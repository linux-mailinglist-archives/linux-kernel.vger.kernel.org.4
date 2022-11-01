Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B7D614F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKAQnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiKAQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:43:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4F63DB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:43:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1F4Z4S029081;
        Tue, 1 Nov 2022 16:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qBp/o+lV+oR1HcdoKAW0cnNZkqjUo9/A/ckFl2fET2E=;
 b=2bQxdLD42OrBjEmfcjvQZdDyV2ynBj1Om5ekrVbtBHdS9HnEiGjSLsBiGvQa6QIAod/d
 P6uJQ5zQ/PNXNtginPvADpIiKP+PL5iSgog/0pFTUvN/HCAA1ragGdflCDeplrq02bYU
 Ad/DvWVUCZZYGD8NdLbgNwNaGQg6LaErHRRELM9fc5NPNNPe9xWjwBgRQKoRY4EXwFb1
 8Ty4lI3n8H/a+rl2GF3f2igDK6Ck9nb2X5NmOtfUfvu+ETysftbuPvf/a/jgqyBM4p+B
 /11oSazLUzsrqom8MbvKE7uxwbqi7wS/xD0fTxOE6uL2p5hALeD+94W7efxRjjnOBsPZ zQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts17a72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 16:43:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1Fbp19002882;
        Tue, 1 Nov 2022 16:43:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmap84y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 16:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsI/bVJeor6uALORiF5DRkDcsySzumoZi6NAPUKUbZ8cOOKQ6qhTil4cVgZKEzEH6MVoqQT39Pvqu5TfWbu25/djwFzypjECybM3LVYoFsRBToYy2cvbeeANGgJW54H6TsCs3pkZ3UsCxp4Km3D20KXvnZ6QVad2lVGebAaQ9uvDYE1W72ezt+jFJr/F061QnUDiC70qQFaeF7nIDgskP4AIpyvYmDjYT/7/8deHo9Z47jpJwREt2n5d0TkWKND/amfXsLGAlGSB72WpVnjwLjcy365S51P6DvAvb5EJ4W3M82MJoQfI3wPPD9uGkG4Sfpud0Q3meYghU4kij7XXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBp/o+lV+oR1HcdoKAW0cnNZkqjUo9/A/ckFl2fET2E=;
 b=YI+D/U6L7yrFqviGi6HuZ01BM1oI62nXOH0DcyXeIphj/eL8rBPbCw+qZw3NQQyrjGb9H26KGToyKQt9pbKT2LD9ZC0/lMP8oKlp7jz0nBo7P+q6Vm93zNhQFj77cXPwnbVC3lNjdQQGVWGWXqav36peou0Rq61qujzmtFiGT98wOTQ06e9rv6HqgiXC5Qt3vA1meFR/OKVuhofHwPPWxic57YGCXwPGuH5ST9O96t54pN1phlvlg0PoZJrS0D+itXHq+msux/axgyhG5lTGf2vykuhN4+vXf2m1ukJeGcigWX+erSeWSyeKDgdpeAgYmlFn1NYXQCSXIC9R2wc6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBp/o+lV+oR1HcdoKAW0cnNZkqjUo9/A/ckFl2fET2E=;
 b=iJ0aOKVZrdQfgueRcd2ntZxDaNt4puFdH//JihRtaRbotsS2GxuWftSkwDppPla34sLwiedPTNxaEKKZdvHP9F9iAngcdt5jPAXDXOI87a0xyr806DE2mGTNA7YRX+I+53GhKfvyGqG25Y2YT5Q/mrXDJhGlY4RydqMWTfKgS58=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6157.namprd10.prod.outlook.com (2603:10b6:8:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 16:43:13 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 16:43:13 +0000
