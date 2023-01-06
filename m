Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6377660A7A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjAFX5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAFX5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:57:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF0E7CDFF;
        Fri,  6 Jan 2023 15:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673049451; x=1704585451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8LdS9t0yq4kp8/qxDPocyWeBPXOL5MJctnMU27azrbs=;
  b=evIKAc08oWPugQU+ekdV1NgPexXoriqj6dmceF54d88rditxujI9qS1o
   tH1yrzUzf4PIvQjX01s+EUehEwVswZZbPNfJjowYCEBdMKBYFjGwGGFLS
   SMJG0LghyqlQIFxbmqGZarO0UjZ0n1K3T+P3ie0o2QqJYyImAinlr2wbB
   MGlW6eCcDmz/f3Icfw3e0UM+ybagjJ9+SUy0GsHDvliJBLFgK7aybMwQW
   hXQvrBTKjU9BYgsIQrobVFiChqV2KV0b3g9ZrJpn2kZMK+tNtPQlXYo13
   Y1GG0t1ammgaMZWxHehzWheHgGiN9f9bUAKewUKm2Kf8NduUt/2nDlueF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="387047014"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="387047014"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 15:57:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="984817911"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="984817911"
Received: from apbaezbo-mobl2.amr.corp.intel.com (HELO [10.212.60.153]) ([10.212.60.153])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 15:57:29 -0800
Message-ID: <3ecf7fbc-5640-ac99-e0f4-ccba310c103e@linux.intel.com>
Date:   Fri, 6 Jan 2023 09:57:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 00/14] Introduce QC USB SND audio offloading support
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <0991fdf5-a29d-6ef7-71ec-9b4d858ed1eb@linux.intel.com>
 <178892ad-091e-1d95-d9d9-7270f19ef4ef@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <178892ad-091e-1d95-d9d9-7270f19ef4ef@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> On 12/23/22 17:31, Wesley Cheng wrote:
>>> Several Qualcomm based chipsets can support USB audio offloading to a
>>> dedicated audio DSP, which can take over issuing transfers to the USB
>>> host controller.  The intention is to reduce the load on the main
>>> processors in the SoC, and allow them to be placed into lower power
>>> modes.
>>
>> It would be nice to clarify what you want to offload
>> a) audio data transfers for isoc ports
>> b) control for e.g. volume settings (those go to endpoint 0 IIRC)
>> c) Both?
>>
> 
> Thanks for sharing your experience, and inputs!
> 
> It would be the audio related endpoints only, so ISOC and potentially
> feedback ep.

That's good, that means there's a common basis for at least two separate
hardware implementations.
>> This has a lot of implications on the design. ASoC/DPCM is mainly
>> intended for audio data transfers, control is a separate problem with
>> configurations handled with register settings or bus-specific commands.
>>
> 
> Control would still be handled by the main processor.

Excellent, one more thing in common. Maintainers like this sort of
alignment :-)

>>> There are several parts to this design:
>>>    1. Adding ASoC binding layer
>>>    2. Create a USB backend for Q6DSP
>>>    3. Introduce XHCI interrupter support
>>>    4. Create vendor ops for the USB SND driver
>>>
>>> Adding ASoC binding layer:
>>> soc-usb: Intention is to treat a USB port similar to a headphone jack.
>>> The port is always present on the device, but cable/pin status can be
>>> enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
>>> communicate with USB SND.
>>>
>>> Create a USB backend for Q6DSP:
>>> q6usb: Basic backend driver that will be responsible for maintaining the
>>> resources needed to initiate a playback stream using the Q6DSP.  Will
>>> be the entity that checks to make sure the connected USB audio device
>>> supports the requested PCM format.  If it does not, the PCM open call
>>> will
>>> fail, and userpsace ALSA can take action accordingly.
>>>
>>> Introduce XHCI interrupter support:
>>> XHCI HCD supports multiple interrupters, which allows for events to
>>> be routed
>>> to different event rings.  This is determined by "Interrupter Target"
>>> field
>>> specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.
>>>
>>> Events in the offloading case will be routed to an event ring that is
>>> assigned
>>> to the audio DSP.

To the best of my knowledge this isn't needed on Intel platforms, but
that's something we would need to double-check.
>>> Create vendor ops for the USB SND driver:
>>> qc_audio_offload: This particular driver has several components
>>> associated
>>> with it:
>>> - QMI stream request handler
>>> - XHCI interrupter and resource management
>>> - audio DSP memory management
>>>
>>> When the audio DSP wants to enable a playback stream, the request is
>>> first
>>> received by the ASoC platform sound card.  Depending on the selected
>>> route,
>>> ASoC will bring up the individual DAIs in the path.  The Q6USB
>>> backend DAI
>>> will send an AFE port start command (with enabling the USB playback
>>> path), and
>>> the audio DSP will handle the request accordingly.
>>>
>>> Part of the AFE USB port start handling will have an exchange of control
>>> messages using the QMI protocol.  The qc_audio_offload driver will
>>> populate the
>>> buffer information:
>>> - Event ring base address
>>> - EP transfer ring base address
>>>
>>> and pass it along to the audio DSP.  All endpoint management will now
>>> be handed
>>> over to the DSP, and the main processor is not involved in transfers.
>>>
>>> Overall, implementing this feature will still expose separate sound
>>> card and PCM
>>> devices for both the platorm card and USB audio device:
>>>   0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>>>                        SM8250-MTP-WCD9380-WSA8810-VA-DMIC
>>>   1 [Audio          ]: USB-Audio - USB Audio
>>>                        Generic USB Audio at usb-xhci-hcd.1.auto-1.4,
>>> high speed
>>>
>>> This is to ensure that userspace ALSA entities can decide which route
>>> to take
>>> when executing the audio playback.  In the above, if card#1 is
>>> selected, then
>>> USB audio data will take the legacy path over the USB PCM drivers,
>>> etc...
>>
>> You would still need some sort of mutual exclusion to make sure the isoc
>> endpoints are not used concurrently by the two cards. Relying on
>> userspace intelligence to enforce that exclusion is not safe IMHO.
>>
> 
> Sure, I think we can make the USB card as being used if the offloading
> path is currently being enabled.  Kernel could return an error to
> userspace when this situation happens.

