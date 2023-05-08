Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9E6FA1BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjEHH7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjEHH6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:58:54 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CD59ED0;
        Mon,  8 May 2023 00:58:53 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3487QqkK011998;
        Mon, 8 May 2023 00:58:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=mQYDo/r38N2alGbaUoz1D7LHoobnVFuxpV8oSRCtwew=;
 b=I6544JcRxlKmO+y2UzOwEWFans/iymQPHkL15sV8i7mCULVvLYBrLLSovMZfQd+hsR0R
 FqQkzlghydB9S1QddukkQeRFsSSYw3YqP7K2RnW7WYAfvf9gIfbT3mSUQ67xNLqHVRWR
 cBwSQXoc2U+I6uv/qH0n8PBo2cSnqDev5mF/2ZzwAR7ieEgZWPiXbZpcC77TY1rUv9ka
 KitaW+1pRB0xt4NmueZnDQl/oauA4+m8rV5dsEPsMjrD55Bwgg4jmA6V/AbAc/+e2YQC
 gFuScxgWzF8J0lH1vU1xVS1lv8huTyL9vZEp0gvY2ij5QJEzlh9SPMjOVSEei/jMmtNr jg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qdpe43n4a-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 00:58:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DprMyBLx8gzHFEAn3ET43xdjgxSzFa91xzDv7HcGKOOZcPlsxfbHn76c9bGyKmKg+t/Vh9RbEEkG5Qii2E00nuxsM29TGVeZFS69ARfgoe5rSI8nJYnOMfJruFCbiPvoHwsNc0dKueG6XdNInI3lmifWKfKFcmFgY01mJR1xvWfKB1NKBRlREUIOUMbnRh9v1P95JCW6EzDaG6VOC2rTIsc4ji5R90Sf0qSthTK05KnUpDWqfv2uP5jkWdgR6/8Hf8CNtqn5wY30TimsqVP2iskr7St4mibSURIem2W5vXfuqSrItKpu4292S6LWuu+o9M2NVE8rRCWnbJ5lnVtDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQYDo/r38N2alGbaUoz1D7LHoobnVFuxpV8oSRCtwew=;
 b=nAyHAghaRXsbuSravVHu5Qxd0T+xCfBftP/y6RRcJnxy3fMVnLAbX246IS5rZvkZzteoX8siSp2GPFGXf/nRewJFbcRP3185WpM5zDh0ggwSqfKO7xCfbXVSlNsRGAr+NkqReAyYkcK820IwyazsOj7QmOm7VLFj0ITzWRl2je1SVdnN4m8znNzFAPfR5Rmw7y7o9/doqUHKyTSbdHxfMpnMhpS0WRM5SqwmITYcxFSgqwekZG6tbadWtwlL/61A/dJJsxl6z8jB3bqV8W9zkBPOvGe4HZdvdBUIkF1ig0Vmyj5IlLvj4byYMTACZMgxpN3wjwicsEmfGRoM8/OxVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQYDo/r38N2alGbaUoz1D7LHoobnVFuxpV8oSRCtwew=;
 b=iTTlZpnK/3tVtTIJGZU1ber3vWuLL8jy9Y3lmfQNK0KEJ7Z4H2DKJl1iF4hLhgOk2D7S56ftAntnf2PwFtk14CVPF3EVQrUxn9mowhFcejZO/LbKzdyen0KTmRPnJxpDc9rM198nc7qBeXchF6DdbJiEkInIBWmC/drWe6nSe3ylro0dAA7c/dAaW855aoEr+pPmGI77ggDVNQwWpm6roQtBt5ga1rNE+4ijMDamVG89c3hQNx3CEkK5dYNMQ4ExcURQzy1/6vapNX2Gs/tBDbEh1/ZDm5/COrQvZPKKayhja5FquI4m29dXbH7mARKoagbD/WKyUR7Xk1RlSlUh9g==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by SN4PR0201MB8821.namprd02.prod.outlook.com (2603:10b6:806:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:58:49 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 07:58:49 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH 4/4] audit: check if queue is full after prepare_to_wait_exclusive()
