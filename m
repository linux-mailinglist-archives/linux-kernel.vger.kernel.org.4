Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500815E6FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiIVWl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiIVWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:41:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4307106520
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:41:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MMNsfU014822;
        Thu, 22 Sep 2022 22:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=oKeKQuDIm32+/l3+A2Dfc5oWvPgZR1CL27ISyUzjRWw=;
 b=P1v5TEIYVdfbYiYRkggwvoC54nO76zcEicyz9cwMDmDjJgUMMR6M15ZAHJ6j80MI9DIl
 B3rE5EC78+jvsXAh18vTr3Zui6YmhauPpN004qAvfEdy63w1VymD+cuTyR2hI9aIdXzW
 TQBVt1ZiFxpMZzQE1QtSJjxYARh7mQVpi6juzxylnQCekhixpKQoN7hgjgudTmr/EKdm
 gYz/+U/MgdK8QY/OIowIImu4iOaKnpznamkXnEMxRnVDJmRVwq2PB1MclAc1TkpPJ4T6
 hMiIuEV+tGeIUN23yMT0pA8pOjmT7idpwYd6/2OQsb25TR8a+Tr87mlNEjHHKyvbgRq0 zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69ky4hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 22:41:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28MLpdQR001919;
        Thu, 22 Sep 2022 22:41:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39ta3ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 22:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbRN/59hlNfhUFHfgY/5GMZKtImDAcfMGUy6KFHQVu/WpRsqCcbi1fpS6MdmxNg03Igz6VIPuxlsokNnOCjxdVKCk/Mq6HXtw3IRCWCWHKc9sqbDtRd4jh85p/yDHm5uEBFhxhbM1nEKLVD6m3IqX+rkiWhu1h7mHVsENPU8xPbNqcnisTwTTW4bIZ1NgMTkAHLX5hLtzCJh9QMO21YOP4ysGqlHPRpK48k0taHaEUqjGe1zc+8V4hulEBfLB80idORhRaS0mIDuLSYNqg4q13DSQP3V/FBT9CPHD6Dhp+spYchNQmaMoIHhrQyE79tY62CYwWWsENBUwP3/tsu8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKeKQuDIm32+/l3+A2Dfc5oWvPgZR1CL27ISyUzjRWw=;
 b=apQ6F29f4cQ0SNavNddPlgudGeaKwNi4pvUCZkXR/LyTmzCNYXhseVnI3zW5vqo2dHZvR1sai5owyCutOXe9a0FGaQZ85z+Ckj9Bm5GLA/SvnJeXxJaUAcgPCRjXl6A8yPPf92FWC96hcRHBBbBClwlh5hy+TS2UlY53OJ3ND8N3w08IfUV97+H6TdU51I3cFlPEsJPRUHyw1oQy7B4/eSvViTAE+rhw38pRBPB4xwUfApIqqzkMbi0sZ9Ao+ncjhr4ilch6auW8uSak3XpxDnUdeB2UEQvPAUuyiWqpwVJlqD5VNtFsJmDVYYpeU5V7V50f+HbbwLX6FkkysrdWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKeKQuDIm32+/l3+A2Dfc5oWvPgZR1CL27ISyUzjRWw=;
 b=OcWJ+DCAasdXDBjMfOJ9fTkkxL+/60UdPM275KZFSFjYIxAIMC1X23lJRfrD+w4/VZNQRl7O+jtvilTabxlU5lEp+I7p2Brp/ZcThLL58NjdeH2Nm1WDUEUPLKobafZRK3EAbq9X2aUayKiApWm4/0fRaeD3DKyoLP0Y78oanic=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 22:41:39 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::7dd3:9e44:abb5:c679]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::7dd3:9e44:abb5:c679%5]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 22:41:38 +0000
Date:   Thu, 22 Sep 2022 15:41:36 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/hugetlb: hugepage migration enhancements
Message-ID: <YyzkoGJsIXVFW6ZL@monkey>
References: <20220921223639.1152392-1-opendmb@gmail.com>
 <YyzEz4snl2x51iTY@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyzEz4snl2x51iTY@monkey>
