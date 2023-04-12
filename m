Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5396DFAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDLQOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjDLQO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:14:27 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1F96E8A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:14:18 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230412161416euoutp0178d7fad05fb5d338a6f81eb2ca00e4d2~VPAuUWGya1426614266euoutp01_
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:14:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230412161416euoutp0178d7fad05fb5d338a6f81eb2ca00e4d2~VPAuUWGya1426614266euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681316056;
        bh=mJErNJqAaOKuevg4erS+jj/iV6Tf0H2AdcqJimvMrd0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=qPfgbgzKpp/TF3cYq2kUcEQdRQPf3V+IL+LofnJBtP5BJ+aD6WIVClPss7QnhDQBG
         DRrT7PkdcIVJt84TIZ9MtrVMSeqKKQ05RtOczoc9aww7CAk805TTTC97aW6vkKP3Q6
         Ar2DO2/f0SOPSrFbD9rt220Sd0celBrVVwmxUPD8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230412161415eucas1p2e194bfe601e12ac85f31d17b83aa0fce~VPAt12VUi0963809638eucas1p2i;
        Wed, 12 Apr 2023 16:14:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FA.BD.09503.7D8D6346; Wed, 12
        Apr 2023 17:14:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230412161415eucas1p1536b537c3f866e9820d3bea8bb9ea2d9~VPAtZiscS2982629826eucas1p1Y;
        Wed, 12 Apr 2023 16:14:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230412161415eusmtrp226df3dd82d73afb6a877861e742848e0~VPAtY2E7U1406814068eusmtrp2I;
        Wed, 12 Apr 2023 16:14:15 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-9c-6436d8d7e8b4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DA.BB.22108.7D8D6346; Wed, 12
        Apr 2023 17:14:15 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230412161414eusmtip1a84a6c6d8af932004cd0a42c22022ba7~VPAsjojgT1652616526eusmtip1b;
        Wed, 12 Apr 2023 16:14:14 +0000 (GMT)
