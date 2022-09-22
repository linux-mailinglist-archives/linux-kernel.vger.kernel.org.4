Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5754A5E589F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiIVCgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiIVCf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:35:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C5FAC241
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:35:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LMwfC6011434;
        Thu, 22 Sep 2022 02:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=fkgWt/UOyYjAPx47SEYTvQMNXAipQ4b7TH2Is4f4jt4=;
 b=0MHU/rjiRLcGrGkWumr+PaCwfQ3n0jaTHInwFA4kc/pKu5jtoRo9LWf9J7P9YUd6zLfd
 reJSndvXJR4sGkzl/fuuCEr07SJxD6Y80sFhH+cdTzJcVq2HxUIOghqp+ax2ZBfVQUFE
 lwOWHUSmXPLe6nlzCXne7Lsr3S5LOfKroSMP3Zd62IBljzqk76VixXfENbt0utXFM9N3
 uvz7ETgWQe29ybKPnrX6SgHtMq0lhR+H4i0uYWQG4tKAHzedyszylyaYJYlLsBYeaPdU
 9qAB8WNG5kZX3TPh2NLk9TLhzVxwFgNhXtGkhuhkNhmhFF+1RgSECv2j4T6d3WdYRPVk oQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rm0x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 02:35:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28M10JLl037823;
        Thu, 22 Sep 2022 02:35:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39s97e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 02:35:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azhVAMeKYjc5pzmXLuOABOAYZcgxCEtKMThjE0w2txw4YH+qv/lMKbafWp2nod6X2gaZ9CTVzv7yJyda2SkztiL8S4GjUUcNATb4zVOBZQRemhYAhvU+HopFPWLdNzaMqatCgSBwdFs3d0a7crL5hFMd0yU4y7rHHY48poVkz+OwHZmzEaxGgMW3eIst0A2gTkEUzzvADAC81udCnyQlm9wvLmsZHGMDWVYJ3Y+Dj0o1SNfJD4QIDqSRNtEGtcf4NapinbHdrpiuJCsOAU5OtkPMuimvMk7Jvrhowt0P7WN+hQYqx07EA83eRnUEbyX+OlzmPvrm4SF3b93PDVmyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkgWt/UOyYjAPx47SEYTvQMNXAipQ4b7TH2Is4f4jt4=;
 b=Dg/2dZM9tOCsa/1BECqK/xJqsrlUSiPhBQQYO+z4ResIaNtGeD/cji//rdKj73FEB9LsfIiVXXGtJtGEeH9oY0hx/4qJ/GzTapd2EqOuyRmeF6CohB+VgJZ0Rec0Ueu7xRkriNq6RU11mbt/fV/qVvDSbTSiXN82oylzln0wpfhSv8UURr+pBJhfiTKKAhVdWl7xJvNyOwbTQeQVW/nP+h74Zrj96NmA5pGzynSnUlVBvIj/9lD4qbQ690dnPs7/pcKV1eKaW2MhMKcc54O0Co+xlGLKfNDgNX6qSKLVy7hnAoMQFa0MQrvU4z9d3vxGBjsMdhtOyJ3V0oy8POE89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkgWt/UOyYjAPx47SEYTvQMNXAipQ4b7TH2Is4f4jt4=;
 b=NBRyv6ZEuYEqjMOgUhQkYpPXfpjdMh0T/CbQNNHdGNDe9+v2VfaJX7BPEHzVOQCH7MK/gbLP5KDEdgDZ+2bieIA/YXPxP9rZWL78UHu6GZYO3ujm0yEgS5GQX0ETWKxtMDsMvogOe427P7VHnAiw67cErMC2OhX7bvwRPBzILBA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 02:35:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 02:35:36 +0000
