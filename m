Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA540628C17
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbiKNW32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiKNW30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:29:26 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557D9140CB;
        Mon, 14 Nov 2022 14:29:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYCc3lgcBaMcg1HJBtPs3aIgQa6HqPpn2nlKbLBVF5emd88zJwyASmU0wsAl5YQinHdF8+7G6wscYkB49LQG4MMnIADodS4YLJtPCbs4hszgPJhoPG+18Cg+Ue8EHuQJlFcVG5Kjk0a73ODiChBoJHmtY+c3ZCmPhyhZSFiEGMVPZ/pSGW+AxNSJJ7eFqGhEHoCnW+YNTB6+pipxECve0T1hqzrMceBbrL2jcGjm6uwAY5ORbt27CZsnBl9xSmfYB3zuZl/hBKTHYpQx0rqCIldVubAcLocL6nh28we720F0YGrUoQEg+/tH4yPI8W5w3xfCG2rx9Y84FPy4eSQmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJzGLUimyd4mqDUTklX765i/qc21asPhTZTRjWGgU/I=;
 b=MvhTPXws9mGA265khPKipZk4lNJmaPtq61OJ7mEoTYFkqloMmV60jzF6bRzMHcXnUyywzrDn01lp8GibLTnFvFmmN5CMf3ysY5mmSgYUVvPcLfJpUg7/URp2qK2AWsoNkk7KX/2GhYZqAc1A3CMS/2EZWiCx2nBiU/r1zsofoKrMUqqo3K3CpZa9al8xAN8AKVNtXMdTlTbogE3hWopX8Fw60uQtXBv5BrcEgNkCou14FNgO5QR6B8GyeAoLKw/JMaXbfM9sXUl8F+GoAvYA4rFeknz4p0pE/jDmZAojTLPxJK7Kn9anTvoUR9hG/YZdNjREnNSe6XaD+uAapAHuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJzGLUimyd4mqDUTklX765i/qc21asPhTZTRjWGgU/I=;
 b=whsIL077aOxo/OY+4/XkP91Bjc26oVSD03fBZGFflnRiFH/UaNo55A/gR/8zErveyGLDmGlHXqz4tvyjY/tE+xZ/TIWZSvqNVyju9LbxJequlYweS+NNsiZonyTBMKg2j1Z0BPl1CsU54awja3vt21jmihbMZfgETbPJ+U1l7CI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4954.namprd12.prod.outlook.com (2603:10b6:610:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 22:29:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 22:29:22 +0000
Message-ID: <76570217-12b0-0501-53b6-45100c3effe1@amd.com>
Date:   Mon, 14 Nov 2022 16:29:19 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 9/9] Documentation: amd-pstate: add amd pstate driver
 mode introduction
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
 <20221110175847.3098728-10-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221110175847.3098728-10-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:610:77::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: 26524a71-a05c-4237-bb85-08dac68fade0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99g/zLTomYtcASkbS4Zk1m5sQZ0rk1IRfp/RfR51phFyXZ7VWqeabIWXQABwdc5kkRtxD6QxeoiAjJ7qoiVmvnQ6W2y4bdvHE5W2NfY8TxC0/u3yiC6AL2bh8BPWVrv9Z4tgmbQiCy4wv6zmRA4fu71Hl1ji18a+y9cWlw7bZWyDysUvOnm2ZLt5YwvWC6WkkVTL1pnU0R6xhBflZNPN7tPhCM7spBDiFqKpBrH6ltZMhU1rXQKAWBoSV/7fD5N7quWju28aDG3tlyeT7y0m76A5nhGfylfSlGco5cnlkU/HFl9Co2/KXnSXaSJxJmi+A25wE9mAmLjP/ATbv0dTxMNMr/MS+rOYVd+tcrI1rkYG98Y+/mUSBKfEM8qpq4dwQ2/I+/YBKYCwzqh3NDYw7Ug6+7G115oB8PSMRBvKKjPTBH5W3BkeR1Qd7cMQlYPZCXYLeZ4r2EKDYHsQdf0CApo4OfS/tCwrR4uztnWagXtcZLPvLr9mSsUwICkEWIakLgXeZzZazXuvFkvbVW1x6Vzxy7RJc2vCHwsbYReX21j27rlHwdcYpGIM95jmzwBYFKM9YL/Hcxm6RQlH2a2JG080p3ypLJnFhOqP5g0LjmvC+OBSRg+55IP+w/bVd1WtDLrWKYoFRmOup52BV2FT6UcLDLqByygx61dePUaBOxqrE+EXZKJwynk3/tpPZSTxFn8MtzrTRN96r4rwL0M+Z8kn03iUNSRFpz/TcdIrxceguyIQZYDicljQYRdpczVhKu1lBMY3AIKqk6wRO7GpLQEjFIy9WS1GAfUDg0YnhoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(2616005)(316002)(66556008)(2906002)(66476007)(36756003)(66946007)(186003)(8676002)(4326008)(31696002)(86362001)(6512007)(31686004)(6666004)(6506007)(83380400001)(5660300002)(6486002)(478600001)(41300700001)(53546011)(26005)(38100700002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRBUkF5WTkwQTAxM3d3SjBzRlFIZ2pEVFFkRVQ2dHJGSmlPVWFUTjFoaE1I?=
 =?utf-8?B?QmJ2Z2F3R0Q3NmpocHJVM29XY0NVRENHbDdIdXVRdHM2UGZXNlFoN05iQzhI?=
 =?utf-8?B?VlhjUVVlaGxuZnZXR0ZpYjhLUmN6QUw5MmZ1emFLQWQwR1RlN21Jc0xNSHdo?=
 =?utf-8?B?WUs4NkZQOVBmVVRESEd6R0dyZm0vYUppNGo4M0V5Rlplcnk5cFVTL2VrMjVv?=
 =?utf-8?B?Y1kvNWFwd2o0cm1HTDJxN0h5OEVoYld6Nk5LaHNpNmVvMHhhVFl6SW0rWmNY?=
 =?utf-8?B?ZC9NSVgzekg4bGpaNVg1M0lFYzM0K2NyUTFnUDBpOWJUUHNkNmJka3BKeHpx?=
 =?utf-8?B?c20rTTU4VzNKZjhQU1haL21UbUh5YWh2cXBjeFp4RFE4RDRiNHhaeWFGNHRC?=
 =?utf-8?B?TitDcDVQSGFnSHVqL05GUDA5YUZNdnpxNE0rSUtXNHdBaUMwakliVnpvd1VL?=
 =?utf-8?B?TDR2NmIxZzZwWHhBb0Nmbzh5OWMweTdqeGp3Y09hVFA0eHJhYmw2YTVzYnZy?=
 =?utf-8?B?VEg1K0tlb1ZBVkVKMGEwY2ROUnpRcVNJWk4zZ3lMNHhBSXkzVDZxeVJGWGFN?=
 =?utf-8?B?ZGdKZlA3T1JrTFRtZG5UTzVBa3dtelVnSXBvRFFORUVGbThMT0RqSWo1UnhK?=
 =?utf-8?B?bklSQmFpMVhYNW1KRFJUcjFJeVgxVy9LUFBmbkRMN29KdklGTHpVRTk5OUQy?=
 =?utf-8?B?cXV2ZjVadnNyemg4MFE0VEh0NW5EWHRrSnZvb3B5ekdFdzZiQi9PZG5DS3hw?=
 =?utf-8?B?WmlzdjA2R0czbWJoOG43WThvZGdRMGdQM1ZidStPWE9raU9LR3ZvZEJzbUJI?=
 =?utf-8?B?N0s4cUYyajJrMjFweGpnSUJpUXpTMlBXNlRkY21TVkRId3RFbHpKazc3ZGdk?=
 =?utf-8?B?NnJ6YWg2N1pDOWVlcW9SYTNPRHdkcGhtaGsrNks1TVh3bEhYU1A3Y3ZSOEph?=
 =?utf-8?B?QklZYjZIUmtWU05oQzBBUHIvOG41dUFmbUtGYVJyUzdZeCtOVTNlVDNjYTlK?=
 =?utf-8?B?SVEyWnJIai9aSDh6S0NHaFAyOU1ucTVialRRRmc0N24vMGFnTEZESzhZREtG?=
 =?utf-8?B?c2dEeUk0QjMrNzN1bE1Nd2FJbTZEZ0FHK3pDeUZObVNzLy9LTERndWNNTk9t?=
 =?utf-8?B?NXp1bFhXS2dVcXpQVmFmMmRhNjVtcWZhK3BIcVhsbUM3WnZCZG9Ddko1cG0w?=
 =?utf-8?B?bHBhVlhCclNzYW9pTGxMSEdISTJYODhrQ0xKNHN3RTJCdk9IV2dGbmJVRk41?=
 =?utf-8?B?MENHRzZkMW9MdUovT1lmditoNWxKdFh5c3lESVZxR2x0L1JxMG5PTmwweVBZ?=
 =?utf-8?B?N1VLTXVDN2Y5MDJWVkV3ZEJNOXJlYlRUTXpzYXRmZ21VcVgweHkzbmdQTER3?=
 =?utf-8?B?MnZlYkljWld4QSsxLytZdEwzbURqNnY1ZFlKQlhucHhmQXFrd0NSQTR1VVRi?=
 =?utf-8?B?d3puVFhKNjBmZWRPd2RpdGpQazBVWFBYSi9RTkZGY1NBSjVLR0w1b3VsR2RG?=
 =?utf-8?B?MmcwbHpHM3NUTDBLQWdUQzZIQkdrNUV1VGNpcFQ1aW0yZ2haVGZFaFpOd0pQ?=
 =?utf-8?B?amRMZ0ZqdUpmVk43TnhFb0U3bTE4dTREcC9KRXFTVGhtclNrUUZ1MGU5cUc3?=
 =?utf-8?B?R29HYmNIS09nYUVMOVZzRnBWSmo2SzNmSmtSUkZIQUpzYk0wR0k3bThCai90?=
 =?utf-8?B?aitOa0MvbHk2NE8zcW5jb21peUZLUi9Gc2wxYzluYUZXQXFVa0JtUzVuNDJR?=
 =?utf-8?B?c0FaQ0R6aGJKalhIbWhPWENyRHM3blJQN0hMbVlwbW1YWWlPU1FNcXdUd3Bl?=
 =?utf-8?B?USt5KzJtZmpyWTB0T1R5NThHbUdYYm0xdVZ6K0Z5cDZEeFlMRFE4czNWdXJ0?=
 =?utf-8?B?bTMrbllzUTlSVThBQnJQTTFlSkpRZC9pcko2b1BsY0ZuTllWaXFHbkExTmoy?=
 =?utf-8?B?b0lYcWU4UXdDS2EyUXIyQlMxWTlENTZZSWlRbExtUHJmN0hEbFVXTk44QXI1?=
 =?utf-8?B?MVJuK3BDMU0zRk1YNW85Q2VpSVVlTkljcXRmREJtK0U4WDhpdzJWcC92eFI3?=
 =?utf-8?B?L21QODdZZHVWcnk3L2xGMC9EZWI3eEp2SjBac2RPQU1TeS85QStVMU4ya256?=
 =?utf-8?Q?HeVi7fMYeTAxkQjktVxaoym7S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26524a71-a05c-4237-bb85-08dac68fade0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 22:29:22.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56Tmtegb4+90l9E+8khkCsZNd3YSQWYzYf+O5VQ4/zz8go6JadBEBST5uhOfK4RkRghuunk43i9g38ssthR+3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4954
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please run this through a spell checker before v5.

On 11/10/2022 11:58, Perry Yuan wrote:
> Introduce ``amd-pstate`` CPPC has two operation modes:
> * CPPC Autonomous (active) mode
> * CPPC non-autonomous (passive) mode.
> active mode and passive mode can be choosed by whith different kernel parameters.

can be chosen by different kernel parameters

> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 47 +++++++++++++++++++--
>   1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index e7488891b12f..6ba02a658b31 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -302,11 +302,11 @@ efficiency frequency management method on AMD processors.
>   Kernel Module Options for ``amd-pstate``
>   =========================================
>   
> -.. _shared_mem:
> +.. legacy_cppc:
>   
> -``shared_mem``
> -Use a module param (shared_mem) to enable related processors manually with
> -**amd_pstate.shared_mem=1**.
> +``legacy_cppc``
> +Use a module param (legacy_cppc) to enable related processors manually with
> +**amd_pstate=legacy_cppc**.
>   Due to the performance issue on the processors with `Shared Memory Support
>   <perf_cap_>`_, we disable it presently and will re-enable this by default
>   once we address performance issue with this solution.
> @@ -321,6 +321,45 @@ If the CPU flags have ``cppc``, then this processor supports `Full MSR Support
>   <perf_cap_>`_. Otherwise, it supports `Shared Memory Support <perf_cap_>`_.
>   
>   
> +AMD Pstae Driver Operation Modes

Pstate

> +=================================
> +
> +``amd-pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
> +CPPC non-autonomous(passive) mode.
> +active mode and passive mode can be choosed by whith different kernel parameters.

can be chosen by different kernel parameters

> +When in Autonomous mode, CPPC ignores requests done in the Desired Performance
> +Target register and takes into account only the values set to the Minimum requested
> +performance, Maximum requested performance, and Energy Performance Preference
> +registers. When Autonomous is disabled, it only considers the Desired Performance Target.
> +
> +Active Mode
> +------------
> +
> +``amd-pstate-epp``
> +
> +This is the low-level firmware control mode which is implemented by ``amd-pstate-epp``
> +driver with ``amd-pstate=active`` passed to the kernel in the command line.
> +In this mode, ``amd-pstate-epp`` driver provides a hint to the hardware if software
> +wants to bias toward performance (0x0) or energy efficiency (0xff) to the CPPC firmware.
> +then CPPC power algorithm will calculate the runtime workload and adjust the realtime
> +cores frequency according to the power supply and thermal, core voltage and some other
> +hardware conditions.
> +
> +Passive Mode
> +------------
> +
> +``amd-pstate``
> +
> +It will be enabled if the ``amd_pstate=passive`` is passed to the kernel in the command line.
> +In this mode, ``amd-pstate``driver software specifies a desired QoS target in the CPPC
> +performance scale as a relative number. This can be expressed as percentage of nominal
> +performance (infrastructure max). Below the nominal sustained performance level,
> +desired performance expresses the average performance level of the processor subject
> +to the Performance Reduction Tolerance register. Above the nominal performance level,
> +processor must provide at least nominal performance requested and go higher if current
> +operating conditions allow.
> +
> +
>   ``cpupower`` tool support for ``amd-pstate``
>   ===============================================
>   

