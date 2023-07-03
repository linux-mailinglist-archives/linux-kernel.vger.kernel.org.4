Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB374552D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjGCF7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCF7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:59:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC729B6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:59:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 362Mwqrx014049;
        Mon, 3 Jul 2023 05:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=dj7z8RUuHw0Qg+MY1bCofYDUKBCxdrPRgu++XFuJR3I=;
 b=MhPpRbINaJ9TmXtJ6o41qWPmQAZFRicSmIi2dIKjHVh9wnc6t9NKXLmKc947C8CNg3aH
 jst1yNbGRRXHcliZld/WlstI/k3E7YLkUQtVSc5Fx82pwqjX8gM1PAORdgBBiR1ZJwCI
 9kT/Jf4TXd/Bh5Fnf1tj6bVmKrmW4reOzOkNnnkXZhNtn4lOiiZQFLihE2pBnXkFwZRZ
 0ZkBPVzQ3fiIftHsd3CY6e+0dypxINOQD14ZYBToFGNVKJ7aLyOFBJRGYtKNbi1UpoI4
 YPsoXzPV/Ha+LvjjawpQouEbinEhqkWiNKrWiScjUYafgxOfddPvqjX9CLpujleVnvaj zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc1ahtby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 05:58:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36344iLj010994;
        Mon, 3 Jul 2023 05:58:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak2v13x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 05:58:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuoLBZ8qxgvPRdfi3+/r2WNbrD5NdHS6tyD+vcJgp28ne8WxqxUMtq1nuyILsNKM4Imly6D0aUdK82Ee6JmMM/9yalO/qQ5IF4JqtT5PAWZQR69Zc1WW+sOWc1csq7qs7jCGo/UmMslt4ABnQTCzShUlBaMekWpt/7Rn1XvD48B+psA3Uvj7qbgckkO/iOYoqQJfGI5wRtqkjFggHV+vLzXI9trMuQNBsziAmQ1hSt6h3iQICuUvvJ+0tpgelO7z4yJtR+a4VsW5UqXsdFyTFnfg9/vtCrSdzoYkYenSjPh6kXi7N1HQA3wBv5LhI+oLJTdEf29mISoh9hSvSyFWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj7z8RUuHw0Qg+MY1bCofYDUKBCxdrPRgu++XFuJR3I=;
 b=FlsN72vwvZEIOt0WHk26DUiupGLl458x9ykeOqROaYQbkm4sJufXyh/Mv/jcaMktKeBThomCnm/MdB6rGCwttQoDlk04+NcqErzakbnX9ClveWnhmtvE0xV6BddiZOv3p8ZCAkng0Y28ZnjTmwXDOMo+Cao3Rtk/Y1x3ghdl8Z/S5K/g1Y6DEgeATCccn09n5zEYVMiEM73iMdiJ4nu9zLlpUF3Nc+dNZ78UVPY2BALXtj85gMMYMKoKNid0dUFsG2MJWXUU7RdrvbzrSNorTF3i4fyCfu+PMxSjjqYN9cmNRIHjaGVFyHK15bvGV3WxftO5tOxXLh9AZEYXrkhmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj7z8RUuHw0Qg+MY1bCofYDUKBCxdrPRgu++XFuJR3I=;
 b=g+PAyDELt3X9gzOVzeg+0ZIUB8R3xMLEFYu56QO65tvbtLllVVBl4c+/vPptKgkTBd2t80pVQQc2+TX2I7JpNvq9Nt2+geGfZ4aFoyn6WXZZuKfOfXevnLEYVATjkgJeoG8TGkG/M0SiPcZ3DoHWcpAHyZEjdKmmmQ9CvURfkgA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB5085.namprd10.prod.outlook.com (2603:10b6:5:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 05:58:56 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 05:58:56 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 1/4] mm/memory: convert do_page_mkwrite() to use folios
