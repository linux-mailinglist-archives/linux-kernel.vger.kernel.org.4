Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7268F9A9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjBHV1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBHV1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:27:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06521C7DB;
        Wed,  8 Feb 2023 13:27:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 512D7B81F05;
        Wed,  8 Feb 2023 21:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98E0C433D2;
        Wed,  8 Feb 2023 21:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675891622;
        bh=oI7y/FZhevEdPWTxEZ3gltCzaLhYnX3pa+zhqi7lojU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvUV+QOoPcofq6JRXv3o5N3Ym1RXQNN1T/FLKfz+9De+6hKU2UZ4BfURPanxoURAh
         /8XMjpDLGHJyG0c5gxbYCq4iuvzcIaV20GeASVA5vIFaVvSjC+8lXNov9n2jAym2Um
         KyE2+KGwAAwstbZdDTlLMcKdwe19eSR7BmYHRb3vILrvk6ZGu0KuzwunctXPPNeL52
         IRhkHPJ5vkDwcyjfrCZSBQmdfn030NM4GOC6VntaI415hL7yuY3SbDar9fyzg6iWzM
         J+0wxmO0HOc41xm69u+6BC9Y1hPDve7nu6UQ695jU2E9rYVr1zi7jX4kp5fFYdjlIN
         W/Asq6vZDNo/g==
Date:   Wed, 8 Feb 2023 21:26:57 +0000
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
Subject: Re: [PATCH 06/24] RISC-V: ACPI: Add PCI functions to build ACPI core
Message-ID: <Y+QToXO2kYQ2ipdz@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-7-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pAMvRf+LG3lTC78u"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-7-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pAMvRf+LG3lTC78u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:07PM +0530, Sunil V L wrote:
> When CONFIG_PCI is enabled, ACPI core expects few arch
> functions related to PCI. Add those functions so that
> ACPI core gets build. These are levraged from arm64.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/kernel/Makefile |   1 +
>  arch/riscv/kernel/pci.c    | 173 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+)
>  create mode 100644 arch/riscv/kernel/pci.c

> diff --git a/arch/riscv/kernel/pci.c b/arch/riscv/kernel/pci.c
> new file mode 100644
> index 000000000000..3388af3a67a0
> --- /dev/null
> +++ b/arch/riscv/kernel/pci.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Code borrowed from ARM64
> + *
> + * Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
> + * Copyright (C) 2014 ARM Ltd.
> + * Copyright (C) 2022-2023 Ventana Micro System Inc.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
> +
> +#ifdef CONFIG_ACPI

Quickly checking against ARM64, they do not wrap the read/write
functions in this ifdef, so why do we need to do so?

> +/*
> + * raw_pci_read/write - Platform-specific PCI config space access.
> + */
> +int raw_pci_read(unsigned int domain, unsigned int bus,
> +		  unsigned int devfn, int reg, int len, u32 *val)
> +{
> +	struct pci_bus *b =3D pci_find_bus(domain, bus);
> +
> +	if (!b)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	return b->ops->read(b, devfn, reg, len, val);

A newline before the return would be appreciated by my eyes :)

> +}
> +
> +int raw_pci_write(unsigned int domain, unsigned int bus,
> +		unsigned int devfn, int reg, int len, u32 val)

Also, both read and write functions here appear to have incorrect
alignment on the second lines.

> +{
> +	struct pci_bus *b =3D pci_find_bus(domain, bus);
> +
> +	if (!b)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	return b->ops->write(b, devfn, reg, len, val);
> +}
> +
> +

Extra newline here too, looks to be exactly where you deleted the numa
stuff from arm64 ;)

> +struct acpi_pci_generic_root_info {
> +	struct acpi_pci_root_info	common;
> +	struct pci_config_window	*cfg;	/* config space mapping */
> +};
> +
> +int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> +{
> +	struct pci_config_window *cfg =3D bus->sysdata;
> +	struct acpi_device *adev =3D to_acpi_device(cfg->parent);
> +	struct acpi_pci_root *root =3D acpi_driver_data(adev);
> +
> +	return root->segment;
> +}
> +
> +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)

Rhetorical question perhaps, but what does "ci" mean?

