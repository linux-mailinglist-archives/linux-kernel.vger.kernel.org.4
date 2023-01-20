Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE36759ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjATQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjATQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:29:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74737C153
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:28:43 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGEBFP006188;
        Fri, 20 Jan 2023 16:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Q9gXkD7pNY5boTf6/n69cYfv4qPG6fatPSUYpXkTdDQ=;
 b=FAc7yrN/dbTPy5RJehZjA3pdQxAXlGGCw4VXjQPLHIlY93DFfbYRaFf2ry9wy32yWmw8
 PSImKQy9qRCN4quilZdavNBZ0RteutDCSKw6grMeOmc+2N14VATTzZdLs+BBSWMDlVgO
 nB3ul50stbBYsF3hhw/2hPA6lViTtlPbdj8eUVAdUpL7C44R3nPeUP1H6vEEKI2il2YG
 R2bIx1pi+e1SIG3S8oGoEm6jOIA3VQiKkgMjR3lkLUUNdMW8WQfxNQrZzQpzJcUo2WZ2
 uu+YBSrcSO80UEhLV+LHm1zujGKnMuL4sep2ladngXU1Qw6hvjRt4n0ps8samB2PFLWj Ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdmfv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KG4G4Y027874;
        Fri, 20 Jan 2023 16:27:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qud9185-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfu0Qt3wsUpqfjS+N5cBcQt3N8V+Z1u95LxcHub3o36ZGfsYsab+TS88yEtTz7dg4XfDMHnW+VtiyVW8eKVzOfqTefvcj24cHyJ+MyGYb2HkTyEXC212b8KfGkD+oyyjysnfvRLmtmGchWxoPiZk7iVpmnjbl7MP/HSd4N6gdc71cF6EsxIV2sWTsmtoHx+bszi02Eh8EiarRX9/xIEa5nr/K7BtvARGlC/5lw1gjGyPFWHrBqtsmpUbQyAxNx+AQLAv5RsAst7TsFwV7eXO5ba9sKxQ7IRBJ1UDorsSGGigIsnXpfiBmldI+hWfvZlud7xZ3w0qv7dbym/37RUKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9gXkD7pNY5boTf6/n69cYfv4qPG6fatPSUYpXkTdDQ=;
 b=KobgkiXvyZvuTujVB5CNSLyRemPJRMvP933tuC5w1xuZpjuSSNrM4WQeZEg3CcXm+v5WzRVdRh6JToTRy9J5OJeqOY9OtdDMJ9K/4o1z55hq+x9c4dkBGQGxB2mgqp7F+17HenQfiwafppBLPPYzBY5hJ7Iulmh+fI+71oMY90u+6JAzA78HWG41k0T2AajNW2MyKqrN2qqOJ26RtIpauLCnqRqqCcQXwv/+4VUMhuR5nZ68cuDkno+pk2sb46ygmrQ93XFVff5M36Ne+pMT/kjX5y6sunceqIyFi/IumFLvrWbYgCVRWZJ0kEq+ZrLNYqrGJ2GEP0LeA1lGTig4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9gXkD7pNY5boTf6/n69cYfv4qPG6fatPSUYpXkTdDQ=;
 b=HyZlBs8w9BuuMcoo+nvyy22BpRC2uW8ui5NDB28zo4ZWK+Qcwo5brnC650rigHHYqZYmP/ItWjM1JssxiF556kHvv980H/jBNwu8w8XuL2ITx6YsJy9OUKVb0D706z7hzRyj1XjF6ZkILuHqHIqEfkX0CJcm2522tsmesQJOTkw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:46 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 14/49] mm: Add temporary vma iterator versions of vma_merge(), split_vma(), and __split_vma()