Date:   Wed, 21 Sep 2022 19:35:33 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Liu Zixian <liuzixian4@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Message-ID: <YyvJ9Q00JDpSoqJO@monkey>
References: <20220921083440.1267903-1-liushixin2@huawei.com>
 <YytOYH1MSo5cNoB6@monkey>
 <Yyuk83B4VHh+pbFp@monkey>
 <f48ba16b-0c2c-fa93-c8e0-e6c2adf913aa@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f48ba16b-0c2c-fa93-c8e0-e6c2adf913aa@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:303:b6::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 1348a1e1-81ee-492e-cf3c-08da9c43211d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBZ9rJH2ju6ecSCAPvhlinuu36kK5LrkVP9BqpdoXrLz0l7ZM2W83lBAbtA8Q7OapvxYWyhrrrhaTBOTTEAsewQKEXofko8nJ68VF+TyhIunkA/foQsfP2yIElM9+5rzgsZIlQSF6Bva7ZspXe5y0e9bu6d/13aQzc5mncph3JPoMkF1kTA3wCDRYqmo1GRkQhf6K0HyU/Q5RgRFKsRX6qc3I7bKPjHiKOwAEC6n73Gb1wJIH4H9i7bFZrf8fy5Ch/EFUH76ccac/Y3WTUnGGLH9N06/prC7ztWxvtnWQ9DzgHraVk//SAiUHTEJRLZTO9Ozh1NG+Gn3a72AQ3tRfnm3D8dvEfJqy37NZe7teEimp7Z5PO44dwROZHHnEW5mrp7fLAtpc/ZugnN1v9nqVQ2aDZzZKWdlHFEALi3AqGCAqLagDl5+YhiZ4iiKl8XQ62TG8Mc4LDsitFRW3jIMrWp2DfcKTxhfI7BbPcqhbn5hT1s7kOKjyNyGmKMNYCFO37EWU6FLI+NUixkVaOBDZWePqqY4kN1A6uUKTZBYHVggzu45EVGCbEuyYV3xU4XRYrtzulnTOBtDeP/eAkT/H4vtn+XRhh7Pwy9/xaR67Qq52hz47klokCQR0lQp+Ie5LpRVVns8GHE9piQ4VrN8GpVeUumBGbQFJmx7VSnseGsnuSWLemL70X9Y6/rTGoqjw1bJI0tvtAOWzgV+JVDy0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(2906002)(54906003)(6666004)(6916009)(6506007)(53546011)(86362001)(7416002)(478600001)(6486002)(8936002)(5660300002)(41300700001)(44832011)(186003)(26005)(6512007)(9686003)(38100700002)(66899012)(33716001)(66476007)(4326008)(316002)(66556008)(66946007)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r39Tnyv+i0OQcEWIHoMGGetqPN9p6pCyHd/NnPMVbMw0uO9Kx3QniIfU1kmQ?=
 =?us-ascii?Q?0BhyDKf2i8Si7zARnZ5gmPvPjrLv7XRHS2Eg1KXpMZ9RLrdDjF3rmMnYg0ha?=
 =?us-ascii?Q?Ui31MnkBDJqSnqjI3RKN04foMlv4u/TkH5HklT5PGatNNE1zlVPJNVTJiqoN?=
 =?us-ascii?Q?Up9I5+vzkppuU1pl8PkrjWvCw7Dic0DRdEwxBISjTXRzoVM2X8AMozEl4rA2?=
 =?us-ascii?Q?xdcA3w7CzEWGt3a0jsqkwpsgyaSeNsuug/psJ/S8nmtXJoGHTP4TLbPLhEUu?=
 =?us-ascii?Q?LgN42FHRzHUEgyExxLEJQbB0xmqquxAsJKJ60QaSm8BY5WxBDk3ogFzbA6Dn?=
 =?us-ascii?Q?bXcYMrtV3J3Dt/FS5Y9nllUsiNn90UFPnp/1RZzv5lnmrvuwRKTtynWrgU77?=
 =?us-ascii?Q?mKj0s57tmc1q2W+vQnPiqirkhX88Wt9SmNMapuXz0VKiKZGlMfHBP1eUQb1t?=
 =?us-ascii?Q?cne8JuT/HtLyXE7SfY0H6N3tvyfQCQSnKqrgBYhxBPa42WOYGM7gkPdc9cVd?=
 =?us-ascii?Q?mK1CimOSOb01Pcwx2g1MxE9m49kZxlkRJEp1ehQv9QLAuLKN3v4iifPy+in/?=
 =?us-ascii?Q?uj+F8/0pWtqapxSa/pKz3+JqVjMLcv3JKMY0IX5TENwPrt680mVjkpNdTmAI?=
 =?us-ascii?Q?jtvC+ZTbCU9MY4aVUlQeaacIV7uaGlV9QRB1NL2YxejwhPR0htLQNvu3Vntm?=
 =?us-ascii?Q?8vr45Kl92NefmlXYL+Fmanhd08OiTu7NMzU5axWWJNn0Vofjij492oBMwkrp?=
 =?us-ascii?Q?Y4/93jBnyUw91IL9LT/dXJsHVYt/7/IWNSfJYCIW0QZT8Yd2hsg5ZMkiCCqj?=
 =?us-ascii?Q?JEsFCf1qpwLncND8Tne8YZT7NupoEV5M84klfOkbTIdZVi34rFCbjvf57149?=
 =?us-ascii?Q?phqcbKEfHSPmj2VRhnf4bz8XuTIyhrTA+6Xjy+pOBqBsNPc2CFx5NqMO0kzI?=
 =?us-ascii?Q?x+yO3YwuFZHAnXCzNqRpk15S5oVHli5rgBfGqgxnuHSWoyvOr3hlPmam/fHp?=
 =?us-ascii?Q?yBqjQ/7iSueYVeZgwZVrGXlXynv/Rsrf6dIJuFoS4mzWwG1coGgGezyIYIyl?=
 =?us-ascii?Q?QOYMaESviQ8OEzlfcu49frQ2Zi9oIXcO6F/MMdXg92nVyMZr6l0HIyQmECBd?=
 =?us-ascii?Q?A3Jga7bHhneEBFQpx4HzTQUwDmeZUjQ4Jr/fPP0MRI5cWBsa/Aqxz+1IQVD5?=
 =?us-ascii?Q?YTIjvBHFpyj4sEQw292z0S2LGX/rbebF4SlcDfivW9aFU/wGjy2o7u8kfQc4?=
 =?us-ascii?Q?j2EcOw0XdaSgroZ6ljMeN/xeATvBsQl9BMPpUGnrsP3MlhrrmAo7d0RZr6s3?=
 =?us-ascii?Q?d8Ubhg/0M8pUCZilTnkYLwkNu2JbWxg2ICZHW06N9ONcGezBvZkvr+kNJBOv?=
 =?us-ascii?Q?QqkGH/cl1q7tjF6Hl3p2/nrAed+W6bCqbJAYpzBYPugRyBSgjg276R+kHBq0?=
 =?us-ascii?Q?grYwm/d4I+eM5/adIRGhOWeU1FcpxJHRz/Fbc9HqieU+J4gbLrDbGSyWz4RC?=
 =?us-ascii?Q?nvOZ/pnY2XOh53b50tliLoP2Jomg48R3Zl7dzjocsc980Tfq7oWji0vUuIEt?=
 =?us-ascii?Q?BYLvNzVHzj8U40+kguUv1lqNiuj0T6iAYcNLxdjE8cQAMTxlPYVJC/7uTn3m?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1348a1e1-81ee-492e-cf3c-08da9c43211d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 02:35:36.0408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBsq5Mfy50P5TWw5mgBnMLb5xEjkHSXcj/7vlfZ1E353gCjCmO40IsFd7b8sDQZRrEV8qIXTvo2AdDJ5ZQ+xTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_13,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=612 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220014
