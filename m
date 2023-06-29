Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4811742512
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjF2Lkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjF2Lk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:40:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C83D10F0;
        Thu, 29 Jun 2023 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688038826; x=1719574826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sAr1yW8ms9qKdVY87lLEN9RPbOLSC7vvBYXs60c7FDI=;
  b=u05q+pJZZssCqlezI/w0BorKOqAo/eiI4+c4cyMhF6eCF21w0OQAKVmr
   /M/3XeCEudZ6hlVS0vZgCclrsj3rdKedet0Wa/2F5ROnBpDB4GZZrr3hR
   rYF9LUFlcWIyYoAhfD4fpjjsMKldxgmRc+cepWnSHB1vfR0EY+uMwkdA4
   3wdGXcApbpMVjQArj5MjHdDEI6dOvvuwRnQbiC3M4TUz8HEPfQ0ZjpMx/
   gjsxRkqi+Mry7iUMawm9vkCzwZymZr9ZYIt2VnNKP1tmuBjwCaCTgi7qv
   nyKsLuB2ctlqgD7zHUfg6NMV3LskL/cQya9LnmSbs9pXtdd5Cz0HWdKlB
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="asc'?scan'208";a="218175038"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 04:40:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 04:40:22 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 04:40:20 -0700
Date:   Thu, 29 Jun 2023 12:39:51 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     <palmer@dabbelt.com>, <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v2 10/10] RISC-V: provide a Kconfig option to disable
 parsing "riscv,isa"
Message-ID: <20230629-deceit-macarena-2a744ac70148@wendy>
References: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
 <20230629-resilient-grievance-d782163b09d6@wendy>
 <20230629-a80f112e6ed4158080867694@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Sze7hK0PNyYVfnYw"
Content-Disposition: inline
In-Reply-To: <20230629-a80f112e6ed4158080867694@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sze7hK0PNyYVfnYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 11:31:33AM +0200, Andrew Jones wrote:
> On Thu, Jun 29, 2023 at 09:28:56AM +0100, Conor Dooley wrote:
> > As it says on the tin, provide a Kconfig option to disabling parsing the
> > "riscv,isa" devicetree property. Hide the option behind NONPORTABLE so
> > that only those willing to keep the pieces enable it, and make sure the
> > default kernel contains the fallback code.
> >=20
> > Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/Kconfig             | 16 ++++++++++++++++
> >  arch/riscv/kernel/cpu.c        |  3 +++
> >  arch/riscv/kernel/cpufeature.c |  2 +-
> >  3 files changed, 20 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 1d39efe2b940..0e1909ac5947 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -291,6 +291,22 @@ config NONPORTABLE
> > =20
> >  	  If unsure, say N.
> > =20
> > +config NO_RISCV_ISA_FALLBACK
> > +	bool "Permit falling back to parsing riscv,isa for extension support"
> > +	depends on NONPORTABLE
> > +	help
> > +	  Parsing the "riscv,isa" devicetree property has been deprecated and
> > +	  replaced by a list of explicitly defined strings. For compatibility
> > +	  with existing platforms, the kernel will fall back to parsing the
> > +	  "riscv,isa" property if the replacements are not found.
> > +
> > +	  Selecting Y here will result in a kernel without this fallback, and
> > +	  will not work on platforms where the devicetree does not contain the
> > +	  replacement 	  properties of "riscv,isa-base" and
>                      ^ spacing issue

Huh, weird. Given the tab followed by spaces, it must have snuck in
during reflow of the text after some rewording.
Wonder how I missed it, given that...

> Should we also have a kernel command line option, 'isa_fallback', where
> without this config the command line option is not necessary to fallback,
> but, with this config, no fallback will be done unless 'isa_fallback' is
> provided?

I don't know, maybe I have the wrong end of the stick but it feels a bit
premature for something that may never not be hidden behind NONPORTABLE?
Perhaps that could be left for a point in time where the default value
of the symbol changes, or the dependency on NONPORTABLE is removed?

Cheers,
Conor.

--Sze7hK0PNyYVfnYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ1thwAKCRB4tDGHoIJi
0vzDAQDP9JlWlUGwMAoSKSxFjb6GGIDX8Mbn07UsWcWTcqMgAgD+JkZNTy1Vf7gU
LgyClwNQJHHQVT0Xj7BVnlyqzAn93Aw=
=bH7a
-----END PGP SIGNATURE-----

--Sze7hK0PNyYVfnYw--
