Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8F71690C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjE3QSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjE3QSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:18:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02555C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:18:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6cbdf16d2so32165935e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685463487; x=1688055487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ii3O+FiaiXPgUUO3kXXrARz1zx/omFCilxvfJov9FLU=;
        b=GId8MLiYDaNO741mhSW+w3x+w3XizQLrM6VaPIM/DsquBPArwmC32vWkvQZXnBoqhD
         G0p5WR2+S8MZfUO86OAZTjTrkQOhUYQyT5LFh/ZRWreAOUMTvEFUZ+i3/phOXbPbJeGD
         jwvJ3tsQQzYS7mtl2F38Tz4nNKZAogBUnW27lrEaXkYl4F1iFY3C0OZQjSdmUGY5I3Dr
         iA8UIehnHfr0ZfJuf9CUMf4kzlV8FBMCtgcluaB1BfiyQ6E+WLmDh9uhAbVLJCcU/Uxn
         jiT39PFuBHjXFqwM/GsOuxFf7DUuzPZ62IURlCGDFlXTHXXvI22e/NEewYe5Zm9S86ry
         mvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463487; x=1688055487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii3O+FiaiXPgUUO3kXXrARz1zx/omFCilxvfJov9FLU=;
        b=GCr2Xxb5fRKcDxl6dQbjZAD3D2V9gwR0c8/PYGfeescbFeDSvjuUjaTEkD5s4NhwD6
         +INSDfO5G21Nk+ruIsZrKo3C2rfGCnqZee+L+rpRWXy5I8b3J/C3WzjaZkYp0vC8gs7S
         MXcbemq5i2+Q+vMMRFjjnso3zKp/ezkDNf7YiTHuRv++HHN49bAjUjU41x8nZ4fv+j1l
         6dJWkgn0d+FJWJgaOKnhIhAaD/Ow+tb2fH8eZQ8uQ4hB7J+f14wb/bOmAmAU5+nAHECD
         9xwfWRpEkrZyjNv80eabP+E9msFigodo5o8qBJ/z8Pz4+dGpFcrk8n4GLT17M4GRpO1X
         F8+Q==
X-Gm-Message-State: AC+VfDwoJdbHrEV4aj4cQfIsgRyS38k/XmP6SF7fKRqEYjojqy3NOvff
        qyQkE+QnJycvdJKqIupN0VK6Hw==
X-Google-Smtp-Source: ACHHUZ6LWzkS3alCl4WtWgrbiIF662cVgxuzbcJ/rBa+VhIO5XJSXsAG/2ou4kdPlz6k7e9e1ehY2w==
X-Received: by 2002:adf:cd02:0:b0:30a:a333:790e with SMTP id w2-20020adfcd02000000b0030aa333790emr2188131wrm.69.1685463487236;
        Tue, 30 May 2023 09:18:07 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:dd1c:e75b:56ba:6bf? ([2a05:6e02:1041:c10:dd1c:e75b:56ba:6bf])
        by smtp.googlemail.com with ESMTPSA id x15-20020adfdd8f000000b0030ae3a6be4asm3762807wrl.72.2023.05.30.09.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 09:18:06 -0700 (PDT)
Message-ID: <5d0c2a64-9260-02b1-b2af-0cea4983d5b7@linaro.org>
Date:   Tue, 30 May 2023 18:18:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Well, it is back on the radar now :)

Without feedback from the driver maintainer I'll pick the patch in a few 
days


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