X-Proofpoint-GUID: iTupU0kg0MltR2WuHz1DUmzv4aNi18D8
X-Proofpoint-ORIG-GUID: iTupU0kg0MltR2WuHz1DUmzv4aNi18D8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/22 17:57, John Hubbard wrote:
> On 9/21/22 16:57, Mike Kravetz wrote:
> > On 09/21/22 10:48, Mike Kravetz wrote:
> >> On 09/21/22 16:34, Liu Shixin wrote:
> >>> The vma_lock and hugetlb_fault_mutex are dropped before handling
> >>> userfault and reacquire them again after handle_userfault(), but
> >>> reacquire the vma_lock could lead to UAF[1] due to the following
> >>> race,
> >>>
> >>> hugetlb_fault
> >>>   hugetlb_no_page
> >>>     /*unlock vma_lock */
> >>>     hugetlb_handle_userfault
> >>>       handle_userfault
> >>>         /* unlock mm->mmap_lock*/
> >>>                                            vm_mmap_pgoff
> >>>                                              do_mmap
> >>>                                                mmap_region
> >>>                                                  munmap_vma_range
> >>>                                                    /* clean old vma */
> >>>         /* lock vma_lock again  <--- UAF */
> >>>     /* unlock vma_lock */
> >>>
> >>> Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
> >>> let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
> >>> the issue.
> >>
> >> Thank you very much!
> >>
> >> When I saw this report, the obvious fix was to do something like what you have
> >> done below.  That looks fine with a few minor comments.
> >>
> >> One question I have not yet answered is, "Does this same issue apply to
> >> follow_hugetlb_page()?".  I believe it does.  follow_hugetlb_page calls
> >> hugetlb_fault which could result in the fault being processed by userfaultfd.
> >> If we experience the race above, then the associated vma could no longer be
> >> valid when returning from hugetlb_fault.  follow_hugetlb_page and callers
> >> have a flag (locked) to deal with dropping mmap lock.  However, I am not sure
> >> if it is handled correctly WRT userfaultfd.  I think this needs to be answered
> >> before fixing.  And, if the follow_hugetlb_page code needs to be fixed it
> >> should be done at the same time.
> >>
> > 
> > To at least verify this code path, I added userfaultfd handling to the gup_test
> > program in kernel selftests.  When doing basic gup test on a hugetlb page in
> 
> Just for those of us who are easily confused by userfaultfd cases, can you show
> what that patch is? It would help me understand this a little faster.

