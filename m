Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB8E742683
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjF2Mev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjF2MeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:34:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A8A26B6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688042060; x=1719578060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V3orB8X2pnGHKa4XQHvRaYEdUceUMOeLKtK+nBaNFd8=;
  b=Cq3m0wKL5ftIk7Q98ZHuGr1ZpIwXWpKzCfqqclo8wyGgSOPuUUigPROH
   7h3+UgybnfzdGit2wNkeDTszUQXRu82qb/s9WEZ8DKkLNWYBObwCfW6OY
   RszA4AUqEAx0EoTN3PdN8z5vkcNnmZMtM0G/daXKiAlsFKIt6sbJftUYA
   51bxyAsLjR6mS8oAepWutXQNSll3P7AQkqg7cGksb3VaTlDTy1FLa31tr
   3seQF+UEvWE8jOH3Y6Cp3eritNkyecAf7XOgDFDQigiTN3Hmv19iGNRZ6
   D1kdgHQpZhr6dDMNU/VIl/ijXPKqsijfMRaeytLNDbasrq7XMPpaCHwpT
   g==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="asc'?scan'208";a="220483366"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 05:34:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 05:34:19 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 05:34:17 -0700
Date:   Thu, 29 Jun 2023 13:33:48 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <ajones@ventanamicro.com>,
        <sunilvl@ventanamicro.com>, <heiko.stuebner@vrull.eu>,
        <apatel@ventanamicro.com>, <evan@rivosinc.com>,
        <greentime.hu@sifive.com>, <leyfoon.tan@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: BUG_ON() for no cpu nodes in setup_smp
Message-ID: <20230629-maverick-kelp-17327f04482a@wendy>
References: <20230629105839.1160895-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+Xe4Uyu39cOMQrN6"
Content-Disposition: inline
In-Reply-To: <20230629105839.1160895-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+Xe4Uyu39cOMQrN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Jun 29, 2023 at 06:58:39PM +0800, Song Shuai wrote:
> When booting with ACPI tables, the tiny devictree created by
> EFI Stub doesn't provide cpu nodes.

What are the conditions that are required to reproduce this issue?
When booting with ACPI, why is acpi_disabled true?
In my naivety, that seems like a bigger problem to address..

> In setup_smp(), of_parse_and_init_cpus() will bug on !found_boot_cpu

Please, s/on !found_boot_cpu/if the boot cpu is not found in the
devicetree/, or similar.

> if acpi_disabled.

Why would of_parse_and_init_cpus() be called in any other case? There's
only this one caller, right?

> That's unclear, so bug for no cpu nodes before
> of_parse_and_init_cpus().

What is unclear? That the reason for the BUG() was that there were no
cpu nodes, since it could also be that there were CPU nodes but they
were disabled etc?

> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/kernel/smpboot.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 6ca2b5309aab..243a7b533ad7 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -187,8 +187,13 @@ static void __init of_parse_and_init_cpus(void)
> =20
>  void __init setup_smp(void)
>  {
> -	if (acpi_disabled)
> +	if (acpi_disabled) {
> +		/* When booting with ACPI tables, the devictree created by EFI Stub

This is not netdev, please use the correct comment style :/

> +		 * doesn't provide cpu nodes. So BUG here for any acpi_disabled.
> +		 */
> +		BUG_ON(!of_get_next_cpu_node(NULL));
>  		of_parse_and_init_cpus();
> +	}
>  	else
>  		acpi_parse_and_init_cpus();

checkpatch should have told you that you now need to add braces on all
arms of this statement.

Or, better yet, move the whole thing into of_parse_and_init_cpus() in
the first place? You could drop most of the comment in the process,
since I think the details of how you hit this problem would likely not
be helpful to anyone that hit it under different conditions.

Cheers,
Conor.

>  }
> --=20
> 2.20.1
>=20

--+Xe4Uyu39cOMQrN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ16LAAKCRB4tDGHoIJi
0kjfAQDJJ0vTpSJCysk3tWFZuO7Zk8aSbHHO0s+tldla0nXdZAD5AYH55vxAQeSf
VUtbo0CsM0uDGuFly0pPfOcvM0iKOgA=
=JAVg
-----END PGP SIGNATURE-----

--+Xe4Uyu39cOMQrN6--
