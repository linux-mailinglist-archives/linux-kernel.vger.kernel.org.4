Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5180760741E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJUJcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJUJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:32:06 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A609F256D09;
        Fri, 21 Oct 2022 02:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inyNIZDMo2rBrTjj48/wb2IkvJBGu8/2KsMsmBHulVMeXMJhJ2NCbFMNvwVa+SJRVzm4UD6DiwUl7ASKGieAS5ieDDGK9ixiAFi2z/XGm853IbA2IiUdPgiCSB6XFPtFQTONo6ZVbqyypXQFXka1PH/LdOQA+AgqGlH6dSXsJWN0InffzlpJzUYjHSf4hNJFVqG77tlgHvbuVMz6Kg6H6ggA9/glDtrSyU39cFJRf77KSJ5Qou/Ojm57upnh7eZ8UxgRlqMokDHNea0/5x7Irs0/4oKw1rkqh2HlqvH4aNlSraKrbG2LFv+M7ArUhuhWIuNhlUGfV9AwPijEhCknWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFljExZKI/hH2jz5ff/LSycirC/HnzXWtUN26hrlxhc=;
 b=F3Vmi5wjVxL8D2VJ3yqdqQDCyEutAVS0C+3nZ0anu3+ljHkTH8y1ijcnMUFF52B+mK9LLhZgZcO3tFo4CCKztLZbqdphNRMOvoKdq6/stJ11U78oYitG0pOadXsr8kDkpUPTQzwj5pjQ+eERWQi3YUPRWMu2tqIdfQxqQ059/DpdoSQSoRpGkoKRsFg8S/GOztxpUBgbNCkbyvEq1dzmDaF1a0d14dAJasMYVZsSmK+Jv3qgHbfgNm9JZcoqFXbAYVynh1XB/ps7zWbQc/et8ZlUtImrMhTeWMyqUd+QlUeQxm5HLu1CY5omFxEICCmorOYapnZLFipNkZ9h3uPHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFljExZKI/hH2jz5ff/LSycirC/HnzXWtUN26hrlxhc=;
 b=Wz/hZg8dXW/W3ZB/irH9dojKTgLi+yVGaV4KWQ7R813R8kSIDbZReIGEx5R2L/GMd+9I1K60f776z7uuWJTm0r3MaPQmTq13vqv1wXiwoLb13xcnfx6qXgtXYgeguuAgPA4Yj3WBcXJg0mvNOpVvwHf9vzcW5brN3Od39JlKAwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 09:32:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 09:32:00 +0000
