Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD6767439E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjASUmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjASUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:42:06 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AC79EE0F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:41:31 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z9so2563766qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1jM2JQTdRNAdYzy1GQ8Op4oYVTBiB1MTyaHN5HgqtFQ=;
        b=G90JXst8UiJUIJm7dm3a/sYtG7NhkTvFEmQppGE0hH7IurH7MrzQIguR4FMczQzG4D
         LOy+4VdCoyC2rOpVbAsvWND1TldbzniA5lIg3zl7FkX5gYQR9iz8vbNdXvRwbUcS620P
         eXAGG4LWc3oQj8zfpvTUHYV58B/Hp+qZvnmBRKtoCzlHCk1N+WO6bgfKfDXfDY4Virhy
         iMifmeqgDfdVuKndw50gQa93m9LQaUVL5w5FDlgW9S6nLhePhUOQG7QlR4wf9yfU8tYr
         24sAQFPRErLH1z55azBDRTRFgrYiVrO86bp3vyFYdFAMmasFeHcs4ebwoBsQwK4T9J5H
         UXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jM2JQTdRNAdYzy1GQ8Op4oYVTBiB1MTyaHN5HgqtFQ=;
        b=IxP4kZfCU+c/C9gSI3ZGJ9E88+CeMdnuj4e1Avnwyq3Jqhd0XpEr+6NmOVDrAqD37j
         luJHDEKI7T7QXw98NGOBAGJ7zT/GPCs2E/teTkW/bFLPlH2spibKuHCngwm8NvWyG+eh
         Nj+HLx+l6zQrBmuc8E05CFzSetqP783Q4S3eNsreWA5nDeEeikZX5de01mUWWOwhBpPj
         NILslBxFYLOFkpa4+MMha0HJfTngal7nPQdRPoEk6Seh7aKVzEnZoTBxugBYB+9lX6hd
         Q83POWhaRgJ8m4JF/YHT9iPPfC5Lv8QoWh+gx0YbpPtqUyKzlT4gxVvVN3tpS5irMM9F
         P4gA==
X-Gm-Message-State: AFqh2kpBJFvMjmlhldkWqvxRL1S8ufQkwQ/vx+0DIJFvMd85nkDDYo1s
        VsLOvIzYu46KSPLNMCvmZfPTOg==
X-Google-Smtp-Source: AMrXdXvC9/kukIOkGJxFQ64UcL1d+ibzQMHjEy4HG2UUkfHs3di2p07mMQ01ChKb+J9L5KZYIHTnFA==
X-Received: by 2002:ac8:4a18:0:b0:3b6:8d44:5648 with SMTP id x24-20020ac84a18000000b003b68d445648mr6609929qtq.46.1674160882813;
        Thu, 19 Jan 2023 12:41:22 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id j25-20020ac874d9000000b003b0b903720esm12386762qtr.13.2023.01.19.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 12:41:22 -0800 (PST)
Message-ID: <bb9fb55bf81b978041e44e04d619adf43488f467.camel@ndufresne.ca>
Subject: Re: [PATCH v2 2/2] media: amphion: support to decode sorenson spark
 video
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 19 Jan 2023 15:41:19 -0500
In-Reply-To: <ab85e597c37aad849480bfe912d5e06aebc51726.1673513975.git.ming.qian@nxp.com>
References: <cover.1673513975.git.ming.qian@nxp.com>
         <ab85e597c37aad849480bfe912d5e06aebc51726.1673513975.git.ming.qian@nxp.com>
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

Le jeudi 12 janvier 2023 =C3=A0 17:04 +0800, Ming Qian a =C3=A9crit=C2=A0:
> Sorenson Spark is an implementation of H.263 for use
> in Flash Video and Adobe Flash files.
> amphion decoder can support it by insert some startcode
> before sequence and picture.

Its historical codec, but I'm surprise it does not also support H263 (and
possibly H263+). Note a review comment of course, just a curiosity.

