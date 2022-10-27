Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B7D610232
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiJ0T7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiJ0T6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:58:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5B48991C;
        Thu, 27 Oct 2022 12:58:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHmppt001419;
        Thu, 27 Oct 2022 19:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=RdKfiUQzQZfWe2qNENmLmxoQLh+dBt776HmM3eMhbLc=;
 b=CVIM6S30VzM/0+wc8dyxuvA1CkBePuVjsJAw2r7qA/U4+ZeqoSegytBe4K8lXbITIEdv
 4Y+HaMBM1W7WzlI6snhSL234zcmf4pxAC2vphzeBC54uBKlcdD+QTnQdrLxrIeqK6gPk
 bS2NkmAxezx40atzoWcIpGrGaOVVuRDtvQEpSSDO3dmJvy7Gt9Cz5SffRity+dgleZu0
 sRmb8wG4an0ZHeJ23L9jYI7OxgDISR0zbwSFLiUtC9S9RF3iWpAGQi74Wpzk1PpQF9aJ
 V+GqEP3Kn48dvpa2MgmhRf2iR0HwQ2zrHScGQH6/0aSgqfdj3ImTj0liIZ16ViTOfu8a Sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawru8cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RJvqxD006906;
        Thu, 27 Oct 2022 19:58:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghb1bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce9qVwzX3C+ZE+SvBp1MSOOF1zx93+XNoXiMUPNGnV1dmlboREOW97tVY9DdnBxOs0Pq4+tsAjMi/k8KV74fLGyQcgbcEJDD+Q81k3Rgz5aCOAHGKrPgFSjMuaLR0WRGl4i1srb7m2nICPPu9fE/Rtpiprvg4vOzm4+avth29Fv6pe9FUjWRDrg9SCDEUdNfd1lWkgkE6AMSb2mTUHxx+DOegPuvIovVvVg5VEz4SvMFeNV6sOgxJ5R2ydSl+ZLv7hLt129sPb7B2Tq62CQyElA0dcQZVrnrSRwVzXc7HZHsDhjqbD7Va7pgTNtsrL56JExZFsCRULPN6YNIGCo5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdKfiUQzQZfWe2qNENmLmxoQLh+dBt776HmM3eMhbLc=;
 b=mXazQ5nqW7Mibs3wRhwT6pefqcNkSaPlthwAgouNSwKPH9RnutpRRhr76Q/x4VzDU5RECnPTI//X6TCh5AL3uW/lFXMyyKAiJvtmaAGwWDcwlEE1B/f0P9LraKWi/uqYFLQzPto12see/+B+HGiE7ujRv/wKhVTnxe/wTXbuyTeATbaDhotmmbzO1nOns7JgUaRLkA/V7oto+OEUJVi1mMwIx3ysJAVt9E11+eFiX5HnTa4+f2TcixOrgGVXvEuqkYsd4ZenKtnwkLNIgkYQL1/5VQmLs8GqmJuZOvGXsOy31ar60HK0AnwuFT0xGhJJcp+pBXPYSO1lTv/ZYZVXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdKfiUQzQZfWe2qNENmLmxoQLh+dBt776HmM3eMhbLc=;
 b=hIMQ0QCY7kT+gse5BTIK51R16OCQypDb2YtqjabrrLSC6IMUa9EJInOt8XDzcmEIEMj3d3NseEB/6dq4VAdOL2u6wL0jjcWd959dBi8PkH44LvgEoGVj93TuH0WB8Wj8Ai6FAilK7A1jQVINtIGRFAEqCEuayZj0pMyAWg1+ORE=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BL3PR10MB6042.namprd10.prod.outlook.com (2603:10b6:208:3b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 27 Oct
 2022 19:58:29 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 19:58:29 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org, masahiroy@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 5/8] kallsyms: optimize .kallsyms_modules*
