Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6201C6EE3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjDYOOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjDYOOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:14:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5326816193
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:13:22 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDhpDJ001851;
        Tue, 25 Apr 2023 14:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=iKKn9jpp9wDQXc/pAc6us+ZOVLDwMdFNQWGi7o0zXuQ=;
 b=0WuAjC6NcX/tDiIOb06wWRpnbSAXWDFgfW52of2VYCKiDXqX8pL7nP4/v0qMDEn/Cpck
 kosVzk9gK11Rwk/sQZzN8gKXrzOQmISPVNHrgSZcJEpo+PH6gAdSHnswvEdgUt2XxTf9
 4TsHuCvUpQlUGy+17AythpQkdePcjT1LMBCokcVcwPc/eAJXgKMY/XZr4ZE+mIucXhxQ
 DaOR/yOs2K2/g/h2nc+13xPJFuhydSlQp255GMzvz2rWvA9a7BUz9sXgAbqZsrgoXHrq
 MsUu+nSNdpjBFDoXjRVw2JJi49Bwq7BqPFji/1HXj276h9SyW8uZCam9QBvYOymJ3rec 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47mcwffa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PD909b007380;
        Tue, 25 Apr 2023 14:11:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gf25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCdEeb/T+7Xpx/LeQ3xXosidA2QHQW3IybPeIRX/A96SQUq4E/ZijyDkVD2xhFz5r+ToCfzWio2DasB+ygzAmpktMJtGSuIXSNR/wHSTIYVtxUzTG9ItxV5zg6AJc9W8FQ/dIxCS4XPPsFc1u6wllJtce6IYR8C2dpk7OR4cM/JVGxoUeV2xNk0PL8FjAwf1+r/P7S1ZIWXvtRbGLHBEvU8QGdAzLMRKtWMX/PaGyEprGivjrfAV9j/Xes0i0Pt8U9uHaET/fsvgjFPq0Z6m0cW4wOYO1VN00XdO1j+CfyCuiHCxkUYW8JfRD4C6NqVAR2NMXMpHfN7ROe3dtRgqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKKn9jpp9wDQXc/pAc6us+ZOVLDwMdFNQWGi7o0zXuQ=;
 b=TDDVU0vkb0uGzymsjHIa/Rzq1shxjIOSyJjFvh2VcqgDLsrX1zTAHr235CqtpKymADMVPpc7QNVYl1anvqKSvUTxHnS8vja/o6OegivdrK2JwmqZP3gjVsOairlbp3UL1cryLzLTxVb5E/G66tF1sRjJp5avysB58sUSvVQ7Rs3G5OKeuNCP6PsxKwz0FgLyPDsIH4PSYO8ZU8JDaz6b1hfhN5eWLWgAm8NNOgFU3uaVzEu6ycFBMVMVBMLC5sKqKhpJjpiOoa2CHmhHezbwfZ9KDLgzlS2aoQvpPl2/tUUF23cnFbnQ3a+NTM7xf1tiN86n2p/W2JWwl3M/eQI4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKKn9jpp9wDQXc/pAc6us+ZOVLDwMdFNQWGi7o0zXuQ=;
 b=FdWzxGkeBEAIrWdzAOBn64ux3aqpoMpP+sHVvuv7C51xPveNMPTrXdDSZT8jkZHf22ER3JZBSDL8UO9OHXQK83Ls/bqyySVH/psRotoqPfmxzAazTrZKdbf06j2cCOfq6h15puT66y7kpSxy3g8GsgOixFoPdVZi7+P3/vFdKb8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Tue, 25 Apr 2023 14:11:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:36 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 32/34] maple_tree: Add mas_prev_range() and mas_find_range_rev interface
