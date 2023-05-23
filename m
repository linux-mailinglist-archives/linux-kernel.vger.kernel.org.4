Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D472A70D77D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbjEWIdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbjEWIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:33:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27F7212F;
        Tue, 23 May 2023 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684830546; x=1716366546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fr8/rGDDsZpOOPOgXOkmnx5UALlAdGkBZkWrF/mDeOw=;
  b=idgnQSxtLglnb6bVO3wZsemJb35rYSo1vX1zWHXhbHU1/fGSSQJEbXSS
   HPSEzW5gXsbQpB+Rtw9ezVaGsYwnl3Mm1wL5YNGBIusZo6HWbgKwWkYIO
   exIOGbxDrGcdRiODtEPQOPpBbK61Rj+D/RNjZjvOksjp8Y/Lbv9X1mRTt
   E9NUxgr3ZfAbulvFvf4X63b3LByG2U5snU5P6i1Tf0wF41tqX5ihfhkre
   6wKeaSOgSWVXw0khIVQCDxSoMRDbY+2nO3FOGQ9q0iI9ivRDGuxP59zc9
   P1HSRtcYB3l6UqkXSMbJtarbQ93/MFXXsi/K4qnMoteZGzXu++cqgmEKf
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="asc'?scan'208";a="214471136"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2023 01:29:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 23 May 2023 01:29:04 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 23 May 2023 01:29:01 -0700
Date:   Tue, 23 May 2023 09:28:39 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
CC:     Torsten Duwe <duwe@lst.de>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <yanhong.wang@starfivetech.com>,
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
Message-ID: <20230523-fondue-monotype-0c751a8f0c13@wendy>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-2-xingyu.wu@starfivetech.com>
 <20230519135733.GA10188@lst.de>
 <20230519-smokeless-guileless-2a71cae06509@wendy>
 <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P8c7zTGQM/sTX7js"
Content-Disposition: inline
In-Reply-To: <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--P8c7zTGQM/sTX7js
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 10:56:43AM +0800, Xingyu Wu wrote:
> On 2023/5/19 22:16, Conor Dooley wrote:
> > On Fri, May 19, 2023 at 03:57:33PM +0200, Torsten Duwe wrote:
> >> On Fri, May 12, 2023 at 10:20:30AM +0800, Xingyu Wu wrote:
> >> [...]
> >> >  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> >> >  #define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> >> > =20
> >> > +/* PLL clocks */
> >> > +#define JH7110_CLK_PLL0_OUT			0
> >> > +#define JH7110_CLK_PLL1_OUT			1
> >> > +#define JH7110_CLK_PLL2_OUT			2
> >>=20
> >> In U-Boot commit 58c9c60b Yanhong Wang added:
> >>=20
> >> +
> >> +#define JH7110_SYSCLK_PLL0_OUT                       190
> >> +#define JH7110_SYSCLK_PLL1_OUT                       191
> >> +#define JH7110_SYSCLK_PLL2_OUT                       192
> >> +
> >> +#define JH7110_SYSCLK_END                    193
> >>=20
> >> in that respective file.
> >>=20
> >> > +#define JH7110_PLLCLK_END			3
> >> > +
> >> >  /* SYSCRG clocks */
> >> >  #define JH7110_SYSCLK_CPU_ROOT			0
> >>=20
> >> If the symbolic names referred to the same items, would it be possible
> >> to keep the two files in sync somehow?
> >=20
> > Ohh, that's not good.. If you pass the U-Boot dtb to Linux it won't
> > understand the numbering. The headers are part of the dt-binding :/
>=20
> Because PLL driver is separated from SYSCRG drivers in Linux, the numberi=
ng
> starts from 0. But in Uboot, the PLL driver is included in the SYSCRG dri=
ver,
> and the number follows the SYSCRG.

Unfortunately, how you choose to construct your drivers has nothing to
do with this.
These defines/numbers appear in the dts and are part of the DT ABI.
The same dts is supposed to work for Linux & U-Boot.

--P8c7zTGQM/sTX7js
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGx5NwAKCRB4tDGHoIJi
0hKCAQCjR+6mFn9Hvjg7LZxkV1N8CJdjb0cHcueV22kKPkPAUwEAs0oxZHhBAEM3
N73rfgjIVRlJ5hJyp3q2Sua21OaY/w4=
=v6JB
-----END PGP SIGNATURE-----

--P8c7zTGQM/sTX7js--
