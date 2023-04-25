Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCDD6EE3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjDYONM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjDYONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:13:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679F4168C5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:12:10 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDibKb005234;
        Tue, 25 Apr 2023 14:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=LyTnByyQ/uRkrpAzi9MfH8841LKGO6dtdk4jEIaJp30=;
 b=dJROeIB9zEwpcqOk8ZWrHOkqQMYlacwf4RQZnk91vk6AEojOaeQPzy6e/A/PrCdYWwIU
 QGgBC8dULRJe5C2rICix66m1gHl9fTpBci4lyhik9cyINOQ1yXLnQoe0xVeGaW57q2HL
 mtgecbWahLGxBQ1Gq1W4Vii9BYYY3E087Hj0viVGDtcpNVOQ8f2qqPZFt0crswOKN7hc
 nUfk89y9DSwYV9eSNoxFSJUrVVgecBGVdXcKWtz0ZMIx6Ojkz/6A6TWmNjN7+kftGq9f
 WRv6pjX9ZHzjqN4IzDG6fZj6ezCO8i40G5yLcII4H4S8wQVMShVZCEr1tOi/Rn6ZgIf+ Nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbng95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDStKI007334;
        Tue, 25 Apr 2023 14:11:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gdyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDziNX30JiLN685HPPEEwkHilidODjGkOE4oeOdg9pwSzFY0nA7/jndeHnBinxDlDrikOO4B7Pwj/IVltECJ2usvcdt54NNopFk/OMmcJ8P0l11/xYqyGrIE/nzG20yStDo2fb31v75lMvP56T3fo4k+RG8NHSkMpRsb2wl53MtbyzDveGhURo6ZtKNvKQ5RKE51S68PwqS26f3AS5L/rBYNTdEjLmDShKhHTyt7EA31xxlLklLe2HgcNKkBDkPOuSjY6/2GHD9Lft7bo1LUgm4jvbBXmbCMepGOLjsl2fwQV0miVnJLDmgmCaiwAtERO6NrV3+8NudhLGp7O5J3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyTnByyQ/uRkrpAzi9MfH8841LKGO6dtdk4jEIaJp30=;
 b=B6IXxISqxZ4ybdbBqUVp/aIEwnYcXqehItiZC/tygHwDcJ2Wg3YRWQlINgpSony9ouvQiaa40eQGKPeEkNNCnz9G5RVU7V7S+BDoEl9ZLF2kHNSfuW6PaT/WfMfSXTDc6tsOyCBY3orUwTMya5WNRTECm0o6E6q2v3tDbAg7VrDfnfUoTr0Jnjg7z9Y9jA17bnmnh2e+v2CORQzF+zq5G2HArIX9DkkKcwvGyWLJz/wD1YyTgZdAnyhu4xHbtFYqUbevEjgY6BsRiLy+gx0034P+RM0iKBrqpO0cseEv/fgcMgwBMnYgBXkeqt10F2QgSrZSMqItMX+wJptxuT8waQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyTnByyQ/uRkrpAzi9MfH8841LKGO6dtdk4jEIaJp30=;
 b=Xtt3BeI+en/oJjD5wV+h/wyuV6hq4+jQ0usnTG+pTK/+oFB2BLIqaPbxHyaJPN9W3J2z8RZHF0lfQlIKy9EAoc8Yk8oFIJcuGNbu3QKfExS8t40VLcasFR0LH0axB9CMdSqG9WjSiEy4059MSwsFXiqGLyI3yUgLtyK1taCANi4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:05 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 19/34] maple_tree: Add __init and __exit to test module
