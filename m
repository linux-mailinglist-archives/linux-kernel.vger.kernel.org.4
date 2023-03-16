Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1368C6BD9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCPUPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCPUPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:15:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC238E2779
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678997750; x=1710533750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rnr9bM5NvaGufUTXYiCF1W3NAZAs1x+v1u7FDecbFJI=;
  b=YTw7LqgnpnYr5VY6loXbBmngf504QGmuMayfc839ZaNb4ff8SbimIFVc
   1hkcu/jR0UVHGkcnyGimo7Wk4fpdosrQuFFnncmJjG4m5EBdwFetGWFb4
   1YPtUvG/HhjX1w3qv7HtPRMm3ZmOvoaGLuZhqYj96wjsl9Y1UiRjpe458
   dvE6F+PIZGp9rEoBSQGEA345HYX+mENy0uRElFzmmA7daScQPt9DI720J
   s8ePSAOPa0Q4VIrke7QJLIqdUtrClcAIvqZkBUKE0EEfrtUmWA3FBEAsM
   kiwlyd4KQTzQp/H6tXrQefHg8JlSi0Cs8Dua3c6uP3YL3h2uoEM043BgP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="336797710"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="336797710"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 13:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="925892471"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="925892471"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2023 13:15:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcu0k-0008mu-0e;
        Thu, 16 Mar 2023 20:15:42 +0000
