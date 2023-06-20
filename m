Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D74736EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjFTOfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjFTOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:34:58 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2088.outbound.protection.outlook.com [40.107.15.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBB8E68;
        Tue, 20 Jun 2023 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XvCnbvudkJekWgW7eYljbGbo2+o1PxmcwYzlPOvpqI=;
 b=qLpOQ9A2nSyV/vCLc8AVcWGTqy++vAI/MkaTNHoFvwLbJxjWQKK5wYU8nKjAikh5k6WeMSDI+ersddKQdGR43AZXcC/gMyu/bRyP+D+SbuBnsVbqRh6B3rMScePlGJY0eLm/tndYotPc7o/avB2zZwlJJhVpLd/iBULDxscV+UTYWtxFQZ9CsVhp9OCT+kXtZyD0CSyWziURvvzc8lqn/sXs/3RCVCjhfRZTDeEtAi4HpWBiOGkD4JiD6pcROxoQ6VAnUMr1UVs7dmm+6JByacj+5Q1WAaT5RMertABTq+HLw7ll9SS+okYTqPGSZy+JBW07106a2MElkmw2B3X2qg==
Received: from FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a2::8) by
 AS4PR04MB9716.eurprd04.prod.outlook.com (2603:10a6:20b:4fa::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 14:34:48 +0000
Received: from VE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a2:cafe::34) by FR3P281CA0158.outlook.office365.com
 (2603:10a6:d10:a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 14:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 VE1EUR01FT076.mail.protection.outlook.com (10.152.2.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23 via Frontend Transport; Tue, 20 Jun 2023 14:34:48 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.177) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 20 Jun 2023 14:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd3j6KQrNcl/PbodQLENJ7eU/pFz5TmAUtIyZCyPVda+J1ofvgdwo1jj+nxK0FfIdaovI+MjGMm0M9B98usDkbcnvjWZ4Xgv2W5IswrxMIdYeKcwjgG+1+IUIN5etKKJAQ+7fzSrC6WdfdcSVnsCx6iW+/hU9AD2EZYg9RUfvB42uGlr4XwEpIPFig3qDt9P31zPDIQb8CLfxq3IOp2qCcOvy1L6BOHDXcex0S0grhPcmZh6qVmkp1wtwGLRrfRxYxtPOStQFGUQ7fwa7GBoXIF5gMNkx8+GCSyxTnbllXIymzyXOZXlJUWo0t0Rsx+xEF0TSc8KHiG8twpyABaUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgtCf86oZMa2irtUS06J2ESiXIGtKqILhbY5+AD/2a4=;
 b=GOmCDuoHQMV9j3+gz3R36H2pCszS49g648GOwx4avsL7u6w51zTgmCs9F7XzM86xL9xVDrdbdjyFg/S00vGn4Aa3Lt+22/OiJrRwo+s2P0ShaPZBKK41ivGneG5Q+GhkGhjfU1Jka6HxWqLAVKPngxu/wl08t0vQbjs5VAvbHFSkHrh1RXmltg6lvseMKRRRy7fYQkqk+zqxCKrCjbyAbczw9kl1GYo8nOuGNFfnea/1LFNcxfiHl2ZhI93VTx0KqOoj4oZasgRh8rUGylREzYSi9FQmrA8GUMk4GRSOxqLidg9VpUQ+a+J15lzhcR1j5eiik4ohQYYwGRJBdqHUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgtCf86oZMa2irtUS06J2ESiXIGtKqILhbY5+AD/2a4=;
 b=OdqD7eSjfH1H2jsUevaRe1iPL3yY/e/f6cTQ2bcPwLCANUiVX+98SZtM3UkYV6vrZuZ4lm1adY7IGiiQqu1igMkrQdjtzmLB0Na9ugTID3GZ8M3tNQ9CTI8Io2iFRlDuJK1dogvPoO9EMUWamaOrxRcsVmoChk2HnYxuzRGd882rzTjdXwzxP/tZr90dpey5wFikoj54LgsRXQzVvWzctnpnrK+xlXQnd4J3HMH4JVelMWkzKWqbJ2TFXSUiSkqp+sX0Vo0BSDht9mtRPSxgvVTVV0IjUpHFyIKQrFCnMQGiA14+4Cj9+zarYx7TqdNXD7FfsitiIMkvUSsPkyePeg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AS8PR04MB8737.eurprd04.prod.outlook.com (2603:10a6:20b:42a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 14:34:44 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 14:34:44 +0000
Message-ID: <b2c432e2-ea5f-79bc-0429-e89e6f948268@topic.nl>
Date:   Tue, 20 Jun 2023 16:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/2] iio: adc: adding support for MCP3564 ADC
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230519160145.44208-1-marius.cristea@microchip.com>
 <20230519160145.44208-3-marius.cristea@microchip.com>
 <915a5d31-5eb4-54b9-3fc9-ff69836f3d76@topic.nl>
 <20230528202024.0ade4595@jic23-huawei>
Organization: Topic
In-Reply-To: <20230528202024.0ade4595@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM9P192CA0029.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::34) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AS8PR04MB8737:EE_|VE1EUR01FT076:EE_|AS4PR04MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: e29814c4-f4d7-4f88-8914-08db719b8002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9ul71wqb6yPtniCLGmUvc9CUXeG4Nc6wu9QC7r4SFIm+k3T9wEKUmaPdHomi1YzLJBDggo8UstyvI1VeqabjHHyM8azTyE/j+ASZD/uLR9zQ2WdjxHSaL4nf+IX0NoRajrdwcy3r+8dQpNOpDcuzisjY1ExuLD6r6ic4gGIlEXm0aTb16awhOMig6huJvMX8LNemLwhQ6OB29jBxjGuIttWvpKhNQPw4PePgcR4fo8kIQ64x9Krg5P5Vml+jH2rM4PVG2cZUeKMG+34BmLNvvKLHT9O4pBaqexuqVLSCDXwKfp4VrDyfIvyMuObMcX+AV2b9CczbNhgOpLXfsCeIu7vCoEr1GhFst582eBD+YZxLkkcNu6P9s18U7OGBoQMKSWhWM6vWzu1xmQtQivK440Tz8Vy6ACm7g/3bqwOIX1R2eMtnuUtsrbdnrbU6kkNzUxQ95J+nLEZPQzEAIa/Znz9G5E/3ok7aHazduRD64hfn5Uk+87rBIVcEUiQhGTADAQY2KR5Jwb7tF8ZvcI6PJcqmbm5S4pOkohm4hLBis99pFFnZa9+sw880mOBHWZwHSa/ZIGot4MjwFUY1t0b77Z9DP8bY/iL/a9JxpE6FVCi4NZPiwsgcWESr2X38b0glPDoXMRCDvsNtxdMxQLKgBBbF3QKkAXmRcrut0bj+ZEw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(366004)(396003)(376002)(136003)(451199021)(8676002)(8936002)(38350700002)(42882007)(186003)(6512007)(38100700002)(5660300002)(26005)(53546011)(6506007)(15974865002)(6486002)(36916002)(52116002)(31696002)(2616005)(83380400001)(478600001)(83170400001)(36756003)(316002)(41300700001)(6916009)(66476007)(66556008)(66946007)(4326008)(2906002)(31686004)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8737
X-CodeTwo-MessageID: b62728ce-10ba-48d8-a38c-8656a89a43d0.20230620143447@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 12b8f724-6d95-4e65-1443-08db719b7d70
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5e+sTooHb2bZQ/Nbw5EFK/0MAsET+ZZRVYx8cRZNp/MBucGCNB68qehhUE7DH4woXcnHhxXV08O6bQXZxdExl8CtvOIyc1+lqLZXZA3bUx0KsPZO3hOukrkBkwHS6ydEUib1+096msoi/w2g5Q/jGaRIhU7mtn3SfGR+JndGTCarDhtkffKQMjwAfaWkoHrLPhSVAk8Lwl2kcMF549oJTQZVT5M2kMsnzFSSAfm/db0vfRkI05XNjrJRaqByZ8JXGpsElRD0Cjh4HUZ/yDZk7d1jv/WtrV2mnW8LN3czDSENaa32cYgQ6Qdd2i2NhMYLCpLGlGkvE7qy57efkde6+FZt/uXbmuyqP0zDJUx58dql4KKS08I3SyC1pf+PU4Ak/Cr0XGaHy8+IY4aicXVhaGTfkWsOGQHttWZUVOHy+PfiQTLWjTdI7jNaD3zgp3Y7l6loaFcrx9HymR8/YAkpVqmftm5NsS0RcQFrl712xV5PmgAos1QZfjSY2VqF7XmJvgg1wqnPsoKmIvILEv6+fP4h7mMedsVWnWrQcLug4/FGxrJIvSO/JUtseTd4o9iEfuZwpaMGkXUVKoIH6Js6KkWhAYhHzJqSfidxYi4ShlXYbGG3QYPHZWVx7HDw+2LlD6xcSMgiyyxpQ+43VDj5vBhDTJaSMEnQ/lUWV+J7LBZ73PcuNQRO/SCacFB4FSbdyEo/SdIKingL4MfBUR9NIVCPYZiG4pIF0Bqs3HKOZZ7y2fN0mwxn4ard50uCMT2Lym1QSCQaTgwTj7de0jUYgQ==
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(5660300002)(44832011)(2906002)(40480700001)(82310400005)(8676002)(8936002)(83170400001)(7636003)(7596003)(356005)(83380400001)(47076005)(36860700001)(36756003)(31696002)(15974865002)(31686004)(36916002)(6916009)(4326008)(6486002)(70586007)(478600001)(70206006)(6512007)(186003)(26005)(42882007)(336012)(41300700001)(316002)(2616005)(53546011)(6506007)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:34:48.2857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e29814c4-f4d7-4f88-8914-08db719b8002
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9716
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-05-2023 21:20, Jonathan Cameron wrote:
>>> +
>>> +static inline u8 mcp356x_reg_fast_cmd(u8 chip_addr, u8 cmd)
>>> +{
>>> +	return ((chip_addr << 6) | (cmd << 2));
>>> +}
>>> +
>>> +static int mcp356x_read(struct mcp356x_state *adc, u8 reg, u32 *val, u=
8 len)
>>> +{
>>> +	int ret;
>>> +	u8 tmp_reg;
>>> +
>>> +	tmp_reg =3D mcp356x_reg_read(adc->dev_addr, reg);
>>> +
>>> +	ret =3D spi_write_then_read(adc->spi, &tmp_reg, 1, val, len);
>> I had issues with spi_write_then_read not communicating properly with th=
e
>> device. This may be due to the SPI controller (Xilinx IP in FPGA) though=
.
> That's a bit worrying!  Shouldn't be a problem unless there is something
> fiddly required with the chip select or similar.

I suspect it's the Xilinx SPI controller IP that's misbehaving, we saw=20
some strange behavior of the CS line while probing with a scope. Judging=20
from the scope images I suspect it tri-states the CS line between the=20
transfers, instead of always driving it low or high.


>
>> I had to use spi_sync() to get reliable answers. Also has the added bene=
fit of
>> giving access to the interrupt flags.
>>> +
>>> +#define MCP3564_CHANNELS(depth) {			\
>>> +	MCP356X_V_CHANNEL(0, 0, depth),			\
>>> +	MCP356X_V_CHANNEL(1, 1, depth),			\
>>> +	MCP356X_V_CHANNEL(2, 2, depth),			\
>>> +	MCP356X_V_CHANNEL(3, 3, depth),			\
>>> +	MCP356X_V_CHANNEL(4, 4, depth),			\
>>> +	MCP356X_V_CHANNEL(5, 5, depth),			\
>>> +	MCP356X_V_CHANNEL(6, 6, depth),			\
>>> +	MCP356X_V_CHANNEL(7, 7, depth),			\
>>> +	MCP356X_T_CHAN(depth),				\
>>> +	MCP356X_V_CHANNEL_DIFF(0, 1, 0x01, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(1, 0, 0x10, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(0, 2, 0x02, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(0, 3, 0x03, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(1, 2, 0x12, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(1, 3, 0x13, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(2, 3, 0x23, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(2, 0, 0x20, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(3, 0, 0x30, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(2, 1, 0x21, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(3, 1, 0x31, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(3, 2, 0x32, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(0, 4, 0x04, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(0, 5, 0x05, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(0, 6, 0x06, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(0, 7, 0x07, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(1, 4, 0x14, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(1, 5, 0x15, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(1, 6, 0x16, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(1, 7, 0x17, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(2, 4, 0x24, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(2, 5, 0x25, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(2, 6, 0x26, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(2, 7, 0x27, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(3, 4, 0x34, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(3, 5, 0x35, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(3, 6, 0x36, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(3, 7, 0x37, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(4, 5, 0x45, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(4, 6, 0x46, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(4, 7, 0x47, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(5, 6, 0x56, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(5, 7, 0x57, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(6, 7, 0x67, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(4, 0, 0x40, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(5, 0, 0x50, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(6, 0, 0x60, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(7, 0, 0x70, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(4, 1, 0x41, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(5, 1, 0x51, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(6, 1, 0x61, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(7, 1, 0x71, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(4, 2, 0x42, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(5, 2, 0x52, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(6, 2, 0x62, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(7, 2, 0x72, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(4, 3, 0x43, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(5, 3, 0x53, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(6, 3, 0x63, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(7, 3, 0x73, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(5, 4, 0x54, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(6, 4, 0x64, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(7, 4, 0x74, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(6, 5, 0x65, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(7, 5, 0x75, depth),	\
>>> +	MCP356X_V_CHANNEL_DIFF(7, 6, 0x76, depth)	\
>>> +}
>> Nice that the chip can do full 8x8 mux delivering 56 channels, but I don=
't
>> think that will be useful to many people.
>>
>> Also I'd want to see buffer support added to the device, which only work=
s for
>> the channels as in the table in the datasheet, so only 4 differential on=
es.
>> It'd be annoying to have 56 channels but only be able to contiuously rea=
d 4
>> specific ones.
> One common solution to this is to push the channel setup to firmware
> as it corresponds to 'what is wired'.  See the channel bindings
> in Documentation/devicetree/bindings/iio/adc/adc.yaml
> and various examples in tree.

Makes sense. Also would allow you to hide inputs that aren't connected=20
anyway.

>
> Thanks for combining efforts btw - should give us the best overall
> result but I feel for you when you discovered the duplication :(


What worries me more is that Marius Cristea isn't responding... maybe=20
he's on a holiday? I'd be happy to join forces on this...


>
> Jonathan


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



