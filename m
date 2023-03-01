Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74946A6759
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 06:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCAFeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 00:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCAFeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 00:34:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9264910A98;
        Tue, 28 Feb 2023 21:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677648850; x=1709184850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A6ub2cXWHQMEfm0wCSYRJRabIFLkc/xUWoGiNEvzz4g=;
  b=ecxl8KnjEBOBMSsuTBOuhmTyb/7cL88Gh+8mu7wnlCOX8gOJ28S2AWEF
   91GHxgCbxij/oLOXeIxIQ8J7qNna+7MU8mPI9zwTGDt8H5o+JYCtgrbbX
   Q9g3h31sd89HJ5TIfZY3dEhRr5FmZfvutaedgiM9SJ/BDLlQWkghYVI/e
   gk+2nR35JhNoTT+5FaCwIPlChHRTwdWo0XOQwW8cfiGzFju5IUvXrjm+q
   XrRtFIYT89ABBUvj6H+x3JRGRcI4Hu+EbhWg6cNe63Q2M8bqyCboFivhy
   Nv32RO34xHP1/MPPsxhcDdyR7DxP0YY1fSlVVG08LvCv7HKR+giu3VEex
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="361901880"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="361901880"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 21:34:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="848509548"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="848509548"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2023 21:34:06 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXF6M-0005vf-0L;
        Wed, 01 Mar 2023 05:34:06 +0000
Date:   Wed, 1 Mar 2023 13:33:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: Re: [PATCH v2 2/2] leds: add aw20xx driver
Message-ID: <202303011345.29QIi1UF-lkp@intel.com>
References: <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pavel-leds/for-next]
[also build test WARNING on robh/for-next krzk-dt/for-next v6.2]
[cannot apply to linus/master next-20230301]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Kurbanov/dt-bindings-leds-add-binding-for-aw200xx/20230301-051348
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
patch link:    https://lore.kernel.org/r/20230228211046.109693-3-mmkurbanov%40sberdevices.ru
patch subject: [PATCH v2 2/2] leds: add aw20xx driver
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230301/202303011345.29QIi1UF-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/67ff1bda566825f286aa03653a54a5ca9bc98012
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Kurbanov/dt-bindings-leds-add-binding-for-aw200xx/20230301-051348
        git checkout 67ff1bda566825f286aa03653a54a5ca9bc98012
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303011345.29QIi1UF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/leds/leds-aw200xx.c:18: warning: expecting prototype for leds(). Prototype was for AW200XX_LEDS_MAX() instead


vim +18 drivers/leds/leds-aw200xx.c

    17	
  > 18	#define AW200XX_LEDS_MAX                 72
    19	#define AW200XX_PATTERN_MAX              3
    20	#define AW200XX_DIM_MAX                  0x3F
    21	#define AW200XX_FADE_MAX                 0xFF
    22	#define AW200XX_IMAX_DEFAULT_MICROAMP    60000
    23	#define AW200XX_IMAX_MAX_MICROAMP        160000
    24	#define AW200XX_IMAX_MIN_MICROAMP        3300
    25	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
