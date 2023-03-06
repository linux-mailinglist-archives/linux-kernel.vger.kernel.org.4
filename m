Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063896ABE15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCFLWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCFLV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:21:56 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872AD24112;
        Mon,  6 Mar 2023 03:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDse2gtut33YR4HylOoyUIYXxS5SfDnV9tRbq41+7AE=;
 b=lVbuzEWouX9m/9lx9MbgjO/LqBYSef4qXf8FijOvpN9zsnMB6DedN1pcNVn/+lJs74sTD4wJ6GS8oh7auygfI4Csv28PKe5wvE+k62GtkGbXD6PufROMG3eRlQj8qNqft5j0tViZZ/cLqmJ2xKGp7KQCEXCErrpfornIJDEa7hPDRFRxdXhA4yzRaZQOH2nMlmXgS3HaIqgqE/k4D9HWqfcE51dd24ud2gA1Z0zExeXrn4BaQ5OViZANkK3mZNrAzugkn36Z210M9WC+2idCyaDHci4ZOdJfZpHzKYZELP0aWQNNfbuZKWFbIxvSSevMpgZ1BFlmyhbzmGmagpB2QQ==
Received: from DB9PR02CA0002.eurprd02.prod.outlook.com (2603:10a6:10:1d9::7)
 by DB8PR04MB6923.eurprd04.prod.outlook.com (2603:10a6:10:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 11:21:50 +0000
Received: from DB5EUR01FT077.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::48) by DB9PR02CA0002.outlook.office365.com
 (2603:10a6:10:1d9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 11:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT077.mail.protection.outlook.com (10.152.5.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.14 via Frontend Transport; Mon, 6 Mar 2023 11:21:49 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (104.47.0.54) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 06 Mar 2023 11:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BctXp3390JKPmX40CLLUUMwOrlUJZKcc8E9i0tKmGfmx+yl4aIsAy2TCiUnKREv1MkNQmdoH/wtzh9d6f1WJXyuzMZyUBOEIdYoc3Jl7YaQQHACZWvlqNUrbJSWU3ztbWwopQBsJNfUG4ByLlF+wpuSa8YIYTRqbcjsfy4A6gnNGQNIQrZVNPE6Gh8GnbdRrbpG1gJTumNHa5p6iugyF8+e4G5ALfOdxdpiq6hYNg4Rqy6HHV2DH6wP2Ue6VZVJwGb33EJRg3SfZdUJii4bnp1+hJ29AndWLMe10oLH1Mpe1js70ft263zits004+3dFFi79QnjDYCAW+Zf6vFGG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raHgdK/04B3ct08XR/v6nCOVRdeGfLIc0E3pDK8ntg0=;
 b=brbjUxqx5lAGT9hwgStjnOe/LnfvhP7Gjt2t64P6Os8+NkwhilaVK+UWM4qYAudNqATnjQ3uQ5wiu5ytB9KrBZ4/DsfBNv0SJaLivCewCKbdA07G4PxlQyVU0tNg+B5kI/NJCO8UYjSnulZRtdDMyaHKgzgdMuLgGdnjIL1rdMnbGEVqAEBhGoCK3uuQVrkIn9VVdFNzc0NckXByqPzL3JNRNNo1Wq4HgOnAgFBN5JcQIzISy+cCSrzW9cDWKYPbmAl3MeKLJHi23kiblYQgjQ5n+6C/gLdZ19aP4l7i/Aoilwx2X+2AUHvl2ZRU54llnmfsfX9bW/etnQnzAXSL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PA4PR04MB7501.eurprd04.prod.outlook.com (2603:10a6:102:ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 11:21:45 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 11:21:45 +0000
Message-ID: <f91d6d0a-e197-a66b-61b7-f2ea668429f7@topic.nl>
Date:   Mon, 6 Mar 2023 12:21:44 +0100
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
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c6259f01-fccb-4a0c-a50a-69f2dcd4ea5b@emailsignatures365.codetwo.com>
Organization: Topic
In-Reply-To: <20230304175751.2daae308@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0201.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::8) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PA4PR04MB7501:EE_|DB5EUR01FT077:EE_|DB8PR04MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c57c818-257a-4bf6-0461-08db1e34fb0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Zb9Whpze9XhvFh7h8f2jUEfhGuWgcRw/5hW1Lc8Ez6vDSGv5HszYgbEy1xJtNLfg1kiftmqHdyJ7p9hHvBR1In8rRW/Eneq54jtJmVM7LOw+47lPgRUAWu35qbSB3aX1sKdTXD6pFIyiFkjEzt5bPFnQeJ+hbgtVCxlH469JlsdP5ZPvBbDe+MziLIVCFe7wISMcXHG0hrngP0M5xJhImj2n3A2NaeFmgJ3nbTa7T0MTpHrS/Fwzzsy7ClHEomEfBuMAvDHEdxGr9kD7vqgoJQkeob76Z7aOj78HoDjb7oQOsUxIAtjXsGANRJNMerGTqOuTeGZdimcSEUurWprKv5kCS3VrMaKJ5lSoMDeBHi3xCplwrQIVb2OOnngmwHnh6ne0h51dpwfAM24n4RSQdE77wHiUqeg58Q0dVZfVPqLTXfJAGhdP+yvVb7ii/UedVTVch8IaH/6tQQVafM9jJIxYtrRiVlIOtFdWOvDnEOGes7gh8Zpujf7qyNQPWaKaxLkuNcs9CN2VRTV5F5xlr5PzvLQoO+daNmvamuaJXHgmQa6RuKtBHpbVayVQsQWdW/4k+A1hO3mU93Z7ccgWDQ4NNIQ0l/pqCgvyZOIDDjA2LXioiCHtIvcrRAar3Zy9D8Bjm4PxQPHWNR0kRAH7dvadHkbYlZKNTs9+u/5KCVmZ/37LPCcXwv5OIgdzlt2GgtIU1gTfRMlITttCCQ6Zgpehvu2GGFPafJgOzlZHDuHH1BbInuSAJNlylCbP3irwSioI4tdJp1JYgYY/WAuPUA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39840400004)(136003)(366004)(396003)(451199018)(8936002)(31686004)(7416002)(5660300002)(44832011)(66476007)(66946007)(66556008)(2906002)(8676002)(6916009)(4326008)(54906003)(316002)(478600001)(36916002)(52116002)(36756003)(6512007)(6506007)(6486002)(53546011)(26005)(2616005)(41300700001)(31696002)(83380400001)(83170400001)(42882007)(186003)(38350700002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7501
X-CodeTwo-MessageID: 2a585dcb-b21f-4aef-a927-90232e02947c.20230306112149@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT077.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1a17bd25-8868-4273-3baa-08db1e34f830
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPAQba8lcIhGNNrJ7f7Am0sxJr4mDwydhNvzUveT5UjJAqtLBtPpl5698bO3wUw6WKrWA8FW9QkRHWr4h/Mev5tLYe0VLx9KPw43/J0peZyHMfy/SRTTwhTtVKvL7SofQdOPdwyLgVkPrLNmz4emF4S+jUYaa5AmoQPeWF467C3SyGbBgB+jnB2jA/WGdYdmpfiwktS0xmnReU0zzk59HmM8HALEad6+tJcj/XKTVFY2sQUyaXD9C5jnWQklCJszjhs9748uxvb+aF4kOFUmSpJ1e6ry3Pay1vwtJpl8mXGtbY6SMwCaU4Gl9XzV2QggQPpR5nr0IaBOpF/PW5nvEQvvsh9B+iz6j2WS1Kgldv3WGGxpGWDRAXLi0wSGt3y+J3B5V9/TNBCHnL54yo/SP2U1jOZN1xvETn/XOcwNn2YlDgzJ+VU1+YaTVIUyZQKiKd2BojJ2NlIuQUZjhpwxqQpMRyc4ieEXcigQC5Ow7AgHoR29UGEJJkCao2c0CwA2HpzdMSHQbFH9+ekNxh8kxs90Vx3tKgxOBYej0dDsmypbd68A25ce/OX5V8/SMjGBTDxHzmozmG58+3sE/ezrdHTgMRdrLCuNAuQZ6f3qgFw/Cbf+nUMf1JMW4kfJ+NCkpN0LX1t7Z/MlLraO2mxgMl7s8Gybx51/ovPU/C7PUyjp/09uo6dDrk8xEvl+CCmQ
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(39840400004)(396003)(376002)(136003)(346002)(451199018)(46966006)(36840700001)(186003)(7636003)(7596003)(83170400001)(356005)(8936002)(70206006)(41300700001)(4326008)(6916009)(8676002)(36860700001)(44832011)(2906002)(5660300002)(70586007)(7416002)(36916002)(478600001)(6506007)(2616005)(47076005)(53546011)(26005)(6512007)(42882007)(6486002)(54906003)(36756003)(31696002)(40480700001)(83380400001)(82310400005)(15974865002)(316002)(31686004)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 11:21:49.9024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c57c818-257a-4bf6-0461-08db1e34fb0b
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT077.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6923
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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
>
> Jonathan
>
> ...
>> +	data->client =3D client;
>> +	mutex_init(&data->lock);
>> +
>> +	indio_dev->name =3D "ads1100";
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +	indio_dev->channels =3D &ads1100_channel;
>> +	indio_dev->num_channels =3D 1;
>> +	indio_dev->info =3D &ads1100_info;
>> +
>> +	data->reg_vdd =3D devm_regulator_get(dev, "vdd");
>> +	if (IS_ERR(data->reg_vdd))
>> +		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
>> +				     "Failed to get vdd regulator\n");
>> +
>> +	ret =3D regulator_enable(data->reg_vdd);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
>> +				     "Failed to enable vdd regulator\n");
>> +
>> +	ret =3D devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_v=
dd);
>> +	if (ret)
>> +		return ret;
> Please could you check a subtle interaction of runtime pm and this devm m=
anaged
> flow.
>
> I think we can hit the following flow.
> 1) In runtime suspend (wait long enough for this to happen).
> 2) Unbind the driver (rmmod will do)
> 3) During the unbind we exit suspend then enter it again before we call r=
emove
>     (that's just part of the normal remove flow).
> 4) We then end up calling regulator disable when it's already disabled.
>
> We've traditionally avoided that by having the remove explicitly call
> pm_runtime_get_sync() before we then disable runtime pm.  I don't
> think that happens with devm_pm_runtime_enable() but I could be missing
> a path where it does.
>
> If the sequence goes wrong you should get a warning about an unbalanced r=
egulator
> disable.  The fix would be an extra devm_add_action_or_reset() before the
> devm_iio_device_register() below that just calls pm_runtime_get_sync()
> to force the state to on.
>
> Gah. These subtle paths always give me a headache.
> We don't normally have too much problem with this because many
> runtime_resume / suspend functions don't change reference counts.

Just did this test, waited a few seconds, checked=20
/sys/kernel/debug/regulator... that the regulator had been disabled.

Then executed:
echo -n 3-004a > /sys/bus/i2c/drivers/ads1100/unbind

to unload the driver, and no messages were added to the kernel log.

I could see the driver going away and removing itself from iio and=20
regulators.

Tried this a couple of times (using bind/unbind), and no problem reported.

Hopes this helps with your headaches...

--=20
Mike Looijmans

