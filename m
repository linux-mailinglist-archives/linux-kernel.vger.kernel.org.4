Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C306D4DF6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjDCQdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjDCQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:33:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA41FE9;
        Mon,  3 Apr 2023 09:33:39 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b6so10920152ljr.1;
        Mon, 03 Apr 2023 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680539618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkZFZlPRMlYKwjpbbTT6jEeFeXceUIO5EZhwvdzI3bQ=;
        b=qTi4uuh5mexUYWC4r1FH6lOdiprJe+MyZIUfSAKv/iQVigRK0vHesgdj6UHXNFRGOK
         STDUrBkbc3VLbXjMBxgmozPlfIk2I0NVGXpaW+T2IhwpPdmLewkSLEZ0Tm9T7Ylon8xo
         Gkc+QOIOh+wmCzxBJe6YR5EDCu78m1zJzZHk06/ZxPrMhiPRh7PK5QcWZb8rlETOpAs0
         jw6tElzBqaHLThTrw2Jbnkqw4seBBh2/x8pUMCcGzmrnXP1v1Cyhb9+truhhmzmJ7455
         i2/4agEv3rZJ8s+R6E6PuTXkCsw0Zq3+BHzMUNh86O0VC/kgJcDBKd3tX7cAOFabsm1Z
         aQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkZFZlPRMlYKwjpbbTT6jEeFeXceUIO5EZhwvdzI3bQ=;
        b=aorSf1Fl8dhhajSklWQgKRxu/kOJgsEwDxLJnL2qxVoaKopUKVWZEbDpoj6x0tyVWr
         XVQVLCLu9Cs7ptkMPkrDRwvSEr/sEvCdeZvGbBDcNOs5U7oNk13A3PezYhZH+fEuNZ+C
         JB0GunQ+GaS5KSjFOGh4VPsjJKyxWgfTcANHMd5gOaXShZuO94+EhevMxi+8O3XOCZYO
         +Bc/+zqWdmwVyHgGdcUz2dVEhmQb7TDV+1PT0tv3VZzRGtnKF2vxZ3zk07nwpaA990iw
         auKaizgn6i+gn7Jvk54eUjBrPlUu37bTgBU4eDQaJ+VTEMCDEVfLUkmeRsb/qHjpe9mh
         j6OA==
X-Gm-Message-State: AAQBX9dk8Mvq07hld2ouzLkLDxOBfMViXhQOUrxsO8KfTAi87XJpgE1p
        u+i2kemJ+07b/tNLwIkVadSmQrvA8cc7JEye9kO6UL7XtUI=
X-Google-Smtp-Source: AKy350b0wUTR7gDktVVgeGYmRALTgZK1FygHgbpWCrF+54g/4oIhYITpIoRtBCvvNPPAcsND1DmuiERKtua2eR6+ViM=
X-Received: by 2002:a2e:9809:0:b0:2a4:eb14:249b with SMTP id
 a9-20020a2e9809000000b002a4eb14249bmr35637ljj.7.1680539617944; Mon, 03 Apr
 2023 09:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230309201022.9502-1-jorge.lopez2@hp.com> <20230309201022.9502-5-jorge.lopez2@hp.com>
 <6da33dcc-0526-4398-bf35-655b64d07e20@t-8ch.de>
In-Reply-To: <6da33dcc-0526-4398-bf35-655b64d07e20@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 3 Apr 2023 11:33:20 -0500
Message-ID: <CAOOmCE_kzVnUr9WoPAEu-e+E5=-RfHUCjj6U7kL_yhqKHsP84g@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] Introduction of HP-BIOSCFG driver [4]
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Please see my comments below.

On Sat, Apr 1, 2023 at 6:58=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> Hi Jorge,
>
> Hans asked me to do a review of your series, so this is it.
>
> I'll start with patch 4 because it is the one with the docs and build
> system changes.
> Reviews of the other patches and the code of this patch will follow.
>
> In my opinion the best way forward is to drop some of the non-core
> and duplicated functionality.
> The reduced scope will make review and rework easier and therefore speed
> up the process.
>
> Please also Cc the general kernel mailing list
> linux-kernel@vger.kernel.org for future revisions.
> This will make sure the patchset is picked up and tested by the bots.
>
Will do.

> On 2023-03-09 14:10:22-0600, Jorge Lopez wrote:
> > The purpose for this patch is submit HP BIOSCFG driver to be list of
> > HP Linux kernel drivers.  The driver include a total of 12 files
> > broken in several patches.
>
> No need for this paragraph.

