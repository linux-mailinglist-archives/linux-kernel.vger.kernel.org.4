Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10061622CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiKINzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiKINzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:55:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EAD19D;
        Wed,  9 Nov 2022 05:54:58 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9DljZw027737;
        Wed, 9 Nov 2022 13:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=2/AXzHCvqQXde74LhZFpYpeNnEDDNsHTMzasoJKQahE=;
 b=nwwWfN4/Gy+Ukr9QgDTZS9K//CCBgfMu3oeJgaAgQ48JpyGT4+N//4jd50nZFUI2CFZk
 DzRp7riX8pD8pt9gqJ4rrxwe0XAW6It19ErNfRSizHAk1gs0HiqdBnsvHLRdAg5w95YC
 ALk3kDa1jtKQQMSG8FFU/7Z2ermpTUv25SRONLjvOoV4/SNq6SKwymmGMaqaxxWHnWQo
 GtNJKtH88c2jBm9dvy5+/Gtm2qSZA7vT86zvvNia2GMHKN6AHPba7/sBL1l9lEEHLehX
 zHwwV7H2X7aplMoi2B94papaGrcGGOMJ51a5YrPfpTLbPSYQmRh4/U8wILcEwYW0Nyn6 Zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krddar0bv-27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:54:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9Cp1LL017872;
        Wed, 9 Nov 2022 13:42:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctdn98s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2tgrBmcjHFhhSyYUSRQ0SYpsLiBBfDJQsXjC2qdbOhCqCMFsFosaUIrgyV/ewcWrtcel3ajHIda+VG3BlAlQh7dE1ul6bfp1OmKxDsvo8nLU8RVEZcJSene0Kcw72l0eCRjv3/O9kSSklqAs02H+OMY1NFs5fb8o0MfVJQ13b/YHmRhoNol3cI5gyiJTenuTc9Q8aOujEz0uiV/VdRtKhIPfDf1VmtIZUVtN2mtfDZgKBKBZGbUVMJx3TQt1dRujJZJ2BQXY+6yvUODKEW63Za+eD1JrLR4n5BqnHVlrWoKvQsdbwlvpso/eMJBGAVYkfLDQzoby0G7B9IjXeUtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/AXzHCvqQXde74LhZFpYpeNnEDDNsHTMzasoJKQahE=;
 b=ZvZBwKGT1zR9CmCRPdZrB4oLCorV6XylIBVoyzejuIW0ivMKEfEyIm9ugwO4ZAbmhR0jr3HFrpjNhVTrjcny45abpFsqB1Q7vSwpUk10kUiLi1bqmFOdKi1H1AjwM9TcuQHeHWyXE11QO+8hqIh8x5de+x/BmdiE0L0gP+GoBCeMtmhKh2qmi4FW/g8HMILQYibjqx2WJYenYfzfdSr8A/5HLtNG02M0OLla3o+xSjZ677vCkPXrExChLMhbUqiV5a6i0gy2MlOllwD9I/YAPYwtxzw5NGMTzxdkbV/MjW0KA9fL63UK5wpX1/v3pqFdGpjqhHK04Xtq/zSnBizO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/AXzHCvqQXde74LhZFpYpeNnEDDNsHTMzasoJKQahE=;
 b=SW9THsNsYu857cFQrKZif0F9YYVnTcz6B0msuwaixX+KNWRy/DQ4Ad3glKKu7AgpG+LacOMabPxJCtTsjv34HXvPLuDco0jKKU/batNIn3DsbrDi5rH41TlxsmkSuT0DPsbf2M3Q4m/hmMYopC7I1/ZKVXl2gZuAvIOPw3yxSR4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 13:42:26 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:42:26 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 6/8] kallsyms: distinguish text symbols fully using object file names
Date:   Wed,  9 Nov 2022 13:41:30 +0000
Message-Id: <20221109134132.9052-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221109134132.9052-1-nick.alcock@oracle.com>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BLAPR10MB4817:EE_
X-MS-Office365-Filtering-Correlation-Id: e71fc019-d662-437e-da93-08dac2583ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnjesswRabPK7nJ8oeR2yWXsFqljluq1e+N8jrmGHGlDhabT99R8pZX11xTaTQuiSKljQAuESM/gL3e1P4M6qu5ncSH5i1chkhJGob3HRxFl7yIR8ZK4tvEHg9Ock0Tw+c63kXOW/sRraLfKehlNhVXZOc7W2L1ebKbEQDOzM8XT0Pv9iDeVDAUu1XXVXMuvDxDJoDWUhc9VQ8Z4zAa+7xu5VW8c7N+GJHtoMFbKlmvpVFM3uWw7TbOzrWucahoKjIr9OMrMUbHaZOSRiUVvzXJUzValD1iASE5YAH9un4DIF73p0WJRrg46bsQlfuwcFMZHOfEb3kzrZXAL+lbs8N2PgCaYax6DLCg63yxSmP+Rdx+iRgwaLLIXB2BxAyxli02u4gW5uYPjT1fD8lLQyLMQS0PAhc54C1yzNpbgdqgIoKI3oiYdciCSCWywKfEwOGc+QWFQ/8hhF/b99ovDGBPFbySIytvMzJ6vhLfZ5UEEfRP/bCa5MTsDspyarQdsQFUQXgCD/YOZeWjsa0rOwIP6VHROi2oOvQ9IU4dSICpcxsuNF6xLry2exo8FBiSqVehwvaX/3L1n2QKd+IawpHe26Mvk0z+RjCZLzBoSAImw7QSKAsEeirpMzH1rOOPhHONzPa3I1X/Wc2L1+c/TzomkAVgdZ//nOgjUtMvSfawuPNLmw0C5sa3LrSv4O4Q5DAuUFMLBfVWe10qLUmBuJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(2616005)(66556008)(186003)(83380400001)(1076003)(38100700002)(6512007)(5660300002)(8936002)(30864003)(2906002)(6506007)(4326008)(6486002)(478600001)(6666004)(107886003)(66476007)(8676002)(66946007)(316002)(44832011)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b0TE+qpDNeGLQ+rASFbyms2rDccmn6jpe8VHla/9tZFc9kb829ZKRkkkOstP?=
 =?us-ascii?Q?mUjdHPh1jqI+KyPMSEaJDJC4QR7/6hJ31epNhvqGjkjhrQr3QUyoGJrzMlv0?=
 =?us-ascii?Q?1V2eqQY7a1jM/LEo3m2W6ZfEwTG1fopF5ErNQCukTzVdgsnFQiyS1tOQsHDa?=
 =?us-ascii?Q?d/gNXQpxAgKi4LKba9Qrzj1E9UpoSflK7v8mg6ya6XNkRgdQYrly5agvn+kj?=
 =?us-ascii?Q?MmMbcAVMuOGhLWalOHgot7Z/fN/F3FrevPxJS+Rz4FaIRchl7HRLJ6LjoNcf?=
 =?us-ascii?Q?pPnI9TCgPjeu2QJNnokaJCOZsyduGnZ+wwcezh5e7DxRwClIXngVTMHgBB7W?=
 =?us-ascii?Q?ScUL8xXwzmKZ5/QL7Wp7Vtxr97xGB/Hc2z7ietoSmvfI85oO7yATupCmv1dN?=
 =?us-ascii?Q?VWxL9aMySt0BRNwvoXsE5Amkb7jaAfl6ffDtylk44EyQeVmGJWQFZHLNaWwY?=
 =?us-ascii?Q?lz2zMLSLOt9lp/RFVr1mPv16X6nT5BKH15lXKKAlagr/j8REo1IuPeW4Q+cY?=
 =?us-ascii?Q?YCn7wGyN8DrXw5vVZLZYmm4OV52vvf+xlQ7tYcbLu3yIH45jG2nx0IO3/n+7?=
 =?us-ascii?Q?uTy3b2dMt0i3Xf74vMo1E1+nmlGZ+jUqMqDfROds+fUwx/TwOIri424PrK9y?=
 =?us-ascii?Q?R5WDqyIs4SJ6fNgKJ6/pDrl9vwGjYbidWZzJ2bFcZPJ9ub13oFXBK++VDh6q?=
 =?us-ascii?Q?uLuaq9EHrpbP5D2UiXzlC1wpCNCdF4v3likylUVy4D1BlV/Swg7zEvEq1CzF?=
 =?us-ascii?Q?ph7UoBqFZ/jZRCO1G5AGzq/PcDaytxbCLQFdK5EnybNmxFaI7H7JUht+6Ud8?=
 =?us-ascii?Q?+Njzo+egJbDGpgCVCCG8r+Qz/q8qGxUqpGEYiO79epnRy/ZQKTih0BhykzGc?=
 =?us-ascii?Q?7P+Z3ovoaMdVyO1CZsOY63T+28s3qiTVG3J4O31DI6e0dVsMKj4z/TimmufJ?=
 =?us-ascii?Q?v5NbTQ81RXS6ooMR3Fn4zScV4KH7/70seYHd8rFqFVljokaDRHD4Q4bvYPCg?=
 =?us-ascii?Q?5Qp5rQMXDBp1PfokcmEc+6+OjBYwcUM2DpVNLLAShVW2h3JJmqzdwew/h5z3?=
 =?us-ascii?Q?T3QW0R5gXe+jijItxx4w9nSm2/l2D1BxHvia8EdMZexEJY7edu6kk/73GRjh?=
 =?us-ascii?Q?fjRoh+n1ZRAgrdkHo38rJdjap00P6f3aqtV995Ka75RvBqE8zPRiaPbdKDKi?=
 =?us-ascii?Q?QFQNYxUTsQ/gkqDlpOBC4JCowMewhpDrnJuNvLlBKVm5zS52NRiTo6fV9qUK?=
 =?us-ascii?Q?v7N1m8Ril7nKXajx69W99bLqhPO7hPREgoBYlzxqZyKXjFmCLshFoLR6ioex?=
 =?us-ascii?Q?XUWnXYP283x03tk0EXYM4esCGnz4+ZH51X5/WAT+HEC0WYgoxk1l3dJyzABQ?=
 =?us-ascii?Q?/UACCIIRBZVTq74kpJKnCl5qBNWupvefkWThXbof8cK1bYux8mCVNG/1O531?=
 =?us-ascii?Q?ro3kDdl1tA4eCmpTD8ia+2kTc76hUIzKSXGWzYHI8RuYhQfymp+WoYzNOJux?=
 =?us-ascii?Q?PL7y71/EczUcchCGCIqfbX909DezIruvK3srwFUHJJNtIaDD/Usd+UgOI4HR?=
 =?us-ascii?Q?yLP30wBRZq+2v1xZgfHFF+lkMQ/0Z55MBo2KMalllmR4vtpTwvLkD4lixVJx?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71fc019-d662-437e-da93-08dac2583ced
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:42:26.3353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WK9wwbol+m/n8eezsL/F/z9A5GUyFl8gv/ZRujz5OrElIRwfca/5Iqw4pJqziHpsr6wxZqEt46odru975pvlCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090104
X-Proofpoint-GUID: bNBPOotOQ4LabJaCB3Q4uIhxVXMK2-ej
X-Proofpoint-ORIG-GUID: bNBPOotOQ4LabJaCB3Q4uIhxVXMK2-ej
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commits before this one allow you to distinguish identically-named
text symbols located in different built-in object files from each other;
but identically-named symbols can appear in any object files at all,
including object files that cannot be built as modules.

