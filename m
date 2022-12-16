Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ACE64F071
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiLPRhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 12:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiLPRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:37:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B192A164A9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671212219; x=1702748219;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yXW+wV+UgSM2VSneYgwaMavVBMwnnak5JNaby2zZkUY=;
  b=CTit5uW6eaCNF3GDuV3ogc0CGpP47y7jEnc5IqivZxUflrtrn1AQRrbi
   pNHMtWvdfU+apTma+/51JOtLB40j8ngwT44h+8XGki1p/Vl6uQppLJmbq
   yNhGVqa2R34+uWWLUPTUIaZ2tOSoDACjxbJSntITKeO+Y5utstFJYFFc1
   qFCNmSjuv1raEioETZqUYxESXvE5M9HVA24RZlYPYLVQn4/qaq40lQCP1
   eAj7rJ2bFA+ixUQOlKi3nFzSaeF7LSugUi50dtOTgyFfKy/+ymOY1C6nr
   0k4gh3DyDHb3Im7oU4UCtiAjfRrdd8vaw8Vrg15DAvqAPYGpx1oC0RaLQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="383352498"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="383352498"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 09:36:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="651997543"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="651997543"
Received: from krojasle-mobl.amr.corp.intel.com (HELO [10.209.187.31]) ([10.209.187.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 09:36:57 -0800
Message-ID: <9aa4bffd-bc7e-0e40-3063-5ce80b5fbe9a@linux.intel.com>
Date:   Fri, 16 Dec 2022 11:36:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2] ASoC: Intel: sof_nau8825: add variant with nau8318
 amplifier.
Content-Language: en-US
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     Libin Yang <libin.yang@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        David Lin <CTLIN0@nuvoton.com>, alsa-devel@alsa-project.org,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, Yong Zhi <yong.zhi@intel.com>
References: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
 <b0612bbd-2eba-36cf-9c29-7542cf32adfd@linux.intel.com>
 <CALprXBYy9_ax8-xfh0paB59Pn=TB7yVLwtY8vnT_-y5vWd867w@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CALprXBYy9_ax8-xfh0paB59Pn=TB7yVLwtY8vnT_-y5vWd867w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/22 10:55, Ajye Huang wrote:
> Hi Pierre
> 
> On Sat, Dec 17, 2022 at 12:03 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
> 
>> On 12/16/22 09:49, Ajye Huang wrote:
>>> This patch adds the driver data for two nau8318 speaker amplifiers on
>>> SSP1 and nau8825 on SSP0 for ADL platform.
>>
>> So here you are making reference to two amplifiers...
>>
>>> +static struct snd_soc_dai_link_component nau8318_components[] = {
>>> +     {
>>> +             .name = "NVTN2012:00",
>>> +             .dai_name = "nau8315-hifi",
>>> +     }
>>> +};
>>
>> but here there's only one? I was expecting something like what we've
>> used for Maxim amplifiers with a codec configuration and dailink
>> components that list the two amplifiers.
>>
>> static struct snd_soc_codec_conf max_98373_codec_conf[] = {
>>         {
>>                 .dlc = COMP_CODEC_CONF(MAX_98373_DEV0_NAME),
>>                 .name_prefix = "Right",
>>         },
>>         {
>>                 .dlc = COMP_CODEC_CONF(MAX_98373_DEV1_NAME),
>>                 .name_prefix = "Left",
>>         },
>> };
>>
>> struct snd_soc_dai_link_component max_98373_components[] = {
>>         {  /* For Right */
>>                 .name = MAX_98373_DEV0_NAME,
>>                 .dai_name = MAX_98373_CODEC_DAI,
>>         },
>>         {  /* For Left */
>>                 .name = MAX_98373_DEV1_NAME,
>>                 .dai_name = MAX_98373_CODEC_DAI,
>>         },
>> };
>>
>> Or is this a commit message problem and there's really only one amplifier?
> 
> Really , it has two speakers.  The nau8318 is an auto mode Amplifier
> chip, similar to the max98360a amp chip.
> EX: Sof_maxim_common.c (sound\soc\intel\boards):
> static struct snd_soc_dai_link_component max_98360a_components[] = {
>     {
>         .name = MAX_98360A_DEV0_NAME,
>         .dai_name = MAX_98357A_CODEC_DAI,
>     }
> };
> It is not an i2c interface,  from the nau8318 data sheet, there are
> five pins used mainly. one for enable, others for I2S.
> EN-- enable pin
> FSR-- Frame Sync, Right
> FSL--  Frame Sync, Left
> BCLK--  bit clock
> DACIN-- Input i2s data
> 
> The FSR and FSL pins are for Left and Right channels used.
> thanks

Ok, thanks for the explanations.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
