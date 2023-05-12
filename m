Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063BD700EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbjELSWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbjELSWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:22:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51DFE737
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4ki0023043;
        Fri, 12 May 2023 18:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9yNU9HJW6liJ2fUnwkIAF9WIpSr2/rxcoMxVBhqd718=;
 b=EgCHd63+A5j+X5QYHuz6xONyolzXGUcdWg9xcYvY1pf+BpfNmAufRyWnIN478HGSTfE6
 qpPusEhb5wgVKE2cF2xjooTPMaSmcIgYJdfmoAZnFserNoaQtfKkl0iAPL9i2ZdRQgYu
 Q4Ha0/2+hwrHeXx8DBZgL3hGPIyHdAjngHN3R7Eww95/3lvSN0b1kSDE96aJgKWAjH2f
 s5gqz6FgDnjBWGVeCA2iPh7mCSR1OimA4mSaLrDmLulrh1030Dw+4iqigbZTwk750plI
 0x/iXvXR7kTNn7MhJD3wyovpEn51lNIvYduO5HIyZ1LX/SdadCazG1Nc+dyYfccTfJhG rA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77gbq2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CH6CWR024148;
        Fri, 12 May 2023 18:21:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7y8gtjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJHKmYSBkmVx/8X2hP3Cgk08IXWFlGiICHYXhFyJVeeNR7FwcrslKfva+s2bg12Uxif0494JMMr/6ZEYkCUgJBYxZpge/y62uGpvmhj9tpOYAg2K87XTb1KeV3n1TlHeFaBZ0VP7SF1gOCCUsoTGBEuPxENQD0pJZnyXnKJaOWPrbVbI6NSd35pWNp5bvkZ0mpckTJoU+YhPdZSFxgi/OgS/LJe6BJ2QO5/wJdkB+2VGQ/hVjA0kYIBtqYwDHtfjMSzznjpb3MFGDGZn6+Lad8aRJCplMBPf+KCzTzkdicy4I7UKT/k8m2vMhopsqS8kZpMbmB06ZCOGVZomNZHdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yNU9HJW6liJ2fUnwkIAF9WIpSr2/rxcoMxVBhqd718=;
 b=j0wiVpXid+LWigmwfCPMm/Jj0qQqgeqBkpBnD8nTAxWMWe5I3ZrxS91hzs8X7x1D9bdjqPQWJFksETIe0G8fA2lph51HnMswWBZ82k6h1khXZFYBILVNE1kgNKtrgZN0mqWKG5hax/O93X9ZNwnv2m932+R8/i7rxcpR5DVyKMzo4I6PCWPMq1jPxuZLhm0KdK09D8BgfqQFEdtvkftW+tld9i5tZVzYCpIseXpqyQfjgOISq+XJuSu6sjCRCB0E563pyprtBH41f9OxAE5kIH0fh4yqwVvML+UFOim6qDjEukZhNe25A/AtG5x4JRxwnugmR9XNMFyh4THYZMUQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yNU9HJW6liJ2fUnwkIAF9WIpSr2/rxcoMxVBhqd718=;
 b=NiO1CqauRKrr6F1ogToC4aD11mAmTdkVvmjmYTeIs4M/FxIofWyLT96c9/sTzunRx+ZVHEms9iJeGFUYOE/YhNHHXAAcEOnBFlvw2YI3jQcNPB7F5gmeVZPUAXORV2JniVODHaIFnvN8aiM8sS2WqBtgWX9qbnTPm7HCsZeXP4c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:27 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 14/35] maple_tree: Use MAS_BUG_ON() prior to calling mas_meta_gap()
