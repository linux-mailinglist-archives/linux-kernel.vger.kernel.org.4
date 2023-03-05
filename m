Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936B56AB283
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 22:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCEV2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 16:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCEV2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 16:28:47 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1741393F8;
        Sun,  5 Mar 2023 13:28:45 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id by13so7398837vsb.3;
        Sun, 05 Mar 2023 13:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678051724;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqMIsTuh5H2eGH/JwEzxFYeDZu5xrPX32j7KJzKP+FM=;
        b=nOvSNL7qrtE3M058QgbS/ijcFW76W4ifzeSTHgYMtNrGLsmo5MX4bVnpftbW2+motF
         mb0nwW0XQb5Hzl+YaJttXEMNTRCrFSzIGF5iEYQQdiPDU9ndv40WiQSHYmBPE0Uitd6J
         YGHzGY3xBYbrTWa7pPOFPNi1vfqOJXoNqZNFzmH8pEbV3plWoZuyrWesKArcpcLeMQqH
         drb7uggadaQHFXmMmbvPKrVpAEeqGtaX0R2hHbqLVeyGyqg+YDwoewW0Yl9DQKD6w8Ef
         mJSoEP4axldCbFyRF+a/rF0gZSENntksTeM74o23Iv+PNfTQXOTpEKKRNaBdm1DoUR2d
         7f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678051724;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqMIsTuh5H2eGH/JwEzxFYeDZu5xrPX32j7KJzKP+FM=;
        b=CFtLqW42KZWFxV/PB92iSGBBQL2g37FUpUrwIBpgvCfrNVyJYnzMPzhocXYQOb3afo
         xPbg+X3covj+j31iDgaApLQhYzNHtpMaZhTh7dp4A6Iyyr6bc83IufNTWmxdTP6te2rB
         VEFaf4PIcKSW7Znyd0o0gVF5oSatQrVKp/3dvtZPexkimHg7wfJuOO9h00zO3ZK8R95n
         X1LJmPaYJZKFegDSmf5t7OML8DgNAjB+FMvbP3DhDQqjhkp82/Zu25u7k/MXE4ylOJqa
         dHtioV/t2SGb4v7OKaaTNrbyz75cmV06wcytHP8Rm7e9SLgUzD07zez+94vKu17dVpDA
         E3Lw==
X-Gm-Message-State: AO0yUKVey5mstwAfZW3fVCpuba8TgceHljD4mlXvy8VvQV0l4zLpws8z
        tXF3G3yWB1dBHuKxtQY2ngvOl0IeLm8Xpyd6/516JpJljZ0=
X-Google-Smtp-Source: AK7set8UzjUHBzGzCgd7BqdCJkKC5Y32YBkbKjsU6tv6MqUonx4jZ+NTBojx5rv/XnGGxqg/RP3IeTyf5KXt2SU37I0=
X-Received: by 2002:a67:f4c9:0:b0:402:99ce:1da2 with SMTP id
 s9-20020a67f4c9000000b0040299ce1da2mr5962265vsn.7.1678051724094; Sun, 05 Mar
 2023 13:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20220818125027.1131-1-yongsuyoo0215@gmail.com>
In-Reply-To: <20220818125027.1131-1-yongsuyoo0215@gmail.com>
From:   YongSu Yoo <yongsuyoo0215@gmail.com>
Date:   Mon, 6 Mar 2023 06:28:32 +0900
Message-ID: <CANXPkT6iFFOZ_Q-Az=eA8pR2pSJ4o_mUt6uaRnBPq0C_BN+jug@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ca_en50221: A bug is fixed for size write
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, yongsu.yoo@lge.com,
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
