Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A4F675A04
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjATQbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjATQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:31:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D8DC4EA7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:31:21 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBXO6020071;
        Fri, 20 Jan 2023 16:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=57GulC22IzZN7y5jzLF7uN7yeYdZzkWQzGDDgEf53d4=;
 b=T/dvt0SIVNp1lP+X23v2zS/14f+VG+plnmYRtWx//pTHNCUwh42u63MWcoxYpQK8OWl5
 uOz5jGuyg/TBVNsdknLPvx876u0SYZlxvvbcNrVTvojMjcFTCfd2AmNl4h2o2+I3JElA
 kMSbpWgUqLgl6bY8pZCQ+FeYXjgq7PPcx2pm9kzopy1/GV048sKjEUeTZ7Qk7makfMSf
 th4kPb3Hyo2PCAdqNbYDxNXyV2CjIlzx9V2Ur4fVDf+Oh+SBZvvECM0cYjLJoke4Me6w
 kSWX9+55z29E3wMQ+l4mfmUZNGcv4PK3TUwL6BcbznS6Atr9IkDOFtcAuuwvxaTKtAd9 Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tw27g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFCTaE000901;
        Fri, 20 Jan 2023 16:29:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2sxch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9JHwiYrW4XFeMbIkSFDoM4BkvWi/rpn6QKzSAxxbk7Rs+p9AdBrIL5hxqLof4Ekg13cbggjzGU6UxpGLgj9fo7hq5haLkGPrtbvBDsY/uwtkGe/aH1J9yEcAu9IKctyQDigBQooGyX5hvE8vLCQiwpTZ48EReEy3td2vWNNcg9fxsdsbCBLDsEJzWWHbDiBV/M9l0Y0umdDF6KQufcgh0mAn2K0uX98ejVDLWXOYt4GoEpTyX56AIlzV2MCOjwNgU07TjWV5eRhLhPBLpCdG74BjHL+uT0rw6/VGOV9BvsrdVvStB+U5Vz+Y9RuASWrBFOWXjemraKxgs9gzI9Epw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57GulC22IzZN7y5jzLF7uN7yeYdZzkWQzGDDgEf53d4=;
 b=eqiq7IBD2fwBbeJPWlGUW0bUepFkSFALnDZUsf0CeGxJ235DGpMkzfaiSTSLalEXKjGOqUVRGd2CBWlq1J+sOHnVAYsNTdUj3UWwWER1/Iuz3Rxwkfga+YN4zak/0mkiHAOXR0H0jmzUT/rM7rglwCI90v3ogW8HOB739+TJMWy/gAXiZJJ6dwI5rU8QqBN92lSStQPgPc6TEBfM6surN120fC24V4Qu1QSwaFEe8ZAdbL/WOBkUxkJcxPha7WJ/1ZzEkvGkq+b069tL888NwlT0slL20Y97FWLrTgsfELrxQHMSLDhMrOrG4SD9e9et7RcBfkroJYqrK5fdUvAWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57GulC22IzZN7y5jzLF7uN7yeYdZzkWQzGDDgEf53d4=;
 b=fyLwjq9Qf2gm7gyIurcb1gBVWQl+rNXZIT7cl/rhaKQcbKl3HVr2qLGGlJ4tHsBDi6XyvDZ6J5gqjiFp/2wI7UyhOpuA+35kw3d0whHD+vkJ12JrO5jgHbJEq4ifBaB4+BiBwWrjFynbT7oGD0ujjOM5M+pVG2mMRR0xMOl1iSc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB6400.namprd10.prod.outlook.com (2603:10b6:a03:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Fri, 20 Jan
 2023 16:29:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:29:15 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 48/49] mm/mmap: Remove __vma_adjust()
