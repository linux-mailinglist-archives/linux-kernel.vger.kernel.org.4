Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991A06F837B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjEENHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjEENHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:07:51 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2132.outbound.protection.outlook.com [40.107.247.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCBC1C0F3;
        Fri,  5 May 2023 06:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAhkOpbtl2uQ3PtHxk8PSq41hrqgFgZJbrcNCVoHFXi7Qxj0FTHvFaNEhmJQw6ZrboDLwKViejLkXNclquTuYBId0G4Tgv7p/Gi2j5mL0zEgIBcCr+URktXyXmCh28kRyYZIjNeYCvNDGOIOAy3VO78vsXmJ1PdNduZDokVkYGaHAriX8pqRbrt4v/IuWtQl+FfPqmD/XaBh0SyyUy+1C+Bv6IC1VCaHCq4rrD+p8xz1JldNHUJyEOReJBRjXG8hGXGh7zUaAM1LIaX7Fw/+fROidoxY+7DbL2kzO0RXjElP3GP1NlNhDYzQmBJsgFuJQfaSIt2yyyMACI2cMB6y9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjlHQ6gya/7engP6BQxh6YrtXx6xPFgKLPMBs3iw9ss=;
 b=Jh/B2ceNm303m/vvs8b8tTJR1MMrU0GxHC8j/8b8mSg4S711U3k7lGoZfsfdUciz5e7hPMkIquEExCbqLmbuQAgK16KuHfi7QfWhEA7oNtrQShTE8JgsNUhARJO3QaEJYiMqLy7ZWfyHcqbcrsGTZkjzmQrfV0vXQpCrbl9QLPmGl75FHQ7QnJhe/3qwYqvlxQeLi1UwequvwmPSwpIo9lcUW/PQ2T7qjczz+cfTfNurUh86F4dARnn35dT89ndPYTYAgiTUPKVbkj/Ji/LbvAJKX94uuIg3HpUdt7Vw1Zh2/Uy0dRmHMu1/E5lVGsGry3cOb02DwSUyptpa4Fxikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjlHQ6gya/7engP6BQxh6YrtXx6xPFgKLPMBs3iw9ss=;
 b=I9cBe9u5kXwuVJJn3x/jPoZLtIBJjy9AvzKISUd5NZ878Qxg8CgIuWM/hIuLbS8kn9+R9YO2Ltsof/J3O/Op7cX0nul5vhX6JusiSI5wGs14aLOJamTcI+Y3cmLaYXzuTEgCkk8HOyAqN9XMzUz25YKIAo1GQeGOPgoUkZNp7M8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB9PR02MB7916.eurprd02.prod.outlook.com (2603:10a6:10:33b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 13:07:46 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::3d67:4b0:82d5:1daa]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::3d67:4b0:82d5:1daa%5]) with mapi id 15.20.6363.021; Fri, 5 May 2023
 13:07:45 +0000
