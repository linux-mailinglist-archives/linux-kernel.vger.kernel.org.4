Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C645B5E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiILQlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiILQln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:41:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FB73DF25
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663000901; x=1694536901;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HrhGxk2/iCVY5M0CFfwhHaqJ2VGJruraZPDq/GYEU78=;
  b=mjLd4Xw6wdMaGW2YXTgmczqqL5ySBiENdjiccKayIekwC1Hw5FsjyhDr
   SFDbwwvGNIplTzgEG1vDF8J31xJydvYuZzqUZk3IqFAosfQGLh5adtAM9
   +GjyR4NWHwrowjXjaa/Wk8nLcS+QwyZi0mevKWoW6A85xNF6lKzdGFCFK
   Tunu75BcsubL5SyaX4N3o45HWj1iw/NzJBDTV8XXVl9Wluz8gxQISMz9N
   7vzbhQf0QVIuzXDdYgzDOdYzBJgqcJtW/ABuW55wwHUk2DhYro+rhti5A
   csv5SPFK3U/n7o3xZ5WbQ4FP73ShjefhygBi2QiOF/IJMX4TTeIhXEZ3E
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="277647456"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="277647456"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 09:41:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="649320965"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Sep 2022 09:41:39 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXmV8-0002f7-1d;
        Mon, 12 Sep 2022 16:41:38 +0000
Date:   Tue, 13 Sep 2022 00:41:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Girish Mahadevan <girishm@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14-rebase 2947/9999]
 spi-geni-qcom.c:undefined reference to `clk_set_rate'
Message-ID: <202209130045.TEZuG612-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Girish,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: a756d02d5a186df7e64256ae3146f040b71f23cb [2947/9999] FROMLIST: spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
config: m68k-randconfig-r034-20220911 (https://download.01.org/0day-ci/archive/20220913/202209130045.TEZuG612-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/a756d02d5a186df7e64256ae3146f040b71f23cb
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14-rebase
        git checkout a756d02d5a186df7e64256ae3146f040b71f23cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/qcom/qcom-geni-se.o: In function `geni_se_clk_tbl_get':
   qcom-geni-se.c:(.text+0x7e2): undefined reference to `clk_round_rate'
   drivers/tty/serial/8250/8250_dw.o: In function `dw8250_set_termios':
   8250_dw.c:(.text+0x3da): undefined reference to `clk_round_rate'
   8250_dw.c:(.text+0x3f0): undefined reference to `clk_set_rate'
   drivers/tty/serial/qcom_geni_serial.o: In function `qcom_geni_serial_set_termios':
   qcom_geni_serial.c:(.text+0xa52): undefined reference to `clk_set_rate'
   drivers/tty/serial/mxs-auart.o: In function `mxs_auart_probe':
   mxs-auart.c:(.text+0x60a): undefined reference to `clk_set_rate'
   drivers/tty/serial/owl-uart.o: In function `owl_uart_set_termios':
   owl-uart.c:(.text+0x60c): undefined reference to `clk_set_rate'
   drivers/spi/spi-geni-qcom.o: In function `get_spi_clk_cfg':
>> spi-geni-qcom.c:(.text+0x5e2): undefined reference to `clk_set_rate'
   drivers/spi/spi-sun4i.o:spi-sun4i.c:(.text+0x2a8): more undefined references to `clk_set_rate' follow
   drivers/media/v4l2-core/v4l2-clk.o: In function `v4l2_clk_set_rate':
   v4l2-clk.c:(.text+0x37a): undefined reference to `clk_round_rate'
   v4l2-clk.c:(.text+0x38c): undefined reference to `clk_set_rate'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
