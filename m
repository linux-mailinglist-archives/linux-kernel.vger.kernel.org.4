Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C516B387A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCJIYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCJIY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:24:29 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A5FA8CC;
        Fri, 10 Mar 2023 00:24:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maYJWKLGfXJK1xEoQgq6J7Ic2EL5msGt9Ut1Bb/pw3vtHnm/TUTwiV0wChIb8yXL62ggEZaar0U7G0oLwPCDMABdtM0ilINcAKJUb2E6ou/YATS04Vowb607npnQ0bnKCWZMCYw5dPrhp12epiLM9ef73fLXcPWyl8uflrW+kBtfcRXzLV9wKpiyX2qy04Bf2ADc/u3GH9FApWn+0YkHGQJfzLvoqehmFEcIoHVq7fyvYdAs5zNlcCtCsvTr82kPGYyhBTbVsTU44gQGFBnC5yu1RVj/9IQdJskeSV+roFc0vMFIBdW9nmHCYeZWTgfflIwDpBGGLcHXMv1+T5H72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB24UzYT8fYvSZtDtqyFDzx4FEZM+BL/2udeGnDmwKA=;
 b=YH1+IZO4iLEyeMU9rVNIPGBSWfzlfDcTd9mGghmqxT37ud1/X1T892hW5qUnb5yZ3PJIP+H2bUv1+a50T/xawN+8gR+Spy2iBJvL1UL7vor5igGAyx+4oAx+JvSGMAVPDXIwNkNiMo3PLwSpY08cg7MUqwPHGBfshcqa1JzU3kd15T0Vo33U/CpdulHCjZISoy0UjGF6kJL3jnRLZbBE3CvDWU+iCeIWRnzqAGxu3PDdiRZk/TiDpM6OMiEupSOkScur4GiG/R+UwkWyzZmao/Erk74lRUoytaKfOq1iHKi1uhid3oEdjaguHrwoZ1v+EbcdiDj0TdWL2dNMKLvU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB24UzYT8fYvSZtDtqyFDzx4FEZM+BL/2udeGnDmwKA=;
 b=a31cEvM0AcQ4v6cPwb3EHPBy9oCp/JUxlgm36fEVCJLlYSMY7QqOBOBywYjgXO4cCTAphB3vHrVxJUK7WIDgAHRImZXkyr8bVD8KnBl42j20PXfzvKp+pcroNZyH9fZVcDM1cAyS61LHEF/r3U53Ojw2Kmdct1GGrVF4uobo07rj74XSkVN5X37m61I9WA+2yyVn4ljBn4w8RnJjiO5T6qw5Ef6h9vbbOWV/k+dy/e5UsqAH73apXheZ/330/BukTDuptzI6SNy6xZMyULJ/kSGOXcwf6pX1d+uC1shblxCwmfdZkWGR9YXIXMmVZcBsBCe2+XHbxRwhQDZNScXeMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4309.apcprd06.prod.outlook.com (2603:1096:301:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 08:24:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 08:24:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] block: add queue_logical_block_mask() and bdev_logical_block_mask()
