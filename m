Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107476DC4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDJJNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDJJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:13:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73124681
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETiwiIYlPesfz6C+whyBycZ9XvqhBF/S2r91kXILFMVNzEt6H2+0JplBztOHyPSXkK7IDZig9/9tMmlh/MJI94R25Flv9/E+Toix7gbRmRaogSLda25deHMfnk6IQgF1QX+nchlmx1kKUYohhuixVqwMU4sg1DnnNsI3fbTemlq+0EiBGpKcO9OFpZ2ChCJFhtMArd3fM8KpJCxbKcdn23fgSo18fAFwHwk39MRSdGwVgDLwpwXPb5XX9tK+9+wTbvLgxVQ2011fcxAouLgocYEowdLjxeU31iazYFukd4JaCNESXQGM7HK6ppjw71jEe8ZaHjpQGhNHwe8ni2kLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V75irzTUXp33w85GzwxLvQo26Glzwo/Wku7UN++bNCY=;
 b=Ih1JtYp66wuccjYUkFnC4vfSWKOxQsRYhadsB3k5NiI3MEIXZZblb+FHghLYXxKXIze3OkLDgwUNlKKg7kOptRDlbYtl1vi72EWr2pHXXDHFyf7dVe6ZBnoQFhJczBIZUHMZjK/WEcQvi+twkH+UovkH8E7ljN0ifsl20afo5lGg2g3PAOz3wLFd5SjN2FMSsv6ruDPgNFNSnQtQYElx+e5qb0/MU2Sv3UttTN1XEB+ov6nD4hjJUaEwLeOKqPL6BUbnkxuhJDZhA3S7Drgw8Cr/rPpTn2Mv+Valv9m1PQ00a5Cp/O0gZOslDEEftGpjuZCE3HDesF37TzbkzxcPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V75irzTUXp33w85GzwxLvQo26Glzwo/Wku7UN++bNCY=;
 b=RN/jm8ZEEAw2bmL3iiM+WGj9P28aT7LHnBrOqqLSrCxTrsLiI8rn4vlQFsjgz9Uwr79R4s8/2mEM+DMZ2tubxMdwbT29tNJ9pyh5X4eaJesYEN3ZxtJOMnUJTIihCNnOUg5GMWPgRg9mwb1UyE8HOeSTjULGC7EK9mN3lj01SxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8752.eurprd04.prod.outlook.com (2603:10a6:102:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 09:12:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 09:12:56 +0000
Message-ID: <426d8797-d4e5-624e-0d08-0b9dea5ea62a@oss.nxp.com>
Date:   Mon, 10 Apr 2023 17:12:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2] soc: imx: imx8m-blk-ctrl/gpcv2: fix i.MX8MP VPU_H1
 sequence
