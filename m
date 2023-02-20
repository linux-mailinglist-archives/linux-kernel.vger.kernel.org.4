Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C280C69C645
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjBTIFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjBTIFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:05:11 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF4A10402
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676880310; x=1708416310;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=01oGrLUgQ5tdI6Y/Aa8uYNbCUuT6l98FR3ulJc3hAVk=;
  b=gqVQSfhPUsWcSLptRJhR7cL9Xa0n68tRq1SnnLXOCT61A7P+z+0WWWdv
   sCRC/B6l5bGv0lzfxWW4J/jfKzB2VohYl1116am7HTHcZnoxzUE0mX/E7
   Y0pgi6BZtQWHOc2KKNRPBGQHsUUDlq6J40yu5cwo0BWJSklv3I6IK2Ux9
   9n8kvOIPt6Uxr7+Qk8s0pZ5TkJMfbOAzeCFM6a9F0Juyw5scx9gH27cel
   u9AWDGdf4gotFY/Tvi26u+vcoXg7XZfsgu1UuzWZRm8FCO/U9giIpZJtY
   mpg0MAvnybqurJhJEjAVxXYA7avWWcDLudTL9CC0Y5wm6LASl+Md03pQJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="397031243"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="397031243"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 00:05:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="648752362"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="648752362"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2023 00:05:08 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pU1AZ-000DmL-11;
        Mon, 20 Feb 2023 08:05:07 +0000
Date:   Mon, 20 Feb 2023 16:05:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-rspi.c:1136:29: warning: 'qspi_ops' defined but not
 used
Message-ID: <202302201551.l6HP3T7S-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
commit: 851c902fd2d09b2ed85181e74b43477b7a3882be spi: rspi: Remove obsolete platform_device_id entries
date:   3 years, 2 months ago
config: x86_64-buildonly-randconfig-r004-20230220 (https://download.01.org/0day-ci/archive/20230220/202302201551.l6HP3T7S-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=851c902fd2d09b2ed85181e74b43477b7a3882be
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 851c902fd2d09b2ed85181e74b43477b7a3882be
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/clk/imx/ drivers/hwspinlock/ drivers/mmc/host/ drivers/spi/ drivers/usb/phy/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302201551.l6HP3T7S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-rspi.c:1136:29: warning: 'qspi_ops' defined but not used [-Wunused-const-variable=]
    1136 | static const struct spi_ops qspi_ops = {
         |                             ^~~~~~~~
>> drivers/spi/spi-rspi.c:1128:29: warning: 'rspi_rz_ops' defined but not used [-Wunused-const-variable=]
    1128 | static const struct spi_ops rspi_rz_ops = {
         |                             ^~~~~~~~~~~


vim +/qspi_ops +1136 drivers/spi/spi-rspi.c

426ef76dd8a394 Geert Uytterhoeven 2014-01-28  1127  
426ef76dd8a394 Geert Uytterhoeven 2014-01-28 @1128  static const struct spi_ops rspi_rz_ops = {
426ef76dd8a394 Geert Uytterhoeven 2014-01-28  1129  	.set_config_register =	rspi_rz_set_config_register,
426ef76dd8a394 Geert Uytterhoeven 2014-01-28  1130  	.transfer_one =		rspi_rz_transfer_one,
880c6d114fd79a Geert Uytterhoeven 2014-01-30  1131  	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP,
9428a073eb703d Geert Uytterhoeven 2019-02-08  1132  	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
2f777ec91aa062 Geert Uytterhoeven 2014-06-02  1133  	.fifo_size =		8,	/* 8 for TX, 32 for RX */
426ef76dd8a394 Geert Uytterhoeven 2014-01-28  1134  };
426ef76dd8a394 Geert Uytterhoeven 2014-01-28  1135  
426ef76dd8a394 Geert Uytterhoeven 2014-01-28 @1136  static const struct spi_ops qspi_ops = {
426ef76dd8a394 Geert Uytterhoeven 2014-01-28  1137  	.set_config_register =	qspi_set_config_register,
426ef76dd8a394 Geert Uytterhoeven 2014-01-28  1138  	.transfer_one =		qspi_transfer_one,
880c6d114fd79a Geert Uytterhoeven 2014-01-30  1139  	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP |
880c6d114fd79a Geert Uytterhoeven 2014-01-30  1140  				SPI_TX_DUAL | SPI_TX_QUAD |
880c6d114fd79a Geert Uytterhoeven 2014-01-30  1141  				SPI_RX_DUAL | SPI_RX_QUAD,
9428a073eb703d Geert Uytterhoeven 2019-02-08  1142  	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
2f777ec91aa062 Geert Uytterhoeven 2014-06-02  1143  	.fifo_size =		32,
426ef76dd8a394 Geert Uytterhoeven 2014-01-28  1144  };
426ef76dd8a394 Geert Uytterhoeven 2014-01-28  1145  

:::::: The code at line 1136 was first introduced by commit
:::::: 426ef76dd8a394a0e04d096941cd9acb49539a3e spi: rspi: Add DT support

:::::: TO: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
:::::: CC: Mark Brown <broonie@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
