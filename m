Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA79672280A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjFEOAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjFEOA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:00:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A179C;
        Mon,  5 Jun 2023 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBez5Uy5DWoPCxP9y4Hr85uL78tonqtZFZUmaFwmuuw=;
 b=YjdvCFyrEhws0pKi8kjucJ6++NQgFdWuHmgB1hWelHgzkWo6ISwdVrRRZSLOLHy/XdzEVQmPFrEh2HApessShyYwPodZicY9V/hU+8YEPzlQYNcfUtUvyCm+DNbP4MLksjR2ndGjen3LM1xMhDoz6afhho2827W/9nKGwJsNnsFwoIko0YEftOgSidgGpx5wxtLUM86tRWMaHoIzFuMAZz6GH9DTAmSnnszcx5ZnOR4RJgWmNU2qOtc7GemI8JeweDi1dosGw76WM6J3y8pJ+aWbPHZdtJuez3ce6MzXbu00ePu0+S2QwwjMmVDVpXXzI1KD3tAmx3C7cVu8dIiXiQ==
Received: from AM5P194CA0012.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::22)
 by DB8PR04MB7017.eurprd04.prod.outlook.com (2603:10a6:10:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Mon, 5 Jun
 2023 14:00:24 +0000
Received: from VE1EUR01FT082.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:8f:cafe::e2) by AM5P194CA0012.outlook.office365.com
 (2603:10a6:203:8f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 14:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT082.mail.protection.outlook.com (10.152.3.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.19 via Frontend Transport; Mon, 5 Jun 2023 14:00:24 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.239) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 05 Jun 2023 14:00:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQBMHHxUol50oCpzm6C1Qbl/+FUTbIiA6y6J/L5yiiDj8x1XZ5aKJ5ooPpgP1+CGkjvbQfkGmOtAqfCSnTYO8muUro8qZYB3dWrcTNT0fNpEaO5fkz7q8Ixz04McFfElRv5nCcvBoalgdeHKkC0+YqC6WhabguJmwkaVl35I25rHgTUcEZrcedGjN0c5YLbqQvIGZnP2Y6+vB0Cm0DWsjtt9KxqEnReg/YzjvOxWFT8JbgRxIvctbsuVmVC4UPXvIh3gtdQjGS1rXsT+Je8i6wA/pSb/ZLkPea3w7BJ897G/dIW7wH4IRvZUT12F9xbRkO+yHx/lX3jaM58QevBwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6E3B9K6la7BJadEYu29JuKU+wZVVrax4SFJ7R34q5Y=;
 b=PAL89UH7na9raW/Jlilb+UGli6LuQvOB4zmX2a3WHDWnjr0daqczzkIMmNj0/VDY3jW1wQW5KHnKHI6AGhShuAltktp0kKJ4HDBp7i8VFpEDR0Ro6uhNjAW8DeduR2JUGNAprVUJx0D1ACcaKuOemPJJjkz/dFuRraaqlatnSESwJSsEzLn1xUtpkdTvHm4kqIHTs5QFQVqNSG32UPRQ6ufJRWyxuzwScUx4SOBjuGLRu7D9SRKDKkjI94jXBPeHxe5iZTkyTSlQNBKTt/CJwY+W22jqvMNXtCkTLzj/MniDRheSh5ojw+GX6+oTh2HoIMNY9W7UBOp1/AJZbo9FYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6E3B9K6la7BJadEYu29JuKU+wZVVrax4SFJ7R34q5Y=;
 b=zdA4R27n5P6H3m+RUSp0gUtD7Ang1j8gw2ALS52sGqkoJfP7LzwoD311FXkVF8Wdr9T61UXk9EnQzS4Xft/TG0kesOC4hWyiZmGDHFfnhrR9Od+b5W1Mlva2+XMLorfQ1633RiZvUYWftScThRAAMFlxF7+2auOm8Tv/27qRFEyPclpp05ijs8IJwbZX2ZS9SjT9g7nGnLecYGt1n8pYs7BF0H2cqfuBnutJ+suwn/O6iZNv8/dBbyOUIPutvKCZcFb7KsXZokezzTmK79NnqnY83zJHPzF9JCCDW8wzX0rsnuUG7vKlhF0sk703laiG08fmD8ePy+oltClMJqSBSA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM9PR04MB8193.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 14:00:18 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 14:00:17 +0000
Message-ID: <96004048-0ba5-4cd6-406f-e1235c819c97@topic.nl>
Date:   Mon, 5 Jun 2023 16:00:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: fixed-clock: Add nvmem support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.1d0217a8-661f-4359-b77b-02222c761b01@emailsignatures365.codetwo.com>
 <20230605133410.15076-1-mike.looijmans@topic.nl>
 <5d1f08f1-792b-255b-89f0-dd5fa2f0baa4@linaro.org>
Organization: Topic
In-Reply-To: <5d1f08f1-792b-255b-89f0-dd5fa2f0baa4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0144.eurprd04.prod.outlook.com
 (2603:10a6:208:55::49) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM9PR04MB8193:EE_|VE1EUR01FT082:EE_|DB8PR04MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b1740f-78a4-484d-36ec-08db65cd3582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: TWok8VDb3TaZt3jk6c+Mk+Y8OgjV1O1OypEsN4zyXeX0NZt8BFlYN1y1ZrjG9lvs7i52EbTpypX2UbczKr0AwO0AUHTefbN/ZfdlwjztjU1XXd5sDKGxu0mir4ArrRSlzvtrrmQ2Xzp6i/2ACJzfj4MF5puQKiAa+rZOOYoVwjt76erNMHSQX9z8bQtvrgSWO+vhdCVOJmi4Xf3/+wMxOKtkFAv4U3n1A3qxu7sIDsA+FkWL/c3NM/G/T9dwttoHxhI4MBrh2OvSoft7u/HT1rrZFFpp2n2OSKtJASR0w43oz+SIZd8DgFzrJlqDgQNzpkAozEu1hJmGAF4VG0tq/97GLS9UufIqLgEP0HPeNW3+QMNjaKNYMUxJo3XsrNomBl9IjzdYC/NvgDnthp0A+KrmAFxsfc/mwpZFv/Paq52dTm1C6Z/YKADN6ytXYzEnyPwDNBO1X5C0yWaYyal4nwgQ83DbQ3Rs4z0S1RHRpKqkOdbA9zUFaEmTRTRoSeZJ+bg9t/E0DKUcwoz2d7xD1nzKSlp0MezzEoni51qVLz1zcxHLAF7FZJKZIzI9XaHYp9j4S0prWNcqsTMISXbRz67NCaqJzJ8QLp93J14XBIATkKrA+FwhV+fUMLwlaSJLyxcL6kpPU2ugD+BIql8EFaQ6xgjnki1DR/TWjo5VJuw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39840400004)(346002)(451199021)(83380400001)(15974865002)(42882007)(83170400001)(44832011)(54906003)(478600001)(8676002)(8936002)(41300700001)(316002)(66476007)(66946007)(66556008)(31696002)(5660300002)(38100700002)(38350700002)(4326008)(6486002)(36756003)(52116002)(36916002)(2906002)(6512007)(186003)(6506007)(26005)(53546011)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8193
