Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CDD6C63FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjCWJrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjCWJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:46:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5B6244BE;
        Thu, 23 Mar 2023 02:46:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5i7AM005177;
        Thu, 23 Mar 2023 09:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8zn4ye5Wdo3UkBGVsStS8b3TMCzSwtohGd97Hs5Iyrg=;
 b=IxKaYLng/VXWRiX63dy7+Cv5XXnHdsqqtQKiOFzUM8H6Qcp9Bu3tmivvhC1SrMhNUYGU
 F81haO+OXCC/onixf0mYAaMImrPayw3fiVTtvuCWmDyigMSzBeRPDBGIAu39W+vpfmIH
 Mqf7Zs8O7tgRhvSmLLPi1vpnnJkxOjQRiv9MZEcrDHynZDaJBIEe8FcLI86wag0A9YEz
 JNdnTWEqtJfgvm3oyT2AHEA4ygtrgkz4V0o1gurZAT/4G0pmOrbbneXEkyUne6xySPcZ
 anpiaIdYQtr7deUQIOcfpSMTsdxRDbWv3tthpA2pFULBD29aLHI2YVkYJuLfwEXlNEWX +g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdu3ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9cdiC006987;
        Thu, 23 Mar 2023 09:46:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgmamg7ry-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz9N8RZoufynyrdHPEWahVg/gDtMBnTPvGzguiyLx9AIrDfTXGWOGgW72V0SRXYsSPmz3DEbz9Y2DGNMDtIVOThkbRP7Y1UiPchpFMrCSXiCg+oNpJGVEg3vPilkXVwETnktdEhFObQTk5fpVDyeB7teyiyGjRPNDNF4a6CVHhx/y6Aat8wg4WuwVVZ3XsZHMrsBmn9TZFlKxXwxebvFeG7fPJbnwGx4Zmc3ikv5I5g+Nz9GfOfHLO0cMyzmUriqXGrptNPTvkO0YV7N11CsekzHiaOiXqA5ndvUgU8EBcgHJIjgsulQEC20W9Kbo5CPHAqnVt1B9PXo+1kLhsNiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zn4ye5Wdo3UkBGVsStS8b3TMCzSwtohGd97Hs5Iyrg=;
 b=N9ns9bPSUvu/0blBngGGcqzaXOxlvE9mSpAfjYLwRT83qVy5THmwJoGYsbdUnbgqddSn7gg/et6FAOipjdI76vVc/kV79RflIy+hHW8tD3Xx3bnMw9lQuDVYF/OF6utBolsomgA4eLV9ZhywJnFisumaDOi5lnQE6xG/W5iyksXPd60co1oAuGLcH/FOfZ4ONesDPg/lBKLIZtj82Xvaot5pFYdFiAeeswX/Zj59oFk5ttm+Dh74Arw+D+99bmWN9FgxxzSNdz28tk7TBmk1DNmIgIj91UJcbw1yMHnb9Pyb4Vw3dtiAkQfQr/rnp/f2aWRj1ySPgwBfW3dmGppTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zn4ye5Wdo3UkBGVsStS8b3TMCzSwtohGd97Hs5Iyrg=;
 b=Rm8qdkqQ2PWtvzMXN19cMejPrSHL2fxBQZSCtbrzNNBuDlezBvkBsRF+rUrZ1ytysKNDsTD/FruYyGoDAdxqNUJKAC033gfXJNRHqACBQldf7mWmkqTilVhIerWa3KBD/n2eul8deeDOtVmGQcGY+5DjhNSLPvBPqmpsS0ZCHJE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:46:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:46:23 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 05/11] scsi: scsi_debug: Use scsi_block_requests() to block queues
