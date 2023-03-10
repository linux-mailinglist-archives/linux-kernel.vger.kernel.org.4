Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA086B341F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCJCPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCJCPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:15:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E0E104627;
        Thu,  9 Mar 2023 18:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678414524; x=1709950524;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FAurejgzZDgiq4zpMgWd/d8Gh7qfzGeEBH4Wzs2K1W8=;
  b=eJjR95LNPBMxBXEfBKYwEUaAflaO1eSPkVAxOABh8eK6djOSxDBgKnXI
   ey6+f5LlYvZi21oIwbTEMvCg3EQX3KLCIn6TEQBNVxMZtO4qXzHNPc8pi
   MFBpYCkdsJr4PdzNX4J1Mh5/U9nHx+8xk1e69SD94XUMAlAYMiC+13yAM
   Oupp3zVcuiEHWTVV2wZZc5WrjoxIqulvv/KkoMVwESMbZ6U5oKyo2BL8D
   nn/ItkSGs990+AkvmpamoMuTH4fd8CPo6vfhQqoOra1/OL758WLwOa4YA
   vJ8qlRwOjvrd/ebrqg2P10vPrWkzGSIFCzPZfewAWy7BEo6ms3W5Nc0BW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="338988955"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="338988955"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 18:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="670935165"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="670935165"
Received: from hamannjo-mobl1.amr.corp.intel.com (HELO [10.255.34.234]) ([10.255.34.234])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 18:15:21 -0800
Message-ID: <a211f26d-a045-0729-871f-248d5fce3f3f@linux.intel.com>
Date:   Thu, 9 Mar 2023 18:37:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v3 00/28] Introduce QC USB SND audio offloading support
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <4f8a66c0-398f-5655-3aa7-a59bc9ba56cc@linux.intel.com>
 <8b2f3ce7-3e0c-bdf0-8d9f-9aeabba09a15@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <8b2f3ce7-3e0c-bdf0-8d9f-9aeabba09a15@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Create vendor ops for the USB SND driver:
>>> qc_audio_offload: This particular driver has several components
>>> associated
>>> with it:
>>> - QMI stream request handler
>>> - XHCI interrupter and resource management
>>> - audio DSP memory management
>>
>> so how does this 'qc_audio_offload' interface with 'q6usb' described
>> above? how are the roles different or complementary?
>>
> So in general you can think that the qc_audio_offload is a complement to
> the USB SND USB class driver, while q6usb is to ASoC.  Since the ASoC

Humm, that is far from clear. I don't get how a something that interacts
with the USB class driver can also be in charge of the audio DSP memory
management.

> framework doesn't have any communication with USB SND, the ASoC DPCM USB
> backend (q6usb) will have to be the entity that maintains what is going
> on in USB SND.  That way, sessions initiated through the ASoC managed
> sound card can evaluate what is available based on information reported
> by q6usb.
> 
> qc_audio_offload and q6usb will have some interaction between each
> other.  The majority of communication between qc_audio_offload and q6usb
> is reporting the device connection events.

It's already complicated to figure out how the DSP and USB class driver
might interact and probe/timing dependencies, but with two additional
drivers in the mix it's really hard to understand.

Maybe ascii-art would help describe the concepts and types of
information exchanged. Maintaining a consistent state across multiple
drivers is not an easy task.

> 
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
>> I already voiced my concerns about exposing two cards, each with their
>> own set of volume controls with the same device. It would be much better
>> to have an additional offloaded PCM device for card0...
>>
>> But if the consensus is to have two cards, it's still not clear how the
>> routing would be selected. In the case where there are two USB audio
>> devices attached, the offloaded path would only support one of the two.
>> How would userspace know which of the two is selected?
>>
> 
> With patch#24:
> https://lore.kernel.org/linux-usb/20230308235751.495-25-quic_wcheng@quicinc.com/T/#u
> 
> Now, userspace can at least choose which device it wants to offload.
> Part of doing that would mean userspace knows what USB SND card devices
> are available, so it is aware of which devices are shared (between the
> offload and USB SND path)
> 
>> And how would userspace know the difference anyways between two physical
>> devices attached to the platform with no offload, and one physical
>> device with one additional offload path? The names you selected can't be
>> used to identify that card1 is the optimized version of card0.
>>
> 
> Is userspace currently able to differentiate between cards that are
> created by USB SND versus ASoC?  How complex can the userspace card
> discovery be?  Can it query kcontrols at this point in time?  If so,
> maybe we can change the names of the newly added ones to reflect that it
> is an offload device?
> 
> SND kcontrol names are currently:
> Q6USB offload status
> Q6USB offload SND device select

I must admit I've never seen kcontrols being used to identify what the
card is, and in this case it's a pretend-card that's just an improved
version of another. It might be easier to use something else, such as
the component strings.
> 
>> Before we review low-level kernel plumbing, it would be good to give a
>> better overview of how userspace applications are supposed to interact
>> with the cards and identify the offloaded path. Testing with
>> tinyplay/tinymix is fine, but that's a developer-level or CI unit test.
>> we've got to see the broader picture of how a sound server would use
>> this USB offload capability.
> 
> Sure, I think that is fine.  I was hoping that at least adding some of
> the new kcontrols would help userspace make use of this path in general,
> but we can add more information if required.

Can I ask if this solution has been used with a complete userspace stack
already? I could see how this might be used with a relatively fixed
Android HAL, where the platform and routing are relatively controlled. I
don't see how a more generic audio server would deal with the discovery
and routing.

