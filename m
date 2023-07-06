Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524F37499F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjGFKyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGFKyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:54:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1051BFD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688640839; x=1720176839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o50z9Dt6f6niYBZzkVylMnavHJWjV/lG6IzZydHxJ9M=;
  b=1IXfUo7TWsCrbHOgUYQu8Fr1B5k8nxfIRedeCZI+FYOUy1L7cKNMEbFp
   nU9lHRbGaRLpSzhAo8zLSz3khJ8axPEDF9oyTGUeJ8Nwkh6EQtRfpwYQN
   JmjeCxd27RBSuDYlrnOCQ6Vu7RQNWX+VxnORgHsOa9KEuwI6Yx8PsK1ov
   pd5bNBtA+6zVwLC8TcNEoGtASvzmVe6I0yV41DzuD9Xea5bGqhuS+kgWb
   qToCWqOThGXxYLT50iXLCznx6WHTNokI9KioZvTmxkkmdOr7LhdjY96Yw
   QhKmrptaRb2CN66F1hEWoTIaS7oigp904YRRq+lJfDuuPVbBwoib4DQaP
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="asc'?scan'208";a="160126353"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2023 03:53:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Jul 2023 03:53:44 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 6 Jul 2023 03:53:42 -0700
Date:   Thu, 6 Jul 2023 11:53:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Evan Green <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230706-murkiness-oven-444f25924546@wendy>
References: <20230705172931.1099183-1-evan@rivosinc.com>
 <20230706-dbdee6eba0c4a16084587b10@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0qpcjaRKI05o/cBU"
Content-Disposition: inline
In-Reply-To: <20230706-dbdee6eba0c4a16084587b10@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0qpcjaRKI05o/cBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2023 at 10:01:31AM +0200, Andrew Jones wrote:
> On Wed, Jul 05, 2023 at 10:29:31AM -0700, Evan Green wrote:
> > In /proc/cpuinfo, most of the information we show for each processor is
> > specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> > compatible, and the mmu size. But the ISA string gets filtered through a
> > lowest common denominator mask, so that if one CPU is missing an ISA
> > extension, no CPUs will show it.
> >=20
> > Now that we track the ISA extensions for each hart, let's report ISA
> > extension info accurately per-hart in /proc/cpuinfo. We cannot change
> > the "isa:" line, as usermode may be relying on that line to show only
> > the common set of extensions supported across all harts. Add a new "hart
> > isa" line instead, which reports the true set of extensions for that
> > hart. This matches what is returned in riscv_hwprobe() when querying a
> > given hart.
> >=20
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> >=20
> > ---
> >=20
> > Changes in v2:
> >  - Added new "hart isa" line rather than altering behavior of existing
> >    "isa" line (Conor, Palmer)
> >=20
> >=20
> > I based this series on top of Conor's riscv-extensions-strings branch
> > from July 3rd, since otherwise this change gets hopelessly entangled
> > with that series.
> >=20
> > I was unsure if I could snuggle the new "hart isa" line in just below
> > "isa". Aesthetically it would be quite pleasing, but it runs the risk of
> > breaking brittle usermode parsers that are assuming a specific line
> > order. So I put it at the end.
>=20
> Actually, they're probably only aesthetically pleasing when they match. If
> there are differences, then I'd guess having them side by side, almost the
> same, but different, would make them even harder to look at then they
> already are. So I think I'll be happier with them separated by a few lines
> anyway.

This list is eventually going to be so big that I don't think doing
by-eye anything is going to be useful, so aesthetics be damned.
That said, a parser that relies on the order of individual lines like
that might deserve to be broken ;)

Anyway, change looks good to me:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I was thinking the uabi doc might need an update - should we add to it
that "isa" means the common set & "hart isa"?

Cheers,
Conor.

> > ---
> >  arch/riscv/kernel/cpu.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 1acf3679600d..6264b7b94945 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -197,9 +197,8 @@ arch_initcall(riscv_cpuinfo_init);
> > =20
> >  #ifdef CONFIG_PROC_FS
> > =20
> > -static void print_isa(struct seq_file *f)
> > +static void print_isa(struct seq_file *f, const unsigned long *isa_bit=
map)
> >  {
> > -	seq_puts(f, "isa\t\t: ");
> > =20
> >  	if (IS_ENABLED(CONFIG_32BIT))
> >  		seq_write(f, "rv32", 4);
> > @@ -207,7 +206,7 @@ static void print_isa(struct seq_file *f)
> >  		seq_write(f, "rv64", 4);
> > =20
> >  	for (int i =3D 0; i < riscv_isa_ext_count; i++) {
> > -		if (!__riscv_isa_extension_available(NULL, riscv_isa_ext[i].id))
> > +		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id=
))
> >  			continue;
> > =20
> >  		/* Only multi-letter extensions are split by underscores */
> > @@ -271,7 +270,15 @@ static int c_show(struct seq_file *m, void *v)
> > =20
> >  	seq_printf(m, "processor\t: %lu\n", cpu_id);
> >  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
> > -	print_isa(m);
> > +
> > +	/*
> > +	 * For historical raisins, the isa: line is limited to the lowest com=
mon
> > +	 * denominator of extensions supported across all harts. A true list =
of
> > +	 * extensions supported on this hart is printed later in the hart_isa:
> > +	 * line.
> > +	 */
> > +	seq_puts(m, "isa\t\t: ");
> > +	print_isa(m, NULL);
> >  	print_mmu(m);
> > =20
> >  	if (acpi_disabled) {
> > @@ -287,6 +294,13 @@ static int c_show(struct seq_file *m, void *v)
> >  	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
> >  	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
> >  	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
> > +
> > +	/*
> > +	 * Print the ISA extensions specific to this hart, which may show
> > +	 * additional extensions not present across all harts.
> > +	 */
> > +	seq_puts(m, "hart isa\t: ");
> > +	print_isa(m, hart_isa[cpu_id].isa);
> >  	seq_puts(m, "\n");
> > =20
> >  	return 0;
> > --=20
> > 2.34.1
> >


--0qpcjaRKI05o/cBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKadGAAKCRB4tDGHoIJi
0pK8AQCYZpuP+ABbmojkwmSlqKPYl+thQSqwUqrJsDOgD51+aAEAvyq/zo3OaIWj
saOw+IqxHnyBVjVvUCz1KNx9ABaCBQ4=
=UJ59
-----END PGP SIGNATURE-----

--0qpcjaRKI05o/cBU--
