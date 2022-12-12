Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA564A79A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiLLSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiLLSv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:51:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3FE28
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:51:22 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwcjI004041;
        Mon, 12 Dec 2022 18:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IsyE56L6wVYSSYf+J5BhHPuhtu0x1gYPi6WL2FUoAaw=;
 b=HRmFSsjDDMtE5R63RRgBVtc8qjjHB2iEzQ6tcnMIync3R4ZLJCnRf4PYJHsWQErSuIEg
 KCKF0eBQfp4jQvcQ5tHqgTUb6QbKnD8y08YDoUHjhzSATWXKTCS3gob9d0vCbFyIsWXj
 YVvsK7lbpQZ52KFYPe2+FdHJF5Ma8I5k7ZRW8xCR6iYIjcMjJkKC06ugemeY9wBQugo4
 4UHN6uV00YxhhUJimgz7jUEDKZDa0uKuNGcfXCE22/kuf5F09qpt183FIRNtWBCEiH1V
 V0GOSToXucZpiPwofHZ8qlFYsuP5p3MmQez4PhOgZirZyhXSp24nH59pdttNKfvyZY87 4w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcgw2bm1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 18:50:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCIXTbZ033179;
        Mon, 12 Dec 2022 18:50:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjb0dd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 18:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRHEXet097FeRIdBR54KNNMEVKadrEeUVeDGHREOZ1PTf5IM7OaDCbbnHs8Som8ZuUJH2SToUVqDEayHjY94TcBYzpxQR8amJPsQptXLtiB1OjlrxA0zWP6iMLqcXZuTPjclCqJCC9JWz2U+y7LKftTE6K39w5vxTXf0hscuoaOCBzHVMd1LODu1jtEpGSEvTLVrQZhVE7MCIvEwt+GnRLMR9TExxCydoTj+L03WnFh6KkuchdsLbNgcarZ1xG3m70HwIlJAG6FUILZItGXGL9eDECV8mShEjISS5t+WkxZ3PokuDAU43wE8JKHYMZYB5nTQHhbEk5zCVgRN/wbS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsyE56L6wVYSSYf+J5BhHPuhtu0x1gYPi6WL2FUoAaw=;
 b=bBcYsPxhrOITaCOsQ3Nkabfiy5OMXZQAny0HSJrQwXJGJOP9Gbdq2hgGlcs0KAwt8YDIZI5zE7Rt1X+jgmhJN3j1jYgJxxUj1Eo1i1M5s1iz3fIzRGoTic8nPRF4SZNPo/9JnvI7bsXiC36lXH+cB5E7tkIaiWYYIiWpoAipZbg2jFXAfLRYduOMG5pPtxHu8uzWthkoWtwHD1lQsJmI6PJiI0kOUuYh1UWNjA5pDqaFs9ruFlrCD6x1dTQtiMij7R7PJS+cKT8fcmvlLX4vabORQJkC6KqCyNmduoqIybkJP6Mo1/rgiXYTWERX1MLQ8b/eK6PNeJ69+KeeCUXfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsyE56L6wVYSSYf+J5BhHPuhtu0x1gYPi6WL2FUoAaw=;
 b=YZcqaOe+k9COAKnNUU5l+dtwIR0JHjg4eatYqEuPRD+KtvLjGQnqLDgbxRk24q4EkBsQ09J+zkmGmOA5TWBDiEt3UWcF71uThanvA0OEKt+9C6GMVnTcKWhNhLWm8DMV0qF4FXnajOmLgPSLOM1RaY2yOjwUEKIorMzBsuDYrdQ=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 18:50:47 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%4]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 18:50:47 +0000
