Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE7660A7E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbjAFX5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjAFX5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:57:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2327D9DF;
        Fri,  6 Jan 2023 15:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673049453; x=1704585453;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5YAuWiDjAal/uJrXM9ILONLLrQCsDzm/BE7yygN0SAs=;
  b=AcRFq5yy28m0IpgQ+f0CHsnrCj0ThOcCS0NyE7V04ZgJm7/u8oM+EkeR
   cPcXG5afbBapJzAI35nirukYnZ/6i5/rKhoIjpTUUbfnAm+If0hzuvOyD
   YPFV/U59wKyz7MUtgMKhNQvbZrVQUGUY331M55O5xOZVQ+PGS5K1+5SZH
   IovJjpMB/YPRv11uA0OxWKst/GZGctdzw02z9+sVQX89551Zp5szHRmaT
   bFvuHGBb4N85S9ACV8+CfebgKdLqoqt8MsbIPfh9+LAjIZPLvjc9D6tfm
   Jc3hj0vIJuFNaP9GLUluFxSswFKkj0KHmCSGPMv5JkyJFjBCxaeQmnXou
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="387047027"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="387047027"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 15:57:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="984817926"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="984817926"
Received: from apbaezbo-mobl2.amr.corp.intel.com (HELO [10.212.60.153]) ([10.212.60.153])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 15:57:31 -0800
Message-ID: <65820e0e-be8b-c574-98d0-a2e60ee4be76@linux.intel.com>
Date:   Fri, 6 Jan 2023 10:09:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 02/14] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
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
 <20221223233200.26089-3-quic_wcheng@quicinc.com>
 <5babccd6-9796-7613-cf82-cc859f338448@linux.intel.com>
 <6e13521a-84bf-f8a6-e8cc-5b90ff4bd675@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <6e13521a-84bf-f8a6-e8cc-5b90ff4bd675@quicinc.com>
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


>>> The QC ADSP is able to support USB playback and capture, so that the
>>> main application processor can be placed into lower CPU power modes. 
>>> This
>>> adds the required AFE port configurations and port start command to
>>> start
>>> an audio session.
>>
>> It would be good to clarify what sort of endpoints can be supported. I
>> presume the SOF-synchronous case is handled, but how would you deal with
>> async endpoints with feedback (be it explicit or implicit)?
>>
> 
> Sure, both types of feedback endpoints are expected to be supported by
> the audio DSP, as well as sync eps.  We have the logic there to modify
> the audio sample size accordingly.

did you mean modify samples per USB frame (or uframe), so as to change
the pace at which data is transferred? If yes it'd be the same for Intel.

>>>     static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
>>> +    {"USB Playback", NULL, "USB_RX"},
>>
>> ... but here RX means playback?
>>
>> I am not sure I get the convention on directions and what is actually
>> supported?
>>
> 
> The notation is based on the direction of which the audio data is
> sourced or pushed on to the DSP.  So in playback, the DSP is receiving
> audio data to send, and capture, it is transmitting audio data received.
> (although we do not support capture yet)

ok, it'd be good to add a comment on this convention. Usually RX/TX is
bus-centric.

> 
>>> +struct afe_param_id_usb_cfg {
>>> +/* Minor version used for tracking USB audio device configuration.
>>> + * Supported values: AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
>>> + */
>>> +    u32                  cfg_minor_version;
>>> +/* Sampling rate of the port.
>>> + * Supported values:
>>> + * - AFE_PORT_SAMPLE_RATE_8K
>>> + * - AFE_PORT_SAMPLE_RATE_11025
>>> + * - AFE_PORT_SAMPLE_RATE_12K
>>> + * - AFE_PORT_SAMPLE_RATE_16K
>>> + * - AFE_PORT_SAMPLE_RATE_22050
>>> + * - AFE_PORT_SAMPLE_RATE_24K
>>> + * - AFE_PORT_SAMPLE_RATE_32K
>>> + * - AFE_PORT_SAMPLE_RATE_44P1K
>>> + * - AFE_PORT_SAMPLE_RATE_48K
>>> + * - AFE_PORT_SAMPLE_RATE_96K
>>> + * - AFE_PORT_SAMPLE_RATE_192K
>>> + */
>>> +    u32                  sample_rate;
>>> +/* Bit width of the sample.
>>> + * Supported values: 16, 24
>>> + */
>>> +    u16                  bit_width;
>>> +/* Number of channels.
>>> + * Supported values: 1 and 2
>>
>> that aligns with my feedback on the cover letter, if you connect a
>> device that can support from than 2 channels should the DSP even expose
>> this DSP-optimized path?
>>
> 
> My assumption is that I programmed the DAIs w/ PCM formats supported by
> the DSP, so I think the ASoC core should not allow userspace to choose
> that path if the hw params don't fit/match.

Right, but the point I was trying to make is that if the device can do
more, why create this DSP path at all?

> 
>> Oh and I forgot, what happens if there are multiple audio devices
>> connected, can the DSP deal with all of them? If not, how is this
>> handled?
>>
> 
> This is one topic that we were pretty open ended on.  At least on our
> implementation, only one audio device can be supported at a time.  We
> choose the latest device that was plugged in or discovered by the USB
> SND class driver.

Similar case for Intel. I have to revisit this, I don't recall the details.

>>> +    u32                  dev_token;
>>> +/* endianness of this interface */
>>> +    u32                   endian;
>>
>> Is this a USB concept? I can't recall having seen any parts of the USB
>> audio class spec that the data can be big or little endian?
>>
> 
> No, this is probably just something our audio DSP uses on the AFE
> commands that it receives.

ok.


