Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567A86366F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiKWR1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbiKWR1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:27:32 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3254ADFB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:27:31 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h193so17294758pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpmaIKnrCiI4dvK6OHphu9fCVFQl5+naAN7dmWdbu6Y=;
        b=hTepHPcEdaE8aWTpVsBV28Kfw+AScDUUMp1OWmNWZkDvAs8vu9XSl97xS+VwCan0zc
         pIqlwsAT2klMTrfB2nKQZmP3b2TvvP7boaGYLqWhxorXfY6AaJepQreCO1UPwaxqTZCm
         tcHgAOyyi4BQRQARd187JP6i8eclEEUSO3q7PmzFNo0mC33WjqWMXEUqJQQqxe+DbcVT
         v46sJGgnIWQP8Rf+7NIQTQYpJLRydAf2qJtizRKWA5fdA8345MK+Dz480CJsI84jdWpD
         a8gNH/YmsX6pZZrt8AM5059jH3FazvOjXTZyzhywzNobWaNnHs/lipbRM9TKGm4u3RT9
         NPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpmaIKnrCiI4dvK6OHphu9fCVFQl5+naAN7dmWdbu6Y=;
        b=uKZA2zUJmqzi35UnXpEwg7ikOMTWqOyz/3taCjkfYCuskGeX235YxT/BYLnhKJF/3I
         yDsecHNzxC8Vf1y75v+1sPAAvHSTPaBRKbHIGVm6UKDtkwiGotIZo3ib5d3f6Td6ooZI
         +SFe1fEDPaT6mnl0edSJ1vi0kMmYoMGYb4HJamXzUnZnhq9DmdztSxjCbnvwBIt6hIHF
         E77aq4P8X2JthCO6L1/tjgfqveI7KfIG2cJIIaNXnqRnmzJBKxHXiCwjwgFmGOdtd4G4
         tRXhcUJrJhWy817zK/gzzVMgfzrUxYT6F46RuJBkivUgzZiGRo/8bKYW4buQ1qMLvEoT
         vKRQ==
X-Gm-Message-State: ANoB5pkqOKuCtUNDCiSHi1Mq+5XbgmlxfNThku+XZDOKFaXqzVmnuc8f
        43nKC0eX+eVxZlaVpocOzsX7jgYx0hsG6zs3PaM=
X-Google-Smtp-Source: AA0mqf7CRXwpttGvvthhj0/eYYlegEoG4pgsx4gg/zyYwVlbyxVGhqcY4H/bUoc2X4vDbexQVQLdhZzT6SNjnUwA308=
X-Received: by 2002:a63:e401:0:b0:46f:c183:2437 with SMTP id
 a1-20020a63e401000000b0046fc1832437mr27325610pgi.613.1669224450105; Wed, 23
 Nov 2022 09:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
 <20221123142025.1504030-2-suagrfillet@gmail.com> <CAJF2gTTwvApRaGhZJxOrdcjWUC9DN-WF_7EKcHXx5HZ9Jkd5EA@mail.gmail.com>
In-Reply-To: <CAJF2gTTwvApRaGhZJxOrdcjWUC9DN-WF_7EKcHXx5HZ9Jkd5EA@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Thu, 24 Nov 2022 01:27:19 +0800
Message-ID: <CAAYs2=ghhMmmrM4Bktvw9iGiajS5PLd1=Z61j2ZfhbhGUi4ekg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv/ftrace: add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8823=E6=97=A5=E5=
=91=A8=E4=B8=89 23:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Cool job, thx.
>
> On Wed, Nov 23, 2022 at 10:20 PM Song Shuai <suagrfillet@gmail.com> wrote=
:
>>
>> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
>>
>> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
>> register_ftrace_direct[_multi] interfaces allowing users to register
>> the customed trampoline (direct_caller) as the mcount for one or
>> more target functions. And modify_ftrace_direct[_multi] are also
>> provided for modifying direct_caller.
>>
>> To make the direct_caller and the other ftrace hooks (eg. function/fgrap=
h
>> tracer, k[ret]probes) co-exist, a temporary register is nominated to
>> store the address of direct_caller in ftrace_regs_caller. After the
>> setting of the address direct_caller by direct_ops->func and the
>> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
>> by the `jr` inst.
>>
>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>> ---
>>  arch/riscv/Kconfig              | 1 +
>>  arch/riscv/include/asm/ftrace.h | 6 ++++++
>>  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
>>  3 files changed, 11 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 39ec8d628cf6..d083ec08d0b6 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -278,6 +278,7 @@ config ARCH_RV64I
>>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>>         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,=
-fpatchable-function-entry=3D8)
>>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>> +       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>>         select HAVE_FUNCTION_GRAPH_TRACER
>>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
>> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ft=
race.h
>> index 01bebb28eabe..be4d57566139 100644
>> --- a/arch/riscv/include/asm/ftrace.h
>> +++ b/arch/riscv/include/asm/ftrace.h
>> @@ -114,6 +114,12 @@ struct ftrace_regs;
>>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>>                        struct ftrace_ops *op, struct ftrace_regs *fregs)=
;
>>  #define ftrace_graph_func ftrace_graph_func
>> +
>> +static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, =
unsigned long addr)
>> +{
>> +               regs->t1 =3D addr;
>
> How about regs->t0 =3D addr; ?
> And delete all mcount-dyn.S modification.
>
The direct_caller has the same program layout as the ftrace_caller, which m=
eans
the reg t0 will never be changed when direct_caller returns.

If regs->t0 changes here and ftrace_regs_caller executes `jr t0`,
direct_caller will enter the dead loop.

Actually the reg t0 always saves the address of function entry with 8B
offset, it should only
changed by the IPMODIFY ops instead of the direct_ops.
>>
>> +}
>> +
>>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>>
>>  #endif /* __ASSEMBLY__ */
>> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-d=
yn.S
>> index 466c6ef217b1..b89c85a58569 100644
>> --- a/arch/riscv/kernel/mcount-dyn.S
>> +++ b/arch/riscv/kernel/mcount-dyn.S
>> @@ -233,6 +233,7 @@ ENDPROC(ftrace_caller)
>>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>>  ENTRY(ftrace_regs_caller)
>>         SAVE_ABI_REGS 1
>> +       REG_S   x0, PT_T1(sp)
>>         PREPARE_ARGS
>>
>>  ftrace_regs_call:
>> @@ -241,7 +242,10 @@ ftrace_regs_call:
>>
>>
>>         RESTORE_ABI_REGS 1
>> +       bnez    t1,.Ldirect
>>         jr t0
>> +.Ldirect:
>> +       jr t1
>>  ENDPROC(ftrace_regs_caller)
>>
>>  ENTRY(ftrace_caller)
>> --
>> 2.20.1
>>
>
>
> --
> Best Regards
>  Guo Ren
