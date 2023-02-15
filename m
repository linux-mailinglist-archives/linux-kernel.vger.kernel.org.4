Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56D69782B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjBOI3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjBOI32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:29:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3925D46A7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:29:26 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk16so18179663wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+uRuWA2my0PkLfTRJkVAZ05w6wbQaFzpjSQTlA3Y10=;
        b=EAjtSefiFMcRJUjTT1vKa++/98Yo1SN60xpEBkPSeru5QVrOombFl7ZHZ9y0eBb+k8
         1ZpycnMJayGmVT6T6UnuPRjCB3nPxmBujGFtXaNp8cbOZSlWgdaIEhXU+GGjztzV/czy
         1WDq6VfomA00oo7hLpCf0eBYSqerRkvKuSrVmRTM4XbxzJrQVoIbRj0AGC+iAePl6sTf
         Z2xptiD/VOo1nfoRA4XWNffLKM3ZE08q46EkUvIRst5VglioETpQYFtr/iY0tCSkcOlD
         bJtursUf7vQFXV0RL9Rz9XvQSF18NBopDoEorHB9a2ffDlY3yM0iSt8r0hW9VmbKY8B/
         Tfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+uRuWA2my0PkLfTRJkVAZ05w6wbQaFzpjSQTlA3Y10=;
        b=piilw4oiwyAdpsvK5I1A2Xy30drB3usCEaWiCGAix5vT9jf0Lj8NwG6VTFZb+VFz0j
         Fe0uTPI1oYTs5m3QEiwUl8ACKPF5PmWbWIM8dykJQ673+tRH2v/mSlBL4Sm1FO0yXB4Y
         j2Pk89uM8MLCSkR5Mp4OmECqqSrJQt6m2Previz93uWUwjjm5baJq4HLZxrzDXLoLI9w
         YBLIeYbmCWIQYoRfwep5V1aEIp1IxWLOu/ig+th19ovlS1lbgaM3IEh2PGcJsM3wdBdQ
         RuwxJc4fB/+vm5goxHpxz4dub8PKrjiXZVGNBkau18vroJi3uSwv55W4CKTcQ3WJcQqF
         LmLQ==
X-Gm-Message-State: AO0yUKXefw7HRxr7pdfEvMIqcOPtUwikEoNxLIZNN4CIs0ImaNmesMRt
        Gf8Rg2x038syg6nU75GjHBDmkQ==
X-Google-Smtp-Source: AK7set8G2iiFdHjvUAVVY5llFOflusvwqwWTyX5fVt/Awzv2HxyXMg5++kq1nd94kDMQiFL/tQeRqw==
X-Received: by 2002:a5d:67cc:0:b0:2c5:58fc:e1bb with SMTP id n12-20020a5d67cc000000b002c558fce1bbmr826926wrw.10.1676449764713;
        Wed, 15 Feb 2023 00:29:24 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id i2-20020adfefc2000000b002c553e061fdsm8524783wrp.112.2023.02.15.00.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 00:29:24 -0800 (PST)
Message-ID: <c56dc4b9-035d-7773-ecb2-0e1ac6af7abc@linaro.org>
Date:   Wed, 15 Feb 2023 09:29:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 09/24] mips/cpu: Expose play_dead()'s prototype
 definition
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev, f.fainelli@gmail.com,
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
 <080a5ccb-7fa0-1a75-538f-a09dc146fc4e@linaro.org>
 <20230214181101.3a2tscbmwdnwbqpu@treble>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230214181101.3a2tscbmwdnwbqpu@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/2/23 19:11, Josh Poimboeuf wrote:
> On Tue, Feb 14, 2023 at 08:46:41AM +0100, Philippe Mathieu-Daudé wrote:
>> Hi Josh,
>>
>> On 14/2/23 08:05, Josh Poimboeuf wrote:
>>> Include <asm/smp.h> to make sure play_dead() matches its prototype going
>>> forward.
>>>
>>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>>> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>>> ---
>>>    arch/mips/kernel/smp-bmips.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
>>> index f5d7bfa3472a..df9158e8329d 100644
>>> --- a/arch/mips/kernel/smp-bmips.c
>>> +++ b/arch/mips/kernel/smp-bmips.c
>>> @@ -38,6 +38,7 @@
>>>    #include <asm/traps.h>
>>>    #include <asm/barrier.h>
>>>    #include <asm/cpu-features.h>
>>> +#include <asm/smp.h>
>>
>> What about the other implementations?
>>
>> $ git grep -L asm/smp.h $(git grep -wlF 'play_dead(void)' arch/mips)
>> arch/mips/cavium-octeon/smp.c
>> arch/mips/kernel/smp-bmips.c
>> arch/mips/kernel/smp-cps.c
>> arch/mips/loongson64/smp.c
> 
> Indeed.  I really wish we had -Wmissing-prototypes.
> 
> I'll squash this in:
> 
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 89954f5f87fb..4212584e6efa 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -20,6 +20,7 @@
>   #include <asm/mmu_context.h>
>   #include <asm/time.h>
>   #include <asm/setup.h>
> +#include <asm/smp.h>
>   
>   #include <asm/octeon/octeon.h>
>   
> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> index bcd6a944b839..6d69a9ba8167 100644
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -20,6 +20,7 @@
>   #include <asm/mipsregs.h>
>   #include <asm/pm-cps.h>
>   #include <asm/r4kcache.h>
> +#include <asm/smp.h>
>   #include <asm/smp-cps.h>
>   #include <asm/time.h>
>   #include <asm/uasm.h>
> diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
> index c81c2bd07c62..df8d789ede3c 100644
> --- a/arch/mips/loongson64/smp.c
> +++ b/arch/mips/loongson64/smp.c
> @@ -14,6 +14,7 @@
>   #include <linux/cpufreq.h>
>   #include <linux/kexec.h>
>   #include <asm/processor.h>
> +#include <asm/smp.h>
>   #include <asm/time.h>
>   #include <asm/tlbflush.h>
>   #include <asm/cacheflush.h>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks.
