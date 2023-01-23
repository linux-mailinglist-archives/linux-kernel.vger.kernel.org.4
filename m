Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF91E677FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjAWPZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjAWPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:24:58 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052472A9AA;
        Mon, 23 Jan 2023 07:24:32 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id rl14so28096304ejb.2;
        Mon, 23 Jan 2023 07:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quFutVDzXOuiGFOnAIlXrcYj/4FfLNEimxfsbTCP31g=;
        b=casY42fp0CPsxMpDebmQUR6sYU5KhJU1Dyv0pYM4Y1JmNEFcoiTmZm5cwTHNGJc3R3
         ty3pD1p43EHIPGwphlwumHC3o6XpXJ14ityW2AQk2dCZ3idvZ1t8Q1MBLl04n1nYy6Ov
         uqoPh27+B6vzYNUtCsJxicjfc5yIQt80MoP80a+E5W9IxgSyUx0sdbj5RTOh/qbmlj/U
         GIQFkgaFJpCQzf2rOTCH8PV8mjg/YOHgKcoK73ucH7g7NUbGXL8aSYvK7uhvaQJrOdIo
         18RxGduHZxG++UFh4uSyQFLxTVgBjNrDEGtaHRl3Oz0jgwIjiBvNNTvQ7SZlmI2mPF9o
         D+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quFutVDzXOuiGFOnAIlXrcYj/4FfLNEimxfsbTCP31g=;
        b=d2LC9hB2tR2z64L8OSy9nWjKK7BT7gTNbaKVGdhv4Q+p69NxPP2J/w9tg1GydBCubC
         WRAsVkTWNUP8VU109bRg8pDVbvqIdYtMlT0sxo0+cipqUESNfZAaNpTS5pOH1DsD7Gdx
         I+QIxp2QmvW3X4Yk9F2HAfLdN9FdKDVymmvjkWFr4iU+vTR7AAL7bMftVKlHztw93k+7
         o7grD7Z2yb0tZJ7sh2+293YR7Y5edm1v14DlCy4m956G+z2SbVwx2ewCw9XwDJhGooQh
         PNU5w+4YCMNHzleblUDprNum8wFsHLL8WEBtvt5/t4wusrBU38Gyqnf/KXlMGmuVYr2c
         Lq8Q==
X-Gm-Message-State: AFqh2kp3s7cOGp+rDp9Riu+QDsJXZDA8A4zo8i8Fw9IN8s2oH8cHwaQ0
        LXkzHExUf0mEfXj8n5DeDg0=
X-Google-Smtp-Source: AMrXdXsNXZAjwBSF2rV5p0/d14xBhorkGt2j6MBSzb7IRXW1/AvdX71aI7knW2abe2geUXIw0Crd+A==
X-Received: by 2002:a17:906:79d8:b0:877:a2d1:7560 with SMTP id m24-20020a17090679d800b00877a2d17560mr12044853ejo.27.1674487469938;
        Mon, 23 Jan 2023 07:24:29 -0800 (PST)
Received: from [192.168.3.54] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id i20-20020a1709064ed400b00872a726783dsm9878482ejv.217.2023.01.23.07.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:24:29 -0800 (PST)
Message-ID: <ecfc1831-6500-e9fc-efec-b4574c3a61bb@gmail.com>
Date:   Mon, 23 Jan 2023 17:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/2] Add support for Samsung Galaxy S5 (Exynos)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
References: <20230121201926.46990-1-markuss.broks@gmail.com>
 <703ad169-fb10-651c-96fe-22d2eae959b6@linaro.org>
Content-Language: en-US
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <703ad169-fb10-651c-96fe-22d2eae959b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 1/23/23 11:59, Krzysztof Kozlowski wrote:
> On 21/01/2023 21:19, Markuss Broks wrote:
>> Samsung Galaxy S5 (Exynos) is a mobile phone released in 2014.
>> It has an Exynos5422 platform. This version of Galaxy S5 is only
>> capable of 3G communication using the Intel modem, while the
>> LTE version of the device (klte) has a Qualcomm Snapdragon SoC.
>>
>> Currently, internal eMMC, USB, regulators on a PMIC, and touchscreen
>> are enabled in the device-tree.
>>
>> It also has the following peripherals:
>>
>> - 5" 1080p S6E3FA2 DSI display,
>> - Cypress StreetFighter touch buttons,
>> - Broadcom BCM4354 wireless connectivity module,
>> - Intel XMM6360 3G modem,
>> - STM32F401 serving as a sensor hub,
>> - Validify Solutions VFS61 series fingerprint sensor,
>> - Lattice ICE401M FPGA as an IRDA controller,
>> - Maxim MAX86900 heart rate sensor,
>> - NXP PN547 NFC controller,
>> - Wolfson WM5110 Audio DSP,
>> - Broadcom BCM4753 GPS radio,
>> - Maxim MAX77804 PMIC,
>> - Silicon Image SII8240 MHL controller,
>> - TI LP5562 LED driver
>>
>> Cc: Mark Brown <broonie@kernel.org>
>>
>> v1 -> v2:
>> - use better subject prefixes
>> - rename Galaxy S5 (Exynos) to Galaxy S5 (SM-G900H)
>> - align the compatibles and clock output names
>> - reorder the includes
>> - generic node name for regulator-tsp-vdd-en
>> - GPIO flag for regulator
>> - rename all the regulators, leaving the voltage values only where
>>    it makes sense (e.g. on 3V3 and 1V8 supplies for the HRM)
> I got two v2 patchsets from you. No clue which one is correct. Please
> send v3 if there were differences. Otherwise please annotate somehow...
Sorry about that, the first time I sent v2 it lacked the v2 tag in 
actual patch letters, but contained the tag in the cover letter, so I 
thought it would make confusion, so I fixed it and sent it properly. The 
patchsets are identical otherwise.
>
> Best regards,
> Krzysztof
>
- Markuss
