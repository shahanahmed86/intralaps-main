export const SHOULD_OMIT_PROPS = ['password', 'isDeleted', 'deletedAt', 'deletedBy', 'deletedById'];

export const MORGAN_TOKENS: string = [
	':host',
	':date[iso]',
	':method',
	':remote-addr',
	':status',
	':url',
	':user-agent',
	':response-time',
	':error',
].join(' ');

export const GENDER_OPTIONS: string[] = ['MALE', 'FEMALE', 'PREFER_NOT_TO_SAY'];

export const LOGIN_TYPES: string[] = ['LOCAL', 'FACEBOOK', 'GOOGLE'];
