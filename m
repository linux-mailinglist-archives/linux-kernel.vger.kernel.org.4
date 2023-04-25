Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E286EE3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjDYOMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbjDYOMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:12:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F05513FBE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:11:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDibUa006082;
        Tue, 25 Apr 2023 14:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=IDIXK2KxMTW9l24QIc5A5LUq1e1m5wDTil92Q6ZsfZI=;
 b=F2/E3rgIlRiQizG4c21HeLETFab/WJ+eGJ8MVfREY4zfZziejs51CgDZZMEsxsJV5weN
 Vl84MmXnviDckg6+eaPY2scxJdReAbfB9771Km5GWQ6kI19BWUVbKQTBm4vqd4SuxAbC
 KV6oEnB9QAkQetmpUEw+hlpb6qsMbP7IMdzbqKiIjq7rADIjRYLxmY/9i0yowT1naIDj
 a+VmNr7AkdtS+gWtm+o9ibK9HWbKySrsLy7bXSi5pcdIv0MyIq20gRrU5Dg5OJ05O7t/
 KAX3Ssp1LHAhzU8BdcZ5pbtSOi1mYNSc8BYBOLcegtb/Z4Ni4MRq/bkJ52buGZ8RUjXS Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q4661wgmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDwhPU024866;
        Tue, 25 Apr 2023 14:11:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461crc9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amKVwWdFUFob1I2Iyqgj9RRw8l9fNDcBVcC4Obei0iwpIQ5tVml8I+SYfr3dYiE/fEd9dEQd4pUcaBxr2VTFXsMvfjRfFsjP7wGNkH2+8DgKeV9uukYrOefCYG2p7ToOKfRldmDWl1OGwesC8qkyCWxu69WIGe/bpzJMnDpBn97S12UJrmPmdSurIdGPN+NdOe93wtFzM99bgqH1zvRt3ROjDq2f5UdOhRSJu9tfc2ZneQuhNQoAUXl2iLeVs++3qeBaykS8P8MqGGUbK5M95ZGnFXKSxYqxtlNpyGcxiJXG/cHLphcXFM3g9wKZUgoYRdv+9lesarxy5/rN2KGRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDIXK2KxMTW9l24QIc5A5LUq1e1m5wDTil92Q6ZsfZI=;
 b=K3bearJhH60opWe0a+9/PWPUuSuJ6MGULNlJNVgZi1DKJMZfwRE3XW8KtL+q/9us3YTBmDy20drFNioepqcI3Vi3SwklisdH1xk4LlGtyoZI/rDJDocOQgLG0biSKtm3U3IXfCzRD1C17xBLRWftlZus1yWKr9DwmLmkt5Di71LoQPuEDFXOXtmSy60dfzz2pV75F1McJuE1itGhLyXorKTDVfKbXZcL/vF+tjtvzolMT/SBDT+3VA4lmx1odCBRL1NGlHjYqeJq2PXQWiiVHf1KMsLSR101gzk/t4kJRFINDR11GGwIHZ7i9L3lLYGCej+hu2PLvOtSfsFPuM84/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDIXK2KxMTW9l24QIc5A5LUq1e1m5wDTil92Q6ZsfZI=;
 b=AAV7muwAByXEyF1BmwFgjV/rqxe9ZcqlR0WA+71RcOx4ePFqHJsqB5mKixDY9+mynE9mhkUX9AJbkAnGwzt/c5p26WbSdQqeyKfYCIM2Li2rJyEWg6dBIUxjsnb7eb/XC/OUK1N+upZI4RdDHIObcdzLrRcX840nxMDOdd9VOJk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:59 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 17/34] mm: Update validate_mm() to use vma iterator
