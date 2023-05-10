Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ED46FE117
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbjEJPEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjEJPEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:04:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C221B1;
        Wed, 10 May 2023 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OA17IWIFruik6KYN7bczpkJgH3LdC++KOSz5ZVJJ2E=;
 b=T2cY+Zbgj45vK4VWxJj8fgxJGrbnJ3udYL8Rv04sdj1xcvoNWsQjGCz2DMp7djYdlV3mXUvJfGgRS/wfHibkgXWJYoJQHFK8wXJH70mYOoSJODrKCjuyPmhCQdWY36oc7Yt3odGmEwDhFA1UdsJnXVTVTACV4thPAHcZ+k8ci7AJ1C/2+DSAaYqPdbg0zyqu/u84YNYnkN3TZQo1kDFLzUqfRQ2G+RCRlHDgCrAq3b438dWElzssxoHWKoP2OrrffvxPEFiWl5jXiF/3SNjpVPiYlh+9mlzhmFqwVF5lsmmR0r3ljj1STA+1NK/t/zryChhmqFrMmvJwcv3udSEkTA==
Received: from OL1P279CA0010.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::15)
 by PAWPR04MB9959.eurprd04.prod.outlook.com (2603:10a6:102:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 15:04:41 +0000
Received: from HE1EUR01FT093.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::f2) by OL1P279CA0010.outlook.office365.com
 (2603:10a6:e10:12::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Wed, 10 May 2023 15:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 HE1EUR01FT093.mail.protection.outlook.com (10.152.0.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 15:04:40 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.51) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 10 May 2023 15:04:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGhiSPH/pFyTCP5kMKHi1AzN0luUJsHtkOpnL5z1UZ3F4JTeAV4W7nvBY1DujrF2pw7/+BlE6/AonQilsnz3XoJJ78yQVSo6cJlVXJriURcdsXA+r4KnZskJn2XMQ87gvwnaodHVAMJub15EVvZcDQZ2vk1y1VTgL3PHej0YDVvc1CFb/mDE5LIFUazfDgnNOjsYjh/pmZ+Z97XtMr56tLqJkdgh/7gS4g2Z8BYAfz3IgIHg1/jv5q7nA0C8IiVpsht6ZHzl+KUyUWBnZNbrbCvIJftOtOre6F3uAM0bl+c8fjap8pyGPKwalgZYRqPdDsY78OH1Ajk34oX6uIogHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO4Ko6m/7vDqD3rYb6ulFk5bwq61O8gngTzIvwgDToQ=;
 b=bBQ6AQpPHOQVuG4ezwd8mudpjExtsKIO1RnhHbfsCyk6AD2e79PiKjXXT0MSIBNI2RU/+9GaLbpXKJofX3UUGHXCum2kLMJos7tRn+gdH8CVs37b4nL7myLu7OS67ulfaFfCdpE8B00AWJeu2Gi6VVwbFWECpi5Cn2t8eHCPMRyD+9tpkFA+4JF/F4nEzpFYpgvOSMh7BlWO/KwW3CI5zxnAIglMvXJABHMQ57bwdu3BoaZBdhUosEdZVzSwqZappb/FbHwBaFTBZNeG2XuGsCQHEdjzfNipM3lQ5yDWNJmVr0ZOjiXnuZ42fOQzL7ZoWVqzPbDanT7mSH/j+Dtd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM9PR04MB8453.eurprd04.prod.outlook.com (2603:10a6:20b:410::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 15:04:36 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f4fa:8429:9de2:41c3]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f4fa:8429:9de2:41c3%6]) with mapi id 15.20.6387.018; Wed, 10 May 2023
 15:04:36 +0000
Message-ID: <0332e0d2-5b7a-d79f-490b-a8e60e4663f8@topic.nl>
Date:   Wed, 10 May 2023 17:04:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/2] dt-bindings: usb: misc: Add microchip USB5807 HUB
 driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.73717b19-477a-47ab-9efb-48f096304ca8@emailsignatures365.codetwo.com>
 <20230509074621.29774-1-mike.looijmans@topic.nl>
 <9a2c6858-fe1d-121d-aca4-58fa907ee2fb@linaro.org>
