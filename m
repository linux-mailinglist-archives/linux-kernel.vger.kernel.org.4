Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4B62BF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiKPNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbiKPNf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:35:28 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B8D3F07E;
        Wed, 16 Nov 2022 05:35:16 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C274749C;
        Wed, 16 Nov 2022 14:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668605714;
        bh=Sys0rARy8J8jP/a46/LNXBCNgBu8UjwvelC2PQ7N1z4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CMucZLEkB7PjzR3s2w/0Moz6WaXvsCfSbDbnEMYdJDs6B1RpB+vqWMFWPhPodBAU7
         naMnG1Bpkpr4F7ZbK3KSP9zv/uIs5Ei3cOxQUw8IyN/sIAb39HxtIxUlZI/Adn1rUC
         zO3IzpQLHz00jaelSiu/Xe/clZXSdilgXTfvJ+pE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221116094006.16054-1-lukas.bulwahn@gmail.com>
References: <20221116094006.16054-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] media: i2c: refer to config VIDEO_DEV to make ov08x40 image sensor driver usable
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jason Chen <jason.z.chen@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org
Date:   Wed, 16 Nov 2022 13:35:12 +0000
Message-ID: <166860571228.50677.2036444260575403904@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lukas Bulwahn (2022-11-16 09:40:06)
> Commit 9958d30f38b9 ("media: Kconfig: cleanup VIDEO_DEV dependencies")
> removes the config VIDEO_V4L2 as it is merged with config VIDEO_DEV.
>=20
> Long after this change, commit 38fc5136ac16 ("media: i2c: Add ov08x40 ima=
ge
> sensor driver") introduces and refers to the removed config VIDEO_V4L2,
> basically making this driver impossible to build, test and use due to
> dependencies that cannot be met.
>=20
> Refer to config VIDEO_DEV instead to make this driver usable.


Fixes: 38fc5136ac16 ("media: i2c: Add ov08x40 image sensor driver")
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/media/i2c/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index 49c1c27afdc1..4a4ae9c20119 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -366,7 +366,7 @@ config VIDEO_OV08D10
> =20
>  config VIDEO_OV08X40
>         tristate "OmniVision OV08X40 sensor support"
> -       depends on VIDEO_V4L2 && I2C
> +       depends on VIDEO_DEV && I2C
>         select MEDIA_CONTROLLER
>         select VIDEO_V4L2_SUBDEV_API
>         select V4L2_FWNODE
> --=20
> 2.17.1
>
