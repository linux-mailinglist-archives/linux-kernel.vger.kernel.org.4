Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41876B72AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCMJe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCMJde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:33:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA1556531;
        Mon, 13 Mar 2023 02:32:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D5f8rQ006522;
        Mon, 13 Mar 2023 09:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=AIiTWATWPyFuTDZUG5HFf0bdHkWMXoIf2fbBo+ky270=;
 b=VEpKMk8VnwlPljM0NTa4AnFFuedCf3d3AUavxwG68fvLFnLGdq0dGqIyRzWa1nffx9Au
 L8b8WCjXrHrSR3cGfTIXke2rW0hxthwGebQcW7fYWrQXD/1v/vDQQZ8167h9xkUmjX+i
 zRHx+UJD7U9Dc9/pY0pssdNTCmdw1smzfhp38ixdkxIaeUeyBxQMJxPq+Y/7xhckhH/F
 hZKCFep502K+rabzAnPRP0v9u1YUCW6il7OGgAvvXXVqXdHrJBPfTNJxJ+SrcnZP4iAj
 ST/2e3mhx2Gt+NFzzL5fTXVx5typH04/2SAK+VenSaGailuN4GARm9YKejX0RFFPS9nh 8w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8h8tbat1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:32:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D89ePv025072;
        Mon, 13 Mar 2023 09:32:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34d323-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:32:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUTHc2FFusLENzDabu/IaPgz41/vJmiXIZzcDiBI9R9lSpRv6g65QmBV8Hp3H1yPC7vNJkLBHlOaSRKjSZZ+1jEzoIrDcX7TTkTvpQVYjpP3yF3bloM5uWpnue8WZEX4xXAeBGA5RBPHlCnENGgZP02apsxXiON9c5aHvvmpKTMcQxS+s3SdSJPy7heUH9flqcS7aPvgf1V+Vr8RTWdjL003+/s9opJ5s0FeFUU6MjzMbTxAFXB7w6ZK24javr3WJlO8p0AwAekWGbIfErEPxCHIxV5XG+260mI9LOKzipAZbmlO8VwKc4IU6xkSJeOYqcR/rTCXatbq+eeCmu6K0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIiTWATWPyFuTDZUG5HFf0bdHkWMXoIf2fbBo+ky270=;
 b=l6FRNnEsz+nMhoCqj4Fkq+61R/dyUIiCHq+h7oCTZYY2VG4liSOUOSK18C16thNeBeMcY6gOLzrcEERRQbfqlwqmOdBOJWXPuHICKXYt70u9fgqg5aheN9J1qQ7TNZ3FdhyMzZBJ9gFR+dW4U9raUz2R8tdB2qrBX5zKzMkKVA3d8UrIYhBHB++nVPlyUviBr9ZM+Kf9fc0wvtYc5c1xR8Fn5CBi97FM/WQGz+RuMiLvEqDgE906fNNDc7CemaX0lrd8eCPJfKwZLnoGEjhrAjGh3rHhWtK3kaTlMdCXkUttSoJpTzmFtk0wmakGriy3YvYMajCpIfkjPd3XD6ax+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIiTWATWPyFuTDZUG5HFf0bdHkWMXoIf2fbBo+ky270=;
 b=AuMQmHCXsgfxlZRd5inI9JA57fq1ueFP/6BIcq1NaqTM5ShRFLzoTcgq/1uKbbdB3kyGemEm9mETRzQvVGgERpalWBXh8c+tMnlxCa5Q0xUZMtQ5AH5KCbeVZqVSYW2sypnP5TWlwC/0GdhhCgPdqRSKiVJLb0rIJTwDIHX2PFY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5060.namprd10.prod.outlook.com (2603:10b6:208:333::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Mon, 13 Mar
 2023 09:32:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:32:03 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 10/11] scsi: scsi_debug: Get command abort feature working again
