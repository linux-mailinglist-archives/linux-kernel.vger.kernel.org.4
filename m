Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED554621BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiKHSeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiKHSeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:34:11 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EFA2B615;
        Tue,  8 Nov 2022 10:34:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so12301834wmb.2;
        Tue, 08 Nov 2022 10:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3hp60uFt/XqpVFEQ8lHI7m/IKYo89nJRwN7r0UdODk=;
        b=FWfcRwAi66FGV4e2iOt3H5FG3JyY+JjnjgZF3gp1H2j6IENJmOaR4IR1a2LnfNOOWg
         jXAcNhjSFRQ1l2/nqCBJ29Mc2GYr42SFPdNZteh/A0ZdugEUTkrRffJDnXdXyF7rxwEn
         seCbGlr0lijKPcyGQUieC9RPSUzfXOKaeVpf1ypcWLh6kN+TX/GtP66BaFp1JpY7iH4Q
         tAgugbvaQ2Ww1wqAVkdJ8PoL58j9goTV4PI2SGQQf/LEHpkA1joORsX8yy8SHJ0jwbt4
         qxN8Tn8krmcKMftXKG+if3+XwqnRwxM171sEi1Eh+JEFfgU2h2ImNO6q3aTRKrvbTJiu
         wL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3hp60uFt/XqpVFEQ8lHI7m/IKYo89nJRwN7r0UdODk=;
        b=2ThyI1NNCr70vqSWPyCCrFBvBYwTTjyAL7Yk+5Pr1Sb8Z+e8zbrq/3JF5He2rWk00k
         gXePlSAuV5iaBcT02O0Bs2E5+j23wEqscUMnKRiW3n63KjJc7H58hu4+/BcmDHa91KCd
         ODF/xBhH9D2MumELttHxZ0XdYjJvEwfEdEmQbZp6HwtFyG30tl50090/KgHwqOGFPCxI
         9ZCseqL2naoi5DFhyBuXgHSclZ3kOB6wN7OnIPVuq21YYWsb/TEimcf7HymEbRHkja9e
         p5FE7kdHqotxGAybhkXIosUOku/DBSrYl0r4C0ZPH4PYn57eqMEdBUwdFNBu4mrS4Zv8
         AFsQ==
X-Gm-Message-State: ANoB5pnz6MLiOucxX20b8hDOPB5IpRha29Aqr0H9o0S/0ifbm7RxQ4t5
        qhUymwi5qVnKf+TYVbh7/4M=
X-Google-Smtp-Source: AA0mqf52uXRHtcat6g1cDBSffb9BHvne26T0RWlXx66e8mwsVjfpxFljibCX+5KvBvD4EFtE+RGBjA==
X-Received: by 2002:a05:600c:3ba6:b0:3cf:acc5:f7bd with SMTP id n38-20020a05600c3ba600b003cfacc5f7bdmr7511958wms.125.1667932449118;
        Tue, 08 Nov 2022 10:34:09 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d6a4c000000b00228692033dcsm11124391wrw.91.2022.11.08.10.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:34:08 -0800 (PST)
Message-ID: <142fe940-6fcf-4eaa-2cb6-94df541723c3@gmail.com>
Date:   Tue, 8 Nov 2022 19:34:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 0/6] Add mmc-support for mt7986
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>
References: <20221025132953.81286-1-linux@fw-web.de>
 <CAPDyKFriLmsSsy5LfiJJH-s7uQMD1AycE7R4NtN1_Td3XocyOQ@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAPDyKFriLmsSsy5LfiJJH-s7uQMD1AycE7R4NtN1_Td3XocyOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/2022 13:25, Ulf Hansson wrote:
> On Tue, 25 Oct 2022 at 15:29, Frank Wunderlich <linux@fw-web.de> wrote:
>>
>> From: Frank Wunderlich <frank-w@public-files.de>
>>
>> I've noticed the mtk-sd binding needs a bit more work get into a more
>> clean state.
>>
>> There are 2 properties missing that maybe need to be added later or
>> dropped from devicetrees:
>> drv-type (which is used in mt8183-kukui.dtsi and set to <2>)
>> and
>> r_smpl (used in mt7622-rfb1.dts and mt7622-bananapi-bpi-r64.dts, both
>> times set to <1>)
>>
>> i don't know their function and boundaries and i do not find them in
>> driver. I guess they are added by accident, so i removing them in the
>> patches 5+6.
>>
>> v2:
>> - add compatible based binding
>> v3:
>> - solve "not" statement in binding and reorder if statements,drop mt8183
>> - added patches removing invalid properties (not in driver)
>> v4:
>> - squashed part 1 (compatible) and 3 (SoC specific clock config)
>> - new mt7986 clock bindings based on info from mtk
>> - re-add mt8183 reg boundary
>> v5:
>> - add fixes-tags to Patches 4+5 and reviewed-by to 6
>> - drop quotes from mt7986 clock-names from patch 2
>>
>> Frank Wunderlich (3):
>>    arm64: dts: mediatek: mt2712e: swap last 2 clocks to match binding
>>    arm64: dts: mt8183: drop drv-type from mmc-node
>>    arm64: dts: mt7622: drop r_smpl property from mmc node
>>
>> Nícolas F. R. A. Prado (1):
>>    dt-bindings: mmc: mtk-sd: Set clocks based on compatible
>>
>> Sam Shih (2):
>>    dt-bindings: mmc: Add support for Mediatek MT7986
>>    mmc: mediatek: add support for MT7986 SoC
>>
>>   .../devicetree/bindings/mmc/mtk-sd.yaml       | 149 ++++++++++++++----
>>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   6 +-
>>   .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   1 -
>>   arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |   1 -
>>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   1 -
>>   drivers/mmc/host/mtk-sd.c                     |  14 ++
>>   6 files changed, 136 insertions(+), 36 deletions(-)
> 
> I have dropped the earlier two patches I have applied for MT7986 and
> applied patch1, 2 and 6 from this series instead, thanks!
> 

3, 4, 5 applied now thanks!
