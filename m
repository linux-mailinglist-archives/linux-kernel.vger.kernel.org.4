Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642EE63F417
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiLAPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiLAPgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:36:03 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832241704D;
        Thu,  1 Dec 2022 07:36:00 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id b81so1010267vkf.1;
        Thu, 01 Dec 2022 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C4Ic/rXKLW7Wm5b9u8f/7TaZwZEpMvyKDBcW8SAsLk=;
        b=e+CS+oiWp1wdfbWovV6vY/rRGNffWAKIlOBhrrlgpzz9JNfoZWu/lm0Nfn69J+awIr
         4VPJNWvlEGKr+aFlcJbyisb203YkwCRz2V/PJ+i4CYfNZePm3dA4xGBSClEg+seLVzlt
         BPI/00DrYA9W7qZb7JNPjY5YtXMLsfFXY8ayJPbTQV5wgREhjN/PaHvrIUYxvNtznIOc
         3ETlduz1KgwhkrmWsr57KPDuGzcbtuPmEfG9TMj/13FI3T1MntVYXtjMzc+/+ZFeJQbv
         FyjFpXyejTRJk0MCZ7zAHHS51v4JeCLM/7QoLFNRzSSUz4MQsuOxwPN5R1PuhypJroZ2
         91SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C4Ic/rXKLW7Wm5b9u8f/7TaZwZEpMvyKDBcW8SAsLk=;
        b=b2clvsXHQ9yCoVJq5Ps7mDX8SWPEbhc7NwC1RDycVFpxtF4R8oUmzf9g99ZwjvTnTQ
         i1gj03ggioGt5Im3hJWLHPil22+Td0UN+KK9SiL5mcjYDlM3w77reUWtKsHvbm7J4WdQ
         uEKBYPtjysm4kRDsv7GM5cLW/f31KWsLcDv6wbNz7pllddQBrz7+DawUoaJUCVSWEtxR
         rzs+tkQoOpFFmxMSp0RMecwrFK4W/KUwNJykZNrQc4pNHpL97hnOCbX52c0MOupWpJva
         yxHTBYLhf+N51uBxXpKBstpUDzuoTwONnBCHJHc8JlAZK0GyCxQ8gLF87fiqPAtvUBmI
         NLBA==
X-Gm-Message-State: ANoB5pm4Zffyv6gcvI5d6TRzcxtQ+5VIqp13H3Sqn29sDMkBFMAAXpf1
        HgZxNSQY5iS/fB4hgXoixQvF44CXgKr1+A6b55rHf1OL
X-Google-Smtp-Source: AA0mqf5KPcANLGmMtowqVNJztvO5JBcHknnxue/TlujOQIdSQqoqu6Xqeh1N+bdszi0HANLbBFbC7QkbgGxfe60jsho=
X-Received: by 2002:a1f:edc6:0:b0:3bc:b66b:fe7 with SMTP id
 l189-20020a1fedc6000000b003bcb66b0fe7mr19693980vkh.20.1669908959513; Thu, 01
 Dec 2022 07:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20220818125027.1131-1-yongsuyoo0215@gmail.com>
 <CANXPkT4KL9KxvgjaJO058zg8nb00qaiPfDFKEaQ42g6v18XvKA@mail.gmail.com>
 <CANXPkT4hB4AEKk_=piESRTxToBsoKCpaq8vvjP05o3CX6QX4_g@mail.gmail.com> <CANXPkT4pzpEKMXuBShAeWfA80g5UigodrVZc+EBDnTLrHjnpyA@mail.gmail.com>
In-Reply-To: <CANXPkT4pzpEKMXuBShAeWfA80g5UigodrVZc+EBDnTLrHjnpyA@mail.gmail.com>
From:   YongSu Yoo <yongsuyoo0215@gmail.com>
Date:   Fri, 2 Dec 2022 00:35:51 +0900
Message-ID: <CANXPkT74VPmFuGjTH+_=ycvoLni5GZDuf5mbo_ACdexp57oHxA@mail.gmail.com>
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
It has been a long time since this patch was created.
Can you share how this patch is going ?

2022=EB=85=84 10=EC=9B=94 14=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 10:41,=
 =EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
>
> Dear All
> Can you share how this patch is going ?
>
> 2022=EB=85=84 9=EC=9B=94 15=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 5:47,=
 =EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
> >
> > Dear All
> > Can you share how this patch is going ?
> >
> > 2022=EB=85=84 8=EC=9B=94 31=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 10:=
43, =EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4=
 =EC=9E=91=EC=84=B1:
