Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EBA5C0573
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiIURsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIURsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:48:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D2DA1D56
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:48:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LHjE0D001009;
        Wed, 21 Sep 2022 17:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=6JDxIOAvFOUGMV7jJU8P58LlZ4WLGkgFbiY/33IjeSE=;
 b=CuJCwkSb2KRSY9CGe0swljtWZ5CWScqVXEQRCsJWra/Ahwe+fCpC0MtCAmKaDTpra5dn
 L2Bl3LiwM+0w4I2hgD6FCWOxXQY65zKlRGZGMT8tngqbJWDpHsjTUy4K1K3MPTl/qn6e
 d3dQgcgL9z4RATIALvBFz7DEu4GYadDBJ9kLOQ/+mCobH8T1dFytHTSCtoHQomWn/rvr
 cySTyGPr3ApFEOzdswlxENs/36/4yPMm0xb5JQ/Py6Bu4VWIC3KftCSlh/Ek5Dk+gc/6
 8jZQup/0mp7i+BFdopDIo+mWT7UhfdtsBqiPBUI+6dEYWCeDR8QKzo4bXgCRHzEDVh6D wQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69ku80x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 17:48:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28LF4CIN025575;
        Wed, 21 Sep 2022 17:48:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39f5jgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 17:48:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4nO+g9ZbEBXI7pG9QLq7PZ8vhLkBaW496cMFphq5sXjyd2jasmse6yq/tcu5JTSoMnQw6DKZ+R1OjYsjadDaePQnOBg22eLCrkf/4nJl2HKOSZ7kWGe9nXZSLwCOUhQDmHWy4ayOZgxDJfJSTikFaqO57W3VwmzeMXfMLhdk3bNTg6Z0HuMu7DaT1Q1I24GNvrVCnyS+uo9uNji4GtUzoajF6K+1V7tmyyUr5yY9DvVYODK8u+BJUXWeArPTqI5QWuqjBLLPkh1vOa4d1HuWzxFf2tDlGSo1wsgQ+XHVtTMgXUXjXpJ0EcbN3oEd53Z5glX7HBMbic7+Gc2b/Ho4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JDxIOAvFOUGMV7jJU8P58LlZ4WLGkgFbiY/33IjeSE=;
 b=A/lgkR62h1IqbzB7iuAne0SHme31RPteCP9lj4tEO0ZvwvZWbSGL4uRIdOVGyC/R3TRgZR6BXO+wmlMMrpWAQHo08yYNbisBwU5UB/dmqYOE9fxLtXBRW8LuUK8QuAurb9JSbYAwJJ6i30Mh1maKI8rx+jN8SsUFwFFVpHW/teR1juRAHRszpzw07/swrUpoRzOmKnN2dIijO6iD92n98DSapfqcuWzXXovJlBVbd5w0NyzG9gwJQLtV1IRHC/g3bx6NjMAVekUpcEikQKUqFJZhwrO/QnYNuGMraI9VUEaqJhbc77jK5CEKRvhw5TroiJM8OSucTXuTYNAbcoUfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JDxIOAvFOUGMV7jJU8P58LlZ4WLGkgFbiY/33IjeSE=;
 b=wHcmnN3ijP14ikhyE1bDH5k/KhQfd8ruDVJl4RCpzbvzHbIZc60sdFo+TstvSV/JSY3tXJUk9/f57vlr8FoHeHnB/3A/gQDMlVg91e6CHdo6HgmxPwlBHKGl91rWI0dkqH43re1Ob3iqnK3bhd9NaC4PrKIDJ83+fH47G8IC9Pk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB4859.namprd10.prod.outlook.com (2603:10b6:610:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Wed, 21 Sep
 2022 17:48:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 17:48:19 +0000
Date:   Wed, 21 Sep 2022 10:48:16 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Liu Zixian <liuzixian4@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Message-ID: <YytOYH1MSo5cNoB6@monkey>
References: <20220921083440.1267903-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921083440.1267903-1-liushixin2@huawei.com>
X-ClientProxiedBy: MW4PR04CA0387.namprd04.prod.outlook.com
 (2603:10b6:303:81::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: 76aa1107-9231-4bec-8b53-08da9bf97824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lvDubc+k9RY+v+xgDDEf6hB4XVwIGNbKTd/af6YnvvhTNyYDuZnXQARnHULk52cDd4J2BwjH4TzITRpEjjBZ6rwgszkIuCUrsicGs/NK/reT4l4KRcOF8Uuhyels17hjleKqvW2g5cAqpLlnvzGDbFTA2RvQgsn/EbH+h4Cj+HPWmvPt6yvjCnVs+W6q3Ek/f9i5FALva+pU9zoyM5C+aqT0Hyo/cqlkj5jC7SQ//IZ+fZmTlSmNoUN/RIQLkqTXn9Lp4ewVAjym2GTmG3xWWyBXxjwYn8B5946p5VT7Vg/0gkVHNItw0fjj8BCbmp0JisUSQliUcclQwu5viHi7mQKdWuKKBlYnwt8FBp+AixHBeCu6N5eAZ24YsI/Ikd8ikKwY33YJjPR0F0awiJjJRIAy/XVpP9tJahpyouknn6GWjTGlIFrnKVrr2Y2Ne9GgniPaBuKo1yC31hCnqPL8NrvhBl8EN381G5uz0ONpj+C9sVfi46zTtlyP2rJiZcvPgpzeuo222U2/0kA0iyd2d48Z0q+F+TcqSJ0oeJ8mSexBQ0NnpqKOMWbZ0haXGlXKXYR4615fD8GpykumBOvG9BjuVtqaI17w8YH9QiYJoN7Jcuo5M8vF7XVTUssNQ7KW2psIQAbcWPcp7UE4UAPHhkLNwyDbtqq3Jatn+BBRkooHiV9fBBfrcakW0hELvVFzobfceNDCaqlezF5Gz6bhz0DfRoq1ty7KheNUIR1URDksXnO1cuup5PfelqapM5p0nbURzPy9aoIJptZpSvIoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(38100700002)(86362001)(316002)(6916009)(54906003)(2906002)(9686003)(53546011)(33716001)(6506007)(26005)(6512007)(83380400001)(6486002)(186003)(6666004)(4326008)(41300700001)(478600001)(966005)(66899012)(5660300002)(8676002)(44832011)(66476007)(66556008)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qw/88XSUq26HkC8ONeX9jAm0f7vNS50nvcGhcsVq51s4sfki/tiN16J7eVKf?=
 =?us-ascii?Q?CmP+JDVA4AHdVIW/FNPQF5Ds928TP6UhdcYKrfO/wmRTSJQoko+PZ51SwwYL?=
 =?us-ascii?Q?+FzusChSLkv/KWkmN/0t8z0Z9jNoRQnjftBSgMI3m5GayUFvtlqoUXktAUcE?=
 =?us-ascii?Q?t/gXQ34lSsUOzW4hbeQ2yE7nODQfcFV1ZM/X5kfxazsG/FDpEL1M47ZANM5T?=
 =?us-ascii?Q?k4nnCbej8hnJb8BcGbWPv9AsBuESqAZrd5vUB4pjz9OcT0GBHIBRonpBgtJW?=
 =?us-ascii?Q?UeKhK/rlU08CySR7qOiifEBtaqaH6BTgAeT9VPcs7yyczw/k0UOl7L/jSul5?=
 =?us-ascii?Q?r2ren1HzYFWPS5t+PqAV6P/jvEBN9YO3zPevR3NMA2qwySTctQmv/9E91T6V?=
 =?us-ascii?Q?AGuDl035/td71I+Ho/79cpCdHtnTj+PcX3lepLGzidpgM2AOtaRYOq6BKuGk?=
 =?us-ascii?Q?A1YprxHFi9TPHn/pdinPNjuQwEf99mdyEid3r2X97dTVffdzKgQShXQkuK40?=
 =?us-ascii?Q?vWBxcW3ytZbbFBE6G1lGtkE1LCHItW1sCOg8tqeA3t88VsbLoD64j1ec+S/J?=
 =?us-ascii?Q?DNBTg3wzapuqBNwGqIi72TwiDxndHm9FcE2iKjTWcIM+9gVTU6wE21TRQjBC?=
 =?us-ascii?Q?9LVT+H2HQljXf3oYX+XpoNJl0ZQnuRj2qLxWYAvu7D6iAjFcc7tUCOn3AfgQ?=
 =?us-ascii?Q?UX66eBs0snsLqXcHe6LCog3I+Ve5+ZYa8a4EUAxvnSLlKI0COKAbZ2qCfvtW?=
 =?us-ascii?Q?u1pDD1h9DxuZesC2nHwSVLNKcmyOReZr33XQ73yLvoQaQbTzT0wN/gLzpPap?=
 =?us-ascii?Q?LDFZizi0xQm/snJlW32Uq939F0sb1cguwqMczA32NY/0sHbrGrWT5d30Kq34?=
 =?us-ascii?Q?Ws/tQ9dK8ap+P2ZTcBqka8c082nnJKXhO4e1QwPoJEI53vd3Pq4LdoI6lbFO?=
 =?us-ascii?Q?mcUefRU1PxJd8F36LAFyQP28NVQiHUf6LXmgrBj2FTNu9/l00fuc7l5u0Cvm?=
 =?us-ascii?Q?BZQKVjFn6Qw+8nqzZ3uInSf2/cHyBEYQhKezcJ/UiILvAjrdoNWDxPbDNbKH?=
 =?us-ascii?Q?TMBDu19sdC1qGn2qhkhKi1811SgB6lR63t+LzHPTvpodGBtNTtCD6nVPogit?=
 =?us-ascii?Q?uKD2HYxv4n0zFtXFqBSoDdZBhbrxQg/n2pxh2y7AyY5JSWMV4OsHU53rcKjY?=
 =?us-ascii?Q?Ei74+XKwcJmYaqgKufUefMsWssxfYffS2D5QCewKUqo+zyav9Ovw9fjiKb18?=
 =?us-ascii?Q?rd07t11kW5GWoEmwVoco9tSEm0wzXQNmzmT/DnRuUaWherZ3ENmDrM+/zra0?=
 =?us-ascii?Q?aF1nB+KfoASxej4E5QvT+0VBubqB+S94jWHSd+0CHKPtFB6+ti6rz+HaWl1X?=
 =?us-ascii?Q?33c5dHAKIrRPLOSUMK/lwh788fPaZEqabMo1NjmXYiQZp07x4UAj3XldlCtn?=
 =?us-ascii?Q?VB8Wcb4UmXVNGAHsctHfHj4xWRGTjLBhmnHbNy/WfU2BBA38ZnXtsbtMSYcA?=
 =?us-ascii?Q?r61zYeFs8BEdTpCYmicY8cAsPElF2wku16i9/P4jA1YZmhAvww0VDjq6b7MC?=
 =?us-ascii?Q?0mR0P2flq+3yiCAYS6btmERhHKlXhz/SCaF1x/T+vs9aw5oB3FRtHHSksTjL?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76aa1107-9231-4bec-8b53-08da9bf97824
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 17:48:19.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83uLmPIZyqR2J8uMKALa3md9p0sQV45eyg4BRuHJ0bwdEJTq2HawN8WS/nvOEEx27BkBEIxH8wGkNbXzETZLXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_09,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209210121
X-Proofpoint-ORIG-GUID: eH-FCtRAmTw58y0-VeOLjgMh4OtCoquj
X-Proofpoint-GUID: eH-FCtRAmTw58y0-VeOLjgMh4OtCoquj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/22 16:34, Liu Shixin wrote:
> The vma_lock and hugetlb_fault_mutex are dropped before handling
> userfault and reacquire them again after handle_userfault(), but
> reacquire the vma_lock could lead to UAF[1] due to the following
> race,
> 
> hugetlb_fault
>   hugetlb_no_page
>     /*unlock vma_lock */
>     hugetlb_handle_userfault
>       handle_userfault
>         /* unlock mm->mmap_lock*/
>                                            vm_mmap_pgoff
>                                              do_mmap
>                                                mmap_region
>                                                  munmap_vma_range
>                                                    /* clean old vma */
>         /* lock vma_lock again  <--- UAF */
>     /* unlock vma_lock */
> 
> Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
> let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
> the issue.

Thank you very much!

When I saw this report, the obvious fix was to do something like what you have
done below.  That looks fine with a few minor comments.

One question I have not yet answered is, "Does this same issue apply to
follow_hugetlb_page()?".  I believe it does.  follow_hugetlb_page calls
hugetlb_fault which could result in the fault being processed by userfaultfd.
If we experience the race above, then the associated vma could no longer be
valid when returning from hugetlb_fault.  follow_hugetlb_page and callers
have a flag (locked) to deal with dropping mmap lock.  However, I am not sure
if it is handled correctly WRT userfaultfd.  I think this needs to be answered
before fixing.  And, if the follow_hugetlb_page code needs to be fixed it
should be done at the same time.

> [1] https://lore.kernel.org/linux-mm/20220921014457.1668-1-liuzixian4@huawei.com/
> Reported-by: Liu Zixian <liuzixian4@huawei.com>

Perhaps reported by should be,
Reported-by: syzbot+193f9cee8638750b23cf@syzkaller.appspotmail.com
https://lore.kernel.org/linux-mm/000000000000d5e00a05e834962e@google.com/

Should also add,
Fixes: 1a1aad8a9b7b ("userfaultfd: hugetlbfs: add userfaultfd hugetlb hook")

as well as,
Cc: <stable@vger.kernel.org>

> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/hugetlb.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9b8526d27c29..5a5d466692cf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
...
> @@ -5792,11 +5786,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  	entry = huge_ptep_get(ptep);
>  	/* PTE markers should be handled the same way as none pte */
> -	if (huge_pte_none_mostly(entry)) {
> -		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
> +	if (huge_pte_none_mostly(entry))

We should add a big comment noting that hugetlb_no_page will drop vma lock
and hugetl fault mutex.  This will make it easier for people reading the code
and immediately thinking we are returning without dropping the locks.

-- 
Mike Kravetz

> +		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
>  				      entry, flags);
> -		goto out_mutex;
> -	}
>  
>  	ret = 0;
>  
> -- 
> 2.25.1
> 
