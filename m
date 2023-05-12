Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3913F70098E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbjELNzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjELNz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:55:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4781FD7;
        Fri, 12 May 2023 06:55:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f13bfe257aso11221710e87.3;
        Fri, 12 May 2023 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683899724; x=1686491724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvoLfYzvWUCgmuvSbtKdObQkHFSKgSRFJiD4mJ91vzE=;
        b=CfIIO2mMsdhsrn1U+vwVnebzIyXHmtQRKasn4WiXhIXQ/pq+yabQXrC/khfiaJEnmh
         VihdMUJOgHeCmWdOHCXRzVp+8V6E4x92g5MLZJDqg5+yLTftUUC6S8Rera2G0DTyjAHT
         AykksXLiGe6ecrhr3D11QJUqs3UWA6AOvg4nLsrj+6ekOPc090pY5alJPJma/SqNG7g6
         o8TT4p2Nl3RtYGnBR2iJdPkqEwLDDHPKDOHdrW5OgPWiSpvbwBlRmPIAUJiO38V/j3CV
         IJ8x2ixW7NRjHyzSYEPEAR312F/QmvT7pCWhumeB8yumGCLxtcGq8jM8S7YwRgent7MH
         owSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683899724; x=1686491724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvoLfYzvWUCgmuvSbtKdObQkHFSKgSRFJiD4mJ91vzE=;
        b=kzqxyETh9QTVXA1NlLGewARb9LjWf4gm44Dj7UXqHhrjpKedZvE14LiY9fa/eQL0ZV
         kGIqfoefOmddl54X9VX/ulWgBjIDbHTE/I2nBcclnvmKRzPwmgESAl0jCDx3hjclYe5z
         38IE75kdtNuHLKuNTOfXsTkI1CfldnVVlO6XfDFGlDJ4MlhTKOc1s7QP0Xc352rrOweE
         tKanZTyDzNNTmJTDUvDViP5sU/NhXclDHv20NnxnYbT10iMT6e3+u7pkJpHOiZKW5VQZ
         Nw06j5VtLaw2StI7lm0Nofgmb0JrPi/nKDLRKbqbf9HlfOVQsGu/xmfI8qs6PkNDsdA2
         6g6A==
X-Gm-Message-State: AC+VfDwM9GjVZ2MoGFVdS+ClmahbQFLZ5TK9VhSc03T+/dLsMk9OR9w9
        Kc04j6XovU0Lq3VAKpfx+SAY7396wvQIh8CoxiY=
X-Google-Smtp-Source: ACHHUZ5O0n4pbWl+rMF0PwUgcm43Jwx3w9FRbLDUJRFjeQFNlIQbMu3f7jhL46D5tbWd85e3VRqk/KS9Ep4jtyVJKEA=
X-Received: by 2002:ac2:4293:0:b0:4f0:9126:b7e3 with SMTP id
 m19-20020ac24293000000b004f09126b7e3mr3142519lfh.26.1683899724280; Fri, 12
 May 2023 06:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-12-jorge.lopez2@hp.com>
 <ef445e78-5751-bd8f-44ce-d9beaebaac6@linux.intel.com> <CAOOmCE_dRivApf46KO1Cq-vHGsHVXNVCqbqF2NV4Y6SVpYx6hA@mail.gmail.com>
 <79db2a99-5cd7-19c0-212d-9e28869a6a18@linux.intel.com>
In-Reply-To: <79db2a99-5cd7-19c0-212d-9e28869a6a18@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 12 May 2023 08:54:54 -0500
Message-ID: <CAOOmCE9rNSJDbhoMgyEenog1CG6xG_cRoPNtYp--37DAi4iqsg@mail.gmail.com>
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

On Thu, May 11, 2023 at 4:32=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 10 May 2023, Jorge Lopez wrote:
>
> > On Tue, May 9, 2023 at 8:57=E2=80=AFAM Ilpo J=C3=A4rvinen
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
> > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attribute=
s.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > > > new file mode 100644
> > > > index 000000000000..b627c324f6a6
> > > > --- /dev/null
> > > > +++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > > > @@ -0,0 +1,133 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Functions corresponding to sure start object type attributes un=
der
> > > > + * BIOS for use with hp-bioscfg driver
> > > > + *
> > > > + *  Copyright (c) 2022 HP Development Company, L.P.
> > > > + */
> > > > +
> > > > +#include "bioscfg.h"
> > > > +#include <linux/types.h>
> > > > +
> > > > +/* Maximum number of log entries supported when log entry size is =
16
> > > > + * bytes.  This value is calculated by dividing 4096 (page size) b=
y
> > > > + * log entry size.
> > > > + */
> > > > +#define LOG_MAX_ENTRIES              254
> > > > +
> > > > +/*
> > > > + * Current Log entry size.  This value size will change in the
> > > > + * future. The driver reads a total of 128 bytes for each log entr=
y
> > > > + * provided by BIOS but only the first 16 bytes are used/read.
> > > > + */
> > > > +#define LOG_ENTRY_SIZE               16
> > > > +
> > > > +/*
> > > > + * audit_log_entry_count_show - Reports the number of
> > > > + *                           existing audit log entries available
> > > > + *                           to be read
> > > > + */
> > > > +static ssize_t audit_log_entry_count_show(struct kobject *kobj,
> > > > +                                       struct kobj_attribute *attr=
, char *buf)
> > > > +{
> > > > +     int ret;
> > > > +     u32 count =3D 0;
> > > > +
> > > > +     ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
> > > > +                                HPWMI_SURESTART,
> > > > +                                &count, 1, sizeof(count));
> > > > +
> > >
> > > Extra newline.
> > Done!
> > >
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +
> > > > +     return sysfs_emit(buf, "%d,%d,%d\n", count, LOG_ENTRY_SIZE,
> > > > +                       LOG_MAX_ENTRIES);
> > >
> > > Why 3 values instead of 1?
> > This version of BIOS only returns the number of audit log events availa=
ble.
> > The other two values are the current log entry size which today is
> > hardcoded.  This will change in future when BIOS returns the log entry
> > size.
>
> And you cannot provide the others in separate sysfs files?

