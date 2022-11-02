Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63273615768
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKBCOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKBCOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:14:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C522658D;
        Tue,  1 Nov 2022 19:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP47Vy6k3N4Q3fM4qe9FBmfnwEFsh4IXWNjHPmUuCeSwu/Rrqlm3F0WnSr4/5n5giSVe5ySbb8cdPOv7NgyT24yxNToG0ztee7gHcUQ6nOfCJTpeSn/owcB1DXmjoe1t/Q8HvY/JVgQi+hXHzaty7nN9i+MIWZrv8yogvcKDK0yHxNysRrJ456M627wOc++w3XdCg1um+OdkVKX6fCro74zA6Plh1YDh+WBHrxPcMluJqavguxBxtlcNKuLoyOIG0kOw2czJc+HS+CxNdaQprCeXiVgvweBWV02he9NyvISbUaPZG1LNcc6dQk1YI0iaSiaHubu/LNuKT3T/Zyf4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JID4PaiO5nznSHcr2xVkN0LyV+nGq95xo7ow94FDg3A=;
 b=nDS4UOR7LMwr6tYqhFhI8D2paPVllfEzGieXhS3NmePG1+PXrDc2Vy4uKGzl26nwgxSoSsb4klQNHV0GXKnGxdxKQuU0az/O4qOMXGkjThl0OvqxP6YoBXl8FJGzZTgW7/KzWqCoI3YX+0f/TJ982LNtkIxKYhexcPZ4BVx85CxmnqhWK8BlstkIO8Dvfn7uURPuQyGIpDQWalNU1UB3pvMHXtlmzS9JKRgfiAAEVTKwiXUTrdvQQWylF1rqShavKcX2vpaheqCifxdy9Vg9elk9pDDsXJbeXcwWFZxyNRzSmqrRqF5nCxDtsCPzk78ZA+mjoe5UVObOdsbTQ9RiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JID4PaiO5nznSHcr2xVkN0LyV+nGq95xo7ow94FDg3A=;
 b=SVePSQZqhyt8J8J1AeQqWau7f8/tDsJPvmmGHzPgNsPlwb+MkP07g7kX+1dA7BG1lTKaD3LJWCHKyDWX82W8Q7l6gjdRzfJmEnjgS84hhlbvIoiCDm8xbsQzCEavGdbovP6IVLZAmp3q2B+c5U68Km3+Gfb8xS8wStEqsGlT1Qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 02:13:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%7]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 02:13:59 +0000
