Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6705EF59F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiI2Mkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiI2MkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:40:14 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA362FAC77
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:40:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b6so1384703ljr.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dhh6nNTG3cQbu2+/UY4E9ECxQouXbUNsJMhUFHHFteY=;
        b=kWS+mX1fzHpWgp4sKzzasMuSVtCPi3rvmO8sCBs5g2Y6chi47zlezfb2AVmU2U7U9k
         0NpwCbbn904CxatBISjO55b5M90Yk8uaI2eW/Kk8G7iQI3GS0TCEWZGqf/Zwk2DD8D8j
         xF0Xz9tIPS0I1th3mXRyJTRB1MS0RtK+ynTvlj0ictG8lkpVzXV9i8pij9ZlRvDGIv7X
         J77Is8JmTttUmWu47FpWgnBtoLOrwvd2BLLzGuRfuc8YKQkupTlQihEEv0QAprebBud9
         QKocE8xLpY8ZVurU60EDOo+wVWgytUElsVs7t1Nr8nuTT2FoxDG/WcOdJI227sChT+4K
         HCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dhh6nNTG3cQbu2+/UY4E9ECxQouXbUNsJMhUFHHFteY=;
        b=NvX31PqVaKwvWivVRUhe4NczcS+2YB8uAzGWtTwtU32j8YkvFcZJKGghMhdBQN7pXV
         oZs5t490srMSTdGqMtBNeb74Ng9CqP8NsXkGlAH7wl9uEsfud/acNjbe8vgI6ETK06Qn
         3o1DZDJiJSNGmC3OYCK/h3ygi04yZoToCJ19MGlLrqjNoXZFAAe9k2PLs5sVnYuDs9Aw
         9/glAWLDRvE8w6Yl5OPDHVjSb6YTqiRIkSKuVNxXlpWDj/U5GJazvJqTX7six51U92pM
         dByvDgA3Puui7Y29CIOAxyhG0qC/JiEHM24I5ivH3WhBUsD8bRNM0Ix467cigMoKu6fh
         OBXw==
X-Gm-Message-State: ACrzQf3fxGpD5PtCudyClohaYgWepC7ArQTLhHqDUx4Xeer+UUY3kjqG
        MwXeL1bWGS3/NL9QOCGc2a4FQJCcCokYmg==
X-Google-Smtp-Source: AMsMyM6F+WpFg+vop57ZHvOS+i+7ShMPC3QW8oqdWbw+jDkUFuaaoSf9WA/vKypuhtRzTjzyUPW98g==
X-Received: by 2002:a2e:a0cc:0:b0:26d:b6c8:ff8a with SMTP id f12-20020a2ea0cc000000b0026db6c8ff8amr1088268ljm.492.1664455207490;
        Thu, 29 Sep 2022 05:40:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o17-20020a056512051100b004a054535826sm777972lfb.24.2022.09.29.05.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 05:40:06 -0700 (PDT)
Message-ID: <5445adda-80e6-41d0-9786-c26d253631c9@linaro.org>
Date:   Thu, 29 Sep 2022 14:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] dt-bindings: add bindings for QCOM flash LED
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     collinsd@codeaurora.org, subbaram@codeaurora.org
References: <20220929121544.1064279-1-quic_fenglinw@quicinc.com>
 <20220929121544.1064279-3-quic_fenglinw@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929121544.1064279-3-quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 14:15, Fenglin Wu wrote:
> Add binding document for flash LED module inside Qualcomm Technologies,
> Inc. PMICs.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>

Thank you for your patch. There is something to discuss/improve.

> +  reg:
> +    description: address offset of the flash LED controller
> +    maxItems: 1
> +
> +patternProperties:
> +  "^led[0-3]$":

In such case: ^led-[0-9]$"

> +    type: object
> +    $ref: common.yaml#
> +    unevaluatedProperties: false
> +    description: |
> +      Represents the physical LED components which are connected to the
> +      flash LED channels' output.
> +
> +    properties:
> +      led-sources:
> +        description: |
> +          The HW indices of the flash LED channels that connect to the
> +          physical LED
> +        allOf:
> +          - minItems: 1
> +            maxItems: 2
> +            items:
> +              enum: [1, 2, 3, 4]
> +
> +      led-max-microamp:
> +        description: |
> +          The maximum current value when LED is not operating in flash mode (i.e. torch mode)
> +          Valid values when an LED is connected to one flash LED channel:
> +            5000 - 500000, step by 5000
> +          Valid values when an LED is connected to two flash LED channels:
> +            10000 - 1000000, step by 10000
> +        minimum: 5000
> +        maximum: 1000000
> +
> +      flash-max-microamp:
> +        description: |
> +          The maximum current value when LED is operating in flash mode.
> +          Valid values when an LED is connected to one flash LED channel:
> +            12500 - 1500000, step by 12500
> +          Valid values when an LED is connected to two flash LED channels:
> +            25000 - 2000000, step by 12500
> +        minimum: 12500
> +        maximum: 2000000
> +
> +      flash-max-timeout-us:
> +        description: |
> +          The maximum timeout value when LED is operating in flash mode.
> +          Valid values: 10000 - 1280000, step by 10000
> +        minimum: 10000
> +        maximum: 1280000
> +
> +    required:
> +      - led-sources
> +      - led-max-microamp
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +    spmi_bus {

No underscores in node names, so just "bus"

> +        #address-cells = <1>;
> +        #size-cells = <0>;

Best regards,
Krzysztof

