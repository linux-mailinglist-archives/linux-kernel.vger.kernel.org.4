Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE664D606
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 06:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLOFKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 00:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLOFKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 00:10:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C67C2A271
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 21:10:00 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF2NeeR006971;
        Thu, 15 Dec 2022 05:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oEwYtMKDimt2ISHRitHvShJugNcXu7ILukZqBTqnX5I=;
 b=S5pMz/npa4lgzAKNj0OGIbI9/3DNyGkUQeXYUExk9Qm14CE1lbkFGjIo3Rtf3+mSGW61
 U5Zr0aaiLLr8H18rmBUsG7dDEZjI/ogP8/FUSdFcZbiBOh9jJGuHjKxDDQC5kRVbEFUa
 IZ59o2i3GA4DAV3trMpBFrWIBod0KgLhBbg9QqiVVmarkzEHWpG1z70aFfI016rymHCs
 0vIYb+lgGyStlZ+qtIWtlnxYgkviI1xJqY/L2GNCfYbs90tfnXy4wBPmnFHKr2goGS22
 kcstR95v8LAlxwJ8qj8TISMVuPqvaDbuwFQ2wma+j4zzHFga2waLsFkdM0Mrz7mOHTSm Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeuc35s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 05:09:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BF47aJE003969;
        Thu, 15 Dec 2022 05:09:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyex3wpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 05:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQmr1ydfHNY/wZLL63GFvpfIYK67sq3tVGtnUPL+QJ7Bw19W4ohFH4U/uoU1X6Kbje/1Llm/PpolyVBNS0+fq0TtHPqfdmQIx2O/TzzyW6IzOOpXqhKHO9PzkMtLLBYHku4fcsjpOBCFkvxGfMNVzNFp8DODz73HuaS3aOsgw0jEz2Gl+5aaGj3CYzbAFumiOGJUDP3X5o2Ove5CqskSZfoX93fIV5c3DHsREcR/XxqUgB0xNejHNyGt88fN8H7k66pWcw/hr/vnyeqQHoWXuiAbIQ7dgQ5x5sb+gOLzCG2/zxvSondLJ2z8QB7j73t9nMfA/4OXz+k0e+nODGqd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEwYtMKDimt2ISHRitHvShJugNcXu7ILukZqBTqnX5I=;
 b=cn+MYYDzu6x8IYEag1sI43aFW/BiHN2b00sEiap6oj7OyaQ+W5PBpfrhBCJ23sBpilJGJ/tm68Zk4+bGB+GVZuTGPjc/2PN0FmMQZZ63O+xcAu7EeEcQU+ZNTV4VApl1dDXM7uGYTlOVQtLXcRdFN21p3osXySX0sWmuMvHH6xBy3jWAFCI9ATTy880MfT/IBmLen2kOHsJ3TjZ+9PX091mdTSWFx2nuz03XXnQTubSF8GhOmb0L4PWroYtI3fJ8/kBKDO6Pm4vQmVzVHmecYP8a3l5B4bv7gcEBx7hFoWsQRKcqZ/6qDIK3RTM4I3jvAjY9zrDj8smBKDkpxGMpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEwYtMKDimt2ISHRitHvShJugNcXu7ILukZqBTqnX5I=;
 b=i5oej3VU1rwx6CY1yzS4/CYDFTSU8UP1ynp+TL5cLx5CFhxdL9M4GT1/4ni5pUdx/EDJV5Q1oM29y5bIqzNA73TwsfRQaH8riO0Dk+sijv/5M4kMAwDVZh+/h2U0EvlZi3fMp7G2NCwGPV4kG6Q9ecC9gKfVJt91U59px4IYIPY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO1PR10MB4577.namprd10.prod.outlook.com (2603:10b6:303:97::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 05:09:46 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%5]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 05:09:45 +0000