X-CodeTwo-MessageID: fdfeb8f2-69a4-4825-9aca-b7ce6a7825e1.20230605140023@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT082.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b1bb85eb-b81b-4547-47dc-08db65cd318f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdb9wMNYIBnKbale7z9ijcDkRJp/LhalLYSGPhtLKddkEOvmsuZlPl+fZjwX6HJdBs+X6vLbMAh9XlFJG3qeTKb76LFJqjSsn/PzOHpuH0//yTdl7vQ66y5rHQHtVQA/waRjHdUYRToE6oDBjXzQD7EC/AC8+YBmX59i/3bDwNnjAjFYcQpEpTROnOrpZjryXKxVko/WQcq0yct8zSfJR4o8uS7PXYuEn1/NJ8EuGdkak1eh3swXVc5vaOjWBkTbHMJ9pQmAfL+dxvxlmRsCnitU7GV3OQNJ4wXGNljmYt7Uwuod/XZT6YoJw1eLnycmkmaICDjhZ72zNXvxpG1d0/nv9jNHjVtokvjrfqK5uNnn76rkzjTYTR6AKl6LxMieukrD2PFWwyUPjJQe8YjFK8MmcB+G5NCNfX0uJba49tSESdN77MacCKq3UIgq1zoUXbHNs3pLaF4zQ/1GP/oe06gPgka6T2wYHOGmVPJIZiOV2qc/oUGt6dVXw5uQdUVL6abBL7gNg03sNk0uGoCvVQAwRfPEd7nE2GJ+LGYMm1iPM0Bs6qZnU6KT0ei/tAGtzHwuAjRFp7Zo9Vq/jSq82sMOEkLB1wy7Vjqg1PJCgB6/dggVCNyuXLISSO2O4DwiiXklXFv6EXD52L2ac+L3UxhAga1JHlKup9+ETW8lIDOwh/gnnrMqCxTIoA3Nxt21bYowaTTrcuhTIFekPYb8AOTCU3p1qLRlJHpGeUU66L0WDrCUWSwUtS0M5BC1eO/IKtydFnhw5oU++PVB+D8QwQ==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(136003)(396003)(376002)(346002)(451199021)(36840700001)(46966006)(8936002)(8676002)(478600001)(54906003)(83170400001)(7636003)(7596003)(356005)(36916002)(316002)(5660300002)(6486002)(41300700001)(186003)(26005)(53546011)(42882007)(44832011)(31686004)(70206006)(4326008)(6506007)(70586007)(6512007)(83380400001)(15974865002)(336012)(2906002)(36756003)(2616005)(47076005)(31696002)(36860700001)(40480700001)(82310400005)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 14:00:24.1140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b1740f-78a4-484d-36ec-08db65cd3582
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT082.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7017
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-2023 15:38, Krzysztof Kozlowski wrote:
> On 05/06/2023 15:34, Mike Looijmans wrote:
>> Add bindings for a fixed-rate clock that retrieves its rate from an
>> NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
>> or similar device.
>>
>> Component shortages lead to boards being shipped with different clock
>> crystals, based on what was available at the time. The clock frequency
>> was written to EEPROM at production time. Systems can adapt to a wide
>> range of input frequencies using the clock framework, but this required
>> us to patch the devicetree at runtime or use some custom driver. This
>> provides a more generic solution.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>> Changes in v3:
>> Modify fixed-clock instead of introducing nvmem-clock
>>
>> Changes in v2:
>> Changed "fixed-clock" into "nvmem-clock" in dts example
>> Add minItems:1 to nvmem-cell-names
>>
>>   .../bindings/clock/fixed-clock.yaml           | 25 ++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/=
Documentation/devicetree/bindings/clock/fixed-clock.yaml
>> index b0a4fb8256e2..23e4df96d3b0 100644
>> --- a/Documentation/devicetree/bindings/clock/fixed-clock.yaml
>> +++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
>> @@ -12,7 +12,9 @@ maintainers:
>>  =20
>>   properties:
>>     compatible:
>> -    const: fixed-clock
>> +    enum:
>> +      - fixed-clock
>> +      - fixed-clock-nvmem
> Do you even need new compatible? Isn't this the same clock from the
> hardware point of view?

