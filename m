Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF0610B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJ1Hax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJ1Hat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:30:49 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593AB7F133;
        Fri, 28 Oct 2022 00:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY7XoMvHK318PI6SqKodl1sgbXutFJo1rP7wd8sjkh9qzHs/fjzzpbDVRZ8PNt4fFl6ersGYobEv1jhxT67I84L7KyHH3Cz7ZBEhjOxxRwqQDVyZ7PcCuJziUdsTHgd1ywBc/a2yZAHCaTkzOYrhoYJIwnGKygs+bGYeez6roo6qm8aRN4ybWbHNfEBnrudiPuF/79/2wG5Bfxc7BqvyRyaT/0l5qBqQecruy/wvesIVY7DMmoT4ByjK3tA6R8DIBqYHZv58EsTBOutO4eWBMFonwmJoVnsZP6Uh0UM6b1iotqwJUPHqqv+txf99OEjgUPAPc6fPE1hRMnH92GwxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckLfrT3u9bCppYGrd7OfAwp3WaLtPNCOgF6Ny/wXcmg=;
 b=cwVZQM+i3ZURNrTojIo3ieiig66KB/ZbiBfZh6zu6TvpCyCoc415mu7EbU6J4rZHWKtfudefJiWjTPt31epl09LirOdLkVF8FhSueg4q+6W+m7514SwoSPHIKLP3XPgtQg/iudF6TdcgiWpxZcy9SXv8r5Df7MRfoD0poGWvUDFPFBbviO4S+r961qvC0FdephJ6+CIRwmcfLOqpDM+jXsiziPV/pNJ4mk145w7Czp5zTIt0fXN1Gek9RG51rOCZizXg0xk5DWRLRDNS/kwNwbDnh6MeDf0D7cGnxY0DBsltO0AEjia+fzSQEDF76UDJ3cvubPhE/HeV9d96WnHoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckLfrT3u9bCppYGrd7OfAwp3WaLtPNCOgF6Ny/wXcmg=;
 b=Psyr1FYCzYbUI7Q7Km+LZMW6LAXHcgkLXVu8cLWYZrOX8yFShkVscS+Im9b/jGBdDDuffnkcSaZLZiKbCxR8wHMWHaRjdOCloBLmdczMkmbqPdaaCCCixuOw1Rfvx60nCWKgoDU0J2/Wm4sFHYm62eZbak6fbha0dB84U54jkxfQ060vukXnhlWwG4ZWqtjay2EOicf4fxQTmMU6jzs6s1XkAY9TBsRjlCE/R8SCqxUoNhBx1JHt+9TJStIUW0d8dZ3xIXBe8Xw7D1HHgROBioPO5a8Zdu/3KCpDJorfjH4Gwo91NdWAZFtbIG75XVtO7T9ABNuHb9v61CywChbq3g==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SEYPR06MB5719.apcprd06.prod.outlook.com (2603:1096:101:b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 07:30:40 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::9ae1:4f06:2773:f8dc]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::9ae1:4f06:2773:f8dc%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 07:30:40 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiaWei Wang <chiawei_wang@aspeedtech.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
