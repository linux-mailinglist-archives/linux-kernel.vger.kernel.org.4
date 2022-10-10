Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB225F979E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJJFFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJJFEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:04:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A9B1F9D8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 22:04:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A1ZtlT021613;
        Mon, 10 Oct 2022 05:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5L5eCMQIO07I858f9zMwg877hAQqKDTPJsxQQHPNzuI=;
 b=GeMf+3m81jVOfgHaoplNWLY9kv7a9xIsANmMa0l+MV3vz8s7CAebVlZguyn9HdHyE+Qc
 SEs0EZaXO/n74hAKKtUIeQyjglNhfNrpOBqduMyt+o8EhlHS96itJ+5/663I0cHYgymv
 nr5ljmj5/2kyond4aCrrfJJ0lDOf+bnPqgyIuTO/ddKZhMiTe2E21UmqFutJsfPEXmU4
 bvCOMv9x27Gq2ImlJHZ68gz35ZsGCzNKmP4xwzz8G2cJ7j0M47tJHtzmBDz6/wTtcHWS
 8XXrP69ETVYhvdZeoU6ycgWKUXzdkqyouSL/oPaS4Fl8wm0ppSy780sk6jBUJ8ZnR7de Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k30tt2cmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 05:04:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29A45bDD039137;
        Mon, 10 Oct 2022 05:04:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn2agem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 05:04:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6M1qICeGum9G8oHg7TuGxsjn58d2KOuoxRQwwMEHrKBh8nFq9pKTYZEHeGIIsLVFZO7twSoXUPIrgMAn7/A/LmzXKKRq9cXST4JLynKY+z6OcaDiEXzNc6efj0DvFlEZu6UxhcYa1SZIXLJJ+Nf4FIvGwYxYGdW9Be0y94pZfEVLIS9AoUhfeVKmacDB1XePEQ2jcecBICrzQax712kkn2VVVio7xjT+qzVjK6Db/i4FJO+lhSeci661tPQVf4YsZT26/Dd+i8JLchXY7MKawp26nvzvhntodu4Tthc8SsvoAo8wnXUkScCpqR+z3L6hqSRAYUy/EEty43uOW2YvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L5eCMQIO07I858f9zMwg877hAQqKDTPJsxQQHPNzuI=;
 b=NVhFIxYMLbd+OjUSHHSiI63uKh4O2ZW6ookQj+U8gnY68z7MnsBmBpd6Bs+OJwVpFn/z/R8WlCtAb7/1uqPgoOJ2lmndRP71hw9YfdTWwXHa1XERnGBeNG+wW3ppHP4hcLp1NTylzo+3yZ9RIlZTvQHIx94Yzlz3Gu/HSuu9xipTOHeYNNNdX6wGVsY85sfVhFbPWN9/HH2N09raNcIiMSByWNPh0hkkZ0jEzbGGbVBjxaZNvE8/nSS1rpndmF/DF4Nj/YKDerXUlu6XO0TT35ffZoDZSfquCKDG+0+3ZB4dBVNDJ8YczzHjzWt2gjyljIy/wDM0boK1bObANtwmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L5eCMQIO07I858f9zMwg877hAQqKDTPJsxQQHPNzuI=;
 b=iPHGZsZenLQa/kPIlatK+Vmx7ZwnlffGkpOaqO+zLjyfO71P+7p7aPXGOeDGO6HlCT4XaubA+9w05Qy7hSwp7W8Qx5AHKspJAKr7inCXFLx8yMdosaxdQDv/5WbzQWoXu+BjhCXyYvhYJ0fbD6bJQDMK7pFSO4AjO75VMVYHyxc=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 10 Oct
 2022 05:04:04 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::d8bd:518:30e6:e7b7]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::d8bd:518:30e6:e7b7%7]) with mapi id 15.20.5676.028; Mon, 10 Oct 2022
 05:04:04 +0000
Message-ID: <91d8d712-f20b-0809-7272-9b16bf83968d@oracle.com>
Date:   Sun, 9 Oct 2022 22:03:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] perf/x86/intel: Hide Topdown metrics events if slots is
 not enumerated
