Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA04633BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiKVL4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiKVL4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:56:01 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38E1275D9;
        Tue, 22 Nov 2022 03:55:59 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id s4so9067125qtx.6;
        Tue, 22 Nov 2022 03:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8Q3/gFuGykAVEgTB/rfpTsANTf7AyXepd36i+RSjl8=;
        b=idlg8C90K+l7TIE201+hn0CdjZFTFHwQhvh28zO0qgPmqQwbeK/5Pp0c0zNW01+lFq
         9dc6PzsrYN4e6wio8bGlA95mqtiJlwPzxlCbng6P2eCuJMuz+E5QqRV26Sfqg7TJOUWd
         CGft56Qc7x14vdk8HHmgLTHx75TjVVLLpEyKSNCuk4HBNGhJaiCTJCHqFBiIaBw9z+Lh
         QTo2CsrvmHEWV8BDYTG/rsukUBDCBBzjgYMe0TBnM6Rr6yC5ZmndyJc+8lqXFMZOn1SZ
         uU36zKpFlvniFL3CR6Cfx5z6SE03lneR+dqh5HolghLUU69PnmCjaP1zma+BDIfDK1Tc
         pT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8Q3/gFuGykAVEgTB/rfpTsANTf7AyXepd36i+RSjl8=;
        b=Ud4VeAuViYCTJtGl3nsFiuQbWcSXKyZ1w8RHrRWbOb/LQxaw8vzuZICp6AYCxX2bGS
         jokHd6pom9W0OTj16XWwmg15p+zaM21XmjMaD370LBl5SqJcl4f5JPn/A1Iv26eIICED
         odA+MVP62q4DtSn3Camlk+8B8PxvQjOfKRn21gGtR1NOMXenOqc2N5p2iTz8hTJ+tLT5
         8QFQSNnpOHkmJfkVpge+Bs98t4pvfxoCF27KPr2LiSoHnFyaFGyeLxs28ZtCR7UFUjNS
         vID1G9AEI883jm6lgQ2r6DAbI/fJd40//Sc7ixsUw73I62iI7orLaWGiegbfe1ezI1a3
         GgtA==
X-Gm-Message-State: ANoB5plZeN3ahOxmmFRn0DfP2jVZRIUGSH2PzCddNG6grdj0izQGLJrO
        SIU2x7iaeKvwa5VfvTNHwCSZoCll8Z+f8EhARy1wrG6y4fQub0O7
X-Google-Smtp-Source: AA0mqf42lKjOUPBhLC5cHOGGrx9Ye1UJajYXLLHDIOWO36fd3kqaahER5lOTISCYegB539EhxodCv4Mwk0KZl4wsbTc=
X-Received: by 2002:a05:622a:22a9:b0:394:a30:b606 with SMTP id
 ay41-20020a05622a22a900b003940a30b606mr21602353qtb.159.1669118158995; Tue, 22
 Nov 2022 03:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20221119191743.6466-1-mmyangfl@gmail.com> <20221119205057.11694-1-mmyangfl@gmail.com>
 <nycvar.YFH.7.76.2211221028170.6045@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2211221028170.6045@cbobk.fhfr.pm>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Tue, 22 Nov 2022 19:55:22 +0800
