Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67F6EC379
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 03:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjDXBqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 21:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDXBqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 21:46:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7916D10CC;
        Sun, 23 Apr 2023 18:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtIz0ch4AZUmgNW0iyakDU78Pqh04TVw+L8kMCq0R9oJnlTlHSDm47bHjbjT91hds5RzTwK8vZc3djtBl5LAgoZGdeZTc8VevVwMJjJCNlW7u02FSHF8eJgaFzJ5n6rxKD00EpPPo3+msGoj5zqOFYgXTTrj+hw6TcXx/gHpmkGdUxu7djBcWOfyHCEmv0BvCwqUFbajC6aNx0w5YOSkE1zeaQqrxF/ouMj9WJ8SkQE0E71hdrNTRPVGOdKA0xWhLPkS4MsDSozNmoeDwxr5d48q17N5XkahBSJaOYHV/bbZYHU0637x+aioBk1tlbAqDqcl/+j+9hFO304gB9ec0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMa3kphUlV54DCdqGM/pYA0lehNHEurQiTvONkMt/q0=;
 b=GCQHNZSGVM2oNWKWN6pwUGESSRGM14a/POObc12jVdYztnrw8jQ6H7WrHy5JsXzd5YMHrl6egd+IVvLOTYdYMzLol97f1gkAM/9rdnN42qnGee3v1rmXbu0SbTaK3dj5e4EaMxNRsfq+nu/p+WkmrPYWD7upToKWTMRzyrLyw+LCEHNIGtEvFStieeBdoF3TI9YVlOJY7bOoqPCRM3rYDt+4zRUsOUNED/phs6KXRf1H3fZFVU4lDVPT+YyQbS7Exu8zJo/nBH0pnUCFYsJUOT24x75RJsH5O9Mf7kNsLDb7vcne8y/nrh7CxJgVfPMlagWrKppLawhDuNYxV5rpxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMa3kphUlV54DCdqGM/pYA0lehNHEurQiTvONkMt/q0=;
 b=b0yNYN1gX8zZ74t0REvEqyhewlV8wNErxz/NDpySNxRn6UApm+gdVhMcmxklJoqgCqw5vnGx4SIq0WuNDoTdq8mQQzztM0oH0ZZJOcxLYm4XSOrxAN2/c+GRz+LTq9JBXdmKbt1SqfFHdQgqAKehCIFh6VfJKMIjpv3ZcWWEOG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 01:46:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 01:46:41 +0000
