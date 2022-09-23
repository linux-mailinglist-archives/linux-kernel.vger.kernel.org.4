Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C755E7FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiIWQ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiIWQ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:26:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3DE13571C;
        Fri, 23 Sep 2022 09:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9/JxGiMWFbnxiAPWdm9sXMsL6rXJJLdrLos93yFoEHpx3DAxoNoetyMOXTghANrDJtKcwCisYSjvhnRBiMOlTZAK0PakP9CPt+I73eTAorjFXdUBq+IOeOgOTmDtvxSLWwXh8qC6zxj8G4PCavFlsLS94TIXOWTI7OujUZoTja/sGPbH/L7pMg+6tksGiN7eEZpYzAQ97GNBNTbdC8XWwpkG9S6xAWKJbFCt4De9+bXG1Q7p/y1qh7vkb1gwWCBuxB3e+EYX35xrF2Mfs/EjEbMgQRd+0j4ro+1FP2HREWSIPTQVZVmvaj1+1amuXtUFuQLurLr91vIdexn5R6SxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOPP8rEb+B6reTaXdVrtQcMTo0MEPd6QnGFstpMXOaA=;
 b=E9FU4sQzt4eu1lgzac9q/CPtospC1AI+nT1O7/Df8GEsPctLps2llPh5fZdKAvyoOE+VeXg2Bju/NYraxYto+EjM9gy2fGErEvjlWpx3/4ITBSmMgsRGT3V2REqOFZAnLEHGc9wYlJjfkWxF1sMy+Psln9lVMxqdRIkYIulhNOGasIxnra/G+3NKAczvX/1imcl8wGQUC+DgNPHoIN0FKMyKInA+hojLytM+kh0/96Bg8fLft4jFXpa+txGGYDHWtdLTtIHst3i84Q+iQwMed8PS7KgS42JOmWRt5YzYJ8SopNOlpZIHPELJWpjQcgzDiyKhjI5RNRZqeOUN9B0+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOPP8rEb+B6reTaXdVrtQcMTo0MEPd6QnGFstpMXOaA=;
 b=AiAbRhb1XdCfJ7QZuQQ3rdZteXDsb0NgJcuwUPdpVlzQSDuYcJG1JL1pl9RasxCm9fq+YweWplIrFNrDJuDpsHF930+pnsaHfcfkELbqnR1gOOHwXJEnPApo71ghmdLfz4zXhSYPhKczASZ3smj3OhMxoJvQXsQ0JkN0si4InUU=
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com (2603:10a6:208:145::23)
 by AS8PR04MB7941.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 16:26:14 +0000
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::7d0b:b02:69b9:a3b4]) by AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::7d0b:b02:69b9:a3b4%4]) with mapi id 15.20.5654.016; Fri, 23 Sep 2022
 16:26:14 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH v2 5/9] arm64: dts: ls1046a: make dma-coherent global to
 the SoC
Thread-Topic: [PATCH v2 5/9] arm64: dts: ls1046a: make dma-coherent global to
 the SoC
Thread-Index: AQHYyVu7ZWZ+5HaopEeXyly5/MaOXK3tO1AAgAABOrA=
Date:   Fri, 23 Sep 2022 16:26:14 +0000
Message-ID: <AM0PR04MB6289919428F12CD125357D4F8F519@AM0PR04MB6289.eurprd04.prod.outlook.com>
References: <20220915233432.31660-1-leoyang.li@nxp.com>
 <20220915233432.31660-6-leoyang.li@nxp.com>
 <e27d295b-abbf-716c-5e0d-97dd63ce07df@seco.com>