>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/amphion/vdec.c       |  7 +++++++
>  drivers/media/platform/amphion/vpu_malone.c | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platfo=
rm/amphion/vdec.c
> index 87f9f8e90ab1..09304b96f40d 100644
> --- a/drivers/media/platform/amphion/vdec.c
> +++ b/drivers/media/platform/amphion/vdec.c
> @@ -165,6 +165,13 @@ static const struct vpu_format vdec_formats[] =3D {
>  		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
>  	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_SPK,
> +		.mem_planes =3D 1,
> +		.comp_planes =3D 1,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
> +	},
>  	{0, 0, 0, 0},
>  };
> =20
> diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/=
platform/amphion/vpu_malone.c
> index 2c9bfc6a5a72..67ba637c4c7f 100644
> --- a/drivers/media/platform/amphion/vpu_malone.c
> +++ b/drivers/media/platform/amphion/vpu_malone.c
> @@ -562,6 +562,7 @@ static struct malone_fmt_mapping fmt_mappings[] =3D {
>  	{V4L2_PIX_FMT_H263,        MALONE_FMT_ASP},
>  	{V4L2_PIX_FMT_JPEG,        MALONE_FMT_JPG},
>  	{V4L2_PIX_FMT_VP8,         MALONE_FMT_VP8},
> +	{V4L2_PIX_FMT_SPK,         MALONE_FMT_SPK},
>  };
> =20
>  static enum vpu_malone_format vpu_malone_format_remap(u32 pixelformat)
> @@ -987,6 +988,7 @@ static const struct malone_padding_scode padding_scod=
es[] =3D {
>  	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_XVID,        {0xb1010000, 0x0}},
>  	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_H263,        {0xb1010000, 0x0}},
>  	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_VP8,         {0x34010000, 0x0}},
> +	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_SPK,         {0x34010000, 0x0}},
>  	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_JPEG,        {0xefff0000, 0x0}},
>  	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H264,        {0x0B010000, 0}},
>  	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H264_MVC,    {0x0B010000, 0}},
> @@ -998,6 +1000,7 @@ static const struct malone_padding_scode padding_sco=
des[] =3D {
>  	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_XVID,        {0xb1010000, 0x0}},
>  	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_H263,        {0xb1010000, 0x0}},
>  	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_VP8,         {0x34010000, 0x0}},
> +	{SCODE_PADDING_ABORT,    V4L2_PIX_FMT_SPK,         {0x34010000, 0x0}},
>  	{SCODE_PADDING_EOS,      V4L2_PIX_FMT_JPEG,        {0x0, 0x0}},
>  	{SCODE_PADDING_BUFFLUSH, V4L2_PIX_FMT_H264,        {0x15010000, 0x0}},
>  	{SCODE_PADDING_BUFFLUSH, V4L2_PIX_FMT_H264_MVC,    {0x15010000, 0x0}},
> @@ -1411,6 +1414,16 @@ static int vpu_malone_insert_scode_vp8_pic(struct =
malone_scode_t *scode)
>  	return size;
>  }
> =20
> +static int vpu_malone_insert_scode_spk_seq(struct malone_scode_t *scode)
> +{
> +	return vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_SPK, 0);
> +}
> +
> +static int vpu_malone_insert_scode_spk_pic(struct malone_scode_t *scode)
> +{
> +	return vpu_malone_insert_scode_pic(scode, MALONE_CODEC_ID_SPK, 0);
> +}
> +
>  static const struct malone_scode_handler scode_handlers[] =3D {
>  	{
>  		/* fix me, need to swap return operation after gstreamer swap */
> @@ -1427,6 +1440,11 @@ static const struct malone_scode_handler scode_han=
dlers[] =3D {
>  		.insert_scode_seq =3D vpu_malone_insert_scode_vp8_seq,
>  		.insert_scode_pic =3D vpu_malone_insert_scode_vp8_pic,
>  	},
> +	{
> +		.pixelformat =3D V4L2_PIX_FMT_SPK,
> +		.insert_scode_seq =3D vpu_malone_insert_scode_spk_seq,
> +		.insert_scode_pic =3D vpu_malone_insert_scode_spk_pic,
> +	},
>  };
> =20
>  static const struct malone_scode_handler *get_scode_handler(u32 pixelfor=
mat)

