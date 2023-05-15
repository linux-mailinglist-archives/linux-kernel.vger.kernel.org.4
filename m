Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670E77024C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbjEOGdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbjEOGdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:33:23 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C236C139
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9HK67mWZ2ND9rxkxCcjbM+vOJiIl0SECO0jOMywG53CgHN72ziM4eRJYj16jc4+prhgbJQJAM9odq4wEmWc2iznOZhR+Tx5Rc28UTgzlJCTpt2e1yEpUf/ukojipsCw2Z9Yh0+G5EL+sbF94RtGxCRsPWiwR1DTHNwh5SVw197pIJ8+nDLGM8JtmvdbjT7vodGW3j5IcLOd2Zl9Bb/u333Lv9/fVC5M3I1xA/mXVeYkJTeiiG7LTf8/svumyv8vRWrK27C+ooCPJkV29QINdUMpEbH+l3lWxQ8498OaKS2mKAivGOQZKLEJtuEcd0Pa660BKj3bZPtDf3ZLvsRhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fjx6kynwmhSOMku/aZoXGMfsfv1TwWzEG8hKoqz+kro=;
 b=Q+Vcp1rfBCjGSXbDYUgxmipirug6QBv0HWY1YIYRa0HfqOI9f5zbjKdojTjg/PSDkSeUXqp4E53xkxBUqzjvkWjJjCJbDtPAybeDBjUwoJZ6rofhi/iJujydPb7bAl7V7iQa4CrkJtrJDFx2vo+ZEPrej7MVfjEkxMlu2WXeXjTDtbnSvHsEfihUnu6+Ir1QlwbIL/37uvTn10DIgal/cMLgGXPLh3XAUHHDObOg2XMxTThEh0JXLxUy3vyaYo3zx88c3LMmPvyuWH97mhc49fcPuQn9FpkOmJZxKKUfVqqqzI2kJLT2/flsAndSI5+RJW4p42ZIKHwN4LyfD7635Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fjx6kynwmhSOMku/aZoXGMfsfv1TwWzEG8hKoqz+kro=;
 b=RxNNNbfIFgFyH257HQZBZP0x10zLDVumM87gFV+0uPz3uFNdptAoEYKUprF4addeAquPwckOnstqjDlXfabBXLmEDR55rZC9jJ+7ReT7oWUij8fdq6lAzF1ECHVbjAWfirNWyUWNyMCw8Sx/Cc79mvDoV9L8vUspjv3JqLH8F4I=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 06:33:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 06:33:13 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2] soc: imx: support i.MX93 soc device
Thread-Topic: [PATCH V2] soc: imx: support i.MX93 soc device
Thread-Index: AQHZglaw5NYrHwJNokmcm/x+hxQdrq9asCWAgAA5PVA=
Date:   Mon, 15 May 2023 06:33:13 +0000
Message-ID: <DU0PR04MB94178BD13190BCA6C7980DAD88789@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230509091942.2923330-1-peng.fan@oss.nxp.com>
 <20230515030741.GC767028@dragon>
