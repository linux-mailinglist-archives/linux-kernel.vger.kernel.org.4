Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7E6759E7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjATQ2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjATQ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:28:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E8640E9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:27:55 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBY6n020107;
        Fri, 20 Jan 2023 16:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=fyJnErIbWF7lFTxyPkj7eK0DihuRuq9cDCnhqrWV/aY=;
 b=pEnmBgY58HfnDhYcxAQpuZ/vf3d9D2Pf9s+GGykFVs1Byzz19G+ekwRJ+9ZT/NLSXSuE
 VAGJNI1zzxv9byFGroBnKprF4fTuhMV5CsplyRv2PL6WL097T4Da194MAShpeSXjLomy
 N1fJD3MMQz3mPE3KcKZaWj80YztCVvnPBle4xm0nE5GMRR8nvuF4eILnr6rI8Zfg+XUY
 L/i37ixOrgFr7eI1rvxyWwQ6imf59+//7Qe3GT5flyGC+RLGvPBlQ021YL2XE5eWM6KL
 GM8BR7pYcdHoBHgR9i5nb9qdkC6vLKMXGg2Yu7G/3hx3DdBnS6zX7MJtYCDzkyLR4Rvl vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tw23a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFH6qD013438;
        Fri, 20 Jan 2023 16:27:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmfaxam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpLVDvcHsEgUmkaXCHjOfjeTmZ09Vcqequ5Z/8rObt3nYqKeyQ7tfnQXXQ4EZ206LpamT36nUm4SH95H55LSWcFrY/onI8Xk95ypPiVxndFdAak/D1gE5oSGssWMxR/IxDL0nXNZWiRQIVvmQxp0Ha8J2/xBpp7OKmAlDB2tHaDhN7IDrkD8SfjCSs7cQYFs/e6ILkLbZXh/DVGTig8ckGQSzN64r6jIVP0L2JxZjflAqWjIIqEV1md3iQFqpUWzx3Vbsaa2t4y/ORsd7orcSekAio+1riFke6b+xWbCZc+GedowpT7ZwoBPvcscnBOUGiQj0YAGdYQOLNXYx9dSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyJnErIbWF7lFTxyPkj7eK0DihuRuq9cDCnhqrWV/aY=;
 b=ltgcofyBWctVJG4P/8Xr5iyqMFd4groGa6PEfPUJHx3nXM8chw1GTY1eNNvF8EuQ+U37s5U57VvDivYK4Qa/BYFpbxSpeNRmUsCx5j772AqzmsE+CJvP41cMKZ9BGwW6z2IYA0gKnKTWuHZsO6Xb/xigRhABBgCNQHxzohWbVTJ8Sz02uOqpgckNo4M9iERCrVVmbz8++BiQ03LllaJ+B2XTUErNWveQzOJAEwl80KdoOxO4KPjAPOzkgga2I4bKciCmCZfnecF3hq3Q2NSz8SB+tQpOKZMtmTxzEs/Ohq4VX2qL82KfjOHdjssIKLTNDJc7Ttf43ygaIOR1gn7rsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyJnErIbWF7lFTxyPkj7eK0DihuRuq9cDCnhqrWV/aY=;
 b=n5IxHrUD7PIhaRDeKOVDXXRAAXFFcPsbPy3VVAfFKBR+cyS2nCWSlxG2498UOYhIaoDxZP30/yxrVTaXuDPYO33AqOe1BibdDJz7X9bzu9PAGMbq1kFCJRC0v6lDRO6ED1jI/Y3L3KTlrc9W2znbsAfPqcBAi832AuUc0hukKZc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6026.namprd10.prod.outlook.com (2603:10b6:208:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:36 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 10/49] mmap: Convert vma_link() vma iterator
