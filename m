Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929E770DB75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjEWL3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjEWL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:29:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D77FA;
        Tue, 23 May 2023 04:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684841352; x=1716377352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ERDBnHnLv/O/sXjD4JjS2N6Q49PCHOq6wfY9yfihEY=;
  b=QW/K8VVdJkX5Ll3E/7mex+bKSwvQpQBQLVUWdBA2yyi8VOw6vXEj+Y8A
   9+uOt8oBTfYVwNrEOoVl7IcUPbpVLW/dC3j2yon4oBV5ndKCsvNTakKyd
   J88ehOug0uKlX5Gx3SfzQhLq+gElisCdyCjLkj03Z1cRLYTAvaf2FwRIF
   SVlZwYzxWohoTWK6Pr4a9RxGsh5UJP1huo/4amOfq8OitJAa1bScZG+2a
   chmMI0GBC4PF0HSrqAfH0wjKCxZHcxhOUVAqaRD3UZhwA4tTawVR8sw/P
   I4m1oZOni5dQ29/Dz73DQqUz3WoeDmrKIv7HxpZ2SZNg24pHcCL5VUHdV
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="asc'?scan'208";a="153476304"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2023 04:29:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 23 May 2023 04:29:11 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 23 May 2023 04:29:08 -0700
Date:   Tue, 23 May 2023 12:28:46 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Torsten Duwe <duwe@lst.de>
CC:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <yanhong.wang@starfivetech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add StarFive JH7110 PLL clock
 generator
Message-ID: <20230523-saturate-axis-f46b78b7b82b@wendy>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-2-xingyu.wu@starfivetech.com>
 <20230519135733.GA10188@lst.de>
 <20230519-smokeless-guileless-2a71cae06509@wendy>
 <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
 <20230523-fondue-monotype-0c751a8f0c13@wendy>
 <20230523131006.46997d84@blackhole.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zph+Miw3ashxgetF"
Content-Disposition: inline
In-Reply-To: <20230523131006.46997d84@blackhole.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Zph+Miw3ashxgetF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 01:10:06PM +0200, Torsten Duwe wrote:
> On Tue, 23 May 2023 09:28:39 +0100
> Conor Dooley <conor.dooley@microchip.com> wrote:
>=20
> > On Tue, May 23, 2023 at 10:56:43AM +0800, Xingyu Wu wrote:
> > > On 2023/5/19 22:16, Conor Dooley wrote:
> > > > On Fri, May 19, 2023 at 03:57:33PM +0200, Torsten Duwe wrote:
> > > >> On Fri, May 12, 2023 at 10:20:30AM +0800, Xingyu Wu wrote:
> > > >> [...]
>=20
> > > >> > +/* PLL clocks */
> > > >> > +#define JH7110_CLK_PLL0_OUT			0
> > > >> > +#define JH7110_CLK_PLL1_OUT			1
> > > >> > +#define JH7110_CLK_PLL2_OUT			2
> > > >>=20
> > > >> In U-Boot commit 58c9c60b Yanhong Wang added:
> > > >>=20
> > > >> +
> > > >> +#define JH7110_SYSCLK_PLL0_OUT                       190
> > > >> +#define JH7110_SYSCLK_PLL1_OUT                       191
> > > >> +#define JH7110_SYSCLK_PLL2_OUT                       192
> > > >> +
> > > >> +#define JH7110_SYSCLK_END                    193
> [...]
> > > > Ohh, that's not good.. If you pass the U-Boot dtb to Linux it
> > > > won't understand the numbering. The headers are part of the
> > > > dt-binding :/
>=20
> In fact, the clock index >=3D 190 makes linux hang on boot, waiting with
> EPROBE_DEFER for every device's clock, because the sysclk driver errors
> out with EINVAL (jh7110_sysclk_get()).

Yup, that's about what I expected to happen.

> > > Because PLL driver is separated from SYSCRG drivers in Linux, the
> > > numbering starts from 0. But in Uboot, the PLL driver is included
> > > in the SYSCRG driver, and the number follows the SYSCRG.
> >=20
> > Unfortunately, how you choose to construct your drivers has nothing to
> > do with this.
> > These defines/numbers appear in the dts and are part of the DT ABI.
> > The same dts is supposed to work for Linux & U-Boot.
>=20
> The JH7110 has 6 blocks of 64k iomem in that functional area:
> {SYS,STG,AON} x {CRG,SYSCON}. None of these has 190 clocks.
> The good news: the current DTS, as proposed here and in U-Boot master,
> provides nodes for all 6 entities. The bad news is that the clock
> assignments to those nodes and their numbering is messed up.
>=20
> AFAICT PLL{0,1,2} _are_ generated in SYS_SYSCON and thus U-Boot gets it
> wrong, in addition to the erroneous DTS.

The numbers are kinda hocus-pocus anyway, they are just made up since the
clock numbering usually isn't something with a nice TRM to go and
reference (unlike interrupts which usually are documented in that way).
It is very helpful to make them aligned some register/bit positions or,
but that is not required.
IOW U-Boot is not wrong per se to use 190 instead of 0, but it is wrong
to have different numbers in both places.

It sounds like you're saying that (and I have not looked) the U-Boot dts
actually has structural difference w.r.t. what provides which clock?
If so, that'll need to be fixed independently of the numbering problem.

Otherwise Xingyu & Yanhong should coordinate on which is the "correct"
way of doing things & do it in both places.

Thanks,
Conor.

--Zph+Miw3ashxgetF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGyjbgAKCRB4tDGHoIJi
0nWNAQCl0+Oajv0+WviUX41q7gnY6/ROmNpaw9Cwk/tbztgTrgEAwnHUKh2L1DIZ
essd134nm8Py1uvt2pf9pfOKbU8dOAw=
=y0FI
-----END PGP SIGNATURE-----

--Zph+Miw3ashxgetF--
