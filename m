Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47226F1FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbjD1UrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345728AbjD1UrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:47:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2AE2706;
        Fri, 28 Apr 2023 13:47:09 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4effb818c37so374799e87.3;
        Fri, 28 Apr 2023 13:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682714827; x=1685306827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RoDzqaHs8D0cJHQyOh9YTjplQciDuElxMFrbB4PZkc=;
        b=kIXorO7U1M214fIhhteYdoFzVksbkPKKcPOblOX4CxeaDvEwvX66QpoLg2AIw++73f
         PIosZkndjE+katnH5fv5VDvn+n0DoEQIOj2RW7UzS8qRMKXsXaPI6p3H90fUcCfZ1KCK
         4c6uq/1kCVJ+p0ZTvmYh8oiSGNMv7ve97EmV3SPBLmNK0qI02BK/HwHhsSic7MwclPx2
         wYOh9syJeyTpBTLcTczGRDCZjbWZZRvx3KWK2LWztnYqrQ0qL48/pfyyFaXTvwAuvPVc
         bVde9WlU60aF6FsPgkdP+rJ+07SOPA/v//ykiuYJbA7UypRbg8s8Mxv5ypIguGCsGD6m
         al+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682714827; x=1685306827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RoDzqaHs8D0cJHQyOh9YTjplQciDuElxMFrbB4PZkc=;
        b=MAtNp4brUvVgevheViv89WUi9nZSw6XuO4o5tPEKFY43S70tXDYE+NwOwPV0sowQ5r
         8BSnXVMX6nZfflagVBpGAYFXdDHrGwJR4n9816IO+Bf/e07wTpFEq6W4HRxVp43qsFb+
         KctOfpIug+7mJETVaPRND+uN+n0mphIACaIpi1i+YsClXxrUgzW4lyOLKEQB0d6C4WqD
         GYFiYaqq8aNuxziWch5xDej2LptUEtT/ysE+Q7uGNplE6UbXczsvw+Hxwii+Lwrt9gU9
         i1XjJBQo/miMjesgnoah3wVv+z0AHEOliWcyfQC6IAqdzS3yOv1I5NPB/d2ggWnLCa2s
         hVMA==
X-Gm-Message-State: AC+VfDzHbGcvmRRiAVWITdq736Rv9MktIrd6VyBCqEDUlulaYdDoCkvH
        KggLm2xRfxYff/skvg+XAHs1LbV0PPx4ceBeC40=
X-Google-Smtp-Source: ACHHUZ6NozmeYOwehRrfE8FBmoQpThI3M+LicZ8mzN3mkQ6/DiQLohemv9QJBO8BF1bJVCKGwLlKa16Nch91sDr10LE=
X-Received: by 2002:ac2:4542:0:b0:4ed:c5a4:28dc with SMTP id
 j2-20020ac24542000000b004edc5a428dcmr1894317lfm.38.1682714827024; Fri, 28 Apr
 2023 13:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-13-jorge.lopez2@hp.com>
 <cf54c6f4-d177-4904-82ee-9d33566fb920@t-8ch.de> <CAOOmCE8rpA=XvWBxcyRVu_gOHie3qN0E15Rs9bLfhb6tPZ7tyg@mail.gmail.com>
 <479b18e3-a35b-45c7-8c8a-cd30af646977@t-8ch.de> <CAOOmCE87dV6pnnU7r8Ycf0XcVERpRFRZeK6=y+nC+_Fc1EuJMg@mail.gmail.com>
 <7bdac640-cf61-429f-acd0-f8aa40b41e73@t-8ch.de> <CAOOmCE9pWqqN1zNAfdaWFL_cZvSfiEpQjETVeECR0BAw9-sVDQ@mail.gmail.com>
 <52554657-2902-454b-b2af-ed632dd2f081@t-8ch.de>
