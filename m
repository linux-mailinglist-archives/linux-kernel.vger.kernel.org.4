Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736EF6F8060
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjEEJt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjEEJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:49:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A684F19D4C;
        Fri,  5 May 2023 02:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2FG65ZDbeT7y8e7UN1GUZFrSb2pWETzLw7uzfiHoosBbFZG20e1jhCh/DT4TIOVRDX0XH+oQL1DannpAc6fpVwdq60R2YTqmoiWXS3ZpUoMwzl/T9Ncf8yVtwCoqM/j9nPUEmxlDK9FSaGFTsrftRKha5cJ225BCLjukag3d9QNEQGv0IgVmyDttSLbjMY10LUJ6+TObGFcLP9tjWK1fpP02zJmn4g7LPa70gWS3P5LW0O5mq7aJUPCyfQ7y9FNW2KXrG9jppA64GdcwmbcFLqk8odEDNFd6d250um7c6xyKGhibM0xWZZ5/HvfH/OoGg34F9H5ZTirQrw9CYhgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH+g8OyLtKVrY7wUOznhreDJWCk5C7nhYBrbBny0AwQ=;
 b=gMForhdUigCtcMEL+sfOKrd3rqiAkRpNX7kUY6pTbBYFxhkV8Cf5rFVdSfQLhJnyKxjyBhYCvWKOBPLiwPsUqj8SNfWQfQCyia/23SQ4Oe93NzgEkxhBRQ2E5FMw6FMsTHT4ceJxSe4cctP8JymdqH3GMMsbL8eksSRT0MELYm88oUk5v7tru7iL4fXSQUgPpMVXw3MchmKpquKfqbrC/3h5dQArlrU/kElkQycz5IHyw5zCwo8y46CUYhN63Gi4zCtYparS0rSUgG4+UrAlz/hBC20s7tHBe1s19FDLW6V08FDQbrR5yriCTp5O+L6zweXO8tgX+XDIkko8OyS5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH+g8OyLtKVrY7wUOznhreDJWCk5C7nhYBrbBny0AwQ=;
 b=GtrOy1lA8tazrbWxzuK1TEhULw0SChepHLLhhmaUVK9HkOHPbNWHiLz4Tp5cIN2PrS/4XgMt5rPbtpL4aOCW77VhrNiDldGROzlrTFN/6MpQHn1PBSaBNtnhYscjNMQNvNqPd3UvgTbQNDuUfJmGxTyQY2GAHQH8HvuYQ6L6qTc=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by PA4PR04MB7552.eurprd04.prod.outlook.com (2603:10a6:102:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 09:49:16 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::adc9:9956:50dc:d10e]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::adc9:9956:50dc:d10e%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 09:49:16 +0000
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
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Topic: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Index: AQHWWfIP+etXd7nQnUiONRrlcYizuqkH0FqAgACfy4CAB2whAIAARP2AgAAEJ4CAACLRAIZATVEAgAAHjgCAARDykA==
Date:   Fri, 5 May 2023 09:49:16 +0000
Message-ID: <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
 <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
 <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
