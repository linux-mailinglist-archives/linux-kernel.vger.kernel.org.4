Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8C36EA9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjDUMDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDUMCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:02:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D213A92
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B049663FED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4496C433EF;
        Fri, 21 Apr 2023 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682078567;
        bh=9g7jXvL+Vk47LSrV14mlLXjQs3XKeQ/P9UgGKL9znfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpQC20DmBLpdhqFSEYzNCGc/0weTtAAFu0CsTGNl1PxfqsuMR1vpyU/lBI+ht2I4O
         Jk/2Y/RpB8bgwQTl6lbKMUVZBT02mZYCS5eB+8ME8b0E9gBRBTV9d9BKeDrK/Pslo4
         hebhtaMK7fThVUH8Z7lx76uPi6tA8i985B1Ty0dsVFsWC671OAlP3ycMDVl94TMjUF
         BHnmdxt8MiuNj5baFNXw9XX7lwkGoh/xYUeszuhgQD8/6WArLtM4Mp+t4HOxEnlTfA
         U1juAk4GtLxisZnsLcNkie7KA9P0VXRHhfDlKmtIu9vrGgFV6/4Ot5WqDA8bO/BP4j
         12XFbVnAPW0uA==
Date:   Fri, 21 Apr 2023 13:02:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regulator: pca9450: Fix BUCK2 enable_mask
Message-ID: <228edf87-c4bc-4525-8f18-74e1638cea16@sirena.org.uk>
References: <20230310092857.3555187-1-alexander.stein@ew.tq-group.com>
 <1848012.tdWV9SEqCh@steina-w>
 <7e44e0e2-b67c-96b4-3e8d-036650180201@kontron.de>
 <3900361.irdbgypaU6@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3PYb3eT5MBw9/7wk"
Content-Disposition: inline
In-Reply-To: <3900361.irdbgypaU6@steina-w>
X-Cookie: Hailing frequencies open, Captain.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3PYb3eT5MBw9/7wk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 21, 2023 at 01:57:01PM +0200, Alexander Stein wrote:

> Could some of the maintainers make a call here, how to address the origin=
al=20
> author where the change is taken from? Note: It is not cherry-picked, but=
 only=20
> some hunks are taken.

I don't particularly care so long as everyone involved who should be
getting credit is reasonably happy.

--3PYb3eT5MBw9/7wk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRCe2EACgkQJNaLcl1U
h9DLTAf7BJ83hWL+uz42hvUA26053oJOaB8yYmuNYKTMOqIfL6cmssKH9MIdP04o
OT2Bcg+49+a45pCwMSnfufkGSG0DF5JK/vET8tYGB1beHLlCLiDqlE9YnwvIgANL
haGGygxLP4i00KsiTo6BGgSpgaizchBALi3ItUKBxfhg0VVtY5pMail0xPCu2G4q
6xDCboVEeUti0j8ItieE71qOAoIwJ8W7rwKBQ0daTUYtT492vEnNg11seYYKgBGg
0CuT9Ce27aWK+WQ8euq8AD8Cf5m6b3v2JyP/eh8Itutfags+mAwnYMpnDpdabOb2
Fwr+7eT+G4roMkShhk6TrN2rehIkQA==
=4Off
-----END PGP SIGNATURE-----

--3PYb3eT5MBw9/7wk--
