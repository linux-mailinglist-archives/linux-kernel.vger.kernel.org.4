Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB09621DB4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKHUcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiKHUcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:32:19 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4F110B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:32:18 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j4so22872501lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJt0kVHbBDkDv41VSM0vRXGgK3laYpSR5VQmLWACDUI=;
        b=ZObg1M6AdOgFmIvQnXI6XbCgZteotPWmAIw1AYTkUWJ+Of6jMW4AY6CPCMWSjd6/BX
         jP1Rk+QyGNN/9l6v8fkwbF/mcgTMYm/LsCN1JmIutv+DN+EEC2mBCT327RfxNVZa7Xvz
         UB3MuzkZKv8lRA2BMMiQpAMFhFo+oxU9ZBPUBf/bpkNBDaaKh5W8gBzFKirqCvXQ+npF
         8Q1Xpixu5nT4ErL5/wgnZ1S6CKV4dXKOzmEgIyqC7kgiWYh9TKiGqWeAMuNncIfUP9/0
         eRN5/q2OcGH3nxJoO98T9Tl2tT2GCWTc/iqgb77IEcJ3f/lMKGVDz/gZjIW9b5mfMp9j
         S/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJt0kVHbBDkDv41VSM0vRXGgK3laYpSR5VQmLWACDUI=;
        b=bGxSC3qJLaq9i7glECArdKZlhGCTQvLBbdgkx3OLm9LT8x823l3bQ/n2MU2OB3UsVR
         g+2aB60Rbq436CHR6dsU32+T9rhNKk11u2lcooysRD4088oc++eA2WyGfV86SLn0IABf
         gb8D3y/VHTqr6RAONOkpR2ecrfRFC4uFjaese7mEXjNgEK8Aio6qvToAHE+LBk5S50xK
         snmeM6wZbpk1K9Trix3OjLMFEDYwHRpJ803RMWyoNriMP0/KHzG40xD0/wk8O58C3mEM
         smzX64WSuBR4tPNNFF5kVXZQRQUggogTJO0M7zMUyq5wMPUutVXXh5GyKpSg5b8N6CK9
         SSZw==
X-Gm-Message-State: ACrzQf1IH6HZ20mfOyrMLTXlrAprA8zwQmOAIwsnd0ys5yWsN81yql63
        ltZ8co7kIOcNyiqQxe007rU=
X-Google-Smtp-Source: AMsMyM5xe7/Zs/d1l7n5NMl+fxbaRaq/ljwi54jYxD1lKDQ1X2daxrs4PzGZ3FGiAWmao9lwieXciQ==
X-Received: by 2002:a05:6512:1154:b0:4a2:4f74:f47c with SMTP id m20-20020a056512115400b004a24f74f47cmr490729lfg.367.1667939536837;
        Tue, 08 Nov 2022 12:32:16 -0800 (PST)
Received: from [192.168.31.203] ([5.19.98.133])
        by smtp.gmail.com with ESMTPSA id y19-20020a2e7d13000000b0027709875c3esm1859272ljc.32.2022.11.08.12.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 12:32:16 -0800 (PST)
Message-ID: <518b5f84-ca10-6943-76dd-a7fa267b8a13@gmail.com>
Date:   Tue, 8 Nov 2022 23:32:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/3] x86/kasan: Populate shadow for shared chunk of the
 CPU entry area
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
References: <20221104183247.834988-1-seanjc@google.com>
 <20221104183247.834988-4-seanjc@google.com>
 <06debc96-ea5d-df61-3d2e-0d1d723e55b7@gmail.com>
 <Y2q2GFWjLKMp5eUr@google.com>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <Y2q2GFWjLKMp5eUr@google.com>
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



On 11/8/22 23:03, Sean Christopherson wrote:
> On Tue, Nov 08, 2022, Andrey Ryabinin wrote:
>>
>> On 11/4/22 21:32, Sean Christopherson wrote:
>>> @@ -409,6 +410,15 @@ void __init kasan_init(void)
>>>  		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
>>>  		(void *)shadow_cea_begin);
>>>  
>>> +	/*
>>> +	 * Populate the shadow for the shared portion of the CPU entry area.
>>> +	 * Shadows for the per-CPU areas are mapped on-demand, as each CPU's
>>> +	 * area is randomly placed somewhere in the 512GiB range and mapping
>>> +	 * the entire 512GiB range is prohibitively expensive.
>>> +	 */
>>> +	kasan_populate_shadow(shadow_cea_begin,
>>> +			      shadow_cea_per_cpu_begin, 0);
>>> +
>>
>> I think we can extend the kasan_populate_early_shadow() call above up to
>> shadow_cea_per_cpu_begin point, instead of this.
>> populate_early_shadow() maps single RO zeroed page. No one should write to the shadow for IDT.
>> KASAN only needs writable shadow for linear mapping/stacks/vmalloc/global variables.
> 
> Is that the only difference between the "early" and "normal" variants?

It is. kasan_populate_shadow() allocates new memory and maps it, while the "early" one maps
'kasan_early_shadow_page' 

>  If so, renaming them to kasan_populate_ro_shadow() vs. kasan_populate_rw_shadow() would
> make this code much more intuitive for non-KASAN folks.
> 

Agreed.

