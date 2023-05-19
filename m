Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F604709956
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjESORV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjESORT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:17:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183CAD3;
        Fri, 19 May 2023 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684505837; x=1716041837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sd2VkJX17zpiW/S4Qia53jgvQaRUOiUOyM2LVozEYUc=;
  b=Pl/L3pHaS6SX7mqzkGckGzxeTL3AOZUBNfFXbwsKlmFNC44TewMUPMqq
   x4/s/OhAr2ewR/yU8lWeKqLybP+O8lUmczxR1B6tPuQCf1VuHDYWLhB/E
   sOHR53XkqQ9rrEK2v2uymdF5TL0YxGa09XaZpr+xvAFTmqIfMN6YuEpxK
   pEfjAIMvsIGNsz9B7YJoyuBVYfkzZzjUOmQwGBomtTC80tW7BJiIoyQaE
   Z+v9voQmAYfhRtTObZQO7993CSUzdAqPSdWcPUa9pP8F4LaHyyaeFg6Bt
   34aw6A6V5pFTPKx0sHAPRSkk7OWzsJu2ZvNlNNYXvUsa8BUpJulnZ9G6i
   g==;
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="asc'?scan'208";a="214610741"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2023 07:17:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 19 May 2023 07:17:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 19 May 2023 07:17:10 -0700
Date:   Fri, 19 May 2023 15:16:49 +0100
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
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add StarFive JH7110 PLL clock
 generator
Message-ID: <20230519-smokeless-guileless-2a71cae06509@wendy>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-2-xingyu.wu@starfivetech.com>
 <20230519135733.GA10188@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R4Qg/wX5CgaesNEQ"
Content-Disposition: inline
In-Reply-To: <20230519135733.GA10188@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--R4Qg/wX5CgaesNEQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 03:57:33PM +0200, Torsten Duwe wrote:
> On Fri, May 12, 2023 at 10:20:30AM +0800, Xingyu Wu wrote:
> [...]
> >  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> >  #define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> > =20
> > +/* PLL clocks */
> > +#define JH7110_CLK_PLL0_OUT			0
> > +#define JH7110_CLK_PLL1_OUT			1
> > +#define JH7110_CLK_PLL2_OUT			2
>=20
> In U-Boot commit 58c9c60b Yanhong Wang added:
>=20
> +
> +#define JH7110_SYSCLK_PLL0_OUT                       190
> +#define JH7110_SYSCLK_PLL1_OUT                       191
> +#define JH7110_SYSCLK_PLL2_OUT                       192
> +
> +#define JH7110_SYSCLK_END                    193
>=20
> in that respective file.
>=20
> > +#define JH7110_PLLCLK_END			3
> > +
> >  /* SYSCRG clocks */
> >  #define JH7110_SYSCLK_CPU_ROOT			0
>=20
> If the symbolic names referred to the same items, would it be possible
> to keep the two files in sync somehow?

Ohh, that's not good.. If you pass the U-Boot dtb to Linux it won't
understand the numbering. The headers are part of the dt-binding :/

--R4Qg/wX5CgaesNEQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGeE0QAKCRB4tDGHoIJi
0j9qAP43YVrZEKNRod6kOuBIre1NM1sSrB1fIk55f7+4mLNEYwEAlTvK/m1TazZN
R+GITt0fWp/eotW4VJ7EN6IC8v3C3QE=
=BbP3
-----END PGP SIGNATURE-----

--R4Qg/wX5CgaesNEQ--
