Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C570F454
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjEXKiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjEXKh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:37:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEF2A3;
        Wed, 24 May 2023 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDNfUWXT5SE6eSWdO8dVcqzgenv+qk+R+pRzFV/CE5M=;
 b=vKmlbOrTpEbPJYUN7xiy7YDMgDldmLkSeHrnh70MZ24QoQMONrgn2hd4B1T/hmOLqWBcOgtty4t75X3FpQX1Yvin6kaRjncIhLrF2Wi4x7RKw7q7jWt26b/E9X994ewyGxMtNHZMx4TfLyr83HiUwIT5ijoCyb/nrvLvh/6w79B/Q171+F5FfairL3Ez7AKZMDDl3acff/NkybmW3MGUakFu/zjLV3NoFK2MICBPlBvQHejkvqlHDlzkCEAxpHzV4ERHnBl6lQvybtRKMugRN5TyD5Fgs2Gq5cR0UcYDjtngUOlpqbt1R9MF5cUppMkUbBrnNIQXe39I/bou0dMv4w==
Received: from DB6P193CA0017.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::27) by
 AM8PR04MB7250.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29; Wed, 24 May 2023 10:37:50 +0000
Received: from DB5EUR01FT027.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:29:cafe::f8) by DB6P193CA0017.outlook.office365.com
 (2603:10a6:6:29::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 10:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT027.mail.protection.outlook.com (10.152.5.1) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15 via Frontend Transport; Wed, 24 May 2023 10:37:49 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.107) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 24 May 2023 10:37:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9/sTfWcVvH2+ZyDjyakKtU1XNIkIUoc5dDQaRawJZeSTGvNZXmPy12b5IRMEMaKGkAUTMbyqt9+DC4GKBoI1s/otvls7ZMPF1ar3DhKBtZVohVjKkMe2hGt2MAd4fdvsI6Favd9ZNv5ncbKDFkoknBbrtP5Anz8R3ATIIRRmQu3MFtHA+BReATL4R+engkyV3zAPenjq3BMWGYJveaG4U+5odKb0nw0qO3OTXZMij5VW8hdrn/+gXcPGHDg/IcJtkd793Ieg7Y0Rka3qav4aSGuIFpApWcxcdX9RLv2Whv0IQWNGor6lNmnssZ9kMgoRKRFJy1b67ARijJN86FL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqfcEkp3aPESIZpiNm0C4fmBV0js6IV699WTQCuQwDw=;
 b=LONJs1i0tnl2KlGSm6WrqKruPn0ijUOBDP8cXV6a35xttuaqHlmwwEmV7bzjHEY80xbFaoLvGniTbgKBKj4b44/K4Hau4/MJviq8/SOjKvMGVSLb9/COnYkE6KdEseCnLXrNfK4bqBP9MFlx3Ixc4GkGNaboom2/YHe16sMZ0gk6dtKdjDVG0HPQRGYJtG+uGIL8QY9W8bVSJLcKVcf0rqktrZobS2TeqffclMQKjrKvbv7TFro9G4928pvCDfiZ4lldY0nGQx6E4tvTMNr5BSIlJoYTE0IG3S/ktenZkYejGmMq9YUb6xisH8DC3x14nEVUqLKbHJSSEdHvmSqDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqfcEkp3aPESIZpiNm0C4fmBV0js6IV699WTQCuQwDw=;
 b=af9TjeFanNo1YOxZnN735xjsuNLR1JCFj7OjtxMEB7hcUS2j07fkfdV68Pw1cs9NbqtbbuMcaT9WkL+AaA2tF4f+PondmBp+GJXte2X4KqgjECSHFj4ZKs1eJ7lVRmlSVOcIllNUag5yau4xjuaNEBgYoiz0086fysTb+JXpLgjJS3n54v+T9BWtj5pGWdItieEeRibmDSFXAqI9Y0dWtRfbuVpppVJR/ARO3mWKY2KOGn1PRKmyV348Op+8nvPmzUOR8eQnYIwosLLzuBY7GJFc3b9w5Qo3eLXG90yGpGASAstwpV6TRziarhLPr9XHiBRmV+yPnEcIUmb1pBxviA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM9PR04MB8116.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 10:37:45 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 10:37:44 +0000
