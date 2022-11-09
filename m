Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F91B622CE5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiKINxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiKINx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:53:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D525DD7;
        Wed,  9 Nov 2022 05:53:24 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9Dl4dB026016;
        Wed, 9 Nov 2022 13:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=7hNpr2jAHme90wG89ywYaxbkWPRr1q/sz64Wtpn03MQ=;
 b=NHKnknRYStFbzrnGyb6/wFJTXJhkVGQZekAuI3GdHLeHEzekBu4y+IbNM+AmTL0JCM13
 jjxhul1N1EPDGCsAte1WiLCxjlDGxbKCT40bDoMcMXcMjAkfQZmKv60rG6GeNNKDDDtY
 v5wMbsRaQc8B69v9k3STSC7ltU+0OMab4FbU2M/SSN1v9ilClQRxkKGxXRPvk/Vvd+zY
 gM2AmrC6Qh8vK8ZOFelT+owbq1TeYn4eznlfd0qQKAvaVra76m73ujKvG34RO8qisIYK
 8NZzVAGfACfr18feGR4sRrM/groAN2aNkAa16Csr7yk/7ikcgW+GQWdnaO73BPXaEiuj 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krcnmr467-86
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:53:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9CoVwO004321;
        Wed, 9 Nov 2022 13:42:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq3ddxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:42:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpuFhzJG/H/nCcfxjwQjkzqWOPkXHylpNT9YE/juc1b0tr3NxoKevOODYlU91gDeyIMBeiFaxaulqsMISQQRmGosIwSCUuZ/+cV2ad/pyc3YgdUqgbj1kzGL9D64EegE54plj8wmgp6vYusGEZPf3wKMvrSoGNvebzYJhxsYcJFWxFFBn4xcAKN8Ypi2efXjumyJ4nFfa0F42pFXPu7I6rVPFk8Tje4JGadSZpmWnRPYBAmLvBIRPAH29M0NHR6AW9OmXRqkSfXjbRYa+csmHssHtZr698h34i4INgZf4eGiIDZPVlyTljEnnErPMDHUEQSdLnri9z7RsKd927+mMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hNpr2jAHme90wG89ywYaxbkWPRr1q/sz64Wtpn03MQ=;
 b=IFz5JJXRbbxhgZYhE5azW+IjXwga/uYffGypaEwSVyjgt2eFe3oK2DN2KW82fiI6HsS/KrDADaXZiSxatr0OeLjkgzZHnM/D/BR1LMawTonEifXlULuhcuEIiA5508CuTHk3ey8frpfXpKPEpvpKQJTHhv1k08rAcCeqpLEx9HMiRq38tPKE7u34yRNKakjrw2cS/5gG56P79nykLJWV3f++ADYBxJRY4uaCewogffEKio0+wZRH50cgIDIc4AVneYEc8TJ2BYSBWbpGa1KXrdAVKKZ9WDfnntqXbB5Sb6PaQRHyfLekjlzcmXpTDZ5Gv3BekvfIJSlYwYQKp7f9Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hNpr2jAHme90wG89ywYaxbkWPRr1q/sz64Wtpn03MQ=;
 b=yLh5X7sJpHWstQDIw6MFmgSTWF8cl6qX03oC3UoduhkGeFIqMYAfiZFO2wxl8ENUMy/71PgzrkYXF4pnTcaigjNqDEsbOlB94xpDC3KLq+5aoFy3OhkzWIWUDPf5mZHhlqu8rV/iy7TIGSPycAxCmBaeTeHoD5d3ipO7KGJdF2I=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 13:42:18 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:42:18 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 4/8] kallsyms: introduce sections needed to map symbols to built-in modules
