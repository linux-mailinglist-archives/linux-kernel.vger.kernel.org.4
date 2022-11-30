Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B8563CD7E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiK3Cs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiK3CsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:48:24 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDBA2E9F5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:48:21 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id n205so17435788oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=keXd344sIL2Axw294Ojzkf8vMy22zfN9agu+NIErakc=;
        b=q4h7YuMITHQxrW7ZuaQ5CLlmfdNHlj7tkZnyFGRJ79wAUoewwbZndW8+BaQ1gcu1gh
         QsH6IyUquRSagctknw2PpehMpel5+mogcX84p1/1PRCOf3jR1pYc9f11tkxUTaz3nJw2
         pc6+03jI0dOCB3402JK509Hhc0Fyb7567c1aZKMMIcvY9UHcYNENo+U1XiyL7AwGH75K
         5JbbUvYujwKmDW8F+uZWgxl20X2uVTTdwOTrhqjZly1FTHwcOUc3mgzOnj5CdbFqWDQr
         9tgvEKKwVXArDfeRCAm90yy9nFztRVXwMKTyDun3H7+7s8syW3Sn+ALJBH6mYifPNzye
         oO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=keXd344sIL2Axw294Ojzkf8vMy22zfN9agu+NIErakc=;
        b=k1I+tNmOkvU7TibWME+RJIMixfgfYibmfvuReZyoY1bSS3LBOuzskrQfXttUeVnZmP
         x6dnLabqCQDwGbkXeMMycIRhpzkCcddHk5f0d13f9Cw+wDxjnilubozRwzgOSRW157Kl
         YSHuE7V/guWw2JeIOE8Sv/H4Oh55Ry/5NWhz0yJQ2SNOGZ9UxPrb1KF1BU5I8fDVaZfu
         ZLx3DYpNytfbZQ9vNbfuEslnGTS5xFEO3F+tBLgRCN79DLZQaWBFS1jMhhHEsKC5kFcE
         zIiNlDflZeQRY6C/PUwV95GyL6twfsDzskxY5RaMHVSMuPVbrURQ8b2CbHH+FD6IvIXO
         orWA==
X-Gm-Message-State: ANoB5pkLFOHO+u3qu2X6CYBnSy9brl6Y0/B+SgjdqBi/M9FkraNqHZEF
        z2jYrciOj3sYWCMpX3tY/dfM0KR7dC/n9RMTKZWhHPV7
X-Google-Smtp-Source: AA0mqf4XDuK51ylnQ1qDeOE5aq2PPrJbmFP2lmvGRlVb9l0st8hTdzUCZJMG5GqoHJsxhY2CSjXDfkK+7/IKWCIili4=
X-Received: by 2002:a05:6808:1c1:b0:34f:d32d:cad5 with SMTP id
 x1-20020a05680801c100b0034fd32dcad5mr30266295oic.262.1669776500901; Tue, 29
 Nov 2022 18:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20221130023515.20217-1-palmer@rivosinc.com>
In-Reply-To: <20221130023515.20217-1-palmer@rivosinc.com>
From:   Khem Raj <raj.khem@gmail.com>
Date:   Tue, 29 Nov 2022 18:47:55 -0800
Message-ID: <CAMKF1srMj5aH4_+iwbFuu+AEgyyz85y+UPEszUGeQ7U=u19R3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Align the shadow stack
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     jszhang@kernel.org, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer

On Tue, Nov 29, 2022 at 6:36 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> The standard RISC-V ABIs all require 16-byte stack alignment.  We're
> only calling that one function on the shadow stack so I doubt it'd
> result in a real issue, but might as well keep this lined up.

Is 16-byte alignment required on rv32 as well ?

>
> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/riscv/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index be54ccea8c47..acdfcacd7e57 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -206,7 +206,7 @@ static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>   * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
>   * to get per-cpu overflow stack(get_overflow_stack).
>   */
> -long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
> +long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)] __aligned(16);
>  asmlinkage unsigned long get_overflow_stack(void)
>  {
>         return (unsigned long)this_cpu_ptr(overflow_stack) +
> --
> 2.38.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
