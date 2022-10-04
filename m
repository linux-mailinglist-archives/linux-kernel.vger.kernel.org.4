Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83305F40FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJDKrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJDKre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:47:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9D650730
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:47:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a10so8345178wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cEukjb2UHK5KqOanQB61zhcVE7DRFNm5dcKOe0eZBnI=;
        b=dhKSlYdYkxEW6eonWePf90D/2Wkp27oLOK/2b1lxm0GZ2l8Rbv60TIC/4og+E/LlpZ
         zE8hxUxVfxYcMGcewbLcPorJ6pTTOEf+ogZkrm+IZqcESkFi1KjcJh4jNpNGlmdA0FQ1
         vAAgBLlA1+wc8iJ6CdcCUk+jhQz8AcU2Bvn+AMdw1LGeK8jbgFajfwM+5lsDE6HSB5C6
         Xfol4ujqekdk5SSbQFqbKEJD5LdGYHO61fWF8HLwQ0OhZt0kwc5S9A9v7CDrY/qbyjhJ
         5uzHI1SzYbt5kQtrlSO9CpPwnPCvMlex+1V5jd2/gSVlRm8XEt3aca0Kq1ABqguQS+d+
         AruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cEukjb2UHK5KqOanQB61zhcVE7DRFNm5dcKOe0eZBnI=;
        b=7++vZb6K3URsV8YiwIihBK7Kum9pQ+HOVdDk1ajdgE3OszJvGhhQo0R/gRNOFEtDHC
         uM41o1vNl5XlN60tQMJhrIF3Uo8uN8/TRu/5B5mcRW5Oyi8EfPI56nfX2cHNO6NJZoD2
         E16dDtQMFLQ4QH74HEi/m2aJZbAK8854Q66oPpnCzSZvTm/jyiJb/+oj7XZfzN41GGmt
         tmMnXCIfVoe1HWYAcDvUBwIx0gpi3VoEiKGTC04/yqFdjSf8Pzg9ROeFOlsUKplNst7T
         trQAmbAvO0/dO4oBxJt+0SNULD7vGJuEYFcMt7893mP7fgBV3MWRE1iacHeQqKbY40su
         94zw==
X-Gm-Message-State: ACrzQf1pePu6tNUvigy+PKjkJ3T24ulAianIxaYCjzHlJmL3Ph2LJQ6+
        4BIiLYDatIdRmSg7lkMVZDb+cw==
X-Google-Smtp-Source: AMsMyM7ncqbuDxUiZMMmnbuthAQ80+V55LgaGgIxWvf/tI6EXifGRpjq/61Pu4DozeT85LYz66Jplg==
X-Received: by 2002:a05:6000:4c:b0:22e:48e0:1a0b with SMTP id k12-20020a056000004c00b0022e48e01a0bmr3105069wrx.618.1664880452067;
        Tue, 04 Oct 2022 03:47:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c456:8337:99aa:2667? ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.googlemail.com with ESMTPSA id k18-20020a05600c1c9200b003b5054c6cd2sm25870085wms.36.2022.10.04.03.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 03:47:31 -0700 (PDT)
Message-ID: <17f3fd40-70c1-2e8d-8002-dfe9690aed88@linaro.org>
Date:   Tue, 4 Oct 2022 12:47:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt8183: disable thermal zones
 without trips.
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221004101130.17256-1-aouledameur@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221004101130.17256-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Amjad,

On 04/10/2022 12:11, Amjad Ouled-Ameur wrote:
> Thermal zones without trip point are not registered by thermal core.
> 
> tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose
> only.
> 
> Disable the zones above and keep only cpu_thermal enabled.

It does not make sense to disable the thermal zones. Either the thermal 
zones are needed or they are not. Keeping them for debug purpose is not 
desired.

Alternatively to removal, you can:

  - remove 'sustainable-power'
  - add a passive trip point, optionally a hot trip point and a critical 
trip point

The passive trip point will allow the userspace to set a value in order 
to get notified about the devices temperature (writable trip point). 
The hot temperature will send a notification to userspace so it can take 
a last chance decision to drop the temperature before the critical 
temperature.

The passive trip point temperature could be a high temperature.

The mitigation is also managed from userspace as a whole.


> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 9d32871973a2..53f7a0fbaa88 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1191,6 +1191,7 @@ tzts1: tzts1 {
>   				polling-delay = <0>;
>   				thermal-sensors = <&thermal 1>;
>   				sustainable-power = <5000>;
> +				status = "disabled";
>   				trips {};
>   				cooling-maps {};
>   			};
> @@ -1200,6 +1201,7 @@ tzts2: tzts2 {
>   				polling-delay = <0>;
>   				thermal-sensors = <&thermal 2>;
>   				sustainable-power = <5000>;
> +				status = "disabled";
>   				trips {};
>   				cooling-maps {};
>   			};
> @@ -1209,6 +1211,7 @@ tzts3: tzts3 {
>   				polling-delay = <0>;
>   				thermal-sensors = <&thermal 3>;
>   				sustainable-power = <5000>;
> +				status = "disabled";
>   				trips {};
>   				cooling-maps {};
>   			};
> @@ -1218,6 +1221,7 @@ tzts4: tzts4 {
>   				polling-delay = <0>;
>   				thermal-sensors = <&thermal 4>;
>   				sustainable-power = <5000>;
> +				status = "disabled";
>   				trips {};
>   				cooling-maps {};
>   			};
> @@ -1227,6 +1231,7 @@ tzts5: tzts5 {
>   				polling-delay = <0>;
>   				thermal-sensors = <&thermal 5>;
>   				sustainable-power = <5000>;
> +				status = "disabled";
>   				trips {};
>   				cooling-maps {};
>   			};
> @@ -1236,6 +1241,7 @@ tztsABB: tztsABB {
>   				polling-delay = <0>;
>   				thermal-sensors = <&thermal 6>;
>   				sustainable-power = <5000>;
> +				status = "disabled";
>   				trips {};
>   				cooling-maps {};
>   			};


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
