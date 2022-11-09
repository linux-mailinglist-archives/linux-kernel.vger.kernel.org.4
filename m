Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18E622CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiKINxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiKINxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:53:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9842ED5D;
        Wed,  9 Nov 2022 05:53:01 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9DlkcU027743;
        Wed, 9 Nov 2022 13:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1z6C9gtkixehzLN/UpkpEQAvPNA7JZPk/QsoJZ6Xg60=;
 b=DMRAstWGBzxcmafXNBlunjvmRW82MCBXFP7ZWM5wBkFNcAbxOjV5Eq134EywxBKN0rGl
 gHU79ub3By46AqyUCvNUay+GHyYcZPGL8LlqUFOqgDf01njH3scldUstPve2C67IdKvt
 /ty6/txnaL3yys0895XkGGV+lcDXLfTTutvssanxNdA2ydf7iup8GNqkvR64ZlrxdK8q
 owE4mBo0PVRkakwZ5jCtSTtGVta7g6VT30/qXy7Ua3AyFLWtys7AQYA7bO5mKVAofG+2
 JDr86qicO8GVyy04k/aaszCGFUhDH3FznO9DQUOO3fAw6LgkyRD91ycMOR850FMQBbY/ BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krddar0bt-21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:52:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9CxQBH017819;
        Wed, 9 Nov 2022 13:42:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctdn8pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCu+Mm5XiEnvn1+oKEJvmDu69zKcmefQpTXV/xnAQxktmu2Q//flyCVHjEH6d92NhM/QAzFx2ggonmibatVv1vrWTYORn5t+PZNkP7vaG8imgrkeHnuO2w4A849ITy+0DP3sG9mnvBA9WZ00bHuGZff7kUL6nCMwwY1f1/GV5KUhgKZ2AkUF4m3k63/z5A6xm1QOKfPifzXPu1DoXTaMef/5reqm3TNlpOzRb6EAZb19pmeihS9WiTdjYPx5uZi7icFD3sQU83cspLCOteO4EzpySPHV3f69/6FGLf3tplM55pmgXGB/Y7sWszRQN03i7x8a0KdmcNmi4ameECBcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z6C9gtkixehzLN/UpkpEQAvPNA7JZPk/QsoJZ6Xg60=;
 b=geIghMuqDJZSjlHxgeYN9KZSjQ2sNDh537Y1T3Prs9A28IiH+CpwsIrlLbBr79bjwkElTX0iRwRFt3cWk3MC95IYmCxyiyZx5UeRa0NxIH8GdzxHI9d1RJU+Qr79GOjRpspgRFf9xDpYpkxzmt2H6TEag3ZkdnUw7zGYSTWCdnCUk1u0U4U6d3BKa/xzxd4IyETovh2HgkdBJNWyybXHOjvc7d7EyBAJrc2loG8awW4ry98LHI+f/xGM7gpStW4vfDqIUIOhOH8dj5iCx9k0o/i/ULeJEX8sefrrOO++O675aDpvIgX6HQ6o3zVtX4e3dbhXkxzQfwbJwiRx98jfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z6C9gtkixehzLN/UpkpEQAvPNA7JZPk/QsoJZ6Xg60=;
 b=BjexByZ70m7yIUYrISSWCUoYRYmdnyzubqNdyWoUnV9GxLPSxj2PEprSWQm4QTHXUnW0b5JZqKTwJlcVnxtq2LhX9gG0oCcnGHAjQvKa8r4Sd5rD2T3/dZYj9XUG0LaYApahIWa724dEEZ5xAVUocypm6e7BMMheJgXneWAADH0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 13:41:59 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:41:59 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 2/8] kbuild: add modules_thick.builtin
