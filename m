Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4301B74A123
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjGFPhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjGFPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:37:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3834619A7;
        Thu,  6 Jul 2023 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqrqktqfUgj/GNzMGRuQLDSJPxUw3uZs4mizzJI51Go=;
 b=jluPlj05clu/4SnsC6SOoM/svp591W+txifUXrUl34IOLeKVHDtER1Kq4q7AUxuxxXjzXHBWId/GjT+OhzFr8XeYGVhqVa0e9jaGwrJd3I/DTJ9HVz5KlTq74YWI0j2ypEOM2TeC6UDnt49LSWmrxQYnoLPMDfEWN24mkR2lyxRCwEQQZ9Ek/d34UIFma9pmdWJrFvONpgbvpSLb+5JNnrhdJuARuYJT4Zl7uLk9ixWF3t1bcfyhLE/BExrKmevmA1crZVa6EuRkoczfSknWjNGm55x/cDC1MBlDVu+Cmy9JSGpi2VhRYSbdrp80H1LXr8vIWkkRezJtGmsRBOylUg==
Received: from DB6PR0301CA0082.eurprd03.prod.outlook.com (2603:10a6:6:30::29)
 by PAXPR04MB9218.eurprd04.prod.outlook.com (2603:10a6:102:221::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 15:36:55 +0000
Received: from DB5EUR01FT048.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:30:cafe::8e) by DB6PR0301CA0082.outlook.office365.com
 (2603:10a6:6:30::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 15:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB5EUR01FT048.mail.protection.outlook.com (10.152.5.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Thu, 6 Jul 2023 15:36:55 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.172) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 06 Jul 2023 15:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNvSlRh81u4kQuEwLfZErkMXLfOBd8bApEQvCNmIOwmxghD4wUiPoa09WQaj1FC+UmysHwvvPvlzTYrWX3LGqw4oZ7sRSXNqqItpktjCBEQYmj/55rPljkkahC3wTmH5t2i9C2ElYybtM0DbeaECtEGT8YVpSjGbxeTxaiHRvsgNDAd13Cwi/6wQlhtqgaZ0uSliCDkj53yPgPDAkGmI+30T5n3VLeQrvoNT6sNh73NZITlN/0tRH5vndHrrGj6slg69xCwkrGHzSf7heNfCRpnR7xzie+4NxtzTfl8s4wLSvYUf7JzxrjcprvabWC5h+UZy02o+IDqJ6D+DfApHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kpp0JdpCRlqZLbzckmLinSBFgI1SOgHHgMsMvt8bgpo=;
 b=RQH42F2esbfgz/FQ7PaQJJmbJ9IcL5m+rqNU7dpjyDSjjiyV6TTBRekvjLw8q2eQwMWk14oAqOOT0r7Ajf1U1GzZKUzRmO2zMchmzjv4IubUw1Ctv5IO7vJ7Mq99fjuFEUzk1633Xks9v3qIcrsbKVKlylRNtj3/xV4EjWkPKroJdWoUF2U/dIvhGYzO1ojnqCiWYg+tRxWPXMn71Bm/tK91xHBGOLOVWwi8PcpdnVBSAIfx1s+IP3CUWBbMYSkssY8YHiBvmv/2ZUujCxjADPadEucBQhZLI9V3NwvDRDkCzTTxipYIDcR8iGJObuMnb1WHZ4Z/CyP6YUdsMKR1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kpp0JdpCRlqZLbzckmLinSBFgI1SOgHHgMsMvt8bgpo=;
 b=DnTlg50D0hUHwnEb7iXBsx4e73e+FxQwAeWKtR2zqGuVMSSTsIs0vbG7nbezEZ8Jj1xGJ2WLRsomZeOgkmDiHpdNGHojbEXL94KT8KvyEua/bjsgaKFJ0gBPcx4VwVcwmHgMOSatddJtWF1pApyYVuPT64qESEEaYMsi2Sz7sdQF6xNLjVsP0VkF536zOJP3qeR9oiaDfzTrVG+m8Yh91hZdPVL9LhVSfXIFrJEw+Gm6//MQoXqqL/TI9aaOw/EmuoOwROuzpkYLu/cJCozmXXrYLi2nXj3ZBLGCONRAvuFCiR7095BiRKSpuehCcpb2vGky8oWMul2E7V22T5lX+Q==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB6827.eurprd04.prod.outlook.com (2603:10a6:10:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 15:36:52 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 15:36:51 +0000
Message-ID: <25c9fb72-90b1-1ab4-e5c9-73c838bd8e0b@topic.nl>
Date:   Thu, 6 Jul 2023 17:36:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/2] Input: exc3000 - Support power supply regulators
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20230703084536.8429-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.12499438-d166-465a-8847-b25e1baa3dad@emailsignatures365.codetwo.com>
 <20230703084536.8429-2-mike.looijmans@topic.nl> <ZKXlYbsk+6MPfeWy@google.com>
