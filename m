Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F57660B08
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbjAGArD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGAq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:46:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEDDE7B;
        Fri,  6 Jan 2023 16:46:58 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3070k7M0023665;
        Sat, 7 Jan 2023 00:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lFP/Z8FJ+oBq6832PmNg9KZqQVlbURsTWsrh6CBwd4E=;
 b=frxX1ZPCS7v/cgsqXEJGKMYlnkNISCXgWYq3v45n4hIx+XhJ3sL8gAj1iyKIIGwl2ArG
 A0XYnmyJvT3uBTlY//gegWtpJ5pMiVBh8Hx79/dUT1I0vJOmecr1Byh8Ehn3pLJObw+x
 PETqmKPqVtqL8KGVmJ6GsJszNlt9xiI5EFdV1b90MhkoRsUwzv5OeD1Ug/1XAvjTPHj0
 CukLilm+xjGqxxQ4XDgBTof8xo+lCMxrJU2ptSxyHKKvur7m8505LXt/VvtgPK4HgIeO
 uuBgaqScHasjwEOHm1xYMQB2DTVlhGLEfS2aBmUy4VYAihcmSVhFBX7QEaVQwejMT6cH Wg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mxktt1dyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Jan 2023 00:46:07 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3070k6kG016035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Jan 2023 00:46:06 GMT
Received: from [10.110.74.54] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 6 Jan 2023
 16:46:04 -0800
Message-ID: <0d26311d-ed6a-edc5-f41d-93aa0da9314c@quicinc.com>
Date:   Fri, 6 Jan 2023 16:46:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 00/14] Introduce QC USB SND audio offloading support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <0991fdf5-a29d-6ef7-71ec-9b4d858ed1eb@linux.intel.com>
 <178892ad-091e-1d95-d9d9-7270f19ef4ef@quicinc.com>
 <3ecf7fbc-5640-ac99-e0f4-ccba310c103e@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <3ecf7fbc-5640-ac99-e0f4-ccba310c103e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Imq_wR8yTtkHlwWNeI2IzybahFDWHaMH
X-Proofpoint-ORIG-GUID: Imq_wR8yTtkHlwWNeI2IzybahFDWHaMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301070005
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 1/6/2023 7:57 AM, Pierre-Louis Bossart wrote:
> 
>>> On 12/23/22 17:31, Wesley Cheng wrote:
>>>> Several Qualcomm based chipsets can support USB audio offloading to a
>>>> dedicated audio DSP, which can take over issuing transfers to the USB
>>>> host controller.  The intention is to reduce the load on the main
>>>> processors in the SoC, and allow them to be placed into lower power
>>>> modes.
>>>
>>> It would be nice to clarify what you want to offload
>>> a) audio data transfers for isoc ports
>>> b) control for e.g. volume settings (those go to endpoint 0 IIRC)
>>> c) Both?
>>>
>>
>> Thanks for sharing your experience, and inputs!
>>
>> It would be the audio related endpoints only, so ISOC and potentially
>> feedback ep.
> 
> That's good, that means there's a common basis for at least two separate
> hardware implementations.
>>> This has a lot of implications on the design. ASoC/DPCM is mainly
>>> intended for audio data transfers, control is a separate problem with
>>> configurations handled with register settings or bus-specific commands.
>>>
>>
>> Control would still be handled by the main processor.
> 
> Excellent, one more thing in common. Maintainers like this sort of
> alignment :-)
> 
>>>> There are several parts to this design:
>>>>     1. Adding ASoC binding layer
>>>>     2. Create a USB backend for Q6DSP
>>>>     3. Introduce XHCI interrupter support
>>>>     4. Create vendor ops for the USB SND driver
>>>>
>>>> Adding ASoC binding layer:
>>>> soc-usb: Intention is to treat a USB port similar to a headphone jack.
>>>> The port is always present on the device, but cable/pin status can be
>>>> enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
>>>> communicate with USB SND.
>>>>
>>>> Create a USB backend for Q6DSP:
>>>> q6usb: Basic backend driver that will be responsible for maintaining the
>>>> resources needed to initiate a playback stream using the Q6DSP.  Will
>>>> be the entity that checks to make sure the connected USB audio device
>>>> supports the requested PCM format.  If it does not, the PCM open call
>>>> will
>>>> fail, and userpsace ALSA can take action accordingly.
>>>>
>>>> Introduce XHCI interrupter support:
>>>> XHCI HCD supports multiple interrupters, which allows for events to
>>>> be routed
>>>> to different event rings.  This is determined by "Interrupter Target"
>>>> field
>>>> specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.
>>>>
>>>> Events in the offloading case will be routed to an event ring that is
>>>> assigned
>>>> to the audio DSP.
> 
> To the best of my knowledge this isn't needed on Intel platforms, but
> that's something we would need to double-check.

