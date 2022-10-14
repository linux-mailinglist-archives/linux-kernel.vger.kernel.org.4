Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27B65FEECB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJNNmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJNNl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:41:58 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDF518C40F;
        Fri, 14 Oct 2022 06:41:56 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id a2so4867022vsc.13;
        Fri, 14 Oct 2022 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhsGglXkDpyWTUDP1zpBe/DMVjny5tzPLCxJzM1rCH8=;
        b=cIH2cckbEGL+G/8YvkQXnCT075p7SPbYhAj2r9HrLwKpOTGpyu9IMoDGGdvcFUwmYm
         74Mzg0H0xer4u3MHNrjdmo418+0ytiVPIJKkTv0LawZhbJOTvYxpp9alGdc/mdIiR7Ql
         8VwG49acoRv2MWeaDla+1OAt1de8IBl4+bf5juw8OANDCHtos05zE82UhFftovI9wEna
         twOp6cm5s/w7FPlzANG6n6srVutDn9bLYLw6EKYAQAie+TyyNYs6Wm8HakWeyPTyvN9r
         3zmL/orgX5pyIIfZ8SvCP1rJ1AuE/n9+JXQh73cB7RFIM41zfnxFcTg155Q6JnyosLgZ
         xK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhsGglXkDpyWTUDP1zpBe/DMVjny5tzPLCxJzM1rCH8=;
        b=1ZhZX+kJhdHQ7GJ5o0mIV+zDIFTIFc7phJF1ckxONM7py4pxXLLU3FEgoZbaOPmHL1
         Gc6m/Hp6ByU1h5vBUjwpO0Ay7Ho9MlTM3S0uE2SYYU9knjtab9IPajBrYQihjC61RcIL
         //d2lsqS9ZmmUUMmcGs3Wy58+xUH0Lmqjg7t7eIehMuGzcKOS6thahi4FV1A6TC1BeSD
         SKEsPOxdGWOOc9hy5imv46Mr2IgRrCm5ZzT7pn7HaZEIRKZnPgn8/BPC52aao7I4GvZM
         HNkXCOjVh712Fcbh3i5EAsaqLg9uxBnJQGHJTE4fZF9bDOPFjwYc3JE0kecyzO2hG7c7
         xcOw==
X-Gm-Message-State: ACrzQf0ge4Jl9fubPRYQbU3MQ2siPfbsdZevrY/7URfURVuogYnVskz6
        RzIAj45/Czej0kg5Hdc0YwGLzpv465RZQgWBuxo=
X-Google-Smtp-Source: AMsMyM7C0xvkIkQ+4nTj1gQpIbbBxDC8WXcerlQyMkQN7bDj/EnnYReGlbrgoOEF6yBlqaxk2Z/WA2ezOvu7KgtSaV8=
X-Received: by 2002:a67:c09b:0:b0:3a7:954f:5e4d with SMTP id
 x27-20020a67c09b000000b003a7954f5e4dmr2345935vsi.31.1665754915522; Fri, 14
 Oct 2022 06:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220818125027.1131-1-yongsuyoo0215@gmail.com>
 <CANXPkT4KL9KxvgjaJO058zg8nb00qaiPfDFKEaQ42g6v18XvKA@mail.gmail.com> <CANXPkT4hB4AEKk_=piESRTxToBsoKCpaq8vvjP05o3CX6QX4_g@mail.gmail.com>
In-Reply-To: <CANXPkT4hB4AEKk_=piESRTxToBsoKCpaq8vvjP05o3CX6QX4_g@mail.gmail.com>
From:   =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Fri, 14 Oct 2022 22:41:47 +0900
Message-ID: <CANXPkT4pzpEKMXuBShAeWfA80g5UigodrVZc+EBDnTLrHjnpyA@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ca_en50221: A bug is fixed for size write
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, yongsu.yoo@lge.com,
        =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>,
        Hans Petter Selasky <hps@selasky.org>
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

Dear All
Can you share how this patch is going ?

