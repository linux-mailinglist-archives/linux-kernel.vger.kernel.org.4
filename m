Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D866AC3B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjCFOql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCFOqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:46:30 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB52A9BF;
        Mon,  6 Mar 2023 06:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bilTqpBJVi1t5QdFSDsTEGwGPT70rh/dBW2449Ga8Uo=;
 b=t8PpGU1MBWaZIFT52fEFf3LCgrVzN9XqouOuogQzj7CnjKiLXA5JwVyAyTBGk6pqFrwqomEVRrRkZIY30zVhAUQG3XwAvyyi1HSNYMIf6aUCfh1n7wAQHaGueWx5O/pwx7CUUD1Np2wWXitKUe4J+mLM4mh6xDWt9rpwgnZmG2PO8tkSi3oWUidUloCdXdSfFXXk3hG/mEKWF8RzyaD4f2uumhORtGOTkJr1dxgkNCx9YfCod2lJRhppBC3k7Tk4QW17uuXUOrqeQqJbHkZWgo3jUxtxtlW42PJYVJt2WHjoZxTSRZY3Tyy7ZA2DaUKt7W1D35jsmw3+EuBRkAprhg==
Received: from FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a2::8) by
 AS8PR04MB8417.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 14:44:28 +0000
Received: from VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a2:cafe::7b) by FR3P281CA0158.outlook.office365.com
 (2603:10a6:d10:a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.14 via Frontend
 Transport; Mon, 6 Mar 2023 14:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT018.mail.protection.outlook.com (10.152.2.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Mon, 6 Mar 2023 14:44:27 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (104.47.11.235) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 06 Mar 2023 14:44:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXmFNojG5W/4WFojfZnpyQZhSid5Y/l+vobSJcZgIwkS9zKLkTeCcVZvdM97FUaXfpZPedRtIp5crG40hsQKy+hYHQWzP5RdMyzYQq6RWZEfgacdNmOKv1MHU0wj4wCW1d0wlEyzGRfaKYBWiTCCdcQaDEGIc0iMshCjAlkMJ9/4SomDgXwcQ0M2zqpWox1lAcU8KNKUCzipdFb0Sb/E7RnGXH2sN6+MzgF/iiJTfDG4kSpp91MZyBrBaV4v77FCglnCDKJrSV7zH0IStM3s0ST4IoscmxZS0peOxzUaRQD5R1OEZEIPCU2OOJU7vrYLsoRGzRGcC2Cyjd/8isiDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lbbXM/RyaZ2HbKIo5NlOhGknlUaoiReuaIZ4RFtyxs=;
 b=lyt0NtdSx8GP2DX8V9pNjqOtTTkFYjaquunm4tjG+2W9uwjcYtrlz6OidSKsd7QYPZfAT03UbE82in+9CsMqkPKAchCcZGajhGGIVzApI0mZms8q87usJxCuMVTQDn+uh4/sJ/awS12LK6b3dePtehs3xbC9wDmMsAsaYNESSMKa9d51RqwSpj75DAJhGcj03AhTQeKEIc0o46/tzsiNVxOhLHa+1MosewsvwSWvpT+9tazfl+KqCZHH7/+kD8MHEA4MWc9aCgrKm12pem+7SuOvDXQmZUVBqIETC8n2tZKwflD6bcQFmfPl11veiqmAFp/XU6Ag8bOVXFyJC4xGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DU2PR04MB9083.eurprd04.prod.outlook.com (2603:10a6:10:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 14:44:24 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 14:44:24 +0000
Message-ID: <8a1dc110-97fe-a9c8-ce53-918f403a16eb@topic.nl>
Date:   Mon, 6 Mar 2023 15:44:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v4 2/2] iio: adc: Add TI ADS1100 and ADS1000
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230306131312.7170-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0270109b-145d-4024-b8ff-05d54be2ad97@emailsignatures365.codetwo.com>
 <20230306131312.7170-2-mike.looijmans@topic.nl>
 <ZAXqwaKA3Uh6TH2q@smile.fi.intel.com>
Organization: Topic
In-Reply-To: <ZAXqwaKA3Uh6TH2q@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::18) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|DU2PR04MB9083:EE_|VE1EUR01FT018:EE_|AS8PR04MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: a4209f3d-a76e-49d0-687f-08db1e514997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LsYqB8QixPrby658m9bCU44rYayFgDHfQ/Y+Lcrz8/V580V0/b/gS0z0vAOR0LlmZdK7iIkza4uTiVXbX9KP0WUi2q8GURls86VHN80jfeP9Qk9cZxMBk0dRKuSMWTEoA5DA3VPn6FZZpGimBBkLu0pUePkmY8cEFFWKPOhz/uDpg7dlpTy9Udkh2DLDmuKrChUFfge27QYzDh1wxxk1IuECzKuN5kdXI8fYrUlL1PBC/vNpzuTBjUkHmjuvuDOiFunlxCa48XGhCiYKnnISmrE//1JhyTD2C6N3VdWOWpyzi9mEkAsBNVt/78+lnUX8Aun2BzTxSc34pOyPKO/aqv/Ax3j9fNhPfeL31oTEKoP7KzSPuxVzGMs/FdFFh0X8RHEMrfZFfbBBbsdEwaarxAQH1oJrveob1taUphXh9UZm1g9UDrIOK2IKI0/NZiul0ZgLbmosaXQ/rcGrMSmmxnds5jm/0MA8PBm/5jXdKDF+/fJcs+X0J69p7Vmvyg0xsvbnZO604M7jFwZcSu5WEbnHUA9JFD8XRi9YX1V6GU3VBlh9w5l/bQGwdOjQ/Qqs4mkfdBQE1eZFpAjYKV/l9Kq2mC4Dt+qR5CNpqgnSx6PhvQWmsvGS17bj1gtOMWrXK82kXmEH/S2zDyxKCYG4WXnxOiFLe64IrLVPqnvO7aXDrc1ZRTqkEfNotaqYa3NJ+7nPZ5dZkm9OL01lHNRjVKerPp01mlcOg73xmN9cy2FbBcvCXKZ+9LkqXQt31DHroDplCVafHfSGAgLeHh3wmw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39840400004)(396003)(136003)(376002)(366004)(451199018)(6506007)(6512007)(53546011)(6486002)(36756003)(42882007)(83170400001)(83380400001)(31696002)(38100700002)(38350700002)(186003)(2616005)(26005)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(6916009)(2906002)(31686004)(8936002)(44832011)(5660300002)(7416002)(478600001)(36916002)(52116002)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9083
X-CodeTwo-MessageID: c2f39107-ca57-4038-a9a8-04c4f3c3db72.20230306144426@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 174d2742-89be-41bc-462d-08db1e51476c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0YjS182ERUTUa7KarCEBNOuXbu/ksraFPGAO0hJutz9p4lnV/kMfMsKZ3kU5oNidgf5o2U47LghUTd2TSUs3sT2yrz+PEmA7PvDIwSu4GCP+Sf2bmrHAEkhGis9iT4IHfTADI14IkLScprSwPJpYi+GgZCdvigZ/uelFCG4W/lJrGCxPBCba4eu3tYcL4FKb63A1NWIWRQjIi1GQOBNm6ci5IyTKboG6b/aLEqsJBXtvGmBY3rAdG83LoLTxpdukbQSA/u0FuI9EiSbKjBMQ87pW52nkY0EhJgfm1yHMvT5bk6dGVC9O9CuEyLH/Ti1WH9cfD/7oSUyW1d9ysjZMCwA2XyAEh2JQmkGrlw5+Y0WMYOL28LRWPGEPT44aU/IxEdL6YU0TzqKtxV9LkquMRaD9i5GPHZLgAeMKaUY6zrdWb2LEgb7Ce04EQSVazWSgOyFixDb29ZESDAYZ7phCA/XbGpUmJnUEaBOVDfwQ++zghliSk+L+hTr8wIfVUfwMC09UoiXZxBgluQFy+yr25r/f2yXPYpZUnk4FNlvJBNAE1Soo/HsJt7g/qo1Req7DCPppoLBbGmP7x+IasVXggN1xqI4QytLnaQ+oq2hkvQ6W6Z5SLOjaBB7axRIpkINEbtlZ5yN4SBaVaBZqz7lwwPUSIevW/Bim+mXIjfO8QfHrvE9ba/ZnzZNZvC6Pqhw
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(39840400004)(136003)(376002)(396003)(346002)(451199018)(36840700001)(46966006)(26005)(6506007)(6512007)(53546011)(6486002)(36756003)(36860700001)(47076005)(82310400005)(83170400001)(356005)(15974865002)(83380400001)(31696002)(7596003)(7636003)(40480700001)(42882007)(186003)(2616005)(336012)(70206006)(70586007)(41300700001)(6916009)(8676002)(4326008)(2906002)(44832011)(31686004)(8936002)(7416002)(5660300002)(478600001)(36916002)(316002)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 14:44:27.5775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4209f3d-a76e-49d0-687f-08db1e514997
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8417
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
On 06-03-2023 14:29, Andy Shevchenko wrote:
> On Mon, Mar 06, 2023 at 02:13:12PM +0100, Mike Looijmans wrote:
>> The ADS1100 is a 16-bit ADC (at 8 samples per second).
>> The ADS1000 is similar, but has a fixed data rate.
> ...
>
>> +	microvolts =3D regulator_get_voltage(data->reg_vdd);
>> +	/*
>> +	 * val2 is in 'micro' units, n =3D val2 / 1000000
>> +	 * result must be millivolts, d =3D microvolts / 1000
>> +	 * the full-scale value is d/n, corresponds to 2^15,
>> +	 * hence the gain =3D (d / n) >> 15, factoring out the 1000 and moving=
 the
>> +	 * bitshift so everything fits in 32-bits yields this formula.
>> +	 */
>> +	gain =3D ((microvolts + BIT(14)) >> 15) * 1000 / val2;
> Perhaps adding MICROVOLT_PER_MILLIVOLT (to units.h) and use it here?

Would that require a separate patch?

I fear that would get feedback like "why not MICROCOULOB_PER_MILLICOULOMB".

If I fill in the equation then that "1000" is actually=20
MICROVOLT_PER_MICROVOLT_PER_MILLIVOLT, which would evaluate to simply=20
"MILLIVOLT".


>
> Besides that it's seems like
>
> 	microvolts =3D regulator_get_voltage(data->reg_vdd);
> 	gain =3D DIV_ROUNDUP_CLOSEST(microvolts, BIT(15)) *
> 	       MICROVOLT_PER_MILLIVOLT / val2;

Yeah, the DIV_ROUNDUP_CLOSEST is more readable.


>> +	if (gain <=3D 0 || gain > 8)
>> +		return -EINVAL;
> As I commented out in the previous discussion (please, give a chance to t=
he
> reviewers to answer before issuing a new version of the series) this bett=
er
> to be
>
> 	if (gain < BIT(0) || gain > BIT(3))
>
> which will show the nature of power of two implicitly.
>
>> +	regval =3D ffs(gain) - 1;
>> +	ads1100_set_config_bits(data, ADS1100_PGA_MASK, regval);
> Can be unified in one line.

Combining it all, I'd arrive at this code:

 =C2=A0=C2=A0=C2=A0 gain =3D DIV_ROUNDUP_CLOSEST(microvolts, BIT(15)) * MIL=
LI / val2;
 =C2=A0=C2=A0 =C2=A0if (gain < BIT(0) || gain > BIT(3))
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;

 =C2=A0=C2=A0 =C2=A0ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gai=
n) - 1);


>> +	return 0;
>> +}
> ...
>
>> +			return ads1100_set_config_bits(
>> +					data, ADS1100_DR_MASK,
>> +					FIELD_PREP(ADS1100_DR_MASK, i));
> Wrong indentation.
> Please, check all your code for this kind of issues.
>
I always run it through checkpatch.pl but that didn't report on this=20
indentation.

A bit of digging in the scripts directory yields "Lindent". Feeding my=20
file to that indeed changes those lines (and some others too). I'll run=20
my next patch through that.

--=20
Mike Looijmans

