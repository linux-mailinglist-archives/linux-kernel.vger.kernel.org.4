Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051BB700EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbjELSVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbjELSVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9043A85
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF48VQ032462;
        Fri, 12 May 2023 18:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=x1F35Nl/y1jdMAp6sXSkI9LKCTzgTwzSHQmh+g/8a1k=;
 b=yXv7CESSqG+HbWaN2UZ3gYc/BU9LDulA3lYj60uyb5i3SSdLgTDBhaUwGYZyCmvtPMoH
 GeVrewYRuB/jTTivh2DkszWL4iO9kXHG5OaYM2m2wY8rWiyRaVzNO5r9ia8sVN3oCItG
 nr4NA/T1DqxjkTaVPKskFBbwO1cwcf1Y+buKAOn3EX0qA5IZ2IsLMFVhHQcTIflKgR7K
 5kRnbjg1mQnK4g6c8vCPP6M/p/7eW3yGvFqdDcQXRBKLfi/5yBY3/BJw4un0KGxhO/o4
 NVM9QFMmYe5XVyCulzwLBLXwDFsvCuQKUVlOrfHNvRcW2vrK4qSDUyZXQJzmhY72+Pbf Ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bm0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CGe6ve014359;
        Fri, 12 May 2023 18:21:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8316bpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8jEIcZuY8L/9NL8EO3it3O2WMnhIAN3zd8UCp227JZEFPAchmuUfbNI0Vd4KPreKX5A+g9KzgJO2DBWlKhDmobXnK/ZAq72Pp5p9Gvy3XLSaJbgmMcz14iodLU+dOyuqoAnzgtn0YziSXB/23LVj/B9Id5ljj8Vesv0oqj2Gx2kNr4yN44r3gzRQnoUklO51bLZYQyDN4dyffB6UsFx/bURYwK0ZwB1D89bFKv5BM5kIx/+IGuc/cSS5m+Pddi5cwSJ4iMUk1Xyq4cCciQRkvMCW5mQBckghxwy6simrbIYMYzdaZbY4Uft3flAxQOTg4imcJ7g45o6ksjMWoCTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1F35Nl/y1jdMAp6sXSkI9LKCTzgTwzSHQmh+g/8a1k=;
 b=aJ0ItBud4md//RrHuJs/dQr/nmoGZmLE6DdCzE+Jy3IlzUpV0N2GJofnkJZG4fG0mZrsCWEOKBOzpK+9qhVOFtHfdFenJ2zqNfTMH4OhpudvxTrIcYLjkYqIbDWtUZ8d+a9g1t/hwiqnaz+OVQ7gQQMFrtJ64qRs7MZClGgtHvqyrcAu345bGrT+uszJgtn8eS1ZoYlc/uAyhB6CRM8QBcoCnVCUqMwG0/B0pFHGAh4O7QBAKHQi0X6SC0z8Oo1XgjdwjmEfj+Mxh5lM5xTcT7EtGTUaLAw3XF2vgjRFtmSo6PvgN9F1VxdZtjMopB5jqmlHGjszeZ35GXdb7wauwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1F35Nl/y1jdMAp6sXSkI9LKCTzgTwzSHQmh+g/8a1k=;
 b=nqQVVZExhVaS0UAORt7fRccmO1J+CIhUWDTB90HU1afoG+yBbNYIw/ojsrRB8cBhyP8TkfOrvqVY+nrCVjSuDu9+Y/Lrro/r63hqOgGWc8Qk2JFyTKWJqTcxBiAtSNvtHgkQErYyapu38S1vO7T2U9ytTuRLoddlItB20E4wBEY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:02 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 05/35] maple_tree: Add format option to mt_dump()
