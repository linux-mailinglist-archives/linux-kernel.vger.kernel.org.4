Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18BD6F90C5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 11:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjEFJDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 05:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjEFJDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 05:03:15 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0628.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7202C61B8;
        Sat,  6 May 2023 02:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2ImhejtFy3OUceK7b76DGNWFjzNNduf8sgTjdXFdRnSUS5J0wrvBVb+uGbCq6GHhtFJ6h+bK0ovvYttZEF5eLJ3jLc2UXMsic+R4GvBUexkZyAd7Tg+BriR+ctyW0CFBAEgGly2b3hV5E3/sv71aNMhGVe5/stVK6nxyLhXWooEcuFuuPYwcdhGonKH8TwKPi5PJCjoTdexG9pbQBHVc15lCCLR2oOFsWRxXc/5hF8YUBTXOEleX/i1VWzMeOyOtp1pDOZkPhlRJ6jYkgg927Q1feDJWpQ/pD2feIFiXAxJTu32xngEiW3GhlYt+TC9gsEsffKLCp2VVO/x3UJp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcMhxj5/wYLAsFvxl/TEUfzFor2gIf5YZ8CJCsArfqk=;
 b=KW4TBDwUc1Q51wWks2K4IUlBN309Z3KTKHe1rybCqyklTZAoT421LaBofmpGydpU3iofRS1zP/kxMSWIaCRDzpct5iyj93FcgyXA/mLNYbnCdd5FKXU5zHNUest3kwvmr5l91dT7IVhSVIm1RgvLHKc1AaJ955YDIOmq4i6jgEK2ZJeEMIVvUkly5kBhbOeHH1xeY5gsl5gHVCsS7mEE3fSCpyTHeLiae72H42DlQNpxXmPXWylDtmIVrdG838csYTTo4Pa1LVGCa5EuAL0EeySiuFDFsKBXzeIRcinMi/3HyuPCZUEOE6IKJz/Mju+H4dt2PCO3T6OUF+zSMnlwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcMhxj5/wYLAsFvxl/TEUfzFor2gIf5YZ8CJCsArfqk=;
 b=eofj/HzzZuvI+L/CQj/Mm7v6C8VfAaHZikN/ARi3d3hopihwmbK432wA+Odx0yhYJy4EYYxpvTEwyjZ87P4txO8lFz8YxPUQGoT8dZbrLkrreBMLOdUtgsT5DBnJLxSimCthoQPTZXTMqvexTYTr64NYIoMmo0an8lz37gjuMc4=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 09:02:40 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::adc9:9956:50dc:d10e]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::adc9:9956:50dc:d10e%7]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 09:02:39 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Topic: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Index: AQHWWfIP+etXd7nQnUiONRrlcYizuqkH0FqAgACfy4CAB2whAIAARP2AgAAEJ4CAACLRAIZATVEAgAAHjgCAARDykIAAEIcAgAAPIACAAABSsA==
Date:   Sat, 6 May 2023 09:02:39 +0000
Message-ID: <PA4PR04MB96405EE2468555EA900B340189739@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
 <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
 <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
 <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <20230505120618.2f4cf22c@booty>
 <ZFThyn/D/dDK9nk3@francesco-nb.int.toradex.com>
