Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA9604BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiJSPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJSPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:36:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C744572B54
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:32:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9497361844
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D23CC433D6;
        Wed, 19 Oct 2022 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193412;
        bh=KbpFf17Fs8uesDt4MwO+iDiMglDae99et8YXveCfYBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LnOfM73EzfDc9csGyPs8AZcppDQrpgiFd1XhABH42Yy/zOgDPSxgQCzdcPhR40+un
         4Uqy7Detq9i1YMNUwRthH0GB5s9EEz7DfqS1xSjUh3nlj5LOLBNwgUHf8kr/+Zc70B
         s+y0fZWrrH8WVO0+ULO68efbdyRJxOFwL+NNgX3W4hF2gH4Xkz2ylRRKKGvT8rXvte
         zRXVetAVhXBKODkkJ4QvYxt6q8K0+P/IyZPYIo6AR9NmBfZWkp5Ae54Rkeyl9QJr+J
         yzfMZbzlzTkEm4E44Aw/i2i3k1hMMsQUVwBBVuV/ZU/GEuhWgZueiAhNtCb62pPvd+
         EPD7V/iZBpFoA==
Date:   Wed, 19 Oct 2022 16:30:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mika Westerberg <mika.westerberg@iki.fi>,
        Ryan Mallon <rmallon@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 05/17] ASoC: remove unused ep93xx files
Message-ID: <Y1AX/AkUwKFCOQ2T@sirena.org.uk>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fa40iDI1U45x1LDe"
Content-Disposition: inline
In-Reply-To: <20221019150410.3851944-5-arnd@kernel.org>
X-Cookie: There's no future in time travel.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fa40iDI1U45x1LDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 05:03:27PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> A couple of ep93xx board files were unused and got removed, so
> the corresponding ASoC support can also be removed.

Acked-by: Mark Brown <broonie@kernel.org>

--fa40iDI1U45x1LDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNQF/sACgkQJNaLcl1U
h9Cn1Qf/XqU894hIJIMkbghx6OOqUvxAGU4bdRqR5HCP6qB3XxFB6V7nbadpabwm
0JZqSHJpOn4oRlNmnD8kUI0U0PXZ1QfJhq0oPlBNCUU2ID03VKBDdD+wxkNRF//9
gboL6JJpVFI3XDOkmxZzFozUFF/56Y3HDF0aqdt+uX6zdCSTftJm5FjJVWHqEaD8
5EmijSrlvOsia0jVg9fTlucQKPYrdpBntDOy07jD0UZiA2NQjnoAhkOUBDcgQJar
dRB/gjX3t7zsf/Ycciz3i03IedU2nc26uvZJxEG39/I5GOn54DYhbundTyFmX4ka
z1CkIENotNYGRsaRsWX7HkhAve8sTA==
=4PhZ
-----END PGP SIGNATURE-----

--fa40iDI1U45x1LDe--
