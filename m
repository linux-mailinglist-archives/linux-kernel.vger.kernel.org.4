Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627EA72E049
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbjFMLCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbjFMLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:02:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDCB10D4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4824C61757
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A99C433EF;
        Tue, 13 Jun 2023 11:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686654156;
        bh=xTXLg6Gmd35HxM/DB6S7j9/iRs4jOwAr4ziLjh9QAYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Su4olLirkWNUvyiNlpG+6n7FFzfa8TNzL0BdpeYFHYR7+oDYZRnqFCWtcLXfvIqpL
         WzgCy/ZlMhXb+ZGul217aC5jD+xxAlPn518Xm4OOBfm0HXaMVEV6jrnYWxWQJnZ5Hw
         v2Wit34P5NY0EObKCin6wU5ofWD0i1x+e1wMTXxWbbNSGZ8EjL3u2RIDUL2BRqPz2T
         gwNygVM7sJokIUjJ63nMow3gwlYaoZrpQc1HkfChPS8NmTM9ZJxTv/VUfAkZqF1xBi
         5myvPWVEv8UHqgHKbMvQhDp6d0T0Zy7U17hFekTZFOGwJIGBs5jVTusm1zADlji+Gc
         zyqb3CSi0kbqA==
Date:   Tue, 13 Jun 2023 12:02:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 14/14] arm64/sysreg: Convert TRBIDR_EL1 register to
 automatic generation
Message-ID: <8bfffd83-f4a3-445b-9343-7325c671bd00@sirena.org.uk>
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
 <20230602062552.565992-15-anshuman.khandual@arm.com>
 <4de1ec32-f07b-4eca-99e2-f71a08f5cd5b@sirena.org.uk>
 <1dca7ec8-a0d1-3038-7e9f-0d2934dc2e37@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tPwiVwOaYEtW6aoV"
Content-Disposition: inline
In-Reply-To: <1dca7ec8-a0d1-3038-7e9f-0d2934dc2e37@arm.com>
X-Cookie: Made with real ingredients.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tPwiVwOaYEtW6aoV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 09:56:31AM +0530, Anshuman Khandual wrote:

>  Sysreg TRBIDR_EL1      3       0       9       11      7
>  Res0   63:12
> -Field  11:8    EA
> +Enum   11:8    EA
> +       0b0000  NON_DESC
> +       0b0001  IGNORE
> +       0b0010  SERROR
> +EndEnum

Sure.

> >> +Field	3:0	Align
> >=20
> > Align arguably too though really it's just encoding the relevant power
> > of 2 with the enum coming from the fact that it's limited to at most 2KB
> > alignment so a Field may well make more sense.
>=20
> Can fold the following changes in this patch (if required) unless the Fie=
ld
> looks better than Enum.
>=20
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -2275,5 +2275,18 @@ EndEnum
>  Res0   7:6
>  Field  5       F
>  Field  4       P
> -Field  3:0     Align
> +Enum   3:0     Align
> +       0b0000  BYTE
> +       0b0001  HALF_WORD
> +       0b0010  WORD

I'm not sure this one makes sense as an enum, though it is technically
one.

--tPwiVwOaYEtW6aoV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSITMYACgkQJNaLcl1U
h9Cebwf/YnyUkQpHVypDqyv2AXpb4cbOcLaeN51ltZjX+52q7Hfj5X9gMcClDYpy
nS6Zs7MUlCVB5z0oT4jLmrNE199Kl4XfizF93KX9eY3xXJV97nhdswOum4KaDViP
KJZfmSyu4iTqgVc8XrNzORTwX09RxwxQ5AFGLvImzVHjM5DFXUY6QaBpbYWgz/9I
vouoTBegdtm91HLm9JfBCnpFpdjgIweGwcreFssr+iFgXwZKh+Ro9XdX4RQmwVNs
1L1tguc8jFnQyNxbN9u5UemC+eq5GY5tecERTf+apqmWSEw48y0tiN2bofJxJX6Q
/duLdurFMRpeOpsa+6gPCs5MGOWY+A==
=zLcy
-----END PGP SIGNATURE-----

--tPwiVwOaYEtW6aoV--