In-Reply-To: <ZFThyn/D/dDK9nk3@francesco-nb.int.toradex.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9640:EE_|PAXPR04MB8576:EE_
x-ms-office365-filtering-correlation-id: 905bf78f-5809-4a7f-b285-08db4e10a4f8
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SR/G2V+LCJfMvlJ+QLgDrfOgZkCBo+uVwVjcAf6pH8Gh11eimrExp7xjMXVyip6flFxP7M0hPXTUx3R2uhhRl9HIeBiNwGteJOMvbCXsXDqwglT6I91K9cQZFex+SgtF4O9juQCH55ipnh9RH1LAcfi24VvFU59JgCsODoTralNl7v4pCEnC05PhzqV5g2a62vAkxBYMhfm4X5TpaVBa5ghdL+VGsavt9gayTwxJHBdjZr4V4R/JW0yu41mJxPrXolXvVdtrpEbw+PpufQBaBhVtDskYcgXgsFcSSl7YgYXZI2wpoTRCHH2innQYlsKADf/43bIsam2LeP4//bJdASUq2ONQrG3rDMkGzFsU+u4l/cChssZP6TTzvmYRl+k6Vq5BqRdWnR29Rbq/R8nrW2/J4U7ILy5Tw8DXgovY/DqUJeY2jY4MkGhddFbARjpH1GbsgccSXHtHZWpENburnU4C1mnDZDxQZFom3EGt8knKQ/B1NfFiYJuqzTvsMzk5ad10Dy0jBpmUxGeKh9ToSmThNmUuUXVPG/VnBb/4iblbiAn/VKQ+/711mobyQ2paDtUJMxqN4pc7yfrREutKONhPOKSDydV6KT+UYnnemPUyqRyaUR4kbBrxAAPc26AK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(7696005)(71200400001)(83380400001)(55016003)(186003)(122000001)(38100700002)(86362001)(38070700005)(33656002)(26005)(6506007)(9686003)(53546011)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(76116006)(2906002)(54906003)(110136005)(52536014)(44832011)(41300700001)(5660300002)(7416002)(316002)(8676002)(8936002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TrcnDkMRsQh+WADdnTMmhlZsit2MKrA/ddsJGXe47tkaquBb3elA4asQZmmc?=
 =?us-ascii?Q?wrwAsPeOvoqUv8HAdAkj8DiPHipoXh0vdsAdNQaSZStv/UDdaFeBQKqF7yvr?=
 =?us-ascii?Q?qdm/kYoKimLEyB1NJCo1xaLjPeAEGnwTvKDhf8OzAJBS+TTb+N/Sf4VS7Z8b?=
 =?us-ascii?Q?xB4CkXbVJ4/03cC8a2RT14V+omr6Usk+WKpefrPjs1Eu3EpEJ7mQVJeFIDpJ?=
 =?us-ascii?Q?TG0Kpy6SVPuhmqMhknQpmbUoNPMcQL/GUmQfBofR1RxlgTKnMQEIXhDDNpNZ?=
 =?us-ascii?Q?wpziXh98aMyMVgVP8RJWhf8lEj4hZDJdpJhLtr5fCnvNoABvHLb3rHtWMpKl?=
 =?us-ascii?Q?/U6HOmmzuko8RWMhSSlaF/1LB4Pd1XGRsiJZGiCB5X/O+FXDU00gZicOApR3?=
 =?us-ascii?Q?T6KoLtmlUeHzOc1jQytgmBHZBHuLTSXfS0CW2uPBccBt1pO83hIuTS1UwRRB?=
 =?us-ascii?Q?gsggtbYBzZY8fLUdT7z5MuP+mU8Lmf/rIzfrlX9iZSuvkrIm6nUrnOrKsqv5?=
 =?us-ascii?Q?V8SkrBuIoJvjrIREjs92MtYl2PI7CvCPy8twv7hn9sCQu+nvqNPSNE6SOpMz?=
 =?us-ascii?Q?aREG1Kc5wRxdd+NYgzK2K+10dTjLodcYXIqbyj4Lom+zmyuLiIscwAz2aiWX?=
 =?us-ascii?Q?E6VheLpdDjHj73ut8CyLV/L+mQ0ns7KgnrNc0/RFL2v0/fRzV2nk94SNdDXh?=
 =?us-ascii?Q?Qk8LYK6PEaXF6jH99nipuLy7dAqLMsrQbpUUHikiG1FygSWm/+hZUOMm+wxv?=
 =?us-ascii?Q?bApHh2awQ38Y8jWO9qwkSqqxFddTGIDyGgEdaKnGsllOP7panSnYikV2RTHg?=
 =?us-ascii?Q?Sp+1ag/4ubayPv4l9H/3WbMUSsdbn/yD/Tq+Gz1kg60a6oewBijSWlL7WOSg?=
 =?us-ascii?Q?rdS2dfpLsSfpC4X1KbLsHCg9CNcWoz8LbH2nOtJztbJZJRNtZena8NrFzXhK?=
 =?us-ascii?Q?gyHemW68002ohDGk0azJBB/T7z8YNJ1JBf25YlB6g4FP7+d2Stvm+R/2OkM9?=
 =?us-ascii?Q?31TEE8lvjOWFNU2e8mVY2sTlUM6aCXz3Ukj9liIOInVaFw2tgb2IOdx/mfBX?=
 =?us-ascii?Q?2CREHd6a+BZKDanCwk750zu8tQ+bKIWPie3Ex6o/kvBK2utnd1AEUHDFQC8/?=
 =?us-ascii?Q?q+UbhIf/3omU6z9oZrBGtuGVQvfRD+NQxTPt5xOFEWoJo/CbCmLzHXJ4GFgC?=
 =?us-ascii?Q?qEBGmxbZWbvfTRgKjRheW+75qwWtqmRvuFgSUW3MTmrqg3+gv5Xr0St/Xc1p?=
 =?us-ascii?Q?8bGkc76IUWJnivw1bi48dd4qCdXYkbCzlpiO07g435Avg8wFUWjUQ34EmxbL?=
 =?us-ascii?Q?V9JZdBfnoRXUvT7oVNekmKdr/XdDiHNCJDDb8caIFqf3W7vs5nIXvI6vAid1?=
 =?us-ascii?Q?JjoX7TtgCMiCskGrUYFN1ehRKK+XRZ5cJLyirUpLm9uM3FKKJtRy7saafw3h?=
 =?us-ascii?Q?FiYBtO4f03DsgJNWgoLgogrjr/Vac0rWWlgvMkXMaOKJU/tMa9yhCR2/RJIK?=
 =?us-ascii?Q?rNL+ckifvaireURDRgnUjn7evHthwvlDXEYrbZAVNTjbGxKMzB51qn9Dm49x?=
 =?us-ascii?Q?HvjYU3s9APG3QfEZfbo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905bf78f-5809-4a7f-b285-08db4e10a4f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 09:02:39.7176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrkH+w5gWS26t0yTnRsJ6hEcFXHdA6WZxfTCPLShsCLKcDNE5dcfDV6xc+HCK4ZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, May 5, 2023 7:00 PM