In-Reply-To: <20230515030741.GC767028@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|GVXPR04MB9949:EE_
x-ms-office365-filtering-correlation-id: a6ab28b7-f53e-4323-c4ba-08db550e4266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8KUj6q63g7dFn1j8yoWUrVyl/k2mO9VqMfqlj/Xcped+QcA/D8A6pLBcH7snscJkgl7OP5IdIE3nA5QCCaWQWFcYM4JY1qK4Bf1rLrGSv3E7MTpUPfTHu4qILDLucCZFMGsjW22su5QkMArWyt0wSrXWowbg0eLONy+JeHDZjzKTwBaQmkFoxxwblU8y3BKOkFWKt4bt46eEZqg8Z9epqYXHheIx+cGrmF/4EFE3jlV88krn0CqXmxFTHMnjP/KZeBwfZ/tH0AB4UoUyIrgOIqYb+QKGUwOmNCNVnM1MjOwipL+KS5RlfkryHQ7mo+245d2Os3ft/JDOTS35mH7GjTHaPX8lfBti6mjt65SJdaohY1lMZUt78zm8rH2EWNT2GjlVj0bD+VIWmWBSG9v9LtZ9BjSvhjHLHixssH3HZcTfe9YXMIILhddG9ldeUWGRaZaMLUXqH/DK7EtO2BwpU1M7b7q2RmRQ0VHRMxnA2tpBoxRUI6o3AlFyYc8D1dN57lMLJOLrlZkhwUuCSE70XhcXugpZ1dV73a2jZTrLColjjERKzMiNPAyArkL4K8EKdXWw+MPyFd3U2tKg5CdeV1MsfXcvOc/1/oWhFGzoTHZBiU+VOYJXdvGwK9rkJLOh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(966005)(66556008)(66446008)(64756008)(66946007)(66476007)(4326008)(478600001)(7696005)(45080400002)(76116006)(86362001)(316002)(54906003)(110136005)(33656002)(83380400001)(26005)(186003)(9686003)(6506007)(71200400001)(41300700001)(8936002)(8676002)(5660300002)(52536014)(44832011)(2906002)(55016003)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5aufEM0hVPwW8+/GW3Wux/y3dwCzSbpAqRUfGJcqLNOq1DKzel1QpYa8n3jz?=
 =?us-ascii?Q?N9m5fKxrnlGTydzyvfoUZpNp9JwZ5ByXPiEDv+k0yEUtLyvWevjEm4pdbu1K?=
 =?us-ascii?Q?5DqoBgwa9aIaO3a8TqanHwWmwXXy1rpDuZyfDr4jC7RHa6pq3S5dM8JHVCr/?=
 =?us-ascii?Q?elw7s92diexiWqCciaFFz9Wtecsb7O3vcaqYYHMuUR8ixdRzvUCyAqcj/pvC?=
 =?us-ascii?Q?SP/h3WhW8aT5gHK9vKkUxCFeh+8gewIqy02oh30MkJAh0Nc7ceW9U4DyMydW?=
 =?us-ascii?Q?JRx0P8gV0y1iKm4w5/7QNFgWTORK7TJ3rVxTPqCYABNiT5XY+/P1BEi+J1h5?=
 =?us-ascii?Q?tw3+lQF/uokCnCoyMeTE25IRqxJZSP6Fc4lYPs4rOgzfbWlIDpMMxSEbLgWO?=
 =?us-ascii?Q?KSfZ0QdScAiw5RRsEIayieIEAQmmMeH/mDKU02DLbfDy4nzfKabBhNUuAYrF?=
 =?us-ascii?Q?wRKhV1E6He8WjAgP5CwPzuiQclAPBwbGXMpGp5jqL+CxPFT1aMJttmIEwByi?=
 =?us-ascii?Q?RTLGIOgu9cHoT9ex4L/u14GGCPImt4ZSILcyWYeOEVnU1L38Eq/TeioKU/N+?=
 =?us-ascii?Q?TqDJ3meO3M9AUT9TxLfR9oniSlMpjmenNFqZu6ICKsPcGS1QKiD3UPVYD2pt?=
 =?us-ascii?Q?qTy8/+IwQZbtId61WjblIIZDl/pcDds2FED9/XgfbmNZWY+Nknsd0P0yDPBf?=
 =?us-ascii?Q?FpBbmDH4qHHxvUL3NPHhXLJ5nfoq89nKjWCraXdItuvodJNE6a0drHx5/5k2?=
 =?us-ascii?Q?ha1DBlUPO11j/q/d6mx0GKRPLtn6hHoRufANyuO0WO7kc7dPWhC858g04Ipd?=
 =?us-ascii?Q?6B4D0jjJIyoleU004mNtjUdAVkSU+VDQUbFqfXYgehEGaBOAebKmlpeObEAs?=
 =?us-ascii?Q?Q7VduAeuNV5LeHl9sJUrXZvlpnJbDS2K0Dz2o565re7lF5HMvlv0tr/GXsvO?=
 =?us-ascii?Q?MUS1Utn72QH2vD54Vx3Fr55himqH+uwvy/rU75Efiw6Hk0sg9rGlh8+lQZtp?=
 =?us-ascii?Q?F09Bi8Gf/6/GNxlUhhRFdZKLjlQkKxKaT2aImV5NjevKmSt3itLFMoz4/Mkw?=
 =?us-ascii?Q?K3LPAqk1+22rj1hkyk3B+iA3KecWYRH+zDbqZZFLkEI1hMztGUxNu+Zjgj10?=
 =?us-ascii?Q?Odjr3QIO6xvXDAoQse44pRWypcUxAKDowhRW0AgHJEKqGHFyoSlrSPU5UMei?=
 =?us-ascii?Q?Z9KIQtGmhTp+1bfCs+9VSGNpk0ujJY46GxVHslkost/tntBNp7mFEOGF2fYs?=
 =?us-ascii?Q?hd20FGI1cAE8xq3uwCZ/qHZEQF5EGpHAdDk+ovlIuKGKRwAEeiic9D/JEN9c?=
 =?us-ascii?Q?NTwGGuNy75u+Bwn+OISdNshfv2fRnFWgc/8uJcCUa2gSw6n/14CZSH37BRPb?=
 =?us-ascii?Q?1jKz34kfVn1JmDNV1bCMeHn5CV782ZCarMsHggMiCgZ7MjM/m5qMDMKlRqz9?=
 =?us-ascii?Q?0ly+r3NymNoyA0x5KWfLBWbkD0Myv1ktgUCjwu2+3Ks64RF9FVwF3ZhynGDi?=
 =?us-ascii?Q?H3/UxqBMVu3nohRfhn1UtLKHKOfKBHTMF5S5tDqGdqYzTXb6QV4rmqjVWwKP?=
 =?us-ascii?Q?SoWla1c0Wx+dK0u1ce4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ab28b7-f53e-4323-c4ba-08db550e4266
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 06:33:13.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFw67HznuxggBkq5/+jzT0FmB9s0cBq0u0gmgUVNYHJRj5UIQIIQz5I0O2i30KmTT/wH+dhPVc0mGckt5vhz4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn,

