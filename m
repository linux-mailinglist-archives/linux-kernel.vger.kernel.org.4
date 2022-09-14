Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65285B88F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiINNSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiINNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:18:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A00F58DD8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:18:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so15490468wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DS/dB1Z8F2XdEan+7+v8LqVABBrY3Wgrn6yGpXksSnc=;
        b=U3uQB5mdqAWulEk/fX6kGrPUKTRAaJXxtaOqKnZAK5Ttyefxo59iAwEwEq8JOs8iDO
         8bg+Va6JCMlpApltHBGInErDhsVO/awvtfjGuzGNSlwI02Q0ktap8u/XuljHFlumrxPW
         VLi5lh1mJys7EZxxZ/Nr7IES8Ir9goTJkdpzG2VjdnfSsdSNGhvpbQErQ+qsVh2WkQMu
         oaXx1T8Y9JtzepZG8kPn4V5SP9bnXVKSbygKNW6mTmPEfC/OREA9Im1NSxl4L7Dm0UWf
         wTkmIKou80/6UwkmnHY8AJxZTKgznM7FrmL6CVqn1JYMegf1VFmsHppG76zsL+OL9EMb
         yS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DS/dB1Z8F2XdEan+7+v8LqVABBrY3Wgrn6yGpXksSnc=;
        b=cn67wRP9CIidzfn+ArBzSjHkA82ds8Z1G336rjjo4Hk85CLrRZKMAqFmUocFOgBEyw
         WG6AavrYnHKYTNhRMy+7KrO1SErHtqlUa4YrgwMcWkNpq0XXIvJ+KmGdZKh2OnNH4dY7
         o+c6fAyTU3gSdLUX4LD2ho3W8gUalIi22EI7Xl2w1mo6++hRh7JCIKmcVjv3nmpUuYy8
         rCdJ1YkWGvKGsU80MzclFy9i5cFcSWJ/zDhbG8s52+7TEOoACM412zwYZ8UYsqRou+Qx
         pB8ZMDqiCSBSoHPoDuZhYLsm/wR3XTX0dPq/jlLm0biKkpTOqqrz6btnq56To7N9mgyE
         hPvQ==
X-Gm-Message-State: ACgBeo3e9v2oxzEBafobGxOPM2Ji2z1VLPg3TnmYeFEE3rPEz5JYjaaA
        ti/MOwp/urxHij6LGh3A9sw1rvrm+uArU0nt
X-Google-Smtp-Source: AA6agR4grufWg+c3qXZKBLUKABCRUYDpCsb6qvLVWtV85cOL2R6YF4TAyyUjumc/HzIXaQ4ecB7u6w==
X-Received: by 2002:a05:600c:1ca8:b0:3b4:a5d1:2033 with SMTP id k40-20020a05600c1ca800b003b4a5d12033mr1741290wms.23.1663161510097;
        Wed, 14 Sep 2022 06:18:30 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c038a00b003b2878b9e0dsm16599554wmd.20.2022.09.14.06.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 06:18:29 -0700 (PDT)
Message-ID: <fda72ade-3c47-e9f8-d041-3a87d55318aa@baylibre.com>
Date:   Wed, 14 Sep 2022 15:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re:
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220914131219.18236-1-aouledameur@baylibre.com>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <20220914131219.18236-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The subject has not been parsed correctly, I resent a proper patch here:

https://patchwork.kernel.org/project/linux-mediatek/patch/20220914131339.18348-1-aouledameur@baylibre.com/


Sorry for the noise.

Regards,

Amjad

On 9/14/22 15:12, Amjad Ouled-Ameur wrote:
> Subject: [PATCH] arm64: dts: mediatek: mt8183: remove thermal zones without
>   trips.
>
> Thermal zones without trip point are not registered by thermal core.
>
> tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose
> only but are not supposed to remain on DT.
>
> Remove the zones above and keep only cpu_thermal.
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 57 ------------------------
>   1 file changed, 57 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 9d32871973a2..f65fae8939de 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1182,63 +1182,6 @@ THERMAL_NO_LIMIT
>   					};
>   				};
>   			};
> -
> -			/* The tzts1 ~ tzts6 don't need to polling */
> -			/* The tzts1 ~ tzts6 don't need to thermal throttle */
> -
> -			tzts1: tzts1 {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 1>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
> -
> -			tzts2: tzts2 {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 2>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
> -
> -			tzts3: tzts3 {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 3>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
> -
> -			tzts4: tzts4 {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 4>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
> -
> -			tzts5: tzts5 {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 5>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
> -
> -			tztsABB: tztsABB {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 6>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
>   		};
>   
>   		pwm0: pwm@1100e000 {
