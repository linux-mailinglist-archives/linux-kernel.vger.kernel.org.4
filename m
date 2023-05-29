Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ACB714DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjE2P6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjE2P63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:58:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74119DB;
        Mon, 29 May 2023 08:58:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f606912ebaso35314125e9.3;
        Mon, 29 May 2023 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685375903; x=1687967903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjV+qtzWnYDSApuIZdG6k60da0iyvrETpppNOJS7QhA=;
        b=leIrk3+YeN3O5gT0SiqrdKlm8hRwbjXVUPzrUbTvKtNHpXLi9kF1LnJ2T00hZkDFD9
         feQolja6wM71xhsg2GIE9+9UkEf50wO/KeNUyMOgsB8+5WOT/AblVKwm5+byas+hrW7R
         UYDkajejLeYdBxZtJ1Wmrkr+0GwMw4bZ7Fr+YE9YTQmRyXcWzuFMc8spSIVSfPtHBL2Z
         pDY+ugMtzo1vu8Bxy98yZOeNFAK3mLSOV6l0PkpWjhA0E3kWrcsjEuJLdo7gdfd5LV7y
         k1AxLpynxLdzftCdiq5ot65HBN1Cf6icKbZZtXVIZkewTIX72bXfIAHUEoptZsYHtG5f
         TbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685375903; x=1687967903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjV+qtzWnYDSApuIZdG6k60da0iyvrETpppNOJS7QhA=;
        b=Pv+GkMFGQCr601FVfoXVsEjXo0wKbXL0VSl1G0Ow5UTUBtokP8yq3N2nIHEdFZdn2O
         3ZjfRFE/mPY8z4zNCNRZY1anckQPr9+/Rry8GjZE/QHCN9ycNJfp9xxp2PXpFR/ohPNj
         RldshR76v+mfSZOG3QXLfiWWVGqgURCKFuJZ148r2B4Vqdb9X7CH3EO59yR0bX9/oGS9
         Ft2Kh4WA8QVxFVigkEFe2r6P9lmFvocCYqRQbErugcLdBQQyKjXrBkoPmRwYrl1F58Ta
         Tms5H2GqCc6lEiJADQEt4RXzdYvTDgn6KEWy5hNIjZdYMJOJhp5Q1ean2Yso1IG6Qs6B
         Onog==
X-Gm-Message-State: AC+VfDwCr6TJ8OkAszw+7GWDtThhjNQxTDh/TK3u8BtIEIQx+t7Iwyr2
        nGfEvpW4MuWO0vzrcLt+Dmo=
X-Google-Smtp-Source: ACHHUZ5WAiz6002gv+g3zk45cDtlIbfdv4jSfPBjDN5+0vxgVtYnOKe1uuzF73n649/FcsDdWL8lMQ==
X-Received: by 2002:a7b:cc93:0:b0:3f6:9634:c8d6 with SMTP id p19-20020a7bcc93000000b003f69634c8d6mr8977486wma.18.1685375902833;
        Mon, 29 May 2023 08:58:22 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n5-20020adffe05000000b00307bc4e39e5sm318049wrr.117.2023.05.29.08.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 08:58:21 -0700 (PDT)
Message-ID: <bba52e30-47ef-540b-1683-44e19dc8aa8b@gmail.com>
Date:   Mon, 29 May 2023 17:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 4/7] arm64: dts: mt7986: add PWM
Content-Language: en-US, ca-ES, es-ES
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
References: <20230421132047.42166-1-linux@fw-web.de>
 <20230421132047.42166-5-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230421132047.42166-5-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/04/2023 15:20, Frank Wunderlich wrote:
> From: Daniel Golle <daniel@makrotopia.org>
> 
> This adds pwm node to mt7986.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index a38965e23825..a409d5e845c2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -240,6 +240,20 @@ crypto: crypto@10320000 {
>   			status = "disabled";
>   		};
>   
> +		pwm: pwm@10048000 {
> +			compatible = "mediatek,mt7986-pwm";
> +			reg = <0 0x10048000 0 0x1000>;
> +			#clock-cells = <1>;
> +			#pwm-cells = <2>;
> +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_PWM_SEL>,
> +				 <&infracfg CLK_INFRA_PWM_STA>,
> +				 <&infracfg CLK_INFRA_PWM1_CK>,
> +				 <&infracfg CLK_INFRA_PWM2_CK>;
> +			clock-names = "top", "main", "pwm1", "pwm2";
> +			status = "disabled";
> +		};
> +
>   		uart0: serial@11002000 {
>   			compatible = "mediatek,mt7986-uart",
>   				     "mediatek,mt6577-uart";