Date:   Tue, 25 Apr 2023 10:09:40 -0400
Message-Id: <20230425140955.3834476-20-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0343.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aee9f68-77a5-4a96-0645-08db4596e842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axtT1yCiob20CWh74C79FkUmlSrEPhQXDR6355vmmf1d29ClKlrMqtN4mU/Kz3xGtl8Fwo7CmL7SDHE/SBtYTjSf5urNN8ohbdctB/5KG8SnTqBNibPuXoCn31itCfQAFyBSP/vli16vSgI/jcJtf1jtD1Hstih1QruQpD9B4CdZ8cV2/vQ9n6fG34vos9CtSUg8Vi8JCeM7M81QZl98b7TIFVtNj9QudBNg7vtZ6PemNZCuUwuBMjnGEMOJjlL25lFP4P/RI/BjDpzzjO7U9cVcHO1SKSjkWADNJ4u0m7+VRpJtLQtNpQGKRmgVEFLbFv1TJgTyr4clfDQi94CGsobXgpzOnf5Ujcj5r4X62TmgTf5p3jb2Oy15IWDla4RTBzTFXKc8FA1EW/bA7cUJV8khSlbKIGU5rOIUB44oSdvTTZL6Sg8Q1KRq4RIHPBjv3Fbr3wFIJhdC4UoBSe4SH9WhrCJpxa+x1piolQDRsnkOzyyijFvXIF/6GCeHrBzbpZQCnn9pWfWHCIgrNYSekjMs3XZB4BM/a/3dLC7qoVH9fguL+lfSKEtabiplP4Im
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(36756003)(107886003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(40140700001)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(30864003)(38100700002)(8676002)(41300700001)(5660300002)(8936002)(2616005)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQrjJPxs4SqO/cX6ICYlh1bFJijYi6nPGUsrjTP0WgkxW4RwEv88P1KPMlt8?=
 =?us-ascii?Q?S79zozCKrGEg2r8SzJZzGgeb9mJhxcoUOVF9vkd2XHTaqP8m8Y0Dm3OEhR9g?=
 =?us-ascii?Q?VRhs4ld2Csm1pKyFXiVgpxaS4GeMb1E1bhayVgWYNephfRJzTbrno/9+8OR/?=
 =?us-ascii?Q?gKhaKbRQQFdR+ELjDIQEFsipSyGesvQr7D+MWMxUpgmx0OkHCwbhy/SZ71j+?=
 =?us-ascii?Q?h7UeVZOGQlq5wHTxfkC0QLUZivS3k50s8OZByGjF7LtrweP2XoQOPUO5S42I?=
 =?us-ascii?Q?skrdEU6sgJrqkqTu8saHh2gbgfQdkGDZsFyTMK3Mynd0QDVrV3yOa1HB72HB?=
 =?us-ascii?Q?79SxbNJpwGzRycRo6ypeatI4WwNBr98gYGGlNSpowsHwmf4RcStFtmXIiuPZ?=
 =?us-ascii?Q?dsp2wrecjpgIrrPUM3eCeTQYYnR2F+1Z4T4mcQ+TuJY0Aob1endK1U+kBWZ1?=
 =?us-ascii?Q?c38IhS028B5CwwGSwvrKVzKH8tjo5azKL2XkPTp7f0OO37pUv9eu1fL0NVtz?=
 =?us-ascii?Q?uXfGcm7PsuTET3AOtUserENdDikx+sKhPhszFbTx56ccbaM7v73OtuMeashG?=
 =?us-ascii?Q?805DE9NAEP5643zgGaRrjjVexQcva9PRqLp6ex2igkP8cpL/1htl954eCbsj?=
 =?us-ascii?Q?DN5kWz+inoTF8ZxDMNHK1iHY8YTD2WZh9ruaDssMBM2If+HOxkwgIAK9Cs1w?=
 =?us-ascii?Q?c2QnMU0ypZ/hnxMvYXWUeOz9sxeibORsp8lmnjkP3W+Rzlmdd+UFsPoca7JL?=
 =?us-ascii?Q?CaYNy1oI/xDac1mMNeIgPaeH97sapzZQbvXdF66Z+tiwoOLDbtqnfeqUBoxP?=
 =?us-ascii?Q?w7c3F2LpDvzjGk7/DNa3MQnEjOJQhmgKZhLr7rHJS8UdT+ybVfRcKHxek8Rl?=
 =?us-ascii?Q?qSHY1oWseiqsozz2JdQpXN7mzT6nYZHxShcVJHRxouYHaFOmadv1mw1mlJEF?=
 =?us-ascii?Q?7T8xjsD4OimrXJD++lpJz7O2vm8dju9P1Oy71Mvhx3QkN7QVN3z6ph/gLmhx?=
 =?us-ascii?Q?8lYpIdBjfrmZj8WvJmudEmt034V8+hm8vE4ku29d1+BHhMg1jUcewNu9qoRr?=
 =?us-ascii?Q?d8uYlXy56N30fglVoEJvgK2llzkD4L566DboCO4s7cLo54kcQ3qd3TB0Fddg?=
 =?us-ascii?Q?LG3xIutznPzdSf0XrkJLGljIW7Lu0NdD1McQLVW1FdVwr6/VossVJxo+IegI?=
 =?us-ascii?Q?a5tYDEaa2gCzthi26vCH5q0OWWH+x1veX4Hn8e2AUX3wUwTSZhe+I2x33ng0?=
 =?us-ascii?Q?lEtzb7MMcYr890X539BZZwaSnJ8f2lziWOkvb30O+/Fq0ugbnpe8h/xswlv3?=
 =?us-ascii?Q?9kPAxxwaL1J8NXn37m25mdjrJgOSgH6XR3oDkpIUbiu/A4EBTfSX/Ppuckbj?=
 =?us-ascii?Q?1g614VRqPEWSYhtkMWvRROTmaHj3hxqX3qVeKbjoKNuqIODNEcufGHY+GwhR?=
 =?us-ascii?Q?xHb/+jCdtCZMBOl0dV8NssFf+vSycWlrd33zEPoznAZ1YthJxAj0DelH/ULN?=
 =?us-ascii?Q?JUxOJPPusNK6wbiPc67iMC7mQJCCLvFD/U0FmvXW3KWGDd8/8BJIhdf0wzEF?=
 =?us-ascii?Q?GRIFhJMw4Zc6783ltHHFwYahfZt79kAR7Ej0qlLXpq12fuktwkkSomW0zEQs?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: selLX0GmJM76R/PG+X9WjAn1w2gOxgd4rdsOcRaWfsXiLjjJAYtfBP9tjIituiTuswFjW7LDpFdI3FznGqUe1QS/uTA+uSYqAKqlcuatclcqkFlYj5Vx+0ajTb43xf0iOUlmCcQL5WKBw8O5m11LwGvIqpvOTHndVvd5UbuC30LZm29UWGh+I9bi7Uo2Brz8rKZ1umdsYmwkK/TKmF09GDB6bVQFW+88kgyazMaSbLB6GhqPmQtsBFbqcbMod1g+pZywM1L/1pya/YQW0YIz/DoQyQZ3muHGHCLoc4QS5JQTWbWYgTUPPuaL7wN1x1HKfWIfQkCfbhgDE1xrC7KVgLRGLWkGkqJo0f+9qlSrskyzAwJEKcjpwLGQ+aZUFzJNseHKKvCSjYJV8wFngbRRkiilCNiAg9xRohqS0AJsGfT1JR1BfZCXlPHqBl3BXIg4yAKITeN5HKHZpoXU3eGVUJ15xsBEDUUNJ18eeQsDBtX/LLYlRbnVPR7EoLOOKupoZnFJY8XgAePajZUYkqaG8fNgeGnOmzbjHj5J4o3ehA4f08fMoTysDzi/z9dU9fOdiVbucMnf1jFjT6WI5eHliS+OD9TZm+q8ZzY7sbtpVU2Lo3AZhCIqk/9UbyRfGkLiSz8GCBGMk3EOSNTEYhmk6lFzvwSwYi6eiKzaT+ULsFUI1hJ5ObGLqZjlUKTZhrcSNZ4+EmG+O9IkpWURDx4vz3alZ/2ATZGKDkOT2KKHgmmUw5SkHDwEFEEZ3/sngH9DqK50UCR7tmqLtst7TiqQqlW/pWI/AOG6U6v8JhNQa13kafc5BkimYYhzJ4TbFwWi+UP/UbpWwj5Um6PQzCk7pJFMCa+IjztLUoD1ryudt683n4PPDnDzgyFxosQl2mwMWEjDMudlKlL+RfMhhYKlVw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aee9f68-77a5-4a96-0645-08db4596e842
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:04.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1Nn/vMXMaj2i/912FAtFMNBXIYxuMwCFz51YoGRzy7YaJHyYz8POIRFFvp7K9rFOQ3jDRZMRZgnXYHn4RyrUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: Ng9ADVzju73P3iXYLtnBrDhhnUCp0kqU
X-Proofpoint-ORIG-GUID: Ng9ADVzju73P3iXYLtnBrDhhnUCp0kqU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test functions are not needed after the module is removed, so mark
them as such.  Add __exit to the module removal function.  Some other
variables have been marked as const static as well.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c                 | 158 +++++++++++++-------------
 tools/testing/radix-tree/linux/init.h |   1 +
 tools/testing/radix-tree/maple.c      | 147 ++++++++++++------------
 3 files changed, 155 insertions(+), 151 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 89383eedb70af..ae08d34d1d3c4 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -33,54 +33,54 @@
 #else
 #define cond_resched()			do {} while (0)
 #endif
-static
-int mtree_insert_index(struct maple_tree *mt, unsigned long index, gfp_t gfp)
+static int __init mtree_insert_index(struct maple_tree *mt,
+				     unsigned long index, gfp_t gfp)
 {
 	return mtree_insert(mt, index, xa_mk_value(index & LONG_MAX), gfp);
 }
 
-static void mtree_erase_index(struct maple_tree *mt, unsigned long index)
+static void __init mtree_erase_index(struct maple_tree *mt, unsigned long index)
 {
 	MT_BUG_ON(mt, mtree_erase(mt, index) != xa_mk_value(index & LONG_MAX));
 	MT_BUG_ON(mt, mtree_load(mt, index) != NULL);
 }
 
-static int mtree_test_insert(struct maple_tree *mt, unsigned long index,
+static int __init mtree_test_insert(struct maple_tree *mt, unsigned long index,
 				void *ptr)
 {
 	return mtree_insert(mt, index, ptr, GFP_KERNEL);
 }
 
-static int mtree_test_store_range(struct maple_tree *mt, unsigned long start,
-				unsigned long end, void *ptr)
+static int __init mtree_test_store_range(struct maple_tree *mt,
+			unsigned long start, unsigned long end, void *ptr)
 {
 	return mtree_store_range(mt, start, end, ptr, GFP_KERNEL);
 }
 
-static int mtree_test_store(struct maple_tree *mt, unsigned long start,
+static int __init mtree_test_store(struct maple_tree *mt, unsigned long start,
 				void *ptr)
 {
 	return mtree_test_store_range(mt, start, start, ptr);
 }
 
-static int mtree_test_insert_range(struct maple_tree *mt, unsigned long start,
-				unsigned long end, void *ptr)
+static int __init mtree_test_insert_range(struct maple_tree *mt,
+			unsigned long start, unsigned long end, void *ptr)
 {
 	return mtree_insert_range(mt, start, end, ptr, GFP_KERNEL);
 }
 
-static void *mtree_test_load(struct maple_tree *mt, unsigned long index)
+static void __init *mtree_test_load(struct maple_tree *mt, unsigned long index)
 {
 	return mtree_load(mt, index);
 }
 
-static void *mtree_test_erase(struct maple_tree *mt, unsigned long index)
+static void __init *mtree_test_erase(struct maple_tree *mt, unsigned long index)
 {
 	return mtree_erase(mt, index);
 }
 
 #if defined(CONFIG_64BIT)
-static noinline void check_mtree_alloc_range(struct maple_tree *mt,
+static noinline void __init check_mtree_alloc_range(struct maple_tree *mt,
 		unsigned long start, unsigned long end, unsigned long size,
 		unsigned long expected, int eret, void *ptr)
 {
@@ -97,7 +97,7 @@ static noinline void check_mtree_alloc_range(struct maple_tree *mt,
 	MT_BUG_ON(mt, result != expected);
 }
 
-static noinline void check_mtree_alloc_rrange(struct maple_tree *mt,
+static noinline void __init check_mtree_alloc_rrange(struct maple_tree *mt,
 		unsigned long start, unsigned long end, unsigned long size,
 		unsigned long expected, int eret, void *ptr)
 {
@@ -115,8 +115,8 @@ static noinline void check_mtree_alloc_rrange(struct maple_tree *mt,
 }
 #endif
 
-static noinline void check_load(struct maple_tree *mt, unsigned long index,
-				void *ptr)
+static noinline void __init check_load(struct maple_tree *mt,
+				       unsigned long index, void *ptr)
 {
 	void *ret = mtree_test_load(mt, index);
 
@@ -125,7 +125,7 @@ static noinline void check_load(struct maple_tree *mt, unsigned long index,
 	MT_BUG_ON(mt, ret != ptr);
 }
 
-static noinline void check_store_range(struct maple_tree *mt,
+static noinline void __init check_store_range(struct maple_tree *mt,
 		unsigned long start, unsigned long end, void *ptr, int expected)
 {
 	int ret = -EINVAL;
@@ -141,7 +141,7 @@ static noinline void check_store_range(struct maple_tree *mt,
 		check_load(mt, i, ptr);
 }
 
-static noinline void check_insert_range(struct maple_tree *mt,
+static noinline void __init check_insert_range(struct maple_tree *mt,
 		unsigned long start, unsigned long end, void *ptr, int expected)
 {
 	int ret = -EINVAL;
@@ -157,8 +157,8 @@ static noinline void check_insert_range(struct maple_tree *mt,
 		check_load(mt, i, ptr);
 }
 
-static noinline void check_insert(struct maple_tree *mt, unsigned long index,
-		void *ptr)
+static noinline void __init check_insert(struct maple_tree *mt,
+					 unsigned long index, void *ptr)
 {
 	int ret = -EINVAL;
 
@@ -166,7 +166,7 @@ static noinline void check_insert(struct maple_tree *mt, unsigned long index,
 	MT_BUG_ON(mt, ret != 0);
 }
 
-static noinline void check_dup_insert(struct maple_tree *mt,
+static noinline void __init check_dup_insert(struct maple_tree *mt,
 				      unsigned long index, void *ptr)
 {
 	int ret = -EINVAL;
@@ -176,13 +176,13 @@ static noinline void check_dup_insert(struct maple_tree *mt,
 }
 
 
-static noinline
-void check_index_load(struct maple_tree *mt, unsigned long index)
+static noinline void __init check_index_load(struct maple_tree *mt,
+					     unsigned long index)
 {
 	return check_load(mt, index, xa_mk_value(index & LONG_MAX));
 }
 
-static inline int not_empty(struct maple_node *node)
+static inline __init int not_empty(struct maple_node *node)
 {
 	int i;
 
@@ -197,8 +197,8 @@ static inline int not_empty(struct maple_node *node)
 }
 
 
-static noinline void check_rev_seq(struct maple_tree *mt, unsigned long max,
-		bool verbose)
+static noinline void __init check_rev_seq(struct maple_tree *mt,
+					  unsigned long max, bool verbose)
 {
 	unsigned long i = max, j;
 
@@ -230,7 +230,7 @@ static noinline void check_rev_seq(struct maple_tree *mt, unsigned long max,
 #endif
 }
 
-static noinline void check_seq(struct maple_tree *mt, unsigned long max,
+static noinline void __init check_seq(struct maple_tree *mt, unsigned long max,
 		bool verbose)
 {
 	unsigned long i, j;
@@ -259,7 +259,7 @@ static noinline void check_seq(struct maple_tree *mt, unsigned long max,
 #endif
 }
 
-static noinline void check_lb_not_empty(struct maple_tree *mt)
+static noinline void __init check_lb_not_empty(struct maple_tree *mt)
 {
 	unsigned long i, j;
 	unsigned long huge = 4000UL * 1000 * 1000;
@@ -278,13 +278,13 @@ static noinline void check_lb_not_empty(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_lower_bound_split(struct maple_tree *mt)
+static noinline void __init check_lower_bound_split(struct maple_tree *mt)
 {
 	MT_BUG_ON(mt, !mtree_empty(mt));
 	check_lb_not_empty(mt);
 }
 
-static noinline void check_upper_bound_split(struct maple_tree *mt)
+static noinline void __init check_upper_bound_split(struct maple_tree *mt)
 {
 	unsigned long i, j;
 	unsigned long huge;
@@ -309,7 +309,7 @@ static noinline void check_upper_bound_split(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_mid_split(struct maple_tree *mt)
+static noinline void __init check_mid_split(struct maple_tree *mt)
 {
 	unsigned long huge = 8000UL * 1000 * 1000;
 
@@ -318,7 +318,7 @@ static noinline void check_mid_split(struct maple_tree *mt)
 	check_lb_not_empty(mt);
 }
 
-static noinline void check_rev_find(struct maple_tree *mt)
+static noinline void __init check_rev_find(struct maple_tree *mt)
 {
 	int i, nr_entries = 200;
 	void *val;
@@ -357,7 +357,7 @@ static noinline void check_rev_find(struct maple_tree *mt)
 	rcu_read_unlock();
 }
 
-static noinline void check_find(struct maple_tree *mt)
+static noinline void __init check_find(struct maple_tree *mt)
 {
 	unsigned long val = 0;
 	unsigned long count;
@@ -574,7 +574,7 @@ static noinline void check_find(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_find_2(struct maple_tree *mt)
+static noinline void __init check_find_2(struct maple_tree *mt)
 {
 	unsigned long i, j;
 	void *entry;
@@ -619,7 +619,7 @@ static noinline void check_find_2(struct maple_tree *mt)
 
 
 #if defined(CONFIG_64BIT)
-static noinline void check_alloc_rev_range(struct maple_tree *mt)
+static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 {
 	/*
 	 * Generated by:
@@ -627,7 +627,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 	 * awk -F "-" '{printf "0x%s, 0x%s, ", $1, $2}'
 	 */
 
-	unsigned long range[] = {
+	static const unsigned long range[] = {
 	/*      Inclusive     , Exclusive. */
 		0x565234af2000, 0x565234af4000,
 		0x565234af4000, 0x565234af9000,
@@ -655,7 +655,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 		0x7fff58791000, 0x7fff58793000,
 	};
 
-	unsigned long holes[] = {
+	static const unsigned long holes[] = {
 		/*
 		 * Note: start of hole is INCLUSIVE
 		 *        end of hole is EXCLUSIVE
@@ -675,7 +675,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 	 * 4. number that should be returned.
 	 * 5. return value
 	 */
-	unsigned long req_range[] = {
+	static const unsigned long req_range[] = {
 		0x565234af9000, /* Min */
 		0x7fff58791000, /* Max */
 		0x1000,         /* Size */
@@ -786,7 +786,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_alloc_range(struct maple_tree *mt)
+static noinline void __init check_alloc_range(struct maple_tree *mt)
 {
 	/*
 	 * Generated by:
@@ -794,7 +794,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 	 * awk -F "-" '{printf "0x%s, 0x%s, ", $1, $2}'
 	 */
 
-	unsigned long range[] = {
+	static const unsigned long range[] = {
 	/*      Inclusive     , Exclusive. */
 		0x565234af2000, 0x565234af4000,
 		0x565234af4000, 0x565234af9000,
@@ -821,7 +821,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 		0x7fff5878e000, 0x7fff58791000,
 		0x7fff58791000, 0x7fff58793000,
 	};
-	unsigned long holes[] = {
+	static const unsigned long holes[] = {
 		/* Start of hole, end of hole,  size of hole (+1) */
 		0x565234afb000, 0x565234afc000, 0x1000,
 		0x565234afe000, 0x565235def000, 0x12F1000,
@@ -836,7 +836,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 	 * 4. number that should be returned.
 	 * 5. return value
 	 */
-	unsigned long req_range[] = {
+	static const unsigned long req_range[] = {
 		0x565234af9000, /* Min */
 		0x7fff58791000, /* Max */
 		0x1000,         /* Size */
@@ -945,10 +945,10 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 }
 #endif
 
-static noinline void check_ranges(struct maple_tree *mt)
+static noinline void __init check_ranges(struct maple_tree *mt)
 {
 	int i, val, val2;
-	unsigned long r[] = {
+	static const unsigned long r[] = {
 		10, 15,
 		20, 25,
 		17, 22, /* Overlaps previous range. */
@@ -1213,7 +1213,7 @@ static noinline void check_ranges(struct maple_tree *mt)
 		MT_BUG_ON(mt, mt_height(mt) != 4);
 }
 
-static noinline void check_next_entry(struct maple_tree *mt)
+static noinline void __init check_next_entry(struct maple_tree *mt)
 {
 	void *entry = NULL;
 	unsigned long limit = 30, i = 0;
@@ -1237,7 +1237,7 @@ static noinline void check_next_entry(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_prev_entry(struct maple_tree *mt)
+static noinline void __init check_prev_entry(struct maple_tree *mt)
 {
 	unsigned long index = 16;
 	void *value;
@@ -1281,7 +1281,7 @@ static noinline void check_prev_entry(struct maple_tree *mt)
 	mas_unlock(&mas);
 }
 
-static noinline void check_root_expand(struct maple_tree *mt)
+static noinline void __init check_root_expand(struct maple_tree *mt)
 {
 	MA_STATE(mas, mt, 0, 0);
 	void *ptr;
@@ -1370,13 +1370,13 @@ static noinline void check_root_expand(struct maple_tree *mt)
 	mas_unlock(&mas);
 }
 
-static noinline void check_gap_combining(struct maple_tree *mt)
+static noinline void __init check_gap_combining(struct maple_tree *mt)
 {
 	struct maple_enode *mn1, *mn2;
 	void *entry;
 	unsigned long singletons = 100;
-	unsigned long *seq100;
-	unsigned long seq100_64[] = {
+	static const unsigned long *seq100;
+	static const unsigned long seq100_64[] = {
 		/* 0-5 */
 		74, 75, 76,
 		50, 100, 2,
@@ -1390,7 +1390,7 @@ static noinline void check_gap_combining(struct maple_tree *mt)
 		76, 2, 79, 85, 4,
 	};
 
-	unsigned long seq100_32[] = {
+	static const unsigned long seq100_32[] = {
 		/* 0-5 */
 		61, 62, 63,
 		50, 100, 2,
@@ -1404,11 +1404,11 @@ static noinline void check_gap_combining(struct maple_tree *mt)
 		76, 2, 79, 85, 4,
 	};
 
-	unsigned long seq2000[] = {
+	static const unsigned long seq2000[] = {
 		1152, 1151,
 		1100, 1200, 2,
 	};
-	unsigned long seq400[] = {
+	static const unsigned long seq400[] = {
 		286, 318,
 		256, 260, 266, 270, 275, 280, 290, 398,
 		286, 310,
@@ -1567,7 +1567,7 @@ static noinline void check_gap_combining(struct maple_tree *mt)
 	mt_set_non_kernel(0);
 	mtree_destroy(mt);
 }
-static noinline void check_node_overwrite(struct maple_tree *mt)
+static noinline void __init check_node_overwrite(struct maple_tree *mt)
 {
 	int i, max = 4000;
 
@@ -1580,7 +1580,7 @@ static noinline void check_node_overwrite(struct maple_tree *mt)
 }
 
 #if defined(BENCH_SLOT_STORE)
-static noinline void bench_slot_store(struct maple_tree *mt)
+static noinline void __init bench_slot_store(struct maple_tree *mt)
 {
 	int i, brk = 105, max = 1040, brk_start = 100, count = 20000000;
 
@@ -1596,7 +1596,7 @@ static noinline void bench_slot_store(struct maple_tree *mt)
 #endif
 
 #if defined(BENCH_NODE_STORE)
-static noinline void bench_node_store(struct maple_tree *mt)
+static noinline void __init bench_node_store(struct maple_tree *mt)
 {
 	int i, overwrite = 76, max = 240, count = 20000000;
 
@@ -1615,7 +1615,7 @@ static noinline void bench_node_store(struct maple_tree *mt)
 #endif
 
 #if defined(BENCH_AWALK)
-static noinline void bench_awalk(struct maple_tree *mt)
+static noinline void __init bench_awalk(struct maple_tree *mt)
 {
 	int i, max = 2500, count = 50000000;
 	MA_STATE(mas, mt, 1470, 1470);
@@ -1632,7 +1632,7 @@ static noinline void bench_awalk(struct maple_tree *mt)
 }
 #endif
 #if defined(BENCH_WALK)
-static noinline void bench_walk(struct maple_tree *mt)
+static noinline void __init bench_walk(struct maple_tree *mt)
 {
 	int i, max = 2500, count = 550000000;
 	MA_STATE(mas, mt, 1470, 1470);
@@ -1649,7 +1649,7 @@ static noinline void bench_walk(struct maple_tree *mt)
 #endif
 
 #if defined(BENCH_MT_FOR_EACH)
-static noinline void bench_mt_for_each(struct maple_tree *mt)
+static noinline void __init bench_mt_for_each(struct maple_tree *mt)
 {
 	int i, count = 1000000;
 	unsigned long max = 2500, index = 0;
@@ -1673,7 +1673,7 @@ static noinline void bench_mt_for_each(struct maple_tree *mt)
 #endif
 
 /* check_forking - simulate the kernel forking sequence with the tree. */
-static noinline void check_forking(struct maple_tree *mt)
+static noinline void __init check_forking(struct maple_tree *mt)
 {
 
 	struct maple_tree newmt;
@@ -1712,7 +1712,7 @@ static noinline void check_forking(struct maple_tree *mt)
 	mtree_destroy(&newmt);
 }
 
-static noinline void check_iteration(struct maple_tree *mt)
+static noinline void __init check_iteration(struct maple_tree *mt)
 {
 	int i, nr_entries = 125;
 	void *val;
@@ -1780,7 +1780,7 @@ static noinline void check_iteration(struct maple_tree *mt)
 	mt_set_non_kernel(0);
 }
 
-static noinline void check_mas_store_gfp(struct maple_tree *mt)
+static noinline void __init check_mas_store_gfp(struct maple_tree *mt)
 {
 
 	struct maple_tree newmt;
@@ -1813,7 +1813,7 @@ static noinline void check_mas_store_gfp(struct maple_tree *mt)
 }
 
 #if defined(BENCH_FORK)
-static noinline void bench_forking(struct maple_tree *mt)
+static noinline void __init bench_forking(struct maple_tree *mt)
 {
 
 	struct maple_tree newmt;
@@ -1855,15 +1855,17 @@ static noinline void bench_forking(struct maple_tree *mt)
 }
 #endif
 
-static noinline void next_prev_test(struct maple_tree *mt)
+static noinline void __init next_prev_test(struct maple_tree *mt)
 {
 	int i, nr_entries;
 	void *val;
 	MA_STATE(mas, mt, 0, 0);
 	struct maple_enode *mn;
-	unsigned long *level2;
-	unsigned long level2_64[] = {707, 1000, 710, 715, 720, 725};
-	unsigned long level2_32[] = {1747, 2000, 1750, 1755, 1760, 1765};
+	static const unsigned long *level2;
+	static const unsigned long level2_64[] = { 707, 1000, 710, 715, 720,
+						   725};
+	static const unsigned long level2_32[] = { 1747, 2000, 1750, 1755,
+						   1760, 1765};
 
 	if (MAPLE_32BIT) {
 		nr_entries = 500;
@@ -2031,7 +2033,7 @@ static noinline void next_prev_test(struct maple_tree *mt)
 
 
 /* Test spanning writes that require balancing right sibling or right cousin */
-static noinline void check_spanning_relatives(struct maple_tree *mt)
+static noinline void __init check_spanning_relatives(struct maple_tree *mt)
 {
 
 	unsigned long i, nr_entries = 1000;
@@ -2044,7 +2046,7 @@ static noinline void check_spanning_relatives(struct maple_tree *mt)
 	mtree_store_range(mt, 9365, 9955, NULL, GFP_KERNEL);
 }
 
-static noinline void check_fuzzer(struct maple_tree *mt)
+static noinline void __init check_fuzzer(struct maple_tree *mt)
 {
 	/*
 	 * 1. Causes a spanning rebalance of a single root node.
@@ -2441,7 +2443,7 @@ static noinline void check_fuzzer(struct maple_tree *mt)
 }
 
 /* duplicate the tree with a specific gap */
-static noinline void check_dup_gaps(struct maple_tree *mt,
+static noinline void __init check_dup_gaps(struct maple_tree *mt,
 				    unsigned long nr_entries, bool zero_start,
 				    unsigned long gap)
 {
@@ -2481,7 +2483,7 @@ static noinline void check_dup_gaps(struct maple_tree *mt,
 }
 
 /* Duplicate many sizes of trees.  Mainly to test expected entry values */
-static noinline void check_dup(struct maple_tree *mt)
+static noinline void __init check_dup(struct maple_tree *mt)
 {
 	int i;
 	int big_start = 100010;
@@ -2569,7 +2571,7 @@ static noinline void check_dup(struct maple_tree *mt)
 	}
 }
 
-static noinline void check_bnode_min_spanning(struct maple_tree *mt)
+static noinline void __init check_bnode_min_spanning(struct maple_tree *mt)
 {
 	int i = 50;
 	MA_STATE(mas, mt, 0, 0);
@@ -2588,7 +2590,7 @@ static noinline void check_bnode_min_spanning(struct maple_tree *mt)
 	mt_set_non_kernel(0);
 }
 
-static noinline void check_empty_area_window(struct maple_tree *mt)
+static noinline void __init check_empty_area_window(struct maple_tree *mt)
 {
 	unsigned long i, nr_entries = 20;
 	MA_STATE(mas, mt, 0, 0);
@@ -2673,7 +2675,7 @@ static noinline void check_empty_area_window(struct maple_tree *mt)
 	rcu_read_unlock();
 }
 
-static noinline void check_empty_area_fill(struct maple_tree *mt)
+static noinline void __init check_empty_area_fill(struct maple_tree *mt)
 {
 	const unsigned long max = 0x25D78000;
 	unsigned long size;
@@ -2717,11 +2719,11 @@ static noinline void check_empty_area_fill(struct maple_tree *mt)
 }
 
 static DEFINE_MTREE(tree);
-static int maple_tree_seed(void)
+static int __init maple_tree_seed(void)
 {
-	unsigned long set[] = {5015, 5014, 5017, 25, 1000,
-			       1001, 1002, 1003, 1005, 0,
-			       5003, 5002};
+	unsigned long set[] = { 5015, 5014, 5017, 25, 1000,
+				1001, 1002, 1003, 1005, 0,
+				5003, 5002};
 	void *ptr = &set;
 
 	pr_info("\nTEST STARTING\n\n");
@@ -2991,7 +2993,7 @@ static int maple_tree_seed(void)
 	return -EINVAL;
 }
 
-static void maple_tree_harvest(void)
+static void __exit maple_tree_harvest(void)
 {
 
 }
diff --git a/tools/testing/radix-tree/linux/init.h b/tools/testing/radix-tree/linux/init.h
index 1bb0afc213099..81563c3dfce79 100644
--- a/tools/testing/radix-tree/linux/init.h
+++ b/tools/testing/radix-tree/linux/init.h
@@ -1 +1,2 @@
 #define __init
+#define __exit
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index cf37ed9ab6c4d..03539d86cdf0f 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -14,6 +14,7 @@
 #include "test.h"
 #include <stdlib.h>
 #include <time.h>
+#include "linux/init.h"
 
 #define module_init(x)
 #define module_exit(x)
@@ -80,7 +81,7 @@ static void check_mas_alloc_node_count(struct ma_state *mas)
  * check_new_node() - Check the creation of new nodes and error path
  * verification.
  */
-static noinline void check_new_node(struct maple_tree *mt)
+static noinline void __init check_new_node(struct maple_tree *mt)
 {
 
 	struct maple_node *mn, *mn2, *mn3;
@@ -454,7 +455,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 /*
  * Check erasing including RCU.
  */
-static noinline void check_erase(struct maple_tree *mt, unsigned long index,
+static noinline void __init check_erase(struct maple_tree *mt, unsigned long index,
 		void *ptr)
 {
 	MT_BUG_ON(mt, mtree_test_erase(mt, index) != ptr);
@@ -464,24 +465,24 @@ static noinline void check_erase(struct maple_tree *mt, unsigned long index,
 #define erase_check_insert(mt, i) check_insert(mt, set[i], entry[i%2])
 #define erase_check_erase(mt, i) check_erase(mt, set[i], entry[i%2])
 
-static noinline void check_erase_testset(struct maple_tree *mt)
+static noinline void __init check_erase_testset(struct maple_tree *mt)
 {
-	unsigned long set[] = { 5015, 5014, 5017, 25, 1000,
-				1001, 1002, 1003, 1005, 0,
-				6003, 6002, 6008, 6012, 6015,
-				7003, 7002, 7008, 7012, 7015,
-				8003, 8002, 8008, 8012, 8015,
-				9003, 9002, 9008, 9012, 9015,
-				10003, 10002, 10008, 10012, 10015,
-				11003, 11002, 11008, 11012, 11015,
-				12003, 12002, 12008, 12012, 12015,
-				13003, 13002, 13008, 13012, 13015,
-				14003, 14002, 14008, 14012, 14015,
-				15003, 15002, 15008, 15012, 15015,
-			      };
-
-
-	void *ptr = &set;
+	static const unsigned long set[] = { 5015, 5014, 5017, 25, 1000,
+					     1001, 1002, 1003, 1005, 0,
+					     6003, 6002, 6008, 6012, 6015,
+					     7003, 7002, 7008, 7012, 7015,
+					     8003, 8002, 8008, 8012, 8015,
+					     9003, 9002, 9008, 9012, 9015,
+					     10003, 10002, 10008, 10012, 10015,
+					     11003, 11002, 11008, 11012, 11015,
+					     12003, 12002, 12008, 12012, 12015,
+					     13003, 13002, 13008, 13012, 13015,
+					     14003, 14002, 14008, 14012, 14015,
+					     15003, 15002, 15008, 15012, 15015,
+					   };
+
+
+	void *ptr = &check_erase_testset;
 	void *entry[2] = { ptr, mt };
 	void *root_node;
 
@@ -738,7 +739,7 @@ static noinline void check_erase_testset(struct maple_tree *mt)
 int mas_ce2_over_count(struct ma_state *mas_start, struct ma_state *mas_end,
 		      void *s_entry, unsigned long s_min,
 		      void *e_entry, unsigned long e_max,
-		      unsigned long *set, int i, bool null_entry)
+		      const unsigned long *set, int i, bool null_entry)
 {
 	int count = 0, span = 0;
 	unsigned long retry = 0;
@@ -968,8 +969,8 @@ static inline void *mas_range_load(struct ma_state *mas,
 }
 
 #if defined(CONFIG_64BIT)
-static noinline void check_erase2_testset(struct maple_tree *mt,
-		unsigned long *set, unsigned long size)
+static noinline void __init check_erase2_testset(struct maple_tree *mt,
+		const unsigned long *set, unsigned long size)
 {
 	int entry_count = 0;
 	int check = 0;
@@ -1113,11 +1114,11 @@ static noinline void check_erase2_testset(struct maple_tree *mt,
 
 
 /* These tests were pulled from KVM tree modifications which failed. */
-static noinline void check_erase2_sets(struct maple_tree *mt)
+static noinline void __init check_erase2_sets(struct maple_tree *mt)
 {
 	void *entry;
 	unsigned long start = 0;
-	unsigned long set[] = {
+	static const unsigned long set[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140721266458624, 140737488351231,
 ERASE, 140721266458624, 140737488351231,
@@ -1135,7 +1136,7 @@ ERASE, 140253902692352, 140253902864383,
 STORE, 140253902692352, 140253902696447,
 STORE, 140253902696448, 140253902864383,
 		};
-	unsigned long set2[] = {
+	static const unsigned long set2[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140735933583360, 140737488351231,
 ERASE, 140735933583360, 140737488351231,
@@ -1159,7 +1160,7 @@ STORE, 140277094813696, 140277094821887,
 STORE, 140277094821888, 140277094825983,
 STORE, 140735933906944, 140735933911039,
 	};
-	unsigned long set3[] = {
+	static const unsigned long set3[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140735790264320, 140737488351231,
 ERASE, 140735790264320, 140737488351231,
@@ -1202,7 +1203,7 @@ STORE, 47135835840512, 47135835885567,
 STORE, 47135835885568, 47135835893759,
 	};
 
-	unsigned long set4[] = {
+	static const unsigned long set4[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140728251703296, 140737488351231,
 ERASE, 140728251703296, 140737488351231,
@@ -1223,7 +1224,7 @@ ERASE, 47646523277312, 47646523445247,
 STORE, 47646523277312, 47646523400191,
 	};
 
-	unsigned long set5[] = {
+	static const unsigned long set5[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140726874062848, 140737488351231,
 ERASE, 140726874062848, 140737488351231,
@@ -1356,7 +1357,7 @@ STORE, 47884791619584, 47884791623679,
 STORE, 47884791623680, 47884791627775,
 	};
 
-	unsigned long set6[] = {
+	static const unsigned long set6[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140722999021568, 140737488351231,
 ERASE, 140722999021568, 140737488351231,
@@ -1488,7 +1489,7 @@ ERASE, 47430432014336, 47430432022527,
 STORE, 47430432014336, 47430432018431,
 STORE, 47430432018432, 47430432022527,
 	};
-	unsigned long set7[] = {
+	static const unsigned long set7[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140729808330752, 140737488351231,
 ERASE, 140729808330752, 140737488351231,
@@ -1620,7 +1621,7 @@ ERASE, 47439987130368, 47439987138559,
 STORE, 47439987130368, 47439987134463,
 STORE, 47439987134464, 47439987138559,
 	};
-	unsigned long set8[] = {
+	static const unsigned long set8[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140722482974720, 140737488351231,
 ERASE, 140722482974720, 140737488351231,
@@ -1753,7 +1754,7 @@ STORE, 47708488638464, 47708488642559,
 STORE, 47708488642560, 47708488646655,
 	};
 
-	unsigned long set9[] = {
+	static const unsigned long set9[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140736427839488, 140737488351231,
 ERASE, 140736427839488, 140736427839488,
@@ -5619,7 +5620,7 @@ ERASE, 47906195480576, 47906195480576,
 STORE, 94641242615808, 94641242750975,
 	};
 
-	unsigned long set10[] = {
+	static const unsigned long set10[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140736427839488, 140737488351231,
 ERASE, 140736427839488, 140736427839488,
@@ -9483,7 +9484,7 @@ STORE, 139726599680000, 139726599684095,
 ERASE, 47906195480576, 47906195480576,
 STORE, 94641242615808, 94641242750975,
 	};
-	unsigned long set11[] = {
+	static const unsigned long set11[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140732658499584, 140737488351231,
 ERASE, 140732658499584, 140732658499584,
@@ -9509,7 +9510,7 @@ STORE, 140732658565120, 140732658569215,
 STORE, 140732658552832, 140732658565119,
 	};
 
-	unsigned long set12[] = { /* contains 12 values. */
+	static const unsigned long set12[] = { /* contains 12 values. */
 STORE, 140737488347136, 140737488351231,
 STORE, 140732658499584, 140737488351231,
 ERASE, 140732658499584, 140732658499584,
@@ -9536,7 +9537,7 @@ STORE, 140732658552832, 140732658565119,
 STORE, 140014592741375, 140014592741375, /* contrived */
 STORE, 140014592733184, 140014592741376, /* creates first entry retry. */
 	};
-	unsigned long set13[] = {
+	static const unsigned long set13[] = {
 STORE, 140373516247040, 140373516251135,/*: ffffa2e7b0e10d80 */
 STORE, 140373516251136, 140373516255231,/*: ffffa2e7b1195d80 */
 STORE, 140373516255232, 140373516443647,/*: ffffa2e7b0e109c0 */
@@ -9549,7 +9550,7 @@ STORE, 140373518684160, 140373518688254,/*: ffffa2e7b05fec00 */
 STORE, 140373518688256, 140373518692351,/*: ffffa2e7bfbdcd80 */
 STORE, 140373518692352, 140373518696447,/*: ffffa2e7b0749e40 */
 	};
-	unsigned long set14[] = {
+	static const unsigned long set14[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140731667996672, 140737488351231,
 SNULL, 140731668000767, 140737488351231,
@@ -9833,7 +9834,7 @@ SNULL, 139826136543232, 139826136809471,
 STORE, 139826136809472, 139826136842239,
 STORE, 139826136543232, 139826136809471,
 	};
-	unsigned long set15[] = {
+	static const unsigned long set15[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140722061451264, 140737488351231,
 SNULL, 140722061455359, 140737488351231,
@@ -10118,7 +10119,7 @@ STORE, 139906808958976, 139906808991743,
 STORE, 139906808692736, 139906808958975,
 	};
 
-	unsigned long set16[] = {
+	static const unsigned long set16[] = {
 STORE, 94174808662016, 94174809321471,
 STORE, 94174811414528, 94174811426815,
 STORE, 94174811426816, 94174811430911,
@@ -10329,7 +10330,7 @@ STORE, 139921865613312, 139921865617407,
 STORE, 139921865547776, 139921865564159,
 	};
 
-	unsigned long set17[] = {
+	static const unsigned long set17[] = {
 STORE, 94397057224704, 94397057646591,
 STORE, 94397057650688, 94397057691647,
 STORE, 94397057691648, 94397057695743,
@@ -10391,7 +10392,7 @@ STORE, 140720477511680, 140720477646847,
 STORE, 140720478302208, 140720478314495,
 STORE, 140720478314496, 140720478318591,
 	};
-	unsigned long set18[] = {
+	static const unsigned long set18[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140724953673728, 140737488351231,
 SNULL, 140724953677823, 140737488351231,
@@ -10424,7 +10425,7 @@ STORE, 140222970597376, 140222970605567,
 ERASE, 140222970597376, 140222970605567,
 STORE, 140222970597376, 140222970605567,
 	};
-	unsigned long set19[] = {
+	static const unsigned long set19[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140725182459904, 140737488351231,
 SNULL, 140725182463999, 140737488351231,
@@ -10693,7 +10694,7 @@ STORE, 140656836775936, 140656836780031,
 STORE, 140656787476480, 140656791920639,
 ERASE, 140656774639616, 140656779083775,
 	};
-	unsigned long set20[] = {
+	static const unsigned long set20[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140735952392192, 140737488351231,
 SNULL, 140735952396287, 140737488351231,
@@ -10849,7 +10850,7 @@ STORE, 140590386819072, 140590386823167,
 STORE, 140590386823168, 140590386827263,
 SNULL, 140590376591359, 140590376595455,
 	};
-	unsigned long set21[] = {
+	static const unsigned long set21[] = {
 STORE, 93874710941696, 93874711363583,
 STORE, 93874711367680, 93874711408639,
 STORE, 93874711408640, 93874711412735,
@@ -10919,7 +10920,7 @@ ERASE, 140708393312256, 140708393316351,
 ERASE, 140708393308160, 140708393312255,
 ERASE, 140708393291776, 140708393308159,
 	};
-	unsigned long set22[] = {
+	static const unsigned long set22[] = {
 STORE, 93951397134336, 93951397183487,
 STORE, 93951397183488, 93951397728255,
 STORE, 93951397728256, 93951397826559,
@@ -11046,7 +11047,7 @@ STORE, 140551361253376, 140551361519615,
 ERASE, 140551361253376, 140551361519615,
 	};
 
-	unsigned long set23[] = {
+	static const unsigned long set23[] = {
 STORE, 94014447943680, 94014448156671,
 STORE, 94014450253824, 94014450257919,
 STORE, 94014450257920, 94014450266111,
@@ -14370,7 +14371,7 @@ SNULL, 140175956627455, 140175985139711,
 STORE, 140175927242752, 140175956627455,
 STORE, 140175956627456, 140175985139711,
 	};
-	unsigned long set24[] = {
+	static const unsigned long set24[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140735281639424, 140737488351231,
 SNULL, 140735281643519, 140737488351231,
@@ -15532,7 +15533,7 @@ ERASE, 139635393024000, 139635401412607,
 ERASE, 139635384627200, 139635384631295,
 ERASE, 139635384631296, 139635393019903,
 	};
-	unsigned long set25[] = {
+	static const unsigned long set25[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140737488343040, 140737488351231,
 STORE, 140722547441664, 140737488351231,
@@ -22320,7 +22321,7 @@ STORE, 140249652703232, 140249682087935,
 STORE, 140249682087936, 140249710600191,
 	};
 
-	unsigned long set26[] = {
+	static const unsigned long set26[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140729464770560, 140737488351231,
 SNULL, 140729464774655, 140737488351231,
@@ -22344,7 +22345,7 @@ ERASE, 140109040951296, 140109040959487,
 STORE, 140109040955392, 140109040959487,
 ERASE, 140109040955392, 140109040959487,
 	};
-	unsigned long set27[] = {
+	static const unsigned long set27[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140726128070656, 140737488351231,
 SNULL, 140726128074751, 140737488351231,
@@ -22740,7 +22741,7 @@ STORE, 140415509696512, 140415535910911,
 ERASE, 140415537422336, 140415562588159,
 STORE, 140415482433536, 140415509696511,
 	};
-	unsigned long set28[] = {
+	static const unsigned long set28[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140722475622400, 140737488351231,
 SNULL, 140722475626495, 140737488351231,
@@ -22808,7 +22809,7 @@ STORE, 139918413348864, 139918413352959,
 ERASE, 139918413316096, 139918413344767,
 STORE, 93865848528896, 93865848664063,
 	};
-	unsigned long set29[] = {
+	static const unsigned long set29[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140734467944448, 140737488351231,
 SNULL, 140734467948543, 140737488351231,
@@ -23683,7 +23684,7 @@ ERASE, 140143079972864, 140143088361471,
 ERASE, 140143205793792, 140143205797887,
 ERASE, 140143205797888, 140143214186495,
 	};
-	unsigned long set30[] = {
+	static const unsigned long set30[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140733436743680, 140737488351231,
 SNULL, 140733436747775, 140737488351231,
@@ -24565,7 +24566,7 @@ ERASE, 140165225893888, 140165225897983,
 ERASE, 140165225897984, 140165234286591,
 ERASE, 140165058105344, 140165058109439,
 	};
-	unsigned long set31[] = {
+	static const unsigned long set31[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140730890784768, 140737488351231,
 SNULL, 140730890788863, 140737488351231,
@@ -25378,7 +25379,7 @@ ERASE, 140623906590720, 140623914979327,
 ERASE, 140622950277120, 140622950281215,
 ERASE, 140622950281216, 140622958669823,
 	};
-	unsigned long set32[] = {
+	static const unsigned long set32[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140731244212224, 140737488351231,
 SNULL, 140731244216319, 140737488351231,
@@ -26174,7 +26175,7 @@ ERASE, 140400417288192, 140400425676799,
 ERASE, 140400283066368, 140400283070463,
 ERASE, 140400283070464, 140400291459071,
 	};
-	unsigned long set33[] = {
+	static const unsigned long set33[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140734562918400, 140737488351231,
 SNULL, 140734562922495, 140737488351231,
@@ -26316,7 +26317,7 @@ STORE, 140582961786880, 140583003750399,
 ERASE, 140582961786880, 140583003750399,
 	};
 
-	unsigned long set34[] = {
+	static const unsigned long set34[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140731327180800, 140737488351231,
 SNULL, 140731327184895, 140737488351231,
@@ -27197,7 +27198,7 @@ ERASE, 140012522094592, 140012530483199,
 ERASE, 140012033142784, 140012033146879,
 ERASE, 140012033146880, 140012041535487,
 	};
-	unsigned long set35[] = {
+	static const unsigned long set35[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140730536939520, 140737488351231,
 SNULL, 140730536943615, 140737488351231,
@@ -27954,7 +27955,7 @@ ERASE, 140474471936000, 140474480324607,
 ERASE, 140474396430336, 140474396434431,
 ERASE, 140474396434432, 140474404823039,
 	};
-	unsigned long set36[] = {
+	static const unsigned long set36[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140723893125120, 140737488351231,
 SNULL, 140723893129215, 140737488351231,
@@ -28815,7 +28816,7 @@ ERASE, 140121890357248, 140121898745855,
 ERASE, 140121269587968, 140121269592063,
 ERASE, 140121269592064, 140121277980671,
 	};
-	unsigned long set37[] = {
+	static const unsigned long set37[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140722404016128, 140737488351231,
 SNULL, 140722404020223, 140737488351231,
@@ -28941,7 +28942,7 @@ STORE, 139759821246464, 139759888355327,
 ERASE, 139759821246464, 139759888355327,
 ERASE, 139759888355328, 139759955464191,
 	};
-	unsigned long set38[] = {
+	static const unsigned long set38[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140730666221568, 140737488351231,
 SNULL, 140730666225663, 140737488351231,
@@ -29751,7 +29752,7 @@ ERASE, 140613504712704, 140613504716799,
 ERASE, 140613504716800, 140613513105407,
 	};
 
-	unsigned long set39[] = {
+	static const unsigned long set39[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140736271417344, 140737488351231,
 SNULL, 140736271421439, 140737488351231,
@@ -30123,7 +30124,7 @@ STORE, 140325364428800, 140325372821503,
 STORE, 140325356036096, 140325364428799,
 SNULL, 140325364432895, 140325372821503,
 	};
-	unsigned long set40[] = {
+	static const unsigned long set40[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140734309167104, 140737488351231,
 SNULL, 140734309171199, 140737488351231,
@@ -30874,7 +30875,7 @@ ERASE, 140320289300480, 140320289304575,
 ERASE, 140320289304576, 140320297693183,
 ERASE, 140320163409920, 140320163414015,
 	};
-	unsigned long set41[] = {
+	static const unsigned long set41[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140728157171712, 140737488351231,
 SNULL, 140728157175807, 140737488351231,
@@ -31184,7 +31185,7 @@ STORE, 94376135090176, 94376135094271,
 STORE, 94376135094272, 94376135098367,
 SNULL, 94376135094272, 94377208836095,
 	};
-	unsigned long set42[] = {
+	static const unsigned long set42[] = {
 STORE, 314572800, 1388314623,
 STORE, 1462157312, 1462169599,
 STORE, 1462169600, 1462185983,
@@ -33861,7 +33862,7 @@ SNULL, 3798999040, 3799101439,
  */
 	};
 
-	unsigned long set43[] = {
+	static const unsigned long set43[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140734187720704, 140737488351231,
 SNULL, 140734187724800, 140737488351231,
@@ -34995,7 +34996,7 @@ void run_check_rcu_slowread(struct maple_tree *mt, struct rcu_test_struct *vals)
 	MT_BUG_ON(mt, !vals->seen_entry3);
 	MT_BUG_ON(mt, !vals->seen_both);
 }
-static noinline void check_rcu_simulated(struct maple_tree *mt)
+static noinline void __init check_rcu_simulated(struct maple_tree *mt)
 {
 	unsigned long i, nr_entries = 1000;
 	unsigned long target = 4320;
@@ -35156,7 +35157,7 @@ static noinline void check_rcu_simulated(struct maple_tree *mt)
 	rcu_unregister_thread();
 }
 
-static noinline void check_rcu_threaded(struct maple_tree *mt)
+static noinline void __init check_rcu_threaded(struct maple_tree *mt)
 {
 	unsigned long i, nr_entries = 1000;
 	struct rcu_test_struct vals;
@@ -35369,7 +35370,7 @@ static void check_dfs_preorder(struct maple_tree *mt)
 /* End of depth first search tests */
 
 /* Preallocation testing */
-static noinline void check_prealloc(struct maple_tree *mt)
+static noinline void __init check_prealloc(struct maple_tree *mt)
 {
 	unsigned long i, max = 100;
 	unsigned long allocated;
@@ -35497,7 +35498,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
 /* End of preallocation testing */
 
 /* Spanning writes, writes that span nodes and layers of the tree */
-static noinline void check_spanning_write(struct maple_tree *mt)
+static noinline void __init check_spanning_write(struct maple_tree *mt)
 {
 	unsigned long i, max = 5000;
 	MA_STATE(mas, mt, 1200, 2380);
@@ -35665,7 +35666,7 @@ static noinline void check_spanning_write(struct maple_tree *mt)
 /* End of spanning write testing */
 
 /* Writes to a NULL area that are adjacent to other NULLs */
-static noinline void check_null_expand(struct maple_tree *mt)
+static noinline void __init check_null_expand(struct maple_tree *mt)
 {
 	unsigned long i, max = 100;
 	unsigned char data_end;
@@ -35726,7 +35727,7 @@ static noinline void check_null_expand(struct maple_tree *mt)
 /* End of NULL area expansions */
 
 /* Checking for no memory is best done outside the kernel */
-static noinline void check_nomem(struct maple_tree *mt)
+static noinline void __init check_nomem(struct maple_tree *mt)
 {
 	MA_STATE(ms, mt, 1, 1);
 
@@ -35761,7 +35762,7 @@ static noinline void check_nomem(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_locky(struct maple_tree *mt)
+static noinline void __init check_locky(struct maple_tree *mt)
 {
 	MA_STATE(ms, mt, 2, 2);
 	MA_STATE(reader, mt, 2, 2);
-- 
2.39.2

