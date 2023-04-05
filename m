Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338E36D8621
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbjDESir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjDESip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:38:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1E36A4E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8700B627F7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8497DC433D2;
        Wed,  5 Apr 2023 18:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680719921;
        bh=Plk+eHzKUO7XGS0vNsSKUKGT9kZ3xSq0tiKaF75pX+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okPEC2PdLZvNMWDZ3fLWjD+X++uC3xbaMyU+S5EnleKBbj4U6cXTSODjM/Ylbkt99
         /rDGnaukisIccX8lTJzFHh0u5+kfthNDQgNTJ2VA4SofmzCGGPHCOAXedqmRq+Ak/7
         7HUbx2gqh5YNp4G3am+3OHpA2MXNfNu9I+4OGEPVR2mHH71hWLa3CTB8A1Dq/nKImD
         4ONioFAqEWmgvqRnh+l65zS9WPHPEDL3ygCThRjr8lnMGi0xIs31SDCbyLWEXEp8hc
         7f5en9mQHcV0E4vrkSK/YxnmhQH+uqhpLXaELKVgZ+UVp9iXzFH747KKMqUXFEnIRs
         d63cukxJIxZdQ==
Date:   Wed, 5 Apr 2023 19:38:36 +0100
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
Message-ID: <601dd4c7-0940-498b-815e-99e570e732d2@sirena.org.uk>
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-4-andre.przywara@arm.com>
 <20230405142103.GL8371@google.com>
 <f1d7526b-7f51-462d-8192-0a05828bfc4f@sirena.org.uk>
 <20230405153651.GS8371@google.com>
 <e86dd4a9-540a-461f-a78a-5acb480e98b9@sirena.org.uk>
 <20230405163906.GT8371@google.com>
 <185fbb80-7fa3-4c88-9f96-92894370a3aa@sirena.org.uk>
 <20230405180340.GV8371@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dFXWKpFjmqoxgdDx"
Content-Disposition: inline
In-Reply-To: <20230405180340.GV8371@google.com>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dFXWKpFjmqoxgdDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2023 at 07:03:40PM +0100, Lee Jones wrote:
> On Wed, 05 Apr 2023, Mark Brown wrote:
> > On Wed, Apr 05, 2023 at 05:39:06PM +0100, Lee Jones wrote:

> > > I can't do anything without an Ack from you or some indication that you
> > > want me to apply the first 2 patches and share an IB.

> > Yes, please apply and share a branch like you usually do.

> I usually encompass the other subsystem's patches in the IB too.

> To enable me to do that, I need an Ack from you.

So not apply the first two patches and share a branch like you said
above...  TBH these serieses would probably be a bit more legible if
the branch were created with just the MFD patches, that'd also mean
smaller cross merges.

--dFXWKpFjmqoxgdDx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtwCsACgkQJNaLcl1U
h9C9Fwf/Qt5h+o5pfvxtQJEyBb3Na7YBcHUBvcSUfXIUkt1Hc6Wie3HJBzSpiNSR
wYvLYSHQm9XmSaMdOEGg/eIFNa2dQq1A/7gKD8HGp4eXrCK1Pf422jB7kdDcMtwI
9NMjlJleNEdIATfasDarUfylsehtTXwjlUKLXO2Qlgj6wh6SgBsmbd+D7avhL5qm
Z7CnhSVZ7RkxBRrtKHiHTXmXiUuRPSDaxPk6xHDwDgyg4jize/1RfVW8Rr7tp2uj
cuI1L/uKZzyvQE6N90g+u0KsCdui29jlkgCtDn0jZCSIrbEYhqNvZ+tnH0ojShLM
013Ab/7VbFmsV5xhI2V/jpXWapUCqg==
=PVfP
-----END PGP SIGNATURE-----

--dFXWKpFjmqoxgdDx--
