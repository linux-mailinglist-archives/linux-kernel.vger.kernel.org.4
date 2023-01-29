Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A50467FC80
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 03:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjA2C7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 21:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2C7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:59:22 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88D620693;
        Sat, 28 Jan 2023 18:59:20 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id r132so7412821oif.10;
        Sat, 28 Jan 2023 18:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4i31LaSS9q/4u1kbSCx/ZFKdWGE5zXNu3uzmgdfiYk=;
        b=WC9NQAxaSWcDNEj1EQ/SqCLHMiZuRJBevGD/0rWF3gh2u5EwrTh0qGTOO+Dpt5kC50
         MAyMt2iyJVzQzmSu404zhrscO3LLo+4tfmDhfKs1PDOyryWw04NnkpMfBUuR0u8inuxl
         K6I4HIBxY567E+X3+wzTneB/1L9IVq/IZCwiIqpulDWOceWX5R2D5XLCzwmmnImlpa+d
         xDD8/UQIAL+6GAV5uQ/liQpMqb8zgVr7084NI3sh1qVIP+kvzpAGtLyj3TYHT0wPFxOT
         IDmPktuhf3XaVnSz7PfaxDYsTGCtiWtIj6TsqT9TLU1ufdFM+tLhupGnHugpNQuBhu//
         MTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4i31LaSS9q/4u1kbSCx/ZFKdWGE5zXNu3uzmgdfiYk=;
        b=H6cs/sCkf+wWz7MulEVwdIIkJ1e7BN/Fw6dCohNFMYckRG1+IU+9mvsmGxzz+m+Nkw
         QD2rYEurHgouAfhSvnPfTJHNlMqLWrURhPMqOeiTOMTToGJuBkee70z3o7+jMwa+NkC0
         UpYWD/L9g6GXhY+FVSDw1c9tVHAKRbl0RppXcqy8Y4wRXx6VAYJaQu/SissaalmtUxM7
         V/GhWz1XwhPdDvsx0dwNwrST/RS1oR4pz/fG4EzidULsZqw6RCOm3jZHOx366ZiGBctH
         lN/jK/NMFuD94G2/oXbA3Q5eN45B5beArtgRWtIfRhZFLyJ7VFfxdMXwdSG3RHDEYWhA
         xPfw==
X-Gm-Message-State: AFqh2kogzMfURrcpJbB4mLD6vAkB8A+cE19cCMrbiw4VwgD21QAlSYQU
        Jyg4G/LjIDkP+AnTbUa1Zfzzs/Mas69pVVV5Mdjt8hSlSk8=
X-Google-Smtp-Source: AMrXdXtjBbNlrbNaqxsosn3cWkfgwuo7+Cj6Gms1kzkaaSdo90s0QMjbEZtqdV6PSjHcqGsKNcH0GUP4vhv7UpRGUZ8=
X-Received: by 2002:a05:6808:2388:b0:36e:c0b6:6a07 with SMTP id
 bp8-20020a056808238800b0036ec0b66a07mr2349066oib.77.1674961159375; Sat, 28
 Jan 2023 18:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20230109123216.4974-1-fengqi706@gmail.com> <nycvar.YFH.7.76.2301201849090.1734@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2301201849090.1734@cbobk.fhfr.pm>
From:   qi feng <fengqi706@gmail.com>
Date:   Sun, 29 Jan 2023 10:59:09 +0800
Message-ID: <CACOZ=ZWB3grJKn7wAZEZ0BDyN7KJF4VWUTNs-mPxeoW_oiR7=g@mail.gmail.com>
Subject: Re: [PATCH] HID: add KEY_CAMERA_FOCUS event in HID
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
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

Hi,
Our Bluetooth Handle needs the focus function, which is missing in the
current map
If our setting is unreasonable, do you have other suggested values

thanks

Jiri Kosina <jikos@kernel.org> =E4=BA=8E2023=E5=B9=B41=E6=9C=8821=E6=97=A5=
=E5=91=A8=E5=85=AD 01:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 9 Jan 2023, Qi Feng wrote:
>
> > From: fengqi <fengqi@xiaomi.com>
> >
> > Our HID device need KEY_CAMERA_FOCUS event to control camera, but this
> > event is non-existent in current HID driver. So we add this event in
> > hid-input.c
> >
> > Signed-off-by: fengqi <fengqi@xiaomi.com>
> > ---
> >  drivers/hid/hid-input.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index 9b59e436df0a..22cca3406b5c 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -1105,6 +1105,7 @@ static void hidinput_configure_usage(struct hid_i=
nput *hidinput, struct hid_fiel
> >               case 0x0e5: map_key_clear(KEY_BASSBOOST);       break;
> >               case 0x0e9: map_key_clear(KEY_VOLUMEUP);        break;
> >               case 0x0ea: map_key_clear(KEY_VOLUMEDOWN);      break;
> > +             case 0x0ee: map_key_clear(KEY_CAMERA_FOCUS);    break;
> >               case 0x0f5: map_key_clear(KEY_SLOW);            break;
> >
> >               case 0x181: map_key_clear(KEY_BUTTONCONFIG);    break;
>
> [ CCing Benjamin ]
>
> Hi,
>
> so according to HUT 1.3.0, 0xeb-0xef are Reserved for now, so I'd be a
> little bit hesitatnt to but this into the generic mapping, as later HUT
> revision might define this in a different way.
>
> Which devices are known to be producing this?
>
> --
> Jiri Kosina
> SUSE Labs
>
