Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58328617A42
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiKCJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKCJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:53:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337F363F4;
        Thu,  3 Nov 2022 02:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfXfcxv1qMhUsAAa2XIjQxWnBZY7wlRgFg86m0hy2UEAP8WCqIrQadjuoBoHYRqQeQPLfoluvF17aPNGdrTR8rv4nj2spHQyLc/KAqspirjjHeGb8xCVWSkalf3bMrShsDQV8gFroylgs0SKjSuA3Ti2c/zRT/VKwKq4N9z0w6Q24nPMe6498zM1MjnQC5OqsB/8JJiNNbzKisfotE4bPmRtZdGhoReHYTmNIXKJcZhCG5P4kHAxZ1/mI3WcGSnkPITz+rSYms0BW6KqYZJBWk9n6AwnFDR/EbJMYbKr7W0OWKqE9dBFrV5x4BGL2uQwD/zAb+Xugt10LIT+Oge9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEtxW+gtN+3XS3R23MHPtYf2YTI9nA7eQR+uFrsBQMc=;
 b=TcBPqWLlvI22ip5BAA9d4kX4nnvtOLK27GhOynmMkOluG89SIUHqN5SBGhcM43R7mJQnKXaMEsX517huwPkoAM/gST1zxxip5D8XPcc1XZB1NO6FkEmyyD+EPcJNoL9TG9pnPeK2Lf84prodBJW75j3NMqYaEeeDIT+46ZSDkKHpJS4GDSz5vklbsJtc/YwDJ+87+7rmUrrmXcZDl4HoTqLjcurQmpBdjzmJKK8wY5vexQT1avRoRldgDubbwUI8BB8Am8Ag/DSN4pYBskA3qsAGVFyQxl5z82FapofyKUuTfC5LQGg8G9DvdozMbq/N/ber68dT4VJVS7x223XFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEtxW+gtN+3XS3R23MHPtYf2YTI9nA7eQR+uFrsBQMc=;
 b=xWsJPNAA3r+Iu4stR0boAMen0UJerMkfO/DCQmA5sfJhTGNPGDGTK6Zh31f16p5GnFeEaW3zROOGGSlfFFEyxJqDJ0iuA7r3BAUxqzPE6ALgXSC8P8YsgexPOQaowSTt7fyqfIFmJ04HDJKxXIK03ftqyRms+yErcFQdSPmn6o8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 09:53:14 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f397:c6b1:a8a5:55f5]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f397:c6b1:a8a5:55f5%6]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 09:53:14 +0000
