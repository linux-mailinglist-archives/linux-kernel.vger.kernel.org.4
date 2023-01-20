Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F48675E02
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjATT1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:27:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3D6D0D9F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:26:41 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGE89v024778;
        Fri, 20 Jan 2023 16:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=xC3mu4AKsppqbyDSCw58mvfzh8IAlVWOVoZ5aweJCiA=;
 b=zMVvl+6K/rTLeU7dmJtAyWFK+ltz0cAU/sPpg18S0y58UZjSZ3p2iQo17IJ3ABiNPome
 j0ZwY4jAFSWOdtw8yS/ZaCUyuieFWzGMb0BKGlLBiKhIMKwv2N98/NtPS2qinIfSlKW4
 uuKMj/HEfTUdiXWKLOmjEPoeE9R9lVZoo1b9nX0rTr/qLAOhMqKmN7mUG2czIUoILZRm
 FBX/ON78LfoqAZvsJ6qC99bMV6TKfAf9t2HN20tI1ziNtpDhWs6msC+BBnDVn9fxNr6c
 RmyWeYYWbslBUzTT1SrWYXWk3VdACHhWupAYndcj0nq2vJLFRZQYP3RxyTsTGZTxKpUB zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k0154bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGNJar027896;
        Fri, 20 Jan 2023 16:27:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qud91fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2kCteIhm/+5Y7z72WFN4NaENkG0pxKHdemTWVTpYgWQ0UhpLZ1Riajv1NXYtjebQ7fc2+r2eaeRJqC9IJnFugioWLn29urH6PfiEigei5q0RVUyop6qaG4RImz+w9/lj5nZCPrhwjQO6Yvr9bXsQMuvSESMQr9EncFvfI1c3EuLBHLkTUWjQ55bdARjHR+/3DQGnWDnoecCJFPcsdqqmt5dppjs+3E6oI7ENDIPflHVqWgHfQxMPEizybkAi1tE1B6UUoxpJNPDHBX+DPd0WcWc2J8cSK3WfekChM3C/otSs+w57bysx5TQiu7DjVpV94vkkDdowiZ1frMcPo+eRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xC3mu4AKsppqbyDSCw58mvfzh8IAlVWOVoZ5aweJCiA=;
 b=nCee1KXpLIolb4WsqLwCHkBppctLy0o4EqFsQDtQGVPK7BLn5j8Zzbp7eIDR2rrHEIn/vspslGeyKu/73CaGe3a50bLGtCyHMDdoPrM0cXV2e9wUTZh4g8F24zCY0BUe6ObDZkEAcRSb1ve6+0Paot0NZ4WvySoLPfCsSe+uPj5UN9B/vS+bYObUmQxtXK7gHO/sJMBJc0hjXElGbMHu8MS1CGVG6mPlftlMS7bKuOnxMgIDEEKdlDLSSQNbAEsDK9h/E7bSh/5KgWHPTOEBCB+f1lZzL+Wkigc6KOZIa29yy82DqgfWNjKoL6X946WWCf6oYCa+KsdA9KGN1IN1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC3mu4AKsppqbyDSCw58mvfzh8IAlVWOVoZ5aweJCiA=;
 b=HhDZiEVDo3b8n5A9nWY4n7EpdK5HmUiOBSCAYdUmDYOsoqvD+JI9QLepugS8bWAoiSgugYFucBSyGx2WL4PJ+T+3s8wm0smIR7CB+OFnmefT8Pv13wP7NJX/chjxMOlZcC5d03JAyBV4mPeonvP6vaFWVQPqDw5BG96YXjXCVYo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:56 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 18/49] mlock: Convert mlock to vma iterator
