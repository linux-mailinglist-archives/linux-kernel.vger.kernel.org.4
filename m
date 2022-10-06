Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975EC5F7185
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiJFXEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiJFXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:04:16 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E68D4E400
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:04:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9338C5C006C;
        Thu,  6 Oct 2022 19:04:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 06 Oct 2022 19:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1665097453; x=1665183853; bh=14xYdWrGRp
        hAh90L8qat5pXsjxjsYqhYpzu3bbkUsnM=; b=HKAMQz4CtOxH+ypTe490dK93jn
        XYyDwYwqxwF8F/ZlakRq/arVwbQdBj4wf9SnGEL9Tr/NdjL32u+AsTBb6iMIxkHt
        53CXxxSrvfC7do5J5Q3MwIzOH1Hp0iFhkrrPqEfkVSQWfEuq7p/9MuaoQjxtRK67
        gndrLrhdjuSXvglBZAYEKSb17+yR0r/gRmvejU7TppOtlb/Zd2WwVqcJCLlhEMyo
        GRVB8+2ZwK19RpgZkX3bnAyueM3d6B2+Ks0o3BGuQcFgOrj3LW6FP8DTiT2hjB8J
        kP+dGN2CWyti+tk0rgpxZgETry4ISA1K9U18sB1oeoxQAs3WbzYXY/70Mzcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1665097453; x=1665183853; bh=14xYdWrGRphAh90L8qat5pXsjxjs
        YqhYpzu3bbkUsnM=; b=U3Z9Ivl59s7hGtVNon48rTBwzefpvBC3vz8uNDZ4RC2d
        Qly3t4jyx0AiX8BEV+bYnLO7Jh8ZeXEnTOk3dyclB0F1mm7+I5y0AyrLTcUpGlIR
        OLanxgJzrx+6+o7srsZIyJ08AtRPrePdh4d6j1P6Xv5UXNCp+2H2O4qMTp2GY+39
        rR7Jr/5lRE2fx7SrwGf0VsACV7pDraxe6x110gRvFnx7arUDJ3BdN7It1aAo8UOa
        kx3nB/FelTsU83UzlFZNFDDqZhL36cEl+07wH+5XslDZh5gov+/WrZj559dK1Qca
        pBh8eDiXIJSAklelfjlw0Tahh/0XILTl2CtKnOUPow==
X-ME-Sender: <xms:7F4_YwpZ3Qx-NglWUjqMlxNEjlrCF29QGhWVlgHhtSbY6qiWHnVcaQ>
    <xme:7F4_Y2oBbGHQkDAD5VXGjUxH07FQ6pe9GoRes3BoSmkZ3pnIz0ZFI43RFPjMGTwnO
    Xs8DCwsv3nMZZrAAZI>
X-ME-Received: <xmr:7F4_Y1MuWrWlGaUlQtMLamhAGEfK445h1R8bEK4ia1jKjCeerdrcGJ25_iCMdf7xgFlvFUbPx3Y5K1o3okklAdTo4ROETrUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:7F4_Y363azDz3Z6e6xWzIUMbDkCn2DCzknRlsKxK5ID16rzbyQUh7w>
    <xmx:7F4_Y_4YJA0rGdbQwTPcNSKMIW7FGnAAmCZqpsaYsCcbIThgVnE43A>
    <xmx:7F4_Y3h04dW3H1vjT4xkW6y8ySLv4vGuMto1qbmO9KMdSKtRY67v-w>
    <xmx:7V4_Y8zm2sHOsba32r-g6J1ZwFOhxaFfJ_JZ5kuJLEnrO2m0QSkZcQ>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Oct 2022 19:04:12 -0400 (EDT)
Date:   Thu, 6 Oct 2022 18:04:11 -0500
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
Message-ID: <Yz9e6x+3nvJMUCgF@heinlein>
References: <20221006070841.2106194-1-Delphine_CC_Chiu@Wiwynn.com>
 <0dde4fa6ddeefa23314dbdcd1dd1b28b@walle.cc>
 <Yz89UJsFJBMaTxuy@heinlein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QFYV+iri/JDIrPel"
