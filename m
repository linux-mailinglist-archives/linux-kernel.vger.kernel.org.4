Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FECE700EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbjELSWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbjELSWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:22:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C346BD049
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:41 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4AGc017810;
        Fri, 12 May 2023 18:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=fS3QzFuLOtxJjXjPIV+nCtOmoBdMiTTxr1dJoGyuKyc=;
 b=VY3D3WeTDdXZZO9mFtcbkrStY+CK75PL6OiICgyPnrc/E02PzlLOApRb1FctgA1yBuXM
 ZB6fqFnNTPtYohxYnIA2ZYtPJsLZRuOFjOTMNBimTJ92KfKeLYbPsMdgWmiyCi66o/gG
 2s/WbeCMiKroz11arnpqlJ+AFqak3todu9SlVRgISygp8K4le0D05WohgBmrbfAlVdxN
 JR0YpFzMyKUPKeLstZMptCgqKkJ0b1pLBWDzgBF5TfjbEH+m/96Bm15pqUQIoGeaVFpR
 0Bx7wxpzUY+s65X+Wdse/JgnOxYaDn2IcPhSVsxs6r6/dNqifkotOhG1U96j+KriaSOZ 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qhje7j3kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CGbZDR011613;
        Fri, 12 May 2023 18:21:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8156ymp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfGrjmG16/bprGRCZmPgwyhfyp3GYMJJIVBpzSn5TbUPFc9NRNHC6vofaMNM+2HJkFzbIqq8iOisB+rS71qcYAFdj5zaDLhp6CaLSJKaYMv8oU1Lw5r+pNf0apIy54UG+QZbXAl2HA065DhP3O5uSg4GPX0BEOGyC3I42gR7VgITZxZUHjad0XEP4GZNdGtEoxxRIhA256F4mfucexLQrSLGn0yRib5WA1rSCjucF+DcAeSy0Z8BbuzYr1D4gVp2bGfUJ6GaJ7ljtNfW2Pox5Q2iApNJ3bvT0+1pz3Gao1GJsl63yfiTB4rEeAbw11Enrs1jl/nmiaYg26H59plkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS3QzFuLOtxJjXjPIV+nCtOmoBdMiTTxr1dJoGyuKyc=;
 b=m/Br/aL9RmqOYWKL+2sM7F0I6ChQCuN2M1dvR3U2fAt8Hmzq5qdoNwKFzonu12j39XRXKLA5ej/nw/ndV0c9UJtIHUupDWuUBdBc4Kz/8eiYnC4WlgYwrAiQ6XX/JkPot56fYtNV23zfl64R2793hGO2xOmkZu+8NE9CDsoYzgyBoYe5qT6HB7XJ90UGte2WDPkXE1VdDGsbDwjD4CiNIvd7X8JPXSKOk59RIXh/hcU0UyiF6CCtCEfQAmh8V3bLU4vAq5ljkTpIrhmZv3IhIgkm1h8vuciWQ8o26aJkVNr6fyquDbYF/HF5+3JBuKMqFEjfQvbKaTeQYAK1BWyEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS3QzFuLOtxJjXjPIV+nCtOmoBdMiTTxr1dJoGyuKyc=;
 b=hHlZVYFfx0+sIXLH9ZTM1XrYDUkH90YyYxzKwwsVjuryQaNDnZ1tW4Y7GgAHcEfGhxOvqjZ75N5N2WyeC2yfZYo4Yjr5kwhWMj9plAcHDnMWqs6XcTrCrnay315AU8+Oc1wyplvknrw//uVVcUgfiJ6fY/BkLXYuxK9aPt3FM2w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:24 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 13/35] maple_tree: Use MAS_WR_BUG_ON() in mas_store_prealloc()
