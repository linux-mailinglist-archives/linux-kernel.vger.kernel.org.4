Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4241065EF0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjAEOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjAEOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:44:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58821EC71;
        Thu,  5 Jan 2023 06:44:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 983C2B81ABD;
        Thu,  5 Jan 2023 14:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5F6C433EF;
        Thu,  5 Jan 2023 14:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672929841;
        bh=8ZYhdVRy8WTVHS/NoM8xkMFQn94wh2mTKmVziKYic6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SniGlC6u9PAO1XLhI2b1NgyEF0owZ7BkskObnUPs+iBROk829MqRWaDX7JBYy/If/
         vsSOn0dGEiqx5GWj5xp31Av0bcuh9hbRTt4CxpeB4N84OO8O42Vc5ilGrnPkTGogZn
         gz7GZr7lggMnZ+/pL/ptE7ta1xUO1XeYOzVxI3+/oni62cNd4HdVs/3ziNxQIGNVS1
         IIro0CDLeT/vJLYz6wEODl49i9rINQ4Axg0dRqi+h+RhJl/QEgwyTGiRVsTeQx2KNf
         Nbw/xa3bB1jFsH2h5502kGpmRmGsL3rsfJ3UW5few9LedkYynLMAH9Vp/x++rA8FVG
         z6PowD1qA7+Zw==
Date:   Thu, 5 Jan 2023 14:43:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] spi: spidev: fix a race condition when accessing
 spidev->spi
Message-ID: <Y7biLYFDEhQ0Kq/L@sirena.org.uk>
References: <20230105124100.185542-1-brgl@bgdev.pl>
 <Y7bWCm/hpK4pbI6W@sirena.org.uk>
 <CAMRc=MdwdKKEx0DZ6xJvYRu3qbvUPD-J1RbQ6b0uMkP_JU=5bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n4BhMqwu6f98V8Zh"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdwdKKEx0DZ6xJvYRu3qbvUPD-J1RbQ6b0uMkP_JU=5bQ@mail.gmail.com>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n4BhMqwu6f98V8Zh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2023 at 03:30:47PM +0100, Bartosz Golaszewski wrote:
> On Thu, Jan 5, 2023 at 2:52 PM Mark Brown <broonie@kernel.org> wrote:

> > I'm not sure this is important or useful, there's not a lot that can
> > practically happen concurrently when we get to actually interacting with
> > the device and it's making the code a bit less clear.

> You suggest to just use a mutex instead?

Yeah.

--n4BhMqwu6f98V8Zh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO24iwACgkQJNaLcl1U
h9CgeAf9FwNE0tTNxDPFxb1YbeTCYDD8ZrtsudyYXk92AFR47bK2RqD1h/02WzEI
Cht4HMpDti4S9tpPruamEcG3BH039CjvUJLwSt2eFNoq6nXiQ/fslfoAKfY8ou51
Qoun3L4TsjSboj3PHqqVXvgE9fchVOGVcmcN6qmQ7HMMU7wrI/7bYrBGqHgLmdMP
Cda7p/sCBIfCTufOAjupRTSY0jXTHi1Py26YN1EyfvvS0kvBe928tLTllj3ANC7H
w1ci5DDsL/jR+MdFgaOOp83wYbzDS7vpz8hC3BNoLT1hqldUGixsJp4al9qAwQ0i
spZOUzvx/6MCwXASGH3oyDZTa+/EHw==
=Fm+C
-----END PGP SIGNATURE-----

--n4BhMqwu6f98V8Zh--
