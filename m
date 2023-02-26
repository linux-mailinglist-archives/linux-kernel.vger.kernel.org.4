Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E1F6A2ED8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 09:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBZIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 03:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 03:24:15 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52FEB47;
        Sun, 26 Feb 2023 00:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No77AJRWbGcwC4C4nfN8rBOkPYzXfgu8jTevg4lDE7o=;
 b=uTrl8IZ6HP9rkN2q8jiaxoUWKC0+T0kaCav962yC0Lx35nm3Uxw3+DckaT0vQQve+7LXrUw1/XqGN/1q5AxhfHgQGQpTsbur+24PzDuyN2xSuffFmh7jM703owzA37lP82x+ZIVz49YRSASbeYOX1R4B2vUIM0qn55qNZfGqTru0fcxihs/zwYGB4CAKDmFQkVmR8Y5yTKeDgJwAcCnDyU64XxN8q+vjkMqdsRaC32vHxGEOehnef14AqSwu/EPY3WvV09td79NnKQ+x+6RyuvCZXumQdwSs0FItuvd87iJcmX+IEyUNLngtSdJsHJlpspQOMwwxoHUPweQbJyXlYA==
Received: from DB9PR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::23) by AS1PR04MB9454.eurprd04.prod.outlook.com
 (2603:10a6:20b:4d9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sun, 26 Feb
 2023 08:24:09 +0000
Received: from DB5EUR01FT040.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d8:cafe::b3) by DB9PR01CA0018.outlook.office365.com
 (2603:10a6:10:1d8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26 via Frontend
 Transport; Sun, 26 Feb 2023 08:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT040.mail.protection.outlook.com (10.152.5.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24 via Frontend Transport; Sun, 26 Feb 2023 08:24:08 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.58) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Sun, 26 Feb 2023 08:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR/fqXM5a7x/WxoxV/MZUCDm5tftnA0kGi9tcLOCdbugZPCzxmQVbQh3QAsQPvK28nm8Q74pfqjGlB9aj3Hm3zVNRzaElhBQC6mbZzn1NSvhL9aItTCEbEih3+q/bdCSngobhIY6jyEtdSNQjwYMXfcRC/7J/RbLrd0KooSvRFDWqots++1e5/QQY7uWEqwGNhdcIcmaXWjKGe22q9Oa2bUdJY57/CElnW/EDZu5T6QDzhOusTm1gmJlJlXvqN+PUcqk4IG+kB5DV5x/eZrKj7k3FoHQyWC9oc+LCjVs7SceenvNsMCzfhKCD6mfod9IR4msKwNR7Qede01vtS5n+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUA3movr4koW7kSw18P8pR/h2BIAjejc7g60TUqXluE=;
 b=cCtTJkq+OzDiQMY0Y2kc9HNsf0LluVHUnr9trwYtQ5Mh7NRjdFQDUTGDBZov0uHZyeMw5FKMrUJAullY6MfqjPfge5PxRSLrk6YplTzEyMz9mXx8Y8x61zdGMuDLfFmB9aKt0jd5HtDoEejwODbjpmK2cFX9e2Blb8ZMXjh7B2FaBzKVncYyOHifQil2kFgxcAubd87t9SRMBgwalgqq+BOKTmSmbBAZNJmZpUjmEJ+R8nJ5M9Vt/21eUPN1JlXMH3g7kSBDfQNlSWDoXu37Dx0+kd0vyPyz8lGekT5VMmsUmw5qEgqe09hSlELvEnCXC6EjPF0SrY3R7RkIowp/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sun, 26 Feb
 2023 08:24:04 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%7]) with mapi id 15.20.6134.027; Sun, 26 Feb 2023
 08:24:04 +0000
