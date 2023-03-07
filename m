Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD66ADF11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCGMsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCGMst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:48:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BE373896
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:48:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cy23so51606892edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678193326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXMDjluJDUvPLUicyi9DzXJkAKHHUVttkvC/e23H4Xg=;
        b=gBNpW4hE+viaph3Z9oHqJD+5k9T0kLFVksSmYDaYHCpYrjYet2Y7xzwCXwhRqORnWg
         wE/6W9M/kc2+Vve5aDGSeGrXaWB8YjgQ1XUCQyjvp3SwsV+/jnfGbM0RdpGcyF9bbsYV
         lOYcZyKaGNtFSN4ipuq8gqyuTT3TnA4YFmx2/+HNIVvKoDFUhMgSCOj0EOxNurAeeMHR
         BKML1W/QnpTHpizWDwPqbpCTwS8V3VqmklGMmeFRE+B+KdKB43IAX7OGr9zWxyZm3Tp3
         zA0DYbSuK1C1R2g2MQFf5E8PEfKrZpH6MuFnOzGHIORxpGRoS/T/AApE89N8YE7aN/l5
         UWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678193326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXMDjluJDUvPLUicyi9DzXJkAKHHUVttkvC/e23H4Xg=;
        b=XKAh6F25BQcgEBECbWtRa4MgoRGjYtHNk9ykasQvcXj3VBYywYawquqQah1G3bllsc
         Q6+janmOIe044HiMF22XPNIWh7F/+b1cWRVBYlRPjWQtnZjwATcXAUI9wROaB9340RBV
         GY8vrvBJXwfqOL/BUJIXaF3/PRXQaT173J1WGxvwd4fnAn3iEcTowQUXuTBa3cfE4LWw
         Z5KaOjyMA0FfYXVUPt4jt7RhPcfM5mhyLYArjAE2A0TXY6AwFN3B6XCwQH/bWHgTBRPh
         QZhSvT4f6Rsc5stbbzZzSinoserZu08zu48iP/L98rlc4eW40UkP4miiHWUl6dKuS9bP
         hVvA==
X-Gm-Message-State: AO0yUKXcxt0cCkDZzwXf9OjpGKkT3tHp5bbpJv3Or0CDF6Qtky3hbF0J
        xahs6dgVWlMErXacSBoA8e+ALQ==
X-Google-Smtp-Source: AK7set8MCzzEe4umSH1sYZCblI6WJ1yy9vx+YgB8ty6up6YK0RjeqU1A/CLPMaRwTV8qico7a1qLyw==
X-Received: by 2002:a05:6402:7ce:b0:4c0:57b:47a9 with SMTP id u14-20020a05640207ce00b004c0057b47a9mr13267661edy.35.1678193326220;
        Tue, 07 Mar 2023 04:48:46 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:a60f:e604:c252:1f3d? ([2a02:810d:15c0:828:a60f:e604:c252:1f3d])
        by smtp.gmail.com with ESMTPSA id le16-20020a170907171000b008da6a37de1bsm6174070ejc.10.2023.03.07.04.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 04:48:45 -0800 (PST)
Message-ID: <de9d5cdb-29d5-8252-6884-dd50a22d1580@linaro.org>
Date:   Tue, 7 Mar 2023 13:48:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 8/9] dt-bindings: display/msm: dsi-controller-main: Add
 SM6115
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
 <20230213121012.1768296-9-konrad.dybcio@linaro.org>
 <bcb5c17f-da78-9d68-66eb-b620ee583602@linaro.org>
 <22970751-8bc0-9cbd-eec1-cbc92f0b4ea7@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <22970751-8bc0-9cbd-eec1-cbc92f0b4ea7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 12:14, Konrad Dybcio wrote:
> 
> 
> On 7.03.2023 10:17, Krzysztof Kozlowski wrote:
>> On 13/02/2023 13:10, Konrad Dybcio wrote:
>>> Add a compatible for the DSI on SM6115.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>>> index 2494817c1bd6..f195530ae964 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>>> @@ -25,6 +25,7 @@ properties:
>>>                - qcom,sc7280-dsi-ctrl
>>>                - qcom,sdm660-dsi-ctrl
>>>                - qcom,sdm845-dsi-ctrl
>>> +              - qcom,sm6115-dsi-ctrl
>>
>> This looks incomplete. You also need to add it to MDSS binding.
> https://lore.kernel.org/linux-arm-msm/145066db-5723-6baa-237d-7c2b8fd476d9@linaro.org/
> 
> Does this.. but I guess I'll resend this as one series, as it only
> makes sense.

It should be one commit. Adding sm6115 here is incomplete if other
binding (using this one) does not allow it.

Best regards,
Krzysztof

