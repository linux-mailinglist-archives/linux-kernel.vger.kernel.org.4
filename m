Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A446005A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiJQDRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiJQDR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:17:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1C24D15B;
        Sun, 16 Oct 2022 20:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GolqOyPZqqCQJP1Ta+Usi14WBw6XeledNLzo6G+iCECn9VoaL9FoNmbTc1v/8j5I38kIUJcr8sPMPnQDPLRKQZFE+SOmEEfeiDzUqFtbmlbIOHTYqxqVI8p9UVLvaJHAF23iP2ThdRA0goUr1OL+C2cQcX9DMRZPN47Qv1Hixw9kVnjvi8LoWBbRJ1C7SCfT44qSvB0bL+ft9n93v5Dm5nkgE0J0wam7jscXdny5p+SJtvUYlO3QpHgkHPq5fDDJejsvwBf68GVstr0vRFIpGIvM054xJqBMwRNP0qoAvn02o8skNd0hnEZQORe/bAeR6fgZ/a7VQFeYspIBngSvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6F8foZSsapKx/l7ixwlyuEMJlFHZQR7MSGjCGyDEw0=;
 b=AztU0HiO0GVTx6d8013gjkAX3DueJndyKnu/7rWasTn3in4nstecY/sPxFJhV57tRyLn7L7wtZjcHInG80zLZKoMyXvp+ou0X12LSQ0mjjuKXfFiaDR3rgwnnISs80JkhUAlAg/KniyCp4pkEjOnqzjcN7cGXOkLzv2/gHvem5zTwtfZLQ4P/T/+OzZN4wg59ms9eGe8LS6qyHiuuXc7ybz6aCW8Kg+8kIkufFFye+8QDzQQyLsI0na5HAfdIH52O6WZQwMvEGvIr1gwBWlsvPbY3u2uqcmk9xIyBKcvTdeRrHk4SiNLEGUsbDgV2kY+ap+suY6FxJz1out6JJXy1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6F8foZSsapKx/l7ixwlyuEMJlFHZQR7MSGjCGyDEw0=;
 b=INa+P/8ehX40iKP4gUkujQCo8WyghYyVwVQBYYwVur0hBo/EcIUSJeV3FiG0RBvHk8+Dt3wGI1YZ1Aksul1sjtBN7C8pAbLq7sMd0C9NULdY5FMObZY/X4WTUeusDBWlWmfBshxnlxACGjey6FmOvJ1molyd4x1z6n0Ij16NVz8=
