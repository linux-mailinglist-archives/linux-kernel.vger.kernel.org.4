Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696FB70A123
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjESU6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjESU6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:58:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB16BC2;
        Fri, 19 May 2023 13:58:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af2602848aso11819091fa.2;
        Fri, 19 May 2023 13:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684529923; x=1687121923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvHRB9FcG1nrgIWVeWJjDEuxWAphpgsmUKl7eFi3J00=;
        b=HCetSTo78t0uCgroZErIYelZciALeYs9WojKcGAc9fNg+R2vfoF48LgARcfHYbDBv4
         syXDsJW1Q08VmqVdtiRZgrKWoN61a2s94sp5I12MmtFP2l+d8GOesYVkTqujir2JTBnl
         RRIPxo/8szS75XHigRAQ1l4oi/wP1hVEOX3B57XOq7fLgow1ZNs60LJcZ0+fQNYVWIR+
         izN6zaj0hQ9T6QfWpYRR5r76kcpr8wiYAn7N2WYbsIGbEIDBT+pU7E4eL73OOLspW3/X
         XvykUEEAMHzCw9gebIA0B9Z4CvDEICcbLgBWJ2RQwnDtBVul01RSJE8Eq+C0mcpCfQYQ
         xbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529923; x=1687121923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvHRB9FcG1nrgIWVeWJjDEuxWAphpgsmUKl7eFi3J00=;
        b=bfrmu+p44ZyjIo9YjV5EdV22AW8A4WHJRqCWh71/HHl2KrpgIeQtf3OH/KChK/Cfuc
         4ftWXRyaOCzdvx35JFAkOvTmXzUkYQbELY6YbNSEHDWe8fZ/YtbTNeEaj26mUbTMYKic
         tLrN+Ic6YGRSm356/TrOK9CA32eeCfAAa3xI2pPj48eDJj+p8lWqGPQOZvPzDQggP+uS
         anVlvJZc1hI0EcpPaGR6SnIKPJfz7bTqKpPMSx2x8jPO35MVRwdeE9K7B47KU1icu6iq
         f6Ypgd7Rl8Nz2hzKQ8OMYu+xRbToF6YttwIDasb4fdJkFQ3QQDTbmtvtquhRu3oT6wBS
         B7jA==
X-Gm-Message-State: AC+VfDzWAPQTfZlyH7tDZY+nVhspl2tmHZjit3kuirNTxt4gye9I1cjB
        HMa0+ebXwlZg+RppM5wztlabZ8YVnTc7tTI1V48=
X-Google-Smtp-Source: ACHHUZ5SqXNcJmF+12P0THuelwVQVrfY/kmxPyZh4U0ovP9loxx+cdjLUW3p4J8l3wNUKDsq+WfVm0oOlko28ogF+qk=
X-Received: by 2002:a05:651c:1041:b0:2ae:cf05:5bb6 with SMTP id
 x1-20020a05651c104100b002aecf055bb6mr1188484ljm.15.1684529922694; Fri, 19 May
 2023 13:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230517155026.28535-1-jorge.lopez2@hp.com> <20230517155026.28535-2-jorge.lopez2@hp.com>
 <0abdb306-1e24-4653-9a14-e5db8d508a82@app.fastmail.com>
In-Reply-To: <0abdb306-1e24-4653-9a14-e5db8d508a82@app.fastmail.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 19 May 2023 15:58:10 -0500
Message-ID: <CAOOmCE8-GB-yM-cfCP6Sw8xdnOgNm4b7viUziA48YJ4mGkGfag@mail.gmail.com>
Subject: Re: [PATCH v14 01/13] hp-bioscfg: Documentation
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        ilpo.jarvinen@linux.intel.com
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

