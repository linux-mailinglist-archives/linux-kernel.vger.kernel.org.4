Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F06024F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJRHFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJRHFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:05:31 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C806DFA0;
        Tue, 18 Oct 2022 00:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVFkZiaihKGZkmImSXCaEubW5B60+KEvXxFNb2uKd06MD+SiTql9dMeufcgUtzk0mnk20q9DZiBz0+Cp0iczYvFZE3NpMlilvfRDuWlAJYeMn1XsBvy5yyQX2Vcdr5IIrIp53WDb+ocpERdtYq3Nuh0ew1a/+YSrDb/j3oinGnSV8S1I0hTRd52Sl5g4pkM1rrTRh8xZ17/KfYucIypOlVxgbucE+x6R22g+0wJmDeAVeC7TxoVl7OLCrtnA822a+4ASplLcf3QgFa1V+xq00zeS2ljZw+tt2DXBWUmeCxauz/vh6wx9Wbyaz2eOriMV1ro8NI0XFwNB7y0WatXd9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yi7yFsI/cUQYkKrdAxbMpIbB2fKR7YzSmFCE26QI0Rk=;
 b=mZy3N6JUDrZu02j6y0R8ypF8dDrDytALxrmMcyUXDU1DQqICjanmgIzBS03ru1SFvbkuDaF5gtvSSlrQ3Kq4CFW6tr1SrzMl8aEVjXuFzAQuuPfNXUiB6XBPLeqoWz3IOuyH+SH2O3Da5aP9twOqU+HlZf09XiuaGMsANhchGq13YCHPmpHUp/fGl91ZKyS6zdkESV5X6OEHCAEE4A12ql3ZM5rk/RFWW+7qcGBJTOHwyrGAK3rQ+HDaOB+axPb0VrqQzIW+BNoxS7s8T+yJREEEj+SbJB1FzEHb1gec3yfqGfiW04PqQqS7F75TDMYW+5ThI0L0RY73ePUj5G/q4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yi7yFsI/cUQYkKrdAxbMpIbB2fKR7YzSmFCE26QI0Rk=;
 b=KW2tZj5mzUKn/2hcBU0vARjojqu3jAUkHzzjwnWYKT5qsGI+ssFRpzWIb7lAb72N1gIeyKPJ0Iw6XGCzMSlT3gicPIXyusFBQUbaWXP+mgtCcYycBIPowdWEDT9JlgHEIpBvoeCnHNmT6kIP2hn2PNO9akmXPy1InxQA4ELAe1Q=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 07:05:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 07:05:24 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 6/7] remoteproc: imx_rproc: request mbox channel later
Thread-Topic: [PATCH V7 6/7] remoteproc: imx_rproc: request mbox channel later
Thread-Index: AQHY33pjL4ioJSeYvkqlTZaiTg9KJa4OK4mAgAO85tCAAPXHgIAA4lmA
Date:   Tue, 18 Oct 2022 07:05:24 +0000
Message-ID: <DU0PR04MB94171073005FC3DBC63611C688289@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
 <20221014031037.1070424-7-peng.fan@oss.nxp.com>
 <20221014174903.GA4125124@p14s>
 <DU0PR04MB94179580E85C888CDAA8EAA788299@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20221017173335.GA121862@p14s>
