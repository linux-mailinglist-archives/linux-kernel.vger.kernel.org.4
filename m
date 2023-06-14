Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2172D730571
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjFNQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbjFNQwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:52:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1448C1FF7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:52:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9745baf7c13so127562266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686761534; x=1689353534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4RKuZCqzW2Dlrgh/BnCWxatIsnaqixg2Yy82HrsyRc=;
        b=ea5niOQKFslWBeiu8l8bwW2emOXzF+TZN9SXr6i6QQGhp+/Rdf7xCwSxDj4eCkhE/x
         ixSyBRefLvGETnEw79vEBBJvw6TMiaS7seZe6l+jhYIK5aike+iFA3QzmbwqVdtGyRa3
         Kc5CKve1Wfl9CZVQiDSwPLlShhaHSdjgc6QikaV4cOde4oTY2iB6UEe8nmdXB+ftFd6I
         N+/h2rvuVm56oG/884rJdLharBgh6ijnN5RIeI7fyLvljOXocqTYgzB4Q+Jj3TkJiG/O
         6fWUTFcmCCcRTJk0I0DJ/tTqqrFQN2OcylO40akZYApsIi+WCslvmTg9vyCrR1+gBH/r
         BQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761534; x=1689353534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4RKuZCqzW2Dlrgh/BnCWxatIsnaqixg2Yy82HrsyRc=;
        b=gvaGJawUVp0s2lh7acVMW383lvRY+KXnI0o9ZfpzDKWYHpUwpQJX6C61Fgpn0R9/s3
         lqyARN+bG/dn9FCn486FVO2GRBeji//4TsWuFHW07T5I3GpJcY9y6qSSocajjpCr9wVS
         i1tUIyQFpqZ0+McJ30fcpq+dZhKn5V6yYCHlJomghoKq8LL/+vh1Mba6/9FidAHwGv3y
         jOnA3yr5ZvHkZBINmhTqUGM+Hq/AIFpjDWCaPqaSc01dkWjAtZQArY77ZDNpiX+fM6fr
         yyM8ySWKDcjDyISE4dyWBfkVNy9NgXb98eW06yubHerIw3YT6n9EjjeEk4xmtRcLdubW
         zTZQ==
X-Gm-Message-State: AC+VfDz3P5Wj+zt8zEBV2oSPW/OyHMhdU7dALRdQoTVxw0fiaf4d+ZkQ
        Nt0exuGax8GugtxsNoex3NDUlQ==
X-Google-Smtp-Source: ACHHUZ7E7FKxahgtG+bxV0HhVkZEyxm7yrjKAS9lo7WpJwoXEvrbR8cTx0jmapBX4FNtiJqh6VEy0w==
X-Received: by 2002:a17:907:80c:b0:978:8e58:e1a9 with SMTP id wv12-20020a170907080c00b009788e58e1a9mr16265342ejb.15.1686761534577;
        Wed, 14 Jun 2023 09:52:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906358700b00969cbd5718asm8140798ejb.48.2023.06.14.09.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 09:52:14 -0700 (PDT)
Message-ID: <e12b251a-9e4d-6706-f6ba-7ca20c674587@linaro.org>
Date:   Wed, 14 Jun 2023 18:52:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 01/22] dt-bindings: interconnect: Add Qcom RPM ICC
 bindings
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
 <20230526-topic-smd_icc-v5-1-eeaa09d0082e@linaro.org>
 <c8573d08-d4e2-41a8-f0b1-e1d7a0c9ce17@linaro.org>
 <e7a083f6-e885-113b-bb6c-d20108777c5e@linaro.org>
 <47cfe777-45b9-6303-1374-bc96803d26d4@linaro.org>
 <c1c84eef-ee43-fcb9-de93-ba609b842d87@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c1c84eef-ee43-fcb9-de93-ba609b842d87@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 18:48, Konrad Dybcio wrote:
> On 14.06.2023 18:47, Krzysztof Kozlowski wrote:
>> On 14/06/2023 18:43, Konrad Dybcio wrote:
>>> On 14.06.2023 18:43, Krzysztof Kozlowski wrote:
>>>> On 14/06/2023 12:22, Konrad Dybcio wrote:
>>>>> The SMD RPM interconnect driver requires different icc tags to the
>>>>> RPMh driver. Add bindings to reflect that.
>>>>>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>>>  include/dt-bindings/interconnect/qcom,rpm-icc.h | 13 +++++++++++++
>>>>>  1 file changed, 13 insertions(+)
>>>>>
>>>>> diff --git a/include/dt-bindings/interconnect/qcom,rpm-icc.h b/include/dt-bindings/interconnect/qcom,rpm-icc.h
>>>>> new file mode 100644
>>>>> index 000000000000..2cd56f91e5c5
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/interconnect/qcom,rpm-icc.h
>>>>> @@ -0,0 +1,13 @@
>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>>> +/*
>>>>> + * Copyright (c) 2023, Linaro Limited
>>>>> + */
>>>>> +
>>>>> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
>>>>> +#define __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
>>>>> +
>>>>> +#define RPM_ACTIVE_TAG		(1 << 0)
>>>>> +#define RPM_SLEEP_TAG		(1 << 1)
>>>>> +#define RPM_ALWAYS_TAG		(RPM_ACTIVE_TAG | RPM_SLEEP_TAG)
>>>>
>>>> Where are these used? I don't see any DTS in your patchset. Did you send
>>>> it separately?
>>> In the driver for now, e.g. patch 19. DTS can only come after the
>>> driver is fixed or things will explode!
>>
>> You reference it in patch 19, but I still do not see the constants being
>> used.
> 
> Fragment of P19:
> 
>  	if (!tag)
> -		tag = QCOM_ICC_TAG_ALWAYS;
> +		tag = RPM_ALWAYS_TAG;

Now I see, thanks:)

Best regards,
Krzysztof

