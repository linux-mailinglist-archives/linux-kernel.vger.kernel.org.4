Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C52361022C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiJ0T6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbiJ0T6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:58:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A063C88A0A;
        Thu, 27 Oct 2022 12:58:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHmxq8019860;
        Thu, 27 Oct 2022 19:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1z6C9gtkixehzLN/UpkpEQAvPNA7JZPk/QsoJZ6Xg60=;
 b=OPHsqupzJ1T8gVmYGI6SMTFjOb/ESTuVFdt10eRD4k9+3YUbSQjrqVPNwnu72O3qlazJ
 EzBADwUn6JIGdJBnIUGaWjU2n1VKP/2HlUL1Ev9TRn/zMStzUIPjAWasBeAus/nqxmn0
 F1ci7VNqeOJFb9FlMZvaBk9/VnfCWEm6rPxRjuNevTWWvy8i+gRvX4h0sDX2M/MpzvIT
 MrN7e2J7fG33Bip/EAWbN7bNzQuVCDcF/QNq+3kyLYh7jQQoKSZLu2CL28XKM9J6N0bU
 advv3+V8w5hSmcq7wAF+mcINq5ZbAFTfcxYPeRH2cRR74vm6HW+waOWEAziEgt5lVYP/ 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7u304-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHgu9m027030;
        Thu, 27 Oct 2022 19:58:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagqc21j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifkSBCGd+4L8Rxb33Dmy17I0UsRxG1q+RbjtHj577e2pLeyeqK3si+Von8bQ1nny1Eag2oi12EuwZ1UinL95LF3Iwdlobr9RXfce2nIwAOMGRggStVF9GYBeYCOvmtK4CvWlL09xnPMYRNCdPdlJ4o54cziIDNMaLf2hse2vwwrospwHNTrMucmfNstLfl05TQvRKmhFHqbWvHi0hZLaQ/pVxXhkONuBR6OkoIhduoOE9Sc4xqw2/0zt9hXlUcxUV0vB+8hkTKkjmJ8pAFIeTIcLn6nLV0133iwOd6ck1R6rZnqjlfsXnS+Fho2Y7lOPXD09haCl0D5iYltVmoUPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z6C9gtkixehzLN/UpkpEQAvPNA7JZPk/QsoJZ6Xg60=;
 b=XZQXef9Cq1uqCQeIfTNCETvELweZx/4ca5TaeNwXnQN7MW0rrr8aI8x7mRUipZQ4qdKqJ5BEzhGnsemK1WqUVeshgc0XMG+C6aXe08kcK6KsHa9qVnrt11zgiRwFZQkiSHMJKmm6hJKglfoDND+5uJ/ZCIu5zmmZhY7ZRUxVid6Y4GJNIksgyR3iavgNGTcj3kFna40PphkaC73tUBwB3zFbP5ZQJlMwPK7/kGhWvCOhBS2Kn0qGQ3NKEmFGY352FtwLeeDECCMceRyJrFrYlDaY0MKn4uvWbzvKGHocozZt/fqhQGykTRvF6DvoU1wwaA4MUvN7S1xxFHHUk5sPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z6C9gtkixehzLN/UpkpEQAvPNA7JZPk/QsoJZ6Xg60=;
 b=TK8R/oRo6dIfjS5TORKo+nCpqQODuXXIjDbAwQaMTmQ9bgvXSEXkiqwugDakI4HGK7sl+/Xy5miQ45yCZX9spDdC19zVENRSVKN9FvI1kRzRHEx20Im2mAEj9JzzR7NPsGQ21zRwLcqZJhWfli7M4zKP0go23lfkxgzHa2zxOI8=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BL3PR10MB6042.namprd10.prod.outlook.com (2603:10b6:208:3b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 27 Oct
 2022 19:58:17 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 19:58:17 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org, masahiroy@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 2/8] kbuild: add modules_thick.builtin
