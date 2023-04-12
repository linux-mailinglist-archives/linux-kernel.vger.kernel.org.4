Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D256DF3BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjDLLcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjDLLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:32:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4B88687
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:31:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gb34so28110569ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681298999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJyqTEHoLZS3AbdsFdXhAUrC5DrToCewd/skrvNJpNI=;
        b=aWUihRyiFOSRdhy+QAXifz6dmGMrUxWJOYkhA1L8xDFjix9a6ZCB7JdM+Nf9OshSYX
         DS3//Jd7TSowWzvIryVIHN725R+T+4KPeJJgtyvX/PysOZtAS5aGivGTW93yOX/VDY4j
         VKsNhM1UhyEx4aPy6dbFkyrLEO9K42kWD+qy5upC62c1Xa/fjkboeWaVLvzojMN92r94
         Sg9wJLnCLyiWQyR6C5a0Hht5O81P8NmfnoxmSKqFlLORhJyHRWsMROGTinqKtxIOoUk9
         hx0uRmfTuB8vGIOzZAurbvk9hDIo2M9L30ofh6gB5GjeFcJi2u4nzotuwtF36Kt8LaEr
         gBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681298999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJyqTEHoLZS3AbdsFdXhAUrC5DrToCewd/skrvNJpNI=;
        b=3b6DnA4mxvlYVrL9Q4NSiKVWgczR3YdIO0szXFbiNczDKn2BRpntHNC5x0YBaana0i
         xGhjR90LngqP33jHcVIIeXlVinEeYWI47OZSA92Qv5lSL8JLpguuCgD8pwLxcEmiUjGM
         eY9QNrPibpNuClTg5lwXcKa260nRpFaXKKHuuaQgQJo56D8XVVS9nqdT+YGsbu/px868
         lF8Ud0H6U14z7ZdKt1okIuBQXlcM7WitJLNWfy5cQ4O94IQrjjp72eIZgiEmlB1yLdFa
         EJQOpKBxJfu2BxYfld8zPr3gPpGAcU0tcyfuvDfF4lGpEQy7pUtGwUCE4Z+pdKd4SNxn
         GCRw==
X-Gm-Message-State: AAQBX9fLLfNV1IB+E+5A5sH6ooaXwguKLL8/4c/CriQIT5/AuwjXJRn8
        YcowMw11jlqSqj7Rycx0WIWbUA==
X-Google-Smtp-Source: AKy350br4Y9CUS+K7knoYE8kFb8eku7TCZzpnUfEtRlKwcgWkPZSs/wUM8aZVxbWOeE72ExZALTlzA==
X-Received: by 2002:a17:906:a4b:b0:94e:4700:7a66 with SMTP id x11-20020a1709060a4b00b0094e47007a66mr2587909ejf.6.1681298999193;
        Wed, 12 Apr 2023 04:29:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id pv5-20020a170907208500b0094a8d25f7d1sm3079153ejb.82.2023.04.12.04.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:29:58 -0700 (PDT)
Message-ID: <d59439c1-bce1-b4a1-0e05-77afc4fc2ebb@linaro.org>
Date:   Wed, 12 Apr 2023 13:29:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 1/7] dt-bindings: power: Constrain properties for
 JH7110 PMU
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-2-changhuang.liang@starfivetech.com>
 <cb97cf01-2dfd-7f93-2048-e05a806d468f@linaro.org>
 <ee406b3d-0719-9332-cab5-62fe7537bcf1@starfivetech.com>
 <20230412-trifle-outplayed-8a1c795fab8b@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412-trifle-outplayed-8a1c795fab8b@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 11:42, Conor Dooley wrote:
> On Wed, Apr 12, 2023 at 04:51:16PM +0800, Changhuang Liang wrote:
>>
>>
>> On 2023/4/12 16:35, Krzysztof Kozlowski wrote:
>>> On 11/04/2023 08:47, Changhuang Liang wrote:
>>>> When use "starfive,jh7110-pmu-dphy" compatible, do not need the reg and
>>>> interrupts properties.
>> [...]
>>>>  
>>>>  description: |
>>>>    StarFive JH7110 SoC includes support for multiple power domains which can be
>>>> @@ -17,6 +18,7 @@ properties:
>>>>    compatible:
>>>>      enum:
>>>>        - starfive,jh7110-pmu
>>>> +      - starfive,jh7110-pmu-dphy
>>>
>>> You do here much more than commit msg says.
>>>
>>> Isn'y DPHY a phy? Why is it in power?
>>>
>>
>> OK, I will add more description. This is a power framework used to turn on/off 
>> DPHY. So it in power, not a phy.
> 
> Perhaps tie it less to its role w/ the phy, and more to do with its
> location, say "jh7110-aon-pmu"?
> There's already "aon"/"sys"/"stg" stuff used in clock-controller and
> syscon compatibles etc.
> 
> Krzysztof, what do you think of that? (if you remember the whole
> discussion we previously had about using those identifiers a few weeks
> ago).

Depends whether this is the same case or not. AFAIR, for AON/SYS/STG
these were blocks with few features, not only clock controller.

This sounds like just phy. Powering on/off phy is still a job of phy
controller... unless it is a power domain controller.
Best regards,
Krzysztof

