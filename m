Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103146C32B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCUNW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjCUNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:22:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F071524BFA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:22:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 952AAB8169B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9C3C433EF;
        Tue, 21 Mar 2023 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679404931;
        bh=6nQmTXWR0S5yZAO/vh9jjHZ8e6HnzfqVY7IbBOcHD98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IogLwT033y5KY0sEFYrePVyrpD/N7OIvRDlrC1p1hfhU5OympYUhOIxEjPufXraKm
         4uaW4oOp+iHIM/DapN1B5HEmFbzIFjmFMdD29Q0B0gX1BaaVqtvAG8dE7qARlNLMo9
         XNG4c84zR+JBic2jq8DtdWDyTVuoetX0c35821RLP4UhBE8sF7vmmREfkdk6Y4qbIZ
         QEB/VY96BlWHnz4SbUdk97TZ6IoV0GSw44yxItISmOGId/Hitq9Eym29EnJFoS5O8S
         Kb5j44ouix6KCCasa5HvkvSvY9opaFER5fcr1qC9KFnqbnuA5YlcGLSSVU9tKuYJFK
         +SyIPYTHna8tw==
Date:   Tue, 21 Mar 2023 13:22:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shenghao Ding <13916275206@139.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com
Subject: Re: [PATCH v5] ASoC: tas2781: Add tas2781 driver
Message-ID: <e9134abb-5caa-45aa-b623-e1ceb40223d1@sirena.org.uk>
References: <20230321113130.25853-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0KwVVK9qwawOe9aF"
Content-Disposition: inline
In-Reply-To: <20230321113130.25853-1-13916275206@139.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0KwVVK9qwawOe9aF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 07:31:30PM +0800, Shenghao Ding wrote:
> Create tas2781 driver.
>=20
> Signed-off-by: Shenghao Ding <13916275206@139.com>

Not looked at the code properly yet but as previously noted you are
adding a new DT binding so you need to send a patch documenting that
binding along with the driver.

--0KwVVK9qwawOe9aF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQZr3wACgkQJNaLcl1U
h9A6Cgf/dONTG2ih8NwPlAV46YcR7SHyEM6ke3V0bNPQrib8DgEyj9w86A4dskHF
2EpQaQOVpGTgjS6pYH2srs2i30iV7yYLb+a1rSCt/QzBzJL0bolEskKXCHCqk/+L
+yMBi/zXMpIZtXaBZ9LWFt+7s07/CaaBtrxam4yMs8gM/YACW6RRZXIjCXX90Rc5
zkXIkHHxN01RZlcXf8sWqpeB8hn71MdWr0bKzlBCk8/xs7ygKffLmB9PyYASoepZ
S1E6uxk83SBXDaf5xFEwxD3cHucGrretW8yvy06vdYfrvTEKsac6afts/TWDtHmJ
VFRyjEqZHbMQZgBaQaaLm3nIdsGVKw==
=30hx
-----END PGP SIGNATURE-----

--0KwVVK9qwawOe9aF--
