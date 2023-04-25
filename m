Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28246EE3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjDYONq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjDYONg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:13:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9EB146D0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:12:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDibUd006082;
        Tue, 25 Apr 2023 14:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=7H2wIy/la9zGER0MZ6oUbF5r5hWOi2yPIm1zTd6UTEg=;
 b=SupMEHNWvFC2qxRmU1f3/cXRbBlk8w373wL6wH1C1r7VRB/QswI7JEnl4ME8aIuS+WiI
 6s6KIbyhvzCemImzWHQUX5/PyhGnXuOE727+0yiHUXzlFTw6Crmv98AgzlDAPdbqLHj0
 WgSmxkLFU3zLoYl0fcrifyDA2sL6gQU8FmCAj7axJQ6t4GyiphjlmITSY+CmfwENTnEz
 sAOsniINAi4l5J/mdHwGazzm0U7HQYQyvEC4mnZAauvu8+xOzFNnjiXl4HtMR/8Eufyi
 BLSWhY3grQNRJmFWLFPihtYkg986Yf1rWIwyfKyTUWr+k4/B8cmPYl/CFTwu6eZUAOmS FQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q4661wgns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDuJe4006705;
        Tue, 25 Apr 2023 14:11:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gscs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaH4avUehhEodfV55WfSHcuAGfU71+malbQxHsgzpEDcoDR1da+Nb2Rl3VtwGDl8LqH/RVQiCzDJNm5v3IHRVY0MjuOx/WUHGI9XpXFsG9Vc6oC1YK31HL3uYNEjl9gSGu5kJZl3mORRmVIHy9n5ka2qe1tFNpa/Ec7CkImJSGajCYCcItJgTI9oQqZD3p67Lztv18KBKFgVh6jxoh3pBCWlupgu/DlaQytK6wS2jINJlaY8bMGfdpTmt5NiPJUptuFoOclN/pPyW1gReobZ8qGQlBs/gAKueJLKPTnJqwXxtGsu2q29bbXNgvFtO6wD3uQX0zfdhRPEUarYQxnyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H2wIy/la9zGER0MZ6oUbF5r5hWOi2yPIm1zTd6UTEg=;
 b=WTQZVXLTdIFmmUHiYwts4yYx3zPTWNnuKKDNsxDh7Y0dJPnZUGl3yOBD1B+FgEkCkxdhqLQqNc9MwlA9piKAb/LiJofbld7D+Ys1Gc6labLjVPH2wJ0H0f43PqlvE5M8YltBETDaZ6N6m7olDLqIGvba6rm2ggIRkHaPFfM6iI56ceRQfoXRQZPRa/5X5D8rz6sE3F2VSWAkv/UfwMIYCJy2WTw2ionWugGT7D2y/UMw0/6Xgq7pwEtORGjlijckt/vO6LDn5sM4U+XDOr5J/RHNX5ODafqxYqPCsG7oTwtKzNPqKWnGJ50eQoXWcYQAfL+C0hRKGHp9AbFrutSRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H2wIy/la9zGER0MZ6oUbF5r5hWOi2yPIm1zTd6UTEg=;
 b=FxllB0eU6lfWhxvE964CegWS+dFY9VIB4fWMpTEHgmxsVboRix5abF6k6UvIqvtT5KqFY7eu3u33ZUB92nUGhoPaI9hpKpJ3tX6MQwrcX+3dV76SUpfGN1v05h//FIcKbP+BkeRb6Q83zJ/jW+16Ze3Ka2LgRxHHHQ+LSkZogGY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:19 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 25/34] maple_tree: Clear up index and last setting in single entry tree
Date:   Tue, 25 Apr 2023 10:09:46 -0400
Message-Id: <20230425140955.3834476-26-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 573cf4be-fba5-46f6-6067-08db4596f143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIo3vjtUgup4kgpTOaZNKlShb/0MFhY8sbk7+jOt3WRJRMIQ+wtU7Ocr8hpXqX5WQ1IUqY8iiIdVmPTPUFRcExVAXH5gKj1as7jBGoFHqTdCmIjpVYw2oiAKvrXRON+Foyo6bFD19yhQ3x6KndlfImnvo0rEAhTQ7F2TD4DRUlPlwgjFfU2GYrDYBZPYb28VwIFcWTYx8X3xXjSaKTgE4ZVLMjPeN8qQ/kZJv59CmJBpoiEDhQqnITEOZbq8M9bvWWS7hpy7CIpXOcE/CqBM8TdrwOoF+kRuz9FxToUA9FLo1zSIajc7NYHyBcGtrujtvmZ2+PopRnilrrq28yAfE+RBMnP6fnLno72OQHeXZZ1REb2CBALw/BnxDaauVwrE0mjtKMnZ+xwp3gVD8FOrcbjpWPy4T4xAH/7MwR0D+q+smn/WcLcaOxcIZMFEB5PSa+tPrwEEhrdo0/IvtTujPPTVfEiiJ2dYqc2CRELrvnwgF2xlq5Uibc+FhxzWCy+y82+evrwAKlgwW8+Hsnqhk9Ovx+I7dMWODEnlzdslz1FZrGIYGInuMpvCy8NAMx7Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(36756003)(107886003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(38100700002)(8676002)(41300700001)(5660300002)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zq2g3TaS4CTH8JTC0UiT/vd26CAuOBcIqMiTrXxzenZzzS2cNhOdGpQ7SfS4?=
 =?us-ascii?Q?6KcwJuf5K0gkQgNr64kqzxG8vviosE1QkNQTJXeuAi5PKxhcNDWWytKJ4cFb?=
 =?us-ascii?Q?P5o5YjPTmZdYIayRh5CuazHXrBBLRQs7yPRQcOqPuvFsnMlmwR4hRyYzBz4W?=
 =?us-ascii?Q?JRxt7+kmyLB3rWbsEXE3eIq+EV/+KwSPtNUvIR2s0xdQgaO1Py0xo49PZHWp?=
 =?us-ascii?Q?zaspcU6HY2lcBHjm5KFlqZDUkBaAMojgjpLv/LM7DIZLP98qyL/OGADBGue/?=
 =?us-ascii?Q?SqHzMszRBwIA8Waj69vOTzclqSjge/sERUmC19N38JWg6S22skEqsbngqhTs?=
 =?us-ascii?Q?NYfg0vkxs4iMDKtCPbGgKS6phJwtvgRkFxvz9YSjPTaThNZxKNe2SE2vWNJc?=
 =?us-ascii?Q?EaEcu4xP0Kt1kbURyqskL0+VmulOgKZdZYt64Hnx2bQyT/hxgwDdmUEFeoIV?=
 =?us-ascii?Q?aKdQEifqrziG5Ysnm4oMnvUBoVmKE6n6LZadd173jYzkQ+BisIy2Sjr5/5tW?=
 =?us-ascii?Q?oIzuJmw5t26YDZE6OK/ioAVaDv6V6150pCCDCYLYGX24iVwEI1hlN0zHsJjf?=
 =?us-ascii?Q?vlM8tGTmPVOWvykw5NbemIPf87fJBfNwdsz+uoVVvvfFZpzeZfcsNqBF3sdi?=
 =?us-ascii?Q?GUsSgMzQPxs3NOFGCYUqZyXhjAVCZTI8Sb53+wKnUGwBm6j0ld75OSTNResu?=
 =?us-ascii?Q?qnNZrKbcn/AGN+bmA1CUUGHu5QUCJQmuItr53WgTCmUbU4XvCYabscoPA6Nb?=
 =?us-ascii?Q?gQZJrXUi+ObHSMuOOtrlusYLUZg/oxL2ifnVLckY9dgX18mfjsEvsK4qPXud?=
 =?us-ascii?Q?cvQ9Y2Ectc+vQSTA9qVVgv/nHFSAeZY3k22DyiQgdAmJSzD0wquunFVAf+XN?=
 =?us-ascii?Q?ZiB/XEE0VScE7AVE1WYZjGWAzyYQNug1T2gJWRqrfSVC+3Z8Ke8FMypXEaRf?=
 =?us-ascii?Q?DqEsEQ8KPXQXWlc2DZ2VrHHE2H4Gx92Xqyy/OHMNIEeNW+rB2SL3NiNKprHm?=
 =?us-ascii?Q?/aV5shG2HDW3YjmBuBllNWavpi6+Rp2+zH3Hy1Fccoee26AMtNJ7kL0MFSbz?=
 =?us-ascii?Q?wLB2GO8zSx5PB1jqPuXTDs4iWmZ97Y92d8ciFyMUTs9cxF6jc1fzWkFs2BE6?=
 =?us-ascii?Q?kEPYzyva/u9DLacXr3Lv31Xq/pT6V3Ks+Fld50IkgovhHTfrU16xncJne80q?=
 =?us-ascii?Q?CCk/3sWtpz8+8GZnF3OM0GdOioVs0qxVCcgiyTzcQNbZpHa6ubdZNGVOQQXf?=
 =?us-ascii?Q?+0NwAqYXFUSAM7d9E4ilZxjtMTIL2CEgC2nCMLxgzQW+8eeHHSVu3Gy6b72V?=
 =?us-ascii?Q?aOM5DehnXU7IGTL5tAee2rmq6n4k8x0pwlO8QPADBeArlF96Pze0lin73aGo?=
 =?us-ascii?Q?D2a8SSX0iBBM8SkCWI8SNELEbcMrvlWGTZNns4OnQkJKs7x/z9/sAu0jlblt?=
 =?us-ascii?Q?9wUG1M5/qnxV/96TieE9R+K2QD0shl/zPrM6jXEVm2ok79yrnh0njFnMeDk/?=
 =?us-ascii?Q?4y5vqGC5E67df/4UlFZZQBIiBYmTdqd1J7H47qWn28TWL0xpIhDsNIKHGSj6?=
 =?us-ascii?Q?eHlUQHBt6LV3S4w65Ik8c5J2JiKC2ko3smirCnTUagSe51kApv68+XzLXEnG?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DZ49Xnd645BQavHUnaTwjQHKC0KR/SQeq5wgz6GpvuiQ7TuE9k9P+5YDCnRi84slLtz8ybbYayXJU/Umf7Y96tbzSVQONzYPU2YrYYfgdM2qt69Cqm1Ao8ZQ/pNb/GDu4GifkAscNet5b3yTH9uhrPOQxKtQ4tLXtLmGKC7bWXnkhV1PA42iOWC+p7PYRPqh0sZ/dbupFYVOBcMhsmUCjQWF5c6TrTElehxQKpnQR1klCc/u1uZ/K9uxg9bzdbVEbVG5rGmpgwdn8Lu+6Zw+B1WlycuLn00uS11JZF6XbdkBlaGKJ4TnEfyL6pAI0cVD0s4VJisI4eROwACnupLBdHDrIWy6kW3opSqGTOe8vYqW5HT/a2OGYwifTLbXyMcBmkazinuDH6BGQgP2Yk9NQguqVprbXWE13z9UI1TDdul9tjUUJ2MykGWWmjwa7b6dYLeuhFPXRAaUAfN9ZZFC+nPgk3aN2mRQmnXlAYJkY1j8Z1aYq3BzmwJLS+ulnpDOVx003xaro/HpUBQyzh2vjZwQiqyvGcP5ZqtPwaTQF7nHUsm+hdAId3nbx6XUrHNsT0ILPnGYLP1myRwFm+nfTWdtEud40jOPxXtVHNBSpqLudOHQzEqSWSqDqJFuQ+xM/phjd4FSUMocoejpk49kYeJpNCZ/7vnjQmchkiKFKbwE8w19cjDjVv5sKmKI+BkpTuPNXsaYcZue/p6F7UNw0JzlyqEBx4FVoUrmxwPBTT/y/vndU5b/CGoSfZ4Tsu6P6Lbj/2iJ0BlD8b8RNn/lftu41+NrffAnYky+BenZyoJBn+lUzKRp3hHxrwThS7YifX4VS2UhrKg7/X2MJy6OX/7ibW8E2ytBMZj7S/TWMKot2dGHlom64Gt+DnUwWTDc80Rd3C2s3Bjx8Ow/7DMX3g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573cf4be-fba5-46f6-6067-08db4596f143
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:19.8877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iww0KbDh7aacA4pNn7CjE8th/hRsJEPrqNk2kh7hjsvn4EL94+NXB7I3VQLTilzdAQkMh1Y9Aqa5YyuC3QwH/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-ORIG-GUID: aSL3LELxtz-Ywa_nI11Tg0jxIXMZdS6m
X-Proofpoint-GUID: aSL3LELxtz-Ywa_nI11Tg0jxIXMZdS6m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is a single entry tree (range of 0-0 pointing to an entry),
then ensure the limit is either 0-0 or 1-oo, depending on where the user
walks.  Ensure the correct node setting as well; either MAS_ROOT or
MAS_NONE.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 20f0a10dc5608..31cbfd7b44728 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5099,24 +5099,25 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
+	if (mas_is_none(mas) || mas_is_paused(mas))
+		mas->node = MAS_START;
 retry:
 	entry = mas_state_walk(mas);
-	if (mas_is_start(mas))
+	if (mas_is_start(mas)) {
 		goto retry;
-
-	if (mas_is_ptr(mas)) {
+	} else if (mas_is_none(mas)) {
+		mas->index = 0;
+		mas->last = ULONG_MAX;
+	} else if (mas_is_ptr(mas)) {
 		if (!mas->index) {
 			mas->last = 0;
-		} else {
-			mas->index = 1;
-			mas->last = ULONG_MAX;
+			return mas_root(mas);
 		}
-		return entry;
-	}
 
-	if (mas_is_none(mas)) {
-		mas->index = 0;
+		mas->index = 1;
 		mas->last = ULONG_MAX;
+		mas->node = MAS_NONE;
+		return NULL;
 	}
 
 	return entry;
-- 
2.39.2

