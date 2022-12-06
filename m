Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928F06441E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiLFLLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiLFLLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:11:14 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3900124F17;
        Tue,  6 Dec 2022 03:11:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apd4RdPcMP1Z6qeVNFR9vleLtdbf7ncrNll4I/rKgCJucSQ5wtGu3mQp4Lw/nPWL/yfPwgWPTI0NvWsocMn6VGuTGE3fVBstQ2CEA50gsitA5NpQH3eTbBW2zPy/9Hqy/O679tw/n6Dlr8+K5Xjfg4BBhbHESywDkK+UncTobP/pMfrOuUBE1nl62bvFI2Ym5YssGlxeI8ncXT5ARwKFa3RA0DU0D63rbsZ0a5//OqoXa5etbaBDrYDd8GZmubxnB8gQjoPkHv3F55EnGdVq/qZZdvC9NstFshgTNW9cdVAQNL4SmdCQm6GYDZ1JLRIyPlx7qLxB1kVawq1AMQjfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9JxxRpT5ZjSIIGphlXLZuN0R4MVAgo2M31KkD+TE6Y=;
 b=RNfqfTZ/M6J3gE1QGXs8s8Y1NJFugCkhS9StOy09FUyPcDyO7DWOzL0nKpAC15/jf4aS/eQamQo+KfDp/u0L1pA5N6HaZhw5tUWQfQSW7PM4Bh8WBbE4ybIloK8hvPfLKJCiIiOzKEUefINM79R/jqXe76o6CwpVTghVgC1NxX+OYkPi7YKWkAyBgxCphCHS0MCA7JTcX6CUIXRaKN7Y7HbcSycRUoX7yIhSw87vc5Ic/qIY39xexpeS3nthaDPhWxns5p+asczN07Ah3+xdv7xSaMA4fm/pOIYMTG4S9sG2IuAT9whtfNI/4TxvqcaCGDm8dBhyvI63/o/5HuFwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9JxxRpT5ZjSIIGphlXLZuN0R4MVAgo2M31KkD+TE6Y=;
 b=OSRWFDpBjiDfTyt3Fg7sFH3pZLrkBCSOt6MYZw86ixYDjk6B3wFHrpIDLZM5SDRwLvXsuZyPtWAoCpDHydD4LLODkaP80AAvOuMvBHL8hkOzMkLZGElZBfNI9wXga/t096feGKTmQnh8V9YwylyaCEXHvbrr+Et+KpPCS1AIDea7cgqoLr+U84VZjT+fjsnle1K70DPBQURGEwzb0ET91Jh0WL0dFGgvdfTyrWka4JwNmCM2T1CcW6QLihCBEK5LggofdpIYn2rHl2U7yTZnsMG1N5D6c5X7X+QpIkpkJXRLypGFd6oIezpBBhh19tzk1TrKSm9uTD3S22YR5RrbjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8782.eurprd04.prod.outlook.com (2603:10a6:102:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Tue, 6 Dec
 2022 11:11:10 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6%6]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 11:11:10 +0000
