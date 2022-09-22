Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EAF5E6193
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiIVLoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiIVLnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257DD9B84A;
        Thu, 22 Sep 2022 04:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B061762D10;
        Thu, 22 Sep 2022 11:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53630C433D7;
        Thu, 22 Sep 2022 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663846990;
        bh=Mt1LmaPy1kmdHUWpVIaEnQs3jZ8cHI0aSQlLWzzmn6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/vDVHh6CcVgYhTaXIubIoJmnHhH47qzbaDmu6X5ThWAYku/IosBbrHeMKtAK7x3K
         peS2ZrRVyPKten45dPEqXY4MpRJBKPVF1Q09bk4HNGtMgMrt6sWV4RhKQriINvCSpN
         gAVcAKxeNfbjeHlKEIImumAE7M2OzGtHnXZCCHej0zmS+NUj7L5DfUhLZ2BehrjdXd
         hDN0VtZyMvF0we7VWMvJ0Ez7P+W2YWBpmvoBqgfdsWKmpf3duwGUc95uFFmGg8LLVn
         TsLGrH2UnmM+Tq7rGXC9jZ4YxKr0FwEVwO7nFajtMXvJtGJgXyUkbQkM6te7kkcNKO
         7qQVF6r0OXozQ==
Date:   Thu, 22 Sep 2022 12:43:06 +0100
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
Message-ID: <YyxKSjMPlGPfegpJ@sirena.org.uk>
References: <20211008031953.339461-1-zhang.lyra@gmail.com>
 <20211008031953.339461-3-zhang.lyra@gmail.com>
 <YY5wPh0rwRvFjSRG@sirena.org.uk>
 <CAAfSe-uA3iowafC25zRqoTSaub1PbOzUvQgukLm=szEge_abvw@mail.gmail.com>
 <Yyw2nAAjN6NxmS09@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udX+hJO9s5cT5HSG"
Content-Disposition: inline
In-Reply-To: <Yyw2nAAjN6NxmS09@google.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udX+hJO9s5cT5HSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2022 at 11:19:08AM +0100, Lee Jones wrote:
> On Thu, 22 Sep 2022, Chunyan Zhang wrote:

> > I understand your point. But like I described previously [1], if we
> > still use the current solution (i.e. use devm_of_platform_populate()
> > to register MFD subdevices), a compatible string is required. I'm open
> > to switching to other solutions, do you have some suggestions?
>=20
> Many IPs encompassing multiple functions are described that way in
> DT.  I don't have the details for *this* device to hand, so my
> comments here aren't specific to this use-case, but describing each
> function individually does describe the H/W accurately, which is all
> DT calls for.

If people want to describe the individual regulators that'd be
less of an issue, it's mainly when you're nesting what's
effectively another MFD within a parent MFD that it's just noise
that's being added to the DT.

> Can you imagine describing an SoC, which can be considered as a huge
> MFD, with only a single node?

Honestly we should be arranging things so they're more like that,
at least using overlays for the internals of the SoC so you don't
have to rebuild the whole DT for updates to the SoC internals.

--udX+hJO9s5cT5HSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMsSkkACgkQJNaLcl1U
h9ADIgf/XyrCnfbvHQW+GuVjIQWh4YtsBqREfURkbTJq/thjgMK2mxMdQSZCgC5V
+eS59XsXPUaJlJTyfiY71s67Ebow79uicYK7OlSvc+fHJOBwo77E3b1a4dOl4wlJ
K2UY3K/kNhEz6kFDusdiOZHejTP2EJMZznojRfbFE+WcljCIj+1V9BhDTg1UkjxM
fHquLPs2O91UyDJdbjJ9K63UVgh2erco3aAsJDECltUezGHxE0qEa83pgZjABDFj
KUcHne6v8xRsbmNNNG/K1EgAyqhAlcdRkx2xpKhzpR7jSsVH4j/RHm8Zzat0cZAJ
jbDt2QBb4yMKHQwBiyo9actml29DwQ==
=xOVL
-----END PGP SIGNATURE-----

--udX+hJO9s5cT5HSG--