Date:   Fri, 20 Jan 2023 11:26:49 -0500
Message-Id: <20230120162650.984577-49-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0056.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: b672da2e-be34-422d-1cd5-08dafb037874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjW/QVkF1E6nngSblFOpvWdX5o307qtfwWi2xvObxp+8UbHZJbzQV0HqfUUCtfJEiDWPtHUXEWdCPjgqXYVa88NXs25iraxEFxbqgwO4jsTlvw6vKbR/Me2NE6hBEHg1RNgj5DVknnKAoRx588b4BYjXtgzNzoLneh3SbZG2R4K5V8rDi2mFa7zlijBpG/KdxXA6vaWulRC1Mz2DPBanhdEUoP4K+HRStL2gxABf1Htn9HIY71H5rlFq7Doousjojbxq2ukuV8k3BW+iUXdF0Wg7WinQMfwV0qz99y1lqjNvGJ6Y0WrWRUke1GzIc4RjjNj6G/tufzWdZNhyiHSYuVXRMffOR1CeFz3xrDP1wHf+5q/kmI+amptamlK6XlR0qXSgrF1Syb3V7lJwhjnsFmZujEBin1WMnFpE6IIHEgpBmrwQhvH2CY0rU3yi/WxBho/M9EzH8CKhm8CcU9FRB/HFYDCop5eWuFGg2dcmcgbiK0PjHAjgWxnS0fXyUNUTk2aRVjoBbcOxjtel4UduQhZZCyjeef6wpLyGnC8qQ64EPPsputKrYCFezQUK9A6ur6A+CalNBrBk2aJxVriPoltvJ6lx2e/t2tNmhqHQ3L15nUTD6JHSLeq22iOhago5jzOlDTx4qMJ48BBdGIorbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(316002)(54906003)(83380400001)(2616005)(1076003)(2906002)(66476007)(26005)(6512007)(186003)(30864003)(6666004)(107886003)(4326008)(8676002)(66556008)(86362001)(6506007)(36756003)(66946007)(8936002)(6486002)(38100700002)(478600001)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92wnSEbjA8RJ1ej19Sm8z8oGh9J/JLN3c503WTwe3FJnsPbDp9J1Bl2JNrK0?=
 =?us-ascii?Q?h9ZGSu8rSYj5606cU9FaeXSWpe2tMhlsmBoZXpWHasdzYfAEfI+UAI/h/Ppw?=
 =?us-ascii?Q?nSZdiRU6XpyqaDcOu2UJavYnhOot1C53ZV3j6EyEzHRGPol9B/ktMUu+vmDe?=
 =?us-ascii?Q?1Wt4c8p1l9nVUngpKAW925nSjFD5O+mvo6SrBPAj7ZCgn6/u/1EqqrPZxg51?=
 =?us-ascii?Q?whpHOR3LIkxCyKTeIBjhJQgYF2nX32OrK9SkRsBZBLpHVsMm1YwXmM7A1do6?=
 =?us-ascii?Q?0JfMy++vRT8MJFlazSiNvs21bcwGcRp8JBfh9FvNQjytq3KNj2skeFvguoDV?=
 =?us-ascii?Q?GX1Efd6tCUtJ3E9CkJdQm87sHRXMagciRSIzb9qeb5PtqJj3EabStf5gX5lk?=
 =?us-ascii?Q?I1IcKBG0X+E8zq8zXuSUtpD9fz7bxVwzGf/H5m/phN6NdFbbaDI7Zo/aGyjV?=
 =?us-ascii?Q?RQ58NwLc1xIVtoDio8HVAFQxDE6xSjbKiiltA5/XuhHgHZwCzmPcs6zEu7/x?=
 =?us-ascii?Q?EUjHqHYMRyMeCPGOr1zDfxrvS7H2+IkY2EZLbLNvo/SGxytNK53u88rR6Ysg?=
 =?us-ascii?Q?InhQK8MkZzR/7EB6qZY0qqCxGV8XUyRwutmE5D04Uk9RQshIqCF73qOFhjre?=
 =?us-ascii?Q?pDMAlNE0LYpEbAB1lzqwk0ymmyEMFS55B7sgCfDma9ysj2pN6hsE7d0M2U1A?=
 =?us-ascii?Q?7A4MT+bVhM60AYhgip2HVF9/qCrCfUCyV9qgJNUSifzDB0eSiEahvg+SSVRC?=
 =?us-ascii?Q?NSr8aZQ9xYuv2CUODIxZ9H8vyQx+AFP3tWzcuykIhE9m/oQTaC57dEx2uNnq?=
 =?us-ascii?Q?WSL+bbSNB87X4ALDf0oujBsWbiEHgAFtYR8sIlhdgDR9vYsQly3C+vLKjepH?=
 =?us-ascii?Q?SgNFRybLv+wX3sIZ6qpLHel9EN7kwVdQ8ZvEACEhqdko0kkYvKtWLh0eTD0v?=
 =?us-ascii?Q?ZN+aDC9ZORJ2TQgrYcmDNfLf6QuY2ZgOhuoQWZUvvpw3iUaxVyC2En06Ul+M?=
 =?us-ascii?Q?DFk9a5n34SpmAgRdLoxBi/g8CF18rPe6AibxGVMAyowUN7tRIU+gpVEhQ+9w?=
 =?us-ascii?Q?ywi5ZGdM5K9krqYJdYe7XAbZHUiaYzLPAGmurKpHkH28RqIoW6jLTjpqWBUt?=
 =?us-ascii?Q?M449SGhklfYOdju84ZbcNB7JcNUvLuLY6f2DDjjGavvWnozc1VJd8+URKGdW?=
 =?us-ascii?Q?lDbqmIvPIdT3q8kdyZ5nwAPe4eRUAOMUiMDWHrFKVZ8zQJUqzQ+dec9/xCJp?=
 =?us-ascii?Q?/7eZfATIzmWJUmDpdu2P9Zcw1pLKMrqmcpw2RNDWzCLRGgUPDbmcmulPIAVr?=
 =?us-ascii?Q?qOWW/LC1vs4vdF5Ju9qhUWIFs1REc3J5y3pJLkO/gSky2sNSxpo3fYaEj5LA?=
 =?us-ascii?Q?bF/fdQWygevz7u4ycfYumeoHQ7mb478zqZMjUOVEG67Pia468GrSAbl93fRb?=
 =?us-ascii?Q?MwyOFkIZek54A0tP8zPMaHISnsXYl1aZUZBECxlqaCGkH79Ppq4gt/jKqYhH?=
 =?us-ascii?Q?szwsWrHXI6FStFAuB51LwmfLESemF9wgN9yjOFFgaVA8Y21H3DUtjjhxzkrq?=
 =?us-ascii?Q?GgmMBZKeRvLVD6QOvBgh5Ke5BcKaUwawhyjx9HZY8s0p6H9fNfwzgYj5gb+1?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OLX1NakJTPEHsTbvwiE6NicwYYLxVPpA9ds5YgMwG365MqPbDSpDXx1q4EUo+ED0xXGTuuyJuAF6BdRXMRsox8/YtMkrHmS9f5v99HRxozN4GgYI4AVgJZ/qpDqJ0X8q0Gye2rCl9TaciA1Nxk/msn/nzgN/NritySxSsZ8qXyG6QXpsD3cIcuJQe0NL4IIeH3RApxIuIASgytqVohqdrF+WlIwFML3oGZPXmK1+2P/k+w6lu4pHhubtCkSCO1Q9Flz0ou4EZTUsqmYE0jtjbnOf+FFHzLpkLTZOA8tfS2syXqYlYRzHr8C8/JOVT9z6dePwO3oRHKAT55zTtzaXeRb4jsYGsTCQuQQ6EM3w3ZA25tasXCXgzNIHZE7gBEao3+cJl0KxcxKp5xrxCNTSkEfnHT7KwCZoyagtBcGkQOt5rU02ZCqXFwh8dEJ7FTnEfwLv7ia85Yn8d7LY93cCa/yAnbNPf39Ot23zJg3XGePWyvrrr9/iaLeyoi6lgIGQA9xCpe0E4MH0XkAMvP+XDsI7i0mjSGOUC8eDWPlhL36K5KXT6R4x+s98UErz0/rbRP1OfiDTlSx9jpI3VhBCJVDyUwysRzh/eBtjs0S5vGY574ZbHoaliQulNGV1ODKWz6mGP46d/gwxKs15BfiJyBin2k+IKyYrwIUtKWKQfGwwYIs7pMrZB5VlVOtQ7txIPUfYwOsDLMB8oKvtgh3jjY44oytoKQf6je/bBq2sNaBtWx9TBB7Y59urgQycOK0PfpA45XHpd8tkjKyPUiKsPRR48ymIBLsv6m3i72AbOfFhS2wMmfuYIYj6Ornaj0SArFXiYuiGStdyj1MBiBzvB+E6MkDIQvBLPG0hRvAiYSDoNZin4GhTKg02Q73eqLmihmrJGLeZMuCibRkbYJRVCg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b672da2e-be34-422d-1cd5-08dafb037874
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:29:15.3351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eZWSCysSR/PN5jW8hCm4NjHZn0M+gKT1Muo8RbmBZesrdUNYra87g8w0EAn017HhUx9Ghr9U8+iyLX43kKJjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: STFUqhp5J4XmYNJhzx19pFnCpw1_aPHR
X-Proofpoint-ORIG-GUID: STFUqhp5J4XmYNJhzx19pFnCpw1_aPHR
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

