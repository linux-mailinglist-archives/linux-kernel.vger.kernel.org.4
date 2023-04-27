Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7128C6F0421
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243551AbjD0KW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbjD0KWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:22:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DA8449D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:22:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2472dc49239so7315772a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682590940; x=1685182940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnODog9U903LNGD2V1Nk+gMw3BrcjjBNHazIwAOSIYs=;
        b=btJTg7f9VKENot0Au9p4GAN4K+Bmbohn4oyMWlWhtfceqKATCOMSN0EqEhzzSepPzA
         seRVV5LMhj02yUkZpMcOI1QvdKkysW9+duxXF5JerrH/Z/pdlnV9dxX8n5HlfBDo+2ty
         E+ZALpmuIlKVTlYyXbxLJr6d66daljc+amVBdDWOsLuMoyg7Gghm606jO0a99LQeZ6Ij
         1yrjCrpLukFj5vjiSVtZfZiS0M7YS6brxDw5t5DiIZCRA/k+/O6pB5JDPV5j8KyFeOp+
         KnMgAba9FMGsjDlhy5fbyD4nKGpXxxuHSTAOQ7nbL5gBhB055H27X0S+U/FzanRJ163X
         B1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590940; x=1685182940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnODog9U903LNGD2V1Nk+gMw3BrcjjBNHazIwAOSIYs=;
        b=QeM2I7bTyIWDv1MZreRKNFG1qsyuSULe/rMPlRjkp5wM6u1BVjgDNojtAGo+Fyd+Rb
         g5XzbExCNo3pBdIDECsuMiaZLNhRn9YnbnMkwUyz/5tEr87585YK9cnzcSujLUUHcVST
         IwPWiHFGwqjpUXIiqM8qcKD+5FJcJt0PDjeQT8vR50jjiArgnjzONHdYY9IKEjT3cHq9
         1jB0kfo9/+RBrp/Xo5yN3eJSyBh1M9a4LchWecikBPWDC9KXoyksluafYkl4utlCTVK3
         pUKYe2yEwMAsQf0dXCkgKdKko6eY5G2unaR04X9hHg0TsT+rq4vFyBkLtWt4Bbye2OsB
         snjw==
X-Gm-Message-State: AC+VfDzBPKCM4xqYVbjz1pX1AA3jBC+91in27c9/jVS4YbulM0xYRa/q
        bVGcwz2ux1cyNTohYzpBERfHVhZsQw/C3KMk3fM=
X-Google-Smtp-Source: ACHHUZ74pJgbzC2ZFcCd//1VReiQpkWmwTEmUMjiTdxjQv6IVRjpu9ndqiUDYz2KnTZWlxGVgUseChkXgRj7PeZoKaM=
X-Received: by 2002:a17:90a:cc02:b0:247:6a93:1d56 with SMTP id
 b2-20020a17090acc0200b002476a931d56mr1313129pju.22.1682590940306; Thu, 27 Apr
 2023 03:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230426100009.685435-1-suagrfillet@gmail.com> <20230427-prevail-upload-033ca439a54c@wendy>
In-Reply-To: <20230427-prevail-upload-033ca439a54c@wendy>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Thu, 27 Apr 2023 10:22:08 +0000
Message-ID: <CAAYs2=hvyZgtDOMtO4OMbu5vWC6yn+xJunTYbDZ_T_AZ50kCiQ@mail.gmail.com>
Subject: Re: [PATCH -fixes V2] riscv: mm: remove redundant parameter of create_fdt_early_page_table
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexghiti@rivosinc.com, heiko@sntech.de,
        guoren@kernel.org, anshuman.khandual@arm.com, mick@ics.forth.gr,
        samuel@sholland.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=882=
7=E6=97=A5=E5=91=A8=E5=9B=9B 10:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Apr 26, 2023 at 06:00:09PM +0800, Song Shuai wrote:
> > create_fdt_early_page_table() explicitly uses early_pg_dir for
> > 32-bit fdt mapping and the pgdir parameter is redundant here.
> > So remove it and its caller.
> >
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>
> Whoops, I missed the v2, so copy-pasting:
>
> "and its caller" sounds like you're removing the caller itself when
> that's not what you're doing!
> I am certainly not suggesting that you resubmit because of that though.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Automation failed to apply this which is a bit weird. What was the
> base-commit?
commit 1b50f956c8fe `riscv: No need to relocate the dtb as it lies in
the fixmap region` in riscv/linux fixes branch.
>
> Cheers,
> Conor.
>
> > ---
> > Changes in V1:
> > https://lore.kernel.org/linux-riscv/83540cb1-0c9b-f572-849a-cb100437d04=
9@ghiti.fr/T/#t
> > - fix the typo
> > ---
> >  arch/riscv/mm/init.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 0f14f4a8d179..6ebb75a9a6b9 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -843,8 +843,7 @@ static void __init create_kernel_page_table(pgd_t *=
pgdir, bool early)
> >   * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 =
PGDIR
> >   * entry.
> >   */
> > -static void __init create_fdt_early_page_table(pgd_t *pgdir,
> > -                                            uintptr_t fix_fdt_va,
> > +static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
> >                                              uintptr_t dtb_pa)
> >  {
> >       uintptr_t pa =3D dtb_pa & ~(PMD_SIZE - 1);
> > @@ -1034,8 +1033,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >       create_kernel_page_table(early_pg_dir, true);
> >
> >       /* Setup early mapping for FDT early scan */
> > -     create_fdt_early_page_table(early_pg_dir,
> > -                                 __fix_to_virt(FIX_FDT), dtb_pa);
> > +     create_fdt_early_page_table(__fix_to_virt(FIX_FDT), dtb_pa);
> >
> >       /*
> >        * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-io=
remap
> > --
> > 2.20.1
> >



--=20
Thanks,
Song
