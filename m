Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F7D6D16F7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCaFuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCaFuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:50:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC48BDF1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:50:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l14so14060158pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680241805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3nkvz76Kmrv3hbovEY5+v+WAWeK34sXiKeBzdNDn28=;
        b=zi9O+FHEk8cymIknF2sF8w8nxwV62xUF/t07fVO2BRUgoI9k9MRO6Fptd2ONhwz0B0
         hAAhLQb8dFanGQbHR94e/iFwtYbnDjsD2vhcJGJxKdHawFz+lMFav0wC+pXjjAImvhZR
         3bIvGTNwbOps4JCjijHWSkz2ev/ViQCKwKOmdz/3887YniTd4kHT4jOsziK04Zy8xCVA
         li7t2EhbVKeHOxeCGMWOANbnazUrUHfskFZR7rf6nVKdII4si5/qq1ZZvCCv0QuWPDg7
         yOgmmQ218QaG1jWNLgBgi5TUEOseNDjubFJN9Dg5smndSmXtzlPv7bZr/vd9yFjJO+8n
         z27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680241805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3nkvz76Kmrv3hbovEY5+v+WAWeK34sXiKeBzdNDn28=;
        b=XkTsBK+p20ufX87lHkS1ltpZ6cbzjbAXBOtqCu1jvboBW4PU8hF/Oh1g1OzYS8tQcL
         vfbj0qCPfSv+YNxbLgsB1h8w7PMbIGPPZG+aYIVRg1GeAb4gJpAoh5GuFhLFo7qgGmKj
         6rnTM3lzMvNavGJXsqkchvinTWLyUFv8T4pdINvb3vrHN45+We9xc0cy0teVElMBI/bP
         rWdC8ZVlXoQkINdhHErle/c25io2xJtuKciEsSVLeU/1dB8zXER3Q+n7kSu7a54F58tp
         YexqSqFdVm+t3YYjz8E+CpwqX996YPgu/dIKhxmmzJHD5IdwmuMiW5vIo6IQbiq9EHWi
         QLSA==
X-Gm-Message-State: AAQBX9eKs9Es6hCte89V4nIM861AR/nhacZq/00bfcelbQPZEbHGhOAS
        6U9imGBfxqJ95EH7x6EkQgvHbw==
X-Google-Smtp-Source: AKy350ZRFpWG1nNLD5QMFXlw8ACbFlfLgTo16+2Yh0cJ0QDQ/HhLm6U1Bx0O3HYkjmrm97EoHs8NnA==
X-Received: by 2002:aa7:9601:0:b0:624:2e60:f21e with SMTP id q1-20020aa79601000000b006242e60f21emr25262492pfg.29.1680241804749;
        Thu, 30 Mar 2023 22:50:04 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c5e:53ce:1f39:30a5:d20f:f205? ([2401:4900:1c5e:53ce:1f39:30a5:d20f:f205])
        by smtp.gmail.com with ESMTPSA id bv129-20020a632e87000000b00508e7bd761fsm740351pgb.87.2023.03.30.22.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 22:50:04 -0700 (PDT)
Message-ID: <a3c692bf-9ca7-d15a-4f1d-c5a31d1b82f6@linaro.org>
Date:   Fri, 31 Mar 2023 11:19:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 1/9] dt-bindings: dma: Add support for SM6115 and
 QCM2290 SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
References: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
 <20230328092815.292665-2-bhupesh.sharma@linaro.org>
 <76982d25-cba5-2a18-387f-b1735eef21fe@linaro.org>
Content-Language: en-US
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <76982d25-cba5-2a18-387f-b1735eef21fe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 3/30/23 1:41 PM, Krzysztof Kozlowski wrote:
> On 28/03/2023 11:28, Bhupesh Sharma wrote:
>> Add new compatible for BAM DMA engine version v1.7.4 which is
>> found on Qualcomm SM6115 and QCM2290 SoCs. Since its very similar
>> to v1.7.0 used on SM8150 like SoCs, mark the comptible scheme
>> accordingly.
>>
>> While at it, also update qcom,bam-dma bindings to add comments
>> which describe the BAM DMA versions used in SM8150 and SM8250 SoCs.
>> This provides an easy reference for identifying the actual BAM DMA
>> version available on Qualcomm SoCs.
>>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   .../devicetree/bindings/dma/qcom,bam-dma.yaml | 22 +++++++++++++------
>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> index f1ddcf672261..624208d20a34 100644
>> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> @@ -15,13 +15,21 @@ allOf:
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -        # APQ8064, IPQ8064 and MSM8960
>> -      - qcom,bam-v1.3.0
>> -        # MSM8974, APQ8074 and APQ8084
>> -      - qcom,bam-v1.4.0
>> -        # MSM8916 and SDM845
>> -      - qcom,bam-v1.7.0
>> +    oneOf:
>> +      - items:
> 
> Drop "items". This is just an enum.

Sure, will fix it in v4.

Thanks

>> +          - enum:
>> +              # APQ8064, IPQ8064 and MSM8960
>> +              - qcom,bam-v1.3.0

