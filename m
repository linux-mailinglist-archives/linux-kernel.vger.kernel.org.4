Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1379261023B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiJ0T7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbiJ0T7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:59:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655BF89938;
        Thu, 27 Oct 2022 12:58:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHmpfx001409;
        Thu, 27 Oct 2022 19:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=zgGkXDjkyMHjdfNQzVhUVuVo36dzABRxbA++2XsbHco=;
 b=dSwcGvZoJJNoeiLaE3Bs190GiWGcaknJ9OoKnDaWpFjPiD8lsJY5KbWFebrZcIKZjEwL
 nW01DJ9rH2PL8NPwRM1dwZZUge6KSuSZEotbJb7MCMGrOHlNUxq0Xw02XuyGBgVXIs4X
 /3SRk9dTeBls4igOqJqQzqCtrujJKpWFI24/40rHfWOpPSN2fdSEdm2sUxA/8k0437rT
 Uw7DTgl263DmBhVM1bHHsKKvepA7phRRQgyBnXZwTc/ciBVFrMC7lLttjhqUc26Iidl0
 YfOXU/4Sz1OSj1wTvLYKG3Lbo3nLuLvBxSkCu9rP4zvPaYH4FPLKSkXXU6X5kU9Fwp7e TQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawru8db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIR3mq033439;
        Thu, 27 Oct 2022 19:58:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagnbyf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3DX39nxGJPN1hbTAw7jz1nJWLyUquLj2N8taAom9zSnU0N8WjXywBpt0ojs4+ownjc/g8ogZuOB6RnBeg31PzUa+9L3PnmTTsinkdi/YS5GoonOxXF+kjevtZTGG1TMG/nnojI68yi+FcnFHrFTkUx/fOsu7pXWl4jV8M5bEwLNxiUyWA0QmnPn9RSYnNlM3n1hL9A7hss7VqB710prgCRX+Hwp7EgB2sdbTf+boCikSs4B7DIQlYtz1h1GSaly42aMKENKt32OMiDMgP0GGHxND8RGucBIdI+WRbuOwp++tqXpE8pk5UE0N4DRTkk5INIoGnyaf/W8c+ypKuf6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgGkXDjkyMHjdfNQzVhUVuVo36dzABRxbA++2XsbHco=;
 b=n+PY2AcBh5Qo8pM9+anJOpP7my3/vFOFeTXJYoIprUqLlHiKgoO2z9+d1pwnOKOzE3bppmts7Qzm0In/tOrQAu3NdNV03kGsYQRa/ocD/yovGB+xooytqantArscFj5KQ8NJLZqztp05yH05LVtYO54IvE1ETBVQrav2fX+RJtsIFWrH3c/vkFCqAEy86irsC1QHAHFQtBYIPlEDrlVubpa1hoNtJWZerDAIh5V+orQv19EYl0tcstcFXcj/qq/asVhf/QYZMLqzubACw6rjtLl6hPWtk0uJ701rS1VcbFC3I5Wfn/IElmKbykrsczxH6VKQ8COxKsC2X9KVLVwGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgGkXDjkyMHjdfNQzVhUVuVo36dzABRxbA++2XsbHco=;
 b=C+pem6NjRoq5t01MhOc8TaF7TIROGwil1vNnqCwRTiLuFx7aC5UbOrn8xSG05DxkMr3ZF3sJ0dahhaMPWQssKSe+IGYQ2TQrjeyw826+lZXkC5WiSuvLK134ySba7r3srIHsog2SvEbeY2QGUkB5l0n7c4cQXsxu14qN59H+Juw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB6778.namprd10.prod.outlook.com (2603:10b6:930:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 19:58:41 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 19:58:41 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org, masahiroy@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 8/8] perf: proof-of-concept kallmodsyms support
Date:   Thu, 27 Oct 2022 20:57:54 +0100
Message-Id: <20221027195754.100039-9-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221027195754.100039-1-nick.alcock@oracle.com>
References: <20221027195754.100039-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0135.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::10) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: b4537590-832e-4840-7184-08dab855a54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOZxeadD1fhoe7r9YqZY32bJ7z3OgDAMhvWd6gOOSKRq7OPl2YNfxSEvvOry9mPANKH7N1LPZ/By4ZS5SRUJ+x3h6xcHFSfY+kfM+X6t05ysIOnWKc4AYtFDG/yrGIA6WBgPhZrhCKDBs6M2V4FtXvSGuELfe8epRwjg6T25PFSDazUrtuJ55FpMmV8wC2cZ6Iy71YXVspyT75AiAFMoX7HKRV6/uDCV+ZIyhE+SHzFwp2+s9NR7U3IxYwgM5uImOHZyD0m5wBGw4OZgm5d9wiHH4alg/oET2V4+v6Fq6FCaxgxcLw6Kh2ekTLeoh9cQGouzBrE06+EeAteeyVPKdR0f4ishzOBFmSj/S0A8jFnto2ebB/aU5jONKpqA146gtZ8z7GGGK6foZAD5SN1zxM5HfSv10te6CJPbXiDFdmBIx9ULV+IxzijmlPXW78L3GADUgRZckGGViZz/Lw9oKbRo/5h4ZwWjUqHtnuFMqjx6fzoL74UwRoy7TqpgCwujPDWY7ZiR/QqUD0unL4QeG64cfb1RFChFYHr2yuZOAXfAdPU3n9QPpC/6zBnFsa9jja2T0+vckQVDqarhzH2dUj2cdCj5JwGrDN6zgLNz6pgXD9hUfTAaXf8m2ff/CRuJwuqR3cvKkcPF+/bUtZ2VGSJlxDqb0ts6c6MtQQrEeg8jKovmWB5k723q8Mf92leWZbEKESPvMLdAPOFqNcjIWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(6486002)(83380400001)(41300700001)(5660300002)(30864003)(478600001)(8676002)(6666004)(107886003)(66946007)(4326008)(66476007)(316002)(44832011)(8936002)(66556008)(1076003)(86362001)(2616005)(6512007)(186003)(2906002)(36756003)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hx/d9rCXYS6qhaqsIasoL4CHzwWt1TqbFCdLsaaSO5dJnPHA0S+ftZL5nO6z?=
 =?us-ascii?Q?HmMY0AOR8oILcZLRy+fAa9ZqLtqQiI3vbcVZ7aITPRK/MDJbPwtsVA8dVTyb?=
 =?us-ascii?Q?6aJrBfFZjxx9cM0BIwaREPYMHLn/jnOBvkaHZD5md1xpi3B9BFz8Sb/GDKHK?=
 =?us-ascii?Q?rsTsbakFirA7+XgLkg2GENeErxL8G5vQqcHqFpwE668+cR7YcJu4QAW3pXE1?=
 =?us-ascii?Q?TfhucpJtzpG2/ezA5klGmgDwGsTYylGO+ZuSt2sVn8sg+pqn7QGMiXruQxAY?=
 =?us-ascii?Q?kMj+JKaF3qNKjBSHl8S7is2iFZjrrFI9XEDP1rZq8VSNS8iTeeVcTvm4xCkU?=
 =?us-ascii?Q?4oMl2rbFPLYn+EOuvbBv+jqtEPNtaXaXNwBlj4UNLSJ8mcjJGQW432OskJoy?=
 =?us-ascii?Q?4x78CpvOYgpKhcn0xoK2L0vrG3VOHptpDGFuND6scqdS8do6kplbcdlp20mY?=
 =?us-ascii?Q?MpB+o97Gs5x5RuacFIUKTZqwCJtdR7dUcty8qhe8IsvMvdrOLv5v3bnRVk9V?=
 =?us-ascii?Q?zI2y2KtLU4H/VVSG1v1ezKQuUJog1RI9Ee1xg3Wv7MDmUeZAx+M3+soLdJMh?=
 =?us-ascii?Q?CpRp2sCbtsj9Kr24MEz3RPKcrgMU/e286/jId3H/Iab2vGFP8tTVDc3JKiPR?=
 =?us-ascii?Q?ubFeZBZkXt1uQEIJ9GT/1IXLrVdsSE549IIvh+9hdjNkCY2KX/8K/KUQjA7X?=
 =?us-ascii?Q?lk7UGAHEYVM8L05eoOP5POUu/0OBJaVaAcK6KiZeZK8X2h5yCCaTlolni1CK?=
 =?us-ascii?Q?Rx+N0Lj/8BW47InH2OhbE7oT8AltBcUkv/RwGB7vsd4s5SykDjRLZH+roaPA?=
 =?us-ascii?Q?i/B6vU5EyOtJfcW3FYhQaTKKc9OixCy5UBvgJnrCeOYrQkrcwqgQI4/eqtXt?=
 =?us-ascii?Q?7R+xEEAsYbUSot6DhM6AN0vZfY8r+oeOikWGvsNiPtY/BF9sCaAjD4SJMsft?=
 =?us-ascii?Q?2x15pvLq44tW1PicVYeJYdauzww7f6GOGVstznj81hpbob4Wcj1+uG944Ern?=
 =?us-ascii?Q?jjekHD7My+wxHte5mb0+iBC2MpOQQ4U3M+KVMBk1DL8/13nvKQkHGqZPtnSh?=
 =?us-ascii?Q?OP/h/VnZmmjhPPpsHVVe5VfRpRU5ear4o87zowEbcdACvuNlrnDHxpz5czwp?=
 =?us-ascii?Q?96C6K3Z9tS/gKiBTfaVzfQeXwNuz1ptyxkrkgN1GKk8iUP3fVzczcUwOSu1d?=
 =?us-ascii?Q?PtTRhXB4ZGn8BB8ir8qVBbScAOoCH85XwQQj62RdCEe11zQLBw6/PJ6g1K1G?=
 =?us-ascii?Q?0Le6Iwr97HIM5YMMexO+SRvPm4XVhV8hV34ICtrgj4KqjPsA60YNjEc/nQwa?=
 =?us-ascii?Q?2+OWkN6YA9IPk4qIPCebOJl4hVNNIS5BAFSnpS+miqf6irkvNwMUj3ky6i2v?=
 =?us-ascii?Q?VXIYwYnT6EsTtnWEvr5GkYRZ3lzG9QV3iGA2OuOos5bXR+qkHjkmVTruS5sP?=
 =?us-ascii?Q?gJrcqRHLvClBvXFBqm52m6hwx9GbjxA+E8o9kumGqNHK3LD4AnXMmBzcH9sr?=
 =?us-ascii?Q?tNjiAooNamLOa6IsTaz57qjsnFwztd2l2XhL9H5FO0bPuOn4++KwWtQ70c9e?=
 =?us-ascii?Q?D4rkGRXLDSWE+HeY1iDZyJ3AIqSgSgccAGlx6Rc2h8Aunb+aM8onRhLZYFxK?=
 =?us-ascii?Q?2i6aT3KtFbGGCKT/7AOXhZg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4537590-832e-4840-7184-08dab855a54e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:58:41.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AN8YhgpMgL5K45XCzoUj4t31KwkG+uOqSN6z84F5ikAuEiwbzl45Hi7VjhV+WxfWXIvT9OdswqYuxFSOIkC/jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270112