Date:   Sun,  2 Jul 2023 22:58:47 -0700
Message-ID: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 0806d1e2-a03a-4b25-d3a5-08db7b8a966c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvDcWnOXh1p8FMhcwGxI1wJD4C+VBQSTxGz2Uv2TCFmPrzye7NsXDuLvglg9/nnzstylSdn7Js+ea0hPxRV+iG3ogqyYuWGilTEgRNy347AGWAkYnH0Qm/J7EAiVh2768TSC849p81QEQlogyhZ6xwM8P1OIra+9pP77y9jDONJc6Z1q0/oVmuZmPPL3pIB3hPd37QvwhTxuTD1O0jftlpdSqrjjk9rcoy3FyCnmFqI7/arJETmv5iQYSZSRE/C7r2n9fBeFyOBN4Gjx/2Aocc61I0RBCi2XgwmoGonDX64N8vJJJbcMgSlm+nMgDzk1WWSkHanmersLuo9+ahSp6X5oUg8+iHm8dcjb6WuinQ3IWlc2Qc/p62eyDvIEGPpEtKpZNNpFs+//SFqiZtkKoIEVggA59XLBZ3asfjpd/od32tasDbvCVmHKfWwFJ7t/2IwkKa0mqYNjhyj/cFsywrWRLJgcFXoQ8Ro7CefiAY5r3vvO3hkgePEDlOSn0VAlEiVzm2mpagg8441ocbNDBp7wqF0sSZIMDT6/Fya4kM24zGt/7oNFMv7HiB5hXZe3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(1076003)(6506007)(66556008)(66476007)(4326008)(66946007)(478600001)(41300700001)(107886003)(38100700002)(316002)(2616005)(83380400001)(186003)(6512007)(44832011)(8936002)(2906002)(5660300002)(6486002)(36756003)(86362001)(6666004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ip3V9nchQcJYodQs28kJxmeq2kNv5YJP0uLX6F3g294oWESCA+oZTo7/kxgY?=
 =?us-ascii?Q?IZlbBEHK3nSP8BA4Z0Z0FRGbYWfIlRSWbYYNx0wyTpFimFzUCMn4e7voDYP7?=
 =?us-ascii?Q?ImRMEhu/uiQ2LsKKXWiRhJ4lonwgOmqLZe/TkFUzWKFeOBXULOyKm9GLFApK?=
 =?us-ascii?Q?uZanUqcMs7yVfXZbIJhFpYkW2JKaQRHB0ItaXkviGVxuo7t3NeD3rK9LM9cj?=
 =?us-ascii?Q?B1kkUdJpPCWePBBZcuS9ln8Nz38c0pUOJB5fZ/ELby/mOr4kMCT8wOt7ybSe?=
 =?us-ascii?Q?dKBwfy4uZq+kelfcS5+GstIz4PACxdzNWU/6C0DLYvGUzw72GT8AckLaYDHi?=
 =?us-ascii?Q?FX+IoaOEUYTGzXEQyW5HMUQyMUwqxelA996vFChZrEKEKRFDyZKzAQyqINWc?=
 =?us-ascii?Q?GNjJVn4MB301lVPbI0GdlvuDezfDxYb8zf8t8n5FySKSnd1o8lTYGkF/a0Me?=
 =?us-ascii?Q?0wqQG5niRCGK7u3JleT66FeolJ+kvNEh9qOBF4VkSxOUOg90xrxCuRsEudMk?=
 =?us-ascii?Q?xz7SPF3ijZWvzVv+aFWm/RGarlQcfgVe/xsx1BBgUfCfU8nq4PLOBYa9jINd?=
 =?us-ascii?Q?KgabxKrcnvSvFsjoJr71InQqtUltcfC3bdGZzSmW6HG1d2KYhHCA01hZH9Oi?=
 =?us-ascii?Q?sIwcf4f0Kxp/LzuKyCIaOuizMYq1dFXAV4Onr8cp3yfQE/9RVs+u6XuUQlFn?=
 =?us-ascii?Q?gIICnHI4vOCA8LGEawHAObUqrZDQNgP9/KavTQOj+9bDKPZbvkSPX+ZO8rYc?=
 =?us-ascii?Q?rl5uLGdWHqMezs4Gt9P88EtTVp0rgWITd0p0zpCWvXGlcx33wPAvkKIgbxjH?=
 =?us-ascii?Q?xKQSM9PJ2bPCEEgUsXEVxf/akq1ew7ov6r2jSH/NBKiQ1LQbpWRdpobsG7Ca?=
 =?us-ascii?Q?GrV5yROB2Mel5FdjMHTTr1bRINitmceClbzx5JTOEVmJdM61/UYDn97/9idD?=
 =?us-ascii?Q?BhFQnvv0lLUeXubAxtlwG/G639zHUEKq6mAQaarL386jSthwceDxdEsutlpJ?=
 =?us-ascii?Q?rY3CTTCuFVBV4w2vuZVevBwCfRFx7Ggo/i7aRdr09giyw7nGEgC3ZQA4Qjk+?=
 =?us-ascii?Q?Q8Ih/Ma+V+CosmJ5sL1jYf5NZceSEc8n9MTtrMoJQpMh1ooqXODtyb3K6MHT?=
 =?us-ascii?Q?mmXQbGGRcBIR4uq5z15RStrtbDoRfHZpjATooPnNmDNaeiwjl6NPBfCwY5qW?=
 =?us-ascii?Q?lnHT5JIsG/zfo2ZCMhivKYhOxMNxIeuI/J0zluoLAKUswm2tTLF9su5OZkHC?=
 =?us-ascii?Q?xiJ0LMNi17WxlMggAYJEofEMi6G0UtBG68QGmyAx8JbIAoTINnkzLU5A97+j?=
 =?us-ascii?Q?rckBE94F/oJjLmA7kMhKJ9edgyfkzoqCIDhgzWiOpo7GYTGDSWDL6mhw6yEx?=
 =?us-ascii?Q?2aYC3qaRlm+It2egcvEwd08ZTL+Wu3te9IFwymSYp9K6vLKMgClJSZqjPfqt?=
 =?us-ascii?Q?TA+C1FFaBi4GgBcGqWD6dhTI0OnPPqmsu+7g9Btx6MhznWNV7ux9EX+ENyeE?=
 =?us-ascii?Q?YVCscqpcOYKdipreb6q0BTF+lniCCi61SBJrwImvu7O4fL6xEa2aGweE83YZ?=
 =?us-ascii?Q?HOtl1N4XS9yMXWp7nsqtr/PnaXjDhiYzYB0u2fx13L7i8lK+ygPQyxpKOnhx?=
 =?us-ascii?Q?nW0nhLauSAG1YVEmLUp3rFU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V+B+A/SvDP97laGvgglBSgZZk322Ma+18sTDIAQnAlH6kUMPQ1N8oyE9mAJHurNuS2gcQ+qDyBIjno4J2tIVo7SdAtEXlOVBCB4AiZizk6NzunSBrU49e/MNI0UWyVLyG/sPLgcvxCDfkpCFQbiI32emqxi6t/IfSZQIryf/T/d/RVJ6Rz4QNbt9ubKX0OCQGOK3xl0B7cLhYDy2RmDOHL+7rJhxA6DPzv5Ii/vLzt4NTlBaN0kdD0CTDz2pYBsoTlLBSPck6Msz7HlS2Dtd6il32kbazepY0m2YGtYrEotCdIOzhQmcE4po8iSW7KU87PXtb6Aro6iul9kQzSilVEQLew4sm4I7RfV24gINhxgXWpUU63X5QV7G/E8YHhNHY31pNo/nG26yV4238Foz64s0hgbY94ay/lt9mB7LEa8kKzWRVwUGsnwCAEmdFe76gkW+m82MSyRdrIw53XgKmyBB+TG15/0536ODMfouNHeZTxYt7FI0rWyXf38e34kq/xDu8TA20Wu5yQiY0hfxaRUzaIMFkmmrEhnQskCWEYsv6kGiDzFYBChX5Par549Pk8tQpGRj65qpC0PpfEs1xQsgrgFRB10tqhBWPWftQwG2OHLqpkUYTYM5a5Pd0QFuoWL4UzJSxMLqXjibB1gVB/m5BISpUoRJFmTqfHPj9zLL6bhJAGsZdqjRqnNlt4Eqa5Z252Y1310bwF6y6GNm2IYhIUTLs50+k0y7X9DUeEt0oDI95zx2ie4nB1t6m9Utdw6n6wpZ6dh4QFhOFe2Hf7cOghTCm8O+tsd5qi+bYmYnk6BslznNwGnKxsoBlJAM2ElasM96V8qrZGACAoMlFpVjSTz9WVmx4afUyB/9bMwgpsTHWqrrvVfpW+7UsIsj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0806d1e2-a03a-4b25-d3a5-08db7b8a966c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 05:58:56.3959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIG3u5hMag6kaNhwmv0/jcVz+jwMHSX15nC+80iaywgD6GuQIq7Usj1j3cWnfwr1GVRkYAtdwshJ6mlDrL+QCePnq03MLNPanKC6I/e4T4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030056
X-Proofpoint-GUID: YYiuVSLmrAngyqz1jYO00p0EnQzdi3ia
X-Proofpoint-ORIG-GUID: YYiuVSLmrAngyqz1jYO00p0EnQzdi3ia
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves one implicit call to compound_head();

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 21fab27272092..098fac2f5efc0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2932,7 +2932,7 @@ static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
 static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 {
 	vm_fault_t ret;
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	unsigned int old_flags = vmf->flags;
 
 	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
@@ -2947,14 +2947,14 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
 		return ret;
 	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
-		lock_page(page);
-		if (!page->mapping) {
-			unlock_page(page);
+		folio_lock(folio);
+		if (!folio_mapping(folio)) {
+			folio_unlock(folio);
 			return 0; /* retry */
 		}
 		ret |= VM_FAULT_LOCKED;
 	} else
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
+		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	return ret;
 }
 
-- 
2.41.0