Date:   Fri, 12 May 2023 14:20:15 -0400
Message-Id: <20230512182036.359030-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0047.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f3a7e7-d6b8-4fb9-d1b1-08db5315b33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTJs5lyFM3/BwYcRmldEn6B2q8rIGiRe3xA96PW5hlgC0kdbqadyr4MRNrRFayN8N3g2S30FEH4rTP0eXlXk1hVHiTopKCg6pXjE7QBfu9Eo8jXJZXRv+uc35rZ6uIVH/H13znZUcwi+Glr4fQv8bGjCJVi3fYV3wx4d9cdAaX6j9lm1TtUl+Ei8+zOFNS8fzx+D36D7aUJLpV5Xq2mfaXb1+8y+GOqM0p4o/dqNNki26fYEL3BeddI87e/UXhM0W/opc+2DwFIjhVKSB/vetc8fJguAZwd2AbLcLN/wFp5kC4Iv2kciE3pCGAMMMlHzX7VcTexOUjNe6DnHmZtAYNOjzFqO0R7ZauEHEf57jR535ye9FcS3zOvwD4/3lFfx1sUFDaH9aHZkGNNkN9UHP0wDrYAtkl8BOGFDqhJ/PsjjkFkI7V5qpg3bTyY0RYpoTx4Le7jamkwPIovgSa4bFGz3BbZQam5+TL3NdN/ZO6zUO+u4gy7f1UKoE0t0l0cfZw+5TDS7lqAsxBOTU8YROiCLxigr0Xv947I0rsWapOTt8CkBNv0mEXfdysIb2UfV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(1076003)(86362001)(6666004)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YRAKUdjPsAi0Swb8uQ7FEZLeobqbdv4PLVHkRcv9HF2npSEaMOohP5ccBIYH?=
 =?us-ascii?Q?KQA3yRaqyonyI12ebt65n6GglDGRG257gS1bNpYpS97xQH2WU/m+utQkB99l?=
 =?us-ascii?Q?Ri+xsx3AqMz+IU055jFZzwz/UB9An9Xc9LDpN2Kpz1t2sMG/tGg5ajK0MiWG?=
 =?us-ascii?Q?Ha6ib4Th5dwFdr/CYDwRuvwPeFgJoYBch/nFIgyXUNfi3K4otAYC46VnkTaC?=
 =?us-ascii?Q?3NZ1LPSfKyBoTAfnGnbdyxKd17gxP7YjBAWbjwjRxIYXZOLbMdrssRkKjQ+E?=
 =?us-ascii?Q?rNUATLx1hxbpU7fHi1vxv+G6QWQtcYdK56kc350wLEUycaBRSc+miT8qWyYm?=
 =?us-ascii?Q?t+N50rlEsDoWITpj54QFvYVhpMI526FJAZaQW4xWXGkXWoLRqp/PBMLHsQ5Y?=
 =?us-ascii?Q?OpOsVZEDzbQc70Ypm3qUjQEN7c2FChhwYWv3YoRvH8V1y8zRCjpPntKNkPg+?=
 =?us-ascii?Q?TVP9aHA0bTNd+BNTmKCpQzkOxHTOc7CZnVFF10IFQRrAFflKwOKIAYcVAMko?=
 =?us-ascii?Q?ZTYbYG/rj00QVAwYsWW2TeF9VN2ujziFjS3Kb4jlQN0iNUwc7Q0l4boCv8vx?=
 =?us-ascii?Q?xSyKAyuR9I9y1hc4Fe7jbXaoFP/rMcDj5yQrrwGhX3uA1OIGJBWHhDuOrV1C?=
 =?us-ascii?Q?Jf+vQZxIquzIH22Hy4KrrZaOC+0iJH9iIYHlunRwYX0p0a2tfOkgKroNCV0Q?=
 =?us-ascii?Q?UANsj9saSnMcz4tuxmW0foSu+8uK1hGWCd3ykosHI3ceQlkIF7UYjwPXHCMn?=
 =?us-ascii?Q?/LTggwqhp2sJcSyHGvDNVNJFy6QOKHwkpHR9o2oPDmMHrFdkx6ZjEgoXVSTf?=
 =?us-ascii?Q?6/tXeWCIfy+Sfds4f0yek+NP9YkOJ2atYdDqNCovRhZyFJfUWIHwtQakAp/A?=
 =?us-ascii?Q?+575+Ff5d1MXW2xqLNeD8ZvxAOOZXyIitQP90gAVx2gzXEm+UaAM3ezA7NK+?=
 =?us-ascii?Q?LxELk4YzsK4yn0D988Nete9ko+a+B18RJ/mK+OLN06IdNA5hcwcwi8wAzZMY?=
 =?us-ascii?Q?ii4jt6lMZBSQ4jFtP+JUp8WzLn1c4Y5iWKE/6VDSgmLqokyhShF/i1H1C75F?=
 =?us-ascii?Q?EzkI7shKs86u1mukwskLsK+ph38Eh+oT1B/OjxopAaklAKVBbbD0X5FI9e6K?=
 =?us-ascii?Q?eleQcmbHaRIuw4WZ0R/JICCBVP66wcyYHKCWdPsZ3vZiEOghnBzZRXnP45Ar?=
 =?us-ascii?Q?N9LQGiC5YVlBuPdebcRX+8QRKzG+xuB5gD5+OTYIiAHpUgP2XdUEyxYWl6Ei?=
 =?us-ascii?Q?7NQUcNj9BRlEWy1hueSkYM/UYDrN0+u00tODIRCR4/pYUkjAbvOlgjA1iQ5i?=
 =?us-ascii?Q?b4u4B7aOEJIgBvaHv+er1gTkDYQKGb5fxj1ATMKdDdOgusPgkZ/4F5VLI/yA?=
 =?us-ascii?Q?cKjORPfq0yk8cyjuSuZ8jAt6MRFe4cHU6g5HSmpttYUFdnKiFmWw/fh7M9pq?=
 =?us-ascii?Q?cEF7XqmmOMNXawRZEVk4PzER1Y+PPtGXZ9Ki0XER7V+8q+2x6D6UlY5L5ef2?=
 =?us-ascii?Q?okBpgCHv0XiQ0/4CyyoROmMhnNZbrxhofEqj11yjfIX7L52sq2vEmaYqQ/Er?=
 =?us-ascii?Q?j/jwPa43TfDO9/qfBqYw8cmgnyT94evG3uudkaRai/lNmiTO8MSl9T+sNHWi?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o8NTy1vScuBRiOO5Tz9Hl5z80l+hQ7I8uMr/tF+yzDappbzCkhQQGrFzohGzIKlA9kTsvjOARK2z4vaLfXugvTuZJdyC+nkOFETQbpIJ1uTw6ffPjo9TsfUhI/rHKuL0NeXPJ56+Qzht/y6FVGii+vRKqOkbxhm9z/1ZCjZVrQl0t/N0WPzxCq4Xp+dEjl7tgtCsoLUP9QZjgezZ87i8b0vcPuehGXechVah9GLYKg7F6nSjLY8jceuubygHI4NeftMWWa9IsZUDSfDz7Y9ow9fXV9cT5Bod11YhJLDnEx1Pl1Z3jE30ljz4bwMSQgwCVqyytHjZT1J9OuHoJzrRPr2KOePUDEHm8o8tQfWmaV0PNnsYVl3mXH7mJmb65zlZ4FI97jsojNXWnDC9utmeo8BSAD1hCbbHEbXkOLjFdrna6+HfO2+D1GUyqrcBuE8dseTYcK3Wjbz2p9Ward98knO0WZSPY98ZZH3Lopjn0YX2pPixljlybjK+22ajv8lTVlDL/RmJBH6kllAWZ10iadCKc5OvuqBufJHMuNXC+1iTwWiZB6e5AOvCvbXUdzfz4tCym/m0ubHHCK2MbXsODgA04iC7V2Tgphjg9nIvXjPH2Px2VIjJzLhG62ZfGmhIKlJylN6wFnmbR5kk+EdGQMSUowO0ARi+IlVKFkq0rcS+UCGIkq1JI0KyuLeCnuClxijHqHiYPLPpWozS391dwDm4cTI4ECUpp/QNEPW6MCh2i9CqtUdODDhw4QWN/0MEVKrQcMAF//JvzgATrNuKBNUO9RGyxDCsRfzBRk/iJNEOlwkUI5nUWAsTgDuFz5rYXRke67hAS83x3vqmof1TA+QUDzE8T5kqDnF7flL1omXQmekfEZiGu+svejbRaWB7/KdPSVTdH3CXtICWmTcmBQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f3a7e7-d6b8-4fb9-d1b1-08db5315b33b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:27.0594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZBNaHjd45ZOFGepVvbetBfuuVNEayvIg3M4WT9vItOs+fYwjkA+StM0DFlwTggy9wupWk4dpaRBecMigwnmaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: xYSOlNajnFQJ0zrI3hZjAm4dPWVKGCYP
