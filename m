Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937D4723C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbjFFI7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFFI7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:59:41 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E1818E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:59:39 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bad97da58adso7375905276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686041978; x=1688633978;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6kW28rRS95PBT40ZyGvD53ULubXonpBS0T08hlvYzY=;
        b=dPR7PAcBEbq14AyijUdKPeY9aopH5oxf/XU5xNmYSoOyjYqERl9cm3yey7nh0m1wiS
         1fQw4PTKPUr1LJE40ZZd38eOjy07GYhYSuKlqSPiw9DGP2NV1Aew+xNyenr+gJKvfyEv
         Y673QHzNp/7uVnjx13QJvFKmESHWi+kGU/7hSOalAPdHTdKRkE5GkH2WPHuEeLevB7hY
         fg6S/VW2ocpOzz2HcK6UtqUmuV68T5KMZHULgMQU8YeFJ/522xFXPPa4x+MmRNG7uo3B
         Ir72yEqU5vuJXbw10qlB+t+kNprQd5pxm7t7+R4QcijkqpA6eNRyCE7+kDOarN9nzyr+
         ZNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686041978; x=1688633978;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N6kW28rRS95PBT40ZyGvD53ULubXonpBS0T08hlvYzY=;
        b=J+cJmtPnb3NgcxxAQGPKnli+3AWHAMCENishhA5YsvFAZxaC+bO9R7EXj4S0FRMv+a
         B4lgjZQWjkcOSeDSrtF1J6jgRx4aKCK8cj21J+X74oxHDcyzrhn7LBRkJ6dAlUJAx2hW
         05K6d93FR8IfTHkrtbZFF85gsDLtfGyW0qSRvvppFp5gZMQcRQwJaH9oKXn0g4zFFrti
         4YMj/G51B1EQxFPQhvbWjRCWTDbR1ErjZvPZPyy6H+iV1y9FpgWz9+UdRpUo5Hy1riem
         jUAYBli8nmVvWcJmFZTm3V0mLHrqhd9TJRc+b3IkRtqTR5lXnxlldap8wXTowQezvUFn
         qZUA==
X-Gm-Message-State: AC+VfDxvWeC7EL7TLhdC5pFBFih0F/F5t/Af4v1rpSUcX7+z/vMJc8Ex
        mlb21JCNd/yM8+zzG4t97aX25ke4RbY=
X-Google-Smtp-Source: ACHHUZ6AeR7qesANdIDtp2lhgxb5Ewp8VMikOiupHZ9Q+qMTh31yK+rF2gXmNDrRFS8peWohfho2dQ==
X-Received: by 2002:a25:c382:0:b0:bb3:b0ab:d626 with SMTP id t124-20020a25c382000000b00bb3b0abd626mr485746ybf.31.1686041978611;
        Tue, 06 Jun 2023 01:59:38 -0700 (PDT)
Received: from localhost ([203.221.142.9])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090ab88100b0024dfbac9e2fsm9010107pjr.21.2023.06.06.01.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 01:59:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 18:58:46 +1000
Message-Id: <CT5FZBY14ZM4.OYXBJNXQU9A2@wheely>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/signal32: Force inlining of
 __unsafe_save_user_regs() and save_tm_user_regs_unsafe()
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.14.0
References: <7e469c8f01860a69c1ada3ca6a5e2aa65f0f74b2.1685955220.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7e469c8f01860a69c1ada3ca6a5e2aa65f0f74b2.1685955220.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jun 5, 2023 at 6:58 PM AEST, Christophe Leroy wrote:
> Looking at generated code for handle_signal32() shows calls to a
> function called __unsafe_save_user_regs.constprop.0 while user access
> is open.
>
> And that __unsafe_save_user_regs.constprop.0 function has two nops at
> the begining, allowing it to be traced, which is unexpected during
> user access open window.
>
> The solution could be to mark __unsafe_save_user_regs() no trace, but
> to be on the safe side the most efficient is to flag it __always_inline
> as already done for function __unsafe_restore_general_regs(). The
> function is relatively small and only called twice, so the size
> increase will remain in the noise.
>
> Do the same with save_tm_user_regs_unsafe() as it may suffer the
> same issue.

Could you put a comment so someone doesn't uninline it later? Marking
it notrace as well would be sufficient for a comment, if that works.

Thanks,
Nick

>
> Fixes: ef75e7318294 ("powerpc/signal32: Transform save_user_regs() and sa=
ve_tm_user_regs() in 'unsafe' version")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/signal_32.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal=
_32.c
> index c114c7f25645..7a718ed32b27 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -264,8 +264,9 @@ static void prepare_save_user_regs(int ctx_has_vsx_re=
gion)
>  #endif
>  }
> =20
> -static int __unsafe_save_user_regs(struct pt_regs *regs, struct mcontext=
 __user *frame,
> -				   struct mcontext __user *tm_frame, int ctx_has_vsx_region)
> +static __always_inline int
> +__unsafe_save_user_regs(struct pt_regs *regs, struct mcontext __user *fr=
ame,
> +			struct mcontext __user *tm_frame, int ctx_has_vsx_region)
>  {
>  	unsigned long msr =3D regs->msr;
> =20
> @@ -364,8 +365,9 @@ static void prepare_save_tm_user_regs(void)
>  		current->thread.ckvrsave =3D mfspr(SPRN_VRSAVE);
>  }
> =20
> -static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontex=
t __user *frame,
> -				    struct mcontext __user *tm_frame, unsigned long msr)
> +static __always_inline int
> +save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *f=
rame,
> +			 struct mcontext __user *tm_frame, unsigned long msr)
>  {
>  	/* Save both sets of general registers */
>  	unsafe_save_general_regs(&current->thread.ckpt_regs, frame, failed);
> @@ -444,8 +446,9 @@ static int save_tm_user_regs_unsafe(struct pt_regs *r=
egs, struct mcontext __user
>  #else
>  static void prepare_save_tm_user_regs(void) { }
> =20
> -static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontex=
t __user *frame,
> -				    struct mcontext __user *tm_frame, unsigned long msr)
> +static __always_inline int
> +save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *f=
rame,
> +			 struct mcontext __user *tm_frame, unsigned long msr)
>  {
>  	return 0;
>  }
> --=20
> 2.40.1