Date:   Thu, 27 Oct 2022 20:57:51 +0100
Message-Id: <20221027195754.100039-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221027195754.100039-1-nick.alcock@oracle.com>
References: <20221027195754.100039-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0131.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::23) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BL3PR10MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4183e0-48e8-4e49-f704-08dab8559e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lK6QMBd6DZSGocZ7cpue/lAYtddl8wikWcyNBwWfsoykTPwpwrnL6eXiX3zJSPA5iAK+rOh+qNaBXJnXulcuivZGBcMO+8ll2xJI99HURaENVQ61/HVW5rUYYH9ZkeUVgszkqlaBA3P+bWtnMCJ5/Dh9K9CRUtcth69E4+rERrVFR8LDOBs0i8HW09J8hx5DAqw89QGVT83fNm/TGP4ICu+nfIauq0IjGz2diw2bkxwNSv6gqNeye8eH7UcyalagnSvSwXlaxD6EmBXoHDG/l6/J8KHV5zQTB4t/DLHGLtvCU8F9estZdHGw5NNCkIEWogaNSSF4t8iThjcKKijqksp4BZSyBDkAxQjOTRbMkEjuOpZFSHdxFjzhY+KjRtsVPvCIWfQ5ShhPDV8yaoCfmXusJRJjIPn38qXgNZwbt7rzgeoiepfMG2wEDnV3/mjK12oxzAxMK/LOjijoTXBoi5s/W6wRw+hecyTcn+HlLJ0mYdsOulrGV/vEv7LMdSkTmNZFs5Lx25/bWw3LQFOitcGGUTG/iwBHJoFJdo7EBodNVWwlcORPzthjqmETGcgDpzNY+FWEnvQ5DmiycFGR5yJ/QddaWRnKS7x1ayMO490/3/ckjxpn5i2j+0FgaBN2xQXsBrCS9cFOJL8Hc09CFsUaV4+oy7F6VyqoVmpVh4f/CGNUBS//k5CcSjNX5Wc2/THl9mDc+cQ73tTRjEd6dSHTOsJO3R3MuZRzlz6UABpRXRGMJF7+otn+NRnwqmLG/5Xc35yNpQWpGOV1/ZMAOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(83380400001)(41300700001)(478600001)(66476007)(6506007)(6486002)(8936002)(316002)(6666004)(30864003)(5660300002)(2616005)(4326008)(66946007)(36756003)(2906002)(6512007)(66556008)(86362001)(107886003)(44832011)(8676002)(186003)(1076003)(38100700002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A92M2PWs5iVhEXkkT9EDFmkYw6lpQQJZCL3o0cc4CD4b2qqjiKncIJ+o66ye?=
 =?us-ascii?Q?PikR8omRTh+90L5qEUdUZMspEG0kb3jKUW92KF7NJ48FzbEpd1A+j/DOnkq3?=
 =?us-ascii?Q?kEOrbo1j8o1gUqtfSqvLsn71Ne8U3v8QtHmps8IkIh+iX0MYMq33zMY0EhB/?=
 =?us-ascii?Q?kCmnj/bbjym6T2NqA9j2EnWH5imylBOfIIVdLwDBoBnIZImC+sQUU8ARp7mY?=
 =?us-ascii?Q?dtJcJ0awX1mIYKb1/D9z/AeRktpjuC8H4fWEC5ItZHsQ1EtcBRd2tBcDBRVo?=
 =?us-ascii?Q?RDyAf4zBVoWzAWU4gpMtNIvMwSsALXhZ6CbcQw54YGyJEk9gYJt2yHUaRfyl?=
 =?us-ascii?Q?xZs5SdKSDfQ+C/IFDUSg+kaOd1dn455m5IuCZORNUxKrsIoEyq4Zo0xhG2aR?=
 =?us-ascii?Q?03CGElYxK7Y1nuzfn2swBaQhciMJyzLBNriPUbky7InWAiRSkYlewYR6ufTv?=
 =?us-ascii?Q?MRBQQc2mXjII8YGJ27b9UGFaA20Iul/fifN+3zhv5G0BtT6kh2UzfCRb7INZ?=
 =?us-ascii?Q?is1rrTwnq6sUEt9WKsMM/MMDVInEo5o7qgtUhCQqLNbX+p5hRKZl9lfFoP8C?=
 =?us-ascii?Q?LvCIPvSQTGBUqAG2kqn0Xut1na1HccCGHVfxnZhhS+kTy71jWhoWmsUvUJGw?=
 =?us-ascii?Q?CcDnP+/GRvyXtQnxvCeeeT+2KSxoDTm+8S76EyZX1p/NWkVKHa5wUkAHG6Uf?=
 =?us-ascii?Q?e7NwJDG1Bz12hfMlvizE9u/EYMy7k0dyD5Dwxu8ulT/AQQfAaAfAy1IvkkkT?=
 =?us-ascii?Q?6M6nOE4UTpN4hbkaUkokN/mfo7RHWVP/YEYhEVsmcJ4PePCbXBnyRdikFYnD?=
 =?us-ascii?Q?EvE2HUWjzUp1opnaqNwzsjK1wFrGqDbXGj8gzgbS9g9T8ZCGtzHgtfp5LjxJ?=
 =?us-ascii?Q?DovBoFFFdFFBSCRdgVGzrH9VLJ0jy1k1iG7eL9Oeran6M3pceT6H+h5T7PPp?=
 =?us-ascii?Q?ACkdzLl0edGybpny7ZBxhbuvLrzoutX0aIDXGUzZcDnnXektdFjEnuLa8650?=
 =?us-ascii?Q?nmi0bO7d8n5TyhlXcCZ6iYquIKu9WfOlBdUmOf1i32TfJ4+/W2fF7OqPLs7V?=
 =?us-ascii?Q?9DImzUJF1AwMJW8546WCFYx4a8r1HsnsVwRokYrJoiqtgs8/qK/nMZDCu+Re?=
 =?us-ascii?Q?LhK3bjF7r513RWzaQdVgdgbm2w3J5O/e0mvqDMg7sR9I4HVQ3ivOsDmYQmcF?=
 =?us-ascii?Q?mQdDoDDoNR+OBWjOPIiggOQmVQjEcgve+5uIaG4fhjIfaNH72cLriOoIRr7r?=
 =?us-ascii?Q?FwnXQ13vAy6hQnw0ewzJrusHbinLwNJBHXktWpvA9IIqYPKEvZJroWdU4gZ7?=
 =?us-ascii?Q?co+moBQiv8R8uIOi2eLPNfHLOftchdP2cSKcuxeZq8fEQRU/5IAucvXXc5rP?=
 =?us-ascii?Q?XeOYkIrwBgfzPsfaNNZ/VjkeASeylgR0qZ9h3xuJPjdAeoKpVb4GKM7kOfU9?=
 =?us-ascii?Q?DWz3jmfOmIUuq2i8GF5ogr0kLmCcOAuLNvZBUm0AdQHz4Zn78JvtxDm2rwoB?=
 =?us-ascii?Q?hiRuhssBVhq14JlWSsd211q4qnENTB622gTBlHIRNNodAfH2TPpSliqiwB20?=
 =?us-ascii?Q?xR9Yj6/FSHKirPXD3//7Hy4cUDg4dbibfzppAjNsVfQCfYsECOLpFK9pcCqe?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4183e0-48e8-4e49-f704-08dab8559e64
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:58:29.7369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECWjrEwWxrbpgWyGDpHD3PB5sB3ACvJn59FmW2tMOTubfs4GJcyJilN+ibXqujCpHU34Zegzr1hb1xjWS0qjxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270112
X-Proofpoint-ORIG-GUID: tzipA8SOygMJefgUWXDxW3kYAiQ6VwDb
X-Proofpoint-GUID: tzipA8SOygMJefgUWXDxW3kYAiQ6VwDb
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

