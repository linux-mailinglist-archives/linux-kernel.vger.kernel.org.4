Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C11F6E2651
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjDNO61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjDNO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:58:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FDDBB9A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:58:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EEmkGO018718;
        Fri, 14 Apr 2023 14:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Vyb7XMU15lDZp1BvEYH9DDnivJQN64Iep5N04qYyvgQ=;
 b=0AcTlMLPMo29Zbbi7dA8LX2syP3zwG4KoS/EauV/Tgq5PYc5WsgsnfzoJs1RBgDDZlIg
 VbeJ/MHocGeqAQn8P9Tdl5y8uQI9P9gf3PTDgpvtdV+8dM6S49pO0mJ6Cihl4fP1i/CF
 bvgRbjzL9bkjrJhtwH3sYbKi5GgFY+17yDyvnekP6NQmUBei3rYhcLweZSq+lIfU2lTm
 ePnQwxhITF6AA49BYnkrdeYMySbETC7fbYp2Fkg7vfj9nY5UchM7n8Y4PsdhawR0rpaJ
 289eol/xMwCjdUXJqxqHJWL6DouQB/Jc+6fVlRagZc/HO9c27JYeoH18A53C1mAsOj0v 0w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0e7p1ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 14:57:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EECTK7011445;
        Fri, 14 Apr 2023 14:57:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw967npx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 14:57:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8Lqn7yfme0tB56/17U8wriAgNpDFciemEj2mVvuG+sj5IeRxCiqDR9sfiDHFOqqsQ0nIkdpuDr8xdIbPXo/OL5wy/B9sOQ0qjnAOUiE1wm77UWNBII7PB1vznzKQxT0bqWDyj7gQLmOR9U5N0UXSkgc9ZPA5omGMTG17IjAwu1X089PkVEs5rTK/DXl5OrAdVd6MwQHP0dknVUuSlKn+eNe9r0FeI0+89wQCd1MaM8WQhh4zPIwd8Hnn6fZsMggaM6mslt4P04HlgmzlIaLwg8Pf1kvwmALw1aYuN5L72mAe6beheT2uJrD9zUY+eGQyIX/z8QnleTvJTDkNIvBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vyb7XMU15lDZp1BvEYH9DDnivJQN64Iep5N04qYyvgQ=;
 b=jFbrvrPMWgNOEHWSQuX9KYDsw+ZUD3KkUvcAB3uvecnOCLt/tWRGJQ/3uHE6YVckFtT8Few0PGi+j5D4b/IGSVaDrnogm64/Dhd4g/EK+dv6ufSvei9I7DtgZkEKNcNOG3UrbVGN7h8QqEYN0xXXTXqdGK6LtWexCTU/iIhHy9hEa0din4y2Sn755TidRAHFF7YHwM4wL5+8DXR0HW7uL3MiBC6XseTD2akNlFl9oqL29nM6RvD3zTkIrUNEqvRw8pu0fdZ2ii5cFNOoiojWM0bzny94PixAmuHFOQ9c76SLpeLh3dHiriBCLShrkWCl6HHn9x7w44R2XiqFHiKl5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vyb7XMU15lDZp1BvEYH9DDnivJQN64Iep5N04qYyvgQ=;
 b=Aca8T5kAlaf++/i5LRndQsG4MbsOY0qUJQeC1awQffjQWGbgTDHdARJjVs3sLkgQ1Cn2+d6pecr+9KDfFQBvMeVisePtUEw/I6EIXl6Ed61NA/w8M3gsIerZTLltAeT3NsNifKaTFkWrlHnvYNttvfBqUdepgNk+IXQ3rYoBMmg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4582.namprd10.prod.outlook.com (2603:10b6:510:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Fri, 14 Apr
 2023 14:57:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6277.035; Fri, 14 Apr 2023
 14:57:55 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 3/3] mm/mmap: Regression fix for unmapped_area{_topdown}
Date:   Fri, 14 Apr 2023 10:57:28 -0400
Message-Id: <20230414145728.4067069-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
References: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0388.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: bd317e9c-a865-4c74-48ca-08db3cf8a13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19nrDevz3qSprkG/zZuShSA7/1WmCr1RXSmiq1scJPP9Otmbg+GLn5ZwMgRXj4k8LSe5aDP19k5Ev6wkZCeo+l2b7GiQHv8Hokq1sx5UwzYxfMoariWYbdoIJ2deltUd/FiJDxLjOQ4dgH9I0QU80b7sVnxeX2uyJJ/bk7LjnPqFW9zROMJgKZxbP+jwuCBbfywrzoQ94JB2z+lBuBLuWRegwDwcMEYwgYQj1mcKVOC3E6kZ72Yjo0LfRDdFLvawDcMBsOovdnylMgKEkNs4xgBh04w/dqjMqTgA0E1NFkjjpxnVhMsB1fqhvoTNqu7pOUN7jdZdwGGudYFbvHLm3/zhHyYdRrBajmfledXMpuotOBroRzj+YT36h6ADhrv7bCLqZGloQ9noCK1Gk3Ax44VrJVsV504vB0rE4RONiNroHdyBNWPMz8ZVvP9vIE5Qe1SQtCIo61xjT7wQVw6oSXysy+WKfYW5dzaAvrzThxM08JENXKaf7RjzQT9b1Go3wopxVTmhsbFR5Yt33q49UjkjH9P2D18CiNFHhPbTH1nxbgetArwbHjfqaccYqXb7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(1076003)(6512007)(6506007)(6916009)(86362001)(4326008)(5660300002)(6666004)(8676002)(6486002)(36756003)(316002)(8936002)(41300700001)(54906003)(478600001)(66476007)(66556008)(66946007)(2906002)(83380400001)(38100700002)(26005)(107886003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f1eRITP73xKC5Q3BHcFjsEKTh2x4RbICYloJMVkseyDw/AMkk5nBIunSpFrH?=
 =?us-ascii?Q?xANHNDCSskh55DPUdV1RtrXLexzMSIbFMlJL0A4s74dISCdV7At0Dm+35bCP?=
 =?us-ascii?Q?7tIwNw6AdNxR9vUUMAnrQq+v+obtQpCLsaXicsypkfpHdeTKU9ZrC/GAIgqs?=
 =?us-ascii?Q?qfmZuLwN93iKkOZVd+ZyT0ICht9dCLQtyaIME2TvpjHT1pc8Sw9FGA5PhpON?=
 =?us-ascii?Q?POiwaOq8I1l5zWO48j2/ynEZwOlVeC278BlyPxo5lcEUPRo5VOg2LoaVUp8x?=
 =?us-ascii?Q?aiSiO5IgnwlC6aArabwHVEWYYYh8sjBeIItps5WGrBJkN2Xce6QFAtBYFoVD?=
 =?us-ascii?Q?cEYksAw2UhQaBH7HYBd+6jsRp3ELaOw7RU/1JZA2F9OCj26iz6622XR5GcJ4?=
 =?us-ascii?Q?E4HJ804gE5X6ch8Fgbj1+SVMirkAqHVchiINkGi5tj/qeCfHT+7k0cz5WGAu?=
 =?us-ascii?Q?5wZTBzrW2KvdbaOf5DBWG/P47lAWnAH1jg6wv5god8Hifb51LJ7Birz135vK?=
 =?us-ascii?Q?FOpvaWGO9Jvie+oePGTajyECFDvf+53eTGxcKBDCeuAVpd9MYfe2cMEcSsC3?=
 =?us-ascii?Q?xxWHvwj9MQ8B8U6quH9uwQGx5Wc0T2McnvdEdbfFy5BBX/bf06EVKMNKB8Ei?=
 =?us-ascii?Q?IxBkpljvTKQ4OGaK7WYOrvpO9QYc7DpkxQV1TsYdfvn5Pi7yLm+Mav2QUn5T?=
 =?us-ascii?Q?CxciO9uAHKCsU/2M89+p8yuKJq4/2i4WGHmcAkR+HFzc6h5oEJqftxJdXtEf?=
 =?us-ascii?Q?GLPpeG2xAbibwCQ2oP1w9f8ct+aVwsTVAcftlVG13cfwoQ6efMrJczyJIeWJ?=
 =?us-ascii?Q?CEgf65DonFl9MDhweverXb0oIFnOUe7QwyfVsKJOt6dj6olC32pvLoR9O0AM?=
 =?us-ascii?Q?3rP3eq+pKZtaG0vzAylucfmA6LcQ2cYnnS8PHVX9H5/Z1zngiGYu8piT4BS0?=
 =?us-ascii?Q?6+BRuEQ/mf9gCWlTV4x0FHHJsmq3564+I3/WBuHiImN2IiojtCmfdLXzGoLi?=
 =?us-ascii?Q?TFqZNbjJPx9hChxJ6jxshFZxwdLuex7KxUR0TjbIJsB9v31n6VugvUHQ0vM1?=
 =?us-ascii?Q?EsJ2LB/f+pVkLPY5aNKAJ8AElCou6z5ddL/CNBioH16u0V7fSlzK+zqnDGPk?=
 =?us-ascii?Q?+pjrGG4aRDeSSuQaLadvm91brxlm5WLZOPlNkVBr/rzhwmXuChJP2QLGfMN4?=
 =?us-ascii?Q?JLrn71xbdjh5MJ2K9m//Kub/3OcYV7bcntU4U8iL0IPoXRRgtW6B2blcymBj?=
 =?us-ascii?Q?ziHkfFMez28HPY+F3txlvUxhxLaSL2VCiL0Osh8TdkzblqGZMt3eooRturQA?=
 =?us-ascii?Q?ZPYmOGS1SVEOdJWybtTP03imEBxzJV6BfT6ia4kYmMj7+/j2IBhIY6Q6/QLR?=
 =?us-ascii?Q?JoOJF5KPKaGH3Pq0OBKt+nDrotUJ5snk8Z6Jmt1tBJL3UfOWuwhrvKMwI38M?=
 =?us-ascii?Q?u7MMAq9qXiTvJl7Wzl2gYCBcRiNeQShzW3JmrnocGIRjsnOKnSjb9Oa89hUx?=
 =?us-ascii?Q?Mou+54Eo0TRT/nKo1OiJyMz0sX3CCxwr+DQT29mYcxr+p6o5V59gRBC1TBO+?=
 =?us-ascii?Q?2ouP24em5ovIk6terfLxymaAuJUrINxVjEuPV/d3/RVIwy1vSq9aqasgi+q5?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DhTwyVt0LrSCbVPF5KXTysZ0HpayeImJaYzKlQ167797FsfMdw4H2/O4CIS3ixzyHGxbJgFWPXxFTbyYINwXOSTcQPanAONx9bZE/Fe3p7gMuXhDeMxVS7PQRJPfp6CVgQ7AlHexn+m8FHxchToctl3MJpXH0HRfx1QYcOPbMxgtCHd5MfA12gp01Z4uwbf4zV0/viMl95MI6JOYveIisNY8BfmF3gbMbw7kGstPprJT6ClbzJz4pKaa02I1m+z3xiVIIB80m46lgsE9WPJs5Z4JHsrhREZCFVr2qLTduaIpVn2QtYCvNpA6XRtH6xxEdX5PuWnt/0hztQJX3YhXAluuPxGRONMpQzxxkvZ+TmQSDLiULLqyVG6E5CdZBz1QexHUm1cQTwfGvqt/NqeebBMAaePSRk/87shfJ8QyMkG5yx/YZnt0tmKWms4ivOhfHoOpp52bIQFIeLk6co9dJrYj+gVqyJhbHozROdwDlTLyXR+u24+7qnwOTt5f2i2pxgyhgEu0fJ9o2iKMlrT3g4NkI4ospp0TpoUCWhBcGqo9Q9YyCBOZHAZrKklszohiBkjg0mAIgLgZ2Xi6LFu2VLkqx1aI2E9texumLlrr9WyoEJQHtRB9XfuqHr3wo2H2TYPtodc4TCUiEfp+5SzX/QFR5MFdeNI9svEf5yZAGh2XjGSAH/G89DhHOW4DPU7xy9yFObUg9dbjWL/PM/c3VpNApaSFF6a5nZ1PDsTfkJDOWa2L1TFnQVpV4M8/lmMN99REw8CJJCwkCnof18mgU8gswN/w48Iee5PQbLW9sQRwWeItNCvfU26OEhWu2G1Lcfv5amkhvgHIX5NnaBQOOfNuWYJYfcLEysGi2bgY5cjg4NI+0Ika2vO8jl9I2xip
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd317e9c-a865-4c74-48ca-08db3cf8a13c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 14:57:55.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEvDeFb9NqDeszr0J9nzUU9ievbxRL7J4r1UDw4TFH8DQq9QKcgJgAK1kEvh0q+26Zv4hiUp4JrVNjK0WdyM8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_08,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140131
X-Proofpoint-ORIG-GUID: pArv3fjO61Ah_dGZgcFolTtTphAr-AUI
X-Proofpoint-GUID: pArv3fjO61Ah_dGZgcFolTtTphAr-AUI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree limits the gap returned to a window that specifically
fits what was asked.  This may not be optimal in the case of switching
search directions or a gap that does not satisfy the requested space for
other reasons.  Fix the search by retrying the operation and limiting
the search window in the rare occasion that a conflict occurs.

Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Fixes: 3499a13168da ("mm/mmap: use maple tree for unmapped_area{_topdown}")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 055fbd5ed762..c3b269260138 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1548,7 +1548,8 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
  */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap;
+	unsigned long length, gap, low_limit;
+	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 
@@ -1557,12 +1558,30 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	if (length < info->length)
 		return -ENOMEM;
 
-	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
-				  length))
+	low_limit = info->low_limit;
+retry:
+	if (mas_empty_area(&mas, low_limit, info->high_limit - 1, length))
 		return -ENOMEM;
 
 	gap = mas.index;
 	gap += (info->align_offset - gap) & info->align_mask;
