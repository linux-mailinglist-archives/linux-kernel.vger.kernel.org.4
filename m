Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558A474E660
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGKFgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKFga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:36:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A895134
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:36:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AHuFME028133;
        Tue, 11 Jul 2023 05:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=+6Fwir1C8gSj9SjqFNC+C7qeHoJrcujFnOcfJldfxJk=;
 b=dAB++8r48u7sn9LaSBp1k15aVFuZ+oh4qRR0xvaGC93r4qfhmxYlS2zmu2TZfDPu25c1
 Ll5/9jWWh6yhWSkJfTM4mTP3p472fUIpO6iGFNnataKzqKZkvIPqiQs9dP1vrpHQNmyN
 WZ9A05yCqGFc9On9l6KdE7tjro9GDrpR2PBnjW9y8MHoJTv2Jdf5u6YsMJTSRfdeuIfs
 6jHPYfmT+76Qv+fMDusDRUR7ENJUAe97vfd0SP/KCrTZIt7ASwQiZ9sisO6RB2LwYgM3
 9CfAJ4Ge+FFjdKJIuLrOqO1Xa0T1ivV1Pxwic0oAqfYBBbICkXN/+yX03igBPWemfZC3 jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj61xps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 05:36:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36B3DSd6003964;
        Tue, 11 Jul 2023 05:36:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8amcyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 05:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcwR/cJATPsxG/Deq4mvbg+oc6ZL2fwNg6UdpjycDNeagWN5fBII9/SJnLlQBo0F7T+XIjwJmDbSkg/LUHxqYqDOH+GkwU+9Jtx+ufzHHN0GCE273JSqwgm6GfgQIUaSZ1sc+IPE6JHEIK5DshXjsZ5LKf/EK5QHysrNTqtfUQ8erJQrUwzLgairMcH91u6kcRRKG9T8q7ZdySsR4urmMs4Co9A38YqkBu9t6XDobmK1sBWFq5Sl5V6yMpime3wPTpMPIcsiR23MP9MZ0mOQCtm8z2CwKk9lyBq2MxLcx+/lfvbrMk/udj7AJXZ8QUT3qB6r5Ba52jpx+Vo7BMB8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6Fwir1C8gSj9SjqFNC+C7qeHoJrcujFnOcfJldfxJk=;
 b=Y+j74Qhd2yMqecQ370sEX07Sjv10AUWM3qSXDt1dlEdF7CCFy/jwXBqbwv5CnThyO7RmJqLk4RamKYK29TmZNRoDf1mhhozswG1KXMnCh0eqUMhPFGbpelPJ5aswgL885klBDzIlUEjYpiXM6pCc0B1hNon5WUMp5EDzkCKdJL7W+2TbL9dmGJnG1qGEsHvTWwoa6CDmMoUSMf+Gp0FqDADh/cYllFziRw07UlnNIyXGbTQaWFuTEuziIOmvWLPIVKS0Mj0uHfdbn/WHGSS98yyr4ldxwOJ46971zokMj/G54qJK3vhA73hyt+f9R4hcR6tEAFixhS4E+mAdpF1qkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6Fwir1C8gSj9SjqFNC+C7qeHoJrcujFnOcfJldfxJk=;
 b=SmjmUq4SQFRxkEdwtPf4DkbTllv40z95uog5WbPz6CGanMxviEEm0IgZSR/Eljyle2NRofAYe0Um8TWTwc4pdbUZldXngEatMEQR24bG3Svn60Kyumo4EGiZf1qDK8ZDUFcNnzBJIkSMoBxy1GNk7d+wMU4glxGUGmTDGaYRXWU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB4407.namprd10.prod.outlook.com (2603:10b6:510:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 05:36:15 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 05:36:15 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/memory: pass folio into do_page_mkwrite()
Date:   Mon, 10 Jul 2023 22:35:44 -0700
Message-ID: <20230711053544.156617-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 8324922f-146c-4184-80a3-08db81d0be87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79/c5ilHUzQZsMD/l5+w9bKX4Fo4fORhAb2DsrNi5lPC9dvAQgUL1d/HYB+nJlZrifTzgiLCim8exDM3xnWylsR0FVAYC3Q17EIyHQpHtaq6rQd/eB05uu9KIcsTfmyr9HXZ5WzMZR1+ZnSc3Q8rYm31Sd7lBR4nc/2U9l3ECQKX0oT9DH6BqLMhCyKIW+4l2Ipzu4j/NsZuVKMJorGcPNAcwQhDprILx7vbJdT7sdGIrYglZgW/fneKDR+yqdaxWUxgr4KGoWAGrPSBPPYgYsaeRsKgArgfAtqLic8zXmMrFe3IUbA6s7XpWSspGKcMmEON4UP1gyBJQTtt5qLpH+g3XiXqkt0TJgtG+WWu0NsC5XkGt4BeojUyEWWCSPCkvaON4+Zxl8LtWWSsbTHqDPGGRgGnm+aYVMdPx5Qx3FFQ/ih21Pch6YZWxHAYqN6PrG5YVWsd9awv1Fm5JqvIvF1fEY/7kHGfB2U+qRxQr+tmlNi0xahou4t+3jmUGqqk3DJ6+Oi8G7UheoZ/VojD+3r564CBkvrLqXP+QIDcRHD/lL5PdT8zoBLuifL/kWUB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(478600001)(4326008)(6666004)(6512007)(1076003)(6506007)(107886003)(6486002)(2906002)(186003)(41300700001)(8676002)(8936002)(44832011)(66476007)(316002)(66946007)(5660300002)(38100700002)(66556008)(36756003)(86362001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?USfSKa79FpIM0n1uewpVi95/yC1YWftrSsw6/nH7zm0qZZvlVSe1vAbyY1GC?=
 =?us-ascii?Q?9tSR+jW+O7qJqNzH9z07/+Tz6DdPFUKRPz6weuUNZnVxrXiLSce+Md7jtqLN?=
 =?us-ascii?Q?jlq05IR3crZzxPafx5JRMRPmtK/V+NhQT+JK6YbNnHk5yX7Bk7vMf5QLJI1y?=
 =?us-ascii?Q?cRq4OLP9KVc2hy8Sv2v4ueyW07j1rQ0F7LXaxhV3+l/iidgK+EL9XcLxAAUF?=
 =?us-ascii?Q?LonXM0gXyAV6RH4/NtU5LUfRlMwYwZ11NXMOyCRy+/zaqRO8ogb9YqOMRAVu?=
 =?us-ascii?Q?elEVBfr6+7w3wQMO9P9dpJNLcDwEze+n3bP5Is7rLwKRvNG9jrGkprvyq6M2?=
 =?us-ascii?Q?f8f8WDydIDbbmMSLuawXdvVs+4WkzwLAOohJz5NCzALzWi+/kRKLfIBGSKGD?=
 =?us-ascii?Q?0PuNt7zVlezYgXYzV92QlDyFXTx0CAwdkO9rV5uq1ooetK4qKJOhkPBJSnGc?=
 =?us-ascii?Q?LOom56D3vLrEPoG5kLi4wpZEgw7SeNT0vcM+hHUnSyawK2QaVuKgPNQBPSLw?=
 =?us-ascii?Q?HKiRxuCzop/UdoExdH8X5gKX4XPt5dcoQY0kGV3u4/JmlWesaR+MzuBB4KEA?=
 =?us-ascii?Q?GRBaohgUi9SZd9cPbDCQXVrnsFD6G28uTLDI066024TUciEo6eAGTVsCoO+Y?=
 =?us-ascii?Q?1+tdM3zvTfPl6doaJQQ6cANaaYqiisjEfH7iax7PBlq0cmi3zF/Ax38+VBWp?=
 =?us-ascii?Q?Xy5vZYjehxTEqbEcsU8NGZ6a5eifUMynbm0iAHcIhdrB2NH0negyt9htGyjA?=
 =?us-ascii?Q?3gk54pqC5dbhrhLICYMOVT5TXSSUA0mx0jLi8ofvhrsfGXn1lTqiRd3yiHhz?=
 =?us-ascii?Q?FwXNMs+iruuflc+EW0ZbTXsXGsADfRCAMuo5f2w4a/iT1aHTDSI3zGH4fWU2?=
 =?us-ascii?Q?xzBTzyPVe02SNrp2SajMy8ANCsYInvW0pZvOaPnSA0RVMGLLP8dDZk7PUDO1?=
 =?us-ascii?Q?btYDZhWm/9atNZ3g7wqCz3e9uK6n/ZCFmsTDhDJWtqEA3EGEaU2l5MouWgPV?=
 =?us-ascii?Q?uDKR+LJbio5UWbbBEjR8ebvIwPv2Auurct0pz78ATQXfP1nZv8YJlPcmGPlf?=
 =?us-ascii?Q?Xcxzb688H0YZuiFhFt0/koD9uNzswXJk+fhRXGHMJ8qa25vsM+q9j/ni5Joo?=
 =?us-ascii?Q?DLKRfX/zZaTJ6Rce0B5QcxlXjVXUZVNgiQxqv42bU1GgUz+0XKO58Cst1Ai7?=
 =?us-ascii?Q?HPjd13a7vYgWMiXt/6UN4EvTy+GMev1Eqz0sPJlIYc0tP/3C99lCMh+pZScu?=
 =?us-ascii?Q?xFKlPz+qWhmPqPp+8erdgcSWjDEiVvtaSUJsvNUkSU8hPBGaKgFtHyZZfGDo?=
 =?us-ascii?Q?8oTuc3ovPlUYWmvvjnjV5sr842lku5FVkcK8FOzelPhCwOOZofnS0pa5QzEf?=
 =?us-ascii?Q?frF3YRvv8qWtCrAaghvgsTszPxlKcd3O3dxPa0ci6Z0znweseODZs44UficV?=
 =?us-ascii?Q?e0oup6nDTUWWHlSxdhcqfzKMQ43RgyFL/G8CfFizHm6yY6WFtCzYUb9me7qJ?=
 =?us-ascii?Q?YedLmUgK4AJLrBBy8mTLbIn4MLXcmtS6ZUWgTQyPcaypKROvCpsTyOJUYIoe?=
 =?us-ascii?Q?ZMeDQerZrMPLLc4AhrVGCCOUuU8HtuPIKpS2OuavfbvysILRpiZsgqPHQYzt?=
 =?us-ascii?Q?YCl7MKfpfajd7Y7qkqp0Mo0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EPqn/9HDaOX9o1AvEWwGsCzCD/R+/KCKKlxZLa0XzV0HNwmpUSATZUSHIWefDtr8Da4A09jt+FcWQbm/TocMMZTp+t2gR9xNmonGj5h/bVX+FzSJMHfs7I0Xh52Amk7G3+r4gNm5f+bkVzPrWMXwqRlb/bS1Woj3xhQwx8/nnnXiHf5YIIBXlPfz7+GM7Eyqwo52w3uSEVyYfR9/dM66jIJoZevQHINLS2sk0OIZ+sAzguT/cZVhnUFGaGVVPuL1XwdzzflCYlvHNmVaxYmZfP0htFsIbHkHnCSIjs0YlDCCxMPgs4Jdnm+fXv6iIt5Ulg7dxtLgSqdn57t3zQbOjlXSmzzy4/uh0xJJq1hIhirv/K96A9G+K+zepMbGy02VwVsjeA8So7/g0zg1LLDU7Bl+MW82r+3N5M8W/i0ieBGCDdsHuZuQgX66TLrhHMTySWh4D8fX2PFdX+9+cuWEguVfAoS/ksu2QnmXfeZARVV2jmeRZxEu+eEiNqQhco3NlBETTGoGhhB3yb1010i8IiQ4t8I92wBte/C/n5fCfFM/4f6v0P1qsIfKBO15sN9JT4DqkULwayCkxz777LzJv0DorXBXoK5BtfmwTxGD3QxA/7gmyFNHu3bnZTJgQIGlU61rqHqTY7YnsUw4xSzZgJkBh7we0G34Fex6Yo9YJZEk2xUdRMW3/yNwpgcaTitWJFKhu7qzO77JzLrKJ3ssxtIG1p8RP25D1GLjum5qnxwuP1WBrXS9CS88r8KWVCzNPMkx2fOcO/N8bRM0TbZxqJKsCd94RNEFXG7dsECBC2OQxdUk62GbOxR0PdElQzBRlqNB9KOseZBW9ivR7zzsy51Cg1z44TYjQ8Jbyy0e3yQM59c6u1WkjTWXVO6H5ClB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8324922f-146c-4184-80a3-08db81d0be87
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 05:36:15.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEfsOZ659l+GxmxiEVeYXfwL4/KrlbRH8gv94sscxIuUaYXRVvxFMAKPXyVEmRvLIAidSXy4FvgMVXy/NCaoJNF6asGpxk3JmfVTxUwKHGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110049
X-Proofpoint-GUID: 7UVB3MPXAI1XpRnDzbvXFjjnixumZ7bK
X-Proofpoint-ORIG-GUID: 7UVB3MPXAI1XpRnDzbvXFjjnixumZ7bK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves one implicit call to compound_head().

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
I'm not sure if I should change the name of the function
to do_folio_mkwrite() and update the description comment
to reference a folio as the vm_op is still called page_mkwrite.

 mm/memory.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1dada20e39959..ad790394963ab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2936,10 +2936,9 @@ static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
  *
  * We do this without the lock held, so that it can sleep if it needs to.
  */
-static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
+static vm_fault_t do_page_mkwrite(struct vm_fault *vmf, struct folio *folio)
 {
 	vm_fault_t ret;
-	struct folio *folio = page_folio(vmf->page);
 	unsigned int old_flags = vmf->flags;
 
 	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
@@ -3301,7 +3300,7 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 		vm_fault_t tmp;
 
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		tmp = do_page_mkwrite(vmf);
+		tmp = do_page_mkwrite(vmf, folio);
 		if (unlikely(!tmp || (tmp &
 				      (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
 			folio_put(folio);
@@ -4627,7 +4626,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 	 */
 	if (vma->vm_ops->page_mkwrite) {
 		folio_unlock(folio);
-		tmp = do_page_mkwrite(vmf);
+		tmp = do_page_mkwrite(vmf, folio);
 		if (unlikely(!tmp ||
 				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
 			folio_put(folio);
-- 
2.41.0

