Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED505F9FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJJOOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJJOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:14:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989D2140D6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:14:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AC459v030737;
        Mon, 10 Oct 2022 14:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gJVCNUVQJEA8v4a1T1RwVQq88kbuvu+nH0mb2ETbz0o=;
 b=g6wIVu7nAo8Ae9rP0Cnd8ewRSSMW2HsuV1Hm/5WPOAqBepf3w9ACgzlZSz66/Z3muf+0
 xTav8x/9EX8ehVDJlmT+IFZvbN8F+izWGr9dMu8+6oAZf/PkzEXVIYf88mR2KGDM3Xhv
 lFWxyRbpIJGsiDkL4sGZVyBTKxDGS9hY6UjSqxW7CHLyYoUD8JPlrVr5VE7BUwbyx/BN
 YeMYFwyxzlKrHXa7h23I6omdj4ReFilHkFn7xd6MT06GSyY2acOI5RHf4Swgu9bA8Z9d
 3//o/vX8D25ByAub+ts5g28rldhniQSg42sIJff0jNtYOTuxgVKQlnepVrco4gfPBv6O Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3139upwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 14:13:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29ADhHB3002907;
        Mon, 10 Oct 2022 14:13:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn2pfv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 14:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGE71p3z8CY5yvPU9MC8uP+tJfkHxfPQBI6jsDt7JX1wfuSNtNj+c1x3Vw9H9rPS2i1EDz61u3luyS4LM6O8BZ70hqKlZ1JyFSN7wqaa3jq3dxgREPK2YW3M2+cqsq9gm5yV1OitWxig1pEGsb2EqkneQgVfWFrjQa0oPXkO3stKP04QisdvNzoHn+KMdGtCVQsmC4U7/La9GVBjbn0oaHdCr/XeFz3tOLxkaQqFsFWibVgzTYn01D/eUnClYSR0ukUAwI61gu028sZxYX9sNCHMGEKkpkBLtLCg2v061XS+xe5CjNgcexz5AkxWXvLTXeoUpU6PA2NoaMlI4C/vpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJVCNUVQJEA8v4a1T1RwVQq88kbuvu+nH0mb2ETbz0o=;
 b=dhgZyS21f95lm1FjgoUQPe9EQ2CXvNGgh+kXrTdwtK7tXkfuEcFoXzG33Ktjsf2pzlz9PNAqy/XsRJ3wQkLRFj96aKxbB40cDeF5XcwuQDtf5IUs4gyvQajk1c7s2oM4g1cewIHcbnwFMdLrG7WEGEduwiioYpBcFOVVd+DIRhFUlahnkgsRGyEJkKw18q885vvwJAatatVNi08hKpUBnoeml9UiPr2aB7b9mYlE8ACjldaelRhKr1jO/pDk5ymomX7lQipIoIosfwe2U1K5TvTeXBIWzoPW06wpSWXdMJk/QT6lEtF3/M3ZK9M47WXee/getYmrj6GaEGcdI/YJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJVCNUVQJEA8v4a1T1RwVQq88kbuvu+nH0mb2ETbz0o=;
 b=V80YQZHHspvAo1vO/hPfU823A7ESZUTfVjNQd6pdmWkymPF0LfyRXs7qm/HtQM1gcxOytMwVDs8yVFKm0J5UJ7rZiDv17/EWmMEQNxTJYH3FKjHMC+EMA+UAHk+m25lTiRcJ1jUzAOdRyj8sr4O4cTMO4z4SpL5z7b7hceo3h3M=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by MW5PR10MB5714.namprd10.prod.outlook.com (2603:10b6:303:19b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 14:13:54 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::dff7:be08:8fff:b064]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::dff7:be08:8fff:b064%7]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 14:13:54 +0000
Message-ID: <cb418668-e02e-964e-f6ac-6bb3d82f5e36@oracle.com>
Date:   Mon, 10 Oct 2022 09:13:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] fs: jfs: fix shift-out-of-bounds in dbAllocAG
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>
Cc:     syzbot+15342c1aa6a00fb7a438@syzkaller.appspotmail.com,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20220929054500.488604-1-dzm91@hust.edu.cn>
 <CAD-N9QXODN4xjOg3a3chs0yxfXfAO8pY+yud0Den+1padxGoLA@mail.gmail.com>
