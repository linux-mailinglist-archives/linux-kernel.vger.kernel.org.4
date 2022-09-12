Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BF75B5581
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiILHqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiILHq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:46:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5263F5;
        Mon, 12 Sep 2022 00:46:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQzDy1snRz4xFt;
        Mon, 12 Sep 2022 17:46:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662968787;
        bh=2SsaEEsOuBsDzoqGxUU4foG/ybmcBiUyUnzznMmODz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jvbu2dRb78KP0o0CSZTO230juQFTGyMUYIALP0Tg2aj3UjXlv0vkfj/BY/ID8dNXF
         BlXBC/TPxVi7KI0qnhc9HCvhdcgEEkoX+KecXYbfryGIY+A92QisOKRRE+3zMOC0yL
         4cWFTT2cjKh4bsgSmrpvbkzCCJHQK+qDRQ68wb1s5s0USg1kSRBqI/Dsu1joIgFvDM
         iSo2y7/cby06NxtNosqTT1JdxFymAVTfzVdBNr+gFMVTqdESk+cNQ7qmgMP9sRr2uG
         gfZWPgNYE7RwRsc3wr26WqeOItOextxQbqd9C7w5eiejIaqckayNQalLj7lxW0iuLb
         gjpFbxflTep2Q==
Date:   Mon, 12 Sep 2022 17:46:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: manual merge of the battery tree with the i2c tree
Message-ID: <20220912174623.3a7f52b8@canb.auug.org.au>
In-Reply-To: <20220912073455.rlqf6q4rsgydk46h@pengutronix.de>
References: <20220912130344.2e635cd5@canb.auug.org.au>
        <20220912073455.rlqf6q4rsgydk46h@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aFXYWG+6ol6wJTyv8iqOQrb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aFXYWG+6ol6wJTyv8iqOQrb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Mon, 12 Sep 2022 09:34:55 +0200 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@p=
engutronix.de> wrote:
>
> On Mon, Sep 12, 2022 at 01:03:44PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the battery tree got a conflict in:
> >=20
> >   drivers/power/supply/cw2015_battery.c
> >=20
> > between commit:
> >=20
> >   ed5c2f5fd10d ("i2c: Make remove callback return void")
> >=20
> > from the i2c tree and commit:
> >=20
> >   ed5c2f5fd10d ("i2c: Make remove callback return void")
> >=20
> > from the battery tree. =20
>=20
> The commit from the battery tree is
>=20
> 	0cb172a4918e ("power: supply: cw2015: Use device managed API to simplify=
 the code")

Yes, sorry, cut and paste fail :-(

> > I fixed it up (the latter removed the code modified by the former, so
> > I just did that) =20
>=20
> I don't see today's tag in git yet, but removing the code sounds right.

Good, and, yeah, I am still going :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/aFXYWG+6ol6wJTyv8iqOQrb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMe488ACgkQAVBC80lX
0GzumQf+J7mlovl2QFZlxw6ve0sWPSgrgnKR7q6MNJGXUNx7f7L89wLYTCnmXM/Y
Bq8/PD6PMm8cCkYL0mmLwRoGeWY3gh3pguSKITx2AAWGMhqImV0CiQefxL46+QRd
wBKmhQdOAUPwVoRz1IiVIqt+0MSYWRyvG9jtDAOf9iCOo5LqA4s8S1LxwxXmKvSF
IHxOIIvs1Jz8V71Avv1kiQ335IshYxrxwbDbWUQ6uSHB42QmKBOQTIUoCMSddNvf
YT9ueRnIjwspsx2XvabuTuoT60Anid8RfZTQ+HnJ38PcezXoIrTAilECu+D42QuU
AHDyyaTKkZP182mQckUGKQl1XEAyAg==
=AYdd
-----END PGP SIGNATURE-----

--Sig_/aFXYWG+6ol6wJTyv8iqOQrb--
