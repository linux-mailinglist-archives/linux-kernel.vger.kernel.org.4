Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E062F6FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbiKROQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242309AbiKROPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:15:43 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FEF8CFD1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:15:32 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x21so6898764ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/vD7enc56atpBczKJzqgTsL6AFCybnSYYQVuhqp1NI=;
        b=qTC4hGd8mEu11HXOae8BTAFj3rb1gcqw6088kJxqNAr+qwAfIa38UYtb7dDIjMT7tn
         XW6WSqHgsjuNXv8a6PcKJnOhRhvqcUAlyJU1iJ1MG3mns4ga0YqRicXJm5QFZT6vKqKb
         XkXaK7aTfXhJcSrKO6Nfe/dcqNayasX+8MFsujGjwRV4bNfFfmzZvplz8UZ4VRtFMtyF
         8iitAyWMbbzEfdRsj2lBi+dfOtrRFyVa3wXDs8GftseQ1GfWVphrEvxJmH2eiggwIOFq
         PyB4S9iFdtdzNF2sEyj+2gmGw+hq71iDMXZ7ccOLdoTd9Sntn/vWUtnYzDRuNvysXQj9
         LM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/vD7enc56atpBczKJzqgTsL6AFCybnSYYQVuhqp1NI=;
        b=piYOqkelXd6uHI1sgiQJ/+W7/804Vn925J0u73GL1EPVtWbifFCUZxrQm8Lwn9zB6l
         H70ANnWLv94WDhlTh3pJqPpmeUwZm1GWjKVSafiGaLq6WWTZxcDfKJGBennk87HqY0fX
         lF5c9ur2TAQHv7KehrVs/uQISNPqyRjsFj2OI9U5dMJ7/LvaVUNVgjF9ZGfXaa+B5Oql
         2maoOBMrwibL4rQRUI+LZu8aM6SD5FRMy3As/YFenKK/tCafpRwPsxUaeSYI4zNdpbmz
         WYMQAZYyHm3BwYkKQgFU0MriVPyjWdSJLAwAxp5cAZBtsB6qxB0E5h39AAxRwdZzozTK
         xgqA==
X-Gm-Message-State: ANoB5plZ1YXHloGeQD+WbKaVjIwQFKZLIR0H8k4MPMO62p4Hx7Ta/AFx
        z4inVaAregS2V/ZGed32eYXFGg==
X-Google-Smtp-Source: AA0mqf5SdFHb+qIiePgEdKZLvmgzQUquFds8rpyUzrc0VMzDO/gX+t/OuV4dCyv5UJI7VZ/grUWjjg==
X-Received: by 2002:a05:651c:1797:b0:277:1caf:679e with SMTP id bn23-20020a05651c179700b002771caf679emr2801330ljb.115.1668780930529;
        Fri, 18 Nov 2022 06:15:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q6-20020ac25fc6000000b004a45f2e49b1sm667033lfg.273.2022.11.18.06.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:15:30 -0800 (PST)
Message-ID: <b818219f-ab28-5bed-e2a2-1884a6dbe061@linaro.org>
Date:   Fri, 18 Nov 2022 15:15:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD Pro
 boards
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org
References: <20221118073017.26128-1-quic_rjendra@quicinc.com>
 <e93a61ce-4c7b-ecb2-7b82-1bde388ec6bb@linaro.org>
In-Reply-To: <e93a61ce-4c7b-ecb2-7b82-1bde388ec6bb@linaro.org>
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

On 18/11/2022 15:13, Krzysztof Kozlowski wrote:
> On 18/11/2022 08:30, Rajendra Nayak wrote:
>> Add compatibles for the Pro SKU of the sc7280 CRD boards
>>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 463509f0f23a..2550ab251f7b 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -613,6 +613,11 @@ properties:
>>            - const: google,hoglin
>>            - const: qcom,sc7280
>>  
>> +      - description: Qualcomm Technologies, Inc. sc7280 CRD Pro platform (newest rev)
> 
> Such entry is already documented. I think this is not based on recent
> kernel.

My bad, I missed this is a Pro. Why it is not part of compatible? What
is the difference between hoglin and CRD Pro?

You have plenty of space in commit msg to explain this.

Best regards,
Krzysztof

