Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF296D8129
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbjDEPKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbjDEPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E487EC6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6678C63790
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A877C433EF;
        Wed,  5 Apr 2023 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680707229;
        bh=5x6+lM5qQE/TjNOsAuBROgc7xHXIj/4JzKzX7mcvMLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKKCKsYirNS1p1VFRS1pzV+w2fep0cG0tdbIY0XGequJSBBQUrVpbUXrdHCCPaK08
         JRZjWHJznWFbmGrb0HkbSf+bgwFdlVeUgfxYi7WO7vXIRm5hJE59y469xVUM4KBk+9
         0APrM7EBEgbgdW61IAwE3KeZJl5ZqYr04O6Q71Zh4yPhy/GedB8pzQVV2tXkaeYsUf
         4sp1lsdmTnUpOBdP4ws9rXfTudwyX1WsSLx1ikNDyHUG7S/SPHXz30lohFUvUuVSUf
         ebqoVTH7sDxiD3I0j/DjMACPjyfs9b+gqT4EZquverW2xw77SalaCstR8ngZ0lPqXi
         27Nt7kFVVxJqQ==
Date:   Wed, 5 Apr 2023 16:07:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/3] regulator: axp20x: Add support for AXP313a
 variant
Message-ID: <f1d7526b-7f51-462d-8192-0a05828bfc4f@sirena.org.uk>
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-4-andre.przywara@arm.com>
 <20230405142103.GL8371@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s00eJ8nyCZjf3ylO"
Content-Disposition: inline
In-Reply-To: <20230405142103.GL8371@google.com>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s00eJ8nyCZjf3ylO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2023 at 03:21:03PM +0100, Lee Jones wrote:

> Is this on your radar?

> Can I take the other two patches without causing issues?

I'm waiting for the MFD.

--s00eJ8nyCZjf3ylO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtjpYACgkQJNaLcl1U
h9By4wf/dkxm0infGdmrULyFieQUeY2O4E8pBU3yywl1lq0PCFHXe6UwTz50KfvX
4GReUFZmaySaZ3SljDCKwpAAVwxTDN16Ao5iXw56dS3ZE8nySMUp0OBGRyzf+A/6
aj6Dfv/1b4t6OCa6nJ++nsalKN39XFk9bCiH9eA5R3gZkP1Gce3kPnmbClqHIe0k
+lT9g9+Oi+XJDqdeA56dYS1KFK7DBU/I3+IWjRmq6cZ2J5XftJTL35+zQN1PEOui
QzhktPbkuD8KU3nsksdrC46PO+3n/Twoe7dQGaP9eCY7AOf4O+OTvN74GEdG/Tco
yteeKi7WQwEMgMYF46+hJPFBH3beAQ==
=N3h1
-----END PGP SIGNATURE-----

--s00eJ8nyCZjf3ylO--
