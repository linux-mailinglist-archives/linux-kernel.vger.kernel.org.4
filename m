Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE471788C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjEaHpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjEaHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:45:27 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD910E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:45:25 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230531074522epoutp02827ff97b18ea38ed6f0f4d5e9fe74602~kKrYmo6T22799427994epoutp02B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:45:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230531074522epoutp02827ff97b18ea38ed6f0f4d5e9fe74602~kKrYmo6T22799427994epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685519122;
        bh=H6wakReZj3X6TMsaGJiAoGxjSAD48emzppa7JMd+Quw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JEfd3688uI7Eh4XJGTl1ykENCdoEguvQJ0C65REFJ+tYp+0P+sp+PhvtI0MpgkU2f
         Cuc+1mt0Zj+0LKt0z/0TUoO6BbbxydyRsq3Ne6bhkFyrY6EhecAMxqox+Jcz8/fAKy
         1rVe0ZYAtNLplueDEYobigpI9Ah+eGyKeQCTcHgA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230531074521epcas1p16f21c73bc229931a2313695ec2f5d344~kKrYHMYBm3064830648epcas1p1z;
        Wed, 31 May 2023 07:45:21 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.136]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QWLsF27BDz4x9Pw; Wed, 31 May
        2023 07:45:21 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.F7.48553.11BF6746; Wed, 31 May 2023 16:45:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230531074520epcas1p1c0d3f71f7baf85caccca82316a7b80fb~kKrXO4i7U3069230692epcas1p1u;
        Wed, 31 May 2023 07:45:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230531074520epsmtrp2862b808b9ec38ed7a764524fd94e254a~kKrXJiIy31510215102epsmtrp2Q;
        Wed, 31 May 2023 07:45:20 +0000 (GMT)
