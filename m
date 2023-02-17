Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC3069AF24
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjBQPLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjBQPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:11:14 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970A7268E;
        Fri, 17 Feb 2023 07:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvPyrSm4TSLBON3HgnjUYphu07b+5XwcGoTfKmn6J2Y=;
 b=T6LtYrSxu/M3d624YIxLfjFNW8oOAHfvLhNY4dvOJM6H9GVaoUxnLlUsidoRLe72SLOF5+uu7Y1pbEN4SfVjj1jVhiAhl6MeDySG6R/UzXKOv3OJ+rMJPbZaENHXVHxBJP9VhYL3bhtw3qHx1EZW05S4ctWI9tjGNVaCEclIbJHiNWyZETfsQZrcHlODlOIdhdHDzY/PtYhEO//Trrm96nreLcBFGsJ+5+RcUCAFrMET8tT5qA/KLumT2jaaTAVGmvgUzMFgogRl4M26oSYiL4OoNOToRtKVPNwONCRwrASS7NPuh6hWm+tx3b0tHhk0kCY8HJTpVAz327i4xOCAxw==
Received: from GV3P280CA0108.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::19) by
 DU2PR04MB8696.eurprd04.prod.outlook.com (2603:10a6:10:2df::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.15; Fri, 17 Feb 2023 15:10:59 +0000
Received: from HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::56) by GV3P280CA0108.outlook.office365.com
 (2603:10a6:150:8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15 via Frontend
 Transport; Fri, 17 Feb 2023 15:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 HE1EUR01FT031.mail.protection.outlook.com (10.152.0.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.13 via Frontend Transport; Fri, 17 Feb 2023 15:10:57 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.50) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 17 Feb 2023 15:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYoYZvqgDgljKvdV6ASr4MR4KX98TAb1hGc3Lq3RzOxcBHjrswhkxeaGWB8hlqI7s2zmOza/QUXW7lC8tOYdMag1URgaFbZ5lge/2tctUmtvVuILtp9payhNxIHCwSzxuSrYXy4E2HiQkq9aVvUhiO5uAKfJDLkS407YAtBN+qeIRHQE+FAh78vfmJB6lC3GwANjiyAwdQzOOiYVsPv1JZCzsNLK/rrNyDRFRmNBsF85lcxK8CyBz6zuauCX68aNVxBE246/z67bNxvm2kDzKvEYMZ/CPF4ghTePG/TxNvS5VnEySU3TLBHx/J3B2gJ5XXjJfEdqlZ8kidSHEJQlpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHeRip3FaH1InDqwJFzNeQcru9ajnbJIVQa3NG21eKY=;
 b=lKK3+GbJiTXBp1g9+mPVQDiU9AmpylPUldv2HLWt7IRJqtx6HNIKSDz6t4RliiPqOLmjNBbH26keovUhjAaVMnC6XZgBsXhm1APmH7mpB+kmLYm6DQE99V24OJ1iQoqjHQnDqGPpK/MAQQYgXaX4B+mSh7oYNm2XB6OOsXOaobjW00OtwQPJ4fpCWALHuEspQYLVeSAeRwDxwlA9ccEBaLbitCIcbtGs/GZtDHR4EAQ1KD+f0xczZXIBRr+0pCRljcojCkPVrcNttbWJy9A1fkwTwZADdhlkuRzJSgd0SFVLZgxyf3MZIHYMILutY70AcMMoHIn2AeQX+uZbriPpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB9PR04MB8379.eurprd04.prod.outlook.com (2603:10a6:10:241::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 15:10:51 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%5]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 15:10:51 +0000
Message-ID: <b3fde4a8-e344-9d3d-0b1e-9a11c4dd09de@topic.nl>
Date:   Fri, 17 Feb 2023 16:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/2] iio: adc: Add driver for TI ADS1100 and ADS1000 chips
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230217093128.8344-1-mike.looijmans@topic.nl>
 <20230217093128.8344-2-mike.looijmans@topic.nl>
 <Y+9zR3bhlEMuma66@smile.fi.intel.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.9c64e84d-a2fd-448c-9100-2fa583a49f45@emailsignatures365.codetwo.com>
