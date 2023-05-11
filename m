Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE56FF370
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238122AbjEKNwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbjEKNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:52:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C635A7;
        Thu, 11 May 2023 06:52:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f22908a082so6701818e87.1;
        Thu, 11 May 2023 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683813151; x=1686405151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94GUMh2At/vGwoRKKOJX0Z9VU5+Cp+4GaApU4ASVFxQ=;
        b=L1fUZuuAOKbNgn/+Qzr4dyiiTKcYNxVg7GbYuJT2ToA/8QK1DVpH8IdUm8jhE/Fs4n
         o5+Tmu3ZnQBAcKy7WsLY67m9/VeTBJhwNk5d/6HF61OoUvE/LmcKiOPMFKa/lNYyh1Ub
         js6KhPe508TFmYdskpWCDttqFvOwgQJeOYDPojzPZN8hTr16H3ht3k7mq4g3+4SEF7GM
         CtBf2+deyIOWh/mpXMkpwRtpsf9P/AL0x+dEO18ZTIAeKUIYs9ojVYvh/JPl8OQAOozg
         CTJkR34kq/MybNv2++ebco3U/MlgUPdScRQLJsAFJ9afox5694I52jZSJvXJ3SvzBIC7
         +ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683813151; x=1686405151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94GUMh2At/vGwoRKKOJX0Z9VU5+Cp+4GaApU4ASVFxQ=;
        b=Hfa3AdHoLdkr3YLNH+TDpNbDTp4sIY/K7ddKo9yhZ9Fp18hzG5rFlkd4dkxOflbVdD
         FHq96ypVUXM9lZPAS8B4j20rgp+RyFqKNIZtdqFbb4oUzEf4GldXf+obHNXi0nR1Fqyy
         UuYXQfi/AKABerhjVm6aqVMk8VvwPDrN7V0KAQrhAuR4wICtRI5yU4eIpv5s1ACCoxLW
         D98I61HkEPRqRqbA3ki5w4bBAtmc6Hf4aM8hd9JfGnO6HpHbN5j2bkgdE5sWrqFvF373
         cYMGfXRNpEf4scdwhXc7pgeRGYGeFtKLQjVkWGU6Dl93DzdvJJ+fqLZr6nvaN2UV+fDM
         yAfw==
X-Gm-Message-State: AC+VfDx7CLtd8Oe1c4YwDfP9+LLm/zvBUcm7Wr41pGqef/6kHTluxXD7
        eD95QW3FnNYdEZNJpD2d3FRda6Vl1EED+epA8jM=
X-Google-Smtp-Source: ACHHUZ4vwA21i8+m6tp88IUPyNNAFjRCTB2zwxs+aTrDvd1h/Qb30LjmRi3tFDX81fh1QbJCSTaHhY7veI6ca5typok=
X-Received: by 2002:a05:6512:1024:b0:4ec:89d3:a8ac with SMTP id
 r4-20020a056512102400b004ec89d3a8acmr2537648lfr.30.1683813150527; Thu, 11 May
 2023 06:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-7-jorge.lopez2@hp.com>
 <ff831b68-58ca-947e-1e1-b9461b781bc0@linux.intel.com> <CAOOmCE9MUFyXzeb-iBaXdpD0-ctSnYPnM_07VCAzGCg-vaOjsg@mail.gmail.com>
 <5fe49d95-79bd-441d-3a3a-4e2894536ae9@linux.intel.com>
In-Reply-To: <5fe49d95-79bd-441d-3a3a-4e2894536ae9@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Thu, 11 May 2023 08:52:01 -0500
Message-ID: <CAOOmCE-0V0WJEAL3Hg=RM1m1hf=vvRB1DqU1NUKaS9BrUye1Jg@mail.gmail.com>
Subject: Re: [PATCH v12 06/13] HP BIOSCFG driver - passwdobj-attributes
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, thomas@t-8ch.de
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

On Thu, May 11, 2023 at 4:09=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 10 May 2023, Jorge Lopez wrote:
>
> > On Tue, May 9, 2023 at 7:34=E2=80=AFAM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Fri, 5 May 2023, Jorge Lopez wrote:
> > >
> > > > HP BIOS Configuration driver purpose is to provide a driver support=
ing
> > > > the latest sysfs class firmware attributes framework allowing the u=
ser
> > > > to change BIOS settings and security solutions on HP Inc.=E2=80=99s=
 commercial
> > > > notebooks.
> > > >
> > > > Many features of HP Commercial notebooks can be managed using Windo=
ws
> > > > Management Instrumentation (WMI). WMI is an implementation of Web-B=
ased
> > > > Enterprise Management (WBEM) that provides a standards-based interf=
ace
> > > > for changing and monitoring system settings. HP BIOSCFG driver prov=
ides
> > > > a native Linux solution and the exposed features facilitates the
> > > > migration to Linux environments.
> > > >
> > > > The Linux security features to be provided in hp-bioscfg driver ena=
bles
> > > > managing the BIOS settings and security solutions via sysfs, a virt=
ual
> > > > filesystem that can be used by user-mode applications. The new
> > > > documentation cover HP-specific firmware sysfs attributes such Secu=
re
> > > > Platform Management and Sure Start. Each section provides security
> > > > feature description and identifies sysfs directories and files expo=
sed
> > > > by the driver.
> > > >
> > > > Many HP Commercial notebooks include a feature called Secure Platfo=
rm
> > > > Management (SPM), which replaces older password-based BIOS settings
> > > > management with public key cryptography. PC secure product manageme=
nt
> > > > begins when a target system is provisioned with cryptographic keys
> > > > that are used to ensure the integrity of communications between sys=
tem
> > > > management utilities and the BIOS.
> > > >
> > > > HP Commercial notebooks have several BIOS settings that control its
> > > > behaviour and capabilities, many of which are related to security.
> > > > To prevent unauthorized changes to these settings, the system can
> > > > be configured to use a cryptographic signature-based authorization
> > > > string that the BIOS will use to verify authorization to modify the
> > > > setting.
> > > >
> > > > Linux Security components are under development and not published y=
et.
> > > > The only linux component is the driver (hp bioscfg) at this time.
> > > > Other published security components are under Windows.
> > > >
> > > > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> > > >
> > > > ---
> > > > Based on the latest platform-drivers-x86.git/for-next
> > >
> > > FYI, for me you don't need to reply into the comments where you'll be
> > > following the review suggestion. It saves us both time if we focus on
> > > points where there's more to discuss.
>
>
> > > > +                     /*
> > > > +                      * This HACK is needed to keep the expected
> > > > +                      * element list pointing to the right obj[ele=
m].type
> > > > +                      * when the size is zero.  PREREQUISITES
> > >
> > > Please remove all these double space from your patches (should be eas=
y
> > > to find them with grep). Please check if your editor adds them e.g., =
when
> > > reflowing text.
> >
> > What double spaces are you referring to?
>
> There's "zero.  PREREQUISITES" so double space after the full stop. We
> don't use them in the kernel comments.
>
> It could be that your editor auto inserts the second space (by default)
> when e.g. reflowing text because it's some English rule to use two spaces
> there.
>
>

Thank you for the clarification.  I checked and fixed all double
spaces in all source files
> --
>  i.
