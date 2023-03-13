Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E816B716C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCMIqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCMIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:45:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083629141;
        Mon, 13 Mar 2023 01:45:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D01VWJ018846;
        Mon, 13 Mar 2023 08:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=xBVeTvLzBsoJHRKo7CEnffiNcOIz9zRSdm+Wg+Lq5Qs=;
 b=tk2hqFK+u2hAV40/ttkFN56/API4z07bYNKTZVKSwXqoExaSo3nnm6UUtydqWTVyRbE3
 m8WE5z34a4lMVGBA7682ycAYIHC+5heWYKKxB/7LK4ycuXH1QIjnmLJjg02s2GKU0KYP
 EjtdUay8TOj9ZCb3boa870D0UhYd6Fs6ayqa0yL/OrqrB0d8XuaKJtD5kkCUQZgOCHLt
 EWeIqSr9U+02KpGr6MtAwCOuqGHgQexavLodSBRYNeRPU6YDl3t8MqP29M+MAiKCCgPo
 kpLKbvJhskPcHqCXaTwYaDM5sg9E7t+zPWN68AmEFqJW3N4oFmW0mxXQUJ9n5eFVy9Cj xQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hhab7qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D80TRs015268;
        Mon, 13 Mar 2023 08:45:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34umkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAe3h5Q+Nsyj3uMWnaRGhPNP9iOLJRIeF9qpsy0zXBJfdORwbkr4+8adPrJdTclRf88t/c53M7+tlrjTH2zxFY/u4UltPhpwMmVe5JgZhvW9AUdtuIU58hRc+DozlTsMh0ibtS9lRHgGByQ6vSCYzRGjPs8pYmYopCLmfKbz6kUiX7An0SQkaDlNFOXrhRCLnaHkxUlG89khcLoLuaiCbF63lK7ULxtqBRH1d3DKb4J4jLU/UnvyX/UUewxnfqbX3YhRnlj2uiZ5DnzR4pyQmfjpbC8B9UNG+ETgUBklFaYr9YPIyBEyIAo20aVUHEAKHQ3KMjAQtg9/6Xc7p3gdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBVeTvLzBsoJHRKo7CEnffiNcOIz9zRSdm+Wg+Lq5Qs=;
 b=DMjfyF5XApOKg9OJWBDjQbNKrUrGFM6VfaxelzpCDl73nMfJ06CSCNV1SFMkaoOJWac+JcAscHjzNzFFkH/TNSkkfNmKMw0/i0qPmJjzS4c8VbohdHInL0jXCwZQmg+gC71ofZFlChD9E1TKTVnPx6vGabArHNJEDTcs412sNlkNnj4Cgz6uSnEmFv6dd1HMGYPD2ZxXC/PlwZl2Ov2DFZT05XxIjuVlBCY7tOgTwtQ6ZFdbX7dJ2s60b+tWPs2NcNSfFHJDCPsz2T8f7nExOAUHwvBxAdK9O54tPTjttFEzKmDXkvPo7BUO2Mjzk3vwHjW2ad2ebDNIuGWgj/J2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBVeTvLzBsoJHRKo7CEnffiNcOIz9zRSdm+Wg+Lq5Qs=;
 b=AoZJ8TabH/QeJEQtFSiU4dYONXQS6jS2NFbuHqkUywCr4X0q2xfngFm+mQ76u2ZUrwl5CfYUk1lCi8u1JYxWuToyNWiI2NhzDPAuy9EjXc0+ahBHBTqGtIn6bYsZN6tnMmXOOoqDUMxHB3IPdaMRRUGwjA2FZ0PscXf+YrJ0aeo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:33 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 05/11] scsi: scsi_debug: Drop scsi_debug_target_reset() NULL pointer checks
Date:   Mon, 13 Mar 2023 08:45:00 +0000
Message-Id: <20230313084505.1487337-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313084505.1487337-1-john.g.garry@oracle.com>
References: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 6efc1876-b7fb-4ca4-2345-08db239f4ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SyrWbZqzjXVnoeIB/KR82OaYaPg/WeHGIS11DYztK8AM7s1d8YwajXjUgDCSKxlEzpqHFc8AhWF0kEqvcKvglrkZAp90gGkXT9bBJEK26eMirE4PeblMR24r/zkRpczJ9mHH5mC7Q9KOPj1cZCUoIBmBZjqbJDQUklTMzeEvgxeeUkbWb1w6qWWo5m77zNPr6pP5cd9v+Tacy3Ix/PxvuAdezVOsVdEuT4znj8bitxePsBA/g9IIqBlotlCCumIIGypomoUfm4TBJTv2M8zaUU2q9TfdhGzbDRla6cCrNK8vh8nZYx74KcvT2OffnEaftqhBSWCK+LTHZU4B2GwE8jkQ+YD80SQoCiSpe7Qst4IiZfPl8DP/ZgtUwHtNlv9ikDhc9ihQIqvmjg2iFGEHX3IhFPDVpl7KrIXZkJ7+2XXr7zG13rh67cj6y5K/RmC0fxJlQ7O4+T5S/omuhU6xG1pdcCEM3+dRhttfRXalp8j602CB10OJ9ZSs/uFx85SGnDIGwzsV/i7LAoru85qm7J97/l7OpksBJub8y9rAGyVcNWvcpsOeXmmQ6aDwY3RV2MdOK2QnaUbBejyHezWkHRglHMBA9WXyjJD9wPs7HDhLYxHKVuhtqaHkcxHfWkVcRvwqhtuiiprmemaGGrt3Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(83380400001)(36756003)(5660300002)(66946007)(66556008)(41300700001)(8936002)(4326008)(103116003)(8676002)(66476007)(38100700002)(6636002)(86362001)(316002)(478600001)(186003)(2616005)(6486002)(26005)(107886003)(6666004)(6506007)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5F5nazqTwaZCzvrjTExfSfGE6FrdR3JnPSHU5KTRul0l4F/L/0QxWVYF9i6z?=
 =?us-ascii?Q?UdM18BLd4e+dsovpyVMixtg4Oe5RqsA4l3pnMO7Vhg4usOS+zwJNhYFQbr65?=
 =?us-ascii?Q?PfdNA21cJvfiwdnVJMTNczc3fjUgElIdf8BbIUaA1DEfKvVEByZDwU5d0BgK?=
 =?us-ascii?Q?jE8wmZSs61+cnRuR2Xf9qvrzxKrtq6/zd/ohUBnsX727DCe59mSdc8t2D7PY?=
 =?us-ascii?Q?c+Q/ODykia6ICcZlstL9eo8jZL9WGhPf+iFSpi31QwWC/Ifh4BA1J3K/O2tb?=
 =?us-ascii?Q?R+CRDWP3wJC/LPIBvoUrUBlPx79ydiWkwxNd2y3L0JM09BBEdVB8rQT+CkjC?=
 =?us-ascii?Q?KNncz3pv2HPijVz3reQ0hI4CZRlHxXN3AABVecdrc6juqB+NWizNKg1ORzLa?=
 =?us-ascii?Q?gzihbSRpolFmvsG0JamLWGsVze5RfGihQU+/mAZMRiZTEyME+OXwqsgPCIWP?=
 =?us-ascii?Q?ZtYHBJsEkVuOCELtZd+0o8kcPfjV68r0tvk2oIf2DCAougp/XWqPhXz6ND+K?=
 =?us-ascii?Q?nQZukNCPBeZCCH2us4MZ4Mem1MDuMMjzB8DQpVl2GXDzjlADbjG1KAxMVtqk?=
 =?us-ascii?Q?Td8fJ+zpdJ4YK7vpk0eVTR1WQqB7tzOGf2y+FkyI3YpIiheCy46795r7sXV5?=
 =?us-ascii?Q?deCXe9WhOkOMPe18v9ISoJ5g9AWGc6taXz7lsAUoEo5TcvXhhLzsVnLWWuLD?=
 =?us-ascii?Q?pbgETfNFIgHDnipWOPVtBtPVzc3q/nGjV1tlHxwy5QvwoSyFgqCe1ew9HBdk?=
 =?us-ascii?Q?/bALUj0AtstenPh19feTrSikwmP/eaLSz/pHyCPRLEldsonkzWFPBnCjPVnV?=
 =?us-ascii?Q?YwHqRgU1743Px8TSPrD2kaQQPNFFHxO02t9oWdh4L1SMzpPdMzN3DISWppS9?=
 =?us-ascii?Q?ASmYIXI0A5VqP/6ByO6IX+geELQEZw95186pCCXrxAESqUDPtzseNZqgX35s?=
 =?us-ascii?Q?JRaDUe8Ja2etbMfFmIZ+A2mlsBQyn6kBUZS1g6I3FKla5UHRLMlbvYVPzaOY?=
 =?us-ascii?Q?CZM9dOJRGrucGP8tAZeZL42mR0V5sR0V24sPhLfE8e7DNkErdgs6s7IocCor?=
 =?us-ascii?Q?trDt7qib1yC9QEohacUXQBadzy/FiUcOqwo8M1DqekgulP8hYkci7oKOM71T?=
 =?us-ascii?Q?7RULSomJNAxKG/enqihZm70AfcM6BbyulvPHCUgnWV10Ko645a9xp89kISPt?=
 =?us-ascii?Q?bsTQXxFGoCm7JBwwEGUkvNauGtgZeRqQp6NQKL2gRjPsFFxUbRWO7rTgXwkE?=
 =?us-ascii?Q?dWXcpfqBfNO8mgbgqWOvAfMypxHGWM7dmkmAtQbct3cfBZr/3ZNnx7vVwIPq?=
 =?us-ascii?Q?qbRO1B0P0jUHG93DyCj35VQfU4Es1KDjnLIHADbhnECeG27XZcAkfzOXNxNY?=
 =?us-ascii?Q?NhsjP5QfVMc+wsii0BK+J9Tw/ibrU0HsQuswfbUYSHaCyVwyMTsrISkKzzns?=
 =?us-ascii?Q?DLrlIoVqDNnfejZ0/pqeVBgy6D7tUXkOUwGFAXHiVAEgo7YwaJcVZToAzv6g?=
 =?us-ascii?Q?dCwv09JnXrUxQ5qHGEOCorwiJZHITnj2f5qVimZ1eWXSCFsHMKawGoB+HcMD?=
 =?us-ascii?Q?iHp5rLytXkAbvrZ16Bw29R+ghZlKzja2Hw6FLl99V0ulrHNwRAd/rpIMLmpu?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IOvYEb8eKcmwbFHsyWZVB3Ewyy+DoNskwFPWaLfcj9lxDwdN7pb3bus9lDawfSgHVl68OBehgcvg8pPUPY8O1L0tbHzhaawM5+E0758bzVLKXf78afyhakJ7yifywvib3jnSAyddNd3Tr2KLJyWYBMhQBwzMg+K6yrdfEKfjgkJE/ucj2OIHTkTNLYuMr+90mbPBqbPUaOLFfPP9EmHnfNOMr2/QiMYjlBaNBWdO1ZRM9nova6RG95HEBaAfmGlXBZV1W13wY++37jUiqtF+BK7EIVgdiHImpNGIHgt7LZ8pilCOYvw2bqZLhGgeSga/Kr0qlBxDv0ZF9wYBWJEjwqxPbdocLehItfkqBhnMRZzAtCVDw+12XSBhw19wKZ8lLM0IJKba6kd53jnyImuII/KHpXT1WMZJjtqN5YmrpcR2oXPof4zZj3W3CcYznIVQBcoI0W6fqsuJKY4AzuIA6kwfMwcHBgy7CTvpzBYnvWHypzZLne7+pyPUhH8pKm/E2eVtld4774BP7ZNZtSj+DfXVmw67C3j4LVSlqiFvqRSZDCFJTp75Rdwb7n9nhaZp1caHXjtg2HCJeF6sJh50/6+Yw9F2S1cv8Wu2PTgWtsf6J8UvTVV1rBKcB5kLTNliLGo1JRMaQQuxNRISUAIgLdufBY6JFBUCiEO8R5OrCIiqeIebdTWpZIk9dw1FAFgEf6C7PyBm99L7IxRfjShECoycseMxodWgXrFeX3VMFVpGvaCLuu4E/C22MbZPs7II/q0VKOMJwRHEi2DbPhcCl7jglzY3O1ybVUIy5MYhuY7MECU/zZVSA+OoWdn1XYH34WBzdWTFsdbPzUKHDDYEnLa+AAfa4M1DZvgyy7AKluI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efc1876-b7fb-4ca4-2345-08db239f4ecc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:45:33.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bG1ywTH0+7LRYN6nD1/BDkyLOQBv3KVer3mzoTHgcGr05Htkz6yOQdr/sZlFhj2eW1JVB++BiuTZ05lk+sLSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130070
