Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AFF743C91
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjF3NUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjF3NUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:20:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BEA3A81;
        Fri, 30 Jun 2023 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688131218; x=1719667218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EaJ77L8/k3Hf0KmA9VK9enDoW0KMpkjzS7BilECDl2A=;
  b=zNSTiHPPjPJnIj1KJ98izycMouV3yTak2XgvVfFNuQVlPdS3pyVLRVD3
   VQw5eUu+Al+WkJdlc2ICzdhXPP8ADplTCogp33X9TGZwb9WEjKC3XBMbf
   OJlQgBHmoWX1H0eDEgkPJSAbUutgSTmOoTK4YEZnom2qDmMQxUHlBy1xL
   YEI4TWGwz7hpHg3XWtwgvjUDB050Q/5R4smaipRfk4jCgz2PHGRkIYZhd
   wAsDQrMut1PiCXw5d48s6ghJOuCv9uv1md2EKYwrlL50tFoy9O7y7T90t
   yN1HiVmViVMBj5BTj7BdO2IxPQdjOumvDDtiQM5OmhDMo5WZzBAHV+pS4
   w==;
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="asc'?scan'208";a="221422464"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2023 06:20:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 30 Jun 2023 06:20:17 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 30 Jun 2023 06:20:15 -0700
Date:   Fri, 30 Jun 2023 14:19:46 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>, <sunilvl@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] RISC-V: provide a Kconfig option to disable
 parsing "riscv,isa"
Message-ID: <20230630-urgency-emission-882cd52a7a27@wendy>
References: <20230629-landed-popsicle-ab46ab3b46d9@spud>
 <mhng-f060b5c8-aa99-4952-b1e1-ee85a92e6b07@palmer-ri-x1c9a>
 <20230629-angled-gallantly-8fe7451a25fa@spud>
 <20230630-7d0f6fe66c9415315d491f15@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o4a1LRPZt0ieGy5D"
Content-Disposition: inline
In-Reply-To: <20230630-7d0f6fe66c9415315d491f15@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--o4a1LRPZt0ieGy5D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 09:46:48AM +0200, Andrew Jones wrote:
> On Thu, Jun 29, 2023 at 10:44:18PM +0100, Conor Dooley wrote:
> > On Thu, Jun 29, 2023 at 02:16:49PM -0700, Palmer Dabbelt wrote:
> > > On Thu, 29 Jun 2023 13:20:55 PDT (-0700), Conor Dooley wrote:
> ...
> > > > +bool __initdata riscv_isa_fallback_cmdline =3D false;
> > > > +static int __init riscv_isa_fallback_setup(char *__unused)
> > >=20
> > > Maybe it's better to support =3Dtrue and =3Dfalse here?  Not sure it =
matters,
> > > we're already down a rabbit hole ;)
> >=20
> > Dunno, not implemented a cmdline param before. Seemed "cleaner" to check
> > for presence, don't really care so I'll adapt to w/e.
> >
>=20
> I don't have a strong preference here, but to throw in more food for
> thought, I see this DT-v1 vs. DT-v2 choice to be a bit analogous to the
> DT vs. ACPI choice. The 'acpi' command line parameter, for RISC-V, can
> be 'off', 'on', and 'force', where
>=20
>   off -- disable ACPI if default was on
>   on -- enable ACPI but allow fallback to DT
>   force -- enable ACPI if default was off
>=20
> So, if the default of the isa fallback command line option will depend on
> Kconfig, then we may also want a 'force'.

I'm not sure that I understand what "force" would give us.
There's 4 cases:
- CONFIG_RISCV_ISA_FALLBACK is enabled, cmdline option is present:
  cmdline option is ignored, fallback is taken if needed.
  crash if neither are present.

- CONFIG_RISCV_ISA_FALLBACK is enabled, cmdline option is not present:
  cmdline option is ignored, fallback is taken if needed.
  crash if neither are present.

- CONFIG_RISCV_ISA_FALLBACK is disabled, cmdline option is present:
  cmdline option takes priority, fallback is taken if needed.
  crash if neither are present.

- CONFIG_RISCV_ISA_FALLBACK is disabled, cmdline option is not present:
  fallback is never taken
  crash if new properties aren't present.

I don't really see the value in having an equivalent to acpi=3Doff,
because the order of precedence is, to use your naming, "DT-v2" falling
back to "DT-v1" & the default value concerns the use of the fallback.
For ACPI, it is the other way around & the option controls the use of
"DT-v2"'s analogue. Trying to slot in that logic:

- CONFIG_RISCV_ISA_FALLBACK is enabled, cmdline option "=3Don":
  cmdline option is ignored, fallback is taken if needed.
  crash if neither are present.

- CONFIG_RISCV_ISA_FALLBACK is enabled, cmdline option "=3Doff":
  cmdline option is prioritised, fallback is taken if needed.
  crash if new properties aren't present.

- CONFIG_RISCV_ISA_FALLBACK is disabled, cmdline option "=3Don":
  cmdline option is prioritised, fallback is taken if needed.
  crash if neither are present.

- CONFIG_RISCV_ISA_FALLBACK is disabled, cmdline option "=3Doff":
  fallback is never taken
  crash if new properties aren't present.

I think I prefer the behaviour of what I currently have & I don't really
get where the "force" option is supposed to fit in either?

Cheers,
Conor.

--o4a1LRPZt0ieGy5D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ7WZwAKCRB4tDGHoIJi
0gMcAQChwEuzvhSORcS7/4Mm0GXlyvRmOlOfWOHtGmwWRFmLMgD+JzMMaxJwKmej
f/W/6SoUrX44MMben0skWQdfEYtTNQo=
=N0ZM
-----END PGP SIGNATURE-----

--o4a1LRPZt0ieGy5D--
