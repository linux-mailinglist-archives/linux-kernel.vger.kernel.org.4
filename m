Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F7C720692
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbjFBPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjFBPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434A319A;
        Fri,  2 Jun 2023 08:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C70A0651A1;
        Fri,  2 Jun 2023 15:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB36C433D2;
        Fri,  2 Jun 2023 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685721248;
        bh=Es/w85zqCOLTBKKU6u/SunDJIniDYXSgH1w4nPLzpGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ob6M93AWC2OlTZCdsavfDIW2JWpHDT0zq0GaEOLoivGFrnhZbLLaf14R8E0A+g6YK
         KS2XchQOU/5dK3q2eSG6vke0C7vF+xhe4mBILN6U0TdQWktd19I2o3iuqZromS5wax
         XduhNQF2M65JsgWaG15gNbmBsuGNxLJ+c2Ehw3QJ1rQokB25Lvp4CP8m5a0yJ5umBS
         1661iykNwaPr/GRBAciaU610TqajTv0If1D5Tbx8NJx9/5uQJY/nTsVAuhcQQX2ZU2
         dGQaoPEHLyxMi3D3fwVTsXI5dbtlmuhgOrnfabEQT6bsQSjppJ9vMRWpGggwpNWup0
         4rG8SptpUyaZA==
Date:   Fri, 2 Jun 2023 16:54:00 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-doc@vger.kernel.org, trix@redhat.com, llvm@lists.linux.dev,
        Bjorn Topel <bjorn@rivosinc.com>,
        platform-driver-x86@vger.kernel.org,
        linux-riscv@lists.infradead.org, qianweili@huawei.com,
        herbert@gondor.apana.org.au, corbet@lwn.net,
        Marc Zyngier <maz@kernel.org>, daniel.lezcano@linaro.org,
        linux-acpi@vger.kernel.org, lenb@kernel.org, aou@eecs.berkeley.edu,
        markgross@kernel.org, hdegoede@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com,
        linux-crypto@vger.kernel.org, rafael@kernel.org,
        luzmaximilian@gmail.com, davem@davemloft.net
Subject: Re: (subset) [PATCH V6 00/21] Add basic ACPI support for RISC-V
Message-ID: <20230602-aerosol-granddad-f091b94e74e1@spud>
References: <168571787727.17224.6663458864222960682.b4-ty@rivosinc.com>
 <mhng-4fad860f-b5ff-4dc1-968e-219be1983acd@palmer-ri-x1c9>
 <20230602-reformist-jet-9fd642b971d2@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Rvz4WVjJsR4hWDUh"
Content-Disposition: inline
In-Reply-To: <20230602-reformist-jet-9fd642b971d2@spud>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rvz4WVjJsR4hWDUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 04:50:49PM +0100, Conor Dooley wrote:
> On Fri, Jun 02, 2023 at 08:11:04AM -0700, Palmer Dabbelt wrote:
> > On Fri, 02 Jun 2023 07:57:57 PDT (-0700), Palmer Dabbelt wrote:
>=20
> > I also don't yet have any testing for the ACPI stuff, but hopefully I'l=
l get
> > around to adding some.  We should probably add it to the patchwwork CI =
as
> > well.
>=20
> Yeah, just like DT testing should be added too! I am planning on doing
> some work on that front next week, hopefully I make good on my word...
>=20
> Cheers,
> Conor.
>=20
> Also, having ACPI support in means we now need
> https://lore.kernel.org/all/tencent_B30EED51C7235CA1988890E5C658BE35C107@=
qq.com/
> to be compliant with the ECR. It doesn't apply as-is, so I will add a
> Fixes tag & rebase.

Nevermind, doesn't need a rebase - it applies with `b4 am -3` ;)

Cheers,
Conor.

--Rvz4WVjJsR4hWDUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHoQmAAKCRB4tDGHoIJi
0t7eAQCPio6yrHjEb84AkptPs4YobcI7FS9rxh1Jaq6uUwcvmAD+NcquJRl67h8E
oLlMgcF9wP0MM93Up+Cjy+GEh6eFkAg=
=GFdg
-----END PGP SIGNATURE-----

--Rvz4WVjJsR4hWDUh--
