Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC0D6C9771
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 20:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjCZSWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCZSWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 14:22:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A616580;
        Sun, 26 Mar 2023 11:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679854972; x=1711390972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NoAMrGG8BO82WF0/W/nj7Qdz5t8YcEaBhEumn5bnTws=;
  b=QGe0qNLgH/yTHU45hpxizwbIa8VZo8kw6+z+KUzLCO52X8JILDEe/xXa
   tx8+a6J/+jC54MZKtmifZE2vazHI8GxSXUbi7R6+TkjvSL2XPLTHPkurx
   FLT8yETMsPGsvjF7LLtnWQGVjDUMtXQuskpMQCQiBSNuYAzWx7jbVZuO4
   J3jFFDwz2/UBpc/UAkmqR9aOrgYF9xxlRNjwxyHz9U86q30V3nrLoxKvj
   bJCGrgRB8ZW+y9keObE4gUDbxJfyDrssF4FeS0erkQsKEhtIyeCWSnGUv
   FqfjsDKf7GwJfx8nYyskCptgP8ZxerKF+gTh+qGewV0A8+cjpuZTxO1ro
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="402714547"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="402714547"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 11:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="660631212"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="660631212"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2023 11:22:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgV0y-000HIT-0m;
        Sun, 26 Mar 2023 18:22:48 +0000
Date:   Mon, 27 Mar 2023 02:22:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herve Codina via Alsa-devel <alsa-devel@alsa-project.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/6] mfd: Add support for the Lantiq PEF2256 framer
Message-ID: <202303270203.QeRuuc9d-lkp@intel.com>
References: <167949286900.26.3992817728812049195@mailman-core.alsa-project.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167949286900.26.3992817728812049195@mailman-core.alsa-project.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on broonie-sound/for-next lee-leds/for-leds-next robh/for-next linus/master v6.3-rc3 next-20230324]
[cannot apply to lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina-via-Alsa-devel/mfd-Add-support-for-the-Lantiq-PEF2256-framer/20230322-215208
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/167949286900.26.3992817728812049195%40mailman-core.alsa-project.org
patch subject: [PATCH v3 2/6] mfd: Add support for the Lantiq PEF2256 framer
config: m68k-randconfig-c024-20230326 (https://download.01.org/0day-ci/archive/20230327/202303270203.QeRuuc9d-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d60948895815b59306d870e7c189741b7d14d5e2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Herve-Codina-via-Alsa-devel/mfd-Add-support-for-the-Lantiq-PEF2256-framer/20230322-215208
        git checkout d60948895815b59306d870e7c189741b7d14d5e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303270203.QeRuuc9d-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/mfd/pef2256.o: in function `pinconf_generic_dt_node_to_map_pin':
>> pef2256.c:(.text+0x280): undefined reference to `pinconf_generic_dt_node_to_map'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
