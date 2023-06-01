Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112A671F6AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjFAXdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjFAXdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:33:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED015189
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685662369; x=1717198369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jnUqFNkhIxJHpKKVsCBE6VI+DG87rqbejJG+frFjsGY=;
  b=c1XqcNBFvyKAeh4c7hpGknDrKpCT0dOCykT+AVxaSaXRIKCtPJp7+epi
   h/s2js1ul++ZMh+NXrqaa26B4yje1l3AiJZRnTjFL4jVRaPHTc+QzqA5Q
   gaXlGAE8OZ3hjdzd6iHs1FWbQkXODvN3T2PxpHg73qqFir57UNrkNVxye
   30Bd4Puom+CNsJJWuNhkWnud3YejD8FtHm6plSMzERQXqwAh8Mc7zPw0F
   BCipRmgp4W+0tTSusA5OszlYWNlCACBbcmUZsI+CZxkS6WqgoiUM3pBWl
   TO0I25eYZXLCBa2FSbEgg493xrwLgc0cAR2QPU6Xn251WnZU2pFEL0pfq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="353209033"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="353209033"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 16:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="831747988"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="831747988"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2023 16:32:46 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4rmf-0002l0-2Z;
        Thu, 01 Jun 2023 23:32:45 +0000
Date:   Fri, 2 Jun 2023 07:32:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: kismet: WARNING: unmet direct dependencies detected for CRYPTO_AEAD2
 when selected by SEV_GUEST
Message-ID: <202306020738.PhX4qjeQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9e87b63ed37e202c77aa17d4112da6ae0c7c097c
commit: fce96cf0443083e37455eff8f78fd240c621dae3 virt: Add SEV-SNP guest driver
date:   1 year, 2 months ago
config: x86_64-kismet-CONFIG_CRYPTO_AEAD2-CONFIG_SEV_GUEST-0-0 (https://download.01.org/0day-ci/archive/20230602/202306020738.PhX4qjeQ-lkp@intel.com/config)
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
| Closes: https://lore.kernel.org/oe-kbuild-all/202306020738.PhX4qjeQ-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for CRYPTO_AEAD2 when selected by SEV_GUEST
   .config:5047:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   .config:12594:warning: symbol value 'ONFIG_NR_CPUS_DEFAUL' invalid for NR_CPUS
   
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
