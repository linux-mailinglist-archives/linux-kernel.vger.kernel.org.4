Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82CC6CA29C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjC0Lii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC0Lif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:38:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E361734
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679917112; x=1711453112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q2B4kA6um1AUrS22dRB1g2bdoajEizZ7FOgCaLz1DVw=;
  b=WjARYSDWoKmASnnfQaQpcuhTJg24Pld/nFPdY4iZNiFuYFVA7PhtaPWq
   o8ob0ruAXZJAZTXbYzjbRSkS2iiP2SDugIZpEcnb/STrFuLtIw0vFoRFf
   votA0CWUowQW+4Tu1OBi3usglpiDP34wU/Y08ytrWTr63PZYrP/CQsmNP
   TCA6x/QDMF0IbFTuyprbrkgEhpD4rmVp+mP/OvT597pEB95LFhCwzXz1s
   HSfLnRiKx1/kD2o5CV4ldN70R8EoYrFMUXNOh1H96nJmSOh2nkCWLF3qA
   V91fUBK/Gst7eTbsTCAMH2nPPomTR2x7O/uASswSCiv5RHSEoKOCbNzsR
   w==;
X-IronPort-AV: E=Sophos;i="5.98,294,1673938800"; 
   d="asc'?scan'208";a="207407574"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2023 04:38:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 04:38:28 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Mar 2023 04:38:27 -0700
Date:   Mon, 27 Mar 2023 12:49:44 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bjorn@kernel.org>
Subject: Re: [PATCH V2] riscv: export cpu/freq invariant to scheduler
Message-ID: <b6d48638-92b6-4406-b472-90d3d53b021f@spud>
References: <20230323123924.3032174-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Edl0/TOuOami8mTi"
Content-Disposition: inline
In-Reply-To: <20230323123924.3032174-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Edl0/TOuOami8mTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+CC Bjorn,

On Thu, Mar 23, 2023 at 08:39:24PM +0800, Song Shuai wrote:
> RISC-V now manages CPU topology using arch_topology which provides
> CPU capacity and frequency related interfaces to access the cpu/freq
> invariant in possible heterogeneous or DVFS-enabled platforms.
>=20
> Here adds topology.h file to export the arch_topology interfaces for
> replacing the scheduler's constant-based cpu/freq invariant accounting.
>=20
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>

Something in CI really, really doesn't like this patch:
https://patchwork.kernel.org/project/linux-riscv/patch/20230323123924.30321=
74-1-suagrfillet@gmail.com/

The CI stuff applies the patch, builds the tree, resets to HEAD~1,
builds it again, goes back to the applied patch and builds a third time.
Builds 2 and 3 are incremental.
In theory the same stuff should change between applying and removing the
patch, and therefore each of builds 2 and 3 should have the same coverage,
but that doesn't seem to be happening here.
Build 2 looks to have rebuilt almost nothing and build 3 has rebuilt the
world.
I'm gonna chalk that one down as a CI issue rather than your patch!

That said, I was wondering if you would end up submitting this patch,
given the discussion on your last one ;)

Looks to be the same as was done for arm64, so fwiw:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
> changes from V1:
>   - fix the leading underscore and tidy the patch up=20
> ---
>  arch/riscv/include/asm/topology.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 arch/riscv/include/asm/topology.h
>=20
> diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/t=
opology.h
> new file mode 100644
> index 000000000000..727e8d163a3b
> --- /dev/null
> +++ b/arch/riscv/include/asm/topology.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_TOPOLOGY_H
> +#define _ASM_RISCV_TOPOLOGY_H
> +
> +#include <linux/arch_topology.h>
> +
> +/* Replace task scheduler's default frequency-invariant accounting */
> +#define arch_scale_freq_tick	topology_scale_freq_tick
> +#define arch_set_freq_scale	topology_set_freq_scale
> +#define arch_scale_freq_capacity	topology_get_freq_scale
> +#define arch_scale_freq_invariant	topology_scale_freq_invariant
> +
> +/* Replace task scheduler's default cpu-invariant accounting */
> +#define arch_scale_cpu_capacity	topology_get_cpu_scale
> +
> +/* Enable topology flag updates */
> +#define arch_update_cpu_topology	topology_update_cpu_topology
> +
> +#include <asm-generic/topology.h>
> +#endif /* _ASM_RISCV_TOPOLOGY_H */
> --=20
> 2.20.1
>=20
>=20

--Edl0/TOuOami8mTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCGC2AAKCRB4tDGHoIJi
0l+xAP0XEpkCEwAle/m9iBKU+5bYreUYM96+rKjw0G4g24GPGgEAxMrUg2z+QaPq
gEVLcP4H1EF+3p8QDiDa+tdyUjhgyA0=
=noGV
-----END PGP SIGNATURE-----

--Edl0/TOuOami8mTi--
