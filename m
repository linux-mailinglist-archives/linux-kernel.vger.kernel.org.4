Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AD3681FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjA3Xro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjA3Xrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:47:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544A32B63F;
        Mon, 30 Jan 2023 15:47:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E047E61302;
        Mon, 30 Jan 2023 23:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33320C433EF;
        Mon, 30 Jan 2023 23:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675122461;
        bh=WoJeIgf/JQZhJHXDszCWgkHNzPbweY0aWYQ3iEPGhBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QULFyBjTeeC1392caZNLBFUYEO05aNmt2qcr6HCpbQfJG2gU2FkCDLwIgYUjz18Q8
         uChNcDCAt0lr57gFu+1jkgxml6xL7DE7LuDBWkog8j9Ivc837sGCjv0UpTOD5Snbp0
         d8cxiAZHD24140/A9KBZxYbySlCqpCOnpFU+MgQbb1/Hfd02VQ1hxYoZ164EuA5e5E
         1Tp/4WdqExpa5XLCnjzmcjtOSaA5WERxcbf1ShyECo1MsVWtSlNJMVpVRagSxdlT1h
         7AQVsg2bu2pbk9IVx2gu4xU1FPlwj1iYAS/8j5MckNHeBucgBCo0GJ8Q4JoCNDywGU
         ffrSlyJINLfRQ==
Date:   Mon, 30 Jan 2023 23:47:35 +0000
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
Subject: Re: [PATCH 22/24] RISC-V: ACPI: Enable ACPI in defconfig
Message-ID: <Y9hXF8RpNawkuTEN@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-23-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zg0/95MUBwMtXXq2"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-23-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zg0/95MUBwMtXXq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sunil,

Two quick comments while I think of them..

On Mon, Jan 30, 2023 at 11:52:23PM +0530, Sunil V L wrote:
> RISC-V: ACPI: Enable ACPI in defconfig

btw, about half of this series redundantly puts "ACPI:" or "RISC-V:
ACPI:" into $subject. None of commits that mention ACPI after the last :
should mention ACPI in the prefix IMO, it's just noise.

For example, this one should be something like:
RISC-V: enable ACPI in defconfig

> Add support to build ACPI subsystem in defconfig.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/configs/defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 128dcf4c0814..8ce06fb0dde8 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -218,3 +218,7 @@ CONFIG_RCU_EQS_DEBUG=3Dy
>  # CONFIG_FTRACE is not set
>  # CONFIG_RUNTIME_TESTING_MENU is not set
>  CONFIG_MEMTEST=3Dy
> +CONFIG_ARCH_SUPPORTS_ACPI=3Dy

This needs to go into the arch Kconfig file, where it will be selected.
Check what arm64 does if you are not sure what I mean.

Hopefully I'll get a chance to look at the rest of this this week
sometime,
Conor.


--zg0/95MUBwMtXXq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9hXFwAKCRB4tDGHoIJi
0jz5AP9T0B2MgLSmPbYSg1QODDZGfojq049zs7BQd+8I5h0xMQEAg7Tq0HANXXSF
/wo06urL3IrFIJh1toI0j0c616zj5Q8=
=lM2h
-----END PGP SIGNATURE-----

--zg0/95MUBwMtXXq2--
