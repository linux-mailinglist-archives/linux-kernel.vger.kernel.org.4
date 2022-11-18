Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9233A62EF65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbiKRI3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241452AbiKRI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:28:36 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073F26AE6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:28:32 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a15so5886513ljb.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZabo7ibEwOOw8J7VwUfivpQWJQQOqpTQOP6qmrwcFs=;
        b=c0DwlSGGZnpMt70g7cvHCqqLtClo+HqnYC/KDMQT/2C4Kgme2ED6Ajko4OIXpmbeXS
         m5SIke4QdtVszOu65Cv1AnF200xxc1a/iy1cj+W/4WPUi1idnzCq3jL3rOCyXQ/Sy7Xo
         FhxYYZmL7CP0ofdSTlNio6J4qvL4Gb4QE7SbMbyvGwdcz0q2lnaiEphLSDGuz3cWY979
         gQT9VdBtzdRs59dL/dUgCq5BV84WRT+Q7ok8jIBAq5G8XWvjz6kIifP/efd7/+/UMkZu
         +qzJPaRvsSeqy/GGhmsAycmFzituYnYzJUATh2BkazIz98eeuD3Eq9fkv2cSDtBNQpLB
         eqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZabo7ibEwOOw8J7VwUfivpQWJQQOqpTQOP6qmrwcFs=;
        b=ICEmjBBJmZ0umwueaTd8iNnGRsa5piONLg3yR19r7kMrm8g4IjjgTn5vThYEzFVF0c
         lPyvEmCC5UZCom7jz7qlCMVVoQPsION7ply+qAUUsVfYfWV2PJ35lW7ZYQkVByKR8Wud
         5Hbu3elUuVt7zECCWAwDTRzY6h1O8/Wo2e81oidOuwo7K1nDt63qdEvMwQI8cgV3+egL
         1TtBDdaJUwiQRy4pC25ya8EA4isfBELQRluWvWu9TKThNglj81hX42qoC2Tin3SItYnO
         eu0ZK5/PzjRW8zKey8XHEqYJbNPjqBAjqu+KiIH5uWPfv0EeJekJ1Mw0oz9ZHIPB/u6G
         o6HA==
X-Gm-Message-State: ANoB5pnNR0XSVQZLNdrwVMJXa8eDFuiyorm8GJQLjPXgsUrGTwfz0h6/
        N4z/4g8U8kKRTuCvrfQqQwyDwg==
X-Google-Smtp-Source: AA0mqf5FUU/an0yPckwGnu0iJ8FLtTfHewcyaiyp5w+c6ymGf8LMkNj5Lkw1yXdUuHVX3l3x9IvIFA==
X-Received: by 2002:a2e:a5c7:0:b0:277:8d48:27dd with SMTP id n7-20020a2ea5c7000000b002778d4827ddmr2207144ljp.192.1668760111721;
        Fri, 18 Nov 2022 00:28:31 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d24-20020a056512369800b0049b8c0571e5sm564273lfs.113.2022.11.18.00.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:28:31 -0800 (PST)
Message-ID: <578b686e-8461-a959-86c5-83a8be1dc981@linaro.org>
Date:   Fri, 18 Nov 2022 09:28:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 1/9] dt-bindings: drop redundant part of title of
 shared bindings
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-can@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-watchdog@vger.kernel.org
References: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
 <20221117123850.368213-2-krzysztof.kozlowski@linaro.org>
 <20221117220756.7a1bf734@xps-13>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117220756.7a1bf734@xps-13>
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

On 17/11/2022 22:07, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> krzysztof.kozlowski@linaro.org wrote on Thu, 17 Nov 2022 13:38:42 +0100:
> 
>> The Devicetree bindings document does not have to say in the title that
>> it is a "binding", but instead just describe the hardware.  For shared
>> (re-usable) schemas, name them all as "common properties".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/clock/qcom,gcc.yaml         | 2 +-
>>  Documentation/devicetree/bindings/dma/dma-common.yaml         | 2 +-
>>  Documentation/devicetree/bindings/dma/dma-controller.yaml     | 4 ++--
>>  Documentation/devicetree/bindings/dma/dma-router.yaml         | 4 ++--
>>  Documentation/devicetree/bindings/iio/adc/adc.yaml            | 2 +-
>>  .../devicetree/bindings/media/video-interface-devices.yaml    | 2 +-
>>  Documentation/devicetree/bindings/media/video-interfaces.yaml | 2 +-
>>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml     | 2 +-
>>  Documentation/devicetree/bindings/mtd/nand-chip.yaml          | 2 +-
>>  Documentation/devicetree/bindings/mtd/nand-controller.yaml    | 2 +-
>>  .../bindings/net/bluetooth/bluetooth-controller.yaml          | 2 +-
>>  Documentation/devicetree/bindings/net/can/can-controller.yaml | 2 +-
>>  .../devicetree/bindings/net/ethernet-controller.yaml          | 2 +-
>>  Documentation/devicetree/bindings/net/ethernet-phy.yaml       | 2 +-
>>  Documentation/devicetree/bindings/net/mdio.yaml               | 2 +-
>>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml        | 2 +-
>>  .../devicetree/bindings/power/reset/restart-handler.yaml      | 2 +-
>>  Documentation/devicetree/bindings/rtc/rtc.yaml                | 2 +-
>>  .../devicetree/bindings/soundwire/soundwire-controller.yaml   | 2 +-
>>  Documentation/devicetree/bindings/spi/spi-controller.yaml     | 2 +-
>>  Documentation/devicetree/bindings/watchdog/watchdog.yaml      | 2 +-
>>  21 files changed, 23 insertions(+), 23 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/Documentation/devicetree/bindings/mtd/nand-chip.yaml b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
>> index 97ac3a3fbb52..20b195ef9b70 100644
>> --- a/Documentation/devicetree/bindings/mtd/nand-chip.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
>> @@ -4,7 +4,7 @@
>>  $id: http://devicetree.org/schemas/mtd/nand-chip.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>> -title: NAND Chip and NAND Controller Generic Binding
>> +title: NAND Chip and NAND Controller common properties
> 
> I only see this now but the title should be
> 
> 	"NAND chip common properties"
> 
>>  
>>  maintainers:
>>    - Miquel Raynal <miquel.raynal@bootlin.com>
>> diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
>> index 359a015d4e5a..a004efc42842 100644
>> --- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
>> @@ -4,7 +4,7 @@
>>  $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>> -title: NAND Chip and NAND Controller Generic Binding
>> +title: NAND Chip and NAND Controller common properties
> 
> And here just "NAND controller..."
> 
> Of course the original purpose of your series is more to clean those
> titles rather than fixing them and if you disagree I am fine doing it
> myself aside, but if you could at the same time make the title more
> accurate that would be perfect.
> 
> Either ways:
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks, I update these manually, so I can correct the names to ones you
mentioned. Thanks.

Best regards,
Krzysztof

