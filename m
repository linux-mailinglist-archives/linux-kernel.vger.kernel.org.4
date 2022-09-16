Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591CD5BB415
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiIPVrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIPVrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:47:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F6CB2747
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:47:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GLDvqg030126;
        Fri, 16 Sep 2022 21:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=xzCb72BvLZeraXZCdfhhw9aeF+cVXx2ssBfVV5HP2eE=;
 b=ZOU2+5EnoBTnPTdCkRvV4QArlE5e5HmcumZgBzSnqZUQnyLnodaRgu4iZB7IdR5V8usW
 R0WQg4D6XtpbnGG4hPTxgfiSO6Y4YPAhhdvGqjS+Uu4nijH/1MFVar5kSjrP/6jfsbDs
 muS3tnmRGUCrTIUuKNWyvym35jJ0Cb3DIl9T97GXNoN9zIU+YlWzCumyqFQzALpsCLIm
 JSPJ1B9XIzZrVgFQssrSTC32N2lvNL0nL7GWw0f6sV2TAt4cmMqIq8sPsivoceGcUgkz
 I3fPKWqfdN93eyunMRvImZIBuF6zx3wC/qVRlYsh2TMKvAcCoVycACx5wDZA/eMmyad8 vQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xcbnhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 21:46:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28GJmbkH038296;
        Fri, 16 Sep 2022 21:46:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xacv84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 21:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTsxZWHBabzwjjq5kXHMC98J55J0/9ON6Ts69PTWiP+zp2HeaQ/PDldOLs0L72veV80UiV1JOoaHxecLblSx3d33nW1Hc+9GqYaDGuRr4haIgFj15L+PMliuc8urG1B4OCV6ISG1h9FJqzfip6pTK5djdT+/Qtyw+y9WhvmN6Vev30n8yjoNwLeHf60vlNDgQhON1dedIrB24VJ6UReZIpSpFz+rIt8qutJT1REEDj1fShVBHpvd7M5g6Vq1GfboiPOCeMDt2mIn+UJmGaYHWWmaG9rNBhI3YJ4tNN3pZXPO/EcJ+lVxCnQLOptBgb/uBXR2Ln5kyVoHziN2YPDbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzCb72BvLZeraXZCdfhhw9aeF+cVXx2ssBfVV5HP2eE=;
 b=S/EKhePwfYj7QingGOawypHPtdflx67ij9r1PL0b23o5V4rFeHzHjfp+Lny6i5lZTEFYJH3nk1nxpvOCnDGr9oivZJkMVTAbBgfkm9obatdLiIwXR8jECB672xJhOM/QwqML1tt0R+6e25F7M7/GUi+x6PegYxSz56eLGKA7UyfthMSZ5IXFt140gdOwo8CMPGflEWMvHuALiOVEnkLgjDB7B7Vc0pSAVjXLR4PG0msatRYJOfUU2iLF61aYIArrtbUIVQmGhexD1clqP+nlymrmyath4EAJCgi1hM8tN+hqPawQ5SfIe52wn5tFBTifVFNxtTEOQcxDrUWxoyIfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzCb72BvLZeraXZCdfhhw9aeF+cVXx2ssBfVV5HP2eE=;
 b=DABizDG6YHe3uBkpqgR/MIQaM2yHijlFRE5uCEcns/JjMLm7GCMrPOptjeiOSZBC/sAuEgU5lUujitS5Pv0//GpgdvNz4yLQEDowYZZBFhhTHXs2IdFzri7yKwH+brBQ57gpAJ8j/Lw7ETd4ggKJKDi0Qs8qv9j7VW4DJna5Br0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4490.namprd10.prod.outlook.com (2603:10b6:806:f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 21:46:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.017; Fri, 16 Sep 2022
 21:46:42 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2] hugetlb: freeze allocated pages before creating hugetlb pages
