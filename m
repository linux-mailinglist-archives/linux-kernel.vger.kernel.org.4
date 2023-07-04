Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E60746A59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGDHNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGDHNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:13:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF543130;
        Tue,  4 Jul 2023 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688454802; x=1719990802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3R780gSrSJ9nAhXyLdyPKWWj43EVLHOBBiNKAgvxGrU=;
  b=xPW1IBOORPmY3AuH7XsIYwZRSENfZZUi9dRsE800lejI+z7DiDjMLfx9
   IUTXAiVKfSHQ+7NV3wMjOhePoG4OlcxXtqhTHytbLsaXWakwQrlkIS3Q4
   uxYBBAmS/gWYJwZq8DTIMYkuq+NWolEcbTmb8vQIqHqI4ABzAz8aNOBNb
   sMi04JZHGfR4xram/dOvPB1EP2Ph8yOv8j2zmquNSyYcScqJw5LuX4KsH
   CMQzSRzfWgiqlR8EJv73wJdKnHhq+Bl79ezYm1l52yuEoVpg5QYXwpuLr
   BtGicCDG5FUBb1+RNfzDFID7tAmgb7l06I1Zxe8yAu4oKIFouB2LmhwYE
   g==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="asc'?scan'208";a="221180429"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2023 00:13:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Jul 2023 00:13:21 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 4 Jul 2023 00:13:18 -0700
Date:   Tue, 4 Jul 2023 08:12:49 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v3 11/11] RISC-V: provide Kconfig & commandline options
 to control parsing "riscv,isa"
Message-ID: <20230704-surely-defective-c55f6341127c@wendy>
References: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
 <20230703-greedy-dividable-251fa2b809ac@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M4y9ClbXh4dwVo7F"
Content-Disposition: inline
In-Reply-To: <20230703-greedy-dividable-251fa2b809ac@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--M4y9ClbXh4dwVo7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 11:28:03AM +0100, Conor Dooley wrote:
> As it says on the tin, provide Kconfig option to control parsing the
> "riscv,isa" devicetree property. If either option is used, the kernel
> will fall back to parsing "riscv,isa", where "riscv,isa-base" and
> "riscv,isa-extensions" are not present.
> The Kconfig options are set up so that the default kernel configuration
> will enable the fallback path, without needing the commandline option.
>=20
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v3:
> - Invert the Kconfig entry. It's now default y & not hidden by
>   NONPORTABLE, but its entablement will now activate the fallback
> - Add a commandline option to enable the fallback on kernels that do not
>   enable it in Kconfig, as Drew suggested
> - Default the global var to the Kconfig option & override it with the
>   commandline one, rather than have checks for IS_ENABLED() and for the
>   commandline option in riscv_fill_hwcap() &
>   riscv_early_of_processor_hartid()

My own bot reports a build failure for nommu, because of section
mismatches. riscv_early_of_processor_hartid() needs a dose of __init:

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 1acf3679600d..208f1a700121 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -41,7 +41,7 @@ int riscv_of_processor_hartid(struct device_node *node, u=
nsigned long *hart)
 	return 0;
 }
=20
-int riscv_early_of_processor_hartid(struct device_node *node, unsigned lon=
g *hart)
+int __init riscv_early_of_processor_hartid(struct device_node *node, unsig=
ned long *hart)
 {
 	const char *isa;
=20
Good aul nommu build, always the one that catches stuff :)

--M4y9ClbXh4dwVo7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKPGXQAKCRB4tDGHoIJi
0rg5AP9PY2fBP1Bcb1QnerRLwimjm13N3bl6EFsys6XQFXHKGgEA1IWYAyQyJYZo
ePxSXe208Sl91eEjos5oE0IwX0ipbgQ=
=YbUb
-----END PGP SIGNATURE-----

--M4y9ClbXh4dwVo7F--
