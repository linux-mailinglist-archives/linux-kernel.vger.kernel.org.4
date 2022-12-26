Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B465B656608
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 00:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiLZXbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 18:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLZXbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 18:31:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CA930D;
        Mon, 26 Dec 2022 15:31:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95CFCB80DFD;
        Mon, 26 Dec 2022 23:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5401BC433F0;
        Mon, 26 Dec 2022 23:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672097459;
        bh=pG/b8YqAZy2+dIgH80FlNz0kMyNrFX5NfBgX9nTD5DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hj2RAAOXRTk0O27Pv4w/4+Nq1b5fDlb88dilrsu7URWmIt9UN7USZOkKygo+hNboh
         k9KxrZEr9Fcoy6EFIl+rK3LxegXSmODZToXapNVMhjAwPvmC1A3T3VFcpCZ8rWnkbd
         Jy3qasHluBaWsdpqGmFWlqYViHd5sg7b+ihrGh229YnZbyp57qOaDiUtzp7tXwvNpA
         vLXhqBoOeve7a0DCnMwqgMdj5P+O5IiZXJUuTcyiC8yQEAiYi4jfcr8nM9P0nczH36
         T9YAlXUNMPmTy5bWvJ8yAoR2e99NixR5dYs3GSl0z+QBFxuD6HI7NBnAd+4tKUMFoQ
         943G2shFPVqPQ==
Date:   Mon, 26 Dec 2022 23:30:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Tremblay <vincent@vtremblay.dev>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spidev: Add Silicon Labs EM3581 device compatible
Message-ID: <Y6ourhGlvHYX9IYq@sirena.org.uk>
References: <20221224041825.171345-1-vincent@vtremblay.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e1jb2CH64A2hGG9p"
Content-Disposition: inline
In-Reply-To: <20221224041825.171345-1-vincent@vtremblay.dev>
X-Cookie: Noone ever built a statue to a critic.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e1jb2CH64A2hGG9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 23, 2022 at 11:18:25PM -0500, Vincent Tremblay wrote:
> Add compatible string for Silicon Labs EM3581 device.

Even trivial bindings should be documented - this should be added to
some binding somewhere, trivial-devices.yaml should be fine.

--e1jb2CH64A2hGG9p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOqLq4ACgkQJNaLcl1U
h9BSIwf9HAxhNbDZgrGHpYznZ6bLuIkMzvKHzuFTmgxhkMgVavpK5z44moR+Kl6t
LDT4wsPlWumNLPd9vum71+nf/GIaiFrDey9mGMrNjOlrRtBKkMoUSTbBS6tnb123
ZSbcO4MiaSjRi4HsaAYHZNPGzxCwd4lPKMzYDFt4DL1+3z613nveCPcLz26szzuT
YU9l/hgsFSvpmF/rUTye9MpD28ismzi8JokH0Ish9rrjLUAk9AhWbUtPS2gxLMz1
v+ShxP69TdzQd1zN8h3ZRH6TCMvyBIp+b4cPGq8qS++jXZDelY7x8+RnmcRgJj/d
yA4L9qq7vZtlVz6EaMJ/wWItkZOeiw==
=/Wfd
-----END PGP SIGNATURE-----

--e1jb2CH64A2hGG9p--
