Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E006ABFFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCFM4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjCFM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:56:31 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC22BEEE;
        Mon,  6 Mar 2023 04:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8ahmN8vdZHgt/A9v/x/81eTbRXob7cLyCIHoo3wV9c=;
 b=Hnvo5TJS6DwcJxOZjpCI/FYppZW2zcAAUSPDhaJ1XiZvH1ddc5L981ckKP4X57IfXvHFnjuRqYWQsFRDSXmtqAao2gzwTmBv55hlhulGwk0eIpr6eOakA0XaI1BpMunkl81qY4jdUeVdthWUiIIarKbRmSPBRxjjCSBuROsYCvZBHuMl2UaSxMbBMcOYE+l3XE36CfLirCqtbmLL3GebVlm/thnzGGCxsZcdfJP/+EbeFC9hXddG+pb1jdjuOQMWnueZiyqM6fM5P2L9VEvF6Mjy7SMguDEXo7uDYNjbuzjodWgue+mhApkUk+BSunxzBiA8jzLxasasZ76ONlcKGw==
Received: from DUZPR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::11) by PA4PR04MB7614.eurprd04.prod.outlook.com
 (2603:10a6:102:ea::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 12:56:22 +0000
Received: from DB5EUR01FT022.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:469:cafe::34) by DUZPR01CA0053.outlook.office365.com
 (2603:10a6:10:469::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 12:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT022.mail.protection.outlook.com (10.152.4.244) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 12:56:21 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.51) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 06 Mar 2023 12:56:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5Bn6aXwE71ekMalXiBA/dihJAg85EUmIWEt2lGY9X8cZ+8/7joJ/P/ldTzvm0/3jZ/y9HzZ85Xs1lXEjTZ95n7BiD17TrD9d6pvZa6p8cXOdHT9ZWsk5GsglY7XFqUD7qmv7/DSDY1I/OiDXD9nFz6W4TpaPVaYhh/5y0M6Gt1lU/RTwIOkht5wdj5Q/hpRhs2pN+GEaLcrVlQjwT/dWU6jA94Q79Pp5mN1rGb5pCtWscGzEIlWKKDqx6+Cr2v6QVQzUKKqhi5V3BcqYqAmuBoJFmE1KBPGy64HXL4VChemAytzpH26+a4BISCBaCU95GKX0IA3GK+ax9jyNnE6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYlBQ6ZzIw9a4J0F+Tuz619HL2thE61c9maqIme3xH4=;
 b=JXnJe+v62gWbiDKRiBXpyXTxCP1P80h8yCxElvDKH4YPJ5Y+V0czxkLfbbO96LHgeg4yjFeimDEPFQGhydu4S5AjdSBSSMNpTJLRmZVZkV/v6S4qKiHMQBJLf/3ytUUgEu6AToR23aIL/QBVNuIUWzcJvaWshF37hX++Vy4/eMv4OaCF1zME8i1FhWAPYwEqIhJ5OJoK9KIdLSpNVRmEH2z9nE3RZkMcJc2W7IJvd2kcxkEuZ1veCPqJw4qzJRGDWg8X3cCcitE2AFmuwnn9fsBSsdITD0yQJikQ1JnoAwEEnCdnGiXEjslipSP6792YX/XeSVk2V6MtPpD38FE9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 12:56:16 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 12:56:16 +0000
Message-ID: <abe9224f-9c4d-f8f5-ad7c-5d034bd1056d@topic.nl>
Date:   Mon, 6 Mar 2023 13:56:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
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
 <20230304175751.2daae308@jic23-huawei> <ZAXYhIETzMa/7G6N@smile.fi.intel.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.be34025c-a863-4735-b566-67fda50f37f8@emailsignatures365.codetwo.com>
