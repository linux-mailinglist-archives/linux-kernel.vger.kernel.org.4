Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7766E9E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjDTVyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjDTVym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:54:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD92A26B3;
        Thu, 20 Apr 2023 14:54:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KKGLYZ009202;
        Thu, 20 Apr 2023 21:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vj1BssR+OqWnYGF9jMKMNrgV3jvPAHClYoOkW+SK88A=;
 b=wUSLz1yEaPZgr+3FLTpPTPAA69bmMLbXl2ACv5r38KHGZn/kT477bICE9BH3YMHSSv19
 ecv9tkoy4BPbk5iRPmMUZPb8gV6ElvzkQRFr8bZJGcvxbGXyl5VqcgYzNvwqBGNhN6bB
 BI65EbiYHGgXBHXfUD60NZxXwuJ515uHwZGRxD7RMsCgmr5dJDbbp1Poujyak2PZ7DwC
 ZloiHTWn+k9cYza4OIhmyJD1AtJZ9I/QdiPAeCgBQa+FQsSGCbOsKX3IkMjpnTdU2ob9
 Z+8mfIlKqjjjgYB/7TjJ3ChIzkjMxwT08Vb8JOg95BtJHxuU4NKFUFSTtyoQB4j9EKal Ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjh1v2r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 21:53:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33KK9Opq015638;
        Thu, 20 Apr 2023 21:53:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcevsf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 21:53:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOj0UNC2BfEwnatWsyoGseKg2T8pFWNEiDIIen3OyN0Afx/LixdiHyQwkqQGcvRp0H58yCvJceStsHekHwB2n2YUn6FZ5jq1qoTxGQcTMQXTqNIntIkukXkpKZ7iEYqvaV66WaznLBoOuuuLdnU1TdNQqLRNplMHd/odE7WlA5O2YH0HnPRwKcCWDehogQ8ccp8Vnap1/ki/UFH5GeZyhjQz5o1DMUE4CZYQXF2/xz58gDCadx1bO9j/N6qmhUztMFESom55/YtJXH0OdtDu6sAPw4S+CZ5ip0bfqAwiLDXNi1ZRtoBVzmx9EmlhmNntW1psVvoYpaMl0Ao9wKSBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj1BssR+OqWnYGF9jMKMNrgV3jvPAHClYoOkW+SK88A=;
 b=AYBd6LTMcvLLQv/rx9foc89eFOg4KSy8kGN3yaGhU+APnTfLYwH2E4jGIC18cg8Ef5bNSJwJ8hszC2rLsW6A+tEruEX4Bk90UNn6UOb8c7jeR2MGbIF8JB+F3WBJbGr1Tbb+GXpkd2VwGPT3gv4cAXnMqBZ13aGv5dtFx8JsxfTfzv1srpY2+DkuK7blqiH9ygYMN6Pn5JcLyjCvotvPK8ZZsKJkg4vFmnroOupZvkcObUn3XQ8vsK7Fe5X3/vnP+lig+brRD4+8legrhYRWVDy7KzN2uH1whBP2DLzGJv3WjKCpP8j3mUIzBy+xSn3ZTnfs4cqTB/Hrng8nxIJCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj1BssR+OqWnYGF9jMKMNrgV3jvPAHClYoOkW+SK88A=;
 b=CQBrAOE9f2euM37s4EMCrNwAwLavFvNThWlFc6WjT/PwLdvEYhFe0BxA+6sOQrGUrEb2s6VFchmxMnIrkExOz5l+5G2rTZZ2Tktb6S5RXltqILNd/7Th2nFH0VxKqI7Oo53Sh9B12qZsL5yMJUZa0TULSEOhmFYzEFL5py7j+T4=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by PH7PR10MB7036.namprd10.prod.outlook.com (2603:10b6:510:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 21:53:39 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c%5]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 21:53:38 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org
Cc:     paul@paul-moore.com, nathanl@linux.ibm.com, axboe@kernel.dk,
        jmorris@namei.org, serge@hallyn.com, konrad.wilk@oracle.com,
        joe.jin@oracle.com, junxiao.bi@oracle.com