Date:   Tue, 25 Apr 2023 10:09:38 -0400
Message-Id: <20230425140955.3834476-18-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f99d61-8805-44f6-c0c2-08db4596e544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zN50abmjqPFUsd1eECoIUtesi08AqXyrHJjUdLbbp2b7nm5uDZmb4te90NF8ADPGu1ouftjhSxVph0RfGHkDFGuOdP4Hu8JSYCBrlYuTiAYCI7da8P3HnQNtIGRufkJs3waNe+CxKxFRzCUlzcpi5tZDJz8lbDftURo+VW9X4PtHrn02iGPTHytTiqz1zH041pYWKCqStCcE7ZIZ9a9hhfLsuLSTPz5Ijv72fYAzRThOGAbh1KaCdwRCPgQ9glda5QxDWs0DluJNvv4NHyRBspjmlpdU+z9v0ixM08oaNFv0j0vZm/07CdaFFJ2OjgucFUXmdDWhq7LmQJbZ2Zv+859lrcYCDDjcM7bfi9amcOWo1RgtTpGWCihyuhGq7MVfeNAwoz4bLNn+mRg/oTyqqyDN55E8yW6HbuCDYTazhAx9eEZgFnqgtR1ibAvenBmSlXOjm+0CuO1Ovv6TNos1ZD0sW8zFFEkIbm9xT7Cw3IMf81/Ld+5ERGPwRpF9eW8cv9aOltK6x7tlxmTjzi413hhlb1H7GkQgTMGHnqDElY+CO0IY1LoBU5w9/wZA8OFT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(36756003)(107886003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(38100700002)(15650500001)(8676002)(41300700001)(5660300002)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?396eJHgzi+KmyAzKCK2IaxSdWj9PE251K3Xby7Y9bkRRTJcWQVePTgjCDw2h?=
 =?us-ascii?Q?LUxPSibvv/y32ua4tAyVme1DhZf82+XbSuPh/Dgo2r00gWeHoVb1MeyoNItz?=
 =?us-ascii?Q?lSRrpYgnM7Ap7+KSw40NO2W4icdDovNWwULvii5rpg0aLnhfgd6/bOqfVQZ+?=
 =?us-ascii?Q?FZsspISQRb/eK4fb8VKacgMQp/r0xhBN8KXIH5tztdNjrBlEREHVViTleWHd?=
 =?us-ascii?Q?OU1nzYJbHyWfvU7tx+XcwLSweGs02tn7pq8pocBK5CVB9ex8TNoocWamJxXa?=
 =?us-ascii?Q?YFAUhKsR39hHF1+SxNsF6QZ+IRMNO1eFBcFYsSo0nJltqJnoxMK1I8kso8mX?=
 =?us-ascii?Q?Ko6sYqDYiSAVqdkcU9Sm3/bSJrybqJR+viyaN6uc8ZGP8LsGTS8BKrZ12a/6?=
 =?us-ascii?Q?KC6uwgR4gRxpda5PtmBAe3WcMwCLuyq7uqBRI1374dhfHomCgBsYcrGNbfQ9?=
 =?us-ascii?Q?pdNAFr8N2oxGlBStsMTeDSDLPRIpF50DMLXDu50WCBzxjiMxCOTl5zDZmsR4?=
 =?us-ascii?Q?FKLAiAcvYCfe1jpeARFK4B6NKyJT5KZpCbIJsNF5YFCaPUJK1CEig6a5sDFc?=
 =?us-ascii?Q?/hsFSRBi/dVPIo9GWQAz5GLDaU0ckMyHFKw4HWwP7+z8Z2YDqs3pTXuQFP7M?=
 =?us-ascii?Q?o8mN2GrzbsIFhOSdzgg6pXOcN5BH2Eplruf+KPOTneoOoeuTOnWaRtUF/TPZ?=
 =?us-ascii?Q?MR5Bh/VEP1fQaedJ1k4xWSrXx8/1mzVIUeJHFVnC6wP1dMTvCuZnQI55N0sZ?=
 =?us-ascii?Q?DxhfcJj9+T7ebH+wFcovSB+jxtCy7JlTTsbf/z5JkVKN9VHBLK/mQGRJgq+n?=
 =?us-ascii?Q?memLIhPO8iCQawiJdWNHM+A4PAkFY6OyPcZLZbwP3RGb9x5OYA8KqWVouU4y?=
 =?us-ascii?Q?fOObQEJumnxfQgWArG1WSFeCyjZ4pRcJ4JOsNHGUWo17SZGpdfyRgjZNutlZ?=
 =?us-ascii?Q?iGKVdkow3caKNLy1JGCkewdoflnHa+B53OIs4d4kyALTx5grdEEy3MMW3r4S?=
 =?us-ascii?Q?2Pt+aOGHJnXrgIsUkSsnQ31t3BbqIB5Bkj4G4Mcmvm0SWdDHDPrB1dPPd4TK?=
 =?us-ascii?Q?ndwhz1Hb2cB6venn6VKeLfogNnhhg2HMH+ylW1aoCr8/e4/46WzGrgGK/KDy?=
 =?us-ascii?Q?Czgq/Zm5zl+Vtrsm5fgyB2Omj6nH9bJVUewmIy3xFzc2WndO9ZEvNqAL3uOF?=
 =?us-ascii?Q?WZQrymnr1QnB95vyjbeCNOzW6UIdYOByX2cLWx17oHhjPv5VBfRWCgslnY+r?=
 =?us-ascii?Q?LgVHg8qd8uZKqfIPKeVZi/u09n9FkrhbhAxpPjDZ3QDCNyhEqjFnOBDGxwVJ?=
 =?us-ascii?Q?f2V7wZZahBdXmxrNPY6UKmWyiOttwzp6rU9Yyjhxg1js2fuvQhZSuspebxar?=
 =?us-ascii?Q?HzIBvEkGRmQBFPNDOHFQdZ1jPqSmYSd6PVBSvd66UMScl8cD/Me07RE6LBdU?=
 =?us-ascii?Q?vBYIoT0aC54w0ClAvcOE8CpiY1u8icx8+QiF5ktLPpt+hirWVv1aAAONhw5q?=
 =?us-ascii?Q?UBtkEU/sORSZyqmkqW2ACc2wkyWIP13dF/7usIapmIvc40X1lgEbpsrCroUL?=
 =?us-ascii?Q?lWhstl06wKPbNIrIr2v9UGfbBR4e5JGPgu0/sIGRGtEDZ5dPiWXTyGbHm0/T?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y0ko3KTCyT2dsAvfRYz7jsEf5R1d3jp8AzPib0Ot3XU9V4e92k+VSUl1nzwoqeHnZJssrqBJnxCFKD8CV+NKK1Fr9T+N8CbmiuXo4sjEtH9P+O6zq2hfoYAZ7sA+CqMyv5OoIeu3YUTMpXQMMInqh6L+c/rMZJODjh53x7vnSHCiZ9EbRYZCMom757ME2jjOzvPvP5srW7/Wgy8Qm0y4XJYoec9p4QjxO77cyJxPD0+bOZ/v7Wfgtt/XoZys6P29TGhGaz1hH4368cg1fGpR7jemjilvKwz5OSnDAn8i2lzM6f1vnsWl2L2bnNU2XHMiS9/L4KFD/MGhhEYZdhiyhmrID1n+HoL1rHh+DKTrHmOJDYJuK7IkaafJ6Q8H/35YyLg1NU/yqYtDgjZ0a7jUzXiBjK4Idn+m+3P8jJaCpF8Dt5Kd5ASBdIqF3678jD3RlT/J02o93q7axzj69z/YVoIOpmkHBoW/YmCNwwtbQ/SE7izoRrnMv8b8SRJOrL+1dwghgtb8CSa75XOELsl6Aa6nMlDMaFAbaJeA49CKjy5oC09CzeVNe94A+nd+rO1qQFckprYEMUTaInzdQcrikb4xolOloKrCrFAkrM81lHDgNsdBd1a3/ICafJm0a79xb5DgJS3asKrGiq1a8yPGnrk7vTkxvSYbJtnRO084gxiwu1KrmDvKZ40Q2MNim8/cKYn45fFjD0jKE5kvY0Ymoc/oXZfT56cIo0HqzkeamLOTKhE6/KjrlhuPp0Dj0hZtrjxWZ44o6mU7FdnyenhYX+EOQ0nhgPSo7cAfjUby1doXHav51QDYW3WJcOeebRHFCHKeFH+AzlkIFlChjIG8mja6QE2YBvUPImNNwq7b6W7ipJqOVDCitF8Jog4fSc4SSKloGgCEwUu2qnupf4wBdw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f99d61-8805-44f6-c0c2-08db4596e544
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:59.8182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdjlA5LuokpkWLJQXJ11XDaSCPQcDQAYptHkI4yuxALdVWXJIYMJbYZ/Au+q4u4Xy/hsMkc6D81NKpqGTb7HNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-ORIG-GUID: 1NM28iUJRgNdxufKwc_s7uWBcb8dcIq5
X-Proofpoint-GUID: 1NM28iUJRgNdxufKwc_s7uWBcb8dcIq5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the vma iterator in the validation code and combine the code to
check the maple tree into the main validate_mm() function.

Introduce a new function vma_iter_dump_tree() to dump the maple tree in
hex layout.

Replace all calls to validate_mm_mt() with validate_mm().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mmdebug.h |  14 ++++++
 mm/debug.c              |   9 ++++
 mm/internal.h           |   3 +-
 mm/mmap.c               | 101 ++++++++++++++++------------------------
 4 files changed, 66 insertions(+), 61 deletions(-)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index b8728d11c9490..7c3e7b0b0e8fd 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -8,10 +8,12 @@
 struct page;
 struct vm_area_struct;
 struct mm_struct;
+struct vma_iterator;
 
 void dump_page(struct page *page, const char *reason);
 void dump_vma(const struct vm_area_struct *vma);
 void dump_mm(const struct mm_struct *mm);
+void vma_iter_dump_tree(const struct vma_iterator *vmi);
 
 #ifdef CONFIG_DEBUG_VM
 #define VM_BUG_ON(cond) BUG_ON(cond)
@@ -74,6 +76,17 @@ void dump_mm(const struct mm_struct *mm);
 	}								\
 	unlikely(__ret_warn_once);					\
 })