Date:   Mon, 13 Mar 2023 09:31:13 +0000
Message-Id: <20230313093114.1498305-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eefe6b7-4c33-464b-6690-08db23a5cd81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBRwhbzmKcLa7wxybCVRmh+A5P8AZMoUm219tuqoTV4DJGPpFef1jiIWrk9n8NmBwJ3Ws66uBCe0I24uJR4g6xniRQVZWOUf/uh7XgBXHfu/eEPt24/+SkmsCp64K2OPpl5hLfXixueiWdgRaja3KpR8ULORFKKeFcsJhRj9X2YDk0evCYscAmhFNIilJ31sTSxTZhRPPghDs3utrZtU9/mD0GGqfJ3xPlNtxmYl2w5v/dbV5cq8NYtYQbB6KgzExs4z7mCbBNdTBjbzcnnUNJmHn1T8/n3JDZzEYMd4YJoT8wes4cirThCXbi1P38xrBhwX84+32nMLUv+y1vtceVvZ1rgVoKlnHkseJwxAYTRXHHehqgpGy8g8fW4np0EbuZ3iRdPO44Xq/oeFsxoPk0KMac9j/Y14OcMUjqIQOGrBm2Ipwy4s5HQC6KC2mVdfcSQUDUHmxFDAXSFD5+UKPDtY8szDuDNisSqag5fmqOnQ2ipU5MEfq/J8AdQQVucNiFmL/4lsMTJWDCtgxKuSxUAhT4faDr0hJ/a/cl9nzzitSqVsWygnGZi48Z3UPUQGuUG03EhwoEmv8XQLEgndhHNCdoUheyyzllQUY2lR7GaIZLd+ap2LXnRSG/amb+pIQFossnfRulQrAWtGp/y+GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199018)(2906002)(83380400001)(36756003)(5660300002)(66946007)(41300700001)(8936002)(8676002)(66556008)(66476007)(4326008)(38100700002)(6636002)(86362001)(316002)(478600001)(103116003)(186003)(2616005)(26005)(1076003)(6666004)(6506007)(107886003)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?azplPkTzzmKPDMvRi+frb1rErengZTK57h1+ihjcuwKXb6FIZ1x32zAzwsoV?=
 =?us-ascii?Q?en5aocaz5hPo/o7jIotjgWhoxXZ+Z06QmMj2u4JMMqYK5pbMSzWBhHGgK/of?=
 =?us-ascii?Q?ccWAP/jUm7XFwyq1H2WUJ7Zvc8wF54l0AzA1PrxP3e/7TlbnUMDFL4nCHv2/?=
 =?us-ascii?Q?crvn80535TVymKwkSGwv1vQwFGe0Vg8DPkj3tAbK+rP2zhcf5fW/ulpCNQ4T?=
 =?us-ascii?Q?YwBJ2ENWKQqQHzLPSmqkKXcGqehFPiZTgM5qJqufwPtSsgeAGSeIoLSdr76t?=
 =?us-ascii?Q?65B4sn0gtUVYp0Nuqll16PRRsXHjhW3klBBFUnlAaLLmFFnnn4ggBdRyeZ3g?=
 =?us-ascii?Q?TbvCdtqGGqwQC0pVmXMEeeN9ACPHbxqYr9YEaIzyeWDiGUzKJH2pbAAw3mGw?=
 =?us-ascii?Q?kQAEbclq5ENXGc4gNRvb+8IvFIdsrsZFY5Y6McU7E19WIMnJKzSvY3BObrOo?=
 =?us-ascii?Q?P/zuZPf/8HkFKnoi9OonbrbBcRUciLsZQBx9V+D2DvWfr9VyeasrCMMXghqA?=
 =?us-ascii?Q?Gc1//BVWtDb4KP6Nr2/GZfY3ZttL2mPOtvCk4+4rlzqpQ5EWH50LtvSVz6b1?=
 =?us-ascii?Q?gLY9bFZ9BnLRgCsnS5onDgiucNpO4holSdVo+BTv6wgHGg3gAEcCCmv/YlDq?=
 =?us-ascii?Q?+GBVJAhrZzBKYs3/5Ohw5ctiIPh0q2NcnfbygyO6Z19xi/jXapeAMPO0PCZT?=
 =?us-ascii?Q?hVhDsvRMgQheCLPYM+sDfthHx9mJ3+pLuNMO2drpR+HGDaaBAZL80TwX9BFw?=
 =?us-ascii?Q?kn9yoeHTvn4oqVpetSoCP9fKquwR4kADFPysj2g1eIacrays/gmcIWQCzxan?=
 =?us-ascii?Q?UcrqmY8Dz2N0/5EtyKO5MsB7SR6AA4VIejsSLEIothugs1B9hdRb+eQRSXwP?=
 =?us-ascii?Q?VLwA0IvVaBPbDjAtNSKoKAhkwosrvlkVY/NbRgC9lxI3tHGQU2MP+UnIGpmZ?=
 =?us-ascii?Q?4PQSHR0cw/hdtxYm4tses6rphWNUES5qEe7bbsN8PGZVUXgSTTua33x+GaKy?=
 =?us-ascii?Q?mh0h6KloSbbn4/HgzUiDB5D2l6Mw1cBOA6WDyj79SSgbU9ebOchSyUs4vPU2?=
 =?us-ascii?Q?auZqp4ysUyQr3PWDoQlJkKsRn684lSHCwgiqg5Ik7xRbmQQNRnmIeLtjyX8P?=
 =?us-ascii?Q?UGwc9URlsLDJAMKZ2UjXCvUWxzAt5JwJWQ3eFk5MdBXlEOOnQeAIelVY/v0S?=
 =?us-ascii?Q?THgCzNObxS1dXie5cpnxus3OTUCPVX2l7YQvp6cVjwmZKTkVYBhtaYyxQmE5?=
 =?us-ascii?Q?bXwHEQ9Xi1lkLEcXiy/EKhga0XmlIFbcIoSoHgf2V4YLFDutV/PxLOodGA0T?=
 =?us-ascii?Q?EumH/QGmWpSAYPr1KS2+7xMtnn14CJYk4yAvqc3hxD74Bosb/i3wfisbhVkB?=
 =?us-ascii?Q?ayzS0JAP+ld/E1oH3WGfrV6tjxCESxAashybWTphMXe9h1wj3V5FPNHYrP4b?=
 =?us-ascii?Q?/wax4OoCeuvNKcpDI1O1QiAD/jgBi9f1oN7GYT80x3/d3T8PFJr0zA1SJzKj?=
 =?us-ascii?Q?ptVf46mbQo8LEdir4Qyqyx8D+Uf5AgVuj+OIwmJ9M9NfnPwJ1srRsELu6WVN?=
 =?us-ascii?Q?eSDpO8MAJO++xEgIqSnAP+VX/gRxAmkhrvccfrmwxfy7prV3rtbEhmRQE0Zc?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Cw3/5c0/7HR9Jmb+TPJt7G3ZiyaQOlyA1ntvOVSTZuOXUTZriZMUScPbgPjmYEdbgGnDTH/BN98upD/QV01bWd1nOaSLyu9BnC5lkv9dYUdZWkMCpo5DjtEbdaGcK9H58nua1Kv4AS0foyZJSZZ0M1sEEkcD4O9FQOtL2JGPCHTFNpLpPpx+QW8A2v94ic/QfuKGWM+8P/jJtBivZWhgBNxcA4E+ojMAQxijItD2x2C94idgX2hbZ/j4OKgqxB+z5X+9gB2HustY+KpnBa3lbrDTOytKtMp/QJE7GedO66OR2fye/Ff+eBelTZFvvPWez3yifiVcJp0gCKuYcmSToYk/lOVHSdsXPE/WWAQTLO+wfTNAwcr+6XNY70PigkiUOJgNAB2OmwyRW1L+R3GF9utoPWLdROYtyo5M2OBiD/L2mPG7xZ7UHUoyraTKtwZFXvu9gCVx2KLCYRyaIrkJSfaK26XEPhh5LuSrHPUrFtR6yEHKmIKaTsmaWbAXzf/0EYLZBI9bHcZEOcQIPytsJhe5h489UbC+A13R/mWcfkzmN+CLrJF9GDjBBEYXAdEByeSPCzwIDo6mki44chOTcROHo6xTyXQrywq/PizE3/W7P//MOmokd1c2yoqFiKdnQdMm9gJRqhsb6ON1YZjM4vJ6y28ldAAcTYYwos+H8iYCK0+emsalyCwvUlPqPnFJYIAqZjC8vjB62OlXtTofwR+Z/adnwI2Wn+WFXTKCIewpEVBOEWSoIRw8n8I+++V2zcQF7oAlOsXkwn+nLu3SGJDcdpCoZ1f26YhbFr7f26pCYYo+gSioS5oRPDZHeV89iFSx05ESzEp1B+g+4NeylhlMVegbp01wPhQlBEQy52s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eefe6b7-4c33-464b-6690-08db23a5cd81
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:32:02.9786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3Vp25b33RL0kQjPz+dhHqG9WD0BR93oUS809xSifBMJAh2WPgtFM3f8yLn7VNxO4l/afferICegxBrPArz/Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130077
X-Proofpoint-ORIG-GUID: RxDIV8qTdUMJnMIM8kpD99iDWVs4SK9q
X-Proofpoint-GUID: RxDIV8qTdUMJnMIM8kpD99iDWVs4SK9q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command abort feature allows us to test aborting a command which has
timed-out.

