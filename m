Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9E5659864
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 13:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiL3MpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 07:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiL3MpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 07:45:12 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6BF11C26
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 04:45:11 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9D898FF806;
        Fri, 30 Dec 2022 12:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672404310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HLWw/hSJZJa/2KIWUjKLrI7JPtEFnluoknqg1vyqjA=;
        b=jE7MjJnAU4ROFgwsh44z0DnELsemJx4w2jKwXVuv+9yJCrKLmREXc4XFqCjc+zI3D0qVoy
        7OHnC5wgVpjOV0ES9l6wWoi88LUGEl176C+zBYQWIGqkZeSN9vopP6W8gDzL3A83jn9dwp
        RN6FbQuyyCvgzNE8tLv3hITUQuunmzuGLvCcyr/8ap1k12c4RF7W0BdNa3w1YR+F63F+Ov
        3W3rBOdI6tl1pa1xlpKBFK1QzyI3KxBdFdfsEeoALdc8I6K5KSyxCfjMp+4D1tOd8vLpNb
        uCD4tOS0T6Zt9y8sLYRLu8im1AOKdg3N7Kojqt6MO5P7RrqVyBv+gxlG6k6+Rg==
Date:   Fri, 30 Dec 2022 13:45:07 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: rawnand: hynix: Add support for
 H27UCG8T2FTR-BC MLC NAND
Message-ID: <20221230134507.719edeae@xps-13>
In-Reply-To: <20221229190906.6467-2-samuel@sholland.org>
References: <20221229190906.6467-1-samuel@sholland.org>
        <20221229190906.6467-2-samuel@sholland.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

samuel@sholland.org wrote on Thu, 29 Dec 2022 13:09:03 -0600:

> H27UCG8T2FTR-BC is similar to the already-supported H27UCG8T2ETR-BC, but
> reports a different ID.

Can you provide a datasheet for this part? I am surprised by the page
size. In general anyway, it's best to provide a link when adding
support for a new component.

Also, for your two series, no need to resend this time, but please use
git-format-patch and git-send-email to create your series, so that all
the patches are answers of the cover letter. It helps keeping all
patches and answers in the series packed together.

Thanks!
Miqu=C3=A8l

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  drivers/mtd/nand/raw/nand_hynix.c | 4 ++++
>  drivers/mtd/nand/raw/nand_ids.c   | 4 ++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nan=
d_hynix.c
> index 0d4d4bbfdece..836f152612ab 100644
> --- a/drivers/mtd/nand/raw/nand_hynix.c
> +++ b/drivers/mtd/nand/raw/nand_hynix.c
> @@ -721,6 +721,10 @@ static int hynix_nand_init(struct nand_chip *chip)
>  		     sizeof("H27UCG8T2ETR-BC") - 1))
>  		h27ucg8t2etrbc_init(chip);
> =20
> +	if (!strncmp("H27UCG8T2FTR-BC", chip->parameters.model,
> +		     sizeof("H27UCG8T2FTR-BC") - 1))
> +		h27ucg8t2etrbc_init(chip);
> +
>  	ret =3D hynix_nand_rr_init(chip);
>  	if (ret)
>  		hynix_nand_cleanup(chip);
> diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_=
ids.c
> index dacc5529b3df..167183ccb9e9 100644
> --- a/drivers/mtd/nand/raw/nand_ids.c
> +++ b/drivers/mtd/nand/raw/nand_ids.c
> @@ -55,6 +55,10 @@ struct nand_flash_dev nand_flash_ids[] =3D {
>  		{ .id =3D {0xad, 0xde, 0x14, 0xa7, 0x42, 0x4a} },
>  		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1664,
>  		  NAND_ECC_INFO(40, SZ_1K) },
> +	{"H27UCG8T2FTR-BC 64G 3.3V 8-bit",
> +		{ .id =3D {0xad, 0xde, 0x14, 0xab, 0x42, 0x4a} },
> +		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1664,
> +		  NAND_ECC_INFO(40, SZ_1K) },
>  	{"TH58NVG2S3HBAI4 4G 3.3V 8-bit",
>  		{ .id =3D {0x98, 0xdc, 0x91, 0x15, 0x76} },
>  		  SZ_2K, SZ_512, SZ_128K, 0, 5, 128, NAND_ECC_INFO(8, SZ_512) },