Date:   Fri, 20 Jan 2023 11:26:15 -0500
Message-Id: <20230120162650.984577-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::31) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f4a4db-5c04-4bdf-6aad-08dafb0342de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwEnEE/N5Ys2t5hgkywDN8WKtXw65ioWuGpkFVHvpBRYueFLz4097g9EGLYQ4lewom1amyS+Vj0PxsgPwaYaGldpluhtuNro0sL1DsQTcmI8C+J+tKldB9FdxCOCutv67J1K/3RmR0LWkgZAHfnzp7gm2Wcnf/i6ijpNW3UBCh5I/oEWyb5Qnom5vXj/mr/IHytWwT0uZsDVQ+agye+97ncNfzto6sTysWZuumh8AzSLpCi+F+4wsROX+2ZJVHuYdjuD5xnQaxTRtHDoQkQZg3RGbjUQXRUXj2Ikt5mvB33FPdInSOh0clMHuWKefdShRXKNoqpRy5u/XH/muDBo1knD9swwQw5xYA7noKvM5XLLaEvIy9WM2RsUw1Roq5Cyu7OKmV4oCb2/1z6QS+jjVw/Vd4mwEL21zJuVAXh9tN9BlUc2QCCbFjlSgIlbLsHLZs+J1/itYwwtE64Tlrmw7auUUywf/ZxZq/ORohD6Ebb96Q8FWoAM8D/Jj/vV9gvbOw5y+r6YOCSUjQE6Bd2vvQEZX9sKVkEXCfwHHNwEefhXfyvgZUQM5VnOEf6DtOClO0qb1tmf4tp7idG1h9O1M7TXFJtjXn1XYOIVVAdY5U4XM0+rT+KTSdZPwIlLQxOGN9IuWZl8BPCQ1X8KCNnx5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JgTpiTMV5E3/wkM3wAyJfjSzruksIib0hh1hCAjJ/99o9lBHWqknuIVBR2D3?=
 =?us-ascii?Q?Xo0wMghUOkSGsWR4AArYmpaJPtSHCP4kS/wBsuLDXgMhuD3YFD8Zhb7ix1Dq?=
 =?us-ascii?Q?3Xg7Ktvpgf0R6GhGN59n5WnJK2gnq2P3JcXuZ5FPkf5R9nDQ7XMIAwrM8aGa?=
 =?us-ascii?Q?ju6IQ86Hv5zypmNqCMt9pQzqueodWqAItVB4UbSeA/RlOKFHRQSepBy56Zfp?=
 =?us-ascii?Q?r2NyTUAr2xbWm4J0feGx5J5JUyBb7GbfhLmWA0dJ4a5srZyXJyi6HOzrhsqz?=
 =?us-ascii?Q?kWZuCl1j8t48GRzBDan5AyeDrkTr5Ako40HHsfdNALmZe1l3/F2hARTYKvHk?=
 =?us-ascii?Q?H6j629ThnjVTVM1FHzRrYCPV+MgpiTdOUr6MfGXJmzJZHALkvoDtFnIN9Nw9?=
 =?us-ascii?Q?E7w8qRMlmUBaD/n5OzvgTkIhyqFPKicBdpqhirG6poMzqBM4RtHMQolJV3DM?=
 =?us-ascii?Q?/wGwKPt/N1kUKE+4IWGqYSB8pD0GjIzKkyAkgqn7dmYjzjYsTp5wEd6gjtQk?=
 =?us-ascii?Q?r2KN9KsLGQ51jCwFI9uqyZTMRmmQliNLM8LOQbfV85ylgmu+CFBDfjSm5SVu?=
 =?us-ascii?Q?8bMdqyNiI7KoDdyuapyT7HY3WYyUJC3xUhcgvc3lshtZ+EFhvU7h+J0ZFBVo?=
 =?us-ascii?Q?Kqx+ppjcToZeFhEX8IjX5vMPZwBWs4FIBanscOuhZlrmeROvBTHI+sa1TGLp?=
 =?us-ascii?Q?ROl5FBS5XgSkGaRL0k5Lj1kRh+9yizsCMNY6RstKVi9Cx7JBDwY00DJ3Wdmx?=
 =?us-ascii?Q?MeSwRnXYl4afki7aarR2QiECPevNl3eM6sDR7+HO0A9T6BLQOh3wZ/HetCVd?=
 =?us-ascii?Q?3EaIz1cd2L/hhhvUyZ3BzzE9DAQS+h4uT4i2O5CNKOjV4l2SfHp6l0XRD8Jv?=
 =?us-ascii?Q?H1dZz8UNMnSYzdVtBzvrncCsAJ7j/sgjeNn0vXt8BNU7rNtDeAiwcZAmt3Xx?=
 =?us-ascii?Q?POxBk5eE0BMbHxI+nBLTN3zdVPQz1HaDe93i8GXKdVNxVagzudSg4Y5v749K?=
 =?us-ascii?Q?lRDa4OYbOY56n0dBL/KAC3ecbqrQg4h+j+J5lCzqjJ5Rwt+Mtwgq6ajk5+tH?=
 =?us-ascii?Q?fTDg395Ef0iVCB1opaxLbHvaiF1iHpVNJnHjpJcqH6nUxQ/+UUlwMVyKgeu7?=
 =?us-ascii?Q?n+Ln0UmPYbBZCbkW75YzUfKuXrpvUYAYKgR5i/d/4BQYed0jW35XYBUXajqS?=
 =?us-ascii?Q?ezkndkj/ENcLJ6a1bbm7og49Y68GGC0VHD+8vONQiJ1Psl7nT9/Sb29ddJyK?=
 =?us-ascii?Q?R202jA9hoLl7OAxIGCQBSZU2VbT8Dn10B+lZn1BW/sojAR9EVxUcYQpD4VLB?=
 =?us-ascii?Q?f9lf345KdggsToXuQF2zFT95XzxHNatZR03JrENoSv6LxQBMCuxc9+wFMLWt?=
 =?us-ascii?Q?x0zofzPCQmorIVXsM44qZbuK3cwaaHi4C5WwUwy/vhbS1HHGJFke+y9y0XVl?=
 =?us-ascii?Q?6XZYnCH1xnJju/LQ7lyojbIrHe90UIysiL3j1+Ayhmjr2ImpSlkVh1yYO6zv?=
 =?us-ascii?Q?Ue93lDDb95onezd21E4ExxBmxnSVpZ9HsEYar5uPJWvFW8twVRl/fKrOevbK?=
 =?us-ascii?Q?gNk+RUID0q50mzgNLKTDJSGPJQrRURv1na4IxVZmOoW7TMASBCtU+1vF9mMf?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LHD2bO3QoYgkob+yf7Qyl9nBK4BI0qAgdteuIw9w1u+O6onSdO1tIDpBCfzirdWFIvUXeb4uX/kDEfq6wufolq5+LM77fNsmxWouYiq2glcbZ6+8lQIN1Dr8/c93NNgvJnEVT0OeIr+B0+o0/6i3YhfIDuVJpLikqZ0KFFZL/QiyshGlQnbADlPFyf3Lu50tx6ZDzvpKk3uD2YAL27ccZNbSAl6yFmLyDdD0HjPz62DMFxLF5ctM49PIFbD5gmsT1/B33sMT4TzLIFmc/Ff/UxxFNsoPY9vSvbPrlZyiff93z8+2XiYQcLm13DRqSOwqx6Coqv1GNFSSUWWmGlrHZq5No03jkYncZl5XlAatI2HsthQv0vCaucTO6n9PW845hBMuar3M65UaujC7cOh0+3mNw/KymG7XFm7GUPZCTq2kc8kax9R4ms1zFDQbYdz2q6F88/KjQQS2dy9f1pQmTKf/K64xpncPRIXbZkJ3YqAblRITyNQ44yAoMSHjNCUY5VGKqoDISKzSUaEGVPX/3MWZVjvMdTnwNRNhYsVm1IctDBAwMztuikFx/K9t0XKYcox9A2+4pIiGj236172teTd1pU4PmAnLBtK5dUrbNnubQBu4rWqAnNznQg20cXFpCdenK19VqsKebWpfbbWFTClkT2M4ouM6iRuspoMT7c++SkWcJi/oaootUh/2ShgO12Q1pK18XD94klzLnRPbWx287aSW1pSwJSyCtHNguowc+uu/Y0pgO7TwMymGnm8LS2nwUWOyAhYXCGfHUP+1QsUHpuPtlIJTS5gqNw+tapdYeGgWbWabdL+ziSMZNrJXQk2RXWlcxPaNjaRT+u4SCZ+gO01FlabyMnatHZwMxHqq6J0AUXZLT7kLKt7PGLyizC/f40IJhSxWiauc7NDxOA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f4a4db-5c04-4bdf-6aad-08dafb0342de
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:45.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3w3eTvOFs8F0o0M/t+At7v5v1PEmyPm3ed0BrlvYFgvzuKltTRrWguVXK6hEWUu4HLOxwZpzDgNObxb4q5dfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: oJiTum2dZVAtP2njHh6P48PelAvSrKnB
X-Proofpoint-GUID: oJiTum2dZVAtP2njHh6P48PelAvSrKnB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

