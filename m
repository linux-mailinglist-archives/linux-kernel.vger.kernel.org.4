Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29526F87ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjEERr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjEERrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:47:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D641E987
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:46:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhJ55028052;
        Fri, 5 May 2023 17:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=CSPTd7X/nJiZQ3dnRaeG803+526/vbVCDuYpiQ7PWtM=;
 b=Sj3LL3XMXkylM5mJhnd4A+wEPRdyTSMIAUqNZajsf31/XJuKRv8lVaUrfLmleqxOK27O
 8yt7VHQGwSt8o8yxCe7a5yKLgpx9quiTWapBH0OIy4jRlBM2kkAzsY6x3Icew4bkthvA
 wrjo3OOSv66j5YauCWad4XZShZ9PNb3q4pZCBoMIHLLm63l1r+Ij4/bP334H0kSHIC7F
 7pNucx2u6HtnkAMeNPeodsCPFCqNYdxxtQOSAW8AlCxRz3FhJoo8MLKDkcM3CFhE/PUQ
 gkjJRwC4bzq/sOie6QeYtGhNjYyR39Y5FB/K8CQGJUBTVEN5ybskt7jQsHTdNkiE+zLi sQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t145jdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HA61i009869;
        Fri, 5 May 2023 17:44:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spankhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiZFI2f5hXOVT4TJTMqn6Bjfyyj84VmwqmgCYj50oxDkLjo6Y5i2xbAgXkuGo6R54j+x99KoJxvWlOH8kGUNr7N/LvTxLgQ+GLYywPFAJAx9R2lmwc/DwkG7XgqgTInWH2Qd8txUIvOmZTGYRzruKJVKHsPsqwYg3QCsYNa81hffbVxK2Hpw5hqQe4VjrGuwtAcqhr+PIbiQA5ug/NTGEb8Udl12pE6PNkxypDfhRdmVQufO0lGdVPm1jZCZRpVnZHEAhhzL950lq6o0BZd/g9m/PcdFvN5E4kNe+tgiBP/uHW3fYiMv4jkQ30I5XHGi8SYMr1xXCa3+pzscrvVMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSPTd7X/nJiZQ3dnRaeG803+526/vbVCDuYpiQ7PWtM=;
 b=fBp+xM5uaqfOPhTpgA1ABolQt+R/hwXhqSju9w9wGSrs8z4OhVA8OaDwYP5tpLJqQco5IBfGfGM39lxCTLht+OMbn7795osm9hKlvoUUAUAjEr/YxChlbeYbQkS75gboj4yIqWlK4vVbBuvlwOmoGCjytbj7mVZCuz0Kn80zcIi2tuiZIU3UnKKT43Ab7BTKgzOoF8Eq61wzI+VyrIztFAHySKwDcoEamMvZv7/8Xlgaf2BHUc0/a2RsAt6/WFbGrRbBKs60JCiv8BmhUawB8yrPnTdzs8Y4m9hW4c8qGM3tJUfQSLdXEpxZz7zI+9dLTYQO2z+tpANR5UOgYvoj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSPTd7X/nJiZQ3dnRaeG803+526/vbVCDuYpiQ7PWtM=;
 b=qfQ3Wo1MniS1VmgTxzTKp4JyUggzPAfujLh80yS02WzsBcuEgQGDy7SNN7DylTPlz5CThRuPHi4QmDhhi6BjpmWW93nnxjM0vnPcCCGTdPmWCVsowseKKbVsBWngfRKhCvmlVJbfHO/4RvpLfqTnyqkCBPKXVb/juV3MSDvLAdo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:48 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 28/36] maple_tree: Add mas_next_range() and mas_find_range() interfaces
Date:   Fri,  5 May 2023 13:41:56 -0400
Message-Id: <20230505174204.2665599-29-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0027.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ba792a-2f74-4c53-6efd-08db4d906baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ok319SvQoG1NLeUZ5Riod9yQZNGML6aNacDPbZBvgqDSUGy8vtSCakg8NAzQFnoCQGHuB+gMY39V9e0xpw+KSfIMRUtdmkVGuvr01F9f4p8ME5TrcW6SQmt0Xs7UptmSIoMoGLxjfJhw+Lob9mxVvtSbkeBPSnNfOImyHEJ/9tdozeoXamrZJDmhmuZ1lWd4U+Wcp5alEYDsiq3HtA5iE7tkuzEp7xoBdspDlCCsN9WLrz1NqGwAcE7Sz6uspuzUN/F7038G+vade1zqY14bTa6oRr/0LPws8Phv1MH4pXwivTTD4xe+ze35WETSKht4im/E1XCU8fz3k1ZnhRQF9sSG5ly6A4H7kCVgrCSUsBWMQme743jDpLml25bkSCb+PI/EvUHVMqiSHfbPNH8j/II3vYcPYBsDBobIZwMYb3wh2IQpaqIbm1BqtcPlff8SAl9/sUfad6MoBcaJwOOBIeK1tX2oxbzrI8uT6ZS2mJ1BLVJYTCqUzRpVIwTR9PoEY6FB8eTAFNfgAbOquYA4UJ53kgMPYkmJ6QkgamOhOu+EdunWMCpTUkYjKETdAdl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6666004)(6486002)(107886003)(2906002)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hm/n7/0xfKUOVKISchxXPXOOViByqAT6ez8tzBuZeu16ejTNndA7Whrcnnle?=
 =?us-ascii?Q?R7ODK8tBgdHC0Q9QmsCUzVh906ApqliotgNWzEgF9sNfO52Bf6m3b+zrNX0k?=
 =?us-ascii?Q?s+FuE7zkcrukhAK4bQstfyrpnmDevgCm51W71N51Lk2eUhWg4AlZ2f4nNwUL?=
 =?us-ascii?Q?ZowWhc1vU4V3nUrN797gPkvxax3JQxyxUpxFBzg7qgsa7llF+ubV6+4QxEHe?=
 =?us-ascii?Q?yiTR4lwNfR2Fs9y5DFW3uhbKIVncRr57AfySdvXmVI9JEc8zoSwvU1T2iYiP?=
 =?us-ascii?Q?L8TSd/5egf+nAh3qFCA7FpfmpQUSoOyFtku3ybVpYHRbeh39Ea829aRPhNTX?=
 =?us-ascii?Q?avoAvlEGEHJ+Gn7N39NvT0nEAaCyN6dfGS5Hy81+u7bAjZ6x6CAbsdqY6sMW?=
 =?us-ascii?Q?/RGGHRjRVjv7pS6ZQieORfLre1KP00Bq45UzBr9tbHN++H7ZNrX7O6trrQ8m?=
 =?us-ascii?Q?O+shgF3OTPNKlU3uCDXRaeREt+9jB27BJsAfPqY5iNPp1aK/bkyfgP8vif1n?=
 =?us-ascii?Q?ilhyAPj2WoPGH/3KQolOwCauSv1LO5gTzWs0uo7rkLuNiW0wfjCL4G/bPnbe?=
 =?us-ascii?Q?JAersEnvX0YaYToAytKOjPIKH/wfGFe1PjnJeGByf5VGZ5LgIcxuh+ff4pjp?=
 =?us-ascii?Q?xHla32EriU+xpK6xpFino3Cz4zJxuDHeMgAX6Wfvm2szxmVozwGbh8KEJnAp?=
 =?us-ascii?Q?MtprZ8YcnoWVs4fFtm3E5w6i2NbutGt+Vja/77O3F1USlsTNUMSMdFDDxQzR?=
 =?us-ascii?Q?PdxfItBZkN6X+HWR3SO93e+lsLAtzKcSU2MKX8j4w5py8UHbe6Tc/ZIcopmm?=
 =?us-ascii?Q?PV1SJ9HGYyxgZ5tG03AU2uRy6nI8pzHmTf9RnlMl/x6wRIF+oVvR3eIH0ktR?=
 =?us-ascii?Q?m8gPFxWFbv4EUFmOtkHSPISuK1oXTZSzPPTUimLxiY1vF5eDUhOOVhM5tDpf?=
 =?us-ascii?Q?tsUxxbh/ClUXeascGb/Uv97Jx8v7+Wu4FVoJlBIsWCWNv+ZhYSju+kjkvfIi?=
 =?us-ascii?Q?1e9aGLq7apa2kQ36R6xj65SLyKbWjlw51gq9pELtr+l9qZTwYWm12IJUD38g?=
 =?us-ascii?Q?rt4jtbUl6KOuotLTPBUs83tdS5fPlHqqSYH/UWVoURvgdilXMybEgRx5Bohv?=
 =?us-ascii?Q?eSJrtpO7Bssy78cB6wzkXh4Hr7Nlzuocf30qkRsUZXH10FCIsBCG1Quophj/?=
 =?us-ascii?Q?eEKuHEsOF8zE4kQTKczTa3xLHpe9mAT5B9dK40to/Xs+mGYBNYXtZwFFmCtt?=
 =?us-ascii?Q?C4wDVmYNkdSvRy6hbgG+MUtnySy4OuAK1omiJIMWeNUDIevx6h8ZqaRAs5qm?=
 =?us-ascii?Q?YIGquYNawpIN/o4VTCGaPiXbvmySZT/HNgEciq1nDJawZOea7u4rowvAkkbM?=
 =?us-ascii?Q?bLOlmvOG8QD3nVfbivHY4dfTkHCRuE0t/kgrgkcdDSDzHRD7fDL1csar34eH?=
 =?us-ascii?Q?6ujBfvljKx0ZY5rEdXEGWy54j96JFvuvFFAJebzBUHDGRqk5xcOnRWDwy37O?=
 =?us-ascii?Q?zKpr8okJTY56mGdh8bPN2OqRKDxQAIy+dh5Cz8R2/PL8aP3bwXAeYI7sJaS1?=
 =?us-ascii?Q?6wXFIJsWKj5twk6//ggXjbE/bshFfrvjFcrUIJWrdTiK8hy/ITE/04/MF7uk?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xs0XNdOwPO4e1IKlxs0BtX1yQT651jvUC03vFtaAk7K+pZZXDqLIxHtIF5HVdGBUFR2OyV/PhY/xGJmGNYL561ltsFoCM1zBoGI7gpyGRn/tQp03mqSWq6+hmdzDojZ1T/7E0unHBCAcBIs3DlIXsRQBccZ8SWt3j5OTJfsenL8k5nrAZLIZif3XqMxakwXMz+AAjc6YTqNDsngSwU7jjx3qXcZEAdHsq7z4H5nxmCUwAi/anRwMnmz18YqnuYEQoIsKkVWc+WFEaS/R7Znqh2Q9SV5WvqwSnL2Obw9EKsllsqAL3+2YnwimIre7Jbtya8SXgPzVZUhz0aOEuYavp/6y3pyYOJRDVWBLAWaqW+jYpuop1n7UDAUQxvZZHMqxt6IDptq8VH1wLferNMWnlSNPOI/sl0aK/AX9erDON8JXB65EW/KPaZCV8P/GVl7eA1s89wTEooBmxWlW0ujxg/zbP46bUGC9FFtx9pg/43mk+t3cPWYSB8xO5Dd5ZF3gWMroogGjC/myOL5BaYKyn2XU0jdKH4KzYECxVYvwcT++Dxt5Xq5K75chi0Thjlgz1o/GJ4g2lUWEf0aeHoGPDDu9Iwh+OzJtgBqmndwl51B61AgU5Yc9kUnHuYJUALYMSKUG/eKChx/8NjUiXMJSOsExf5IlpkBXFLFeUfwtwB0Iayvf2YJj99/XQEpViKj9EktLBkqmuFZTCBOqhSWtdPfKPXkvozrnoCqoKMa+IiB2+gxivE/0nQWBZm/RMMidX3nF2e2prtFF1Kg7IJcQBrKfWKstpeG/3+9LU6fTgqWVI4E8+/xn0s23meHtjzw7meKpULsRv0wBuHXY+2XT6ftLEgie3I82KUUcJdaGHIzmbVLwNm5vfkr9QweBppnbfCvSm3FHU0E4dReBRXzPpg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ba792a-2f74-4c53-6efd-08db4d906baa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:48.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzYTSYqBQk771kvzIfb/8WjH/syomPYxziXySBY+2FW5pYVJ/49xp+uiZ+nIeGTJ2IITL7wqV/eMt4SWLUKpow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: VxQ-Edq0BiYnWQuazuNsXOiGvsOrvBy_
