Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F126664C84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjAJTcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjAJT3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:29:04 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B5DFAD0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:29:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m6so20041156lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dvobj1X+xc4GVt39MIncU9qtTohL/6IewqIL/mqFFrs=;
        b=Mpp1KcH5J0Nxi7XqAbnBXAkVlLLyOmTJz5SFMLKi2bA3rGcVcwV1unlabs9okurghG
         X5s93wx5eojIsOXSj0Yw/2dY5clgbMKPGaBpc/NA9n+/SpHOgGvpMXpuOk48Gy4wH8db
         jixdxwBiVIlIBhfxL5xmBtHAfsAy4SGXOT/ub6llc2ciy1EZOSw5U/Czs7yrOOf0Q5+U
         eSRjkHN8RbwFk5Rd365SqyeeWfPhh8P2Zg8mSMMcNzNS2RTixqgbPDgmk1upVwL1cAgf
         DxaedNxYgQpRRC0aIb/mPH3rMfFWNtudRzC6SlBT9dqYi0ug5f8MFB8VT1lXx6wIAcWX
         dr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dvobj1X+xc4GVt39MIncU9qtTohL/6IewqIL/mqFFrs=;
        b=MDB6PTBy4nCA7OCJXte9laGEmdeiGy363MNJFhRDOJhDRvxk03E3AyL1L8c+wpElLz
         1t1CielB03ucvXwhBsOvV/LBpXLjXE88qcxiSP2yt3NNTm+CjUPlmU+qPDpS8VET4s36
         lyks5wLIeBG6bl7Ou8a7kLg85aEQE/ok1IjI+B37uk9AOzE8C1zhIxi/WCmJN3yF4cR+
         hnSXvwRS4xmgj0ffMVKM0CTS4aYB8qyDhFJhq3zBG/skWdd78oX/cl01q1YfNSbynt35
         CSAaovcu4TRFxmcztRBmqKCXcNRXEqGbt6wTxLXoNqJhkDp0VRNKzQ1ikAuGrqVOu3Zt
         Wo/g==
X-Gm-Message-State: AFqh2kojLjTATS6rR9AwYBCOLCfW+n02wdUP7Ms1u9loyNaC/2sGswL8
        46MzF3Z7Bxo1buP8jTLBE+TTDU9CF27X3VM9B52dGw==
X-Google-Smtp-Source: AMrXdXsSKeFeC0BCPqtujs7lk4hQBPbwtEg2u9EOGL4sawIpm45u9+Y9dXGLbvOP6ylptimmsYrU4P/UqdWHXSh5hSo=
X-Received: by 2002:a05:6512:708:b0:4ca:fab6:91db with SMTP id
 b8-20020a056512070800b004cafab691dbmr2840792lfs.202.1673378940985; Tue, 10
 Jan 2023 11:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20230103170058.810597-1-benjamin.gaignard@collabora.com>
 <20230103170058.810597-14-benjamin.gaignard@collabora.com>
 <CAAEAJfBRtBSZt0B3OyQSCHhsseUn6_H+JSvAR3cOH15WUryuNw@mail.gmail.com> <852e5269-cb3d-bd56-c7fd-0a1f461623de@collabora.com>
