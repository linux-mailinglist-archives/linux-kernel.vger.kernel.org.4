Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25171622D18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiKIOCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKIOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:02:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BC7280;
        Wed,  9 Nov 2022 06:02:45 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9Dlo1u018000;
        Wed, 9 Nov 2022 14:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=RdKfiUQzQZfWe2qNENmLmxoQLh+dBt776HmM3eMhbLc=;
 b=QWUx95eH+TYtD9iPmcAOl75VTSyQpinNf3aIiob56OPmhPZFMX1rnZ1/tW5ICvNgpf43
 2HMCdrIYhsEcXJmHiv4EO9d5Jsq0mALIXWj002WV/chRtzhEmtVqY2EKkS2CMgr7rkE+
 hASve/uHvqsZqCmUndSnvJLJSwuAAHco8oENRkRgL7np6JK0Ax+1gbupZjGkaunKS5rH
 rdpASKSmRAq2aHpCXTinSDRpfPBfays/0cgRkhdkVIUSLqBHeWvoUxT8vdh5bHuTS8QQ
 0sTB4ofEi8it8brFazT+xqPojzQnqzIwRd7q8pnopvxg5pLh5vEo32giIKCn3Fg+cXbz YQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krdd2829v-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 14:02:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9CCHvb018952;
        Wed, 9 Nov 2022 13:42:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctmwawg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:42:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrdAOCqTWiHolhn3O1DauPPZNMiRZXCGB7WJEKQPJmqvuSO6Bu497PWWVszXP5AgevEzrWYlZrRLVpF0FTVdPBOTH+oUNrPZotcQg7oJpTJHhDmcmr6ztvDvyiHFRn9GyznQQfMhNwBuRLlIsdwpgmjnrlLBK/dbOVfknWlvmBD3yqOSORZQMt9A4RRL2gVPgyAjHP4wuuiGjfaNg5ekP3ZlJBbR1sbynJqjMF61mKcMHqcMkASSoocnoaZIzBIhLljT/b7urJHWQEs4lzdID+Q5YQcsb1hWVH/1Vo4H8BF66kQGtY76X2j8wwWpzy/BB3mj2QCyDRi6AWVd0leYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdKfiUQzQZfWe2qNENmLmxoQLh+dBt776HmM3eMhbLc=;
 b=i1tfYB91+W+RO3I3Xb4BvT+OYyNGP4/gEjz0+YjxMwWM+oUETEKizzOhOcG7PZBDM96Y3mNhHxjGwrzHd+5s6K3f9Y2rXW9DBdLcWw0Mx7u2DGrBMV3WOmQwMntq3Q/x7CGQD1+TvVcjgxesEeBmwW962LphsIghKoV8tPkyLjOSxRLH0P/TSDRspR9pSjX3xhQgozZfuUqi/i/gcZ5UsXRHny9zww+zA6wNB6OSNV+cX2vTFwaAwNm7ThotnE1QGTAf6SW+GesG22dnnB6747e0TZVVrvZPze9fznvR1dC9QqSNeE70DNPC5CUv+7l8crAwE1yXngk45lltyEg1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdKfiUQzQZfWe2qNENmLmxoQLh+dBt776HmM3eMhbLc=;
 b=ojGfP8WbihXIgxJGsvmgt9z6yYZBbFhXc4dlKU57eXGB/Ff2xhVsboLKphdCPWWgToLe8TC9YY55533P8N1uXGSCWq2QFRsDnRRg+pV2R1fMcPVqbvrtRogZN2CzrTld27Dqv4znpV76EQCO9Pavarodu/dkF/YnZ3+8B26q4XM=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 13:42:22 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:42:22 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 5/8] kallsyms: optimize .kallsyms_modules*