In-Reply-To: <20221017173335.GA121862@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7766:EE_
x-ms-office365-filtering-correlation-id: 31273906-28a3-49a2-fe2f-08dab0d72128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LUQFwQK9t983Mtj18DoXaaRNtVDzKNJgf94KbWBsk5/HimHveFEbcYZUi8KKr99jWZm9VkgtNr3v0N1YIYotBzZ+QgHCdC0txwfTDbmLS9ITBGX/vKRFgP48bzKrNWYlPn40Z339HsrrV8Mzo6rg7gHjNR1PCEZDKZfMeDPI9O7NDNQj+8sG6XEu/ym/bJmXnsgXDRxml/nhWtPKqCpShHScNjmeeWcQWDdNM5xUx9mlbrdEZhGKLu77VQcV5T98UtGbCfHaiEmj26nOmGN352CLdadVkmGnRBpCrW2nU9S+xbengkmJBHUCurMazj7vhjpchk523FoTUyhvxcSsVgD84dTsHQsyQwiqcvnGG5/PCCpQBUDMIksF3VrUe5xWHZrL76a2jhIXrFHXTZqIeCIw5vSChTSjssHjKuAc92Jir2erxuZ37Psy3WquZHqjYxI4O61sgfu8XO56fpmVWOU8CF2js5xXiGZl+u6sa+nLdMSBrmU38ZqsrHDBfXuJoCZ+PIJVB0CKlEqVYo7ecEatRItRUvMEgDnnenwsCO+K+7Pr9wYtdGaqvcQF/YCjblc6FayDQo3/CbtlKWPaKHHGfnZX3rjcVi5V83Ehn7T/agCutiY6mPHolZDLGs+USgHocifQbXRtJJHrPLkmkf4r1y8yHnQ5kvmeckgNW9iWlUIOPCAjP9wv6kYHv0lKAv8POpSWZYIpst0tNnTHtjZe53onAnyrncUp8HmtBrc79cittUJnwhASfyeY5AGGJs12LH0ssdgEVNZssT31nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199015)(6916009)(64756008)(66476007)(66556008)(66446008)(66946007)(54906003)(8676002)(4326008)(76116006)(33656002)(316002)(186003)(5660300002)(2906002)(44832011)(86362001)(55016003)(83380400001)(7416002)(26005)(7696005)(41300700001)(6506007)(9686003)(52536014)(8936002)(71200400001)(478600001)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dX5rXyJ5X8iUtp2mZO9LZ7R/ZCZncJVph+LCB/+flA5Xr92X3yrFX9d7nQhd?=
 =?us-ascii?Q?yj70bd/jy3PGL81fA2UStseO8k+c9alv+b1c39V2cd3xDJyBReSza/uGEoYP?=
 =?us-ascii?Q?ZgHIOxGn71d3w+8HUHIhHhlWpO+3VxZqDfQd4mVQPQbVlkEAMqzBcm/cIRoF?=
 =?us-ascii?Q?2MD6hOIllh+gShCLWI0ASPvHJ8i4yxXUywiUPqxgv2N4Zbh1fph/Dsh+BhIQ?=
 =?us-ascii?Q?Y9uqemd9qz9pQm6kibdYli0pZRH4GgOXwlMSndVZqU/k7FkrjfBpYv52UOpc?=
 =?us-ascii?Q?g+qaIja4FJIUQAd4+V3kV8siAImBHu28h75kRJSkJp4If3OJa/DrqnJuIrk3?=
 =?us-ascii?Q?SVfMPwTZCmoMAtmSUrWlMFW8iA0l+h3yaJo9acuGU3hbfkoFArEPJVE1vdz9?=
 =?us-ascii?Q?nWt/V+dGiz8CPJ1NBx7woUR17Ur5zx9rHlikRvHA4jpztZ6MhiLnFVmWkViy?=
 =?us-ascii?Q?xl8HixSuKj7ehyM3jvTo6yLp/yzL4jaeUhA50QfjSTgJhU4ZD9/eJFL15936?=
 =?us-ascii?Q?ekATo3Te+tcxw+5n49knPQRw/u9Rkg7QsFkd0jZ/DOqRSz7KSJ8dzq4x0m4X?=
 =?us-ascii?Q?Hyk7JicSaRJKzWqyt4R3tA111zPuBoJUjzwaPdwvjnqeo1YtgkodHb7i91ek?=
 =?us-ascii?Q?lDPLaLZFYRgG13nFJI4WNl8taWozEtPTFKqJ67ZkwOjgm0DYC/N+TMgHZw4b?=
 =?us-ascii?Q?OpUvIiqJTGGgLl3DPT9UiCkS6SlbiMqGDZH4mkAktqUv8vQjT2C2gUGLr93n?=
 =?us-ascii?Q?WIO8/WF6oc2gA3iZzdvsey9aSZNoRMXmyrL9nX1WInvunmJLB070cByIj9hN?=
 =?us-ascii?Q?pgMuN3b8jIR10ET1WkujbZ9qoSshd+u4xMPytB7ur2aeWGEtgQoSiJkIQLOx?=
 =?us-ascii?Q?huSk7KV41o79fDrrUvG+ske2MziNucfgThAZvBImM1tnuTNHiWjEzmq2UBNj?=
 =?us-ascii?Q?N1vNBovA1vL9Yo3HWPLbP0STOSTHE4EffCIifgjWsvUqQBkO05nQycSCaFsv?=
 =?us-ascii?Q?+Le+WwQGCIPGxZcUgwswc+7Rg0OYsNSjt/frxsH0V/w4T2gnfH/deEzWf1ye?=
 =?us-ascii?Q?MoOobVScpbrcKn+9pkYCzycVTzoN6DDeep7L1B05aQc/YAlv83JWvPxINFbn?=
 =?us-ascii?Q?YBBR0qUhuq3FMqdmIWZBh6c4UzLlo74Y/2AGC2s7WThJ09C0oMxus/E+XUYm?=
 =?us-ascii?Q?B7nQYL/iZtJpFQdhE+e+Oo3PCaKs8TwRWGBsIhFayYky5hKvAk1NktPYwNM2?=
 =?us-ascii?Q?c8YaQJvhrlWciVQVQqPAue3gn5kylfBzzdcHoNR1m+OC9q9hVJZ7eYBn9BrH?=
 =?us-ascii?Q?yU2xsJQxGZDwwWjdvsh4bEvU/FIBLRtgKT5wkSL91qYPPoDzaEVfqzqEz8w/?=
 =?us-ascii?Q?lr8II+zu8J5S3/XuxvfA2NalqaYYP5ZCDPZMlw9DmGOLmUBm/WjXN+A5yM9R?=
 =?us-ascii?Q?4MWZKjgAhofQxHUR79w87GEd/au6/gKmiuUOklX8XmgH1CzWiudkpIpBvwXm?=
 =?us-ascii?Q?aOgCGBQZGfYjwuAXCihLVIk184/iFDyqYjM7LlzHuFg1qP1WFufxnY/aKgT/?=
 =?us-ascii?Q?+Iq3c1IfmJYpZvUAzF4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31273906-28a3-49a2-fe2f-08dab0d72128
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 07:05:24.6513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KVYtK3mRa0WNTijIAMkS5Rf+sV4erys4nTRCLPzxeK5nFmuo3OGvrSWLu+qIMxmOXh9i/y6YigP6DxLLOnISWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V7 6/7] remoteproc: imx_rproc: request mbox channel
> later
>=20
> On Mon, Oct 17, 2022 at 03:13:16AM +0000, Peng Fan wrote:
> > Hi Mathieu,
> >
> > > Subject: Re: [PATCH V7 6/7] remoteproc: imx_rproc: request mbox
> > > channel later
> > >
> > > On Fri, Oct 14, 2022 at 11:10:36AM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > It is possible that when remote processor crash, the communication
> > > > channel will be broken with garbage value in mailbox, such as when
> > > > Linux is issuing a message through mailbox, remote processor
> > > > crashes, we need free & rebuild the mailbox channels to make sure
> > > > no garbage value in mailbox channels.
> > > >
> > > > So move the request/free to start/stop for managing remote
> > > > procesosr in Linux, move to attach/detach for remote processor is
> > > > out of control of Linux.
> > > >
> > > > Previous, we just request mbox when attach for CM4 boot early
> > > > before Linux, but if mbox defer probe, remoteproc core will do
> > > > resource cleanup and corrupt resource table for later probe.
> > > >
> > > > So move request mbox ealier and still keep mbox request when
> > > > attach for self recovery case, but keep a check when request/free
> mbox.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  drivers/remoteproc/imx_rproc.c | 39
> > > > ++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 37 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > > b/drivers/remoteproc/imx_rproc.c index
> 917e6db39572..1183de84a4c0
> > > > 100644
> > > > --- a/drivers/remoteproc/imx_rproc.c
> > > > +++ b/drivers/remoteproc/imx_rproc.c
> > > > @@ -84,6 +84,8 @@ struct imx_rproc_mem {
> > > >  #define ATT_CORE_MASK   0xffff
> > > >  #define ATT_CORE(I)     BIT((I))
> > > >
> > > > +static int imx_rproc_xtr_mbox_init(struct rproc *rproc); static
> > > > +void imx_rproc_free_mbox(struct rproc *rproc);
> > > >  static int imx_rproc_detach_pd(struct rproc *rproc);
> > > >
> > > >  struct imx_rproc {
> > > > @@ -357,6 +359,10 @@ static int imx_rproc_start(struct rproc *rproc=
)
> > > >  	struct arm_smccc_res res;
> > > >  	int ret;
> > > >
> > > > +	ret =3D imx_rproc_xtr_mbox_init(rproc);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > >  	switch (dcfg->method) {
> > > >  	case IMX_RPROC_MMIO:
> > > >  		ret =3D regmap_update_bits(priv->regmap, dcfg->src_reg,
> > > > dcfg->src_mask, @@ -407,6 +413,8 @@ static int
> > > > dcfg->imx_rproc_stop(struct
> > > > rproc *rproc)
> > > >
> > > >  	if (ret)
> > > >  		dev_err(dev, "Failed to stop remote core\n");
> > > > +	else
> > > > +		imx_rproc_free_mbox(rproc);
> > > >
> > > >  	return ret;
> > > >  }
> > > > @@ -592,6 +600,22 @@ static void imx_rproc_kick(struct rproc
> > > > *rproc, int vqid)
> > > >
> > > >  static int imx_rproc_attach(struct rproc *rproc)  {
> > > > +	return imx_rproc_xtr_mbox_init(rproc); }
> > > > +
> > > > +static int imx_rproc_detach(struct rproc *rproc) {
> > > > +	struct imx_rproc *priv =3D rproc->priv;
> > > > +	const struct imx_rproc_dcfg *dcfg =3D priv->dcfg;
> > > > +
> > > > +	if (dcfg->method !=3D IMX_RPROC_SCU_API)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	imx_rproc_free_mbox(rproc);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >
> > > > @@ -610,6 +634,7 @@ static struct resource_table
> > > > *imx_rproc_get_loaded_rsc_table(struct rproc *rproc  static const
> > > > struct
> > > rproc_ops imx_rproc_ops =3D {
> > > >  	.prepare	=3D imx_rproc_prepare,
> > > >  	.attach		=3D imx_rproc_attach,
> > > > +	.detach		=3D imx_rproc_detach,
> > > >  	.start		=3D imx_rproc_start,
> > > >  	.stop		=3D imx_rproc_stop,
> > > >  	.kick		=3D imx_rproc_kick,
> > > > @@ -720,6 +745,9 @@ static int imx_rproc_xtr_mbox_init(struct
> > > > rproc
> > > *rproc)
> > > >  	struct device *dev =3D priv->dev;
> > > >  	struct mbox_client *cl;
> > > >
> > > > +	if (priv->tx_ch && priv->rx_ch)
> > > > +		return 0;
> > > > +
> > >
> > > You did exactly the same things as in V6.  I asked you why this is
> > > needed and all you did is point me to the code in _probe(), which I c=
an
> read on my own.
> > >
> >
> > Sorry for not wrote down clear.
> >
> > > Again - why is this needed when we know it will be done in start()
> > > and attach()?
> >
> > start() and attach() not able to handle mbox defer probe. So I add
>=20
> We are finally at the heart of the problem.  I had to go look at the
> implementation of imx_rproc_xtr_mbox_init() to understand that it can
> return -EPROBE_DEFER.  Had there been a comment in the code to highlight
> _why_ the if() condition is needed, I would have understood right away an=
d
> all this waste of time avoided.

My bad. I could add comment in V8 if no major comments after you review.
Thanks for your time.

Thanks,
Peng.
>=20
> > the mbox requesting in probe to handle mbox defer probe, and add a
> > check when requesting mbox channel in start/attach. During first time
> > attach/start remote core, the imx_rproc_xtr_mbox_init just return,
> > because channel requested in probe flow.
> >
> > Since mbox requested in probe, why still add it in start() and attach()=
?
> > It is to support runtime stop and start(M4 is under control of Linux),
> > to support runtime detach(only for i.MX8QM/QXP attach recovery,
> > m4 out of control from linux) and attach.
> >
> > Thanks,
> > Peng.
> > >
> > >
> > > >  	if (!of_get_property(dev->of_node, "mbox-names", NULL))
> > > >  		return 0;
> > > >
> > > > @@ -749,8 +777,15 @@ static void imx_rproc_free_mbox(struct rproc
> > > > *rproc)  {
> > > >  	struct imx_rproc *priv =3D rproc->priv;
> > > >
> > > > -	mbox_free_channel(priv->tx_ch);
> > > > -	mbox_free_channel(priv->rx_ch);
> > > > +	if (priv->tx_ch) {
> > > > +		mbox_free_channel(priv->tx_ch);
> > > > +		priv->tx_ch =3D NULL;
> > > > +	}
> > > > +
> > > > +	if (priv->rx_ch) {
> > > > +		mbox_free_channel(priv->rx_ch);
> > > > +		priv->rx_ch =3D NULL;
> > > > +	}
> > > >  }
> > > >
> > > >  static void imx_rproc_put_scu(struct rproc *rproc)
> > > > --
> > > > 2.37.1
> > > >
