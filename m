Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C726371906C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjFACQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjFACQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:16:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631D0195
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKXv0m032525;
        Thu, 1 Jun 2023 02:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wU14PBuTjC9Yf1nsufmd8IeOziKTsVC4KgDaYYEL8V0=;
 b=asrujIQQ/aPJPtpiR/ujC6htyjUqgeyaL5naVHDmLOrlayBBc5hJQwV6L/0m8Dmcu525
 WFFAKHZE1f6DMrhjRaQI7gbiRjDbmiPTYeSey+cUnBqXPXvkdm3XSv3Nv7RqEfFjTBjk
 qHd2LYul1TfHMokdzQiJX3DNA1ZbSmofiuheAd0Wl9cUPhiwtaXdCGCzO7E3zOGEzUtv
 Po+3Skm+4xzaz9iY8Pvj3N4UG+5VTUHG6a7ahqYC9Z7nuqBFD4hKMe00dud51GUaNnkT
 6VDb5kaccvROMNKXx8e70Ki4qUBhqi4BPi1e2OWOrSTWIBTAnA8+3aJD8CxGPezH+oX3 Nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb97hv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3510E5VZ014631;
        Thu, 1 Jun 2023 02:16:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6gr6q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcFwpI44CtimFOFwH/QhRUHdHmfa9o17BljAfL4NV5313Hxf1e1PoJRrpq8JNmwLYWiKHt8DCR1xjQxAmhv0aYGGBrm53oSI8q2EuD+/HXjUKalcxVsbvJuF3AkD3otUfKqEmCH51T9ZnMIW4MnDiADiHntvNJGkdnrJHXDnYppd9aZAb4iK1UjUVD16rppT8V6Dmr62x66Td0Fo8cynwNlr77MUBWlcm8hgjpTnmkMkAv3wDndWI7IimAK0o+vcsPLYtgcIdC/3tXtSs2Q9/MDP7J7T9/P/0FSXoHzqaoSD0GWaxZxzIAxFnfri7UT3lbNMAHsZtabK44LijGkwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU14PBuTjC9Yf1nsufmd8IeOziKTsVC4KgDaYYEL8V0=;
 b=DDXUHLU5YE6pxtaG42+4y5uAXmSq7NGPEWHre9onJz5D6Wk6O1EFbxFAFu1fpg/mD4Ma2L3DRJJZNRR4rcVZCBQ+RaYn+EbFMr7Z4ggJK+AofZEWLJ54450eZx+n/ZviBfrmAID+szRFgDSxDlYdzwRpsVMGZnK8A0RM1mutWO7UH912HCAdwvmt1ssfmsJIc0ThKzFsgKC/+WqriNiOnm8yjLkT+wQVwojGP503usc4TCNr1kZFoLy0DDQgxGX+/Ea2UnEo2rJ5z3LQsE2iykDeEbHak3gfiiNkS+gaj6l1wlVU6S9X9WlRoCFD551b3+0mPNBH2V0OxucvMZ/7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU14PBuTjC9Yf1nsufmd8IeOziKTsVC4KgDaYYEL8V0=;
 b=QLMRCCOEqVRqKi/upUToE+kOCNBRh2L729+NYEh+g0upp+ByzNsdKNIlT737doWoAvg5kdxqOm7MHx8SVNitgi/qgUeRiNCdIGF+kltMj9dWLD3imPfZf5kRvcYPwUP8Twrqb1vhjqeWe1Eo7xgv19xZcjJ7N2u2Kfo4SCF6kiY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:21 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 02/14] maple_tree: Add benchmarking for mas_prev()
