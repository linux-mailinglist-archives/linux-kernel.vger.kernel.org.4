Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E936E37DC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjDPMDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPMDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:03:51 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B5F4687;
        Sun, 16 Apr 2023 05:03:49 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id q10so1290371uas.2;
        Sun, 16 Apr 2023 05:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681646628; x=1684238628;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+lGJqFoyzJfQpCn8yCuyjNcVHaJ90w5B5joJrrdUoM=;
        b=oIItBRbokrB1b8XzvgV5Z5G85SSiqeh8EMO1ZwBb3tt2/bE0vs1MSwE0f9Gj8a8s+6
         e7nFXUaz56PQRLNc8UmE6cEvURuJjF5spfMWT/WEHw6BXXEpufcIqjErWAgM1e2dhiLH
         DeN4mpC4a4D12Fi4zjgxLE6nZYo4flhWCEPCNgRGagcXDQmiz+W3ln7N7wI3Lfvra8An
         S47erw+bVQ3wFuLlb+ycfhhR3Cz46PkiZrJr8R12v3IRH6GIu9Ry3+XahNEAK2GQ3xXd
         30Jt4wzTbgew/qfcmnrWNJ46cgEADQQSbZ8w4A2H/UelXYLWGS1cB/QeCA9ytObQoB7v
         fU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681646628; x=1684238628;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+lGJqFoyzJfQpCn8yCuyjNcVHaJ90w5B5joJrrdUoM=;
        b=hydmpQO2Xt7ZV0mEpmTQB/sAtc6GLtm3hJyGcx6uIDR25WUPdiKluqQxFwpfVK13EI
         rntiZhghShQ0WkLAe6YJEQ15Btod8tFlZtk/PFV0KYFfMqueZ9zvTSxaEIrdCYayVPwR
         KmnuEu0uLkKy/6qUR7w+DecWsv3xgidxGr2qSglYoGQdxKu02WJ0Z22icwxuIlLJJb0i
         OEHQwRL4tVfLwDNZv/zksvHRv73JIEf6BdAO0AHJXU9IKvTWlaV1Mbx/YUWd9i2YSKdy
         2paPVCXLNKKPDYIhiCALuoU6WC7trO+DNU/3Dp6v8G9qUeFOG10mJy3ifQTH0QZ/oJsn
         gFEA==
X-Gm-Message-State: AAQBX9eohJPEpSeNzBd5yW5dnD14Y0cKDYTFzV5O4vr46hXpz9ysUAAe
        DUI563MzelEkgDEO07Ilgj9dVNWRljh8ewsl704=
X-Google-Smtp-Source: AKy350bQ8cifbglzDDlWr1+A5z8uSxNay60AFwSvF7erErjIwxt73ihG3SHT4nw3lME0siLar5uGlOfrp/vlYjk6qao=
X-Received: by 2002:a1f:2957:0:b0:440:380f:fc20 with SMTP id
 p84-20020a1f2957000000b00440380ffc20mr6010309vkp.0.1681646628647; Sun, 16 Apr
 2023 05:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220818125027.1131-1-yongsuyoo0215@gmail.com>
In-Reply-To: <20220818125027.1131-1-yongsuyoo0215@gmail.com>
From:   YongSu Yoo <yongsuyoo0215@gmail.com>
Date:   Sun, 16 Apr 2023 21:03:38 +0900
Message-ID: <CANXPkT5EOcQj9WgsHggVz+KCxfA9KfnC8V-fRrWGWU8HR5Xs0g@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ca_en50221: A bug is fixed for size write
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, yongsu.yoo@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ~
Can you share how this patch is going ?

