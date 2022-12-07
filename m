Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD8864607F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLGRnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLGRnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:43:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F285C0CB;
        Wed,  7 Dec 2022 09:43:16 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GGpGN016126;
        Wed, 7 Dec 2022 17:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JhkdiyTsc+v/5uJ8Hs4DTFYq/5OKjHcT+RD7XBVSgLI=;
 b=tbq4sDGISmputuOf//vHlReYVywvLSLM06SDCS95MQMQW/yT9Hr5SbxjRIz+/8St1q2o
 hmNuHeTYsZCic9ZG2Lm1vgaP9DcR00TmrQTNFjNc+w3VdWuulaQV9+aKPgqnHohWQgCZ
 Xii4zK1DPcX+sVc7WoL9TyfpV5POoAlExqhpjaAbpIJrXG0hnY0VK5OD6usam6NdcdF5
 iV3HaBhrTUnBR8IINHNMB5NwF/H4ehghUpnw+IJqFEr+0Lp7NPhyCjvarT1WWhXPWe/p
 xfW182w0s+t+bN88hKnSBayFcpNPAjAkQJk5K/FCcc2R9GdVF1rHNl9fehx2ePEsN90B FA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maud70y4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:43:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7HXlWh017189;
        Wed, 7 Dec 2022 17:43:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa5y4mxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc5aag9OCrtYJYLBT+g8UI+eVgkZvIPJFBrEHAz6yqJXQYtv9aZuCPKBGy3tXCkf77gi6UE9Rj+1XltlXKUdeMw4sdDXAWvPuEn8k37Vh4n1NfnLmh4f4aOHNYdlmKZSCqjv4/3FOoX8J98DbNdC6KftkK1qKjEG66Znh026cgvIPmhZ7YaxBPzkuc0ZtQQuQ7y98IfdwT0lbU5pcB2Zcm5VxvNDKDB9kBcFqowIcSCsr5Ka0DkeFfhWhD1NVWt9H0l408JImWXCaF3SJNbGjU6MR3N2QhWmYpbTGnQaYV6oG46nEOAX/ZTBp+Z7Fs9jOEn8DNK7MoPxKI1sfC2dUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhkdiyTsc+v/5uJ8Hs4DTFYq/5OKjHcT+RD7XBVSgLI=;
 b=AUdP+nKuCigBUweKFPPuFN9EMNm6vMmZi+RRvXaO5GFQNx+pc8t2gXSDVQNnxz6Q+xsxY3JJkK8ByMJ8eg54+y5+1/MR1Ls9SByHegDQPTdW2fSXX1PJtjSTTNmcv3Dq8cFO1bmgdukRohZot7wqOUa7BYF25o20ba0xc6qLJ9iYoGTlOU8+egG+Lrn/G1v7Nu7LrN8/BWmbSB1Vk8GlKl0H5myldR1bgEK8df2cxbFMWV10tFzndIu9e1kt7GYrfWjkUcz2aBY2Bdd2KO5KZrpBMDjAXtHnB54yggq2auR57/CSytmDjN6WtNaQ9Kt9IjTxXV0O1Qodw9sorFEkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhkdiyTsc+v/5uJ8Hs4DTFYq/5OKjHcT+RD7XBVSgLI=;
 b=ntgKt4KVBDmwUR3OORBqHCJwUpvDfUx08hF84XnrVkpOGtUcd1ZUYsrZSHKkZKPTkoQjrrM/NoHJWSbbN/DrSsZxbwe66DGKWOg1wgqSSGNXznHWfhV7+Hf8GZibaH+zsdOeLC60FQTDEFlK0+4EfL7ha28BAOq9KBolbJ+ljt0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH2PR10MB4135.namprd10.prod.outlook.com (2603:10b6:610:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:42:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%8]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:42:58 +0000