X-Proofpoint-ORIG-GUID: xYSOlNajnFQJ0zrI3hZjAm4dPWVKGCYP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the call to BUG_ON() in mas_meta_gap() with calls before the
function call MAS_BUG_ON() to get more information on error condition.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d5ccf7bcf3b5d..d7809a7000c58 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -963,8 +963,6 @@ static inline unsigned char ma_meta_end(struct maple_node *mn,
 static inline unsigned char ma_meta_gap(struct maple_node *mn,
 					enum maple_type mt)
 {
-	BUG_ON(mt != maple_arange_64);
-
 	return mn->ma64.meta.gap;
 }
 
@@ -1628,6 +1626,7 @@ static inline unsigned long mas_max_gap(struct ma_state *mas)
 		return mas_leaf_max_gap(mas);
 
 	node = mas_mn(mas);
+	MAS_BUG_ON(mas, mt != maple_arange_64);
 	offset = ma_meta_gap(node, mt);
 	if (offset == MAPLE_ARANGE64_META_MAX)
 		return 0;
@@ -1661,6 +1660,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 	pgaps = ma_gaps(pnode, pmt);
 
 ascend:
+	MAS_BUG_ON(mas, pmt != maple_arange_64);
 	meta_offset = ma_meta_gap(pnode, pmt);
 	if (meta_offset == MAPLE_ARANGE64_META_MAX)
 		meta_gap = 0;
-- 
2.39.2

