Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601446F7DA5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEEHS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjEEHSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:18:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB9417DD1;
        Fri,  5 May 2023 00:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEAX5lvorRYsROu2oasjdYRwtZIX46UnfJlbtmdFbawWCHCSndJzUcBVUdYVxOsa+m+dPSQYqtvT+htpeMBsxQr1huZ7dnsWMI7ScbcJeovhc/DyegYQ9mTu9YPGl207jPwErCAu3LzKRECCHTFKWVN6FkMptCcMkkCLi7IlbfhkrmuCA2vWq1TBIgRzPpB/mtZUAygELfKfFNJhzI41dbHEt3Xd4Z/lNt6Vz3kpeq2hH3FGa2k87BoYskeULae2IhJLo04j87bCZzqsCLYtMbSVflRSUVcyehYfrjRpreiqhD0zbPj4KkGGsBafXW1p0NT5wxRo6pjTZExMPPhILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSMNvwlsiM23dcPEgHFdf9KSyXsIKVYaw5r0TLXToTA=;
 b=G54fdhmZ1k4SJ93s27do6RhETlahzRVBsR4wmT5YMXhPYNZSf37xD9cOs+LAex6i2AQSefBWhNHU9FoeHpccqrdct+wdplpDh1JbV9NNIroQZOXtKVWTAC3WY4jhogQ54c8qpuaTIy2Md6+O/zdY+J8CXnI6GTb5XX6zper4JbZfSaVVLrgx5iiKdei8YYwZP4RXZcbBpdNksdj1MUcVvV42pghwlXqHteGrfN2gGaO58Ze7jnPhQiqCP8Jwtu3A8Vkjm6oY1vVvkvKw8rzZxGLNsOEc85HBh0AZsxM8UNik/MUTWrEWh4Co1wHPRs/zY9mGfecnhCxX0qnPgO0wjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sancloud.com; dmarc=pass action=none header.from=sancloud.com;
 dkim=pass header.d=sancloud.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sancloud.com;
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com (2603:1096:101:55::13)
 by PSAPR06MB4136.apcprd06.prod.outlook.com (2603:1096:301:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Fri, 5 May
 2023 07:18:44 +0000
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626]) by SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626%3]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 07:18:44 +0000
Message-ID: <c040c820-13ed-5a88-d6ae-6cc0c8d9a170@sancloud.com>
Date:   Fri, 5 May 2023 08:18:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To:     Rob Herring <robh@kernel.org>, soc@kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Persson <lars.persson@axis.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Rosin <peda@axentia.se>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Marek Vasut <marex@denx.de>, Qin Jian <qinjian@cqplus1.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
 <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
