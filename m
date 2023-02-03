Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FED688DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjBCDbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBCDbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:31:21 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20632210B;
        Thu,  2 Feb 2023 19:31:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZVA+LhNmVZW36aPKd5aAGL1fx/mRv9OMlDygHelvup3hYAbUey50q+vbSbB0llOHWPNITZwd4jHpXLou4hFsNmpHmWfaM6lnVMywWDnknm84z+Yo5yRfewa91eBuOC5rpS4bnj/oU7Gzup0kXPh0DnDjoBwKziKnLxeFgvmAgQ8ojD58wnslPEVhhO2EVnvQC2dQ1TcSFoXkRwNIe/2IyEgUQ06ZUNdkscq8zX0mQ4U+o+jH2Uji2D0pgikdPLLZNJbjBSLh//y+WQcfpueXhDpwapHzPqfvTS2wwZPIOk7FWIpMx6m90JcQdDsgvrwLkahb6dQWXUA07UTmerWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFWjzmnG8+gARiespARV2NNFiuRO+KtqNciRMDH6iKQ=;
 b=bO2eWVFvuFY19vCo689PCcB1XXlFDxrVR3l8BH24bGDZKiyv5wLLi+wK8pXcE9dB4zeHIRqNNH7iZiOLJVMYmh//wkFRlfUsiwM2TzN5IHP3+YGrGs+OkBQP+d3yXTHm8WY5Y/jQTywV4qCFsdehGpwG3F/NneWJEmfuStzL4YoCAdazAyei7KbJBjKt//gZfiZ8dHK1ObcR3fA2wIoAs2qKiugi5Jj+KQi09MIxRFz3fcbKygtdzYz/7x12LqrS7/hhxJVu6+Mk2rWaDdA39f7jjSuQokEodNmRsv5HD18gzD69kPUtnH+HgH2BCl3ZJ3NEgEeDo2jDFUIrD3b6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFWjzmnG8+gARiespARV2NNFiuRO+KtqNciRMDH6iKQ=;
 b=dqdmgMEwweReQulGEdfAKgE8jmf3dOkm+ohbPBocsBHFOG8mnf4qgb/3s3G1J1RbDvAgSFW9xvupTeykFNr5k8/heozZNMtSCbU6SWue9qqBDUwgTVkUjxrfNWEi3ZlOeTaOaenDOxCWh74nlHKt3CKJFa67hzwoDonkZT13e1Ge0Vr0CalND4cQBTuuMcRnDtUNNX1LuzGWwDdQaIm6bhsdgn78Q/INgB+o9udXh78i9THbD4uWzLjY3Hlny3F9RlZeksF56JBDtK9PBguBU5eJQLcmAWrr8mWrYx7r+prwfMkR5CH09VZl3GbRkviHvY7Ew8xvDMowuYeQ4tuM7w==
Received: from SG2PR06MB3207.apcprd06.prod.outlook.com (2603:1096:4:6b::9) by
 SEYPR06MB5671.apcprd06.prod.outlook.com (2603:1096:101:bd::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.8; Fri, 3 Feb 2023 03:31:14 +0000
Received: from SG2PR06MB3207.apcprd06.prod.outlook.com
 ([fe80::bfa0:771c:8258:c299]) by SG2PR06MB3207.apcprd06.prod.outlook.com
 ([fe80::bfa0:771c:8258:c299%4]) with mapi id 15.20.6064.022; Fri, 3 Feb 2023
 03:31:14 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH v3] crypto: aspeed: fix type warnings
Thread-Topic: [PATCH v3] crypto: aspeed: fix type warnings
Thread-Index: AQHZN3+/YgDO47yOgkqlmhg8xMbIP668kMcg
Date:   Fri, 3 Feb 2023 03:31:14 +0000
Message-ID: <SG2PR06MB3207A065990C50F67B66BE8E80D79@SG2PR06MB3207.apcprd06.prod.outlook.com>
References: <20230203032932.971586-1-neal_liu@aspeedtech.com>
In-Reply-To: <20230203032932.971586-1-neal_liu@aspeedtech.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3207:EE_|SEYPR06MB5671:EE_
x-ms-office365-filtering-correlation-id: cb80335d-c327-4875-651d-08db05971a63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26PgcqyPtHvL1gK1pdMAtiAgyqaQAMRK6T7jE2/dXchR+3kdur81uyKkh9cU/ru/AEsHtd3TtUaCmkojT5v1NU9JYxxqyOnQib5Q9fkBsOIRQtka4O+ALN1P+fo/D4OFrNIAuzXjaY9P3kNNuUaqSX/6VIfXVKXF4dVAYiK7Zp/PBhDdEIt+oOIbZm6XZ2+hrJl0xwGsqb9qLk+Xbsi2bmWUBeE7AtpAfP5IgCFFeqWJ2azpFYghDG5spblmVD+kV7vG709YtQ1dqhYS0TAUJoaFn+z3zUKYKW3yvsuxB3ZTLqgmVYO7swxfb3A8IAOUH+mDmlhjSv9uTFDaht5DdeeN1L8rjwhNUEZxBmdXdGhhM0DNq8kAbN4hWgyIeTB8XyTOBVmVD8bOeQvGTFRB9opA4NR/DgvWvj0esG8C2+9f2u4ryx47qBoC1TM3w0OIjXe/R+UJ0w+SWt4tCYxcHR5oIYxCOlIFX+yzh1feXEX+kzPa7B8lZx/NlIisNS6VAYSvK0VaO5sArnCewhJ9XOKFQ1j04WCRI6t0QsA9bWxXPCcvGw3XDy8YlfC1Aq4cetqVFWYTV5okz9uskeSaBtV/hUaS+ZVY7M+9Gpjjge0RbFnHbBhjVdJJ17biCAmNGTXzxxphrFHr5PcTrTZMcnTQ2aRENaiOuPuFlz6WHyfWMnK7w71o8VYSnVHQMIgwfoZdVIomOHllDeMOSxUw2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3207.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199018)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(83380400001)(8676002)(76116006)(4326008)(316002)(8936002)(52536014)(54906003)(110136005)(9686003)(186003)(5660300002)(55016003)(2906002)(26005)(71200400001)(7696005)(33656002)(86362001)(478600001)(122000001)(6506007)(53546011)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vTyAo7YO6vLKj+KQyX+aB/8jGjbhMMT5Phl7AnCZBZ6wVPNByn21ePdXNMwK?=
 =?us-ascii?Q?KyYsG2MsvN5M8OMagnfrAuc0NFjgh3W5sRUGzw/K65hPk5ERnVxoswaA0l3c?=
 =?us-ascii?Q?ETyzqcyzFxhjS1/93FiFwYl13ovkfwWuocEbyDtv1jIwgHBUwmOLKNW9tmMs?=
 =?us-ascii?Q?Puy1QWi7TjTyf3bopsfeDVuzvPEOLz0dqEi6n+zBKrxBDgjSBBbalEHWAaDe?=
 =?us-ascii?Q?vAeiJaQ5TOJAKewfHNbpKQuzRxh5ji0SGAnomMZ2QSnqv3rFQOrV/bJyhvoT?=
 =?us-ascii?Q?Y4Qj2GoavlQbV0yWPuZ9pHdO149ykzkiOeQ7mVW6lliF+gc8pbaJsBLUEQue?=
 =?us-ascii?Q?MJjAU0/fXt8AIkDJn1HvPXcqPAiL3CI5dbwxrsxbLJ++yhHjczNMWWM4imFV?=
 =?us-ascii?Q?cRuuumXyyonX90hZsOqy7oDlQyLfE8/2dqmM5d2JgjhjN4CQPXXFn/4qxiTp?=
 =?us-ascii?Q?tRMhFYqSH7HzqpdHSu7436WWGlrdErkYFF3EiKHEtkKC1csfiQwmSp60vQdj?=
 =?us-ascii?Q?aMtkK7Cfa4I5rv3TmZRFhveMISIz4Roxh2ZNvhn/4HjjlaYd0K7bTKM6Bz1N?=
 =?us-ascii?Q?MyRatToD/FNIjkMy8WDENuNjOK+BpmcPbgx/qYseJdLuNrREPQaGIHJGBZSq?=
 =?us-ascii?Q?knkYRp4Flrd7Iz8CJUjYtKp8E/kCcT1dgs0O1sNyaoUcktBGuJLxtxiP9/OO?=
 =?us-ascii?Q?npmRBWP+cObQhGwFrlWvthiIlU+dcv+b3+5Q7OzD5uv0AlH5jfnbfNgJw1NS?=
 =?us-ascii?Q?0PUj1B3DaUY6GRlFdq2EhwIo0cxDNZHF8mFAMUTbIbVxcNgAV6+8UKQ8UrYI?=
 =?us-ascii?Q?MYXBOtj1VZJWHn70FXDVDUCPQzMIZFFBjMOWk/6lEilQhCZ1r5lKRIARdHlm?=
 =?us-ascii?Q?iHd3IUFFfqSYoT+IrMywQs5cLrJLJw6PbaxSQilq8deA0HvO1eNmz0UDRuLW?=
 =?us-ascii?Q?Hv2xHQ+9BpM+JMbaT4AIlqGO64IC9v7bfIj2TQVYo7IixJd715c1nhFYsors?=
 =?us-ascii?Q?xjGhrEk1rQEpQT9BvW/8A1ZAds1SvNszLxZZVif7OQq7SYWPUDnd0jofKXd4?=
 =?us-ascii?Q?hQktY3PxRcLgcAIdi9xocwOZLtNtCEz78PeincA64pfui6aRRF2Hzrwh5uCH?=
 =?us-ascii?Q?uKDwEHSmoDTusBZcjZqOb6TB+yps0rIQncW+9bH0FqZltJVJN7YIvr30Bs5W?=
 =?us-ascii?Q?kX4Eo/xM7hCtm+JmhaxvFuedJv+Fc6bCa6XXIxGIwuCBgYKi/vB/l7CqNx5b?=
 =?us-ascii?Q?kyJDVxqFddYFBhzJq2PVO9DRXXm9yaioY9kYzJG8O0701kizh5tVI2g4mCLo?=
 =?us-ascii?Q?8HBAfjPMuR8roLuy7w4phOb1zeJD+ClBovV7BtVHDs0BF6N/64bfNy7zo0f6?=
 =?us-ascii?Q?fedNgf+OV0wMU8G5vgBtp0LWHImSmxyQnOeurvxhfFjvKw/57X+MFMDdTboQ?=
 =?us-ascii?Q?tNhXZYmv+oK/MK2dgmL410bveOBKiJvYw9xdnU4lIo7smrlYz3d/9YfrQI+O?=
 =?us-ascii?Q?XpFTGz3fFUjhy+XrXAjxHpItSji1nfkyy0DnWs5mbmFZdBO8NkpJ6WCKe6UD?=
 =?us-ascii?Q?gLyHO4SIclSvBiGMseYFseYWy8gXcwJal6FrnBmz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3207.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb80335d-c327-4875-651d-08db05971a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 03:31:14.3510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGF7zCWe63cix8rRIPUBeGjmx2g3EVRYAvVl+JDHANooQgUl8B3gOU9AZWXRCeKGkXvG7oTyq/H+k6XiTihiZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5671
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, ignore this patch.

> -----Original Message-----
> From: Neal Liu <neal_liu@aspeedtech.com>
> Sent: Friday, February 3, 2023 11:30 AM
> To: Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Neal
> Liu <neal_liu@aspeedtech.com>; Herbert Xu <herbert@gondor.apana.org.au>;
> David S . Miller <davem@davemloft.net>
> Cc: linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; linux-crypto@vger.kernel.org
> Subject: [PATCH v3] crypto: aspeed: fix type warnings
>=20
> This patch fixes following warnings:
>=20
> 1. sparse: incorrect type in assignment (different base types)
> Fix: change to __le32 type.
> 2. sparse: cast removes address space '__iomem' of expression
> Fix: use readb to avoid dereferencing the memory.
>=20
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
> Change since v2: remove unnecessary cast.
> Change since v1: keep iomem marker to remain its purpose.
>=20
>  drivers/crypto/aspeed/aspeed-acry.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/crypto/aspeed/aspeed-acry.c
> b/drivers/crypto/aspeed/aspeed-acry.c
> index 164c524015f0..f2429e699d14 100644
> --- a/drivers/crypto/aspeed/aspeed-acry.c
> +++ b/drivers/crypto/aspeed/aspeed-acry.c
> @@ -252,7 +252,7 @@ static int aspeed_acry_rsa_ctx_copy(struct
> aspeed_acry_dev *acry_dev, void *buf,
>  				    enum aspeed_rsa_key_mode mode)
>  {
>  	const u8 *src =3D xbuf;
> -	u32 *dw_buf =3D (u32 *)buf;
> +	__le32 *dw_buf =3D (__le32 *)buf;
>  	int nbits, ndw;
>  	int i, j, idx;
>  	u32 data =3D 0;
> @@ -302,7 +302,7 @@ static int aspeed_acry_rsa_ctx_copy(struct
> aspeed_acry_dev *acry_dev, void *buf,  static int
> aspeed_acry_rsa_transfer(struct aspeed_acry_dev *acry_dev)  {
>  	struct akcipher_request *req =3D acry_dev->req;
> -	u8 *sram_buffer =3D (u8 *)acry_dev->acry_sram;
> +	u8 __iomem *sram_buffer =3D (u8 __iomem *)acry_dev->acry_sram;
>  	struct scatterlist *out_sg =3D req->dst;
>  	static u8 dram_buffer[ASPEED_ACRY_SRAM_MAX_LEN];
>  	int leading_zero =3D 1;
> @@ -321,11 +321,11 @@ static int aspeed_acry_rsa_transfer(struct
> aspeed_acry_dev *acry_dev)
>=20
>  	for (j =3D ASPEED_ACRY_SRAM_MAX_LEN - 1; j >=3D 0; j--) {
>  		data_idx =3D acry_dev->data_byte_mapping[j];
> -		if (sram_buffer[data_idx] =3D=3D 0 && leading_zero) {
> +		if (readb(sram_buffer + data_idx) =3D=3D 0 && leading_zero) {
>  			result_nbytes--;
>  		} else {
>  			leading_zero =3D 0;
> -			dram_buffer[i] =3D sram_buffer[data_idx];
> +			dram_buffer[i] =3D readb(sram_buffer + data_idx);
>  			i++;
>  		}
>  	}
> --
> 2.25.1

