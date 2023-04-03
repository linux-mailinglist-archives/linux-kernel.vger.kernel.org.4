Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8ED6D3D47
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjDCGYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjDCGYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:24:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9389ED7;
        Sun,  2 Apr 2023 23:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680503064; x=1712039064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SXF9ql1O4QqCDwpUFCx0XjbvGZ7VdcC3B9xFy+3JRBY=;
  b=IsV+zfbmgs4DKvkRa0YTOE8MaQ5e1bCQYNTgUNaKDMF2QOHWgo6Z6MRZ
   cMHxQ4lSh78T57+keyZNhFPk/Lc0bUcRnApjCvbUL6wABazCVuo5dIpnd
   OUkqqBMn16K0kbiTmXz/HuXClQ5iVJpVEVXhpd5WCPSvaAqxPmGF7KBGQ
   rxknVWCJxLztRj6zdWZ+28miv4N6gYFuqGz8fmnOxXa+RWkAvfcw+y7NN
   Hqks8RgvvUO/qwgdFSl32Hgzf6OGDQ6ZdI/GdpkR9SKwmpnLMSqngDH+E
   y+95kdSe9o7F6KpJlO92w5uIw+1DYz9qDQR2HjYIwi2YdaL87VDQ0cWg+
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,314,1673938800"; 
   d="asc'?scan'208";a="145160516"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Apr 2023 23:24:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 2 Apr 2023 23:24:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Sun, 2 Apr 2023 23:24:20 -0700
Date:   Mon, 3 Apr 2023 07:24:06 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] phy: starfive: Add mipi dphy rx support
Message-ID: <0dd5e35b-512e-41ed-af33-f94b7e2868c1@spud>
References: <20230223015952.201841-1-changhuang.liang@starfivetech.com>
 <20230223015952.201841-3-changhuang.liang@starfivetech.com>
 <ZBhTmTEcrV59oaw3@matsya>
 <2aa1bdbd-e37e-941a-9422-0908545c14f7@starfivetech.com>
 <ZCbloBdeffocT3Os@matsya>
 <d48ab612-213a-8d20-4b36-3f64f3d24721@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H+2gs+RwcKc2bDgt"
Content-Disposition: inline
In-Reply-To: <d48ab612-213a-8d20-4b36-3f64f3d24721@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--H+2gs+RwcKc2bDgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 09:39:00AM +0800, Changhuang Liang wrote:
> On 2023/3/31 21:52, Vinod Koul wrote:
> > On 21-03-23, 14:08, Changhuang Liang wrote:
> >> On 2023/3/20 20:37, Vinod Koul wrote:
> >>> On 22-02-23, 17:59, Changhuang Liang wrote:
> >>>> [...]
> >>>> +static const struct regval_t stf_dphy_init_list[] =3D {
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(4), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(8), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(12), 0x0000fff0 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(16), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(20), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(24), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(28), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(32), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(36), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(40), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(40), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(48), 0x24000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(52), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(56), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(60), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(64), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(68), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(72), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(76), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(80), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(84), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(88), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(92), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(96), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(100), 0x02000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(104), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(108), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(112), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(116), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(120), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(124), 0x0000000c },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(128), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(132), 0xcc500000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(136), 0x000000cc },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(140), 0x00000000 },
> >>>> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(144), 0x00000000 },
> >>>> +};
> >>>> +
> >>>> +static int stf_dphy_configure(struct phy *phy, union phy_configure_=
opts *opts)
> >>>> +{
> >>>> +	struct stf_dphy *dphy =3D phy_get_drvdata(phy);
> >>>> +	int map[6] =3D {4, 0, 1, 2, 3, 5};
> >>>
> >>> what does this mean?
> >>
> >> This is the physical lane and logical lane mapping table, should I add=
 a note for it?
> >=20
> > Yes please. Also will the mapping be always static or ever change?
> > =20
>=20
> The mapping is always static on the visionfive2 single board computer.
> Thanks for your comments.

What about other boards featuring a JH7110?

--H+2gs+RwcKc2bDgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCpw9gAKCRB4tDGHoIJi
0j48AP93KM8qo+2qFu0Q08mVxv8JhhX9LTXYPZrZ5Cr2SB5nbwEAwF35RRfom50o
FPXKuMztozN4Mw3e3uMacj/9cRNOlAo=
=1C53
-----END PGP SIGNATURE-----

--H+2gs+RwcKc2bDgt--
