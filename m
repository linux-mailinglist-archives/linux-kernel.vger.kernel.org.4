Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C5695B60
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjBNHzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjBNHzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:55:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CBF3584
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:55:37 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h16so14662868wrz.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yp9YVWt295eBrVzLlEnMpa7WOgUH71k9lLJgF3DktSY=;
        b=h7M/SCUzNlOISn5jTGNmLltaLnbaZUtdxvRAjU33Milk2tpbKS2C1xqAq0HPm/BJRT
         FiJ/HCdDfWLCGCTNdK3VS2qjtc9bpTHe81E3CHaSYgmIq5P8HZR7PAW1a8s10oF2TIN2
         HojjglJNveA+nL0EeGaVfr3pzEZ9h17G9zgq7eukZMRTKZ2554cjMQl6XJfdOivXDkqk
         p6+UvsMCjwelsi/fnbvPZ4bmn5hfmGaZNsy5Ihf1d+h0B7f6xnfKvDzNoawdB3/hVkXh
         jP0nQULxasHEDW+waBz6yBAelaG8oXEN0PvGFOoSyLSbjEhs1hwBhQkj5fUqpkYkA3YB
         8MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yp9YVWt295eBrVzLlEnMpa7WOgUH71k9lLJgF3DktSY=;
        b=OVbHOzH/xLYaQFP3DTvGhIORDVDRmQ9Bt7M3g5odk+mA5EQv+RrYo7REXIE0Jeh71f
         oQuvk9NoLzjELYNPRmXf7I2kUsLZqnbn8SX/yxLC9Tdu4GiZLuuzjTYclzeaGmfUcrZ1
         9V9yDb/lqKvGMIMikJ1sJWZZeHuIQ1eF5x7TRwhh1YxT5Ty+yKw2YfNVj2YSBnA9Xl2A
         k4sO/MQVUOBTXL1IJft46BCYypVBWh7j8+sLG9neZ66HqFfrSVbkjX04BH+r2v0B9hCw
         8BMBaVgf+2mzXTwrXnuobLwU8hIBw9skYOMvYgwxQbdunORdFpWqJALv66bBqk1kSvKr
         Nlag==
X-Gm-Message-State: AO0yUKVotMEgW77AE4hL8Oy8XerJ8yIyruwvfWtgXAjzd8Rz0iQCEtFm
        g7zwZvaQbBe3c4KXXJbDHJ4qxA==
X-Google-Smtp-Source: AK7set/rbY3MtHZ2OwQUg49PapdpOUKWpKu/tClY9KXy+Lf8mxXzVA+B1mGvCao1HrbQ7vXyzSy4uA==
X-Received: by 2002:a5d:498c:0:b0:2c5:595a:1c91 with SMTP id r12-20020a5d498c000000b002c5595a1c91mr1050356wrq.7.1676361336205;
        Mon, 13 Feb 2023 23:55:36 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id y1-20020a5d6201000000b002c3ea5ebc73sm12178299wru.101.2023.02.13.23.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:55:35 -0800 (PST)
Message-ID: <1b4afd82-83cb-0060-7cab-8e16d2e69ff9@linaro.org>
Date:   Tue, 14 Feb 2023 08:55:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 19/24] xtensa/cpu: Make sure cpu_die() doesn't return
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
 <cca346b5c87693499e630291d78fb0bf12c24290.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <cca346b5c87693499e630291d78fb0bf12c24290.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On 14/2/23 08:05, Josh Poimboeuf wrote:
> cpu_die() doesn't return.  Make that more explicit with a BUG().
> 
> BUG() is preferable to unreachable() because BUG() is a more explicit
> failure mode and avoids undefined behavior like falling off the edge of
> the function into whatever code happens to be next.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/xtensa/kernel/smp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
> index 4dc109dd6214..7bad78495536 100644
> --- a/arch/xtensa/kernel/smp.c
> +++ b/arch/xtensa/kernel/smp.c

Can you update the documentation along? Currently we have:

   /*
    * Called from the idle thread for the CPU which has been shutdown.
    *
    * Note that we disable IRQs here, but do not re-enable them
    * before returning to the caller. This is also the behaviour
    * of the other hotplug-cpu capable cores, so presumably coming
    * out of idle fixes this.
    */

> @@ -341,6 +341,8 @@ void __ref cpu_die(void)
>   	__asm__ __volatile__(
>   			"	movi	a2, cpu_restart\n"
>   			"	jx	a2\n");
> +
> +	BUG();
>   }
>   
>   #endif /* CONFIG_HOTPLUG_CPU */

