Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9618D610229
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiJ0T62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiJ0T60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:58:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB6876AB;
        Thu, 27 Oct 2022 12:58:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHn0qW019874;
        Thu, 27 Oct 2022 19:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=hafRT3cbaR0JvZQBfXnlGBpP2JcVzJVAiWG91/wkYnA=;
 b=flD9g9Dk8Z5QPAKyrsPGB+MFaKmVfX9eprOiYkU3nzrnmnDXJyXPoMdpx2qvNhCYchUn
 p0iIyGScAP1ixkQ7SVJ/jIwgHtsWJrco884lgThJ6tec0JvPzU4mq/9ut0a28UERLs+x
 lA1ENUhit4Vw/O4zkvhVgLyjcQKQnI+X5hUjW8jL/QxvfdDnWQ/PQ5aagl5W4clKlnOD
 9+aY6ReZzq+bG+BUEXFFQ4r5/v8gfzG/9O4e8GAhExzPMzH/Er+jNfuOV9kGfZCvSXF0
 gDlS00x5Kk9VSGSOYeNCgZzdlQDL9a25jJbI1vEFdcyFETCLAFtSu3ki45buMTOLefsX +w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7u2yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RJvqx4006906;
        Thu, 27 Oct 2022 19:58:15 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghb12u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrAwNqqzubprugX7VbFfhALB7OCYK/EfoHKRrRy472x7AvUrLuHOebjf0VZpz5bqbnMxFdagNJjBVGgPAjwMAcKAoGKo+yiXSnK/5I9xvWmbxlO6RShdJgdm4oyDY/NA3Z6i+RFi2kRFUkTT5W2aGhzvxmtsGfJshAFclVP6TlRVpyizSitch58F8vMzWc2hhzPVtx9Sto4SSx5+xRYEC2u696GBM1RsapW8a7AgOcBu5qD10DaMFzbP2mKXB55rCtVh46W6oJrgvgVytBYNFZT6y5WkGYgUU7ozFHdXXv7BrLc4gTW46gRRKmNVZ7YXCoTovsg8/SXoCh78jTZcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hafRT3cbaR0JvZQBfXnlGBpP2JcVzJVAiWG91/wkYnA=;
 b=RbR47NKpFKz3EoyQbfkCcIGO4wy6RumQCv0jviK1wlVTpq0ZZVAqi7k7C9ClDRaVoZjFoLFtOyEfBmwmViJeD1FbNxKpbRH/0LreCb+83Ykxqnsa2GwF4vVLHzzEogXRF1sXDHva0VdBp54Qn2dMo2jxtfvVQQx6wfDMNq97RkkJFkVyTzeQ1vNXGdmTpdLEGMrlf+FQilRin+Qs5va5HhK0pptesm+a0WSiUV321izN67xdlI/QGs1Y6xwlMQ5OlvDBjxQeTwlrjuYR5K3pyePRIHdNcq4LeWwozRTzUu0ZGhAP7dxQ9dB8nYneT4xo+ah2x801bCfgsu7QbJkHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hafRT3cbaR0JvZQBfXnlGBpP2JcVzJVAiWG91/wkYnA=;
 b=Q8CIEog23HS/cmr5Zqcr382zx2kvBvMnpRycnCiUOJo2bH/NGzbgg/gBzVN5TwjCpddl0bkSqnQwIi3UYMkI1OZzMNFv0mpbkOVsdmjQqKIiBxmOQjbVHlvJv6vYiGm/geFbsmA/Zjyz2EiNUuQE/oxOJY3i4ORgv9440xEKT2c=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BL3PR10MB6042.namprd10.prod.outlook.com (2603:10b6:208:3b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 27 Oct
 2022 19:58:13 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 19:58:13 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org, masahiroy@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 1/8] kbuild: bring back tristate.conf
