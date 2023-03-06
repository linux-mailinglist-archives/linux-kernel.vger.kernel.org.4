Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11EA6AB654
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCFGby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFGbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:31:50 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F4A1689A;
        Sun,  5 Mar 2023 22:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqZ1ofKJK/JX4432vpsOKp1gxQZpBiqJSWM5dVfF06w=;
 b=dk+k5tnca3tedYuanjtXgQDCVCTy1Mlk6+NmUS5EefntAFFY33MVQ39L7BxLzQCiWr5Szd8gH9Ds+ONUdVweJAC+cCt4clsevnepTOCuTTqNossVlvbPqdKsHl/zE1hfv9BRdSM5oVkH4y6N69PoY+FpCtwVzSgscGoZ7FZnDULDqh8OJrz0fTcAo4R2j9zYwlHOXWHAvyhF0SHVXPvqSm8DLl7WPY45nGk5xPi5Zn5jmvYqBRqn1oLKOM+lf+k4aecdHZGyyXZZz9h09e0Lf3yN4Gm3RfQKU3KqtWpEeR9qhc/VHFEz+Pgw4XH13UmsuWmZnmlAjO+OIGRddIuVVw==
Received: from GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::15) by
 PAXPR04MB8475.eurprd04.prod.outlook.com (2603:10a6:102:1de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 06:31:42 +0000
Received: from HE1EUR01FT027.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::50) by GV3P280CA0047.outlook.office365.com
 (2603:10a6:150:9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 06:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 HE1EUR01FT027.mail.protection.outlook.com (10.152.0.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Mon, 6 Mar 2023 06:31:41 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (104.47.30.109) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 06 Mar 2023 06:31:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us0tiDNgsQR8iMbm6UsyTCJKSsDbbG7V2ZYJ8DsihdtHK1PxWWTzjJ81Sekk24OvvlXq0hNfbquP1+ax6Z5vNgaKmWIQ1LWKeGIXFyyC25ER5hSxib3UBspy0AY4Pl3UDiSnZquyj1v35ynVh9EEYL5T79UAOSZNdImYsrma7s1XP5T0xCdU/G3n7DCBJQ7cG7wOoyEP6pasYlylaiWejONRbu2mEeA1vzztn6H9bOrTBH1BuwUFGZ55mi11+lNjTWDsOYnyGZHpiZt+XYh1oSWDRyJKp1V4iGu13sG37ps5ySqsrtSMus2lHBQb11fcb3ZU/Z+n5BhXq5xfsS1qzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YivThwGbBpYsM42yUyEJQHrU01PkIdsWXHkBv6T5h4=;
 b=M3JKqrpK949lQ8NgB0lNcrlaSszQvViBJhA0BD4pzcoExSN/B/IZNdfgwLZ6v1t1WH71Q+9xZbedTsDwnkHFN8R/vT2gKozKS7qEIN5WLM7G24rdFloC6Pwz8tPJhuxoNz4pPAMzZGGUxhzhnPdi/qVmsc8EDwYcuIbhPfCrTkgSVb+sszvdpVG3kg9GJqMnzNi0XNnQlCwGnVS8Boan4zQfsstpPIpXtBweki3i6+zscgNc3o6p78nb6rCnoetNdHxdP2eSyB5o9lv2dARU+gCh1fHrHJfg4pVklw3H1ZWmD+XEsKxwvxk0G8ZTdT0IkftyWyLDvTD+y8i87xOF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB9PR04MB9702.eurprd04.prod.outlook.com (2603:10a6:10:301::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 06:31:38 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 06:31:38 +0000
Message-ID: <ceb4f367-b910-578a-24bc-7c222e2f0b0f@topic.nl>
Date:   Mon, 6 Mar 2023 07:31:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
 <20230228063151.17598-2-mike.looijmans@topic.nl>
 <20230304175751.2daae308@jic23-huawei>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.1e5d3371-10e4-4627-b16c-6b250afbb522@emailsignatures365.codetwo.com>
Organization: Topic
In-Reply-To: <20230304175751.2daae308@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR03CA0045.eurprd03.prod.outlook.com (2603:10a6:208::22)
 To DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|DB9PR04MB9702:EE_|HE1EUR01FT027:EE_|PAXPR04MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb81749-ad46-412e-ade6-08db1e0c72fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: a/pxdho9NBFj+L2SS/8Y/wY5R5+xAlbCqJZF3hZlFYjBJKnRUmF3mxT84hLAMCezGiLjMYbrMolqB+uVqWzUlAgWHsxa1AAgc8MQ/79BupVsx03mbaksIOQWl6ikQcOoCY3bKfod5fcOWFrl1X9uBeg7XWL4SuZ4bJayubnbrZVTf1UlcAw5nb/ZoOCo9DNm0rb+95MlIxeecaQeaJDsGehpGbZPLQrOt37QJKcUT8fFaKS5zTxPjlaZeVN4FiBGg8vttm8cbITd5y6hnoBLH660BRjcnFnm9xYiu6LeTmW4tBIFwWcmCCx6/elmCNl4dNi9+Bh7YyzkoGfZmz+O7mElkEcmtmINNYKXTugy9M2y4Rb45bgnb2SJ2UpEqeHgidZvQnR4MHC1OdXInUz5VZpqBg1bPNXGwUxa8lv7ZOmAPPkdmzDhc16dG7lZuNEX3Ryu9kHV7JR25jYSU+JvXOytTUq93HLEVi5bjwzm7pF8kDgJkqXxq8eIqy/V6bttaDSvYvoNwaVsNN0wdppyKe2JA4QhXy3zETE/ANNrtBDVJPmy8rpNDYFPFyY+3MHRuVNh/VxC1J4eXIbzxc4IUrTx2JvlAEV0WlsteIoilwltzK4OhAj2mWaZcqkV/L21Aaa5VYqnkz+mCNj88Ye0ztqbp818DrzqoeFkjj3nYFsynVNjVSYXqhJ8GM8g41oS1YLvZZzuFOqOOhsAPPLCLWlVz2xAYgyZxSMaYy8mBPhOAn6KzWBJ/nuO34BN1kOCxxxLKIRGQjCVSgzQLETjnw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39830400003)(346002)(376002)(136003)(366004)(396003)(451199018)(31686004)(54906003)(36756003)(6486002)(42882007)(316002)(31696002)(83380400001)(186003)(2906002)(44832011)(5660300002)(8936002)(66556008)(66946007)(6916009)(4326008)(8676002)(41300700001)(478600001)(6506007)(26005)(6512007)(53546011)(66476007)(2616005)(7416002)(52116002)(36916002)(83170400001)(38100700002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9702
X-CodeTwo-MessageID: fd528e66-bfd8-4a5d-b2d3-1b5eff61c4bd.20230306063140@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT027.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3fc02a5a-664d-43c9-f278-08db1e0c7084
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adxxWCMTQSPd2TqISB/gyx9AHvVgqLxXwV1oyBNObuf3Cp5spl71OCg+xECm4aAfazbNkbSk8Rl6ExWNhb1eiNVnpkS+PmUwr22XutXKN+HbZgoQN19LS7sRkOpyotkmiyVoqeCSLwhhveK/IGux8c1s/PXoYFjq021gduWORb6jHR0lLnAv0z9DYiK4Ak8WeyOoe4fdDZnxbAb7b0k8jsaCCri326nIcXuK2MgAanelY3ZVqs8khdaYlK8kjW7NfWN3XX60a6IKqOIR0gDkJPReUqpqdpjUBC6d1g/mlzqiXIQYnxGMuoGjTd5AhUN8J2oFb/13TJmp5/jGaBXNfpAGQJ8QFdaJo7bVe84+bFszU+kiQWGQepJyGsSH3hj50n4ZqKXJAx+A9gS9oYBd1AAT/qTjgrfJKqMa9cNmiYK+60EPQte4W8ziVq0nFWHBofRLMQFNOefiy3TJtT6OH8RoK/rWHIabksf+OkthFiy7eNfyJg8N9056TgIa4dWzSgdTyDXq3hAWINfbB56UkHXBoD4ZEpMvpQKuDapx9H+jUqz9sldcNO4Uzw+LQqfDAEoTHOvT17du0vEVbqJGBxKHDomDGlyc2+ieEcfokWIubh3v1sjZSAuDgvJfmG14WdjUh6ON+WFUI1U8FnHtqKudlG27WMFO1+Ao2qEt5KmabrJF2iF2x6QYblIpwIOz
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(39830400003)(136003)(346002)(396003)(376002)(451199018)(36840700001)(46966006)(186003)(7636003)(7596003)(356005)(83170400001)(8936002)(36860700001)(4326008)(6916009)(8676002)(41300700001)(44832011)(2906002)(70586007)(70206006)(5660300002)(7416002)(47076005)(36916002)(478600001)(2616005)(53546011)(6512007)(6506007)(26005)(336012)(6486002)(42882007)(316002)(54906003)(36756003)(40480700001)(82310400005)(31696002)(15974865002)(83380400001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 06:31:41.6688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb81749-ad46-412e-ade6-08db1e0c72fb
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT027.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8475
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
On 04-03-2023 18:57, Jonathan Cameron wrote:
> On Tue, 28 Feb 2023 07:31:51 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
>> The ADS1100 is a 16-bit ADC (at 8 samples per second).
>> The ADS1000 is similar, but has a fixed data rate.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> Hi Mike,
>
> A few minor things + one request for a test as trying to chase a possible
> ref count overflow around the runtime_pm was giving me a enough of a head=
ache
> that it's easier to ask you just to poke it and see.  If it doesn't fail =
as
> I expect I'll take a closer look!

Will do, but it may take a few days to get access to the hardware again.=20
I'll report on that later.

>> +static int ads1100_set_scale(struct ads1100_data *data, int val, int va=
l2)
>> +{
>> +	int microvolts;
>> +	int gain;
>> +	int i;
>> +
>> +	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
>> +	if (val)
>> +		return -EINVAL;
>> +
>> +	microvolts =3D regulator_get_voltage(data->reg_vdd);
>> +	/* Calculate: gain =3D ((microvolts / 1000) / (val2 / 1000000)) >> 15 =
*/
>> +	gain =3D ((microvolts + BIT(14)) >> 15) * 1000 / val2;
>> +
>> +	for (i =3D 0; i < 4; i++) {
>> +		if (BIT(i) =3D=3D gain) {
>> +			ads1100_set_config_bits(data, ADS1100_PGA_MASK, i);
>> +			return 0;
>> +		}
>> +	}
> Andy's suggestion of something like..
> 	if (!gain)
> 		return -EINVAL;
> 	i =3D ffs(gain);
> 	if (i >=3D 4 || BIT(i) !=3D gain)
> 		return -EINVAL;
>
> 	ads...
>
> Is perhaps nicer than the loop.

Yes, takes out a loop.


>
>> +static void ads1100_disable_continuous(void *data)
>> +{
>> +	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
>> +}
>> +
>> +static int ads1100_probe(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev;
>> +	struct ads1100_data *data;
>> +	struct device *dev =3D &client->dev;
>> +	int ret;
>> +
>> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data =3D iio_priv(indio_dev);
>> +	i2c_set_clientdata(client, indio_dev);
> You can avoid the slightly nasty mix of i2c_set_clientdata vs dev_get_drv=
data()
> below by taking advantage of the fact you have a local dev pointer.
>
> 	dev_set_drvdata(dev, indio_dev);
> and no confusing mix is left.  Of course it's doing the same thing but to=
 my
> mind slightly nicer to use the same one.

Since I don't need indio_dev anywhere, I might as well say this directly:

dev_set_drvdata(dev, data);

(Only the pm_ routines use this)

> ...
>

--=20
Mike Looijmans