Message-ID: <5fda9b2f-a339-8a23-dc7b-f1bac2c385b6@samsung.com>
Date:   Wed, 12 Apr 2023 18:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v9 1/6] media: verisilicon: Do not set context src/dst
 formats in reset functions
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk,
        robert.mader@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230220104849.398203-2-benjamin.gaignard@collabora.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87rXb5ilGOy6p22x5cpsZouNLz6z
        WDy86m9xceZdFovN53pYLVZN3clisenxNVaLrl8rmS0u75rDZtGzYSurxacH/5ktlm36w2TR
        uWIim8XdeydYLL69Wcxo8Xf7JhaLF1vEHQQ9/j6/zuKx4+4SRo+ds+6ye2xa1cnmsXlJvcfG
        dzuYPPr/Gnh0HbnO5vF5k5zHqa+f2QO4orhsUlJzMstSi/TtErgypnZtYC3oUqm48mUdSwPj
        TLkuRk4OCQETiWVnfjN1MXJxCAmsYJT4u3gXE0hCSOALo8SnKx4Q9mdGick3+GEaXr8/zw7R
        sJxR4vTqRcwQRR8ZJa68LgCxeQXsJM5tu8EKYrMIqErcnH+QDSIuKHFy5hMWEFtUIEVi98mn
        7CC2sEC6xP5D3WCLmQXEJW49mQ92kYjAWSaJvvsHWUAcZoGFjBLPmzaAbWMTMJToetsFNpVT
        wE1i/tlJrBDd8hLNW2czgzRICJzilPjZsI0R4m4XifV7m9ghbGGJV8e3QNkyEv93QqyTEGhn
        lFjw+z6UM4FRouH5Lahua4k7534BreMAWqEpsX6XPkTYUeLb57VgYQkBPokbbwUhjuCTmLRt
        OjNEmFeio00IolpNYtbxdXBrD164xDyBUWkWUsDMQgqAWUjemYWwdwEjyypG8dTS4tz01GLD
        vNRyveLE3OLSvHS95PzcTYzAlHj63/FPOxjnvvqod4iRiYPxEKMEB7OSCO8PF9MUId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzatieThQTSE0tSs1NTC1KLYLJMHJxSDUz+HMHS/oe4ni1J7Vj2
        /LH1sXtP9wc9zTk/QeSCVend+Zs2Sd+2jas8rXN9d6vGDae6Nj65YFOfVTm8LboPTKft1Dz2
        +rrd6XvaU/Y+8P+yKMT8OlvpC7533gv4qnZOfB+jsvFHuf3Zhl3pvhz8qRGXn+kasa7QbvnJ
        HRUlNa05YsrjZt/s9k8FMTXGvyumb+TqejHpxq9Pieu79laHP7shXBa/LZT99TJvtia/iAdR
        65Qmfyx4rP7K584Xfd+cZzM5yo9Nd1tsdsdwhfuXeiFn5mal1bGHDmnUOOZGdpX7qU5QM18x
        s0/vcpS8mUWX4CU/xdcd2+S/Tn5mc+3ocpO6duvZEse+TpeTFqz2LFViKc5INNRiLipOBAAQ
        FTjw+AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xu7rXb5ilGJxdzWux5cpsZouNLz6z
        WDy86m9xceZdFovN53pYLVZN3clisenxNVaLrl8rmS0u75rDZtGzYSurxacH/5ktlm36w2TR
        uWIim8XdeydYLL69Wcxo8Xf7JhaLF1vEHQQ9/j6/zuKx4+4SRo+ds+6ye2xa1cnmsXlJvcfG
        dzuYPPr/Gnh0HbnO5vF5k5zHqa+f2QO4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
        zWOtjEyV9O1sUlJzMstSi/TtEvQypnZtYC3oUqm48mUdSwPjTLkuRk4OCQETidfvz7N3MXJx
        CAksZZR41/uZDSIhI3FyWgMrhC0s8edaFxtE0XtGicWHpjCCJHgF7CTObbsBVsQioCpxc/5B
        Noi4oMTJmU9YQGxRgRSJXROWMoHYwgLpEvsPdYPZzALiEreezGcCGSoicJZJYv/8w2BnMAss
        ZJT4ufwrK8S6RkaJjZPmg41iEzCU6HrbBbaCU8BNYv7ZSawQo8wkurZ2MULY8hLNW2czT2AU
        moXkkllINs5C0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgYlg27Gfm3cwznv1
        Ue8QIxMH4yFGCQ5mJRHeHy6mKUK8KYmVValF+fFFpTmpxYcYTYHBMZFZSjQ5H5iK8kriDc0M
        TA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamHhOXFezPsFrY+ZfGH2u5fpP
        87bKcjaPr/Km3isDjuYnpSdZxZjdMuH/z9b1Y+UaS52Pr/8oC0w337ZA26Nqf4tvh/232p99
        YofW7Urdt/f7xn3p0xRmKMxS38GocSPxMsOyzKDFnGI627OZkmzOZohme0ZqRbwK7H/wZ6bd
        7ll39KYUf7URSHHI69fkXD6NX+7C56ktC6XKd9/1Dr4n84kvVL9qxq4nmq9FT9WpKf9ZMoFR
        Pqae+XpHLadT0uLzG32Oeb1qZelruNj4faO8zOfJPzYWFu34IC4wKenO5ldpjwKMb/M/6t0Z
        VGyvz15b8CxJeHXJDd78E4Kbox62zzgRoCbOHc/s1da65ZafEktxRqKhFnNRcSIAftyWE40D
        AAA=
X-CMS-MailID: 20230412161415eucas1p1536b537c3f866e9820d3bea8bb9ea2d9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230412161415eucas1p1536b537c3f866e9820d3bea8bb9ea2d9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230412161415eucas1p1536b537c3f866e9820d3bea8bb9ea2d9
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
        <20230220104849.398203-2-benjamin.gaignard@collabora.com>
        <CGME20230412161415eucas1p1536b537c3f866e9820d3bea8bb9ea2d9@eucas1p1.samsung.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20.02.2023 11:48, Benjamin Gaignard wrote:
> Setting context source and destination formats should only be done
> in hantro_set_fmt_out() and hantro_set_fmt_cap() after check that
> the targeted queue is not busy.
> Remove these calls from hantro_reset_encoded_fmt() and
> hantro_reset_raw_fmt() to clean the driver.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

