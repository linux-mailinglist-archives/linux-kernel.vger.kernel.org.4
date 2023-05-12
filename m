Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A7A700EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbjELSVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbjELSV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446D79ED6
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4huL027771;
        Fri, 12 May 2023 18:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=W5VCQae/u+KrSguTgZokUl+Fxo+cz9ZckZBWA2If+Ro=;
 b=w42u76obBjtgYEKHuclfjHOsYUUW4tFjp73QSR0ClbFg/+Kis+xf/wKkiCHI8EAuTwhV
 0lcYcPnZUqprfRqY7H93NiQAdky+bwDGuCQNoxCI5+T3KFXIHc35KS2F5+pm+TjxB0bi
 rkn+DZT/5gdVhAynjPA0/F6Vlus6wyPrIQCOOFE/XqTlkhh64Ac+RFq/5BPPhEbH4lDE
 Wuc9ZWRim67j4F90DiJMG8kvZ8iGLufBEwMqnoQRbkPO3Sr4sCvINjblZ/7fCp79kRgb
 5J1hVHlT15S+zQ8dpR18YEXKSBaaPqslWyFFdhgZonXzmoJxMmiZ3cjiLOgv0CNXV7EK YQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77cbpu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHqHqd004416;
        Fri, 12 May 2023 18:21:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pnt56g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgbNw4fLqTwr+n7hCUWrQzYiEFjzLgYrO0waixj+fnV8v62od5rMaxZTW9WzgGg7inAJOWIdYU4w2FQ/QRavazc88HH7kcJqa5r+zmiVVu0nK+Hnui63ApmYncvIBOIgzyNgao67ZnjqrJYfdAiQZjNfCJtlY3pHExYzOeM4TTyT6XlRijS1kq98rhhrzr1ABp5LGXDmJVIQUzAd5cdQy+67xpVfZw7Xu5ltFxXe0aKVpgI8kINSo2JukHQS1pJtf8xIoTu60U2GY+rO2L+rNxH/hIufIbJvI2Ixln5kZnEVSr0KxRadc1Fvr/z3+eGPNteczRODpeMgvXUpOVBbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5VCQae/u+KrSguTgZokUl+Fxo+cz9ZckZBWA2If+Ro=;
 b=KQwM3z3UzmxPqBdoS0lEpNQBuLv14zHI/O5QYeXIzdMq/sIpAmstqozCy5AmI4MIhei/Hi889Oy8VF0YK6+G+2hz50rKMprFJCbEEl3rIc0p5PoHFjv09DVQ72Rkxwc1W2k/g5Ea/w10XZhGiQbYEOhztVZcsgkWgGIus4sNjNmkpIUS8W0JGZxYO9fd2gw/NseXhjO6n/dd4Z8Hj5/w5JpBqQOp+oMgm4Hk6rLbigiEKWxm3he4IW9vp6XMO/K47JEOeUrCWNXGamtI4se5E5SehXm7iqHY3t+kZ1GqopjW4HP56G0QTZZ8QZI1hxcz7NphgywBrDEnM4NrxyeSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5VCQae/u+KrSguTgZokUl+Fxo+cz9ZckZBWA2If+Ro=;
 b=CN4a9wh3QNqyZHsnVs/+2oya7W8aswVgd1vyeYJfDIuRu/X0SmYEQ3cAg8T3lTFYJf2Xo/stYtx2UQZ3dnfnRZ1I+lVPieLaPUP5rauvTBpoh0AMuYY+hIj+Lov58ZgXE0o40Z905i3gLiNpTlCtrPIw3lWUmsoARBy17Z8saq0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:11 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 08/35] maple_tree: Change RCU checks to WARN_ON() instead of BUG_ON()
