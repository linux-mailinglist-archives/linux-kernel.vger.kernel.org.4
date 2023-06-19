Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3005735B26
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFSPbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSPbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:31:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E26CC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:31:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f849605df4so4639120e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687188704; x=1689780704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLwy/sKJSKc1YxfHlxR/AtbFfLqkS5JY4ydXbpviBhY=;
        b=Go4+xbz9lJpJ1MBdABEVLtlTj+ViH4dHySD8+IHpf4DVFbkykWMoyAyxGZ1KIUSDq3
         VRNRLJh8RwLuT3hLXPv/lz9/kW/98Ce4tTW1z8MJUOSZSq8cL29rpaAVXNZsx/84xQ4Q
         aTe9BIYvgoocZQsn7X7W0vf6XBfr1y0togku6dnb0lMT4GavsXkTtLr0szqaLXlFRcgk
         jP3AsmO/zc5DcLdk33i9PFM/RG4jJErPE1cvs9mJmTSxwglzhZnUaqhnv8PmQikndAI+
         nSsUYBcKaIrzSRW7RhvYbWKhcAFhSEoWwTUawbUxUKh1ioZrk0jBNM5jtIwooZE49x0o
         2+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687188704; x=1689780704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLwy/sKJSKc1YxfHlxR/AtbFfLqkS5JY4ydXbpviBhY=;
        b=PqfF+Wvpk4W+ZE49N0dR35T0N30KeW7PJhxZwQaRbluWkcYxjPXtFCM85zjsCb2UFh
         OrcszTmnpzdW1nZJUyiHDMxUWN/QIW/hZi7vkSfrl3FDbGJvepC+VDsj98xWy5/XZ1ui
         9XmlrDl9WoFfOVwoFWlU3Bgtl5qqQC8h+2WH5EBI6a/hjiEf3AtGP8DtQItKP9VHo2du
         tdp7ESToUx8Kalu/GBtRMcwfYq6Fv9sM4bso8vKP/MKUDkHQFCeKjFZrZw2jHFA5M8vu
         By/WhK2ukHxZQtv8oJF806sDbSX4bvGzng1/xKOIGy97+iB7x6GhQK8K2ax1XB+aetfP
         sqyw==
X-Gm-Message-State: AC+VfDzGwfWowQs8YrqAiPhJ8VPEyEiimsD5LF9aJ3E8cvEzfvAIfOHS
        mKWop8pAMGwoYABn0DwKaIFdjQ==
X-Google-Smtp-Source: ACHHUZ6fe6PBWGKxbMz8H7pHBuDCnvwTpSeHBIIcoH09H94tkJaFXw/kEWMmujrYl2lV1csDO/mzeA==
X-Received: by 2002:a19:6405:0:b0:4f6:4ba0:7f4b with SMTP id y5-20020a196405000000b004f64ba07f4bmr5090462lfb.68.1687188704231;
        Mon, 19 Jun 2023 08:31:44 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id 20-20020a05600c025400b003f7f36896f9sm11080596wmj.42.2023.06.19.08.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 08:31:43 -0700 (PDT)
Message-ID: <3debf18c-47e7-76dc-fca9-0d81fc53ed06@linaro.org>
Date:   Mon, 19 Jun 2023 17:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] clocksource/drivers/imx-gpt: Use only a single name for
 functions
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20230328091514.874724-1-u.kleine-koenig@pengutronix.de>
 <20230530153115.fpjgg6ubqjrbn73r@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230530153115.fpjgg6ubqjrbn73r@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 17:31, Uwe Kleine-König wrote:
> Helo Daniel,
> 
> On Tue, Mar 28, 2023 at 11:15:14AM +0200, Uwe Kleine-König wrote:
>> When looking at the data structs defining the different behaviours of
>> the GPT blocks in different SoCs it's not helpful that the same
>> functions are used with different names.
>>
>> So drop the cpp defines and use the original names.
>>
>> This commit was generated using:
>>
>> 	perl -i -e 'my %m; while (<>) { if (/^#define (imx[a-zA-Z0-6_]*)\s(imx[a-zA-Z0-6_]*)/) {$m{$1} = $2; } else { foreach my $f (keys %m) {s/$f/$m{$f}/; } print; } }' drivers/clocksource/timer-imx-gpt.c
>>
>> This patch has no effect on the generated code.
>>
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> This patch was generated against v6.3-rc1. On the upside it still
> applies fine to v6.4-rc1 and even current next/master. On the downside I
> didn't get any feedback on it. Is this patch still on your radar?

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

