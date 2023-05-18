Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64D37085B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjERQNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjERQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:13:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8B5E56;
        Thu, 18 May 2023 09:13:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f13c577e36so2659311e87.1;
        Thu, 18 May 2023 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684426408; x=1687018408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Weh/xg3Fwf8aOR0QMCh7viyOOc+gDq+9XGJdCqTazfo=;
        b=kReWF3uCikxpmmDN+2hhPLjcGW7kWcc1e9CV4266Oo+nNk+1Pv3gxBHiHH7sW4t4VF
         Djghi1LB5DEWntJgEkuZaM85dM0mqpqMv/4fyEWVEGQUDTgvu/N0uhxvzlbrTPEr2AYb
         MI4gMxeBk1XNPGpNjDv9EeRjk4pwoqU1+p9NoY9tlYpa277kyGiVxFJjrwvYT2M49s9k
         fliXhRRJDPMB6MnkjJcO7Q1aVdUYNEIZH2dKuepMc3nviq8XreswvW7HUpegNIjQ8g85
         u+kbdlLoSfAQVP3Fh10+lcxaKgWdc6Tnxa92lERRL/MIbaFZyOaRe9ZaAM8LXQ5bK06R
         Tiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684426408; x=1687018408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Weh/xg3Fwf8aOR0QMCh7viyOOc+gDq+9XGJdCqTazfo=;
        b=YZYtqZoBMHmN7hzjpARtDmCb+CcjCJ+YHZEtwjTf2p6YnnTcrLqLaKqoesI5Zv1cv6
         gffsat0yB2BHx6FE8AyuU7cJAolkDAoOe44PJoMnBhY5QW5um//Ie9xgf7Lmsz2MvZtv
         sxqM7RG4Yfvdu7tGCfd7Lud7jbKNCwKALEoeI7K4UyCxrWgKDXdbv8SSK4uYWpZ9xnW1
         V3vimhAPITf2ijaWToS7RLwK7oLk5stFua+kx5p3hvG1GK8STTdbi84Uxdle3Oxi0V1v
         EMlWl2wWKBMLTwbsPNcPeH+vJaMHWTOF7+iIrN3TpOhvMyBX9UCFKTvqzvevNnHbDBFE
         jH3Q==
X-Gm-Message-State: AC+VfDynYt46+o/4vRH8wNE6ava7UpJUG4MtfXNOdLwbWd/iCUj7Jh3I
        rrMnH9wp4nv0/rdP3uF6/7VzW30QBt+kmx+uZXo=
X-Google-Smtp-Source: ACHHUZ7uTWpsHvIsiOjWcJd+GPZT8D1qjhsHgtim4Heb/HFT90on1HvcwQ3rkQIrKbzmHMBt1LocbvkOq/GKDqQztqU=
X-Received: by 2002:a19:5214:0:b0:4f3:8269:7228 with SMTP id
 m20-20020a195214000000b004f382697228mr1389597lfb.68.1684426407226; Thu, 18
 May 2023 09:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230517155026.28535-1-jorge.lopez2@hp.com> <20230517155026.28535-2-jorge.lopez2@hp.com>
 <7e5ee08c-e157-9f2c-3f87-ae88b503fc4d@infradead.org>
In-Reply-To: <7e5ee08c-e157-9f2c-3f87-ae88b503fc4d@infradead.org>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Thu, 18 May 2023 11:12:55 -0500
Message-ID: <CAOOmCE-9M6rJSC6Tcvts6Z=1k0t1nrK_9P02TVLfYnJu8yfgww@mail.gmail.com>
Subject: Re: [PATCH v14 01/13] hp-bioscfg: Documentation
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
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

