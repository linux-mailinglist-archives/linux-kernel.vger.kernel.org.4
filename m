Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54A1719071
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjFACRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFACQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:16:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDE3138
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKGtB7031560;
        Thu, 1 Jun 2023 02:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0QsGUeSC8PoHDvjhcOgTqj5kZeGqMxkW78nbUd0JW7g=;
 b=q1UTECjxTpcHTNNfj20XDQOUL47FyCdtDzR9+Znq8LhPilw2c5ER92UgPDJvlag42mWJ
 cugsR453y2QLfGBSb/shYH9/usZ5J4TU64rdjD4jv2n0Ystua4MFWwtD5su0JDF2EYz8
 lHuC+ThdxNSewDwmola1jU7jsZi7WWwVtTGIR+ujm5DtTd9Fqfxu/D8D1OFnBYs7UzFN
 jEc5+BPYF/sNmAneDWDpic3zyHeHpFV4bLf0sVY6L9ZyBRETCyIAlFcHlzp36t4OA8dD
 RJNSWtZH9cMmhyieYsaBGkSPJAv6K7E+1/L7Z9RIqZdmy6i/195NxM4MD3MqgOY1PzoJ Zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4yhmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3510ZJ1N026039;
        Thu, 1 Jun 2023 02:16:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8ad2bag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtfOR/3SoPycPBpwJaKWH1HMGYxRbigbLBMUaQOUlCx1a8svh1QMq8x3UjnVz1sepkjwNWAww45tYl0lFgwupKWCLE8/4VOz2b+rpRCckhpIHh3hfepze8ybKpRXqlOsiBiaZgDRYffDx5V1UrkXiYmqSFjjlP7a2s5NnSEkV0QHcJgjbWf6FXXk4GGnTYKNdHVyvT7JMUSR7MdPDk8IqIaB7m8BJGc8Ezng4IM57HgM3t7uRAEirtycn5y+wqW3gCvl1ClHXPavHj7Al5N12GvNo8ra/cDgcUtWaAlCcg8IrnpImqItzmH6/mO4jH0AOQ0hzQxqsh2/la666n/GEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QsGUeSC8PoHDvjhcOgTqj5kZeGqMxkW78nbUd0JW7g=;
 b=G14Xt4pzt7qO7hO+cONdY1dKD7YaQywuI29O9ewZXQ7tPBUD8+38BcJ9PBe/SyRGRoe4C7Yf1KdXNb4xOG+fLHDDBhZcrmw6pRU3D1q1cKj0qUnzJiOCWS65eSUW5vSi8S4xc1B4C4GjvZwiKdKuDPouo4k5yfUtqXnuxehxQ/GfrrUwKQ4SIktZZKN+vdffQkKEnJC3+8k4z5PUpE6qMMBeht4bdmvOvymIdHyv0PrwgmwOHmUUPEpaOG6XjLIjpbHS7+dpb/G9jX5cVaqJxUgB2roc6GFk96NgA9lChrLQciBBJZRIDzjxfjtG1Xj1FV2ADXuhDJWIqRYotcvV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QsGUeSC8PoHDvjhcOgTqj5kZeGqMxkW78nbUd0JW7g=;
 b=oRIKA1CM4Bm8/wxk3z0Vn5DiM/u0nnOIfH9GVrlPSdZY4M+q9fAf2eVXdNT0gWIsWpifuTeIJcIFdMutg+mpAizqZInNHln1AESoggqZuhAxQVzasQmj/6d0Z2qQytvKnNU6nMIZ2H8hcdwzgSXpW8Ms/C5eIdr/zhvrGnxwdBU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:33 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 07/14] mm: Remove re-walk from mmap_region()
