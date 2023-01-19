Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09036673D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjASPff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjASPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:35:31 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC2A83E8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:35:25 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J6b7Kt026436;
        Thu, 19 Jan 2023 09:35:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=/iRvVYWK5rL4I2zuHLJ2GkHIvEHY6z28u+BP65XjZJ0=;
 b=bpeweQ8ZEJoVXwjW1g+9cPduqlcwZvf8j18vXom1QAnTprUo5PkdG/sVbYSaP1BncxJR
 3oyeWf3pSEa2p2W5jZU41XPCJI6b60ZVXoggHQUfL/jeM4IEXVpQNfWDEnZmuq0AgHuz
 d1yqTaM1mwoZVUPMp72eeOUS3MhxRAqnwL2wa9iytgQ6wo24QGmEmITQuEmkc1C6ne76
 TwRwke9vUKIyyiZsuEcaOiNsz3bLhGmaX2YIkm8D0tboPtkWXhI1j3K6/6uOPCUOKaFR
 Za8rKopLvZm6BY4C1W0wN2Pdk1WyY7TirRRD9t3E/WZaljxfd7KqYtInAkzbxnspYAa7 ow== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3n3tp6g5d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 09:35:16 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 19 Jan
 2023 09:35:14 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Thu, 19 Jan 2023 09:35:14 -0600
Received: from [198.61.64.248] (EDIN4L06LR3.ad.cirrus.com [198.61.64.248])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5781611CA;
        Thu, 19 Jan 2023 15:35:14 +0000 (UTC)
Message-ID: <32fd1755-0128-8f32-9a88-a92f1647f903@opensource.cirrus.com>
Date:   Thu, 19 Jan 2023 15:35:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/8] ASoC: cs42l42: Add Soundwire support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-7-sbinding@opensource.cirrus.com>
 <33130336-b2ce-330e-fdec-166eee977e13@linux.intel.com>
 <418f6b73-b5ac-8d87-a856-3413ec103f91@opensource.cirrus.com>
 <6ea1b85f-22e2-8744-9638-6321a5a21acf@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <6ea1b85f-22e2-8744-9638-6321a5a21acf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: j_CL7edq6RPNITkhRLOAVsaTXzHjWJyc
