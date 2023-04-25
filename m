Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8676E6EE3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjDYOLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjDYOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:11:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AB1146E5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:46 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDhp3u001833;
        Tue, 25 Apr 2023 14:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=YUghTuunJgcPurK2yB3sYGEpr7hZME8pxAnTfemiK8Q=;
 b=Hin2L4Avha5hRrApUltqdITx5y+OjvHvVoPFqStk7Sybqyyhc2nHKKRe+4bKVhdcMmYr
 qjVQIKdf3SBtGZs56Xk/NJfjmCVjwO+BMdS5Vthwnatz5ELGJal+fRMsaelIbgNdrKgu
 yJl6nBCsoKrFIx+vFYhfdfoj7Gn2mtIJxxAMHPSJ1P2lhmzj8kQ/M7jP9w2UVCXn6ium
 1lJeAlah52ZEFGGDiQfkMi0L2k4rKMfawzoHPf19orudkmP463JvpDhXEzPBuyN53YEB
 mDRZC+pTiLE3ppAyd4g0UoHkxtmN6TjThymkb/l+EfpW9YtoNJsEi6YMKGHbPjSnafAL gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47mcwfc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDHQcq025044;
        Tue, 25 Apr 2023 14:10:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461crbm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaUhzlafQQ9yYlccNTLHD4M0s3ccdDo1Nz29H2rFN4b3ZV9vTgpNhOCsgf8DNatz7lZ39YLJL57cn5Hcd6A3Ac28tATBke/BLitoDcUEWutOupP1L1lEpDzMByICrfhNu0UqLac+CtxWFUG/27R2xg1gZtQXAC6XbBAWij+r1g1sfI7VEaBdJ6hfKySXwNIAtrJ2i0kTwjyAZtcW0cPbyD2mwVCUGvApXnTbHkhYH9t6Apszw6rGpPyuNdeM/yTcyivCiSLTAwY99Clxs8Ff9utrlfSj/DISYvQAMIJd1GfKagfJRfVYccr9y77obolzZJC4r8RaTSoPHnoAyy757g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUghTuunJgcPurK2yB3sYGEpr7hZME8pxAnTfemiK8Q=;
 b=OFxMGWKsI+iJ3RlmcJ2+ljn27CQb1mYdimwLOc9Qyxwx14Y9oMnzOG0L1X1Hke54nWzYoHs4sEZgjxRqS4I6d1eZ2VCqP8zqV6wxLcPdXLrM1Y5EJxYfGdxVKaKozLhzFllXsGDFSCSEnZPYsY6idVhhZogFjPR9+v1LKDJvqNKvIGnE6Dt04iwDuxSXoAEoQbu70RpsvCFgnSsggd88MaZJTU5VGy+XtYLBtRcMPq9gNlBbWQvDx001eGJ+ccwFM3k6FbiJC8cp//QPvTrX7SbmO/O1RfH4HuDloCUneuoU3dSm3IzZf5Ldb+6Cor0syog/F942rew6BuAhHFnyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUghTuunJgcPurK2yB3sYGEpr7hZME8pxAnTfemiK8Q=;
 b=PQPB2CdXqlm1iYT9hz+kpjIO2eK4c6xR0uMPZCKkR2D5GhEqt0UeAGaAwSJtumD8lZ55rW4p0+lSg+xJrmS5a+LuYyxAA1Op74xV4oPuZphT7bzWNk2iOH6KYkKYDVUYfuYhoOGTfQU2tnbA5W9Jacu+H9AuSJPsNLIRrgRz5LU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CYYPR10MB7650.namprd10.prod.outlook.com (2603:10b6:930:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 14:10:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:40 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 09/34] maple_tree: Convert debug code to use MT_WARN_ON() and MAS_WARN_ON()
