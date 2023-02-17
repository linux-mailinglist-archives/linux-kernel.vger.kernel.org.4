Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D375469ADC6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBQOSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjBQOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:18:20 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54374AFDE;
        Fri, 17 Feb 2023 06:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l146rf0mzL0xbAiUBBfXcRIpujDqP/WyEMQptvZXsys=;
 b=hK2TlDr02bazIYwSOiFoPFsYKHmYcw2TV38EsLrL2m4IFF5/MwiSLdRXkfHWgv3cdryHSpYrOHtleW/ScsZw6HlpsBgS5tP2TE/qRCFj6DBPUzKOnh6BrmTK7x94Tjbx5BdLzlIGvSGNpcYfr7MQTe1hRb1cQ7ndrJju69hJCfwVgVKn9gTGS5Ay8be3QT4hY4SXwEjXOq8t4RNMHMcRo0WFzWd43aPW1lJ+RzWavEbTH5Tw9+3k6phsHVZv+n/yAOv+81TRQCo40QmLcewB4u3HQwfl/irwIne+OOCyu71bHNqR2F910zuc/er+i27CEsHfeEosuyUGCAHSEBcogQ==
Received: from GVYP280CA0045.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f9::14)
 by PA4PR04MB8061.eurprd04.prod.outlook.com (2603:10a6:102:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 14:17:57 +0000
Received: from HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:f9:cafe::2e) by GVYP280CA0045.outlook.office365.com
 (2603:10a6:150:f9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17 via Frontend
 Transport; Fri, 17 Feb 2023 14:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 HE1EUR01FT062.mail.protection.outlook.com (10.152.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.17 via Frontend Transport; Fri, 17 Feb 2023 14:17:56 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.174) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 17 Feb 2023 14:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp5bTvc5n6JdKI9S828IFDnmbEa/YFNxjmIFBDxo1jfDMq/yGiR/wzLRJnEHDi/ZC7D5eg7AyNP+do+F+1A5BSXY/BH0mllM8zfGlNvzZWdRnXY9sHxClRBmCQOa2n0dDochwmL9BbJlkS2lKnQHdTGJVV0gpTdjDZ/efSX8LHRS9nrXFFjd7OeynikC0wYtHJBs8P4x8EK5yAJ0wCbVcrt4TGVTTwAZzEn9nw0IPKwqkjFkJWUcTFqC7pVWEFa8qMGnbRd83vuk7HCG6lg4r5oh0hkWaoQa2Pob93K1kMjwfhFz54aLfB/EjSg232LsreFzOTuocFApvPR8jEo35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtcfEsRgM8jtVfvLq8uzKLCyvw/8/qUwO6yawoVjrDE=;
 b=XQ/l0qmYh4ceAK9Krw77vnmIqWjnlftfZzMlUwmKU4UsodgxZllF11q1o0huZkGui/pa2+vMNJrD0Acxkt0D+QpAbOaiHL+bM8vV/dYZelhQt/eLX5IqTs6zcipoZgxbGRBx2mscDVqqQ+q6dv14ZUxWsAl6VRXjTmksG1OBUO6h8yZiRxp2A4y+iOAMNgMVARqvgVEi0ChexlC8auKZ+P+fjW0alXUzIFSX/YJzAVMSA21/ips/M5tztG9omh1Xe1A3iiQ2pium0MZ1q6wbtsiIOUCMd+zahCQLD6X8z+NQ8IdIrsrY4Ffs06ZoN0mA0rxOYN32rcJ2NhcsxH+ttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM9PR04MB8618.eurprd04.prod.outlook.com (2603:10a6:20b:439::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 14:17:53 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%5]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 14:17:53 +0000
Message-ID: <5b90a794-b09f-0785-ac9a-ce375b59a3f0@topic.nl>
Date:   Fri, 17 Feb 2023 15:17:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add driver for TI ADS1100 and
 ADS1000
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <20230217093128.8344-1-mike.looijmans@topic.nl>
 <cec5a521-bf3a-7cd3-4516-4f4a1b9e1661@linaro.org>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f5b3563c-3030-4c7b-8162-00135fd9d2e4@emailsignatures365.codetwo.com>
Organization: Topic
In-Reply-To: <cec5a521-bf3a-7cd3-4516-4f4a1b9e1661@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::12) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM9PR04MB8618:EE_|HE1EUR01FT062:EE_|PA4PR04MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: f15f67c3-c14a-4222-cf72-08db10f1c42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zaMvkPO1iZnK/EiNXZPKzzzFEjqHJDbhghZIakEN33HFgWziLfxZGanQMy9KS3CHJiK4in/CcvkAsdztLZhWGEf4PojZAYKklApbGjMnwXJ01WSe0B3mfvc8jEt7VvysH6bJttXxMnTBpQGqfZvcZcJLXtokwZQU71V4JoCcV2L25tRHw/Vluc+RaT1XY5cvFQAenbcZq2rexGbf8IUhN6UHFFPosseK+G4xBc78jaaqOXkAysgP87MNPhO1UmxrSOKpK4G8DrN2VFmHVsugL78vKFeVR6lmuJFhQqNE/0nfISGHbDCsSUOJy9gViCz2CUSBXPtx2t6FcbFpVYBHvfPHy7xktcdnQNrNxmZ3rk7yCF+d/E98MXG9zeXcljwQfKW2AJhcml8DN3WpJYo6tp2qnJPwQRh9URg8lBvJvtmw4nqpKnfGBOP85IPugKeot/lqD40aKj0NJVbUODcf5baQaq1olBteVlc3NpGbi9hTEiLAJd6sgf3+ts0el3ZOdw52mCBSKuoYc7/godoHM9bV6CCzysSHvHqstdmZsHo7MkNuYvJjJiTZFlJMg6BG0/3ho5aelObrHgjcigO6Jmc1NPBPw3A+/cIRI37u7gxNRR3jeqbnmjKCKV+DiT1ILPI4wmwsKg9kK6bMkuyke/66MefAtuc5NfiRkN0teiSSpm8hcdDsAkaPB2ldMplb3hRQ5VN/nfYiyvJro7jaHJQSWsNgH22fZHMLblzdb/aEK6OGR+Sd3jNLWri94Y+n
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39840400004)(376002)(346002)(396003)(451199018)(31686004)(478600001)(31696002)(42882007)(2616005)(44832011)(2906002)(36756003)(36916002)(966005)(52116002)(6486002)(6512007)(53546011)(6506007)(26005)(186003)(38350700002)(83170400001)(38100700002)(5660300002)(4326008)(8936002)(41300700001)(8676002)(66946007)(66476007)(316002)(66556008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8618
X-CodeTwo-MessageID: be85ee36-27d7-4d4e-a0e6-ee850e5d6bfb.20230217141755@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 66dce267-4539-41ee-6691-08db10f1c1de
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7smhRrdFTtF5anvGvjRBpVcYQqs3/J+Tf6T/9af9EdFz2eMbQyOSFgOf4EKJwO/VNldfgwYNuEHn16UIvA0VY+rcDvfHwZwGs+dNls+lqFASN8zFXtCdebN8N2k8w9QHfx+O1T59HRhRyOTmEQjXo2vfQ8bgqXgE2GvhjvkzjNfE6e6prqcQF3Ts2g2DOU11N7T3QPNBunZUI+Ft3u1nFZoIPKQ1xxiFeiN+t/dsDQ85dxNXO9vnufE3Zd5SPG4HRCd15TppgaN81or7C3ZuWbttn7nMxACZtkn1ww7OT2c6bCY6FE8sktXMo1f31grPYYAozHNA3fRVRKzvYqCwU283b7yKtVtl6HI5ixpraWT3ExJnLtW4Ag+U54wSF9CGOGPiXhVIWOvw62VyCuKNAUzqCgMwmJz6fLPn/JsnHBJcibRPkZvDgq81BrY9ccXjV0+mDWWfkSb04ZEZdJJVr0k1cL+uGwu/6lCphYZk+0WI0AwhsGzyYbWsHLX/qp5v+ghwmXgvqh0ZYkp76yu6YHa1s5n/zfGOSUag16JFlV2XHo7uYnvo9tHWTsluN7Bf1Snoyhb1HdG/DlttxgklyuJfw7vL7LCrYQp/qecX70riupGYP8jmgW86a6vVYVfotsGDZ8S/ubBa0HqP/z2lptDt0gpIa45ux/mzgod9v9n4gvJkIA17QXOSpjfB7zF
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39840400004)(346002)(396003)(376002)(451199018)(46966006)(36840700001)(53546011)(36916002)(5660300002)(2616005)(6506007)(44832011)(36756003)(26005)(186003)(6512007)(7596003)(83170400001)(356005)(36860700001)(41300700001)(316002)(7636003)(54906003)(4326008)(70586007)(70206006)(8676002)(42882007)(8936002)(15974865002)(336012)(47076005)(40480700001)(82310400005)(31696002)(966005)(31686004)(6486002)(2906002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:17:56.4859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f15f67c3-c14a-4222-cf72-08db10f1c42a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8061
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks I've fixed the issues and will send a v2 soon.

PS: Sorry for top-posting, it's to avoid our mail server messing things up.



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
On 17-02-2023 10:36, Krzysztof Kozlowski wrote:
> On 17/02/2023 10:31, Mike Looijmans wrote:
>> The ADS1100 is a 16-bit ADC (at 8 samples per second).
>> The ADS1000 is similar, but has a fixed data rate.
> Subject: Drop "driver for"
>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>>   .../bindings/iio/adc/ti,ads1100.yaml          | 37 +++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads110=
0.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml b=
/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
>> new file mode 100644
>> index 000000000000..ad30af8453a1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1100.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI ADS1100/ADS1000 single channel I2C analog to digital converte=
r
>> +
>> +maintainers:
>> +  - Mike Looijmans <mike.looijmans@topic.nl>
>> +
>> +description: |
>> +  Datasheet at: https://www.ti.com/lit/gpn/ads1100
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,ads1100
>> +      - ti,ads1000
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>
> Best regards,
> Krzysztof
>

--=20
Mike Looijmans