To:     Lucas Stach <l.stach@pengutronix.de>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
References: <20230403084228.3212581-1-peng.fan@oss.nxp.com>
 <30937b92bece48c008c1fe2b29498641df1dfd0c.camel@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <30937b92bece48c008c1fe2b29498641df1dfd0c.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0228.apcprd06.prod.outlook.com
 (2603:1096:4:68::36) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: db5fb1dc-27db-4fdc-cf35-08db39a3c5ce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8t37fYyUJ0NRXHms+nkQ8XE1adZHcGot3gpEAui7ZuuYXi2e+ApF/l54sFq914lH2z89Di4rmAFFSPkUom6DrIuHNuFaS71YExwIXGQVA/uFayYuj2AmCCkIe196RD7d94beGWs+EZ9hFALfd94iBAlbiK+TRSSNPndM5xsWaMbacPauRI00b99upSg3U8BJWrV9Uxv/O2AxdLW5nsXs5v4pnYriODvjl0G+GX9JgUA/YQIqW1qWj4nCOfx4UITZC/83+xlmgn9de7+NFai65U+fGpune7HWRxPperm1fD3UyNeXrkvytUFVAfAamd1eR5f+0anEMyYWnpcYra9/ZyPty/KUJJz+7JjBD+nE/NkSSuZgQgcp9XgAzrAJ+GJPoUp2/i41L7HpROfTPlGXdJBsdrQ+byz1Nt2V6CF5VSsZEgyxo245ZUCaGpDVC/lGjDwH63wJUQy+BsSMjvNpI/3bvct5GaQqXBbtRUKP7RrP0z1lFVX4MqRqXzFmZc/960d5nbU0UZUmgioKMYN0dsS3BRb319tx3LUm0BPg0aRl/fXIvVh1YhykME0lOpBeX1DQH1904mqXok1Am9vDrqxs0py5+PxJdfBKiCCkIpVCmA0eeey+4je9ZewawGSYO9MIb7ZpaNvjaz5ecNCG+8zL8ueR89ttklznePJaDZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199021)(478600001)(316002)(54906003)(6512007)(6506007)(5660300002)(26005)(53546011)(186003)(6486002)(6666004)(2906002)(44832011)(66476007)(66946007)(41300700001)(8676002)(4326008)(8936002)(66556008)(38100700002)(31696002)(83380400001)(2616005)(86362001)(31686004)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZLZi9CS2doMlg5SEJuVmdWaWdZeGl4b0JlTVg3KzhlRWR0UWl5MngwSjJq?=
 =?utf-8?B?NlJHeDc1dnp3SDJId0pROUpjVHJrN0lPOUd0SEJOS2JaU25TZitualEyQVdS?=
 =?utf-8?B?REJmN0JYV2hqcEdKdk81R25TTzV6L1FJUDQzTzdhVTV4c0V3c2JydHJZTjFz?=
 =?utf-8?B?aGI0NXBvajc3VlczTEhJR2hHSVdhMm53YUltUGNCVEJNcm8yT2hLdnJHTU1y?=
 =?utf-8?B?UFFzaitoMFNBdEpjKytVbTFGTDYwYkJuL21UZUFoeTlFMnZmVXJONytRd1hN?=
 =?utf-8?B?VjJIVTVvelFQTG4rQzVXNFhZc1lML0Qzc0VOSHlLMjFia3F4dllyMHJZdWFE?=
 =?utf-8?B?L1RYbHhlTXNQVWNhS0JTc3p5UG5jTklHVktHWitrcXJXN0NsSGw4dkx2YkZL?=
 =?utf-8?B?aEVoSjNJMENmcE95VVY1S0FNYzgwWlRmSEhmVlJBMXJ1bmZlQ3U1VUptdTEz?=
 =?utf-8?B?R2JpR3lyNE0rQWV5cjdMb3hRMnhlUzVjMlVOYXhPWnF1QkV6dHVTWFJXL2hk?=
 =?utf-8?B?TWRPUTNJY0VBakRSTGpkVzJERGxwMjFPbTdyZDlrdXlDNlh3K05PQ3kweEVE?=
 =?utf-8?B?dE10Sm9zK1ZTRHdHcWhBSzR2Z3hRSEhCVXNZMitySVg1bWJYaFJRL1NvQm1t?=
 =?utf-8?B?Y2lreUdBeDVuU0FackNFQndBZWNtbUxuREZxdUtaTnFxS0hoU2lNUGovLytD?=
 =?utf-8?B?MnZjR042ai81WE5mSjgyd04zc2k5MnRIMUFvL0d6Mk5lNWJKdlpSdFpCRURn?=
 =?utf-8?B?c21mZnVxTnhsQ0FBQTRnL2JaMXJtVm5uZ3F4ZzFhYkE1SkxKVFVxUUl5NC9t?=
 =?utf-8?B?NjM4ZjhFMkszK3EzSm94TnFzd20wbUU4SGp6WlowamErYjQwaTVTR2NtMHlY?=
 =?utf-8?B?UUNYM1prd3hPUnp1RTRKdkVZVFpka05HbytqY1lTQUZnRm9PVCt3NkdJNjM2?=
 =?utf-8?B?MWZRcEk1NkpGdWV1M3VLaFlBMld5SHpJYjFMMU5SS1RPN3BnUDZablFITE9s?=
 =?utf-8?B?SHpsdUNrS2h5Y0VQZ0VGcWMxSk5qeUh5WFNya0ZseWRaVmxUempjbXdKSjkz?=
 =?utf-8?B?QmUzZ1F1b3dLRTJ5MEFrMmx4UGs2bEVaZW1SMUdzT0o2R0wreDdNQ1VSWDdi?=
 =?utf-8?B?OHAvKzVYQTZjZjludmRNR3VqYVdqUlNqUGJWWGZ0UjRhTDdEcHB2SitJYzlJ?=
 =?utf-8?B?MVIrK2NZQ0R5bkxBeHh5ajE0Z3dMNnN3M2IyVWxnSHgrQzY0Q0NDdjNEclNE?=
 =?utf-8?B?OThYc0haSU5DNFBhV2I1cUdsajhWMk52aGo2aHg4bjVTQXZXdUdKb0NTOWFr?=
 =?utf-8?B?dy93TnZ2V2IwL2hYZWoyUWc1MlIzM3dMQk12c3hrMldxTkxtSFZ3Z0lUQ1Ba?=
 =?utf-8?B?eGliZ2pIYk5PMmNrWURwZFZiS2NTNGlHcFkvOUJCb1hHaWdMV2h1Q2dEb1dQ?=
 =?utf-8?B?bG5HMlo0TzRKY0Q4TWlYcDlDbDBDTUo5Uk1vV0hwaXUwbC90aWFyMGlFYjZG?=
 =?utf-8?B?bjFmT0kxc29BeThOWkJNMEVTWUdycmxpQ2ZyR2laTE9JRllZaWhIdGJKQ2xt?=
 =?utf-8?B?TW56ZWlJeWdEMnZNWXJvS3lWRm4vVzBjZkJrYUNEU1J4dDlCcHhJV25mRVIy?=
 =?utf-8?B?L1EvN1kzVUpDTDhmbEoyRHBzcW5ESW9OVEd1bXdXQUFTWThtcUlNb0ExSVJH?=
 =?utf-8?B?bHNKWVovRVh5ZURRV2J6bmNVRFR0NkExVUNLSEEvRW5telRUNWRVRHhxWEN5?=
 =?utf-8?B?Vml2QTlLVzlvTjRNN0JwOXNNcHRvRXFPTTZrYmdEeUxoYTNPN2ZsZTVUTHQx?=
 =?utf-8?B?L3U3RjlWVHhsb0xUSTVobVN1QWlXVEllR0ZXWmdZZDd5SFUzNHZSdStNZkJY?=
 =?utf-8?B?VWZ5TWE4WkZOZWVKeWxFbHZmQWVseHlsS094ZVhCY0pvd204STNRdUFQa3pZ?=
 =?utf-8?B?eGtOU1ZZUHVTUmY2YWtCU3k0VElER0F3ck1hdzNSbEFmRks4aGpyUmFvdy9D?=
 =?utf-8?B?Q1B1aG0wMndnWnhuVUh5c3RYMk4zSlZwdUFJaFZlN2J5eWVUbk4zR1dqMU9V?=
 =?utf-8?B?cGtEWTVwckZ1K2duclJyczZ5c00wNWd3NTA3TUh4b1dnVndTemhBVFhwNGlR?=
 =?utf-8?Q?NBns/16cng50AjBkdIb2/kdpB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5fb1dc-27db-4fdc-cf35-08db39a3c5ce
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 09:12:56.7649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1755aH4YfMB7bGymeKdXRE/H6iApC4T63E4TNfsb+pMGf1odzzMJvNNpwY5EwtxOZ24dVu/X9SveXbpQwD8eDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8752
X-Spam-Status: No, score=-3.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lucas,
On 4/3/2023 5:04 PM, Lucas Stach wrote:
> Am Montag, dem 03.04.2023 um 16:42 +0800 schrieb Peng Fan (OSS):
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Per errata:
>> ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
>> power up/down cycling.
>> Description: VC8000E reset de-assertion edge and AXI clock may have a
>> timing issue.
>> Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
>> both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
>> VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
>> de-asserted by HW)
>>
>> Need clear BIT2 of BLK_CLK_EN_CSR before power up VPU_H1, so
>> add a notifier with BIT2 cleared when GENPD_NOTIFY_PRE_ON and BIT2 set
>> when GENPD_NOTIFY_ON to match NXP downstream Arm Trusted Firmware
>> implementation.
>>
>> NOTE: The NXP downstream ATF has VPU_H1 CLK SET before do ADB400 HDSK,
>> so follow that procdure to avoid any suprise.
>>
> This patch seems to be quite complex for what it is trying to achieve.
>  From what I can tell, we can implement the correct sequence just by
> fixing the blk-ctrl driver.
> 
> First of all the i.MX8MP VPU support needs to stop using the
> imx8mm_vpu_power_notifier. This is wrong, as it ungates the VPU clocks
> to provide the ADB clock, which is necessary on i.MX8MM, but on i.MX8MP
> there is a separate gate (bit 3) for the NoC. When this is correctly
> implemented the VC8000E clock should already be gated off.