Message-ID: <b7be4912-542e-8fdc-6948-ac4626a63418@oss.nxp.com>
Date:   Wed, 2 Nov 2022 10:13:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 0/6] clk: imx93: fix and update
From:   Peng Fan <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed23f78-904c-4942-2821-08dabc77e718
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U31DFqdiWvQfwMOE44m5/j7G6zGFC9vmfFyKPiIOd1MmMr6onEPoZuhDgkT+pOGiJUaMNdGnhiBq9x7ijE7avsU1zT1J3rsUmLUybpses8ss8m37WreDLPUSwpzIvWZTq23J2lTVKe7dTlfhFBV7ZavW65xXQJWivBi4zrm7+AgEAoedWin197WSfEZ9ILYTejK30ZtLuY+yzuqfBuff3F+UXQaFJlsBmGDY1v6+UBR90WOkY1Oz6xXc9LTpKloX86lKrEMaBZbnTgolBT+e3oGKz0+teR0Gl4+puGaOZHPzRFYhQy6NiQ9n2x5DVVkU+Ah0ztF3iFu9fSbnQKYit9l/VlnbAuIy+rCDlaI2nFNVxLGIPXwPW4yMp6lKTcBDIr+OrZGnTQjRGxy9KoBKM33GaGC6UIDGeEf+EBQhc9RmY/bLGcA9GCpHNy7AXbjPzPgKxX53eCCe3qRd9C9JNpwJPxgS/s7LaaruP2XDcHPE/KSXIp2g7M+NMj2bb2KXvQnOme6bkVgtkP3E7Xj/qMvu2mk7vgtV7FjEP9hH379aYbblCDfmB1OSAEidCHKf/jbSvLUFChEqm9bkJ10T/hImLkVG5XawTW8JxmMIuFNcG1sms8DhE76uY9qv7leYsnzSpuU92vdoyBTObzbFnNOyOTiGYYlkJ1Mv0cmrioM+AeWV1SELBmXCrXzrGCDtM9JopWeMKU+wDq0swemjBR6jZ7a49QkxrY+nF5gN98gcni6KePt4+c71pujMX41vlbJfEvqX6GyHAsDLEw3aL1BGXrnUScRPRvnVaXniDmENYDxot5anuxb5e0eFRhChIRtKV23Zxj7j97t9TZDDQJCI7gzoCzv2VoHuEM8z9GE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(478600001)(6486002)(31686004)(6666004)(6506007)(316002)(52116002)(53546011)(4326008)(66476007)(66556008)(8676002)(66946007)(6512007)(38350700002)(7416002)(921005)(38100700002)(41300700001)(5660300002)(186003)(8936002)(26005)(31696002)(2906002)(15650500001)(83380400001)(44832011)(86362001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXdlRWszVDV2WklMeXdrMzdwRWhvWjJQQlUwV3NPaVRwdmlnSU5RNmpPamhP?=
 =?utf-8?B?aUw5eVNEeVJhTGhhazJrTDU5cm5Da0NXbGxxQmxhc3p3d1NaVkVmWGlFMkgr?=
 =?utf-8?B?emRVdnBETlhJNStrbVFFYVBkK01lU3pUQWYrbGtBbkFIMS9oYVJ5elFGVk1W?=
 =?utf-8?B?d1hXa1JXa29HY25XejZzcHNqMTVsWE9YNEZYUDA5N3NvbXk4QVRWUTBqcHFn?=
 =?utf-8?B?VFEzWGxKZER0VWl5MnJ4elBZSDBSNXljb09nTWNaRzI3Rk5ucE1yY2FGb1Yw?=
 =?utf-8?B?YVZkOGV4TVRzdEhWd0xjbWM0T1ZEaHl4VkhjdVJERkU5UUM5cDEwMkJvbVgv?=
 =?utf-8?B?WndwTUxRcUdMMjRsTys1QUVUY2RValhwbktLYUY4ZDN0RVFveWg3WUViOW96?=
 =?utf-8?B?RkRqeXRXbzUzaUVBY29IZ0hnUkpJc3NlZ29wZmRiR201R2tiQk9JaXlLV2ha?=
 =?utf-8?B?YllYVnZTQlgyWVY2YmQzRWFtdTBWS21sOUV0cTA4b3FpVWFCNE9iclg4UlZq?=
 =?utf-8?B?aVZobmRsSVY1YWVXd3dqZGwzL0NvTXczeGNwWHFEY2Q2QjBVUFo4MG9XOE5M?=
 =?utf-8?B?UEtMak9Kbjg5ZXZsaWRUVmh1QTMrdFhSUG43alNjekVRRlZsRDEwUzQwc1ZJ?=
 =?utf-8?B?UnFnL0dzY0RRUjFhNnJrZkNEWFppZDVqRTNiOHdDZkIySHRsa1hvRGljNDBu?=
 =?utf-8?B?N0Vva2NCU2V3K3Nub0tISUdWRFg0cXpXTUk3MGdFL2haek5nQWtYcEtUdkZ6?=
 =?utf-8?B?dWl4b0NrOWx2Zks5R0E4QlNlY0c4cDlsVWVjakZZbUR1WkE5WXZZR2IyWmdK?=
 =?utf-8?B?NkxxU2Q3TjFVSjRRWTh3NUhIcTJhMGcyTFlhQ01ERXpjckt0SmNlT3FRZ1g4?=
 =?utf-8?B?VEowYkhidXJBVmY0aGQzczBBZWJhcFErODN1akZ6UUh4cVJWK2pHY2FqSXgv?=
 =?utf-8?B?b1JRSkJJZ1R3aHJRcEFsdDZjWXcrVGNBYk9xN1ZIT3dRWGQrTHR2TTZDdmVI?=
 =?utf-8?B?UXhObnEvdHRvRWVzNFlxUGREWXJQSEdXSjRaMTNsM0UxYVlCM3hnSUkxd0hY?=
 =?utf-8?B?L2RhbURYOG9vaGtkR1kzdUs4QmxLdW1FbVdhd2RNdForMUNvY2NGS0Jnd2I1?=
 =?utf-8?B?ZVROT3VEaGF3c0VFbHpON0tYZndnM0ZDOVorRlI4K3lnWHhIQlB0cmRYRWRs?=
 =?utf-8?B?TFhXakZheVNWbjY2ZU90ajhxSmtYdUxTSHRvRFU4UWZNYzgxaXRjeWJKdnd6?=
 =?utf-8?B?WEtLMlJqcjJ5M2t3R0FlK0J5eHE2bC9UVmpMWmRmVnZoc2dWVHdMazVBbG81?=
 =?utf-8?B?Y1NGaEx5RXYrVTc3bHE0bFphMjRpejBPNHM0N291NUpOQXJNL29MZzhjdzhu?=
 =?utf-8?B?VGVXbDVmTFlPZjBLc21ORzhFcjh5aUF3ZkVRSUZvblJETHk0cExpMlNFYmN4?=
 =?utf-8?B?eXVmQmNVYTZzTGFNYkxFVjNZVUJZMGg5cFR3NlZrUDYrQ0NCMkxqRHVCL09B?=
 =?utf-8?B?S05FWE1oTkdNamxVankvUHlZUW9FcHErM0ZyelNnMEd0ejlySGdkK3dLSFhj?=
 =?utf-8?B?blU2QmFadHRsZFdVQTlQQ1NuejB2Q0pXWUJtV0JQUEM3QTVpRGJYMDhlUlVV?=
 =?utf-8?B?Y1VXWW1JLzdTOXNGMWZHREhPRW4yYVV6bSt3QmZMQ3FSTzNhbktFNUI4bXg2?=
 =?utf-8?B?Mk1YY0Y2cTFxNXFkdFJ5UHZSYkRGYWFKYVU2WCs2NDl5Wm5CTVNZR1hLb3Vo?=
 =?utf-8?B?STA0UFJqY0oyWXBmU3RibXBzVHg4WnkxZ3o0TUtBa2hLWDZhcVZ5SHBsWTRX?=
 =?utf-8?B?bmNnZEZWeGkya0QvNDdXd1RUazdjTnZiS0ZvL3JHV3JIaXlQYzRuNTVDYWxs?=
 =?utf-8?B?eFNVZUp5SWo4d3hOMExuTUxkcS9jcFZOakVhbHFJVDRCS1FaT1F4d3d2eno0?=
 =?utf-8?B?VERDVHZKc1hLanZQRXM0Y1hrM1FuYStrRi9wcTNteUZpMFB2TkFFUHRGTjBF?=
 =?utf-8?B?NjZpdVJkaUhmNm1LcUFJV25QTGM4NzFSTVZheHhKV1FDWDZNajMxZDhJVWVB?=
 =?utf-8?B?VGJRWDg5QUNIWk5rQUlFcFBsR0tKd0h1K2oySzVoOTlEaHprWkNMUUhyeDY1?=
 =?utf-8?Q?f+fpFaXeneGxAgR0P1uBlaaRH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed23f78-904c-4942-2821-08dabc77e718
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 02:13:59.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqLOazmGOg+nha6GagemclxdTflMvHcz91lzpi4SYeG/rZJqG5UQ4CnyNYfmvO91j6I+IWE8Y/1pXcTDzHqGLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel, Stephen

On 10/28/2022 5:52 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>   Update commit log for patch 3
>   Add comment for critial clock for patch 5,6

V2 was not added to patch subject when I send out this patchset.
If you need to repost with V2, please let me know.

Thanks,
Peng.

> 
> patch 1 is reported by Dan and marked as fix
> 
> During our development, per updated reference mannual and design
> information, correct enet and drop tpm 1/3, lpit 1/2.
> 
> The TPM/LPIT patch 3,4 are not marked as fixes, there is no user,
> so update binding and driver both.
> 
> Patch 5 enable HSIO root always on
> Patch 6 enable sysctr always on for cpuidle
> 
> Jacky Bai (2):
>    clk: imx: keep hsio bus clock always on
>    clk: imx93: keep sys ctr clock always on
> 
> Peng Fan (4):
>    clk: imx93: unmap anatop base in error handling path
>    clk: imx93: correct enet clock
>    dt-bindings: clock: imx93: drop TPM1/3 LPIT1/2 entry
>    clk: imx93: drop tpm1/3, lpit1/2 clk
> 
>   drivers/clk/imx/clk-imx93.c             | 38 ++++++++++++++-----------
>   include/dt-bindings/clock/imx93-clock.h |  4 ---
>   2 files changed, 21 insertions(+), 21 deletions(-)
> 