Date:   Tue, 25 Apr 2023 10:09:53 -0400
Message-Id: <20230425140955.3834476-33-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0371.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b816514-4344-431e-5eb8-08db4596fb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmZsL8axCvXwODMKH928AQr8MujmXuBMH8CBVffkW2se6Zuls2e0MY9DaS06YRu4KmaqCF2fyTVw5MmNa0U5HSAa30ymwY7ZZNx++RFn9OzSUZ+ii+bUgC7+i7MZQl9hF52SCirbzcMZsRqH3Q4d3e9NxB9LIy1/pp6KqGhQFlT5472QHxSLBe96MV1w6MH871w/9YZp2m7Ijyuwydk34Me6hiFiy4c5pPP79NTs1yuwPj1AMvfWG9V+UDNeP2jsjxGL2PKd1gviDpQwT9R67U/eKTidHkW0brVL8d9Aot98mb+4QpLDexBXIHdNfjoem4r8kjyMwt+xdK3FF/u+94oWWcM4X55eDLJIg3VhwEY8ZtvYLMpD0tO5Hl59dyqXcGePlVuydEIS8EhQxFXFCozNOn2na9F8GXsD/6ONNL6DVprs5o7Cbntko40t4T8pVq4Q5qBfoDZB53LXf39IHlfEwg9rFE+uJik14GNVzg4z0dobs7bkp6ChIVTyXYA2xX6by41Bb6A7QugjGqGDL/MJyC98OP8KvclB9o/i7RgLrD98JFsB4Eg4b3clbpDZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5PvYoXL9yWwIvFLR1yxE0Ym96pWkjpFJLsG6C2P0VfJ8G3J8o1CktgiWqzUo?=
 =?us-ascii?Q?fr0q5XZ44u0XNolVle23RTYXW2LkaOojL9OOvtPbWQxPpWADDxZgqhHG1v/B?=
 =?us-ascii?Q?V3hbsZzdToDveyUydjD0gXraMNGIWSOcn0NYksq3Rwf1NbLm2fL8qs+BprmC?=
 =?us-ascii?Q?TH3ZHME0K/IT2I06nJRbfzfVlgEwCt/ityaK7WZjZCxz5Xso7lFUHF4DCXzR?=
 =?us-ascii?Q?UiJh/8G0cLBuH9JkjLxX3Hlm9nby6DDQWcJsdziL7DE6VsCOG1fUQiG8+tU/?=
 =?us-ascii?Q?8K9+z5zfhB0G6HBxlUJq++y7VYW265Ph5ZeEUAuukMTIL12+xkhlkhUqj58a?=
 =?us-ascii?Q?f9yzJFLOitmeFiG3JFXrO5d1oF8U0tfShGebL31hDM2SzIVlgRTzNcmaSlG6?=
 =?us-ascii?Q?36B3vin0GZhu48s75HPAw4WoZia66SaBKazSjAds5uwfBdO2lgroTlxfyIuH?=
 =?us-ascii?Q?zPKg+t+Odke7d67/CCdbPuBtoyK4wHHHZa5fQkIkNOCp0zJ8rikESiSPkryQ?=
 =?us-ascii?Q?SYSM4LinWi9DLc13gI0Xfwy93dAzC8XE5xx7Stj6qiyuAQxBh/ONGyv+gU0H?=
 =?us-ascii?Q?eW0udcpZWXjvCX61NZYPvhT6AY7iKyCF6irZHYbtxHERvD+ymw41oFXehffJ?=
 =?us-ascii?Q?6QItY51ZqW7XfAiFF6KDP0AEHKerA7lYhj2yeYPBEVLN3aVIlBU2Wl6FxOfK?=
 =?us-ascii?Q?/i+vMvm2ZWxdRSZAPdj0k9iAB8RM9wVcxbYYFeDksMG8vwZrRy+m4OxUeZHu?=
 =?us-ascii?Q?4UVAMmpHmXK4LLzrWezQ3YVqeY2YqsA9V783eih1ifrmAx/IO25hpWyjPn9v?=
 =?us-ascii?Q?nQ5detpxfg2aeus27ow28mDzNDNTTAxj3d85Vv4tE/OlFq9JJayl/grRT+iI?=
 =?us-ascii?Q?ccRC2PIrCp4pNN6pKJUNW9KY1YM2zRNVCYlXo7c7CgtXAT3I56Se4GHxhHmW?=
 =?us-ascii?Q?BVEmZ881j86DVYzrMXZPXPxih1j97mghQT6ARYXjhD4Gas6vlCsLQN4PdgYL?=
 =?us-ascii?Q?cym493nPGKOGdPyeGvbgmxjTq1suQ1bTpTo5JfY9Q5k2oo7RReqgNPHyMAH6?=
 =?us-ascii?Q?Je059RCPhl0EQVwtFG8fvZTtgM8ttGYoAZxbXOyTgN+l6R2Md2adYIGuuLoj?=
 =?us-ascii?Q?MthNLdGjdAjy6D6ZRXvffbguA/FHTWVUenNBlFH6GC4sHGYRr2SqzrAYYXnh?=
 =?us-ascii?Q?HwuSW9PgYHHohqCke7RnuimNuiWH1fJnEb9v4oyhyXQKl5D/9uqXRwvGvR0K?=
 =?us-ascii?Q?4PiQJH4dGIwGo7k1K5zWB3pmg37X/EWPHOHyD+MiLJgku7SoVstjgDuk+P1y?=
 =?us-ascii?Q?Fr3GrN65LFqqNC2vEeXnoWIDmzJ1bgrxlRrXwMkrt3vlHs6LnyxZbFN+0ewa?=
 =?us-ascii?Q?R6Nd+fCrGSx/npXQvKU/ihAILKZrOisD8r/JFsR/TSGYfC0p/EPbjI6tnBdg?=
 =?us-ascii?Q?yc7gY2vvlQQv6g7sdiIhx4FTx3je8eO9K86IBMm7UVs1rJ296jo69xIXQft2?=
 =?us-ascii?Q?j1XfsAP4Zeq34Ok6wbDP/nSfz4ukbcFCcYp5fW/LKls+ngPpBeWpKNvdYJ6w?=
 =?us-ascii?Q?LQRiRSZx1tcPpUDh38cTG72nNrwgzgJEM4GhjDWYvtvj0ysNcPXNZyx08V+D?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xb/WV7x+wAXMTfu6SdEqfs/6M7W82kn8QewPaUskimyyg+3TMeRJl8gh45hUiqvSB8orxgAmrYM4lOpnX5UFH4CjJSbvTMBQVH3PV8ShjXzTYwNYG6sQ2NXzBIhh0TCcMdZ0tXfWiYbNXUlUDxSfNWHm00FxhzAoJ9zlcF4WPOrIOurb1DPu4EX+Z58ouz0w4BhleieARGzX3rfAjFEjbQglebrxIiOAFmkQBnw03gTjnzQd0wtbm14F3iXtQvFePq4ggnwtuATrhRYNSGVXsn6M4FBVkQuaP6AgjlLvTxQHeGY2Pk/Ewa2GIKiG9y4YGa3MhKoumP27x+ldTAHGNKVopOBdpzQcnIxDP2nuMD9HbamR0XtZFeFGWP/D4Au7WCD31L9iJex3vJhj8giKeKKDzqpoQkzF+659mrdnsStA2qupQhccRmcdKJC3oE+xIKPZuAcThr7qytagOS9z6nzhFh+WCzRAHr7XXjgugSY3bZjhllONPxcT7scC61MLkTgtjPNIvGLevh5euMxgLdt8qlnyPY191esLsZV2IuPwSXWY8+MSTFMclpZSUHtbel3a4dhD9KQ+oI3oeP9q3lT+5zV/Y0MingZH5kzGQUO6MI6QJTSQ89WP9IQ7Sm5xeDdh6r8+JnRXt/25LItXaylWbuRSeXtGbY0+GeURQeOrrOsDl4bjKxUMMpj/6HPaY3tK+8Ms2P0BhEMvrTTqmb43hq6n9ohFWQ0318xMvBrO2mOx+RaxkZkark23bgbqn1EbcPSrv1B+QV7rSynTKzEYu4E9M6FDHBgECVbf3VCXItnvMeXL31EmPr7Y1gyc+erO22tvTHZqDWpNIxaDt6quGXI6cJbhNtLPuHMkHdRijj4hTzm8K0QuuJwHjz2aFR8GkWaJLiQgii6MH140ew==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b816514-4344-431e-5eb8-08db4596fb0f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:36.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7uqp+UdEH9ZvTY1PI6KqRNiPRYrSan5DN6iDEcAMCqTElZ9iFLtbFzpXC8IAZZQ9mnkDltOqp79pC+CHbXfJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: Y7SibdWNp3_ZxG2DRWxichY3XbQXJoie
