Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345FE613F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJaU5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJaU5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:57:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7676013FB1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:57:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJc0B0001514;
        Mon, 31 Oct 2022 20:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=xG4eHyXvvur2xWnleGRRkTXJDdTHnULRCHXlFIHXdSY=;
 b=ZSF1RGKUFO5ItthGIDnkYTlAbH9Z/OQXfJLWSTsbhYwDjd245aqi1daBGVhj3nyu3nlo
 zGzt9DXHwuoocKdanqZIM4083gagobGyjxOw6RYwPpA/5rq+SSHjZnqMBv26tdsKLO5g
 yNhQgvHEWAflgYRVTysyd93MQez+0gIRgpYgPhtgNN54Fz5lDbrdRnHcXwVlmaepl8th
 MIyokn1fT049DAZ8LVPU0Ag/Eb0IiSmzClvSGwQkXAgQcwOeRyItebl5J3r32rsm7i0E
 N54NRkiDctQov/49fREhkppeRV0n+n8O81nsxnd6MH/zsyFH/D4d5preVVkV41TQsSP+ 8g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtcxvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 20:56:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VK3rPs025910;
        Mon, 31 Oct 2022 20:56:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtma066d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 20:56:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JquDs144UM9Pe+hyyZHBxrw02nh4FZSA3ksgElOfarFos11OcKp4JD1DMQT9qTjM136fUJfUrEzdZsHIpgtNP0QOPl29+aISH+cCYJbR2bmrZBDsLi52agt2Eq4WnDKVI5+IeyHLaFf0azHzci1gIu1AUWMlYodIx4MhNS11nZp93l+vh5qVcAhWskS4LGH/QQ38gRIwL26cEt7ZPu0qmeJgexbFadER6YxIYoTFMahfDbd1vrIHDCIZnAygmLoaY/PEgKLsd+0cTlsJoTR6scrINLu/s0PyOKwZ2hWtAEVGGVC8slehMNXkoWVmr0VkeVjJ0GTBMeXIs4gd2mFpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG4eHyXvvur2xWnleGRRkTXJDdTHnULRCHXlFIHXdSY=;
 b=ho5YJ/t/WzGmrcEj4twhyOszFr36RDfFn5KVJ/tJ3N5+VPDJzTKWeGFFScitRrRMeDYr+Ho5hD7HBNu1D4vPRB2ER/q8dJuQ5Mq3vtMd207wk7Z1dM2YeMzGYpd5Ei2bJeqQGbPktCO4yCdWfSy6MJukAwhey8Zqc8pG2/AI/2QH1GL12sGOP5pxaX+sI2W+BKIKcJ9FkVPYSfKoNbvJ3W8XHyTN3V0DQxGVrI2ERRei2ePLk48rhIhQkNmtV/sLguJPXaoP/qXkgiZpKJpwbIUcg5IM40pUHx6cE+VKDYFdyOqj8I/24KVas/LkB3viAAIwGKmZACJpsCOUgAUNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG4eHyXvvur2xWnleGRRkTXJDdTHnULRCHXlFIHXdSY=;
 b=D9ZZN5iVhc2bdqDsozygfFv8KZfmZmSpJuxeygOzS5LUSfDQ+EzRdcSw1d2KlFPzC0KRImjLJ0koTaSHSDA9BhulTA6gw/3spZeWcNxZ+g+/l6OaAmkaNf3175vJgNXsGp+5srzZl+7P6o0Vo/gvi7ckvoYfM9GS+0a7sf0otJs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 20:56:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 20:56:45 +0000