Message-ID: <CAAXyoMP3xCFD8hRJDxxaGun4i3SWsj51PorPq9kZAM91MSeHdA@mail.gmail.com>
Subject: Re: [PATCH v3] HID: kye: Add support for MousePen M508X
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina <jikos@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=BA=8C 17:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, 20 Nov 2022, David Yang wrote:
>
> > Genius MousePen M508X digitizer tablet sends incorrect report descripto=
r by
> > default. This patch replaces it with a corrected one.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
>
> Thanks for the fix. A few comments below.
>
> > @@ -626,18 +751,24 @@ static __u8 *kye_report_fixup(struct hid_device *=
hdev, __u8 *rdesc,
> >                       *rsize =3D sizeof(easypen_m610x_rdesc_fixed);
> >               }
> >               break;
> > -     case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
> > -             if (*rsize =3D=3D EASYPEN_M406XE_RDESC_ORIG_SIZE) {
> > -                     rdesc =3D easypen_m406xe_rdesc_fixed;
> > -                     *rsize =3D sizeof(easypen_m406xe_rdesc_fixed);
> > -             }
> > -             break;
> >       case USB_DEVICE_ID_KYE_PENSKETCH_M912:
> >               if (*rsize =3D=3D PENSKETCH_M912_RDESC_ORIG_SIZE) {
> >                       rdesc =3D pensketch_m912_rdesc_fixed;
> >                       *rsize =3D sizeof(pensketch_m912_rdesc_fixed);
> >               }
> >               break;
> > +     case USB_DEVICE_ID_KYE_MOUSEPEN_M508X:
> > +             if (*rsize =3D=3D MOUSEPEN_M508X_RDESC_ORIG_SIZE) {
> > +                     rdesc =3D mousepen_m508x_rdesc_fixed;
> > +                     *rsize =3D sizeof(mousepen_m508x_rdesc_fixed);
> > +             }
> > +             break;
> > +     case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
> > +             if (*rsize =3D=3D EASYPEN_M406XE_RDESC_ORIG_SIZE) {
> > +                     rdesc =3D easypen_m406xe_rdesc_fixed;
> > +                     *rsize =3D sizeof(easypen_m406xe_rdesc_fixed);
> > +             }
> > +             break;
>
> What is the reason for moving USB_DEVICE_ID_KYE_EASYPEN_M406XE around?
>

Reorder to match the sequence of device ids in hid-ids.h. Same below.

> >       case USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE:
> >               rdesc =3D kye_consumer_control_fixup(hdev, rdesc, rsize, =
104,
> >                                       "Genius Gila Gaming Mouse");
> > @@ -721,8 +852,9 @@ static int kye_probe(struct hid_device *hdev, const=
 struct hid_device_id *id)
> >       case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
> >       case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
> >       case USB_DEVICE_ID_KYE_EASYPEN_M610X:
> > -     case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
> >       case USB_DEVICE_ID_KYE_PENSKETCH_M912:
> > +     case USB_DEVICE_ID_KYE_MOUSEPEN_M508X:
> > +     case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
>
> Same here.
>
> >               ret =3D kye_tablet_enable(hdev);
> >               if (ret) {
> >                       hid_err(hdev, "tablet enabling failed\n");
> > @@ -756,6 +888,10 @@ static const struct hid_device_id kye_devices[] =
=3D {
> >                               USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2) },
> >       { HID_USB_DEVICE(USB_VENDOR_ID_KYE,
> >                               USB_DEVICE_ID_KYE_EASYPEN_M610X) },
> > +     { HID_USB_DEVICE(USB_VENDOR_ID_KYE,
> > +                             USB_DEVICE_ID_KYE_PENSKETCH_M912) },
> > +     { HID_USB_DEVICE(USB_VENDOR_ID_KYE,
> > +                             USB_DEVICE_ID_KYE_MOUSEPEN_M508X) },
> >       { HID_USB_DEVICE(USB_VENDOR_ID_KYE,
> >                               USB_DEVICE_ID_KYE_EASYPEN_M406XE) },
> >       { HID_USB_DEVICE(USB_VENDOR_ID_KYE,
> > @@ -764,8 +900,6 @@ static const struct hid_device_id kye_devices[] =3D=
 {
> >                               USB_DEVICE_ID_GENIUS_GX_IMPERATOR) },
> >       { HID_USB_DEVICE(USB_VENDOR_ID_KYE,
> >                               USB_DEVICE_ID_GENIUS_MANTICORE) },
> > -     { HID_USB_DEVICE(USB_VENDOR_ID_KYE,
> > -                             USB_DEVICE_ID_KYE_PENSKETCH_M912) },
>
> This looks unrelated and incorrect, why are you dropping
> USB_DEVICE_ID_KYE_PENSKETCH_M912 from the device table?
>

USB_DEVICE_ID_KYE_PENSKETCH_M912 is moved upward, see -756,6 +888,10.

> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