Date:   Tue, 25 Apr 2023 10:09:30 -0400
Message-Id: <20230425140955.3834476-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CYYPR10MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 02409481-c407-4bd9-ddc1-08db4596d9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0G3jzgU4rwtAw1RPHuNn51OpKddVO/zf0xpOQMHLzegv3KXJYG3UTzI2kIMzSgNb2+sq2IJklliS0WCBho7J2YhNQ0CK8NhH5jxDnZs2lApAP0tx6z4S5tNxd8dfn0Nl7Z8ba0poQ6xNF1Kjy7RLh8Qdm+YgFM1ZIVUIKtdx2OJNC+tHM7c9Bjlf8f/yQpseFy7MNe+nTbHUxcc6AT494i8Imf2+cDjV5gHx+kUjMA2T8TzKGXFTbjzmr3bQD4pW0U3Vn2651F8504Xdha8sGJ5rGLgeCum4+c25CpKbFubNok85PKHUjQG4td/GRBMFuKVMCul+yM6uQotOWK2Qw30B1und0Rnfyg5MXArReEYm3DEgMzYV/oiKfpSZ7a2RhU/9MP0JLlkzhBIEKLw6DElAbZ86ZaWCrILx5qLCBTz7c1TXStJ9jUbsnTXvZDgGbrDTbTDpY+YGfErCwn7Bwm7kYoqjFLnExuqK0OY/3m1wLU6F4kCAuDFJiTrghoK5t8huuv/xtV47/3xeUsEjF3wV1ifgrQl5i6dl14QmJTH2lxie5P6LHa87AVwPW3k/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RwIIdaExrx/wPTlZG0dy2F5q4YrrjYEuz9AoLvH1kzonWfzi05zeBiJEjHbR?=
 =?us-ascii?Q?kzVHv/hb0VIZxRks8bvhK9Ht1/GEzjrD8IXR68mW5ViwxGCiX9mT83f3nHKZ?=
 =?us-ascii?Q?rnyBrdFhpX6M/wBmZEfQZ9WA4qAXrqUcXi59c23UnxmXh4Xw5gRik2wKNRgA?=
 =?us-ascii?Q?niBsGKS8EMY7cN567NuqFm9SMjir/TiKfrntehgeXEr/Kw+L5VlD6zObhmHT?=
 =?us-ascii?Q?hYSebCqkBo1eQpoZxCKv1+hIS5Mo9MhPZ3pqBLbbnuSnruhiD3AkYn2q3D91?=
 =?us-ascii?Q?lPsiHjRP44OeWFO+iG+WLKjP+iX+RQvF65U2EV+ioUXtsIwSY+OFHpJJ8Toj?=
 =?us-ascii?Q?E/Ai9/CLVkc3ia1jBPXDyiArUVfxaWwaXE/51IH4QLKF+FsV/eJWZuQZCx/L?=
 =?us-ascii?Q?abnLdZV9boTQd86ZYHL56ywkgU5s7r1f0mEuVP5cPGPZKCUDnaSrhjFZYAIE?=
 =?us-ascii?Q?EFGwoMt73T7ElfmSckSfzpZ4ljm/+Cdts9QkoY+a8rtylap69cz6AA9MpmFS?=
 =?us-ascii?Q?z3g7lVu9cNsBUnsyUPzwMc/I3De8SNM73Fk4Z63UUnUpUbD5r7uDOTYZqaqy?=
 =?us-ascii?Q?KqOaDyjLCFIxZCU9x3HdbvCMHVdV8tvCYL7qVXFe6tQt5vt9f1E/KdqIygUO?=
 =?us-ascii?Q?BCgcCa+DakyRSGyn3qfNQGYHWcYSWGTUZn+Uo37ORGrsrLvPasbUjbiB4qrQ?=
 =?us-ascii?Q?g9uS1qKbtmULDupkBlEiAoby1ZXgJ6owiaO/HR3DR8F/5mjsU/3VM8f2sTi4?=
 =?us-ascii?Q?qM9CLf6xP6ix8CT5efQcV8Px1QGjiuNH5hswHtO5eveYT2DXGEJRd7Is3p8I?=
 =?us-ascii?Q?weyI3h2RwcK0XDy5CUCp+y95wX/X3TDUXUZBLDAYJQ9yUofhk7DpsY9GEZ6X?=
 =?us-ascii?Q?B+NMMzZncr/+gNeIyxTfod7D28VPnUq3ptMMYwAxnCtYM6Z9Dajr63QJ290n?=
 =?us-ascii?Q?oRKgHk8ZHQhSoMti9zYDqu3Gg6a10gKLtQthfbYxGylDqkxuxgiFHLVRh38r?=
 =?us-ascii?Q?xkVO4NjlQT2rHQUDCk/LC9af2dV0hilX3uECT10WjDic0/TrgupAMDKnhcaf?=
 =?us-ascii?Q?LRMULtmRERqCqtj7TYUyWUta/25IQVaisXBw/yeK2G9xcycz5dfa+aesw6Bt?=
 =?us-ascii?Q?rKdb2xXWrqoRuM3U4yn2yL7DdeJZNaPKUR1qkHwr78qIdxEOTUVCg/N57qw3?=
 =?us-ascii?Q?dGJfgJAhJ14ZrkUo1TGvm4UlVU9JyY1B0vJPdC9z1UpXry7bzwdcG1qWHF3Z?=
 =?us-ascii?Q?YOOFnMMDQdGN4Yg4lFFRidFyVp6SMofU8LUTmddGkvkiX7/5B7sRn1PjTqRt?=
 =?us-ascii?Q?976tDXfoaaTacGnSdOf7OHOWo5M4Jgxkxsla1rftoofkpkWgIjVcl/ILN6Hj?=
 =?us-ascii?Q?cm/Gvyb5B6c8mWH3czO4sQvpwe41TVExsuDZrq8WFsXIL4jCuKark+2bn7T7?=
 =?us-ascii?Q?PDplyXxJoUD3ZZRYWoQscfkYrTv5L0Z6J5x0B8Jl5Fjpd+73NEw4Jqz0WX8I?=
 =?us-ascii?Q?EBhYlbGQbpvv4WcnaC8g7KBYgeQi7AVMS5pIfScx6+5ZCcL+0CZOdXPMHP6f?=
 =?us-ascii?Q?+K4WVTiI9xuyAAR99cAnIUGVdjpLMI0ftW1Vc4qEIcUL4gHhQUmzMywXFKZy?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W8HJUHT1x9IrnTeVlUXIWP5NrF8vOIljpWA7kk7BCtggvonpJk/DD2/y8earwYs0JltKvZHp4BsWwA2iCaU/tj+GBK8v74Ych3tyHJP1SIYRBOrlaKCrRxWbfJrGkemLHHE6lluAzIXH4vSP9rQ9QhhTJzm50RmluPBWofpAHKvS2umodeniEIqdNBovzxt2zRoVYhXco2U5rYPvS2FHtB1HCSnNb6kQVxwN2n5WWOtFSvcOe/QWX45fRIXAefN7srTswS4thwmZWxfqnyoj5yuL2+yzo7MLm4zILn3REziHVZTZb6bSpcfEXIWCgZikNxl8J844qp7Cgx/1IcBUVM/TwfEiU8GS4bB+UHHuW2lOQjHqY5KEAvX7ebFeJyVIzzZgFQyaAxd/8OveuyAiyeSzVFvp4Lk0+xCCi90syb2ZRd9ZnZ8LJoV5d7bEpLPubknSEHK9fgKnGLf2R7QjbigOPPMWdB+sBdmuUe1SsTaUWZ8qS4FWG3leJWwhhRV0fRI3si4sKUJZ0nnm8R+S9ZXmaupz3efY+Yj+zRl2ZjvoL95J/B5gWGAHY2iA076qzb7lUBslq2X2qtUfukeDwTX5QQ3G1Ki6n4rBBUdBL+4JW9bMuk9YEdu8ImeRP+iAWDSzZzbrl8ec1Q8G7ixIGgDudklrR2TUw+Ks1fgET/VBMuETihzkp34/GvxZqbToe9U0Ss1DXo31BazNIsaxP+3gm87kvjPeQRgACZmV6HWx3fiPMm1CmUh4kbzp1M1gIU3Sp1nBxiExWeUFMO0tevHOSy6eG90LY3QYxnKpP950/uYfE1k29GYS/RP9nbpjOqYstsnrA91zekFybmBmeN/U0MXwZQcjHCgwIc+AiQ1DRWCgxb49/nztUC21IVuoZjJkPk45up5mc0JAi2cyDw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02409481-c407-4bd9-ddc1-08db4596d9c6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:40.5061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcOeidtT3KyzcbJtDWuur7kTqo84HOUhF3VFRh63BCzbnECMmJeXgIjCaCTVJB34vnmHoZDI/lHYmbd2Vb0F+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: WOrgBsNIbS9dHqb77X7Rz5YXewIieZT5
