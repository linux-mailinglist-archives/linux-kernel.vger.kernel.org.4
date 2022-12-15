Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4654F64DAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLOMK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiLOMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:10:14 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091422E6A4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:10:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POs1RitCgkm9mPjx5zWvpKGOfKTieNqRNDR1r2OwpshE9/41zyVKVwsobhgUX7I4kGt6Zx66GXO/l1qc8Sb/U5dBWCSouhJ+mHLNPqNIDzQd2Z8hYtr0oa2ud5klZPYHB+uv+FT4k69EnebDJuVSIUweTW2bo10JMltYlxOSMnYCNOAwKARoyrHZQ83Zxxa8qVd/E/76vGl8+Mmlfv7le9YFru7oxnCZgMQl8tkvToZ+L8+bHuS2EdtJXt+hdaOgNLtj5X5XiWR07+5AUPXrWbC+fuddNhuLP1+uuf1p3uPY0aGWw8n5kManQrrym4vbPcCy1rM7MWaya8ek95EsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqqhLT/q4K25gUWOHVw/HpQxNSwWoBEUDSZOHeYGkDM=;
 b=gRuZrGnwb7ZSiPABSWNoRubmPAnHqC4jVEOGITxYG+fEZX7JW9lYOALuK59c1Da18Jx0gu0vYtZOvegTqBoT6mSaWM1CRSc9m9Lj3ryGurAUhfkZFi3WGQKkFGZx9qEFC4xh0nYVoteR4WQCR6jolX1JYWaa0WiqXVbuBtNXbK/V5P8r0GM2DRjheEp7C3JXavEE7XmOnTEEKr9YcRVZa9dNHV8xnnWdELMrhbbOMjS4ocbAzhsCbxpiz3y1WzZw9/N+LRchZ13L+KLAm98kUaE3hk2JEfgZRCFxZPY/pxfk4TmOWfrsT35z3TnY/nsHefqLljwbLi6FKW+Yr89L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=designlinxhs.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqqhLT/q4K25gUWOHVw/HpQxNSwWoBEUDSZOHeYGkDM=;
 b=3U1v/NKsbNKlbrRATw+E6LPjkAGUa63NHlvboIHrrruB05Cddgew4alQklbW5ooFXFunB7xCBWoixeEQquGuxbWvKILEFwd4yrmz/RIOMOdCU2QTovadDP+GabFHpl/qJAMLyN9ZGONUPa1ozpNRXi4g+k/YjAUSI/o+H/o++/M=
Received: from BN8PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:ac::36)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 12:10:06 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::5c) by BN8PR07CA0023.outlook.office365.com
 (2603:10b6:408:ac::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 12:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.12 via Frontend Transport; Thu, 15 Dec 2022 12:10:06 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 06:10:03 -0600
Message-ID: <672b1277-545c-27f0-a086-b47ce002d498@amd.com>
Date:   Thu, 15 Dec 2022 13:09:39 +0100
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
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <SJ0P222MB0107F467DDDFB7392B04056CA1E29@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 30613cae-e835-47f5-3657-08dade954dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GdSLZwoXi4DZCGgKGkNwC3NHLROCS1EN94MU/ZxUh8dpbt7mSgjidxCtjJCVJAv1oQco4mIM5KH+P6iQIk3i81EoHXHrWKtuqDcxzZErLpita8WWIl3PICGiYOM1yMPkLvs0rybhNoPdspPcbUHVT3uqyJh21TWq3mBV7G2kKYPNaZUSEclZDBSY5AwHGXZxuNbBrKHA1rzNCjwmF8avtQPnMDaRdq7LTGr9VAtyLnFN8ClON30ilyFhlbY+4Ohk6XAq0wfpfUn3DqGra5VHBunzwVXwXZxMZ5YvU+m6fvD8aO08wRh+9vdOCF1WlgcUvfxpAWWSkK0uRfkeRU691KxcXcKJVGhflgscRkoJ8Vk2GS0c/V5v2kKmPT3RSzfufRBBZtsB29EUwPsiiiCJcdbIMbB0n45TQ8iz7C0KiPIpq3tKMEGq0h7Z3HE0h9v6RwljUIlinZURVF0JV05C4QFrgs4zBsuWLvC/vCXvy0B+3mskuyUdE0SB7OwCkWT3m5u0PVWgzPLZyGsTdmgwzAUEdOUm6B9LaSpKlZ1kafpMv92ZhBd8wLqOqRw+ygEv8Dp4H3VbSnjfuNYnY5BDFa9ADJMJFY01nS4g4jKzulNw7RyM/sHMEAmil18ztO2MI6mRqVw5JCu7EOgJ0gm6ZCDPvJj1XuW96IOQCqCIK5duMh5c9I/JH0Qn/0WiFgqkkWxPIQ1om/g3LA6v8HGvc1c7kC872XwM2Fh3dhrdQYu/eiOqoOVi0H2YdrgqPF08y1K/24MyIdJShN03uF/5ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(44832011)(478600001)(81166007)(2906002)(83380400001)(336012)(356005)(2616005)(36860700001)(40460700003)(82310400005)(53546011)(36756003)(186003)(6666004)(16526019)(426003)(47076005)(26005)(70586007)(31696002)(8936002)(40480700001)(41300700001)(31686004)(110136005)(70206006)(8676002)(5660300002)(16576012)(86362001)(316002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 12:10:06.2665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30613cae-e835-47f5-3657-08dade954dcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/22 14:59, Kenneth Sloat wrote:
> This timer HW supports 8, 16 and 32-bit timer widths. This
> driver uses a u32 to store the max value of the timer.
> Because addition is done to this max value, when operating
> in 32-bit mode, this will result in overflow that makes it
> impossible to set the timer period and thus the PWM itself.
> 
> To fix this, simply make max a u64. This was tested on a
> Zynq UltraScale+.

Can you please be more accurate where that overflow is happening.
I see that value is set only at probe like

priv->max = BIT_ULL(width) - 1;


No doubt that there are calculation based on u64 types.


> 
> Signed-off-by: Ken Sloat <ksloat@designlinxhs.com>
> ---
>   include/clocksource/timer-xilinx.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
> index c0f56fe6d22a..d116f18de899 100644
> --- a/include/clocksource/timer-xilinx.h
> +++ b/include/clocksource/timer-xilinx.h
> @@ -41,7 +41,7 @@ struct regmap;
>   struct xilinx_timer_priv {
>          struct regmap *map;
>          struct clk *clk;
> -       u32 max;
> +       u64 max;
>   };
> 
>   /**
> --
> 2.17.1
> 

Thanks,
Michal