Date:   Wed, 31 May 2023 22:15:53 -0400
Message-Id: <20230601021605.2823123-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YTBP288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::31) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: b81ed707-260f-44b9-42f7-08db62463106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZ11cKNM6CcmAYoduajLYnC5f3uQKhe3OJcuqKBR0y83jsKSHIDO9VTZtOW53cLaCxd/eIOb18+7p2NyBLRzFq7wKPIjrbu1fjEXqFiJSDmA2EqVQ0ngbC3ykYhNLHryc386+F4C9KykTxZw+JhD5iQ/3rg21EM/QVS56bbdku1CgSgeqJqS1kc6TLQhioeya+i4J/67uL2AwqiCFeLGlDIbpMvfyr32NcRa7dFWHULLo1TQKYCcsKHQDL3P3B96a9pv0mXQD+qwDgiNUoc3aNkvG70vG4drUOHLMPsNzGYdg/Aii+tMVXfrLkzsBJK9iIRgApwxo0gOiAXoUzBdbS9VLO0H7T9G0ornTYtpJrolH2DT8RJDf90MRkOHN1EFtCHyU1Xbf5FJwFQ63WuovPbeM9cmgJlMBaezqruB3FswHqSD8xSFR45OCAjof8UGawrSNOGVZCFAlWDZqaYnWd1D3lMa4dydpWqNnvm/gMuGzxQY0GYJMLSWTfkM4fm9OabrZv+jb2zqegxd/HCA2jcGpdLuAskduJZdcilenNke+r8Cew2//eRyMfjMufr3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sIK3dSqnxTcUzFKrJWYu5+gRCteGE8JwrlHJpFqUWZciw9bkavpZ+4EVv56f?=
 =?us-ascii?Q?5PYNX47dYnUpops+/mthf6D4UvGxVzucUaF0VHJVjsEt9VHdkxCiAvA9KuFA?=
 =?us-ascii?Q?Mx/Txz4VyEO6q9KAOjHI5hnQ4z5cvbR+B4d4DfYEoHcm+Fj4O8LF6uA4PTnl?=
 =?us-ascii?Q?I1lomJ+IuN5E60wV0lXOwjiLogPCTBz1/C0XTFsHtbrRUDpPqqbENjY1umsM?=
 =?us-ascii?Q?wmAKCs2w+vWK0hyLH7eP3ofhNxjqirlMElGKBgXxIzD4WzImLRBY/3C/1KP6?=
 =?us-ascii?Q?dKOLSIXbC5UXpSx4b+g82eBJ1YJ07T4/xuxnHZiIvVBwqvZIlP+2E73K8wma?=
 =?us-ascii?Q?eaeWKOu5MH8dcBAS9pLoB7dWZoZCnDImrcpUUN3Iahi26mQmcJ4ll7J85WCC?=
 =?us-ascii?Q?//v450TBU20ANgzixPqLsZtNH273smLTIoN+FmdlTLuLwLul4LLPAiDp8SFY?=
 =?us-ascii?Q?dHT7NX/+SrSKNmQ048VOMHoFGxnXeWYwQXpSU+/pkFegIFrg9Ocqu8PExWxv?=
 =?us-ascii?Q?g8psPbg5ozMGST0aiMYIpWhixeTkcse+7NdfwJbx1MWpXSQqDd0AbLMC/XWZ?=
 =?us-ascii?Q?CBCDiK9sr+FpKXc7UV6DsD+WD1NXj5V8milzyxOoml0dx93ZPao7FT8652qe?=
 =?us-ascii?Q?IN/0AXINKKDoDnAPYnx1voEuswEAzeWAKApeK05CO0W0vEY+7r2UwK2dujEv?=
 =?us-ascii?Q?D/qhN/38Ac3vuGZW1CjTEp/d2cWWzHikuKj7LzhNutNsGP8ingi466KkmAjL?=
 =?us-ascii?Q?kMTOTioWwI41kTAAndHEzsypdUyWIwgSk778mJU2R2U9MCsz2S4JlglE11RI?=
 =?us-ascii?Q?Pt//AkphHiv3ITVHevHGNYHujIJ9Ukc8AXYVtG+j+bneDb0fxsQ2OEMXp0PI?=
 =?us-ascii?Q?yHLRKGgKEmd8EoBgON4kyxh1NZ6mRsIdsDOM3htJ/gfY33N3iY59wJBq8H7Z?=
 =?us-ascii?Q?2Siq028AY1kF/twWLS8YZ8t4BCa/+YvtdXJIKe2Gp+VY6YvT3OhOLxr8BYws?=
 =?us-ascii?Q?UW0ZUuo73qZaQAc32/WM2W6n16m4X0p24IboZbutanBoyYCCupZtT7RdyBj8?=
 =?us-ascii?Q?b8Bkz3aDLkyEOngNENES5KjEGvm7QDdmhI81Luq0/X0wmS+hJdLpTNXCw1Z6?=
 =?us-ascii?Q?2HBxVzwARJwE0UEIaMt2aUoNNtuQUxr1wiwQoA6FhYRCTa/fOylr8fDGB37Z?=
 =?us-ascii?Q?rBjuqVPsuQYKH8xspCIJKlLGWy5todikuUfCdwHaLrAFq9IK0ZJPV/prF8Ke?=
 =?us-ascii?Q?EbMqGUuKhniapPmxB25jWKJE7/KPTfVF+2zr+NrPO4H34pUvfMsm3zjClowD?=
 =?us-ascii?Q?bsyUGXHVuNynhb5XZNHMCL9v4Q5x4oD0jINtQ9lDsFYWqPEgsnnyukEDFBoc?=
 =?us-ascii?Q?M+t4sVWlUa8rimLTL4Ck8tWJrju832KhvbGgJpvcBxNc8FqAWreY5Cl8TCcu?=
 =?us-ascii?Q?Gl0B4JzKT8EQUbVP+ttq5oLIpHhILOQnjZRCoWT8PHoUjtIVR/cdzvg2Y5sq?=
 =?us-ascii?Q?P4W6EBU3qmcBtg/QXtD5K50iT+HRdpIAHxcJunGto0/+oguUj4OnpDWwWRZw?=
 =?us-ascii?Q?mqRttRKU45eKmNSdi0rHved6N4yZ792Z1Xr1G986pDKvEW6H72T6bRJ+QiNV?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BXqogGFQIO3UbyPLgbjQfwyzUWmYk2XMtefLFbrh1RqUVFTeviJx4lp8287qiTeNZIBD+TjSaYAD6TPfyPasWNHanoqRrdxQ4B2qBdzomCLX5c3XY41sGVs7O8IUSidO8a/Wb0jW1hiWmc2OwuI7EZP70mH5JGEjJvlfBrT3u44zze2FThJqNCTw/3L4yiwk0np7QkUTHR+d99KkO/RiQ4uZ/eLllJRX4K4a2NhpMXgDV0OhM/q9i+OrFD0itbvlUThxyd9GPNUEY3whEw7WWoxZY/HSyDf/Y4C3dP/SG5cD5DSHnIrwvXLUJTwvRhdQpSZRD5+nqgwrlvaJBguJ0kiDjwA+O2g/Tw7lOMgZrGFChEgi3RwV1DuU8cXnanYjAJKv8/lSaUSVcGiQJNz/8XYLBv4RUEn/o4pUy75v31Y/3ruxJiAq63neTg5he88j9jG7bmi203wEh4kM+7JMFBMfocBWni0I0RWRk7RL0+sg9cNr2LtWKdMk5naSM1QsX8NgYCq8Jh1vZTb5FPUNZSHlz5ZfiHGOWRhgIIIKspM5MZbEnZp9IQHEdw7ekIn4fW1UgjhakSSewAMVl0x+c3KtXwkQKF6/J0TABPjS4fu4dsyCuSz+/wQRuCO3TQYRCzDT+8I1ZetslWHnB25uKCouFbzsBvybivl9e/w9lVuR1GOhdK7TdeV5gTpJDp0bUXSfHu3l5K0vUP3MkaRg2RlnpTfzvl5GnA7739KT7QX0ruZqKhwuWCGCEbyqR/LW4rt0KoqrbZekyyn3kDGzv5s/QeJ5f4PIdDD0sVQ4aaxuOz8k/qc/8ApGhBnffrWZKzifkUrW622rp3Hb9feNFzJB0c6ko+EeTqcdxsS1wQG983ELxRKMJ63FBH4fneiYwNM4QYm5EK1Tm6pnfvuSEA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81ed707-260f-44b9-42f7-08db62463106
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:21.4090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BFVPNrLG8CzLS9nul12DZJNoG2iYcCQ9SE7n86r2D2lCdT52GiMSUMq+0rzJnFgKIRcXnJhcejxshBaIilbaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-GUID: aDNZbnOv52S6_uTnPGkmds4wTCBOHyi9
X-Proofpoint-ORIG-GUID: aDNZbnOv52S6_uTnPGkmds4wTCBOHyi9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 3dbf99c3f2b1..15d7b7bce7d6 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -45,6 +45,7 @@ atomic_t maple_tree_tests_passed;
 /* #define BENCH_MT_FOR_EACH */
 /* #define BENCH_FORK */
 /* #define BENCH_MAS_FOR_EACH */
