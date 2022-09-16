Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5975BABD2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiIPK5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiIPK4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:56:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F52B241
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663325091; x=1694861091;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cmfy2CsDStN+b85QNz1p0ONaXHNh6BP4Ebk5ImS3v6A=;
  b=j7ULq/grLvq1jewtZsVdwPsvgM1tlX6DXIkPgOzfBY3o4WYTx/mGIzGr
   SCBWJ9WXNlc4CmFgQHK9BHMA/B3shEV2sGDAyaLCyLHO/o8GoBNClYOG1
   FrxHvmMMBuoVhNMTy1FLo3dZcGQc+/7pboHk1dz9J/14yxNeZWCGJPnmz
   zyk/Lj2R9hnQ8tc1TbIsxmpo61aI6F1WobivymOqjWGnAPBwGTMikYVqh
   3vH7JeYHOMGDP9M05aXSxpydik1+7TobrqxDkfCqNZ7b3qNjiDTY1mGGo
   LdlFPaVJkI/wocGL8+2ciG/iTxvf5V1/cMxi/mgZaXOyiahzfKKtNdPVz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="325238526"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="325238526"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 03:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="595212787"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2022 03:44:48 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZ8pz-0001hU-1u;
        Fri, 16 Sep 2022 10:44:47 +0000
Date:   Fri, 16 Sep 2022 18:44:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brent Lu <brent.lu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: sound/soc/intel/boards/sof_ssp_amp.c:97:6: warning: variable 'i' set
 but not used
Message-ID: <202209161811.hAq3MGyI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brent,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3245cb65fd91cd514801bf91f5a3066d562f0ac4
commit: 2fe14ff61bd6d4fabe313435dd378b5a38eb6102 ASoC: Intel: sof_ssp_amp: rename driver and support cs35l41 amplifier
date:   7 months ago
config: arm64-randconfig-r023-20220916 (https://download.01.org/0day-ci/archive/20220916/202209161811.hAq3MGyI-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2fe14ff61bd6d4fabe313435dd378b5a38eb6102
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2fe14ff61bd6d4fabe313435dd378b5a38eb6102
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash sound/soc/intel/boards/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/intel/boards/sof_ssp_amp.c:97:6: warning: variable 'i' set but not used [-Wunused-but-set-variable]
           int i = 0;
               ^
   1 warning generated.


vim +/i +97 sound/soc/intel/boards/sof_ssp_amp.c

    89	
    90	static int sof_card_late_probe(struct snd_soc_card *card)
    91	{
    92		struct sof_card_private *ctx = snd_soc_card_get_drvdata(card);
    93		struct snd_soc_component *component = NULL;
    94		char jack_name[NAME_SIZE];
    95		struct sof_hdmi_pcm *pcm;
    96		int err;
  > 97		int i = 0;
    98	
    99		if (!(sof_ssp_amp_quirk & SOF_HDMI_PLAYBACK_PRESENT))
   100			return 0;
   101	
   102		/* HDMI is not supported by SOF on Baytrail/CherryTrail */
   103		if (!ctx->idisp_codec)
   104			return 0;
   105	
   106		if (list_empty(&ctx->hdmi_pcm_list))
   107			return -EINVAL;
   108	
   109		if (ctx->common_hdmi_codec_drv) {
   110			pcm = list_first_entry(&ctx->hdmi_pcm_list, struct sof_hdmi_pcm,
   111					       head);
   112			component = pcm->codec_dai->component;
   113			return hda_dsp_hdmi_build_controls(card, component);
   114		}
   115	
   116		list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
   117			component = pcm->codec_dai->component;
   118			snprintf(jack_name, sizeof(jack_name),
   119				 "HDMI/DP, pcm=%d Jack", pcm->device);
   120			err = snd_soc_card_jack_new(card, jack_name,
   121						    SND_JACK_AVOUT, &pcm->sof_hdmi,
   122						    NULL, 0);
   123	
   124			if (err)
   125				return err;
   126	
   127			err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
   128						  &pcm->sof_hdmi);
   129			if (err < 0)
   130				return err;
   131	
   132			i++;
   133		}
   134	
   135		return hdac_hdmi_jack_port_init(component, &card->dapm);
   136	}
   137	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