Message-ID: <cdfb3f44-4400-1386-42cb-0fb7b30e45db@theobroma-systems.com>
Date:   Tue, 6 Dec 2022 12:11:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 6/9] arm64: dts: allwinner: fix touchscreen reset GPIO
 polarity
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Angus Ainslie <angus@akkea.ca>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Andy Gross <agross@kernel.org>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        David Jander <david@protonic.nl>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221103-upstream-goodix-reset-v3-0-0975809eb183@theobroma-systems.com>
 <20221103-upstream-goodix-reset-v3-6-0975809eb183@theobroma-systems.com>
 <a0c767d5-eb55-3479-c4bc-1029809027f5@sholland.org>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <a0c767d5-eb55-3479-c4bc-1029809027f5@sholland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 2350755d-186f-424e-4132-08dad77a93a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InTMHXK/3YCgTEtNZoYwzxu+ubsusGgyicnm4kK9cra5L7Qn8YAs8Y1iHC99nya1vUqQhp8ldGspvrdBYohPz4TRA0p/Hqj0QoNo6RNzEgnjt/5Zff+TMuRPWdpifj+L2cvFt6WOJn502KQzoQnQsCgrjiF/NBdcHZygwBMQ9yoDXKN83dMyS/SQjSjMX7ITqhhHvLmGOgBjgIuw9rpR74NpU/Ir7SiOw7EnmWS4xYkjyDWcbjayf1+nuYWq8WtlU95mFrxTedHVgL6fFLTuOQ73Eew6+4rBiwrA0xB8gCkAKKrLnuZq16Qp6xgXgDeeXHXKukM63EDCs5LgFFr74KPV/LFJODyBf/UZtee+5gTVAwMR9Oro1pjq2EUoH2gTynZICbKDHJvCG2++ui/ZDfnW9nt4SESGUwDqVi54sTHrmFjjpw5KEMtmTUg7dsimRYi7cyX3mVSEP4ODFnOj7LEVZp4CEwjOcu0oRNRiFId2zwcbOUWCBP6yN4kkqOx+qrWxHvprXsas+ngO5vC1UVlP++c6DB7ED2BsCfhRR0rpQt5IdjVhF5dbtWd0+y6tQ6AzIvjcNBxdk0ojE7PVMtjjxzjNqjaozE5++2vCq35qgwmpj45yhhNRL0ZxUmVdBclVKqMybpBwahPeLnh6VlIM9fCSqao9TC5iEqcTBuNxGAGzwzSxnAsVvJhUbOxYH1FJ2iFfMVwVlobgDJK+HLcJNUoz6rxesO73C19k1no58Lgfr0b2PCF2NvahU/MIJBYCzTnhPuEfizyUxObUew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(396003)(39850400004)(451199015)(36756003)(31686004)(7416002)(38100700002)(5660300002)(86362001)(31696002)(8936002)(2906002)(44832011)(41300700001)(4326008)(7406005)(83380400001)(478600001)(66556008)(6486002)(54906003)(66476007)(2616005)(110136005)(316002)(66946007)(8676002)(6666004)(53546011)(186003)(26005)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1c4Y3lMMDFLN2RSTjVKdkQ0K1F0Y2oyekxZUTdaeXQ5VGVqOXdsbXlUUWkr?=
 =?utf-8?B?NDZWTnd3clIzelBBOVVlOVM2KzkyRTlITkhrUmpLeFB5eUZRYkczMnNFTFk5?=
 =?utf-8?B?UTVaTWlNemtyNXBLakQvaFEwbC9HWTlRTHpTM0pKZzZOL3dxUHUzZEZjcFVQ?=
 =?utf-8?B?bzA5STFLS0lGMDdlTkpNOWgxbnRWcEt1QUdEZndod2ZLWEtOaTVjL2FzZUd6?=
 =?utf-8?B?MHQwUERPT0lWSE9tb3ZpWlJOM3VZdG4yaVFoSGsyckdKYzF6ZFBjbkhLL1p2?=
 =?utf-8?B?VlFzcXJZMHdrb21aaURGSlRtWWZSWVNaVkp4UVpCL2hUYTBYT3V0Ump4YWtl?=
 =?utf-8?B?Q0JNNFBadWZvNzZEdnp4TWtlOVh5bVFSWFNlWXVqNDFlYWNJZXptY2MwVDRG?=
 =?utf-8?B?Y2hRZFUrcFpXY2NnRFpZbGVJSEJrUkJDTTI2cHdYTzVGdzRFV0lGbkdIY1Qy?=
 =?utf-8?B?VHZ3anVvWWVmaGVNdTVlSEtCa291bDJtTS9naUdoUDlpc21rTm1nejRwOCtP?=
 =?utf-8?B?d1ZEQ21lZFdVOGNadHlQYW1LR1FqSlNUMnNEOVMrQzRzenl1K2Y5YTl4ZENK?=
 =?utf-8?B?bEd5aXVRWnR0VjQ3NFpwQW51YUE3NDFwaytlR3FIQ21PWHFYajVJc2xRZVcv?=
 =?utf-8?B?OHZra2x2TFFxQkZtSkRpdVJKeGVJVnQ3cmd6LzhGZytSMlZCZUp4VGIvSmVn?=
 =?utf-8?B?aEI3N1VrOHhvRVkxTHE3Q0xXalZkVkhZMnptd3d4bVpxbE5SS1ZpU0dxYkhO?=
 =?utf-8?B?Z1UxLytoa1VLcmdEY015QXpVYTJKWnBGRFBnU1JwcEpDamMzZVlJZHdwT1Bx?=
 =?utf-8?B?LzV4VHhIQWFTc0hvZi9WeDN4TXQ4NmFCTENDSjJkNi9PWTk1aWZDVVNyemtt?=
 =?utf-8?B?b0xIQ3ZvdWlsdVVLY0YwakNjV2UrR091cE94a3hNYWN2eXlERXFOdFR3d1JW?=
 =?utf-8?B?dDdVRlVadXZvSXdEQ1p2andqUDNkNkd4czI2YUh4VlVmWlQwN1prMnZYWXIv?=
 =?utf-8?B?N3J6cytoeVIzeHZsL25qQVZTZ1hEdHgwYmU3bFBiT2dSL0NtOFpST1RJQkVE?=
 =?utf-8?B?RHlZRTJSYUhEa3diQm1hVHhGSjdzRTdkMzkzTEZ3UExwVkUyWHJpK2JIZHBa?=
 =?utf-8?B?d2hEOFBQaVl6VlI4MXM5RXVBbFVwRnlwdmlCWUozTTZaZGpSUUtPeFFVcWpG?=
 =?utf-8?B?anpOeDVHVTF1LzZnVDMwdnArTktjTHZSMEx1WVNkbUxiTUEzYkhpclFiQnQ1?=
 =?utf-8?B?UlV1UllyTWJrWFFOYXQ4L1lZcTdsRkx4L3hIWlhsemE0NmhpcVBoTmxlZ0dj?=
 =?utf-8?B?Zm8vM2NFRy9TZVJ5TmFKQzRMZFVVbnZ2YWhUdmttMVNjOWYrMFYxR3NiYlhS?=
 =?utf-8?B?SEtNLzV5R0w1WW5PYllEaVJUSEI1QU9MNGFvNVBrUndBSmJLQzdMRDFDa2hB?=
 =?utf-8?B?QnNOZ3RQczFoM2IzSm5KNWROR2pwODFCNmJ6SWM3ZGVVNTlQeGFzSG1vY0E2?=
 =?utf-8?B?M1M1Ry94cDNuWGdrSWp4SlgxRFZmYks0SmkxeHU2aEtsQ2tQT3BhaVRQOUZp?=
 =?utf-8?B?cnJHYWIxdVdmMWV1Wk9PUWN6NE1JeTlOOUxRa1hSc016c3diS2pLdTVhRGZx?=
 =?utf-8?B?NUtaT3BtR1BzenNZNUpSMEpvdXhkT1VYK2tYUjVRL0RHbFN5d29IOFd1Yklx?=
 =?utf-8?B?ZCtSSEdnbUNuMElERFpNbjNjaC9hU3k3dUtmTmVFL0RTMkNnTHpvSlc3S0dq?=
 =?utf-8?B?QXEvWUVvcEJETFF2WEJwOXBJMkRmN2Qxck9lTURqcTFueUo5bWoyaTdqRHlH?=
 =?utf-8?B?UHd6SFlCQmVwM1J2eEg1RVhKZjZHSm5XN052SWFzb0phaWZxZDM2c1BtTnpy?=
 =?utf-8?B?YXRra05xQWF3L0JSZHFsbmtXcTZZN0FiWHhLVUJZUDFzWkkwUVJDeThuc3Iz?=
 =?utf-8?B?RlRUOFdlY3pTbVZYa1dFYTg4aTE0cFFVTHZaM0pxUDVwZUJQbVNOcm5wa1hO?=
 =?utf-8?B?ZFFSME9kb1ZOaVZnb3VMb2lCNU5wUmppVHhObmhjMzYyVHp6WmphZkphSWpM?=
 =?utf-8?B?d0duTy9yeW1uQm11bklCMVI2L0RhV2RQZ2JnVlBpaWtCT1VaYWtIM1ZRUXdt?=
 =?utf-8?B?SE9PUHZrYnZXTEpPVWFMTUttK3Ewam8rQTl1WksvK3ZhaTRyenZBREdSQ3VZ?=
 =?utf-8?Q?qNpVdXyRlIeMGoygxcS9icA=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2350755d-186f-424e-4132-08dad77a93a4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 11:11:10.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNRvWMEsLAtxPQRO+hbxmMA2rmQb0iupD/UqJ+5tURePBEcAU7Y3W6Bmy7tEnPcBgPMYgeagLPqbA37nXVpTExqpdqWSbYKbRwboWSDNQHle0M54s+mxEMhYgz6K3eLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8782
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On 12/6/22 01:26, Samuel Holland wrote:
> Hi Quentin,
> 
> On 12/5/22 07:40, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> The reset line is active low for the Goodix touchscreen controller so
>> let's fix the polarity in the Device Tree node.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>   arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts       | 2 +-
>>   arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts | 2 +-
>>   arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi          | 2 +-
>>   arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts             | 2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>> index 8233582f62881..5fd581037d987 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>> @@ -122,7 +122,7 @@ touchscreen@5d {
>>   		interrupt-parent = <&pio>;
>>   		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
>>   		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
>> -		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
>> +		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>;	/* CTP-RST: PH8 */
> 
> You are changing the DT binding here, in a way that breaks backward
> compatibility with existing devicetrees. NACK.
> 

Yes.

Some boards will get their DT binding broken, there's no way around it 
sadly.

We know already that the PRT8MM DT binding was written with a different 
understanding than for other boards. There are some board schematics I 
don't have access to so maybe the same applies to those.

A reminder that even if you got your polarity wrong, it could still work 
in some cases (timings right today but nothing guaranteed it'll stay 
this way forever).

with the current driver, what I assume we should get for an "incorrect" 
polarity (with GPIO_ACTIVE_LOW) is:
             ___________________
INT _______|                   |___________

     ____________           __________________
RST             |_________|

    ^
    L__ pull-up on RST so high by default
         ^
         L___ gpiod_direction_output(0) (deassert GPIO active-low, so high)
            ^
            L____ goodix_irq_direction_output
                 ^
                 L___ gpiod_direction_output(1) (assert GPIO active-low, 
so low)
                           ^
                           L____ gpiod_direction_input() (floating, 
pull-up on RST so high)

This works because of the pull-up on RST and that what matters is that 
the INT lane is configured 100µs before a rising edge on RST line (for 
at least 5ms). However, the init sequence is not properly followed and 
might get broken in the future since it is not something that we 
explicitly support.

With the proposed patch:
             ___________________
INT _______|                   |___________

     ____         __________________
RST     |_______|

    ^
    L__ pull-up on RST so high by default
         ^
         L___ gpiod_direction_output(1) (assert GPIO active-low, so low)
            ^
            L____ goodix_irq_direction_output
                 ^
                 L___ gpiod_direction_output(1) (deassert GPIO 
active-low, so high)
                           ^
                           L____ gpiod_direction_input() (floating, 
pull-up on RST so high)

This should work too and does not rely on some side effects/timings and 
should be future-proof.

The other option would be to only fix known "broken" boards (e.g. 
PRT8MM, maybe others) and specify in the DT binding documentation that 
the reset-gpios polarity is "inverted" (that is, the reset is asserted 
when the reset-gpios as specified in the DT is deasserted). This makes 
the DT binding documentation **implementation specific** which is 
everything the DT binding is trying to avoid.

Something needs to be done, and no solution will make everyone happy.

Cheers,
Quentin