I added a notifier for vc8000e, not the whole vpumix blk ctrl.

> 
> Then we just need to move the clock enable after the GPC domain has
> been powered up in imx8m_blk_ctrl_power_up(), which shouldn't hurt for
> the other domains, to achieve the necessary sequence.

Let me check more.

> 
> Btw: it's quite confusing that the commit talks about both VC8K and H1.
> The VPU core on the i.MX8MP is called VC8K, so we should really stick
> to that when talking about patches specific to the 8MP.

sure, I will update to use VC8K.

Thanks,
Peng.

> 
> Regards,
> Lucas
> 
>> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>
>> V2:
>>   Add the missing gpcv2 changes
>>
>>   drivers/soc/imx/gpcv2.c          |  3 +++
>>   drivers/soc/imx/imx8m-blk-ctrl.c | 28 ++++++++++++++++++++++++++++
>>   include/soc/imx/gpcv2.h          |  8 ++++++++
>>   3 files changed, 39 insertions(+)
>>   create mode 100644 include/soc/imx/gpcv2.h
>>
>> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
>> index 4b3300b090a8..81e3c09e004b 100644
>> --- a/drivers/soc/imx/gpcv2.c
>> +++ b/drivers/soc/imx/gpcv2.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/regulator/consumer.h>
>>   #include <linux/reset.h>
>>   #include <linux/sizes.h>
>> +#include <soc/imx/gpcv2.h>
>>   #include <dt-bindings/power/imx7-power.h>
>>   #include <dt-bindings/power/imx8mq-power.h>
>>   #include <dt-bindings/power/imx8mm-power.h>
>> @@ -376,6 +377,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>>   
>>   	reset_control_deassert(domain->reset);
>>   
>> +	raw_notifier_call_chain(&genpd->power_notifiers, IMX_GPCV2_NOTIFY_ON_ADB400, NULL);
>> +
>>   	/* request the ADB400 to power up */
>>   	if (domain->bits.hskreq) {
>>   		regmap_update_bits(domain->regmap, domain->regs->hsk,
>> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
>> index afbca0d48c14..d88e338a54b1 100644
>> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
>> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>>   #include <linux/clk.h>
>> +#include <soc/imx/gpcv2.h>
>>   
>>   #include <dt-bindings/power/imx8mm-power.h>
>>   #include <dt-bindings/power/imx8mn-power.h>
>> @@ -53,6 +54,7 @@ struct imx8m_blk_ctrl_domain_data {
>>   	 * register.
>>   	 */
>>   	u32 mipi_phy_rst_mask;
>> +	notifier_fn_t power_notifier_fn;
>>   };
>>   
>>   #define DOMAIN_MAX_CLKS 4
>> @@ -66,6 +68,7 @@ struct imx8m_blk_ctrl_domain {
>>   	struct device *power_dev;
>>   	struct imx8m_blk_ctrl *bc;
>>   	int num_paths;
>> +	struct notifier_block power_nb;
>>   };
>>   
>>   struct imx8m_blk_ctrl_data {
>> @@ -265,6 +268,15 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>>   			goto cleanup_pds;
>>   		}
>>   
>> +		if (data->power_notifier_fn) {
>> +			domain->power_nb.notifier_call = data->power_notifier_fn;
>> +			ret = dev_pm_genpd_add_notifier(domain->power_dev, &domain->power_nb);
>> +			if (ret) {
>> +				dev_err_probe(dev, ret, "failed to add power notifier\n");
>> +				goto cleanup_pds;
>> +			}
>> +		}
>> +
>>   		domain->genpd.name = data->name;
>>   		domain->genpd.power_on = imx8m_blk_ctrl_power_on;
>>   		domain->genpd.power_off = imx8m_blk_ctrl_power_off;
>> @@ -479,6 +491,21 @@ static const struct imx8m_blk_ctrl_data imx8mm_vpu_blk_ctl_dev_data = {
>>   	.num_domains = ARRAY_SIZE(imx8mm_vpu_blk_ctl_domain_data),
>>   };
>>   
>> +static int imx8mp_vpu_h1_power_notifier(struct notifier_block *nb,
>> +					unsigned long action, void *data)
>> +{
>> +	struct imx8m_blk_ctrl_domain *domain = container_of(nb, struct imx8m_blk_ctrl_domain,
>> +							    power_nb);
>> +	struct imx8m_blk_ctrl *bc = domain->bc;
>> +
>> +	if (action == GENPD_NOTIFY_PRE_ON)
>> +		regmap_clear_bits(bc->regmap, BLK_CLK_EN, BIT(2));
>> +	else if (action == IMX_GPCV2_NOTIFY_ON_ADB400)
>> +		regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(2));
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>>   static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[] = {
>>   	[IMX8MP_VPUBLK_PD_G1] = {
>>   		.name = "vpublk-g1",
>> @@ -509,6 +536,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
>>   		.clk_mask = BIT(2),
>>   		.path_names = (const char *[]){"vc8000e"},
>>   		.num_paths = 1,
>> +		.power_notifier_fn = imx8mp_vpu_h1_power_notifier,
>>   	},
>>   };
>>   
>> diff --git a/include/soc/imx/gpcv2.h b/include/soc/imx/gpcv2.h
>> new file mode 100644
>> index 000000000000..db09720bf638
>> --- /dev/null
>> +++ b/include/soc/imx/gpcv2.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef __SOC_IMX_GPCV2_H
>> +#define __SOC_IMX_GPCV2_H
>> +
>> +/* Avoid conflict with GENPD_NOTIFY_XX */
>> +#define IMX_GPCV2_NOTIFY_ON_ADB400	0x80000000
>> +
>> +#endif /* __SOC_IMX_GPC_H */
> 