Date:   Fri, 12 May 2023 14:20:06 -0400
Message-Id: <20230512182036.359030-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0352.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd099b0-3abc-40b3-98a5-08db5315a48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2fsuM9Vq7KUkIj8bTJ+yhN41HcFwQ+IuKfU5DpZ6fDkt1wTt4UpkvjXTUY5pnJQv/eL/mGj47qQuX7aurO9pzqxWMV6eJDKDF8es1Xa9n70FGhu8J0/SbS9N3IzjjLgibYyAXteYagUmqHMzU4DeDk3M/3MwlVjW9udn5Ubp/Bitf97NdeAxNo9U4RBflHt40zJAi3QHywK3Bq0sg+wKb4TuI5jzzzNDTIUxvL/Cz/twzsGsYQ5JcH8t/eC112GRyJnXDaHDr4c5dzG6Q8SAyDrBbG4r3Y4vQxISS0i2Q8IPPN1vDwVauhDTl7jhvSYlAqQTfwEQDP5WJV021Ol+4hPnBy4tSUmIj+obcWLEOXwcH0UUfWY6d5KYOJNkjEB/cN06gY5tchAYGeMmiAerIs7iKSL45dkFem+jHqiE71OgDSlG6GjkHTnwRxBaubhBoreHV88zrAedQz8HrIrKH8JpxyLNTvFDQerXMq/8F2FA0JW+GBRTVhS/BFHmzu6D1fuE6S6AqT+B/VK7J2BvYxDBvq1l6sffKt9pm2vis8fQyF9p08z95rdeorVrSWn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(2906002)(30864003)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(54906003)(1076003)(86362001)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BNKGp6GXWxRE37cLphqBE8/+vyTSET9JmYUqZTI1Imp0aPSYO93nEKyMyXxa?=
 =?us-ascii?Q?dXL7YN3i0DalCCWyOy3v6Z55M3D1DWMCiwnsnAv9p8S4/lMYik2WbN3AM19s?=
 =?us-ascii?Q?f7ZFqnFpL7y7OwpmjQtZnS8ZF+i5wd4wSoEU9oGyfuvmXsH8SkEOQytxflSI?=
 =?us-ascii?Q?AClIFljOJQ0K/ijKa2GVX8LnkT/tKp49TMtj2OqR/K9SCGA0M1FOp4GdBELW?=
 =?us-ascii?Q?hV5e9SDwEjxSkM+yjm9gz5RPzsYtnEFyf3mOPLJC1aY9BohS+nNXcQI/wRUk?=
 =?us-ascii?Q?NalvQgyI7YD/PVWc2skCn9VPwFAINwFSqSILNWg+cKgw8uIl+SVWRbfQjVRc?=
 =?us-ascii?Q?hs4yokNMCJO5DHsBpkQ28ACpG1x/ux8mB4ODTk+JOjbhjFufA41D1kUbBxbU?=
 =?us-ascii?Q?bzyWkOlnzIhImG+8mKufYF0V1ZgzZXiGDppo3bpzpGv4QRY9vo7bOuGQ7q3Q?=
 =?us-ascii?Q?V8aytdL/uT17Vmh6dbgSbWI49hHm/f2iiFuaDzyz+r0+SAGtIT6w2jsJwjGJ?=
 =?us-ascii?Q?xQLeTcWvMKD8cIvNVpHU0mh9irTB4vWYDkUwhGSasDGa0T0ukXPuVL9rVtf7?=
 =?us-ascii?Q?TtfBjo9l+INMqijY6wo2IoH8ugEnixkSjNLf906Pr3qmjVmqg739YxWKWQ7h?=
 =?us-ascii?Q?RXyytt9bca6O2Cxpxd1JgucI2e6iZbDxZfY9RqAefKDFRpfILZwPhXPq4tX9?=
 =?us-ascii?Q?gPBcE5D/mTJ9GjPf+HCAmRMU++NK3/BrXzsR0qBs9EtytxuKPp7gWMgctfKe?=
 =?us-ascii?Q?nDUSxeBHQwIBH8ZmQET0V2GaH1akMySmQZWdxbGzYD79oUoadSd1vmzRrWeQ?=
 =?us-ascii?Q?wIRUtFpTLn5iFxO9WshZ6+N/KFuhWl8z8sW6mI4hHmz2qYnx3dmWwyBNxQWz?=
 =?us-ascii?Q?SR/0Bv3xqVGj2fNXD6dcwDaM+HY0ZukKo2CSa3MW5HPvCak5/8JgdbcRVxLj?=
 =?us-ascii?Q?9v3Bqtze1Gi9kmZ86ffWeGrF2sBQYIz6wRJ4JUU36qvRHXFUPUVR7xQTXZ3b?=
 =?us-ascii?Q?y6KP6PZAL3SbSsz/YyjZ5UeycZXnlJru6gSAMN3FZkzRYb79LOTTd8ggkJzl?=
 =?us-ascii?Q?EDbsViuEXdDF0QrfSLXKSZPv6FQVSAY8Qll3zv2YeeqMsHbtKh4InrZdhqmf?=
 =?us-ascii?Q?n/iKXxnSHs5hePFN1EOkt/qhXGza3J8+u5T9d/9Gwu7ORhkBCAG6ZKh6cXzI?=
 =?us-ascii?Q?wTYRMf0qNWd8FcAmSeVRfTvbqgbBG4PbziQe0pZKVJfMRvUa6taRVHeEaKwB?=
 =?us-ascii?Q?Fpvx/kh8AUiuCnY2Iqqp9Az9TqtqORnbiLgttAehdeQGUg9BFu3C+CNNDStS?=
 =?us-ascii?Q?KVIpDL+lGKal4BJ7rVivhVSMZ8oHoT0MKZyK35Mr6lZE49Tce1wGv0rBI04l?=
 =?us-ascii?Q?0w++hGBs40TwtQYoL/lmEx0sWYhS4Sad2JN6XoeMr+3an13NstWVP141Gfk3?=
 =?us-ascii?Q?ZJq5UMu3TdktWTigyk/0rRdOzcFWwmPBxIHSUGLgHigib5a6Vsf8q4xu9NoR?=
 =?us-ascii?Q?C4Urr/iklW+kmq8mrNtEBEPA/tDlZcVWu7v02G7P95iQ2o7NRbaHke59LGho?=
 =?us-ascii?Q?H+Zz6l2nAw++a0k+F90wM/MOFIexo2gtRjsFMLvcCZbkdvYuG4Zj2+PXf+1G?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gbwbE5k4TlWYS7jI9V3JQXeee27Wi+LKQnwFwpycAkEAUsLPinCjYyApYUJLOLpNjRBTLU29COkF4UdotaMv/i7pnc1WV3ldWC4PLxxhZpBVPx7AYeCDr6RMoAKy3aXCoWelVv6dEqhfsrCXxeBTZ/Acc5dbajgC1/1Bn3B+luqzF1uyW53lW5MuExBlNYklKXvy8cbpU12RvlXKNB0z5f/tXaD0LQiyrnmngF1OvDA8gODNvpLLq2NR2MmCglfXZBDWb+rTq9u+KMEzPN/N1mmVz37fr7ymlWipXJ4iN49YN44LIIb6VE5dQEJKNRftr8iDlyX8rwLGe4HUZvpq3NfOfSv4pVDTEqn8PogfWmyzHiS8AFnCfAfsoqn1qkbE/o63Tsl30xX7VwejgnPD+81FJOlmhbZX+hosY8KL7Z437d++dgmL6yZRXvBlRfqxx30FfSOYmukJRN4tISS0MeuRjpyd79Lz38mjIj8aqSFs6GVjMLyMdkAc7QcYuEELefw0ROAPnBBh988PFfNdjDP+URJj75AiMuYC3r1gLwswKRTbCHAO8eH18oG0OIEu/9Ma9W4aPVy5Iq1GLSTZycrAI/V56cmhdwmUixMU/lEgLSxm4KWrF4xLiHVJcH2ixnuk1zGCrmpiafuzBb1sPTI3RsR52xpUzz0wh5OCuo4dA9Sbm2asQMVL5FbF6UEQ/CPZuOgqfqA64CJwMKLZP0a/I3+Gl9MMMFsBFGW1ZtBcZpUpdOp9yzKsL+Ibuw4M3vcph2WhQcSdWmnuYf8IPe6FHzECrnI8Vb8RLgtZv1c+5YcnWMoPImCjMp4D5ZnvHcs92NGlikzhb7Yvfbd+GYOkp0pWl4+BAcCa0FCp3oG1KTAd8zvVszrYQkgXxRDIyb/Cpzfeof/i8Co2bKHs7w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd099b0-3abc-40b3-98a5-08db5315a48e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:02.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDkzi7VIDc+YKgatrnhyPjwVYzaC+/bi1H1HhQxUt/jdbIgMquYkue5DHY1Lg04OhHgOeWYoyOdBD5mDICA7rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: K9_qDA6xQcd5R6eHVB0zpua70-04jXCW