Date:   Wed,  9 Nov 2022 13:41:26 +0000
Message-Id: <20221109134132.9052-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221109134132.9052-1-nick.alcock@oracle.com>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0209.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BLAPR10MB4817:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd5365c-a865-424c-bf10-08dac2582cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJquKyCBWbx+kbPXXfNpOezlVVmi74v0nwKj5GLSRJ9zHpoA913xD02B9gAmQbP2SwDEb0iSOga0VQqohWtol///aj3xgFYs4XAxS6q7b223H6qX/dqjEsAC54j/Ca4FwP4xdRxUdKUf98/m2AtR3u4VGNHsFgVsrczetIICe+6XGW2J/m1QyeGA3zRLZmsrQTt6m+K7vXyBAIma9xmT2I9edCl1Otzg7MznRNFt6dCXozgL2GP0MA3BkHht5djnam943i/m/PRw7+Shh3QVV3N+GnUs8mvCV93/J0p18KSQsw2j+m3Hx7UUcQWy4lfGWlIQLswjtl9pvQ3bM5ie9AZN+Z+p7GMz2ifCont3/dRBvLG8nCciiTzhlo2CPmcet5VZ8JmtyDevyYg3cV5ayt9OknUTmwQTSAuydM/zyob5f5TmQon8BwwDxRI+lawvQMb+m1BCUF6cclYMEs+nK7OxLicfjgLa1BVYphlKe+Hoy/NQsZjLdrtj+WZ6Y3SQo4agURE3YJbelcy+V4wUeJtRgD2Ciu3LmPTm6lQJXsv4KNrQ6OEZE5VOvyzk2UQgB2p2UCxmDrM6/1xG4u86OI8H0UOOvt8lBZksxqenLVXrQmCY5pu+KzxrZCqC2mOp/DXvIoIX2P646rezGkBKmsBNaY+gJfxplqP80Eruuu5TVaRMm4h+Z2sy7Ic1SAhUlM9RiOa1oxqvo4cbiiuumwCla2LwKnxHUSWZmW/vFLbTGyB0vNIAyP+r13xXpi/f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(2616005)(66556008)(186003)(83380400001)(1076003)(38100700002)(6512007)(5660300002)(8936002)(30864003)(2906002)(6506007)(4326008)(6486002)(478600001)(6666004)(107886003)(66476007)(8676002)(66946007)(316002)(44832011)(41300700001)(86362001)(36756003)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?It/ATvnm4at35qxdWRnmIdWdZV+h1HNuTiPypHOHJFNHAlk1X7UAO5FJ57vB?=
 =?us-ascii?Q?01DXmdm7jutXc7vmjnA40vIcb1U8RoJD9kK1C5bk9RMUXEE7q4C9XWGQoK6/?=
 =?us-ascii?Q?3gOzFo9+iHPQZha3HBHTjsIpjtzhHqlS1NcQupeNxV7TBZ2zDeRQygS1DXRj?=
 =?us-ascii?Q?2b5VQ3Y35fl3jB51jJJ5DZmqigH40raUHOpVsOkcmX/f32sH9LOXFGuxqckT?=
 =?us-ascii?Q?ANULT06TZJPV+Bk9XyNq1Pzd9YEGROY7XyGq8U4W3b036uW/Xgl4Vyl4WKAp?=
 =?us-ascii?Q?PProwRpr1TEEdhDJR4e/XEB4A7fSytojBZsH64RrQgl4FJgA00qg78cbn83x?=
 =?us-ascii?Q?LdMN8kOVGvSvNTs3XQDBNjytafJz4uTYDsD6ivCSRSoQixol3EgEZkzWaJ1g?=
 =?us-ascii?Q?4jTpofOj/vxttc094kp44o0//x2MMAEMN0GcIhSiCtfCYYeMzvrAYTWQ4ii3?=
 =?us-ascii?Q?M+kO4hm/tWVvtnFD+tSxAoZqGeKlig6HQ8gN1et0ysvDzQ71I+eV8G8hiEIA?=
 =?us-ascii?Q?s96Cga653sHr/QrkX/a7I+MlbJbhGZrR/KSeWhsf614g/NajN5BvD3NPSBst?=
 =?us-ascii?Q?430OoVCag4YlQ+fPwee4y8V925w0R1YxQeLh0zonsv4Vh31ZJyKMSx6h6f8j?=
 =?us-ascii?Q?Yu6mysOas4XgdBIaDG7jq7bn+NiFW/jPGdqYWTP7B8rzsFyn0MuV9l56pKr2?=
 =?us-ascii?Q?x33LfZsZQfRiBOaO5IyaQ8nJQ4BQdZaYA2L/p2MLp/vpkPFMIXoB/slqNi5w?=
 =?us-ascii?Q?zyGdbv1u5DVg7vD/qKsukLHSsxGkEtRJJFFLkIyyMzvfg6v4yswm46pzQ5Vr?=
 =?us-ascii?Q?tXkXOv2Iywm1APHO/TJxhbdFPRA3gX7UOaRR/A2eX3aFmHBr9SOHK+0e8i1D?=
 =?us-ascii?Q?dqhOxkaQCfaEA2MoQuIw0VX3AaDp3cA14LoTyyTGb/6HWde5aeYGb8rGqwWQ?=
 =?us-ascii?Q?0txOrpipWMFS176xOkM7pbbACK0fgUVdPp1cvT7yvI2TDn9dBanlSSY4Lpfb?=
 =?us-ascii?Q?Q05zCc8DBRaHZK9XVJpCasZGr+g/We1mLDXelIAEoLzWYTX9S1/viMgdV7II?=
 =?us-ascii?Q?D9EDNMXr0VSshQG85qiNGinN7UBvBV5wqWw5pjwBvFlM+9lAe2G2IetREE8k?=
 =?us-ascii?Q?rw25dKQsjGkksBZyyj8CyOfKUg56lvkPEk6x1j3/2LCNmBP7WNcdmNE57xM6?=
 =?us-ascii?Q?oulf1XhfZEO51lNk2VsjEHFlqZKd3bkO1VA+xmz/q0E/nNclVrs97g1WIHN3?=
 =?us-ascii?Q?ZyzL5ctB0ZO++ljXfHqlFIrp5k/GJV2Pk1TuQ3NH4VwSVsWNvSdwWFRA346T?=
 =?us-ascii?Q?cks8m4WjgKumkwqs4sDzBxGwTSYVc2XR+z1/M3E8ulq5SHyKLgoxrElVsM88?=
 =?us-ascii?Q?T+iwiiKV1pWTFpwMFo28JnEWKwONDauybnLo1VKZ4eqgCEMVXVN5v9cKAmPb?=
 =?us-ascii?Q?yYgjNJB2+2+SbBK8nJ5abIdb5vNG4UMJDc1QrCti+WZja9uY3Do97aTKorD0?=
 =?us-ascii?Q?UsH2v/MCRKh4smnTYea5V/+RixKyIwkp6ygmXSIWdENDyMr1x2JnOoY2jnbj?=
 =?us-ascii?Q?AXBcfjxV6xXl6FCR6EumECbOWv2y1FYiqlFUCnJQ6NIm72ahHAy0yXhkWTYb?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd5365c-a865-424c-bf10-08dac2582cfe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:41:59.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9uWAdFrI2Yr1SQ/GorhH3qJHlBcm8WocQ2afIbdziqpofSGKwbwfbhHjBabHBKoEdMSydm/9ZXph/aYEXdqdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090104
