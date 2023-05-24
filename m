Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA170F1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbjEXJDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbjEXJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:03:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA6B195;
        Wed, 24 May 2023 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br/gUW7mFJwCRuC7MWHiATTSYlAicvloDFqK8vn2OP8=;
 b=y1xsaIf/vvvRLKc3ad6eeek8BN0nchZWYINI3wRskhnlDkkcJteUs9+Lwh6gYGJtYBiZxPF/kCEJw+HCuwf77Nr9WHyd0TMhUpFnyM67W6/hdoV5iuTYOGj9rdUN2wSEN6DZuvAYeKgc1AcPZo0Ie+8vYmKtT38HTp7XNHLvF4ALFh9J+3dH1CgxRWXwwWxruI0IS3ufRYDJNZUi4U8cYs7CKMFPMiTPp0YC6WAXe+IUMMnyBviW/HPfYxzi+yDeIZBp9lqTI03scPcXRwPZWBPScow02oIDCkIDTU/mV+SfLPGirdaWF3h+wzekVxj4AH6fz4E0dLweNbfn5boyLA==
Received: from GV2PEPF00000104.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:1:0:20) by VI1PR04MB9956.eurprd04.prod.outlook.com
 (2603:10a6:800:1e1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.24; Wed, 24 May
 2023 09:02:51 +0000
Received: from HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::207) by GV2PEPF00000104.outlook.office365.com
 (2603:1026:900::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 09:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 HE1EUR01FT062.mail.protection.outlook.com (10.152.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15 via Frontend Transport; Wed, 24 May 2023 09:02:50 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (104.47.2.56) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 24 May 2023 09:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Usu2/oRcPRKa7gTbAWf1VFBRBeGoWP2L8elEsH5FB5ylo0vhW6atUuMxIbBFIBJhdClrU7Qum8lVlqtbx+PxteywZiUd56cuPOCAaDsXfvyUPW6s2DeR0IrRnW42Lg+PSH3sHwt/9ru9/8+/iiutPvX/1K6Cduv0dk+RH4cZcFXNV5BqXU1i9TfsbLPMnHxZHGagaOAbGMPBqA8b/2xaomtuN26Ie9/RU+h0FbufwnEul1pfGpUKPilT+8NUkAPeNOMbqLKiCc+h5lO0ctbevI8kFq9hauZJTbHb1Hb4A6zkwRkx8C6+8ednN8Y6qL8SlZQoQ7tdUjwYCF8drbhBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzoNplencwTm+cthHxfEXuFqnVRLHMUkJKCmU+61ZXI=;
 b=kAgaUdJRabNhBnJZlLgoVErqLlgH9nnkhJu7uT3MDJQCMwdbXmyejImBKGsh9YzqaHKr86wXdTI17OAsWFAAS9G9n9uP5kwHnuFu5btE48hqaKmCm2WmrTZCRFJXerMQpeOLpwoRrnhZTTtfHtAM3k8RgoYdhpqJDGdpyik9E77+6JLDPNZsLS9zdoBo1rK7C9yUQwIw4c0mxZB0UyYHoQYkX8Ixpx0XCsYMprHH0uNw+S+UbE0H4c1oesJukz1hJHQc5d3Hki/mLVvwLo+Cs+p5rdCk3OpFwRd/1MgBIY/xd0wgKmmQqS8BGgchCHfDPTQxt3/j7IvV/TM0dMshqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzoNplencwTm+cthHxfEXuFqnVRLHMUkJKCmU+61ZXI=;
 b=Pw/QyDWR0/sN9z17apYj8BnUNvDfdIo6MKpLW2ZZnP5kvXpVHH2Ro9j0IJZeed8KK9gqJHJLsTcaSw5l0zNIwhTwGkE/2KQSTpveodsQkBMHrpX4oA2uTGYIVAtBj/srZMSFhM7onG4NWy9/SNeEiLWT5YZtDomPPzTfa0s9Dp+gUbPpqubu/QAVWSv1lH36RT3CquRclq1BkVLH4uwgVONM8A/dAFPrCxyq1RiqButPX6fqTBoIpxeQ5iCu00MLQ/VfV/EpTJvLVlwKo3eAgI67CatNaSm4Xb6gCHARKmF3jBQxUdqkVtAxXiqqvnE3WG8QvVy7P3iCx15zDqFObQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PA4PR04MB9389.eurprd04.prod.outlook.com (2603:10a6:102:2a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 09:02:42 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 09:02:41 +0000
Message-ID: <f68b1370-3968-5bfe-5875-26abf868a846@topic.nl>
Date:   Wed, 24 May 2023 11:02:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add microchip MCP3561/2/4R
 devices
Content-Language: nl
To:     Conor Dooley <conor@kernel.org>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.5ebab164-53fc-4492-bb76-5cc2d7b3f4f0@emailsignatures365.codetwo.com>
 <20230523124354.24294-1-mike.looijmans@topic.nl>
 <20230523-panning-surplus-b9072e18905b@spud>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
In-Reply-To: <20230523-panning-surplus-b9072e18905b@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM4PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:205:1::32) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PA4PR04MB9389:EE_|HE1EUR01FT062:EE_|VI1PR04MB9956:EE_
X-MS-Office365-Filtering-Correlation-Id: b34b0110-e2ae-4646-b3ce-08db5c35a708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: TDSNJcHn42AqOBnwJTQckCHogB3+vCSuCnxuzFZt0r0wRVS/5ADTsWjkr4YJQVBdQfJiOjJW5zG1bqAjHGRxEwYEPyQtASxX0nHT//Y2qsNIKWVxtjkUJcCV3g8FcxKvqAYn4Lf+5Mm8I8MXHui3fIJWiC3/kWG3GRLLMIlUxBdiRDrs6lawJrsha3B17NpRt125ufdIUibCr++L/vlxAOpWZhs5xWJs2+QS7u1ldw4eJbz/V5r6sWDcWYOiraKH7buPyLnATMxp9I5fj+ClK706wO2C3VTf/RjzfhAMcYqNZ5UEkHJZvVzWFBxpJngSyZLmSC5CWSVCQgnBCYFX8bpFE19IHaZGUFtu9/sDHglbtuuLrOSmAs864/yDX9Xnf/JoP8FuV8JTzUiNYFVK7+jPvTcTRL46PGwCF2rxEwwmAZB6kd39iKbGksG9+SZye78GfBjzIF/wb4h+tkkAIcPrcqkZ/91sTcE6ixNh/zT8g8rXx9MrGy99co95dfgLI+zXhVCtolngFOb3yvlP2vcdZafczVo1XcnaOYy9/HcTqhV6oqjlZi5dJQAn+GGrsR2ZadVdJoBVIdB+yIwock2/zJ/pfGf6+/RR+1AmkScXGjjim96gEOOoj8JgVUCI
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(346002)(396003)(366004)(136003)(451199021)(186003)(26005)(6512007)(6506007)(53546011)(7416002)(15974865002)(2906002)(44832011)(2616005)(36756003)(83380400001)(42882007)(83170400001)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(41300700001)(36916002)(38100700002)(6486002)(54906003)(31686004)(478600001)(31696002)(966005)(8676002)(8936002)(66899021)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9389
X-CodeTwo-MessageID: 4ad33571-200a-438a-99ca-6c4725148f35.20230524090249@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6846289c-d0c5-45f8-4627-08db5c35a10d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXdbvRSdPQS0Jo5wSgDJXxn23d+TwO9p+hqe2lz5I0EQHLM/l3HhzUz0lCD5UGazrlBhjhTtPA++I4wSa5tAt+nrfMSB/nSsaS92YN/Bon4Bt0xLUBC2aXkH0lhM+TA+A1PKdOJBbKgE1mVTYgCMLPk69svA27O6t7igt8R/CfmcN17WR2XnHRJJSE1Uh6wwexFvMPZToSQCds057Rq68UW2yOoivP+iorq0O+wQpQ6WDTyUmp0EJUBFdFvgbp0hdkW7hCTGedy+pLC7kY+9yGEzuOq1qr1V7GkJcfiB76a/0mHPpCsAwW4C2I1BtaazStcQezmMXS13TOaa9XirQOvD2Roj373X9GmyHyO5Eqqwr481HURD4SCmiboUjG28IstJS5oAd9LLK594Uk/0Mno+f9ZUy0zliBUJuplFZfvpL5bWlyS11TxVF+3Qvab5NiTqv4vbV6zZRwtTyrPtx3iTxjDcshxnaeak6W49jSMf4YB4A0a/1Gapuhxz1IY1zTEyvaJRdKVxj1DgOXP7kEMmPhrKyJY+ikNznZJA/5vIJSs7vApoQgLGSqin8Ptf67TwjYbI7mOdguj5Z/B4HpoGGSNjVULUEjDsb8r0/Bsdesh7Ca02O4yIGSIdLUfHFuqgS+vUXuTLSW6BGDjR3MF2zWf0HK8qXJ/JJdOQ2S3tgxEjKxeGYFLIBvpeRq0us30ejCP2pSrdyGnl36Rh1yokz72+aBDrqpWfnoOHq+d2fhGR/ccwZCGiQ+OHS35P
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39830400003)(396003)(451199021)(36840700001)(46966006)(336012)(36916002)(54906003)(966005)(41300700001)(6486002)(82310400005)(31696002)(316002)(70206006)(4326008)(6916009)(70586007)(8676002)(8936002)(15974865002)(478600001)(31686004)(66899021)(44832011)(7636003)(7596003)(356005)(6506007)(5660300002)(7416002)(26005)(53546011)(186003)(42882007)(40480700001)(2906002)(83170400001)(2616005)(6512007)(36756003)(83380400001)(36860700001)(47076005)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 09:02:50.4830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b34b0110-e2ae-4646-b3ce-08db5c35a708
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-2023 18:00, Conor Dooley wrote:
> On Tue, May 23, 2023 at 02:43:53PM +0200, Mike Looijmans wrote:
>> The MCP3564R is a 24-bit ADC with 8 multiplexed inputs. The MCP3561R is
>> the same device with 2 inputs, the MCP3562R has 4 inputs. The device
>> contains one ADC and a multiplexer to select the inputs to the ADC.
>=20
> My favourite - nothing for a while & then two come along almost at once!
> https://lore.kernel.org/all/20230519160145.44208-2-marius.cristea@microch=
ip.com/
>=20
> Would you mind, since he seems to have sent it first, reviewing his
> series?
>=20

Oh, damn. Want to, just have to figure out how I can reply to mails that I=
=20
never got (had delivery turned off for linux-iio). Tips welcome (just send =
to=20
me personally...)


I see lots of similarities, but also some differences. The main being that =
I=20
aimed at being able to add buffer support (continuous sampling, IRQ driven)=
.


Also spotted a minor bug in Marius' driver, so yeah, I definitely want to=20
comment...



> Cheers,
> Conor.
>=20
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>>   .../bindings/iio/adc/microchip,mcp356xr.yaml  | 84 +++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip=
,mcp356xr.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp356x=
r.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp356xr.yaml
>> new file mode 100644
>> index 000000000000..4aef166894c8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp356xr.yaml
>> @@ -0,0 +1,84 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +# Copyright 2023 Topic Embedded Systems
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/microchip,mcp356xr.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microchip MCP3561R/MCP3562R/MCP3564R ADC
>> +
>> +maintainers:
>> +  - Mike Looijmans <mike.looijmans@topic.nl>
>> +
>> +description: |
>> +  Bindings for the Microchip MCP356xR 8-channel ADC devices. Datasheet =
and info
>> +  can be found at: https://www.microchip.com/en-us/product/MCP3564R
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - microchip,mcp3561r
>> +      - microchip,mcp3562r
>> +      - microchip,mcp3564r
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  spi-max-frequency:
>> +    maximum: 20000000
>> +
>> +  clocks:
>> +    description:
>> +      Phandle and clock identifier for external sampling clock.
>> +      If not specified, the internal crystal oscillator will be used.
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    description: IRQ line of the ADC
>> +    maxItems: 1
>> +
>> +  drive-open-drain:
>> +    description:
>> +      Whether to drive the IRQ signal as push-pull (default) or open-dr=
ain. Note
>> +      that the device requires this pin to become "high", otherwise it =
will stop
>> +      converting.
>> +    type: boolean
>> +
>> +  microchip,device-addr:
>> +    description: Device address when multiple chips are present on the =
same bus.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2, 3]
>> +    default: 1
>> +
>> +  vref-supply:
>> +    description:
>> +      Phandle to the external reference voltage supply.
>> +      If not specified, the internal voltage reference (2.4V) will be u=
sed.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    spi {
>> +      #address-cells =3D <1>;
>> +      #size-cells =3D <0>;
>> +
>> +      adc@0 {
>> +        compatible =3D "microchip,mcp3564r";
>> +        reg =3D <0>;
>> +        interrupt-parent =3D <&gpio5>;
>> +        interrupts =3D <15 2>;
>> +        spi-max-frequency =3D <20000000>;
>> +        microchip,device-addr =3D <1>;
>> +        vref-supply =3D <&vref_reg>;
>> +        clocks =3D <&xtal>;
>> +      };
>> +    };
>> --=20
>> 2.17.1
>>

--
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl


