Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C2A6E3A83
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDPR3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDPR3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:29:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828BE128
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:29:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dx24so14349610ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681666174; x=1684258174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALGubGI9vcPFVNhBw3xYsBRMIAknnF9aicGsi1XUPLk=;
        b=sMuKVfCxr89Rs5nPX29H3CNTFQvBvR/XM4KqkDBiCu3zHbHhec+m6gNXeH8Zro6/hP
         AihhHjRPgDkJMjkI9u+4MLflks+a3mpVBvuGtxpTgNNGVTSObVXzkGGaz7a2JUv7qXlL
         ck4H9Pehfnd6zoAs7HLhocAskPw2zuiFDODfK63C8a+ttTQd2kG9jUvcK8TuiQfejL12
         Iyi6hcI7sHL7i7GHwwqVBigCeaPwPbl2UAZscjInSEvlGpRjCKkNjXCYYVhBTHAUrtwY
         up30+jmftwHc5xx/Vx/sX4QcSUcACPcmCemhZyfGVGReFJiD62AG5oi5XkFEDBOmFG0F
         Mr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681666174; x=1684258174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALGubGI9vcPFVNhBw3xYsBRMIAknnF9aicGsi1XUPLk=;
        b=lWxGO7c1pV05g1cT9LW2fyPagKtRxZIds9t9WysK2OyiJ3vQv8YWFB46OBFebGPNFP
         rCpzr269z9+Na/gVWO42YHI/E9ROv3ZTZgdHns0S8VFNnpaKkXpYi0pihJC15+qTIDgZ
         xp/VDnxI4aRoiQ6+BQi270ZvaYldvK4yk1Th7rk0jlJeKuztv7WnWnSCOU7OH4JAQ5PP
         vcGLK4PuVqTvoguljGKpLrr16+NPybS9nBTtQe3iKCOdN615TUwRnXjhVjATUkaaNuUm
         ra8cIrkx1/2uKG+SAVyvSgJgC1a3TAtAa2RNDtIsG4NBMXjiKuovsKuRTBUCu2zdlP5d
         L6rg==
X-Gm-Message-State: AAQBX9cxoDJDRc6Ydvbc/xl0MXPQe96sH2Cgd25XZqA4Z7oLIP+3yYHl
        /4XUFFjjltdMqJpEJSw1r6F5DQ==
X-Google-Smtp-Source: AKy350YFnbIUE8o83ZkVTdY4/9rW/e7dq7GqM6STdl/F8jdbMAVS3RxyoIDP9UaCahROrbK+1R6w/Q==
X-Received: by 2002:a17:907:2089:b0:947:a6d7:e2b4 with SMTP id pv9-20020a170907208900b00947a6d7e2b4mr4755130ejb.8.1681666173907;
        Sun, 16 Apr 2023 10:29:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709067cd400b0094a86ccb634sm5278610ejp.210.2023.04.16.10.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 10:29:33 -0700 (PDT)
Message-ID: <31c582a7-682a-330e-51d4-53b4a0c5f3a2@linaro.org>
Date:   Sun, 16 Apr 2023 19:29:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Content-Language: en-US
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230412084540.295411-1-changhuang.liang@starfivetech.com>
 <20230412084540.295411-2-changhuang.liang@starfivetech.com>
 <8dd0dc63-e0df-8764-f756-da032d9d671c@linaro.org>
 <eb47b7c7-bdbb-92d9-ba39-604ce487f297@starfivetech.com>
 <f6a4fb28-d635-4d99-44bb-d929cb41eef2@linaro.org>
 <b34a8d59-34e4-8358-9d2b-367f4707ca7c@starfivetech.com>
 <f0d82428-aaa5-3dd4-bc29-f1057fe749bc@linaro.org>
 <0c94aadf-fac3-d05c-1c54-ae8337526849@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0c94aadf-fac3-d05c-1c54-ae8337526849@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 11:02, Changhuang Liang wrote:
> 
> 
> On 2023/4/13 16:41, Krzysztof Kozlowski wrote:
>> On 13/04/2023 04:34, Changhuang Liang wrote:
>>>>>>> +  lane_maps:
>>>>>>
>>>>>> Why did this appear? Underscores are not allowed. It looks like you
>>>>>> re-implement some standard property.
>>>>>>
>>>>>
>>>>> Will change to lane-maps.
>>>>> Yes, according to Vinod advice, lane mapping table use device tree
>>>>> to parse makes sense.
>>>>
>>>> Hm, I have a feeling that I saw such property, so you should dig into
>>>> existing and in-flight bindings.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> A standard property? Like "clocks" or "resets"?
>>
>> Like lane-polarities now submitted to one MIPI.
>>
>> Anyway it does not look like a property of a board. You said it is fixed
>> per SoC, so it should be implied from the compatible. Otherwise please
>> explain in description and provide some rationale.
>>
>> Best regards,
>> Krzysztof
>>
> 
> This property is the only one used for this IP, I have compared this IP with
> other DPHY rx module, DPHY modules form the other manufacturers not have this
> configure.
> And we also have a SoC called JH7100. It DPHY rx module is the same as JH7110.
> But we don't do the upstream work on it. If it use this lane-maps will be 
> configure as "lane_maps = /bits/ 8 <0 1 2 3 4 5>;".

And JH7100 is different SoC, so you have different compatible. Again -
is this board specific? If not, looks like SoC specific, thus imply it
from compatible.


Best regards,
Krzysztof