Message-ID: <5ddc1dac-b6ee-34c4-63eb-63c9a254d984@oss.nxp.com>
Date:   Fri, 21 Oct 2022 17:31:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 05/15] arm64: dts: imx8mp-evk: enable uart1/3 ports
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
 <20221020095934.1659449-6-peng.fan@oss.nxp.com>
 <20221020110723.udftsfrfdnghudto@pengutronix.de>
 <7ede9de4-75ba-6ebf-60a3-fee98e050ea9@oss.nxp.com>
 <20221021090910.zkijqqt6mpukzqdp@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20221021090910.zkijqqt6mpukzqdp@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e80542-14c2-4046-9970-08dab3471aa8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/6st4y3RlkWiW402/ePwYX5BRdeNaMoLaYCLxdEW/NWnaoLBNn1PvXxWdh/hqdzgyV+sA7/p+zuiQ0frmI4KY+0pjgJRJT05rVxKqRBca/xfJ9vYa56scae5tf5Wlw3y21ihlaKMnNvq0CMVBo6d7KVgwju9QmzirB4EwaScEj/aW1xepc4KsxwGCK8IMalX4WjVnJeJGdk+bi9Nq0tyvCpXl7e+btO0JmXSB5N8eQxCdUIAzpbw9qcX+WTHdfdIh/RGIjFapkZb6dXhXUY0WUbf9Pil0Ihb/Db5TwgUNe+M1/3Vb5HfGLxxbntJW99ZwPjHA+t1nHnsNgM3dwf2GiEnAVBL4n6LUumV80izrxNQo96fsBtsx45BAcpYT1N+3AHrmvoHLN7ZXCfzZYolfCfqBayVgcBJ8UFWRnKAkqlg1se6vedQvpsCwdTKhCUCXEdc5TdUubBSpKRWu6qiIO9H/ZpXafu4KKxU5e0fhqS3zJKw0gLKAaEGYp2E4cTXGPWbovVSogOCasEEeGdGcK7Z/nSjDfNHF4HzMlpI9nQImLpjC2sE3EmQ0uRdSay8sJOLnLlPcrzoytbDQjcUwBNaWnXlLyJu84xjOGp62qTFhvJ/5BYz6ZdYX70aR90ARo9a3zEKcwFSsSOEYyDzcbnm4Jvl5byfACQzc1GzbH91LY5N5r6pOy9j64KC3tcAJofx+TaKzbF4rnNGbyrLAdiIAMjUV0Mc1dgcI9g8tnBSjUUTJpuOHkwn4MTin3p84TQODfzZk3GWXD7EOoQv9pPnauTqgiqM2U18k0zYBJeObs/210sBNt82LuWWj63Mz5svDvX+IKHazpIjMBOm55gTl/cgiIOxEhokrZZWpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199015)(31686004)(83380400001)(6486002)(478600001)(38350700002)(2906002)(6666004)(38100700002)(44832011)(86362001)(6916009)(52116002)(2616005)(186003)(316002)(7416002)(66556008)(8936002)(66476007)(31696002)(41300700001)(26005)(6512007)(4326008)(5660300002)(6506007)(66946007)(53546011)(8676002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZtcWxHV1RlOXhMN2RQY2VpRUJoeWFmbmVlM3dHSVhQOXNZSVFJZGdKeXVm?=
 =?utf-8?B?SnZJZy9rR3ArTEdaU0dPMi9YdFY2cUl5dzVCS29HZlZraVVBMldFbXZsNVJl?=
 =?utf-8?B?QXM3dGZ6OFN6R1l6emlZOXFSNkRBdktkUGhNaU96UnozKytIdUpqTlVNMmNU?=
 =?utf-8?B?Zis2QklBT3dMelVvWkd4VjRNZHdmam5KdDJ6b3B4OGNQenJkZWM0R0hhN0w4?=
 =?utf-8?B?ZkNBaGdjOUlURkIzb3Z4UU54bFpxemxScGE4RFFkUHJIOHJJSlBlSldqVlFa?=
 =?utf-8?B?c0VUUTZHTytKRDYzWVF3WFdYRkZ3UHpoQjM3V3dEVTh6ZXRZUVZVbHk1QzhU?=
 =?utf-8?B?NUdNV2pvOGNBSnllQ3FqSFMrLytTWjVWWXB5Uk9sdk9ReE0wTTR1UC80TSth?=
 =?utf-8?B?bElSbk1Cd1kzYUVxc0hPK0JDeWJDbEdDWjdKaXFHaFdvNGQxWWhmaDNnZFlN?=
 =?utf-8?B?Ulc0dzVkSzJRYnpyVTl5TUkwWWF4SVIwS2ZTSmR3a0dpdDR0REw5eVdqMXVx?=
 =?utf-8?B?VUlQcHBPNk1lZkMzeDlKSGN4NnREM1JMQWZYZHhSMVlzN3BOTjZOVzBTRmNv?=
 =?utf-8?B?SnZTajVTejU0TUpGeHFHbERpTUFnQko0blFKd0pHTW1IaWdnbVpGQ2tPRThW?=
 =?utf-8?B?S3o2eGViOVE0b0FZeFMxS2pwckdYaEliSXlGckhKelREWVhsMGtKSmgvdlVF?=
 =?utf-8?B?ZExlazdkNXl1akQrRVZuS2xGSUU3SzVhT2ZTa3J3SGtEaHhLWjhtTlpZZG0y?=
 =?utf-8?B?c215WnVEektYbmpSVWtpKzdjeklpVW80cWduUzJGV05Xc0pKMHdoRUxyeWdw?=
 =?utf-8?B?Ujg5WElhQmxqeXh5bzQ4VEx6Q04wT1M3VW5pSWVxeXdaSGtPQXBVZ2lINUti?=
 =?utf-8?B?M0xWdUFuQWc2M2RtajdQQitPekg5WFdhNGsxVnRWZmZ4S2pTUWdta0l5Mkpm?=
 =?utf-8?B?LzhlN0lkYjloVUdXTDcwUHZFekFpWUpGdlJoa3l6Tkl5MUdaZXJ3Sm5xd3Vx?=
 =?utf-8?B?NDcyWnVoWlZnOXp5YktTNmZnTmxyV1BkVXR4RTdkY3R1MXROdlZRSWsyZ3lu?=
 =?utf-8?B?VENxOG00REFtMFpyaE9Ya015N1ltaDkrT2Q5THIwc01nNmpZMm1lT1crVWta?=
 =?utf-8?B?dEQ5T0FQYjNpUnlNc3kyby92c0FKbGlPM05ITVd6Y2tiUEVmdDRHS2xzTHor?=
 =?utf-8?B?Rk1wUFpFWTl3K0NQSVRnUWQyVVg4YnVIOEtiWnNvdXlkLzRESDJZQ2dNcWJN?=
 =?utf-8?B?WkE1TjJGWkxlRkFsOFA3T25yYk9oNjZrZUF4VnNKOS8rT2N4TmlrN09MY2Zi?=
 =?utf-8?B?WGxCU3h2cWR2SjJUdjlDT1ljWE5qY3p3MjJPMGROUlMxS24zaU5BTXc1NHFC?=
 =?utf-8?B?NGp3WUkrQXZZdkJKUGE2c2NwcXVqOEVoVW0rTWpTSTZra2dnMkYyaXhhVGJt?=
 =?utf-8?B?MWRuTFBoNzlvY1YyYm9MbEx0T2tsVS95WnZyang4Q3c3S1ZtQzFnSFM0V0Yx?=
 =?utf-8?B?WndaUndHcU41U3g2ZUxhVUcybUd1aWpDbi9mQnlTanBzRkRGSVpuZng2bjY1?=
 =?utf-8?B?WCtrSnM1bnJnU2U3UERzS05zN1RSUE1kcE5pUmZpMGh1VHgxVlZJNU9vTllY?=
 =?utf-8?B?ZVhXWW5ja3BZV3FNQkp4cWF4YVZKYkRhOUxiZmRwQXdONE4rVWlRcE5zUXN4?=
 =?utf-8?B?YkYxUWhtUmY0N2FDZjdvM3RobVU1YnZaUFpBR1lzcFBaY1IrRVA0c3RKUGgr?=
 =?utf-8?B?OUtFQ29EMTEwMWVXK05FU21aLzlETG9Yb3NEMk4rMTE5OVNESW14aERLSWNU?=
 =?utf-8?B?R0NmZ2F6R1g0akxyc3ZBaTdEcElyelRiLy90MVlvTTlITVlGYlV0aWFXc3Nl?=
 =?utf-8?B?NzBsVHdsekZueEJNOFBiY0VhTWpPMEFIajhMN1ovL3lJbEF4NXBDQ3R2S3hZ?=
 =?utf-8?B?NHdicjBFNzJrbVNmR0Zya0RKY0xSMVdyL3RLQllYejdwUEJUL1MrTWdSRXc3?=
 =?utf-8?B?Y3h3UWMwRUY4NHdjbUhrUXE5UWdFY1RIcDFLUENaNXplMmJ4dFFMQmhpZmJm?=
 =?utf-8?B?WnZRQUZodXpUOUlTS0RtNDBEZE5lbWt2VXE2ZXR3RkliOGprR3lFbC93dVQv?=
 =?utf-8?Q?r5Duii0i1HgzQJPFgcz7cz3gE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e80542-14c2-4046-9970-08dab3471aa8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 09:32:00.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OluYeYjF2x4VkHtcqxoAJmqHMurvI6NMjwMkEYj+rq9oSemAlyWuIFTTH7qi5lCJ5DVU89j6/0GTmagXSDjNQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On 10/21/2022 5:09 PM, Marco Felsch wrote:
> On 22-10-21, Peng Fan wrote:
>> Hi Marco,
>>
>> On 10/20/2022 7:07 PM, Marco Felsch wrote:
>>> Hi Peng,
>>>
>>> On 22-10-20, Peng Fan (OSS) wrote:
>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> Enable uart1/3 ports for evk board.
>>>>
>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>> ---
>>>>    arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
>>>>    1 file changed, 36 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>>>> index 2e29bb3c041c..366f709f8790 100644
>>>> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>>>> @@ -428,6 +428,15 @@ &snvs_pwrkey {
>>>>    	status = "okay";
>>>>    };
>>>> +&uart1 { /* BT */
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&pinctrl_uart1>;
>>>> +	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
>>>> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
>>>
>>> I'm curious, what is the default parent and why is this wrong? For the
>>> already exisiting uart2 we don't do that. Same applies for uart3.
>>
>> The default parent is OSC_24M. The uart2 is for console, so 24M is ok.
>> As I recall, we met issue 24M not able to get higher baudrate.
> 
> What did you mean by higher baudrate, is it everything > 115200? When
> the console baudrates can be fullfilled with the PLL1_80M as well
> wouldn't it be worth to fix the imx8mp.dtsi instead?

To console, we use 115200, 24M could fullfill it.

BaudRate = (clk / ref_clk_div) / (16 * (ubmr + 1) / (ubir + 1))

If you have 24M ref_clk, the max baudrate is 1.5M, with setting
ubmr, ubir to 0, and ref clk divider to 1.

So more higher baudrate, 24M could not fulfill.

THanks,
Peng.

> 
> Regards,
>    Marco
