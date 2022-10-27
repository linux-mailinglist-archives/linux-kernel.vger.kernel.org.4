Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F9610239
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbiJ0T7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiJ0T67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:58:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC468983B;
        Thu, 27 Oct 2022 12:58:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHmpRv001412;
        Thu, 27 Oct 2022 19:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=2/AXzHCvqQXde74LhZFpYpeNnEDDNsHTMzasoJKQahE=;
 b=PtFoJwn1obR5qRdAJOsHLuWDy7TudRrO8xCMGUhy8wzEZmJ0aA6/ZfxBOYNgypxDtK6c
 s1cQxmH3HVBIk9ar5AvnxKiGBSjyH5pvqMB5GA1+ergYcaWvJmHYkoh0dV9VBNXnnIOG
 s5daC+NeKlaDz5GuJh+eFbJHYf2jyeSLLSWR3eJC/CElw+m29TXH6oPeDaLElcKD/V9r
 fx7sOcOBKomKzI3XeSfl3Zl8giMHv5oKINpHig0c0BTQIKPCCTPOhoZ/I54kA+JxrmJr
 UoD9pGSZcloB/YfD3gOaHdcoeGNwMvy7DXA8gczvkPhp9rH/SSBmNBn5FqfJGeTQyJEP tA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawru8d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIF3wS033247;
        Thu, 27 Oct 2022 19:58:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagnbybx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWb0g6ZgdPCtcgK/Lcd06XVEKnQINsqLBrzPfJZeZegvKwEIsV6La8846L2uZx8ObTEsDGKHfY76yMvWSno4XKS9k19nux51CN2TNs/RdLinbQX+iSKXTrPUIl8tpPu7vkauI//KuMmHMBf/4S82Vn0t1VKSVAV6PKqfVUXuvwg/Fzkm1lA9jNBVu0grm7iOLo6YuHt602MhOuNMl0hv/udLddkH9hEh4kFexUVnoKN3uJtL+bJqYfACPUCMh2Q5qw7sj+93eEL+fy1aeXWv9ak3OOIfMEbqK7aY3LYQv/TfPA4yby7+F3T7CFsEd55LjimN9cRriw4EHaPRt5l9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/AXzHCvqQXde74LhZFpYpeNnEDDNsHTMzasoJKQahE=;
 b=miIcHUJtxiSMgOQPU5I45t+VwTAvSKMTE2aYB/Qc5gAM2gXaf3rrjCdaV1zjRUII2P64iNBPswOuNgk1BiIpQmWMGa1VJ02dBH2X7i5LjKbZyRdRuJ7AChDdFGzhjwyHYqI0wFpe0ZaLkrdJkBq9NQSFd5M91ows8GzibgZU8WFkSW/Kzfl91DDoxTPCslazFKoxL7io5nro33BkTzt4OxSRKxXxSXzUinXnZxW90656oe3jVpiwUuNqakLnIpnRHKQKlH3B2Og+A+KEX7v6W5CzeUytAksy3HIINPMR9PmpmRY7767pNuq7YgE0GpaSI268VcxYNpOHg4h5jJDgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/AXzHCvqQXde74LhZFpYpeNnEDDNsHTMzasoJKQahE=;
 b=a1KJJ0cC9OF1hL0YxRndxAvrp7kOSsh2BmK/opy711eCzs499MCi+jE9vLIHmEmxFul+5pflykjr63VRD0HIUCAs2HH1LXcdk2Rf8od2oj+tCTBGN7tTLXk/NUvS7RoUmrua4nQxyo/azO4uswqB62z/hCv+4t/k3HMQaOmgBkY=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BL3PR10MB6042.namprd10.prod.outlook.com (2603:10b6:208:3b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 27 Oct
 2022 19:58:34 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 19:58:34 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org, masahiroy@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 6/8] kallsyms: distinguish text symbols fully using object file names
