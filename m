Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E3A5E697C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIVRTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiIVRTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:19:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381BCD2D7B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:19:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MH3r34032074;
        Thu, 22 Sep 2022 17:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=mDJt96ZBBWPl1ujIl6EnZ27/HFxXkpj9Ibhf34S4t1E=;
 b=nhJ6Rhg8K6AEeLr2iP64AtZ+sTmQOR2RRxJxqyOxDPb3k1OsgLZ7Qvj1JOkTpqlZHUBn
 3bY35KzTgjHHIXMVy1SFsJZ8cu6QvCIz7JyyuxQCTLuX8DmCK3fDL5LiUX5bhH8znZyX
 2nXQAIGscRIgwxJDvf9DX9qKtByQvWuaMrl1GTnMve7meXRx4dN80CCUnwCelbFce61L
 YHGzshWVIGteS8DA5ivigNoC8u2xkM+i+zZkSRlzqlTU52b5TR+DiK6XtrrUYqFQKV1k
 jmr9krdvilztue6px0udHqzLGgWS6h2Hrb5CAH5dCSFaN7YNdtvcOq+xxMm7StMe/Ttp Jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kx8fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 17:18:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28MGEeVZ001802;
        Thu, 22 Sep 2022 17:18:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39t1gd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 17:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZraRmpPpVOzaaM27UbZpSah/WwBYnX1GR67GV2FnDUxlhpnq6MSmzo8txNL/99QhbAUrDbJjH4J8wWGG0olS3vRajqBLB0MwRiGk282gCW6UsTf8VpQ2Vfpwv4Rbx7GOfHFUJWXcKYAJQ2kveSukNLw7FeH5+mgruFLHJev/BxDcnH5dDzbV4C4S6tzahzuEwqN1WQs87PCdZ/eI6RiI3UgSUcNXsf8lI/1Z0AJQDVr7QHCAsoAeCBs8jNvva7Jilq0iy0U5d6d7y+pljwITfiZTcIc97kTLWN4VNAdNF8IwTyvkXVW1LeqCafyzWSV6SLIygAq0Nzd7CMNiPQvduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDJt96ZBBWPl1ujIl6EnZ27/HFxXkpj9Ibhf34S4t1E=;
 b=TQCmXPFjuzq6s5emB+hse7Mc4cMMsT2GX3wC+DgXNN6FTYxdQpcG+QS6BTqFPROjTJvz3DmIWmKLXSOkKVAUidLMiEgtvcTQd0GnRQyTfy75YWvAdnzP78ydvaafsAzgHTpHValBq7EhDhXW3yqz0AyH7VvV1bYyi6DAYOCX6M1ls4pV34L9a8kk9ciODebfU/jUYUh5j1Vz7n7KAdsmxWwddX6JAm0WgEZ+zHn37wKQILba+88Zd4VxFLAKG3GkK9Kc4eVVuqrV3Nsr31VxVUHywLmL58v0uz4UkUseFiNki++i1/jY2D85isH2XlKx/AGumcVsg/yXXVx1h8XyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDJt96ZBBWPl1ujIl6EnZ27/HFxXkpj9Ibhf34S4t1E=;
 b=yxSTe0TaU2V57V14G/qDRIWbXNlPkSrnKOUL4tjQ0BSqlvPha3mD95YLgUIbmKscbKAo6PPcAm6+Rlxvyei9KlQRPH0NOIMf5jK73m+bYlPXUSgCxSAt2Jd1rexJM0LHKbr4EG4evIMv2ahWH4nLK8PBkckqHj/Tsd8vrdH41BY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4503.namprd10.prod.outlook.com (2603:10b6:510:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 17:18:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 17:18:45 +0000
Date:   Thu, 22 Sep 2022 10:18:42 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Liu Zixian <liuzixian4@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Message-ID: <YyyY8prkoxy2qv+W@monkey>
References: <20220921083440.1267903-1-liushixin2@huawei.com>
 <YytOYH1MSo5cNoB6@monkey>
 <Yyuk83B4VHh+pbFp@monkey>
 <708d1ec7-5c25-5e45-0db8-bd97a64e0db1@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <708d1ec7-5c25-5e45-0db8-bd97a64e0db1@redhat.com>
X-ClientProxiedBy: MW2PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:302:1::40) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4503:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c20090-21bc-49dd-f37e-08da9cbe8138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqX7p23jUclpujhRZW0GXoSXyHMqASLmrCg3DXeGR0WDYplHKLnlGmZ75Gg0mT0duNn9vxMXnT0WNouCrh+ujpFvTsHYyEfTsoRp9Cja58cQEeRW/5VJ21/UABT6eaEhED8nJHuaLhfNG0c3IVu9kyq/cghzWkSlA6rXtqCj1UbkyqqtxnDM/BvApEDXFq+vx4taqCUkGewIZIcahI0Wj2gHjJJanqfYXU5xZ0X6ceWJCxTrveEjw/CyaYm7cZmd/YlLrzHCJJGAy/BcPyAkRWdIM28HWEZkq/7w4Ubg0ZcdHCoxDYq7+NlYu3x6K6CsW8gMOuVl4LLLGhqpcSSWx89NCyU5fzTQyU/EnBF9VLgaOrCOQgbabOju+6V1u+RMtPs6BXQ1JRg+4RThuiXwiHmAefsK82us9CnhHnYZFqEcbsKGrbPysEqi9nWPiuFtSQFQb+JbBJHnBGT4JLz5Dn//8jl2mUZphLEyyIL/OQye0I9bttpb4oDZlafb+L3O4hG2OgY/wNZramf+1iHDBzoU6i+ZX5b11+1sgyPyd+hQQt8PmgjaYboyTit1VebGRa1jUCmjSkd1wXXUQ+SxhCbo7THBRam8RksWaPSTbQpPqtBxOicvvliqoGtuA2wXe5RMbz4OsekqFfk3fcq+NZ6dE1KoD02rq5iBja/myE5m7sDPvep7Bc9MS+IcJiErCWP1uw/Uacr8ticyVrxQiu5G+fwUzUAt9A0CRS3MR6VmacEUdxWkHxZf0Ihk9qe3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(8936002)(44832011)(66476007)(7416002)(110136005)(54906003)(5660300002)(86362001)(316002)(66556008)(66946007)(8676002)(4326008)(83380400001)(186003)(38100700002)(6666004)(41300700001)(6506007)(53546011)(6486002)(26005)(9686003)(6512007)(478600001)(33716001)(66899012)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2V2eldos7fwgJqDEKqSjq/vTMDeybr9YrK8bmR8C0Eevss0Qksm25lFCcXYU?=
 =?us-ascii?Q?W2t6S1s+4ebwKy4aHlLhYaJSckin8Lvj0Dhh8AsomdTRoDeGZ4swXkNJn8l0?=
 =?us-ascii?Q?BxV5hKp2NM2sHht3lKxZ3kL43/02Y71JIq1Xc8P2215Xx5cAroWe1SyJ+Cr0?=
 =?us-ascii?Q?4aJvNABDYlzfik4gmqJGjFWNsLniQFZ5ZdUg3g7nFIhJeH0lthN1DyCxx+KZ?=
 =?us-ascii?Q?hRYiF8lbgCMETxp8k1k3cp0Ge3Oge7YKH9rruCz4aaj06g4ZB9W3/xaoYB3s?=
 =?us-ascii?Q?SEFJgCMU+WFnn7Xl6im5oyth1jsqoKZTSNmAlJEhj0js0ejyLPwHrRE9kIW0?=
 =?us-ascii?Q?ALAzDabBdPgNuQgsh7VC9OSWzzirULp9ahWdpb+HTrg8+THAa8kdEMt1LsNq?=
 =?us-ascii?Q?jkYrPQ4jDZNrYHlHI5HEGB5m3adP6oaBYqKWMycLhT1T0+Q8b9K0R46kaGNd?=
 =?us-ascii?Q?35FkDqj74wkTrjMgSPbNMep7mh7NMqIc5IVzgleP/Ox7rcTCG+7AI+31+aAM?=
 =?us-ascii?Q?Q7ZlCIOadgfexLFprp2+pePAqfCBmocnRPiv5w9kmvIF3AssM1ultC/iHard?=
 =?us-ascii?Q?I57r4X88Wi3vVNUwK1sm8ck0CUEB3aQcz86CmFwpe/BPODALMutPM2V3khvF?=
 =?us-ascii?Q?JHGvVpIY2zjAAlNA2eR9pbrTGS4zWpy/2JUWHeseQI6DT6deh8TtFc0njldc?=
 =?us-ascii?Q?8W8cmftFY2X1AsngrFoosckoE867V3YuAbXAEtdl0UMiicINHqZK0cMGNyTy?=
 =?us-ascii?Q?c3xhvniCAcRrZJVJ4OTQUJlC4Yt2gd4rqASVdQbZIn6fV8oyo1UWY7TS5yXM?=
 =?us-ascii?Q?IbBaF++ntogyPbCBfvhc8gTB3FHgP6yF42/3LgOQnxsiLsAL4KT7chYY6l57?=
 =?us-ascii?Q?tmJWbyiIV8pYUk+dVF2AyNooLdi0Cvc/gbI6N/YpbPWyjj51d3tBVjGGo8je?=
 =?us-ascii?Q?8IYeAqZqjNQmnTTsi6L208+7LwZkgunWCqh4028ipCUq7bErVyr7E95poQk+?=
 =?us-ascii?Q?Ob77dEo7I9/Ice6BuOxRj1EQXbvATxsj/fWz/yMd15wrDFN4PedKKpANr4m5?=
 =?us-ascii?Q?oBHL4T5bniG2Q6YUTswcxuGyVplWrx7w42uGBQLXUIg7zlOd8PxAFYBRD6vm?=
 =?us-ascii?Q?hvNceQwJ8CbAAqGSKtHxP+vSfaFR9Lt67f6LtZFTJvw+VzxN4BF1JpH3H9+p?=
 =?us-ascii?Q?E6J1Lfc7ZxIFQHa6gA3IEMfEcjpe1jiK1PPBOTDIrwog+XWvqYw/m2TRc+GT?=
 =?us-ascii?Q?uWuEdpdtW7Llzx8sk5mdU5qyEa1CQZoINqXlaQ7pN39Um6ixAmR+5uB2WbQ0?=
 =?us-ascii?Q?+3nFSZeP6/Co7f32Tpd49qzj/E+hE6PKgzExcXCdgp089fPWjoMtJmR7YeV5?=
 =?us-ascii?Q?gLyY2qd4Y16q66JWVNdbuLZVZnhLGxICuAoRjRfqoSvEb53lw5r2Tf/8x87c?=
 =?us-ascii?Q?3vnPH82ok66QIh7pmsLv1OKaT6mtptkNRqgkb64MZsKC2fRrnAhNAryphEfe?=
 =?us-ascii?Q?GraO3LmxNOgUaWtrsYYWBzvWs/7vhjiccHuK71p2qta7PttXpblNixAYG0w/?=
 =?us-ascii?Q?vSaAjF6MKaENkQeTk77IT41Cyz8rcyQ9b2cb+Fatek60BX4PMt2PaWUYRhRr?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c20090-21bc-49dd-f37e-08da9cbe8138
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:18:45.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwjYoDthurL7VMbsOPeFu5ywcX5ikawFCqd+fhn8DRrJfxxy8EpdwIAKVdaXjxLabU41VqxnJC9c65x4IP3BvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_12,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=357 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220115
X-Proofpoint-ORIG-GUID: okIIxXQQe2uGPhqULWUTQvAITxIqb34g
X-Proofpoint-GUID: okIIxXQQe2uGPhqULWUTQvAITxIqb34g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/22 09:46, David Hildenbrand wrote:
> On 22.09.22 01:57, Mike Kravetz wrote:
> > On 09/21/22 10:48, Mike Kravetz wrote:
> > > On 09/21/22 16:34, Liu Shixin wrote:
> > > > The vma_lock and hugetlb_fault_mutex are dropped before handling
> > > > userfault and reacquire them again after handle_userfault(), but
> > > > reacquire the vma_lock could lead to UAF[1] due to the following
> > > > race,
> > > > 
> > > > hugetlb_fault
> > > >    hugetlb_no_page
> > > >      /*unlock vma_lock */
> > > >      hugetlb_handle_userfault
> > > >        handle_userfault
> > > >          /* unlock mm->mmap_lock*/
> > > >                                             vm_mmap_pgoff
> > > >                                               do_mmap
> > > >                                                 mmap_region
> > > >                                                   munmap_vma_range
> > > >                                                     /* clean old vma */
> > > >          /* lock vma_lock again  <--- UAF */
> > > >      /* unlock vma_lock */
> > > > 
> > > > Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
> > > > let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
> > > > the issue.
> > > 
> > > Thank you very much!
> > > 
> > > When I saw this report, the obvious fix was to do something like what you have
> > > done below.  That looks fine with a few minor comments.
> > > 
> > > One question I have not yet answered is, "Does this same issue apply to
> > > follow_hugetlb_page()?".  I believe it does.  follow_hugetlb_page calls
> > > hugetlb_fault which could result in the fault being processed by userfaultfd.
> > > If we experience the race above, then the associated vma could no longer be
> > > valid when returning from hugetlb_fault.  follow_hugetlb_page and callers
> > > have a flag (locked) to deal with dropping mmap lock.  However, I am not sure
> > > if it is handled correctly WRT userfaultfd.  I think this needs to be answered
> > > before fixing.  And, if the follow_hugetlb_page code needs to be fixed it
> > > should be done at the same time.
> > > 
> > 
> > To at least verify this code path, I added userfaultfd handling to the gup_test
> > program in kernel selftests.  When doing basic gup test on a hugetlb page in
> > a userfaultfd registered range, I hit this warning:
> > 
> > [ 6939.867796] FAULT_FLAG_ALLOW_RETRY missing 1
> > [ 6939.871503] CPU: 2 PID: 5720 Comm: gup_test Not tainted 6.0.0-rc6-next-20220921+ #72
> > [ 6939.874562] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
> > [ 6939.877707] Call Trace:
> > [ 6939.878745]  <TASK>
> > [ 6939.879779]  dump_stack_lvl+0x6c/0x9f
> > [ 6939.881199]  handle_userfault.cold+0x14/0x1e
> > [ 6939.882830]  ? find_held_lock+0x2b/0x80
> > [ 6939.884370]  ? __mutex_unlock_slowpath+0x45/0x280
> > [ 6939.886145]  hugetlb_handle_userfault+0x90/0xf0
> > [ 6939.887936]  hugetlb_fault+0xb7e/0xda0
> > [ 6939.889409]  ? vprintk_emit+0x118/0x3a0
> > [ 6939.890903]  ? _printk+0x58/0x73
> > [ 6939.892279]  follow_hugetlb_page.cold+0x59/0x145
> > [ 6939.894116]  __get_user_pages+0x146/0x750
> > [ 6939.895580]  __gup_longterm_locked+0x3e9/0x680
> > [ 6939.897023]  ? seqcount_lockdep_reader_access.constprop.0+0xa5/0xb0
> > [ 6939.898939]  ? lockdep_hardirqs_on+0x7d/0x100
> > [ 6939.901243]  gup_test_ioctl+0x320/0x6e0
> > [ 6939.902202]  __x64_sys_ioctl+0x87/0xc0
> > [ 6939.903220]  do_syscall_64+0x38/0x90
> > [ 6939.904233]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [ 6939.905423] RIP: 0033:0x7fbb53830f7b
> > 
> > This is because userfaultfd is expecting FAULT_FLAG_ALLOW_RETRY which is not
> > set in this path.
> 
> Right. Without being able to drop the mmap lock, we cannot continue. And we
> don't know if we can drop it without FAULT_FLAG_ALLOW_RETRY.
> 
> FAULT_FLAG_ALLOW_RETRY is only set when we can communicate to the caller
> that we dropped the mmap lock [e.g., int *locked parameter].
> 
> All code paths that pass NULL won't be able to handle --  especially
> surprisingly also pin_user_pages_fast() -- cannot trigger usefaultfd and
> will result in this warning.
> 
> 
> A "sane" example is access via /proc/self/mem via ptrace: we don't want to
> trigger userfaultfd, but instead simply fail the GUP get/pin.
> 
> 
> Now, this is just a printed *warning* (not a WARN/BUG/taint) that tells us
> that there is a GUP user that isn't prepared for userfaultfd. So it rather
> points out a missing GUP adaption -- incomplete userfaultfd support. And we
> seem to have plenty of that judging that pin_user_pages_fast_only().
> 
> Maybe the printed stack trace is a bit too much and makes this look very
> scary.
> 
> > 
> > Adding John, Peter and David on Cc: as they are much more fluent in all the
> > fault and FOLL combinations and might have immediate suggestions.  It is going
> > to take me a little while to figure out:
> > 1) How to make sure we get the right flags passed to handle_userfault
> 
> This is a GUP caller problem -- or rather, how GUP has to deal with
> userfaultfd.
> 
> > 2) How to modify follow_hugetlb_page as userfaultfd can certainly drop
> >     mmap_lock.  So we can not assume vma still exists upon return.
> 
> Again, we have to communicate to the GUP caller that we dropped the mmap
> lock. And that requires GUP caller changes.
> 

Thank you and Peter for replying!

The 'good news' is that there does not appear to be a case where userfaultfd
(via hugetlb_fault) drops the lock and follow_hugetlb_page is not prepard for
the consequences.  So, this is not an exposure as in hugetlb_handle_userfault
that is in need of an immediate fix.  i.e. A fix like that originally proposed
here is sufficient.

We can think about whether this specific calling sequence needs to be modified.
-- 
Mike Kravetz