Thread-Topic: [PATCH v2 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
Thread-Index: AQHY16FydoFvy/tRik2dFUNH8arC163/yrUAgADxsdCAItIJUA==
Date:   Fri, 28 Oct 2022 07:30:40 +0000
Message-ID: <HK0PR06MB3202285F061E0DFD0967395380329@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20221004032841.3714928-1-neal_liu@aspeedtech.com>
 <20221004032841.3714928-5-neal_liu@aspeedtech.com>
 <20221005131840.GA3256371-robh@kernel.org>
 <HK0PR06MB32020E4C2124FDD9C68F811A805C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB32020E4C2124FDD9C68F811A805C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HK0PR06MB3202:EE_|SEYPR06MB5719:EE_
x-ms-office365-filtering-correlation-id: d1d1bf34-8ce3-4620-9aef-08dab8b650cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7N87U4vT9RmIvtF/lEOgWA9CYd3SlZDbGN+okxH32/3L5oQiRbxUX2rSipwSmBe9+YP2R/TTjn0Jjg+65pWLj79Ljap4/6dEQ6TxG6X7ICt3TYT4m+h3CASa6wpOYE7CBKQVQKDZn+ussy+c/qr/x7hkA3VWMM0hB043sSOzlE/GSzL6EmwBpBIX7uiRsgzL3tCejJV/LqWqIzi0N/fSfLkyb1x9CF40sr4qJ8/q+mcMoF4KP0A0KtZ0nONbOyF0eoSzq/eJChUNrpdY9EilhYO06VSYflFVyhyztWXD31f1ZY41YIsc15p3pDy+EvHly3xt4yiIInTytKfzvXe3XDPEzoEiJMC0L3Askf8+0YvicgsiNBZkoo7vUQejMH47xZ4lTcymU/3C3JNlkrni64puC7Grwt63SoctMUXYcXUqm5sDB8iRpkZgCglAiv7rUjGvG7VnXWG+y6XzUNZbXyFndx6XhJi4LuiSslOlU0Ytn4HiZFZOJD1tx3T+6qtu9NIsCxC6z3OFlNmqioh4KVlmG4dNuPStVTpufMSVmFYQaDRgwNPD+Ti287xF0HmsQRGFs0ecvrmSPgSRaIDPT5ycLwtpIEUqs0mhynnHN3i1fS6bOfGLEiyXr7vw3Ves0+XtBQRNiyKaGy+RvhtOXtMlFIqS5zN2TLoPiEk32NsvOChP+lsG2nSId5i4uioaEBVKbkTZpZeg5+P0P1ZFDZjII0CmPEsi2b6YU2z7MgnajSZQUHDvSL36QyI+R9uuT0rh4X+Z+C0E49QnLpZaqiDoTJYQE9EyDtsBggOgWCk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39850400004)(366004)(376002)(136003)(451199015)(478600001)(6916009)(33656002)(54906003)(66556008)(71200400001)(38070700005)(2906002)(7416002)(4326008)(76116006)(38100700002)(41300700001)(55016003)(8936002)(66476007)(8676002)(52536014)(64756008)(966005)(66946007)(316002)(66446008)(5660300002)(9686003)(186003)(86362001)(122000001)(26005)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uduGAWhyMZePaaQ5CN1qrzBJBWMMa8sCOFOdKQeQOGHp/bQFSaHegPmeRS8y?=
 =?us-ascii?Q?p+zOLekcvp1QSCI2CMUqUsVG/Hd1zLUgnIS3nzwMvJyl5eBGfHMacyqNJbz0?=
 =?us-ascii?Q?VPquRaOiKU/6L5PZRHrhCp/ZyHMyhZazw26lIDAwvTLN9ayrmoVutfmJOLPI?=
 =?us-ascii?Q?l4xrBo6e+XLflgrQpT1HSQQDlpYEmiEeyTYnmOdjMJ2fP8rQX5e8WvwPzzPZ?=
 =?us-ascii?Q?vUwteSTZ/K1MGeruEbxp9Imnleh052aC0J/IlUQIlPywBBa/h1b5ZN1e9GLP?=
 =?us-ascii?Q?MLDxL8ZpUSYiCyDgVvt5TWWuF8cp+hRzFE+vW5b1c7EXIMCZQQg1FOf8gdV0?=
 =?us-ascii?Q?KhFZpeKijKOWbKEGdnfrurJ3+fk574FjjikcV9NiXTSiMmDOVaMc2wjydBBZ?=
 =?us-ascii?Q?xf2GDDCHk6hZQnvgoGXf0TH6p7fW3X0DgJqpvJkF22YlTlIMYwxgSjCZjuh5?=
 =?us-ascii?Q?6ebuI6Rx9jT6ga8FiRmo+dGl5kvvxifl2wVa1V5Nevk7OWwejlJlO9fQbRXc?=
 =?us-ascii?Q?yam+oUPPuXQKLJ6a70wgCbIwu8C0bzcuBDtHKhG4BWbyKbb32DyYquEygAI1?=
 =?us-ascii?Q?X7G91r7/ULjxCzHdD3U8fiYFEI+dGqQTg6AB0+R1tTjvsi29hHi/pCTzot3e?=
 =?us-ascii?Q?3wcYRIf5t8NzH+61W+Kx7NXt6q+7zl6TgvNySI2L5vQ+Njxl4g9NAIz1bepj?=
 =?us-ascii?Q?t/gSPtozBmO/cHnYzU+IKQKr6+/YlRTmWZdfOVeL7JdbjL5ZL6y53D7DazVp?=
 =?us-ascii?Q?sHedjJlHsZK7oRbBr5I2WeyPzbzfr7WhHdkSHth9N47pugLvksRho40aqJRh?=
 =?us-ascii?Q?UAFA4RgskM3sAZQSwtZpaU8/dD19SEUGWJNlmT4rph2S8L2IBJJwOQ1xYiDl?=
 =?us-ascii?Q?op9A/JQ0G/a40uLy4F0VsXMzaC2WpoNxe3EylIax3xlUi83fPTJt2o9tY2yU?=
 =?us-ascii?Q?oxQyHba422scyJCyL65JytHIdQ/h/qp3Q/VIBL45WRIbk5U3cpd/onVRplph?=
 =?us-ascii?Q?pVnWaSdNBNro5R5Bi7FZ8p/OB0HtfksbRYxFBfo2gPY4ZJrPJgyLMyNsyn2g?=
 =?us-ascii?Q?aQ7CBcwCJwELqlNGAZjZ61pkDt58CSky9KoRROqdUEOj/f8vnTUiEoa/kWSD?=
 =?us-ascii?Q?wFomxdfIs1DsYK1ZMTntVolJo3/xA4sx1y83W+OGyZKomDFLZjnq0jVrK9C7?=
 =?us-ascii?Q?x16UYc5tjXuv3Nr/RWyn4CfjCVv2UTtGExdtrxKJ3sw2HsNj/5WaXisnnF/q?=
 =?us-ascii?Q?ys7k4oye2MbtixFsxqRPb0dhLiQkcS0k0/Wn29aHKnOkZfRdFbtT8ATGbOtj?=
 =?us-ascii?Q?nAk9OQ77rgqFSrKYMorGn89ZnWXLLZsuMUuBlX4zT6BjSQdj71hENWcF/bxI?=
 =?us-ascii?Q?K4Pt0J0F3Xa5aXojZuLiV9tMgfrnXX/r055J1mazujapqsOV3x4Ok7dNtu5M?=
 =?us-ascii?Q?edqskWTePkDXAnxUSPHdMWeIlMsQbgkMB+GROnrzO91yRilTsW+ke6hLh9Ga?=
 =?us-ascii?Q?ZOjLARNwwTvvYHCsRHBoN87N+cYDZNEd2VVrj850uiDnnaUdmV/Bkw6NEJ8y?=
 =?us-ascii?Q?M4MfyL2OUKX7Iy4k9V/PnmeR2GKmNwyLrMCJBVQ1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d1bf34-8ce3-4620-9aef-08dab8b650cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 07:30:40.5113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PMHnwVcAKXq2Uy9c3TpFW0avahZTD1T/3Gw9w7qflOOA4MsfebO7hRNTSB7/Nqb2Rt3s2x5Yu4wUruSp80QKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Add device tree binding documentation for the Aspeed Advanced
