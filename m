Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510F36C63F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjCWJq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCWJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:46:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C132471D;
        Thu, 23 Mar 2023 02:46:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5htvh010804;
        Thu, 23 Mar 2023 09:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=vTQfNp5u2wr7k5ga6IP7ndOMPutnmoj1QRDsG24TqO8=;
 b=QT4ws+MJTbg5KCYvzzFroldlkgOSI+27qfUv5z64YC4+tDt7MOTHUViGxoXHv6rwD25F
 r0QC2IclYN3GOg6TG521CAtR5D142D0efXcUiQUspp5GCcEyzmBPHbaiY5Eq7xoPsJiR
 mnr0r2Ejue6Ak5pes1UjjDlL23yMDrmmFGD0Xd5Tsm752/EoPZ25W8ukV6t7Qew0Iklv
 RvogqpDXd37cBSYYwuYUqBpFgMAI92LGEGVqEtXPMO8WQaJnak6OuGyi0etjRO1LIUZc
 W46RjMcX29YC+HmRSXEkKbOyauqxVm5CV5HDsZuFC6zKl46VdGRri87NJP6P/NFIWg4e 1w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd433u9hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9cdiH006987;
        Thu, 23 Mar 2023 09:46:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgmamg7ry-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzFE4lNtOnfGrWapfvnjIWSV5ypEmIEGFSZJ08FybFaJ4H/IbBETi5dAz4E/z9dthmhVEPQu317+pKh2uriaYIAOy1ujtZiq/bUZWu314jlc/Sr9dGQEqK09Vo15CMzzvw166lU8XqbcGIGI/WCSgqKtfTRBTtxZgyhYaqMqBAnU4iTK0jxN83r7uZSPHVho+az/c1CIzR/Kt4YeorYYznL1E175gbBS7DZU8jETJWXajvvuw49zJCBvMwmzGoj8iXOIjztPpCMLFDU23xfz14YrFmTPhh+ovoSNHU6C00ZuhG5xvUj9vSuZ3447g9VeAKvoMfOCsJjek9H83vRudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTQfNp5u2wr7k5ga6IP7ndOMPutnmoj1QRDsG24TqO8=;
 b=Bb46B/uLqPgxXNutFnlQB7s7scT+u1288WUxR6gHPXFx/ayZ6HMPQr9hKgzTp8O+TW3nzEOsUtA0PaGcwvrZ9eWxN05GXEbCNVk5MgEAd8VyfAPJpQaXK1ZvAagQ4K7zMeZ/kdxL0S4UsxZ3g73TVVxUB3SawFJovbrUObCe81lyNzQxJ/kB5CrhDxmF5u/gA/eu5hiLRxEU5MemckzMZmiiXnry//aSDN24lL02iIhURnZcZc86fYwyJ0UIG99J6ZYodlCDzihV6k8eTlPX130tLNC3OfrG1XdiEWBUH8NdD60rdrATVDpCfNij2mZI2Fx3SufD4VaETzkZMBbMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTQfNp5u2wr7k5ga6IP7ndOMPutnmoj1QRDsG24TqO8=;
 b=bfK2osoUAxogXo58xZ8dVxdtKAtPFG6kdvbDUc7PsXnPFqolbY91rMkncWxFqN7LUOgfGasEYqCIrxC4xyM5z2txFumaWwRQEhdCRJv3HRmW3/btyDPMEfebhmOG4gvlGkiUzqQRShJyXe4OXAgOOfwTpwDSscZMStguRRmJ0jk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:46:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:46:37 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 09/11] scsi: scsi_debug: Use scsi_host_busy() in delay_store() and ndelay_store()
