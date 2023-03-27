Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2936C9CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjC0HoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjC0Hn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D1D4200;
        Mon, 27 Mar 2023 00:43:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7ZFqX021908;
        Mon, 27 Mar 2023 07:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=FbruwxeZvxhz+ztTERWaYgYRUcNdNyZJpt5tNzAdTFM=;
 b=TWlBOMpWrVgZv/13wwKXBIsJ7SXrzbTdUEXKZVFsHVY2PKwiNar3dpDX8Sxuw+UWXJEx
 l98sUsA+eGHKI8DiNCWl1SDWy02KIcnzXGKS11aoQNgrs45LQ+x8slO//Z/iB3vA/C8u
 RTGXIH1NJCYYzcMx0kdHZg/tXKouObh3sNw75Ws7jrzBdQYQzALp7tpLeXmMQwt/xQXZ
 ZzKLHuDRTVVhEmhY/bPTxvN4s+7k7Ku4+V5hdUtEAVYoT58Xi2S6g3nKzl0SHCdoHFN9
 gAgAHq4G15JGkUm0mevfQbIDVO3Zker2A5bjeXjzimsNMDvYqQFt+WTx4JAHZa68cxzD yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6vmr14t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R66ahp005510;
        Mon, 27 Mar 2023 07:43:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4d5e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiNGo6/N42bQZ0kKlWqK4CueIdagFrVsC39xoS+sH4sMs9R+aCMzo1a9Easa6xY4hz1NmXthA0Nwt3744V6svVSAgpzaG4UAVf3aE6SNBvRKECSoqk+xu8HxnDQnyt3qhNYpH/6R9BoH+ae4EXLgemOfs3xL+z1JIqjqWITiPTiPwagTwRThe/ZhN7K+YpA/1DrtALcge6EccoOFQwWfEYuEgaCMovc3b3z5pQnY53IQbCsLVZGdWJInd7AwONTGMSwR3bOqRVkBjzwN+SGkrDOm9YjQsOPCmB7s+rfMVCAQo9X+HffCFmqb6FKO0qW0bL0gLO2ckkw4+4TkQXW+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbruwxeZvxhz+ztTERWaYgYRUcNdNyZJpt5tNzAdTFM=;
 b=MykeNe5LpW1l/+QzSxTCoDwncMf+jaR4r/OI/cQA6kaydZeSlUCwUmB5P7xz3Zvs64VpkjUaSRzKnl+iL2T5bvFwrlN8qYq0FO7xLYnPbxd3slf9bHGmBVSxi7kdIjrEDWW68cu2MF1G/rp0EnTLlzEZUMfnj78uDX2DFVh1Yu+TQK4LHiiM0b0D9IaIKwziLe97rlDIBoTkTr0mf9nNgYoWviBtRmFkWKhrkSvbb2dpu5FimS+49wTmkQc5MCUgPRA0iRZIIfGoVQ+Ov5IHqHyH4x4LIiYLz82OZAM9p/mwrpl2m7VdEdDSHF0Iwa/qT9wsw3nC9tO0kkJdbrqHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbruwxeZvxhz+ztTERWaYgYRUcNdNyZJpt5tNzAdTFM=;
 b=Z0WBZ0j6VHFgaMF1TU98zb4pFpsnrZ2/hqY24rXDVkiWcXnLyVt+vPHEjkDmpu+MzK4hyBAEe35TZC7f4yS1Ye60W0WYBC9to4yR4S45cqHQGVrR6JENC5Xhnj7ZSqL2CVkQk2xMWwPkx+GHNLTshGmld+8LTe8OZMP4VIJ25Po=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:30 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 08/11] scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in stop_all_queued()
Date:   Mon, 27 Mar 2023 07:43:07 +0000
Message-Id: <20230327074310.1862889-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:5:330::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 52418e41-9b66-4455-d104-08db2e96f55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJseONH8OLwI7/Tp6nGhKNa8dJYIerbGB7S97xP2B23g/E/WjWG0DVfO1rRZZPlbXK2ny816v/ZsCN7g8pAQiCDk4CHF/ZR+0z2kk73jSEaoiaenuSfvkjP3zE9vqgPtwb4o/4+9gcZh32wAVxnhrZe9nLPwNb4ppmEayYQuVxK0SffOSCriZMulHEM7OWZUE3vu1VM3GwvMxbdqnDmMwg6SYx418E9ZD+szUJNlO2vtv5k2SP+CTU64T6Go8OzPSMGlDDD5gjKCLhS1QMGyWxLkm4FQ18ZU7rQGi/4hCbqefw7BWzShJNRD4d3lZvwX6CdGWCB3JcLMo6Y1HTTlZf1T2Zh8cLpvlc8GDyavtl1njoUpUT1KMharwtWMOrueOMFYgjCAWlbeu2Up3AVyLBkjmC9EpS5CN6rYNSZOON+ftM8IeC4gya52PdvoATK9IWKP/QqS7I0jPj5I+JSudJ+gK5n+PVmBc8Gv/GYkfkr1VIuzddzHDPSUVaWWdErxlukSjSOOjfV9a4cvzpCmcpe0VAKho2pPM8HhdBjvjJmTvEv5XPW4deCzkmh085Wl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(6666004)(107886003)(2616005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Id68dCqrTcLzcS6hKX9SX/ubq3Zj+S3f08DVXbpt2ay0J3ZPZzJAyp0/yqgC?=
 =?us-ascii?Q?Ubd0D6fWxeyPDx0pivhhOtgOhhOszyAWiC32WIKa/7MWWSfNdSn1CfLw7HiJ?=
 =?us-ascii?Q?jYJA2LDqEAW4UomupFeid52+HaypzCVWVTGnKcBxjASqfJ3DnHB/tKXqFVya?=
 =?us-ascii?Q?7mpi9fN6JS/8NYV20u26hAAeaMaoqY6/FpQG3PoZ9CGVMxk+7/H5JZhU+kX2?=
 =?us-ascii?Q?vteayalP0XK9R1mjPrdet1D9TTGiLKW5n+nzlEmcmHcPgOGBzBPkFEu5gpPG?=
 =?us-ascii?Q?ZP3NGv4DIh+TGuBMsNgGWIWMtc3ethNu8NPJdRh7AzbM1aDNyA9fk6/rDv9/?=
 =?us-ascii?Q?M2b7YFYuEHECEuvzonTEza4YwBmxH31MW7oiOZYCGPmQZrVE7Qjb1Lh/hOkR?=
 =?us-ascii?Q?vu2ULmxl2sVwwZbp4kKvJPvpQ9+h4WyiU2deDnu4lPYuOFaRpDLM5O32/XTw?=
 =?us-ascii?Q?buo47nYo6XWjk+8gkJH0VxXBm9FNw2/SYcqjiu7iTgFnTtwXPPRFZ0s8+ymc?=
 =?us-ascii?Q?duBXFdX9DnMNkYMXK1Fb7MpfCsHTSG5+aDg8+H+feioHQBRk79jEYiul52hb?=
 =?us-ascii?Q?lJtuXX1UJ61k4mqjPA7h1aupGcoJuwVsFN+ycmKP0QDqn1ZYeKhMM45l6nz0?=
 =?us-ascii?Q?ZasGLM5uoJ0HV9XxP6jbFgLrvjjTCDUQwrnZzL4n1Wq+yM1ymrLmyDsMO3oz?=
 =?us-ascii?Q?F8hdftOL9mpNAbrWr5vf0kW6DOpwKcI0ZVe3t7fAlVFbn8/Jf/gljuJ4GqKi?=
 =?us-ascii?Q?ZKgD0LhCKMhvgpeLCZNWeY36Kc7S0WcBynHv6aO86ReGE1o9SKAnbfQfBhAL?=
 =?us-ascii?Q?N1FXUaLKsVUKzoKwTF7lJexhQ6Fm9lNrut506/4XRprZC6i2iSCI8OtSAcWH?=
 =?us-ascii?Q?XwDktWtsHGxJsK+/F00zY+5Bg7U6UYkfMcSneux7Qa69Y4dOrOjNKdkVlBN4?=
 =?us-ascii?Q?adja7+FQDBNR0xNVgFvsWjp/6VSTXyt96IcRVds1Yda5A+UQyRbolWyCVcne?=
 =?us-ascii?Q?CT8ylDWwOx9AVyjkk1GUwRMOW/2tHv7j7QWYONmNNbH5P2rH6ZuUmz+/+8dl?=
 =?us-ascii?Q?vdmz6wW5CP/WPS9bhXtrtiVARUuImNWkHokqElWxHwMqMCaDp7I5nb5Hv8my?=
 =?us-ascii?Q?4FpzzRznNlMwBsIhcMKsYtQ/se+hv6ivCJc3grQUdJ33ufySyb3YsjRTQEdk?=
 =?us-ascii?Q?+H+BBcUFu5/Tjf/8M08ncGFlndDr1GMBghsgKkKXuU4xeCwxL+tT0hJsAmYb?=
 =?us-ascii?Q?0a0Padm74LWCI7Vn0aRg2ofCxG+BuL9X5thld8A55gscINiwHScJiENnkdkR?=
 =?us-ascii?Q?EScwFDTu//XJG2eG2tLrE8VYbzx3zQ6rIItUNC5I/SSJznI8GHRhxHWv7OkD?=
 =?us-ascii?Q?BGtxGBEFTA478bH082/IpOvY5ODqxtJCCjl02JfV9iHiTPlNAN7N51JOjw6c?=
 =?us-ascii?Q?vF9vRdFZ0BVgmnr8JdbXJHU0XVzHJSxNUgFrD8vysVFh9H/MMR5B/QiAizEF?=
 =?us-ascii?Q?2cWcZw4cnrbcq3r2dGjrAG++tlN2MNuBOu6EwIfNY9LM7/fxHQa9UVZ8dvn0?=
 =?us-ascii?Q?ye1EpFfkonKOeEIN6ALC8nXH9ekNiR6EkBONWXzF6lDqgnd8V0diANRxDjOG?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BanFRSTfZ9vmwNFos3AuYYkvP6QjStA5UXRauX8R9QcR9S20SfvMW69AAzAm4Wje1JsUGVFuqoeLTGZfjqhIBMPMWMaiUHbXfc2ePfnG9VgLZO+oUTYv0FWbsZi8cTcJOJC2Qp/3qWKLh2j8QhWMEgYUWlDdCKFNJiEybKrpKhxp/llV54bpbiWDYxeK8fvWxsWcmFFyCkfeWlkRZZjVIncckVolPaetfo08fq7uphLmug6uBlgcMnNyRWNkN88qZ0c5rznyVGSUuHLdw6j1oWYfweKQux6W0MKYmTwNgZtzABxTgDTrmQ0tJoq3NT043hKStjIg6T8/S1NyaCiRNhjdVXeWFjbF8wafSr7RhKWD9KP8enLGB+CBMn8Up5BIfEjv5E8K+LAASTw4KUhOKRKsfeXBe/bP66ZWgq3Tl+VZIHI1z5Wyt7622GnWslj3XYJ7DUACHWq6tFMPSA2AS9tlnUMs9HspWbtrXMaWgoHw1vij7Dp6LrvgjDqwUaYs4SF2kn8cuwkITl/dOK/CAqCyQ0k2RLaVWxuUMX3N17qTnyKVhyvFHD0HYytIEz7s3EkypK0gizO4hD83ix+i1CtGTnd4XyVyxqBvRfKs2Z0EYhi9SvZDKW9L6JA0sSeji934Xxu+RWzt9+KFtGSXxR1Mv8W8AuB6U+4FKTIabquYquHEarVLDyMUuTlhwt569IxOHvpUmHD+AIlRYWX1HLgtmkKYMlZUvRqNj6CEarUyYt+DEEucwu67JGDOiamxPXLO2iacLutppAplz3TaKsHQMiai4OL6Gp79Y4wecQxdJAOwUbIfnu9Ztz+o3GszjdURjKCc6ZvTVOpiRZGthzXHuW1eHTfK8NWnXw4hFP4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52418e41-9b66-4455-d104-08db2e96f55d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:30.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUhT8KU26vfW8qS1XKfZ+MgGRHDSQD5TV6ZRK072nqmDpR5rwPCl0YfUwzAih5OVV/bV/LX8wbTWWaUFuWtf5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270062
X-Proofpoint-ORIG-GUID: KDNLsvIDvhklt04hjN3jl4BQZb0G1LSa
X-Proofpoint-GUID: KDNLsvIDvhklt04hjN3jl4BQZb0G1LSa
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of iterating all deferred commands in the submission queue
structures, use blk_mq_tagset_busy_iter(), which is a standard API for
this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 45 +++++++++++++++------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 3330848f13cc..677fb177ccd3 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5326,40 +5326,29 @@ static bool scsi_debug_abort_cmnd(struct scsi_cmnd *cmnd)
 	return res;
 }
 