Content-Language: en-US
Organization: Topic
In-Reply-To: <ZKXlYbsk+6MPfeWy@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::45) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|DB8PR04MB6827:EE_|DB5EUR01FT048:EE_|PAXPR04MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: af625f2f-8344-44cd-da2e-08db7e36d3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ++8z9aMEg1FnFJj67FUbuBkxEwspsokTNpMJDOnR4xn4+1QlqOQD+aBf4hMWTJvheAEEDw5qIYU1v6PRCTHLWg7Lk9zFVbPIs2BiQwLfx36SJntvSoEjGUxS8vO4OOhGYyXc3OejL9umzfherYE3hnYhslyCw24kFEJvadfZyXazKgG9iGfZMIO7xlSU/gaWYbFcfOyJOJ3tNEqYiyqLy8p89bo8Ygzm3MADAkdLZ+TdfiTblomKxUW1dPRS2tHX6z4ll/n8kAi144kr2ahM4lYWzFUSl9hZu2EMMDw4H1aVqrvCkdmY+bLl9LRJAx76PHwgDKWEWXsJtEh+qAzF8GClATrmO5LM7qC7/Qy3M0v7Y9V51/h9EJUdghCDYutB4KjNJWL22bjkUfnSxHJyKiQYTvxUuE6UeiO9H56DIaP254b4Y8vyLN+m9ewNkUx+Dh1/QjX9El3Qpfi4pW69g+iDIc4w73PvYe6L+OlTMFRMroTpjPLNCNOhPD8AvPyd6SVg4v6xv11KQB6AEakjsrLpVWpRDN3yrkMJtchBcpYBypfuxOZ79JDa/8ttHJ7zTSJCu/38MkJH+qCo/PWj5KNXWL3xnrnwZx6XYmwh60ljMh7gvx2S8f77twkLZFqGzSQX8HUHupflOpJR7liPjUDb6Qj2XrOIos/udVLCCHE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(366004)(136003)(396003)(346002)(451199021)(31686004)(36756003)(31696002)(15974865002)(5660300002)(2906002)(44832011)(6512007)(83380400001)(42882007)(186003)(26005)(6506007)(53546011)(66476007)(52116002)(6486002)(36916002)(2616005)(66946007)(38350700002)(316002)(4326008)(66556008)(38100700002)(83170400001)(6916009)(478600001)(8936002)(8676002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6827
X-CodeTwo-MessageID: 9ae65542-8069-4fda-8e92-73814a6f00f5.20230706153654@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT048.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3184e51d-46f5-419d-ffcb-08db7e36d1c0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XkYcdebb55fZnIdaP6qKOJ5WOUKcMeaa6d46uXeZGVRRQiin4YalPiWtMFcBzWGuzSkBvZ9ccQO11+SFj8qLhlay8OUznBCycLeWhWbMz39tPn0WeNnf8Xfs14HVFsZ4aQwO987opwqpOAd+R8gpuLueWBC0f24L6i8odgD/8o/8Hk0o2+LiAfchF3BHljQDCLaBu4bZeA5ls5Jolx8mfc3vbwbO50bJL/2g/Awn/0z7p414CTiEr4wv2YkUJ+mJix6Myxdn6Z9of+BbTrk7YLgv4wi76HZiG9ewY/QMTFWqLea1DwW6iYHlIMxWVVzv0HVJa6wW9+MrL53ZqvNgMVvxVRofTRDMXphKS7jJpnRk8txjB31VPCT0HmT6+37nuJk8v+jX0rYT09kFfe5t79fNHGpPDvAI47astwJ6VRM+LJ0+WEa0szAlYxK17ECxu65zswDcuHQE6IxB/Vq4nAKTSHvKPIXpDMk7iXIrDM0ZdEbFbBDnNmgGXxDRliSrlYdkvAVKjeyLylVuDZ1o6NB4GWYDSE+zT6r8aPiEbhW5PddR6dix03x/x9DKvCaknz/0JlihJDLSG0RYvHVxUyp+HhLl4AZJeXExDuNJd3Vt7hm1CfenSagYxG/S0dp9DTVvSgXbdNG2uy/Y7FMhUlyDPeCmQ5g9xDYDYM6QznDfY0yWYWYlMjtaTQLcKeIgwN2ClM31OulfDqH0m3axysAXv/luh+iNMTRIDyQVRNsN5VzRFNlzRTapAxhgiqP+KNw/8E/oJP+Ytlo+hIdgw==
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(346002)(396003)(136003)(451199021)(36840700001)(46966006)(70206006)(478600001)(36916002)(6486002)(70586007)(82310400005)(26005)(53546011)(336012)(42882007)(6506007)(36860700001)(6512007)(186003)(2906002)(41300700001)(8936002)(4326008)(316002)(5660300002)(44832011)(8676002)(7636003)(7596003)(356005)(83170400001)(6916009)(15974865002)(31696002)(47076005)(83380400001)(36756003)(2616005)(40480700001)(31686004)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 15:36:55.1704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af625f2f-8344-44cd-da2e-08db7e36d3fc
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT048.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9218
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-2023 23:49, Dmitry Torokhov wrote:
> Hi Mike,
>
> On Mon, Jul 03, 2023 at 10:45:36AM +0200, Mike Looijmans wrote:
>> Add power supply regulator support to the exc3000 devices.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>>   drivers/input/touchscreen/exc3000.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchsc=
reen/exc3000.c
>> index 4af4c1e5d0da..3e50af8a4a2d 100644
>> --- a/drivers/input/touchscreen/exc3000.c
>> +++ b/drivers/input/touchscreen/exc3000.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>>   #include <linux/sizes.h>
>>   #include <linux/timer.h>
>>   #include <asm/unaligned.h>
>> @@ -360,6 +361,12 @@ static int exc3000_probe(struct i2c_client *client)
>>   	if (IS_ERR(data->reset))
>>   		return PTR_ERR(data->reset);
>>  =20
>> +	/* For proper reset sequence, enable power while reset asserted */
>> +	error =3D devm_regulator_get_enable_optional(&client->dev, "vdd");
>> +	if (error && error !=3D -ENODEV)
>> +		dev_err_probe(&client->dev, error,
>> +			      "failed to request vdd regulator\n");
>
> If there is a regulator described in the firmware we should not continue
> with initializing the device if we fail to grab/enable it. Think about
> what happens if you get -EPROBE_DEFER here. You should return here.

True, good catch, I forgot the "return" here (which in all honesty was=20
the reason for using dev_err_probe in the first place...).

> Also, why are you using the _optional() variant? VDD is not an optional
> for the controller. regulator_get_optional() is needed when you need to
> alter the behavior of the device/driver depending on the presence of an
> optional supply, whereas here it should work fine with a sub supply that
> will be created if you simply call devm_regulator_get_enable() and there
> is not regulator mentioned in DT/ACPI for the board.

Indeed, "optional" isn't correct here (I probably had the clock variant=20
in mind), a dummy regulator is fine.

BTW, I also have a patch in store that tries to "recover" the device=20
(using its reset when possible) if it isn't responding or if it causes=20
I2C errors. Took several weeks uptime for this to occur spontaneously on=20
our hardware, so I'll wait for this series so I can put that patch on=20
top of this one.

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



