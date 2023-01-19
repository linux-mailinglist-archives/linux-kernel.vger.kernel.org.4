Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E8A6740CD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjASSW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjASSWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:22:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC4A917E7;
        Thu, 19 Jan 2023 10:22:23 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l8so2224642wms.3;
        Thu, 19 Jan 2023 10:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkT0cysy+FxecAuEegqoIzMHcxej0PKOCevVj35BZ0U=;
        b=qPISyl2PgMZSakzvfLevnCw1T47CDwwswcEAdxTEY89OIKyHie+CZYVAaUWvcIQN8T
         AdZSZM3SUdNJS7C+xjSOH4yr+PQGwrIV1u+Rrs40cxAIfznggxJkfyA0g2jA8idfCloW
         FB6XhQCmZmAlcHfvSZwISyU45rXtcT3pZjXEHQSj5NY2V/CcE/Yp/SOUUmBrhYKHDSta
         9NGKKhUcgMaJBgZ7rv0dmcE3Q6fBm4opDPP9xWZdN87lf7jYJJi1Lz/jtGcXowe0WNau
         mF22XOdp63tgEJlzmLal0xlmVajeOvzeArPqrf8yDhOfgAqsPn76NwCFESjMViGEubJz
         EfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkT0cysy+FxecAuEegqoIzMHcxej0PKOCevVj35BZ0U=;
        b=2f1w+npx1My7cOza8VCFPzN/uWKCUHNrQIB257pH8v3Cn4s1ClzGDw/nlVSqxZp4y3
         LLLOnNg3RBPrHEupqCn+jOJU+BnUxfa6Vz/inqbawuOG1GuvF9Sdr/M8AMDElVwnI+/x
         mgcznbaRKLDs183sosYJIQtXO4EPbaaioki9/UmEVzoSdWPdykiVGcG9kQDEU515/VGK
         k5k/q12gfNOI0XYa/o8gFcsrBoIFZxi3eg2iyoE9XadC1xKJqVg9IPzrI8s6fiTydLOe
         JfsNX5llrLva2ccbok7Q0exFJiY5pk0cXQWJPETFwvP3jqlL7lxAbkG8CiQil5dbD/mm
         uIBg==
X-Gm-Message-State: AFqh2koF9sSmJxEwSxLDL6ADCsJehFiRph1EvvjWV+Cf8+/0wMSU99jt
        ZMEArTMUcrstDOyKiwTRbFw=
X-Google-Smtp-Source: AMrXdXtlJ+BqjAv7TuLog+rZuaq6u1JMgaw1kapSbEZsIn63mSSX9fAYaQxezDKK1PjMtcJBS8eYyQ==
X-Received: by 2002:a05:600c:3555:b0:3c6:e63d:fcfc with SMTP id i21-20020a05600c355500b003c6e63dfcfcmr11254139wmq.35.1674152542216;
        Thu, 19 Jan 2023 10:22:22 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q10-20020a1cf30a000000b003d1e3b1624dsm5444546wmq.2.2023.01.19.10.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 10:22:21 -0800 (PST)
Message-ID: <6ecedcf7-e6ca-b118-e2f2-4f1ba0fbe7c6@gmail.com>
Date:   Thu, 19 Jan 2023 19:22:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8173-elm: Move display to ps8640
 auxiliary bus
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230111140724.294533-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111140724.294533-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2023 15:07, AngeloGioacchino Del Regno wrote:
> Move the display to an aux-bus subnode of the PS8640 eDP bridge.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 26 +++++++++++---------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index 18e214464a2d..f9b10c7027cf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -90,18 +90,6 @@ switch-volume-up {
>   		};
>   	};
>   
> -	panel: panel {
> -		compatible = "lg,lp120up1";
> -		power-supply = <&panel_fixed_3v3>;
> -		backlight = <&backlight>;
> -
> -		port {
> -			panel_in: endpoint {
> -				remote-endpoint = <&ps8640_out>;
> -			};
> -		};
> -	};
> -
>   	panel_fixed_3v3: regulator1 {
>   		compatible = "regulator-fixed";
>   		regulator-name = "PANEL_3V3";
> @@ -282,6 +270,20 @@ ps8640_out: endpoint {
>   				};
>   			};
>   		};
> +
> +		aux-bus {
> +			panel: panel {
> +				compatible = "lg,lp120up1";
> +				power-supply = <&panel_fixed_3v3>;
> +				backlight = <&backlight>;
> +
> +				port {
> +					panel_in: endpoint {
> +						remote-endpoint = <&ps8640_out>;
> +					};
> +				};
> +			};
> +		};
>   	};
>   };
>   