X-Proofpoint-ORIG-GUID: Y7SibdWNp3_ZxG2DRWxichY3XbQXJoie
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of the maple tree may want to move to the previous range
regardless of the value stored there.  Add this interface as well as the
'find' variant to support walking to the first value, then iterating
over the previous ranges.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |   1 +
 lib/maple_tree.c           | 163 ++++++++++++++++++++++++++++---------
 2 files changed, 124 insertions(+), 40 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 1fe19a9097462..bddced4ec7f2c 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -466,6 +466,7 @@ void mas_destroy(struct ma_state *mas);
 int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries);
 
 void *mas_prev(struct ma_state *mas, unsigned long min);
+void *mas_prev_range(struct ma_state *mas, unsigned long max);
 void *mas_next(struct ma_state *mas, unsigned long max);
 void *mas_next_range(struct ma_state *mas, unsigned long max);
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 137638cd95fc2..04b73499baffa 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4852,7 +4852,7 @@ static inline void *mas_prev_entry(struct ma_state *mas, unsigned long limit)
 {
 	void *entry;
 
-	if (mas->index < limit)
+	if (mas->index <= limit)
 		return NULL;
 
 	entry = mas_prev_slot(mas, limit);
@@ -5938,18 +5938,8 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
 }
 EXPORT_SYMBOL_GPL(mt_next);
 
