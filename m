Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A970E31D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbjEWRg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbjEWRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:36:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5456697
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:36:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af214a1929so261151fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20221208.gappssmtp.com; s=20221208; t=1684863404; x=1687455404;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3yXKkNvbD+E6srtcqBKqjjdVLMr+2MZVea2zCLfMe8=;
        b=0r7HQVPZQmFhLAOKLplvY2wNgS/qAl+m6CmzaeCRaGTsClDItlrQyP51RPTo4XW+CI
         SIPPMwdA9ljVRqJPjS1xxUXHWbsCdlqdKOulKgksVwE0P8J8U26YAuNBWtXyKck8Nx05
         os5HJkcaDEATwKU3d/v/yV2BJiHLxcJkascIhUOYf5TjIEk2fhbRBAx2SpHej/PJF5z1
         bmAg6yInYVQh9+4Uk5i62YV/UA3hNBwPdFqGbxQlbm6QdbxL8dzTHF1yZ12tHXyIoSOp
         e8fsAuR7HQXSYf1/6G1j4Zh6eybCoB3WQh9Rs7iZyafyCQIGrqRLr+fCkZadRt2iL1mq
         5E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684863404; x=1687455404;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3yXKkNvbD+E6srtcqBKqjjdVLMr+2MZVea2zCLfMe8=;
        b=LEAbtYQC/c4D9y52PpDdeNIOtbULDxJ9+poy2y+uH2BAbfJRqhvVype7FcnsfPJTnd
         J3HxTTbv422iWMMyvT7PQtiN8/xWKTPyMEe8mD8PJ0uWP1KFTbOmsTIUQYifylaHj8vY
         2P1AWq1CwwzrjjSlAuY5bs4AEIcx8T8wF59IbHq0+nq5OzS7kR6vDF53nyJgExpdzKBQ
         BFYkRcO2GSF9yw20u1NdVA9gE/6WqakTXAztRViENeMRaOm2rS30JTfj3XjCfh38CUtl
         HuBCVQRAr8YxfuVqOukriVoRZGkN7bRV44uqI3gFiprMIhU+p9kMml0HVlXCJdXbYHBF
         uvDA==
X-Gm-Message-State: AC+VfDxWHs+l9tMR8rZ+hVhTJILxhOiXz5ZEDE+2QfhqkL8rAcWbFAnf
        RWJHO5MpfbTsdRxyNJUEJznV2X4tJgz4pj9Gak/lhQ==
X-Google-Smtp-Source: ACHHUZ45tDHeXtcr5cUrhHtCcVJ0bxNdoTLxFJA1Tm0vWWWfOdwjrl8bJobJMQ/GXB0uy9MPfYlNokGme7HBr2WnkPs=
X-Received: by 2002:a19:f61a:0:b0:4f3:8267:a2f3 with SMTP id
 x26-20020a19f61a000000b004f38267a2f3mr4796279lfe.0.1684863404435; Tue, 23 May
 2023 10:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
 <c034db29-b664-793d-35e0-406fdfe2b145@collabora.com> <20230523170637.GE9943@pengutronix.de>
In-Reply-To: <20230523170637.GE9943@pengutronix.de>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 23 May 2023 14:36:32 -0300
Message-ID: <CAAEAJfAG_Z_tW8_LzgL7D+tGFYRhyJz3n0uy0gZiOkMnz6FOGA@mail.gmail.com>
Subject: Re: [PATCH] media: verisilicon: Additional fix for the crash when
 opening the driver
To:     Michael Tretter <m.tretter@pengutronix.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, didi.debian@cknow.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

After reviewing the format logic (hantro_reset_encoded_fmt and
hantro_reset_raw_fmt).
It seems to me trying to support Decoders, Encoders and so many
different SoC Variants, is getting increasingly fragile.
This driver is becoming a big fat monolith. Regressions like this will
be increasingly frequent.

The only codec that supports encoding right now is JPEG, so I think
it's a good idea to remove it for good,
and split it to its own driver.

Anyone volunteering? :-)

Thanks,
Ezequiel

On Tue, May 23, 2023 at 2:06=E2=80=AFPM Michael Tretter
<m.tretter@pengutronix.de> wrote:
>
> On Tue, 23 May 2023 18:36:09 +0200, Benjamin Gaignard wrote:
> >
> > Le 23/05/2023 =C3=A0 18:25, Benjamin Gaignard a =C3=A9crit :
> > > This fixes the following issue observed on Odroid-M1 board:
> > >
> > >   Unable to handle kernel NULL pointer dereference at virtual address=
 0000000000000008