X-ClientProxiedBy: MW4PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:303:85::24) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a30fc0d-b982-495f-ff5c-08da9ceb9cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RoD+UAaWhR5cIYZfhHX8QMdSudAj3i2U1DQ+7vW/DVvw1kl1lQw2JqQJWJQIeorGQ35P9vrV4UmCNssmn0T+OYYEo0HV6IrQKg2OQmZPndIvs10tOWxsn7dq9INo9Oev/s39scLDIdanTssRLPWVvbCZHO5XUqyOEcRyd/LMt757UPnpztu8elhmx3jbkDeHIA87UPOCqRKaBqSiuSz+pcoNrnKGxXnZMn7GNzxMf0WbwfCYSKMwqmlLzqjKaJMLZuprnUjJXYnP93C9KA7s88BpMd5gRYYovc/Ke7f3OH92BRbdoMyyHNxRetGh2b18rgPY1tBU33FV20X46L5Lh41LDGH2rF5D9I4bIK6oCWRFhs6o0dlmf5NyL/oeiaCT1KTvQLwNhGnimqmcz9uf7Tpcsas5I0W3wVIp8BwC0ZF3bNfz0lu0Fi8dCfwAkjnJYHXJ29WtEwd4cF2yEfBpG0gDd6qXmVIgD0W8KnyZ+deTgDYUA6eqw6B7k4IrWEMUSCfzaNa7SlxD/6z+3ToSrqvouYNf4WGkFzvWXKwxburIKy7NGHViyhxZnrXgudwFfqq89eveLBz8Jgcgxkq/CBfrhuysI83XD3FDwHP1CtMK9cJ5BSsrwyw+s0ImMDKDVfJ+gK9VftG4sFrvQL1XVqduOLcqPlQtchgODULGGgsMMsTiqDReREQoh6jDd/GJNjjqWCCM9SnvPcpk05h4gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(86362001)(2906002)(44832011)(66556008)(8936002)(66946007)(6916009)(8676002)(66476007)(478600001)(5660300002)(33716001)(316002)(4326008)(41300700001)(6486002)(53546011)(186003)(6512007)(83380400001)(6506007)(38100700002)(54906003)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pmmPaSzuNdvHbkIYE44bkbBNFcvXnPjbHfHfRnvQGTL+w6jfVIB4CbBv5oAg?=
 =?us-ascii?Q?PaTOjdBZ1PfiQZVpA8wj+P9G3K4Kj1M3FXK7Rf6a6kQVy7EoQDnoHL90QmG3?=
 =?us-ascii?Q?9ZQ99meaag+iTUDeo7w/P4thNJiP3DYzsx9XVnpVQFoPzI/yTzBE5FKOgxqb?=
 =?us-ascii?Q?pBr6ZwonsXDcEb6JnbF20GN+m+pcMHSp2+4HWDxjo5EieVrdvbG4c/D4dAZo?=
 =?us-ascii?Q?Kwyy3ilyUXTUvx16I0ulhUCIYz6Z04340peJ1paoYPDEgnj8GJEBo/CDaCuK?=
 =?us-ascii?Q?NREtMQVOy3btz8/PtPQIYKFfeWmr75UhWI+Siz1cA7XoLXhd84AkeCei4DKR?=
 =?us-ascii?Q?sEbSiy7+K7GQKKhQoDqxDHTPkFFhk7MccA3IbDR8iUCtyCALdp2fHSFrJlcC?=
 =?us-ascii?Q?F3XxslFBYRR9OlRat7MECRDkUSXs+0BpSKIcGLt9TKUVTmuV2R22/mfGNfUE?=
 =?us-ascii?Q?hwn0fLGNLO89NhNuLUzAqJDhCQS6anRLwbJ99qLtNGCIBlmUCsTzSZr7B0yY?=
 =?us-ascii?Q?TLE/7SNUbWL5QURjKKA4k9g6m0LymhimN8bWZZOYaZu6oO8NgKc8uDpTOoP0?=
 =?us-ascii?Q?axFUzq+/EG4PDFuniHfXF4+P+yq+P31HT+T/VydczncdNUKiF9N37Uq9PRhG?=
 =?us-ascii?Q?aiJS/aBzVoSZGOTJW18mMVDeeo3IRxrySHzDDTZlGH3zzLZKjwl/aaMZyZfz?=
 =?us-ascii?Q?+Yht/yNp3cslx3SisdOELWKv2emuV0BCj8FUrlvdDfQBgbcLvjujQKK42Fnw?=
 =?us-ascii?Q?dRluwullSPu9IBlWQtzdL7dcdZB5ONpDNbFaEoTt9/C/qM9Ls8ZSBuPNtlgJ?=
 =?us-ascii?Q?4B6f2LN3d26gOOASYDxZ21iCWiiA5v5Ip2hZ42HGHexTRKnAVBzPWpy/R+k+?=
 =?us-ascii?Q?7tn8gl0RVAOOpfxJvC/JqmCLX0PfrnRdHLyLgFhIQUrd3mXW3/f5y7Hkj7oK?=
 =?us-ascii?Q?YXNV99WUqNzGLXJuzdv5ysJU5ktaAp+qkCQ1Ob44teO8qq+Wdh+uSJGchTTt?=
 =?us-ascii?Q?ANjQY016+540rRwDtgoN2BRA8aCeoujwGfncj/0lV5uj89hZgcJrSIcigyvV?=
 =?us-ascii?Q?0vVX3gmF+W2qw0uxnTmvb0dNTDwbXkLuZ/Y/uc+JgZidSCnY+ljt0Nu3yrRd?=
 =?us-ascii?Q?G4Em8wWynO27Pn5JzJD9h0y0qduyeAgTk7pD/vDGD6GCCw1iRcQUJ5l+OE4D?=
 =?us-ascii?Q?OjWUgYlW79KkO7mCbRqs603qZMNEwhZmfoXbl7kUICHDY38RIF9LyNxuV1Oe?=
 =?us-ascii?Q?DgsRuh1GwSZF9zABKFmwvAlLeyb0zQTdLRLXFLOZUbISltv6rOydkHYwjeOD?=
 =?us-ascii?Q?yHWYLv1JvsN3tMq5bUZJizjGTWhJ9NxZUyBkps4d1h3Oq133YtJhTQKugolA?=
 =?us-ascii?Q?ra+6vslbrofwcbDfPerk7n6O8umMw4C3Z8yf9XVTPlnYhxi8EcxnaNfIJN+o?=
 =?us-ascii?Q?3NLQXJ0lN7ZHgQP+8wbDoe73CsTw3/42c6xFUtSlGGB2XcGhlavrBcPc0ibj?=
 =?us-ascii?Q?d9xwMjtJYr+XyItpSrYmSUQoMNJNbLv3LPx+bzEVosr3wkB6kEb/65GZLrik?=
 =?us-ascii?Q?nLGRVOsRnUNsVvbgk3qsoij6k0oqe4LVCw8VryeQCSxzu+XOYENB0W2cUN+0?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a30fc0d-b982-495f-ff5c-08da9ceb9cb8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 22:41:38.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ro/F2LTLw85KngCGWoHhOIhWjPKmQthfEwDhA2gUsow3BowSBuz7BR5UDJ9jGuXPw0umka3x/iGCgnBxn6Hfuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_14,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220145
