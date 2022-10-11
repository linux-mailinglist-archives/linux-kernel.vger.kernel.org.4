Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5595FB0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJKLCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJKLCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:02:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891688B2D3;
        Tue, 11 Oct 2022 04:02:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s2so19607707edd.2;
        Tue, 11 Oct 2022 04:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzksgh0x+zMbqkL5lOd9iUIZ7M+qRWCpvFKFVhrZ8Dw=;
        b=Uhop3Sq0002OM4Hjr3ys31jz0FLsKMP+77kfswKwyjTaVh+2P31pQbplzKzlhij/mi
         gqPm0HB1I11ewOvvbVHjMHiAYmqBUuHhvhKiXZMyLlPATRUwHcSoeAhEr+VDF/ah9eT2
         Sf0Ralh1RnYYmTVhWP56Nk3QjB1bU44eoeR3OykD26Samm/YFqtEPOtOy+WbhtH1rWQF
         zvIHEMB231pZjwqcCbAfZvRQtaaR172QWmVvvwdDyNPUOU3kiZ1slLmXpdzil24qKCeK
         +Eh3dq3xpQKSjeF2LfDdtvXMQgdsLltqR3UGVrfTv2qsqzaD/y0GLkaL9Tyj2XhWFuis
         f2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzksgh0x+zMbqkL5lOd9iUIZ7M+qRWCpvFKFVhrZ8Dw=;
        b=qu4zxAEL0axu/xjK6doVBCBe2QbOVopdRg60+t8dB+gFsF+FDADvqyaqshQG1+v/Jf
         /U8tsKYqc0F6HRgQt2EpqnlVJSAkHq2OeWZkjmBSMxUFgk/YrV+2xEs1Fgf9Mgla0izC
         zEfE8kyCgfRvCCerzUAsStixJBLskbq7PcNjKKoe5ft85NcmKo7dqX+cwtiBcmltwmuL
         6j41YE3TZicYBURb83zMzg5X5QASis14UNDNC+3chvTmlxiOstCgnlWF00lKYIUqJyZl
         7rj8N5kXeBijFvWlX8w31+CoBGSMn73G7Yh781Q0YnxipfNzJjqHgaBiGzNA8Bvt3Ghu
         J8TQ==
X-Gm-Message-State: ACrzQf3qTZDzpgy5KOZviKkoKGzPZaURj8n55NwTciCq1c5xpmSXHdjb
        RuFAXuPZHPpMzXhZxe/r5p4J1N6WWwY=
X-Google-Smtp-Source: AMsMyM5EJXVN5zoQgHh4FaQ4dx3WtUOiDD6MKCS0aAGX8ewxL3N97a2u9xNKznKUqkvfmP19dC/Dlg==
X-Received: by 2002:a05:6402:191:b0:45c:83e8:d74a with SMTP id r17-20020a056402019100b0045c83e8d74amr1671165edv.329.1665486128969;
        Tue, 11 Oct 2022 04:02:08 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b0077086d2db8esm6873717ejd.140.2022.10.11.04.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 04:02:08 -0700 (PDT)
Message-ID: <cc1d1b63-4ee6-68cf-a175-401239539e18@gmail.com>
Date:   Tue, 11 Oct 2022 13:02:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v14 3/3] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        ChiaEn Wu <peterwu.pub@gmail.com>, pavel@ucw.cz,
        matthias.bgg@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com
References: <cover.1665488982.git.chiaen_wu@richtek.com>
 <657f73ae257925ebc68dc825998384ad79d31e1f.1665488982.git.chiaen_wu@richtek.com>
 <68ab0f05-e74a-e091-0109-09b57b90c652@collabora.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <68ab0f05-e74a-e091-0109-09b57b90c652@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 11:52, AngeloGioacchino Del Regno wrote:
> Il 11/10/22 06:05, ChiaEn Wu ha scritto:
>> From: Alice Chen <alice_chen@richtek.com>
>>
>> The MediaTek MT6370 is a highly-integrated smart power management IC,
>> which includes a single cell Li-Ion/Li-Polymer switching battery
>> charger, a USB Type-C & Power Delivery (PD) controller, dual Flash
>> LED current sources, a RGB LED driver, a backlight WLED driver,
>> a display bias driver and a general LDO for portable devices.
>>
>> Add support for the MT6370 Flash LED driver. Flash LED in MT6370
>> has 2 channels and support torch/strobe mode.
>>
>> Signed-off-by: Alice Chen <alice_chen@richtek.com>
>> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
>> ---
>>
>> v14
>> - Remove unused 'depend on OF' in Kconfig
>> ---
>>   drivers/leds/flash/Kconfig             |  14 +
>>   drivers/leds/flash/Makefile            |   1 +
>>   drivers/leds/flash/leds-mt6370-flash.c | 631 
>> +++++++++++++++++++++++++++++++++
>>   3 files changed, 646 insertions(+)
>>   create mode 100644 drivers/leds/flash/leds-mt6370-flash.c
>>
>> diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
>> index d3eb689..0dd955c 100644
>> --- a/drivers/leds/flash/Kconfig
>> +++ b/drivers/leds/flash/Kconfig
>> @@ -61,6 +61,20 @@ config LEDS_MT6360
>>         Independent current sources supply for each flash LED support 
>> torch
>>         and strobe mode.
>> +config LEDS_MT6370_FLASH
>> +    tristate "Flash LED Support for MediaTek MT6370 PMIC"
>> +    depends on LEDS_CLASS
>> +    depends on LEDS_CLASS_FLASH || !LEDS_CLASS_FLASH
> 
> This dependency makes no sense, as the options in the Kconfig you're 
> putting
> this into gets parsed only `if LEDS_CLASS_FLASH`.
> Please remove that.

So the Kconfig is buggy. Someone didn't take into account
`config LEDS_MT6360` requirements when moving drivers to the
flash subdirectory.

> 
>> +    depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
> 
> Well, if it depends on that being either y, m or n, it means that it does
> not depend on that at all. Remove.

I disagree. It makes a lot of sense.
This syntax allows creating correct dependencies by depmod for both
cases when V4L2_FLASH_LED_CLASS is enabled or not, since the driver
can work in both cases.

> 
> After which,
> Reviewed-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>
> 
>> +    depends on MFD_MT6370
>> +    help
>> +      Support 2 channels and torch/strobe mode.
>> +      Say Y here to enable support for
>> +      MT6370_FLASH_LED device.
>> +
>> +      This driver can also be built as a module. If so, the module
>> +      will be called "leds-mt6370-flash".
>> +
>>   config LEDS_RT4505
>>       tristate "LED support for RT4505 flashlight controller"
>>       depends on I2C && OF
> 
-- 
Best regards,
Jacek Anaszewski