Inline the work of __vma_adjust() into vma_merge().  This reduces code
size and has the added benefits of the comments for the cases being
located with the code.

Change the comments referencing vma_adjust() accordingly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 kernel/events/uprobes.c |   2 +-
 mm/filemap.c            |   2 +-
 mm/mmap.c               | 250 ++++++++++++++++------------------------
 mm/rmap.c               |  15 +--
 4 files changed, 107 insertions(+), 162 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 1a3904e0179c..59887c69d54c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1351,7 +1351,7 @@ static int delayed_ref_ctr_inc(struct vm_area_struct *vma)
 }
 
 /*
- * Called from mmap_region/vma_adjust with mm->mmap_lock acquired.
+ * Called from mmap_region/vma_merge with mm->mmap_lock acquired.
  *
  * Currently we ignore all errors and always return 0, the callers
  * can't handle the failure anyway.
diff --git a/mm/filemap.c b/mm/filemap.c
index c915ded191f0..992554c18f1f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -97,7 +97,7 @@
  *    ->i_pages lock		(__sync_single_inode)
  *
  *  ->i_mmap_rwsem
- *    ->anon_vma.lock		(vma_adjust)
+ *    ->anon_vma.lock		(vma_merge)
  *
  *  ->anon_vma.lock
  *    ->page_table_lock or pte_lock	(anon_vma_prepare and various)
diff --git a/mm/mmap.c b/mm/mmap.c
index 5aa048e9ff30..e227b7cd71aa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -743,133 +743,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 }
 
-/*
- * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
- * is already present in an i_mmap tree without adjusting the tree.
- * The following helper function should be used when such adjustments
- * are necessary.  The "insert" vma (if any) is to be inserted
- * before we drop the necessary locks.
- */
-int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	unsigned long start, unsigned long end, pgoff_t pgoff,
-	struct vm_area_struct *expand)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *remove2 = NULL;
-	struct vm_area_struct *remove = NULL;
-	struct vm_area_struct *next = find_vma(mm, vma->vm_end);
-	struct vm_area_struct *orig_vma = vma;
-	struct file *file = vma->vm_file;
-	bool vma_changed = false;
-	long adjust_next = 0;
-	struct vma_prepare vma_prep;
-
-	if (next) {
-		int error = 0;
-
-		if (end >= next->vm_end) {
-			/*
-			 * vma expands, overlapping all the next, and
-			 * perhaps the one after too (mprotect case 6).
-			 * The only other cases that gets here are
-			 * case 1, case 7 and case 8.
-			 */
-			if (next == expand) {
-				/*
-				 * The only case where we don't expand "vma"
-				 * and we expand "next" instead is case 8.
-				 */
-				VM_WARN_ON(end != next->vm_end);
-				/*
-				 * we're removing "vma" and that to do so we
-				 * swapped "vma" and "next".
-				 */
-				VM_WARN_ON(file != next->vm_file);
-				swap(vma, next);
-				remove = next;
-			} else {
-				VM_WARN_ON(expand != vma);
-				/*
-				 * case 1, 6, 7, remove next.
-				 * case 6 also removes the one beyond next
-				 */
-				remove = next;
-				if (end > next->vm_end)
-					remove2 = find_vma(mm, next->vm_end);
-
-				VM_WARN_ON(remove2 != NULL &&
-					   end != remove2->vm_end);
-			}
-
-			/*
-			 * If next doesn't have anon_vma, import from vma after
-			 * next, if the vma overlaps with it.
-			 */
-			if (remove != NULL && !next->anon_vma)
-				error = dup_anon_vma(vma, remove2);
-			else
-				error = dup_anon_vma(vma, remove);
-
-		} else if (end > next->vm_start) {
-			/*
-			 * vma expands, overlapping part of the next:
-			 * mprotect case 5 shifting the boundary up.
-			 */
-			adjust_next = (end - next->vm_start);
-			VM_WARN_ON(expand != vma);
-			error = dup_anon_vma(vma, next);
-		} else if (end < vma->vm_end) {
-			/*
-			 * vma shrinks, and !insert tells it's not
-			 * split_vma inserting another: so it must be
-			 * mprotect case 4 shifting the boundary down.
-			 */
-			adjust_next = -(vma->vm_end - end);
-			VM_WARN_ON(expand != next);
-			error = dup_anon_vma(next, vma);
-		}
-		if (error)
-			return error;
-	}
-
-	if (vma_iter_prealloc(vmi))
-		return -ENOMEM;
-
-	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
-
-	init_multi_vma_prep(&vma_prep, vma, adjust_next ? next : NULL, remove,
-			    remove2);
-	VM_WARN_ON(vma_prep.anon_vma && adjust_next && next->anon_vma &&
-		   vma_prep.anon_vma != next->anon_vma);
-
-	vma_prepare(&vma_prep);
-
-	if (start < vma->vm_start || end > vma->vm_end)
-		vma_changed = true;
-
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
-
-	if (vma_changed)
-		vma_iter_store(vmi, vma);
-
-	if (adjust_next) {
-		next->vm_start += adjust_next;
-		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
-		if (adjust_next < 0) {
-			WARN_ON_ONCE(vma_changed);
-			vma_iter_store(vmi, next);
-		}
-	}
-
-	vma_complete(&vma_prep, vmi, mm);
-	vma_iter_free(vmi);
-	validate_mm(mm);
-
-	return 0;
-}
-
 /*
  * If the vma has a ->close operation then the driver probably needs to release
  * per-vma resources, so we don't attempt to merge those.
@@ -996,7 +869,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  * It is important for case 8 that the vma NNNN overlapping the
  * region AAAA is never going to extended over XXXX. Instead XXXX must
  * be extended in region AAAA and NNNN must be removed. This way in
- * all cases where vma_merge succeeds, the moment vma_adjust drops the
+ * all cases where vma_merge succeeds, the moment vma_merge drops the
  * rmap_locks, the properties of the merged vma will be already
  * correct for the whole merged range. Some of those properties like
  * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
@@ -1006,6 +879,12 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  * or other rmap walkers (if working on addresses beyond the "end"
  * parameter) may establish ptes with the wrong permissions of NNNN
  * instead of the right permissions of XXXX.
+ *
+ * In the code below:
+ * PPPP is represented by *prev
+ * NNNN is represented by *mid (and possibly equal to *next)
+ * XXXX is represented by *next or not represented at all.
+ * AAAA is not represented - it will be merged or the function will return NULL
  */
 struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			struct vm_area_struct *prev, unsigned long addr,
