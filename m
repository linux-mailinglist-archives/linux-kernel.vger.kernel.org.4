Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ACF64E07C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLOSQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLOSQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:16:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3C112AB9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:16:04 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFEn1xk004460;
        Thu, 15 Dec 2022 18:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=8EUyq7sQJlsqWU/iMDVoiqQBz6MIrCzOMPnPRv2EhYQ=;
 b=xgifR8+18E7kAUvJyTOEy+35qQl5BK94DdGZWDcjrMqQ7BJgZVpqfmAA64GJZgI/DzYU
 O0V8yTquDU2NTmST38NWiExhbMSpQVR23+I5fCDCWxRwiZOjqRvMjsLZuXtpQIt4CicO
 Bp93KmZMQO+9RUPCp6IU+T/GbJVwyyO7rB2gupHFCzsiZU3yMXQVtUIqdh3s5SDV4E9C
 qoA9MRPB3Ck1tPjZ8bsM+bzOYviWx7G8IfqS/OJSsqMk41sMx7njne22ZH+wkRA14Djb
 vZCgeaW12dcq9H+JGm8LbUk3/p2NU2AxaZwTI0RpSiFH+To00mbqhvlMVdP8xF8KkkAR pA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeudtqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 18:15:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BFHQEpp011043;
        Thu, 15 Dec 2022 18:15:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyerx1rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 18:15:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSx0KsbmVyhG2QtmI537BoS6lcBHrzcgzFCjbMrPfLgr6xerrl2Bq+ZFpMXc30dVLlDWhnrrHYvPDjjoFVe8m55XeeZbe+nUfVujSeZYJYnYEoN0HaveKpx+cvBH+qvQ8XyCqthuhimtJWxEGEE64BBN3CgX3MLoncH7UVH+cVAAQkZYRq9VtuQYzt0DdjVBiRIscvVHLq6uz6LjibFb+cIB7eq2H5SpNT7rQBvEfI3BGrxGjuC2AV1FzzJusWMWqRvPiwLZgYpNSEz/bEWO4UjZfdLzO8Z1sp3S+GEMs80P8j44VbFwHKLt10awMy3TAm1fsUvNIAMqkW7gLNBeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EUyq7sQJlsqWU/iMDVoiqQBz6MIrCzOMPnPRv2EhYQ=;
 b=FF+a/Wuj1ufe6y+KrJh5OCJOOn8b+puxjDgd1ylVxF0U+62bhF6Xy2Kdkv4Y13e9S7t/PwjA+oErSkuN4AxkpN2yEzFK4Sg5dYMAbO3X1QuJi2QRkYh+hwdZ7Z5qFXjgwwmPxaG4CCj4G+J8bprZ99McKjso28Ahc2FckqaXQOQl6TNPEMjZd0AjjIk5voEnp1+9eYLz8nyjjnR5zC9HLxCm3/9qn6qmfsKVtk8Fdq1RpOPB4oBUbUtjUDwIj7qmbRCtqhX6Sk4hF0Z802CSMfjLZzEX9KEwEgmE4g2uSZMHcZ3lUP4nl6R5HQa6BvIDir1iUUAVboFkVt3E4jyaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EUyq7sQJlsqWU/iMDVoiqQBz6MIrCzOMPnPRv2EhYQ=;
 b=sY3+drPMIYcdcHyQaRNR0VUH2JF2SWvMGpWd6iARyZEbQh2pjLfa4apXi4ebEO1th3g7pV9PfjstI2yWe8rBs0QwIY2QIkQie6ZsY1vGyk2oV4vwju19BC2UH5miF7sOIvDSx0q5d6zd11UNYAzzrtRFUu5bns7wQD1Wyz37NNM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6832.namprd10.prod.outlook.com (2603:10b6:208:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 18:15:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 18:15:31 +0000
Date:   Thu, 15 Dec 2022 10:15:27 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 17/47] hugetlb: make hugetlb_change_protection
 compatible with HGM
Message-ID: <Y5tkP8qUdsAzAe7D@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-18-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-18-jthoughton@google.com>
X-ClientProxiedBy: MWH0EPF00056D15.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1e) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: d15a550b-f108-4f02-7626-08dadec859df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLztYq4vjkcvn9H+xSN0m8PirUPyObqHjexvT14tIuB6YXzCe77beUyY7mI4NnMU70mor5xAy7lNMB7DKbF8Ptrk3Ei8MwIoneE1MLeR9QUYFxfX5RpHnSCVEnIvyDl9OVzuPkCGsDDJev+lqC1M1wdPVs29bdJH/FIV9lh882r4PfWdtBbBd91vXQBJSVFU7by6vBnv18nVgBZ8IKOy0MKfcTz7KQDVOCBMGYfSv2rQwjp+jYihJ+2cn8wQtuRjIrwfIJ9rYBIh8h//byQ386+Il+ioEi6hPNpIrogKXar4/zYgWrSHcRwZjXETjkq/+KL5gyPPMxOCd0gTY5oFMi5r4GikbdTZ9JETUyLViEdetqc3MwHB2lZQMs3hZgKFfkub1zlhP8UGgWJxMGN3MdghzMRwPEHvZP6asC+15SbQt4nKvaoQ9bVog9aDEUX7XxecXLg9nQxQrHSU0nNH6Nu2mA+GIEenKTDeqfqaflwuAMWx8lFfZIDYO8Z/z48O3F8M+2JiDbAhBhJwZnNS2pF2HeQ2gqnpsY7nt5tGUaqVIB16NsLGuE3vb7mXIQ8g7IXmWhLMftGPWJJX4Wy4wlEdipjcADhApQzduKyZSUIDHxK96zdbxE9U7GRwK4P5qQBZvIeOXrYnIBC/tCpaoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(54906003)(6916009)(86362001)(8936002)(6486002)(316002)(478600001)(38100700002)(33716001)(44832011)(7416002)(66476007)(2906002)(83380400001)(66946007)(4744005)(41300700001)(5660300002)(4326008)(8676002)(66556008)(6506007)(6666004)(9686003)(6512007)(186003)(53546011)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KvqYoI0V9vibsTBCwFg0PNkgMzWAggsf1rImrKt1s977fV9TSxswPsm+RHR0?=
 =?us-ascii?Q?C2UydRU6L3PTT6NDPyEI3UbziEnQNCNk78m71JTiDl/QZsUnfYSRiW9bDuJr?=
 =?us-ascii?Q?38cYRin3tVUoBhd93R/If8Aov9wFWrdn+DvfMWvl6LI+DOO1IKJoTna5hQ+h?=
 =?us-ascii?Q?FCHY2caLB8OX0RSY42fzumketkmFPO7a0+f9AKGdqM92NmF8mSDrWbcIstZy?=
 =?us-ascii?Q?weykFTySAuOFnSbaeVmWoKN4v/Nz7xhRTy8hxm01Gn2SY9vTOKSvK+Y9Hsci?=
 =?us-ascii?Q?pK1Yn2ePnT1dKu31ZM9bKriu+QDIkgmPehVm0N5r+6fIHA/xid4hH7y2fKmK?=
 =?us-ascii?Q?O0cH1JhxAH08pgf7ELLfvw/YevDDHhk43I79t1PsdwnqlDGgLQmS3HpmRYS8?=
 =?us-ascii?Q?zqTqYembYszbFov+nLPuHalorCUa08JEatLi6yYPJ2MDOkBeFaMfu/ZSD7bd?=
 =?us-ascii?Q?9phpGV/jLAJOFlrZBY5zGPMoWk5sTOddI1Ye0mCQdZNk5frYhQvXjRHLHr5Z?=
 =?us-ascii?Q?fhioaRHRIHwZPkepcGiQy4LfMx+AmCca8I/ZGLSaVhKTZMvtPFts7mHMibun?=
 =?us-ascii?Q?uDntdGLT4NrnQ0CEZamkRC92Gvetvj3Ua5y/P4ZrwcaJefxkHCwriLakhOzW?=
 =?us-ascii?Q?4rLxmy5YLF/Bsa78sckdH/W+AD2MZ6goGwoIQ0Q27c0J4/aM7RWJfPgDpX8B?=
 =?us-ascii?Q?0csUyRZC9Akze8ToKr8B15pf2z389I03p7T5AlswfaByvwxy2Uu/ASth+U/T?=
 =?us-ascii?Q?UhEID2aCTLK1hQVFqCPe36/xtsO5BRgZBKHoc9ikavaMvfEKGMC4AcTb9Z5J?=
 =?us-ascii?Q?J2kwabhowe+hNS+S4qHLxHne9TuCZTIUzQNGa0NRxNYsL/fc2kMrBkO7H3VB?=
 =?us-ascii?Q?9qk1ddAthZgQNnUb7cCNe4W+hP3p/ZTsHL45qyjSr9AHIHRFpA0yiuwe0oWG?=
 =?us-ascii?Q?guy7E31/gJvPm+Q53s2L1AKItB4d+XaP9Gcvenresa1zK3+RvUJjDCG7w61S?=
 =?us-ascii?Q?FgRHYjgZrjE9o4D/f++AXh7OMQCbYVUKcif6s6DCdHlY8NxBUatTwLysAYVo?=
 =?us-ascii?Q?lIRx28Z5/tq+lEHjMJrCwhZs0ibOWA7NjyAao4vNKVhaKujJr2XHnUZjTniW?=
 =?us-ascii?Q?h5JbGQtcVF7Sil1+POuKU+0z7vrl2JBhln9qSBqucTillMVNreVYtuhxbdec?=
 =?us-ascii?Q?Cn64/yW5HNmdx+G32x+dzACPVPjBNgotlhi+bPY5lolaa1cqdi/L29cFBacq?=
 =?us-ascii?Q?bQaUWB2mHieQXrZz+6RFOHXoq+O2nPT2EYbcbZ16QATRi/Kw5NjrI7zAEIU4?=
 =?us-ascii?Q?PNQNIDsplh7oqlpdzqUjSeBYF8aXB9AD7a2RKpSFZCHMOSXrhffvdUS3OIOP?=
 =?us-ascii?Q?DXXzAjNbD1frbdqCLTXOhKYVagi79KuA0mwKipxqq7RMtBZA2mWSx1qV8wdX?=
 =?us-ascii?Q?cigjzDHwh1sk54Sn/mC0t3NXzw/M+U0R4YZ5+sZ26S+UDk1Hkbz8Gl36+eVo?=
 =?us-ascii?Q?KmqeqjFX27JEd3rkodr/auNq1OiQnmD8Yrlja4o6l0Cb6RESxmNdt4KEOH+s?=
 =?us-ascii?Q?GpnFbH0R1TyIntEmribWVjkbyR3NUHuwwcEvIMzKh5OkbLAt5u9zlOH9Q11Z?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15a550b-f108-4f02-7626-08dadec859df
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 18:15:31.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcVD4bOScNurjdTdoO0q9fQDyCnWKaxPZzc+CTfAJXPqqXCfH1k9Eo8NY2v18Iwk3vx5wHGUWqVs/OhXJczrXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=734 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150151
X-Proofpoint-ORIG-GUID: 3EKOKTMirvcwfwX086c_GybIkG7NqkyC
X-Proofpoint-GUID: 3EKOKTMirvcwfwX086c_GybIkG7NqkyC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 16:36, James Houghton wrote:
> The main change here is to do a high-granularity walk and pulling the
> shift from the walk (not from the hstate).
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 65 ++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 45 insertions(+), 20 deletions(-)

Nothing stands out.  The more patches I look at, the more familiar I am
becoming with the new data structures and interfaces.

-- 
Mike Kravetz
