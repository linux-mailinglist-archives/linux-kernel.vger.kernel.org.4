Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47F46B302B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCIWEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCIWE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:04:29 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5EEE63CD;
        Thu,  9 Mar 2023 14:04:27 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id r16so3744538qtx.9;
        Thu, 09 Mar 2023 14:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678399466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dm82Um1MW3rzQWYywkLIx1xdA+mI1QGfFbckRkmr28o=;
        b=GsDEw+81LxDbAgFAHQKNr6El8lmUE0Q4axdTxhcZWCWFt93vFt1PWi7adrrrjuWq/4
         XsHRdQbHkaSAGiiay1oqMU5l0iN+stw7CrFYx1UVqXMV57RoUHr3w4OmYaYaR/j8bk+e
         c09mR+JkgKbdwQnuMfrD1zxZ37RMxcN5rWrFS4DN94gWzmqgtpPxeq10QS99J2+v8Y3n
         aL7hXkcznTS2tvK7JZDHakvzd9f2fRqBFvgmMSclQWBAqvk19m2xiBmHC5Wq3246c/7n
         TyDq4sPSzfpvwOThetHdCt6PYEcTeg9KXqITY9zY7bDwcJrESRicNTcfp+onC1S9o75u
         uL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678399466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm82Um1MW3rzQWYywkLIx1xdA+mI1QGfFbckRkmr28o=;
        b=AnUnVklK3J+L8PVQRq6p6yWCFroHIG2bq1Mf0vHP1eXCr4Spgo0oV7GCCucmOAr4Mv
         ZLAYKcZHCc7vxlWpUgY0ZyKahbO/+oDJ6wRLstxEz1uEM+ii0Kgm6/WvJ9fyM+R3M0l0
         hRSn5Mu299tleFM5Mr78ncAbSpufQZOSn4Mkt+e3+H1Q3QUi3aorLFX0Dc8vKlU7sB1J
         nJNbnA61W2YTgtyssFKtpBeRJejECals/z4bUOSxK1UppOzVo/VORBO0eeFRSofuiKlR
         BpHgjWaqKcL5uh+mdEu9TDWnBgrO9kRevshox8VpvwokPvm+sFNNGIwB8vGCDLORQO0x
         WAvg==
X-Gm-Message-State: AO0yUKV0iZpZpvMWcpw5U5iRHPsqc26JNbjubpWA/mUTxjOnLVI/NjDR
        djHrJez1DZtv9bmWAHbap50=
X-Google-Smtp-Source: AK7set9n6SkaDNFA5+16m9a8UMRc8Fj/4I/jlqAQPRfiyOBBGLI8OlB9Y+lI/D1+wjVDELuDyL+e1Q==
X-Received: by 2002:ac8:5d8a:0:b0:3bf:a1f0:4bf with SMTP id d10-20020ac85d8a000000b003bfa1f004bfmr40547862qtx.56.1678399466338;
        Thu, 09 Mar 2023 14:04:26 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w7-20020a05620a444700b0073bb00eb0besm84131qkp.22.2023.03.09.14.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 14:04:25 -0800 (PST)
Message-ID: <b313d7af-2e1a-07a9-8680-4588fcf6a2d2@gmail.com>
Date:   Thu, 9 Mar 2023 14:04:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mips: ar71: include linux/gpio/driver.h
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308145303.826942-1-arnd@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230308145303.826942-1-arnd@kernel.org>
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

On 3/8/23 06:52, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The change to remove the implicit gpio/driver.h include was done
> after fixing all the other users, but the ar7 file still needs
> the same change.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 21d9526d13b5 ("gpiolib: Make the legacy <linux/gpio.h> consumer-only")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

s/ar71/ar7/ in the subject, with that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