X-Proofpoint-ORIG-GUID: K9_qDA6xQcd5R6eHVB0zpua70-04jXCW
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

Allow different formatting strings to be used when dumping the tree.
Currently supports hex and decimal.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h       |  9 +++-
 lib/maple_tree.c                 | 87 +++++++++++++++++++++-----------
 lib/test_maple_tree.c            | 10 ++--
 mm/internal.h                    |  4 +-
 mm/mmap.c                        |  8 +--
 tools/testing/radix-tree/maple.c | 12 ++---
 6 files changed, 82 insertions(+), 48 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 1fadb5f5978b6..140fb271be4a4 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -670,10 +670,15 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max);
 
 
 #ifdef CONFIG_DEBUG_MAPLE_TREE
+enum mt_dump_format {
+	mt_dump_dec,
+	mt_dump_hex,
+};
+
 extern atomic_t maple_tree_tests_run;
 extern atomic_t maple_tree_tests_passed;
 
-void mt_dump(const struct maple_tree *mt);
+void mt_dump(const struct maple_tree *mt, enum mt_dump_format format);
 void mt_validate(struct maple_tree *mt);
 void mt_cache_shrink(void);
 #define MT_BUG_ON(__tree, __x) do {					\
@@ -681,7 +686,7 @@ void mt_cache_shrink(void);
 	if (__x) {							\
 		pr_info("BUG at %s:%d (%u)\n",				\
 		__func__, __LINE__, __x);				\
-		mt_dump(__tree);					\
+		mt_dump(__tree, mt_dump_hex);				\
 		pr_info("Pass: %u Run:%u\n",				\
 			atomic_read(&maple_tree_tests_passed),		\
 			atomic_read(&maple_tree_tests_run));		\
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1e7e7249a0cf2..084868865849c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5699,7 +5699,7 @@ void *mas_store(struct ma_state *mas, void *entry)
 	trace_ma_write(__func__, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 	if (mas->index > mas->last)
-		pr_err("Error %lu > %lu %p\n", mas->index, mas->last, entry);
+		pr_err("Error %lX > %lX %p\n", mas->index, mas->last, entry);
 	MT_BUG_ON(mas->tree, mas->index > mas->last);
 	if (mas->index > mas->last) {
 		mas_set_err(mas, -EINVAL);
@@ -6753,22 +6753,33 @@ static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 
 /* Tree validations */
 static void mt_dump_node(const struct maple_tree *mt, void *entry,
-		unsigned long min, unsigned long max, unsigned int depth);
+		unsigned long min, unsigned long max, unsigned int depth,
+		enum mt_dump_format format);
 static void mt_dump_range(unsigned long min, unsigned long max,
-			  unsigned int depth)
+			  unsigned int depth, enum mt_dump_format format)
 {
 	static const char spaces[] = "                                ";
 
-	if (min == max)
-		pr_info("%.*s%lu: ", depth * 2, spaces, min);
-	else
-		pr_info("%.*s%lu-%lu: ", depth * 2, spaces, min, max);
+	switch(format) {
+	case mt_dump_hex:
+		if (min == max)
+			pr_info("%.*s%lx: ", depth * 2, spaces, min);
+		else
+			pr_info("%.*s%lx-%lx: ", depth * 2, spaces, min, max);
+		break;
+	default:
+	case mt_dump_dec:
+		if (min == max)
+			pr_info("%.*s%lu: ", depth * 2, spaces, min);
+		else
+			pr_info("%.*s%lu-%lu: ", depth * 2, spaces, min, max);
+	}
 }
 
 static void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
-			  unsigned int depth)
+			  unsigned int depth, enum mt_dump_format format)
 {
-	mt_dump_range(min, max, depth);
+	mt_dump_range(min, max, depth, format);
 
 	if (xa_is_value(entry))
 		pr_cont("value %ld (0x%lx) [%p]\n", xa_to_value(entry),
@@ -6782,7 +6793,8 @@ static void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
 }
 
 static void mt_dump_range64(const struct maple_tree *mt, void *entry,
-			unsigned long min, unsigned long max, unsigned int depth)
+		unsigned long min, unsigned long max, unsigned int depth,
+		enum mt_dump_format format)
 {
 	struct maple_range_64 *node = &mte_to_node(entry)->mr64;
 	bool leaf = mte_is_leaf(entry);
@@ -6790,8 +6802,16 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 	int i;
 
 	pr_cont(" contents: ");
-	for (i = 0; i < MAPLE_RANGE64_SLOTS - 1; i++)
-		pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+	for (i = 0; i < MAPLE_RANGE64_SLOTS - 1; i++) {
+		switch(format) {
+		case mt_dump_hex:
+			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
+			break;
+		default:
+		case mt_dump_dec:
+			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+		}
+	}
 	pr_cont("%p\n", node->slot[i]);
 	for (i = 0; i < MAPLE_RANGE64_SLOTS; i++) {
 		unsigned long last = max;
@@ -6804,24 +6824,32 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 			break;
 		if (leaf)
 			mt_dump_entry(mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 		else if (node->slot[i])
 			mt_dump_node(mt, mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 
 		if (last == max)
 			break;
 		if (last > max) {
-			pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+			switch(format) {
+			case mt_dump_hex:
+				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
 					node, last, max, i);
-			break;
+				break;
+			default:
+			case mt_dump_dec:
+				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+					node, last, max, i);
+			}
 		}
 		first = last + 1;
 	}
 }
 
 static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
