Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6306EE396
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjDYOCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjDYOCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:02:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25B61A4;
        Tue, 25 Apr 2023 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682431368; x=1713967368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l6q1dc5C1/q1Geq8yt82kUpPLs/7UC9mtgVUN2I56UE=;
  b=h5LpmLC4zIWnHrVCNUQ/ECOWOAd+4R/QT75d9q2qc5VctZZaxAc3Gj6y
   Xjp+cxDNpW3Si7YkTZ1H5p0OJMi8VRLamHllThRqBLou1Eu0ngqQGhZn5
   G63f4GyiGr/ZtnV91Fhl36qYN9F972kpIbqBp0XzB+ISpJRWxT9BFPTUk
   4YMpZdXj0U9Aq0CDkvfOG6QNs3rzgBbdF9agu/Iy4w1xrGtMkk3ISVX7Z
   834mf+lwqAG3NIl+IOs0HsECaBIseIEaFZ+FD33lmXRoboRFN/WsYoYUz
   RiFC/bD+PCU4+SSosNOZ4/3WXaV5soFRZsw7FA6xV2I6ezOhxGc1Fac51
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="412062305"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="412062305"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 07:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="837448058"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="837448058"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2023 07:02:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prJFh-000jRg-39;
        Tue, 25 Apr 2023 14:02:41 +0000
Date:   Tue, 25 Apr 2023 22:01:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v8 10/11] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Message-ID: <202304252118.P0ZCvlQO-lkp@intel.com>
References: <20230425102418.185783-11-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425102418.185783-11-ychuang570808@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next linus/master v6.3 next-20230424]
[cannot apply to pza/reset/next pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Huang/arm64-Kconfig-platforms-Add-config-for-Nuvoton-MA35-platform/20230425-182746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230425102418.185783-11-ychuang570808%40gmail.com
patch subject: [PATCH v8 10/11] tty: serial: Add Nuvoton ma35d1 serial driver support
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230425/202304252118.P0ZCvlQO-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9f299bce6e0e871aa112e06e2451e88198a75d97
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jacky-Huang/arm64-Kconfig-platforms-Add-config-for-Nuvoton-MA35-platform/20230425-182746
        git checkout 9f299bce6e0e871aa112e06e2451e88198a75d97
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304252118.P0ZCvlQO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/ma35d1_serial.c: In function 'ma35d1serial_probe':
   drivers/tty/serial/ma35d1_serial.c:675:28: error: implicit declaration of function 'devm_ioremap'; did you mean 'of_ioremap'? [-Werror=implicit-function-declaration]
     675 |         up->port.membase = devm_ioremap(&pdev->dev, up->port.iobase, UART_REG_SIZE);
         |                            ^~~~~~~~~~~~
         |                            of_ioremap
>> drivers/tty/serial/ma35d1_serial.c:675:26: warning: assignment to 'unsigned char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     675 |         up->port.membase = devm_ioremap(&pdev->dev, up->port.iobase, UART_REG_SIZE);
         |                          ^
   cc1: some warnings being treated as errors


vim +675 drivers/tty/serial/ma35d1_serial.c

   647	
   648	/*
   649	 * Register a set of serial devices attached to a platform device.
   650	 * The list is terminated with a zero flags entry, which means we expect
   651	 * all entries to have at least UPF_BOOT_AUTOCONF set.
   652	 */
   653	static int ma35d1serial_probe(struct platform_device *pdev)
   654	{
   655		struct resource *res_mem;
   656		struct uart_ma35d1_port *up;
   657		int ret = 0;
   658		struct clk *clk;
   659		int err;
   660	
   661		if (pdev->dev.of_node) {
   662			ret = of_alias_get_id(pdev->dev.of_node, "serial");
   663			if (ret < 0) {
   664				dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
   665				return ret;
   666			}
   667		}
   668		up = &ma35d1serial_ports[ret];
   669		up->port.line = ret;
   670		res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   671		if (!res_mem)
   672			return -ENODEV;
   673	
   674		up->port.iobase = res_mem->start;
 > 675		up->port.membase = devm_ioremap(&pdev->dev, up->port.iobase, UART_REG_SIZE);
   676		up->port.ops = &ma35d1serial_ops;
   677	
   678		spin_lock_init(&up->port.lock);
   679	
   680		clk = of_clk_get(pdev->dev.of_node, 0);
   681		if (IS_ERR(clk)) {
   682			err = PTR_ERR(clk);
   683			dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
   684			return -ENOENT;
   685		}
   686	
   687		err = clk_prepare_enable(clk);
   688		if (err)
   689			return -ENOENT;
   690	
   691		if (up->port.line != 0)
   692			up->port.uartclk = clk_get_rate(clk);
   693	
   694		ret = platform_get_irq(pdev, 0);
   695		if (ret < 0)
   696			return ret;
   697		up->port.irq = ret;
   698		up->port.dev = &pdev->dev;
   699		up->port.flags = UPF_BOOT_AUTOCONF;
   700	
   701		platform_set_drvdata(pdev, up);
   702	
   703		return uart_add_one_port(&ma35d1serial_reg, &up->port);
   704	}
   705	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
