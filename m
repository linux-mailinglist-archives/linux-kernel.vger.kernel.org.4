Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8317A6E139B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDMReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDMReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:34:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1903977C;
        Thu, 13 Apr 2023 10:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsd+LYa/pelZbkn5y4zCHZfCcQFziKxrqWph7TKOVcGlRsdOoNgMfPLvZZS81tAlb6BHSqQSCRg6cOHSEJQAehC9Cd9amz2mcBrAQJVdJo8+vn0evQqzx9XttayOLfAKTYOpJ1ChwMxoB4OCU0dKlqBzzicACFNQmNXiWo/8jf1OE+ZbMT257vGefr5Y63Qwpx190U9QE5vjXKNaZIf24e7JVaDUZnFpsj2DXiG3MDa9bpN6wq80cJIyTtHhVlrBdAcsB/xUIH2YGWuyDWxhvUSQCMNgMJtbfOqHEh5AEjPkreId1/7tl4fyuyED/fBAJ/B/IuA6ugwUA3+OMiOYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xv4IrEk9BXuGKLvWDDChBDDWrykBDP8i7wODUNendvw=;
 b=SUGh34RqQBPzdMsJu2IjfOHVNYAapJ1lQ8B/nx5oG+xWNa6yd3usVuxq48pLG6fsIOsGGOzKSWa+5bx5V2mWEzg3gy5Kdo/cfGjlwm+9cfhkdwZFzU0tyx8wkW4+y0xJv2qnKNtPlz1OlpjbMinBNWJAqqiQ6Qc8SRrdcfiV9KIaUucB+Trd4z2Q7WXlDp/sfmarKH6sYAujIFtEDldG/Qj3e2h2wxqLODA3skVoJn+ymZJbQjO9Re7SOJvKlh9gdcBJtnM6c8+UlscOdSzMD/sv9Ae6cfm4UIpanN30oDoAwvrHtoqO5IOahtwxOx+VaVszTR/qFu2QzQzMNPUi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv4IrEk9BXuGKLvWDDChBDDWrykBDP8i7wODUNendvw=;
 b=HYCm4pv40TKJ2G1DKwgJdYvXmicVPSEpAdqsbiqtFfIgxqNmlLPUGieKyCpSldbTSP6BK4csiaAX6+bJcFZZyV5nfNF++bi8dTSx7nFJKN/B6l3bzTxd//q0OHdoJFtpLH1m2uti8WMTZqTNSY2Eq7A2ZjiDewQzfZ3OIC57yK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 17:34:03 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd%3]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 17:34:02 +0000
Message-ID: <10b8610d-0950-57cf-4fc7-202ce69d28a3@amd.com>
Date:   Thu, 13 Apr 2023 23:03:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/2] arch/x86: Set L2 Cache ID on AMD processors
Content-Language: en-US
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org
References: <20230410163527.1626-1-kprateek.nayak@amd.com>
 <1730486.opmyjpaWMg@natalenko.name>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <1730486.opmyjpaWMg@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::19) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 481e8272-ba2d-4458-ab00-08db3c4545c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ty0K+jkKJfL1Tg7ta26C3IlQL8u4/xTFYQP8oxT8FnPdPsSoS3nCqVpVri2tN/hVCWqNhbD/t3nUUMwbvPPadr49zemG7lV4lEK2xXVUvDxC6Pt7S3AMBwzB5i4clWYCdzyBuGxHQC/R7AAL5A/pAj+pCEH2HKHM5yY383g5sbVEpZwxCtZlIVmDFLGcL2yOxlwcPO86eFnp5ODiT5XWh8Irczw8ie3vHNblQoG/p7+iKdLaKwXahJHIoOXldgSssCYd/sZj5/b7s33TXdcuS2qK37Fd1oZU36ImT8Awoi+hZbBJ+jGcejFf5VON3cCL/FqN0UBffkEHjLkk2o1NnqnE/rxBrDhSHWQpaKSHh41UZ0KnSI0z1OuQCbH3XmxnMFcvxDmgpI7ZiVhajoe2zyYDqdfr/xexwuJYKeRHb4IyCkaYr3i6SDDiLffw3UR1LmqvuB3BrHl4ijMPFI9bxZfO+51cC05HnN1iSBKjtzRnRNiys6OgAUKCsYJvd1UtbU7930yYc4jguuqMNqWk+YaW1Wd9cR69orTMsN72a3yP620ktqVWjTWyjgKl0WAvVzDWSsz98zWvi8WB1p9cen9N5RoCWz10nFDkzZaG7N8rAFPE5ECM78HJB6GHYR7PsdzBGgKLEMi5esE39MaDLHEvCMTIEj3dgs+O7OtRfbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199021)(66476007)(66556008)(66946007)(316002)(4326008)(2616005)(66574015)(83380400001)(6486002)(478600001)(8676002)(8936002)(41300700001)(38100700002)(6666004)(2906002)(5660300002)(7416002)(26005)(53546011)(31686004)(6512007)(186003)(6506007)(86362001)(31696002)(36756003)(45980500001)(43740500002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFlRZExzMG5aVG0zeGUxbEh5YU5FdnBlOTh2dGk2RmtURlZPR040Q1BZa0dL?=
 =?utf-8?B?VDM5THExbG4vNFpzZzN5dThtbFYwbGVBUDNDZW5TQVFRN2FOU1VsaEtadk5I?=
 =?utf-8?B?Zk45K3dVUGdHSnBKUnk0T3ZjMmd3UmRHRUthTmh6TlA5Q1BpSU1aSHUwbnNG?=
 =?utf-8?B?dFJpMVNxV2V6RkhzUjJnSG5EY3Q1QjNoOTgrTEticmdTUTgrN1dPNkpyOFJK?=
 =?utf-8?B?V04rTHJVbnYzbEgwMmFBRXpHNlIyYnlTL2t6bUFhYTlLVTM5NTN0MGMyMHFJ?=
 =?utf-8?B?Z3hDdmJzL3VQTy9XTGhFNUI2SXlHRTQ1eHN2YzdYa0lrS0RVRm1xdEwwdC9K?=
 =?utf-8?B?TExVamZQNW1yeUc4M1U1WWNhWXZFeGVtL2NqY0llSkIyWmdQUWJEZmpvbWtj?=
 =?utf-8?B?TFg1dHkxSFBra3ZoczF4SThTeDcwZGF5S1lyMlFpSnhnV0ZZZVNLcGJiZXhp?=
 =?utf-8?B?WWQ0R3VtbXZiMm1OVjhNaXkrNTlvbVZzcmNKc0U5VWJWMm5sTXNRSUxWSWNX?=
 =?utf-8?B?WWlpdmt5MzVyclJRbW1uUzZScURrTityMGJHb25OUEtjMzFGOUgya0g2N2M3?=
 =?utf-8?B?c24rZ1lGN1BPMDBTNXRRN1lxVUJrNVhMVno0M292U2NXdzZBTFcwMXhlVFhi?=
 =?utf-8?B?amFhTFlkcVN4Y3VZSGFuYys5U0YxUTIrOGdiMk1Uci9XSkFtOHNGQmRuVXNY?=
 =?utf-8?B?dVZDS05ydDQrRi8vbko0TWZ1RGo3Z2xRNEZiRjR5VlZpYlBHZEdHMUZnTzRC?=
 =?utf-8?B?QVRuT2NETzlZQVN1TVpLay9JdXU1OXJlVExnZHd4MDArYUNkQldlNWhsdDFu?=
 =?utf-8?B?SytCeUxwdnBtQ2QyZERSSVl1WUxWU3VGTGRvZ0MxUkk1SmdsQmpBNytXTCsz?=
 =?utf-8?B?b0s4OE81b2l5OVlvQklTNmduNThqazZxY05zMXErcjhaS25aVXlEZDU1c1gv?=
 =?utf-8?B?N1UwNmJoeVJJSUNPbG5wZVdSY1QzTUVXVWtUNy8zam5tWFlZTkk1eTNXMjdI?=
 =?utf-8?B?Z3BZOURwSlhXRzhucWEwcU9Pc2lCN01SeldnV0tLTFd5R1h1LzdMcUREa2oz?=
 =?utf-8?B?VzhyYnFPdHNiM1RlVGk3a0RNRy9uamlIOHNtNm83dDhGQ1lXeGM2UUJyRUY0?=
 =?utf-8?B?ZlViQWw2UmRNSFRQSEZENVk0RkZlQXE5UzFtazFSVXNhbk9xQ1FaNEI2Ui80?=
 =?utf-8?B?RVZaUCttb1RENDVDejFJNHcxQTg2SnV2VHV0a3FuT1cxNFNUNnF3bnpVMU5Y?=
 =?utf-8?B?dlA3Y0ovYlB5SzdMeTRMOU5tcUJSZ25KVHdWaitUTmVhSnd5UUVwOHVNTjZr?=
 =?utf-8?B?ZUVJTFlCa1JVWXZpVHBqWWtxVEtETGtYUVA1U3ZucWp2MmV0RTFqdDA4bEs0?=
 =?utf-8?B?SzU3Y2UyZEhqZVdOditkZzhnQ2tiNFZDK3RqcWFrYlU1UWRjZ1F2OS9YQmFx?=
 =?utf-8?B?cE8wMnY4SS9Ca2NwNXNJVTBmTmE0dEJzZnR5L0FOS3p3YjVVekcxNHVHLy9O?=
 =?utf-8?B?NkVabXlpT2xGbThtZ3FEUFMzcFh3ZlNQOXh3cnJjdElmRzFDL2YzaTIvWUty?=
 =?utf-8?B?OTUvVGlmckFrQ2J2WHJHVEJJK3hSMzZMdDNpSEc2UDJPZGVQd2lubFdvcFVU?=
 =?utf-8?B?bndQRExnZlI1RGd3blpIbG9vU2VuVFJWcnZpSk5ZNFBrU2wzYW5QNFpVcmcx?=
 =?utf-8?B?YzhYRVpSUktzM1YrYllQVGYvVUxaNmxNdllXemJSZStqdGdWZ01hOHBDUTBB?=
 =?utf-8?B?bitqZm5BaFc5YnY2MzJiSDZ3dWQ0S3ZsSkVUc2oxSkpmS1dabnJSWnFycTJq?=
 =?utf-8?B?N29mQkNQWkVycFFucUwvbFQ0bXZzWHN0eERSMWVGVExPM040MER3VE1xZnYr?=
 =?utf-8?B?Y0tLRFE3LzNSd2hyQXRJUzY1Yyt6YmRWTUZXdzJYamV5UnJpSk1aK2taMmVk?=
 =?utf-8?B?T2lsblpqNWdPRXd0ZWl6bGJDeUJvNjlGS1VkemloS3pGQzVqaTdXTElKT2ll?=
 =?utf-8?B?YUJ0SWNyWlRIUUJNdjkyS3pTd0t2SDJhZThGNm5zZVkxdlpLMzJGNnV3aWk0?=
 =?utf-8?B?b0I0L2ZYbDZhc204bjdFYVA2QlhKaW5YWE9FenM0MThNbkV3amw5UjZwZmVF?=
 =?utf-8?Q?K98I0wsHhegGxOipuFAQ1Oqog?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481e8272-ba2d-4458-ab00-08db3c4545c4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 17:34:02.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiUWlH1lXr/3M1gHjCUOZMNrBV668DIrFyFmck8D046VfIqU4sRQ07/ihfZF8RY1aEiFRFOG77MH9wFXKB8xBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleksandr,

Thank you for testing the series.

On 4/13/2023 6:47 PM, Oleksandr Natalenko wrote:
> Hello.
> 
> On pondělí 10. dubna 2023 18:35:25 CEST K Prateek Nayak wrote:
>> commit 66558b730f253 ("sched: Add cluster scheduler level for x86")
>> defined cluster on x86 as the set of threads sharing the same L2 cache.
>> cluster_id on x86, maps to the l2c_id which currently only Intel
>> processors set.
>>
>> This series sets the l2c_id on AMD processors with X86_FEATURE_TOPOEXT,
>> using the extended APIC ID and the "Cache Properties (L2)" CPUID
>> (0x8000001D EAX). On AMD processors without X86_FEATURE_TOPOEXT, current
>> behavior will continue.
>>
>> Following are the changes in value reported by
>> "/sys/devices/system/cpu/cpuX/topology/cluster_id" on a 2P Milan system
>> (2 x 64C/128T) where L2 is per-core level and SMT sibling of CPU (X) is
>> CPU ((X + 128) % 256).
>>
>> - tip:x86/core
>>
>>   $ for i in {0..255}; do\
>>       echo -n "CPU$i cluster_id: ";\
>>       cat /sys/devices/system/cpu/cpu$i/topology/cluster_id;\
>>     done;
>>
>>     CPU0 cluster_id: 65535
>>     CPU1 cluster_id: 65535
>>     CPU2 cluster_id: 65535
>>     CPU3 cluster_id: 65535
>>     CPU4 cluster_id: 65535
>>     ...
>>     CPU254 cluster_id: 65535
>>     CPU255 cluster_id: 65535
>>
>> - tip:x86/core + this series
>>
>>   $ for i in {0..255}; do\
>>       echo -n "CPU$i cluster_id: ";\
>>       cat /sys/devices/system/cpu/cpu$i/topology/cluster_id;\
>>     done;
>>
>>     CPU0 cluster_id: 0
>>     CPU1 cluster_id: 1
>>     CPU2 cluster_id: 2
>>     CPU3 cluster_id: 3
>>     CPU4 cluster_id: 4
>>     CPU5 cluster_id: 5
>>     CPU6 cluster_id: 6
>>     CPU7 cluster_id: 7
>>     CPU8 cluster_id: 8
>>     ...
>>     CPU126 cluster_id: 126
>>     CPU127 cluster_id: 127
>>     CPU128 cluster_id: 0
>>     CPU129 cluster_id: 1
>>     CPU130 cluster_id: 2
>>     CPU131 cluster_id: 3
>>     CPU132 cluster_id: 4
>>     CPU133 cluster_id: 5
>>     CPU134 cluster_id: 6
>>     CPU135 cluster_id: 7
>>     CPU136 cluster_id: 8
>>     ...
>>     CPU254 cluster_id: 126
>>     CPU255 cluster_id: 127
>>
>> Note: Hygon, theoretically, should be able to set the l2c_id using the
>> same cacheinfo_amd_init_l2c_id() function being added in Patch 1. Since
>> I do not have access to a Hygon machine to verify my theory, ccing Hygon
>> maintainer Pu Wen <puwen@hygon.cn> for l2c_id enablement on Hygon.
>>
>> The series also adds documentation for clusters on x86 platforms and
>> applies cleanly on top of tip:x86/core at commit ce3ba2af9695
>> ("x86: Suppress KMSAN reports in arch_within_stack_frames()")
>>
>> ---
>> K Prateek Nayak (2):
>>   arch/x86: Set L2 Cache ID on AMD and Hygon processors
>>   x86/Documentation: Add documentation about cluster
>>
>>  Documentation/x86/topology.rst   | 31 +++++++++++++++++++++
>>  arch/x86/include/asm/cacheinfo.h |  1 +
>>  arch/x86/kernel/cpu/amd.c        |  1 +
>>  arch/x86/kernel/cpu/cacheinfo.c  | 47 ++++++++++++++++++++++++++++++++
>>  arch/x86/kernel/cpu/hygon.c      |  1 +
>>  5 files changed, 81 insertions(+)
> 
> Having the following CPU:
> 
> ```
> Architecture:            x86_64
> CPU op-mode(s):        32-bit, 64-bit
> Address sizes:         48 bits physical, 48 bits virtual
> Byte Order:            Little Endian
> CPU(s):                  32
> On-line CPU(s) list:   0-31
> Vendor ID:               AuthenticAMD
> Model name:            AMD Ryzen 9 5950X 16-Core Processor
> CPU family:          25
> Model:               33
> Thread(s) per core:  2
> Core(s) per socket:  16
> Socket(s):           1
> Stepping:            2
> Frequency boost:     enabled
> CPU(s) scaling MHz:  37%
> CPU max MHz:         5084,0000
> CPU min MHz:         550,0000
> BogoMIPS:            6789,07
> Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_
> tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c r
> drand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_l
> lc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb
> sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip
> _save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid ove
> rflow_recov succor smca fsrm
> Virtualization features:
> Virtualization:        AMD-V
> Caches (sum of all):
> L1d:                   512 KiB (16 instances)
> L1i:                   512 KiB (16 instances)
> L2:                    8 MiB (16 instances)
> L3:                    64 MiB (2 instances)
> NUMA:
> NUMA node(s):          1
> NUMA node0 CPU(s):     0-31
> Vulnerabilities:
> Itlb multihit:         Not affected
> L1tf:                  Not affected
> Mds:                   Not affected
> Meltdown:              Not affected
> Mmio stale data:       Not affected
> Retbleed:              Not affected
> Spec store bypass:     Mitigation; Speculative Store Bypass disabled via prctl
> Spectre v1:            Mitigation; usercopy/swapgs barriers and __user pointer sanitization
> Spectre v2:            Mitigation; Retpolines, IBPB conditional, IBRS_FW, STIBP always-on, RSB filling, PBRSB-eIBRS Not affected
> Srbds:                 Not affected
> Tsx async abort:       Not affected
> ```
> 
> Without the series:
> 
> ```
> /sys/devices/system/cpu/cpu0/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu1/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu2/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu3/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu4/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu5/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu6/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu7/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu8/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu9/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu10/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu11/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu12/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu13/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu14/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu15/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu16/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu17/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu18/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu19/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu20/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu21/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu22/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu23/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu24/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu25/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu26/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu27/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu28/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu29/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu30/topology/cluster_id:65535
> /sys/devices/system/cpu/cpu31/topology/cluster_id:65535
> ```
> 
> With the series:
> 
> ```
> /sys/devices/system/cpu/cpu0/topology/cluster_id:0
> /sys/devices/system/cpu/cpu1/topology/cluster_id:1
> /sys/devices/system/cpu/cpu2/topology/cluster_id:2
> /sys/devices/system/cpu/cpu3/topology/cluster_id:3
> /sys/devices/system/cpu/cpu4/topology/cluster_id:4
> /sys/devices/system/cpu/cpu5/topology/cluster_id:5
> /sys/devices/system/cpu/cpu6/topology/cluster_id:6
> /sys/devices/system/cpu/cpu7/topology/cluster_id:7
> /sys/devices/system/cpu/cpu8/topology/cluster_id:8
> /sys/devices/system/cpu/cpu9/topology/cluster_id:9
> /sys/devices/system/cpu/cpu10/topology/cluster_id:10
> /sys/devices/system/cpu/cpu11/topology/cluster_id:11
> /sys/devices/system/cpu/cpu12/topology/cluster_id:12
> /sys/devices/system/cpu/cpu13/topology/cluster_id:13
> /sys/devices/system/cpu/cpu14/topology/cluster_id:14
> /sys/devices/system/cpu/cpu15/topology/cluster_id:15
> /sys/devices/system/cpu/cpu16/topology/cluster_id:0
> /sys/devices/system/cpu/cpu17/topology/cluster_id:1
> /sys/devices/system/cpu/cpu18/topology/cluster_id:2
> /sys/devices/system/cpu/cpu19/topology/cluster_id:3
> /sys/devices/system/cpu/cpu20/topology/cluster_id:4
> /sys/devices/system/cpu/cpu21/topology/cluster_id:5
> /sys/devices/system/cpu/cpu22/topology/cluster_id:6
> /sys/devices/system/cpu/cpu23/topology/cluster_id:7
> /sys/devices/system/cpu/cpu24/topology/cluster_id:8
> /sys/devices/system/cpu/cpu25/topology/cluster_id:9
> /sys/devices/system/cpu/cpu26/topology/cluster_id:10
> /sys/devices/system/cpu/cpu27/topology/cluster_id:11
> /sys/devices/system/cpu/cpu28/topology/cluster_id:12
> /sys/devices/system/cpu/cpu29/topology/cluster_id:13
> /sys/devices/system/cpu/cpu30/topology/cluster_id:14
> /sys/devices/system/cpu/cpu31/topology/cluster_id:15
> ```
> 
> Hence,
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

I've retained your tag in Patch 1 of v2
(https://lore.kernel.org/lkml/20230413172918.1500-2-kprateek.nayak@amd.com/)
since there are no functional changes for AMD in v2.

> 
> Thanks.
> 

--
Thanks and Regards,
Prateek
