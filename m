Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9689677239
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 21:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjAVUJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 15:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjAVUJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 15:09:44 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E827E12F22;
        Sun, 22 Jan 2023 12:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674418182; x=1705954182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oQLkUGhy72RRBJNTpngo0DRv1LKKtWD9XpE1XZkpgVo=;
  b=MEl4WbmI3DEyyFkYK9zKK93CV6k/BdIqxeMdPXOVDXLkdCczWkfacOAR
   wT5EwicP6mdxXp2w+XF9+z9vxhfmSDC61YyHOHPaxu/ObkskxkeNXXhAU
   laUm+2qzcx5wfByYqmCD4yHHrBmU6+PX+t5abBHm5BKW6poGfi5FZUxjv
   TH4em169owmcnO8rJBcBdtWc8eVnwSZVtmJq3fYajUFWzY5Dcb2KrFzUl
   fBa6aSf3pTQWeeF6D9yEp3iRwU6Vz63pMQHk9LxWlQ2gDSCUTT7hXtyVl
   HauhkPPyhgwmPWLMzeQ37EvmzJ5LgVNUq1KYQUDriblTmuubYDvISvvVU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="388293477"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="388293477"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 12:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="654690130"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="654690130"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Jan 2023 12:09:38 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJgen-0005Dj-2C;
        Sun, 22 Jan 2023 20:09:37 +0000
Date:   Mon, 23 Jan 2023 04:09:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Kaher <akaher@vmware.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH 5/8] eventfs: adding functions to create eventfs files
 and directories
Message-ID: <202301230304.kKbSbIeq-lkp@intel.com>
References: <1674407228-49109-5-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674407228-49109-5-git-send-email-akaher@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ajay,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
patch link:    https://lore.kernel.org/r/1674407228-49109-5-git-send-email-akaher%40vmware.com
patch subject: [PATCH 5/8] eventfs: adding functions to create eventfs files and directories
config: riscv-buildonly-randconfig-r003-20230123 (https://download.01.org/0day-ci/archive/20230123/202301230304.kKbSbIeq-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/950ac8561471b622eac5555b4a7502bcd8c20663
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
        git checkout 950ac8561471b622eac5555b4a7502bcd8c20663
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/tracefs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/tracefs/event_inode.c:48:16: warning: no previous prototype for function 'eventfs_create_file' [-Wmissing-prototypes]
   struct dentry *eventfs_create_file(const char *name, umode_t mode,
                  ^
   fs/tracefs/event_inode.c:48:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct dentry *eventfs_create_file(const char *name, umode_t mode,
   ^
   static 
>> fs/tracefs/event_inode.c:117:16: warning: no previous prototype for function 'eventfs_create_dir' [-Wmissing-prototypes]
   struct dentry *eventfs_create_dir(const char *name, umode_t mode,
                  ^
   fs/tracefs/event_inode.c:117:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct dentry *eventfs_create_dir(const char *name, umode_t mode,
   ^
   static 
   2 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y])
   Selected by [y]:
   - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y])


vim +/eventfs_create_file +48 fs/tracefs/event_inode.c

    23	
    24	/**
    25	 * eventfs_create_file - create a file in the tracefs filesystem
    26	 * @name: a pointer to a string containing the name of the file to create.
    27	 * @mode: the permission that the file should have.
    28	 * @parent: a pointer to the parent dentry for this file.  This should be a
    29	 *          directory dentry if set.  If this parameter is NULL, then the
    30	 *          file will be created in the root of the tracefs filesystem.
    31	 * @data: a pointer to something that the caller will want to get to later
    32	 *        on.  The inode.i_private pointer will point to this value on
    33	 *        the open() call.
    34	 * @fops: a pointer to a struct file_operations that should be used for
    35	 *        this file.
    36	 *
    37	 * This is the basic "create a file" function for tracefs.  It allows for a
    38	 * wide range of flexibility in creating a file.
    39	 *
    40	 * This function will return a pointer to a dentry if it succeeds.  This
    41	 * pointer must be passed to the tracefs_remove() function when the file is
    42	 * to be removed (no automatic cleanup happens if your module is unloaded,
    43	 * you are responsible here.)  If an error occurs, %NULL will be returned.
    44	 *
    45	 * If tracefs is not enabled in the kernel, the value -%ENODEV will be
    46	 * returned.
    47	 */
  > 48	struct dentry *eventfs_create_file(const char *name, umode_t mode,
    49					   struct dentry *parent, void *data,
    50					   const struct file_operations *fop,
    51					   bool anon)
    52	{
    53		struct tracefs_inode *ti;
    54		struct dentry *dentry;
    55		struct inode *inode;
    56	
    57		if (security_locked_down(LOCKDOWN_TRACEFS))
    58			return NULL;
    59	
    60		if (!(mode & S_IFMT))
    61			mode |= S_IFREG;
    62	
    63		if (WARN_ON_ONCE(!S_ISREG(mode)))
    64			return NULL;
    65	
    66		dentry = eventfs_start_creating(name, parent);
    67	
    68		if (IS_ERR(dentry))
    69			return dentry;
    70	
    71		inode = tracefs_get_inode(dentry->d_sb);
    72		if (unlikely(!inode))
    73			return eventfs_failed_creating(dentry);
    74	
    75		inode->i_mode = mode;
    76		inode->i_fop = fop;
    77		inode->i_private = data;
    78	
    79		ti = get_tracefs(inode);
    80		ti->flags |= TRACEFS_EVENT_INODE;
    81	
    82		if (anon)
    83			d_instantiate_anon(dentry, inode);
    84		else
    85			d_instantiate(dentry, inode);
    86	
    87		fsnotify_create(dentry->d_parent->d_inode, dentry);
    88		return eventfs_end_creating(dentry);
    89	}
    90	
    91	/**
    92	 * eventfs_create_dir - create a dir in the tracefs filesystem
    93	 * @name: a pointer to a string containing the name of the file to create.
    94	 * @mode: the permission that the file should have.
    95	 * @parent: a pointer to the parent dentry for this file.  This should be a
    96	 *          directory dentry if set.  If this parameter is NULL, then the
    97	 *          file will be created in the root of the tracefs filesystem.
    98	 * @data: a pointer to something that the caller will want to get to later
    99	 *        on.  The inode.i_private pointer will point to this value on
   100	 *        the open() call.
   101	 * @fop: a pointer to a struct file_operations that should be used for
   102	 *        this dir.
   103	 * @iop: a pointer to a struct inode_operations that should be used for
   104	 *        this dir.
   105	 *
   106	 * This is the basic "create a dir" function for eventfs.  It allows for a
   107	 * wide range of flexibility in creating a dir.
   108	 *
   109	 * This function will return a pointer to a dentry if it succeeds.  This
   110	 * pointer must be passed to the tracefs_remove() function when the file is
   111	 * to be removed (no automatic cleanup happens if your module is unloaded,
   112	 * you are responsible here.)  If an error occurs, %NULL will be returned.
   113	 *
   114	 * If tracefs is not enabled in the kernel, the value -%ENODEV will be
   115	 * returned.
   116	 */
 > 117	struct dentry *eventfs_create_dir(const char *name, umode_t mode,
   118					  struct dentry *parent, void *data,
   119					  const struct file_operations *fop,
   120					  const struct inode_operations *iop,
   121					  bool anon)
   122	{
   123		struct tracefs_inode *ti;
   124		struct dentry *dentry;
   125		struct inode *inode;
   126	
   127		if (security_locked_down(LOCKDOWN_TRACEFS))
   128			return NULL;
   129	
   130		WARN_ON(!S_ISDIR(mode));
   131	
   132		dentry = eventfs_start_creating(name, parent);
   133	
   134		if (IS_ERR(dentry))
   135			return dentry;
   136	
   137		inode = tracefs_get_inode(dentry->d_sb);
   138		if (unlikely(!inode))
   139			return eventfs_failed_creating(dentry);
   140	
   141		inode->i_mode = mode;
   142		inode->i_op = iop;
   143		inode->i_fop = fop;
   144		inode->i_private = data;
   145	
   146		ti = get_tracefs(inode);
   147		ti->flags |= TRACEFS_EVENT_INODE;
   148	
   149		inc_nlink(inode);
   150		if (anon)
   151			d_instantiate_anon(dentry, inode);
   152		else
   153			d_instantiate(dentry, inode);
   154		inc_nlink(dentry->d_parent->d_inode);
   155		fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
   156		return eventfs_end_creating(dentry);
   157	}
   158	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
