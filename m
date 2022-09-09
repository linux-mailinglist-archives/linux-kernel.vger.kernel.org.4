Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C212C5B3C72
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiIIPzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiIIPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:55:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22FC5D13D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662738900; x=1694274900;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ej34HINTXAFmGJ3MuZfYuP26ktwJLXNaGaR7XiNX76g=;
  b=cXd02jNFg5A2sZUNxxVLSzwGe4MfMJmuXUIwmao6FNwme6Mcli5T76xM
   8GKC3J+F1g9M8KE+0MHKfO4ZfQY+ApBCTHVH2n5fmv7D8sJyr3VMStidm
   5HQ/PdZgisxHMzdO3KTKoolm7D39Y0KvxjYRIJn35SBZlzzc2Oxg0IV/L
   LgHinJFiN3Dp3uw4YadE936MvVwlnTscExSNHWjdvflBNH9+XZb8ZWqPY
   uEvr9BJULC96gkPZTI6mSfD/XSLJQVXKTtRznpTltVBBSMT6G4bAuXG/o
   Fei3WW7a7n+rTGQnhaPoYhMmGXrT675HMeCj4msD3PGDn/SuKviF7XV9a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="297503244"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="297503244"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 08:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="704443820"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Sep 2022 08:54:37 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWgKy-0001OF-2v;
        Fri, 09 Sep 2022 15:54:36 +0000
Date:   Fri, 9 Sep 2022 23:53:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [vfs-idmapping:fs.posix_acl.vfsuid 32/37] fs/xattr.c:585: undefined
 reference to `posix_acl_from_xattr'
Message-ID: <202209092359.kTlM7Ca6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git fs.posix_acl.vfsuid
head:   d37e11d9b40fc35810217121aa3205b7975fd4c6
commit: fcb72ace104f57d790022ca5895c44a9379dc0a7 [32/37] xattr: use POSIX ACL api
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220909/202209092359.kTlM7Ca6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/commit/?id=fcb72ace104f57d790022ca5895c44a9379dc0a7
        git remote add vfs-idmapping https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
        git fetch --no-tags vfs-idmapping fs.posix_acl.vfsuid
        git checkout fcb72ace104f57d790022ca5895c44a9379dc0a7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: arch/x86/um/checksum_32.o: missing .note.GNU-stack section implies executable stack
   /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
   /usr/bin/ld: fs/xattr.o: in function `setxattr_convert':
>> fs/xattr.c:585: undefined reference to `posix_acl_from_xattr'
   collect2: error: ld returned 1 exit status


vim +585 fs/xattr.c

   575	
   576	static int setxattr_convert(struct user_namespace *mnt_userns, struct dentry *d,
   577				    struct xattr_ctx *ctx)
   578	{
   579		struct posix_acl *acl;
   580	
   581		if (!ctx->size || !is_posix_acl_xattr(ctx->kname->name))
   582			return 0;
   583	
   584		/* TODO: Don't use GFP_NOFS to allocate POSIX ACLs. */
 > 585		acl = posix_acl_from_xattr(current_user_ns(), ctx->kvalue, ctx->size);
   586		if (IS_ERR(acl))
   587			return PTR_ERR(acl);
   588	
   589		ctx->acl = acl;
   590		return 0;
   591	}
   592	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
