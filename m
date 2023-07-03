Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB45745530
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGCF7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCF7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:59:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14253B6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:59:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 362M0IrP009736;
        Mon, 3 Jul 2023 05:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=gFYk9aa5kbnZajo5uK0L2ZV4PacQ7xs/SUS137pU2kE=;
 b=F7nQkhYX/+L469mNz++FGGTzynh8Aam3rZeVuJ253RqtD/PTWRd6iA9313m00h8uIE2M
 8Bi4ljW3UEEil69+MVrCWqqaRKa0Rn4F6bI8j6VFznLIs3qTACXNIuC0QpBlNi90PDYE
 eXqCJ0VOfuDvTkS6HYpxPFYn8msepEVLqHXtnNoIxOeYdsuhldC8YUb8EAXt7ZAwzp0a
 Mbqrys/NH8joQY5dUwNCuJHnnxNjvpWcVvxnVD2kF5sT+f9o2aCdRCvA1OE+pOC3PnbG
 W29n4WoeJh5pGijClfthdfRh1nYCk7j4ixIpEVIaVwQRMHKY+GWENh71NRgOBC1ogH6y kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpu9ssd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 05:59:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363406s2020201;
        Mon, 3 Jul 2023 05:59:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak2m4ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 05:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2x5z+QyxmQCkVay8U05dK44UdxN0THzvWpl+/4IxvwORjdcMDhZbAaBriUTWm6mMbt8DFb93uQtoq6jx37Q+qC0wiX53djR3xW6+/lXPc0NvlRHwm6NtqOTCKktEn21fqyr1g+fedaVv+1spiysZwRgP+Fts2kQjlqJ5bYeUvk4BKThMrW90Gg/upSz/hTurOGN1n5KEZlF6y4PgdKOSpiG1Sdpf0dKvNAGHKzp7q65p624z4tw4x2zZVE9n3XOSpBDgsTJx/zjP1iEIVzKO4w6aLNCI4l4L427qZ8fOkci+TK4MgvjgppYc68XIu81lXStsRSHnPY8A3uLP7QKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFYk9aa5kbnZajo5uK0L2ZV4PacQ7xs/SUS137pU2kE=;
 b=KFucXsfjmrot2/lthEteci15E7RYHuTCVmJmTD+dr/oHZCtb0EpqqTT3W1DKIDa2HvOgiHjNWDKXN8QOlvqw+D4KFp2myz62eG+nowuo9d8GzJ/vxmjdWTZz5Rp/1l/q66u0VWWlFFZStVygvQXTFzWCxfcfS2D14X2Lx+8MKyyyzmAZj623J+K3R7ZUnl1VDsti8yNpmRGpJu2iyLKwZJ7Nm/1Fl3nduQlUZQ1TI0zJkh15YywZ9cfT1HG+DTH18LoAxPB06NizdRjmRC/skvvT/apAlBYhVGJZrTwNV7jZso+NO0hol/qgRYrrKnMpTp0BY/joNebkwx5Uu0l6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFYk9aa5kbnZajo5uK0L2ZV4PacQ7xs/SUS137pU2kE=;
 b=TMQOWs3uV9Io4DHAVHSZ+6YrabTltXLBhzCYmC+bqRrXU90fKOD6tAunCR5Gfxee7OY+oO8KwaCY9G1xmp1Ugv9u5PUB2VYkXDnzS5sb31QEdIa2WzzdkhxyU4WscpmHIS3C5RhrbwQPX0M4BkwShTObTivdo20W7nX1GJdRqH0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA2PR10MB4697.namprd10.prod.outlook.com (2603:10b6:806:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 05:59:04 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 05:59:04 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 3/4] mm/memory: convert do_shared_fault() to folios
