Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC137302B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245708AbjFNPDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245720AbjFNPDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:03:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47C21FE3;
        Wed, 14 Jun 2023 08:03:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A2576434E;
        Wed, 14 Jun 2023 15:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEF5C433C8;
        Wed, 14 Jun 2023 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686755002;
        bh=LEt2pBYL7CigE1zEaRaDO5CTS69Z8c7codyCYkofPlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cl5xcE7xsFiWw1tORLb3Cr9abHfqVlN5zVheDN2OuHYk/LGpOY+Z295mDlFLKxLMO
         2pgKIYBAlJ0GcqVx28nUJNfcM9Bk39NIXXUuSN9++U8rlE8ck+pLGI3TNn1ApR/vQo
         hAkFb/Rmf+fKdBBrsulw9hxCdf2flgP8XTdhbQcsRwuMPcOptxcIo6lvHv9o6xmQkD
         PDgQ0nrKTOwxt8IlmCKZTNoSbPsjLoDMnyz8UjcyJXK5SRSYToylgaG6x1CrhxZVvj
         y9PlQfD49xp+Grmt6UxCqo++jI8JgUYkaXmgi1PU3Uk8T9HanISI2cqzZ+vg4TJVfu
         wGgLaEncEmIlQ==
Date:   Wed, 14 Jun 2023 16:03:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: riscv: cpus: drop unneeded quotes
Message-ID: <20230614-credibly-pluck-0495779ada5d@spud>
References: <20230609-discourse-lapped-5217cc4d7ede@wendy>
 <mhng-c1f5c918-1b72-4a2b-91c0-eea05dab14b7@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PV8595nD57bx5mfz"
Content-Disposition: inline
In-Reply-To: <mhng-c1f5c918-1b72-4a2b-91c0-eea05dab14b7@palmer-ri-x1c9>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PV8595nD57bx5mfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 07:46:12AM -0700, Palmer Dabbelt wrote:
> On Fri, 09 Jun 2023 07:21:17 PDT (-0700), Conor Dooley wrote:
> > On Fri, Jun 09, 2023 at 04:07:06PM +0200, Krzysztof Kozlowski wrote:
> > > Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> > > checking for this can be enabled in yamllint.
> > >=20
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> Did you want me to pick this up in the RISC-V tree, or is it aimed somewh=
ere
> else?

Usually subsystem, or in this case arch, maintainers should take the
bindings patches. So that'd be you ;)

--PV8595nD57bx5mfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZInWtgAKCRB4tDGHoIJi
0un5AQCSNBTFePFa+t7bxX4UnEM53NaEfGDqBHaxM75f0smrwQEAofUW6ZXXVhva
Nm+4b9RihEYapjfffhBtj5KQhVz8LQE=
=8DCH
-----END PGP SIGNATURE-----

--PV8595nD57bx5mfz--
