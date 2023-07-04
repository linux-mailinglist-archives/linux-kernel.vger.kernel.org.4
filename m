Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BCB7476FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGDQlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjGDQlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:41:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C886A10F8;
        Tue,  4 Jul 2023 09:41:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C2F961307;
        Tue,  4 Jul 2023 16:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613CEC433C7;
        Tue,  4 Jul 2023 16:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688488888;
        bh=SVPdblX3YDY55Q6UtjLbYsorf7soz2DR4bHIEBjDZIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHi9lr8nVm6HF0BJ5YxREUODkaqRgT+8dw/G9LRK/hK9Rhku7NT5RIFrHDn3prkoB
         KHJMZR7UjrV8oMT6KtiNxyQ0rd3c14XgOXshImtCHcikHEEqi4UFaCRRL7tFX8xOh0
         Q/UJP9W9bIVC1GxQMcBXE+6TtES6HCSNR7tdg217QUu01jVJ20TYimWzjIM97juGMW
         3H3y+yRh61P/sgTBwSLyeRjp5G3jM3Ll1OqhZ02r1jIc+/tWQ4daLD5n3YtdjMA8PT
         2cyw06urNulmdbk1bCMaiWEC2Qn4ADLd8PWQD2+YjgGCPplxYr2wEqc6xYA0McJem4
         4lU946xl2yEFg==
Date:   Tue, 4 Jul 2023 17:41:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v4 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Message-ID: <9de02a94-8043-4355-8925-99e0d1ffb713@sirena.org.uk>
References: <20230704090453.83980-1-william.qiu@starfivetech.com>
 <20230704090453.83980-3-william.qiu@starfivetech.com>
 <20230704-gooey-lair-2bc45bbd163c@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L4GnaeX8yK5XFQS4"
Content-Disposition: inline
In-Reply-To: <20230704-gooey-lair-2bc45bbd163c@spud>
X-Cookie: Memory fault - where am I?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L4GnaeX8yK5XFQS4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 05:36:03PM +0100, Conor Dooley wrote:
> On Tue, Jul 04, 2023 at 05:04:52PM +0800, William Qiu wrote:
> > Add QSPI clock operation in device probe.
> >=20
> > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> > Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202306022017.UbwjjWRN-lkp=
@intel.com/

> These Reported-by tags don't seem correct, given they were reports about
> this patch, not the reason for it - but did you actually check that you
> fixed the errors that the patch produces?

Yeah, the Reported-bys that LKP sends in response to on list patches are
a menace, they just generate noise.

> This particular one seems to complain about a hunk that is still in the
> patch & the CI running on the RISC-V patchwork is complaining about it.

I'm surprised that builds cleanly anywhere...

--L4GnaeX8yK5XFQS4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSkS7IACgkQJNaLcl1U
h9Cwygf+Lj0XeLehyPuY28oqR7nq3BMn39mQIj5yXEW09p/l4CZZw5/nQLPSE4Jm
AczOgbi3beJiQmLD3L3d8BAO8JIHTbTJB+KB45GTL9TAUi35rENRnvQ58BEbC3dw
hGRSzWT4MB6NnwWwB5JncAEACtqgigOD5JVivb11GC6+XmH2A5q4FUP3ZtQpM7Yu
XoD8W7cWHhwFz0K/kLW8R/zSjp3F16C0yl3hZaOyuYvfPO4KqBBjnByCpazTyVFp
bdBGgDDW5slxkRAQco2hUBvqyV6zOdqQv5FXPmw7regtL3fn0OnGMjs3p1jZ0Tdn
Kep9GeD7snkKgqCTvEMXpTvpjBgE6Q==
=dkuj
-----END PGP SIGNATURE-----

--L4GnaeX8yK5XFQS4--