Date:   Fri, 16 Sep 2022 14:46:38 -0700
Message-Id: <20220916214638.155744-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:303:b7::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd6f247-1328-4c23-6403-08da982cf174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RBZ8Ng2Xv2y3ZY0XtUYC1yB5E8rgLNzm4uwh3BVnOgFHlNM/L3BUDdx+NI4JrdIvx2Wa4+Uh67wA+6IGtavDZFsD//M+79W3JEi1E2f0POGyS1qEuCldq+auE2KhGaK7ZXrpv3TcB62B4BqAZXCeiAOdvkScu9RE1i21KyrJlzUuqiBzuqgofwUE2SG+PgzU1h24Io609n2ewNSW07j9zAz9bIbiUrZhlWHYm+gFJgqpOxAfmqOUC0OSAffq6zlwvG/WQ+NLph7FXrjd3/hYtEPJZ4V0T0JwOx1AydQbDtFeIt951BdSej6HGM2PNtnvn5CvPIQOA+iz8COAHTqonW7JW1knHycGvldpBDPBDK9LfmqbRjHgeXXBcSgr+9lrfK4MSa8+O+TxbooSHMDY64TVaRe0RKMvu7D4RRkpQXuxi9WT/VZRz3RaXwEgiKV6HZtsbhz1FrZA8glS9l+FSOxWIZxgkKg7S+HNia4SdTtmbRJMG1oLvBJn7vfH1RIQMcI9lphzzLilXNNvicim9cOxdZUidoL2ZMp5wcotlQPjvAT4XQTJTH9LEsOEhHTLm1MKSoVJnIQ5RAw7uVUZ5nLyqxv+RIiR5RpD4SdCwE7qPtLmR0XPKFo7GwsnB3laSmiL5/v1MZdvqiDk1siQ2Qsbpr2FsO+gCJJzPojUBXMCxXHi9v7SHve7MGnqX46RWfTKmL20s25M2cy8NWf8LieT4G4LE5DcdchK2Q3poAKT7ckEm64XeFs7gAVhurNzU03g11pwluf4OOQFvY3Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199015)(38100700002)(6512007)(26005)(8936002)(2616005)(86362001)(6666004)(966005)(6486002)(478600001)(41300700001)(6506007)(66946007)(1076003)(36756003)(4326008)(66476007)(8676002)(66556008)(54906003)(316002)(107886003)(186003)(83380400001)(5660300002)(44832011)(30864003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWXTT1QwkHQAxPrxN7l/V6b9pjzJoAhJLD0Wqd+8gHfEVKwjgtv1kg7SvzJq?=
 =?us-ascii?Q?J1WuuTlZwm6KSiWsUlTdKOd0UB91VbviBID+kfT0fXQ6qS3e58deTc5q0iFJ?=
 =?us-ascii?Q?dWkcXaMBZuNyYtquzADI9FQuUOvyhKWaDOE8gBwXHPrVsmfOJ+hJbOZAUUuX?=
 =?us-ascii?Q?labnc6Z0kKjefLvcsZHsya/8ZjiUZoYtWS0JQgy0sqCDZFgPgIgJv56A5rIu?=
 =?us-ascii?Q?cMs6N9yhCjFL6YeeyGOeYpkY9hZFmpGKV/Z/9PjMQxbm+gmuAyMRfXQBgZSC?=
 =?us-ascii?Q?SSoR+cfOFCNSn/jERY96/jNKjx3hCtWzO2qItoGrFDw+87ztjDUy6eby9tVX?=
 =?us-ascii?Q?UsPtCi3xIUWHuwFrgDr2KH5SKnX8dmz6IE9j+EVKF/xf4CeZ6mOnfV2si+k9?=
 =?us-ascii?Q?qf38QnDUaeyiRMWkoZpTQxan6XeohB56N6rfFeFT9IPoQuwtDPciu16ETs6D?=
 =?us-ascii?Q?omWqDMC+CcGHN6p2Vtfl7+hwMYl41P7MWrFAvlf2+HHHDhUq+n8N6ZbyCExB?=
 =?us-ascii?Q?KXhUf9ZEFMETtqRt+WfmS4HtwCg5i2yZemOGkURjzAbbtf+MMvDTyOOKHZ7t?=
 =?us-ascii?Q?doUBrnaG17mGhGL2Bu9s2h5BUMJk47mFiTdUcxb0GytttKHnnz41eGz/M15p?=
 =?us-ascii?Q?CCWr9ZKlQopiUbrxnXUBato/dYXo953IGXkEVC7J9xdf+ptrc5OtwUsSZaMY?=
 =?us-ascii?Q?aAbztcb9HS+FpMz4KskzKXWgExyJWgHoOfO89gq/4NohbWgKQ3VVPOZmPJID?=
 =?us-ascii?Q?zbue/hdXZk0GiIg2lOo8bflk4gRPPtAZBYpjTh5t7DLFD0uIcQnkPiF95Wpz?=
 =?us-ascii?Q?NjMWMn86cHDfU2uqfHp90pF3ICdziRqBfuv87eZMM7CmFTK3EX+1lFx2vh9W?=
 =?us-ascii?Q?A/ccjsZys81w/E81m3z1SGJ0QFvMTzB/YWTGIWfjdejHMOvNGQw1iaBIgwe9?=
 =?us-ascii?Q?z8kQwFQJCt/t5XoQuG7cifhYMgfGDz5HnkuQB12JVIO90/5GZ+jC4+woE3ub?=
 =?us-ascii?Q?mPGp6Cn/V4wnt8ZKJECvE4QuykzizSYR4gg1cj9ZKyUS36ouTUB1chwTRaqJ?=
 =?us-ascii?Q?Uacd8D1zSwKFmP3xvAI/TJ+XpE2XiELhz6b24TYO2xFU7rmgQSQmY4iOf7Kc?=
 =?us-ascii?Q?ydU5ekaqwlf8dvQmZiFj0Z0wt0LdWjZyxi0w8VZ/1MH1RjjjHHHVUZt0mIrL?=
 =?us-ascii?Q?SWzHZo/iNHzGcXpoNT3gXetENjJIU/BD08rIDU6qtX/EQAB/ZjPIP3b5TLzl?=
 =?us-ascii?Q?aMiNB32rw59+Dj3nzZIkwjyM0L3dTX1J79DY+Mm6jDHc6bZbNxAu+jmoFlfg?=
 =?us-ascii?Q?dFYUWkwy/Y3u5RSaBfykas1n7NqI2zRS9JGnkQ3zafXIf7rQV62Tgke1uKCi?=
 =?us-ascii?Q?2kYpbOfaDEWzzZAhEsLQQLrA+v/eRJ7YXK6INO66T5iQ9L92/aP4yFyBeVQf?=
 =?us-ascii?Q?EJg6DQu8458/CEHQhZ+fJB3DhAZ71dYOnQxH01Eo/3V0OLh6TSDqWi8Q59Aj?=
 =?us-ascii?Q?ZVWIQy5JwYt8PjbARqGXOOjXpH8K9Lz29Jb9wJ4AzGPlvrvgxtyBdQSWgTU8?=
 =?us-ascii?Q?jdzeedvXZHYI2lZsa0rUnMtHL6kgFfFqYATFsAfz2KkHraIx9tKvVtE2yxUY?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd6f247-1328-4c23-6403-08da982cf174
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 21:46:42.4203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozCPAY7jeKyXMYCUEvQZjNmZROYSjKjDOE0Emn3zq86G1EfCYIaL+v5vOrdBb/I3vByBO80cWyeG9QDoc7b6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_14,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160155
X-Proofpoint-ORIG-GUID: CbxQvb4RrpzJFAf-0mdYU7gZH7mnehqB
X-Proofpoint-GUID: CbxQvb4RrpzJFAf-0mdYU7gZH7mnehqB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating hugetlb pages, the hugetlb code must first allocate
contiguous pages from a low level allocator such as buddy, cma or
memblock.  The pages returned from these low level allocators are
ref counted.  This creates potential issues with other code taking
speculative references on these pages before they can be transformed to
a hugetlb page.  This issue has been addressed with methods and code
such as that provided in [1].

