Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6C7262AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbjFGOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjFGOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:21:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABCD1BCA;
        Wed,  7 Jun 2023 07:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B62C163FF0;
        Wed,  7 Jun 2023 14:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC328C433EF;
        Wed,  7 Jun 2023 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686147709;
        bh=C8jieTFPTbsf9bXiIj2WuYDozebdE9lj2pgU/0k568M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHUCVX66HBImmMVu/k8/R3nf3ivqv4Men24IaG+b6dqTcXzEbPs7Qoc3etA3z6XPr
         /wG+y2KMH0bc/LFm3qXqESSGD4geXZjkVj8LPQCLpdWIlRIO8yvgLq7vSf8hnRbklZ
         p0MRpUPlVTwwvbbYm9d+aMqdSVU5z4dFMcfJCWKpFVyhS3Bzd0iHYL8t624Cz2O8L/
         wnEb6uqZAD/ktqNwjbRX6f16hrDMJkplo/BJz7WYi+m8/8JtA1s5SZ/Oqh/FHiA3L6
         kucXSC5NOAgzqe8BJvlzODUZs+Nlk9q2odEwl3bXYaSKeQHvJr7knDsqc2bIeiAQrl
         sTCoAiixF7xmw==
Date:   Wed, 7 Jun 2023 15:21:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
Message-ID: <8416d36f-ae13-43c0-8267-e86ef3c8a75a@sirena.org.uk>
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
 <628b7411-7d12-4915-80c8-cabb74ac6590@sirena.org.uk>
 <CACRpkdYhFmG-Cb-5+dt1Huktnm+tkOjSGO5ZFPjGeOXRott6Dw@mail.gmail.com>
 <a1a1bf95-6333-40a8-9f08-4c952cd070df@sirena.org.uk>
 <6a0abd6bba2f8f940e695dfa9fd0c5f8ee19064f.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WJwu/n+x+jLcVhiw"
Content-Disposition: inline
In-Reply-To: <6a0abd6bba2f8f940e695dfa9fd0c5f8ee19064f.camel@ew.tq-group.com>
X-Cookie: Keep away from edge.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WJwu/n+x+jLcVhiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 07, 2023 at 02:55:31PM +0200, Matthias Schiffer wrote:

> It is not clear to me what alternative options we currently have if we
> want a setting to be effective from the very beginning, before
> userspace is running. Of course adding a cmdline option would work, but
> that seems worse than having it in the DT in every possible way.

Is it *really* that important that this be configured before userspace
is running?  With an initramfs you'd be able to do configuration before
even trying to mount filesystems if your primary storage is flash.  I'd
not expect the pre-userspace period to be under particular pressure
here.

Frankly I don't see the command line as being particularly worse here,
it's more tasteful and if you're doing some device specific
configuration it doesn't seem to make much difference.  Userspace looks
even better though.

> Requiring such tuning for specific drivers or driver instances is
> however a common issue for embedded systems, which is why we are seeing
> (and occasionally writing) such patches - setting things up from
> userspace may happen too late, or may not be possible at all if a
> setting needs to be available during probe. And even when deferring
> things to userspace is possible, making things configurable at runtime
> always adds some complexity, even though it is often not a requirement
> at all for embedded systems.

Using DT is all about adding complexity.

--WJwu/n+x+jLcVhiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSAknYACgkQJNaLcl1U
h9D+kAf/awycT8XVBCnr0kCiYWtoYgzT/oQXfsZKlKT9dOd7BxKN/NhDj7QIorwh
0fNqrzEV/jfc/py4sjfMlDaf/stbPohsNrvYiNZFoFXfexH+pPAydQJdefoxYb1u
sLPGl3r3P1BxExWtXI21mkzFZqowP/YhwkYkqC30WfE6pz6G7mbVaKiLCCklLYWo
keBIKxcJlS8ZEZl/wTTuJnhiCfJYMuhSLJhWfJEhHoBN+ptjbP21DbSnoKCL/x0O
KZEHcJh+sIrxfC7EXmbEl8RXp5eQJ/Ukd4usthaIZ4VCF8RqSIYVBqSVUfWiIi9j
i++y+VulJkx0LeF7bz1tox4yaRLVLA==
=VVkr
-----END PGP SIGNATURE-----

--WJwu/n+x+jLcVhiw--
