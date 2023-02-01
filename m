Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87C4686B36
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjBAQLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjBAQLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:11:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28D340FD;
        Wed,  1 Feb 2023 08:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675267889; x=1706803889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1WRzhheT0far4uWXe5/27l5EWuUFvZB4LXQCLYYjMl4=;
  b=a1tHRK2ptw5CFpt8vjvczBweJ7gou26iszdkKK4Rw4SSwUpy+KT5FkNN
   N1EqSr0q32UuOTF1binOMsbp5Y17lz/7o++53ZhX+vQCdb6q6Nm6Ab8DW
   weoUgBNycR0rjeSovLasNrL+c81GMOGoZroLkFpj+yJTlNUOkz2JxHQ+u
   bF9sGWVqnXPNKlR47kCgdAsmGqNGGT5fHUCObNL+1hN7D1NX+30p4nLWc
   cQuLTING77PbEY8GQoD9c7AomzSwAKIsaGrcMlb3sPqTKUXcOU6K51MdJ
   uhLgPMwSDEQNR2kYYjRbK8CICjV/COrtSMIhPd0V//A/03O/hXQrRhGxW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="392762610"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="392762610"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 08:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="664918209"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="664918209"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 08:10:33 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNFgu-0005Z7-2i;
        Wed, 01 Feb 2023 16:10:32 +0000
Date:   Thu, 2 Feb 2023 00:09:41 +0800
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
Subject: Re: [PATCH 08/14] ASoC: q6dsp: q6apm-dai: Add open/free compress DAI
 callbacks
Message-ID: <202302012337.pC5Q3lLy-lkp@intel.com>
References: <20230201134947.1638197-9-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201134947.1638197-9-quic_mohs@quicinc.com>
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
patch link:    https://lore.kernel.org/r/20230201134947.1638197-9-quic_mohs%40quicinc.com
patch subject: [PATCH 08/14] ASoC: q6dsp: q6apm-dai: Add open/free compress DAI callbacks
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230201/202302012337.pC5Q3lLy-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/78a6016e006a8e405679fd335940ee710416c43f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mohammad-Rafi-Shaik/ALSA-compress-Update-compress-set-params-for-gapless-playback/20230201-215622
        git checkout 78a6016e006a8e405679fd335940ee710416c43f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash sound/soc/qcom/qdsp6/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/qcom/qdsp6/q6apm-dai.c:135:6: warning: no previous prototype for 'event_handler_compr' [-Wmissing-prototypes]
     135 | void event_handler_compr(uint32_t opcode, uint32_t token,
         |      ^~~~~~~~~~~~~~~~~~~


vim +/event_handler_compr +135 sound/soc/qcom/qdsp6/q6apm-dai.c

   134	
 > 135	void event_handler_compr(uint32_t opcode, uint32_t token,
   136					uint32_t *payload, void *priv)
   137	{
   138		struct q6apm_dai_rtd *prtd = priv;
   139		struct snd_compr_stream *substream = prtd->cstream;
   140		unsigned long flags;
   141		uint32_t wflags = 0;
   142		uint64_t avail;
   143		uint32_t bytes_written, bytes_to_write;
   144		bool is_last_buffer = false;
   145	
   146		switch (opcode) {
   147		case APM_CLIENT_EVENT_CMD_EOS_DONE:
   148			spin_lock_irqsave(&prtd->lock, flags);
   149			if (prtd->notify_on_drain) {
   150				snd_compr_drain_notify(prtd->cstream);
   151				prtd->notify_on_drain = false;
   152			} else {
   153				prtd->state = Q6APM_STREAM_STOPPED;
   154			}
   155			spin_unlock_irqrestore(&prtd->lock, flags);
   156			break;
   157		case APM_CLIENT_EVENT_DATA_WRITE_DONE:
   158			spin_lock_irqsave(&prtd->lock, flags);
   159			bytes_written = token >> APM_WRITE_TOKEN_LEN_SHIFT;
   160			prtd->copied_total += bytes_written;
   161			snd_compr_fragment_elapsed(substream);
   162	
   163			if (prtd->state != Q6APM_STREAM_RUNNING) {
   164				spin_unlock_irqrestore(&prtd->lock, flags);
   165				break;
   166			}
   167	
   168			avail = prtd->bytes_received - prtd->bytes_sent;
   169	
   170			if (avail > prtd->pcm_count) {
   171				bytes_to_write = prtd->pcm_count;
   172			} else {
   173				if (substream->partial_drain || prtd->notify_on_drain)
   174					is_last_buffer = true;
   175				bytes_to_write = avail;
   176			}
   177	
   178			if (bytes_to_write) {
   179				if (substream->partial_drain && is_last_buffer)
   180					wflags |= APM_LAST_BUFFER_FLAG;
   181	
   182				q6apm_write_async_compr(prtd->graph,
   183							bytes_to_write, 0, 0, wflags);
   184	
   185				prtd->bytes_sent += bytes_to_write;
   186	
   187				if (prtd->notify_on_drain && is_last_buffer)
   188					audioreach_shared_memory_send_eos(prtd->graph);
   189			}
   190	
   191			spin_unlock_irqrestore(&prtd->lock, flags);
   192			break;
   193		default:
   194			break;
   195		}
   196	}
   197	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
