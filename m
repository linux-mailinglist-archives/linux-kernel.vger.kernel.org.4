Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433A368C080
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjBFOu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjBFOu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:50:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71AC24C90
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:50:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so10940287wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xj5rghWD9HHvdaDeOxD1ymwL8XZWcK1ZvSHaDd4etb4=;
        b=OzPSK6luNf4eYVfUJKBlBnZtjGvgbGVjvrk5hXAR7Pd82Qp6uOsyoSgOOAHZtIbF1x
         uo6Fn2JB5LSEfXZ7u2Idd/yosFnGV5za0Hybhy9W8uzT5st3/rgJCWJ18aBgyv4w7Xsu
         2bkzgz2ip1mp5uqLEgxlbRg7W8EIZL2NNWwL0B9pHfeaqabD0sX0TwMW6I+Ai+z+ky61
         uqh2qAQM9aMR1nZEag/1uw9hRmkbTHkQhe2lfQhUTCyPw3gQn5QqR8kkG4hOb59ANhHS
         LAODPoLih+Hd4gTY6JbsErx9EVkyhKAmxkDcqdLzBBSXDaL+BdAF+Q0/bGB6tJkFd+Ul
         Le5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xj5rghWD9HHvdaDeOxD1ymwL8XZWcK1ZvSHaDd4etb4=;
        b=ZH3f4NAx1reeEk/zJKTkmZvYVUy8TMgd+bNaURHVa/zR9PBnqa8MAgSPwoYRJ7O3vS
         87IcV3/GjFV1FxgHx4AIbCUJVLiMxIlkN/ZhXCc1cXYIDNi+55sdQSBkh0za8w360NXE
         pak1J/ZI/wndr26ECL6SVi15LFlWYbx/fo9D4dfjqrnHP2JVX+A9yC2rl8y1iYUJxPJz
         AYMqZdw6kz02wZ8CQmea6mprLuzAXpqWWBTiruZm6mlNREt3/2tJvOYouc9qpqbHno10
         TcbfWxODCWExVnVTJ5uN85bc+hib4k59ouzeJ1ozGtHO0YP9kmspCCioFjUtlbJoHk6C
         EHUw==
X-Gm-Message-State: AO0yUKW14c8XQAgyDDfPIU43vhQbng17FH6P7ys+KP7vs9xl3mtQnX/P
        wC8uYJMV5xAMevGyRJEhA6WRdA==
X-Google-Smtp-Source: AK7set+GTdygKvnYzpFQzeoj2zGAMebxHRR3Ax/eELQQ9kpUcI1S38whsNzBhVq47acAQ0IldgXA8g==
X-Received: by 2002:a05:600c:2143:b0:3df:85d2:c768 with SMTP id v3-20020a05600c214300b003df85d2c768mr17217899wml.26.1675695024478;
        Mon, 06 Feb 2023 06:50:24 -0800 (PST)
Received: from [172.17.59.64] (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.googlemail.com with ESMTPSA id k24-20020a05600c0b5800b003cfa622a18asm16406813wmr.3.2023.02.06.06.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:50:23 -0800 (PST)
Message-ID: <f626967e-d6e6-817f-abeb-4aed89856c66@linaro.org>
Date:   Mon, 6 Feb 2023 15:50:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: thermal/drivers/tegra: Getting rid of the get_thermal_instance()
 usage
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Wei Ni <wni@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Johan Hovold <johan@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
References: <fa2bd92a-f2ae-a671-b537-87c0f3c03dbd@linaro.org>
 <Y9J4WAFyXyV/nqlG@orome>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y9J4WAFyXyV/nqlG@orome>
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


Hi Thierry,

did you have the time to look at the get_thermal_instance() removal ?


On 26/01/2023 13:55, Thierry Reding wrote:

> 	[   12.354091] tegra_soctherm 700e2000.thermal-sensor: missing thermtrips, will use critical trips as shut down temp
> 	[   12.379009] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when cpu reaches 102500 mC
> 	[   12.388882] tegra_soctherm 700e2000.thermal-sensor: programming throttle for cpu to 102500
> 	[   12.401007] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when cpu reaches 102500 mC
> 	[   12.471041] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when gpu reaches 103000 mC
> 	[   12.482852] tegra_soctherm 700e2000.thermal-sensor: programming throttle for gpu to 103000
> 	[   12.482860] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when gpu reaches 103000 mC
> 	[   12.485357] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when pll reaches 103000 mC
> 	[   12.501774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when mem reaches 103000 mC
> 
> and after these changes, it turns into:
> 
> 	[   12.447113] tegra_soctherm 700e2000.thermal-sensor: missing thermtrips, will use critical trips as shut down temp
> 	[   12.472300] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when cpu reaches 102500 mC
> 	[   12.481789] tegra_soctherm 700e2000.thermal-sensor: programming throttle for cpu to 102500
> 	[   12.495447] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when cpu reaches 102500 mC
> 	[   12.496514] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when gpu reaches 103000 mC
> 	[   12.510353] tegra_soctherm 700e2000.thermal-sensor: programming throttle for gpu to 103000
> 	[   12.526856] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when gpu reaches 103000 mC
> 	[   12.528774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when pll reaches 103000 mC
> 	[   12.569352] tegra_soctherm 700e2000.thermal-sensor: programming throttle for pll to 103000
> 	[   12.577635] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when pll reaches 103000 mC
> 	[   12.590952] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when mem reaches 103000 mC
> 	[   12.600783] tegra_soctherm 700e2000.thermal-sensor: programming throttle for mem to 103000
> 	[   12.609204] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when mem reaches 103000 mC
> 
> The "programming throttle ..." messages are something I've added locally
> to trace what gets called. So it looks like for "pll" and "mem" thermal
> zones, we now program trip points whereas we previously didn't.
> 
> I'll take a closer look to see if we can replace the calls to
> get_thermal_instance() by something else.
> 
> Thierry

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

