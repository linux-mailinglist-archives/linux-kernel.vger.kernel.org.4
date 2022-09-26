Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC75EA9F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiIZPOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiIZPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:13:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145B7D7A2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:56:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1B674CE108C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1CCC433C1;
        Mon, 26 Sep 2022 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664200559;
        bh=p34+2qpnfD6AreGBPpZ0cE46lXrx78KqMzqC+jEEjdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jR7ZS6dbh2uraofF+LAgQi+c/dUTDQ3RlIdrcVrOZqg+QLsWSWWW7wSAAOgnb+UdQ
         80n4FzWi92qPRqELJpV2OP484mx6NjO3NDihipxDikYWZsWaBn5kTyMIMP81AzKfBi
         AHpaK+Fe6B45JBQsJ9HFTPSRIc1xn7qJO55dESCvKhiiYHioMfNqwTbKtjvDPsY7uG
         V/g29zrizYAvjS9Vf1pHP1ELl+YrZ0zYMzPmxWzcDyD1/baEJjuLbeiRQXeSx6lXYn
         YUYBAf7I+LExU7HC5ZqsxVyBZrEeTT/relTjvI5O7VJz7t6SapSP1CINwpL3LCQnuM
         9M/9ko/9ptDTw==
Date:   Mon, 26 Sep 2022 14:55:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Andrew Lunn <andrew@lunn.ch>,
        Marcin Wojtas <mw@semihalf.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: kirkwood: enable Kirkwood driver for Armada 38x
 platforms
Message-ID: <YzGvalDnGujC2sl/@sirena.org.uk>
References: <20220920132648.2008-2-pali@kernel.org>
 <20220926110533.13475-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xsFjxfmwLuMLzuRF"
Content-Disposition: inline
In-Reply-To: <20220926110533.13475-1-pali@kernel.org>
X-Cookie: You may be recognized soon.  Hide.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xsFjxfmwLuMLzuRF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 01:05:33PM +0200, Pali Roh=E1r wrote:
> From: Marcin Wojtas <mw@semihalf.com>
>=20
> The audio unit of Marvell Armada38x SoC is similar to the ones comprised =
by
> other Marvell SoCs (Kirkwood, Dove and Armada 370). Therefore KW audio
> driver can be used to support it and this commit adds new compatible stri=
ng
> to identify Armada 38x variant.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--xsFjxfmwLuMLzuRF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMxr2kACgkQJNaLcl1U
h9CRcAf+JuTBZSz2V4JDBCSszUuJCyQMdD3hD7e5kqxtIa5AXxBUh7Igj8pir59o
l2qbKnF9wPzk1X75wKhUipR9Jgj+id7QmtUfnQEazqBG9ZXtz65FRmPzNh3bLowF
nZPe/HCZdrShy2+/5F+QF8ZfdBHRXp7XaVD5xOnH3c5AHydMHcz4jYmxiGJLuVC9
TEbQPZTZomM2qCK0ajEvTIqUJzi+83z7qMsqOea/g/di54uh9NXIM0lxMAsan7ZM
mRsWFHAyE5jUip9e/CRmZ8UZ2A73vGKL6RfqposWOyJwpyGv4aOO37ltWItrOxOb
Y+7fXQtzDwTOUhTFpQcteixI7Cyo6g==
=d5D/
-----END PGP SIGNATURE-----

--xsFjxfmwLuMLzuRF--
