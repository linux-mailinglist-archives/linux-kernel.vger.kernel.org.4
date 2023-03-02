Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B166A8228
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCBM2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCBM2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:28:38 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82176E99
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:28:32 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id g18so15274604ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 04:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677760111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QM9EzJ59d7bm12hYRBG6XOMDXAxFr+3VVIYgcW52hKU=;
        b=lZIUY2xO9crjBnBglCG+jmfXGploPGWLi1NjlFyOGpVzQWKyDoe2m9nYrRtGHt/MwU
         dGInHAH7wJx4Moi5TU1b0FoUn/6CpIc5ps0vqd+x3ta3xLYndI6VZoplvuQS6LfAo0mZ
         8oYOb87lL2GqISnfyNi+xK7+ocr6kLZQ0Ha59By7OexU2iweDROpWTcXfwq7ss5VDaJk
         +6GPno+LQxqgemVcxPHFMWOCCYQ2D82FDhf3ug6ZmB4eVC4BeN+7xGCyZ/DLxXTedkb1
         1fGVnf8vxxlOdxy0QXukySqts6C+/0m/EzEArj75MDF4LGwgoJkn+/p982GXyAudP/7o
         rTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677760111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QM9EzJ59d7bm12hYRBG6XOMDXAxFr+3VVIYgcW52hKU=;
        b=cFXOPCIVBIeBXLC3LJSm/MbcE4hNskN5VuQHBBR/WkGmJeFKhU+0QfiGgg4VqkVAQc
         cv94M8ekwP36L2hvBSZaxjjvRfNTlTyuEJsN8KjliYBLKw5DYYu27W3QnK56wWbtzYHO
         24+cxY75QJQfketf3F0MKN00OYfZMwy8+BuUE3G8TtRPirNpYBSCrVp3ftKewBRzvFSo
         LCNE9bExtVkF44N4ARi3ZewotmUw13hu9KGWjxU98xYyBfayXOCIfqcULMdxuUzw/n6o
         wLZdPyv12X7gkcarFfKKGde0iIuCqerfV5Ct8f6CULYqD0vYltSA0isLyctLyY1GHEbD
         /sGA==
X-Gm-Message-State: AO0yUKVfvrT2EnOcXHiMfw1zaYacpKSx6CqTCld1fDVkhhFDgYCqEMJm
        yLBG22gewukvFRH7Bx/p84ymOA==
X-Google-Smtp-Source: AK7set/X14A60bT9t4QpESXUrKarmtui6NVnUQo6yUQoVYeTRj2Pq03+cx5bPgVW7QJbidOyAsln/g==
X-Received: by 2002:a2e:9b49:0:b0:293:4b61:265a with SMTP id o9-20020a2e9b49000000b002934b61265amr3040517ljj.49.1677760111243;
        Thu, 02 Mar 2023 04:28:31 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id g7-20020a2eb5c7000000b002946be8475esm2079985ljn.135.2023.03.02.04.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 04:28:30 -0800 (PST)
Message-ID: <f39890de-54a9-297b-68ee-41dedd7bdf27@linaro.org>
Date:   Thu, 2 Mar 2023 13:28:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc8280xp-x13s: fix va dmic dai
 links and routing
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302115741.7726-1-srinivas.kandagatla@linaro.org>
 <20230302115741.7726-5-srinivas.kandagatla@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230302115741.7726-5-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.03.2023 12:57, Srinivas Kandagatla wrote:
> VA dmics 0, 1, 2 micbias on X13s are connected to WCD MICBIAS1, WCD MICBIAS1
> and WCD MICBIAS3 respectively. Reflect this in dt to get dmics working.
I'm far from good when it comes to sound, but is it expected that
(VA DMICn) are are connected to both (MIC BIASn) and (VA MIC BIAS{1, 1, 3})?

> Also fix dmics to go via VA Macro instead of TX macro to fix device switching.
> 
> Fixes: 8c1ea87e80b4 ("arm64: dts: qcom: sc8280xp-x13s: Add soundcard support")
If that doesn't depend on any driver changes, please Cc stable
so that distros will pick this up.

Konrad
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index d18d405d1776..89230112e288 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -933,9 +933,9 @@
>  		"VA DMIC0", "MIC BIAS1",
>  		"VA DMIC1", "MIC BIAS1",
>  		"VA DMIC2", "MIC BIAS3",
> -		"TX DMIC0", "MIC BIAS1",
> -		"TX DMIC1", "MIC BIAS2",
> -		"TX DMIC2", "MIC BIAS3",
> +		"VA DMIC0", "VA MIC BIAS1",
> +		"VA DMIC1", "VA MIC BIAS1",
> +		"VA DMIC2", "VA MIC BIAS3",
>  		"TX SWR_ADC1", "ADC2_OUTPUT";
>  
>  	wcd-playback-dai-link {
> @@ -986,7 +986,7 @@
>  	va-dai-link {
>  		link-name = "VA Capture";
>  		cpu {
> -			sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
> +			sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
>  		};
>  
>  		platform {
