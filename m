Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91A4623807
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiKJAMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiKJAL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:11:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0B465EC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:11:58 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9NxNvG024370;
        Thu, 10 Nov 2022 00:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=L3vhyLNJvtoZSYZedgznVAdH9iu0NNxIfd6P82aQ++0=;
 b=q653ASyaL1nZc9xybcviJ6ePHHnpKkRASzmr/nxjAPNudRJCFrAfljNfiRSPAE2q6kh3
 m/JZ5iq+PhnH7QojYNktH2lK9AtvopMMo61mAgQgnvTS+69nvS5ljCxBKyVujKNPXVDo
 xhw3j+cpuEAbLxUJl8ry7RNwlM4s46lxqpmRl1FsIrITK78dcdR9xRdc6jRIp9HEuVp0
 FQbwqNO2aiFh4PdDmHBgYXdB7U8o6YZbrjTbZL3Q664KqtHaI2AKNQ14l8W4yJK0/rer
 mYKmhJuktbkxmj9jqkGhgSfkp2e8DT2QpbG6ak074Do0zFpiNLlIlIwQcVujp2yvgp48 UA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krpbt817s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 00:11:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9MTdPO000362;
        Thu, 10 Nov 2022 00:11:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsfr27v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 00:11:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4i4C3gYtO5VMgdQKjWqhKKIYqVEuYIBIH0a/hQ46Laq/sH1zfZdiOIDq1ARe5sGcYyBjITVRm2QUFix5h2urcSrs0kP4NRtUBESj3Up0IRuEqmPxIxwj/+OSg/a0xPOkpbBT5u+1buJ0i4y7G9V5XGVhyCSTW1aJzJ6c4bLZIFsSgSopqVU4euVgPPrvTv+lNeCjcAgIy1jVRdKZ70QsFgTfR+aN/ldjz+Ot/8hjCSb8pHUFkhFIGLFtXvih6eS4udMJF8tNqHFn4r1Q/H/eKu3lckFuZ9AAM5ccy7b8Mv06H6HHoMfEYfxmRM0OM07VPf7lMua9XAhtPWPJC6DUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3vhyLNJvtoZSYZedgznVAdH9iu0NNxIfd6P82aQ++0=;
 b=F3wk7ATwK/KGaBGIkgp52ATTsuXjk1DHGg0/RgqHknOVZuZUJ0E8FhpwJ1haJQj+M794xYC8q+/vxAcBwRX4nHm6NG295TTfgzdVO03F887TIt7P1MYcEQlbi5TaMyLHgsc7LIjCYq6KNOsIaWdeXFeQe38RVSmvPADGjxYxspmqEpdONdek7FaXMqFsl7wLHEV9JhlZUCMTiHCyzszXTojWE1IFExtRk8gPo8wJ3O+Oj8bDqifDA9EBjG1vGAGJ5Kroz1q1h1E96Zj25PeuCtttn5IxnIe1BxNSoJS8bvU3G3jlhsMhk+Vbx73lpqgxsYlE9x/79fSw3Ba5hNVhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3vhyLNJvtoZSYZedgznVAdH9iu0NNxIfd6P82aQ++0=;
 b=uxCcJHyKsW2rbkCkWiaHkZiNv1eex+zqloG8Dor9zLWArxq2As2FmeZej8bNqC3X8B4fH0vXWGsjCWKmYrqLpiZCXSMCgh2tFPY1lT+JsjPsDAJ/WyMKGjsIux01rLm8GNCNNVnh9/A0+8S6UT/uFvuy3xEVCG4uu6bHnRh9aS4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB4837.namprd10.prod.outlook.com (2603:10b6:408:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 00:11:23 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 00:11:23 +0000
Message-ID: <e5bd10cd-eb86-3a70-a0fe-21ba49b5ab25@oracle.com>
Date:   Wed, 9 Nov 2022 16:11:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/3] mm,hugetlb: use folio fields in second tail page
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <3818cc9a-9999-d064-d778-9c94c5911e6@google.com>
 <5bd8a365-e2c5-a721-1257-81ec4ae0c626@oracle.com>
 <3934b34-ae2f-2119-9a68-33e51e909795@google.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <3934b34-ae2f-2119-9a68-33e51e909795@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BN0PR10MB4837:EE_
