Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2745F6B0259
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCHJFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCHJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:05:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97319AFDB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:04:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cy23so62649940edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 01:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678266297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=269a+hSFqGP/XBfE02KYCbxQFTM7xuOYsDEHsUDIoiw=;
        b=C/f+eUOIEi3uxqK85NzLLkIaMc3bYeiNLchyXLYpEu9fdTe4m8/2IzR2Yrz35BVypJ
         By70P9SvUMhJnhepKxiEcoXwrhK+GpEDkZLQ4v6+AGhLQsPeWUsf+uMM1l7GSMyxHg1j
         7mTMftIMI8wA+oG4zEi9N9UYjsWcvw6/dx5ALQ9ViwpO4Yhv1soyo0oWtIlnPrwVgRWV
         iqcxukrmFtpkSea7QszjGQfMYMCx96IYdJCWZcRTgrg7xbw/iCuS9vpH8xoZHaSxF/H2
         dc/ECeXdsZHD7nfDjTUTG/J0o/vgjlrfexfpsUtm8WW2J8o/7pQ7nHF2GQbc39KwkEaU
         5UCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=269a+hSFqGP/XBfE02KYCbxQFTM7xuOYsDEHsUDIoiw=;
        b=wGccDzAn/vQstXSPChXYV3yXniX1jVOCJWMfvyqMRlDXbQSN+JO0Dlq6aBh5M6kw11
         d92ILyE1FQoU9BB4Cue2VSq6kNrmdXHr4AAgQuVzyn/ipR6kZ4CoiRzAJXTy8CoSzb61
         ORA7pluDVgX6GGOMNfup2lQ5z813ZCMlYcyjMIFLyQaeV3Vx7uy+C4yNzLnk6sLvMTUg
         51L+kRH5opCHzpy25025RBHLD3ju95XN7rIUZ4Z6gUSss/M+1Q2P6eC3szQDnOhE0+oh
         067Rakoh0mqhz8wtx0A02+pvCHD/Buaoyfp7rJVBR1ABKXQMHldtVBUTLSR0NntcJ4iz
         /aWA==
X-Gm-Message-State: AO0yUKUV2RaLou8RSwFzVMRJEP9dm97gXPRMZ2TVvrZLNSelhtI94rBO
        tyksJJNMGqpQ5YsiPmmaEw12fQ==
X-Google-Smtp-Source: AK7set+2qTfpfpduh8f17lysCrO27en5LVth7P9pVbPwi6AtQ+YAQ0MG4sEuKa+PIBipFEgB54KvEA==
X-Received: by 2002:a17:907:6e87:b0:879:ec1a:4ac with SMTP id sh7-20020a1709076e8700b00879ec1a04acmr21367004ejc.76.1678266297454;
        Wed, 08 Mar 2023 01:04:57 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:bba:fbfa:8aec:a133? ([2a02:810d:15c0:828:bba:fbfa:8aec:a133])
        by smtp.gmail.com with ESMTPSA id u15-20020a1709064acf00b0090766deae98sm7115207ejt.166.2023.03.08.01.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 01:04:57 -0800 (PST)
Message-ID: <95fa5f0f-cf53-7a37-2170-98b81c0982f1@linaro.org>
Date:   Wed, 8 Mar 2023 10:04:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/4] dt-bindings: power: supply: maxim,max17040: update
 properties
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308084419.11934-1-clamor95@gmail.com>
 <20230308084419.11934-2-clamor95@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308084419.11934-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 09:44, Svyatoslav Ryhel wrote:
> Add simple cell, status, health and temperature properties.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/power/supply/maxim,max17040.yaml | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> index 3a529326ecbd..6f1c25b4729f 100644
> --- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> @@ -55,6 +55,20 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  monitored-battery:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the battery node being monitored
> +
> +  power-supplies: true

This should be rather specific input name, e.g. vdd-supply.

> +
> +  io-channels:
> +    items:
> +      - description: battery temperature



max17040 does not have ADC temperature input... so is it system
configuration?


> +
> +  io-channel-names:
> +    items:
> +      - const: temp

Drop the names property, not needed for one item.

> +
>    wakeup-source:
>      type: boolean
>      description: |
> @@ -95,3 +109,26 @@ examples:
>          wakeup-source;
>        };
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      fuel-gauge@36 {
> +        compatible = "maxim,max17043";
> +        reg = <0x36>;
> +
> +        interrupt-parent = <&gpio>;
> +        interrupts = <144 IRQ_TYPE_EDGE_FALLING>;
> +
> +        monitored-battery = <&battery>;
> +        power-supplies = <&charger>;

But here you suggests something else than VDD... The hardware does not
take charger as input. It takes power supply - vdd.

> +
> +        io-channels = <&adc 8>;

Just add these to existing example.

> +        io-channel-names = "temp";
> +
> +        maxim,alert-low-soc-level = <10>;
> +        wakeup-source;
> +      };
> +    };

Best regards,
Krzysztof