Date:   Fri, 20 Jan 2023 11:26:19 -0500
Message-Id: <20230120162650.984577-19-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb355af-a16a-4163-4b13-08dafb0349b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ObCuBKlSkW+zFiCh80A7BZfHeFHIFFzRdOT/qXg+2oAi5CZBmnjQX8SV/jOxbZicyBkOrAGc9trIHvxwrdOJe8zcCjCzJfHN95axqvSj+e8waNRYWnOSUoUFNsAmIEoXMzBzLwcAf6GK0XAbozlFivH1NBE4XEGXtX2aszeVlAc0Qt4EtiBK9dZG+w8HqU3fdytLNulaznK2bmBBm7l0OY6Of6PDjpJnlHBSobdmIQrgL+OrgwnzcklIjpttftXJ8wOPaTr7nIYWPnpLBUtqSojpwX3GLHtBWSYo4wwGzrAWMXhcGbEd4eqv7K0iqdskzzv/OksBtLY/bP9iBCEWqtirzSkCfJl1bvWk8S37DavsknHi3Ik1JolmLg/vnP/s3p/IDc5U2c0iyYxB72wYdM4G6n33MgP2PysW0mm0F1NBQnrFB7OWzgYoLiho0PZSWMH/fxARBMR0UoR1A02F9tXv9OSD+g+sDVAwArvFJ/Ez6xl/yUpoomC5pIbv9BYdSqrdbsuD4HLTy0NA6c3kQbsqqj60gV8xQf8dyUKnAZ5TujaU5rxUYvlorhaKI7WGfRVdpm0/dUFOicOlJVVIBVf8ZsZJ/rIb+hGegFCkRo6wVIrYu7HIVC0hilYDTpTcrc6l9xv4SgVA68PHQ8IJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2WpRS1GxRYpeeRkj4PrKU3kehHlF4dUO90U2QLWN+42p9IEZgnK4G0lOam95?=
 =?us-ascii?Q?fPh4Imcc1o1ldavUer9xA/Oia0r6OYmAQGzR8NGRRDODw8CKuyNvjKCUsRJl?=
 =?us-ascii?Q?mCLYdDGBNilfnBsZIFOwX7WkRwgo1JwrBgPKHn6diNCsGxYPFWvVnBRNO81T?=
 =?us-ascii?Q?n4zofBCmMUCDZvrjSf5/f81HO6riWTB0AaPEZao6CMtHJB1NOMROg4jyWM7X?=
 =?us-ascii?Q?9OWRXpiFM6XEx0qfwQWnyFhKw31ESfJWK/suzBYBupYDHuhjDTn5wT6VMaVC?=
 =?us-ascii?Q?CailnILko6YrYMWSVUS/l8meN52sLRJbJXDqyXbvAulcy4wjIxvxT0fkBYVi?=
 =?us-ascii?Q?XTVpPxwDQNzp9jijlaibVMfRNj6/ENm1alLoC2umIV3WeUOGmD/4twu22Vvc?=
 =?us-ascii?Q?wq8VKLNc90An1DoCPkpAsp+GSD+QeaJSjb7pPuTg2hlZFIokowd2uWsL+Hhl?=
 =?us-ascii?Q?gM3cQCitGJ68HhSWifSCWzaoVOaz9DJlksq7hL7aNbFUAf965DSGNKTjT2f5?=
 =?us-ascii?Q?bWMu6XtNQGnjy7/MBgi9UwgW64QKQX/HExgopzDpMb4WYS+Dnu71U1S2sSDC?=
 =?us-ascii?Q?909fasweq4iHmAFKBWhZPmAUl/NRVORXVtCDgJl1bcJ0ZngXAYFvArwvIzFM?=
 =?us-ascii?Q?SkS4uvR2ehf9j0bg8CEPcZ2sHEoPc9LWtzM+CI17oeVu+UP333vwk6sW/dN4?=
 =?us-ascii?Q?60XnDyYLjlN+RpoPk9QxmSbSxEbheE0AMqEOs5Xcj3K64ymGh+0g6l19WSxl?=
 =?us-ascii?Q?XWTeibM5T0p0YT0u/EoyLqHY3Z/eQVnE8z9lRCfxQrgPDw0z2FbM5+LaRFfD?=
 =?us-ascii?Q?8ZYJCswVKXBMIR8HwOdAIs0pg1YL+9fhKlnfUHys1erSdzr+pFxkJCn6n/oW?=
 =?us-ascii?Q?8a/ONjuop8jfQJMcRN170+57VAuwtGj3BInTOtgs9glOhbAZ1ek+Yf8nzg7a?=
 =?us-ascii?Q?siNng3+C2Jb73APGMtoOHJB0b+xcEChniG5sDPx7iYQM88zSD6d0pJdGsrJB?=
 =?us-ascii?Q?7fLNJ3pArl5cbfmYuglUcd0gm/pm41Am6VB5TgUYc/RX7OnldUO6O/w1bwzZ?=
 =?us-ascii?Q?qhDjVVXoLH038GFJpKykdJsHJHi6MhPkzOv5JUUw/w5HtsCAXOPe2LPaL3d0?=
 =?us-ascii?Q?bJvhjDBegggQjXggy0RGpp8oPOUFxX356UvCOlagEXXYe/KxoInFUKuDg20g?=
 =?us-ascii?Q?mVxIiQmzanzEc3hj/iyixGvhFOYZW4Cg2P01hzo4ASpFhImTtrQkyJhbxYHu?=
 =?us-ascii?Q?RA0iRy1xMRYzK6AXGDewrk1qoOgt3ZWSO6tU19dXHdlilkBVxm4beuJyBaGw?=
 =?us-ascii?Q?HH2TJkqbwbPrrd/Vhm/YI/dZeQ8E4xRK1rrIKbufSucXPh+4D9Sda5nFZU7n?=
 =?us-ascii?Q?lwjpfnv06hASQVKtN2qEnkaHCOQBXcharguJTAC2ty30Y3rzqO0HXErPLOr9?=
 =?us-ascii?Q?QZuQM0YciEP8Ejvjs/6sTAY0evGfkb9bmclOPhHYrm8uyPShHiFNFDtUchLk?=
 =?us-ascii?Q?gOs80q1An6ionLLaiXYhmyxUxZHo2XPOWsQp4DvqOuwiqAonVN3ydmtV1NvL?=
 =?us-ascii?Q?j7H3CW3LuBGu2KxQLNQ+9IsSNH5DaFKidPLnZUVsRBJuobXtabou9WXlXcX3?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VsfJri/J7pigpol6VOkcK8f+hg3HfeCPPI1gkz5byynynS1H+Gnb/tu3zNia/FwROY/HnGR935CeSSx4oeMZh86VAw+U5IzZUd5WESvg2YCULrDMqHMTjQdjVTIoTHh5NfoE7z6Zr/Q0MuwyvWZTMSKJU/icGgXV1/AU7kDR1LR3b660VrU4mzDHUJiJ7D2YpA/eO5969ZBxJSWyJOn1FYW1bhqS4yowp/G5jJfr1MVSD2QVziFFLA7dJCXzlgR5Di4u2kYIIv8tbJq8KBR/K18+DPMmnMqKF6kfJ61b6nKToYV5LBEBJbl4L83TR7mnW6f3f9DROn+wBNw6uUUCHnmTjr7SPFaiyQVKHGq+xgOec1Yp7u18ejU/zLz8J9sqjWS3L2M0ZnHPY3lP0HU2COWchIT4yIQ3wSHMmBqzPLWjSD/5o8oz9QZYAH+XMc/IMVnIAaUJc4AW3C6MAY97sIjo4vLxcrSOW3kk1hcYWT2LEoAsioDnSiJIaP2twdLygFWjBUbdvCXBKUFu6YA3lFprqc/7Fw+Q+Xc9Wg8ljdQltv3KTC1tNacMuEmXDEZUNO8m4Q0s946a70Jw40oA5iwjv0gpMqXIf6l7XFuZeiwzN9237LAKQ/C1tpx+J/Ihy6PmbfVOYD4h70UVXBovxpwYeBHbXcwrpWZT24iy6DAVrnBH1G/Scsqap76N0kPTxZrNZziQiBJh4Or2wlACKkUnrpMeepgF1urEC57sK6iSu61yX9vuLkxEBsMNeAiFmyAwrnBmLyLWxmDScItiZK1NYVgV/C+ENZMZVHtzdRtkCai7M0MMT8nrAj9myE3r0XhodjRutR95lSCIrbK5WG144GY3EOU/8l5mbkMlUJRL2rHVyS28tUiu1hSiq8xUOJVCurMuTafFG7sVzefU4g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb355af-a16a-4163-4b13-08dafb0349b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:56.8091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxLLRqq4CbgaNF63ZBlnblsKN1iCqZ9fg0RBAZNhKbtTtpVIztv1z35qk0dkqTocMGqEgUAsz178+9SxbFFNmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: I_K-UACvcYwpXhSPkTb2g6hJmAW659mI