Recent discussions about vmemmap freeing [2] have indicated that it
would be beneficial to freeze all sub pages, including the head page
of pages returned from low level allocators before converting to a
hugetlb page.  This helps avoid races if we want to replace the page
containing vmemmap for the head page.

There have been proposals to change at least the buddy allocator to
return frozen pages as described at [3].  If such a change is made, it
can be employed by the hugetlb code.  However, as mentioned above
hugetlb uses several low level allocators so each would need to be
modified to return frozen pages.  For now, we can manually freeze the
returned pages.  This is done in two places:
1) alloc_buddy_huge_page, only the returned head page is ref counted.
   We freeze the head page, retrying once in the VERY rare case where
   there may be an inflated ref count.
2) prep_compound_gigantic_page, for gigantic pages the current code
   freezes all pages except the head page.  New code will simply freeze
   the head page as well.

In a few other places, code checks for inflated ref counts on newly
allocated hugetlb pages.  With the modifications to freeze after
allocating, this code can be removed.

After hugetlb pages are freshly allocated, they are often added to the
hugetlb free lists.  Since these pages were previously ref counted, this
was done via put_page() which would end up calling the hugetlb
destructor: free_huge_page.  With changes to freeze pages, we simply
call free_huge_page directly to add the pages to the free list.

In a few other places, freshly allocated hugetlb pages were immediately
put into use, and the expectation was they were already ref counted.  In
these cases, we must manually ref count the page.

