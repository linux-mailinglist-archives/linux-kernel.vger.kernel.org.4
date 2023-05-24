Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776C70EFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbjEXHvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbjEXHvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:51:14 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB5F93
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:51:11 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230524075107euoutp0145bc2a764100c0c9cf4883df65df6f66~iBPaBPlR60893708937euoutp01D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:51:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230524075107euoutp0145bc2a764100c0c9cf4883df65df6f66~iBPaBPlR60893708937euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684914667;
        bh=YEkrocO0Lhlb57mohHGNmeTDKwplmsj2mt7QK1SNvHM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=G9S4pcMqE6t09Qir0XS4yvAJ/f72EPm6+qstq18k5G4ztrs9ehjS/UDxwPyiNcBOP
         5bxkCi8ILMDMHsaiIZeEcZtNnEXh9k94dA353j86EIk1MLJR+N/gqD7o0GBh27+CTe
         XwgjmsCMU4MqDujouByXr8s3cfBHo4OC1LnwTccI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230524075107eucas1p2ba76fdf6fdf3d88c9abb90fcc8cc494f~iBPZxdIia2699126991eucas1p2E;
        Wed, 24 May 2023 07:51:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 04.1E.42423.AE1CD646; Wed, 24
        May 2023 08:51:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230524075106eucas1p26a6f2fc48035a96cd86912d6f9a71a69~iBPZYj3Qu2697926979eucas1p2R;
        Wed, 24 May 2023 07:51:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230524075106eusmtrp1900217962e97d095ced3bf5a75072223~iBPZXkj2v2522525225eusmtrp17;
        Wed, 24 May 2023 07:51:06 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-03-646dc1eab95a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5E.17.14344.AE1CD646; Wed, 24
        May 2023 08:51:06 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230524075105eusmtip233dd8d7684832bd1687f22a6140474c0~iBPYey1fZ1216812168eusmtip2R;
        Wed, 24 May 2023 07:51:05 +0000 (GMT)
Message-ID: <7659de84-2b90-7f6b-edf3-2e1e42f6e4c6@samsung.com>
Date:   Wed, 24 May 2023 09:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] media: verisilicon: Additional fix for the crash when
 opening the driver
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.tretter@pengutronix.de, didi.debian@cknow.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        regressions@lists.linux.dev
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djP87qvD+amGHx0sthyZTazReur5+wW
        G198ZrG4OPMui8Xmcz2sFqum7mSxuLxrDptFz4atrBafHvxntti24hyrxbJNf5gsdn25x2Zx
        994JFouNbzvYHfg8Tvw/wuKx4+4SRo9NqzrZPDYvqfd4sXkmo0f/XwOPriPX2Tw+b5LzOPX1
        M3sAZxSXTUpqTmZZapG+XQJXxvqFE9kL7ohX3Ju4n7GB8ZVwFyMnh4SAicSvBxvZuxi5OIQE
        VjBK9K2bxAjhfGGUONf1lA2kSkjgM6PE2m3ZMB3NB64xQRQtZ5T4uHcRM4TzkVFi1YaNTCBV
        vAJ2ElsuzmABsVkEVCW6vy1hhYgLSpyc+QQsLiqQKrFq80VmEFtYIF7iwKSrYDazgLjErSfz
        wTaICNxklOg4PB/sQGaBk4wSl7d/AetmEzCU6HrbBXYfp4CbROOeH2wQ3fIS29/OATtJQmA1
        p8TyL11AoziAHBeJt9ukIX4Qlnh1fAs7hC0jcXpyDwtEfTujxILf95kgnAmMEg3PbzFCVFlL
        3Dn3iw1kELOApsT6XfoQYUeJs5dAmkHm80nceCsIcQOfxKRt05khwrwSHW1CENVqErOOr4Nb
        e/DCJeYJjEqzkMJlFpL/ZyH5ZhbC3gWMLKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzEC
        093pf8c/7WCc++qj3iFGJg7GQ4wSHMxKIrwnyrNThHhTEiurUovy44tKc1KLDzFKc7AoifNq
        255MFhJITyxJzU5NLUgtgskycXBKNTBJhr1RS3pxy+Okg4SXadVjcVmZvXVxZ5+6NDdfqPgy
        O1x26hv2j9be7dMsX5yY3tEef7O1be0prR3Wwgp7Gpb8Xdus8XrRnf85blIfZ76+FD1javtM
        xbvcTP5iyW/qVqydbH/OcKZX9E7XxSEqm1rrayvebUr3qDh49dy5FfP5TfN7GuYktj18Umdx
        6dDswuAbK9ep34kOnrj0gVTVxO8MPUYf3Asdmz3z780rdstZwvTWfXpu4iPWg2Vz14l12blc
        CF8772Sf+dL6vjTFvVlMB7caf15yWGf2nMtPHghYbXf7ribAsvXqUwE10SUtF/9e4qkxd0wQ
        0G0+JCDe5+AafcGy+VkiS62FvHTZNQklluKMREMt5qLiRACH257w5gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xe7qvDuamGOw8qGCx5cpsZovWV8/Z
        LTa++MxicXHmXRaLzed6WC1WTd3JYnF51xw2i54NW1ktPj34z2yxbcU5Votlm/4wWez6co/N
        4u69EywWG992sDvweZz4f4TFY8fdJYwem1Z1snlsXlLv8WLzTEaP/r8GHl1HrrN5fN4k53Hq
        62f2AM4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
        vYz1CyeyF9wRr7g3cT9jA+Mr4S5GTg4JAROJ5gPXmLoYuTiEBJYyShy6t58RIiEjcXJaAyuE
        LSzx51oXG4gtJPCeUaLhbxyIzStgJ7Hl4gwWEJtFQFWi+9sSVoi4oMTJmU/A4qICqRInl94A
        s4UF4iUOTLrKDGIzC4hL3HoynwnEFhG4ySix4o8zyBHMAicZJc70zWWDuGgmo0TXvQVgHWwC
        hhJdbyGu4BRwk2jc84MNYpKZRNfWLkYIW15i+9s5zBMYhWYhOWQWkoWzkLTMQtKygJFlFaNI
        amlxbnpusZFecWJucWleul5yfu4mRmCEbzv2c8sOxpWvPuodYmTiYDzEKMHBrCTCe6I8O0WI
        NyWxsiq1KD++qDQntfgQoykwNCYyS4km5wNTTF5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6
        YklqdmpqQWoRTB8TB6dUA5OZ3Peqk6/nZwbacTJPi0t3KN7isKLqcMzlPW1V6Wpr2VmeiqkH
        S5yTNZ568y7P3Cl+N/KKrv15lfL+W4V5xHbn7685XOqs3shM2/KAd69bmsCe4DvNDvHeRblT
        S1MnhavecHvmnPRP7UC//LMaJaZchpUHzaz9Vggc3TZNVC7wrqxIvgQLT2py412vA3NkH8q4
        97VOZvjsG9DuJndqx/E/JmaJvIdMZEyL1jIntwrrx1bzFdmq3P3vsDzMN6XQ7Nf/deovGyfd
        +eF7zXvZbauE2YmcfeZS7/SNAw9O4Kj0dXz1M+vd60lqGn+Ctp2X72jfpRO0zHJzgipftHDa
        K2vHOcoH53HVS2cwrfVTYinOSDTUYi4qTgQAuyXLn3kDAAA=
