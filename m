Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE1C747280
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjGDNSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGDNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:17:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CDD1737
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:17:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3143798f542so2252520f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688476613; x=1691068613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTZLLHkFTBtSMOJnP8CLim0/TijHiGLdbtLujLrTJFk=;
        b=a8BjrrHYfZMyz6yrmzXkUQ8MdIVci4LJxe4cdhZUl/5LFBPZ5PEzheK1kIBrgpRGWg
         DepKSRrGwybfjUMLKtQ1DzLD4er/RC9rEEilDlaNE9uKSx+iqFITmKcrPtHXWVlTT6Pm
         96XI2v6C2G+crKr1K1YVSLYiB2CnYblHXYqinyVdfh53SCM8TzMjHxZpvgi+KHiHzKDq
         XrjTFmeV8qE3mcOIYZDJnxp+vZsPi5AoSSXosEdRDkQc6SrbOonIGn1sXNPQPFdGl5ET
         yyPNLSaezl7UTju75iKCyfC+8y1/Af+9r8i/C+B3qOjkebNRw3pHCaRAC2LetQKTWlW3
         FHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688476613; x=1691068613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTZLLHkFTBtSMOJnP8CLim0/TijHiGLdbtLujLrTJFk=;
        b=eJosVGg1VUJyGFufjOQjENIdmEVaJVFJcVDmd4fO+LZdAxWSk8tYYNMiXMNc0YJI7G
         EWS5gXoxJSy40wlg7f/1oYMjsqJcA+L1DDK7RHr4d+RIU7CC7XD6P9YHbIVmw8P72B//
         DLJof05FrstVdKZdV5j/Y9xAtIak+/tGo6bVax8AvTKjVxbQKtRsE0xEfgmppZafKsSe
         Yynqh8dk76IlZ5pMHg+vhIiQJJXNJ7fnNvyjrgsvK8Qy2FwjXL//Hs/lggL/P5n6d+/a
         Qh7zrMdywgeN+b1BI6ictvP95D8epTGCdx0EQfn/6erElWLNZe1aWvK6CspVM0j0XeDE
         Qo5Q==
X-Gm-Message-State: ABy/qLYocilgAiTWtKDZqstl5a32FeqaeECL07rKqX8XyWNU4pX0JH+d
        2Fs2oDoKriRqAaqmLRVd1PKAcMdtts/Xcxiz01sIiw==
X-Google-Smtp-Source: APBJJlH7VHDukA6SBACWsBQtjJa6BPWnsXvLmaA/dbhGPDLmaW4rqT8OV4z/YSjBBO/sGZmYtQEAQuxDu+EACIuBDyw=
X-Received: by 2002:a5d:670a:0:b0:313:eadf:b82d with SMTP id
 o10-20020a5d670a000000b00313eadfb82dmr9469272wru.69.1688476613446; Tue, 04
 Jul 2023 06:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230704121837.248976-1-alexghiti@rivosinc.com> <20230704-emblem-rubble-e4a3a87cb98e@wendy>
In-Reply-To: <20230704-emblem-rubble-e4a3a87cb98e@wendy>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 4 Jul 2023 15:16:42 +0200
Message-ID: <CAHVXubikF36Tc19vv9osVz3ZvEyKXk-+74YBpPAZQpSt+vFkQw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Start of DRAM should at least be aligned on PMD
 size for the direct mapping
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> Hey Alex,
>
> On Tue, Jul 04, 2023 at 02:18:37PM +0200, Alexandre Ghiti wrote:
> > So that we do not end up mapping the whole linear mapping using 4K
> > pages, which is slow at boot time, and also very likely at runtime.
> >
> > So make sure we align the start of DRAM on a PMD boundary.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Obviously correct me if I am wrong here, but was this not reported by
> Song Shuai as a regression?
> Accordingly, should this not have Reported-by, Closes/Link & Fixes tags?

Sure we should add the reported by from Song as he did the proper report :)

Reported-by: Song Shuai <suagrfillet@gmail.com>
Closes: https://lore.kernel.org/linux-riscv/20230625140931.1266216-1-songsh=
uaishuai@tinylab.org/

And yes sorry, I thought it was there before, but it was actually when
I retrieved the first 2MB that the problem appeared, so:

Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")

Thanks!

>
> Cheers,
> Conor.
>
> > ---
> >  arch/riscv/mm/init.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 4fa420faa780..4a43ec275c6d 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -214,8 +214,13 @@ static void __init setup_bootmem(void)
> >       memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> >
> >       phys_ram_end =3D memblock_end_of_DRAM();
> > +
> > +     /*
> > +      * Make sure we align the start of the memory on a PMD boundary s=
o that
> > +      * at worst, we map the linear mapping with PMD mappings.
> > +      */
> >       if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> > -             phys_ram_base =3D memblock_start_of_DRAM();
> > +             phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;
> >
> >       /*
> >        * In 64-bit, any use of __va/__pa before this point is wrong as =
we
> > --
> > 2.39.2
> >
