Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8461B742F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjF2Vo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjF2Vo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:44:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F432D71;
        Thu, 29 Jun 2023 14:44:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61440615D8;
        Thu, 29 Jun 2023 21:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E95C433C8;
        Thu, 29 Jun 2023 21:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688075063;
        bh=rp6hpoVxlllNoMAJLp+Lmnh4HU1PyID2eHP/qrWpoF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7B6ybNki/JJRvaZPrb4SWWoBNu7j4kW/ysTdm3G8tXhlxIfqKgF0SdbssXKO6lro
         jVRqSmmLmajDdpWQVlqTapszK49PkIF6jMHmCgbctzcI5TXjCZwz+7k/8t88UQ3gqt
         NczHhzyXT71AE+h40HBRiNSR7wnZDmEj5qiq4F1QlJXKEK1EtKi5Xek5GukmQ+TzMp
         z6ves5iNJnov+oHBIT3BGHoDFM2J3v28Q90SvoFKHu2A37AQJZ3n3UCV5gtZNIqBMo
         FPL87/sNcDr21LLMuzZGf0/l2WOTVEC+KmXYdLuCQkQ7xASvADvZNY3bFkQjV58D7l
         0slLCraWD/TgQ==
Date:   Thu, 29 Jun 2023 22:44:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     ajones@ventanamicro.com, Conor Dooley <conor.dooley@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, heiko.stuebner@vrull.eu,
        Evan Green <evan@rivosinc.com>, sunilvl@ventanamicro.com,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] RISC-V: provide a Kconfig option to disable
 parsing "riscv,isa"
Message-ID: <20230629-angled-gallantly-8fe7451a25fa@spud>
References: <20230629-landed-popsicle-ab46ab3b46d9@spud>
 <mhng-f060b5c8-aa99-4952-b1e1-ee85a92e6b07@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NhGwwuXLQmoFWz13"