X-CMS-MailID: 20230524075106eucas1p26a6f2fc48035a96cd86912d6f9a71a69
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230523162528eucas1p297a28b644c81704d7fc9a0810649e3e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523162528eucas1p297a28b644c81704d7fc9a0810649e3e9
References: <CGME20230523162528eucas1p297a28b644c81704d7fc9a0810649e3e9@eucas1p2.samsung.com>
        <20230523162515.993862-1-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.2023 18:25, Benjamin Gaignard wrote:
> This fixes the following issue observed on Odroid-M1 board:
>
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
>   Mem abort info:
>   ...
>   Modules linked in: crct10dif_ce hantro_vpu snd_soc_simple_card snd_soc_simple_card_utils v4l2_vp9 v4l2_h264 rockchip_saradc v4l2_mem2mem videobuf2_dma_contig videobuf2_memops rtc_rk808 videobuf2_v4l2 industrialio_triggered_buffer rockchip_thermal dwmac_rk stmmac_platform stmmac videodev kfifo_buf display_connector videobuf2_common pcs_xpcs mc rockchipdrm analogix_dp dw_mipi_dsi dw_hdmi drm_display_helper panfrost drm_shmem_helper gpu_sched ip_tables x_tables ipv6
>   CPU: 3 PID: 176 Comm: v4l_id Not tainted 6.3.0-rc7-next-20230420 #13481
>   Hardware name: Hardkernel ODROID-M1 (DT)
>   pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : hantro_try_fmt+0xa0/0x278 [hantro_vpu]
>   lr : hantro_try_fmt+0x94/0x278 [hantro_vpu]
>   ...
>   Call trace:
>    hantro_try_fmt+0xa0/0x278 [hantro_vpu]
>    hantro_set_fmt_out+0x3c/0x298 [hantro_vpu]
>    hantro_reset_raw_fmt+0x98/0x128 [hantro_vpu]
>    hantro_set_fmt_cap+0x240/0x254 [hantro_vpu]
>    hantro_reset_encoded_fmt+0x94/0xcc [hantro_vpu]
>    hantro_reset_fmts+0x18/0x38 [hantro_vpu]
>    hantro_open+0xd4/0x20c [hantro_vpu]
>    v4l2_open+0x80/0x120 [videodev]
>    chrdev_open+0xc0/0x22c
>    do_dentry_open+0x13c/0x48c
>    vfs_open+0x2c/0x38
>    path_openat+0x550/0x934
>    do_filp_open+0x80/0x12c
>    do_sys_openat2+0xb4/0x168
>    __arm64_sys_openat+0x64/0xac
>    invoke_syscall+0x48/0x114
>    el0_svc_common+0x100/0x120
>    do_el0_svc+0x3c/0xa8
>    el0_svc+0x40/0xa8
>    el0t_64_sync_handler+0xb8/0xbc
>    el0t_64_sync+0x190/0x194
>   Code: 97fc8a7f f940aa80 52864a61 72a686c1 (b9400800)
>   ---[ end trace 0000000000000000 ]---
>
> Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst formats in reset functions")
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/media/platform/verisilicon/hantro_v4l2.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 835518534e3b..61cfaaf4e927 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -397,10 +397,12 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
>   	if (!raw_vpu_fmt)
>   		return -EINVAL;
>   
> -	if (ctx->is_encoder)
> +	if (ctx->is_encoder) {
>   		encoded_fmt = &ctx->dst_fmt;
> -	else
> +		ctx->vpu_src_fmt = raw_vpu_fmt;
> +	} else {
>   		encoded_fmt = &ctx->src_fmt;
> +	}
>   
>   	hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
>   	raw_fmt.width = encoded_fmt->width;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

