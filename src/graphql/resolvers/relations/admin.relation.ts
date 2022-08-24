import { Prisma, prisma } from '../../../library';
import { Controller } from '../../../types/wrapper.types';
import { NotFound } from '../../../utils/errors.utils';
import { includeDeleteParams } from '../../../utils/logics.utils';

type Controllers = {
	deletedUsers: Controller<Prisma.OpsUserWhereInput, object, Prisma.UserWhereInput[]>;
};

const Admin: Controllers = {
	deletedUsers: async (root) => {
		try {
			const id = root.id;
			if (!id) throw new NotFound('Please provide ID to get deletedUsers');

			return await prisma.opsUser
				.findFirstOrThrow({ where: { id } })
				.deletedUsers({ where: includeDeleteParams({}) });
		} catch (error) {
			console.log('admin.deletedUsers catch error....', error);
			return [];
		}
	},
};

export default Admin;
