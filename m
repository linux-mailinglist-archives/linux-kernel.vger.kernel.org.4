Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D12963338B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKVCs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKVCs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:48:27 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952895AE;
        Mon, 21 Nov 2022 18:48:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOf9a+sDJ91eXwY7ki4a85gh43rxXRJP7OYWtqvEeDIsOotf/7Evy0OgygVJl677qZgjYTWmKExTNBzVVclO6UDop0WVXUhjv8XuMkmtGYyG8bUxh4Eq097B/pIGh6eYeZzQPD3vpld4NTF/dKIuC1jhhipiYWq60oEbbNJPnhlCLuTZ2ddfBv+Zki4b0AAAIO/S+PfqG1VIt5158r/Vvb+Ntp0/dBVol8+SCWW8m5wZ0WNVQpzmW3lo8w9URbMlc3p92Zvt83u0b0Ta1ht/77a3UTpRmoaejesiDx8m0DIN56WD60iCottJn7OR+nN5ho7lO1oFtBzM5QX3JqF7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDp3y+CPAlmmdp1JcfHB8EXsPUN2nKmXyzh9COYcxQM=;
 b=ZMexnQzrqNF7oQLxfpxkb0V3lDptu0E5i3g4ZY2bYzP/NhA3GGCdKcnp3FvL6zdZxMPcD10zR/QfPBwR/NnX7kqVpkgkdpdIPyKOAPsfN8nQjMbFuulv5pyqBZUNtd0hJVUX7e+PGbgEZWNy2RdD3SeZfDA5NUHYPU8c9J0Iv1Eg0HyDamJbT9CQQkAVmaCaGaOSnu7suyeAbDt6rhsN69WEONHmde+M4ZvguTc7/aufeYDT610RZizBkA3ZL7cGPKb8oRnVJ4bmKgdmjYdyuv7O+B/RPl5tqt2NDANBu5iQ7lCfOTDjzA+A1pE+ZufrTmkdroekkWWXxZWUhry6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDp3y+CPAlmmdp1JcfHB8EXsPUN2nKmXyzh9COYcxQM=;
 b=YsDxyQnBNXgOfjeE2Clnp9+cOy0c/Lac49IGXbUIlLtbhQtUGGRK71A5bQVxv06XAhc1xFwzGM5celhOE9eRRuaE/8r6DIv9Hmbfr6JtaIbZ4dZ8AiIgLX9u1rlOz0gq513G8ukDXZ/LhJ2gB1MJpfPBlpQTDJn8zWB1ohWbpzg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7954.eurprd04.prod.outlook.com (2603:10a6:20b:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Tue, 22 Nov
 2022 02:48:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%6]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 02:48:23 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amarula@amarulasolutions.com" 
        <linux-amarula@amarulasolutions.com>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] clk: imx: replace osc_hdmi with dummy
Thread-Topic: [PATCH v2 2/5] clk: imx: replace osc_hdmi with dummy
Thread-Index: AQHY+njiWWXxSLCmxEKfq4XiQQY88K5J1mgAgABsx5A=
Date:   Tue, 22 Nov 2022 02:48:23 +0000
Message-ID: <DU0PR04MB9417ACE65DC5AE841BEC5324880D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
 <20221117113637.1978703-3-dario.binacchi@amarulasolutions.com>
 <Y3vb1r8G+B8n3T+A@linaro.org>
