Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B939A722464
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjFELQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjFELQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:16:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331E2F3;
        Mon,  5 Jun 2023 04:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M04ONzdWUttNjczhQkVCTRHIRE3/s/UZAjrnre92TOYTKBayvYPWZsnU/WhbetxKfsjzutgRvkxU3PhX4EKYXphrsHHy66uwHKDf2T/xjD3iDx5ltijkfFfrG/CQp8242Mc9hqPJ2mvcX4YfBQ0bgNNjlIEbdtVl42OQ2qCaV9rRdaRAOOlfE8YY+9OfbaPydM+nPdF+UAze25sxF3CH7a8xarx/7zKZOn4BQY90WQoWGFrwO6QuOOyVP0VeqcND62nsG/d2ANjD+uiyjymAT8S4I7HYd/wMn7GZDzvBeJqt7Vmomn4vi5baUiZaTHQyD0fGQ37NxY3s6VkkcnWMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdHdOaQmZ8Nle8zQxmpL4UFLD4BldHvfVsRDxwXF9TQ=;
 b=URpvbKD4Gd6Dci6QpTVnHIXzf6KjzS3fRbU/9tUI1QqbC8IoGR9uSikF55H7NkeruA0QkW0Sw8sgA3HFI8Sq0kzZ72JwbuBSyr9YQ0QOIccV40HtcmL6gcf6Y0Zf96pL1scdmfBOuns+VodDzCQiqJQ8s/+zQyv+dPU+Hc+78hjfgnGTGTN8NBICu20UwCkO7eE2n4CaAzaLQS7WyaFrYQL+NDEJM7EsE+e5O/FAV9FeSKejFpNTR2kPd6PH9OwxJuj8cBz7m+xcgDn69uIp3Xta4CE8e5CkYnRieY+h6QFZP9O1889Zt2ACf9o6KktVnjTo2lAM9DBjVfvZYiULXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdHdOaQmZ8Nle8zQxmpL4UFLD4BldHvfVsRDxwXF9TQ=;
 b=3oWcPBfCX+kzjVWgtfHfDGRdlc7lub1PfA8DgJqkcXZvv69HgQBsTZ/meWIsG09WuEM89TOKsOVKkMJdZRnhcY2t8wck6Nppv6VvvphCXKyjsvsedLsBvkJ3fkqbDQuXRWIjyr48nS+L6w7K4ehuA304+knM0EmwwfILdhtepO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 11:16:42 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 11:16:42 +0000
