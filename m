Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677876B81E2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCMTyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCMTyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:54:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E44347A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:54:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so12856717pjg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678737254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IIRpccnj6QdWaP+7djIK0B82m70OeUvp6oiDbiM2NyY=;
        b=sBpLJ+pwrdjzadrhoAhhR92IWQPiGL8BV/PZ+8Yv21zLaf0IlPFpjg5aKxThafUlyK
         cTdd++/jVmnM5xndiaYa1R/iRFObBdqC8qf27vTmeAEJj9iIpmpAtU0blv9EKRVMOJMu
         kurZdmTYaA1C0GXvQmHSUr59C6Wm5SS+HdXGSi2CWie1vO/zo20fucspo505nB53SFz9
         yRd+aPqintpYobBQckGgfXFKpa1v6XvnOY6FnSdHubc6OUMVIsVMAEMSjHvOkJJCSWC2
         51cv12vClcj7koN8DtPEa/ZE9J5VdDXDzAeKEzwAHPejalFzcXTX3yG40gdw4/WQGW8x
         y/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIRpccnj6QdWaP+7djIK0B82m70OeUvp6oiDbiM2NyY=;
        b=fnP94KxlYRANjYDI66MgtEDStoorOoFEERWIRCbdeDW0QdWipPLC6PlYFn1wWkFR3c
         p+RWB4IZUeNEOAbDXX3WrLAsnv5GikPee3FjhNdF6alY+S32COyY21VNUgmnD/p0irAO
         l4s9cmgaPM22abHqHYp2KoEQk7lyWk8b5M9QW3W9OGTtE6dg2gz3SOAoqB8Pwunkzuan
         bTS6M62/A2tWt2oVvsHRPwXqKZ2dQlF2j1bnQcQTy17n2myPBhPLB5n9kutlmlbuEmPY
         tlWJVOc8Jxrpdr0g8ayd+26PgSvap2lqe2NgxuFYf1phMEG5A5GXFY/Q7bwdV45sTIBz
         nKKw==
X-Gm-Message-State: AO0yUKVhN39RZbDAHtE/SZvXsN3sKhJC+M3TNH72FA2Got/2TT7YfR+w
        CGUXhYptuqUvzqxCf3ZyYZUYnO3FGg+JQAgJ+pw=
X-Google-Smtp-Source: AK7set+BggVToSySWpaN9jUkKsW5DIa7uiTKL/TI0z17kIwb6FoN7xVsApFGpvy6dzvv/SAvv7uEaQ==
X-Received: by 2002:a05:6a20:8e07:b0:cd:d13:8a6e with SMTP id y7-20020a056a208e0700b000cd0d138a6emr40737807pzj.21.1678737254616;
        Mon, 13 Mar 2023 12:54:14 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c5e:4a3e:15d0:d540:3861:ef0e? ([2401:4900:1c5e:4a3e:15d0:d540:3861:ef0e])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b0050362744b63sm99565pgv.90.2023.03.13.12.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 12:54:14 -0700 (PDT)
Message-ID: <99b7f8c2-38d5-9912-06aa-65beb723cfcf@linaro.org>
Date:   Tue, 14 Mar 2023 01:24:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] dt-bindings: remoteproc: qcom: Add sm6115 pas yaml
 file
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     mani@kernel.org, mathieu.poirier@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230128053504.2099620-1-bhupesh.sharma@linaro.org>
 <20230128053504.2099620-2-bhupesh.sharma@linaro.org>
 <7cbd882d-c71c-ad92-6dbe-0f178043fdfd@linaro.org>
Content-Language: en-US
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <7cbd882d-c71c-ad92-6dbe-0f178043fdfd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 3/9/23 1:56 PM, Krzysztof Kozlowski wrote:
> On 28/01/2023 06:35, Bhupesh Sharma wrote:
>> This documents the aDSP, cDSP and MPSS DSPs present
>> on the SM6115 SoC.
>>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   .../bindings/remoteproc/qcom,sm6115-pas.yaml  | 143 ++++++++++++++++++
>>   1 file changed, 143 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
>> new file mode 100644
>> index 000000000000..f5d1fa9f45f1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
>> @@ -0,0 +1,143 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/qcom,sm6115-pas.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm SM6115 Peripheral Authentication Service
>> +
>> +maintainers:
>> +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> +
>> +description:
>> +  Qualcomm SM6115 SoC Peripheral Authentication Service loads and boots
>> +  firmware on the Qualcomm DSP Hexagon cores.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sm6115-adsp-pas
>> +      - qcom,sm6115-cdsp-pas
>> +      - qcom,sm6115-mpss-pas
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: XO clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xo
>> +
>> +  memory-region:
>> +    minItems: 1
> 
> maxItems instead
> 
>> +    description: Reference to the reserved-memory for the Hexagon core
>> +
>> +  smd-edge: false
>> +
>> +  firmware-name:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: Firmware name for the Hexagon core
>> +
>> +required:
>> +  - compatible
>> +  - reg
> 
> also memory-region


Since this patch was already picked up by Bjorn, I will send a fix as 
per your suggestion as a separate patch shortly.

Thanks,
Bhupesh