X-Proofpoint-ORIG-GUID: HGaWHbYFNWF1Fr8xVuHpphkLbl6JQ7pv
X-Proofpoint-GUID: HGaWHbYFNWF1Fr8xVuHpphkLbl6JQ7pv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is only very partial: it adds support to 'perf kallsyms', allowing
you to say, e.g.

% ./perf kallsyms __scsi_device_lookup
__scsi_device_lookup: scsi_mod (built-in) 0xffffffff9b901de0-0xffffffff9b901e30 (0xffffffff9b901de0-0xffffffff9b901e30)

and get told that this is in a built-in module.  We also handle symbols
that are in multiple modules at once:

% ./perf kallsyms lio_set_fecparam
lio_set_fecparam: liquidio, liquidio_vf (built-in) 0xffffffff9b934da0-0xffffffff9b934e10 (0xffffffff9b934da0-0xffffffff9b934e10)

We do this the simplistic way, by augmenting symbols with a module array
field, the members of which are atoms in a new machine.modules red-black
tree (structured the same, and managed with the same code, as the
existing transient tree that is used to compare /proc/modules against
each other).

kallsyms symbols no longer carry a [module name] around with them that
needs cutting off whenever it's used (all users that relied on this
adjusted, I hope) but instead have that name hived off into the
per-symbol module array, with a new 'built_in' field to tell users
whether this is a built-in module or not.  Since we cannot use the
presence of '[' to detect modules any more, we do it at kallmodsyms read
time by spotting _end and considering it to denote the end of the core
kernel and the start of the modular range.  (I *think* this works on all
arches.)

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---
 tools/perf/builtin-kallsyms.c |  35 +++++-
 tools/perf/util/event.c       |  14 ++-
 tools/perf/util/machine.c     |   6 +-
 tools/perf/util/machine.h     |   1 +
 tools/perf/util/symbol.c      | 207 +++++++++++++++++++++++++---------
 tools/perf/util/symbol.h      |  12 +-
 6 files changed, 211 insertions(+), 64 deletions(-)

diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index c08ee81529e8..6bcec2522d2d 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -35,10 +35,37 @@ static int __cmd_kallsyms(int argc, const char **argv)
 			continue;
 		}
 
-		printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
-			symbol->name, map->dso->short_name, map->dso->long_name,
-			map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
-			symbol->start, symbol->end);
+		if (!symbol->modules) {
+			printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
+			       symbol->name, map->dso->short_name, map->dso->long_name,
+			       map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
+			       symbol->start, symbol->end);
+		} else {
+			if (!symbol->built_in)
+				printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
+				       symbol->name, map->dso->short_name, map->dso->long_name,
+				       map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
+				       symbol->start, symbol->end);
+			else if (symbol->modules[1] == 0)
+				printf("%s: %s (built-in) %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
+				       symbol->name, symbol->modules[0], map->unmap_ip(map, symbol->start),
+				       map->unmap_ip(map, symbol->end), symbol->start, symbol->end);
+			else { /* Symbol in multiple modules at once  */
+				char **mod;
+
+				printf("%s: ", symbol->name);
+
+				for (mod = symbol->modules; *mod; mod++) {
+					if (mod != symbol->modules)
+						printf(", ");
+					printf("%s", *mod);
+				}
+
+				printf (" (built-in) %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
+				       map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
+					symbol->start, symbol->end);
+			}
+		}
 	}
 
 	machine__delete(machine);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 1fa14598b916..a344b35f7e38 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -97,16 +97,28 @@ static int find_symbol_cb(void *arg, const char *name, char type,
 			  u64 start)
 {
 	struct process_symbol_args *args = arg;
+	char *chop, *tmp_alloc = NULL;
+	const char *tmp = name;
+
+	if ((chop = strchr(name, '\t')) != NULL) {
+		tmp_alloc = strndup(name, name - chop);
+		if (tmp_alloc == NULL)
+			return -ENOMEM;
+		tmp = tmp_alloc;
+	}
 
 	/*
 	 * Must be a function or at least an alias, as in PARISC64, where "_text" is
 	 * an 'A' to the same address as "_stext".
 	 */
 	if (!(kallsyms__is_function(type) ||
-	      type == 'A') || strcmp(name, args->name))
+	      type == 'A') || strcmp(tmp, args->name)) {
+		free(tmp_alloc);
 		return 0;
+	}
 
 	args->start = start;
+	free(tmp_alloc);
 	return 1;
 }
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 76316e459c3d..2be5a3c1a267 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -173,7 +173,7 @@ struct machine *machine__new_kallsyms(void)
 	 *    ask for not using the kcore parsing code, once this one is fixed
 	 *    to create a map per module.
 	 */
