Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AD15B5911
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiILLOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiILLOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:14:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0662F116D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662981284; x=1694517284;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=34Sy9c7OCYlkrL64QYSrisV6esBjhRFslEPAIn8tZ+E=;
  b=MNSc1CaicgoEHzu/YB84A5SZUCdwAlSoXrQzYkYZvzarUM15smhvy/rL
   eSJRNFinSo0CoT9GG9cAsyISy+DVhTmKtmdt/Lo/6aGvivFpRQ6xiLDi3
   JiFQIjmtuKerRA+yooTSoLdSTpYuuIF5zsNFiNRad52Z3v5/lMheQDBBE
   /kWTPghmMxrNySZaAjzplVJbxai5J9UD3iLcRdVFdEkQ+aiVqJOKEfvpH
   x0RjmuiDSpGxZCPEsIQJ0kYA55c9Xa90rxggs93NQUwCvcfucmvfYkNl8
   lK2yJhUoWis5dyjr/2kOsjOTEapJNYEKJtpw5sGusm9a4LU/5yjW7Dncb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="324071273"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324071273"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 04:14:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="944592206"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2022 04:14:42 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXhOj-0002SF-2s;
        Mon, 12 Sep 2022 11:14:41 +0000
Date:   Mon, 12 Sep 2022 19:14:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Doug Anderson <dianders@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14 6580/9354] qcom_geni_serial.c:undefined
 reference to `clk_set_rate'
Message-ID: <202209121919.KFTYLA5V-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14
head:   6f750b16c322c9191168a3a97c427c90581d9144
commit: 12f34066295c18fea8f40973b522e260c86fefe7 [6580/9354] FROMGIT: tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP
config: m68k-randconfig-r034-20220911 (https://download.01.org/0day-ci/archive/20220912/202209121919.KFTYLA5V-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/12f34066295c18fea8f40973b522e260c86fefe7
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14
        git checkout 12f34066295c18fea8f40973b522e260c86fefe7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_dw.o: In function `dw8250_set_termios':
   8250_dw.c:(.text+0x3e2): undefined reference to `clk_round_rate'
   8250_dw.c:(.text+0x3f8): undefined reference to `clk_set_rate'
   drivers/tty/serial/qcom_geni_serial.o: In function `qcom_geni_serial_cons_pm':
   qcom_geni_serial.c:(.text+0x30a): undefined reference to `geni_se_resources_on'
   qcom_geni_serial.c:(.text+0x31e): undefined reference to `geni_se_resources_off'
   drivers/tty/serial/qcom_geni_serial.o: In function `qcom_geni_serial_port_setup':
   qcom_geni_serial.c:(.text+0x86c): undefined reference to `geni_se_config_packing'
   qcom_geni_serial.c:(.text+0x8ce): undefined reference to `geni_se_init'
   qcom_geni_serial.c:(.text+0x8da): undefined reference to `geni_se_select_mode'
   drivers/tty/serial/qcom_geni_serial.o: In function `qcom_geni_serial_set_termios':
>> qcom_geni_serial.c:(.text+0xb8a): undefined reference to `clk_set_rate'
   drivers/tty/serial/qcom_geni_serial.o: In function `qcom_geni_console_setup':
   qcom_geni_serial.c:(.init.text+0x60): undefined reference to `geni_se_resources_on'
   qcom_geni_serial.c:(.init.text+0x9e): undefined reference to `geni_se_resources_off'
   drivers/tty/serial/mxs-auart.o: In function `mxs_auart_probe':
   mxs-auart.c:(.text+0x5e8): undefined reference to `clk_set_rate'
   drivers/tty/serial/owl-uart.o: In function `owl_uart_set_termios':
   owl-uart.c:(.text+0x60c): undefined reference to `clk_set_rate'
   drivers/spi/spi-sun4i.o: In function `sun4i_spi_transfer_one':
   spi-sun4i.c:(.text+0x2a8): undefined reference to `clk_set_rate'
   drivers/spi/spi-sun6i.o: In function `sun6i_spi_transfer_one':
   spi-sun6i.c:(.text+0x2dc): undefined reference to `clk_set_rate'
   drivers/usb/phy/phy-generic.o: In function `usb_phy_gen_create_phy':
   phy-generic.c:(.text+0x3b2): undefined reference to `clk_set_rate'
   drivers/i2c/busses/i2c-qcom-geni.o: In function `geni_i2c_xfer':
   i2c-qcom-geni.c:(.text+0x6e0): undefined reference to `geni_se_select_mode'
   i2c-qcom-geni.c:(.text+0x80a): undefined reference to `geni_se_rx_dma_prep'
   i2c-qcom-geni.c:(.text+0x880): undefined reference to `geni_se_rx_dma_unprep'
   i2c-qcom-geni.c:(.text+0x8f4): undefined reference to `geni_se_tx_dma_prep'
   i2c-qcom-geni.c:(.text+0x972): undefined reference to `geni_se_tx_dma_unprep'
   drivers/i2c/busses/i2c-qcom-geni.o: In function `geni_i2c_probe':
   i2c-qcom-geni.c:(.text+0xbd0): undefined reference to `geni_se_resources_on'
   i2c-qcom-geni.c:(.text+0xbfa): undefined reference to `geni_se_resources_off'
   i2c-qcom-geni.c:(.text+0xc42): undefined reference to `geni_se_init'
   i2c-qcom-geni.c:(.text+0xc56): undefined reference to `geni_se_config_packing'
   drivers/media/v4l2-core/v4l2-clk.o: In function `v4l2_clk_set_rate':
   v4l2-clk.c:(.text+0x37a): undefined reference to `clk_round_rate'
   v4l2-clk.c:(.text+0x38c): undefined reference to `clk_set_rate'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