Message-ID: <3aa1b03c-2b1f-998c-3cbd-4fabfb436dda@topic.nl>
Date:   Wed, 24 May 2023 12:37:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Content-Language: nl
To:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org
CC:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230519160145.44208-1-marius.cristea@microchip.com>
 <20230519160145.44208-2-marius.cristea@microchip.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
In-Reply-To: <20230519160145.44208-2-marius.cristea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:208:122::33) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM9PR04MB8116:EE_|DB5EUR01FT027:EE_|AM8PR04MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: db186197-29ba-42b5-4612-08db5c42ebf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: P/NeiH0YTZLlBqn4ts7H+qr8uz7gV903kMlAM++3tjXmTQppms/x3AMahHc6cGRYGe5yK+8fk4Qx6o6t9BlBoWJ6lJYNQCM6viSIhbPiytA/4oa1U+zS1Z2nmt87z9HllqAgO2q3tAjIyH+Yhj2vyDJASCMFZdYa0nNQGOMSjoGdQQyBi/zC01toh7sLE6YAz5eHmlL/Jpco1lV7M4MJHS0igkWwKiTaOvlz5QW67Bqed7+67xfZ+91s49JYr+Uzo9UXBbruZ9+i+ApACjKvIdYdmY43tRsC4ImEh95sOVrJ1cS59nVYcMWHUGsxCIYQaQJMyuscthxEyuv+RRdTQGUYNV3NVgFy/CtcFLJcNC9RO99lsNJWSnG8SglYAgXwMen1+yIHJzqx9uH4fs3hLXnv+uwVc98bvWGzHdjBq0m8k46v/aq+XMDoZ4TFGrWdHB4dRo0YHpS6hcsNagBsP6vC1JTgkyP6C9R9zho8bo5+KkcZ7VCe5dNc+LpbwzYj6w0YQAPNgUHZBKOyENLvrsS6zyQY6qwSzHFx95zylm9f9AKXAKnRWpdioYiry/iWpGtnepM8i++nji/vJl7GQWmK3C/Fr1eEjBYFcCwjhDfSfR/62MBn+0LS9HalBkmZ5qFVzlHYsGyoxLnafzFp6g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(366004)(136003)(346002)(396003)(451199021)(36916002)(6486002)(41300700001)(478600001)(31686004)(31696002)(316002)(966005)(4326008)(66476007)(66556008)(66946007)(5660300002)(8936002)(8676002)(38100700002)(15974865002)(44832011)(26005)(186003)(6512007)(6506007)(53546011)(83170400001)(83380400001)(42882007)(2906002)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8116
X-CodeTwo-MessageID: 6162571f-32b3-4f80-abce-9fb504799bcc.20230524103748@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT027.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1e77124b-a510-4861-7999-08db5c42e8df
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogMlgDMvfuRuR0Roys8EBEYL6jSy3Rz0cHSVXpeh8FBoG6qzxuxec9m7lY5OOIpM0vI4wU71M2PJUCdC69FJX5T3cuaYYu9xFVAMjZsGmNSYFymy2VR2xO0ETmisAlamrS+CSntEL2eoAOUcjUMP6h6sDAHmMRpb2c5HJnhpHakuYFaMSRX9poQedfv7TZQPQVPjMWkSwsjleE16k3vMi0GI46zC33OrZib8SPKhirgsAbpCCesoIrQ73KJIFWei5l2okVjIesUwh7zxCf3aDGwbZq/E6CE0h2KqXNl6GNs+8vkZwvwbAXv2UZDuacm+sexdlggTxQ4FRJMSPPRL1B1AQiOzdjTtUMi+FEmivItZrl8/8cPhf8Zv07ruVngnZzTNWHbiZaBLLIXM8DVx40+/s+HiH6bzkZucAsEs62Wh9QaCSwpfjPwt2GZVESPtrtWTzzBiaOMFIje6s7mi1bz3KetB3E6+7Vr4A9KJGL2sT/zduIJJhcHkr6/eYQQ4/4QgjbFm5iVG2Pbbj30uxwxzCkDXGdooOtytPVhg0zBVmkgHXmP6CAb19MxypJw9+RQnkIDKHIJZ77S/pPZbXq0XPq1VlQeWf3hgVN9Hf9L96NJuoIv1eaHCJJVtzpIIDFI2laDQJazuHVN3934w4o8BHKHoF2LhxjmVPo04F4ezBOQ7scoWOmlA2g4exAgU96J13zAENrt98kONEF5Xh6ypD5FhYiMtnaZFB+3V4YvMoajNjmcwrq04lY7MBHwJxlVLNpFyQ1eDc1wXiln7MasCUkX6XO1CbbuwL0gvF3zbSjsaFNcIK+mBbI6pHXD9
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(396003)(136003)(376002)(346002)(451199021)(36840700001)(46966006)(41300700001)(70586007)(70206006)(2906002)(40480700001)(26005)(186003)(44832011)(478600001)(6486002)(316002)(4326008)(36916002)(966005)(31686004)(5660300002)(6512007)(8676002)(8936002)(36860700001)(53546011)(7636003)(7596003)(356005)(36756003)(42882007)(336012)(2616005)(47076005)(6506007)(83380400001)(83170400001)(82310400005)(15974865002)(31696002)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 10:37:49.7236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db186197-29ba-42b5-4612-08db5c42ebf1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT027.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7250
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-2023 18:01, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the device tree schema for iio driver for
> Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> Delta-Sigma ADCs with an SPI interface.
>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>   .../bindings/iio/adc/microchip,mcp3564.yaml   | 88 +++++++++++++++++++
>   1 file changed, 88 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,=
mcp3564.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> new file mode 100644
> index 000000000000..407a125e3776
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,mcp3564.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP346X and MCP356X ADC Family
> +
> +maintainers:
> +  - Marius Cristea <marius.cristea@microchip.com>
> +
> +description: |
> +   Bindings for the Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> +   Delta-Sigma ADCs with an SPI interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp3461
> +      - microchip,mcp3462
> +      - microchip,mcp3464
> +      - microchip,mcp3461r
> +      - microchip,mcp3462r
> +      - microchip,mcp3464r
> +      - microchip,mcp3561
> +      - microchip,mcp3562
> +      - microchip,mcp3564
> +      - microchip,mcp3561r
> +      - microchip,mcp3562r
> +      - microchip,mcp3564r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  vref-supply:
> +    description:
> +      Some devices have a specific reference voltage supplied on a diffe=
rent
> +      pin to the other supplies. Needed to be able to establish channel =
scaling
> +      unless there is also an internal reference available (e.g. mcp3564=
r)
> +
> +  microchip,hw-device-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    description:
> +      The address is set on a per-device basis by fuses in the factory,
> +      configured on request. If not requested, the fuses are set for 0x1=
.
> +      The device address is part of the device markings to avoid
> +      potential confusion. This address is coded on two bits, so four po=
ssible
> +      addresses are available when multiple devices are present on the s=
ame
> +      SPI bus with only one Chip Select line for all devices.
> +
> +  "#io-channel-cells":

