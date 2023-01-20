Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89856759FC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjATQar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjATQao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:30:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB1893E2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:30:06 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBbSg003336;
        Fri, 20 Jan 2023 16:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=7C53ousdziI37cbxBfN0Xo+nYJxD9WslkqlikZo2qKw=;
 b=JxO79Rv8If/FFnfaJz9n6jmzj+9UZFHDKsmzOC/LMh4uBd2smf1LUiDEKQN3wUPSosbo
 G9uc9fMV29rDXAeGffFHok5/rUzxluNuPaph7KXUAiZeRqfM9DGY6CML4OwMvUBNggfF
 67h+2za8pPBuIOEeX++6e54D2tHIAr0sNGWkC/ATf4+dmSct83cJKXXojwW7ID8SdBCX
 Iv1ayh1VnYV5TRo3K8hJu63T7SAIW1OPuxKl4t0gDnCR93WlGbZnOePHrJBi4keINgfM
 QFUCm4nwH7o6evh2caT1Qglt0aZqSRJLg4IsgEr2QUuIWy3tOdeHjnKcc2ZS/ZBTrhbE jA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medn7h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGNOdd004659;
        Fri, 20 Jan 2023 16:28:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1gs7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqptT5iN+Bz8uzJ+2+MschwuW9Jb7hE9isz0+Cd+cInHBfGJ6TIaEdhsYGFfWpbbV+A1I+4Na6vNzapUPNQDJsun4yqr5JXry5EEHr5WmbuYHG+8jnxLffU2H6/cbEsm/upee14kpM3Scwxwg5XbIXh3JuTut9fmmdf44IFYHhCvP9E2Ic2zPy2drPi7t7nwJu680/vW/9KX8I5EDaUYcv3CRntp6XMcijkSDzpX3DYiPc7VLETnYRQ54yGMo1DdSU5A4rKIzxN+U02HaKeNfrWX4Yq+yKyjASyYU8OzaA7KO6R6ztztwL2BTLSwXvIx58kFFSJ7jiLAGRXhL0f+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C53ousdziI37cbxBfN0Xo+nYJxD9WslkqlikZo2qKw=;
 b=BOpCUVrYqcI5E3zAnrRA27MomuddhoW1hwHIDGlizdhy6cn396zdvXlyIEST5xtHALwR++r0JMmSYS+hRGRnhUoc6te3jVlQUE21+nQUrWl5GVrGWpYEOM9+372EPnkwuLtPwP5EQQhhHaxyfLgAQcH0uademXGB1T2Nf6fW6PPiVhFiLlIuQmrFlVG/QrZYGd5WePdB3Z/xGAzycH80gKghO1PJTIBuHGtQpw65YM6XsnGx2Ohci/cus3b+1zcPyUE7jCs8C0wbt0n/jKnFtYg/gfa2f/5LPAiMjkjKPRc40A+uwy4Nubl6L68WpdgrQWvTe4wpC3KrlaHnhQE1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C53ousdziI37cbxBfN0Xo+nYJxD9WslkqlikZo2qKw=;
 b=bHMkuz4EuQ3XXEOMVjtGMnOWorl1j9KXRajREWGBQk2zl4dHTTGA9SROA4Hds32ggVo3Rrdr880ozJJF/6J+ojpLLNc5LjzZDF+VOOnDOdKPGfKLUvjMSOpC1AH2QvwhOEAZ0Nu7xtF1gSmGGv6/KAS/C1Yi85+BD98WNACsj1g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:42 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 35/49] mm: Pass vma iterator through to __vma_adjust()