Message-ID: <6a8c7157-9632-e07d-0ba3-ee55d73dd9e3@amd.com>
Date:   Mon, 5 Jun 2023 13:16:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 5/6] arm64: zynqmp: Add pmu interrupt-affinity
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1684767562.git.michal.simek@amd.com>
 <dde2e4b5ac6018adb9bfae05bb3800af6b7c0f0e.1684767562.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <dde2e4b5ac6018adb9bfae05bb3800af6b7c0f0e.1684767562.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4b14b0-e2cb-4387-32ec-08db65b656c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81dNrwzSlHTY0P1TsDjufia8ojOp1xOS3D7Rn8F9Ktd14XIWrXKFNVS+3EP0K4Pesn7FGB4ALRj97lMjDXcT94RIXX7AqOV+qURYC2yXVJx2rDp3QrVSMgd4gjINpDV370Ob/r/93euv7YfOJfnDwuNEDl+5fZCQUcv/Gn+fjZBF982M0/GH/aNvWyx8WaWqgOJjyNVVMYsPyxM/SX1i5INjVHNwwUcNrH8U4gzvb/F4IfXKv5ZxKjAwgnlRE4m+47oEx/Grob0u7uY51g2YvkOUum/9ZeUQSgGz7JrtFFRHPetp9Fe1JDdhrZOyA4J2dZphGtOh+bqnd/uaRB0gEpZVb+EixqxlnygUtlqnOzCJ2RkstqycUEWLtygvfFv/arXVPMwiKZo6EoBxwNwC/C47eAnvqNfFwJW3trEBNqEkmCxWvNdSuDIx4myGoIYEk6AsAq5vQ9CD3j33ORhrSUUXDewIFuCja7T8rrpJSI4s21Zg/mMUgTZYqOQAdZqpzQ8+/c9/wMlDej1ZY5hdIdGf7HWIcgDPjJ6iUnU74i7J30z5oqHpEHOHpZQHGrcGXREGBEjGfqu3BIrUOQaHp82YBbsk1VdTTn8VZP/IBq470TPwT1Pvrg7fSv4niJTXCOYn0WEeWA8biPIhazx9nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(54906003)(478600001)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(6666004)(6486002)(53546011)(6512007)(26005)(6506007)(31696002)(86362001)(44832011)(5660300002)(7416002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2kyeFpOR2dmRndBMVJLQ2ZhckdtNEZlL0JsQXB1dW1ranY4NEtzdkhQbzlH?=
 =?utf-8?B?ZVh2bUZQSzlxSklWQVlscHJmRjRJSWQxMmxXZ01wUVg3RTZZMzU4N1A0Mmly?=
 =?utf-8?B?NzlidGNuMnpQTUx3ellQakluazRNRnA5ZzhQc29ZN0NRaERzMUIxNzdiL3c0?=
 =?utf-8?B?aXRTeW9HOEZSK1lMTGpJRE44WkhPUFhvMVVSRFU3bVNiaEcxbVo0ZjJoYUlO?=
 =?utf-8?B?ZFlLRUU4dHJSSit1MWhPdFVET0wrRFZjajc5cHJBT0FIUTA5WDFRZ25NNTVM?=
 =?utf-8?B?eXF5NEtlT3h0d0krbjBPaTVoci9MZ24zM0JiZWZtZ3lvQmNUNDJ2dlNzRmZR?=
 =?utf-8?B?Y0JvMU5rV2FZbjRPTHg2NG9GdDd4cFRndGFTQjJEczZOak4zUTdpZjF6Q1Bi?=
 =?utf-8?B?QytiMVNvQzNSZm4rc3BXTEVpVDluVnRUR3R3dWs2K1BhTHYzeDlhRGRsNEt3?=
 =?utf-8?B?MUFhTVVzQjdHdjZmLzVXQUVZeFF5Y3RnWktMdDBuUFQ0MzJ2emNUWldvT0JE?=
 =?utf-8?B?Z1FRTnNZZkhHTjRQSU82TllUdDZDVEhQbTQ5VWZLc2lWL25SczJGN2Y1UFFR?=
 =?utf-8?B?NHlOUzJMcFcrN2JPVGR6Sk1zY2NRSDlsLzgvWVl1V3lEOVpvcEYyc1dvamRR?=
 =?utf-8?B?NmNINFJ2ZDczaEsvNmNUSm91QWt3V2phNFNkVEFvWGE4dTZiUHRYZ1BQN013?=
 =?utf-8?B?eDRSQzFkUzJySGFYcnlDMFZqNlZnSmZWT3NlWkVGSm1wUWxEZU9zb1JQZFZu?=
 =?utf-8?B?UGdyYmlOZThMbXAwQWZzMVNIU201b2ZlQ3V1dkhMSzN1TTZMUDAyZ2xCQzRB?=
 =?utf-8?B?Y0hZZUtEalJPRnpHTEJ2eGNvUXNZOW90ZE41WXdtMlZhVlE4Sm1lTkpCakoy?=
 =?utf-8?B?bVZkanpaVisxbWptZUFjZzhxVW82eVdYYmdabW1VeFIrWnZOU1Q0Smlmdzhi?=
 =?utf-8?B?VzMrQlFGTFgvZ3l3TmFLYWQvMTNSaXRQdG5KSEJUc2RtSFdRWVpkZzRSeWQy?=
 =?utf-8?B?Lzg5YzVwZloyNHhZUGNLbm9GN0xMaGFzTkU2MDBiVDJaVHYyeEFzUTBOVXp6?=
 =?utf-8?B?ZW54ZmlsUzJGUktHZGZSYXZZSXNETGt0SHl1d29EcmVyWFJtUkxwZWJYaXgz?=
 =?utf-8?B?S1Zodm9HZjhDL3J3a0F5cFZOc2c1TVN1SGc3K2lRVEdrd0xlUG42dW5TaHE2?=
 =?utf-8?B?YTVhZGQxUWNaOXJSUlJJVk40eEdXakcwVVNiMVdnNkowYWFjQlBNOTQ2bXFv?=
 =?utf-8?B?ZUNNd1FVZ1pLMFUwTVpiTDJqdGgvVnplSXVnK25yRXhWdWtSRklkTnA0ZVBY?=
 =?utf-8?B?Z0NKNWw1elp2VEIwTmJEUy8rQ3d4dTViWjVIaTFnbFhGOWhyYk1OWWlQYU01?=
 =?utf-8?B?RWFScE1sY3ZHRjUwcVpVN0V4VjUwbGp2aXBPN3JLREM4NVZQOXlaYzlnU0NL?=
 =?utf-8?B?UUxuS0gvYloyZVNPM245M1pRZ3c5U3Q1Y3EyTmxPeDlqeXcvY2ZBNjNNdzVw?=
 =?utf-8?B?RFA1ZXBzU29mQTRWODVLeFNrbHUzRE1sNlhGcHp6WFZ4QTBkTjcwcXpYeHZU?=
 =?utf-8?B?UGxUK3JUNmFHK25WQndWMWVNNGRYRFRhNmtvcjVVT0RNZ0ZHbzE4blcvVFpH?=
 =?utf-8?B?QldrKzlQSHdYWlA5ZVI5Uy82NDBzeTB6WjZHdUc0SS96cmJBelA4R1lRMW9V?=
 =?utf-8?B?d0xhSHV4RVFmUVNrVSs4b04zQW9FMk4wK0swNWpDbEpTVlZWdGZXNDJPeDc5?=
 =?utf-8?B?U0ZxYXhoOXdVcklUeW5PVDlKZ1lTWXhNM0tybkwrZ0R3OGR2YmdwR2pOYWVm?=
 =?utf-8?B?U2hnaVJQN0RlcjVzRXA3RmE3VnY2dmNYTkFmY1M1b3lTYmYwZlBzSjFtRHVv?=
 =?utf-8?B?dVNWS05tUG82b1E0ZTIrYVloVkszeUV5RTBnV2tlZjZRNURwQzFwQ0IwR3lZ?=
 =?utf-8?B?Y2ZUclpnZElIUW16SURmYTd4Slhsb1RTNnJWd0U0R1Nva2FLbDEvdUJCSnJU?=
 =?utf-8?B?UStRZ2tFZDUyL1FCdGN4cGlaOFVvWHBaVWNtcVNaanVjbGR0Tm1hNTArOWV2?=
 =?utf-8?B?cmNTTnRJVVNaZUN6MExuZFpISmtkbnkvQ3YzMnJQNlBjekdyU29SSWkwYWxh?=
 =?utf-8?Q?4lVsSbu3y4/gvS47WsEyYXDC9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4b14b0-e2cb-4387-32ec-08db65b656c3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 11:16:41.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q23aaURRle8zQJbNFaVFhUhuWG2shq1M96CQcWS3eVZu1XunAHFMqFCvu/8cFPC4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 16:59, Michal Simek wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> Based on dt-binding "This property should present when there is more than a
> single SPI" that's also case that's why explicitly specify interrupt
> affinity to avoid incorrect usage.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Update commit message to remove OS content - reported by Laurent
> 
> This avoids the following error upon linux boot:
> armv8-pmu pmu: hw perfevents: no interrupt-affinity property,
> guessing.
> 
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 02bd75900238..fc5e21bc647c 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -164,6 +164,10 @@ pmu {
>   			     <0 144 4>,
>   			     <0 145 4>,
>   			     <0 146 4>;
> +		interrupt-affinity = <&cpu0>,
> +				     <&cpu1>,
> +				     <&cpu2>,
> +				     <&cpu3>;
>   	};
>   
>   	psci {

Applied.
M