Date:   Wed, 31 May 2023 22:15:58 -0400
Message-Id: <20230601021605.2823123-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 0592cebc-4244-4810-e025-08db6246385c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ns9EikDrQ/hEJISe0sqy+Y3EJ5EhRpOadFwATE7gkjGgix3cO5a3ymJBkJ7opWzzVg51g6TjNHUAVjQXy1TQ56Z8a556zUzBaESB55diit7XEbnrw09a+kCxuqjQl0yzWftqNQX/6MjJKuOF/pe1LJQDQsl7FCrnTP9sf+/MgpBAMk62NvepD3/FncEOrAtK6seaMEXqlGAYITDPAKUZao3IjXyiKtaJZAl0cQ4vPmR6l3/LzXbCaFYcEoUOAkhyoowhHQvZCcY/KILGhMyWUmKEt8A4z3CDT7KYeFFEjUtdzsJSpZWySIM7Uw8VhHZkSqDyffal7Bl2jOWu78qzS0GrK9LF4Atv/zmzyjqBxald3DtkWjvjaQwVxft3D4iJkpqpq2xW+jn60c16zPKXu6skVjrUOrba2GIkQoD3ZyCJqnRrygOId5C0T1WEYnUCZFyZN5dso20cxADBwgbj67Imiw9iB+VtoDULy4AszdeIRscFYYkYEyD5YOYxB8u5Sl7rgYMDg97etVZVJCrMz5DsucZwl3r4r/ccTz92Zdgi24HsGeuCYXejpJSkLeir
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4qLnThywqsPz0a/lHKsxCBbqfPmWYX4U4NPOjbaEoEyAsYdle3If8cLnOsE?=
 =?us-ascii?Q?pfJMGwhTMkid6y335sTSYS0iZb92ToXCjH647Yr8NvBmVXCRmLzjx73vC2Za?=
 =?us-ascii?Q?k13a/TgdgARRWQhOZzqJ+cqRvsQrgaJDHXYVRV+fJIQVZCe6RMoDDomT6zRS?=
 =?us-ascii?Q?qLP9J21XMsbZVsdl4Hi7Q5e1b6Alq7ixswbWaJtxxOYHKoZfxf6BJNxzC2P7?=
 =?us-ascii?Q?VpgGHRtZeIMhngOHtzDXIjnB0i76XlyEE68u3zRWjI7ZJs9uU6uw4+EyX3aW?=
 =?us-ascii?Q?XsvZ8d25bjckqC73FKzK1hIAUVuMgq/kpQJ7vREbIy81ITd2zOhwXigZ1Ee1?=
 =?us-ascii?Q?OmZd9pXUGHElxf7YP2xXnApQX81dp3Nvk3lZLoFQvHjIoiVWgkyZwLOgbAwN?=
 =?us-ascii?Q?mM4+/aIw6HAh08AyzgLy1zi/1HAKS2+/4wSdGP/FNDCdkgBvT6NBljR2tTXi?=
 =?us-ascii?Q?YnTqnoZwDVjfgi/zGZfmw5mLWiYnyhp20Ocu5+axsQo2n7NsvdpeUVLipEwL?=
 =?us-ascii?Q?r9aOaoT/GVLbnptLfr255ip4Mzp09gUTUdWTXN561S5W0WZjy/jtLFNw1vKG?=
 =?us-ascii?Q?XlTYndVlJ0A4c97pLfh8PVtGIOpamUMc3umoLPsVuB0XMyFfU8QBdDvlcujs?=
 =?us-ascii?Q?g2rzZSQ2/wpFZHn8QzImM2RN8AJF2uL/2U279sBv5PmpslBwMY4Zeut/jTBF?=
 =?us-ascii?Q?MCdmtL+hDTB43gof4C8YK6/l0alo/2ZqF1kdvL9gYIPzLkByFgZHK4kOplNS?=
 =?us-ascii?Q?f8K/cscjfsgabhBSOybIT8ZeZHYbLACX3wU4aYB/I/YI2LE9LRoSBU0AYHfJ?=
 =?us-ascii?Q?WbU1r1ymjkOGn9AAH17jl6IFIRU9t+YQy5FJzu9xS57aJnWPD2r7zJoj/dF9?=
 =?us-ascii?Q?cGmFuM/5TOHitcA4/dB9++QuIoRkq6rA1mhJfQeg3ez1wu+jbXot/dpiDEzW?=
 =?us-ascii?Q?H5Z9YYXPRad6FiQXMYShHqkyQwQIEv2vyr+06pMykkB9JhCCGfgxhfYWZgXM?=
 =?us-ascii?Q?TkGrROhtSq0B4WhN6p/3UZOLvzIjSjXmSEoZ/cSCejZq9KAJP7pqaN/3Ha1Q?=
 =?us-ascii?Q?cgyWKPNOoU5/dNSwR8M/O2HhehkX5F4AuLHxLqz9g7YKqB+jQs/X+nqUxsXz?=
 =?us-ascii?Q?51Ihv25J+yhobj2KHY3CKgXAlvyWcx3oy1jzax4CflbJsgXBcLKRrOl3JL54?=
 =?us-ascii?Q?e8I9Hr+z7/rW1n7P3JUaTlQO0+E6/UE1Y3uayttkoZJuvRSXCZGsoQzIQ27T?=
 =?us-ascii?Q?jzBz270lwU6kn8EIECWT2uw6FJCDUZANbu/bM+Tn0p1nH2skMps+J4LMDTa5?=
 =?us-ascii?Q?7MuzFAAyvUxkgdIYGx6lBnjxQzc7zZeV91F4BAJNDsI0epgY20+ngupfZCI7?=
 =?us-ascii?Q?SG88bYE06m7TpSyjb53qxiDo3GoMcsgF9CeHTmBgBuJesKYdWL83gVfbs0om?=
 =?us-ascii?Q?PxV/LkPsi9uM0CswpdwCiogpghM0BXhdPo9WdGp0qKsHTXwD108QfAKVYzir?=
 =?us-ascii?Q?RHadxchwENde2q2JSEFBlardKXSXSm6oZpIuXMjAXqOtK5CoZxY7N+chfVHq?=
 =?us-ascii?Q?ZXQCPlEe+tpuSSQmsLKCwByZx7b80WhoTbPTM3VopL10DJQwt+K5lwkHQQAu?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OujIaRBqu1K12FvoCRBeHBdpQUUlpbrYcj8uc0e0XlyVEEZImqBOj0QTSAGbf1xivpka/aTc2J/C/QNixwQu0XCnjnYTw14eQuvBKCuTJZY3Vnxpx4y9TpfKe1RVWkOHE2nXXCQXz55KNu0EyYLOdjCZMl66Ox4wBQmRPs6dAaV1Fdrq1FQ9CVzJ4KvuKEtW0++6zphjgn/O2R9n+PugOR28Z/TWb5ZYDAj5Hvng6sWH3r3hj+NMEjhshegOJwMOTKFYdcDMAU3BhPecJ3CT2vOqO9zrOzv6dkHUvLv95/gOK3NIC6c6lg56LrW96WJoa2xfocNg4af+V0C47B9z8KboQmbHxa2+2pjqzn9ZLdyL05oa5lLgU8NGEy05qZlxgbokRwtJWQLs3Ljl1uPHQB3Jln14+O0eaOTC3nKBGR8cA6YoeHjla5g5/kPETtpEK6hgWLf1cs1pLEiTvALPZMIa+dHyyG0d7wmG/NiC4kPGMDv1JiYpIl2fUoASyuonYIFC3cx+DzBf/t6psrHMhCnnnDYBdQSeEdZlXkOOgjApOfMpzE5vf5wknC4cnzyftnLEv0I13ps4qKJDOfDW7br204wVnthzI7C0padAiGqNTB7JqQAU77Jbm2udKq2OQ3DJrxeFZEYNT+txbB5K3gwfhU8n9J8Z+DMWVgflIdANH6M4vNkYNAyJD9PEsSlFktGGXV5AOBrc6LPgL4XidEb59+X6xWM+nsrou3Yxn8SMf28vUBt4EKYAERCD1qH8B2ColR7eluuPR0QiHhePYLqIP0MVvIRCP8UMJPZrmAKEgvcybmaGfCTLYVvBXF4bj9acajEhgznh64pbGK5mJqVM8Rlc2ZEZbFsrNYEwdjj3DTDn3qUnAco9PUxXTlsm+NwedhdlX0R+msuTwH1OUQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0592cebc-4244-4810-e025-08db6246385c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:33.7293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrQwKeIv5O7X5/9OZYKhKYhCTgmoZbAuihctVVYkK3dUN0bfjiI2tA/ihqzM6WXFuzSx1JgYgyDAIMJiKdaFvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=767 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-GUID: IbPd7lk4QHZ4jpsyW0oEDE1oZQaVBgxJ
