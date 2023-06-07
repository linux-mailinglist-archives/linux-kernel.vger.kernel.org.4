Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7447257F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbjFGIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjFGIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:36:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3E61715
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:36:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so828470a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686126960; x=1688718960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrBypWeubMbxcljEMrbhcsqFO6qImvP/mf4G4xcloiA=;
        b=CoMG7GGoFmIb27F5iwkC4dcYhIURDa0iz6nd23TcOi2jGSO4YPEry92mXnx7Sbv0pz
         PXphDr6sBgSRaeX2p2vZMXJFejvbI6jEVHXxW+BjH9L8qKMoVC+lqeYdvegV+lvar0Lm
         JtBgrUsyc+ZL+Dx2yuLTtAjr9M4sxFZ14wulNTQH/gHXzHwVXhiosAPTQ6suM+IbGz8W
         pmP84dFIypCg8SHVAaCZPy3ncxVyLSBp5x/lkh7K0QdSST4GopSwlZSaJhXO2gyKR2Qb
         Snv8L1h05nwICLtL1x3a0sePYfsJmsJHMzVlPGwJ8z/aKpuz7pGO5KgFDyUUYy+6b0Cs
         P59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686126960; x=1688718960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrBypWeubMbxcljEMrbhcsqFO6qImvP/mf4G4xcloiA=;
        b=edzVEkVUwc6PF4ACJn6E7XEn4VeopDe3jAIYSXC0377/2gGZUmmMXQ41UmJjOCXQt1
         l0dTh40Mir5aP1PdLP8h1kYw0nseRuZ/Q6pVynqMNoCeve5+t5KgPYDdl8btxwpBZzI6
         9gI/l3okA0IbRo6I1c5vpouPbCYOqV/R0kBm+e/rRPmeSLFxNGt7rySI4eKE+MIlTZih
         UNyCeOLjw0zhnKP9nZBdlBBRhU2z2w7YdKVsuNUTG4OQDVXsliWFNWKLMhv+ou7ijo41
         p//LpR+aBR8dr4SK4TmcRbtUGN48BMlKPP4tndBTKtAG8ABhJ0fTmuVdhg5nG9ze2aR4
         sqMQ==
X-Gm-Message-State: AC+VfDyYlI5Qi2ULHKQthRyRqPUZmIIWFHX2PbPafK7JUShAF4RVU6Ds
        tr5YBxKCqJdT9bojcjs1yZdD4g==
X-Google-Smtp-Source: ACHHUZ6ykvSByCH8/v69gOuWKopinDUva0RGEVG+ZsvSnFjn4B71tLz6YtG8xCXT/qyHkEG3v92gBw==
X-Received: by 2002:a17:907:8a08:b0:974:419d:7837 with SMTP id sc8-20020a1709078a0800b00974419d7837mr6143995ejc.34.1686126960414;
        Wed, 07 Jun 2023 01:36:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lo12-20020a170906fa0c00b0094f07545d40sm6536109ejb.220.2023.06.07.01.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 01:35:59 -0700 (PDT)
Message-ID: <45ad07cf-c046-876f-1374-0a83fa561107@linaro.org>
Date:   Wed, 7 Jun 2023 10:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v1-1-4a0741b8aefd@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v1-1-4a0741b8aefd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 16:31, Neil Armstrong wrote:
> Document the Goodix GT9916 wich is part of the "Berlin" serie
> of Touchscreen controllers IC from Goodix.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/input/touchscreen/goodix-berlin.yaml  | 81 ++++++++++++++++++++++

Filename like compatible, so at least with vendor,device style.
Preferably named exactly like compatible, since you have only one.

>  1 file changed, 81 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix-berlin.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix-berlin.yaml
> new file mode 100644
> index 000000000000..4c24a541e919
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix-berlin.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/goodix-berlin.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Goodix Belin series touchscreen controller
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - goodix,gt9916
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: Analog power supply regulator on AVDD pin
> +
> +  vddio-supply:
> +    description: GPIO power supply regulator on VDDIO pin
> +
> +  spi-max-frequency: true
> +  touchscreen-inverted-x: true
> +  touchscreen-inverted-y: true
> +  touchscreen-size-x: true
> +  touchscreen-size-y: true
> +  touchscreen-swapped-x-y: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

I bet supplies are required - at least one of them. If hardware needs
them, they should be required by the bindings.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      gt9916@5d {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

touchscreen?

> +        compatible = "goodix,gt9916";
> +        reg = <0x5d>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
> +        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> +      };
> +    };


Best regards,
Krzysztof