Date:   Wed,  9 Nov 2022 13:41:28 +0000
Message-Id: <20221109134132.9052-5-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221109134132.9052-1-nick.alcock@oracle.com>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0141.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::20) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BLAPR10MB4817:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd08165-0a31-4006-bf43-08dac2583836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3ukjBd9eAr0LIPYTybkpXWHacg5e5hH9CA74ynj0OX6H0Glb61QHd5CB8WLdk3aZXk41i1KwAdu2yXOAuCozgufzA3hWKXCwujytgo61KXvM5BOqBHxS8n5Ln2pjb7Nj3vUkXJbGnyvAhSopju2Vf4D8Bl0+Wihdz30ZyV4X4ZizxAqIs/hxpr8GiFkqDZx08A3RC6ElEfAsU1f/erC4440yFrTA3dww5TMEM11MBxgpovgq3qeTziMc3Zm2rr4osXLd1nlyR1y649nI7K8L9oe6Uv2Dn6U7GmHJmdO254wM+9KmHJ4w+INe2ZwSSqmF8X/CP3yIOxsuffi7ZOZ9UAj0UrbqTLkbcX0nSZgXp3oIN0lseQJFAWQC2CxlK9lLawGKwnAaLwffyzZssE6819qDZHMKmxEN8TjflHlPtpM75u5k0rrWooMfgyVHlN37OdtlfbO/vFQ+Wt/+nzVl+kUBiboFR2Iv2WxJMLaBzlOrwf4wepsquRj1QwE7kc81bywB5DjG0Ib3qpVA9ITP9hxIJUycdrAilHtsFBjUaoXyutEV2EEW+clc1Sm9CJW9eUnj4/DocihackZT158OTDm7W7zcAewVe1jCYsugEfN5i1o+/wIRr3NxLW15FUEPm36H3bCMCTYABeHoT5D0idWm+mg+E0jjiaFLeu4XNVPIAVPF+ftvkTYtxy6/ROHHyQX33A7K+V4GEmesUxi1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(2616005)(66556008)(186003)(83380400001)(1076003)(38100700002)(6512007)(5660300002)(8936002)(30864003)(2906002)(6506007)(4326008)(45080400002)(6486002)(478600001)(6666004)(107886003)(66476007)(8676002)(66946007)(316002)(44832011)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YL5jOLbiIQ7epZYbEJnVLCKcJhGeshbL+fsv6q9GrVakQL88bcQdM5YKjDND?=
 =?us-ascii?Q?w2Es2uAyBmni4eYFkY+Z7sqZcryU2E9n5aQg9Dz2dt+d1F9Ejc8/EjQJYRJa?=
 =?us-ascii?Q?ftvNTwZQYSCuwPOQXYWyI/6pOntCmp06V+gJTzqLkhKyGQp5jj2TYgwq4RLH?=
 =?us-ascii?Q?V1uOPel8Mq10VTolK4IyTXzl+K/DYMhN8V+8R1x1kHrsF8x32yRMxClIzBEK?=
 =?us-ascii?Q?C/eg6yLsdaTQcbXWFCD5QvT8j1L+uxbKAEDcS1XsvfLv0zZ7GmTcCeQe9gxG?=
 =?us-ascii?Q?b38a0nBIKNOEFZjE4dKkbY73DmNuwXfaHmVKkciFv1CxQvRRfktAuBZ7Ual+?=
 =?us-ascii?Q?w+QzcduRn7imV4RCBhXT31/u3uQwFlv1r2hJQ4n4PowWUZb4ou0QDksi03F5?=
 =?us-ascii?Q?ZJ5neuekyoqrzLNWh+HHmtlWRH3lhXvouJBo/W6W3fXYNTO4XBORLwT8DExE?=
 =?us-ascii?Q?aIkNsDVt+MMpDLkmSHuxZDxy/f2phWug65gVW7D35KyK6J04iqMNXT2yh5It?=
 =?us-ascii?Q?Rdnv/B3BgmJjY0RPZrFIw2NHuwwLITPDv8YRdO2xtAZScYVU9XzIXX+ZVIj0?=
 =?us-ascii?Q?xy5xqYxS1sT53r7qxMqY7Xs0H7oSqpWfzTVYDWpdg+36ehPj7voQ4yKeIKCH?=
 =?us-ascii?Q?dz3Tbnx09FN1Zz3AbqXVFWLg09Gj9sNc1T3MAr19jlmAOS0KD1YCo4khwzi7?=
 =?us-ascii?Q?eJQc19W2xWzvKdLDGecPHz4MpfZC0UE/DzOb6n2lKFjaQuv5dWE/v4lNsylF?=
 =?us-ascii?Q?bS3Du0wL1vruR1n0ZBd8+SkQxgHUYFIIlbfimrAkvLvIR8cZuHpR8H3+jdGu?=
 =?us-ascii?Q?lHJTg2S82R+l87cyHfWXxNzZ1MFSbkTSBinzSnuMSgbLiDvA187BEkmYgr0S?=
 =?us-ascii?Q?046Xqq0ru+R77/rj8CQ0V/jUwN8mLtIS3lCwdm/UttXsnPV2anUeZnnDmRIO?=
 =?us-ascii?Q?iBhuslBfAOjF5OySMFGUpPeuw13+1eVRgx3gCQSXqLmSIWu0ol0CheD1YjbD?=
 =?us-ascii?Q?OLSV/qKddvwuVoajxXpyhDGjhZlQkETSej8iAbmTrmYA8gktlb/MbAgbxQHi?=
 =?us-ascii?Q?cZ0Ki+/J3qgF+usiOQ2y1OXgqIQujs9f+OILhHRnhZ/Ky8n5klr0OjT44PNd?=
 =?us-ascii?Q?XwOM3fcl9kAn2YUQGaF22HrYybJR06t/ZOkiOdp//92pqSeevXnJmSnJ1Bjo?=
 =?us-ascii?Q?mken34cVzMwpSs/vJrD7LaaaE5aU1iNHTYIN1fdzYnwMAPWu0n33uQIJBW+z?=
 =?us-ascii?Q?VYE4modRBAbSzuDSNsvWUf+6oPx+4Om3JJlKA6z98qu6i8/SanKsWQBPOT1x?=
 =?us-ascii?Q?iCv+iW98eanobOU9eYOYnNemFvMs2gAQ+PEG6/F4bIVJ/VtSSPZweH13+tFL?=
 =?us-ascii?Q?hUua2SAWqQd5Xs6btG2u5t9u816B0I9MdBFTlQvq81qLNQQHk1TGAFlOTs2R?=
 =?us-ascii?Q?IiklNfc1quiOOlXblNqI4DY7WtQjpZX5DWRbL6QITMc7oPd9xzWuLJRrxxqN?=
 =?us-ascii?Q?U7ek9IMe9QN5reKGkaS+3E894FwCiuepY6H2YXgFoR9KLazfx5os366s7m6g?=
 =?us-ascii?Q?nCKbURESARjQRsfQRWytPUIwJbya5IYgzxML/yiePa2tdxRG1MNgHkn/sGwF?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd08165-0a31-4006-bf43-08dac2583836
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:42:18.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4JD4/2ZR5CRF2eRQwnd0+ITVspc+jRiOxwDImEVOFbJruqiux9yJkTJj32GnHTPrjqwtQ9EjpKNHjHD3Zbg8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090104
X-Proofpoint-GUID: hGhHuCyQIXX7JcTqPY6_ZtK_Okrf--2L
X-Proofpoint-ORIG-GUID: hGhHuCyQIXX7JcTqPY6_ZtK_Okrf--2L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mapping consists of three new symbols, computed by integrating the
information in the (just-added) .tmp_vmlinux.ranges and
modules_thick.builtin: taken together, they map address ranges
(corresponding to object files on the input) to the names of zero or
more modules containing those address ranges.

 - kallsyms_module_addresses/kallsyms_module_offsets encodes the
   address/offset of each object file (derived from the linker map), in
   exactly the same way as kallsyms_addresses/kallsyms_offsets does
   for symbols.  There is no size: instead, the object files are assumed
   to tile the address space.  (This is slightly more space-efficient
   than using a size).  Non-text-section addresses are skipped: for now,
   all the users of this interface only need module/non-module
   information for instruction pointer addresses, not absolute-addressed
   symbols and the like.  This restriction can easily be lifted in
   future.  (Regarding the name: right now the entries correspond pretty
   closely to object files, so we could call the section
   kallsyms_objfiles or something, but the optimizer added in the next
   commit will change this.)

 - kallsyms_mod_objnames encodes the name of each module in a modified
   form of strtab: notably, if an object file appears in *multiple*
   modules, all of which are built in, this is encoded via a zero byte,
   a one-byte module count, then a series of that many null-terminated
   strings.  As a special case, the table starts with a single zero byte
   which does *not* represent the start of a multi-module list.

   (The name is "objnames" because in an upcoming commit it will store
   some object file names too.)

 - kallsyms_modules connects the two, encoding a table associated 1:1
   with kallsyms_module_addresses / kallsyms_module_offsets, pointing
   at an offset in kallsyms_module_names describing which module (or
   modules, for a multi-module list) the code occupying this address
   range is part of.  If an address range is part of no module (always
   built-in) it points at 0 (the null byte at the start of the
   kallsyms_module_names list).