Content-Language: en-US
To:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, joe.jin@oracle.com, likexu@tencent.com
References: <20220922201505.2721654-1-kan.liang@linux.intel.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20220922201505.2721654-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: fccf537b-ac08-4e9e-243b-08daaa7cda37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gh3ZxLQfPqZtfyLPMl/4cFzwYqq82xH1blEWd/cI3Rk/rH8PaxtibMrfisKnsesA/fo9U9qO/0zUdfzh0U4IYwnApxBl3ZkRu/ISqY+LUYeQq+Y/0Mod2IgRyHje1VglHMFniJFEZkNfdn/962PgKtEG3+NGMLAh+zOG8xKTQyvh2CfGE6sR6Zole5PQ6UeiJVw9LQlOwnEGwK2r354p6bFT5YZupLJ0LXUEet2q4fIC4IJdd3ah2XfmR3yMBF/zfFZMaYE5z7ZxwcQ9JMRWalChEyoNDMWWKIwBFRMgm782eF/APig7QMDv7PwQGAACiWblUeTakVVyB+eY5VvSMFzpxtZcU+y5j1sKw/cAbNBRSQVoIPSLYGO4mqM6IaA32G+q8lA1x+ChMY1JLnpfPoZfN+BDJjSdFr7d5W9t5A9Ra/W8igOaDvaqYKiWHUjiRMhkNr0RWTI8s0gpUCDnNJvkwsEdmiwmWXUJMweV8V+ZBETx8j6sTUWaCoQcP52o3AD8MPbtqZDCWn2A3MjuYchwXotEWF/ipkbUuqPCJ381ylXTJ0yrZt3C2919J+4fpRK8R0TvcrNPTb7ufQdVE8y/Jk08fMxVmnSWUvk7Pq/Mb6Zg3Ua8djwWAvf0+i3H+N60Axkao1kvmzIG04UL/NO4LtAVZYli7V8X7Ys8TmLLb6/BzpPNgNWRfhkccUTnqiKvHbbPEIbutY8gr9KUWuwraJd8A42a9ojV/8ghaXPkMwzuAmgJqMMYx5l5NsTRb39Fth4kOcD59FSV2sy8xJHTcDdCoJ3yZTjZDJHLnpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199015)(186003)(83380400001)(86362001)(31696002)(38100700002)(44832011)(5660300002)(316002)(4326008)(66476007)(8676002)(41300700001)(66946007)(6512007)(6506007)(478600001)(53546011)(2906002)(6486002)(66556008)(6666004)(2616005)(31686004)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNtTGFpelZsdi9nMkU4eW1ZZnBtd1BxUjZYekZmMXVsY0pWUU9xZWVtNlN0?=
 =?utf-8?B?NGxQYSsxLytYdWJhV0gwRGVoOWlCTzE0VXdxRDAxM3RNTE4wOWFrWStVU25Q?=
 =?utf-8?B?RzF6VXc1WENMN0FLNXJzb2lSWW8yRDA0c000cTlKTDVWZGxFYVY4b0hiUlkx?=
 =?utf-8?B?MG1nQVpXM3NveGh2NHpURktmYmJGd2FjVGtnZDVucjlJMmJMZ3BtZW1YMWFQ?=
 =?utf-8?B?SjR0WkQvZVpPYmo5WS8yZW9UbjZQVnVqZGt5eDh2bVBueU4yRUp6SU1qR2R3?=
 =?utf-8?B?SytiTjhFTzVBSDdWMHByNVZkaHNFNjlPcEtORXpOWTFFWFRtbmRPTFFlT1BU?=
 =?utf-8?B?WDJkVjhJNjVlZU9iRmlrVFpHVGtuUWpxYmlrbTd2SW1zUHhRRVBLTWE1SUli?=
 =?utf-8?B?V3I0RmdVQ0hqSUVoKzlQS3I5cGQySGhEaXpCVFhDK0J3cnpzZmFxdXNqNkh5?=
 =?utf-8?B?T2JMZXVObDdzbzk4Z3pHbXM3SGVnSXBab1lIVFpUOTg1OEtlbUc0a01CVS90?=
 =?utf-8?B?U1dES3JZSUxBbFhVK2doSDBPbndHQWF4dEtHTmdXcVVXTE4xQWRYUkxEdEo3?=
 =?utf-8?B?VEdNTTdqcWdRc0FFWXJEbjFDbmxVMlpUN3RXV2JqSVIrQ0QwS3ozREJ0dVpK?=
 =?utf-8?B?ZW1RNE01OHkxem1ZNTJJK2Q0TUZkNzgrZ2hIWFFSeWxxQm4yYmxoSWpQWmlN?=
 =?utf-8?B?SU53R01YNkRJbTZKNU05RUpxMGpnTzNKUE9SemJLV2FmenlHTGhSZ3Fkckx2?=
 =?utf-8?B?Rlo0STV0d05lYTcxZUlkdEtEVlVKTTNoSzBaN1N6anhNcWNIdFJaejBCRDhL?=
 =?utf-8?B?MFNrR213NDZBcnFuMkxkYW5wSmxSdmNNQW84K3ErQ3hOZTRONXRCU3ZLNFUy?=
 =?utf-8?B?RVNlVk0zVDQ1eW9wWHMvWjdqSGhTNkxpSnZvWG9PWHp1a0UrL1ptaWlLdU1m?=
 =?utf-8?B?aXhFMkdjM3BaaHlBcmwwYjJYRXFmV3FVVFQ5d2tNTUFHanFjYThzb3NBQ1RQ?=
 =?utf-8?B?M0xFTEwvbmM1czRwTlNsU3czRzkrbmZLdTBmZzRjUlh1NzBFRjZiSEF1WTR6?=
 =?utf-8?B?L2NUdG1IYytxUys2ak9lVEJqVWNnNDVKc1JTbnB2Z0ZPVU1XVzlLTHdDT0FB?=
 =?utf-8?B?d0UyTXVzN3Z3N0Y4a3FFRDd1VnowR0hjNVJZUm1MejdLUFdWeEV4SDlTMFRv?=
 =?utf-8?B?aGdpbnhnY2R2V2x2VXZSUWNsSDV5bXNCS0x0bmxHOTRzNjkxWlA0Y3pldVJJ?=
 =?utf-8?B?ZFA5SWViemkva0JpSnh2MDFvYlJyeWJoejFWbExzenZNN2toRmRYR0ZuTE9k?=
 =?utf-8?B?cU1SRTR1dElsQW03QlVWcURpdittVjNDTFlMOVJUZ3dDNHBUUXRtaHliQjdE?=
 =?utf-8?B?bkI2VHl5eWsxNURuc3pmUytwSUZRSnNPbDRYNnJzOEVWSktvNnlhK09xR01a?=
 =?utf-8?B?dmp0UGZpVEFLVVU3Z3FmUWQvOWc1SUVkdmpWMEFyMHJPbDM2MEcrb1V3NG4v?=
 =?utf-8?B?ai9ZYUwvL2FDMEkzeFpRdlRMOFFETFY5MnVyVEFBREZaNEdaUnhtU0dycGdF?=
 =?utf-8?B?TUY5VUREZE4rMnM1VE5NY3J2c0hKNllsc0d2bU5ZRHpQZW4rQk5NV1JPOFdN?=
 =?utf-8?B?R0J4elpzdEdab1phNEh4MVFIU3FYeUxnQ1BaaXBjMnJhb3d1RE9JZnhQUUgy?=
 =?utf-8?B?VTdaVVJNZGc5a2FoQ1hPeFBFVk54OUJXQnhndlc2MXlpTHNMa2U5UThGczd2?=
 =?utf-8?B?WkJhMC9ldjluc1d5Rnl2empTQjFZa1dkNmRLUEdxcjN4RVllUWtYMUcwZWda?=
 =?utf-8?B?cXJ3eDFMcmhZdmNEUXFTTnl6SjR1Y3JJQ1I2aEdQL0ttQkY1SndZSHZHdXJn?=
 =?utf-8?B?U1pnM28zWXVMWklTd1AweHlZWGNnckVuRmRNdTNnZVFrQTB4MGNEOFRrN25j?=
 =?utf-8?B?NjFxU3JIZWRVZDhTa2lqenlXcU12Ry85MUZZWmJhOE1zdC9GOFZESDRuZ052?=
 =?utf-8?B?a3V6ZmpEUENhYko4NityUFZQdDZQckREUXcwdXd6Y0lrMGRVbkRJZ2xLODVJ?=
 =?utf-8?B?TERmWnMwZUIrMzZ4UFFNVkc4QkFBdEFtZkU0U3BObS9ibHBWbVZaNkZXcWs0?=
 =?utf-8?B?TDI1VmpaTE85azN2WjJscDd2eVQyYmEvdWdOZVJIT0xaMjZaYTJqQzUwRWdB?=
 =?utf-8?Q?CWChDLdJyGFF3qwIFCelcoQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccf537b-ac08-4e9e-243b-08daaa7cda37
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 05:04:04.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Li97xH3f9k0upjupAsn2HGWlUw1ou4vjmVXS+kEENhWQ7pd9jD2Pa9GokwCtAvtWa44xn/fCokdz79j7tuTbZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100030
X-Proofpoint-GUID: G1F1C-P70XMQe7Ahzid6We2LNoQbkut-
X-Proofpoint-ORIG-GUID: G1F1C-P70XMQe7Ahzid6We2LNoQbkut-
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

