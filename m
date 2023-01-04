Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3B65E12B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjADX7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjADX7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:59:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC2943187;
        Wed,  4 Jan 2023 15:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672876754; x=1704412754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3xkgJ3CRSrpi2FIgfZy5JtMvByFVAneG7IfF27leIOM=;
  b=TU3tYnUP0gzDcRYjz+QJOAaQ28muTEbuJ0HoHEeEAqWW7MkjGgSj0qIX
   W4ND/05jgUONMFiWkJVyFXEou15zX+v6pH7/SW8fEzocOhI9oHWHgnFeA
   AXE6YuaoLXAN/8NSZt6qicr2vEQ+tQGm7CDrXiiieIhoOi9JyKQM4Gqo0
   xhCwnpwtJqvmLy4iOzQzVL6zoYN/pXOH42bvF0nSYrXDjCfFaUM2uJwvs
   8PaDitGwnQkNqxuXofu+4qI6iX39OoAcIZ8Rt1sCiaKV5dVQZaTNH8zE5
   6QKByGP0CBp3SGY/XRy8BsPmcOkkJuUOJqte+XBNh2cNKf3E2BbrcYLlR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="323306051"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="323306051"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 15:58:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900745323"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="900745323"
Received: from kvthalli-mobl1.amr.corp.intel.com (HELO [10.212.102.90]) ([10.212.102.90])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 15:58:45 -0800
Message-ID: <0991fdf5-a29d-6ef7-71ec-9b4d858ed1eb@linux.intel.com>
Date:   Wed, 4 Jan 2023 17:19:10 -0600
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221223233200.26089-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/22 17:31, Wesley Cheng wrote:
> Several Qualcomm based chipsets can support USB audio offloading to a
> dedicated audio DSP, which can take over issuing transfers to the USB
> host controller.  The intention is to reduce the load on the main
> processors in the SoC, and allow them to be placed into lower power modes.

It would be nice to clarify what you want to offload
a) audio data transfers for isoc ports
b) control for e.g. volume settings (those go to endpoint 0 IIRC)
c) Both?

This has a lot of implications on the design. ASoC/DPCM is mainly
intended for audio data transfers, control is a separate problem with
configurations handled with register settings or bus-specific commands.

> There are several parts to this design:
>   1. Adding ASoC binding layer
>   2. Create a USB backend for Q6DSP
>   3. Introduce XHCI interrupter support
>   4. Create vendor ops for the USB SND driver
> 
> Adding ASoC binding layer:
> soc-usb: Intention is to treat a USB port similar to a headphone jack.
> The port is always present on the device, but cable/pin status can be
> enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
> communicate with USB SND.
> 
> Create a USB backend for Q6DSP:
> q6usb: Basic backend driver that will be responsible for maintaining the
> resources needed to initiate a playback stream using the Q6DSP.  Will
> be the entity that checks to make sure the connected USB audio device
> supports the requested PCM format.  If it does not, the PCM open call will
> fail, and userpsace ALSA can take action accordingly.
> 
> Introduce XHCI interrupter support:
> XHCI HCD supports multiple interrupters, which allows for events to be routed
> to different event rings.  This is determined by "Interrupter Target" field
> specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.
> 
> Events in the offloading case will be routed to an event ring that is assigned
> to the audio DSP.
> 
> Create vendor ops for the USB SND driver:
> qc_audio_offload: This particular driver has several components associated
> with it:
> - QMI stream request handler
> - XHCI interrupter and resource management
> - audio DSP memory management
> 
> When the audio DSP wants to enable a playback stream, the request is first
> received by the ASoC platform sound card.  Depending on the selected route,
> ASoC will bring up the individual DAIs in the path.  The Q6USB backend DAI
> will send an AFE port start command (with enabling the USB playback path), and
> the audio DSP will handle the request accordingly.
> 
> Part of the AFE USB port start handling will have an exchange of control
> messages using the QMI protocol.  The qc_audio_offload driver will populate the
> buffer information:
> - Event ring base address
> - EP transfer ring base address
> 
> and pass it along to the audio DSP.  All endpoint management will now be handed
> over to the DSP, and the main processor is not involved in transfers.
> 
> Overall, implementing this feature will still expose separate sound card and PCM
> devices for both the platorm card and USB audio device:
>  0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>                       SM8250-MTP-WCD9380-WSA8810-VA-DMIC
>  1 [Audio          ]: USB-Audio - USB Audio
>                       Generic USB Audio at usb-xhci-hcd.1.auto-1.4, high speed
> 
> This is to ensure that userspace ALSA entities can decide which route to take
> when executing the audio playback.  In the above, if card#1 is selected, then
> USB audio data will take the legacy path over the USB PCM drivers, etc...

You would still need some sort of mutual exclusion to make sure the isoc
endpoints are not used concurrently by the two cards. Relying on
userspace intelligence to enforce that exclusion is not safe IMHO.

Intel looked at this sort of offload support a while ago and our
directions were very different - for a variety of reasons USB offload is
enabled on Windows platforms but remains a TODO for Linux. Rather than
having two cards, you could have a single card and addition subdevices
that expose the paths through the DSP. The benefits were that there was
a single set of controls that userspace needed to know about, and volume
settings were the same no matter which path you used (legacy or
DSP-optimized paths). That's consistent with the directions to use 'Deep
Buffer' PCM paths for local playback, it's the same idea of reducing
power consumption with optimized routing.

Another point is that there may be cases where the DSP paths are not
available if the DSP memory and MCPS budget is exceeded. In those cases,
the DSP parts needs the ability to notify userspace that the legacy path
should be used.

Another case to handle is that some USB devices can handle way more data
than DSPs can chew, for example Pro audio boxes that can deal with 8ch
192kHz will typically use the legacy paths. Some also handle specific
formats such as DSD over PCM. So it's quite likely that PCM devices for
card0 and card1 above do NOT expose support for the same formats, or put
differently that only a subset of the USB device capabilities are
handled through the DSP.

And last, power optimizations with DSPs typically come from additional
latency helping put the SoC in low-power modes. That's not necessarily
ideal for all usages, e.g. for music recording and mixing I am not
convinced the DSP path would help at all.

> This feature was validated using:
> - tinymix: set/enable the multimedia path to route to USB backend
> - tinyplay: issue playback on platform card