Date:   Mon,  8 May 2023 07:58:12 +0000
Message-Id: <20230508075812.76077-5-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|SN4PR0201MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: c065b783-fb21-4a30-8c9f-08db4f9a0e6b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzJGaOu44BMD+u7vi8nkh9C2s3MxPkgBJfNWxKUUjIQIob6bczv0Hi5Eeq/ASuFAjqVVBNEodY1jWz/Pwu9ne7879xtH2wVN52g12n7bPhXKKm9AJLcjz+p+sBL+KkA1XCUoPLOSN2StItvbgvExJKZAlTNk7+OQhXNws/6CX/OcPpqWhGSpUFnBVatpXlDIFLHol/KRICBYI6tFvxKH61W3B0hwMkw699W2g5rIJR0gOX5SKHMQEVg/UvqUj4kPrcyqwLhGsxCgHL6E7y1qJWsq7qIV1khYaRPH9PFpCJCiUMb+ITLZhj8DBQZiRw6FSl25pBys662/GOfGZrswJxIcfsNP1dc2gdas2naU8U2JLxcAd13RLSQUdCZrCz59b8Ra/VuNnKdt9+jdj62WYbHHStiK1ieauML2ZKAsYqkr0ntv1Uv25EzyF68OkctDUbU9jZjzmuxuHXVyURb4oChg1Dv011fze+X/NvF9Q8OgxW4616G0zjGU6RfN4M6St+1yEbnCYLZPyiAhGkfILq2qOj7xnbMqjJDwUi53Oj6J4hhpWpGULO0iKg5X+tCfdAOwgSy4bdh3pSR5/gWEeUH5INg12zEB1bvInS8VIquuW4nDU72fwMqpU1Ecocuo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(52116002)(66946007)(66476007)(4326008)(478600001)(316002)(6486002)(86362001)(36756003)(66556008)(83380400001)(107886003)(2616005)(6512007)(6506007)(1076003)(26005)(6666004)(8676002)(8936002)(5660300002)(44832011)(41300700001)(2906002)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sAcynbSwzjloeMvpDnQQD+Z0FPTgLlYT8TLX9EN+jmFImh9yW44llFMvL7oV?=
 =?us-ascii?Q?hVcVuuA49FTc9RHPyDtbJByk5zwy5HuCK48M5VwRk9fdxZRN1hjvVvF6HYc6?=
 =?us-ascii?Q?Sl6ZRC6OUjIvK3prNbJam6p8mRj/xCkXEVAnIOUDZ4LVyJ2wQZ98tAa2J42p?=
 =?us-ascii?Q?jmOn7FTIRoZ1bqYwUSsZOhY3a6+gpdxKGNfbX8W2eD3t7NVtplCCUbbwTP83?=
 =?us-ascii?Q?tC2tHNLJgNFJWVDhwlEHCTwfOjvBvyDzpcKob+hkGlXST+NxgjdIwsrOKlJr?=
 =?us-ascii?Q?CLVerrzvyux2lquDGmraPlhyajjFuI22jl3x5QftZEu6UF1jB0umbsXPlYzT?=
 =?us-ascii?Q?Ma76uNz2BANY3YN0RzzUanKRzESQOFlJV669C8tAmQkrxwLd05uv5zRXg5LL?=
 =?us-ascii?Q?svHlxLzZpZdNF4XQMl1dgKsK1W3shvprlSFEKkzu0jJlLNnVNB1EfFSDACYl?=
 =?us-ascii?Q?X29r0QG9SJs8mQV+0wZ40usLDowU1vlx0ghfgYk3oTfiQKus8v2Kye9p4Txr?=
 =?us-ascii?Q?4led127f6GDiQZ/iqCER82pfuKiJsJiQ9e+B8VsDpWhIjIcEXQUz/hQql+eq?=
 =?us-ascii?Q?rQintysQeNNdUDlaThbEECgNQDVPy4uOwT2ejX0SL4LZ9KFF5ev72RaIEd5s?=
 =?us-ascii?Q?sLX6KJu1ZUjKD+JQ8W3MysJCrMDGix0Pz5J+MNgkczYHPJ6MFaSCEAcoyAeV?=
 =?us-ascii?Q?b1rzgw1pBF7eLxWdY2nGlu7S80WNT1VSL7PhcekexKYinnUnJDAGpDLZHaxK?=
 =?us-ascii?Q?3w6n3n5x0sQSYMrbhHjR6ywTCNEnsQHiY1+zeBQaxDGEvAQgH6VZFG2MGaGQ?=
 =?us-ascii?Q?bv75GV5650z7EoYAG8rcD5NZJsfflyTR7CUrzdzR8n5i8vBYttghSwqjAfzp?=
 =?us-ascii?Q?UUgZ313Ye9B68fJ5xV6+5jpFhR6PGFO25ddDq9jpTkzXMoSS6mZqb0lxpr+M?=
 =?us-ascii?Q?fnwVUZMgGvCYiriOhZWdr7Wzq3h+N1OtlVYPOgyZplByes+YV50B10bwFDzV?=
 =?us-ascii?Q?QPgXZOIVvBfOvNJ6tdm0BJpftQis+AmadXcVBF9oEU3YKltOyNlpGnAZhYts?=
 =?us-ascii?Q?mVRIz+pAyLBAG2GD5WzuFZK/FofGlImDxi9HIUlyM9jbltTjLAR8EV93F2ry?=
 =?us-ascii?Q?hz022iqSZW19JK6Kz70lGH79eq2nQrjPSDbxMn36vaMKrsAJ68IiHwLQecYu?=
 =?us-ascii?Q?acV6TqGDJ8CennF896r7L4oVq1VwJEVCS5haDCLP3izOQMytDFs39eQfganj?=
 =?us-ascii?Q?j5sh/6bGe3u6Ln8u2uoKJnOOWBXawu/JYg7AfIDiS5YsECrUwyBbZNg/0j8W?=
 =?us-ascii?Q?nwOVtUP9+VUCM30eS3IScAWzq7I0dQW4R6yT2X6TITZ2n2Ti518wgbD/epYm?=
 =?us-ascii?Q?wQ7Gb8bgssYvp8/bnnS3hr3UAD+XLtlB8/YVmoqoUFAuWjyqKJWKDPztaAv7?=
 =?us-ascii?Q?dlOOpHmn/N9i0lizmbIk8RAgbhWSmbK8NV6GFN58hFAorv7lji0yFgI1Nine?=
 =?us-ascii?Q?W/miVS1mhKAMKwvySLuttFSLffZCnRua4xHdpd3No3vTv8Z7uErabhZCQrFn?=
 =?us-ascii?Q?Fh5TsF13ChU4FbPsxnI/3MmDEVE5gjSJGnJLk3P9r8Nmj6WVpXd2xgLpARu0?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c065b783-fb21-4a30-8c9f-08db4f9a0e6b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 07:58:48.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TeEP+B5vK+GCXy8VBOibDwyR+R6w7h5FXnp4y8ka61NgFbc5vqwHOyDfIT994nZs7mRodGswe3SqXTka7CjzIRID6TgYvle3xJyoguu7Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8821
