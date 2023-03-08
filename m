Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FFD6B0572
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCHLIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCHLIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:08:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0A59927A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:07:52 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ec29so33309383edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 03:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678273671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XOXj33xYRyvRjw0tjSabpMsq8BekV0jE87PdwF1hf5k=;
        b=R8OvhGfCpynLB7ACnBVVELznEJTehRf3eH6xSvQMhNSO7ynQXFj1HJBIWnHY02ngwt
         d7zcal82tjKt7B5VOkXiJdfp7a/AexmxSwsSfeU4zeYiBA7mE0R7FAIBLOoSvQVPIGuU
         0BYLAiL3beIxf1Rq8vmy/1/8pItinZi2PYjRM1fF1bi9xJ62zOztFv/IhmbP5cPh1PmF
         z1VIndGxokZGS6IGxu8sz4L8kz9ouy2fVEQfyysb0zi802LeCIWA2Ck7EpEshvoCPlmG
         e3YcyeOyfTULKvos6GONhx5NCAxcT77WFp/fzm0VN+xtvTtc5kEoF+dj6IcY+5YteS3K
         Z3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678273671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOXj33xYRyvRjw0tjSabpMsq8BekV0jE87PdwF1hf5k=;
        b=mHgeKejQBwdRkXlwSfQ9H/GPs38B9d50Cih6SbCz6D4t62f5QkUBN6OLnluNKvp6qe
         yATRkRL5i87keFu7iSlVLxjpEPzJAW0olu9h55SAOylSWGO3jvi78wjqkOv92ezYxhTq
         fWHKi2eq71SGMm/goVESuaotA7umbaA3UjUBdHsLJBbdfbeY9QX14kCoL5LXb7wHCnzG
         UO9f/X7ric0P6nFCzSn4jwNqe8/6co3NNc6joOIPQ5Io2Zq1Dboyu8ldG6Kg8et1khAP
         zT5zzvGOKO7UX9dLOISzsgtaHtwyTbzpQJkL1UVHT5Nrh3EXD7v/v4dY3VlsuscV7ka5
         HMaw==
X-Gm-Message-State: AO0yUKVnYVRE1Ir8XNy4QbrAHltZYFSLFrNqhppIgK2q+136P4Sse3jl
        xkxXVl9+SyKmLq8rEHW1B4XopA==
X-Google-Smtp-Source: AK7set/T6NXfefI3apYBnuhuHeGcGhWicxbthX9S5jDU/7gI1DQeiNmrE+SAWinienxvlJrfawpOtw==
X-Received: by 2002:a17:906:3c56:b0:8ae:f19f:609e with SMTP id i22-20020a1709063c5600b008aef19f609emr18979469ejg.66.1678273671087;
        Wed, 08 Mar 2023 03:07:51 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090653d400b008e97fdd6c7csm7283796ejo.129.2023.03.08.03.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:07:50 -0800 (PST)
Message-ID: <efddfbf3-8003-c5e5-5054-3d30287c4b23@linaro.org>
Date:   Wed, 8 Mar 2023 12:07:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 11/11] media: starfive: enable building
Content-Language: en-US
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230302091921.43309-1-jack.zhu@starfivetech.com>
 <20230302091921.43309-12-jack.zhu@starfivetech.com>
 <bd6c9135-e12c-a6ac-db46-416403850751@linaro.org>
 <15b29a5b-29a1-8440-2b46-0c201c20defd@starfivetech.com>
 <edf4febc-1629-45c6-ea48-ece8df12a4a5@linaro.org>
 <05465184-5976-6cee-9925-e3712a1ea650@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <05465184-5976-6cee-9925-e3712a1ea650@starfivetech.com>
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

On 08/03/2023 12:03, Jack Zhu wrote:
> 
> 
> On 2023/3/8 18:33, Krzysztof Kozlowski wrote:
>> On 07/03/2023 10:46, Jack Zhu wrote:
>>>
>>>
>>> On 2023/3/3 16:43, Krzysztof Kozlowski wrote:
>>>> On 02/03/2023 10:19, jack.zhu wrote:
>>>>> Add Kconfig and Makefie, update platform/Kconfig and platform/Makefile
>>>>> to enable building of the Starfive Camera subsystem driver.
>>>>>
>>>>> Signed-off-by: jack.zhu <jack.zhu@starfivetech.com>
>>>>> ---
>>>>>  drivers/media/platform/Kconfig           |  1 +
>>>>>  drivers/media/platform/Makefile          |  1 +
>>>>>  drivers/media/platform/starfive/Kconfig  | 18 ++++++++++++++++++
>>>>>  drivers/media/platform/starfive/Makefile | 14 ++++++++++++++
>>>>
>>>> This is not a separate commit. If it were, it would mean you just added
>>>> dead code in previous commits, so why adding dead code in first place?
>>>>
>>>
>>> The previous patches are made according to the module function.I think
>>> it is helpful to explain the composition of the code file. 
>>>
>>> stf_camss[patch 9] as a platform device manages all resources including
>>> ISP and VIN. ISP/VIN [patch 7/8]as a sub-device needs to access other
>>> resources managed by stf_camss.There is mutual reference between them.
>>> Therefore, this patch is used for the overall compilation of the starfive
>>> directory.
>>
>> So previous code is dead? Again, what is the reason for adding dead
>> code? Mutual reference is not the answer.
>>
> 
> Maybe I need to merge the previous patches[6-11] into one patch to submit?

I gave you the recommendation in my first reply. What's wrong with it?

Best regards,
Krzysztof