There is no optimization yet: kallsyms_modules and
kallsyms_module_names will almost certainly contain many duplicate
entries, and kallsyms_module_{addresses,offsets} may contain
consecutive entries that point to the same place.  The size hit is
fairly substantial as a result, though still much less than a naive
implementation mapping each symbol to a module name would be: 50KiB or
so.

Since this commit is the first user of modules_thick.builtin, introduce
rules to actually build it when CONFIG_KALLMODSYMS is set (similarly to
modules.order, it is named in the top-level makefile purely for
documentation purposes, then reiterated in the makefile where it is
actually built, in this case the top-level Kbuild).  Since it's also the
first user of the new Kconfig symbol to enable compiling-out of
/proc/kallmodsyms support, introduce that symbol too.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v9: Rename .kallsyms_module_names to .kallsyms_mod_objnames now that it
        contains object file names too.  Adjustments to the Kconfig wording;
        adjustments to modules_thick.builtin rules.  Adjust to getopt_long
        use in scripts/kallsyms.

 Kbuild             |   6 +
 Makefile           |   5 +-
 init/Kconfig       |   9 ++
 scripts/Makefile   |   6 +
 scripts/kallsyms.c | 375 ++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 392 insertions(+), 9 deletions(-)

diff --git a/Kbuild b/Kbuild
index a84e8312c174..2bd36178ae64 100644
--- a/Kbuild
+++ b/Kbuild
@@ -113,3 +113,9 @@ $(modthickbuiltin-files): include/config/tristate.conf
 
 modules_thick.builtin: $(modthickbuiltin-files) $(obj-y)
 	$(Q)$(AWK) '!x[$$0]++' $(patsubst %/built-in.a, %/$@, $(filter %/built-in.a,$(obj-y))) > $@
