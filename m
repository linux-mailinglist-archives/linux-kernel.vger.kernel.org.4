Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0EB6CEC33
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjC2OxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjC2OxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:53:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D5136
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:52:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l12so16012686wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680101575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2kmo0aenMDSgvw0VfC+Yjgx7r7yEQ3UFvZP5QHKIFU=;
        b=2AX6WT151XrxxKQ9+KZHBNPV0OKNUZqklMPvJ36VJq9J3TuOH8OV8pTmqS9WA/lBIZ
         fFjAMYfcPxG8VZ/ozr3H6SR/ckhvHEIGfk4SrzK1MAD3PEVvf5idTnEHFAY6o8TnBvL4
         F39elSu+TIpfZ4LyV6FX3/zyPkTvaG/66tZxHkwqMmwInLZEbEdQrMbbrpLuNQ6YC/3z
         fl4ForUJSR2MqgC7/PbT2lQoIr+MWtZS3mkaRITA+tVFU+uOStpSTnw1HsF9GzvnNVIA
         NJXB4pb+gH0+ApT++xs6D3QtTr4nV0GuyXY9BkXUWz4wTr52ilLrBe86Jho2QAG3/vft
         QsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2kmo0aenMDSgvw0VfC+Yjgx7r7yEQ3UFvZP5QHKIFU=;
        b=zJcsJdkuIpqwjU5PQJqc+c/6rOlHNnc45E7OFQlQ00izusWM4FgIY16DztkhkSI73Q
         thpAxPgKz++EvfuuFxhoRHCsJWcB3BkhhpXPTXK6f6GwSrbn8FN984jqOJmZUErHUUW/
         sn89sHA4AmgycH/kRAOJk6D4mFNM7J/4xAUmxxkiVLPcpH/gpeeq/FUfeSvcBvaByXEJ
         q1dwGiFeSpUqXxYdGo6anitpKjaoVsSaiabIXW5GCcO9poRUcrLG1yyZzwRw2UKZrDQO
         15GcQtTPV4eO8nnVOT6LPCYI0mjT//X9e4yLdnnEvCqL2YivBggs4VjznElhEntYTJdc
         bbnA==
X-Gm-Message-State: AAQBX9eL2bBDvHTS7fMzZ/MsDZxWyyE0nPdJGJDGr8PSH6U23ngEEtQY
        4ygA2Uv+U4wOh7VmXLoVbPzNxeUnqAWYmScNSZ/FZw==
X-Google-Smtp-Source: AKy350YibrgJqYb/G35x+FrqrJN2n0PzT7ee4etzLgFgZl3mXcWrfWIyeg9q9WE/eraWA5q1adz/eOCiZYh4p396ZL8=
X-Received: by 2002:a5d:6606:0:b0:2de:9905:a46e with SMTP id
 n6-20020a5d6606000000b002de9905a46emr3109552wru.13.1680101575731; Wed, 29 Mar
 2023 07:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230329081932.79831-1-alexghiti@rivosinc.com>
 <20230329081932.79831-3-alexghiti@rivosinc.com> <179c38d6-4298-4a16-b0d7-8aee49a91f58@spud>
In-Reply-To: <179c38d6-4298-4a16-b0d7-8aee49a91f58@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 29 Mar 2023 16:52:45 +0200
Message-ID: <CAHVXubh9t7VuM337Br-4y7zJp1msr6+bAtr1eVLc+P50V9Bikg@mail.gmail.com>
Subject: Re: [PATCH -fixes v2 2/3] riscv: Do not set initial_boot_params to
 the linear address of the dtb
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 4:37=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Mar 29, 2023 at 10:19:31AM +0200, Alexandre Ghiti wrote:
> > early_init_dt_verify() is already called in parse_dtb() and since the d=
tb
> > address does not change anymore (it is now in the fixmap region), no ne=
ed
> > to reset initial_boot_params by calling early_init_dt_verify() again.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/kernel/setup.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 542eed85ad2c..a059b73f4ddb 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -278,10 +278,7 @@ void __init setup_arch(char **cmdline_p)
> >  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
> >       unflatten_and_copy_device_tree();
> >  #else
> > -     if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> > -             unflatten_device_tree();
>
> Silly question maybe, but since it isn't explicitly mentioned, the
> XIP_FIXUP bits no longer matter?

The XIP_FIXUP is only needed when translating virtual to physical
addresses, but that does not mean I did not break it, I haven't
considered XIP at all...

> Also, in related news, I assume you don't have a QEMU setup that can do
> boot an XIP kernel?

I haven't booted a XIP kernel for a long time now, here are my notes
from that time:
https://github.com/AlexGhiti/alexghiti.github.io/blob/main/xip/XIP.md

>
> Cheers,
> Conor.
>
> > -     else
> > -             pr_err("No DTB found in kernel mappings\n");
> > +     unflatten_device_tree();
> >  #endif
> >       misc_mem_init();
> >
> > --
> > 2.37.2
> >
