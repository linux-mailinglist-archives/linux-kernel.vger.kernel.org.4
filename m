Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255F45B51E3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 01:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIKXXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 19:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIKXXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 19:23:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C6324F24
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 16:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662938595; x=1694474595;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e/19Vje21OgZ+v69V1ILvN9DrlGfoQeRbzYvJM7koDE=;
  b=Q8Ep0Meak9DIvEpdsDuCcj2K1mtkGu0LCLVJ6A/AuyZXIlsnSZvNK8kP
   d6KH59DEirKNL2Y9uBnc3EL2+fBVTkB68iaV9PW/GjH8apm3iYhts9lmA
   VSxzQF7KTGMQZOqBUYdw3ixDbWVd+FSERgOTMUFvzfGFknQWRGXsI9tUQ
   5QTHyXL5PMTe5F4pTCV4Vv13xjga4tJ506cRDL2KHawkZW3KnWrmOMXhn
   iP1mGMnh0mJANBCUwUrnu7DLF05/tj4OvgqnUkJ2zKy3b2tD2DBUTJi7k
   ALXrO7nE/bBMtcz5PararUrl3CRDZDh6lGXqRcSNaf52uVuiRvGdmxM/9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="323986271"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="323986271"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 16:23:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="615868090"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Sep 2022 16:23:14 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXWID-0001xZ-1E;
        Sun, 11 Sep 2022 23:23:13 +0000
Date:   Mon, 12 Sep 2022 07:23:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [vfs-idmapping:fs.posix_acl.vfsuid 14/37] fs/cifs/cifssmb.c:3474:48:
 warning: variable 'i' is uninitialized when used here
Message-ID: <202209120746.50JlBseF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git fs.posix_acl.vfsuid
head:   d37e11d9b40fc35810217121aa3205b7975fd4c6
commit: 7839133c91c444aa039e18550338d10b7e30d51e [14/37] cifs: add ->set_acl() method
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220912/202209120746.50JlBseF-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/commit/?id=7839133c91c444aa039e18550338d10b7e30d51e
        git remote add vfs-idmapping https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
        git fetch --no-tags vfs-idmapping fs.posix_acl.vfsuid
        git checkout 7839133c91c444aa039e18550338d10b7e30d51e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/auxdisplay/ drivers/bus/ drivers/gpu/drm/i915/ drivers/net/ethernet/stmicro/stmmac/ drivers/usb/core/ drivers/vdpa/ drivers/vfio/ fs/cifs/ net/mptcp/ net/netfilter/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/cifs/cifssmb.c:3474:48: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
                   convert_ace_to_cifs_ace(&cifs_acl->ace_array[i], pa);
                                                                ^
   fs/cifs/cifssmb.c:3447:7: note: initialize the variable 'i' to silence this warning
           int i;
                ^
                 = 0
   1 warning generated.


vim +/i +3474 fs/cifs/cifssmb.c

  3431	
  3432	/**
  3433	 * ACL_to_cifs_posix - convert ACLs from POSIX ACL to cifs format
  3434	 * @parm_data: ACLs in cifs format to conver to
  3435	 * @acl: ACLs in POSIX ACL format to convert from
  3436	 * @acl_type: the type of POSIX ACLs stored in @acl
  3437	 *
  3438	 * Return: the number cifs ACL entries after conversion
  3439	 */
  3440	static __u16 ACL_to_cifs_posix(char *parm_data, const struct posix_acl *acl,
  3441				       const int acl_type)
  3442	{
  3443		__u16 rc = 0;
  3444		struct cifs_posix_acl *cifs_acl = (struct cifs_posix_acl *)parm_data;
  3445		const struct posix_acl_entry *pa, *pe;
  3446		int count;
  3447		int i;
  3448	
  3449		if ((acl == NULL) || (cifs_acl == NULL))
  3450			return 0;
  3451	
  3452		count = acl->a_count;
  3453		cifs_dbg(FYI, "setting acl with %d entries\n", count);
  3454	
  3455		/*
  3456		 * Note that the uapi POSIX ACL version is verified by the VFS and is
  3457		 * independent of the cifs ACL version. Changing the POSIX ACL version
  3458		 * is a uapi change and if it's changed we will pass down the POSIX ACL
  3459		 * version in struct posix_acl from the VFS. For now there's really
  3460		 * only one that all filesystems know how to deal with.
  3461		 */
  3462		cifs_acl->version = cpu_to_le16(1);
  3463		if (acl_type == ACL_TYPE_ACCESS) {
  3464			cifs_acl->access_entry_count = cpu_to_le16(count);
  3465			cifs_acl->default_entry_count = cpu_to_le16(0xFFFF);
  3466		} else if (acl_type == ACL_TYPE_DEFAULT) {
  3467			cifs_acl->default_entry_count = cpu_to_le16(count);
  3468			cifs_acl->access_entry_count = cpu_to_le16(0xFFFF);
  3469		} else {
  3470			cifs_dbg(FYI, "unknown ACL type %d\n", acl_type);
  3471			return 0;
  3472		}
  3473		FOREACH_ACL_ENTRY(pa, acl, pe) {
> 3474			convert_ace_to_cifs_ace(&cifs_acl->ace_array[i], pa);
  3475		}
  3476		if (rc == 0) {
  3477			rc = (__u16)(count * sizeof(struct cifs_posix_ace));
  3478			rc += sizeof(struct cifs_posix_acl);
  3479			/* BB add check to make sure ACL does not overflow SMB */
  3480		}
  3481		return rc;
  3482	}
  3483	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