Date:   Wed,  9 Nov 2022 13:41:29 +0000
Message-Id: <20221109134132.9052-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221109134132.9052-1-nick.alcock@oracle.com>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0142.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::21) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BLAPR10MB4817:EE_
X-MS-Office365-Filtering-Correlation-Id: 300dbcde-61fd-48d4-1ec4-08dac2583aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: di/Xg6UVFy1LeyW7kHLN0QL3YoWxSk0E//NQMdcIOG9YVq2+QoOJOUmMENNhOCeX9NGMrxDEEgYBTuSvMO2Mjhy2LAyYylnkAJn2z9GztyLxAMtCY9YBvVGSV4qDIdOvIfD7AU24Z09+i3JN6lYlgI+gGgUaJfKq/diFZve/QU4c49ZtpNI59vmR3E0eoGnM0Dl6maTofkisnnz2rVFw4uuA7ELZXWH4+Ga5vspdJ9jEJiSJ68fYjPfjFrV935Uab/n3K7x2mqyAhfgY6OaWIvOvaQdCWoLLNg12yAC9JWzxE0BZI1F7EazneRAKDf2synFu+x0iaDo5s9xczZrcncJmX5o1v7dtNmW/fczXkddM1jUIp7Bg5p+PXFDEpoNUEcFbY5NpakZLEyZiRYg/1mDI+hBNkROiz744ZVeNCmcOEZshIB2kwXXA6RcRSUqyBThNTd7GjBswPM3yfm2hsO46X8Y9c6/mvSEzqyY6kKnxWw8kvlPbnwo9W33857ZPrY2x+AUM8LYEEMdLDg6IFZqVA+zAO2RvgVE12GzHLur7D15azmH8leUgb47lEsu7w0LxRAyvsp+0rAp6OcXenK235IddEq4RbZpFrwWaEebn1nuMlKtwbv//8bqZ9Avp0tbuHA+GM3/z/i68C9YzJ726Inv3AcNwY6Esk9qP1PZlolXhU3ohJ9wfgrmljVgUOT7zriWX9X2tz/9EQ//YmLGVzG8Os9N9BKL4xvU5eT2nT8ak0GvwnSkxIxPhaOFB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(2616005)(66556008)(186003)(83380400001)(1076003)(38100700002)(6512007)(5660300002)(8936002)(30864003)(2906002)(6506007)(4326008)(6486002)(478600001)(107886003)(66476007)(8676002)(66946007)(316002)(44832011)(41300700001)(86362001)(36756003)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGZoR2TziY+neyl2B1fK+TaN4/AmlrEXIZerdhjkiO2F0aHb4198LjwYkWTv?=
 =?us-ascii?Q?oZA44dWRR+jJmoweRaAL59/FtRG+WqdP18w5WpGL2YAhaR0lL3GW37SOeFK0?=
 =?us-ascii?Q?15hzPOhHkkYo7VWONUKePmR/TeeBD9kLbVwJSPOa2FfDNgAfRRO9xf3FphPr?=
 =?us-ascii?Q?QAr3k498xWFoDuxjIijeRiq/yDL4yFvLNnZzie1Afjf6biTyIEY97zDF5vfk?=
 =?us-ascii?Q?n0QDD3Be4rNgMYDB5D4EMUwWjWKHTgqrWa7XduJrdx3OPt/vlwKFSoph4HEm?=
 =?us-ascii?Q?qA3Fi5KU1zZQl83ltI3Pb5C1I7PIO1W1rBEzWSAXu0VystML/bf1RmXYMk+d?=
 =?us-ascii?Q?5sss/BN1QoOfDA5LYRFiZrarFgmjgwXD0tqRrfUZmREjYQFy75hzomCJqypi?=
 =?us-ascii?Q?fSgxCEYkJU8bLSO+am6LRpWRnDbho6DND20ZNuJpcRZwqHlRlI/8nSvpfpbh?=
 =?us-ascii?Q?SLGuNQbrnPww4OLDhPhvg4uaYcF3r75CWIo+qIlFjcPEjqv5e/QJOcl0No1/?=
 =?us-ascii?Q?1U3l5VkrJ9HC1j2L+M5Tcrvv1T8GDS+wlB8azFBrOeargDnxnvGYyPvZn8Jx?=
 =?us-ascii?Q?HD9lJS/wOhPKEScHIMRvZEgedY9KvDkzRHtxDXBC9wH/7ltDAeA0rBvKM+tt?=
 =?us-ascii?Q?6DbIgBqpxr6daHrnHZxi7FY+9ofdb+z6TpfkezMMFDoKtjCWVeJvIqsVaOsc?=
 =?us-ascii?Q?vU4zgssv8AntPsH5UM8wBMn0mr8Sisgqtzx6tYjf4zKFyHtF+4kG3RE4XryU?=
 =?us-ascii?Q?8rl5efK+IwrgxRLqUJgNmuwVT71CXH4tbPMhkcKAVz5Omepdk+C5nW1yTw7k?=
 =?us-ascii?Q?mDrdY6NfAjtM4mC5tjxnMpwILlJOP2vRMMSiUIo7ubihkrxyw19s/qh3ruFP?=
 =?us-ascii?Q?nqipXXLCjQwLHo99jAt9B7s/VIfVNWrnfRriga+IE4ghE4Mq2lnq0WwsIxVY?=
 =?us-ascii?Q?7QIc5PHSmqO7QppPZm5dB1102XnyW/tqHo71fy45g2Fb1CiPyen8ES93kyIt?=
 =?us-ascii?Q?hMki6QWk44f8OhQxIsOqlIN1TIUexQl1FoHgoBXjvH7Df4HmYCyOK575Tzx4?=
 =?us-ascii?Q?XAZgduIDSUJE4pj6jyaudkn1chs7sZABUH5ZPA3pFOkpP27wyDo8nF+LvRp2?=
 =?us-ascii?Q?rhq+KFZYn3hiQ8cXbFFd7/kjpkeXhlGcO3Fr+Hpbqvz3gepe8g66lWSUVzdd?=
 =?us-ascii?Q?8B/7UZKj+ixoRhG04PVCLmwbwPT/vl60/tnrMtcoZkjfN2YFM5Gl8xcwbs0+?=
 =?us-ascii?Q?xHWqTAWy/pmItWOuavRtQ+9EoH9agYFfm5DYI4vECwOtcamVjhpwz1+fr6BL?=
 =?us-ascii?Q?zqGz9eyZaXX58HauxVj2wgm/MEL2wuwBW9eg5C2BGAjMh2k3eGREGAXmgeTC?=
 =?us-ascii?Q?eUm11d7vBGqjaeIBC7bZB2X7kGBlC8gr0cuXZLxOdFdt+ZtTHM/ACfvNQaTn?=
 =?us-ascii?Q?bDMho585cmhgLC7koNmI/vhvI1s4bcHLwR5QkbTaXf0rEuTBHp+4WwFmE53N?=
 =?us-ascii?Q?YaRmvtVDOD9PI02fOMPphvRH8cho/JGwxlt8BwYudUF14ruwA/Gj+L72n2cF?=
 =?us-ascii?Q?Nu1KUPFOswidS0gXN+J0xPzDj48Qv7x+iCmayXqkSatYBcqaSYoh7ZszR8p6?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300dbcde-61fd-48d4-1ec4-08dac2583aaf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:42:22.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUQ6aBRiC+4gIPB/PWMtZQhkOHgwPk1Ne/aK82tWLUBWtgujYcJlVGFG62ZkJfNs/qNrEQ8uBvv3hog4GoUH5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090104
X-Proofpoint-GUID: oQ1aQ0X38_p5ELYyek9_l-HrHNH4wvrj
X-Proofpoint-ORIG-GUID: oQ1aQ0X38_p5ELYyek9_l-HrHNH4wvrj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These symbols are terribly inefficiently stored at the moment.  Add a
simple optimizer which fuses obj2mod_elem entries and uses this to
implement three cheap optimizations:

 - duplicate names are eliminated from .kallsyms_module_names.

 - entries in .kallsyms_modules which point at single-file modules which
   also appear in a multi-module list are redirected to point inside
   that list, and the single-file entry is dropped from
   .kallsyms_module_names.  Thus, modules which contain some object
   files shared with other modules and some object files exclusive to
   them do not double up the module name.  (There might still be some
   duplication between multiple multi-module lists, but this is an
   extremely marginal size effect, and resolving it would require an
   extra layer of lookup tables which would be even more complex, and
   incompressible to boot).

 - Entries in .kallsyms_modules that would contain the same value after
   the above optimizations are fused together, along with their
   corresponding .kallsyms_module_addresses/offsets entries.  Due to
   this fusion process, and because object files can be split apart into
   multiple parts by the linker for hot/cold partitioning and the like,
   entries in .kallsyms_module_addresses/offsets no longer correspond
   1:1 to object files, but more to some contiguous range of addresses
   which are guaranteed to belong to a single built-in module, but which
   may well stretch over multiple object files.

