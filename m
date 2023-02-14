Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D35695C84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBNINc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjBNINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:13:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C5310CB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:13:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id he5so2565406wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRk5ZZgGHESQjRAciCkzTAgvsM2DNZ9ZsvdntVwJ0aM=;
        b=VyF1fPdQ9QypQQWSzFllqGzI7seyTSuDNNWwfWkkysTNgd3Z0AjIHNF4LL0vR9kDt1
         TWXLrpk12hmDLU5xwDRS8oUfZzApeC/OHNNgO/kMt5igi3066XuNNQHPHFYxq5aB3Iio
         Rm5A78vOgv0qZPG3TgPZ61nsLc76jlc9DVGKtErGMeKDI9u1sAq/m/nABeTJZydjJdxc
         KGyGm1+PtUnlS5irzivoc/koNSZhBHg8b061deMm/1IYjdDegSeovedsXz378PrcPSkc
         AtwiyODrhxTX3DivF8dzOcKQXifNwgDmLtIw7KfLqn/lQcvbpYuvCV1bwFmaRQqmk4vF
         cK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRk5ZZgGHESQjRAciCkzTAgvsM2DNZ9ZsvdntVwJ0aM=;
        b=VDCECmWFFAFCfFY+fltE0OKyvQ3BAMxf8NI38WwC+r7vK5CBJDK+XxvNJBOGcizW+1
         2duBOSHOFtfTmcnnwH8ELgzwGezJy8QShUXM2sfwGg4/6m/4mI5/JdL3QO9eTIS6youV
         dZuPncK9m/LOEh2qtL6qe9pd+82Sz/PNg8m6LsSc2Ju7LKCXN0q+aa9L2YJK9bi6jDIr
         K0WnSjE68sztcSYp/JjXIEUJPzmFv9PNARRdq6D0r0eza/GAAl5xBxfS97rmPItweJu4
         3vA31vvYNNcdDP+B71TsBP0rwrMjnzdZUjUafBAezlk15FeyHMj+PBHN/55SGPdq4o7J
         Ab8g==
X-Gm-Message-State: AO0yUKUcrIe5fxFYG2q0f4ei1gs/+co2PHvvaAVLPOmH6gAPptVEM3fL
        +oAgujalxEMUy3fWic9O5D2otZN4/5u75rHc
X-Google-Smtp-Source: AK7set86AEK8D+D8+uPrCG75m0oQUNX8HZoOAkr8DDcCJCZFL80/CRikdClz+P95k5T2L/MBj1J/jQ==
X-Received: by 2002:a05:600c:30d2:b0:3dc:4fd7:31f7 with SMTP id h18-20020a05600c30d200b003dc4fd731f7mr1177763wmn.41.1676362392093;
        Tue, 14 Feb 2023 00:13:12 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b003db1ca20170sm17626418wmq.37.2023.02.14.00.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:13:11 -0800 (PST)
Message-ID: <14274f04-2991-95bd-c29b-07e86e8755c1@linaro.org>
Date:   Tue, 14 Feb 2023 09:13:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 04/24] arm64/cpu: Mark cpu_die() __noreturn
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
 <e47fc487980d5330e6059ac6e16416bec88cda0e.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e47fc487980d5330e6059ac6e16416bec88cda0e.1676358308.git.jpoimboe@kernel.org>
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

On 14/2/23 08:05, Josh Poimboeuf wrote:
> cpu_die() doesn't return.  Annotate it as such.  By extension this also
> makes arch_cpu_idle_dead() noreturn.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/arm64/include/asm/smp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index fc55f5a57a06..5733a31bab08 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -100,7 +100,7 @@ static inline void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
>   extern int __cpu_disable(void);
>   
>   extern void __cpu_die(unsigned int cpu);
> -extern void cpu_die(void);
> +extern void __noreturn cpu_die(void);
>   extern void cpu_die_early(void);

Shouldn't cpu_operations::cpu_die() be declared noreturn first?

