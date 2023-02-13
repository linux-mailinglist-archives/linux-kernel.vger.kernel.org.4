Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CE9694DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBMRO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjBMROW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:14:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0D61C5B4;
        Mon, 13 Feb 2023 09:14:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 678B96120C;
        Mon, 13 Feb 2023 17:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9709FC433EF;
        Mon, 13 Feb 2023 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676308460;
        bh=RkBn+EgRto+hmgpE2gQsAE6PgkVzQwCEhp8Ja4WbBSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNVbNcAPNfcwog/A5CdIWs2f3/q0e89mJw3M/fRVwaDjYc1ZOvGrXOJuHP543sbV3
         QDNHcRGe3tjDCCehkpIqHsA5eQCQJuyc4S/nUcFSpr+LVr4POcVa96LXRzoMlD2sV1
         IzoUOCdb8ZBOQ0LmgJgO5KY9sIja8UyH88ezxrbWFa6gk3TmCaJLw5NwOaggKZGaep
         53W9GDBlNqjOlo6LPT0gDvoGyGSnqS6yKhyIH6t+TjJxTvbzhHVUyVXb282TI/NMMd
         ZDl9vWsVIo/LwzWWMxX1bCrC+W1TY17rOVBAtfH42FY30NHz/RrofpOvVqdufzC1dX
         fqpBQj4D0tFKw==
Date:   Mon, 13 Feb 2023 17:14:15 +0000
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
Message-ID: <Y+pv5yefi3xYfLt1@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-7-sunilvl@ventanamicro.com>
 <Y+QToXO2kYQ2ipdz@spud>
 <Y+pV1aafHUNP6QfU@sunil-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UmPzDpczqd5I7ZHh"
Content-Disposition: inline
In-Reply-To: <Y+pV1aafHUNP6QfU@sunil-laptop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UmPzDpczqd5I7ZHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 08:53:01PM +0530, Sunil V L wrote:
> On Wed, Feb 08, 2023 at 09:26:57PM +0000, Conor Dooley wrote:
> > On Mon, Jan 30, 2023 at 11:52:07PM +0530, Sunil V L wrote:

> > > +/*
> > > + * Lookup the bus range for the domain in MCFG, and set up config sp=
ace
> > > + * mapping.
> > > + */
> > > +static struct pci_config_window *
> > > +pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
> >=20
> > This all fits on 1 line.
> >=20
> It actually goes beyond 80 characters, right?

100 chars is the limit :)

--UmPzDpczqd5I7ZHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+pv5wAKCRB4tDGHoIJi
0mKhAQDrj8O8lI6jdzx/eHAiCr2CbVDULMK6x53p1/fhcJI7wAD+OWuhz8aeys1U
u1nGrlAy/YPBtu3+qPTbE+jWT1BDJgs=
=JgRA
-----END PGP SIGNATURE-----

--UmPzDpczqd5I7ZHh--