We already have nearly all the machinery to disambiguate these symbols
as well.  Since any given object file can contain at most one definition
of a given symbol, it suffices to name the object files containing any
symbol which is otherwise ambiguous.  (No others need be named, saving
a bunch of space).

We associate address ranges with object file names using a new
.kallsyms_objfiles section just like the previously-added
.kallsyms_modules section.

But that's not quite enough.  Even the object file name is ambiguous in
some cases: e.g. there are a lot of files named "core.o" in the kernel.
We could just store the full pathname for every object file, but this is
needlessly wasteful: doing this eats more than 50KiB in object file
names alone, and nearly all the content of every name is repeated for
many names.  But if we store the object file names in the same section
as the built-in module names, drop the .o, and store minimal path
suffixes, we can save almost all that space.  (For example, "core.o"
would be stored as "core" unless there are ambiguous symbols in two
different object files both named "core", in which case they'd be named
"sched/core" and "futex/core", etc, possibly re-extending to
"kernel/sched/core" if still ambiguous).

We do this by a repeated-rehashing process. First, we compute a hash
value for symbol\0modhash for every symbol (the modhash is ignored if
this is a built-in symbol).  Any two symbols with the same such hash are
identically-named: add the maximally-shortened (one-component,
.o-stripped) object file name for all such symbols, and rehash, this
time hashing symbol\0objname\0modhash.  Any two symbols which still have
the same hash are still ambiguous: lengthen the name given to one of the
symbols' object files and repeat.  Eventually, all the ambiguity will go
away.  (We do have to take care not to re-lengthen anything we already
lengthened in any given hashing round.)

This involves multiple sorting passes but the impact on compilation time
appears to be nearly zero, and the impact on space in the running kernel
is noticeable: only a few dozen names need lengthening, so we can
completely ignore the overhead from storing repeated path components
because there are hardly any of them.

But that's not all.  We can also do similar optimization tricks to what
was done with .kallsyms_modules, reusing module names and names of
already-emitted object files: so any given object file name only appears
once in the strtab, and can be cited by many address ranges and even by
module entries.

