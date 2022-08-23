import { Router } from 'express';

import adminRoutes from './admin';
import commonRoutes from './common';

const router = Router();

// common
router.use('/common', commonRoutes);

// dedicated
router.use('/admin', adminRoutes);

export default router;
