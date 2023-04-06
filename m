Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3791F6DA042
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbjDFSrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbjDFSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:46:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBCAD12
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:46:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n21so3671846ejz.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680806790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MgXJOn+WAZ47Cl6o8tPQjAABd5Itwae5J4f0B3wQsNo=;
        b=mpk5TuobYbvWtl+C6R4wLIUF/Hc35fhvJv5TThEYojiqCz6ARENF8am1xXOuZlBYxm
         V+6OxdoIfOdTAgqPVOUimNaPdocS5O4zRTVeblGEk1pwGG+A5Ll9Z0+GMr4FIQnkrZRu
         0/PZYhI5ncokLTLlZMZsjgAR83yvo/Cl41eXvIZL8FiFyqSaPwlnZtBVEyP7y4TGSXyD
         CwQUxZWYrAz/nqcGyNb7arm7sQnHGYylg8XxmOoEQZj5FNrfeGlq/y4pNvgz5po9kVPw
         lXbiLUi4G3AGzHqsJvBViVK8Q+XZhkHsJKFXr/y9GMlu3eqZ0nyX4cAby5wnHmGAn5CC
         zTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgXJOn+WAZ47Cl6o8tPQjAABd5Itwae5J4f0B3wQsNo=;
        b=RbKHq0aDPKBJqkgnYJeopY+yxNFAN/gSHRYneovPZZ/M86FUWWerbp22lVaQtPzFJk
         7SjSngl5b0ZBHmilYnXl/SJNU1pOQJAUC+EkcGDThBDbfz9OiNibmUoqMLL2DeWPP60r
         sK5kI8LwC5NKRiygk9wvrMKFXBQvF/XXE+5ViesYygNdXvrq35fXP+QHv2ZILJp3d9wu
         ofkxexdtQUBzZ1s9TJnVn3oukyMPrEkhxDJBqeBKpUO/jebgJlFXVT3aV2cAAonztQyX
         gC9261Xuf9OQiqJg2a1xM1Bbb6EfIQmlxfQn6FqtL3AStJT48tvxHYP65i2ZSr9IIA1A
         bD+Q==
X-Gm-Message-State: AAQBX9d/alt2oSPheotBXH8tHHi1sDnyGunv80KkHIk0DAaWTP0iDgG8
        MUaFjk3fLye1ES491ib9q1tD8w==
X-Google-Smtp-Source: AKy350ahKqk/eVseprVd25UAxkAp8OgeoVUzsVGX0BSATs/dsK1+2sIuMzxutuwaNHjcCfphm9gnJw==
X-Received: by 2002:a17:906:c005:b0:947:55ce:1217 with SMTP id e5-20020a170906c00500b0094755ce1217mr6864670ejz.73.1680806789884;
        Thu, 06 Apr 2023 11:46:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709061b4e00b00930a4e5b46bsm1108835ejg.211.2023.04.06.11.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:46:29 -0700 (PDT)
Message-ID: <37d04794-d790-fd7c-9f34-901955083874@linaro.org>
Date:   Thu, 6 Apr 2023 20:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 1/2] dt-bindings: omap: Convert omap.txt to yaml
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tony@atomide.com, afd@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230405161908.4312-1-andreas@kemnade.info>
 <20230405161908.4312-2-andreas@kemnade.info>
 <eb4cf82d-f523-d5af-be18-25c37678a95a@linaro.org>
 <7f43953c-d326-f517-d896-cbb060d8092a@linaro.org>
 <20230406203548.152ae065@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406203548.152ae065@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 20:35, Andreas Kemnade wrote:
> On Thu, 6 Apr 2023 10:36:36 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 06/04/2023 10:32, Krzysztof Kozlowski wrote:
>>> On 05/04/2023 18:19, Andreas Kemnade wrote:  
>>>> From: Andrew Davis <afd@ti.com>
>>>>
>>>> Convert omap.txt to yaml.
>>>>  
>>>
>>>   
>>>> +      - description: TI AM43 SoC based platforms
>>>> +        items:
>>>> +          - enum:
>>>> +              - compulab,am437x-cm-t43
>>>> +              - ti,am437x-gp-evm
>>>> +              - ti,am437x-idk-evm
>>>> +              - ti,am437x-sk-evm
>>>> +          - pattern: '^ti,am4372[26789]$'
>>>> +          - const: ti,am43
>>>> +
>>>> +      - description: TI AM57 SoC based platforms
>>>> +        items:
>>>> +          - enum:
>>>> +              - beagle,am5729-beagleboneai
>>>> +              - compulab,cl-som-am57x
>>>> +              - ti,am5718-idk
>>>> +              - ti,am5728-idk
>>>> +              - ti,am5748-idk
>>>> +          - pattern: '^ti,am57[0124][689]$'  
>>>
>>> I don't think my comments were resolved. I asked if it is possible to
>>> make a board called "ti,am5718-idk" with "ti,am5749" or with "ti,am5708"?  
>>
>> Hm, I cannot find my concern, so maybe it never left my outbox. Anyway,
>> it looks like you allow here many incorrect patterns and combinations.
>>
> You had concerns about the "dra" stuff for the same valid reasons.

Yes, but also about this. So again:
is "ti,am5718-idk" with "ti,am5749" correct?

> 
>>>
>>> What's more, you dropped several variations and compatibles against
>>> original binding (all the "dra") and it is not explained in commit msg
>>> at all.  
>>
>> All changes against original bindings should be explained.
>>
> ... which I then just decided not to convert but keep as is in the text file
> because there were no comments hints about it more than a month since the first
> version was sent so thought that it has to be resolved later.

But you partially remove them - see AM5728 IDK.

Best regards,
Krzysztof

