Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0F96190DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiKDGUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiKDGU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:20:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6180029357;
        Thu,  3 Nov 2022 23:20:22 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=LymW1rMPSGwB9JAlqr0Wz5Xyot//OOQXko+PXpNLxIh2dJeNBhQ9z/F+AflB6wxRG+mXyM/AxUAg6eAahuxa9Qp+XmQ98eeZSfCNZ/UlcWULzBWmechAOszHBx0N0w4jGWGrJxdTU1biIEvTs6Wqxy6+tolUoP6z0dTGQsbICFC4zwShE5QpUlQ5QkbAK/LtIHvJbdwUmPvgqESc+n0jXi9gh68q70E+1wOEpdNiEroLKjDmqbUXhXwm2wx351OsA6IQzG9j7vjAM745DbPymOgYX8J2GFQER5t/HHc/S6Xqfmk08S9lGEasEiYwRsh1FTN+FGtThUPrOw3K7xdJAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8z+dD5REr4bJvIJP9gH2iwxp1/Y85DWe1Z6n9mSzHo=;
 b=iVM7i0u8Igqy/7NkbX6UfHiqsPxYoOtHTMiTabAJ1+igXyGabQ/ZVRKwCGVBOnU4Z0rCw2/+VgjHB8DRmMh3kgTPalcUDMDA6DKplSneGih0K/RkWtywUgAaBlIprH6fxOTHIVtyzVL2yjjSD9/mTHH/fS6j3tBTdkFKLd8McqC5nMTA+UjkXStQH2sjS+eaZ9SIFk1tTN+YF0pIJxrKuhadnP6JA8466oZoD6z5ZNw/wLY79rpNLbr9O1pLAfOy6/jsoOESpFoIoQuzzFe+hr5jffGGdYH2Xvp9qhMLQKeDtzJ7qw+l1oukq2VGaJLxbFAqgwBvpaTvJllwGMdD3A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=topicproducts.com;
 dmarc=none action=none header.from=topic.nl; dkim=none (message not signed);
 arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8z+dD5REr4bJvIJP9gH2iwxp1/Y85DWe1Z6n9mSzHo=;
 b=0I1WLvYTiEX2txU4YYOq/FEg6rWxWChjTykcAG7Za79lA+Zxu0/EcSI+13lBfTrnC1e3SKf4aTsuqL5J7U0U14R5ED5jW5/JCypNNKs31X1zVjA9sDgmuUdm+Fv5OLAqpOPuPOyh7NQVXNypDJY+z7snLGbqGR+5lkvy0LeDnhhuwY2PO4if0+SUqt4meKteqRPUAx6njsECZMT17vUkKdb2t/7IAqngNr9a8RQSlaKv/wptnl/EmHU4LzeMn9pfzCHBp+nIRIf2CUHDyxpIY+Xib8thRjoBdzr8Dzc6oAaeDi0z1zPSG37Wf3Bh3sy4O3+vELtgzc+jkFLRIlloOQ==
