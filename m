Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF605C0198
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIUPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiIUP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:29:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4619AFDD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663774004; x=1695310004;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rqJUOoVj5mAMGy2f3TCSteYp6PBvRaljpl/4msFKkoI=;
  b=bVFfALK/bYaZoERMSPR2oUoLLA78Mt5Oe6S5CE8TFBUlebPkPV/hqsaZ
   Hdvf7jUPfmLOPyLZHlERx6RoTvARqYmSeC058v55QLzjhsx1rg4tQC2Sq
   /1PXhxwgLjcxt3NStKRozPASUUz+shRZere6vWn7M4sPcH+EFy9nh56Gu
   sO+92+0zTkYUZcbS4GKiv/ArAIZLoDBf9LhkG6GU5L4e1052RC0TBAXPt
   s4ovwaRYgZQroB/ituV3TH+FspIsqxENv1l0DFMN8a7k859D3zNswoYx0
   VjOyMEkwXeO19loECI9dN0eabxjptu55bU3XXRVawy8FyJ759WPpZTlqy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="279759314"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="279759314"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="948199885"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2022 08:26:26 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob1cH-0003ib-1W;
        Wed, 21 Sep 2022 15:26:25 +0000
Date:   Wed, 21 Sep 2022 23:26:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-6.0-esp32 7/12]
 drivers/tty/serial/esp32_uart.c:33:6: warning: no previous prototype for
 function 'dbg_echo'
Message-ID: <202209212350.zedDtGpw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-6.0-esp32
head:   513fb5af258c5311c5e0684c21db9aeb48e981e8
commit: a17e7b31fc865c922149feb5c560bc4c497b8c34 [7/12] WIP: drivers/tty/serial: add driver for ESP32 UART
config: riscv-randconfig-r032-20220921 (https://download.01.org/0day-ci/archive/20220921/202209212350.zedDtGpw-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/jcmvbkbc/linux-xtensa/commit/a17e7b31fc865c922149feb5c560bc4c497b8c34
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-6.0-esp32
        git checkout a17e7b31fc865c922149feb5c560bc4c497b8c34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clk/ drivers/misc/ drivers/net/wireless/ralink/rt2x00/ drivers/pinctrl/ drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/esp32_uart.c:33:6: warning: no previous prototype for function 'dbg_echo' [-Wmissing-prototypes]
   void dbg_echo(const char *s)
        ^
   drivers/tty/serial/esp32_uart.c:33:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dbg_echo(const char *s)
   ^
   static 
>> drivers/tty/serial/esp32_uart.c:48:6: warning: no previous prototype for function 'dbg_printf' [-Wmissing-prototypes]
   void dbg_printf(const char *fmt, ...)
        ^
   drivers/tty/serial/esp32_uart.c:48:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dbg_printf(const char *fmt, ...)
   ^
   static 
   2 warnings generated.


vim +/dbg_echo +33 drivers/tty/serial/esp32_uart.c

    32	
  > 33	void dbg_echo(const char *s)
    34	{
    35		volatile void __iomem *base = (volatile void __iomem *)0x3ff40000;
    36	
    37		while ((readl(base + UART_STATUS_REG) & UART_TXFIFO_CNT_MASK) != 0)
    38			;
    39	
    40		while (*s) {
    41			if (*s == '\n')
    42				writel('\r', base + UART_FIFO_REG);
    43			writel(*s, base + UART_FIFO_REG);
    44			++s;
    45		}
    46	}
    47	
  > 48	void dbg_printf(const char *fmt, ...)
    49	{
    50		va_list ap;
    51		char buf[256];
    52	
    53		va_start(ap, fmt);
    54		vsnprintf(buf, sizeof(buf), fmt, ap);
    55		va_end(ap);
    56		dbg_echo(buf);
    57	}
    58	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
