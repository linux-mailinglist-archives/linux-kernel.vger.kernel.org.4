Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D8E6FE453
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjEJTC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEJTC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:02:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E89610D3;
        Wed, 10 May 2023 12:02:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f1411e8111so8486034e87.1;
        Wed, 10 May 2023 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683745344; x=1686337344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxguqY4S16tZeT7RMekpOI21FADH1yjNY8YIqvTqbyM=;
        b=I2n2SnX88DnF4aRXyA+hq/WiN3F206P2YysVnnTiH6QeMcBJkA3U0mSdX78MJeJVOX
         j6ITofZCED7dL0K8Uwosf1SBD1yyMtcEDg/k/gyQP30CbIF1BvqbFIEZU8BuqMR5dk+q
         wksOYuPX6cvkaNL1WhjSkssfCPC3MhPCz30HVsAUNhNPLerNnAM4IXUtgkEhWs8/PB1x
         n6t39L7ovFSWzU3gXm1WEjEON8anYIUG12cRY0U1XX4T9fvDnUHtRPAK2CKc5CVw6g/M
         rSc69qMFh5aSkZBM5bFrOOxTgoxAusyLzhIKInkcTc8rI+Ngd6zIiNTYVR64Qs3/Z4t7
         wYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683745344; x=1686337344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxguqY4S16tZeT7RMekpOI21FADH1yjNY8YIqvTqbyM=;
        b=XVFEEf8lxTHWXruuPdFHCz1h93DspC0bu8za4zQghZhkLq7u6a7AjnLeQCLxN1xN/h
         BdOExv5w0NtpJ4B14aNIcXnA/FAMcxLUc0O/MAlximWfL6rkJHH6pSW3zuMpvy26DoHB
         Tyb8aLwJ9F+wZcgiMrYDm2g4Y5ftlz2OTtAqo5WzM9YEKTok/Px29zWBZHnjx4AcH9w0
         yDuUsOJLwFB4f3W6jU25XTrZ9gkjXEGZSXN8+qsjpb++uJ8y5ShG4nk84RHfB7rk9tfo
         MjUdhGnz6IMKhoqzesTIOHWMsN84qH4lw3pxqeA1Ggi4QCXIcJTzSOHYxLJ4UM23jdbx
         bQ7w==
X-Gm-Message-State: AC+VfDxwuDbTUpWnpH3J3SaffkFKBsVPZ/PIL3mHcCHPe3is7sYPWxsz
        C8QJAP1gBv7EQwtGV28VSpmR/ah0HnXryKL1jSM=
X-Google-Smtp-Source: ACHHUZ41hmokATCb8qf/C/tq2sKVejh5NEgx35cZhvshZGfVOw80kgUtxmq7erZJBe+j2I0jfi7m5xt9zueI7+uiaIc=
X-Received: by 2002:a2e:b282:0:b0:2a7:75aa:40c with SMTP id
 2-20020a2eb282000000b002a775aa040cmr2428524ljx.10.1683745344533; Wed, 10 May
 2023 12:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-5-jorge.lopez2@hp.com>
 <51607d2d-2d74-7dd4-e266-cf3ec0235e7a@linux.intel.com> <CAOOmCE-7sAPYcPM393Zsj=eR96fJv8Ectm8FoEJdxwPPAwEVVw@mail.gmail.com>
 <acac7018-99ad-c195-d361-f536a96aa5@linux.intel.com>
In-Reply-To: <acac7018-99ad-c195-d361-f536a96aa5@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 10 May 2023 14:01:55 -0500
Message-ID: <CAOOmCE_cEQycCSKYKDRDOfo9O4ud=EWCP5zD+yGpAfTHVinOMA@mail.gmail.com>
Subject: Re: [PATCH v12 04/13] HP BIOSCFG driver - int-attributes
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

On Tue, May 9, 2023 at 5:24=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 8 May 2023, Jorge Lopez wrote:
>
> > On Mon, May 8, 2023 at 9:45=E2=80=AFAM Ilpo J=C3=A4rvinen
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
> > > > ---
>
> > > > +int alloc_integer_data(void)
> > > > +{
> > > > +     bioscfg_drv.integer_instances_count =3D get_instance_count(HP=
_WMI_BIOS_INTEGER_GUID);
> > > > +     bioscfg_drv.integer_data =3D kcalloc(bioscfg_drv.integer_inst=
ances_count,
> > > > +                                        sizeof(struct integer_data=
), GFP_KERNEL);
> > >
> > > It would be better to use sizeof(*...) format.
> >
> > I cannot use sizeof(*...) at this time, because it is allocating
> > bioscfg_drv.integer_instances_count number of  integer_data
> > structures.
>
> Isn't bioscfg_drv.integer_data is a pointer to a single struct
> integer_data? Why cannot you do sizeof(*bioscfg_drv.integer_data)?? It is
> perfectly legal C construct for getting the size of the struct the
> pointer points to.
>
>

You are correct.  I found the problem in the code during my testing.
I will update similar code across all files.

> --
>  i.