+/* #define BENCH_MAS_PREV */
 
 #ifdef __KERNEL__
 #define mt_set_non_kernel(x)		do {} while (0)
@@ -1735,7 +1736,35 @@ static noinline void __init bench_mas_for_each(struct maple_tree *mt)
 
 }
 #endif
+#if defined(BENCH_MAS_PREV)
+static noinline void __init bench_mas_prev(struct maple_tree *mt)
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
 
+	rcu_read_lock();
+	for (i = 0; i < count; i++) {
+		unsigned long j = 2495;
+
+		mas_set(&mas, ULONG_MAX);
+		while ((entry = mas_prev(&mas, 0)) != NULL) {
+			MT_BUG_ON(mt, entry != xa_mk_value(j));
+			j -= 5;
+		}
+	}
+	rcu_read_unlock();
+
+}
+#endif
 /* check_forking - simulate the kernel forking sequence with the tree. */
 static noinline void __init check_forking(struct maple_tree *mt)
 {
@@ -3468,6 +3497,13 @@ static int __init maple_tree_seed(void)
 	mtree_destroy(&tree);
 	goto skip;
 #endif
+#if defined(BENCH_MAS_PREV)
+#define BENCH
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	bench_mas_prev(&tree);
+	mtree_destroy(&tree);
+	goto skip;
+#endif
 
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_iteration(&tree);
-- 
2.39.2