In-Reply-To: <852e5269-cb3d-bd56-c7fd-0a1f461623de@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 10 Jan 2023 16:28:49 -0300
Message-ID: <CAAEAJfDgL+zvFBd2556==W2aKBrzwCMCUR7vhBszArvnQrgQTQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] media: verisilicon: Conditionnaly ignore native formats
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Mon, Jan 9, 2023 at 6:05 AM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 08/01/2023 =C3=A0 22:12, Ezequiel Garcia a =C3=A9crit :
> > On Tue, Jan 3, 2023 at 2:01 PM Benjamin Gaignard
> > <benjamin.gaignard@collabora.com> wrote:
> >> AV1 film grain feature requires to use the postprocessor to produce
> >> valid frames. In such case the driver shouldn't propose native pixels
> >> format but only post-processed pixels format.
> >> If a codec set need_postproc field in hantro_ctx structure to true
> >> native pixel formats will be ignored.
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >> ---
> >>   drivers/media/platform/verisilicon/hantro.h   |  3 ++
> >>   .../media/platform/verisilicon/hantro_drv.c   |  5 ++
> >>   .../platform/verisilicon/hantro_postproc.c    |  4 ++
> >>   .../media/platform/verisilicon/hantro_v4l2.c  | 46 +++++++++++++----=
--
> >>   4 files changed, 45 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/med=
ia/platform/verisilicon/hantro.h
> >> index a98cb40a8d3b..7a5357e810fb 100644
> >> --- a/drivers/media/platform/verisilicon/hantro.h
> >> +++ b/drivers/media/platform/verisilicon/hantro.h
> >> @@ -231,6 +231,8 @@ struct hantro_dev {
> >>    * @ctrl_handler:      Control handler used to register controls.
> >>    * @jpeg_quality:      User-specified JPEG compression quality.
> >>    * @bit_depth:         Bit depth of current frame
> >> + * @need_postproc:     Set to true if the bitstream features require =
to
> >> + *                     use the post-processor.
> >>    *
> >>    * @codec_ops:         Set of operations related to codec mode.
> >>    * @postproc:          Post-processing context.
> >> @@ -258,6 +260,7 @@ struct hantro_ctx {
> >>          struct v4l2_ctrl_handler ctrl_handler;
> >>          int jpeg_quality;
> >>          int bit_depth;
> >> +       bool need_postproc;
> >>
> >>          const struct hantro_codec_ops *codec_ops;
> >>          struct hantro_postproc_ctx postproc;
> >> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers=
/media/platform/verisilicon/hantro_drv.c
> >> index 4fc6dea16ae6..8d7055c0bf3b 100644
> >> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> >> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> >> @@ -346,6 +346,11 @@ static int hantro_av1_s_ctrl(struct v4l2_ctrl *ct=
rl)
> >>                                  return -EINVAL;
> >>
> >>                  ctx->bit_depth =3D bit_depth;
> >> +
> >> +               if (ctrl->p_new.p_av1_sequence->flags
> >> +                   & V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT=
)
> >> +                       ctx->need_postproc =3D true;
> >> +

As discussed with Nicolas in IRC, I believe this should be handled differen=
tly.
This case is similar to
https://lore.kernel.org/all/f26407dbf3efc6cc046daaabdbe75c516743a187.camel@=
collabora.com/
and also similar to
https://elixir.bootlin.com/linux/latest/source/drivers/media/platform/sunxi=
/sun8i-rotate/sun8i_rotate.c#L582.

Setting the SPS control changes the possible pixel formats, so the S_CTRL i=
octl
should reset the format.

This means try_fmt should probably either check the (newly) SPS value
or some context fields (ctx->bit_depth, ctx->av1_film_grain, etc.).

Thanks,
Ezeqiuel

> >>                  break;
> >>          default:
> >>                  return -EINVAL;
> >> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/dr=
ivers/media/platform/verisilicon/hantro_postproc.c
> >> index 7dc39519a2ee..293e5612e2ce 100644
> >> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> >> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> >> @@ -57,6 +57,10 @@ bool hantro_needs_postproc(const struct hantro_ctx =
*ctx,
> >>   {
> >>          if (ctx->is_encoder)
> >>                  return false;
> >> +
> >> +       if (ctx->need_postproc)
> >> +               return true;
> >> +
> >>          return fmt->postprocessed;
> >>   }
> >>
> >> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/driver=
s/media/platform/verisilicon/hantro_v4l2.c
> >> index bbe79dbd2cd9..5c381766cca3 100644
> >> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> >> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> >> @@ -38,6 +38,11 @@ hantro_get_formats(const struct hantro_ctx *ctx, un=
signed int *num_fmts)
> >>   {
> >>          const struct hantro_fmt *formats;
> >>
> >> +       if (ctx->need_postproc) {
> >> +               *num_fmts =3D 0;
> >> +               return NULL;
> >> +       }
> >> +
> >>          if (ctx->is_encoder) {
> >>                  formats =3D ctx->dev->variant->enc_fmts;
> >>                  *num_fmts =3D ctx->dev->variant->num_enc_fmts;
> >> @@ -132,6 +137,15 @@ hantro_get_default_fmt(const struct hantro_ctx *c=
tx, bool bitstream)
> >>                      hantro_check_depth_match(ctx, &formats[i]))
> >>                          return &formats[i];
> >>          }
> >> +
> >> +       formats =3D hantro_get_postproc_formats(ctx, &num_fmts);
> >> +       for (i =3D 0; i < num_fmts; i++) {
> >> +               if (bitstream =3D=3D (formats[i].codec_mode !=3D
> >> +                                 HANTRO_MODE_NONE) &&
> >> +                   hantro_check_depth_match(ctx, &formats[i]))
> >> +                       return &formats[i];
> >> +       }
> >> +
> >>          return NULL;
> >>   }
> >>
> >> @@ -261,19 +275,6 @@ static int vidioc_g_fmt_out_mplane(struct file *f=
ile, void *priv,
> >>          return 0;
> >>   }
> >>
> >> -static int vidioc_g_fmt_cap_mplane(struct file *file, void *priv,
> >> -                                  struct v4l2_format *f)
> >> -{
> >> -       struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;
> >> -       struct hantro_ctx *ctx =3D fh_to_ctx(priv);
> >> -
> >> -       vpu_debug(4, "f->type =3D %d\n", f->type);
> >> -
> >> -       *pix_mp =3D ctx->dst_fmt;
> >> -
> >> -       return 0;
> >> -}
> >> -
> >>   static int hantro_try_fmt(const struct hantro_ctx *ctx,
> >>                            struct v4l2_pix_format_mplane *pix_mp,
> >>                            enum v4l2_buf_type type)
> >> @@ -353,6 +354,25 @@ static int hantro_try_fmt(const struct hantro_ctx=
 *ctx,
> >>          return 0;
> >>   }
> >>
> >> +static int vidioc_g_fmt_cap_mplane(struct file *file, void *priv,
> >> +                                  struct v4l2_format *f)
> >> +{
> >> +       struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;
> >> +       struct hantro_ctx *ctx =3D fh_to_ctx(priv);
> >> +       int ret;
> >> +
> >> +       vpu_debug(4, "f->type =3D %d\n", f->type);
> >> +
> >> +       ret =3D hantro_try_fmt(ctx, pix_mp, f->type);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       ctx->vpu_dst_fmt =3D hantro_find_format(ctx, pix_mp->pixelform=
at);
> >> +       ctx->dst_fmt =3D *pix_mp;
> >> +
> > This looks like the g_fmt is setting some state in the context,
> > this looks incorrect.
>
> Indeed only a call to hantro_try_fmt() is needed here.
> I will fix that in v3.
>
> Benjamin
>
> >
> > Thanks,
> > Ezequiel