Date:   Fri, 10 Mar 2023 16:24:13 +0800
Message-Id: <20230310082413.58141-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: b33c5f41-b69e-479e-71fd-08db2140db33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYR1iyLtonOk5q0x0Jw+sxJ1Lyfjh44vGST0h3TxxBcGsdHGoWKYfE9YQGGefM8qWA4+fDTPfTYKfbABSB7oxuS0zCnlwh8dfpwgs3QaKgKInbr91y6tsQ9MOFvidIdYCAUeF0UgcLMKeQIvtsOrO7PVzMmS64nrSdGdnKJ823sPer7U0za0pAsIkqkgSGPDd5G3Vn5iJq3pvi8aWazqs9pdUK9mc9U+x4X+lGe1M9kMQL57J5lMZzBt+Nomn/6E7xMpFj3NfYb0pGJ8jxD7jeAqx+7wWPvB5n4TB1iUeI8lDGMxFJk6IeuHavF/jQugg5JGN6SwCtIvKbxDB6l0miqi4Kt7bXtUDP82yrk/M8Ris3is6qiArLy+4UhDAOI8MZgSMBz9+Em6GYm27L1oEV6tR23siS2wHZgX+DVII0krMspW0kcLiVZVXR++QBShRhX6vMfxID+9KaTJ9e3GJQpfxP4YC/A3D7QjKxV80c1LJ3PcTWq0t0IYE7bCeSNlfK76ZiVxpbkRZK6wupW7XyJV1g5Zq5eH/CyTHvZ5k1h+ZHrLLCP5E7ghHZ8/O8M/uGBUh7pVLoN2m6H/dCeACFDkFgjdBTWfBkdvvbQ2vYqZCeseHbHeeqK04Nqu+Tee1peNkpN8ej37xp5L1xp1STgCBYeKXDOnHjmbTJY7wzop07d/hXNtzPTS2BI4mog0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(316002)(36756003)(6506007)(38350700002)(86362001)(38100700002)(41300700001)(6512007)(1076003)(6666004)(26005)(107886003)(83380400001)(186003)(2616005)(8936002)(5660300002)(478600001)(52116002)(6486002)(966005)(6916009)(2906002)(4326008)(66556008)(66476007)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W3PgL9yhbeG4Nux0J2Vn+q/F9a0+qmv6uHn4TxjyRHvw6ZlzUyeyF1IBEWLu?=
 =?us-ascii?Q?c0kpqvKtjtABaowujlbkCii4Qrwym5O7ur8QiH6K73/iShdoPwcVhbBgEc8I?=
 =?us-ascii?Q?vJNjLoy29/xonehrA8AXWhlpmT6wFcF03CQTdcORblruQx76Bd2N3GvDTdfw?=
 =?us-ascii?Q?LnErH13t4gCA8HmoaJKogq9wOyrDtF4vh54GJnL/W+tCj4BvQGsYE5v1az1k?=
 =?us-ascii?Q?rLuCcZ8pgkeP/PyMuOc2LhAH2tvMCQTyZoiFA+DUlRL/7htBravFnX/ZQwkl?=
 =?us-ascii?Q?WPpSkeUsri4CGmi4FKoUClWeGmOsHwVDBNdigoQmr2fC+Afgm2I7a1LtNd2g?=
 =?us-ascii?Q?J+WHipymR6Q33soQkMAI16uIlQnYLItc9kB2Hw4/IhJDdpEu4dIo73CxdZBn?=
 =?us-ascii?Q?kD/vAUWipTCluZiwBYOY53WkwIm/s6eUFMPWHsiKRLyp14cpRRq/pcdow0DU?=
 =?us-ascii?Q?T0mjvKpoA9Gmdfb8+3Ux/bupNCaGSrj/tFWkI0pUWDCOT2u32nrR1vOc9+8I?=
 =?us-ascii?Q?gW1fzneE6sDukPv2LWT1Y+FFWvQWsgbnbdKX/EtLJI/WdLk9X2SNHyz5Swaz?=
 =?us-ascii?Q?ysqORIlCLsaaygyvJgP0gN2Gzri9pG2dSSkkSpSPy9qrQV1gLCgW6T/7sJS4?=
 =?us-ascii?Q?fGbEIpILdOuU/JiUGxgwGzj88CAwM9QyRhESca3kE479xMe/MbXCCy9Kdt+8?=
 =?us-ascii?Q?60NZx3Domlat2RyN2R2pe8uYAskIghDCtONCqvfHHzg/NnCgRbKq76RimIpN?=
 =?us-ascii?Q?Ay57ayHJdOQa7g355uIbmsEer7TrC2Zm+8xBnZZU+r21Nt3yk9zRa2WH1q64?=
 =?us-ascii?Q?5GG1A3kdy2luCXXBTDb9PP20rLaMvMzDpvZh6VaAiL58ewKIKJBL7qr6dHZO?=
 =?us-ascii?Q?ypzDnWO/8fmqaI8ywJgnMQp5avh0iK27OEW8AdP76OybxNdnvguDwnkd+nIj?=
 =?us-ascii?Q?dNGqRAv0g6N4gY4WnKJ/Lzr/wlZcWw+2yq31nMYYrjrwyHNS8pDrmoMEjfLp?=
 =?us-ascii?Q?553ola4pvgX5c37LFVSIozhtOjv7JBRZwV10FOd0dFaP9k/ZzxIFHNQZ91Cl?=
 =?us-ascii?Q?JAX0wuPqGFi7utfNMFdgfwMn7o9Xn+c+PazGaEwagX0np2Gx7x54vLM7mWtx?=
 =?us-ascii?Q?k98YXC+30dAYpLoeaZlBzhJIEJo2lcd2by4Ldo1tJ7C7U2CtH49iSt9WaXiL?=
 =?us-ascii?Q?vElWxQyDdTZ2Qasupiwz1IPeX9dlBOBGFmh6jJgapSIH5qX7hQG5MEStFIqg?=
 =?us-ascii?Q?bDZIc5Yu3MY5h++S+AAU/YNMA3m7ak3E9307RPUweGKAPHkziX/Yj8ildP3N?=
 =?us-ascii?Q?GwPcNANZ2QR7n7/ilK3v6y9OC4br6ap+zvaqyoxil5b3bYaLESo64wxAoSWL?=
 =?us-ascii?Q?vazbW++xuQqzT9Z8KBnqRg1RuC6LjMTMnrbmlAj+Lfe2KD9gCOTpSQPyq6B1?=
 =?us-ascii?Q?l4nrfFR6WuL1XnSrh2DA3j/4oh77WMACQ7ZPA3I7W5gbjPbvYRjI1DBI+Kkr?=
 =?us-ascii?Q?WebPTsRnTlJvcPe06PAiRemh9xSiLS+toyHFSyZfIsf1id1HuXpKTfOVQJZw?=
 =?us-ascii?Q?4fD8wjioW8xN7tq7oQPHrGnDvNuX9IPrH6taMOht?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33c5f41-b69e-479e-71fd-08db2140db33
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 08:24:24.5230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rs6203TA7g3jCAVdWnTxW9GnHWnNuYbIDthO82nII06aCiAF9AoXxyrmQkJRUVY3hbVH4pPfymA/fMT1H8K52g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce queue_logical_block_mask() and bdev_logical_block_mask()
to simplify code, which replace (queue_logical_block_size(q) - 1)
and (bdev_logical_block_size(bdev) - 1).

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
Like wo done for fs.
This round we add helpers and start converting in the next cycle.
https://lore.kernel.org/lkml/20230309124035.15820-1-frank.li@vivo.com/
 include/linux/blkdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d1aee08f8c18..a68a704e5ea5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1173,11 +1173,21 @@ static inline unsigned queue_logical_block_size(const struct request_queue *q)
 	return retval;
 }
 
+static inline unsigned int queue_logical_block_mask(const struct request_queue *q)
+{
+	return queue_logical_block_size(q) - 1;
+}
+
 static inline unsigned int bdev_logical_block_size(struct block_device *bdev)
 {
 	return queue_logical_block_size(bdev_get_queue(bdev));
 }
 
+static inline unsigned int bdev_logical_block_mask(struct block_device *bdev)
+{
+	return bdev_logical_block_size(bdev) - 1;
+}
+
 static inline unsigned int queue_physical_block_size(const struct request_queue *q)
 {
 	return q->limits.physical_block_size;
-- 
2.25.1

