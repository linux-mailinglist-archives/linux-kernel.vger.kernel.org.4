Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C848695AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBNHqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBNHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:46:48 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524331ADE5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:46:46 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso5477311wmo.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DacxiEr/DRTGj0ihMvkUuLy+Ahw15SkCabwK0cVB44w=;
        b=qDhFLdhlw3fk5+cbylV4EuicP2cp1j6GaEdWR75BFZ5cfMBViuHmoRACKTBq3oTz7n
         rVewYzdKSuwUurougp6CYy6IznFyHmrUwCi8u3DL9kS12KPbFLP07ynhro3+WFQSogl7
         uRbm7TyoTfgCngAGgMH6zAG0xNfoturbGAhE6YPUOw/BHGya7N+sX2wG73atfoGfioqV
         mZ44LWGz/XNdw1/lRFvORgWHtF//Vi0ebYhMCr3UkzP1JnplE/haXspQGjcP6TSdlIoQ
         MCUGIt9+T8hGMtruIPo9k19B4TRRKfvoX7D14PPhoPGCN7rLnhONxg37CYK0ltz3+z7L
         rxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DacxiEr/DRTGj0ihMvkUuLy+Ahw15SkCabwK0cVB44w=;
        b=d6LI7KQmjQB+SJh5ESsZ2Vg7hOfrDly3t6RD+v7y0nTnVRZO2Di1tBFRAcDEyVoZFT
         wybRAkxj7C8XQwROiKVAJ5GP3V4sv0w9KENg5JsDao+z3IJ0RwRGg9vgJUwV6VbTUhX4
         p0z+6tGjS0YfbLf3yFyi4x9vwQx14Rjb95BboLneANvgi2hv3Yhf9qzQPMmY32bYv8Wr
         Yi6kIeBn1Rp1iYZh7EKgX8NiwmIzJuksPGACX+4MgFoyKtEeHQGdzdj8k9B2tzOlpzig
         uSpKqUtrs/+oKnDZdEAqRS9ytKWK67bLkpQzAfn5wxfZ0EIktQZSCo/vHG5GrL766K1o
         5/Cw==
X-Gm-Message-State: AO0yUKUVdjs3I1E4cRBRBWPLPGfhl+aIJ6FwKdsZ+34maBI5u6edzAT8
        y0Sp7gSv+NPF7MYWjjmL0luOjw==
X-Google-Smtp-Source: AK7set9Rqo60IwHxoePnD0qX8izJ2ESap7X64zOUHv8nkLWZxobCJ+rymd6DUJKr/uol+6YPFby3eQ==
X-Received: by 2002:a05:600c:993:b0:3df:50eb:7ca6 with SMTP id w19-20020a05600c099300b003df50eb7ca6mr1103969wmp.15.1676360804870;
        Mon, 13 Feb 2023 23:46:44 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bca57000000b003de8a1b06c0sm19248993wml.7.2023.02.13.23.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:46:44 -0800 (PST)
Message-ID: <080a5ccb-7fa0-1a75-538f-a09dc146fc4e@linaro.org>
Date:   Tue, 14 Feb 2023 08:46:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 09/24] mips/cpu: Expose play_dead()'s prototype
 definition
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <39835bc75af2e812fce56400533cb2ab41bcf0e2.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <39835bc75af2e812fce56400533cb2ab41bcf0e2.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On 14/2/23 08:05, Josh Poimboeuf wrote:
> Include <asm/smp.h> to make sure play_dead() matches its prototype going
> forward.
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/mips/kernel/smp-bmips.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
> index f5d7bfa3472a..df9158e8329d 100644
> --- a/arch/mips/kernel/smp-bmips.c
> +++ b/arch/mips/kernel/smp-bmips.c
> @@ -38,6 +38,7 @@
>   #include <asm/traps.h>
>   #include <asm/barrier.h>
>   #include <asm/cpu-features.h>
> +#include <asm/smp.h>

What about the other implementations?

$ git grep -L asm/smp.h $(git grep -wlF 'play_dead(void)' arch/mips)
arch/mips/cavium-octeon/smp.c
arch/mips/kernel/smp-bmips.c
arch/mips/kernel/smp-cps.c
arch/mips/loongson64/smp.c

