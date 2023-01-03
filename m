Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A1265BEA3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbjACLIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbjACLIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:08:46 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF1010E3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:08:45 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z26so45177952lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BS0JkwlA994b8gDT8ijmzGitBJGDV2ohc6oOypmPs6s=;
        b=np87eWRWakZKR/jOiuZJH+DoznqVDr/X6lVSAYal5LvDyQVolQFJ8xIcUMFWAdprBK
         k05urcpcoJL7W7xw8FQnYq0+bXyWtQw8Q7fqvQIWv9NvYq63zZ4zJPde0zMDaqOAUc1h
         hjmBpq3BqhgungABi44MJu54bixVGToCVZ/A5TutCSJ83HIMvy/2dHKF0QHf9UTpNEGl
         J/7K6nA3TLpJbx7N/sNGfQJlXbcJ2qphY4xl6cIvKO3Dss1qNGYqCx6kqckVWIQ/PB98
         PwEn4b5rHo/vM0d7llFjmSwXmKIL4MnpwfZhUpPyRVhqQtprFKUi8VRPDCMMTPERwvqm
         WUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BS0JkwlA994b8gDT8ijmzGitBJGDV2ohc6oOypmPs6s=;
        b=vK41XecO+aHEv2W4ZAID8TuFskZ48vFq1J4CB10/SyveQq9xWgeUrDUu4B4lSuMxw3
         7BRfgzQlLXWYwm9gMvf2/0jNoOY9rKvDUI4EP54oNxNcDbh9sIUCMdoFBdqbdj8deCxQ
         p9YbvRAN2kfNAFTCQXndM8GX9kQYnGszn9j40b1pq37g4eBwu6ZiJuLCH6/V7LtN6zwR
         ODOhek0wH68Nbj8aAFOFkodz1LQ3utG8cFapsQw4FZwXLzinV5KW3m2AyyKobVOkk3Ny
         7v6zDw3PXtuaer14LVbrAgFUnx0G1e9y3VawbMfYKAsfgvCIxZj1gQPtQdlcaqxejQKp
         g3xA==
X-Gm-Message-State: AFqh2kqQfTyVeTRyLSLYVpH8nbt65rz9t4r6sDD3gOJ0p2FwSc1bJ2FR
        8OE8s9aQVqwiedKkjchcx+rZcw==
X-Google-Smtp-Source: AMrXdXuonf6hj66exXU1xiu8uK2tdafKJa6v2G8LwY7oa7jLfWKhxOIjluFgkcYqpwExmL2xDOY7bA==
X-Received: by 2002:a05:6512:24e:b0:4b5:82f1:7f3d with SMTP id b14-20020a056512024e00b004b582f17f3dmr20058836lfo.58.1672744123454;
        Tue, 03 Jan 2023 03:08:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k1-20020ac257c1000000b004b55ca53543sm4785669lfo.233.2023.01.03.03.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 03:08:42 -0800 (PST)
Message-ID: <0cb682bd-7f1b-009d-6f1a-1a5a46366fe8@linaro.org>
Date:   Tue, 3 Jan 2023 12:08:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/5] ASoC: samsung: i2s: add support for FSD I2S
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
 <CGME20230103045655epcas5p1af06a83208190c471e8cd891ef4760f3@epcas5p1.samsung.com>
 <20230103045613.100309-3-p.rajanbabu@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103045613.100309-3-p.rajanbabu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 05:56, Padmanabhan Rajanbabu wrote:
> Add support for enabling I2S controller on FSD platform.
> 
> FSD I2S controller is based on Exynos7 I2S controller, supporting
> 2CH playback/capture in I2S mode and 7.1CH playback/capture in TDM
> mode.
> 
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> ---
>  sound/soc/samsung/i2s-regs.h |  1 +
>  sound/soc/samsung/i2s.c      | 57 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
> index b4b5d6053503..4444c857d0c0 100644
> --- a/sound/soc/samsung/i2s-regs.h
> +++ b/sound/soc/samsung/i2s-regs.h
> @@ -132,6 +132,7 @@
>  #define EXYNOS7_MOD_RCLK_192FS	7
>  
>  #define PSR_PSREN		(1 << 15)
> +#define PSR_PSVAL(x)		(((x - 1) << 8) & 0x3f00)
>  
>  #define FIC_TX2COUNT(x)		(((x) >>  24) & 0xf)
>  #define FIC_TX1COUNT(x)		(((x) >>  16) & 0xf)
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index 9505200f3d11..dcb5c438cb2f 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -50,6 +50,10 @@ struct samsung_i2s_dai_data {
>  	u32 quirks;
>  	unsigned int pcm_rates;
>  	const struct samsung_i2s_variant_regs *i2s_variant_regs;
> +	void (*fixup_early)(struct snd_pcm_substream *substream,
> +					struct snd_soc_dai *dai);
> +	void (*fixup_late)(struct snd_pcm_substream *substream,
> +					struct snd_soc_dai *dai);
>  };
>  
>  struct i2s_dai {
> @@ -111,6 +115,10 @@ struct samsung_i2s_priv {
>  	u32 suspend_i2spsr;
>  
>  	const struct samsung_i2s_variant_regs *variant_regs;
> +	void (*fixup_early)(struct snd_pcm_substream *substream,
> +						struct snd_soc_dai *dai);
> +	void (*fixup_late)(struct snd_pcm_substream *substream,
> +						struct snd_soc_dai *dai);
>  	u32 quirks;
>  
>  	/* The clock provider's data */
> @@ -940,6 +948,10 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		pm_runtime_get_sync(dai->dev);
> +
> +		if (priv->fixup_early)
> +			priv->fixup_early(substream, dai);
> +
>  		spin_lock_irqsave(&priv->lock, flags);
>  
>  		if (config_setup(i2s)) {
> @@ -947,6 +959,13 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
>  			return -EINVAL;
>  		}
>  

Except several warnings this patch generates, this is a bit surprising:

> +		spin_unlock_irqrestore(&priv->lock, flags);

You have critical section which you now break into two. You cannot do
this usually. How the synchronization is now kept?

> +
> +		if (priv->fixup_late)
> +			priv->fixup_late(substream, dai);
> +
> +		spin_lock_irqsave(&priv->lock, flags);
> +
>  		if (capture)
>  			i2s_rxctrl(i2s, 1);
>  		else

Best regards,
Krzysztof