Received: from DB6PR0501CA0040.eurprd05.prod.outlook.com (2603:10a6:4:67::26)
 by PAXPR04MB8878.eurprd04.prod.outlook.com (2603:10a6:102:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Fri, 4 Nov
 2022 06:20:17 +0000
Received: from DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:67:cafe::c0) by DB6PR0501CA0040.outlook.office365.com
 (2603:10a6:4:67::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 06:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB5EUR01FT054.mail.protection.outlook.com (10.152.5.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 06:20:16 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.51) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 04 Nov 2022 06:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7XRN/fwqPk5X8aWErgzLH3zGN3AoYYnyyovKAgqG63bc3p+lToC3ySoyAsVHzIbdfm3krpVOcicfSMPY/pTA6ltV40UlvTrXhMghLujKQT40BGLq1RFeSZ72Wzw+T20R1DHnAkpamUDJvQyyk6vxnOUqtvAIRDeyxPHCbnHg8LdivEddcqAgPkz2Pm6fUpMr42RpRL7rW163rbp+mJTB4FqHl4muoRtj2CptjkkOlTGwBtVNR5y/zVKL/w3PnL/Rm/wglBt0zH8fkWIXEQOd23X4m5ow+rngGAr/BC/fyAUz29rrzHRq8lpCcixxWuUpgZNpPZRmoCH1V9Facz7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufTTfjA6uxEA7LpRKUaT0sFfiKAdiIaCZC6knnb2nhs=;
 b=PyyOj2w3nCmRPdO8EHky6izLQwHjxN3mg6QZh3wiOKt1jDtK24oCju747cIKajm9sRjzVP3EM1J4L5sRLDev1kxvRt4nyVZXv1WcPbaFBGBwxcyZiJnZ1tSv7BZ8wOBBRHijG4K7Aym8pnxJ/X9kJSNlBWenTEkmrk9k02eIp0pmJ2/jxKh8hqFyYrSwf/4HSUocfvTXF131aOnxR08tgxVmHAK8eTl8tYheRPv+PkeecaszcICgqoBl8m0cQ7bgHy9waBboTikvSia7GDbjNJ6IEF0gpHugVcBk/zkRfKG0Fqs/A7fU1X4z/T2memruehlesUxSXO4TMq3O4GYWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB9PR04MB9499.eurprd04.prod.outlook.com (2603:10a6:10:362::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 06:20:12 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::e9e6:da5:b455:2c6a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::e9e6:da5:b455:2c6a%6]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 06:20:12 +0000
Message-ID: <c313e8ba-e44a-66aa-3577-31b5df728e90@topic.nl>
Date:   Fri, 4 Nov 2022 07:20:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: ds1307: Add support for Epson
 RX8111
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        glazveze@delta.nl
CC:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221101083123.11695-1-glazveze@delta.nl>
 <Y2REHDAHFNJIUbL4@mail.local>
 <7e7e966f-8d5e-8d86-60d5-b65ef0b2514a@linaro.org>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.37681389-32fe-4735-beea-f7f137eb7fff@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.e3306698-ebb5-4500-8c99-409c9fe9831a@emailsignatures365.codetwo.com>
Content-Language: en-CA
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
In-Reply-To: <7e7e966f-8d5e-8d86-60d5-b65ef0b2514a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR08CA0011.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::24) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|DB9PR04MB9499:EE_|DB5EUR01FT054:EE_|PAXPR04MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 938e147b-19f5-4276-1fc1-08dabe2ca423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ouFxJDQHkh8/3DGdMo2A6Nx1B0jI+2eW3vCFgSUeTId4bVY52zqalD/WH647NzRX4+DsGeMb+O2V14SE+Kz9nn/jcwyceNxMlOnLKr+MAjPV3iXpWr7CqRKxfflpq3smVs3cBnmsIldpmM4c3Fv6hRTZOsQLtIiAZDDxgR7CzyyhWYQ/YSzVnhU8yIpatRPVv/vGdMVbmqNER1sju8JPMTQMVI1t5g+b7wn52PvqNAYheXQ06Nj7mX0Sc/+hZygf+6W5HNiA7v4DanoR8qfGdeg3ub7Iz/5ZTElwsaSdNQrTv9O99nGgIpCFRCzL2tCx2zto7aYi7hDwum5klq1HSQiHprpwm7LVVsslBf8UwGTpx4vHQlI+paCQjWIDnb52c/OY1CE6vIILS8ar0Wn3FBawKfKkx+jgxrSeg/ZsfdTPSE+GBTOUxAwBPNXwR43AEiorj0JupLQG3Y6nAlPPKEovaIv/ClfzSIG7M1p4wSaN4fwnYaHYqnuSUnj4T+XLVoKAyL8FkMWSZi0o6tOq35nMKH7sXd4d2eFct/tXmHGL4bzvO5q5Gfb6nGE5mLcIlo/FGgk5C7Wc/DoO7IXe924qKam4zeKJ9FV1OgCM5oOoWOahq082XWDY7r31LdVaQuAc8IJ4tAzUbIYBzIrqdl12K2UOsH3FBrXOIW39ZiUpDmKzWP5m0ZIT1ZaZOmnVy0aYc07iMmqmAg8pUVySwNVtVj2gMhpcb+3VklPmyIYFoL5lOmQqmXcUKufWiVrm0bA253UjODcI3kGRLVJtMvJ5Ue2DJiOrIr13GejrxsU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(346002)(366004)(396003)(136003)(376002)(451199015)(36916002)(478600001)(6486002)(54906003)(110136005)(316002)(38100700002)(2616005)(6512007)(26005)(6506007)(53546011)(83170400001)(42882007)(186003)(41300700001)(5660300002)(31696002)(2906002)(44832011)(8936002)(31686004)(4326008)(66946007)(8676002)(36756003)(66476007)(66556008)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9499
X-CodeTwo-MessageID: 649097e6-74d3-46cc-b4b7-06dfc3fd36a8.20221104062015@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d1218e88-ac7a-4ee8-0963-08dabe2ca15f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4hTw5EJCNXuAyB9oNA9TT5NzEcYuOBMXNpKdIo1/xy5mPW35KyUk5js4PzaVLNKQzBcyJm6V0rSL2SP+GdBb+Pyh3Dd6Y1OrP0h0wClBLE1AgpzMN2fqvLGrv/FELtohy7DAsdPEQ4gn+kgiH5/jJBpowUcngRR8Ju8Xch/TSSeyCPvE7a9+ySXFvBqlsmkJB8zCDqaQtV1iGYStVeEByVmuZbJDIqx1w0JA3/56J+o+1zE5XoxIsUf/eH8NAFT/A/IugfiPYFp2VvxwzO7MKXwXRZvNn1yRkPCY1tdKryXQeeh7YydW4ucEFdYjXrm7q20PPa8lG33s99kTmHbeP1QjovIefw+OWe+qfojy0XQWpPhOFunRoqIZmT0Um9VX8/C6t5be/Wj+whDLVCtyiei3mIJBbRT43PKvIgYjYaQf9BbdizgCoPrNa7Bb866PrHVJzGPqryEHzTJ5NQfv9XGyXacLk/TZH/gq1l0z+XlI85WiNry5zFHTf0bgAoTSO1HUl6SDypzEhkxLIg+GilIXa7Pv8SU4+wc/2XVeI9F3aA4xEo5PoFJAT/V3+ulZ4RtWfeJANYPb+95nACv8onbWUvb53xEK9LdD1TDJcWw07Ki6op8bum/r8gWpYPLS9+35tYmiVPHlEb+h7M+LVQDk6zQM0+SzINyWgmawZ238yemn4iEW5sPChFAOA4nkAkYV+Lqdsx/chp1bc/ZD0xjdND4jNUzymmEGz3AX+1YQDR4ShW8FDhlxsB9Xg1gsKzXMrdrjo1UQrHjChgPEEfxNPRoCOAxeuShL0HOiZ8=
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39840400004)(451199015)(46966006)(36840700001)(31686004)(47076005)(2906002)(36860700001)(15974865002)(40480700001)(41300700001)(70586007)(6512007)(70206006)(8676002)(4326008)(36756003)(31696002)(356005)(7596003)(7636003)(82310400005)(54906003)(110136005)(316002)(83170400001)(8936002)(5660300002)(2616005)(44832011)(186003)(336012)(42882007)(53546011)(36916002)(26005)(6486002)(6506007)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 06:20:16.5919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 938e147b-19f5-4276-1fc1-08dabe2ca423
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8878
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 04-11-2022 02:50, Krzysztof Kozlowski wrote:
> On 03/11/2022 18:43, Alexandre Belloni wrote:
>> On 01/11/2022 09:31:21+0100, glazveze@delta.nl wrote:
>>> From: Mike Looijmans <mike.looijmans@topic.nl>
>>>
>>> The rx_8111 is quite similar to the rx_8030. This adds support for this
>>> chip to the ds1307 driver.
>>>
>>> This adds the entry to the devicetree bindings.
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> The SoB has to match the sender address, it took some time to me to
>> understand this was for the same person...
>=20
> Ugh, so who sent it?
>=20

I did, but our company mail server is incapable of sending patches (it will=
=20
have mangled this mail as well), so I sent it from a different provider.

