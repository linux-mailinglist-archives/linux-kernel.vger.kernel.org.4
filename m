Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDDC5EE31A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiI1R1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiI1R1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:27:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA56E4D89;
        Wed, 28 Sep 2022 10:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B6B1B8216E;
        Wed, 28 Sep 2022 17:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B70C433D6;
        Wed, 28 Sep 2022 17:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664386039;
        bh=GH1UskgjZIUPQJb+x9CDmOVXsZCej5rWpjjvE5I/zpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAu5P64TFUrxKs3oC0J1oqmHOxwrUwzSAZ69obhwH9w2crmKuKqukX4gmzItsVpVl
         gQYZf/VK7IT4SwAWcqa7UtrnOhgUbL8cVJG40t0o0EFjoqPi1u1HjFwfO9PiaEFKL5
         vQguSJBRPOuW4d9P3JJKfPiP544zil80jqw9mUGmYE4lgc/+xquFIcnY4mRjFWMXkj
         xjMJK0DQ4bBmta8zAzYYZe4OK2fqpUwUxcslwemiQpWdLOPiDTRR12OnbMxFdP68h0
         nMtWEyl+tQ93sua2+M3CgyVAGNzoC1Gd/Eeuah8bgwxsVTuV809kC0bzB0K9iezokH
         TGFElxsq77pdg==
Date:   Wed, 28 Sep 2022 18:27:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: regulator: Add bindings for Unisoc's
 SC2730 regulator
Message-ID: <YzSD8cQrFpIWunls@sirena.org.uk>
References: <20211008031953.339461-1-zhang.lyra@gmail.com>
 <20211008031953.339461-3-zhang.lyra@gmail.com>
 <YY5wPh0rwRvFjSRG@sirena.org.uk>
 <CAAfSe-uA3iowafC25zRqoTSaub1PbOzUvQgukLm=szEge_abvw@mail.gmail.com>
 <Yyw2nAAjN6NxmS09@google.com>
 <YyxKSjMPlGPfegpJ@sirena.org.uk>
 <YzFNvByGG7ADWfmd@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a+ETSZRf0TrB1BfO"
Content-Disposition: inline
In-Reply-To: <YzFNvByGG7ADWfmd@google.com>
X-Cookie: You look tired.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a+ETSZRf0TrB1BfO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 26, 2022 at 07:59:08AM +0100, Lee Jones wrote:
> On Thu, 22 Sep 2022, Mark Brown wrote:

> > If people want to describe the individual regulators that'd be
> > less of an issue, it's mainly when you're nesting what's
> > effectively another MFD within a parent MFD that it's just noise
> > that's being added to the DT.

> As I say, I haven't studied this use-case.

> These comments were designed to be more generic.

> What do you mean by nested MFDs?

Given that individual regulators tend to be separate physical IPs in the
chip if you create a single device tree node that lumps them together
you still need to also represent the individual regulators as well so
that collection is functioning like a MFD does except not on a chip
boundary.

> > > Can you imagine describing an SoC, which can be considered as a huge
> > > MFD, with only a single node?

> > Honestly we should be arranging things so they're more like that,
> > at least using overlays for the internals of the SoC so you don't
> > have to rebuild the whole DT for updates to the SoC internals.

> Right, there would be one device root node.  However each function;
> clock providers, regulator controllers, PWMs, GPIOs, networking
> (various), reset, watchdog, etc would have their own nodes.  Rather
> than attempting to describe everything in the parent's node.

We don't split things up by function, we split them up by IP - we don't
just allocate a compatible for all the networking related functionality
simply because there's a networking subsystem in Linux for example.

--a+ETSZRf0TrB1BfO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM0g/AACgkQJNaLcl1U
h9CUCAf/Q6E+WKiJ2KGknP5+06b4wxdfhbz+BpVH7gWrCq9iry5COPHP2d/vtR0D
PywhTxxFTjxjL9AHcyxMpkrT7Vp2bHkQD1gdsRehHDgNbTAFMR0G2D8VU3MpxKPO
d79P2y8PGARmVuITXGEOMpentnHb+tWYOzNCGKfpjzG8MWsukT0qVYPu9KKpI1d9
2AwAmGy8axUtSUA5atMYN37HDtyB1aP5FaXPmY14MGr/QtifBpt/dNcEduZDxf50
x1E4t6NIr2ratmhawivwudR6ModSXw4AyTYXgcsXuZvDnofhDyTEE44WrExgqbS+
S0h8CtCK7sscoqwfNPXPcxEla76H/Q==
=GLRW
-----END PGP SIGNATURE-----

--a+ETSZRf0TrB1BfO--
