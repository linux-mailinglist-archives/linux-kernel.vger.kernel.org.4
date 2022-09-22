Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D8F5E58E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiIVCzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIVCzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:55:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A713F04
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663815299; x=1695351299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1FvRcBVjSThU+ZLj/LthgVh6DAUV3SAXF87hiv2RbA8=;
  b=EwEzRGpR4awWePcP1wx/p/wZD36StzqYtmkVu4QabfkdXf7C0l9nTSew
   JE+Xbmfbq0EtV6+z9pkcXlSpdQqc/AvusSyJg5T9/CLOLIoEwYA1dVvuV
   Kn132lCBoBdiTKyhbeaSsOUXuhkkv3Eiutv5ybps2XIEwuJLejZekS19o
   lxXwJsjIhZOAuxDACREiXrPTHSK5EuHDHkE3fdOzl0GorU6zXd4Jd0ycH
   i2YQXzvIl4rjhZl/P5tJoREQ/bqQYg7596tmcvEZr7Jv58amcU5AYT+cQ
   A/1Q+HZEufC/mf3y0ozgECVRPnd6hi3wgmggFRhrAFRA+FF4Z/K6eNbJs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="361943786"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="361943786"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 19:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="745211443"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Sep 2022 19:54:57 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obCMa-0004Ee-2b;
        Thu, 22 Sep 2022 02:54:56 +0000
Date:   Thu, 22 Sep 2022 10:54:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-6.0-esp32 7/12]
 drivers/tty/serial/esp32_uart.c:33:6: warning: no previous prototype for
 'dbg_echo'
Message-ID: <202209221041.VOST58aJ-lkp@intel.com>
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

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-6.0-esp32
head:   513fb5af258c5311c5e0684c21db9aeb48e981e8
commit: a17e7b31fc865c922149feb5c560bc4c497b8c34 [7/12] WIP: drivers/tty/serial: add driver for ESP32 UART
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220922/202209221041.VOST58aJ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/a17e7b31fc865c922149feb5c560bc4c497b8c34
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-6.0-esp32
        git checkout a17e7b31fc865c922149feb5c560bc4c497b8c34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/clk/ drivers/net/wireless/realtek/rtw89/ drivers/scsi/qla2xxx/ drivers/tty/serial/ drivers/ufs/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/esp32_uart.c:33:6: warning: no previous prototype for 'dbg_echo' [-Wmissing-prototypes]
      33 | void dbg_echo(const char *s)
         |      ^~~~~~~~
>> drivers/tty/serial/esp32_uart.c:48:6: warning: no previous prototype for 'dbg_printf' [-Wmissing-prototypes]
      48 | void dbg_printf(const char *fmt, ...)
         |      ^~~~~~~~~~
   drivers/tty/serial/esp32_uart.c: In function 'dbg_printf':
   drivers/tty/serial/esp32_uart.c:54:9: warning: function 'dbg_printf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      54 |         vsnprintf(buf, sizeof(buf), fmt, ap);
         |         ^~~~~~~~~


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