Date:   Thu, 23 Mar 2023 09:45:49 +0000
Message-Id: <20230323094555.584624-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323094555.584624-1-john.g.garry@oracle.com>
References: <20230323094555.584624-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1e40b6-cd58-4dc8-5553-08db2b8376c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEPYMRtKjKWFfLXvm9/k+Xg41oQAR09gRV6p1A3jOv8vpciQwt5PxEyxQRpcHmr7Ydd6d2/ELJVA2YTy/Y1ELrWIPqrzk7P/aLQKv9dkl3SS6xR0pCs0HObrkfbKY0B/nvNFpzqCXqm7a8oBhwHYnH/i1iZxs4bLXGNMC2FmmFVTJH7wswmM/up+BqqN2OGskbUupiRbpfOdgyUFmE3v2Xb/euYqX9BH/olIcnFjNKvNbuwXcLbyz/O3TEXdzOZFFbK8OyomS2gvC2EcVet6lM9mzG12ndJzGoaKRlm1Em9i9zaRfPOyLqJYdZA4nfjJfZqr03X7qx88ACm01WnzeWXO1Ov3h0MsAND3CMLW9zCuwbyhrrO3EAEycVeKcGNXX39mXiIrXXy6JnVizWL+Pd4GSPIkD5R0JZek4EBphKIsDjLYWMGS/pgCZw6DE1s1LErU9xEJ12aKrmY4K3L+KMsvri/U5ZNTEzyvMxvy9TulQi1I27Bkr3GkbZ94jInMEubYODWovHkrhqJGAYADPU4N1dn0wCxkI7UmAGRJ9VpQhuFKDLBelM3ro8hA8iVSn7qBikfg/jZOOJuGh41voKm0dNKR3zR3kDTWpovRTdJQ+Ov/DT5/+htAdDPBLftUvExKTsn6k2992UC0/BWWSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(6486002)(316002)(5660300002)(2616005)(8936002)(83380400001)(26005)(103116003)(41300700001)(478600001)(86362001)(38100700002)(2906002)(36756003)(4326008)(6506007)(66476007)(186003)(66556008)(6666004)(107886003)(66946007)(1076003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wr+R/BNvg1sy9hHmZMnRr/WIg7JJOdBMaZX1lX4lsovq9/9lZYoP4O1jTJes?=
 =?us-ascii?Q?XVfzgymf1Of8ckHO35d+d77ift9huURYoxkFfQGUmC11k1hRpGckKDGLJBma?=
 =?us-ascii?Q?ne99gLivRvBQM8Q3pnUBrn6e97PmWAHm+ryPr1qP3YnxoI4MBYtkkGj2WX7V?=
 =?us-ascii?Q?E8paZ/6XZnht8pgsqUCC5wYqk4QrGP+PaM9Eo1FU+NgiQir2DXd6uD9exTCj?=
 =?us-ascii?Q?HY2By3AmrIXzIiZ2M59G9rw/vWu/e7TlzwzXHZsvY2qh8u7Pk5ueVJCqIcQO?=
 =?us-ascii?Q?8jXS9fQ1BbMV/b+7F/N7vPp+oFgw6y/NHl+tFmkKr2Wiy3t8Eey3zFTYMa5p?=
 =?us-ascii?Q?/q4v/1UdtuRBw94DGBcLOIcUq4C41vdCa4RgR71RKw/jNW4MJ2gmeW9W2x+D?=
 =?us-ascii?Q?n7yqR36MRY4SDdZMfh3jvYUrLrVLnrCOxVClaPiDg+8e8itaco7obztiGhP5?=
 =?us-ascii?Q?O73n5t93CxpHgWFdtksEwQf5Y678mD/jP7wNMEXsmyh7HCPVwN4bkCidSU54?=
 =?us-ascii?Q?x7MnhNtJFgcWwM9imAfQbiGzt7S5TaqOx11ft8rBuSeSZ7pog/6/E0UkHEun?=
 =?us-ascii?Q?/QHUiFTmGuVRwHs+FBpd68U9oijF3AWLsXetxfyI8ZYOTxrTbHIRZeZ2xUKg?=
 =?us-ascii?Q?CcSOsnUYK3DWi+tzkqX87IAlySeSEqWpIok1KuFZUY2ABej5xJ4lxx7KgphK?=
 =?us-ascii?Q?EiMKrG1TNbflt1Dhu+IDeBOHHP4cj7ZPQ4tPj9PKC7roDJXauisavG3sTxoi?=
 =?us-ascii?Q?J5jXInc0FKpz/Bkt0SvADwnUFZdPLzH5knIHrbeRG6jDO1e3LJ02gcoe6f4c?=
 =?us-ascii?Q?RhPIBUGKBrgE3nWYEMgW1wCuKH1Q/SsTHF8bFCZy1nHZPgZIAO2uhnFGKVut?=
 =?us-ascii?Q?Ab6qB1iYcu+4nIKAwquUOw/DCj+biNFzB9x1qOQwkl8cs+vIaGbeTvKb/CrV?=
 =?us-ascii?Q?b6SX6qIQJWzDfwOzIheq6Dy//gOKfFNdIMF0b2ZUVNfbDqgDy1NlpO+PgTEd?=
 =?us-ascii?Q?ebQV7G7FEK33DYN1pQQPfxwqyP6SCoJHNDhPWnvYPxUKTUFnKTeGvxhF8bTF?=
 =?us-ascii?Q?eTL5Zrv/8Na+Cew7Hoeufmq0MziD4ljQn6Enb810UUVWtcPMpFh1cLJhvWzI?=
 =?us-ascii?Q?rF9wSb1uOEksAyP2Ye34XaM3zDGYh0J7elIshfIJ2ssYW0xXvXGWciJFf7Jd?=
 =?us-ascii?Q?L0O7wW0LYnrrtg4Vcm3mPHVWJgMcMT2uzV8Lyq4fXaYt2WWOkqF2guh4S+jw?=
 =?us-ascii?Q?rhSROI40xEskwg1sT7NtdtGxLnqeoKe/7rS4l49chVT3KQvuU/JnmsjrIapa?=
 =?us-ascii?Q?pvHZplOxQSwlgeVLbgVlJC3WWg7nKF4C8xCgWqeQt1sSKfbLS6x/Sx+v/+xW?=
 =?us-ascii?Q?ddaU+gTmiqtheetLWmAQ4Uc6zFN0tvxXR1LPZARB+mRd28PMk14tH8Hz24ZQ?=
 =?us-ascii?Q?gKWHavNyj/+2kiIiiYyDbbKZJVFh8eJUXj2Lx6o3eKGfLeeRdkUYqi9zdtT9?=
 =?us-ascii?Q?mQqkjPF1uqDpBRqD8LCR1PJD/jBTAzusLObiXjZ+mftmgejI0JTvxgFUhBwv?=
 =?us-ascii?Q?QKiJHstZUvydpKJbH1nOrRWo9JmrPTPHLeHP5ETpMo9GBHjioB878c8Aukr+?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7diWtIWSnpWdOn8gLzKsjw1r6EgQs7VEBm/G+JGbVWV5NQHP9BKbAoUVGC2efBZI1tu36k/aFqCxVCuzSUv+sXh7qRvGrhIuWxElSkryvkeHNnRjpm4sCQoAa0bfxBcugnFWMzJY+z3ZLW3/EgsHD0BN7tl5jzMTb6EyQsfE/0W8562cC6u+raq2HPlLSlI9Cb3JZog8POpWwHbN+nR2H944ihz57ayLV1id+rz3p+54gIY/NfnOBO05jd6yI0JqaTkDR+YkhFEjV9uQyjT30JWWDsaFysPIihvEN0KllFwcsD9r1lLGhe2OBTUPUlV/LScs64J2wr+s8tSVmEwumGwXiK5ZHvi2fTn6pqomwc11Fp0MVfn2ZaqKOrN0TZXIlWG28pHPYjYZGPK18XKvXxXHQvU+ocyCAd+F5WagJBgVrksBAi3oEvksGaMIPLVK9X1gMmEUP2gTXMsy8gl7g/FIfmSanQ6ePxhfdwLlHH3LTG/5eyB+9xnHZFQD33EhVUnDOlfLeCptchBj88UZV963lQAp7A9f/Y4MBrbkwNO04vP0125RvEmxUxqEov4iZQKPpDtkvKS/8vQkVC+HHHTk81mwW5aXgJCF7vN3mu5hcxfDUoElJMAlFaXbyR76sjHDssAN1u/i04qTNIM/JK2PlMZ7QkXfV18bNW/20NBtXPBnQCjz39b4+sj1oPnDK8HchjCKhd7aR/A9hXYIjUe7OgG/Ty8zd9vTqTq3KhgxiBB9ClGSEXyULkm91c2O4/ZS+WF2jJfVoQvrVByBsgJDgoBn6HwQNqLwrJgtoEdjb3t9mTsa0oKfnyFudiU6hAN5/LxclTWgEuLXLxRPvqFw5NWdZ5nQpyjRx+BZE0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1e40b6-cd58-4dc8-5553-08db2b8376c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:23.8507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tecVkbeST6134Fp47BGqQQdKOdKofAydwky6TZZ+q2FzwGixiTlBudMrA/kS8ZXikIiOMNpSEvGZBNF7rPpmKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230073
X-Proofpoint-GUID: -fYRznUDkCSPDpET1p_Lk0rPUmDaaMrt
X-Proofpoint-ORIG-GUID: -fYRznUDkCSPDpET1p_Lk0rPUmDaaMrt
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature to block queues is quite dubious, since it races with in-flight
IO. Indeed, it seems unnecessary for block queues for any times we do so.

Anyway, to keep the same behaviour, use standard SCSI API to stop IO being
sent - scsi_{un}block_requests().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index cd05e2f87417..f53f3e78aaa1 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -359,7 +359,6 @@ struct sdebug_queue {
 	struct sdebug_queued_cmd qc_arr[SDEBUG_CANQUEUE];
 	unsigned long in_use_bm[SDEBUG_CANQUEUE_WORDS];
 	spinlock_t qc_lock;
-	atomic_t blocked;	/* to temporarily stop more being queued */
 };
 
 static atomic_t sdebug_cmnd_count;   /* number of incoming commands */
@@ -5494,13 +5493,18 @@ static void sdebug_build_parts(unsigned char *ramp, unsigned long store_size)
 
 static void block_unblock_all_queues(bool block)
 {
-	int j;
-	struct sdebug_queue *sqp;
+	struct sdebug_host_info *sdhp;
 
 	lockdep_assert_held(&sdebug_host_list_mutex);
 
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp)
-		atomic_set(&sqp->blocked, (int)block);
+	list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+		struct Scsi_Host *shost = sdhp->shost;
+
+		if (block)
+			scsi_block_requests(shost);
+		else
+			scsi_unblock_requests(shost);
+	}
 }
 
 /* Adjust (by rounding down) the sdebug_cmnd_count so abs(every_nth)-1
@@ -5572,10 +5576,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 
 	sqp = get_queue(cmnd);
 	spin_lock_irqsave(&sqp->qc_lock, iflags);
-	if (unlikely(atomic_read(&sqp->blocked))) {
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		return SCSI_MLQUEUE_HOST_BUSY;
-	}
 
 	if (unlikely(sdebug_every_nth && (SDEBUG_OPT_RARE_TSF & sdebug_opts) &&
 		     (scsi_result == 0))) {
-- 
2.35.3

