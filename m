Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34501675C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjATSDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjATSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:03:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5BB28D21
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:03:30 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGEYO8026896;
        Fri, 20 Jan 2023 16:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=5lZYcXgYC2XU7Q7Crq0PpM5xawnxjnt3+he9batxW9A=;
 b=z5cy3D6NpXlMlCgZIQj7dWFWT9kkjv7Bz08HGQRuGFcBxeiB7xJRxbA6PPvMCTRwEVa2
 XW6qHxk9C2XGnnGnnt6BJrld772Pou6kzrakjKlZMtMXM57h6IAsdEB+i/+e36kiHi8O
 W+pDyK2/WE+o86GX8FZb3G7aa/g4noLaIxiyZ0wDT4Vlkm6Cmo/kX30fZN9VX1n6nQVw
 NGeH+0Z9Sdn34DyYqaV+y9ydF6py/npkiPuq3OX30JUz+YKEMB2V59TlFpeksfB+QsMr
 QBRYv75aczqvyDizI/q9vqR/2Z695/JNhdzgAxFPqw1O3O+bklM0ALXw9sqpLK8VWNeo gQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k0154bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFHH9s018715;
        Fri, 20 Jan 2023 16:28:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quja01d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvwYAEumVFDmNG4fBr0qanWn3V6xQ5nFB7sGIi06+ENYSh4Zau0Dibwgv2ND0eaVMqY+poWOB9gY8+pirh4x1LApe0eYu1HHKZAMICLiFL+MqmQ6FaPImozFXe+NBDa+aFCgdpQoNl5wnlZT5uN0k/OPBGvV9zdNAfWkQIdt5gCcT81oWgRlMNAI6rdFFns13uNNb+suqbd1SjMd0RbHXR9TzKAG6ZCl5wJgeq3VO0E1hMZ3c9SqVUba0KSho95BkKgOpEvBYXJWKZugVE1OO2hka+DgQJOSWU+ceuyK+17FU1OOpi7vUvvT/aqeRffhrN1KLfjxQ50g3r1y+jCA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lZYcXgYC2XU7Q7Crq0PpM5xawnxjnt3+he9batxW9A=;
 b=ah2yefM/g9xF/g6wiin/3az+N6eqcwN+RAtTIX78FTNwknUJQoQW6EKMTNGCsYYyOhOm+v49z8m5tHeo0S0vln85uCdlHhthv6o31YUIlIep0g8Or2UpnvgGzfc8QMccceakOgM2CNBmU14DZdJj6vwWoCVT7W23alzEMB+0fRW4GTecLOsZFMCGrBk2EjFKZoAc367MrL21/fL0qVGixvBwKASusF75DqcxbVE/qAAV9blmvBNkmO1VbK1ndcMbfy/fonNUKcAUqJ4l5rhhbgLnTNHnUHKCaECHsRSxuEQQ1wRKk/S7r8KudX77sdGqdUu3rgmaldPyv5PkqxqJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lZYcXgYC2XU7Q7Crq0PpM5xawnxjnt3+he9batxW9A=;
 b=jEHaOOBwQxAjeFWhZWfagx+wvK4ltGg40Djy3dpw2p5HjqzcvJES5/61KbrCIOqvWVqxvYRkAPbf6YWxmNd3cylh20xaAZnyoLsScriVisZVHzfdqtIPvbxm413cli98fIOyfjgwvwE0UpKo+GDXcWfnbRCHBwdTA1M3VXb9Pc8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:58 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 19/49] coredump: Convert to vma iterator
