Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCE64DC9E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLON7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLON7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:59:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E75303D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:58:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSc/hBtERhIoaq+KOJavw7/gsAzBE+/wfqg6pbM4TWpL0ClwFrXSgVJOtNwcBpt5P6iaS6WvpgLdduiLyYevQ/Hpqb5VjxGp9fvWY49HM7X2S2i/tsMZahpdTp9XT03Q+o+OXpwhn7Ov/ICIwnp/j1OCY+JkJML4tMUOBRSlYmFXeARQ3fRFHiy2HX/Zmo/Br2hHZwSxmvXtr/PM9b2bBVdZaxnaGKauY5L6D+CZMhaTDh7uQpEIp7aqrTh7BRBEmse5Zdeyq3ce1DOto4F6OAvpuNcFIutL2WVRw14uEO6OUHMAmTOsCW/etK7dlN4HRIotd5KvUWpjJbI5PLMHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKUth1c+C5HH2qT0yZxbZg7qmiuKGwWbeIbg2B7s6a0=;
 b=R3e50DQwmE5QRN7R9BzdeOr3/LgRWqFYo6IaDeqOiF7Bfbj7FFRQQScPEp0V3bRPSvyej66aH7ukHOd0y7d6zDLlt27z56jCTlPep7Zhd0BpUET39n/ixO4+UELxfdbPuxBTTd0Jpt5ObekqPveuuHOcuGd/4l9y59KM3NNh+FBaJothCC2WXWIt4YC9WbFWk4yR+18v5vLScmIjxs0EiN8IHB7iFe4AbqCZGclgO9R21gKNxOTZKwumUO+klYLYa2dN3cKWLwGpTe2pMK6uq0+xgCOjZSxYXMbedGr0xyaWZqz7lsYmiKEtxZlSaMnppEP7dmWQhqOiZlgUPadiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=designlinxhs.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKUth1c+C5HH2qT0yZxbZg7qmiuKGwWbeIbg2B7s6a0=;
 b=etkdj+GJPfm9uaiehMqkjtwrM7HjMUUDhAT9FJdNqJIJnMdlJ48lal/0RTRi7WJ14LEFOy9LzkhHpQKtiRXxfl/SvA0xVVM/pZuSWutedEu7Q1le62K5hf1JLwgcBIU3E9dym94Omiu7g+2GLEAWXR1VgAxEd5Q+WCzOrS+axwQ=
Received: from BL1PR13CA0419.namprd13.prod.outlook.com (2603:10b6:208:2c2::34)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 13:58:46 +0000
Received: from BL02EPF00010207.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::cb) by BL1PR13CA0419.outlook.office365.com
 (2603:10b6:208:2c2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 13:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010207.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.10 via Frontend Transport; Thu, 15 Dec 2022 13:58:45 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 07:58:43 -0600
Message-ID: <10a8b1d3-e435-0a6b-9241-2eb660f6c94f@amd.com>
Date:   Thu, 15 Dec 2022 14:58:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] pwm: xilinx: Fix overflow issue in 32-bit width PWM mode.
Content-Language: en-US
To:     Kenneth Sloat <ksloat@designlinxhs.com>,
        "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SJ0P222MB0107F467DDDFB7392B04056CA1E29@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
 <672b1277-545c-27f0-a086-b47ce002d498@amd.com>
 <SJ0P222MB01077015D90D0B2D7F995552A1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <SJ0P222MB01077015D90D0B2D7F995552A1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010207:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3e9d8f-4522-40dc-0349-08dadea47bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WoPIgStjSU0zvG2lBthkrS5hpibDeMhfAo8ROVhHF7mLj8Ng98xL2m5/nCNEXKan2R2CmuXrSNTJewHGAsVFiytezPvMZxEji94iIX2wCSlnWb15APwmmUKxLERh50736NA3ArVqllnj5Q4ku/92lr+mEbyCFm9gcmLhvJ/VIToO7o15lgC7Xs8cKZioXsHl9Ff7CVtZfPa7g76gC1SOD1D4DAa+F/6wt6JIfdd1KPR3E0FmSyYZPGwkYy8ZE0VkzDw1D5QSWVZy2Am7S6JL7MkWHOiElneRFjme+zKiifjiHDHxHOulk18ZWawBWLZWTDS4sfe1j7AVaUweeDD8cmlPfKI06WuMsfGR7FjWGNzVYt/9Qb1GaTFILdAqjk1uGuO3A3boDj1cidz/qfF3XJxRsTnn5pFDNYs5VEknU5Lh9Lv7fvEcZArChNMlewsvtA4GUwbI5Q4/bdY1mbJgFHp1LXsvnBHFTo/RWBC4m/kcHZeqJmqv0r99xATO0AsQuKKnJCZqZKY28dg804VbDyKuwu+nyBc7Rc05SG+Vqu5ELPO5V7GwmYmCc3njHiIb6UnTIW70aoTlHuTEYczWPb9sooCCdoNnyQuKR5m+XBOiAtg2h9i6BGxmd0szurqXWVmWmuEmzt7MLIplXP5uCC/9GxWBG6qPUxlexwBsHt//r7A18apHCfcmdV73Jj2/qsVN0FfJ8ARmzBAm43ByY9yXPWpYg5SFjGyvp+F43Rl8JgwDN5LKlZdq+Qf7xEiOEfUlkUh65VsUD0pgFJIagg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(31686004)(82310400005)(36756003)(70586007)(70206006)(8676002)(336012)(26005)(186003)(478600001)(16526019)(2616005)(41300700001)(86362001)(31696002)(40480700001)(47076005)(5660300002)(426003)(2906002)(44832011)(8936002)(16576012)(36860700001)(40460700003)(53546011)(110136005)(316002)(83380400001)(82740400003)(356005)(81166007)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 13:58:45.8652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3e9d8f-4522-40dc-0349-08dadea47bc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/22 14:43, Kenneth Sloat wrote:
