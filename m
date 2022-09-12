Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B237B5B59CE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiILMBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiILMAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:00:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DCE30547
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662984034; x=1694520034;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cOz4LC+vVivuX8Ts3PVkxuMj1HkgIMBETXMOxkFJ1pg=;
  b=kyg2n/PEDv1rAJqWlrWJXG3a0m9JbPEmYN+yk4F/fWYmhuGXTnXxmvKR
   VUGOiJmpilCNxfJKDeJP+VGhHWh+Sf/jyMWtE4A0KjVQf4sTWSheXSbIz
   iKpmpVsJ5kX6kQzS/GRTDhp0sGg+aE+Rra1GSEqaezSGZEbU7T0p1TLrs
   cb9joMwD9FZXRl/Juxlb8B3wQv+nByyyBhA6Axnxazw4CV8lx+3YEiBLU
   lc1ZuAiFfUqBDxk36xgN6lSAOBuko7CeoDlm0kWrwru68Wv5g41y5NmK+
   vaGrKuFh0i8rkiEXdn4+zOH2HslUGB8vOhWNuUNtk+WNIT1ut1Ef6PE/D
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299186203"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="299186203"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:00:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="705126666"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67]) ([10.252.32.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:00:26 -0700
Message-ID: <00ffdd42-2cb6-112e-3bb5-b9ef1105fc4f@linux.intel.com>
Date:   Mon, 12 Sep 2022 13:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ASoC: Intel: sof_rt5682: Add support for
 jsl_rt5682_rt1019
Content-Language: en-US
To:     "Lu, Brent" <brent.lu@intel.com>,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>
References: <20220816075424.1245593-1-sean.hong@quanta.corp-partner.google.com>
 <f6baa98e-af46-7ca8-397a-2e762cd444c6@linux.intel.com>
 <CY5PR11MB6257F0C029B0C9325A8AC443977F9@CY5PR11MB6257.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CY5PR11MB6257F0C029B0C9325A8AC443977F9@CY5PR11MB6257.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/22 10:07, Lu, Brent wrote:
> 
>> On 8/16/22 09:54, Sean Hong wrote:
>>> This patch adds the driver data for rt5682 support jsl_rt5682_rt1019.
>>>
>>> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
>>> ---
>>>  sound/soc/intel/boards/sof_rt5682.c               |  9 +++++++++
>>>  sound/soc/intel/common/soc-acpi-intel-jsl-match.c | 12 ++++++++++++
>>>  2 files changed, 21 insertions(+)
>>>
>>> diff --git a/sound/soc/intel/boards/sof_rt5682.c
>>> b/sound/soc/intel/boards/sof_rt5682.c
>>> index 045965312..3a840f3a9 100644
>>> --- a/sound/soc/intel/boards/sof_rt5682.c
>>> +++ b/sound/soc/intel/boards/sof_rt5682.c
>>> @@ -1100,6 +1100,15 @@ static const struct platform_device_id
>> board_ids[] = {
>>>  					SOF_RT5682_SSP_AMP(1) |
>>>  					SOF_RT5682_NUM_HDMIDEV(4)),
>>>  	},
>>> +	{
>>> +		.name = "jsl_rt5682_rt1019",
>>> +		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
>>> +					SOF_RT5682_MCLK_24MHZ |
>>
>> I see it's the same setting for all JSL devices but I am having doubts on this
>> MCLK.  Is this 24MHz value correct for JSL? It's derived from ICL so in theory
>> the MCLK should be a multiple of 19.2MHz if the root frequency was the
>> oscillator.
>>
>> Is this intentional?
>>
> 
> I've checked some internal wiki page and sof git log. It seems the first amp enabled
> on JSL is max98373 running in TDM 4 slot 100fs so 24MHz MCLK seems to be a
> reasonable choice. The commis is 5340225a7 ("topology: Add JSL da7219+max98373 support")
> 
> +# SSP 1 (ID: 0)
> +DAI_CONFIG(SSP, SPK_INDEX, 0, SPK_NAME,
> +       SSP_CONFIG(DSP_B, SSP_CLOCK(mclk, 24000000, codec_mclk_in),
> +               SSP_CLOCK(bclk, 4800000, codec_slave),
> +               SSP_CLOCK(fsync, 48000, codec_slave),
> +               SSP_TDM(4, 25, 3, 240),
> +               SSP_CONFIG_DATA(SSP, SPK_INDEX, 16)))
> 
> I've also tested 19.2MHz on JSL boards and it also works. 1K sinetone playback sounds ok.
> Since JSL boards are using 2.304 MHz bclk for max98360a and 3.072 MHz bclk for alc1015 now,
> changing to 19.2 MHz mclk seems no benefit.

Functionally there should be no difference, but the 24 MHz MCLK can only
be created on JSL from the 96 MHz HDaudio PLL while the 19.2 MHz can be
divided from the oscillator.

I guess it's too late to optimize now that the topology files are in use
so here is my Ack:

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


but that's a clear miss in the topology reviews.