+#define VM_WARN_ON_ONCE_MM(cond, mm)		({			\
+	static bool __section(".data.once") __warned;			\
+	int __ret_warn_once = !!(cond);					\
+									\
+	if (unlikely(__ret_warn_once && !__warned)) {			\
+		dump_mm(mm);						\
+		__warned = true;					\
+		WARN_ON(1);						\
+	}								\
+	unlikely(__ret_warn_once);					\
+})
 
 #define VM_WARN_ON(cond) (void)WARN_ON(cond)
 #define VM_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
@@ -90,6 +103,7 @@ void dump_mm(const struct mm_struct *mm);
 #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_FOLIO(cond, folio)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_ONCE_FOLIO(cond, folio)  BUILD_BUG_ON_INVALID(cond)
+#define VM_WARN_ON_ONCE_MM(cond, mm)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
diff --git a/mm/debug.c b/mm/debug.c
index c7b228097bd98..ee533a5ceb79d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -268,4 +268,13 @@ void page_init_poison(struct page *page, size_t size)
 	if (page_init_poisoning)
 		memset(page, PAGE_POISON_PATTERN, size);
 }
+
+void vma_iter_dump_tree(const struct vma_iterator *vmi)
+{
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	mas_dump(&vmi->mas);
+	mt_dump(vmi->mas.tree, mt_dump_hex);
+#endif	/* CONFIG_DEBUG_VM_MAPLE_TREE */
+}
+
 #endif		/* CONFIG_DEBUG_VM */
