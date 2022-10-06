Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5718A5F6479
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiJFKoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJFKoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:44:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C648597EF2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoCDaxzE3SKvvfFHvcrh6XfzV4tb8ZIhtTRpND56vpqWmJE57Tke6YWB/sGdyixC7DecnHUd75K1GNGubRdOOEaJzXWGQEJAKzLlLh0L3BcZc/h8kEbQ/eckr73BiHrpuzOmLF+g7T1lN7YgwDfoDA2BtOEuJcHjgTmoK3iLbRiIWWskqlI5f6sOhCZBrtTmXgtnxO78ck8yi7+UsBXw7LRZdyZQNzr6OOolKqS92ikqfa/d8blYqSIlaNH5jVs+FtxVNMmNA/p/S7IldsMtsiYMBFKYpWuCf6ZmALoi5r2Xc6NH1kfI0E+AXmj7PeKVwDjorfVe3WyY6lcMzf6rbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAIKcKHx1v1EOIPRljAQCO+pKPjyvkuc0WBxXxxgsJ8=;
 b=jF6/+1TX5K7ku3pFuhFST00yQQAFnt83+zLp8VFEqkOTRx3DZKAk0OEZ2VL/pWR4xwJvCPVLHeNvVNhBo2iuEifecREtNOvEb74xtoAyhg3TVfjtxIyTTp8eWnzEIid4EQnrummdAnTGSM8X/CeNez22xmjm0FsnmyJXc/R2ea3JJ3Z7u+9ZUlmVo+QzyiFbfJIQrSDBlHJTGaUjiUMqOPP7ieT0wzkzAG8IrnfkNoC3YSFvMZ02RlDQPGgSUIDvqMlZSDRPiR/hvQS+QOHh2pusGHiLbBdonmupi2DXk5vZrD3PW1sWHZT2R74hJ6cV9SDkIDDx6jOcTXyJnnHpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAIKcKHx1v1EOIPRljAQCO+pKPjyvkuc0WBxXxxgsJ8=;
 b=VshUUAezkvlulQ75jqp0BRZaBhWrQ46kEhKV23nOaDZbvo5Ngrrftw59sUCrsmbS6GAt/Kd/ieC6t3mNsuOK1mdQ72HJi6oWc7PRREKHs9ZEJ9nhVpdAn4Xbjk9Sye0C3IaRLaCuaEDsjaDqndRCo3QZhtzx65wLkG0OsDWvr0E=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6847.eurprd04.prod.outlook.com (2603:10a6:803:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 10:44:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Thu, 6 Oct 2022
 10:44:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ying Liu <victor.liu@nxp.com>
Subject: RE: [PATCH V2] mailbox: imx: fix RST channel support
Thread-Topic: [PATCH V2] mailbox: imx: fix RST channel support
Thread-Index: AQHYy9PylouxuLcz8EWVOIHjv5pRIq4BSYlg
Date:   Thu, 6 Oct 2022 10:44:29 +0000
Message-ID: <DU0PR04MB9417E587ED9439309510B34A885C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220919030136.1055409-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220919030136.1055409-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB6847:EE_
x-ms-office365-filtering-correlation-id: 1b8c7b9d-d663-469c-ab54-08daa787beef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yeRpS7VeEwcPBqi4BOSd5q2pUcgYts+1+QDb5xr+Mx0VWx0wtG7+gNKP9udZ4xAemDSfOyKBgoN91J7T5BcjKOglrFZlM5GXc2vEIZPB76YbcYEyNfqspt1ZhLSQnrNqv5H42+E7BCzClkS1HknPzGyZ/kVfuNoPHx5g5F9DyUNJ4v8hRlcyBr1gd8w0Ky92b9M95Xx+W2Gkh3DjMY5iBKWZYRbObzTBrlHFX2U/g1xSbu6U8TEJyBnokdKGYamnl/OU8mXmepvA7KXC6NjjtK3SmR6y2adibU7hNAeNj5IXrB6b1nO/YvuLC9CC1jETeH1kOdTzP4YzzIg1aVlLt3CQs8PVXYUAbIFIsgzSxUGubVvkflGBWH2xev52f1IZIyNXo0OE7222LcyToIRfgCWP27830cXDCm4ixDkUzLrYqw28ZPec44BXpKnoKOwzFD3da5ItKtWEkfLlNX/NGA1yaKfCjiB9eu18te/LxpQva+Lm+BIeptv6MUoHH0uwMIqhyUPh3CJH/02zH1MhRWalyVT2tvqV9iitaN51FMZ/gRFdVy3h+93fHI5m1OtIvmS7LKs6Ha1uRf3ZlIVACdeH1lnkZ8/NI9a2ggICW6kxp8eLlTrXgNH9ngeemb/9FB8HL4lE12zA6fUz5rolHJtYoaqNrXGSXKGqA0ms9mod/nKlhvBnoTphXNYz5yklxSSf/h7mAWtQIrr8Vaek4ZNC3lCnw/c3sa9zsdYt28yZKzYjGxUJ2zZe1EQtUT+YDMDuhEFnMY4yDvN1OY4qjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(83380400001)(110136005)(186003)(38070700005)(122000001)(38100700002)(44832011)(2906002)(41300700001)(15650500001)(5660300002)(8936002)(316002)(52536014)(54906003)(55016003)(478600001)(7696005)(26005)(71200400001)(6506007)(76116006)(64756008)(4326008)(8676002)(66446008)(66556008)(66946007)(66476007)(9686003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MwVherY6ReA7XoyTygy6X0n+pznlAscOI54fiJZLvNFetaD/gKmYEhUOzQsk?=
 =?us-ascii?Q?fFAlB8TSRyjL5lfK6go/R+xxavIZVFB5D2Sn1rRC8tZWfJKUpCZcVqcdV7pd?=
 =?us-ascii?Q?k7kDKIf1o4LD25uuDEhxBqbt52+QX4rNhuBMa85BDDMaWXanYbFimY18tHmy?=
 =?us-ascii?Q?FCfZ+Ao/H/DgdXYMDOrmVxzruTOx4dR7zIl9DgWbysO9iMTeAxMoPvKTGxMY?=
 =?us-ascii?Q?97L9GbYpr7Akpx+StSkmT61u8Ppvi/5UiHQntX1YGKvaIv8BY8r5xGiEMfyj?=
 =?us-ascii?Q?NC1pWWQyVAysTDIZGrHDACaK98X6DqY2aexkHCisHjtGzkqNQEj4SsPBbMKG?=
 =?us-ascii?Q?LRQ422tAUmBsuAkvBHLwDZKd+DvGL76Bwwp22Z1qQeNYgZwb0XWZyJpaI1KC?=
 =?us-ascii?Q?swyzail4QCmfvl5QAEdNIIVbGt2bZx2xuS6gYmLAQZfY3mwnOZWC2SL0x+d0?=
 =?us-ascii?Q?DuR8jC2QNP5QB3V/v9VksOX6W48EGVyUQX7EQ26PPZJMMI2L3XeedPoexD0x?=
 =?us-ascii?Q?lC4yBOZAwLkiIF49bBqihphP3j9A4Gk7JJvzkXLuq22uR42f9y51GUKofd6+?=
 =?us-ascii?Q?tWfnGnKu40VeiD0bwHk0Q7hNhENHY8RejbNUcm5VDhRacYHepZQyZktTSkuI?=
 =?us-ascii?Q?INrT5wM8jjH7zHJ2D5Nlvo72JjKT6TbKZ8YVxsWr+xajnQs/4Y36t6w6ZjvB?=
 =?us-ascii?Q?L4dsJ1ew0Zy18UJ7eaZZI+nfMvv2z846hkzJdwwLgiSx/D1CbPhFkAsBB28d?=
 =?us-ascii?Q?VLNxp38MpHacoPrI9zvuqxESfBS4ywLFdQCaaV4ic4wAqFmCNFSaMgQjYgnq?=
 =?us-ascii?Q?fjGwrXvxP/vYc6sfsqbDpssohqts0xN8alP5mYzdpPASNB6gei6lIALxwbZY?=
 =?us-ascii?Q?aD/5q4M2SkTR4YnnAcIDG9itteCkWy8ulGd1HImnfaVJuw+aInfaO+du3IES?=
 =?us-ascii?Q?qRjaW8hNJy9p9vXCpy5WF3MMKdbE9LWkrVz8UWwJRg0wLOR6PQh47a377jwe?=
 =?us-ascii?Q?2d8kVwHwDC3KKFi4wPrZU8tj8Z9vkx7u8JyYCzL2+9/U/bE7zV3AeHHkel7i?=
 =?us-ascii?Q?Yq/Q5mwoPar+h3KRAbPicpR2L0PPkJpMmhJCqoPCCz577LE+url1F1I9Qw93?=
 =?us-ascii?Q?mrH/rTt7XijQ/W3ltDxNr7Qk31LcH6HfyhTszcmdwnjAuqPLKT+S6LiW4sCD?=
 =?us-ascii?Q?iWP6yfVVGADc3BifmEA98GW92pzhZWRJToVvfgRIdxGgG0CqsqSZRVIJz96j?=
 =?us-ascii?Q?Tf9/A9b6VemLz65lFzHJebRY0zXiBmXwmVCL4vCJIqsi/104KZ8E1cO6pGKd?=
 =?us-ascii?Q?HxLO40NrB62d2V87AnilaU8IMBSah8bzJB4NGLkiHzsW38Dqh3NzAk3KrLrL?=
 =?us-ascii?Q?Yrvlh/2MpCG/ZdvDuS7K92a7X/b7i+r838LHbD1fvyRQTSeJizBiphMP7tdP?=
 =?us-ascii?Q?v9TFPRoE+AZhnknOO5b1SN/blJ5eWrPIRwUAGwXGciufXRzhkdVpjB6yHaew?=
 =?us-ascii?Q?aNAUZIdHnrppE3CXBdQjztdX2hWLAF5gdV+k55beH+TicUss00Nxc++nfb/j?=
 =?us-ascii?Q?BJRIXLBIj06QBjqQsmQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8c7b9d-d663-469c-ab54-08daa787beef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 10:44:29.1835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMmfPL1e7eW57QqvtRuBO1BVW5KZYBjDZ99ZGjB/zVyC+ttux0jgmQ2TiEzRKaL2rkc39EgkcsRSVDDSNloNhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6847
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

> Subject: [PATCH V2] mailbox: imx: fix RST channel support

Would you pick this patch?

Thanks,
Peng.
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Because IMX_MU_xCR_MAX was increased to 5, some mu cfgs were not
> updated to include the CR register. Add the missed CR register to xcr arr=
ay.
>=20
> Fixes: 82ab513baed5 ("mailbox: imx: support RST channel")
> Reported-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Tested-by: Liu Ying <victor.liu@nxp.com> # i.MX8qm/qxp MEK boards boot
> ---
>=20
> V2:
>  Correct Fixes commit hash
>=20
>  drivers/mailbox/imx-mailbox.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.=
c
> index 02922073c9ef..20f2ec880ad6 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -904,7 +904,7 @@ static const struct imx_mu_dcfg
> imx_mu_cfg_imx7ulp =3D {
>  	.xTR	=3D 0x20,
>  	.xRR	=3D 0x40,
>  	.xSR	=3D {0x60, 0x60, 0x60, 0x60},
> -	.xCR	=3D {0x64, 0x64, 0x64, 0x64},
> +	.xCR	=3D {0x64, 0x64, 0x64, 0x64, 0x64},
>  };
>=20
>  static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp =3D { @@ -927,7 +927,=
7
> @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 =3D {
>  	.xTR	=3D 0x200,
>  	.xRR	=3D 0x280,
>  	.xSR	=3D {0xC, 0x118, 0x124, 0x12C},
> -	.xCR	=3D {0x110, 0x114, 0x120, 0x128},
> +	.xCR	=3D {0x8, 0x110, 0x114, 0x120, 0x128},
>  };
>=20
>  static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 =3D { @@ -938,7
> +938,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 =3D {
>  	.xTR	=3D 0x200,
>  	.xRR	=3D 0x280,
>  	.xSR	=3D {0xC, 0x118, 0x124, 0x12C},
> -	.xCR	=3D {0x110, 0x114, 0x120, 0x128},
> +	.xCR	=3D {0x8, 0x110, 0x114, 0x120, 0x128},
>  };
>=20
>  static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu =3D { @@ -949,7
> +949,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu =3D {
>  	.xTR	=3D 0x0,
>  	.xRR	=3D 0x10,
>  	.xSR	=3D {0x20, 0x20, 0x20, 0x20},
> -	.xCR	=3D {0x24, 0x24, 0x24, 0x24},
> +	.xCR	=3D {0x24, 0x24, 0x24, 0x24, 0x24},
>  };
>=20
>  static const struct imx_mu_dcfg imx_mu_cfg_imx8_seco =3D { @@ -960,7
> +960,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_seco =3D {
>  	.xTR	=3D 0x0,
>  	.xRR	=3D 0x10,
>  	.xSR	=3D {0x20, 0x20, 0x20, 0x20},
> -	.xCR	=3D {0x24, 0x24, 0x24, 0x24},
> +	.xCR	=3D {0x24, 0x24, 0x24, 0x24, 0x24},
>  };
>=20
>  static const struct of_device_id imx_mu_dt_ids[] =3D {
> --
> 2.37.1

