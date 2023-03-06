Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68776ACF21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCFU06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCFU05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:26:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D36EB3;
        Mon,  6 Mar 2023 12:26:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD7CCB8108B;
        Mon,  6 Mar 2023 20:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD787C433D2;
        Mon,  6 Mar 2023 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678134413;
        bh=IgrsSBvQN4ROvRo5O3phazhRtEEiAn3qxcpkRoyKDvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWMLE5PfWhbV12VdnLkTA8CFqUi7eNYS3U7vVBLBRDJ7GOR8hm0h+Ys2xK4tjwVzG
         fEKUEJv/qzaWx3dsYNNvGsGhW07KHuvdad81fYXpI4FB/asY/svnX/gUkpflDD6drM
         sUhh13qetPkAvYTO+JLZVCNBIjsYCMQyjE6akilIDjCSnkksi86kLqnCKGK8nr2fER
         B3onZiM2rDcUbKWxqtJ+NFrfvpJ8QLWOaiuFgZ67ONa+8dA4tmDZMImL4wxSc7NMiy
         7HWpSdasoKYMZe+7m1vbIkPKo+aYVAdxj4/RoqED/k9GiGk82lxAxL15TNfoPQVLbB
         rtR7bF2dVMLaA==
Date:   Mon, 6 Mar 2023 20:26:47 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 12/20] RISC-V: cpufeature: Add ACPI support in
 riscv_fill_hwcap()
Message-ID: <ea37af34-ccb9-4b6a-a67c-a17f03fc0311@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-13-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8PADbTt3DS+5vFB"
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-13-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8PADbTt3DS+5vFB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 07:06:39PM +0530, Sunil V L wrote:
> On ACPI based systems, the information about the hart
> like ISA is provided by the RISC-V Hart Capabilities Table (RHCT).
> Enable filling up hwcap structure based on the information in RHCT.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

With Drew's split out of the riscv_of_processor_hartid() removal and his
acpi_get_riscv_isa()-takes-a-cpu suggestion:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--a8PADbTt3DS+5vFB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAZMhwAKCRB4tDGHoIJi
0nABAQCnF38Bn91wkehg27V7pP0e84DW4kc9w5CHtUNPsU8ruAEAkX7FZy7UJEOR
dWOFx+i4IeK+2UNEiKaPlMuO32y/xAY=
=bGRd
-----END PGP SIGNATURE-----

--a8PADbTt3DS+5vFB--