Message-ID: <4aa80b81-6b20-3095-f109-cf83d175fbf7@topic.nl>
Date:   Sun, 26 Feb 2023 09:24:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/2] iio: adc: Add driver for TI ADS1100 and ADS1000 chips
To:     Jonathan Cameron <jic23@kernel.org>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230217093128.8344-1-mike.looijmans@topic.nl>
 <20230217093128.8344-2-mike.looijmans@topic.nl>
 <20230218164832.695fe5b5@jic23-huawei>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.02fda1de-62d6-4f7a-9537-1a2cd4a482bd@emailsignatures365.codetwo.com>
 <18a6b72b-4165-c9e7-3dc7-81fa85f0e4e9@topic.nl>
 <20230225170131.0afbfcb6@jic23-huawei>
Content-Language: en-US
Organization: Topic
In-Reply-To: <20230225170131.0afbfcb6@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:208:122::39) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PA4PR04MB7727:EE_|DB5EUR01FT040:EE_|AS1PR04MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: afc06c35-3731-42f4-179d-08db17d2d4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ADSPAUTLLmkxn6x5Bs1kflYNdZnV2/dZE6tgyZ9fHg2AW9wLpSOxh/X6mzshbGhiXVk9gQEsTzoC5Or8iG7qhuGce1QamVUKTxZd7lClq9ylwLBtataZ1b3qJpug7RWkreNmpG+dxKHmYH7cVS8HgibQc2I0z0OzjKs+6DW30WN5/RhMQGk+53PBX3Ben1YOs2m2RqGVfwxLIv+MBr1X95jg0jEmLXO+lvH+urMq/IQ3z78EuCNiXBFEN6WtA5/CDP99vpV7+PvV2a7fbQvneH74ZjXJlFtQv7v7+t2FL5OmwdaohD2nkHitYrUpvHAR8nFpHkAGpWVAUijP/QSgWLCpCcSGH4dvklDbf41oxHaoPlP/6KRHaAoVrgF6zFFcho6UGP0vmJaV5hW9jEHJlxXLV/nQzoEdMJVqs/4qSXg3fcqOzi0DNtdvqlAOtaJZbNiRxBctk6LQgQqU3jaRYb2WzZKpmWfSubxpYe2g1Mt1ddco8ovgXDxMKoFK0+EQWA7kqE4pgfLoF85xcq0BHQZ+PJDbswsERZmGLUwXWkRn1KVILrM3WWfxkNiKlA7G2SrgwWjLEm6XCntnnol40Cdboa/+bdRT0QOAVtA2zaD1t6a0CXGtOIplXrlcLPVl2otxoSL9cL9RX3QSDXnr5RrMwJtEYjJGoBGuRLu9oQQfs/YSE5yAz7oIMOhVn07+H9zpVaTgVzDkCbBKSJU+u1ZXs71KgBkxNmxSeLimG5T17SjIEeYzXQ+lR39VwoI4n11U7xgvELlwuGjdzBDFDQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39830400003)(136003)(366004)(376002)(396003)(451199018)(6916009)(83380400001)(66476007)(8676002)(4326008)(66556008)(6512007)(38100700002)(38350700002)(2616005)(54906003)(83170400001)(31696002)(36756003)(316002)(186003)(42882007)(26005)(53546011)(36916002)(66946007)(6486002)(6506007)(52116002)(478600001)(66899018)(7416002)(44832011)(5660300002)(31686004)(2906002)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727
X-CodeTwo-MessageID: ef5c75f3-4b66-4f69-9b9b-7a8a988fa3cd.20230226082407@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fdf50418-1bad-48a3-6ff5-08db17d2d214
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /37xO1ChX7FCqHLzeoUoVtX9OSZfVWaQeyQN7K/uKbWfKoIRv1aKsgAJM9qmBB/AIaQTheYdvNMjuxiC9hlBiyyq+ayXfv6DcPoBgAzSORcQScz6kL++j8cT4elqf87IA/mfEHe23IxGloHjXuSDqYtzhZSWwXNcu4zRamxlcfNzq+tqADmSCXYGT/Hd/SIjn/NUZUu3o4S7EzkuhMVNEiZ/OeHusYVOCnOE2OkhtQEHO5LqFMlXGelrPNdbhSQ4WtFzxvnYKNttwFa8RphKQSfFcIumAyOFI5RX0mKmE79O+CpkuMOqzuZMBavHbbkgd3JJPKPauB+XmmMXqXT8VymhdIF6h0PY+5rvjDjt8YotczWL71B0DozRVPO1x7FISr2N4JorWse84x6pwtq+4t8RdlWvLydNl8zykDT9UGZScMdF+UKF6BjDNvzooZOHFC//6mZtS3C3ujgxdC6uG2D4BFrOpVNahig4jCdToDp84pUq6FLqyW6QzWWUF4wkuRX/Z5kigW8xcQHT9K8jcmkaQXa43At8sxmc4zMH0EddyozrZtfGniUJnVj/o3mQMF52fg+V1rlTwm7RXx6vQeJUpNEBnALFG5ZTyDvuDlfiW13Ngwfb75IyFLDlJRfFzIZ+ew4CR6WT73MsgxzogHmPNclQg6nLsAmzhks07vksZPgILgvKAj2f+jhr8Cjs
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39830400003)(346002)(376002)(396003)(451199018)(46966006)(36840700001)(2906002)(36756003)(7416002)(47076005)(44832011)(42882007)(83380400001)(336012)(2616005)(26005)(40480700001)(356005)(83170400001)(36860700001)(7596003)(186003)(7636003)(70206006)(70586007)(15974865002)(8676002)(4326008)(6916009)(316002)(5660300002)(41300700001)(8936002)(36916002)(6512007)(53546011)(6506007)(54906003)(478600001)(31696002)(6486002)(82310400005)(66899018)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 08:24:08.3061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc06c35-3731-42f4-179d-08db17d2d4f6
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9454
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
On 25-02-2023 18:01, Jonathan Cameron wrote:
> On Sat, 25 Feb 2023 12:03:05 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
>> Comments below - mailserver has a top-post fetish and will inject a
>> signature here somewhere...
>>
>> No further comment from me means "agree, will implement in v2"...
> One 'nice to have' when replying where you have chunks like that
> is to just crop them out so it's easier to spot the interesting bits.
>
> I've done that below.
>
>> On 18-02-2023 17:48, Jonathan Cameron wrote:
>>> On Fri, 17 Feb 2023 10:31:28 +0100
>>> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>>>  =20
>>>> The ADS1100 is a 16-bit ADC (at 8 samples per second).
>>>> The ADS1000 is similar, but has a fixed data rate.
>>>>
>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> Hi Mike,
>>>
>>> I probably overlapped a lot in here with what Andy said, so just ignore
>>> anything you've already fixed.
>>>
>>> Biggest thing is HARDWAREGAIN.
>>> That is very rarely used with ADCs.  It exists to support cases where
>>> the gain is not directly coupled to the thing being measured (light
>>> sensitivity of a time of flight sensor for example).  Userspace expects
>>> to use SCALE to both control amplifier gains and to multiply with
>>> the _raw value to get a value in the real world units.
>>>
>>> It's a bit fiddly to do the computation, but typically at start up time
>>> you work out what the combination of each PGA gain and the reference
>>> voltage means for the scales available and stash that somewhere to use =
later.
>> Complicating factor with this ADC is that the final gain value depends
>> on the sampling rate as well as the power supply voltage. Which would
>> lead to the "available" list being different after changing the sample
>> rate and confusing userspace. If a userspace app would read the
>> available sample rates and gains, and then proceeded to set them, the
>> results would be weird, as the order in which they were set would
>> matter. Setting the gain after setting the sample rate would likely
>> result in an EINVAL error because the selected gain is no longer applica=
ble.
>>
>> To me it seemed more logical to provide the analog amplification and
>> sample rate as separate, unrelated values.
> It may be logical, but it isn't how the IIO ABI has ever worked and it do=
esn't
> extend to more complex cases.  It's in general true that a PGA will resul=
t
> in a change to the scale that userspace needs to apply. There are devices
> where it doesn't. There are lots of things that at first glance 'could'
> affect scale but often do it in complex non linear ways that userspace
> simply can't know about - hence if we are pushing calculations into users=
pace
> we need it to just be (_raw + _offset) * _scale.
> Note that there is some wiggle room with how raw "raw" is.
>
> There are two solutions that have been taken in drivers.
> 1) The above software flow is broken as any ABI write in IIO is allowed
>     to affect other ABI elements.  This is less than ideal though.
> 2) Let the scale free float.  So the attempt is to keep as close as possi=
ble
>     to the set value as other things change (i.e. the sampling frequency)=
.
>     The scale_avail reflects current settings of everything else, and ind=
eed
>     changes with other ABI wirtes (this is quite common) but the interfac=
e is
>     made more intuitive by matching as closely as possible. Thus if you c=
hange the
>     sampling rate and the scale changes then you attempt to modify the PG=
A
>     to keep it approximately the same.  Obviously it clamps at end points
>     but nothing we can do about that.
>
> However, having said that, I don't 'think' we need either here...
> A common thing to do for scale vs sampling rate (which is typically
> either oversampling based, or based on another SAR cycle) is to just shif=
t
> the raw data to incorporate it - a common sensor design is to justify it
> so that the unused bits are the LSBs - so may be a case of just not shift=
ing
> it to compensate for the datarate change.. That's not true here if I read
> the datasheet correctly, but a simple
> sysfs raw read value =3D=3D raw_value << (16 - bits for data rate) should=
 fix that.

