Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0371639088
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKYUNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 15:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYUNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:13:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD028727
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 12:13:28 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so8564537pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 12:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDP8+zBmfQHRcFiPOpCE4wMRSn6LEmNlkUH03ts3yr0=;
        b=hKyprivKiYzzTQ8oF/ulUkkdzfgIzRiVbIUuR89KKXYuG438MnyI88QGVMT8EcO1w2
         iGJr19FWFI0DRxsAW6fw4vpIkQ7sS6PXTXfZZq1dsZ8SqhlpjEIwCyTLHbfJZfJU0NHz
         A9pB4zYyQs3p5roKeN30feXEdRIwLbAtzEP6kNo1VcvYiCuoMkLyjctiWg1x9mPf17ho
         NYYRhaNm3fbQhLyiS+uTdSgESVpJmHagdOe0785ktd7t+ECJL/d1GE5bM1FqQXaguMLF
         YfRMpG8KvHZK7Rc/YcR7Ez16XYTPz6V4euDjSEZwjRgOx4SEiOvCCBU6zLUzj3B8bMPA
         0uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDP8+zBmfQHRcFiPOpCE4wMRSn6LEmNlkUH03ts3yr0=;
        b=SDbNc6uxGGBVW+BLyrTrf9AhJzjIcuWkT0k/j31lADXY+a1R7ztuOL+2Mx/us/5Ems
         4Zrb7WyYt8m8+f5n3ECc4JrQXQi0K55IJcHc/HioVlIV1RUgmRs3khbFOOKs50ttN5S0
         URipCdP8wMriUb8etb+/udxL0lRj1ULb2OgWm30AXZ70T7moUhfLibyLXoL4s9rvXMs9
         L/xCOskozmzmZSpOpDdyG7VRY24+e2+u7q1mWdq6FRW4OEuBEWFFg+zECkCQFr5s4ELs
         25v2hEoMRZ4ISF507g1CDdaB6I4gaCTv4lEaxnSrJqjB88rOndRQFXF/hwdijAJblq3p
         Cm4g==
X-Gm-Message-State: ANoB5pli+V9N+w1zDVA5GcvsJKec8i7Ndz4XEoYbG/WqWykT5MZ258Y3
        QVQPdBOeRfyD2VSMbgGqfUJlJy5TB16qnQ==
X-Google-Smtp-Source: AA0mqf7aQtDeqUgEbaJZZey8FgHViRH5FRjF5BMRy/riw4u/ktLZOVEt+cQ+jwW38CL7F8wBpxdP0g==
X-Received: by 2002:a17:903:2601:b0:189:315f:d6fc with SMTP id jd1-20020a170903260100b00189315fd6fcmr19751432plb.35.1669407208245;
        Fri, 25 Nov 2022 12:13:28 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id b16-20020a170903229000b00186a68ec086sm3813166plh.193.2022.11.25.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 12:13:27 -0800 (PST)
Date:   Fri, 25 Nov 2022 12:13:26 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v2] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <20221125201326.GA2037421@debug.ba.rivosinc.com>
References: <20221124094845.1907443-1-debug@rivosinc.com>
 <CAJF2gTSU5sskjJTm6yL_X9aHdtVQ0MLzEY7FRRLT1mKH9qkWXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJF2gTSU5sskjJTm6yL_X9aHdtVQ0MLzEY7FRRLT1mKH9qkWXw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 05:53:45PM +0800, Guo Ren wrote:
>On Thu, Nov 24, 2022 at 5:48 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> index df9444397908..a7da051159cf 100644
>> --- a/arch/riscv/kernel/asm-offsets.c
>> +++ b/arch/riscv/kernel/asm-offsets.c
>> @@ -38,6 +38,7 @@ void asm_offsets(void)
>>         OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>>         OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>>
>> +       OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>Why not TASK_TI_CPU ?
No specific reason.
>
>>         OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>>         OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>>         OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