X-Proofpoint-ORIG-GUID: VxQ-Edq0BiYnWQuazuNsXOiGvsOrvBy_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of the maple tree may want to move to the next range in the
tree, even if it stores a NULL.  This family of function provides that
functionality by advancing one slot at a time and returning the result,
while mas_contiguous() will iterate over the range and stop on
encountering the first NULL.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |  15 ++++
 lib/maple_tree.c           | 171 ++++++++++++++++++++++++++-----------
 2 files changed, 135 insertions(+), 51 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index ed92abf4c1fb5..a4cd8f891a090 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -455,6 +455,7 @@ void *mas_erase(struct ma_state *mas);
 int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp);
 void mas_store_prealloc(struct ma_state *mas, void *entry);
 void *mas_find(struct ma_state *mas, unsigned long max);
+void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
 int mas_preallocate(struct ma_state *mas, gfp_t gfp);
 bool mas_is_err(struct ma_state *mas);
@@ -467,6 +468,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries);
 
 void *mas_prev(struct ma_state *mas, unsigned long min);
 void *mas_next(struct ma_state *mas, unsigned long max);
+void *mas_next_range(struct ma_state *mas, unsigned long max);
 
 int mas_empty_area(struct ma_state *mas, unsigned long min, unsigned long max,
 		   unsigned long size);
