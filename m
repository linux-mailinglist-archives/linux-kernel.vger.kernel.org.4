Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C99570846C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjERO6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjERO61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267A710FC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:57:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IlYr012447;
        Thu, 18 May 2023 14:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=jgywN8jRiNRwTIyRRyz+BVe3XwlkNQkfDm5N7nxtCT0=;
 b=kH6HK6Gxj2S+IDz0cO9C8zLJo+Q59oBueWGwNXY950voWl4D95FH+WsSOTquWUj5xjfM
 40Fc5KcJvkO7cekOyKjf1aIbIz3kxxKApIzGUVdhaVef5lAfZEmy7kJnVwZBa0Z6uOuD
 8FdCFqrYPITEq4htsrdHD7CAN/zM/TNUPkPleczszljTRa7Lp0CLEwelwpHtZGbdj2bK
 drVH3Qjq2aySLBJ3iYUlxQ6mYuCCJEMFII2n0jU4BQhSKWx3gKd9ME1Tuv9VL/fSSt2u
 WqwA91vMbt31BxWZQK/3iZ4F34rX5yEzKIjq7n56euanSDgJwwpfQt+mwgmChQtt0GSN 5Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdrh00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IEidhb036327;
        Thu, 18 May 2023 14:56:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm03w3tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej4njUs+c1MWR1ZoyVVAJuBWO4WbNagSIuBZjTlswtvtMy/k9AbZxCzzMSiG2w3DYdDANyodu7cedLhaTMSozniicePWDt85elnQGWpa94pOGS+UR8ZSjIsHFRDH0CZldUBGyWCzYi/GGBBzoWdUOBog7fkGBN99CDgoV9PkSagLc+ywpadxLv0kpzGR6bJuL46C9G9JKzZsmtP8NQUR5KNraGvEO96ZOpkL2lukZJGkEJUAJXWx/byBzJExxUpFatA3e0TkaqnkqnsQ6cWTXO+OnFY3l0+7G9zFR/UBPvoNlSfoj5NivKyCC31M1l9v2u/h2aGSbqnQEC2g15Ofeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgywN8jRiNRwTIyRRyz+BVe3XwlkNQkfDm5N7nxtCT0=;
 b=iguE3oZgfVijyH9+8noAzyrdh+INRsYwTRTGc8AWYkk5mF4NZoqJgd8FJoHWlYZK6sfJJB1TpgNEkdfTAzc3mF2Zi8mqyu1vacCtvfMq+U8Sc0PyJtSNTh9yO4WkNgV2157wQ3mQ+LU7pWYfu65d8gobOFNQRxIJl7FX2YTUbXU2HnMT7D5fO4PbKXPe3LhJ3KUXjK8UM+rGbzu35TcgcqfqVEBxPihTnb0HYuGQzwDJZR8TH1u57ZE9RVTpTUg1SZrg1eYkzOcEvZcbzZTRux28vOlYU27kIyUH6E2JsNNi+zyCX19pLEHYj44TMWJ+qCxansqj1ZojNeEPcui4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgywN8jRiNRwTIyRRyz+BVe3XwlkNQkfDm5N7nxtCT0=;
 b=HltFhs7hrzf12wOmonJrhpV7sxZDY/P7xxqKym5wu98kFAIW7oObiH/9PuKBYVgva4FSA/F9iQsIwChmWDsDD1Cf7Y/ZEK11uAm79XqDW3dIKVBktN7u+O482AoiJVe1wWFFLTfVnfalxawC27BvmupY6gl/Nvk7wp6UWz2JIrw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:43 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 22/35] mm/mmap: Change do_vmi_align_munmap() for maple tree iterator changes
