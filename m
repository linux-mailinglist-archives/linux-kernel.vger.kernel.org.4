Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F1E68F76D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjBHSuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBHSus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:50:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF7D49422;
        Wed,  8 Feb 2023 10:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75733B81F45;
        Wed,  8 Feb 2023 18:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F0AC433D2;
        Wed,  8 Feb 2023 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675882245;
        bh=aj8x5SDs25y8h+VPsvp1Z3QlTPzHoa2icbVCfoaqexE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hAJ8Sm/EsdS5aquTPc13W7ADNi5CwgFTirWqfzYHXRuA5abvJXKH/fzDIPBAhrBGi
         prsnPoOwSUOWQUoP4k0GxcJVSKYTKc9qbqnPTbbpBiCYrnWxFiRLXWGp1knjhJDe7y
         5bR6laiAZ5ICnUFMCBMuaxQ2fdcyvYDv1fDJNojs3dkt0ZlS4CfeHuPJOfWJMUXPzB
         nWHQa7sbV+BlxsUEvGQOnqqINg8IyNbr/o9IEMbZqisJ+PMFl6JWZxmibB05zcWoMp
         HIxOnf0WbFRGbmaAyk3i585IP23qUdGL32Jz3pzR9Sl1CKHPnuYnKHZfrPrtRd71TS
         lAf1QO+yvLqRA==
Date:   Wed, 8 Feb 2023 18:50:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 00/24] Add basic ACPI support for RISC-V
Message-ID: <Y+Pu/z7dN87v3udc@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <Y+Ppv6kB1iksf+TF@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aaYcc/YKkg738NAj"
Content-Disposition: inline
In-Reply-To: <Y+Ppv6kB1iksf+TF@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aaYcc/YKkg738NAj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 06:28:15PM +0000, Conor Dooley wrote:
> Hey Sunil,
>=20
> On Mon, Jan 30, 2023 at 11:52:01PM +0530, Sunil V L wrote:
> > This patch series enables the basic ACPI infrastructure for RISC-V.
> > Supporting external interrupt controllers is in progress and hence it is
> > tested using polling based HVC SBI console and RAM disk.
> >=20
> > The series depends on Anup's IPI improvement series.
> > https://github.com/avpatel/linux/commits/riscv_ipi_imp_v17
>=20
> In the future, please provide links to patchsets rather than "random"
> git trees.
>=20
> > Jisheng Zhang (1):
> >   riscv: move sbi_init() earlier before jump_label_init()
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> What has this patch got to do with your series? Just something that was
> sitting in your tree?
>=20
> If you need this, it'd be ideal if you would submit *with* the R-b tags
> it appears to have had by v6 [1] & add the reason that you need to move
> it to the commit message.
> In Jisheng's series that was obvious, but this is a significantly larger
> series and it is hard to spot your reasoning for it.

Apologies, I forgot to provide the link!
https://lore.kernel.org/all/20220821140918.3613-1-jszhang@kernel.org/

Cheers,
Conor.


--aaYcc/YKkg738NAj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+Pu/wAKCRB4tDGHoIJi
0pqjAP9v4xdzdROd07gJezBPig/rkwOEA+Nl74MUMwUBEgsVJwEAlKLC7xLXGfWy
pbk12modw39jo6nvkXOoN9lAb7SH9QM=
=465b
-----END PGP SIGNATURE-----

--aaYcc/YKkg738NAj--
