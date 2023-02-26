Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6D6A2D12
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBZCHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBZCHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:07:34 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE486149B5;
        Sat, 25 Feb 2023 18:07:26 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id i202so1214166ioa.3;
        Sat, 25 Feb 2023 18:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nRJ1z3jciefZNx3Ldo4FLT1Lt6iH/IsHxfrZc22u8pM=;
        b=ARn/FqWiLWDklDuOxv4z0ENc2cOrqo8sjAh7pe4JNIL5ckb4Dmirbma/DIQpV6FgWI
         vspBHGYyGeRyYtra9OoGLy5RvBHJ/ziwxES0UFNSX8uPfxrgFfRnkoZgandDzS5zD8XN
         5vTkxKj9DtFLZB8yk5Du918KAjF9nxgqUXG0kRzflxaIwifTD4aNhsclaUuXkU2bys7d
         H+HJJ6SoqtYuxT1n3qHst5otzCsfUIhXvwBqoNQENR3+c2W+9xBS+3UGoMvA6Fcb/47v
         enVDd4lMFq7jh4QN/QOROFRaqMf3BnvOj0GdLbK2mEy4sGFjye31aHeqdbmSUY5IaZq5
         TjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRJ1z3jciefZNx3Ldo4FLT1Lt6iH/IsHxfrZc22u8pM=;
        b=Dx3C+UWJMXCbiDe0IhtxgyJSJiQbr6gssYDnDi+SZUtICnrbwX1NfVk4P4ptvsNXKM
         Dl4hC4lpR8qMsHuijDjUt/I4BUN7D/mqMb16BqJwoa+HB9vrw6nEq6mTkIr+Ls/v7dU7
         LHoSzhlw4uDmV4+BUN+PORB2npqNvhw1gtB3GCPfYb2HoQ3+A4sdXhBga5/gu62i40C7
         +DRf0d0AhJu8Rh8XVBjDmao4FqMsnDfSLGzu9iQp0Xl7H3Lz88Dj1aT5Buj3iLXqfwqz
         KFj/AzIftuN3sEEfo538oxBMSc0yoLPy423/Eou2DqMggsrDSNB6TLRZHTDUWxiFuNAt
         x41A==
X-Gm-Message-State: AO0yUKUOTwlICPnrt0YsWH5oJBwKnjhwUdqvFg2eENQrqrbwcZc+w2lN
        770LRdbIBOIc0+BtHQnvvKyKN4SiK3ysb5BKSp8=
X-Google-Smtp-Source: AK7set9f4ONz9ZuBmLnWrWUYfyjh4pV2YDotsGmR7AzhTJk+CksQhdt1zTc60VpD70DgyfhTPbMbHIn9BKYkqlJtk78=
X-Received: by 2002:a6b:140a:0:b0:73a:397b:e310 with SMTP id
 10-20020a6b140a000000b0073a397be310mr3904203iou.0.1677377246113; Sat, 25 Feb
 2023 18:07:26 -0800 (PST)
MIME-Version: 1.0
References: <20220329025737.2375176-1-yang.yang29@zte.com.cn>
In-Reply-To: <20220329025737.2375176-1-yang.yang29@zte.com.cn>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 25 Feb 2023 21:07:15 -0500
Message-ID: <CAEdQ38E7QKZddcZGFWBRB8AFu9CEBsiKxDrC4aG5nwT9p-PZvg@mail.gmail.com>
Subject: Re: [PATCH] alpha: replace NR_SYSCALLS by NR_syscalls
To:     cgel.zte@gmail.com
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, firoz.khan@linaro.org,
        ematsumiya@suse.de, rostedt@goodmis.org, mingo@redhat.com,
        yang.yang29@zte.com.cn, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 10:58 PM <cgel.zte@gmail.com> wrote:
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Reference to other arch likes x86_64 or arm64 to do this replacement.
> To solve compile error when using NR_syscalls in kernel[1].
>
> [1] https://lore.kernel.org/all/202203270449.WBYQF9X3-lkp@intel.com/
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  arch/alpha/include/asm/unistd.h | 2 +-
>  arch/alpha/kernel/entry.S       | 4 ++--
>  kernel/trace/trace.h            | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
> index 986f5da9b7d8..caabd92ea709 100644
> --- a/arch/alpha/include/asm/unistd.h
> +++ b/arch/alpha/include/asm/unistd.h
> @@ -4,7 +4,7 @@
>
>  #include <uapi/asm/unistd.h>
>
> -#define NR_SYSCALLS    __NR_syscalls
> +#define NR_syscalls    __NR_syscalls
>
>  #define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_OLD_READDIR
> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index e227f3a29a43..966400b925a5 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S
> @@ -454,7 +454,7 @@ entSys:
>         SAVE_ALL
>         lda     $8, 0x3fff
>         bic     $sp, $8, $8
> -       lda     $4, NR_SYSCALLS($31)
> +       lda     $4, NR_syscalls($31)
>         stq     $16, SP_OFF+24($sp)
>         lda     $5, sys_call_table
>         lda     $27, sys_ni_syscall
> @@ -585,7 +585,7 @@ strace:
>         ldq     $21, 88($sp)
>
>         /* get the system call pointer.. */
> -       lda     $1, NR_SYSCALLS($31)
> +       lda     $1, NR_syscalls($31)
>         lda     $2, sys_call_table
>         lda     $27, sys_ni_syscall
>         cmpult  $0, $1, $1
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 07d990270e2a..7ad8324db192 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -25,7 +25,7 @@
>  #include "pid_list.h"
>
>  #ifdef CONFIG_FTRACE_SYSCALLS
> -#include <asm/unistd.h>                /* For NR_SYSCALLS           */
> +#include <asm/unistd.h>                /* For NR_syscalls           */
>  #include <asm/syscall.h>       /* some archs define it here */
>  #endif
>
> --
> 2.25.1
>


Thanks for the patch! This was included in my pull request today and
is now upstream in Linus' tree.
