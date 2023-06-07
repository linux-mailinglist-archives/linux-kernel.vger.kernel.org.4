Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8A726773
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjFGRcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFGRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:32:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE1D1FDA;
        Wed,  7 Jun 2023 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686159129; x=1717695129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AsVSg3Faz1IxnTa3HiL4YpkQZ7wQ38kBaOY0hJhpXrU=;
  b=QPHU595MaVDvKre3Peir1jxavI9OQzZVmTbV+HaAfwK8NJ01pKdKw1ik
   kJtt205TWGqUGEtDdgdLWmetYwwNO+Q3j9CoguJ5XM0FmijjPnJVhYLIw
   r+tDti17rhar5A0ds1ikVyPCIQNRZcR3rH/nb1DDhpe3x2hcHSJ+H/7gE
   y90WmKr6oSstlN6aC97m6Q4AMqFBpefDija2IBeU2tQvP8n9vual/Bap1
   JEoVrtVbdYFk4jI9f/AxLOWR/d7vuE5g1w1R+5q83zrw7wKAPn98PDeZ4
   7EW6QF7qpogc8bGQEdXA4HqAEOzGb9kQT96TVbgmplSPxK9JHhD5PEGXI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="420614934"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="420614934"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 10:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="854002886"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="854002886"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2023 10:32:04 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6x0u-0006mA-0K;
        Wed, 07 Jun 2023 17:32:04 +0000
Date:   Thu, 8 Jun 2023 01:31:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Stanley Chang <stanley_chang@realtek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 2.0 PHY
Message-ID: <202306080128.Gh3c2H1O-lkp@intel.com>
References: <20230607062500.24669-2-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607062500.24669-2-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanley,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus robh/for-next linus/master v6.4-rc5 next-20230607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanley-Chang/phy-realtek-usb-Add-driver-for-the-Realtek-SoC-USB-2-0-PHY/20230607-142704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230607062500.24669-2-stanley_chang%40realtek.com
patch subject: [PATCH v3 2/5] phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY
config: arm64-randconfig-r014-20230607 (https://download.01.org/0day-ci/archive/20230608/202306080128.Gh3c2H1O-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add usb https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
        git fetch usb usb-testing
        git checkout usb/usb-testing
        b4 shazam https://lore.kernel.org/r/20230607062500.24669-2-stanley_chang@realtek.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306080128.Gh3c2H1O-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "devm_usb_get_phy_by_phandle" [drivers/power/supply/wm831x_power.ko] undefined!
>> ERROR: modpost: "devm_usb_get_phy" [drivers/power/supply/da9150-charger.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for USB_PHY
   Depends on [n]: USB_SUPPORT [=n]
   Selected by [y]:
   - PHY_RTK_RTD_USB2PHY [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