That's a typo, "io" should be "iio", right?


> +    const: 1
> +
> +dependencies:
> +  spi-cpol: [ spi-cpha ]
> +  spi-cpha: [ spi-cpol ]
> +
> +required:
> +  - compatible
> +  - microchip,hw-device-address

Should be optional, as the default "1" is going to be what most people will=
 be=20
using.

> +
> +additionalProperties: false

Missing properties:

- Interrupt (even though the driver doesn't use it yet)
- push-pull or open-drain config of interrupt pin
- dvdd-supply
- avdd-supply

I suggest using this:

+  clocks:
+    description:
+      Phandle and clock identifier for external sampling clock.
+      If not specified, the internal crystal oscillator will be used.
+    maxItems: 1
+
+  interrupts:
+    description: IRQ line of the ADC
+    maxItems: 1
+
+  drive-open-drain:
+    description:
+      Whether to drive the IRQ signal as push-pull (default) or open-drain=
. Note
+      that the device requires this pin to become "high", otherwise it wil=
l stop
+      converting.
+    type: boolean


> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "microchip,mcp3564r";
> +            reg =3D <0>;
> +            vref-supply =3D <&vref_reg>;
> +            spi-cpha;
> +            spi-cpol;
> +            spi-max-frequency =3D <10000000>;
> +            microchip,hw-device-address =3D <1>;
> +        };
> +    };
> +...

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl


