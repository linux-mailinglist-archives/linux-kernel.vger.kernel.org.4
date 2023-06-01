Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C67871906B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjFACQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjFACQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:16:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A618B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:38 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJt9tc020026;
        Thu, 1 Jun 2023 02:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hNNPNCDvHhDl4WRLh9/7Z8qWAAWKO6ttK4dq+KZRwuk=;
 b=Wl44DzIMGCvGjeCfHa7f8zMkFqwaZSFKHevccsxOj+hoVdlVWFvUqc/7W6rN0OHGIjM3
 uf8W2wdhrki/cfV8/yt5rHoIaMu1oaInVAHPBpfAqPdAg5i8xkoemI/Ry63OmcsfI4Gh
 FY+U1L64fvJwz0cE3QruovRAj3iSMmPtK2LoG6kgcoFC23h5bxQYt6v30OdXTi1pPN17
 0Ndvzgpwu5nrxd/nIRRyjbN86hwfQ/uxu4/fy/IEseir4s4pnxuBkVYoakSfab8mE7YX
 C4F3iXVEpmWn0V9HT3o8rG4mrKgtqMHelDxNKuNWcgsZZw764sJk2+1iUgvBHIFHU7zz VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh7hb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3510E5VY014631;
        Thu, 1 Jun 2023 02:16:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6gr6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0BumRofVVkgtYj148LE39NaTPTU/euKc5qywBm8QBQh4gYVMfzn8xRZWB/UgqVL5MeHE7/xxmuIXTH0wOG/hp9dU6ECxnuF+52I0qDlATdaJzPXbTUPQ8bQgI2l7JoybSVJ1AS9B+PKSMp0zygUHcNNa8y1JKGvxQU0uk9S6Gh2IDKbi3m3dHzxi7sC7E0D3wLgq4dyeRu76NJgjORYTuYDdRgpGyKhqvZZvJfR6BMvSUWj7AvqK3G4SLB6NWItxZgrggf+KhXA76r+QIH4A+dB/ZpyN9L2Bq19BbCVrsYlYWVo39TS6HHovawvsYUs+K8YeQk/WCncX9RmjzkKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNNPNCDvHhDl4WRLh9/7Z8qWAAWKO6ttK4dq+KZRwuk=;
 b=P0/NI6+COntkDg6p9tzbhsOUDJFvJ+HMLb+Eo1ckzGCYTBn6Yi/OFGTA358kvEnixF6hy72ZFRu4JUdj0PTPjBWoomCwuqhLbFaB0hoWe/5gDmlca8veqxPGBZm8iCqe8iIgqPxpkeN7QkSGSzCwkJlAcR3z9pNnxyw/gRK4G95RUiafXkfd4dG95dVcpugq5C6Si+7UhpNizIqSU+Qo2RLGMqG1hrxL3DMZId8XmOREffbieft0stZy33lStqOfoFznX/Eu0NmHJuk0mRW127GeWVl+GyGo332QHnS2K7Gi9MV6i6GR5iqmrHa3vaNuV0d8vtVo6npKSdiL2J9wgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNNPNCDvHhDl4WRLh9/7Z8qWAAWKO6ttK4dq+KZRwuk=;
 b=cT6l5As4e/mIS3e82hFW2iUEdlld5paPqWcwVboq03FIdmH1rsZpdcGGa22m7nejlkHKbdILpvNEzP/qjtDOBuRsnlCRCtG/aPxEw0mh2YOybNs4iS996bIQyfqtcgjfLogMoYnOkB0VbXedHoNHCV6Ehsr932qLmvkpCr4u4Xc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:19 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 01/14] maple_tree: Add benchmarking for mas_for_each