[1] https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/
[2] https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@oracle.com/
[3] https://lore.kernel.org/linux-mm/20220809171854.3725722-1-willy@infradead.org/

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v1 -> v2
- Fixed up head page in error path of __prep_compound_gigantic_page as
  discovered by Miaohe Lin.
- Updated link to Matthew's Allocate and free frozen pages series.
- Rebased on next-20220916

 mm/hugetlb.c | 102 +++++++++++++++++++--------------------------------
 1 file changed, 38 insertions(+), 64 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5ea0b1b0d1ab..9b8526d27c29 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1787,9 +1787,8 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 
 	/* we rely on prep_new_huge_page to set the destructor */
 	set_compound_order(page, order);
-	__ClearPageReserved(page);
 	__SetPageHead(page);
-	for (i = 1; i < nr_pages; i++) {
+	for (i = 0; i < nr_pages; i++) {
 		p = nth_page(page, i);
 
 		/*
@@ -1830,17 +1829,19 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 		} else {
 			VM_BUG_ON_PAGE(page_count(p), p);
 		}
-		set_compound_head(p, page);
+		if (i != 0)
+			set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
 	atomic_set(compound_pincount_ptr(page), 0);
 	return true;
 
 out_error:
-	/* undo tail page modifications made above */
-	for (j = 1; j < i; j++) {
+	/* undo page modifications made above */
+	for (j = 0; j < i; j++) {
 		p = nth_page(page, j);
-		clear_compound_head(p);
+		if (j != 0)
+			clear_compound_head(p);
 		set_page_refcounted(p);
 	}
 	/* need to clear PG_reserved on remaining tail pages  */
@@ -1936,6 +1937,7 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 	int order = huge_page_order(h);
 	struct page *page;
 	bool alloc_try_hard = true;
+	bool retry = true;
 
 	/*
 	 * By default we always try hard to allocate the page with
@@ -1951,7 +1953,21 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 		gfp_mask |= __GFP_RETRY_MAYFAIL;
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
+retry:
 	page = __alloc_pages(gfp_mask, order, nid, nmask);
+
+	/* Freeze head page */
+	if (!page_ref_freeze(page, 1)) {
+		__free_pages(page, order);
+		if (retry) {	/* retry once */
+			retry = false;
+			goto retry;
+		}
+		/* WOW!  twice in a row. */
+		pr_warn("HugeTLB head page unexpected inflated ref count\n");
+		page = NULL;
+	}
+
 	if (page)
 		__count_vm_event(HTLB_BUDDY_PGALLOC);
 	else
@@ -1979,6 +1995,9 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 /*
  * Common helper to allocate a fresh hugetlb page. All specific allocators
  * should use this function to get new hugetlb pages
+ *
+ * Note that returned page is 'frozen':  ref count of head page and all tail
+ * pages is zero.
  */
 static struct page *alloc_fresh_huge_page(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
@@ -2036,7 +2055,7 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 	if (!page)
 		return 0;
 
-	put_page(page); /* free it into the hugepage allocator */
+	free_huge_page(page); /* free it into the hugepage allocator */
 
 	return 1;
 }
@@ -2193,10 +2212,9 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
  * Allocates a fresh surplus page from the page allocator.
  */
 static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
-		int nid, nodemask_t *nmask, bool zero_ref)
+						int nid, nodemask_t *nmask)
 {
 	struct page *page = NULL;
-	bool retry = false;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
@@ -2206,7 +2224,6 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
-retry:
 	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
@@ -2222,34 +2239,10 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
 		SetHPageTemporary(page);
 		spin_unlock_irq(&hugetlb_lock);
-		put_page(page);
+		free_huge_page(page);
 		return NULL;
 	}
 
-	if (zero_ref) {
-		/*
-		 * Caller requires a page with zero ref count.
-		 * We will drop ref count here.  If someone else is holding
-		 * a ref, the page will be freed when they drop it.  Abuse
-		 * temporary page flag to accomplish this.
-		 */
-		SetHPageTemporary(page);
-		if (!put_page_testzero(page)) {
-			/*
-			 * Unexpected inflated ref count on freshly allocated
-			 * huge.  Retry once.
-			 */
-			pr_info("HugeTLB unexpected inflated ref count on freshly allocated page\n");
-			spin_unlock_irq(&hugetlb_lock);
-			if (retry)
-				return NULL;
-
-			retry = true;
-			goto retry;
-		}
-		ClearHPageTemporary(page);
-	}
-
 	h->surplus_huge_pages++;
 	h->surplus_huge_pages_node[page_to_nid(page)]++;
 
@@ -2271,6 +2264,9 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 	if (!page)
 		return NULL;
 
+	/* fresh huge pages are frozen */
+	set_page_refcounted(page);
+
 	/*
 	 * We do not account these pages as surplus because they are only
 	 * temporary and will be released properly on the last reference
@@ -2298,14 +2294,14 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 		gfp_t gfp = gfp_mask | __GFP_NOWARN;
 
 		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
-		page = alloc_surplus_huge_page(h, gfp, nid, nodemask, false);
+		page = alloc_surplus_huge_page(h, gfp, nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
 	if (!page)
-		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask, false);
+		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
 	mpol_cond_put(mpol);
 	return page;
 }
@@ -2375,7 +2371,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
 		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
-				NUMA_NO_NODE, NULL, true);
+				NUMA_NO_NODE, NULL);
 		if (!page) {
 			alloc_ok = false;
 			break;
@@ -2737,7 +2733,6 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nid = page_to_nid(old_page);
-	bool alloc_retry = false;
 	struct page *new_page;
 	int ret = 0;
 
@@ -2748,30 +2743,9 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	 * the pool.  This simplifies and let us do most of the processing
 	 * under the lock.
 	 */
-alloc_retry:
 	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
 	if (!new_page)
 		return -ENOMEM;
-	/*
-	 * If all goes well, this page will be directly added to the free
-	 * list in the pool.  For this the ref count needs to be zero.
-	 * Attempt to drop now, and retry once if needed.  It is VERY
-	 * unlikely there is another ref on the page.
-	 *
-	 * If someone else has a reference to the page, it will be freed
-	 * when they drop their ref.  Abuse temporary page flag to accomplish
-	 * this.  Retry once if there is an inflated ref count.
-	 */
-	SetHPageTemporary(new_page);
-	if (!put_page_testzero(new_page)) {
-		if (alloc_retry)
-			return -EBUSY;
-
-		alloc_retry = true;
-		goto alloc_retry;
-	}
-	ClearHPageTemporary(new_page);
-
 	__prep_new_huge_page(h, new_page);
 
 retry:
@@ -2951,6 +2925,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		}
 		spin_lock_irq(&hugetlb_lock);
 		list_add(&page->lru, &h->hugepage_activelist);