Date:   Fri, 12 May 2023 14:20:14 -0400
Message-Id: <20230512182036.359030-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 360ee9d5-b4e6-4a8f-e74b-08db5315b1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCwpBMisa1FhyJNoyry+5ICG4eRhPo+7iCKVywVCVPmhY/XOGiyJ2+IV7XV6RKXG/Xp9/kNGltgNzdWk06hQ3QoSwPnrOC7Vb/ihHPrjSLpxMyPEENifkTShmXxzzJXmHJ6qX+ppoTrq1VkN3lbmiI10VLuEgVuu+6D85QvQ2w/qgYfzpwqsa6aqYKlVeM2DHA7j52i2ubh0bdDdpPORuzglXPbXBs2fe0UJ2/X1Orf/MMGm8bgORIP3+yqMTZzL67aFZHmKYDQEyhLlzcUDbeR+p3x0zcMrQ84/0gEqD7EF16SRVoolEJ5UbSxQvv3jn9mhsJ+EBJNfF5BARyfclKDBigQ+ZJ6zdynO+jrIitM929pPjLuTDoVsiHbxbh0QSF0NKDUYGjVxnruoNhuWkN/rX7WhjkD/twUo638fOy0hPojNQLOaTCSRnsrGiznOtvLYdUBjN0SvG6o91FiOPM5w0If1krd2G74lPACfp63yyKk0hV5ssTYjvZpiBEzZraPvu3ItBI8zrvtuEp2yTJuvJ+jpzJVAi49/Ln++YbtRRjjpJV4EnmBOIQsvL9Ot
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(4744005)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(1076003)(86362001)(6666004)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UKGR4SVQESkB6ZyEpvD1u0s+5ODpiuO8U7g0a7jbOwJEFiaLY05m4qHoliZY?=
 =?us-ascii?Q?27xP5KH3Ip+91g/lgp49Qwx891pnQJ7XxLyB85DsASargVl0Hlwr228hRAZg?=
 =?us-ascii?Q?D8QAbNF7nGA/qqDrKmfbYdgeGWMBBICcrX8Cg4CT05YAgT3yyoElpK9TmS/4?=
 =?us-ascii?Q?N/DzJHIizJra5T6WMjbbHZyqJ18QAteTArfJZ6ysBlppqHLBnBvCmQdCKEw5?=
 =?us-ascii?Q?t0L5MGj6dCFOUtJ+ElXBuNsoTXkuUO4CdioS/2zR/zKLaZafYt3O9drATLoi?=
 =?us-ascii?Q?X9jWM+oy73mdee3cQ94ZOaDweTwrqW+YwFxVsAkcdeYJZgPQION+Jzu4Baju?=
 =?us-ascii?Q?zCLiycPlMz4L8K0aDmLGbVv+NdJSOcvzp7b2Lpul4klelNloEJbyrdRqu6sy?=
 =?us-ascii?Q?iAlsgcR41/f9Z6fgf5P9mRVsJTc12aBMQLGVYHrPdhH3mzst79O3SYtq/KXQ?=
 =?us-ascii?Q?yyZyZRvl4t2YGsSeX86wg1FoRyFXtN9Pk3gRJGrRX3fGsSocyRkUesTpBPVJ?=
 =?us-ascii?Q?t/hyo8f3Vc3y+uRkOW028i1rzNsMKPAi3MLDu+LFw0lPAXDuj9D2BGRBlM6t?=
 =?us-ascii?Q?5jg09lop8ug3NU80OD6woZqSifjD4EjZUkwOeuIgvYbrv0j36ebfBGUtSIzY?=
 =?us-ascii?Q?GLsNKMDNmQrWm+65dxWmW+TQEIVRFBbCpyp0B1GEOUHvjmhOgR51lXY7RnkX?=
 =?us-ascii?Q?4/EhfDf+3jMngzxCXLBpsMxjMqTSZbXZZR67G+2rJs25b6v2bwOdlBIgxaqD?=
 =?us-ascii?Q?hdnnuP3QLmq190JURJt/HA1VZBRujHHob1ClHT9cn9n1EkXZoGxUsH7aO/+U?=
 =?us-ascii?Q?2aFHg+x6M4au61+J2qOrbFRV+fo2YdVDYU84vhRv4cWUkTOIFXgiXySrxxxg?=
 =?us-ascii?Q?KVdxyu6M2/db80mT8DMu1jQyNf3wE42evI9yoLLezrCPCc7ptFtxWHoPKsk9?=
 =?us-ascii?Q?XFAEV1mQ85Qdkbx8kHxCfKSVQON1N4o++yCWj7c3GbT1rTKaIfvGhGpQf4HF?=
 =?us-ascii?Q?qkw61kaohIV/xi4qUKhjRKs1l20ox7TXOog0wAmJW4BLseoEW2HObA3aMSX5?=
 =?us-ascii?Q?1K81LswVZDHaB3IHFOxbYHk/kDsX6eFg2kf6q08Pqemn7Xfw/3s5EW5GaGeR?=
 =?us-ascii?Q?rSHTe2dxhmT/bBCPn1AzQKFhvtk1bNnx1Q9HNJZqcr8mQ0cjLEGBXFpBzcaT?=
 =?us-ascii?Q?bXMgqpn93FvrT42PB6ftAz2ja5KhPW23huMbELc28RRsGYhYIKODh5pNomvV?=
 =?us-ascii?Q?Ya14jMSrfSWPO527p4+W1pvUZVqVD2la0DLz6Txz2F+GOnxYLqmM292qR1vZ?=
 =?us-ascii?Q?gs+eXpGWvi2YMQxd9n5ow2bzfy8mzZrwnF0PKPdewBvtzLmLmmDC3VW0S84b?=
 =?us-ascii?Q?2BBQWqnraTJttJkdWYLe3+toejEWAoRu/TaE55JRnszDoyazRYvpFEf6iU09?=
 =?us-ascii?Q?s+Cjm0/8/uP7bNGt2+ArC0TSSdqNPt2MLdOf+HLx1WTiuBEcPISRT+4S2X3g?=
 =?us-ascii?Q?2XIdgCtyheJHkbGEDCo5+Rxas9OupUOOluWsUV2ISISZxkGhTTeot5d4Stj+?=
 =?us-ascii?Q?eiYSOFldg4vpQXLsrFQrjcuDrp9q6bKZteqIslPYH/V5P/Ro3McvVxibZQ0M?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1ovN8yw0bOqBcoXMMgd7PPfeDbhhquCEGXZcMJDSTpznw5/mcrq4DaQNVrG1Mm/wUelwlmkHP/UcgBJYLkzDhlxTNFCKqmdgI9DZudhcJqil60WzizO4WPMR0Qyaj8dDfe5mRyCvaBrZ4u6Pjou+5PG7Vo1prCA3/IWBIjhjOXpkdE/JgJx4eQ97PeluXWz0Cv5rh2smjr4JiSa+R4qwZYG1+t+cbVvD5JVnvV8B6HjsMD3Uo+RMUFea94PqkRAWADeAEeMGnoUytJnhMWg8yQFXxnRwTxjX5yZwSE2IQRaoqksDU/sIqe/PL3jZp8AMfkW7nBUopta5rZKxJS6ZGuwDQMrxoCzWyZ+uVFKMZzX1qqEyDQeHqByiLsZrXBsWKQutPXTj/grMs0mh09CDNTg/8kPX+znBdik/E6g5UapeTpItVUH1OuDx8uAHRumGDJ0DvlEFaY1uUc9pcx6Dm8kll9sQ9Wj0N9ttzMPIgMACBTNFa+pqrdGTkyH8lsfAuMr/CWq7WSNngMRh9+hiueC9eyhSkrYb/g6L5wg6+u3czKU10ILgPw27NiJTkrN+VNS+eF/hpYZQG31zNQj2OfE47SRNOMXT8Yov4WtmdXmW/ST7JrGkeJ2QRl39Xgbwx3Aw2SB1OEzeHcIqynyuxmwAfU9DthMeCdWow3drhM89xkyFVLh7cY0WH4rNcyb/mN3pcmNNce9Vu92/QtwLcy9P3oGYlZQ9WHCFIZp4x5NgUuOn9wlzjxWgF8z04eCtMtkTQCeImxCWBXcBm+G9/a0tRrhmUosvc1RHvBp1BAP6kApc/EvmNQ5pwH0WnSvuphOq3DLxMEZXgVK9VdOqgJ5slzFGroJRYomOYeuHdtjOPznHjGHxT3mSJjt/aWDuzV3HXqclus0M8uyx+hwJJQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360ee9d5-b4e6-4a8f-e74b-08db5315b1e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:24.8380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bad98YVxUI5KKslH2jVqzYMrYvz4qkw0jRTa1nYhnFy+0shNXQ/43d01dVIZNvJAgMc+bp9RPx90fWfvZJoMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-ORIG-GUID: J0Ehsb18eLwHJv3mBAP6oqTisqhiT0Ef
X-Proofpoint-GUID: J0Ehsb18eLwHJv3mBAP6oqTisqhiT0Ef
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_store_prealloc() should never fail, but if it does due to internal
tree issues then get as much debug information as possible prior to
crashing the kernel.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 824967872d426..d5ccf7bcf3b5d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5761,7 +5761,7 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 	mas_wr_store_setup(&wr_mas);
 	trace_ma_write(__func__, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
-	BUG_ON(mas_is_err(mas));
+	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
 	mas_destroy(mas);
 }
 EXPORT_SYMBOL_GPL(mas_store_prealloc);
-- 
2.39.2