Date:   Thu, 27 Oct 2022 20:57:52 +0100
Message-Id: <20221027195754.100039-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221027195754.100039-1-nick.alcock@oracle.com>
References: <20221027195754.100039-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::15) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BL3PR10MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 18dc075e-4052-4ca1-318d-08dab855a0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agFAz8s+dCwKMe8dfW+VWPHNqRYTXzY9tgo6wNQnBAwN2F9jhXrgfT5StiiOBySklKQAApz2Hp6wvZddq/MRkB+DrOwgUTwb1YCB0n7ePXpgbU4ckVUPXcqN17gqTzpsedD9dpEdj+PX4ZtgJ6CV1dv4F5XgeZypVvlUzjrhV2+xquq+bVcaSSx+MUDszAbTHdY0Nd7Tk6T3CRbKd7Q9HFIb+/b5qRADvVGZPBWviwqQQBQbUbtAG3DDlbIRiKtz5dzwKdO4+pvmp1iWlmwH4C+zdJWclysjtUMSt0+9YVwjae4gvVjRDXf3ndKW+VRYvyEGnl8+JHYEqPSr+SVx56PqQNGez0qSIXpOzn7aFtcd8EYCQgOmYwlhkE/je4jIDuIIxo1Uz7Skjh19DkEFpu1PkEQnxaSDsMEUY9B8ByDPEEO5OqKDieLoX4ts3BKsSEhAEINGFsWj5zx7oncRX9pZ3kP4H8njmvmI2koBpnV4TyA1j2dtI5mWcAjZceBcvPk7INfosSgmORUh1m2NKhXHCvN0AlDErkybVhE/vU5u6QQtPE0UE2HFNHkI2/Fg0zOIkx4XQslViEgoYG0fCE2E0/17Gnrn/wjeXQP+WkdS7GV3UYe7xdsimqvLOcWLbSupvCP3MPc94Ta1lfEpK2Zuv8Vk0B8SRbgqgkHff7d6PXcIX16m+yVyd7S4ic3zmacTA9Rn1mfU+24te3lh5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(83380400001)(41300700001)(478600001)(66476007)(6506007)(6486002)(8936002)(316002)(6666004)(30864003)(5660300002)(2616005)(4326008)(66946007)(36756003)(2906002)(6512007)(66556008)(86362001)(107886003)(44832011)(8676002)(186003)(1076003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JbmLr643Chda4oBb71sYKEYZV0PCFPkSuWzdFNyYppkyIwsVQNt7tp4K5kMU?=
 =?us-ascii?Q?YuKFarI6YarFSz0qb+WC1xjghDnod0vaGdJR0juOEJt7IJKMFOCWaw3RD7i+?=
 =?us-ascii?Q?gos6vqTB7eqeCneU30z31bMvbgZ5ClqpN08Go+qnk2hJbv59Ejd11lqRKfZQ?=
 =?us-ascii?Q?/yuzHHwM7aCSFRVidAm7zR9MtB+CAkvm0Cge4DPSPR7RsATJbmMzT9bxC2Uk?=
 =?us-ascii?Q?ZaEIHH7ZAflgP2pOt+OypYY7rN700t+ZwZ3hTwBW4rgcpz5sjao+PczHti+b?=
 =?us-ascii?Q?ktudveKpSGdW3iNieVllXmCcE3wcdD4uEjtGCkW630eP9X2r1DJsA6n+l6he?=
 =?us-ascii?Q?Wq/QfL4yBHSNTXp86+JHBywpZSIEtJlVD3l97m0RTjMzQjCmLeJPlf1FvuKs?=
 =?us-ascii?Q?hZpFbs+ylgGoRXgHsuFGCjBP2wX/OSX9n+6HNftyboGILKDJ3xjPMZ92Tg79?=
 =?us-ascii?Q?rUr/VKH6K9q10/T7Un22pBiB6UbaOc4BhkIO0rnvWS6sn8J0M4NGhwgCd/as?=
 =?us-ascii?Q?mX2FliJDiti+0N46fa09fBLgWX7ytUHdVle7vZUpfXgzIgvcz99C2G2D3d+d?=
 =?us-ascii?Q?byFh6t4hkdr6WjDUbp6byzHM4aKYT9x/GDN+Fnhy4ylBGf9HVY/t+H1ux6SE?=
 =?us-ascii?Q?/O5jKfwL0M7cAcCIGeIY8j/OVphldTLMMS6nA2JrX62yq/u1pS678YYfZwor?=
 =?us-ascii?Q?/hp2wEkFiuxgf58qIO0DDhKigAknCyKmZYz4NKwBg/dn9Fo4QcPgY6gJbO1t?=
 =?us-ascii?Q?0lkbiLHnSQ7cQVzHAPhyBo5mBvR9b5ochpvnIlMbjzFvBDXFLybxaJfql5Kg?=
 =?us-ascii?Q?r9OlbgGVWaqCZtXY3to/JEAebHsy55Y4hIYuvXCpcx/drDyreBB5tAiMLWvP?=
 =?us-ascii?Q?HSSg2VQU37KRXInrOdV0yqnjr6eLqMD0iJMhnrAr/GxnEHcOtAhJy9beZ/va?=
 =?us-ascii?Q?wvosP+qdGy/HVJvmJ8YFo7Vwy6Ii7vS3vKUE2d6iw2OP72sAB5VN8jDZkgIE?=
 =?us-ascii?Q?RPeqzj1sG4RpAhO83S+XCnLKJdsZ7vvrdohVUJsFQ//sxDwuJ0PsMU2A/Y3/?=
 =?us-ascii?Q?usnL+qQ6ZwlEkIG54pIyVTQeCF3XzPvUq1M5YEzWpxLjsMjxSjR9QEXJvF0C?=
 =?us-ascii?Q?UVoPbYD5r/80RjZc+whZGPMrgZOD7FL3Loni6OO1t2xfNvUu5ki+WT/HOKJU?=
 =?us-ascii?Q?lfMfoIoehdJ0jCpIu0LnEtONoh+6bHLYPsA//hHuXtpOf1jFNplTH1+Q8uQo?=
 =?us-ascii?Q?6CptZTyJc3pv1f4wRDq/TJBCYr/hbtv5NgUpmiTgJK6er5sXsaGyOZ6xcwBR?=
 =?us-ascii?Q?x2IjSe8Jz1ObBDmC2vHuD6Yf3twRwNdmpDUxeG1IBxiVOms4Syxd113LIkQg?=
 =?us-ascii?Q?FD+q91qJL5oTfpbbW8KmScPhCg16g9lUCKRQ3BstpWBFfZbIrHRyjWVV2PyK?=
 =?us-ascii?Q?s+Y/uGo/LqZAcw6sW0mLmKhOJHrX0BvPphtwGhd7jzpTmU6RT/lc3cE1MmcN?=
 =?us-ascii?Q?RBusv3j1tymVM5FtAK95JXrzfCM8QlOzURgjfYHUtixKLPZsrwCBNqzSx1Bt?=
 =?us-ascii?Q?DJZtvGlYJdRiaASPvNJHoUC3o4l9rWCCvLni8fD+QdtGkMlepkAlDU4iuW3w?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dc075e-4052-4ca1-318d-08dab855a0eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:58:33.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D08Os3ZqYMaJ/5a4TWOfSZxKDUDlWqyC7GnaakUaGPWV1LQTjPp0QneAw8sEQyg4RfQbmymOGFKV/K8F6COArg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270112
X-Proofpoint-ORIG-GUID: vu63DnCKBYpU37u9PQPldqKAEBV0Fd-v
X-Proofpoint-GUID: vu63DnCKBYpU37u9PQPldqKAEBV0Fd-v
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