I think Mathias mentioned that he was looking into adding some XHCI 
secondary interrupter support as well.  However, it did have some 
slightly different requirements compared to what this offloading feature 
is trying to do.

I'll first have to split up the XHCI/HCD changes into separate parts 
(interrupter specific and offloading specific), and then I'll work with 
him to see what can be improved from there.

>>>> Create vendor ops for the USB SND driver:
>>>> qc_audio_offload: This particular driver has several components
>>>> associated
>>>> with it:
>>>> - QMI stream request handler
>>>> - XHCI interrupter and resource management
>>>> - audio DSP memory management
>>>>
>>>> When the audio DSP wants to enable a playback stream, the request is
>>>> first
>>>> received by the ASoC platform sound card.  Depending on the selected
>>>> route,
>>>> ASoC will bring up the individual DAIs in the path.  The Q6USB
>>>> backend DAI
>>>> will send an AFE port start command (with enabling the USB playback
>>>> path), and
>>>> the audio DSP will handle the request accordingly.
>>>>
>>>> Part of the AFE USB port start handling will have an exchange of control
>>>> messages using the QMI protocol.  The qc_audio_offload driver will
>>>> populate the
>>>> buffer information:
>>>> - Event ring base address
>>>> - EP transfer ring base address
>>>>
>>>> and pass it along to the audio DSP.  All endpoint management will now
>>>> be handed
>>>> over to the DSP, and the main processor is not involved in transfers.
>>>>
>>>> Overall, implementing this feature will still expose separate sound
>>>> card and PCM
>>>> devices for both the platorm card and USB audio device:
>>>>    0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>>>>                         SM8250-MTP-WCD9380-WSA8810-VA-DMIC
>>>>    1 [Audio          ]: USB-Audio - USB Audio
>>>>                         Generic USB Audio at usb-xhci-hcd.1.auto-1.4,
>>>> high speed
>>>>
>>>> This is to ensure that userspace ALSA entities can decide which route
>>>> to take
>>>> when executing the audio playback.  In the above, if card#1 is
>>>> selected, then
>>>> USB audio data will take the legacy path over the USB PCM drivers,
>>>> etc...
>>>
>>> You would still need some sort of mutual exclusion to make sure the isoc
>>> endpoints are not used concurrently by the two cards. Relying on
>>> userspace intelligence to enforce that exclusion is not safe IMHO.
>>>
>>
>> Sure, I think we can make the USB card as being used if the offloading
>> path is currently being enabled.  Kernel could return an error to
>> userspace when this situation happens.
> 
> It's problematic for servers such as PipeWire/PulseAudio that open all
> possible PCMs to figure out what they support in terms of formats. I am
> not sure we can enforce a user-space serialization when discovering
> capabilities?
> 

I see...I'm not too familiar yet with all the different implementations 
from userspace yet, so that is something I'll need to look up on the 
side.  Takashi, would you happen to have any inputs with regards to how 
flexible PCM device selection can be from the userspace level?  If the 
offload PCM device can't be supported, can it fallback to another PCM 
device?

>>
>>> Intel looked at this sort of offload support a while ago and our
>>> directions were very different - for a variety of reasons USB offload is
>>> enabled on Windows platforms but remains a TODO for Linux. Rather than
>>> having two cards, you could have a single card and addition subdevices
>>> that expose the paths through the DSP. The benefits were that there was
>>> a single set of controls that userspace needed to know about, and volume
>>> settings were the same no matter which path you used (legacy or
>>> DSP-optimized paths). That's consistent with the directions to use 'Deep
>>> Buffer' PCM paths for local playback, it's the same idea of reducing
>>> power consumption with optimized routing.
>>>
>>
>> Volume control would still be done through the legacy path as mentioned
>> above.  For example, if a USB headset w/ a HID interface exposed (for
>> volume control) was connected, those HID events would be routed to
>> userspace to adjust volume accordingly on the main processor. (although
>> you're right about having separate controls still present - one for the
>> ASoC card and another for USB card)
> 
> The two sets of controls implied by the use of two cards is really
> problematic IMHO. This adds complexity for userspace to figure out that
> the controls are really the same and synchronize/mirror changes.
>  > The premise of offload is that it should really not get in the way of
> user-experience, design constructs that result in delayed starts/stop,
> changed volumes or quality differences should be avoided, or
> users/distros will disable this optimization.
>

