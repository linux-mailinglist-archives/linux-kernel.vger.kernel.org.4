Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5379E66B1D7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjAOPGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 10:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjAOPGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 10:06:40 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486A99EF6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:06:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id u19so62630818ejm.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mV2i5/nB+6SQc3dRdfPMP5cMJSxy5rQiGnmFtQCfgQ=;
        b=Gxs+wgA/dB9MSMphhEcVZMGRdxcy+UPE25FznZluA2FOhVqJ8U4Eo6zqWEi5g8q+A6
         T2YCrsRaw2aw287emFzJt2/ALkOUorBkXUkLb7nQcm3aMpYdWdY34Y4e9tzVftHi5pB/
         QUiyVIb7EhiDGlRUBHdxbLoXoux/oAaLuWbDE8nUnxECJO1s2AgEyv89Zw85RCoGuqky
         1c006IJMXIKKrHw8onTaVEqeCArUieCwzFrrPxeH/Ev52mY+GtzWhHq6Jh5u7Jm63qbQ
         BtuEzdm7hMKrDoNu9eA8iDVemEFbPuV1wjrMIIAv1Yngxj7XKL/ZayYJEs7BRku/+Al0
         C56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mV2i5/nB+6SQc3dRdfPMP5cMJSxy5rQiGnmFtQCfgQ=;
        b=ZGn+CI+ohv9vwEAcBwYQcrybA50+TMUnM3FCPo1DZXI6oFhTz7jFbVdjAxlcw6ohcR
         8HrN1YQjvwMDDRUJPWXcEQhUjILKmpaUiHM0VzbT/7DjSY5ONvcWmJ1IUTV1D1zHIfYt
         8IcE0Yrmraz5klw33BJrpyAzZZj1+Ruw/6oGwJuW6xbSpdqpROuJMNfpgBGKU1HK0eif
         SkY6MoyXWrjbyoZeLso2XTjFeAyT+0WgYHiZMX8JwA8QtsmRe6oJ+WqeFfzqCnZws+up
         f4yfoTkIMT/Khfa2MMw5/JQeXLYzx/OpA6YWR9kffkW7PlNSaSrMmb86t/CZ89bkU7dl
         O/4A==
X-Gm-Message-State: AFqh2koSRy8+t5QFWNezUEcBCde1XXZdcK9oDvVqtvWj90uRuEStU0VJ
        AvjVQvL+a6HM6MtdOe2NgncNFA==
X-Google-Smtp-Source: AMrXdXtoJE1Ir5Xn52Iji4CbQo6oLweEklRVp9bvVaH0Nk2PtWen++DWHI0yZaagkGlYpbUC+Ijg7A==
X-Received: by 2002:a17:906:b108:b0:843:a9fe:f115 with SMTP id u8-20020a170906b10800b00843a9fef115mr79416292ejy.32.1673795197836;
        Sun, 15 Jan 2023 07:06:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id kz14-20020a17090777ce00b007c17b3a4163sm10914026ejc.15.2023.01.15.07.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 07:06:37 -0800 (PST)
Message-ID: <a4982e06-a6a4-a8c9-3b24-24f798c61f73@linaro.org>
Date:   Sun, 15 Jan 2023 16:06:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 4/5] arm64: dts: fsd: Add codec node for Tesla FSD
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20230113121749.4657-1-p.rajanbabu@samsung.com>
 <CGME20230113121830epcas5p4cc336a48f4597ba84ab1352774242f75@epcas5p4.samsung.com>
 <20230113121749.4657-5-p.rajanbabu@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113121749.4657-5-p.rajanbabu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 13:17, Padmanabhan Rajanbabu wrote:
> Add device tree node support for codec on Tesla FSD platform.
> 
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd-evb.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> index cf5f2ce4d2a7..2f211a1ad50d 100644
> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> @@ -10,6 +10,7 @@
>  
>  /dts-v1/;
>  #include "fsd.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	model = "Tesla Full Self-Driving (FSD) Evaluation board";
> @@ -34,6 +35,17 @@
>  	clock-frequency = <24000000>;
>  };
>  
> +&hsi2c_5 {
> +	status = "okay";
> +
> +	tlv320aic3x: codec@18 {
> +		compatible = "ti,tlv320aic3104";
> +		reg = <0x18>;
> +		#sound-dai-cells = <0>;
> +		reset-gpios = <&gpg1 6 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +

Why there is i2s here? What was the base of this patch?


Best regards,
Krzysztof