> +{
> +	struct resource_entry *entry, *tmp;
> +	int status;
> +
> +	status =3D acpi_pci_probe_root_resources(ci);
> +	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> +		if (!(entry->res->flags & IORESOURCE_WINDOW))
> +			resource_list_destroy_entry(entry);
> +	}
> +	return status;

Perhaps that extra newline from above could migrate down to the line
above the return here.

> +}
> +
> +/*
> + * Lookup the bus range for the domain in MCFG, and set up config space
> + * mapping.
> + */
> +static struct pci_config_window *
> +pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)

This all fits on 1 line.

> +{
> +	struct device *dev =3D &root->device->dev;
> +	struct resource *bus_res =3D &root->secondary;
> +	u16 seg =3D root->segment;
> +	const struct pci_ecam_ops *ecam_ops;
> +	struct resource cfgres;
> +	struct acpi_device *adev;
> +	struct pci_config_window *cfg;
> +	int ret;
> +
> +	ret =3D pci_mcfg_lookup(root, &cfgres, &ecam_ops);
> +	if (ret) {
> +		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
> +		return NULL;
> +	}
> +
> +	adev =3D acpi_resource_consumer(&cfgres);
> +	if (adev)
> +		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
> +			 dev_name(&adev->dev));
> +	else
> +		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
> +			 &cfgres);
> +
> +	cfg =3D pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
> +	if (IS_ERR(cfg)) {
> +		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
> +			PTR_ERR(cfg));
> +		return NULL;
> +	}
> +
> +	return cfg;
> +}
> +
> +/* release_info: free resources allocated by init_info */

The fact that you haven't picked a consistent comment style for this
functions really bothers my OCD. Yes, it may be copy-paste from arm64,
but since this is "new code" I don't think there's harm in at least
*starting* with something that looks cohesive.

> +static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
> +{
> +	struct acpi_pci_generic_root_info *ri;
> +
> +	ri =3D container_of(ci, struct acpi_pci_generic_root_info, common);
> +	pci_ecam_free(ri->cfg);
> +	kfree(ci->ops);
> +	kfree(ri);
> +}
> +
> +

Extra newline here.

> +/* Interface called from ACPI code to setup PCI host controller */
> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> +{
> +	struct acpi_pci_generic_root_info *ri;
> +	struct pci_bus *bus, *child;
> +	struct acpi_pci_root_ops *root_ops;
> +	struct pci_host_bridge *host;
> +
> +	ri =3D kzalloc(sizeof(*ri), GFP_KERNEL);
> +	if (!ri)
> +		return NULL;
> +
> +	root_ops =3D kzalloc(sizeof(*root_ops), GFP_KERNEL);
> +	if (!root_ops) {
> +		kfree(ri);
> +		return NULL;
> +	}
> +
> +	ri->cfg =3D pci_acpi_setup_ecam_mapping(root);
> +	if (!ri->cfg) {
> +		kfree(ri);
> +		kfree(root_ops);
> +		return NULL;
> +	}
> +
> +	root_ops->release_info =3D pci_acpi_generic_release_info;
> +	root_ops->prepare_resources =3D pci_acpi_root_prepare_resources;
> +	root_ops->pci_ops =3D (struct pci_ops *)&ri->cfg->ops->pci_ops;
> +	bus =3D acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
> +	if (!bus)
> +		return NULL;
> +
> +	/* If we must preserve the resource configuration, claim now */
> +	host =3D pci_find_host_bridge(bus);
> +	if (host->preserve_config)
> +		pci_bus_claim_resources(bus);
> +
> +	/*
> +	 * Assign whatever was left unassigned. If we didn't claim above,
> +	 * this will reassign everything.
> +	 */
> +	pci_assign_unassigned_root_bus_resources(bus);
> +
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +
> +	return bus;
> +}

Anyways, this does look to be "leveraged from arm64" as you say and I
only had minor nits to comment about...
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--pAMvRf+LG3lTC78u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+QToQAKCRB4tDGHoIJi
0olNAP9lp3WE8VCFaQckxPUKRtzrtdzfJ3ELelGbTEBAtUvOxgD+N9unferlze1j
9CtTXW5bLgdHZbiLIlkSAugaqVc7uwE=
=cnvy
-----END PGP SIGNATURE-----

--pAMvRf+LG3lTC78u--