X-Proofpoint-GUID: RXYyu_QfbLQIgz2d5rZxMLOUXp8-C--r
X-Proofpoint-ORIG-GUID: RXYyu_QfbLQIgz2d5rZxMLOUXp8-C--r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks for SCSI cmnd, SCSI device, and SCSI host are unnecessary, so
drop them. Likewise, drop the NULL check for sdbg_host.

The only caller is scsi_try_target_reset() -> eh_target_reset_handler(),
and there those pointers cannot be NULL.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 5b51c24f7d09..6364d6f08861 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5387,37 +5387,26 @@ static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 
 static int scsi_debug_target_reset(struct scsi_cmnd *SCpnt)
 {
-	struct sdebug_host_info *sdbg_host;
+	struct scsi_device *sdp = SCpnt->device;
+	struct sdebug_host_info *sdbg_host = shost_to_sdebug_host(sdp->host);
 	struct sdebug_dev_info *devip;
-	struct scsi_device *sdp;
-	struct Scsi_Host *hp;
 	int k = 0;
 
 	++num_target_resets;
-	if (!SCpnt)
-		goto lie;
-	sdp = SCpnt->device;
-	if (!sdp)
-		goto lie;
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
-	hp = sdp->host;
-	if (!hp)
-		goto lie;
-	sdbg_host = shost_to_sdebug_host(hp);
-	if (sdbg_host) {
-		list_for_each_entry(devip,
-				    &sdbg_host->dev_info_list,
-				    dev_list)
-			if (devip->target == sdp->id) {
-				set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
-				++k;
-			}
+
+	list_for_each_entry(devip, &sdbg_host->dev_info_list, dev_list) {
+		if (devip->target == sdp->id) {
+			set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
+			++k;
+		}
 	}
+
 	if (SDEBUG_OPT_RESET_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdp,
 			    "%s: %d device(s) found in target\n", __func__, k);
-lie:
+
 	return SUCCESS;
 }
 
-- 
2.35.3