X-MS-Office365-Filtering-Correlation-Id: 672f638b-fef9-4e83-42a9-08dac2b019a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhskZAyNFpwMyi1bk8zZXPXvUceUtGR0ozgAoFWxVnmsF7QSNjWjLCIZ7WP5pSpIwjY4qY5mloLuRrHWs9yduTE+alwk3U+JqBiIwi5qKAbaxmqWiXm8hcWXkqmLFZNoWfEcX3GR0ZmI59AyEK4NJgJZbSHI7O9VcR+hz/dgcCsOQuGTXYfZDrRcPrpBHCK0Fk6EJX109LQOAA3g2625X6Hc0z/SVe90D3SevrK0eCWsnwKp+cKPO2/UfFH4T3Imr4865+7gDrJbQZ4AkpWD+95P20xMx2m9+VPRYSGDoZPJqRjw6DsCvcL4yXHdCya2qltvza2TmQzKWu5k5NjURb3t+D38OkeP6s6f5iE6eFcFwzC2zAkBw1EvS2dFfKeIY5VqrSjMCv1mSuvMAQtxZhKyIJOkf0+vxSXMtqwtdIBvIcAR54uJMZYBYq7FklIghTd66NQ3EdyOMDrataRm7IgkpIGO4xC5YU/Ql0d/UgemAOB3pqPmuFnEe2Ttws3lx2pQDl4fp6YmdmwRc6xdvuYz0LNG/tJz0mHY7QHJ+j1pp+PA2aBaLKPA9yZvkj3Vrfu16Jsaob+EHKXbcNZPxahEcxVraA26jwAAByioJfrUjS3WhJGPAGOScjA93iNisRfBnnO/tji3KmQUl9F0QQtDB/4o3lgTOwxJjUyHnBOKBZ1Oq9isU/LiEGPm5HrjK5hq9BjFsq0LmF7+UgkXBy3IxfFrwSlCYlTUdy/ry2U97j7W4vFMJF4EJ4KAYs8y1w0lc6qmLjUSBy9hyGRZdkIf1II1syq/Mp7L637q3vc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(83380400001)(38100700002)(6512007)(2616005)(4326008)(6916009)(186003)(66556008)(26005)(5660300002)(53546011)(8936002)(7416002)(2906002)(6506007)(478600001)(6486002)(6666004)(8676002)(66946007)(54906003)(66476007)(44832011)(41300700001)(316002)(31686004)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJ4NEhsV1M2bm1TUi9IaDRQRmhmenNONDNpRklPeDlkM25NaXowYThZaVdU?=
 =?utf-8?B?WDJDYngrWkQxSE5kYlA0ZFMrMWsrbWF0R0hwaWF4cW1NWlZhc1JYWTFuQndU?=
 =?utf-8?B?Rkp3TmxGcGhwa1EzWjRRcEZRWktPWDlzVGZoTEdyU0szWFkwUEo2WUpLbmZ3?=
 =?utf-8?B?a3Ftc3pxY3pjVVI0UlJkbDRhRFhaYjc5WXZxdkNkUHBTVmhJN1FUaElYdEd3?=
 =?utf-8?B?byswVy93aFZYMjloOXNrSWpRa3c3Q3FXZkV4aGhXdW81N1lPZWRBZXA2ZDla?=
 =?utf-8?B?M1V3N21waVF1bGx2cmwvK1JFTE5sVkc3TWI3UjRoOHBhZTBoOWdXeTRUNDIw?=
 =?utf-8?B?SkQyUFlXRmd5b2dVVWhsSGxkRHpETzBWKzFmSjB0NFZBOTFpRnQrVTJVdDlZ?=
 =?utf-8?B?bGlnTGIxczJlU3diRi8rL0Vsckc1RmZjU0xWUTBUVy85UnlRbkduS3VWcVpJ?=
 =?utf-8?B?am4wMzk0ME9zSmhTelkwQnFVT0tpVTRyNDZWT0cxUUsyamxFWFRIK2NzeTNM?=
 =?utf-8?B?OHNPSVBnaHhpVFlWNEN4Z1NFb2VJREE5RCt3eU0wQzZxdVYreGUwcExIdlho?=
 =?utf-8?B?NEJ6WnJXMVRkUkFzOTMySFFWN2RwNTlCVlRCWW5JdzcyTnhTeUFLbGw0UEtq?=
 =?utf-8?B?VHpBUTNnb0IrMXF0b0l5SE1zQTRoZE9tUUFIUENXZUxKUE5XU29JWU81NVl6?=
 =?utf-8?B?OUI3MzRBYVgzYy9rdnpGc3VMOGZ6Z2hzVHVLaXpkUjBpcStFeDRJeEFyd1Vm?=
 =?utf-8?B?LzVBcmd1YzVxT1RkbVlkRHNmSVpRck9TcUMwUWx3b21acGlacm1STVMwTWE5?=
 =?utf-8?B?YzlwWnRnclVzRUg1Y1RmMDFGK0hmYUQzQ1NxZG4wYXBsalFpVjVXTnhlV3Yy?=
 =?utf-8?B?UW44RjlWTWNRQTNzRTRranlBcWtvRWlIa1NqWFdqRXRoM21EMzVhY010Mnk5?=
 =?utf-8?B?czZXMDAxSnFpWGhOVFF0RzB0eDVBakZSMWhzN1ExbUNIcm43ZSt1YXVCSUh0?=
 =?utf-8?B?MUxTeHFZaE9MZlhFa0xHUlo0bWY5L3JrK0xxRWpvTnVrRXVIdEhqLzAxK05J?=
 =?utf-8?B?dGhYOFNWUlZpRFM5VDR3bXVDOFhwQVFtWjZ0N1hGSXd3UGJmNVpVTXRFZ0NW?=
 =?utf-8?B?TS9MZkd2L2ZYNzFWM09iR1ladGl4ZnJhQUQrYUZhWkNQbkwzY2pzQUF0WDZq?=
 =?utf-8?B?U3M4WGJUUk93NXowWjd3WkIxbVB2enkzR2ZaTncvWUhQZWNKQzlRUkJydzBs?=
 =?utf-8?B?RUF5ckFNckVPRzFBd2xZaWJRY3VUS001QkN4bVcycWJHTW1qV2RQWGlkTW1m?=
 =?utf-8?B?QmxraDA4aFRHNmUzRENnbk5BK1RZK2ZqenZscmtWbXMwM0hXYUY2UFlqS2V6?=
 =?utf-8?B?V1hsVnFXMjVGQU5zYWo3T3M1eWtUTGFmRWdxN01MZmxKWFNCVVpEcXlHdHh3?=
 =?utf-8?B?ZGozNUIySnRXUjAreFVTNVVyV01qSmFXS1FhRmZOeFU1UlRBWUczSHhVRWkx?=
 =?utf-8?B?N2NTWExWQW5kMUpQbksybVgrUCtmbzRiNUh5VUpvQkU1MStpZ0VmZjRqU2Ev?=
 =?utf-8?B?M2FjZGwvUXdwQ0RZT1lqY1E0UDA1bnBPbkFBbnpXWGY4c1duSm9FVlk1d0N6?=
 =?utf-8?B?Rk5QZnNKUXBBMTNHMUhvRWlnZzV4aFpsSkg5WXMza2xTdktpQ1lMNkc4Qzdj?=
 =?utf-8?B?U0V0d3JYMmtwSzlyYWluK29NL1hDL1Q3TXpQcFdnRjVmUkhQSzVVdkVzYjA0?=
 =?utf-8?B?bXkrRjExMFJHdGJJUEpsM0p3K2tiaGpiUEdMenJhbVQxUmJsVDBXcStnZGFv?=
 =?utf-8?B?VGY3eEVKdGhKbzJsdFJ6OWxDVHMvNU5mZklIRDE3Z2c1aFBJUFBYMGdoUVZW?=
 =?utf-8?B?YVZHUDBVendoMnRIOGNpa0FJeURsVzJINHlFK1BSWkhFVGlnek5takRYR3ZQ?=
 =?utf-8?B?a3drL3Z4VWxWdGhjQTNvMFptaDZFK0N0SWhTWjhpMnlwaFViRVJLQzMwRHlQ?=
 =?utf-8?B?d2U0bVJJWmRtNi9TMmE4a2x3R3pqWUtqcUdGK2tUV0xmdnFZQ28vNy9tK0cz?=
 =?utf-8?B?aHppZjhVSHZUSWhZRC95QXFmWDU4NXpobWFkVy9aRFlxem5mZG1HY3RvNStF?=
 =?utf-8?B?ZlFCbVNRNDljblJrS3dkamhtV3VIRnpwVVNWSmcyM0UzU0J1WEIxNVlqaytY?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672f638b-fef9-4e83-42a9-08dac2b019a4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 00:11:23.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6BO/F+UJ9fGpo8MF1DF/HaXTXUuSqj7BLb1DQnwPhFBFP3KALIzvTPQ/E7Qlmpc6phpN2kDymvMDhZg7y0IAa+EhrRA57fr0yign84MCNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090181
