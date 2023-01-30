Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7CC682049
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjAaAA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAaAAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 19:00:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B9241EB;
        Mon, 30 Jan 2023 16:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675123219; x=1706659219;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NxMa5bJdffBaqxCEjJ47Ei59YQ+ioElnc5bDUaZ3lyo=;
  b=QL7vJMQLQIf0XXnhH1zojlO+tbUAc20VZhJZsEM4tlLnwORh1gtnInx6
   o0OLk9B6MnqxYaeOABX4zBH4AAH1OjhKbsQ8XvP9naKXLvwLuglKJ+ZBE
   hx9DwTmQ94et1dp3b1avRIuVewTPRXIykBLjgTWF+rH6ORMKjQC29pIyG
   omtTgwV1cgLFM18Dz/SDg46p4GUh89upF6CV4rxw4mX0JSvx/6gjYuXwE
   oSfzCG+AqMfXmvbaaPe7bQB8ajYgtb0H3YNhuiDqmlAI3jVBELCv1/HBL
   jDzFHdEUwx5zxiuhF1BhBWxcIhk1eWzNpdo0QmFsqX3Z/M13+fL2EWTbg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="327726698"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="327726698"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 16:00:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="614227900"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="614227900"
Received: from inuber-mobl5.amr.corp.intel.com (HELO [10.212.58.60]) ([10.212.58.60])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 16:00:15 -0800
Message-ID: <8f827e42-e5d8-1190-b5ae-2f99c71fbeee@linux.intel.com>
Date:   Mon, 30 Jan 2023 17:50:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v2 11/22] ASoC: qcom: Add USB backend ASoC driver for
 Q6
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-12-quic_wcheng@quicinc.com>
 <7f471960-0909-4680-e192-261d1fdfe6d7@linux.intel.com>
 <4a255518-6fbb-122a-ba97-1e995785c35f@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <4a255518-6fbb-122a-ba97-1e995785c35f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +static struct snd_soc_dai_driver q6usb_be_dais[] = {
>>> +    {
>>> +        .playback = {
>>> +            .stream_name = "USB BE RX",
>>> +            .rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
>>> +                SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
>>> +                SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
>>> +                SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
>>> +                SNDRV_PCM_RATE_192000,
>>> +            .formats = SNDRV_PCM_FMTBIT_S16_LE |
>>> SNDRV_PCM_FMTBIT_S16_BE |
>>> +                SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |
>>> +                SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
>>> +                SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_U24_BE,
>>> +            .channels_min = 1,
>>> +            .channels_max = 2,
>>> +            .rate_max =     192000,
>>> +            .rate_min =    8000,
>>> +        },
>>> +        .id = USB_RX,
>>> +        .name = "USB_RX_BE",
>>> +        .ops = &q6usb_ops,
>>> +    },
>>> +};
>>
>> ... here I see a single DAI, so presumably ONE endpoint can be supported?
>>
> 
> One USB audio device can be supported.
> one AFE port = one USB audio device
> 
>> I didn't see in the rest of the code how a card with multiple endpoint
>> would be rejected, nor how the capabilities are checked?
>>
> 
> Need to take a look at this query a bit more.  Let me try to pass in a
> format that can't be supported by the audio DSP, and see if the formats
> specified in this structure will not allow userspace to start the session.
> 
> When you say a "card with multiple endpoints" are you referring to a USB
> device that exposes multiple data (ISOC let's say) eps for its data
> interface?  I haven't run into a device like that.

A headset will typically only have two isoc endpoints for playback and
capture respectively, but while that's a very large market USB audio is
far from restricted to this configuration. It's not uncommon for the pro
or prosumer market to see devices with multiple input/output
capabilities and run-time mixing on the host.