This patch landed recently in linux-next as commit db6f68b51e5c ("media: 
verisilicon: Do not set context src/dst formats in reset functions").

Unfortunately it causes the following regression during Debian boot on 
Odroid-M1 board:

--->8---

hantro-vpu fdea0000.video-codec: Adding to iommu group 0
hantro-vpu fdea0000.video-codec: registered rockchip,rk3568-vpu-dec as 
/dev/video0
hantro-vpu fdee0000.video-codec: Adding to iommu group 1
hantro-vpu fdee0000.video-codec: registered rockchip,rk3568-vepu-enc as 
/dev/video1
Unable to handle kernel NULL pointer dereference at virtual address 
0000000000000008
Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000001f446f000
[0000000000000008] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in: hantro_vpu v4l2_vp9 v4l2_h264 v4l2_mem2mem 
videobuf2_dma_contig snd_soc_simple_card display_connector 
snd_soc_simple_card_utils videobuf2_memops crct10dif_ce dwmac_rk 
rockchip_thermal videobuf2_v4l2 stmmac_platform rockchip_saradc 
industrialio_triggered_buffer kfifo_buf stmmac videodev pcs_xpcs 
rtc_rk808 videobuf2_common rockchipdrm panfrost mc drm_shmem_helper 
analogix_dp gpu_sched dw_mipi_dsi dw_hdmi drm_display_helper ip_tables 
x_tables ipv6
CPU: 3 PID: 171 Comm: v4l_id Not tainted 6.3.0-rc2+ #13478
Hardware name: Hardkernel ODROID-M1 (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : hantro_try_fmt+0xb4/0x280 [hantro_vpu]
lr : hantro_try_fmt+0xa8/0x280 [hantro_vpu]
...
Call trace:
  hantro_try_fmt+0xb4/0x280 [hantro_vpu]
  hantro_set_fmt_out+0x3c/0x278 [hantro_vpu]
  hantro_reset_raw_fmt+0x94/0xb4 [hantro_vpu]
  hantro_set_fmt_cap+0x23c/0x250 [hantro_vpu]
  hantro_reset_fmts+0x94/0xcc [hantro_vpu]
  hantro_open+0xd4/0x20c [hantro_vpu]
  v4l2_open+0x80/0x120 [videodev]
  chrdev_open+0xc0/0x22c
  do_dentry_open+0x13c/0x490
  vfs_open+0x2c/0x38
  path_openat+0x550/0x938
  do_filp_open+0x80/0x12c
  do_sys_openat2+0xb4/0x16c
  __arm64_sys_openat+0x64/0xac
  invoke_syscall+0x48/0x114
  el0_svc_common.constprop.0+0xfc/0x11c
  do_el0_svc+0x38/0xa4
  el0_svc+0x48/0xb8
  el0t_64_sync_handler+0xb8/0xbc
  el0t_64_sync+0x190/0x194
Code: 97fe726c f940aa80 52864a61 72a686c1 (b9400800)
---[ end trace 0000000000000000 ]---

I know that v4l_id tool, which is a part of systemd/udev, is known to 
crash badly on various vendor kernels (fixing this would be a really 
hard, especially assuming the brokenness of some vendor hacks), but I 
hoped that at least it should not be able to crash the mainline kernel.


> ---
>   drivers/media/platform/verisilicon/hantro_v4l2.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index c0d427956210..d8aa42bd4cd4 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -382,13 +382,10 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>   
>   	vpu_fmt = hantro_get_default_fmt(ctx, true);
>   
> -	if (ctx->is_encoder) {
> -		ctx->vpu_dst_fmt = vpu_fmt;
> +	if (ctx->is_encoder)
>   		fmt = &ctx->dst_fmt;
> -	} else {
> -		ctx->vpu_src_fmt = vpu_fmt;
> +	else
>   		fmt = &ctx->src_fmt;
> -	}
>   
>   	hantro_reset_fmt(fmt, vpu_fmt);
>   	fmt->width = vpu_fmt->frmsize.min_width;
> @@ -408,11 +405,9 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>   	raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
>   
>   	if (ctx->is_encoder) {
> -		ctx->vpu_src_fmt = raw_vpu_fmt;
>   		raw_fmt = &ctx->src_fmt;
>   		encoded_fmt = &ctx->dst_fmt;
>   	} else {
> -		ctx->vpu_dst_fmt = raw_vpu_fmt;
>   		raw_fmt = &ctx->dst_fmt;
>   		encoded_fmt = &ctx->src_fmt;
>   	}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