X-Proofpoint-ORIG-GUID: WOrgBsNIbS9dHqb77X7Rz5YXewIieZT5
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

Using MT_WARN_ON() allows for the removal of if statements before
logging.  Using MAS_WARN_ON() will provide more information when issues
are encountered.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 662a9ecccecbf..d22a337e9cb6b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5699,9 +5699,9 @@ void *mas_store(struct ma_state *mas, void *entry)
 
 	trace_ma_write(__func__, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
-	if (mas->index > mas->last)
+	if (MAS_WARN_ON(mas, mas->index > mas->last))
 		pr_err("Error %lX > %lX %p\n", mas->index, mas->last, entry);
-	MT_BUG_ON(mas->tree, mas->index > mas->last);
+
 	if (mas->index > mas->last) {
 		mas_set_err(mas, -EINVAL);
 		return NULL;
@@ -6530,10 +6530,9 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	if (likely(entry)) {
 		*index = mas.last + 1;
 #ifdef CONFIG_DEBUG_MAPLE_TREE
-		if ((*index) && (*index) <= copy)
+		if (MT_WARN_ON(mt, (*index) && ((*index) <= copy)))
 			pr_err("index not increased! %lx <= %lx\n",
 			       *index, copy);
-		MT_BUG_ON(mt, (*index) && ((*index) <= copy));
 #endif
 	}
 
@@ -6679,7 +6678,7 @@ static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
 	max = mas->max;
 	mas->offset = 0;
 	while (likely(!ma_is_leaf(mt))) {
-		MT_BUG_ON(mas->tree, mte_dead_node(mas->node));
+		MAS_WARN_ON(mas, mte_dead_node(mas->node));
 		slots = ma_slots(mn, mt);
 		entry = mas_slot(mas, slots, 0);
 		pivots = ma_pivots(mn, mt);
@@ -6690,7 +6689,7 @@ static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
 		mn = mas_mn(mas);
 		mt = mte_node_type(mas->node);
 	}
-	MT_BUG_ON(mas->tree, mte_dead_node(mas->node));
+	MAS_WARN_ON(mas, mte_dead_node(mas->node));
 
 	mas->max = max;
 	slots = ma_slots(mn, mt);
@@ -7134,18 +7133,18 @@ static void mas_validate_limits(struct ma_state *mas)
 		if (prev_piv > piv) {
 			pr_err("%p[%u] piv %lu < prev_piv %lu\n",
 				mas_mn(mas), i, piv, prev_piv);
-			MT_BUG_ON(mas->tree, piv < prev_piv);
+			MAS_WARN_ON(mas, piv < prev_piv);
 		}
 
 		if (piv < mas->min) {
 			pr_err("%p[%u] %lu < %lu\n", mas_mn(mas), i,
 				piv, mas->min);
-			MT_BUG_ON(mas->tree, piv < mas->min);
+			MAS_WARN_ON(mas, piv < mas->min);
 		}
 		if (piv > mas->max) {
 			pr_err("%p[%u] %lu > %lu\n", mas_mn(mas), i,
 				piv, mas->max);
-			MT_BUG_ON(mas->tree, piv > mas->max);
+			MAS_WARN_ON(mas, piv > mas->max);
 		}
 		prev_piv = piv;
 		if (piv == mas->max)
@@ -7168,7 +7167,7 @@ static void mas_validate_limits(struct ma_state *mas)
 
 			pr_err("%p[%u] should not have piv %lu\n",
 			       mas_mn(mas), i, piv);
-			MT_BUG_ON(mas->tree, i < mt_pivots[type] - 1);
+			MAS_WARN_ON(mas, i < mt_pivots[type] - 1);
 		}
 	}
 }
@@ -7227,16 +7226,15 @@ void mt_validate(struct maple_tree *mt)
 
 	mas_first_entry(&mas, mas_mn(&mas), ULONG_MAX, mte_node_type(mas.node));
 	while (!mas_is_none(&mas)) {
-		MT_BUG_ON(mas.tree, mte_dead_node(mas.node));
+		MAS_WARN_ON(&mas, mte_dead_node(mas.node));
 		if (!mte_is_root(mas.node)) {
 			end = mas_data_end(&mas);
-			if ((end < mt_min_slot_count(mas.node)) &&
-			    (mas.max != ULONG_MAX)) {
+			if (MAS_WARN_ON(&mas,
+					(end < mt_min_slot_count(mas.node)) &&
+					(mas.max != ULONG_MAX))) {
 				pr_err("Invalid size %u of %p\n", end,
-				mas_mn(&mas));
-				MT_BUG_ON(mas.tree, 1);
+				       mas_mn(&mas));
 			}
-
 		}
 		mas_validate_parent_slot(&mas);
 		mas_validate_child_slot(&mas);
-- 
2.39.2

