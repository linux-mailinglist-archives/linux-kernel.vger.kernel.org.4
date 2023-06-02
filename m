Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB37C71FABF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjFBHLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjFBHL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:11:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078FC1A1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685689880; x=1717225880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lPXxRm8hcSU2M/BYATMh1fohydYKFbkOb+HkZZPE9Yk=;
  b=dknlJNJjPqlnF/ouHjjrT9GtKHN6Rh45dsx2Evt279R2WzFVmctWTh4D
   QaZfMNuCfeE8vy1O+mi0w9P6tnGMyOrrMQP4YZk5/mVb/kUx0jFkTxWJj
   yhpM8PYPSgzOsngu9Y5AtUWN2e8llbgijCQYeFBKRRTFuGefH42fP6AQY
   COmFI138HwjdrCtAECQBq1SQCHXdAI51JPDWxtm0nMaGAbcPSregcZ5sc
   V9A9Hgh46FSOkxvcAPyjRG9dfV/oGAsHjJMaD+brhaSz4zpqGXeZK9cRQ
   HW9pXz4yQHEV8xrQYlKI7/htaZBEsKMlF9N8+pMVDQp/Whu3ee4y5iBL0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421615098"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="421615098"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 00:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881943501"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="881943501"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Jun 2023 00:11:17 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4ywP-0000EL-2R;
        Fri, 02 Jun 2023 07:11:17 +0000
Date:   Fri, 2 Jun 2023 15:11:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: kismet: WARNING: unmet direct dependencies detected for CRYPTO_GCM
 when selected by SEV_GUEST
Message-ID: <202306021511.A5iYGMjX-lkp@intel.com>
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
head:   9e87b63ed37e202c77aa17d4112da6ae0c7c097c
commit: fce96cf0443083e37455eff8f78fd240c621dae3 virt: Add SEV-SNP guest driver
date:   1 year, 2 months ago
config: x86_64-kismet-CONFIG_CRYPTO_GCM-CONFIG_SEV_GUEST-0-0 (https://download.01.org/0day-ci/archive/20230602/202306021511.A5iYGMjX-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fce96cf0443083e37455eff8f78fd240c621dae3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fce96cf0443083e37455eff8f78fd240c621dae3
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_CRYPTO_GCM --selectors CONFIG_SEV_GUEST -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306021511.A5iYGMjX-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for CRYPTO_GCM when selected by SEV_GUEST
   .config:5042:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   .config:6125:warning: symbol value 'ONFIG_ARCH_MMAP_RND_COMPAT_BITS_MI' invalid for ARCH_MMAP_RND_COMPAT_BITS
   
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