X-Proofpoint-GUID: MXNvhTqpoBrO3oVUE4aNUvJqhZEXNtL3
X-Proofpoint-ORIG-GUID: MXNvhTqpoBrO3oVUE4aNUvJqhZEXNtL3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is similar to modules.builtin, and constructed in a similar way to
the way that used to be built before commit
8b41fc4454e36fbfdbb23f940d023d4dece2de29, via tristate.conf inclusion
and recursive concatenation up the tree. Unlike modules.builtin,
modules_thick.builtin gives the names of the object files that make up
modules that are comprised of more than one object file, using a syntax
similar to that of makefiles, e.g.:

crypto/crypto.o: crypto/api.o crypto/cipher.o crypto/compress.o crypto/memneq.o
crypto/crypto_algapi.o: crypto/algapi.o crypto/proc.o crypto/scatterwalk.o
crypto/aead.o:
crypto/geniv.o:

(where the latter two are single-file modules).

An upcoming commit will use this mapping to populate /proc/kallmodsyms.

A parser is included that yields a stram of (module, objfile name[])
mappings: it's a bit baroque, but then parsing text files in C is quite
painful, and I'd rather put the complexity in here than in its callers.
The parser is not built in this commit, nor does it have any callers
yet; nor is any rule added that causes modules_thick.builtin to actually
be constructed.  (Again, see a later commit for that.)