On Wed, May 17, 2023 at 6:42=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi--
>
> On 5/17/23 08:50, Jorge Lopez wrote:
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
>
> IMO it doesn't help to have this blurb repeated in each patch.
>
> The commit message should describe what this patch does and why.
>
> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >   .../testing/sysfs-class-firmware-attributes   | 102 +++++++++++++++++=
-
> >   1 file changed, 100 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes =
b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > index 4cdba3477176..f8d6c089228b 100644
> > --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > @@ -22,6 +22,11 @@ Description:
> >                       - integer: a range of numerical values
> >                       - string
> >
> > +             HP specific types
> > +             -----------------
> > +                     - ordered-list - a set of ordered list valid valu=
es
> > +
> > +
> >               All attribute types support the following values:
> >
> >               current_value:
> > @@ -126,6 +131,22 @@ Description:
> >                                       value will not be effective throu=
gh sysfs until this rule is
> >                                       met.
> >
> > +             HP specific class extensions
> > +             ------------------------------
> > +
> > +             On HP systems the following additional attributes are ava=
ilable:
> > +
> > +             "ordered-list"-type specific properties:
> > +
> > +             elements:
> > +                                     A file that can be read to obtain=
 the possible
> > +                                     list of values of the <attr>. Val=
ues are separated using
> > +                                     semi-colon (``;``). The order ind=
ividual elements are listed
> > +                                     according to their priority.  An =
element listed first has the
>
> I have trouble parsing "The order individual elements are list
> according to their property."

I will update the text and provide a more comprehensive statement.
For instance...  "Values are separated using semi-colon (``;``) and
listed according to their priority."
>
> > +                                     highest priority. Writing the lis=
t in a different order to
> > +                                     current_value alters the priority=
 order for the particular
> > +                                     attribute.
> > +
> >   What:               /sys/class/firmware-attributes/*/authentication/
> >   Date:               February 2021
> >   KernelVersion:      5.11
> > @@ -206,7 +227,7 @@ Description:
> >               Drivers may emit a CHANGE uevent when a password is set o=
r unset
> >               userspace may check it again.
> >
> > -             On Dell and Lenovo systems, if Admin password is set, the=
n all BIOS attributes
> > +             On Dell, Lenovo and HP systems, if Admin password is set,=
 then all BIOS attributes
> >               require password validation.
> >               On Lenovo systems if you change the Admin password the ne=
w password is not active until
> >               the next boot.
>
> > @@ -364,3 +394,71 @@ Description:
> >               use it to enable extra debug attributes or BIOS features =
for testing purposes.
> >
> >               Note that any changes to this attribute requires a reboot=
 for changes to take effect.
> > +
> > +
> > +             HP specific class extensions - Secure Platform Manager (S=
PM)
> > +             --------------------------------
> > +
> > +What:                /sys/class/firmware-attributes/*/authentication/S=
PM/kek
> > +Date:                March 29
>
> Date: should be Month Year or Month Day Year according to other files
> (although it is apparently not specified as far as my quick searching
> found).

Date format will be changed to Month Year across the file.
Thank you.
>
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'kek' Key-Encryption-Key is a write-only file that can be=
 used to configure the
> > +             RSA public key that will be used by the BIOS to verify
> > +             signatures when setting the signing key.  When written,
> > +             the bytes should correspond to the KEK certificate
> > +             (x509 .DER format containing an OU).  The size of the
> > +             certificate must be less than or equal to 4095 bytes.
> > +
> > +What:                /sys/class/firmware-attributes/*/authentication/S=
PM/sk
> > +Date:                March 29
>
> Ditto.
>
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'sk' Signature Key is a write-only file that can be used =
to configure the RSA
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
>
> Ditto.
>
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'status' is a read-only file that returns ASCII text in J=
SON format reporting
> > +             the status information.
> > +
> > +               "State": "not provisioned | provisioned | provisioning =
in progress ",
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
>
> Ditto.
>
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'audit_log_entries' is a read-only file that returns the =
events in the log.
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
>
> Ditto.
>
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'audit_log_entry_count' is a read-only file that returns =
the number of existing
> > +             audit log events available to be read. Values are separat=
ed using comma (``,``)
> > +
> > +                     [No of entries],[log entry size],[Max number of e=
ntries supported]
> > +
> > +             log entry size identifies audit log size for the current =
BIOS version.
> > +             The current size is 16 bytes but it can be up to 128 byte=
s long in future BIOS
> > +             versions.