Date:   Thu, 23 Mar 2023 09:45:53 +0000
Message-Id: <20230323094555.584624-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323094555.584624-1-john.g.garry@oracle.com>
References: <20230323094555.584624-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:5:337::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d043da-d7a1-476e-29e6-08db2b837eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrMAQ1uO4q0KQN7G3DpvMWC+vkWh8OYwMdw1jLRfbAMHBBIo3NHRPxDg6y5mO449d4UMNyki1/nTUSvswtEWgcN1Q6FXZ9agO6plIaNrRObSQQXNd0qc9wVdNaagyOVlk8FKWbh2ZYJ5H5tlBXWeHO7+0vU+ilvm2UW5ucyd3cTK5DHDVVrkn6LxazAf7xoDyz7tOgJC+jwd8kEdSmLz2YCmRCL5gtfHAc9rnvzl+4v0LjTdIWQykJrBFy7h8O08QFu09EjS45THp/CuNCq1b2V8v48IGxCSvnN/ZhJ1gKZjNl3xG1mnBVmOy33D2b4tutxjJ8+SbBHTNCur6AdwVuXZ5N+DgTicYGEhKR1XkXH5E95LfiodrDxmtjD2S0ud3MQE02WuXnI4PrnX2SH4Y3Q5Vccpr4RKKY0c8fAomdDwosfmdSvLKrcBQSMeDvyl+CgDk1rIKKIi/BfSirFpQ08mTI+qgXSb3T03akhAmxqhyjI73WVE4yXLD5p6+ybyHidTZ4PLJ9YqmwZqRLWgjHNlfgzIv9XhzFqnbM2wOpIQzrevpIMVMUN1Ps2h8/F9YF54xvu07nav8Cd4rXyDdDVQKwmtolzjpN4pGCA/g2I+CdQvWJgOotnT+Ke3vGln0n54JRw1Z6/DjMzjj8Cnaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(6486002)(316002)(5660300002)(2616005)(8936002)(83380400001)(26005)(103116003)(41300700001)(478600001)(86362001)(38100700002)(2906002)(36756003)(4326008)(6506007)(66476007)(186003)(66556008)(6666004)(107886003)(66946007)(1076003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HHJ4HRfHe+MmCvWUnCct7iYPPvMB/Rmv/xmZOuzaONgteZQFIdUYLjFtMD/0?=
 =?us-ascii?Q?kJWWRub6kFqJFob1T0QJnNInrUauBYKWFvuANQ6KZXZMijin7hVy6OQ3r3eP?=
 =?us-ascii?Q?w5m9g/5DEcppEZXPr4z7Whoz1c6p0k0QzSxBsK/aZCy6qJDatX6ESWnVwAv8?=
 =?us-ascii?Q?L8bkEZqKyf8q7SbI0rzKKSMrhAsXW4BBLBbu70wPmuWLvXpmTTpeSrU0reMM?=
 =?us-ascii?Q?5kcQM5kspCG9X+ytYPwsQUI8OOVGKwzkU3ocBnvJ2y+j8BF/sKSX1PaVY+0z?=
 =?us-ascii?Q?gBNBTPZ6Z50uVJQbydBh6DYWb7HCXXalzBz+5kmhOzxXktFf33yFNW0wnIhu?=
 =?us-ascii?Q?hgSsN+9tzEQJ+w0PmPlEfIJVVeU7cXLLSRX1nCOxrGh8b2q2B3ggwib4esZq?=
 =?us-ascii?Q?AR7D0X0klhr0Fi7swWL0UntGAN0Osz7GlH+PQ0Ul8dwmpCf1KFk+sbGkq66f?=
 =?us-ascii?Q?vCQyKeRAbPeP5uw4ONTn1UDy4a1E00jJfiFDQlabsEutKpxoi/NMVQw0iprB?=
 =?us-ascii?Q?nciNjsNRkgPgV+TyjkGGZj0goODiy8U8Ez9Y548cYPQDKcjBA2NVqhyfEUoD?=
 =?us-ascii?Q?kfZ1xESKucHp9EwSrJ1YcZoS+zrP8fdTjdzIfsUnoH6IZ0l3caN8yXBFjBFy?=
 =?us-ascii?Q?qnxJ+L907gv0bfM9mdAefZTYSdXYUEQHLDQw2khsJ6a1WLZ7ZWSZ74tlf4FU?=
 =?us-ascii?Q?By4E6gYaFQLOuAdrjpuA7Ht43L2d61O6wYk9x3QpQJFRUc5fPVdAXBr/gcTk?=
 =?us-ascii?Q?TiiayQ/iLkG9NN9cYIRuIaTXEa+YnkESJFqwGM0G1atQSXngz7QxZ5ASCAXj?=
 =?us-ascii?Q?rUr1BukBY8ZA0n/2gkSbZFn5n6jAULtXLUMkygxiofcpfKHHt6UGkJbisOwd?=
 =?us-ascii?Q?7bU4SOcb0GbLYwlMkPFMkP1OQQrNgeXiLHRBkwuhGgdbO02Uu/2saSdmdJyL?=
 =?us-ascii?Q?jeHjFrXwSvxK8NXKZdOOIzTGeA524Sr5wylwMNmQ0e3neju4zFYujdollBSF?=
 =?us-ascii?Q?/VojAz7PC1He8Mj0RGLvpWDGc1Cb2FBSnCi3g5dLcpqNyVk8kHlMdJfYOnkw?=
 =?us-ascii?Q?XpKceV3s2JzvpICxGbklwE9yHIsvD801AoyAc6FlMNnqvbIKoxiTWj+luz+4?=
 =?us-ascii?Q?ZlMeysmN+Oz4hzFsqxklla3P5LcHrX5U5yuIZEMxHBRCyLwvV6n4Q0aJjCGp?=
 =?us-ascii?Q?YBGhYtXGGFGgb3RSCsZXRKMNbMlaVlZYV1pVjFc17ip1Imy0NaBliLRm0rSJ?=
 =?us-ascii?Q?Jf4XHTwe1Ma8QxtZLG3YvR2V/birHJ5q7tD79Vh3TMCWpnwEnKEK5uUmWbYh?=
 =?us-ascii?Q?YLaKGwgaVlcVELO8S/AqRVcE5ZjpP4OuNcsmGbGkIrqdZBR/sa0E4lCOm+Ei?=
 =?us-ascii?Q?2Uw0pUjD3Q9K/L16YVj0REtYwidIaN7QiT9ipqFkxLpOD27BriJN/d0WAbKw?=
 =?us-ascii?Q?tcStGiKnbHGwtOpZM4DNu/QUXqpDppahM8vEycqyyxlZdIARvq7bhBf14ccM?=
 =?us-ascii?Q?ZuHrPn2YwaRZBH4VcC3Rn8TJGEDogDKOQ6j61YoEJyZIW59Z/Yl2GSEmjgAF?=
 =?us-ascii?Q?clNcVgxnzI4U7DWzAUaXy013sm4HEYtp24vcb3wY6WWlwObWis/ROHnwLsk4?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4ICosJD9M1e9LkOTjgO9EmOeeOm3PRWKM/ELiWhPc3hCJCayeduGDbqdxxx9oFtByyUotyhPIj+11XBMCK8Ymh5D1qeFNkmP2rj3Lq7kBur/VnUHwZtUGIaE7mE8ddEs5XWxBGXzN4SLz+QC9kmHHPB+ZQMwPv1VJbNMqiHUv2ycHfQPTBfUtsi80bFgS6zaKmgMx9LahJYjrWNjQcEKem2m+1m3s+ftWhshy5T6njYt1PiF/mn6I1Swqw4B/MWyMDy7ATtHJ8ctFnu1kHCctBOcpTcga67zH5eACEOigeV3nijVGclE06zyI2a/c7cnVW4QPH5+o3BydT2HjSIlQ065uUGUu02qp8ZIyRi7HrvejiBwpWgdHTdrUSFeMZssecj1zNH7DKzL/84Tp0my81ugLFL7XRWBquj92spK7t+M4wHHVq2IplNBPjhuA6W5ziHOYpY6ivRYNozYz1JAZlWCQPIjXHhq+cxefuln8x5Bc+/o2vpdp6WbBJv5mdlykydiHUal49Cl25hqXAUhue/mQO/gL0eLiGDfsWGKWGNQdxwNjAOaaO127HMlDVILcvhwb31KM9zRoIcbvgvUy6AzyzSi3wh9LuurmQ8sbXxgJ0lS7DW+M+YvEVHkZiV9JIL9LY8pJXFTSZBVkLweF4ZyLfPzTjh9V5LmK06J9TFHjojGflAt8lAFM0Qi8pkRHMMAcKyvzKnnDsV5m3kBzITKC4OaqEjxoYP/tWZfICh6/ymub6h9OoShr/XP4UlpyfUOAoGaBOzr05vo6aeIsYWVrWR4A31SOWPYPsL+gQqQ6mYI+WJ8kkW6lX713DzAwk8+gCBbpbcfrjkjD4RNm1EUaLSZlQhO9wQXvpOvdEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d043da-d7a1-476e-29e6-08db2b837eec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:37.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYVvLTWqt2zbgMD/HA6xzd5tVgYIKrXDgkh43s8nUzISHNBg4WeIwoieufY9jvf9zUFwNAxIhVJlwpC/24Y6iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230073
X-Proofpoint-ORIG-GUID: 9VCWR6naogU_ZNWC7KJYdI5J_Klcvydx
X-Proofpoint-GUID: 9VCWR6naogU_ZNWC7KJYdI5J_Klcvydx
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions to update ndelay and delay value first check whether we have
any in-flight IO for any host. It does this by checking if any tag is used
in the global submit queues.

We can achieve the same by setting the host as blocked and then ensuring
that we have no in-flight commands with scsi_host_busy().

Note that scsi_host_busy() checks SCMD_STATE_INFLIGHT flag, which is only
set per command after we ensure that the host is not blocked, i.e. we
see more commands active after the check for scsi_host_busy() returns 0.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 3e2e7f24d90d..8a0fe403e225 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -6061,16 +6061,15 @@ static ssize_t delay_store(struct device_driver *ddp, const char *buf,
 	if (count > 0 && sscanf(buf, "%d", &jdelay) == 1) {
 		res = count;
 		if (sdebug_jdelay != jdelay) {
-			int j, k;
-			struct sdebug_queue *sqp;
+			struct sdebug_host_info *sdhp;
 
 			mutex_lock(&sdebug_host_list_mutex);
 			block_unblock_all_queues(true);
-			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
-			     ++j, ++sqp) {
-				k = find_first_bit(sqp->in_use_bm,
-						   sdebug_max_queue);
-				if (k != sdebug_max_queue) {
+
+			list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+				struct Scsi_Host *shost = sdhp->shost;
+
+				if (scsi_host_busy(shost)) {
 					res = -EBUSY;   /* queued commands */
 					break;
 				}
@@ -6103,20 +6102,20 @@ static ssize_t ndelay_store(struct device_driver *ddp, const char *buf,
 	    (ndelay >= 0) && (ndelay < (1000 * 1000 * 1000))) {
 		res = count;
 		if (sdebug_ndelay != ndelay) {
-			int j, k;
-			struct sdebug_queue *sqp;
+			struct sdebug_host_info *sdhp;
 
 			mutex_lock(&sdebug_host_list_mutex);
 			block_unblock_all_queues(true);
-			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
-			     ++j, ++sqp) {
-				k = find_first_bit(sqp->in_use_bm,
-						   sdebug_max_queue);
-				if (k != sdebug_max_queue) {
+
+			list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+				struct Scsi_Host *shost = sdhp->shost;
+
+				if (scsi_host_busy(shost)) {
 					res = -EBUSY;   /* queued commands */
 					break;
 				}
 			}
+
 			if (res > 0) {
 				sdebug_ndelay = ndelay;
 				sdebug_jdelay = ndelay  ? JDELAY_OVERRIDDEN
-- 
2.35.3

