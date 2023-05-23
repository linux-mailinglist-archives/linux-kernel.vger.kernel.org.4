Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E55D70E1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbjEWQ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjEWQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:28:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AEBC2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:28:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b0ee606cso10424e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20221208.gappssmtp.com; s=20221208; t=1684859303; x=1687451303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Fjno37nGq6ToMVKImqM2lZBGb3EVuqh7ZMDboA4Wx8=;
        b=ZC8VlTvXr5lx7bQVKwNDAk+CYJfCuDXLtTeH5F1vbaXCgvvAgytyFmqFQ09v+uv7/r
         P+hOstfU5a2yhpwSPkJ+agMRFx3d4qQ8MEjX1puTOk0QalHexKRzyiWnETUO80Sfu4qQ
         GIEmtCZDmUKwFYVEUSqZzCQGBtmA14P5GZ1GUGuZB8ri42UhDoPUP5yvQozORxKWBcsB
         dRHap5Y/Mip91sx7s7GgPn2Pj1sQCjWzPuw5lj8kMum3cTskuqvn+I10QUO6xJZekl/H
         HzO+ONNfCX9feqraOUdtG1EIu/V7C8oXyacEYMSOk09GE4uyVKyIMiNaEd+UghxyoiYm
         YeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684859303; x=1687451303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Fjno37nGq6ToMVKImqM2lZBGb3EVuqh7ZMDboA4Wx8=;
        b=SvYp1iFv8ZHifCXOgScfXdObSRC2E9/e1B4zvFKUjRpypf5WRmgX9Cso6F8etvb69K
         Jd91yyWEy6bqv9Cu23wROGmdbdBkh/O5B854mUuucDO31HAA1KjQbcDVMjEJHeNF/DbX
         G8WvCfw9Z3nV/LfP0Uoc/nzN/jrjoFFamIy/44T1VzILBjVGDPUJRsQ47My6YRhUWc6K
         FkhQJwgirt4Du4pwX+0AiIylJffYR/a+OZsYkPz+N8+/y/O5S1EEMBgIpFRyxcQA/9kO
         NuZqV3V9cYzmQOb1P6QvcYgb9Riaqx/eoaWo/bRrWFLQPHEdXYir0RLZKTsXHF1gzyjP
         SyZQ==
X-Gm-Message-State: AC+VfDxrX3b46ZDBhhL+SAXzl6VLZWqDpHnaAVRg30WQHz5TXONF3MEO
        ux7PfpebKIte4SXWCqbBDr3DrKua1XMN0FT8C7uBuw==
X-Google-Smtp-Source: ACHHUZ4ZG46KruFaIEkonBK5cy8poqFewof6mQjdcZ/qwwI8FGa2qjA7UJfen6qFakg1ItIS5mrKfGchjAhIooGdyQ0=
X-Received: by 2002:a2e:a37a:0:b0:2af:150f:d421 with SMTP id
 i26-20020a2ea37a000000b002af150fd421mr5307619ljn.5.1684859303206; Tue, 23 May
 2023 09:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
In-Reply-To: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 23 May 2023 13:28:11 -0300
Message-ID: <CAAEAJfDgJM++zHzR9ez94ZgRSr7H6NrohsG8=+8722ZEjC1gRg@mail.gmail.com>
Subject: Re: [PATCH] media: verisilicon: Additional fix for the crash when
 opening the driver
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     nicolas.dufresne@collabora.com, p.zabel@pengutronix.de,
        mchehab@kernel.org, m.szyprowski@samsung.com,
        m.tretter@pengutronix.de, didi.debian@cknow.org,
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

Hi Benjamin,

Thanks for the patch.

On Tue, May 23, 2023 at 1:25=E2=80=AFPM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
> This fixes the following issue observed on Odroid-M1 board:
>
>  Unable to handle kernel NULL pointer dereference at virtual address 0000=
000000000008

What pointer is NULL? ctx->src_fmt ?

>  Mem abort info:
>  ...
>  Modules linked in: crct10dif_ce hantro_vpu snd_soc_simple_card snd_soc_s=
imple_card_utils v4l2_vp9 v4l2_h264 rockchip_saradc v4l2_mem2mem videobuf2_=
dma_contig videobuf2_memops rtc_rk808 videobuf2_v4l2 industrialio_triggered=
_buffer rockchip_thermal dwmac_rk stmmac_platform stmmac videodev kfifo_buf=
 display_connector videobuf2_common pcs_xpcs mc rockchipdrm analogix_dp dw_=
mipi_dsi dw_hdmi drm_display_helper panfrost drm_shmem_helper gpu_sched ip_=
tables x_tables ipv6
>  CPU: 3 PID: 176 Comm: v4l_id Not tainted 6.3.0-rc7-next-20230420 #13481
>  Hardware name: Hardkernel ODROID-M1 (DT)
>  pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : hantro_try_fmt+0xa0/0x278 [hantro_vpu]
>  lr : hantro_try_fmt+0x94/0x278 [hantro_vpu]
>  ...
>  Call trace:
>   hantro_try_fmt+0xa0/0x278 [hantro_vpu]
>   hantro_set_fmt_out+0x3c/0x298 [hantro_vpu]
>   hantro_reset_raw_fmt+0x98/0x128 [hantro_vpu]
>   hantro_set_fmt_cap+0x240/0x254 [hantro_vpu]
>   hantro_reset_encoded_fmt+0x94/0xcc [hantro_vpu]
>   hantro_reset_fmts+0x18/0x38 [hantro_vpu]
>   hantro_open+0xd4/0x20c [hantro_vpu]
>   v4l2_open+0x80/0x120 [videodev]
>   chrdev_open+0xc0/0x22c
>   do_dentry_open+0x13c/0x48c
>   vfs_open+0x2c/0x38
>   path_openat+0x550/0x934
>   do_filp_open+0x80/0x12c
>   do_sys_openat2+0xb4/0x168
>   __arm64_sys_openat+0x64/0xac
>   invoke_syscall+0x48/0x114
>   el0_svc_common+0x100/0x120
>   do_el0_svc+0x3c/0xa8
>   el0_svc+0x40/0xa8
>   el0t_64_sync_handler+0xb8/0xbc
>   el0t_64_sync+0x190/0x194
>  Code: 97fc8a7f f940aa80 52864a61 72a686c1 (b9400800)
>  ---[ end trace 0000000000000000 ]---
>
> Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst form=
ats in reset functions")
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro_v4l2.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index 835518534e3b..61cfaaf4e927 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -397,10 +397,12 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bi=
t_depth)
>         if (!raw_vpu_fmt)
>                 return -EINVAL;
>
> -       if (ctx->is_encoder)
> +       if (ctx->is_encoder) {
>                 encoded_fmt =3D &ctx->dst_fmt;
> -       else
> +               ctx->vpu_src_fmt =3D raw_vpu_fmt;
> +       } else {
>                 encoded_fmt =3D &ctx->src_fmt;
> +       }
>
>         hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
>         raw_fmt.width =3D encoded_fmt->width;
> --
> 2.34.1
>