2022=EB=85=84 8=EC=9B=94 18=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:50, Y=
ongSu Yoo <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
>
> The function of "dvb_ca_en50221_write_data" at source/drivers/media
> /dvb-core/dvb_ca_en50221.c is used for two cases.
> The first case is for writing APDU data in the function of
> "dvb_ca_en50221_io_write" at source/drivers/media/dvb-core/
> dvb_ca_en50221.c.
> The second case is for writing the host link buf size on the
> Command Register in the function of "dvb_ca_en50221_link_init"
> at source/drivers/media/dvb-core/dvb_ca_en50221.c.
> In the second case, there exists a bug like followings.
> In the function of the "dvb_ca_en50221_link_init",
> after a TV host calculates the host link buf_size,
> the TV host writes the calculated host link buf_size on the
> Size Register.
> Accroding to the en50221 Spec (the page 60 of
> https://dvb.org/wp-content/uploads/2020/02/En50221.V1.pdf),
> before this writing operation, the "SW(CMDREG_SW)" flag in the
> Command Register should be set. We can see this setting operation
> in the function of the "dvb_ca_en50221_link_init" like below.
> ...
>         if ((ret =3D ca->pub->write_cam_control(ca->pub, slot,
> CTRLIF_COMMAND, IRQEN | CMDREG_SW)) !=3D 0)
>                 return ret;
> ...
> But, after that, the real writing operation is implemented using
> the function of the "dvb_ca_en50221_write_data" in the function of
> "dvb_ca_en50221_link_init", and the "dvb_ca_en50221_write_data"
> includes the function of "ca->pub->write_cam_control",
> and the function of the "ca->pub->write_cam_control" in the
> function of the "dvb_ca_en50221_wrte_data" does not include
> "CMDREG_SW" flag like below.
> ...
>         if ((status =3D ca->pub->write_cam_control(ca->pub, slot,
> CTRLIF_COMMAND, IRQEN | CMDREG_HC)) !=3D 0)
> ...
> In the above source code, we can see only the "IRQEN | CMDREG_HC",
> but we cannot see the "CMDREG_SW".
> The "CMDREG_SW" flag which was set in the function of the
> "dvb_ca_en50221_link_init" was rollbacked by the follwoing function
> of the "dvb_ca_en50221_write_data".
> This is a bug. and this bug causes that the calculated host link buf_size
> is not properly written in the CI module.
> Through this patch, we fix this bug.
> ---
>  drivers/media/dvb-core/dvb_ca_en50221.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-=
core/dvb_ca_en50221.c
> index 15a08d8c69ef..13f249b0a080 100644
> --- a/drivers/media/dvb-core/dvb_ca_en50221.c
> +++ b/drivers/media/dvb-core/dvb_ca_en50221.c
> @@ -187,7 +187,7 @@ static void dvb_ca_en50221_thread_wakeup(struct dvb_c=
a_private *ca);
>  static int dvb_ca_en50221_read_data(struct dvb_ca_private *ca, int slot,
>                                     u8 *ebuf, int ecount);
>  static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot=
,
> -                                    u8 *ebuf, int ecount);
> +                                    u8 *ebuf, int ecount, int size_write=
_flag);
>
>  /**
>   * findstr - Safely find needle in haystack.
> @@ -370,7 +370,7 @@ static int dvb_ca_en50221_link_init(struct dvb_ca_pri=
vate *ca, int slot)
>         ret =3D dvb_ca_en50221_wait_if_status(ca, slot, STATUSREG_FR, HZ =
/ 10);
>         if (ret)
>                 return ret;
> -       ret =3D dvb_ca_en50221_write_data(ca, slot, buf, 2);
> +       ret =3D dvb_ca_en50221_write_data(ca, slot, buf, 2, CMDREG_SW);
>         if (ret !=3D 2)
>                 return -EIO;
>         ret =3D ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND,=
 IRQEN);
> @@ -778,11 +778,13 @@ static int dvb_ca_en50221_read_data(struct dvb_ca_p=
rivate *ca, int slot,
>   * @buf: The data in this buffer is treated as a complete link-level pac=
ket to
>   *      be written.
>   * @bytes_write: Size of ebuf.
> + * @size_write_flag: A flag on Command Register which says whether the l=
ink size
> + * information will be writen or not.
>   *
>   * return: Number of bytes written, or < 0 on error.
>   */
>  static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot=
,
> -                                    u8 *buf, int bytes_write)
> +                                    u8 *buf, int bytes_write, int size_w=
rite_flag)
>  {
>         struct dvb_ca_slot *sl =3D &ca->slot_info[slot];
>         int status;
> @@ -817,7 +819,7 @@ static int dvb_ca_en50221_write_data(struct dvb_ca_pr=
ivate *ca, int slot,
>
>         /* OK, set HC bit */
>         status =3D ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMA=
ND,
> -                                           IRQEN | CMDREG_HC);
> +                                           IRQEN | CMDREG_HC | size_writ=
e_flag);
>         if (status)
>                 goto exit;
>
> @@ -1508,7 +1510,7 @@ static ssize_t dvb_ca_en50221_io_write(struct file =
*file,
>
>                         mutex_lock(&sl->slot_lock);
>                         status =3D dvb_ca_en50221_write_data(ca, slot, fr=
agbuf,
> -                                                          fraglen + 2);
> +                                                          fraglen + 2, 0=
);
>                         mutex_unlock(&sl->slot_lock);
>                         if (status =3D=3D (fraglen + 2)) {
>                                 written =3D 1;
> --
> 2.17.1
>
