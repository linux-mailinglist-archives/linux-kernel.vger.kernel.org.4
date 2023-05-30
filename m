Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AAB7155B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjE3Gwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjE3Gw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70153107
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 23:52:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01EB62AC2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7B8C433A0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685429542;
        bh=siy9Ko3UbHkih669rTBXTrvvQJb6+6k5h7kksul6NjI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hjuWY8Xz1RNVPltId3hJptIderckVfGZUOze/C01KfNLTniS/9JvZq2ZLrX62m+HX
         EP8gdcj04gBtPPWvc9nwSGzRvfmKo0HA9WC7hNmtkBldqQyq3DGgLLvFO3BWlo2O9R
         uAY0MOAIxcm/zSAvPsDy+tqReP/Qe2/TX+NraxQbqG7mhubXOytt1d8UjzkZMBWNil
         h7iQqH3U8EKBI9YuUDTXf6jPR8tGkQSolZ8YcyWYnohyrWQegVohXQnwKZpug06zU5
         jIlCETnkZ/11wjn4aC3gXIJJmgxTjUO3H68E3sZsyUw6WMApoWhKyKg7decYv1/0JK
         CBW7gFicrQBNQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so3153549a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 23:52:22 -0700 (PDT)
X-Gm-Message-State: AC+VfDyLT5Wg597PcO6kdK/LxZ4Tei//QJA3yrfP9xZQOl/QKVG+UpLQ
        5KK7721VU3uTv8veyevEzTRWOVOuvohiE+bXq+8=
X-Google-Smtp-Source: ACHHUZ7TPl4oqNW3y5WapM499wNVHLkNCZ/pq+hqHH1T3d3rEcKGogkr0Z5uJqSVymnmk+X6pAcpDng3aDt3ARvmnGk=
X-Received: by 2002:aa7:c504:0:b0:504:b228:878d with SMTP id
 o4-20020aa7c504000000b00504b228878dmr878888edq.25.1685429540598; Mon, 29 May
 2023 23:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230529073845.2859178-1-guoren@kernel.org> <20230529-jasmine-amigo-6d01f6852b35@wendy>
 <CAJF2gTRSoZbexqka=_7nf4+dHZW2FGf++BiTMypfTbeoGAbUiA@mail.gmail.com>
In-Reply-To: <CAJF2gTRSoZbexqka=_7nf4+dHZW2FGf++BiTMypfTbeoGAbUiA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 30 May 2023 14:52:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTzUfp7xDr8myA+xMcxGNEQ+XLEYMfoR91NShdBAQMu7Q@mail.gmail.com>
Message-ID: <CAJF2gTTzUfp7xDr8myA+xMcxGNEQ+XLEYMfoR91NShdBAQMu7Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: vector: Fixup modules compile error
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, paul.walmsley@sifive.com,
        palmer@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:59=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, May 29, 2023 at 9:43=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Mon, May 29, 2023 at 03:38:45AM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Some .ko also need the riscv_v_user_allowed symbol.
> > >
> > > ERROR: modpost: "riscv_v_user_allowed" [arch/riscv/kvm/kvm.ko]
> > > undefined!
> > > make[3]: ***
> > > [/home/guoren/source/kernel/linux/scripts/Makefile.modpost:136:
> > > Module.symvers] Error 1
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/kernel/vector.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > > index 1c4ac821e008..3ae08816d608 100644
> > > --- a/arch/riscv/kernel/vector.c
> > > +++ b/arch/riscv/kernel/vector.c
> > > @@ -129,6 +129,7 @@ bool riscv_v_user_allowed(void)
> > >  {
> > >       return riscv_v_get_cur_ctrl(current) =3D=3D PR_RISCV_V_VSTATE_C=
TRL_ON;
> > >  }
> > > +EXPORT_SYMBOL(riscv_v_user_allowed);
> >
> > Is there a reason that this should not be EXPORT_SYMBOL_GPL()?
> Good question, but I just follow our arch/riscv habbit, maybe we
> should change all of that in another patch.
>
> =E2=9E=9C  linux-s64ilp32 git:(s64ilp32) =E2=9C=97 grep EXPORT_SYMBOL  ar=
ch/riscv -r | wc -l
> 66
> =E2=9E=9C  linux-s64ilp32 git:(s64ilp32) =E2=9C=97 grep EXPORT_SYMBOL_GPL=
  arch/riscv -r | wc -l
> 15

Why !MODULE_LICENSE(GPL) modules couldn't use riscv_v_user_allowed?
Seems EXPORT_SYMBOL_GPL has more limitations.

:c:func:`EXPORT_SYMBOL_GPL()`
-----------------------------

Defined in ``include/linux/export.h``

Similar to :c:func:`EXPORT_SYMBOL()` except that the symbols
exported by :c:func:`EXPORT_SYMBOL_GPL()` can only be seen by
modules with a :c:func:`MODULE_LICENSE()` that specifies a GPL
compatible license. It implies that the function is considered an
internal implementation issue, and not really an interface. Some
maintainers and developers may however require EXPORT_SYMBOL_GPL()
when adding any new APIs or functionality.

For kvm is okay:

MODULE_AUTHOR("Qumranet");
MODULE_LICENSE("GPL");

So, I would leave the decition to Andy. If he didn't want it used with
other non-gpl modules, choose the EXPORT_SYMBOL_GPL.

>
> >
> > I figure Andy will roll this into this next revision.
> >
> > Cheers,
> > Conor.
>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren
