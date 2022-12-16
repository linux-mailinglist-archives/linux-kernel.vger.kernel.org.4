Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB2864EA02
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiLPLKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPLKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:10:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D39EA0;
        Fri, 16 Dec 2022 03:10:19 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso3844637wms.4;
        Fri, 16 Dec 2022 03:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzKAQT6vbiepszrD0+VM2G1/oJOVdJ1k4cSZtQrnzhw=;
        b=qahHQ2hQalVG872kBe//5V/5jaRnbx1APMf+vUt061g35sTwdMPn3BycY6jv3Mmw9v
         OoAButwJzIftdTe9KRxADOVdCx+G5hwxB7VN97DRsuatS7MZu0x567dCjJBdyKH8FaeT
         hcAZ1lzjaZjaTz+yTk5HYPNofw/XAXuAE38uhYBXWKE0mB6tUw0eJdhrrFGx3zydzcWn
         hrum2AUR7t1Uf18qYdkgeOvwaXPx88jvoDjXgllierTHz8yx/CYP35Zc2VNmimZUwE+/
         Q5GyYC4Xk22dOdMY9LuOnx7WFJHtQ+jYxZoRbrUoNELGQPMTXxPWQSaWpEgphxIiFqXV
         TYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzKAQT6vbiepszrD0+VM2G1/oJOVdJ1k4cSZtQrnzhw=;
        b=0xWh1CbCTLE/4FQYAkfcUCeBNlzan/YJB62WiJg+xF3JCB/aAR2NjFA2YK5xF5aUiJ
         PMyXIfY3+5WgAjM+CUJjzJRCNLWFXrMPh9UWgG/zwj+pU9uQNMQHA05drCVXtIA2vNn0
         fcOtuDFMoghsPmz2XPF2/IOYNeXwgvdPek6JJSb3QjXrsAtgWQfjIzsVPsm86LrHAl35
         CpNemDPWay2uaFLwNOQbXCun1jgZMjqMogkNPhxXjtISflUVaXkDEvXpFY+gc5CYrkiv
         IW8oirHE0C6cDknJbpx3LsqsgkXFy3a9z66y7O6BPFmhV1BPRh0m71kZb1xxQRvzU6U+
         avzA==
X-Gm-Message-State: ANoB5pmeJKXztOdw0rMOXpiNmJ52bAsvioi2xfncofZpJwRoEhB8GuE3
        O/nlKMEhO3SBn1Np++A4Snc=
X-Google-Smtp-Source: AA0mqf6IEVWiFLjp3/9w60Cwc4bWOIs5zm16vVKKgTK3FaHKykwos7vm3VPEVfd3JcJxgK0bqXR+gw==
X-Received: by 2002:a05:600c:6549:b0:3cf:497c:c59e with SMTP id dn9-20020a05600c654900b003cf497cc59emr24959984wmb.6.1671189017920;
        Fri, 16 Dec 2022 03:10:17 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id bi7-20020a05600c3d8700b003d1e051f671sm2199552wmb.9.2022.12.16.03.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:10:16 -0800 (PST)
Message-ID: <d2585fef-98b1-39ae-876d-523e385aebe9@gmail.com>
Date:   Fri, 16 Dec 2022 12:10:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: mt8183: kukui: Split out keyboard node and
 describe detachables
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220527045353.2483042-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220527045353.2483042-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/05/2022 06:53, Hsin-Yi Wang wrote:
> Kukui devices krane, kodana, and kakadu use detachable keyboards, which
> only have switches to be registered.
> 
> Change the keyboard node's compatible of those boards to the newly
> introduced "google,cros-ec-keyb-switches", which won't include matrix
> properties.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 ++
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi  | 6 ++++++
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi  | 6 ++++++
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi   | 6 ++++++
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi         | 1 -
>   5 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index 2d7a193272ae..981c889a22ea 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -4,6 +4,8 @@
>    */
>   
>   #include "mt8183-kukui.dtsi"
> +/* Must come after mt8183-kukui.dtsi to modify cros_ec */
> +#include <arm/cros-ec-keyboard.dtsi>
>   
>   / {
>   	panel: panel {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> index 28966a65391b..4b419623c8dc 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> @@ -372,6 +372,12 @@ pen_eject {
>   	};
>   };
>   
> +&cros_ec {
> +	keyboard-controller {
> +		compatible = "google,cros-ec-keyb-switches";
> +	};
> +};
> +
>   &qca_wifi {
>   	qcom,ath10k-calibration-variant = "GO_KAKADU";
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> index 06f8c80bf553..4864c39e53a4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> @@ -339,6 +339,12 @@ touch_pin_reset: pin_reset {
>   	};
>   };
>   
> +&cros_ec {
> +	keyboard-controller {
> +		compatible = "google,cros-ec-keyb-switches";
> +	};
> +};
> +
>   &qca_wifi {
>   	qcom,ath10k-calibration-variant = "GO_KODAMA";
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> index a7b0cb3ff7b0..d5f41c6c9881 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> @@ -343,6 +343,12 @@ rst_pin {
>   	};
>   };
>   
> +&cros_ec {
> +	keyboard-controller {
> +		compatible = "google,cros-ec-keyb-switches";
> +	};
> +};
> +
>   &qca_wifi {
>   	qcom,ath10k-calibration-variant = "LE_Krane";
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 8d5bf73a9099..db1388550f98 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -986,5 +986,4 @@ hub@1 {
>   	};
>   };
>   
> -#include <arm/cros-ec-keyboard.dtsi>
>   #include <arm/cros-ec-sbs.dtsi>
