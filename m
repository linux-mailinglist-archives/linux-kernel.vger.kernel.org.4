Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF372D0D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjFLUmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237708AbjFLUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:41:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363641701
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:41:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNjIO016697;
        Mon, 12 Jun 2023 20:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=snKjq27RM8dqWHzAhSVOgtEZhiI/iMNdvGiktQzMQd8=;
 b=c71P8umqopReDsc+/LEvNtY8JWN5T+GWMseD3F7YAXegccXzUepoOxyKdJmkbAbHwOUv
 JaiLtffm2A+6um27Yx51EC4PiZUln5suyCuNp9nsHYyhgp3BihYXXocLX+qBu8DQDTjT
 jYVANBc7y4TP6gslQJ9dUKUu+ipr3AH0+bNb2f6+oYsuEIykNHfc0cfIK95bjf3vyj5/
 tCExRgBgjONzYTp6M1POQg1Dw2Qxo/cpxBYxwytku8FHpYg6zLQ5Cn3uBzlM1AuR0C9X
 Pxmpz5ZeIb+0ZVtzxeyZVky87YMKn326wTN1MID96qpSoDN+nPX2YC3MDwO3AWZElUWA Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3busw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKR0p3021624;
        Mon, 12 Jun 2023 20:40:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm39c65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDUtXVlCUPla+VLTvWnNyHKoshBlPR0SeRFsVUrcCrK7GAyze+91oZamQ444sbG5E3DG1UYePw3W8zypiaVEpR0LTS6YgYbVaPACEIDKwXBDupuexI4uUpaK7JcHquqQsgj7Qzb+9kUW6AiIVX1D7YgVLqaZBgNaTRwYrex6QFusfpDLLmF8HjB7WjmurBQtbLCcbJrpnAgVQJo0IpYTSNfYPEldb7Syb7DT2ZDb4EN2oh9cIECPlCy53+Y94MvKwc/quDjDuUz21+i6HcTtHdhNembqRkfoOqMxtvegDusTv8MZXb35AEa9rRKat6VjAQHJrppZvC4sVDsijhNS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snKjq27RM8dqWHzAhSVOgtEZhiI/iMNdvGiktQzMQd8=;
 b=bjkl8TO76Cu0NT1ZbbAOMJHVmt05QwTcVwMlRri2WqUS9nl3OMJC2g7MtqD4QdOaTZOQjF9n5/sGtvd5b5Svn2WMpron5x0+Q6Gl4D/++N4vtxFQG8Sf+usGPCXwuZvhDyKjcLKpLublT2cgMzaYkHk1iKS20gboM/0RQUDUndTnPl4g5TKhPp9JMB1F8ZlyO4FEhaEgdJsdAFA9ZvR4YqAPgZR74YZ52PSdgz5PYW3gdzwfFDL9+o7sTcVtAXHpQMjbZDygtwOnhbGKcIQ73YpuWoEnPKPn0phQUAmDTtauEbPKz3UWjQmYobXlDMGoY4nmLNooC+w2IRkHqVvs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snKjq27RM8dqWHzAhSVOgtEZhiI/iMNdvGiktQzMQd8=;
 b=vl7za7F04flOtzxN1/+Wr+dhkdOqPTKj7xlCwVguCEDbPrMMX3o/ONajnSbfx4l4n4k9eltVDTujjMuf7vMc54wDi/E3GtQmAwR1taOCUAr5uJGl6/3TURHKZIkrZor1udPDQ8vpuGmSCEYTUyruzpeVKqyI1a+hwTLOsvAs020=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:38 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 15/16] maple_tree: Reduce resets during store setup
Date:   Mon, 12 Jun 2023 16:39:52 -0400
Message-Id: <20230612203953.2093911-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0032.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: d2216350-4a94-41a1-61ee-08db6b8547f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POvHcYbU4hxCYhlAUFaALZiOqaQvJZR1pugXSnNbvBlsGu2Ku+zuYG0X9T5g03j2icymXN6u+oiXF5nM8Vxu50rlmYZS3YfM0TdUl7UAPvz53TdbOwcZYYudqSHiqbZDhFI6Ds4vIr3p0u/rsR9cBDIi1tg8bZqa0G71s3wm0AFkPV94rVNqA7G6zZ71HxRiJD2xZKmS+YCu5Kz7Iry8eI/otQw44zm0m1+oMWc+YagapBKhu6mOXfW9nEIFTPc07SiX/5I8fux6ViPhyMn6MYjVNbcprX641jwhmhOPmMG2a8PuSwQlFnOKmqBK3mUNCX/O0TDLmmsLjx1MLS2gBg2+CmV/HUdV+5pPssyFsNN7hYa+n5WuAdDSVrrlzNJtc2MS0ij8QR6FI9ay8Knna/oaRCX5qtEa80y8XficYEl2d6QCd3rG/w00P8vL+85sZ+YiqkPxVbKQahox9m+g/JeKUylO1JFk3mQwgCeg3Y4k7M9s8jQljXCiawySYFDrEfIihh4FWWUXvobfz5oodLC7Gjw+/zYP4hcwJMXxlWBuQgUFz0YIXlYCo730aQ1J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(36756003)(2906002)(86362001)(107886003)(6666004)(186003)(6486002)(83380400001)(6506007)(1076003)(6512007)(5660300002)(26005)(478600001)(54906003)(66946007)(316002)(66556008)(2616005)(4326008)(6916009)(66476007)(41300700001)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2mQ/oh7isaiFOkgw3Kxpz6BZ0zr9Eg0i53xGI5JUGoXbewbkxfTp+8W1J2v?=
 =?us-ascii?Q?j26a8vxClopaI5CkdhQHIao/Mz9DOAQa5buWYJ2JJUtvG6SYhiTrHkRY44EU?=
 =?us-ascii?Q?sE/ditpq1reIK5+Wz47FymFAbPd3SnNItVNHcx39f4Hzgfr0Qtu/AJNCkNXd?=
 =?us-ascii?Q?f/mJSyxCFb8mh5xCkBJDdBDs+gbY38M1L0+nvRnnySHqamWnt3SQIAsPBgnw?=
 =?us-ascii?Q?rw7hRMbdnrWlqGsLIlGMqKK9Cxjnnb2c3g2u8F8b/nR5jLLrsmwGC1mzYScv?=
 =?us-ascii?Q?Dx6jNyrVKFGGTsIy+V/kUnAM1//+/Unh77j4S/bJEy5V66ifHBrH21Hh6XaF?=
 =?us-ascii?Q?gfpgqPhye0wr1A3mdv25+sJ1VNfzDMTuyMYGHiJzhFruzgcbhFvh0VWvNNNK?=
 =?us-ascii?Q?qpse3lOqbCLGHovx98+qju4T55vnXcAT0QCNRLx+sHJ7fvNDboHC2AdxvZXP?=
 =?us-ascii?Q?48lC8c7Ht1FTfbsRYnC7DeqhxkrihSbOqOEIWiMf8RWe7fgTSnuD3iSKSb+T?=
 =?us-ascii?Q?8YeDqraDLnQyH5si+WD8Ux0fmCtk9gCcV0I0K5UzfNeD3ArRVkqkATI6xrue?=
 =?us-ascii?Q?5mTwJcdZ5tIASnPCk72/dKfxbtm52ko0jy7Kb/tPG2PpNYWbG+fmiJeo/j3s?=
 =?us-ascii?Q?t7+f8lnbTUbx5/Y0+Brlz0vq7KvyFjurKpflhS4ZDVJVm11paBX4KmAjZR6B?=
 =?us-ascii?Q?hATzOJC7dMhZwsppwDc6ikjkCBQldxBPSCy1dTuOrPUvXSMsRrVpzo0drH0+?=
 =?us-ascii?Q?YuG/QAlY704hAnyzC2VEPh3KMrClPGKPGYyjhrmoenb3ed37kyPpr6FDSPnJ?=
 =?us-ascii?Q?OAJi9G1z6PdUQAwVyYbGMJvwhoLa/9y+IMoQOFHXHRj9rENIx/qWFhnV+EBR?=
 =?us-ascii?Q?+VrBrtvSIbdC+S9+xHpzN1aZDZW3yrfPVR4QY4H6VVjoZJpkbs5Fg3zQ6gKV?=
 =?us-ascii?Q?AoFCI2niSoGtKM0iIXndfbP1gH3PlYcD99iTMTE1+DkIAQtpfsjgt9Erk9Us?=
 =?us-ascii?Q?NleSJrXjPB75sg0n1maBSqq9kgHMXwRtNDnxdipiFHUFnYmGHYEw663e5MHL?=
 =?us-ascii?Q?BPpzuCERbUWmPPjONTt+Sm0I2YDnN5G36Xx88kQYLHfqva2SC78zSu/UFydD?=
 =?us-ascii?Q?CB4ftAv/0ZnNuKg0K7GwkgP36UgrcSQxaJuJUKN5kEFPtTUfP73bXHmy2h/t?=
 =?us-ascii?Q?AfqTffReMSBigsEWkj3OpJIsuRnKk4+v3ziODDswihwbggVn/zgkYNhKxUvF?=
 =?us-ascii?Q?RMY82TbqDbTk+7Tqn8PBKfa1GUssIU1RjH28+enBK5A1Iaqb4WRzYjExYDyx?=
 =?us-ascii?Q?wWZluL38QsMeFm+N3GJt9ysVtbKFtJw8hOF1rVvynspdqI4syC234vWqaKab?=
 =?us-ascii?Q?nYpVYN9HCWXpCyHCzBEUv5IsbKraSnIXR9AfyKD0WbkL1+d0bPnMJ+uy/ra+?=
 =?us-ascii?Q?i/IfAcvR5n8Yekxl1OnhLHlM8f56XD9rCIle0dd8pj7YKHleag5f45/nQxT3?=
 =?us-ascii?Q?LDnCsXljfmpZf00Zi4vHm36ZLQQhmjG/F5WYfWsG2VBqDnB8jLZYaRkaxyc+?=
 =?us-ascii?Q?3TLMip+TDawYfckldZySFx03Q3K42zbeqBClglGLJAUDwRnpHqH3TUB1u7pZ?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dj7kFN4Qj8duFvRIjhC39/cGSlh2QFtnsFdJ3SXYVggtKnrgEE2X/4wmxjg6?=
 =?us-ascii?Q?oPj8a964qMz4pWS9A9O/RmWQz2nLyd1q2185OD6Jk7X4jDXMF78aUItQdV2P?=
 =?us-ascii?Q?8b9J2UAw7PNR+JNoIXuIEbb2EJOAFklmcJdiaX9u8Fi27BSMr+z5PLt+yCCS?=
 =?us-ascii?Q?TUpzb6+snEBpsBX7PNPvLXzVTjRMpvucnu7H4xidW2dYEZ+3Ap2MrfsRAxFQ?=
 =?us-ascii?Q?rNZ5fOzf3h7p9L8J0qWiqwO1hhHVdDKuqG84yzvb09AQztFA6m41SCh3tPp+?=
 =?us-ascii?Q?fCc4hcxsP/UAQL5/Dx3QRXuaMlO4i2ONti7HeXICojlglE111+bqxtb/YtVU?=
 =?us-ascii?Q?7nmprIvYjC34eDUCkdDdDmXJkl6c8ycsfE/tRrAJa4K6Ouxx8Xa+rJtOt+o4?=
 =?us-ascii?Q?0INLL2vqCNTgawVzpfhXKhTVy5a6bW7ELZ4+h35+lDQcUTRoB2fpF+gzW6e3?=
 =?us-ascii?Q?3wsRDk17SlqHTFPfPnGGQIn6tFxcswAOPWlXhHg3H+6n3twbU1yUBn1G+T4t?=
 =?us-ascii?Q?nZvW4mYBCZ63eBOpYgJRHNesGslsO/lik1sSYA+AHiq+KGUCW7v+v4CcRXK1?=
 =?us-ascii?Q?WBtOfU/VTEWAl4TgwlQxrFxG7wVAaosKYXw34ykhEa/rWYU8ApXPvZGMzt5G?=
 =?us-ascii?Q?qlhPophvM7RaFegRGKn8DLUCQ+pwyGKwQYqY1gNGULgf6EIuhjgBV4vNGvRf?=
 =?us-ascii?Q?jQ0rH00nwRDR8GijiSvCL/6J9QXXu1F4rFa/QIvOMoJ1f26/lpo7B0XhGKVz?=
 =?us-ascii?Q?HYyBUCtC9bOn1JX0165uqdw/yFh5Y/bIeEbjUgS7fLAhHJUJFVpPbFvbVRPM?=
 =?us-ascii?Q?SUywJtdDItBJDRbaV7g9UG/At7AKgcVvG/Pdex28brZ2wZJtMotuCLAhY7I8?=
 =?us-ascii?Q?RclVAfPi8oaeppUXh4doDXjycKrcG+69fHbtlCR2kx0zGVApzvISF+Au1iXk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2216350-4a94-41a1-61ee-08db6b8547f4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:38.6060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jjrt8d5YXars3mbw77kUXC2EJ6g48eyns5ChcXQ+/6ryTKWZJp8y1s16xM4EV9RYghqMmJhQ/7z2UILCfblsDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120176