Organization: Topic
In-Reply-To: <ZAXYhIETzMa/7G6N@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::15) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PA4PR04MB7502:EE_|DB5EUR01FT022:EE_|PA4PR04MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e80daba-db9e-4585-b834-08db1e422f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4PH31owKj+D9R0ZrNoNgizevC9P44d8dMgK7FWt69Gi0Jz/K+WIIk+pTBlpQEIel8wehZwXCr7j5MgcqsgpARoJf1xzMC94sGoDv3Vp2OKinsIK+RQ5tkfPKFFZ5z/lA/HLWWKoGNb4/pOKncAFew+vWAV+rFIQQKGvVYngOyQvqrLe73xtGYS0bGajIA6vQU1E5BcNuULdRYuezvB1GTLg4iGZc57EEylDcz3t3z0qxMT1ydguniusV3RGzzebHN3exgfMjdlhqjsWRxJhPX45/N5A8DLER4dgwUjdFONHddvePTlAmb7ynG/IkJQQoy72yIy68kGaFZpnnyWp/IdC9vfFCPwyVq6oJ0VMK+Uhz1WzC3NgLz61fVzF2mj0Rti15T3GT6QZpZW27amJibx5I+fsLPcRfjV23nDL2bf6+Vqka8Fzk4BRntk4NhPx25gA79/zRFSDCsHrkDoqupdzIAsHp74ONCGvvZfF7+fWBheXwDxI7ssv5mfoK8FwD2WkvQwPGZfY9sF8eG2bqyGF4/ctCv7dwEh48yA76UtGP3pNkMFv875ovfdr1bwsdwME07CQ2jwgEmAWFN21EXgTQsksaMwRsBYSsIaIRkKq+l3Bk4qoBC+SEma3gNFuMW72OHYHpewFXQqDUk3guceaNskMHXcAHXgNdZHWutOgagc3BpFnxEX/vFcyJPG9C1TCI1B+0xfzS7mcImnOCi7b2m7x6zZx7xur01I3NBrFlgw/vUS6NeVsDl5znNg47
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39840400004)(396003)(376002)(136003)(346002)(366004)(451199018)(8936002)(31686004)(7416002)(5660300002)(44832011)(66476007)(66946007)(66556008)(2906002)(8676002)(4326008)(54906003)(110136005)(316002)(478600001)(36916002)(52116002)(36756003)(6512007)(6506007)(6486002)(53546011)(26005)(2616005)(41300700001)(31696002)(83380400001)(83170400001)(42882007)(186003)(38350700002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7502
X-CodeTwo-MessageID: bfab8a98-f71b-42ce-a360-8ef12c285e0c.20230306125620@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT022.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 045f51e6-736b-4d0e-0186-08db1e422c80
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Rk1cBRlAUTglQFfoxYwDaBWXLtn4Hz6xnxip3FttM+1OrC8e+0X8l1j49QrRlhYlM3Q9dignYmKxl2abV0h4eRLGMYr+EwumlF6WzG5FRiGOnNXxYj6sFzxLYhD6BjxkTlBlMuI1uC4+23zaflyoZ72OH5SmrUs8C5hJcHGe+xEn+l82UFWNP9CVB5MEsM+EMVt8GN5tFtLoC2V6VvOrReX7AK1Q3GVXYXOyFQHbIO4mIT1uSDJCA+db1k8k/dUZgf3RY7i8/MBQ4U8VAnVtp8UN1dM7QS4jnfx2SEdW+kD72wBn73PvE+KA38evwBPw/9eicDcM6U+iXvaeg4KSaGElHfz6LWKsEdsJTicuZyHsvtHh2Ova826wy/5aASbkJCXJM9u4I/NBzFtN8b6UtgE8yP1+HP6w+ZXRt6PZff75PghPordmOxsC3K0d8IR81D4T3CT9MJBkRQOQMXVmevdXATiFu9Bbo88btvnAj2hq05RTixj3togDWrd9hFxOZ4lciW+aqUaxowXMJhHVS8Js658avGhcvqlpP+2Op/y6UxaS03nY0AHRVzKv8DhwJBhQYV1Rq1WqxdtYBhhx4MaMVn3i752U7+4UGdERglOVWGqlmum1okUw9NxBNao5oO+zni/vBPqQQFEz2wSHMt13PfFcx1t1ANhSXdMo+VHr5v+mHMwTKxrTwGLNSRz
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39840400004)(346002)(136003)(396003)(451199018)(36840700001)(46966006)(54906003)(110136005)(6486002)(42882007)(36756003)(316002)(83380400001)(40480700001)(15974865002)(31696002)(82310400005)(31686004)(336012)(186003)(2906002)(5660300002)(44832011)(70206006)(70586007)(8936002)(36860700001)(41300700001)(4326008)(8676002)(53546011)(478600001)(6512007)(47076005)(6506007)(26005)(2616005)(7416002)(36916002)(7596003)(83170400001)(356005)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 12:56:21.4605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e80daba-db9e-4585-b834-08db1e422f8b
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT022.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7614
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
On 06-03-2023 13:11, Andy Shevchenko wrote:
> On Sat, Mar 04, 2023 at 05:57:51PM +0000, Jonathan Cameron wrote:
>> On Tue, 28 Feb 2023 07:31:51 +0100
>> Mike Looijmans <mike.looijmans@topic.nl> wrote:
> ...
>
>>> +	for (i =3D 0; i < 4; i++) {
>>> +		if (BIT(i) =3D=3D gain) {
>>> +			ads1100_set_config_bits(data, ADS1100_PGA_MASK, i);
>>> +			return 0;
>>> +		}
>>> +	}
>> Andy's suggestion of something like..
>> 	if (!gain)
>> 		return -EINVAL;
>> 	i =3D ffs(gain);
>> 	if (i >=3D 4 || BIT(i) !=3D gain)
>> 		return -EINVAL;
>>
>> 	ads...
>>
>> Is perhaps nicer than the loop.
> Even better:
>
> 	if (!gain || !is_power_of_2(gain))
> 		return -EINVAL;
>
> 	i =3D ffs(gain);
> 	if (i >=3D 4)
> 		return -EINVAL;
>
I'd guess that "is_power_of_2" is about the same complexity as "ffs".

If we want smaller code, in retrospect, I'd vote for omitting that=20
power-of-two check altogether.

The IIO device reports this for a 3v3 Vdd:
# cat /sys/bus/iio/devices/iio\:device1/scale_available
0.100708007 0.050354003 0.025177001 0.012588500
# echo 0.012588500 > /sys/bus/iio/devices/iio:device1/scale

That last statement results in val2=3D12588 in this call.
The whole point of this exercise is that the value '0.012588'=20
corresponds to a gain of '8' here. There's already quite a bit of=20
rounding going on, since writing to the scale turns the value into=20
"micro" scale.

Also, looking at the "avail" table. the values for "7" and "8" are much=20
closer together than "3" and "4".

And the correct formula for the inverse of "gain =3D BIT(i);" is "i =3D=20
ffs(gain) - 1;" because ffs(1) =3D=3D 1

So I propose this code:

 =C2=A0=C2=A0=C2=A0 if (gain <=3D 0 || gain > 8)
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;

 =C2=A0=C2=A0 =C2=A0regval =3D ffs(gain) - 1;
 =C2=A0=C2=A0=C2=A0 ads1100_set_config_bits(data, ADS1100_PGA_MASK, regval)=
;


--=20
Mike Looijmans

