Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C415645CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiLGOmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:42:37 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1509E266C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 06:42:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALrgfkb6zZrNXgptRWRF2KTFnTKKUMZmKU1D5z/9A1BhnP/a/gCDxdPOe+zssJ1vyqj11YRwtWUEB1j3X8vTp049NzqP7MqXj+caJ86cggzTyyiIs26IiE7FAyUrAwSehvVkS1RJYpDlw4RdfyX3P6Fz3nKT5gcMZgmOCcb7z+MDszt3lHHpVGbyfY7t4xuUXLf4Yx1zmnf5Oo58yoc6QgeHnkPn3W61wYCQJmzspY3Gt5Z6I2Q7vOUHvdxbZqLaqiLT4NDd0kqemRaFApuvvAeYtQVzqXsyoz015pWTCjW+XFqmN4KIVOqgfx0IDyODez1yL9/8YYSv3nbWPXr4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7d3kb5B2ez54HRT926x65Fmjlek5gN/1tThS2aTKaI=;
 b=kTOTEYu8Atbfs1X7c72/AKqCXKVzqUeovm6CJcTvR0iYis+sTZ6vuqMySd7WLQIYTk215g+329DQBQHiy4qBhEUGj1yWNqYOtrPDsE5H2Cfq0qtKZGR27yPw0OKpS69VUgylxkojldNCkZFKrzs8nvYO178IAz54HfnxtiVUF6Vhr7GjSTQ8eNqiHHRRl4K/2+OUKHUZsWdn7tICN9mqmm/zsheRAz1CinSYbzqzmXblT9afnTH3wogcQS6o0MxI7majT/d+Bh6OJ6AgzynYFfLF/nlZTNMGO5e55CPKvJsQDml62BF33MmpCTXJgX/UleA41bkSuDH1zAN7Z41XIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7d3kb5B2ez54HRT926x65Fmjlek5gN/1tThS2aTKaI=;
 b=QbsdwnNwlcUPEyfEel+G13b/5ArsirKxOf70xG5sbCdUUYuUWuWxdAqdasRlFKAVmliBqiIL1LwQ1yg3mA79WAS5ub2JTIfE+AgDECbyS+ZxRhZenWl9SXuEGboqEmjKckJE2ipP/bC3gJO9KnX5J2+QtKYWXShP37Emj81k6DA=
Received: from DM6PR12CA0002.namprd12.prod.outlook.com (2603:10b6:5:1c0::15)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 14:42:33 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::89) by DM6PR12CA0002.outlook.office365.com
 (2603:10b6:5:1c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 14:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 14:42:32 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 08:42:27 -0600
Message-ID: <d1abd7c7-299b-4a2b-456c-2c0e0ef6436a@amd.com>
Date:   Wed, 7 Dec 2022 15:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] ARM: zynq: Fix refcount leak in zynq_early_slcr_init
Content-Language: en-US
To:     Qiheng Lin <linqiheng@huawei.com>
CC:     <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221129140544.41293-1-linqiheng@huawei.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221129140544.41293-1-linqiheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1a7f79-e59c-425c-59d0-08dad8614639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3JDl+s0Jv1h9Iupca+lIKJzORJ2fFImiA+ds5gNQhN/uqAYjCrXuKLb70chZ+jc9MLcavlIFRp24z/WSvDNEVTony2de1lNfMk3EgQW7BNhAY9El/jiHzy7LQyV0hYR9QXL33/LaTj7fWPpbn5C7fnqU5VUbVAdl1uJq40ZJHuNfRfFO7JkWwayojHNasht44wiBpYDQ2nEiOMtFXD0/lUtgie3rlsNPQmLRuQvwV1lz2qk2uxDa6hQVg6aRc5TGCioOz7XcKS+rBeJb/i5BQCWTmbn2Eg9/T9T6OiHJnW9fmxtW5WyWiv+cY++y5tvOj0YHVex+qYIn82rJhnok3818Wl4lCR/gzwdMmL4ijUjgd0BMgmBNWOumN5WxF9EeWH5GkJCLQINwSKnWhceyIARJwxzpaZAYQ90Nkz9FW1iYL4amIGxvDsdKxRDhWClfc2Z4rkyRuy7hbvuvywxW1a2dEVa0Y8y7YFd2LwNsi6n4asNFOX0V3z8XpFWZl2tirXvJacMBwGsid9XouB5IXsMPx/Oz1iX5VW00YCYp61m0bOhLcdKjK5gLY15qZ596wLp9XgAogc83+wX5UH16EKOsm72RP8ZvGtg5i+NRMGPZWBZaYPT50/AA1iUlEybhrEjh2GBJAFkfLq7iJWrUOh63twEQ6BXuJF9eCwdxs8EoNNLCYnM09AgX6mngRgZNMYmnYBXy3bYKMbGkMWI/aevXJteRcKdibcaWwNaLB6ZPp9fmTi6rwiQy2gF876Caf+ndUS/XQZtiK/dr/KkceA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(40480700001)(8936002)(4744005)(53546011)(47076005)(426003)(44832011)(186003)(86362001)(26005)(40460700003)(336012)(2616005)(16526019)(2906002)(31686004)(6666004)(6916009)(36860700001)(54906003)(36756003)(82740400003)(4326008)(70206006)(41300700001)(8676002)(31696002)(70586007)(16576012)(478600001)(81166007)(356005)(316002)(82310400005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 14:42:32.7000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1a7f79-e59c-425c-59d0-08dad8614639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/29/22 15:05, Qiheng Lin wrote:
> 
> of_find_compatible_node() returns a node pointer with refcount incremented,
> we should use of_node_put() on error path.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 3329659df030 ("ARM: zynq: Simplify SLCR initialization")
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
> ---
>   arch/arm/mach-zynq/slcr.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
> index 37707614885a..9765b3f4c2fc 100644
> --- a/arch/arm/mach-zynq/slcr.c
> +++ b/arch/arm/mach-zynq/slcr.c
> @@ -213,6 +213,7 @@ int __init zynq_early_slcr_init(void)
>          zynq_slcr_regmap = syscon_regmap_lookup_by_compatible("xlnx,zynq-slcr");
>          if (IS_ERR(zynq_slcr_regmap)) {
>                  pr_err("%s: failed to find zynq-slcr\n", __func__);
> +               of_node_put(np);
>                  return -ENODEV;
>          }
> 
> --
> 2.32.0
> 

Applied.

Thanks,
Michal