I am not wedded to the approach used to construct this file, but I don't
see any other way to do it despite spending a week or so trying to tie
it into Kbuild without using a separate Makefile.modbuiltin: unlike the
names of builtin modules (which are also recorded in the source files
themseves via MODULE_*() macros) the mapping from object file name to
built-in module name is not recorded anywhere but in the makefiles
themselves, so we have to at least reparse them with something to
indicate the builtin-ness of each module (i.e., tristate.conf) if we are
to figure out which modules are built-in and which are not.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v9: move modules_thick.builtin generation into the top-level Kbuild

 .gitignore                  |   1 +
 Documentation/dontdiff      |   1 +
 Kbuild                      |  16 +++
 Makefile                    |   2 +-
 scripts/Kbuild.include      |   6 ++
 scripts/Makefile.modbuiltin |  56 ++++++++++
 scripts/modules_thick.c     | 200 ++++++++++++++++++++++++++++++++++++
 scripts/modules_thick.h     |  48 +++++++++
 8 files changed, 329 insertions(+), 1 deletion(-)
 create mode 100644 scripts/Makefile.modbuiltin
 create mode 100644 scripts/modules_thick.c
 create mode 100644 scripts/modules_thick.h

diff --git a/.gitignore b/.gitignore
index 5da004814678..f129bf52cbd4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -52,6 +52,7 @@
 *.zst
 Module.symvers
 modules.order
+modules_thick.builtin
 
 #
 # Top-level generic files
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 352ff53a2306..077d43b9675d 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -183,6 +183,7 @@ modules.builtin
 modules.builtin.modinfo
 modules.nsdeps
 modules.order
+modules_thick.builtin
 modversions.h*
 nconf
 nconf-cfg
diff --git a/Kbuild b/Kbuild
index 464b34a08f51..a84e8312c174 100644
--- a/Kbuild
+++ b/Kbuild
@@ -97,3 +97,19 @@ obj-$(CONFIG_SAMPLES)	+= samples/
 obj-$(CONFIG_NET)	+= net/
 obj-y			+= virt/
 obj-y			+= $(ARCH_DRIVERS)
+
+# Generate modules_thick.builtin if needed.
+#
+# modules_thick.builtin maps from kernel modules (or rather the object file
+# names they would have had had they not been built in) to their constituent
+# object files: we can use this to determine which modules any given object
+# file is part of.  (We cannot eliminate the slight redundancy here without
+# double-expansion.)
+
+modthickbuiltin-files := $(addsuffix modules_thick.builtin, $(filter %/,$(obj-y)))
+
+$(modthickbuiltin-files): include/config/tristate.conf
+	$(Q)$(MAKE) $(modbuiltin)=$(patsubst %/modules_thick.builtin,%,$@) builtin-file=modules_thick.builtin
+
+modules_thick.builtin: $(modthickbuiltin-files) $(obj-y)
+	$(Q)$(AWK) '!x[$$0]++' $(patsubst %/built-in.a, %/$@, $(filter %/built-in.a,$(obj-y))) > $@
diff --git a/Makefile b/Makefile
index 5d26447fecb8..21117f9d4202 100644
--- a/Makefile
+++ b/Makefile
@@ -2008,7 +2008,7 @@ clean: $(clean-dirs)
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name '.tmp_*' \
+		-o -name '.tmp_*' -o -name modules_thick.builtin \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 2bc08ace38a3..28d5eb7a9b61 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -78,6 +78,12 @@ endef
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(srctree)/scripts/Makefile.build obj
 
