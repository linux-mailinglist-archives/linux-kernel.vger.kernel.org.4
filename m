Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8C716925
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjE3QXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjE3QXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E2C100
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81D2461136
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E318BC433A1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685463774;
        bh=JGeOPr61EyRFf2BxMykJnZJ/gcMx62FZwVC/VLhCqLo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JL+fH5y+8C5qPBJYQWPbXjIqM2lL0QtUk4Gvq6RvFfcMNTqrnfXSdiV00866UicbW
         Oz8PX6Y19MIZ7wwC4SkojqG0ojDjwV8xjV9U7sRNgoK5YfxyhqOM14cuA2tiSyMDu3
         ZZrNRgSZ/+BttKq/ZI6OO3HRXpFjskquiXylawsQ8Sge48v4ZBkNM9J0Ob+Atd1cbI
         pAwogzMhqQZvze5EEwcgJhI6k0cYB6Jc6QZOSCVQel3OjmXvWYVDvUy6WSikNojDVL
         Ov5s9iEzzs9xE4b7e0IhQrZAbwXIKDCoPxpytmfU3n7DO3nDfb3b7F/5rdZu1cCCdQ
         Vlxn9oV2wjHqw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so4247322a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:22:54 -0700 (PDT)
X-Gm-Message-State: AC+VfDwctyO9Bc0J2/1MLKlcJt5wgFIdT8l9qcUsCppXcwqCawP5ROTO
        AVr2fK+BpLOEQF1tKqVUS17nTPcBfVkkv1l7ibI=
X-Google-Smtp-Source: ACHHUZ5oYKOXYVKPGZYL2Sd9Egd4s06eBPOBJs+Vz76XkHlA6svwRkGBAjLGUyj94EpgMZbFw5pOhDIGICxJjGBIEvg=
X-Received: by 2002:aa7:ccca:0:b0:50d:f9b3:444c with SMTP id
 y10-20020aa7ccca000000b0050df9b3444cmr1813894edt.17.1685463773136; Tue, 30
 May 2023 09:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230529073845.2859178-1-guoren@kernel.org> <20230529-jasmine-amigo-6d01f6852b35@wendy>
 <CAJF2gTRSoZbexqka=_7nf4+dHZW2FGf++BiTMypfTbeoGAbUiA@mail.gmail.com>
 <CAJF2gTTzUfp7xDr8myA+xMcxGNEQ+XLEYMfoR91NShdBAQMu7Q@mail.gmail.com>
 <CABgGipXu7iq-J5v6GVMPrnHiGVLuMxabB0_hPb+o+04T2MAwpw@mail.gmail.com>
 <CAJF2gTR2fAkk1532VWmsWP5DSYN17ib80wa5QwwT=DC0LY9gGw@mail.gmail.com>
 <20230530-static-smith-96cf543bfda2@spud> <CAJF2gTTD-Qbp1bJ2EZgpBTzRrWtUEy7k644GzYES2qRWY3D3LQ@mail.gmail.com>
In-Reply-To: <CAJF2gTTD-Qbp1bJ2EZgpBTzRrWtUEy7k644GzYES2qRWY3D3LQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 31 May 2023 00:22:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTje+Kbyw2iC+ZsfeftTJ9CyqHN789wgocr0WOFnk=3dg@mail.gmail.com>
Message-ID: <CAJF2gTTje+Kbyw2iC+ZsfeftTJ9CyqHN789wgocr0WOFnk=3dg@mail.gmail.com>
Subject: Re: [PATCH] riscv: vector: Fixup modules compile error
To:     Conor Dooley <conor@kernel.org>
Cc:     Andy Chiu <andy.chiu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
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

On Wed, May 31, 2023 at 12:14=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, May 31, 2023 at 12:04=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Tue, May 30, 2023 at 11:37:38PM +0800, Guo Ren wrote:
> > > I just found Linux-next build is broken, so I sent the patch. It seem=
s
> > > you've solved that. That's okay.
> >
> > Are you sure that linux-next is broken because of this?
> > This series should not be in linux-next...
> I mean:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=
=3Dfor-next
I would change it to

+risc-v git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git#f=
or-next

next.

>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren
