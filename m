Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54AF6759E2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjATQ1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjATQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:27:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CBDF940
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:27:35 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBjO3011480;
        Fri, 20 Jan 2023 16:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=xYHmyeDE45MB7bpsP8TJQMyzpnw7c2mZrwsPVdP+egc=;
 b=uN8hAoMjEZdUPzqeILm9RF95GtcaokgPcSzrAV3nETbfCQXfKKoI/NmSZdd1QDT1mYQj
 HBCR+sjbm5yEJ6qFs9VA4OCIIeTx8IdmVm2dvYH9l3ZnBiMiCXgGtSIUyRQ6ckIyBvGy
 etuhlQxNZAfCLORBYPmoJQe42SwWRgpQWWunAWM/s4cl+6KdSwuic4eVjYNDy+gzp4zN
 jd6RQ4lXCOESv4GRVAYAi3bLfYT8aLvecfsuHi1Bcv7Rboytsm8I9lUs4DejyV0eVlD5
 zmcQZj1kTg8LLQ1ZezmGfTs8bFvJzWpJdEOGcSRvnMvliTVKWxZwaQ84AnTNvlxQorK1 /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895aqp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGN1Nj018798;
        Fri, 20 Jan 2023 16:27:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quj9xyg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFwmSj/eJIfLUKZSjOsQuHZokA1md+OFX5Fctcd5+XEOO1Zgxmlmao79l47oNuJ+nbyBFrSna+qn6hrLpS27Z0/gZNGyZHTa4rjkPntvQjEbVgmgg+qLaXG0zJ2pi7Lh/7KiYq5L5nMLwR7z3KhUeNNjSOqkQ18xr5HBjCIsf+b8q0jgI2oVf/rruebqumKBGYoEymdnK1G+loqKca3cc1bQoDgyHYjwVQWYDjSGpoucQP6RgwLRlbfj1qBQbpcdv1BV9GKU1XjOLWCKHj7ZVwoRxoQnr0V7m8sv0DJIKFctNIbasctPCr1efPxi6BLuQCtDtuiWpkKixtKIYkoy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYHmyeDE45MB7bpsP8TJQMyzpnw7c2mZrwsPVdP+egc=;
 b=KHwoJTKIPvqGnD4zVXRPcHIScHjNhQNLVeVAFDyO+YxzAb25X7iMe2VhrbXRzWMAyBaRJfvpeVv3EmiZERQuIXZO1xWpYM0tSp8W2qxzEq645XBh5K9scvi7yG3iVU0CcZNT7Xrt1gsF+IbfmixJOg+QG2ls2qT6P88LBn/KvavFcw6b+4ViB02fLfJeZWT5+UY3bWSBgRHIKPXZk3n4aEfbO1XxWbmv8tKmH1UWYv1zELcrRAgTQsVbQloKbLc5/exqJIes0091LWVWhqAOK18d/huoRzd0jnN1H1JgyW03/XQQOLvf6FgE7ZRNktEA7OQrt8UmhgRjQvgdn5EMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYHmyeDE45MB7bpsP8TJQMyzpnw7c2mZrwsPVdP+egc=;
 b=DezlSfkokLoSFIzSzHyiizfVKtsjLz3PdGjPG0QG/IhhhhykTXpVRVcGJQNA6G9dT5jqpg2HJNSdAI5uUtSIbeomenEsb0R4bVN/+Jec0nMLP8h3nnEPcMdWGEVwPhUwuacrEUB8ZMfcq/pSM0dibJsQ/FyF30Kkvl29dTs7owc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6026.namprd10.prod.outlook.com (2603:10b6:208:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:22 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v4 05/49] maple_tree: Fix handle of invalidated state in mas_wr_store_setup()
Date:   Fri, 20 Jan 2023 11:26:06 -0500
Message-Id: <20230120162650.984577-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0019.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::32)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 678c1af6-d2aa-412c-a7a3-08dafb033551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eEudXIMknd8GZve6v9k9WGTneWbjO90CSX3af3SCSY7cr1ILqQbga/CECRYkGYC/hXlvHzJb3ur4D9ZIRE1yJC1P5xFtyPqrnfatWy+JIHMjpUZ49XFgv9MPxQjJx0oLWzi6c+iYX5cdN4+NWxfasvmwNHZrYthzEU/uZdbInHE7FILYQQxkRwUesEjtWrgdjjcJmEFOaa7zQo04JT5ZhCvkfbMLfsrObdCoRFcGtvnzUGeTtTJHTGkwz+1Cqgc4lBU98Vyg6OLYCYHiDePLZ1khnIXcCPOLSCKGEDRmOgiHsWoAOwD1fTGM83vHFCutQEtne3MmzYP3zvfUqCVp5/YflTEIzoaedWCAt6wbQaHDmUnUjhztKFFe+SExvMhm9+mASnuxT8/2zDrGzdY6ikPDruZl5SuUuxqFOJyX6wllH3ZN67zZ0J03gIZqjL6ISHDs87UG5I6SB5doJje/GZq4Hw8GI3UsB67Em3BoALPzG6/9HO2Vr286W0CWxC+5brcuCkDuQYw6y+bRlgtNnuxUc18I9r/tDU8EcBt6cl7fS0GoyelqMbN/Iu/oM0AjblJxUrRTznYLzpY8hBQ9arLdbF8HaXRboPkjsbafD0go7q6bfE5omp/6eZ0Kj5OrQe4uJdVus7p30swIIzb/tSfiTkVBLCFnDQ14C3xcqDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(4744005)(5660300002)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(36756003)(6666004)(38100700002)(6506007)(26005)(6512007)(186003)(2906002)(54906003)(6486002)(966005)(478600001)(316002)(2616005)(83380400001)(41300700001)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/HT7Po2MBSrrSQmNQoTcGD5uqRBgIa2iNzo+CFcX6O8TSg63DWyWSf6P9cN/?=
 =?us-ascii?Q?tCvXupyDzr2UpzYpGNbVUc8IF+OtKSm+9j83eQf3UgyaN7n3QkT6GEOEWeNe?=
 =?us-ascii?Q?+uMNoTiDe+0d4Z6K6K9JzNYSn/lT9AhYTTJdobYPSvZVy9Zsw/lIVPTZPTyC?=
 =?us-ascii?Q?wMU/7YJB7oYtWASWX3uVMpJ5/sj2u2F8geREiimgyrIX70hxw0dkMGHxVe8s?=
 =?us-ascii?Q?7PQtnSZhzIqYYx+ZVBpiwwr3woi2SQllLHJvYgZsPsS4xTy5+BoRcR7X0a2G?=
 =?us-ascii?Q?THvYB/aJP8fh9nQWzli8/IesTOdLOuIFa36zu35udBkmPIniYL9SAoOc+LOz?=
 =?us-ascii?Q?2H1A4q6c9Zm0GzGT5aOGgah/k/lpiV7SzPisn3O2inJVKP4EkfL7wmrxvq9P?=
 =?us-ascii?Q?eTEcGbVWl8K5VTHZUunUpraJNo89vhXIa/En4Ytj5FUt6+jLSVveqappvrcB?=
 =?us-ascii?Q?YGIrwqdDK9S5yvflUKhv7KtX9nxc5gfUm0SIQcBcs8bp3NmkAAVjfgj71Ds7?=
 =?us-ascii?Q?8RQTnGmcgXqkg7nqhDCRto1FGZLNCrZ973hXoFi6gHIiqr3iLXz4N+9LynBc?=
 =?us-ascii?Q?ukmM0AIQ3Hu+LmkckXvq+UkDhrxzpvSkWt+U6DANLhnuhUEV9M4Jijc3JnX7?=
 =?us-ascii?Q?9ChYWb9W+yIdJhHf0Go4RnOSe9FL/69XwDhgCF3Fvd7rFgnboluejOBBPLQ2?=
 =?us-ascii?Q?K2VDUHzrP6fUoW6KtbrFyh/kP5gRvii2y3gK53wlGlYQtyEetVfgI/SCrpgf?=
 =?us-ascii?Q?36QVBGmlP32cj3J6TdoaNhSEdRBb8goHmQT3KC675vdFl2L3QM5lEPaaumyr?=
 =?us-ascii?Q?HtflAlxHXQCvHkW75m4k9R7y/NoIlv6vRC0QDaoenk2VhV67XUNCa5TZ8HI3?=
 =?us-ascii?Q?RTGmKO2L+pKiuKqlMNwmRcQlA+72A/Oi611AEpdcwUu561ZdTZKBVDMcSFk2?=
 =?us-ascii?Q?8hincQhzlNKvccHCMpWIiNvJXfQvVaMpOq1eXjCElXamixwoX/nw+aPZ59XS?=
 =?us-ascii?Q?pH+SLzP9WIQ+TJGLYOBl/pcQLhVkMS2LeIytz3ORVZSRjnPYwwktAj/WBVLe?=
 =?us-ascii?Q?COVkVifjEJ/3qnFOGi012MIJN9uExezoqjQoIUCTbYl6hPHzON+A6W1/ad0m?=
 =?us-ascii?Q?gy58b+ALokIyXHsXVhbdvXPU4wx4jCxqEwyjJUIR3ocoQbI7onX12TjLJWKf?=
 =?us-ascii?Q?6o3CihbDzqzYtqoqhAZ+tqGeUp3csqBSBiqsMG683NDejH/G96IxdnyTBo6h?=
 =?us-ascii?Q?0OCLTNA+dfhw+BfuZ5psIjGR3KYpOOJVWTRepDpkhMmkcMLxATy7N67u75VH?=
 =?us-ascii?Q?ygwZeksBMgtZF4TE22NpaTUwy/SIF8NALHi5+PmW6PVrAeVXIIrd2XC6756v?=
 =?us-ascii?Q?2NDOwaDW5mQWN0nDnLRsLfBkJdrxQy+SAgCrcX0y5cSKCzAJ165ceLGVIHVx?=
 =?us-ascii?Q?d+R0Ml8PdiZiQiNfbO9mx0GRRj9fVz2RxVkUNbKJvaGR1XuHMd/8IPu8kZzG?=
 =?us-ascii?Q?WnoluUHr7BIK31R6xwo1jDaDToDcID1Dhrsz9JfpRv9ONxPmSYcRKpvUnQgf?=
 =?us-ascii?Q?A7cNDVyN1BdMjXjNMcypg8TdYM0sUbeqcwsdQpkdTDet8adr99kdvfNHr5nS?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KvjHWV0O6W9FsOCOPAD9jXnL3ze6P1YyHJoHlyU4yHxy5xjADTxikR++P1RvNCuXrH0weFDvPGhgrc6Fq/R65eFTnbpBYE2u0N2LIWItwBHP3ejVSDOosbW7RuU0ilQqzbmYhPshKgBgYwYSlKPFlZm49/p/TRzC0SuM9Jv5c3meZ2IzJDOnWubr9wDgloPF6N9PCFrm8u2ar9Hv9q003KSkKs5Rm3aIIZEgEKm9o8J+2B0Qiu1CQTHEkTb2Ny3OXc6wbbdfoggBMrhq5bRvZzm18foOmIoek64jVRtOBAl2m9Ud15PBtf2dPljYrkJeTHPNB/FujvQQOzqG9FcNx+y64YmuR1aul3OosK6cUBGpSbh0jEE3XySQeC4ChL0uJDzNVt4MPSD4LoLnJfBqKbNLKaVS+E2BfQwU4BbBwp25i5qVRk37AFySD1/HJdAHShzkYrxYy8UjN3U64BLZ5EMPB6l4NGzGoQM7i9YKWzR9ATIqtpxfrFToZCP/GlX9bZcHPfVTUBJOMrMdKaQsQqcxBMp4mkPjpVdsXZHk9tTCD8+fqDO1GYhNpA+JT7w1Ce4BpSjrBwFnVnL1QWP8zKuQfYqV0eJrP8TbgRWbjf89V9+uVStu0to6I8VbMSQ08vYQq/+rDhDlhkl93m5v6uCTeswddhAAEVTCBYjHyeJvx/T0s3KHa3IyGdjz3o3PBVbvaqMrK409ydjnRdg6yZrzCHjV24tST07g7mg6xl/KNOSImhz9LfBaVxn9kPdD1ZpaFtiFFQuI/vtmEKpz+XJqzRBVlxNc2oQHzrj/FTS6aRse5AErZEb1FrpuJt7N7sDuB4fK3vvZk7YUNSasnOQKsdqPU/jAAhfT+O0yXbCWyrv+POMGzfH92FQqXKVxKxHaR/trup8XNNDh0o0pHX0VGk3NiDo7bjUkHLB6e08=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678c1af6-d2aa-412c-a7a3-08dafb033551
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:22.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gitym+CAuEDnt45XNOcUUN07JCjVtowsljSj8LROJkc+9c7Lm3swXr2wr3V9iyzn57bhjUqZmWOaJDg+ADO8ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: asZ9Aj0fqy-4IOoBn_6bDhu45JIvonVa
X-Proofpoint-GUID: asZ9Aj0fqy-4IOoBn_6bDhu45JIvonVa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an invalidated maple state is encountered during write, reset the
maple state to MAS_START.  This will result in a re-walk of the tree to
the correct location for the write.

Link: https://lore.kernel.org/all/20230107020126.1627-1-sj@kernel.org/
Reported-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1af09c6f7810..14ce355e4149 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5608,6 +5608,9 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 
 static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 {
+	if (unlikely(mas_is_paused(wr_mas->mas)))
+		mas_reset(wr_mas->mas);
+
 	if (!mas_is_start(wr_mas->mas)) {
 		if (mas_is_none(wr_mas->mas)) {
 			mas_reset(wr_mas->mas);
-- 
2.35.1