X-Proofpoint-GUID: adsQygpsUqanpMpvoNbSViSsQtW7pPBj
X-Proofpoint-ORIG-GUID: adsQygpsUqanpMpvoNbSViSsQtW7pPBj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/22 9:29 PM, Hugh Dickins wrote:
> On Thu, 3 Nov 2022, Sidhartha Kumar wrote:
>> On 11/2/22 6:48 PM, Hugh Dickins wrote:
> ...
>>> Undo "mm: add private field of first tail to struct page and struct
>>> folio"'s recent addition of private_1 to the folio tail: instead add
>>> hugetlb_subpool, hugetlb_cgroup, hugetlb_cgroup_rsvd, hugetlb_hwpoison
>>> to a second tail page of the folio: THP has long been using several
>>> fields of that tail, so make better use of it for hugetlb too.
>>> This is not how a generic folio should be declared in future,
>>> but it is an effective transitional way to make use of it.
> ...
>>> @@ -260,13 +267,16 @@ struct page {
>>>     *    to find how many references there are to this folio.
>>>     * @memcg_data: Memory Control Group data.
>>>     * @_flags_1: For large folios, additional page flags.
>>> - * @__head: Points to the folio.  Do not use.
>>> + * @_head_1: Points to the folio.  Do not use.
>> Changes to my original patch set look good, this seems to be a cleaner
>> implementation.
> Thanks a lot, Sidhartha, I'm glad to hear that it works for you too.
>
> I expect that it will be done differently in the future: maybe generalizing
> the additional fields to further "private"s as you did, letting different
> subsystems accessorize them differently; or removing them completely from
> struct folio, letting subsystems declare their own struct folio containers.
> I don't know how that will end up, but this for now seems good and clear.
>
>> Should the usage of page_1 and page_2 also be documented here?
> You must have something interesting in mind to document about them,
> but I cannot guess what! They are for field alignment, not for use.
> (page_2 to help when/if someone needs to add another pageful.)
>
> Do you mean that I should copy the
> 	/* private: the union with struct page is transitional */
> comment from above the original "struct page page;" line I copied?
> Or give all three of them a few underscores to imply not for use?

I think the underscores with a comment about not for use could be helpful.

Thanks,

Sidhartha Kumar

> Thanks,
> Hugh
