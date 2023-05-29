Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B619C714432
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjE2GUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjE2GUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:20:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E65B2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685341241; x=1716877241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mY2erTeWwo8KLcT3K3FPJaJOXqKJMG+PRsSCo6Oc9A8=;
  b=lb4B+B3t0Wam1xF+IdwV1LWH6jRzf4xcmjNlDqfnl5oVUITMhxbDA3lM
   NcFjAQvX0zwHG0E49h2x8WCL2Z2zJ61/O4hlalkG41OuIscxa7ZYUEw5x
   xuFEADRX9OF1ocHEjrFydFpv1Em4h2QZtbEok2ThPRIEoqUXTZ2DGnC2j
   lRj5D2FD2h3SLHRC0s7CbwZqgYWiq/RF6p0M/F5gaHFqWh+nVNZTMKlJA
   DPzXwVWKkxcPZqCm25OmZHkWBzUGF29xNa/4xc0DFYur8DEOkf6hPzVc0
   kM8BUfe+tTfiBA8eXQFjN5zjy+P2Xf8w+k417lHll6feW7n6QmaWbvQMU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="344130748"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="344130748"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="952613634"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="952613634"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 May 2023 23:20:38 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3WFC-000Kug-0G;
        Mon, 29 May 2023 06:20:38 +0000
Date:   Mon, 29 May 2023 14:20:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sheng Yong <shengyong@oppo.com>
Subject: Re: [PATCH] f2fs: add f2fs_ioc_[get|set]_extra_attr
Message-ID: <202305291408.kdy2Itan-lkp@intel.com>
References: <20230529013502.2230810-1-shengyong@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529013502.2230810-1-shengyong@oppo.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jaegeuk-f2fs/dev-test]
[also build test WARNING on jaegeuk-f2fs/dev next-20230525]
[cannot apply to linus/master v6.4-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sheng-Yong/f2fs-add-f2fs_ioc_-get-set-_extra_attr/20230529-093611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20230529013502.2230810-1-shengyong%40oppo.com
patch subject: [PATCH] f2fs: add f2fs_ioc_[get|set]_extra_attr
config: arc-buildonly-randconfig-r004-20230529 (https://download.01.org/0day-ci/archive/20230529/202305291408.kdy2Itan-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/519a8b3bbd4d743ae67c32dfef61e8bfa0951cc5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sheng-Yong/f2fs-add-f2fs_ioc_-get-set-_extra_attr/20230529-093611
        git checkout 519a8b3bbd4d743ae67c32dfef61e8bfa0951cc5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305291408.kdy2Itan-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/f2fs/file.c: In function 'f2fs_ioc_get_extra_attr':
>> fs/f2fs/file.c:4312:44: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    4312 |                                            (void __user *)attr.attr))
         |                                            ^
   fs/f2fs/file.c:4316:48: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    4316 |                                                (void __user *)attr.attr))
         |                                                ^


vim +4312 fs/f2fs/file.c

  4262	
  4263	static int f2fs_ioc_get_extra_attr(struct file *filp, unsigned long arg)
  4264	{
  4265		struct inode *inode = file_inode(filp);
  4266		struct f2fs_inode_info *fi = F2FS_I(inode);
  4267		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
  4268		struct f2fs_extra_attr attr;
  4269		u32 chksum;
  4270		int ret = 0;
  4271	
  4272		if (!f2fs_has_extra_attr(inode))
  4273			return -EOPNOTSUPP;
  4274	
  4275		if (copy_from_user(&attr, (void __user *)arg, sizeof(attr)))
  4276			return -EFAULT;
  4277	
  4278		if (attr.field >= F2FS_EXTRA_ATTR_MAX)
  4279			return -EINVAL;
  4280	
  4281		if (!extra_attr_fits_in_inode(inode, attr.field))
  4282			return -EOPNOTSUPP;
  4283	
  4284		switch (attr.field) {
  4285		case F2FS_EXTRA_ATTR_TOTAL_SIZE:
  4286			attr.attr = F2FS_TOTAL_EXTRA_ATTR_SIZE;
  4287			break;
  4288		case F2FS_EXTRA_ATTR_ISIZE:
  4289			attr.attr = fi->i_extra_isize;
  4290			break;
  4291		case F2FS_EXTRA_ATTR_INLINE_XATTR_SIZE:
  4292			if (!f2fs_has_inline_xattr(inode))
  4293				return -EOPNOTSUPP;
  4294			attr.attr = get_inline_xattr_addrs(inode);
  4295			break;
  4296		case F2FS_EXTRA_ATTR_PROJID:
  4297			if (!f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
  4298				return -EOPNOTSUPP;
  4299			attr.attr = from_kprojid(&init_user_ns, fi->i_projid);
  4300			break;
  4301		case F2FS_EXTRA_ATTR_INODE_CHKSUM:
  4302			ret = f2fs_inode_chksum_get(sbi, inode, &chksum);
  4303			if (ret)
  4304				return ret;
  4305			attr.attr = chksum;
  4306			break;
  4307		case F2FS_EXTRA_ATTR_CRTIME:
  4308			if (!f2fs_sb_has_inode_crtime(sbi))
  4309				return -EOPNOTSUPP;
  4310			if (attr.attr_size == sizeof(struct timespec64)) {
  4311				if (put_timespec64(&fi->i_crtime,
> 4312						   (void __user *)attr.attr))
  4313					return -EFAULT;
  4314			} else if (attr.attr_size == sizeof(struct old_timespec32)) {
  4315				if (put_old_timespec32(&fi->i_crtime,
  4316						       (void __user *)attr.attr))
  4317					return -EFAULT;
  4318			} else {
  4319				return -EINVAL;
  4320			}
  4321			break;
  4322		case F2FS_EXTRA_ATTR_COMPR_BLOCKS:
  4323			ret = f2fs_get_compress_blocks(filp, attr.attr_size);
  4324			attr.attr = ret;
  4325			break;
  4326		case F2FS_EXTRA_ATTR_COMPR_OPTION:
  4327			ret = f2fs_get_compress_option_v2(filp, attr.attr,
  4328							  &attr.attr_size);
  4329			break;
  4330		default:
  4331			return -EINVAL;
  4332		}
  4333	
  4334		if (ret < 0)
  4335			return ret;
  4336	
  4337		if (copy_to_user((void __user *)arg, &attr, sizeof(attr)))
  4338			return -EFAULT;
  4339	
  4340		return 0;
  4341	}
  4342	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
