Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222AB6A7C0A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCBHtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBHti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:49:38 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0610.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BEE144A0;
        Wed,  1 Mar 2023 23:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCXq3Cf9k0Ce3JPZWz0/xQySZaJrcRRMUE7tdtvUEAk=;
 b=mCsq1CKO1j719a9eQr4Oebxt24GX99+8n9iHrKW19gIo7XUo2kWempTnpoGFN7S7XiaCCZR6OxWin2+OE4EQAYdepvZkkvvBF0qTK9P2UnA3SAnXu5JZzqfwqD3CyxqyuGCVrE1dyATlKF66bIw2sWQJ2CwgltT229tdYlNfVPm6IQTgT5eYdDDN5+a3WEDr7+nOV98mPzk/gNogorRVyBtBJ5N+iYq/oRbI9i7ZLDrfJRjo1A6/SkCFeuzYHMAxC9ve0Zmapr7iO2CtqHAKDA9wZZzuQCcwfAKFWDxUgPogCLvd9YIXOxsegsif59nQNX4cSWVMGK4Hpc+3nMU1vA==
Received: from DB6PR0802CA0046.eurprd08.prod.outlook.com (2603:10a6:4:a3::32)
 by VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 07:49:29 +0000
Received: from DB5EUR01FT101.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a3:cafe::5f) by DB6PR0802CA0046.outlook.office365.com
 (2603:10a6:4:a3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Thu, 2 Mar 2023 07:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT101.mail.protection.outlook.com (10.152.5.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Thu, 2 Mar 2023 07:49:28 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.108) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 02 Mar 2023 07:49:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElOzymMxFAVQWjlwgm1bYA4ePOMw6Rkpg4tKPXMj50rq3vVnvccD+cc20mAxp7OTxqpeWcaOAMMslx6iqXVeqEkPJVjSYv5621tlxnc+U8g2kmKSzgIt8L7N/uSYT/iokKOEGobzK5Oo+pMTVw01D0oYVuid+B9HC1s3qbrAg0ZqPTqyBiON8muaYAC5QAcRAMjGv2UCPsIjF/zczrwHA3yBhAJIrW5vHsH/D6rxCw+S6zqveoRd/lZQHUL1I51dUHcsAxzKDSu4z+FCIMHZEuaL1keEC8rrWO8jg/DifNIeLIOu6nhij+bYZpC4ogfKrE1eAjG825lOR5WmnJoryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6BHd7qNe9fNXKzhbVcZgSnkTVbxHoJWYS4dhiSOs2w=;
 b=C5qRvfMruzktvpUsgOIXTH3P+HW5CIuCIqQ1Z5nqFqIJJ12IT7UzjvZcQPGgRA9f8ra5gMckwKuZ0mBNZAq/oVnEMqEHw8HX8YuHRpQRhKEgk5NN/KukZW2+eqccne0E1TmkZjvXQWYJDjLoQ27mrZK2y/sbtViX8G9l1edapxvapYdJznuLO4X90yu+3L5Tz8eVPNNtLpUAyRJeGmFszkrM5KU4uHTDWrpT+kf700GKmYt+00PTaALlYQ29cyTjrsFnXk88VmTzjysRVcJAwcJig+ih8BY3Rzr+ghD89XOduE4EpVIJ23iVKj7yUmU0AdXH+7kb/2i51NLFgpt6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB6969.eurprd04.prod.outlook.com (2603:10a6:10:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 07:49:24 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%7]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 07:49:24 +0000
Message-ID: <a2ba706f-888b-0a72-03a5-cbf761dfaf19@topic.nl>
Date:   Thu, 2 Mar 2023 08:49:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
 <20230228063151.17598-2-mike.looijmans@topic.nl>
 <Y/9vez/fzLD5dRVF@smile.fi.intel.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0685d97e-4a28-499e-a9e3-3bafec126832@emailsignatures365.codetwo.com>
Content-Language: en-US
Organization: Topic
In-Reply-To: <Y/9vez/fzLD5dRVF@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR10CA0120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::37) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|DB8PR04MB6969:EE_|DB5EUR01FT101:EE_|VE1PR04MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: ea98b925-1dce-4ea8-6674-08db1af2a6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: S09X1kmNgeeCi3DqTT9/Mk7NwprbsZcmOAEtbe2ZzagrhppDohhmeQTNtnMptIWLeH9nPqOhDvhnKAKLXLi+L2SWi+h6wr9ovWtR70kHMRCeAl6LAK31xut9LYkai/OhIlG6zQbDJFuUtLQzC9bxhWOxd6iTIjJZooGlv1rQYeXZrnZ2i7iI2qyZLfJ28RNENwXONGk6v5kxbjWVLTN21dvjrTMyfiPuIMdORBrNzhxFip0iT4AgkgpYyNXXCEngAscRRNNU0iwX21yvZyUbZ/ncthfSeLPmC5j1Lpbw38d4uN/8psARnasRppK9HAHfvB6LomOCmKON7TTuP3qCiVOHySuS3gXs0hCZiMaNQO63vhE3qolcihXbcZxfU8oS+61Q1KADceGr4rWQI2tNTXuvQiXaGVZmxM/SPOIzTFsUcq9wWLZFcGFiEtNzhqmdUR1dcvbEbta5uHDA7FFHQC92qbOFE2ArWuKU24sVeH7DE1/8d9aos8vNyf/jrN7vf/a8Ih7HF4SX14Itmb0aNswBFrBdd7BZVrG7CSsVNTtuENLQhIx6nfiQjYST6fYGyzW2k+kts1Xw1eX9RLMGII3LlIm2cP43ZEsjod1DgzTOh8CiJUSVLjVM31vBxfFApm9a7VAoVSRg1MAHvfhNxKux7Or8qHLf0DJX65QffjYFUdwEoPZmpN2JeZ3eVPAqVVyD0l/iusvzkeB7TWJh1e0tOhzzEwpb4znA7v1VFCpf4UnsxwGw+4DnekNYL/D8Vz3ljb1g9xLyMU0toMZxkw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39840400004)(396003)(366004)(451199018)(36756003)(53546011)(4326008)(6512007)(6506007)(6486002)(2616005)(42882007)(26005)(186003)(41300700001)(52116002)(54906003)(316002)(66556008)(66946007)(8676002)(36916002)(44832011)(2906002)(6916009)(478600001)(8936002)(5660300002)(7416002)(38350700002)(31696002)(83170400001)(83380400001)(66476007)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6969
X-CodeTwo-MessageID: f30e88b5-1d77-4b2c-b498-93f30e2cfcb9.20230302074927@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT101.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 08161c04-fde7-48e6-1f3a-08db1af2a3fe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMBFLFBkUfem31sUozTiyyHG4IzMeMDzX0XuOchyKnsZMZ+kNqGnjdljzY3+XKPZqCP8YYhGDfpad0kdVd6NK1UZQ53JyMrq4jB8f51VpNyD29VBAYeeQXQDqSdw5MsyyThRb0UfQgIfm8Otl0o1U6X+LdGfhSllCi7ETRT5Ir29kLNazKNHXcpnCbXxVtTig9CVFdflCdXBzAlWvWdZU8jjEUOkXTOgKTqp8AS2/lzoyAvsoxZfp/IfxOV9z2VKxr2SO6kF/3DjeK0MDcWKnM1mhikGJ+QOHKDeHrHpLElGCI3QPQVh9oBoQXnHYI32b3XTzfnFAbyvqc0y/49IUYE5tXrtFuS8Gvrsi3+AC2OI38wZzFbWAbU/oqUO0pfDVCpvkZBxL5Lb3JTMVeyP1qoQjnX+6ouAKxzVDW0srhbhXK1OxB4BsSbYa1b767B1Vxfs7YivjSROtqmGpEbUKhoCI/8fJadtxoEUIjHU9Njh+inn7SnpfzHhXPKLzRVUmcLyp1gsVVgtAD4ATJGNrcSn7n8ks+xpULVyFjujBuwjVOht54vM+I460T8Jykenfv+j2P7DvtbHAKIgT9WTNt3q+LR/w6msA0uUmbnOJvpwCfv+RH1kvEyRKTpWk9amHD5IoPJP5Y59bdgFng03ODqQdLCGj4cEvSpAGjAXRXdRQ3Z5VCttB6l0GT4Z58on
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39840400004)(396003)(136003)(451199018)(36840700001)(46966006)(44832011)(7416002)(6916009)(4326008)(26005)(186003)(53546011)(6506007)(8676002)(7596003)(31686004)(5660300002)(70206006)(7636003)(478600001)(2906002)(70586007)(8936002)(82310400005)(36916002)(6486002)(54906003)(36756003)(15974865002)(6512007)(40480700001)(2616005)(316002)(31696002)(336012)(47076005)(83170400001)(356005)(83380400001)(41300700001)(42882007)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 07:49:28.3459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea98b925-1dce-4ea8-6674-08db1af2a6d2
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT101.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7213
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comments below. Mailserver has a top-post fetish and will inject a=20
signature here somewhere...

No further comment from me means "agree, will implement in v4"...



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
On 01-03-2023 16:30, Andy Shevchenko wrote:
> On Tue, Feb 28, 2023 at 07:31:51AM +0100, Mike Looijmans wrote:
>> The ADS1100 is a 16-bit ADC (at 8 samples per second).
>> The ADS1000 is similar, but has a fixed data rate.
> ...
>
>> +	/* Shift result to compensate for bit resolution vs. sample rate */
>> +	value <<=3D 16 - ads1100_data_bits(data);
>> +	*val =3D sign_extend32(value, 15);
> Why not simply
>
> 	*val =3D sign_extend32(value, ads1100_data_bits(data) - 1);
>
> ?

As discussed with=C2=A0 Jonathan Cameron, the register is right-justified a=
nd=20
the number of bits depend on the data rate. Rather than having the=20
"scale" change when the sample rate changes, we chose to adjust the=20
sample result so it's always left-justified.


>> +	/* Calculate: gain =3D ((microvolts / 1000) / (val2 / 1000000)) >> 15 =
*/
> Can you use more math / plain English to describe the formula? Otherwise =
we can
> see the very same in the code and point of the comment is doubtful.

I'll try to explain it better.


>
>> +	gain =3D ((microvolts + BIT(14)) >> 15) * 1000 / val2;
> Something from units.h?

Could put MILLI here, but I doubt if that improves things. Its actually=20
MICRO/(MICRO/MILLI) given the explanation above... Not helping much...


> ...
>
>> +	for (i =3D 0; i < 4; i++) {
>> +		if (BIT(i) =3D=3D gain) {
> ffs()/__ffs() (look at the documentation for the difference and use prope=
r one).

Thought of it, but I'd rather have it return EINVAL for attempting to=20
set the analog gain to "7" (0nly 1,2,4,8 allowed).


> ...
>> +	for (i =3D 0; i < size; ++i) {
> Why pre-increment?

Spent too much time with other coding guidelines, missed this one...=20
Will change.


>
> ...
>
>> +	int millivolts =3D regulator_get_voltage(data->reg_vdd) / 1000;
> units.h?

Should I write:

regulator_get_voltage(data->reg_vdd) / (MICROS / MILLIS);

I doubt that improves readability.

> ...
> ...
>
>> +static int ads1100_runtime_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
>> +	struct ads1100_data *data =3D iio_priv(indio_dev);
>> +
>> +	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
>> +	regulator_disable(data->reg_vdd);
> Wrong devm / non-devm ordering.

Don't understand your remark, can you explain further please?

devm / non-devm ordering would be related to the "probe" function. As=20
far as I can tell, I'm not allocating resources after the devm calls.=20
And the "remove" is empty.



--=20
Mike Looijmans

