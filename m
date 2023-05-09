Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2536FC646
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjEIM0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjEIM0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:26:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D34F40F7
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:26:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f42d937d61so1508325e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683635194; x=1686227194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJkrzczLXQ2vOsIEvj+HJWNbaauC+Ei52VybYLriynI=;
        b=fx1H6x9zUiGsH11fp6Aj8DDoUhRE5WEV/dqLlJR9z4JYOLnXGRXV2Lmm3OaSfY8FaQ
         pyeGF9f9bN93QT1EFwPTu4GXTzuFz/EMs644BQVf+veB1djyPqRdOoFETyyJujL/ggek
         j1bCJIuGVdZc7muiKrtTW/98pSzqo1+c6SRo55xWiqF7ezTanAZm+j72cWiRp2H3OpTZ
         zgFQm740zHefEgcdMbV5HmfzrHwZ4QCtwOiPJ4djvuP2RyeTqgM2WCxVDIx98MP/JpQr
         bmzBKhhZkjjW7Sq5zR90rkICzTVq/guzrHldcHIO73HqodQvx97y9Nto63FV7w1TAjlR
         g5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683635194; x=1686227194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJkrzczLXQ2vOsIEvj+HJWNbaauC+Ei52VybYLriynI=;
        b=a3Coltelq0GqaqAQsOkezzAzTjO4nlu3OfO3S5aMNvppoSlmfMpQKT1UJpbnLhjOC9
         YFxJmoM3mWKTphncVniHuc0EcsLXGokdmBBRHIqV8F3z9uwj4MFZ5thNE5Dobs+Ud31/
         pJlzMj2lcwChp9p7+0y/4wXEsq5twNmlvpM+SnRlR/VkP+QFSQxS1CiWQgFUAARz3DL8
         NiYa3eRm8PYSGHLTx5ZuJj6XamQ7b3rhr5WIyBKjKiihldf3b36AGp9nYZbvv4dxsGO+
         2pmHIDxa97xxrZfuL4Q/hFOCeszKJFHLyyaSWxh5TkAK5FI7DYIoUIHmZ5daGNFDjlOM
         TEOw==
X-Gm-Message-State: AC+VfDwnaVp3K086UnB/trSnW2bQ6ZrY/uxs66yEClLc8XrO17U3KNKp
        KEaLghEkgrj4VS4WGUH/JVW1MlvpP5NaXvtncIw=
X-Google-Smtp-Source: ACHHUZ72bk79+HSabo6iVnsvC4TpiytkhXT3xTqjg38X/qltYooTO2CJZ8gvQyj1tuTUbU4LIQwA3A==
X-Received: by 2002:a1c:c917:0:b0:3f1:76d7:ae2b with SMTP id f23-20020a1cc917000000b003f176d7ae2bmr9915789wmb.13.1683635193642;
        Tue, 09 May 2023 05:26:33 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k9-20020a05600c1c8900b003f4283f5c1bsm3063641wms.2.2023.05.09.05.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 05:26:33 -0700 (PDT)
Message-ID: <bb67f4b0-e96a-3718-f855-80e1d21e9d38@linaro.org>
Date:   Tue, 9 May 2023 13:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ASoC:codecs: lpass: Fix for KASAN use_after_free out of
 bounds
Content-Language: en-US
To:     Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
Cc:     Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230509103232.20953-1-quic_visr@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230509103232.20953-1-quic_visr@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2023 11:32, Ravulapati Vishnu Vardhan Rao wrote:
> When we run syzkaller we get below Out of Bounds error.
> 
> "KASAN: slab-out-of-bounds Read in regcache_flat_read"
> 
> Below is the backtrace of the issue:
> 
> BUG: KASAN: slab-out-of-bounds in regcache_flat_read+0x10c/0x110
> Read of size 4 at addr ffffff8088fbf714 by task syz-executor.4/14144
> CPU: 6 PID: 14144 Comm: syz-executor.4 Tainted: G        W
> Hardware name: Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+) (DT)
> Call trace:
> dump_backtrace+0x0/0x4ec
> show_stack+0x34/0x50
> dump_stack_lvl+0xdc/0x11c
> print_address_description+0x30/0x2d8
> kasan_report+0x178/0x1e4
> __asan_report_load4_noabort+0x44/0x50
> regcache_flat_read+0x10c/0x110
> regcache_read+0xf8/0x5a0
> _regmap_read+0x45c/0x86c
> _regmap_update_bits+0x128/0x290
> regmap_update_bits_base+0xc0/0x15c
> snd_soc_component_update_bits+0xa8/0x22c
> snd_soc_component_write_field+0x68/0xd4
> tx_macro_put_dec_enum+0x1d0/0x268
> snd_ctl_elem_write+0x288/0x474
> 
> By Error checking and checking valid values issue gets rectifies.
> 
> Signed-off-by: Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
> ---
>   sound/soc/codecs/lpass-tx-macro.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index da6fcf7f0991..2fc150b17f29 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -746,6 +746,8 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
>   	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
>   
>   	val = ucontrol->value.enumerated.item[0];
> +	if (val < 0 && val > 15)
> +		return -EINVAL;

how about

if (val >= e->items)
	return -EINVAL;


We could get these checks if CONFIG_SND_CTL_INTPUT_VALIDATION  was enabled.

>   
>   	switch (e->reg) {
>   	case CDC_TX_INP_MUX_ADC_MUX0_CFG0:
> @@ -772,6 +774,9 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
>   	case CDC_TX_INP_MUX_ADC_MUX7_CFG0:
>   		mic_sel_reg = CDC_TX7_TX_PATH_CFG0;
>   		break;
> +	default:
> +		dev_err(component->dev, "Error in configuration!!\n");
> +		return -EINVAL;
>   	}
>   
>   	if (val != 0) {
> @@ -785,10 +790,16 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
>   			snd_soc_component_write_field(component, mic_sel_reg,
>   						      CDC_TXn_ADC_DMIC_SEL_MASK, 1);
>   			dmic = TX_ADC_TO_DMIC(val);
> -			dmic_clk_reg = CDC_TX_TOP_CSR_SWR_DMICn_CTL(dmic);
> -			snd_soc_component_write_field(component, dmic_clk_reg,
> -						CDC_TX_SWR_DMIC_CLK_SEL_MASK,
> -						tx->dmic_clk_div);
> +			if (dmic < 4) {
> +				dmic_clk_reg = CDC_TX_TOP_CSR_SWR_DMICn_CTL(dmic);
> +				snd_soc_component_write_field(component, dmic_clk_reg,
> +							      CDC_TX_SWR_DMIC_CLK_SEL_MASK,
> +								tx->dmic_clk_div);
> +			} else {
> +				dev_err(component->dev, "Error in dmic configuration!!\n");
> +				return -EINVAL;
> +			}

These changes look unrelated.

--srini

> +
>   		}
>   	}
>   
