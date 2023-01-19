Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD30674242
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjASTIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjASTHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:07:11 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183DA966FD;
        Thu, 19 Jan 2023 11:06:19 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id a9-20020a17090a740900b0022a0e51fb17so135813pjg.3;
        Thu, 19 Jan 2023 11:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xpxp7XO5sHsJ3lfzTlYxihhbIWhrIJucAXxN9hxl+dg=;
        b=FREbxc9Qy3HiT086pEfzb3u7yMxdQQY6pmDTfhdTpr3nAcl+UV5k/sLGoOyF+m+zcd
         la7GHQ9xZzBpLAPDtbarVXD10pdoeeaHqaEAEfksd2h2nhxaWRDxZW5aO3apUt3tRlsH
         jsYYJkRjqpFI2FjAW4C8VUlDqHIUYmHRnZmGqMTk9E+a2N8IbHf943QI7Y/mMkKh7kia
         qPauKgmYrXeLl5yXewYjwMcBMpS3HrtKu2qLs2YM4YUs2uAcdRdgkHc/lWgt7pntuPSj
         x7lPqyiSXpasmSrhz8WjRNh6hmTYKrYBhX0PCZD7W5+eUWB/Xw4g5WMpMrsPGuOwVotr
         cpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpxp7XO5sHsJ3lfzTlYxihhbIWhrIJucAXxN9hxl+dg=;
        b=EIqPccG/aQ+GFfd+D4ebNBSQv7stBBx7+W5MTouHuLLO6kQYehbosjsE7BaAgoWYSw
         4xHEQ1X7YVKFy2HEejJdjKRpzJNubgoQQjL+KqmKxMBKpeW7hjgbyxN1zrQbTZLX8NmS
         3lAkbZCYQUiT/pcuXozyQScm5XeA12t3eC9Q63HA+i+DBpkeIXEkXs+nwLGt1Pmc9ZEv
         QJtZeLLOaBEfscSwHnU9w3NL3W4EbksPbRFfZNHUwEf5x7rStGma+Rh+XILXsrEt+fbd
         iXICm+DiFeLBps1778mMeVymWmARghr66aSYwvbz2KmDDD2Ec93ImAkht15C0cqDj0Ts
         iFug==
X-Gm-Message-State: AFqh2krxA6MIjfKDOS6UzADyaI4fk711ybVNf2YBkcOtNl7FxfnQB+a/
        x5ig9nt9DEgpt2kUTzhV/BA=
X-Google-Smtp-Source: AMrXdXvnQ3a0kXh2UwRDjq1SPGKPM5tMn2rlGLjHsP24ziyycXfEdP2gXJT7cg+xD4J9MmhtVCzCmA==
X-Received: by 2002:a17:902:cad3:b0:194:7abf:742b with SMTP id y19-20020a170902cad300b001947abf742bmr10801145pld.47.1674155176064;
        Thu, 19 Jan 2023 11:06:16 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u12-20020a17090341cc00b001888cadf8f6sm6794374ple.49.2023.01.19.11.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 11:06:15 -0800 (PST)
Message-ID: <4d26bc29-5c85-1f30-388b-539bc6a3f09a@gmail.com>
Date:   Thu, 19 Jan 2023 11:06:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/4] gpiolib: get rid of exessive
 ->of_gpio_ranges_fallback()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
References: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 13:53, Andy Shevchenko wrote:
> The ->of_gpio_ranges_fallback() repeats the idea that lies behind
> ->add_pin_ranges(), while the latter covers more cases that the former
> hook. Drop the former one for good.
> 
> Changelog v3:
> - moved check of the property presense to GPIO library
> - split out the refcount fix in a separate patch
> - added cover letter

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian

