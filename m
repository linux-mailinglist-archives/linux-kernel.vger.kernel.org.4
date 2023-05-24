Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27A070F4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjEXLFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjEXLFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:05:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4AE78;
        Wed, 24 May 2023 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKb2uRBNM5LGcESENCzb5Pqbg1g21rQHwceGlfBVArs=;
 b=s97YtN/CEm8GDXCajZv4lYd6bXUE11Q7Bv6q1x8mTAF5C0sR7/4wnu93ELMl3tQ1C9pT3kUT353Fe8Mxojfyn44poMeLw4NgNJiuIetqPhzwVA1weNiisARxNZKuEax0DcOxkhLEkhwFCBq2wYFIDbQSyr6hlQ+af5q0fiGpVum1zMY47KJ8qL5QV203qMrxivEYAqpWYxccZ54Yd4mElceUnyQHkQGUmo+0eb1HMbNwzt/RBaVgtakHoP5F+MMGozOm/rPU0X0dTJ6jL2P5LkvQFhgFig/nz1LIdcr392aDAAc+o8Bo/0+MHVBKxvo9xdUUogDe+8x/nE8r3bENqg==
Received: from DUZPR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::20) by AS8PR04MB8785.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 11:05:20 +0000
Received: from DB5EUR01FT089.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:46b:cafe::bf) by DUZPR01CA0026.outlook.office365.com
 (2603:10a6:10:46b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 11:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT089.mail.protection.outlook.com (10.152.5.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15 via Frontend Transport; Wed, 24 May 2023 11:05:20 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.51) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 24 May 2023 11:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVSnFwNYHqlgtMnCuJY1xIF8WGo6hxce5rUMENus8P45BcucuL+BdEeomip3RfAYGA6Z2YrZDsM0Fz1T+pziB+ym+XMo1QGiaOX6R6qUEy7Aw8UQIjU3DkAc3kTQ6/S5mHvGfezrN2AveI0RAwA81yBlZgQRj6mXkiXnVdbSTs8FZnmT3+GB/4qjDLlKAir6dDBEjd38LgFiyF7OwToZG/Z+JcBVfX+JgG+CT1aEZHf351WMm7oUbb9GhMxzFlB+0wFgWmESN1n+KK9x5z3PxObytk6H3AlBOB7OIUtBvZplXo3HQR3MwfpZEdTX+W7h8WYHT+nUVaSgxBv4GjIrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+H5+H47EOCErGE2yPnwKpkkl9M262ygHD1qBUAMtnM=;
 b=oB2Y1cLQjBt624tsSeCYXL8r5Lnr3elNWttgYG+r3Z/BMeB8hrU6mHXQG9p7ho5c2XxqFspDqBWwSXIUKbAoM9SKezl1Pio95oUQAvFFFiUFBaIHv+sqeYjQJQeqYGfpOJa8EN7WOlLEx9G2Q9l4+n23KorgvEbsr4cjzWya8Bby33vYUdfsRhoYEmMujMH5KrMq+STy0rGyht35eVUczx+4GMqn1kelIGnx294fM27NmvJ8CCHFyw1Bb66CwuQtZATb9Va6SyqekVpNLmkn5yu43AxngnlGzaFrkKA7XA2QSRBK4TvMWJmUvUcuSsYH4829WxF3Xov0HdZLzwzjEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+H5+H47EOCErGE2yPnwKpkkl9M262ygHD1qBUAMtnM=;
 b=gfpiZwNO46G4x2m8bUa8RCzeiz2yBvr84tn1WjYV8hAI8znbxdzxw6Og+0FmcqkkZcCTPvLwocKu55gUnfnP3O2eyursahjYYtrIZuXxJvqq+dOeW5gDalDIs6XB+Kpw43fIrrtFQ8AY0G3juDiD2BzyF4IPjeOYaAcK/oGzj3j420EyIn4hbfrZvFEzpQhik7VIJQwVrDC7wbZJidBm4/12/PWRSQv27QG+VH6RcaYer+/yqOB08yPK8c4rPois5gvwe6ndWm3sp7i63eLOPvb5fsx4MoPk7UYORvOtI9fU1r9Y8idqROKZpqgaN4Uja+FvNHus8nN1dKmRIcc4UQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DBBPR04MB7642.eurprd04.prod.outlook.com (2603:10a6:10:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 11:05:13 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 11:05:13 +0000
Message-ID: <915a5d31-5eb4-54b9-3fc9-ff69836f3d76@topic.nl>
Date:   Wed, 24 May 2023 13:05:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] iio: adc: adding support for MCP3564 ADC
Content-Language: nl
To:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org
CC:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230519160145.44208-1-marius.cristea@microchip.com>
 <20230519160145.44208-3-marius.cristea@microchip.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
In-Reply-To: <20230519160145.44208-3-marius.cristea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0040.eurprd04.prod.outlook.com
 (2603:10a6:208:1::17) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|DBBPR04MB7642:EE_|DB5EUR01FT089:EE_|AS8PR04MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f92c4c-3491-4bef-ec34-08db5c46c3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: us1LHlVBYuHXf48M5eplHlXNeFJBanF3gT7wpKNrbZI2k5W4v+ycWSgio0sFiKi5bPBDOEhxC3bl0nsqWn4lRavbHLnF5R+2tSWXqzj9Cj6kuI9HJnurlM+ryzOsz3rbYQOpGKqPxArnQn/26mBCwruGs5NeDXyKOl7e1CU62pAI0WSyPX9Nh0OqX9LcOfC9reeHq8W/2KKLrTEdvCdpIYY9l3++kAUJsrvyrSuF00SKhP2San6w2drm9G7wo2RFd6iniv550tDlJRwc/rAUaiX8xS1XsFqVurL5+v//awZ/hKtcYl4Mpbz8mAO2cMycoPtPZzo5394p5cvX36gRrP/4N+y73f23kDwfHpD0p/DWpojkuDX/o9r9lpHFQos2rGP2jW2BfJRvdeP9kxLFHgIbpT9ZLOX+TpD1rUXOAN2oT9XlA56VAka7z3BF/0xBDk82MiwE1r3pYORV6MBTV9HHPVfYEN88tdzfCEEty1Esv/yQhroDPnzA51OYseO1a6GRJJWxkFUkxeWAJQlCiYSfI/kLO9RS8kJhh8Dcm9qFoD7iq6XF5XkFcv/7N6HWNb9op3nAgt8viCgSeqBCeON7geASnAwcadt3G922eG5T35eqhsIKLVZVhmLbuBksSE1fx6yK+d9nw9/AtcFI7g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39840400004)(451199021)(186003)(6512007)(53546011)(6506007)(26005)(38100700002)(44832011)(2616005)(36756003)(83380400001)(42882007)(2906002)(30864003)(83170400001)(66946007)(316002)(66556008)(4326008)(66476007)(41300700001)(6486002)(36916002)(31696002)(478600001)(31686004)(8676002)(8936002)(5660300002)(15974865002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7642
X-CodeTwo-MessageID: 11f38bd3-b73c-4b0b-8e82-c2a5e617698a.20230524110518@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1290fd07-40f8-4856-b2ea-08db5c46bf95
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+84kAFwS20Co5CDHQPlwGd4gPk6yIkpDwGIDmo3BmGukHrp2VFjP9flR38622yjU8rEI9WiFpc//ekmY8wMA8z+Zf2FJzr9IfDnqmFlx6HJoB0mIk215bS5PtD4y1TyDEg08nRLEZBGL69r/gH/M2LcF7SBuRDM88pYu1gyJXriD5FuNJcy6LsvM1T58NxwwiXsftCXa3JCgQZQxj1fKzK3x7JS17Yawx81dEejtvbB5qu40X2PvjLkWXYzlnPR72w/5icI0+zsnpkKaAxU2crVYvArqXZeEVmyLfEwdH5Gq5NyJnbuB3ZpESyEyIuRUNd5PIffh4Z6imBUfbfwoJUUZUJacNQlOW4dGhWCX7rtz+l1/MSCFxzPYy///gl2RptPmpVy2Wx4+6LtuVAIVBFSWj6gRD9l2a4XFXDUwnSqvp8MkI1mp1/Ml2P/Uj7shWmIzl8pwtHeqvZynZZg5aRRYREiz5bVJfsS9ridOwaBBSrIXDNo/CWZyf/TO/8kSf5VQJI1frFpvC2cM7mbu3YVIzodoYVkn8K4Lp6GvBkWn3OPu/x+rwK6CTVYmLg09UVrK6c1O2wRvTcGL4TxoXuCwYjyKXvNGcsoa4sS/Lx9WaZRUG8iappRV4Eu9m3WjDrzmhtpXsXulpWs/QoLv2tdO2R5DJddlGMb+q3B4nlUstu9ScjGcIGzztN+UdoUqMS8ntbRm/g15tBEc6mrX/G2mPyigug+4AGZrWVX6+4bZsJwgxnB1TcYOMDOS7APlTOY0IBwPyohL/KFiDn53w==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(376002)(136003)(346002)(451199021)(46966006)(36840700001)(31686004)(36860700001)(83380400001)(47076005)(336012)(42882007)(2616005)(44832011)(8676002)(5660300002)(41300700001)(8936002)(7596003)(7636003)(356005)(30864003)(2906002)(36756003)(83170400001)(31696002)(40480700001)(478600001)(82310400005)(53546011)(6506007)(6512007)(26005)(186003)(36916002)(15974865002)(6486002)(70206006)(316002)(70586007)(4326008)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 11:05:20.2848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f92c4c-3491-4bef-ec34-08db5c46c3c0
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8785
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-2023 18:01, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the iio driver for Microchip family of 153.6 ksps,
> Low-Noise 16/24-Bit Delta-Sigma ADCs with an SPI interface.

Oh nice.. I tried to submit a similar driver just yesterday, I'll comment o=
n=20
yours instead...

>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
...

> +
> +static inline u8 mcp356x_reg_write(u8 chip_addr, u8 reg)
> +{
> +	return ((chip_addr << 6) | (reg << 2) | MCP356X_WRT_CTRL);
> +}
> +
> +static inline u8 mcp356x_reg_read(u8 chip_addr, u8 reg)
> +{
> +	return ((chip_addr << 6) | (reg << 2) | MCP356X_RD_CTRL);
> +}

How about using FIELD_PREP() here?

> +
> +static inline u8 mcp356x_reg_fast_cmd(u8 chip_addr, u8 cmd)
> +{
> +	return ((chip_addr << 6) | (cmd << 2));
> +}
> +
> +static int mcp356x_read(struct mcp356x_state *adc, u8 reg, u32 *val, u8 =
len)
> +{
> +	int ret;
> +	u8 tmp_reg;
> +
> +	tmp_reg =3D mcp356x_reg_read(adc->dev_addr, reg);
> +
> +	ret =3D spi_write_then_read(adc->spi, &tmp_reg, 1, val, len);

I had issues with spi_write_then_read not communicating properly with the=20
device. This may be due to the SPI controller (Xilinx IP in FPGA) though.

I had to use spi_sync() to get reliable answers. Also has the added benefit=
 of=20
giving access to the interrupt flags.

> +
> +	be32_to_cpus(val);
> +	*val >>=3D ((4 - len) * 8);
> +
> +	return ret;
> +}
> +
> +static int mcp356x_write(struct mcp356x_state *adc, u8 reg, u32 val, u8 =
len)
> +{
> +	val |=3D (mcp356x_reg_write(adc->dev_addr, reg) << (len * 8));
> +	val <<=3D (3 - len) * 8;
> +	cpu_to_be32s(&val);
> +
> +	return spi_write(adc->spi, &val, len + 1);
> +}
> +
> +static int mcp356x_fast_cmd(struct mcp356x_state *adc, u8 fast_cmd)
> +{
> +	u8 val;
> +
> +	val =3D mcp356x_reg_fast_cmd(adc->dev_addr, fast_cmd);
> +
> +	return spi_write(adc->spi, &val, 1);
> +}
> +
> +static int mcp356x_update(struct mcp356x_state *adc, u8 reg, u32 mask, u=
32 val,
> +			  u8 len)
> +{
> +	u32 tmp;
> +	int ret;
> +
> +	ret =3D mcp356x_read(adc, reg, &tmp, len);
> +
> +	if (ret =3D=3D 0) {
> +		val &=3D mask;
> +		val |=3D tmp & ~mask;
> +		ret =3D mcp356x_write(adc, reg, val, len);
> +	}
> +
> +	return ret;
> +}


This update function is used a lot, and is just a re-implementation of=20
"regmap" functionality. Since this driver only reads/writes single register=
s,=20
I would recommend using regmap with the read/write functions above. That wo=
uld=20
also reduce the SPI traffic as regmap can cache the values for you.

...

> +
> +#define MCP3564_CHANNELS(depth) {			\
> +	MCP356X_V_CHANNEL(0, 0, depth),			\
> +	MCP356X_V_CHANNEL(1, 1, depth),			\
> +	MCP356X_V_CHANNEL(2, 2, depth),			\
> +	MCP356X_V_CHANNEL(3, 3, depth),			\
> +	MCP356X_V_CHANNEL(4, 4, depth),			\
> +	MCP356X_V_CHANNEL(5, 5, depth),			\
> +	MCP356X_V_CHANNEL(6, 6, depth),			\
> +	MCP356X_V_CHANNEL(7, 7, depth),			\
> +	MCP356X_T_CHAN(depth),				\
> +	MCP356X_V_CHANNEL_DIFF(0, 1, 0x01, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 0, 0x10, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 2, 0x02, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 3, 0x03, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 2, 0x12, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 3, 0x13, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 3, 0x23, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 0, 0x20, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 0, 0x30, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 1, 0x21, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 1, 0x31, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 2, 0x32, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 4, 0x04, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 5, 0x05, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 6, 0x06, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 7, 0x07, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 4, 0x14, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 5, 0x15, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 6, 0x16, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 7, 0x17, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 4, 0x24, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 5, 0x25, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 6, 0x26, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 7, 0x27, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 4, 0x34, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 5, 0x35, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 6, 0x36, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 7, 0x37, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 5, 0x45, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 6, 0x46, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 7, 0x47, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 6, 0x56, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 7, 0x57, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 7, 0x67, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 0, 0x40, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 0, 0x50, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 0, 0x60, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 0, 0x70, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 1, 0x41, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 1, 0x51, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 1, 0x61, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 1, 0x71, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 2, 0x42, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 2, 0x52, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 2, 0x62, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 2, 0x72, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 3, 0x43, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 3, 0x53, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 3, 0x63, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 3, 0x73, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 4, 0x54, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 4, 0x64, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 4, 0x74, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 5, 0x65, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 5, 0x75, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 6, 0x76, depth)	\
> +}

Nice that the chip can do full 8x8 mux delivering 56 channels, but I don't=
=20
think that will be useful to many people.

Also I'd want to see buffer support added to the device, which only works f=
or=20
the channels as in the table in the datasheet, so only 4 differential ones.=
=20
It'd be annoying to have 56 channels but only be able to contiuously read 4=
=20
specific ones.

...

> +
> +static int mcp356x_read_single_value(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *channel,
> +				     int *val)
> +{
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +	int ret, tmp, ret_read =3D 0;
> +
> +	/* Configure MUX register with the requested channel */
> +	ret =3D mcp356x_write(adc, MCP356X_MUX, channel->address, 1);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Failed to configure MUX register\n");
> +		return ret;
> +	}
> +
> +	/* ADC Conversion starts by writing ADC_MODE[1:0] =3D 11 to CONFIG0[1:0=
] =3D  */
> +	ret =3D mcp356x_update(adc, MCP356X_CONFIG0, MCP356X_ADC_MODE_MASK,
> +			     MCP356X_ADC_CONVERSION_MODE, 1);
> +	if (ret) {
> +		dev_err(&indio_dev->dev,
> +			"Failed to configure CONFIG0 register\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Check if the conversion is ready. If not, wait a little bit, and
> +	 * in case of timeout exit with an error.
> +	 */
> +
> +	ret =3D read_poll_timeout(mcp356x_read, ret_read,
> +				ret_read || !(tmp & MCP356X_DATA_READY_MASK),
> +				1000, MCP356X_DATA_READY_TIMEOUT_MS * 1000, true,
> +				adc, MCP356X_IRQ, &tmp, 1);

I have an implementation that (optionally) uses the interrupt signal from t=
he=20
chip, nicer than polling.

> +
> +	/* failed to read status register */
> +	if (ret_read)
> +		return ret;
> +
> +	if (ret)
> +		return -ETIMEDOUT;
> +
> +	if (tmp & MCP356X_DATA_READY_MASK)
> +		/* failing to finish conversion */
> +		return -EBUSY;
> +
> +	ret =3D mcp356x_read(adc, MCP356X_ADCDATA, &tmp, 4);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D tmp;
> +
> +	return ret;
> +}
> +
> +static int mcp356x_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *channel,
> +			      const int **vals, int *type,
> +			      int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*type =3D IIO_VAL_INT;
> +		*vals =3D mcp356x_oversampling_avail;
> +		*length =3D ARRAY_SIZE(mcp356x_oversampling_avail);
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:

Hmm, last time I tried to submit a driver with HARDWAREGAIN I got told to=20
change it to selectable SCALE instead. See the driver I submitted yesterday=
=20
for details.

> +		*type =3D IIO_VAL_FRACTIONAL;
> +		*length =3D ARRAY_SIZE(mcp356x_hwgain_frac);
> +		*vals =3D mcp356x_hwgain_frac;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*vals =3D mcp356x_calib_bias;
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*vals =3D mcp356x_calib_scale;
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +
> +static int mcp356x_config(struct mcp356x_state *adc)
> +{
> +	int ret =3D 0;
> +	unsigned int tmp;
> +
> +	dev_dbg(&adc->spi->dev, "%s: Start config...\n", __func__);
> +
> +	/*
> +	 * The address is set on a per-device basis by fuses in the factory,
> +	 * configured on request. If not requested, the fuses are set for 0x1.
> +	 * The device address is part of the device markings to avoid
> +	 * potential confusion. This address is coded on two bits, so four poss=
ible
> +	 * addresses are available when multiple devices are present on the sam=
e
> +	 * SPI bus with only one Chip Select line for all devices.
> +	 */
> +	device_property_read_u32(&adc->spi->dev, "microchip,hw-device-address",=
 &tmp);
>=20

tmp may be used uninitialized here. Initialize to "1" to get a proper defau=
lt=20
value. That also makes the microchip,hw-device-address optional instead of=
=20
mandatory (see my dt-bindings comment).

> +	if (tmp > 3) {
> +		dev_err_probe(&adc->spi->dev, tmp,
> +			      "invalid device address. Must be in range 0-3.\n");
> +		return -EINVAL;
> +	}
> +
> +	adc->dev_addr =3D 0xff & tmp;
> +
> +	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
> +
> +	ret =3D mcp356x_read(adc, MCP356X_RESERVED_E, &tmp, 2);
> +
> +	if (ret =3D=3D 0) {
> +		switch (tmp & MCP356X_HW_ID_MASK) {
> +		case MCP3461_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3461 chip\n");

This will never get output unless the driver is compiled in debug mode. I'd=
=20
have expected this ID to be used to initialize things?

> +			break;
> +		case MCP3462_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3462 chip\n");
> +			break;
> +		case MCP3464_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3464 chip\n");
> +			break;
> +		case MCP3561_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3561 chip\n");
> +			break;
> +		case MCP3562_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3562 chip\n");
> +			break;
> +		case MCP3564_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3564 chip\n");
> +			break;
> +		default:
> +			dev_err_probe(&adc->spi->dev, tmp,
> +				      "Unknown chip found\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		return ret;
> +	}
> +
> +	/* Command sequence that ensures a recovery with
> +	 * the desired settings in any cases of loss-of-power scenario.
> +	 */
> +
> +	/* Write LOCK register to 0xA5 (Write Access Password)
> +	 * Write access is allowed on the full register map.
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_LOCK, 0x000000A5, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* Write IRQ register to 0x03 */
> +	/* IRQ --> IRQ Mode =3D Hi-Z IRQ Output  --> (0b00000011).
> +	 * IRQ =3D 0x00000003
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_IRQ, 0x00000003, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* Device Full Reset Fast Command */
> +	ret =3D mcp356x_fast_cmd(adc, MCP356X_FULL_RESET_CMD);
> +
> +	/* wait 1ms for the chip to restart after a full reset */
> +	mdelay(1);
> +
> +	/* Reconfigure the ADC chip  */
> +
> +	/* GAINCAL --> Disabled.
> +	 * Default value is GAINCAL =3D 0x00800000; which provides a gain of 1x
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_GAINCAL, 0x00800000, 3);
> +	if (ret)
> +		return ret;
> +
> +	adc->calib_scale =3D 0x00800000;
> +
> +	/* OFFSETCAL --> 0 Counts of Offset Cancellation
> +	 * (Measured offset is negative).
> +	 * OFFSETCAL =3D 0x0
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_OFFSETCAL, 0x00000000, 3);
> +	if (ret)
> +		return ret;
> +
> +	/* TIMER --> Disabled.
> +	 * TIMER =3D 0x00000000
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_TIMER, 0x00000000, 3);
> +	if (ret)
> +		return ret;
> +
> +	/* SCAN --> Disabled.
> +	 * SCAN =3D 0x00000000
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_SCAN, 0x00000000, 3);
> +	if (ret)
> +		return ret;
> +
> +	/* MUX --> VIN+ =3D CH0, VIN- =3D CH1 --> (0b00000001).
> +	 * MUX =3D 0x00000001
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_MUX, 0x00000001, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* IRQ --> IRQ Mode =3D Hi-Z IRQ Output  --> (0b00000011).
> +	 * IRQ =3D 0x00000003
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_IRQ, 0x00000003, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* CONFIG3
> +	 * Conv. Mod =3D One-Shot/Standby,
> +	 * FORMAT =3D 32-bit (right justified data): SGN extension + ADC data,
> +	 * CRC_FORMAT =3D 16b, CRC-COM =3D Disabled,
> +	 * OFFSETCAL =3D Enabled, GAINCAL =3D Enabled --> (10100011).
> +	 * CONFIG3 =3D 0x000000A3
> +	 *
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_CONFIG3, 0x000000A3, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* CONFIG2 --> BOOST =3D 1x, GAIN =3D 1x, AZ_MUX =3D 1 --> (0b10001101)=
.
> +	 * CONFIG2 =3D 0x0000008D
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_CONFIG2, 0x0000008D, 1);
> +	if (ret)
> +		return ret;
> +
> +	adc->hwgain =3D 0x01;
> +	adc->auto_zeroing_mux =3D true;
> +	adc->auto_zeroing_ref =3D false;
> +	adc->current_boost_mode =3D MCP356X_BOOST_CURRENT_x1_00;
> +
> +	/* CONFIG1 --> AMCLK =3D MCLK, OSR =3D 98304 --> (0b00111100).
> +	 * CONFIG1 =3D 0x0000003C
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_CONFIG1, 0x0000003C, 1);
> +	if (ret)
> +		return ret;
> +
> +	adc->oversampling =3D 0x0F;
> +
> +	if (!adc->vref) {
> +		/* CONFIG0 --> VREF_SEL =3D Internal Voltage Reference 2.4v
> +		 * CLK_SEL =3D INTOSC w/o CLKOUT, CS_SEL =3D No Bias,
> +		 * ADC_MODE =3D Standby Mode --> (0b11100010).
> +		 * CONFIG0 =3D 0x000000E2
> +		 */
> +		ret =3D mcp356x_write(adc, MCP356X_CONFIG0, 0x000000E2, 1);
> +
> +		dev_dbg(&adc->spi->dev, "%s: Using internal Vref\n",
> +			__func__);
> +		adc->vref_mv =3D MCP356XR_INT_VREF_MV;
> +
> +	} else {
> +		/* CONFIG0 --> CLK_SEL =3D INTOSC w/o CLKOUT, CS_SEL =3D No Bias,
> +		 * ADC_MODE =3D Standby Mode --> (0b01100010).
> +		 * CONFIG0 =3D 0x000000E2
> +		 */
> +		ret =3D mcp356x_write(adc, MCP356X_CONFIG0, 0x00000062, 1);
> +	}
> +	adc->current_bias_mode =3D MCP356X_CS_SEL_0_0_uA;
> +
> +	return ret;
> +}
> +
> +static int mcp356x_probe(struct spi_device *spi)
> +{
> +	int ret, device_index;
> +	struct iio_dev *indio_dev;
> +	struct mcp356x_state *adc;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> +	if (!indio_dev) {
> +		dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev),
> +			      "Can't allocate iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	adc =3D iio_priv(indio_dev);
> +	adc->spi =3D spi;
> +
> +	dev_dbg(&adc->spi->dev, "%s: probe(spi =3D 0x%p)\n", __func__, spi);
> +
> +	adc->vref =3D devm_regulator_get_optional(&adc->spi->dev, "vref");
> +	if (IS_ERR(adc->vref)) {
> +		if (PTR_ERR(adc->vref) =3D=3D -ENODEV) {
> +			adc->vref =3D NULL;
> +			dev_dbg(&adc->spi->dev, "%s: Using internal Vref\n",
> +				__func__);
> +		} else {
> +			dev_err_probe(&adc->spi->dev, PTR_ERR(adc->vref),
> +				      "failed to get regulator\n");
> +			return PTR_ERR(adc->vref);

You can "return dev_err_probe(...);" directly and save a line of code

> +		}
> +	} else {
> +		ret =3D regulator_enable(adc->vref);
> +		if (ret)
> +			return ret;
> +

Use devm_add_action_or_reset to register a disable function. That gets rid =
of=20
the gotos and the remove() callback as well. See my version of the driver f=
or=20
implementation example.


> +		dev_dbg(&adc->spi->dev, "%s: Using External Vref\n",
> +			__func__);
> +
> +		ret =3D regulator_get_voltage(adc->vref);
> +		if (ret < 0) {
> +			dev_err_probe(&adc->spi->dev, ret,
> +				      "Failed to read vref regulator\n");
> +			goto error_disable_reg;
> +		}
> +
> +		adc->vref_mv =3D ret / 1000;
> +	}
> +
> +	spi_set_drvdata(spi, indio_dev);
> +	device_index =3D spi_get_device_id(spi)->driver_data;
> +	adc->chip_info =3D &mcp356x_chip_infos_tbl[device_index];
> +
> +	adc->mcp356x_info.read_raw =3D mcp356x_read_raw;
> +	adc->mcp356x_info.write_raw =3D mcp356x_write_raw;
> +	adc->mcp356x_info.read_avail =3D mcp356x_read_avail;
> +
> +	ret =3D mcp356x_prep_custom_attributes(adc, indio_dev);
> +	if (ret) {
> +		dev_err_probe(&adc->spi->dev, ret,
> +			      "Can't configure custom attributes for MCP356X device\n");
> +		goto error_disable_reg;
> +	}
> +
> +	indio_dev->name =3D spi_get_device_id(spi)->name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &adc->mcp356x_info;
> +
> +	indio_dev->channels =3D adc->chip_info->channels;
> +	indio_dev->num_channels =3D adc->chip_info->num_channels;
> +	indio_dev->masklength =3D adc->chip_info->num_channels - 1;
> +
> +	/* initialize the chip access mutex */
> +	mutex_init(&adc->lock);
> +
> +	/* Do any chip specific initialization, e.g:
> +	 * read/write some registers
> +	 * enable/disable certain channels
> +	 * change the sampling rate to the requested value
> +	 */
> +	ret =3D mcp356x_config(adc);
> +	if (ret) {
> +		dev_err_probe(&adc->spi->dev, ret,
> +			      "Can't configure MCP356X device\n");
> +		goto error_disable_reg;
> +	}
> +
> +	dev_dbg(&adc->spi->dev, "%s: Vref (mV): %d\n", __func__, adc->vref_mv);
> +
> +	ret =3D devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret) {
> +		dev_err_probe(&adc->spi->dev, ret,
> +			      "Can't register IIO device\n");
> +		goto error_disable_reg;
> +	}
> +
> +	return 0;
> +
> +error_disable_reg:
> +	if (adc->vref)
> +		regulator_disable(adc->vref);
> +
> +	return ret;
> +}
> +
> +static void mcp356x_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +
> +	if (adc->vref)
> +		regulator_disable(adc->vref);
> +}
> +
> +static const struct of_device_id mcp356x_dt_ids[] =3D {
> +	{ .compatible =3D "microchip,mcp3461" },
> +	{ .compatible =3D "microchip,mcp3462" },
> +	{ .compatible =3D "microchip,mcp3464" },
> +	{ .compatible =3D "microchip,mcp3461r" },
> +	{ .compatible =3D "microchip,mcp3462r" },
> +	{ .compatible =3D "microchip,mcp3464r" },
> +	{ .compatible =3D "microchip,mcp3561" },
> +	{ .compatible =3D "microchip,mcp3562" },
> +	{ .compatible =3D "microchip,mcp3564" },
> +	{ .compatible =3D "microchip,mcp3561r" },
> +	{ .compatible =3D "microchip,mcp3562r" },
> +	{ .compatible =3D "microchip,mcp3564r" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mcp356x_dt_ids);
> +
> +static const struct spi_device_id mcp356x_id[] =3D {
> +	{ "mcp3461",  mcp3461 },
> +	{ "mcp3462",  mcp3462 },
> +	{ "mcp3464",  mcp3464 },
> +	{ "mcp3461r", mcp3461r },
> +	{ "mcp3462r", mcp3462r },
> +	{ "mcp3464r", mcp3464r },
> +	{ "mcp3561",  mcp3561 },
> +	{ "mcp3562",  mcp3562 },
> +	{ "mcp3564",  mcp3564 },
> +	{ "mcp3561r", mcp3561r },
> +	{ "mcp3562r", mcp3562r },
> +	{ "mcp3564r", mcp3564r },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, mcp356x_id);
> +
> +static struct spi_driver mcp356x_driver =3D {
> +	.driver =3D {
> +		.name =3D "mcp3564",
> +		.of_match_table =3D mcp356x_dt_ids,
> +	},
> +	.probe =3D mcp356x_probe,
> +	.remove =3D mcp356x_remove,
> +	.id_table =3D mcp356x_id,
> +};
> +
> +module_spi_driver(mcp356x_driver);
> +
> +MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
> +MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP346xR ADCs=
");
> +MODULE_LICENSE("GPL v2");

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl

