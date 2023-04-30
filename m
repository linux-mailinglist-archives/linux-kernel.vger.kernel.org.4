Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699796F297F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjD3QZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjD3QZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 12:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0607E1992
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 09:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BFB660AB1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 16:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDFCC433EF;
        Sun, 30 Apr 2023 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682871924;
        bh=V2tgsxOxTfmZcvRZyi6ynmgrf/tIIQz5o5snoPZmHO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohiSAAgMfDAtFcx9SK192wPjh/7XHrSN79xa92ySMS7s2DLmuZmbHI+Jkj476cGoc
         1A+qIU0Ini9+ni1jZoTzJHyEmIjacVKZxEkCuUgTWtHQYq29cXXYQhgAkmYj5/xsxb
         aQe5wPQp1vI+yTeOJm8F499YWhjkrxkXvMvqJMiR5gq5530vUJerAzWTUxSFGyFyJj
         z2CjhGFbqyJl0+f80/FyDVF56TPLZnCeTnAMZtmNdUc2R9U8d3FPyRBM4Cz7RMzwKG
         CjVvnhMvGnTlg1awNM2qS+j0pzUI7wYtxAHTSXTGLcayqQHxdAvW6Mrwzom+sUxXZi
         1BT2oml3WvHPw==
Date:   Mon, 1 May 2023 01:25:22 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Shenghao Ding <13916275206@139.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com
Subject: Re: [PATCH v1] ASoC: tas2781: Add tas2781 driver lib to support
 common operation for both ASoC codec driver and HDA codec driver
Message-ID: <ZE6WcuZQH+5sla8n@finisterre.sirena.org.uk>
References: <20230429032302.5257-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DQ1ay+ysaRLSTEhG"
Content-Disposition: inline
In-Reply-To: <20230429032302.5257-1-13916275206@139.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DQ1ay+ysaRLSTEhG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 29, 2023 at 11:23:02AM +0800, Shenghao Ding wrote:
> Create tas2781 driver lib.
>=20
> Signed-off-by: Shenghao Ding <13916275206@139.com>

As previously and repatedly advised new DT bindings need to documented,
you should be sending the bindings and driver together as a patch
series.  Look at how other drivers that add bindings are submitted.

--DQ1ay+ysaRLSTEhG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmROlnEACgkQJNaLcl1U
h9A8Sgf/ZDYUOEkE+LN5WUMzOqBBnA8RCiUkP5OFE3sF5ssY270K+NMw8RFws/g4
OfQL58Wy7OYcXgWeqvemzybMavRT/pvJ80EptPsy5fnd8fP28c71Fs7TXSJBU+to
bvXDBSpHQOUFyuI22Ckk67KeSZDQO2AGJqwYp0hoZdRkenbOXtTRzV9tmVdDWev+
vQpmqGdZ6fRQA3kU/eXRaIq0evBxAXxSzJ54h2YiDOpo01cOiwzWcpGPgtB4QFXX
5MLYXK7ISSS+DSvF6BFG52zexdKdycTlbSG51Uyd4ynaXTCJCDiUOsS/OB9OMFpq
xoo4sdi6mo301RNil5YnxIi3KQ1lng==
=Cbb4
-----END PGP SIGNATURE-----

--DQ1ay+ysaRLSTEhG--
