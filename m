Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1935F14F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiI3VfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiI3VfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:35:09 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653AF47B90
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:35:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id ay9so3484027qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zTs6fvHbkyLzG2YUopzzW4E7mGdZIU1mET/bYxmp2kQ=;
        b=klemS+egUTYXRtKd1VvIqVdeSIPx0TtpsxzY9VtGzf1+sNVxK9g3UNViSxvvf1IlcY
         S3jrJtJ3NV7TJvEgh/mwBwZgNFVP66SBMHsZ4VA8KRZB1FOWj4wgmTwcijdHI8Ds8ovS
         F75885wMo6zqEnnnzyflOQEo5mmXOtbNyvu2DssatZBsQJyGjC3tjPstsLQx/9r0chZh
         vZxgEaI06QwQiPREVkD53PLfsuekxZqsmaQXF6N6mPmZEtvjuAfdJCiwwcW7wYBKs00l
         RTqe4TJ6bO4eSnTjNjULlsT6yiYPFnsGiGIwyPG1xx91e8eSgtv8t2U8UAnt9h/hT4rv
         AHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zTs6fvHbkyLzG2YUopzzW4E7mGdZIU1mET/bYxmp2kQ=;
        b=t0C/ho+MSolZUnQRsVd4TGI0gccMn1+K45Diff4jrNRXHaqJxlCXlsreMbsMZ8xf7D
         fqHYwwYkKtoxbYuhQ1h2OJVgcXfG8H41nopaAtGUxEyomMs/p0LJCHHrokip2Z2AvmeH
         hLTrHLA15NPh9/hxmF5zT7H8FT611pXblQbQogXt7CP1ux10TisDcpdhXbFOevtL5DKk
         MV/q4Pv++kw8byYor4cV9RG0qKggh/+qVB9sf3Yn77Dzr5eRfv+XCV8j9FvGi9hGJQqn
         hTZcCYvcD+VZY05LIaQ/J98kX/DwX6MsWyoy1v+wTvJa7glehIAZj8n9RG6tgQzS5r6m
         q4Bg==
X-Gm-Message-State: ACrzQf0LI7ECrlhGtvLmxMmGa88Yb6y9FetsJm5EHW4q+rE76aKKrZXA
        crEQP+mSmpTcKTymsN4XsoI=
X-Google-Smtp-Source: AMsMyM6KczG9OopdDrJnlYq3saTTts1izUmcmTm9VwQgyszvDx7xG9c///0FGY9T4L7sylDptBRjnA==
X-Received: by 2002:ac8:5c8f:0:b0:35c:c6b5:9179 with SMTP id r15-20020ac85c8f000000b0035cc6b59179mr8801713qta.10.1664573701410;
        Fri, 30 Sep 2022 14:35:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm3081614qty.56.2022.09.30.14.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 14:35:00 -0700 (PDT)
Message-ID: <b6abc730-21a2-91ee-5424-f473b29abd90@gmail.com>
Date:   Fri, 30 Sep 2022 14:34:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        William Zhang <william.zhang@broadcom.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com
References: <20220928174739.802806-1-f.fainelli@gmail.com>
 <202209281100.5311EE081B@keescook>
 <729030b4-c341-966f-05ed-3754122cb4f7@gmail.com>
 <986bea84-7cc3-9c40-733c-0c766f7a9ebc@broadcom.com>
 <202209290110.024DC2FE@keescook>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <202209290110.024DC2FE@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 01:10, Kees Cook wrote:
> On Wed, Sep 28, 2022 at 05:33:14PM -0700, William Zhang wrote:
>>
>>
>> On 09/28/2022 04:06 PM, Florian Fainelli wrote:
>>> On 9/28/22 11:01, Kees Cook wrote:
>>>> On Wed, Sep 28, 2022 at 10:47:39AM -0700, Florian Fainelli wrote:
>>>>> From: Seung-Woo Kim <sw0312.kim@samsung.com>
>>>>>
>>>>> To enable UBSAN on ARM, this patch enables ARCH_HAS_UBSAN_SANITIZE_ALL
>>>>> from arm confiuration. Basic kernel bootup test is passed on arm with
>>>>> CONFIG_UBSAN_SANITIZE_ALL enabled.
>>>>>
>>>>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>>>>> [florian: rebased against v6.0-rc7]
>>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>
>>>> Ah-ha, thanks for testing this. What devices did you check this on? I
>>>> know boot-up on arm32 can be very device-specific.
>>>
>>> This was tested on an ARCH_BRCMSTB system which is using an ARMv8 CPU
>>> booted in AArch32 mode, so virtually equivalent to armv7l. A raspberry
>>> Pi 4B is also happily booting with it.
>>>
>>>>
>>>> Which UBSAN configs did you try?
>>>
>>> All CONFIG_UBSAN_* work with the exception of CONFIG_UBSAN_ALIGNMENT on
>>> my ARCH_BRCMSTB system, however it works fine on the Raspberry Pi 4B.
>>> Florian
>>
>> I also tested on a BCM63138 board (ARM A9) under ARCH_BCMBCA using the
>> multi_v7_defconfig with all the UBSAN configs enabled except UBSAN_ALIGNMENT
>> and board boots up fine. Turning on UBSAN_ALIGNMENT results in flood of
>> false positive misaligned-access warnings. This is fine as ARM supports
>> unaligned access.
>>
>> It did catch an out-of-band bug in mach-sunxi smp code.  I will submit a
>> separate patch to fix that bug.
> 
> Yay! :) Move coverage is great. :)
> 
>>
>> Tested-by: William Zhang <william.zhang@broadcom.com>

Submitted to the patch tracker:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9253/1
-- 
Florian
