Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C682708469
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjERO6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjERO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699AED
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:57:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IpcF003885;
        Thu, 18 May 2023 14:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=iIEqoKHCtZVIcHQcln7ub7Fr3AEamO8DkcUXBPgJVW0=;
 b=KLLtgtxuOqobTuSqI6fvrBtxKQ7Uz8G/beucSIIJX3X+tNRguA+cGpEd5kxX/ZCy58q0
 zGmyOyCxNQqXnexctByZu6vzEtCdjypZJVb+UdfhUbHH0KGXc8QbMHnPjnynztWs2Ztg
 Rbq7soGTwaWKnqulxq2Ig1PlHC007cmGxA0zmanbbvWn38KJHVEKbchZ6k0IaqRCHpjK
 Rj2ncStexZQ2YoHLhMB7AO8dLGooXZfSV79VNrgqXQKmjaH9GuptK5U0FLBKzwZcir5D
 L9xkwGVqEETFLuMPksIh4sI6WfGIEKG4TCk/55EpTFK35hdo8IVDlOepr2RWMKnaKgf7 cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33v043b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE9Wc4025017;
        Thu, 18 May 2023 14:56:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106vkvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSI2vh65brkq1vEIPyyT0+T2t5gbfIDrKZXmvhflfe9wkRwwKy5j93nZFISN/UR5tOgoQoRY3QNfCciNyGLM+xIFsvHp6McJP6yRDVKhUsxV646UErCkGg/f7CuQnD+U6VRDMrsRGRlSzn+Owe/PCSwBw024KtKy1wlNxbjeJDk429kIaf9OCxFuuNjRRYi3hHxlmahCJ0ZqbcjvmAfffdEM9NCtAqU1EF1Mw12zIeurvvGmmx4v1OnWBaEXl8R6xbh+pZd7lKXM9QMeDOoJlDZNgB5I2w1jHNm72QTF8OCaluymlfFjrSJcSPt8WcmVfCtfs/XcRbtT3eAWuxwfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIEqoKHCtZVIcHQcln7ub7Fr3AEamO8DkcUXBPgJVW0=;
 b=WFSTtgQLvtPhD9Z6ijt4N+opsQkduyjqvn17lTL10jC6g0Ci2x6fw8EZjd8m7roheDPb4IimBq/4B4yeRs8nrWIYNI4TfAJXprt8F7sQa7o0rCvjbqZ3leTuFZonrnRmcvGbOD935bEmvOYLh+YRYmcjYDFRSC9kAd6fShoSvXnECEfvZXS0499REPfC2jrzmG2Xzsz6eznAWDYnt+CRciyINxRlBYnTcB/2jp54W15PQ/1+ouZBYZ+sY22MfmSijxGhV9T1ED1qq1JLcfG/w/G8S8DF17RmDHuJfozKvC+ZTnmejsEZHApXrT75ttEUOmVy1UiwZM+NEwV6VR7odQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIEqoKHCtZVIcHQcln7ub7Fr3AEamO8DkcUXBPgJVW0=;
 b=AeKmOlpGsjXg3Ro4DlzUUDxuaScIM0N+BZUba5Z3lM23T7VnDQVGiuBs3hIn7bpV7cDHQ5LGwT3Ex5KO9WBZh3IJggxZV/p3NKYo81dJIBPt8DSJoCmeEbAWzYY7VP8BkmCOxID2S4sok6VhxWedKR4PBGojj38pBfuk7LMVeE4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:56:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:08 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 08/35] maple_tree: Change RCU checks to WARN_ON() instead of BUG_ON()
