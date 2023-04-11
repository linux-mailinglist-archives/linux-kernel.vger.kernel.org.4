Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52306DDB92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjDKNDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjDKNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:03:44 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB2340C5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:03:19 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a23so4954115qtj.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112; t=1681218197; x=1683810197;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to
         :references:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=48ZGep8agVIFkiKE+tF0Dg09U1koXWBDBYS5oLlDvgg=;
        b=6v+dhrXtGDeDBqPvu1ZLzV5tJJ604ZmQpcMpwF4MAqbb0Q1pEsf7Ebbq34DSfVLlpU
         SvaEor9qMcmEROAh81rpc1OGVsqOMrM93YZX50eT4JRpLnrWSRTvUpYP26EeUPtYHUa5
         IJtU1CRbyFh+Ol0NDFfovUqJb/pRq9MkOg1YUYIiKKuO/yN0E7nITj53toUKHjv91OSX
         EcmMKnLocLMeAGrStVHt8vTEqj40gLBD1mPH7lc5nCcj9fVZ6VUUeYF59nSaPKjeFmEL
         yqSliAW/4t2O4cbD/XgHTZmtk7yafgIizDcBEUoMDRmILwQGQXLSvuHyWuMtg659Tt1Q
         fNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218197; x=1683810197;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to
         :references:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48ZGep8agVIFkiKE+tF0Dg09U1koXWBDBYS5oLlDvgg=;
        b=kjnR8t3Vnx9YO8GsF4nSjfqWFM4/y8qA9uppeuGShf9uqLG15vBLn8yQel/13xUC/e
         8PUoTFEzyHeIagcazJZx0cszKad8+y+JF6njA7rZeKaKLOcvrfgkOfBngycmUBAd1mUr
         A0xM39yL1cSKPCd8ErzOlmQTMZKQrmAhriAwW2dZMZ8hxmjHjccfwas+gVdKp5ZAgKiu
         0EesA4P0qSSnQp3f19GkbBegZEa//pxMnovIN/+Qx+4FnD+iO5tI/OxxRieu2wXd5dVV
         7x7n3ZTbpykIbyTqVuiX+FqhFWyKBmtvBGwYokR0lgRqUlcnNF54WK1mxdQ+YcKGRQ2p
         PmZQ==
X-Gm-Message-State: AAQBX9ehrrbqvX0gwj4koIQ8eShpGUAqWk5a3i5L92vUj8kIppED6gjE
        alXOt2jtpIsRUPZE6XOoCofGnQ==
X-Google-Smtp-Source: AKy350aBNqc9Nqhi4ZcBbIoTNhKQwdXmy00nuSQAUSrAiCgNfMG2bBNrHukz3572jhBTZ0lBRoqKOQ==
X-Received: by 2002:a05:622a:5d1:b0:3e4:e2f3:3776 with SMTP id d17-20020a05622a05d100b003e4e2f33776mr17808603qtb.16.1681218197534;
        Tue, 11 Apr 2023 06:03:17 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:199e::580])
        by smtp.gmail.com with ESMTPSA id b16-20020ac844d0000000b003e64303bd2dsm3541983qto.63.2023.04.11.06.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:03:17 -0700 (PDT)
Message-ID: <08dc61aa2c61771e99c73b308d4c36d40ea28c2f.camel@ndufresne.ca>
Subject: Re: [PATCH 2/9] media: v4l2: Add NV12_16L16 pixel format to v4l2
 format info
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        DVB_Linux_Media <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Tue, 11 Apr 2023 09:03:16 -0400
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
         <20230324151228.2778112-3-paul.kocialkowski@bootlin.com>
         <20230325210120.GB22214@pendragon.ideasonboard.com>
         <40774dc0ef32246af76a202caca3632abc1ae25f.camel@ndufresne.ca>
         <20230405042131.GO9915@pendragon.ideasonboard.com>
In-Reply-To: <20230405042131.GO9915@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Le mer. 5 avr. 2023, 00 h 21, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> a =C3=A9crit=C2=A0:
> Hi Nicolas,
>=20
> On Fri, Mar 31, 2023 at 02:54:20PM -0400, Nicolas Dufresne wrote:
> > Le samedi 25 mars 2023 =C3=A0 23:01 +0200, Laurent Pinchart a =C3=A9cri=
t=C2=A0:
> > > On Fri, Mar 24, 2023 at 04:12:21PM +0100, Paul Kocialkowski wrote:
> > > > Represent the NV12_16L16 pixel format in the v4l2 format info table=
.
> > > > This is a 16x16 tiled version of NV12.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >=C2=A0 drivers/media/v4l2-core/v4l2-common.c | 2 ++
> > > >=C2=A0 1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/=
v4l2-
core/v4l2-common.c
> > > > index 3d044b31caad..5101989716aa 100644
> > > > --- a/drivers/media/v4l2-core/v4l2-common.c
> > > > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > > > @@ -280,6 +280,8 @@ const struct v4l2_format_info *v4l2_format_info=
(u32
format)
> > > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Tiled YUV formats */
> > > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .format =3D V4L2_PIX_FMT_=
NV12_4L4, .pixel_enc =3D
V4L2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2,=
 0, 0 },
.hdiv =3D 2, .vdiv =3D 2 },
> > > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .format =3D V4L2_PIX_FMT_=
P010_4L4, .pixel_enc =3D
V4L2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 2, 4,=
 0, 0 },
.hdiv =3D 2, .vdiv =3D 2 },
> > > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .format =3D V4L2_PIX_FMT_NV12_=
16L16,=C2=A0 =C2=A0 .pixel_enc =3D
V4L2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2,=
 0, 0 },
.hdiv =3D 2, .vdiv =3D 2,
> > > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.block_w =3D { 16, 16, 0,=
 0 }, .block_h =3D { 16, 16, 0, 0 } },
> > >=20
> > > Not necessarily related to this patch, but I'm a bit puzzled by why
> > > V4L2_PIX_FMT_NV12_4L4 doesn't list block sizes.
> >=20
> > It looks like Ezequiel introduced that initially, but didn't introduce =
any
tiled
> > format, as a side effect, we missed it and no one ever used it.
> >=20
> > In practice, its not dramatic, since most of the time, the alignment ne=
eded
is
> > bigger then the block (specially with only 4x4 tiles), but we should
certainly
> > fix that, thanks for spotting.
>=20
> Just to make sure this won't fall through the cracks, will you send a
> patch ?

I didn't had any immediate plan to fix it (lack of time, absence of related
bugs). Andrzej, do you happen to have some time ? The SUNXI pixel format sh=
ould
have that too, along with some NXP format.

regards,
Nicolas
>=20
> > > >=C2=A0=20
> > > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* YUV planar formats, non =
contiguous variant */
> > > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .format =3D V4L2_PIX_FMT_=
YUV420M, .pixel_enc =3D V4L2_PIXEL_ENC_YUV, .mem_planes =3D 3, .comp_planes=
 =3D 3, .bpp =3D { 1, 1, 1, 0 }, .hdiv =3D 2, .vdiv =3D 2 },
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
