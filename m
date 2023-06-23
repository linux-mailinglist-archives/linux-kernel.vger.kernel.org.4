Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4F73B35F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFWJT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjFWJTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:19:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDCAC2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687511989; x=1719047989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XGiyyAs9cVt4Aoql04BBBGaqkZFGdvDDQCfl0RCfgVg=;
  b=tP5HEbPNOZGKoY5eSxohED0r/D0iThyAxzJbb7rA4Fp8wuHjCgeMKci9
   PNqMZ0LX6jD2cm4fm4RG1ZJ90QXMIngtF5JNy3+/SEKGFadHQhcbfrv0O
   ttOPjFSDa6weWgp+pe20SyvoL2BrJeVTQrIWXOtv+fJVXXDxBuveCcVti
   xrtb+iaoIT+l9NwCQccMBhF8IzdGBQSPjLgJ7ZUBUa4TLgSZ8zn3qYeX8
   QUwNZiGbZX5DClnmKggkmwA/GvfAZxWYMYqQ/ytw9DjHoW2NE2w9FwmV7
   olDSRfecFJkisCPOjnuzYFHV1AiYVMqDSjt50x7A1EB/tUE0zc1kPORh6
   w==;
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="asc'?scan'208";a="220110214"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2023 02:19:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 23 Jun 2023 02:19:37 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 23 Jun 2023 02:19:35 -0700
Date:   Fri, 23 Jun 2023 10:19:08 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Heiko Stuebner <heiko@sntech.de>
CC:     <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>, <samuel@sholland.org>,
        <guoren@kernel.org>, <christoph.muellner@vrull.eu>,
        <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v2 2/3] RISC-V: move vector-available status into a
 dedicated variable
Message-ID: <20230623-celestial-vitality-f4a564208b7b@wendy>
References: <20230622231305.631331-1-heiko@sntech.de>
 <20230622231305.631331-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dIb/j54IQUnxjZNI"
Content-Disposition: inline
In-Reply-To: <20230622231305.631331-3-heiko@sntech.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dIb/j54IQUnxjZNI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Heiko,

On Fri, Jun 23, 2023 at 01:13:04AM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>=20
> There is at least one core implementing the wrong vector specification,
> which cannot claim to implement the v extension but still is able to
> do vectors similar to v.
>=20
> To not hack around this by claiming to do v, move the has_vector() return
> to act similar to riscv_noncoherent_supported() and move to a separate
> variable that can be set for example from errata code.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/include/asm/vector.h | 5 ++++-
>  arch/riscv/kernel/setup.c       | 6 ++++++
>  arch/riscv/kernel/vector.c      | 8 ++++++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index 04c0b07bf6cd..315c96d2b4d0 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -19,13 +19,16 @@
>  #include <asm/csr.h>
>  #include <asm/asm.h>
> =20
> +extern bool riscv_v_supported;
> +void riscv_vector_supported(void);
> +
>  extern unsigned long riscv_v_vsize;
>  int riscv_v_setup_vsize(void);
>  bool riscv_v_first_use_handler(struct pt_regs *regs);
> =20
>  static __always_inline bool has_vector(void)
>  {
> -	return riscv_has_extension_unlikely(RISCV_ISA_EXT_v);
> +	return riscv_v_supported;

Since you're moving this thing away from being backed by an alternative,
should this variable then be marked with something like __ro_after_init?

Cheers,
Conor.

>  }
> =20
>  static inline void __riscv_v_vstate_clean(struct pt_regs *regs)
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 971fe776e2f8..952dfb90525e 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -36,6 +36,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/kasan.h>
>  #include <asm/efi.h>
> +#include <asm/vector.h>
> =20
>  #include "head.h"
> =20
> @@ -308,6 +309,11 @@ void __init setup_arch(char **cmdline_p)
>  	riscv_fill_hwcap();
>  	init_rt_signal_env();
>  	apply_boot_alternatives();
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_V) &&
> +	    riscv_isa_extension_available(NULL, v))
> +		riscv_vector_supported();
> +
>  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
>  	    riscv_isa_extension_available(NULL, ZICBOM))
>  		riscv_noncoherent_supported();
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index f9c8e19ab301..74178fb71805 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -22,6 +22,9 @@
> =20
>  static bool riscv_v_implicit_uacc =3D IS_ENABLED(CONFIG_RISCV_ISA_V_DEFA=
ULT_ENABLE);
> =20
> +bool riscv_v_supported;
> +EXPORT_SYMBOL_GPL(riscv_v_supported);
> +
>  unsigned long riscv_v_vsize __read_mostly;
>  EXPORT_SYMBOL_GPL(riscv_v_vsize);
> =20
> @@ -274,3 +277,8 @@ static int riscv_v_init(void)
>  	return riscv_v_sysctl_init();
>  }
>  core_initcall(riscv_v_init);
> +
> +void riscv_vector_supported(void)
> +{
> +	riscv_v_supported =3D true;
> +}
> --=20
> 2.39.2
>=20

--dIb/j54IQUnxjZNI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJVjeAAKCRB4tDGHoIJi
0u32AQCEH5dh46wYlzcytvlmzGZZ1ELU0VlUt4hnRxFArrW7TgEAgd5IEQlWTbuA
Jr3XQI6Op3zOmHf4p98etsTEV6rDrwo=
=y0Xk
-----END PGP SIGNATURE-----

--dIb/j54IQUnxjZNI--