Yes, the information can be provided in separate files.   Because two
out of three values are currently static, it was decided to keep all
information on a single sysfs file.
The documentation reads ...

What: /sys/class/firmware-attributes/*/attributes/Sure_Start/audit_log_entr=
y_count
Date: March 29
KernelVersion: 5.18
Contact: "Jorge Lopez" <jorge.lopez2@hp.com>
Description:
'audit_log_entry_count' is a read-only file that returns the number of exis=
ting
audit log events available to be read. Values are separated using comma (``=
,``)

[No of entries],[log entry size],[Max number of entries supported]

log entry size identifies audit log size for the current BIOS version.
The current size is 16 bytes but it can be up to 128 bytes long
in future BIOS versions.

>
> > > > +}
> > > > +
> > > > +/*
> > > > + * audit_log_entries_show() - Return all entries found in log file
> > > > + */
> > > > +static ssize_t audit_log_entries_show(struct kobject *kobj,
> > > > +                                   struct kobj_attribute *attr, ch=
ar *buf)
> > > > +{
> > > > +     int ret;
> > > > +     int i;
> > > > +     u32 count =3D 0;
> > > > +     u8 audit_log_buffer[128];
> > > > +
> > > > +     // Get the number of event logs
> > > > +     ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
> > > > +                                HPWMI_SURESTART,
> > > > +                                &count, 1, sizeof(count));
> > > > +
> > >
> > > Extra newline.
> > Done!
> > >
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +
> > > > +     /*
> > > > +      * The show() api will not work if the audit logs ever go
> > > > +      *  beyond 4KB
> > >
> > > Extra space.
> > Done!
> > >
> > > > +      */
> > > > +     if (count * LOG_ENTRY_SIZE > PAGE_SIZE)
> > > > +             return -EIO;
> > > > +
> > > > +     /*
> > > > +      * We are guaranteed the buffer is 4KB so today all the event
> > > > +      * logs will fit
> > > > +      */
> > > > +     for (i =3D 0; i < count; i++) {
> > > > +             audit_log_buffer[0] =3D (i + 1);
> > >
> > > Extra parenthesis.
> > Done!
> > >
> > > > +
> > > > +             /*
> > > > +              * read audit log entry at a time. 'buf' input value
> > > > +              * provides  the audit log entry to be read.  On
> > >
> > > Extra spaces.
> > Done!
> > >
> > > > +              * input, Byte 0 =3D Audit Log entry number from
> > > > +              * beginning (1..254)
> > > > +              * Entry number 1 is the newest entry whereas the
> > > > +              * highest entry number (number of entries) is the
> > > > +              * oldest entry.
> > > > +              */
> > > > +             ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG,
> > > > +                                        HPWMI_SURESTART,
> > > > +                                        audit_log_buffer, 1, 128);
> > > > +
> > > > +             if (ret >=3D 0 && (LOG_ENTRY_SIZE * i) < PAGE_SIZE) {
> > >
> > > Can the second condition ever fail?
> > >
> > Only in the event BIOS data is corrupted.
>
> i runs from 0 to count - 1 and you prevented count * LOG_ENTRY_SIZE >
> PAGE_SIZE above. So what does the BIOS data have to do with that?

BIOS guarantees the number of audit logs * LOG_ENTRY_SIZE will be less
than 4K (PAGE_SIZE)
Because Linux kernel trusts no one, we are checking that BIOS does not
report more events than it should.
WMI expects the input buffer to include the current audit log number
(audit_log_buffer[0] =3D (i + 1);) which is i+1.

>
> > > > +                     memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE)=
;
> > > > +                     buf +=3D LOG_ENTRY_SIZE;
> > > > +             } else {
> > > > +                     /*
> > > > +                      * Encountered a failure while reading
> > > > +                      * individual logs. Only a partial list of
> > > > +                      * audit log will be returned.
> > > > +                      */
> > > > +                     count =3D i + 1;
> > > > +                     break;
> > > > +             }
> > >
> > > Reverse order, do error handling with break first.
> > Done!
> > >
> > > Why not return i * LOG_ENTRY_SIZE directly (or at the end), no need t=
o
> > > tweak count?
> >
> > Done!
> > >
> > > > +     }
> > > > +
> > > > +     return count * LOG_ENTRY_SIZE;
> > > > +}
>
>
> --
>  i.