> > > High-Performance Bus (AHB) Controller.
> > >
> > > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > > ---
> > >  .../bindings/bus/aspeed,ast2600-ahbc.yaml     | 46
> > +++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > > b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > > new file mode 100644
> > > index 000000000000..c42a350d30a1
> > > --- /dev/null
> > > +++
> b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > > @@ -0,0 +1,46 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ASPEED Advanced High-Performance Bus Controller (AHBC)
> > > +Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Neal Liu <neal_liu@aspeedtech.com>
> > > +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > +
> > > +description: |
> > > +  Advanced High-performance Bus Controller (AHBC) supports plenty
> > > +of mechanisms
> > > +  including a priority arbiter, an address decoder and a data
> > > +multiplexer
> > > +  to control the overall operations of Advanced High-performance
> > > +  Bus (AHB). AHB is the main system bus for ARM CPU to communicate
> > > +with the
> > > +  related peripherals.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - aspeed,ast2600-ahbc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    bus {
> > > +        compatible =3D "simple-bus";
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <1>;
> > > +        ranges;
> > > +
> > > +        ahbc: bus@1e600000 {
> > > +            compatible =3D "aspeed,ast2600-ahbc";
> > > +            reg =3D <0x1e600000 0x100>;
> >
> > Devices on the AHB bus should be child nodes here. Unless this is just
> > for device master interface to memory, but that's not what the descript=
ion
> says.
>=20
> Sorry, I don't understand. "ahbc" device is already a child node here und=
er
> AHB bus.
> "ahbc" is a controller to control the overall operations of AHB, which is
> described in the description.
> Could you explain more details?
> Thanks.

Hi Rob,

This controller is a device master interface to memory, not the bus itself.=
 Maybe the description confuse it, I'll try to revise it.
Thanks.
