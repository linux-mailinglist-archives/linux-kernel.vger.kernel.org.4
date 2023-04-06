Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528F06D8D48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjDFCJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDFCJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:09:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FA44EEB;
        Wed,  5 Apr 2023 19:09:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so41445536pjb.4;
        Wed, 05 Apr 2023 19:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680746990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDj+eIZP1IBl3cm+vrX+HXVFRJPLqgSdyxr8utmbIjE=;
        b=h6Q+NXLQyIEa36PKr/1WzGbsDNDfKEYm+dOiV/ApaoLGt+7ZNuBj8Irn7W504d10ly
         5emknI7Pfxxinw9eMxy/md4IIN6GkWotv04pDaUoIlP+J8MAL++Pj6u0koDVFUgu3stS
         FoOZEum5KCkP+Vr0ryyZqdE2GGWmd3nKrgSqdSn1ft2BCuKrT/tuS7rCOMBWQ6XWKhEj
         pT7LEyVOEz33oTEBOw4LQ9Rbdk545ytJ4nVaB3VftzqN2b/uaTt7UoQlsTUuxSTE7tv7
         fxf24juZkHTuL8zitk5WpMF61A9/oKTV3hRY5Dg7PeHAtlKSguoRQi53XrIhgDZT/trc
         0B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680746990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDj+eIZP1IBl3cm+vrX+HXVFRJPLqgSdyxr8utmbIjE=;
        b=JkS6CcZhJ/F3ob5BSXA8oGYiG9yhGJWMGeZa2v5M4NNKbAGRBjZ8ZBD17PfoImf6xJ
         BT3fuN6SYctGYaUnVeaav7OkilNOAmKBrP2Tzgfdt26oEZhhUgTSiH/MHWxL3DOSMNIA
         edMEKth5HC0tHdgKKo/f8CCis0dX1yBa5k1MpxL4OcEIee3C12etZpL3Br6QtdHJm7up
         t7joYDsmFiLOvoCRC93kITdKUD6UOX3A/GTCmSS5PRypA7PGKnTCdp1f2wCIGt+4b99e
         B5JTxmOfmWTH28zHLT/3I5R5i7QdPLMECyPz8LWxjc055g9TaNwutlmCfrEjcy0VKU2N
         aPaA==
X-Gm-Message-State: AAQBX9etnHqEHrFRgYl98EiFHJWbx6QYytTBdFv1Y9R20aUqzJltVB2j
        A+3Y5c7MIiyky1LaXE3Oap0=
X-Google-Smtp-Source: AKy350aamNfXjrdleRXHKCW87e/AlADBfBL5Ykcht2rfnwOkDw7oTlMOzLwKwFp3d1HKMch7gEwaxg==
X-Received: by 2002:a17:90b:1d81:b0:23f:7c82:2468 with SMTP id pf1-20020a17090b1d8100b0023f7c822468mr9357903pjb.31.1680746990495;
        Wed, 05 Apr 2023 19:09:50 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090a348d00b002310ed024adsm2032412pjb.12.2023.04.05.19.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 19:09:50 -0700 (PDT)
Message-ID: <dd5c3875-ad42-d41c-0c21-94472828484a@gmail.com>
Date:   Thu, 6 Apr 2023 10:09:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 06/12] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-7-ychuang570808@gmail.com>
 <CAL_JsqKrrWyOKGUAaT-8r-nKvtS5f_gHAhE5=XaXuGtuYC2gCw@mail.gmail.com>
 <a497eb9c-8279-d4e9-3b8d-537ffa1f7522@gmail.com>
 <cfa5904e-8ae4-6d39-ed4e-35d1b55e2b04@linaro.org>
 <f39edbfe-75bd-3b39-e325-8d24673a4501@gmail.com>
 <20230403203349.GA1692472-robh@kernel.org>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20230403203349.GA1692472-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/4 上午 04:33, Rob Herring wrote:
> On Fri, Mar 31, 2023 at 10:15:16AM +0800, Jacky Huang wrote:
>>
>> On 2023/3/30 下午 09:25, Krzysztof Kozlowski wrote:
>>> On 30/03/2023 12:41, Jacky Huang wrote:
>>>> Dear Rob,
>>>>
>>>>
>>>> On 2023/3/29 下午 09:07, Rob Herring wrote:
>>>>> On Mon, Mar 27, 2023 at 9:19 PM Jacky Huang <ychuang570808@gmail.com> wrote:
>>>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>>>
>>>>>> Rename the bindings/arm/npcm directory as nuvoton.
>>>>>> Add binding for ARMv8 based Nuvotn SoCs and platform boards.
>>>>>> Add initial bindings for ma35d1 series development boards.
>>>>>>
>>>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>>>> ---
>>>>>>     .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>>>>>>     .../nuvoton,npcm-gcr.yaml}                    |  2 +-
>>>>>>     .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>>>>>>     3 files changed, 32 insertions(+), 2 deletions(-)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>>>>>>     rename Documentation/devicetree/bindings/arm/{npcm/nuvoton,gcr.yaml => nuvoton/nuvoton,npcm-gcr.yaml} (93%)
>>>>> Since you are moving it, this one should be moved to bindings/soc/nuvoton/
>>>>>
>>>>>>     rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
>>>> OK, I will move "Documentation/devicetree/bindings/arm/npcm" to
>>>> "Documentation/devicetree/bindings/soc/nuvoton".
>>> To clarify - Rob asked *this one*. Not all.
> nuvoton,gcr.yaml is what should be moved to bindings/soc/... The rest
> are the correct locations.
>
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Dear Krzysztof,
>>
>> I am sorry that still cannot get it exactly.
>>
>> 1. Just only submit  the nuvoton,ma35d1.yaml to
>> Documentation/devicetree/bindings/soc/nuvoton/nuvoton,ma35d1.yaml
>>      and keep Documentation/devicetree/bindings/arm/npcm unchanged
>>
>> 2. Move the directory "Documentation/devicetree/bindings/arm/npcm" to
>> "Documentation/devicetree/bindings/soc/nuvoton"
>>     and submit  the nuvoton,ma35d1.yaml to
>> "Documentation/devicetree/bindings/soc/nuvoton"
>>
>> I should do 1 or 2?  Thank you very much.
> Neither.
>
> Arm board and soc root node bindings go in bindings/arm/...
>
> Miscellaneous system registers that don't fit into any other bindings/*
> subsystem directory go in bindings/soc/
>
> Rob

Dear Rob,

Thank you very much. I got it now.


Best regards,
Jacky Huang



