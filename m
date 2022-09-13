Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040655B6D28
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiIMMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiIMMZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:25:10 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E501EC67;
        Tue, 13 Sep 2022 05:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWSm+f84S2DeH7F7qM8EnKOuuIQwOlvXjYY0dGb3aLgoOaBOiCdN+fjN1/56ZGaV9tFOsSOHrvr0ziQDOvSo7gJvP3Yj3o1eyFDRPQISsAd7Tf7z7BhgOzdIZ1YbLzVFpiM3QpTkswE1HGgcFrVpY4A2KIFfWMdjVRt102g125tM/injjHyBuKVgnn7Nff/zN24tCLp7QCV/aAzT5cEj5Ajq5HvlfDm6Izdm5YjN6PNo/PgkcRYa3YPmeu9qycWUsT6amZ6N/upFkjOTwJN3MTDinI8hjf4yvKqPOh8WYHbz728cEhOP2Jtd3Bx7paQkYSC46km3V0rvPEmzs7EA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzZ00t8eGLpNYph+5BoxP0wJT5skfftspq9bYxpUECM=;
 b=fnYUSjmM8OfmL0HMKM5hylvdJ6R/ap1z7y0prfVJFztx+zCOLgYvaSRURq+4yIKvfisrS5mwR8MYp1044nfvvGyAfoPACYw52EMIicmUCuDZUY6dPKGehDEEgyPvXOBsPRa7MPo+nwmqDaZ2WbIQE8ac3i70ZxfYpdDFW1tTHobr69THKcuZDoes36Xd0hc9pz4H0dIFVlulsRyOPqMkdZODPiz/8Y+kS794X3nv1KTwQOgbvEz5nmXKV/o4rDvc/+F2+5WMCCrMadfxfSu3pbf5kg6j8+8F7sqbPNblXJxwN/qsDrebiWj+n/o3eSF4uEDDY40xwS6j81g1NKwE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzZ00t8eGLpNYph+5BoxP0wJT5skfftspq9bYxpUECM=;
 b=NQybRmMVp7Wt/qGvAZVm70B1W3f3neBZwHngVv6YEDpt0wvRbl7Eqrnd1987nqxvR0AVmCFkRTtwfP4hnGTLDB37qi3aLTt0hcxvmEHug9B52WNXZa2GLVsk7N9Jfdplw/beyt01HYK9tMOJONoJSl+yB9nfousotw4dBC+uvWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8530.eurprd04.prod.outlook.com (2603:10a6:20b:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 12:24:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 12:24:59 +0000
Message-ID: <30a8c599-583a-3eea-c7bf-04062c43b736@oss.nxp.com>
Date:   Tue, 13 Sep 2022 20:24:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [RFC PATCH 0/2] Propose critical clocks
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <20220913102141.971148-1-m.felsch@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220913102141.971148-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac13ace-aa43-433d-0d17-08da9582f95a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbbh2X0Iq9c2J/AIBTjEzNy9LrxpeeoFcL3YM38PhZ8waJv6UEJlYjfcgrE/To0wHF/VfxfC0JqlPTQGax7s+vtB/q7ah8Ns7NWyWhLF68RQwau0KszeIsaG0gulD1uyhZZd4ThuN2oOozFv6NqJG23uVnG7xTrq0R4fh+StAFpXsUUbJPxsoLB5PfrXWKBXAUeiIjtIWelh9td9LGwSg3u0EQzNJ7Lw6zyCAagE+iUnlKwfafTUx3Fe5RMfXJzNR/ObHKspXRnXgmh1+bdtwS6cDEp1caMrJY9wmWXSaCTtgkYgCUTnS/ee8ctPI/UefnhISMjSF2iLibffsJAhAA8yISdsRQnALCzA1UgwWlgjL02TEXaRYv+iK0Jjwy8xaLJOZ1pXTqV5GVEeplZDpSap/bzOaXvmhSb9tj/sCrd/+TBf1/7kK/QOND/c3mX0DXbn7qKBr8s4zSZwccikzRKzf6+cAObUGUFAm3hpP9fvwwVKwUgnscrdWL9eBjcJuFCCTd8i92f8yEJWQv9HWcsQFvlxxATdqdbuWIUCKw+M2tA8lhJed33s+zIPMo+h4FrWOWzNCfzziEN7X0mh3j5Pdyq9ro3vrH1wRZYDjAG7BbIskL4Rlym0KNMof0haQrOnIQKuDXF//KBksCL70tJ07rRjhvyTNzpQzgXd+FiboEoS8xPg+zYceB0RcpUlPWGai6i394D46/KsVgCk9ivS4cMJgHK8l/mJ3poCMeuNAyW1XuxxwpLtoJ2PixYZ5c0LFNJosVW6NuASQygTvhXmopyS8LHsjONlxyCxxjz9tarLhar/8w3D7ry2BJziW9bTQ2d9ZxUPNVA0w/GbXnkXQA8ISHYWgVVexUpc+sBE2MweEckvZpHVSbKrf88Zgu6T/3VZecPjYqdqiGUP6Pmi9VytxXESfCGap8XGRGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(7416002)(2906002)(44832011)(6512007)(478600001)(31686004)(66946007)(921005)(83380400001)(86362001)(41300700001)(66556008)(316002)(52116002)(8676002)(5660300002)(31696002)(26005)(8936002)(6506007)(2616005)(186003)(66476007)(38100700002)(6486002)(38350700002)(4326008)(966005)(53546011)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elo1QmNBd200YVBMbExuN2JBejhrVUxod0ZnaHFLaXp1QlMzY3ZUaHB6TFB4?=
 =?utf-8?B?M0NJWVN6amJoZnBXaHZSWTUxU01KM1BrOUs5K0NSMUlaeFgyUTkxVHZFUFFt?=
 =?utf-8?B?RzhIZ2xlQ0RWc1JEeXBOOUJMdVNYbjNIMnZGWmlzZGQ3VHBFeVk3RjNKRVJK?=
 =?utf-8?B?cjJjOW9Lckl4SXJzSTRYeU1wZUFFdmx5S3pBVHZIcEpHVGNEdy8wN2ZhQ2dq?=
 =?utf-8?B?ejJSNFZudmZaK1c5QXhYYTREVjBKQmVVM21URmxub2RKc1AyRkkwQmJuTit2?=
 =?utf-8?B?LzZSb1U2ajRlZEM3NkZIRDVoSG5sbUJwaXVCL1dFaExuSlhtT0RQZlJpRGJi?=
 =?utf-8?B?Zld4Z1lCQXdWakpDZXdXSC9WMnFvY3BJQ2gxQmVxaWltSVFYZEFCSnhvSHho?=
 =?utf-8?B?WHZVQzR2NVpadjkrNVJidldTTHNHdGRvSEp3L3BNaisyWko4bXlLZGltNHEr?=
 =?utf-8?B?ZzNEWVdGbGdMVHFRMHpPeDNCSHd2NkU1clNrT1BuRGEwVGd4REp0cUtaeDV0?=
 =?utf-8?B?cExSN2dURzBwbmkxMi9ZQnJLZ0VYbnZXZFphVjdjRWoxbUtQVkswZnFyRHJs?=
 =?utf-8?B?SXVmNUlHY0xJcGdXRm9YcUlRWThOcmdvRzUwTFJZMnFrb0hmWHI2bG5jaEVP?=
 =?utf-8?B?U0FndzkxTjlFVkNMQXMzVXdwa0hHam9YeGhiT3NMTDhYcXpEUlJxcGRqV2Q3?=
 =?utf-8?B?N0N1Z1JWV0ZRcFFtSEhFejRHVGlUNGJBMVJuLzF0SGRnUDhkRjlTR0U4YVN6?=
 =?utf-8?B?c3JZV1F1eVZPM1VtR2RtVkg4Nk5SNzc4RTFhS3hLRW0wa2UvVlY5dzhiUmRO?=
 =?utf-8?B?TjJnOXBUQ1pBUkpxcVN2N0N1NnZwM0NXMkluVHNqdzFaREJUM08wcXprTkFj?=
 =?utf-8?B?T1FzUDUxMDMwZmtkTzltck5hUmtWZmhxazhSdlZDY0dnNXZ3b08zNG0wNG9G?=
 =?utf-8?B?NW9Wa0RneEZERW1PZzdqV2xtTnoyTzR5ajR5N1NBTUs0M1ZWUlIwQ2ZOcEtD?=
 =?utf-8?B?WWJJcEp3dDAxTnZYekMrQ0NkelM2Rjd0bjlya2EzVHhMdlZWOGdnZ2tmNlJO?=
 =?utf-8?B?cHhWVDFJYW93NUJSQW45dWdjQkJKRTg3ZUxoZ0FHY1M4OUorNXM4STZBdjky?=
 =?utf-8?B?eWdqUTV2cHUwbXczWHgwOE1qT3dycXNwaVI1eThpZzgxVk1sUDc0d3lObUZZ?=
 =?utf-8?B?NEVwUkVFblFiWS9BZERRQzFFVS9RMG5rNGlneUpua0ROWFpFSS8vbG9MM0Zx?=
 =?utf-8?B?UEplTjF5b2t1dkFJVndwd0drTzJtd0tXZ01EdFBJeHpQY2k0c01yN2hldTRM?=
 =?utf-8?B?TmV1OHhzTm8wRFFZT3U2Y1NVSVBnaVNMWVltQXdGV0dGOC95WVRJMVQ4T0tC?=
 =?utf-8?B?RlZDVTVIemM3VkdBSjBxaW8zOXd2TUVOc3BEOG44WUJWOHljcTdWYUdUeGEv?=
 =?utf-8?B?QWxLR29nMjBtZnFXRnk0N1JiYWJYVjV3TVRYZHdvSU4xWFZERWdkZ3RNcWVF?=
 =?utf-8?B?eFlJSUZzR0l0elppdHNLRG1OWFRXV0cwTExvVm41Wk83Y1Y4djViTVBtekZJ?=
 =?utf-8?B?b1lpM1FYZExZM3A4ZjFsM3F3dG9CZURkYXBYS3dpVUVwVlNWem1MZGxJK0RX?=
 =?utf-8?B?bTM4T1RCSmxoa05tc21xeEFxbU44TDdmOStCOGVMdmNZUHIwZWEyWnNtTjIy?=
 =?utf-8?B?dnBWZDdRRjdmb1hrcUpWYlNZVkhhWW4xTWs2T3Q1aXdLcEVXUWFLTmNwMWs3?=
 =?utf-8?B?ZEZyZ1NOSkNHNnN6WWhCbEppZDZDSTJ2TnJjYTU1TjZyZkVGQzhtYkZLSTM4?=
 =?utf-8?B?b1FDakZUVU1hZ0gvcG1KWThYaTBSQ3JOQWJIUGhmZnlJOWJYN2NVR2tjK3N5?=
 =?utf-8?B?TU1ubG1RUllHTVJsdGRRK0VwVHN0dWlvN0V5V05pdVdJZUJPQlJ1aUFCZXVK?=
 =?utf-8?B?d0xJZXRVN1NvRTkwWWt1Mk41eFVKK2o3RmJVU2VyNkdRZzRpTFY5TFlQSUMz?=
 =?utf-8?B?YU5FWHNtZTRNZTUwam5jandrbDhESkJseHE0NGJCbCtjeUdHZVh6YWxNd0Jy?=
 =?utf-8?B?VTNLdWNUeVlDK0ozd2IyeVZmOHc3elhTVWZWRnRwRjNYOVNROU1aQWo5V0gr?=
 =?utf-8?Q?2LrdmGppHetRRo7BpC51IINkz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac13ace-aa43-433d-0d17-08da9582f95a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 12:24:59.0839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jq+5VSLeM47k5ikO+toYQEm01b3MIUYI6AIXuiLaJmon1SsaDJVTtQTzYdlWXMwGWJ1FwS3ohSZz44eJ98fJ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8530
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2022 6:21 PM, Marco Felsch wrote:
> Hi,
> 
> this proposal is to mark clocks as critical. It is somehow inspired by
> the regulator-always-on property. Since sometimes we can end in circular
> dependcies if we wanna solve the dependcies for a specific clock
> provider.
> 
> The property is generic so it can be used by every hw clock provider. So
> it can be seen as generic implementation to [1].

Thanks for working on a generic solution, I think your proposal could 
also help [1] and try to resolve same issue as [2].


[1] 
https://lore.kernel.org/all/CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com/
[2] 
https://lore.kernel.org/all/20220517235919.200375-1-marex@denx.de/T/#m52d6d0831bf43d5f293e35cb27f3021f278d0564

Thanks,
Peng.


> 
> [1] https://lore.kernel.org/linux-clk/20220913092136.1706263-1-peng.fan@oss.nxp.com/
> 
> Marco Felsch (2):
>    clk: add support for critical always-on clocks
>    arm64: dts: imx8mm-evk: mark 32k pmic clock as always-on
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  1 +
>   drivers/clk/clk.c                             | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+)
> 
