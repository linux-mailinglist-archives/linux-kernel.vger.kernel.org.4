Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B23C6FB26C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjEHORy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjEHORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:17:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424EF19AF
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:17:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9659c5b14d8so737991466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683555469; x=1686147469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ownDs96VmZuf2SD3gS4UazEGTd4JsZ/cGQWhog0hNx8=;
        b=iu+iZGfPr4HbdXLGQeG5JZH80mbVi4fy7axe2WAwYlOvsmJ3zh2Z5gbnd+Jq//v/RJ
         hgkUFpB/STejIWxcxxYvXlsQzOd7/aN1Rc7JBXrfLo2FesYT8SOGtYs3VgzN7OXS8amJ
         ab4KD//BjGTO+eoplp2ZCIMc0gtGbg5EaJqt6yUi39vpfNAue9xvU/THJPbTmsuq9gD2
         Kb6XtVEKaqleJROnJRNQf4UNxNAwrwrrT+T9w0fWotk8JA5XZdpIqrfK2mUhOAr50Ofj
         onwKO8p7VFAOku/1HDv8vlyqmSORhuMlo/BK1wfQghwAMW0VlBq12IaQ/ubTIIJUqWHp
         VuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683555469; x=1686147469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ownDs96VmZuf2SD3gS4UazEGTd4JsZ/cGQWhog0hNx8=;
        b=SGJMfvu3Lyp3WtWcTRRTJYjlWY9ZItMkpluyCedPHN948s0NVBOxRn/xD6004NFjyM
         9tTsaqsE5Pqy8cscVHBVVnCyTbXy4JYth2q13vsfzF0KujrvkYhNVFc2aVP6keUL2gXv
         z+NFlJtZkHVXDLbVc7jA1ryFQpJ7fZCxA1WwSkhZdQ3Ul1HJr4ziA0co4Y1UfWelT+6s
         nSQ9q8vd++DRXb8t7nuk0BN+3K2+H6EY07uXKklmd/wjD/ohZFN3r/NB5pqS0RwTCszr
         CHK6vGY5+Pi2HPtq3tRfHAW2SCclKpiWnfnJ19MiWOFZVrRfDKFUE5d4x7n0JNAkK2TL
         roCA==
X-Gm-Message-State: AC+VfDxq+afe8qqjYlxIW5JyRkHyCW4DpJfbPU3lkslfCoAPI6TEp6Y8
        uc34d0Qv26AhlUfnef8LLOoDxg==
X-Google-Smtp-Source: ACHHUZ560sKldiqrIMjg1ekA7xnXwChXcannOgDV/O9OwzIlwtcHkzpXwhvGDxk9FWQR5cgmnyBKOw==
X-Received: by 2002:a17:907:2d26:b0:94f:3804:5cd6 with SMTP id gs38-20020a1709072d2600b0094f38045cd6mr9550720ejc.66.1683555468736;
        Mon, 08 May 2023 07:17:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906338900b0094ee99eeb01sm21627eja.150.2023.05.08.07.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 07:17:48 -0700 (PDT)
Message-ID: <7e16c25d-ab17-741a-1c7c-6cf1462eef5b@linaro.org>
Date:   Mon, 8 May 2023 16:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs
Content-Language: en-US
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Kristiansson <stefank@nvidia.com>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
 <20230508122048.99953-5-pdeschrijver@nvidia.com>
 <43945fad-f57b-cfd9-78bd-9ec9e6628382@linaro.org>
 <MW3PR12MB4346ED32BBE6EAA7CB8C91A8B1719@MW3PR12MB4346.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MW3PR12MB4346ED32BBE6EAA7CB8C91A8B1719@MW3PR12MB4346.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 16:12, Peter De Schrijver wrote:
> 
> 
> ________________________________________
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: 08 May 2023 17:04
> To: Peter De Schrijver; thierry.reding@gmail.com; Jonathan Hunter
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; devicetree@vger.kernel.org; linux-tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Stefan Kristiansson
> Subject: Re: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs
> 
> On 08/05/2023 14:20, Peter De Schrijver wrote:
>> Add bindings for DRAM MRQ GSC support.
>>
>> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
>> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> ---
>>  .../firmware/nvidia,tegra186-bpmp.yaml        | 69 ++++++++++++++++++-
>>  .../nvidia,tegra264-bpmp-shmem.yaml           | 40 +++++++++++
> 
>> Why touching two files?
> 
> Because both are needed to support having MRQ GSCs in DRAM.

Yeah, but why two in one commit? All patches are needed for full support
and they are not squashed into one.

> 
>>  2 files changed, 106 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
>> index 833c07f1685c..d818cfe1d783 100644
>> --- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
>> @@ -57,8 +57,11 @@ description: |
>>    "#address-cells" or "#size-cells" property.
>>
>>    The shared memory area for the IPC TX and RX between CPU and BPMP are
>> -  predefined and work on top of sysram, which is an SRAM inside the
>> -  chip. See ".../sram/sram.yaml" for the bindings.
>> +  predefined and work on top of either sysram, which is an SRAM inside the
>> +  chip, or in normal SDRAM.
>> +  See ".../sram/sram.yaml" for the bindings for the SRAM case.
>> +  See "../reserved-memory/nvidia,tegra264-bpmp-shmem.yaml" for bindings for
>> +  the SDRAM case.
>>
>>  properties:
>>    compatible:
>> @@ -81,6 +84,11 @@ properties:
>>      minItems: 2
>>      maxItems: 2
>>
>> +  memory-region:
>> +    description: phandle to reserved memory region used for IPC between
>> +      CPU-NS and BPMP.
>> +    maxItems: 1
>> +
>>    "#clock-cells":
>>      const: 1
>>
>> @@ -115,10 +123,16 @@ properties:
>>
>>  additionalProperties: false
>>
>> +allOf:
>> +  - oneOf:
> 
> Keep just oneOf and drop allOf.

???

I wrote this. Fix your mailer.

> 
>> +      - required:
>> +          - memory-region
>> +      - required:
>> +          - shmem
>> +
>>  required:
>>    - compatible
>>    - mboxes
>> -  - shmem
>>    - "#clock-cells"
>>    - "#power-domain-cells"
>>    - "#reset-cells"
>> @@ -184,3 +198,52 @@ examples:
>>              #thermal-sensor-cells = <1>;
>>          };
>>      };
>> +
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/mailbox/tegra186-hsp.h>
>> +    #include <dt-bindings/memory/tegra186-mc.h>
>> +
>> +    hsp_top0: hsp@3c00000 {
>> +        compatible = "nvidia,tegra186-hsp";
>> +        reg = <0x03c00000 0xa0000>;
>> +        interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-names = "doorbell";
>> +        #mbox-cells = <2>;
> 
>> Why HSP example is here?
> 
> Because it's referred to further down the example.

Not needed.

> 
>> +    };
>> +
>> +    reserved-memory {
>> +        dram_cpu_bpmp_mail: shmem@f1be0000  {
>> +            compatible = "nvidia,tegra264-bpmp-shmem";
>> +            reg = <0x0 0xf1be0000 0x0 0x2000>;
>> +            no-map;
>> +        };
>> +    };
> 
> Drop, fairly obvious and should be in that binding, not here.

???

Please use mailing list style of replies.

Best regards,
Krzysztof