Makes sense.  I think in terms of controls, we know that for an USB 
audio device, anything will still be handled through the USB card. 
Again, since I'm not too familiar yet with all the userspace 
implementations, does it have mechanisms to treat the control and data 
interfaces separately?

> One card with additional DSP-based PCM devices seems simpler to me in
> terms of usage, but it's not without technical challenges either: with
> the use of the ASoC topology framework we only know what the DSP
> supports when registering a card and probing the ASoC components.
> 
> The interaction between USB audio and ASoC would also be at least as
> complicated as display audio, in that it needs to work no matter what
> the probe order is, and even survive the Linux device/driver model
> requirement that there are no timing dependencies in the driver
> bind/unbind sequences.
> 

Yes, this was my initial approach as well, but from the technical 
perspective it was very very messy, and potentially could have affected 
functionality on certain devices if not handled correctly.  I think the 
difficult part was that the USB SND framework itself is an independent 
entity, and it was tough to dissect the portions which created PCM/sound 
card devices.

I don't think that was something which would have gone well if 
introduced all at once.  It would require a lot of discussion before 
getting the proper implementation.  At least this series introduces the 
initial communication between ASoC and USB SND, and maybe as use cases 
become clearer we can always improve/build on top of it.

>>> Another point is that there may be cases where the DSP paths are not
>>> available if the DSP memory and MCPS budget is exceeded. In those cases,
>>> the DSP parts needs the ability to notify userspace that the legacy path
>>> should be used.
>>
>> If we ran into this scenario, the audio DSP AFE port start command would
>> fail, and this would be propagated to the userspace entity.  It could
>> then potentially re-route to the legacy/non-offload path.
> 
> 'start' or 'open'? This is a rather important design difference. Usually
> we try to make decisions in the .open or .hw_params stage. The 'start'
> or 'trigger' are usually not meant to fail due to unavailable resources
> in ALSA.

This happens during the .prepare() phase.

>>> Another case to handle is that some USB devices can handle way more data
>>> than DSPs can chew, for example Pro audio boxes that can deal with 8ch
>>> 192kHz will typically use the legacy paths. Some also handle specific
>>> formats such as DSD over PCM. So it's quite likely that PCM devices for
>>> card0 and card1 above do NOT expose support for the same formats, or put
>>> differently that only a subset of the USB device capabilities are
>>> handled through the DSP.
>>
>> Same as the above.  We have programmed the USB backend to support the
>> profiles that the audio DSP can handle.  I assume if there was any other
>> request, the userspace entity would fail the PCM open for that requested
>> profile.
> 
> What's not clear to me is whether there's any matching process between
> the DSP capabilities and what the USB device exposes? if the USB device
> is already way more complicated that what the ASoC back-end can deal
> with, why expose a card?
> 

That's something I thought was done by the ASoC core.  I can check that 
and see if that's the case.  There is a check added in hw_params of our 
ASoC component where we do query the USB audio descriptors to ensure 
that the PCM format being used is supported by the device.  I guess this 
is when the DSP capabilities are better than what the headset can 
support :).

>>> And last, power optimizations with DSPs typically come from additional
>>> latency helping put the SoC in low-power modes. That's not necessarily
>>> ideal for all usages, e.g. for music recording and mixing I am not
>>> convinced the DSP path would help at all.
>>>
>>
>> That's true.  At the same time, this feature is more for power related
>> benefits, not specifically for performance. (although we haven't seen
>> any performance related issues w/ this approach on the audio profiles
>> the DSP supports)  I think if its an audio profile that supports a high
>> sample rate and large number of channels, then the DSP wouldn't be able
>> to support it anyway, and userspace could still use the legacy path.
>> This would allow for those high-performance audio devices to not be
>> affected.
> 
> ok, we are aligned as well here. Excellent. With the on-going work to
> introduce 'Deep Buffer' capabilities, we'll have a need to tag PCM
> devices with a usage or 'modifier', or have this information in
> UCM/topology. Logic will have to be introduced in userspace to use the
> best routing, I would think this work can be reused for USB cases to
> indicate the offload solution is geared to power optimizations.

Great, I like that idea to see if we can help userspace choose the 
desired path based on what the overall system is looking for.  I wonder 
if that would also potentially help with some of the PCM device 
selection complexities you brought up as well.  If the system just wants 
best possible performance then it would just completely ignore the power 
optimized (offload) path for any device.

Thanks
Wesley Cheng