Date:   Fri, 20 Jan 2023 11:26:20 -0500
Message-Id: <20230120162650.984577-20-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::30) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: b6304b48-82cf-46a5-ae38-08dafb034ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78TXp6kJlid7U/RPa3NO4IimDv5r5s8kRx2RHoEKp1IGW9JUGMRxSCAxK3ZcdeXvvghY2fzrfB4C7ds2b4e0lo/62dh81G5lYQDhvFj1kCIK+E2bcaqX1C3wOACSqtMTJ4BUFMORkmml6Cbqo93GGTuTo7gdYhotRW9swt9wv8NMWapdX1ZpKvaRoB9yaL26vQxCQdntsS3Tw8EGHxllhtraXBBzmx0F26poIpmfYMlaM3lj5T7GuiXmBn+55ROF+EY9f4Q23hGSVcDu3/mXwTm5wLz7tW4O1BFTT/ZgvgNBNKJMApGYFzfFTqqy8UFlR5N3+ew2ybl4/obXwQFfOcOrHh7Um5p+zR7Bi+YPW9bV/+uGU22tVslQmt4vmowxGNlg6ExXDystss5uJW6ZM+jDTjqYBOt9lGmRlTk9rDmLdP7ZLh6i2X1gW67Z3EPTMZvg7VV6JTcPG119Nmn1D9wsnJJ1IV4IQyTpw4ByFSqDA0cvgp0YhdcoFNZUfT7S4yiwdyftWVg8b/rlpz6UNgxQbJOvHUlUFpeR5Doa0jp2tQ7wCr/ps702SJW1YQIDv/E3vg2CVvPRkFdNaxUt1AW+dBjwtTwnpKi/K6k5yQ8I7l1i5p04EODlvhwssfljutRBPNEnsW+3/61RXmtF7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9+yrNsGv6BkwcZgEuPPUn3IE+rKkFnXVIsuDlM3ZeuMirMy0tk4vBbAPpOm?=
 =?us-ascii?Q?YdDF4yKokLpTZ/WZWzXb/UAng6Djk1DYD3fYqr2SBPKDwi95XnxK4t9TqLIQ?=
 =?us-ascii?Q?VHQA2kYtYdaEeYSbAeWiGTXoMHxK0/diTpwE4lBRg+MBBQ/18ZXcHiJGc0Sq?=
 =?us-ascii?Q?mI48SbEKUkC5qUtKbIDBpN+bmqSQRn2kw/rWzKd/FvqS1NPcd9mOCltPXuJV?=
 =?us-ascii?Q?noeEI/UHzxpzjgLVgOLSuxrPDavsw2P4cfC2RKKLHptgXQscUPheFWG1FWcZ?=
 =?us-ascii?Q?pblC6nRc8NOY7HGN2rUEoOb2lInV+jmIMkd8dBPv/Qlqdyhg1JhAjVNyq+Km?=
 =?us-ascii?Q?XrrTCpMdv8+MKeWeiPU8lj5UwItMSgzF4iB9vTRcMaxaHS8RjxTVn4SsuJsI?=
 =?us-ascii?Q?K1qPrpaqcw6+i3bsanr9BQgABWH+n81sJE/gMc7+D4AxXRHS5bYIIwwyxFfq?=
 =?us-ascii?Q?0EjEbFz5ZqBa9dPbJW8090Ce2bIbBuN6H8ar7noN6GtsRhu81y47ftlWxqJH?=
 =?us-ascii?Q?fyMl+X/WqsO4D46361nOUb4tRzoJ9gQJh5komFDvsBnc+vN365x1urGiGFal?=
 =?us-ascii?Q?vSEBnz/RkmjmfXgKBKCeYAqgHh/v5N3YH84N1H0gjkf3PD0EN1vePh7wGXDy?=
 =?us-ascii?Q?qU0bl5MJU91Namg8pq9buqqgY1hBz4Lev4vO9xqbEt/S0nl0zZkU7L39MPW/?=
 =?us-ascii?Q?N/Dt9abLdFMgthrH/fBSvPnk0vF2Qau9k2Xtab5uHgnD+Ho9sSl/IcTrQNxO?=
 =?us-ascii?Q?GYS7zcw4vEfuP1GzjNvlECp31kaptYtI4KpJB0RnT96d5RYDiR7gKQsEPF/L?=
 =?us-ascii?Q?XZNGIabJ/EFMHGQ+gYHF0cieIwEEIqzA0U5TaF4X+Rg6BqWfeiI6Z5IaiQ/1?=
 =?us-ascii?Q?QVOZ/7fJ9HQAej0LzDfFOdckMImRUCPhNvWyxb/sbn/r9YbUbNBw6LoU8lDF?=
 =?us-ascii?Q?1s7nT+t2aQH5OfQrreBqiy/+XtGhvCgMIEC7M4U6hQhcqENGgmzn9/Xbe7DT?=
 =?us-ascii?Q?/JVvGHqHhj+hoBUD0U5L7HFLYlyOZImuJf/U6q0SOvrRfK90Ms/XRRg0uy+b?=
 =?us-ascii?Q?HM9YGKbdUZ/wWeWAwzIhzirEFUu1mFV6iQmZ/Gt16WoyvxJ7IPIjpaAGbIu5?=
 =?us-ascii?Q?ikPMmT+7W/z+cYHnlMkaKL3Ao+UMCT63ypb9sovvJuUbmCltD4ronhyq5EYu?=
 =?us-ascii?Q?zvijvrJdixVk8YC9mYL5C5k0p18hPssxr2KjjyGyBVrxkemBvzShLAdafO/q?=
 =?us-ascii?Q?mkus3ISd5LR4WCrDxCpj1LBZXCOq+dixLbZe4QqIQ4wMeKOu06k+cs5SsfwU?=
 =?us-ascii?Q?DSt6Yd6S33A803b3Oh9wEWLlw+EOx3iUNeU8J6kxCjFv0+nmbOUtm0gUdcVi?=
 =?us-ascii?Q?wP+cWU7vm6wHbdD66BxcYXu9jttMjBbTOx7A9n5xvGO1mm/HXvZZTjKjkw7P?=
 =?us-ascii?Q?SCub+zL0fcgg27tlA6M8YEv+JVuN36bdID4m2c+p3r4MewQnN6xE5uVhgzIm?=
 =?us-ascii?Q?MwOiaXSJ8mtbrk3Tik/MoY9u4NeewYh5NOmhmLZLVToJTpub2BlpiUVrUWM7?=
 =?us-ascii?Q?1zVtqNxvRMCFtSvlG35QrdNsdmRSSUbagX4kOaOxQvHST+HjUHBvyj9DAYdr?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ewb25UxK4SXR8HLzTl/rHxpNgmee1R9JzAjxzU42VTZgl9DQ52SMmsqjhEOKMR8OkB2in+F2eGXPVzSVUWrcX9L8OijMrdXcMiHt0wUPe2bJ/aDhbZJv2iEVBCxi1Fp3V90GVFjxTFoUdDLClOk5K5q9xlsQ9aQUcKRXdstS/CIBgK9sxMgLBu8rM/LgztZlRRmtrB02BrZ9Qx33bcQkiyatAKraQeV/wkud/esT6ea9z7VDjLhEQb2XRuVdtEXW0lMXMFL591YEwFXbbKuDGdNBKBApvyLknv+5OfVhe45DHHLlzuIjfWPxfXYQwvyzLZcV1b4E2k1WcAlv4diY95YvEV5BYq6l6AMr3cuqb7ZaFBObtBza6Ed2RyLoTyQcZDyZwM0Rz3dSEGEvu7EgdOHAJfjKb8DTB6ff7f9ffT+denE7BrHGOZxcJLs1hh3r9XpLJAxjlqO2KiNJTCI/ruYz2W/YDIAClF7RjRDMW+O2gTNJLGMFSr2zCqphzlmK+P1oGdtk1BavHNRr3HPyfQxmYFMTsYoiKU0XqkOMzCbmK6eITBm2SK4QM9vaOeBX+fXZTQ+8ggvK48IFdZTRc2gOLFN3oUEdtVjP8AKNxOOGrJ2JdrQSrhgWpc1eIArTcgdGYP5GJ9zwk9UNaJ/eJb0NT7U8gQ37ti2peBOIvavZ9gFjWxPqmyMEl/vV5cJNTwcdq0dMJ63Pu8UgrA4USB5C6VCNa4MVoagPdE4Y8ouprphyXThGjV68xAW3s7bKMI22p54R9b+3Djjyv965gy8OalP5CygqENzYFhDBKJV2GHGU54JD8dCI5YXmFqq6mx+eM+3UqA+Z7AxBAk9ngWlDIku/ONn0fHv8K/TvNC+Z+aRsZOj0VLwF953F6pdsVQlfMPZ6rGKzCALz+jxpbA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6304b48-82cf-46a5-ae38-08dafb034ae0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:58.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4TimXEOL3RaIIX2TuhYXy2kuZSSiNEif8lGkZuRys739Wq/bzAPLnryQA5GBEkiHQGTIc2/PCaOF+++rjcKiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: jOU0MwfaRsnZi4rKzuj3KyjiDJQfsgZ3
X-Proofpoint-ORIG-GUID: jOU0MwfaRsnZi4rKzuj3KyjiDJQfsgZ3
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
 fs/coredump.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index de78bde2991b..f27d734f3102 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1111,14 +1111,14 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
  * Helper function for iterating across a vma list.  It ensures that the caller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+static struct vm_area_struct *coredump_next_vma(struct vma_iterator *vmi,
 				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
 	if (gate_vma && (vma == gate_vma))
 		return NULL;
 
-	vma = mas_next(mas, ULONG_MAX);
+	vma = vma_next(vmi);
 	if (vma)
 		return vma;
 	return gate_vma;
@@ -1146,7 +1146,7 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
 {
 	struct vm_area_struct *gate_vma, *vma = NULL;
 	struct mm_struct *mm = current->mm;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	int i = 0;
 
 	/*
@@ -1167,7 +1167,7 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
 		return false;
 	}
 
-	while ((vma = coredump_next_vma(&mas, vma, gate_vma)) != NULL) {
+	while ((vma = coredump_next_vma(&vmi, vma, gate_vma)) != NULL) {
 		struct core_vma_metadata *m = cprm->vma_meta + i;
 
 		m->start = vma->vm_start;
-- 
2.35.1

