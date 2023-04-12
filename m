Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAAA6DE869
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 02:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDLAKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 20:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDLAKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 20:10:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BCD449D;
        Tue, 11 Apr 2023 17:10:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BL9hQ7029961;
        Wed, 12 Apr 2023 00:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=xEt1SHSVYaZWWhL/IRN7oA6TsJmqpiMLrNnKx131ItU=;
 b=cPcKaAI6sbA+eNiRRAungfqstVZ+CQWIMh6k/4wJrLA2CpmnaqJpJgplADriaYgZV4C5
 /I3+mlrLTrvwoRF84VHzFwNXSOYiSf1L7Ua59k+YNdSptDHoNMEOFPl7a81950ltGmyQ
 vM71o8AnjYhVEYYRVilgJ1wA4nxqB5Sdyh8dCBWzPDdMJrUTIUODVTLUH7cIgUCkf4l9
 eoEr1/0Ufzr96kwISnZhsz0qX4j1vA+jSoxZ5XorLHjxTpbo16Vy7RiPHdnDm1uxQSuM
 cuu/Ou/eee78V/3ptky1kanQMFSQkzt4dVbdg8O6y6V2M4w/h3B59LQCEMGleH0nJdbP ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0ttpub1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 00:10:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33C03UDK008156;
        Wed, 12 Apr 2023 00:10:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwc50emb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 00:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+oFhhFBKuZiuIn1dLmyANph0AsLfyLlzySB3b2wgvGK+RKotbmKCqegWTiabNihZhNq6xNL04H/MJcLnvsal/+TvjkOtYT5weosn1aLC3n2tdB11E8v0pNmsgiqxdTwreftiiCpTru/ptVZawjL5iQfRoNYIgCTFhnWXLV6XfrZOJ+iG6w0dJ5nRN3PZLYaIjtsj/7DFFiEgnlTdEWShAaffv5kTgkefJao2wmfUJ0Ji9QyLvF38GU+HSeoxO7wxX6+ksWmtHrd4mvBKk3542uymlsJ4d9ETNvXYoDfRjNhBPbFfebJyRrr2H69gwtbRZ0P10uNzCx/wulRxBwnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEt1SHSVYaZWWhL/IRN7oA6TsJmqpiMLrNnKx131ItU=;
 b=csuxzp9ossoVHwCj6Xq8r17ALCewom1QkbIXxFarxpqMFyXduB8l1UO98ufnwN4OtogG8cC9+iSwrhXRi8qas032kM8TmujR2fJIw4iFUlncFr1lGNL8wDd0XGqenHcbfxK4G7GVX0Me7eNMS12WhoL/hCMjp8MhTVWD+0gw+XeJvTfCqcaJjSGP9EHuaam4cFt0AN/djXeQOqbl680vCdxEMegL01sBtII9Y1yMLo8UXZdyYQPuDeDj7BKnLgjT+2W3H9v2o6e3crvnp7OnjVZLoOv/Bgy07x28qexxclk48TxhAsTVax+1SB9P1WRF5p/vQP4zfMpwaT6ZHHAAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEt1SHSVYaZWWhL/IRN7oA6TsJmqpiMLrNnKx131ItU=;
 b=SwJI3iDH858ZGUDamYE8e2h717KZJXh6dnCRgkrPDaI4QUrXATc+HLr83JkMtyr15/vctStDh6YQVh8OO4uW4A5Awec8bdGbyOlnGWbp6mDV7EFQgwVhlFv/eAKAD5C7o/S8Bo7hqMUfC0PaOHAQnZRBY2kUEQ8rhXgIopr/EBg=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by DS0PR10MB6151.namprd10.prod.outlook.com (2603:10b6:8:c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 12 Apr
 2023 00:10:34 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1%8]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 00:10:34 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        nathanl@linux.ibm.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        joe.jin@oracle.com
Subject: [PATCH] debugfs: allow access relay files in lockdown mode
Date:   Tue, 11 Apr 2023 17:10:30 -0700
Message-Id: <20230412001030.88441-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::34) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|DS0PR10MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf41076-8030-4947-f2de-08db3aea55c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(5660300002)(66946007)(36756003)(6512007)(186003)(44832011)(316002)(41300700001)(83380400001)(38100700002)(8936002)(66556008)(2906002)(66476007)(8676002)(4326008)(6486002)(86362001)(478600001)(6506007)(1076003)(2616005)(6666004)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf41076-8030-4947-f2de-08db3aea55c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 00:10:34.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EuGCV5DSIzfsX37tXEfjMortq9F5ft4LpjvyrfKYfA0u8xtZ9iNVeFL3OyauKtL8mV/WqEjdwDLDghcGP/dNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304110217
X-Proofpoint-ORIG-GUID: l4_laFtG2qTbth9szr60jpgWOpQY8825
X-Proofpoint-GUID: l4_laFtG2qTbth9szr60jpgWOpQY8825
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relay files are used by kernel to transfer information to userspace, these
files have permission 0400, but mmap is supported, so they are blocked by
lockdown. But since kernel just generates the contents of those files while
not reading it, it is saft to access relay files in lockdown mode.

With this, blktrace can work well in lockdown mode.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 fs/debugfs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..04fa813a227e 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -21,6 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/poll.h>
 #include <linux/security.h>
+#include <linux/relay.h>
 
 #include "internal.h"
 
@@ -142,6 +143,11 @@ EXPORT_SYMBOL_GPL(debugfs_file_put);
  * Only permit access to world-readable files when the kernel is locked down.
  * We also need to exclude any file that has ways to write or alter it as root
  * can bypass the permissions check.
+ * Exception:
+ * Relay files are used by kernel to transfer information to userspace, these
+ * files have permission 0400, but mmap is supported, so they are blocked by
+ * lockdown. But since kernel just generates the contents of those files while
+ * not reading it, it is saft to access relay files in lockdown mode.
  */
 static int debugfs_locked_down(struct inode *inode,
 			       struct file *filp,
@@ -154,6 +160,9 @@ static int debugfs_locked_down(struct inode *inode,
 	    !real_fops->mmap)
 		return 0;
 
+	if (real_fops == &relay_file_operations)
+		return 0;
+
 	if (security_locked_down(LOCKDOWN_DEBUGFS))
 		return -EPERM;
 
-- 
2.24.3 (Apple Git-128)

