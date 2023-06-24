Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777F773CA46
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjFXJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjFXJms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:42:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75DE1BFC
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:42:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-987accb4349so201750766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687599765; x=1690191765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBlwLAaVch1INC96eKn5eKUTFSyd9FeySsDuSnKFv5g=;
        b=xFrz6uKlO6J1hCJXiYfgjAvCcMA16i7mnGogxnAB1JMtPjuqSHgLhZnvwcl/FhmJxf
         iSuW6Ok1eqbzbx+ktyzA/zRSljNZg1uzyQtlKSjb+CCyjAQ6xj1SbUu1FCeAs+ZtgT4q
         yU9QA2ksqdMKdf6F3tZ1IV7WoE+y33ZOKZWi7xiZrIpExZydPxusSkBalepmTdJ4J9JB
         TtUQkaNcAp51QZlefijkUamJS0V9qLjSKS7zy4MgzEoWrEv31OGWoVPZJo1yWnzwJQcS
         AKvDHCumGYmgssX3n/G2lOc5uiVqW/TZ4c3NWbM3vvLAs+Rckkgeu5svdAxT2BQdqUm2
         Athw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687599765; x=1690191765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBlwLAaVch1INC96eKn5eKUTFSyd9FeySsDuSnKFv5g=;
        b=FnePhEp39LhBnP0ymHrx0gp7J3D41zqZgT6c1O9jNpNDrnH7P3mUGln2qO8qRW5L91
         5a3xstjrtO/qO1mrADPeiuN7vjuypEUooUsdKpFWr+SFTWFiETjzDjmU4H8jtp/DBwrJ
         9o/c7Bv1fspRWBZ+sf9rwuQAZLY0+mUazDE5GKXkBOk4IqnitVtJWYUArTfeKw3fbeGr
         Bm4RNrXFmnj9Jk7CmPzLZpo68bt/uJtW3/SlpeKeUWZx8IwUkxYwuyL0rz00G5osLmdK
         RbmwyhyyNc05hgr+S1db3dl7Of2KBaj0PRjYL72i1Yokr0ldMWap8WCL0Wrfbz6RoR7N
         OCEA==
X-Gm-Message-State: AC+VfDwPa3w0ZhbeKhFd7DmRys/LZBXJXx61+G64H+kMpzXe5QXNrGDP
        LqYLFin683ZOctKOFiAnXyZIBA==
X-Google-Smtp-Source: ACHHUZ7FviPXKBiOCLdCKWjxQJylLJitMT/nJmOLackYgoV7v3uRdZOFqv3PNDQ2J4TZVCzNKYFjqw==
X-Received: by 2002:a17:907:7b96:b0:984:5c67:e73f with SMTP id ne22-20020a1709077b9600b009845c67e73fmr22933243ejc.54.1687599765183;
        Sat, 24 Jun 2023 02:42:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z18-20020a1709067e5200b00985bdb7dd5fsm665323ejr.201.2023.06.24.02.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 02:42:44 -0700 (PDT)
Message-ID: <4ee5f3fc-3376-7421-23cd-8fc905704493@linaro.org>
Date:   Sat, 24 Jun 2023 11:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for LUT
 through NVMEM devices
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-3-quic_amelende@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621185949.2068-3-quic_amelende@quicinc.com>
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

On 21/06/2023 20:59, Anjelique Melendez wrote:
> Update leds-qcom-lpg bindings to support LUT patterns through NVMEM
> devices.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../bindings/leds/leds-qcom-lpg.yaml          | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> index e6f1999cb22f..c9d53820bf83 100644
> --- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> @@ -63,6 +63,31 @@ properties:
>          - description: dtest line to attach
>          - description: flags for the attachment
>  
> +  nvmem:
> +    description: >
> +      Phandle(s) of the nvmem device(s) to access the LUT stored in the SDAM module(s).

It's the first time in this binding the "LUT" appears. Drop redundant
parts like "Phandle(s) of ...." and describe what do you expect there
and why the hardware needs it.

> +      This property is required only when LUT mode is supported and the LUT pattern is
> +      stored in SDAM modules instead of a LUT module.
> +    minItems: 1
> +    maxItems: 2
> +
> +  nvmem-names:
> +    description: >
> +      The nvmem device name(s) for the SDAM module(s) where the LUT pattern data is stored.
> +      This property is required only when LUT mode is supported with SDAM module instead of
> +      LUT module.
> +    minItems: 1
> +    items:
> +      - const: lpg_chan_sdam
> +      - const: lut_sdam
> +
> +  qcom,pbs-client:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: >
> +      Phandle of the PBS client used for sending the PBS trigger. This property is


You need to explain what is PBS and what this property is doing.

Phandle of PBS client? This is the PBS client! It does not make sense.



> +      required when LUT mode is supported and the LUT pattern is stored in a single
> +      SDAM module instead of a LUT module.

Which devices support LUT? Why this is not constrained per variant?

> +
>    multi-led:
>      type: object
>      $ref: leds-class-multicolor.yaml#
> @@ -191,4 +216,64 @@ examples:
>        compatible = "qcom,pm8916-pwm";
>        #pwm-cells = <2>;
>      };
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    led-controller {
> +      compatible = "qcom,pm8350c-pwm";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #pwm-cells = <2>;
> +      nvmem-names = "lpg_chan_sdam" , "lut_sdam";

Fix your whitespaces.

> +      nvmem = <&pmk8550_sdam_21 &pmk8550_sdam_22>;

Two entries, not one.

Anyway, adding one property does not justify new example. Integrate it
into existing one.

> +
> +      led@1 {
> +        reg = <1>;
> +        color = <LED_COLOR_ID_RED>;
> +        label = "red";
> +      };
> +
> +      led@2 {
> +        reg = <2>;
> +        color = <LED_COLOR_ID_GREEN>;
> +        label = "green";
> +      };
> +
> +      led@3 {
> +        reg = <3>;
> +        color = <LED_COLOR_ID_BLUE>;
> +        label = "blue";
> +      };
> +    };
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    led-controller {
> +      compatible = "qcom,pmi632-lpg";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #pwm-cells = <2>;
> +      nvmem-names = "lpg_chan_sdam";
> +      nvmem = <&pmi632_sdam7>;
> +      qcom,pbs-client = <&pmi632_pbs_client3>;

One more example? Why?

Why do you have here only one NVMEM cell? Aren't you missing constraints
in the binding?

Best regards,
Krzysztof

