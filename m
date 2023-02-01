Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D388C686C1A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjBAQvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBAQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:51:43 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D7773749;
        Wed,  1 Feb 2023 08:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675270302; x=1706806302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MPihZ1keAuSkK2h3BqSj6sByR6pdBoovP1rP5iabTMc=;
  b=hO57vMUbGulckjuO467lb/UfMOhSwBj0WlP7uO5qwiU9XwApi/xwuu50
   8fTjc1AmIEHlsCUrY5kgUFlMFn+v+aUGypuVD/cmO9/zEHiflbJpS0aSu
   P83k+v8AE5B6fZv+yhV8fvYHpcC7GN5cz2qarmJ4mkyeMOmG5vClmXn97
   pgpOqIrKnpAzOOKeCQ8KubBYANPriwbZENZkvDmXT/5UER1ZN5EZ08xhR
   j4WT8fYRrt4Ln+5FJthRrL2Yt74sxVOmX7AP7drGzVLyaJEMSRWTf0DPe
   WiQXzCmEZRIj7aKSFYbhufLW6NH6QyKDhzZGb+KAzVCa9HrdN0FebVYjk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="390588968"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="390588968"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 08:51:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="993755960"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="993755960"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Feb 2023 08:51:36 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNGKe-0005ay-0A;
        Wed, 01 Feb 2023 16:51:36 +0000
Date:   Thu, 2 Feb 2023 00:50:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: Re: [PATCH 10/14] ASoC: q6dsp: q6apm-dai: Add trigger/pointer
 compress DAI callbacks
Message-ID: <202302020014.J221iZHe-lkp@intel.com>
References: <20230201134947.1638197-11-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201134947.1638197-11-quic_mohs@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mohammad,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on next-20230201]
[cannot apply to tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.2-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mohammad-Rafi-Shaik/ALSA-compress-Update-compress-set-params-for-gapless-playback/20230201-215622
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230201134947.1638197-11-quic_mohs%40quicinc.com
patch subject: [PATCH 10/14] ASoC: q6dsp: q6apm-dai: Add trigger/pointer compress DAI callbacks
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230202/202302020014.J221iZHe-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2b44c079fb2d53ef9e13fc7d7b257fd4c6f4b56a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mohammad-Rafi-Shaik/ALSA-compress-Update-compress-set-params-for-gapless-playback/20230201-215622
        git checkout 2b44c079fb2d53ef9e13fc7d7b257fd4c6f4b56a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/qcom/qdsp6/q6apm-dai.c:152:6: warning: no previous prototype for 'event_handler_compr' [-Wmissing-prototypes]
     152 | void event_handler_compr(uint32_t opcode, uint32_t token,
         |      ^~~~~~~~~~~~~~~~~~~
>> sound/soc/qcom/qdsp6/q6apm-dai.c:576:5: warning: no previous prototype for 'q6apm_dai_compr_trigger' [-Wmissing-prototypes]
     576 | int q6apm_dai_compr_trigger(struct snd_soc_component *component,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/qcom/qdsp6/q6apm-dai.c:610:5: warning: no previous prototype for 'q6apm_dai_compr_ack' [-Wmissing-prototypes]
     610 | int q6apm_dai_compr_ack(struct snd_soc_component *component, struct snd_compr_stream *stream,
         |     ^~~~~~~~~~~~~~~~~~~


vim +/q6apm_dai_compr_trigger +576 sound/soc/qcom/qdsp6/q6apm-dai.c

   575	
 > 576	int q6apm_dai_compr_trigger(struct snd_soc_component *component,
   577				    struct snd_compr_stream *stream, int cmd)
   578	{
   579		struct snd_compr_runtime *runtime = stream->runtime;
   580		struct q6apm_dai_rtd *prtd = runtime->private_data;
   581		int ret = 0;
   582	
   583		switch (cmd) {
   584		case SNDRV_PCM_TRIGGER_START:
   585		case SNDRV_PCM_TRIGGER_RESUME:
   586		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
   587			ret = q6apm_write_async_compr(prtd->graph, prtd->pcm_count, 0, 0, NO_TIMESTAMP);
   588			break;
   589		case SNDRV_PCM_TRIGGER_STOP:
   590			break;
   591		case SNDRV_PCM_TRIGGER_SUSPEND:
   592		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
   593			break;
   594		case SND_COMPR_TRIGGER_NEXT_TRACK:
   595			prtd->next_track = true;
   596			prtd->next_track_stream_id = (prtd->graph->id == 1 ? 2 : 1);
   597			break;
   598		case SND_COMPR_TRIGGER_DRAIN:
   599		case SND_COMPR_TRIGGER_PARTIAL_DRAIN:
   600			prtd->notify_on_drain = true;
   601			break;
   602		default:
   603			ret = -EINVAL;
   604			break;
   605		}
   606	
   607		return ret;
   608	}
   609	
 > 610	int q6apm_dai_compr_ack(struct snd_soc_component *component, struct snd_compr_stream *stream,
   611				size_t count)
   612	{
   613		struct snd_compr_runtime *runtime = stream->runtime;
   614		struct q6apm_dai_rtd *prtd = runtime->private_data;
   615		unsigned long flags;
   616	
   617		spin_lock_irqsave(&prtd->lock, flags);
   618		prtd->bytes_received += count;
   619		spin_unlock_irqrestore(&prtd->lock, flags);
   620	
   621		return count;
   622	}
   623	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
