Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD1D6F122D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345451AbjD1HOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjD1HOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:14:48 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1E32106;
        Fri, 28 Apr 2023 00:14:46 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so7369792276.0;
        Fri, 28 Apr 2023 00:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682666086; x=1685258086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjD4LdSVifv1y48NP8NbjYeH/jMSNzvdhViXyXR12O0=;
        b=CmddwR/COD4j5JCvj5y8CuVO2dPW87N9Q9DKsOWuSog2R5gV8dD7wnAaSe61NuISW8
         g4mnzESEGxadmaUOBs8uXDoZAIk6NmPnhsKIHTLdLofh7gvFydlscvMhqBtt5qzxyThc
         p0bTHZaBb/lwcHMJL1RMdau5CNEkjs633qacSYQbAsHfA9v6OR3GD9VIoZBs0ZFpFalT
         Tsbj7UP96SG9FawCqe2ZSdPqeMER3oETtScicg2RnPG1nwYZO8KGmvoknut8soa6z11v
         jqpUJxjgIspsfTZsPeneWQioycC+C4DAqtVFng50LIjF0js0r7hIysXeQfQStlnMxCQt
         5+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682666086; x=1685258086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjD4LdSVifv1y48NP8NbjYeH/jMSNzvdhViXyXR12O0=;
        b=hZ9JEX40JAazXUZcOhflPSKQ2u/aT0//3MhmylpJFhrOjqJjMHMpKsc07yj2hP6Sy4
         7XD4R5QE577RTFCEHkGWrHh0XS7ph7FZh7d5LlJj/XuC0yJkAvtWNMUj1lWKAXvF/FQK
         AW5aSUiw5Kmdk2zMTz5NfWJarnr9Q0Q8g0c+VJ+8Y2XVs7DZlnlYSV2XbONhlEoFGZXJ
         xvbAKH/LBJoeecnOQ8elyrx7dBggpsA8Ee2uUrGQZ0xSPjkpnTzTGR0ma8tekEMp9W1V
         xBgzHL87MnqUeGUhbOWdaFJCYuz5OVB0iD+YEHn1WVXNjLnewZgPk58OIZra9KUQVnch
         ujZw==
X-Gm-Message-State: AC+VfDy5e6GUNUYgqHK9Q7I4/2QikkRlLWnqWHCOwHa13FQ/VzUwzIot
        JxlSP/QtWSj4x53S/Sdspo8Zc1F96rRpkptTbl5ucjb9hvYNekNs
X-Google-Smtp-Source: ACHHUZ7qAMCPC1Nx0vUJvR5mwjHg24fYFqQIBkUzZFfa6v3Jnl36hIANECVAnaR8WbC2XBxcVj8WMq85y+iUxhLGMts=
X-Received: by 2002:a81:4dc6:0:b0:54f:85bc:a808 with SMTP id
 a189-20020a814dc6000000b0054f85bca808mr6394159ywb.16.1682666085657; Fri, 28
 Apr 2023 00:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOd03yRAmPULzi8fYTnukCpRPHa1Zsv5ZFFeQRcQ7B1abQCGqA@mail.gmail.com>
 <20230427150332.2978867-1-zhanggenjian@kylinos.cn>
In-Reply-To: <20230427150332.2978867-1-zhanggenjian@kylinos.cn>
From:   genjian zhang <zhanggenjian123@gmail.com>
Date:   Fri, 28 Apr 2023 15:13:32 +0800
Message-ID: <CAOd03yTc3+Sa4zsPQCu3dHiJfuUf-kOMxeUH6rm4u4Z6Hv2BQQ@mail.gmail.com>
Subject: Re: [PATCH v2] fix ___SYNC () build error when PROFILE_ALL_BRANCHES
 is enabled
To:     tsbogend@alpha.franken.de, rdunlap@infradead.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 11:05=E2=80=AFPM Genjian <zhanggenjian123@gmail.com=
> wrote:
>
> From: Genjian Zhang <zhanggenjian@kylinos.cn>
>
> compiler error (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110):
>
> {standard input}: Assembler messages:
> {standard input}:171: Error: found '(', expected: ')'
> {standard input}:171: Error: found '(', expected: ')'
> {standard input}:171: Error: non-constant expression in ".if" statement
> {standard input}:171: Error: junk at end of line, first unrecognized
> character is `('
>
> Expands ___SYNC() macros. However, 'if' statement will be wrong
> assembly.This Compilers report a lot of errors like the above.
> this problem is caused by the #define of if() in
> include/linux/compiler.h when CONFIG_PROFILE_ALL_BRANCHES
> is set. Move '.if' into quoted strings to fix it.
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> ---
>  arch/mips/include/asm/sync.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/include/asm/sync.h b/arch/mips/include/asm/sync.h
> index aabd097933fe..56a4f6f6cdef 100644
> --- a/arch/mips/include/asm/sync.h
> +++ b/arch/mips/include/asm/sync.h
> @@ -175,7 +175,7 @@
>   */
>  #ifdef CONFIG_CPU_HAS_SYNC
>  # define ____SYNC(_type, _reason, _else)                       \
> -       .if     (( _type ) !=3D -1) && ( _reason );               \
> +       ((_type) !=3D -1) && (_reason);                           \
>         .set    push;                                           \
>         .set    MIPS_ISA_LEVEL_RAW;                             \
>         .rept   __SYNC_rpt(_type);                              \
> @@ -192,13 +192,14 @@
>  /*
>   * Preprocessor magic to expand macros used as arguments before we inser=
t them
>   * into assembly code.
> + * In addition,'if' cannot be enabled.
>   */
>  #ifdef __ASSEMBLY__
>  # define ___SYNC(type, reason, else)                           \
> -       ____SYNC(type, reason, else)
> +       .if     ____SYNC(type, reason, else)
>  #else
>  # define ___SYNC(type, reason, else)                           \
> -       __stringify(____SYNC(type, reason, else))
> +       ".if"   __stringify(____SYNC(type, reason, else))
>  #endif
>
>  #define __SYNC(type, reason)                                   \
> --
> 2.25.1
>

This patch does not take into account the situation that CPU_HAS_SYNC
is not set. I will revise it later.

Thanks.
--=20
Genjian