Date:   Fri, 17 Mar 2023 04:15:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Fitzgerald via Alsa-devel <alsa-devel@alsa-project.org>,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH v2 8/8] ASoC: cs35l56: Add driver for Cirrus Logic CS35L56
Message-ID: <202303170422.ZYpOtc4P-lkp@intel.com>
References: <167872265923.26.336497278776737619@mailman-core.alsa-project.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167872265923.26.336497278776737619@mailman-core.alsa-project.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on linus/master v6.3-rc2 next-20230316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Fitzgerald-via-Alsa-devel/ASoC-wm_adsp-Use-no_core_startstop-to-prevent-creating-preload-control/20230313-235605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/167872265923.26.336497278776737619%40mailman-core.alsa-project.org
patch subject: [PATCH v2 8/8] ASoC: cs35l56: Add driver for Cirrus Logic CS35L56
config: s390-randconfig-r044-20230313 (https://download.01.org/0day-ci/archive/20230317/202303170422.ZYpOtc4P-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/5856c94d659f9c9963f5c37762cf201e1f1765e9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Richard-Fitzgerald-via-Alsa-devel/ASoC-wm_adsp-Use-no_core_startstop-to-prevent-creating-preload-control/20230313-235605
        git checkout 5856c94d659f9c9963f5c37762cf201e1f1765e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303170422.ZYpOtc4P-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390x-linux-ld: sound/soc/codecs/cs35l56.o: in function `cs35l56_dsp_work':
>> sound/soc/codecs/cs35l56.c:887: undefined reference to `sdw_write_no_pm'
>> s390x-linux-ld: sound/soc/codecs/cs35l56.c:888: undefined reference to `sdw_read_no_pm'
>> s390x-linux-ld: sound/soc/codecs/cs35l56.c:889: undefined reference to `sdw_write_no_pm'
   s390x-linux-ld: sound/soc/codecs/cs35l56.c:953: undefined reference to `sdw_write_no_pm'
   s390x-linux-ld: sound/soc/codecs/cs35l56.o: in function `cs35l56_sdw_dai_hw_params':
>> sound/soc/codecs/cs35l56.c:710: undefined reference to `sdw_stream_add_slave'
   s390x-linux-ld: sound/soc/codecs/cs35l56.o: in function `cs35l56_sdw_dai_hw_free':
>> sound/soc/codecs/cs35l56.c:729: undefined reference to `sdw_stream_remove_slave'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SERIAL_MULTI_INSTANTIATE
   Depends on [n]: X86_PLATFORM_DEVICES [=n] && I2C [=y] && SPI [=y] && ACPI
   Selected by [y]:
   - SND_SOC_CS35L56_I2C [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y]
   - SND_SOC_CS35L56_SPI [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SPI_MASTER [=y]


vim +887 sound/soc/codecs/cs35l56.c

   668	
   669	static int cs35l56_sdw_dai_hw_params(struct snd_pcm_substream *substream,
   670					     struct snd_pcm_hw_params *params,
   671					     struct snd_soc_dai *dai)
   672	{
   673		struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
   674		struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
   675		struct sdw_stream_config sconfig;
   676		struct sdw_port_config pconfig;
   677		int ret;
   678	
   679		dev_dbg(cs35l56->dev, "%s: rate %d\n", __func__, params_rate(params));
   680	
   681		if (!cs35l56->init_done)
   682			return -ENODEV;
   683	
   684		if (!sdw_stream)
   685			return -EINVAL;
   686	
   687		memset(&sconfig, 0, sizeof(sconfig));
   688		memset(&pconfig, 0, sizeof(pconfig));
   689	
   690		sconfig.frame_rate = params_rate(params);
   691		sconfig.bps = snd_pcm_format_width(params_format(params));
   692	
   693		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
   694			sconfig.direction = SDW_DATA_DIR_RX;
   695			pconfig.num = CS35L56_SDW1_PLAYBACK_PORT;
   696			pconfig.ch_mask = cs35l56->rx_mask;
   697		} else {
   698			sconfig.direction = SDW_DATA_DIR_TX;
   699			pconfig.num = CS35L56_SDW1_CAPTURE_PORT;
   700			pconfig.ch_mask = cs35l56->tx_mask;
   701		}
   702	
   703		if (pconfig.ch_mask == 0) {
   704			sconfig.ch_count = params_channels(params);
   705			pconfig.ch_mask = GENMASK(sconfig.ch_count - 1, 0);
   706		} else {
   707			sconfig.ch_count = hweight32(pconfig.ch_mask);
   708		}
   709	
 > 710		ret = sdw_stream_add_slave(cs35l56->sdw_peripheral, &sconfig, &pconfig,
   711					   1, sdw_stream);
   712		if (ret) {
   713			dev_err(dai->dev, "Failed to add sdw stream: %d\n", ret);
   714			return ret;
   715		}
   716	
   717		return 0;
   718	}
   719	
   720	static int cs35l56_sdw_dai_hw_free(struct snd_pcm_substream *substream,
   721					   struct snd_soc_dai *dai)
   722	{
   723		struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
   724		struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
   725	
   726		if (!cs35l56->sdw_peripheral)
   727			return -EINVAL;
   728	
 > 729		sdw_stream_remove_slave(cs35l56->sdw_peripheral, sdw_stream);
   730	
   731		return 0;
   732	}
   733	
   734	static int cs35l56_sdw_dai_set_stream(struct snd_soc_dai *dai,
   735					      void *sdw_stream, int direction)
   736	{
   737		if (!sdw_stream)
   738			return 0;
   739	
   740		snd_soc_dai_dma_data_set(dai, direction, sdw_stream);
   741	
   742		return 0;
   743	}
   744	
   745	static const struct snd_soc_dai_ops cs35l56_sdw_dai_ops = {
   746		.set_tdm_slot = cs35l56_sdw_dai_set_tdm_slot,
   747		.shutdown = cs35l56_sdw_dai_shutdown,
   748		.hw_params = cs35l56_sdw_dai_hw_params,
   749		.hw_free = cs35l56_sdw_dai_hw_free,
   750		.mute_stream = cs35l56_mute_stream,
   751		.set_stream = cs35l56_sdw_dai_set_stream,
   752	};
   753	
   754	static struct snd_soc_dai_driver cs35l56_dai[] = {
   755		{
   756			.name = "cs35l56-asp1",
   757			.id = 0,
   758			.playback = {
   759				.stream_name = "ASP1 Playback",
   760				.channels_min = 1,
   761				.channels_max = 2,
   762				.rates = CS35L56_RATES,
   763				.formats = CS35L56_RX_FORMATS,
   764			},
   765			.capture = {
   766				.stream_name = "ASP1 Capture",
   767				.channels_min = 1,
   768				.channels_max = 4,
   769				.rates = CS35L56_RATES,
   770				.formats = CS35L56_TX_FORMATS,
   771			},
   772			.ops = &cs35l56_ops,
   773			.symmetric_rate = 1,
   774			.symmetric_sample_bits = 1,
   775		},
   776		{
   777			.name = "cs35l56-sdw1",
   778			.id = 1,
   779			.playback = {
   780				.stream_name = "SDW1 Playback",
   781				.channels_min = 1,
   782				.channels_max = 2,
   783				.rates = CS35L56_RATES,
   784				.formats = CS35L56_RX_FORMATS,
   785			},
   786			.capture = {
   787				.stream_name = "SDW1 Capture",
   788				.channels_min = 1,
   789				.channels_max = 6,
   790				.rates = CS35L56_RATES,
   791				.formats = CS35L56_TX_FORMATS,
   792			},
   793			.symmetric_rate = 1,
   794			.ops = &cs35l56_sdw_dai_ops,
   795		}
   796	};
   797	
   798	static int cs35l56_wait_for_firmware_boot(struct cs35l56_private *cs35l56)
   799	{
   800		unsigned int reg;
   801		unsigned int val;
   802		int ret;
   803	
   804		if (cs35l56->rev < CS35L56_REVID_B0)
   805			reg = CS35L56_DSP1_HALO_STATE_A1;
   806		else
   807			reg = CS35L56_DSP1_HALO_STATE;
   808	
   809		ret = regmap_read_poll_timeout(cs35l56->regmap, reg,
   810					       val,
   811					       (val < 0xFFFF) && (val >= CS35L56_HALO_STATE_BOOT_DONE),
   812					       CS35L56_HALO_STATE_POLL_US,
   813					       CS35L56_HALO_STATE_TIMEOUT_US);
   814	
   815		if ((ret < 0) && (ret != -ETIMEDOUT)) {
   816			dev_err(cs35l56->dev, "Failed to read HALO_STATE: %d\n", ret);
   817			return ret;
   818		}
   819	
   820		if ((ret == -ETIMEDOUT) || (val != CS35L56_HALO_STATE_BOOT_DONE)) {
   821			dev_err(cs35l56->dev, "Firmware boot fail: HALO_STATE=%#x\n", val);
   822			return -EIO;
   823		}
   824	
   825		return 0;
   826	}
   827	
   828	static const struct reg_sequence cs35l56_system_reset_seq[] = {
   829		REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
   830	};
   831	
   832	static void cs35l56_system_reset(struct cs35l56_private *cs35l56)
   833	{
   834		cs35l56->soft_resetting = true;
   835	
   836		/*
   837		 * Must enter cache-only first so there can't be any more register
   838		 * accesses other than the controlled system reset sequence below.
   839		 */
   840		regcache_cache_only(cs35l56->regmap, true);
   841		regmap_multi_reg_write_bypassed(cs35l56->regmap,
   842						cs35l56_system_reset_seq,
   843						ARRAY_SIZE(cs35l56_system_reset_seq));
   844	
   845		/* On SoundWire the registers won't be accessible until it re-enumerates. */
   846		if (cs35l56->sdw_peripheral)
   847			return;
   848	
   849		usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
   850		regcache_cache_only(cs35l56->regmap, false);
   851	}
   852	
   853	static void cs35l56_dsp_work(struct work_struct *work)
   854	{
   855		struct cs35l56_private *cs35l56 = container_of(work,
   856							       struct cs35l56_private,
   857							       dsp_work);
   858		unsigned int reg;
   859		unsigned int val;
   860		int ret = 0;
   861	
   862		if (!wait_for_completion_timeout(&cs35l56->init_completion,
   863						 msecs_to_jiffies(5000))) {
   864			dev_err(cs35l56->dev, "%s: init_completion timed out\n", __func__);
   865			goto complete;
   866		}
   867	
   868		if (!cs35l56->init_done || cs35l56->removing)
   869			goto complete;
   870	
   871		cs35l56->dsp.part = devm_kasprintf(cs35l56->dev, GFP_KERNEL, "cs35l56%s-%02x",
   872						   cs35l56->secured ? "s" : "", cs35l56->rev);
   873	
   874		if (!cs35l56->dsp.part)
   875			goto complete;
   876	
   877		pm_runtime_get_sync(cs35l56->dev);
   878	
   879		/*
   880		 * Disable SoundWire interrupts to prevent race with IRQ work.
   881		 * Setting sdw_irq_no_unmask prevents the handler re-enabling
   882		 * the SoundWire interrupt.
   883		 */
   884		if (cs35l56->sdw_peripheral) {
   885			cs35l56->sdw_irq_no_unmask = true;
   886			cancel_work_sync(&cs35l56->sdw_irq_work);
 > 887			sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1, 0);
 > 888			sdw_read_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_STAT_1);
 > 889			sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
   890		}
   891	
   892		ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_SHUTDOWN);
   893		if (ret) {
   894			dev_dbg(cs35l56->dev, "%s: CS35L56_MBOX_CMD_SHUTDOWN ret %d\n", __func__, ret);
   895			goto err;
   896		}
   897	
   898		if (cs35l56->rev < CS35L56_REVID_B0)
   899			reg = CS35L56_DSP1_PM_CUR_STATE_A1;
   900		else
   901			reg = CS35L56_DSP1_PM_CUR_STATE;
   902	
   903		ret = regmap_read_poll_timeout(cs35l56->regmap, reg,
   904					       val, (val == CS35L56_HALO_STATE_SHUTDOWN),
   905					       CS35L56_HALO_STATE_POLL_US,
   906					       CS35L56_HALO_STATE_TIMEOUT_US);
   907		if (ret < 0)
   908			dev_err(cs35l56->dev, "Failed to poll PM_CUR_STATE to 1 is %d (ret %d)\n",
   909				val, ret);
   910	
   911		/* Use wm_adsp to load and apply the firmware patch and coefficient files */
   912		ret = wm_adsp_power_up(&cs35l56->dsp);
   913		if (ret) {
   914			dev_dbg(cs35l56->dev, "%s: wm_adsp_power_up ret %d\n", __func__, ret);
   915			goto err;
   916		}
   917	
   918		if (cs35l56->removing)
   919			goto err;
   920	
   921		mutex_lock(&cs35l56->irq_lock);
   922	
   923		init_completion(&cs35l56->init_completion);
   924	
   925		cs35l56_system_reset(cs35l56);
   926	
   927		if (cs35l56->sdw_peripheral) {
   928			/*
   929			 * The system-reset causes the CS35L56 to detach from the bus.
   930			 * Wait for the manager to re-enumerate the CS35L56 and
   931			 * cs35l56_init() to run again.
   932			 */
   933			if (!wait_for_completion_timeout(&cs35l56->init_completion,
   934							 msecs_to_jiffies(5000))) {
   935				dev_err(cs35l56->dev, "%s: init_completion timed out (SDW)\n", __func__);
   936				goto err_unlock;
   937			}
   938		} else if (cs35l56_init(cs35l56)) {
   939			goto err_unlock;
   940		}
   941	
   942		cs35l56->fw_patched = true;
   943	
   944	err_unlock:
   945		mutex_unlock(&cs35l56->irq_lock);
   946	err:
   947		pm_runtime_mark_last_busy(cs35l56->dev);
   948		pm_runtime_put_autosuspend(cs35l56->dev);
   949	
   950		/* Re-enable SoundWire interrupts */
   951		if (cs35l56->sdw_peripheral) {
   952			cs35l56->sdw_irq_no_unmask = false;
   953			sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1,
   954					CS35L56_SDW_INT_MASK_CODEC_IRQ);
   955		}
   956	
   957	complete:
   958		complete_all(&cs35l56->dsp_ready_completion);
   959	}
   960	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
