Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B24675CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjATSgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjATSgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:36:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B04B4E0D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:36:47 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBi17001419;
        Fri, 20 Jan 2023 16:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=dF+0k54bykce8J17oSg5dT0XvDP4Mdb9eo9FmMMZgLc=;
 b=Rm3Zjl0rtlY9XqSPUkArrPL4O8SdyitX4nwFxhVYUgJx2MOCirS0IT2BuXLkxeHxMpOm
 dxRxjV6pdSE7p1Bnh61Ej/E/cGKTO5upWr7f0TWTm8yay39cCE9eW/bQo1Zwh9VH9jnH
 Wg0Rfzc1QsadO9orQnt8SDOkrPZoXNC6NCKwoERoYp4Lum441Xlk8H34fFvChy9Nx0hM
 x5DXv61C8/r5jOZ0e+qziK4f+1d0TYCSLURLdyIjgh1FdbpCo7Q/BJIz1zHrm9ugxbO/
 lTF7eOwXPQ2WfWB+RVo4Jw5bf6SzWmZ+FFFz9i8l4XDQp5guDZmUlT4SVObCrxKheW/b 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaan2yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFDBAN013578;
        Fri, 20 Jan 2023 16:28:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmfayg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPDNYxwIDA8xTLhyb74qGsR7ykNmUiojAKZZz7lZ9zD4yXnFl9nvuDFRAok8be96ZlqIpAENPgyBW/S5ZmmnZWSzqf+aTV/aLKLrEVSdome2yS3OEeMHezHtwOGpV0cTUVmYGUBnoS7SHHUIFHGjC4BC+g2a4qUSrmNgy/4KpQiToq86HL4sGQBt5EXc7+L8Baa4/sXMRRDElMxLq/hxTlM+W9gAzvgSqOtjeIp6+yV7p+SL0LdT6WjmbzKcHVRj5ajtagkkI/I8mjZKn5azWpu4KxetOeZS3XiUceVwQL8BU9b3lZV16OJiErrX5tRp8qz2wfAQCGG1Rlpq+GiRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF+0k54bykce8J17oSg5dT0XvDP4Mdb9eo9FmMMZgLc=;
 b=PNXdFZLGpQ70eEYFM09rAiniDe6ww8c9RY7LSS6252wB5RX4fSYjG+wEaGdfRRrm2dlma+htTWuyNI4R++1pt0ite59dGUtTPoD3mKoXL9t/VMpWzlXnvUsRWWYZayQUAFFEntzjPiQYOEyGGBuOHSRo+KblfErNt8/DFMZq3Luf2fAupkefpp1FhiEcVHInbMCfpp7N7GyRnLsy5FBaCAIk+HaA8Z9ntBKCFauf/y+X2zeDFCLDWmuqxaYT+T9wtqTsM6CWUOvY3JrcFDmLW0Mgm8CjzqTUY7w9ssBC0G4kGZ3SuC33g4mRwb2Vd5ZH57yUpFZq89iDuDMihH6UVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF+0k54bykce8J17oSg5dT0XvDP4Mdb9eo9FmMMZgLc=;
 b=Hu4Px2V4ixkLGLUgvs+0uzsvaoUUe17o+4nODqvbc9PirFjy/XbqMgs2ApAh/kfSFBsnSM/QK/haSd4Kss44iibladQwo4MRMDcLtckZZUktJtWl72YWkXZAPBlc4XjKsWtnhW5i1dGBMy8n1ELK4FV+cHbbpJTf6gDJG56UKZg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:22 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 28/49] nommu: Pass through vma iterator to shrink_vma()
