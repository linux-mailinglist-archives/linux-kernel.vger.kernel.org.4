Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC705BD1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiISQFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiISQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:04:53 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD4664EF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:03:53 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DF6E760010;
        Mon, 19 Sep 2022 16:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663603431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CnOoRxmwYhSpaB0jR89REFkLchcSk/gvAm6USd9rNko=;
        b=YH1pjxhfXejKy3Spd45V9Eb0rqxArJQZnFqKKmDDdivcCH4kdD+3UJCeWNHKDu5V5XOaMC
        VUC5Ni/f76dbiRswmCfphgd80tLZPyYCCLDcjUgIcSu96J8rxiewOcQWxBw+Ru9/l6Iquf
        s6v5PE3LwbVrm4E+zqNHe7gPsH3H5dIk/Y6guLGVbqoAyxUSlDpcNwhmYWs8AQ5EQVHdZ3
        bMTLZlF0l8QEuFyOrfs3S4+pDp1LHp6zw0PKQSxPqS2Gjx7zW8ZgAGgxy+ksecrctI2SK8
        P7rArPjwClH6hl/RixXuex+9KHPpMEqnJUFEvlM83WmRDXv36xB946IC4l3+QQ==
Date:   Mon, 19 Sep 2022 18:03:49 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: Fix spelling typo in comment
Message-ID: <20220919180349.6af1befb@xps-13>
In-Reply-To: <20220906134204.4119-1-wangdeming@inspur.com>
References: <20220906134204.4119-1-wangdeming@inspur.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deming,

wangdeming@inspur.com wrote on Tue, 6 Sep 2022 09:42:04 -0400:

> Modify the maxiumum to maximum
>=20
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/m=
td/nand/raw/bcm47xxnflash/ops_bcm4706.c
> index 8bb17c5a66c3..276c529014d5 100644
> --- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
> +++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
> @@ -14,7 +14,8 @@
>  #include <linux/bcma/bcma.h>
> =20
>  /* Broadcom uses 1'000'000 but it seems to be too many. Tests on WNDR450=
0 has
> - * shown ~1000 retries as maxiumum. */
> + * shown ~1000 retries as maximum.
> + */
>  #define NFLASH_READY_RETRIES		10000
> =20
>  #define NFLASH_SECTOR_SIZE		512
>=20
> base-commit: 840126e36e8ff272cb63158646433fa1324533d9

Thanks for the patch but there is an identical commit received one day
before.

Thanks,
Miqu=C3=A8l
