Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C186773F7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjF0Ivs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjF0Ivk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:51:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2ED10D;
        Tue, 27 Jun 2023 01:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687855897; x=1719391897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CXsYWghN+E3gwCoJ+rRyfawRMHzc9mlxaZI/0JHowCY=;
  b=CBQ33ownST3aciL70QFwHbT1jLQCH0JVc8QK/UszaotNJ4v9h0nsRHK0
   X+mjie192ABtJNaYrAJsXikwwqRhi7Z/BW1o6Ni2Dra1bZSNfP62OXi3i
   P7If8+6xlNCtYPsE+Y6wm6N1GMhfjE2d8b+LkTCaJswltCXMK+z4KlYnh
   94u7q1z0KQpTX9C1HV2NH6sU7AhL507kDsktnEMfETCXNm9vL10ANXcJC
   uBs0w8vSPlpxTOYncFKQGhESATOz3kDl2NSvOVMJO5wjzrpGebhCJxJIt
   Sqrj/TUhUAmpbMIoyijOA26SWoXAD/6K42yoIhM1VHXjqUJYq05+cAQ51
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="asc'?scan'208";a="220027967"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2023 01:51:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 27 Jun 2023 01:51:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 27 Jun 2023 01:51:34 -0700
Date:   Tue, 27 Jun 2023 09:51:05 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/9] RISC-V: don't parse dt/acpi isa string to get
 rv32/rv64
Message-ID: <20230627-gosling-crouch-635c07ae05b3@wendy>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-silk-colonize-824390303994@wendy>
 <20230626-e3ea7beb39c584bfbf7ee836@orel>
 <20230626-dragonish-romp-9acf4846ae01@spud>
 <20230626-4fb963235f3ab08383a6d9ab@orel>
 <20230626-ragweed-whenever-5b22e180dcd1@spud>
 <ZJqXj7UdegnRP4mI@sunil-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ThX69JfIuFO+nHyA"
Content-Disposition: inline
In-Reply-To: <ZJqXj7UdegnRP4mI@sunil-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ThX69JfIuFO+nHyA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 01:32:23PM +0530, Sunil V L wrote:
> On Mon, Jun 26, 2023 at 05:16:09PM +0100, Conor Dooley wrote:
> > On Mon, Jun 26, 2023 at 06:05:40PM +0200, Andrew Jones wrote:
> > > On Mon, Jun 26, 2023 at 04:51:29PM +0100, Conor Dooley wrote:
> > > > On Mon, Jun 26, 2023 at 05:14:15PM +0200, Andrew Jones wrote:
> > > > > On Mon, Jun 26, 2023 at 12:19:39PM +0100, Conor Dooley wrote:

> > > > One of the few things I know does parsing of /proc/cpuinfo is:
> > > > https://github.com/google/cpu_features/blob/main/src/impl_riscv_lin=
ux.c
> > > > and that doesn't seem to care about the mmu, but does rely on
> > > > vendor/uarch ordering.
> > > >=20
> > > > Makes me wonder, does ACPI break things by leaving out uarch/vendor
> > > > fields, if there is something that expects them to exist? We should
> > > > not intentionally break stuff in /proc/cpuinfo, but can't say I fee=
l any
> > > > sympathy for naively parsing it.
> > >=20
> > > Yes, it would be nice for ACPI to be consistent. I'm not sure what ca=
n be
> > > done about that.
> >=20
> > Print "unknown", until there's a way of passing the info?
> > Speaking of being an eejit, adding new fields to the file would probably
> > break some really naive parsers & quite frankly that sort of thing can
> > keep the pieces IMO. Ditto if adding more extensions breaks someone that
> > expects _zicbom_zicboz that breaks when _zicbop is slid into the middle.

> Instead of unknown, could you print "risc-v" or "riscv"?

I don't really see how that is better. "riscv" is not the uarch or
vendor. If we don't know, we should either say we don't know or omit the
field IMO.

Cheers,
Conor.

--ThX69JfIuFO+nHyA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJqi+QAKCRB4tDGHoIJi
0odMAP9kKtThcpSAcsqVjnS6huAGPWKUX3mutzPXNe6QTDlWoAEA0U6dhi0/NMhn
piv1C2IwpR2atmi3IYJKU226a/OWxQU=
=NB1e
-----END PGP SIGNATURE-----

--ThX69JfIuFO+nHyA--
