Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE366939B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbjAMKCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbjAMKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:01:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB191158;
        Fri, 13 Jan 2023 01:59:46 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D9kal3009800;
        Fri, 13 Jan 2023 09:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mt+cRANZZZFxUu76bt7nDaeIvLdnmdUEA94LGK42yGY=;
 b=qNR5N0O9E33y2MGSWg7O/vOMA4YhhP8dkIJfIOYf3w016z6DPpJMUYsCCy/KGeaAgfCM
 zwEp3ontS+K6LSV5jJIHfJ8t5vx8x02ZPWFB8oos1IPjzqH0KGF98xFIsXS/1/Iq8Rf7
 VRNohtJyu1QccJdsuGS7O0xm+4bVQQTY33cV/DTfpN4YWnPi1nkVSVdyghrP5FOVLRjC
 MYuF0zFD0kLuPY0zdQ5DbsFF+PLy4EVl8g0gp2of7lcMp74K4ru1Az6JAIpQpWwdqPaH
 wLrzsWWfvI/7v/tWDpAOaPfC6d7mT84LBTqEVZ4I4n8LdbNkTpLkOAXxkz3pWnLBD7HJ fQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n33spg56h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 09:59:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30D8dRBH018636;
        Fri, 13 Jan 2023 09:59:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4gfbse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 09:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzTPoGHbTc/ol7Sa3YwdNBqbthO9ayrnOLv1oZkXbnz/hna64LWluS8zgUOihF6Lh2qYEnBvXikLKG56WotoTtOiGclJZ/aYV9P7P7dO0UdX1TaZfwVkH9C4p5pa5y4oQYAvFG9HBb+805zRc47pE8J5hz4x9EDFDnjGbXhcUiP2DgzB4Bol3TQDjmRd7w+WND1C7NtTolTMumzTAJFTtO8cdy0eZBrtQVYTQA1bIysrKY1fb0F4d0hpXJFw5Xpzfxkh8qIVqBv+CTk0JGYDfoNlSr8BRORlliBwccmEJtTjG2JFPxHAdeQqcRclR7wxwKUpvQXlEgHgn+39KDnJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt+cRANZZZFxUu76bt7nDaeIvLdnmdUEA94LGK42yGY=;
 b=T9Pl1fSEBHabBnD9ScpmujcJZL7t19Bgci9SZJx46/ULMJ3pPOCxr+NW8DQDbLCYUDyjIzFSJ/MaVV6DQOAFWvTOpwXtd2t2mJw7yx/cokI/Qab/Ey2X477/pOnlhXxewCWjkf/cLzDyTG+DnTyv9+jBrBRSW0swdvNZQEWJeiy7S1jq+hfb38tI/ktdRkpEROMijZcozrPedyBFXNe0hX6zf9UbWgJnXMufa/ENV7f8sQRS8c/shWi3ir1GqKSsefkxU5pSdv58xXh/kKMdLSWwTiEP+lcznptcYreluHsMUTLI1V8pNptlzIvZz/t4KFDlrrfWSdJnWDj7lWdgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt+cRANZZZFxUu76bt7nDaeIvLdnmdUEA94LGK42yGY=;
 b=ZzIYRyVltETjth3nhiLZivFfGd8vurRRPxvLvRZ3pXEzl6h7ovqp0JHSQI0uBF92fxXS54H+qqQfqBfZsoD0yP6FMomV2iPAOwv5CHBzNAFpQxsTQ2853WzeTkZLi8nTUAoc2xZmLurPyx1H1+bOj4KHDC9qC6xoAGqfVznguCc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 09:59:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%8]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 09:59:15 +0000
