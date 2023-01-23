Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25906786B0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjAWTqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjAWTqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:46:10 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6610226589
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:46:05 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id a25so10837913qto.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mUY+K/gEms4vfsNGwjElIC9Y1rJValU7AjQ/+P7XQGU=;
        b=M7vkSBADLg68yS5WFEvjM5Lx2R90zGRvw7OZ+Ot2DOA0cEw39ThzNEfTeqFJhgjMtr
         Pt9f8aooYdhoLWi5ap1uY7xiKGe4NPitD8MVA+vr1ecmeK8kXG0Bx4OwKy23QZmIQO7K
         D5WSlBRqYNTyWpzyDWpb+imz/9IBRGxcqQStVWyzLrfkfTOtqMFj9Xriae6/wRVAjCLs
         JmZ7LOc1DmQCU8D78MfaVAK2RU92npGK2Uct0mc8J9/lVMqA7ScFIUQInj8G5p3fEFss
         mtO23tXEGSRCpI1Wj6I2qLAicwMQnR/yrC+KzMv2Zt6Cci/UMjESOm+xJvFgutkmfoG5
         +Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUY+K/gEms4vfsNGwjElIC9Y1rJValU7AjQ/+P7XQGU=;
        b=isue1oQyAu/Xw2iHo9nWDiv8MDbyx0reS2OjgkGuQvstoGTZRm6bvaNKO7x1xyHaa7
         Zr1SzVBj55NgOxLO68sho93E/bKVLRnUzeG3PUwr+Ve/43rtZnnrKt1bnHPKFLT4JFOu
         XWKpo/k9aB9u2FDSTJYpqptynT79r7Hsp5NPmJxseTOVOGZwmHnWoTdqEk09CXoGrLOU
         8ew5PB863Cp5dDliEaInQhw8RD8Coz/oCbt0X/lKoMJQsMhOkpZoTWc+6nF00A+972ml
         /OuB7huj2vtaZz1vL26ocC4xmTrnMRB3qcVTD3Yn+km9oRVSGA0T7Bj8b/GNirWdL4Nn
         ZZ8g==
X-Gm-Message-State: AFqh2krNY3IMIA1lkmUxilrhzgkh8nCrsuu2UyIAysg2ilKQIe99qVZ/
        sGUB6IYdmy+Bfjodm3VgpfJqZQ==
X-Google-Smtp-Source: AMrXdXsK65R6/0BvIy5WSEzZ1awjWS2XHY8JYoDof3t2VDl8/Bdi0DMByDP+4TK9lSQkfcOvjuExvA==
X-Received: by 2002:a05:622a:a07:b0:3b6:2fd2:84b5 with SMTP id bv7-20020a05622a0a0700b003b62fd284b5mr41539393qtb.57.1674503164528;
        Mon, 23 Jan 2023 11:46:04 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id 188-20020a3703c5000000b006fb112f512csm42350qkd.74.2023.01.23.11.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 11:46:03 -0800 (PST)
Message-ID: <6e1cf4ee9bda46f0e15f715ed97dc46d06ffd735.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH v2 2/2] media: amphion: support to decode
 sorenson spark video
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 23 Jan 2023 14:46:01 -0500
In-Reply-To: <AM6PR04MB6341EEFACA1BAD7DC4E82B71E7C59@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1673513975.git.ming.qian@nxp.com>
         <ab85e597c37aad849480bfe912d5e06aebc51726.1673513975.git.ming.qian@nxp.com>
         <bb9fb55bf81b978041e44e04d619adf43488f467.camel@ndufresne.ca>
         <AM6PR04MB6341EEFACA1BAD7DC4E82B71E7C59@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 20 janvier 2023 =C3=A0 09:59 +0000, Ming Qian a =C3=A9crit=C2=
=A0:
> > From: Nicolas Dufresne <nicolas@ndufresne.ca>
> > Sent: 2023=E5=B9=B41=E6=9C=8820=E6=97=A5 4:41
> > To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org; hverkuil-
> > cisco@xs4all.nl
> > Cc: shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> > imx@nxp.com>; X.H. Bao <xiahong.bao@nxp.com>; Eagle Zhou
> > <eagle.zhou@nxp.com>; Tao Jiang <tao.jiang_2@nxp.com>; linux-
> > media@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v2 2/2] media: amphion: support to decode
> > sorenson spark video
> >=20
> > Caution: EXT Email
> >=20
> > Le jeudi 12 janvier 2023 =C3=A0 17:04 +0800, Ming Qian a =C3=A9crit :
> > > Sorenson Spark is an implementation of H.263 for use in Flash Video
> > > and Adobe Flash files.
> > > amphion decoder can support it by insert some startcode before
> > > sequence and picture.
> >=20
> > Its historical codec, but I'm surprise it does not also support H263 (a=
nd
> > possibly H263+). Note a review comment of course, just a curiosity.
> >=20
>=20
> Hi Nicolas,
> =C2=A0=C2=A0=C2=A0=C2=A0The decoder does support H263, but for sorenson s=
park, the vpu requires
> extra startcode, but H263 doesn't.
> So driver can't reuse H263 for format spark, as driver need to insert the
> startcode for format spark.

Ack.

