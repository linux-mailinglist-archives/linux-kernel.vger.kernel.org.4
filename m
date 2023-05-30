Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489E1716739
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjE3Ph5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE3Phy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5BBC7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B2D1629D4
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD27FC433D2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685461071;
        bh=I+bDplFB4ybfoxeuTjDQOJi8CNtCKz/6pE+frellwdw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CL+UBr8+xQiuU2Uzm5rgc/6Ijr+ybjXyWsdX/hFcmslL0w6tfI+kNHoOk1qiEhons
         sa3TUeA6xcnI/vDGf+/toNsoLVo6tecz2wx1bi2Q53md3LAPhOZwKnqpfXsVZG2ere
         aDxYQ0m0SMBupi6W9ERgv+RtUVTIkuFwUFZ6zB/7/5trk8Ji/LC7ZY8ygsQdMXZxKM
         8kAwimKnI7tCnDj2mGaGSNukohfq1dVn+qhBhnKAHNWLWtW5cC0P0LUdmjZvuwVTBo
         lrfFKnJMrUiDffkHg4togiBuNHbAMD50FK2TdotvqJZfI+DBq7Wl+4fkGlF122EOwx
         zCDKEWRNleOPA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f4b80bf93aso5155664e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:37:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDz4h9kXasnDmJKwmYtvZR448fcA7y4vMYwQUDpsAXMGM2C7nWRR
        9S+yCXQcH0iTmKtFi1sbvTzUeuk4m7rjmRbe7+Y=
X-Google-Smtp-Source: ACHHUZ4eIE/heo/0Kn6F9UfSo+8dlTQAjTrg/t6eQUk7SkKkLaE4qya56Lz8F7g5SRJ48fAbdBGvPQp6DD16rlkOl+U=
X-Received: by 2002:ac2:44cf:0:b0:4f3:7a59:d19 with SMTP id
 d15-20020ac244cf000000b004f37a590d19mr1075745lfm.59.1685461069828; Tue, 30
 May 2023 08:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230529073845.2859178-1-guoren@kernel.org> <20230529-jasmine-amigo-6d01f6852b35@wendy>
 <CAJF2gTRSoZbexqka=_7nf4+dHZW2FGf++BiTMypfTbeoGAbUiA@mail.gmail.com>
 <CAJF2gTTzUfp7xDr8myA+xMcxGNEQ+XLEYMfoR91NShdBAQMu7Q@mail.gmail.com> <CABgGipXu7iq-J5v6GVMPrnHiGVLuMxabB0_hPb+o+04T2MAwpw@mail.gmail.com>
In-Reply-To: <CABgGipXu7iq-J5v6GVMPrnHiGVLuMxabB0_hPb+o+04T2MAwpw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 30 May 2023 23:37:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR2fAkk1532VWmsWP5DSYN17ib80wa5QwwT=DC0LY9gGw@mail.gmail.com>
Message-ID: <CAJF2gTR2fAkk1532VWmsWP5DSYN17ib80wa5QwwT=DC0LY9gGw@mail.gmail.com>
Subject: Re: [PATCH] riscv: vector: Fixup modules compile error
To:     Andy Chiu <andy.chiu@sifive.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, greentime.hu@sifive.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmer@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 5:49=E2=80=AFPM Andy Chiu <andy.chiu@sifive.com> wr=
ote:
>
> On Tue, May 30, 2023 at 2:52=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Tue, May 30, 2023 at 10:59=E2=80=AFAM Guo Ren <guoren@kernel.org> wr=
ote:
> > >
> > > On Mon, May 29, 2023 at 9:43=E2=80=AFPM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> > > >
> > > > On Mon, May 29, 2023 at 03:38:45AM -0400, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > Some .ko also need the riscv_v_user_allowed symbol.
> > > > >
> > > > > ERROR: modpost: "riscv_v_user_allowed" [arch/riscv/kvm/kvm.ko]
> > > > > undefined!
> > > > > make[3]: ***
> > > > > [/home/guoren/source/kernel/linux/scripts/Makefile.modpost:136:
> > > > > Module.symvers] Error 1
> > > > >
> > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > ---
> > > > >  arch/riscv/kernel/vector.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vecto=
r.c
> > > > > index 1c4ac821e008..3ae08816d608 100644
> > > > > --- a/arch/riscv/kernel/vector.c
> > > > > +++ b/arch/riscv/kernel/vector.c
> > > > > @@ -129,6 +129,7 @@ bool riscv_v_user_allowed(void)
> > > > >  {
> > > > >       return riscv_v_get_cur_ctrl(current) =3D=3D PR_RISCV_V_VSTA=
TE_CTRL_ON;
> > > > >  }
> > > > > +EXPORT_SYMBOL(riscv_v_user_allowed);
> > > >
> > > > Is there a reason that this should not be EXPORT_SYMBOL_GPL()?
> > > Good question, but I just follow our arch/riscv habbit, maybe we
> > > should change all of that in another patch.
> > >
> > > =E2=9E=9C  linux-s64ilp32 git:(s64ilp32) =E2=9C=97 grep EXPORT_SYMBOL=
  arch/riscv -r | wc -l
> > > 66
> > > =E2=9E=9C  linux-s64ilp32 git:(s64ilp32) =E2=9C=97 grep EXPORT_SYMBOL=
_GPL  arch/riscv -r | wc -l
> > > 15
> >
> > Why !MODULE_LICENSE(GPL) modules couldn't use riscv_v_user_allowed?
> > Seems EXPORT_SYMBOL_GPL has more limitations.
> >
> > :c:func:`EXPORT_SYMBOL_GPL()`
> > -----------------------------
> >
> > Defined in ``include/linux/export.h``
> >
> > Similar to :c:func:`EXPORT_SYMBOL()` except that the symbols
> > exported by :c:func:`EXPORT_SYMBOL_GPL()` can only be seen by
> > modules with a :c:func:`MODULE_LICENSE()` that specifies a GPL
> > compatible license. It implies that the function is considered an
> > internal implementation issue, and not really an interface. Some
> > maintainers and developers may however require EXPORT_SYMBOL_GPL()
> > when adding any new APIs or functionality.
> >
> > For kvm is okay:
> >
> > MODULE_AUTHOR("Qumranet");
> > MODULE_LICENSE("GPL");
> >
> > So, I would leave the decition to Andy. If he didn't want it used with
> > other non-gpl modules, choose the EXPORT_SYMBOL_GPL.
>
> Do you have any use case for exporting this function to non-GPL
> licensed modules? I exported the function with EXPORT_SYMBOL_GPL() in
> v20[1] because I thought most maintainers would accept GPL rather than
> non-GPL one. And it seems most drivers would never call this function
> anyway.
I just found Linux-next build is broken, so I sent the patch. It seems
you've solved that. That's okay.

>
> >
> > >
> > > >
> > > > I figure Andy will roll this into this next revision.
>
> The fix for this has been included in v20[1]. However, I also changed
> the function name
> s/riscv_v_user_allowed/riscv_v_vstate_ctrl_user_allowed/.
>
> > > >
> > > > Cheers,
> > > > Conor.
> > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
>
> [1]: https://lore.kernel.org/all/20230518161949.11203-21-andy.chiu@sifive=
.com/
>
> Cheers,
> Andy



--=20
Best Regards
 Guo Ren
