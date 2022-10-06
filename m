Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787585F6365
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiJFJPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiJFJPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:15:43 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4E4C620
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:15:39 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 346BB240002;
        Thu,  6 Oct 2022 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665047737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=APsvoPiMqcgjCyLTp/wGIQOIyM81IZBQevZbMqq+Di8=;
        b=IQIM17DyCVjN4QeDnWr1ZxFxkJhFQggIouff0aDO/EKaVmhpD0ELpPj1L/dRkNSEOJtrzJ
        A1U1zEXCTv9nQkQj65UmYWrRj/IxOX1aNGsondJ+NW79i8ItHiqBh/3uEn77zJwrphIms7
        Xf+yK1jVNA+BQztZI56f7fmqUJFKdkgKRY7yQnpDcsJRNrPM7Hvcwf3pE8yrTkDrwYkC1Q
        k+lALc+pTtYYjrPsNFDFRkoYy57YVLXMBQaOJ28pxPJlD2KKKQRmhQF+mo7qP7bubh7K/V
        WttSbm4vEzwCO6iFyVEexQdEZwUixv+hCBL4SjKFIMYnA1FFKm/RK9/wKAfLZw==
Date:   Thu, 6 Oct 2022 11:15:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: Delete commented printk and add some space for
 required
Message-ID: <20221006111536.2c285116@xps-13>
In-Reply-To: <20221006090419.1635-1-wangdeming@inspur.com>
References: <20221006090419.1635-1-wangdeming@inspur.com>
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

wangdeming@inspur.com wrote on Thu, 6 Oct 2022 05:04:19 -0400:

> Delete commented printk for NFTL_findwriteunit and
>=20
> NFTL_makefreeblock. Add required space for the variable blockofs

I would rather not delete these comments because they are very old and
I believe were debugging lines in the past. I hope we will never have
to dig into this driver anymore but if we have to, I would suggest to
use debug printk's instead.

Also, if you want to clean up a bit the driver, you can go a little bit
further and address eg. all whitespace issues.

> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  drivers/mtd/nftlcore.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/drivers/mtd/nftlcore.c b/drivers/mtd/nftlcore.c
> index 64d319e959b2..e3c17ed4c219 100644
> --- a/drivers/mtd/nftlcore.c
> +++ b/drivers/mtd/nftlcore.c
> @@ -486,7 +486,6 @@ static u16 NFTL_makefreeblock( struct NFTLrecord *nft=
l , unsigned pendingblock)
> =20
>  		while (EUN <=3D nftl->lastEUN) {
>  			thislen++;
> -			//printk("VUC %d reaches len %d with EUN %d\n", chain, thislen, EUN);
>  			EUN =3D nftl->ReplUnitTable[EUN] & 0x7fff;
>  			if (thislen > 0xff00) {
>  				printk("Endless loop in Virtual Chain %d: Unit %x\n",
> @@ -501,7 +500,6 @@ static u16 NFTL_makefreeblock( struct NFTLrecord *nft=
l , unsigned pendingblock)
>  		}
> =20
>  		if (thislen > ChainLength) {
> -			//printk("New longest chain is %d with length %d\n", chain, thislen);
>  			ChainLength =3D thislen;
>  			LongestChain =3D chain;
>  		}
> @@ -525,7 +523,7 @@ static inline u16 NFTL_findwriteunit(struct NFTLrecor=
d *nftl, unsigned block)
>  	u16 thisVUC =3D block / (nftl->EraseSize / 512);
>  	struct mtd_info *mtd =3D nftl->mbd.mtd;
>  	unsigned int writeEUN;
> -	unsigned long blockofs =3D (block * 512) & (nftl->EraseSize -1);
> +	unsigned long blockofs =3D (block * 512) & (nftl->EraseSize - 1);
>  	size_t retlen;
>  	int silly, silly2 =3D 3;
>  	struct nftl_oob oob;
> @@ -592,10 +590,6 @@ static inline u16 NFTL_findwriteunit(struct NFTLreco=
rd *nftl, unsigned block)
>  			   a chain to make room.
>  			*/
> =20
> -			/* First remember the start of this chain */
> -			//u16 startEUN =3D nftl->EUNtable[thisVUC];
> -
> -			//printk("Write to VirtualUnitChain %d, calling makefreeblock()\n", t=
hisVUC);
>  			writeEUN =3D NFTL_makefreeblock(nftl, BLOCK_NIL);
> =20
>  			if (writeEUN =3D=3D BLOCK_NIL) {
> @@ -618,7 +612,6 @@ static inline u16 NFTL_findwriteunit(struct NFTLrecor=
d *nftl, unsigned block)
>  				printk(KERN_WARNING "Cannot make free space.\n");
>  				return BLOCK_NIL;
>  			}
> -			//printk("Restarting scan\n");
>  			continue;
>  		}
> =20


Thanks,
Miqu=C3=A8l