-/**
- * mas_prev() - Get the previous entry
- * @mas: The maple state
- * @min: The minimum value to check.
- *
- * Must hold rcu_read_lock or the write lock.
- * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
- * searchable nodes.
- *
- * Return: the previous value or %NULL.
- */
-void *mas_prev(struct ma_state *mas, unsigned long min)
+static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
+		void **entry)
 {
 	if (mas->index <= min)
 		goto none;
@@ -5967,7 +5957,8 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 		if (!mas->index)
 			goto none;
 		mas->index = mas->last = 0;
-		return mas_root(mas);
+		*entry = mas_root(mas);
+		return true;
 	}
 
 	if (mas_is_none(mas)) {
@@ -5975,18 +5966,65 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 			/* Walked to out-of-range pointer? */
 			mas->index = mas->last = 0;
 			mas->node = MAS_ROOT;
-			return mas_root(mas);
+			*entry = mas_root(mas);
+			return true;
 		}
-		return NULL;
+		return true;
 	}
-	return mas_prev_entry(mas, min);
+
+	return false;
 
 none:
 	mas->node = MAS_NONE;
-	return NULL;
+	return true;
+}
+
+/**
+ * mas_prev() - Get the previous entry
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * searchable nodes.
+ *
+ * Return: the previous value or %NULL.
+ */
+void *mas_prev(struct ma_state *mas, unsigned long min)
+{
+	void *entry = NULL;
+
+	if (mas_prev_setup(mas, min, &entry))
+		return entry;
+
+	return mas_prev_entry(mas, min);
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
+/**
+ * mas_prev_range() - Advance to the previous range
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Sets @mas->index and @mas->last to the range.
+ * Must hold rcu_read_lock or the write lock.
+ * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * searchable nodes.
+ *
+ * Return: the previous value or %NULL.
+ */
+void *mas_prev_range(struct ma_state *mas, unsigned long min)
+{
+	void *entry = NULL;
+
+	if (mas_prev_setup(mas, min, &entry))
+		return entry;
+
+	return mas_prev_slot(mas, min);
+}
+EXPORT_SYMBOL_GPL(mas_prev_slot);
+
+
 /**
  * mt_prev() - get the previous value in the maple tree
  * @mt: The maple tree
@@ -6134,21 +6172,17 @@ void *mas_find_range(struct ma_state *mas, unsigned long max)
 }
 EXPORT_SYMBOL_GPL(mas_find_range);
 
+
 /**
- * mas_find_rev: On the first call, find the first non-null entry at or below
- * mas->index down to %min.  Otherwise find the first non-null entry below
- * mas->index down to %min.
- * @mas: The maple state
- * @min: The minimum value to check.
+ * mas_find_rev_setup() - Internal function to set up mas_find_*_rev()
  *
- * Must hold rcu_read_lock or the write lock.
- * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
- *
- * Return: The entry or %NULL.
+ * Returns: True if entry is the answer, false otherwise.
  */
-void *mas_find_rev(struct ma_state *mas, unsigned long min)
+static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
+		void **entry)
 {
+	*entry = NULL;
+
 	if (unlikely(mas_is_none(mas))) {
 		if (mas->index <= min)
 			goto none;
@@ -6160,7 +6194,7 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 	if (unlikely(mas_is_paused(mas))) {
 		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
-			return NULL;
+			return true;
 		}
 		mas->node = MAS_START;
 		mas->last = --mas->index;
@@ -6168,14 +6202,12 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
-		void *entry;
-
 		if (mas->index < min)
-			return NULL;
+			return true;
 
-		entry = mas_walk(mas);
-		if (entry)
-			return entry;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
 	}
 
 	if (unlikely(!mas_searchable(mas))) {
@@ -6189,22 +6221,73 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 			 */
 			mas->last = mas->index = 0;
 			mas->node = MAS_ROOT;
-			return mas_root(mas);
+			*entry = mas_root(mas);
+			return true;
 		}
 	}
 
 	if (mas->index < min)
-		return NULL;
+		return true;
 
 	/* Retries on dead nodes handled by mas_prev_entry */
-	return mas_prev_entry(mas, min);
+	return false;
 
 none:
 	mas->node = MAS_NONE;
-	return NULL;
+	return true;
+}
+
+/**
+ * mas_find_rev: On the first call, find the first non-null entry at or below
+ * mas->index down to %min.  Otherwise find the first non-null entry below
+ * mas->index down to %min.
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find_rev(struct ma_state *mas, unsigned long min)
+{
+	void *entry;
+
+	if (mas_find_rev_setup(mas, min, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_prev_entry */
+	return mas_prev_entry(mas, min);
+
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
 
+/**
+ * mas_find_range_rev: On the first call, find the first non-null entry at or
+ * below mas->index down to %min.  Otherwise advance to the previous slot after
+ * mas->index down to %min.
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find_range_rev(struct ma_state *mas, unsigned long min)
+{
+	void *entry;
+
+	if (mas_find_rev_setup(mas, min, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_prev_slot */
+	return mas_prev_slot(mas, min);
+}
+EXPORT_SYMBOL_GPL(mas_find_range_rev);
+
 /**
  * mas_erase() - Find the range in which index resides and erase the entire
  * range.
-- 
2.39.2

