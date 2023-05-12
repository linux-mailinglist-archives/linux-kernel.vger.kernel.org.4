Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F01700BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbjELPfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241233AbjELPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:35:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD88B12A;
        Fri, 12 May 2023 08:35:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac82b07eb3so102783491fa.1;
        Fri, 12 May 2023 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683905718; x=1686497718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGClo5yQnuXbxJbb6N7eNBaPdwNH7dImKOaMeUWqjNk=;
        b=FdCnX2vKGhnL1s04fulB01XMFpqR3eKKjHsID5Hvotkqlozy/VxKNNVY+Nir6yzU9t
         4e7InJEIWAiXhBxP7sstdfehHk0GYKVH64GcNzVZpCvhdF69XJrjL9kKSPoWDcHpo0Cn
         kzAdC8b2xlooG5odHjWx+N16ywxXqLR4xi59wjp0yOX0GMLaBNinVHwcfyOyKwRYEo8E
         XeE7Wk3G0dudfJS/WadR4EKwnR0/GiaQJBQJ5L0PrkXfDeNNlaKx6vqgDJTBm7TDTG+1
         f/j2ZZw77LkUBfuI2mj5G3K0MGwlgeyA45ESClOWs86cPViPNbX6tbDB6glaYK+LXwEU
         Ochg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683905718; x=1686497718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGClo5yQnuXbxJbb6N7eNBaPdwNH7dImKOaMeUWqjNk=;
        b=hPxgoYQhRHxxJYx9cDsQDpjXj6FiQh2AD9wvaJUGB4m874inCJxkwqqQRCdnmjg7rX
         KTD7PYho24QTczMfL3bEiVFQQn0lrJhkCQuSit0j3U7KLR6BYE4XD6o6HorS/QA8FkgY
         LUPjK9okbZkefM+WxArNTd/e9u4jfO9LVUFFKrD7GoHO+95IvP+sJGiLrXRSWVU2HFX0
         H+LFpPqAcahZCtMSmBSVv40vHsbePmWX4W/XFG2ubEQBoGmBg1eW+uxrysxJu7xaYc/2
         79lMYEeDHawJeH40Sb94kdeo75Al+w+3ZXpsAgR4sBXT/MYaF4rCql2iA7Ok4OLwphIV
         nrgg==
X-Gm-Message-State: AC+VfDxEN0W7e5yz/PRxm4Rv/eiWoVZI1CE5033jFqM/0QgJpDUxizIc
        MIRdswKDSfqtRo08SWvmeq0I26MMM1Eles1WzRY=
X-Google-Smtp-Source: ACHHUZ5DFcntOBfjGXkq0x0qFwHKu2Qht8zuLK3cTtGceJPeALjMji/3H79vCk56D96zI9ulQKSFaWa9RsGHMnUnbIM=
X-Received: by 2002:a05:6512:963:b0:4f2:4bc2:fc35 with SMTP id
 v3-20020a056512096300b004f24bc2fc35mr3993596lft.53.1683905717720; Fri, 12 May
 2023 08:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-12-jorge.lopez2@hp.com>
 <ef445e78-5751-bd8f-44ce-d9beaebaac6@linux.intel.com> <CAOOmCE_dRivApf46KO1Cq-vHGsHVXNVCqbqF2NV4Y6SVpYx6hA@mail.gmail.com>
 <79db2a99-5cd7-19c0-212d-9e28869a6a18@linux.intel.com> <CAOOmCE9rNSJDbhoMgyEenog1CG6xG_cRoPNtYp--37DAi4iqsg@mail.gmail.com>
 <a8d1a232-d0f0-16ab-57a8-28e3b2f84@linux.intel.com>
In-Reply-To: <a8d1a232-d0f0-16ab-57a8-28e3b2f84@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 12 May 2023 10:34:48 -0500
Message-ID: <CAOOmCE-7WyqUzST=sOW-2iXkz0=07JGrEauA0h4cVZ67NPeTkQ@mail.gmail.com>
Subject: Re: [PATCH v12 11/13] HP BIOSCFG driver - surestart-attributes
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

On Fri, May 12, 2023 at 9:12=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 12 May 2023, Jorge Lopez wrote:
>
> > On Thu, May 11, 2023 at 4:32=E2=80=AFAM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Wed, 10 May 2023, Jorge Lopez wrote:
> > >
> > > > On Tue, May 9, 2023 at 8:57=E2=80=AFAM Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > >
> > > > > On Fri, 5 May 2023, Jorge Lopez wrote:
> > > > >
> > > > > > HP BIOS Configuration driver purpose is to provide a driver sup=
porting
> > > > > > the latest sysfs class firmware attributes framework allowing t=
he user
> > > > > > to change BIOS settings and security solutions on HP Inc.=E2=80=
=99s commercial
> > > > > > notebooks.
> > > > > >
> > > > > > Many features of HP Commercial notebooks can be managed using W=
indows
> > > > > > Management Instrumentation (WMI). WMI is an implementation of W=
eb-Based
> > > > > > Enterprise Management (WBEM) that provides a standards-based in=
terface
> > > > > > for changing and monitoring system settings. HP BIOSCFG driver =
provides
> > > > > > a native Linux solution and the exposed features facilitates th=
e
> > > > > > migration to Linux environments.
> > > > > >
> > > > > > The Linux security features to be provided in hp-bioscfg driver=
 enables
