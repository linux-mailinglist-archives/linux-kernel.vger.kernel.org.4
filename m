Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB47003DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbjELJff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjELJfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:35:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428A4C1F;
        Fri, 12 May 2023 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683884131; x=1715420131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fimsaLVN3IxgXwB6v4650M8bZOFhhLTgufNrSkX2BtI=;
  b=ic5GkReHO9v9JdcZGljzbr24fpwf8PWhUnzV+8fCVl0ZmqO2ok/Yoldn
   emVD9nenNzjdmAcAoSqauy/zddWztZaN/+/4I6+oXMF9ULlToxD/Vu5wQ
   1SewJiKZigKMOxaId32XgYPcEGiPPMlfd5Xi+hhSQ6s9Ah65CPUC9ZrXn
   7o1sWM9GQ+5Xxvbzf7uC78I94e30dzfnzQW10djbdJ6dDlV7OQSOgz5HG
   uQTjxr/h48mQx3g93FhtjbRH9UuZB3xxyjiD9qxEw4foBTd+e4ZKvSe3d
   RDjuSEm9jRxBNqlxefUt+N4+rTJJ76x5pdeT17+BMZmgBlacGzSoKQM4m
   g==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="asc'?scan'208";a="213028836"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 02:35:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 02:35:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 02:35:27 -0700
Date:   Fri, 12 May 2023 10:35:07 +0100
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
Message-ID: <20230512-backlit-radiated-ded0b38b4a94@wendy>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-4-xingyu.wu@starfivetech.com>
 <20230512-uproar-external-49a9e793fbc4@wendy>
 <91e4fd3c-20cb-724b-c9a8-e038600aabb7@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QcQ3Y5HHQp1oxn9V"
Content-Disposition: inline
In-Reply-To: <91e4fd3c-20cb-724b-c9a8-e038600aabb7@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--QcQ3Y5HHQp1oxn9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 04:07:47PM +0800, Xingyu Wu wrote:
> On 2023/5/12 14:47, Conor Dooley wrote:
> > On Fri, May 12, 2023 at 10:20:32AM +0800, Xingyu Wu wrote:
> >> Add PLL clock inputs from PLL clock generator.
> >>=20
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> >> ---
> >>  .../clock/starfive,jh7110-syscrg.yaml         | 20 +++++++++++++++++--
> >>  1 file changed, 18 insertions(+), 2 deletions(-)
> >=20
> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-vision=
five-2-v1.3b.dtb: clock-controller@13020000: clocks: 'oneOf' conditional fa=
iled, one must be fixed:
> > 	[[19], [20], [21], [22], [23], [24], [25], [26], [27]] is too short
> > 	From schema: /Documentation/devicetree/bindings/clock/starfive,jh7110-=
syscrg.yaml
> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-vision=
five-2-v1.3b.dtb: clock-controller@13020000: clock-names: 'oneOf' condition=
al failed, one must be fixed:
> > 	['osc', 'gmac1_rmii_refin', 'gmac1_rgmii_rxin', 'i2stx_bclk_ext', 'i2s=
tx_lrck_ext', 'i2srx_bclk_ext', 'i2srx_lrck_ext', 'tdm_ext', 'mclk_ext'] is=
 too short
> > 	'i2stx_bclk_ext' was expected
> > 	'i2stx_lrck_ext' was expected
> > 	'i2srx_bclk_ext' was expected
> > 	'i2srx_lrck_ext' was expected
> > 	'tdm_ext' was expected
> > 	'mclk_ext' was expected
> > 	'pll0_out' was expected
> > 	From schema: /Documentation/devicetree/bindings/clock/starfive,jh7110-=
syscrg.yaml
> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-vision=
five-2-v1.2a.dtb: clock-controller@13020000: clocks: 'oneOf' conditional fa=
iled, one must be fixed:
> > 	[[19], [20], [21], [22], [23], [24], [25], [26], [27]] is too short
> > 	From schema: Documentation/devicetree/bindings/clock/starfive,jh7110-s=
yscrg.yaml
> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-vision=
five-2-v1.2a.dtb: clock-controller@13020000: clock-names: 'oneOf' condition=
al failed, one must be fixed:
> > 	['osc', 'gmac1_rmii_refin', 'gmac1_rgmii_rxin', 'i2stx_bclk_ext', 'i2s=
tx_lrck_ext', 'i2srx_bclk_ext', 'i2srx_lrck_ext', 'tdm_ext', 'mclk_ext'] is=
 too short
> > 	'i2stx_bclk_ext' was expected
> > 	'i2stx_lrck_ext' was expected
> > 	'i2srx_bclk_ext' was expected
> > 	'i2srx_lrck_ext' was expected
> > 	'tdm_ext' was expected
> > 	'mclk_ext' was expected
> > 	'pll0_out' was expected
> > 	Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> >=20
> > This binding change is incompatible with the existing devicetrees for
> > the visionfive 2.
>=20
> This looks like less clocks about PLL in SYSCRG node. And I add this in p=
atch 7.

The existing devicetree is a valid, albeit limited, description of the
hardware.
After your changes to the clock driver in this series, but *without* the
changes to the devicetrees, does the system still function?
=46rom a quick check of 4/7, it looks like it will not?

--QcQ3Y5HHQp1oxn9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF4ISwAKCRB4tDGHoIJi
0iZ9AP4u9KYEMY6ijX89u7Z+3hMOXU9bpxiDpvO0ou//U3u5/QEA/iV3wF+GGG2p
Xe3b7nBI0NXFjIeBsr4Ow5b4xMFfZQc=
=4554
-----END PGP SIGNATURE-----

--QcQ3Y5HHQp1oxn9V--