I need a new compatible because a "fixed-clock" only loads at init time.=20
It registers using CLK_OF_DECLARE, which requires the clock to register=20
early. NVMEM providers are typical devices like I2C EEPROMs that won't=20
be available at that point, hence I needed to create a clock that=20
registers as a regular clock driver and can handle deferral and similar.


>
>>     "#clock-cells":
>>       const: 0
>> @@ -33,6 +35,27 @@ required:
>>  =20
>>   additionalProperties: false
>>  =20
> Put it under allOf. Entire block should be before additionalProperties
> (just like in example-schema).
>
>> +if:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: fixed-clock-nvmem
>> +
>> +then:
>> +  properties:
>> +    nvmem-cells:
>> +      maxItems: 2
> Anyway, I don't think you tested it. Provide a DTS user of this. I don't
> think it works and such user would point to mistakes.
>
> Properties should be defined in top-level properties:, not in
> allOf:if:then. In allOf:if:then you only narrow them.

Ah, got it. Added an example dts block to the document, this revealed=20
the issues, indeed didn't test the bindings.

Fixed it into an "allOf" to properly narrow the properties.

I'll test and post a v4 in a jiffie.

>
>> +      description:
>> +        Reads clock-frequency and/or clock-accuracy from an NVMEM provi=
der in
>> +        binary native integer format. The size of the NVMEM cell can be=
 1, 2, 4
>> +        or 8 bytes. If the contents of the nvmem are all zeroes or all =
0xff, the
>> +        value reverts to the one given in the property.
>> +
> Best regards,
> Krzysztof
>

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