Message-ID: <cad21f29-3eea-9fe5-3146-6ba394db8f8a@axentia.se>
Date:   Fri, 5 May 2023 15:07:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
Content-Language: sv-SE
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
        Nancy Yuen <yuenn@google.com>,
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
        Paul Barker <paul.barker@sancloud.com>,
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
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0100.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::18) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|DB9PR02MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8cba9c-ab55-494d-525a-08db4d69b7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1t2cF17WaZQTw+dLqOJ0bGBjENEVOTp0tYNcUEDYCqczTSgnDySjzaG3+uxHeeA0asDdJjEs/GGunSCQKEn9Sg3A5WehqPzCp7fxbys1uN8fQZq+cQGQMbAtzJo81JDxcRKzDsE5ZZKO9MNAByJiuNSN92jAiH2JxGzCYyZ2dGwkxQynpnjEbj4R3bKy8FsL5W62MSb4pn4NIB5nS6/EnU35mw7k5RTDqysYajX7yg451ZNmd/01R9C4TQnb0Ixti/eKhtQ+GEmQYkpsuevqEWIrJdclcYUHlTZTIM/OKQ1L1wQ1GcBMkf7z4FVlA24AImPAFKk5Qf64TH2uzb+ZgKkt8YtRRx3xVTTipDiyG50f3keiY5i/+R8AVAhsmiB4fdQb/9EyZ+C16+KwJFE9IHm+HS4CDKRc+1m91anWAq2lsrDX4pIk/qnZi+hxF8BFLuETBSl8G7KT0e2Zjo1Q9EOSXvASbZ4KSFDpWsmzgJv6vs75+5j0cT2OViBxF/GtwIWZxCJAnr9Gd5+nrFnsxsn2NMC9QBftlfbyVXR1SK5qSFn8iLuTTW5BQLreGP5TzXXPORIL1vdhVKEOiqtyn+VHOj8knV/tFTiCMZ/5iqu9S/9AOSWM+Mshzhg4xfCr457LvoAf3LKz2f8MImJwtU/Diil+w68PuI4jf45al0Gb16rWkzbMSF8z/HnDvJB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(39840400004)(366004)(451199021)(83380400001)(186003)(110136005)(478600001)(6486002)(2616005)(6666004)(6506007)(26005)(6512007)(1191002)(7406005)(7366002)(7416002)(36756003)(2906002)(5660300002)(38100700002)(66556008)(8676002)(66476007)(41300700001)(31696002)(921005)(66946007)(4326008)(8936002)(316002)(86362001)(31686004)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRiRkg3T2lVL3drMTZuenIxQ1FJTmZIY3pmV2FBQzJlTzFDcGlndyt2Qmdh?=
 =?utf-8?B?NHJscytTWWV2dVo5YjZoMk9RQXdQVnZhY0VrSXVORzAwRFVmTFhweGMzckhk?=
 =?utf-8?B?QXNSbzhzaUpVSHRNdC94RXYvUlRsZnRXMjE3ampSV2h4alVUYjFtZWI0QmRz?=
 =?utf-8?B?UHhZc00vaE1zZWRJNktVc1M3STRRb2tvVFRKMm12R251V1FmTTdOVUx5YXUr?=
 =?utf-8?B?cUNoMWREY1o1L3NndGc2YmtRekdHQzZRTTRFR3k0TDcxZGNQbUM5WDVGUitY?=
 =?utf-8?B?d0trelRIRnV5TjVwYXloZzgxYVBhaGVReHA1eTdMVGZKYnZnQkNqRER0amlH?=
 =?utf-8?B?bFRzYzZZNFVrQmNXYXB1ejJwcGNZQU0vRXBXUWwwWGdTU0Q5STBLYzZLRjE4?=
 =?utf-8?B?RmFuZWQydzBoWTNYUHhicDRqYXBCcFNOVTdSTjZBdWV2ZTlJNlVteFIzbStW?=
 =?utf-8?B?LzVad3lWR24vd0FpYVN2YzNldHpKYmVNcEg4eDljODZha2E0bmlCMHg4M21o?=
 =?utf-8?B?QU5JdVJuZUJ1TzduQmtIOU1HMjk5cHVxb05DNHhNRkNWbWdMWksvbE4wbHJ0?=
 =?utf-8?B?dkVudE1RbXJaL2FTOWxvdmxLdkFXMXo0UzU4YTVBSFFmcGMxSUlla2Jwanc5?=
 =?utf-8?B?eU5IMi9TbyswbklmcGIvM0FMYzc1STUrZSs1Wng5WmtvTXRMU0pOV2wrdSt4?=
 =?utf-8?B?MVM5eTdPaS8xazJJcXcwMEVFNXJSemNzSW12TEc2YlNibU13dEFSNk1VREk5?=
 =?utf-8?B?TEE3VUlXV2Y3TWhmdEpBSkhYQWNwVXgxSDEvb3FDUEN3TnVwUmtrN3VabEls?=
 =?utf-8?B?eG9CTjZaN1BRUEl6c2NiVzFETjEvSkErWFNEdTZaSm8zU3IyQmczckNWY200?=
 =?utf-8?B?WXNvUlU3c0ZPQ3Q4NWE5cldrS3gzZnJpbkVkTW0xV1FTZjBaT1FDVGVwbm1N?=
 =?utf-8?B?OTg2TWhCM2h1UmtBUEhxZU9ESWZSQ2ZycmVuVEN2YjRVNDAwQys2NVRaYkpV?=
 =?utf-8?B?K3BFU3crb2kwNEc0Q3VvVFZIdENyRmRkU3VnOFJJcFdWeHRsNmNaT3hOR2hz?=
 =?utf-8?B?M3VnVDBXT1R6ejgzYys4cExFV3kwVTJRRk5RZHVoSTdKL3MwNHhuanN1NWRy?=
 =?utf-8?B?cXY4b1FGN3BqczRwYlYrNXNYZEw1Zmo4Ly9SVWM2NzVZV0Q5Y042bXhSeXFq?=
 =?utf-8?B?bVNjdTdRZlhSV3JpQXpJNTdXSStWNnRBdnBFaFowNGoySXBhaWhkc0hVdEx6?=
 =?utf-8?B?OFM2ckNGRmQrYUZqbFZPRDEzbWYwUTBoQklRd3FHSEM4Wjc5eGVwQWprcHpn?=
 =?utf-8?B?NjYrYWpEU2ZOZWs5WFpLNisvR0UvZ3ZyUVFINTVoSkhMNXBKUHlNRjlHdjAr?=
 =?utf-8?B?a04yVFl2MWlHTnl0QTNnSzRPUUtRRUgyWmNDN1BNVlpnZEp6RkRCS3l3SjRB?=
 =?utf-8?B?b2Q3ZkhsYVBRck9lY01qRUNpR0R0OVFHZWFQaFBCWk5xYUNPYnNhZFVUb2w3?=
 =?utf-8?B?NWRCOEd6SHo0WG85T3VzdUVtaVdXVlJWVGMxR3BjdmdMSXIveFJMTmVDbkFl?=
 =?utf-8?B?RTFkQS81TGh1V2pYS0R3dGt4OWJqcDhMdW5KdEwyTFdYOVFqSnl0aVNtbVpX?=
 =?utf-8?B?N2Y3T2ZqR0JRR3R1anV5NzBHdzZDUDYzRG5BUmN5MUlydjZlbWRtdldiaG1m?=
 =?utf-8?B?eXpaV2N3RmJBT0pIOGFjM3AzNVVtWWVKbVZCM0dJMVFpamZhOU5yTkV0RFJG?=
 =?utf-8?B?MlFNV2J6aHFqNmNxSVRNckZsR0dwd1pKNldoY1Z3OWt2MktHK2FiQXBQckZL?=
 =?utf-8?B?YkVteEkvMkxTcURiNk5JWnRzZTNhN1V5dTA5aW5xWTRlTGNOUGdIREh1OXFI?=
 =?utf-8?B?NVBGZFRXK2oxSVFWVjBvREFMeFlPMnZRSU5zRVdZU0FzMWM1RTVpVVNWaUlI?=
 =?utf-8?B?bmJuYjB1ZHljZzFRMWVudXYwc2ozNTBpeE9VaXpNaXZXTnBEREtUSDgxUEJZ?=
 =?utf-8?B?bVNaQTVBc2xzSzVQVEl1eXo1SWNaZkx5TFRETmZma0tOZDNySkQvZEV0S0Za?=
 =?utf-8?B?TlZuV1BDVUVmSGRzVzR0THRHcTQ4NWJiM0lZdk9NQ016Y3R2VXZXa2ZZbEQz?=
 =?utf-8?Q?aGCBJpE2xTUnoIrwRfixBIfQV?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8cba9c-ab55-494d-525a-08db4d69b7d3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 13:07:45.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wbZyS5+WXkQG2bjroa5mc2lO1IKex3hXFyeb6G5jBEUp+DeOEFSd2+Yr01CyNkx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7916
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-05-05 at 05:29, Rob Herring wrote:
> The arm dts directory has grown to 1553 boards which makes it a bit
> unwieldy to maintain and use. Past attempts stalled out due to plans to
> move .dts files out of the kernel tree. Doing that is no longer planned
> (any time soon at least), so let's go ahead and group .dts files by
> vendors. This move aligns arm with arm64 .dts file structure.
> 
> Doing this enables building subsets of dts files by vendor easily
> without changing kernel configs:
> 
> make allyesconfig
> make arch/arm/boot/dts/ti/
> 
> There's no change to dtbs_install as the flat structure is maintained on
> install.
> 
> The naming of vendor directories is roughly in this order of preference:
> - Matching original and current SoC vendor prefix/name (e.g. ti, qcom)
> - Current vendor prefix/name if still actively sold (SoCs which have
>   been aquired) (e.g. nxp/imx)
> - Existing platform name for older platforms not sold/maintained by any
>   company (e.g. gemini, nspire)
> 
> The whole move was scripted with the exception of MAINTAINERS.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

*snip*

> @@ -3404,10 +3385,10 @@ AXENTIA ARM DEVICES
>  M:	Peter Rosin <peda@axentia.se>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -F:	arch/arm/boot/dts/at91-linea.dtsi
> -F:	arch/arm/boot/dts/at91-natte.dtsi
> -F:	arch/arm/boot/dts/at91-nattis-2-natte-2.dts
> -F:	arch/arm/boot/dts/at91-tse850-3.dts
> +F:	arch/arm/boot/dts/microchip/at91-linea.dtsi
> +F:	arch/arm/boot/dts/microchip/at91-natte.dtsi
> +F:	arch/arm/boot/dts/microchip/at91-nattis-2-natte-2.dts
> +F:	arch/arm/boot/dts/microchip/at91-tse850-3.dts

Acked-by: Peter Rosin <peda@axentia.se>

Cheers
Peter
