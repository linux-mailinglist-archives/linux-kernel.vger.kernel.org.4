Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF426DDEFC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjDKPJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDKPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:08:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB215267;
        Tue, 11 Apr 2023 08:08:39 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54D6A66031EA;
        Tue, 11 Apr 2023 16:08:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681225717;
        bh=076CzJvPOPKrvq+MGxxB4wZDMf27bcPrUtizfOd0u4Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T9sqm70h7J7oaiuU67WzBUMIQBqkQlP3kEAMaYwOUOn8EdVh8dpBYOlSlRvwEfuHA
         U6aAjG5OZB86zADQEjkuWhUSySyZSwh3S/SrGLeFIM5NX0TuwVsAqmXscvVEYC4JO5
         ABDQnFbcqlThss8JCmtsHv3W6e4CYlO6TO7iGs/Dm/08pVIjKcnOapLBHosuE8lFpf
         sypiCU9ofXYqyiNDk/9tro41zQIhGbvdiTDrMW0gqjup6fhTlluQZ9FcnKrkGKY0pk
         CykGkxTVDxl3iXgi1RINxy7t/K1hgJlSs/6xQCWhgv7Qgk6TJO/FdJmVi5BQRi4zLd
         A8DwQn0sbAEhg==
Message-ID: <46703c104c57d7b192f3e19860809e8e71016997.camel@collabora.com>
Subject: Re: [PATCH v5 04/13] media: verisilicon: Get bit depth for
 V4L2_PIX_FMT_NV12_10LE40_4L4
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Tue, 11 Apr 2023 11:08:26 -0400
In-Reply-To: <20230330154043.1250736-5-benjamin.gaignard@collabora.com>
References: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
         <20230330154043.1250736-5-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 30 mars 2023 =C3=A0 17:40 +0200, Benjamin Gaignard a =C3=A9crit=C2=
=A0:
> Let's the driver knows that V4L2_PIX_FMT_NV12_10LE40_4L4 is a 10bits
> pixel format.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/verisilicon/hantro_v4l2.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index d238d407f986..7ed2dfd4aefa 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -71,6 +71,7 @@ int hantro_get_format_depth(u32 fourcc)
>  	switch (fourcc) {
>  	case V4L2_PIX_FMT_P010:
>  	case V4L2_PIX_FMT_P010_4L4:
> +	case V4L2_PIX_FMT_NV12_10LE40_4L4:
>  		return 10;
>  	default:
>  		return 8;