> > > > > > managing the BIOS settings and security solutions via sysfs, a =
virtual
> > > > > > filesystem that can be used by user-mode applications. The new
> > > > > > documentation cover HP-specific firmware sysfs attributes such =
Secure
> > > > > > Platform Management and Sure Start. Each section provides secur=
ity
> > > > > > feature description and identifies sysfs directories and files =
exposed
> > > > > > by the driver.
> > > > > >
> > > > > > Many HP Commercial notebooks include a feature called Secure Pl=
atform
> > > > > > Management (SPM), which replaces older password-based BIOS sett=
ings
> > > > > > management with public key cryptography. PC secure product mana=
gement
> > > > > > begins when a target system is provisioned with cryptographic k=
eys
> > > > > > that are used to ensure the integrity of communications between=
 system
> > > > > > management utilities and the BIOS.
> > > > > >
> > > > > > HP Commercial notebooks have several BIOS settings that control=
 its
> > > > > > behaviour and capabilities, many of which are related to securi=
ty.
> > > > > > To prevent unauthorized changes to these settings, the system c=
an
> > > > > > be configured to use a cryptographic signature-based authorizat=
ion
> > > > > > string that the BIOS will use to verify authorization to modify=
 the
> > > > > > setting.
> > > > > >
> > > > > > Linux Security components are under development and not publish=
ed yet.
> > > > > > The only linux component is the driver (hp bioscfg) at this tim=
e.
> > > > > > Other published security components are under Windows.
> > > > > >
> > > > > > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> > > > > >
> > > > > > ---
> > > > > > Based on the latest platform-drivers-x86.git/for-next
> > > > > > ---
>
> > > > > > +      */
> > > > > > +     if (count * LOG_ENTRY_SIZE > PAGE_SIZE)
> > > > > > +             return -EIO;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * We are guaranteed the buffer is 4KB so today all the e=
vent
> > > > > > +      * logs will fit
> > > > > > +      */
> > > > > > +     for (i =3D 0; i < count; i++) {
> > > > > > +             audit_log_buffer[0] =3D (i + 1);
> > > > > > +
> > > > > > +             /*
> > > > > > +              * read audit log entry at a time. 'buf' input va=
lue
> > > > > > +              * provides  the audit log entry to be read.  On
> > > > > > +              * input, Byte 0 =3D Audit Log entry number from
> > > > > > +              * beginning (1..254)
> > > > > > +              * Entry number 1 is the newest entry whereas the
> > > > > > +              * highest entry number (number of entries) is th=
e
> > > > > > +              * oldest entry.
> > > > > > +              */
> > > > > > +             ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_=
LOG,
> > > > > > +                                        HPWMI_SURESTART,
> > > > > > +                                        audit_log_buffer, 1, 1=
28);
> > > > > > +
> > > > > > +             if (ret >=3D 0 && (LOG_ENTRY_SIZE * i) < PAGE_SIZ=
E) {
> > > > >
> > > > > Can the second condition ever fail?
> > > > >
> > > > Only in the event BIOS data is corrupted.
> > >
> > > i runs from 0 to count - 1 and you prevented count * LOG_ENTRY_SIZE >
> > > PAGE_SIZE above. So what does the BIOS data have to do with that?
> >
> > BIOS guarantees the number of audit logs * LOG_ENTRY_SIZE will be less
> > than 4K (PAGE_SIZE)
> > Because Linux kernel trusts no one, we are checking that BIOS does not
> > report more events than it should.
>
> I know you're checking that.
>
> What I'm trying to say that even after that check, your own code does not
> trust that when i < count holds (as per the for loop termination
> condition), i * LOG_ENTRY_SIZE < count * LOG_ENTRY_SIZE.
>
> So what I'm trying to say is that this check:
>                 && (LOG_ENTRY_SIZE * i) < PAGE_SIZE
> ...is always true (and therefore unnecessary).
>

I partially agree.  If BIOS returns a  count size of 300 for the
current audit log entry size of 16 bytes, then this condition is
false.
(299 * 16 bytes (LOG_ENTRY_SIZE) ) is greater than 4K.
I am just trying to prevent conditions when BIOS could return invalid
audit_log_entry_count values.
If you still feel the code is unnecessary then I will proceed to
remove the check.

> > WMI expects the input buffer to include the current audit log number
> > (audit_log_buffer[0] =3D (i + 1);) which is i+1.
>
> I don't see how this is relevant to what I was asking.
>
Just adding information how the messages were retrieved.
Please ignore.

> > > > > > +                     memcpy(buf, audit_log_buffer, LOG_ENTRY_S=
IZE);
> > > > > > +                     buf +=3D LOG_ENTRY_SIZE;
> > > > > > +             } else {
> > > > > > +                     /*
> > > > > > +                      * Encountered a failure while reading
> > > > > > +                      * individual logs. Only a partial list o=
f
> > > > > > +                      * audit log will be returned.
> > > > > > +                      */
> > > > > > +                     count =3D i + 1;
> > > > > > +                     break;
> > > > > > +             }
> > > > >
> > > > > Reverse order, do error handling with break first.
> > > > Done!
> > > > >
> > > > > Why not return i * LOG_ENTRY_SIZE directly (or at the end), no ne=
ed to
> > > > > tweak count?
> > > >
> > > > Done!
> > > > >
> > > > > > +     }
> > > > > > +
> > > > > > +     return count * LOG_ENTRY_SIZE;
> > > > > > +}
>
> --
>  i.
