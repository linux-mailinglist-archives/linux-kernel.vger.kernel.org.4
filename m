Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAE05ED809
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiI1Ij6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI1Ijf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2A2A221D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664354371; x=1695890371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V5ZHsDB6wcD9KRT2A0rLXsENvTTm9TvpXoN0E3+EoAs=;
  b=JNi7XZ31VYgr285enypFj3IqaGVqbqN13gSg62aQ/Dw7WevnWkCy3EE7
   1KD5U0xJ5wCI/+qGTc31eXK5n0Qqn0eyO9AoUDMJsFznfpb5KqVpFHckl
   8jxGhoDpfK3MJaf68K1lkZiqI7Zpjj4ij/zkclumBmPRbeTvKfHLM4q6E
   KmSaQj81zo4hk8IiuDXKWYn8znQ4bSVSG4AyTkDeacYPurRavr7ylxVd9
   IwJ09FnkoEpydac4Mis/rwuRcgPMG3HYliMNG8bJN4xpyDtFgA2AUbt1X
   kOPb9wVbfu/t3Nt+FdtjQ/YHUwNv7uH2BNX1Ys94bV3VyG/bVomYGJEIe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301520876"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="301520876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:39:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="617131390"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="617131390"
Received: from morank-mobl3.ger.corp.intel.com (HELO [10.251.211.7]) ([10.251.211.7])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:39:25 -0700
Message-ID: <d94a9abd-95ca-09ba-ab24-e4c38b832678@linux.intel.com>
Date:   Wed, 28 Sep 2022 10:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: remove
 SOF_RT1015_SPEAKER_AMP_100FS flag
Content-Language: en-US
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ajye Huang <ajye.huang@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>
References: <20220913074906.926774-1-brent.lu@intel.com>
 <2577e4db-8593-cf37-135b-aa51b6268cd7@linux.intel.com>
 <CY5PR11MB6257A5CC3976FAEA2C713A4997559@CY5PR11MB6257.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CY5PR11MB6257A5CC3976FAEA2C713A4997559@CY5PR11MB6257.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/22 15:16, Lu, Brent wrote:
>>> +		case SND_SOC_DAIFMT_DSP_A:
>>> +		case SND_SOC_DAIFMT_DSP_B:
>>> +			/* 4-slot TDM */
>>> +			ret = snd_soc_dai_set_tdm_slot(codec_dai,
>>> +						       rt1015_tdm_mask[i].tx,
>>> +						       rt1015_tdm_mask[i].rx,
>>> +						       4,
>>> +						       params_width(params));
>>
>> The changes look ok, just wondering if we can avoid hard-coding those 4 values.
>> Can we not get the number of TDM slots from topology and/or dailink
>> configuration?
>>
>>
> 
> I think TDM slot number is possible but not TX/RX mask. What we have in topology
> is union of tx/rx mask of all channels. We don't know the mask of specific channel in
> DAI_CONFIG.
> 
> DAI_CONFIG(SSP, 0, BOARD_HP_BE_ID, SSP0-Codec,
>         SSP_CONFIG(I2S, SSP_CLOCK(mclk, 19200000, codec_mclk_in),
>                 SSP_CLOCK(bclk, 2400000, codec_slave),
>                 SSP_CLOCK(fsync, 48000, codec_slave),
>                 SSP_TDM(2, 25, 3, 3),

the 3 3 is precisely the channel mask!

>                 SSP_CONFIG_DATA(SSP, 0, 24, 0, 0, 0, SSP_CC_BCLK_ES)))')
> 
> Regards,
> Brent
> 
