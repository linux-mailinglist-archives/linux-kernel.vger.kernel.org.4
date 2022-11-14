Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20910628311
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbiKNOpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiKNOpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:45:14 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A952D2D77E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:44:02 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z24so13468472ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejflZfRBJZNtbDrOFC8bunVAY8SzTkb6ZTYNd35CpN8=;
        b=ZHXettCaWz+3gxKUE9liEzp5XWwCBfeD/3YJHp2tmkGX1VCRa+qIn7/dX660w5/R/U
         kCBSwZ1hbrn565S00TC+V27KrIbqFrM/Z3V7jWyqCfGl8EzEY8M+Sbz0fupb8izvOIrN
         QVraaeLVBtEl8BOa75+7ZwfJ/FYSAKaNk2hgELw5+n0xYtfm1YJ4PdcGV6vUlB6mt2cp
         7YVy72dUgLQt2NquOyFXsXQjAEQszNF/VQOw7g//sfAv+USdeuESSjwSSWb1+hXbiPUz
         A65l+i42Jdse5H/5N+uk/BEZ8KyoCoHlh2aouhjHAQwElpo5ZVB3+iSZ4dqHPtrwTPKg
         61Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejflZfRBJZNtbDrOFC8bunVAY8SzTkb6ZTYNd35CpN8=;
        b=fOYxVYmaPuanuBSVZ8eAcov+u9vx6xfrxE7SMUsgQUQj8GKIsPBbPtjC0PZ8eETFIa
         yC2w7VeDRXfrL1hWgV+3BU/unQcjcXCQO3zi25EQ80ExNbtnkjE2f98CHDvSfbag3q52
         d6IhPaMJkUss4w9k986R/Wd94SqwJPFQZ5Aa0P2uXvt5TLJrf2+vweTwB8hO79xiWruG
         wJxm5JEgWlBCaVg6qyYSjYSB0Yv0VsVazC/RmjkITsWzFMoyRJTXZRnaLe6A+UlLw8Wi
         HitzR970KAo0KY8aPNIv5GB9+kPWsqgRFMXwK+FnmfhahujgIleK3JNCtzyJrKcp47Zu
         K60g==
X-Gm-Message-State: ANoB5pnCSbZn8K9QNxWXgqwGutrgu6jD6w6GMvpA2k25KCzMHM764DsU
        z1DdCLSImYBEqsjZFJ1eOu4=
X-Google-Smtp-Source: AA0mqf4Vmt8eS6siyEamccNe+6rgjmMuH4A46zfX72r1xhqRLOF7KvP7NR3JZseVWtZQbKoZFcWy9g==
X-Received: by 2002:a05:651c:1a13:b0:277:113d:1c38 with SMTP id by19-20020a05651c1a1300b00277113d1c38mr4765556ljb.238.1668437040914;
        Mon, 14 Nov 2022 06:44:00 -0800 (PST)
Received: from ?IPV6:2a02:6b8:0:107:3e85:844d:5b1d:60a? ([2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651c130400b0026e02eb613csm2053541lja.18.2022.11.14.06.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 06:44:00 -0800 (PST)
Message-ID: <3b7a841d-bbbd-6018-556f-d2414a5f02b2@gmail.com>
Date:   Mon, 14 Nov 2022 17:44:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 5/5] x86/kasan: Populate shadow for shared chunk of the
 CPU entry area
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
References: <20221110203504.1985010-1-seanjc@google.com>
 <20221110203504.1985010-6-seanjc@google.com>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20221110203504.1985010-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
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



On 11/10/22 23:35, Sean Christopherson wrote:

>  
> +	/*
> +	 * Populate the shadow for the shared portion of the CPU entry area.
> +	 * Shadows for the per-CPU areas are mapped on-demand, as each CPU's
> +	 * area is randomly placed somewhere in the 512GiB range and mapping
> +	 * the entire 512GiB range is prohibitively expensive.
> +	 */
> +	kasan_populate_early_shadow((void *)shadow_cea_begin,
> +				    (void *)shadow_cea_per_cpu_begin);
> +

I know I suggested to use "early" here, but I just realized that this might be a problem.
This will actually map shadow page for the 8 pages (KASAN_SHADOW_SCALE_SHIFT) of the original memory.
In case there is some per-cpu entry area starting right at CPU_ENTRY_AREA_PER_CPU the shadow for it will
be covered with kasan_early_shadow_page instead of the usual one.

So we need to go back to your v1 PATCH, or alternatively we can round up CPU_ENTRY_AREA_PER_CPU
#define CPU_ENTRY_AREA_PER_CPU		(CPU_ENTRY_AREA_RO_IDT + PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)

Such change will also require fixing up max_cea calculation in init_cea_offsets()


Going back kasan_populate_shadow() seems like safer and easier choice. The only disadvantage of it
that we might waste 1 page, which is not much compared to the KASAN memory overhead.



>  	kasan_populate_early_shadow((void *)shadow_cea_end,
>  			kasan_mem_to_shadow((void *)__START_KERNEL_map));
>  
