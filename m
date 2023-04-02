Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92E56D3554
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 05:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDBDEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 23:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDBDD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 23:03:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F3520C3A;
        Sat,  1 Apr 2023 20:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680404636; x=1711940636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UwGIjXk3/Uoh9jUrJy/wr/+7yvyMHOiCs5iNw+KoTj8=;
  b=MsYVmEvFEyy7DSx/e3YcPU4wLoNy3O8xGU7hObWELVA0KxyvcXeo/Gke
   ImQYCQhgD9MeJxnU1XjrNdNH6BsrD2/1eU9jOIp+pSi8wBUaNqS6fnW8j
   B9jm2mJ9/2Lhqr6y0SSUCXLavIqoVjKBOqSiB3O1axJa1PRwh9CVINH0A
   SO/jB0eM0IztforZ6J4D7rNJGd0mgQkFtxz8XpqcVK+K6iIuJBIlNq4l2
   2c31tUb1e5tFpr78EB1ZCt0AIUvuj6HrNSIOZCIPerrRwN97ST41sgmNK
   V4ZqAUblFdDrq9HihBRRnwHfCAAhpB3LQc29pTrPLviJuWpL0tUmMsayI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="330260334"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="330260334"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 20:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="718147955"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="718147955"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2023 20:03:52 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pio0Q-000NCN-2f;
        Sun, 02 Apr 2023 03:03:46 +0000
Date:   Sun, 2 Apr 2023 11:02:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Honeywell mpr pressure sensor
Message-ID: <202304021013.6NytoSFn-lkp@intel.com>
References: <ZCf085W4XL2PtQf6@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCf085W4XL2PtQf6@arbad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

I love your patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Klinger/dt-bindings-iio-pressure-Support-Honeywell-mpr-sensors/20230401-171226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/ZCf085W4XL2PtQf6%40arbad
patch subject: [PATCH 2/3] iio: pressure: Honeywell mpr pressure sensor
config: arm-buildonly-randconfig-r004-20230401 (https://download.01.org/0day-ci/archive/20230402/202304021013.6NytoSFn-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/6a49dae45811d8a644c56dc18b6cdbc6ea67df98
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andreas-Klinger/dt-bindings-iio-pressure-Support-Honeywell-mpr-sensors/20230401-171226
        git checkout 6a49dae45811d8a644c56dc18b6cdbc6ea67df98
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304021013.6NytoSFn-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__aeabi_ldivmod" [drivers/iio/pressure/mpr.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