In-Reply-To: <Y3vb1r8G+B8n3T+A@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB7954:EE_
x-ms-office365-filtering-correlation-id: eed14ccd-4421-40a1-f272-08dacc3405b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bFwkGgwJ/p5aRBXN4iDejx07c55SgvLEgrOvDsUpAkurt/6Vt7UsuLqpgqGjhJr6ZGD4M8Bz60HozwJSmAjiCmiyXv9xA3apXkEurkBCtYmO8Yrg4JiRHBGJ1yEs5rhZaLqN1zO8vnVq/YgMi/2IXFjubyF6i1W6WK/7noLcFdk6XYlzRCeQNabEVpH5XiAs5UHC89yBfq/Br1lrwxDaD1WUGxl2BkSxInIkjmWOUFnqEW6m0eU+uP8x7WyXAkI0SdXWyyoBK4T6NtwSclfDyVaKs2b4VB3LTuah61O0eHLMgc6U2e6/ApzyPZGfvuAnh+pJlaSKW+9nL4X6Q21ejSvQUDCrloMM6SWAHvbRnSnM9J80iCquihm/bBUMpKFD106ct7isbV6ycI5LC7mg6BsTiiTPvydd/JYisikBfODMMSBKMxbpdPQLAyRfomVAkdhv6rLpjyFozpsJvrXyrPhaaps/WCxN+ze7NdASzfPdnmLMVsUQqU2T/esDkzr9zR5vfZPNdKfM9Iu4/e8nhuGq4O5PeR2UruMQznmJPOaopK4Vxh0ZchjAylMsx+w2VQ2y1W0pRlGjgOdPqMqhtzInp5QqCHpr/IAswIxS+9/STPoi8qAsR4aU+QJCCBAVfheQONjM9Q5+mfM8qZtdjtU65OI4W01A6OPV/isHDtzmw8+7VaGWr75+MHgPI8Q0ISkIUQAuVMLLkSW284xfeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(41300700001)(7416002)(33656002)(44832011)(52536014)(86362001)(64756008)(76116006)(66446008)(8936002)(66476007)(8676002)(66946007)(316002)(5660300002)(4326008)(122000001)(186003)(38100700002)(26005)(83380400001)(71200400001)(110136005)(53546011)(7696005)(38070700005)(6506007)(478600001)(66556008)(9686003)(54906003)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uwTsiVbPJGmYJdXQs7N1Gw6phKum07hPsNhtsDDP1N5v1HJpxZNKsgfJHJLG?=
 =?us-ascii?Q?c8O4z8IqqqKCMVxkcYfQmt2yXmWG7tGTDv4LvdIdATkvzXBYg+A8jVaNM53u?=
 =?us-ascii?Q?yCiBesJtG69ZrpFqKirWeVQQpmEitnj1uwEouTbjuCYT5FmrfQQUTzN3DSIZ?=
 =?us-ascii?Q?Rx4mPpE5siq6l/iMuNVoBRn8Bz47Nmmvj5V8wf7YKuKDhmrkhLRqXAe7Jjnf?=
 =?us-ascii?Q?8nRzfhJCNqFMx3/rsjIv6+Eda0yBlccxBtt2+XfiPYQJ/Kehjkx4eOVhTUtz?=
 =?us-ascii?Q?uWbdNg25PBecnSD8Oxkmcj9L4L3x0GZMyeEZmbkLVTn6O5RIu4TRaY3dAEic?=
 =?us-ascii?Q?BwK+40BtVIPbCAY8pjDqUdsftxc4CtKVk5CG5Gnl9JCajTSdv5iREVH4bpH8?=
 =?us-ascii?Q?YfShGqn6ZHrMTQn+KBQ68D9FBnz0gymeo1ef5LiIY4OrEE5DxyVyG2OL4K0R?=
 =?us-ascii?Q?E7dFzQcAvU0w0aiqSg03+pby1hDgSqrMYT+c6Sdhsd9HQc+9vzxoxWzZ6LUu?=
 =?us-ascii?Q?L7uM0AdXtJokJ/8HfclkXnbiS16a9qsQZ3YLotrs+nQcHmMZi/iXzDpqrIi6?=
 =?us-ascii?Q?ToG5O1ttJmZy5+IsM+80jYjzOPrH4Ad2YefnHb+0ZOR9RuIR91ZWIWie4uHI?=
 =?us-ascii?Q?dU0/JylgjrYFfIxc0PQviEw69csTe3GvbZ8uwS1sOTs9Q1xzlq2kNHs39dbO?=
 =?us-ascii?Q?+NC2MrJVYtxNpN/22AVi6v19cVnzWVW/ZuRyVWrIIYBYE1Rwj4PCER1soGGF?=
 =?us-ascii?Q?gCsWvoiuLMm19bdSrEEpbEFQlMJwFUweHtWqMFCXB6hyXXD/s/MiKmTiFKB/?=
 =?us-ascii?Q?gU3cOk4/XmZCK7L96K30IZ/Hx4lbgUAWlxyy/0xVSyLratQe4AjL2Aj36lna?=
 =?us-ascii?Q?oByXgKrQnOmlZRKTzvNOYwZf8t9sceLDXU1Q4xrvSSr8A3aPRQcgRaNPYO4l?=
 =?us-ascii?Q?LoWJ69LPYELIbx8GaVPT4AUVnfWfa7y/7OWHLVR3HLU8q11FSgF8tI6HY8U7?=
 =?us-ascii?Q?qSc2sYuVvuyqx5oRNaBIeCT0vzuNsAviP0zPk4/J8uuicP4sc1/a24dSlmlu?=
 =?us-ascii?Q?Up0FlFfMulptEKwTejmX1NPUZqkcV6j5p9B5BS1rrVeahd6U49b76F/NqPJ1?=
 =?us-ascii?Q?2fZ8QTtSGELEXVHeZiUFv5VKX2n02FG0XCWR8BYquYwPcQ/a0RYuPGyqz5mv?=
 =?us-ascii?Q?ByVTPlEIPHCLncQ7LqdvdQseepiCfR5x3x9fo22EpbJQAuSBnBrN/l/vVmrS?=
 =?us-ascii?Q?4BoKxKN5g3rPeGE2KV6y02LK0DHOqTGTn9am8VX7+II7NTii/I/keun0UYc5?=
 =?us-ascii?Q?2rKKEnoauiHWp8hM99qhwy0222gtgdLKABG/Sot8BfbFFwTT4x2FviXhOEeL?=
 =?us-ascii?Q?U90qx3FyWQqKqOvB0yQFkvLbe1GFPlrLCEoY7brP/SNp87HHNZqAOzfvi2Bk?=
 =?us-ascii?Q?4XouhkrPjJKjDDAy/8gqXXokk5iMSNVoChB+++f5gbXEfVcmtwAR8Ypgb9ie?=
 =?us-ascii?Q?KLtYf4xHioIR1Iu0LaEntG+9iF+15dcFSj645EQAnzndkYK96FxfIvD1vjpK?=
 =?us-ascii?Q?D4lBcZ6br6Tskn3t+UE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed14ccd-4421-40a1-f272-08dacc3405b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 02:48:23.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVBzJhCFM9lGz9PelRtfPLMGHodHb6WkIt8G7zgMiTaDNOOnqvZzYA/mHgqIt4171O+R3LkBmlFiQAjLFe3dpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7954
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v2 2/5] clk: imx: replace osc_hdmi with dummy
>=20
> On 22-11-17 12:36:34, Dario Binacchi wrote:
> > There is no occurrence of the hdmi oscillator in the reference manual
> > (document IMX8MNRM Rev 2, 07/2022). Further, if we consider the
> > indexes
> > 76-81 and 134 of the "Clock Root" table of chapter 5 of the RM, there
> > is no entry for the source select bits 101b, which is the setting
> > referenced by "osc_hdmi".
> > Fix by renaming "osc_hdmi" with "dummy", a clock which has already
> > been used for missing source select bits.
> >
> > Tested on the BSH SystemMaster (SMM) S2 board.
> >
> > Fixes: 96d6392b54dbb ("clk: imx: Add support for i.MX8MN clock
> > driver")
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>=20
> I don't think this is correct. It might even break the EVKs HDMI support.
>=20
> Peng, can you please confirm ?

The reference manual not has osc hdmi as clk sel. So It is ok to use dummy.

Regards,
Peng.
>=20
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/clk/imx/clk-imx8mn.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mn.c
> > b/drivers/clk/imx/clk-imx8mn.c index 72f9563a0ff6..0fae97e61e2c 100644
> > --- a/drivers/clk/imx/clk-imx8mn.c
> > +++ b/drivers/clk/imx/clk-imx8mn.c
> > @@ -108,27 +108,27 @@ static const char * const
> imx8mn_disp_pixel_sels[] =3D {"osc_24m", "video_pll1_out
> >  						      "sys_pll3_out",
> "clk_ext4", };
> >
> >  static const char * const imx8mn_sai2_sels[] =3D {"osc_24m",
> "audio_pll1_out", "audio_pll2_out",
> > -						"video_pll1_out",
> "sys_pll1_133m", "osc_hdmi",
> > +						"video_pll1_out",
> "sys_pll1_133m", "dummy",
> >  						"clk_ext3", "clk_ext4", };
> >
> >  static const char * const imx8mn_sai3_sels[] =3D {"osc_24m",
> "audio_pll1_out", "audio_pll2_out",
> > -						"video_pll1_out",
> "sys_pll1_133m", "osc_hdmi",
> > +						"video_pll1_out",
> "sys_pll1_133m", "dummy",
> >  						"clk_ext3", "clk_ext4", };
> >
> >  static const char * const imx8mn_sai5_sels[] =3D {"osc_24m",
> "audio_pll1_out", "audio_pll2_out",
> > -						"video_pll1_out",
> "sys_pll1_133m", "osc_hdmi",
> > +						"video_pll1_out",
> "sys_pll1_133m", "dummy",
> >  						"clk_ext2", "clk_ext3", };
> >
> >  static const char * const imx8mn_sai6_sels[] =3D {"osc_24m",
> "audio_pll1_out", "audio_pll2_out",
> > -						"video_pll1_out",
> "sys_pll1_133m", "osc_hdmi",
> > +						"video_pll1_out",
> "sys_pll1_133m", "dummy",
> >  						"clk_ext3", "clk_ext4", };
> >
> >  static const char * const imx8mn_sai7_sels[] =3D {"osc_24m",
> "audio_pll1_out", "audio_pll2_out",
> > -						"video_pll1_out",
> "sys_pll1_133m", "osc_hdmi",
> > +						"video_pll1_out",
> "sys_pll1_133m", "dummy",
> >  						"clk_ext3", "clk_ext4", };
> >
> >  static const char * const imx8mn_spdif1_sels[] =3D {"osc_24m",
> "audio_pll1_out", "audio_pll2_out",
> > -						  "video_pll1_out",
> "sys_pll1_133m", "osc_hdmi",
> > +						  "video_pll1_out",
> "sys_pll1_133m", "dummy",
> >  						  "clk_ext2", "clk_ext3", };
> >
> >  static const char * const imx8mn_enet_ref_sels[] =3D {"osc_24m",
> > "sys_pll2_125m", "sys_pll2_50m",
> > --
> > 2.32.0
> >
