Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A33864AAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiLLW5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiLLW5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:57:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4C1616F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:57:18 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwdJR010496;
        Mon, 12 Dec 2022 22:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Vk7d0vXKYk0QNVa4WqxdmLJ2MKfRhOyZCFVuNS0xdYw=;
 b=sSe2It14SRjQPqdeNEBc3obp3NtUoZAtK8cZhEKSEuB1R1MlQMuSgUwAzUDwRWDQkjh+
 guAB+uD4R0eUTuZ6kzjn18DZZwHI1rs3cR5ZRHBeLZsCKR0mq0TKEONOv2nv3GLtC+se
 kf7YRQcgtS9EMeJV7JRZQd1pGh9+cF/RMIjX8bkKdzSTFCu14jLdT+zYwJ1HUT9VzxED
 M9eDhqjqoxuwqAijBaUIzR8J+i7W0tFCjOVw7/hWTwkl0tUKIRMPOQyBVCYi2KVeMWg6
 k35sFuYcAN017fBzdRgNdYH7C8rS1xabieFxFhOntexQ6XOxXaY5Xz9WObpStNVQm84e xA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcgq0c527-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 22:57:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCMcY8G018645;
        Mon, 12 Dec 2022 22:56:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjba0n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 22:56:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5gvB/YEPSP1Wd5yIMaHt0Xba8aG0M2JyzqVIDJbQZGUYHVOiQBCB7GquSerEy/tJzzH4pyulWlEP0s/uZjPxRixQzaYm5yshRdXg92TnZD9bX5s5WNYbVGo2kimtgnppGzZM6WtPYXcDciQP9jYI8B4FOOCDyPxI8Plk5Ky/zN5DSu6Y0q+AXzFvocz23vrAHuljmyJB7xiRZW0B9Ol5DKfNM525RfW7jV6WB3wIM377RPoFGN7AjxFQ9vz3YcBngKvaEqMksOO7ZBPldChHde/NwN+F41xz2srr+Vyhjjq6J4e6PFD2ThUiVcNlpzrXs4jRpfk3qGE0G84aYpSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk7d0vXKYk0QNVa4WqxdmLJ2MKfRhOyZCFVuNS0xdYw=;
 b=eAzTthYiPqtuv0MFGpqdnZheEk/2az+2C3yeljEGzC9NcW9rBJL96+25pm8bCGAsQLvlZUqGpWR2FQEdkctIoG9JVpS9yBOjVdZk3Ty0WXSy7IUF+dzGWN31TcPoXdlHDnu4Q25IZ63PEwAREPzXT9EwpZfGx9ICIH8Ky7MvPkqIYQ+ZegS6hEbBoONCq2Yu2IyKI5wjgNAtkg2HGRbHvOrZKrOsW6qj+YNcAYy3Yy0V/c54josioE3NKDwwvZfBshZONvGSEXUTqbP4vDlS8o36FTfYJPHNUxKcH+8mYF+P+wqCnHmYb71PH44oP20l88MyltERtNw0g1ZiAgETMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk7d0vXKYk0QNVa4WqxdmLJ2MKfRhOyZCFVuNS0xdYw=;
 b=XNmIAYweCxDDSrRvNyxIwtHcb2aP8aIEm5MlbM9ugRS4tExfPj/k5cEVLup12LLdONYBxkWlCyhzY8zF4F64tYQJaWyeyPpoUX7RYIXz7j8+NJ7U3wYtCknRnRdSy4Cm0nyQcIOHF1xtYa2Z+rkL3xoPJ8dDeilMzH8h4D3j71k=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 22:56:57 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%4]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 22:56:57 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-stable] mm/hugetlb: set head flag before setting compound_order in __prep_compound_gigantic_folio