Date:   Fri, 20 Jan 2023 11:26:11 -0500
Message-Id: <20230120162650.984577-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ea22d9-6809-484f-163c-08dafb033d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ny2N0C6ht6adxD3hjkhF3vwMT+usVJHuh8zCAcbgTdqDMd1ZiWm0Ir/N1VblPtehkT1p54Seu/WvL6eovYwqalgvUOLU4UAFpXYMlBOIhswOTcgmcAd6vxnONhpdMaKORfo8DgWBc02u65h75dFqhTkjf2B+hRMZV5zvoUj+L83qSMYt9QMpe0Ik72p1rsPU8MefmoV4F3v6z0OtIv5xitA5qvnxkkyHp3/YgKBUqf0T9jCce84QYMGiCzD8i3jmzJ8AQsZdTyRbKIFVrUofrzxHXVHpUFNpeqpqQNi3a6D4NBsnIgLO83aMUfFqyovGt3YQRM8PFbCO9PJgPNu0Gg+fLJoGqjGXjgCtGkduKE6XyBi4fvQykBI5tjK7mKKZjiBDfOGEDGj7neUmfxRDU/swgF+XKGWcYAd20iMvwRAu/RCA4SqNFnGFy3QYA4ktzmktgOz65PA4cRpNEBlDQaZDacLYNQwW3VPtabIcKx0xHIlleIRRIruq9+RE+XsUZboUNn8Cgjvsg2/AdMTFi2b+R11ZKFih0PnBZgVvIBlXdYHOx389m/zupgSwHq9htaaudpUIw6kdeYvZafUZhFH3Wx8C1/cWFAVgjui5Hv++FAz8dpsA0p4UKgDDYwACA4YKwCVo8Z5Wi8VhmcEIRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(4744005)(5660300002)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(36756003)(6666004)(107886003)(38100700002)(6506007)(26005)(6512007)(186003)(2906002)(54906003)(6486002)(478600001)(316002)(2616005)(83380400001)(41300700001)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S2LpEyzJluQNtIscIuTbA8GqVQm1hO0z3AhdoCy9yMObW0lJbr2Nc2u9Lxy9?=
 =?us-ascii?Q?i7PWh7/z0ib/TsHXCocD4H4kFPGEajyhNtoRQJTPSriKsvYAB/U2YurOGgX4?=
 =?us-ascii?Q?95PWuxM6h840ND2LIuz7uoNm4d4vxYXOIWF6lNf/l4fj2GKqltpO5Z1FcABV?=
 =?us-ascii?Q?DhwXfcIPrze8L93r5zQqVQM8Doax0UGFx7KMHjQQVhdp+mZ3RnGRDCXW8UH5?=
 =?us-ascii?Q?WLZwl4FU3rA+Eoo2QapUrkZiXXxx2vNAZwl9GoXLQdkZFhXg5YfMkeCp1Dkz?=
 =?us-ascii?Q?G2wnDcpPrQ2pvFMzrg5HyPsHs9XEHyY/aCJld3TgivncnJbu4cHlKzcr/G1x?=
 =?us-ascii?Q?TWL87d6nHqONI1B8EqZ3louLBia2Yl7KcRn14uSc0uZ+HYC0L0BYUboa4aX+?=
 =?us-ascii?Q?iKmYHUuIPzMk8+GVIzruU0f6Hu16ZKKol+Khe/EuLSKyY09ypSqo+NEFtG3J?=
 =?us-ascii?Q?fKQ1JqbBfDW5v6mkV36ANUqSKg0CO9lAh+/30HFKzwMv/TeI7eJ3BmzawGj7?=
 =?us-ascii?Q?JQBf+5xKIYXa/VdpOz8qK2f+sauaumCvTBOFynR/sxlZLU+PElkj2eiuRXIL?=
 =?us-ascii?Q?AB2oIoOxxVWvTJHSaao342B8kzij43JsSilGSQJ2knvNKWltt1xsXUVls/kk?=
 =?us-ascii?Q?26vDjyLc9gnYYxIyO7fm6w244GiaFEvXqWJcXnpawEPOFw0SmU2iOWjAD5Y9?=
 =?us-ascii?Q?x6MzFJ6LwKk1UEUaMISWwitnLKbIQ6wqfBPIBCtvOAnzNad1F8TLlA1MDfZm?=
 =?us-ascii?Q?P0GvmF02U3AcixMjH9tH6Oq5qbzcDXEbbpInS0OHhUe4yWY3W9FM5d6X4ieg?=
 =?us-ascii?Q?BQw+WjWB0l8z7dJkpKs9BI16ybE163BAhA08cmtBp80Te8InoUCrgB3PadSZ?=
 =?us-ascii?Q?QkZPG9J0z0xyzGTWI1WpDh6cPl0muhRedAcn+mO1/PFPBnOcR8jbaXiH9+Ap?=
 =?us-ascii?Q?hMUBENKjfdpUXk7tzQFaWfNLytl8q6wP1ZvAsbC3gIIz/AwkeztLEeuReZvR?=
 =?us-ascii?Q?iUEZaRubGueA9e7dxI/6tLpfb0nix4rGAvXw4WHJ8WN3XeSn8wC2LgWagKb/?=
 =?us-ascii?Q?bDFldmbhwLMIY1c1z5OTeHwFpX+FkxkkPl5cuKW3ZxFGdg18iIhDOKs17W5E?=
 =?us-ascii?Q?CF3J6KTCAWSRMpRIwXI89I5GkJ5gIaBTDL52rlYbvkqyM+13EdGsfxuoS4ol?=
 =?us-ascii?Q?pgnB5O1fikpn/PjdIy6SfB2ovelPTwBUmqTQPkkTfV3zb4kA6nzgESsaorSV?=
 =?us-ascii?Q?VYfQsX3pVP3U0GtTUrMnWk1FR6fS7oJGooypanxSlj3tlFzezmh5C3wmDYqg?=
 =?us-ascii?Q?ifLYJnCpUhUiTGlG1JZzWfQE09g4Nuf4Se0or9/jayLAB5TaMlMOP8H/Yh86?=
 =?us-ascii?Q?mt8CXxg4fHc3czKcML3yqKpWPiovFH2r1BptcbwJ3L92FVple53wYcH+Qrs1?=
 =?us-ascii?Q?sVomUxWd8POPkEVqoL1MpEdOvomBFTdUVo9UByNXORpmdnqjfwhm1J5rhmgu?=
 =?us-ascii?Q?WeTLt5618DvnYOeaKcKzrurIZudNsH4spO/whf3tL0dQ1yys/MY8AB2Mh5O5?=
 =?us-ascii?Q?vFLgeat5IgvU8HBBXUPKSK8Bwkt/XIQD51cQlRkmIpyTZ6MTuhPplxJ9DmLU?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cQV103FOyH/JRbyk4SV2JBpBlg1m+R+IDrLOlBVA2vXAgzLTwVGPF3UOYT2h0oy3l+Q2n9FqIS34Uq4Tuh6wtOw7xNJQo+9c52pR2uiJhX5co7x0fd8CiPOfiyOQCK/w8pRqzcFhBKVqla56ioXIZP+ZYXDeDP02wkTP/XrJAI+nsq7tg8q9tAHQ9CkyUFqZRXDCQ0slWq5cFBc/NHf9qDtMAP5zd6+AbbG+TE9eTOR1cWJoHU7bI+cQlF+54ogokHFGt+aj+1CxGAlK9mbiYvMKCf1C55Ei5gc0RQWX06r/BzCrTg6a9O54PWmyd8vGcCNZbtmkDE8dr647OSuoeVU/z9xFclsQvsLP+Nl/q494cZKNXotqlrtUiN695/SuOiyzQSJFm6lOWfOsv1+HrFealkMoVypc2C8qAYpeuOMxbQh7wIVAUgKckXO2bGYODGrJyUc1QHBGxl0ATpLg7PjDOak6M8fYTBDPmZNVBgjngzi3i07NMXV2j5wm1kuHjJMr0hRAna8PYK4/O2oWMjutbpXKxEkRbaGTLdmCAXWvJYz79VJuuRDXJ24zE6gBNrXRzgXx01NESg4cJDCwSykhNgyR15cl0mDYnLNx/D/mIbIrQJp0iiptHyueByvdwDrtkpkiVbclDVxV7fsTO6fdPCHNheAwY2y/6pwE46wVlNq6uC+t9LzF0hDszsmqVJM3gCNm4BGv4zqc5rlOoks/T9tSnSqF7SLmp3s/o2Y1hD3GfqMGrbyrRw3zXjZnguYxpbPt+ORUwQmdylE8Fg+rZ40aUN35xPDAjVeq+acVjfHZG6BgP2TqN4I5Tw9xnCARDV1EAUG95+AdjiLKqwP62mhTOb83Bn3oIRMhpVq6XNeYFcrDZnYbQgsl9/W/nT+eANqv4MgXo6s/kfFsCQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ea22d9-6809-484f-163c-08dafb033d1d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:35.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9+D0hPRv/ARuxnJLyX3/jtOQtu25bHUxlpycpu5AuiJlUW7aBuSZO3HdWzDKA/52RGQ3MgBg5S+R9u3wIv8Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: WrjtzaxudaA5bNyxTiKFETuYwSKAgkSj
X-Proofpoint-ORIG-GUID: WrjtzaxudaA5bNyxTiKFETuYwSKAgkSj
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

Avoid using the maple tree interface directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e2ba9b094cad..09a5b6e00374 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -487,10 +487,10 @@ static inline void vma_mas_szero(struct ma_state *mas, unsigned long start,
 
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	struct address_space *mapping = NULL;
 
-	if (mas_preallocate(&mas, GFP_KERNEL))
+	if (vma_iter_prealloc(&vmi))
 		return -ENOMEM;
 
 	if (vma->vm_file) {
@@ -498,7 +498,7 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 		i_mmap_lock_write(mapping);
 	}
 
-	vma_mas_store(vma, &mas);
+	vma_iter_store(&vmi, vma);
 
 	if (mapping) {
 		__vma_link_file(vma, mapping);
-- 
2.35.1