I agree, a bit of shifting (pun intended) is by far the better solution.

> Interesting the datasheet argues they deliberately right aligned and sign=
 extended
> to allow oversampling without shifts, though counter argument is they mad=
e everyone
> who wants a real scale apply a shift.  I guess it depends on the expected=
 use case.

My guess is that the chip internally always runs at 128Hz and simply=20
adds the sampled values together in a 16-bit register for the lower=20
sampling rates. Someone came up with that datasheet text later on.

>>>> +
>>>> +static const struct iio_chan_spec ads1100_channel =3D {
>>>> +	.type =3D IIO_VOLTAGE,
>>>> +	.differential =3D 0,
>>>> +	.indexed =3D 0,
>>>> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>>>> +	.info_mask_shared_by_all =3D
>>>> +				BIT(IIO_CHAN_INFO_SCALE) |
>>>> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
>>>> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>>> +	.info_mask_shared_by_all_available =3D
>>>> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
>>> Hardware gain is normally only used for cases where the gain is not
>>> directly related to scale.  Things like the gain on a signal that is
>>> being used for measuring time of flight.  Here you should probably
>>> just be using SCALE.
>> In this case, SCALE depends on SAMP_FREQ as well as GAIN. Which will be
>> very confusing to userspace.
>>
>> Hoping for some leeway here...
> Sorry no. Though I think applying the shift as mentioned above deals
> with your data rate dependent scaling and makes this all a lot easier.

True.

...
>>>> +	iio_device_unregister(indio_dev);
>>>> +
>>>> +	ads1100_set_conv_mode(data, ADS1100_SINGLESHOT);
>>>> +
>>>> +	pm_runtime_disable(&client->dev);
>>> I'd expect runtime pm to be disable before messing with the conv mode.
>>> With a little care you can use devm_runtime_pm_enable()
>> Setting the conv mode involves I2C traffic. After runtime_disable, the
>> power supply to the chip may have been disabled, leading to
>> communication errors on the I2C bus. Hence I thought it appropriate to
>> write the config register before turning off power.
> pm_runtime_disable() is disabling the runtime management of the power
> not the power itself.  That you need to do after turning off the
> management (thus avoiding any races)

Ah. But does that mean I'd need to disable the Vdd power supply here as=20
well?

--=20
Mike Looijmans

