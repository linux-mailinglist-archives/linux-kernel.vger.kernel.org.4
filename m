Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC50D60AFA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiJXPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiJXPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:53:49 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA31CB04
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:49:13 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id e15so6505682qvo.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KiZKr4vVKiBAMCknSXKk7OaZnMVGhLrm0Fpb1/F76Ak=;
        b=Pjqyjt8ciOBBxKf/tgqFyRvVj8YjqhDMxQtTt5Ecs2Eu5qhxq5NGCAG/oKNGao7VTa
         JQxTHYdSOc6Ek/e2RfV2pFYzGPL2/SX7G9pZP+ZwLtWKOSyZ/OuazNTSL66XQnEJ+JAQ
         FsB5f7AFkKVWTnZI3zzvMBnvpGSoMNIyigmNjJmDaYxkCJ+PrvIqg2DDtpQ3CkGym2xo
         1/qgdeISTMhsSwnsKxvgLjfST0dKXBQUh4UmZCTH9K2IXOghkF2LwOg9HyjUnQCo+qbk
         N4Qh+ysyWsBdJR9JKKnQXtyaEZYleTI4wyuQq8DtmjnlDl2no9LO8n+TilKetKXbtNFz
         wipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiZKr4vVKiBAMCknSXKk7OaZnMVGhLrm0Fpb1/F76Ak=;
        b=uDDuqXXK8bMd7vRngB+CJLYIf5NBP1WOHfhwI8eZxCOR2v0vFpmBpKoBtR3K3eIopv
         TqwlO8CAkJyRn2gToacR3Q6oIfp+0yfCWMTP1rhYZK1C5MHkx2JjaIYaiKCZaulOWMs2
         BxDhi9kFOtNQIHEFB2EoN87awl9ylobJaESCC0yXAX8MJjmKxBUgnPVdho9lFg8hnTKC
         wo/1zkPBFfJ1TRku5wWLPNmMsK0ZGTd4T8DmuzWqpPQDL55j6ZOMIg4gTcbEKxrrizeV
         eI9/pj+s8oUgxipqSj2PAaLyaIGDG7sRuQmAFCvQuCIQI+OecCBl0q1WMXdsQ5SzNHSg
         qGrA==
X-Gm-Message-State: ACrzQf2HtapOrgJb/FE8X/q51T6cFUMtZbzjySVwLjTBb2tDUrKnd13L
        i5Yugh6hplO9bs1ed8MlLI2mZrByABI5Tw==
X-Google-Smtp-Source: AMsMyM6QBU8we6whgGDieruOEgMwW/cTO2KHBX9O//ujatJzasoGEK+uPqOb8astjsF60GtF4W/nqQ==
X-Received: by 2002:a05:6214:27e9:b0:4ac:a4b7:b688 with SMTP id jt9-20020a05621427e900b004aca4b7b688mr28877333qvb.75.1666620808554;
        Mon, 24 Oct 2022 07:13:28 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id dm10-20020a05620a1d4a00b006bb87c4833asm15084211qkb.109.2022.10.24.07.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:13:27 -0700 (PDT)
Message-ID: <186642c0-0417-9947-341c-a4c96257a84f@linaro.org>
Date:   Mon, 24 Oct 2022 10:13:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 05/21] ARM: s3c: simplify platform code
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-5-arnd@kernel.org>
 <fc923325-335d-e768-ea72-ba1712320d9d@linaro.org>
 <9912a1eb-ad12-4608-bf48-d74ac5f5805a@app.fastmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9912a1eb-ad12-4608-bf48-d74ac5f5805a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 09:32, Arnd Bergmann wrote:
> On Mon, Oct 24, 2022, at 14:29, Krzysztof Kozlowski wrote:
> 
>>> diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
>>> index c403d7642f0a..c52c7ce1d8fa 100644
>>> --- a/arch/arm/mach-s3c/Kconfig.s3c64xx
>>> +++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
>>> @@ -15,12 +15,9 @@ menuconfig ARCH_S3C64XX
>>>  	select HAVE_TCM
>>>  	select PLAT_SAMSUNG
>>>  	select PM_GENERIC_DOMAINS if PM
>>> -	select S3C_DEV_NAND if ATAGS
>>>  	select S3C_GPIO_TRACK if ATAGS
>>> -	select S3C2410_WATCHDOG
>>
>> This does not seem right. S3C2410_WATCHDOG is a driver used by all
>> (including Exynos) platforms.
> 
> I don't remember why I removed this line, probably because I
> removed S3C_DEV_WDT after there are no references to that
> symbol left in board files. The watchdog driver is now DT-only
> with cragg6410 being the last remaining board file.
> 
> Ideally we should not 'select' it from here but instead have
> it enabled in the defconfig file, but I agree that would
> be something to do in a separate patch, while the patch here
> should not change the behavior. I'll revert this part.
> 
>>> @@ -121,10 +118,8 @@ config MACH_WLF_CRAGG_6410
>>>  	select S3C_DEV_HSMMC1
>>>  	select S3C_DEV_HSMMC2
>>>  	select S3C_DEV_I2C1
>>> -	select S3C_DEV_RTC
>>
>> This as well.
> 
> I'm fairly sure this can be removed along with S3C_DEV_WDT,
> S3C_DEV_I2C[2-7], S3C_DEV_NAND, and S3C_DEV_ONENAND
> as I remove the symbols due to the lack of references
> from cragg6410.

Yes, you are right. This can be dropped.

> 
> I folded in this fixup now:
> 
> --- a/arch/arm/mach-s3c/Kconfig.s3c64xx
> +++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
> @@ -16,8 +16,10 @@ menuconfig ARCH_S3C64XX
>         select PLAT_SAMSUNG
>         select PM_GENERIC_DOMAINS if PM
>         select S3C_GPIO_TRACK if ATAGS
> +       select S3C2410_WATCHDOG
>         select SAMSUNG_ATAGS if ATAGS
>         select SAMSUNG_WAKEMASK if PM
> +       select WATCHDOG


Looks ok.

Best regards,
Krzysztof