On Fri, May 19, 2023 at 12:34=E2=80=AFPM Mark Pearson <mpearson-lenovo@sque=
bb.ca> wrote:
>
> Hi Jorge,
>
> On Wed, May 17, 2023, at 11:50 AM, Jorge Lopez wrote:
> > HP BIOS Configuration driver purpose is to provide a driver supporting
> > the latest sysfs class firmware attributes framework allowing the user
> > to change BIOS settings and security solutions on HP Inc.=E2=80=99s com=
mercial
> > notebooks.
> >
> > Many features of HP Commercial notebooks can be managed using Windows
> > Management Instrumentation (WMI). WMI is an implementation of Web-Based
> > Enterprise Management (WBEM) that provides a standards-based interface
> > for changing and monitoring system settings. HP BIOSCFG driver provides
> > a native Linux solution and the exposed features facilitates the
> > migration to Linux environments.
> >
> > The Linux security features to be provided in hp-bioscfg driver enables
> > managing the BIOS settings and security solutions via sysfs, a virtual
> > filesystem that can be used by user-mode applications. The new
> > documentation cover HP-specific firmware sysfs attributes such Secure
> > Platform Management and Sure Start. Each section provides security
> > feature description and identifies sysfs directories and files exposed
> > by the driver.
> >
> > Many HP Commercial notebooks include a feature called Secure Platform
> > Management (SPM), which replaces older password-based BIOS settings
> > management with public key cryptography. PC secure product management
> > begins when a target system is provisioned with cryptographic keys
> > that are used to ensure the integrity of communications between system
> > management utilities and the BIOS.
> >
> > HP Commercial notebooks have several BIOS settings that control its
> > behaviour and capabilities, many of which are related to security.
> > To prevent unauthorized changes to these settings, the system can
> > be configured to use a cryptographic signature-based authorization
> > string that the BIOS will use to verify authorization to modify the
> > setting.
> >
> > Linux Security components are under development and not published yet.
> > The only linux component is the driver (hp bioscfg) at this time.
> > Other published security components are under Windows.
> >
> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  .../testing/sysfs-class-firmware-attributes   | 102 +++++++++++++++++-
> >  1 file changed, 100 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > index 4cdba3477176..f8d6c089228b 100644
> > --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> <snip>
> > +
> > +
> > +             HP specific class extensions - Secure Platform Manager (S=
PM)
> > +             --------------------------------
> > +
> > +What:                /sys/class/firmware-attributes/*/authentication/S=
PM/kek
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'kek' Key-Encryption-Key is a write-only file that can be=
 used to
> > configure the
> > +             RSA public key that will be used by the BIOS to verify
> > +             signatures when setting the signing key.  When written,
> > +             the bytes should correspond to the KEK certificate
> > +             (x509 .DER format containing an OU).  The size of the
> > +             certificate must be less than or equal to 4095 bytes.
> > +
> > +What:                /sys/class/firmware-attributes/*/authentication/S=
PM/sk
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'sk' Signature Key is a write-only file that can be used =
to
> > configure the RSA
> > +             public key that will be used by the BIOS to verify signat=
ures
> > +             when configuring BIOS settings and security features.  Wh=
en
> > +             written, the bytes should correspond to the modulus of th=
e
> > +             public key.  The exponent is assumed to be 0x10001.
> > +
> > +What:                /sys/class/firmware-attributes/*/authentication/S=
PM/status
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'status' is a read-only file that returns ASCII text in J=
SON format
> > reporting
> > +             the status information.
> > +
> > +               "State": "not provisioned | provisioned | provisioning =
in progress
> > ",
> > +               "Version": " Major. Minor ",
> > +               "Nonce": <16-bit unsigned number display in base 10>,
> > +               "FeaturesInUse": <16-bit unsigned number display in bas=
e 10>,
> > +               "EndorsementKeyMod": "<256 bytes in base64>",
> > +               "SigningKeyMod": "<256 bytes in base64>"
> > +
> > +What:                /sys/class/firmware-attributes/*/attributes/Sure_=
Start/audit_log_entries
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'audit_log_entries' is a read-only file that returns the =
events in
> > the log.
> > +
> > +                     Audit log entry format
> > +
> > +                     Byte 0-15:   Requested Audit Log entry  (Each Aud=
it log is 16 bytes)
> > +                     Byte 16-127: Unused
> > +
> > +What:                /sys/class/firmware-attributes/*/attributes/Sure_=
Start/audit_log_entry_count
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'audit_log_entry_count' is a read-only file that returns =
the number
> > of existing
> > +             audit log events available to be read. Values are separat=
ed using
> > comma (``,``)
> > +
> > +                     [No of entries],[log entry size],[Max number of e=
ntries supported]
> > +
> > +             log entry size identifies audit log size for the current =
BIOS
> > version.
> > +             The current size is 16 bytes but it can be up to 128 byte=
s long in
> > future BIOS
> > +             versions.
> > --
> > 2.34.1
>
> Firstly apologies as I've done a poor job of following the updates to thi=
s series - so if this has already been discussed and agreed by more seasone=
d kernel contributors please feel free to disregard my comments :) I was ca=
tching up on my inbox and had some thoughts.

No worries.

>
> For SPM - as this replaces password usage, is it done for all account typ=
es? It seems a bit odd having it be a replacement for the passwords but in =
it's own location and not in the same place as (for example) Admin/current_=
password.
> For the Lenovo implementation I put certificate, signature and save_signa=
ture in the authentication/Admin directory and I realise your implementatio=
n is different with the keys but if the kek and sk are only used with the A=
dmin account then shouldn't they also be in that directory? It would be nic=
e to have some commonality across vendors in my opinion.
>

SPM (Security Platform Management) does not replace password usage and
it is done for the Admin account (Setup Password).  SPM is a security
feature available to the user to configure/update BIOS settings when
Sure Admin is enabled in BIOS.  One of the files provided under SPM is
the key _role and its value is set to =E2=80=98bios-spm.=E2=80=99   A =E2=
=80=98bios-spm=E2=80=99 role
indicates a password is used in combination with an
endorsement/signing key.  It is also the reason why SPM is kept
separate under the list of authentication attributes.

> For the Sure_Start I would propose de-branding this so it's generic and I=
 don't think it fits under attributes as it doesn't support any of the othe=
r required attribute fields. I think your implementation of an audit log se=
ems neat but if another vendor was to do similar it would be better to be a=
ble to reuse the same attribute name and enable common tooling.
> I propose having this as just log/audit_entries and log/audit_count and h=
ave the log folder in the top alongside authentication and attributes.
> If someone wants to add other logs in the future it would be a good place=
 to have them.

I like the idea of having a log folder alongside authentication and
attributes where future logs can be placed.  Unfortunately, Sure_Start
is part of the security attributes  and the initial driver provides a
minimal implementation.   Other attributes associated with Sure_Start
and available in BIOS are  'SureStart Production Mode', 'Sure Start
Security Event Boot Notification', 'Sure Start BIOS Settings
Protection', 'Sure Start Secure Boot Keys Protection', and 'Sure Start
Security Event Policy'

>
> Thanks
> Mark