diff --git a/mm/internal.h b/mm/internal.h
index 4c195920f5656..8d1a8bd001247 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1051,13 +1051,14 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree, mt_dump_hex);
+		vma_iter_dump_tree(vmi);
 	}
 	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
 		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
 		mt_dump(vmi->mas.tree, mt_dump_hex);
+		vma_iter_dump_tree(vmi);
 	}
 #endif
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 1554f90d497ef..d34a41791ddb2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -299,62 +299,44 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return origbrk;
 }
 
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-extern void mt_validate(struct maple_tree *mt);
-extern void mt_dump(const struct maple_tree *mt, enum mt_dump_format fmt);
-
-/* Validate the maple tree */
-static void validate_mm_mt(struct mm_struct *mm)
-{
-	struct maple_tree *mt = &mm->mm_mt;
-	struct vm_area_struct *vma_mt;
-
-	MA_STATE(mas, mt, 0, 0);
-
-	mt_validate(&mm->mm_mt);
-	mas_for_each(&mas, vma_mt, ULONG_MAX) {
-		if ((vma_mt->vm_start != mas.index) ||
-		    (vma_mt->vm_end - 1 != mas.last)) {
-			pr_emerg("issue in %s\n", current->comm);
-			dump_stack();
-			dump_vma(vma_mt);
-			pr_emerg("mt piv: %p %lu - %lu\n", vma_mt,
-				 mas.index, mas.last);
-			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
-				 vma_mt->vm_start, vma_mt->vm_end);
-
-			mt_dump(mas.tree, mt_dump_hex);
-			if (vma_mt->vm_end != mas.last + 1) {
-				pr_err("vma: %p vma_mt %lu-%lu\tmt %lu-%lu\n",
-						mm, vma_mt->vm_start, vma_mt->vm_end,
-						mas.index, mas.last);
-				mt_dump(mas.tree, mt_dump_hex);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_end != mas.last + 1, mm);
-			if (vma_mt->vm_start != mas.index) {
-				pr_err("vma: %p vma_mt %p %lu - %lu doesn't match\n",
-						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
-				mt_dump(mas.tree, mt_dump_hex);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_start != mas.index, mm);
-		}
-	}
-}
-
+#if defined(CONFIG_DEBUG_VM)
 static void validate_mm(struct mm_struct *mm)
 {
 	int bug = 0;
 	int i = 0;
 	struct vm_area_struct *vma;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 
-	validate_mm_mt(mm);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	mt_validate(&mm->mm_mt);
+#endif
 
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma = vma->anon_vma;
 		struct anon_vma_chain *avc;
+#endif
+		unsigned long vmi_start, vmi_end;
+		bool warn = 0;
+
+		vmi_start = vma_iter_addr(&vmi);
+		vmi_end = vma_iter_end(&vmi);
+		if (VM_WARN_ON_ONCE_MM(vma->vm_end != vmi_end, mm))
+			warn = 1;
+
+		if (VM_WARN_ON_ONCE_MM(vma->vm_start != vmi_start, mm))
+			warn = 1;
+
+		if (warn) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+			dump_vma(vma);
+			pr_emerg("tree range: %px start %lx end %lx\n", vma,
+				 vmi_start, vmi_end - 1);
+			vma_iter_dump_tree(&vmi);
+		}
 