Subject: [PATCH V4 1/2] debugfs: provide a way for relay user bypass lockdown
Date:   Thu, 20 Apr 2023 14:53:30 -0700
Message-Id: <20230420215331.88326-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::13) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|PH7PR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8c928c-926d-4f47-fd40-08db41e9b2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23WWxyxyoGKgCqpzA+nc3IR5J2bBtxYWmDgaFI5PFUHgA+rRAY51/ZFHDTAWNGQlByOpvy2R9mM0OKm74YNqBI3sMjqYho38/zpYMu4wYdZuC9F5Np31/U8/doOJ7OndTstge+QpbSWawLU18GdWb9q04qkUxrK5DKtNaAlsqM59QQlmIJPAKAa4pQww8tEYbMoHKbMmlw0JQv4LsTZ2K4BbRH3FyzY+98Moy5cmPVmwRxb37kHJBszkWsDCS3xGRyCXwbsH1gt0DS4Ep2mmsRSdKonuh5nsy6Dqjrrb0eTN/O6DTKDPcsY/Wc34hBbOSVrDRInCWLLEfkvtK4HDgMt3cuL4kSVudXrMeZpmmwxVB3jFHG+cRT7ilsameUGVh/ScciFybz9iQKl+gDqXQtbYbMHSGxUBlEF9Rm2RPiUca1LGQF4PVPyma8AaBYliODldGBthsjga0RfjOfUMnbF5YlGWlE40G2yVQxS15R0rlEO3d9S9lL1X1wwE24jkpvtvZCllH49sUsYixwRf8V3BJ7mdJFJtTznKcCSpXTKoPC5JTfcrBOLnkX2sCKq6pmQYjzBK/tNUJCNOTDIFIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(5660300002)(44832011)(2616005)(41300700001)(83380400001)(86362001)(107886003)(966005)(1076003)(6512007)(6506007)(186003)(38100700002)(8936002)(8676002)(478600001)(6666004)(6486002)(316002)(36756003)(66946007)(66556008)(66476007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HuK4AiX8TDILEEaThfPr9xSnsPyRTJ2+e2PveLnyOXuA1x4J2/NBKpREHm22?=
 =?us-ascii?Q?ZQ+JJrjmsu6LJdkgDJl+zz/sDJnmYZC8kaixL45IPyKqQ1dWmNQiuF6ZiWOv?=
 =?us-ascii?Q?p2Mvlq9AuX3xX+CPqEB25Sl6qSTcD5+K++R9tQSTkWaVcaVvmxdzCC/nWm7Z?=
 =?us-ascii?Q?wxQwInt+O79ckLWmTLNn9vC3SDTbkk+4kGv2sfJWrMKFZKFhl0bFthjQ2Flx?=
 =?us-ascii?Q?cg2BCcqYh9WVQj0Q1RKnwhkG2A1a3pyubReVlUz/nE5AKyHjbUAbFoQOPz3M?=
 =?us-ascii?Q?FyTFZnwWhIqrG0mDUtKbq/X51qxq+7e99qO28+kZvVqYTfxgjaUgzAidlU4g?=
 =?us-ascii?Q?aztVr07pZcwEsZvH8uN1aTo8fCQJZTkUbUwwKIZI9J8/cxOM1J+jzHQmzQrL?=
 =?us-ascii?Q?sauk2Qc7gUgq1SaG60RT3hVxlvUPkfmyEowNFwCkWfnFJvSfVzSCR4q1w0QW?=
 =?us-ascii?Q?dX1H+HY6DlnqpEx/TnVNXDFd2qHJ9kpxbzXfxbIaXLZigsO1Usthg7xLnpN0?=
 =?us-ascii?Q?AP5W7Zjt5oNAZOJ0CBK8DrRhYpm2HjkkXE2gpaI1hBK2eUs3HFXX3BHSKQWN?=
 =?us-ascii?Q?++BWNoI34vJA9wzk3JRGlzU4YGNcOm5JrgT+Vb7bIRuTQaEQC3oH3cIdFtLM?=
 =?us-ascii?Q?qQNXZhvo+2RG0BzLo8riixkr+QqfmJCuZxdbvKomxWjddiSLrJyo+Ye/q56z?=
 =?us-ascii?Q?CJf8Hnz8jCkDZanqr+vQ96+uTK5Hoced9X50Vy2gguPeng6GJIsBkCa3Lrcs?=
 =?us-ascii?Q?DvrDySdpd7zcDrFYNK2Ti7t/zlu9VxZr5oALyKLTcJJOcmZv5+vZWwK/61rB?=
 =?us-ascii?Q?vT4qWo7Be4GBbjWjZPBk3g8oUSyQBznI943WeEE6W7WyKF5SZEhAvri3+T2s?=
 =?us-ascii?Q?Fa4fCcMC3hcDd9Q902OIycP+PiofgZeskGZHPrNu9uEzxmPrl0OUjAErUxyU?=
 =?us-ascii?Q?OG/wSB8jF4dhkCxzm8f796XH0lkt7/g/I7yNnx1mdnBr7QDk6yW1uc1ekM1x?=
 =?us-ascii?Q?v5TKtMbZsYLTAcOGSBG+6A8i7mOAuc7ihSKavKet1sPFrQJCR4RW9b4RKQ11?=
 =?us-ascii?Q?IcofYqbcnw0OGcGWZrYY/VlTFuXQAU4WcwKuw2/GYZun78bOzJV3r99ycdS0?=
 =?us-ascii?Q?1YaIyNx0n2GYoeNXDG9v/pKchzoo+LXJiDpXmSFMPxUYBWB3c4YvB6KAnzML?=
 =?us-ascii?Q?BhwkY4Cg8b4ix+IA0W3KrQ8g9AHWtMAmZCOqwE2HUozzb136yFdDSCheFthN?=
 =?us-ascii?Q?XwMpQSZ2IoMcFosW1DnaBti0qE7xLMIVh/GVMgR80mD2Qpea4vvqbpEQxKiO?=
 =?us-ascii?Q?jrmT+XwDPkiy6DNyjuW1uAerYGqAQdSXJBpZzcY2v6jJmBRmZZUBZUSOG3Km?=
 =?us-ascii?Q?9hCWmJ1KvsJuVtnguCohXjCEuk8BzzewR+1xOvfJYJxm5piCLDNmZx8DGnU8?=
 =?us-ascii?Q?to9fnUrPXezc2pga1JtM6Zw8VDTCu85oYXRzzT5YkfMP6c7cztelHDh4iWrk?=
 =?us-ascii?Q?FKmSxRGBDdgGZpNKe71Wp4EdAbXb7niqEe8RgpdbjB4dSHk9lfuSuZSVLMwN?=
 =?us-ascii?Q?qkGElyqacgFhDyH7ORqu1nPF6RYhNnsFaBQ8SYxIDapa5Cr9HCv4IwhOXUMz?=
 =?us-ascii?Q?cDbET7cGvR9L87wbTsph+6c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a3KSYRqJ5MSIOce46VcIj20uPBe5djp9TCCXg1PIvULHPWKVjKcMszk3gapEUqYPKOe9fvchknxHAL75MM59vMxf2xblxtOS2fr2ylNa+IvdbMT/vnQTVmtnNncoxL3NJNfpIYmPicuvLmOINjEkeQS7bEKGHKTFx5G9xXCYqXiV8GHGebwjlcGOH94iFV7lRnocW/heOdUQETIhSS4gu4qIZpdS86gUnmsG7j7o02qIS1fXjXXl4xp/gIhYl+SqFH+QLFpxfZapIMzOieVvcQOMACpghUwF6Z0zpT7dJt5EgURt8yIMVXCKVLrkYhiaMhCdFnB0juVWrkY5pV5GeTkrizbMfOqTjbCEdhGqwjurFPvhtDLasfqnUj1qAZg0u0y5bStUrloj89GQxF9NI/lS4GW4AAcjp72WQXrIfNorYQDAR34yM/oaXBFwKRYk8Y3RKgsqwhs/Ugg6S4bTeHjwBygGI+5IqNDsAw4LpYcGD7OuZZzUtf+CracTPS8pl4K6BR/+4ZctlDmNE+ON8yjRZD6VWSvdGj614IQXA+oxRz5ff3QNNSPUOLHXXXlZs118DZ7/4MzwfUAMTybyv5i88ITzjt0OXm+Oom7edieiNXgiGENZmxl2vwBoOxg4jeb9oykVPiu3D8RquptT9/61wwrPdO3buIU4BYUlZ3km8sJ8wAVc+vAwWhn4vjyyb+Q/N4rXzlfiEQTuslwnb9ip6qgizZ21aKnly7FUJ4VUThVim+S8A13TkrjhiAY/+ZXjTq+WwKYoc0ZFcOUzYjdts7DHnTwRdwgAw1Ip2X4wCr/WUW0VrDOsnZ6rVBFNtzm0e0Ihroo4Q4/bEoH6u4rDoVI7/pDbQDyBKJ6qnEdshn7kYioxyetXu/ly+Ovm07rvbfbSHv0mJSCcEojGiq2AhWCx19wuC4nLb1bqSDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8c928c-926d-4f47-fd40-08db41e9b2ba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 21:53:38.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+p1uUrxXtEeEfQn2KJ99aQezWSQw8om0Iz73RxlCG5qai24nj5D4tVFvA8OkPW3n3TG9hFDOIJTemJdIBa6nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_15,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200185
X-Proofpoint-GUID: eVa_uEkNxCkED3-hjFP5BOk_UZz7yDiN
X-Proofpoint-ORIG-GUID: eVa_uEkNxCkED3-hjFP5BOk_UZz7yDiN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relay files in debugfs is used to export information from kernel to
userspace, relay user should tell whether the exported information
is safe to access in lockdown mode or not. The access will be denied
by default.

v4 <- v3:
refactor the code to make code more foolproof.

v3 <- v2:
allow only blktrace trace file instead of relay files
https://lore.kernel.org/all/20230418172656.33583-1-junxiao.bi@oracle.com/

v2 <- v1:
Fix build error when CONFIG_RELAY is not defined.
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304121714.6mahd9EW-lkp@intel.com/
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 fs/debugfs/file.c     | 11 +++++++++++
 include/linux/relay.h | 16 ++++++++++++++++
 kernel/relay.c        | 17 +++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..e12dd8634dc6 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -21,6 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/poll.h>
 #include <linux/security.h>
+#include <linux/relay.h>
 
 #include "internal.h"
 
@@ -142,6 +143,13 @@ EXPORT_SYMBOL_GPL(debugfs_file_put);
  * Only permit access to world-readable files when the kernel is locked down.
  * We also need to exclude any file that has ways to write or alter it as root
  * can bypass the permissions check.
+ * Exception:
+ * Relay files in debugfs are used by kernel to transfer data from kernel to
+ * userspace, these files are with permission 0400, but mmap is supported, so
+ * the access is blocked by default. But there are relay users like blktrace
+ * which will only export none security sensitive info to userspace, so provide
+ * a way for relay user to hook in to tell whether accessing the file in lockdown
+ * mode is safe or not.
  */
 static int debugfs_locked_down(struct inode *inode,
 			       struct file *filp,
@@ -154,6 +162,9 @@ static int debugfs_locked_down(struct inode *inode,
 	    !real_fops->mmap)
 		return 0;
 
+	if (relay_bypass_lockdown(inode, real_fops))
+		return 0;
+
 	if (security_locked_down(LOCKDOWN_DEBUGFS))
 		return -EPERM;
 
diff --git a/include/linux/relay.h b/include/linux/relay.h
index 72b876dd5cb8..0fd1fb638434 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -147,6 +147,19 @@ struct rchan_callbacks
 	 * This callback is mandatory.
 	 */
 	int (*remove_buf_file)(struct dentry *dentry);
+
+	/*
+	 * bypass_lockdown - check whether file can be accessed in lockdown mode.
+	 *
+	 * Called during file open. It depends on each relay user to tell whether
+	 * accessing the file is safe or not in lockdown mode.
+	 *
+	 * The callback should return "true" if allowing access, "false" if not.
+	 *
+	 * This callback is optional. If not set, accessing the file will be
+	 * denied in lockdown mode.
+	 */
+	bool (*bypass_lockdown)(struct inode *inode);
 };
 
 /*
@@ -279,8 +292,11 @@ extern const struct file_operations relay_file_operations;
 
 #ifdef CONFIG_RELAY
 int relay_prepare_cpu(unsigned int cpu);
+extern bool relay_bypass_lockdown(struct inode *inode,
+				 const struct file_operations *fops);
 #else
 #define relay_prepare_cpu     NULL
+#define relay_bypass_lockdown(inode, fops)    (false)
 #endif
 
 #endif /* _LINUX_RELAY_H */
diff --git a/kernel/relay.c b/kernel/relay.c
index 9aa70ae53d24..d5a76566ef62 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1234,6 +1234,23 @@ static ssize_t relay_file_splice_read(struct file *in,
 	return ret;
 }
 
+bool relay_bypass_lockdown(struct inode *inode,
+				 const struct file_operations *fops)
+{
+	struct rchan_buf *buf;
+
+	/* Not a relay file */
+	if (fops != &relay_file_operations)
+		return false;
+
+	buf = (struct rchan_buf *)inode->i_private;
+	if (!buf->chan->cb->bypass_lockdown)
+		return false;
+
+	return buf->chan->cb->bypass_lockdown(inode);
+}
+EXPORT_SYMBOL_GPL(relay_bypass_lockdown);
+
 const struct file_operations relay_file_operations = {
 	.open		= relay_file_open,
 	.poll		= relay_file_poll,
-- 
2.24.3 (Apple Git-128)

