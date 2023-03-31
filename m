Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B676D2879
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjCaTHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjCaTH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:07:26 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C0522933
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:07:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id n14so22623169qta.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112; t=1680289644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pMRUsebyQ3K+oRbvGz0OgZqKFBtrPEJ2p4+ZFvhigaU=;
        b=YuQxViwdUk90gHQ/2KIzGu/DK8R4deZMcmawGiTY+fXik+vDT6npk7xJqJFWoyp6TR
         e2VhlrZjt4RUoOLmQw313flnsClMLakq9J92I3I5n+G7SdQJQMGulL48Re+VsrqsitYa
         8A2FED5SaUxgAG8PcRFtGNwTRVCiC9VHuuMY8PejpvTq8+ARgsJfAzrXtBeDGKOUaR7M
         yUvajONXOgGY3AjiQ3KMfy0WgQad2sQN07S1w4qAiLZgmFsKgXYTuhIGZpOhIN8Zrf1G
         jthDxywmg2BHnm0uTRB/z7AT4EnIU/tmdolnadp7XfZiksfBnYXuOhfPYawRUDHi6P5n
         Zjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680289644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMRUsebyQ3K+oRbvGz0OgZqKFBtrPEJ2p4+ZFvhigaU=;
        b=Y9vIJiLVZJL5rIdwimIhTua5DWtaEjdsR6p0DWQCRTeZqpPjsqmNtiPrFVFDCWq3Jc
         5HGhNoj1kAPco9LzKqjmhajEBbeeoKwF8IyBy+f8/y+bBlT+ASt50HcSUB4atareeAVl
         hdwjn/EEbNRjsy0NNwxApESVl59OF44G31LkPXDme6oe0T8r/zlRhjnM5GN2q00NdTLO
         CDvKMgnmRpoIrO6S8XaigNfvQgMl5LNtIK74fthyE8hYVyZJ2sjPwU1bGUB5sJynehy6
         8lBRsl1OUcMgEnSvGlQkzxTRXZ6FxK87GEgpRrptfoaKlqNjxbihvaSUSBMyl3xDRuWh
         IxZg==
X-Gm-Message-State: AO0yUKUcUoGGou+vmHGl1RxLmi/a4qdOvnApwvcWpX4ZkhX6e9w9sRFF
        p2KAAjsKHC6VsOde2ATEFtpo/w==
X-Google-Smtp-Source: AK7set+yzGmjUCCfKmLI0eGwVq5GmGvjBm883sXpbX5Kxiis3RtX5l/GNMfOuCsLPZdohe+mayr6uQ==
X-Received: by 2002:a05:622a:181b:b0:3d0:7bdf:42c4 with SMTP id t27-20020a05622a181b00b003d07bdf42c4mr48530950qtc.59.1680289644733;
        Fri, 31 Mar 2023 12:07:24 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:a07e::580])
        by smtp.gmail.com with ESMTPSA id e1-20020a05620a014100b0074a1d2a17c8sm701489qkn.29.2023.03.31.12.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:07:24 -0700 (PDT)
Message-ID: <57144a4a5dc9994319bb1f7c3a75a1943227417c.camel@ndufresne.ca>
Subject: Re: [PATCH 4/9] media: v4l2: Add JPEG pixel format to v4l2 format
 info
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Fri, 31 Mar 2023 15:07:23 -0400
In-Reply-To: <20230324151228.2778112-5-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
         <20230324151228.2778112-5-paul.kocialkowski@bootlin.com>
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

Le vendredi 24 mars 2023 =C3=A0 16:12 +0100, Paul Kocialkowski a =C3=A9crit=
=C2=A0:
> Represent the JPEG pixel format in the v4l2 format info table.
>=20
> Note that the bpp is set to 1 which is not a proper way to estimate
> the needed buffer size for a given JPEG image. However the compression
> ratios of JPEG typically allow fitting the image in a smaller size,
> even though extra metadata could increase the total size by an
> arbitrary amount. Thus it is not a perfectly safe way to calculate the
> size of a JPEG buffer for given dimensions but it still provides a
> reasonable approach.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/v4l2-core/v4l2-common.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index 5101989716aa..8b2f201a8918 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -317,6 +317,9 @@ const struct v4l2_format_info *v4l2_format_info(u32 f=
ormat)
>  		{ .format =3D V4L2_PIX_FMT_SGBRG12,	.pixel_enc =3D V4L2_PIXEL_ENC_BAYE=
R, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =
=3D 1, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_SGRBG12,	.pixel_enc =3D V4L2_PIXEL_ENC_BAYE=
R, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =
=3D 1, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_SRGGB12,	.pixel_enc =3D V4L2_PIXEL_ENC_BAYE=
R, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .hdiv =
=3D 1, .vdiv =3D 1 },
> +
> +		/* Compressed formats */
> +		{ .format =3D V4L2_PIX_FMT_JPEG,	.pixel_enc =3D V4L2_PIXEL_ENC_COMPRES=
SED, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 1, 0, 0, 0 }, .hdiv =
=3D 1, .vdiv =3D 1 },

This is ackward, at best. Guesstimating the compressed buffer size is a val=
id
use case, but this table and the related helper function seems badly suited=
.
When I look at the stateless decoders that do that, they take into account =
the
fact that the compression can handle different bit depth, and difference
subsampling (choma idc). In this implementation, JPEG is reduce to 4:4:4, 8=
bit.

I'd like to reject this change, and recommand coming back with a suitable
integration, so that it can be special cased and the driver can communicate=
 the
required information to narrow down the estimate. And this way, you are act=
ually
making it usable for other compressed format like H.264, HEVC, VP8, VP9 AV1=
 etc.

Nicolas

Nacked in that form.

>=20
>  	};
>  	unsigned int i;
> =20