X-Proofpoint-ORIG-GUID: yWosrFLOItw5AD8tQksEcuw8ynyPBlD_
X-Proofpoint-GUID: yWosrFLOItw5AD8tQksEcuw8ynyPBlD_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/22 13:25, Mike Kravetz wrote:
> On 09/21/22 15:36, Doug Berger wrote:
> 
> As noted above, for pages to be migrated we first try to use an existing
> free huge page as the target.  Quite some time ago, Michal added code to
> allocate a new page from buddy as the target if no free huge pages were
> available.  This change also included a special flag to dissolve the
> source huge page when it is freed.  It seems like this is the exact
> behavior we want here?  I wonder if it might be easier just to use this
> existing code?

Totally untested, but I believe the patch below would accomplish this.

From aa8fc11bb67bc9e67e3b6b280fab339afce37759 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Thu, 22 Sep 2022 15:32:10 -0700
Subject: [PATCH] hugetlb: force alloc_contig_range hugetlb migrations to
 allocate new pages

When migrating hugetlb pages as the result of an alloc_contig_range
operation, allocate a new page from buddy for the migration target.
This guarantees that the number of hugetlb pages is not decreased by
the operation.  In addition, this will result in the special HPageTemporary
flag being set in the source page so that it will be dissolved when
freed.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  5 +++--
 mm/hugetlb.c            | 12 ++++++++++--
 mm/internal.h           |  1 +
 mm/migrate.c            |  3 ++-
 mm/page_alloc.c         |  1 +
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cfe15b32e2d4..558831bf1087 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -702,7 +702,8 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-				nodemask_t *nmask, gfp_t gfp_mask);
+				nodemask_t *nmask, gfp_t gfp_mask,
+				bool temporary);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
 int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
@@ -1003,7 +1004,7 @@ static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 
 static inline struct page *
 alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-			nodemask_t *nmask, gfp_t gfp_mask)
+			nodemask_t *nmask, gfp_t gfp_mask, bool temporary)
 {
 	return NULL;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8bcaf66defc5..19de8ae79ec8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2308,8 +2308,11 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 
 /* page migration callback function */
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, bool temporary)
 {
+	if (temporary)
+		goto temporary_alloc;
+
 	spin_lock_irq(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
 		struct page *page;
@@ -2322,6 +2325,11 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 	}
 	spin_unlock_irq(&hugetlb_lock);
 
+temporary_alloc:
+	/*
+	 * Try to allocate a fresh page that with special HPageTemporary
+	 * characteristics
+	 */
 	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
 }
 
@@ -2337,7 +2345,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
+	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask, false);
 	mpol_cond_put(mpol);
 
 	return page;
diff --git a/mm/internal.h b/mm/internal.h
index b3002e03c28f..3ebf8885e24f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -800,6 +800,7 @@ struct migration_target_control {
 	int nid;		/* preferred node id */
 	nodemask_t *nmask;
 	gfp_t gfp_mask;
+	bool alloc_contig;	/* alloc_contig_range allocation */
 };
 
 /*
diff --git a/mm/migrate.c b/mm/migrate.c
index c228afba0963..6505ba2070d7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1610,7 +1610,8 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		struct hstate *h = page_hstate(&folio->page);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
-		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
+		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask,
+						mtc->alloc_contig);
 	}
 
 	if (folio_test_large(folio)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d7b20bf09c1c..2b8a5a2b51cd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9166,6 +9166,7 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 	struct migration_target_control mtc = {
 		.nid = zone_to_nid(cc->zone),
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+		.alloc_contig = true,
 	};
 
 	lru_cache_disable();
-- 
2.37.3