Date:   Sun,  2 Jul 2023 22:58:49 -0700
Message-ID: <20230703055850.227169-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA2PR10MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8c906a-e5b8-4c31-d6cc-08db7b8a9b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8Akol0YSu5KAnshkV8ClRUIP8QP4iqvjj8rKG2+j4VoKqny2oTb60faR+VblMYHcph6RlNSEi1YdRLKzoWvUPwftYXqFSYUUxNwsOmms6IZazJCmUbyvwAi9Yy4DvG9PGIKajN77k162vf0cdeEBlPWuIXrjpju3vDqnblJ/o4b8JD3GTNhPcBAGiF6dCHVQAxAk/g5aXOOKG/M6D+FFREgH59UiCtDlv/c46Q/31NKSGkE7YLycfZqgqQEJeL8zttsomm3GJ7PIPeO/T7LwDdEkGYELxM2DDW33nPMzxZBhyFxHkrQBAOprVt7xLYxxHDp2nJUtIX6Fxg1pfMOJmDGWVs8J1SGJ7w7hTLeoCJXTm1dTqBTmVS4/eRmLAg2bABdXW4zGpeuLyuj35eDpsVQGxCUEaJelY0e/9YRfQ7pnMWR7dZh/MJATmriI7Pw7UfzBkPN5NNY/VPVXSbZm1xls1rmQAT3r7kdDwE/p24WqUgqkYa1+xukTDxrI1AKwD9wVkqf2jSQ7T2LHZMHhEqkGOy5kJpXv9KTi0/f0HVvJv/qTesjr8uCyU/hEXuR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(2906002)(478600001)(6666004)(6486002)(86362001)(41300700001)(44832011)(8676002)(8936002)(5660300002)(36756003)(316002)(66556008)(66476007)(66946007)(38100700002)(4326008)(6506007)(1076003)(6512007)(2616005)(186003)(83380400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NRvIhPAVMg2MbRf/29IPgQoNFRuR2wzrSV1/AvV0dxJ/c9vDhTgjF+AE1cDk?=
 =?us-ascii?Q?4uSbfcn9ZRnVqTk60JiUmzfDFHlO+C6t//Q5XGWagmnZUlguZQvE4FNrbczm?=
 =?us-ascii?Q?J46PxJkDVnrPEMzolAK+8j5EypHINdDnKdWPibv+N67RC42da+ZNVdQ4NRYV?=
 =?us-ascii?Q?Z8qy91jOx8JALz3sqqHegWEkNtKzoy4eabZogmTbz+wxa5nJstAB1uyR0MAy?=
 =?us-ascii?Q?D4kWR+ydHBsC6x9H7iAr3Y+hGMsiekBcNWwYFg5znl8BS1wWiQ7aumAEEGA7?=
 =?us-ascii?Q?/v3zNYEMzLIIoEiWxilXazSNE/lT7ZpJKv0wJ+mlxbZpLAqp/vKdgd4HG7oJ?=
 =?us-ascii?Q?TkZ9mKPpY0T2xSbHBrm09A3dATlt85FCc8zQtVY7U2ht4CvQczLI/iEq4yfD?=
 =?us-ascii?Q?oOkSvJBOwpjR6+S5Vo1bb6LBOD83mrDXXC/KjMkAcDCOWsUiG6KKfPwO4nAp?=
 =?us-ascii?Q?QaSjdd2I3stOm7Mp5TyCZloZKahrmgm4zSZE5CHU6lXQvJmJifwCq62zGi84?=
 =?us-ascii?Q?b5tYmtD6YslR0Hq1CrnZvyxs53rbwSNpK/eAvzFtYAZQTXURsMKM8YujHoGo?=
 =?us-ascii?Q?rkf/7h4xmd/cXPC3RgtBcII6dcenWz4E97l+ObxJQRHGnZo768lggvw+D9jP?=
 =?us-ascii?Q?SGBWZhhk2TGJbZejLCn36NWhVYVdDVUsg2a/MEfbpVCodX2WBqMEdyLUgzfr?=
 =?us-ascii?Q?wm+LqktNPauMHQ0Md9yvJIEuWrh7E9CB2/vQZLn/5UB0fDI/CuMRtLbOldrK?=
 =?us-ascii?Q?IUekt250mH+dFLDeM4vwyJ9a1OJmCnv4KHWXYWtvN8GBxEFv4+5SOiKiMJxs?=
 =?us-ascii?Q?AVU4NML1gMtjpp7TqPf4Ml/EmEDBhHhJYOkzghw0K+7jyRFCKszTez9nEXm1?=
 =?us-ascii?Q?E5dOKw7ZO/L3y08PpPr2crK5Vl5Sg8rDkyyHZOVKWhYt6hs8hLS/HA/znI+h?=
 =?us-ascii?Q?ZFLKH/b8g8pJe8j9FLxd/+0fMdDuL/BrIQg3HnwWeBxcpLbvsDUaJHUErev/?=
 =?us-ascii?Q?f0j29UgKtW6G68CKjFAHegKN8Nhhv6+6nKyTFj2Q0e/Qq1GpXyjbERihNqpM?=
 =?us-ascii?Q?7UYO5qi5UcmMBVpRr3HsmOn5WmxXFCxa1pn4uFu1gqVDeNxnTbnNReKU17n8?=
 =?us-ascii?Q?Thyy3JWdOxyrj6lI1h9G+qCQcM88+Dylwdki9B15h1xRaEnlp/eGrbZDVhNJ?=
 =?us-ascii?Q?kVYVF9FR97JQJq+RuApPIXMhfzAP++BCxXlHFj+Q8UXdL6HYYRIAuFdu/UdZ?=
 =?us-ascii?Q?OS5iEZFvES5gIugkdrABypCgOM5HxBdSXBA6qg9Iq+xMek6m2Mi0mFbeFO2B?=
 =?us-ascii?Q?TkKF0LUU43+hp9sjIYU4pFImOmmwI9OghtQE+H+7Cpw5uUTxkyq7H5k4cQcK?=
 =?us-ascii?Q?I1lgI4X5ZbC+DOyQqUI55NYZDrt52w746UlG/20FusesKzIvXsw3cJ5tpsRo?=
 =?us-ascii?Q?+yeQYa+F31kw98sNo6MytZKDN2xKL+eIAd5SGWXt7S1qonYe3z5EfEw6y1bg?=
 =?us-ascii?Q?lDw/iAW0Bcye2JNEEiF3X+KrDzAdBF0MR1UvO9WxDEhKJUKYK+uzFpwv9ls1?=
 =?us-ascii?Q?wo6UgTo9CHwScr3adNtgKi1c4YWQ+D0P5rrGe21h5uGZSDSK0Rkv3b4tog5T?=
 =?us-ascii?Q?nbg8UEX4ZXJCvXdl5ceD1Fk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t0MrgEVILwrsRIIU4IfH7T/D/fWNdQiaDSoz7W9EgjhOs7+CmE8BJK+TrNh0MkkhrdohlZ/caD8U49vrN96/a4kNKUqat4hlakfrk8dTsZjeOSaQUTZgDxBpC9Ra273EzRglo8BLwuPXgiTDVj/lmynGmJJu12Cw9Y+fnx1ah8niBWp/AQZwKM+tSsJkTUlHSIreJb/Oz81rfmmHHaHrcsi0+xswYbfByNggQsAdek5mlLDhufwCbN/x+OyrFRpUMFL7Cm63uAzUOpPLs05iMl/5LgtSWChVsRU7Eo9tYbgHBnn/4N3cy0R8SQcudy0EEcMp1GuHWq+j44pmAbifO3zAIjY4EnBUkpQd214q2Gc0TZfjFyQRwR/DnGt0HrpvCoTZYM7cCvNeNxnB62sTuR0rlpZBw9w8sy4tbrgyRelFrPWs6acRtZouid2hPf2767wAc9C/juyWLAJqSQbo1L+Z9rBL7EDJ+baF0zbf+G3RZY/qr5KPIcjfDb34WwwviiuICMPMrSxjVR0w6eXGJbejPYQu/lPsjLA2RHNchjL/26A5bJ3taGPhpWBhWm4tRs+sM/9ILKKPsXX+0mQQD3Yue4DEhpZI9GrxYgNopcR2GEP1un5Tg1N3j4SqZ9XDNcJ5BIdH51MjFd7p4yDqZOii29/qZgHUz0ypaXP8dmqoE7z3m8KZ+HlZUOWumzULtfXUhQKRjBMAeyTCIXgPQjL1hFAEYvvmBJLf+p1FvxUDP8uzilmAaj7POCrC9WR0EKFT9nV5hlFgSiXdn0k+WfNhXpQCZl9ynFROhqdN/NfpI3wVYAqgZfypB1Tc0qxiyv9bNbmWmN7m3hIojZRIzPyZGeksKFwaVkfJUlz3Bvg0ARJxqHSvyZ9M9mII5WRO
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8c906a-e5b8-4c31-d6cc-08db7b8a9b3a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 05:59:04.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xN6c+Jc65DBGxZ0k7dpf3fSslmU277nJEaCKQ9ifOSX4mQNJBxfTWKOU6aKOBvTtD0XDOz/N20w/iTUuxa/SDP2LTxcLVpVbfL/02DA+0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030056
X-Proofpoint-ORIG-GUID: gJ9jXKm5Dfz6Ib6NFElSeh6loN7MmKkc
X-Proofpoint-GUID: gJ9jXKm5Dfz6Ib6NFElSeh6loN7MmKkc
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves three implicit calls to compound_head().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 93480e846ace6..33bf13431974c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4594,6 +4594,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret, tmp;
+	struct folio *folio = page_folio(vmf->page);
 
 	ret = __do_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
@@ -4604,11 +4605,11 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 	 * about to become writable
 	 */
 	if (vma->vm_ops->page_mkwrite) {
-		unlock_page(vmf->page);
+		folio_unlock(folio);
 		tmp = do_page_mkwrite(vmf);
 		if (unlikely(!tmp ||
 				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
-			put_page(vmf->page);
+			folio_put(folio);
 			return tmp;
 		}
 	}
@@ -4616,8 +4617,8 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 	ret |= finish_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE |
 					VM_FAULT_RETRY))) {
-		unlock_page(vmf->page);
-		put_page(vmf->page);
+		folio_unlock(folio);
+		folio_put(folio);
 		return ret;
 	}
 
-- 
2.41.0