+	tmp = mas_next(&mas, ULONG_MAX);
+	if (tmp && (tmp->vm_flags & VM_GROWSDOWN)) {
+		if (vm_start_gap(tmp) < gap + length - 1) {
+			low_limit = tmp->vm_end;
+			mas_reset(&mas);
+			goto retry;
+		}
+	} else {
+		tmp = mas_prev(&mas, 0);
+		if (tmp && (tmp->vm_flags & VM_GROWSUP) &&
+		    vm_end_gap(tmp) > gap) {
+			low_limit = vm_end_gap(tmp);
+			mas_reset(&mas);
+			goto retry;
+		}
+	}
+
 	return gap;
 }
 
@@ -1578,7 +1597,8 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
  */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap;
+	unsigned long length, gap, high_limit, gap_end;
+	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
@@ -1586,12 +1606,32 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	if (length < info->length)
 		return -ENOMEM;
 
-	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+	high_limit = info->high_limit;
+retry:
+	if (mas_empty_area_rev(&mas, info->low_limit, high_limit - 1,
 				length))
 		return -ENOMEM;
 
 	gap = mas.last + 1 - info->length;
 	gap -= (gap - info->align_offset) & info->align_mask;
+	gap_end = mas.last;
+	tmp = mas_next(&mas, ULONG_MAX);
+	if (tmp && (tmp->vm_flags & VM_GROWSDOWN)) {
+		if (vm_start_gap(tmp) <= gap_end) {
+			high_limit = vm_start_gap(tmp);
+			mas_reset(&mas);
+			goto retry;
+		}
+	} else {
+		tmp = mas_prev(&mas, 0);
+		if (tmp && (tmp->vm_flags & VM_GROWSUP) &&
+		    vm_end_gap(tmp) > gap) {
+			high_limit = tmp->vm_start;
+			mas_reset(&mas);
+			goto retry;
+		}
+	}
+
 	return gap;
 }
 
-- 
2.39.2