+###
+# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.modbuiltin obj=
+# Usage:
+# $(Q)$(MAKE) $(modbuiltin)=dir
+modbuiltin := -f $(srctree)/scripts/Makefile.modbuiltin obj
+
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
 # Usage:
diff --git a/scripts/Makefile.modbuiltin b/scripts/Makefile.modbuiltin
new file mode 100644
index 000000000000..a27b692ea795
--- /dev/null
+++ b/scripts/Makefile.modbuiltin
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Generating modules_thick.builtin
+# ==========================================================================
+
+src := $(obj)
+
+PHONY := __modbuiltin
+__modbuiltin:
+
+include include/config/auto.conf
+# tristate.conf sets tristate variables to uppercase 'Y' or 'M'
+# That way, we get the list of built-in modules in obj-Y
+include include/config/tristate.conf
+
+include scripts/Kbuild.include
+
+ifdef building_out_of_srctree
+# Create output directory if not already present
+_dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
+endif
+
+# The filename Kbuild has precedence over Makefile
+kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
+kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
+include $(kbuild-file)
+
+include scripts/Makefile.lib
+
+modthickbuiltin-subdirs := $(patsubst %,%/modules_thick.builtin, $(subdir-ym))
+modthickbuiltin-target  := $(obj)/modules_thick.builtin
+
+__modbuiltin: $(obj)/$(builtin-file) $(subdir-ym)
+	@:
+
+$(modthickbuiltin-target): $(subdir-ym) FORCE
+	$(Q) rm -f $@
+	$(Q) $(foreach mod-o, $(filter %.o,$(obj-Y)),\
+		printf "%s:" $(addprefix $(obj)/,$(mod-o)) >> $@; \
+		printf " %s" $(sort $(strip $(addprefix $(obj)/,$($(mod-o:.o=-objs)) \
+			$($(mod-o:.o=-y)) $($(mod-o:.o=-Y))))) >> $@; \
+		printf "\n" >> $@; ) \
+	cat /dev/null $(modthickbuiltin-subdirs) >> $@;
+
+PHONY += FORCE
+
+FORCE:
+
+# Descending
+# ---------------------------------------------------------------------------
+
+PHONY += $(subdir-ym)
+$(subdir-ym):
+	$(Q)$(MAKE) $(modbuiltin)=$@ builtin-file=$(builtin-file)
+
+.PHONY: $(PHONY)
diff --git a/scripts/modules_thick.c b/scripts/modules_thick.c
new file mode 100644
index 000000000000..9a15e99c1330
--- /dev/null
+++ b/scripts/modules_thick.c
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "modules_thick.h"
+
+/*
+ * Read a modules_thick.builtin file and translate it into a stream of
+ * name / module-name pairs.
+ */
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file)
+{
+	struct modules_thick_iter *i;
+
+	i = calloc(1, sizeof(struct modules_thick_iter));
+	if (i == NULL)
+		return NULL;
+
+	i->f = fopen(modules_thick_file, "r");
+
+	if (i->f == NULL) {
+		fprintf(stderr, "Cannot open builtin module file %s: %s\n",
+			modules_thick_file, strerror(errno));
+		return NULL;
+	}
+
+	return i;
+}
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name)
+{
+	size_t npaths = 1;
+	char **module_paths;
+	char *last_slash;
+	char *last_dot;
+	char *trailing_linefeed;
+	char *object_name = i->line;
+	char *dash;
+	int composite = 0;
+
+	/*
+	 * Read in all module entries, computing the suffixless, pathless name
+	 * of the module and building the next arrayful of object file names for
+	 * return.
+	 *
+	 * Modules can consist of multiple files: in this case, the portion
+	 * before the colon is the path to the module (as before): the portion
+	 * after the colon is a space-separated list of files that should be
+	 * considered part of this module.  In this case, the portion before the
+	 * name is an "object file" that does not actually exist: it is merged
+	 * into built-in.a without ever being written out.
+	 *
+	 * All module names have - translated to _, to match what is done to the
+	 * names of the same things when built as modules.
+	 */
+
+	/*
+	 * Reinvocation of exhausted iterator. Return NULL, once.
+	 */
+retry:
+	if (getline(&i->line, &i->line_size, i->f) < 0) {
+		if (ferror(i->f)) {
+			fprintf(stderr, "Error reading from modules_thick file:"
+				" %s\n", strerror(errno));
+			exit(1);
+		}
+		rewind(i->f);
+		return NULL;
+	}
+
+	if (i->line[0] == '\0')
+		goto retry;
+
+	/*
+	 * Slice the line in two at the colon, if any.  If there is anything
+	 * past the ': ', this is a composite module.  (We allow for no colon
+	 * for robustness, even though one should always be present.)
+	 */
+	if (strchr(i->line, ':') != NULL) {
+		char *name_start;
+
+		object_name = strchr(i->line, ':');
+		*object_name = '\0';
+		object_name++;
+		name_start = object_name + strspn(object_name, " \n");
+		if (*name_start != '\0') {
+			composite = 1;
+			object_name = name_start;
+		}
+	}
+
+	/*
+	 * Figure out the module name.
+	 */
+	last_slash = strrchr(i->line, '/');
+	last_slash = (!last_slash) ? i->line :
+		last_slash + 1;
+	free(*module_name);
+	*module_name = strdup(last_slash);
+	dash = *module_name;
+
+	while (dash != NULL) {
+		dash = strchr(dash, '-');
+		if (dash != NULL)
+			*dash = '_';
+	}
+
+	last_dot = strrchr(*module_name, '.');
+	if (last_dot != NULL)
+		*last_dot = '\0';
+
+	trailing_linefeed = strchr(object_name, '\n');
+	if (trailing_linefeed != NULL)
+		*trailing_linefeed = '\0';
+
+	/*
+	 * Multifile separator? Object file names explicitly stated:
+	 * slice them up and shuffle them in.
+	 *
+	 * The array size may be an overestimate if any object file
+	 * names start or end with spaces (very unlikely) but cannot be
+	 * an underestimate.  (Check for it anyway.)
+	 */
+	if (composite) {
+		char *one_object;
+
+		for (npaths = 0, one_object = object_name;
+		     one_object != NULL;
+		     npaths++, one_object = strchr(one_object + 1, ' '));
+	}
+
+	module_paths = malloc((npaths + 1) * sizeof(char *));
+	if (!module_paths) {
+		fprintf(stderr, "%s: out of memory on module %s\n", __func__,
+			*module_name);
+		exit(1);
+	}
+
+	if (composite) {
+		char *one_object;
+		size_t i = 0;
+
+		while ((one_object = strsep(&object_name, " ")) != NULL) {
+			if (i >= npaths) {
+				fprintf(stderr, "%s: num_objs overflow on module "
+					"%s: this is a bug.\n", __func__,
+					*module_name);
+				exit(1);
+			}
+
+			module_paths[i++] = one_object;
+		}
+	} else
+		module_paths[0] = i->line;	/* untransformed module name */
+
+	module_paths[npaths] = NULL;
+
+	return module_paths;
+}
+
+/*
+ * Free an iterator. Can be called while iteration is underway, so even
+ * state that is freed at the end of iteration must be freed here too.
+ */
+void
+modules_thick_iter_free(struct modules_thick_iter *i)
+{
+	if (i == NULL)
+		return;
+	fclose(i->f);
+	free(i->line);
+	free(i);
+}
diff --git a/scripts/modules_thick.h b/scripts/modules_thick.h
new file mode 100644
index 000000000000..f5edcaf9550c
--- /dev/null
+++ b/scripts/modules_thick.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _LINUX_MODULES_THICK_H
+#define _LINUX_MODULES_THICK_H
+
+#include <stdio.h>
+#include <stddef.h>
+
+/*
+ * modules_thick.builtin iteration state.
+ */
+struct modules_thick_iter {
+	FILE *f;
+	char *line;
+	size_t line_size;
+};
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file);
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name);
+
+void
+modules_thick_iter_free(struct modules_thick_iter *i);
+
+#endif
-- 
2.38.0.266.g481848f278