Message-ID: <0d64e485-5acf-b7ad-e228-9bf85d8ae16d@oracle.com>
Date:   Wed, 7 Dec 2022 17:42:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4] perf jevents: Parse metrics during conversion
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20221207055908.1385448-1-irogers@google.com>
 <Y5DQKif+PdRJblk+@kernel.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Y5DQKif+PdRJblk+@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH2PR10MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9ce051-2cfe-4bef-75e6-08dad87a7aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDPwmw9RI2r+7tr5nxwlzqpLFa10ixJ8iw0E07C1rIyZeB0yVnZxq8BAqsG5DkUFh/XyFbuf2HEIR2MdHVXQYyTqLa3eh8YIoWCiG8jcZprWp6AkcolOBkMbHvz0KNoNlG3l7oXw6uaRSz0JoHF3cm9cj9dyQ5cskibZMgEAigNYzn380B9cVl/xWQGQ0FW567+cTNeAO+B8itjfgAXi+SIwZvA5cSXZJq6FjGigm07fxIw7CRiTMlgApp3QZ7Srrje2oMql6I8lUG2ecTI04UNPjHAiFwy0Io7cDFsz1qXGeicUHh2CLEG7jMUKgPCekdKEUHrsmL1dlkQETfENMan5MX8n+VGUehfsPaycIOYuFhU7i137zWTGtoOBOF5IUVd0o9TceSDmshEqV48jketW+I5Q59J6LtZ2Plp4LcI21PMwWxAo+vwxCDfD1nXWuaKM9Oapj+1SdE+9cefpfKopD0Pf+PDELU9GJHovmDADODo0GF3UQhJ8iSSOCFyQt2uUgDoz+AR9cM1Jix71xHrc5GzWC9dUnUl7SwrOk/9LWZIsH5hxEjJeKG39g3SUC6OnXLcw3Lv3t8uAKDnSKjuz8uMjGLLdT8QuYKIToc/YC9LVKqD01/XCOzlJR2b7MHGPSnfIUnA51/lJO5uAkPGTeiJVeCY44MGNJ0S6p5GZCCu9acTl41jI3c0AgQGP+AZT4FTgdk4aWsfjJBvCUtLUPFt25LqreiqtYDnWaCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(36756003)(8936002)(31696002)(86362001)(41300700001)(4326008)(4744005)(5660300002)(2906002)(7416002)(54906003)(66476007)(31686004)(110136005)(6486002)(316002)(8676002)(66946007)(2616005)(36916002)(66556008)(38100700002)(186003)(478600001)(6666004)(6512007)(26005)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czg3YTB5Z0NMNmhtT3hoSkJVak5JdFpCeGtwVWdYRkJMRk5TSFZSNjVibjVm?=
 =?utf-8?B?ckFpQnBGUlBmMzRBSW5IV0hYT3NUZ2RRZ1FNU2hjbzhGQ1VwYXhSMXl5Q3Yz?=
 =?utf-8?B?TEc4QXpxRXJRVEk0QTVYTWFjMWZ2d1UwWWI4bkxUbDVId09sbGVzeENNajZI?=
 =?utf-8?B?Ym02M1VSTWw1ZkRnMFpGZEdpZ3NMUEprNGZ4SW9KNVd0dTRaWUUwRnNlTHRX?=
 =?utf-8?B?OVlWQ3BjWkdSaTVES0M2cHFhRVp2d2F1a2V6VEd0a0ppMEpxNUlkN2FjWjVL?=
 =?utf-8?B?cjZPaXdYczllTk5SZmdkSHBkeVpUa21EOFBDeFV6TVVIbHdXWm5OaVNubTlF?=
 =?utf-8?B?L1R5V0tZbC85a1ZEZjF6djIwUVA1aXlrTEhRcmFDbXc4dndObC9BQWtjVEpo?=
 =?utf-8?B?cktzNlBCTW5SMGh1TS81aTlrYWorU3Uyb1BiMUhaMTZBREJyS0hVZlJuVFRk?=
 =?utf-8?B?L3FnTWZJQmdpZ0taRG5oYTIwbDhhakg3Qit4NzRtNGJZelZId1lZemtIMkpv?=
 =?utf-8?B?QTBDdDBETDZiWHlvWUVJYUY1a3NvMk1NYXpIWTdKR1crNkJ0UnpyaTRWQi9U?=
 =?utf-8?B?SlJVSHZRRWUzbUNRVlRIQnA3N0NVdFRQbjBRcGRpQjlINEUyRkk0Z1JvdXpM?=
 =?utf-8?B?OFpGN3hUTDlMMDdrMVZhR1VsTVRsSE4zdHRaUlBBdFM4VjcycEZvOHdzSC9J?=
 =?utf-8?B?RzdPbTgzUkNwcW1LcFB6QlpNKzVNMEhSUTZiNWF2RnFZYnZjekdzR2g1bktm?=
 =?utf-8?B?cHpuSmZFVk9PVEtDOWo1N25GWW8vZURYaldtYlZ1cTVNY00xbXNJTjRyc0RG?=
 =?utf-8?B?bktDRFpaUGhRTXBsc1hmOGZPUTRnV24wWXFLZCtibEIrQ2tHWXBOKzFDVlFI?=
 =?utf-8?B?NWNzMjI1dmJGa1BQNjhHNlBsc2tjanRlSU56em1CdmJKZmdzN3I2aXEyV29x?=
 =?utf-8?B?eUh4d09vZTlwQTJKV3dlaVZPZmlWNE5WQWlVSVNZcjUyaXR5ZTRKeWxQS3Ju?=
 =?utf-8?B?OFZ0MnY5MVBTS0liNFZaVGhDNmFDNExEanJHTEJVUy9MODN3VkFQbjNBMFcv?=
 =?utf-8?B?dXNxK3plNmNJckNxbEN4VGxIV1d4OTgwVTQ1N1NCUTlycG52Q0kvUEZMZjda?=
 =?utf-8?B?aVdBUG5SM0RGTDFaMG1wbisvTjZaK2UvZ3NhY3FndFdqOWZGc3IzZFBxcXIv?=
 =?utf-8?B?VmJIOGNHUHlzTDF6RS91aXRnL0NRbWtCdVF5aHBVanN5Ym9HbjdUZFFlNEUz?=
 =?utf-8?B?QndDSnR3cmJFQXQyRUE3M2xBQTdaUFMvRCtHaU9veTU5bjFHOGsrdmRkT1Ur?=
 =?utf-8?B?d1VzTk9CSXhwVmhFVC9NMDhSbHIrK2xMS3ZtRnZKSWp5VzhkL1Q2dGpxMnM2?=
 =?utf-8?B?VGRpZDdBcDVWcXZiMUV5QTRKRFVRTTladTl1Zk5QMlpDZDYwMmphMDB5OVJD?=
 =?utf-8?B?K0NUM0I2Qk4vZGQ0S056TnhhR1g3SlI4Zi9qNDlEdFJCWm1ZNk5WQVljTzFq?=
 =?utf-8?B?UVgvTDJvN1JwWFN6S0ptTHZxSHlhaEUxK3MzeHBuVnZJb1NSVTdHVXZ5Z01M?=
 =?utf-8?B?U3g2bng5ZFVqbitLa24wa3QzUmMyWS92UmdCOFlWbEZKZ0YrOTdjN05SR05Z?=
 =?utf-8?B?SHdhd1I0aEhWTldhcjVpZmdoaDhGN2pnczkzRDJEQWlpSjBZMGFQTTZ5eDVR?=
 =?utf-8?B?U3RYTWlsR0RZQU5RaENObzA5YjhEdkg5ZmdNb0dJNVdVT3BOb2ROVDE4Vzd3?=
 =?utf-8?B?d2ljOTRDU3lqamNnUG9tRHp1SEJHdkJkbUUyQk4yZWw2eUxjQmo4eW5Hbnd5?=
 =?utf-8?B?Y2xIZWE3bHYzTExOZXRYSEZzenVsOW81djRHOVFlZXdjRHZSUmlOaUtNRzlK?=
 =?utf-8?B?QndwUGVUQnN5NVRUVG95UHhQb0lrcXdacC9pd04xckd6WXhIeW9rK1RJWWFv?=
 =?utf-8?B?MFRTOVlWMExIZFNyeWRCOTl5WG9rVEgrb0t4UkdyTEZZUTRLK25VMXRmWWhP?=
 =?utf-8?B?MFhBV2JUNnplNWRrTG1GUFpPaTlET3oxczl1RlQwTy9IajhocDhpa0ZMbzhm?=
 =?utf-8?B?ZDFuT1RjbmtVTzdFbWdEdXpoa1Qwd0Q4R1RweUdrYXFEbW51dWp1c29mZEJl?=
 =?utf-8?Q?747ss2Dnkb251sxpx4K6iXef4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9ce051-2cfe-4bef-75e6-08dad87a7aa4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:42:58.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Zk7Y4Lf47rUEd63rzWq6RcBEe/Z3rIFTZoQ8DNiCMcywmFnx6Cbr0TgDh7/Qb7PRyC6GXAVExM7se1mLlFA1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070152
X-Proofpoint-GUID: 72BCRmspH458bTpTjfGa7Sh5nfHPBRWG
X-Proofpoint-ORIG-GUID: 72BCRmspH458bTpTjfGa7Sh5nfHPBRWG
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 17:40, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 06, 2022 at 09:59:08PM -0800, Ian Rogers escreveu:
>> Currently the 'MetricExpr' json value is passed from the json
>> file to the pmu-events.c. This change introduces an expression
>> tree that is parsed into. The parsing is done largely by using
>> operator overloading and python's 'eval' function. Two advantages
>> in doing this are:
> John, what tag can I get from you? 😄
> 
> - Arnaldo
>   
Sure,
Reviewed-by: John Garry <john.g.garry@oracle.com>
