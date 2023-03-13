Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899EB6B7887
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCMNLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCMNLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:11:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A26A408
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678713083; x=1710249083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5/v8hZeX3JHTuddiH+ohsP0faMUyO1GG9lvlYbgaG4s=;
  b=G6wRaSfFrzeckYzbZQvhH1s5JhDzShxbYetRQNS0P94epqwIeklRq9lP
   oLScbdfsMxrO9LHzIuFBqePx03+2CMElftcYK6GsjGPqNe92gD59re7na
   qJqwebtHF2RQhMmvSLEQ0djAzypFRafxT19plqfqYBnqUezA+Y3HxFFD4
   UkYza1VkuNVZnjHaHe2ib3z9uuBoPqnKaPe+R8ArVVcH/LuneaiwNJAL7
   bDf/BZS3RfbcCJIChADZ/KMNWPFC4pkzdNyj1n7rr5mctOKLdJr+AXJx5
   tKRrdnblVCzSuV8ONwloyupqsQM7l4f4Jm9EjDLuSlESueUvCCZi8vKsS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="316788222"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="316788222"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 06:11:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="671890390"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="671890390"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2023 06:11:19 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbhxP-0005gb-03;
        Mon, 13 Mar 2023 13:11:19 +0000
Date:   Mon, 13 Mar 2023 21:10:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] clocksource: timer-stm32-lp: Mark driver as
 non-removable
Message-ID: <202303132013.6jB1U6Dg-lkp@intel.com>
References: <20230313075430.2730803-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313075430.2730803-3-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

I love your patch! Yet something to improve:

[auto build test ERROR on fe15c26ee26efa11741a7b632e9f23b01aca4cc6]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/clocksource-sh_mtu2-Mark-driver-as-non-removable/20230313-155913
base:   fe15c26ee26efa11741a7b632e9f23b01aca4cc6
patch link:    https://lore.kernel.org/r/20230313075430.2730803-3-u.kleine-koenig%40pengutronix.de
patch subject: [PATCH 2/5] clocksource: timer-stm32-lp: Mark driver as non-removable
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230313/202303132013.6jB1U6Dg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d4016ca907c0dd473c1f28ce43f4ef2495cf1dd5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Uwe-Kleine-K-nig/clocksource-sh_mtu2-Mark-driver-as-non-removable/20230313-155913
        git checkout d4016ca907c0dd473c1f28ce43f4ef2495cf1dd5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303132013.6jB1U6Dg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clocksource/timer-stm32-lp.c:205:19: error: 'stm32_clkevent_lp_remove' undeclared here (not in a function); did you mean 'stm32_clkevent_lp_probe'?
     205 |         .remove = stm32_clkevent_lp_remove,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
         |                   stm32_clkevent_lp_probe
   drivers/clocksource/timer-stm32-lp.c:142:12: warning: 'stm32_clkevent_lp_probe' defined but not used [-Wunused-function]
     142 | static int stm32_clkevent_lp_probe(struct platform_device *pdev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~


vim +205 drivers/clocksource/timer-stm32-lp.c

48b41c5e2de6c5 Benjamin Gaignard 2020-06-03  203  
48b41c5e2de6c5 Benjamin Gaignard 2020-06-03  204  static struct platform_driver stm32_clkevent_lp_driver = {
48b41c5e2de6c5 Benjamin Gaignard 2020-06-03 @205  	.remove = stm32_clkevent_lp_remove,
48b41c5e2de6c5 Benjamin Gaignard 2020-06-03  206  	.driver	= {
48b41c5e2de6c5 Benjamin Gaignard 2020-06-03  207  		.name = "stm32-lptimer-timer",
48b41c5e2de6c5 Benjamin Gaignard 2020-06-03  208  		.of_match_table = of_match_ptr(stm32_clkevent_lp_of_match),
d4016ca907c0dd Uwe Kleine-König  2023-03-13  209  		.suppress_bind_attrs = true,
48b41c5e2de6c5 Benjamin Gaignard 2020-06-03  210  	},
48b41c5e2de6c5 Benjamin Gaignard 2020-06-03  211  };
48b41c5e2de6c5 Benjamin Gaignard 2020-06-03  212  module_platform_driver(stm32_clkevent_lp_driver);
48b41c5e2de6c5 Benjamin Gaignard 2020-06-03  213  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
