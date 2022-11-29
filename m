Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5EC63BFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiK2MEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiK2MD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:03:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6030C5802C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:03:14 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c15so4168363pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4Uj47DJf73FxZb3P8g6O9fWjUxsQOikSyAAeVgUhcA=;
        b=P35CotWzaM2P3ovyTan+dW0r95aJEGTqjZRrro4IiaN6r7sLG4x5QwwOxC23vuRxBS
         obQTCzC9TcZWGZ6UJMvVn5Vx+c1fM2MDcFhO9fPBF0T2dhWebBUy7sEV01KAZdFmia06
         tKNoS2f0xttHee5GmSVIqbBmDeBplGQphNx0/efdoc9iGvePyTwo3Ii3L6LjPJdRqT+d
         dg/y7Svxyg4M4sBdd7JWKc2xDe2wYQhZGolbC7RCA1tF1rZtboNQEadSqoEXdd2q5ae7
         vlK4rXNMG+4DJf3GtDeb2ylVB2Gg4yds1cCpf1uROZQEZojPAkDLyshkQuYBHvA+3eXj
         FpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4Uj47DJf73FxZb3P8g6O9fWjUxsQOikSyAAeVgUhcA=;
        b=WS1RAn9F2dlffaHjMWEOoGELaTdvJXkgBGfLORvbcvG0o8KP5odsFnhSE2d/zMsO4n
         NcbM7FOMFSP2TxZN/CoepwIssd97JNwdG3/YYFJD5ijtb33I9zQk9qyCwKgJuJVsz6h7
         roiMpKRpI/lxdfvuqjBsbYO0abpa8Z4r0M95W2WX7reYAbHUfg1KfOEi07D5/+ICJsHZ
         KgqY6ExBDUszRApIm5coHJ5ju35HRRcN8+O1uebaeqBXAHIjNKmB6RUDwwwu1uuNe+QA
         ChnmgLYZrYbLZPl969k3tTaqwrtImdvw7V0jW39xbf9oPOxo9NeDyYjpCqdDmbcCnFJG
         xNxg==
X-Gm-Message-State: ANoB5pm2diQGoyxR38bJJ/6c4cQxPruwEA19HlHhBYkgqxplEiKHekjA
        8iCSZ7gEtXgltRbVFFrp/NcQIZXfJgPGYiGtxoo=
X-Google-Smtp-Source: AA0mqf4/dopHy4Uoq3WIsq7+rfzDdzcrMyrEbwpKPtKtcK0vYk4/gyqUWPj6A+PfWF8PSjL4A+A7Ty5zl3QIssAcOCM=
X-Received: by 2002:aa7:8709:0:b0:572:2189:84ef with SMTP id
 b9-20020aa78709000000b00572218984efmr37192850pfo.28.1669723393830; Tue, 29
 Nov 2022 04:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20221129033230.255947-1-guoren@kernel.org> <20221129033230.255947-7-guoren@kernel.org>
In-Reply-To: <20221129033230.255947-7-guoren@kernel.org>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 29 Nov 2022 12:03:02 +0000
Message-ID: <CAAYs2=hOY+ib_OYwUfnM10kwyqte7C7=efTL00VkVKHWM9HbAw@mail.gmail.com>
Subject: Re: [PATCH V4 6/7] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 support
To:     guoren@kernel.org
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, andy.chiu@sifive.com, mark.rutland@arm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

<guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8829=E6=97=A5=E5=91=A8=
=E4=BA=8C 03:33=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Song Shuai <suagrfillet@gmail.com>
>
> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
>
> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> register_ftrace_direct[_multi] interfaces allowing users to register
> the customed trampoline (direct_caller) as the mcount for one or
> more target functions. And modify_ftrace_direct[_multi] are also
> provided for modifying direct_caller.
>
> To make the direct_caller and the other ftrace hooks (eg. function/fgraph
> tracer, k[ret]probes) co-exist, a temporary register is nominated to
> store the address of direct_caller in ftrace_regs_caller. After the
> setting of the address direct_caller by direct_ops->func and the
> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> by the `jr` inst.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig              | 1 +
>  arch/riscv/include/asm/ftrace.h | 6 ++++++
>  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 1d0e5838b11b..2828537abfcd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -278,6 +278,7 @@ config ARCH_RV64I
>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-=
fpatchable-function-entry=3D8)
I noticed this cc-option uses the '-fpatchable-function-entry=3D8' to
judge if the compiler supports this option.
Should we keep up with the CC_FLAGS_FTRACE modified in ("riscv:
ftrace: Reduce the detour code size to half"),
or follow the parisc architecture to set the value as '1,1' in the
case of the CC_FLAGS_FTRACE is not constant.
```
./arch/parisc/Makefile:75:CC_FLAGS_FTRACE :=3D
-fpatchable-function-entry=3D$(NOP_COUNT),$(shell echo
$$(($(NOP_COUNT)-1)))
./arch/parisc/Kconfig:70:       select HAVE_DYNAMIC_FTRACE if
$(cc-option,-fpatchable-function-entry=3D1,1)
```
>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> +       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftr=
ace.h
> index 84f856a3286e..4539f10fea56 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -114,6 +114,12 @@ struct ftrace_regs;
>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>                        struct ftrace_ops *op, struct ftrace_regs *fregs);
>  #define ftrace_graph_func ftrace_graph_func
> +
> +static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, u=
nsigned long addr)
> +{
> +               regs->t1 =3D addr;
> +}
> +
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dy=
n.S
> index 466c6ef217b1..fef7c460f991 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -232,6 +232,7 @@ ENDPROC(ftrace_caller)
>
>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  ENTRY(ftrace_regs_caller)
> +       move    t1, zero
>         SAVE_ABI_REGS 1
>         PREPARE_ARGS
>
> @@ -241,7 +242,10 @@ ftrace_regs_call:
>
>
>         RESTORE_ABI_REGS 1
> +       bnez    t1,.Ldirect
>         jr t0
> +.Ldirect:
> +       jr t1
>  ENDPROC(ftrace_regs_caller)
>
>  ENTRY(ftrace_caller)
> --
> 2.36.1
>


--=20
Thanks,
Song
