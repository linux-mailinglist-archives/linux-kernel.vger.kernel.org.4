Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E69690D17
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjBIPfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjBIPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:35:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3687D63138
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:35:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bu23so2155873wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tq8yGCw5g55228TSVXqVlwEC96LSIgCuU4gj18BrnfY=;
        b=tkeWbi9wJTc9MeRzDy7qt1yPzQkZQNYP6/bgOt9vpo8YMSazZ45GxT4G3k0vGuQKqG
         3VMLzYSNoYmjAfnVkuHgGePIMkbxJ9V+pc+9mwmrBS+bCkAEknjI0NXxjQ3sf8hAgtlV
         AWu2ZCfMG/1mQyG13CnD2A//AmEx1IcELAJqdb8DZJlhKZ2jRqlIwS+jBzUGX0SOrETz
         UKcs8NkqrqRP1RUE/5Ac7ABvd86WoXCLgsBxsfYWsE2oKMqvsqXkYSTG7pLArmd22aW0
         m4Isc8M48QrwUYMXDz6NGDj5kU0TySAdvfz7/hmwS7MrRNAmG4D+KKfDDWTpJwovGsY+
         ml7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq8yGCw5g55228TSVXqVlwEC96LSIgCuU4gj18BrnfY=;
        b=KuTkMqNdfaPC0oSzpER9BtTaUuq2yatjl+p6EdCJblz7OFDFTH0L8WkNN5UyUebPTU
         +IX+EUYCU5ECiidFhhX/eEabjU6gbItaetGJ/IX8pHDi/58Mf00+jxK25R4trX6kf55t
         IQSkkFWeAvmpNg2tJ1n7Ze+m7W2sxMu95kWXZwBGS4XP+rFV4z7uXorm7coShM0mh4+e
         tfXpcb78zqdKXCL5zx9lsvRIIZtqNmxJ2rhKhnk5+2K2QNaDHMMugbJUWG2O3IrCTuby
         oWN5CSAyrgYGNDHtcK/xore9CBQkyWydKIDXEMCIauDXgMio2VGG+UhcaWbLxQ5VYjja
         x6yA==
X-Gm-Message-State: AO0yUKWDdNXHA27oPtLRVvu8a+cUava5hoM3KNw4I6AKcW6K0vLKh4WX
        /6YobRa9A0pmyFyVS+sPlhqR5g==
X-Google-Smtp-Source: AK7set8xTgUyE+Dwtou5d4+iZUWo5Vra04tsnSr6qBKJsukN5Tl3gL04SGtgKiJb8efwj/hPHlEgpg==
X-Received: by 2002:adf:d847:0:b0:2c4:645:da29 with SMTP id k7-20020adfd847000000b002c40645da29mr4972638wrl.65.1675956899678;
        Thu, 09 Feb 2023 07:34:59 -0800 (PST)
Received: from [172.17.49.168] (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.googlemail.com with ESMTPSA id o26-20020a5d58da000000b002c3f1223059sm1525636wrf.36.2023.02.09.07.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 07:34:59 -0800 (PST)
Message-ID: <5821b2c6-0e50-5a75-0d11-c299e68cb200@linaro.org>
Date:   Thu, 9 Feb 2023 16:34:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] time/sched_clock: Export sched_clock_register()
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        walter.chang@mediatek.com, Thomas Gleixner <tglx@linutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>
Cc:     wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230208094813.20874-1-walter.chang@mediatek.com>
 <20230208094813.20874-2-walter.chang@mediatek.com>
 <e1a89a4e-8a0d-47e1-a8fd-75ea152ef816@linaro.org>
 <ad3a5c30-5062-55ae-7908-c0a127bec5ee@gmail.com>
 <3bbc55b8-6b12-4e81-026d-75e0c9116a7b@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3bbc55b8-6b12-4e81-026d-75e0c9116a7b@linaro.org>
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

On 08/02/2023 20:45, Krzysztof Kozlowski wrote:
> On 08/02/2023 20:41, Matthias Brugger wrote:
>>
>>
>> On 08/02/2023 15:24, Krzysztof Kozlowski wrote:
>>> On 08/02/2023 10:48, walter.chang@mediatek.com wrote:
>>>> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>>>
>>>> clocksource driver may use sched_clock_register()
>>>> to resigter itself as a sched_clock source.
>>>> Export it to support building such driver
>>>> as module, like timer-mediatek.c
>>>>
>>>> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>>> ---

[ ... ]

> ... and actually test if the system works fine when booted from such
> clocksource as a module. I have doubts that and unfortunately folks
> working on GKI like to put whatever stuff from mainline into modules
> even if it does not make sense for us (see long time ago discussion
> about pinctrl drivers).

+1

It is not the first time there is a proposal to convert the timers to 
modules. After asking, nobody came with a real study regarding the 
impact of the modularization of these drivers vs the time core framework 
and the benefit.

My gut feeling is that is not that simple.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

