Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6EE7143E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjE2GKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2GKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:10:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116C5AC
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685340641; x=1716876641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ui5e+hpJjEMBH055sDXv2DCRvdcgFaCddqy3h5liFdU=;
  b=GRVv7C5x2iF9GXlrFOALglbOdFGZZggVhPvUXdV5IhPZ3c9ET07EyzpG
   0XdykkH0zsMFv2hQJO+hOhAeOYtvbs1XPt+1JwqeYVEirOexoiO0FDOsa
   kYZXc7eTb3mmKsBL8IJjgNt7K8ZRZK+w36XIsbyaxu6H/NI0mJN1eEhQY
   BuD4DMoElSVg/Ox72zyrDcP01p/CEOTnmM/o5GV86KXK9O0fqdi+8ydc3
   MRi9MKwV+/edCPJ92yuAm34RR+S9dDjH6ITkWPxXtuVZEPsW0T4U8KGL0
   T++JYKsVrru0Nv5CTQmnf1WyPna2DbaJZSeLfhA/OHCgBmD5J1SdqkJu4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="354643338"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="354643338"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:10:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="705937923"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="705937923"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 May 2023 23:10:38 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3W5V-000KuQ-2j;
        Mon, 29 May 2023 06:10:37 +0000
Date:   Mon, 29 May 2023 14:10:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sheng Yong <shengyong@oppo.com>
Subject: Re: [PATCH] f2fs: add f2fs_ioc_[get|set]_extra_attr
Message-ID: <202305291323.u3OTwJgK-lkp@intel.com>
References: <20230529013502.2230810-1-shengyong@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529013502.2230810-1-shengyong@oppo.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on jaegeuk-f2fs/dev next-20230525]
[cannot apply to linus/master v6.4-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sheng-Yong/f2fs-add-f2fs_ioc_-get-set-_extra_attr/20230529-093611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20230529013502.2230810-1-shengyong%40oppo.com
patch subject: [PATCH] f2fs: add f2fs_ioc_[get|set]_extra_attr
config: i386-randconfig-i086-20230529 (https://download.01.org/0day-ci/archive/20230529/202305291323.u3OTwJgK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/519a8b3bbd4d743ae67c32dfef61e8bfa0951cc5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sheng-Yong/f2fs-add-f2fs_ioc_-get-set-_extra_attr/20230529-093611
        git checkout 519a8b3bbd4d743ae67c32dfef61e8bfa0951cc5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305291323.u3OTwJgK-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/f2fs/file.o: in function `f2fs_set_compress_option_v2':
>> fs/f2fs/file.c:3996: undefined reference to `zstd_max_clevel'


vim +3996 fs/f2fs/file.c

  3957	
  3958	static int f2fs_set_compress_option_v2(struct file *filp,
  3959					       unsigned long attr, __u16 *attr_size)
  3960	{
  3961		struct inode *inode = file_inode(filp);
  3962		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
  3963		struct f2fs_comp_option_v2 option;
  3964		int ret = 0;
  3965	
  3966		if (sizeof(option) < *attr_size)
  3967			*attr_size = sizeof(option);
  3968	
  3969		if (!f2fs_sb_has_compression(sbi))
  3970			return -EOPNOTSUPP;
  3971	
  3972		if (!(filp->f_mode & FMODE_WRITE))
  3973			return -EBADF;
  3974	
  3975		if (copy_from_user(&option, (void __user *)attr, *attr_size))
  3976			return -EFAULT;
  3977	
  3978		if (!f2fs_compressed_file(inode) ||
  3979				option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
  3980				option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
  3981				option.algorithm >= COMPRESS_MAX)
  3982			return -EINVAL;
  3983	
  3984		if (*attr_size == sizeof(struct f2fs_comp_option_v2)) {
  3985			if (option.level != 0) {
  3986				switch (option.algorithm) {
  3987				case COMPRESS_LZO:
  3988				case COMPRESS_LZORLE:
  3989					return -EINVAL;
  3990				case COMPRESS_LZ4:
  3991					if (option.level < LZ4HC_MIN_CLEVEL ||
  3992					    option.level > LZ4HC_MAX_CLEVEL)
  3993						return -EINVAL;
  3994					break;
  3995				case COMPRESS_ZSTD:
> 3996					if (option.level > zstd_max_clevel())
  3997						return -EINVAL;
  3998					break;
  3999				}
  4000			}
  4001	
  4002			if (option.flag > BIT(COMPRESS_MAX_FLAG) - 1)
  4003				return -EINVAL;
  4004		}
  4005	
  4006		file_start_write(filp);
  4007		inode_lock(inode);
  4008	
  4009		if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
  4010			ret = -EBUSY;
  4011			goto out;
  4012		}
  4013	
  4014		if (F2FS_HAS_BLOCKS(inode)) {
  4015			ret = -EFBIG;
  4016			goto out;
  4017		}
  4018	
  4019		F2FS_I(inode)->i_compress_algorithm = option.algorithm;
  4020		F2FS_I(inode)->i_log_cluster_size = option.log_cluster_size;
  4021		F2FS_I(inode)->i_cluster_size = BIT(option.log_cluster_size);
  4022		if (*attr_size == sizeof(struct f2fs_comp_option_v2)) {
  4023			F2FS_I(inode)->i_compress_level = option.level;
  4024			F2FS_I(inode)->i_compress_flag = option.flag;
  4025		}
  4026		f2fs_mark_inode_dirty_sync(inode, true);
  4027	
  4028		if (!f2fs_is_compress_backend_ready(inode))
  4029			f2fs_warn(sbi, "compression algorithm is successfully set, "
  4030				"but current kernel doesn't support this algorithm.");
  4031	out:
  4032		inode_unlock(inode);
  4033		file_end_write(filp);
  4034	
  4035		return ret;
  4036	}
  4037	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
