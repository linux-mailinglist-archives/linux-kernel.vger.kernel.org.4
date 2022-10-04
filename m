Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA35E5F3F05
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJDI75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJDI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:59:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C281007F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:59:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id o7so12912634lfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IVn1e873PvRiD77ZTr/X3t/FlEWxpTUJ4sOFXDhbtHo=;
        b=XxwxkaXKiq6e5IwFsDFC6xGQP81S/9Ajpc0L8PX5Gnmowqj9rZOMrwu/hq04mOCc4P
         kbOMmzUBGi4KrbcJlfmHluVMZweqZk/4qBRKDXJYuYKCzdafknER/r7HP8wnBZY1rYox
         4aVKLLV11n+eZrHcl2zpMinR5cLU52Xniyyxxe/NoeEBbrMTO3Q9TRWIDZqhNcS7oW6j
         cRYixH7NblTWcNYgJjMzFxfyA9XtEuPq9FoLWjp8YLZruJIDR6YootF78ri9wLPPrrNz
         vb5NSErH57CGJpWPHxNgu4+GKNJY91MK1XdoDPsZC2knrkjxezcXe3V9Qwh5xBiD0Qhm
         pbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IVn1e873PvRiD77ZTr/X3t/FlEWxpTUJ4sOFXDhbtHo=;
        b=7l7OI+AMGyPM3LqNzuFWRbucMHNMw+frEId9jhKUmzmOuigGMNT706Fib5jPNcVdlR
         NVkgCzFGCeKbcOyjVcNC0FJm4bciIOWLVc8Vbup6kLv2EEz7I2XzYo1e5VwGREMYQ7e+
         dpE6h916Ic5zSWSUZENI5qjxiVJEPpVgz+3emXqJM2bARubkIPHHmc++/fRPJpQliYY4
         4T1qjwlvW6etLLQRtDmQvrv9H426jVXgUyMF+jMRdrrH1Inf1JHhHo58Abwe7Wf20RH/
         sXECGGXz9AnUiLgJXtru8cfkdfuAw6oJg3TkKqZ6fsMo2JsIBXmX3y0A10LzDOZscQ+2
         LyrQ==
X-Gm-Message-State: ACrzQf3wWBDpjTR0bsItGoR9OAYuMyLkRi0r8TBo21BLss4Z75icCl1O
        6e1gbqRrGkCBLMcdYcK0qEgERQ==
X-Google-Smtp-Source: AMsMyM7iawg50cv/2c+1JUkuN8CbHjBOKFupbo7YU/iNfDEAxyF4uXalwVDZZbeEadjMENF9FKD2qA==
X-Received: by 2002:a05:6512:308a:b0:4a2:eeb:a18c with SMTP id z10-20020a056512308a00b004a20eeba18cmr6682132lfd.255.1664873984765;
        Tue, 04 Oct 2022 01:59:44 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y22-20020a197516000000b0048af4dc964asm1822327lfe.73.2022.10.04.01.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:59:44 -0700 (PDT)
Message-ID: <91630a1c-c4bf-357f-20f3-8176bd91bdf6@linaro.org>
Date:   Tue, 4 Oct 2022 10:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 06/11] dt-bindings: input: qcom,pm8921-pwrkey: convert
 to dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v2-6-87fbeb4ae053@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v2-6-87fbeb4ae053@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 10:08, Neil Armstrong wrote:
> Convert input/qcom,pm8xxx-pwrkey.txt to YAML, and take in account that
> the PM8921 pwrkey compatible is used as fallback for the PM8018 pwrkey.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 

You miss diffstat... but I guess it's result of b4?

> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml b/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml
> new file mode 100644
> index 000000000000..ae38c4ef4932
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/qcom,pm8921-pwrkey.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PM8921 PMIC Power Key
> +
> +maintainers:
> +  - Andy Gross <agross@kernel.org>
> +  - Bjorn Andersson <andersson@kernel.org>

Keep only Bjorn. Andy did not review much for some time.

> +
> +allOf:
> +  - $ref: input.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - qcom,pm8921-pwrkey
> +          - qcom,pm8058-pwrkey
> +      - items:
> +          - enum:
> +              - qcom,pm8018-pwrkey
> +          - const: qcom,pm8921-pwrkey
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +    description: |
> +          The first interrupt specifies the key release interrupt
> +          and the second interrupt specifies the key press interrupt.

In such case better to drop maxItems and description and write it:

items:
  - description: key release interrupt
  - description: key press interrupt

(maybe even the "interrupt" word could be skipped...)

> +
> +  debounce:
> +    description: |
> +          Time in microseconds that key must be pressed or
> +          released for state change interrupt to trigger.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pull-up:
> +    description: |
> +           Presence of this property indicates that the KPDPWR_N
> +           pin should be configured for pull up.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/interrupt-controller/irq.h>
> +   ssbi {
> +   #address-cells = <1>;
> +   #size-cells = <0>;

Messed indentation.
> +
> +     pmic@0 {
> +       reg = <0x0>;
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       pwrkey@1c {
> +          compatible = "qcom,pm8921-pwrkey";

Messed up indentation. For entire DTS example keep 2 or 4 spaces.

> +          reg = <0x1c>;
> +          interrupt-parent = <&pmicint>;
> +          interrupts = <50 1>, <51 1>;

Use defines for interrupt flags.

> +          debounce = <15625>;
> +          pull-up;
> +       };
> +     };
> +   };

Best regards,
Krzysztof

