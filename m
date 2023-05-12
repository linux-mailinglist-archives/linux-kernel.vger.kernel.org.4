Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA18700978
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbjELNt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbjELNty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:49:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301EF12EA9;
        Fri, 12 May 2023 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683899393; x=1715435393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DuNeysYSTXy/mIZofYnY1xvzASlALFjZdE92szRAONc=;
  b=jalO+Qu1oHnS0FfJgzVsS84HrwTnpOqII992QLCJf1te4pfzAhqA71d3
   e5/JPXViiWgCfUhnR1J8CEAy42yukDc1X8TG9bMnApgnas6oN3W7KPSs5
   aqKulDjLCCr9BwzuQgnKEf3Q+yOZ77FTq/igFZJIqzuGcbxg5Y70gfAXc
   R9TBX7K9THPlkWmm19EqasQavHFWsCmib+rQ/QgBlk4Df4PXoSNonSRZ4
   r8vc+ZblUVm24cUoemNfMgv3K9olZfevenckc+Z1EJtbsCapoMLG8tn0a
   3ggUMw88eYK9udVQOx7CmfL2EywPiQSKajicXRKFVDn8P307pNzHHIEY6
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="asc'?scan'208";a="210975138"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 06:49:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 06:49:50 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 06:49:48 -0700
Date:   Fri, 12 May 2023 14:49:27 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
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
Subject: Re: [PATCH v4 3/7] dt-bindings: clock: jh7110-syscrg: Add PLL clock
 inputs
Message-ID: <20230512-traffic-popsicle-5c3423b37fab@wendy>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-4-xingyu.wu@starfivetech.com>
 <20230512-uproar-external-49a9e793fbc4@wendy>
 <91e4fd3c-20cb-724b-c9a8-e038600aabb7@starfivetech.com>
 <20230512-backlit-radiated-ded0b38b4a94@wendy>
 <be85aa2a-c72c-5272-ee40-f1265768e7b3@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qj/PZxe9T53Afs5A"
Content-Disposition: inline
In-Reply-To: <be85aa2a-c72c-5272-ee40-f1265768e7b3@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--qj/PZxe9T53Afs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 05:56:16PM +0800, Xingyu Wu wrote:
> On 2023/5/12 17:35, Conor Dooley wrote:
> > On Fri, May 12, 2023 at 04:07:47PM +0800, Xingyu Wu wrote:
> >> On 2023/5/12 14:47, Conor Dooley wrote:
> >> > On Fri, May 12, 2023 at 10:20:32AM +0800, Xingyu Wu wrote:
> >> >> Add PLL clock inputs from PLL clock generator.
> >> >>=20
> >> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> >> >> ---
> >> >>  .../clock/starfive,jh7110-syscrg.yaml         | 20 +++++++++++++++=
++--
> >> >>  1 file changed, 18 insertions(+), 2 deletions(-)
> >> >=20
> >> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-vis=
ionfive-2-v1.3b.dtb: clock-controller@13020000: clocks: 'oneOf' conditional=
 failed, one must be fixed:
> >> > 	[[19], [20], [21], [22], [23], [24], [25], [26], [27]] is too short
> >> > 	From schema: /Documentation/devicetree/bindings/clock/starfive,jh71=
10-syscrg.yaml
> >> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-vis=
ionfive-2-v1.3b.dtb: clock-controller@13020000: clock-names: 'oneOf' condit=
ional failed, one must be fixed:
> >> > 	['osc', 'gmac1_rmii_refin', 'gmac1_rgmii_rxin', 'i2stx_bclk_ext', '=
i2stx_lrck_ext', 'i2srx_bclk_ext', 'i2srx_lrck_ext', 'tdm_ext', 'mclk_ext']=
 is too short
> >> > 	'i2stx_bclk_ext' was expected
> >> > 	'i2stx_lrck_ext' was expected
> >> > 	'i2srx_bclk_ext' was expected
> >> > 	'i2srx_lrck_ext' was expected
> >> > 	'tdm_ext' was expected
> >> > 	'mclk_ext' was expected
> >> > 	'pll0_out' was expected
> >> > 	From schema: /Documentation/devicetree/bindings/clock/starfive,jh71=
10-syscrg.yaml
> >> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-vis=
ionfive-2-v1.2a.dtb: clock-controller@13020000: clocks: 'oneOf' conditional=
 failed, one must be fixed:
> >> > 	[[19], [20], [21], [22], [23], [24], [25], [26], [27]] is too short
> >> > 	From schema: Documentation/devicetree/bindings/clock/starfive,jh711=
0-syscrg.yaml
> >> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-vis=
ionfive-2-v1.2a.dtb: clock-controller@13020000: clock-names: 'oneOf' condit=
ional failed, one must be fixed:
> >> > 	['osc', 'gmac1_rmii_refin', 'gmac1_rgmii_rxin', 'i2stx_bclk_ext', '=
i2stx_lrck_ext', 'i2srx_bclk_ext', 'i2srx_lrck_ext', 'tdm_ext', 'mclk_ext']=
 is too short
> >> > 	'i2stx_bclk_ext' was expected
> >> > 	'i2stx_lrck_ext' was expected
> >> > 	'i2srx_bclk_ext' was expected
> >> > 	'i2srx_lrck_ext' was expected
> >> > 	'tdm_ext' was expected
> >> > 	'mclk_ext' was expected
> >> > 	'pll0_out' was expected
> >> > 	Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> >> >=20
> >> > This binding change is incompatible with the existing devicetrees for
> >> > the visionfive 2.
> >>=20
> >> This looks like less clocks about PLL in SYSCRG node. And I add this i=
n patch 7.
> >=20
> > The existing devicetree is a valid, albeit limited, description of the
> > hardware.
> > After your changes to the clock driver in this series, but *without* the
> > changes to the devicetrees, does the system still function?
> > From a quick check of 4/7, it looks like it will not?
>=20
> I just tested it on the board and the system still worked without the cha=
nges
> about devicetree. But these clocks' rate were 0 because these could not g=
et
> the PLL clocks from devicetree.

Hmm, that sounds like an issue to me. If all of the clock rates are
computed based off of parents that incorrectly report 0, are we not in
for trouble?
Should the fixed-factor clocks be retained as a fallback for the sake of
compatibility?
Emil, Stephen?

--qj/PZxe9T53Afs5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF5D5wAKCRB4tDGHoIJi
0ls8AQDZMoyMjXuX37lw7BCSWsU9Gxef0TEiBYOlGG+R1S9i9gEAlqR+XYcFjG8B
9nGwVdlLV70d09Xp6IjHrhusCQ2QSA4=
=fsw/
-----END PGP SIGNATURE-----

--qj/PZxe9T53Afs5A--