From:   Paul Barker <paul.barker@sancloud.com>
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
In-Reply-To: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AP8AHyYu0SMA73dANTyV024o"
X-ClientProxiedBy: LO4P123CA0306.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::23) To SEYPR06MB5064.apcprd06.prod.outlook.com
 (2603:1096:101:55::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5064:EE_|PSAPR06MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: a94ccc72-0941-40d7-3b00-08db4d38f543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DcOs9+eHF81TyrNDi/VZqatjWUA13QAwebIEBtC63N7yfExKuUjBZ6/WH4Zi4plorl8Sqw7cS9bfxj4HY0GAxNcC0+cUqTmuss5NOkc0GVBGx0ccn55D+Z+v0s4I7AoLIaEXJTFiGbKVfYhacbI6rtMqLlTlWEallt8kxG2dF2nLuEjFaff8Uq51FJhytJOIGKtAL/k1qLaenIv4Ct8l3kUyG6gILVbsJceBYXxcPvrNXPSR+dA6qn9OlGcRNc9xsPGu+7VFZOQtX2hBxoxvBw/kcfLIxHvOg2qWTG+1paNBoc1UDvtgOoZxeEZ72Ff8qYGBJtEPr9XSKntH8VEUI5RGQG9oCkx+AqxyehE5aOdr0ZkFKu8VAcdkBTstk/BT8D/IVykRCgE+rE2fHO6JWnLDKbweyfTRizNhJsx6iy0pm9I94NIrzdZZoSOUXk8EPalWPkwlmwDnr2js+J9/ZpCumkEGwQOz4RveVZpLXW3pOtFKv49Vi8wIbn/YR5yGBgkCaE0Ektmk2cYz05VtiYG8hT1ocxCRbCIGJA64UOGt+bXVU3SUZdsyWOCvd5Piqa8qw3I/5mF1T2Iv1wVmkLsp8v+KYRC355z8EiUWXXQixaeAEDuMtzGJTcw7TewRrKQSCF8libeTrXbpAZmnDVLCn8KDsPDY4OdPEJwkt2SVh2GOdwxF3oyVL+VhH3E9CRkq5Xtelr3EWwVw0RwAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5064.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(39830400003)(396003)(451199021)(44832011)(921005)(2906002)(38100700002)(5660300002)(7416002)(7366002)(7406005)(8936002)(235185007)(8676002)(31696002)(36756003)(41320700001)(1191002)(86362001)(6666004)(33964004)(6486002)(478600001)(6506007)(186003)(110136005)(26005)(31686004)(2616005)(21480400003)(6512007)(53546011)(83380400001)(41300700001)(66556008)(66476007)(66946007)(4326008)(786003)(316002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWlybGdrTlZGTmo5bSs3bm9jNnl6a0lNMDVnK2ZJOWxFRldNRFlCOWMwR0E2?=
 =?utf-8?B?dTBMQWhSUUY3QVRrS2lIL0FVMGd2cEVMd2FReWdmUUpHQWtuUlJ3VHBhUUk1?=
 =?utf-8?B?RG5CUTJ1MmhGemUyQVk3bDdxenhhRXlvclFVMFFRNWNDRVYveW15dmUyY3RC?=
 =?utf-8?B?M3VYZ0ZmK1FncithdnNZei9ONTBlcDRYMnZtK1pHQ1h0YXZ0bEZWOXhNbElv?=
 =?utf-8?B?TFljV081V0ZPZmN0UjcxTk1pZm9kNzBINGlYaXF4RXpXTFJNaHVYa1M4RS9F?=
 =?utf-8?B?MUUwTTV1V0duKzY3K3AvaU96M2VMbnZTWHppaFNGc3B3Wnh0amo2MmhpdENH?=
 =?utf-8?B?QkNVT2pjOFpwS0QwNUN0QjlvVldveXNrMUVIU1pVTFY1dkhtSWtrbHUxbmVl?=
 =?utf-8?B?SGtXVmlWRzl5NnpFYjhlZ21FMEIvOFh6a1htRCtsa0tNS1VWblNuMmRCNzln?=
 =?utf-8?B?cXZLNm0yK1Z2TC9YSFI2bVVoYVJ1eVJZbmNIY0tHM0FHYmpveHZMV1YvL0Qz?=
 =?utf-8?B?d0pseVBna1VBT21lOHM5clpndTA0cS85QkRINkl4Q2pJczdKK2NRbERJRzFk?=
 =?utf-8?B?ck1Jc2FkK2ZoZGRjL2pkdXJ3S1NicTBabU5MYkVIV3JMRHR1L3lmaWovV1lE?=
 =?utf-8?B?TDdRWml3a0kzYjdlcytCNXlkbG9Mb3owVkZZeTRZdVRNWXpvWGZXa05JYUJB?=
 =?utf-8?B?TXFMc2FWTlZ6bk1LNUxSbEpSWVZZSDl4aVZuM2dsRTJTbkJWcXJwaUpsaWhv?=
 =?utf-8?B?UGt5SDZDamc0UXNRRkJoc0QvdllrY1c5WUxhU3lxME5mNjIveEFxaWlCUnp2?=
 =?utf-8?B?a2JWUVNhMWRmejdYOWZ2UmNtV0V2THUrQ2ZQV08yY0pyY3ZZMFd6bXF5cDB4?=
 =?utf-8?B?T2lqWVdGKzJwZ3FaRkdSaFZzQVhqMnNzNG5oK0IyU0toUzRjN21vckVuWlpH?=
 =?utf-8?B?L1lQalFkUmRad05QQnUwOGlhZGNsZG41cjAwNGN0d09paUFDTWVSYWlwWGYv?=
 =?utf-8?B?cFhmcHFJMHZZL3FjYld6d3lqQWNzWHJJREpDdnJjY25YQnc5dTZhWFpyWkNp?=
 =?utf-8?B?V1Z5cFFwRnZEaGo4M0RNN2VLTVRxaFhtYVBtekIrZGEyUnNPdnNRbG5wTzNs?=
 =?utf-8?B?QU9tMnBSRG44Qnk0VVhDY1BLaWY2Vm5aUjVMbEJYVVZOZTlaWTNJYkF6b3RK?=
 =?utf-8?B?MGJDQlBlaTUyMEc3MFQ0TU5semN6OVZLbzIzY1cyK0owUDBBOW1Ud0cxTHpa?=
 =?utf-8?B?cDhoOXhkcG44eUVYbTF5QnlxQWZUemFEa2J3YmpHeW9pZ0UvVkJnc0UwZUFR?=
 =?utf-8?B?K1pmcmJPTGVpangwSEF4VGE0dWRscVV5R2M3VTF2UU84TnFQWnVFTXJKY2Nz?=
 =?utf-8?B?cHZ2QzZ2eTN5MjZ4UzRFSG16SVFkWmY2Z1pkN24rTzNUTDNaRy9SNG15VFFk?=
 =?utf-8?B?VFZESW5DS2g4MllsYUI5ZU91R1R4NE9URFFvTUtXUDB6VW8vQVZJRVNDNFU1?=
 =?utf-8?B?ZElhQjNPMEE3Z1JVbE01NklmTU1kZDk2bm5aczd2YXRaMUVyMWt5a2JxZUQ0?=
 =?utf-8?B?WHZ1dGVIOE1PSDVNbkZhZlQzMTFkSENQVlA4NW5OZS92VnhSSzQrbm0zdVhP?=
 =?utf-8?B?M2k5YnpsYWNVRlE3QmFFaGpSbXduQTBrTlgxRTh6a1hHZWIrZmVvejhDOU9X?=
 =?utf-8?B?cS9qTG41SXVEM3g4S242Q0ZRTmRROXIvcnB1MXpDYkJFVzlLZUluN0hxTFFF?=
 =?utf-8?B?dkgvT2pzTTR4Q0FncGhwdjI3SDNSVzdUcU5yOGVqWUhFczBrbHlidHZaMk4x?=
 =?utf-8?B?Y2RiVVlRMzFaN0NaMG5LeDhocE9DR3RHY2JiTXk3VUN4WWl4WVdUOWNTSHNO?=
 =?utf-8?B?RUJqaHgwNERjenhNOEptcmZsTDIvc1Q1TmU3TnpDdmhoMWlUTFRwVGlzU3Fw?=
 =?utf-8?B?V3ovRVFVLy9waGN3cjY5MzVGVGZhV3BhY1pWd0hFM3pJcDNCY1BxTGEyLzlJ?=
 =?utf-8?B?Y1JrSGMzM05IeWdYTGgzWTNzeUlZMy9Ob25qRWtlMUR0bTJUK2xBbHFtNHJy?=
 =?utf-8?B?NFB3Zjhla1JySTlkbWluWEpyZmFCWW5WVU1kK3UwSnFxdUEzUGdMSVl0cjFa?=
 =?utf-8?B?RWsyY2wzdGd1a2dwOVVtRHlkeURUZTRSSkhqSUFxMmxoeUk2ZGxFZGZHbXo5?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: sancloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94ccc72-0941-40d7-3b00-08db4d38f543
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5064.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 07:18:43.9139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e0f949f-6a74-4378-baf2-0abfca8d5e06
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3FTubwUdiiFMFs46Mme+rp+DA/qD9c7pRVLuTmfIygynN5wY0Edj3/D9vUSRhVRu/w4OLwGCQlW7f5XkZvDDv5wif9lZ+e0PxcTmmGHgio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4136
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------AP8AHyYu0SMA73dANTyV024o
Content-Type: multipart/mixed; boundary="------------SIxmAO397Vvg17zshwxyL0qy";
 protected-headers="v1"
From: Paul Barker <paul.barker@sancloud.com>
To: Rob Herring <robh@kernel.org>, soc@kernel.org,
 Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Masahiro Yamada
 <masahiroy@kernel.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <mani@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Antoine Tenart <atenart@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla
 <sudeep.holla@arm.com>, Joel Stanley <joel@jms.id.au>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Lars Persson <lars.persson@axis.com>, Scott Branden <sbranden@broadcom.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Baruch Siach <baruch@tkos.co.il>,
 Wei Xu <xuwei5@hisilicon.com>, Jean-Marie Verdun <verdun@hpe.com>,
 Nick Hawkins <nick.hawkins@hpe.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Lubomir Rintel <lkundrak@v3.sk>, Matthias Brugger <matthias.bgg@gmail.com>,
 Peter Rosin <peda@axentia.se>, Nancy Yuen <yuenn@google.com>,
 Benjamin Fair <benjaminfair@google.com>,
 =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
 Thierry Reding <thierry.reding@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Palmer <daniel@thingy.jp>,
 Romain Perier <romain.perier@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Marek Vasut <marex@denx.de>,
 Qin Jian <qinjian@cqplus1.com>, Jisheng Zhang <jszhang@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Javier Martinez Canillas <javier@dowhile0.org>,
 Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
Message-ID: <c040c820-13ed-5a88-d6ae-6cc0c8d9a170@sancloud.com>
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
 <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
In-Reply-To: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>

--------------SIxmAO397Vvg17zshwxyL0qy
Content-Type: multipart/mixed; boundary="------------BNtflzvK0q4xLXx01FZAN0yF"

--------------BNtflzvK0q4xLXx01FZAN0yF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2023 04:29, Rob Herring wrote:
> The arm dts directory has grown to 1553 boards which makes it a bit
> unwieldy to maintain and use. Past attempts stalled out due to plans to=

> move .dts files out of the kernel tree. Doing that is no longer planned=

> (any time soon at least), so let's go ahead and group .dts files by
> vendors. This move aligns arm with arm64 .dts file structure.
>=20
> Doing this enables building subsets of dts files by vendor easily
> without changing kernel configs:
>=20
> make allyesconfig
> make arch/arm/boot/dts/ti/
>=20
> There's no change to dtbs_install as the flat structure is maintained o=
n
> install.
>=20
> The naming of vendor directories is roughly in this order of preference=
:
> - Matching original and current SoC vendor prefix/name (e.g. ti, qcom)
> - Current vendor prefix/name if still actively sold (SoCs which have
>   been aquired) (e.g. nxp/imx)
> - Existing platform name for older platforms not sold/maintained by any=

>   company (e.g. gemini, nspire)
>=20
> The whole move was scripted with the exception of MAINTAINERS.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

For SanCloud boards:

Acked-by: Paul Barker <paul.barker@sancloud.com>

--=20
Paul Barker
Principal Software Engineer
SanCloud Ltd


--------------BNtflzvK0q4xLXx01FZAN0yF
Content-Type: application/pgp-keys; name="OpenPGP_0xA67255DFCCE62ECD.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA67255DFCCE62ECD.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
wjSllz6aOtP0BiQ=3D
=3D6e3J
-----END PGP PUBLIC KEY BLOCK-----

--------------BNtflzvK0q4xLXx01FZAN0yF--

--------------SIxmAO397Vvg17zshwxyL0qy--

--------------AP8AHyYu0SMA73dANTyV024o
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS7m7rT1+CktY3YG1PYN3IfEvob6gUCZFStuAUDAAAAAAAKCRDYN3IfEvob6qTE
AP9JTtaho33SU+lCAdHNDYEcDZ4DwG5xnu3wcslnZd8rrgD/T8WiR8HKjPMpPRbu1mNakNXvqzc/
q8xf+6Jc9/QmMgQ=
=/tzT
-----END PGP SIGNATURE-----

--------------AP8AHyYu0SMA73dANTyV024o--
