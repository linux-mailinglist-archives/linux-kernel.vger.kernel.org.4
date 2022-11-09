Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E55622D0A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKIN7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKIN7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:59:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3926412E;
        Wed,  9 Nov 2022 05:59:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9DqgPf027411;
        Wed, 9 Nov 2022 13:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=hafRT3cbaR0JvZQBfXnlGBpP2JcVzJVAiWG91/wkYnA=;
 b=Zt0kx/gUcQcEAh2Pm2EnFn71DE6zqS6InnoqtkpBG8Qx8vDSieWX7WVmkYnZLRS8u17L
 csU3OaIlH+YVdIV7AMO3KrOFG8ChidNSR8Aw4lXje09d1duxdCDi0jG+XwU3mzgomVWk
 q8O6txzip291xUimnFCFjglr2hcP/ce77TGPdo5zBnG56CfZq2q0gGzSb9vSK4GQ5N31
 y2w75WODjNa1u+SKkd7JgDuOnGul4ht81ajJxEnLvkMghCHvQYOvHOiCuIWD1wlwKw41
 BJMAf5yRZ9k38hF+22pHXRHcIQvuBFgu0cjEPEXnTAbE9UVuzTpO25rWMoFTUqtIk/JN 0g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krdfkg0t4-24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:59:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9Cbjcb017960;
        Wed, 9 Nov 2022 13:41:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctdn8kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxngrQQFPe0WyP+rSG0SLAS1fzHazzvXaA24hEjRfJ2vgpJ5WRGTx+wot62GOq4gVO4QOMlt8D8SY933jHyIuySvhZtyEBupiNzkALl1Xg2pnyM2gd4L4zlsuh/n+RqulGUTTSBZtMlOhl8w+86EZNdGOA4oO2cH0Fj4FIELQg9+IzsN87mS9ndOZUqEupBk0gOK4z9CQJz9LRQusB7dYM8I7mtgddQYkAAwovnPxanN+uqaaNiyF/66OULZqZKV7b7kHMcrolrduel7T/XZKIIWdW33blDYFWJh3hSL+AY7laHmXBETzT6eoU1iLujgV9r4LDH/t9obwOChn9SNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hafRT3cbaR0JvZQBfXnlGBpP2JcVzJVAiWG91/wkYnA=;
 b=h7K8sot9F9hexgXBcoXzUInNqG4nc0zOj4rueWcttNSdV7Xt/0j+PwSj+af5zMdOXmjaoMdBeTtE9EzDlHoBVzoIqBl+2xrYu2gxnI5V+8/+kR/yH+UiVPYqn4++cjzfrw9DnJmXbL5W5fO0invKjc9thPqi1Jt+k0rpe76YxW3f4rtX6n3dN9rOVy439qC3AgQZBUrU4hdF4Bw52YqWIQuyKfUST01HFmWfk1ksK3qCfx8nBlwziGNeii/7PpC9mW/9WG1pjbhATbBOfNI2F6fYIVTvtp5FTN7UjUzfPogqZuT03doewxUJjzwB8XA3JeJBoXLrl3lem7i8tXtXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hafRT3cbaR0JvZQBfXnlGBpP2JcVzJVAiWG91/wkYnA=;
 b=SZL4aCAhFhPTBCggrs8zF7TQfgJwtBrNNGzxgxhg1jRN22445rrrydVlPtqVrpMOTECs8PQQZAl7/6X/+O5krdE2kdVIIg5vmPEYs4aDf6Jz6LC2YWpgQa4rWP9WB1VD1p8xhCKJLB+QLd9FHmykIkTzdds6o51/C2g7zoRKuA4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 13:41:55 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:41:55 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 1/8] kbuild: bring back tristate.conf