+		set_page_refcounted(page);
 		/* Fall through */
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
@@ -3055,7 +3030,7 @@ static void __init gather_bootmem_prealloc(void)
 		if (prep_compound_gigantic_page(page, huge_page_order(h))) {
 			WARN_ON(PageReserved(page));
 			prep_new_huge_page(h, page, page_to_nid(page));
-			put_page(page); /* add to the hugepage allocator */
+			free_huge_page(page); /* add to the hugepage allocator */
 		} else {
 			/* VERY unlikely inflated ref count on a tail page */
 			free_gigantic_page(page, huge_page_order(h));
@@ -3087,7 +3062,7 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 					&node_states[N_MEMORY], NULL);
 			if (!page)
 				break;
-			put_page(page); /* free it into the hugepage allocator */
+			free_huge_page(page); /* free it into the hugepage allocator */
 		}
 		cond_resched();
 	}
@@ -3478,9 +3453,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 		else
 			prep_compound_page(subpage, target_hstate->order);
 		set_page_private(subpage, 0);
-		set_page_refcounted(subpage);
 		prep_new_huge_page(target_hstate, subpage, nid);
-		put_page(subpage);
+		free_huge_page(subpage);
 	}
 	mutex_unlock(&target_hstate->resize_lock);
 
-- 
2.37.2