Put all this together and the net overhead of this in my testing is
about 3KiB of new object file names in the .kallsyms_mod_objnames table
and 6KiB for the .kallsyms_objfiles table (mostly zeroes: in future
maybe we can find a way to elide some of those, but 6KiB is small enough
that it's not worth taking too much effort).

No ambiguous textual symbols remain outside actual modules (which can
still contain identically-named symbols in different object files
because kallsyms doesn't run over them so none of these tables can be
built for them.  At least, it doesn't yet.)

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v9: new.

 scripts/kallsyms.c | 559 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 546 insertions(+), 13 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f89f569eb3c9..ffb69a8f6ff8 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -113,6 +113,9 @@ static unsigned int memhash(char *s, size_t len)
 	return hash;
 }
 
+/*
+ * Object file -> module and shortened object file name tracking machinery.
+ */
 #define OBJ2MOD_BITS 10
 #define OBJ2MOD_N (1 << OBJ2MOD_BITS)
 #define OBJ2MOD_MASK (OBJ2MOD_N - 1)
@@ -143,15 +146,40 @@ struct obj2mod_elem {
 	struct obj2mod_elem *mod2obj_next;
 };
 
+/*
+ * Shortened object file names.  These are only ever consulted after checking
+ * the obj2mod hashes: names that already exist in there are used directly from
+ * there (pointed to via the mod_xref field) rather than being re-emitted.
+ * Entries that do not exist there are added to the end of the mod_objnames
+ * list.
+ */
+struct obj2short_elem {
+	const char *obj;
+	char *desuffixed;	/* objname sans suffix */
+	const char *short_obj;	/* shortened at / and suffix */
+	int short_offset;	/* offset of short name in .kallsyms_mod_objnames */
+	int last_rehash;	/* used during disambiguate_hash_syms */
+
+	struct obj2mod_elem *mod_xref;
+	struct obj2short_elem *short_xref;
+	struct obj2short_elem *short_next;
+};
+
 /*
  * Map from object files to obj2mod entries (a unique mapping), and vice versa
  * (not unique, but entries for objfiles in more than one module in this hash
- * are ignored).
+ * are ignored); also map from object file names to shortened names for them
+ * (also unique: there is no point storing both longer and shorter forms of one
+ * name, so if a longer name is needed we consistently use it instead of the
+ * shorter form.)
+ *
+ * obj2short is populated very late, at disambiguate_syms time.
  */
 
 static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
 static struct obj2mod_elem *mod2obj[OBJ2MOD_N];
-static size_t num_objfiles;
+static struct obj2short_elem *obj2short[OBJ2MOD_N];
+static size_t num_objfiles, num_shortnames;
 
 /*
  * An ordered list of address ranges and the objfile that occupies that range.
@@ -165,6 +193,9 @@ struct addrmap_entry {
 static struct addrmap_entry *addrmap;
 static int addrmap_num, addrmap_alloced;
 
+static void disambiguate_syms(void);
+static void optimize_objnames(void);
+
 static void obj2mod_init(void)
 {
 	memset(obj2mod, 0, sizeof(obj2mod));
@@ -182,6 +213,18 @@ static struct obj2mod_elem *obj2mod_get(const char *obj)
 	return NULL;
 }
 
+static struct obj2short_elem *obj2short_get(const char *obj)
+{
+	int i = strhash(obj) & OBJ2MOD_MASK;
+	struct obj2short_elem *elem;
+
+	for (elem = obj2short[i]; elem; elem = elem->short_next) {
+		if (strcmp(elem->obj, obj) == 0)
+			return elem;
+	}
+	return NULL;
+}
+
 /*
  * Note that a given object file is found in some module, interning it in the
  * obj2mod hash.  Should not be called more than once for any given (module,
@@ -254,6 +297,12 @@ static int qmodhash(const void *a, const void *b)
 	return 0;
 }
 
+static int qobj2short(const void *a, const void *b)
+{
+	return strcmp((*(struct obj2short_elem **)a)->short_obj,
+		      (*(struct obj2short_elem **)b)->short_obj);
+}
+
 /*
  * Associate all object files in obj2mod which refer to the same module with a
  * single obj2mod entry for emission, preferring to point into the module list
@@ -393,6 +442,336 @@ static void optimize_obj2mod(void)
 	fprintf(stderr, "kallsyms: out of memory optimizing module list\n");
 	exit(EXIT_FAILURE);
 }
+
+/*
+ * Associate all short-name entries in obj2short that refer to the same short
+ * name with a single entry for emission, either (preferably) a module that
+ * shares that name or (alternatively) the first obj2short entry referencing
+ * that name.
+ */
+static void optimize_objnames(void)
+{
+	size_t i;
+	size_t num_objnames = 0;
+	struct obj2short_elem *elem;
+	struct obj2short_elem **uniq;
+	struct obj2short_elem *last;
+
+	uniq = malloc(sizeof(struct obj2short_elem *) * num_shortnames);
+	if (uniq == NULL) {
+		fprintf(stderr, "kallsyms: out of memory optimizing object file name list\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/*
+	 * Much like optimize_obj2mod, except there is no need to canonicalize
+	 * anything or handle multimodule entries, and we need to chase down
+	 * possible entries in mod2obj first (so as not to duplicate them in the
+	 * final kallsyms_mod_objnames strtab).
+	 */
+	for (i = 0; i < OBJ2MOD_N; i++)
+		for (elem = obj2short[i]; elem; elem = elem->short_next)
+			uniq[num_objnames++] = elem;
+
+	qsort(uniq, num_objnames, sizeof(struct obj2short_elem *), qobj2short);
+
+	for (i = 0, last = NULL; i < num_objnames; i++) {
+		int h = strhash(uniq[i]->short_obj) & OBJ2MOD_MASK;
+		struct obj2mod_elem *mod_elem;
+
+		for (mod_elem = mod2obj[h]; mod_elem;
+		     mod_elem = mod_elem->mod2obj_next) {
+			/*
+			 * mod_elem entries are only valid if they are for
+			 * single-module objfiles: see obj2mod_add
+			 */
+			if (mod_elem->nmods > 1)
+				continue;
+
+			if (strcmp(mod_elem->mods, uniq[i]->short_obj) != 0)
+				continue;
+			uniq[i]->mod_xref = mod_elem;
+			break;
+		}
+
+		/*
+		 * Only look for a short_xref match if we don't already have one
+		 * in mod_xref.  (This means that multiple objfiles with the
+		 * same short name that is also a module name all chain directly
+		 * to the module name via mod_xref, rather than going through a
+		 * chain of short_xrefs.)
+		 */
+		if (uniq[i]->mod_xref)
+			continue;
+
+		if (last != NULL && strcmp(last->short_obj,
+					   uniq[i]->short_obj) == 0) {
+			uniq[i]->short_xref = last;
+			continue;
+		}
+
+		last = uniq[i];
+	}
+
+	free(uniq);
+}
+
+/*
+ * Used inside disambiguate_syms to identify colliding symbols.  We spot this by
+ * hashing symbol\0modhash (or just the symbol name if this is in the core
+ * kernel) and seeing if that collides.  (This means we don't need to bother
+ * canonicalizing the module list, since optimize_obj2mod already did it for
+ * us.)
+ *
+ * If that collides, we try disambiguating by adding ever-longer pieces of the
+ * object file name before the modhash until we no longer collide.  The result
+ * of this repeated addition becomes the obj2short hashtab.
+ */
+struct sym_maybe_collides {
+	struct sym_entry *sym;
+	struct addrmap_entry *addr;
+	struct obj2short_elem *short_objname;
+	unsigned int symhash;
+};
+
+static int qsymhash(const void *a, const void *b)
+{
+	const struct sym_maybe_collides *el_a = a;
+	const struct sym_maybe_collides *el_b = b;
+	if (el_a->symhash < el_b->symhash)
+		return -1;
+	else if (el_a->symhash > el_b->symhash)
+		return 1;
+	return 0;
+}
+
+static int find_addrmap(const void *a, const void *b)
+{
+	const struct sym_entry *sym = a;
+	const struct addrmap_entry *map = b;
+
+	if (sym->addr < map->addr)
+		return -1;
+	else if (sym->addr >= map->end_addr)
+		return 1;
+	return 0;
+}
+
+/*
+ * Allocate or lengthen an object file name for a symbol that needs it.
+ */
+static int lengthen_short_name(struct sym_maybe_collides *sym, int hash_cycle)
+{
+	struct obj2short_elem *short_objname = obj2short_get(sym->addr->obj);
+
+	if (!short_objname) {
+		int i = strhash(sym->addr->obj) & OBJ2MOD_MASK;
+		char *p;
+
+		short_objname = malloc(sizeof(struct obj2short_elem));
+		if (short_objname == NULL)
+			goto oom;
+
+		/*
+		 * New symbol: try maximal shortening, which is just the object
+		 * file name (no directory) with the suffix removed (the suffix
+		 * is useless for disambiguation since it is almost always .o).
+		 *
+		 * Add a bit of paranoia to allow for names starting with /,
+		 * ending with ., and names with no suffix.  (At least two of
+		 * these are most unlikely, but possible.)
+		 */
+
+		memset(short_objname, 0, sizeof(struct obj2short_elem));
+		short_objname->obj = sym->addr->obj;
+
+		p = strrchr(sym->addr->obj, '.');
+		if (p)
+			short_objname->desuffixed = strndup(sym->addr->obj,
+							    p - sym->addr->obj);
+		else
+			short_objname->desuffixed = strdup(sym->addr->obj);
+
+		if (short_objname->desuffixed == NULL)
+			goto oom;
+
+		p = strrchr(short_objname->desuffixed, '/');
+		if (p && p[1] != 0)
+			short_objname->short_obj = p + 1;
+		else
+			short_objname->short_obj = short_objname->desuffixed;
+
+		short_objname->short_next = obj2short[i];
+		short_objname->last_rehash = hash_cycle;
+		obj2short[i] = short_objname;
+
+		num_shortnames++;
+		return 1;
+	}
+
+	/*
+	 * Objname already lengthened by a previous symbol clash: do nothing
+	 * until we rehash again.
+	 */
+	if (short_objname->last_rehash == hash_cycle)
+		return 0;
+	short_objname->last_rehash = hash_cycle;
+
+	/*
+	 * Existing symbol: lengthen the objname we already have.
+	 */
+
+	if (short_objname->desuffixed == short_objname->short_obj) {
+		fprintf(stderr, "Cannot disambiguate %s: objname %s is "
+			"max-length but still colliding\n",
+			sym->sym->sym, short_objname->short_obj);
+		return 0;
+	}
+
+	/*
+	 * Allow for absolute paths, where the first byte is '/'.
+	 */
+
+	if (short_objname->desuffixed >= short_objname->short_obj - 2)
+		short_objname->short_obj = short_objname->desuffixed;
+	else {
+		for (short_objname->short_obj -= 2;
+		     short_objname->short_obj > short_objname->desuffixed &&
+		     *short_objname->short_obj != '/';
+		     short_objname->short_obj--);
+
+		if (*short_objname->short_obj == '/')
+			short_objname->short_obj++;
+	}
+	return 1;
+ oom:
+	fprintf(stderr, "Out of memory disambiguating syms\n");
+	exit(EXIT_FAILURE);
+}
+
+/*
+ * Do one round of disambiguation-check symbol hashing, factoring in the current
+ * set of applicable shortened object file names for those symbols that need
+ * them.
+ */
+static void disambiguate_hash_syms(struct sym_maybe_collides *syms)
+{
+	size_t i;
+	for (i = 0; i < table_cnt; i++) {
+		struct obj2short_elem *short_objname = NULL;
+		char *tmp, *p;
+		size_t tmp_size;
+
+		if (syms[i].sym == NULL) {
+			syms[i].symhash = 0;
+			continue;
+		}
+
+		short_objname = obj2short_get(syms[i].addr->obj);
+
+		tmp_size = strlen((char *) &(syms[i].sym->sym[1])) + 1;
+
+		if (short_objname)
+			tmp_size += strlen(short_objname->short_obj) + 1;
+
+		if (syms[i].addr->objfile)
+			tmp_size += sizeof(syms[i].addr->objfile->modhash);
+
+		tmp = malloc(tmp_size);
+		if (tmp == NULL) {
+			fprintf(stderr, "Out of memory disambiguating syms\n");
+			exit(EXIT_FAILURE);
+		}
+
+		p = stpcpy(tmp, (char *) &(syms[i].sym->sym[1]));
+		p++;
+		if (short_objname) {
+			p = stpcpy(p, short_objname->short_obj);
+			p++;
+		}
+		if (syms[i].addr->objfile)
+			memcpy(p, &(syms[i].addr->objfile->modhash),
+			       sizeof(syms[i].addr->objfile->modhash));
+
+		syms[i].symhash = memhash(tmp, tmp_size);
+		free(tmp);
+	}
+
+	qsort(syms, table_cnt, sizeof (struct sym_maybe_collides), qsymhash);
+}
+
+/*
+ * Figure out which object file names are necessary to disambiguate all symbols
+ * in the linked kernel: transform them for minimum length while retaining
+ * disambiguity: point to them in obj2short.
+ */
+static void disambiguate_syms(void)
+{
+	size_t i;
+	int retry;
+	int hash_cycle = 0;
+	unsigned int lasthash;
+	struct sym_maybe_collides *syms;
+
+	syms = calloc(table_cnt, sizeof(struct sym_maybe_collides));
+
+	if (syms == NULL)
+		goto oom;
+
+	/*
+	 * Initial table population: symbol-dependent things not affected by
+	 * disambiguation rounds.
+	 */
+	for (i = 0; i < table_cnt; i++) {
+		struct addrmap_entry *addr;
+
+		/*
+		 * Only bother doing anything for function symbols.
+		 */
+		if (table[i]->sym[0] != 't' && table[i]->sym[0] != 'T' &&
+		    table[i]->sym[0] != 'w' && table[i]->sym[0] != 'W')
+			continue;
+
+		addr = bsearch(table[i], addrmap, addrmap_num,
+			       sizeof(struct addrmap_entry), find_addrmap);
+
+		/*
+		 * Some function symbols (section start symbols, discarded
+		 * non-text-range symbols, etc) don't appear in the linker map
+		 * at all.
+		 */
+		if (addr == NULL)
+			continue;
+
+		syms[i].sym = table[i];
+		syms[i].addr = addr;
+	}
+
+	do {
+		hash_cycle++;
+		retry = 0;
+		lasthash = 0;
+		disambiguate_hash_syms(syms);
+
+		for (i = 0; i < table_cnt; i++) {
+			if (syms[i].sym == NULL)
+				continue;
+			if (syms[i].symhash == lasthash) {
+				if (lengthen_short_name(&syms[i], hash_cycle))
+					retry = 1;
+			}
+			lasthash = syms[i].symhash;
+		}
+	} while (retry);
+
+	free(syms);
+	return;
+ oom:
+	fprintf(stderr, "kallsyms: out of memory disambiguating syms\n");
+	exit(EXIT_FAILURE);
+
+}
+
 #endif /* CONFIG_KALLMODSYMS */
 
 static void usage(void)
@@ -424,6 +803,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_relative_base",
 		"kallsyms_num_syms",
 		"kallsyms_num_modules",
+		"kallsyms_num_objfiles",
 		"kallsyms_names",
 		"kallsyms_markers",
 		"kallsyms_token_table",
@@ -431,6 +811,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_module_offsets",
 		"kallsyms_module_addresses",
 		"kallsyms_modules",
+		"kallsyms_objfiles",
 		"kallsyms_mod_objnames",
 		"kallsyms_mod_objnames_len",
 		/* Exclude linker generated symbols which vary between passes */
@@ -700,6 +1081,7 @@ static void output_address(unsigned long long addr)
 static void output_kallmodsyms_mod_objnames(void)
 {
 	struct obj2mod_elem *elem;
+	struct obj2short_elem *short_elem;
 	size_t offset = 1;
 	size_t i;
 
@@ -755,15 +1137,75 @@ static void output_kallmodsyms_mod_objnames(void)
 			}
 		}
 	}
+
+	/*
+	 * Module names are done; now emit objfile names that don't match
+	 * objfile names.  They go in the same section to enable deduplication
+	 * between (maximally-shortened) objfile names and module names.
+	 * (This is another reason why objfile names drop the suffix.)
+	 */
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (short_elem = obj2short[i]; short_elem;
+		     short_elem = short_elem->short_next) {
+
+			/* Already emitted? */
+			if (short_elem->mod_xref)
+				continue;
+
+			if (short_elem->short_xref)
+				short_elem = short_elem->short_xref;
+
+			if (short_elem->short_offset != 0)
+				continue;
+
+			printf("/* 0x%lx: shortened from %s */\n", offset,
+			       short_elem->obj);
+
+			short_elem->short_offset = offset;
+			printf("\t.asciz\t\"%s\"\n", short_elem->short_obj);
+			offset += strlen(short_elem->short_obj) + 1;
+		}
+	}
+
 	printf("\n");
 	output_label("kallsyms_mod_objnames_len");
 	printf("\t.long\t%zi\n", offset);
 }
 
+/*
+ * Return 1 if this address range cites the same built-in module and objfile
+ * name as the previous one.
+ */
+static int same_kallmodsyms_range(int i)
+{
+	struct obj2short_elem *last_short;
+	struct obj2short_elem *this_short;
+	if (i == 0)
+		return 0;
+
+	last_short = obj2short_get(addrmap[i-1].obj);
+	this_short = obj2short_get(addrmap[i].obj);
+
+	if (addrmap[i-1].objfile == addrmap[i].objfile) {
+
+		if ((last_short == NULL && this_short != NULL) ||
+		    (last_short != NULL && this_short == NULL))
+			return 0;
+
+		if (last_short == NULL && this_short == NULL)
+			return 1;
+
+		if (strcmp(last_short->short_obj, this_short->short_obj) == 0)
+			return 1;
+	}
+	return 0;
+}
+
 static void output_kallmodsyms_objfiles(void)
 {
 	size_t i = 0;
 	size_t emitted_offsets = 0;
+	size_t emitted_modules = 0;
 	size_t emitted_objfiles = 0;
 
 	if (base_relative)
@@ -775,12 +1217,15 @@ static void output_kallmodsyms_objfiles(void)
 		long long offset;
 		int overflow;
 
-                /*
-                 * Fuse consecutive address ranges citing the same object file
-                 * into one.
-                 */
-                if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
-                        continue;
+		printf("/* 0x%llx--0x%llx: %s */\n", addrmap[i].addr,
+		       addrmap[i].end_addr, addrmap[i].obj);
+
+		/*
+		 * Fuse consecutive address ranges citing the same built-in
+		 * module and objfile name into one.
+		 */
+		if (same_kallmodsyms_range(i))
+			continue;
 
 		if (base_relative) {
 			if (!absolute_percpu) {
@@ -807,11 +1252,12 @@ static void output_kallmodsyms_objfiles(void)
 
 	for (i = 0; i < addrmap_num; i++) {
 		struct obj2mod_elem *elem = addrmap[i].objfile;
+		struct obj2mod_elem *orig_elem = NULL;
 		int orig_nmods;
 		const char *orig_modname;
 		int mod_offset;
 
-		if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+		if (same_kallmodsyms_range(i))
 			continue;
 
 		/*
@@ -819,8 +1265,10 @@ static void output_kallmodsyms_objfiles(void)
 		 * built-in module.
 		 */
 		if (addrmap[i].objfile == NULL) {
+			printf("/* 0x%llx--0x%llx: %s: built-in */\n",
+			       addrmap[i].addr, addrmap[i].end_addr, addrmap[i].obj);
 			printf("\t.long\t0x0\n");
-			emitted_objfiles++;
+			emitted_modules++;
 			continue;
 		}
 
@@ -835,8 +1283,10 @@ static void output_kallmodsyms_objfiles(void)
 		 * always points at the start of the xref target, so its offset
 		 * can be used as is.
 		 */
-		if (elem->xref)
+		if (elem->xref) {
+			orig_elem = elem;
 			elem = elem->xref;
+		}
 
 		if (elem->nmods == 1 || orig_nmods > 1) {
 
@@ -872,6 +1322,19 @@ static void output_kallmodsyms_objfiles(void)
 			 * the multimodule entry.
 			 */
 			mod_offset += onemod - elem->mods + 2;
+
+			/*
+			 * If this was the result of an xref chase, store this
+			 * mod_offset in the original entry so we can just reuse
+			 * it if an objfile shares this name.
+			 */
+
+			printf("/* 0x%llx--0x%llx: %s: single-module ref to %s in multimodule at %x */\n",
+			       addrmap[i].addr, addrmap[i].end_addr,
+			       orig_elem->mods, onemod, elem->mod_offset);
+
+			if (orig_elem)
+				orig_elem->mod_offset = mod_offset;
 		}
 
 		/*
@@ -881,12 +1344,68 @@ static void output_kallmodsyms_objfiles(void)
 		assert(elem->mod_offset != 0);
 
 		printf("\t.long\t0x%x\n", mod_offset);
-		emitted_objfiles++;
+		emitted_modules++;
 	}
 
-	assert(emitted_offsets == emitted_objfiles);
+	assert(emitted_offsets == emitted_modules);
 	output_label("kallsyms_num_modules");
+	printf("\t.long\t%zi\n", emitted_modules);
+
+	output_label("kallsyms_objfiles");
+
+	for (i = 0; i < addrmap_num; i++) {
+		struct obj2short_elem *elem;
+		int mod_offset;
+
+		if (same_kallmodsyms_range(i))
+			continue;
+
+		/*
+		 * No corresponding objfile name: no disambiguation needed;
+		 * point at 0.
+		 */
+		elem = obj2short_get(addrmap[i].obj);
+
+		if (elem == NULL) {
+			printf("/* 0x%llx--0x%llx: %s: unambiguous */\n",
+			       addrmap[i].addr, addrmap[i].end_addr,
+			       addrmap[i].obj);
+			printf("\t.long\t0x0\n");
+			emitted_objfiles++;
+			continue;
+		}
+
+		/*
+		 * Maybe the name is also used for a module: if it is, it cannot
+		 * be a multimodule.
+		 */
+
+		if (elem->mod_xref) {
+			assert(elem->mod_xref->nmods == 1);
+			mod_offset = elem->mod_xref->mod_offset;
+			printf("/* 0x%llx--0x%llx: %s: shortened as %s, references module */\n",
+			       addrmap[i].addr, addrmap[i].end_addr,
+			       addrmap[i].obj, elem->short_obj);
+		} else {
+			/*
+			 * A name only used for objfiles.  Chase down xrefs to
+			 * reuse existing entries.
+			 */
+			if (elem->short_xref)
+				elem = elem->short_xref;
+
+			mod_offset = elem->short_offset;
+			printf("/* 0x%llx--0x%llx: %s: shortened as %s */\n",
+			       addrmap[i].addr, addrmap[i].end_addr,
+			       addrmap[i].obj, elem->short_obj);
+		}
+		printf("\t.long\t0x%x\n", mod_offset);
+		emitted_objfiles++;
+	}
+	assert(emitted_offsets == emitted_objfiles);
+	output_label("kallsyms_num_objfiles");
 	printf("\t.long\t%zi\n", emitted_objfiles);
+
 	printf("\n");
 }
 #endif /* CONFIG_KALLMODSYMS */
@@ -1430,6 +1949,20 @@ static void read_modules(const char *modules_builtin)
 	 * Read linker map.
 	 */
 	read_linker_map();
+
+	/*
+	 * Now the modules are sorted out and we know their address ranges, use
+	 * the modhashes computed in optimize_obj2mod to identify any symbols
+	 * that are still ambiguous and set up the minimal representation of
+	 * their objfile name to disambiguate them.
+	 */
+	disambiguate_syms();
+
+	/*
+	 * Now we have objfile names, optimize the objfile list.
+	 */
+	optimize_objnames();
+
 }
 #else
 static void read_modules(const char *unused) {}
-- 
2.38.0.266.g481848f278

