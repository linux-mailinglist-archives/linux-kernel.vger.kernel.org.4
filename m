Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36967E237
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjA0KvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjA0KvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:51:07 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668C9783EE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:50:50 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so5117246wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HwSavTNmt/iSOWToRrOQRo5WI793hfeDOFSkH2AVIz4=;
        b=A7BuikDUFnrnOkNs916iNPhILrb7gliAt6eo8nRlWdME4PTFbBNJ3aDOqDnwIpTSQY
         z+ZyqKx+O38L99+8VzZAlfgVTtrnUCLP/vaPuao/SMaJ56swbuQ6u+VZtqaWWEG43Ijz
         wmiZGAY709vdHZo8FQ93iJK2M+ufm4iWJpqORKO1M2lTSxr1WZsYvkxma4YcMImOs4+b
         +WI/iNo6Q+eh8PTJoLcmt/nCleaqD2a3qLuO/N+CTFbqR+leiQvT6XlPxid/f+GpBWVO
         h4ou/aUEIfE8mMENFwYH5dvwhuAQYfslY4qUYpiIyS/xbHQSc/53tiLa8V1MfpXgFurJ
         vuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwSavTNmt/iSOWToRrOQRo5WI793hfeDOFSkH2AVIz4=;
        b=bWfKi8QzWxRYO8TO1u8sx7/hJ/9H1uB2HcGvto/9KrGExrtpgjuizZzXr4Gg4qqXP1
         k76zmaoGolbYDfuVqKNb+iQiXen2EU8FuISyorTk4Sa5vKclkyoa8GB4qlCVjG43h5Zk
         wwXoHDx2dHn5L4xDL9OTk3dwWmjH4JdXnYy4jdL7L6jWRc1bN137SsFMS6Sh9U+iqERl
         OQ3MSP3wnZAR2iT+Rjoa5eQty4DshfcaaLXfh2bhbGJPuJH7Ww0f2LxMBVRjIxbKq0zh
         7GuOfUC0IRs7p6HnyR/x9fs6moA/qvLqKmxxlDgKRps2rKKNz7g1rSTHrvlDhJW27JE3
         npeA==
X-Gm-Message-State: AFqh2krFZYb5oCXad8ebIHx0+cq83RynjLxwqMuLF4o6ykp5EB/FQfGt
        /b6O2N3YtqD0NIFW6pxBJC9OTA==
X-Google-Smtp-Source: AMrXdXvW1bSIjLK7Tu0+rEdSDxo9z/Df4JT/zK4JmYVf4bN2G5mcNCKaqFahL8xtSz0ogBFXfk+JDw==
X-Received: by 2002:a05:600c:4b9a:b0:3da:fcdc:cafd with SMTP id e26-20020a05600c4b9a00b003dafcdccafdmr38636963wmp.13.1674816648946;
        Fri, 27 Jan 2023 02:50:48 -0800 (PST)
Received: from [192.168.0.20] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c19cc00b003db0ee277b2sm8128445wmq.5.2023.01.27.02.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:50:47 -0800 (PST)
Message-ID: <9b5911ec-9993-5540-6de5-c62c7c446274@baylibre.com>
Date:   Fri, 27 Jan 2023 11:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v8 5/5] thermal: mediatek: try again if first temp read is
 bogus
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Michael Kao <michael.kao@mediatek.com>
References: <20221018-up-i350-thermal-bringup-v8-0-23e8fbb08837@baylibre.com>
 <20221018-up-i350-thermal-bringup-v8-5-23e8fbb08837@baylibre.com>
 <96e7aaf5-76ef-9356-84e2-ee1f747dafcd@linaro.org>
Content-Language: en-US
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <96e7aaf5-76ef-9356-84e2-ee1f747dafcd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 1/25/23 11:58, Daniel Lezcano wrote:
> On 25/01/2023 10:50, Amjad Ouled-Ameur wrote:
>> In mtk_thermal_bank_temperature, return -EAGAIN instead of 0
>> on the first read of sensor that often are bogus values.
>>
>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/thermal/mtk_thermal.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
>> index b8e06f6c7c42..e7be450cd40a 100644
>> --- a/drivers/thermal/mtk_thermal.c
>> +++ b/drivers/thermal/mtk_thermal.c
>> @@ -736,7 +736,7 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>>            * not immediately shut down.
>>            */
>>           if (temp > 200000)
>> -            temp = 0;
>> +            temp = -EAGAIN;
>
> Did you try to add a delay between the bank init and the thermal zone device register (eg. 1ms) ?
>
> May be the HW did not have time to initialize and capture a temperature before thermal_zone_device_register() is called (this one calls get_temp) ?

A delay of 29 ms actually fixed the issue, thanks for the suggestion. I can send a V9 with this improvement.

Is there anything else to fix perhaps ?


Regards,

Amjad

>
>>           if (temp > max)
>>               max = temp;
>>
>
