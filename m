Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0315F6F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiJFUlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJFUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:41:22 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F517E808
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:41:12 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5BF3B5C00BA;
        Thu,  6 Oct 2022 16:40:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 06 Oct 2022 16:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1665088850; x=1665175250; bh=de59dSNQPp
        7lYzDS7scAquZbLIpMTBkfanJfxPS4kG8=; b=cQRy2TO3+9hXOKUKMRVrXIDBbc
        yrk4Ydbu7zfxCehfhP/ofFZvZ4Hsx6o8QEZmiWH9KaZI00b82T0liEUNE05FPFAt
        uMq0Z3+BP9f0RIvmOad6PGR7MIeZV2i+2eJDWX2+Kz7C4hXYcvOQ60pXfhJRwrU9
        LsGK/fLDkQPM71v5eqVjIYFlUnmwSio24zjx/ipgxI9n+ixwAmqgXLhNEbjkjmY6
        V4t8PgS/QDKORUGl59Bn/MaX3qaon/uu+vCzpO4Xu9xCgRTT296kR1qWgZgEhYGq
        afWO5oVwyiC5CiosoO7W0DEk34U77q7wEl/tQaLkOgdjt+HF6kEljAKNKx+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1665088850; x=1665175250; bh=de59dSNQPp7lYzDS7scAquZbLIpM
        TBkfanJfxPS4kG8=; b=VTuTJJ8CKhVA1uFRqwkHT82E+Ha9Ib2fHfkqFIEO0ydV
        Rr+dHHQ4ctRuh+BD1Tt4cksvKL4QiEbqcXS9rgftHey5iZ0Mx58zK+esYQN0pbWf
        8Lq+54c84SnB3kB16WfOm6ZuKVQIpG+lKpLtnllXYrZV90Vb/TN14iK4bLwGmL7K
        PteYxYy3rYom3Z34E47+2YsB4fYOfgJkxgiWnpsnL2zjTd29ji8wP64zY+fGNz+M
        BiuiHyCbbcu+BHvsHpvfDiyaoBvYeXOILrc8Kk2oe3vWURgT/PCQi1NYj7KKBep9
        e1c3ZR0U2an9bQUO2eHRAC5xFmpCvHutX4m+sgUMUw==
X-ME-Sender: <xms:UT0_Y8WpjKSrGH3yeYdFN569T-SCD78DGHWyyhWzEhXiAQYOewlEoA>
    <xme:UT0_Ywlj_Q-sku_GbT3B7kQr6_aNp7sc9b3bLKT1JFjbxDEHuMUPTacopiZ20wnik
    ZdLHzPKsIJy11J4C3A>
X-ME-Received: <xmr:UT0_YwaZiYerCBwjRJSAM5TN0sHMIZ5FiQ95ql-ZfZIvaIOgn-XupDefpcXk6JIVULAe_IzdCK46vaycr71XsStl9EivpXVv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreer
    tddtvdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkh
    esshhtfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepheefjeehfedtjeeivdefkeff
    heeludekudelleffkefgtdeludelvddtgedtheeknecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:UT0_Y7X3fN_5Zukbr9ECB6xbRRgHbSPucxdHlRrE2OaNG6F6xLueNg>
    <xmx:UT0_Y2na4fvqPhjwFtdDGMTKMM_X3NHEV-PLhJfRHeTWi_PlXge1gg>
    <xmx:UT0_YwfxFhH3-akInXPFZvR1U4a-J0Bf9YkytUadfm0qPdutEh8tAQ>
    <xmx:Uj0_Y_fYB6BYUt_gsDWoVAztIPI4GCvCGqDhqTLRLNt0CNrYAJM-ng>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Oct 2022 16:40:49 -0400 (EDT)
Date:   Thu, 6 Oct 2022 15:40:48 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Michael Walle <michael@walle.cc>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        ~sircmpwn/email-test-drive@lists.sr.ht, garnermic@fb.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for w25q01jv-im
Message-ID: <Yz89UJsFJBMaTxuy@heinlein>
References: <20221006070841.2106194-1-Delphine_CC_Chiu@Wiwynn.com>
 <0dde4fa6ddeefa23314dbdcd1dd1b28b@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pjTEFctmrz8zr3LU"
Content-Disposition: inline
In-Reply-To: <0dde4fa6ddeefa23314dbdcd1dd1b28b@walle.cc>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pjTEFctmrz8zr3LU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 06, 2022 at 01:52:33PM +0200, Michael Walle wrote:
> Hi,
>=20
> Am 2022-10-06 09:08, schrieb Delphine CC Chiu:
> > Add support for winbond w25q01jv-im chip.
> >=20
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
> > ---
> >  drivers/mtd/spi-nor/winbond.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/mtd/spi-nor/winbond.c=20
> > b/drivers/mtd/spi-nor/winbond.c
> > index ffaa24055259..2b02b05ceb0a 100644
> > --- a/drivers/mtd/spi-nor/winbond.c
> > +++ b/drivers/mtd/spi-nor/winbond.c
> > @@ -139,6 +139,9 @@ static const struct flash_info winbond_nor_parts[]=
=20
> > =3D {
> >  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
> >  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> >  			      SPI_NOR_QUAD_READ) },
> > +	{ "w25q01jv-im", INFO(0xef7021, 0, 64 * 1024, 2048)
>=20
> The name should be w25q01jvm.
>=20
> > +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> > +			      SPI_NOR_QUAD_READ) },
>=20
> That flash should support SFDP, so please try the following:
> +	{ "w25q01jvm", INFO(0xef7021, 0, 0, 0) PARSE_SFDP },

It seems like QEMU doesn't support SFDP yet.  Is using PARSE_SFDP a hard
requirement or can we delay until the QEMU support can be written?

--=20
Patrick Williams

--pjTEFctmrz8zr3LU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmM/PU4ACgkQqwNHzC0A
wRmpJw/+Np3IEKkaJrHkeGBaf2O57oTxLMumWGxDCWV/tu3k6J9K6k7T5opE6zBA
DHkPs7pnvSsZoGHXQYo179cNsSfX1qgOIBPiLAo0PyI0CgW73GSWt3kRlafJv38l
bb9j/vr+uXb8+k62npuX+9iM04gcRU4geAj9gVYnMHmVkUr9Ma/33vGHrkfM3sLk
c3OHdZG+cvsVTRJiatoSyrHm+S+yvkMVH7Ztw8z9WTH4/ANi26CsggapMUYANc8T
5Aa7Jtbasx2I7xTboNkioKe4Ah9O4EmwKoohChuK9mwlFI1zBFltzjjVVOkc0gfm
pMzsmz9PQriatqEAB4je+SHd4WSoDs3t3iKWReFx2rOAjUM8CRZATqAtWrv/1HUL
K/4T6wXMgLLrMU5t3bIyncHS30KiFpq76ZRq6MNicf0De1C+HBoJjSWlBSlvJ8VN
dXCBhIvzpc3nq62Mab1lWwyTn5ggTD8ZHXjr24lg2E5i44NMUMACrv/Br5osOihH
QqDmY0hAAIyggxMR90f799lsVfL4iVtovwKXi7Ud+2z1OlPZiJ2vX6Q8udxvXVVP
tIgWHecZ9d1/ZLLGoipYzGxYgoR+9EI1vYGhTJt+EvAWyG6DAs1bS3XThASli6j7
yVetrfPHlLT8rYMYvqXOd0TH12YoINOZnOs9qrn7qxkWtWxKX8o=
=f5UJ
-----END PGP SIGNATURE-----

--pjTEFctmrz8zr3LU--
