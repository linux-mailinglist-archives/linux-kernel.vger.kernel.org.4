Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2F7088A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjERTwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjERTwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:52:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C734E44
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:52:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JDTm018335;
        Thu, 18 May 2023 14:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0gyCDIKC93BPQ76stKJ0o4Op1QUgFXcRfpAud8qjgE4=;
 b=lnva68kSo21o0aH1JC4h9OJcPhe4YEmXRna2qQc17X2kH+uZJ2I+9MBFASoysp4nmZmr
 sXd/qcH4NJMp9WglDrDdmEz8lAxZ+PY71XW5f8X29s9MZjbVchc8qWECT82HDkGzfuXa
 orUXMJp7V6sMykGM2eY7sg/iikJoPzfl3Wr0IZH9g3YFNvB+k/Kp9YoWjGKFeQdfTOmi
 jlOINMd67+OYwPD/OQuh7ilm7KPjqVs37EQ9kpLBSyIIQZUWAyBkjAftbalXGMtmYKWO
 9VvNu/USi5zSyt8Iky3hHlyyhtNgkceDLRdvx+1Gp5cix+uT/iB0hyt5lP2qOxI/TBmq jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j2vq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IEXVLW036331;
        Thu, 18 May 2023 14:57:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm03w47f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG/qlrq12kr7tuLTEsnLYA5lDsQdb/2xIWtjc7PV5BvtHapUAUuULiE/zgsSfpK6uqKwZ5UWq6p8W08LIlBrNzmBeezNq1e9EdDPHxzya5zYl3lXwqJe4NvawaOpGs4y16MpYJ/CZx4vlxtxANraTqvCHFrn401xx7ej6gV+1gjGl0MPTLfkUda3hbP4Kd11Sj9zbZp4hQwfzsspjXm9IrqEUfIkiKwjhdky5RHbjieqCV7qDhjaq8lvPBSAseF3rfptHjy+o968rf7pURiYqsMhKPI/jfzNLczz0hAQUs+C2vkhGB4+LJAslr8592cQApQ0qTZdE0viQcr6n0CcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gyCDIKC93BPQ76stKJ0o4Op1QUgFXcRfpAud8qjgE4=;
 b=SDU71bLJpLY9Ai8VL0KbUu3FpnZ3qBpNEjmm4j9YdaZO3iJ/QzMIHGiovEkPYARDZQUv+GsAD6O+lM1InQRLy4NpBoqs8sq/JPX6CJezmCvX4OQnEiIOkzVVfk4hMAKcejAdhAxUVZAInjn5Hg0HRDStLT46K/vO9rb97Rs5LVa1Jz/rYPWeXp+fG5/Vkwjq3MQogBbXbiGJqxuKAiLsoKm6JYwm4CEi9OXQIDGDcYZfyW6XK8j4M7iKhafvU+WonZkGuLl0GmzNPeL8yruyJBhXSQrQYdzXNhP5gPdSkQlPtU/MCHUV9WKp8mlwB3eHQqvli8hs/Tm9sgkV/1S9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gyCDIKC93BPQ76stKJ0o4Op1QUgFXcRfpAud8qjgE4=;
 b=Hc38volSE3m+xSa2G8uxF+5yONa9GjHd/qOXYS8WMssbR9gnPVnlEPRdBCJuheRrQBGD4xHOCz/x8liv/AilIQx58deNK8pXCNLTCNDCEP7RskYg7xgePTAJvOtRPyB1E9/q5u9wP4TXhRgEVBD8dGpBM9BFaA0kzv/8mSTiQtg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:58 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 28/35] maple_tree: Add mas_next_range() and mas_find_range() interfaces