X-Proofpoint-GUID: 3EEqJd7Gllioxahca6z8xvOGDxr5NzE9
X-Proofpoint-ORIG-GUID: 3EEqJd7Gllioxahca6z8xvOGDxr5NzE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_05,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7ffb8e317bae ("audit: we don't need to
__set_current_state(TASK_RUNNING)") accidentally moved queue full check
before add_wait_queue_exclusive() which introduced the following race:

    CPU1                           CPU2
  ========                       ========
  (in audit_log_start())         (in kauditd_thread())

  queue is full
                                 wake_up(&audit_backlog_wait)
                                 wait_event_freezable()
  add_wait_queue_exclusive()
  ...
  schedule_timeout()

Once this happens, both audit_log_start() and kauditd_thread() can cause
deadlock for up to backlog_wait_time waiting for each other. To prevent
the race, this patch adds queue full check after
prepare_to_wait_exclusive().

Fixes: 7ffb8e317bae ("audit: we don't need to __set_current_state(TASK_RUNNING)")
Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 kernel/audit.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index bcbb0ba33c84..d37a3a045230 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -644,8 +644,14 @@ static long wait_for_kauditd(long stime)
 
 	prepare_to_wait_exclusive(&audit_backlog_wait, &wait,
 				  TASK_UNINTERRUPTIBLE);
-	rtime = schedule_timeout(stime);
-	atomic_add(stime - rtime, &audit_backlog_wait_time_actual);
+
+	/* need to check if the queue is full again because kauditd might have
+	 * flushed the queue and went to sleep after prepare_to_wait_exclusive()
+	 */
+	if (audit_queue_full(&audit_queue)) {
+		rtime = schedule_timeout(stime);
+		atomic_add(stime - rtime, &audit_backlog_wait_time_actual);
+	}
 	finish_wait(&audit_backlog_wait, &wait);
 
 	return rtime;
-- 
2.40.0