> Hi Michal thanks for your reply.
> 
>> On 12/12/22 14:59, Kenneth Sloat wrote:
>>> This timer HW supports 8, 16 and 32-bit timer widths. This
>>> driver uses a u32 to store the max value of the timer.
>>> Because addition is done to this max value, when operating
>>> in 32-bit mode, this will result in overflow that makes it
>>> impossible to set the timer period and thus the PWM itself.
>>>
>>> To fix this, simply make max a u64. This was tested on a
>>> Zynq UltraScale+.
> 
>> Can you please be more accurate where that overflow is happening.
>> I see that value is set only at probe like
>>
>> priv->max = BIT_ULL(width) - 1;
>>
>>
>> No doubt that there are calculation based on u64 types.
>>
>>
> 
> It actually does not happen in probe but when applying the PWM settings, here:
> 
> 	period_cycles = min_t(u64, period_cycles, priv->max + 2);

ok. It means (u64)priv->max + 2

will solve the problem too.

> 	if (period_cycles < 2)
> 		return -ERANGE;
> 
> If the timer is 32 bit, priv->max + 2 will roll over to 1, and thus will always be rejected as out of range. So, likely at minimum, a cast on priv->max would be needed here first.
> 
> duty_cycles would also have the same issue:
> 	duty_cycles = min_t(u64, duty_cycles, priv->max + 2);

and here as well.

>>>
>>> Signed-off-by: Ken Sloat <ksloat@designlinxhs.com>
>>> ---
>>>     include/clocksource/timer-xilinx.h | 2 +-
>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
>>> index c0f56fe6d22a..d116f18de899 100644
>>> --- a/include/clocksource/timer-xilinx.h
>>> +++ b/include/clocksource/timer-xilinx.h
>>> @@ -41,7 +41,7 @@ struct regmap;
>>>     struct xilinx_timer_priv {
>>>            struct regmap *map;
>>>            struct clk *clk;
>>> -       u32 max;
>>> +       u64 max;
>>>     };
>>>
>>>     /**
>>> --
>>> 2.17.1
>>>
>>
>> Thanks,
>> Michal
> 
> Are you are good with the code change as is? If so, what do you propose? Should I amend the commit message with more details about where the overflow is occurring?

I would update commit message with both cases with simply saying that one way is 
to recast priv->max calculation because type is taken from priv->max which is 
u32 and one way to fix it is to recast it or change the type.
And that you are using second approach because it is more cleaner.

Thanks,
Michal

