Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310A173D467
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjFYVY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 17:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFYVY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:24:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BFB184
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 14:24:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f9189228bcso23611895e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687728263; x=1690320263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJ2LafRfz7os09FITqhIzXchpbb/yMPyJ2Us3fSNtf0=;
        b=iTWoODUdaYt63IT2LCFFmF27v13vBU9cMCV96V34jkX9XShSfvrMiace/hecHAvK+0
         4vn4p2/zz9GSXEnpBM20uJ/iZlwZ+9WVjEKijGCZJ8AvTE3qb5MSmfjbZgIaw6YJfLe9
         WDUh34UW//HY8Dc/ItqAQsBhZwNr/XIhdjADfnlp3WlhxWJdOClYv2zcDffRZheFOUWB
         tYpErS6IaBm6ybKKh+47GuC1BShx0GrlNSnOsONy1IQsLm0YoEayGjCe60gnHaNIwXpH
         EKwUt7pNCwC/7GGfUEuYnQO2kJyx2Q9x/jv1O3BK/shZ6VwAZHMPhdVVMUlsTIghuGP9
         nDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687728263; x=1690320263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ2LafRfz7os09FITqhIzXchpbb/yMPyJ2Us3fSNtf0=;
        b=L+4EWLQEB7jieTFXCZsWlDTiC6VNAhKAhzd1sNMyE0V+DZuovNSuytgLamdrIs8lpr
         mK6qE536njXDMe4JjRMwyq3AOWZgwVgmQungqRXR+wrrNTIUpFcxUkyR6VOxC6aABH0+
         vKNwPN5ypfxK8Qujk5sBcnpM8Xd+9FrMqLnXIeN8jPwQ2DZUWw4XurRSw+N3S5iyJjyb
         qhX3qz92MamETcEySVe2VudDxZxLFrTt9hDkEL9ZyaFw4dueLPmI5twHTM6Yos21YJ3Z
         7ZEJ5pFE+mP6cwOP/NYBKYW4PdP+07QxsYedRvLgbYoxmJjcfhZGBbuOpC1jUjF5xCgo
         /Rjg==
X-Gm-Message-State: AC+VfDyja/JT1cdJBHa+SvZdcBQZRIyU7EjDbzZrKHbaD22wYf9QQpEY
        pF9ssyvbYkrABT/8Zkupy8Gd8g==
X-Google-Smtp-Source: ACHHUZ7owkSsDH94uGEOz/gQMPWu+sjhTMek700bGa8JgoZcFLJS995GaovHAQT/FzjooRzNe5f+tQ==
X-Received: by 2002:a1c:e914:0:b0:3f8:facf:7626 with SMTP id q20-20020a1ce914000000b003f8facf7626mr18367949wmc.20.1687728263150;
        Sun, 25 Jun 2023 14:24:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c228400b003f7e4d143cfsm5665000wmf.15.2023.06.25.14.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 14:24:22 -0700 (PDT)
Message-ID: <b751e028-598e-14fd-1f2b-34d1b9eed599@linaro.org>
Date:   Sun, 25 Jun 2023 23:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [patch 04/17] ia64/cpu: Switch to arch_cpu_finalize_init()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.137045745@linutronix.de>
Content-Language: en-US
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613224545.137045745@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/6/23 01:39, Thomas Gleixner wrote:
> check_bugs() is about to be phased out. Switch over to the new
> arch_cpu_finalize_init() implementation.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-ia64@vger.kernel.org
> ---
>   arch/ia64/Kconfig            |    1 +
>   arch/ia64/include/asm/bugs.h |   20 --------------------
>   arch/ia64/kernel/setup.c     |    3 +--
>   3 files changed, 2 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