Date:   Fri, 20 Jan 2023 11:26:36 -0500
Message-Id: <20230120162650.984577-36-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: ee354a16-acb3-47c1-187c-08dafb036539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NB3AoqcWsp2uJknIBuciUtSrANYevzq/acUC7Ihpyk+aE50LJ0E0fdDMn2C0oJOlXcr3YQ0ocsE4S/IG06QNrx0jR9UL9iI+LbJS1QOGGr57dUK0ahm0VzSY1Zn7JM7ZBa8dBLposuzyGyufeJ0rO4i9R0uLhu8a4ZZXFrzT64DifQKdFISuyQVgcPE/MyH+pg4ooUYXtzzw1RTHQdaI/71Jksh+DsnACpTsXtD3qUMmc3uMLnksSBF/1HnjVWUgf6dLw5MYC2baW3tncVL6A0j8Ql9Y2/Y9QBY+whOi+SMvni5M9aiTAz20fj7y9w7BmAWPxOdIFheFKCFoydZiTVsr3wsGC1MKh5JPV2f+iK9w5TmQ998NIkIADFnudvCEjwonkR6O62WauH5sNvMHAMi02hA/ZuINIcIo8px19TiP14S+dfRemMC+ITYCgomhSuflctHLnLnhS7RM1KttJySHjwP+e5DXSbvnAEOtTImN/JllUjmHSkPGnsOSVKynC1zh+Wrqn9VZctitHJQVIXmJGi+Q8HJXg534Zbe9mv9T/r5kh9qxaNKQ0FyNXYUeJfY3alakf0/ZSD0Js4qPLA6ZYQgMr/NpYhpmrYRtQy6obA5r65gAi5YUNmm5SmecWeu/Dzn6iXVEnGbWG+lazQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(316002)(26005)(54906003)(41300700001)(2616005)(4326008)(66946007)(66476007)(66556008)(36756003)(83380400001)(86362001)(8676002)(38100700002)(6486002)(6666004)(107886003)(478600001)(6512007)(6506007)(1076003)(186003)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQsGzM216EVy++T2Hs7HJem4KAzFGv+EsWIIDTqal17Jz9rwFZvHuhCG/d5y?=
 =?us-ascii?Q?Xxf2S1RrKW2b3Hg9wGh7tB6TNRjtYeBJ4AIFKeMZ+2Oyqln4k8hybQhFf3AX?=
 =?us-ascii?Q?9yljs3jXtankVQhXOIo03uw/gn0yNq29XmT3nXL/a+PXKFWo9IbB0BjgVC58?=
 =?us-ascii?Q?djJBSId9ml9+sxzm0sJaRZiss8zo8ZNlibYTqPv6Z/LR7YlI0YZbTb0VbpN8?=
 =?us-ascii?Q?1Umfgv9OrMOPIeLE5XxEtdDuhmWihqSb6auyrGfYALS+vlKkst/WjVVfO1YK?=
 =?us-ascii?Q?4qrGSXKB0z7NsBHKPH6gQojfSgf3gGnlrZsct+MFpXeQWVCJ+/LcvgIOQeqe?=
 =?us-ascii?Q?Dtg5cpZyoB6xo5gIx1EKXmnY/zCTXXjdoBNLxdtdxGRMVMlTz+o8cqzOC7Hh?=
 =?us-ascii?Q?sOz9UFnNG/fdH6jlEx2tkeis9F3oQ996JfXBamTpTDapq1BBNFdrO2uFmtzy?=
 =?us-ascii?Q?FDDKj/StC2pztPdoB1PlE5iRb1eG3V2QfljaaGQLu1DuIyMnQHG7IhRdOPIz?=
 =?us-ascii?Q?kx5Ah1C7QPwQiVFFD+fIog93q02vx1EF+2YdI1OihbBEic/tc5oWnQT+M9S4?=
 =?us-ascii?Q?oqt3IcPOb/cJDUcwtr5BObKYCRJl3mQTzbyAOrqN2kI/HA6YOhhhP4Di1Gpz?=
 =?us-ascii?Q?baardl0aG/KzAJJEi6zv5XYQW4bXSGNjeEUdIOl+F3PiVjddrf1g15cjfEaw?=
 =?us-ascii?Q?wcF3p+WzHmCRaID9Zhg57Qh1kUia+cdlMUJCySl1V6OQ8nhA3/Qwywpg8Ulx?=
 =?us-ascii?Q?iEJR43PvMUUxRZgCt1ZwnSHfQBbao8UXW7AGgkwjUtQMd8dT3tXohn0x4y95?=
 =?us-ascii?Q?eBVnKwzgPq/G5h7dZnFa0FOTDZy220H/6VaEAw7Ergag5OTMcQYogOUihTXO?=
 =?us-ascii?Q?apuUaEU/kAeyrPCQ+1LpIag4SUGhmNj1imBMygimQ6vTDg7KaQHJui98HyL9?=
 =?us-ascii?Q?y37nfyi+kZr7J2hlq/LgVGY8h7+r30qJ3+bixDDD+IeBo7d2iaXlDu9fo9uR?=
 =?us-ascii?Q?Qfn5/P/EDszbd0lDBETAgomY9wmEB5tSZDvK2zSMJvnm2qqMxDvSgmrv/S5g?=
 =?us-ascii?Q?Rfg/2s0Xka/sch8wvSpFn8Ox+MlrWSWMQYU4eW1uVLR54V80MEbsU86/ZV4X?=
 =?us-ascii?Q?1cdH0PQ2Hik8WQu2V/pg6S4Tx7UJAHKsNkaSMYsh5SMtvSZMs+lqbtOcHL98?=
 =?us-ascii?Q?Y0AGZuS/hav1E6U0dO74W1DDYqY+elbfiywVVZ2pVCzqlUWLq/jvg7cFJB/c?=
 =?us-ascii?Q?+LpQ1GrqZlurAC93BXvt86F13zw966NJspfG50ImG23X0jXPCtrJN0ZGD6lR?=
 =?us-ascii?Q?033pNqM3IGhlrEjQYgSfF3e1WqkyMEGRjwCDrMRorR9L1eLIPjeI2/1NIpuP?=
 =?us-ascii?Q?XfBbQoFm2tDedgqxbGzvRzRMvXqGO1NrQU9zvtJR3Nel/7FknadpcQ2CQ0xz?=
 =?us-ascii?Q?2Yewt5vpOwR9QrhY4SXVhugk0T2ffPosRJ5q5LORJ0H4awn5LuE6wE/rC+rl?=
 =?us-ascii?Q?kqC2fcd3TThdqjpdi2gGT935GQs5QbbPl6QqJnxjonxrQ5SroJagzw4CAfNQ?=
 =?us-ascii?Q?Rph1KwXZLbVGADKTt4O2qD2QuLK3h2rsRPIVRX6wNg7v3NupvLl9lUAIUqWh?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mSHODp32Yp1fuEjV0QoWd3GRnO6HPKUy1IUtjN44JnvP6qhzZySIfrKKWOQi/ygzStBo1dZy6YbyaVf7JN113IgIu3Jpw3E3y4npBuAZMBtDijzNsqEvfYS7y4QAFqG9flf2QUc+YbQyv24BFQ8WgBynefrhRnGZCU/x9CdL1h8MVa6eqsCwopFRKxzn9KdNdpUDLQxmc9HVXpiD4IB3FAwp4T+MTbiznNtWg3nZx8p0I3vmaK7F8ZPNybr9jQ7gmkwUsNdY+t5QWD5Gt9KvgpuTWN8jHB5cAu+00heNnJdgwMlDqwHxMJEMC/FcktB0c5HYjdH3j2/sIzTUtThg0GAjyO6gahskNRQf1O3Oic+jgE10iCgRXXiNg/q7Y9sckNveRjq8sRpJYQVWlg/fbDMrs7LglvdYYK3x01d3pHO54Vq1ReapDZqwZgitJEJkSeHy6KcWdP40hu0yS9jqFab8N2nbAP1XIfufWxviXJXHTbg3C0EPqYU2q8zgNCCpAPJYQUPlBbhwCVcbLEV+dTWjtU977UEIGGObsAG5kFqL06iUqgW0sRhOZMAtxk0zYblGFpUY4eDMzCMKH6aN9/z5KGpj7y8782a17Za3NZPMAwH52upZxBhdwBQX+ROBZvsZwjGKa6tbpDeTasgS2pzXLwJPB1vjfN2MYODVjSJNeVl8qmkJ34y2m776W6i5NF2nLZkL1qKlcznbLOOAT0JaDPf0Dk6rVwrDfMrG4Eg2ATHoxldjZ/iSQ7HUnoX6xGOdR1c+def2DGIJd7HfTEoizrBRyANbZWykN+NQb93uk9RGjvXpHHuO8blD46AE4IoYxrhJc+dbne+9HF/gHEKitRZ6pl2XLGUEZJY+O7lmGfa83kQD8rWzqcgBoazLDXBhaIbNBxPoB4NIEaarJg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee354a16-acb3-47c1-187c-08dafb036539
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:42.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goQ90hcQOgUTeD46eVMH2wGxqFiZBZYJZeAFWlM7me76/Cspk/OBbSjuS1Rfdot4DRQWPAETW43T/IQLwdOzGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: TgrmUuWoXuS7wExi7mGq8FAlldkEyGWm
X-Proofpoint-GUID: TgrmUuWoXuS7wExi7mGq8FAlldkEyGWm
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

