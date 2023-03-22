Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5816F6C4EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCVO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCVOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:55:49 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BA11B57E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:55:13 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2D5FE1C0006;
        Wed, 22 Mar 2023 14:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679496911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFfA11oca0z60zNaQoo8l9bTRoSybNo1r8bX+dEwnH8=;
        b=BCbP6P978hjPpmfP/HktMsFzWqr2cU0aBDRzuVx41Ae0cZRzjkyus4BSPwKrR6cYX5AqO8
        gHoiybIdDDQ2ljSgvr9wgMX+RUZmHncu3eNxt92/OFb8eiKFnNpOzdDKkmR2tUm4dfYetq
        a+FI1WM/diBlWqWK4c+/909BZ1a9Sk1krU9Ll2J81yCZi9DTmXPtJI3DXFB1HfT4tvu9P/
        X7Tv0VNktXp6L5UHUDLV8748FA4PNoJY9qqgHrOVWse7FOMzXhOG37LIqrb/oCddNt3wHl
        M4BY/dmkEoTDru7gq70xfNaedXdlIjEEdcp9XxGj3LZppZiHsgIa5IzLTSsgtw==
Date:   Wed, 22 Mar 2023 15:55:08 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] mtd: rawnand: mxc: Remove the unused function
 is_imx51_nfc()
Message-ID: <20230322155508.6f4acb80@xps-13>
In-Reply-To: <20230317074041.115036-1-jiapeng.chong@linux.alibaba.com>
References: <20230317074041.115036-1-jiapeng.chong@linux.alibaba.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

jiapeng.chong@linux.alibaba.com wrote on Fri, 17 Mar 2023 15:40:41
+0800:

> The function is_imx51_nfc is defined in the mxc_nand.c file, but not
> called elsewhere, so remove this unused function.
>=20
> drivers/mtd/nand/raw/mxc_nand.c:1602:19: warning: unused function 'is_imx=
51_nfc'.

Thanks for your patch, but apparently is_imx53_nfc() is also unused,
strange the robot did not pick this up. Anyway, no need to resend, I
received another patch removing both functions already.

>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4559
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/mtd/nand/raw/mxc_nand.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_n=
and.c
> index f6c96341b896..16d795c25609 100644
> --- a/drivers/mtd/nand/raw/mxc_nand.c
> +++ b/drivers/mtd/nand/raw/mxc_nand.c
> @@ -1599,11 +1599,6 @@ static inline int is_imx25_nfc(struct mxc_nand_hos=
t *host)
>  	return host->devtype_data =3D=3D &imx25_nand_devtype_data;
>  }
> =20
> -static inline int is_imx51_nfc(struct mxc_nand_host *host)
> -{
> -	return host->devtype_data =3D=3D &imx51_nand_devtype_data;
> -}
> -
>  static inline int is_imx53_nfc(struct mxc_nand_host *host)
>  {
>  	return host->devtype_data =3D=3D &imx53_nand_devtype_data;


Thanks,
Miqu=C3=A8l