Date:   Wed, 31 May 2023 22:15:52 -0400
Message-Id: <20230601021605.2823123-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0339.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 21388493-825e-42de-318a-08db62462faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtGOTpr6zFlGqyFII+6yRqbd9Ij8/9J4f4CwHpTcNpL/5+c0X361irVimr1Ep0JGZKxY3199mqW9eP2U720d40DlelB5pNQPaZ3O5i2LabmvGFM1X2KdJMTWi5sBO9XWQQJ1sYcUyzBRxiz4LRfclFdsiKEk5Eki7jbz+2ZbG1togz2lcBmKmlrdgREI+tvEHuF0h3Vi564pNrWzzRNTz07nWFItcFlodFbiVLQaLQ7yx9lz1eqnpFCxLGrc3HVadYSZhCtPQ0tOVZLcRwnUKBtRviHzqADdretn/DtpMB0MXG7cRb9JGZgjAOXEsNp9Gdu4XG6WPoUTibU7NaOgDGSsqcYZnXtp103UnINtd5OsCJ6REFgc0LXLti8PQ6XzdWrs3Q0XNUJQaCqEsB4AEIJmLf3ZuAv8SoF0cpxdQFoTFGqHjQqk1UYLzPzIHA3YIrX+PKlYr8yDImqogl3+JMkZp1FX4XFHd7WKWXez1q1fWsG/cOwsxjA+dLP1brXfksFKML+IofUBXXSzxEQ05qRlREI98Z2uuge7pC5wzurF/5K2ydBrNr8Eqn96hIXt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BHSEWj66j8mV+uDESMp/8VFkbYO+MV44bevas5Ha0mu9/iZqS2jHCJyEw7pN?=
 =?us-ascii?Q?G539ZHooJIvfwF7Jma+1GMhAytMZMiiUV3H/WRVuGZmOKM9g35d/iRzTiKK5?=
 =?us-ascii?Q?K4lK2RjR3CB6pDEiCVHTLPfBWvXee1aTRszuuFQBQlkZOdXjRgBAlF1aVODk?=
 =?us-ascii?Q?sv7xCycTkQ7EOSS6jeWSVa7gTC/aCEXwI6OSm86Zj7vl5GRLlclKiWIBZ7GS?=
 =?us-ascii?Q?CsPDs3xF33sQSsB9cA3NrBY0i0h23/mWrWIK95tfuVMx3hh1CPSLGS4TxeLB?=
 =?us-ascii?Q?bQsBf2u8GDcPVv6kOPXWf2jN/TM/ngI4i+rjDXLtgYxMkE8K7czhJCLR4grh?=
 =?us-ascii?Q?RFW+xnicc7jHrfiofWhAxUXcv/aFhB+G2XBL6tNRDMc5XcvLJlQJUzQJqDn0?=
 =?us-ascii?Q?UEOgoaGRhVrI3XG7jTP5HJlhSQ8cNIl9Pg/IbMyCfkGoKiccsGLQ0YzwolMG?=
 =?us-ascii?Q?xUpyAOKXAUCRUDjOKd46bfjShxH/1MrsxAE34YtxleiF8hloUnMa2Gl3JIYw?=
 =?us-ascii?Q?+oOO4Hzn0IMBaOyTtIqzb1zwlm2ZsOIUzGS+eIJuyLfgby6/cjXJM++0ks0h?=
 =?us-ascii?Q?n0jf9+dwxz4Poh/lXjFaiYeXKJb5CJTrV4qraEDCRwU/Aca0EUkiThh9kHvh?=
 =?us-ascii?Q?o8nl0c5QN3g2LMR+nxfYOJb1d+hejgAGbpGN4inpcjOJeilKTK+Y0Yc7XX1G?=
 =?us-ascii?Q?nd1FbrWzMsGg2hGXiyP0JP6+i2fyK/cD0ywzkgq15/rOfSgZ5k6/sCkvreS/?=
 =?us-ascii?Q?4BexgmN0dQAqV3hsJvd8Ex5bCK6pMyu0MXOnABFkpt0Hk6T2eqSoF24I3aG5?=
 =?us-ascii?Q?dCKA/9uT/bHkeOR+cQFBR2BXB8+XQX51wnGaMKePfsyY72pQ3etiTqV2Kk3M?=
 =?us-ascii?Q?1I/glPTnFPA+szqAUpAHFXfmBusOKKeTif3SMx8KlhpAjyZ/GAwwMOYDZGxW?=
 =?us-ascii?Q?YtkMRkZdemQEuxtEVTlYFXdwtbcZG/fQb3VJPg8LrfqrV5BvM8192+3yv7tH?=
 =?us-ascii?Q?BiPX9WbOSnJrpEpX0InyWwdUa6dcr9qAp0uC44sLRDBaFXlATkrsZkfxtTZj?=
 =?us-ascii?Q?Do1z65yavOj/HTP0b+HaKVRTQvvEWUZDYyDasAMg3kVIN0H5RqktpicrnONP?=
 =?us-ascii?Q?3Y0iBrCpF84+7D+xwYetfwpC11NllG2fz6o597B0KwCnhPorH5lUal/N7Oc+?=
 =?us-ascii?Q?bqzaDaf93csHpk1KOJU3KoPdeX5Xwb2xp7g17IKehJAvA3OAdaOpI2gjgn6D?=
 =?us-ascii?Q?4HvzH5JHdndHhsHPC32gccaRE8j3jBgdes8wjW9aDeS7VwVyLytpNCqsXwBZ?=
 =?us-ascii?Q?miioaGBA/7QcdsPeFcmr4qs5A1TIPMco6ym1bk60n20C8Yesgb3OyHdpSDaz?=
 =?us-ascii?Q?4860dRkk6P6peRZ+iMf7pvU7pjB4rnRadAkoTCOuOZwlPxeK1iqmtw2dRDzw?=
 =?us-ascii?Q?g25rx5nBMZ3PXxLCCzYtA5rfTpxX+j5oL4pZpXME6s+UXBWu3uO+67VAJlRw?=
 =?us-ascii?Q?Z42/FaFFITdq8undHQH8n+P6Aq0YZVumMVOcGi2KYbg1F+T2QA/45Mr15aXe?=
 =?us-ascii?Q?0xOV0DY+Wpjd0FsDyvWUeSbXYd0UOFbc/DncMoegcNOwXJ3oYuM2ARRb7Hk9?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QeAagsZEiM0IDX1uQVxoNzeYmhgpxKG2STo4+DCvagDC4B8rlUuefPfKlzhdlohAiKcrfImbk9iMWz+19zZ5iLswIYpYV3YMSNsu9W8pymO1IishavyZ2DFJRvznNErk98k20UN1ndrM1A8Y57QmrOsXykEspXiGQG/TFz2cORe0vV9lHKseil03ueN2Jctbc0OyDVCjVDCsPmjnwS6y6v4HDZAQnmoR3YN5QgTmuGVmgwWAHajreopHp7RxsStgDyG6SvTH6Sh85ETUmS1H5eNLfzF1pZhyE8VIxADpSCSD/tOM7w8MikJuAoL7WmTK+61SAuIo1ksiPx3WNrhpbnuAec4NZ4BGNkLmE/T/QpXQs+B3GYaciihr0V/FmkqeYaTra7dPO2UkRRW6mUDRpIjTljSJqOrDLD6BhFGo/0bvRdwR+mvjrh7/sFUQy+6CK/XbODREC0wokXViO1FKBkVff/mLufyHAlJr9co1zNv9eLjOy5EVNgCDp7CLYdCH/K8KNek2GrDZkFLoKCQXKvQkMol+tG6fOHZSln1sjcJjovzOGvpCVKl+5jrhVMEL7toNmSyhAFlo15uhaUKhWfgA4r4FzZSu20i5gY+PHvSBEYHLPgjm6w8C6l7vIe3hssPTIj0Ha8RxmbUB8ZVaKAx301/kbmN8jxPVEKaXOPgsD6XZ3EEgVNUpXtAzqoSdzsaUVrAIkQFcpa7MGjGyYpPF2sYDSOmoQoltVYjU5kYhT/+SCQqPRQZVI1wCQLJRTzlzZU1F/sUA1zedqShiaq9H67Akj1YNNoNwKLPE+CzyNfDHKp+eaQ1uFqJUw7kCsxNpv8qtfjz0X9WUO5ynz8DmtKBmDjyLqG7SE2b1rZjomMtJF1ab+H9M6KeYcG8IHRFxzE9M7AJv1RyNTjsTcg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21388493-825e-42de-318a-08db62462faa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:19.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzrGHif99CZjSZUb65ZQ6wrh3HUuA9OtTd/84ewcUJqg+EKyNtpwMp5Mm7m9012+ot8sqoG23iYuBOvjEovKeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-GUID: -Uc8XSWebcAtuRfKkCAt5pLCsuA9bRo1
