Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654C56EE3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjDYOLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjDYOKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:10:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4271E5FC0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:44 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDhpZv001840;
        Tue, 25 Apr 2023 14:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=W5VCQae/u+KrSguTgZokUl+Fxo+cz9ZckZBWA2If+Ro=;
 b=lWCufE77AmGsxA2tWrVhV0M624iWLtyRFRKheBemUFQviJnb2lrOYtSXaHUU9xNjyIiG
 yxxt3Bj9ARGv7iBvUK6G9XM5WTYOcXEC8+4iZZtY+5P7Gz6dzPSadHRGu7oTirrtt4+k
 EE6uReHXzE2RQ1V85Z51RBZ0Q+e+wVa2OkTacrA+vEA/w/mYDufXCQ9b/G3qwe1ubzGy
 BpAsWjphbjB3f7DMmzORKZ9H19Lqqo7dMVthe9bITK+2dnKA6wX6elmv8cOHsksHE3f3
 WhL65PaVbPxirF2tYEZv5rYuL2lOZbTxFnlwYwjkeqrcsqhLtWmZnVN20wgGfBBME8Ur Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47mcwfc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDn4AA006793;
        Tue, 25 Apr 2023 14:10:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gqy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsmQml8gpNTVmOMsHMUjuRS9WBVlYGcIAYbr6jwwIt9koLOYKngEUBFBqn9ZKL+4sVHSv/ud3cUIBVTOgoi9zsICMbKszjQbrmvWzOLPupd6SkoZ9HYP0weex0g1NSWPlrECrjXgcMPlhccfIB7Rl4NHvbV+cN1RG1++SLTU4PzVgY2Bg+0uiRYyuhwdbnoQMvw00iGXDaDrsER+Kpr06U+7UbEOUtaZlhBAW7t6j6e0OeZulDx2/lysvgOo+OZ4jOjoXxEhEiqKUyOq+yFbniw8s7wioriBKYXEDV44v56UuiThwfugmF6ZO9UMeER3MDd+MQqtdlPrYCoVaCxzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5VCQae/u+KrSguTgZokUl+Fxo+cz9ZckZBWA2If+Ro=;
 b=IZ184cMrl/YvTvhuVCz1knmhrYVZP4XTzewKePnVfidTbioJbXfMcL9OmJfjA1B1Q9Dt4qMZAozlr6wC62LYRu20xqpPHAeKg5lIe6tXeKVd2pvhtBRyVCV9JI6AchH2kE55nVk/eR6FOxMrzUrTfxhaJRJwi7YBHZhY6dkJyI35aAYxHD270Tn1i5euaEEngsyNK39lcz7odvmWwvaJXTbYuxjVea5de2kdPbINMD/ZaEeIv1jWYr7UVtIHNsjUoO5jY50mbZgAxnrLUlGDGdI1inuHnXpTwvDAj8qkLFZsIKHjH2xV+aSxnrDLU1stdFSVEzeJXRoN/gds0ebSXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5VCQae/u+KrSguTgZokUl+Fxo+cz9ZckZBWA2If+Ro=;
 b=h0UI1LW9JGpXzcCp5F8tl53iZNRwY7EI3/GEG/3dLjwR/adSCGQ88e7YbJMZUwoexZjOGWKmCKv6akCKOMGhnIjzDeLrU52HXefWEAJNyFDXUE2MQ7XZRDJWfiusGQq0akq1ZNDXAWmMnmgCtXJjGtX1IeSr21TqBk5jTJu5GIw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:10:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:38 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 08/34] maple_tree: Change RCU checks to WARN_ON() instead of BUG_ON()
