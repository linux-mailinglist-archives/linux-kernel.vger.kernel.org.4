Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596E6E9799
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjDTOvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjDTOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:51:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489961B9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48EF4617BD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 14:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A57C433EF;
        Thu, 20 Apr 2023 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682002244;
        bh=8ro4HOuoHKad2p1pLuPfohLj+SGCxJrxBqFXzofKVMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlpfVo4eVUrJzszrPKY7xlaDUY+8O7XmS00j4VkvH81EoFf0uFbD9oUpEya7O+Eev
         jmnWDA+6VskBO15i4ZxGyPRMFUF2eseMQ0y2FSn+4tgwEr2p19skaEF0+4J3Jx41xI
         WnsH2dt5e7QZi7YRRn9dRxacfr8zyJVsNiR6tIfPRoYwkZ5SNrU8iOcxMmKz+2zola
         eJi6+0aNxpR/tY8uW2RQ1yPsMug0pFe+rVFbckGtuvWKUco42BBkhCJcyaGeBLIAD+
         fevfFwvuc1D5sd/9nn86GE/mTkGQhbIZOz8X22I7UDFfj0UTyt2Qlq0HyaZOVuynRs
         obIriwS22v5Lg==
Date:   Thu, 20 Apr 2023 15:50:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     mazziesaccount@gmail.com, DLG-Adam.Ward.opensource@dm.renesas.com,
        benjamin.bara@skidata.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH RFC 1/2] regulator: introduce regulator monitoring
 constraints
Message-ID: <4aa88f7c-f1ea-4ab7-a806-3214c541ce7d@sirena.org.uk>
References: <ad59933d-714f-6444-b835-ecd9791934aa@gmail.com>
 <20230420142924.541206-1-bbara93@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1vZu9hFgYh1yYYUg"
Content-Disposition: inline
In-Reply-To: <20230420142924.541206-1-bbara93@gmail.com>
X-Cookie: Above all else -- sky.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1vZu9hFgYh1yYYUg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2023 at 04:29:24PM +0200, Benjamin Bara wrote:
> On Thu, 20 Apr 2023 at 13:33, Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> > It would also allow drivers to add delays to the function(s)
> > re-enabling of monitors when needed - at least the bd718x7 had to wait
> > for new voltage to stabilize prior re-enabling the monitors.

> Also not 100% sure about this one, but I think these cases could be
> covered by a mandatory regulator-*-ramp-delay, when necessary?

If the voltage is out of spec there should be a ramp delay anyway, yes.

--1vZu9hFgYh1yYYUg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRBUT8ACgkQJNaLcl1U
h9CcCwf9HviZFzDikAHYCb+Le47Er1KbeOhEXQzOFb11HIKMn/zTJs+5Sp8MGq63
iR1odxX6KcSIrCHjTzzvAr82Ffa/UY74+Dpsd3fjE2camH+9DlwF0kUB2kzThmjB
l2I5W5UL0Z5GH6Yy8+qOKJbaCdJGM9zJ2hLz/Yu9lEXzuKtHjPsH8eA+rHj2X6jy
Q8VHvqHyyIBMl84Rp3/5qyRLzpVtXF7nJrv5Q6vramyT0oM5sN5W9kQcJX2/GVVE
VpGspVH8zQcu6NYY6hC9gqhw8UcUem9OQJgL2r6fe+4CAZQfIhAeynzk7tlyjJoQ
h6uBTrqAqKJHLmuw5HmXWaPls8dnUQ==
=Tvss
-----END PGP SIGNATURE-----

--1vZu9hFgYh1yYYUg--
