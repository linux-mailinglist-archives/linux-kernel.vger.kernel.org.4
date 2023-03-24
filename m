Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AD86C778D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjCXGAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXGAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:00:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0410D2737
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679637603; x=1711173603;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GFnt8wQIfhP9vRVFHL/JQd3DrMiRkuwhQ4dxicCa0xg=;
  b=bvguCogLjGXBe2M11ACvyHDLRQnX8mvHqOxzC5Yh4xZeNvb1ZHQqpsJQ
   EqWcFAHXQHY/Cunpl+uZ9cxp404yZKGUF6eo3Jrr69Y1/vNnd2Oz+QlM0
   xYeNjg6wJfXKFnCAAD5mFch+jw+luwc/8+/3Hd+Dj7Kgd4j01V9VNAAzq
   taROCBbK1yLxjg3UVzx0UdKarkhd9RGVyfTQ5nozWABC5NP5h/8FKXBKG
   0NOwtySGwVW3f4y/NEpS/ZpHlmZz3u3KO0oGoP+/uJt0asOj8XtcI62Lp
   i9du8QzUtRurUjKzhOmxP6rTpxZigiaSRTNrJiG6GSWt8opnRiOmQOlrV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402285024"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="402285024"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 23:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="826119291"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="826119291"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2023 23:00:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfaT3-000F1w-0n;
        Fri, 24 Mar 2023 06:00:01 +0000
Date:   Fri, 24 Mar 2023 13:59:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kismet: WARNING: unmet direct dependencies detected for
 RPCSEC_GSS_KRB5 when selected by NFS_V4
Message-ID: <202303241307.f6NeW9gZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1e760fa3596e8c7f08412712c168288b79670d78
commit: e57d06527738798039b8e91af762fbd33881b34d NFS & NFSD: Update GSS dependencies
date:   2 weeks ago
config: csky-kismet-CONFIG_RPCSEC_GSS_KRB5-CONFIG_NFS_V4-0-0 (https://download.01.org/0day-ci/archive/20230324/202303241307.f6NeW9gZ-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e57d06527738798039b8e91af762fbd33881b34d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e57d06527738798039b8e91af762fbd33881b34d
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_RPCSEC_GSS_KRB5 --selectors CONFIG_NFS_V4 -a=csky
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=csky olddefconfig

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303241307.f6NeW9gZ-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for RPCSEC_GSS_KRB5 when selected by NFS_V4
   .config:4761:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   
   WARNING: unmet direct dependencies detected for RPCSEC_GSS_KRB5
     Depends on [n]: NETWORK_FILESYSTEMS [=y] && SUNRPC [=y] && CRYPTO [=n]
     Selected by [y]:
     - NFS_V4 [=y] && NETWORK_FILESYSTEMS [=y] && NFS_FS [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