+
+ifdef CONFIG_KALLMODSYMS
+ifdef need-builtin
+extra-y += modules_thick.builtin
+endif
+endif
diff --git a/Makefile b/Makefile
index 21117f9d4202..71f4d7abd6ed 100644
--- a/Makefile
+++ b/Makefile
@@ -1232,7 +1232,7 @@ vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
 	@:
 
 PHONY += vmlinux
-vmlinux: vmlinux.o $(KBUILD_LDS) modpost
+vmlinux: vmlinux.o $(KBUILD_LDS) modules_thick.builtin modpost
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux
 
 # The actual objects are generated when descending,
@@ -1562,6 +1562,9 @@ __modinst_pre:
 
 endif # CONFIG_MODULES
 
+modules_thick.builtin: $(build-dir)
+	@:
+
 ###
 # Cleaning is done on three levels.
 # make clean     Delete most generated files
diff --git a/init/Kconfig b/init/Kconfig
index abf65098f1b6..70cc2e67bef7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1570,6 +1570,15 @@ config POSIX_TIMERS
 
 	  If unsure say y.
 
+config KALLMODSYMS
+	default y
+	bool "Enable support for /proc/kallmodsyms" if EXPERT
+	depends on KALLSYMS
+	help
+	  This option enables the /proc/kallmodsyms file, which unambiguously
+	  maps built-in kernel symbols and their associated object files and
+	  modules to addresses.
+
 config PRINTK
 	default y
 	bool "Enable support for printk" if EXPERT
