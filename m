Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9651062D1E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 04:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiKQD5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 22:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKQD5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 22:57:10 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326564B9B4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 19:57:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frdhE/zqL2GoAet2TrsQafg1POQ+hntD6cg8F38VvTO0+PCUlNin5kNOAaolvtg/uPalWVbKDlZlmchCyQK4ZmlVPzXOFZIs11MH2P2AnbLw/NcWZd24VtXVghhhB882wQNdQgeUac4J9b4Yhxa2IedHHsAj4GdcVz2wK8ppEL8VLB3KpWCrDqeZLxw47xbt8wLW1aDo134SkMIMvODADQHEdPC+YLyVd7WAKAMlTqWmpT7/uReu5Flb2rNxJdJn2sooc3HQK7haM4bNUI/KXLCgoRBiDINnoTcUc59k3oBOSf5yDkU8UADi0WeaDAgYORKEKcYry8UUIbfvC96ybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo8pjVZSAsMbszSxnO2rrttzV61PnXs3Q5AmUdjZBlM=;
 b=LAL/MSFJevleBF54XUaNbqIr405oyXv8eEIhic0Ni8vXcNBLTj4EoCzhFK7ZZnlwexU32OGgVnXysTZRvH0iZKXmlhSF6uo3JhG48isVi5kTTnhZJKID2IHjkhivRL5ul3ck50yrBSCmRc0vPyZDk/sK9OqUXISCbVIb5c8SZToRsJKkk3qMYX/ItRxFueVGWb8+oh+Y6L1JEOS53nkqkDcSukfdK/y+jNUoz7c1VKoj1TNtBTN7yl4dZmvUayo1g2nw6TycMLx/rTdsxrI9qCjmQmHAflFA6H/hgCm+kJMG/gCSmrFHBb3KBYy6w8FScuY9WHEB/lofU/lznOx85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo8pjVZSAsMbszSxnO2rrttzV61PnXs3Q5AmUdjZBlM=;
 b=3BpapoDkDY6AlQL+v4ruUUD4LDnTWnP4tQ2Oi5AOpDP3AZsM8BVgN1/mwQrKqhu1fiz87tc68K6+DolO5XHMi+itJNQO8BLTiwGGgxJ5DERMgljsYUXMaclQiPX9sibRzYA9Shxxn7nR53PJ0zfaIwYVG5b3wTJ9mosTwLY9uZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 03:57:07 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 03:57:04 +0000