> > >
> > > Dear All
> > > Can you share how this patch is going ?
> > >
> > > 2022=EB=85=84 8=EC=9B=94 18=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9=
:50, YongSu Yoo <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > > >
> > > > Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
> > > >
> > > > The function of "dvb_ca_en50221_write_data" at source/drivers/media
> > > > /dvb-core/dvb_ca_en50221.c is used for two cases.
> > > > The first case is for writing APDU data in the function of
> > > > "dvb_ca_en50221_io_write" at source/drivers/media/dvb-core/
> > > > dvb_ca_en50221.c.
> > > > The second case is for writing the host link buf size on the
> > > > Command Register in the function of "dvb_ca_en50221_link_init"
> > > > at source/drivers/media/dvb-core/dvb_ca_en50221.c.
> > > > In the second case, there exists a bug like followings.
> > > > In the function of the "dvb_ca_en50221_link_init",
> > > > after a TV host calculates the host link buf_size,
> > > > the TV host writes the calculated host link buf_size on the
> > > > Size Register.
> > > > Accroding to the en50221 Spec (the page 60 of
> > > > https://dvb.org/wp-content/uploads/2020/02/En50221.V1.pdf),
> > > > before this writing operation, the "SW(CMDREG_SW)" flag in the
> > > > Command Register should be set. We can see this setting operation
> > > > in the function of the "dvb_ca_en50221_link_init" like below.
> > > > ...
> > > >         if ((ret =3D ca->pub->write_cam_control(ca->pub, slot,
> > > > CTRLIF_COMMAND, IRQEN | CMDREG_SW)) !=3D 0)
> > > >                 return ret;
> > > > ...
> > > > But, after that, the real writing operation is implemented using
> > > > the function of the "dvb_ca_en50221_write_data" in the function of
> > > > "dvb_ca_en50221_link_init", and the "dvb_ca_en50221_write_data"
> > > > includes the function of "ca->pub->write_cam_control",
> > > > and the function of the "ca->pub->write_cam_control" in the
> > > > function of the "dvb_ca_en50221_wrte_data" does not include
> > > > "CMDREG_SW" flag like below.
> > > > ...
> > > >         if ((status =3D ca->pub->write_cam_control(ca->pub, slot,
> > > > CTRLIF_COMMAND, IRQEN | CMDREG_HC)) !=3D 0)
> > > > ...
> > > > In the above source code, we can see only the "IRQEN | CMDREG_HC",
> > > > but we cannot see the "CMDREG_SW".
> > > > The "CMDREG_SW" flag which was set in the function of the
> > > > "dvb_ca_en50221_link_init" was rollbacked by the follwoing function
> > > > of the "dvb_ca_en50221_write_data".
> > > > This is a bug. and this bug causes that the calculated host link bu=
f_size
> > > > is not properly written in the CI module.
> > > > Through this patch, we fix this bug.
> > > > ---
> > > >  drivers/media/dvb-core/dvb_ca_en50221.c | 12 +++++++-----
> > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/medi=
a/dvb-core/dvb_ca_en50221.c
> > > > index 15a08d8c69ef..13f249b0a080 100644
> > > > --- a/drivers/media/dvb-core/dvb_ca_en50221.c
> > > > +++ b/drivers/media/dvb-core/dvb_ca_en50221.c
> > > > @@ -187,7 +187,7 @@ static void dvb_ca_en50221_thread_wakeup(struct=
 dvb_ca_private *ca);
> > > >  static int dvb_ca_en50221_read_data(struct dvb_ca_private *ca, int=
 slot,
> > > >                                     u8 *ebuf, int ecount);
> > > >  static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, in=
t slot,
> > > > -                                    u8 *ebuf, int ecount);
> > > > +                                    u8 *ebuf, int ecount, int size=
_write_flag);
> > > >
> > > >  /**
> > > >   * findstr - Safely find needle in haystack.
> > > > @@ -370,7 +370,7 @@ static int dvb_ca_en50221_link_init(struct dvb_=
ca_private *ca, int slot)
> > > >         ret =3D dvb_ca_en50221_wait_if_status(ca, slot, STATUSREG_F=
R, HZ / 10);
> > > >         if (ret)
> > > >                 return ret;
> > > > -       ret =3D dvb_ca_en50221_write_data(ca, slot, buf, 2);
> > > > +       ret =3D dvb_ca_en50221_write_data(ca, slot, buf, 2, CMDREG_=
SW);
> > > >         if (ret !=3D 2)
> > > >                 return -EIO;
> > > >         ret =3D ca->pub->write_cam_control(ca->pub, slot, CTRLIF_CO=
MMAND, IRQEN);
> > > > @@ -778,11 +778,13 @@ static int dvb_ca_en50221_read_data(struct dv=
b_ca_private *ca, int slot,
> > > >   * @buf: The data in this buffer is treated as a complete link-lev=
el packet to
> > > >   *      be written.
> > > >   * @bytes_write: Size of ebuf.
> > > > + * @size_write_flag: A flag on Command Register which says whether=
 the link size
> > > > + * information will be writen or not.
> > > >   *
> > > >   * return: Number of bytes written, or < 0 on error.
> > > >   */
> > > >  static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, in=
t slot,
> > > > -                                    u8 *buf, int bytes_write)
> > > > +                                    u8 *buf, int bytes_write, int =
size_write_flag)
> > > >  {
> > > >         struct dvb_ca_slot *sl =3D &ca->slot_info[slot];
> > > >         int status;
> > > > @@ -817,7 +819,7 @@ static int dvb_ca_en50221_write_data(struct dvb=
_ca_private *ca, int slot,
> > > >
> > > >         /* OK, set HC bit */
> > > >         status =3D ca->pub->write_cam_control(ca->pub, slot, CTRLIF=
_COMMAND,
> > > > -                                           IRQEN | CMDREG_HC);
> > > > +                                           IRQEN | CMDREG_HC | siz=
e_write_flag);
> > > >         if (status)
> > > >                 goto exit;
> > > >
> > > > @@ -1508,7 +1510,7 @@ static ssize_t dvb_ca_en50221_io_write(struct=
 file *file,
> > > >
> > > >                         mutex_lock(&sl->slot_lock);
> > > >                         status =3D dvb_ca_en50221_write_data(ca, sl=
ot, fragbuf,
> > > > -                                                          fraglen =
+ 2);
> > > > +                                                          fraglen =
+ 2, 0);
> > > >                         mutex_unlock(&sl->slot_lock);
> > > >                         if (status =3D=3D (fraglen + 2)) {
> > > >                                 written =3D 1;
> > > > --
> > > > 2.17.1
> > > >
