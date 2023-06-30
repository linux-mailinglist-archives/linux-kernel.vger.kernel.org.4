Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5153743405
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjF3FV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjF3FVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:21:53 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC5B2D78
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 22:21:52 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a37909a64eso872633b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 22:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688102511; x=1690694511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vh6aUxcW9Sd7Nxw2SV2uQlOuQlDwxv1Adt7CXHdwfk=;
        b=nAeGpiUndUVQPZMONYwc5zzAZpk7CWbiehmHv9I1PbnOL9LX5oMIuZWNTjkq6tKdui
         EGnqJS779zDyO/LiRjSBzAjO+gGxxcQC+bxIbZF56aHwtMEOxObe9iVF6839gBPwwtjF
         1mJodOzwca8fotOK97lnhgj4m/DwMgk58D4YuZ29OCw3zVfftkJiJdQONmPTB1YZ6U6V
         AcdwIWxn391JeUYRd/ZJukEncgow4UMeLLEX5d8iX2T6e0BbrtvuB3br66P77W01YQBp
         wrs4oV7U4Zbc1s7W3yKspvIRTSIXvt+XB+j/kNrL/Wymc+BzhAsYXQAJ0BgedIy1dBUC
         U86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688102511; x=1690694511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vh6aUxcW9Sd7Nxw2SV2uQlOuQlDwxv1Adt7CXHdwfk=;
        b=M4lLx+lySOKQwDTZaGlvw9oveXogMYKDYt16DQcoaML9CvEr2JhXUu/EmLJLWz5GDk
         ID9rjllBubpmGqsyHtSwGkmI7lEl0rcYiEbEwywDa9ogzlOE9Mb5SJ1wMt50LgAIOPH7
         SwS7JbojGqD5j49Cdm0v/Vq6/607K31jRxX7vPiTzzfS7J/QzsmMcka4/gli4rdyaO9d
         zos9Fodi6NCHBHpoZrePLW03LGLkXM1FKgGlHSJJQos3bXqOVVYTVyBw49XvRLwqrkBl
         f6RT6VD+bJHIMqL2ndeb4WdV4GbHBiDKyBujRvARdtWdDP4/lXmShNhFCq7JuFRAVwbT
         eTDg==
X-Gm-Message-State: AC+VfDyc9QmR6Qv1INpeVPcwhizhDZ5e1dEVLEr63J9ME/4c/goTI/ee
        gkVra67aFrQJvpvZGAjpWewMUnft6BxF8EcLWG+b+Q==
X-Google-Smtp-Source: ACHHUZ6UjmrHQtZtyrtFYxI2C+hfVD90LjdrZ/WYiPgj7rLAkiWiamFoA1AZi+yuYC5Nfm+35QUwTj/FybV0jioAUNM=
X-Received: by 2002:a05:6808:11cf:b0:3a1:c108:41b1 with SMTP id
 p15-20020a05680811cf00b003a1c10841b1mr1656069oiv.25.1688102511194; Thu, 29
 Jun 2023 22:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.651069086@linuxfoundation.org> <CAEUSe7-xC90CGpJjQD4w10ea=nXMiGhsFouhaa8fVK5W-WJJJQ@mail.gmail.com>
 <2023063056-waviness-unearth-08aa@gregkh>
In-Reply-To: <2023063056-waviness-unearth-08aa@gregkh>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 29 Jun 2023 23:21:39 -0600
Message-ID: <CAEUSe7_3+JHgdEAkJ=7ha5pm=24dV5zN_LakKMM6RUBo+nABXQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/30] 6.1.37-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, 29 Jun 2023 at 23:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 29, 2023 at 04:25:40PM -0600, Daniel D=C3=ADaz wrote:
> > Hello!
> >
> > On Thu, 29 Jun 2023 at 12:46, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > This is the start of the stable review cycle for the 6.1.37 release.
> > > There are 30 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Sat, 01 Jul 2023 18:41:39 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pa=
tch-6.1.37-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Early report of failures.
> >
> > SPARC and PA-RISC both fail to build (GCC-8 and GCC-11).
> >
> > For SPARC:
> > * allnoconfig
> > * defconfig
> > * tinyconfig
> >
> > -----8<-----
> > /builds/linux/arch/sparc/mm/fault_32.c: In function 'force_user_fault':
> > /builds/linux/arch/sparc/mm/fault_32.c:312:49: error: 'regs'
> > undeclared (first use in this function)
> >   312 |         vma =3D lock_mm_and_find_vma(mm, address, regs);
> >       |                                                 ^~~~
> > /builds/linux/arch/sparc/mm/fault_32.c:312:49: note: each undeclared
> > identifier is reported only once for each function it appears in
> > make[4]: *** [/builds/linux/scripts/Makefile.build:250:
> > arch/sparc/mm/fault_32.o] Error 1
> > make[4]: Target 'arch/sparc/mm/' not remade because of errors.
> > ----->8-----
> >
> > For PA-RISC:
> > * allnoconfig
> > * tinyconfig
> >
> > -----8<-----
> > /builds/linux/arch/parisc/mm/fault.c: In function 'do_page_fault':
> > /builds/linux/arch/parisc/mm/fault.c:292:22: error: 'prev' undeclared
> > (first use in this function)
> >   292 |                 if (!prev || !(prev->vm_flags & VM_GROWSUP))
> >       |                      ^~~~
> > /builds/linux/arch/parisc/mm/fault.c:292:22: note: each undeclared
> > identifier is reported only once for each function it appears in
> > make[4]: *** [/builds/linux/scripts/Makefile.build:250:
> > arch/parisc/mm/fault.o] Error 1
> > make[4]: Target 'arch/parisc/mm/' not remade because of errors.
> > ----->8-----
>
> These issues are also in Linus's tree right now, right?  Or are they
> unique to the -rc releases right now?

Correct. I went to look at mainline and it fails the same way there
for SPARC and PA-RISC, so 6.1 and 6.4 are on par there; 6.3's failures
on Arm64 are only seen there.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
