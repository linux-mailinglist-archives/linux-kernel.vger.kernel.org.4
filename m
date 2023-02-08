Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C7568EE8B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBHMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBHMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:08:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25FC271C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675858094; x=1707394094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kE+J52cgIQ6iIZdVoYoaSbu2S2jw29ayH0TUmUhV7fk=;
  b=XBcbPUUvghccoS9aURNuimEYCdu972yflkASDBfDebiNyc7rQXp/8Mk3
   nRCpmTonPCBxNA55DyKMaD8QXynp0hWWw+5AcNXKLoBCNpDYEekNENuvn
   sACIv8wF8j1qbaK0W3VZ8rmOgcXZfVrP83b8ttJbXzLvJbM7ZbDzcAznw
   HYcwCDbKZi4SOlQCx5XUxPVbpHG88WepThDWGh3gBpSYgqIxHYSP1BvCm
   PGRtMdS7lAutr8K95IQ/gR/VzYAaWCVbAjO/NvVJYgYRMdT26VlHNfsuH
   X7xZUVuYvmKi7upHygNWSAwhAN5V9s+TMjpu6fQZsaQPrawMuSzsJe/Kx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="310132864"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="310132864"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 04:07:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="841158725"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="841158725"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2023 04:07:03 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPjE6-0004Qg-2m;
        Wed, 08 Feb 2023 12:07:02 +0000
Date:   Wed, 8 Feb 2023 20:06:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: fs/nfs/fscache.c:58:51: sparse: sparse: incorrect type in argument 3
 (different base types)
Message-ID: <202302082046.gSEcLsV7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0983f6bf2bfc0789b51ddf7315f644ff4da50acb
commit: a6b5a28eb56c3f4988f7ff5290b954ba296e309a nfs: Convert to new fscache volume/cookie API
date:   1 year, 1 month ago
config: arm64-randconfig-s043-20230208 (https://download.01.org/0day-ci/archive/20230208/202302082046.gSEcLsV7-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a6b5a28eb56c3f4988f7ff5290b954ba296e309a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a6b5a28eb56c3f4988f7ff5290b954ba296e309a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/infiniband/hw/hns/ drivers/remoteproc/ fs/nfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> fs/nfs/fscache.c:58:51: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be16 const [usertype] sin_port @@
   fs/nfs/fscache.c:58:51: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:58:51: sparse:     got restricted __be16 const [usertype] sin_port
>> fs/nfs/fscache.c:59:61: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be32 const [usertype] s_addr @@
   fs/nfs/fscache.c:59:61: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:59:61: sparse:     got restricted __be32 const [usertype] s_addr
>> fs/nfs/fscache.c:64:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be16 const [usertype] sin6_port @@
   fs/nfs/fscache.c:64:52: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:64:52: sparse:     got restricted __be16 const [usertype] sin6_port
>> fs/nfs/fscache.c:65:73: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be32 const @@
   fs/nfs/fscache.c:65:73: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:65:73: sparse:     got restricted __be32 const
   fs/nfs/fscache.c:66:73: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be32 const @@
   fs/nfs/fscache.c:66:73: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:66:73: sparse:     got restricted __be32 const
   fs/nfs/fscache.c:67:73: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be32 const @@
   fs/nfs/fscache.c:67:73: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:67:73: sparse:     got restricted __be32 const
   fs/nfs/fscache.c:68:73: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be32 const @@
   fs/nfs/fscache.c:68:73: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:68:73: sparse:     got restricted __be32 const

vim +58 fs/nfs/fscache.c

    37	
    38	/*
    39	 * Get the per-client index cookie for an NFS client if the appropriate mount
    40	 * flag was set
    41	 * - We always try and get an index cookie for the client, but get filehandle
    42	 *   cookies on a per-superblock basis, depending on the mount flags
    43	 */
    44	static bool nfs_fscache_get_client_key(struct nfs_client *clp,
    45					       char *key, int *_len)
    46	{
    47		const struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *) &clp->cl_addr;
    48		const struct sockaddr_in *sin = (struct sockaddr_in *) &clp->cl_addr;
    49	
    50		*_len += snprintf(key + *_len, NFS_MAX_KEY_LEN - *_len,
    51				  ",%u.%u,%x",
    52				  clp->rpc_ops->version,
    53				  clp->cl_minorversion,
    54				  clp->cl_addr.ss_family);
    55	
    56		switch (clp->cl_addr.ss_family) {
    57		case AF_INET:
  > 58			if (!nfs_append_int(key, _len, sin->sin_port) ||
  > 59			    !nfs_append_int(key, _len, sin->sin_addr.s_addr))
    60				return false;
    61			return true;
    62	
    63		case AF_INET6:
  > 64			if (!nfs_append_int(key, _len, sin6->sin6_port) ||
  > 65			    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[0]) ||
    66			    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[1]) ||
    67			    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[2]) ||
    68			    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[3]))
    69				return false;
    70			return true;
    71	
    72		default:
    73			printk(KERN_WARNING "NFS: Unknown network family '%d'\n",
    74			       clp->cl_addr.ss_family);
    75			return false;
    76		}
    77	}
    78	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
