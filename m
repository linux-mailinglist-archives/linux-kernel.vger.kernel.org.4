Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC7A697C20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjBOMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBOMpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:45:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735B632CD0;
        Wed, 15 Feb 2023 04:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676465152; x=1708001152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ArTeTBl6HoOFZclYi5EBGCWmiDoltI/AT5lZ8Q0N0Tc=;
  b=LUl8RwjvJvHWsbMm3lYFWgmu6ovPceV9XW2/YVQQd0Pa7TiexFx6GQG5
   AMcTkq/5R7AfDDahp0nuNsBZSJkaB1iucFxqycaliKmh9wpH3SJ5pCpBs
   7ZYSkOeyIeeXzvrnb2XOi2j1be13BeHC4jd5NjgHgDFloWdp1zRFYOMBR
   1gBw0SrfCIbPdm2DIsZXHxBiTE1pDlmQJIy5pYQgpnS7RqohEyRMTluOG
   KWfC+Nz/a2TWnsof+LjajXdhoCZpjaT7WgB/b+wX0GmKq19XptSKxRW+9
   Etql2lcZGh0xfkVhw45clO6fxbjDdMRsvpYCp1oz0cAOCmny97ED/4+3q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417638100"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="417638100"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 04:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="669600690"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="669600690"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2023 04:45:46 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSHAP-0009MX-35;
        Wed, 15 Feb 2023 12:45:45 +0000
Date:   Wed, 15 Feb 2023 20:45:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 06/10] soc: fsl: cmp1: Add support for QMC
Message-ID: <202302152037.NXHi2aFY-lkp@intel.com>
References: <20230126083222.374243-7-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126083222.374243-7-herve.codina@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

I love your patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on robh/for-next powerpc/next powerpc/fixes linus/master v6.2-rc8 next-20230215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina/dt-bindings-soc-fsl-cpm_qe-Add-TSA-controller/20230128-152424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230126083222.374243-7-herve.codina%40bootlin.com
patch subject: [PATCH v4 06/10] soc: fsl: cmp1: Add support for QMC
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230215/202302152037.NXHi2aFY-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/20ec2eacb76ca7252aa2934f53357663652edd0f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Herve-Codina/dt-bindings-soc-fsl-cpm_qe-Add-TSA-controller/20230128-152424
        git checkout 20ec2eacb76ca7252aa2934f53357663652edd0f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302152037.NXHi2aFY-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/soc/fsl/qe/qmc.o: in function `qmc_probe':
>> qmc.c:(.text.qmc_probe+0xd8): undefined reference to `get_immrbase'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
