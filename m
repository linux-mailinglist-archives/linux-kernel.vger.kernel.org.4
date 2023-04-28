Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1496F1B07
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346147AbjD1O6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjD1O6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:58:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532492D5B;
        Fri, 28 Apr 2023 07:58:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4efec123b28so8314385e87.1;
        Fri, 28 Apr 2023 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682693906; x=1685285906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JenPzQlIuF7J8p54MWPw88/YQhGaeWH6osoTclpO1zo=;
        b=Crxo6YOjva/7wIi4nHL2RFumtUF8Utx6nUgSngUI3Mx5V7WflzyHkR6TDKHqmlifSX
         l/GyCpYgHsw2LjaUHUL+nhrgL27/tJJqnRVhGg4sPDG4MuwZKoB0jiwaQuvvp1UQC/90
         Wm9ioxXDqDIyyQYlZYSaxdLqgjkFI9f0WRcYMtn5p0N2SBEtGDoPfE31JRubDx9hxuWl
         0hTlKh3PHIk/NZrZSgSin1JMSgqHyGwzxffhy/aZWiW0opogJcYpOp4AG0FSN8YE3UCr
         Jh39x2ZFMTkg0Dw1HiQwu/l0HvsgwhJBAaKH4w7TUQgmCGtl0rpEK8dW8d5HKyEmaPhR
         eSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682693906; x=1685285906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JenPzQlIuF7J8p54MWPw88/YQhGaeWH6osoTclpO1zo=;
        b=KO+BpWzv6va5jap5daoLyguA7odHEGRwpHGwQFfKdERHYnO8HV2tPDk0ixX3wC6P9p
         qD5+9v0mIdklcMSo73YTSBzmgCI5zDl2FUsSqpd3QNfiNsXyK75b5NiMvQw5PjpTZXDx
         V2UObT9nPf95eak3bCLQfuu6GFwmFZGSeFPXWJRI5hdyGieG0dkJY4sKcLR5sUM31EmR
         CS3itO8/OBff0rnNe3mO5u8nHyCJueKN6eHmHc2+3vNcahGQyLcQATNPhs4DXQ3CSmh2
         Vbk0yEqAi5VmoOW+OBNnX8vlg8sHBNF1Fhi2s/9l9nKtJJJqmFTu2i65rEOk8w681Sbv
         KxUA==
X-Gm-Message-State: AC+VfDwSRakgqb1YD+kc7HlWshhls2bR39bEwPeS0QIpFdtXNrziXP/z
        IdPQlpK82oCHV8SaayDM73tCwGueY8SiErOLrLLzaT6TjkA=
X-Google-Smtp-Source: ACHHUZ74CoWZmG6L0xywK4fCoh95gmlp8HDTQgUuJTKRb9LQS59d2s9+EaB1uIexarGjchfUQQXYJtDCVN02OYp5mIY=
X-Received: by 2002:ac2:4895:0:b0:4ec:9f24:3e5f with SMTP id
 x21-20020ac24895000000b004ec9f243e5fmr1659763lfc.0.1682693906297; Fri, 28 Apr
 2023 07:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-13-jorge.lopez2@hp.com>
 <cf54c6f4-d177-4904-82ee-9d33566fb920@t-8ch.de> <CAOOmCE8rpA=XvWBxcyRVu_gOHie3qN0E15Rs9bLfhb6tPZ7tyg@mail.gmail.com>
 <479b18e3-a35b-45c7-8c8a-cd30af646977@t-8ch.de>
In-Reply-To: <479b18e3-a35b-45c7-8c8a-cd30af646977@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 28 Apr 2023 09:58:01 -0500
Message-ID: <CAOOmCE87dV6pnnU7r8Ycf0XcVERpRFRZeK6=y+nC+_Fc1EuJMg@mail.gmail.com>
Subject: Re: [PATCH v11 12/14] HP BIOSCFG driver - surestart-attributes
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Apr 28, 2023 at 1:03=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2023-04-27 17:17:57-0500, Jorge Lopez wrote:
> > On Sun, Apr 23, 2023 at 7:16=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t=
-8ch.de> wrote:
> > >
> > > On 2023-04-20 11:54:52-0500, Jorge Lopez wrote:
> > > >  .../x86/hp/hp-bioscfg/surestart-attributes.c  | 130 ++++++++++++++=
++++
> > > >  1 file changed, 130 insertions(+)
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-at=
tributes.c
> > > >
> > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attribute=
s.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > > > new file mode 100644
> > > > index 000000000000..72952758ffe3
> > > > --- /dev/null
> > > > +++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > > > @@ -0,0 +1,130 @@
>
> <snip>
>
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
> > > > +
> > > > +     // Get the number of event logs
> > > > +     ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
> > > > +                                HPWMI_SURESTART,
> > > > +                                &count, 1, sizeof(count));
> > > > +
> > > > +     /*
> > > > +      * The show() api will not work if the audit logs ever go
> > > > +      *  beyond 4KB
> > > > +      */
> > > > +     if (count * LOG_ENTRY_SIZE > PAGE_SIZE)
> > > > +             return -EFAULT;
> > >
> > > The error code seems not to match.
> > >
> >
> > Changing error to -EINVAL
>
> -EIO seems better.