X-Proofpoint-ORIG-GUID: I_K-UACvcYwpXhSPkTb2g6hJmAW659mI
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

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mlock.c | 57 +++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index b680f11879c3..0d09b9070071 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -401,8 +401,9 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
  *
  * For vmas that pass the filters, merge/split as appropriate.
  */
-static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
-	unsigned long start, unsigned long end, vm_flags_t newflags)
+static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       struct vm_area_struct **prev, unsigned long start,
+	       unsigned long end, vm_flags_t newflags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgoff_t pgoff;
@@ -417,22 +418,22 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		goto out;
 
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
-			  vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	*prev = vmi_vma_merge(vmi, mm, *prev, start, end, newflags,
+			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
+			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*prev) {
 		vma = *prev;
 		goto success;
 	}
 
 	if (start != vma->vm_start) {
-		ret = split_vma(mm, vma, start, 1);
+		ret = vmi_split_vma(vmi, mm, vma, start, 1);
 		if (ret)
 			goto out;
 	}
 
 	if (end != vma->vm_end) {
-		ret = split_vma(mm, vma, end, 0);
+		ret = vmi_split_vma(vmi, mm, vma, end, 0);
 		if (ret)
 			goto out;
 	}
@@ -471,7 +472,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
-	MA_STATE(mas, &current->mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, current->mm, start);
 
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len != PAGE_ALIGN(len));
@@ -480,39 +481,37 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 		return -EINVAL;
 	if (end == start)
 		return 0;