Message-ID: <d33086a5-233f-f591-c9da-5f1a2e8aaf54@oracle.com>
Date:   Fri, 13 Jan 2023 09:59:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 0/9] Add metrics for neoverse-n2-v2
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0180.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de03210-9e18-4dd6-0e21-08daf54cd3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuPGXUKmMg72Yns0/yF5yqg4XxHwoCSE6uNW9g1iErjdxj7IY5VnZVuJELkwhzWNrrYdSv15wM8uyN0a+Nx+sHKpEaakC0b+A+ZWv+21QBoLo4D04jKu0ksau4FM4g+glJ7v7hvSXOtRqPHI8Q0MUclFXg/OyJnzsbim2HsNwo6koBZ3SBkqauEbtL6QsUyI14AlfbbZaULWT0NPOMY4UZwHodqlNbE40z3iit9+jiV7MW/zGNFZkso80+sZ8f9iRi8t7eq3UF/kP6gN4FuZ7WM5rYOgEkctXEmhw/7ytaoFLBgEV0G/qPElTieIYyaAjSOGMiflpOkTjtOjTjV/IpMFRqjMNutVbNBV0epIotkrUsatHQaKtUnfj61jTK3lNX2InNeaMIPOox8lif7cyjiInAb0fq7xXFL9kj3wFR60oAPJvhciS5Yyrhf1lLmpv3yoxcqdwT/6wSItZqMmFb8VputyeazLmzY4u+LMUvJA53rNhnL0ThhpXjH1GROxl1PmEBhOyz0jEAMPrQJcBOfg1uCQq4jp+jquU3PqpupnL70BDR1AWRpkg2nv8riMi1GKvUyvi23B3LIC53OGfmhYdAJjDsukhzIEY3mAv8RFK3Hb/oDJWSDm0yNDL8Y/lR7Cq3E5WRns/JwRhca9FwWVClVEz2oSjPefpSaEoo4etCVlO4aLhG/D1Ryi7FjuyN6jpxPfK5BikjGUYRfYqfuc628iSG4OdesNb7atGAtALbh1ijXO0uJ44N29/3fI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(6506007)(36756003)(6666004)(26005)(186003)(53546011)(6512007)(6486002)(478600001)(36916002)(38100700002)(31696002)(86362001)(2616005)(7416002)(8936002)(5660300002)(31686004)(2906002)(66946007)(66556008)(316002)(4326008)(66476007)(8676002)(110136005)(54906003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU91Nnkrd2tQdjc2VGxKMG1CVXFtZGtLYXY0b3F3OEd2a1B1eFBpb3hEV2Ro?=
 =?utf-8?B?Q2VScE5USnpvTVlHQ1RGc0FwNEFGTURGVy9Zc2tNd2hPQUtWdkdkVG5BUi9v?=
 =?utf-8?B?OENtb2swbDBOcjFrZ3pmR3VsYVYrUHBnZW16WlRlZ0g1ZE44MTU1Y0NzZGt2?=
 =?utf-8?B?dE9MTDBmZzF0cnJCajVuQzZmWXVEVW1hTTRuSTZsVHNacmhDRjNGdEJCeTJv?=
 =?utf-8?B?MFczcVVrY1o2dW5IcG44OElsSlJFTThRdFlBcGtaTjh6WjhveGJjSUVBZjFG?=
 =?utf-8?B?QXorYVppTUV5SDAvTUNnVEZBY244aml4MlRVNm9nY1Z6NWJLUnJPUTBBTTZa?=
 =?utf-8?B?am5tMGZpdkxPbnN1UVZLdlR0Sm94SHJnTkhPbmNoOXFxQWR2TTB6UE5WNXlk?=
 =?utf-8?B?TnRkNDZQVElnQmRrbzRkR0tRZFVaTVp3b3FtYSt5bXNEbkg1VHV0c09XNHA3?=
 =?utf-8?B?bHV3R0VZRVU2Y1VXSEVmdlF3ZUc3ekZXUzQwRm5iYmRCaUJpbkJnVmZmbUxs?=
 =?utf-8?B?R0k4YzgxT1AwYXNpRjJYUW5XdHVCNWRuV3JxaWZxVE9mT0RNTmtpR0RXQ0Vj?=
 =?utf-8?B?ZUVxQmJ6R2s2OFh0WXJCcytuK3M1RDhOSWJGRUdFZTllUXE3d1l4QkhGeDVi?=
 =?utf-8?B?dFNBd0RuUVZtMk1pTFFxenFiYnREQVhpZGNPNUtWMkladXlGMFU0SG1mVDhD?=
 =?utf-8?B?UEIrM0dOWUk1Vmx4d3g0bVAzeW9DYjFibUJxdGswTUtrWURVUjhTWS9BVjFR?=
 =?utf-8?B?dWJMZFdEL3NVSUhEaVNmL3J1S003c2E5enBDVnBmT1c5c2tlWFZmMVNLQjFx?=
 =?utf-8?B?bFMvbEovclRSUWxTSGVZUzRyZlBRN1FPSUtWREI2dmxJSlFRQ1ZrWEp5Tlln?=
 =?utf-8?B?OExaUFBSVHlWZFZqVzFxdXowdlN2MjMzc09IeWNZL0pWMWV5YnFBRjJLQ1Er?=
 =?utf-8?B?cCt6Nlo1bnNPcldlNldRaU0zcTZPdXpzMkRpNDF3OHNsU3NvZmF6cG5wdVJI?=
 =?utf-8?B?eVdnVFdWSHNyVFVIVnNGb1NsWFU4ZWVGZXJuUkY5MjNySVBjTVRuU3lrdVpT?=
 =?utf-8?B?SU5zdUVVQVZxYzlGWlhpWTdyQXM3cTBLZnJXbWJCejZlY3J1dTVnRCtJbk5Z?=
 =?utf-8?B?NjVUNzR5N2RVRjZYcG56NzR6MCtxNGJ0Qy9pdmhnVzJxTkVSSG8zVUFWdi82?=
 =?utf-8?B?Ky9FWE9qd0VnNTFjU0IrODBHTTV2aGJZT2wvMjJRdk1DcGtXa2JPZjJpZHBC?=
 =?utf-8?B?OUE0S1RHL1dZL2xJcUl1aXhpSGRxVDVEVE0wMGZ6aXV3Qll4VklsN2MwdnBP?=
 =?utf-8?B?cnFUNTUyTWVydForTVRyVEtJQmo3RENuaFMyYURJSjZFcGxPZzNBWGRkakxQ?=
 =?utf-8?B?MjFMcTArSWhySjRlcXhFUDFocVM5K2NVQ1Nja2JzMG9ITkhXL1FYaTJ0Z29r?=
 =?utf-8?B?bmEzNXc0dWpBbHkzM05oT2NWNXJhZUFJaDkxNHpIeVE2Zmc5cW9LYTNWUFA2?=
 =?utf-8?B?Q0oxRUViRHdUSWhLc1dXU1F6YjE4NEt6SmZ1aXpyUkRXbndTMlgvVWIrOWRW?=
 =?utf-8?B?OXZnWTZTRGdJemI5YVkwcVE1dUZFU0RMVjBPUWNETWs0VlVqL3hKOUVWMmtn?=
 =?utf-8?B?NDZZTjZlN3VobFU0MUtwSlhFSm9FdW84Uy9SZytXNy9KTWVoVFA3UmhqTmhP?=
 =?utf-8?B?S3JiTHlocHFjdW5VVlNnYjZSaFo5TVdSREZSL0hlRHBxR3BudU10UFA3bzEy?=
 =?utf-8?B?WWhQNXNkWHIxbGVsczg5b2FJK2V0a3l5WG9sN1JRWjRUTjRsREkxbUROR0NR?=
 =?utf-8?B?YnJxbG1PQS9vZ2RvT3kwWGc4a2ZHRTEzRUtxVzlKcEsxaTFQaGNIdkIvTEF0?=
 =?utf-8?B?VUZJL2tVcG50MmhkdlovSk5EMXo0czI4cWZJN0JLL1BwWFF2VXNFS1dkYyt4?=
 =?utf-8?B?ZTNKNksxaURaekV3UUdJR1J4YU84ekdmbHorQTdlZkp2NnlaMXNHbzd1dTg3?=
 =?utf-8?B?YXRwdi9rWEFmVWNrREpQRUFrRlpHMzVTcEwxTHBDem9SVEoyV0pSSGhSWWFs?=
 =?utf-8?B?d2cyQnRuN3VYRW5tMXFlcFF3Nm9HaXJNb0tpZmxBVjZxcWNSa00zeGJwbzlE?=
 =?utf-8?Q?hEimzAp0ZmqL5Afzs7oA//sNN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N1JlWjBuSzM3Q2pJUVY0a2tXK1JZUER0UDVQa01ycU9IMjRXZ0kwbXl1Wmpk?=
 =?utf-8?B?dHErdVF4azVyT3U3dmd2T2Q1MzZNZlJQaGFSaWZGeGJ0UmRXZHpwTFBCdmk5?=
 =?utf-8?B?MGpnc0txMnhjMnRoSEtGc0tFQ2h6WWZTY21VdDFiQllLSWdLc25zQWE5Q290?=
 =?utf-8?B?eUxOdDJmb2RvaFpTZmIwR0FzU0lYQ0xjZGxLUUNSY2RDdzZWcTVXL0NLMm1E?=
 =?utf-8?B?bTJXMU1nM0NKazdsN2RURzBGK0xHRXdkSThxWldiWGUzRk5PRWJNNm1TQUhN?=
 =?utf-8?B?K2lZd0JzWWlobXJDMzNRbnQ5NkI0bWNuWnAweU9WSWNyT3g5eS9KYzd2TmNP?=
 =?utf-8?B?R0V3WkhTaldWWi8vNVJrRTRsRlNPT1hDOXpuL0xLaGtNdXJGWmtjVnZpSXNT?=
 =?utf-8?B?WjFERDhkSEZNMzhZaUFYSG9NcXVHVjQ1c1dRYWsxbUI2ZHV4bnVML0tMcnA4?=
 =?utf-8?B?SFpuUC83cThkZjJMbjFpZHdtV2UyNU5wam9xVGVjU2luWGlGMEYvZE9rTkR6?=
 =?utf-8?B?RFlyanpjQXlYcjR5Q21hZCtWZEJhUFhVa0lMbk5rS01veHdsSkZRZjFXdHJs?=
 =?utf-8?B?OTFIeFdLQjNmQjV5c2c1NC9OVDRNTlV1M0RKRzlNN3JhMWJwTWhzZGMxcTA1?=
 =?utf-8?B?Z1V0UWV6TmZVMTYwc05ZS24rR1V0RmJ3OUtwaG5UN0E0OXNIWFFmaDBtQzcz?=
 =?utf-8?B?NWl1SG5rQ1hoei83N2dGejcvSVFSbzQwWDk2V2kxQ0w0ZkZzOVJ6bVcyQkxi?=
 =?utf-8?B?ZUJOMncxMzdXamlNNHpJdUZQNFp3ejJlcnhMYndxWnp6K2NhZGtBNStTZjJk?=
 =?utf-8?B?aTU3enQzYXhtcG5JcWMwV2dEcHI5RjJBQ1FCcHJNUjg5N1luVzdqTTVZdnhy?=
 =?utf-8?B?cFkxQ3FaZXFsSGo4cXRYMDQ4RldwZVhqQzNYbUs0RktHQ2xpK0d0VWZmN3dD?=
 =?utf-8?B?VFFqeWRGdFV4K2hLdlFGN3FXZU9kY0YvbExmaGFBWGRQVXMwU1pESzdPWGNT?=
 =?utf-8?B?aTZ0K0p4QitQRlZEc3d0d3VaTFRiWnh4WWxSVDUrWU9QcFJNNkJOZk1TR3ZB?=
 =?utf-8?B?SlZYNjlQVmc1QlduLzc3ZkRkSW9MQlo5Z0R6YURvN3lFVng3cEMvZ2pMQWNH?=
 =?utf-8?B?dmFsTDZtUFRiNFk2dDY4Rk03UW4rUUtucERjMlo1dGRWeVBmRzNOV3g3bnJG?=
 =?utf-8?B?ckkybzNHY2pHSUxhK1MzVnNlNHVjVUk5VHZXVjFPdzdVQUtDVS9xcjlQUFgv?=
 =?utf-8?B?TURuaDNXRzE2czh2RHpxaU4vWHpiZjkwL2lDTUFqMUxwdnFSMTEzemFOMEJh?=
 =?utf-8?B?b0hNbEx6cFdMUXdaT0JYam1pR0s2MElnZklWYngxK0NNaEJIOTdXK2hIUjZR?=
 =?utf-8?B?cTJPeE94NFFWOXg4V2FCcTB2VWxaa1M3RHhta25OSWVlM2RhMDdZTHMrU3hT?=
 =?utf-8?B?WnllUllST3hpamdRV3ZQQjRhMVhHMStyZHVOVnVnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de03210-9e18-4dd6-0e21-08daf54cd3d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 09:59:14.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqG/YbkSDtOf9Sa8HwqlzgxqjgxJScNZPp6emg4NCwrv2kJ4QPL+48zHzD60TW9hBu5hu6DsPziolZtOcQYBTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_04,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130068
X-Proofpoint-GUID: 6yPOKX8d8cWOLMrE9FDAC9_cS7x5q7mE
X-Proofpoint-ORIG-GUID: 6yPOKX8d8cWOLMrE9FDAC9_cS7x5q7mE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 09:22, Jing Zhang wrote:
> Changes since v6:
> - Split patch #1 into 3 smaller patches as suggested by Ian.
> - Change perf_pmu__get_slots into perf_pmu__cpu_slots_per_cycle,
>    per John's suggestion;
> - Return NAN instead of 0 in perf_pmu__cpu_slots_per_cycle weak
>    function, per John's suggestion;
> - Factor out pmu_core__find_same function, per John's suggestion.
> - Link:https://urldefense.com/v3/__https://lore.kernel.org/all/1673017529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com/__;!!ACWV5N9M2RV99hQ!LhBq67uDCOsz1k7ZF4aQPHF0Bp8FsMr-ZNgCnBSUKF4qJTFODfnkId7lw_NXqB4qZUCpu-jbY8z8LTckoqFGz2Q8bA$  

This looks fine. But for this code:

On 13/01/2023 09:22, Jing Zhang wrote:
 > +double perf_pmu__cpu_slots_per_cycle(void)
 > +{
 > +	char path[PATH_MAX];
 > +	unsigned long long slots = 0;

I would prefer if this returned NAN (and not 0) for when we can't find a 
pmu or the value from ./caps/slots is zero, but I am not going to get 
too hung up on that.

For series:

Reviewed-by: John Garry <john.g.garry@oracle.com>

