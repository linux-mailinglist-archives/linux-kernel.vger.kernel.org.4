Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC516759E5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjATQ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjATQ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:28:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D172D518F7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:27:41 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBgYG011429;
        Fri, 20 Jan 2023 16:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=GjZeg7DdqxJGEQ3GVwz+oA8eJAbgDE9yxBeOU1FAn9c=;
 b=Ii0gnx9sIxb0+DR6hYDFqMbH9f1KtjhpdTYfTFVbX8U/g+JTZJkjahyXQaZYan1+jrEk
 ACCS9dvDtcJ15jnA5J6gHDa7AwYa66asM1rZ78cmM+xwG4y+jZ3bHSIhmynyFk7fJAT+
 EcxwfR6OR9d9fHsxzjnmbPN7d2DPqKshTNH8NTbWZIW0BO2LFVzDgokJ9h4CZB/gU35Y
 NstJjkoi3hjlO8LLiagt2JJLvLfCVdR/UE/PwYG0eanW1PnXKDQwgiieVw1N8Eo8QnzE
 jWNi3MebHrKs/C3nMu9DAH3eBWJoEdKKKNxVc6lt34nkykOrG3JcT5UzbdUDJ6liaC/O EA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895aqpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFMJew004631;
        Fri, 20 Jan 2023 16:27:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1ey0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD3Ak8QbhknrB7Zi2MeBLksw/sMmQypTAad9kBwXmZkcsv1OFYvckoHOh+fU5xM0pD46jdqLmiJUxpNk6pp24tYU3UYbYnF3ZuIEl1b9nabzno9GNAlmYDgNkliQAqdfLqITq2wMcbnN4Ch2fgovezGFYnXqbuPDrrQr63csFkK3iMjCa3GHmndW+Q42/QwSKOGT0Kv6p3DNn3T6iy1eLnMZZ+GmaLK54RlIGrR+8/iWdzuNPCydwXHl3ztlg8Au+QGeABDC3B+3PjOsIbz+2fRp2C6NNy94uKzIxUhM2LFwnOdWTwgs/6TzXl35NvbRLQMNN50KbtVtMXLy1wepYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjZeg7DdqxJGEQ3GVwz+oA8eJAbgDE9yxBeOU1FAn9c=;
 b=Yz3cKWcwpUKuoQVHehkQkFEDCPSOsc0V1m7sL9QgLQeafEcomzIWa7eWSle1dhojhewXFJyxk4Fn0PVey7UrpeAT9iSkJvb7l/alhGISG6r8u2uQlYxiPNxap5d0oEqHkwF2HmLzlOo0ANWV3nBtVRRCsZo4mXnEkk5qkNkVLglh7Oly4QmkJMT9+Eqw3V3qqriPm7FEPH/i36OxcNhsAERGtelpdoM7iKvlweJ6gKovtSM73GmAW3th8/SO1wr78k+m91VmCEsFQvPPT3TkcQ+rkPmNtuJL6Waf7CQkh0wtOG4Mmf1YWx9SxxHY6Lke4Af7e/xXbO0lHNjpNdKMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjZeg7DdqxJGEQ3GVwz+oA8eJAbgDE9yxBeOU1FAn9c=;
 b=YvR3XCGFKtIJ9OZMQsST95aa81Cz23Wtu71n6Xt/r6W108+AnSL32uK4DZKYY4FlYhPtdkHJr4SItTokorih2Kj2F6OgdtTZoI/cVfgLF+YSFAWS/1oWlshTsI/Ew4aM+QG5J7rfJCSMKJ1e7btX6RRvnwRvLUBhpqtT7Kl5vH0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:31 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 08/49] mm/mmap: convert brk to use vma iterator
