Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE0670DF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbjEWOSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjEWOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:18:35 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF5B109;
        Tue, 23 May 2023 07:18:33 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2af1a7d2f6aso69371821fa.1;
        Tue, 23 May 2023 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684851452; x=1687443452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgp0WGgQRnhS5h2HXXDa4Jv0mpviiv7tawtn9KwlyOE=;
        b=DdScvZkRj6fz33AoLK3TCnv16P/t0+wXqgWTr4rTe0zTqKu5DOQvBQv3S6BrHEUkBO
         3fMs8JXDX9TmaCgWWOSsazr3Gt3qhZZs0MN9ivPqYxagfro0I58n8Q3n2jUlbIh61d96
         L71Z/uXncaqSQQ44nTkZk1AXfTeH/iy1/b9YCUc4IC6SDEgl9K+4+rzkmEVfvdKPS8eV
         0hIaQzRFZKENbqWDxhZhW8EAGIThsBuOcf5lnTjdpkMvgmCLn5MmvhdU89jXpIzKm89w
         aW0BprSeatwAgsdTiKek/e90S1h1calYLsKrOoSDbiHEO4LHvFIabbyD4YhUZEK+C+dp
         HCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851452; x=1687443452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgp0WGgQRnhS5h2HXXDa4Jv0mpviiv7tawtn9KwlyOE=;
        b=BjWtfmiIflvhYTO2QI/e8EXKcMsUpR06dicTvaCxrJEEdkaaQaswHKbPMuPKqq2D+b
         OWL0UAMdouy/6DNaNtOYd15J/1DrPTiTGtnX4+gTz9+tyuVx5592F832SvA06N2iUBHK
         TG5F6TjLSHlAErtSe7v2NWInZcutUYi9A7klbvLi1PWIZXwKd2QEBiWlt/ngLMbmWokF
         crkjcq8tesZsCmCwklqb8b2WoxZXZDHOhT/QCFysheJjzKDfN3sPoYjKj+KzO3Bgu/ex
         bE2apL0TVtyD8wwFH6u1KvVaETYvL7KuWkypgCL26fjz8WdF8gVroiHbj6+FlVt5wr/S
         I4TQ==
X-Gm-Message-State: AC+VfDwkLJ4KbmFOfOzSO9U5nBAIuS6s8jCOQbN9Ez8URoDZiBVL8eOi
        xq395Cdiiopd7lzA+dOLBXVNfe35yBrGv9s73a9tyYAGLw0=
X-Google-Smtp-Source: ACHHUZ48D9ju1tf/+willhkmKEU07oYET3oKAQ6KOM19Votg2QiqAgHNcTusHuHK4irGmk9k6b0CZqVSoKoNuSa292o=
X-Received: by 2002:a2e:7e0a:0:b0:2ac:770f:8831 with SMTP id
 z10-20020a2e7e0a000000b002ac770f8831mr5310344ljc.40.1684851451186; Tue, 23
 May 2023 07:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230517155026.28535-1-jorge.lopez2@hp.com> <20230517155026.28535-2-jorge.lopez2@hp.com>
 <0abdb306-1e24-4653-9a14-e5db8d508a82@app.fastmail.com> <CAOOmCE8-GB-yM-cfCP6Sw8xdnOgNm4b7viUziA48YJ4mGkGfag@mail.gmail.com>
 <7406150c-4ac0-4a61-b7e5-fd5f89ef0d45@app.fastmail.com>