Date:   Thu, 27 Oct 2022 20:57:47 +0100
Message-Id: <20221027195754.100039-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221027195754.100039-1-nick.alcock@oracle.com>
References: <20221027195754.100039-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0108.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::24) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BL3PR10MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a94aa39-c8c6-4c73-6863-08dab8559465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyTdRbLn8N0tTX9NkQGUQA+/SotDEnMn7fAcBHzgFwTUO3TFa79STkfv0A09AaqYGNH6FINYe4D5NwTLpQEE5NJj0MlUrCsdsJR2TLwQSC0HYLdFkjGdF/mFlKXeEdoVhmNHceNqvA2UDbYxDzYV2JrPSNH8Pj08nLqv3dKxY6hH4lix2ktlHnAfQJ56k+esKQsFRp3kz2FU5AyMLDVd4o4Cl73izvdGlIc3AdE8qkn55xP9aFxJ/3KUsrOcI/mv+izywdwPv09jFw7V/2RuIYuQw7v6orVntPaYBaVMKSbiLrFl/GCywfArjmSOMO54YufYbPP2ffHzJK+ekUHrlhPUKD0z1MyZooHNjHe3YWF6kyiLECy6cX7zFzEUL6tdkIUinEWRUKSHz4uo4IFS0yp4G9qZtKxZzJMQkZM26HFiJ1IQ3YHw9SdBcWxHL2CsoZ7yxuTMfUS6AEMMvD2RE6qQ9/pWDUu6g6HOpfdO1WzHI7yGdEAfoELXc1zq3jCClNuxY2h9FHmQjUd7ueYai9EjS2TYf7Jq/D5GtNSBumxku88nfoU01mHau6klQW56SjgScNZcVeW2lTh93p2WmBcE+TLKn3YXNwzShm1vtuxX2vo4Fdwy4HkGiU3Xw3+5hcnKQZ8ub+WAWWsw2a8YDV/vZrtU0Awt+I4PJY/oujLCEYKx1RJT9f4meQH24oy2SyK2f5sm9EDcAd7set3gSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(83380400001)(41300700001)(478600001)(66476007)(6506007)(6486002)(8936002)(316002)(6666004)(5660300002)(2616005)(4326008)(66946007)(36756003)(2906002)(6512007)(66556008)(86362001)(107886003)(44832011)(8676002)(186003)(1076003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/FeXlbXKKU9FwLsxQX1ANNfdOcK+vlYoJId+sR6bPd5GNezRuEEJU5CrCHTm?=
 =?us-ascii?Q?HsA3cCJr+GqgTH+q22fFzkXgCY/NxmeFY06aoqdi+GLJACTe5pXVW69XGm+t?=
 =?us-ascii?Q?82Jj3MRE0yLb7wIkrNRYnumKWzqo0IWmwN0DkIC8WPpY09awfe5SvtkZHAvm?=
 =?us-ascii?Q?I+I/WkRqQxVeHcmKO0psETS5Cq/JwCKXbKSKSaUWaAH3AbAADAqzcKorO5zy?=
 =?us-ascii?Q?EZRy9tCr6TqTD8Pltk+284LYB8w31mwgzLU0LEPTmu3eynTeFz/3eDVS1kEX?=
 =?us-ascii?Q?6nTSYLFO8jPDFPbELg1/zCHORae6u38aQrSq7twNm24svgTKCdQmY3hWZer4?=
 =?us-ascii?Q?SBfNpOTzPuO8OV3N+gWjTRMHEri8eRfWVTMzgzpBV+X382r00A4neNBkWKKQ?=
 =?us-ascii?Q?tAUTBHJOaK+r0U+3aTJiwRXPnbGXgM42fmghql4LfoVv+sMF0S1vVUqNjftq?=
 =?us-ascii?Q?n8hhTU65N6bITMjwRuYEu9SrBOBEdGPH4hSjy9XQJfzb+MAXsVtVqnxnzosu?=
 =?us-ascii?Q?99b/FvTFMjc5ZP8HLho8ARCHCK+5HEu4xpDApfOIpaK7FZvMBzmO3W+ixw2e?=
 =?us-ascii?Q?u8tDgLdoNEqCQXAgRGLJoOb1g+I/L7a2xGSOI09+0efD/vMhSN1lKzOR2F9k?=
 =?us-ascii?Q?dvMcmQYMudr5cp6UBmYCHA/3QN715OEI38uuGFuZxDkRg8k2qn76VWw57x04?=
 =?us-ascii?Q?6eVgNCiMZ3KymWCwjZOF6sE3PjjUaKzbhlP+0ggPDos3049uwYzlCL7j6Mq1?=
 =?us-ascii?Q?obvrw9REVEjHl01TrQ9cd9fpwQMz6AbrhBLeOMLizD5CCbL+7EO45n5PnfWS?=
 =?us-ascii?Q?PKXSTCDvxRBKqgtNDbdxAMlLBC4TT8jSWFeIZqXz0Y9l6jM49b93W5+2+57i?=
 =?us-ascii?Q?JNWiScJX9qRFxyfHPQDpDNEEPIAnpciI0nRbsl65d2gzfsQCWeVnVSvfk1VY?=
 =?us-ascii?Q?8mJYEyF5h9cdPf5dAH3P9L9ziE35kncimRu20yqJmUQfv97pez0wzyA+0rky?=
 =?us-ascii?Q?h2OTyMC4u287eFHVRkB5FUN9oScn8sL4+2qsAzamStwikFAVdmpg/gLHqNg0?=
 =?us-ascii?Q?rALAdQXMek2ESNiFJcwQwcHp5ZmP28csiBVLZDMc64Zs+rzmJoDyxhszqbtj?=
 =?us-ascii?Q?OKQ1wv+6p1SirqPx6r2gbAs31UQqgYuAOoCYwaAQzeqWApGemrkyMIa+rdkK?=
 =?us-ascii?Q?Y2UzhZetpECdBM7l33QsC1Jgswt94DHj6tYzepjJWPsz52q/u/wHKiYp+F3H?=
 =?us-ascii?Q?tzEElg7pSmVe8AZwwNIkB5irC8tjOS7wsPc8EN9mMoGZFi5LAK8mpZE3TpgK?=
 =?us-ascii?Q?4QY8GKsdzfXy1uJCgPPZOPWilJQcyD9XDvo09mP/gQsgXvEeUv1AIyRm+q7L?=
 =?us-ascii?Q?Xx68XB9TvfV/xeq9X4FobSQefPYfpUKdp8O1yLg4quQ5CatnzZUi4OiC0nmj?=
 =?us-ascii?Q?O1n4vuoA9pcCAHdaJazaZ7IHR6Ftr7G2N8IsSV4fdPUdjnqd6PZSg5GNFTnu?=
 =?us-ascii?Q?/n2zOomgC0Pk2g1RB9oi1I9enzYu8OmhLzxoRgTBeFZU5hlhu1wOPGiKevtK?=
 =?us-ascii?Q?OhyVfgQopb4YQqBxPgENez7zQyZjzr7QWJ8bK4HqjVZo+aUbwpDWuylcbUHX?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a94aa39-c8c6-4c73-6863-08dab8559465
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:58:12.9626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2pwYrsyUNkhJbnhoW8Mufcc8YYthHDLkA7YQ6wkqCkGiXWQEUvHkN03wrenyWHd+jwSEkW3woVYlKXgu1j29g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270112
X-Proofpoint-GUID: QztShrEen4mrEhanTBNP1v3u2_RVymMk
X-Proofpoint-ORIG-GUID: QztShrEen4mrEhanTBNP1v3u2_RVymMk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tristate.conf was dropped because it is not needed to build a
modules.builtin (although dropping it introduces a few false positives
into modules.builtin support), and doing so avoids one round of
recursion through the build tree to build it.  But kallmodsyms support
requires building a mapping from object file name to built-in module
name for all builtin modules: this seems to me impossible to accomplish
without parsing all makefiles under the influence of tristate.conf,
since the makefiles are the only place this mapping is recorded.

So bring it back for this purpose.  (Thanks to the refactoring in
the 5.16 timeframe, this is basically a reimplementation of commit
8b41fc4454e36fbfdbb23f940d023d4dece2de29 rather than a simple
reversion.)

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Victor Erminpour <victor.erminpour@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v7: rewrite in terms of the new confdata refactoring
    v8: adjust for changes in 5.17 merge window

 Documentation/kbuild/kconfig.rst |  5 ++++
 Makefile                         |  2 +-
 scripts/kconfig/confdata.c       | 41 +++++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/Documentation/kbuild/kconfig.rst b/Documentation/kbuild/kconfig.rst
index 5967c79c3baa..e2c78760d442 100644
--- a/Documentation/kbuild/kconfig.rst
+++ b/Documentation/kbuild/kconfig.rst
@@ -162,6 +162,11 @@ KCONFIG_AUTOCONFIG
 This environment variable can be set to specify the path & name of the
 "auto.conf" file.  Its default value is "include/config/auto.conf".
 
+KCONFIG_TRISTATE
+----------------
+This environment variable can be set to specify the path & name of the
+"tristate.conf" file.  Its default value is "include/config/tristate.conf".
+
 KCONFIG_AUTOHEADER
 ------------------
 This environment variable can be set to specify the path & name of the
diff --git a/Makefile b/Makefile
index d148a55bfd0f..5d26447fecb8 100644
--- a/Makefile
+++ b/Makefile
@@ -793,7 +793,7 @@ $(KCONFIG_CONFIG):
 #
 # Do not use $(call cmd,...) here. That would suppress prompts from syncconfig,
 # so you cannot notice that Kconfig is waiting for the user input.
-%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h %/generated/rustc_cfg: $(KCONFIG_CONFIG)
+%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h %/generated/rustc_cfg %/tristate.conf: $(KCONFIG_CONFIG)
 	$(Q)$(kecho) "  SYNC    $@"
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else # !may-sync-config
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index b7c9f1dd5e42..160d12b69957 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -223,6 +223,13 @@ static const char *conf_get_rustccfg_name(void)
 	return name ? name : "include/generated/rustc_cfg";
 }
 