Date:   Fri, 20 Jan 2023 11:26:09 -0500
Message-Id: <20230120162650.984577-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ae89fe-bcdd-4fe9-9ac7-08dafb0339c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEfhQSKKUgvjMc9Xg2pAqfodCKyrO102MdwUSMQi4KE0HH266ieFOdo/4Ok/4T8bOoaonk5vCkL+zEAPP/OxFj8D6aAIt9lz3K6vUCyrxrTqnk21SCBrKbkfAfG+j3MtmgCi+47NQWjB24NZ6lgTsqNQOd1wIc0CnL7ig+vNtVfeehsmSy+zd+kweuOEMndoGG6aZnjd/0ddr9Rat1ZAyAAkmeD+gMWySNbaxSPlhCAX5/c7tDgzdLWCFeV7qk3sAGF1q/jpzO5C4C3gy61+AXfNWSTnPUFBbqZrgtsI8hP4I11ZCynD7TnIGMBOk5dJYwxPJdm4SxMUtbLjgnxguha/y+AUSDK/Ku5QjzxybiYwxap/Ho0YPyRLwL0+YvCHVgSebNhsVC0xtK/YzRE6QbpcvtRxJTsdyncpNe4J5+2av0QHkcVJ/sICWM6PSakTmyHuz8rkcOtNBqBdMpHbqxv1lTRoSUDJdyoSJVY6IAlECeoQIBI3lA0qxRFoV1UHm9XWWgwid6vB6aY5jAGYZNV85sevmfSWrUVyuoN9emPu9/lGpN0cAoQlmC07ZFU9JUsF+9IzyHpu3KwxTHR5y6uQ6q8vjeq6TGQTicQpgu0Q0I3aRlU4NNgkQD+8szaUvjvULLwXkaXaWo94ju1jZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nl0P9UovOLC4amtzHCOIJPJXSZi5YoR7YXnbuJBtxpcQkWPBwiKyU7fTGlVH?=
 =?us-ascii?Q?OPEd1CE1VmA4YpdfpIYh6z+EQAhdXzYqqzPtV75X394PTVOxnHERd4brG//u?=
 =?us-ascii?Q?1pjcr3Q4Z3Kv4AcFvxRKN1DOE76oSlj+E1WsEhYIPd13TUKO7gkNc48QCbtm?=
 =?us-ascii?Q?kBteob9bcVJb5yjgQflVSgoVYsiy8SjVo0zeKhS4IcUBsx3SrvC/FK+FBYSz?=
 =?us-ascii?Q?RpboXZH6Gplc8xftjNROzbJvHaKc2lrWT9AZuxnB6llEJyDMbGbatbZpbf/I?=
 =?us-ascii?Q?B0qCnR6ieCWNC7Oho8uo6pac2qCWqop74/B9LvG04+4vQoSWPKc6mhLkY7E1?=
 =?us-ascii?Q?HEZWs3V5einkX1PYHAv9gFOwQ1jGEL2kdiMrAnlEB2iYwNMgoCOeHgUOwvTY?=
 =?us-ascii?Q?DkrJc5umRcdMDYdvPFmzRHggRqi8+NE3bTh+QmjyEj1H0NMbirVJClRMv6SV?=
 =?us-ascii?Q?VigcD1Cn+RTSDeYpT+KVXHje+gphw/aQMsJDVtNLLH1/buVqNuIyHLjexM69?=
 =?us-ascii?Q?ba52ce+A7U9bAkqDO74/CPbW++pNUqwRa23eVcx9FaMCNP1YUqrt51i4UHYj?=
 =?us-ascii?Q?Gm0An0wBuQu/Wl8qqkUxQVV6LFpVZ2CiSnEAVlZ720A03XUyTwXrwEjPuZ1u?=
 =?us-ascii?Q?/yKu/OfJ8SIPndkpHbmUCbKCZ+ZfLckTKDd7rfF/wu1eh4bvKGqPA83zXkcc?=
 =?us-ascii?Q?TFUALAB51bOGnraCJ8Hstuxg5Z0HRc74Fzj2Kzv6ieCz7Wahk5WPI7wBUJdf?=
 =?us-ascii?Q?RCkE91GNsCMNiUpTz7TEMYSmZVLzA7aRsYYPp+MOhww/gUKdgP+nRAk/NO9T?=
 =?us-ascii?Q?z3hWbqumeLbqI+En2rsA52LLGsp6LIzYgkeTy6v5iKU4dbkFgXDzPR3GA/ZQ?=
 =?us-ascii?Q?zmIyb+/JiUs5vStSP9zj3GbGnEP9UrjZbTkHk4vr5mU2QgEIP9LG7NWNJPPM?=
 =?us-ascii?Q?VjM8UoCh3l3/iHf/VIHEI5p8Pqn4ql4qPL8OVEf9SmhUXdRH0KfImlS3WDgd?=
 =?us-ascii?Q?hsmQ6m5SwRkUxfFpK7xNgHMIj/eJukj6Z0nccUEfYhFeZlIQph9b9lw7W/UG?=
 =?us-ascii?Q?IUt7QDvhTEubYNdK9E96fH54zPKyHyPtXLu2DrvSBXoSEGdPRzsmxc7H+z5b?=
 =?us-ascii?Q?KJot3AkzK8QWOzhBITxZtl+YL0k+4SRzNI94QsO903fZwchp0V1EvTdo+UTJ?=
 =?us-ascii?Q?9jxrH+W0VV3h8j0CWXpvtrQ1bgcn16LRcfZVnKkzZqCh/cS9+ifmSBTt0/ty?=
 =?us-ascii?Q?FFIPcAQqEy/k9ZdvQYYy9+f1P5K1NKyMjUExY/JvPBqWTIZljE6b7TRFOEdj?=
 =?us-ascii?Q?WASnIMfg+uSab1RkB5LepQxPIbIgYu3RE6T1iMJZnz5JeQbaZ+P845I5jrmn?=
 =?us-ascii?Q?BZdr+6h+HVd7c5Uq8pgyMviahTsx1BB0cns/AoFCaXrqZdxX0dsSGXOyCJTg?=
 =?us-ascii?Q?5n2dyb+4vfyW0GgkhqMBWiGteLdnc7aL9AmXKyLo7m2EjR3MkLSnssotlKBc?=
 =?us-ascii?Q?yukfAw5S58/JCyIIGN7S/6S3ach34bNW/5athvVF3EUNExoYW3/R2YMSIC4t?=
 =?us-ascii?Q?0i99kpmom7mrdevIV50fleGgpLjq6zSsW5G6HNaf3MJipYIAso5hCBoDhOCH?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JBYXemFkIeCKQ85iuD2n6Q8WXn0TdFUlW7ltIMrt1dI72S4AtpYw/OK9ymWBz/MeWq7lecRDkhF8VY/4FhbncxT7w2mUQqgi2sRIoV3c1CJTcEd08d55IOKShlaI+WeTunTokNzf38z53BogevkL5qBlRPogyPUz5CPITZFK53Mk0LsKKXgIVFhp5WZmdfpprFasWD9vpbkeFH34CPCTjsdmNjkYfYUZQBomUx08UoQOGcW1FQ2bZCUz1EPvj5GS6MoywgaK3qErZS1QUc5DdfBAIuTuQphE2DLVHFgFoezNRs1WrHTEV+L/diUR+lsZUGecy6tZogdmD+X4wARRHH8AKd9XDe0YfUl7NwnWTkPpDbVehzIFV7cB5Jc0MTHAtPfQJje/fVRkgrPN0yuiKTdlFZbf0/cr+Op/z1hdGmlbYIvdCTk6QsV2OCaI0GNoj4FfEohNe90ac/ifr82QDwRQE3ricQHUntWgZRyUtK6LZy6fSwJQvdIja7qWs1H82GdIeMxB/7usB9a/JnCC1w5/rPLA2YCoapYzecdzdldos80u3K7uzEdschnE/ESdrNwUtijleomtIfVSkFWkzWT6rW18yxDRTNUBJrleUFrpX6zsBYs9+wTnAHe3Cg4lFgLCdPUzMvsf6p2oS3p/a3lOC66Q0DX2Cx0sQCzPvvNC+9dkmEkR5VhfDIBJSMCDkhmGGUgU+CnzliTdDLvzu4NJ0568ljbk2OH2ckFYt0HRT62jRAorMaW9HzsiPiT2aS8Dcwi+RF3Ket4PZfFB2rE4sfWiT94PkYU20/6hMIdllJX06jrB0tBn1aNfVGRFLls2O7RTQi5dX3VTd8/Y8MiG2vpiiVYlLcgzvCR4w8VG32pAvwytbuq2wl4e98gAkaxNL/hBw273y1pI+o8+vg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ae89fe-bcdd-4fe9-9ac7-08dafb0339c7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:30.9514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/i56ZZPbrM/UKq9ayPA+0t5Hy8umE9NAjJQz7Su/eX3wOS1oTnsnc436yWnfOrPe1jW1c8JTfFy0yTZQNOSWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: 0CbemzNU7bPB5xvjYMJD8GXu9tM3tYgS