Date:   Thu, 18 May 2023 10:55:17 -0400
Message-Id: <20230518145544.1722059-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: e7048e49-2387-4cfe-68aa-08db57b0034f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gURmUyVULnU2pzDkWml4HZ5MjgeCIytIM5T+jd8eMcSA9+nYaOZ61jW7SMrhNhxEQ2F44Sowr1MI5UNhAuJAnsaxMJ7O+voSyWMepKTZT0KXkxBi+bcX5J3u6YHmohLHa0GA41cNcbESOl/0zR7iwiu3xKOovop1xbjetYEFbYPidwK5zm+IFH79mooz4t1/ZBsRGm1PTcd0w19cMK/Dv24dcClwQBg7rxruxA9+1krgIZZicELFiXZwvzynJ3Cb/bOYulORnd48DujABkqlB+SrpErp6Zw8K7IuMBddOT2nVR8rAK4dyw8cIIx85DIdOBvPiFM/p3hisGrlZEG+p1a/5ZOc59wNYfryjDuKUihSz0y9kETfQaHcszIPgV9rwN+Ddo4BvMVPlAlmA/qsfvY/BPjWssfGGE9YygdQOyjssyAXBhN+xcfyaDnOtm7oFGDdxnFuB66NSsPqbOVl/NC0di7OJdmMNGXIXa6ItJPBmyoWOKPeXepz45PTS2QO4rmMByDcrViSPPPKSr4Y2QbEZtW/dAELeM2JA3w3ZXbJRNP7hbFwnrar4+LBL78/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(6666004)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(54906003)(2906002)(4744005)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVJRa0ito6gYx+pqxxttkC0oOVguPwViDw6P3+7mZlMd0L60zvmI0jLBjP5k?=
 =?us-ascii?Q?+CFuGQSY9BeUpVKcaaU/c9z7XovBqCJ6Nd0Io4zByLyREd8bheZxnfR3/Sy5?=
 =?us-ascii?Q?amtFFNgz+Ve177XNMAWWydRdnOQfCrErVFyjwj+JCbqDy4sARnBGMn9S1C1i?=
 =?us-ascii?Q?v+ojtj7fz2qaK4Ve1ayv9hbG8yYtNWnNrNiQij3yJttwPVOJ5NqRXgLtR6hg?=
 =?us-ascii?Q?upEgRJmFW4xNTnHb0mcIpXDYQa7GZchgla04aH6Lt6w3/Lk92djrgUs6IoOq?=
 =?us-ascii?Q?GrzjcAUmdP4wX2j0+9PFUI8WAr6O8+b8BuVzkuw74SUPqHAiQKLRJ0PYMdJF?=
 =?us-ascii?Q?P/C2FRxC5ZHSeahsyoOk3v8xwGWj/ROxhsOuVp8jIOAYnMUkJgaFeiEL2A73?=
 =?us-ascii?Q?hCDZmMETm97hpRCEuDTaFcYXwNGb4m9RAL8e9OD185OD6GCp0/SOQsQINbyL?=
 =?us-ascii?Q?C8N6QTG81XkJ1mGN0b6odIsm7owGqrAi2mfSEziDOjLMO2KrfuxNYdv7G83c?=
 =?us-ascii?Q?/64nOyJt1Fp55NXme1k/CAD/WD9QK38xwLVQuCoNkEsgdbm7H7LQ3x615+3y?=
 =?us-ascii?Q?k8r3FOkq6UzFi2zzW+VK6jHtrJDqkAA6iBftdINVass4otx54pJVXvOxPdfy?=
 =?us-ascii?Q?fI13g9pYZojq//QrNWu6iRDYhSUsY4RgJjk/8gCdkzfxT0TXpZ4qfYggc1hh?=
 =?us-ascii?Q?s2Um63x/N/K4kwHmtS/lmhtKRuGApl2MJKCwZcz8uBpFS2B8bgFRJF0ZZHtd?=
 =?us-ascii?Q?O9piqSkRvNcoP0zcH6T7dzKcjyI2Qnadd34416bcu7bnPcAdXRQ3riRsbVIz?=
 =?us-ascii?Q?bIjzq9eoFY6r5m7E6O0Q/TV/U32EcX2bneGHK/cQUYbz1+/MPz3Qh3rk5o6l?=
 =?us-ascii?Q?24AS/FypXHJYPOfTNLj1jFhXzvfHnewYuoE1PaBl/HvUkqn+V6VCTYdjNdvf?=
 =?us-ascii?Q?FqMmBEPNEAOq5X/p4r6FvoA9ROagEZbXPEWZGGkiIAqNOraeEUBqEXXHpExB?=
 =?us-ascii?Q?0IrzfSBKW+x/q4mmgJ/MoB23FKkG3uF9llrF+Dj65K9pJJDi7mYw4BdzeJ77?=
 =?us-ascii?Q?lNfc+finPmIazkO3gzVYbEmXKUxBsNOfa22yO2ZdF799tHrDUx8dxIyTvbTa?=
 =?us-ascii?Q?q6LzAU8ONgFAcSwL/NPVHFKtprTPVPj0L8fuPL2CCDviRgFwwoTuRPDvZmuk?=
 =?us-ascii?Q?B/edqfLgX4neQNibG6Fm4KcNI+XQwtLqZmXyFNrnE6X28vWFzE/9zWBG/Wal?=
 =?us-ascii?Q?VbSeSLq4+b7XgftpyxQPPgGDfpBonwaS7WilN6fCoZUJbrfjvSVuWC9ZuzEO?=
 =?us-ascii?Q?06OQQTMzNVeWm5SHVeMqf2Z2NNmeMnKjz77QeQguQ1bq+F0VWEbgifh0y4O5?=
 =?us-ascii?Q?ZuuMd69KzyLBPOi9N9rcUG9KTdmbpyBXxPgPf9fZ3eBjk3oc3Gs4jaFCM3rQ?=
 =?us-ascii?Q?slWmJAWPwTw1TZ44S6DblsGEhQfLyofAhznTDddZg+xbdsr5/8Gg//iSkV3v?=
 =?us-ascii?Q?B3FEA+eVMDQZ+v5lhRi0VLwg2elZz/6mLZSIMZYdx0r/2U7ECaabnZOC+bAj?=
 =?us-ascii?Q?iqJZLnH8b3OtoPm+NtyqktbfGeBZnBBdmhe4oVs9rKO1IhPDyeZUxPurdfrm?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iBFIpyX72C0fecrmnGMdMAn9d/cSJNMUz1rgUlazJqrCWZJngaNdkhm9Y81v2/ku/rHH0hLj/WgbH4RU9kLvvOb6SmRDaYV6y3SeBqv+J1031aKnySG0Upyw6wombXu+jLU15+f6kIOaIEP/vd4iRKmUX8xJy0+KmXAbmC9I2y/hTVoWiDNWtQ86NwdS7WhzwB3Vii5+jEgprYatMh48hDqUSraIgdNstwMru6e0EG56bo0FvLzAB8Y+ysGgepjJDdDLQh8OpWMQH+8oFOZtMuqqmM6gWdTOpqUtkyGJx/jhxqfWn1g2XDvb3mySVnc1omm0jiP3Bqe6e7y5k82Acm8VA7ZsHWtGQwvHBt2DyFDA44yZ+inI4AdZSaCdkCpQoCfrKBbNPIZkuAl85UoapFDw6ynK4gn/MyzLUv4ja9eS+gAJ2mYVsBPfeuZzGDLNsWQvF6+m2HbSRth8d9bJ+/xKS0itcWHzAqaiPH5lKGhsBo3Gl519cCEervcPqzJf71bn/rnDJ8rxMVgx54e7KhRUPnhVq5O/XzRe/10Y9L7deeb3y8fdTVvHBOvJl3p/74aIdTug83a6sjgnBoENqodiSaSk1dqPismTvnemDztI252a4n8NGYFWufbWiLMrojpmRs/lhB7DR0nHbf0/T9EDP1j7tokvvt3gbrVB/dHgHU//fGLCFy8TdxBM5j7MJkOhzPzmozj9PtoL+jDTxUcQAOIdky5PoWOCuJmIWTkhxPgadbHWkAq+xbOQY7pOxcuioC/DrdbjJ1XS1ze3bOBzQc3mgqzfWx3E8F89NHZARd9xNykwipuLmQUMh8TbHXxNXS9dnk9eWKYUhIxe3zKLl3rzg/vCe63Hrh38+ao6ioy31pZK6VcrQhCrAgGyMPba54FMCHPOcJ90lpyjDA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7048e49-2387-4cfe-68aa-08db57b0034f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:08.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLzxDBgytF2pxu6pEu7v2yaCuLtmr/IAn6frAoGIqdR0RrsGXhmhSkSm6Vbs6EQJMSM2uAUSNE5vqPQoV73Uew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-GUID: 6RaQFkGPGvNa87k0dyIPuXTp7jIgsqPz
X-Proofpoint-ORIG-GUID: 6RaQFkGPGvNa87k0dyIPuXTp7jIgsqPz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 204d7941a39e..ed92abf4c1fb 100644
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