@@ -1016,11 +895,19 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			struct anon_vma_name *anon_name)
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
+	pgoff_t vma_pgoff;
 	struct vm_area_struct *mid, *next, *res = NULL;
+	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	int err = -1;
 	bool merge_prev = false;
 	bool merge_next = false;
+	bool vma_expanded = false;
+	struct vma_prepare vp;
+	unsigned long vma_end = end;
+	long adj_next = 0;
+	unsigned long vma_start = addr;
 
+	validate_mm(mm);
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1038,13 +925,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	VM_WARN_ON(mid && end > mid->vm_end);
 	VM_WARN_ON(addr >= end);
 
-	/* Can we merge the predecessor? */
-	if (prev && prev->vm_end == addr &&
-			mpol_equal(vma_policy(prev), policy) &&
-			can_vma_merge_after(prev, vm_flags,
-					    anon_vma, file, pgoff,
-					    vm_userfaultfd_ctx, anon_name)) {
-		merge_prev = true;
+	if (prev) {
+		res = prev;
+		vma = prev;
+		vma_start = prev->vm_start;
+		vma_pgoff = prev->vm_pgoff;
+		/* Can we merge the predecessor? */
+		if (prev->vm_end == addr && mpol_equal(vma_policy(prev), policy)
+		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
+				   pgoff, vm_userfaultfd_ctx, anon_name)) {
+			merge_prev = true;
+		}
 	}
 	/* Can we merge the successor? */
 	if (next && end == next->vm_start &&
@@ -1054,32 +945,85 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 					     vm_userfaultfd_ctx, anon_name)) {
 		merge_next = true;
 	}