Pass the iterator through to be used in __vma_adjust().  The state of
the iterator needs to be correct for the operation that will occur so
make the adjustments.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 58b2187b447b..c7d72475ba6d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -528,6 +528,10 @@ inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma_interval_tree_remove(vma, root);
 	}
 
+	/* VMA iterator points to previous, so set to start if necessary */
+	if (vma_iter_addr(vmi) != start)
+		vma_iter_set(vmi, start);
+
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
@@ -2167,13 +2171,13 @@ static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
+ * VMA Iterator will point to the end VMA.
  */
 int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	int err;
-	unsigned long end = vma->vm_end;
 
 	validate_mm_mt(vma->vm_mm);
 
@@ -2209,14 +2213,17 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		new->vm_ops->open(new);
 
 	if (new_below)
-		err = vma_adjust(vma, addr, vma->vm_end, vma->vm_pgoff +
-			((addr - new->vm_start) >> PAGE_SHIFT), new);
+		err = __vma_adjust(vmi, vma, addr, vma->vm_end,
+		   vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
+		   new, NULL);
 	else
-		err = vma_adjust(vma, vma->vm_start, addr, vma->vm_pgoff, new);
+		err = __vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
+				 new, NULL);
 
 	/* Success. */
 	if (!err) {
-		vma_iter_set(vmi, end);
+		if (new_below)
+			vma_next(vmi);
 		return 0;
 	}
 
@@ -2311,8 +2318,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (error)
 			goto start_split_failed;
 
-		vma_iter_set(vmi, start);
-		vma = vma_find(vmi, end);
+		vma = vma_iter_load(vmi);
 	}
 
 	prev = vma_prev(vmi);
@@ -2332,7 +2338,6 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			if (error)
 				goto end_split_failed;
 
-			vma_iter_set(vmi, end);
 			split = vma_prev(vmi);
 			error = munmap_sidetree(split, &mas_detach);
 			if (error)
@@ -2576,6 +2581,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		goto unacct_error;
 	}
 
+	vma_iter_set(&vmi, addr);
 	vma->vm_start = addr;
 	vma->vm_end = end;
 	vma->vm_flags = vm_flags;
-- 
2.35.1