I noticed later that it was supported and it make sense to make this a spec=
ific
formats, its not compatible, even though both are H264.
>=20
> Ming
>=20
> > >=20
> > > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > > ---
> > > =C2=A0drivers/media/platform/amphion/vdec.c       |  7 +++++++
> > > =C2=A0drivers/media/platform/amphion/vpu_malone.c | 18 ++++++++++++++=
++++
> > > =C2=A02 files changed, 25 insertions(+)
> > >=20
> > > diff --git a/drivers/media/platform/amphion/vdec.c
> > > b/drivers/media/platform/amphion/vdec.c
> > > index 87f9f8e90ab1..09304b96f40d 100644
> > > --- a/drivers/media/platform/amphion/vdec.c
> > > +++ b/drivers/media/platform/amphion/vdec.c
> > > @@ -165,6 +165,13 @@ static const struct vpu_format vdec_formats[] =
=3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION |
> > V4L2_FMT_FLAG_COMPRESSED
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > +     {
> > > +             .pixfmt =3D V4L2_PIX_FMT_SPK,
> > > +             .mem_planes =3D 1,
> > > +             .comp_planes =3D 1,
> > > +             .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> > > +             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION |
> > V4L2_FMT_FLAG_COMPRESSED
> > > +     },
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{0, 0, 0, 0},
> > > =C2=A0};
> > >=20
> > > diff --git a/drivers/media/platform/amphion/vpu_malone.c
> > > b/drivers/media/platform/amphion/vpu_malone.c
> > > index 2c9bfc6a5a72..67ba637c4c7f 100644
> > > --- a/drivers/media/platform/amphion/vpu_malone.c
> > > +++ b/drivers/media/platform/amphion/vpu_malone.c
> > > @@ -562,6 +562,7 @@ static struct malone_fmt_mapping fmt_mappings[] =
=3D
> > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{V4L2_PIX_FMT_H263,        MALONE=
_FMT_ASP},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{V4L2_PIX_FMT_JPEG,        MALONE=
_FMT_JPG},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{V4L2_PIX_FMT_VP8,         MALONE=
_FMT_VP8},
> > > +     {V4L2_PIX_FMT_SPK,         MALONE_FMT_SPK},
> > > =C2=A0};
> > >=20
> > > =C2=A0static enum vpu_malone_format vpu_malone_format_remap(u32
> > > pixelformat) @@ -987,6 +988,7 @@ static const struct
> > malone_padding_scode padding_scodes[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_EOS,      V4L2_PIX=
_FMT_XVID,        {0xb1010000,
> > > 0x0}},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_EOS,      V4L2_PIX=
_FMT_H263,        {0xb1010000,
> > > 0x0}},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_EOS,      V4L2_PIX=
_FMT_VP8,         {0x34010000,
> > > 0x0}},
> > > +     {SCODE_PADDING_EOS,      V4L2_PIX_FMT_SPK,         {0x34010000,
> > > 0x0}},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_EOS,      V4L2_PIX=
_FMT_JPEG,        {0xefff0000,
> > > 0x0}},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_ABORT,    V4L2_PIX=
_FMT_H264,        {0x0B010000, 0}},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_ABORT,    V4L2_PIX=
_FMT_H264_MVC,    {0x0B010000,
> > 0}},
> > > @@ -998,6 +1000,7 @@ static const struct malone_padding_scode
> > padding_scodes[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_ABORT,    V4L2_PIX=
_FMT_XVID,        {0xb1010000,
> > 0x0}},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_ABORT,    V4L2_PIX=
_FMT_H263,        {0xb1010000,
> > 0x0}},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_ABORT,    V4L2_PIX=
_FMT_VP8,         {0x34010000,
> > 0x0}},
> > > +     {SCODE_PADDING_ABORT,    V4L2_PIX_FMT_SPK,         {0x34010000,
> > 0x0}},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_EOS,      V4L2_PIX=
_FMT_JPEG,        {0x0, 0x0}},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_BUFFLUSH, V4L2_PIX=
_FMT_H264,        {0x15010000,
> > 0x0}},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{SCODE_PADDING_BUFFLUSH, V4L2_PIX=
_FMT_H264_MVC,
> > {0x15010000, 0x0}},
> > > @@ -1411,6 +1414,16 @@ static int
> > vpu_malone_insert_scode_vp8_pic(struct malone_scode_t *scode)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return size;
> > > =C2=A0}
> > >=20
> > > +static int vpu_malone_insert_scode_spk_seq(struct malone_scode_t
> > > +*scode) {
> > > +     return vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_SPK,
> > > +0); }
> > > +
> > > +static int vpu_malone_insert_scode_spk_pic(struct malone_scode_t
> > > +*scode) {
> > > +     return vpu_malone_insert_scode_pic(scode, MALONE_CODEC_ID_SPK,
> > > +0); }
> > > +
> > > =C2=A0static const struct malone_scode_handler scode_handlers[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0/* fix me, need to swap return operation after gstreamer
> > > swap */ @@ -1427,6 +1440,11 @@ static const struct
> > malone_scode_handler scode_handlers[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0.insert_scode_seq =3D vpu_malone_insert_scode_vp8_seq,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0.insert_scode_pic =3D vpu_malone_insert_scode_vp8_pic,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > +     {
> > > +             .pixelformat =3D V4L2_PIX_FMT_SPK,
> > > +             .insert_scode_seq =3D vpu_malone_insert_scode_spk_seq,
> > > +             .insert_scode_pic =3D vpu_malone_insert_scode_spk_pic,
> > > +     },
> > > =C2=A0};
> > >=20
> > > =C2=A0static const struct malone_scode_handler *get_scode_handler(u32
> > > pixelformat)
>=20