I will remove it in the next submission.

>
> > HP BIOS Configuration driver purpose is to provide a driver supporting
> > the latest sysfs class firmware attributes framework allowing the user
> > to change BIOS settings and security solutions on HP Inc.=E2=80=99s com=
mercial
> > notebooks.
>
> Here it says "notebooks", below "PC's". Does it also support
> non-notebook machines?

The initial release of the driver will be supported for business notebooks.
Although the driver is not targeted for non-notebooks machines, the
driver was tested on non-notebooks in the event a decision is made to
targets them

> > --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > @@ -22,6 +22,13 @@ Description:
> >                       - integer: a range of numerical values
> >                       - string
> >
> > +             HP specific types
> > +             -----------------
> > +                     - ordered-list - a set of ordered list valid valu=
es
> > +                     - sure-admin
>
> Does sure-admin still exist?

I will remove that entry.   Sure-admin no longer exist as part of the drive=
r

>> > +             HP specific class extensions
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
Element listed first has the
> > +                                     hightest priority. Writing the li=
st in a different order to
> > +                                     current_value alters the priority=
 order for the particular
> > +                                     attribute.
> > +
> > +             "sure-start"-type specific properties:
> > +
> > +             audit_log_entries:
> > +                                     A read-only file that returns the=
 events in the log.
> > +
> > +                                     Audit log entry format
> > +
> > +                                     Byte 0-15:   Requested Audit Log =
entry  (Each Audit log is 16 bytes)
> > +                                     Byte 16-127: Unused
> > +
> > +             audit_log_entry_count:
> > +                                     A read-only file that returns the=
 number of existing audit log events available to be read.
> > +
> > +                                     [No of entries],[log entry size],=
[Max number of entries supported]
>
> sysfs is based on the idea of "one-value-per-file".
> The two properties above violate this idea.
> Maybe a different interface is needed.
>

Both properties report a single string separated by semicolon.  This
is not different from listing all elements in a single string
separated by semicolon.

> Are these properties very important for the first version of this
> driver? If not I would propose to drop them for now and resubmit them
> as separate patches after the main driver has been merged.
>
We want the initial driver to have all predefined properties available
first.   There are plans to add future properties and features which
will be submitted as patches.

> > +
> > +
> >  What:                /sys/class/firmware-attributes/*/authentication/
> >  Date:                February 2021
> >  KernelVersion:       5.11
> > @@ -206,7 +245,7 @@ Description:
> >               Drivers may emit a CHANGE uevent when a password is set o=
r unset
> >               userspace may check it again.
> >
> > -             On Dell and Lenovo systems, if Admin password is set, the=
n all BIOS attributes
> > +             On Dell, Lenovo, and HP systems, if Admin password is set=
, then all BIOS attributes
>
> No comma after "Lenovo"

Will do
>
> >               require password validation.
> >               On Lenovo systems if you change the Admin password the ne=
w password is not active until
> >               the next boot.
> > @@ -296,6 +335,15 @@ Description:
> >                                               echo "signature" > authen=
tication/Admin/signature
> >                                               echo "password" > authent=
ication/Admin/certificate_to_password
> >
> > +             HP specific class extensions
> > +             --------------------------------
> > +
> > +             On HP systems the following additional settings are avail=
able:
> > +
> > +             role: enhanced-bios-auth:
> > +                                     This role is specific to Secure P=
latform Management (SPM) attribute.
> > +                                     It requires configuring an endors=
ement (kek) and signing certificate (sk).
> > +
> >
> >  What:                /sys/class/firmware-attributes/*/attributes/pendi=
ng_reboot
> >  Date:                February 2021
> > @@ -364,3 +412,60 @@ Description:
> >               use it to enable extra debug attributes or BIOS features =
for testing purposes.
> >
> >               Note that any changes to this attribute requires a reboot=
 for changes to take effect.
