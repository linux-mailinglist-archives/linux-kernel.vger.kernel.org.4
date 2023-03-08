Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E476B048D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjCHKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCHKdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:33:39 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7BD93E13
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:33:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o12so63687997edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678271606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iR9ZZTK/rVOSQ9FgkPLyd+GiiOH43I/y6nWqPVeCUA=;
        b=sSH/DKMtEmhNsmHwdtFv+I70ArkkRbSVJiTNetRHfCqPsFOazlA2p/HjjQpMWsn4h4
         CXB8Eel8JoAiOQWdOAAKmiXIYSYjs/56J2Wo5cp7Dg+V72F1SrhyDQD1D7h/LnbiQ7bj
         G0x6rHLzcANSoee87ijmfDUTA8ckWE2knAJYnGUurxdyZ3nr+sV3bgmz4D2EaJtSlKHn
         idl9WofsdAKch5xAS0grSK7gnQi0SWnj1bOlX/ho76JcldGZkwr1zVfoyE8JDxd+yxEK
         Sg8nes52tbQDTm8eqgrzYSgPbxAQNCJ9Sux7vSHYHZ6aZ0eiAEkuZ/T0pUESoD12l1Ir
         6sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iR9ZZTK/rVOSQ9FgkPLyd+GiiOH43I/y6nWqPVeCUA=;
        b=TofJVuMgxdnD13gT/eUrk1Fxi3juvYcs4cAEYsgG1+X1lvCqF0coZcAHKWHPw+hsGA
         AWRRoftSGkoAAP1D56EQcov+usOjjwtFxi+PSsYsOq4WrtdK/y4CjEwDUs42WilZjPh/
         jPaZGP+KF1tT9nFhahwVfaqeNf3zJahXm8kcCXwwK+XrRfCyQCfPICiX8v0WNJ5s6JGG
         QKt2+AI6Ru44lAyPoOn8skcdfEGxPi15LTpejB4N8gpWy3kOuofElpuOk+VfYcC4z0It
         COCrPEPmWGyKBRyOiQCit8t4S5jYqd3VkZq+8ZGXgrWRqLuaBTrKX0oGwIxiqyWknqjm
         B3KQ==
X-Gm-Message-State: AO0yUKXc7gNUOo3pI69SOEsbuDKZF778O11KK77FJMEX3LLnx+EnHcSO
        fKRlkYbKNLw4CSFX9LkLazVjMA==
X-Google-Smtp-Source: AK7set8jPEuIAK54meSYftxPzkeOLlgD1AFufEs0U+ChwKL3GmHTKRlCjZqKCKGWnvv8IbOPRdMasg==
X-Received: by 2002:aa7:dccb:0:b0:4ae:eae1:946a with SMTP id w11-20020aa7dccb000000b004aeeae1946amr20494081edu.13.1678271606164;
        Wed, 08 Mar 2023 02:33:26 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id u25-20020a50a419000000b004bd6e3ed196sm7955780edb.86.2023.03.08.02.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:33:25 -0800 (PST)
Message-ID: <edf4febc-1629-45c6-ea48-ece8df12a4a5@linaro.org>
Date:   Wed, 8 Mar 2023 11:33:24 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <15b29a5b-29a1-8440-2b46-0c201c20defd@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 10:46, Jack Zhu wrote:
> 
> 
> On 2023/3/3 16:43, Krzysztof Kozlowski wrote:
>> On 02/03/2023 10:19, jack.zhu wrote:
>>> Add Kconfig and Makefie, update platform/Kconfig and platform/Makefile
>>> to enable building of the Starfive Camera subsystem driver.
>>>
>>> Signed-off-by: jack.zhu <jack.zhu@starfivetech.com>
>>> ---
>>>  drivers/media/platform/Kconfig           |  1 +
>>>  drivers/media/platform/Makefile          |  1 +
>>>  drivers/media/platform/starfive/Kconfig  | 18 ++++++++++++++++++
>>>  drivers/media/platform/starfive/Makefile | 14 ++++++++++++++
>>
>> This is not a separate commit. If it were, it would mean you just added
>> dead code in previous commits, so why adding dead code in first place?
>>
> 
> The previous patches are made according to the module function.I think
> it is helpful to explain the composition of the code file. 
> 
> stf_camss[patch 9] as a platform device manages all resources including
> ISP and VIN. ISP/VIN [patch 7/8]as a sub-device needs to access other
> resources managed by stf_camss.There is mutual reference between them.
> Therefore, this patch is used for the overall compilation of the starfive
> directory.

So previous code is dead? Again, what is the reason for adding dead
code? Mutual reference is not the answer.

Best regards,
Krzysztof

