Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577596BE8E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCQMLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCQMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:11:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7EBB420E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:11:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g17so6224317lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679055104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nv1WVingwKQqcczYi8r8VBOd0VikPJkwNV75HJHOc0=;
        b=n5o7j0lVrENy0i3VuG3fuFH3roBx9qJHhS5QR2EpySWyeFbVL1wpv74Soc9yHgcIYs
         RZ9NdCvNgMjKMSpdZJnrZGhX7LhefQB7ERV3bAnNmKy/jcryYY1RS28RbvdHcB1pxiNJ
         TUGQLKkK1AUlLf8RWYd5LD6XCM3wwaMYAaNF/I8+tA72z6DvlSOWhcLP0f4f0TmqTrP2
         zX9QCaPgZCQDBJlMkO4nB7noNZhYck7Twa+uItXMuVFMVkZHmyFGPN/4ZHpZoHOZKdQ+
         Q7nKbxm21kH+8vC3S7g8ehS5/Bm9jMMKWcWLEjPH4RXx2HdxnX0DKAIrWf85g/Jpe/cr
         9Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679055104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nv1WVingwKQqcczYi8r8VBOd0VikPJkwNV75HJHOc0=;
        b=UUWyK2INBIY6RV0UwPiD7gz5SKX5VwN6Etx/eskQ39SuGJZPoCCyPHJ9jrBk/T7GwF
         DEaY2AXxisZweNapxdvW79VNL55fCynM/pRdKVstDRP2ebZ/BlBfCDLieDghq2yJHDUV
         BA3BEzxEwfa6C8Ul9zLcAVKsU0JZAMbvGL9pG11aUysJe3EacFuwvO+y6AN5Lps3o1TU
         axmIZ+j4LS+MCvyyXlx05DfmyIJMyGchLhUnHvnmZjo5dADXFxEMcV4pfp1io9kYmyC2
         8TmlzFBS0/cTjxHU6SxjNXr1XCpkotjYBqrMZhrosDi35lre/LIUfd4/VkOI5+Lgxity
         Ls9w==
X-Gm-Message-State: AO0yUKUmRmx/MwGYzgP2Zr8C3/CIni9gFyrt4YKjRqOBSQGjBN8eQaHo
        N3oVQXlff0TRRLRokN3+RPaE/A==
X-Google-Smtp-Source: AK7set+SITW6PfVyW0vx/b6QUwTQu4cULmJDZbRF+ch64jkCjg5miyQdWBlyuzqsrmRjQJ3jp+rO+w==
X-Received: by 2002:a19:ae0c:0:b0:4dd:840d:462 with SMTP id f12-20020a19ae0c000000b004dd840d0462mr940064lfc.21.1679055104657;
        Fri, 17 Mar 2023 05:11:44 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w10-20020a19c50a000000b004e84a8c3d86sm363638lfe.42.2023.03.17.05.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:11:44 -0700 (PDT)
Message-ID: <63037930-8ce4-532c-2e1a-0711005bdd77@linaro.org>
Date:   Fri, 17 Mar 2023 13:11:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/5] dt-bindings: clock: qcom,gpucc: Fix SM6350 clock
 names
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
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1d0c894b-ccd4-348f-0c48-c6a5c89df27d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.03.2023 09:37, Krzysztof Kozlowski wrote:
> On 16/03/2023 12:16, Konrad Dybcio wrote:
>> SM6350 GPUCC uses the same clock names as the rest of the gang, except
>> without a _src suffix. Account for that.
> 
> Why not fixing the names instead (to use the same)? If the clocks are
> the same, why using different names for the inputs? To remind - these
> are not names of clocks in GCC, but names of clock inputs to the device.
Considering SM6350 is the only used of SM6350_GPUCC and it's not yet
in next and I don't think any other project using devicetree has
Adreno up on any platform, let alone this one, I suppose the ABI could
be broken and the driver could be made to expect the more common set
of names? Or I could transition it to index-based lookup?

Konrad
> 
>>
>> Fixes: 7b91b9d8cc6c ("dt-bindings: clock: add SM6350 QCOM Graphics clock bindings")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../devicetree/bindings/clock/qcom,gpucc.yaml      | 29 +++++++++++++++++++---
>>  1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>> index db53eb288995..d209060a619d 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>> @@ -43,10 +43,8 @@ properties:
>>        - description: GPLL0 div branch source
>>  
>>    clock-names:
>> -    items:
>> -      - const: bi_tcxo
>> -      - const: gcc_gpu_gpll0_clk_src
>> -      - const: gcc_gpu_gpll0_div_clk_src
>> +    minItems: 3
> 
> Drop minItems, not needed as it is implied by maxItems.
> 
>> +    maxItems: 3
>>  
>>    '#clock-cells':
>>      const: 1
>> @@ -71,6 +69,29 @@ required:
>>  
>>  additionalProperties: false
>>
>>
> 
> Best regards,
> Krzysztof
> 
