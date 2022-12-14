Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B078664C3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 07:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbiLNGip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 01:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLNGin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 01:38:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD4826ACF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 22:38:41 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLNnvn032323;
        Wed, 14 Dec 2022 06:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=D1KIyuGeObn6JGiB5UJkc5d2p9UhW7EGhCMvOWCsag8=;
 b=z6R8CEa/fuW9fhlvbr3T7XIs0i0LnNnIwXBBQkC2YPFRvQfuB5yDqQA/Joc6M0OG5M08
 sElXq1Jr01lij2Y1po6L8jkySEzao8Tor02jF+SdGjVggHyPWVhWrqQMLZF4UbHxZJR9
 80EV6d1ZCbaZZc0uF4XqlZr4+BNfg/nA+pN3DWAr0m3X8FSutdqd7g69c5VS/8KlzBj2
 ycvZmvZkdyffESMx7uNCrbjCxGNzkBipxvXGfGotXfZ/cSHCMluNDfhxsVOm8a0m888e
 vWjSyyaokcetcvQEMX5jH+ZjXGf1a5XJOQN/S7ZkxLdGn+Am+D6kO6HzRlcpFlU1ODLD XQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyews70p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 06:38:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BE5wFDF037243;
        Wed, 14 Dec 2022 06:38:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyekre0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 06:38:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1qMXQAHQ2VxAgkDdMvo1t77gf0AkWvJ8r3u2vA6J+y1DcXdAlp3C/H8aqsbYv3JXgy+9R+QNX28xP3DSh8AaaYg/KVjBYAIhLRDv1Va51Lz5uLgGkF4uBkLHiejEm5kIQ1fyiEvU0W/frUWmhTxVbN0E5tNLMhsOtavIeayffNgcLdeGFU6Ego+hXBVV3vTnSizeWhYLE9KbW0tzHV4hCvXxI5pQzpPNymqcD+krc+z0LUZhucw0KF11af79CIzRnraFxUlt5T4I0D96KZ1A8aKo6gZT5QMX9R/KCtbCU4XUgYDEWHSSv9NNTFWRkwOQsIAnxFfY6i4KvIFs+BZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1KIyuGeObn6JGiB5UJkc5d2p9UhW7EGhCMvOWCsag8=;
 b=dyd8cFjS7yoC81s3XkWDbJE6EwIdhxJ7zPVZ3wzcFfcG4gKsoZLXeX8ggnwOeoWo4iai1pSeBP0qCkmIeCf4TKJnX4tzifDTQBPnnThZDVC/g8KKNqVHLIdUnQFCukgFbpnGNgEId+ym8Im97VyztnDLbDu6PfZM7WPGzyk4IXoOBYbi2b3Mlavjs7bQ7/lcSHKXLokIaUjWyEldKmRynC1E555XlWmAgdbHrw4iRY9aAynXppy1eewXg0RDoKWctXs3KxUw71qQV4LXb7Z0z99W80Htl5LR3SaLopwmUsFivSp5dlyQudMCAGVzGcwQ6p8kqKs7Bb/huNlnYeKvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1KIyuGeObn6JGiB5UJkc5d2p9UhW7EGhCMvOWCsag8=;
 b=CZl+MSi5zcjtZT5Mbpdc2qGY6f2CblwBK08DXYPwV1J2vlKcysXPOl0HmtnBXrPdIaInK9HPCJf2HRQaIL5345JWOpVGd9+33PN5Q7flMr3vbsezv8atMlv0N6J78dLwhoSlBa/JWjKQ6Qe0tsWmN1vHVGEZ/i3j30RG7hLZ10I=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 06:38:19 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 06:38:19 +0000
