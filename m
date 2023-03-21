Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57156C2694
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCUAzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCUAzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:55:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B68D34029
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679360108; x=1710896108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZHer9Ncbg/NVTXk2nlism8j1Sf+fLmesX1WdkPxr0pA=;
  b=OU6ZXtSq3VZN2byt00VxBu57z20il4c3Py07Tq6+++Nvaj06PF2laCCK
   4No2FJwqvQwzto+dser5KJB518bRDzUSbsIz3Ls/Vm7s75s99Ts/ciK0A
   YpjKdyjkHyftKFtET1WEKbhkmGJPayB5V+JgmsueDRDCnZ1eF/ITO5qsC
   RRWpnoJ/TN2dhfKlWdKKFlObSlhonkVev03yIJ6/vPJ+l5OnSP/5orCFE
   TXaIA2FZcUGI8ZblQVrTdEGErz9yHqpEoZWHZR3jk1Xu6NTClJtMOXQQ/
   VmeTEt1PVinTdB+x4A+2/a3WVrAHbyzjAJLifbr2DjCmBXSh9Nb5jfTbM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322655856"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="322655856"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 17:55:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="683641879"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="683641879"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2023 17:55:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peQHI-000BRq-1U;
        Tue, 21 Mar 2023 00:55:04 +0000
Date:   Tue, 21 Mar 2023 08:54:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marian Postevca <posteuca@mutex.one>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Marian Postevca <posteuca@mutex.one>
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
Message-ID: <202303210820.JYm7LOnS-lkp@intel.com>
References: <20230320203519.20137-4-posteuca@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320203519.20137-4-posteuca@mutex.one>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.3-rc3 next-20230320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marian-Postevca/ASoC-es8316-Enable-support-for-S32-LE-format-and-MCLK-div-by-2/20230321-043847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230320203519.20137-4-posteuca%40mutex.one
patch subject: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables sound for systems with a ES8336 codec
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230321/202303210820.JYm7LOnS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0562079546d40f50d025ea1c4dacd31120b8b0bc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Marian-Postevca/ASoC-es8316-Enable-support-for-S32-LE-format-and-MCLK-div-by-2/20230321-043847
        git checkout 0562079546d40f50d025ea1c4dacd31120b8b0bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/amd/acp/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210820.JYm7LOnS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c:464:6: warning: no previous prototype for 'acp3x_es83xx_init_ops' [-Wmissing-prototypes]
     464 | void acp3x_es83xx_init_ops(struct acp_mach_ops *ops)
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/acp3x_es83xx_init_ops +464 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c

   462	
   463	
 > 464	void acp3x_es83xx_init_ops(struct acp_mach_ops *ops)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
