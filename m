Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5488E65115C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 18:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiLSRwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 12:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLSRwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:52:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AE0DF5D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 09:52:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0769CB80F52
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 17:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C2AC433EF;
        Mon, 19 Dec 2022 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671472333;
        bh=omnk1EvftJxQZKK4tFNl78eH7ggIgQG8DRMsnWyBp38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHRiMbVZ3RofwcmucbbxHiWnKKCyyOlCx1ztiN1W8TWZJOMTSy1A8lM0131J+SQ4W
         IxEGB9p/fKEijrcT6ntjOGiRswr1zujSVUh+YQEJdmumqVwAeUsBJmICp/UsuJkavX
         neDh1bJ96fNh9J0+Dmv7ienF2yJzvbtnWe8Eph8gmqL4zYZHu+mY7Wv4jqC3tGJJy3
         vbvQ1Al9FdpIzb8iUWRSx6pnHhjHoQI84bUndWDGGTZkFoatbWKorzyiZcyvgbaDRq
         296Dh4cd60qnYK1Aaj5DeZwFua1efEq4UtKkR/xxPFlL51pKUCHcdVcqffqN6RlBiV
         e51q1ZLqj90uA==
Date:   Mon, 19 Dec 2022 17:52:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Akihiko Odaki <akihiko.odaki@daynix.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 1/7] arm64/sysreg: Convert CCSIDR_EL1 to automatic
 generation
Message-ID: <Y6CkxueMwWPBMV7h@sirena.org.uk>
References: <20221218051412.384657-1-akihiko.odaki@daynix.com>
 <20221218051412.384657-2-akihiko.odaki@daynix.com>
 <87cz8hez0i.wl-maz@kernel.org>
 <1ef32b0c-6cee-75f7-e1e0-ede1f5b9a016@daynix.com>
 <87bko0g8m2.wl-maz@kernel.org>
 <Y6B8fzaFSwmJ5VC1@sirena.org.uk>
 <86o7rzpg6i.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oz/pzyR4HiMnUm6B"
Content-Disposition: inline
In-Reply-To: <86o7rzpg6i.wl-maz@kernel.org>
X-Cookie: Pay toll ahead.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oz/pzyR4HiMnUm6B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2022 at 03:27:17PM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > fully represent everything in the spec yet.  For things like the
> > registers with multiple possible views it's much more effort which
> > shouldn't get in the way of progress on features but with something like
> > this just updating the tool so we can match the architecture spec is the
> > right thing.

> I was tempted to add a Namespace tag that wouldn't generate the sysreg
> #defines, but only generate the fields with a feature-specific
> namespace. For example:

I think this is roughly where we'd end up - I was using the term view
when thinking about it but that's just bikeshed.

> Sysreg	CCSIDR_EL1	3	1	0	0	0
> Res0	63:32
> Unkn	31:28
> Field	27:13	NumSets
> Field	12:3	Associativity
> Field	2:0	LineSize
> EndSysreg
>=20
> Namespace CCIDX CCSIDR_EL1
> Res0	63:56
> Field	55:32	NumSets
> Res0	31:25
> Field	24:3	Associativity
> Field	2:0	LineSize
> EndSysreg

Yeah, something like that.  I think we also want a way to label bits in
the root register as only existing in namespaces/views for things where
there's no default (eg, where a feature adds two views at once or things
have been there since the base architecture), and I wasn't sure if it
made sense to nest the declaration of the views inside the Sysreg (I'm
tempted to think it's more trouble than it's worth especially on the
tooling side).

I also wanted to go through and do an audit of all the current registers
to make sure there were no nasty cases that'd complicate things.  I
don't think there'd be anything but...

> the later generating:

> #define CCIDR_EL1_CCIDX_RES0		(GENMASK(63, 56) | GENMASK(31, 25))
> #define	CCIDR_EL1_CCIDX_NumSets		GENMASK(55, 32)
> #define	CCIDR_EL1_CCIDX_Associativity	GENMASK(24, 3)
> #define CCIDR_EL1_CCIDX_LineSize	GENMASK(2, 0)

> Thoughts?

Definitely that for the output.

--oz/pzyR4HiMnUm6B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgpMYACgkQJNaLcl1U
h9DU0Af/SvoqDYexlOme2j0EORslcib1fD+HrBcMgXD/y5b//5a3p3SAmFlAd4P3
pITNOWvrGAqXP/YLGgwMnnHaZqSk/lHr5+FvqNJPuYPesoqDVIC7essCYZxx/7Oj
A1/UNsvXnMc8PctXZwv8zUPDYv0K3kgr6Tyh/gkeCU1MSzoKLoSTBQ7R3fa2KkC1
RTjeUddshIpTQwHmB+I6YNKCAirDHOs4oF6A5fyrh+lOIyUXmer7tMTX0SEKkbtz
zdHKY0Ul8u0P0IQm65LWYBeC1pz8rwp7RBhKkWbGMORv24PaeI5t1yzxeJhdFYLN
yYJbS34/t/gl9viuV6jBiFvnr3meVA==
=Gj9m
-----END PGP SIGNATURE-----

--oz/pzyR4HiMnUm6B--
