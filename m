Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225D16A8074
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCBK4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCBK4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:56:04 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00343E0B7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:56:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r18so16105195wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677754561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcB+LkE9o/I91gQw86q7yd+Ffjb03AeLOMDNvAVG6zU=;
        b=e+rBLcD31qUq8ofcmunQB9T7cslMikWVWW6tnNkoeRTZSr0ibaKWx6rD8a8dIYWPbf
         fW0lAdd1SlGla3ldAdLc2WNM647uUJVdreNaB/qg7aUUMgDDePMIWN3pb/AoMCiJb+St
         tow4zUg3XCJzfV66feCzlombFmSlirJwAwJYJJXxg73C74+IUIAmk+CfZV7/C8RF237X
         ATaGKPpZHMGMf9NOyVzbyWTAcRJ2fyN3xTL77ldU6Hy2rlID/O21D1kJ//SZkIYlIO5l
         DDGWvkXwGEua7w2cyrIHn6vIVLfQNHuKTWku29kPg5x4VOTcuWrsPVQur+EkO3X8IVit
         RLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677754561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcB+LkE9o/I91gQw86q7yd+Ffjb03AeLOMDNvAVG6zU=;
        b=Z1KwS4MlooMwhu3TX1wI50oDeBOqpxzpMJbQWmR8/RTIRqYgOZUGVMPLvHIrb2yDKT
         Z69XkHK0H8RFRP0QlG797LDJ8DggZwKRQCsxALQ3IZ5uUnUvbsuTl+3nLABKxrhOju3s
         xXtG0r71sP1uJ9YilSshoBJFD2F8YOoW6q54BHowSnp3j3ZihIK0W6dVlUPYCQDItOJu
         OAlZEhIlvSDGSCv5jq8aptw4Z79sAgyTmrkp5+h4OJUAHkpAr3bWFkJYyEigUhq3pKPC
         tEjkzKnp7NfS/gV79gq6pkLHxr2U8FxHGXwneNdQpM8n2osvEyQZCjEELdvV+cvMqJ9c
         /F1Q==
X-Gm-Message-State: AO0yUKVQqKWefIhqd5UvW9YhTpC/oX6fvlT5rSFP5BcXLqna2Lq0yCtx
        mYuBfWhNefQJ4UJHmK+5RZyAhQ==
X-Google-Smtp-Source: AK7set/m1l0TRmjNbMf9+h0ZaEF1Xb+SrFR0Wb95q+XihEhxpIYi+zG0JloSFSR6HCHnrFBnWnL2Qw==
X-Received: by 2002:a5d:4d43:0:b0:2c7:1e43:f46e with SMTP id a3-20020a5d4d43000000b002c71e43f46emr7571202wru.37.1677754561094;
        Thu, 02 Mar 2023 02:56:01 -0800 (PST)
Received: from [192.168.74.175] (89.red-88-28-21.dynamicip.rima-tde.net. [88.28.21.89])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe590000000b002c70e60eb40sm15183667wrm.11.2023.03.02.02.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 02:56:00 -0800 (PST)
Message-ID: <1a4df71c-3934-6956-4120-d6cf3fcf4ca9@linaro.org>
Date:   Thu, 2 Mar 2023 11:55:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2.1 04/24] arm64/cpu: Mark cpu_die() __noreturn
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     juri.lelli@redhat.com, dalias@libc.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, peterz@infradead.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        x86@kernel.org, jiaxun.yang@flygoat.com,
        linux-mips@vger.kernel.org, bsegall@google.com, jcmvbkbc@gmail.com,
        guoren@kernel.org, hpa@zytor.com, sparclinux@vger.kernel.org,
        kernel@xen0n.name, will@kernel.org, vschneid@redhat.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        ysato@users.sourceforge.jp, chenhuacai@kernel.org,
        linux@armlinux.org.uk, linux-csky@vger.kernel.org,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        bcm-kernel-feedback-list@broadcom.com, mgorman@suse.de,
        mattst88@gmail.com, linux-xtensa@linux-xtensa.org,
        paulmck@kernel.org, richard.henderson@linaro.org,
        npiggin@gmail.com, ink@jurassic.park.msu.ru, rostedt@goodmis.org,
        loongarch@lists.linux.dev, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, jgross@suse.com,
        chris@zankel.net, tsbogend@alpha.franken.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        bp@alien8.de, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <e47fc487980d5330e6059ac6e16416bec88cda0e.1676358308.git.jpoimboe@kernel.org>
 <14274f04-2991-95bd-c29b-07e86e8755c1@linaro.org>
 <Y+zZgZIP7RPIgyQf@FVFF77S0Q05N> <20230215194538.aiiris3uabnuvkkg@treble>
 <20230216184157.4hup6y6mmspr2kll@treble>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230216184157.4hup6y6mmspr2kll@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 16/2/23 19:41, Josh Poimboeuf wrote:
> cpu_die() doesn't return.  Annotate it as such.  By extension this also
> makes arch_cpu_idle_dead() noreturn.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/arm64/include/asm/smp.h | 2 +-
>   arch/arm64/kernel/smp.c      | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