These wrappers are short-lived in this patch set so that each user can
be converted on its own.  In the end, these functions are renamed in one
commit.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 11 ++++++++++-
 mm/mmap.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 152a1362b800..956025940053 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2843,11 +2843,20 @@ extern struct vm_area_struct *vma_merge(struct mm_struct *,
 	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
 	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
 	struct mempolicy *, struct vm_userfaultfd_ctx, struct anon_vma_name *);
+extern struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
+	unsigned long end, unsigned long vm_flags, struct anon_vma *,
+	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
+	struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
-	unsigned long addr, int new_below);
+			       unsigned long addr, int new_below);
+extern int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *,
+	struct vm_area_struct *, unsigned long addr, int new_below);
 extern int split_vma(struct mm_struct *, struct vm_area_struct *,
 	unsigned long addr, int new_below);
+extern int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *,
+		struct vm_area_struct *, unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
diff --git a/mm/mmap.c b/mm/mmap.c
index 2ec671a119c1..5092d0405883 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1091,6 +1091,25 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	return res;
 }
 
+struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+			struct mm_struct *mm,
+			struct vm_area_struct *prev, unsigned long addr,
+			unsigned long end, unsigned long vm_flags,
+			struct anon_vma *anon_vma, struct file *file,
+			pgoff_t pgoff, struct mempolicy *policy,
+			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+			struct anon_vma_name *anon_name)
+{
+	struct vm_area_struct *tmp;
+
+	tmp = vma_merge(mm, prev, addr, end, vm_flags, anon_vma, file, pgoff,
+			policy, vm_userfaultfd_ctx, anon_name);
+	if (tmp)
+		vma_iter_set(vmi, end);
+
+	return tmp;
+}
+
 /*
  * Rough compatibility check to quickly see if it's even worth looking
  * at sharing an anon_vma.
@@ -2276,6 +2295,18 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	validate_mm_mt(mm);
 	return err;
 }
+int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
+		   struct vm_area_struct *vma, unsigned long addr, int new_below)
+{
+	int ret;
+	unsigned long end = vma->vm_end;
+
+	ret = __split_vma(mm, vma, addr, new_below);
+	if (!ret)
+		vma_iter_set(vmi, end);
+
+	return ret;
+}
 
 /*
  * Split a vma into two pieces at address 'addr', a new vma is allocated
@@ -2290,6 +2321,19 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
 
+int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
+		  struct vm_area_struct *vma, unsigned long addr, int new_below)
+{
+	int ret;
+	unsigned long end = vma->vm_end;
+
+	ret = split_vma(mm, vma, addr, new_below);
+	if (!ret)
+		vma_iter_set(vmi, end);
+
+	return ret;
+}
+
 static inline int munmap_sidetree(struct vm_area_struct *vma,
 				   struct ma_state *mas_detach)
 {
-- 
2.35.1

