Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C16E6B65
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjDRRti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjDRRtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:49:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF88618A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:49:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2478485fd76so891230a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681840174; x=1684432174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlIxeOWy4t6oNXCBK7WY5wY7Tp+89AfzXIVcFw6Esng=;
        b=F0vmAUYI6vw0QV9Xa4+wYvpq5W5eNg7Dix3wyxxY1HNfGO9Es0s54210TBtEvrS13N
         ZURx54bjmjG0rp9avMzCSj7tfEGPvqO985LuiQeCoFLHp3DsHfci92tcG3c9GeHZwvnu
         VUH2ITP4bsjdzdmAp9OtqXgYEXPpe/WrOoT50e73Sky+MZPXxnLbJYmWkj5qRN0KPCSe
         SSqGVgTGtNB+HrMTkTsvVOjh+yJvL8DiQCbBEDPJ60+07H7b8mruQNaP684n7+PNhCWw
         RqbbxRI596LCql78trh9D3Ww6cOmGUX7nO5+kCtoLKg836bgZrFHE4st/eY6AkX0SRB9
         xFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840174; x=1684432174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlIxeOWy4t6oNXCBK7WY5wY7Tp+89AfzXIVcFw6Esng=;
        b=TbWmREqqCgd8wdBeSlKills4ms0hepgnMh83A2DV81dL9xG8RJ9IqYGYibjcPhyK/E
         Qk4UnwfE522WHuuxjVeAklkE26W9VN02Nz6aO9qwOpdhdPc7GY6CwajLCK1/HekNkKi2
         tUGqNfIRD7uS9H2fbQfDOmUMfvSBjiJxgaG+X3z+DnibVHoO1SMx7Z4xFntmqQF4+aP9
         hSb6l7OnVHnCUukSVXbPphZUwppoScy3AlhMpm0V1q8Tlq9VGbkb2/ik0Nb68CX3bbo6
         X/kvl504mlsJcGzQ4y/mjEbveQJfXQnBEuR/HX8uZstMx7QbXVxH0uF4ZoZjzPA288UW
         59dQ==
X-Gm-Message-State: AAQBX9ckdGa3ifNTavDA9McUuHyvd3DVMXxByDJhwqK/t0IT1yhoXdSl
        rm7acB/D1v9qeL8mvLc1RHhrrQbYBAQ+ZqaYzQPTIA==
X-Google-Smtp-Source: AKy350YrkykFuX9C6FMngEXAngaFBdSEPN7VQptU9h4a3p/UiakXeVMbpqehZB0WAdTS0ezf8ptktEt6I8iBC9XybPg=
X-Received: by 2002:a17:90a:4594:b0:22c:59c3:8694 with SMTP id
 v20-20020a17090a459400b0022c59c38694mr342535pjg.44.1681840174174; Tue, 18 Apr
 2023 10:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
 <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org> <20230330111523.4b98c8ce@gandalf.local.home>
 <20230330151826.GDZCWoQkQBj4BYbwWw@fat_crate.local> <20230330113127.3011e021@gandalf.local.home>
 <20230330160017.GEZCWyEXQVQZRBbYif@fat_crate.local> <CAKwvOdkULKxoifiVO4H4yomt1DHQxw0ntdO6QgMXk2BpM-urRg@mail.gmail.com>
 <CANiDSCvSDcQi2Qbwu8ddpPDAYehu2VoOB6x-v_PaMkWnwAGxYQ@mail.gmail.com>
In-Reply-To: <CANiDSCvSDcQi2Qbwu8ddpPDAYehu2VoOB6x-v_PaMkWnwAGxYQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Apr 2023 10:49:22 -0700
Message-ID: <CAKwvOdkbB4qpjZWRb+2CnOqxNgEY-JB4JvkXSFmOLB_1C=owqQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Simon Horman <horms@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 2:46=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> Hi Nick
>
> On Sat, 8 Apr 2023 at 01:22, Nick Desaulniers <ndesaulniers@google.com> w=
rote:
> >
> > Hi Ricardo,
> > Thanks for the patch!  Please make sure to cc our mailing list
> > <llvm@lists.linux.dev> for llvm specific issues.
> > scripts/get_maintainer.pl should recommend it, or you can find it from
> > clangbuiltlinux.github.io.  You can also ping me internally for
> > toolchain related issues.
> >
> > Start of thread.
> > https://lore.kernel.org/lkml/20230321-kexec_clang16-v5-0-5563bf7c4173@c=
hromium.org/
> >
> > On Thu, Mar 30, 2023 at 9:00=E2=80=AFAM Borislav Petkov <bp@alien8.de> =
wrote:
> > >
> > > On Thu, Mar 30, 2023 at 11:31:27AM -0400, Steven Rostedt wrote:
> > > > On Thu, 30 Mar 2023 17:18:26 +0200
> > > > Borislav Petkov <bp@alien8.de> wrote:
> > > >
> > > > > On Thu, Mar 30, 2023 at 11:15:23AM -0400, Steven Rostedt wrote:
> > > > > > > Make sure that the .text section is not divided in multiple o=
verlapping
> > > > > > > sections. This is not supported by kexec_file.
> >
> > Perhaps this is related to CrOS' use of AutoFDO creating .text.hot?
> > If so, it's probably more straightforward to straight up disable PGO
> > for kexec. See also:
> >
> > commit bde971a83bbf ("KVM: arm64: nvhe: Fix build with profile optimiza=
tion")
>
> It was indeed due to the AutoFDO, adding
>
> KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile-use=3D=
%,
> $(KBUILD_CFLAGS))
>
> to arch/x86/purgatory/Makefile
>
> It is definitely simpler than adding a linker script, but I am not
> sure if it is the correct way to fix this... Seems like splitting
> .text in multiple sections is an implementation detail of the compiler
> and the only way to force it is with a linker script... Or am I
> missing something?

I think with the use of `unlikely` GCC will put code in .text.cold, so
it is possible to trigger this using simpler means, but...

>
> Shall I send a new version with the KBUILD_CFLAGS ?

I still think the cflags approach is way simpler.  If someone tries to
use unlikely in purgatory: "don't do that."  Same for PGO.

>
> Thanks!
>
> >
> > > > >
> > > > > And?
> > > > >
> > > > > What is the failure scenario? Why are you fixing it? Why do we ca=
re?
> > > > >
> > > > > This is way too laconic.
> > > > >
> > > >
> > > > Yeah, I think the change log in patch 1 needs to be in this patch t=
oo,
> > > > which gives better context.
> > >
> > > Just read it.
> > >
> > > Why did it work with clang version < 16?
> >
> > I'll bet if we bisect llvm, we can spot what might have changed, which
> > may give us a clue on how to get the old behavior back; maybe without
> > the need for a linker script.
> >
> > Ricardo, how did you verify that your fix was correct? Surely we can
> > check using command line utilities without needing a full blown kexec
> > setup? If you can share more info, I can bisect llvm quickly.  If it
> > requires profile data, you'll need to share it, since CrOS engineers
> > still have not posted public documentation on AutoFDO as I have
> > repeatedly asked for.
>
> The simplest test is to run:
>
> $readelf -S arch/x86/purgatory/purgatory.ro | grep "] \.text"
> [ 3] .text             PROGBITS         0000000000000000  000002a0
>
> If there is only one .text section then that kernel will be load
> properly via kexec_file().

Got it, profile data will be required to reproduce then. If you can share.
--=20
Thanks,
~Nick Desaulniers
