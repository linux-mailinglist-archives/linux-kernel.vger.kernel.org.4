Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2E76C9640
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCZPtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCZPtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:49:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF5E6180;
        Sun, 26 Mar 2023 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679845789; x=1711381789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OaKvVJRvcWuHtVOvJttpA3gJz8/VcByd+7+i/AbP3iw=;
  b=gnmcxmNCU+l6kmkRZBAFrrsgVTRUnDDhClFqYe4hIoSKRhmA0dFWhJVR
   VlyFtukXm8xgHk1QpPZ1eVjFk1/JUHPk3uESTrQEG59P2caCebAFHSIjS
   8K4aHlq3zHLTeJ3a1hJAL6Iirghaa8fQqaNoGfixb6ynEbdbO+Itjz8ii
   lXjFWRey1kgUADOEtxmceudN30Z9MFMbJYrE9a7cqUzkkC7z2/OZvE0CW
   iEKrzmqfa+NEmeO0DYtB7Z9cG9yi6iMoTqJdP0yIJIeql2m4HLNIif4U6
   1i3s141Yt00KuPgdf/fhkGHKykgvANhM7rNQs4ilLCgZ1S/XQrDxbpkPx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="319755938"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="319755938"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 08:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="807231038"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="807231038"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Mar 2023 08:49:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgScq-000HDn-1x;
        Sun, 26 Mar 2023 15:49:44 +0000
Date:   Sun, 26 Mar 2023 23:49:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herve Codina <herve.codina@bootlin.com>,
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
Message-ID: <202303262358.vWU2dypT-lkp@intel.com>
References: <20230322134654.219957-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322134654.219957-3-herve.codina@bootlin.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

I love your patch! Yet something to improve:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on broonie-sound/for-next lee-leds/for-leds-next robh/for-next linus/master v6.3-rc3 next-20230324]
[cannot apply to lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina/dt-bindings-mfd-Add-the-Lantiq-PEF2256-E1-T1-J1-framer/20230322-214827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20230322134654.219957-3-herve.codina%40bootlin.com
patch subject: [PATCH v3 2/6] mfd: Add support for the Lantiq PEF2256 framer
config: parisc-randconfig-p001-20230326 (https://download.01.org/0day-ci/archive/20230326/202303262358.vWU2dypT-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/53e683ee1cad96a898f7fed03f88a3898e8dcd15
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Herve-Codina/dt-bindings-mfd-Add-the-Lantiq-PEF2256-E1-T1-J1-framer/20230322-214827
        git checkout 53e683ee1cad96a898f7fed03f88a3898e8dcd15
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303262358.vWU2dypT-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/mfd/pef2256.o: in function `.LC58':
>> pef2256.c:(.rodata.cst4+0x54): undefined reference to `pinconf_generic_dt_node_to_map'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
