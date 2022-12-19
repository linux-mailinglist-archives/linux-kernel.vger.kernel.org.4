Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05469650E31
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiLSPBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiLSPBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:01:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3661B655F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:01:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8B460FDF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F88C433D2;
        Mon, 19 Dec 2022 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671462096;
        bh=fQl1soAH+o/N3eRgAlLaFBBRGKmW0pCblygzAUxFLhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RuF7hpTGX6ovJF1sDqwgwDqlX+NbPx03E0AlfdEpQnD1CC6DONwyiX0yVBHHfX1A+
         Ybc/kDFaL7J9Sn/F1a5Ygr7pxVzGibqWKwTT163pbYSwhr0gCFvAbZC1BV2ZfMetgS
         hHa1D6lR79/h6do8DW49tp3oNUChL1oj9Io9VURkXhcX1f+SuJh/vKXORVNv7S27L2
         Bf3m9YPAn+zixdMXR4HUk7L9vnTXp7uh6nFZnlva1iZJ/vl2axero30DaCCWOWtpu6
         JFnk1+juW9TTx4TZaYGAKxhpLqysiE1QxDd4gq9fdLsL17C8ioLaBjWd3HLY2sBG3X
         hkgqyzaRCCuIg==
Date:   Mon, 19 Dec 2022 15:01:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 2/7] arm64/sysreg: Add CCSIDR2_EL1
Message-ID: <Y6B8yQxR3wP6VUbW@sirena.org.uk>
References: <20221218051412.384657-1-akihiko.odaki@daynix.com>
 <20221218051412.384657-3-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bs4hCqutwxbx+i3f"
Content-Disposition: inline
In-Reply-To: <20221218051412.384657-3-akihiko.odaki@daynix.com>
X-Cookie: I brake for chezlogs!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bs4hCqutwxbx+i3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 18, 2022 at 02:14:07PM +0900, Akihiko Odaki wrote:
> CCSIDR2_EL1 was added with FEAT_CCIDX.
>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Mark Brown <broonie@kernel.org>

This matches DDI0487I.a.

--bs4hCqutwxbx+i3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgfMgACgkQJNaLcl1U
h9BkKAf+NPos2o6mLgjoG89mZgkmPOF4TShAObGH5JrXHGyhZnj53UB6vh9JI5tX
6uz/oVmHC1btr/6CqnoISLk/Rt7cd4gjgZ8DScJ9ZZV3tIzgbPxIvE4ONDMT9h9O
Diy71bwou0xCYa1fURWOyeIt3T6yn5AiZsnqvf0v9nDZlcTG2h7lJBnnxTB4z+L0
yGXYWtl968mWkyTDQ4sgYbaumdP6x/iDwNLAGEo7f/g0Pzpxd+ODSaykBrFBhTV5
2zHafaqPrR0Ty9eke3BLDlWYLcIPK5WfNq/+WoG2vxWuzhVy6yEEDZL/AGGyI1DL
Rrt+To8Eqxx7xA9zDDg48XIODFIzdg==
=iHBD
-----END PGP SIGNATURE-----

--bs4hCqutwxbx+i3f--
