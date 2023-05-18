Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17C708471
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjERO7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjERO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A1F1726
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IlYv012447;
        Thu, 18 May 2023 14:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=BNJ/xs+tArZ3RHkKqzIfUzuJIlhPq7rBrHJ1DH2BcV4=;
 b=Y1Gn+jcuobXm3ljccfkRmC8VfoHx5KCw/ZgQtU3Dx038ZQ5LMQtQwR5aWYE3rB461Wn+
 QP++YkGYNVzV9pH++Cj9B5MCUGWW2eVaXSs9N1sTKSfMDBj0kxLegaL1FBpq1yilI5lI
 oJx5HfZmcqSvpz4BCuTQHcTXGXK/A2Elo2Qke3/dmUgP+UKE21LvoSYtK+l7bZPxaQsi
 YAePA4PL80gQ49IwnERx3BmaFm7GfAtZEIeIPeheFUBXvdzaq65GWct66tVWVZk8o129
 Yb3kFWtZTIEHnq2aHhZ0DxGSM9gZvcc4JulgKcGLD5m/W8Ee9JpfIk6ZtxTOJ2Cp8FTx jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdrh0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IEIORY036313;
        Thu, 18 May 2023 14:56:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm03w453-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFyV4ukGYF1HHc1vXl8ekSQCVAAmvC2TRhYY7qnloLtiD1WgoMHR/btC15T5RSEBQlxt9HTV68p2/RbZ8fMwP9KW9FeSZfozTeD7MOiHLwN7W1O5JCAkSPI54Kct7XEC8ymIdSAvaKAPBDkTwF8igor6KDkBl6L4FzAiKTjFjdtJ8T1v23Gn7U/aFx0pIZZyD0WUmqHul3CaSCKyqIK9eqOiWbR5t3pfT+Xq4nCMNtsmAjqisYoWRLNggUmUWPRpeh2TE3MlSr08wqPvyonPtKVhRWOaCQKXUgTDtyCHuOYKVuxY4FcVs+DAdIYRWscBoMp8dfnZpikghGqHzdWy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNJ/xs+tArZ3RHkKqzIfUzuJIlhPq7rBrHJ1DH2BcV4=;
 b=AiPDj+14LxMd4rVhNqhddFY5AnoYPBEYfGgPGTJaqoE74aQAQGRJPIA6gc9qX3VH+apsEGWoqeDaccTcNznFu0XLXWIVdIOJe8Eg04tKFM6OU+Mibcr61x4mPfLYLZREurJ3oV2fo37NoiwQTbh2Li4QwlPXVlldnXmzZN/6phEoEPXd9p26ensCV6/uW3uaQrFRSM4mmh0jl0reDnwzjIqE+7xyDiE8NpjxljHiej/JAzxiZHYlAaI/L4WLfPP+kVRi9awTDk83gNk64lkG6VcYYZLS3auKQ0oxILXZCmcJjcYDRVYZ/T+lRdUleEn5VGaV8pguyeqVc4zX56Otyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNJ/xs+tArZ3RHkKqzIfUzuJIlhPq7rBrHJ1DH2BcV4=;
 b=PixVlpEYS1ujFM2PdkRpzBer+oo4zzfpkQZ4uBonm5BEF2I4z0rbbGKyZRdZNrO7zzjB7CxB1jR0lP9oUXrVhSoi7ojOKNO2SbwZm6FeajB19uHTtbRsGT0pAXNMZWQ82ndzsd/Z757rBZ1JgkjU7CXoNMt1RcobceFHrra4AOA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:55 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 27/35] maple_tree: Introduce mas_next_slot() interface