Message-ID: <62ca3baf-4220-e69f-2218-3b4a157e88f0@oracle.com>
Date:   Mon, 12 Dec 2022 10:50:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
 <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev> <Y5ALigw0kUO/B3z2@monkey>
 <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev>
 <a6776188-056e-3a36-4f92-d83b3bfcee38@redhat.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <a6776188-056e-3a36-4f92-d83b3bfcee38@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cbebf8-3d28-49e1-570f-08dadc71c7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHnoXd8Y/bWWfWHeOSlWutAapkYL37tdvd+KxTDXHjH3kErCv9DsCE1BwdblVIbiykiV3L41jsMCG3Ci9rNJcuNVN6RIFoeY5ExMANRt1cIek8aABU3WFVOxOYwWJNSzlVbk6YFxhWNrWSd+kwPbBKsmkWZNBAi1crEaMsO0tN4RPTFLC1c1wOOBIls0vNcTfGhKO9WimknuhmwWImuHLK9Da6bSj0J1zaXBmzmaYS1AenGJOxm0tTiWgtxZkus1VHpG6oRl9y+Wxnv7+4qd9Ieo+ppJmJpKOgADB6Vo8W6knPQ2i5OuDOZcwxB2mGqCbFpb7rToVv75c7INPERrgBRbV9Zw6Fp4uakJZGo+hNQnLEC1ocAGDdQZlJYRYT/Wctg1EnlMAeKECSNDaklTbNJcnqgzKgKKU6oSx9uyM42TGqsjDT+g7IZWdaDtQXAsxd+S75lBJIGZBl2xIPnna9qN9CiIxlEFgRGSsxf42GXSSIXqGaWiNKXs2DOd56Uwp9OniBrRGvEtIO0AeZMhQkCR2QvAbg9NMF+KwyeXPufqnyxPnkW0o2l9/NZdzQEV0S8xOh8xNPU5w0sqICKz/pY6mHoxmnhOT9ysY0lnMcI2XCNft+NgvP4HlUAbs9wLKa2vEKcSHmGKDTLCi5are21M0CQ4oP0//SD78t8sTegJ4spePyuMsHY7Rto9oopAG/duvFYTLlDH6iiRSmXJxi4aY1KXsvdCPYvGgukNPFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199015)(83380400001)(6486002)(2616005)(6666004)(45080400002)(26005)(6512007)(6506007)(478600001)(53546011)(31696002)(38100700002)(86362001)(36756003)(31686004)(186003)(5660300002)(8676002)(4326008)(41300700001)(66556008)(66946007)(66476007)(8936002)(54906003)(110136005)(2906002)(44832011)(6636002)(7416002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SS9pRzhaK05nYzZ0SGE1VEo2SlNRRTFGZy8rUjJyelRSQjhST29EMDhmeWlJ?=
 =?utf-8?B?LzhKTnBhSU1OMEk2blkycGlNMVBNb3NLTlZHbnBja2x3KzZwUzRJSzd3KzBt?=
 =?utf-8?B?Vi9UNzJPYkF5QVkxRmFkNWVJaHQ0MjdWamJtTWZydVlGMmptS1Y3alBvaStN?=
 =?utf-8?B?NnFtQnA1TUZLL3FmZ2dPWVNFVWhhYTc1S202cmUzTDU2Rnc4QStKTzFId1JS?=
 =?utf-8?B?WldqQWYwdGhhdTFvRUxjOE1uUndFalhhUHgrTEhqa3o4OFRaanNqLy8yenM4?=
 =?utf-8?B?UGpnUjJrWEJUYmFKN3RtMDZEYlQyMGY3Z0x0dDJvVHprSmFYQWl5ZlBodnJW?=
 =?utf-8?B?L3FIc2QyeXhOb1cxWlIwamxJOCtkVFlJb1dxTGJob1lrakttNTNhY1pQYWtm?=
 =?utf-8?B?dENkajBMVnFlSGU1OVJIS3JnU3hDbmo1STFmSjZOY0x4djVndjZZRkhtMTVU?=
 =?utf-8?B?RmF2MVFiRVBpRHFwaWxhMzFCQzNFbllxTVNyNGJ2Tm90U2orOURJcEZDSTl0?=
 =?utf-8?B?WmxzeFNIU2dkaWtiL2lvdkNDSWZLZEh3cUQyR2JiKzkxWnM0cGk4cUtaNUtB?=
 =?utf-8?B?ekJqWVE3SGVjbzNqK1JzNGhrbXFLaXh3WFhZQUhRUUlzS3B4OXBkS2xEcEM1?=
 =?utf-8?B?cUYxc3gwazlha3ZHYUVWNk1HdWRxYUJaYkpmMHhRZXFWakFvb25QNEZadmNq?=
 =?utf-8?B?amhkRVZ4SzVpanVQK1NsZGd2aG9qMGx5cHEvVjU0VGh5c0dnN0M1NTFDOXI1?=
 =?utf-8?B?YWh1WjJtLy9WQ0N5VVNJWmFDalM5OVBqTFkvK3Y0aDRjUFJ6c0JGVUNrMnRE?=
 =?utf-8?B?cjNuN3VYc29xZDdoTnd5SFNCV1Q4QVRrcEtKdmhjRVRYZXgzcGxSVWFKZ1E2?=
 =?utf-8?B?aEFObVZKWTNrNWw2NGJhM2JnRE5odnRRbmF1QnplRjZ2Nk1wemJ5Ly9pTHg3?=
 =?utf-8?B?UzVLWkhhZWQ4cTNNRzhOc2V2Yk9McFZBMlJkZWdzZWRZVGZDVlJyenJRcDc1?=
 =?utf-8?B?WFRsRm0vNjBvRXU3cXJlTC9YWDZSSUxrQVJ1VG95WVM3NE1lZllCYjNrZEt4?=
 =?utf-8?B?K0VDak5UZkxUZlhKS0MrWmdCd2pOMHJxZlBXS2tDY1c4eGZHdFlGNThkUVVF?=
 =?utf-8?B?ZnYyK0J4RW93U0ZCVytsaWF4MFh4Z1lQOGNTejQxTGc1c1BQNTdOZ3h6ZjJX?=
 =?utf-8?B?VHdIYmx0OEw4SGYrMnFUN01BdkIrNjc5YXB3M2dzclk2VXNzM3BuZCt1alNG?=
 =?utf-8?B?c0tDZG5Wa0tkbENrVG45amkyYlVLRW1wcVkwakpja2JQQXpOVENjUmp3UkZn?=
 =?utf-8?B?V1pjTFE4SXFSdHEyd0p6WDdBKzNZK2ZxOW44RXU4ZkZUMjJzeFB5MzRER2Qr?=
 =?utf-8?B?UkorVWNPZjJxejhCVHRpSnNNRnd0alJZNFpUaWlVdnk4WjFmNmU1dW5waXFN?=
 =?utf-8?B?MWFubWlSQkpySS9qSVg4VkY0K2ttK1lDWjQwai9jY21jOW14U2hOVEMySXo2?=
 =?utf-8?B?ZzJrdGVndFhxV3NwOXN5RDd0eVY4dmdqdnBvS004dEN3Z3NDMXE1K1ZBUWY2?=
 =?utf-8?B?N1hDWmlWWFB4WEtEaU9idWdKcFdDTyt4VUF0dE9ubEE5emNQOW5tZkhLQ3Er?=
 =?utf-8?B?ME1tRU5ENVRsOTdIcWJiRXR5OW9HNEhnT2pWdXA4L0gxd01kWjJJeExJRW1U?=
 =?utf-8?B?ZXJieWIyMnZreGV1MHdwZGVhNnZXY1BJVlhVbnYwWGNaWkNxb1VRa0JDQzFF?=
 =?utf-8?B?S2d2N21SVU0xOE91UHFnRHprcVYrd1NaUlhzNDg1OXBkLzJIbmxHRVg3ZWor?=
 =?utf-8?B?YnNZdFFjZUNLOXUyUHhEcWlQVEczallvQ0hocHVDMlNXNVY1UTVmem5zRzVn?=
 =?utf-8?B?S2dmdnZNcC9YcWlUZHZTdzEzWk9mK3c5UXhyMVFYMW9oUy9HN0RSUmJ5NmF0?=
 =?utf-8?B?bnBrM0dyR0dxUTNiRDlVeUUreU85dTRRbk9uT1FhYWpwbUtuSDY3eHVQeVpl?=
 =?utf-8?B?RW9YakRlM25rS3J5Yk4zeThpSEYxL21WK2NuY3RCREpBN0xUVVJDRUpDZWd4?=
 =?utf-8?B?Q20rQ0JMZ3RrbVNCbkNwNU1UeGt4bTRVUVlKS3lRQ3hMZ0xhN0o5R2lrN3Aw?=
 =?utf-8?B?QXZNL2Q3b040VDVPL3Z6Vkdjc0U4U2ROcThCWkErRTZWLzNSalVZRmdiaHZS?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cbebf8-3d28-49e1-570f-08dadc71c7ec
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 18:50:47.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nSPlxcJ21c7r7Cc+mWkqwqdsHCwJCGl8kQ/UluY37GjEqbWQIs1fGSqFGUj1Fj3wNJDsvvAAcwa4WYMANQiDsvIia9eazLYON6K752cevU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120169
X-Proofpoint-ORIG-GUID: FIzTwr-f66FbCKi8LdMjh-R-12yn6Rcs
X-Proofpoint-GUID: FIzTwr-f66FbCKi8LdMjh-R-12yn6Rcs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/22 10:34 AM, David Hildenbrand wrote:
> On 07.12.22 05:11, Muchun Song wrote:
>>
>>
>>> On Dec 7, 2022, at 11:42, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> On 12/07/22 11:34, Muchun Song wrote:
>>>>
>>>>
>>>>> On Nov 30, 2022, at 06:50, Sidhartha Kumar 
>>>>> <sidhartha.kumar@oracle.com> wrote:
>>>>>
>>>>> Add folio equivalents for set_compound_order() and 
>>>>> set_compound_page_dtor().
>>>>>
>>>>> Also remove extra new-lines introduced by mm/hugetlb: convert
>>>>> move_hugetlb_state() to folios and mm/hugetlb_cgroup: convert
>>>>> hugetlb_cgroup_uncharge_page() to folios.
>>>>>
>>>>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>> Suggested-by: Muchun Song <songmuchun@bytedance.com>
>>>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>>>> ---
>>>>> include/linux/mm.h | 16 ++++++++++++++++
>>>>> mm/hugetlb.c       |  4 +---
>>>>> 2 files changed, 17 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index a48c5ad16a5e..2bdef8a5298a 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -972,6 +972,13 @@ static inline void 
>>>>> set_compound_page_dtor(struct page *page,
>>>>> page[1].compound_dtor = compound_dtor;
>>>>> }
>>>>>
>>>>> +static inline void folio_set_compound_dtor(struct folio *folio,
>>>>> + enum compound_dtor_id compound_dtor)
>>>>> +{
>>>>> + VM_BUG_ON_FOLIO(compound_dtor >= NR_COMPOUND_DTORS, folio);
>>>>> + folio->_folio_dtor = compound_dtor;
>>>>> +}
>>>>> +
>>>>> void destroy_large_folio(struct folio *folio);
>>>>>
>>>>> static inline int head_compound_pincount(struct page *head)
>>>>> @@ -987,6 +994,15 @@ static inline void set_compound_order(struct 
>>>>> page *page, unsigned int order)
>>>>> #endif
>>>>> }
>>>>>
>>>>> +static inline void folio_set_compound_order(struct folio *folio,
>>>>> + unsigned int order)
>>>>> +{
>>>>> + folio->_folio_order = order;
>>>>> +#ifdef CONFIG_64BIT
>>>>> + folio->_folio_nr_pages = order ? 1U << order : 0;
>>>>
>>>> It seems that you think the user could pass 0 to order. However,
>>>> ->_folio_nr_pages and ->_folio_order fields are invalid for order-0 
>>>> pages.
>>>> You should not touch it. So this should be:
>>>>
>>>> static inline void folio_set_compound_order(struct folio *folio,
>>>>      unsigned int order)
>>>> {
>>>>     if (!folio_test_large(folio))
>>>>         return;
>>>>
>>>>     folio->_folio_order = order;
>>>> #ifdef CONFIG_64BIT
>>>>     folio->_folio_nr_pages = 1U << order;
>>>> #endif
>>>> }
>>>
>>> I believe this was changed to accommodate the code in
>>> __destroy_compound_gigantic_page().  It is used in a subsequent patch.
>>> Here is the v6.0 version of the routine.
>>
>> Thanks for your clarification.
>>
>>>
>>> static void __destroy_compound_gigantic_page(struct page *page,
>>> unsigned int order, bool demote)
>>> {
>>>     int i;
>>>     int nr_pages = 1 << order;
>>>     struct page *p = page + 1;
>>>
>>>     atomic_set(compound_mapcount_ptr(page), 0);
>>>     atomic_set(compound_pincount_ptr(page), 0);
>>>
>>>     for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>>>         p->mapping = NULL;
>>>         clear_compound_head(p);
>>>         if (!demote)
>>>             set_page_refcounted(p);
>>>     }
>>>
>>>     set_compound_order(page, 0);
>>> #ifdef CONFIG_64BIT
>>>     page[1].compound_nr = 0;
>>> #endif
>>>     __ClearPageHead(page);
>>> }
>>>
>>>
>>> Might have been better to change this set_compound_order call to
>>> folio_set_compound_order in this patch.
>>>
>>
>> Agree. It has confused me a lot. I suggest changing the code to the
>> followings. The folio_test_large() check is still to avoid unexpected
>> users for OOB.
>>
>> static inline void folio_set_compound_order(struct folio *folio,
>>                         unsigned int order)
>> {
>>     VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>     // or
>>     // if (!folio_test_large(folio))
>>     //     return;
>>
>>     folio->_folio_order = order;
>> #ifdef CONFIG_64BIT
>>     folio->_folio_nr_pages = order ? 1U << order : 0;
>> #endif
>> }
>>
>> Thanks.
> 
> On mm-stable, dynamically allocating gigantic pages gives me:
> 
> [   23.625105] page:00000000ae27bd2a refcount:1 mapcount:0 
> mapping:0000000000000000 index:0x0 pfn:0x1800
> [   23.635117] flags: 0x17fffc00000000(node=0|zone=2|lastcpupid=0x1ffff)
> [   23.641969] raw: 0017fffc00000000 ffffa4edc489bb58 fffff784c6000048 
> 0000000000000000
> [   23.650141] raw: 0000000000000000 0000000000000000 00000001ffffffff 
> 0000000000000000
> [   23.657907] page dumped because: 
> VM_BUG_ON_FOLIO(!folio_test_large(folio))