-			unsigned long min, unsigned long max, unsigned int depth)
+	unsigned long min, unsigned long max, unsigned int depth,
+	enum mt_dump_format format)
 {
 	struct maple_arange_64 *node = &mte_to_node(entry)->ma64;
 	bool leaf = mte_is_leaf(entry);
@@ -6846,10 +6874,10 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 			break;
 		if (leaf)
 			mt_dump_entry(mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 		else if (node->slot[i])
 			mt_dump_node(mt, mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 
 		if (last == max)
 			break;
@@ -6863,13 +6891,14 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 }
 
 static void mt_dump_node(const struct maple_tree *mt, void *entry,
-		unsigned long min, unsigned long max, unsigned int depth)
+		unsigned long min, unsigned long max, unsigned int depth,
+		enum mt_dump_format format)
 {
 	struct maple_node *node = mte_to_node(entry);
 	unsigned int type = mte_node_type(entry);
 	unsigned int i;
 
-	mt_dump_range(min, max, depth);
+	mt_dump_range(min, max, depth, format);
 
 	pr_cont("node %p depth %d type %d parent %p", node, depth, type,
 			node ? node->parent : NULL);
@@ -6880,15 +6909,15 @@ static void mt_dump_node(const struct maple_tree *mt, void *entry,
 			if (min + i > max)
 				pr_cont("OUT OF RANGE: ");
 			mt_dump_entry(mt_slot(mt, node->slot, i),
-					min + i, min + i, depth);
+					min + i, min + i, depth, format);
 		}
 		break;
 	case maple_leaf_64:
 	case maple_range_64:
-		mt_dump_range64(mt, entry, min, max, depth);
+		mt_dump_range64(mt, entry, min, max, depth, format);
 		break;
 	case maple_arange_64:
-		mt_dump_arange64(mt, entry, min, max, depth);
+		mt_dump_arange64(mt, entry, min, max, depth, format);
 		break;
 
 	default:
@@ -6896,16 +6925,16 @@ static void mt_dump_node(const struct maple_tree *mt, void *entry,
 	}
 }
 
