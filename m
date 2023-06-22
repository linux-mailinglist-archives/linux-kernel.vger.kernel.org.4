Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47A3739FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjFVLl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjFVLl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:41:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3B81FC1;
        Thu, 22 Jun 2023 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9draTj28MTfCxGvqCc0W8SMOx4WpoFTx/CJdqN2AXc=;
 b=jnvIHaRV1Ap9nNZ9WoKO/Gf2qq49AsjCq18JPtmueLr8rqDLelTKe9u6T3FbeLTliuEHzuKY8M1or/lXgJU77nIJ1O2SHENeMEfB2++OpvbZbf6UuYoKJozp8EaQbhpyOxabG2LLvzSpBWR5pmU88xdlGqQ2MqXcgzOljySc99Pt/7pOcN09COqgJfRBP87XBP+gs3BnS+xOihH2Vk3E4w38P7Iwojuww/QFJanIsLAAibjU16lKmLR9DacWH4ZeV5w97Bm90/OuchX8l1bd9uG+WO4E++/DthqWiZUqndtp8L2SXkTp0Pa6BODtrrdG8RUX86AFpj7ufcNdWVi2bQ==
Received: from AM6PR10CA0094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::35)
 by DB9PR04MB9916.eurprd04.prod.outlook.com (2603:10a6:10:4ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 11:41:18 +0000
Received: from VE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8c:cafe::ee) by AM6PR10CA0094.outlook.office365.com
 (2603:10a6:209:8c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 11:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 VE1EUR01FT015.mail.protection.outlook.com (10.152.2.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24 via Frontend Transport; Thu, 22 Jun 2023 11:41:17 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (104.47.11.105) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 22 Jun 2023 11:41:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oza4+stRJ1msxJRRXm4XKYONffyRCaoTyx6eVkHWNG+Y+zWZKUy6MAtE8d5922yVPoE4SFLYjqF6FrWZTmKKxGCsMshn0CcPv0989VDxKiX7CAMeq7oneaRBVr7OW0+eC1VR1sfmP1r87GlOi+kFZoe2Qc0/YTL6qV7irHASl+WsTXDJb6jHU37e9l3yMJBvgO0Kwn6VPk7iwtQpB3NC4fBlWGLH+5FuwfcORALG5SLNxGu9QrAVNJ9WFzSACGCVQlobpWiqjGDjx6SzOHxy5HHZFBFdIezl5DRit4h/vAjifZAReJf6iJiK9HBG5LZPUcXX53Wsg3MScze2JWxR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6NZG1mVBAN04eBgTuw8324h8Z8VK7gZwfpR3jSyjhw=;
 b=C2rglMgGCV6knXmpM5zH+sc+U/tHw8SRxEr6fy88+bp4Mh+Q85GbzPgJBCTScRFGG19f+w1gBMGVuph0w8DI+fCkIwpSbWxb9W7x58XeYLjUHChVmnxBlWa+Wwq4W5WvvGzKeBa+d30lF6xZs6ar7jhgCHOMc/jix3KUdszq+JUGIiqJZ+sDVu+LnWR0Clw9Iw4VdQpsMGzhRNDFX7CuU1vyHPoAJx9EgWx5aYrhh/yIshBk/ky2jDZDr8f0z8e0gTHxfds9pZ1FbBoGOzh4MVYi020e1eyBBibwfzAfvTFzmqDw8/hs8rTj8HAgBS318XuvZuiB6pw94ooHg1b1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6NZG1mVBAN04eBgTuw8324h8Z8VK7gZwfpR3jSyjhw=;
 b=osGy63siUAjsmYQZZ5U1t8i7JI/qvRgHxrkNBC67QI0lgjKr7zvXYw6sskwkQmiRCUpfkPu05B7d0qtxmwWaJovxhWJKWBf3mmNOH8v3/ebcH81Wm/q9JprN2XInAvdJM4yAO1JFroQ7PAEW45Obg0L9utyHOM4XCy9yLce+ohwUF6y6e7r/l6Mo7beAz8Js4Aoa2x0RvSvLdoQw+3h0ZwnHcGkxZwG9v4s8cbWAEVwU6T1nqtkxXzeDuekZsg+Pnf/G6nG9kpJGcigqf7I2HbVbZqakUP81VAPhmkYY9IC/7mmYIHScUnYKba7v+xRdZ5S1jzN9p42vSHXktWkMKg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PAXPR04MB8391.eurprd04.prod.outlook.com (2603:10a6:102:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 22 Jun
 2023 11:41:12 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 11:41:12 +0000
Message-ID: <1e87be02-4bea-0b84-a0ee-457c56d4cfd9@topic.nl>
Date:   Thu, 22 Jun 2023 13:41:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: fixed-clock: Add nvmem support
Content-Language: nl, en-US
To:     Rob Herring <robh@kernel.org>
CC:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2d27bfea-4746-444c-89f4-e5d35cb7de66@emailsignatures365.codetwo.com>
 <20230605140149.16841-1-mike.looijmans@topic.nl>
 <20230607224155.GA107156-robh@kernel.org>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
In-Reply-To: <20230607224155.GA107156-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0035.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::11) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PAXPR04MB8391:EE_|VE1EUR01FT015:EE_|DB9PR04MB9916:EE_
X-MS-Office365-Filtering-Correlation-Id: cdde140a-06ae-4175-3d59-08db7315976f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tLrgJy0cD6JYmZ5W569pzIhlcA3g2+77pwiUkwlAB13nSCF3y5TD3pAPo6WjjIAgYq1z7HFzK4bzjpPoNNX+aixbXOci47lsFeH7f59p6XOaojIi4gfXI5xnShp1GGCz3SFaCGnQGa+z0+t/ACXcU0UAjG52UsmI41/ssjOQKM8zE8ofpjBHmP9xjaP1w5jaKpGtcimyzMWpmnoCpQOffjQNWd6bY1AM0pt+1Udbczy2L/T+asOuDYPbXEq39gXPJKYew/7YsD9inqfnnC8DpNEYQc/Gpe/EzyRHjAExTmnKv2ASgdA6WC5kq6mvNsdmmW2PUanmGYavMhMghDaJmBa7zq+7MslxlJ2dv8FMqhPuJ4qiEVwdPkcINOstEAwYLlGvha1GzSxFPgtPLQ1gwdxPrz4d9MD9D3V8QO1TSvHfTn/gT+7A26WoToaK8rkz2wfK0e06hv3sewZzKdAJrhyOzlnt0Hfk6fj+wphHYxozm4KiZHfS9B8O78sZn/2YRw1BPBab0psTzzqcUJ0LEDvRBp72I99eCd5ehXzNAtK7V3TNj0vbxx+ZS37qBE5Vkxr7qWmb8QlxBN1X4Bo7pEjKkaQbzU9f9PTSWb4+4mwKzQMqvKKi6z1BSZ/Y8qs9ad1MRFT6wWg3kO2TGNfzpg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39840400004)(136003)(366004)(451199021)(41300700001)(66476007)(44832011)(66946007)(66556008)(2906002)(6916009)(4326008)(316002)(54906003)(8676002)(31686004)(5660300002)(8936002)(478600001)(36916002)(6486002)(83170400001)(42882007)(26005)(53546011)(6506007)(6512007)(186003)(2616005)(83380400001)(15974865002)(36756003)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8391
X-CodeTwo-MessageID: ca42bccf-16cd-4a5c-ba1c-7a5ae2e025fd.20230622114116@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a4f2f3d6-3056-402e-e5a7-08db73159465
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AN+JIEsK9d0p/qgkhRNwJvAP8NyBRmT9zg/BMBjFoU5fiWBOyczD8uagcMuTRk2ngGS4T+tc7qAgvPpuvPuFT2TbUi4qy1ago/xHHKQosgzq/p8n8DhDGv8geeTzERPERGAenVSB3tnCGnotOyW7itjT9G9Bt0jQeAT0GJXYKY6STxMws7NsuCZ/ZxlJxVBNRjSe/INebJBJov2Yyl2hnBYIHrOB56TrQ0TWju0ObGW48h20d2UbCfD34jY6I56CuHhnLqFKGrS+Y6gqAlguR4sPNYZ1kdIwjLfgn6tyvlTFXL25NX0kpqyFghKvoG5ZoCg0po4bRd0XDGRy+zlQ0Du+HCWdzYaASreZYfRjgUAmjs/5MXoi6a6qVlkfQQFWYWkI45yYLL/j7inXHZHBA0rkmMvl2LOMlOVKN14G7YpflllVHEvF//5yVg5ZJVjh4p0/zr3Tk/yDBF6s8/z2N1odsQPkhHWOSZccQPGsXBQp77hjCbdwdg/rZWJNpbjcyIhP5qigzSr0NeHIwRy9rt5hV16KUytOL6WWv47yPL+w7S+psobbPWcXxVGhQPjKXlkNmwp8PSMhWwEzntr2KB49kIyxdHRqZ1V0sPp+thkWRBdFcwBVjTulbjCWc7g8H8yCwrxtceQE2uhwLdj9YM0ivpcbRLs8DhbBiXL+GzandISYEtaBGZrdNhMQ40rpdEhMOGZtDPMIaWDh33YmaAfag1lt+z6qrDco6QnjD0BKVEPzsPtv+8vdWaJLXDFBJCXIfJBkhrA2Bt5/qgHqPA==
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(396003)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(336012)(2616005)(47076005)(36860700001)(83380400001)(6506007)(186003)(53546011)(42882007)(6512007)(26005)(36916002)(356005)(7636003)(83170400001)(7596003)(6486002)(54906003)(478600001)(31686004)(36756003)(31696002)(15974865002)(70206006)(70586007)(8676002)(8936002)(40480700001)(4326008)(316002)(6916009)(2906002)(5660300002)(41300700001)(44832011)(82310400005)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 11:41:17.3339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdde140a-06ae-4175-3d59-08db7315976f
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9916
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-06-2023 00:41, Rob Herring wrote:
> On Mon, Jun 05, 2023 at 04:01:48PM +0200, Mike Looijmans wrote:
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
>> Changes in v4:
>> Use proper "if" block and add example dts
>>
>> Changes in v3:
>> Modify fixed-clock instead of introducing nvmem-clock
>>
>> Changes in v2:
>> Changed "fixed-clock" into "nvmem-clock" in dts example
>> Add minItems:1 to nvmem-cell-names
>>
>>   .../bindings/clock/fixed-clock.yaml           | 42 ++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/=
Documentation/devicetree/bindings/clock/fixed-clock.yaml
>> index b0a4fb8256e2..71a5791da438 100644
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
>>  =20
>>     "#clock-cells":
>>       const: 0
>> @@ -26,11 +28,41 @@ properties:
>>     clock-output-names:
>>       maxItems: 1
>>  =20
>> +  nvmem-cells:
>> +    minItems: 1
>> +    maxItems: 2
>> +    description:
>> +      Reads clock-frequency and/or clock-accuracy from an NVMEM provide=
r in
>> +      binary native integer format. The size of the NVMEM cell can be 1=
, 2, 4
>> +      or 8 bytes. If the contents of the nvmem are all zeroes or all 0x=
ff, the
>> +      value reverts to the one given in the property.
>> +
>> +  nvmem-cell-names:
>> +    minItems: 1
>> +    items:
>> +      - const: clock-frequency
>> +      - const: clock-accuracy
>> +
>>   required:
>>     - compatible
>>     - "#clock-cells"
>>     - clock-frequency
>>  =20
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: fixed-clock-nvmem
>> +    then:
>> +      required:
>> +        - nvmem-cells
>> +        - nvmem-cell-names
>> +    else:
>> +      properties:
>> +        nvmem-cells: false
>> +        nvmem-cell-names: false
>> +
>>   additionalProperties: false
>>  =20
>>   examples:
>> @@ -41,4 +73,12 @@ examples:
>>         clock-frequency =3D <1000000000>;
>>         clock-accuracy =3D <100>;
>>       };
>> +  - |
>> +    clock {
>> +      compatible =3D "fixed-clock-nvmem";
>> +      #clock-cells =3D <0>;
>> +      clock-frequency =3D <48000000>;
>=20
> If the freq comes from nvmem, why is this needed?

Not needed, but it's a nice default in case the NVMEM is still 'blank'. Wit=
h a=20
separate schema (see next comment), something like "clock-frequency-default=
"=20
would be more appropriate.

> I think this should probably be a separate schema file as the only
> other thing shared is #clock-cells.

Yep, I implemented it this way as suggested by Krysztof.

I don't care much either way, I'll send a v5 with a separate yaml file, if=
=20
Krysztof agrees.


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl


