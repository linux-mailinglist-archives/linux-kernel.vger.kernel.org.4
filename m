Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662746EE4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjDYPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjDYPiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:38:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532D2CC39
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:38:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDhp48001833;
        Tue, 25 Apr 2023 14:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=mwgxS4v/JFSCwGiJrJKZtRQ4wYxr/0cEbmcARTsSEO0=;
 b=HO/t7gIMzf0YzSG+ozsRk2nfhw3Lwz62xpZ2JA+wHP17FPAQE+agjwlnf7BeLhmqrgfc
 PgJPqRnxuXyk5bTSF56N2B8Xz1/VHEnbRjhs37yU3dnTWU1bPLuXX9iSEZkkATgKBsZ1
 rmdf/pz8loZh9iY8WG1bnPNZcxDAspvMV6LNrzfFV7HUQsEv+ItfqxEQdD/+mFKAnwBT
 AE33bIkZ5zvKcehx6HgTa2wezgMluWjz6ML0w7+OUq8+kG7rLjGU+1QZc+8RMlUtFzke
 NJPKVWmLdzbUOTzHZrZoluHxofDENpwZxI+GeMy2RgA0Ce5MD7cx8oHJfgygMD1+QLIh Rw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47mcwfeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDt2Y1008641;
        Tue, 25 Apr 2023 14:11:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616qpmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOptfW7TqT9Q4zrXfd7n9NUEdxgsMiZls3y+ed73EaaPmv2PB2Bc/6QqBfZB8GxJ2CityXesp8cNFiesoZsFXI21b1Pna+WxAKgOP8E0VMUxwWNrW+agdkCC/QWfwLyBqLbuSXRtsbAE9FNV49kjDTRLNupLI3Hp+en1mPX0f/ZxXKwAyMqp9FTUDn5wo0iNuEAoKehBeEHSG1SSQDTKfU0a2khH5LwENVN4GJhEIx3CncNYpzksCS1kL8Hx76AknWoZ/kuTS/oDZISvoaziBaxs3RifZNMr0YlhXZlnnp4vUr7uScnnBe2EFS1MDSZoMU1mT1evudQ/ufjdGaEjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwgxS4v/JFSCwGiJrJKZtRQ4wYxr/0cEbmcARTsSEO0=;
 b=mZpxxoYuYRDCrag36OtrZ0yZfzOElmebwhjRImhjQ2i4OdDs4Pp4SV8WqDRAr4onrfdVSsImZFyFPzPJJnQsstsCcocwixfBSLn171S/dAkyBj5RQeXNmGhHRNNXlbDY7Fz2S2HR8uhGbNiChsRtos0Gg7Cw/olpeNc6If6y2vouMHe5EE+1l7xYhLA5jZohvsz4dgeYxFJX0ReTVBZ9MCiOM2BDjIlzZ1Lu3wGQKXy67kLr91mGON+beBJCfjsGxgGJuhxvZnGti2xz0A3Pt/pwTsiwrIcAMIHO+in2EP73F6HAx6ERn78QpuoIxIcaUJ3zfconuyCyd7IxudFCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwgxS4v/JFSCwGiJrJKZtRQ4wYxr/0cEbmcARTsSEO0=;
 b=FqnIJ1LewCDYvSvVa+3K613WBDkiYP94Y0gufhVBq02DMbJT0awxkrllf2qnml3He+/c0XOEGDyWHqrQmZ9j6tFCnH+21+9xG6VGx9fCekWbfZqoe/g9iyfP2iUVfPfr9v2FOxU3fNthiFWduU4DHulG4Oa8zxTCYJLxxkjAWj4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:25 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 27/34] maple_tree: Introduce mas_next_slot() interface