X-AuditID: b6c32a39-509937000001bda9-b4-6476fb11202a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.86.27706.01BF6746; Wed, 31 May 2023 16:45:20 +0900 (KST)
Received: from inkidae001 (unknown [10.113.221.213]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230531074520epsmtip205e0a19fdc3e2293041f027e4c134aaf~kKrW7MAMc2089220892epsmtip2H;
        Wed, 31 May 2023 07:45:20 +0000 (GMT)
From:   =?ks_c_5601-1987?B?tOvAzrHiL1RpemVuIFBsYXRmb3JtIExhYihTUikvu++8usD8wNo=?= 
        <inki.dae@samsung.com>
To:     "'Min Li'" <lm0963hack@gmail.com>
Cc:     <sw0312.kim@samsung.com>, <kyungmin.park@samsung.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230526130131.16521-1-lm0963hack@gmail.com>
Subject: RE: [PATCH] drm/exynos: fix race condition UAF in
 exynos_g2d_exec_ioctl
Date:   Wed, 31 May 2023 16:45:20 +0900
Message-ID: <13cd01d99393$d9b7b070$8d271150$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHl90PUgZVgoIOsoCnWfp0gsuCaowGTj1Ryr06bZVA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmvq7g77IUgwuHeC1OXF/EZPFg3jY2
        i//bJjJbXPn6ns1i7+ut7BZnm96wW2x6fI3V4vKuOWwWM87vY7I4Pr2ByWLG5JdsDtwee78t
        YPHYOesuu8eda3vYPO53H2fy2Lyk3qNvyypGj8+b5ALYo7JtMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZ/zacZex4AZPxfHTM1gaGG9zdTFy
        ckgImEh0zp7P1sXIxSEksINRYtWjCVDOJ0aJUw96GSGcb4wS9+f+Ye5i5ABr6d0WBBHfyyix
        eNZjVpBRQgIvGSXWLioCsdkEMiTuti9mBakXEVCVmHAxAKSeWWAbk8S5gyDrODk4Bawknlzv
        YwSpERYIkuj84AgSZgEqP7TkLFgJr4ClxJG2+YwQtqDEyZlPWEBsZgEjiSWr5zNB2PIS29/O
        YYb4RkHi59NlrBBxEYnZnW1gcRGgVfeubWIHuUFC4AiHRPvz9awQDS4S2z+chmoWlnh1fAs7
        hC0l8fndXjaIhsmMEneur2CBcGYwShz+eZ0RospYYv/SyUwQtqLEzt9zGSFW80m8+9rDCgkt
        XomONiGIEiWJYxdvQLVKSFxYMpFtAqPSLCTPzULy3Cwkz81C8tACRpZVjGKpBcW56anFhgWm
        8OhOzs/dxAhOwFqWOxinv/2gd4iRiYPxEKMEB7OSCK9tYnGKEG9KYmVValF+fFFpTmrxIUZT
        YHhPZJYSTc4H5oC8knhDE0sDEzMjYxMLQzNDJXHeL0+1U4QE0hNLUrNTUwtSi2D6mDg4pRqY
        mL2bju+8a+DC7d0t/Lfoc/7VRxKzXm6U0bqWrvxw/S6Turu7be2Tk3QbonZ67rKKsj7zye6Q
        9E1FlsJg7rcnTRqUq0S8LjukNrM+/33JJ2fjsSgpw2SzwK03p9mklAvOfh49W/Sc0sz1tjOY
        vD9csHW/van+6j7GSq4DbF6vzxu8KohhOR6pKac6bakXa9aVzXHWpde2WT3ws9EO5QiWKT1h
        oHewr/PvtzXT1H6cmrhAwCprScbOyro3v2/cbPwkvolD6W77lqUrWbkTEmdmeoT7bmE5ucpS
        agGba+LKcJYJLEs8Ly+r2RQ1x/zrwmdesWts3Vjkt15/ve/xDu2uSGmpkDsTlr92czHqW5yk
        xFKckWioxVxUnAgA9BM2mkkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSvK7A77IUg4+/tC1OXF/EZPFg3jY2
        i//bJjJbXPn6ns1i7+ut7BZnm96wW2x6fI3V4vKuOWwWM87vY7I4Pr2ByWLG5JdsDtwee78t
        YPHYOesuu8eda3vYPO53H2fy2Lyk3qNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgyfu24y1hw
        g6fi+OkZLA2Mt7m6GDk4JARMJHq3BXUxcnEICexmlJjWuZgJIi4hsWUrB4QpLHH4cDFEyXNG
        iZ6vt1i6GDk52ATSJCbN3c8KUiMioCox4WIASA2zwAEmievr17JBNHQzSlx5eIcJpIFTwEri
        yfU+RhBbWCBA4uqtx2wgNgtQ86ElZ8FsXgFLiSNt8xkhbEGJkzOfgC1jBrqz8XA3lC0vsf3t
        HGYQW0JAQeLn02WsEHERidmdbWBxEaBd965tYp/AKDwLyahZSEbNQjJqFpL2BYwsqxglUwuK
        c9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNQS3MH4/ZVH/QOMTJxMB5ilOBgVhLhtU0sThHi
        TUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBaf1sZsOsQwpz
        djp8eHNEbvnahJuraz7stE452mKb2Fq8Rkve4m5a94n6q/4LtjMv/PVorvvpjgv5XC46rwv+
        /bq09P10xmaxl3V3/1YzzDAxqYl4r5Nbu3bWI5aIab5db052eVRP7Z1etr/h+AyDMpGw4886
        Z7Lx8NiftpptMsd6Foeia3Z6gNFT7tWaX8Sz1PPCf1xdPWHR5b5Nl+eutMlwWba1RLmTSY3x
        uuY7j+Pza26X//feVPdttdIR5XXHHrbf3ZLhJNF2il3e5Ny3Wf/6VjFYpdmud9N7WpwQcJS1
        ML0kflLu7qPq4j1BHFteLft1Ovo0w7mVLIXTlRSent/29+RLycWZf6I9Gv9eYFNiKc5INNRi
        LipOBAC51w5YMQMAAA==
X-CMS-MailID: 20230531074520epcas1p1c0d3f71f7baf85caccca82316a7b80fb
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230527081826epcas1p15ec3fca591d914aff2019ddf7fd1d59c
References: <CGME20230527081826epcas1p15ec3fca591d914aff2019ddf7fd1d59c@epcas1p1.samsung.com>
        <20230526130131.16521-1-lm0963hack@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> -----Original Message-----
> From: Min Li <lm0963hack@gmail.com>
> Sent: Friday, May 26, 2023 10:02 PM
> To: inki.dae@samsung.com
> Cc: sw0312.kim@samsung.com; kyungmin.park@samsung.com; airlied@gmail.com;
> daniel@ffwll.ch; krzysztof.kozlowski@linaro.org; alim.akhtar@samsung.com;
> dri-devel@lists.freedesktop.org; linux-arm-kernel@lists.infradead.org;
> linux-samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] drm/exynos: fix race condition UAF in
> exynos_g2d_exec_ioctl
> 
> If it is async, runqueue_node is freed in g2d_runqueue_worker on another
> worker thread. So in extreme cases, if g2d_runqueue_worker runs first, and
> then executes the following if statement, there will be use-after-free.
> 

I received a report about the related issue from a white hacker before.
Thanks for contribution. :)

> Signed-off-by: Min Li <lm0963hack@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index ec784e58da5c..414e585ec7dd 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -1335,7 +1335,7 @@ int exynos_g2d_exec_ioctl(struct drm_device
*drm_dev,
> void *data,
>  	/* Let the runqueue know that there is work to do. */
>  	queue_work(g2d->g2d_workq, &g2d->runqueue_work);
> 
> -	if (runqueue_node->async)
> +	if (req->async)
>  		goto out;
> 
>  	wait_for_completion(&runqueue_node->complete);
> --
> 2.34.1