In-Reply-To: <52554657-2902-454b-b2af-ed632dd2f081@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 28 Apr 2023 15:46:41 -0500
Message-ID: <CAOOmCE8X=VK7hjAB48Jp2x4-5GhtSJKYHB9scdN9CL6gZKvMJQ@mail.gmail.com>
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

On Fri, Apr 28, 2023 at 11:06=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8c=
h.de> wrote:
>
> On 2023-04-28 10:40:59-0500, Jorge Lopez wrote:
> > On Fri, Apr 28, 2023 at 10:21=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@=
t-8ch.de> wrote:
> > >
> > > On 2023-04-28 09:58:01-0500, Jorge Lopez wrote:
> > > > On Fri, Apr 28, 2023 at 1:03=E2=80=AFAM Thomas Wei=C3=9Fschuh <thom=
as@t-8ch.de> wrote:
> > > > >
> > > > > On 2023-04-27 17:17:57-0500, Jorge Lopez wrote:
> > > > > > On Sun, Apr 23, 2023 at 7:16=E2=80=AFAM Thomas Wei=C3=9Fschuh <=
thomas@t-8ch.de> wrote:
> > > > > > >
> > > > > > > On 2023-04-20 11:54:52-0500, Jorge Lopez wrote:
> > > > > > > >  .../x86/hp/hp-bioscfg/surestart-attributes.c  | 130 ++++++=
++++++++++++
> > > > > > > >  1 file changed, 130 insertions(+)
> > > > > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/sure=
start-attributes.c
> > > > > > > >
> > > > > > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-a=
ttributes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > > > > > > > new file mode 100644
> > >
> > > <snip>
> > >
> > > > > > > Instead of not returning any data, why not show as many resul=
ts as
> > > > > > > possible?
> > > > > > >
> > > > > >
> > > > > > if count * LOG_ENTRY_SIZE > PAGE_SIZE then I prefer to return a=
n error.
> > > > > > if the count is correct but a failure occurs while reading indi=
vidual
> > > > > > audit logs then we will return a partial list of all audit logs
> > > > > > This changes will be included in Version 12
> > > > >
> > > > > What prevents the firmware from having more log entries?
> > > > > Wouldn't these audit log entries not accumulate for each logged
> > > > > operation over the lifetime of the device / boot?
> > > > >
> > > > > This would make the interface unusable as soon as there are more
> > > > > entries.
> > > >
> > > > BIOS stores a max number of audit logs appropriate to the current
> > > > audit log size.The first audit logs are kept in a FIFO queue by BIO=
S
> > > > so when the queue is full and a new audit log arrives, then the  fi=
rst
> > > > audit log will be deleted.
> > >
> > > How does it determine "appropriate"?
> > > This would also be great in a comment.
> > >
> > > If the BIOS is just using FIFO the driver could return the first
> > > LOG_MAX_ENTRIES entries.
> > > This would avoid trusting the firmware for a reasonable definition of
> > > "appropriate".
> > >
> > > > >
> > > > > > > > +
> > > > > > > > +     if (ret < 0)
> > > > > > > > +             return ret;
> > > > >
> > > > > And this should first validate ret and then count.
> > > >
> > > > Done!
> > > >
> > > > >
> > > > > > > > +
> > > > > > > > +     /*
> > > > > > > > +      * We are guaranteed the buffer is 4KB so today all t=
he event
> > > > > > > > +      * logs will fit
> > > > > > > > +      */
> > > > > > > > +
> > > > > > > > +     for (i =3D 0; ((i < count) & (ret >=3D 0)); i++) {
> > > > > > >
> > > > > > > &&
> > > > > > >
> > > > > > > Better yet, pull the condition ret >=3D 0 into the body, as a=
n else-branch
> > > > > > > for the existing check.
> > > > > > >
> > > > > >
> > > > > > Done!
> > > > > >
> > > > > > > > +             *buf =3D (i + 1);
> > > > > > >
> > > > > > > Isn't this directly overwritten by the query below?
> > > > > >
> > > > > > buf input value indicates the audit log to be read hence the re=
ason
> > > > > > why it is overwritten.
> > > > > > This is an expected behavior.
> > > > >
> > > > > So this is read by the HPWMI_SURESTART_GET_LOG method in the firm=
ware?
> > > > >
> > > > > Make sense but need a comment.
> > > >
> > > > Done!
> > > >
> > > > >
> > > > > > >
> > > > > > > > +             ret =3D hp_wmi_perform_query(HPWMI_SURESTART_=
GET_LOG,
> > > > > > > > +                                        HPWMI_SURESTART,
> > > > > > > > +                                        buf, 1, 128);
> > > > > > > > +             if (ret >=3D 0)
> > > > > > > > +                     buf +=3D LOG_ENTRY_SIZE;
> > > > > > >
> > > > > > > So 128 bytes are read but only the first 16 bytes are preserv=
ed?
> > > > > > >
> > > > > > > The documentation says that each entry has 128 bytes in the f=
ile.
> > > > > > > And that they are separated by ";", which is not implemented.
> > > > > >
> > > > > > The statement will be removed from documentation  (separated by=
 ";")
> > > > > > audit log size is 16 bytes.
> > > > > > >
> > > > > > > Can the audit-log not contain all-zero bytes?
> > > > > > > If it does this would need to be a bin_attribute.
> > > > > >
> > > > > > Bytes 16-127 are ignored and not used at this time.  If the aud=
it log
> > > > > > changes, then the driver will need to change to accommodate the=
 new
> > > > > > audit log size.
> > > > >
> > > > > buf is not guaranteed to have 128 bytes left for this data.
> > > > >
> > > > > For example if this is entry number 253 we are at offset 253 * 16=
 =3D 4048
> > > > > in the sysfs buffer. Now hw_wmi_perform_query may try to write to=
 4048 +
> > > > > 127 =3D 4175 which is out of bounds for the buf of size 4096.
> > > > >
> > > > > Writing first to a stack buffer would be better,
> > > > > or pass outsize =3D LOG_ENTRY_SIZE.
> > > > >
> > > > BIOS currently stores 16 bytes for each audit log although the WMI
> > > > query reads 128 bytes.  The 128 bytes size is set to provide suppor=
t
> > > > in future BIOS for audit log sizes >=3D 16 and < 128 bytes.
> > >
> > > And if an old driver is running on a new BIOS then this would write o=
ut
> > > of bounds.
> > > Or if the BIOS is buggy.
> > >
> > > If the current driver can only handle 16 byte sized log entries then =
the
> > > this should be used in the call to HPWMI_SURESTART_GET_LOG.
> >
> > BIOS WMI specification indicates that the HPWMI_SURESTART_GET_LOG call
> > expects a 128 byte size output buffer regardless of the actual audit
> > log size currently supported.
> >
> > Return Values:
> > Byte 0-15: a requested Audit Log entry (Each Audit log is 16 bytes)
> > Byte 16-127: Unused
> > >
> > > Storing it in a 128 byte stackvariable would also sidestep the issue.
> >
> > The driver hardcodes the audit log size to 16 bytes.  If the new BIOS
> > provides an audit log that is larger than 16 bytes, then the logs
> > provided to the user application by the old driver will be truncated.
>
> HPWMI_SURESTART_GET_LOG is directly passed a pointer into "buf" which
> comes from sysfs core and is one page, 4096 bytes large.
> It is told to write 128 bytes into it at a given offset.
>
> In the loop if i =3D=3D 253 then this offset will be LOG_ENTRY_SIZE * 253=
 =3D 4048.
>
> So on a new BIOS the driver may write 128 bytes at offset 4048.
> This goes up to 4175 which is larger than the 4096 buffer.
>
> (See also the calculation in the previous mail)
>
> Just use a 128 byte stack buffer and copy 16 bytes of it to the output
> buffer.
> (After having validated that the BIOS actually returned 16 bytes)

Thank you for the clarification.  Done!