Date:   Tue, 25 Apr 2023 10:09:29 -0400
Message-Id: <20230425140955.3834476-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 34799008-0dd1-4355-03da-08db4596d8a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R47gbpjty5yCeT9VWfB79v5GCXyKTzIapZWZ+n69fg3IhlLke3pLQ0l55bpkU0crinIw1Y8gp6Ix5VrulNH0w2iATiilce0WEMAfRrAMTEH8lAfg+o1wAwcZrup47/NfiMjgI35kxGvd7ZtjOVgMAyPgKfno4tZ/aaBvzNe5sNHpJ6p+hPZEfZKjEXm8Dn9LTyV8Rjf5W8WgYlGOcNlei5/wutk72UmsILSLhoCDtVRCsbWrOnilzeCur5v0pBGp+aswNP+j0z2OYksw7QEYdAr2hO8lk0rZ7M1pde8kCWbZfr+F2JSmkSJEhGeC5WEnOYNn5PjVq7oWOKFBSrfPS9/Aj3qxXI7o6R/icZfuA17ibtAjsa3nkY3DJBEMuPyuj0GnudqDdD9uRmEQZMq79Ll0EPLBb9REAWEs3oFSdLGI3RCMsfeEeyhgXwE8ldX8aizeusXvQbkeBzuooCigdmOKB2pqqIukuvAou0x5cmBz4ZdO3K9qkR7vag9/tVjwIDFG5jgFQukEBzjnMRbwwnWfu3id5O5q+nkJ73EC0Ypl7q/i6OGpKg0dsY4OtYD8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(4744005)(2906002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(41300700001)(36756003)(86362001)(186003)(26005)(6512007)(1076003)(107886003)(38100700002)(478600001)(6666004)(6486002)(83380400001)(2616005)(6506007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NeQf7pFMZSmOiYDZDpOT13FSsEkYGyu7lm6jQfAsMmFvLxkRKb4JCwhWzUUd?=
 =?us-ascii?Q?H4IRi4WdpKdBGXNUVdEOUnZckDNG9R1yTdZiWgPOK4GVHVjUNET4v/3VN4Ux?=
 =?us-ascii?Q?l14aakPqZOiuFm5UDOd4+9bVjgpNMrI9UP9Y0ooYicxlCycovvi/KO3lfOTL?=
 =?us-ascii?Q?krz5AZg8cGJNQRH/36ocXPd5Fwu58Do8GRw0PKT2TFi3YiF5ChfQ8o68RTHn?=
 =?us-ascii?Q?pTadwtsJO+RV9AP1441XM3JW4iSH/TrQgROePzFHR3tndqzAHmL4Pv7DATci?=
 =?us-ascii?Q?Nxw+FN3UQmGYZiIz7z/lnTJGTYoghdUNoHqpDHta0uXKDJGrihpluvj2+3wF?=
 =?us-ascii?Q?48PHSZfqyWae2Kyh9M8iKzHziJyEmHu461fw2vUYz2cMfY7eIqj0Fj2f7R1G?=
 =?us-ascii?Q?KDfQpRQNiQ68nbaJu7Wkph3y+7m4JcmxLvLTLQZ3A2TC1lg2Ac23AEjhROs1?=
 =?us-ascii?Q?rGGLHI/2HIV/1vS+3+T5sWfXdrRye2/wnUARoc+tP20exutMfDH/KhdLDCLp?=
 =?us-ascii?Q?LxcmMFfcLiWn6k+kqYkGXBpQrDA8aR+IUeeCF6xeEUemyX9EeslRUjJZdKpc?=
 =?us-ascii?Q?A8OFubTL7mclYo3zGcbDo5tpVIB91Tw66YDbdLAC4XFrbOeNxLEwYMEKmEtE?=
 =?us-ascii?Q?NFCepN5PlztMIJZG5Pk6me8yJ9VuvusvkKsPK7ONJCifYQKQp9X9Mw3vRLY3?=
 =?us-ascii?Q?EzufaJt5h0CJDNiGpxW60YSkon4AgwOl0X43GkHNxJc7WvwbndkWrfZqtiqQ?=
 =?us-ascii?Q?s4//Li8RCkf7wzKm4UmLCmzB5lj8OZWu8dzzxPEgjX7ILjM6C26qBw8rcfNE?=
 =?us-ascii?Q?vqD8T93wigY00Ex0lY3GQ8sBwbDlTR1i/RO/SsZyftlivWUtf1Vnf1Pwy8Oh?=
 =?us-ascii?Q?Kv1fkDydF0BNzNh80TOfKLfDllsd/9au+yYC2OAXMbsTGCv/FPPNKMU8l0le?=
 =?us-ascii?Q?dFX/C4lONMwdzmLPS6x+Qdjzv0FeAcFCCblScich8hgK7bnvAFW3YYWj+CEh?=
 =?us-ascii?Q?TmGvX1x6v+a1D0HA9ufapnQ57ky50lZ07wxxjX/jSQSi4f+SwDQ2tm1lNuEo?=
 =?us-ascii?Q?p5CA22EHSQoUZ3MoYNa7gmGkDxOhIiqxGNwEs2IVRqDCDAIarf5ONL8gnLOn?=
 =?us-ascii?Q?H9CEduLpeO7an32Q4YVO1GPIuYzxai2ckd2emEjcvi7S2SqMDMNIxjTTun7O?=
 =?us-ascii?Q?1QKpQdFcBXTH5HvvaMliKIS3CRGXXWhpxrHIROp84IeyT/mWOV+uIFdv2d3o?=
 =?us-ascii?Q?3mTqU1vg0aehseHkdcUDk7e8N2dPk1embLOkhpskaRmjCU+OWxk+tjdGLKZu?=
 =?us-ascii?Q?nZlRXAtbfl+Kue1yHnYe2ZUPOumgafq+hfCao/FmAyb73sPXbCxmWUZugzFB?=
 =?us-ascii?Q?dr7smq7ztUeB2OUZRz4ZlGcXp1AddT1RUhxO99Td+lH4uEcaCUwhIsOAcona?=
 =?us-ascii?Q?+qPA2oOYDfeQvQiP+Twoib5dPeTQkT0xWlIIV4xl7wuSaPre5hhp2OMTK5Gm?=
 =?us-ascii?Q?FAe+zElD9g0bc0DnBz77klN3Y9BTT+avXoODDWI4zI6OZsjkMblImQ+5jisw?=
 =?us-ascii?Q?MZkT5TJwJKrruAgPR00+671L2mYZ4BF0VU61y2pwDTO9vkcrkYC9+9TRmiVJ?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QmGXuLNCVrHDlOFt+t8kUJCZKcQbeAhBaz1QvYk1HS+caC/K0rFN96OaB/bvNiPNPHA7vNXxLkY1ml/LnNT9Z2ud92aTCM6djOzlLRKuy2txfxN5PHCd51n/0ORgdeHxJolUP0C/jJGYz9dt9s7RoQm59StLRykx+KgsQwbgGWmD6bEauz7VRrccJhYUmJJaLodqvIKAgE/WpWxxJZGZKfamKGDwt+F5+8zxd7HvXLNWeMlFnWXusCHyewdotS0BadV8Artjwa2EMtpmo3ZFcnqmroI/liNskJydpc/cN3OI8mo6igM4WtwQPGoI5X2F2XuUixoobMdBH294tGx8oguJAsTzW1+UHlQPIdQ25ggzSZSV22VjQcDce4UaXGEAEc/o/KyM4hhuNFkX6FUM80BSBFrKY1R9wnvhP3x4WqDqoVUa5lNBFr4KhUigfaDa5Q3iQNX94l2cU8SCYlBQSzctNFv6Qf3+dPe7CpVLkBlPCWEPoat6Rsxuul5JBeTHe5eiqkj5XezEjhML3pTQKJ0TxpR/yMQHxzUEUCkFCGowbX/P000ZndI9zKxGkV5SX3vTL4sxFSFY9g7xIRvNSgwIPJJoJWmyA8pCyqCGWn7Uh9UpMUy5KV1GshFWf0dSnZ/nMELHTRtYO+2AdS8aMStNSknXKyaocWmm7CA6crPVroTqzZynUuRRm88RtwQ3mjBpr5vCWd5L6oTOrprVkENb5/zFdDTcR4dt2LBDdEL497yQ3QybGw9jHeAqQ43+/cuY1WkzBIOUWGq+DdMpOaMx9UfsDCPysRxUckfo74zNw/ByHFEfpCoafUT/cseJxK4K4/LPQToH2+WprtUQs53NNdPuH4lXDlmLFW5DiVrZ/ChDcg6RmVtBkOHKuiuq5aPV9dA3hZjlarkWgPfyVg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34799008-0dd1-4355-03da-08db4596d8a4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:38.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+twtW2KcbmfUj+gUWNF0JtwHoxra9BjoROlyJ39AC8yMQLj/JtohWW2yshvpkPPRDoCSr09KCg9AB/m0g44Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: JxUufsA0INALTwPkJNWfSch5F7T54zMx
X-Proofpoint-ORIG-GUID: JxUufsA0INALTwPkJNWfSch5F7T54zMx
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

