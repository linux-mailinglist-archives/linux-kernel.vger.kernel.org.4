Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B760715418
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjE3C7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE3C7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:59:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF1D8E
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5314E62A0B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF39C433A1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685415568;
        bh=wEuys/ept9SxgsrESA2dJvolxDiyhIWiuVW3VCQrAU4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ftXDHZUW2eUlkyR2HcYaUsPKFR1nSV3H0e26TTOG/Chs+IuqwHgg4ksAzBF73s5OM
         u7Vj2nUduAoJUfyXutNUiV5gg7rI2p19gg1/5p10JLvJuXGFwDSRwJ2IDRsmehNsYm
         7OZG3nfBs+A4dd9BEivk8sozw1wouBmiO3GvT2Ddb5TCJLKML5f57BuHHAX2bPPczl
         /UN1d9pauLTfi1r8eSBIrF7Obi43z/UQnGmnGg7XMX0+ma7rVjdo9XcFPKo9gl35rp
         p9bnGjS5vwiqds2s4aCQBz7tFvCHONPpeaQO0RdoGySN2WnvwCEPpvJflc9+Gl2XsN
         N4KxOO5Z0pE0A==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5147f5efeb5so6579946a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:59:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDwCwdW43s5gLAmix9GpnCQCABr3X1nij0LZHZEJ2erPXB3qgMNC
        9YuuWYuvuxf8LEo9jFpv1Gg0C51TRdlDHVzp9yc=
X-Google-Smtp-Source: ACHHUZ4/zl+1rtgPVprtzBxAUtPl09fa84vSaubO1V4vVcGTKJs6j11bXnSSmaQi4f8VjVFbneN1HvjlKdRQvgvYmKI=
X-Received: by 2002:aa7:c743:0:b0:514:a5f7:a6d1 with SMTP id
 c3-20020aa7c743000000b00514a5f7a6d1mr552034eds.1.1685415566870; Mon, 29 May
 2023 19:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230529073845.2859178-1-guoren@kernel.org> <20230529-jasmine-amigo-6d01f6852b35@wendy>
In-Reply-To: <20230529-jasmine-amigo-6d01f6852b35@wendy>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 30 May 2023 10:59:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRSoZbexqka=_7nf4+dHZW2FGf++BiTMypfTbeoGAbUiA@mail.gmail.com>
Message-ID: <CAJF2gTRSoZbexqka=_7nf4+dHZW2FGf++BiTMypfTbeoGAbUiA@mail.gmail.com>
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

On Mon, May 29, 2023 at 9:43=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Mon, May 29, 2023 at 03:38:45AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Some .ko also need the riscv_v_user_allowed symbol.
> >
> > ERROR: modpost: "riscv_v_user_allowed" [arch/riscv/kvm/kvm.ko]
> > undefined!
> > make[3]: ***
> > [/home/guoren/source/kernel/linux/scripts/Makefile.modpost:136:
> > Module.symvers] Error 1
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/kernel/vector.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > index 1c4ac821e008..3ae08816d608 100644
> > --- a/arch/riscv/kernel/vector.c
> > +++ b/arch/riscv/kernel/vector.c
> > @@ -129,6 +129,7 @@ bool riscv_v_user_allowed(void)
> >  {
> >       return riscv_v_get_cur_ctrl(current) =3D=3D PR_RISCV_V_VSTATE_CTR=
L_ON;
> >  }
> > +EXPORT_SYMBOL(riscv_v_user_allowed);
>
> Is there a reason that this should not be EXPORT_SYMBOL_GPL()?
Good question, but I just follow our arch/riscv habbit, maybe we
should change all of that in another patch.

=E2=9E=9C  linux-s64ilp32 git:(s64ilp32) =E2=9C=97 grep EXPORT_SYMBOL  arch=
/riscv -r | wc -l
66
=E2=9E=9C  linux-s64ilp32 git:(s64ilp32) =E2=9C=97 grep EXPORT_SYMBOL_GPL  =
arch/riscv -r | wc -l
15

>
> I figure Andy will roll this into this next revision.
>
> Cheers,
> Conor.



--=20
Best Regards
 Guo Ren