-	vma = mas_walk(&mas);
+	vma = vma_iter_load(&vmi);
 	if (!vma)
 		return -ENOMEM;
 
+	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
-	else
-		prev = mas_prev(&mas, 0);
 
-	for (nstart = start ; ; ) {
-		vm_flags_t newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+	nstart = start;
+	tmp = vma->vm_start;
+	for_each_vma_range(vmi, vma, end) {
+		vm_flags_t newflags;
 
-		newflags |= flags;
+		if (vma->vm_start != tmp)
+			return -ENOMEM;
 
+		newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+		newflags |= flags;
 		/* Here we know that  vma->vm_start <= nstart < vma->vm_end. */
 		tmp = vma->vm_end;
 		if (tmp > end)
 			tmp = end;
-		error = mlock_fixup(vma, &prev, nstart, tmp, newflags);
+		error = mlock_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
 		if (error)
 			break;
 		nstart = tmp;
-		if (nstart < prev->vm_end)
-			nstart = prev->vm_end;
-		if (nstart >= end)
-			break;
-
-		vma = find_vma(prev->vm_mm, prev->vm_end);
-		if (!vma || vma->vm_start != nstart) {
-			error = -ENOMEM;
-			break;
-		}
 	}
+
+	if (vma_iter_end(&vmi) < end)
+		return -ENOMEM;
+
 	return error;
 }
 
@@ -658,7 +657,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
  */
 static int apply_mlockall_flags(int flags)
 {
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, current->mm, 0);
 	struct vm_area_struct *vma, *prev = NULL;
 	vm_flags_t to_add = 0;
 
@@ -679,15 +678,15 @@ static int apply_mlockall_flags(int flags)
 			to_add |= VM_LOCKONFAULT;
 	}
 
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 		vm_flags_t newflags;
 
 		newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
 		newflags |= to_add;
 
 		/* Ignore errors */
-		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
-		mas_pause(&mas);
+		mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
+			    newflags);
 		cond_resched();
 	}
 out:
-- 
2.35.1

