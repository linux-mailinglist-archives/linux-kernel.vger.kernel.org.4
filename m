Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890FD6BACE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjCOKBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjCOKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:00:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D4C7E781;
        Wed, 15 Mar 2023 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678874386; x=1710410386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X6BAVsKWLXtrazjgu9pdHPUztlPGwZ8uFR32xRG5cjk=;
  b=QeaqUWrrQPBJBh69P0zwM4XW5tLigbTGbRjLuEraqj2I/ZG61oc9sZlx
   Bt/DHamuRDpbqkAKtyJsZkMlOIMA9aZzbchfxxkmqVz19XV+tyV7J22ZU
   WZylj+DGqeAkeeN4TU2WOfSkCHe5RpAFwKndm7jczqQbokRmUs6qew4eY
   xKmDeig7MJ1p89deQo3BZvSrLlwxucJsG1P47ZYziHOV97Jb22D82nRvu
   VeiO7yzrwrgSmvtHT+1QT7DkAYOK+tRfIJTmomLU07HtTW8bwlJzzC1rN
   o9MzWsQbJP8gq7w6RMrhTHvL2JsyJCgHIbHj4uI6k1svFByN3gXUFzyd7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321502517"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321502517"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 02:59:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="656699487"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="656699487"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2023 02:59:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcNv4-0007bb-0m;
        Wed, 15 Mar 2023 09:59:42 +0000
Date:   Wed, 15 Mar 2023 17:59:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        devicetree@vger.kernel.org,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: Re: [PATCH v3 2/2] leds: add aw20xx driver
Message-ID: <202303151746.f6VVX4iZ-lkp@intel.com>
References: <20230314120252.48263-3-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314120252.48263-3-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pavel-leds/for-next]
[cannot apply to lee-leds/for-leds-next robh/for-next linus/master v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Kurbanov/leds-add-aw20xx-driver/20230314-210251
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
patch link:    https://lore.kernel.org/r/20230314120252.48263-3-mmkurbanov%40sberdevices.ru
patch subject: [PATCH v3 2/2] leds: add aw20xx driver
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230315/202303151746.f6VVX4iZ-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9760204574f3c53a9753b6daf20125c8552ce8ae
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Kurbanov/leds-add-aw20xx-driver/20230314-210251
        git checkout 9760204574f3c53a9753b6daf20125c8552ce8ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303151746.f6VVX4iZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `kernel_entry':
   (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `start_kernel'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x20): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x30): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0xa4): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xb4): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x128): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x138): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x1bc): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x234): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x254): additional relocation overflows omitted from the output
   mips-linux-ld: drivers/leds/leds-aw200xx.o: in function `aw200xx_probe_dt':
>> leds-aw200xx.c:(.text.aw200xx_probe_dt+0x164): undefined reference to `__udivdi3'
>> mips-linux-ld: leds-aw200xx.c:(.text.aw200xx_probe_dt+0x184): undefined reference to `__udivdi3'
   mips-linux-ld: leds-aw200xx.c:(.text.aw200xx_probe_dt+0x53c): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