Content-Disposition: inline
In-Reply-To: <Yz89UJsFJBMaTxuy@heinlein>
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


--QFYV+iri/JDIrPel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 06, 2022 at 03:40:48PM -0500, Patrick Williams wrote:
> On Thu, Oct 06, 2022 at 01:52:33PM +0200, Michael Walle wrote:
> > Hi,
> >=20
> > Am 2022-10-06 09:08, schrieb Delphine CC Chiu:
> > > Add support for winbond w25q01jv-im chip.
> > >=20
> > > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
> > > ---
> > >  drivers/mtd/spi-nor/winbond.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/drivers/mtd/spi-nor/winbond.c=20
> > > b/drivers/mtd/spi-nor/winbond.c
> > > index ffaa24055259..2b02b05ceb0a 100644
> > > --- a/drivers/mtd/spi-nor/winbond.c
> > > +++ b/drivers/mtd/spi-nor/winbond.c
> > > @@ -139,6 +139,9 @@ static const struct flash_info winbond_nor_parts[=
]=20
> > > =3D {
> > >  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
> > >  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> > >  			      SPI_NOR_QUAD_READ) },
> > > +	{ "w25q01jv-im", INFO(0xef7021, 0, 64 * 1024, 2048)
> >=20
> > The name should be w25q01jvm.
> >=20
> > > +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> > > +			      SPI_NOR_QUAD_READ) },
> >=20
> > That flash should support SFDP, so please try the following:
> > +	{ "w25q01jvm", INFO(0xef7021, 0, 0, 0) PARSE_SFDP },
>=20
> It seems like QEMU doesn't support SFDP yet.  Is using PARSE_SFDP a hard
> requirement or can we delay until the QEMU support can be written?

It turns out that there is some tentative support in QEMU for giving
SFDP information now.  I've sent a patch building on top of that for the
w25q01jvq chip and updated Potin's patch-set to v4 that I mentioned
elsewhere in this thread.

It looks like the w25q01jvq I pointed to in Potin's patch-set and the
w25q01jvm being proposed here are slightly different chips.

--=20
Patrick Williams

--QFYV+iri/JDIrPel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmM/XukACgkQqwNHzC0A
wRkoQA//Z5uGIe+1YPNJV2xianP3UkgF0nc4Npy9LdsWZ52m+yuoGTBgLGvPcC7Y
p2pdkLeyMCdRXO5RG52QXf7r7GYsmD/qUgw/1ZCjfC591qN4Fkt6fuO87pa6CFU3
ZZ2T6Ai/kWlbNkvEoMu6p9qx5W90g/IqzrFQn5AQ0M/vq4o0PPkVcUj8KsiM/Vrl
k7FO5zoiy1yED7Q/BdafkvNhiMK2eu0ytKc9c8maHXEi/G1V64xmC9nN3Oe7fofh
QBr810X1w6OC01zB4gD3i8l935hllGMomggX2CDFmKsBq9Oo6iwCLyekm9WwgRnP
XuZLHMe8ohkGo+BdjLsfFKq4Mfw4WrV83DqfRiv1oiwdDZrBxVTYE2dlgk307/nA
VvtWxedXDYzYekc9AdZxv6kSIKbHEOHzmPJgLgCgipXJfs22q540WOd7171vcWkp
xR+Qx/dntR+8xXe5aIn08g4xfHVx6c2lEykHIo4hk4pbqp8JxyuXYo1mpNLvmhRK
Q0DLIoiITxgNWvgAB9Ek8xT+VTD0JCNMdUF+qAMFCs/u9NOASM6ZuRqMLfR6i3av
y7OmCk5Kj68T0F1jxgq40szm+P0M/c8qb2nL3QAjIptZ36GqEaZOdj7Y4jPUCoQ3
KqHPhpz4BJE+hpKpX3itNZf7uBc12yd4+Estzx68U1pMZwcWrnA=
=k89/
-----END PGP SIGNATURE-----

--QFYV+iri/JDIrPel--
