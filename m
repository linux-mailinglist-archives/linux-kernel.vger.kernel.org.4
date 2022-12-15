Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A618664DE46
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiLOQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLOQNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:13:16 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AB2F029
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:13:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuJX/t03dKPajwk+XinxWPMu9dvOaWYQqhUVtmJ9jWGXTK8tTwRnvqPahSS7sHIkDL+NWvUsq1F8EcQ2NrC2VGYgQB/xJbXdOF3yKof5CEx+xKGCj4upcONVhW4f84y5hdhsfokCmECz7GVMaFhcGbIjX4SG6LBFILk6cWTxotqqeImNZsAReaRZZlUutVUdlUxYXIOJScA1sEyOaexG0qom5acrzbf+rfl/s84Pb744+IoT+pDUOiHUCl13Nd8sSS7AfUCyOh4HbCF4CgXDJe0KcF293uHl0p4IpZeaSHw+rUolqDpRfzqRiC53jAz7PfvsAf2/bOEwvHnCSe/jNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a75fQG7L8RWieKNiAp3VlWxkOnuU7Y6pHlePlcXszZQ=;
 b=BtOVTcWWfre0rEUHrVhyUnZkTYzf/57+4rIzm6pW7Rev2BLaTaMlE80uYRQJqinwaOWdsCsLI+jLfIpg0Iy6CGCcULKWw9CUkib/Z0kKkugKhvLlt8HXTcCRrl33x1TPG1DH3o7IiJdJhaWlmk7vOsX5qazdn7m6//tgdK6pKdmdof/+nL3uDpBcZWTPFnZAs7WiizGk+77B45Mju9jGYuwBkC+iAl4B4IP5+oLbO1KOtOK3tULd90KjuB0EHQl1UVyYnaMhStBP3OJn2wquqSILFAl/7xOQziIWbCGgx2MnPjWxleg6wgdBJihO3lLeyloHYuwD2OkAMKo2tEvDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=designlinxhs.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a75fQG7L8RWieKNiAp3VlWxkOnuU7Y6pHlePlcXszZQ=;
 b=L7/76EHiwzCSBrX2dCm8CVEt9amnQrUiG4LuidqHEqnx8ClpDkAgB9oXdmkdT1bKiM2tdWXxUihrt/3tsDUwI7vEkUAhbp5WsmJME0ZbiYd1gmTddxei2DIXGZstoUP1ny6naPWqVcGkt/Q86eVwzSweAwJjH7tHyslPes9UAoY=
Received: from DM6PR10CA0019.namprd10.prod.outlook.com (2603:10b6:5:60::32) by
 LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.12; Thu, 15 Dec 2022 16:13:13 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::63) by DM6PR10CA0019.outlook.office365.com
 (2603:10b6:5:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 16:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.12 via Frontend Transport; Thu, 15 Dec 2022 16:13:12 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 10:13:09 -0600
Message-ID: <f46702a5-e53d-42c6-0c78-a70db38084f2@amd.com>
Date:   Thu, 15 Dec 2022 17:13:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [v2] pwm: xilinx: Fix u32 overflow issue in 32-bit width PWM
 mode.
Content-Language: en-US
To:     Kenneth Sloat <ksloat@designlinxhs.com>,
        "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SJ0P222MB0107490C5371B848EF04351CA1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <SJ0P222MB0107490C5371B848EF04351CA1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6e2764-51b7-4154-f57f-08dadeb743cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2x+jmdASgUp4vQ3xlNHq3sRCY9WoU6CcVCJ6P3sQqO2xqvsZLmKMdo0uA8XBVa58r/Lbnz3Cbs48msGfSrI80CWRUJ9tRqZjIvf5m/VQZDTxrc1eNNrpjF6WT5/0HUuCe5ur1M6Y6c79JdLKyYI32AIdjdf2XlRtc9qsXNGtww4SQppr8lmi7i+dKbKa2es9RyYaDbukXE1AfjBOyTYZWfCzd6yH5j/TGdvAgakSKtL/HGKcE0/dHjNin+M8LdIj+SNVGdG5jMl/2U4Y5F4NyPPv6yQHVTx25ovlCwN7btckrNwcw/V0UOHT2cO/tz7wpzRjJCIEnUWLSPJQwIxbxcCZ0Ki3FPn3uDNwLaG9iKJTwaS12ve3WNDVQTgGKHTWtbkT6+nGTRcgR/+1PaJP0bv9+jlwErXSfLxc9LEfcOoLduw1DqNrqAlP90OPc3xEHaSkd0Cqu9JAi3lHKiZ8BX7qH0kdrjZf605PgZPzo24BEi/wZ4yOzTtD7T6ARv9DFoBhl6jd6PQ8Z3+OK7A+rrLU0t3FGsNe4KADArzQNAodqgeuBmSIVJvQrUinoODMHEELyfCB6VCtxSNjlxzcB3F1YV1ERX3g5brF/gy26/hUYZXroNfnRhd7CNLObcxsEhTgAwxq8cbH3MjAz/F2GENR7jE6G5VpGw8mqzZ/WdYrXXZKpIw9/yGnRgPgudWz9v9YPO89csiFlHzlsQ1sjBjxJ2l16ig8RnQ6/Gjf8+2SvihQdaiXJYucPlWrHvuGnJkrEgji1zPj06ub6UusQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(8936002)(31696002)(86362001)(8676002)(81166007)(356005)(5660300002)(44832011)(82740400003)(2906002)(70586007)(70206006)(82310400005)(41300700001)(40480700001)(53546011)(26005)(16526019)(186003)(47076005)(426003)(2616005)(336012)(110136005)(16576012)(316002)(478600001)(40460700003)(31686004)(36756003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 16:13:12.3386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6e2764-51b7-4154-f57f-08dadeb743cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/22 17:07, Kenneth Sloat wrote:
> From: Ken Sloat <ksloat@designlinxhs.com>
> 
> This timer HW supports 8, 16 and 32-bit timer widths. This
> driver currently uses a u32 to store the max possible value
> of the timer. However, statements perform addition of 2 in
> xilinx_pwm_apply() when calculating the period_cycles and
> duty_cycles values. Since priv->max is a u32, this will
> result in an overflow to 1 which will not only be incorrect
> but fail on range comparison. This results in making it
> impossible to set the PWM in this timer mode.
> 
> There are two obvious solutions to the current problem:
> 1. Cast each instance where overflow occurs to u64.
> 2. Change priv->max from a u32 to a u64.
> 
> Solution #1 requires more code modifications, and leaves
> opportunity to introduce similar overflows if other math
> statements are added in the future. These may also go
> undetected if running in non 32-bit timer modes.
> 
> Solution #2 is the much smaller and cleaner approach and
> thus the chosen method in this patch.
> 
> This was tested on a Zynq UltraScale+ with multiple
> instances of the PWM IP.
> 
> Signed-off-by: Ken Sloat <ksloat@designlinxhs.com>
> ---
> Changes in v2:
>          -Update commit comments to explain specifically where this
>          problem occurs as well as compare solutions.
> 
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

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