Date:   Tue, 25 Apr 2023 10:09:48 -0400
Message-Id: <20230425140955.3834476-28-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0192.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cf6e67-e905-46a8-1aba-08db4596f456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enmu3md3v2fiEIRsk+qdbGSsKc8zYdrnjbo0+vNCruFrdgOdRK7QgJ7flEt2gM4SJo9cQr63IfCwHWxdHgwvTBMAOqltZ38Z9BsenlYMxMGfykm01YzE3nw8B3Qlgsd4GeoqWpVIruFejaPU6v1JS61z7KdYojj8+gRq9bokWfFldOSvkHAPJtcyg6oOpFnDEWgN6/8tq7uvfMHCMOxWhMsIPc4+EFXX1TVDTyxYbliYS90ITPdabqDZz+FiQ8wPy4iQyOb9aQ6H2iSJ24m4BtvafuwNFh6aZmrRGq4kOKzfebCjCGSsDezTywrnXgyQwp3W+NXEAvKrhVxWaUv7YzNIOkmGVaoGX38/f/xIkScJvIyZg1xd8MvcoYmaic2yQnxfB9JWzuxtkBsKOR2xIjbS8h6xT2cVZwrqppIdgNeJgF7syBIPGsPRuhAHYhNCdH9bpbOv2m5gXa9TkmbGZHZATJ3BWmmWNy7Ya5TDR/LokuW9Ezs6Dp7gU8MLDj76C1le3rIBvMbR51cdG5r4yXbdGaWd95AHbjnf/mUW2yMX/jNBD4AO1mmZkYDsyzyV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(36756003)(107886003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(38100700002)(8676002)(41300700001)(5660300002)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l8nUKj8cnxc7XfYs/+TFxzE2eaZyVxMpzwf0oFiGHCuRoCOCoQxdZEq1kGWY?=
 =?us-ascii?Q?qLIGnOMN8nhqFE5c7TnIJOdEjE4S97yQveV13mLmt+YFgnTbSl9EOO16JKO1?=
 =?us-ascii?Q?6wRKtnxAIntdacUFncRIRxvgAJmX1r6uC3gCzHy8b0ftr18z/6Rshuq8qp2g?=
 =?us-ascii?Q?3SgFP9qPJWJhJYNaq0ct4IfMLGoYxNhZzQMNUYRKHm1pnlRRY6HxAcrEYMOP?=
 =?us-ascii?Q?1OPasellDBiXB6tOYNavxXWPrWJXSkU0988bI/nhme+dCz87nZb2g52rR1Vd?=
 =?us-ascii?Q?YcOiiG5eyV9WaWiFiS3SOU7IHuHwD5SDHaZMgcJ7YIWZiONAzRAt5kHNOR/S?=
 =?us-ascii?Q?DFz6LKE0oivBJ/NZs4qWGEnIuUgRaizOnvIYc5BhQRgdfzbnvgkQINp5A9Bi?=
 =?us-ascii?Q?syecjHwIYJtd6wnKXZ9RGF/egqLDoIH7g3jP/aZnjt37eHsxF4uKF3+8/oUw?=
 =?us-ascii?Q?R85Y9V4GbzFkitdmXjvIUczd5bfvFO+IxoVhKx2SfYATtsD55xZbBXn2gTcE?=
 =?us-ascii?Q?R1w/TELkGHP+w8FwZxECX5QY2sySRwiVmo4jDQrmHzXG2HzmXWfOyRqMju9B?=
 =?us-ascii?Q?rwW3ICFyxm9EvQjjITNb5C1MHLYuGTxKbOw8JiGfHKE+LwY3OJQgbNa19fuF?=
 =?us-ascii?Q?6W3DyVlxPXKPo55hUP1OcS1DT9LkudmYxKl9PCM7oTMdpCrxLFHV1SmqEtMv?=
 =?us-ascii?Q?oPWIGL6zL2j5KCp3hZbCmerPyyRqrKGKiegVNxAaGeYaYEdV1aodlSlpp9uH?=
 =?us-ascii?Q?yTcu+JME/8BXoEDoNfQ6mP/QO68wtLQem49w+3mXaEcPdpP+ENwTytpu8c7b?=
 =?us-ascii?Q?u/fWRJ7D30GmczVzvwNNU9DHDXlbPsn/CktENqvSguXR7X7bkKVyjR9pCvmQ?=
 =?us-ascii?Q?Fic8mAPJPLcnQmE7HCiZsSgXVNsPg2eCBsZfNZ2WGM2NsEP+tVOO48sJWA+j?=
 =?us-ascii?Q?6jtWe9uPp4FduMOOBVUrV0YCqKvprkg6t1hR8XmtIIDhy+PxU4FL/snUy7U0?=
 =?us-ascii?Q?lCNPl/HgHeovIuV3cG1+fstIDH9KglauSp39YInFYlJlmXI3nEZ/QaV2wSU6?=
 =?us-ascii?Q?o9ldr7wWaT+Di2aVDT1f3167jy1ZwDBsvdK0XXXQ2a7N8Lvy9vyIiGnjFnp5?=
 =?us-ascii?Q?Ae136FcOvayC+xwTNseo14qZUDeJT4LYF3s9NCQ2ThZIK6WvR38GZZgItLq8?=
 =?us-ascii?Q?Xd48WfLpXSKrheNBYte2KZzuxmisawgVwiAP79SLb8iZA3K5qru8sC6JssGy?=
 =?us-ascii?Q?X6UgrOo06e7S+6tE9X8eRkMrTuB2YxXUkWefU6/8Kjk07zJAJNmnhZJkOBxo?=
 =?us-ascii?Q?3QQgaywa1rIG5iffIvNYfICMvyF3ypLLp3xkmMOhaEydlB3PzC10tMbiANNF?=
 =?us-ascii?Q?9k1ffuHQ0RF0NfoCWMHvmQtrot/OhQrenBHjNW6Etn7UqUj8mXabg9w+3aiE?=
 =?us-ascii?Q?+eU4jBpIPM5ieOIZRqu07DOdoRHeg3basUPbIIGyhkET75o9alLMSlwmNYBJ?=
 =?us-ascii?Q?flXZGQ1MqOkqj3bY+2IGDF502Mwf26dtHJMd3zHYmy4HJe7AhXSg2uP5ie3S?=
 =?us-ascii?Q?+KeBayuiRcGTtT64y++ScgHCTiH5qy6E5d9/r2I1wnxe5vzBj1gw0+d511iw?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oUBhhkJ3Y8g9gRMOjHt3whFMj6A0fFY0pI5x+X6lY+NZhXutGdz6+A9HWv7xigpgNDlIDNWFrV2ZcKImUeAwQY+YbUajNLjhU64s3A/O8n3gS9zQGqdr2h7vmG3B/4n1jO+IW7Ik3xxNySsBoHLGaZ9Y4P6FjvzM4D6n/PxvEznKNP6MBNvk8u7dK0szhCiNS4tuQzbsW89B/lHmbhiSMy+SpAllJU5A12P7DKQfQMIGVgrEi+plFj//bdB7qW4Y2ENh3O9CnWRTTEuqnTL5vZNyLImCr4t/OWmYSMC48iCa8oLYUjrnWxHmZrZlEQ1y47s9ZMLWUCq6SDeudDpebXlamXv3WBUWhRH2yObxfsDrWnHeLVRmTvCJh1KRZoA+lJ7usLxJ8poqw1EBiJWp3FXrwjWKkLJkw9eloNMxLB3sSmQckj+FdbMRMi6/un+bYUcH0bIKzi6wHZDuTWNJnDycLQVmtOf43QRv9rsOBsUQvBDnHR+e7gasxySTQDBTgYsxV27kUwc0rq6D1YYHvyJdL9CZ3+Zo36Hs8mMwdQGnDt8JqDyhzQFgOQjA0plD0kEN0rdmIjUgylhlJ1feaMTtZOUDHWyX3gR6Hd0UBAPUdcTeM4xscIY+CkxfUxqAfFgB2R9ZJKCKY/UjBjqOBxO2cdpScp+PIOXULrtGGvT5oPRcOoxRzKCmT454cstt9hMWm7Kzh4g/VCfIpe2BQuBvDXeFClGAY0YXVSL5WEvPWg6rZVTdgDRqAibZ4fXpRrRmYF/93ITy4XABnS6YsqaquG6UYZNdRvod2h5GM8civBnjYcnwLy3Mtjidw54BDHeM1v9Bvk0HczIHcD17GU2zDMySKKPcfE9Z/cSDc/5dIklVYcMYNrPaEOG0yaQpqsR5BbbLscSHMe+bfcB86g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cf6e67-e905-46a8-1aba-08db4596f456
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:25.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpFWD+cwwl6NmAG9A9+jaO6yC9utag5yYXiHGIihob53SbljDNxf5i4VtdqIIvVAQsRSiF0QyO1GFCqAfQvKew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: t8F04wz0Ftsm1O74C-L1CQ6UaNqG7mCN
X-Proofpoint-ORIG-GUID: t8F04wz0Ftsm1O74C-L1CQ6UaNqG7mCN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, during a tree walk, the user needs the next slot regardless
of if it is empty or not.  Add an interface to get the next slot.

Since there are no consecutive NULLs allowed in the tree, the mas_next()
function can only advance two slots at most.  So use the new
mas_next_slot() interface to align both implementations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 178 +++++++++++++++++++----------------------------
 1 file changed, 71 insertions(+), 107 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 31cbfd7b44728..fe6c9da6f2bd5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4619,15 +4619,16 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	if (mas->max >= max)
 		goto no_entry;
 
+	min = mas->max + 1;
+	if (min > max)
+		goto no_entry;
+
 	level = 0;
 	do {
 		if (ma_is_root(node))
 			goto no_entry;
 
-		min = mas->max + 1;
-		if (min > max)
-			goto no_entry;
-
+		/* Walk up. */
 		if (unlikely(mas_ascend(mas)))
 			return 1;
 
@@ -4645,13 +4646,12 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	slots = ma_slots(node, mt);
 	pivot = mas_safe_pivot(mas, pivots, ++offset, mt);
 	while (unlikely(level > 1)) {
-		/* Descend, if necessary */
+		level--;
 		enode = mas_slot(mas, slots, offset);
 		if (unlikely(ma_dead_node(node)))
 			return 1;
 
 		mas->node = enode;
-		level--;
 		node = mas_mn(mas);
 		mt = mte_node_type(mas->node);
 		slots = ma_slots(node, mt);
@@ -4680,85 +4680,84 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	return 0;
 }
 
+static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
+{
+retry:
+	mas_set(mas, index);
+	mas_state_walk(mas);
+	if (mas_is_start(mas))
+		goto retry;
+}
+
+static inline bool mas_rewalk_if_dead(struct ma_state *mas,
+		struct maple_node *node, const unsigned long index)
+{
+	if (unlikely(ma_dead_node(node))) {
+		mas_rewalk(mas, index);
+		return true;
+	}
+	return false;
+}
+
 /*
- * mas_next_nentry() - Get the next node entry
- * @mas: The maple state
- * @max: The maximum value to check
- * @*range_start: Pointer to store the start of the range.
+ * mas_next_slot() - Get the entry in the next slot
  *
- * Sets @mas->offset to the offset of the next node entry, @mas->last to the
- * pivot of the entry.
+ * @mas: The maple state
+ * @max: The maximum starting range
  *
- * Return: The next entry, %NULL otherwise
+ * Return: The entry in the next slot which is possibly NULL
  */
-static inline void *mas_next_nentry(struct ma_state *mas,
-	    struct maple_node *node, unsigned long max, enum maple_type type)
+void *mas_next_slot(struct ma_state *mas, unsigned long max)
 {
-	unsigned char count;
-	unsigned long pivot;
-	unsigned long *pivots;
 	void __rcu **slots;
+	unsigned long *pivots;
+	unsigned long pivot;
+	enum maple_type type;
+	struct maple_node *node;
+	unsigned char data_end;
+	unsigned long save_point = mas->last;
 	void *entry;
 
-	if (mas->last == mas->max) {
-		mas->index = mas->max;
-		return NULL;
-	}
-
-	slots = ma_slots(node, type);
+retry:
+	node = mas_mn(mas);
+	type = mte_node_type(mas->node);
 	pivots = ma_pivots(node, type);
-	count = ma_data_end(node, type, pivots, mas->max);
-	if (unlikely(ma_dead_node(node)))
-		return NULL;
-
-	mas->index = mas_safe_min(mas, pivots, mas->offset);
-	if (unlikely(ma_dead_node(node)))
-		return NULL;
-
-	if (mas->index > max)
-		return NULL;
+	data_end = ma_data_end(node, type, pivots, mas->max);
+	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
 
-	if (mas->offset > count)
+	if (pivot >= max)
 		return NULL;
 
-	while (mas->offset < count) {
-		pivot = pivots[mas->offset];
-		entry = mas_slot(mas, slots, mas->offset);
-		if (ma_dead_node(node))
-			return NULL;
-
-		mas->last = pivot;
-		if (entry)
-			return entry;
-
-		if (pivot >= max)
-			return NULL;
+	if (likely(data_end > mas->offset)) {
+		mas->offset++;
+		mas->index = mas->last + 1;
+	} else  {
+		if (mas_next_node(mas, node, max)) {
+			mas_rewalk(mas, save_point);
+			goto retry;
+		}
 
-		if (pivot >= mas->max)
+		if (mas_is_none(mas))
 			return NULL;
 
-		mas->index = pivot + 1;
-		mas->offset++;
+		mas->offset = 0;
+		mas->index = mas->min;
+		node = mas_mn(mas);
+		type = mte_node_type(mas->node);
+		pivots = ma_pivots(node, type);
 	}
 
-	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
+	slots = ma_slots(node, type);
+	mas->last = mas_logical_pivot(mas, pivots, mas->offset, type);
 	entry = mas_slot(mas, slots, mas->offset);
-	if (ma_dead_node(node))
-		return NULL;
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
 
-	mas->last = pivot;
 	return entry;
 }
 
-static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
-{
-retry:
-	mas_set(mas, index);
-	mas_state_walk(mas);
-	if (mas_is_start(mas))
-		goto retry;
-}
-
 /*
  * mas_next_entry() - Internal function to get the next entry.
  * @mas: The maple state
@@ -4774,47 +4773,18 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
 	void *entry = NULL;
-	struct maple_node *node;
-	unsigned long last;
-	enum maple_type mt;
 
 	if (mas->last >= limit)
 		return NULL;
 
-	last = mas->last;
-retry:
-	node = mas_mn(mas);
-	mt = mte_node_type(mas->node);
-	mas->offset++;
-	if (unlikely(mas->offset >= mt_slots[mt])) {
-		mas->offset = mt_slots[mt] - 1;
-		goto next_node;
-	}
-
-	while (!mas_is_none(mas)) {
-		entry = mas_next_nentry(mas, node, limit, mt);
-		if (unlikely(ma_dead_node(node))) {
-			mas_rewalk(mas, last);
-			goto retry;
-		}
-
-		if (likely(entry))
-			return entry;
-
-		if (unlikely((mas->last >= limit)))
-			return NULL;
+	entry = mas_next_slot_limit(mas, limit);
+	if (entry)
+		return entry;
 
-next_node:
-		if (unlikely(mas_next_node(mas, node, limit))) {
-			mas_rewalk(mas, last);
-			goto retry;
-		}
-		mas->offset = 0;
-		node = mas_mn(mas);
-		mt = mte_node_type(mas->node);
-	}
+	if (mas_is_none(mas))
+		return NULL;
 
-	return NULL;
+	return mas_next_slot_limit(mas, limit);
 }
 
 /*
@@ -4845,10 +4815,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 	slots = ma_slots(mn, mt);
 	pivots = ma_pivots(mn, mt);
 	count = ma_data_end(mn, mt, pivots, mas->max);
-	if (unlikely(ma_dead_node(mn))) {
-		mas_rewalk(mas, index);
+	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
 		goto retry;
-	}
 
 	offset = mas->offset - 1;
 	if (offset >= mt_slots[mt])
@@ -4861,10 +4829,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 		pivot = pivots[offset];
 	}
 
-	if (unlikely(ma_dead_node(mn))) {
-		mas_rewalk(mas, index);
+	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
 		goto retry;
-	}
 
 	while (offset && !mas_slot(mas, slots, offset)) {
 		pivot = pivots[--offset];
@@ -4881,10 +4847,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 
 	min = mas_safe_min(mas, pivots, offset);
 	entry = mas_slot(mas, slots, offset);
-	if (unlikely(ma_dead_node(mn))) {
-		mas_rewalk(mas, index);
+	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
 		goto retry;
-	}
 
 	mas->offset = offset;
 	mas->last = pivot;
-- 
2.39.2