+
+	remove = remove2 = adjust = NULL;
 	/* Can we merge both the predecessor and the successor? */
 	if (merge_prev && merge_next &&
-			is_mergeable_anon_vma(prev->anon_vma,
-				next->anon_vma, NULL)) {	 /* cases 1, 6 */
-		err = __vma_adjust(vmi, prev, prev->vm_start,
-					next->vm_end, prev->vm_pgoff, prev);
-		res = prev;
-	} else if (merge_prev) {			/* cases 2, 5, 7 */
-		err = __vma_adjust(vmi, prev, prev->vm_start,
-					end, prev->vm_pgoff, prev);
-		res = prev;
+	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
+		remove = mid;				/* case 1 */
+		vma_end = next->vm_end;
+		err = dup_anon_vma(res, remove);
+		if (mid != next) {			/* case 6 */
+			remove2 = next;
+			if (!remove->anon_vma)
+				err = dup_anon_vma(res, remove2);
+		}
+	} else if (merge_prev) {
+		err = 0;				/* case 2 */
+		if (mid && end > mid->vm_start) {
+			err = dup_anon_vma(res, mid);
+			if (end == mid->vm_end) {	/* case 7 */
+				remove = mid;
+			} else {			/* case 5 */
+				adjust = mid;
+				adj_next = (end - mid->vm_start);
+			}
+		}
 	} else if (merge_next) {
-		if (prev && addr < prev->vm_end)	/* case 4 */
-			err = __vma_adjust(vmi, prev, prev->vm_start,
-					addr, prev->vm_pgoff, next);
-		else					/* cases 3, 8 */
-			err = __vma_adjust(vmi, mid, addr, next->vm_end,
-					next->vm_pgoff - pglen, next);
 		res = next;
+		if (prev && addr < prev->vm_end) {	/* case 4 */
+			vma_end = addr;
+			adjust = mid;
+			adj_next = -(vma->vm_end - addr);
+			err = dup_anon_vma(res, adjust);
+		} else {
+			vma = next;			/* case 3 */
+			vma_start = addr;
+			vma_end = next->vm_end;
+			vma_pgoff = next->vm_pgoff;
+			err = 0;
+			if (mid != next) {		/* case 8 */
+				remove = mid;
+				err = dup_anon_vma(res, remove);
+			}
+		}
 	}
 
