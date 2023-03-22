Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C676A6C53B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCVS0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjCVS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:26:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D4865059
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:25:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13so19335196pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679509557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xai25ViACOhtMbP/9A/HIC69Te+6jb14im4nmgBreX0=;
        b=Nc7bqPWvvVP0Fh9GRUREatEuPhbNWcj8ydyJq6p7WhnKTmZsmINp40U8jm2U/D3eOh
         GiADNrvpDW1src3wBD86k8hybLw++0LHdLBlze0Q290ZO1ycLMYXpjqhF0bC849Amhtk
         Uy0gNTTczAqnmq7Ne1eUnCmgjRAczfqeQ58RKE9Z1Dbo8WYhXCE+35mHwpNTZjinRv7Z
         SvFY91A1LyC+CNVJab3PMehak5rGBLhjGTsCzg52VkGZ8uMK06Y5GA1JlP2dh0NN6NWH
         L5Jzlk3GH1BS4NTePFlNBmFvEFZSn5SfhLcK85z0+yzixjDvudD4Wt6pqVVnBBIsUYXI
         dcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679509557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xai25ViACOhtMbP/9A/HIC69Te+6jb14im4nmgBreX0=;
        b=2xtMnsaGuCAs+Tf3gKNdx+FoBpAAp1Ti18vs1FIDHVQ1KyJWtZ3JXCBCKy1krg0NJd
         iFnD9u2Orak7A0SMQ/vi8SQ5AITEOSiobNI3McWcogf2ywMxSihEtspzprHjZUgfwLmX
         kOIU5q37kRKufqUMJVPlIHgsnb4UN3gmNvS6tARV4x2onKiBMMiPzzPTVfcd7s2yfnOz
         ok3a/0zVOpZMuTVL5F+s8qzUp/OaRQ9x99sQfmWbpaopkeo7WuxR6SkfYMQEynaIonM3
         mrwUZeiW/tPf58RJv/w6HQCcsnOT7JvByESM3hiutRiNH3y0bZvurr7Tsvj4vGyzx7dM
         fI/A==
X-Gm-Message-State: AO0yUKWsuMIpQh95Jo7Ks5C0ymtesZmmCPZM1ZpBnpI5+NBb1gB/+ctM
        M2h/VZo/IE5bqqZohIgTSeRFzsrjTxR1th8dp8YHqw==
X-Google-Smtp-Source: AK7set/ZMXJixIFC4D/KWjt5E7Yb69EPs9KtjzG+BYb//151Eeugg7QbDH72EBo41HILsUMiYkKai/KWyETz2jWK8JA=
X-Received: by 2002:a17:902:7b8b:b0:19a:82a2:fcf9 with SMTP id
 w11-20020a1709027b8b00b0019a82a2fcf9mr1399015pll.2.1679509556719; Wed, 22 Mar
 2023 11:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230215143626.453491-1-alexghiti@rivosinc.com>
 <20230215143626.453491-2-alexghiti@rivosinc.com> <4a6fc7a3-9697-a49b-0941-97f32194b0d7@ghiti.fr>
 <877cw7dphf.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <877cw7dphf.fsf@all.your.base.are.belong.to.us>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 22 Mar 2023 11:25:45 -0700
Message-ID: <CAKwvOdk0Lr-9gt0xAKvkcwA53+Wy8oeYQo1RJ7XH-LKCCURQCQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] riscv: Introduce CONFIG_RELOCATABLE
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, nathan@kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 7:58=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Alexandre Ghiti <alex@ghiti.fr> writes:
>
> > +cc linux-kbuild, llvm, Nathan, Nick
> >
> > On 2/15/23 15:36, Alexandre Ghiti wrote:
> >> From: Alexandre Ghiti <alex@ghiti.fr>
> >>
> > I tried a lot of things, but I struggle to understand, does anyone have
> > any idea? FYI, the same problem happens with LLVM.

Off the top of my head, no idea.

(Maybe as a follow up to this series, I wonder if pursuing
ARCH_HAS_RELR for ARCH=3Driscv is worthwhile?)

>
> Don't ask me *why*, but adding --emit-relocs to your linker flags solves
> "the NULL .rela.dyn" both for GCC and LLVM.
>
> The downside is that you end up with a bunch of .rela cruft in your
> vmlinux.

There was a patch just this week to use $(OBJCOPY) to strip these from
vmlinux (for x86). Looks like x86 uses --emit-relocs for KASLR:
https://lore.kernel.org/lkml/20230320121006.4863-1-petr.pavlu@suse.com/
--=20
Thanks,
~Nick Desaulniers