Date:   Thu, 18 May 2023 10:55:36 -0400
Message-Id: <20230518145544.1722059-28-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: c15f59ee-ba55-4bae-3ba6-08db57b01f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8gp09koOMpXSxE8LYfvMMD9CeWo/NBVe+TA97LzyQjnnRpLNhHssIQnPlxsUw0/qtKNSKszm+n8inNENj9gq53jR1Hslb4pNvomPLex0/OwK50bNBZTY5dyHcaE9pnv+FNfomNFZZaq5O9eiS+xfSbkBXSUJsWdYxjQXjp848MjEZ3cZrDABD3y3Tjjqf6rSwwPXaEMllv4wFr/Oh9gksZUYZ1IQAx8SPJ22xlD72nyRLLCWtxb6yIroc6vfcdTOxZxAvVqQ8Wvb0hbBRLycC7M+L6VQ7xb7kQQUNiRivHT+qk/LnTm1aOiDxyDIL5WBYBRcHYBjAXwqgNQ5z0XTSsDa+K4cljHS+BC7DtfTFl2WL3dtl3ohlaJfI8OjijgpX9d2laTD9TzeGMlN2rUu8m0g4Lj3D82M/SvGqsKJDnt0itOG5lk8VMXASTZVqoLT60mehUXn4iVX3gm/Xt7TDPNp4RwXGzGg1NeB/NJ/5kKSdlsVWZZkVaQNdDm+yGiHfR0c5H1j7b/piAxTKgWzdNa/8S+2NeYX3LNjZGF0aYLJOLgC3Vt9YZB6ZYh9khp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(107886003)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wp9ye8sPn+iQjgPPIZNXsVTV3z0jYE1MGeaIOtEyGmDlF14M+jXbS5FOMJJb?=
 =?us-ascii?Q?YYdWbBg2DUf26r5QSIohqrs63X0/Uste7mBCVDmjbX+GSeys/yWMuDiw9RNT?=
 =?us-ascii?Q?pQKSB3aIZa4hWoJMeVS2iPiIBKCF4ZaLIrocJ7vkSHB+gg5lt+2DYOQor8lS?=
 =?us-ascii?Q?bhHZV+79vWqy+ZO27byK/ebgD+jP2SbvriFO5G40wEWaTczcSb32uhQT/XeQ?=
 =?us-ascii?Q?P0RaJu8FFOU5dGopMaNS9J3qJqPhYGf+SCpLiwn6P0F10+dk5rNf54tla6Mh?=
 =?us-ascii?Q?bsbk0FNFJGtA4BBi0tK3smuEouBaZb4+z5BxKzRsSQ3YmrE1PBG4b1MVRB0E?=
 =?us-ascii?Q?2VwbU5FTJ+EQjaBn8AE6PDsf3jZu1vxtP/G2UAf9hbF7lMlbq/qKzXzDZ3Ix?=
 =?us-ascii?Q?/S1QIoDTcLns9fnedqnWshoB237c6QW86rkGxQcH5x+urh74RBfh4E8ATcA1?=
 =?us-ascii?Q?qUz5Xd8Vw8Q6mze/KXhzBbtG2Hz9BVR+CK1X9l9GfxJUCBRHsSAN4fC1hGEX?=
 =?us-ascii?Q?kpb/xaQ0gCHqmvTNEzD2Tz+cffxRGl54YbfO2meSOcXJE9LKJLIy0Ml5MG7D?=
 =?us-ascii?Q?8Do6UO3FEJ4ObGDf4fx22CJ6tGrPz9K8pnjNlSE5vvmPNEpFE5f4qttLcUsU?=
 =?us-ascii?Q?jSc9LZVbi8oTESZb47A8QrlRG7Bcg0wh0Gb+Fe7e/FVHmGTlE1FNhN3pRn42?=
 =?us-ascii?Q?T6FBpZqoq83lQGVaeu4Fd2yfQROoX7aPXdAVlMo/l/mZaO0IucBK/pGvAMX0?=
 =?us-ascii?Q?chndN2cxCZ9Roi+tV70GcOFFE7K1YtsmoKOa1LbxJxR2s4IMmvQBTykPFzpg?=
 =?us-ascii?Q?SEjiGtaKwLsTOZ5sFgQmEi1aOFfyzknPFxgqCLd/4jX1gLHtg9scrC2XgtR1?=
 =?us-ascii?Q?mVMoQH2sL0tBWgMbul1kedR9coiUH1ZZHOGSUjGi8qxm6Cy4kLiAivqphrTN?=
 =?us-ascii?Q?5ShM87mtPcBA1HokX0bmYJnrPrKOffVWZeCbl4xj3FzAdQwr655xFYyC0DOa?=
 =?us-ascii?Q?G722TWVVsTJKbUPQbhF0bzBG05If2XW/bXEyc5RIw8ldo+LuP7FSEf+jy3m9?=
 =?us-ascii?Q?fZWOCJuOWda4Kg2iUwC71h2rqXfWVX1XhMTJCbox2c6E6v/2IbZWVGevVijO?=
 =?us-ascii?Q?pgXokCfyeMcUR4ESocBvWwwBd+US4C56MEyuN3iHTw32jLbi3fYi6oEEtzUe?=
 =?us-ascii?Q?ylnOGtmr0ioDN8Fhfte09tvFVlRmUaLpQdEEvf438nXS+/qbG+vahW3NLWCu?=
 =?us-ascii?Q?06cs70rK0UCaaKxk6fYGZUJAokgSJbq8aaHohB0ZmIsWV3A/aGm32d+LfO17?=
 =?us-ascii?Q?ANWIVaCa1KM2XLzQ5h+oGB4LK6ML/C5Z08BhF97MyIH3HDFh5B5qQoCoX593?=
 =?us-ascii?Q?nZg/XUgbD/Fm3zDz2JyG+9xs+jM7mgKXLKkgpb8e8Zuujvo+x/vc3xt6q20v?=
 =?us-ascii?Q?dkJrErH1cQp2stOXKmKCL1VQBQI+50GyFEPfcGt5ui4Ty6CV0GPiX76gDjXK?=
 =?us-ascii?Q?QRj7S6QSUi2Vu8TIKclleigiv1pHhWifJ8qHmFy2BTG88mZdtNjyiD65cGda?=
 =?us-ascii?Q?3WBbnuDgmDw4daKAs4wV7gYF6wvaoqAPveRHPF3qFo8R5efZ5K5kfadzReJ8?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AbpMM1McfCq/X0Sz0NFoFAXDfM2L5nzwYB5phOkRm9JFLyiqaWTKbLkkFoUEQWxR8IpE7FR0K/ZCV73qL6dZkkcs/3RBITlzHpC2vZqHty7pn+RPkyn0gAvj5QFHNwHLQAJRm9J+zDb+QYDkI0gogxuBIjZw9PSte2qEYZov5kJUmvX1GrEC61rfVUyC5WRqCr7JxRYvRIH6z+YHw7/gbCSwnjwaRrdUEnj/baxQZYrqb4M12f4hLXWQIQf8jDbquZnLv28wQNAxZOU4M+2Q5sD/ELUCQXQ8TfMZZKdi/JZmu4wMD0MhstIUQWvya8F8FJ75V0CRzJd9/HXNg3TMAKesD+N6GnSMoT5DZS+efEY2bwpyivDYayeHgAb0jwgtIuyjsX9YU8nn/3FC4FvXrxHbVLGWqDvpsrKUEjpo8w7SiKn1BR1/G8rkKuHl4RuM/096ESm2aMw4FwhVta34eR7xMrfOQsZhIeVKltq/yd1qZvvgYRgoxrbxb3rmy+T7ff/7G0P6rE4J3m0LXmxjp6xt2Wk7jUsA5/oOFiyFQppcw7ElqRF+6BSZqtFQoQUdwEv3iLt2H+gRnK8SQ77a+2HOsMA5YEu/ntJi+tijNcOEZLmgCJAgAkexRJqwKAEz2Y4SZEPBG3/Fc6bhBkK6sSt0K7EMf4viN+gMx0yd74ou/AClpZ6UDDBwiWUbpRx2yR5sgGC+eB6DFDgNy+1LXEHl9jY8kDRvrXi90nvIyKzEoq5W9C2ykIc8igJjIN6itmP32k5KiQY/chnN79lghUsbWfm6NXY+QQ8hCgpuDUdsprZb8OivWie+NeR/5skZOlemYWDkDY6iFX0qMMTlVjHHSKQBNgDlGlARfh+ZSOrg1+eWt3G2srmQN88om4l4IO+xFpbmIH0I3XFQ8UmlMA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15f59ee-ba55-4bae-3ba6-08db57b01f82
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:55.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiXRSixjRrXbVirfuEsgnoM7xS8LA6DaNJUdfMqmdZj9sEHKenSl09rDIuFgTIViGoLfcI4jyfD0Z0JNOhoGMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: K3Yhsaq6t0yxrW9A1ib2ngAPTLH4j8BY
X-Proofpoint-ORIG-GUID: K3Yhsaq6t0yxrW9A1ib2ngAPTLH4j8BY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, during a tree walk, the user needs the next slot regardless
of if it is empty or not.  Add an interface to get the next slot.

