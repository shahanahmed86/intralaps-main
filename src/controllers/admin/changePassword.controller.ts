import { compareSync, hashSync, prisma } from '../../library';
import { Controller } from '../../types/wrapper.types';
import { ConflictError, NotAuthorized } from '../../utils/errors.utils';
import { convertUnknownIntoError, joiValidator } from '../../utils/logics.utils';
import { changePasswordSchema } from '../../validation';

type Args = {
	oldPassword: string;
	password: string;
};

export const changePassword: Controller<null, Args, string> = async (root, args, { req }) => {
	if (!req.opsUserId) throw new NotAuthorized();

	try {
		await joiValidator(changePasswordSchema, args);
	} catch (e) {
		const error = convertUnknownIntoError(e);
		throw new ConflictError(error.message);
	}

	const admin = await prisma.opsUser.findFirst({ where: { id: req.opsUserId } });
	if (!admin) throw new NotAuthorized();

	const isMatch = compareSync(args.oldPassword, admin.password);
	if (!isMatch) throw new ConflictError('old password mismatched');

	const password = hashSync(args.password);
	await prisma.opsUser.update({ where: { id: admin.id }, data: { password } });

	return 'password changed successfully';
};