@@ -528,6 +530,19 @@ static inline void mas_reset(struct ma_state *mas)
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
 
+/**
+ * mas_contiguous() - Iterate over a contiguous range of the maple tree.
+ * @__mas: Maple Tree operation state (maple_state)
+ * @__entry: Entry retrieved from the tree
+ * @__max: maximum index to retrieve from the tree
+ *
+ * When returned, mas->index and mas->last will hold the entire range of the
+ * entry.  The loop will terminate on the first NULL encountered.
+ *
+ * Note: may return the zero entry.
+ */
+#define mas_contiguous(__mas, __entry, __max) \
+	while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
 
 /**
  * mas_set_range() - Set up Maple Tree operation state for a different index.
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2865a987bc559..2f43afeae94e4 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4792,13 +4792,10 @@ void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
  */
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
-	void *entry = NULL;
-
 	if (mas->last >= limit)
 		return NULL;
 
-	entry = mas_next_slot(mas, limit, false);
-	return entry;
+	return mas_next_slot(mas, limit, false);
 }
 
 /*
@@ -5885,18 +5882,8 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 }
 EXPORT_SYMBOL_GPL(mas_expected_entries);
 
-/**
- * mas_next() - Get the next entry.
- * @mas: The maple state
- * @max: The maximum index to check.
- *
- * Returns the next entry after @mas->index.
- * Must hold rcu_read_lock or the write lock.
- * Can return the zero entry.
- *
- * Return: The next entry or %NULL
- */
-void *mas_next(struct ma_state *mas, unsigned long max)
+static inline bool mas_next_setup(struct ma_state *mas, unsigned long max,
+		void **entry)
 {
 	bool was_none = mas_is_none(mas);
 
@@ -5904,24 +5891,71 @@ void *mas_next(struct ma_state *mas, unsigned long max)
 		mas->node = MAS_START;
 
 	if (mas_is_start(mas))
-		mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
+		*entry = mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
 
 	if (mas_is_ptr(mas)) {
+		*entry = NULL;
 		if (was_none && mas->index == 0) {
 			mas->index = mas->last = 0;
-			return mas_root(mas);
+			return true;
 		}
 		mas->index = 1;
 		mas->last = ULONG_MAX;
 		mas->node = MAS_NONE;
-		return NULL;
+		return true;
 	}
 
-	/* Retries on dead nodes handled by mas_next_entry */
-	return mas_next_entry(mas, max);
+	if (mas_is_none(mas))
+		return true;
+	return false;
+}
+
+/**
+ * mas_next() - Get the next entry.
+ * @mas: The maple state
+ * @max: The maximum index to check.
+ *
+ * Returns the next entry after @mas->index.
+ * Must hold rcu_read_lock or the write lock.
+ * Can return the zero entry.
+ *
+ * Return: The next entry or %NULL
+ */
+void *mas_next(struct ma_state *mas, unsigned long max)
+{
+	void *entry = NULL;
+
+	if (mas_next_setup(mas, max, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max, false);
 }
 EXPORT_SYMBOL_GPL(mas_next);
 
+/**
+ * mas_next_range() - Advance the maple state to the next range
+ * @mas: The maple state
+ * @max: The maximum index to check.
+ *
+ * Sets @mas->index and @mas->last to the range.
+ * Must hold rcu_read_lock or the write lock.
+ * Can return the zero entry.
+ *
+ * Return: The next entry or %NULL
+ */
+void *mas_next_range(struct ma_state *mas, unsigned long max)
+{
+	void *entry = NULL;
+
+	if (mas_next_setup(mas, max, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max, true);
+}
+EXPORT_SYMBOL_GPL(mas_next_range);
+
 /**
  * mt_next() - get the next value in the maple tree
  * @mt: The maple tree
@@ -6031,49 +6065,38 @@ void mas_pause(struct ma_state *mas)
 EXPORT_SYMBOL_GPL(mas_pause);
 
 /**
- * mas_find() - On the first call, find the entry at or after mas->index up to
- * %max.  Otherwise, find the entry after mas->index.
- * @mas: The maple state
- * @max: The maximum value to check.
- *
- * Must hold rcu_read_lock or the write lock.
- * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * mas_find_setup() - Internal function to set up mas_find*().
  *
- * Return: The entry or %NULL.
+ * Returns: True if entry is the answer, false otherwise.
  */
-void *mas_find(struct ma_state *mas, unsigned long max)
+static inline bool mas_find_setup(struct ma_state *mas, unsigned long max,
+		void **entry)
 {
+	*entry = NULL;
+
 	if (unlikely(mas_is_none(mas))) {
 		if (unlikely(mas->last >= max))
-			return NULL;
+			return true;
 
 		mas->index = mas->last;
 		mas->node = MAS_START;
-	}
-
-	if (unlikely(mas_is_paused(mas))) {
+	} else if (unlikely(mas_is_paused(mas))) {
 		if (unlikely(mas->last >= max))
-			return NULL;
+			return true;
 
 		mas->node = MAS_START;
 		mas->index = ++mas->last;
-	}
-
-
-	if (unlikely(mas_is_ptr(mas)))
+	} else if (unlikely(mas_is_ptr(mas)))
 		goto ptr_out_of_range;
 
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
-		void *entry;
-
 		if (mas->index > max)
-			return NULL;
+			return true;
 
-		entry = mas_walk(mas);
-		if (entry)
-			return entry;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
 
 	}
 
@@ -6081,23 +6104,69 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		if (unlikely(mas_is_ptr(mas)))
 			goto ptr_out_of_range;
 
-		return NULL;
+		return true;
 	}
 
 	if (mas->index == max)
-		return NULL;
+		return true;
 
-	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false);
+	return false;
 
 ptr_out_of_range:
 	mas->node = MAS_NONE;
 	mas->index = 1;
 	mas->last = ULONG_MAX;
-	return NULL;
+	return true;
+}
+
+/**
+ * mas_find() - On the first call, find the entry at or after mas->index up to
+ * %max.  Otherwise, find the entry after mas->index.
+ * @mas: The maple state
+ * @max: The maximum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find(struct ma_state *mas, unsigned long max)
+{
+	void *entry = NULL;
+
+	if (mas_find_setup(mas, max, &entry))
+	    return entry;
+
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max, false);
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
+/**
+ * mas_find_range() - On the first call, find the entry at or after
+ * mas->index up to %max.  Otherwise, advance to the next slot mas->index.
+ * @mas: The maple state
+ * @max: The maximum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find_range(struct ma_state *mas, unsigned long max)
+{
+	void *entry;
+
+	if (mas_find_setup(mas, max, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max, true);
+}
+EXPORT_SYMBOL_GPL(mas_find_range);
+
 /**
  * mas_find_rev: On the first call, find the first non-null entry at or below
  * mas->index down to %min.  Otherwise find the first non-null entry below
-- 
2.39.2

