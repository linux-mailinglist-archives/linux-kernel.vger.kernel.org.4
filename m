Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0B6A815C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCBLlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCBLlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:41:16 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F3349892
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:40:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cw28so17227169edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677757235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8kgK3rGpvo+xdIFwuswsin4gApQRsnJwFdM+M3smNCU=;
        b=TnjAMKIfsEuggjoINqOgonvrcbETzjD8x1+K5jU0ps8BhAc1/alvOMpAiwPLPKDYvA
         u9VxTAUQoBXXB1tB/55OlEaFIokjG9bsEo5LYs7XbPvUQWECBp0HoPg+YmH9+ZBXeZ7m
         Yssqo3ZQV9hlNMJT5SvBAUBxuGBg87nbyhsd106wrifTvfNpeGK8urRus80z5gXXN3sa
         ckW26cuhPJjHkafbEgXrFhTHEc2K65OJwrKNV7sMWozGN1D5sA+JOr5k777csAemTHnv
         qmPpuUOh/tNJkZjzNghEKj3KmnXVx76S3H1JwQNldKkN0FE+YRiJg4BbAfbCAun1nj0+
         WMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677757235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kgK3rGpvo+xdIFwuswsin4gApQRsnJwFdM+M3smNCU=;
        b=eiajBdLgcn0/IRrIJ5N2/CdKORjGZL0xMVLgOJ5eCHppBa+0XjtsmdgxBKclO+jhWj
         qJjnv2tGATebeyn7J+6gKnLeUm3zK4lTskLB0WSFSuccweAW5ZRGrjpsZ9WCXPpz3aVH
         cSHGpML/perKdqis5C4PaDZ1vWlhcmNNdX+kIT72dgsaxXkoXef/PdLvSKd57CNKSuCG
         Ne9mHEnSH73JidocIP7MwnooldjgLJOMnENJbNqvdTBfB4W7EzUbuwmOIYQVB9pxJrlZ
         gI4C8C3sxudGO7nDAvvPewXBhLgHnoWvoH8e/R0K/3C3VQR4RyJI1y1xxS9j/TFBztV/
         WLIA==
X-Gm-Message-State: AO0yUKVOqaKyENUI9ywVQ6X9WStzgX+KnFcSstH6J1B9BK6pojxAK8WF
        qsVxnU5xb7M6vBOrrRhIrSRKNg==
X-Google-Smtp-Source: AK7set+AokLI+Z0baoOmhcQLdIPuG+PuvKtSFZ2aW2WdgG6u9UgL73M7k/KhveB8CV4Yg97vjJalcQ==
X-Received: by 2002:a17:907:6da2:b0:886:fcbf:a1e5 with SMTP id sb34-20020a1709076da200b00886fcbfa1e5mr15668923ejc.59.1677757235362;
        Thu, 02 Mar 2023 03:40:35 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m18-20020a1709061ed200b008d427df3245sm7010607ejj.58.2023.03.02.03.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 03:40:34 -0800 (PST)
Message-ID: <5cc00c00-7dd3-4b7f-71e6-397f76acaed0@linaro.org>
Date:   Thu, 2 Mar 2023 12:40:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] gpio: loongson1: Update copyright
Content-Language: en-US
To:     Kelvin Cheung <keguang.zhang@gmail.com>, andy.shevchenko@gmail.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230222111213.2241633-1-keguang.zhang@gmail.com>
 <20230222111213.2241633-2-keguang.zhang@gmail.com>
 <Y/YH20aKp+u+QEwA@surfacebook>
 <CAJhJPsVqPAC_GP0JE98nrpmvDTwXdt4m0z3SZQPX3GFCijT09w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJhJPsVqPAC_GP0JE98nrpmvDTwXdt4m0z3SZQPX3GFCijT09w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 12:09, Kelvin Cheung wrote:
> On Wed, Feb 22, 2023 at 8:18 PM <andy.shevchenko@gmail.com> wrote:
>>
>> Wed, Feb 22, 2023 at 07:12:10PM +0800, Keguang Zhang kirjoitti:
>>> This patch updates copyright and author information.
>>
>> ...
>>
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>
>> Have you talked to your lawers? This is an inequivalent to what was written
>> below.
>>
> Yes.

Yes to what? You now change the license... and commit msg does not
explain it and does not justifies it. What is even weirder that your
lawyers agreed on GPLv3! With GPLv3 you need to open a lot from your
products... Not mentioning that they agreed on future GPLv4 and GPLv5,
that's even weirder because GPLv4 might be saying you need to buy me
flowers...

Best regards,
Krzysztof

