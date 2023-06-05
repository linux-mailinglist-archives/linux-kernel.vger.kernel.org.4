Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F5B72277B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjFENdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjFENdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:33:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C6FCD;
        Mon,  5 Jun 2023 06:33:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1adf27823so42139591fa.2;
        Mon, 05 Jun 2023 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685971997; x=1688563997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yl2FRRZbqp6hkInYnbnTkh2CQSLwc6kpHyElfV11jp4=;
        b=nJKXh53CYDqPRRUCBt0EeTg0bIzYC1Z6d+GcW4Z59Nw0iY5koUcaMsIGKf2ORLIQ24
         ONhba79cdf4J0TnhZBXhtMf3EPPHewPbJ1IDptP77tTVEAY2snKzC8F4WE8FK/kMF01w
         9Mf8hU/Y8IQoaa/AbJO0SBstyldrnkvB5WNgtHUgFmyDS4Upgl5EsJVLQQRj9ZJFH3lA
         Y+v2aLiePLz5HWZMge6E7XU8OQ0xMLO74qMdGYgE4PBlDLWsY2JvCcNH9hA5u6+L3bB1
         gGLbC5FZe/QSuC0XA/BN6xLmgLwB5IPbkuQRD2lI23/ZWXZz/OqxjdGZkSR237mNBZ08
         8v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685971997; x=1688563997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl2FRRZbqp6hkInYnbnTkh2CQSLwc6kpHyElfV11jp4=;
        b=AP0KNXSPmG2xEcJ2oJJm+BSHbVR0RZT+YS/d7Hx/wISmnz9dysaiFucraw6Uwo8WWi
         3AurffgE/Bmf87+QrzlVzz62IJmyNxe7e4lSc+hyBMaNueix7W98tdBLY8fYyQWgrraG
         mnotoGA+2MFaENYuyrdXSI42BzpijIcQtLEMJkYFRtXuayjQBSiEgtRsnMkC/baWf/ky
         qsOcEeufn1h/ZpzOH23R8YuAozmWS5cyAiuLwmw34LMnXDRAW6g+1kAlE0BKSGiZ2SIt
         o8Z9WcqN0vH24F0maZJaRf6hKLGzO7TicCCNzy7Zd/ToYjwn5B1p24qH73hVisIqYiUG
         fV+g==
X-Gm-Message-State: AC+VfDxXASeuyFvOVs9ojNT77f6tTIolGftYeye282qVj33mVMQyThe4
        8XS7veWyxKtW/3JaPx+Qst5jjv20Nm75j7vthqc=
X-Google-Smtp-Source: ACHHUZ7YKBeNxLNrxcOxiF/3NT42dU2EAVK/I4SAAk/05LVJNAoDhCsUWzWxmTgxJQA+jUdRfDPixCqQVCdxPUa8Me0=
X-Received: by 2002:a05:651c:412:b0:2ad:99b6:1728 with SMTP id
 18-20020a05651c041200b002ad99b61728mr3578309lja.24.1685971997091; Mon, 05 Jun
 2023 06:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230602131044.3297-1-jorge.lopez2@hp.com> <20230602131044.3297-2-jorge.lopez2@hp.com>
 <39a19a0b-610d-52bf-5050-eb870ad2e619@infradead.org>
In-Reply-To: <39a19a0b-610d-52bf-5050-eb870ad2e619@infradead.org>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 5 Jun 2023 08:32:39 -0500
Message-ID: <CAOOmCE9jmPpG8Do1h3uaMX9GKoioBLwak_3BeBoGPTtUj0Yj5Q@mail.gmail.com>
Subject: Re: [PATCH v16 01/13] hp-bioscfg: Documentation
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

On Fri, Jun 2, 2023 at 5:55=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 6/2/23 06:10, Jorge Lopez wrote:
>
> >
> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  .../testing/sysfs-class-firmware-attributes   | 101 +++++++++++++++++-
> >  1 file changed, 99 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes =
b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > index 4cdba3477176..df9904b9f39c 100644
> > --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > @@ -126,6 +131,21 @@ Description:
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
> > +                                     semi-colon (``;``) and listed acc=
ording to their priority.
> > +                                     An element listed first has the h=
ighest priority. Writing
> > +                                     the list in a different order to =
current_value alters
> > +                                     the priority order for the partic=
ular attribute.
> > +
> >  What:                /sys/class/firmware-attributes/*/authentication/
> >  Date:                February 2021
> >  KernelVersion:       5.11
>
> Why 5.11 and that date?

Date and Kernel values were provided by an earlier submitter.

>
> > @@ -364,3 +393,71 @@ Description:
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
> > +Date:                March 2023
> > +KernelVersion:       5.18
>
> Why 5.18 and that date?

It is the minimum kernel version where firmware-attributes are
supported and date when we expected hp-bioscfg driver support to be
available.
The driver, kernel versions and date changes weekly so we were placing
those dates and versions as tentative.
Any suggestions for Date and KernelVersion fields?

>
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
> > +Date:                March 2023
> > +KernelVersion:       5.18
>
> Why 5.18 and that date?

See previous explanation.

>
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
> > +Date:                March 2023
> > +KernelVersion:       5.18
>
> Why 5.18 and that date?

See previous explanation.

>
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'status' is a read-only file that returns ASCII text in J=
SON format reporting
> > +             the status information.
> > +
> > +               "State": "not provisioned | provisioned | provisioning =
in progress ",
>
> Drop the space after "in progress" ?

Done!

>
> > +               "Version": " Major. Minor ",
>
> So Major. should have a space before and after it? and Minor should have =
a space after it?

Neither.  I will remove the space before and after for both Major and
Minor.    "Major.Minor"

>
> > +               "Nonce": <16-bit unsigned number display in base 10>,
> > +               "FeaturesInUse": <16-bit unsigned number display in bas=
e 10>,
> > +               "EndorsementKeyMod": "<256 bytes in base64>",
> > +               "SigningKeyMod": "<256 bytes in base64>"
> > +
> > +What:                /sys/class/firmware-attributes/*/attributes/Sure_=
Start/audit_log_entries
> > +Date:                March 2023
> > +KernelVersion:       5.18
>
> Why 5.18 and that date?

It is the minimum kernel version where firmware-attributes are
supported and date when we expected hp-bioscfg driver support to be
available.
The driver, kernel versions and date changes weekly so we were placing
those dates and versions as tentative.
Any suggestions for Date and KernelVersion fields?

>
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
> > +Date:                March 2023
> > +KernelVersion:       5.18
>
> Why 5.18 and that date?

See earlier explanation

>
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description:
> > +             'audit_log_entry_count' is a read-only file that returns =
the number of existing
> > +             audit log events available to be read. Values are separat=
ed using comma (``,``)
>
> End the sentence above with a '.' please.

Done!

>
> > +
> > +                     [No of entries],[log entry size],[Max number of e=
ntries supported]
> > +
> > +             log entry size identifies audit log size for the current =
BIOS version.
> > +             The current size is 16 bytes but it can be up to 128 byte=
s long in future BIOS
> > +             versions.
>
> Thanks.
> --
> ~Randy