-void mt_dump(const struct maple_tree *mt)
+void mt_dump(const struct maple_tree *mt, enum mt_dump_format format)
 {
 	void *entry = rcu_dereference_check(mt->ma_root, mt_locked(mt));
 
 	pr_info("maple_tree(%p) flags %X, height %u root %p\n",
 		 mt, mt->ma_flags, mt_height(mt), entry);
 	if (!xa_is_node(entry))
-		mt_dump_entry(entry, 0, 0, 0);
+		mt_dump_entry(entry, 0, 0, 0, format);
 	else if (entry)
-		mt_dump_node(mt, entry, 0, mt_node_max(entry), 0);
+		mt_dump_node(mt, entry, 0, mt_node_max(entry), 0, format);
 }
 EXPORT_SYMBOL_GPL(mt_dump);
 
@@ -6958,7 +6987,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 						mas_mn(mas), i,
 						mas_get_slot(mas, i), gap,
 						p_end, p_start);
-					mt_dump(mas->tree);
+					mt_dump(mas->tree, mt_dump_hex);
 
 					MT_BUG_ON(mas->tree,
 						gap != p_end - p_start + 1);
@@ -6991,7 +7020,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 	MT_BUG_ON(mas->tree, max_gap > mas->max);
 	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
 		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
-		mt_dump(mas->tree);
+		mt_dump(mas->tree, mt_dump_hex);
 	}
 
 	MT_BUG_ON(mas->tree,
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f1db333270e9f..d6929270dd36a 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -219,7 +219,7 @@ static noinline void check_rev_seq(struct maple_tree *mt, unsigned long max,
 #ifndef __KERNEL__
 	if (verbose) {
 		rcu_barrier();
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_dec);
 		pr_info(" %s test of 0-%lu %luK in %d active (%d total)\n",
 			__func__, max, mt_get_alloc_size()/1024, mt_nr_allocated(),
 			mt_nr_tallocated());
@@ -248,7 +248,7 @@ static noinline void check_seq(struct maple_tree *mt, unsigned long max,
 #ifndef __KERNEL__
 	if (verbose) {
 		rcu_barrier();
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_dec);
 		pr_info(" seq test of 0-%lu %luK in %d active (%d total)\n",
 			max, mt_get_alloc_size()/1024, mt_nr_allocated(),
 			mt_nr_tallocated());
@@ -893,7 +893,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 #if DEBUG_ALLOC_RANGE
 		pr_debug("\tInsert %lu-%lu\n", range[i] >> 12,
 			 (range[i + 1] >> 12) - 1);
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_hex);
 #endif
 		check_insert_range(mt, range[i] >> 12, (range[i + 1] >> 12) - 1,
 				xa_mk_value(range[i] >> 12), 0);
@@ -934,7 +934,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 				xa_mk_value(req_range[i] >> 12)); /* pointer */
 		mt_validate(mt);
 #if DEBUG_ALLOC_RANGE
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_hex);
 #endif
 	}
 
@@ -1572,7 +1572,7 @@ static noinline void check_node_overwrite(struct maple_tree *mt)
 		mtree_test_store_range(mt, i*100, i*100 + 50, xa_mk_value(i*100));
 
 	mtree_test_store_range(mt, 319951, 367950, NULL);
-	/*mt_dump(mt); */
+	/*mt_dump(mt, mt_dump_dec); */
 	mt_validate(mt);
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 68410c6d97aca..4c195920f5656 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1051,13 +1051,13 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree);
+		mt_dump(vmi->mas.tree, mt_dump_hex);
 	}
 	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
 		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree);
+		mt_dump(vmi->mas.tree, mt_dump_hex);
 	}
 #endif
 
diff --git a/mm/mmap.c b/mm/mmap.c
index e96f96c69c342..76eaf12f13903 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -301,7 +301,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 extern void mt_validate(struct maple_tree *mt);
-extern void mt_dump(const struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt, enum mt_dump_format fmt);
 
 /* Validate the maple tree */
 static void validate_mm_mt(struct mm_struct *mm)
@@ -323,18 +323,18 @@ static void validate_mm_mt(struct mm_struct *mm)
 			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
 
-			mt_dump(mas.tree);
+			mt_dump(mas.tree, mt_dump_hex);
 			if (vma_mt->vm_end != mas.last + 1) {
 				pr_err("vma: %p vma_mt %lu-%lu\tmt %lu-%lu\n",
 						mm, vma_mt->vm_start, vma_mt->vm_end,
 						mas.index, mas.last);
-				mt_dump(mas.tree);
+				mt_dump(mas.tree, mt_dump_hex);
 			}
 			VM_BUG_ON_MM(vma_mt->vm_end != mas.last + 1, mm);
 			if (vma_mt->vm_start != mas.index) {
 				pr_err("vma: %p vma_mt %p %lu - %lu doesn't match\n",
 						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
-				mt_dump(mas.tree);
+				mt_dump(mas.tree, mt_dump_hex);
 			}
 			VM_BUG_ON_MM(vma_mt->vm_start != mas.index, mm);
 		}
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 75df543e019c9..ebcb3faf85ea9 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -1054,7 +1054,7 @@ static noinline void check_erase2_testset(struct maple_tree *mt,
 		if (entry_count)
 			MT_BUG_ON(mt, !mt_height(mt));
 #if check_erase2_debug > 1
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_hex);
 #endif
 #if check_erase2_debug
 		pr_err("Done\n");