X-Proofpoint-ORIG-GUID: -Uc8XSWebcAtuRfKkCAt5pLCsuA9bRo1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a way to test the speed of mas_for_each() to the testing code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 9939be34e516..3dbf99c3f2b1 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -44,6 +44,7 @@ atomic_t maple_tree_tests_passed;
 /* #define BENCH_WALK */
 /* #define BENCH_MT_FOR_EACH */
 /* #define BENCH_FORK */
+/* #define BENCH_MAS_FOR_EACH */
 
 #ifdef __KERNEL__
 #define mt_set_non_kernel(x)		do {} while (0)
@@ -1705,6 +1706,36 @@ static noinline void __init bench_mt_for_each(struct maple_tree *mt)
 }
 #endif
 
+#if defined(BENCH_MAS_FOR_EACH)
+static noinline void __init bench_mas_for_each(struct maple_tree *mt)
+{
+	int i, count = 1000000;
+	unsigned long max = 2500;
+	void *entry;
+	MA_STATE(mas, mt, 0, 0);
+
+	for (i = 0; i < max; i += 5) {
+		int gap = 4;
+		if (i % 30 == 0)
+			gap = 3;
+		mtree_store_range(mt, i, i + gap, xa_mk_value(i), GFP_KERNEL);
+	}
+
+	rcu_read_lock();
+	for (i = 0; i < count; i++) {
+		unsigned long j = 0;
+
+		mas_for_each(&mas, entry, max) {
+			MT_BUG_ON(mt, entry != xa_mk_value(j));
+			j += 5;
+		}
+		mas_set(&mas, 0);
+	}
+	rcu_read_unlock();
+
+}
+#endif
+
 /* check_forking - simulate the kernel forking sequence with the tree. */
 static noinline void __init check_forking(struct maple_tree *mt)
 {
@@ -3430,6 +3461,13 @@ static int __init maple_tree_seed(void)
 	mtree_destroy(&tree);
 	goto skip;
 #endif
+#if defined(BENCH_MAS_FOR_EACH)
+#define BENCH
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	bench_mas_for_each(&tree);
+	mtree_destroy(&tree);
+	goto skip;
+#endif
 
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_iteration(&tree);
-- 
2.39.2