The ugly (just throw code at it to make it work) diff is below.  All I did was
add the sample code from the userfaultfd man page.

With that change in place, I just run 'gup_test -U -z -m 2 -H'

> Actually I'm expecting that Peter can easily answer this whole thing. :)

diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index e43879291dac..491424d0a039 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -8,8 +8,11 @@
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/syscall.h>
 #include <pthread.h>
 #include <assert.h>
+#include <poll.h>
+#include <linux/userfaultfd.h>
 #include <mm/gup_test.h>
 #include "../kselftest.h"
 
@@ -48,6 +51,75 @@ static char *cmd_to_str(unsigned long cmd)
 	return "Unknown command";
 }
 
+static void *fault_handler_thread(void *arg)
+{
+	static struct uffd_msg msg;   /* Data read from userfaultfd */
+	static int fault_cnt = 0;     /* Number of faults so far handled */
+	long uffd;
+	static char *page = NULL;
+	struct uffdio_copy uffdio_copy;
+	ssize_t nread;
+	size_t page_size = 2 * 1024 * 1024;
+
+	uffd = (long) arg;
+
+	if (page == NULL) {
+		page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		if (page == MAP_FAILED)
+		exit(1);
+	}
+
+	for (;;) {
+		struct pollfd pollfd;
+		int nready;
+		pollfd.fd = uffd;
+		pollfd.events = POLLIN;
+		nready = poll(&pollfd, 1, -1);
+		if (nready == -1)
+			exit(1);
+
+		printf("\nfault_handler_thread():\n");
+		printf("    poll() returns: nready = %d; "
+			"POLLIN = %d; POLLERR = %d\n", nready,
+			(pollfd.revents & POLLIN) != 0,
+			(pollfd.revents & POLLERR) != 0);
+			
+		nread = read(uffd, &msg, sizeof(msg));
+		if (nread == 0) {
+			printf("EOF on userfaultfd!\n");
+			exit(1);
+		}
+
+		if (nread == -1) {
+			printf("nread == -1\n");
+			exit(1);
+		}
+
+		if (msg.event != UFFD_EVENT_PAGEFAULT) {
+			printf("Unexpected event on userfaultfd\n");
+			exit(1);
+		}
+
+		printf("    UFFD_EVENT_PAGEFAULT event: ");
+		printf("flags = %llx; ", msg.arg.pagefault.flags);
+		printf("address = %llx\n", msg.arg.pagefault.address);
+
+		memset(page, 'A' + fault_cnt % 20, page_size);
+		fault_cnt++;
+
+		uffdio_copy.src = (unsigned long) page;
+		uffdio_copy.dst = (unsigned long) msg.arg.pagefault.address &
+						~(page_size - 1);
+		uffdio_copy.len = page_size;
+		uffdio_copy.mode = 0;
+		uffdio_copy.copy = 0;
+		if (ioctl(uffd, UFFDIO_COPY, &uffdio_copy) == -1)
+			exit(1);
+
+	}
+}
+
 void *gup_thread(void *data)
 {
 	struct gup_test gup = *(struct gup_test *)data;
@@ -94,7 +166,11 @@ int main(int argc, char **argv)
 	int flags = MAP_PRIVATE, touch = 0;
 	char *file = "/dev/zero";
 	pthread_t *tid;
+	pthread_t thr;
 	char *p;
+	long uffd;
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
 
 	while ((opt = getopt(argc, argv, "m:r:n:F:f:abcj:tTLUuwWSHpz")) != -1) {
 		switch (opt) {
@@ -230,6 +306,18 @@ int main(int argc, char **argv)
 		exit(KSFT_SKIP);
 	}
 
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd == -1) {
+		perror("uffd open");
+		exit(1);
+	}
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
+		perror("uffd ioctl API");
+		exit(1);
+	}
+
 	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, filed, 0);
 	if (p == MAP_FAILED) {
 		perror("mmap");
@@ -237,6 +325,20 @@ int main(int argc, char **argv)
 	}
 	gup.addr = (unsigned long)p;
 
+	uffdio_register.range.start = (unsigned long)p;
+	uffdio_register.range.len = size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
+		perror("uffd ioctl API");
+		exit(1);
+	}
+	ret = pthread_create(&thr, NULL, fault_handler_thread, (void *)uffd);
+	if (ret) {
+		exit(1);
+	}
+	
+	sleep(5);
+
 	if (thp == 1)
 		madvise(p, size, MADV_HUGEPAGE);
 	else if (thp == 0)
-- 
Mike Kravetz
