Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB496F8856
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjEESCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjEESCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:02:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF71C160B1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:02:38 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643a1fed360so622514b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683309758; x=1685901758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+y7orr2WYnU2wxLyQBDVL7NcQ3meJkrWwS+TlRo/5k=;
        b=59JTMX7SoHpxLlJllIJYKo4oaclguiHkyXzwm6YydSXIs4chAUJZ+3USTS+2XEm1Ws
         PJM7tdJf6Gqt2rTiQC4zwu0F1dI4ITzgIROuqFN5UjEzsbcI+DUrCe/JYWhG2qG7K7rX
         iEO9qWOJPMeQtH+MQEADgryvJpSSqx+MkuDMUXkbNeJXh7GgcF4rThiuMbyuUiIupKlQ
         DZygiac4UcrIhGuhwaBMsboTVDVOX76zGuZnC6vpDpy7faNVezd9jhmCrQn397UTYVBq
         ZqxZnvi5ZZExEFr1VLSXgMBTHd3Xysyind8f2rY+GPaQgyruLWUsI8okgMKtqs8Mo/he
         XHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683309758; x=1685901758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+y7orr2WYnU2wxLyQBDVL7NcQ3meJkrWwS+TlRo/5k=;
        b=mFnLow9eKXNSkY+XVxOY2UWrEeFrEeQytllOjlIumuY08IPYx3CZaT6kansbg+sLee
         QtuAUvGxK4vBJaaGGNjv51rxTL23QxAkEmMgX/IMOQtdmKP8HMXO5iDv+fi6lVmZZo/Z
         RGi6nTGWrLD10kcIz/zdRiedZnThxZrI5mb46KYeJi7rExuiD4X7FpBsa4hvPZK1ELBO
         PcBPTNetTOaC88DxyurbSpHfO4drwxIqHbLkYs4FPHg2Ac7pWDLtHELLffvil0p71C2R
         TkRg0QMGC2JI1Nobmhbk0BYx52uQtditO2Fld/FU1a3BYnK4Io5zATZ18wu1reFl3mFj
         UcHg==
X-Gm-Message-State: AC+VfDzUy5Xq6P1SUFHxA/PBEGXDuCEfWU4Y6osMPhQx7Z5m/k27t0qC
        haEqOvbKwSz4iPu1Iu38KXVuaGnhglKXZoI1J+y88A==
X-Google-Smtp-Source: ACHHUZ562fRZ16BrsqpqruSW/hQByJUNF3Cf2ITXtNN/LXEqvSo1HkZpSrlm3dOU3erF18a65YShp1Q5ks9EwTFBXoM=
X-Received: by 2002:a05:6a00:181d:b0:640:f220:d16e with SMTP id
 y29-20020a056a00181d00b00640f220d16emr4005185pfa.11.1683309757324; Fri, 05
 May 2023 11:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <7cee0c83225ffd8cf8fd0065bea9348f6db3b12a.1682673543.git.houwenlong.hwl@antgroup.com>
 <CAKwvOd=zgjWdg2+_bg3QByh_2hve8yoKzCfEBZ5md+k8ytkqcQ@mail.gmail.com> <20230505061420.GB103506@k08j02272.eu95sqa>
In-Reply-To: <20230505061420.GB103506@k08j02272.eu95sqa>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 May 2023 11:02:25 -0700
Message-ID: <CAKwvOdkWt8FpqegyaGRNdF067dwwFEGze-nqR+yF=TA1FnTozg@mail.gmail.com>
Subject: Re: [PATCH RFC 16/43] x86-64: Use per-cpu stack canary if supported
 by compiler
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 11:14=E2=80=AFPM Hou Wenlong <houwenlong.hwl@antgrou=
p.com> wrote:
>
> On Tue, May 02, 2023 at 01:27:53AM +0800, Nick Desaulniers wrote:
> > On Fri, Apr 28, 2023 at 2:52=E2=80=AFAM Hou Wenlong <houwenlong.hwl@ant=
group.com> wrote:
> > >
> > > +config CC_HAS_CUSTOMIZED_STACKPROTECTOR
> > > +       bool
> > > +       # Although clang supports -mstack-protector-guard-reg option,=
 it
> > > +       # would generate GOT reference for __stack_chk_guard even wit=
h
> > > +       # -fno-PIE flag.
> > > +       default y if (!CC_IS_CLANG && $(cc-option,-mstack-protector-g=
uard-reg=3Dgs))
> >
> > Hi Hou,
> > I've filed this bug against LLVM and will work with LLVM folks at
> > Intel to resolve:
> > https://github.com/llvm/llvm-project/issues/62481
> > Can you please review that report and let me know here or there if I
> > missed anything? Would you also mind including a link to that in the
> > comments in the next version of this patch?
> >
> Hi Nick,
>
> Thanks for your help, I'll include the link in the next version.
> Actually, I had post an issue on github too when I test the patch on
> LLVM. But no replies. :(.

Ah, sorry about that.  The issue tracker is pretty high volume and
stuff gets missed.  With many users comes many bug reports.  We could
be better about triage though.  If it's specific to the Linux kernel,
https://github.com/ClangBuiltLinux/linux/issues is a better issue
tracker to use; we can move bug reports upstream to
https://github.com/llvm/llvm-project/issues/ when necessary. It's
linked off of clangbuiltlinux.github.io if you lose it.

> https://github.com/llvm/llvm-project/issues/60116
>
> There is another problem I met for this patch, some unexpected code
> are generated:
>
> do_one_initcall: (init/main.o)
> ......
> movq    __stack_chk_guard(%rip), %rax
> movq    %rax,0x2b0(%rsp)
>
> The complier generates wrong instruction, no GOT reference and gs
> register. I only see it in init/main.c file. I have tried to move the
> function into another file and compiled it with same cflags. It could
> generate right instruction for the function in another file.

The wrong instruction or the wrong operand?  This is loading the
canary into the stack slot in the fn prolog.  Perhaps the expected
cflag is not getting set (or being removed) from init/main.c? You
should be able to do:

$ make LLVM=3D1 init/main.o V=3D1

to see how clang was invoked to see if the expected flag was there, or not.

>
> The LLVM chain toolsare built by myself:
> clang version 15.0.7 (https://github.com/llvm/llvm-project.git
> 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)

Perhaps worth rebuilding with top of tree, which is clang 17.

>
> > Less relevant issues I filed looking at some related codegen:
> > https://github.com/llvm/llvm-project/issues/62482
> > https://github.com/llvm/llvm-project/issues/62480
> >
> > And we should probably look into:
> > https://github.com/llvm/llvm-project/issues/22476
> >
> >
>
> Except for per-cpu stack canary patch, there is another issue I post on
> github: https://github.com/llvm/llvm-project/issues/60096

Thanks, I'll bring that up with Intel, too.

>
> The related patch is:
> https://lore.kernel.org/lkml/175116f75c38c15d8d73a03301eab805fea13a0a.168=
2673543.git.houwenlong.hwl@antgroup.com/
>
> I couldn't find the related documentation about that, hope you can help
> me too.
>
> One more problem that I didn't post is:
> https://lore.kernel.org/lkml/8d6bbaf66b90cf1a8fd2c5da98f5e094b9ffcb27.168=
2673543.git.houwenlong.hwl@antgroup.com/

Mind filing another bug for this in llvm's issue tracker? We can
discuss there if LLD needs to be doing something different.

Thanks for uncovering these and helping us get them fixed up!
--=20
Thanks,
~Nick Desaulniers