Message-ID: <a2feaf02-4b36-f86f-b6ff-018aafe81fac@amd.com>
Date:   Thu, 17 Nov 2022 09:26:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [tip:perf/core] BUILD SUCCESS WITH WARNING
 e8d7a90c08ce963c592fb49845f2ccc606a2ac21
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <637553b5.ebdZY+lvkXPfAk1E%lkp@intel.com>
 <Y3VYQtTSJDpwKZR5@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y3VYQtTSJDpwKZR5@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdac9fb-4248-40db-d503-08dac84fca02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEieSiWX0UJowk6Mg7wYPvp4eIbts8cfw4yBHu1T17cQ5YEyBhVWejtSdcevbcP//PtBx3MRPdn/kdDQw+xErd7XKq5xEwJHyVuaiap3bbjFzqgbi1BFjajT/SpVoYIVeaMwR2f/lVnwgqj5y+VzueQVlING5v2DmortnJTAa3+hmsGRB3y+5puCDDW1+1r8Vhmma4zpqFKW6PvJMxxZr3YRe0x3agQ+/mcCDhXUMh9zcVUmETwty+0hSuKs7lXgfpB6lcMjaL+LOsyyS7+GzJQeyUB7iIs7mgcli2BLSYbL/EAqDrVo2fGgCLPCMNaUiCpwQ2qtYGN5L87uJiBo3Dut7Zq7/V0KIauHmmiia0g9a+e/5cAtxl8XDKQZP6ItlVtfkBW55KmEXJo1GSoOO2hvPcfXYt6KfOXksekR6+aUd+JzKV56caHhyUbUwsS2IBkxUBzoTgHXbOBNNCt1Bp4NzWy217K2fJ8dZeyXUYzSMWC8jqvym+YO9aggYTzkFPAoAe9QO+8y4Ko3F8Oi4NdiXxKfdgVTWmx0Nm1uyI0cxbEbJwBJ7C5ad24TH2Er3UDaDMwpVIT7P7Zax6bvm68rsPk9Wptho5x4d5vQGnZur7D3Eel63L9nYakCw0d2wrSLxJ2MNQZ6K1+Gor0peiCr7Y560mh+KSfml1s/sQ8908Dc+cTNjZj/jY1D9Ekqi1mLSEH2rsgO2XSN7Vy++7Jx3K/Gdvy7l8Vm2WvNswXdXIcrezV/K7rU8RMf14HPz/oRqemOML+M7pXNP4fwqxfYlT3Qcynxxq6owRWxbQktryP47E2Np5yRJwzt9VDy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(4326008)(31696002)(8676002)(83380400001)(86362001)(66556008)(66946007)(66476007)(5660300002)(44832011)(8936002)(41300700001)(38100700002)(26005)(966005)(2616005)(186003)(478600001)(6512007)(6506007)(6486002)(316002)(54906003)(6666004)(6916009)(36756003)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWRscHkxNDVRNlptVXh1K1RzTjg2OGV0SUlUbWROaHh4MmZnU1FRUGg3LzFT?=
 =?utf-8?B?YTJLOTlnVHRraG54dkVQUm0xd0Rtalo4YzVHUlJBa3Nqb1E5WEwwUk1iblBk?=
 =?utf-8?B?Vi9IanZucW1FZ3BHYWRFQXV5alVERlhPRittcnQ5WGd3NVJCQWRzeGJkUE03?=
 =?utf-8?B?c25USWZXK0M2UTRkWjN4VHpCMmFVMXhzOXhWMVQva2hrRW0vK25TekJtc2dp?=
 =?utf-8?B?Nm4xY2tJSks2dXdNL2VLNkZxK1BaWDIrYkZHTFBnSFlFbG9FMlArUVcyMWs2?=
 =?utf-8?B?dDdub2pPWlFUT2dpdXZCREJDR0k0dTAxSGhGd0JLWEI3MFZMdEZidVhYUmNR?=
 =?utf-8?B?RFI3UnVZUkd3aHJPZktuejJkdHozV1gycDR4NHVNcEhZRWM2QVJXN1ZkN2RF?=
 =?utf-8?B?VGkyQXp1T3puZmxKbnQrVldVZ1RCTmZkbDZkM2NNQkh4NGFPSzFKRWRaOHhh?=
 =?utf-8?B?R2pVVGxIRjRLWXFyZ1h6VUYwdUpRWW5RbWtGWmI2WHUxUmo3UEg3WlY5U1FP?=
 =?utf-8?B?L1BXNmFreWhvZyt3SDZ0WEVDWlNSeFdORG5TRjh2YXkzZWcxUXhNb1Nwa2VQ?=
 =?utf-8?B?NXBhMVlhSGQrL2VSY3A1ZTY2eWpybzdPUjFGSzJTSXVzdG9aUWduMGNaSEJD?=
 =?utf-8?B?aitxVXdKdWZUL1BpNUZ1eW55b3dnMWFXRi9TWWNRcm5xdHhKNjBHKzFlNkZ3?=
 =?utf-8?B?aEp1em1reXREekNGOWhlMEdTMnlUMEZWQmhaVGY1djVrcThpYWNFU2Y0d3BK?=
 =?utf-8?B?c3p2dFp2Q2FRMG52RCtMbXlTZFJJQ1M0bkxxaHZuZDJPcFZndU9SRU9zUjh6?=
 =?utf-8?B?V2hIOWFmOE9mTGVoM2V1anduTFpxRGVhd3d2SFZYblQ1ci91UDkwdmVscnE1?=
 =?utf-8?B?MW80WEprb0FkekxMNStsZ3dRUjZ4ZndFUFZCa1Z2SHVObXA2NzhHOVNQTUpD?=
 =?utf-8?B?RmhUUkxWbXhyWm1GSEZLTnVzVkxaMG5hV1dLTXNrTjQrRFk3U0RkNnpmaDhk?=
 =?utf-8?B?TExhNHNvTjlmYlRpelY4RERoV1VtT2RCQUFpUGlqc3dLZlJzSTZGZ2gyeHRO?=
 =?utf-8?B?bk1vdVRablhLbmlmSjdyM3FBRGJEdHp5OXJsa3k0eGVOSGMrSWh6V3YycDNV?=
 =?utf-8?B?N2pCdW51OE1ySk5DajVka0k2aHBQbG8xMldiRFFybTZaQUI0bEdKVVFJMFVH?=
 =?utf-8?B?bzNiMnNHN1BmZXNSYVBtLzdCdW5NOUpHbFZQaEFVWHRaM0Y2UkdqZXZwNi9Z?=
 =?utf-8?B?R2MxMnJBL0pVWWdzd0I2ak4zY3J4YW9jaUNLcVlLR1AvekE5ZExFKzV2WGRs?=
 =?utf-8?B?dDArUjZNSjdOVktPVzFJMEJseGpOWUQ1eWxnZERndFdidUZJemVWZWNuQ09m?=
 =?utf-8?B?MUhaQlZwVVo5d2tNVzF2REVmdllMeDlycTREbGZEMHFtbzg1R3EwYm8rdzU5?=
 =?utf-8?B?anpjUTIyVVdzOXM1b1pLZldzaUNLeXZUZ3p5NnQvWHVOT2srbkNCNU1uR3Rh?=
 =?utf-8?B?RjVYWEIzbVZOWktReVptcytPdFZBZzl5dUZYN2lXZnlGbE1SY3JFZEtTRk5a?=
 =?utf-8?B?c0RJZjh4bVY2VmZ0dzErbC8yWHNIYWhhV1JaZjR3UHBIT29ZcTJzalZjWHl2?=
 =?utf-8?B?NzkxM3o4UmQ0a0JQaEZvQUU1SVVHYmpyYlRDaXBDZG45SnRPMVdXVlV0Q2JI?=
 =?utf-8?B?QWpJQ3pnaER6RW01ZDNUN0VwVDVXSFFmL3J0UFVmQkVWYkRuSXhReVJTMHEw?=
 =?utf-8?B?MjI1Y01MSTM2RXdkaSs2UXc2KzAzWVhrempuUmN4SVc4blBaRmFBZHBrQVhW?=
 =?utf-8?B?NmpkdWVDME54UTRJanpYaFNjQnlrQmxyU2tDL2NJWFZkekdXSWxCSktXb0lC?=
 =?utf-8?B?c0ZMb0F1WEFsS01RVFpjZU0vb3F3M0ZFdVNoWkJQWStCQ3NqQ2ROL0o0ck1u?=
 =?utf-8?B?MFpCb1FIVlpKYTRjQ2IwQ2VROXFBNS9ZR2FjOXdOWThVa2pPQVVZNU1BYnpP?=
 =?utf-8?B?bjhZdDZWVTJHUEVEQ1YvWk1PanFYdzJnVWljM3hwTnBmOG9IMmNXN2JWSmdB?=
 =?utf-8?B?UURUOUdkTXh4TXp5STVwR0tzRHBsQ0xLdGVFVEdtQ0NackozNmR3UUxhTXY0?=
 =?utf-8?Q?2s2A/jKxkxWyjt/OYLwp/3oi4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdac9fb-4248-40db-d503-08dac84fca02
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 03:57:04.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/jFfO1Xj4FJW4a9mp3cQM5vYdQ30Xd52nDKk1e4r8KUxND7ufeUEAw6shtXd6JYCsLTnZ5POy4bDgUmEsoDHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

>> kernel/events/core.c:11274:4: warning: cast from 'int (*)(struct perf_cpu_pmu_context *)' to 'remote_function_f' (aka 'int (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
>>
>> Warning ids grouped by kconfigs:
>>
>> clang_recent_errors
>> |-- hexagon-randconfig-r001-20221116
>> |   `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
>> |-- hexagon-randconfig-r005-20221116
>> |   `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
>> `-- s390-randconfig-r012-20221116
>>     `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
> 
> Robot guys; why don't I have a report of this warning?

https://lore.kernel.org/all/202211041643.J58xvn1k-lkp@intel.com

I'll prepare and post a fix.

Thanks,
Ravi
