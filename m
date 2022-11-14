Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B03628219
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbiKNOKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbiKNOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:10:41 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5509E1FCF0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:10:40 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id l8so13305384ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADSq2f7jGhQ/42j/nm6BykZfXnm5jbp6+XiZg6V4aNs=;
        b=bSeOmRV84dazrprcJMg38nKqQZ1+Tq0XqgSKIMwgieiVhhYniNfD2CfPAYLXPbVeU3
         sFXUgSPLC5zwsJAH/vr55NJjHeCd7L7G8kTYVBxY4P1++jtKBD6KgZEIBWIaAiSbvhLm
         eG5BOQKGUfJEAufuq+oqFUq9yDgz/m2KxtASoRkWh9QqhZlOi7aEl4jqPeO+l701ceEt
         pfGiAby+CTl9DNJXquNhew5T2DUNuoffTjDqjBxv8gUV7xPz1ud1eZc3u3AxUBvMHMTF
         oX9eOxVf55+NVJWclTCCquHVRVfSRyew7YIQJ+/LFesKex1RJy1cqzjIqQT4POP32BQ+
         NlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADSq2f7jGhQ/42j/nm6BykZfXnm5jbp6+XiZg6V4aNs=;
        b=mck3/kbixeYGYuhFkj0+jTa1O/CVEncq2TaeOKLlq+sJBytta2vh30DhMH/HTFuWJ+
         MdDd06YX94hpuMX+DHjgmotwFX6rYoHlcN3ZLu+MybQrB3vhnNYd6JOx89alxMNaJdP8
         CYY/x8H1FTzqna3AwDDtcNf+dV278YUyQ68s9KPBXBpnIV2BXUrftH9mfcSkMaztKMFi
         +bibI3+8EZ+LbUBD8Oq32M/YGq3CWrQRGtyxlDZx3DRaQusglHx5DR/avPivBKDhV2MM
         oOl/8uIMiITAmZJeJtY+wnP88Bg2ORrmjBPb6FrZQkZSOZ0Z4ay53GXN8utI7fDFHHuZ
         CH0Q==
X-Gm-Message-State: ANoB5pkzOSfUR+Fflx2VE14ISZJ4z6VhhLig6idDhEssHHu++gAeYL9K
        JMbr0j5b1u9W+yn4ASE7vBQ=
X-Google-Smtp-Source: AA0mqf5IsamLhCJhWu55KmajM6t3WOOsOl957GGk4kdg+8LFR3PUric6TOjTnMscbhZ0/8t26W25ow==
X-Received: by 2002:a05:651c:491:b0:277:38d8:1e28 with SMTP id s17-20020a05651c049100b0027738d81e28mr4570723ljc.46.1668435038555;
        Mon, 14 Nov 2022 06:10:38 -0800 (PST)
Received: from ?IPV6:2a02:6b8:0:107:3e85:844d:5b1d:60a? ([2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by smtp.gmail.com with ESMTPSA id c2-20020a056512074200b004979e1ff641sm1824669lfs.115.2022.11.14.06.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 06:10:38 -0800 (PST)
Message-ID: <288b8f73-ee5d-76f2-18e4-f8e41ca98df5@gmail.com>
Date:   Mon, 14 Nov 2022 17:10:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/5] x86/kasan: Rename local CPU_ENTRY_AREA variables
 to shorten names
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
 <20221110203504.1985010-4-seanjc@google.com>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20221110203504.1985010-4-seanjc@google.com>
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
> Rename the CPU entry area variables in kasan_init() to shorten their
> names, a future fix will reference the beginning of the per-CPU portion
> of the CPU entry area, and shadow_cpu_entry_per_cpu_begin is a bit much.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/mm/kasan_init_64.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
