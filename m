Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560DA6F43E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjEBM2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjEBM2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:28:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47442130
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683030508; x=1714566508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qdK9ZCfjM/VCR79/TkJmrZ0wJaDOUM+rryu9bdTqOrk=;
  b=iHiCAqY4CFZEa3ulcyHAhJCIYKC9rLXZ8tUWE4Ae99GjiCNofU0bdVFH
   6igpRnUe/AACAxuVKozuNAVuPkGD1ttGksksaMJ22PYaObRjluVz7Lhhr
   01TDkGru5gvHf61DriF6gNivmXCxt8wIpJgLF3GhUUJBoS+gVw7j83YZe
   sWfOBwXYaZGEWyjQdF+7Ej8gwH/3UPGUNZKOPByFWtt/imrGB7d48sRE+
   ty71qJzzfguoUfZ/k/WkAp0osYX0CjTqlBtRMj7hvrYWHjUHZCnoizqdZ
   vplmsnwJIY1RbsYL0/pNIiXa0G5pmNWQuIwvTHwbkcDH4mz6Rlam+lbJf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="413825449"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="413825449"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 05:28:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="840277778"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="840277778"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 May 2023 05:28:24 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptp7H-00012e-15;
        Tue, 02 May 2023 12:28:23 +0000
Date:   Tue, 2 May 2023 20:27:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com,
        Shenghao Ding <13916275206@139.com>
Subject: Re: [PATCH v1 4/5] ASoC: tas2781: Add tas2781 driver
Message-ID: <202305022033.LiI7Ojm4-lkp@intel.com>
References: <20230502053254.27085-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502053254.27085-1-13916275206@139.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenghao,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Ding/ASoC-dt-bindings-Add-tas2781-amplifier/20230502-133533
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230502053254.27085-1-13916275206%40139.com
patch subject: [PATCH v1 4/5] ASoC: tas2781: Add tas2781 driver
config: hexagon-randconfig-r045-20230430 (https://download.01.org/0day-ci/archive/20230502/202305022033.LiI7Ojm4-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b1465cd49efcbc114a75220b153f5a055ce7911f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2ce0b86d1a6546d78dc4151d98a67537b8cc8669
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shenghao-Ding/ASoC-dt-bindings-Add-tas2781-amplifier/20230502-133533
        git checkout 2ce0b86d1a6546d78dc4151d98a67537b8cc8669
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305022033.LiI7Ojm4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: dvc_tlv
   >>> defined at tas2781.h:148 (include/sound/tas2781.h:148)
   >>>            drivers/firmware/ti/tasdevice-fmw.o:(dvc_tlv) in archive vmlinux.a
   >>> defined at tas2781.h:148 (include/sound/tas2781.h:148)
   >>>            sound/soc/codecs/tas2781-lib.o:(.rodata+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: amp_vol_tlv
   >>> defined at tas2781.h:149 (include/sound/tas2781.h:149)
   >>>            drivers/firmware/ti/tasdevice-fmw.o:(amp_vol_tlv) in archive vmlinux.a
   >>> defined at tas2781.h:149 (include/sound/tas2781.h:149)
   >>>            sound/soc/codecs/tas2781-lib.o:(.rodata+0x10) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: dvc_tlv
   >>> defined at tas2781.h:148 (include/sound/tas2781.h:148)
   >>>            drivers/firmware/ti/tasdevice-fmw.o:(dvc_tlv) in archive vmlinux.a
   >>> defined at tas2781.h:148 (include/sound/tas2781.h:148)
   >>>            sound/soc/codecs/tas2781-i2c.o:(.rodata+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: amp_vol_tlv
   >>> defined at tas2781.h:149 (include/sound/tas2781.h:149)
   >>>            drivers/firmware/ti/tasdevice-fmw.o:(amp_vol_tlv) in archive vmlinux.a
   >>> defined at tas2781.h:149 (include/sound/tas2781.h:149)
   >>>            sound/soc/codecs/tas2781-i2c.o:(.rodata+0x10) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
