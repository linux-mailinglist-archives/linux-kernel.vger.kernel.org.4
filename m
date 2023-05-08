Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35F16FA02D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjEHGwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjEHGwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:52:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646DE11628;
        Sun,  7 May 2023 23:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683528769; x=1715064769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jmyhl5KhhfscLfRNmqFrjA+USTYyDadaT89tqH5yj9c=;
  b=si8BPrZhlVrHr9U9UacDS+Npvj+zdbyvBxmHDyQ9nJSCodJ2DOk2DNVL
   0nk4iw38sPwHEnSl5szhbrIK2QPVOlY+eZGklnIh9rtF/iBq+MKtSxDDQ
   2UN4e/tuGklP/AuXA6EfkEF/wegNyv5pZcq7tzlmKl346SCgik5bLKhPi
   V50DhbJKBRs9X52NGceBXX8j2yEOcVmoNGfJM0kpsnkPgSPejFTcIFiuc
   bU8W3eogzqlIA+LfGv1Ukz/2PppEjFwQFXwVvz7CmSYP+dSd7DGWUxguH
   E2H4165Yl4OvRX/8MSFr9npTP30v1Vts3hSwky3F3uSBD9x3XG/Y1dk2m
   w==;
X-IronPort-AV: E=Sophos;i="5.99,258,1677567600"; 
   d="asc'?scan'208";a="212854013"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 May 2023 23:52:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 7 May 2023 23:52:46 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Sun, 7 May 2023 23:52:43 -0700
Date:   Mon, 8 May 2023 07:52:24 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Guo Ren <guoren@kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/5] riscv: Add the T-HEAD SoC family Kconfig option
Message-ID: <20230508-splashed-voicing-bc6e91aeb053@wendy>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-3-jszhang@kernel.org>
 <20230507-sleeve-tacky-21e817e31fb2@spud>
 <CAJF2gTTSRQUX8C3C-tgq4o5iGJqKTja7-1Dv8epG_qZizUvSow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WAjmQ6ZL3drTJadU"
Content-Disposition: inline
In-Reply-To: <CAJF2gTTSRQUX8C3C-tgq4o5iGJqKTja7-1Dv8epG_qZizUvSow@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--WAjmQ6ZL3drTJadU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 02:42:10PM +0800, Guo Ren wrote:
> On Mon, May 8, 2023 at 5:22=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > On Mon, May 08, 2023 at 02:23:01AM +0800, Jisheng Zhang wrote:
> > > The first SoC in the T-HEAD series is light(a.k.a th1520), containing
> > > quad T-HEAD C910 cores.
> > >
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/riscv/Kconfig.socs | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > index 1cf69f958f10..ce10a38dff37 100644
> > > --- a/arch/riscv/Kconfig.socs
> > > +++ b/arch/riscv/Kconfig.socs
> > > @@ -41,6 +41,12 @@ config ARCH_SUNXI
> > >         This enables support for Allwinner sun20i platform hardware,
> > >         including boards based on the D1 and D1s SoCs.
> > >
> > > +config ARCH_THEAD
> >
> > Could you please add a defconfig patch, adding this option, so that we
> > build support for this platform by default?

> Yes, but it's another patch, see: 'commit eb20e7cb91ba ("riscv:
> defconfig: Enable the Allwinner D1 platform and drivers")'

But that's ARCH_SUNXI for the Allwinner D1. If the TH1520 is a
first-party SoC, and not an Allwinner product, it needs a new Kconfig
entry etc.=20
If it is an Allwinner, then the dts etc should be in the Allwinner
directory too.

Cheers,
Conor.

--WAjmQ6ZL3drTJadU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFicGQAKCRB4tDGHoIJi
0pjPAP0S/tHQSJAG9NJlAJoKtXSJqHqgGe4uxJHLZs3z9WuyGQEA+7omrh/Hz8AJ
5GT8mkA0HjL61HBgDk4yjXhRCjOZfQw=
=kbWE
-----END PGP SIGNATURE-----

--WAjmQ6ZL3drTJadU--
