Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223F0690209
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBIIVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBIIVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:21:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165DD367E4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675930894; x=1707466894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qSNEuSjLMefwCLldzADS4ERa3/+8x0SMhJqpUi9xH9g=;
  b=b/9aSPQR7GZOmxK36AauDLaRm3i/MXMeUeqA+3bMRfwMHwLglrh8+9ZM
   ETNZOc5JAlDDRIq0moDqDg+O+tPDVXHQfqlReO+9pZeAwG9s/F+bvxsPj
   /IqrfK0YQcWeYcCrN+55gBPbcxJ64iaQs52rshRlUUtGi2HR40uWCISLx
   HhwQO0/E6MB7izo+fSZDa07idrZR+Cei0w6FAQ9mo5Pr/iEvEFcvH0HQE
   OcdDEAz9AEI5n+knjs1olW/kjV1OlfLbbU3QBpn71ey1GKzrK6Hz63RYu
   YSPGcAdnoUjIwUf3fpxk7zMrRj41goF55aR12fUcAb94nM46NxuJvmoKn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="416272087"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="416272087"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 00:21:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="996452829"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="996452829"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Feb 2023 00:21:32 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQ2BP-0004w6-1i;
        Thu, 09 Feb 2023 08:21:31 +0000
Date:   Thu, 9 Feb 2023 16:21:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: fs/nfs/fscache.c:58:51: sparse: sparse: incorrect type in argument 3
 (different base types)
Message-ID: <202302091643.bKacRPzV-lkp@intel.com>
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
config: arm64-randconfig-s043-20230208 (https://download.01.org/0day-ci/archive/20230209/202302091643.bKacRPzV-lkp@intel.com/config)
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
| Link: https://lore.kernel.org/oe-kbuild-all/202302091643.bKacRPzV-lkp@intel.com

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
