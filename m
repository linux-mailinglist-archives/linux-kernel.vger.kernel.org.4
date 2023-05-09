Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0698F6FCDBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjEISYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjEISYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:24:46 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A6E4E;
        Tue,  9 May 2023 11:24:45 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0E95A1C0CA9; Tue,  9 May 2023 20:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1683656683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qean7PXv8GuL/wPy75uYkndbiFmbJgeIOaj5KDpqYAY=;
        b=NeynZHrAWG/R+5wpZXCrtXLdK6ycC7g6PVX9Kuo9pvNFOVgQe85sbyf4s4Ns7Z+PxgrSsk
        FHmnMmZL0T/tAHn5AVAd3W33pqbSCy1Pcw7HkLCBGyadt7IbpEkY/CaEKx7WFTmeyR8z/C
        pFDnWJf4kyPvatTTWzh6r/RzjIRpVtM=
Date:   Tue, 9 May 2023 20:24:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lee Jones <lee@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Make LEDS_TI_LMU_COMMON invisible
Message-ID: <ZFqP6tZrVdbmKkds@duo.ucw.cz>
References: <91f6efaa48c36320e58b6a312025ae9b39ee206b.1683644796.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rON4OQBqwST31RDu"
Content-Disposition: inline
In-Reply-To: <91f6efaa48c36320e58b6a312025ae9b39ee206b.1683644796.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rON4OQBqwST31RDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2023-05-09 17:07:47, Geert Uytterhoeven wrote:
> Currently, LEDS_LM3697 and LEDS_LM36274 depend on LEDS_TI_LMU_COMMON,
> which contains the common code to support TI LMU devices.  This means
> the user is asked about the common code first, followed by the
> individual drivers, if their dependencies are met.
>=20
> Simplify this, and reduce the number of questions by making
> LEDS_TI_LMU_COMMON invisible, and letting it be selected when needed.
>=20
> Fixes: 3fce8e1eb9945c27 ("leds: TI LMU: Add common code for TI LMU
devices")

Lets not do fixes tag. This is not "serious enough" for stable.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Pavel Machek <pavel@ucw.cz>

Best regards,
							Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--rON4OQBqwST31RDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZFqP6gAKCRAw5/Bqldv6
8txiAJjICF/+GBr80/bRpqBpNlW64NCvAJ9cE2bSF2SE1mgsHggXetcQk7z8Cg==
=Iwf6
-----END PGP SIGNATURE-----

--rON4OQBqwST31RDu--
