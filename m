Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0FB5B7DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiINAvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiINAvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:51:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EE9371AF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:51:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DN78cB011169;
        Wed, 14 Sep 2022 00:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=6AdSjsA5JzzekjJLCfLw4wXiENMCcR+4enFEou1F9jE=;
 b=CromyJJ4QPVJnUpFLNxODvZHOsmhPuE+1ggXzCRmxlPkbQk6G37j0c6gJapLRNiFvAne
 NK4Xp/BuSaq646wJhjeOmIUJ7YPTwNxfzOd5BhrkXKghjoCIvEJUtBuQQCW7VU6HB+3r
 BDcIg898cKXSqTnjBas/hO6P9Z8CkzziSr9Pn1Amun+uR3iqGJ5cM2VP8I0GsfHgnrvv
 aNW4xOAqILLIqMykOnHWbxWR7HQfGIhiZC/6swvMcEDcZzG5CAhIpHbV2rbCUePwGtom
 kd2PyZOiK/uLGdUmMVRrzMgTd+07tN2lrwj17q24d5CaOdqPhwZyAx04RJkXymhuGtix Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyp8r34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 00:50:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28DLR5in007439;
        Wed, 14 Sep 2022 00:50:22 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy5dfttf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 00:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1m0ifzwwcUqYwu11EYj9/5ShEWM1bjJGo9QU85nC+WUtvE/NKPyO1C9JOpz+h3IYceQleQh+Cm+j/XVLP/V5lY39gAYpxwSsQ2UsrcYeg+czRFwZXb5EjeROp+3JF/aPbkRkCgeTsXnJifN0ajEpQEiifDOf56Sf4tjNvWQPo8/Hxvz1Q+PhK0lAaxOqVixV+LhuC5yc0SbvVqHnco5FT0yDpmqcEu+JoysdzCjo8qLunTWRNwL7T+NJIBwZvSQ2qVJD5Yc3sSQcMxqkfxlsydzSGge5UdQfyjDRWcKkZoJOnl1z+ug3LMzy/aJozNdXkVSSBLij+7XKEfhQ0qQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AdSjsA5JzzekjJLCfLw4wXiENMCcR+4enFEou1F9jE=;
 b=ByQ2NBz0fbWdKJkOqWqbgPD9kgKQ/vE7plyt8TOwQaY5FvLFU31j/qxEC6fszerWtl5ottynJt+3XAWWFmmGQV6T1iK0Mz/hTo+i6sv2RKDBAiLxNiyNpNvQsuKZTyGddjPmje55OAwjQqlpttOfVV8pmSwR5Xh309Gd8R85tVXbm8uNiYNHVq/FwudHcCJUT0RHFGY1SanjfCd9xWDxUkCBDM5rCD+uYOwmP2ZkeH8XS5uK57vtyHXH4qcPPGMvTgMqbB/ILGYZP1DvS4WxgBI74+AfCCSpS7H22+meMbKSdUkvaRaADpZWgV0Y0zXDFWePIVGcSR2vR/bbDRXdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AdSjsA5JzzekjJLCfLw4wXiENMCcR+4enFEou1F9jE=;
 b=sW6Vs9Wv7oJgTt37gl4zCk/nAXIxFNtfoKop1KuHqfzPg4VxBB/ru6Jszh/zNj45j0QGmNxbWcumR3TWn5ylM8/qgvQWcynp15N0VdhOVw+3j67T2kOUcA7zTWh5NMg0Idf0LWda55H4t5yjT29ziHQGfjDWhKPPWiIr2VYP1p8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ1PR10MB5979.namprd10.prod.outlook.com (2603:10b6:a03:45e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 00:50:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 00:50:19 +0000
Date:   Tue, 13 Sep 2022 17:50:16 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] hugetlb: use new vma_lock for pmd sharing
 synchronization