diff --git a/scripts/Makefile b/scripts/Makefile
index 1575af84d557..acd46bfeedc3 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -32,6 +32,12 @@ ifdef CONFIG_BUILDTIME_MCOUNT_SORT
 HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
 endif
 
+kallsyms-objs  := kallsyms.o
+
+ifdef CONFIG_KALLMODSYMS
+kallsyms-objs += modules_thick.o
+endif
+
 # The following programs are only built on demand
 hostprogs += unifdef
 
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03fa07ad45d9..6b9654a151fb 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,10 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
+ * Usage: nm -n vmlinux
+ *        | scripts/kallsyms [--all-symbols] [--absolute-percpu]
+ *             [--base-relative] [--builtin=modules_thick.builtin]
+ *        > symbols.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
@@ -25,6 +28,10 @@
 #include <string.h>
 #include <ctype.h>
 #include <limits.h>
+#include <assert.h>
+#include "modules_thick.h"
+
+#include "../include/generated/autoconf.h"
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
@@ -84,11 +91,118 @@ static int token_profit[0x10000];
 static unsigned char best_table[256][2];
 static unsigned char best_table_len[256];
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned int strhash(const char *s)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+
+	for (; *s; s++)
+		hash = (hash ^ *s) * 0x01000193;
+	return hash;
+}
+
+#define OBJ2MOD_BITS 10
+#define OBJ2MOD_N (1 << OBJ2MOD_BITS)
+#define OBJ2MOD_MASK (OBJ2MOD_N - 1)
+struct obj2mod_elem {
+	char *obj;
+	char *mods;		/* sorted module name strtab */
+	size_t nmods;		/* number of modules in "mods" */
+	size_t mods_size;	/* size of all mods together */
+	int mod_offset;		/* offset of module name in .kallsyms_mod_objnames */
+	struct obj2mod_elem *obj2mod_next;
+};
+
+/*
+ * Map from object files to obj2mod entries (a unique mapping).
+ */
+
+static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
+static size_t num_objfiles;
+
+/*
+ * An ordered list of address ranges and the objfile that occupies that range.
+ */
+struct addrmap_entry {
+	char *obj;
+	unsigned long long addr;
+	unsigned long long end_addr;
+	struct obj2mod_elem *objfile;
+};
+static struct addrmap_entry *addrmap;
+static int addrmap_num, addrmap_alloced;
+
+static void obj2mod_init(void)
+{
+	memset(obj2mod, 0, sizeof(obj2mod));
+}
+
+static struct obj2mod_elem *obj2mod_get(const char *obj)
+{
+	int i = strhash(obj) & OBJ2MOD_MASK;
+	struct obj2mod_elem *elem;
+
+	for (elem = obj2mod[i]; elem; elem = elem->obj2mod_next) {
+		if (strcmp(elem->obj, obj) == 0)
+			return elem;
+	}
+	return NULL;
+}
+
+/*
+ * Note that a given object file is found in some module, interning it in the
+ * obj2mod hash.  Should not be called more than once for any given (module,
+ * object) pair.
+ */
+static void obj2mod_add(char *obj, char *mod)
+{
+	int i = strhash(obj) & OBJ2MOD_MASK;
+	struct obj2mod_elem *elem;
+
+	elem = obj2mod_get(obj);
+	if (!elem) {
+		elem = malloc(sizeof(struct obj2mod_elem));
+		if (!elem)
+			goto oom;
+		memset(elem, 0, sizeof(struct obj2mod_elem));
+		elem->obj = strdup(obj);
+		if (!elem->obj)
+			goto oom;
+		elem->mods = strdup(mod);
+		if (!elem->mods)
+			goto oom;
+
+		elem->obj2mod_next = obj2mod[i];
+		obj2mod[i] = elem;
+		num_objfiles++;
+	} else {
+		elem->mods = realloc(elem->mods, elem->mods_size +
+				     strlen(mod) + 1);
+		if (!elem->mods)
+			goto oom;
+		strcpy(elem->mods + elem->mods_size, mod);
+	}
+
+	elem->mods_size += strlen(mod) + 1;
+	elem->nmods++;
+	if (elem->nmods > 255) {
+		fprintf(stderr, "kallsyms: %s: too many modules associated with this object file\n",
+			obj);
+		exit(EXIT_FAILURE);
+	}
+	return;
+oom:
+	fprintf(stderr, "kallsyms: out of memory\n");
+	exit(1);
+}
+#endif /* CONFIG_KALLMODSYMS */
 
 static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] "
-			"[--base-relative] in.map > out.S\n");
+			"[--base-relative] [--builtin=modules_thick.builtin] "
+			" in.map > out.S\n");
 	exit(1);
 }
 
@@ -112,10 +226,16 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_offsets",
 		"kallsyms_relative_base",
 		"kallsyms_num_syms",
+		"kallsyms_num_modules",
 		"kallsyms_names",
 		"kallsyms_markers",
 		"kallsyms_token_table",
 		"kallsyms_token_index",
+		"kallsyms_module_offsets",
+		"kallsyms_module_addresses",
+		"kallsyms_modules",
+		"kallsyms_mod_objnames",
+		"kallsyms_mod_objnames_len",
 		/* Exclude linker generated symbols which vary between passes */
 		"_SDA_BASE_",		/* ppc */
 		"_SDA2_BASE_",		/* ppc */
@@ -262,8 +382,8 @@ static struct sym_entry *read_symbol(FILE *in)
 	return sym;
 }
 
-static int symbol_in_range(const struct sym_entry *s,
-			   const struct addr_range *ranges, int entries)
+static int addr_in_range(unsigned long long addr,
+			 const struct addr_range *ranges, int entries)
 {
 	size_t i;
 	const struct addr_range *ar;
@@ -271,7 +391,7 @@ static int symbol_in_range(const struct sym_entry *s,
 	for (i = 0; i < entries; ++i) {
 		ar = &ranges[i];
 
-		if (s->addr >= ar->start && s->addr <= ar->end)
+		if (addr >= ar->start && addr <= ar->end)
 			return 1;
 	}
 
@@ -285,8 +405,8 @@ static int symbol_valid(const struct sym_entry *s)
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
-		if (symbol_in_range(s, text_ranges,
-				    ARRAY_SIZE(text_ranges)) == 0)
+		if (addr_in_range(s->addr, text_ranges,
+				  ARRAY_SIZE(text_ranges)) == 0)
 			return 0;
 		/* Corner case.  Discard any symbols with the same value as
 		 * _etext _einittext; they can move between pass 1 and 2 when
@@ -378,6 +498,121 @@ static void output_address(unsigned long long addr)
 		printf("\tPTR\t_text - %#llx\n", _text - addr);
 }
 
+#ifdef CONFIG_KALLMODSYMS
+/* Output the .kallmodsyms_mod_objnames symbol content. */
+static void output_kallmodsyms_mod_objnames(void)
+{
+	struct obj2mod_elem *elem;
+	size_t offset = 1;
+	size_t i;
+
+	/*
+	 * Traverse and emit, updating mod_offset accordingly.  Emit a single \0
+	 * at the start, to encode non-modular objfiles.
+	 */
+	output_label("kallsyms_mod_objnames");
+	printf("\t.byte\t0\n");
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (elem = obj2mod[i]; elem;
+		     elem = elem->obj2mod_next) {
+			const char *onemod;
+			size_t i;
+
+			elem->mod_offset = offset;
+			onemod = elem->mods;
+
+			/*
+			 * Technically this is a waste of space: we could just
+			 * as well implement multimodule entries by pointing one
+			 * byte further back, to the trailing \0 of the previous
+			 * entry, but doing it this way makes it more obvious
+			 * when an entry is a multimodule entry.
+			 */
+			if (elem->nmods != 1) {
+				printf("\t.byte\t0\n");
+				printf("\t.byte\t%zi\n", elem->nmods);
+				offset += 2;
+			}
+
+			for (i = elem->nmods; i > 0; i--) {
+				printf("\t.asciz\t\"%s\"\n", onemod);
+				offset += strlen(onemod) + 1;
+				onemod += strlen(onemod) + 1;
+			}
+		}
+	}
+	printf("\n");
+	output_label("kallsyms_mod_objnames_len");
+	printf("\t.long\t%zi\n", offset);
+}
+
+static void output_kallmodsyms_objfiles(void)
+{
+	size_t i = 0;
+	size_t emitted_offsets = 0;
+	size_t emitted_objfiles = 0;
+
+	if (base_relative)
+		output_label("kallsyms_module_offsets");
+	else
+		output_label("kallsyms_module_addresses");
+
+	for (i = 0; i < addrmap_num; i++) {
+		long long offset;
+		int overflow;
+
+		if (base_relative) {
+			if (!absolute_percpu) {
+				offset = addrmap[i].addr - relative_base;
+				overflow = (offset < 0 || offset > UINT_MAX);
+			} else {
+				offset = relative_base - addrmap[i].addr - 1;
+				overflow = (offset < INT_MIN || offset >= 0);
+			}
+			if (overflow) {
+				fprintf(stderr, "kallsyms failure: "
+					"objfile %s at address %#llx out of range in relative mode\n",
+					addrmap[i].objfile ? addrmap[i].objfile->obj :
+					"in always-built-in object", table[i]->addr);
+				exit(EXIT_FAILURE);
+			}
+			printf("\t.long\t0x%x\n", (int)offset);
+		} else
+			printf("\tPTR\t%#llx\n", addrmap[i].addr);
+		emitted_offsets++;
+	}
+
+	output_label("kallsyms_modules");
+
+	for (i = 0; i < addrmap_num; i++) {
+		struct obj2mod_elem *elem = addrmap[i].objfile;
+		/*
+		 * Address range cites no modular object file: point at 0, the
+		 * built-in module.
+		 */
+		if (addrmap[i].objfile == NULL) {
+			printf("\t.long\t0x0\n");
+			emitted_objfiles++;
+			continue;
+		}
+
+		/*
+		 * Zero offset is the initial \0, there to catch uninitialized
+		 * obj2mod entries, and is forbidden.
+		 */
+		assert(elem->mod_offset != 0);
+
+		printf("\t.long\t0x%x\n", elem->mod_offset);
+		emitted_objfiles++;
+	}
+
+	assert(emitted_offsets == emitted_objfiles);
+	output_label("kallsyms_num_modules");
+	printf("\t.long\t%zi\n", emitted_objfiles);
+	printf("\n");
+}
+#endif /* CONFIG_KALLMODSYMS */
+
 /* uncompress a compressed symbol. When this function is called, the best table
  * might still be compressed itself, so the function needs to be recursive */
 static int expand_symbol(const unsigned char *data, int len, char *result)
@@ -477,6 +712,11 @@ static void write_src(void)
 		printf("\n");
 	}
 
+#ifdef CONFIG_KALLMODSYMS
+	output_kallmodsyms_mod_objnames();
+	output_kallmodsyms_objfiles();
+#endif
+
 	output_label("kallsyms_num_syms");
 	printf("\t.long\t%u\n", table_cnt);
 	printf("\n");
@@ -784,7 +1024,7 @@ static void make_percpus_absolute(void)
 	unsigned int i;
 
 	for (i = 0; i < table_cnt; i++)
-		if (symbol_in_range(table[i], &percpu_range, 1)) {
+		if (addr_in_range(table[i]->addr, &percpu_range, 1)) {
 			/*
 			 * Keep the 'A' override for percpu symbols to
 			 * ensure consistent behavior compared to older
@@ -811,13 +1051,123 @@ static void record_relative_base(void)
 		}
 }
 
+#ifdef CONFIG_KALLMODSYMS
+/*
+ * Read the linker map.
+ */
+static void read_linker_map(void)
+{
+	unsigned long long addr, size;
+	char *obj;
+	FILE *f = fopen(".tmp_vmlinux.ranges", "r");
+
+	if (!f) {
+		fprintf(stderr, "Cannot open '.tmp_vmlinux.ranges'.\n");
+		exit(1);
+	}
+
+	addrmap_num = 0;
+	addrmap_alloced = 4096;
+	addrmap = malloc(sizeof(*addrmap) * addrmap_alloced);
+	if (!addrmap)
+		goto oom;
+
+	/*
+	 * For each address range, add to addrmap the address and the objfile
+	 * entry to which the range maps.  Only add entries relating to text
+	 * ranges.
+	 *
+	 * Ranges that do not correspond to a built-in module, but to an
+	 * always-built-in object file, have no obj2mod_elem and point at NULL
+	 * instead.  Their obj member is still filled out.
+	 */
+
+	while (fscanf(f, "%llx %llx %ms\n", &addr, &size, &obj) == 3) {
+		struct obj2mod_elem *elem = obj2mod_get(obj);
+
+		if (addr == 0 || size == 0 ||
+		    !addr_in_range(addr, text_ranges, ARRAY_SIZE(text_ranges))) {
+			free(obj);
+			continue;
+		}
+
+		if (addrmap_num >= addrmap_alloced) {
+			addrmap_alloced *= 2;
+			addrmap = realloc(addrmap,
+			    sizeof(*addrmap) * addrmap_alloced);
+			if (!addrmap)
+				goto oom;
+		}
+
+		addrmap[addrmap_num].addr = addr;
+		addrmap[addrmap_num].end_addr = addr + size;
+		addrmap[addrmap_num].objfile = elem;
+		addrmap[addrmap_num].obj = obj;
+		addrmap_num++;
+	}
+	fclose(f);
+	return;
+
+oom:
+	fprintf(stderr, "kallsyms: out of memory\n");
+	exit(1);
+}
+
+/*
+ * Read "modules_thick.builtin" (the list of built-in modules).  Construct the
+ * obj2mod hash to track objfile -> module mappings.  Read ".tmp_vmlinux.ranges"
+ * (the linker map) and build addrmap[], which maps address ranges to built-in
+ * module names (using obj2mod).
+ */
+static void read_modules(const char *modules_builtin)
+{
+	struct modules_thick_iter *i;
+	char *module_name = NULL;
+	char **module_paths;
+
+	obj2mod_init();
+	/*
+	 * Iterate over all modules in modules_thick.builtin and add each.
+	 */
+	i = modules_thick_iter_new(modules_builtin);
+	if (i == NULL) {
+		fprintf(stderr, "Cannot iterate over builtin modules.\n");
+		exit(1);
+	}
+
+	while ((module_paths = modules_thick_iter_next(i, &module_name))) {
+		char **walk = module_paths;
+		while (*walk) {
+			obj2mod_add(*walk, module_name);
+			walk++;
+		}
+		free(module_paths);
+	}
+
+	free(module_name);
+	modules_thick_iter_free(i);
+
+	/*
+	 * Read linker map.
+	 */
+	read_linker_map();
+}
+#else
+static void read_modules(const char *unused) {}
+#endif /* CONFIG_KALLMODSYMS */
+
 int main(int argc, char **argv)
 {
+	char *modules_builtin = "modules_thick.builtin";
+
 	while (1) {
+		static int has_modules_builtin;
+
 		static struct option long_options[] = {
 			{"all-symbols",     no_argument, &all_symbols,     1},
 			{"absolute-percpu", no_argument, &absolute_percpu, 1},
 			{"base-relative",   no_argument, &base_relative,   1},
+			{"builtin",         required_argument, &has_modules_builtin, 1},
 			{},
 		};
 
@@ -827,12 +1177,21 @@ int main(int argc, char **argv)
 			break;
 		if (c != 0)
 			usage();
+
+		if (has_modules_builtin) {
+			modules_builtin = strdup(optarg);
+			if (!modules_builtin) {
+				fprintf(stderr, "Out of memory parsing args\n");
+				exit(1);
+			}
+		}
 	}
 
 	if (optind >= argc)
 		usage();
 
 	read_map(argv[optind]);
+	read_modules(modules_builtin);
 	shrink_table();
 	if (absolute_percpu)
 		make_percpus_absolute();
-- 
2.38.0.266.g481848f278

