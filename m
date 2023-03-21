Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A34E6C35B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjCUPaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjCUPad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:30:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6607367FD;
        Tue, 21 Mar 2023 08:30:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j24so5221838wrd.0;
        Tue, 21 Mar 2023 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679412606;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ari/7JtTNW0WfcbZuhnrhR4cCTcsxRQZKwPb9wkPuo4=;
        b=VkupBurEgW0h/pfZf9DucwZbh1HfhAknnQz7ZcURPkf0CXFEgAp7Fq8lsz+kUYNje/
         OmtQ5d3Bc2mD5xZCm0/Y0kLikBj0OaS54XDLeJZ8Bb6dTLmYWDLcz0pi4HNl/y/VQbZt
         MQpft+arS+rJMWrO2xzZsX6VN38Hi9kZedAmjuGjE9ePK1Xrq8T5sQGSTl1RcYrpDFsW
         r+HQPEFQviWB6nqOYLl1eg2TW32E4XiRLSOicP+B2blonfEzJoV+P2lM5B6BzHXgnGCi
         DNDn33UiwqdPcVCtm3aSFCcjb4D6dT0L3KHsyOfSjEeaUDSjHr3Ms1Yu0ERtb9Ib78bh
         AlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679412606;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ari/7JtTNW0WfcbZuhnrhR4cCTcsxRQZKwPb9wkPuo4=;
        b=HwmBFb9wpSzNTGJzqwrhxIH/ARS9wyvQO00vWCQw1I+qobleNaKhCu6gl6IR2iNqCX
         y48g9vPpSVS5G27QSVGuA9072NGpYJMujbJDxOkhfGoBSgObrwuZsauwvroCQHvunDUX
         iCB3BpytkYQX6uLQCxVtcyp33AuzMphceturdx57XcUFCJDjr2RpDrdRhtL5QEzVQja9
         coRBibHrK6/+b6AaJ7giqm2fNKDNrpiZBxHpKBj4lcBKqZX5esolmERqVqBO8pnaUrxl
         Njd9a5ccPGV2Z7vxe5Ib9BkoaUDCON2cpY46wgWokerHlLvdIxavCzjfTneCCloDi+Vr
         MesA==
X-Gm-Message-State: AO0yUKVtaemw2eewgRX60j5aj/zIp1Fbp+dC6X7MKhp7oCBsICP2USIj
        fjQ6UmGll/9XxhvaX1Ewq0A=
X-Google-Smtp-Source: AK7set+oFplvc6wvPLsOfP4NJKKW5rdvK3dpDjNY4C7LLchtelC4UNA/jj1MeAvdcXyxeLnPmcL8YA==
X-Received: by 2002:a5d:6a8e:0:b0:2d1:f165:7041 with SMTP id s14-20020a5d6a8e000000b002d1f1657041mr3156639wru.11.1679412606112;
        Tue, 21 Mar 2023 08:30:06 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000181700b002c5694aef92sm11516642wrh.21.2023.03.21.08.30.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2023 08:30:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH v3 2/2] media: meson: vdec: add HEVC decode codec
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <558a8afc-f62d-aec7-aca5-5d26471ba332@xs4all.nl>
Date:   Tue, 21 Mar 2023 19:30:01 +0400
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org,
        AML <linux-amlogic@lists.infradead.org>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Benjamin Roszak <benjamin545@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AEAFD8D1-D7F4-470A-A84B-E18DD9FDA735@gmail.com>
References: <20230314114318.4057353-1-christianshewitt@gmail.com>
 <20230314114318.4057353-3-christianshewitt@gmail.com>
 <558a8afc-f62d-aec7-aca5-5d26471ba332@xs4all.nl>
