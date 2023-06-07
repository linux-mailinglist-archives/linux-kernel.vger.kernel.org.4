Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75BE726389
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbjFGO6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjFGO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:58:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF21702
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:58:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-973f78329e3so1214730466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686149913; x=1688741913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJjTaZ/9cZA9GnMjrlFxN0BcpW9ecqXexzGH0t5m7pg=;
        b=QZtp60wD+75gS8sutSysW1Gt5v97dtcxNep2QtjO8YjTnwodJlOnvSVKHI9xa8kYtr
         DLvw+vYLWItGs39/ssYBe6cGf3k1K86bMckozzamLHDw8So1t81h1NuirKkpAACPOosL
         3+IHpGoghgtv+K5fQNtJMk7KRb4NZrlVVeqDpDQiCwF45+OQdMYsf18vErJE0e4+o1qq
         +99a7XbNwoEjshZltQVZbDB+bVs9ZuRjhEHU2xfzruJb/OMmzhUEsY87IASFlbxxnmPQ
         tw3V+IR8IPYE4cTPSTNj+nmOoeuyIlRwASCc5eLMnhlRt6OyFR80XImfkn/TJ8UHOLtw
         ebXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149913; x=1688741913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJjTaZ/9cZA9GnMjrlFxN0BcpW9ecqXexzGH0t5m7pg=;
        b=hNW/1vKXoMO39OowuFXWNx3VYgL4N4QCC23Vhzcu4GP6oeuQLLr6VlXEeqNskGP7xA
         TdTYctYVmvzv6+ehLhxLfc0EDr4XANKbrvpoocSkqV3JIPvgz/7bQ7lfI5kiyKDXZc0j
         KKfukxzYuShNrGQFPcBydkARXWq/BZ14CNnywI6iATs5fS0lpeyECMfasbmQlzQRF1Fx
         odGP+KqcDVI4jH+VhnXKEkUU2YEk7lQeAvvHVjdtevvL2jhdzIjGpTP1U7Yt0Ot0iEbx
         tIvukUeMensxh2w4gJVEilAPGLzdGRSXiLT9ZbHQlf1B0gufExAY3N+8hwgEg7RSrder
         v2AA==
X-Gm-Message-State: AC+VfDw6cKI/4x0WKaZfAK+e8LCm1L05OoX8m892s6uTFOm/nAoww61t
        MF9JJzs11EIa054NRFPUuw0l0w==
X-Google-Smtp-Source: ACHHUZ6wzBYezPQx+NTgUt4QVORBO0tD9ssE0IbCfRYurBIDs8W2LBeRt9iNG8JBmBTHHs8zUMPPHA==
X-Received: by 2002:a17:907:1c17:b0:971:2ead:e161 with SMTP id nc23-20020a1709071c1700b009712eade161mr6874357ejc.6.1686149912938;
        Wed, 07 Jun 2023 07:58:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bv13-20020a170906b1cd00b00978743b54bdsm1822713ejb.78.2023.06.07.07.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:58:32 -0700 (PDT)
Message-ID: <9105207b-0dfb-346f-422f-984cf3454f90@linaro.org>
Date:   Wed, 7 Jun 2023 16:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] dt-bindings: nand: meson: Fix 'nand-rb' property
Content-Language: en-US
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
 <20230607095802.3adcd4f9@xps-13>
 <166bdc27-f77c-9076-f866-180cfa5bff76@sberdevices.ru>
 <08da4e86-433a-7d2e-25ff-ffa24221abdf@linaro.org>
 <835a3587-1e0f-64d7-1d1a-b639ae8b7307@sberdevices.ru>
 <2ca6e619-1d57-8fff-6176-9ee890e0d167@linaro.org>
 <5ca9eb2b-4bc8-5883-a029-3eeca905fe6e@sberdevices.ru>
 <20230607113605.50a992bb@xps-13>
 <6c1973d1-38c0-6048-90ad-da2f60df8238@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6c1973d1-38c0-6048-90ad-da2f60df8238@sberdevices.ru>
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

On 07/06/2023 16:52, Arseniy Krasnov wrote:
> 
> 
> On 07.06.2023 12:36, Miquel Raynal wrote:
>> Hi Arseniy,
>>
>> avkrasnov@sberdevices.ru wrote on Wed, 7 Jun 2023 12:04:29 +0300:
>>
>>> On 07.06.2023 12:08, Krzysztof Kozlowski wrote:
>>>> On 07/06/2023 10:57, Arseniy Krasnov wrote:  
>>>>>
>>>>>
>>>>> On 07.06.2023 11:53, Krzysztof Kozlowski wrote:  
>>>>>> On 07/06/2023 10:40, Arseniy Krasnov wrote:  
>>>>>>> Hello Miquel, 
>>>>>>>
>>>>>>> On 07.06.2023 10:58, Miquel Raynal wrote:
>>>>>>>  
>>>>>>>> Hi Arseniy,
>>>>>>>>
>>>>>>>> AVKrasnov@sberdevices.ru wrote on Tue, 6 Jun 2023 22:35:07 +0300:
>>>>>>>>  
>>>>>>>>> Add description of 'nand-rb' property. Use "Fixes" because this property
>>>>>>>>> must be supported since the beginning. For this controller 'nand-rb' is
>>>>>>>>> stored in the controller node (not in chip), because it has only single
>>>>>>>>> r/b wire for all chips.  
>>>>>>>>
>>>>>>>> Sorry if I mislead you in the first place, but you could definitely
>>>>>>>> have two chips and only one with RB wired. It needs to be defined in
>>>>>>>> the chips.  
>>>>>>>
>>>>>>> Ok, so to clarify: is it ok, that in bindings this property will be placed in the
>>>>>>> chip, but in driver, i'm trying to read it from the controller node (thus  in
>>>>>>> dts file it will be also in controller node)?  
>>
>> The bindings and your driver internal representation are two different
>> things. Anyway, as mentioned above, wiring the RB line to one die and
>> not the other would be valid hardware design and would require the rb
>> property to be in the chip node. Please perform a per-chip property read
>> in the driver as well.
> 
> Done, I resend both patches (bindings + driver update) as a single patchset. Your review comments
> for driver code were also fixed.

No, please send new version, not the same. New version means with fixed
comments and with patch changelog.

Best regards,
Krzysztof

