Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5200F6B39CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjCJJNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCJJMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:12:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C7D113F60
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:08:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so17671084eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678439284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x13l6iJykM0Iq5sMF/00j6Gyhm3oFJMW1U4hx4uJJAE=;
        b=fBcJZWOS9egaVLPPMnATuMAo3NpeqRO4MyNjgxQDUMoZgpcoPOryBo3h7HryZ+10I/
         tcAAtAU3LDUhA2bDQRHSDBYZdmgYUm454JUyXbWHFefrXimFb9V2p/Om+3wo1lj7GXEW
         BfTZCfYMZ1TX/q9tEvreOThibJb3x0oI5JUgI/8Ja6OwZ8pUAbahthwatIuutXyo9hFE
         Y7DUcCtHAobY8i7acmGRfaAWUjvqG/mbMjaEIJ3DbER/c+xWx9Q6lL5+AaKHyekhA38e
         swCCvZYbHFc24BU5I4CZRkLe+nb0SIqXWBnyL/CtCru2a/0k6a79uW6UuzHRSQyhsOtb
         FqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678439284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x13l6iJykM0Iq5sMF/00j6Gyhm3oFJMW1U4hx4uJJAE=;
        b=rPilqlvH9+lN8Ld1RebKa840sF079V4ZaT7aMmCYfwHlB3YDjrBTZ6yIS9HAWxci2Y
         qFA6DmWYxOfwFBqgIk2Ug9cwDDap6/Sr/31LoiT8HEwwfdI6WZuU4MCA8Pnqu9AFd1zA
         35FYVn5gfeNFDbx7AozMdStL2MAjFlskedwu8jWWpLNsXEY0vyZL38TK1Mcfh1dSw9CB
         WXWG6VstM4vOBLYKBFqnFh1HykmYBAvxLmqIkzYciIFVdCMmy1WdK0ILI34KNU9gcBA7
         3NRNlxySOS3uosqVqw/Ah+Kwd0+wvfXsHTp3zYYpJwXvQevwtpgFtABlSatZxo18sHoU
         fNpg==
X-Gm-Message-State: AO0yUKWW602U5aVd94AspZxdvmQvkZP/eTXGcNEU8QYzUY/kZrWeRViK
        auhAdAvt6KwfragEbxDIaSmHzQ==
X-Google-Smtp-Source: AK7set9My0LsxpYnbZ819noBKM/f6rZVDXH8k8ypKSMrHnIlsoTuj6+1Dk6MzeDY4MN3gOEzeWC22Q==
X-Received: by 2002:a17:906:25d3:b0:8d4:1e81:f87e with SMTP id n19-20020a17090625d300b008d41e81f87emr24686993ejb.57.1678439284216;
        Fri, 10 Mar 2023 01:08:04 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b008c22a35e684sm695919ejb.196.2023.03.10.01.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:08:03 -0800 (PST)
Message-ID: <49106943-450a-11c0-99ce-159d40471bf2@linaro.org>
Date:   Fri, 10 Mar 2023 10:08:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Patch v6] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com
References: <CGME20230301035153epcas5p40f576188a9a69835c1050135219a3720@epcas5p4.samsung.com>
 <20230301035144.8645-1-aakarsh.jain@samsung.com>
 <8b5bea40-6f7b-1d00-ac23-83a28c7dacbc@linaro.org>
 <046b01d94d1a$418146a0$c483d3e0$@samsung.com>
 <9b93849d-d4a4-67ba-e8a0-ee6c7209bd65@linaro.org>
 <000701d95257$e97ebd50$bc7c37f0$@samsung.com>
 <81e78cf6-b8b3-0cab-d190-aa22abbc5c2d@linaro.org>
 <001901d95263$eac4b460$c04e1d20$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <001901d95263$eac4b460$c04e1d20$@samsung.com>
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

On 09/03/2023 09:48, Aakarsh Jain wrote:
>>> won't fit here.
>>> Since IOMMUs maxItems is 2 here for Exynos4. Giving maxItems:2 alone
>> will also break the bindings. Thanks why suggested
>>>          iommus:
>>>            minItems: 1
>>>            maxItems: 2
>>
>> Are you sure you are putting this in correct place? This is if:then for
>> Exynos3250, isn't it?
>>
> Its not only for Exynos3250, its along with Exynos4 since their clock properties are same
> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - samsung,mfc-v5        #Exynos4
>               - samsung,exynos3250-mfc
>     then:
>       properties:
>         clocks:
>           maxItems: 2
>         clock-names:
>           items:
>             - const: mfc
>             - const: sclk_mfc
>         iommus:
>           minItems: 1
>           maxItems: 2
> 
> or do I keep different if:then condition for both Exynos3250 and Exynos4 for IOMMUs property ?

Yes, they should be split into two if-then.


Best regards,
Krzysztof