> > >   Mem abort info:
> > >   ...
> > >   Modules linked in: crct10dif_ce hantro_vpu snd_soc_simple_card snd_=
soc_simple_card_utils v4l2_vp9 v4l2_h264 rockchip_saradc v4l2_mem2mem video=
buf2_dma_contig videobuf2_memops rtc_rk808 videobuf2_v4l2 industrialio_trig=
gered_buffer rockchip_thermal dwmac_rk stmmac_platform stmmac videodev kfif=
o_buf display_connector videobuf2_common pcs_xpcs mc rockchipdrm analogix_d=
p dw_mipi_dsi dw_hdmi drm_display_helper panfrost drm_shmem_helper gpu_sche=
d ip_tables x_tables ipv6
> > >   CPU: 3 PID: 176 Comm: v4l_id Not tainted 6.3.0-rc7-next-20230420 #1=
3481
> > >   Hardware name: Hardkernel ODROID-M1 (DT)
> > >   pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > >   pc : hantro_try_fmt+0xa0/0x278 [hantro_vpu]
> > >   lr : hantro_try_fmt+0x94/0x278 [hantro_vpu]
> > >   ...
> > >   Call trace:
> > >    hantro_try_fmt+0xa0/0x278 [hantro_vpu]
> > >    hantro_set_fmt_out+0x3c/0x298 [hantro_vpu]
> > >    hantro_reset_raw_fmt+0x98/0x128 [hantro_vpu]
> > >    hantro_set_fmt_cap+0x240/0x254 [hantro_vpu]
> > >    hantro_reset_encoded_fmt+0x94/0xcc [hantro_vpu]
> > >    hantro_reset_fmts+0x18/0x38 [hantro_vpu]
> > >    hantro_open+0xd4/0x20c [hantro_vpu]
> > >    v4l2_open+0x80/0x120 [videodev]
> > >    chrdev_open+0xc0/0x22c
> > >    do_dentry_open+0x13c/0x48c
> > >    vfs_open+0x2c/0x38
> > >    path_openat+0x550/0x934
> > >    do_filp_open+0x80/0x12c
> > >    do_sys_openat2+0xb4/0x168
> > >    __arm64_sys_openat+0x64/0xac
> > >    invoke_syscall+0x48/0x114
> > >    el0_svc_common+0x100/0x120
> > >    do_el0_svc+0x3c/0xa8
> > >    el0_svc+0x40/0xa8
> > >    el0t_64_sync_handler+0xb8/0xbc
> > >    el0t_64_sync+0x190/0x194
> > >   Code: 97fc8a7f f940aa80 52864a61 72a686c1 (b9400800)
> > >   ---[ end trace 0000000000000000 ]---
> > >
> > > Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst =
formats in reset functions")
>
> This patch partially reverts the previous commit. I wonder whether the re=
ason
> for resetting the context format only if the targeted queue is not busy s=
till
> stands.
>
> > >
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>
> Tested-by: Michael Tretter <m.tretter@pengutronix.de>
>
> > > ---
> >
> > Diederick, Marek, Michael,
> > I have tested this patch on my boards and I see no regressions on
> > decoder part and no more crash when probing the encoder.
> > Could you test it on your side to confirm it is ok ?
> >
> > Thorsten, I try/test regzbot commands, please tell me if it is correct.
> >
> > #regzbot ^introduced db6f68b51e5c
> > #regzbot title media: verisilicon: null pointer dereference in try_fmt
> > #regzbot ignore-activity
> >
> >
> > >   drivers/media/platform/verisilicon/hantro_v4l2.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drive=
rs/media/platform/verisilicon/hantro_v4l2.c
> > > index 835518534e3b..61cfaaf4e927 100644
> > > --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> > > +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > > @@ -397,10 +397,12 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, in=
t bit_depth)
> > >     if (!raw_vpu_fmt)
> > >             return -EINVAL;
> > > -   if (ctx->is_encoder)
> > > +   if (ctx->is_encoder) {
> > >             encoded_fmt =3D &ctx->dst_fmt;
> > > -   else
> > > +           ctx->vpu_src_fmt =3D raw_vpu_fmt;
> > > +   } else {
> > >             encoded_fmt =3D &ctx->src_fmt;
> > > +   }
> > >     hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
> > >     raw_fmt.width =3D encoded_fmt->width;
> >
