Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369716B35FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 06:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCJFMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 00:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJFMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 00:12:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ABF272E;
        Thu,  9 Mar 2023 21:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678425117; x=1709961117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=noDPSzkrbIVRmf73+0OTg5GszDAlUz5733GqCCRBmYM=;
  b=BX/nz0s0HcWJGBwjMNw67fPBYeSo1Fui2XOLxHzKDzSjGrF11owW0mfQ
   NDYPPjc/oEDts4XLYcqIF14Uzhnj6o/ppKABpY00Q2woYFtARTAvRrBLJ
   0wODFiChyyaKn1iTrzPXjBjtcC46jn9ilqaOEq0lcd/CSwudEowFSeRjD
   gcXI3nyyuLfv9Nwx0ocp8q7sGOEsl8cwwfIMCeedj7Is2x2L/kvn0mhjP
   6bHEN3CDWbKs3RnYL9yEKEYvEZg+MIzEEJAhKFg/umhz/8KziidyfEPag
   W36Ufkt5rS6pAoVWFwstKFI0T+PdvHCBp49vMWuzRpn228Ejna8fci3E+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="336667024"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="336667024"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 21:11:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="680091881"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="680091881"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2023 21:11:55 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paV2o-0003Wd-00;
        Fri, 10 Mar 2023 05:11:54 +0000
Date:   Fri, 10 Mar 2023 13:10:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv1 02/11] power: supply: core: auto-exposure of
 simple-battery data
Message-ID: <202303101236.fqHwh3Tt-lkp@intel.com>
References: <20230309225041.477440-3-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309225041.477440-3-sre@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

I love your patch! Yet something to improve:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on robh/for-next linus/master v6.3-rc1 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Reichel/dt-bindings-power-supply-adc-battery-add-binding/20230310-065229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20230309225041.477440-3-sre%40kernel.org
patch subject: [PATCHv1 02/11] power: supply: core: auto-exposure of simple-battery data
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20230310/202303101236.fqHwh3Tt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/83ec4c841d68a66bc95f5e534a805e765785f934
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sebastian-Reichel/dt-bindings-power-supply-adc-battery-add-binding/20230310-065229
        git checkout 83ec4c841d68a66bc95f5e534a805e765785f934
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303101236.fqHwh3Tt-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "power_supply_get_property" [drivers/phy/ti/phy-tusb1210.ko] undefined!
>> ERROR: modpost: "power_supply_get_property" [drivers/power/supply/88pm860x_charger.ko] undefined!
>> ERROR: modpost: "power_supply_get_property" [drivers/power/supply/charger-manager.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
