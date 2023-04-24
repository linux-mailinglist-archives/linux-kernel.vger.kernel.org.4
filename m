Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7C6EC3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 05:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjDXDaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 23:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDXDaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:30:18 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061BF212A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 20:30:16 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6CED23F431
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682307014;
        bh=WC+th9q1qyucqdCNULRu9PzbE/3NOazpAVoskMrOCMo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Dl6RJiPu+iGamiCdC7B/0RxMdWt2kxVpkTERV6MfLntFkuRD/8ONWFX8LUih68ScA
         pxeoSMIp1mkRIhCkKM9zd18xrqlLhRpJ3+tIK/UwK4XXVMM3TR5p3b2y04L6rcUhq3
         jzU/7hNIvoHOgJLKXRa1CsFld5gUlgz8IZeZ3EbGU2Ue/hVmoY8A5PSJw9hqBj3gr4
         VZG8glX9jCUYqCzcfplAn6TV4Gw59peycfYngOKOJ5igGv2ZCk8EoeoPDv+0dokqWS
         RtljBJ5lKPYcmUqonnazcasGUCkFq/MWq4xbtEgAccegxhbWc+/fQ1PTVDZvGRk6q+
         p/ZRes+6eLjIQ==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2479c766e91so2300164a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 20:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682307013; x=1684899013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WC+th9q1qyucqdCNULRu9PzbE/3NOazpAVoskMrOCMo=;
        b=Nz9zRxDsbNhrJ2yK+usrMgfrReXP3bYpulkMWWY/coTLUunWj1j7PCxwcnhZJHTFUe
         EKatfEYvW5H/X8VEgjgHsZv/u1sto1dZVBZoLRmLq8Qn6FKNb7lphYEFnhn+DGGQFheA
         P3RDfAQwaBjFlx8kRX3FyVsefiQBu5sdpwivedO1oLSoiEx0XhyOQn0qxRVeIQM7JOU4
         CuxFG0Y93Fhuecsn/vqpKvTO8a3kNvvKx6tcHgI9qnL8stBPQ6c1P3ym58H6Qz63BmmZ
         ftgR+A+Zl/Yz/JtKzdVBo4VNns8HJ3Pr8FubrPlNNN07qN0wa3exjWVU3atb/SxaQZcy
         f5ag==
X-Gm-Message-State: AAQBX9eo747fY9BL9JKRHRn0zlnXOJ/CWLSXBJucfJjYGWlcrkty8Aus
        /3UzENPkwkq6aKrvlwUof0LTofTBjH4vBbN/z5ajo5gQIPVuBuR3eleD69FMPJsrTAmsJRGPcqy
        sScDFUmz4ADalK1xn4tLP54og2HPyQgBDN6YfQDQHyc9C8pqnUv6qVfRD4w==
X-Received: by 2002:a17:90a:b38c:b0:247:af63:483 with SMTP id e12-20020a17090ab38c00b00247af630483mr12772622pjr.46.1682307013114;
        Sun, 23 Apr 2023 20:30:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350YPFNl2sw980xfSiaLkuusJtUDH8Vy2niQImnLC5y6fXjtaKvfBAZfSLb2n2lE+iD3LAaPsmJAM0uhQfag4djk=
X-Received: by 2002:a17:90a:b38c:b0:247:af63:483 with SMTP id
 e12-20020a17090ab38c00b00247af630483mr12772606pjr.46.1682307012756; Sun, 23
 Apr 2023 20:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230419054112.269734-1-kai.heng.feng@canonical.com> <20230420174321.GA123094@t480-pf1aa2c2>
In-Reply-To: <20230420174321.GA123094@t480-pf1aa2c2>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 24 Apr 2023 11:30:01 +0800
Message-ID: <CAAd53p4+7npE=Q1eWeNZp01F0BukKHj8inx95_ektv_zkvtjqw@mail.gmail.com>
Subject: Re: [PATCH] scsi: core: Avoid doing rescan on suspended device
To:     Benjamin Block <bblock@linux.ibm.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        acelan.kao@canonical.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 1:43=E2=80=AFAM Benjamin Block <bblock@linux.ibm.co=
m> wrote:
>
> On Wed, Apr 19, 2023 at 01:41:12PM +0800, Kai-Heng Feng wrote:
> > During system resume, if an EH is schduled after ATA host is resumed
> > (i.e. ATA_PFLAG_PM_PENDING cleared), but before the disk device is
> > resumed, the device_lock hold by scsi_rescan_device() is never released
> > so the dpm_resume() of the disk is blocked forerver.
> >
> > That's because scsi_attach_vpd() is expecting the disk device is in
> > operational state, as it doesn't work on suspended device.
> >
> > To avoid such deadlock, avoid doing rescan if the disk is still
> > suspended so the resume process of the disk device can proceed.
>
> I'm no expert on suspend/resume, but wouldn't you then potentially miss
> changes that have been done to the LUN during suspend?

This is a valid concern.

>
> What takes care of updating the VPDs, scsi-disk re-evaluation and such
> in this case, when you block it initially during wakeup?

The other approach is to perform the re-evaluation when the system
resume is about to be completed.
Let me send v2 to address that.


Kai-Heng

>
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/scsi/scsi_scan.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> > index d217be323cc6..36680cb1535b 100644
> > --- a/drivers/scsi/scsi_scan.c
> > +++ b/drivers/scsi/scsi_scan.c
> > @@ -1621,6 +1621,9 @@ void scsi_rescan_device(struct device *dev)
> >  {
> >       struct scsi_device *sdev =3D to_scsi_device(dev);
> >
> > +     if (dev->power.is_prepared)
> > +             return;
> > +
> >       device_lock(dev);
> >
> >       scsi_attach_vpd(sdev);
> > --
> > 2.34.1
> >
>
> --
> Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Develo=
pment
> IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/pr=
ivacy
> Vors. Aufs.-R.: Gregor Pillen         /         Gesch=C3=A4ftsf=C3=BChrun=
g: David Faller
> Sitz der Ges.: B=C3=B6blingen     /    Registergericht: AmtsG Stuttgart, =
HRB 243294