Message-ID: <fb2fb91c-1e54-a4ee-bf69-299e9114ae1e@oracle.com>
Date:   Tue, 13 Dec 2022 22:38:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC V2] mm: add the zero case to page[1].compound_nr in
 set_compound_order
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, gerald.schaefer@linux.ibm.com
References: <20221213234505.173468-1-npache@redhat.com>
 <Y5kPKpNp5qCnZEWy@monkey>
 <CAA1CXcB653kDtF90oWUgVA3TDUrJHac-WPe1HdsQtRwtN5B3gA@mail.gmail.com>
 <CAA1CXcDK=bpAbmkwyssja9d7eA3iEtNQ2aNaQo4DkdjV3YvOVA@mail.gmail.com>
 <Y5kgoTVteXm0QFgT@monkey>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y5kgoTVteXm0QFgT@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::9) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2f4338-c3e8-4e42-0e11-08dadd9dc904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqFjyMA/BOrY7BX5vqLGZ6Opi/1drGQCe7lzH5LoWAsrFjsfdXZABR8hSroaFrY1WCs+IK4YWmPXmCQEEeIinlqsMZgUzt489ARlYFlP9DZekDI5R059UW+97veH6JkGCJTOq26IpPFZQXoL1shXcGtRA7zA0XUV1WwkhmFbmxXwDl/fkW4WySOYihJll1JCVvQgGUZ2ioYoF9DA5Qu0YoRewYYGfnBNto3Ruw5H80huSsKHFDxLKe+1rJpKZLx3QT2t6mgukDgZz6ksyt/gjqEeseCZ2wm8Gjq5pJiY7Mpe59YqAtcQixoMAlhZVpXfuETROJuRsypb934MW4EhD4Z6oOcoW6ne+aNkLHdR4mVSJJGjdgLekaMQHJzvAX7wtNWrOqZ8rTGgnbcl8LkPZo74GnAVFbI21X9LtpEre6NasT7TgFQmAe7/DTWyXkswCnCJHzwFrQOR9MxXGJ/Z3hidaLSiLcdKx1YdiZm1wpsjcynn/L4XG6i9Mpe6sDxO7FZhmzhjDqYw6Rme7s73DWVo2Pysr6tvkUX6We4G6/fC1OtCrJZ5OlmeRdeDiOTrVo9Xnwahd2kCUcGvmC4Ib061RPNQmrxGFXxUfmtsgjdx4GGpjUl+NFS9OSRX9O1s9WsKxLcRuEOKMMQqJjU4/D42scXIqsHaBSk233xjj1udjJLYcmt559Ev7KlskpNO2WffH/SRE/MG7ULK91lmY//3dNZXmwmzjMkaLbBgGhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(86362001)(83380400001)(8676002)(66476007)(31696002)(2906002)(110136005)(38100700002)(316002)(66946007)(66556008)(44832011)(5660300002)(8936002)(186003)(26005)(6512007)(41300700001)(53546011)(6486002)(478600001)(6506007)(6666004)(2616005)(4326008)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RC80bS9SeVZSSG9uZENPaTdaVXZrNEJydStmTlNWR2VIQng5V2liYklxYkFp?=
 =?utf-8?B?cUZLTm1pdS9lRmJVK2g4OGJJclVzdXAxNFV6UkM2eXZ0T3Fad1A3L05wNWNz?=
 =?utf-8?B?NStyOUJNbHBMb0NkbEtiTmR3bjlHNTA0NTFkMXNUeVFOZFZaUnVNb0hjaFBU?=
 =?utf-8?B?RS91LzBhWWQxUmMzLzhKb3ZEN1RERnN6NlV0TE5aLzRiUVNnb3VTc3ZvMFI4?=
 =?utf-8?B?bVVKY2NhZ1RnRWdRajVRTU1lTFNKN0dFbTQ3NlR1eElzMmNuVXZFOTZwemhL?=
 =?utf-8?B?eDlSVTBvV2FhcTlub1Z5WG1Fd2pub1JMUGtuVEpnWW5vTjVCWmY2eENhMmwv?=
 =?utf-8?B?cTJqYi9UYVplbkl1V0taOTNvUk5RZGpTMy9IajZINWY0QVhNNHhNU1BQakJv?=
 =?utf-8?B?T2NDdm5rK01sbWhla0NjNzVySStNZVdqbjRlS0NZZExiN1lxSC84ZU5VT3hu?=
 =?utf-8?B?Ujh5RFhRVDFidVZXL2lGOG1NNFBQOU9FNXU5eGQ4RjZwelpRSkltSEdLYTU1?=
 =?utf-8?B?MDhHYWVVZjIwSmppdFVJZ0RaUEh3NEhUSjlabDRrdk1lTDNjYldsRDRZNHJl?=
 =?utf-8?B?QkFIcG9FV012YlhtWXFCUnJrd0ViTnhkT0g2WXZORjJaaWRCalcvTVJQc1BC?=
 =?utf-8?B?TklmOExGektpNDhmdDVLL2UweXBQT2JBWEVhaVJmNjdQM0pTa0hzVUppcTRG?=
 =?utf-8?B?WllTT0NtVDdhMnJWbU5FRWZzYXp4ZXMybEE5Myt6QXV4dVZCb1RLRzQ0WHdW?=
 =?utf-8?B?a0U0QkUrWVYwZzBnd0w4NEQyU0M4dmxDa29hcFJNTVBQZnRBOHM0WFlrNDJZ?=
 =?utf-8?B?cXFuMVY2NDRJMGN0MDFuejQ4bTgwL1VXZHlHMVo5TFBzekxsVzZGVGJWZFdk?=
 =?utf-8?B?bm16T25YMkl3V1F5SlZsWHh2OFdjQTZjZU5vOWhERDJIOTdXUldsR1h3Sit1?=
 =?utf-8?B?WlFQRk1wWEttc3hDcVVsdHhnT05VeGRheHdaa000ZlhsdVFaM1RMMEk3ZGFu?=
 =?utf-8?B?ZGJ1MEt1c2o2TnNvaW9PQTBjNmNtMy96LzU3S2tXOUJDMVF1QnpZUmNUZU5s?=
 =?utf-8?B?UlVjWlNUNDhzMGZtZFFTU21PT3VYWE91bm1GdHZDNDIxU2VrWE0xaHkvL21E?=
 =?utf-8?B?MlZaMC8zZTVZNHJYWGJBcTlXYmF5MjB5ckdiWlB4Y2pobHBBSCtsOXoxQzRT?=
 =?utf-8?B?c3ZoWTBJQzVuUjhhLzg4OXdnQk1BMXozT2loWFNBMjRDcExtV3BML0pOalJt?=
 =?utf-8?B?c2RVamhFQm12enk3eHpEQjlNOE4xUjgyd09DWWF5OWZsVi95N0tRTy9DSlV2?=
 =?utf-8?B?eDlsMG5SSmpkNTM4QlRtOHl0bS9WOEtRa2NYeUE3OS9zelo1bmFRQmJYVjlz?=
 =?utf-8?B?Wnc4TDJLTWo5c2JSZWNtbUk4RFNaemZpdkNkcGZxb3RqVTIyQW9FazBCVm5L?=
 =?utf-8?B?b2o0cWJXR0ovcnR3dzZFWUF6Y3lrNkk4QkF1MzFsQUFsVTRtQzI5bnZkV0V1?=
 =?utf-8?B?cnliMTQ0YU5VaXJibklCeWQ5K0VBbkc0YVg2cXpNMjZyMTNtSkZLNTYrZ0Nv?=
 =?utf-8?B?RmlIditkNjVmakdRRVhDTUFia0UxN2o5UzY3K08yeURJSmZ3VVg3M1RrenhK?=
 =?utf-8?B?ZEhzNDBzdHVhSnJwa2J6a3FvbXorenIxWHRsOVByQzRUWTYvcjdZNFV3MnlP?=
 =?utf-8?B?QTJQMXIza3ZQQUJxOUJkamN4VnQzVjVWaE1DakRvL2UrcHV3Q0RaUC9Ua3A0?=
 =?utf-8?B?blJoL3JvTURqdG5IeG1ObVhYSFlTdE50T1A3UzlWSW80M0diM2c1US9CclVH?=
 =?utf-8?B?aDVsRnkyQWpKVm9ISlcwQ1R3U1FtU3p0dVdmd3hWVDFNc3gyUmFTVHJnSlRj?=
 =?utf-8?B?b0pZNUdQbnZid0toRDZqZFpWNDhQVjVFaDE0WTNDLzQrYTdMdk1wNmtXM0lF?=
 =?utf-8?B?a1RHSmFucEdXVzJMaE9ZQUJmSVVLOWRqN0dvUWxLbHZFdStJcGwvL3FYSEVp?=
 =?utf-8?B?Um5YV01tNXJrTC9VS3RnU1U2dlFtL3d0QktCc243Ym9iVFdxVUw5YlYyZFpT?=
 =?utf-8?B?b0dhdmx6Mzd1OEQ4d2d3YXQvS3hJSVYwSGpLOUdQbDlXdGRoUWlXcmJQcGRr?=
 =?utf-8?B?SGJqNk9XU0hkVWJvSjVXM1l3SUwwMHg5cmVRTlVnd0FpM1BVWEY0OG1MRFRp?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2f4338-c3e8-4e42-0e11-08dadd9dc904
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 06:38:19.6862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXqFVqVoS+4RjsVjT6fusXe5ajUmlJQKhXpzfNLx1Xd3Jwivl3BAo0dda7Aupw4x1Vv5lLEZIG+ly6taoKEQzZA7Z4jw0z6+91INoxHWeyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_02,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140050
X-Proofpoint-GUID: VYYxN1iU3wI9zCJw5vSWbkRfmKa8ypML
X-Proofpoint-ORIG-GUID: VYYxN1iU3wI9zCJw5vSWbkRfmKa8ypML
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 5:02 PM, Mike Kravetz wrote:
> On 12/13/22 17:27, Nico Pache wrote:
>> According to the document linked the following approach is even faster
>> than the one I used due to CPU parallelization:
> 
> I do not think we are very concerned with speed here.  This routine is being
> called in the creation of compound pages, and in the case of hugetlb the
> tear down of gigantic pages.  In general, creation and tear down of gigantic
> pages happens infrequently.  Usually only at system/application startup and
> system/application shutdown.
> 
Hi Nico,

I wrote a bpftrace script to track the time spent in 
__prep_compound_gigantic_folio both with and without the branch in 
folio_set_order() and resulting histogram was the same for both 
versions. This is probably because the for loop through every base page 
has a much higher overhead than the singular call to folio_set_order(). 
I am not sure what the performance difference for THP would be.

@prep_nsecs:
[1M, 2M) 
50|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|


Below is the script.

Thanks,
Sidhartha Kumar

k:__prep_compound_gigantic_folio
{
         @prep_start[pid] = nsecs;
}

kr:__prep_compound_gigantic_folio
{
         @prep_nsecs = hist((nsecs - @prep_start[pid]));
         delete(@prep_start[pid]);
}

> I think the only case where we 'might' be concerned with speed is in the
> creation of compound pages for THP.  Do note that this code path is
> still using set_compound_order as it has not been converted to folios.