> > +
> > +
> > +             HP specific class extensions
> > +             --------------------------------
> > +
> > +What:                /sys/class/firmware-attributes/*/authentication/S=
PM/kek
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description: 'kek' is a write-only file that can be used to configure =
the
> > +             RSA public key that will be used by the BIOS to verify
> > +             signatures when setting the signing key.  When written,
> > +             the bytes should correspond to the KEK certificate
> > +             (x509 .DER format containing an OU).  The size of the
> > +             certificate must be less than or equal to 4095 bytes.
> > +
> > +
> > +What:                /sys/class/firmware-attributes/*/authentication/S=
PM/sk
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description: 'sk' is a write-only file that can be used to configure t=
he RSA
> > +             public key that will be used by the BIOS to verify signat=
ures
> > +             when configuring BIOS settings and security features.  Wh=
en
> > +             written, the bytes should correspond to the modulus of th=
e
> > +             public key.  The exponent is assumed to be 0x10001.
>
> The names of the files 'SPM', 'kek' and 'sk' are cryptic.

SPM - Secure Platform Manager
kek -  Key-Encryption-Key (KEK)
sk - Signature Key (SK)

Those abbreviations were used because they are industry standard and
reduce the  size of the commands.  Any suggestions?
>
> > +
> > +
> > +What:                /sys/class/firmware-attributes/*/authentication/S=
PM/status
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description: 'status' is a read-only file that returns ASCII text repo=
rting
> > +             the status information.
> > +
> > +               State:  Not Provisioned / Provisioned / Provisioning in=
 progress
> > +               Version:  Major.   Minor
> > +               Feature Bit Mask: <16-bit unsigned number display in he=
x>
> > +               SPM Counter: <16-bit unsigned number display in base 10=
>
> > +               Signing Key Public Key Modulus (base64):
> > +               KEK Public Key Modulus (base64):
>
> This also violates 'one-value-per-file'.
> Can it be split into different files?

I will split the information in multiple files.

> This would also remove the need for the statusbin file.
>
Status bin is used by GUI applications where data is managed
accordingly instead of individual lines.

> For the values:
>
> Status: I think symbolic names are better for sysfs:
>         not_provisioned, provisioned, etc.
> Feature Bit Mask: Use names.
> Keys: It would be nicer if these could be shown directly in the files
>       that can be used to configure them.
>
> As before, what is really needed and what can be added later?

Status is needed when the user enables Secure Platform Manager in BIOS
and  KEK and/or SK are configured.

>
> > +
> > +
> > +What:                /sys/class/firmware-attributes/*/authentication/S=
PM/statusbin
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description: 'statusbin' is a read-only file that returns identical st=
atus
> > +             information reported by 'status' file in binary format.
>
> How does this binary format work?

Yes.  Status bin is used by GUI applications where data is managed
accordingly instead of individual lines

>
> > +
> > +
> > +What:                /sys/class/firmware-attributes/*/attributes/last_=
error
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description: 'last_error' is a read-only file that returns WMI error n=
umber
> > +             and message reported by last WMI command.
>
> Does this provide much value?
> Or could this error just be logged via pr_warn_ratelimited()?

It is specially needed to determine if WMI calls reported an error.
This property is similar to the one provided by both Dell and Lenovo
drivers
>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f32538373164..663ae73fb8be 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9367,6 +9367,12 @@ S:     Obsolete
> >  W:   http://w1.fi/hostap-driver.html
> >  F:   drivers/net/wireless/intersil/hostap/
> >
> > +HP BIOSCFG DRIVER
> > +M:   Jorge Lopez <jorge.lopez2@hp.com>
> > +L:      platform-driver-x86@vger.kernel.org
>
> Broken whitespace

I will be corrected.

>
> > +S:   Maintained
> > +F:   drivers/platform/x86/hp/hp-bioscfg/
> > +
> >  HP COMPAQ TC1100 TABLET WMI EXTRAS DRIVER
> >  L:   platform-driver-x86@vger.kernel.org
> >  S:   Orphan
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/Makefile b/drivers/plat=
form/x86/hp/hp-bioscfg/Makefile
> > new file mode 100644
> > index 000000000000..529eba6fa47f
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/Makefile
> > @@ -0,0 +1,13 @@
> > +obj-$(CONFIG_HP_BIOSCFG) :=3D hp-bioscfg.o
>
> The kbuild part that defines CONFIG_HP_BIOSCFG is missing, so this is
> never built.
>

This is an oversight on my part.  The changes were made but never made
part of the review.

> drivers/platform/x86/hp/Makefile also needs to reference this Makefile.
>
> After fixing up Kbuild please build the driver with "make W=3D1" and clea=
n
> up all the unused functions/variables.
> (This won't catch unused stuff from bioscfg.c, so you have to check
> these manually)
>

Thank you.  I will make sure to include it
