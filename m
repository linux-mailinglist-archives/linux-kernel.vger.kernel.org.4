Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE70D70B34A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 04:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjEVCok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 22:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEVCoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 22:44:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C0CCD
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 19:44:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2554696544cso798236a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 19:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684723477; x=1687315477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWDVQ2z9KbD5MMR01fZ/nUn7dd6pMxIl5hvJiDhQHvo=;
        b=UaHBoDKS854frBK/ZKm/R5ak1GHqwLRbN0J3coRoqw85jDzTznan3Fh68I9q/yJBSW
         aq3sxoWgOF2YZcpy+SO29NYWNygI9aypJTjTDDuGIHXYy4Hmo6n0saTKnvLpgafSE+ti
         OFt6MoYdT+7QtRBcSKSL8crqbuTBkBxkcFmgj3OVi4G0STdrKDwEs2WMkxtJySmH2/RH
         PNsSHbRO6SQNegR7LYf2TbmKVPniZkq2Tki8kTRTlJ1qNvqoKMMLn69EiuQXlw8v85cu
         AySeapHgW/ZzU/NHYy8hDzQpXQJNmJ2l1W3LryPqDUZWKV4nEZTKFjqtU1MiBgjfAD/h
         ie1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684723477; x=1687315477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWDVQ2z9KbD5MMR01fZ/nUn7dd6pMxIl5hvJiDhQHvo=;
        b=hUWCA51zFvIY3Fm4VHmflbCexCwldBD+Nj/Ni+ERb7M53CPPqnTmIPbWx3J1p+Fcyp
         wmIXsxJwuRCERrctQiptfOQYBIt7+H5jcCvFET33+s0eNBQm5foiSqYN36fIJNoBArFh
         Qs1/WW0ZwZsIfu2GiNQe6eGp0qyzLcWLKjLHnxqDRju1LTND99LrLxb3h7KeeaU3j4vv
         8XqTp81GdrYHLinlIcSgMIYBBQPeFhQL2kEP0rsvgXOUlTzlCHIUlJYQG/yh51RddUro
         orzdJgChO/oSGJpOvokesqd6uhSU2Z8SmVCrtzBfL6/YZdrQg6EqO/v7U0HGH0hNoLui
         yVjg==
X-Gm-Message-State: AC+VfDxYz4Rs3On3AnQNoC0ibEEl7PSSANaX0yBFtz7xJ1cVH2wbvFNc
        17A5LS+mfXaD+Ea/I2OtP1ZOLRGyZvRp++07E/E=
X-Google-Smtp-Source: ACHHUZ6EDNCD2w7OjNMSQxovKBobBHr0OevXHMTn+rnQzJVWq4xGtQU/acDIDmYoH5whN3zuJBgRRH97gwDGQs2BrXQ=
X-Received: by 2002:a17:902:daca:b0:1ac:859a:5b5a with SMTP id
 q10-20020a170902daca00b001ac859a5b5amr13057446plx.0.1684723476850; Sun, 21
 May 2023 19:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230519102908.253458-1-suagrfillet@gmail.com>
 <9a274a44b61345e8aba747a44250c4d8@EXMBX066.cuchost.com> <20230519-clarinet-collar-ba2c0fa37e11@wendy>
 <20230519-roundup-legwarmer-e26b31db3123@spud>
In-Reply-To: <20230519-roundup-legwarmer-e26b31db3123@spud>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Mon, 22 May 2023 02:44:24 +0000
Message-ID: <CAAYs2=iF9P_pXwNXRitXmk9pUAB7n8wMnNkqYAh-SMh44kYqDQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: hibernation: Remove duplicate call of suspend_restore_csrs
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Song Shuai <songshuaishuai@tinylab.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor@kernel.org> =E4=BA=8E2023=E5=B9=B45=E6=9C=8819=E6=97=A5=
=E5=91=A8=E4=BA=94 20:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, May 19, 2023 at 12:28:07PM +0100, Conor Dooley wrote:
> > Hey,
> >
> > On Fri, May 19, 2023 at 11:14:27AM +0000, JeeHeng Sia wrote:
> >
> > > > The suspend_restore_csrs is called in both __hibernate_cpu_resume
> > > > and the `else` of subsequent swsusp_arch_suspend.
> > > >
> > > > Removing the first call makes both suspend_{save,restore}_csrs
> > > > left in swsusp_arch_suspend for clean code.
>
> It took me embarrassingly long to wrap my head around the control flow
> here again. I'm not sure that I agree with you that splitting the calls
> between asm & c is cleaner, but whatever:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> > > >
> > > > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > > Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> >
> > BTW, why the two email addresses? The tinylab one here seems entirely
> > redundant - unless it is your employer, in which case should it be the
> > only SoB address & also in the author field?
>
> Deja vu with my questioning your email address, but does your
> tinylab address actually repeat "shuai"?
>
Yes, that's my full name.
As you noticed, I'm switching my email from Gmail to Tinylab but did
something wrong.
Thanks for your correction, I'll re-send this patch with your
suggestions applied.

> > Also, Fixes tag?
> >
> > > > ---
> > > >  arch/riscv/kernel/hibernate-asm.S | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/=
hibernate-asm.S
> > > > index 5c76671c7e15..d698dd7df637 100644
> > > > --- a/arch/riscv/kernel/hibernate-asm.S
> > > > +++ b/arch/riscv/kernel/hibernate-asm.S
> > > > @@ -28,7 +28,6 @@ ENTRY(__hibernate_cpu_resume)
> > > >
> > > >   REG_L   a0, hibernate_cpu_context
> > > >
> > > > - suspend_restore_csrs
> > > >   suspend_restore_regs
> >
> > > Good catch. This function is invoked twice to restore the CSRs.
> > > I am good with removing this function from here.
> >
> > If that's a review, then please either give an R-b or A-b tag :)
> >
> > Thanks,
> > Conor.
>
>


--=20
Thanks,
Song