Message-ID: <cda1b5ca-a03e-e545-d206-30d74ed33a3d@oracle.com>
Date:   Wed, 14 Dec 2022 21:09:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: move folio_set_compound_order() to
 mm/internal.h
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>
References: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
 <0B650D64-1F64-4695-9365-CF695029C50C@linux.dev>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <0B650D64-1F64-4695-9365-CF695029C50C@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO1PR10MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: 6977345f-6e41-4702-d495-08dade5a9523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7kYZgJUHPN0e93/h8ELBF+UYcy9tv6KlZk49WW9sEBVuKnGlDr5J6awMuv6rQl2pWucBePj3T+NW0TSyUotWmUgQo+OhgWr8sviUYeFimtOsaxrGuu0x0A4NCP8iFsgkXRGCHjftKqWu3SROFzg0tJdHgNnNBtNXMa7wDM+qqp3fsZ8tPzaXw3+AKIVzr8HlSB1OdnVe2iSSaJUB/J0MnIPylXZWTwHYP+OKwcSv5bYhN7uUTcCxcacJ3PZ3egSEYD5YeZ8aJrZqsFzWO1gpUZt3PLEJF1fAihpcJxpWfo/b2oE98jzyOeZTTVNpzaEPHRNonVwKwfkDtmlcRgriPV8sQ55typd0cycbuNAhQUuro7r024ILkrF34mPYRzMEI/2pdcCyfjPYG4j5R1N647fFvgzA5PGCtPmx6btoQmoL0txWNeDGCx+U2eLwY8ETrrIVPQjj4icv376rqVc1BZxXI2CVWIBBWe2WzYJlbMtT4PCZ4jURoGnvkfy9mx8bw8yHbX8RK7qzr7aLXajh8jns/qZPH3PRh+22vEVBPqXc+4qBCftxEKLVtG8X/1cwP3HKWmE8Gydv+f63K29uBplbwSKWmY3wmDPIFSsdL30+7EkOCAD5XhG7VzmMpHip2sDam1oJz3fh7zsFzv8wUXZyH+ily39iuNTWEZn5L+vIwy1JZnTj9PFoEtf49JCyYCNQkfXGFNYP2DQTcOWdGDU1E3Z97SkKEciatGqPp9O9TiQgeWkFnkcMZIBFfh/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(478600001)(31686004)(6486002)(26005)(966005)(186003)(6506007)(53546011)(6512007)(316002)(5660300002)(2906002)(83380400001)(54906003)(36756003)(66946007)(66476007)(4326008)(8676002)(2616005)(6916009)(66556008)(86362001)(44832011)(31696002)(8936002)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUwzdjROOXM1UmdqbVJ4amcyVzZKd3ZlMnF2NVJVbkVJVE8vckM4NFZOQkZz?=
 =?utf-8?B?WUlaOFZwY043L0lHL0ZEbkNnK1lkd3dRQlc5SjdBNTVVcGpjMjRQNjFyeDRL?=
 =?utf-8?B?QW82VVZtd1pRdlZGMEN5ZDhFRm9zZXRtdE9FWkZXVk1MNDJzMnlMWjMrUVM4?=
 =?utf-8?B?RXd0ZGZsVnpXSnROenJXZnBPU3ZSRU5mb3h2c0hUQjVuVENMeDhpYytoQlBk?=
 =?utf-8?B?elFaeXZCbWlvWjFsU2JZck5ZK29VWmRaNmJ6bEpPb3ZjeWhVSzhuOTZhUmRn?=
 =?utf-8?B?N2p3Nm5GT0E2UHZjRDlDUWJLbERhL2g0NjVpVGVaT1UwbUZMQTYyei9DWnps?=
 =?utf-8?B?MmhoUUYwQVJod0JYdzViZFBZM2JjbC91Z3d1SXpYT1lqNlR2VFRQVVBSTWxY?=
 =?utf-8?B?VFFjVFNad0gwYVlwU01LN0dzb0pUL1RUL1kraFc3OFlUU2dqSGNENzlYb3dw?=
 =?utf-8?B?c2JxZUQwSmNjbmNzYkd1OU9CbW1vSGRvait0aUo5eFgzRDMzSGh6dTg5Q01i?=
 =?utf-8?B?SE1LaUVjZGlENkpqY3pIcVBsVVNaYTRXRUhINSsvbDZ0WFA4TXBQSHA0d1k0?=
 =?utf-8?B?QlJTNnlCTndkZjdJWEtIM1NlNjhObXlGWmNMK0Nwb1VKbmQzZWp3N1N2UUdO?=
 =?utf-8?B?cnFnTFFWK2pDZm1wOCthaXFCQndZMVRwS0tlcEZ6dlNWbi9CM0JMTk4zYlEw?=
 =?utf-8?B?WExQY3VjTXNEc0wyOER6MCtad290VGNxR3MrdXhZMmtDYlZ4aWd4eWxPS0N2?=
 =?utf-8?B?SjBOcWNWcTNtV1BaV1pNNmlkMno4UEM5WWhjRFVUWTZ0cm9lQ21rZmZQdGYv?=
 =?utf-8?B?UHdNSjZtSExyYmRKa0dxVmxnQkc2WkFYVm9wNEwySWhZTVhEdDRPbVkvQTUy?=
 =?utf-8?B?YkNQVFdINFFxeEh0cldjT0pSTmpwSGd5ekZnM2J3dW1kZ01VZnRSWXpORDlx?=
 =?utf-8?B?ckxJd1ZDbW1JeTFuUXBxUlpIMkkvSDQ4WHJmQmxPWjBiVUdjeGlzN3VKT0V4?=
 =?utf-8?B?ZlEyTVZ6VGM4bkh2ZjhFNjMxVThQK20xMnVrL25HL1dXdWQ1WDlKdzJ4d1N1?=
 =?utf-8?B?eTdNVFZLZGtZNmtZbVdZd3FWekxJZTZ2VVd4WGhhRkQwNlFwZElrQXJpN0dX?=
 =?utf-8?B?c2N5ejZuVHlDc04yMG9YeE5PRndHYVFBUEFjYUNnYmtTeW9KTGdxQy9ZZHFi?=
 =?utf-8?B?bnhNTG9ON3R5dXpVbC9tN0wxKy9KVnBWOXlaaTN0QTBQWkJDNDVpNDZXUEpU?=
 =?utf-8?B?djljZ1YremQ5QTl1VmdqNXRBZ2tCbVFFNHZ3MXoxV2xkQm0vOVVsY0toWDZi?=
 =?utf-8?B?UWRMWDRPOStkcCtvZTJYd09IdVc2TlNuVHRNdXZKc3dLaUlkQ0JmNDlJVUY4?=
 =?utf-8?B?aDByS205Unc1Vjh0dWJ1TmhFQituRmZRSHZadS9vbHRzV0R0aWx4aFQrTFAv?=
 =?utf-8?B?UHlpbDJYaVhRMmtJbWVIaW9FWFEzZTFnUDRVL3NsamoyU0dQNi9vVk0rTGZW?=
 =?utf-8?B?RGNiY0NpbVJIYmRmV1cwUHVFOFBGTWFYZnAwNldMSjNBTUMva2N0cGE1NUdE?=
 =?utf-8?B?L1RXaUNxUWpMODdNeGxqa0EzSlJVZnhMQkpqZzkzSEEwOWp0QlA0anVDSWh3?=
 =?utf-8?B?ZnEwTUUvUWNJdFFpd3prYlZzZEp1NXY3RXpaMDUrcGNUUkgweUlwMmY0a3I3?=
 =?utf-8?B?bU9aVktjTE51amQ5TWQ2OWUzb3R4aFY1NndvMUdSVDhSUkFBSENXWDFOeWJy?=
 =?utf-8?B?b3JJcjhpbHI4SVVUbWpGeVBtdHNxMzk0TE1vRGt0UWtDOU9kV3J5N1RWdm5a?=
 =?utf-8?B?eXdQWHBKYllkOGJxNlBWdDlNbGlvaTF1bDNyZkx3d1hlWUJhYVRMTVl3eHlE?=
 =?utf-8?B?cVgyeU1hVmFjUVgvN0trS2ljVDFVZDZWQ2tvSVJVd1BLdUhmZ3puZ0JuOEox?=
 =?utf-8?B?YnlMbXdtMzBRaFNxNm1CRjlzTlVMZXN1Q2NJcXJuNlVDNEcvMUVnVFN0Y25W?=
 =?utf-8?B?ZjRuWWNjSHJpc0RUbUU2ZmFEZWdFdHlnWFZ6eE5iMDRrdlVlOTJjRHVPcWZv?=
 =?utf-8?B?czlKckxxdGFZK1Z5RDVjbHZ6SXBuWENDVWZPM2hTMnFyUFJLUmhwVnQ5UjFR?=
 =?utf-8?B?R0cyZmFHUmJSZ000NDNISTJ6aXdtS0hyZnovQWNab0tzS0lSRXd0a0VMd3Bw?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6977345f-6e41-4702-d495-08dade5a9523
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 05:09:45.9090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+jXPBBmdn2qcE3Z/9j5JUxQOnbyb/MNNsS8GMInsYybcbq+WSvtO8gKVhPpgBr4ljpGBUgkLH8WEJkb5c1C+EorCSdHQ5dmvfraDYn/wS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_02,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150038
X-Proofpoint-ORIG-GUID: xQmarWAnti3irWrWTyHXMaRg3XCR1MLY
X-Proofpoint-GUID: xQmarWAnti3irWrWTyHXMaRg3XCR1MLY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/22 7:44 PM, Muchun Song wrote:
> 
> 
>> On Dec 14, 2022, at 05:20, Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
>>
>> folio_set_compound_order() is moved to an mm-internal location so external
>> folio users cannot misuse this function. Change the name of the function
>> to folio_set_order() and use WARN_ON_ONCE() rather than BUG_ON. Also,
>> handle the case if a non-large folio is passed and add clarifying comments
>> to the function.
>>
>> Link: https://lore.kernel.org/lkml/20221207223731.32784-1-sidhartha.kumar@oracle.com/T/
>> Fixes: 9fd330582b2f ("mm: add folio dtor and order setter functions")
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Suggested-by: Muchun Song <songmuchun@bytedance.com>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Hi Muchun,

Does this review include the change from

+	if (!folio_test_large(folio)) {
+		WARN_ON_ONCE(order);
+		return;
+	}

to

if (WARN_ON_ONCE(!folio_test_large(folio)))
		return;

discussed in in this thread?

Thanks,
Sidhartha Kumar
> 
> Thanks.

