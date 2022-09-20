Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461495BDF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiITINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiITIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:12:38 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D26232AB6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:10:27 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7A2E34001E;
        Tue, 20 Sep 2022 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTRGNviQHFqWuM3ffV1RWQ7rlvrVGJjSIWFr0QbELOo=;
        b=HbOYFV1wqgSj5sIyE9m9/t0E8rf1loYpPmRpkmrjCvbPAfdYFaCNaLfG8ribybz+fjM4BW
        hTLhDRFal7T8FAl3ffPfdFpb7vnVQB1sWb2U+Ajnqfo64hfNOPCeo6WqYSNfZxYgI592fS
        LBUz7Ghe5xPXgRfGx25BJgPzRhzh03TWcZ2urJXIZmeU109P0PCT9m7mvikFrcCJR4esor
        BY+IROz2U6ZUanEoRPIhNPv48T9/h4ifXEohDwzYT3wUdAxbIQhesK6BJCvqA0pw5gWtl5
        vKfVPKsNZ7bMuc7uvbJDvySv40QrktwNCCg9F1lmwoo0/vYwYwJ05wEurUH0Mw==
Date:   Tue, 20 Sep 2022 10:10:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <novikov@ispras.ru>,
        <vasilyev@ispras.ru>, <kirill.shilimanov@huawei.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: intel: Remove macro that is already
 defined in the core
Message-ID: <20220920101022.7bfa5304@xps-13>
In-Reply-To: <20220801025740.47191-1-tudor.ambarus@microchip.com>
References: <20220801025740.47191-1-tudor.ambarus@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

tudor.ambarus@microchip.com wrote on Mon, 1 Aug 2022 05:57:40 +0300:

> NAND_DATA_IFACE_CHECK_ONLY is already defined in
> include/linux/mtd/rawnand.h. The intel driver includes
> <linux/mtd/rawnand.h>, so remove the duplicate definition from the intel
> driver.
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/nand/raw/intel-nand-controller.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/n=
and/raw/intel-nand-controller.c
> index 7c1c80dae826..fbf6731420d6 100644
> --- a/drivers/mtd/nand/raw/intel-nand-controller.c
> +++ b/drivers/mtd/nand/raw/intel-nand-controller.c
> @@ -99,8 +99,6 @@
> =20
>  #define HSNAND_ECC_OFFSET	0x008
> =20
> -#define NAND_DATA_IFACE_CHECK_ONLY	-1
> -
>  #define MAX_CS	2
> =20
>  #define USEC_PER_SEC	1000000L

Actually I already received a series which contains a patch doing
exactly that. But thanks anyway :-)

Cheers,
Miqu=C3=A8l
