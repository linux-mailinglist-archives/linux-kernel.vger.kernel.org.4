Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158AD72745F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjFHBg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFHBgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:36:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7868726AF;
        Wed,  7 Jun 2023 18:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686188176; x=1717724176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B0VSdm1hETZ89zwsJ2li+Uinhg7LbDBnxsYq254PuxU=;
  b=chsKfG7mG5c8jrJhQsjY7kysK9LSGkZnYaLnM4cIZPbuIurhm21O+fLv
   yvoVMjguuHLtM0r/gnYJFpSG8gkyikocx20tDhJ4gknzR5IuJW9JrjUA/
   wQDEzgA6bYIaLU0dUs2e63Xbnlkx7F00W0Ht6PAcVneJxsYr8HHpWauX/
   uD2fs6SxJ9YUFTqgOih7J6BGiL4lKEgzxGspphDAsMpRT/nHIut4845Hh
   yRBiLslOs7wp2fT+3vaHAQXvxx08Bi6IY4qW6te6pBTx9rXzTMjJevwUv
   mE38Ywh1D7SkjZyYWmIPv6lscqA+3p4SM/QcsTWpE3jeaz+NJa1TS8c3j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="341822939"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="341822939"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 18:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="687205165"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="687205165"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jun 2023 18:36:10 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q74ZO-00076D-0Q;
        Thu, 08 Jun 2023 01:36:10 +0000
Date:   Thu, 8 Jun 2023 09:35:31 +0800
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
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 3/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 3.0 PHY
Message-ID: <202306080940.5Lcjwfck-lkp@intel.com>
References: <20230607062500.24669-3-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607062500.24669-3-stanley_chang@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230607062500.24669-3-stanley_chang%40realtek.com
patch subject: [PATCH v3 3/5] phy: realtek: usb: Add driver for the Realtek SoC USB 3.0 PHY
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230608/202306080940.5Lcjwfck-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add usb https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
        git fetch usb usb-testing
        git checkout usb/usb-testing
        b4 shazam https://lore.kernel.org/r/20230607062500.24669-3-stanley_chang@realtek.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306080940.5Lcjwfck-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "usb_remove_phy" [drivers/phy/realtek/phy-rtk-usb2.ko] undefined!
ERROR: modpost: "usb_debug_root" [drivers/phy/realtek/phy-rtk-usb2.ko] undefined!
ERROR: modpost: "of_iomap" [drivers/phy/realtek/phy-rtk-usb2.ko] undefined!
ERROR: modpost: "usb_add_phy_dev" [drivers/phy/realtek/phy-rtk-usb2.ko] undefined!
>> ERROR: modpost: "usb_remove_phy" [drivers/phy/realtek/phy-rtk-usb3.ko] undefined!
>> ERROR: modpost: "usb_debug_root" [drivers/phy/realtek/phy-rtk-usb3.ko] undefined!
>> ERROR: modpost: "of_iomap" [drivers/phy/realtek/phy-rtk-usb3.ko] undefined!
>> ERROR: modpost: "usb_add_phy_dev" [drivers/phy/realtek/phy-rtk-usb3.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
WARNING: modpost: suppressed 26 unresolved symbol warnings because there were too many)

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for USB_PHY
   Depends on [n]: USB_SUPPORT [=n]
   Selected by [m]:
   - PHY_RTK_RTD_USB2PHY [=m]
   - PHY_RTK_RTD_USB3PHY [=m]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
