Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68A37128C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbjEZOnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbjEZOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:43:15 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DE110CF;
        Fri, 26 May 2023 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6pRiHgXT6kViPU0BoTz0O7YdMH1uBpOhWdP7UTxfiU=;
 b=DoRhp50OpS9r5cJnnXaEVt5oTti6w2ncqs2mYYYT/Yh8phzlm8mKZzhRauQqr8QxOfpgrl9Pv0gmTR0sZZQCNCC29/ae0ndWyMCvMTPhqDDvmK1aBXSHRVNr8CW+KzoM7DkTJBD2cUSaqSdQ+Eduzl2Ov7UOMHgorLsxuKp4wBpDKYf10AIerFohEasExXZMM0XlyqGQBG2X05YK0DA2a3+6iWj9xXS2poMz8VCRI8rhmtD3HxvppjA1k1QWqWPxA7xJeN8Ab2BXwQgKM0YwRFhdrVvnImnwXAl4HyKGJ7/cDdyz70Siz74ou5MpKDrM9HjOu8pFeFn6/2bYSqFcCg==
Received: from GV3P280CA0009.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::25) by
 AM0PR04MB6804.eurprd04.prod.outlook.com (2603:10a6:208:189::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:40:43 +0000
Received: from HE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::f9) by GV3P280CA0009.outlook.office365.com
 (2603:10a6:150:b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19 via Frontend
 Transport; Fri, 26 May 2023 14:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 HE1EUR01FT103.mail.protection.outlook.com (10.152.1.45) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.16 via Frontend Transport; Fri, 26 May 2023 14:40:42 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.112) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 26 May 2023 14:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UELzkOGVQ6ev179IGq263nRx9jdIrr/wzcW83BqVUDomdZD/T+Tv05GKkCdVd2InJniG2LHSS8TfQnl5hR4X9W5P++jotS6cAn3EVzQY2lYnTnw+b6M+yHFohgn5NCfCJylopTPQ+b1Plz580EHOM2RJFd4SPTOaNSjtolt/MbHyeBeNnH5WpuEL+KG8oqk8c5CGnY+yiK/0HRT4zkErj7SrYwsPeV8B4LgCJWFl4tzJLjp4jvVvHuOwmj1mbPLRcx2m0g1TLahDEVKfgT9puzzKTnu4NicDPtxVYi71jgDC54Dte08az2IZTNC/oads515K5+kJKg4ycXwr1la1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGjKRnrpiPRJOmy881aboP7WKM9gyyHf5Nd0xN/QCRM=;
 b=JYqrTNUYvKinGzsPEM+bvSafBx7YKjSY6jh4OA5W+D0G5P9hZPgpBfXyOseCZbBDxXg4LMxxN0KlbFCH+ILTD83Wg6G6KKDhcQikOEcfhKy7te5amBe1q8jnQBSckmOP0lweEr4uOPN48IRf8Il6wDuQ3BiH5KIIkr09+S3Q5uwdJheaoGHBBPA/JdCq7lGXYjtIaI/kPNKqEZR7YJTKaGwULdNzlrQ28ILpX0wxpbd5xVNxBDUFqEmnd5+wOzuS/YVeQ5jFfH2HLqQBcaXK/3/jblOSrNaFrrL1ROJ0RL86IKlkICYBuoo7pznRe9f0gSDhtxTCTISxW2rBRay9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGjKRnrpiPRJOmy881aboP7WKM9gyyHf5Nd0xN/QCRM=;
 b=Iky/bZglfhOdaCpHn7HtiByFNySfzZ0aZToAvYZEMl74WZ/aZ4LJ8Cv+VJRK2wQruyqHWbIWsofuTDWQFC9I6YYu8U5ijgtXo2MbWthbU2QnNISwLp2TJQCWodXIP/MvJLfuFM5X5d1bQEmeQwpGakdlYJ2Nbikoyf2wpHTCLZRj4LqzJdXbIjdmR1ahKJpk4EdXYEYJxrIIHBz+juUVryA0ZYMPJ1CDDJ6MwOHXwku1xGud1EQAKLDVvhhfuJuOTEOhPbQwfXVI0XeVkJEDlqcjcM8XxrZRtxBF6x9s5PqSpX/Vdvop3A/MpdONSiWskJTwUSlod84EpQNMVxorOA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM9PR04MB7699.eurprd04.prod.outlook.com (2603:10a6:20b:284::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:40:38 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 14:40:37 +0000
Message-ID: <36a04586-6faa-2da7-0828-aa5743abd9f7@topic.nl>
Date:   Fri, 26 May 2023 16:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add nvmem-clock
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.5f32aca3-00fd-424f-a27e-023bfb44e8d1@emailsignatures365.codetwo.com>
 <20230526140513.6943-1-mike.looijmans@topic.nl>
Content-Language: en-US
Organization: Topic
In-Reply-To: <20230526140513.6943-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4PR10CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::15) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM9PR04MB7699:EE_|HE1EUR01FT103:EE_|AM0PR04MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bce04eb-b4fb-454f-107f-08db5df72f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: V3p6HT6VXSzS6jI6zwJNNXpjpkc9mKdJ0b+JrZW9Afl7LGuwaP60dfMi1nyOa283C48+UPZ94ceBl6NzYYtLDMs39FF4gI9U501k/WisLqp1YGYkotU/3tqTOmKjyQLL0aaxP7Bhk4C4nJLazEEtJw0PLaQP2rFXqQfNqt7JmXsuSpoWeA/yiKtV+emNh1oiEb1ag/8a9zfKOJUOsU8SrWSttUBzz4ekZhVlGqlj4b9j5QKJCCjxTyIp/p6PXBqBKSstMJ7DZGZXTOV9Y9SRam2OozTWyXc5nFuNUW+TxPbQa+nqWxYplhX2ivmkWcYsOmIwXiuAHHZ898VBVjRXlDlGt61hJ2lZ+Me+CZPw2uKeB+/Y4I03TOecFdGv+GbXnPOf7usGSdqPoFc1foa5e2x98CBkB5frrpNrVNw0kreiGzQivY9ZoKv/r/v//e8vy8lbsAKg+CC5kk7dfgaMDPU3kXQa7PWhSD9IFzc6xW/AcFNR4fEhLUMTq7Tjs/+WpKHY0I4sgiqwfXBi8W/c7VndfjUkBpEVv7AhDNAc33Pi5e5k1N7AxBG3VgmD7f3Q2/JSJNPpGPqoG6c2xHDdJ5SUn6jP4E1BYM3/gsI/B0Ml1d7t+zVZFQBhs1k+psgRELDbeHekT9WzLz4BuCZQetmqsFveLQVO+ZC9BErin7s=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39840400004)(136003)(376002)(366004)(451199021)(316002)(83170400001)(52116002)(6486002)(41300700001)(36916002)(44832011)(53546011)(6512007)(6506007)(8676002)(38350700002)(36756003)(5660300002)(38100700002)(31696002)(2616005)(42882007)(83380400001)(8936002)(26005)(2906002)(15974865002)(186003)(966005)(4326008)(66946007)(66556008)(66476007)(31686004)(54906003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7699
X-CodeTwo-MessageID: f30258d1-5418-457a-9406-40687495782a.20230526144041@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4e21e8fb-8fe1-4d92-1197-08db5df72bf3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owtUu0ttnfjk4BTz52SOp3zn/VRQLHnoy/x7lHHuTrR3Sd3W+J0E/gYcB1p9r66T8vulTcdJNoCpe3tnwxcNI9xB2ThU5BcbUnJcDnDDXoxGGNC2q+o5P1ExbaobHj5IwlrCfgk1st11byO5lEoHKlMGtTTPstNgT23uIJSPVGTX4NO62R1iBplm17K4BFVi79rlJc2TMCUqxYwctQ3jVdFKs7PhftAuDsrsSaq+880HtEDL3a4foj2ERFi+tim69Jg64le+5BnwyeVoT8fH3WFv4jG4q+U3QWOgH/rbt1EWipBMz0ciLVKA8lIHcw+Q9GjhmDDEgOOXiBYlCPiU2YJJWmzpQjqCV5gebJrdm96ipokzm2DyPANDlvt3QEnamSrhK/GJM9mNBtvQqXn30JdEmcpXR9QtllxwRQmqYvmSruTuA1GS0F+xJ5n+EN2ZpuOg91prVQW2RSLPO73FCFWGu47z2q49TnPLXY5NcNALyvXLOI3/wRLTDmLHOAAcnssnBA4v5iI6CvXI4BqXppJa/U/Xozd5I9JrTotmZplbEh99SbpBHBYJ0tP4HpDDEGf6s/W/y77CWwPIl7zP97qb6klqaHJ9/BogoGREuV2VpmmfhC1l/kDO8NiQBHGbYCr0HbiaLglH1f/wzWEgfHE4BoawagthUV4Kghuk/1g1A4O5ZP+odxi2/l2ISoGk1m7QEPpJX+QpF7EbKUZTmXiqvdHnobxmDJ6QVZTz/wSpDEQTBB+IBsfyvsRKCcgjJ9ThzHxaoB1dltocnswX5w==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39840400004)(451199021)(46966006)(36840700001)(186003)(26005)(6512007)(6506007)(36916002)(53546011)(6486002)(83380400001)(966005)(47076005)(36860700001)(336012)(42882007)(2616005)(41300700001)(316002)(5660300002)(44832011)(8676002)(2906002)(8936002)(4326008)(70206006)(70586007)(478600001)(54906003)(15974865002)(31696002)(40480700001)(36756003)(83170400001)(82310400005)(7596003)(356005)(7636003)(31686004)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:40:42.8434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bce04eb-b4fb-454f-107f-08db5df72f17
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6804
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-2023 16:05, Mike Looijmans wrote:
> Add bindings for a fixed-rate clock that retrieves its rate from an
> NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
> or similar device.
>
> Component shortages lead to boards being shipped with different clock
> crystals, based on what was available at the time. The clock frequency
> was written to EEPROM at production time. Systems can adapt to a wide
> range of input frequencies using the clock framework, but this required
> us to patch the devicetree at runtime or use some custom driver. This
> provides a more generic solution.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>
> ---
>
> Note this patch causes dt_binding_check errors that I need some help
> with. It claims "clock-frequency" is a required property, though I don't
> want it to be, and it also doesn't like the nvmem entries, claiming they
> should match "pinctrl-[0-9]+". Cannot make sense of the error messages...

After hours of frustration I finally discovered that I accedentally=20
typed "fixed-clock" instead of "nvmem-clock" in the compatible string...


>   .../bindings/clock/nvmem-clock.yaml           | 62 +++++++++++++++++++
>   1 file changed, 62 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/nvmem-clock.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/nvmem-clock.yaml b/D=
ocumentation/devicetree/bindings/clock/nvmem-clock.yaml
> new file mode 100644
> index 000000000000..2e40df150b59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nvmem-clock.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nvmem-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple fixed-rate clock source from NVMEM
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description:
> +  Provides a clock rate from NVMEM. Typical usage is that the factory pl=
aces a
> +  crystal on the board and writes the rate into an EEPROM or EFUSE. If s=
ome math
> +  is required, one can add a fixed-factor clock using this clock as inpu=
t.
> +
> +properties:
> +  compatible:
> +    const: nvmem-clock
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  nvmem-cells:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Reads clock-frequency and optionally clock-accuracy from an NVMEM =
provider
> +      in binary native integer format. The size of the NVMEM cell can be=
 1, 2, 4
> +      or 8 bytes.
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: clock-frequency
> +      - const: clock-accuracy
> +
> +  clock-accuracy:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      accuracy of clock in ppb (parts per billion). Alternative for prov=
iding
> +      this through nvmem, the nvmem provided value takes precedence.
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    xtal {
> +      compatible =3D "fixed-clock";

Oops...

> +      #clock-cells =3D <0>;
> +      nvmem-cells =3D <&efuse_xtal_freq>;
> +      nvmem-cell-names =3D "clock-frequency";
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