Organization: Topic
In-Reply-To: <Y+9zR3bhlEMuma66@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::7) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|DB9PR04MB8379:EE_|HE1EUR01FT031:EE_|DU2PR04MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: e1aece93-efcf-4e5a-b0e8-08db10f92c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Fd2/T65Z9af52KI/RuMbVAAA1fJT+dlSUlfAjVtmvFIQV2hKneHB4W3+HXiL8abYQHslfFXx2SEYn+u2C79Id3OIec9kbWEIU/M2iT2URXyVqXxjB4TLlkSYmmzvcRfcbbHa/bHn5m5BJvnyed/w+vWxlgZK13Gw/T4kyZcLDYOHiUSC/rN+mCu2MLCyd5EciFjt7PedrD2VgmZ87rQNL9sMpHSEoRPvsr0pM7YVYhXgaK97Tfmy/C5HRnEVraj1N360pI5g9K/q3nYAF8K59LPQJeJKXQtt0xHssMJRneoAR1ssjw18rprbOTnx1k4iGae1XYzhyEEaoaSSnTIqWIXxfnBdUQhg5Ib8pEqIsKDrpFnoiVQ1aENJNF7qItuwyxQuvByoEpvoV1BWC5w0T4zWuGy2GFhS8V8zShK5Cl6WxyWO7mnRnnK6SnW8Ov7RmvZ0QV4rC1ieiM4cFg0ynAiHJNavkBL6oFPz8lOBYasVD7pRFuTZlA40DhCah7kHxx2P80aS2ce7gfNT8Wlsh7Zf8jCyizu8OlJxM09hj7R32f1HOzb2AbKfgv9izyMyYOpFFHU9cnPHuEIs1fSSw6sGRCR/2G+la4LaQxQLQZNp4YZfx2OEZXRZmmG5K/96z5q69oH7KW32qS9r31SVVw0mEre+qqkfocSsMEU+HeAFHPbZQnF4cj0fQadC4RdDl2le231aL9wrp2ps7c0VTARBsWvInfw6rzNEYK/xTNSKGVYZLkVm0kYM0t80Fe0Gr93V1n9AFyOwvFEHCbftWA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39840400004)(366004)(346002)(136003)(396003)(451199018)(31686004)(36756003)(4326008)(6916009)(66476007)(8676002)(2906002)(66556008)(8936002)(66946007)(44832011)(5660300002)(7416002)(83170400001)(38350700002)(38100700002)(31696002)(36916002)(52116002)(6506007)(478600001)(6486002)(316002)(54906003)(41300700001)(83380400001)(26005)(2616005)(186003)(53546011)(42882007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8379
X-CodeTwo-MessageID: 33cd9115-2b63-458c-a15b-ad94c2ec2e0e.20230217151056@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b30ba54d-0742-4f8a-8548-08db10f92829
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7HeKAB2jioxi63OfSiPinwjTzSdjck2HlSAbRhCwSkwpCGwitmBXf4y+S3L3U6SkEzTTlksnzfw4M9jk/TdHPdK95SxC0g0n+NbZPYoJf0eFVg6tIP/pnCixGw9rze+slsem/eQmDbSK9u9YvlgIR4MCgJdcwQmEH1PQBPN8MC/OArK9nWVBUCYBvjiR20lq/IfZGftubQLLqVxWR+kmbkkZLOmOm6OkF5AT1ps27pUBfma3gJKgECV+g9HXAoiHBUiBTP1UL1wXCiGdORrjo+EgL3zdTJKPppn6vJsRlYgnP7EvXyTvVQadilrzh+KKh16EmW8zquO6Pxx3q/sF1Z2XWUgYQdpV0pAk7q/hfw81Ha/cuKRCR2eVAX+tAI7oczFDZ6m3r1CJN7iga/OER3EH0iKko5PJIrporOdRb8SXZp9UBcBJFpbG3E95PbLVoBr8yW9rLIrZBkDukE3drT6exZJ+RqqMXfWo8aq4XOcW+xlZDRAyRIyrnRk4La6ZBUN/lRwh0pXdgUnHCPb8CzZARHeexn2KmVv6YsNtXjfTZeXjieZ/SvzYZ/SjaF3I9p1Udl+ldfGJSnrQYPhoevVgTJNRNd4nMydFXCGAZ4r0oxIQmKZmDSdzPQE20j3DaX+eWe7v4XDTdV0NJSLN0rJVvz/E3yKadOJr21u6HiXCb+3paosr3+IMhs72LzI
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39840400004)(396003)(451199018)(46966006)(36840700001)(31686004)(36756003)(15974865002)(6916009)(2906002)(8676002)(8936002)(70206006)(70586007)(44832011)(5660300002)(7416002)(356005)(83170400001)(7596003)(4326008)(36860700001)(31696002)(7636003)(40480700001)(36916002)(6506007)(478600001)(6486002)(54906003)(316002)(41300700001)(82310400005)(47076005)(83380400001)(26005)(42882007)(336012)(2616005)(186003)(6512007)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:10:57.5462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1aece93-efcf-4e5a-b0e8-08db10f92c56
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8696
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your quick feedback. Replies below (skipping signature added=20
by borked mailserver)
I'll post a v2, want to do some testing first with the changes and I'll=20
have hardware access by the end of next week.
No further comment from me means I agree and will change as requested.


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
On 17-02-2023 13:29, Andy Shevchenko wrote:
> On Fri, Feb 17, 2023 at 10:31:28AM +0100, Mike Looijmans wrote:
>> The ADS1100 is a 16-bit ADC (at 8 samples per second).
>> The ADS1000 is similar, but has a fixed data rate.
> Any Datasheet link available?

Yes, will add a friendly link.

> ...
>
>> +static const int ads1100_data_rate[] =3D {128, 32, 16, 8};
>> +static const int ads1100_data_rate_scale[] =3D {2048, 8192, 16384, 3276=
8};
>> +static const int ads1100_gain[] =3D {1, 2, 4, 8};
> Do you need all of them as tables? They all can be derived from a single =
table
> or without any table at all (just three values).

I think the "data_rate" tables make the driver smaller in size, it's not=20
a straight power-of-two list. I want them anyway for passing as "avail"=20
sequences.

The "gain" is a simple power-of-two and might be replaced with code, but=20
makes the "avail" more complex. Even in this case, the code to generate=20
the list will be larger than the list itself, and I need the list in=20
memory for the IIO_AVAIL function anyway.


> ...
>
>> +#ifdef CONFIG_PM
> Why?

I based this on the ADS1015 driver. Which appears to be outdated, I'll=20
convert to DEFINE_RUNTIME_DEV_PM_OPS

+ int ret;
>> +	u8 buffer[2];
> __be16 buffer;
>
>> +
>> +	if (chan !=3D 0)
>> +		return -EINVAL;
>> +
>> +	ret =3D i2c_master_recv(data->client, buffer, sizeof(buffer));
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	*val =3D (s16)(((u16)buffer[0] << 8) | buffer[1]);
> 	(s16)be16_to_cpu();
>
> But (s16) looks suspicious. Should you use sign_extend32()?

The chip always returns a 16-bit 2's complement value, even when only 12=20
bits are actually used. I'll use sign_extend anyway, just to improve=20
readability and take away doubts such as these.

--=20

Mike Looijmans

