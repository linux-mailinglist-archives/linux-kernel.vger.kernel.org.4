Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5456CD852
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjC2LTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjC2LTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:19:02 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA34481
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:18:49 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s20so15672595ljp.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680088728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aumpSLpdIfLau4SMf/sV4ChK4mZM2lEguzptioMGQ4U=;
        b=uFwVrsI6SSC2d9PykTW4cU7uDFJl43V+qNoP5Mu9QsCHu21y6cgb5yiaCUIA8gcaE6
         jjUixrJNaWA1Cj+Nmuvxm26mz/COosJGIcydHRU5IXxvq7hB8lFlte0K+AiRc89sH5vZ
         R7KEWf9G/LC/tLe122uw/eB1mbeS+uaBQFi1yCdDM+apYT2Z7ca2ENnNyIBDDQIAE8JV
         +lxiLDOGiQZqygnP33zQAp+4hlaecddzfea4juzVcxvG1X54WucAwLCDvYYRKgoa7K3N
         3ZTvWzmgYW5m9I2iOHEy8Qy6GVl9d2U3LtxcOGI8AlkIeKPyeVHUmiJA2pj46nT0rvPP
         jrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680088728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aumpSLpdIfLau4SMf/sV4ChK4mZM2lEguzptioMGQ4U=;
        b=KF/RdhR3am83h/A3XOFM5xsEOdUy7n7gWAgN6ZO1v7cezmduaPA/S6BoxlVftqdOw7
         T28S/SVKL7mfc/dU/2EDH2wmTypUpnS6TxGLcLu6LWWxajggso144LDzD1La44re4ZUR
         aH32CQQShsa41bLtGMvBAUl4J+CZSXLWnjJ2XNTEpQkXCA7PwilfOx2Nymou2OxdVv+q
         VrWIMnbXc1xUhrod4YLiXROsy2WrfgbunUIk8691cehXSAbUzHwZ6H3m5H29dzUKRxSI
         134PhUleRdkhU1alHbmGONGU1T5BgL4c8evTkU3BP2B+KJqpBw9HJ4coqDNg+LojZUgf
         tv+Q==
X-Gm-Message-State: AAQBX9fjjWGVGDPeL7Loac/v0XsJF34NI30JK59VlXP1ACq5mAvToRFa
        jTUT1AmhcGBcoHNtI92ns0O8lQ==
X-Google-Smtp-Source: AKy350Y+FUEY3T5G6lVTIZU60xd7NyIE28Cebhu9hQFEyNetn4hH5Q2gpXeT36vTCVqan1zZiOD9Tw==
X-Received: by 2002:a2e:3011:0:b0:298:b338:f5db with SMTP id w17-20020a2e3011000000b00298b338f5dbmr5451392ljw.52.1680088728062;
        Wed, 29 Mar 2023 04:18:48 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id u9-20020a2e8449000000b00293534d9760sm5490627ljh.127.2023.03.29.04.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:18:47 -0700 (PDT)
Message-ID: <09f50ca6-3480-0c8d-9494-35893393d205@linaro.org>
Date:   Wed, 29 Mar 2023 13:18:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: mpm: Allow passing
 reg through phandle
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
 <20230328-topic-msgram_mpm-v1-1-1b788a5f5a33@linaro.org>
 <863d5a85-3399-5a43-b755-1316e3adcfec@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <863d5a85-3399-5a43-b755-1316e3adcfec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.03.2023 10:27, Krzysztof Kozlowski wrote:
> On 28/03/2023 12:02, Konrad Dybcio wrote:
>> Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
>> use 'reg' to point to the MPM's slice of Message RAM without cutting into
>> an already-defined RPM MSG RAM node used for GLINK and SMEM.
>>
>> Document passing the register space as a slice of SRAM through the
>> qcom,rpm-msg-ram property. This also makes 'reg' no longer required.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../devicetree/bindings/interrupt-controller/qcom,mpm.yaml          | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
>> index 509d20c091af..77fe5e0b378f 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
>> @@ -30,6 +30,11 @@ properties:
>>      description:
>>        Specifies the base address and size of vMPM registers in RPM MSG RAM.
>>  
>> +  qcom,rpm-msg-ram:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the APSS MPM slice of the RPM Message RAM
>> +
>>    interrupts:
>>      maxItems: 1
>>      description:
>> @@ -64,7 +69,6 @@ properties:
>>  
>>  required:
>>    - compatible
>> -  - reg
> 
> Either:
> 1. make reg deprecated and require qcom,rpm-msg-ram
> or
> 2. you need oneOf:required for reg and qcom,rpm-msg-ram
Right, let's go with 1.

Konrad
> 
>>    - interrupts
>>    - mboxes
>>    - interrupt-controller
>>
> 
> Best regards,
> Krzysztof
> 
