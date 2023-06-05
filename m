Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD772226B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjFEJns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjFEJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:43:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218C8DC;
        Mon,  5 Jun 2023 02:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGQJl61xwDRjyL4xF5SxNZYfAgt2RPtBlp0+iCNXRi0NWK6mpvGogAOJCakp5Qct4NVdHpcvKJkUHev7wFclprKQPYGSYs//ekJ9wuTxkVgnkGXZU3AxWb1UXX0TYDKECAVHvmNaivZFiHQUHe/KxEjbqMJMHgB668kTDAoCTonwivQznKyTyq3fmL2P4UZj3RMNdkPoKOXybDJSv7u5R4B9wSP//JQIpBn3sm7J9Zhl283SBMaxzVWiRDsJ918jLRoArqS2z4uyiWXw8wbfBkDlzugo7v+Lz8v/MwyqnHiQDAQXtvla2Qciso1PLKNybeGXrJN5SFXx4ETlH0Uq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROuXnT2KWbrXegPetQftB0S2Y+gnxsKI1WWjEq3oom0=;
 b=dahkzt8mL8YQ+mZg/a5NySjXuWtYmHQLU2J0Pnk3/4t5X5QYTlbRPuQzrnbtelb0MNb1DOJpqyQnbxYy8rYH6+VkA7TGy1yA+dOAx5M8v+U6yuUIuKPZ+JhbCqQC8iMM19GzHcq/Mmwck8OQ+UKApTNUqrK9fEzLvGOGVnwYXBJL8jowaiSgSyZnHINN+ed0OXTUgOXgSAXIa5vUWF+07Syx6BK91913SPuuI5Dp85djQIWCmAz93jpEbDDt7ceUm9yZiSvKpKx0ECtH5ipNIU5s3eJ8W9AsrkE+X3EGgJAZGHMUUEkUV4Un+QlMwVipI1xSdozLjV+13tzkVO2mDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROuXnT2KWbrXegPetQftB0S2Y+gnxsKI1WWjEq3oom0=;
 b=mcGoY63QnVFpvDVWPznwm2XW7eQ7ZtANFlEYXbO8YzUwagXkqM4MnO5UPL+hnFcgDySfpo4UzEc6YrPHFvpd25xfz7N8KRCgYFsQ8JCq6c/dfTLdoXjnwsWFDhcsuowZ9u0s/hvsCip2Je6024zRHeH5depwPNPgfdL28JKXC2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 09:43:41 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:43:41 +0000