Date:   Wed,  9 Nov 2022 13:41:25 +0000
Message-Id: <20221109134132.9052-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221109134132.9052-1-nick.alcock@oracle.com>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0218.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BLAPR10MB4817:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8d8b48-b508-422d-c72d-08dac2582a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHS/mBiJCNcdU7dsgBQPPFKnqeMiyF8iUHPyi4ZrhPASYTutUAUepYa+8Ozq25mlflOXQ2ttyyxky/oSz9FBCYXq+FO6bgEN7I7xThlfH0Wi9zT/yLrZvyjgXiEyXhWZNTnf08uVAehVlLUvPkLZGW6X17PQ2tjZnt47vt83ut4spdg4jl5YX+RRPolbyRkMZMo9rQJVdBg13hFqTK3eKU00e52sptXLak9aB80wNNh2sNBE4gFsvQc0J7OMni8H1E+KMSaGxRslLDMAVcyqqiiZL1u0+wtP6L9DyCR1CRjcoIDd3VPx8hSwDoE9AsRTM7Zb/W0c3GMfkgzvHlRzrq877lbbeCAp8/EDWoYNBnplry6/CYY7zYmVo+bml8lmE3AOVXpXvHBi7crtmwgQGnyfwWwx6KrL97wSlRtTe0WHJt8cxPx5N95NvkGRtua01WFjclmHGmsKliPCDcyUBgW3lQkKdtq4f9iu+eTwKkcC6SAi8MhxCCkcp10sCHKMRYqgN6V1rQgfMTadPpXUIq1c5/UP+60DM1GJucjBZUcgwrdmcge+wb8TJVY6HDepyRDdjQq+vBAbp9Zsd2LyI2YH38i9GtJdQAGYcfGR1O7gXW9ggHyOJPJMwMK8y1H9cR7lN7009QZ6rdrBtINx3vrvbtFW+xICqr/I6uKyeTvbRF0DhBF4CD5xJr0LSuYkbYFirl8lRwuYmjTCccvLHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(2616005)(66556008)(186003)(83380400001)(1076003)(38100700002)(6512007)(5660300002)(8936002)(2906002)(6506007)(4326008)(6486002)(478600001)(6666004)(107886003)(66476007)(8676002)(66946007)(316002)(44832011)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5p+RsvTxWTETbVj3y85NuUX56bzKP/dVGNiI5qxMkbjt8BX1PTVwWj2dPt04?=
 =?us-ascii?Q?qqOkr1L5BiwRaisKIN939HsNl60GFGZLUo61f1qJRUqC/8UrZbmb7PGbPB3w?=
 =?us-ascii?Q?+9kofWefvxAper6hol0TfGR9tPnuu1Ya7g17S7hx3qlsCRfySZ+hou3+3Exs?=
 =?us-ascii?Q?eeJumWiT3eiNaiENuodYjB3P68UsH/9TWCYVMB3TUiIasOWqpmvsaprQRyKN?=
 =?us-ascii?Q?2VbsobHyhA/XcoVtBIPu7i1CPpMiTMNpjnwdxV6YpfuWzypRekfGPeAqUHsy?=
 =?us-ascii?Q?SmzruEHsOWpoU3wdkbSCqXJBfQ15UG4omt4Cy09qwUUQLgLd/kJpkaRNF6b0?=
 =?us-ascii?Q?b9l8OTvPSKWNCzbqIgtcI5lYCvADXjw5GchkIV2w0ZC0POhsNFHXS64AWP3e?=
 =?us-ascii?Q?tWEI+AtH2pLQyrm6+xxQuGZnHPYLsIrMQ0oBlME5/Qjv20fkHCmDix9L0V71?=
 =?us-ascii?Q?LbVGkPXGldeW/t8g4/0GdB1Z/ZreylTEXrbO90iJwqy7YmxnYgkQ14+TxCEJ?=
 =?us-ascii?Q?nDjlEEyAN7N2BCkl/OpzAiHx9Y+g73wxyiPGrOEaoqFnKpVD3/EK6eMOwmwO?=
 =?us-ascii?Q?gUEKG4RpAdWiZSmhRPfvzL0f+0ivcg10fi16Lm2hOtVfU5s0jSPrrhpiIWdc?=
 =?us-ascii?Q?bSrHgsNZQOOeLKhIbWs2rDFm7xKM/Pm2q+IEIQk0JvrzdW8N5F6ENlKa2N4Q?=
 =?us-ascii?Q?uElQq/HYtq1BYAiPxKwdu2MQzMC9GhC/g32gYrTHvEfZYYDEFlNjBF5l03Z1?=
 =?us-ascii?Q?WZ1PcIfJlFQp7tVNeXzuHfDN8TCH1ZnC2XJBb0Ua1hWDtZPGJIZyshQC3rRJ?=
 =?us-ascii?Q?F2qe/HiQv1jRo2SKbI2jh0uu20PpGhy8gFjcyLjCnCbv7Lnlpib95ytY09Q7?=
 =?us-ascii?Q?R0pBWUBOB8H/f4J6Fr7WugYMdzVR9GlJ7TYPIN3uIy0z2kllwpEB9xmBNVZe?=
 =?us-ascii?Q?myewILhdJ1YYSiutrD2WYjvJzAuVeL/6DfTyxgbL2PYqmcWAw8EVn4wgQXpN?=
 =?us-ascii?Q?jL/RqHsUsulnfzDsCwTd3nXs00J4mgm9CxwFBg0sO66nPBZGVTZLWMnj7PqU?=
 =?us-ascii?Q?j7hh9fKt8HbXucak0YhA3QREZ7m6WzwQcrf7Lh1rLi6FcxzhA/fn63cLnwz0?=
 =?us-ascii?Q?Td9LgTJr4DnGbUTlMz45RtlMT27DFLOhtHsx6lfADvlKMF9CFuSnNQsR92sR?=
 =?us-ascii?Q?O0dZGkR/azRUiXpTMHSV5eFGpjw3qf0mwtqut29/NrzWIJMq+d0ebg4QQM3E?=
 =?us-ascii?Q?nwJHGYT2bEzJR/cItZrgrOVjzwVIBkGnPSHb5fhQumivMu6OtJWKVgLwp5gl?=
 =?us-ascii?Q?ekWT42sQe89sbGtiI9J5187c8Jbu36Tex8PSy616GnDVWKzmexZawjYOL1Lc?=
 =?us-ascii?Q?O1C44vMB0PNhHyHMCjD3mGja9fZDsbfvgqcSWbQ+37z+Ni92DJX+1ySHVtFN?=
 =?us-ascii?Q?gFaYylSMekENKqr3gx7KLkkPz3kngUhj8lzO4n/Dz4w1w21hlvdgBkugkT6A?=
 =?us-ascii?Q?untei3LRIDaIfiV8Iua4MW8vBxWWcuZxrV3tOQwofgPH7hjgz+sv4kTFeQII?=
 =?us-ascii?Q?uLP6zi/7/PzKeqAruqfFKW/r+YZPUqAUDZIec7qMUiH6D3QKMCCj0JlcRN6G?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8d8b48-b508-422d-c72d-08dac2582a43
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:41:55.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+jREwBVAmDaWtA2SbixSycR1eJ4qLzvOgvMJaJQ22QH0cdK+4AS5NnkKT71MkdsUrhVqejFIyJ1uZOP6despA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090104
X-Proofpoint-ORIG-GUID: fyXCLyHjorH_CRYY5eGzhhuXmxXF4N7t
X-Proofpoint-GUID: fyXCLyHjorH_CRYY5eGzhhuXmxXF4N7t
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