In-Reply-To: <7406150c-4ac0-4a61-b7e5-fd5f89ef0d45@app.fastmail.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 23 May 2023 09:16:57 -0500
Message-ID: <CAOOmCE-1LykpkkSFd112F=YFsY2Vmyphn-coE_SbDbnfGrdyGQ@mail.gmail.com>
Subject: Re: [PATCH v14 01/13] hp-bioscfg: Documentation
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 6:19=E2=80=AFPM Mark Pearson <mpearson-lenovo@squeb=
b.ca> wrote:
>
> Thanks Jorge,
>
> On Fri, May 19, 2023, at 4:58 PM, Jorge Lopez wrote:
> > On Fri, May 19, 2023 at 12:34=E2=80=AFPM Mark Pearson <mpearson-lenovo@=
squebb.ca> wrote:
> >>
> >> Hi Jorge,
> >>
> >> On Wed, May 17, 2023, at 11:50 AM, Jorge Lopez wrote:
> >> > HP BIOS Configuration driver purpose is to provide a driver supporti=
ng
> >> > the latest sysfs class firmware attributes framework allowing the us=
er
> >> > to change BIOS settings and security solutions on HP Inc.=E2=80=99s =
commercial
> >> > notebooks.
> >> >
> >> > Many features of HP Commercial notebooks can be managed using Window=
s
> >> > Management Instrumentation (WMI). WMI is an implementation of Web-Ba=
sed
> >> > Enterprise Management (WBEM) that provides a standards-based interfa=
ce
> >> > for changing and monitoring system settings. HP BIOSCFG driver provi=
des
> >> > a native Linux solution and the exposed features facilitates the
> >> > migration to Linux environments.
> >> >
> >> > The Linux security features to be provided in hp-bioscfg driver enab=
les
> >> > managing the BIOS settings and security solutions via sysfs, a virtu=
al
> >> > filesystem that can be used by user-mode applications. The new
> >> > documentation cover HP-specific firmware sysfs attributes such Secur=
e
> >> > Platform Management and Sure Start. Each section provides security
> >> > feature description and identifies sysfs directories and files expos=
ed
> >> > by the driver.
> >> >
> >> > Many HP Commercial notebooks include a feature called Secure Platfor=
m
> >> > Management (SPM), which replaces older password-based BIOS settings
> >> > management with public key cryptography. PC secure product managemen=
t
> >> > begins when a target system is provisioned with cryptographic keys
> >> > that are used to ensure the integrity of communications between syst=
em
> >> > management utilities and the BIOS.
> >> >
> >> > HP Commercial notebooks have several BIOS settings that control its
> >> > behaviour and capabilities, many of which are related to security.
> >> > To prevent unauthorized changes to these settings, the system can
> >> > be configured to use a cryptographic signature-based authorization
> >> > string that the BIOS will use to verify authorization to modify the
> >> > setting.
> >> >
> >> > Linux Security components are under development and not published ye=
t.
> >> > The only linux component is the driver (hp bioscfg) at this time.
> >> > Other published security components are under Windows.
> >> >
> >> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >> >
> >> > ---
> >> > Based on the latest platform-drivers-x86.git/for-next
> >> > ---
> >> >  .../testing/sysfs-class-firmware-attributes   | 102 +++++++++++++++=
++-
> >> >  1 file changed, 100 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attribut=
es
> >> > b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> >> > index 4cdba3477176..f8d6c089228b 100644
> >> > --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> >> > +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> >> <snip>
> >> > +
> >> > +
> >> > +             HP specific class extensions - Secure Platform Manager=
 (SPM)
> >> > +             --------------------------------
> >> > +
> >> > +What:                /sys/class/firmware-attributes/*/authenticatio=
n/SPM/kek
> >> > +Date:                March 29
> >> > +KernelVersion:       5.18
> >> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> >> > +Description:
> >> > +             'kek' Key-Encryption-Key is a write-only file that can=
 be used to
> >> > configure the
> >> > +             RSA public key that will be used by the BIOS to verify
> >> > +             signatures when setting the signing key.  When written=
,
> >> > +             the bytes should correspond to the KEK certificate
> >> > +             (x509 .DER format containing an OU).  The size of the
> >> > +             certificate must be less than or equal to 4095 bytes.
> >> > +
> >> > +What:                /sys/class/firmware-attributes/*/authenticatio=
n/SPM/sk
> >> > +Date:                March 29
> >> > +KernelVersion:       5.18
> >> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> >> > +Description:
> >> > +             'sk' Signature Key is a write-only file that can be us=
ed to
> >> > configure the RSA
> >> > +             public key that will be used by the BIOS to verify sig=
natures
> >> > +             when configuring BIOS settings and security features. =
 When
> >> > +             written, the bytes should correspond to the modulus of=
 the