Since there are no consecutive NULLs allowed in the tree, the mas_next()
function can only advance two slots at most.  So use the new
mas_next_slot() interface to align both implementations.  Use this
method for mas_find() as well.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 229 +++++++++++++++++++++--------------------------
 1 file changed, 104 insertions(+), 125 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 580310741d89..860f82e16166 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4606,11 +4606,10 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 				unsigned long max)
 {
-	unsigned long min, pivot;
+	unsigned long min;
 	unsigned long *pivots;
 	struct maple_enode *enode;
 	int level = 0;
-	unsigned char offset;
 	unsigned char node_end;
 	enum maple_type mt;
 	void __rcu **slots;
@@ -4618,19 +4617,16 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	if (mas->max >= max)
 		goto no_entry;
 
+	min = mas->max + 1;
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
 
-		offset = mas->offset;
 		level++;
 		node = mas_mn(mas);
 		mt = mte_node_type(mas->node);
@@ -4639,36 +4635,37 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 		if (unlikely(ma_dead_node(node)))
 			return 1;
 
-	} while (unlikely(offset == node_end));
+	} while (unlikely(mas->offset == node_end));
 
 	slots = ma_slots(node, mt);
-	pivot = mas_safe_pivot(mas, pivots, ++offset, mt);
-	while (unlikely(level > 1)) {
-		/* Descend, if necessary */
-		enode = mas_slot(mas, slots, offset);
-		if (unlikely(ma_dead_node(node)))
-			return 1;
+	mas->offset++;
+	enode = mas_slot(mas, slots, mas->offset);
+	if (unlikely(ma_dead_node(node)))
+		return 1;
 
-		mas->node = enode;
+	if (level > 1)
+		mas->offset = 0;
+
+	while (unlikely(level > 1)) {
 		level--;
+		mas->node = enode;
 		node = mas_mn(mas);
 		mt = mte_node_type(mas->node);
 		slots = ma_slots(node, mt);
-		pivots = ma_pivots(node, mt);
+		enode = mas_slot(mas, slots, 0);
 		if (unlikely(ma_dead_node(node)))
 			return 1;
-
-		offset = 0;
-		pivot = pivots[0];
 	}
 
-	enode = mas_slot(mas, slots, offset);
+	if (!mas->offset)
+		pivots = ma_pivots(node, mt);
+
+	mas->max = mas_safe_pivot(mas, pivots, mas->offset, mt);
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
 	mas->node = enode;
 	mas->min = min;
-	mas->max = pivot;
 	return 0;
 
 no_entry:
@@ -4679,83 +4676,106 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
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
+ * @empty: Can be empty
  *
- * Return: The next entry, %NULL otherwise
+ * Return: The entry in the next slot which is possibly NULL
  */
-static inline void *mas_next_nentry(struct ma_state *mas,
-	    struct maple_node *node, unsigned long max, enum maple_type type)
+static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
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
-
-	if (mas->offset > count)
-		return NULL;
+	data_end = ma_data_end(node, type, pivots, mas->max);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
 
-	while (mas->offset < count) {
-		pivot = pivots[mas->offset];
-		entry = mas_slot(mas, slots, mas->offset);
-		if (ma_dead_node(node))
-			return NULL;
+again:
+	if (mas->max >= max) {
+		if (likely(mas->offset < data_end))
+			pivot = pivots[mas->offset];
+		else
+			return NULL; /* must be mas->max */
 
-		mas->last = pivot;
-		if (entry)
-			return entry;
+		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+			goto retry;
 
 		if (pivot >= max)
 			return NULL;
+	}
 
-		if (pivot >= mas->max)
+	if (likely(mas->offset < data_end)) {
+		mas->index = pivots[mas->offset] + 1;
+		mas->offset++;
+		if (likely(mas->offset < data_end))
+			mas->last = pivots[mas->offset];
+		else
+			mas->last = mas->max;
+	} else  {
+		if (mas_next_node(mas, node, max)) {
+			mas_rewalk(mas, save_point);
+			goto retry;
+		}
+
+		if (mas_is_none(mas))
 			return NULL;
 
-		mas->index = pivot + 1;
-		mas->offset++;
+		mas->offset = 0;
+		mas->index = mas->min;
+		node = mas_mn(mas);
+		type = mte_node_type(mas->node);
+		pivots = ma_pivots(node, type);
+		mas->last = pivots[0];
 	}
 
-	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
-	entry = mas_slot(mas, slots, mas->offset);
-	if (ma_dead_node(node))
-		return NULL;
+	slots = ma_slots(node, type);
+	entry = mt_slot(mas->tree, slots, mas->offset);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
 
-	mas->last = pivot;
-	return entry;
-}
+	if (entry)
+		return entry;
 
-static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
-{
-retry:
-	mas_set(mas, index);
-	mas_state_walk(mas);
-	if (mas_is_start(mas))
-		goto retry;
+	if (!empty) {
+		if (!mas->offset)
+			data_end = 2;
+		goto again;
+	}
+
+	return entry;
 }
 
 /*
@@ -4773,47 +4793,12 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
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
-
-next_node:
-		if (unlikely(mas_next_node(mas, node, limit))) {
-			mas_rewalk(mas, last);
-			goto retry;
-		}
-		mas->offset = 0;
-		node = mas_mn(mas);
-		mt = mte_node_type(mas->node);
-	}
-
-	return NULL;
+	entry = mas_next_slot(mas, limit, false);
+	return entry;
 }
 
 /*
@@ -4844,10 +4829,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
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
@@ -4860,10 +4843,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 		pivot = pivots[offset];
 	}
 
-	if (unlikely(ma_dead_node(mn))) {
-		mas_rewalk(mas, index);
+	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
 		goto retry;
-	}
 
 	while (offset && !mas_slot(mas, slots, offset)) {
 		pivot = pivots[--offset];
@@ -4880,10 +4861,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 
 	min = mas_safe_min(mas, pivots, offset);
 	entry = mas_slot(mas, slots, offset);
-	if (unlikely(ma_dead_node(mn))) {
-		mas_rewalk(mas, index);
+	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
 		goto retry;
-	}
 
 	mas->offset = offset;
 	mas->last = pivot;
@@ -6108,8 +6087,8 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 	if (mas->index == max)
 		return NULL;
 
-	/* Retries on dead nodes handled by mas_next_entry */
-	return mas_next_entry(mas, max);
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max, false);
 
 ptr_out_of_range:
 	mas->node = MAS_NONE;
-- 
2.39.2