Just posted V3 to address your comments.

Thanks,
Peng.

> Subject: Re: [PATCH V2] soc: imx: support i.MX93 soc device
>=20
> On Tue, May 09, 2023 at 05:19:42PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Similar to i.MX8M, add i.MX93 soc device support
>=20
> This commit log doesn't provide too much helpful information.  You may
> want to briefly introduce i.MX93 UID, which looks something new?
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  The ocotp yaml has got R-b from DT maintainer:
> >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore
> > .kernel.org%2Fall%2F01be24b3-aaf2-e27b-d00e-
> f8649a497463%40linaro.org%
> >
> 2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7Ced8cd9c0eac146837e8c08d
> b54f1950
> >
> 5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638197168793784
> 144%7CUn
> >
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haW
> >
> wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D2QBo%2ByyZflXjzQ%2FW
> 8jQBlald6Gt
> > w9kyUIu0pP2iIqhg%3D&reserved=3D0
> >
> >  Remove uid_length from V1 which is unused.
> >
> >  drivers/soc/imx/Makefile    |  2 +-
> >  drivers/soc/imx/soc-imx8m.c | 64
> > ++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 64 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile index
> > a28c44a1f16a..83aff181ae51 100644
> > --- a/drivers/soc/imx/Makefile
> > +++ b/drivers/soc/imx/Makefile
> > @@ -7,5 +7,5 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
> >  obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
> >  obj-$(CONFIG_IMX8M_BLK_CTRL) +=3D imx8m-blk-ctrl.o
> >  obj-$(CONFIG_IMX8M_BLK_CTRL) +=3D imx8mp-blk-ctrl.o
> > -obj-$(CONFIG_SOC_IMX9) +=3D imx93-src.o imx93-pd.o
> > +obj-$(CONFIG_SOC_IMX9) +=3D soc-imx8m.o imx93-src.o imx93-pd.o
> >  obj-$(CONFIG_IMX9_BLK_CTRL) +=3D imx93-blk-ctrl.o diff --git
> > a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c index
> > 1dcd243df567..0e69b8b48183 100644
> > --- a/drivers/soc/imx/soc-imx8m.c
> > +++ b/drivers/soc/imx/soc-imx8m.c
> > @@ -25,8 +25,11 @@
> >
> >  #define IMX8MP_OCOTP_UID_OFFSET		0x10
> >
> > +#define IMX93_OCOTP_UID_OFFSET		0x80c0
> > +
> >  /* Same as ANADIG_DIGPROG_IMX7D */
> >  #define ANADIG_DIGPROG_IMX8MM	0x800
> > +#define ANADIG_DIGPROG_IMX93	0x800
> >
> >  struct imx8_soc_data {
> >  	char *name;
> > @@ -34,6 +37,7 @@ struct imx8_soc_data {  };
> >
> >  static u64 soc_uid;
> > +static u64 soc_uid_h;
> >
> >  #ifdef CONFIG_HAVE_ARM_SMCCC
> >  static u32 imx8mq_soc_revision_from_atf(void)
> > @@ -141,6 +145,53 @@ static u32 __init imx8mm_soc_revision(void)
> >  	return rev;
> >  }
> >
> > +static void __init imx93_soc_uid(void) {
> > +	void __iomem *ocotp_base;
> > +	struct device_node *np;
> > +
> > +	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx93-ocotp");
> > +	if (!np)
> > +		return;
> > +
> > +	ocotp_base =3D of_iomap(np, 0);
> > +	WARN_ON(!ocotp_base);
> > +
> > +	soc_uid =3D readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET +
> 0x8);
> > +	soc_uid <<=3D 32;
> > +	soc_uid |=3D readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET
> + 0xC);
> > +
> > +	soc_uid_h =3D readl_relaxed(ocotp_base +
> IMX93_OCOTP_UID_OFFSET + 0x0);
> > +	soc_uid_h <<=3D 32;
> > +	soc_uid_h |=3D readl_relaxed(ocotp_base +
> IMX93_OCOTP_UID_OFFSET +
> > +0x4);
> > +
> > +	iounmap(ocotp_base);
> > +	of_node_put(np);
> > +}
> > +
> > +static u32 __init imx93_soc_revision(void) {
> > +	struct device_node *np;
> > +	void __iomem *anatop_base;
> > +	u32 rev;
> > +
> > +	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
> > +	if (!np)
> > +		return 0;
> > +
> > +	anatop_base =3D of_iomap(np, 0);
> > +	WARN_ON(!anatop_base);
> > +
> > +	rev =3D readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX93);
> > +
> > +	iounmap(anatop_base);
> > +	of_node_put(np);
> > +
> > +	imx93_soc_uid();
> > +
> > +	return rev;
> > +}
> > +
> >  static const struct imx8_soc_data imx8mq_soc_data =3D {
> >  	.name =3D "i.MX8MQ",
> >  	.soc_revision =3D imx8mq_soc_revision, @@ -161,11 +212,17 @@
> static
> > const struct imx8_soc_data imx8mp_soc_data =3D {
> >  	.soc_revision =3D imx8mm_soc_revision,  };
> >
> > +static const struct imx8_soc_data imx93_soc_data =3D {
> > +	.name =3D "i.MX93",
> > +	.soc_revision =3D imx93_soc_revision,
> > +};
> > +
> >  static __maybe_unused const struct of_device_id imx8_soc_match[] =3D {
> >  	{ .compatible =3D "fsl,imx8mq", .data =3D &imx8mq_soc_data, },
> >  	{ .compatible =3D "fsl,imx8mm", .data =3D &imx8mm_soc_data, },
> >  	{ .compatible =3D "fsl,imx8mn", .data =3D &imx8mn_soc_data, },
> >  	{ .compatible =3D "fsl,imx8mp", .data =3D &imx8mp_soc_data, },
> > +	{ .compatible =3D "fsl,imx93", .data =3D &imx93_soc_data, },
> >  	{ }
> >  };
> >
> > @@ -212,7 +269,12 @@ static int __init imx8_soc_init(void)
> >  		goto free_soc;
> >  	}
> >
> > -	soc_dev_attr->serial_number =3D kasprintf(GFP_KERNEL, "%016llX",
> soc_uid);
> > +	if (soc_uid_h) {
>=20
> Unnecessary parentheses.
>=20
> Shawn
>=20
> > +		soc_dev_attr->serial_number =3D kasprintf(GFP_KERNEL,
> "%016llX%016llX",
> > +							soc_uid_h, soc_uid);
> > +	} else {
> > +		soc_dev_attr->serial_number =3D kasprintf(GFP_KERNEL,
> "%016llX", soc_uid);
> > +	}
> >  	if (!soc_dev_attr->serial_number) {
> >  		ret =3D -ENOMEM;
> >  		goto free_rev;
> > --
> > 2.37.1
> >
