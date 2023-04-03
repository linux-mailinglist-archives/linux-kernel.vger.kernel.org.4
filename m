Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC966D4FEA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjDCSFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjDCSFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:05:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE722134
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:05:43 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a44so12610796ljr.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680545141;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R2HkI4cTUCP2cGZwi+QRGyuqlnwQLBxlin1+ogWHLy0=;
        b=n+uZs52IEvopHGjLJv5ixfblvCWQcA1693SNNBJWwcON5Q1A+UQmyoann/sytlgRV3
         h22PLDHHsK1oHhUdDvOmWtT7qRxVuP1jhyX+fA8/SNbCmNuN50YJ18azzbuePwHm9ttq
         x/d+cKjz5bkKlH5LHF2SLD0/JBSAXmCrW2rxhdl/tkF/UgGOvO4rdtKFzaGm8DkeJT6R
         j5xX1nBp4irYyyPOkiHeKRt68tKidcB+4mY9zNwfefcG2X8MbtDy2RbLxq3uecq3DWNg
         PzV89xuM9gx2e6rIUwj3ecj6KGM6UxPMlLIdLh9hKhocdWyrJ9pgA+s4Xj9iukX4kt9e
         NjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680545141;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2HkI4cTUCP2cGZwi+QRGyuqlnwQLBxlin1+ogWHLy0=;
        b=TpILv3s3S/5Sy2/Gpy5kVnLXUM1m+2Uj5iDm8FQfAPap/nJRpi1wBF0GRvVLt/CZBF
         FTlwprkCNttZLTPhKi0EhBYJ8L6ivjYR4/bPsi2VROU9YEPKKe05sVQSAR1Vrep3e6fE
         UGOica4RMXQuubJ16/k8rqhbw36nZzTfmjHRepSNEtuweyQV1QataxOYAIgGLmDkn0Mm
         SFqVp+j+ZEJO+vU31hPVR95tqYFzOCRSehRHOOa7GkSkKiqA3Kz4aceE99AmPlsFJHJD
         qQyhKkAK2jJFszO9TxlLLPlZPUaHWFRP2bHtp2EYwvOjYGhOv8aDBtnmC7rtQTRvDePp
         6UmQ==
X-Gm-Message-State: AAQBX9doJRp0zSXlgqELqnOGe/FsTT9K1kqXq7uBw5P0p0xRjCHPiWmE
        8JX9wiX5NPABzrRYYjOQEG5ETw==
X-Google-Smtp-Source: AKy350Y/q2Hrwz8PlPoUGUnxQyh1S12S5N9FBlDdGljkYL+7RNeVy94u6bcoheHGJs6zsQ4+3FJ51Q==
X-Received: by 2002:a2e:80c5:0:b0:293:1565:4353 with SMTP id r5-20020a2e80c5000000b0029315654353mr125952ljg.10.1680545141478;
        Mon, 03 Apr 2023 11:05:41 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id u22-20020a2e2e16000000b002a260e3a5bdsm1860320lju.27.2023.04.03.11.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 11:05:41 -0700 (PDT)
Message-ID: <8b8540a9-505a-2b68-c246-fabba0f5fc37@linaro.org>
Date:   Mon, 3 Apr 2023 20:05:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/5] dt-bindings: clock: qcom,gpucc: Fix SM6350 clock
 names
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
 <20230315-topic-lagoon_gpu-v1-1-a74cbec4ecfc@linaro.org>
 <1d0c894b-ccd4-348f-0c48-c6a5c89df27d@linaro.org>
 <63037930-8ce4-532c-2e1a-0711005bdd77@linaro.org>
In-Reply-To: <63037930-8ce4-532c-2e1a-0711005bdd77@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.03.2023 13:11, Konrad Dybcio wrote:
> 
> 
> On 17.03.2023 09:37, Krzysztof Kozlowski wrote:
>> On 16/03/2023 12:16, Konrad Dybcio wrote:
>>> SM6350 GPUCC uses the same clock names as the rest of the gang, except
>>> without a _src suffix. Account for that.
>>
>> Why not fixing the names instead (to use the same)? If the clocks are
>> the same, why using different names for the inputs? To remind - these
>> are not names of clocks in GCC, but names of clock inputs to the device.
> Considering SM6350 is the only used of SM6350_GPUCC and it's not yet
> in next and I don't think any other project using devicetree has
> Adreno up on any platform, let alone this one, I suppose the ABI could
> be broken and the driver could be made to expect the more common set
> of names? Or I could transition it to index-based lookup?
Comments, please?

Konrad
> 
> Konrad
>>
>>>
>>> Fixes: 7b91b9d8cc6c ("dt-bindings: clock: add SM6350 QCOM Graphics clock bindings")
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  .../devicetree/bindings/clock/qcom,gpucc.yaml      | 29 +++++++++++++++++++---
>>>  1 file changed, 25 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>>> index db53eb288995..d209060a619d 100644
>>> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>>> @@ -43,10 +43,8 @@ properties:
>>>        - description: GPLL0 div branch source
>>>  
>>>    clock-names:
>>> -    items:
>>> -      - const: bi_tcxo
>>> -      - const: gcc_gpu_gpll0_clk_src
>>> -      - const: gcc_gpu_gpll0_div_clk_src
>>> +    minItems: 3
>>
>> Drop minItems, not needed as it is implied by maxItems.
>>
>>> +    maxItems: 3
>>>  
>>>    '#clock-cells':
>>>      const: 1
>>> @@ -71,6 +69,29 @@ required:
>>>  
>>>  additionalProperties: false
>>>
>>>
>>
>> Best regards,
>> Krzysztof
>>
