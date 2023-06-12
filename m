Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530F672D378
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbjFLVpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFLVpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:45:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB21D2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:45:03 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNq5q021029;
        Mon, 12 Jun 2023 21:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=QSBdD1BDuPCOf1BZHuq5+Lc300fbL1OzTlU8+A08HSs=;
 b=rO4aToESONErib2GXk5inHV8xmq3A5j0ivzcGeusw9M0x/yGdxKVv4sbq/aG+DTu2vkc
 ctSGgI/3bhw5GGpM0rgLz1MF5+pl9DuS8NoeuIp6fTV3w+x8nwTQpU1NQ7sraqFpQC4J
 g5tIt3FCoctJDJE5FsaAKBdZ/JWDrWhh8fL0Zb+WPY+iujMla/Nkq+GcFQX6WsTWjv7M
 q2t3lQYsvlTVZoKhDv4u3CSpJmtNWFxECHShcbK5lXD1WjMsqNMI9C6XKV5uBA1IeZvz
 K05zPqGwwD5aydFhnyvtA0cCWsY2Hni+HkumDbSdMO4rut2N97KPlbYl1Fdn1dD6mr/x Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d3xfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:44:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKUO6e008966;
        Mon, 12 Jun 2023 21:44:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3kkvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a70NS9Z91hNNDj2G/6CTa2glFsLWKEvjhyPnzfJzUrRUxFDaG3x0iESb/mXUmPExxq4hnIolzuvSxi94h7rWyVcu5AjbMUiZHdvgXDjAtEINueWnOcASny8grMYhPEab/HAfdiZR+eAnoC/1OYM0icq+XiOVqS55cCtgYoJsRxFejYZxZvrt3ylPdrJ6/FRbtKF6ORq9Itkt2+KcDV5zAAizUchn9dSmh88QDxdXqGWWtSr7z7/Mw2DDbPq/d/FeUsMS+DCSw6Hh5nG2fdXYpYyy87cnGSwxFAVb76jtlPUYHxM0fwf30qytPE4vR7jlhetEcmVDJCJuHwaWjWkOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSBdD1BDuPCOf1BZHuq5+Lc300fbL1OzTlU8+A08HSs=;
 b=FcsRUl2hX7U4BjVwfQdS88fChJjoWzB9u0ONNwHa8gbuj/ptLQgs0jxJuOjRJj1t4Wyw9Z15a8Q7qrx5mQ8HtGFvmf5H1cLkTIg0xq/Ql/4n7bspM+cYm6C1DQGMAEZnj7ohJ15vTwhb2i4Zmsr3pZEGYa12ncduKDOyWSgcQ4UuX15lVRkemLs08CMJcys7usWPif413kkwHrX/LhZxpEHsZ+gDUambgztpKKnoZq2dwxoBRfynpVe+HBr/5YsHUZbzq3jS8++YmpLKzcOffA0o00XilcuJSXuuTbNt8C/WFw4X80lt0L8woKVm0qsSp/sPXkIs1bd+EJ4wFY0YMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSBdD1BDuPCOf1BZHuq5+Lc300fbL1OzTlU8+A08HSs=;
 b=BYFJKHuZCnT8W1j1wPkpZ60B0Tn/N9wONm3dinA6nKxstbCxzFMT0cT4vrCdFMs2t0+A9AZBPnkZWrQaBaGV0E9BewD4+6joEVLrMXsB2p1KgF4cSz+RgTxjXfKL8VY8nq4mpgGD81igpDz2Yb3QUSKzWrQ74jZeevEJ3+4TAKU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7414.namprd10.prod.outlook.com (2603:10b6:610:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Mon, 12 Jun
 2023 21:44:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:44:35 +0000
Date:   Mon, 12 Jun 2023 14:44:32 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm/hugetlb: Fix pgtable lock on pmd sharing
Message-ID: <20230612214432.GE3704@monkey>
References: <20230612160420.809818-1-peterx@redhat.com>
 <20230612204418.GD3704@monkey>
 <ZIePspc+wgNeR0/H@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIePspc+wgNeR0/H@x1n>
X-ClientProxiedBy: MW2PR2101CA0031.namprd21.prod.outlook.com
 (2603:10b6:302:1::44) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 59922b77-f9c3-4263-9a92-08db6b8e3702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /G2lXe2pAPZYV7xsS/56yAnj6Aeo+YjRtyjeTE3scEWaGdb1NeN2Uld73+iV1WyTHDt4gVpEPk9wmZxfoocUItUvijgsWjX1OrVtxQtgJFU2HNqVqMSWIq2sOzUakBEFPgX7SgrkjnysrhJZTjId0Z+GO6IOlwSjwK4xLYC58YQmNF9jart8K1MfeemaeCLk+OpxQsseKdOAsknc33MehZRGa0b1mLPoyM9T9blvly9kKPnBhSfCwJ26yzoQo45YdxZzxF4krUHBX2Jxd0IBfCRlktua52M1BnRi1QJhIvXXAoMmb39M61v2JHXFopMVpjkKBRr7xnw15Hxv6Xk4A8A5Il6dHq+/LaF79kpCVYBbOI0UnbW3hskxmChsDNhYuHK+A7RWmBXCvnIM1kHyvlhHoWSY/6qk99gB45r1DqGvUokI8klBAoLlZ5CRrtzmOcL6NgWXF6jYLAe7bpx9Ar2VrDPASXZOfGzhKncJDQSxRctGyy3WfeHgvAI8Tgv+u3r5Th6rXFjLZ6PESzO8kzg8NH8MEcGz/4zkaCz5tVpwUpO6wr3+VpH2bazI2Y6L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(6666004)(478600001)(186003)(1076003)(6512007)(53546011)(33656002)(38100700002)(9686003)(26005)(86362001)(6506007)(33716001)(83380400001)(6486002)(6916009)(2906002)(66476007)(66946007)(316002)(66556008)(4326008)(8936002)(44832011)(8676002)(54906003)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B0HMgwF0tz6WbB7qIvFRObJHee314e5tRy9jrLjCPr6PFDUeArrBSdlDjkso?=
 =?us-ascii?Q?HW4BKr9B6HIjN99cwl/SSj+9/mV12oLsr5pSgZS2XiVckmgAilRVlVBJOCvY?=
 =?us-ascii?Q?guAu5o832nSwmPm5sYZrnJ7UvPMQc7uhlHIBXVZeWrtl/+0n8CPdTEdb1gQG?=
 =?us-ascii?Q?KajadklwtwGQjgdfOO7xNDPHSZWgEXcyGLkOvJgrfvAsSKdEzOqnU5C+IbBD?=
 =?us-ascii?Q?i3HmTQQN72DgLMxZ9cy1NbMIHS8zxQhnASBf8Ax9/ZzrhuAi9u4YuGAeG8Qj?=
 =?us-ascii?Q?OYlQX7ykbHqJZE7WiAsKmjSE4JrOcatpJnlEl6tx2pweB2B3XsDM0Xrrqpgd?=
 =?us-ascii?Q?EHsWJqocj2IY0meLKVZ28LKkgTROV4n7JJGcF/Y//eum8Y++rqRhrfO1QbVq?=
 =?us-ascii?Q?Q4Awq3r3p/zyj8K6oEq16ZItr7eaVKTG/7iw72BDh1mGpgMUB+6Iz+t1Qpwu?=
 =?us-ascii?Q?+a6ZldAUdnaaW50qkf+7QFS+RP+3RQ8GRv4Y/J5O3pUCAC8BPGL7wWjcgZBW?=
 =?us-ascii?Q?DZaREiHy6SYKH45ANOpiQsT8umAJYJxrbTapQ00Z9TbU6Z6qgOKxNd/EJub1?=
 =?us-ascii?Q?X188Nd5Rzf40VNE/E3zP4K0zyG14W/2gN3trOHlIllr4SpSGmqfsEYOR2oyg?=
 =?us-ascii?Q?AgP/buPRTLHTNm/FCJ6y8p2FCED/Pa4AgVJ/aknzcKBkTM3N6sVGBpdjmTA/?=
 =?us-ascii?Q?QRCkVSolS5J6HAg7D0bEg+El0y8bTZWE0Xf6CcsVIH+NbYl3HXJHUkFu+RwC?=
 =?us-ascii?Q?Z12CLtlmeE+NfPtKWgXsUzmcVaVkF8cCAKsLwImB7d4dwqh3A/S6hS8lzGps?=
 =?us-ascii?Q?dZjzrdSpKsthY++YcUxOjOn//toq6j7ZAtlK5iCGUXgN5lUlyqaaSHpbN47X?=
 =?us-ascii?Q?Rug5xsKcl93RaXe4efhE3yTrkEZ5RoPz3bdW9tNtBaQjI7Yw4pqu31LkHQQ3?=
 =?us-ascii?Q?VCiVob0prAZQLUsx60PyxQ29vAiP4adYUW2gdWOaO0qMOg7GrYe56YJWcy+p?=
 =?us-ascii?Q?vUjw3JwpwpMHjAUWayOV6H3VGD9c2GoOPmxVffslDNkAnSHQMtkLP2ofGT4G?=
 =?us-ascii?Q?50rYl/7iSCckwTh0qBWI4/xi7eYkwUtFyInh3YIOLLebVQiHZywI7tcnWNd3?=
 =?us-ascii?Q?SJle0LBOib2rJVVT/5yLkyMtYBuKs5GHDfov++yXdOe9WVL/7dPoeuW0OiAj?=
 =?us-ascii?Q?5i5plfMcdYO5QyWLy/ct4fo8eex5XR8tG+Qji8/3qm88fPpI68WS5hn8aFIe?=
 =?us-ascii?Q?Xz5w399IQQKzHF04q66tyM5/fYTHVwqmdZfkJEeBq8JU5ggKG8+WVcsIBEQl?=
 =?us-ascii?Q?wBZVosWqYHKJ+mHyVaBKKJghgLdeaP+MzzopGsIYSYau05YmTyL61uMtFBZl?=
 =?us-ascii?Q?Gwah3hIlZu6Y0ucOsQLahWqpRL56zypQi4QfO5sMbjAdnKw/7Sy9Q/aEtDqr?=
 =?us-ascii?Q?fWG5DG7epwUpbhB94z2jT1d5yQHqoIrJw1JaDmcX96TzJFDUYBrFLxd1A3H+?=
 =?us-ascii?Q?LfWkCsBmyDL9CHhVv4Rm4TP47yRCCe8doKPw3h3+GVtcL0BdAWc/C77u3de8?=
 =?us-ascii?Q?4hKxuBCMyzxcGrMWV4qbCnFSBTJXwUn/DKhtj66k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JF+KSfut4vIyOCKBoQeiIZt7QJkjKVlIMh+n9/rzC5p6+KkoRIgjBfYajcVY?=
 =?us-ascii?Q?dongZoz2/MAjfY0dKsXO33qrBb3xJUh/RYN/K1EulH/PDXOvAjEXFHuz8N0/?=
 =?us-ascii?Q?wnRnVb8BK3bK9ekWGdCpUiVsFlSCg3RLxZkPfBhqMHXdi3UwvO0DA9zfffiO?=
 =?us-ascii?Q?lrTx+Nr3byhozAPM4HDKt/t9SeV5QVSxb6KPYd+Pad8akdfTMj7TKU1bhs29?=
 =?us-ascii?Q?aNcHRBWkexhCV590SnH9mfATZsEs6OKTZ5wfAvjUng7QMnVtTRejVwjtAFsn?=
 =?us-ascii?Q?jQYeyf7YGUTO9C9TuAKPJPgcBZCMfZzMlab51h95bVKi/umlqlNfslqqv33l?=
 =?us-ascii?Q?JEL3QYSft0ZGcJXfBzIY9U+QbJUO/bP6B/tXfdXrq5150ZNQv0jBuIH/9bJR?=
 =?us-ascii?Q?6x/08/qfops8g6Pb3mF7sYSkY4jZcyo9pYsKXWULILXN6sDXXgfQjM9EhneA?=
 =?us-ascii?Q?RXceYd9rT3mrbTqUZsJFu2VdD7HeDiQnDcerrJRriSLd1/94zStGkHfgaF+2?=
 =?us-ascii?Q?nrJzfic+HTzXbolcVopI3GlJxV69qrbju7t+iJvTAdx+Nyul+AHQE42QJnIk?=
 =?us-ascii?Q?os5Yku62tbImIXo/wZ4WOXUU42wD92vlUpqA6JRKvwvrqa9Hqd/0KK3EbfhV?=
 =?us-ascii?Q?1b3ubaIUfsYPn0wcPoeoxOzrrUFoWT3nQG5Hyhl9vb2e1GGkexF4fWlHOAn/?=
 =?us-ascii?Q?u7+AmMLOaHlCjRJxCvc0PJgvokr/miQFDighdkHx0swMzzuGKxHZpMm2ulnE?=
 =?us-ascii?Q?ihktWrQOJjqhsDD5BWPzkGesLUUef1+idCCR/0W/91FqhRRAevmrx+evQDR6?=
 =?us-ascii?Q?hbbGbeodadyyHC/LbGPuefow68+bwm/tbaRtdHofg4qk4xpK90nYqS6RP8UN?=
 =?us-ascii?Q?0fLPjJWFNb0STCwE1IBJXBJxDPrDmsyDeHM+G8JIuW8p0Du7AYgYFOsHnRTL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59922b77-f9c3-4263-9a92-08db6b8e3702
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:44:35.8555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITGfuvwI+KdHk8v5YCV86/q/QknbbIdvGdJUNDnMbbU+zsxP5bj/dqoreYLVrqYeOVg3H7nee6K8cnJC9VzRrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=858 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120186
X-Proofpoint-ORIG-GUID: MjbcoNgTOHJbdM7HrV3Ia44UDPcAyw5j
X-Proofpoint-GUID: MjbcoNgTOHJbdM7HrV3Ia44UDPcAyw5j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/23 17:35, Peter Xu wrote:
> Hi, Mike!
> 
> On Mon, Jun 12, 2023 at 01:44:18PM -0700, Mike Kravetz wrote:
> > Agree with this change.  But, it does make one wonder if the pud_clear()
> > in huge_pmd_unshare is safe.  Like here, we really should be holding the
> > higher level lock but are holding the PMD lock.
> 
> The vma write lock?  My memory tells me that you worked on the vma lock and
> one major reason was for that, but maybe I missed something?
> 
> I did check again and all call sites should have that lock held, which
> looks fine here.  One thing worth mention is pmd unshare should also always
> be gup-fast-safe because it never really releases the pgtable, unlike thp
> collapse.

Yes, Duh!

In the unshare case we KNOW what is mapped (the vma) via the PUD.  So,
we certainly am synchronized with that access.  I was just trying to
imagine some other situation where we may be walking the page table
without the vma lock held.  However, you already took care of those call
sites.

Thanks!

You or Andrew can add,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