Date:   Mon, 12 Dec 2022 14:55:29 -0800
Message-Id: <20221212225529.22493-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: e9aed5f7-19c6-4ab8-c3a1-08dadc942bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFEWMm5vWuoXA2g9f5WUnZgroN3n6sJkvqhVVzCud7/YEbeXVEAlgeFAReVvxyVP0D8wSFUllEbQQwNtEt5FIvWf3SPuqQ9jgq5P2Htdfe0vvj/8FS5Mm7fywEKnxOHlMqkZM8vpQLiNJBdXVZlahGw2lNDdx699u1wRNX7J7dnTgi6Lv47cZ4gjuCOdY9Wmg3aAeINJjuDEdTkyX7WqfYwPdFXi6tfxagoq2lTkGYmZWQdaApGjTNS14/15sKfeBgcWVi92vo5HW9UPtmDmcE90xBOS4Vz5guxr9iW6DedcSKUQaowl9RL0Dp4wqvB/Yq5wMZ9pIAvVU/I0L0XIVA9iXsVLl7NjyG+OQ2/9EnBaRSK0VVjuT92ZaMiXrZhDcGo5QSzXJfYzCy2yeMvXT1Nr2Anoc5zHv9cWzd/yTX9ufRBV+zgTH0gi+m7CVAzyBxO7mV8c5IfQd9+HX2r8DPF88hT0Nqs1VqBprZDH+0hWb202FRZi7pEcgry2cIyL74JzfyfiSQZGjnODQ9nztqbH/7CZ2WsDDHRZdRI2pMRdgslB3/LKVpgQzxXqNYGLOanVSXHk4HhBTT5XoPENTO2Txy5i/us9cgSDEbyw6ZKHKUyuG++P2aYLyJGUKaGNJuCC7S3Rb+PJIf/Bvy81xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199015)(86362001)(316002)(38100700002)(8676002)(4326008)(6666004)(478600001)(66556008)(44832011)(8936002)(41300700001)(5660300002)(2906002)(2616005)(66476007)(26005)(1076003)(186003)(83380400001)(66946007)(6512007)(6486002)(107886003)(6506007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SS/xHuXQkr7vfPxnOjUUSzSe51QtnIYv+qLrJ3Q9iH49pqIzG8cbFoXkmA63?=
 =?us-ascii?Q?iGlbocsx6nylddLLCoOGVK15KrQ6EI6hHTUBybxHPiUHatTWv6Fxzh6zfhDM?=
 =?us-ascii?Q?ljBv+lsdiaksNFhG/0OJn2562FBTWFHK9ZhFRm014a9uA2H8F3kgU9WPmTjw?=
 =?us-ascii?Q?qTrrhhYsH0mIVH7zS7K+xruDRk/Oc5ucEZmxSYliOarl55nBOnjA+3bVKpMu?=
 =?us-ascii?Q?I0tz74MD5Iiqq5vwmNbrmSOP/9W7RZ++o4gBFOk4+MTSPHOoame4394bU0Fi?=
 =?us-ascii?Q?LTU4CQKvQMAKBbgx8Cg6s/9fgZpWd4e8uNrymHvV4fxn6i+zYQZOsQCdk5+G?=
 =?us-ascii?Q?n0FDeMG2jd+acqUBE8c0ZTNkxBy2+qCoFSKDVt3SSpJcWDXNhZChwXcUCv/H?=
 =?us-ascii?Q?9RGxt/fzyGbM0nQpDZy3G9h0JwsHYnrIfmh86Dg9+wHQ+P3tyBPlzQOt2GJ4?=
 =?us-ascii?Q?d7mxFlyPe7GXp0GxGPwDHwseW2DSsu+ujbr0LNZt6BkeXqo8iL3ZdFKv3DHk?=
 =?us-ascii?Q?iJ7Fc4f3hxrHyZmRyZWELKR4CiUxc6XyO/LVkl8zSUDpSpTXZ8if3xaEygcT?=
 =?us-ascii?Q?8hbbGhAqUlA9mqHYKh/Or1Xp5Ue0DcD+hIlDnS+W0zrnLO0l7tk1yZPM57/d?=
 =?us-ascii?Q?CK8KXXGYUuXpaZQHSEcA+uigjk65Xh8rsUgb0tS6YHRRG1gsVQGBSXaiy1W0?=
 =?us-ascii?Q?/5BJsw6cHNZMGRRBIDIvXnudU+R6ATA2WEsH3Fu5/uY4PhqhaJL9xlkqOL8s?=
 =?us-ascii?Q?bofXVBtBVtgaf5KL+f9Tv1PzU6ysghbxQ7um2G61pU8zFWQbPDdbH0LmKGp+?=
 =?us-ascii?Q?wdUCKohKiWConxHJxIF5YbNqrirnoalKbzHThYMbD55c8MAWi7Y46sl7gmXe?=
 =?us-ascii?Q?MupZZywCBdFDbPV5E509eLFr3dHondq3ZPFywdye/n+JsVSxRSsuk3Na8X3x?=
 =?us-ascii?Q?VLUC+Y6d9IQfH2Gjt55mXcVIcHoKOd+W08tPNXjcUG+Bg7mGDXRaalrteSTL?=
 =?us-ascii?Q?11JNWWVdQg9Y74nEwlyfMiBo5ey2t3we3dXkmICoZqxARXC2yhpXY+c8QKQZ?=
 =?us-ascii?Q?MeRVCG1fKFbtRIgCeAdIbZx7M0Elilh9VUgzj+xf5mg4xJuEF7JZuAoVKJpe?=
 =?us-ascii?Q?LkSKj7wNGUX0xNvHe9JjeMUGX2IZl4gU4B50UsgfL4xhMxrC8+Yz4OYtItQm?=
 =?us-ascii?Q?fiL8UL5xRULOqK9oSz+SxJKNwvZNkrKDR7LeKeXbe09NWGdtuHO1zl8BWTwC?=
 =?us-ascii?Q?2hxmxB/tJ7PQF1gmcGJHdC+svEz/1+od5DdA7cHtpCjv8jcs/Lg87P6PSxPB?=
 =?us-ascii?Q?oSEfjrlWw0ZIu5KqQTfnHUTmweWobZm/iZwWGmi/mYNLzuXOFTwfojKy1G/6?=
 =?us-ascii?Q?JAPMoCeh6gfG/Ca/WoAioCXgk7qFEZcTe/DDRoZv2v72EHkraxVZap9a9myj?=
 =?us-ascii?Q?Ww6u5SX7Vj915P/gmqVqjnMnBQRdui+rDeyM8xSfFsAsrCQoCxtUNkn4pO3I?=
 =?us-ascii?Q?bUzFNNUck+rnsmzIPMtpfoJMvY2m5xS3gmfd2Dx0yWbRh1vTYBI6KfXByk3W?=
 =?us-ascii?Q?S/knGf1dcO/XM1ODglljab85JiE6RrNnAMv6axbe+MhWcXoE2m4cztSAMBx/?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aed5f7-19c6-4ab8-c3a1-08dadc942bc2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 22:56:57.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5jPDRVebVXnWcs6fFqt/Juu6vUYtTusTdjQPleOQ5YcP9B6Qi7lEAVeqaKZTV2hVuRmV69MhRDZ1ASHayEfq11nYbxTrrfYlENDns2sjTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120197
X-Proofpoint-ORIG-GUID: wZkTHmjWPxcgv51lGXU1zYObOub2FtGf
X-Proofpoint-GUID: wZkTHmjWPxcgv51lGXU1zYObOub2FtGf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

folio_set_compound_order() checks if the passed in folio is a large folio.
A large folio is indicated by the PG_head flag. Call __folio_set_head()
before setting the order.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reported-by: David Hildenbrand <david@redhat.com>
---
Hi David, 
I tested this by doing:

echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

and checking dmesg. Let me know if there are other ways of testing
you would like to see run. 

Hi Andrew,
This can be folded into d1c6095572d0cf00c0cd30378639ff9387b34edd
mm/hugetlb: convert hugetlb prep functions to folios.

However, there is still ongoing discussion with this patch series,
specifically with patch 1 9fd330582b2f mm: add folio dtor and order setter
functions, so I'm not sure if this series should be a part of the 6.2 merge
window. I am planning to send a v6 within the next few days to implement
the suggested changes.

 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8c6fe2286814..7cdbcc22587b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1805,10 +1805,10 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 	int nr_pages = 1 << order;
 	struct page *p;
 
-	/* we rely on prep_new_hugetlb_folio to set the destructor */
-	folio_set_compound_order(folio, order);
 	__folio_clear_reserved(folio);
 	__folio_set_head(folio);
+	/* we rely on prep_new_hugetlb_folio to set the destructor */
+	folio_set_compound_order(folio, order);
 	for (i = 0; i < nr_pages; i++) {
 		p = folio_page(folio, i);
 
-- 
2.38.1

