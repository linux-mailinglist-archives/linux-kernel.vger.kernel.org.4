Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C035E56DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 01:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIUX6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 19:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIUX6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:58:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5639FAA4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:58:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LMwr4V003835;
        Wed, 21 Sep 2022 23:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=uyQ7NLMBLCZuFJkE9qqW1ftB0nmYRW+syVDy4jniNSw=;
 b=P9H94x5jAxXOm5I/pIm/DhXmm/v0jAxEb4BHjkJChwql7HgfO4QJH1qDQh3aevuNuTZt
 cGVqR+N33GDJmpssSgqgUtb4uVHBA7jhT2u/lSAyYUU55zh9Ar7jvuqZoZn1XtI7g7yB
 UBm6zGGgat8wezS3aXv0fTfE8fFyN6MuFuUZrv/ujXMPblomdx8w3DMIVmBubiFqZtmN
 bTNnizgRMAxCV4T3ekDl4bHz5QN4pTFSo8ty1kb2kJ14Ldv4ftWk5aK5BCby12a6iucQ
 Hw77KDGFwfj1DEPBj6FhKQc4IBpCpj71mrf54cDhR6KHJIVAmYhbrGvbYbZ6KadNtSq6 Lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kuya9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 23:57:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28LLcjkA037990;
        Wed, 21 Sep 2022 23:57:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39s6b47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 23:57:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8i9GmRKDBZ/2AEG31VjQ7B+dz4tBt5XIb4tUD6oHx5ER7FhkjklZ/cEiQAnkNDas9tcwiVug0pz3lWThZWMS9qjs0KFF/UtQ52IvRSEXKtL6IeRVeWc9WhlnwMwHMQv0u+CVnsDcUSFKTf01/pM0FNu1K+qtZAxWRA0v/pWkEI08qc/pJl5eCLCPZEXpRu+uxI2kqtc15bZCb/vr/npFAT90/WbeP1KjYfIBjjoK6JF7FaLYSKFMwM/3OFvJnKj+93udxIpQ2cvKZtSjof/v2uj54banUyYFdJ7o+S3o3L598YsjvrOQIS1BNXPDa8qHkH60H/owL/bkJCXZ7REgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyQ7NLMBLCZuFJkE9qqW1ftB0nmYRW+syVDy4jniNSw=;
 b=QzPS15ANzJLgKyZAOn+99Wt4MxzQb9887PX81yqU9qLPVwV8qJKyz4zATaeSwY/RBgX7PwLvv/WPZ7DpgwU3hgNu+/3Cf9D2EbhdLoy35S+68qT6+eCJX8XLeM0xkgkNHUIbJ2WpD8+QjKzOdE6td0b9cg5xPu0xhlZM+aZtgYdBm2rlfYj5gAqdLAw85VY0PLMTmbfD9x6Pnl2yRJ+l9ZknweJmLni5l5K0E8U0iuOCzEfGO3NgZoh+T9mF1eQt8GwLov30VThW7o9hCPz4sJwB12mKMwEmx6n81gJCOtYOSgNnqET56MWmdyxWibdaRK6i9AJX1+C7Tg2LJblviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyQ7NLMBLCZuFJkE9qqW1ftB0nmYRW+syVDy4jniNSw=;
 b=Z4pDAWMl7ys3YOYCCgkQGvqhnaeM/AAI2Uq6RlVY6IR2g0TE4aoMuCad8JI0ls0CQAYlZt1bScNveg18ZL/JIWPAF5+siFosuj/QLzV0k2QXP5glWnJPyk4Ou47+f53g5jbp5lSYXErWRd1AmZmln8Zh/z4+mXDeGlGgsoAbeJA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 23:57:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 23:57:42 +0000
Date:   Wed, 21 Sep 2022 16:57:39 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Liu Zixian <liuzixian4@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Message-ID: <Yyuk83B4VHh+pbFp@monkey>
References: <20220921083440.1267903-1-liushixin2@huawei.com>
 <YytOYH1MSo5cNoB6@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YytOYH1MSo5cNoB6@monkey>