+/*
+ * All we can do is set the cmnd as internally aborted and wait for it to
+ * finish. We cannot call scsi_done() as normal completion path may do that.
+ */
+static bool sdebug_stop_cmnd(struct request *rq, void *data)
+{
+	scsi_debug_abort_cmnd(blk_mq_rq_to_pdu(rq));
+
+	return true;
+}
+
 /* Deletes (stops) timers or work queues of all queued commands */
 static void stop_all_queued(void)
 {
-	unsigned long iflags, flags;
-	int j, k;
-	struct sdebug_queue *sqp;
+	struct sdebug_host_info *sdhp;
 
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
-		spin_lock_irqsave(&sqp->qc_lock, iflags);
-		for (k = 0; k < SDEBUG_CANQUEUE; ++k) {
-			if (test_bit(k, sqp->in_use_bm)) {
-				struct sdebug_queued_cmd *sqcp = sqp->qc_arr[k];
-				struct sdebug_scsi_cmd *sdsc;
-				struct scsi_cmnd *scmd;
+	mutex_lock(&sdebug_host_list_mutex);
+	list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+		struct Scsi_Host *shost = sdhp->shost;
 
-				if (!sqcp)
-					continue;
-				scmd = sqcp->scmd;
-				if (!scmd)
-					continue;
-				sdsc = scsi_cmd_priv(scmd);
-				spin_lock_irqsave(&sdsc->lock, flags);
-				if (TO_QEUEUED_CMD(scmd) != sqcp) {
-					spin_unlock_irqrestore(&sdsc->lock, flags);
-					continue;
-				}
-				scsi_debug_stop_cmnd(scmd, NULL);
-				spin_unlock_irqrestore(&sdsc->lock, flags);
-				sqp->qc_arr[k] = NULL;
-				clear_bit(k, sqp->in_use_bm);
-			}
-		}
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+		blk_mq_tagset_busy_iter(&shost->tag_set, sdebug_stop_cmnd, NULL);
 	}
+	mutex_unlock(&sdebug_host_list_mutex);
 }
 
 static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
-- 
2.35.3

