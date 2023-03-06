Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29CF6AC9A0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCFRSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjCFRS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:18:26 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2858A45;
        Mon,  6 Mar 2023 09:18:02 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-173435e0ec4so12109676fac.12;
        Mon, 06 Mar 2023 09:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678123046;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0sctzMQRiraFg62oYuZlLcDDNcLGWUWrlXyOzIV7mo=;
        b=TsYa+QtM+WVh6i9Of2refGVaXt7sMv0H1TyxbBIBmwq4UGHXPbI8E/p154fsOpyyQO
         FbYXkgYgfHZ4AOEITkq/CTTMtcuVMACzMNtexAy+pn82kXuBcb36vl8et8zuyomOMzOA
         nKH0NmXhi3UrET/IFFzsaJODZ5DVQT79WV2WTjlLD+GkGY63m/YGoOO+zk4m/bTjkN7J
         vvsehEG/s+m2RlY+9vjbf1v6N6w7neXnExhoDWea3mRK/WGe5HDxAlne4kvUDRar4wxj
         MJtAsKBRcgKpnEtv8yJ4f0YGODgm8aMf86qSyXmR3xfVUREH2XjRr5/R3JXmUu1MVaQX
         UkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678123046;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0sctzMQRiraFg62oYuZlLcDDNcLGWUWrlXyOzIV7mo=;
        b=cvzA+E1+U932ZjOKfpn0vQbLKf9S0hfGXyjQIDN8nheD8tXPz1kGaaHDBxqSw9c2Ca
         58LcTfBq8nQ/XxlzQwNuVYHSTLPJW4KpRvEGe+2OeIpj7RkzwIniDC83TXmArwLFXdMT
         oBgGg8oJvC8fJay6tXP+5Vgq9WNeptIeC0A0sRxSHCnMrnw3vUV/xosSBOoUwQ2gtXF9
         HL/xHwpPnNBd/Y0ujlNUHnu9HjQ+fY+FVSHBHEwIxaN91ILLNTlS4Js+SlKOdlGRlQGv
         vadeI3B32osMkp0MZe5KSYDCYziFwbct6L0Y6jwwpI1ZrSMPQFUwQPFxSu6YCf5ujBtv
         T+zA==
X-Gm-Message-State: AO0yUKXT63yOIfJBF8wyzfqn0Kuk++nehmoi2C59sp7j9pmt1WIcUYB4
        uxxU+HpJzj4RpDty0fR6EBE=
X-Google-Smtp-Source: AK7set/tMMdJ8dCV5bEacRjA+f4zjiFks1hoVEIZBqVftkGKw5SwwAXHlTXwewnGW99cLpO8lhmjJw==
X-Received: by 2002:a05:6870:a108:b0:176:348d:fb0 with SMTP id m8-20020a056870a10800b00176348d0fb0mr7771666oae.42.1678123046228;
        Mon, 06 Mar 2023 09:17:26 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b26-20020a9d479a000000b0068bcb44e7f5sm4315137otf.68.2023.03.06.09.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 09:17:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <312e57b8-d47f-1269-a463-d2a4ef19b212@roeck-us.net>
Date:   Mon, 6 Mar 2023 09:17:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
References: <891023d7-9510-445e-9053-ad5c0398d350@roeck-us.net>
 <20230306090919.2206871-1-u.kleine-koenig@pengutronix.de>
 <20230306090919.2206871-2-u.kleine-koenig@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] watchdog: s3c2410_wdt: Fold
 s3c2410_get_wdt_drv_data() into only caller
In-Reply-To: <20230306090919.2206871-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 01:09, Uwe Kleine-König wrote:
> s3c2410_get_wdt_drv_data() is only called by s3c2410wdt_probe(), so the
> implementation of the former can move to the latter.
> 
> scripts/bloat-o-meter reports for this change (on an ARCH=arm
> allmodconfig build):
> 
> 	add/remove: 1/1 grow/shrink: 0/2 up/down: 4/-129 (-125)
> 

The reason for separating functions in this case wasn't that the separate function
would be called several times. It was to improve code readability. If anything,
I would argue that it might sense to split the already lengthy probe function
further instead of combining it.

Maybe I am old fashioned. Maybe the old "split your code into multiple functions
if the function size is larger than X lines" no longer applies, and it is now
"never split functions unless the separated function is called more than once".
Still, I am quite concerned that accepting this patch would result in a flurry
of similar patches which would all do nothing but hurt readability, using the
same set of arguments. I really don't like where this is going. I am going to
leave it up to Wim to decide if and how to proceed.

Guenter

