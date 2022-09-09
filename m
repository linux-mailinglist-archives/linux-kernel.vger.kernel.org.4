Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF8D5B40D0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiIIUmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIIUmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:42:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0DE12D181
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662756129; x=1694292129;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VjPnROU7ENiGPuwYDR4O7DVUE4Xqvv//S1TeoNDHOHk=;
  b=FKr4FvfoPFKMil+ioMkUupzI+CRd92JxZL2LnUzNvXwgPCs6mZ3WMnOI
   EspZN5wKt/DqndN01ZfpfrC28TLcxkxB19ONSlmfN9/hF5yoyAfEAi5x3
   ouvI1raSUTc3iE50GxfxB25JFKvHfTR5y/lk5QNbG3UMM7JVdb1oA2zed
   aii8DQjWzNwQf29hrFCZqw5nPX2WANn8matUklug7QgBuCGoLaVRKkzqj
   hWEkbrUNFRLD8qHy8B4zrBzlDTbyw2pMsRjfcrVr1qFgI0b/VSCaE+m35
   FefOppxY4X/60pthO+Fm6V3Bksv+7RNl6HZd7QBoXgZS8f7ECqieSTmOh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="277958354"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="277958354"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="741174843"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Sep 2022 13:42:07 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWkpC-0001iZ-2M;
        Fri, 09 Sep 2022 20:42:06 +0000
Date:   Sat, 10 Sep 2022 04:41:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [vfs-idmapping:fs.posix_acl.vfsuid 24/37] fs/posix_acl.c:111:19:
 warning: no previous prototype for function '__get_acl'
Message-ID: <202209100432.pAFEMvWb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git fs.posix_acl.vfsuid
head:   d37e11d9b40fc35810217121aa3205b7975fd4c6
commit: 95fef95c76885cb97f319e5a5060964eb9e96126 [24/37] acl: add vfs_get_acl()
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220910/202209100432.pAFEMvWb-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/commit/?id=95fef95c76885cb97f319e5a5060964eb9e96126
        git remote add vfs-idmapping https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
        git fetch --no-tags vfs-idmapping fs.posix_acl.vfsuid
        git checkout 95fef95c76885cb97f319e5a5060964eb9e96126
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/posix_acl.c:111:19: warning: no previous prototype for function '__get_acl' [-Wmissing-prototypes]
   struct posix_acl *__get_acl(struct user_namespace *mnt_userns,
                     ^
   fs/posix_acl.c:111:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct posix_acl *__get_acl(struct user_namespace *mnt_userns,
   ^
   static 
   1 warning generated.


vim +/__get_acl +111 fs/posix_acl.c

   110	
 > 111	struct posix_acl *__get_acl(struct user_namespace *mnt_userns,
   112				    struct dentry *dentry, struct inode *inode,
   113				    int type)
   114	{
   115		void *sentinel;
   116		struct posix_acl **p;
   117		struct posix_acl *acl;
   118	
   119		/*
   120		 * The sentinel is used to detect when another operation like
   121		 * set_cached_acl() or forget_cached_acl() races with get_acl().
   122		 * It is guaranteed that is_uncached_acl(sentinel) is true.
   123		 */
   124	
   125		acl = get_cached_acl(inode, type);
   126		if (!is_uncached_acl(acl))
   127			return acl;
   128	
   129		if (!IS_POSIXACL(inode))
   130			return NULL;
   131	
   132		sentinel = uncached_acl_sentinel(current);
   133		p = acl_by_type(inode, type);
   134	
   135		/*
   136		 * If the ACL isn't being read yet, set our sentinel.  Otherwise, the
   137		 * current value of the ACL will not be ACL_NOT_CACHED and so our own
   138		 * sentinel will not be set; another task will update the cache.  We
   139		 * could wait for that other task to complete its job, but it's easier
   140		 * to just call ->get_acl to fetch the ACL ourself.  (This is going to
   141		 * be an unlikely race.)
   142		 */
   143		cmpxchg(p, ACL_NOT_CACHED, sentinel);
   144	
   145		/*
   146		 * Normally, the ACL returned by ->get_{dentry_}acl will be cached.
   147		 * A filesystem can prevent that by calling
   148		 * forget_cached_acl(inode, type) in ->get_{dentry_}acl.
   149		 *
   150		 * If the filesystem doesn't have a get_{dentry_}acl() function at all,
   151		 * we'll just create the negative cache entry.
   152		 */
   153		if (dentry) {
   154			if (!inode->i_op->get_dentry_acl) {
   155				set_cached_acl(inode, type, NULL);
   156				return NULL;
   157			}
   158			acl = inode->i_op->get_dentry_acl(mnt_userns, dentry, type);
   159		} else {
   160			if (!inode->i_op->get_acl) {
   161				set_cached_acl(inode, type, NULL);
   162				return NULL;
   163			}
   164			acl = inode->i_op->get_acl(inode, type, false);
   165		}
   166	
   167		if (IS_ERR(acl)) {
   168			/*
   169			 * Remove our sentinel so that we don't block future attempts
   170			 * to cache the ACL.
   171			 */
   172			cmpxchg(p, sentinel, ACL_NOT_CACHED);
   173			return acl;
   174		}
   175	
   176		/*
   177		 * Cache the result, but only if our sentinel is still in place.
   178		 */
   179		posix_acl_dup(acl);
   180		if (unlikely(cmpxchg(p, sentinel, acl) != sentinel))
   181			posix_acl_release(acl);
   182		return acl;
   183	}
   184	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
