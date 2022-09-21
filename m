Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A545BF500
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiIUDuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiIUDuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:50:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D68539BB4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663732199; x=1695268199;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RuMwWQzKLToHMyJhJyQGhoAmhYUA+z1cZ/a4u4LT7oA=;
  b=FNJmbFFiJyc3guSAAgG+MyG9rPMuFqf1hkkR3b4eq0K+hItAevfHn1jl
   ipXWPp3z7dsr5Gne0uczPeb5gTZnFb5iFo7vh0OtweleogUEpeajRUCtu
   XGm9ZDOKlGuKbkRl8+UYWnNiafQUHcvpfY71u+kaBw2TWdZtHmqUdpyya
   gWlTmPwdWiDo6iPGWF1P6gMctc1+IAMhGhX3CR6jUGvSFJJYE93Aa9wVO
   bJfZ6TPW/T4BnSO4+GVy3fxMa5IWjh6/vqwkS77jNHy61aZfKdlNmzshX
   LQcKsXUNb50UNJWTPpAfw6u53YqXn7fM1JNfmKsrMGkakcN8ffZ+Uhviy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="282936672"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="282936672"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 20:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="761579147"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2022 20:49:56 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaqkG-0003CZ-0h;
        Wed, 21 Sep 2022 03:49:56 +0000
Date:   Wed, 21 Sep 2022 11:49:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev.2022.09.03a 36/36]
 kernel/rcu/srcutree.c:647:1: error: 'u' undeclared; did you mean 'u8'?
Message-ID: <202209211114.7li0O31k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.09.03a
head:   607762184099b5d0b6765f69673fafa1d7eb4d30
commit: 607762184099b5d0b6765f69673fafa1d7eb4d30 [36/36] srcu: Check for consistent per-CPU per-srcu_struct NMI safety
config: parisc-randconfig-r005-20220921 (https://download.01.org/0day-ci/archive/20220921/202209211114.7li0O31k-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/607762184099b5d0b6765f69673fafa1d7eb4d30
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev.2022.09.03a
        git checkout 607762184099b5d0b6765f69673fafa1d7eb4d30
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc64 SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/rcu/srcutree.c: In function 'srcu_check_nmi_safety':
>> kernel/rcu/srcutree.c:647:1: error: 'u' undeclared (first use in this function); did you mean 'u8'?
     647 | u);
         | ^
         | u8
   kernel/rcu/srcutree.c:647:1: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/rcu/srcutree.c:647:2: error: expected ';' before ')' token
     647 | u);
         |  ^
         |  ;
>> kernel/rcu/srcutree.c:647:2: error: expected statement before ')' token


vim +647 kernel/rcu/srcutree.c

   628	
   629	/*
   630	 * Check for consistent NMI safety.
   631	 */
   632	static void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
   633	{
   634		int nmi_safe_mask = 1 << nmi_safe;
   635		int old_nmi_safe_mask;
   636		struct srcu_data *sdp;
   637	
   638		if (!IS_ENABLED(CONFIG_PROVE_RCU))
   639			return;
   640		sdp = raw_cpu_ptr(ssp->sda);
   641		old_nmi_safe_mask = READ_ONCE(sdp->srcu_nmi_safety);
   642		if (!old_nmi_safe_mask) {
   643			WRITE_ONCE(sdp->srcu_nmi_safety, nmi_safe_mask);
   644			return;
   645		}
   646		WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
 > 647	u);
   648	}
   649	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