Message-ID: <6d78caf0-cb4c-1a30-66ce-242df87656ef@amd.com>
Date:   Thu, 3 Nov 2022 15:23:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: qemu-i386: perf: BUG: kernel NULL pointer dereference, address:
 00000148
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CA+G9fYsGFoC5TciCuijZXLx48TZnoTSkq=iUgb+vFdi9EYTucw@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CA+G9fYsGFoC5TciCuijZXLx48TZnoTSkq=iUgb+vFdi9EYTucw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::21) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d4fd5d-2635-44b4-b95d-08dabd81393b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FS4SSfQACoMNLGNP/bJ2Tv2EH/uoNWqXIf1GgjV5BM845NseH435VbAJ9O5dYKii9WdayXIM+JQdOwkW+uiYAtiFL+5Muwu40q+ROkzzA1HKHod2TeDfqr2C3inJ/pDTAzhYosfBNn3ZrPN1zefMbrIDptXrUyaqvo1kBB+XgkPL+8unbH2qapRtohlx7cGUIj1UQfEmEr1oi/NgfzC9O7ehDWYBiBC9BRX/pp/0/YQ7f+W2Zm+QleM6Lv7PhpOozC2vPc7K5cYFx08+udtDqqtItcHq2t7CkgrbbcvFeKVZkTpvgkkZG91ME3VpUs6AE+Eg6Hq4QcgCxNx/qvWiEk8opRnU1yrL52ugnprgFao4RjzM1ucKI8IcDyAWNFOX6DS5/pEGvYSVJGeSNsHoslRyTyS/7ZGBsJ9Ije4qXXNg8NmLOC3JSfXybFJeQmMQhkt3lcD5/fm/rl0k+u/a12KpfXh4rkJVcIhA4VexIzfCCWJkqZrsj4yEa3C0mEhNM31LM6HxETg1Py2W+kcv2Jj8d6yaXaOrAGuE5V669dNmcapUJdH+jkCnS0PG3sFUtIbEewnFdKhFX6Y0dqpn/fLh/2aLDQeLdPRSeMh5iBYNeAZs0crHX14ekiD9VZ2Xdug/6CGjas9P2M8Hgx+sifQxtohoIJarxOjiK322mQqubwrsKdiMHVH6Oqad7ly/u1u/SKO7eMWQM4JxjaOQ+GerT/pmZRnxWkniD5t2qBQ2Qg+ApDYgycfIRRBVYpDifXZ3x0Fpgq81JK9e78S9+JOdIw4Fk+PjaFFaxBGov9C0ov2X4R5yM4idZYTKYaKN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199015)(44832011)(38100700002)(31686004)(41300700001)(2906002)(66476007)(66556008)(8676002)(66946007)(4326008)(6666004)(2616005)(36756003)(186003)(6506007)(45080400002)(8936002)(83380400001)(5660300002)(31696002)(86362001)(966005)(6486002)(478600001)(316002)(6916009)(54906003)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RERmL3Z2amtUN0Y1ZzJRZHlBbHJFZEx3ZXZPSlI0OVovUUlteXRuZVRoY3BN?=
 =?utf-8?B?LzQvYVllNU1FWWlFaWZjL1FSUnVtWEZsV1FkWlNHOThRZGRiYlFINzNZeU8y?=
 =?utf-8?B?TXNYVjNyWVExRXFYVjJGdlRvL3doQ2xNeVlVVTlLZlhRS1FCekY5Nk1JYitM?=
 =?utf-8?B?VDBDTUw5ZjVJWFJCRWphZUdPRnlhRkFhSDQrRVVua21JeGJrNnhBTzkyUHg2?=
 =?utf-8?B?WmlXdGN6TURJU2lwRUJVMWFGRTlZT3ZyMVIxZEExd2lMOEtzL2NoRFArN3pF?=
 =?utf-8?B?R1Q3RDFINXhKbUNkckJxdHoyNFNiTkp4d3AybllxcUV0eFN4bjhWay96VVBq?=
 =?utf-8?B?cG1ldEQxbUViZCtXNjN0Qy92V01XOHA3NXJUa0xBQjVyNUh2NmxodkhCWkdo?=
 =?utf-8?B?bks4RUxkcDVhWGFxcDErVFoyZktiOXAxRU5IRVRSMG12cHB1Z0l6dk00WnJq?=
 =?utf-8?B?M1VIbjN1RzBTNUlLRE9aSWNzRlNGTFJMdmNKbzE3eXFjWktPK1grbGd5Z3Rz?=
 =?utf-8?B?Wit5WkNzdzhtTDAzQkRMemE2UU1UWjJzQ1RGUDRXaU9aNWlmbHRTY09zcStj?=
 =?utf-8?B?TTdpY20wSkdxbnB2M3M0RkI3NW5wMGgvMkhqeWJuQTZHcWdJeWZpdVhOTzcv?=
 =?utf-8?B?M0dzSFdSTkVVODJGQVgyVHNLR01QOE5pODFHTy9WZ04ySm1XeEV0Q0FsUWpB?=
 =?utf-8?B?OTJNelZmVTZjaFRtVlZYVW0wRlIrQlNRM2hqRXRadjZubHdYOEp1SGNObjJ3?=
 =?utf-8?B?b1pZcEZYUmRjOFNtK2RyUUpCTjhKZkgzUGsxT1k5clVFeXVtOS8vcGFzbE01?=
 =?utf-8?B?OVEyM1BaVjd3dHp3S0NKcDNXQU1TUG10aThtZjdkUkJUV1o4emk0NGIzNmEz?=
 =?utf-8?B?N3RYTHI4dWdzNnNRU1pEUGdMVi96VkJ0dTYzUHJ5WGlBcnBTK0JUb3g5eXZZ?=
 =?utf-8?B?bDRPNDdaQWJ0S0sraWlxU2YwSUFwS2czUEg5Y1FmN0xMNDlMb21Vd3AxSFZ3?=
 =?utf-8?B?S2hHTWU0WDVVMGJud29mcVVzbU5wTHJZNXFweDVnT0tMOTlQOVdXQkNqSTNp?=
 =?utf-8?B?NW9OYklnZG5xYS90VXJWWUtTbjUzV0FCY1p4RzdENmJHY015OEYyVHplYzlt?=
 =?utf-8?B?ZXcvL0VpcnE2QnRWUTVzM2RVUXh5THM0emdSOFFNamY0U0FqOHNzdlFSNXA4?=
 =?utf-8?B?K1VwdFI0a1dKMzBIVzNFaVpwSVNBWm5MV0dicjJ5WWhWam94VENkcVlocWZx?=
 =?utf-8?B?b3FFYlhidnVDUGdBOW1CTlNUNzN6NStnVG1wYmFBdGVJMXVtZkpwaGIrakdM?=
 =?utf-8?B?VkJzRzlDSHlidGR5ZlJURnJpcXlBNzhDNVJBNFYzZVkrNDc1MVRvQXd5WHl1?=
 =?utf-8?B?L280T29nUjA2Q0t2U3BnRWRGc2FkTjBEeEJ3SGtRZ3J3M0t6b3h1dEErc1Zn?=
 =?utf-8?B?WklYV2lDcldKUFl1Z2hub3pNR0xOeG9IdzhrMllHdlAwaGlqU3JneVB0Z3Y1?=
 =?utf-8?B?cUswMVZWcGd4WEFjNFR4dG1JUWxOUzdneS91WDNkUWVpS0hXYVFvTkRINHhr?=
 =?utf-8?B?cHd5WXpXWXJZem5IWUxIVU56YmZSY09kQXpaZ2RYSTNhUUVYR2xiNkwxQ1l5?=
 =?utf-8?B?TURMbW8zeURHb1MxOFE2UkZ4TjRHckViMzVCYlJPL2RwR3ZmUmFEcUJQUDhj?=
 =?utf-8?B?dmNrTVIrMjI3VUxPTkx6ZmE1T2FiRmwxa3IxTFRLa1NJVHVBdkFaQXpldVdi?=
 =?utf-8?B?WnlUdThUdGJBcmJYbHZyckw5WDFaMUlyZk5BbU44V3RQdUZBUlBWTDZvbkl4?=
 =?utf-8?B?OE9TbTU4S2p2SW5wZmVlaCtGOHZmd29uSGZjRnpQZkZrQ1IzRWFKV3lwNzY2?=
 =?utf-8?B?TWZFTWMzMVZISTNMVVZnSGtPUTlRS1FCWE43UVZ3OWQ3MTBLeFUzQUY4VXVu?=
 =?utf-8?B?cXNRaVIvbHh3dEZSWG9WNVk1S0MvQWIyM2dlV2RiY2xmTGFuWE1QNE9oOFI1?=
 =?utf-8?B?SXo5VjEramxQZmhjSlJ1MjJQcHhuZ3l3WmdDNmU1L3lXZUZLVzgwdEUzVnJj?=
 =?utf-8?B?dEViVkpETFBrQlI0QnBQYWRWaHpqaEluemwyamJoZWZGY2JaZC9wMXI3LzE0?=
 =?utf-8?Q?OhD0iL8VRvhSKZWd3OxnMFYS9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d4fd5d-2635-44b4-b95d-08dabd81393b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 09:53:13.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxN4Cs5VNpVGPJbNtiB0qJ8PAZT72nJLQYaOoO5rfkdIRg0mCKXIHoHRRE2fCQjPAUtQMUDyoRDXxYQEO1EZng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [  116.006600] BUG: kernel NULL pointer dereference, address: 00000148