The idea is that for specific commands we just don't call scsi_done() and
allow the request to timeout, which ensures SCSI EH kicks-in we try to
abort the command.

Since commit 4a0c6f432d15 ("scsi: scsi_debug: Add new defer type for
mq_poll") this does not seem to work. The issue is that we clear the
sd_dp->aborted flag in schedule_resp() before the completion callback has
run. When the completion callback actually runs, it calls scsi_done() as
normal as sd_dp->aborted unset. This is all very racy.

Fix by not clearing sd_dp->aborted in schedule_resp(). Also move the call
to blk_abort_request() from schedule_resp() to sdebug_q_cmd_complete(),
which makes the code have a more logical sequence.

I also note that this feature only works for commands which are classed
as "SDEG_RES_IMMED_MASK", but only practically triggered with prior RW
commands. So for my experiment I need to run fio to trigger the error on
the "nth" command (see inject_on_this_cmd()), and then run something like
sg_sync to queue a command to actually trigger the abort.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 449b460e4c1b..1463e54179bf 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -4983,7 +4983,8 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	if (unlikely(aborted)) {
 		if (sdebug_verbose)
-			pr_info("bypassing scsi_done() due to aborted cmd\n");
+			pr_info("bypassing scsi_done() due to aborted cmd, kicking-off EH\n");
+		blk_abort_request(scsi_cmd_to_rq(scp));
 		return;
 	}
 	scsi_done(scp); /* callback to mid level */
@@ -5712,8 +5713,13 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 			sd_dp->issuing_cpu = raw_smp_processor_id();
 	} else {	/* jdelay < 0, use work queue */
 		if (unlikely((sdebug_opts & SDEBUG_OPT_CMD_ABORT) &&
-			     atomic_read(&sdeb_inject_pending)))
+			     atomic_read(&sdeb_inject_pending))) {
 			sd_dp->aborted = true;
+			atomic_set(&sdeb_inject_pending, 0);
+			sdev_printk(KERN_INFO, sdp, "abort request tag=%#x\n",
+				    blk_mq_unique_tag_to_tag(get_tag(cmnd)));
+		}
+
 		if (polled) {
 			sd_dp->cmpl_ts = ns_to_ktime(ns_from_boot);
 			spin_lock_irqsave(&sqp->qc_lock, iflags);
@@ -5738,13 +5744,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		}
 		if (sdebug_statistics)
 			sd_dp->issuing_cpu = raw_smp_processor_id();
-		if (unlikely(sd_dp->aborted)) {
-			sdev_printk(KERN_INFO, sdp, "abort request tag %d\n",
-				    scsi_cmd_to_rq(cmnd)->tag);
-			blk_abort_request(scsi_cmd_to_rq(cmnd));
-			atomic_set(&sdeb_inject_pending, 0);
-			sd_dp->aborted = false;
-		}
 	}
 
 	return 0;
-- 
2.35.3

