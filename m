Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D82C7442D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjF3TpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3TpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE9A3AAF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 12:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83A88617F1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 19:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3291C433C8;
        Fri, 30 Jun 2023 19:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688154305;
        bh=Gz3EGjK0wDfPFqqPSFx9EN34bJyDZae+TOOU/oFUqkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5/CBbIcmZzqWROpNGgc/CmzTwFgP9rZyUp8A1QdPu09GeFAvlgHUKihV/9/2Aw6u
         R+PXolwZe2WHbRCTHJoUfCMuGRw0mDVGN66Yq88BTSVGEbUmY5EQv2I2QAFL9NJuDD
         TH2dhHu7yOItVSw/NKDvESkPX/CnEiJC5zQ0SsvYhRXAZ5SDR4QeYW8w/FDFnf/pJw
         zX0/cp+PhPwofjT0SfaQc9vFU3+4trABpM5XZGlQ8+exl/2CZO1QXVJtPmwhzp8tYm
         sl0n+0EPVyol/zkeqcPIFHdVCTR4bOSZvgoU6Qkl+S/aFrSC4qVYiS7jyyCubZD0CF
         SjJI/7ADIBSYQ==
Date:   Fri, 30 Jun 2023 20:45:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] riscv: KCFI support
Message-ID: <20230630-imprecise-ibuprofen-98f70a8665da@spud>
References: <20230629234244.1752366-8-samitolvanen@google.com>
 <20230630-phrasing-strung-12e53988ad81@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5RH3lh36f2f8cAFF"
Content-Disposition: inline
In-Reply-To: <20230630-phrasing-strung-12e53988ad81@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5RH3lh36f2f8cAFF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 07:48:23PM +0100, Conor Dooley wrote:
> Hey Sami,
>=20
> On Thu, Jun 29, 2023 at 11:42:45PM +0000, Sami Tolvanen wrote:
> > This series adds KCFI support for RISC-V. KCFI is a fine-grained
> > forward-edge control-flow integrity scheme supported in Clang >=3D16,
> > which ensures indirect calls in instrumented code can only branch to
> > functions whose type matches the function pointer type, thus making
> > code reuse attacks more difficult.
>=20
> > base-commit: c6b0271053e7a5ae57511363213777f706b60489
>=20
> Could you please rebase this on top of v6.5-rc1 when that comes out?
> This base-commit is some random commit from Linus' tree, that because we
> are currently in the merge window has is not in the RISC-V trees yet,
> and means the series wasn't applied by our CI stuff.

In other news, I gave it a go with 03b118c7e456 ("[SLP] Fix crash on
attempt to access on invalid iterator state.") & have been running it
for a bit. All seems in order so far, nice :)

--5RH3lh36f2f8cAFF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8wvQAKCRB4tDGHoIJi
0n7sAPoCIPcrVQj6zFZMwpWtS5syPkfKJvsn7z+aOpGtLJuswgEA0cHVGWrRG5F/
7pkuFFiHmNuHKoATNB+0d+B3WOzhAAA=
=a0Pn
-----END PGP SIGNATURE-----

--5RH3lh36f2f8cAFF--