-	if (machine && machine__load_kallsyms(machine, "/proc/kallsyms") <= 0) {
+	if (machine && machine__load_kallsyms(machine, "/proc/kallmodsyms") <= 0) {
 		machine__delete(machine);
 		machine = NULL;
 	}
@@ -237,6 +237,7 @@ void machine__exit(struct machine *machine)
 	zfree(&machine->mmap_name);
 	zfree(&machine->current_tid);
 	zfree(&machine->kallsyms_filename);
+	modules__delete_modules(&machine->modules);
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
@@ -1410,7 +1411,8 @@ int machines__create_kernel_maps(struct machines *machines, pid_t pid)
 int machine__load_kallsyms(struct machine *machine, const char *filename)
 {
 	struct map *map = machine__kernel_map(machine);
-	int ret = __dso__load_kallsyms(map->dso, filename, map, true);
+	int ret = __dso__load_kallsyms(map->dso, filename, map, &machine->modules,
+				       true);
 
 	if (ret > 0) {
 		dso__set_loaded(map->dso);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 74935dfaa937..393063840cd1 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -55,6 +55,7 @@ struct machine {
 	struct dsos	  dsos;
 	struct maps	  *kmaps;
 	struct map	  *vmlinux_map;
+	struct rb_root	  modules;
 	u64		  kernel_start;
 	pid_t		  *current_tid;
 	size_t		  current_tid_sz;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a3a165ae933a..aab7ffdd0573 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -41,10 +41,16 @@
 #include <symbol/kallsyms.h>
 #include <sys/utsname.h>
 
-static int dso__load_kernel_sym(struct dso *dso, struct map *map);
+static int dso__load_kernel_sym(struct dso *dso, struct map *map,
+				struct rb_root *modules);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
 static bool symbol__is_idle(const char *name);
 
+static int read_proc_modules(const char *filename, struct rb_root *modules);
+static struct module_info *find_module(const char *name,
+				       struct rb_root *modules);
+static void add_module(struct module_info *mi, struct rb_root *modules);
+
 int vmlinux_path__nr_entries;
 char **vmlinux_path;
 
@@ -85,6 +91,12 @@ static enum dso_binary_type binary_type_symtab[] = {
 
 #define DSO_BINARY_TYPE__SYMTAB_CNT ARRAY_SIZE(binary_type_symtab)
 
+struct module_info {
+	struct rb_node rb_node;
+	char *name;
+	u64 start;
+};
+
 static bool symbol_type__filter(char symbol_type)
 {
 	symbol_type = toupper(symbol_type);
@@ -234,15 +246,10 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 		 * kernel text segment and beginning of first module's text
 		 * segment is very big.  Therefore do not fill this gap and do
 		 * not assign it to the kernel dso map (kallsyms).
-		 *
-		 * In kallsyms, it determines module symbols using '[' character
-		 * like in:
-		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
 		 */
 		if (prev->end == prev->start) {
 			/* Last kernel/module symbol mapped to end of page */
-			if (is_kallsyms && (!strchr(prev->name, '[') !=
-					    !strchr(curr->name, '[')))
+			if (is_kallsyms && prev->built_in != curr->built_in)
 				prev->end = roundup(prev->end + 4096, 4096);
 			else
 				prev->end = curr->start;
@@ -301,6 +308,8 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 	sym->type    = type;
 	sym->binding = binding;
 	sym->namelen = namelen - 1;
+	sym->modules  = NULL;
+	sym->built_in = 0;
 
 	pr_debug4("%s: %s %#" PRIx64 "-%#" PRIx64 "\n",
 		  __func__, name, start, sym->end);
@@ -318,6 +327,7 @@ void symbol__delete(struct symbol *sym)
 			annotation__exit(notes);
 		}
 	}
+	free(sym->modules);
 	free(((void *)sym) - symbol_conf.priv_size);
 }
 
@@ -716,12 +726,37 @@ static bool symbol__is_idle(const char *name)
 	return strlist__has_entry(idle_symbols_list, name);
 }
 
-static int map__process_kallsym_symbol(void *arg, const char *name,
+struct process_kallsym_symbol_arg {
+	struct dso *dso;
+	struct rb_root *modules;
+	int seen_end;
+};
+
+static int map__process_kallsym_symbol(void *arg_, const char *name,
 				       char type, u64 start)
 {
 	struct symbol *sym;
-	struct dso *dso = arg;
+	struct process_kallsym_symbol_arg *arg = arg_;
+	struct dso *dso = arg->dso;
 	struct rb_root_cached *root = &dso->symbols;
+	struct rb_root *modules = arg->modules;
+	char *module;
+	const char *modulep;
+	int counting = 1;
+	size_t nmods = 0;
+	char **mods = NULL;
+	char **modp = NULL;
+
+	/*
+	 * Split off the modules part.
+	 */
+	if ((module = strchr(name, '\t')) != NULL) {
+		*module = 0;
+		module++;
+	}
+
+	if (strcmp(name, "_end") == 0)
+		arg->seen_end = 1;
 
 	if (!symbol_type__filter(type))
 		return 0;
@@ -731,18 +766,88 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 		return 0;
 
 	/*
-	 * module symbols are not sorted so we add all
-	 * symbols, setting length to 0, and rely on
-	 * symbols__fixup_end() to fix it up.
+	 * non-builtin module symbols are not sorted so we add all symbols,
+	 * setting length to 0, and rely on symbols__fixup_end() to fix it up.
 	 */
 	sym = symbol__new(start, 0, kallsyms2elf_binding(type), kallsyms2elf_type(type), name);
 	if (sym == NULL)
 		return -ENOMEM;
+
+	sym->built_in = !arg->seen_end;
+
+	/*
+	 * Pass over the modules list twice: once to count the number of
+	 * modules this symbol is part of and allocate an array to store their
+	 * names, then again to fill it out.
+	 *
+	 * Arguably inefficient, due to one allocation per built-in symbol, even
+	 * though many symbols will have the same mods array.  In practice,
+	 * it's just too small a waste to matter.  The module names are pointers
+	 * into the machine->modules rb-tree (lazily populated here).
+	 */
+
+fill:
+	modulep = module;
+	while (modulep && (modulep = strchr(modulep, '[')) != NULL) {
+		struct module_info *mi;
+		const char *end_bra = strchr(modulep, ']');
+
+		modulep++;
+		if (end_bra == NULL || end_bra <= modulep)
+			continue;
+
+		if (counting) {
+			nmods++;
+			continue;
+		}
+
+		/*
+		 * Fill-out phase.
+		 */
+
+		*modp = strndup(modulep, end_bra - modulep);
+		if (*modp == NULL) {
+			free(mods);
+			return -ENOMEM;
+		}
+
+		mi = find_module(*modp, modules);
+		if (!mi) {
+			mi = zalloc(sizeof(struct module_info));
+
+			if (!mi) {
+				free (mods);
+				free (*modp);
+				return -ENOMEM;
+			}
+			mi->name = *modp;
+		}
+		else {
+			free(*modp);
+			*modp = mi->name;
+		}
+
+		modp++;
+	}
+
+	if (counting && nmods > 0) {
+		mods = calloc(nmods + 1, sizeof (char *));
+		if (mods == NULL)
+			return -ENOMEM;
+		modp = mods;
+
+		counting = 0;
+		goto fill;
+	}
+
+	sym->modules = mods;
+
 	/*
 	 * We will pass the symbols to the filter later, in
-	 * map__split_kallsyms, when we have split the maps per module
+	 * map__split_kallsyms, when we have split the maps per
+	 * (non-built-in) module
 	 */
-	__symbols__insert(root, sym, !strchr(name, '['));
+	__symbols__insert(root, sym, !arg->seen_end);
 
 	return 0;
 }
@@ -752,9 +857,11 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
  * so that we can in the next step set the symbol ->end address and then
  * call kernel_maps__split_kallsyms.
  */
-static int dso__load_all_kallsyms(struct dso *dso, const char *filename)
+static int dso__load_all_kallsyms(struct dso *dso, const char *filename,
+	struct rb_root *modules)
 {
-	return kallsyms__parse(filename, dso, map__process_kallsym_symbol);
+	struct process_kallsym_symbol_arg arg = {dso, modules, 0};
+	return kallsyms__parse(filename, &arg, map__process_kallsym_symbol);
 }
 
 static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
@@ -766,22 +873,14 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	struct rb_root_cached *root = &dso->symbols;
 	struct rb_node *next = rb_first_cached(root);
 
-	if (!kmaps)
-		return -1;
-
 	*root = RB_ROOT_CACHED;
 
 	while (next) {
-		char *module;
-
 		pos = rb_entry(next, struct symbol, rb_node);
 		next = rb_next(&pos->rb_node);
 
 		rb_erase_cached(&pos->rb_node, &old_root);
 		RB_CLEAR_NODE(&pos->rb_node);
-		module = strchr(pos->name, '\t');
-		if (module)
-			*module = '\0';
 
 		curr_map = maps__find(kmaps, pos->start);
 
@@ -830,19 +929,19 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	x86_64 = machine__is(machine, "x86_64");
 
 	while (next) {
-		char *module;
-
 		pos = rb_entry(next, struct symbol, rb_node);
 		next = rb_next(&pos->rb_node);
 
-		module = strchr(pos->name, '\t');
-		if (module) {
+		if (!pos->built_in && pos->modules) {
 			if (!symbol_conf.use_modules)
 				goto discard_symbol;
 
-			*module++ = '\0';
-
-			if (strcmp(curr_map->dso->short_name, module)) {
+			/*
+			 * Non-built-in symbols can only be in one module at
+			 * once.
+			 */
+			assert(pos->modules[1] == NULL);
+			if (strcmp(curr_map->dso->short_name, pos->modules[0])) {
 				if (curr_map != initial_map &&
 				    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
 				    machine__is_default_guest(machine)) {
@@ -856,12 +955,12 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 					dso__set_loaded(curr_map->dso);
 				}
 
-				curr_map = maps__find_by_name(kmaps, module);
+				curr_map = maps__find_by_name(kmaps, pos->modules[0]);
 				if (curr_map == NULL) {
 					pr_debug("%s/proc/{kallsyms,modules} "
 					         "inconsistency while looking "
 						 "for \"%s\" module!\n",
-						 machine->root_dir, module);
+						 machine->root_dir, pos->modules[0]);
 					curr_map = initial_map;
 					goto discard_symbol;
 				}
@@ -971,12 +1070,6 @@ bool symbol__restricted_filename(const char *filename,
 	return restricted;
 }
 
-struct module_info {
-	struct rb_node rb_node;
-	char *name;
-	u64 start;
-};
-
 static void add_module(struct module_info *mi, struct rb_root *modules)
 {
 	struct rb_node **p = &modules->rb_node;
@@ -995,7 +1088,7 @@ static void add_module(struct module_info *mi, struct rb_root *modules)
 	rb_insert_color(&mi->rb_node, modules);
 }
 
-static void delete_modules(struct rb_root *modules)
+void modules__delete_modules(struct rb_root *modules)
 {
 	struct module_info *mi;
 	struct rb_node *next = rb_first(modules);
@@ -1060,7 +1153,7 @@ static int read_proc_modules(const char *filename, struct rb_root *modules)
 		return -1;
 
 	if (modules__parse(filename, modules, __read_proc_modules)) {
-		delete_modules(modules);
+		modules__delete_modules(modules);
 		return -1;
 	}
 
@@ -1101,9 +1194,9 @@ int compare_proc_modules(const char *from, const char *to)
 	if (!from_node && !to_node)
 		ret = 0;
 
-	delete_modules(&to_modules);
+	modules__delete_modules(&to_modules);
 out_delete_from:
-	delete_modules(&from_modules);
+	modules__delete_modules(&from_modules);
 
 	return ret;
 }
@@ -1133,7 +1226,7 @@ static int do_validate_kcore_modules(const char *filename, struct maps *kmaps)
 		}
 	}
 out:
-	delete_modules(&modules);
+	modules__delete_modules(&modules);
 	return err;
 }
 
@@ -1467,18 +1560,20 @@ static int kallsyms__delta(struct kmap *kmap, const char *filename, u64 *delta)
 }
 
 int __dso__load_kallsyms(struct dso *dso, const char *filename,
-			 struct map *map, bool no_kcore)
+			 struct map *map, struct rb_root *modules,
+			 bool no_kcore)
 {
 	struct kmap *kmap = map__kmap(map);
 	u64 delta = 0;
 
-	if (symbol__restricted_filename(filename, "/proc/kallsyms"))
+	if (symbol__restricted_filename(filename, "/proc/kallsyms") &&
+	    symbol__restricted_filename(filename, "/proc/kallmodsyms"))
 		return -1;
 
 	if (!kmap || !kmap->kmaps)
 		return -1;
 
-	if (dso__load_all_kallsyms(dso, filename) < 0)
+	if (dso__load_all_kallsyms(dso, filename, modules) < 0)
 		return -1;
 
 	if (kallsyms__delta(kmap, filename, &delta))
@@ -1499,9 +1594,9 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename,
 }
 
 int dso__load_kallsyms(struct dso *dso, const char *filename,
-		       struct map *map)
+		       struct map *map, struct rb_root *modules)
 {
-	return __dso__load_kallsyms(dso, filename, map, false);
+	return __dso__load_kallsyms(dso, filename, map, modules, false);
 }
 
 static int dso__load_perf_map(const char *map_path, struct dso *dso)
@@ -1814,12 +1909,13 @@ int dso__load(struct dso *dso, struct map *map)
 		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
 
 	if (dso->kernel && !kmod) {
+		machine = map__kmaps(map)->machine;
+
 		if (dso->kernel == DSO_SPACE__KERNEL)
-			ret = dso__load_kernel_sym(dso, map);
+			ret = dso__load_kernel_sym(dso, map, &machine->modules);
 		else if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
-		machine = map__kmaps(map)->machine;
 		if (machine__is(machine, "x86_64"))
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
@@ -2220,7 +2316,8 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 	return strdup(path);
 }
 
-static int dso__load_kernel_sym(struct dso *dso, struct map *map)
+static int dso__load_kernel_sym(struct dso *dso, struct map *map,
+				struct rb_root *modules)
 {
 	int err;
 	const char *kallsyms_filename = NULL;
@@ -2282,7 +2379,7 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 	kallsyms_filename = kallsyms_allocated_filename;
 
 do_kallsyms:
-	err = dso__load_kallsyms(dso, kallsyms_filename, map);
+	err = dso__load_kallsyms(dso, kallsyms_filename, map, modules);
 	if (err > 0)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
 	free(kallsyms_allocated_filename);
@@ -2323,11 +2420,11 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
 		if (!kallsyms_filename)
 			return -1;
 	} else {
-		sprintf(path, "%s/proc/kallsyms", machine->root_dir);
+		sprintf(path, "%s/proc/kallmodsyms", machine->root_dir);
 		kallsyms_filename = path;
 	}
 
-	err = dso__load_kallsyms(dso, kallsyms_filename, map);
+	err = dso__load_kallsyms(dso, kallsyms_filename, map, &machine->modules);
 	if (err > 0)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
 	if (err > 0 && !dso__is_kcore(dso)) {
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 0b893dcc8ea6..9ca218e09acf 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -66,6 +66,11 @@ struct symbol {
 	u8		annotate2:1;
 	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
+	/** Null-terminated array of pointers to names of containing modules in the
+	    modules red-black tree.  May be NULL for none.  */
+	char		**modules;
+	/** Set if this symbol is built in to the core kernel.  */
+	int		built_in;
 	/** The name of length namelen associated with the symbol. */
 	char		name[];
 };
@@ -137,8 +142,9 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 		      const char *vmlinux, bool vmlinux_allocated);
 int dso__load_vmlinux_path(struct dso *dso, struct map *map);
 int __dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map,
-			 bool no_kcore);
-int dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map);
+			 struct rb_root *modules, bool no_kcore);
+int dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map,
+		       struct rb_root *modules);
 
 void dso__insert_symbol(struct dso *dso,
 			struct symbol *sym);
@@ -161,6 +167,8 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid);
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
 					 u64 start, u64 size));
+void modules__delete_modules(struct rb_root *modules);
+
 int filename__read_debuglink(const char *filename, char *debuglink,
 			     size_t size);
 
-- 
2.38.0.266.g481848f278

