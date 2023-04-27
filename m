Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216E36F00CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbjD0G2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjD0G2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:28:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D373C449F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 23:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682576896; x=1714112896;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SBHbRP2uH9ckZQ2moO8kKI2lZYJzWpGyqnzrTsZg2V8=;
  b=Q2Vd9J0ENSNv/dfM/npb/HxhWJ2Kl00vX4Q9/64ancx2M1UX5Yo7sII3
   2vdFJt/bNg9FidCB/Rfy2N/cQ/bT3sJwuOkM9+G2muBq8QfboPpFw/P/j
   fuA8TmsSZlQqCIbjf0QAFjbqaIPSNrhQIMgpjDjjeKSDEdk8ueKRGiwwW
   frb3rWkyvSNm17xhu97cG0GewtSw142NaFISqaaY5ukeJD7bsC0MfFqFZ
   wQ68R9AuoYKWcKkRxcfqySAe8OxTohv5DtmyGbsrCQc3nlmeTBcwy8kXi
   73eHRZoO4XZSdBvuvCcgTZcECucQvr3thVg5E/6J6cSL/Ej0/UvJI6G4M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="331592957"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="331592957"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 23:28:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="644561409"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="644561409"
Received: from lkp-server01.sh.intel.com (HELO 1e0e07564161) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Apr 2023 23:28:14 -0700
Received: from kbuild by 1e0e07564161 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prv6z-000037-20;
        Thu, 27 Apr 2023 06:28:13 +0000
Date:   Thu, 27 Apr 2023 14:27:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.04.26a 38/51] arch/x86/kernel/nmi.c:441:6:
 warning: no previous prototype for 'set_nmi_torture'
Message-ID: <202304271446.dk8ruOnO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.04.26a
head:   56b38a90a12f76e463a7381d8cff854926fa2b59
commit: e5bf47f3a53ddfad8e0c56b6cbf048de8d82b033 [38/51] x86/nmi: Add a set_nmi_torture() function to control NMI testing
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20230427/202304271446.dk8ruOnO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=e5bf47f3a53ddfad8e0c56b6cbf048de8d82b033
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2023.04.26a
        git checkout e5bf47f3a53ddfad8e0c56b6cbf048de8d82b033
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304271446.dk8ruOnO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/nmi.c:441:6: warning: no previous prototype for 'set_nmi_torture' [-Wmissing-prototypes]
     441 | void set_nmi_torture(int nmi_delay_in, bool nmi_halt1_in, bool nmi_halt2_in, bool nmi_halt3_in)
         |      ^~~~~~~~~~~~~~~


vim +/set_nmi_torture +441 arch/x86/kernel/nmi.c

   439	
   440	/* Set the test values as desired. */
 > 441	void set_nmi_torture(int nmi_delay_in, bool nmi_halt1_in, bool nmi_halt2_in, bool nmi_halt3_in)
   442	{
   443		WRITE_ONCE(nmi_delay, nmi_delay_in);
   444		WRITE_ONCE(nmi_halt1, nmi_halt1_in);
   445		WRITE_ONCE(nmi_halt2, nmi_halt2_in);
   446		WRITE_ONCE(nmi_halt3, nmi_halt3_in);
   447		pr_info("%s: Set NMI test parameters nmi_delay=%d nmi_halt1=%d nmi_halt2=%d nmi_halt3=%d\n",
   448			__func__, nmi_delay, nmi_halt1, nmi_halt2, nmi_halt3);
   449	}
   450	EXPORT_SYMBOL_GPL(set_nmi_torture);
   451	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
