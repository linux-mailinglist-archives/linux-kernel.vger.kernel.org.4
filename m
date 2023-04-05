Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949B06D81EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbjDEPam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbjDEPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F0A171C;
        Wed,  5 Apr 2023 08:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E16062683;
        Wed,  5 Apr 2023 15:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10492C433EF;
        Wed,  5 Apr 2023 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680708629;
        bh=J70rkXpf+7f+HnbEFbLXATI7qyexO1zYvkS1Bdg/1F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDDWSOhT3kzc6lyxKUkTZFHCre0Ns6mUD+tB0tYkihTyztKFBxFtlqLJgNlqV6gDJ
         qOMn9cGcV2+X0j6MlVJ03OOlDG+iLFwczbgBMjKBnYXU3Uv1i+fKRu6DmyI+/Yxz9s
         8RIYINIVbaW5Ng69aX9lf+qB9UGL5ceLrxTFZhunq9mNHirMxY/K/QuA+f80rD0wKb
         JMvvvuIlG960ADqVTyftwbW3/yYOaQoBWamDuRiajNw4GVkTWzvDKE916QV5M6/Vyx
         dSj2MT9L0akAXnsn064NQlVRrb7cTPo9nsPXGcn+gKTkQqpKLw8UxruRkitnwP1EFN
         7rgx5JkERclEQ==
Date:   Wed, 5 Apr 2023 16:30:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Weili Qian <qianweili@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Len Brown <lenb@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH V4 19/23] RISC-V: Add ACPI initialization in setup_arch()
Message-ID: <20230405-exclusion-swivel-b350fe541ba2@spud>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-20-sunilvl@ventanamicro.com>
 <20230404-escalator-fridge-daf9aaffad12@spud>
 <ZC2PuiY5Xscz305H@sunil-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GEzl862YP+iNbgsb"
Content-Disposition: inline
In-Reply-To: <ZC2PuiY5Xscz305H@sunil-laptop>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GEzl862YP+iNbgsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 08:41:54PM +0530, Sunil V L wrote:
> On Tue, Apr 04, 2023 at 10:38:56PM +0100, Conor Dooley wrote:
> > On Tue, Apr 04, 2023 at 11:50:33PM +0530, Sunil V L wrote:
> > > Initialize the ACPI core for RISC-V during boot.
> > >=20
> > > ACPI tables and interpreter are initialized based on
> > > the information passed from the firmware and the value of
> > > the kernel parameter 'acpi'.
> > >=20
> > > With ACPI support added for RISC-V, the kernel parameter 'acpi'
> > > is also supported on RISC-V. Hence, update the documentation.
> > >=20
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > > +	/* Parse the ACPI tables for possible boot-time configuration */
> > > +	acpi_boot_table_init();
> > > +	if (acpi_disabled) {
> > > +		if (IS_ENABLED(CONFIG_BUILTIN_DTB)) {
> > > +			unflatten_and_copy_device_tree();
> > > +		} else {
> > > +			if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> > > +				unflatten_device_tree();
> > > +			else
> > > +				pr_err("No DTB found in kernel mappings\n");
> > > +		}
> > > +	} else {
> > > +		early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa)));
> >=20
> > I'm probably forgetting something, but this seems very non-obvious to
> > me:
> > Why are you running early_init_dt_verify() when ACPI is enabled?
> > I think that one deserves a comment so that next time someone looks at
> > this (that doesn't live in ACPI land) they've know exactly why this is
> > like it is.
> >=20
> > Doubly so since this is likely to change with some of Alex's bits moving
> > the dtb back into the fixmap.
> >=20
> Good question. The kernel creates a tiny DTB even when the FW didn't
> pass the FDT (ACPI systems). Please see update_fdt().

Can you add a comment about this either on-location or in the commit
message please?
I think this counts as non-obvious behaviour. At least to me it does!

Cheers,
Conor.


--GEzl862YP+iNbgsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZC2UDQAKCRB4tDGHoIJi
0kR4AP0Q5hwJRNOPqj+g2K45l6UmniFmC4M8n4KXYsXGPCyozAEAm42AMmnUhTsZ
Hnl2sWV10azclkpiXjVwwJJY0TUWNws=
=6Cjf
-----END PGP SIGNATURE-----

--GEzl862YP+iNbgsb--
