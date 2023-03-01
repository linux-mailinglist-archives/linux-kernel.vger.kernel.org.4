Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5786A6C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCAM0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:26:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1098823139;
        Wed,  1 Mar 2023 04:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677673581; x=1709209581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RFhvfep3rQoV9f6iVnl78FDfyj++uAV6VK+LcCiV/8U=;
  b=hbF90Ro1ZWJPDnGCu3MT4z6iEP7zAOHUaZoPBC6/PZZVudAjzX920e9s
   oUzbOBNJHlYqOm+IQQmd5sHCxcT2/Tt/+qkhU7QRCvNSQ1ua/hTZSREX+
   th/X7Cf6U3FvVcarqA93qQHRw+HhyZRLCInUd6Ub5zw8FNwZOFBz/bhI6
   b4fMqDJCRtoh+UrSPEqlcaQy5vs/3gAkLdxHtkaWIGMLtYi+lrEWdrblT
   od8CVh7SUtDZArcgzg7Kjk3lIpSQhz8zP/Mf+HvYtSIshEkb98kyeDAfy
   7RGpNchlBYJ2QXUFMiJgahQbwdzFnujnV51GaZ0At17WkKbJYsRZFY4EV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="318195089"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="318195089"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 04:26:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="676738624"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="676738624"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Mar 2023 04:26:17 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXLXE-00068d-1Z;
        Wed, 01 Mar 2023 12:26:16 +0000
Date:   Wed, 1 Mar 2023 20:26:10 +0800
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
Message-ID: <202303012020.TjjSJTcQ-lkp@intel.com>
References: <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pavel-leds/for-next]
[also build test ERROR on robh/for-next krzk-dt/for-next v6.2]
[cannot apply to linus/master next-20230301]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Kurbanov/dt-bindings-leds-add-binding-for-aw200xx/20230301-051348
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
patch link:    https://lore.kernel.org/r/20230228211046.109693-3-mmkurbanov%40sberdevices.ru
patch subject: [PATCH v2 2/2] leds: add aw20xx driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230301/202303012020.TjjSJTcQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/67ff1bda566825f286aa03653a54a5ca9bc98012
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Kurbanov/dt-bindings-leds-add-binding-for-aw200xx/20230301-051348
        git checkout 67ff1bda566825f286aa03653a54a5ca9bc98012
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303012020.TjjSJTcQ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [drivers/leds/leds-aw200xx.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/leds/leds-aw200xx.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
