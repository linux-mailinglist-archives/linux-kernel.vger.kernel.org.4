Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA9A648AEB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 23:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLIWwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 17:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIWwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 17:52:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42925C46
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 14:52:35 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9ME08R002204;
        Fri, 9 Dec 2022 22:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=O7proDHCDiJMApvTw0RSqeOC2S0L9uLCr/3ywppaE14=;
 b=b3beYlX0fnhrOZwp01tDzZL/FWgUWoITpg/giFexmZzX51ECjIlRqLqJrBKWxIJTNMiV
 gOhjut2ZzuEeWRB7ykR2fSKTYVsR1jpCJWHceE+YicPWibHuwtqGbdk0t7CwlO5zntex
 UfqAvRYpwoi5kD05B+ykwy/QbaZnzoMP1sJCJWa01koTpoH8rEkt3RAfXo5USvH8dwyk
 r3r/HTU5B/DUsfSEwLD3mKNb6MsWgmusDcXRxke56NJS9cQmcJDx8SqfcLoOUNEv9xuJ
 /9wFLeyqj3xmpm5BD5icZlHlTa9ATJ15PUhb4OyECtvdz6HtSphYAJeXGn7HaZyfhU6y Jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mawj6wabp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 22:52:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9MUnbN006700;
        Fri, 9 Dec 2022 22:52:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8278bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 22:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ew96D0eenf3rS6zUkINGL/sxVJOahTIXlK/9jYFI31scEYaXvDtP4jXpA2VfHud8B4W9CkAYaGFGR0Ebu9IyylMps/V7xz5XzNL4pwJkmwdpMllpdWiGiT29TJfwXWuBVcaYm1yRvYGr/B19xU1dG6tnGoXYL0HuRM6j6+mUTDrpJDHxTbQRpXPASy/ZLXN7xzY004T7j5srdtK3e/31vSIDKVPRyS/aM2R0z2I+hVeX8cd/sBi4oozgEk+G3xUEF7Ol74d/7x0mI84grsQ7tjV150NKTXXWIa7sUsxmZF5TLMX7DoVnRMg6UfHVYa7aZ08SQthup9XUI/+6tibe1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7proDHCDiJMApvTw0RSqeOC2S0L9uLCr/3ywppaE14=;
 b=Rfs0vG4s4VmzCjOIOBdAvQ7pWZ6bg1AK2JoF0C4BSIJ5pZ5xI5pcjVre05iIxxcU4lBEyb1ceuBcvWwVNtj9q3A+8/gyGXgi0S0Us+pyoSjq6bkREnjyq0qZ3nnm9P0KJCLZ5grQwyjFPoMh65ip6cpXz99CCBqbTkhd71YFuTfPcHzCvTk2rUTYNlR2xK7FKAhAi5bKG/+04GA8EmEfERkWPhUQNBpPH2MluowClJdECkhFYhUAnIqPvVlbYTEjpWdUKZHmMP/gI2YqQoWlGDTL9H2Vy4XgXK+ZoIBtMOrzqz3bIjOrv6w3uBwwlP5ZZDI/4A/AwM516rwIRWwfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7proDHCDiJMApvTw0RSqeOC2S0L9uLCr/3ywppaE14=;
 b=HF/OXYW1r8istWA1jmj24FuHvexLqzvyTCTysb4VWVaSgeVrwVwdsTPqlQGeYnYkL5SRSg5ouBCunVgy9mbGdDx8/j/SdZJ4nCbJ4ttGFkgWDEvq0uWzhcNNOR3/P5mYpJHY1CYwGWMDYdCMXnOL1Q9mvd/PQ9uGJF4qaqqBLAI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA3PR10MB6950.namprd10.prod.outlook.com (2603:10b6:806:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 22:52:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 22:52:04 +0000
Date:   Fri, 9 Dec 2022 14:52:01 -0800
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
Subject: Re: [RFC PATCH v2 07/47] hugetlb: add
 CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
Message-ID: <Y5O8Eewl0v6CSmt6@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-8-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-8-jthoughton@google.com>
X-ClientProxiedBy: MW4PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:303:b8::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA3PR10MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: d9829fb5-b95e-4444-1c56-08dada37fda1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38tmasQaey3AwsjCX9dGJrZV205rjV9tVY3w2+DG13CBo/o2JPGvnYsbhXcU9krztMSiG09IkziFYLcFunf1u891McdBVCbFvTzhR0JnGC24fwigiN45cKQKrhVP8MD47yNsFl9kurwUkgfG1/ZwJDRxS6Lj9JX44ckbnj07Arfq+dj27vAQ83KPUBoX7o9RpM3qh6OEKDTEkyy+71JhLqj1jT49djYjBoi2YH4esJWws3zieDXGJKeN/Oo5YoTXRCTrD+dQOxldhAT2luKv1LitzcdxQnYvE5GziFtHRelharaUFXEanYfg+NnMNrTCOkvebZUrFzIXkekUzwUldWTxFhW1CbFfKgGPIJNpCKnYFLRpGQRybgn//hqm8nep5+/AtFwTUU0vut7dNgkhgikNspqY4l745LOoNxPsLBSq1avNFy1yKoTOXqswwR5eGMtkMC146KTTyZ3NF4gBGFinsEHN45phpilbPEjsvKGQ6AS2n17qf5a8pswUO7Zv1h7HWQ5kgs1BKOP4/7LQuuZJXjX6/dWicBUVg49ivxlb7xSriPAgWPQHqVf/D2clV+VaexUg0hggyDFM1UEoQTCdVrRfgsDOGuPxvLLmlTLcVQpU9y+5o+6so1eT94YhGcWrPFbcuAo62tJ45RBftQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199015)(7416002)(6506007)(6486002)(6666004)(478600001)(44832011)(53546011)(5660300002)(33716001)(38100700002)(186003)(4326008)(316002)(8676002)(26005)(41300700001)(8936002)(66476007)(83380400001)(66556008)(86362001)(66946007)(54906003)(2906002)(6512007)(9686003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Rk25RV4iWgc2sjEsfmlqnGPlUrHAt5I/NfTOLD8ZmaDYeyh/MKz5OYBMrKh?=
 =?us-ascii?Q?abYs6KpiBwuSNeA1s1g7egHEneau++meWy/jVsJs5jxwDDvijchSi+M8wI0B?=
 =?us-ascii?Q?5FgHHkzNwa5FJfLVIuUzFQuohmClsj/hRDKKcIYdD1RPQv2rzFiu3fSW6B5H?=
 =?us-ascii?Q?Eh1SZQgOepd8BugGvWjFHRp8bM/CtoeO53ugmDifmzbsXzeCNTQsjSnETLoi?=
 =?us-ascii?Q?WV4fQg/5BXkADtsGuswfj9PzxROEJyoKFC3n8W+I6YYlpdUNOd7BqKQ1IRU0?=
 =?us-ascii?Q?1/G73hSxu+lA3eNTTqzvumS6l07G2BrnzZ5yfY3TKZaVeHAxtNGHl0Z0Ewej?=
 =?us-ascii?Q?capaoNZkXt0ZYHw1aqFf0/fSSF2UdSL0/+6XXF6rAIIHzdLSpgbyL5dv42Ve?=
 =?us-ascii?Q?AKWfieGLZToVUXvlpBTSGaq+Fxj48UgwZeS50Jt5GC9Vuml5GY5bvqfvYgha?=
 =?us-ascii?Q?sZJBKvn4dOlifRyT1PHBhxQE6hjc6+XINy8RrcqZnpGhyTRCVGfIDAkq1w2u?=
 =?us-ascii?Q?0mvO1tEAZy0LBL507x5BM245FvccpNT+wRX4rI7/JvR5TYtt05Pa1LDXZFGd?=
 =?us-ascii?Q?NCZm5j/aqr98g2QYfSWe2ElHCp6wV/H6Vcbm+n85N0PE0ogYOsb0R47F3P8a?=
 =?us-ascii?Q?ORyF+CnW3qJ0vV5OSRLuqSH/KPNus9xGIX014zFe5eW4OqiTuM7mgXEATN1L?=
 =?us-ascii?Q?qaFRXYRP6OVCRAWEu17SaarjUvVdbjEM+5KSZF6PuzexRf13DVzbijOjGTBJ?=
 =?us-ascii?Q?4pPQXdMGvSZt+SO9p96y+yUoWYWrdXaTVIzVqXBym3FOiykWuhELwWJ+hewo?=
 =?us-ascii?Q?Ht1sqfxTqzwUucqA4LkYng7uAygdG20w3UcL/LlZE332K2OWo39KM1JPpT23?=
 =?us-ascii?Q?0VBmKUKiBKhYD7OOE2slH+hopwWjd/kmutyO0X8fzA/P2oa0s8q6pMAgvBHr?=
 =?us-ascii?Q?HqgC4IKgC+wbayFS9gS9197+ugYJugi9qjk2VQi+jDXsp/q9EQkNieHgzyDu?=
 =?us-ascii?Q?9m2ckIP7kw73Cd/oxpzC4K8jMpkmt3EOUGQEKnC4B/0nQxyAmDYfalhdIHFV?=
 =?us-ascii?Q?APa2qoEaQybPbsWZ2I2G7tHoqUXD2fwUFXAh9zKhv0+GkvYiWhdF3jYbN69D?=
 =?us-ascii?Q?pi2v9bmSUQaCMAEUcJOiizL2U/Vs17utJWQJP0C1YobX1FXPw37AoIMH5HdO?=
 =?us-ascii?Q?Xgjmp/flSb9y6WpRQP7iGtsvPq84SmypydLeJsgsOTVVf4Re5DcGRjWbMGS8?=
 =?us-ascii?Q?4LhGPEiTpY2ALxRQoyPEByWDJU/Ob0LQYH/pHQLb+4QU3itRVpgaW2VrNhHI?=
 =?us-ascii?Q?VKH8T+dSSiktwA6Z88JNuwEsHW9DI/6v1R3rjMnR+aBAqAQLtwRaqrHMnHcN?=
 =?us-ascii?Q?IugwTNNtpLeIU6UF2II9HENGB8yAkeKZpQ6UIseVlCDImBf9FtTlihBoxrEo?=
 =?us-ascii?Q?GNnhge+WZRHszWrRFiUFZ9BW7OKrofvvGn3fqTAZIV7TMfvQyhk2QAzGiMTc?=
 =?us-ascii?Q?O0cBDAVWCG7uN0NlWgiRtiW67HZaKlp9g1vEZvbmU+gvUn+xSNeh6IbsuKKy?=
 =?us-ascii?Q?ifcAQrVJw+ha9EWq8MBEwMb2Lf1NFRFzLUhNsxiLJaWeGRt6D6uL0QnSkSiw?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9829fb5-b95e-4444-1c56-08dada37fda1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 22:52:04.1784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kD70Br41nM/S9UadFNv10NOjDu57UEts09XSqrQaE87aRpXkEWmJK9QcMZYz9QeGXt9EJjq4egdTMn8fGv4lCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_13,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=864 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212090187
X-Proofpoint-GUID: eWZMFmlIO-eeDfoTIR-9w6cDTMA3vTuC
X-Proofpoint-ORIG-GUID: eWZMFmlIO-eeDfoTIR-9w6cDTMA3vTuC
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
> This adds the Kconfig to enable or disable high-granularity mapping.
> Each architecture must explicitly opt-in to it (via
> ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING), but when opted in, HGM will
> be enabled by default if HUGETLB_PAGE is enabled.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  fs/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 2685a4d0d353..ce2567946016 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -267,6 +267,13 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
>  	  enable HVO by default. It can be disabled via hugetlb_free_vmemmap=off
>  	  (boot command line) or hugetlb_optimize_vmemmap (sysctl).
>  
> +config ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING
> +	bool
> +
> +config HUGETLB_HIGH_GRANULARITY_MAPPING
> +	def_bool HUGETLB_PAGE
> +	depends on ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING

Might also need to make this depend on CONFIG_ARCH_WANT_HUGE_PMD_SHARE
as the vma local allocation will only happen in this case.

-- 
Mike Kravetz

> +
>  config MEMFD_CREATE
>  	def_bool TMPFS || HUGETLBFS
>  
> -- 
> 2.38.0.135.g90850a2211-goog
> 