Date:   Thu, 18 May 2023 10:55:37 -0400
Message-Id: <20230518145544.1722059-29-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::31) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: af7d2979-f9dd-41ef-0f9e-08db57b02102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzCI15xzlLLUNsHzoZ0bXkP7Ip4oe42g9nbJ+4i49BTxzA/O1mWAJ/P9UUHckOigBGAtSYbNT2ID22FX3oPyNAZ1Oa3k535JYQLgQoP36JG+dPRiQ67UOLbHZD3yz1cf4zfsyAGrVwAOatPgY3FhpnXbNM47na8boT3DKNP2weowJUpqOtsUs8QM0Cy4RjyzOMowMFELumJOG8+d/4ajVXSp+tPuUZp1D/4iW5/eUrqLGoNBmdCYEPp+ow7Ha2DDip3G7bGWiyXaM0lp1V0vuY1tor9N/V/v4kwvnYYJRL/ndF/YuFk10YfmxS9C1/Fl3woXzDDY0p121hGwj+Bb70JC06kbzekuPa8s9mxIHK1sXxtV0D5vdE1OpRgqoVEbfORZkVts1cqbXFXPHhaZX4RW1wUIZC+I02kj9X+CgisFj4miNxhM9b/kKVLvwoJjon44a5f3KfJsxmcwc2NX5oB+0whb8zOFuPMC+zXs5urXXCh693RZ7tzPzl/XhcKk3xZmv0Tq71mTYtT3JOMNdXKCW84DTmRwuI8b6mLs23ZpC1x5qZlBTVdCABxZou/Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(107886003)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q8iw9Ka/PnVEh31if7PG0pmilDgQb97az3is4ylGhJ40dENa43CCER1GPobE?=
 =?us-ascii?Q?CiW9T+4K65GNyNYlXwISDKjdSC2M/D/Ei9299DFS/rS9uPrfZwZKFD+7Crxk?=
 =?us-ascii?Q?yEFFVCPx91gWRf38Zdd5BkuY26BieSWonVAKTxDm3CN4Mhgr704gS/kPMOR2?=
 =?us-ascii?Q?ehxVazv2HmgrxvX2rb6hzGxZ1A0j6h8pGKxOV2PDISzhTTcbOvr6wme+uf5C?=
 =?us-ascii?Q?athXfgHyPjaLzJd8FTL028apOHVLCfT44t7ehwpzlZ9gdOiISu9igef0FrVw?=
 =?us-ascii?Q?JmM4Vi0f0DWXkoC7ZUtZD/ypSTRvJ3tBCrf+o359uCkZpLnJnt3l6z/HGwzk?=
 =?us-ascii?Q?TjnBON1LMgRRcGO2dbsVW8HszYoiQlGgT1CpnMbDNU0Tva5ID7hq+bWUVWRR?=
 =?us-ascii?Q?geSMWJa64XU7mmfvhgVc6ErpFSKNzMw81M7FOvIt3S7euEx0grO4QB32sKDZ?=
 =?us-ascii?Q?LSdqT49yySINPOduWRDeDqyLzZokWkglyl2CoBfuHOSZXUJiir8vglliY8UF?=
 =?us-ascii?Q?IUTmfGcdALaVIOgXzSYeY7CpwFwlbf3LwQsAmVKhXBVZht0Yvr7WFnlEmuvH?=
 =?us-ascii?Q?oq9QQwfLNVE5VMtuV+y+cL6/sylEtDZFFakLo/+icyn8LjNf8tL0YvKivYm7?=
 =?us-ascii?Q?kHYGrXIbACEDTByEBwwJznOiMoyi57v1svYWaaBXattVm1V7tPX7qN1I/c6B?=
 =?us-ascii?Q?nZWAp2C99XdphOBoVerR6LGS02IaCwHwBRk5oe1+84xEf9u24ukIRJMoBDbH?=
 =?us-ascii?Q?GAN0Gq/1tahsk/62TV5q73JFybWQTEkFM0zLunMS3ORt+26A0mAAL/lOQsi8?=
 =?us-ascii?Q?UnV4f/lZWXGbtcsG4g4Rr78NFdNkwqDmMVLpxniz9YYCLr+o9Hv3+TzI/7U/?=
 =?us-ascii?Q?2aH5F9zNLaOC4nWJcmv0GYxGvQn4nIbiudlQyP/yozfN6ls9YD77swVE35tz?=
 =?us-ascii?Q?YCjR+o9ZRP6fM4vgvEq8JD3TOLNfZ2ycuCiRP7fHW86mVrxbRdMNk/Id8Hlx?=
 =?us-ascii?Q?EqJtVPRkQvFHE5BmLuNOECVjMGAkXZNtnY3pQK70lKw+fxHw45hJ2Oavtqks?=
 =?us-ascii?Q?TB0k998RL4IKpYh422do5IUppLucfB01LuZ8F9YZ7b+o7b0BkbMo58oDrRFd?=
 =?us-ascii?Q?yFlhX4tWJQX4yB2JtDn30K0esqowLxi3FLzNFtsACzM7z9pTkfSiGtaj1lUt?=
 =?us-ascii?Q?/LvzbamCAVUde00woJ+7bmfzq/IixV29P/Cf6EiKlQhz49LtWw0Zsbx9kkXf?=
 =?us-ascii?Q?8+ySjfTQQVKMcWLJVKwJ3Ect/GSvAFsign48RPKyWS/rxHyA0yd1hKZYUsTJ?=
 =?us-ascii?Q?K20eOxXv0tLEQQcE2PVjtBxjhFm3jZQOIXIZstjdH497Wxj0FEP9nQRMAggf?=
 =?us-ascii?Q?N6D4SKr5NYqMvQMW16EqyX8DFzwLPae9AmFk45fR5aa9YZF+Z9ue6d1+irEg?=
 =?us-ascii?Q?uxf2z9EkNCiB9aWyLQV/nL1OKZ8WM14h353yt2dU7dYc70zh2hABMNDCIbck?=
 =?us-ascii?Q?MwIpRjPKZhL5spilMbZrvdB2C4olt4L95clDDUijQ9sxNUmVGwhlk0qT13RN?=
 =?us-ascii?Q?01NjhmNktofANN/P7BAK3Ut625tooOG1BqHJ4PTq6EWhra8Xdq+pC4vI9Mpa?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fQL3GSMfXf+ULnGzcaUIBOU72maZ+L4eetJiHDNOx3V8DjbLvd+YC6XUCSB8XHJQRbEPPcob6qU1E6XuRYPfvJCNFZAdIKls58jH1ZSLw0DOLJy+42SB9j72mftVSErb6aagGqzuLYeupIHv2E7wSMgCK/hOh72T+Ffm7NN5cLGXeFRcQK2H0jIWNrv5xDZwH/MUsM99yku+xz+Cb0c3nznhip9bjL026c0ajxxFzmYo5xBTdx5v2tdjCtrHp7EY323gc+EiWmA/APELA+N89gp+7TLtadu1dQXXiJEWBwMTyUZyEIMN0swBM4sOR7cIa0B9XEL5Rjh2A1XfuljHdo8NaygPzeNQ4QLXjVbKZFA1P5+1UqjW/R7UfOA6+9V0MgifTP4rS+MH9jaAX6Tj34wWxOPlvaahob4WLjSBg6c9IdxdQP8kemiCijn+jLHp6AXueyAAcDDgkbPPOjCmlNQ/hLIRsiltjCFT5hwmU0MwK3vA4gMC0SD5vdNcZqhmzEWYJf/pPa1d3HeiAVxAFelTJjwI8rqVqvKEFUiyUpwcfO1qywNnKhEoSN0SSHiBp/l8fQYsMwLIOJGZrGtVvW6RpwAQwRh0shbcSlte0udOdYdARbbwVqjnb04sg8Bj1Fj7T2TLn3ZhExh7t6LlkgP15oFa0fVaMbVkl4XcYOPBeR9j4C4cnrhK1LqVAEJxDi35bkLXIramew8yjIPznU/ULx+AspxVOCWELQJRSr9NIjmgUZ9chCbJ47B8jybJTo03tnQlxNBXrgJSp1Nc49QhW/riIkGtFdG/xhCyH/bH02kZxQSQH/xsYtLOrvoBZJRDER8SnqZQCdSz7yusl+vzjUWYrPjStS87+NuwHFCXyi06HJU5ADSKIC2/ZVVBmRvKmZ2Oue9o2QsLYR9B2w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7d2979-f9dd-41ef-0f9e-08db57b02102
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:58.4505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u59zC5DxlY6DI7lDhruYJlarOksT2kBpmwcrpMrJ5kTX93E77hLBH4bmfAeMGE8yRbO8HCojeAhP2F9VSKnuDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: zRrZvx-ozfeRgEKek_FlX8EficT-XQxg
X-Proofpoint-ORIG-GUID: zRrZvx-ozfeRgEKek_FlX8EficT-XQxg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 include/linux/maple_tree.h |   3 +-
 lib/maple_tree.c           | 172 ++++++++++++++++++++++++++-----------
 2 files changed, 124 insertions(+), 51 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index ed92abf4c1fb..9d040043858a 100644
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
@@ -528,7 +530,6 @@ static inline void mas_reset(struct ma_state *mas)
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
 
-
 /**
  * mas_set_range() - Set up Maple Tree operation state for a different index.
  * @mas: Maple Tree operation state.
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 860f82e16166..b5df37be7a15 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4792,13 +4792,10 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
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
@@ -6031,49 +6065,41 @@ void mas_pause(struct ma_state *mas)
 EXPORT_SYMBOL_GPL(mas_pause);
 
 /**
- * mas_find() - On the first call, find the entry at or after mas->index up to
- * %max.  Otherwise, find the entry after mas->index.
+ * mas_find_setup() - Internal function to set up mas_find*().
  * @mas: The maple state
- * @max: The maximum value to check.
- *
- * Must hold rcu_read_lock or the write lock.
- * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * @max: The maximum index
+ * @entry: Pointer to the entry
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
 
@@ -6081,23 +6107,69 @@ void *mas_find(struct ma_state *mas, unsigned long max)
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
+		return entry;
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

