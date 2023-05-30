Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E56A715B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjE3KPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjE3KP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:15:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0E5F7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685441723; x=1716977723;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KVTNOGmvAmJ+DiD643wIHXPZZWInWV0fIFdQmNkVpcA=;
  b=jJZHzVkM/LHBChcxSLViMXAWWViPxEf6mdvXvUCjzjZExMbXQilSoyK8
   wkZf/0RBnZ6JicglSG82VMVx+WLI6GJSV3bsqj0A03jqg8lMKHu6kdiKt
   5OOSa7cNjSRp/ljJRFAq3jsJKZ1zRVYp9QMNruHPKIn6pYYpCXB0cnBsx
   dIy9CcoKY7kLbkWt2WJXDPeDebNUzs08zUHfrB1y3+irQ7whm8jihz8BQ
   +tJQQQQXLus3jhHT+Xr+2nM2WLN4xDW3z4V2pUsoX3hbwZzmlgFAeXwhi
   pYgV6UzcYWnp4xBhguDuvk4kfebmv2GyATOzrlUjW8bKxWA57qoRm9wPC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="335221886"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="335221886"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 03:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="830687791"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="830687791"
Received: from lkp-server01.sh.intel.com (HELO fd90924b3b99) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2023 03:15:20 -0700
Received: from kbuild by fd90924b3b99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3wNr-0000Go-2O;
        Tue, 30 May 2023 10:15:19 +0000
Date:   Tue, 30 May 2023 18:15:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: kismet: WARNING: unmet direct dependencies detected for CRYPTO_AEAD2
 when selected by SEV_GUEST
Message-ID: <202305301832.kW1SCYZO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8b817fded42d8fe3a0eb47b1149d907851a3c942
commit: fce96cf0443083e37455eff8f78fd240c621dae3 virt: Add SEV-SNP guest driver
date:   1 year, 2 months ago
config: x86_64-kismet-CONFIG_CRYPTO_AEAD2-CONFIG_SEV_GUEST-0-0 (https://download.01.org/0day-ci/archive/20230530/202305301832.kW1SCYZO-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fce96cf0443083e37455eff8f78fd240c621dae3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fce96cf0443083e37455eff8f78fd240c621dae3
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_CRYPTO_AEAD2 --selectors CONFIG_SEV_GUEST -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305301832.kW1SCYZO-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for CRYPTO_AEAD2 when selected by SEV_GUEST
   .config:5061:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   
   WARNING: unmet direct dependencies detected for CRYPTO_GCM
     Depends on [n]: CRYPTO [=n]
     Selected by [y]:
     - SEV_GUEST [=y] && VIRT_DRIVERS [=y] && AMD_MEM_ENCRYPT [=y]
   
   WARNING: unmet direct dependencies detected for CRYPTO_AEAD2
     Depends on [n]: CRYPTO [=n]
     Selected by [y]:
     - SEV_GUEST [=y] && VIRT_DRIVERS [=y] && AMD_MEM_ENCRYPT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