-	/*
-	 * Cannot merge with predecessor or successor or error in __vma_adjust?
-	 */
+	/* Cannot merge or error in anon_vma clone */
 	if (err)
 		return NULL;
+
+	if (vma_iter_prealloc(vmi))
+		return NULL;
+
+	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_next);
+	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
+	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
+		   vp.anon_vma != adjust->anon_vma);
+
+	vma_prepare(&vp);
+	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
+		vma_expanded = true;
+
+	vma->vm_start = vma_start;
+	vma->vm_end = vma_end;
+	vma->vm_pgoff = vma_pgoff;
+
+	if (vma_expanded)
+		vma_iter_store(vmi, vma);
+
+	if (adj_next) {
+		adjust->vm_start += adj_next;
+		adjust->vm_pgoff += adj_next >> PAGE_SHIFT;
+		if (adj_next < 0) {
+			WARN_ON(vma_expanded);
+			vma_iter_store(vmi, next);
+		}
+	}
+
+	vma_complete(&vp, vmi, mm);
+	vma_iter_free(vmi);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
 
 	if (res)
diff --git a/mm/rmap.c b/mm/rmap.c
index 948ca17a96ad..f6176c09fcc7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -262,11 +262,12 @@ static inline void unlock_anon_vma_root(struct anon_vma *root)
  * Attach the anon_vmas from src to dst.
  * Returns 0 on success, -ENOMEM on failure.
  *
- * anon_vma_clone() is called by __vma_adjust(), __split_vma(), copy_vma() and
- * anon_vma_fork(). The first three want an exact copy of src, while the last
- * one, anon_vma_fork(), may try to reuse an existing anon_vma to prevent
- * endless growth of anon_vma. Since dst->anon_vma is set to NULL before call,
- * we can identify this case by checking (!dst->anon_vma && src->anon_vma).
+ * anon_vma_clone() is called by vma_expand(), vma_merge(), __split_vma(),
+ * copy_vma() and anon_vma_fork(). The first four want an exact copy of src,
+ * while the last one, anon_vma_fork(), may try to reuse an existing anon_vma to
+ * prevent endless growth of anon_vma. Since dst->anon_vma is set to NULL before
+ * call, we can identify this case by checking (!dst->anon_vma &&
+ * src->anon_vma).
  *
  * If (!dst->anon_vma && src->anon_vma) is true, this function tries to find
  * and reuse existing anon_vma which has no vmas and only one child anon_vma.
@@ -1253,7 +1254,7 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
 
 	if (likely(!folio_test_ksm(folio))) {
-		/* address might be in next vma when migration races vma_adjust */
+		/* address might be in next vma when migration races vma_merge */
 		if (first)
 			__page_set_anon_rmap(folio, page, vma, address,
 					     !!(flags & RMAP_EXCLUSIVE));
@@ -2538,7 +2539,7 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(!anon_vma);
-	/* address might be in next vma when migration races vma_adjust */
+	/* address might be in next vma when migration races vma_merge */
 	first = atomic_inc_and_test(&folio->_entire_mapcount);
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
-- 
2.35.1

