Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2288D66246B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjAILmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbjAILl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:41:28 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACAA2DFC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:41:04 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id o7so8213863ljj.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 03:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/tHPRvN2kH9+ou065o/tSnqEbVr+L3o1B3YpzQ3ZLo=;
        b=tsSuSZPtRvU6Dbtnj4ydxBHB7XlbmNkhIT5K3ASmIJcFoputsZPLcaM8KYKP9xvg22
         +n7kFCUjlunsd644vfJvsCka4sUGGPJo4hrcHU0EuSoQelup6N0rrMO8zv1OVeROksv4
         05t/N52WtOE7fZZXR4Jc8f+UgZ7lknwN4YTW56gJPR5PV/LIXico+qwTQndTMW9KoE93
         VXy1LE+nQp/EfsduLZ3ADCT1hg3I+404Oi+osWA3jZDRkxFTMX7EBTlZRk5UWjZbkjkL
         w5Jibbddi1m0SFVbc0IaqaedPtO4CA50MYy/4ZgaZKzwU79AnaI+tPUqftqOd9ych/Lp
         rknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/tHPRvN2kH9+ou065o/tSnqEbVr+L3o1B3YpzQ3ZLo=;
        b=2VPirTCZTpcI3ANNSMmHiJCoN+T3kdRUQwK+s4RYZtI83GVJ5wHtDx00cFQhLzPbi/
         6Zd4KZW26n2V6o7tGzlnBfZFrPD22xp4rDYfZvEfg0PH4/N/sCgL4p+BRicrX8MEQVh0
         P0j2V4AkpsiblbCw0VV/BWfcjUylTF3aL7c+0ZETGNjT73GrMo1lp+7rk63k4m2FfSnl
         Edme3UfR80E0wiJ7KyozM9SNdPmFWZT/o4jNgPmKDvpW1pAmTHjjfcMiydZPxykvA1of
         VKIelg+Ww72TmjJ72M1qaYhBcZrVr2+TzEKms5BBjyxFMRKbr2P7QXbV7jFDlPAhTdhn
         lNjQ==
X-Gm-Message-State: AFqh2koRoyZ9u8afEAjPYWjXg59HoQUi7DdyObJKQ3k585xjdOr2Mr1P
        /XsrjegPhLLBSaDAoB+ndwoqqg==
X-Google-Smtp-Source: AMrXdXu8jhoAYmgM2b/4FQeYsYSxLSgFAnhLA/LN+U6TyUSc2NBgcq1EPEmtZ/l2NtSUM/RkgTdwkQ==
X-Received: by 2002:a05:651c:333:b0:27f:ed97:7c7e with SMTP id b19-20020a05651c033300b0027fed977c7emr6451350ljp.24.1673264462376;
        Mon, 09 Jan 2023 03:41:02 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id 12-20020ac25f0c000000b004cb3aced3f9sm1584030lfq.226.2023.01.09.03.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 03:41:01 -0800 (PST)
Message-ID: <97dafa30-8b76-8bf9-4411-be6d10e4c71a@linaro.org>
Date:   Mon, 9 Jan 2023 12:41:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/3] dt-bindings: reserved-memory: rmtfs: Make
 qcom,vmid an array
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230109093947.83394-1-konrad.dybcio@linaro.org>
 <2bc5d781-499b-fe39-2dc5-92bc9ba8396d@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2bc5d781-499b-fe39-2dc5-92bc9ba8396d@linaro.org>
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



On 9.01.2023 10:51, Krzysztof Kozlowski wrote:
> On 09/01/2023 10:39, Konrad Dybcio wrote:
>> Some SoCs mandate that the RMTFS is also assigned to the NAV VM, while
>> others really don't want that. Since it has to be conditional, turn
>> qcom,vmid into an u32 array so that we can handle the NAV case, as
>> well as other similar ones if they pop up in the future.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> v2 -> v3:
>> Rewrite to accomodate for changes, don't pick up tags
>>
>>  .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml   | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
>> index 2998f1c8f0db..cfc2fda30eba 100644
>> --- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
>> +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
>> @@ -27,9 +27,9 @@ properties:
>>        identifier of the client to use this region for buffers
>>  
>>    qcom,vmid:
>> -    $ref: /schemas/types.yaml#/definitions/uint32
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>      description: >
>> -      vmid of the remote processor, to set up memory protection
>> +      Array of vmids of the remote processors, to set up memory protection
> 
> You need now min and maxItems.
Hm, I tested it with and without:

minItems: 1
maxItems: 2

on DTs with either one or two VMIDs defined and neither complains..

Konrad
> 
> Best regards,
> Krzysztof
> 
