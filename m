Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA756740E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjASS05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjASS04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:26:56 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20590B36;
        Thu, 19 Jan 2023 10:26:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso4170321wmc.4;
        Thu, 19 Jan 2023 10:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dJmsDozdVRAs19D/c5MdA3A6jGV12O+/i00BReI/8E=;
        b=ZUtIQIKuikeEhvVTBOdwAnI5gTNkXBiK4ZGMgTMla0Iy6odLdVySNIU9pY/UVfzuFL
         vrgyBB8A+QbXeceKV9jz6VvH+L34aJ4TTNNezZUfK50L1nkEDMX16xEMdjv6xI/pd7/3
         Vmti+FHEld7qc4a19lF4bVG0gzPj0XBsIpW8M6fZmWZLcXmjZrI76e0zkk/FY/xYC/ak
         XGbX2lHBmkZQPXAYH0cKg3CjMvjREz2M10vovSfarsRtdV6LWWHZsk/IJJseOBJ8GDjB
         H2HoEQ4OJhZiuP/r7/yPqWT2nq4VrOd9Az0+UWFp/5RmhQYl46PuGKu2WP44iOoW2N9K
         EZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dJmsDozdVRAs19D/c5MdA3A6jGV12O+/i00BReI/8E=;
        b=1cB1phOaKpYKkfzbdP+GrnXsvSsx4BAdaYjKwhcovZN/5u/UdikB2y5g3y1RyIYU+/
         verkSFVHA+11NbUFCPZTZiHN+pKdnKE21iCS5KoUwajqFQwXPh6h3xjgglGlxM9AKrOo
         p815gyWz8smoo1QifvZL8OKdH0SVL0A/AOH/9RNz9jS4TDFwMaJH9vamgjlWapL0yLIQ
         juIlspf/RWezxIlXlB55+C/RzCMsf3CXe0yO/3OgzhqXJ2VZVt0gAgUdRMY4PxNkFqLm
         xR5+cLSxESBa7ru1QS6xyXzsRNF9e9tNPbNF57BUUOQc+yucC7cl9eNiRHHEpsDu81bX
         q+sQ==
X-Gm-Message-State: AFqh2krC0kZ8cz4bNm0oE4K5gkESdyJNDLNDu4PDFelWcSxtw1akOj91
        b8psebh9wUa5LTv60dvY23M=
X-Google-Smtp-Source: AMrXdXuLslVnlOzGTATGgcmq7IrSUmDZBaEvqzhg+QUBZdi3cGfnc1CRoFCFvFMq3Tc1gz9uh4APug==
X-Received: by 2002:a05:600c:54d0:b0:3da:f9c9:cec9 with SMTP id iw16-20020a05600c54d000b003daf9c9cec9mr11360079wmb.1.1674152810079;
        Thu, 19 Jan 2023 10:26:50 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05600c3c8100b003db09eaddb5sm6906139wmb.3.2023.01.19.10.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 10:26:49 -0800 (PST)
Message-ID: <a8d05899-edfa-8036-6672-c4e7e79d60d5@gmail.com>
Date:   Thu, 19 Jan 2023 19:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: mt8183: jacuzzi: Move panel under aux-bus
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221228113204.1551180-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221228113204.1551180-1-hsinyi@chromium.org>
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



On 28/12/2022 12:32, Hsin-Yi Wang wrote:
> Read edp panel edid through aux bus, which is a more preferred way. Also
> use a more generic compatible since each jacuzzi models use different
> panels.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Applied, thanks.

> ---
>   .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    | 26 ++++++++++---------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index 3ac83be53627..543286ce9cea 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -6,18 +6,6 @@
>   #include "mt8183-kukui.dtsi"
>   
>   / {
> -	panel: panel {
> -		compatible = "auo,b116xw03";
> -		power-supply = <&pp3300_panel>;
> -		backlight = <&backlight_lcd0>;
> -
> -		port {
> -			panel_in: endpoint {
> -				remote-endpoint = <&anx7625_out>;
> -			};
> -		};
> -	};
> -
>   	pp1200_mipibrdg: pp1200-mipibrdg {
>   		compatible = "regulator-fixed";
>   		regulator-name = "pp1200_mipibrdg";
> @@ -181,6 +169,20 @@ anx7625_out: endpoint {
>   				remote-endpoint = <&panel_in>;
>   			};
>   		};
> +
> +		aux-bus {
> +			panel: panel {
> +				compatible = "edp-panel";
> +				power-supply = <&pp3300_panel>;
> +				backlight = <&backlight_lcd0>;
> +
> +				port {
> +					panel_in: endpoint {
> +						remote-endpoint = <&anx7625_out>;
> +					};
> +				};
> +			};
> +		};
>   	};
>   };
>   