Content-Disposition: inline
In-Reply-To: <mhng-f060b5c8-aa99-4952-b1e1-ee85a92e6b07@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NhGwwuXLQmoFWz13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 02:16:49PM -0700, Palmer Dabbelt wrote:
> On Thu, 29 Jun 2023 13:20:55 PDT (-0700), Conor Dooley wrote:
> > On Thu, Jun 29, 2023 at 03:53:08PM +0200, Andrew Jones wrote:
> > > On Thu, Jun 29, 2023 at 12:39:51PM +0100, Conor Dooley wrote:
> > > > On Thu, Jun 29, 2023 at 11:31:33AM +0200, Andrew Jones wrote:
> > > > > On Thu, Jun 29, 2023 at 09:28:56AM +0100, Conor Dooley wrote:
> > > > > > As it says on the tin, provide a Kconfig option to disabling pa=
rsing the
> > > > > > "riscv,isa" devicetree property. Hide the option behind NONPORT=
ABLE so
> > > > > > that only those willing to keep the pieces enable it, and make =
sure the
> > > > > > default kernel contains the fallback code.
> > > > > > > > > Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > > ---
> > > > > >  arch/riscv/Kconfig             | 16 ++++++++++++++++
> > > > > >  arch/riscv/kernel/cpu.c        |  3 +++
> > > > > >  arch/riscv/kernel/cpufeature.c |  2 +-
> > > > > >  3 files changed, 20 insertions(+), 1 deletion(-)
> > > > > > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > > index 1d39efe2b940..0e1909ac5947 100644
> > > > > > --- a/arch/riscv/Kconfig
> > > > > > +++ b/arch/riscv/Kconfig
> > > > > > @@ -291,6 +291,22 @@ config NONPORTABLE
> > > > > >  > > >  	  If unsure, say N.
> > > > > >  > > > +config NO_RISCV_ISA_FALLBACK
> > > > > > +	bool "Permit falling back to parsing riscv,isa for extension =
support"
> > > > > > +	depends on NONPORTABLE
> > > > > > +	help
> > > > > > +	  Parsing the "riscv,isa" devicetree property has been deprec=
ated and
> > > > > > +	  replaced by a list of explicitly defined strings. For compa=
tibility
> > > > > > +	  with existing platforms, the kernel will fall back to parsi=
ng the
> > > > > > +	  "riscv,isa" property if the replacements are not found.
> > > > > > +
> > > > > > +	  Selecting Y here will result in a kernel without this fallb=
ack, and
> > > > > > +	  will not work on platforms where the devicetree does not co=
ntain the
> > > > > > +	  replacement 	  properties of "riscv,isa-base" and
> > > > >                      ^ spacing issue
> > > > > Huh, weird. Given the tab followed by spaces, it must have snuck
> > > in
> > > > during reflow of the text after some rewording.
> > > > Wonder how I missed it, given that...
>=20
> I sometimes end up with these when reflowing in vim, the Kconfig help text
> indent confuses things (though many things confuse whatever vim reflowing
> I'm using, so I should probably find something better).

I did it by hand, I have no excuses.

> > > > > Should we also have a kernel command line option, 'isa_fallback',=
 where
> > > > > without this config the command line option is not necessary to f=
allback,
> > > > > but, with this config, no fallback will be done unless 'isa_fallb=
ack' is
> > > > > provided?
> > > > > I don't know, maybe I have the wrong end of the stick but it
> > > feels a bit
> > > > premature for something that may never not be hidden behind NONPORT=
ABLE?
> > > > Perhaps that could be left for a point in time where the default va=
lue
> > > > of the symbol changes, or the dependency on NONPORTABLE is removed?
> > > >
>=20
> I agree it might not be worth the work, but looks like that's done...

Well, whether I did it or not doesn't mean it has to be included in the
series. The work wasn't all that much to be honest.

> > > With the command line option, we could consider dropping NONPORTABLE =
(but
> > > still default off this config). What I'm thinking is that if we want =
to
> > > encourage the adoption of the new format, then there should be a bit =
of
> > > pain when it's not used, but not enough pain to risk rebellion. So,
> > >=20
> > >  * defconfig builds will silently/painlessly fallback
> > >=20
> > >  * builds that want to encourage adoption enable this config and will
> > >    fail to boot when they don't get what they want and don't have the
> > >    command line option
> > >=20
> > >  * users still working through the growing pains can manage when
> > >    the boot fails, and when it doesn't, with the command line
> >=20
> > So, something like the following squashed in? I inverted the config
> > option, seemed more natural that way.
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index d910fba25f2c..6c0d0bc06048 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5437,6 +5437,13 @@
> >  			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
> >  			CPUs.
> > +	riscv_isa_fallback [RISCV]
> > +			Fall back to detecting extension support using the
> > +			"riscv,isa" property on devicetree systems when the
> > +			replacement properties are not found, on kernels where
> > +			RISCV_ISA_FALLBACK is not enabled. See the Kconfig entry
> > +			for RISCV_ISA_FALLBACK.
> > +
> >  	ro		[KNL] Mount root device read-only on boot
> >  	rodata=3D		[KNL]
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0370713ad965..a9a473b67182 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -291,22 +291,6 @@ config NONPORTABLE
> >  	  If unsure, say N.
> > -config NO_RISCV_ISA_FALLBACK
> > -	bool "Permit falling back to parsing riscv,isa for extension support"
> > -	depends on NONPORTABLE
> > -	help
> > -	  Parsing the "riscv,isa" devicetree property has been deprecated and
> > -	  replaced by a list of explicitly defined strings. For compatibility
> > -	  with existing platforms, the kernel will fall back to parsing the
> > -	  "riscv,isa" property if the replacements are not found.
> > -
> > -	  Selecting Y here will result in a kernel without this fallback, and
> > -	  will not work on platforms where the devicetree does not contain the
> > -	  replacement properties of "riscv,isa-base" and "riscv,isa-extension=
s".
> > -	  Please see the dt-binding, located at
> > -	  Documentation/devicetree/bindings/riscv/extensions.yaml for details
> > -	  on the replacement properties.
> > -
> >  choice
> >  	prompt "Base ISA"
> >  	default ARCH_RV64I
> > @@ -857,6 +841,24 @@ config XIP_PHYS_ADDR
> >  	  be linked for and stored to.  This address is dependent on your
> >  	  own flash usage.
> > +config RISCV_ISA_FALLBACK
> > +	bool "Permit falling back to parsing riscv,isa for extension support =
by default"
> > +	default y
>=20
> I think the only risk here is that randconfig will result in systems that
> don't boot, but we're already stuck with no meaningful base requirements.
> Fixing that is a way bigger hurdle than this, so IMO it's fine.

Maybe I'm way off here, but I didn't think that we had to be worried
about randconfigs not booting, as it was a testing tool?

> > +	help
> > +	  Parsing the "riscv,isa" devicetree property has been deprecated and
> > +	  replaced by a list of explicitly defined strings. For compatibility
> > +	  with existing platforms, the kernel will fall back to parsing the
> > +	  "riscv,isa" property if the replacements are not found.
> > +
> > +	  Selecting N here will result in a kernel that does not use the
> > +	  fallback, unless the commandline "riscv_isa_fallback" parameter is
> > +	  present.
> > +
> > +	  Please see the dt-binding, located at
> > +	  Documentation/devicetree/bindings/riscv/extensions.yaml for details
> > +	  on the replacement properties of "riscv,isa-base" and
> > +	  "riscv,isa-extensions".
> > +
> >  endmenu # "Boot options"
> >  config BUILTIN_DTB
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index e3cda14a486b..52fa607a1691 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -81,6 +81,7 @@ struct riscv_isa_ext_data {
> >  extern const struct riscv_isa_ext_data riscv_isa_ext[];
> >  extern const size_t riscv_isa_ext_count;
> > +extern bool riscv_isa_fallback_cmdline;
> >=20
> >  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap=
);
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 86a1d98b8b3b..1e4cbdedc7fc 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -81,7 +81,7 @@ int riscv_early_of_processor_hartid(struct device_nod=
e *node, unsigned long *har
> >  	return 0;
> >  old_interface:
> > -	if (IS_ENABLED(CONFIG_NO_RISCV_ISA_FALLBACK))
> > +	if (!IS_ENABLED(CONFIG_RISCV_ISA_FALLBACK) && !riscv_isa_fallback_cmd=
line)
> >  		return -ENODEV;
> >  	if (of_property_read_string(node, "riscv,isa", &isa)) {
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index f6fb18d2af84..5d848b7c1dde 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -471,6 +471,14 @@ static int __init riscv_fill_hwcap_from_ext_list(u=
nsigned long *isa2hwcap)
> >  	return 0;
> >  }
> > +bool __initdata riscv_isa_fallback_cmdline =3D false;
> > +static int __init riscv_isa_fallback_setup(char *__unused)
>=20
> Maybe it's better to support =3Dtrue and =3Dfalse here?  Not sure it matt=
ers,
> we're already down a rabbit hole ;)

Dunno, not implemented a cmdline param before. Seemed "cleaner" to check
for presence, don't really care so I'll adapt to w/e.

> > +{
> > +	riscv_isa_fallback_cmdline =3D true;
> > +	return 1;
> > +}
> > +early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
>=20
> IMO it's cleaner to just set the default based on the Kconfig, that way
> there's only one thing to check.  We're already duplicating the "check bo=
th
> Kconfig and cmdline" logic twice, there's probably going to be others
> eventually.

Sure.

> > +
> >  void __init riscv_fill_hwcap(void)
> >  {
> >  	char print_str[NUM_ALPHA_EXTS + 1];
> > @@ -490,7 +498,7 @@ void __init riscv_fill_hwcap(void)
> >  	} else {
> >  		int ret =3D riscv_fill_hwcap_from_ext_list(isa2hwcap);
> > -		if (ret && !IS_ENABLED(CONFIG_NO_RISCV_ISA_FALLBACK)) {
> > +		if (ret && (IS_ENABLED(CONFIG_RISCV_ISA_FALLBACK) || riscv_isa_fallb=
ack_cmdline)) {
> >  			pr_info("Falling back to deprecated \"riscv,isa\"\n");
> >  			riscv_fill_hwcap_from_isa_string(isa2hwcap);
> >  		}
>=20
> I haven't read the whole patch set, but at least having a nice error for =
why
> probing didn't happen seems like the right way to go here.  IIUC this is
> just silent when ISA string fallbacks are disabled and the new properties
> aren't there.
>=20

> Sorry in advance if it's just somewhere outside the diff, though.

It sorta is. You'll actually not even reach this code if probing fails.
Because riscv_early_of_processor_hartid(), which is called super early
on in of_parse_and_init_cpus(), checks whether there are any valid
harts (including checking for sufficient extension support to run a
kernel) we will hit a BUG() during setup_smp() & blow up really early:

[    0.000000] Linux version 6.4.0-rc1-00096-ge0097d2c62d5-dirty (conor@spu=
d) (ClangBuiltLinux clang version 15.0.7 (/stuff/brsdk/llvm/clang 8dfdcc7b7=
bf66834a761bd8de445840ef68e4d1a), ClangBuiltLinux LLD 15.0.7) #1 SMP PREEMP=
T @666
[    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit
[    0.000000] SBI specification v0.3 detected
[    0.000000] SBI implementation ID=3D0x1 Version=3D0x10000
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] SBI SRST extension detected
[    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020100000 (options '1=
15200n8')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] printk: debug: skip boot console de-registration.
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x00000000bfc00000..0x00000000bfffffff (40=
96 KiB) nomap non-reusable region@BFC00000
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000107fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000bfbfffff]
[    0.000000]   node   0: [mem 0x00000000bfc00000-0x00000000bfffffff]
[    0.000000]   node   0: [mem 0x0000001040000000-0x000000107fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000107ffff=
fff]
[    0.000000] SBI HSM extension detected
[    0.000000] CPU with hartid=3D0 is not available
[    0.000000] ------------[ cut here ]------------
[    0.000000] kernel BUG at arch/riscv/kernel/smpboot.c:174!
[    0.000000] Kernel BUG [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.4.0-rc1-00096-ge00=
97d2c62d5-dirty #1
[    0.000000] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
[    0.000000] epc : of_parse_and_init_cpus+0x16c/0x16e
[    0.000000]  ra : of_parse_and_init_cpus+0x9a/0x16e
[    0.000000] epc : ffffffff80c04e0a ra : ffffffff80c04d38 sp : ffffffff81=
603e20
[    0.000000]  gp : ffffffff8182d658 tp : ffffffff81613f80 t0 : 0000000000=
00006e
[    0.000000]  t1 : 0000000000000064 t2 : 0000000000000000 s0 : ffffffff81=
603e80
[    0.000000]  s1 : 0000000000000000 a0 : 0000000000000000 a1 : 0000000000=
000000
[    0.000000]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000=
000000
[    0.000000]  a5 : 0000000000001fff a6 : 0000000000001fff a7 : ffffffff81=
6148b0
[    0.000000]  s2 : 0000000000000001 s3 : ffffffff81492a4c s4 : ffffffff81=
a4b090
[    0.000000]  s5 : ffffffff81506030 s6 : 0000000000000040 s7 : 0000000000=
000000
[    0.000000]  s8 : 00000000bfb6f046 s9 : 0000000000000001 s10: 0000000000=
000000
[    0.000000]  s11: 00000000bf389700 t3 : 0000000000000000 t4 : 0000000000=
000000
[    0.000000]  t5 : ffffffff824dd188 t6 : ffffffff824dd187
[    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 00=
00000000000003
[    0.000000] [<ffffffff80c04e0a>] of_parse_and_init_cpus+0x16c/0x16e
[    0.000000] [<ffffffff80c04c96>] setup_smp+0x1e/0x26
[    0.000000] [<ffffffff80c03ffe>] setup_arch+0x6e/0xb2
[    0.000000] [<ffffffff80c00384>] start_kernel+0x72/0x400
[    0.000000] Code: 80e7 4a00 a603 0009 b795 1097 ffe5 80e7 92c0 9002 (900=
2) 715d=20
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Fatal exception in interrupt



--NhGwwuXLQmoFWz13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ37MgAKCRB4tDGHoIJi
0ogYAQCncskGnOcyAXeBFBJrbMjm6BGa8hbVoEjrM/l95UBe8AD/bttbBDXv7Q7i
GBWiWJZfo3zCDC6B5rhf+qlSQcsrmAc=
=23TM
-----END PGP SIGNATURE-----

--NhGwwuXLQmoFWz13--