2022=EB=85=84 9=EC=9B=94 15=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 5:47, =
=EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> Dear All
> Can you share how this patch is going ?
>
> 2022=EB=85=84 8=EC=9B=94 31=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 10:43=
, =EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
> >
> > Dear All
> > Can you share how this patch is going ?
> >
> > 2022=EB=85=84 8=EC=9B=94 18=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:5=
0, YongSu Yoo <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
> > >
> > > The function of "dvb_ca_en50221_write_data" at source/drivers/media
> > > /dvb-core/dvb_ca_en50221.c is used for two cases.
> > > The first case is for writing APDU data in the function of
> > > "dvb_ca_en50221_io_write" at source/drivers/media/dvb-core/
> > > dvb_ca_en50221.c.
> > > The second case is for writing the host link buf size on the
> > > Command Register in the function of "dvb_ca_en50221_link_init"
> > > at source/drivers/media/dvb-core/dvb_ca_en50221.c.
> > > In the second case, there exists a bug like followings.
> > > In the function of the "dvb_ca_en50221_link_init",
> > > after a TV host calculates the host link buf_size,
> > > the TV host writes the calculated host link buf_size on the
> > > Size Register.
> > > Accroding to the en50221 Spec (the page 60 of
> > > https://dvb.org/wp-content/uploads/2020/02/En50221.V1.pdf),
> > > before this writing operation, the "SW(CMDREG_SW)" flag in the
> > > Command Register should be set. We can see this setting operation
> > > in the function of the "dvb_ca_en50221_link_init" like below.
> > > ...
> > >         if ((ret =3D ca->pub->write_cam_control(ca->pub, slot,
> > > CTRLIF_COMMAND, IRQEN | CMDREG_SW)) !=3D 0)
> > >                 return ret;
> > > ...
> > > But, after that, the real writing operation is implemented using
> > > the function of the "dvb_ca_en50221_write_data" in the function of
> > > "dvb_ca_en50221_link_init", and the "dvb_ca_en50221_write_data"
> > > includes the function of "ca->pub->write_cam_control",
> > > and the function of the "ca->pub->write_cam_control" in the
> > > function of the "dvb_ca_en50221_wrte_data" does not include
> > > "CMDREG_SW" flag like below.
> > > ...
> > >         if ((status =3D ca->pub->write_cam_control(ca->pub, slot,
> > > CTRLIF_COMMAND, IRQEN | CMDREG_HC)) !=3D 0)
> > > ...
> > > In the above source code, we can see only the "IRQEN | CMDREG_HC",
> > > but we cannot see the "CMDREG_SW".
> > > The "CMDREG_SW" flag which was set in the function of the
> > > "dvb_ca_en50221_link_init" was rollbacked by the follwoing function
> > > of the "dvb_ca_en50221_write_data".
> > > This is a bug. and this bug causes that the calculated host link buf_=
size
> > > is not properly written in the CI module.
> > > Through this patch, we fix this bug.
> > > ---
> > >  drivers/media/dvb-core/dvb_ca_en50221.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/=
dvb-core/dvb_ca_en50221.c
> > > index 15a08d8c69ef..13f249b0a080 100644
> > > --- a/drivers/media/dvb-core/dvb_ca_en50221.c
> > > +++ b/drivers/media/dvb-core/dvb_ca_en50221.c
> > > @@ -187,7 +187,7 @@ static void dvb_ca_en50221_thread_wakeup(struct d=
vb_ca_private *ca);
> > >  static int dvb_ca_en50221_read_data(struct dvb_ca_private *ca, int s=
lot,
> > >                                     u8 *ebuf, int ecount);
> > >  static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int =
slot,
> > > -                                    u8 *ebuf, int ecount);
> > > +                                    u8 *ebuf, int ecount, int size_w=
rite_flag);
> > >
> > >  /**
> > >   * findstr - Safely find needle in haystack.
> > > @@ -370,7 +370,7 @@ static int dvb_ca_en50221_link_init(struct dvb_ca=
_private *ca, int slot)
> > >         ret =3D dvb_ca_en50221_wait_if_status(ca, slot, STATUSREG_FR,=
 HZ / 10);
> > >         if (ret)
> > >                 return ret;
> > > -       ret =3D dvb_ca_en50221_write_data(ca, slot, buf, 2);
> > > +       ret =3D dvb_ca_en50221_write_data(ca, slot, buf, 2, CMDREG_SW=
);
> > >         if (ret !=3D 2)
> > >                 return -EIO;
> > >         ret =3D ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMM=
AND, IRQEN);
> > > @@ -778,11 +778,13 @@ static int dvb_ca_en50221_read_data(struct dvb_=
ca_private *ca, int slot,
> > >   * @buf: The data in this buffer is treated as a complete link-level=
 packet to
> > >   *      be written.
> > >   * @bytes_write: Size of ebuf.
> > > + * @size_write_flag: A flag on Command Register which says whether t=
he link size
> > > + * information will be writen or not.
> > >   *
> > >   * return: Number of bytes written, or < 0 on error.
> > >   */
> > >  static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int =
slot,
> > > -                                    u8 *buf, int bytes_write)
> > > +                                    u8 *buf, int bytes_write, int si=
ze_write_flag)
> > >  {
> > >         struct dvb_ca_slot *sl =3D &ca->slot_info[slot];
> > >         int status;
> > > @@ -817,7 +819,7 @@ static int dvb_ca_en50221_write_data(struct dvb_c=
a_private *ca, int slot,
> > >
> > >         /* OK, set HC bit */
> > >         status =3D ca->pub->write_cam_control(ca->pub, slot, CTRLIF_C=
OMMAND,
> > > -                                           IRQEN | CMDREG_HC);
> > > +                                           IRQEN | CMDREG_HC | size_=
write_flag);
> > >         if (status)
> > >                 goto exit;
> > >
> > > @@ -1508,7 +1510,7 @@ static ssize_t dvb_ca_en50221_io_write(struct f=
ile *file,
> > >
> > >                         mutex_lock(&sl->slot_lock);
> > >                         status =3D dvb_ca_en50221_write_data(ca, slot=
, fragbuf,
> > > -                                                          fraglen + =
2);
> > > +                                                          fraglen + =
2, 0);
> > >                         mutex_unlock(&sl->slot_lock);
> > >                         if (status =3D=3D (fraglen + 2)) {
> > >                                 written =3D 1;
> > > --
> > > 2.17.1
> > >