> [  116.008309] #PF: supervisor read access in kernel mode
> [  116.009527] #PF: error_code(0x0000) - not-present page
> [  116.010809] *pde = 00000000
> [  116.011454] Oops: 0000 [#1] PREEMPT SMP
> [  116.012144] CPU: 2 PID: 449 Comm: perf-exec Not tainted 6.0.7-rc1 #1
> [  116.013256] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.12.0-1 04/01/2014
> [  116.014710] EIP: x86_pmu_enable_event+0x4a/0x190
> [  116.015617] Code: 64 a1 10 2c 8d c6 85 c0 75 16 8b 5d f4 8b 75 f8
> 8b 7d fc 89 ec 5d c3 8d b4 26 00 00 00 00 66 90 b8 43 bb 49 c6 e8 56
> 13 fb 00 <8b> b3 48 01 00 00 b8 dc 39 8d c6 64 03 05 b0 28 8d c6 8b 38
> 85 f6
> [  116.018642] EAX: 00000002 EBX: 00000000 ECX: c0010200 EDX: c649bb43
> [  116.019709] ESI: f51c6b00 EDI: f51c6c00 EBP: c34e1da4 ESP: c34e1d88
> [  116.020744] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210002
> [  116.021847] CR0: 80050033 CR2: 00000148 CR3: 03e07000 CR4: 003506d0
> [  116.022930] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  116.023674] DR6: ffff4ff0 DR7: 00000400
> [  116.024078] Call Trace:
> [  116.024348]  amd_pmu_enable_all+0x3d/0x50
> [  116.024776]  x86_pmu_enable+0x17c/0x370
> [  116.025179]  ctx_resched+0xad/0xf0
> [  116.025542]  perf_event_exec+0x338/0x400
> [  116.025956]  begin_new_exec+0x548/0xac0
> [  116.026358]  load_elf_binary+0x2ad/0x1360
> [  116.027063]  ? __kernel_read+0x12c/0x220
> [  116.027520]  ? _raw_read_unlock+0x1d/0x40
> [  116.027957]  ? load_misc_binary+0x1eb/0x290
> [  116.028404]  ? trace_preempt_on+0x29/0xe0
> [  116.028827]  ? load_misc_binary+0x1eb/0x290
> [  116.029287]  ? preempt_count_sub+0xc1/0x110
> [  116.029722]  ? bprm_execve+0x256/0x650
> [  116.030122]  ? preempt_count_sub+0xc1/0x110
> [  116.030600]  bprm_execve+0x260/0x650
> [  116.031006]  do_execveat_common+0x13f/0x1b0
> [  116.031482]  __ia32_sys_execve+0x35/0x40
> [  116.031897]  __do_fast_syscall_32+0x4c/0xc0
> [  116.032358]  do_fast_syscall_32+0x32/0x70
> [  116.032777]  do_SYSENTER_32+0x15/0x20
> [  116.033190]  entry_SYSENTER_32+0x98/0xf1
> [  116.033601] EIP: 0xb7eda549
> [  116.033903] Code: Unable to access opcode bytes at RIP 0xb7eda51f.
> [  116.034576] EAX: ffffffda EBX: bfa6d940 ECX: bfa730f8 EDX: 08ea9dc0
> [  116.035278] ESI: bfa73d61 EDI: bfa6d949 EBP: bfa6da38 ESP: bfa6d918
> [  116.035927] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00200296
> [  116.036624] Modules linked in:
> [  116.036961] CR2: 0000000000000148
> [  116.037315] ---[ end trace 0000000000000000 ]---
Seems like same as:
https://lore.kernel.org/all/CA+G9fYtOP-spGS7gYyBB-8wpUDiKxd5e_Nk05J9gzWR_DLBeFA@mail.gmail.com