In-Reply-To: <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9640:EE_|PA4PR04MB7552:EE_
x-ms-office365-filtering-correlation-id: db8d845d-ecb1-4cfc-19a8-08db4d4dfd85
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fzTT75brXC6qYgvyOABfuSh8wEieJh+y/qHWi7LmY/8ZEUYhGs/Mff7r2cVAEAyZkZ75vPrFDGNT3Er7JlQtlHGt/lGo2j63h5eeM8l7/KD/3fDInX8ajLSqQAVa537lT8gBJ6cc6eSGsSV/4yZPsQgVh2pdeNEjOzJ0gGNqpzhzgoSiE+I3PT/x4YNQ9GZ1yUBWb83fzK7WEjYkHAvtriNzf2In72SxRcGbGS8v1sVtQJUWl27P2UeBkvcWXtPwPKQiYBIRIL5uVBEBVa8c56WIN5bnzyvi7g0PzC2SSdUMVuvLlcsnH99KyacaiiLwIc/useZJXQunARMvSPwdoyNpl27M3WfybuLPbLlZ8sP8tPsf5VEPfPKv6aEJnjKN6Uh4XUM4HwSViY1v72YpQwwrFjXqS9ZgAXv0+wtdXkUJq73N09Y5M2291EihSXH0q/FGCPbrgBXkZGsvrDAuLFBOU9qHx+drBwdvOeGR3MdBjW0E67poOJYYuFXr11bn6D0TcWPJan87aIE4VTDa7JA9npz894ylJEKyyH83j2ZToUspWzpxf13pKbglVl3aUKmQyPHYiXUvoPKxjV8ngPeMni5bPCwAn5bFh9/YU8I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(45080400002)(71200400001)(86362001)(33656002)(110136005)(54906003)(316002)(4326008)(66946007)(66556008)(66446008)(64756008)(7696005)(76116006)(66476007)(966005)(478600001)(41300700001)(55016003)(8936002)(5660300002)(52536014)(8676002)(7416002)(2906002)(44832011)(38070700005)(122000001)(38100700002)(186003)(6506007)(26005)(53546011)(9686003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fIkH8/UToteaGwjpt15njXjqUEMEWDFMbuExweQ2I045IFuAy7i6oFqziuuy?=
 =?us-ascii?Q?LLm7DgwPPLvC3R/6rKFf1k5I/hGp/95eycd51gVnNAASK8Q1G4xpQEwqLWF6?=
 =?us-ascii?Q?RCfY6w9PxsfshCO5BOjSP72WghF3eDfZNDWuG6+P8P1/A2/Y8aAKHE3MDBWZ?=
 =?us-ascii?Q?bCV5LhCrkuxA0mJZyQWooD0e0V1ZxIorBEvn3mCXtDssYbGA9EB4/SYrhrRS?=
 =?us-ascii?Q?2rgBV9CM0IcMjSxlnfkTViuQWrgj5HOZ6PnK5YlygGhksb3UnryvwfGsfNgz?=
 =?us-ascii?Q?I0ZUsgIfO30FrX0QPFMlWqkO9ZKvubx/di7xDZkTjk0c7dGbKUgEORLqBzOU?=
 =?us-ascii?Q?ebYYAB0ZwnBdEBmA7l6AyGMBnwrgDm/dLQYQy21K4SIOcOMKTTHH24B7rUkC?=
 =?us-ascii?Q?h6341abNayHLhRLjfZT5tkvmLxdzZ1ZR6VfqZ4L18sykWv0j45w18ctdHzr+?=
 =?us-ascii?Q?+S/LR8j0g0SFpRjW9niScZd5ECkuJ2u26hrDxHwSHXVXNEtWiIri2HYXKfBP?=
 =?us-ascii?Q?tr8l8DmqySOpkbiVMGBeTZA5zwVxCwsJ0iDryfud+rAN+66tjnSoRHfdbbqe?=
 =?us-ascii?Q?soFEdsSazY+4SsePDJWrQhK2FHPBrC6Brjvn0ob+3tJWX7ChTPAoP6W5jQ0l?=
 =?us-ascii?Q?fHiLmoVzI2ozTAFCnT3D4MBCSEyEkMlt8ao9T/KlHFguovp1o3g1Lgnk+pEK?=
 =?us-ascii?Q?z3xfOkJFs1PSOBFmOrWzqBgUYWk+Si7BfDj/CVS3m/aZF5NhzEk9EFSZBw5C?=
 =?us-ascii?Q?9vDosQBk6hlabLXwlAMkF3tUWi07cogg5ZXXdPCnEsv8aOFVzvYhaZMkKKbA?=
 =?us-ascii?Q?2uaBCQ+rE+6ElfCKXwKXlMGoT/HjcZd9BdJx/Do6sapVMayZr7oEBeXeQqK+?=
 =?us-ascii?Q?AvMPIxdqs2a6PO6MK6nDWHyzHHlPZNhOY66GMfF58EG9e7FmU5w5JKrBj89Y?=
 =?us-ascii?Q?Wtv3enJeJ1mGUWE7S0e5uBo5hf7vLonRfSzBC3Zitr/dQPM33pTGt7N0ndpe?=
 =?us-ascii?Q?3ouWXbwKb2a60lQmIGYtNTNm2R4KIsvsawaUDU9Z3nXGioKX066rs1D4Wp0c?=
 =?us-ascii?Q?y1El1KiHn2xtdjwfp7HbZvpzp437fB8X9ywVcYmCKgy+l59dd2qKAJpDC6iu?=
 =?us-ascii?Q?pMgBBF3UNn12EZElDAZhhxJMhAg/BMUCGhDGnBcMeZwHx0l+PMDQmHdOqxVp?=
 =?us-ascii?Q?fVEuR1Pz+gL2OUkQyLZVmUmNHnuM6DBBwfj7SIqrE16279FXSKPKDIUEixJP?=
 =?us-ascii?Q?FEfI2OIH2GZdtxeKgSwiFJiJoKG/sh5VfQuQnZ+4Kjb9mKNW10XxbTsvVLu+?=
 =?us-ascii?Q?NW4hUq/K47AUWG+2coxOZua6rR7eIuC9f+B2pMNLkHv70VhLH0NNhTHehRYH?=
 =?us-ascii?Q?AsmAmZGkKfnEtRvs4L0f9GXmxEW1rdKjRtZtsWIj7QIcbjh+fMldxrlgl9Ir?=
 =?us-ascii?Q?0dju7iG2cE9s5SlUaYc2os9w8De6Nlo8xr4c4xagZQPaHRrHJjztf1hZSi+l?=
 =?us-ascii?Q?GzYiu2chYRbHahZR+Y4dh8u/KCCZWwbEfARPp162ViSV3oE97yVLDWmkZyGm?=
 =?us-ascii?Q?TcTuItwajXimkxop4uk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8d845d-ecb1-4cfc-19a8-08db4d4dfd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 09:49:16.3620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWRkIqedzF/La4kPaID0YJDYnW1y1pX7Gr9TE0d8/n934HagOTdp7oDLQBe0QJf9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, May 5, 2023 12:50 AM
> To: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Cc: devicetree@vger.kernel.org; festevam@gmail.com;
> gregkh@linuxfoundation.org; Jun Li <jun.li@nxp.com>;
> kernel@pengutronix.de; linux-arm-kernel@lists.infradead.org;
> dl-linux-imx <linux-imx@nxp.com>; linux-kernel@vger.kernel.org;
> linux-usb@vger.kernel.org; peter.chen@nxp.com; robh+dt@kernel.org;
> s.hauer@pengutronix.de; shawnguo@kernel.org; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime=
-pm
>
> Hello Luca,
> I guess your mail to Philippe bounced, let me try to answer since I am aw=
are
> of the issue here.
>
> On Thu, May 04, 2023 at 06:23:12PM +0200, Luca Ceresoli wrote:
> > I found this thread after several hours spent in debugging why USB host
> is
> > not detecting new devices on a custom board using the iMX6ULL Colibri
> > SoM.
> >
> > My best workaround at the moment is:
> We have the same workaround in our BSP since quite some time, see
> https://git.t/
> oradex.com%2Fcgit%2Fmeta-toradex-bsp-common.git%2Ftree%2Frecipes-kernel
> %2Flinux%2Flinux-toradex-mainline-git%2F0002-drivers-chipidea-disable-r
> untime-pm-for-imx6ul.patch&data=3D05%7C01%7Cjun.li%40nxp.com%7C776dc1e71a
> 554ee20ed908db4cbfa5aa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> 188158228795706%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D3cFsUurgKBfic
> LNfRxMOErukGiMczhJREFGvaFYTH34%3D&reserved=3D0
>
> > I haven't found any follow-up patches from you, so I'm wondering whethe=
r
> > you have made any progress on this issue.
> You can find the latest discussion on that regard here
> https://lore/.
> kernel.org%2Fall%2FY1vLpaxpc5WBCuGD%40francesco-nb.int.toradex.com%2F&d
> ata=3D05%7C01%7Cjun.li%40nxp.com%7C776dc1e71a554ee20ed908db4cbfa5aa%7C686
> ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638188158228795706%7CUnknown%7C
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&sdata=3DxgIAlY5Az9zQgOBaUTHeGJDXNIyNRmEBlcR49JOVB
> sI%3D&reserved=3D0
>
> > As I see it, a quirk in the driver would make sense.
> I am not sure.
>
> The reason this is not working is that the VBUS is not directly
> connected to the SOC and the USB IP is powered in a different way (all
> of that was reviewed/acked by NXP when the board was designed).

Hi Luca,

Is your board design similar like Francesco's as below?

"VDD_USB_CAP in our design is connected to a 3.0V external LDO,
 voltage on both VBUS pads is 0V"

I am going to fix this by update the PHY power supply check to cover
Francesco's case(PHY is powered by VDD_USB_CAP).

Thanks
Li Jun

>
> The issue is in drivers/usb/phy/phy-mxs-usb.c:mxs_phy_disconnect_line(),
> however:
>  1 - checking for the VBUS when in host mode is not correct.
>  2 - checking for the VBUS when in OTG/dual-role mode should be done usin=
g
>  extcon or equivalent. In this case on the colibri-imx6ull you would get
>  the correct behavior.
>
> The NXP downstream kernel has some improvements on that regard, for
> instance 1 would work, 2 I am not 100% sure.
>
> Here the related patches:
>
> From 60422d8301fc354e69ec0184831468c3b65cc26a Mon Sep 17 00:00:00 2001
> From: Li Jun <jun.li@nxp.com>
> Date: Wed, 12 Apr 2017 05:31:17 +0800
> Subject: [PATCH 1/3] MLK-14285-1 usb: phy: add usb mode for usb_phy
>
> USB phy driver may need to know the current working mode of
> the controller, and does some different settings according to
> host mode or device mode.
>
> Signed-off-by: Li Jun <jun.li@nxp.com>
> (cherry picked from commit 2286cb30feedd6f4a5cb82a0f0af5aa3a04ab698)
> Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
> Signed-off-by: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
> ---
>  include/linux/usb/phy.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
> index e4de6bc1f69b..93963a018a13 100644
> --- a/include/linux/usb/phy.h
> +++ b/include/linux/usb/phy.h
> @@ -63,6 +63,13 @@ enum usb_otg_state {
>       OTG_STATE_A_VBUS_ERR,
>  };
>
> +/* The usb role of phy to be working with */
> +enum usb_current_mode {
> +     CUR_USB_MODE_NONE,
> +     CUR_USB_MODE_HOST,
> +     CUR_USB_MODE_DEVICE,
> +};
> +
>  struct usb_phy;
>  struct usb_otg;
>
> @@ -155,6 +162,10 @@ struct usb_phy {
>        * manually detect the charger type.
>        */
>       enum usb_charger_type (*charger_detect)(struct usb_phy *x);
> +
> +     int     (*set_mode)(struct usb_phy *x,
> +                     enum usb_current_mode mode);
> +
>  };
>
>  /* for board-specific init logic */
> @@ -213,6 +224,15 @@ usb_phy_vbus_off(struct usb_phy *x)
>       return x->set_vbus(x, false);
>  }
>
> +static inline int
> +usb_phy_set_mode(struct usb_phy *x, enum usb_current_mode mode)
> +{
> +     if (!x || !x->set_mode)
> +             return 0;
> +
> +     return x->set_mode(x, mode);
> +}
> +
>  /* for usb host and peripheral controller drivers */
>  #if IS_ENABLED(CONFIG_USB_PHY)
>  extern struct usb_phy *usb_get_phy(enum usb_phy_type type);
>
>
> From cf3f741f4b7ab5d139938c4c0cd65d4547d386ff Mon Sep 17 00:00:00 2001
> From: Li Jun <jun.li@nxp.com>
> Date: Wed, 12 Apr 2017 05:41:21 +0800
> Subject: [PATCH 2/3] MLK-14285-3 usb: phy: mxs: optimize disconnect line
>  condition
>
> We only have below cases to disconnect line when suspend:
> 1. Device mode without connection to any host/charger(no vbus).
> 2. Device mode connect to a charger(w/ vbus), usb suspend when
>    system is entering suspend.
> This patch can fix usb phy wrongly does disconnect line in case
> some usb host enters suspend but vbus is off.
>
> Signed-off-by: Li Jun <jun.li@nxp.com>
> (cherry picked from commit 2af48913f77cec3658f5863b13f63619d8101279)
> ---
>  drivers/usb/phy/phy-mxs-usb.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/usb/phy/phy-mxs-usb.c
> b/drivers/usb/phy/phy-mxs-usb.c
> index 8a262c5a0408..31f40dbb71c0 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright 2012-2014 Freescale Semiconductor, Inc.
> + * Copyright 2012-2016 Freescale Semiconductor, Inc.
> + * Copyright 2017 NXP
>   * Copyright (C) 2012 Marek Vasut <marex@denx.de>
>   * on behalf of DENX Software Engineering GmbH
>   */
> @@ -204,6 +205,7 @@ struct mxs_phy {
>       int port_id;
>       u32 tx_reg_set;
>       u32 tx_reg_mask;
> +     enum usb_current_mode mode;
>  };
>
>  static inline bool is_imx6q_phy(struct mxs_phy *mxs_phy)
> @@ -386,18 +388,6 @@ static void __mxs_phy_disconnect_line(struct mxs_phy
> *mxs_phy, bool disconnect)
>               usleep_range(500, 1000);
>  }
>
> -static bool mxs_phy_is_otg_host(struct mxs_phy *mxs_phy)
> -{
> -     void __iomem *base =3D mxs_phy->phy.io_priv;
> -     u32 phyctrl =3D readl(base + HW_USBPHY_CTRL);
> -
> -     if (IS_ENABLED(CONFIG_USB_OTG) &&
> -                     !(phyctrl & BM_USBPHY_CTRL_OTG_ID_VALUE))
> -             return true;
> -
> -     return false;
> -}
> -
>  static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
>  {
>       bool vbus_is_on =3D false;
> @@ -412,7 +402,7 @@ static void mxs_phy_disconnect_line(struct mxs_phy
> *mxs_phy, bool on)
>
>       vbus_is_on =3D mxs_phy_get_vbus_status(mxs_phy);
>
> -     if (on && !vbus_is_on && !mxs_phy_is_otg_host(mxs_phy))
> +     if (on && ((!vbus_is_on && mxs_phy->mode !=3D CUR_USB_MODE_HOST)))
>               __mxs_phy_disconnect_line(mxs_phy, true);
>       else
>               __mxs_phy_disconnect_line(mxs_phy, false);
> @@ -708,6 +698,19 @@ static enum usb_charger_type
> mxs_phy_charger_detect(struct usb_phy *phy)
>       return chgr_type;
>  }
>
> +/*
> + * Set the usb current role for phy.
> + */
> +static int mxs_phy_set_mode(struct usb_phy *phy,
> +             enum usb_current_mode mode)
> +{
> +     struct mxs_phy *mxs_phy =3D to_mxs_phy(phy);
> +
> +     mxs_phy->mode =3D mode;
> +
> +     return 0;
> +}
> +
>  static int mxs_phy_probe(struct platform_device *pdev)
>  {
>       void __iomem *base;
> @@ -793,6 +796,7 @@ static int mxs_phy_probe(struct platform_device *pdev=
)
>
>       mxs_phy->clk =3D clk;
>       mxs_phy->data =3D of_device_get_match_data(&pdev->dev);
> +     mxs_phy->phy.set_mode           =3D mxs_phy_set_mode;
>
>       platform_set_drvdata(pdev, mxs_phy);
>
>
> From d4c4385b997f32b081e859d491f25f5beb738ae9 Mon Sep 17 00:00:00 2001
> From: Li Jun <jun.li@nxp.com>
> Date: Wed, 12 Apr 2017 05:38:48 +0800
> Subject: [PATCH 3/3] MLK-14285-2 usb: chipidea: set mode for usb phy driv=
er
>
> After enters one specific role, notify usb phy driver.
>
> Signed-off-by: Li Jun <jun.li@nxp.com>
> (cherry picked from commit d3aa2a13f4e47bc7fae7f2eee1e86291d7513312)
> ---
>  drivers/usb/chipidea/ci.h | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> index 99440baa6458..9d7ba902246d 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -274,9 +274,21 @@ static inline int ci_role_start(struct ci_hdrc *ci,
> enum ci_role role)
>               return -ENXIO;
>
>       ret =3D ci->roles[role]->start(ci);
> -     if (!ret)
> -             ci->role =3D role;
> -     return ret;
> +     if (ret)
> +             return ret;
> +
> +     ci->role =3D role;
> +
> +     if (ci->usb_phy) {
> +             if (role =3D=3D CI_ROLE_HOST)
> +                     usb_phy_set_mode(ci->usb_phy,
> +                                     CUR_USB_MODE_HOST);
> +             else
> +                     usb_phy_set_mode(ci->usb_phy,
> +                                     CUR_USB_MODE_DEVICE);
> +     }
> +
> +     return 0;
>  }
>
>  static inline void ci_role_stop(struct ci_hdrc *ci)
> @@ -289,6 +301,9 @@ static inline void ci_role_stop(struct ci_hdrc *ci)
>       ci->role =3D CI_ROLE_END;
>
>       ci->roles[role]->stop(ci);
> +
> +     if (ci->usb_phy)
> +             usb_phy_set_mode(ci->usb_phy, CUR_USB_MODE_NONE);
>  }
>
>  static inline enum usb_role ci_role_to_usb_role(struct ci_hdrc *ci)
>
>
> Francesco

