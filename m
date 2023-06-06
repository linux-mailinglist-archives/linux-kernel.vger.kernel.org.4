Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20463724353
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjFFM4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbjFFM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:56:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5C310FB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAB4963263
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B9BC433D2;
        Tue,  6 Jun 2023 12:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686056166;
        bh=2srvcTQauMXy5Q3j/RaWQ6wod7y2ZW4r+xbDOiID5bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWUhUQGd5yrXxdMgefzra4TtCk/UUbi9pFkLcLu/fj3HO/psKt3DdUQDQP03pJq1s
         WREkWSdE9iqyNaSR2cJ+kI5f2brpEmUdGfd+TCWY7Vo0IEv911aymIHZySwsn15cuS
         Dd/kP0+RZJ5edvvTZAOd9s55zthmm8w5uh1Bk63b2UTMQ7fa1nIsZYrY9YDkzuLPBy
         4VtjNWOkK8jNxQYwuF+ar/VmDE6u7FKFxr83ND7EJHTGFK0tgB7jgge6zE9xBkKnYS
         i/tROeS7xGCL5zzAYiHN/bMaK0HbuOtVJq5/AI12MF3HVkiMu2m9KN76quVZ89hD8t
         eWLOiP5DLgy1w==
Date:   Tue, 6 Jun 2023 13:56:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: act8945a: rely on hardware for operating
 mode
Message-ID: <8fecb30c-a42a-4cf2-8ad7-6795149c2d29@sirena.org.uk>
References: <20230605104830.68552-1-raagjadav@gmail.com>
 <04b8fa24-e5a8-4871-a397-f1c0c886449a@sirena.org.uk>
 <20230605143103.GA3068@pc>
 <545d3463-ce56-41d5-9d95-55764c448c09@sirena.org.uk>
 <20230605161614.GA6548@pc>
 <42423085-2c9c-47f6-9588-3e2260da7cfa@sirena.org.uk>
 <20230606070007.GA4691@pc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fuHrU8yFPMu7b9nu"
Content-Disposition: inline
In-Reply-To: <20230606070007.GA4691@pc>
X-Cookie: Keep out of the sunlight.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fuHrU8yFPMu7b9nu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 06, 2023 at 12:30:07PM +0530, Raag Jadav wrote:
> On Mon, Jun 05, 2023 at 05:30:36PM +0100, Mark Brown wrote:

> > If we have those then we've got a bigger problem, for example we might
> > switch to a lower power mode which can't support the load we're trying
> > to get the consumer to run.

> Yes, but in such cases it will atleast report whatever mode currently
> set in the hardware and not the incorrect one stored locally in the memory,
> and this way I think we have a better chance of finding out that
> there indeed is a problem.

If this is a concern you should add something that verifies that the
mode hasn't changed underneath the driver, this won't actually detect
any corruption - it just might silently fix it.

--fuHrU8yFPMu7b9nu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR/LOEACgkQJNaLcl1U
h9By6wf/UAf816pXODyf69JrmhF+3TMa9gCdZxkn651HdSpPYdf0r6Jo4AQkSMB+
LgVMyRI4VcnPRgWv196BX8ydZO43DWiJ3RHh8Dw6dIsq/G32wIiS6CnXayaeBtxe
1HerFTUIVZic7ITpXzlMqK4oibbBWXaB56RfxUVRTpPE3JfnBYrmiPUQt2p5iQLW
akfqOlUHW3uHUTeZiOy0NM86p6ajuZY5K7aloE68Ss3XbdZ+I7R8VNEBCuJuAbAw
LRbU4TT774YLrafN1zNwhIB5bSx53UbiMreLSNcsMHcT2HPvro00oM+a48fBIQbx
Xqkt+PetPLIX07oTqvGlAWJu2NRlQg==
=CCzN
-----END PGP SIGNATURE-----

--fuHrU8yFPMu7b9nu--