+#ifdef CONFIG_DEBUG_VM_RB
 		if (anon_vma) {
 			anon_vma_lock_read(anon_vma);
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
@@ -365,16 +347,15 @@ static void validate_mm(struct mm_struct *mm)
 		i++;
 	}
 	if (i != mm->map_count) {
-		pr_emerg("map_count %d mas_for_each %d\n", mm->map_count, i);
+		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
 		bug = 1;
 	}
 	VM_BUG_ON_MM(bug, mm);
 }
 
-#else /* !CONFIG_DEBUG_VM_MAPLE_TREE */
-#define validate_mm_mt(root) do { } while (0)
+#else /* !CONFIG_DEBUG_VM */
 #define validate_mm(mm) do { } while (0)
-#endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
+#endif /* CONFIG_DEBUG_VM */
 
 /*
  * vma has some anon_vma assigned, and is already inserted on that
@@ -2234,7 +2215,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vm_area_struct *new;
 	int err;
 
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	WARN_ON(vma->vm_start >= addr);
 	WARN_ON(vma->vm_end <= addr);
@@ -2292,7 +2273,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 out_free_mpol:
@@ -2301,7 +2282,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_free(vmi);
 out_free_vma:
 	vm_area_free(new);
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return err;
 }
 
@@ -2936,7 +2917,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	arch_unmap(mm, start, end);
 	ret = do_vmi_align_munmap(vmi, vma, mm, start, end, uf, downgrade);
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return ret;
 }
 
@@ -2958,7 +2939,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct mm_struct *mm = current->mm;
 	struct vma_prepare vp;
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
@@ -3199,7 +3180,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	bool faulted_in_anon_vma = true;
 	VMA_ITERATOR(vmi, mm, addr);
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3258,7 +3239,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			goto out_vma_link;
 		*need_rmap_locks = false;
 	}
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return new_vma;
 
 out_vma_link:
@@ -3274,7 +3255,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return NULL;
 }
 
@@ -3411,7 +3392,7 @@ static struct vm_area_struct *__install_special_mapping(
 	int ret;
 	struct vm_area_struct *vma;
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	vma = vm_area_alloc(mm);
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3434,12 +3415,12 @@ static struct vm_area_struct *__install_special_mapping(
 
 	perf_event_mmap(vma);
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return vma;
 
 out:
 	vm_area_free(vma);
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return ERR_PTR(ret);
 }
 
-- 
2.39.2