The optimizer's time complexity is O(log n) in the number of objfiles at
most (and probably much lower), so, given the relatively low number of
objfiles, its runtime overhead is in the noise.

Optimization reduces the overhead of the kallmodsyms tables by about
7500 items, dropping the .tmp_kallsyms2.o object file size by about
33KiB, leaving it 8672 bytes larger than before: a gain of .4%.

The vmlinux size is not yet affected because the variables are not used
and are eliminated by the linker: but if they were used (after the next
commit but one), the size impact of all of this on the final kernel is
minimal: in my testing, vmlinux grew by 0.17% (10824 bytes), and the
compressed vmlinux only grew by 0.08% (7552 bytes): though this is very
configuration-dependent, it seems likely to scale roughly with the
kernel as a whole.  (The next commit changes these numbers a bit, but not
much.)

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v9: Fix a bug in optimize_obj2mod that prevented proper reuse of
        module names for object files appearing in both multimodule
        modules and single-module modules.  Adjustments to allow for
        objfile support.  Tiny style fixes.

 scripts/kallsyms.c | 297 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 288 insertions(+), 9 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 6b9654a151fb..f89f569eb3c9 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -102,6 +102,17 @@ static unsigned int strhash(const char *s)
 	return hash;
 }
 
+static unsigned int memhash(char *s, size_t len)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		hash = (hash ^ *(s + i)) * 0x01000193;
+	return hash;
+}
+
 #define OBJ2MOD_BITS 10
 #define OBJ2MOD_N (1 << OBJ2MOD_BITS)
 #define OBJ2MOD_MASK (OBJ2MOD_N - 1)
@@ -111,14 +122,35 @@ struct obj2mod_elem {
 	size_t nmods;		/* number of modules in "mods" */
 	size_t mods_size;	/* size of all mods together */
 	int mod_offset;		/* offset of module name in .kallsyms_mod_objnames */
+
+	/*
+	 * Hash values of all module names in this elem, combined: used for
+	 * rapid comparisons.  Populated quite late, at optimize_obj2mod time.
+	 */
+	unsigned int modhash;
+
+	/*
+	 * If set at emission time, this points at another obj2mod entry that
+	 * contains the module name we need (possibly at a slightly later
+	 * offset, if the entry is for an objfile that appears in many modules).
+	 */
+	struct obj2mod_elem *xref;
+
+	/*
+	 * Chain links for object -> module and module->object mappings.
+	 */
 	struct obj2mod_elem *obj2mod_next;
+	struct obj2mod_elem *mod2obj_next;
 };
 
 /*
- * Map from object files to obj2mod entries (a unique mapping).
+ * Map from object files to obj2mod entries (a unique mapping), and vice versa
+ * (not unique, but entries for objfiles in more than one module in this hash
+ * are ignored).
  */
 
 static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
+static struct obj2mod_elem *mod2obj[OBJ2MOD_N];
 static size_t num_objfiles;
 
 /*
@@ -162,6 +194,8 @@ static void obj2mod_add(char *obj, char *mod)
 
 	elem = obj2mod_get(obj);
 	if (!elem) {
+		int j = strhash(mod) & OBJ2MOD_MASK;
+
 		elem = malloc(sizeof(struct obj2mod_elem));
 		if (!elem)
 			goto oom;
@@ -175,8 +209,15 @@ static void obj2mod_add(char *obj, char *mod)
 
 		elem->obj2mod_next = obj2mod[i];
 		obj2mod[i] = elem;
+		elem->mod2obj_next = mod2obj[j];
+		mod2obj[j] = elem;
 		num_objfiles++;
 	} else {
+		/*
+		 * objfile appears in multiple modules.  mod2obj for this entry
+		 * will be ignored from now on, except insofar as it is needed
+		 * to maintain the hash chain.
+		 */
 		elem->mods = realloc(elem->mods, elem->mods_size +
 				     strlen(mod) + 1);
 		if (!elem->mods)
@@ -196,6 +237,162 @@ static void obj2mod_add(char *obj, char *mod)
 	fprintf(stderr, "kallsyms: out of memory\n");
 	exit(1);
 }
+
+static int qstrcmp(const void *a, const void *b)
+{
+	return strcmp((const char *) a, (const char *) b);
+}
+
+static int qmodhash(const void *a, const void *b)
+{
+	struct obj2mod_elem * const *el_a = a;
+	struct obj2mod_elem * const *el_b = b;
+	if ((*el_a)->modhash < (*el_b)->modhash)
+		return -1;
+	else if ((*el_a)->modhash > (*el_b)->modhash)
+		return 1;
+	return 0;
+}
+
+/*
+ * Associate all object files in obj2mod which refer to the same module with a
+ * single obj2mod entry for emission, preferring to point into the module list
+ * in a multi-module objfile.
+ */
+static void optimize_obj2mod(void)
+{
+	size_t i;
+	size_t n = 0;
+	struct obj2mod_elem *elem;
+	struct obj2mod_elem *dedup;
+
+	/* An array of all obj2mod_elems, later sorted by hashval.  */
+	struct obj2mod_elem **uniq;
+	struct obj2mod_elem *last;
+
+	/*
+	 * Canonicalize all module lists by sorting them, then compute their
+	 * hash values.
+	 */
+	uniq = malloc(sizeof(struct obj2mod_elem *) * num_objfiles);
+	if (uniq == NULL)
+		goto oom;
+
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (elem = obj2mod[i]; elem; elem = elem->obj2mod_next) {
+			if (elem->nmods >= 2) {
+				char **sorter;
+				char *walk;
+				char *tmp_mods;
+				size_t j;
+
+				tmp_mods = malloc(elem->mods_size);
+				sorter = malloc(sizeof(char *) * elem->nmods);
+				if (sorter == NULL || tmp_mods == NULL)
+					goto oom;
+				memcpy(tmp_mods, elem->mods, elem->mods_size);
+
+				for (j = 0, walk = tmp_mods; j < elem->nmods;
+				     j++) {
+					sorter[j] = walk;
+					walk += strlen(walk) + 1;
+				}
+				qsort(sorter, elem->nmods, sizeof (char *),
+				      qstrcmp);
+				for (j = 0, walk = elem->mods; j < elem->nmods;
+				     j++) {
+					strcpy(walk, sorter[j]);
+					walk += strlen(walk) + 1;
+				}
+				free(tmp_mods);
+				free(sorter);
+			}
+
+			uniq[n] = elem;
+			uniq[n]->modhash = memhash(elem->mods, elem->mods_size);
+			n++;
+		}
+	}
+
+	qsort(uniq, num_objfiles, sizeof (struct obj2mod_elem *), qmodhash);
+
+	/*
+	 * Work over multimodule entries.  These must be emitted into
+	 * .kallsyms_mod_objnames as a unit, but we can still optimize by
+	 * reusing some other identical entry.  Single-file modules are amenable
+	 * to the same optimization, but we avoid doing it for now so that we
+	 * can prefer to point them directly inside a multimodule entry.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		const char *onemod;
+		size_t j;
+
+		if (uniq[i]->nmods < 2)
+			continue;
+
+		/* Duplicate multimodule.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i]->modhash &&
+			memcmp(uniq[i]->mods, last->mods,
+			       uniq[i]->mods_size) == 0) {
+			uniq[i]->xref = last;
+			continue;
+		}
+
+		/*
+		 * Single-module entries relating to modules also emitted as
+		 * part of this multimodule entry can refer to it: later, we
+		 * will hunt down the right specific module name within this
+		 * multimodule entry and point directly to it.
+		 */
+		onemod = uniq[i]->mods;
+		for (j = uniq[i]->nmods; j > 0; j--) {
+			int h = strhash(onemod) & OBJ2MOD_MASK;
+
+			for (dedup = mod2obj[h]; dedup;
+			     dedup = dedup->mod2obj_next) {
+				if (dedup->nmods > 1)
+					continue;
+
+				if (strcmp(dedup->mods, onemod) != 0)
+					continue;
+				dedup->xref = uniq[i];
+				assert(uniq[i]->xref == NULL);
+			}
+			onemod += strlen(onemod) + 1;
+		}
+
+		last = uniq[i];
+	}
+
+	/*
+	 * Now traverse all single-module entries, xreffing every one that
+	 * relates to a given module to the first one we saw that refers to that
+	 * module.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		if (uniq[i]->nmods > 1)
+			continue;
+
+		if (uniq[i]->xref != NULL)
+			continue;
+
+		/* Duplicate module name.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i]->modhash &&
+		    memcmp(uniq[i]->mods, last->mods, uniq[i]->mods_size) == 0) {
+			uniq[i]->xref = last;
+			assert(last->xref == NULL);
+			continue;
+		}
+		last = uniq[i];
+	}
+
+	free(uniq);
+
+	return;
+oom:
+	fprintf(stderr, "kallsyms: out of memory optimizing module list\n");
+	exit(EXIT_FAILURE);
+}
 #endif /* CONFIG_KALLMODSYMS */
 
 static void usage(void)