To:     Hans Verkuil <hverkuil@xs4all.nl>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 21 Mar 2023, at 6:25 pm, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>=20
> On 14/03/2023 12:43, Christian Hewitt wrote:
>> From: Maxime Jourdan <mjourdan@baylibre.com>
>>=20
>> Add initial HEVC codec for the Amlogic GXBB/GXL/GXM SoCs using
>> the common "HEVC" decoder driver.
>>=20
>> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
>> [codec alignment to upstream changes and frame handling improvements]
>> Signed-off-by: Benjamin Roszak <benjamin545@gmail.com>
>> ---
>> drivers/staging/media/meson/vdec/Makefile     |    2 +-
>> drivers/staging/media/meson/vdec/codec_hevc.c | 1463 =
+++++++++++++++++
>> drivers/staging/media/meson/vdec/codec_hevc.h |   13 +
>> drivers/staging/media/meson/vdec/esparser.c   |    3 +-
>> drivers/staging/media/meson/vdec/hevc_regs.h  |    1 +
>> .../staging/media/meson/vdec/vdec_platform.c  |   37 +
>> 6 files changed, 1517 insertions(+), 2 deletions(-)
>> create mode 100644 drivers/staging/media/meson/vdec/codec_hevc.c
>> create mode 100644 drivers/staging/media/meson/vdec/codec_hevc.h
>>=20
>=20
> <snip>
>=20
>> diff --git a/drivers/staging/media/meson/vdec/vdec_platform.c =
b/drivers/staging/media/meson/vdec/vdec_platform.c
>> index 88c9d72e1c83..ea2aa0e8cf0b 100644
>> --- a/drivers/staging/media/meson/vdec/vdec_platform.c
>> +++ b/drivers/staging/media/meson/vdec/vdec_platform.c
>> @@ -11,10 +11,23 @@
>> #include "vdec_hevc.h"
>> #include "codec_mpeg12.h"
>> #include "codec_h264.h"
>> +#include "codec_hevc.h"
>> #include "codec_vp9.h"
>>=20
>> static const struct amvdec_format vdec_formats_gxbb[] =3D {
>> 	{
>> +		.pixfmt =3D V4L2_PIX_FMT_HEVC,
>> +		.min_buffers =3D 4,
>> +		.max_buffers =3D 24,
>> +		.max_width =3D 3840,
>> +		.max_height =3D 2160,
>> +		.vdec_ops =3D &vdec_hevc_ops,
>> +		.codec_ops =3D &codec_hevc_ops,
>> +		.firmware_path =3D "meson/vdec/gxl_hevc.bin",
>> +		.pixfmts_cap =3D { V4L2_PIX_FMT_NV12M, 0 },
>> +		.flags =3D V4L2_FMT_FLAG_COMPRESSED |
>> +			 V4L2_FMT_FLAG_DYN_RESOLUTION,
>> +	}, {
>> 		.pixfmt =3D V4L2_PIX_FMT_H264,
>> 		.min_buffers =3D 2,
>> 		.max_buffers =3D 24,
>> @@ -64,6 +77,18 @@ static const struct amvdec_format =
vdec_formats_gxl[] =3D {
>> 		.pixfmts_cap =3D { V4L2_PIX_FMT_NV12M, 0 },
>> 		.flags =3D V4L2_FMT_FLAG_COMPRESSED |
>> 			 V4L2_FMT_FLAG_DYN_RESOLUTION,
>> +	}, {
>> +		.pixfmt =3D V4L2_PIX_FMT_HEVC,
>> +		.min_buffers =3D 4,
>> +		.max_buffers =3D 24,
>> +		.max_width =3D 3840,
>> +		.max_height =3D 2160,
>> +		.vdec_ops =3D &vdec_hevc_ops,
>> +		.codec_ops =3D &codec_hevc_ops,
>> +		.firmware_path =3D "meson/vdec/gxl_hevc.bin",
>> +		.pixfmts_cap =3D { V4L2_PIX_FMT_NV12M, 0 },
>> +		.flags =3D V4L2_FMT_FLAG_COMPRESSED |
>> +			 V4L2_FMT_FLAG_DYN_RESOLUTION,
>> 	}, {
>> 		.pixfmt =3D V4L2_PIX_FMT_H264,
>> 		.min_buffers =3D 2,
>> @@ -114,6 +139,18 @@ static const struct amvdec_format =
vdec_formats_gxm[] =3D {
>> 		.pixfmts_cap =3D { V4L2_PIX_FMT_NV12M, 0 },
>> 		.flags =3D V4L2_FMT_FLAG_COMPRESSED |
>> 			 V4L2_FMT_FLAG_DYN_RESOLUTION,
>> +	}, {
>> +		.pixfmt =3D V4L2_PIX_FMT_HEVC,
>> +		.min_buffers =3D 4,
>> +		.max_buffers =3D 24,
>> +		.max_width =3D 3840,
>> +		.max_height =3D 2160,
>> +		.vdec_ops =3D &vdec_hevc_ops,
>> +		.codec_ops =3D &codec_hevc_ops,
>> +		.firmware_path =3D "meson/vdec/gxl_hevc.bin",
>=20
> Hmm, I don't see this firmware in any debian package. Is it made =
available to
> linux-firmware? This actually applies to *all* meson/vdec/ firmwares.

Yes, was upstreamed by Maxime in 2019 and updated 2020:

=
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.gi=
t/tree/meson/vdec

Christian

>> +		.pixfmts_cap =3D { V4L2_PIX_FMT_NV12M, 0 },
>> +		.flags =3D V4L2_FMT_FLAG_COMPRESSED |
>> +			 V4L2_FMT_FLAG_DYN_RESOLUTION,
>> 	}, {
>> 		.pixfmt =3D V4L2_PIX_FMT_H264,
>> 		.min_buffers =3D 2,

