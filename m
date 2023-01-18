Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A6D6727B2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjARTBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjARTBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:01:02 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F372F5F387;
        Wed, 18 Jan 2023 11:00:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8oJn2cFXLJAn5hUJdKKQ7wNJGHxT1PPjMC6pfVyj04E7edO/YlMET+SfrHDre7gjT1flG4nFXzMR8ksJtbMHzJSwTQQEGdDIo+ce8xZM6pjfChM9HkGVcr3cftS5uB7Gui3g8+SLbqIfx99udIyVWc0RxD5XIG2EMYwtzxkKU8VjkGcB67i1mPE4QhAs72IwneeBiFY0qKTBb2dHmRbqPcOFvBx5uyuimU2XUpNIkSYRi5z/OYDE8MtJL7UMPTO9aJT14OdIcy5fH5tmhs0djbbaEln1f3+L9WFkvVTnYGKqkmlcN3EOsoFyXmNJkXJ6rxXh1nMT7jx1HSaYkg++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoF5LUzBs/yBMovKXbsrbQZ3anHiZVmsTHLHATAF5DA=;
 b=lTPh+9Ep/hCfXh/Xl0XnjVw3x1wj0qPece5VKT8I1AzNMfO0pdZyEyWwReazduzVVMRnZvpgSQl7+FayNhbd7nvTT4Ow69djdfrJcDoKKIABm3d7+aTPOsSoeeWRahZ6+AK1yAgaazMJ8wAptyTCGsYTgzkxAJ23oea8Bni3uMv/g5BMKdEx94MQMOFV73Xn69d03/Z74rrT5ui4rTY8jGC44qboZDNLVwAaS9LrVQwDOw2IZe0sCdt/+lVHRFmi0w7kabkHynfwBcQsI/F89VSRFRPOfg4dXs2YiFZ8pFzp61ekb/30xJrLBpSdnl/Aq1IWHe8fKV2jTjb9WBOxPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoF5LUzBs/yBMovKXbsrbQZ3anHiZVmsTHLHATAF5DA=;
 b=HkGV0WIf8KxnN+x2f2b/Hdf1ARupm+490DEav7mydKAcYBLS9jm7dz5lChpMGC8vwPn0ERadY+dAlrzz0aHjCzcUIJ12B372i14wk6e0wpE6ImAamfM++iikbyzcQ4W+PWekks+W+tqrtPouT6yPhcrRFfA5U5EVyc/X+qHKBg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from GV2PR08MB9158.eurprd08.prod.outlook.com (2603:10a6:150:e0::9)
 by AS2PR08MB9547.eurprd08.prod.outlook.com (2603:10a6:20b:60c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 19:00:25 +0000
Received: from GV2PR08MB9158.eurprd08.prod.outlook.com
 ([fe80::1186:9787:f2c6:235a]) by GV2PR08MB9158.eurprd08.prod.outlook.com
 ([fe80::1186:9787:f2c6:235a%9]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 19:00:25 +0000
Message-ID: <956672cf-a228-54c9-bd79-14b7b0621c59@wolfvision.net>
Date:   Wed, 18 Jan 2023 20:00:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] dt-bindings: media: i2c: add imx415 cmos image sensor
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
References: <20230118103239.3409674-1-michael.riesch@wolfvision.net>
 <20230118103239.3409674-2-michael.riesch@wolfvision.net>
 <20230118154852.GA55989-robh@kernel.org>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20230118154852.GA55989-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::17) To GV2PR08MB9158.eurprd08.prod.outlook.com
 (2603:10a6:150:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB9158:EE_|AS2PR08MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: e6fb485c-f98c-4d49-c776-08daf9864175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3E1FBdK4dj2sl37sPfSrt67Du0kpIFNZ7PW2Aq7cMLnbKCjqVhulYlOd5qy8ZokpRvW79gPeszvIGF8zSyOT/RxRfMpLyQtAZ7FHVp008M9LrYlglAKaEMPh7znV2Pv9o8Q8cjsZpJKPuJVdvZeulX27tGXKSAcJvUtUVawxL78ZdIjXSufbQUmWmcwN28gsOGoeFzaUsU9makFqm6UTS7lHKgEDjBNIRiuE3ZILtNN+DeDjPe3jlDHylvivFexxZUBq6pZ3RDEapBIFhVDKRmbikxW3PKyNj2KE5EtRCKaxMEg+vty4WkmvUQr1iUVzNzz3e1DtGQIislHdxcQcPhKSpjGMvmzANlKxM/xQtCGo2hSI6JUv83cNydsNmtUq6c6U2Hng/h85xTCQII7exWbCWHGrt3cY+XEnhWY83CNtFLetrCwDw5oFtegc+xg7ybR879Ic1rWJ+uuAowQIwStMUaX93G7R1QL6sAQM80TpMVhOjygK4wz4232wThGEPhWMw546MWBPRWq7TcvDXuttN/8Uz4bnyVljuYg1CWbyTFK9mo8FtXhxgnDrWXP+SRbu/gn4JCVvoqXnOkJZjpH3d4mmbdVHnSzWc1cWDheViCWGZUhpnGvW6Eelg7gfgFQBv+H0bIM3ZEDktE8XLBvthhd9K8PM3qT1UKZnUwMocY/scYKTNus52o86xivedm9FKa52c462qmyGqQV3Y035RCKeR81b+Fs7QoqWT1u0nTXgjqDqZOcH1dybHp2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB9158.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199015)(6506007)(966005)(6666004)(53546011)(186003)(478600001)(6512007)(31696002)(52116002)(38100700002)(54906003)(2616005)(41300700001)(7416002)(6916009)(316002)(4326008)(66556008)(66946007)(8676002)(66476007)(2906002)(83380400001)(5660300002)(36756003)(44832011)(6486002)(31686004)(8936002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGlGVC9HM2FkYkJod3M1YVRtc08vRTJhb3BYWnozUjR5NS9VK2I1T2JhZ2tn?=
 =?utf-8?B?ZDExQVc0Tms1QWlwbXFqcDVWbXlyY0tROERYbERoNmxyZlVFcC9ZaDdTbzVO?=
 =?utf-8?B?aks2SHpwSy9TU3VXOU9Kb1ErekFBUXJaOVAzcGRKcy9zOGZObGNTaGdaNzd0?=
 =?utf-8?B?N2xqTUZNU3JJbFllNDh0VnhVTDlreitHcUNaSmpUMHJ4UC94NUhUL01KTUVQ?=
 =?utf-8?B?TmVYRFlHQzJMeTBIaC9IL3h3bVhKZ0UzaUlLZXIrQ3Z3MVc4cmNXNHlvU1pZ?=
 =?utf-8?B?RVJuUHRLOTU4eHJJbVhlbVN2RnZQSjM4TWgyaENWMXM4ZThsaWorT0lkZERq?=
 =?utf-8?B?NVYzVHh2YlhhcGlReU9UZDRXaERvY0pXNE5Ib0ZjMXRQTVoxZEs0RVhKeVBK?=
 =?utf-8?B?Nm1xd1VsdnFkQU1QbWsyUitlS3FISWI4MHE1cjgwNnc2SlZ3dVI4ejlsV2sr?=
 =?utf-8?B?Q0xSK0xaMXlJTmtoWTY2ZTNKZXFYV3VOL21KWldzSElCUW1mVUlpU1k5WTZP?=
 =?utf-8?B?VkNvbTRIcmM2SjVKaEY4QytQVU5HdHMrU2pvOXl6M3h4ckhaMjJwN05TWTJI?=
 =?utf-8?B?bVNEclVpZ3dSL1dMbkZxYWw2NngxOERubmY2Tlc0eFRCcWNiT0FWclZRWjNF?=
 =?utf-8?B?WDFkM1hUb1ZNS3JpdnNOSi9IcFBrMGtCdW5pb1UvNitZTUl6QU5vQzRScy9t?=
 =?utf-8?B?bFpnNTJKUXVTN3lSTzVaclJPdDREOUFzNFBZTmJoaWNqWkk5V3dwYldGRnFn?=
 =?utf-8?B?VFdJR2RBcnk4a3FxdXQwR05NWVdnTC82R3NvQ28xbWY2QzJQZzFubGJJZWw4?=
 =?utf-8?B?cjRYQjlFUjkzd0VWdFNRQ0MzSVB1Qkt0T1pjMWVINTVMZlNnbFZuUVVzMkFM?=
 =?utf-8?B?M0piN1FwQTVCR3EzaFdUOFJSdWhUUnZBaFM4WWo5MS9SNjVtYnBZRktsNUg5?=
 =?utf-8?B?UU5WVEpIZkhmanR4NTVQcW1yOGlwWlhNaHFYWGE1R2lOQXMyOWRiWU5uZksv?=
 =?utf-8?B?cW9neXJMUVNPb1ZaRnZBYUZCYytac0ZqSGdHNmpleTBNRExlNGlkUnZZbzdo?=
 =?utf-8?B?YWtHYXBETy84T2dveVRCUU9kRTloMUFWRHkvVkxoRXNuZTNFdEVPYVlkTFFa?=
 =?utf-8?B?aUNPTGVyS1dkSkRKbjZhS0lwbG5OVXl2bGVORklKbi90SW5GYTdPdUdiYTlo?=
 =?utf-8?B?RUpCSklwdjZJUXY3V0d1MngyTkFCdE12OUJBdTF3ZUo2cjFISHZrQ2Q3Zkk1?=
 =?utf-8?B?bEJKOHFQajQ4ck1oaGlUVEpMOWx5NXo3aS9YTzZ4ZmVWODJWSm1kYTZMeG1o?=
 =?utf-8?B?cmZadGcwR2ZzL0dCRGlKZkc4SGtPT0xkRnVpaFJUWnRiSG9UdnBQL2VyNVlN?=
 =?utf-8?B?RjRjNkd2Y3EyNE1MY0wxSjg2WjNpN2sybkdJSGdpeWlhZkxJT0hGQlhpSFJv?=
 =?utf-8?B?cGRCbTdHSGJHV1Zub2tnSHczK3VkVWNPZ3BkVnBQemlqSkhPRmdkU1dabzJ1?=
 =?utf-8?B?QXU1MEtTcHh1MWtmSnc4S05zeiswRkd5STFuak1WSHRVK2RaU0oySDJ4Z3NZ?=
 =?utf-8?B?cVVCMEU3WGhXaDZwaGNSL0RqSklLaThVZTZaZ0QranVRSXJOdnl1c3hlSjcx?=
 =?utf-8?B?T0FRQ0o4dDVFMGRVZzZ3eGdha2pnZ3Q4TmNUVXF4aysxcDdNNVdXaVRNNlEy?=
 =?utf-8?B?N3hpaVp5NmRuK1RQTVlGNkFtNGZOZUJsdzArRWNBRWorNDRrRU9Bb29tTVhF?=
 =?utf-8?B?YkgzdjFCcEdaRU9ma0dsVjgxQzBzajBQem92QVRyMElTNXpLdzdEcW1nRkZS?=
 =?utf-8?B?VGdJanlMNjd6L1NCTzN1bC82eTB2Y3ZTQVRPWFVDOG5YRm1VTHh2Mno5TW1G?=
 =?utf-8?B?WGR6UzAwOGxOTmxKY2RlUDlVMVd2akJ2S0UxSTdQRVZnL3hNV2VpZGNVNUFk?=
 =?utf-8?B?YjhuV1JmaHBvQWdqR3IrMWg4VFpCZWRkdHBCWUhiVm9xbk8zUHYxMUdRcHd2?=
 =?utf-8?B?eWFzMzA1aHFyVCtIZ0xzUm9oelNzaVVpMVNidFc4RzRxWlNEMzlhWFhmeFlZ?=
 =?utf-8?B?aHhpVEVrZ2NYb2c2WkxFWXhCdElTSlh4eUg3WEZBRjB5VUtNMW5JTEIyUEhK?=
 =?utf-8?B?MDkwSC9PQ0RJNHFJOWZZUzQ2T3NDeTV4R0tkbUpkVzdMckYzamNTaXpUcDB1?=
 =?utf-8?B?U3FTbEpUbWY2U0NTalY1eG5pZmgwOWxpck5HbzVwUkJrOWQwMXI5WkFpZkhE?=
 =?utf-8?B?RnpmRTB3NjNubXVWL1dsSDNXalhBPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fb485c-f98c-4d49-c776-08daf9864175
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB9158.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 19:00:24.7549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pL1vaPNnelB1S/5a3UGXTKmmFdyd2DYCpXn+yC6Z7X2mtUsK8SkEfyiYYHLFC7Lr+Bm2y8wCBB221bYeVnzU/YcbawkRP9EtIOckxolv6jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9547
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 1/18/23 16:48, Rob Herring wrote:
> On Wed, Jan 18, 2023 at 11:32:38AM +0100, Michael Riesch wrote:
>> Add devicetree binding for the Sony IMX415 CMOS image sensor.
>>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  .../bindings/media/i2c/sony,imx415.yaml       | 120 ++++++++++++++++++
>>  MAINTAINERS                                   |   7 +
>>  2 files changed, 127 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
>> new file mode 100644
>> index 000000000000..ae54834a2341
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
>> @@ -0,0 +1,120 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/i2c/sony,imx415.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sony IMX415 CMOS Image Sensor
>> +
>> +maintainers:
>> +  - Michael Riesch <michael.riesch@wolfvision.net>
>> +
>> +description: |-
>> +  The Sony IMX415 is a diagonal 6.4 mm (Type 1/2.8) CMOS active pixel type
>> +  solid-state image sensor with a square pixel array and 8.46 M effective
>> +  pixels. This chip operates with analog 2.9 V, digital 1.1 V, and interface
>> +  1.8 V triple power supply, and has low power consumption.
>> +  The IMX415 is programmable through I2C interface. The sensor output is
>> +  available via CSI-2 serial data output (two or four lanes).
>> +
>> +allOf:
>> +  - $ref: ../video-interface-devices.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: sony,imx415
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    description: Input clock (24 MHz, 27 MHz, 37.125 MHz, 72 MHz or 74.25 MHz)
>> +    items:
>> +      - const: inck
>> +
>> +  avdd-supply:
>> +    description: Analog power supply (2.9 V)
>> +
>> +  dvdd-supply:
>> +    description: Digital power supply (1.1 V)
>> +
>> +  ovdd-supply:
>> +    description: Interface power supply (1.8 V)
>> +
>> +  reset-gpios:
>> +    description: Sensor reset (XCLR) GPIO
>> +    maxItems: 1
>> +
>> +  flash-leds: true
>> +
>> +  lens-focus: true
>> +
>> +  orientation: true
>> +
>> +  rotation: true
>> +
>> +  port:
>> +    $ref: /schemas/graph.yaml#/properties/port
> 
> /properties/port is for when there are no extra properties. You need 
> /$defs/port-base here since there are extra properties in the endpoint 
> node.

Aaahhh, thanks for the pointer! I was really out of ideas what causes
this error. dt_binding_check now completes successfully.

I'll fix it in v2.

Best regards,
Michael

> 
>> +
>> +    properties:
>> +      endpoint:
>> +        $ref: /schemas/media/video-interfaces.yaml#
>> +        unevaluatedProperties: false
>> +
>> +        properties:
>> +          data-lanes: true
>> +          link-frequencies: true
>> +
>> +        required:
>> +          - data-lanes
>> +          - link-frequencies
>> +
>> +    required:
>> +      - endpoint
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - avdd-supply
>> +  - dvdd-supply
>> +  - ovdd-supply
>> +  - port
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        imx415: camera-sensor@1a {
>> +            compatible = "sony,imx415";
>> +            reg = <0x1a>;
>> +            avdd-supply = <&vcc2v9_cam>;
>> +            clocks = <&clock_cam>;
>> +            clock-names = "inck";
>> +            dvdd-supply = <&vcc1v1_cam>;
>> +            ovdd-supply = <&vcc1v8_cam>;
>> +            lens-focus = <&vcm>;
>> +            rotation = <180>;
>> +            orientation = <2>;
>> +            reset-gpios = <&gpio_expander 14 GPIO_ACTIVE_LOW>;
>> +
>> +            port {
>> +                imx415_ep: endpoint {
>> +                    remote-endpoint = <&mipi_in>;
>> +                    clock-lanes = <0>;
>> +                    data-lanes = <1 2>;
>> +                };
>> +            };
>> +        };
>> +    };
>> +...
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f61eb221415b..c9fa893bf649 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19493,6 +19493,13 @@ T:	git git://linuxtv.org/media_tree.git
>>  F:	Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml
>>  F:	drivers/media/i2c/imx412.c
>>  
>> +SONY IMX415 SENSOR DRIVER
>> +M:	Michael Riesch <michael.riesch@wolfvision.net>
>> +L:	linux-media@vger.kernel.org
>> +S:	Maintained
>> +T:	git git://linuxtv.org/media_tree.git
>> +F:	Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
>> +
>>  SONY MEMORYSTICK SUBSYSTEM
>>  M:	Maxim Levitsky <maximlevitsky@gmail.com>
>>  M:	Alex Dubov <oakad@yahoo.com>
>> -- 
>> 2.30.2
>>