Date:   Fri, 20 Jan 2023 11:26:29 -0500
Message-Id: <20230120162650.984577-29-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: f16451da-c46e-4cd5-29f4-08dafb03592c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAJ0WCUbuDxvHvOfCQcBulE4fJXUlcRGd+k2ata8EVuKSPyJA+ZbtiUYpx/WIxSEEkFnHjgPzlPpoDvteHII78gxGAP0B7FPQPQ4T778PmruOaFKAAlAP4y2cuJ3hbj33QO+dnPYSPeLzU3RJ8wrfJscqf2c8aiI2pvBMbAybs2m2gMeggpThGbQ+/Xisx9APcMRrLt6C1BKzSCaiXaFh/5JG64FNw7r3jiEPlNvOsOSQkO8QeWteh0V/Qs12wmk/iou/GfS1FOT9rnIs4wG2Af+fzFvCZIbr/7Musoh+J0GP98+WQr5v6MHpn2iA3bZWLDR5UhOwWQAo68FZWhjKTe7cq5SxiSGLh4QbDCDpQlSv/7vVBhKRdosZ2RkLjivk5G8qWm1ux/IeKHBvPdUAJdbzM/4svqhlrDnMbdBp5gLZMYz54ZzH255tQ6hVFdkGABqZVRB59VgUGha7kGkkTYGBywpAgPYJvqJmr5zZ7hmxx0RjK4io3gLXSl3MsuVWGImBFMj2WxQvPbRIJyuHziImnSgdly0h/7qiWyWWinoQ9RYFmiTQAi3rZXzqiNzhlNEVSvNq8vINAZpch8EghqCCJyfSGw/0sC/I8BsYKMG+VRf08Ki8F8muHeZ/VfPkz3kWxAnd+QujlnL36j3Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(316002)(26005)(41300700001)(2616005)(4326008)(66946007)(66476007)(66556008)(36756003)(83380400001)(86362001)(8676002)(38100700002)(6486002)(107886003)(478600001)(6512007)(6506007)(1076003)(186003)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ateG7sgVqv2s//9RnF5JI/FXut1fDu4rQt2XZhvEW5zWf1J4ObUyZbULmE7E?=
 =?us-ascii?Q?IiSlYQVOatCR9/1WEl+ePak/oQLSUwkxhuK9SF6GEXrScXeiCkzvGQENM29o?=
 =?us-ascii?Q?kSID8TV7p+R5NtXBWR7BulMW5iGe7ux5SRBUXWraqKo04fx1p1OJz18C8Pof?=
 =?us-ascii?Q?z76876qaVFQe4OL3LpafVxsInUTDiQg1nmEZBe3KBacS77R3aZ4d5gTvtkuX?=
 =?us-ascii?Q?44UpUmHoxyMrj9PtWcXSQ0n9cuOwvrYAezre6rxbM2+b/pFM10qWoSETP0E5?=
 =?us-ascii?Q?ZE75NLDDaNrf9sOf5Qu8cLicQdtMNMPs3UvOt9Ne+7Fe61Awcu+AjvWizQ3K?=
 =?us-ascii?Q?SGeotnVDvWwhqZ0ql6jEVsjLQZZJNWUk1yZXT+p0A0rpAvOZAUqo5nEl1Yjq?=
 =?us-ascii?Q?PZR7ZqGIwZxaxB+/AEXyQHfbPoXR5Wtqph3lMq+VOOsn6/V01pK32i9DQZyn?=
 =?us-ascii?Q?RhOIOwGh4eA3RkV/75e01ObKl3vfTFYXXOKx5wSDZsFSY7JiVGXoRgUziyX5?=
 =?us-ascii?Q?8SQtIzJbMZuAbY8ODz/EEnN2ELNeqcD8AZuw30BopM26ud4xZ0QjBUtsmEVj?=
 =?us-ascii?Q?Y3962Q6REeOfio/vxbgsKONwMxIzqh1ZmgUIsE7Wl+r70UZiERU8Pm3OyJtp?=
 =?us-ascii?Q?4Y8hvGEt+y9+BELA56r+VB9tB9StF+P9yqqeWLAge3+vymzILzDw5EXa4HKZ?=
 =?us-ascii?Q?XO4MBM7qjPP3v54zlEjNi67QSwaQZm4MExg6ojOUqWMpf0Y0kjkjK23BM0ob?=
 =?us-ascii?Q?MTITeUw8jdNzmWWfPWC65rem1+eHz5O3LtzYp2IbpBtA689DXrSV5qjgjLAI?=
 =?us-ascii?Q?NN62UAa55bBtfoUawl0Pj5j7bJLNMx6H4eF88IHADbf7dp7En3Kgw3HCEIt3?=
 =?us-ascii?Q?7ab9GfxCTd9OeIMHBuNLPwMGosIstRz/iOaKeOwvmWpcr7McS6/LAioed5Cm?=
 =?us-ascii?Q?uJMz4IBuZBNsppPo6shPf+1lc77FySwY1wWJJVUFUQ0w0SGPt1tDYBKD1An2?=
 =?us-ascii?Q?TVAiKvgOzxn4OoUDLy6407jIZB5yPuRho2HJzJkIkgwMbNUdWUugzzAD8hEy?=
 =?us-ascii?Q?otGB6pAL04SeVyDtgqkEzpbCf2j937kj2BB8XVOFARSL5JuHEu61+bEOz/TK?=
 =?us-ascii?Q?rOLRil8P8Ei48LNTucznd5IeW1xSzrvzZTCzCucqgx97eRZ05fBFPvfKbSfO?=
 =?us-ascii?Q?NMv0DMWKRmzMbGhXlXxJnxnM5qJf11qbjoUDm1gmJ2JnfG6E1vbyq/0J8yDC?=
 =?us-ascii?Q?iy94w2XtplUG7VBxtPndhboHfjM2q11ynXqnVuN7nnRkjyctfqTPcneX4sdw?=
 =?us-ascii?Q?w/baQv3d4pnd/qICTx61fHgYi3Ub6vFSbwZIFELTpo1FhchaRKcrxMr/Lxg9?=
 =?us-ascii?Q?Q6wDbayOXyyPnXsDOGQMyaK/mkMEvp40DosIifUcLWEQp3uBPs/eNK83bTNB?=
 =?us-ascii?Q?PXoUpcButCGYjVYrFYFvL81Hfm3wDPOWqqB6e3KZdbRgwK6t9DgQqdWpIb+s?=
 =?us-ascii?Q?JlH3ALviskhBM8e075oLV0tf66kmzLhe8nRoO4AD2K5+M7emmdp+a3LxexY5?=
 =?us-ascii?Q?gV5jMG8ukLR7BMgOX75ws2llEycX562845AstwW8H+NEx+mUvE/aQDZG0+r/?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PQzk1/UJCL5FRYe0mM7Cl66nmE8A4Q5rCnnTULZq3mHDoo8QLFfmxuGBnJiCytZ/J9R5yn5mWJniFB79hdRXedZe5BmFfWnPT9pDvDT3Utt/9MR/YrAR5q0Wuw0TgQV8ytGcFRRXAPUEch6yOq1qKwPZezRkfJ6pOuE8wwSuOfSoRojISKr8VQDV8NMc7ynPfitWiTz99J06ZVnU3NDUbmKvcKmih9Am/qjdPFpt7dHqkvZVfyMCL0wKtWerXGc7tubP1vHOhmi0V0fgnKz7Vj8kezTYUfb2qQycYH4/lHj71IxRE2k8oT2X2dsZrT49BL7gwqJnt2MCGjHPgsYRwvBbc4gwFTcLmkNzY+gCkGK/prGYFRy5GUpoTtIDL82a8IylSNDV2fQddW+O7+nyMiRjljyjBYtLShWZDpzCFcUnl8zemknfcSNs9HqQd2+5hrWD961jeLOaHS3VL9Ribp+M9fOLKMDp71GRJHWf+7xILBaGzk5jl/BkuBrIXubC6TaHAwgetJa4fad4/L2tgg8D8ZfmvVlhVzvHLK+J/Br1jZd0dJBYRyVaiu5+ObNNnpbFRSCabXvJJc+L6LnEj8sduONEenYa+Aqy0wpOLNbRyxjHwcp5gqhETjan+PrSXs3tKF7Q3zPKjXJniTypVNcp9ZvjcRVZ7V5Z+u1gT10uBfNKlukuHXVQ2dMOZjBq7XJ5iKUh8l7eECox/0EEIIJ5RTrjxmdrvOBioQ2/b7xMzf8XdqGHDg6kLNF5pjojkezdPBq3xQ7Bb8GmrdkqzY7DwF2tp13thrZ4kNRbMZcv5k9pBYWTwmDO6XkA6Eki3G2GpRbQG2IzqEGxO1dnVc+0YF1VUl+1vQFCo96SDpZobcwS6xvTpmtxkW/rcplC2y+wI1NCmAQARSMEHczybw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16451da-c46e-4cd5-29f4-08dafb03592c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:22.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pgYIFqola/S06MX972wKmo/WzdigmEVv9i9M6SMWlYuhq22gFxVyT57/Zfe5tQEoTtor635CQy7of8Z5GHrYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: Yt72NwqWgZIpM0pICzd_Ym1SbZPplwHv
