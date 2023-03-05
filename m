Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69856AAFE9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCENbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCENbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:31:03 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D647D12840
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 05:31:01 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id k10so4277688edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 05:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678023060;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxwKusTrT5Ph9UVPcadPhfPIciAtPEwoDMOjQJNze1A=;
        b=hl/9z6Ol1ta6vFalu2IngF7fzfDi+iLnw4Ik3ge/NOGMzBWs70s0duKW4rfkRKEtCN
         xxMimahktHyXd4aw7QJloyDPuT2HtctGeuQ+1AEvKoAdAyfrjEltRbs8CIH+fMkuQhH+
         arAX08FX/D+xZpm30aVQHhbXoxYIprTvCkrBAwAXDkVv2OektKn0y/x4aEwOrpQAP6sm
         cZzj+jJuShomHH4WvHcOHsuxURGr6GwasAXeqDPjbhxE2ulhp6YnVL3tFTAVeNauCWSf
         NUEe5FK61uo7YLk1Z7MniADb5r+HsTyXZXvcvLghEnRnDaBmPm/OYQTEX9dq5w5mRe3y
         tt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678023060;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxwKusTrT5Ph9UVPcadPhfPIciAtPEwoDMOjQJNze1A=;
        b=iTTYD226p/oceJLFRoLf7Iey+o02l4166cPFJ737ADbi89/YjW6em8scc3Dd4K1efi
         Ou5w4PqPi/dQoi7KyoaoG1o+9MfLvQKgMDiH0GZwQf4HgCrWc7cEyQlpV6XWd6zfUEdI
         8ql5oLD2bi/eQKoY8goDf/MBBE4J+8In8Q552nSF87OPp54yulTyJVYTED7HW3iK3ykH
         5PlQ/+MolRtjbvHlb5oNBrHXbygUEjH/4xBNrUxWpLeOtg+RJyMwsP6Xkmgl6okbu8YB
         P+c4HAsSkR518CSc6oMEu46YLyuY5+kxIGOAnEc3ocaa5exRhY7PWietmENQacMdbOaJ
         72Hg==
X-Gm-Message-State: AO0yUKVvnQ943l3CTDK8SiFDbWCWlAyrHHbSy+Bgma0P1JTae9MjMeYI
        s1ovtkFu8e7yL6e3EgshQbHG+A==
X-Google-Smtp-Source: AK7set/+wBTKZHcwMuDcJInU5Oi6zg2QZX/PcO/qgNORoWNGsi9EADRiv0/dhtTc/PE29DWnpM2xKA==
X-Received: by 2002:a17:906:60c3:b0:8a9:f870:d25b with SMTP id f3-20020a17090660c300b008a9f870d25bmr6605064ejk.15.1678023060093;
        Sun, 05 Mar 2023 05:31:00 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:71e7:13d:1c29:505f? ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id g10-20020a50d0ca000000b004bc9d44478fsm3697966edf.51.2023.03.05.05.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 05:30:59 -0800 (PST)
Message-ID: <0d2184ee-679e-371e-8433-c38b22c97799@linaro.org>
Date:   Sun, 5 Mar 2023 14:30:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] arm64: dts: meson: add support for BananaPi M2S
 variants
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230305132044.1596320-1-christianshewitt@gmail.com>
 <20230305132044.1596320-3-christianshewitt@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230305132044.1596320-3-christianshewitt@gmail.com>
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

On 05/03/2023 14:20, Christian Hewitt wrote:
> BananaPi M2S ships in Amlogic S922X and A311D variants with the
> following common specifications:
> 
(...)

> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		blue {

led-0

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio_ao GPIOAO_7 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		green {

led-1

> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
> +		};

Best regards,
Krzysztof

