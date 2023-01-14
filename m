Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BE966ACA7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjANQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjANQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:36:48 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102CF5262;
        Sat, 14 Jan 2023 08:36:47 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id p96so4765861qvp.13;
        Sat, 14 Jan 2023 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShNCMdSbGR4wZSWeN9wBqnNtg3IMyZVtmlItRwcjcV0=;
        b=TEQ817oxSVVdQlcJtfFblk1BhQ/DA5TVM9nlLLP2YryZJzNyTL2hsrHh/HSnLAmNEy
         hV3gBpJCNUncm+AKtKjywfg5LVwtsZfzl6r39Y5cbTkedhjRVOEc+2bXFC5STSgVbj/p
         4KQdBVC13SiTLBXAiC3nqfNrwPUglqIyhhGFAfe/D+tx0mNtRo3OpX9yEQ72Gi65T/Tg
         BUqtTtJqtnBc7rajJZqUYVzOqBKgriz9tHOQU67gMHYPyp3SJt3pDMRdvSzShOCt+N//
         HLJv1ZpUMbYPwBN2PKou64t8w88mRW5zVKhc7uvuh+cs9PD1uiGsfIVwbluqJji91Q0z
         birw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShNCMdSbGR4wZSWeN9wBqnNtg3IMyZVtmlItRwcjcV0=;
        b=7hJHRUrI6NgY4wfJkXhOZjusX9SRSGHLX2sNg1waf0IFkZDWpdJ6PaSdrzMx2LKtzE
         /y3er2YLDnVt3ZUGlRb62xba4skVINOAbFOBVpIVZqr/mWYj7gbFWXLLK50QTFizGkZl
         tOClPWt7WruUw0mHqzvmrRxYXUsI9jKpWrsN1Nj8BYfOmM07YDE5z4QimTOKaNTqcz9+
         p82RU7X/AdsYDhUfY2PFNa1zR2JzK1m7yTcqACc4tl1ERxT/B3dU0yHWZdDVmV4ZfBZy
         VxPOytN911lrgZ6f1XGhmoGUdzN3AkWCm4Tm69vP3ICyDPEv0UEGTlEsJrtDZu1OJyHt
         FE0Q==
X-Gm-Message-State: AFqh2ko99CM0EKKKq/CsVKtPCuwkxsnrduOWKlSsmNZfI5mb5+dN5dB+
        NvOKPE10D6B1YI0lzi9qyjwcYaDhYFI=
X-Google-Smtp-Source: AMrXdXv3d/ZnYgeB5D7h9nsy5dHaeSjRSRrCBR2/uo5JVvc7SeAnJ3MfxmTAp12tl4lgbNg0lFAItw==
X-Received: by 2002:a0c:ab03:0:b0:531:c116:33c4 with SMTP id h3-20020a0cab03000000b00531c11633c4mr60361410qvb.0.1673714206103;
        Sat, 14 Jan 2023 08:36:46 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id bn34-20020a05620a2ae200b006cfc7f9eea0sm14633046qkb.122.2023.01.14.08.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 08:36:45 -0800 (PST)
Message-ID: <8125207f-db10-98f2-2e15-66c45642e6b7@gmail.com>
Date:   Sat, 14 Jan 2023 08:36:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/4] pinctrl: bcm2835: Remove of_node_put() in
 bcm2835_of_gpio_ranges_fallback()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
 <20230113215352.44272-3-andriy.shevchenko@linux.intel.com>
 <55a87b32-803a-ceb3-4c31-ac818fe69596@i2se.com>
 <Y8KNi0HfqN4qksgI@smile.fi.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Y8KNi0HfqN4qksgI@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/2023 3:10 AM, Andy Shevchenko wrote:
> On Sat, Jan 14, 2023 at 12:03:07PM +0100, Stefan Wahren wrote:
>> Am 13.01.23 um 22:53 schrieb Andy Shevchenko:
>>> Remove wrong of_node_put() in bcm2835_of_gpio_ranges_fallback(),
>>> there is no counterpart of_node_get() for it.
>>>
>>> Fixes: d2b67744fd99 ("pinctrl: bcm2835: implement hook for missing gpio-ranges")
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> thanks for fixing. It seems that i got confused by function name and usage
>> in other driver.
> 
> You're welcome! Would be nice if you or somebody else have a chance to test
> the series.

Yes I should be able to do that in the next few days.
-- 
Florian
