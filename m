Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CF16B1E23
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCIIbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCIIbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:31:20 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC8DE1FE9;
        Thu,  9 Mar 2023 00:29:30 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C6EB95C011B;
        Thu,  9 Mar 2023 03:29:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 09 Mar 2023 03:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1678350564; x=
        1678436964; bh=Oa/m0zQYb/9cVTdeBVWVrncsae/cjF8bU6ixcrep6N4=; b=e
        qVYCC9RU0vIhMD5Svk+mwY3qm4EVGZTIab4j6DZukQqwvwu2I1pyhisx49mTBNoB
        R10G6H51ISsyWkQPpBgIxKblcyiBGNnPVEWUpmRmqpWh7f/fZ91qC4v9LKUrdpVp
        HBamGmLwZUbyzgputxPsokvu6kgsr7BKCydBeUNwYWhFJmp4Fk+HdS6s6tA+Xy0M
        Sc/mA0N76oy/iVS+h2dUapqTnwjuz9YHREc8EgvfQggAH6kA68u73jBBtC8OjrE5
        N6gOeymg+oxGI5sLLdlKzbfgFE1ChBjrINZWwPWsiF/AlVcdgi83FvtshQ1j2XN5
        HwjMCHhDS/ShYpSi1sXXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678350564; x=1678436964; bh=Oa/m0zQYb/9cV
        TdeBVWVrncsae/cjF8bU6ixcrep6N4=; b=Ioqvy6L3B/96WajH3znnyMdgmvN8d
        BO7IuUE1hotFCXXb0JVbvD6AZdHPXKk7utAaxjrKtLdbpLYsvDBoYrhFxsjfY+OZ
        1FE2G5iGup3RImVIQTAE0JJZYhVuo07SpLTYAlXufav8g2NhRa5ygpMXzxJubwcZ
        A6f+Fu8VdYVqHrX5mZXDcvS4mdkKx4M5cWogSKNP50r/LB5ciPUFpMrZas/JbNEC
        GRvw1M5l1/9BZT6BmxR50Xpay9B9GO+wMzXH/zDeVgQL4Z4k5KyfG4BAJ3lpuraJ
        7chNcYChY48yu5h6VflcRX1tuNjJGR7dM8eBE5VD1cRYiq9EehhV8PJsA==
X-ME-Sender: <xms:45gJZMD909XJ-PoqR9DIkjmKJEXf78pqI7VYcRhUBA2vg6wYbNK6Sw>
    <xme:45gJZOimMzZGiYfDOaLZvCJiOfRymLFqloMZ9cd7n1hS-l68hqYtGQlvsjk29U_-W
    gZq9O0Bc_iNOpE9wfE>
X-ME-Received: <xmr:45gJZPnYMoHP3vjuz8G_oW_SGg_ztjOOiozXDDjd_jwFisTVArN3EH27aXz2MyOfjILb6MO4EOFrDY-45Y6MdRYycg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduhedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:5JgJZCyEBeozrJeyqOW8CopBZ22mKWSpCRTRDwQaL8YENXfNAM8dGw>
    <xmx:5JgJZBST7NUjtlUOOiQKRuZYQSjlmkLz-RE_o19_QXi7cuz5QkXeNA>
    <xmx:5JgJZNYzNRG2m6sgw-WyqE3e_cxozLpCp-Mrq5Wg3NcU0QNkAFLTAw>
    <xmx:5JgJZDlmIRE7__MNBhjrnyTEgUTxP45cnnIWJKH0QqxKnXfglyZLpQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Mar 2023 03:29:20 -0500 (EST)
Date:   Thu, 9 Mar 2023 17:29:18 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [PATCH v3 15/28] sound: usb: Introduce QC USB SND offloading
 support
Message-ID: <20230309082918.GA220616@workstation>
Mail-Followup-To: Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-16-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308235751.495-16-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 08, 2023 at 03:57:38PM -0800, Wesley Cheng wrote:
> diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
> new file mode 100644
> index 000000000000..2663906644f2
> --- /dev/null
> +++ b/sound/usb/qcom/qc_audio_offload.c
> ...
> +static int enable_audio_stream(struct snd_usb_substream *subs,
> +				snd_pcm_format_t pcm_format,
> +				unsigned int channels, unsigned int cur_rate,
> +				int datainterval)
> +{
> +	struct snd_usb_audio *chip = subs->stream->chip;
> +	struct snd_pcm_hw_params params;
> +	const struct audioformat *fmt;
> +	int ret;
> +	bool fixed_rate;
> +
> +	_snd_pcm_hw_params_any(&params);
> +	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_FORMAT,
> +			(__force int) pcm_format, 0);
> +	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_CHANNELS,
> +			channels, 0);
> +	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_RATE,
> +			cur_rate, 0);

I think the above code is equivalent to below code.

```
// 1. Initialize the hardware parameter so that it expresses
// the maximum flags of mask parameters and the maximum range of integer
// parameters.
_snd_pcm_hw_params_any(&params);

// 2. Then shrink the mask parameters and integer parameters.
struct snd_mask *mask;
struct snd_interval *interval;

mask = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
snd_mask_leave(mask, pcm_format);

interval = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
snd_interval_setinteger(&interval);
interval.min = interval.max = channels;

interval = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
snd_interval_setinteger(&interval);
interval.min = interval.max = cur_rate;
```

In '[PATCH v3 10/28] sound: usb: Export USB SND APIs for modules', some
codes moved from ALSA Open Sound System compatibility layer to ALSA core
to export some kernel APIs. The '_snd_pcm_hw_param_set()' is one of
them. If they were needed just for the above operations, it would be
exaggerating just for the driver.

Of course, we can assume that the similar kernel API would be required
for the other drivers (OSS PCM, USB gadget, and so on.). However, at
present, it is preferable to focus just on your driver. 

(I note that typical sound PCM driver has code to shrink hardware
parameters in PCM rule. It consists of a set of test and refine API.)


Regards

Takashi Sakamoto