Done!
>
> The problem is not due to some value a user passed but an unhandled from
> the hardware.
>
> >
> > > Instead of not returning any data, why not show as many results as
> > > possible?
> > >
> >
> > if count * LOG_ENTRY_SIZE > PAGE_SIZE then I prefer to return an error.
> > if the count is correct but a failure occurs while reading individual
> > audit logs then we will return a partial list of all audit logs
> > This changes will be included in Version 12
>
> What prevents the firmware from having more log entries?
> Wouldn't these audit log entries not accumulate for each logged
> operation over the lifetime of the device / boot?
>
> This would make the interface unusable as soon as there are more
> entries.

BIOS stores a max number of audit logs appropriate to the current
audit log size.The first audit logs are kept in a FIFO queue by BIOS
so when the queue is full and a new audit log arrives, then the  first
audit log will be deleted.

>
> > > > +
> > > > +     if (ret < 0)
> > > > +             return ret;
>
> And this should first validate ret and then count.

Done!

>
> > > > +
> > > > +     /*
> > > > +      * We are guaranteed the buffer is 4KB so today all the event
> > > > +      * logs will fit
> > > > +      */
> > > > +
> > > > +     for (i =3D 0; ((i < count) & (ret >=3D 0)); i++) {
> > >
> > > &&
> > >
> > > Better yet, pull the condition ret >=3D 0 into the body, as an else-b=
ranch
> > > for the existing check.
> > >
> >
> > Done!
> >
> > > > +             *buf =3D (i + 1);
> > >
> > > Isn't this directly overwritten by the query below?
> >
> > buf input value indicates the audit log to be read hence the reason
> > why it is overwritten.
> > This is an expected behavior.
>
> So this is read by the HPWMI_SURESTART_GET_LOG method in the firmware?
>
> Make sense but need a comment.

Done!

>
> > >
> > > > +             ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG,
> > > > +                                        HPWMI_SURESTART,
> > > > +                                        buf, 1, 128);
> > > > +             if (ret >=3D 0)
> > > > +                     buf +=3D LOG_ENTRY_SIZE;
> > >
> > > So 128 bytes are read but only the first 16 bytes are preserved?
> > >
> > > The documentation says that each entry has 128 bytes in the file.
> > > And that they are separated by ";", which is not implemented.
> >
> > The statement will be removed from documentation  (separated by ";")
> > audit log size is 16 bytes.
> > >
> > > Can the audit-log not contain all-zero bytes?
> > > If it does this would need to be a bin_attribute.
> >
> > Bytes 16-127 are ignored and not used at this time.  If the audit log
> > changes, then the driver will need to change to accommodate the new
> > audit log size.
>
> buf is not guaranteed to have 128 bytes left for this data.
>
> For example if this is entry number 253 we are at offset 253 * 16 =3D 404=
8
> in the sysfs buffer. Now hw_wmi_perform_query may try to write to 4048 +
> 127 =3D 4175 which is out of bounds for the buf of size 4096.
>
> Writing first to a stack buffer would be better,
> or pass outsize =3D LOG_ENTRY_SIZE.
>
BIOS currently stores 16 bytes for each audit log although the WMI
query reads 128 bytes.  The 128 bytes size is set to provide support
in future BIOS for audit log sizes >=3D 16 and < 128 bytes.

> > The audit log file cannot contain all zero bytes.
>
> I doublechecked this and zero bytes seem to also be fine in normal text
> attributes.
>
> > > > +   return (count * LOG_ENTRY_SIZE);
>
> If one of the calls to hp_wmi_perform_query() fails this return value is =
wrong,
> it does not reflect the amount of actually written data.

Version 12 of the code takes such a condition in consideration and
recalculates the value of 'count' to match the one number of valid
audit logs read.
