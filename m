Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72B06AC4BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCFPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjCFPXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:23:33 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E6125298;
        Mon,  6 Mar 2023 07:23:32 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id m25-20020a05683026d900b006941a2838caso5503270otu.7;
        Mon, 06 Mar 2023 07:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678116212;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIo7law34HfY6O9bjn8QcvJtNO/No3tVP5fg4B1s6Ic=;
        b=YQmhAjarE1n39m9RLGR1qCPGNlFTubp3RDMD2WXFzrFxdm5OnAbVjBAjB8G4BDvvCj
         GAk4XPTs/FGFuXAlELj+6VPk3m4846f0SkiKHksvnZx/f7XhrftT6lO1ZFKQnh4aWmMV
         wpfezGIKC/kaQqMEYzXaeJQci65RtQ62P+SzruZVy430beB5Egn9uSKI2Qb865ztZ8B1
         eGJnCB4Uv8StXiFydLXi/ystl3Use26a8c7y5GSu1KfWP7RMwoiTskGhCn7cRVlYsBTC
         v5Hlf6dBej/Sju59miWC5Go1uL9nHarR75G4inNGatK1kqWVCVACdMNnXUjIOvwTkw3R
         qLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116212;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIo7law34HfY6O9bjn8QcvJtNO/No3tVP5fg4B1s6Ic=;
        b=ItKWs/KP40JuOl9TAFot5x1Mx+0PBc2QbDlOLENCA4ATwBUSaYtzu2cqkclnwoSQq8
         D+Xnq0G1KBz9Zr+HU6SDOBrO1xh8Wik7U+3KFFzR2wQgrXwdUWq1W/2L7lZdGCqz+0iY
         n0QyRs/gWtJBsoJDqnSRC3p4yMjpKL4dpLJXL3pDwzns4jeIsAJBM1wU1IWUFjLngdus
         MOwoqJpAdHZn4jDcZ608aANrttxQaHaJWb0tZsEoNpbJScMBNyDOIaf0s6oRTE3XuWW5
         Syp2/Rb6d1ye2MqF2Zk1G56F23UNU15Q6BiLI0MZ2U2Zi9qOmyMxQOOO4kaiAwRn8fs4
         t0wA==
X-Gm-Message-State: AO0yUKUlRtxcTUwaOfS9cANvj7MdekI5LseKmheCErmk7wMlZ6Xc40ci
        gSzssvz/+gqDW+KeNLquzE4=
X-Google-Smtp-Source: AK7set9HWeC/FhWEiCysPFIXgx4Hg9gRTKDSKv1cX9GnP3Wsf5j3hr6K9084pka/TwFpRJV9fcn8VQ==
X-Received: by 2002:a9d:6294:0:b0:68d:5a31:af3b with SMTP id x20-20020a9d6294000000b0068d5a31af3bmr8566721otk.14.1678116211788;
        Mon, 06 Mar 2023 07:23:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w4-20020a4ad024000000b0051fdb2cba97sm3972560oor.7.2023.03.06.07.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 07:23:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2bbabc8c-415e-1fc9-3551-00fedc8bc78a@roeck-us.net>
Date:   Mon, 6 Mar 2023 07:23:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230304165653.2179835-1-linux@roeck-us.net>
 <20230304165653.2179835-2-linux@roeck-us.net>
 <20230306091502.3zlodw6vkqqwgozj@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] watchdog: s3c2410_wdt: Use devm_add_action_or_reset()
 to disable watchdog
In-Reply-To: <20230306091502.3zlodw6vkqqwgozj@pengutronix.de>
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

On 3/6/23 01:15, Uwe Kleine-König wrote:
> On Sat, Mar 04, 2023 at 08:56:53AM -0800, Guenter Roeck wrote:
>> Use devm_add_action_or_reset() to disable the watchdog when the driver
>> is removed to simplify the code. With this in place, we can use
>> devm_watchdog_register_device() to register the watchdog, and the removal
>> function is no longer necessary.
> 
> While the cleanup in this driver is good (
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ) I wonder if disabling the watchdog at .remove() is right.
> 
> At least there is an inconsistency among watchdog drivers if the
> hardware is supposed to stop or not.
> 

Yes, it is, and it is one of those endless-argument things. Some driver
authors insist that the watchdog be stopped, some insist that it isn't.
That is why we have watchdog_stop_on_unregister().

Note I didn't use that here because the watchdog isn't stopped on unregister
but just disabled. That is slightly different, and I didn't want to change
functionality.

Guenter