Content-Language: en-US
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <CAD-N9QXODN4xjOg3a3chs0yxfXfAO8pY+yud0Den+1padxGoLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:610:59::35) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|MW5PR10MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a9157c-cc1f-4570-85fc-08daaac9a999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/UubeVP7KflRHkO/a/chqEBVJL+2Zc0PslUXXitqFpwQh6LYaG1wfKH0TJ0C9l9GPIlqSzwvqB/P9BxKsSL55VIfm/wHtnd1uetONSwh3lncryPFHLw3RwlClIwO3IjTVN7hxNOa/HtUaaTanBqwskk98hAy1GnnLF3qb7bQvohAVzdIgyAI7PphVsXYi0hSsI7Nlh/uic222VfIo3rnyeDCyeIu8MVe4rIa5wodLEQga7coCQwD03DOps7+RjtFyil8vSTHkE6nfgTOtDRLWwYPp30zWvhslW8kF6pKrnmefOnriGYpNL5iqJt5M5pbZJCwEcDoA+4m7So9DEXQ4pe9drZwbS+buYSognvIW9axNEnwddyOHU+bnPDqZKgNY44yw9ivoCIpghDwZ4H8ysq2KsnsFNlQk5m/PffsSSQgXkKlPxKyforiJYyAO1J+B6J/kl0TFG0jpzWHthN51HviX3LhL6gHZ476nthx2P9fSDxgG/pTIAeEBShZQzEErgERuP+3NJDsxEfhhPQFhC4Nt+R2WS3jZVoDjcUeySYjzqOutTA2Ji+CJKYkJL7Rp/RhGLs/biaU/f/dirVhHiXVHy35bLH21UyzDHPScK2GhEw6qeqpIMi5qi2wIsdtbZ9V/VRSXf+Y42IOLF2FS1levMSfnAHyLAh2jttV98zFuDyaNUDN9oB96WFNnXdoBc/9AGq4LvgbLbEdWRxSekjZ0wwW3185Mup/FrZY3P1OUWGB2qAxUMGMDxUiLoAWaApNO/GVnqYWleJbhV4ghFO9dg5vQaq5wOdCmJ74eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199015)(31696002)(8676002)(86362001)(66476007)(38100700002)(4326008)(44832011)(66556008)(316002)(66946007)(2906002)(41300700001)(186003)(110136005)(2616005)(53546011)(6512007)(5660300002)(6486002)(6666004)(478600001)(83380400001)(6506007)(8936002)(26005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZC9meEFPenhEK2RRdTdJSElSQmF3Z3RkZml2YnVCdFlJOWc3WThDRkMrUGp6?=
 =?utf-8?B?czZPa01hUElMeTF6ZU50elpIQXllRGh2ck9YMWRRdTd5b1Q0WVpmdUswcktT?=
 =?utf-8?B?dFNlZjYvM2lIeHViWEt1MVZmRFVPWnBQa3pHK1lBTlJmOTRMTmNvSHVIZjkx?=
 =?utf-8?B?TmVzclpJNlZyVDBWRGlHbk0rRWhYQVVxYlFuTzdVUVdmcWdnQUNVcTYwdUI3?=
 =?utf-8?B?R2FHbjlxVlRrOFE1Q25rbHVqWm05dmdNd0JQM0FmUGduZGFoTnpEbTgxblpw?=
 =?utf-8?B?R3V1VzNHTzEvdVRNeFdHMElwenY1WmEyLzdCVGZHd2FWUFVCazlhSm8wendy?=
 =?utf-8?B?OHljUTh1cVpsb3YvUk5CL0tXVXhRYlN4elhLY2dFbHJMekJVa21SV1JFMjMz?=
 =?utf-8?B?WklUcjJCK2ZGUHQ4Z2QwVmV6M0I1aTZ4Y1FTNzExQ0xSRWljNTlpK0ZRYWZu?=
 =?utf-8?B?V1VQSURSOFd1aU1VdjhBbmZFaURtQ2dBcUlBUEMzU01SMC8xTUNHTElzTWxH?=
 =?utf-8?B?eHJGOXRxVmVhSjRZelJjUk5kV2UzMzZSNytDdDJBYlArSzBXSFQrUGo4TGtr?=
 =?utf-8?B?SWkwdGxka2FnMWd5eFJVYldTMm9PeUZ3VXRNeTdpZDl0RjhKUWk0OVRONmR1?=
 =?utf-8?B?L2V2Vi83VExHWUdBaS9ZWTl2cTRDL204TDVxeHBYV2ZXVUJZUlBVY1VsMmp6?=
 =?utf-8?B?ODdGUXloVnhCb1VTYWxXbG9rYkZDWFlwOVQrZnBUcXM1Tzlkck1xK3ZGK3hF?=
 =?utf-8?B?ZE5tSlhoaUppcytnZk5tdDlnOHJYMFZuczhuSWU2SkVHdjQxTkZ1S21uWUlE?=
 =?utf-8?B?Z0RSUTRmdXBLUmhHTFNwak4vVGRnM2VvWExnSWhSbzJva2FWREtRUU9KVW5o?=
 =?utf-8?B?ekYvY0p0RytZT2ltNXUySGFXZnNPOU9JTHlYRVIzR0o3WVBVZVFwY3FXODhZ?=
 =?utf-8?B?VG1yMlhhTUdkZjYrd0NYVzBPUXJLWnhoRHVDeGppaitkSE5JRFBHaTF2b1lq?=
 =?utf-8?B?TG5lZ1N5M1F0R29lWjBFNkpGTDJtVy9RRWpOK2M2V1hqTFk3RjZDMWpOaGVl?=
 =?utf-8?B?NVAwdW9NKzREYmhDS2RRdEYxcFBqUWpER1l5bXhHQnZBSUVOMUtkWm5PTXpK?=
 =?utf-8?B?ZHM5dVFXYVVzaS9sRlp6L3RCMCtNczF3bzYrNm1uUHpKdWVyU1hQeTc2ek5S?=
 =?utf-8?B?SEtsekR1bklVcy9qQ05jZHY3aDZvUTJpNXB3aHdobWVwOWc2Uk5QcFNUb0FU?=
 =?utf-8?B?Skphc3Flc0ZLR3o5RE9XWHEvWXVyVTdtVUgwVmF5WjhCdUdCOG1ja1hXYnlp?=
 =?utf-8?B?QWRlVEgxdmJ5cUF5MmxrcWp3aWNacGptK2srL2thV0hseVJ6cXVrRVEwbEJo?=
 =?utf-8?B?bG9MeThXczB5dSs5T1NlNnVhQWlaUTljZWhwV0daaDI5VmVEL05JMXVHbW5N?=
 =?utf-8?B?d2hJQTBxb0JjMGdCN0MvdCtjcll4VGJYSHF4THJjQ3B4V0hocjhIdGhXR3Uw?=
 =?utf-8?B?THV5L0NzSXpYRk5Pa0ZFYjloZ09KVXJFZWdiN282RGNaZWtaNHdGallVbFZt?=
 =?utf-8?B?NDF2R1dnTGdxNnVVR0tMTXlxSmhIdzdMWTR3aEVXOWJQVWFCbVZGak40dkMz?=
 =?utf-8?B?N3gxL1NFSENWMURUNHVUZU1QY0IxVUZ4SEg3TGhEelZMeGFnamZhMDdhTUg4?=
 =?utf-8?B?cE1TSUQ1UEI5aFFielhhRHVJV0RmNzZTanNTMUk3ZjdVUjZnUzllcWpWRHFX?=
 =?utf-8?B?MDEvbmFKcXFZUmFxdElPUHROeDlXTncxbTF4NW9PRDhNSXgrZHpVTW9YTm5W?=
 =?utf-8?B?V01kVGRoazRzQko0V0d2cjRxY3Z6TkFrOXd6VTExMVFKYWI2Sk1HaURHM083?=
 =?utf-8?B?WDc5TnVCWElVU2pmb2ZjZkgzait0RFFwTjFwOS9tTFpOS0dzTHFxSklBc2pU?=
 =?utf-8?B?cTFsY0IvNEZ6KzRLMEhwQzI4NWhBbzBDbTUrY3pJMFg4VjIvR3hjTWZ0VE5G?=
 =?utf-8?B?bkt0T1ZqWWlDdTNCOHpQOTVWUllGOWdha2M5SEJTcnNyTC90bC9ibkNyYVJG?=
 =?utf-8?B?N3diY0IzT3FDTzhHMDlUcXdnUExMM0lnR2V1WFlwcU1kRW5DeVJONkw4ZUll?=
 =?utf-8?B?ZVgwenBFTnhpdW5nN2JZNkxUR3IwTXFpUDZreW9FVnpNQUlSWVBaWUcvditt?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a9157c-cc1f-4570-85fc-08daaac9a999
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 14:13:53.9561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMbPrj2j6iArUys8LcP6NTYGVfDqTCzX9hcMDJzM+mNeAehYT9w7by0cbMceXfVm9BCTkohQYeTVRqAW9hCTtuXxIn5pNuPQ7tpObOHgxic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_08,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100085
X-Proofpoint-GUID: 45MYHqACc-LiyWa9vCIkQe6Cr9bGBsiT
X-Proofpoint-ORIG-GUID: 45MYHqACc-LiyWa9vCIkQe6Cr9bGBsiT
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/22 9:00PM, Dongliang Mu wrote:
> On Thu, Sep 29, 2022 at 1:47 PM Dongliang Mu <dzm91@hust.edu.cn> wrote:
>>
>> From: Dongliang Mu <mudongliangabcd@gmail.com>
>>
>> Syzbot found a crash : UBSAN: shift-out-of-bounds in dbAllocAG. The
>> underlying bug is the missing check of bmp->db_agl2size. The field can
>> be greater than 32 and trigger the shift-out-of-bounds.
>>
>> Fix this bug by adding a check of bmp->db_agl2size in dbMount since this
>> field is used in many following functions. Note that, for maintainance,
>> I reorganzie the error handling code of dbMount.
>>
>> Reported-by: syzbot+15342c1aa6a00fb7a438@syzkaller.appspotmail.com
>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>> ---
>>   fs/jfs/jfs_dmap.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
>> index 6b838d3ae7c2..4c717f245920 100644
>> --- a/fs/jfs/jfs_dmap.c
>> +++ b/fs/jfs/jfs_dmap.c
>> @@ -155,7 +155,7 @@ int dbMount(struct inode *ipbmap)
>>          struct bmap *bmp;
>>          struct dbmap_disk *dbmp_le;
>>          struct metapage *mp;
>> -       int i;
>> +       int i, err;
>>
>>          /*
>>           * allocate/initialize the in-memory bmap descriptor
>> @@ -170,8 +170,8 @@ int dbMount(struct inode *ipbmap)
>>                             BMAPBLKNO << JFS_SBI(ipbmap->i_sb)->l2nbperpage,
>>                             PSIZE, 0);
>>          if (mp == NULL) {
>> -               kfree(bmp);
>> -               return -EIO;
>> +               err = -EIO;
>> +               goto err_kfree_bmp;
>>          }
>>
>>          /* copy the on-disk bmap descriptor to its in-memory version. */
>> @@ -181,9 +181,8 @@ int dbMount(struct inode *ipbmap)
>>          bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
>>          bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
>>          if (!bmp->db_numag) {
>> -               release_metapage(mp);
>> -               kfree(bmp);
>> -               return -EINVAL;
>> +               err = -EINVAL;
>> +               goto err_release_metapage;
>>          }
>>
>>          bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
>> @@ -194,6 +193,10 @@ int dbMount(struct inode *ipbmap)
>>          bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
>>          bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
>>          bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
>> +       if (bmp->db_agl2size >= 32) {
>> +               err = -EINVAL;
>> +               goto err_release_metapage;
>> +       }
>>          for (i = 0; i < MAXAG; i++)
>>                  bmp->db_agfree[i] = le64_to_cpu(dbmp_le->dn_agfree[i]);
>>          bmp->db_agsize = le64_to_cpu(dbmp_le->dn_agsize);
>> @@ -214,6 +217,12 @@ int dbMount(struct inode *ipbmap)
>>          BMAP_LOCK_INIT(bmp);
>>
>>          return (0);
>> +
>> +err_release_metapage:
>> +       release_metapage(mp);
>> +err_kfree_bmp:
>> +       kfree(bmp);
>> +       return err;
>>   }
>>
> 
> ping?

Sorry, it's taking me so long to get to this. It looks good, but I'll 
give it a little better look and push it.

Shaggy

> 
>>
>> --
>> 2.35.1
>>