+static const char *conf_get_tristate_name(void)
+{
+	char *name = getenv("KCONFIG_TRISTATE");
+
+	return name ? name : "include/config/tristate.conf";
+}
+
 static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 {
 	char *p2;
@@ -670,8 +677,12 @@ static char *escape_string_value(const char *in)
 
 enum output_n { OUTPUT_N, OUTPUT_N_AS_UNSET, OUTPUT_N_NONE };
 
+#define PRINT_ESCAPE		0x01
+#define PRINT_UPCASE		0x02
+#define PRINT_TRISTATE_ONLY	0x04
+
 static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
-			   bool escape_string)
+			   int flags)
 {
 	const char *val;
 	char *escaped = NULL;
@@ -679,6 +690,9 @@ static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
 	if (sym->type == S_UNKNOWN)
 		return;
 
+	if (flags & PRINT_TRISTATE_ONLY && sym->type != S_TRISTATE)
+		return;
+
 	val = sym_get_string_value(sym);
 
 	if ((sym->type == S_BOOLEAN || sym->type == S_TRISTATE) &&
@@ -688,29 +702,38 @@ static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
 		return;
 	}
 
-	if (sym->type == S_STRING && escape_string) {
+	if (sym->type == S_STRING && flags & PRINT_ESCAPE) {
 		escaped = escape_string_value(val);
 		val = escaped;
 	}
 
-	fprintf(fp, "%s%s=%s\n", CONFIG_, sym->name, val);
+	if (flags & PRINT_UPCASE)
+		fprintf(fp, "%s%s=%c\n", CONFIG_, sym->name, (char)toupper(*val));
+	else
+		fprintf(fp, "%s%s=%s\n", CONFIG_, sym->name, val);
 
 	free(escaped);
 }
 
 static void print_symbol_for_dotconfig(FILE *fp, struct symbol *sym)
 {
-	__print_symbol(fp, sym, OUTPUT_N_AS_UNSET, true);
+	__print_symbol(fp, sym, OUTPUT_N_AS_UNSET, PRINT_ESCAPE);
 }
 
 static void print_symbol_for_autoconf(FILE *fp, struct symbol *sym)
 {
-	__print_symbol(fp, sym, OUTPUT_N_NONE, false);
+	__print_symbol(fp, sym, OUTPUT_N_NONE, 0);
+}
+
+static void print_symbol_for_tristate(FILE *fp, struct symbol *sym)
+{
+	__print_symbol(fp, sym, OUTPUT_N_NONE, PRINT_ESCAPE | PRINT_UPCASE |
+		       PRINT_TRISTATE_ONLY);
 }
 
 void print_symbol_for_listconfig(struct symbol *sym)
 {
-	__print_symbol(stdout, sym, OUTPUT_N, true);
+	__print_symbol(stdout, sym, OUTPUT_N, PRINT_ESCAPE);
 }
 
 static void print_symbol_for_c(FILE *fp, struct symbol *sym)
@@ -1207,6 +1230,12 @@ int conf_write_autoconf(int overwrite)
 	if (ret)
 		return ret;
 
+	ret = __conf_write_autoconf(conf_get_tristate_name(),
+				    print_symbol_for_tristate,
+				    &comment_style_pound);
+	if (ret)
+		return ret;
+
 	/*
 	 * Create include/config/auto.conf. This must be the last step because
 	 * Kbuild has a dependency on auto.conf and this marks the successful
-- 
2.38.0.266.g481848f278