Currently the default "perf stat" may fail on all Icelake KVM VMs.

Thank you very much!

Dongli Zhang

On 9/22/22 13:15, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The below error is observed on Ice Lake VM.
> 
> $ perf stat
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (slots).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> In a virtualization env, the Topdown metrics and the slots event haven't
> been supported yet. The guest CPUID doesn't enumerate them. However, the
> current kernel unconditionally exposes the slots event and the Topdown
> metrics events to sysfs, which misleads the perf tool and triggers the
> error.
> 
> Hide the perf metrics topdown events and the slots event if the slots
> event is not enumerated.
> 
> The big core of a hybrid platform can also supports the perf-metrics
> feature. Fix the hybrid platform as well.
> 
> Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
> Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index b16c91ac9219..a0a62b67c440 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5335,6 +5335,19 @@ static struct attribute *intel_pmu_attrs[] = {
>  	NULL,
>  };
>  
> +static umode_t
> +td_is_visible(struct kobject *kobj, struct attribute *attr, int i)
> +{
> +	/*
> +	 * Hide the perf metrics topdown events
> +	 * if the slots is not enumerated.
> +	 */
> +	if (x86_pmu.num_topdown_events)
> +		return (x86_pmu.intel_ctrl & INTEL_PMC_MSK_FIXED_SLOTS) ? attr->mode : 0;
> +
> +	return attr->mode;
> +}
> +
>  static umode_t
>  tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>  {
> @@ -5370,6 +5383,7 @@ default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>  
>  static struct attribute_group group_events_td  = {
>  	.name = "events",
> +	.is_visible = td_is_visible,
>  };
>  
>  static struct attribute_group group_events_mem = {
> @@ -5522,6 +5536,23 @@ static inline int hybrid_find_supported_cpu(struct x86_hybrid_pmu *pmu)
>  	return (cpu >= nr_cpu_ids) ? -1 : cpu;
>  }
>  
> +static umode_t hybrid_td_is_visible(struct kobject *kobj,
> +					struct attribute *attr, int i)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct x86_hybrid_pmu *pmu =
> +		 container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
> +
> +	if (!is_attr_for_this_pmu(kobj, attr))
> +		return 0;
> +
> +	/* Only check the big core which supports perf metrics */
> +	if (pmu->cpu_type == hybrid_big)
> +		return (pmu->intel_ctrl & INTEL_PMC_MSK_FIXED_SLOTS) ? attr->mode : 0;
> +
> +	return attr->mode;
> +}
> +
>  static umode_t hybrid_tsx_is_visible(struct kobject *kobj,
>  				     struct attribute *attr, int i)
>  {
> @@ -5548,7 +5579,7 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
>  
>  static struct attribute_group hybrid_group_events_td  = {
>  	.name		= "events",
> -	.is_visible	= hybrid_events_is_visible,
> +	.is_visible	= hybrid_td_is_visible,
>  };
>  
>  static struct attribute_group hybrid_group_events_mem = {