Message-ID: <86855162-d792-c339-d71b-f016064877d8@amd.com>
Date:   Mon, 5 Jun 2023 15:13:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jolsa@kernel.org, irogers@google.com, bp@alien8.de,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
 <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
 <20230605092731.GZ4253@hirez.programming.kicks-ass.net>
 <20230605093400.GK38236@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230605093400.GK38236@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d26c36-fc7b-403c-62c0-08db65a95857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYYF+81CyH3ek18jsLL+iClpjfZaOT6HYqaElvzIMWCyfbq6F0tL1pUX6CU2zy3+UPzXVGV/uBbWNgotdV5bAMfYNFTzYHfcOZ4FtKCkguCw5jU7gwdbX0i5OkrbneBLirgxoIRywTQoxZ7gdF7ZHKAll+KAVhdxume72pJOc+vVMdiWzaM9ab1sc6LF9RYIvC7iPu9nYBlLmptuk+gUble5OdN1d6zM0jx3D8gEQrtmLGVAu3gdaElILHP8tKnWq7YfbOy0Xp0WwIy9eBdNw2nR2pETQgC0Myxm4SnF4JlcTymAnv/HMIat1nyCfBhxExOq44ao2j2igcume+sZ/aj5QJeCVv3tZ+Db4mR7HzbAoeFpbitsNseBEkqPppfouN1CgJ+2h2GH5Q0gHx30zQPLh7E6ufS5ucfi5csi5KEBVmR3M/hWVgtPKQ/eKQcyMGPWrx7oobvNL2uqko5iVcmOG2vfgSf/Cj4Mu2LLRVrNIxjec80Dwl3tojQinZMDNGYJi6PqsxVKv4BrHzRntbe7Bb3VPOlvhN/w7pBQvEvWx8ofaZOeMDK1F4fHZ8Dwf+PpGxXxs4OsWMWqWBuDwIWw9lgqrHjoWy3tRop4cpcmyNnHusSJkF1SKyVP3C+jyu7KfGDUxGj5SifEXH/ySQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(83380400001)(4744005)(2906002)(2616005)(36756003)(86362001)(31696002)(38100700002)(6486002)(316002)(41300700001)(6666004)(5660300002)(8676002)(8936002)(110136005)(54906003)(478600001)(66556008)(66946007)(66476007)(4326008)(31686004)(6506007)(53546011)(6512007)(26005)(186003)(7416002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG5ZeDUyL2FVVmpFOUVyak8ybzZkbGZ5N1k3bkdWTzV4ZXJzY2tVU2NOYStW?=
 =?utf-8?B?Zm4xQUhSM3pqYVN3am5IR0VnL0NuSFpCanZDTStVby8xeGh6YW1GSmtFL1pr?=
 =?utf-8?B?Q2tSeThmRWpJdTRHSVdneEsvU3o3YmxzSFNENG5JSFFYZmN2ckcyb0dDOWY5?=
 =?utf-8?B?NThveTFRSW0zREZPR1Vla2dQNTR2cmxrNTB1bks2ejhyOVFOUFRHRTl1bjZV?=
 =?utf-8?B?K3JHaFlkYjk1RjZZcnBEZXBIOGkraEpnMkExeVpMVnJub3M1RFQ1bDd3dXRV?=
 =?utf-8?B?MFJwSXNWbUpWa2xlQjUwSWFCNm1YbGdUZmdzVHFZUk1wWmVhd1puWVNxNldx?=
 =?utf-8?B?a3BERHRSV1NaZTBEM2FEaW1MeGp4dU53dzhEeXBFT3pqNHl5cW5ha0tOd2xv?=
 =?utf-8?B?UXZhK3RkeUNENU5acW54R1J4Mmt5clZjYXlDSHppbEZ1WE8rbU5HVXdtanBI?=
 =?utf-8?B?WEpjRWNXZjQ1SG4wTDYyQlkzYXBNTm9JdkY5OGxQc3UzRjZTWk95R2I1bHlV?=
 =?utf-8?B?SUhtOXlwSFBzSGRyTXFMNkN0NmdUWElEUVlpSW44cCt2QjMwZ3dsbEJPOEM1?=
 =?utf-8?B?NDFKZWpmUG9PRy9JTjRxanVIR3U5RWZQK1Q5VWxGZUN0MWJWVmEwNVMyWlV0?=
 =?utf-8?B?Nm9zTUE5N25hNTZxYUNIUWtESzM0UTVsdmtLcFdlUTkrdmx6bnFnamNueUYy?=
 =?utf-8?B?QS9TOGozY0Vta3VPS2lHYjJYcDRMK2lpaHdFSHhLSDFWYVpXTmpVT2VXRXhi?=
 =?utf-8?B?ODRsNUtWU0ZDWXNaVHAvMkRyOGlXKzBCbXE0MTBheEVZK3BDSll5WkhESlEw?=
 =?utf-8?B?RlNPM3E5WlU0M0YvaVNIb0diTDNCSzlzV1MyNTNIR0ZmeWxtT0xuM1ZhMkJp?=
 =?utf-8?B?bFpJbmN5K3BrZ0JBQW9NZ05yZ0t2blNOTm9zVzVPY053MmF5ZDJadGh0MVdC?=
 =?utf-8?B?U2FzZW15aVJvRTJsdmpudmluZkNSaDVoTG96RVFmMVFsQWs4SFgrTFNOTVA0?=
 =?utf-8?B?ZDZBUWhvUTV6OFFLeWhtK05mRjZwcG91Y0tEWkUwR3d5ZE5XeHlpbWtwMVp0?=
 =?utf-8?B?T3BZazIvRzE5VXplRkY2WHpaVUFhU1pFaVFwT21iTHhwdE1qVlJkYisrWVZo?=
 =?utf-8?B?bkp3MmxvU1lyM0FXODBVYWQzRUR5S3o4aHoxSW9mL0tIc0oydzBHKzZCcG0v?=
 =?utf-8?B?NkgwMDEzYm4rMGorU0QwV0pIRVZMUjVUakc0OWZUNzkrUFVFNytNOUFLb0Yr?=
 =?utf-8?B?NUwxc016WCt6NFRFaytyclZMUmpyY0RLbmx6NFZxeitJMUZpR0R6bmVJRGZS?=
 =?utf-8?B?Ymh3NWl2QmNkSzliYXB6MUdqMDVOQVpUM2hNSVhaMjBDYlI2UERBSGdWKzkz?=
 =?utf-8?B?NENoWm9wMG40UVN6a0N2SGplUXg4bEVhTTRPTTBtOGViek5ZTUN1cmdGMC9k?=
 =?utf-8?B?UW1abmxBcWExb1FPS1cxcTFIMWFmNHdFbTZQL3FzUmdxMVUrdGpUR0JtekdT?=
 =?utf-8?B?TE1sNGk4TXRUOGRnTkRVNE9ZZDZQYW9TemdOS0xSYis2SXVlYnRyMUYyS0Y3?=
 =?utf-8?B?dXZMbFM0anVUTjM1dXFsWUxPcWV1cUI3WEhjWi9YL001ZEpKdGtxT2g0QnM1?=
 =?utf-8?B?QmJlN0l3MS9QZjF2bHArL0psd2YyOGtDb2NqVTZVZVJEeEx5TWJpcVlreUF5?=
 =?utf-8?B?RmloV1I2QmdMbmtJSkl6Q3BJTmUwd3Q4THR2WlE3VUQ0d3c5K2lXU3F4Y1E2?=
 =?utf-8?B?RCtSdUVGMjlwNjN2TjBxV3FmblVyY0FLMi9hMHBhK0QxRVJyWVRrVTI0U3Nt?=
 =?utf-8?B?cnkzNktPdkI1NzBZaE9jU2VCc2NoSkFGYnZzbjV0WnZIQStSWUNzRVNXUjFj?=
 =?utf-8?B?bnNUc3gyTG1HSDNvSEZZcnlVZVNOZVhRZVhWUStWQUhaUjNya29ObFhxR0Mv?=
 =?utf-8?B?YXlYd1dTTlY1Z1loOHg5VXZWS1RUaWFiQkxXeXc1ZHRBcmJCOThQTHl6Ym4w?=
 =?utf-8?B?STYwVEdaZzZ6Z1hWa2ZsN0F1WExnTTdQRDl2cXJKR3BJVW5ReUZRZU9kajkx?=
 =?utf-8?B?NmpxR2d1RUErYlNFYzZrcW0wUFU3Y2p6UzYxZVVuR3BJL0loOTVnRlgyYWtR?=
 =?utf-8?Q?m5Al7pi/SLjXQRnSGsO1TRloh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d26c36-fc7b-403c-62c0-08db65a95857
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 09:43:41.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBms/7opkHNom245FL4D+aQda3GgrC6n49tNEuF7o16rHqTs1NhEXHvtaDfaJuePbd3hAsHta+IHiVKncaKRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-Jun-23 3:04 PM, Peter Zijlstra wrote:
> On Mon, Jun 05, 2023 at 11:27:31AM +0200, Peter Zijlstra wrote:
>> On Mon, Jun 05, 2023 at 08:10:15AM +0100, Mark Rutland wrote:
>>
>>> How does this work on x86? Do you have pseudo-PMUs for PERF_TYPE_HARDWARE and
>>> PERF_TYPE_RAW ?
>>
>> Generic code maps TYPE_HARDWARE and TYPE_HW_CACHE to TYPE_RAW for a
>> first go, only if that fails it will try the actual type.
>>
>> And x86 has the (first) CPU PMU has TYPE_RAW, on hybrid, it will
>> transparently pick the right actual PMU.
> 
> Oh, I might've misread that last bit.. TYPE_RAW is always the big core,
> it will not magic the thing. If you want little events you gotta
> manually find the little pmu.

"manually find the little pmu" ... which was being done by linear searching?

Thanks,
Ravi