> >> > +             public key.  The exponent is assumed to be 0x10001.
> >> > +
> >> > +What:                /sys/class/firmware-attributes/*/authenticatio=
n/SPM/status
> >> > +Date:                March 29
> >> > +KernelVersion:       5.18
> >> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> >> > +Description:
> >> > +             'status' is a read-only file that returns ASCII text i=
n JSON format
> >> > reporting
> >> > +             the status information.
> >> > +
> >> > +               "State": "not provisioned | provisioned | provisioni=
ng in progress
> >> > ",
> >> > +               "Version": " Major. Minor ",
> >> > +               "Nonce": <16-bit unsigned number display in base 10>=
,
> >> > +               "FeaturesInUse": <16-bit unsigned number display in =
base 10>,
> >> > +               "EndorsementKeyMod": "<256 bytes in base64>",
> >> > +               "SigningKeyMod": "<256 bytes in base64>"
> >> > +
> >> > +What:                /sys/class/firmware-attributes/*/attributes/Su=
re_Start/audit_log_entries
> >> > +Date:                March 29
> >> > +KernelVersion:       5.18
> >> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> >> > +Description:
> >> > +             'audit_log_entries' is a read-only file that returns t=
he events in
> >> > the log.
> >> > +
> >> > +                     Audit log entry format
> >> > +
> >> > +                     Byte 0-15:   Requested Audit Log entry  (Each =
Audit log is 16 bytes)
> >> > +                     Byte 16-127: Unused
> >> > +
> >> > +What:                /sys/class/firmware-attributes/*/attributes/Su=
re_Start/audit_log_entry_count
> >> > +Date:                March 29
> >> > +KernelVersion:       5.18
> >> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> >> > +Description:
> >> > +             'audit_log_entry_count' is a read-only file that retur=
ns the number
> >> > of existing
> >> > +             audit log events available to be read. Values are sepa=
rated using
> >> > comma (``,``)
> >> > +
> >> > +                     [No of entries],[log entry size],[Max number o=
f entries supported]
> >> > +
> >> > +             log entry size identifies audit log size for the curre=
nt BIOS
> >> > version.
> >> > +             The current size is 16 bytes but it can be up to 128 b=
ytes long in
> >> > future BIOS
> >> > +             versions.
> >> > --
> >> > 2.34.1
> >>
> >> Firstly apologies as I've done a poor job of following the updates to =
this series - so if this has already been discussed and agreed by more seas=
oned kernel contributors please feel free to disregard my comments :) I was=
 catching up on my inbox and had some thoughts.
> >
> > No worries.
> >
> >>
> >> For SPM - as this replaces password usage, is it done for all account =
types? It seems a bit odd having it be a replacement for the passwords but =
in it's own location and not in the same place as (for example) Admin/curre=
nt_password.
> >> For the Lenovo implementation I put certificate, signature and save_si=
gnature in the authentication/Admin directory and I realise your implementa=
tion is different with the keys but if the kek and sk are only used with th=
e Admin account then shouldn't they also be in that directory? It would be =
nice to have some commonality across vendors in my opinion.
> >>
> >
> > SPM (Security Platform Management) does not replace password usage and
> > it is done for the Admin account (Setup Password).  SPM is a security
> > feature available to the user to configure/update BIOS settings when
> > Sure Admin is enabled in BIOS.  One of the files provided under SPM is
> > the key _role and its value is set to =E2=80=98bios-spm.=E2=80=99   A =
=E2=80=98bios-spm=E2=80=99 role
> > indicates a password is used in combination with an
> > endorsement/signing key.  It is also the reason why SPM is kept
> > separate under the list of authentication attributes.
>
> Ah - I think I get it, and in that case I can see why you keep it separat=
e and it is a unique role.
> I withdraw my suggestion :)
>
> >
> >> For the Sure_Start I would propose de-branding this so it's generic an=
d I don't think it fits under attributes as it doesn't support any of the o=
ther required attribute fields. I think your implementation of an audit log=
 seems neat but if another vendor was to do similar it would be better to b=
e able to reuse the same attribute name and enable common tooling.
> >> I propose having this as just log/audit_entries and log/audit_count an=
d have the log folder in the top alongside authentication and attributes.
> >> If someone wants to add other logs in the future it would be a good pl=
ace to have them.
> >
> > I like the idea of having a log folder alongside authentication and
> > attributes where future logs can be placed.  Unfortunately, Sure_Start
> > is part of the security attributes  and the initial driver provides a
> > minimal implementation.   Other attributes associated with Sure_Start
> > and available in BIOS are  'SureStart Production Mode', 'Sure Start
> > Security Event Boot Notification', 'Sure Start BIOS Settings
> > Protection', 'Sure Start Secure Boot Keys Protection', and 'Sure Start
> > Security Event Policy'
>
> Aren't all of these just regular attributes that show up under the attrib=
utes folder (and have current_value and possible_value settings etc)? Do th=
ey get created in your equivalent of probing the BIOS to determine what att=
ributes are available or are they manually created entries? (I'm assuming a=
utomatic or they would be also added to the documentation)

'SureStart Production Mode', 'Sure Start Security Event Boot
Notification', 'Sure Start BIOS Settings Protection', 'Sure Start
Secure Boot Keys Protection', and 'Sure Start Security Event Policy'
are reported by BIOS therefore listed under attributes.  'Sure
Start/audit_log_entries and Sure_Start/audit_log_count_entries are
created manually and kept under attributes/Sure_Start; same location
as all other 'Sure Start' entries.

>
> It seemed to me the audit log entries were being handled differently beca=
use you had to specifically create the entries, with (I assume) some specia=
l handling for display?

Gathering the number of entries and reading each audit logs require
making multiple WMI calls (Security related).  If 'Sure Start' was not
part of a security feature, I would agree to move it under a log
directory; sadly it is not the case.
>
> Mark