Received: from PAXPR04MB8784.eurprd04.prod.outlook.com (2603:10a6:102:20f::23)
 by DU2PR04MB8693.eurprd04.prod.outlook.com (2603:10a6:10:2dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 03:17:22 +0000
Received: from PAXPR04MB8784.eurprd04.prod.outlook.com
 ([fe80::855c:7884:639:f875]) by PAXPR04MB8784.eurprd04.prod.outlook.com
 ([fe80::855c:7884:639:f875%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 03:17:22 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [EXT] Re: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert
 to DT schema
Thread-Topic: [EXT] Re: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert
 to DT schema
Thread-Index: AQHY37JhVyi1Spma3k2S0s+gX0HEua4PjEKAgAJf68A=
Date:   Mon, 17 Oct 2022 03:17:22 +0000
Message-ID: <PAXPR04MB87840FFD365C5C044D54B55F8C299@PAXPR04MB8784.eurprd04.prod.outlook.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
 <20221014095148.2063669-2-peng.fan@oss.nxp.com>
 <359bc301-fed6-80eb-6945-caeb7fbb319d@linaro.org>
In-Reply-To: <359bc301-fed6-80eb-6945-caeb7fbb319d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8784:EE_|DU2PR04MB8693:EE_
x-ms-office365-filtering-correlation-id: 3d9f0a86-1fe2-4f10-4eeb-08daafee1b4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVtbbIACVEsRMeWlbPHakfxNitWtICsolHVsKBdoBmOxwCoz7D70K5I5qxkyvx/IHkhxicErmw18aGwezeWKnRnU+VyOV4LagjVn7VqJIb0lPEHsRSdCExtGoTmY2OeJl/xiXVrZXHahaA1Rl29Vj4MdXS2TNoU1bDn/PX0yEJf3ZPXEkMsd/2ccfElIwCY6/NATu1ZGjXO0qEAEd5pSaJoHwUm5sxCN12ZsPfAXa61MdeksRHX4O8rQLVje6kdns/QxEHEa8NEE3d3tibB5eqVMmf+LJ0JdwIul2pjtEcY8wER3a2lRz8rMQelhBiQHXSa5yALT5iWDR6isKfQha+fZFHd7AFavqptKQfrSOhpQZwnBjRb2yoCBDYjoojAUIt3yIiWfVDP4+gnU/tJiGwmAWZ48sNeyFmMmN8yia8PFhraqm7sGzdt6WenfPAwb1dHJgkU5Ixl4rdd5cpDHp3fDYTKASUNFIyCqClrmO211TDW33Fw6J8ePIAan9ZoIMgDp5+EaX+vbbuvX1hxIviPlbcU1sC5/0m5K+GKxu3/iqpb5vPxLcW3T8VmWVwe5zu0MwGez4ODK+lgmULwnT73c3JfsjJ8JSoD1zVxc+Y9TrhM1wMemqeMtR7YzsRXPKF/+KjFURr5jdn0RtlajliX8jMl+SeDK5QAqqF3Z0kI7rwsfAJLUf96UGO5Tzyhv5i+lg0nvVOyHTcL0Qs97BX7uQPm+vkb5eWRdFfDtNt3x2k4j/EeG/z4pmDk2wjvdIfXobBIfdgXF3tzS/4OdPOAlfg7bDV2SWEVRYKSa7ylpJJb9CAfapKoRCX73MxZsP+mOYGuVx369ip97xhmZiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8784.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(33656002)(86362001)(122000001)(2906002)(7416002)(5660300002)(38100700002)(186003)(71200400001)(83380400001)(38070700005)(26005)(53546011)(7696005)(6506007)(316002)(966005)(478600001)(110136005)(9686003)(54906003)(66946007)(66476007)(66446008)(76116006)(66556008)(45080400002)(8936002)(55016003)(41300700001)(52536014)(4326008)(64756008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WzTJHh3BmxESlTK5xYlS/YCmkqRr1wNTNliy/i4LUu5aF91rWMW4RTyYUnKQ?=
 =?us-ascii?Q?MtQV8pDxrQMnvIlG2WeGnJAu98z8yrj3qDt04mM3z3z6Ti5orB2htTC1z5Fb?=
 =?us-ascii?Q?N8SCBxNo/o+sHqbtrB1lhr6e7orMA1tfSXtScaGWqXNBkLU4tfTwD7BazfFp?=
 =?us-ascii?Q?jcmEttdT0J5Icnz92jMbazsJK5KYOfwchECd1cBXsBFX9Oenqz5Oqe0F7aK/?=
 =?us-ascii?Q?e+j7X1Hndx9anTVuGhCjR3LaWw+x7DxBVhsETiaujO6lh4P9jogpOpnY7k2O?=
 =?us-ascii?Q?re0d/oHoue0RIlBAayMoNemEGkIYV/rNm/sUWXB+cQ7+inXEBOeqrngmrqju?=
 =?us-ascii?Q?4DaoMFl1Hl4BO//sSfBKbxADnYXTG/qFeS0cAR4TT20L8Qj1E6bIfJmpj9Tr?=
 =?us-ascii?Q?SjHb/hNFiV9LnEus2ln4v2rLNURC/3ABTIgFVCrqgoMUnFzHDnIy2ZEGtwE0?=
 =?us-ascii?Q?U4b4UdCIFdEmXDSbsMCKPcrdNmAxnqh1D5FRlKcCjhnpWp24t5Ulen4+bYxF?=
 =?us-ascii?Q?5r3AU3beSbY6hbSviBHJcFs8YXVDh9rWGsoEvbtRHKY+fuMwy0e++L0RkOaG?=
 =?us-ascii?Q?dUYpzLWyiMyErJu+0rj4ibUtAzQFSQOxMTlhfM2w8TfSwI9BY+zwf2gl3mc5?=
 =?us-ascii?Q?AbMOXe+UlDHs0CRh48saO7eK0RR2b0UMqMqqHIl/iSJEFyDxeMorwywB3DPw?=
 =?us-ascii?Q?b5rmok9q2zB9ARdNeljbrQvhmD1THOLAmAMQIGzgeNKMjNTWrTDWOPt98hqI?=
 =?us-ascii?Q?LLiR0GNn5unBUnNkYx6RlN9gEPoCGtpngeeMo59py+A+3r3zK3VgLivPj6hq?=
 =?us-ascii?Q?Tzd5BLV9Rdn1GLQNqMm65uOn6lXzLwe46HD7dk6pfk+lJgGpt4USakL1E7OC?=
 =?us-ascii?Q?v4Sni487TeZqgKD8NNkdM7Tn7j1hgJdd6KtT4OTs6fts0vfC5/gZcWeO33CR?=
 =?us-ascii?Q?vgafbjJBZuF0xubnrTjSY4g7VvhFbL3KfCImF8eul/CPAdzKXzwGUTcmG4M6?=
 =?us-ascii?Q?iaQOoS37mcsosdBozV4jPKT0hD+kXBTrvKi40Umhi0MecE6V22dpPeIm7HNQ?=
 =?us-ascii?Q?WsAD3aWbzxbIWrrHrpCXyUlFbP/hzoBYCPi4rMYA9pN+PrcB9cZoo6IOt7d1?=
 =?us-ascii?Q?bvMdIuq8A9rctH5cE60kU2iEULlOz+zSumVTLmiulI05QlzzBQDmQlZd93mq?=
 =?us-ascii?Q?axxIJ1i6y8p6FFs58pLc7mm+Zd4i/Y3njNYZBTOTkQl/hHo/As+4fmSg89WU?=
 =?us-ascii?Q?E0WD7V5V53N4ZgYkxJKCVjTmfq71LholeGTa8c1sChHO+NgseU2BB7sFb6gf?=
 =?us-ascii?Q?RBvlT0h8yGWbc35tofTU1SRBdt9Tx61fLWMKCnnSpt0GCSFRMbVMkmPIxRma?=
 =?us-ascii?Q?Zg1NkWPWxEks8+rqHIo4aBFRo3LeMPtoo9QxlYMsgNrCfmJ0jEo8cZ5g+5Su?=
 =?us-ascii?Q?XEOLY/UspO2Paot0UofEjE+RM7bGq3S/MRQzxk+7Bqi/KJB+gAGL/jGgqeCy?=
 =?us-ascii?Q?mElXYlifUOZSSS3G3BMu3TFmsSULM921TupOX84NJEATHwdBni54Tnb3OFOz?=
 =?us-ascii?Q?BN5v0jeu4sQ8jTv69Qc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8784.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9f0a86-1fe2-4f10-4eeb-08daafee1b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 03:17:22.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6sbEy23TSBfI3magw+fiKZO/oCrn1w4Q5/mFOz1W6sULUHR0GdZf9Tf2sZ4McE0wu+T4x7nAOqYudTlf1UEXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8693
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Saturday, October 15, 2022 10:53 PM
> To: Peng Fan (OSS) <peng.fan@oss.nxp.com>; gregkh@linuxfoundation.org; ro=
bh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org; s.hauer@pengutron=
ix.de; Xu Yang <xu.yang_2@nxp.com>
> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-imx@nx=
p.com>; linux-usb@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kerne=
l@lists.infradead.org; Jun Li <jun.li@nxp.com>;
> Peng Fan <peng.fan@nxp.com>
> Subject: [EXT] Re: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert =
to DT schema
>=20
> Caution: EXT Email
>=20
> On 14/10/2022 05:51, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Convert usbmisc-imx to DT schema format.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 52 +++++++++++++++++++
> >  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
> >  2 files changed, 52 insertions(+), 18 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.y=
aml
> >  delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.t=
xt
> >
> > diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> > new file mode 100644
> > index 000000000000..c83ffb6729b5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tree.org%2Fschemas%2Fusb%2Ffsl%2Cusbmi
> sc.yaml%23&amp;data=3D05%7C01%7Cxu.yang_2%40nxp.com%7C24e82b830d9f47018ff=
408daaebcf83d%7C686ea1d3bc2b4c6
> fa92cd99c5c301635%7C0%7C0%7C638014423898086337%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DgNwMbG=
siuMS1zgvbgATYAY70gv2nIhX%2F
> 16IxiSYBf3s%3D&amp;reserved=3D0
> > +$schema: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A=
%2F%2Fdevicetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cxu.yang_2%40nxp.com%7C24e82b8=
30d9f47018ff408daaebcf83d%7C68
> 6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638014423898242035%7CUnknown%7CT=
WFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;s=
data=3DjJUP5aKNkfkAefhNQL9almV
> Gqzn8cTNyjcRlZMOZwRk%3D&amp;reserved=3D0
> > +
> > +title: Freescale i.MX non-core registers
>=20
> You sent v2 before we finished this topic. Is it correct? Even if TXT
> had such title, let's don't keep the wrong name.
>=20
> If it is non-core registers, why it is in USB? Why it is an usb-misc devi=
ce?

The chipidea's doc has a more clear explanation about core and non-core
registers as follow:

"There are two kinds of registers in the USB module: USB core registers
and USB non-core registers. USB core registers are used to control USB
core functions, and more independent of USB features. Each USB controller
core has its own core registers. USB non-core registers are additional=20
to USB core registers, and more dependent on USB features. i.MX series
products vary in non-core registers."

So we have named it like this.=20

Thanks,
Xu Yang

>=20
> > +
> > +maintainers:
> > +  - Xu Yang <xu.yang_2@nxp.com>
> > +
>=20
> Best regards,
> Krzysztof