X-Proofpoint-GUID: 3zdPR061FxqAdGPxSzgaCSBSWE3Q8Lhn
X-Proofpoint-ORIG-GUID: 3zdPR061FxqAdGPxSzgaCSBSWE3Q8Lhn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_prealloc() may walk partially down the tree before finding that a
split or spanning store is needed.  When the write occurs, relax the
logic on resetting the walk so that partial walks will not restart, but
walks that have gone too far (a store that affects beyond the current
node) should be restarted.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 7ac5b5457603..279b871f21a6 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5430,19 +5430,34 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 
 static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 {
+	if (mas_is_start(wr_mas->mas))
+		return;
+
 	if (unlikely(mas_is_paused(wr_mas->mas)))
-		mas_reset(wr_mas->mas);
+		goto reset;
 
-	if (!mas_is_start(wr_mas->mas)) {
-		if (mas_is_none(wr_mas->mas)) {
-			mas_reset(wr_mas->mas);
-		} else {
-			wr_mas->r_max = wr_mas->mas->max;
-			wr_mas->type = mte_node_type(wr_mas->mas->node);
-			if (mas_is_span_wr(wr_mas))
-				mas_reset(wr_mas->mas);
-		}
-	}
+	if (unlikely(mas_is_none(wr_mas->mas)))
+		goto reset;
+
+	/*
+	 * A less strict version of mas_is_span_wr() where we allow spanning
+	 * writes within this node.  This is to stop partial walks in
+	 * mas_prealloc() from being reset.
+	 */
+	if (wr_mas->mas->last > wr_mas->mas->max)
+		goto reset;
+
+	if (wr_mas->entry)
+		return;
+
+	if (mte_is_leaf(wr_mas->mas->node) &&
+	    wr_mas->mas->last == wr_mas->mas->max)
+		goto reset;
+
+	return;
+
+reset:
+	mas_reset(wr_mas->mas);
 }
 
 /* Interface */
-- 
2.39.2