Message-ID: <139d4fe5-c77e-f90a-2b7e-ac2798f4e118@oracle.com>
Date:   Tue, 1 Nov 2022 09:43:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/9] mm/hugetlb_cgroup: convert set_hugetlb_cgroup*() to
 folios
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
 <20221014031303.231740-4-sidhartha.kumar@oracle.com>
 <Y1/5+R7H4yub8epq@monkey>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y1/5+R7H4yub8epq@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:74::42) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 010c6c7a-1795-4c06-bb47-08dabc282b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9yMXAp8N5cf+DbAPf66+v4EuLcVXKFziTnjaOffSqIJJqR7VfgBVhH3hJH+M8R+Vi0y0f4ZXrTV415OdwW2l5pNhQri3OnCCq4qra5xJi53e2qh/Ttvn168kT1WYocd9nP7HFtgEodox2czU6N7zE/sJs17ZTA7aZZ2nmSBBV9A8t40TKP2EKaaSXkWxH/27a/hDyOjA3NNEflwArFOqGyxP5Tz0IoC4gYPdEt2sqNgoNxqEJxu6R2ScRlkvrVRldLFlhjSjwK9vnBGCHzvZNJaJ5oMXIkciOEuV//FjMPzRfy4EQ64c7ITb2YFQPYPJ+yRT5IJJbabAbm821kYIjF5pDuTN7zcgERzhBFhpFCgP28adthLXBAp/DmRheyFjNCUw8Z/LDQ11Ts5o5xeNb8VM0DnFXjg08q3T2I2hBYSrZ5ICjGxqVxOs7/pzj/G2EprGxEtaTZBtQHnR5QqpcuKoZBeAxWVzcTzRly8pBtkxfhn8pXZXPyfvEzWjQPB0NhFup/XLBe8bmR7kGxKSwLkfHeb/JY2vbke6NfO17F85tSRL10H/FU/kL1lQvQlS7AryFyUTfHpCjOuFYFjov5OUHtz2SuH9GgTU7TZtqPrdLqhVGDIeYilMXXifg+0vsE+wgVIo+ZPHWHi6O5xz3InHGnXmqog/vl/k6Skhhd4vaGsSeu5fSknxFo7oM1dofqV3WKyajj+FYiu83B77KFO5uiPdHzKO86J819EemfveUTHwLZEFhbQ03KcqT03sDJgPwzwXLndH/CEqbLh/qYTcs8IPCCAbbgkIL/4gns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(186003)(6512007)(26005)(36756003)(8676002)(2616005)(53546011)(6506007)(6486002)(37006003)(316002)(6636002)(38100700002)(478600001)(31696002)(86362001)(83380400001)(44832011)(2906002)(66556008)(66476007)(8936002)(66946007)(41300700001)(5660300002)(4326008)(31686004)(6862004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Z6SnNjUzI1QkQ4LzRCS0RkZ2xZTXpSM0xqMTJlZXdZSWtPK0duaWloenNn?=
 =?utf-8?B?cGt1ZERzOXU5eS9ZVmZOQmlrcUQ2WmNmeGRNelVsUjN3VkJhMnJUUjc5SjdM?=
 =?utf-8?B?OEMyTmxhNHJSb1M1SW9kYnBpUnRQY0RkeW8rRi8yNmpqcHk1aTRiL3FCSGdu?=
 =?utf-8?B?MlBLQmVDd3UyRXJrdlhtYUxyQ3VYSHJNZDRWeE50Q2hhNTZSZFFuSmRybFJO?=
 =?utf-8?B?U0ZxaUVFWFM2MFpNWlhnanJ5L3V1TDRBSlNRbmpDc0FXWkxjTlBiQ1o3dnhy?=
 =?utf-8?B?Y25VRVJxUkI5emg1S292Nkl2TUJtMklUWFBmYUs5NUdaS0hsMU9PQU9QZm9P?=
 =?utf-8?B?cTVCM3F0T0xXVEU5UFpzbklTV2lDTWo0VzliZHVFMzZ3enFRMWZiNXBkNnBV?=
 =?utf-8?B?ZjhldmNUTzhtRC9VdmtlYVdMbEZjZGFxZWFEZFMwb0dpUkdSRFdIQjl3STdI?=
 =?utf-8?B?cFZUSzhhRmNsWXRudHBlS0FZZFNsRU8zMEc2YkNJSktWREF3a0ZCT2VZTjNR?=
 =?utf-8?B?Q1pMK0ZqMjY2LzY1ZmFLTFBIUWZBTGFPbXQyOGtMNllraU1JeTdSZnpVWlRO?=
 =?utf-8?B?bEh4SGRSUTJ3ak1NRlJtTGJiRldVNWpyMTZ4bkp3UDRPWTNxcm4rWEwwdW9n?=
 =?utf-8?B?Tnp2emZJS2lDc0JzOE1YVVJkaFJVbERsbytEVkJSQ05GNmJ3djNaL1hVQVpq?=
 =?utf-8?B?REZhKytERHJjVWRnUlpyVHoxSmZxbGJMb3RZbmR2SFgxZlFHR0dEaEtNSjJX?=
 =?utf-8?B?elc4RWFVWE9zQXg3ZGkwUG5PakgwNHh3czFaNjZZQloyV3dGUXFVZllxMnRL?=
 =?utf-8?B?V3Z2Y0F0eDRlaFdLSktDTXJHcnpGNEcvMCtDNFdsR2FSakl4TEVLUG9pL3FH?=
 =?utf-8?B?V1gvNzU2OEN5ZTI1ZW5aU3FMTWhUY09YUWpjWWVNSDlBYllhRStzNVlMcDFP?=
 =?utf-8?B?N00zdG5md25PSTJNekZQWjlpRm10Y0liSTB1TmdCN0NIYmFGV3JZdlNDanBL?=
 =?utf-8?B?TXoxckRYQTVIbDVlaGx6RHNvNlRLRnZIaCswbFRQZm9vYmF6c25IeW1DMXJl?=
 =?utf-8?B?N2MyNXpNb2FmMTBSU3YxbDVPSFNyTFVNVTg0YUpFRzFSYWF0SjZDMExUd2Zs?=
 =?utf-8?B?RkxVdHorb051bGVQb0JNUGE3WDBsb1Q5NVVnQ1dVYU1pY2E3aTlGRzRxVWND?=
 =?utf-8?B?ejhpc3FCS1MzaWNGTXlPOUlrSjJWU1poZGlqYklkcExVWCtSM01BNHRzUVht?=
 =?utf-8?B?UlhIYmxuRkp2Z081c25jK0UzdkdkUUdHN3JaY25NWFArWjBOa0ZTclhucUZP?=
 =?utf-8?B?SCtLUW5ldEhVMWpwYzVxMmJhckkxQ1NnN3dzaW5SUitXRE40YmsvWEZhVWFK?=
 =?utf-8?B?bmVJMmRkVVVJYXV6OWhkb0FRZnV1dEVRMTRWeUtKd3hLRWhHc1hGd2g3R053?=
 =?utf-8?B?L3dpTitjcWNEVGtBbkQyc1N3VENMSGFvbEhpTzdoS0QwQVZRTE5EKzZjNk12?=
 =?utf-8?B?bHZTUXY5RmJBVUp3MUR3SEwrVGZEeGVpS0NBVUc2N3pXRnV2ajhkNGFtWWhy?=
 =?utf-8?B?ZjB6WmNqbWFPRXRmU281MjA4ZXJZeGhXa1dUeVhGQXBIbVYzWDZ2bUU5Q3pL?=
 =?utf-8?B?YldjbVV0bUpEelBaWEtEaTZQaW5MTjRLbGJxMWYrZGhrbUJ3VWFOQ1lML29T?=
 =?utf-8?B?MWM0RGJPQTdmcG9ZcVRVdnZHVTgrMGtwY2JvdUtXQXBzSHdrNmRaenpKTDVB?=
 =?utf-8?B?MGhTU0FXdEpLcjVpbTJJcWo5bTdZbUYzalBXcVpoNEJYNHZiUEdDQ3NiU0RB?=
 =?utf-8?B?a2lIb1FWSUZNV3RoTzF3aUswNHpFdnU1MGJRTklwTHIrcWVDQ0tXOVNseGRJ?=
 =?utf-8?B?cDR3Rmw3MWtLM3pGZHVMQk5qbHgzNkp6UGxxNThPVE1GOWJqK2xrNXhnOUZR?=
 =?utf-8?B?NnFrSzByZnJPSTQxZk80TDVDOHFWN3MySmNYUFVJY0pLTXVBYnIydGdDdW9q?=
 =?utf-8?B?RTdmTzNsVFVrdHhZeVJ3YlcrS2FxczdSYkthK3pvcWMveW9icjFEYUEyVzhl?=
 =?utf-8?B?djVTYm9sZEFXSjU2b1BXT2J1QkJxd2R6ZHV2ZzlpWm83em8yb0lSVStWQUtw?=
 =?utf-8?B?azFBUTZRcExsc1FTdjFINVd0UkthMzMwT2gxRTZBUFN2RDh4Syt3QnVEU2Iv?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010c6c7a-1795-4c06-bb47-08dabc282b21
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:43:13.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdGMF8GUzfguGT9HqvfBu0GR5pJyVPgmqFb2DxbNvKRUOg5vY+5zAbJSpLln3UCQKsVNrTTaue9J76J6FvrfodxF7ALkRM2XfYUxV7nwecg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_07,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010124
X-Proofpoint-GUID: 6CaycCfcyUX03gAEZsyeTaEo97A6YxS4
X-Proofpoint-ORIG-GUID: 6CaycCfcyUX03gAEZsyeTaEo97A6YxS4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/22 9:38 AM, Mike Kravetz wrote:
> On 10/13/22 20:12, Sidhartha Kumar wrote:
>> Allows __prep_new_huge_page() to operate on a folio by converting
>> set_hugetlb_cgroup*() to take in a folio.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1758,19 +1758,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
>>   	h->nr_huge_pages_node[nid]++;
>>   }
>>   
>> -static void __prep_new_huge_page(struct hstate *h, struct page *page)
>> +static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
>>   {
>> -	hugetlb_vmemmap_optimize(h, page);
>> -	INIT_LIST_HEAD(&page->lru);
>> -	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>> -	hugetlb_set_page_subpool(page, NULL);
>> -	set_hugetlb_cgroup(page, NULL);
>> -	set_hugetlb_cgroup_rsvd(page, NULL);
>> +	hugetlb_vmemmap_optimize(h, &folio->page);
>> +	INIT_LIST_HEAD(&folio->lru);
>> +	folio->_folio_dtor = HUGETLB_PAGE_DTOR;
> Seems like we should have a routine 'set_folio_dtor' that has the same
> functionality as set_compound_page_dtor.  Here, we loose the check for a
> valid DTOR value (although not terribly valuable).

I agree with the need for a 'set_folio_dtor' routine, I'll send out a 
patch for that as well.

> Not required for this patch, but something to note.
>
>> +	hugetlb_set_folio_subpool(folio, NULL);
>> +	set_hugetlb_cgroup(folio, NULL);
>> +	set_hugetlb_cgroup_rsvd(folio, NULL);
>>   }
>>   
>>   static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>>   {
>> -	__prep_new_huge_page(h, page);
>> +	struct folio *folio = page_folio(page);
>> +
>> +	__prep_new_hugetlb_folio(h, folio);
>>   	spin_lock_irq(&hugetlb_lock);
>>   	__prep_account_new_huge_page(h, nid);
>>   	spin_unlock_irq(&hugetlb_lock);
>> @@ -2731,8 +2733,10 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>   					struct list_head *list)
>>   {
>>   	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>> -	int nid = page_to_nid(old_page);
>> +	struct folio *old_folio = page_folio(old_page);
>> +	int nid = folio_nid(old_folio);
>>   	struct page *new_page;
>> +	struct folio *new_folio;
>>   	int ret = 0;
>>   
>>   	/*
>> @@ -2745,16 +2749,17 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>   	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
>>   	if (!new_page)
>>   		return -ENOMEM;
>> -	__prep_new_huge_page(h, new_page);
>> +	new_folio = page_folio(new_page);
>> +	__prep_new_hugetlb_folio(h, new_folio);
>>   
>>   retry:
>>   	spin_lock_irq(&hugetlb_lock);
>> -	if (!PageHuge(old_page)) {
>> +	if (!folio_test_hugetlb(old_folio)) {
>>   		/*
>>   		 * Freed from under us. Drop new_page too.
>>   		 */
>>   		goto free_new;
>> -	} else if (page_count(old_page)) {
>> +	} else if (folio_ref_count(old_folio)) {
>>   		/*
>>   		 * Someone has grabbed the page, try to isolate it here.
>>   		 * Fail with -EBUSY if not possible.
>> @@ -2763,7 +2768,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>   		ret = isolate_hugetlb(old_page, list);
>>   		spin_lock_irq(&hugetlb_lock);
>>   		goto free_new;
>> -	} else if (!HPageFreed(old_page)) {
>> +	} else if (!folio_test_hugetlb(old_folio)) {
> Should that be?
> 	} else if (!folio_test_hugetlb_freed(old_folio)) {

Yes good catch, I will fix in a v2.

Thanks,
Sidhartha Kumar

>