X-ClientProxiedBy: MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6c84e1-761e-4caf-45ba-08da9c2d1240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDbgQ2Yy9OS4FEWCCrr+g10Z3ItfuLbBOl/zGG1yHv2xKJZIAiTyOuwOmqNvfraepFRQEsriHIVBwL0p1QQ2Lmqmsi7BGfjuFp86bar6HubDts/F83TGsI0F1f/g9qTDs7iGyEPmIbSoEZTWCyBMGMcyS708gKa6Hg630U+zClDLkXHQah1OSN4Z4gt/EC7EBjMJhmhYy5EDh7F3o/2tL+ZLqFFb7gV4ohzpmJXU3fAgV8p4U1ZHrKhtabWD+Kc/O+kjoiMNVRSrdcTKiZKfrFFitops7N83aApW0K2RJXVN4Fh0Qn+Nh79u4lUQID8m+IEU1x5jFK/NIqjBZgcR5rAWsiuwwn1EDFrYqvc0jqHGdAoBiBJ8v558c1hZm6C8p+IrTeEM1pVBDu2qniMQ6Q5HYDHCaNaRmHyZOt1Mba0GLx5O5vYIpeiNGlRvrktvayyAObelZnmD7pg5I2pqV53WYD0cnLudS8BNkBnFQWq6GZk9Rk5inAnDkJMHOXFyDJNzVi2RwmZy5sPgWoolnQKamFnkfnifr33rswRraZecik3LkSYU1Y9krdIP3uTJinv9oLbznkmA9FkU2xSRBKWNJ/2InAlqcaNHnYc+uxS5hqk5kiYAi8SqAIw+IYS+pfPfZYVKy1QkJb6+mTr31jHDKiP3q76ERP1oGMDYSWX95erIfd1rBHLjy/0NUhzZRZ3cw5s3vl0saItJukFud88+wjTh+80O8MEHEzCMd6NMg6M1UJY3LGsMIufoaQYN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199015)(9686003)(478600001)(6666004)(66556008)(86362001)(66476007)(33716001)(6916009)(54906003)(4326008)(66946007)(8676002)(44832011)(38100700002)(83380400001)(2906002)(6506007)(316002)(41300700001)(26005)(6486002)(53546011)(66899012)(6512007)(5660300002)(8936002)(186003)(7416002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sLigpcaPhUYFFLVDrCJMVB5qp26kUzN24l8mVbu0Ga4XAT0pb8J9Zb/710o/?=
 =?us-ascii?Q?OdTlqN38uOQGlOM0GVJNLP1M+jZzY8/AYSSK8Tij5kzeD28p5bkbbNOWPxe+?=
 =?us-ascii?Q?zSiMldNjAVZRBqsm1pokleYsMYsTegD02mD2lzyE/e7IwYYm9kFEvdxH7uCp?=
 =?us-ascii?Q?VLL3RVrL2xwyJThBJo/pdC9aWpuTksqjLROtNz67BqhcRXbHEvYVOM8twJms?=
 =?us-ascii?Q?742oNGByMwFjNUJ61AedkBxXimcegDRXJ624Y2XapbkRFCfhj5YWDCHuh7md?=
 =?us-ascii?Q?7UWjcKVj43tfG0UXfUOaPuHJq8gBvE9LDukJEsyk0vj5jpjieWMie027f8K1?=
 =?us-ascii?Q?uyobtQ3VvhpQXWiPjCgYYAF1Ky+SDiE7vhsw8T94h8eUPnorv+qXGnhNHVyA?=
 =?us-ascii?Q?ofhcayHrcVVLUe5HE/XKnzh2fqurDMsrpdCNFtCsPMaMj+WKSjyWiSuf8/wR?=
 =?us-ascii?Q?1Y7zBb62sDX5n3C9buR6Qgqg3GjmeJdmcgqwHqjhWOyoGfcTMT3Bh7cquMOr?=
 =?us-ascii?Q?PF4teqb1KsE134dsxOMFUPBnIx9kd+eNyQm1QoE/b4yHC4zVkaU+ic07Aywm?=
 =?us-ascii?Q?sD0rmkCMcHKbfIPxRDIDFIqANQm2atFLBt+zTI0Sgz/NFPSa1LtOa11/0rLc?=
 =?us-ascii?Q?9h0za2ZuJ3mIt9q7fWLm5BM3GGBb+BzSXYhpKaYzVmmX1ylgt2DkTrOYDybQ?=
 =?us-ascii?Q?nKvw76QUQMDkWkO6hKu8iz16VAuXXi9AmAK59aidQtnaz/sVv5kpxJaJu0hN?=
 =?us-ascii?Q?4x2f96Mop0OoWNA2rPfFIuXs8curOC/v4PKo3buo4ywwFWm5F6T9ZzAThISP?=
 =?us-ascii?Q?/0YGY1dfL9Pm5iNRfGAzQYEYxkYiwL69dXkN8cQBWIUq2U2jt2I9HIER8MGk?=
 =?us-ascii?Q?eNKvMZgrjh3zLSk4KRhPQNmXWUntbulmm3Z0MQ6Qf3j9QHglq5bhT6x4jGTs?=
 =?us-ascii?Q?ZeM9AA7pqnUTLxJYRcPFflo5JTdYg0sY8hG6fVYVGr1ADAgsw6KaZui58wfx?=
 =?us-ascii?Q?OcnshkRJ1sZ1oAX6jSvjcak0krHZ1eeuiU9xxVPapyJjbpnrTxvOiPALPaCY?=
 =?us-ascii?Q?ddnWUuQv4mJ+5XQRDeQGaRxOhIkfeAAGSxNepuRFMptuVqI9jHZAYQmwYHk+?=
 =?us-ascii?Q?yhSlHUR6Xd3WL+MDI9BJNPSpVH422SA4V0bxaIPX1wZY+OMPUNtTFr3FtHMa?=
 =?us-ascii?Q?X5L1gM5mg/uhxwByU/648xXD73pp/KnRJ0kWiYHPDtyKh++IfcSmtoe80UMV?=
 =?us-ascii?Q?WKsFhtt0DiWz37caxKlzvYvncveM9FvaiMHRk0hwD1c4/ErCV3w8CT+333G7?=
 =?us-ascii?Q?TZVNcQPFpQKNxG6xq9fgDwQD9PBueQCBw7wBdwMEpGepaUi978mRKvPPauJY?=
 =?us-ascii?Q?x2M8CS7mMf53nCxP+4EGVUKc+5E8raQmGaXJM4j8e1kaoGYXWvTn31l3iGTc?=
 =?us-ascii?Q?cm75q0NkdnfOkzcdUkw4kgtTC1PRj4pMEfV/fYlkJGDjwpbcypalJS6Kzvw0?=
 =?us-ascii?Q?nRDYMr1ihk60L1T3WtSeqkCNtj4ASQ/XGrik2i5m0PWewR6JIKhK8cubs7b0?=
 =?us-ascii?Q?UXBkl5+7QD3rBlSaDJyifW9qad/kqcVqeeGtt9sVj/2Fh5u6LCHDo30RyRpe?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6c84e1-761e-4caf-45ba-08da9c2d1240
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:57:42.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ldh8rlRdA5t3TbiES0fxJUXyoeW845lF4sr01JOmDhG3TLdwfd53LaajAsWX4uRgBQjqYhUmhv9LMIZkUjr4pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_12,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=656 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209210161
X-Proofpoint-ORIG-GUID: 57IWppuiOQVLMIqcH2NSaOvwb2bLcbls
X-Proofpoint-GUID: 57IWppuiOQVLMIqcH2NSaOvwb2bLcbls
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/22 10:48, Mike Kravetz wrote:
> On 09/21/22 16:34, Liu Shixin wrote:
> > The vma_lock and hugetlb_fault_mutex are dropped before handling
> > userfault and reacquire them again after handle_userfault(), but
> > reacquire the vma_lock could lead to UAF[1] due to the following
> > race,
> > 
> > hugetlb_fault
> >   hugetlb_no_page
> >     /*unlock vma_lock */
> >     hugetlb_handle_userfault
> >       handle_userfault
> >         /* unlock mm->mmap_lock*/
> >                                            vm_mmap_pgoff
> >                                              do_mmap
> >                                                mmap_region
> >                                                  munmap_vma_range
> >                                                    /* clean old vma */
> >         /* lock vma_lock again  <--- UAF */
> >     /* unlock vma_lock */
> > 
> > Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
> > let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
> > the issue.
> 
> Thank you very much!
> 
> When I saw this report, the obvious fix was to do something like what you have
> done below.  That looks fine with a few minor comments.
> 
> One question I have not yet answered is, "Does this same issue apply to
> follow_hugetlb_page()?".  I believe it does.  follow_hugetlb_page calls
> hugetlb_fault which could result in the fault being processed by userfaultfd.
> If we experience the race above, then the associated vma could no longer be
> valid when returning from hugetlb_fault.  follow_hugetlb_page and callers
> have a flag (locked) to deal with dropping mmap lock.  However, I am not sure
> if it is handled correctly WRT userfaultfd.  I think this needs to be answered
> before fixing.  And, if the follow_hugetlb_page code needs to be fixed it
> should be done at the same time.
> 

To at least verify this code path, I added userfaultfd handling to the gup_test
program in kernel selftests.  When doing basic gup test on a hugetlb page in
a userfaultfd registered range, I hit this warning:

[ 6939.867796] FAULT_FLAG_ALLOW_RETRY missing 1
[ 6939.871503] CPU: 2 PID: 5720 Comm: gup_test Not tainted 6.0.0-rc6-next-20220921+ #72
[ 6939.874562] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
[ 6939.877707] Call Trace:
[ 6939.878745]  <TASK>
[ 6939.879779]  dump_stack_lvl+0x6c/0x9f
[ 6939.881199]  handle_userfault.cold+0x14/0x1e
[ 6939.882830]  ? find_held_lock+0x2b/0x80
[ 6939.884370]  ? __mutex_unlock_slowpath+0x45/0x280
[ 6939.886145]  hugetlb_handle_userfault+0x90/0xf0
[ 6939.887936]  hugetlb_fault+0xb7e/0xda0
[ 6939.889409]  ? vprintk_emit+0x118/0x3a0
[ 6939.890903]  ? _printk+0x58/0x73
[ 6939.892279]  follow_hugetlb_page.cold+0x59/0x145
[ 6939.894116]  __get_user_pages+0x146/0x750
[ 6939.895580]  __gup_longterm_locked+0x3e9/0x680
[ 6939.897023]  ? seqcount_lockdep_reader_access.constprop.0+0xa5/0xb0
[ 6939.898939]  ? lockdep_hardirqs_on+0x7d/0x100
[ 6939.901243]  gup_test_ioctl+0x320/0x6e0
[ 6939.902202]  __x64_sys_ioctl+0x87/0xc0
[ 6939.903220]  do_syscall_64+0x38/0x90
[ 6939.904233]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 6939.905423] RIP: 0033:0x7fbb53830f7b

This is because userfaultfd is expecting FAULT_FLAG_ALLOW_RETRY which is not
set in this path.

Adding John, Peter and David on Cc: as they are much more fluent in all the
fault and FOLL combinations and might have immediate suggestions.  It is going
to take me a little while to figure out:
1) How to make sure we get the right flags passed to handle_userfault
2) How to modify follow_hugetlb_page as userfaultfd can certainly drop
   mmap_lock.  So we can not assume vma still exists upon return.

-- 
Mike Kravetz