Message-ID: <8003e2d4-3c76-6ce5-2d1b-c815438fa6a9@oss.nxp.com>
Date:   Mon, 24 Apr 2023 09:46:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] arm64: dts: imx: add missing cache properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230421223204.115500-1-krzysztof.kozlowski@linaro.org>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230421223204.115500-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcc941e-ab5a-4442-a38a-08db4465c027
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/o5e/5HuquVVUKcMaji+kvSexC8PENjC50vxs43HVBbtgPHKiLkXbRuUKVXvMsGUwYP9DeOT7dC6OwykfGPwvR8a+z+I8F9ieuGSil9pOtVcXOFHJOGZKw8VeGdgxWLVOLt9R6VnDq16fxJOV44z7vzIspKL0+n3R7quul5Lj8YhRcHvSNuY3ncDJcB18Tn49b+cWo0OS2pWPQ9UMKaavzy0BKhX0JvYpUrkQjph738hpmtcY+L+xhLRgaQ5Ba0pXOPokHQeQaAjYVyXvf1OQ6UvY4KRHA6kaVOLDPooiUBHj26c2UWWJzuDCnddwfX6VK+vSHQAK9GjXL9RVDU/ki16khwNuoQ5ALtPm2h9AwuBht7MNYEI+UbPORJf1Vb7DtyaHIvFONWVkm1lkMbnadp9UWGwWcEw7htUiwjcxwxPHVsTkGGj+Bm+8JNZ38jRtDHJOSRJDzWdU+6z3Gk/sO4Dvs5CNMQEZQ1qlAOQMvRETRNdmkiYWUt8CDo97DzmCW6h7AkBAqvJQGOvjvvFAJAlnEY2J8FTDxQZ5ohwOfzzF/ZXAqzfkrRaGfM3eosGR9hSMH8VAdbWIablWL7px6Hh4zzeJx9nVMmDkJFtU7foOyDHvXBFQsPNvlkhWkPLx2wEbx/5SghnoTTVODi43i5P8aiBmDL6gKJJQQLom4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(376002)(346002)(136003)(366004)(451199021)(2906002)(6486002)(2616005)(6666004)(6512007)(6506007)(26005)(53546011)(186003)(66946007)(66556008)(66476007)(8676002)(8936002)(316002)(41300700001)(478600001)(44832011)(5660300002)(7416002)(110136005)(921005)(38100700002)(86362001)(31696002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0Y2dmJOY2F5S0J4ejR0RG95NlFkSk5Hak80dWRyK1NDNERPSDBEdkx4NERP?=
 =?utf-8?B?YzlLM2xjdkdjMnlDL3RlQzVMKy9LdktUMlUya0JGZGtKR3ZnbGhEbXFsdDNK?=
 =?utf-8?B?MmdqNCtYNU51cUJZVitpemR6Znl1ZEpma1A1Qjd6VHBFanQrSmRYSmIvbE1L?=
 =?utf-8?B?dENwblVwaFcwSFpzbHptQWM1eTU3bXhoMjFmOTcvQWFlM2hBTG9jbVZ4VUhy?=
 =?utf-8?B?UHJOM2JNeEp2UmRMdE9uL05tZ2JDQVozUmRDSDYzWWZ1NXhCNGs3T2dPVXcy?=
 =?utf-8?B?aUhmUzBjMGQ2ampDUWVGY2ZCNytJc1p5R0FsOWk4MkIzOXdoU2s5am9DMXlB?=
 =?utf-8?B?bUplRlE1SmUvWnM3TTRqYlVFdm5GYWJ0SjJsK0krYmJCcmhNeFdEeFNiMTBY?=
 =?utf-8?B?LzJVamNpWks0cnVxOFUzSjdYaUVhK2RldDQ2ZlZadFo5ellXWWNLcXpobkx5?=
 =?utf-8?B?TC8yWWhyMnFSR2JnbE5XT29QcXlWTkdZRy92MXlmZEZWZWpOWWx0OGlXZFdE?=
 =?utf-8?B?ZjB2V1duMUdOUTA0dk5iVFJhMWRjbCtzc2g5cGE2Lyt4RTd3WFFJN0o5bkl1?=
 =?utf-8?B?TURFbkdUZXBRTlhPNXpSTFJ6SGRWWW4wVmhFQXFubjZiVXVFZHpwY1RhUy9B?=
 =?utf-8?B?VzJPSmx3WjNMQTJ0SGFtcHp3T1JZZzN4c2g2WWowUFltQTVSTHR6eVVGb0Mr?=
 =?utf-8?B?TUcvVmlVMXZ4eHdqVmRXVUtod25Ud3d4TytuZVdYclMzb3F5ZUVzQXNBQWFk?=
 =?utf-8?B?blpnQUt5blh2TndDU3pqM0pHdGdkRHhzNEU0dktnUTM1ZmxBNlMrR2VPSEFh?=
 =?utf-8?B?NHpZOGF1TFAyZEpkYkw0ejUyekdGSURuVUpwUjh4YVFENU9KNU15S3J0RE1H?=
 =?utf-8?B?TGpmTktKREU2bm5kM0lmZHp1K3JUSHRNVENSRzBkY0FUNUhBUEVXOFlHa284?=
 =?utf-8?B?bmpKeE5QZ1BMeHRKMk40WW5RaEJXNWcwb3JKTGZnMEJMcUJYaVBFbEZpQ0RK?=
 =?utf-8?B?KzJGTXJvMllXRGRTWjNmNENKNUh0eG1zYy9aVktGa09GU0RlY3k2S1FxaUNJ?=
 =?utf-8?B?MjBaNmRSREFWMEhEQmZINmdycTE0UEQ5cU5xbWtqcU9ucm1HNTArZ2RwOVlT?=
 =?utf-8?B?S2FqdWVOY3hVbUdnVTVtd3A0RW91aXpmMjI5ZlQyZFozL2EzaU9PQTFpV3Vm?=
 =?utf-8?B?TnhycHFkYXc0MDBVbmNTOFpzUTZpMit6K2V6UUVlN2NXTFlrUzZvS2FRT3Zs?=
 =?utf-8?B?U2JEZVhHMjhYWFN2ZlB5MlRmMFlvVFdodVhHcEF2dXhBMHpWYlBBNXBhSElP?=
 =?utf-8?B?VE16WHFGM1hiOXA0MWkzVmV0djVmR2Vmc2Y2dkNJbDE1azdDU0VFSEhaeUxB?=
 =?utf-8?B?alZOL3VsRnE0Sy8vQXEyK3ppOXhXcUtEWml2a21wUG1IWnVJSkNMRW9NUDJh?=
 =?utf-8?B?Q1k0cjV6TDUzYjhSaG94WGlHWmE3WG4wTjZtWEt1bk1IUU55T1ZMWmxEYUFs?=
 =?utf-8?B?K3FCVjIwb25oK1pKZWZaT3VoalFUaHdOY2NWQ0g1dlFFNUkxbElxYkxjcGs0?=
 =?utf-8?B?K1ljSmJaKytsVFBvSTIvMnE0K2h0SUhLOW9pamFvanlST1FiR2tzdkNzZHJW?=
 =?utf-8?B?YThYMk5sTUhzNFp0WlcwMWl5eDZrdVVUbnNKdmZ0S1Q2TWl1Vi90a2EyYVo0?=
 =?utf-8?B?c244VEhqN09xbDJaSEZGcHlNWW1OOW00TzZ4T3JuZDNwNGFlTzI5Qi9pY2M3?=
 =?utf-8?B?K0FkUk1DUG8wNEd2a3Y3ck1sNVBQTWFIOTRLRmR1dmZabkV1ZVZrb2tzaVQ1?=
 =?utf-8?B?d1hsMU9iMWt1Q01rckorUkhQRUNjbXRBbC9CdEsxaG9lRGpINlFBWjFvUFR4?=
 =?utf-8?B?SnAvUnpwdEt1ZkljQmxpSnZvdE03Uk4zOWJ2VGVqL09xalZDWnJRSVVIMm9i?=
 =?utf-8?B?RkZqakpaY29XczZDOW05QTJTaDBRT3dDRlNpTTNRMkltSWIzQ0ZqRzRHd0hQ?=
 =?utf-8?B?cDBEL3JWazFaeXpaSWhnT2V5RVpvTDNLeVViME9iNTlMaTBiTko0TGNHVlJa?=
 =?utf-8?B?cUtNcnpiWFZSSlUzenRqTTIxZG5oS1d1QTRkYUI4cVRlbmRkeG1BSTI3ZVdB?=
 =?utf-8?Q?BdUUWvElwx4A5gyV0B1KrsZSs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcc941e-ab5a-4442-a38a-08db4465c027
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 01:46:41.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJvKlXMHOBlGyafJHPIVEAU3vxn7gVIj3wZG4rfyKvg2WDMq28aEuFn+fTIhuYtal/fwnzdTnxohIHCwC6RsTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2023 6:32 AM, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified properties to fix warnings like:
> 
>    imx8dxl-evk.dtb: l2-cache0: 'cache-unified' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Peng Fan <peng.fan@nxp.com>

> 
> ---
> 
> Please take the patch via sub-arch SoC tree.
> ---
>   arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 1 +
>   arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> index 70fadd79851a..792b7224ca5b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> @@ -60,6 +60,7 @@ A35_1: cpu@1 {
>   		A35_L2: l2-cache0 {
>   			compatible = "cache";
>   			cache-level = <2>;
> +			cache-unified;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 32193a43ff49..57627bdaa851 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -52,6 +52,7 @@ A35_1: cpu@1 {
>   		A35_L2: l2-cache0 {
>   			compatible = "cache";
>   			cache-level = <2>;
> +			cache-unified;
>   		};
>   	};
>   
