Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C417150E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 23:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjE2VUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 17:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE2VUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 17:20:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E38ECF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685395244; x=1716931244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xyBU20CXG8koMAj0bGsJoG+erRzjA7QWSdrP0r9WBTE=;
  b=kKptgnWfVicxi3uAVDyafjBZQkZKaYtuiXb/CNTd1cDwdHzMNFvL3mSh
   9elvemf+9dxGsj88//DpphvO55ZSd/mwFIi9BmVghSh78/jceaZ54UnMY
   zfpK/ikYMhJ5bKt1qnc+qb42fzvw40L+lfeWu94PI0xKHiaI3Ae5hgs9Q
   yY8EdLVJth6eWIFNFzJJ6Fs1Ftg7C/NTQC9d8jL74l+9wAZ0ie8wFPQSV
   dhB6/TqHuCZRxDnZI76i25+2Qy6M2Z1YdbrkiW6Y0ssbkZoVvv/rMLDpA
   aYIrdKDc+98g61nXmJ6H7Lnw9fW3G5u3giqIv3KFoDBKuXj0WoegouQIs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="358024396"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="358024396"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 14:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="683693353"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="683693353"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 May 2023 14:20:42 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3kID-000L8I-1u;
        Mon, 29 May 2023 21:20:41 +0000
Date:   Tue, 30 May 2023 05:20:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: kismet: WARNING: unmet direct dependencies detected for CRYPTO_AEAD2
 when selected by SEV_GUEST
Message-ID: <202305300557.PJ5ao694-lkp@intel.com>
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
head:   8b817fded42d8fe3a0eb47b1149d907851a3c942
commit: fce96cf0443083e37455eff8f78fd240c621dae3 virt: Add SEV-SNP guest driver
date:   1 year, 2 months ago
config: x86_64-kismet-CONFIG_CRYPTO_AEAD2-CONFIG_SEV_GUEST-0-0 (https://download.01.org/0day-ci/archive/20230530/202305300557.PJ5ao694-lkp@intel.com/config)
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
| Closes: https://lore.kernel.org/oe-kbuild-all/202305300557.PJ5ao694-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for CRYPTO_AEAD2 when selected by SEV_GUEST
   .config:5072:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   
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