Date:   Fri, 12 May 2023 14:20:09 -0400
Message-Id: <20230512182036.359030-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: cd49cd8d-5cc1-42df-6d00-08db5315a9ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPgrKz1HTFQv7WIEI/Oiabfz2PSRvawKD/Nn8OYxo4Ml0Bcz4Ab2yPQNR3a8ZuD8ZurbbrYKDO+USH1+s5WO35iVmdwreLWmeyLFGpVV0UKi4gZo22CaRe4I1Rv/OpEEZW7x/DvMA+IC/+42dFWMNuqdLzO2aUIbVqkJALwpRYedOdm5fn84/RRk+rypX5mfTQzmrMO5AnRwRhggugLq7In1ivKmuM5nCjw5E4/tROCPUg6bEzMpTdA5zYhPkqHtbalwqPqEtJtKNBXz9gAKopv3wGiyg4106o95N0iRuIs7T4/h0gf8drMi64NlBPYkcJsEE3+OCkSAu2NAYAD0d1u4ExdShNPY4qbmopoN0h/arfWFWQzl8qSjXrURyonPTmFBftCtQ23yrqPT6r821Ulng8HfZ/vnS6Mw9YQQLpcxb9e478foZMhY1N3j9Wzj6vqpWjCqmEcCHlcYdsIStEurXs4XkS4yvJ/JV0zdMzBEf6VhDPADL2c/h3Dh5ljCt9iv9eu+2AQUKiqP9G7B5j2885/RPkIAVwKYOTd1hC7NbwmnZd57TehJHYugjCdv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(4744005)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(54906003)(1076003)(86362001)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jy/U/Gs+GChbwn7hyIA62v8rTlHxKqDqoePMwDCgFE7xYVOHLdWpQzEJ2RzG?=
 =?us-ascii?Q?rCZP+WxgBu6idxLNYp0n4LEu8DCuM0axaqdKMhJ4/QAU46BfxAUuxszUUR50?=
 =?us-ascii?Q?XGqOFW13cLze8vaSJWZPQLJnJBJEpyMczE1pxvhEAstdtgXXmB+9K6+Xv7Wp?=
 =?us-ascii?Q?on7sa/sg0+Wob/rUAQ39t56sJKSJMWqU/Mx2WPc2JljaVoYlpR9VmlAXZjft?=
 =?us-ascii?Q?hLguy03x6gZ1+heh0I+YLYMgqGUEpOjjta82OYAmYwQLEO3SM3mBqCKRk6kB?=
 =?us-ascii?Q?cjY6g5/BdYpmVieQHkx1LE/DpBx7iRpymIDq8EwgyZpg00ADO1fp30CPWecJ?=
 =?us-ascii?Q?7MH/i8HEcvBlF7X4F29VcajaL+wouv9msmd9tuM30XwlTsQjhvNwKNCjW7Xl?=
 =?us-ascii?Q?ffdtL0W8cYYIgTiXy1vYtoyi+6MEA3NNT0BlHP7ucFE/GEKNiy9I1YjiY7P7?=
 =?us-ascii?Q?5Uxk6JSAZAJluUkcjwGQmCwMJ38OLiY3QRJTyiO13EFs1OHvXFxJLtjxKA6r?=
 =?us-ascii?Q?Raic3+4ofRkZypVigeD0KkxxLqqKM61YQ/LqzgwclAmfyKc2n/tIWzTewha1?=
 =?us-ascii?Q?whOe0uDNKS35QmSnrGOtONLS5fkDApfTF/CP0T0TXPmcbvjczFWHqt+vYkM0?=
 =?us-ascii?Q?EXVq/PIMbNER5chnHi6rzTihQ6ddfAscdukhlzsQ6FbobcIELEi5d+XkSkFv?=
 =?us-ascii?Q?M2MVssFrXBOluM4sL9CQe1WG/wwxomZP2WOOmgz6w7Kfx80oTPCY3eKebRAL?=
 =?us-ascii?Q?dt1dAF+bnVrFKjylsHkN5fi4PE82lqmI8Qv1Oug7KyC0Emn9nY1LiWGR5SQX?=
 =?us-ascii?Q?IIBZEL9ue9oVN3Dljq4I6RrznyNnOH0JUaW2MIk0PIrGPuoJGJY5Y2tGRUwB?=
 =?us-ascii?Q?mO92xuBULJAfvaxBB1gmdHj99xkB49RLiXbh1QjskCIIXq8o657YdTfM36u9?=
 =?us-ascii?Q?coURCKgQkPst95cjA8dImSSecD+ayk4joRb9siW4cbDCg+Xp9DrgOrsp+SGM?=
 =?us-ascii?Q?mCCS6bTUyr/hD1D3UXRl9W0V+8k1Yc9zeXmLn1iusGjTi8x1d84tguH5glxm?=
 =?us-ascii?Q?a7eEM4FZguo3zTKsWhg/KNy7JU6WQ+UX7U/i0kI6u8LdePY1dvmff8yN/H9r?=
 =?us-ascii?Q?Ill0g448h+EgCXoxTEjBnMryZH8vsQMM/sOoFEY51XFTvSbsf8P1Kko681Gf?=
 =?us-ascii?Q?0GTPN30dvdP6miOMhnogy3xhN1U2b2DMh94i9d6xc8QGfHXPD9ossjBP9H8G?=
 =?us-ascii?Q?KUH0tkfCKevBYTiEJi5FrcpYO6dJlKnW4GHPIQNl+TErai2pS3dELONi415n?=
 =?us-ascii?Q?fObChw7LDMbhzHiMLNQw0BTh2BbsYDWJlbzbWWtj0sIxfl3qDG84DrpNmwpN?=
 =?us-ascii?Q?jZL9nTivxNVCRgFCRHQwTRSHJPQWGPDaDe/QitWeYP2xLkQQDFkKwrAhAG1h?=
 =?us-ascii?Q?edxfiw88QoJ8rMFK8nO0fJuu9DpJnqGPJLGth0YiU29UarP6DExTi/rHjbnO?=
 =?us-ascii?Q?HC0/hXJqt8bcaWzLVg465JO3zjNGJxuJRaVCoBirtehWf6a6PnEplpD08giE?=
 =?us-ascii?Q?HEVkJnuxSlW0iuLOx0uTAOLbvq2tayjzL3JcBbuugrsZw9pXpHXdFWMBL34H?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 06tlN9+8Fvytessej2mGnhvRmWSf3cnfc//Ojl/7XySuPjFiHNTT9gGcdbeJxBC4x8uXx7WFhDPxhIW2BNeF3haanA7yJOImpNOPd0dGb7EMoJxl8GbaFy+qpZE336AlPbXvcArrEfEm610PnEL3RwPneDta2W9WoGjG3ld71fA1HVhwtx6OYwMHvFQtOvssxO0GkVahyS1yveZ3Bwr550FzmBgaTdx8vAEvJ46oEGqhoI4mbZYzkGuBaymYzwHWKL/DOR1o+fGK2S/yiD1FMVUvR7pmoFqrVkcXZr/SshijG/dabhIMQ+omSn/msEvlcQ4lANUCdQSBlT7V6uUF7uEf2ieCImu4z6mFuT26+VhQ1QA2x3ozVV3bQotHOFx3yCAxsDJDWqA4aSG0v+XZqImAXFyY0mAzX1GxT0uS6w7gan2/OpNacLgnQu5ElUXb7I0jTorK9t/tG8wUi9SH47KqKj7y6zoHYtJZwavOGv90XurPUHgz1iQ3nt51r2EbF924kQzJ17wwtob7WxfRnTQwKqTxQn6Xl2fYNgrDBYBpDHTQa0EFgFfGt5LMWvSagevmaouuB7A2gX2PAfJ+JMxXsfO+iD84VCDWVMPVftGem9rj0+HTPWQ5EBEat/5WM1oOCeWVn3hTKYp8zliCrXVRk/eOegxu9BZ5V2CNRe5tDheOV4P4cXkVOc57oiZpjGm6ceD+cIFd6v0hBr58qlL5wBgbdSPMNY38unBRhOMtbb6GZtX7gs2wEVYjcio04YQgJ8udRPFfrnGHgQxV94nUapx0WqeWZlYFoavmohw6JjlsYE6TF8p0N4AqneNBB94XjUnfK7wvumyl7f5Jw0o3NHPTa0e8YKS9cbSn1JHGOGtkz7+7qt2VdWx+Od4zQtOuA9bZoQvJDg2jgln4Xw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd49cd8d-5cc1-42df-6d00-08db5315a9ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:11.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL8Ziq4wWIdPzdh3ljdmDl5OUE0Xws5vWfKXI2XeYHvpvDDSL2qPKC33q31hWHXwySaAvWuJnbSK7vgda+ZbiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: gW8HvWAadnARSXmgBSdkraqoHZeQ1QRn
X-Proofpoint-ORIG-GUID: gW8HvWAadnARSXmgBSdkraqoHZeQ1QRn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

If RCU is enabled and the tree isn't locked, just warn the user and
avoid crashing the kernel.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 204d7941a39ec..ed92abf4c1fb5 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -616,7 +616,7 @@ static inline void mt_clear_in_rcu(struct maple_tree *mt)
 		return;
 
 	if (mt_external_lock(mt)) {
-		BUG_ON(!mt_lock_is_held(mt));
+		WARN_ON(!mt_lock_is_held(mt));
 		mt->ma_flags &= ~MT_FLAGS_USE_RCU;
 	} else {
 		mtree_lock(mt);
@@ -635,7 +635,7 @@ static inline void mt_set_in_rcu(struct maple_tree *mt)
 		return;
 
 	if (mt_external_lock(mt)) {
-		BUG_ON(!mt_lock_is_held(mt));
+		WARN_ON(!mt_lock_is_held(mt));
 		mt->ma_flags |= MT_FLAGS_USE_RCU;
 	} else {
 		mtree_lock(mt);
-- 
2.39.2