> To: Luca Ceresoli <luca.ceresoli@bootlin.com>; Jun Li <jun.li@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; devicetree@vger.kernel.org;
> festevam@gmail.com; gregkh@linuxfoundation.org; kernel@pengutronix.de;
> linux-arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> peter.chen@nxp.com; robh+dt@kernel.org; s.hauer@pengutronix.de;
> shawnguo@kernel.org; Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=
;
> Francesco Dolcini <francesco.dolcini@toradex.com>
> Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime=
-pm
>=20
> On Fri, May 05, 2023 at 12:06:18PM +0200, Luca Ceresoli wrote:
> > On Fri, 5 May 2023 09:49:16 +0000
> > Jun Li <jun.li@nxp.com> wrote:
> > > Is your board design similar like Francesco's as below?
> >
> > Possibly, but I'm afraid I can't say: I am using the Toradex Colibri
> > i.MX6ULL SoM, whose schematics are not public.
>=20
> I can confirm that it's the same.

Thanks Francesco for the confirmation, had a check with design team,
there is no status bit which can be used to judge the VDD_USB_CAP is
powered or not, so we have to add a board level dts property to tell
this usb phy driver to bypass MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS.

Before send a formal patch, I want to confirm this should work for your
HW design, like below simple hack:

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index e1a2b2ea098b..ec5ee790455e 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -178,7 +178,6 @@ static const struct mxs_phy_data imx6sx_phy_data =3D {
 };
=20
 static const struct mxs_phy_data imx6ul_phy_data =3D {
-       .flags =3D MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
 };
=20
 static const struct mxs_phy_data imx7ulp_phy_data =3D {

Thanks
Li Jun

>=20
> Francesco

