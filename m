Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330B86DDC64
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDKNmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDKNmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:42:02 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C9510D3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:41:58 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1DC8220018;
        Tue, 11 Apr 2023 13:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681220517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7KgLgdH7cjz5drRb45WItsgeAVPeS+LVOF20gs6vrY=;
        b=bcJvA/OeOjZij8rqCIpNuk5SC2T/doK0e3fzWVx8ulahJBd9TLgybmVIdfBSNkoNZk2QwZ
        MwZtsGcaTN023bHSRm84f8Oo5Xssvbfu/v6eQYzoBOcTEOTvZcFkAPr1iwrJVV8g9mgHf2
        o/ObrhGsdveVjBAI+nU0jg3JVS64eUJ9tHCXtupLZdSE1ihj/EcJ++sSWiwucbWBI2IC3c
        W4Wzr4osoVD+9n0BlwT+awExRdz1dVXY+7vKyXUWBUHi0yn3XmR4SAkvQYnMPgnqxKw+Ja
        SxcSC4t3V2UVQkuCg6M5WyeZ89vcHtc2aWPrTzcQ7WE0Az5VYA0ZsIuID0toNg==
Date:   Tue, 11 Apr 2023 15:41:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH RESEND] mtd: onenand: omap2: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20230411154155.7416fd2d@xps-13>
In-Reply-To: <20230407190453.66efdf9d@endymion.delvare>
References: <20230407190453.66efdf9d@endymion.delvare>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

jdelvare@suse.de wrote on Fri, 7 Apr 2023 19:04:53 +0200:

> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
>=20
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> Even though this was supposedly accepted a few months ago already, I
> can't find this commit, neither upstream nor in the nand/next,
> therefore resending.

I have no idea what I did wrong but I definitely messed up, I can't
find this patch while it is marked Accepted in patchwork and I actually
answered that I applied it. It is especially strange since its
cousin applying to raw NAND was correctly taken. Sorry for the mess,
I'll really take it this time.

>=20
>  drivers/mtd/nand/onenand/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-6.2.orig/drivers/mtd/nand/onenand/Kconfig
> +++ linux-6.2/drivers/mtd/nand/onenand/Kconfig
> @@ -25,7 +25,7 @@ config MTD_ONENAND_GENERIC
>  config MTD_ONENAND_OMAP2
>  	tristate "OneNAND on OMAP2/OMAP3 support"
>  	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  	depends on OMAP_GPMC
>  	help
>  	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 SoC
>=20
>=20

Thanks,
Miqu=C3=A8l
