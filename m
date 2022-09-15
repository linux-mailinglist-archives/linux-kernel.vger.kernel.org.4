Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF1C5B9662
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIOIbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIOIbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:31:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDA38A1E9;
        Thu, 15 Sep 2022 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663230707; x=1694766707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4QDYhv01XhBj9H19T7cifgoQYgyC7r+UJfLax276tBI=;
  b=QkrL6RiCYezdZjx0jAPCMyuWDICqWScNX+Sx9q/ic4zTfh0OkO79CmmW
   2+OFLDiO2KQ5McMMyFrQB4xwPJM3sBy5UJP5vcoWPtXkxrMLbveZMbXT2
   UKeg3mKnV3VL4s/W/I2bjcWu5yw9IvD7s5kRmOsg/Om982BjDvbfy/kIT
   2HTRs564OUj7z6b6+qm7WF5rv9P0OmPXvu2lhiUkOSUma/1gUI4o4MusZ
   PwgyK/S6vzhdnoZhwmoIJFMeBxTX0qWv7f8y+dXsVtNJoHb3wWySGiORt
   SfC13kk6ZpTLw8ZovmEeAMC7ahHRHWpdq/EV6Ka0YJvHC3bnC4F5jGPzK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="296241737"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="296241737"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 01:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="650396990"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Sep 2022 01:31:44 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYkHf-0000Dj-1p;
        Thu, 15 Sep 2022 08:31:43 +0000
Date:   Thu, 15 Sep 2022 16:30:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v3] ARM: dts: aspeed: yosemit V2: Enable OCP debug card
Message-ID: <202209151642.BiM4LmOZ-lkp@intel.com>
References: <20220914095207.GA24690@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914095207.GA24690@hcl-ThinkPad-T495>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karthikeyan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm/for-next]
[also build test ERROR on arm64/for-next/core clk/clk-next rockchip/for-next shawnguo/for-next soc/for-next xilinx-xlnx/master linus/master v6.0-rc5 next-20220914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Karthikeyan-Pasupathi/ARM-dts-aspeed-yosemit-V2-Enable-OCP-debug-card/20220914-175427
base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220915/202209151642.BiM4LmOZ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f4ff107abc0f057d0a55ced8a8db831db6f7d59e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Karthikeyan-Pasupathi/ARM-dts-aspeed-yosemit-V2-Enable-OCP-debug-card/20220914-175427
        git checkout f4ff107abc0f057d0a55ced8a8db831db6f7d59e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:222.9-10 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
