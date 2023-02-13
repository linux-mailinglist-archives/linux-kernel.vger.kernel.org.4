Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643CA693E11
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBMGJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMGJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:09:43 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B326BC;
        Sun, 12 Feb 2023 22:09:43 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id dt8so9391229oib.0;
        Sun, 12 Feb 2023 22:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZW39st+bcMCGZRLtcOFM+mueOEc3yNzsbz2kzchZjkE=;
        b=gtyBKEOlwl0ZCCtLRe1KEzIMF9FByTzvs9HZ/nr4mABc3FEFcub5uFtyh+tcHvBlCI
         +QFgJ354gmNHfuoANivjpGz7+2mU31OREQ6W3dBR0e93E8jxvn5V3I2y2gAf93PnTptL
         oyYzfOCFhJhwc12ltp6NVYlYLii7LEgik6jLJYccCc+K/gCxfNF9kokoVHa9uulMj5dw
         rchjuHQxtN8pdFOHXA0DOEiHU4Op7q16g9JthMBCRRs0fFEVa4xaP69POOVuanTl4V3c
         XXWtnOj7OhPby5lDhEaItO5zciF7MEKnfPDB5ye25cWU4HdQEuGxCZ/aLEimxK4fLt/4
         zBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZW39st+bcMCGZRLtcOFM+mueOEc3yNzsbz2kzchZjkE=;
        b=TG2vIxs0yLNquC1Xu1qjHQHBgb575DUHuFv2sCm5fSq4PC4fpwWUFrpHDFE1c45usB
         6QQ7nKm3JlNZf8YzRvdyeW3rbQQ2pbXxBtXIyFah035gUrG2tZUt4RXxOIAgItN47wh+
         k8TZ52UgRPncMalv4JxrpEVpZYHH4UFLwZZ01OwrvxtsUzeZ3d8MHt/6CKyWA6UY4Esr
         6lolIBXUIRQsbQ1XeeJIVaMiK8SiW93Eruo82dSPatF7qYE2o2C4F5ZTHdzFMQsClIN4
         bo87y4ijVSpLH1zMM9cUHTSzGKnTb56K0edSuTBLYKwNGdmbwzWmZ6gDP77CWXojGc7E
         SpGw==
X-Gm-Message-State: AO0yUKWAGjCIdXWCt1/hVwz5vWrtajuZ3qWyyDluIaqz2t/9ukLAxv0s
        U7JHqTf3UoGQgzoAr+teOhWHoKCNyTgp6/vNGousNnmmepo=
X-Google-Smtp-Source: AK7set8UEOVIrTj5XG6VdgcGq89zGLfLE6TRW4LrxehLGAMNpofTFoKg4aJvGvoOp/Uej9mfJSdHRi0/25mmeXRtV28=
X-Received: by 2002:a05:6808:141:b0:37d:821d:5eb2 with SMTP id
 h1-20020a056808014100b0037d821d5eb2mr274906oie.178.1676268582369; Sun, 12 Feb
 2023 22:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20230131114632.14078-1-fengqi706@gmail.com> <CACOZ=ZU0zgRmoRu8X5bMUzUrXA9x-qoDJqrQroUs=+qKR58MQA@mail.gmail.com>
In-Reply-To: <CACOZ=ZU0zgRmoRu8X5bMUzUrXA9x-qoDJqrQroUs=+qKR58MQA@mail.gmail.com>
From:   qi feng <fengqi706@gmail.com>
Date:   Mon, 13 Feb 2023 14:09:31 +0800
Message-ID: <CACOZ=ZXDDWxPFt7sbpiOzh3WHcJN0xPod1YzSj07FMADaXHTuQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: add KEY_CAMERA_FOCUS event in HID
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your help to review


loop more

qi feng <fengqi706@gmail.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=887=E6=97=A5=E5=
=91=A8=E4=BA=8C 10:35=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi=EF=BC=8C
>
> Please help to review this  v2 code
>
> thanks a lot
>
> Qi Feng <fengqi706@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8831=E6=97=A5=
=E5=91=A8=E4=BA=8C 19:46=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: fengqi <fengqi@xiaomi.com>
> >
> > Our HID device need KEY_CAMERA_FOCUS event to control camera, but this
> > event is non-existent in current HID driver.we add this event in hid-in=
put.c
> > We committed this v2 version following your previous suggestion
> >
> > Signed-off-by: fengqi <fengqi@xiaomi.com>
> > ---
> >  drivers/hid/hid-input.c | 7 +++++++
> >  include/linux/hid.h     | 1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index 9b59e436df0a..05fa3e191574 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -1221,6 +1221,13 @@ static void hidinput_configure_usage(struct hid_=
input *hidinput, struct hid_fiel
> >                         return;
> >                 }
> >                 goto unknown;
> > +       case HID_UP_CAMERA:
> > +               switch (usage->hid & HID_USAGE){
> > +               case 0x020: map_key_clear(KEY_CAMERA_FOCUS);    break;
> > +               case 0x021: map_key_clear(KEY_CAMERA);          break;
> > +               default:        goto ignore;
> > +               }
> > +               break;
> >
> >         case HID_UP_HPVENDOR:   /* Reported on a Dutch layout HP5308 */
> >                 set_bit(EV_REP, input->evbit);
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index 8677ae38599e..e3daf2c7739c 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -155,6 +155,7 @@ struct hid_item {
> >  #define HID_UP_DIGITIZER       0x000d0000
> >  #define HID_UP_PID             0x000f0000
> >  #define HID_UP_BATTERY         0x00850000
> > +#define HID_UP_CAMERA          0x00900000
> >  #define HID_UP_HPVENDOR         0xff7f0000
> >  #define HID_UP_HPVENDOR2        0xff010000
> >  #define HID_UP_MSVENDOR                0xff000000
> > --
> > 2.39.0
> >
