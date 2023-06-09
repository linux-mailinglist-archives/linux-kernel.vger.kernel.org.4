Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579617293EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbjFII4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbjFIIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:55:46 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47DC44B2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:54:29 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686300868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yESK7y37bOjN3SANEmCGOV67A0u0f7lUiT19nPSlg4M=;
        b=jNN1WoLiV8ZGE/w2aBcCzWEts/3/G2/blZSW4AUZRnDkdl9/15/4LKJLzjX+ZBHOScRrWL
        68KSYL+V/Esx7DiJZA9tJZl803n4v95QOojdjfUxPoV6wDm/1qPaMUkYpN7K1Uugzj2OZd
        sC9r2Ot9qCWGz8viHLnErWaV+oLUyss+CyCdzsL6n3I4/Mlo1HkLSOjWlvZ1bqBqJLE00L
        49LXjLuvoKyPeUoxcoYxaBbz4Kifu2uqT+llPjM9z0sCtVypvAVACK46Iq5M3WO4qnGyuz
        J/RIO5NTU8TsKlYKPpPDVMyicNyiWSYd7D4ntKYGCSy73c7+97uwQDLZAzRDiA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1169960010;
        Fri,  9 Jun 2023 08:54:26 +0000 (UTC)
Date:   Fri, 9 Jun 2023 10:54:25 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v1 5/5] mtd: nand: add support for the Sandisk SDTNQGAMA
 chip
Message-ID: <20230609105425.60543d8b@xps-13>
In-Reply-To: <c21a0de8-f8f6-a8f9-417b-eca99dc8b55b@gmail.com>
References: <19bf714a-43f9-c30a-8197-91aaaf4a6e5d@gmail.com>
        <c21a0de8-f8f6-a8f9-417b-eca99dc8b55b@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

jbx6244@gmail.com wrote on Thu, 8 Jun 2023 18:31:04 +0200:

> Sandisk SDTNQGAMA is a 8GB size, 3.3V 8 bit chip with 16KB page size,
> 1KB write size and 40 bit ecc support
>=20
> Signed-off-by: Pawe=C5=82 Jarosz <paweljarosz3691@gmail.com>

Pawel needs to be author of the patch or credited with a
co-developped-by+SoB otherwise. The current SoB lines are invalid.

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  drivers/mtd/nand/raw/nand_ids.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_=
ids.c
> index dacc5529b..53c4118de 100644
> --- a/drivers/mtd/nand/raw/nand_ids.c
> +++ b/drivers/mtd/nand/raw/nand_ids.c
> @@ -44,6 +44,9 @@ struct nand_flash_dev nand_flash_ids[] =3D {
>  	{"TC58NVG6D2 64G 3.3V 8-bit",
>  		{ .id =3D {0x98, 0xde, 0x94, 0x82, 0x76, 0x56, 0x04, 0x20} },
>  		  SZ_8K, SZ_8K, SZ_2M, 0, 8, 640, NAND_ECC_INFO(40, SZ_1K) },
> +	{"SDTNQGAMA 64G 3.3V 8-bit",
> +		{ .id =3D {0x45, 0xde, 0x94, 0x93, 0x76, 0x57} },
> +		  SZ_16K, SZ_8K, SZ_4M, 0, 6, 1280, NAND_ECC_INFO(40, SZ_1K) },

I guess you'll need a sandisk driver to reflect the missing timings?

>  	{"SDTNRGAMA 64G 3.3V 8-bit",
>  		{ .id =3D {0x45, 0xde, 0x94, 0x93, 0x76, 0x50} },
>  		  SZ_16K, SZ_8K, SZ_4M, 0, 6, 1280, NAND_ECC_INFO(40, SZ_1K) },
> --
> 2.30.2
>=20


Thanks,
Miqu=C3=A8l
