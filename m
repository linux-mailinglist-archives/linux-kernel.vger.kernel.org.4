Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DF4746641
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGCXt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjGCXt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:49:57 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB34013D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:49:54 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230703234950epoutp046d788479d8a1c7c9331ff519c27aae4b~ugH5p7wNc1245412454epoutp04y
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:49:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230703234950epoutp046d788479d8a1c7c9331ff519c27aae4b~ugH5p7wNc1245412454epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688428190;
        bh=M+PRu7t9Av84Uq/Ch0fMWh1O29jRGMDgZGtSzOc9xKM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=aDmNxbVl5fUOBvMnLppcWNenyJRFVsKnQNTPTHRMwe3LMXrzUVWDdLEboxWO1V1Ki
         Ebu42x7ZwillKvw55ob+Clsn/yDrxhHYq5yD9gfP7o54OH4jgoow8JT/xTZ6CrB0uy
         ztw7TrtDKodx8RIX1DYyNzeRCoeEV3SW5OdTKQYM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230703234950epcas1p396c3d95d3081fdb4cc6a7b662b6d10a0~ugH5HwxpT2621426214epcas1p3v;
        Mon,  3 Jul 2023 23:49:50 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.232]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Qw2hs1sJCz4x9Q5; Mon,  3 Jul
        2023 23:49:49 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.2B.57829.D9E53A46; Tue,  4 Jul 2023 08:49:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230703234948epcas1p135dbb5248ac8fefbe47651b0f822f4db~ugH3qBiKn3212432124epcas1p1h;
        Mon,  3 Jul 2023 23:49:48 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230703234948epsmtrp1ca01f9d5f8bf242bc49208fe9ad72fb8~ugH3pWq-C0142701427epsmtrp1o;
        Mon,  3 Jul 2023 23:49:48 +0000 (GMT)
X-AuditID: b6c32a33-635fe7000001e1e5-96-64a35e9d7c15
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.BD.64355.C9E53A46; Tue,  4 Jul 2023 08:49:48 +0900 (KST)
Received: from inkidae001 (unknown [10.113.221.213]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230703234948epsmtip224f17eb1dec36c6ebb221f4bfba05bc9~ugH3aH8S70594605946epsmtip2N;
        Mon,  3 Jul 2023 23:49:48 +0000 (GMT)
From:   =?ks_c_5601-1987?B?tOvAzrHiL1RpemVuIFBsYXRmb3JtIExhYihTUikvu++8usD8wNo=?= 
        <inki.dae@samsung.com>
To:     "'Paul Cercueil'" <paul@crapouillou.net>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Neil Armstrong'" <neil.armstrong@linaro.org>,
        "'Sam Ravnborg'" <sam@ravnborg.org>
Cc:     <devicetree@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20230703214715.623447-3-paul@crapouillou.net>
Subject: RE: [PATCH 2/3] drm/panel: ld9040: Register a backlight device
Date:   Tue, 4 Jul 2023 08:49:48 +0900
Message-ID: <0f0c01d9ae09$0d3a17f0$27ae47d0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQELXz3jF3oWSYlPLwE5KJCmEnZTHgIJPQsEAjYh06WxI1eC4A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmge7cuMUpBqv+cFg8mLeNzWLN3nNM
        FvOPnGO1uPL1PZtF34uHzBabHl9jtbi8aw6bxYzz+5gs3u+8xWjRv/gSi0Xr3iPsFit+bmV0
        4PFYfamdzWPTqk42jzvX9rB53O8+zuSxeUm9x5JpV9k8+rasYvT4vEkugCMq2yYjNTEltUgh
        NS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6FolhbLEnFKgUEBicbGS
        vp1NUX5pSapCRn5xia1SakFKToFpgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG1pP+BX0CFT2f
        WxkbGK/wdjFyckgImEi0PdvA2MXIxSEksINRonHKYVYI5xOjxNvOu4xwzsOL21hhWs5+aYZK
        7GSUWHBhGxuE85JRYtmq5ywgVWwCGRJ32xeDzRIR2M8k0fTtDTOIwyywhVHi+pk57CBVnALW
        Escv72AGsYUF3CVarvQygtgsAioSi9auZgOxeQUsJdas62CGsAUlTs58AraBWcBIYsnq+UwQ
        trzE9rdzmCHuU5D4+XQZK0RcRGJ2ZxtQnAPoCieJI398QG6QELjAIbFsynxGiHoXiXOXnkP1
        Cku8Or6FHcKWknjZ38YO0TCZUeLO9RUsEM4MRonDP69DdRtL7F86mQnCVpTY+XsuI8RmPol3
        X3tYQTZLCPBKdLQJQZQoSRy7eAOqVULiwpKJbBMYlWYh+W0Wkt9mIfltFpJ/FjCyrGIUSy0o
        zk1PTTYsMITHeHJ+7iZGcGrWMt7BeHn+P71DjEwcjIcYJTiYlUR4mx/OTxHiTUmsrEotyo8v
        Ks1JLT7EaAoM7onMUqLJ+cDskFcSb2hiaWBiZmRsYmFoZqgkzqs4YXaKkEB6YklqdmpqQWoR
        TB8TB6dUA1OPg3/515WHvtjnf9bxYdgtXyj5kIM3mTU2x2Vq4bm95b+rb7ukCSdIzeFijP4Q
        yR+5lM8q0O9l5S1GKaMi7o0btyavPOik1n3jwiQOaWtRxj0KK5iS/+5asedU5fY1pzLPpC66
        qlPwONZHOmuTt79v6IJVn2b0NGSyhZ/iu668OZpVsFDMPrJ//+n29WcPLNSq95zKFvdOqvbJ
        ScbliY2t++LYP/M0lrXr/Zv7bdXnnAtPut7wP6uLXjJbPUdJpXPmyRrepEdbtdXVZzH3r2x7
        dHZ3h0nj9LOGv55F/ttw55W3iYOB/kUzlW0K7+XcNxaEa6czypSXmsUohb75dWNddW1q4sHp
        mzeLZOz7qsRSnJFoqMVcVJwIANnp/j9WBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvO6cuMUpBs2z5SwezNvGZrFm7zkm
        i/lHzrFaXPn6ns2i78VDZotNj6+xWlzeNYfNYsb5fUwW73feYrToX3yJxaJ17xF2ixU/tzI6
        8HisvtTO5rFpVSebx51re9g87ncfZ/LYvKTeY8m0q2wefVtWMXp83iQXwBHFZZOSmpNZllqk
        b5fAlbH1pH9Bn0BFz+dWxgbGK7xdjJwcEgImEme/NDN2MXJxCAlsZ5SY1nGduYuRAyghIbFl
        KweEKSxx+HAxRMlzRonbK48xgfSyCaRJTJq7nxUkISJwmEmia9dTJhCHWWAHo8TqU6tZIFp2
        M0p8614O1sIpYC1x/PIOZhBbWMBdouVKLyOIzSKgIrFo7Wo2EJtXwFJizboOZghbUOLkzCcs
        IDYz0KmNh7uhbHmJ7W/nMEO8oCDx8+kyVoi4iMTszjawD0QEnCSO/PGZwCg8C8mkWUgmzUIy
        aRaS7gWMLKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxgmNSK2gH47L1f/UOMTJxMB5ilOBg
        VhLhbX44P0WINyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomDU6qB
        SWXqLOHOU2Lrtmb93bdEIMpweeOmx0Kfp8YzqpXlcFy+dZ2plblmT/2h9QdDfl5KlLgrdXVF
        RIzMtA0qDlmnzdi4xMTPfMpd+Umv5+F0gRl80TNzw/8vkbz18objhtiTp1Y6zW/d7F6/JjFc
        vK81/NzhO29ORp/vqD2idXj+8f3r6vYciT505MYfjwsqVot3HpggW3bSmmX1DUsRk4lHPz5P
        nrQk6OKVbVpa4td1nojdi+x0LflRM1ne7OA1zfvfr354mVr/pFSqxOtRuBj33/96bkdfdgfx
        5Kcd6ErunHJO4c/PRuGwtd8ZmdUideefyFkXtdAvsMf4kF5X9nFWWcOj+0t+SQR9jeX/y7t9
        sZUSS3FGoqEWc1FxIgAYrp9ROAMAAA==
X-CMS-MailID: 20230703234948epcas1p135dbb5248ac8fefbe47651b0f822f4db
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230703214744epcas1p1d2763aa96e694d0e1693fabf953e83f6
References: <20230703214715.623447-1-paul@crapouillou.net>
        <CGME20230703214744epcas1p1d2763aa96e694d0e1693fabf953e83f6@epcas1p1.samsung.com>
        <20230703214715.623447-3-paul@crapouillou.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> Paul Cercueil
> Sent: Tuesday, July 4, 2023 6:47 AM
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Rob Herring
> <robh+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Alim Akhtar
> <alim.akhtar@samsung.com>; Neil Armstrong <neil.armstrong@linaro.org>; Sam
> Ravnborg <sam@ravnborg.org>
> Cc: devicetree@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; Paul Cercueil
> <paul@crapouillou.net>; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH 2/3] drm/panel: ld9040: Register a backlight device
> 
> Register a backlight device to be able to switch between all the gamma
> levels.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/panel/panel-samsung-ld9040.c | 40 ++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-ld9040.c
> b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
> index 7fd9444b42c5..b4f87d6244cb 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-ld9040.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
> @@ -8,6 +8,7 @@
>   * Andrzej Hajda <a.hajda@samsung.com>
>  */
> 
> +#include <linux/backlight.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> @@ -311,8 +312,40 @@ static int ld9040_parse_dt(struct ld9040 *ctx)
>  	return 0;
>  }
> 
> +static int ld9040_bl_update_status(struct backlight_device *dev)
> +{
> +	struct ld9040 *ctx = dev_get_drvdata(&dev->dev);
> +
> +	ctx->brightness = dev->props.brightness;
> +	ld9040_brightness_set(ctx);
> +
> +	return 0;
> +}
> +
> +static int ld9040_bl_get_intensity(struct backlight_device *dev)
> +{
> +	if (dev->props.fb_blank == FB_BLANK_UNBLANK &&

fb_blank member is deprecated according to the description of backlight.h
file so you could drop above condition I think.

Thanks,
Inki Dae