X-Proofpoint-GUID: j_CL7edq6RPNITkhRLOAVsaTXzHjWJyc
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/1/23 14:48, Pierre-Louis Bossart wrote:
> 
>>>> +static int cs42l42_sdw_dai_startup(struct snd_pcm_substream *substream,
>>>> +                   struct snd_soc_dai *dai)
>>>> +{
>>>> +    struct cs42l42_private *cs42l42 =
>>>> snd_soc_component_get_drvdata(dai->component);
>>>> +
>>>> +    if (!cs42l42->init_done)
>>>> +        return -ENODEV;
>>>
>>> Can this happen? IIRC the ASoC framework would use
>>> pm_runtime_resume_and_get() before .startup, which would guarantee that
>>> the device is initialized, no?
>>>
>>
>> Yes, this can happen. Because of the way that the SoundWire enumeration
>> was implemented in the core code, it isn't a probe event so we cannot
>> call snd_soc_register_component() on enumeration because -EPROBE_DEFER
>> wouldn't be handled. So the snd_soc_register_component() must be called
>> from probe(). This leaves a limbo situation where we've registered the
>> driver but in fact don't yet have any hardware. ALSA/ASoC doesn't know
>> that we've registered before we are functional so they are happy to
>> go ahead and try to use the soundcard. If for some reason the hardware
>> failed to enumerate we can get here without having enumerated.
> 
> Humm, yes, but you've also made the regmap cache-only, so is there
> really a problem?
> 

It's true that normally we go past these stages in cache-only, but that
is because normally (non-Soundwire) we already initialized the hardware
to good state during probe().
If we just carry on when it hasn't enumerated and we haven't initialized
it yet, who knows what will happen if it enumerates some time later.

We could just ignore it and see if anyone has a problem but for the sake
of a couple of lines of code I feel like I'd rather check for it.

> FWIW I don't see a startup callback in any other codec driver. It may be
> wrong but it's also a sign that this isn't a problem we've seen so far
> on existing Intel-based platforms.
>

It's nicer to do the check in startup() because then the application
open() will fail cleanly. We could delay until prepare - which is the
point we really need the hardware to be accessible - and hope the
hardware enumerated and initialized by that time. But that's not so
nice from the app point of view.

>>
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int cs42l42_sdw_dai_hw_params(struct snd_pcm_substream
>>>> *substream,
>>>> +                     struct snd_pcm_hw_params *params,
>>>> +                     struct snd_soc_dai *dai)
>>>> +{
>>>> +    struct cs42l42_private *cs42l42 =
>>>> snd_soc_component_get_drvdata(dai->component);
>>>> +    struct sdw_stream_runtime *sdw_stream =
>>>> snd_soc_dai_get_dma_data(dai, substream);
>>>> +    struct sdw_stream_config stream_config = {0};
>>>> +    struct sdw_port_config port_config = {0};
>>>> +    int ret;
>>>> +
>>>> +    if (!sdw_stream)
>>>> +        return -EINVAL;
>>>> +
>>>> +    /* Needed for PLL configuration when we are notified of new bus
>>>> config */
>>>> +    cs42l42->sample_rate = params_rate(params);
>>>
>>> wouldn't it be better to check if the sample_rate is supported by the
>>> PLL here, instead of in the .prepare step ...
>>>
>> It depends on the soundwire bus clock. We need to know both to determine
>> whether they are valid. IFF we can assume that the call to
>> sdw_stream_add_slave() will always invoke the bus_config() callback we
>> can call cs42l42_pll_config() from cs42l42_sdw_bus_config() and return
>> an error from cs42l42_sdw_bus_config() if the {swire_clk, sample_rate}
>> pair isn't valid.
> 
> You lost me here. Are you saying the soundwire bus clock is only known
> in the prepare stage?
>

hw_params() doesn't know the Soundwire bus clock so it can't do the
check. We need to wait until we have both the sample rate and the
chosen SWIRE_CLK.

I delayed it until prepare() because by that time the SWIRE_CLK must
have been chosen. and it avoids making an assumption about whether 
bus_config() will be called if the SWIRE_CLK hasn't changed.
If we move the cs42l42_pll_config() to the bus_config we must be sure
that
1) the bus_config() callback will be called from sdw_stream_add_slave().
(If bus_config() is only called when the machine driver prepares then
the check won't happen during hw_params phase.)

2) the bus_config must be called even if the SWIRE_CLK does not change,
so that we can reconsider our PLL config if the sample rate has changed.

If (1) and (2) are not guaranteed then moving the cs42l42_pll_config()
call to the bus_config() callback would be worse.

Putting it in prepare() means that hw_params() must have run and the
bus_config() callback has been called. And we don't care if bus_config()
was triggered by our hw_params or the machine driver. Also we don't
care if bus_config() wasn't called because the config hasn't changed.

In the end I'm not sure that it matters. Returning an error from
hw_params() won't re-run the ALSA constraint refinement. It's too late
by then because the params have already been accepted. The ACPI should
be configuring the Soundwire manager to only output valid SWIRE_CLK
frequencies for CS42L42, so we should never hit this error. But if we
come across a broken ACPI we have an error logged in dmesg to tell us
what went wrong, instead of a mysterious user complaint that their
audio is strange.

> 
>>>> +static int cs42l42_sdw_dai_set_sdw_stream(struct snd_soc_dai *dai,
>>>> void *sdw_stream,
>>>> +                      int direction)
>>>> +{
>>>> +    if (!sdw_stream)
>>>> +        return 0;
>>>> +
>>>> +    if (direction == SNDRV_PCM_STREAM_PLAYBACK)
>>>> +        dai->playback_dma_data = sdw_stream;
>>>> +    else
>>>> +        dai->capture_dma_data = sdw_stream;
>>>> +
>>>> +    return 0;
>>>
>>> Humm, this is interesting, you are not using the sdw_stream_data that
>>> all other codecs use, but in hindsight I have no idea why we allocate
>>> something to only store a pointer.
>>>
>>
>> Indeed. I can see no reason to wrap this pointer in another struct when
>> we can store the pointer direct so I dropped the wrapper struct.
> 
> I'll see if we can simplify the other codec drivers.
> 
>>>> +static int cs42l42_sdw_update_status(struct sdw_slave *peripheral,
>>>> +                     enum sdw_slave_status status);s
>>>> +{
>>>> +    struct cs42l42_private *cs42l42 =
>>>> dev_get_drvdata(&peripheral->dev);
>>>> +
>>>> +    switch (status) {
>>>> +    case SDW_SLAVE_ATTACHED:
>>>> +        dev_dbg(cs42l42->dev, "ATTACHED\n");
>>>> +        if (!cs42l42->init_done)
>>>> +            cs42l42_sdw_init(peripheral);
>>>
>>> unclear to me what happens is the bus suspends, how would you redo the
>>> init?
>>>
>>
>> We don't need to re-run the init(). A regcache_sync() will restore
>> settings.
> 
> ah, interesting. Other codec drivers play with specific registers that
> aren't in regmap. There's also headset calibration that's done
> differently in the first init or later.