X-Proofpoint-ORIG-GUID: IbPd7lk4QHZ4jpsyW0oEDE1oZQaVBgxJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vma_iter_set() will reset the tree and cause a re-walk.  Use
vmi_iter_config() to set the write to a sub-set of the range.  Change
the file case to also use vmi_iter_config() so that the end is correctly
set.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h | 8 ++++++++
 mm/mmap.c     | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 24437f11d3c2..cdf06f680d6e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1034,6 +1034,14 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
 
+static inline void vma_iter_config(struct vma_iterator *vmi,
+		unsigned long index, unsigned long last)
+{
+	MAS_BUG_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+		   (vmi->mas.index > index || vmi->mas.last < index));
+	__mas_set_range(&vmi->mas, index, last - 1);
+}
+
 /*
  * VMA Iterator functions shared between nommu and mmap
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index fd3f505b40cc..8b3e58d6ac40 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2659,7 +2659,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		goto unacct_error;
 	}
 
-	vma_iter_set(&vmi, addr);
+	vma_iter_config(&vmi, addr, end);
 	vma->vm_start = addr;
 	vma->vm_end = end;
 	vm_flags_init(vma, vm_flags);
@@ -2686,7 +2686,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (WARN_ON((addr != vma->vm_start)))
 			goto close_and_free_vma;
 
-		vma_iter_set(&vmi, addr);
+		vma_iter_config(&vmi, addr, end);
 		/*
 		 * If vm_flags changed after call_mmap(), we should try merge
 		 * vma again as we may succeed this time.
-- 
2.39.2