@@ -507,8 +704,8 @@ static void output_kallmodsyms_mod_objnames(void)
 	size_t i;
 
 	/*
-	 * Traverse and emit, updating mod_offset accordingly.  Emit a single \0
-	 * at the start, to encode non-modular objfiles.
+	 * Traverse and emit, chasing xref and updating mod_offset accordingly.
+	 * Emit a single \0 at the start, to encode non-modular objfiles.
 	 */
 	output_label("kallsyms_mod_objnames");
 	printf("\t.byte\t0\n");
@@ -517,9 +714,25 @@ static void output_kallmodsyms_mod_objnames(void)
 		     elem = elem->obj2mod_next) {
 			const char *onemod;
 			size_t i;
+			struct obj2mod_elem *out_elem = elem;
 
-			elem->mod_offset = offset;
-			onemod = elem->mods;
+			/*
+			 * Single-module ref to a multimodule: will be emitted
+			 * as a whole, so avoid emitting pieces of it (which
+			 * would go unreferenced in any case).
+			 */
+			if (elem->xref &&
+			    elem->nmods == 1 && elem->xref->nmods > 1)
+				continue;
+
+			if (elem->xref)
+				out_elem = elem->xref;
+
+			if (out_elem->mod_offset != 0)
+				continue;	/* Already emitted.  */
+
+			out_elem->mod_offset = offset;
+			onemod = out_elem->mods;
 
 			/*
 			 * Technically this is a waste of space: we could just
@@ -528,13 +741,14 @@ static void output_kallmodsyms_mod_objnames(void)
 			 * entry, but doing it this way makes it more obvious
 			 * when an entry is a multimodule entry.
 			 */
-			if (elem->nmods != 1) {
+			if (out_elem->nmods != 1) {
 				printf("\t.byte\t0\n");
-				printf("\t.byte\t%zi\n", elem->nmods);
+				printf("\t.byte\t%zi\n", out_elem->nmods);
 				offset += 2;
 			}
 
-			for (i = elem->nmods; i > 0; i--) {
+			for (i = out_elem->nmods; i > 0; i--) {
+				printf("/* 0x%lx */\n", offset);
 				printf("\t.asciz\t\"%s\"\n", onemod);
 				offset += strlen(onemod) + 1;
 				onemod += strlen(onemod) + 1;
@@ -561,6 +775,13 @@ static void output_kallmodsyms_objfiles(void)
 		long long offset;
 		int overflow;
 
+                /*
+                 * Fuse consecutive address ranges citing the same object file
+                 * into one.
+                 */
+                if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+                        continue;
+
 		if (base_relative) {
 			if (!absolute_percpu) {
 				offset = addrmap[i].addr - relative_base;
@@ -586,6 +807,13 @@ static void output_kallmodsyms_objfiles(void)
 
 	for (i = 0; i < addrmap_num; i++) {
 		struct obj2mod_elem *elem = addrmap[i].objfile;
+		int orig_nmods;
+		const char *orig_modname;
+		int mod_offset;
+
+		if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+			continue;
+
 		/*
 		 * Address range cites no modular object file: point at 0, the
 		 * built-in module.
@@ -596,13 +824,63 @@ static void output_kallmodsyms_objfiles(void)
 			continue;
 		}
 
+		orig_nmods = elem->nmods;
+		orig_modname = elem->mods;
+
+		/*
+		 * Chase down xrefs, if need be.  There can only be one layer of
+		 * these: from single-module entry to other single-module
+		 * entry, or from single- or multi-module entry to another
+		 * multi-module entry.  Single -> single and multi -> multi
+		 * always points at the start of the xref target, so its offset
+		 * can be used as is.
+		 */
+		if (elem->xref)
+			elem = elem->xref;
+
+		if (elem->nmods == 1 || orig_nmods > 1) {
+
+			if (elem->nmods == 1)
+				printf("/* 0x%llx--0x%llx: module %s */\n",
+				       addrmap[i].addr, addrmap[i].end_addr,
+				       elem->mods);
+			else
+				printf("/* 0x%llx--0x%llx: multimodule */\n",
+				       addrmap[i].addr, addrmap[i].end_addr);
+
+			mod_offset = elem->mod_offset;
+		} else {
+			/*
+			 * If this is a reference from a single-module entry to
+			 * a multi-module entry, hunt down the offset to this
+			 * specific module's name (which is guaranteed to be
+			 * present: see optimize_obj2mod).
+			 */
+
+			size_t j = elem->nmods;
+			const char *onemod = elem->mods;
+			mod_offset = elem->mod_offset;
+
+			for (; j > 0; j--) {
+				if (strcmp(orig_modname, onemod) == 0)
+					break;
+				onemod += strlen(onemod) + 1;
+			}
+			assert(j > 0);
+			/*
+			 * +2 to skip the null byte and count at the start of
+			 * the multimodule entry.
+			 */
+			mod_offset += onemod - elem->mods + 2;
+		}
+
 		/*
 		 * Zero offset is the initial \0, there to catch uninitialized
 		 * obj2mod entries, and is forbidden.
 		 */
 		assert(elem->mod_offset != 0);
 
-		printf("\t.long\t0x%x\n", elem->mod_offset);
+		printf("\t.long\t0x%x\n", mod_offset);
 		emitted_objfiles++;
 	}
 
@@ -1146,6 +1424,7 @@ static void read_modules(const char *modules_builtin)
 
 	free(module_name);
 	modules_thick_iter_free(i);
+	optimize_obj2mod();
 
 	/*
 	 * Read linker map.
-- 
2.38.0.266.g481848f278