static bool __prep_compound_gigantic_folio(struct folio *folio,
					unsigned int order, bool demote)
{
	int i, j;
	int nr_pages = 1 << order;
	struct page *p;

	/* we rely on prep_new_hugetlb_folio to set the destructor */
	folio_set_compound_order(folio, order);
	__folio_clear_reserved(folio);
	__folio_set_head(folio);

The problem looks to be because the head flag is set after the call to 
folio_set_compound_order() which looks for PG_head. I will test the fix 
of moving folio_set_compound_order() to after the __folio_set_head() call.

> [   23.663955] ------------[ cut here ]------------
> [   23.667680] kernel BUG at include/linux/mm.h:1030!
> [   23.673378] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   23.681610] CPU: 3 PID: 1220 Comm: bash Not tainted 6.1.0-rc4+ #13
> [   23.690281] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> 1.16.0-1.fc36 04/01/2014
> [   23.699837] RIP: 0010:__prep_compound_gigantic_folio+0x115/0x120
> [   23.706587] Code: c7 44 24 5c 00 00 00 00 5b 44 89 d0 5d 41 5c 41 5d 
> 41 5e c3 cc cc cc cc 48 83 e8 09
> [   23.725954] RSP: 0018:ffffa4edc489bc90 EFLAGS: 00010296
> [   23.731001] RAX: 000000000000003e RBX: ffffffffae39a720 RCX: 
> 0000000000000000
> [   23.736065] RDX: 0000000000000001 RSI: ffffffffad522c25 RDI: 
> 00000000ffffffff
> [   23.740866] RBP: 0000000000040000 R08: 0000000000000000 R09: 
> ffffa4edc489bb58
> [   23.745385] R10: 0000000000000003 R11: ffff926d7ff4b028 R12: 
> fffff784c6000000
> [   23.749464] R13: 0000000000040000 R14: fffff784c6000000 R15: 
> ffff9266039fb900
> [   23.753176] FS:  00007f69a9703740(0000) GS:ffff92696f8c0000(0000) 
> knlGS:0000000000000000
> [   23.758299] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   23.761275] CR2: 0000556789080640 CR3: 0000000105568005 CR4: 
> 0000000000770ee0
> [   23.764929] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [   23.768572] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [   23.772221] PKRU: 55555554
> [   23.773696] Call Trace:
> [   23.776170]  <TASK>
> [   23.777258]  alloc_fresh_hugetlb_folio+0x14b/0x220
> [   23.779406]  alloc_pool_huge_page+0x7c/0x110
> [   23.781273]  __nr_hugepages_store_common+0x191/0x400
> [   23.783369]  ? __mod_memcg_lruvec_state+0x93/0x110
> [   23.785343]  ? __mod_lruvec_page_state+0xa6/0x1a0
> [   23.787223]  ? _copy_from_iter+0x8c/0x540
> [   23.788788]  ? __kmem_cache_alloc_node+0x13b/0x2a0
> [   23.790577]  ? kernfs_fop_write_iter+0x174/0x1f0
> [   23.792313]  nr_hugepages_store+0x57/0x70
> [   23.793754]  kernfs_fop_write_iter+0x11b/0x1f0
> [   23.795337]  vfs_write+0x1e1/0x3a0
> [   23.796531]  ksys_write+0x53/0xd0
> [   23.797690]  do_syscall_64+0x37/0x90
> [   23.798947]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   23.800602] RIP: 0033:0x7f69a9501977
> [   23.801798] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 
> 1f 00 f3 0f 1e fa 64 8b 04 25 14
> [   23.807322] RSP: 002b:00007ffce87f3338 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000001
> [   23.809460] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
> 00007f69a9501977
> [   23.811485] RDX: 0000000000000002 RSI: 00005652a970e5e0 RDI: 
> 0000000000000001
> [   23.813443] RBP: 00005652a970e5e0 R08: 0000000000000000 R09: 
> 0000000000000073
> [   23.815385] R10: 0000000000001000 R11: 0000000000000246 R12: 
> 0000000000000002
> [   23.817289] R13: 00007f69a95f9780 R14: 0000000000000002 R15: 
> 00007f69a95f49e0
> [   23.819176]  </TASK>
> [   23.819792] Modules linked in: intel_rapl_msr intel_rapl_common 
> intel_uncore_frequency_common isst_ir
> [   23.829056] ---[ end trace 0000000000000000 ]---
> [   23.830413] RIP: 0010:__prep_compound_gigantic_folio+0x115/0x120
> [   23.832390] Code: c7 44 24 5c 00 00 00 00 5b 44 89 d0 5d 41 5c 41 5d 
> 41 5e c3 cc cc cc cc 48 83 e8 09
> [   23.836787] RSP: 0018:ffffa4edc489bc90 EFLAGS: 00010296
> [   23.838083] RAX: 000000000000003e RBX: ffffffffae39a720 RCX: 
> 0000000000000000
> [   23.839764] RDX: 0000000000000001 RSI: ffffffffad522c25 RDI: 
> 00000000ffffffff
> [   23.841456] RBP: 0000000000040000 R08: 0000000000000000 R09: 
> ffffa4edc489bb58
> [   23.843150] R10: 0000000000000003 R11: ffff926d7ff4b028 R12: 
> fffff784c6000000
> [   23.844836] R13: 0000000000040000 R14: fffff784c6000000 R15: 
> ffff9266039fb900
> [   23.846521] FS:  00007f69a9703740(0000) GS:ffff92696f8c0000(0000) 
> knlGS:0000000000000000
> [   23.848417] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   23.849797] CR2: 0000556789080640 CR3: 0000000105568005 CR4: 
> 0000000000770ee0
> [   23.851491] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [   23.853181] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [   23.854861] PKRU: 55555554
> 
> 
> Something's broken.
> 

