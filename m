Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68E1722605
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjFEMg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjFEMgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:36:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C171FE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B99C62366
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E10AC433EF;
        Mon,  5 Jun 2023 12:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685968568;
        bh=nZwzWRbUjtqgCZKGkZzJhbXU6JBV9oEBXx/wRWmja3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2vsIhX5F81Ujo6EeaYCPq8RmI+7s8v4vdBWO/p5/mwrP4DbenDCN4n3UeFMzcWhF
         x1qGuVv0lsCvA6r1piu+ptenxMe5Euprreh3W45XSRbyBKlYCubDHAICnabbsbRape
         OpV84JRCeDNRXMexIdTPvsGntZ9Gojc7ieB9fkLiVBLYO7MHHefXNOsZaRIXq0fgdy
         LzjUYQAQwHrG35BIcHB++YYkizXFA60TdLlGWxS7AMf70oVszdusxekMvI8dBoDwQM
         9xaMDML4JT2cDSChL4IpI3FhQIQWYe3XBleFmliA6MgS4BqIDUvJ98yB+WprarhbPc
         nC9VFMxIiOjPQ==
Date:   Mon, 5 Jun 2023 13:36:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG
Message-ID: <bfc2b94f-f030-4236-8370-143a8e4d0faf@sirena.org.uk>
References: <20230602124447.863476-1-arnd@kernel.org>
 <1108b836-38bf-4284-b3b9-82cb33509092@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UCIP91/GiG2xL0T0"
Content-Disposition: inline
In-Reply-To: <1108b836-38bf-4284-b3b9-82cb33509092@app.fastmail.com>
X-Cookie: Biggest security gap -- an open mouth.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UCIP91/GiG2xL0T0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 05, 2023 at 10:58:25AM +0200, Arnd Bergmann wrote:

> Please disregard, this version was incomplete, and I ran into the
> same issue again in another randconfig build.

> v2 coming up, please use that instead.

I already applied this one before I saw your message...

--UCIP91/GiG2xL0T0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR91rIACgkQJNaLcl1U
h9Avbwf/QeHTGVBCinNkmwT7kGX/3+fYCa5y3duDBpjzzQKB0cEl4P2ESNdw+asK
dseIyssXPHu3SqepXeD0ndpYgUqWZLaTIAYWpxGGoT8+xpimgNEdnfmLyvXwQRCz
EDZCF1T8mM37jeK4FILPORaVOJgnkAGy/Ifk/vMJid1r6iDDMPXJigUHwF9fz3Hl
cpdax9PvX+5ZtITuwiU+JdipRHuoV5FJooERUriTDkbnVT/tgA/ggvTHv9gtQfue
CG9GrX0zSVFmfAt+rvi45VoJk38u8qEoDkvtUTWsdTdyI42CLZ1QljHrHKcjaR4Q
+/N/NaQDbVdrKYf8SUwimAMoARuauw==
=b+tY
-----END PGP SIGNATURE-----

--UCIP91/GiG2xL0T0--
