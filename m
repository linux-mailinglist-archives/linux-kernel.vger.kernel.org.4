Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA367E465
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjA0MAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjA0L7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:59:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65376EA2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:55:19 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r2so4734501wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGK9WZ16lbXZkqFtM3SgQR1Wjr6DeS1UPNxsNxP5Dls=;
        b=Jzr99gL9j5L2AHl3a5sdtUtwpf2Uymr7zhnQA+wJNf7+HFWZaqVfR/xOouOaJzBKwC
         pq3wooZohecadT3h49kVa1D0mtVSsuKrnnFBuO8mppnpR463pq/Duv7/CR0yGLkPwP0b
         9aVXydRQH/cFjYMjudOOEQ8ejKchp3Rfh9X6ejTDtArHT6jrGDag4tHcX26kBZesOvTV
         zNXMYglrpn1Q/n+kfGLdA4LSocdJ1hTx0t38vAY1V831lAs8mgLRjcyXv6YnTo1Vf1zd
         aAHLb1+x6iAjXODk7PkIir0f6B2nEse/Ns7GjtHDXw49zpvugaIOV0tt1HCfqcE6SMse
         HtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGK9WZ16lbXZkqFtM3SgQR1Wjr6DeS1UPNxsNxP5Dls=;
        b=3Qfnezw6ENd0yjEX5YS6fr+gc4KJoXBGIyVtZklEk6GC8d6Hje3hEepvKqdfHGdnft
         ZhgVrgY5IVfCiJBlssrzZ+WH00YLZag4dkQdSNS4zfq0mQ/SWCGhHjeEcCEqEebAf9Qu
         9jGGjhisxLkqe1m4W0vgnYzVKIe2L3shp5OnzWpRws8nZFBAn+Wq3D3l5SFV4O4l9dNQ
         G69dS93LwO3b33Ra72ZcnkArSePf59Ag/ge7WTB77BXzizzmWoUDtXPbm6sRZUqmcRr5
         XQInbwXZk0myDym2r4YO04ij+Gc9elJ2EK4xZu/1sryF87Cc9JkGEWccQyxpeViqg/wZ
         k8YA==
X-Gm-Message-State: AO0yUKXM4NXfY/3Hb0yNHErzIEkw0n7FO9s+WBhXYcmyfb2sc3LxAmH8
        TD2NzAK7WanIMvolr0UKMQU6yg==
X-Google-Smtp-Source: AK7set+QpQ7+6LvKSS8XS3YposTYS1s0CwK2jSBHJSry7VY6/bljCNPbAGYx4jx9SoyTr6Ce5vH9+Q==
X-Received: by 2002:adf:aa93:0:b0:2bf:ad61:6018 with SMTP id h19-20020adfaa93000000b002bfad616018mr14543430wrc.10.1674820445489;
        Fri, 27 Jan 2023 03:54:05 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a12-20020a056000100c00b002be2279f100sm3736504wrx.96.2023.01.27.03.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 03:54:04 -0800 (PST)
Message-ID: <d4da4803-134c-72aa-a24c-cc6fc3d8acc5@linaro.org>
Date:   Fri, 27 Jan 2023 12:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 5/5] thermal: mediatek: try again if first temp read is
 bogus
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
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
 <9b5911ec-9993-5540-6de5-c62c7c446274@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9b5911ec-9993-5540-6de5-c62c7c446274@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Amjad,

On 27/01/2023 11:50, Amjad Ouled-Ameur wrote:
> Hi Daniel,
> 
> On 1/25/23 11:58, Daniel Lezcano wrote:
>> On 25/01/2023 10:50, Amjad Ouled-Ameur wrote:
>>> In mtk_thermal_bank_temperature, return -EAGAIN instead of 0
>>> on the first read of sensor that often are bogus values.
>>>
>>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>>> Reviewed-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/thermal/mtk_thermal.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/mtk_thermal.c 
>>> b/drivers/thermal/mtk_thermal.c
>>> index b8e06f6c7c42..e7be450cd40a 100644
>>> --- a/drivers/thermal/mtk_thermal.c
>>> +++ b/drivers/thermal/mtk_thermal.c
>>> @@ -736,7 +736,7 @@ static int mtk_thermal_bank_temperature(struct 
>>> mtk_thermal_bank *bank)
>>>            * not immediately shut down.
>>>            */
>>>           if (temp > 200000)
>>> -            temp = 0;
>>> +            temp = -EAGAIN;
>>
>> Did you try to add a delay between the bank init and the thermal zone 
>> device register (eg. 1ms) ?
>>
>> May be the HW did not have time to initialize and capture a 
>> temperature before thermal_zone_device_register() is called (this one 
>> calls get_temp) ?
> 
> A delay of 29 ms actually fixed the issue, thanks for the suggestion. I 
> can send a V9 with this improvement.

I'm glad that helped.

Will you remove the "if (temp > 200000)" test ?

> Is there anything else to fix perhaps ?

Not in your changes

Thanks

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

