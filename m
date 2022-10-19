Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180B160484C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiJSNxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbiJSNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:52:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F2B1C7119
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:36:29 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o22so10660529qkl.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spOHuMkUzxNQDF31ZQ14bo2Slaj0LH2xXCN8rwJWrnI=;
        b=w+CMYrks958c8ml3PmlfBooj70tDMnLmjJmSQ7i5gkstqLRFgYVvEj4aNS4tX2afCi
         KuYAkUXp8mTQ6lM1dnCZFg1Uvepgbs5c9hw81imvk3Tg5Q6JRw5SM4CKE7uE2wlRlbDO
         3bglyUheaLDRyGmGCGgf0t9tUyqyX+W8Vn+6e6fA57MekTOVvqR8W/faGWEx15EM71LX
         ilmjv2dZ8Yh6IfLlrNkW1hMEXmJCiF+YXGIBe7S/PQpQ2qvgekGFjjaSxDTmXTqrsJSX
         8XBwueSqOpqKy5h/oBJIzKsByESd00LhMrJ3vZ6vY2SGo1wLocFxESEJu+NPTun2/TOQ
         6Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spOHuMkUzxNQDF31ZQ14bo2Slaj0LH2xXCN8rwJWrnI=;
        b=swuzGRsUIE+XdYfH+5m6rJPezxZa4zPd9xgZMVnEH8D7277vSb7wFBbGatSYoTOEKB
         nKpg87gPyLUOeqIlmbiP34w4SBDENECr8OUS0L+hWI3FZEKqEl+/qUbsiCSJnzFhximu
         vBedwmohJXAMGMz7nUTxvxp17TVkVhx5moZ4JqZnnN3tgMjHG3a1q/nmazW0Pg2IoJCU
         URIPRDLa4fIGskLJZkAwhS1pPNbGigyUVwWCZ+d71oW6ukiheyirXuyGh3C6Y6cOU/SG
         2Z6u8zYKpfs1M7W/UXjxXu8YawDPaXEi+neKfge9OTODDxEYOF4LpxmUnycIPiB045Dt
         P2cA==
X-Gm-Message-State: ACrzQf27pujJDouq3jYgu0mapqHP2RiP//0OUEgYmo+6YRttGjX3j+jF
        dQsaWOc5HK9xlhwBlCIeR8ZiyA==
X-Google-Smtp-Source: AMsMyM4YZyJwWnHgYffvrOP+BQyLg9L1WUxQQbV6BkIOfB1dOifPywxyt/QXAnfCIv35UpoMV3cqLg==
X-Received: by 2002:a05:620a:2697:b0:6cf:33cd:2bd2 with SMTP id c23-20020a05620a269700b006cf33cd2bd2mr5404994qkp.341.1666186586436;
        Wed, 19 Oct 2022 06:36:26 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id ca27-20020a05622a1f1b00b003436103df40sm4052757qtb.8.2022.10.19.06.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 06:36:25 -0700 (PDT)
Message-ID: <b335e842-0dd9-851a-9876-8ee4711609c0@linaro.org>
Date:   Wed, 19 Oct 2022 09:36:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/2] dt-bindings: add bindings for QCOM flash LED
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com
References: <20221018014024.948731-1-quic_fenglinw@quicinc.com>
 <20221018014024.948731-3-quic_fenglinw@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221018014024.948731-3-quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 21:40, Fenglin Wu wrote:
> Add binding document for flash LED module inside Qualcomm Technologies,
> Inc. PMICs.

Use subject prefixes matching the subsystem (git log --oneline -- ...).

This means:
1. you miss subsystem prefix
2. drop redundant second "bindings"

> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  .../bindings/leds/qcom,spmi-flash-led.yaml    | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
> new file mode 100644
> index 000000000000..d8efde02db72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/qcom,spmi-flash-led.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Flash LED device inside Qualcomm Technologies, Inc. PMICs
> +
> +maintainers:
> +  - Fenglin Wu <quic_fenglinw@quicinc.com>
> +
> +description: |
> +  Flash LED controller is present inside some Qualcomm Technologies, Inc. PMICs.
> +  The flash LED module can have different number of LED channels supported
> +  e.g. 3 or 4. There are some different registers between them but they can
> +  both support maximum current up to 1.5 A per channel and they can also support
> +  ganging 2 channels together to supply maximum current up to 2 A. The current
> +  will be split symmetrically on each channel and they will be enabled and
> +  disabled at the same time.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,pm8150c-flash-led
> +          - qcom,pm8150l-flash-led
> +          - qcom,pm8350c-flash-led
> +      - const: qcom,spmi-flash-led

Blank line

> +  reg:
> +    description: address offset of the flash LED controller

Drop description, it's obvious.

> +    maxItems: 1
> +
> +patternProperties:
> +  "^led-[0-3]$":
> +    type: object
> +    $ref: common.yaml#
> +    unevaluatedProperties: false
> +    description: |

No need for |

> +      Represents the physical LED components which are connected to the
> +      flash LED channels' output.
> +
> +    properties:
> +      led-sources:
> +        description: |

No need for |

Rest looks good:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