X-Proofpoint-GUID: 0CbemzNU7bPB5xvjYMJD8GXu9tM3tYgS
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

Use the vma iterator API for the brk() system call.  This will provide
type safety at compile time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 253a7490fae3..e2ba9b094cad 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -180,10 +180,10 @@ static int check_brk_limits(unsigned long addr, unsigned long len)
 
 	return mlock_future_check(current->mm, current->mm->def_flags, len);
 }
-static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf);
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvma,
+static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
 		unsigned long addr, unsigned long request, unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
@@ -194,7 +194,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool populate;
 	bool downgraded = false;
 	LIST_HEAD(uf);
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
 
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -242,8 +242,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		int ret;
 
 		/* Search one past newbrk */
-		mas_set(&mas, newbrk);
-		brkvma = mas_find(&mas, oldbrk);
+		vma_iter_init(&vmi, mm, newbrk);
+		brkvma = vma_find(&vmi, oldbrk);
 		if (!brkvma || brkvma->vm_start >= oldbrk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
@@ -252,7 +252,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		 * before calling do_brk_munmap().
 		 */
 		mm->brk = brk;
-		ret = do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		ret = do_brk_munmap(&vmi, brkvma, newbrk, oldbrk, &uf);
 		if (ret == 1)  {
 			downgraded = true;
 			goto success;
@@ -270,14 +270,14 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	 * Only check if the next VMA is within the stack_guard_gap of the
 	 * expansion area
 	 */
-	mas_set(&mas, oldbrk);
-	next = mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
+	vma_iter_init(&vmi, mm, oldbrk);
+	next = vma_find(&vmi, newbrk + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
 
-	brkvma = mas_prev(&mas, mm->start_brk);
+	brkvma = vma_prev_limit(&vmi, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
+	if (do_brk_flags(&vmi, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
 
 	mm->brk = brk;
@@ -2907,8 +2907,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 }
 
 /*
- * brk_munmap() - Unmap a partial vma.
- * @mas: The maple tree state.
+ * brk_munmap() - Unmap a full or partial vma.
+ * @vmi: The vma iterator
  * @vma: The vma to be modified
  * @newbrk: the start of the address to unmap
  * @oldbrk: The end of the address to unmap
@@ -2918,7 +2918,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
  * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lock if
  * possible.
  */
-static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf)
 {
@@ -2926,14 +2926,14 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	int ret;
 
 	arch_unmap(mm, newbrk, oldbrk);
-	ret = do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf, true);
+	ret = do_mas_align_munmap(&vmi->mas, vma, mm, newbrk, oldbrk, uf, true);
 	validate_mm_mt(mm);
 	return ret;
 }
 
 /*
  * do_brk_flags() - Increase the brk vma if the flags match.
- * @mas: The maple tree state.
+ * @vmi: The vma iterator
  * @addr: The start address
  * @len: The length of the increase
  * @vma: The vma,
@@ -2943,7 +2943,7 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
  * do not match then create a new anonymous VMA.  Eventually we may be able to
  * do some brk-specific accounting here.
  */
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
@@ -2970,8 +2970,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
 	    can_vma_merge_after(vma, flags, NULL, NULL,
 				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
-		mas_set_range(mas, vma->vm_start, addr + len - 1);
-		if (mas_preallocate(mas, GFP_KERNEL))
+		if (vma_iter_prealloc(vmi))
 			goto unacct_fail;
 
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
@@ -2981,7 +2980,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 		}
 		vma->vm_end = addr + len;
 		vma->vm_flags |= VM_SOFTDIRTY;
-		mas_store_prealloc(mas, vma);
+		vma_iter_store(vmi, vma);
 
 		if (vma->anon_vma) {
 			anon_vma_interval_tree_post_update_vma(vma);
@@ -3002,8 +3001,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 	vma->vm_pgoff = addr >> PAGE_SHIFT;
 	vma->vm_flags = flags;
 	vma->vm_page_prot = vm_get_page_prot(flags);
-	mas_set_range(mas, vma->vm_start, addr + len - 1);
-	if (mas_store_gfp(mas, vma, GFP_KERNEL))
+	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
 		goto mas_store_fail;
 
 	mm->map_count++;
@@ -3032,7 +3030,7 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	VMA_ITERATOR(vmi, mm, addr);
 
 	len = PAGE_ALIGN(request);
 	if (len < request)
@@ -3051,12 +3049,12 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	if (ret)
 		goto limits_failed;
 
-	ret = do_mas_munmap(&mas, mm, addr, len, &uf, 0);
+	ret = do_mas_munmap(&vmi.mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
 
-	vma = mas_prev(&mas, 0);
-	ret = do_brk_flags(&mas, vma, addr, len, flags);
+	vma = vma_prev(&vmi);
+	ret = do_brk_flags(&vmi, vma, addr, len, flags);
 	populate = ((mm->def_flags & VM_LOCKED) != 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
-- 
2.35.1