It's problematic for servers such as PipeWire/PulseAudio that open all
possible PCMs to figure out what they support in terms of formats. I am
not sure we can enforce a user-space serialization when discovering
capabilities?

> 
>> Intel looked at this sort of offload support a while ago and our
>> directions were very different - for a variety of reasons USB offload is
>> enabled on Windows platforms but remains a TODO for Linux. Rather than
>> having two cards, you could have a single card and addition subdevices
>> that expose the paths through the DSP. The benefits were that there was
>> a single set of controls that userspace needed to know about, and volume
>> settings were the same no matter which path you used (legacy or
>> DSP-optimized paths). That's consistent with the directions to use 'Deep
>> Buffer' PCM paths for local playback, it's the same idea of reducing
>> power consumption with optimized routing.
>>
> 
> Volume control would still be done through the legacy path as mentioned
> above.  For example, if a USB headset w/ a HID interface exposed (for
> volume control) was connected, those HID events would be routed to
> userspace to adjust volume accordingly on the main processor. (although
> you're right about having separate controls still present - one for the
> ASoC card and another for USB card)

The two sets of controls implied by the use of two cards is really
problematic IMHO. This adds complexity for userspace to figure out that
the controls are really the same and synchronize/mirror changes.

The premise of offload is that it should really not get in the way of
user-experience, design constructs that result in delayed starts/stop,
changed volumes or quality differences should be avoided, or
users/distros will disable this optimization.

One card with additional DSP-based PCM devices seems simpler to me in
terms of usage, but it's not without technical challenges either: with
the use of the ASoC topology framework we only know what the DSP
supports when registering a card and probing the ASoC components.

The interaction between USB audio and ASoC would also be at least as
complicated as display audio, in that it needs to work no matter what
the probe order is, and even survive the Linux device/driver model
requirement that there are no timing dependencies in the driver
bind/unbind sequences.

>> Another point is that there may be cases where the DSP paths are not
>> available if the DSP memory and MCPS budget is exceeded. In those cases,
>> the DSP parts needs the ability to notify userspace that the legacy path
>> should be used.
> 
> If we ran into this scenario, the audio DSP AFE port start command would
> fail, and this would be propagated to the userspace entity.  It could
> then potentially re-route to the legacy/non-offload path.

'start' or 'open'? This is a rather important design difference. Usually
we try to make decisions in the .open or .hw_params stage. The 'start'
or 'trigger' are usually not meant to fail due to unavailable resources
in ALSA.
>> Another case to handle is that some USB devices can handle way more data
>> than DSPs can chew, for example Pro audio boxes that can deal with 8ch
>> 192kHz will typically use the legacy paths. Some also handle specific
>> formats such as DSD over PCM. So it's quite likely that PCM devices for
>> card0 and card1 above do NOT expose support for the same formats, or put
>> differently that only a subset of the USB device capabilities are
>> handled through the DSP.
> 
> Same as the above.  We have programmed the USB backend to support the
> profiles that the audio DSP can handle.  I assume if there was any other
> request, the userspace entity would fail the PCM open for that requested
> profile.

What's not clear to me is whether there's any matching process between
the DSP capabilities and what the USB device exposes? if the USB device
is already way more complicated that what the ASoC back-end can deal
with, why expose a card?

>> And last, power optimizations with DSPs typically come from additional
>> latency helping put the SoC in low-power modes. That's not necessarily
>> ideal for all usages, e.g. for music recording and mixing I am not
>> convinced the DSP path would help at all.
>>
> 
> That's true.  At the same time, this feature is more for power related
> benefits, not specifically for performance. (although we haven't seen
> any performance related issues w/ this approach on the audio profiles
> the DSP supports)  I think if its an audio profile that supports a high
> sample rate and large number of channels, then the DSP wouldn't be able
> to support it anyway, and userspace could still use the legacy path.
> This would allow for those high-performance audio devices to not be
> affected.

ok, we are aligned as well here. Excellent. With the on-going work to
introduce 'Deep Buffer' capabilities, we'll have a need to tag PCM
devices with a usage or 'modifier', or have this information in
UCM/topology. Logic will have to be introduced in userspace to use the
best routing, I would think this work can be reused for USB cases to
indicate the offload solution is geared to power optimizations.