Message-ID: <YyElSFtbJ32VRLh6@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-9-mike.kravetz@oracle.com>
 <08edc08e-08ab-0706-3c8d-804080f37bd7@huawei.com>
 <YxKMy3sDsWPEOMMJ@monkey>
 <1baff74d-d38f-6139-2548-19c0c8f87649@huawei.com>
 <Yx+6fbHUcInz4R+j@monkey>
 <a879ee95-918e-00f7-b04f-e9dba156902c@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a879ee95-918e-00f7-b04f-e9dba156902c@huawei.com>
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ1PR10MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b3b2cf-7e0e-4327-527f-08da95eb18da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPFHzllahqKh6nsU03vg+BRd6o8vOln5rVViAH6eL/LBZB7NslPFGRt8snoOHuHBNWYJcbvP9LWhTlJgu53vC14toSU7n/4C3cOma8iWEVv5VYvrbje/ygO9RcLgnd9dnioMXdkvK5k2W1Je8BvP3YVp1QbO4LzS0Y+dFJrLzvXueOasOGxWCxMNqj/516vA1WgzabJ1CO6UHDbL35NYJ0rVHwxgCwv1q9vSFT8CpdNQ4WYMKMs8fOAPPapcZn8BGxwDqJl0GLH0Nttl8LTegN14Nq/xkwtBfg6ovClX+jN/yVpZ5hTkkKpZ7ozcJRR56Yj1a6w1UYVK2mCx+ULE/Ub8wQftGpw/n2LXDm5uMUZvKIhflsHmJpD9BwSWozZ+yBK5HENcRpDcg0Zo9v7WlL+Qyop8AXtuDqbQ8ztVVpbZ5QH5oov/H/7ivz8VkDJxw1BkSgVoIk/t0IXwidRkpl13ro0CFFB+CIx3IC/rcQUWb0nZ7YSKg6I2sRPtr/RSJqY3/NsbhyfFEUvuikwxEZr6eeUjUEu7Xbk/+B58BBg2COhor18gsShMfhwRHsG0NxDz2FjF+OAyR1k0GpyB1MHTly/bnNoIWq06OZ+J1rRmkDeuc+KcJLmoX/eKeyp5//dx7Sw0hHOe2s/g8wI6O3pdf1QgWblX7L48whkTEW1O/cCcBcePnorRZraguc4mxW/SUvsInU1w/a0PJSy5yFFKat8XHMlV/brkzw/XqTYB8Zhgm8TRLEisO8dV2+Ta
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199015)(66946007)(54906003)(6486002)(26005)(86362001)(9686003)(83380400001)(5660300002)(44832011)(8676002)(6916009)(2906002)(66476007)(41300700001)(53546011)(316002)(4326008)(478600001)(186003)(6512007)(38100700002)(6666004)(7416002)(8936002)(33716001)(66556008)(6506007)(134034003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cHQMx97mGB1BjByHAUFDWAZV0c4o8QxDvu5hTn9ust3iB45SNwbHyclgJj4P?=
 =?us-ascii?Q?NpxR9HZUg7D3oiX55oEa/9E80vbFCYW+JqM2fPWWVcjkEfxEeeauR0XSebrT?=
 =?us-ascii?Q?tYb9E+YZT5hE2OstMSHfpdwDy3rXqhKO9SZo0cRnr0s1L0dgyChHoz/wi4+0?=
 =?us-ascii?Q?lGfbhvM/1sKj+FhdzOl952+wou9UhsY03HIPgAwZk1n2/rVGo6kR14zOekW5?=
 =?us-ascii?Q?pQbefZS5W3TDeHVCs/1SfgxMeiU4/KTfN+lOTVv4h6gOKfFett5oTl7/GChL?=
 =?us-ascii?Q?XT0S8xJfcWSa3Xn7P/gsys+Pm11vSvbpDCP83TzX0/Hs+eX5a27VGkry5zMk?=
 =?us-ascii?Q?6nHjxYBQgjhJuWuojH81DFUnHXeYXBUahElC0jjdrYN3tijKSWFQE8Xhb43g?=
 =?us-ascii?Q?a619maggT8AxuSwDP5GBlZjlz7WFtYuJQkeBfjim4YDaK4vhhEABydpi8Qf/?=
 =?us-ascii?Q?8kLaVPIpiMb4fbN1WH85lc+u+4ycrjaazDMOpSfaFEgzsPIwfi8oBdIYc8jL?=
 =?us-ascii?Q?qYcFxT55BsJIy69oJUHrDwly1ct7kBCkd/zTN34LsFAWDT7JzAJFcTTR+2Gn?=
 =?us-ascii?Q?99T6x90VTIMCNOKcOzO80DiLOuS1wnpEio117k8HfhRLLN900Fi1hKVUwZAd?=
 =?us-ascii?Q?yFz0j+x9HwEII0kxiQBnagIl8wq6qRR1uc7lxJiGo65tsWt0i/lAGnv0UYms?=
 =?us-ascii?Q?LXI8k0jjqndz77xt3mUDqDQZ55hauKVllSDrVjkluzErwk4QgcpLJOZnMWPa?=
 =?us-ascii?Q?VfHO/lZYrMjbgOWisfDO3k7nd3F/fegs8CgmFVlO0N4BSDbjS+I6zT3ay0bo?=
 =?us-ascii?Q?jzELw32d778vdxk3gfrZh04U6Me1NCGl/AcJhEZJ2qsslZUbJqGH/q9400yr?=
 =?us-ascii?Q?PJoxW3k1kg+GZybmU0bpTjCcIDLJ9Nt14Oj7WtQoXoBJnNcHiEyh5fVoaz2E?=
 =?us-ascii?Q?OaW6YYaiW6zoKTE4UP+tv3/+fC5YTV+ojDwgh6E7RifEBffxHAh1key9FSNu?=
 =?us-ascii?Q?yVidNyYuwMyBhhl5NWQSNRtoKEgzAfoDsZshyURYhc/855JyO/ARXuhwYXl0?=
 =?us-ascii?Q?uj/XZYiOMp1ai/xkycCYiwUUOZEJ3y17EUjUV0Zgm1q95LIaTHgnBazrwRB6?=
 =?us-ascii?Q?ZC4Xx+qS/PvGMT9qzDRAMobVmg5mWk9SMMiskaUGmZjDMYo6XD9SPQC26JVZ?=
 =?us-ascii?Q?oB6QjSZnWu3q052c4NhScn4rKRiwrJvwmZy/LWEp6aZYDRWNAiIrqlxdTMAR?=
 =?us-ascii?Q?0I2F1KYQz0QVxeqekfNnFNGgvq3bTOnHamOVhxd+k1CnJtX86Yp9ZLCHimgZ?=
 =?us-ascii?Q?t1mboQk7xGamxgpgrx09t2X4A+xmeFu+fpBQBRaJYe70S6a4uyjbE2DqXj+P?=
 =?us-ascii?Q?9niS6w1+Pt7HO+lPzjPEdWrj8uVPWZ24TMtl7j+E6H/xYRXGKND9ppbmbDDB?=
 =?us-ascii?Q?5rd4D6qYB3Xu5ErlZ2yLj7x5sejZU767oXyqOxTRWwSDE19+SZ+FNmPsXK8E?=
 =?us-ascii?Q?fg1CtJcwy8SiDuhtKgl2o+6QlMWe3HbHCZp/mNtgyprkwuz+oPhaw9EPTemV?=
 =?us-ascii?Q?e/hTjA4lkPi4T1qJNrGrQKQ3/4KygH10JplTVlLowGNEUHx4QRzajtMtTpe+?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b3b2cf-7e0e-4327-527f-08da95eb18da
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 00:50:19.5660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhojkEdQ7x+S9emTXJGEbuhuacFl6PoYlTAmy6DCZQikp3OXJ5lAL7ns0SYlkjPwIBpHyca9rVWCAuh4tCiokA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_11,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140002
X-Proofpoint-ORIG-GUID: AcEn8eyzBg8AYNaELapQDQ3zSoUmHZ0o
X-Proofpoint-GUID: AcEn8eyzBg8AYNaELapQDQ3zSoUmHZ0o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/22 10:14, Miaohe Lin wrote:
> On 2022/9/13 7:02, Mike Kravetz wrote:
> > On 09/05/22 11:08, Miaohe Lin wrote:
> >> On 2022/9/3 7:07, Mike Kravetz wrote:
> >>> On 08/30/22 10:02, Miaohe Lin wrote:
> >>>> On 2022/8/25 1:57, Mike Kravetz wrote:
> >>>>> The new hugetlb vma lock (rw semaphore) is used to address this race:
> >>>>>
> >>>>> Faulting thread                                 Unsharing thread
> >>>>> ...                                                  ...
> >>>>> ptep = huge_pte_offset()
> >>>>>       or
> >>>>> ptep = huge_pte_alloc()
> >>>>> ...
> >>>>>                                                 i_mmap_lock_write
> >>>>>                                                 lock page table
> >>>>> ptep invalid   <------------------------        huge_pmd_unshare()
> >>>>> Could be in a previously                        unlock_page_table
> >>>>> sharing process or worse                        i_mmap_unlock_write
> >>>>> ...
> >>>>>
> >>>>> The vma_lock is used as follows:
> >>>>> - During fault processing. the lock is acquired in read mode before
> >>>>>   doing a page table lock and allocation (huge_pte_alloc).  The lock is
> >>>>>   held until code is finished with the page table entry (ptep).
> >>>>> - The lock must be held in write mode whenever huge_pmd_unshare is
> >>>>>   called.
> >>>>>
> >>>>> Lock ordering issues come into play when unmapping a page from all
> >>>>> vmas mapping the page.  The i_mmap_rwsem must be held to search for the
> >>>>> vmas, and the vma lock must be held before calling unmap which will
> >>>>> call huge_pmd_unshare.  This is done today in:
> >>>>> - try_to_migrate_one and try_to_unmap_ for page migration and memory
> >>>>>   error handling.  In these routines we 'try' to obtain the vma lock and
> >>>>>   fail to unmap if unsuccessful.  Calling routines already deal with the
> >>>>>   failure of unmapping.
> >>>>> - hugetlb_vmdelete_list for truncation and hole punch.  This routine
> >>>>>   also tries to acquire the vma lock.  If it fails, it skips the
> >>>>>   unmapping.  However, we can not have file truncation or hole punch
> >>>>>   fail because of contention.  After hugetlb_vmdelete_list, truncation
> >>>>>   and hole punch call remove_inode_hugepages.  remove_inode_hugepages
> >>>>>   check for mapped pages and call hugetlb_unmap_file_page to unmap them.
> >>>>>   hugetlb_unmap_file_page is designed to drop locks and reacquire in the
> >>>>>   correct order to guarantee unmap success.
> >>>>>
> >>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>>>> ---
> >>>>>  fs/hugetlbfs/inode.c |  46 +++++++++++++++++++
> >>>>>  mm/hugetlb.c         | 102 +++++++++++++++++++++++++++++++++++++++----
> >>>>>  mm/memory.c          |   2 +
> >>>>>  mm/rmap.c            | 100 +++++++++++++++++++++++++++---------------
> >>>>>  mm/userfaultfd.c     |   9 +++-
> >>>>>  5 files changed, 214 insertions(+), 45 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> >>>>> index b93d131b0cb5..52d9b390389b 100644
> >>>>> --- a/fs/hugetlbfs/inode.c
> >>>>> +++ b/fs/hugetlbfs/inode.c
> >>>>> @@ -434,6 +434,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >>>>>  					struct folio *folio, pgoff_t index)
> >>>>>  {
> >>>>>  	struct rb_root_cached *root = &mapping->i_mmap;
> >>>>> +	unsigned long skipped_vm_start;
> >>>>> +	struct mm_struct *skipped_mm;
> >>>>>  	struct page *page = &folio->page;
> >>>>>  	struct vm_area_struct *vma;
> >>>>>  	unsigned long v_start;
> >>>>> @@ -444,6 +446,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >>>>>  	end = ((index + 1) * pages_per_huge_page(h));
> >>>>>  
> >>>>>  	i_mmap_lock_write(mapping);
> >>>>> +retry:
> >>>>> +	skipped_mm = NULL;
> >>>>>  
> >>>>>  	vma_interval_tree_foreach(vma, root, start, end - 1) {
> >>>>>  		v_start = vma_offset_start(vma, start);
> >>>>> @@ -452,11 +456,49 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >>>>>  		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> >>>>>  			continue;
> >>>>>  
> >>>>> +		if (!hugetlb_vma_trylock_write(vma)) {
> >>>>> +			/*
> >>>>> +			 * If we can not get vma lock, we need to drop
> >>>>> +			 * immap_sema and take locks in order.
> >>>>> +			 */
> >>>>> +			skipped_vm_start = vma->vm_start;
> >>>>> +			skipped_mm = vma->vm_mm;
> >>>>> +			/* grab mm-struct as we will be dropping i_mmap_sema */
> >>>>> +			mmgrab(skipped_mm);
> >>>>> +			break;
> >>>>> +		}
> >>>>> +
> >>>>>  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> >>>>>  				NULL, ZAP_FLAG_DROP_MARKER);
> >>>>> +		hugetlb_vma_unlock_write(vma);
> >>>>>  	}
> >>>>>  
> >>>>>  	i_mmap_unlock_write(mapping);
> >>>>> +
> >>>>> +	if (skipped_mm) {
> >>>>> +		mmap_read_lock(skipped_mm);
> >>>>> +		vma = find_vma(skipped_mm, skipped_vm_start);
> >>>>> +		if (!vma || !is_vm_hugetlb_page(vma) ||
> >>>>> +					vma->vm_file->f_mapping != mapping ||
> >>>>> +					vma->vm_start != skipped_vm_start) {
> >>>>
> >>>> i_mmap_lock_write(mapping) is missing here? Retry logic will do i_mmap_unlock_write(mapping) anyway.
> >>>>
> >>>
> >>> Yes, that is missing.  I will add here.
> >>>
> >>>>> +			mmap_read_unlock(skipped_mm);
> >>>>> +			mmdrop(skipped_mm);
> >>>>> +			goto retry;
> >>>>> +		}
> >>>>> +
> >>>>
> >>>> IMHO, above check is not enough. Think about the below scene:
> >>>>
> >>>> CPU 1					CPU 2
> >>>> hugetlb_unmap_file_folio		exit_mmap
> >>>>   mmap_read_lock(skipped_mm);		  mmap_read_lock(mm);
> >>>>   check vma is wanted.
> >>>>   					  unmap_vmas
> >>>>   mmap_read_unlock(skipped_mm);		  mmap_read_unlock
> >>>>   					  mmap_write_lock(mm);
> >>>>   					  free_pgtables
> >>>>   					  remove_vma
> >>>> 					    hugetlb_vma_lock_free
> >>>>   vma, hugetlb_vma_lock is still *used after free*
> >>>>   					  mmap_write_unlock(mm);
> >>>> So we should check mm->mm_users == 0 to fix the above issue. Or am I miss something?
> >>>
> >>> In the retry case, we are OK because go back and look up the vma again.  Right?
> >>>
> >>> After taking mmap_read_lock, vma can not go away until we mmap_read_unlock.
> >>> Before that, we do the following:
> >>>
> >>>>> +		hugetlb_vma_lock_write(vma);
> >>>>> +		i_mmap_lock_write(mapping);
> >>>
> >>> IIUC, vma can not go away while we hold i_mmap_lock_write.  So, after this we
> >>
> >> I think you're right. free_pgtables() can't complete its work as unlink_file_vma() will be
> >> blocked on i_mmap_rwsem of mapping. Sorry for reporting such nonexistent race.
> >>
> >>> can.
> >>>
> >>>>> +		mmap_read_unlock(skipped_mm);
> >>>>> +		mmdrop(skipped_mm);
> >>>
> >>> We continue to hold i_mmap_lock_write as we goto retry.
> >>>
> >>> I could be missing something as well.  This was how I intended to keep
> >>> vma valid while dropping and acquiring locks.
> >>
> >> Thanks for your clarifying.
> >>
> > 
> > Well, that was all correct 'in theory' but not in practice.  I did not take
> > into account the inode lock that is taken at the beginning of truncate (or
> > hole punch).  In other code paths, we take inode lock after mmap_lock.  So,
> > taking mmap_lock here is not allowed.
> 
> Considering the Lock ordering in mm/filemap.c:
> 
>  *  ->i_rwsem
>  *    ->invalidate_lock		(acquired by fs in truncate path)
>  *      ->i_mmap_rwsem		(truncate->unmap_mapping_range)
> 
>  *  ->i_rwsem			(generic_perform_write)
>  *    ->mmap_lock		(fault_in_readable->do_page_fault)
> 
> It seems inode_lock is taken before the mmap_lock?

Hmmmm?  I can't find a sequence where inode_lock is taken after mmap_lock.
lockdep was complaining about taking mmap_lock after i_rwsem in the above code.
I assumed there was such a sequence somewhere.  Might need to go back and get
another trace/warning.

In any case, I think the scheme below is much cleaner.  Doing another round of
benchmarking before sending.

> > I came up with another way to make this work.  As discussed above, we need to
> > drop the i_mmap lock before acquiring the vma_lock.  However, once we drop
> > i_mmap, the vma could go away.  My solution is to make the 'vma_lock' be a
> > ref counted structure that can live on after the vma is freed.  Therefore,
> > this code can take a reference while under i_mmap then drop i_mmap and wait
> > on the vma_lock.  Of course, once it acquires the vma_lock it needs to check
> > and make sure the vma still exists.  It may sound complicated, but I think
> > it is a bit simpler than the code here.  A new series will be out soon.
> > 

-- 
Mike Kravetz
