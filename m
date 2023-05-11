Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7C76FEE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjEKJDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbjEKJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:03:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4710CAF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:03:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so14705783a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683795806; x=1686387806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gURyFCLGL6qPfte/M38lDLhFR1He2KCfzZXXVoCQbA=;
        b=iquqBAsAp6khHMo3FwoOGE6v0VsiHMPYSjGjvTKxzosEfZXQ3il8oDqFbO4XkIeKHv
         FkT2xFPNu5zcoN/xAab+H7GMj/reMx4tM3hgiqvob+pYCfsBi/YWCiT2HOsGcmXjylB8
         jlyfx4eWElKt7wlyOrfyy6wT7BGgUHGjw/Yh2FKxJsH1cLJL90npjpoTGXKFALSQvmiK
         viU5l7F8nmUxXwdBCepdJapeGj+RXbAQT9g5poWne8216Bdve7JknHuyGVL7aUPJ3zxh
         D1JSoze0mGwo3USInbixsY1y9Z7JdB/nsbZfTKlxYZ8RSOJBgs1bl6H4wxAKHlgcuAW+
         TzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683795806; x=1686387806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gURyFCLGL6qPfte/M38lDLhFR1He2KCfzZXXVoCQbA=;
        b=LZWaUncjJiA4pQamB/LxrGJDL/G8oN+tOXKhLv+TD+L5hY5V2GEcMkqZHHT5GTrbfk
         dX3YSwJ426wmP2rTyhVXwjnw2w4w61mNB6ANKBpsO/sth2v430rBksIc6aCOZDfAOusK
         77r5Q5w3y9TMgPqQi2vbYPRvpr78j/foVNvKnW0BJQMf1AsXlTTdtFgXhN+iIdg1aWLm
         hLIpwhD745OWaWFwer8rlrXxWsC5hnmqey3EotXjxrX+yIWM0buaPmQiCeAqiKtGXxXM
         XT3/KyIIkg2kqOAlDZowwzOdmMO/ztBKO0sR4QdXShdMwO/+qe8hCdkmgqik6gIKsoDs
         vN4w==
X-Gm-Message-State: AC+VfDwZiGFWYUfQk1r0MTeoO39SBTkma+hqF5aA40pbrRZsV6tS1rXF
        ZEQ0qUrp04f/OnVW/woBPfQ0RLfT+aOETdZ4J65Q9g==
X-Google-Smtp-Source: ACHHUZ5M9+Dx5f6PabYjCF+Jaeu08L2NV+JAQZZXXwsGJViNaDBFle8VnOu909l4RFYzaIos/HWAYA==
X-Received: by 2002:a17:907:d01:b0:965:ffda:b9d2 with SMTP id gn1-20020a1709070d0100b00965ffdab9d2mr21532032ejc.11.1683795805683;
        Thu, 11 May 2023 02:03:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id qh20-20020a170906ecb400b009655eb8be26sm3737933ejb.73.2023.05.11.02.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:03:25 -0700 (PDT)
Message-ID: <5d01e717-39f1-798b-dda8-022b8430dc7d@linaro.org>
Date:   Thu, 11 May 2023 11:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/6] dt-bindings: memory-region property for
 tegra186-bpmp
Content-Language: en-US
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefank@nvidia.com
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
 <20230510142248.183629-6-pdeschrijver@nvidia.com>
 <cdba4bb0-551b-a3b2-9329-139d6cda71be@linaro.org>
 <ZFyhqXhzOUKYUafA@44189d9-lcedt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZFyhqXhzOUKYUafA@44189d9-lcedt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 10:04, Peter De Schrijver wrote:
> On Wed, May 10, 2023 at 05:01:55PM +0200, Krzysztof Kozlowski wrote:
>> On 10/05/2023 16:22, Peter De Schrijver wrote:
>>> Add memory-region property to the tegra186-bpmp binding to support
>>> DRAM MRQ GSCs.
>>>
>>> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
>>> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
>>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>> ---
>>
>> Also no changelog. Since I do not see improvements after Thierry
>> comments I assume you send the same.
>>
> 
> The changelog is in the cover letter. I will send it to you next
> iteration.

I got only few patches, rest is missing including changelog. Thus it is
the same as it did not exist.


Best regards,
Krzysztof

