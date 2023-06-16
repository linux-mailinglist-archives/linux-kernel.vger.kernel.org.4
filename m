Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40234732D74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjFPKXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343845AbjFPKXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:23:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6D53C06
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686910899; x=1718446899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/CxSVayYqdgqSworRbtqlrbTvZxrjlkf8x9z3eMO+k0=;
  b=DrpftF/wIfK4v9ZVPEAB+jG1j1bvfQLJBCcNX92NLHtBRvROG0Mppy5T
   2VmeCGMwTmLmY7ep21zdQ6/J3Q6+mcMfdp1fOvfEON5mpdQNfJwkayFjS
   Gt9SP/qcg+K5nymlOBZZTh2os3Mo3qigQtgMNZ2W2tsXdOgZmplUsut5D
   1mdenlVWHxwiqTEF90wKaIvhZYjNGXo0Q3VeSY/jKxi6yhMMMk/ko5mbj
   WarAzuznZ5GBpw1Yd1v8d7GfzYa2aiIvZBXM3QazPTTfCll4K5DsfNFUm
   FQmOrdZ/7PwQbgaDdp/r5wb8p3F0GyPymFBROJdfvzqgMZK9fmINWsR76
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="339509385"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="339509385"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 03:21:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="836993463"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="836993463"
Received: from kjaffe-mobl.amr.corp.intel.com (HELO [10.254.114.132]) ([10.254.114.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 03:21:15 -0700
Message-ID: <c5ce23fc-db87-6f11-0708-85cc4ba2a46c@linux.intel.com>
Date:   Fri, 16 Jun 2023 12:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: sound/soc/soc-pcm.c:2089:5: warning: stack frame size (2064)
 exceeds limit (2048) in 'dpcm_be_dai_trigger'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <202306160240.ahGjvPqw-lkp@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <202306160240.ahGjvPqw-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/23 20:34, kernel test robot wrote:
> Hi Pierre-Louis,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b6dad5178ceaf23f369c3711062ce1f2afc33644
> commit: 9995c1d096c8ab1b5f1edc4141257719f6a53524 ASoC: soc-pcm: improve BE transition for PAUSE_RELEASE
> date:   1 year, 2 months ago
> config: riscv-buildonly-randconfig-r001-20230615 (https://download.01.org/0day-ci/archive/20230616/202306160240.ahGjvPqw-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         mkdir -p ~/bin
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9995c1d096c8ab1b5f1edc4141257719f6a53524
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 9995c1d096c8ab1b5f1edc4141257719f6a53524
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash ./ drivers/ fs/ lib/zstd/ mm/ sound/pci/hda/ sound/soc/
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306160240.ahGjvPqw-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> sound/soc/soc-pcm.c:2089:5: warning: stack frame size (2064) exceeds limit (2048) in 'dpcm_be_dai_trigger' [-Wframe-larger-than]
>    int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,

Not sure what causes this warning to show up, the code hasn't changed in
1.2 years, nor what to do about it....

>        ^
>    1 warning generated.
> 
> 
> vim +/dpcm_be_dai_trigger +2089 sound/soc/soc-pcm.c
> 
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2088  
> 23607025303af6e Liam Girdwood        2014-01-17 @2089  int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
> 45c0a188ca59e7e Mark Brown           2012-05-09  2090  			       int cmd)
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2091  {
> db3aa39c9106842 Kuninori Morimoto    2021-03-15  2092  	struct snd_soc_pcm_runtime *be;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2093  	bool pause_stop_transition;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2094  	struct snd_soc_dpcm *dpcm;
> b2ae80663008a76 Takashi Iwai         2021-12-07  2095  	unsigned long flags;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2096  	int ret = 0;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2097  
> 8d6258a4dd26783 Kuninori Morimoto    2018-09-18  2098  	for_each_dpcm_be(fe, stream, dpcm) {
> db3aa39c9106842 Kuninori Morimoto    2021-03-15  2099  		struct snd_pcm_substream *be_substream;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2100  
> db3aa39c9106842 Kuninori Morimoto    2021-03-15  2101  		be = dpcm->be;
> db3aa39c9106842 Kuninori Morimoto    2021-03-15  2102  		be_substream = snd_soc_dpcm_get_substream(be, stream);
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2103  
> 3c75c0ea5da749b Takashi Iwai         2022-01-19  2104  		snd_soc_dpcm_stream_lock_irqsave_nested(be, stream, flags);
> b2ae80663008a76 Takashi Iwai         2021-12-07  2105  
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2106  		/* is this op for this BE ? */
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2107  		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
> b2ae80663008a76 Takashi Iwai         2021-12-07  2108  			goto next;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2109  
> a9faca15a644ff7 Kuninori Morimoto    2020-12-01  2110  		dev_dbg(be->dev, "ASoC: trigger BE %s cmd %d\n",
> a9faca15a644ff7 Kuninori Morimoto    2020-12-01  2111  			be->dai_link->name, cmd);
> a9faca15a644ff7 Kuninori Morimoto    2020-12-01  2112  
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2113  		switch (cmd) {
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2114  		case SNDRV_PCM_TRIGGER_START:
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2115  			if (!be->dpcm[stream].be_start &&
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2116  			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
> 21fca8bdbb64df1 이경택               2020-04-01  2117  			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
> 3202e2f5fac0032 Mark Brown           2021-08-30  2118  			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
> b2ae80663008a76 Takashi Iwai         2021-12-07  2119  				goto next;
> 6479f7588651cbc Pierre-Louis Bossart 2021-08-17  2120  
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2121  			be->dpcm[stream].be_start++;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2122  			if (be->dpcm[stream].be_start != 1)
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2123  				goto next;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2124  
> a9faca15a644ff7 Kuninori Morimoto    2020-12-01  2125  			ret = soc_pcm_trigger(be_substream, cmd);
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2126  			if (ret) {
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2127  				be->dpcm[stream].be_start--;
> b2ae80663008a76 Takashi Iwai         2021-12-07  2128  				goto next;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2129  			}
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2130  
> 3202e2f5fac0032 Mark Brown           2021-08-30  2131  			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2132  			break;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2133  		case SNDRV_PCM_TRIGGER_RESUME:
> 3202e2f5fac0032 Mark Brown           2021-08-30  2134  			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
> b2ae80663008a76 Takashi Iwai         2021-12-07  2135  				goto next;
> 6479f7588651cbc Pierre-Louis Bossart 2021-08-17  2136  
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2137  			be->dpcm[stream].be_start++;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2138  			if (be->dpcm[stream].be_start != 1)
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2139  				goto next;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2140  
> a9faca15a644ff7 Kuninori Morimoto    2020-12-01  2141  			ret = soc_pcm_trigger(be_substream, cmd);
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2142  			if (ret) {
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2143  				be->dpcm[stream].be_start--;
> b2ae80663008a76 Takashi Iwai         2021-12-07  2144  				goto next;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2145  			}
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2146  
> 3202e2f5fac0032 Mark Brown           2021-08-30  2147  			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2148  			break;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2149  		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> 3aa1e96a2b95e2e Pierre-Louis Bossart 2021-12-07  2150  			if (!be->dpcm[stream].be_start &&
> 3aa1e96a2b95e2e Pierre-Louis Bossart 2021-12-07  2151  			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
> 3aa1e96a2b95e2e Pierre-Louis Bossart 2021-12-07  2152  			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
> b2ae80663008a76 Takashi Iwai         2021-12-07  2153  				goto next;
> 6479f7588651cbc Pierre-Louis Bossart 2021-08-17  2154  
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2155  			fe->dpcm[stream].fe_pause = false;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2156  			be->dpcm[stream].be_pause--;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2157  
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2158  			be->dpcm[stream].be_start++;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2159  			if (be->dpcm[stream].be_start != 1)
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2160  				goto next;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2161  
> a9faca15a644ff7 Kuninori Morimoto    2020-12-01  2162  			ret = soc_pcm_trigger(be_substream, cmd);
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2163  			if (ret) {
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2164  				be->dpcm[stream].be_start--;
> b2ae80663008a76 Takashi Iwai         2021-12-07  2165  				goto next;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2166  			}
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2167  
> 3202e2f5fac0032 Mark Brown           2021-08-30  2168  			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2169  			break;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2170  		case SNDRV_PCM_TRIGGER_STOP:
> 21fca8bdbb64df1 이경택               2020-04-01  2171  			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
> 3202e2f5fac0032 Mark Brown           2021-08-30  2172  			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
> b2ae80663008a76 Takashi Iwai         2021-12-07  2173  				goto next;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2174  
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2175  			if (be->dpcm[stream].state == SND_SOC_DPCM_STATE_START)
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2176  				be->dpcm[stream].be_start--;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2177  
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2178  			if (be->dpcm[stream].be_start != 0)
> b2ae80663008a76 Takashi Iwai         2021-12-07  2179  				goto next;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2180  
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2181  			pause_stop_transition = false;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2182  			if (fe->dpcm[stream].fe_pause) {
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2183  				pause_stop_transition = true;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2184  				fe->dpcm[stream].fe_pause = false;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2185  				be->dpcm[stream].be_pause--;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2186  			}
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2187  
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2188  			if (be->dpcm[stream].be_pause != 0)
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2189  				ret = soc_pcm_trigger(be_substream, SNDRV_PCM_TRIGGER_PAUSE_PUSH);
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2190  			else
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2191  				ret = soc_pcm_trigger(be_substream, SNDRV_PCM_TRIGGER_STOP);
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2192  
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2193  			if (ret) {
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2194  				if (be->dpcm[stream].state == SND_SOC_DPCM_STATE_START)
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2195  					be->dpcm[stream].be_start++;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2196  				if (pause_stop_transition) {
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2197  					fe->dpcm[stream].fe_pause = true;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2198  					be->dpcm[stream].be_pause++;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2199  				}
> b2ae80663008a76 Takashi Iwai         2021-12-07  2200  				goto next;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2201  			}
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2202  
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2203  			if (be->dpcm[stream].be_pause != 0)
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2204  				be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2205  			else
> 3202e2f5fac0032 Mark Brown           2021-08-30  2206  				be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2207  
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2208  			break;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2209  		case SNDRV_PCM_TRIGGER_SUSPEND:
> 3202e2f5fac0032 Mark Brown           2021-08-30  2210  			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
> b2ae80663008a76 Takashi Iwai         2021-12-07  2211  				goto next;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2212  
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2213  			be->dpcm[stream].be_start--;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2214  			if (be->dpcm[stream].be_start != 0)
> b2ae80663008a76 Takashi Iwai         2021-12-07  2215  				goto next;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2216  
> a9faca15a644ff7 Kuninori Morimoto    2020-12-01  2217  			ret = soc_pcm_trigger(be_substream, cmd);
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2218  			if (ret) {
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2219  				be->dpcm[stream].be_start++;
> b2ae80663008a76 Takashi Iwai         2021-12-07  2220  				goto next;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2221  			}
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2222  
> 3202e2f5fac0032 Mark Brown           2021-08-30  2223  			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2224  			break;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2225  		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> 3202e2f5fac0032 Mark Brown           2021-08-30  2226  			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
> b2ae80663008a76 Takashi Iwai         2021-12-07  2227  				goto next;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2228  
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2229  			fe->dpcm[stream].fe_pause = true;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2230  			be->dpcm[stream].be_pause++;
> 9995c1d096c8ab1 Pierre-Louis Bossart 2022-04-06  2231  
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2232  			be->dpcm[stream].be_start--;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2233  			if (be->dpcm[stream].be_start != 0)
> b2ae80663008a76 Takashi Iwai         2021-12-07  2234  				goto next;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2235  
> a9faca15a644ff7 Kuninori Morimoto    2020-12-01  2236  			ret = soc_pcm_trigger(be_substream, cmd);
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2237  			if (ret) {
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2238  				be->dpcm[stream].be_start++;
> b2ae80663008a76 Takashi Iwai         2021-12-07  2239  				goto next;
> 848aedfdc6ba25a Pierre-Louis Bossart 2021-12-07  2240  			}
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2241  
> 3202e2f5fac0032 Mark Brown           2021-08-30  2242  			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2243  			break;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2244  		}
> b2ae80663008a76 Takashi Iwai         2021-12-07  2245  next:
> b2ae80663008a76 Takashi Iwai         2021-12-07  2246  		snd_soc_dpcm_stream_unlock_irqrestore(be, stream, flags);
> b2ae80663008a76 Takashi Iwai         2021-12-07  2247  		if (ret)
> b2ae80663008a76 Takashi Iwai         2021-12-07  2248  			break;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2249  	}
> db3aa39c9106842 Kuninori Morimoto    2021-03-15  2250  	if (ret < 0)
> db3aa39c9106842 Kuninori Morimoto    2021-03-15  2251  		dev_err(fe->dev, "ASoC: %s() failed at %s (%d)\n",
> db3aa39c9106842 Kuninori Morimoto    2021-03-15  2252  			__func__, be->dai_link->name, ret);
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2253  	return ret;
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2254  }
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2255  EXPORT_SYMBOL_GPL(dpcm_be_dai_trigger);
> 01d7584cd2e5a93 Liam Girdwood        2012-04-25  2256  
> 
> :::::: The code at line 2089 was first introduced by commit
> :::::: 23607025303af6e84bc2cd4cabe89c21f6a22a3f ASoC: DPCM: make some DPCM API calls non static for compressed usage
> 
> :::::: TO: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> :::::: CC: Mark Brown <broonie@linaro.org>
> 