Date:   Thu, 18 May 2023 10:55:31 -0400
Message-Id: <20230518145544.1722059-23-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0367.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 562db84b-bd89-412d-40ec-08db57b017eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFB9nSxqfLDl2YTBgVnoJPeuLowhNMzBF2Q2a97DTkcoFeRrN31h8yqZJBrkGw5z0Qcg9J3E4Pm6MFUq3ARsD9WiQjjnA8FnS4O9aRxqDuBCTFaZh6kuthVoAe5uZJ3FMiGbD3HZSEkFcnJFSMPUwBIWvlBJcBRav5pAf3LIWWTC/WhCk0Dthmclnev0uCMcopM7gkMlXOQl+nI5QKBsnMlnc9YYCh9Ku+AIAV96Ty5iqly6RO9oOQLKUtdRiNpZ2kuf5PDQoFt77HsWR1Z9MJQQ3ykgMg8bjMKU/pcXfY4/vakLq+U2M2VwG56+IxTrB2BfUQxmM1RZc9v5MnS1Un2SgD8Qyn48C7nVzBipTf+DpPmIgT/KOQWnRpxvWcIHWOg/8bymp6yoKYBS+sBblWrRGNAsTdYyG41DEGa6TljGitJY1IFRVHHzP6MHFHWxDAzREM3JIUwnoOZVmrB8tDcDVRF33BEJR81jpnqiSNj58ZwgsMx5zyZTJceZOwcNX++HSvgFoTVQZiDNW6/C/y5kbP4gCfEMFx2Q0qpL0YBT/sq67KLyNxF69H1Ewkrh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(107886003)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3pOt/5z6n28u8a7wnFhWguJIPykQikGNU7jb0sJSqcxiCZhsGqnuFD0xXcWo?=
 =?us-ascii?Q?J4iKFaSiCg85AWiRS79Qa/anlZiE/zPmICwZ502b+3m2YoNBOO6xbd1dIU70?=
 =?us-ascii?Q?ozJFOvsLsyTJ4NaEcop6wGW1cqTeURw/Do9fqtM6nR6oCMOxjiAr1wqkStdy?=
 =?us-ascii?Q?bu19IY/uNw1rVrRPBrdJVxNW8d36W2BQ1Vv7pH8guIPigXIRhS4HAActwOcT?=
 =?us-ascii?Q?O8ijfyJbvrYanU3aFDjgE39B5ro+Vln7zCqNosj5rOrWYw13sO6qtTuMq3zT?=
 =?us-ascii?Q?fsw4Bz2iTSPUWFnnmF2MTzJ+jApXyYAbRsUAVYezJq2ZBT04xMlSSfEZQMqm?=
 =?us-ascii?Q?Icz8Jwx9cZJ4YCRvgPAlXOKonK75c3vFP4ELwMfefy7DN0h4oa/PzGdI8o70?=
 =?us-ascii?Q?AjvMGtgSAYgeaAYGDENbWZnULpUGu2SujXPyFu48xksaFTv6Nw0Cq/F/D+y9?=
 =?us-ascii?Q?p7Y2a4+CUtbxnCeEKLOS9kdq738/ktIfmw4DIMnHLIi81ce2Usqz0g0qF+ZO?=
 =?us-ascii?Q?IDvMRKacFV9g8zcVOjb8hKP+Vs0NW998JGh1K/4Jz/YuAzj7Vwc2edQW3feu?=
 =?us-ascii?Q?TKA0HFPc+BZJ71kSHTjepUC+uHZZAyUD7Du63gmbL3TkWMT9HdWZ3ha1L0rg?=
 =?us-ascii?Q?a1jFDPPi7FjAKkxNRV2GKuxHKfDoyfGXqmv0diWKOmvVYYEA84GO19/InqOF?=
 =?us-ascii?Q?ISOWpDEcB4iBxmd2YD+xzTGL6DwntBdaExrz+oKLNwuYKiMrCfZnFCrtib/d?=
 =?us-ascii?Q?Yfbywnm+J0rt9uleRwsP2cAFwLq24Nl+k64wFJAdHM0b/oX2P22+5B7jUu3F?=
 =?us-ascii?Q?kX1Hy05LY0cTQAZF/mVV/gCuFGH3s1snumCwMs9cMW7d0K+ZDLo9ALWdNisk?=
 =?us-ascii?Q?dRlxVBPBmag5qBcZPCGkK56S0AftJkkBNiABULnQGkxcpOgU4iXTxNb8JBnH?=
 =?us-ascii?Q?vweuSV8n9CSv6xjCSdStCknrsAZqbzIxg6ljS13L1NeBTw/UCQheb+hef/c3?=
 =?us-ascii?Q?j7jxgFZG6wyHEM0ZYMF1SMS6GOqy1j44RSNe6rrU9pex6n7GsqLdPhxTkfOK?=
 =?us-ascii?Q?2hJ715gVdKjbKBwOwTBxxomwZtRa0RUeZ+dIlP/YQad9PHx4cSXaNRe0aYRT?=
 =?us-ascii?Q?QWAEpySb1SfPFe+5A+q++iLthCmJH3/trtf5+BD8+Ku/EQ5b3Q9SGIAnIAu1?=
 =?us-ascii?Q?UZBYsTsz1MSOQMedjzTyuwkAS+8bKBxvZv30RDYxhkbvLjkG+FtegR9y+SfZ?=
 =?us-ascii?Q?5zRd3Q4PYYWwqGZFCtcJdVQnnP8/3gxX1pa+miAAvZcA3zvLOkurUXbmbt00?=
 =?us-ascii?Q?xKEpVvceScmdlI/+b7K1mF/rKdiSZ2JNdUNCpGhZyBHv4OV9wd2Y15LL8T/D?=
 =?us-ascii?Q?iWIDKuqQ6eGkDrtUFAZ1NdiYob3Q7oz+udOkt7DSI8pOJsfNPmP4Xb0nzHDV?=
 =?us-ascii?Q?cn+zglmAxIRmZx1Z4kQi2Qn9sNUegiMFiKjNPR/H40rLjEQ5Q5mh/kBFGMl6?=
 =?us-ascii?Q?/Pfq8ug2TO///UHtCf85PfCAcrW+t3wvY844WMzsrg0Bm29f/3u7j0QusUFt?=
 =?us-ascii?Q?LOHUvNZDqKjbMl9ZQGLnuyj0fgoEknW+Gu/8ZqpZZWMxjsAevK71GdGXGQ1/?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dGxfImqnr9pzZRSki7RrW5yVhsxmry72AKHWK+xpbd0R9TSDP00Ib+B4+FHfI+eCM5RXKFnC31WLf+qVq0gQWaRzkGW9iYLx0SYJOVG7oXFjAHn7Q1WRrLm79MtbiNII/Omip+No2Qo3i+oMTrpQMIAw2dXrBYa4fbXcNUxxZ3mrijVDF9aOY2dC0xdeCljka1LEWWZFFOVTiDo1e4TIQ9KCL3MXyz/q7O3pwo8RNf95qBp03NUOGwBY4kLqmMl/3OZ3tQLBDI4iLpCAsJ7YXJAiUK1nDauQt9SzYAviOZaBCQJPoxWALPTWefZp5Cvh5FocWXg3U27jTdCAhwb5HMVvsNwEhAnSBDru/Y7vvxfngI35W/o+Q5c3PWA4ccaa+AZc9uN8v7tGJkavzV71KfEp7cEOios9SsMfmTmJ5gkVPbhFxQY9aLssgLeRUd7OWDf+FzjO5jY/ITGCYjLhxmXZxcMkm3l8uBVfsGTwAd7ZxBJAjSwbDyao3BxDlxVBSUKpqpGq2WfS4Tw3rS1vifdpTvYl3ikwGHu644d1ytSLP9Tz1PhERAGCzQYS7iwbBtjlOPZ0HVYAsntR7iAzJ9BrPiiWKj48CQTpKrmmiGfaOYppjUmnBkkpv/X9AhSkTp0TI22N7KDP+LMJqXCvsLCGFmCF2G6V0iSIfwVBgNjHg/+cu0nPt4Oy2NtIZHimpALsFrHhlumqtRF2HH6JD/cxqe5/0Gij/QbE9bNHdR7K914BH10AeVmjwi9Od41U2McUSV2Z4GYE/legU7MACTm1++HWaU2TLbhT3L0jvRZ0H5r5WS9yU0Uj82IE+aFXlRWDB761EBICPlnwlWQ6+IPM0uYAXmP5wHZG75ACOt7eMEh8FEV48q1XeM35AGXqywGbXgCbOv5tq7CynXWA2Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562db84b-bd89-412d-40ec-08db57b017eb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:43.1198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hezqRNr93dbp0EQ5zJEy7IL7BF9QQBrbKzicL70f1gOe4O4ZS/jJ8/i/AHc0gvlhoqUZ+GHrXpQf/YcxZtbWPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: 2NTUNuCQ95Lzfw30g5KPpFc79bmv8ea5
X-Proofpoint-ORIG-GUID: 2NTUNuCQ95Lzfw30g5KPpFc79bmv8ea5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree iterator clean up is incompatible with the way
do_vmi_align_munmap() expects it to behave.  Update the expected
behaviour to map now since the change will work currently.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bcebfd926632..1602c854133a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2418,7 +2418,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #endif
 	}
 
-	next = vma_next(vmi);
+	if (vma_iter_end(vmi) > end)
+		next = vma_iter_load(vmi);
+
+	if (!next)
+		next = vma_next(vmi);
+
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
-- 
2.39.2