Content-Language: en-US
Organization: Topic
In-Reply-To: <9a2c6858-fe1d-121d-aca4-58fa907ee2fb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P192CA0006.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::7) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM9PR04MB8453:EE_|HE1EUR01FT093:EE_|PAWPR04MB9959:EE_
X-MS-Office365-Filtering-Correlation-Id: 784c9ca9-ad09-4932-e974-08db5167e190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SYllGNeTiAloRhYairXI8PHqxrCuMb163U0HoMYUBE+jB1GoNut6zW7EiUwyWwYJjE8eIgwETnYPO7JAOE3ViYt5mZGYmwGmPqv2WMW71exAVvVhNzRcAOkRKUPM52Vt9Zy8abMuf5/th9AonqgTsaJWXxuAX33DiOHivPvvYphTgnCk24FZFgwuH7rVUadrfGKWMNw3gZnMxq7m0h0LlIAgwtt8Yj82Ie/t9NKJUhtVRN3TO+0FKR0bAJ5Nn2OvVOMr2bhG5iH3UoLHD14uSyL90t2DnDS2zUj0Z42o4FDWgCC3nY6PXGI90xeEWEG1k/skUK3Pkd139dNZD2VsaiQMyBVSZRFe+uYQ7XoayvgaPaUtCdaEZZnObF/dknwuXdnz5tdSn6Ta4REqzm205uqW4hkaH77pCtxmyNPBRO2mW34WvZ7L4qqdoEonOi4p1QnkZv8+HihlYiTqxdxg5BY52z3Ekf7OLJV7AVTxKDSqWOyUW6+ocNmYMMO8OwRK6dtP1DJ8Q2JtInk/bcG+XsH8eoqLFbFe+Naldi+WyZGjxMP/pR9NOILPN0/JXzGnDpSNkf2nVq+Cc5iYpbLwNOa8L8KvygV+zzeRlOxA0BlMLrB3rVJTQo1GNV6mSuFomwD2NYpEa5YEengix46F1k7EGBkkux0YbQzSzT2ZmlA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39840400004)(136003)(366004)(396003)(451199021)(83170400001)(38100700002)(38350700002)(36756003)(31696002)(31686004)(52116002)(8936002)(966005)(36916002)(8676002)(5660300002)(6486002)(478600001)(6506007)(26005)(44832011)(186003)(53546011)(2616005)(2906002)(42882007)(41300700001)(316002)(66946007)(66476007)(54906003)(66556008)(4326008)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8453
X-CodeTwo-MessageID: 3d445e79-12b3-496e-afc9-a53947901f75.20230510150439@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT093.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7fddf3f4-d525-4645-5af0-08db5167de96
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6O98mAte0MF3nGRX/ExUx0F/Ty942tozvw7w0M8lAoHGjwE81utWTHLmZ125dR6pdYCLC5RzLAuDR78AwcWDslmqG9FQQ3bodu1mfdWE1GOddSUuXQmR1dpBZiMxUnTJ7KDy7MLQ3H4dOm4T/Qd7iaGNwBJsDFgu7bP5WiA78WFXwYd4qqEEiQ/22vbgIf9f1qupQUahQ8XAOv7b0H6lIElQlCsBoI+UTRBXTow1q5LHPMyu29/wkxqDM1Jf5cB34P9A5iBfaaSOHb8KEUXN5geqrl1oQViXAvrZDBYh7VzvQM81LKU5f5Mnr2cHmEI8dbJ44L52dLZTCZyn+QNAV1fqxgFbcbofEjWQi5W4F8Ei6vvLG33gZudeGuq6R3BFBIFY0TWOlouV53E4euHkrlEkT10M7aIpXB/l1LZOn+BG4IIJBwVDodjKO0eRQldcXdKZx3DPfmvEdTeu456+UVPiT06y76L8VwCDeERhaC0K+37FaoosCgU/Jl3R5vg0lUfY6HcUIzDfXGvFcuzdFWqHKRQspqzmQj7Lxc7jv6ChDinieHOtRjxSNV8j0p1ORajv0LqSe6Aeqx2ACBtojXDcEXOigGhI4HyQLE1EsCp8TQ9+/d6MBQm7TTTQHNjzip4G9lcrkpvZNFyAwcoT6Z+l8Lue2MGPDtMroyX4eKsxz3FWSrOPHyEf69paIec
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39840400004)(451199021)(36840700001)(46966006)(31686004)(26005)(7596003)(53546011)(356005)(7636003)(478600001)(8936002)(44832011)(54906003)(82310400005)(70586007)(41300700001)(40480700001)(31696002)(966005)(15974865002)(6486002)(8676002)(4326008)(5660300002)(316002)(2616005)(6506007)(186003)(336012)(36916002)(6512007)(47076005)(83170400001)(36756003)(36860700001)(2906002)(42882007)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 15:04:40.7471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 784c9ca9-ad09-4932-e974-08db5167e190
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT093.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9959
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll fix the issues and send a v2. I'll add supply/regulators as well.=20
Will take a few days though.

Thanks for the quick feedback, much appreciated.
--


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
On 09-05-2023 10:02, Krzysztof Kozlowski wrote:
> On 09/05/2023 09:46, Mike Looijmans wrote:
>> The USB5807 is a 7-port USB 3.1 hub that can be configured by I2C.
>> This driver resets the chip, optionally allows D+/D- lines to be
>> swapped in the devicetree config, and then sends an ATTACH command to
>> put the device in operational mode.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
> Subject: drop misc prefix.
> Subject: drop "driver", you are not adding driver here.
>
>> ---
>>
>>   .../devicetree/bindings/usb/usb5807.yaml      | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/usb/usb5807.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb5807.yaml b/Docume=
ntation/devicetree/bindings/usb/usb5807.yaml
>> new file mode 100644
>> index 000000000000..06b94210c281
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/usb5807.yaml
> Filename like compatible.
>
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/usb5807.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microchip USB 3.1 SuperSpeed Hub Controller
>> +
>> +maintainers:
>> +  - Mike Looijmans <mike.looijmans@topic.nl>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - microchip,usb5807
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  reset-gpios:
>> +    description: |
>> +      Should specify the gpio for hub reset
> Drop description, obvious. maxItems instead. If you decide to add
> description, then keep it useful, e.g. mention active low.
>
>
>> +
>> +  swap-dx-lanes:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: |
> Do not need '|' unless you need to preserve formatting.
>
>> +      Specifies the ports which will swap the differential-pair (D+/D-)=
,
>> +      default is not-swapped.
> maxItems (and minItems if it differs)
>
> No supply? How does the hub gets power? I see at least two supplies in
> datasheet.
>
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
> Best regards,
> Krzysztof
>

--=20
Mike Looijmans

