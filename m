Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2773673D472
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjFYVZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 17:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjFYVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:25:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8AC137
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 14:25:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f90a7325f6so33696795e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687728349; x=1690320349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdnZaaLPu+ki2Fnpi7gIMqnleR/1nTSrgsUBiU7raqs=;
        b=AuZzlwnDYmnmOftfy2wrafOBFbb56vCejuD34y8KcPpleFcFuezxpyFWOSjhuZxkPS
         zeSfG2w0XrIPV1KdHWQokPQ1jXghjl2vrhRRAbTkOmBPev2Y+nWRI/biFzHZ3hCMQ7tM
         p/FzxBnXFDBpB8MHCj2WU/UolKd4/Vvmjvp6o4dVorfVmDfRaxfNR+qA9bNx0Pj9YdH1
         aTtZEM3RJSnIyZi4R338cGts/EylYRAl+/bJngdYtZ+oY5xIw7Y0hDIrOVdqWfMpTeqN
         /SK8Y+WrVYilXjqF3JrwO8FslIckA2qun1P1rq5RIx075Bn9K14LU4ka2oAd4GBp7mSP
         lYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687728349; x=1690320349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdnZaaLPu+ki2Fnpi7gIMqnleR/1nTSrgsUBiU7raqs=;
        b=eSH1Yo0HBcGQUKWIp3xbm5bU0szERZ9pAxk62qxnIyHr/JnxlsrWdFxh9Hy/k4+wkc
         lSR6+MQjRaxum5G8NuqrXscocZubFRFHQwLI6mPeR7THjnV4R4aui/d7pI5h2/HXcZ2j
         Sj1Kx/CkPmOT9OmRK5Ne5uEzB9jgAwly+4a1vh99Z3itnfzwu/IjB0wso/etJP+Jcj3Q
         JXMDt6N6tNxRz9XE7c2LORFoUHkHKt7ejlV8fAOFTeMv6qfkliUSRh1n7mKDh9GiOmW/
         P4rdxGxaMynn3ew0MKkEF391vToX8Ck0r5NlQn7iA5CnByaJu2WfoZqgVnMYx/lKOsa7
         VsIw==
X-Gm-Message-State: AC+VfDwJjMiA7to81Rrbxk/Kp+lNz2xOx073c61ZaSgIL76wPQ7/duCu
        AY/K5nj0P7JGA929xA+DMPOtMQ==
X-Google-Smtp-Source: ACHHUZ55uWsoV2hbUGeBFvfsxWLvpqQwxIsiqcLZylUM/E4cjFWcT0Stb/ufsPS5kTWtMBzw9AQ43Q==
X-Received: by 2002:a1c:4b16:0:b0:3fa:8475:bce1 with SMTP id y22-20020a1c4b16000000b003fa8475bce1mr3968019wma.4.1687728349062;
        Sun, 25 Jun 2023 14:25:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
        by smtp.gmail.com with ESMTPSA id c13-20020a7bc00d000000b003f735ba7736sm5718246wmb.46.2023.06.25.14.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 14:25:48 -0700 (PDT)
Message-ID: <db27d890-9c2c-8ec8-0d88-62b9172893ae@linaro.org>
Date:   Sun, 25 Jun 2023 23:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [patch 07/17] mips/cpu: Switch to arch_cpu_finalize_init()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
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
 <20230613224545.312438573@linutronix.de>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613224545.312438573@linutronix.de>
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
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> ---
>   arch/mips/Kconfig            |    1 +
>   arch/mips/include/asm/bugs.h |   17 -----------------
>   arch/mips/kernel/setup.c     |   13 +++++++++++++
>   3 files changed, 14 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

