Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2039664E7B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLPH2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiLPH2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:28:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AC22F66A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:28:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h7so1613586wrs.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mW7QVt5GH3e598iWydxa74nESqdi2JjbfGI/OH0/N4=;
        b=HzPqlS3pSJKX/mWg1aDPh3gvD5j5vVwFrI1oPVhVq0OU90pjIL4AHCWuTX6FwdrH29
         UC1oZF5oNlBEnUfHZOh3y5JsKjFOXQQ8xuYJ0gcP2UzgC/d08zbXfLvS2z0ofXLelTxq
         gn7z21Gmim6PrUf1gMW5fgojW1UV/HRNWvLz3ZGQY4RPufEy75lvMvJRWo/I2Gj1rNI5
         V5h1Oqb8Mi2jOhHPWUCmhg458gzCQP3M4znlhdWMsOB6Y3r8i9v6AcxqURgtPHlSeCGw
         3Gm8d46jhoI98aGwJibETXxGvINhzNvnNhJ/2HoDgZrmnnf+rFtro8E8tKq5QiFs6cOW
         2DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mW7QVt5GH3e598iWydxa74nESqdi2JjbfGI/OH0/N4=;
        b=U7LwQ5y9XjAMON6KO44j31qnllAxtp5KroAknNx+5w8Z6GvyHcw1YdC2e1VB/YXTdx
         ZZQ1NObieVj9JvQkn9pBz3vB1fMj1KlaYJcTeqeqsJZ42BRVJbRcVjCkgWOPAYsf+t7I
         sj8wC8JNbEKxSST5X2QSfcfPEqO1HuhHk5hx7+lTgjJNWCihiUUIR+H/YoIubs1Am0kv
         BXd6GIV9otCiqvxrcHuYiACz6o7Z4jDf+QLvV7cWHploZXl+imjLhQXHvbO70dArq0sp
         uA3VA3dsnrxwMeL2MtUz1Jc3H3rN3jcwdUemKqDYhpTWWub7snP22JZ38r0VPkJpomad
         O3Ow==
X-Gm-Message-State: ANoB5pmcKoLwXvkSh1eLgfYGU8CsV2UpPESzP8VllGL2Dk5pfc76cIc8
        LJXzogzkIR6hoMqGxEXvgvtMpw==
X-Google-Smtp-Source: AA0mqf4v6cBApCiabUT5dWKT5Iaw++KpSoED6jqDXvZelej5Hfe95uM7HEGCGLzAfd0oCYIw/fYf1w==
X-Received: by 2002:a5d:6a0c:0:b0:242:4bbe:2d20 with SMTP id m12-20020a5d6a0c000000b002424bbe2d20mr18379863wru.42.1671175708861;
        Thu, 15 Dec 2022 23:28:28 -0800 (PST)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4cca000000b0024278304ef6sm1498230wrt.13.2022.12.15.23.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 23:28:28 -0800 (PST)
Message-ID: <c2014039-f1e8-6976-33d6-52e2dd4e7b66@baylibre.com>
Date:   Fri, 16 Dec 2022 08:28:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 1/6] DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC
 support for AM642 SK board.
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wadim Egorov <W.Egorov@phytec.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jeff@labundy.com" <jeff@labundy.com>, "afd@ti.com" <afd@ti.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "j-keerthy@ti.com" <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-2-jneanne@baylibre.com>
 <d0d7e315-ce86-0420-8ef5-fe2e4aefd5b4@phytec.de>
 <e2bc53fe-3a0c-cf24-8b29-ca377aba3721@baylibre.com>
 <Y5tGzjgcAWPqdFNE@sirena.org.uk> <20221215175411.znxy3d6ussq2iq5h@grieving>
 <Y5tl3+2pJispcXy6@sirena.org.uk> <20221215214149.whcjdphxxvvedrih@affront>
 <b6ea8cb7-38c4-13cf-a08a-ece973859342@ti.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <b6ea8cb7-38c4-13cf-a08a-ece973859342@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/12/2022 07:21, Vignesh Raghavendra wrote:
> 
> 
> On 16/12/22 03:11, Nishanth Menon wrote:
>> On 18:22-20221215, Mark Brown wrote:
>>> On Thu, Dec 15, 2022 at 11:54:11AM -0600, Nishanth Menon wrote:
>>>> On 16:09-20221215, Mark Brown wrote:
>>>
>>>>> That proposal looks really non-idiomatic and quite unusual, if there's a
>>>>> fixed voltage supply to the LDO I'd expect to see it modeled as a fixed
>>>>> voltage regulator.  I'm not sure what the use of bypass here is trying
>>>>> to accomplish TBH.
>>>
>>>> The problem is this - the default NVM in the PMIC is setup such that
>>>> VSET value =3.3v and bypass bit set (makes sense since the vin=3.3v).
>>>
>>> This implies no voltage drop over the LDO?  Sounds a bit suspect.
>>
>> Not the choice I'd probably have made ;)
>>
>>>
>>>> Now the constraint is bypass bit cannot be changed without the LDO
>>>> being switched off.
>>>
> 
> Per https://www.ti.com/lit/ds/symlink/tps65219.pdf (7.3.6 Linear
> Regulators).
> 
> LDOs have two modes:
> 
> 1. Load switch mode: in this case, output voltages of 1.5V up to 5.5V
> are supported.
> 
> 2 Linear regulator LDO mode where output voltage is programmable in the
> range of 0.6V to 3.4V in 50mV-steps with possibility of bypass.
> 
> (CAUTION on page 25):
> A mode change between LDO(/bypass) and LSW-mode must only be performed,
> when this regulator is disabled!
> A change between LDO and bypass-mode (supported by LDO1 and LDO2 only)
> is supported during operation.
> 
> So, seems like bypass can be toggled even with LDO on?
>I possibly miss-interpreted this caution statement which leads to that 
situation.

Your understanding sounds correct. My mistake... Sorry for that


Regards,
Jerome.
