Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E888717EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjEaLq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjEaLqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:46:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA634E8
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 617D563A0B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A511C433D2;
        Wed, 31 May 2023 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685533596;
        bh=88OU10e4kzT8z8TT+amIVAmCrdCDAdulEGQ6N2xwf3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ztdf6b96WaoSrN1oeNDYOAxCxn3i1+oDz8BdJ/3tzz0qbgO6Q1w8c/75PrIojFuU0
         tMSnka0gKPb30aF1HXTmee7HhSg292TzBPZr4KLGOrrv6HkSKrYiHRWlDA683PykdB
         iDKTjUdL9k8b0YWLuXJmTiqZaKrmx7Vc16NPFKiUIWU6J+Q7HSgUOrnM5SGSCLqhqD
         yw3L55t/9rSHxTID7Ut8zP6Vz+b8ODMdJNgQlr1veXMa/R3us6CCE+B1rZutNO5WzF
         aiAg0UV3zGcoNwIn9SBrnszdOPLI0v5dRZrYgh308QNyJfLEjbnQKmPLd/GQLHTbTp
         PWH+VndjmZQ2g==
Date:   Wed, 31 May 2023 12:46:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, coresight@lists.linaro.org
Subject: Re: [PATCH] arm64/sysreg: Convert TRBE registers to automatic
 generation
Message-ID: <b14abfc9-e6ae-4075-95da-d06947c70db0@sirena.org.uk>
References: <20230531055524.16562-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DJKn/AawpZVzxg9g"
Content-Disposition: inline
In-Reply-To: <20230531055524.16562-1-anshuman.khandual@arm.com>
X-Cookie: Will Rogers never met you.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DJKn/AawpZVzxg9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 31, 2023 at 11:25:24AM +0530, Anshuman Khandual wrote:

> This converts all TRBE related registers to automatic generation and update
> the driver as required. This does not cause any functional change.

>  arch/arm64/include/asm/el2_setup.h           |  2 +-
>  arch/arm64/include/asm/sysreg.h              | 49 ----------------
>  arch/arm64/kvm/debug.c                       |  2 +-
>  arch/arm64/kvm/hyp/nvhe/debug-sr.c           |  2 +-
>  arch/arm64/tools/sysreg                      | 59 ++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-trbe.c | 33 +++++------
>  drivers/hwtracing/coresight/coresight-trbe.h | 38 +++++--------
>  7 files changed, 94 insertions(+), 91 deletions(-)

These changes are easier to review if split up a bit, for example
separating the renames of constants from the actual conversion (and
doing different renames separately, though it looks like this only does
the addition of _EL1) or splitting things up by register so that the
registers that are OK don't need to be re-reviewed.

> +Sysreg	TRBLIMITR_EL1	3	0	9	11	0
> +Field	63:12	LIMIT
> +Res0	11:6

In DDI0601 2023-03 bit 6 is allocated to a field called XE.

> +Field	5	NVM

nVM.

> +Enum	4:3	TRIG_MODE
> +	0b00	STOP
> +	0b01	IRQ
> +	0b11	IGNR
> +EndEnum

This is documented as TM.

> +Enum	2:1	FILL_MODE
> +	0b00	FILL
> +	0b01	WRAP
> +	0b11	CBUF
> +EndEnum

This is documented as FM.

> +Field	0	ENABLE

This is documented as E.

> +Sysreg	TRBSR_EL1	3	0	9	11	3
> +Res0	63:32

In DDI0601 2023-03 MSS2 is allocated in this region from 55:32.

> +Field	31:26	EC
> +Res0	25:23

In DDI0601 2023-03 DAT is allocated in this region at bit 23.

> +Field	17	STOP

This is called S.

> +Res0	15:6
> +Field	5:0	BSC

In DDI0601 2023-03 bits 15:0 are a field MSS which has BSC allocated as
a subfield within it for some events, implementation defined events
could use a different encoding though.  We don't represent things like
this (or the various codes in ESR) within the scripting language yet.

> +Sysreg	TRBMAR_EL1	3	0	9	11	4
> +Res0	63:10
> +Field	9:8	SH
> +Field	7:0	ATTR
> +EndSysreg

DDI0601 2023-03 has a field PAS at bits 11:10.

> +Sysreg	TRBIDR_EL1	3	0	9	11	7
> +Res0	63:6

DDI0601 2023-03 has a field EA from bits 11:8.

> +Field	5	FLAG

This is documented as F.

> +Field	4	PROG

This is documented as P.

--DJKn/AawpZVzxg9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR3M5YACgkQJNaLcl1U
h9AVdgf9FzSgWwcEQeyWJ9GQq6tf6MWtlTLL+IWY6oGCMahE2ybTCSF+UU58xtPU
oxQFg24BAp0EtGz/U35xRm1qLIBJ7GyrcZCpRBG8ldkJGJytZnlm90JLiPb1zIim
F1sizPL2BYUPlGeSdHgLIWLuF3ilm5W+5o/s8fOJu3TEtk2y6pjVxoKzFg94QHJy
5xdvvtrQkFKAqcm9dqE0ZDe+A94hyzCFE12E4hQKVCL9Bx4QyVscswDMDihZhb02
2dyf4xPjjhfeIqCMgn5WiTwBWmUOzcy70aMLXxCapoN3ESFc4N3osYnugJP/c3cb
MolCHs5u84OsFn3WpMtex8BnOi92LA==
=5Evs
-----END PGP SIGNATURE-----

--DJKn/AawpZVzxg9g--