Date:   Thu, 27 Oct 2022 20:57:48 +0100
Message-Id: <20221027195754.100039-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221027195754.100039-1-nick.alcock@oracle.com>
References: <20221027195754.100039-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BL3PR10MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 59044170-0c19-46a8-6cc2-08dab85596ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pr4bI0c9chPuuG9JX3JIGpeFVF60HYY5LSu/9tt1OQyufGLdKx/jlRcC62ATU7DBQxNUANIybsPr7tkhuHhyoQPK+R96BkTpUnN4P6pOEMwRbCDwCwv3ktn48wqAdx5M5/dYKGvof8oz0K+Z7m0ntSTEH/yRcJzbqJ3ye3l90AEQoAsdW11+7v9h5xnxFXhivZQQiapr3RoLh68eNmOGAPdkQR3qfSliQUB1NLCE+B79aWNIGa6yYFfO1YwLWUxbJ2ZYNF+7FHqlrg4B8qJkGIAb1XEYNX05ttAzV5ZYeBbvzZa7U5ut/EvoqcI8TrYJDaG4gSVS6Mpqd23xdHeJ570Q8AxZTgfkyxjQZBfN8xKGgeeRcZJdGGiOLZTxUsS0qYkqR8KVx3Z7QK0O+eA/5TQ6soSrWtYy24vZTY2KK9XRZNV1z035V5P7CVVXoJo2kVpit4sejZZySW6l0gO7/Lh6Us6SyEPgaeaFxj4ljmpYN96XS1tijHTGKc/Hh95Yo3eYHAlXyC630OumdGnnLz+4QoSODMBJql/TJQgEPDWDZffIAvKcyV6SkWKwyMnTQEi4+mbJGiJCOKTPsgn5bqn4x6vn8ulnxm/3lr/er/JPQ3RYh2QlGSlXphuwdR5u4+BQ3XN7rYb4dPMSgzHta0aeBs5k+JZ9J3p9iwXanrYUj/ssIFzfgRG8ZVMfrKZyzD4eb+l8WMLBJGBC+v4R7ndhLuyEdW2v9isaGXlrXhmzarDKbk6s8UbZ5pTGqU3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(83380400001)(41300700001)(478600001)(66476007)(6506007)(6486002)(8936002)(316002)(6666004)(30864003)(5660300002)(2616005)(4326008)(66946007)(36756003)(2906002)(6512007)(66556008)(86362001)(107886003)(44832011)(8676002)(186003)(1076003)(38100700002)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5fE7nt3mWh99CnWRIOdD/qMD+zX1f4xEj7+FRVuhli+Heb5+okFWrdlCjpzj?=
 =?us-ascii?Q?E/y/lVfbW8vXQrbWYaO6C8MK00IICJq4sfPfpc6fWeXU5/8ElVV0yJHDS2Zb?=
 =?us-ascii?Q?71E16nnPPKXvStO8R4Hx2CddMqH033NUQQioXbqX94/kroY4rB3IXxQoAPvb?=
 =?us-ascii?Q?SjZw/m5Po5KPXJbcZdw+jCvqepP4rlsVXoa14wTSa9Y/fYht4X8Eg8QONkHN?=
 =?us-ascii?Q?wqCe/4rklAZiQIqGo4KsqolRnbLtXCDrGU1phDZOnaYoHkD4YSM2IdHFAJHV?=
 =?us-ascii?Q?W7XxkxEogptlqFYip1zzslNmVRVA+ULUuuZDdc3BcD69o5YsCV7TsF2aFQEC?=
 =?us-ascii?Q?RYexYf/LlGP4bXQAY8EahUXSZC+VrjMleXJo1i1GIiiMtTAgfr2QYi7L4hw9?=
 =?us-ascii?Q?OGnAwujq0H0ATgICH5pjTyvmfWJ5WwiAuNV/38i+bOpUfX8ge4LckjDrBXqv?=
 =?us-ascii?Q?A1rrLonKvIV7xIYcByQsntO6Wfg4VIqAzwxZx79Y2MeeMI4O2P4yvBU4/lrU?=
 =?us-ascii?Q?jb7IB/CUaPKPU+eT2qn9EwFFj2P4QSufQmdcAXtDrPbZXFSd2D7IUdM3wi62?=
 =?us-ascii?Q?nNIPcsUC/Ivg4LpgErhFIMzE2+YSKS8Jtde6NFSEm7m8tA3f5+/helxdclwL?=
 =?us-ascii?Q?Bzbil29F3G/OFzjDLAVUu7nShlmkPZWupOFZ2opstuXU3tBJd6a/HUJ8lkqN?=
 =?us-ascii?Q?wCYSGQ3DtokUxxJvQ4YjkBEPuu2PDrHSpKzCOQf294QmesZ7WIgJXNGMLrRl?=
 =?us-ascii?Q?81IDHcCeZ4izT+Ktb+tHevQWK566psHCPY1eoebx5uKvVykpFagKqDIkcqJJ?=
 =?us-ascii?Q?UuDyMp7zQTI7GwgZmTh6163En5RRKA5LM+M5dcxi4O2hg2Vz+jSbo1d4HVI3?=
 =?us-ascii?Q?45I+f69YFkgzDCaBTJpqhma68puC1H7iiBKkUXUyfxAigEEY/fpryc9nLy3B?=
 =?us-ascii?Q?fKON/limB86102U/31Qb+UYUOnJbRGjMM0kEvsGpEqr001P9N7laIWrUpADy?=
 =?us-ascii?Q?bNwQMmqWWi+Q5dg1FTcVcafKfgNbf6DdIB43+Eyq0MrHRpgMZpjTs0CfuieJ?=
 =?us-ascii?Q?Mc5he7yhsTykeaSyBpq6e+m9AtLKX7SGbttaUB3bzEY4d6aAeEaHudDvRqMs?=
 =?us-ascii?Q?YtQm38vF5p8I7MyErLf89YyV/d6PkP+nqcPVDVxBZNgHT8PNav6KSXIn+eim?=
 =?us-ascii?Q?xm/EpqHtxekhDgCNhcMt46cpy4Ifyx+mMKAPY9XiCsAVmXUPBp5eGTuqAzzw?=
 =?us-ascii?Q?OiCQcT3uT6A7WU+p0s2J3QE8/wEVfYKG0pvDHFpEt2eWvo6uFKCIAy+oila4?=
 =?us-ascii?Q?RUJ22QOdLKOwte+KDIq45Dnxpo3T4xwYKHNIemadMGbalTKqtvZAVXd0PyFa?=
 =?us-ascii?Q?K0dJHFVCkzWoF8oNjQwC4+9IqSSFDgxDAdxEm7crtkh0pso+wvLYtkX3gBB/?=
 =?us-ascii?Q?1dpNuSHPp1p5xI4cGsN/vOi5TVjLQKvTI85/OEJekKXrPkhEU0g1TtmBdP3a?=
 =?us-ascii?Q?doBTHyEb3xipGD0dyCvQlwxmW5w3GzTrPD6nk1uehoi6JsKm7xhR/LeLG+gX?=
 =?us-ascii?Q?USJgVD28QD6+CF/d8DPlNbitPrgiK59R7LCiZgggGE6Rp7sT9QXlsRaLhdlN?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59044170-0c19-46a8-6cc2-08dab85596ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:58:16.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9k/vYNvxt+8opKnGZkTdhOiUKDLHvKoM3Da/YkrrX0T7z2ivcaj/In+PLlb/f0olXUjL841zhMXkjlr5lLVTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270112
X-Proofpoint-GUID: pbMprv2Kh78r1IYdRthWe2SPiCtFaAEM
X-Proofpoint-ORIG-GUID: pbMprv2Kh78r1IYdRthWe2SPiCtFaAEM
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