In-Reply-To: <e27d295b-abbf-716c-5e0d-97dd63ce07df@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6289:EE_|AS8PR04MB7941:EE_
x-ms-office365-filtering-correlation-id: 3e2eb1c5-c368-43af-1311-08da9d805594
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M3F45/TdhFYngT1LgCN0Y24VRnEhIn7zNKWFEYVpYbWRbCy0r1rCac0+pcOJ/DYrnV8qeJhddOGSZtY/AeR10sbQb0klAJLWlThVe36HHNYARqC1uCrhsyBUqdRwHw2DlFjScxjBNsGcVdlW8CSPmW7b3sEzfU0fi8cLCo0YJBdPEX3WzfkKO8836EgXkikBx8aRKD5O2Vyfkvh9EcIwyZUCYl8e+8HB4vr0xB9ct/vsHPndDTPBTyEWpuj4kMSUqPlFYNyaIDnUUb7p+kBn1G6eNasPyAyCp2r21UOVbzJeN9tttq0e45c3a2+xEn5Jb4hc++nAO58wK87gOuLcIDnoAMHr/FtVhx6HN+/RtLIVHG/cLhEyNtsUHzHwQNk4m0gb/AcTDGuFu1O93CWt9BQ68bFWLO18v+bNLumCtEL3/87QtwZUx60NbI24teS0nV26pjYUe0dofdt8mnZPDkpP+5d+AjK8gh7mZoiljtYiumcUsN+xJUKeBNo5OXAjrjFrjBKBjjEzP02dKX3PJwkMXz1vHjb5Fa8HAidEfyocv/UYGumsx58r4aMdrTMstFMiN1o1wqS1pE6J2UZluYm/nyVHCdUtH+fyhWp6ieBoMBhETRvn1t4ovhyOTYF63aRCHCB0kvc6GBEclzqODRySACYrrAQLmWhMk2sAOiYHhsTGftYbKJfWWvgD6D6FPEXLNSbV+3A8leyOsnkyomVryhspES197caiFbzJexItrloHZZHnRjuSKWbHLMeS7mCRl02yLfx7adVyjvTmrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6289.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199015)(83380400001)(71200400001)(186003)(110136005)(2906002)(54906003)(6506007)(7696005)(316002)(33656002)(122000001)(38100700002)(55016003)(53546011)(478600001)(52536014)(9686003)(26005)(8936002)(5660300002)(38070700005)(55236004)(41300700001)(86362001)(66946007)(76116006)(8676002)(66556008)(66476007)(64756008)(4326008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cTo7bX9ZtbJbct9WPYDw+UetrFf9rV9ZEk+wyIxJebKEZLV55Nyl/ifv8OSK?=
 =?us-ascii?Q?3eZuHUr2Aga811GmpbJOZY6PUsMphUBFLbHY2p/1fwtuptZopq2kQIO1YO5s?=
 =?us-ascii?Q?6Mz1tneUVlMP6PRfJW/spmdB4aEj2RXtLAOZIWn+HoWI+FkiTIIvw8U2JJFc?=
 =?us-ascii?Q?1NLJsmeas9u1cUUaHsoAPcxTwYTbP4BOWaliVYGOxLutaJ0ME2Jve7JQURbO?=
 =?us-ascii?Q?4BboteDQStVu5rsKivGgcio74vM5xn/DE3UgVZgneMWD4BGrzSWljZf5a1NU?=
 =?us-ascii?Q?hCV5v7WSl0YvWO298w+CWUexAVsdotNl088cWUhJpMr7kuM1hMLs9s38rDDw?=
 =?us-ascii?Q?5Kj96vDSG0fMzsDcBUWRNSl24T4q8L+BWBpFuZ66bm+0vs+o/NMMU3fmuJyY?=
 =?us-ascii?Q?UlB6OJ0b08u/7nUBp8e5DW039Zil//vQhM2p24tG9tZN1UBqkL4E4pKKr4F8?=
 =?us-ascii?Q?FYU0CTEbTxlhplLCpP3uFQE3PMuBfqOQ+oam90RvNFXsB/N+Q4dmyrE+eG6U?=
 =?us-ascii?Q?PIIvu23F7GhIzQfM2lcTay31EMlJa+dDtZXfLE2WQw0Kvz7zBK4XKyJzjoox?=
 =?us-ascii?Q?VQLmLzsVl1QncCpi4Kk290/+ILxI9eIMXfVoMBJK8rZKNt8QWVuViXmkoMNL?=
 =?us-ascii?Q?6jBjluhds/jNHN88V3oTFvwBlA5QFR+P6j79M047rqsv5ox4Tm7qX2igVfsp?=
 =?us-ascii?Q?VoUuiHGjoM7hPxXT3TVVj83M4pGyF1PgYD2vOqJ5h+s8n/ahVHCzFRbrMtKc?=
 =?us-ascii?Q?m9qYcSvSF6X7fs89NLw1z6Vb06F6dmeKiVqxh0OCApw53M82JkK6/paiFKyl?=
 =?us-ascii?Q?5O6azptsYexWc7NRJdqmBmuxDDEHvP3oId/p6NAnQL+wacO9zcP07ikhfFKl?=
 =?us-ascii?Q?Qp6AMimem9csTqzGRtpiViEwWsndCP2LUbtf0kN+1sCKdwULJ7bRnIM2uDAx?=
 =?us-ascii?Q?WIQAoPzSYbAbAvgEG9hMBrVoNn5w1WfUrm74Ura5F6JLtEUf6oJLh73xOKaL?=
 =?us-ascii?Q?S/C4jcOYot3eX30DDxAwLNwFbNaRfqTocoeN4Ec6706UOV9twejBDElWtJpV?=
 =?us-ascii?Q?RiC9cRAwmBf8oaPlwWa7HExPFeCTzV6c1aUNptW7AQm/FiHmuO+xbEYMXshp?=
 =?us-ascii?Q?jCgZPf6sZt/esFBGwH9sFcNtWk0SDEvGCLOMhSnYrWQfq6IFsKqUIqS+9TJI?=
 =?us-ascii?Q?1x5CdRF+p9uMU0a5XVloEEegfMkMt8NjF2+e9YwIMO4OBNqtsISD4aAZPEsa?=
 =?us-ascii?Q?Wh77xx8ni2BXIbByByxKotnJQROuOM0IlPOz2G1d2y16s99/PbhKUVU99unT?=
 =?us-ascii?Q?PWNcx3yNQ9H4Yui7h93ubGl/aq7eiIMLBFjBM0vqtrsJ4LbjM0b1QuanZlot?=
 =?us-ascii?Q?PEdvq9oGolEBIMT7Haagiq2TTDa/QNoFrcfm+xe0zqysEV7OP1s1LuH4wwGH?=
 =?us-ascii?Q?rTiat4nj13Aa6zZpOCURzs+OaWy2+zR8LCyyDmPSMabLxhiQ0jlHeeJSnw2G?=
 =?us-ascii?Q?MXhXJvfAyhJS/KfBd1p7Cl3ohuk/DecDQ+TWFcvGW0b9No4mPGLtzzwqDe93?=
 =?us-ascii?Q?BTp7hMEkO531aCq3rJR8XGwMw6n3L2v0KiPdKMF4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6289.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2eb1c5-c368-43af-1311-08da9d805594
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 16:26:14.3020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ND+a3F8YdSyRpkdk5YXqgnRUdYlm9CUPkt/NBH2ORRIHe5/Yvcd3iY3NnNzRxv3Mngk3u8dFMzj63eCpnevIeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sean Anderson <sean.anderson@seco.com>
> Sent: Friday, September 23, 2022 11:11 AM
> To: Leo Li <leoyang.li@nxp.com>; shawnguo@kernel.org;
> devicetree@vger.kernel.org
> Cc: robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Subject: Re: [PATCH v2 5/9] arm64: dts: ls1046a: make dma-coherent global
> to the SoC
>=20
>=20
> Hi All,
>=20
> On 9/15/22 7:34 PM, Li Yang wrote:
> > These SoCs are really completely dma coherent in their entirety so add
> > the dma-coherent property at the soc level in the device tree and drop
> > the instances where it's specifically added to a few select devices.
> >
> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > index 27033c558e3e..e406499a26b4 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > @@ -273,6 +273,7 @@ soc: soc {
> >  		#size-cells =3D <2>;
> >  		ranges;
> >  		dma-ranges =3D <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
> > +		dma-coherent;
> >
> >  		ddr: memory-controller@1080000 {
> >  			compatible =3D "fsl,qoriq-memory-controller"; @@ -
> 355,7 +356,6 @@
> > crypto: crypto@1700000 {
> >  			ranges =3D <0x0 0x00 0x1700000 0x100000>;
> >  			reg =3D <0x00 0x1700000 0x0 0x100000>;
> >  			interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> > -			dma-coherent;
> >
> >  			sec_jr0: jr@10000 {
> >  				compatible =3D "fsl,sec-v5.4-job-ring", @@ -
> 794,7 +794,6 @@ pcie1:
> > pcie@3400000 {
> >  			#address-cells =3D <3>;
> >  			#size-cells =3D <2>;
> >  			device_type =3D "pci";
> > -			dma-coherent;
> >  			num-viewport =3D <8>;
> >  			bus-range =3D <0x0 0xff>;
> >  			ranges =3D <0x81000000 0x0 0x00000000 0x40
> 0x00010000 0x0 0x00010000   /* downstream I/O */
> > @@ -834,7 +833,6 @@ pcie2: pcie@3500000 {
> >  			#address-cells =3D <3>;
> >  			#size-cells =3D <2>;
> >  			device_type =3D "pci";
> > -			dma-coherent;
> >  			num-viewport =3D <8>;
> >  			bus-range =3D <0x0 0xff>;
> >  			ranges =3D <0x81000000 0x0 0x00000000 0x48
> 0x00010000 0x0 0x00010000   /* downstream I/O */
> > @@ -874,7 +872,6 @@ pcie3: pcie@3600000 {
> >  			#address-cells =3D <3>;
> >  			#size-cells =3D <2>;
> >  			device_type =3D "pci";
> > -			dma-coherent;
> >  			num-viewport =3D <8>;
> >  			bus-range =3D <0x0 0xff>;
> >  			ranges =3D <0x81000000 0x0 0x00000000 0x50
> 0x00010000 0x0 0x00010000   /* downstream I/O */
> >
>=20
> I'd like to summarize the conclusions of [1] below. This patch breaks I2C=
0,
> which is the only user of eDMA at the moment. eDMA is noncoherent
> because snooping is not enabled for it. I have submitted a patch [2] to U=
-
> Boot to enable snooping for eDMA. For now, this patch must add dma-
> noncoherent to the i2c0 node.

I have sent a V3 yesterday to set dma-noncoherent on edma node.  But are yo=
u saying that the dma-noncoherent need to be added to the i2c node to make =
it work?

For the u-boot patch, I will check with the hardware team to see if it is s=
afe to set the reserved bit for edma snooping.  There is a problem with thi=
s is that it breaks the i2c for older u-boot.  Probably the best way is to =
make the default to be non-coherent in dts and update it in u-boot when sno=
oping is enabled?

Regards,
Leo
