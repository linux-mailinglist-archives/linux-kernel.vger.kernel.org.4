Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07A6AD9D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCGJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCGJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:03:56 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F032524;
        Tue,  7 Mar 2023 01:03:54 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 43BCE2000B;
        Tue,  7 Mar 2023 09:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678179833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lWnZbQ74txk8fmZIzwltqIy3VGDLFLIoD4qJMLHcs9Q=;
        b=AB8OTewy2WxToW9EIlO9ll68NNpEnvsLM6dwAkzbF8VXcC6yG5UIH+cipbDuAO4GocKFib
        A0XFjscqDG26hgdaKiqFbVTr49wyxAA6AKraiMfuUSDhYiYYIdGYpQvWUErCPRq7NO7BnA
        pJ1gTAo8o5+so1XRs+iMyIMTxFpED6mPzOnm/6kGALJNIQ6LcNqpKTA9WARgTzaDsJaacH
        jRvwNJrlxx85yQBQcJ7n3pCF2s1yqlzNLDe7msOrrniDHC2MJRIYwG8o9ojZvcQ+bAjlhK
        vMixj94XbsAxPSffJqwq2hvINHUo9FkHve5ePUsXZqwLCxgVrIaagJLzxQAvSA==
Date:   Tue, 7 Mar 2023 10:03:50 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: remove reference to config MTD_NAND_TMIO
Message-ID: <20230307100350.1c0af7b9@xps-13>
In-Reply-To: <20230307074038.17391-1-lukas.bulwahn@gmail.com>
References: <20230307074038.17391-1-lukas.bulwahn@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

lukas.bulwahn@gmail.com wrote on Tue,  7 Mar 2023 08:40:38 +0100:

> Commit 568494db6809 ("mtd: remove tmio_nand driver") removes the config
> MTD_NAND_TMIO and its corresponding driver.
>=20
> Remove the reference in MTD_SHARPSL_PARTS to that removed config.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Arnd, please ack.
> Miquel, please pick this minor non-urgent patch on top of the commit abov=
e.

Actually I guess the SHARPSL driver is not selectable right now, so
this should be sent as part of my next fixes PR. Could you please send
a v2 with a Fixes: tag?

>=20
>  drivers/mtd/parsers/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
> index b20e0c38b517..60738edcd5d5 100644
> --- a/drivers/mtd/parsers/Kconfig
> +++ b/drivers/mtd/parsers/Kconfig
> @@ -149,7 +149,7 @@ config MTD_PARSER_TRX
> =20
>  config MTD_SHARPSL_PARTS
>  	tristate "Sharp SL Series NAND flash partition parser"
> -	depends on MTD_NAND_SHARPSL || MTD_NAND_TMIO || COMPILE_TEST
> +	depends on MTD_NAND_SHARPSL || COMPILE_TEST
>  	help
>  	  This provides the read-only FTL logic necessary to read the partition
>  	  table from the NAND flash of Sharp SL Series (Zaurus) and the MTD


Thanks,
Miqu=C3=A8l