X-Proofpoint-ORIG-GUID: Yt72NwqWgZIpM0pICzd_Ym1SbZPplwHv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function to vmi_shrink_vma() indicate it takes the vma
iterator.  Use the iterator to preallocate and drop the delete function.
The maple tree is able to do the modification easier than the linked
list and rbtree, so just clear the necessary area in the tree.

add_vma_to_mm() is no longer used, so drop this function.

vmi_add_vma_to_mm() is now only used once, so inline this function into
do_mmap().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/nommu.c | 63 +++++++++++++++---------------------------------------
 1 file changed, 17 insertions(+), 46 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 7a52a7c37009..9ddeb92600d6 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -560,44 +560,6 @@ static void setup_vma_to_mm(struct vm_area_struct *vma, struct mm_struct *mm)
 	}
 }
 
-/*
- * vmi_add_vma_to_mm() - VMA Iterator variant of add_vmi_to_mm().
- * @vmi: The VMA iterator
- * @mm: The mm_struct
- * @vma: The vma to add
- *
- */
-static void vmi_add_vma_to_mm(struct vma_iterator *vmi, struct mm_struct *mm,
-			      struct vm_area_struct *vma)
-{
-	BUG_ON(!vma->vm_region);
-
-	setup_vma_to_mm(vma, mm);
-	mm->map_count++;
-
-	/* add the VMA to the tree */
-	vma_iter_store(vmi, vma);
-}
-
-/*
- * add a VMA into a process's mm_struct in the appropriate place in the list
- * and tree and add to the address space's page tree also if not an anonymous
- * page
- * - should be called with mm->mmap_lock held writelocked
- */
-static int add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	VMA_ITERATOR(vmi, mm, vma->vm_start);
-
-	if (vma_iter_prealloc(&vmi)) {
-		pr_warn("Allocation of vma tree for process %d failed\n",
-		       current->pid);
-		return -ENOMEM;
-	}
-	vmi_add_vma_to_mm(&vmi, mm, vma);
-	return 0;
-}
-
 static void cleanup_vma_from_mm(struct vm_area_struct *vma)
 {
 	vma->vm_mm->map_count--;
@@ -1221,7 +1183,11 @@ unsigned long do_mmap(struct file *file,
 	current->mm->total_vm += len >> PAGE_SHIFT;
 
 share:
-	vmi_add_vma_to_mm(&vmi, current->mm, vma);
+	BUG_ON(!vma->vm_region);
+	setup_vma_to_mm(vma, current->mm);
+	current->mm->map_count++;
+	/* add the VMA to the tree */
+	vma_iter_store(&vmi, vma);
 
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
@@ -1406,7 +1372,7 @@ int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
  * shrink a VMA by removing the specified chunk from either the beginning or
  * the end
  */
-static int shrink_vma(struct mm_struct *mm,
+static int vmi_shrink_vma(struct vma_iterator *vmi,
 		      struct vm_area_struct *vma,
 		      unsigned long from, unsigned long to)
 {
@@ -1414,14 +1380,19 @@ static int shrink_vma(struct mm_struct *mm,
 
 	/* adjust the VMA's pointers, which may reposition it in the MM's tree
 	 * and list */
-	if (delete_vma_from_mm(vma))
+	if (vma_iter_prealloc(vmi)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
 		return -ENOMEM;
-	if (from > vma->vm_start)
+	}
+
+	if (from > vma->vm_start) {
+		vma_iter_clear(vmi, from, vma->vm_end);
 		vma->vm_end = from;
-	else
+	} else {
+		vma_iter_clear(vmi, vma->vm_start, to);
 		vma->vm_start = to;
-	if (add_vma_to_mm(mm, vma))
-		return -ENOMEM;
+	}
 
 	/* cut the backing region down to size */
 	region = vma->vm_region;
@@ -1498,7 +1469,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struct list
 			if (ret < 0)
 				return ret;
 		}
-		return shrink_vma(mm, vma, start, end);
+		return vmi_shrink_vma(&vmi, vma, start, end);
 	}
 
 erase_whole_vma:
-- 
2.35.1