@@ -1085,7 +1085,7 @@ static noinline void check_erase2_testset(struct maple_tree *mt,
 		mas_for_each(&mas, foo, ULONG_MAX) {
 			if (xa_is_zero(foo)) {
 				if (addr == mas.index) {
-					mt_dump(mas.tree);
+					mt_dump(mas.tree, mt_dump_hex);
 					pr_err("retry failed %lu - %lu\n",
 						mas.index, mas.last);
 					MT_BUG_ON(mt, 1);
@@ -34513,7 +34513,7 @@ static void *rcu_reader_rev(void *ptr)
 			if (mas.index != r_start) {
 				alt = xa_mk_value(index + i * 2 + 1 +
 						  RCU_RANGE_COUNT);
-				mt_dump(test->mt);
+				mt_dump(test->mt, mt_dump_dec);
 				printk("Error: %lu-%lu %p != %lu-%lu %p %p line %d i %d\n",
 				       mas.index, mas.last, entry,
 				       r_start, r_end, expected, alt,
@@ -35784,10 +35784,10 @@ void farmer_tests(void)
 	struct maple_node *node;
 	DEFINE_MTREE(tree);
 
-	mt_dump(&tree);
+	mt_dump(&tree, mt_dump_dec);
 
 	tree.ma_root = xa_mk_value(0);
-	mt_dump(&tree);
+	mt_dump(&tree, mt_dump_dec);
 
 	node = mt_alloc_one(GFP_KERNEL);
 	node->parent = (void *)((unsigned long)(&tree) | 1);
@@ -35797,7 +35797,7 @@ void farmer_tests(void)
 	node->mr64.pivot[1] = 1;
 	node->mr64.pivot[2] = 0;
 	tree.ma_root = mt_mk_node(node, maple_leaf_64);
-	mt_dump(&tree);
+	mt_dump(&tree, mt_dump_dec);
 
 	node->parent = ma_parent_ptr(node);
 	ma_free_rcu(node);
-- 
2.39.2