Date:   Mon, 31 Oct 2022 13:56:38 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 9/9] mm/hugetlb: convert move_hugetlb_state() to folios
Message-ID: <Y2A2hvKnyw3Q6Lt8@monkey>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
 <20221014031303.231740-10-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014031303.231740-10-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:303:b6::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4500:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dcfd9a4-29e6-4a79-4593-08dabb826b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrPZ21cidIKAnq5lV0TeqgW3EWXKfTcrWzdLXwEg5ikm6C3HRQOOPinK0AV6PpfnM0Z0GZ+GIvI9yc1AE3Zl7m3XAOkhDI7rYR0uylD3zrK5v4XkwXtcHZGePQBmvMppuL45s9m8DyIVtvv8TShNKmj7yo9i4gXa+uHq4bfwVFF5a22qrdlP7KF1YjBRL7hkHW8UYefx5VLlFQ42U/CjXeJabNfoL4TKANyTYJ0HH4woplkR+LNyafprHeKOtpUUbMNbAzDRBJnCsa6b+P/waJumYvoUuc69GlgVEQWXyYFw9WDqqZBy4842xFi6GnW75hdArIdFpxR0o0hWUJvyGdVSrwFIxlRAMhIxYLjCTk16T8+Cu5ME9g0D17PTfSNDF1PIRhozV64loMh2YdRQj7bkiTnRC9BNAarSd4rIJxRzNXDcDKd5HmEH9nKw7hmc+ECq+xO4cbaotMYq+xCc6qcm46mjEdhLOWv5IW4z7agPXxrFyAQfsZEOAD4kMaoHr8XNaVRFmzDdhHN/KKb867lA/wuopYnGF0GV6AUdJXstpo8Y1IQCvXXmLd8xzLAW8xnOc3m8aNvB74QjCNIfozsv8MD+xoRB8og70Pzxk+yUARb4vsQR14khUFzSScvcAhQ8VbA2bqGK5ZUv+buLRDIlgSeEwZ7bAx0qw21o3gCqILN+Unzi29eDGSp71H1qYR8I0V8xaeA9jGvAT2t3Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(83380400001)(33716001)(6666004)(6486002)(2906002)(44832011)(4744005)(86362001)(38100700002)(6512007)(26005)(53546011)(9686003)(186003)(6862004)(66556008)(8676002)(66946007)(4326008)(478600001)(316002)(41300700001)(6506007)(66476007)(6636002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uTCb8m5VnZGulbVBwnj3VdAs63ZU1nsxQcwFaBf5pYQrfs2kNiZI1qUggI3/?=
 =?us-ascii?Q?75BlaZHSbgyEfNyXsw/INbiEin11m2vg29LVODHiWccBHo9tRgxprdF1e5rm?=
 =?us-ascii?Q?ysVk8vieC59hv5WZ1qj15iDOVklUbx36Adt1lX7athEN9jcPYu0cs6uvvbJ2?=
 =?us-ascii?Q?YfqyqlACgsrh2MDm3maCUIahSInHXYwTmOtrn6zQq4HTUduAXQAWbtj6euZL?=
 =?us-ascii?Q?GPdOGZh2tj+OzHonnJXOcY+AAdqR/shj2KkFGl1Jgs9Gk8rZOioItkCjLPSD?=
 =?us-ascii?Q?gl1yU+uFudp0w1FhMsCOaqfYCnYCqmR2MbMIhtOGQuv+xsh/blNLlxEYess8?=
 =?us-ascii?Q?XWFdz5kno/LOFwGqoOTs8G/Oa/Afqvv4xfzm3DJnVjbi/qV2B9u5HjIG8wWw?=
 =?us-ascii?Q?/tpEAhjbT9eHSZadHlY+8OYLMBEqWvYwd8eY5gid8hhC034ZccfJoGMeu5wG?=
 =?us-ascii?Q?oVld/R5xB8B/VUkppabUfbUkuh1C0fdYM5o4E+5WXfSLTt4xTN04HS6lWwj2?=
 =?us-ascii?Q?moI2diVfkhTNN7r5UmiXqWJez8oFhkE+BALb0yZONlZgy/OkedV+yFuZtplT?=
 =?us-ascii?Q?GUraqSiGfGkr2T5rlBuufKJ2s+c93KKV9q3pK95Bd1hmf5PjSvWNWNkHpulG?=
 =?us-ascii?Q?AFpt7oKwANtqefFN6jyRfDl6iogS3LZ1v7emG3i7O94Nxzgb6501LjKuKRda?=
 =?us-ascii?Q?JkhM3qtHgv9ngqZyipxPfhdpH6+zz55FackTKfdit80wYgKxP80vGXYfdk45?=
 =?us-ascii?Q?ZqLpSEKm37Wjf89wqAtulcLgWyJSkq7KPsw8Vru/s/Ho/e8KQWac6hDyjU64?=
 =?us-ascii?Q?kKzIx9I9IEsOqQCQxeh6/cWbDWld2HzqzKWdAqcYbEnWA94ZYjXGMphUKa3U?=
 =?us-ascii?Q?HsUXUBBfX6ssJ42T5aETJqAjjrM4kSXSYv37PMGYFZeNDSUxbNAaZ9BVTnIL?=
 =?us-ascii?Q?4dt0rCYiOpptdeYwaw+5OXGZWuDEugbZYhN3GISst18pYVnd9Mzn7kolFMew?=
 =?us-ascii?Q?sPnCAJcfVluloCOaTCaCsrhDNSIuRa/24SKwlNe9hVa2F6xJI8xTeAch1Q/9?=
 =?us-ascii?Q?bX7w7EPrHsPaNtl77S3VvnQdYZYekZ4ZESaw+6un8EoILXekIVriVDafVWhy?=
 =?us-ascii?Q?cemntcG9sGOgOM+1hzpMG8kNzMbrf74NvRWLhJJMn6/kYY5/47HUHqPzugMo?=
 =?us-ascii?Q?vbEgP6HubbpaY9iid/IkXJUUXfBY1OPENGB9Cuebdb1jRVIaJk//TjGU4hlt?=
 =?us-ascii?Q?FqY27oSxfy8gZIZUcMCd4RDBFu53ErwjmF0TH6p7fBnDr+03kSrTF5eZWw/2?=
 =?us-ascii?Q?k+Onf3pzmVxiTLn6L0RY6sbFnwZnFRg6tqNC7zyxQBYi0m2ZgvIP0oLYubLS?=
 =?us-ascii?Q?klvqtmnw4COjoswvt3WRs+HAXs9hpR24lJ0KdpfnQqIxZnyMh5SCQbiuqvUa?=
 =?us-ascii?Q?pcUrSPvam+MZH09NZWw+w/DFzXrGnVZgqn0HG76HsmE2hX4P3v1PwMA5Gi7/?=
 =?us-ascii?Q?L/yySYgpyyGDKeeewTf3FZ0kX01IvtJzf7VgcOmiCaiGfbiZx95oTPRzJKxV?=
 =?us-ascii?Q?juIdFYIx4n+N6RMxiTeGt8ThJj3VIWWwTniN164OVn9oObymDeF1YoCxvTx5?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcfd9a4-29e6-4a79-4593-08dabb826b74
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 20:56:45.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QjCbHyflqbYZ7fs1YIuWvIiYELY1JoR68CPVeqjk90R/t5iFMbAqiggym0fttUDVazTN2QVT0GWomjJlU5E+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310129
X-Proofpoint-GUID: NjEGqaN2ZIx4CRnqhDK9vkDb2EpopcF-
X-Proofpoint-ORIG-GUID: NjEGqaN2ZIx4CRnqhDK9vkDb2EpopcF-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 20:13, Sidhartha Kumar wrote:
> Clean up unmap_and_move_huge_page() by converting move_hugetlb_state() to
> take in folios.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb.h |  6 +++---
>  mm/hugetlb.c            | 22 ++++++++++++----------
>  mm/migrate.c            |  2 +-
>  3 files changed, 16 insertions(+), 14 deletions(-)

Looks fine with one comment,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1328,7 +1328,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  		put_anon_vma(anon_vma);
>

It looks like there is a hugetlb_page_subpool(hpage) in this routine
before here that could perhaps be changed to?

	hugetlb_folio_subpool(src)

-- 
Mike Kravetz

>  	if (rc == MIGRATEPAGE_SUCCESS) {
> -		move_hugetlb_state(hpage, new_hpage, reason);
> +		move_hugetlb_state(src, dst, reason);
>  		put_new_page = NULL;
>  	}
>  
> -- 
> 2.31.1
> 
