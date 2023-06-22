Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A917399B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjFVIaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjFVIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:30:08 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7511FD2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:29:44 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687422539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Hu3MCvJbtH5Uydd/RtIXSndvH3codqm8tSUoxC5yDI=;
        b=cVvLcZCulrEap/xzXOHQMkw4n5h4NRJCGYKZiA0y5sl2IoYDnBP2+wezVy59rdDhGkXFf/
        Zu9h9OkPg/kq6dTm+McbxlUlZzHinTJlkw5ysALVlXQCuVRu4bdhFhyVRZn+FMFmz9C7+X
        JSjFjl4gS1OfUCvjMBBUPDJz0Ny0Uz9igF7ZjT/1VEsEL0KhCWGCeMkA7JG8OWXivVmjzb
        idgYnnonlMsadzXG4TMr7ETMd5v8j2y2LM3waluRIk1eBDPFX2QXHj/KYi77yubD4ouaJu
        pj70s56s/sC3DJibix2FZFztYDHarPRM0KwqnH2mlaSIfS8i314QHBBYiDC7MA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E50F1C0008;
        Thu, 22 Jun 2023 08:28:58 +0000 (UTC)
Date:   Thu, 22 Jun 2023 10:28:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     vigneshr@ti.com, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for HYPERBUS
Message-ID: <20230622102836.2be2ab1b@xps-13>
In-Reply-To: <20230620025359.33839-1-tudor.ambarus@linaro.org>
References: <20230620025359.33839-1-tudor.ambarus@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

tudor.ambarus@linaro.org wrote on Tue, 20 Jun 2023 05:53:59 +0300:

> Add myself as Designated Reviewer for Hyperbus support.
> I'm assessing the framework and I'd like to get involved
> in reviewing further patches.

Vignesh, any chance you could give feedback on this patch quickly? I'd
like to take it for the next PR if you agree.

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6992b7cc7095..df5c039fc577 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9623,6 +9623,7 @@ F:	tools/hv/
> =20
>  HYPERBUS SUPPORT
>  M:	Vignesh Raghavendra <vigneshr@ti.com>
> +R:	Tudor Ambarus <tudor.ambarus@linaro.org>
>  L:	linux-mtd@lists.infradead.org
>  S:	Supported
>  Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/


Thanks,
Miqu=C3=A8l
