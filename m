Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6874D817
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGJNrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjGJNrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB7EE;
        Mon, 10 Jul 2023 06:47:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E01660FEF;
        Mon, 10 Jul 2023 13:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA0AC433C7;
        Mon, 10 Jul 2023 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688996838;
        bh=dmsWbDbCxq7I7YdHJXMOaz6dJA5zHFyYjanNnHu/MWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJElcKlB7vn6NxqKkoVLHqKvy1/jeiNyQyHlA4CnGwaBog1lDXZGvUc9ouYVVvFzs
         Xf9vtxgmUuD6qsKZ/T0VZdhqdX26W2+P5sJ82ZjM+GH8bSxP+jRvuijqbvU8eAaiPl
         5busSWxvKd9j8XEKZMjWECTvWmAoob7dzbp7bwIktvNRAJUYTxYY9HzXn6YkmjqEWT
         cyb9NChXFbBYrs3Qb7OXbkR7L/6saxksKAGFsdHd7VOkE2bSlkRTEm4IZGarIBwiX8
         IRhsxWvFTomMUI6zfHP/m/CCsK/7+ZYv4x3BalsEn8Gmuy6HjFDUaUcBbgYDlUZ9lY
         poDPgYSw6Q+Ng==
Date:   Mon, 10 Jul 2023 14:47:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        mark.rutland@arm.com, amit.kachhap@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, joey.gouly@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.4 07/12] arm64: cpufeature: detect FEAT_HCX
Message-ID: <0404e7ef-8b1f-483c-a167-56140b29f0cc@sirena.org.uk>
References: <20230702195057.1787686-1-sashal@kernel.org>
 <20230702195057.1787686-7-sashal@kernel.org>
 <b37a9f79-97a8-4f74-a25c-b51128fbc9bb@sirena.org.uk>
 <ZKrKjS7sDFxhKoJT@sashalap>
 <ZKsi+UOdjlmDnhdj@finisterre.sirena.org.uk>
 <20230710094438.GD32673@willie-the-truck>
 <2023071024-unpaved-washed-4d7d@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Th5n2ohpaHHqRMVz"
Content-Disposition: inline
In-Reply-To: <2023071024-unpaved-washed-4d7d@gregkh>
X-Cookie: Do you have lysdexia?
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Th5n2ohpaHHqRMVz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 03:31:42PM +0200, Greg KH wrote:
> On Mon, Jul 10, 2023 at 10:44:38AM +0100, Will Deacon wrote:

> > Maybe we just need a commit hook that yells if something with a Fixes:
> > tag doesn't have a CC: stable on it?

> I could start doing that, it's going to be really noisy...

It would need to exclude commits that are only in -next since that's a
common legitimate use case for Fixes which shouldn't have a Cc to
stable, and there's going to be a bunch of false positives from people
who are overly enthusiastic in their use of fixes tags.

--Th5n2ohpaHHqRMVz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsC98ACgkQJNaLcl1U
h9BF1Af/cCi5hmvO9n2KllIAh5UMXC4SYeIlWw9/t9wDNGprRl6WPnNbgUIkrQvE
KKKjIcIJIma+RPr/JwJh1uiigHly5QPLGg+1FF0ZZnEBbqfAsqZy4flOecYT561d
8bQNUXfmx6AEXppBIJAo1IAGAYWeOV/XIB6VGe+mAaRK3TUUn+hCh7XfiUcOizSn
IJUNoLgGUnNjOM46/0KDrhGmpI3LaDxpR3e/eNP2DIQE/yabxzQyqkpYzyK/ErxI
0G/8MXXXghlU8kRMUId25DyMIJMEhP0LDYwsrLhQ5XitkZqkEPFEBQiznhR9TNC1
bYhqIab8KxZfmoUiRjnYtdlrHGadJQ==
=DB7X
-----END PGP SIGNATURE-----

--Th5n2ohpaHHqRMVz--
