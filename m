Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230E6714DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjE2QDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE2QDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:03:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F97B2;
        Mon, 29 May 2023 09:03:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso35703765e9.0;
        Mon, 29 May 2023 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685376181; x=1687968181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRFtSx1Qrg+CDLZ/Fo2vJebkgNJBOCrU0gJGaDnKCY8=;
        b=G08+hgi89y5+b84/X9EeIzk1I8MAfrsCvOe/SnJcgKvlNXijFcPaolDoL1ZFAsW2kR
         Gowl8hgzctVR63JTwgF6O8KCyFdcBK2I4xjpHXDeOjU0duYbjDzJ9feID3uvrBCdxfUF
         dJZ1FSvcPDAxFUsg4Ka0q1w5UlFxoUsIJAhTESUbOPRmpYv2tZtsd6tptDbKV88FzEY2
         7vEfm4JPR6VlvCwGweEW/xqXTxwawXAr0VPyRtkSrUniHeoDOukO6BhvfrfuaAI3uADG
         2zu7RiJCMmYt2RIIrlftoVkXHeG22QYSsj86VivItAatNlbqs0kAje2PDYgzfCXMr95U
         HORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376181; x=1687968181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRFtSx1Qrg+CDLZ/Fo2vJebkgNJBOCrU0gJGaDnKCY8=;
        b=TtEGlOdEcWjSE8PFO7P1ZAeClpDACijK8LbDCREEDU768Jej3JphGUcFP4AzSUfVE0
         L1PGf0BEPmezO65MV1M3nggofkVTTpWWMcN1JJKdkVDEz9ykVvDiMvSiPVIgZcmiVDWi
         6G6yJXy2wBq7yLU71uLjWnOiVhuKyKfcaMJ4T8tnJNcWS4cmEQOfv/Rl7LtPx1KTeV+b
         SFNMiOd4LCIelBIBsbkujnsN/dI3UBvEVUNIbpMFzxxlG/WkHXV5J6D+xA7D6bazGaku
         CaI45WNxMEUff8yb1Zmc6Uvi1lgrX9zzK89YaGLsdOfeckj0+AtdGkBurpPt1Jze8qWK
         E3LQ==
X-Gm-Message-State: AC+VfDzikVcz7mf70cQ4FC7Yc4oK2z/uuXZyAJQNiagD/EMvXeSicy4J
        Y5cf+R8QC7Qx4qLhPRBNC4g=
X-Google-Smtp-Source: ACHHUZ4uigxNzobgmnVYSy0x1Dll+6NuV5TAwot2deCigkpDBFRtQVP3fIwNi9DkuUHYGKJCqYBMrg==
X-Received: by 2002:a05:600c:283:b0:3f6:3ad:16a with SMTP id 3-20020a05600c028300b003f603ad016amr10116737wmk.31.1685376181436;
        Mon, 29 May 2023 09:03:01 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bcbcb000000b003f427cba193sm18304970wmi.41.2023.05.29.09.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 09:03:00 -0700 (PDT)
Message-ID: <929d92f5-f656-95a9-a819-e450c48fc800@gmail.com>
Date:   Mon, 29 May 2023 18:02:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 6/7] arm64: dts: mt7986: add thermal-zones
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
 <20230421132047.42166-7-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230421132047.42166-7-linux@fw-web.de>
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
> Add thermal-zones to mt7986 devicetree.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 40 +++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index a409d5e845c2..845b29a9664a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -603,4 +603,44 @@ wifi: wifi@18000000 {
>   			memory-region = <&wmcpu_emi>;
>   		};
>   	};
> +
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&thermal 0>;
> +
> +			trips {
> +				cpu_trip_crit: crit {
> +					temperature = <125000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +
> +				cpu_trip_hot: hot {
> +					temperature = <120000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};

We don't use above two trips. Please drop them for now.

Regards,
Matthias

> +
> +				cpu_trip_active_high: active-high {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "active";
> +				};
> +
> +				cpu_trip_active_low: active-low {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "active";
> +				};
> +
> +				cpu_trip_passive: passive {
> +					temperature = <40000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +			};
> +		};
> +	};
>   };
