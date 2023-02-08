Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A488368F6E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjBHS20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHS2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:28:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8661F4B6;
        Wed,  8 Feb 2023 10:28:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFD5CB81F39;
        Wed,  8 Feb 2023 18:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48158C433D2;
        Wed,  8 Feb 2023 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675880901;
        bh=h4Z1PtHljHwCVbgMyobf4aJQwDVtpHPPBTMUIZs29Gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n3eRbsqzEtl0u4K+pBR/uh1MTytXhj7AZOwXNMUUOYm7UpSy4RuCOJdOrHI/HlxNx
         +TH6fp1qcyG+a0tgA0HNILcVRxHV4yfFQB5woClSttKefRU0kTtrkhr/wWd/S8IcXk
         rOA52rdu9fss65Fo3PF2lG5oNdJNa+yUKATyq875Kvaijqu12VL8wt3OZSxUympaQh
         yT+W7N6ofw2unevGSzvVJKYgcwSC7/NVZYrCk/vuMUKYliKpgJ9U2miVbN7Ewkvjui
         uESzBfK5yX/n37emQJk8dScQ30Vt/TM18Q/DBQZn//ttd66cuRSVEp3NNOAPQ6E3Lu
         n5wACa15bgCbQ==
Date:   Wed, 8 Feb 2023 18:28:15 +0000
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
Message-ID: <Y+Ppv6kB1iksf+TF@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3UvAYbWp1U8XT/He"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3UvAYbWp1U8XT/He
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sunil,

On Mon, Jan 30, 2023 at 11:52:01PM +0530, Sunil V L wrote:
> This patch series enables the basic ACPI infrastructure for RISC-V.
> Supporting external interrupt controllers is in progress and hence it is
> tested using polling based HVC SBI console and RAM disk.
>=20
> The series depends on Anup's IPI improvement series.
> https://github.com/avpatel/linux/commits/riscv_ipi_imp_v17

In the future, please provide links to patchsets rather than "random"
git trees.

> Jisheng Zhang (1):
>   riscv: move sbi_init() earlier before jump_label_init()
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

What has this patch got to do with your series? Just something that was
sitting in your tree?

If you need this, it'd be ideal if you would submit *with* the R-b tags
it appears to have had by v6 [1] & add the reason that you need to move
it to the commit message.
In Jisheng's series that was obvious, but this is a significantly larger
series and it is hard to spot your reasoning for it.

Cheers,
Conor.


--3UvAYbWp1U8XT/He
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+PpvwAKCRB4tDGHoIJi
0vPuAP9v5J77SYw+hhwGsTWGrB7BFSWQB+FJSClGtSF9oLyAyQD/eikMzjv2mCEL
dIFF92vSrmUAKvml2Nv8u8CbSJh1RwM=
=oI2R
-----END PGP SIGNATURE-----

--3UvAYbWp1U8XT/He--
