Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D862719078
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjFACSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjFACRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:17:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06031121
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:17:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKT4XL016257;
        Thu, 1 Jun 2023 02:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+CgKikc0zM0ALiJOO2y1mRbuQqUaVFROXh6PVzYHBVU=;
 b=kgYrRywKMPDTTAap5I204HTZ+93306VMNk56yo9w+vJfN7+UsR0C8RLwZh/i1ggKRrHW
 8NoFO1oB97vm/OlAynnrmh49JsnCMT0HyYHr+aENjMUE3MxcDv1JO7ycu3VmYIwkek0H
 BgzPdgel41/Q27fF5uaES4UNIlo7MD/3sHNPoCPPhhdnaO2AEkH3xzqBzAYcjzciIGjp
 nmnFFM1h6/xMJLnj4ZX2ebBbEX5iq8OVjp1wLdIfrWpznNMI1Ye690/CnCJkgFPbz/Zw
 +dSozAEObYjpPAslkTZsdW8ebwl+btLqb5J1xVCDltO0C5DWBgDX/Uq0WN8QASI2iify 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmeqhqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35116JEI000447;
        Thu, 1 Jun 2023 02:16:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8qb17j9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAP6c0YHSQd1Gb7l9xvIm/Q5olHD6TGxSgpfMdO/oJI21K3QoN9PWq+nq3TbpPoZnC9rpDPZZ7EftCETu4ElV1n+QwD4ivhCAyzG5LlTBmXlxwywANe6j4julllSyyQTcqZ3fDp1/6arRvyOukH0kCdXUrmiNrjpF14WSg1HTbjn0HLZ1Ay+WD/DhnyHBNMFk8FNDBxHrWoHbzNd0ZvjRq/jESNK+RYSC3yn4WZzLjDDRPI/kRqRGDEGLYb8TUVEHdPMS4FHVE8MvMEBl4qxbJwUPJkfDEmRbLxchE9mijrn5qvd0nMjG07cy7ifra/1estus8/75MB3uCU/uiSXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CgKikc0zM0ALiJOO2y1mRbuQqUaVFROXh6PVzYHBVU=;
 b=UlLDXiOB4RGhMc7Vpyvi58fXDM3IwQGIK6qDFfymPLzo0shXnUh8VtzqdJykwG/Tw/+TunrghkLEC5tDMgYF6rVhgCk9ibPPFI34MDDLdF2/ylAfxeqG8bBAAdQkc8nioN3ZqfgYsJhmwKcINrD2blAAPo5bu3Jn/Cj6X60+KjfYUUxiuo9RzVs/rQJK2Nu/tcIocxe4J1ZDcbc1f0pQ94lIPooOOzZzNAr5tgDQJo0sZTy61R2HKoF/UjycKHYbPzkDbj3Axe85/cs7wC0DXDL/lTI+Fb/USnOtciu0sS9fvDkUjRTm84OBa3N9cHvbtwDfXEElngtbNoodjBzBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CgKikc0zM0ALiJOO2y1mRbuQqUaVFROXh6PVzYHBVU=;
 b=AoRTCCVWw/rf5ilgTVs6kU/wWr7o/CFJvDy+bAXMczWITVF8hmz1FDjwAqkFgsZmX6drvt0YTs9/0wGDHJ0CKUeMxdohJVj8OrMtKDQsFh7m5t58dUAorym3klJLaYqopwjT5T+iNYKf57Ghglzp/czprPUZGRfw0XnSx5cCzVM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:49 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 13/14] maple_tree: Refine mas_preallocate() node calculations
Date:   Wed, 31 May 2023 22:16:04 -0400
Message-Id: <20230601021605.2823123-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 602bfc5a-40f5-4f1d-22a4-08db624641a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hSzVyju6dAy+SfvdmCoQX9dHr5Qfjm7g+bj4ZmOitUR6AeQBqjEWyXanWFNdyCEQQNWCh8mqDcbqXhB+5JNcMGK6F8YBJFZguNgqU0hw55pYta3kzMRYLCG3JzzxUNdtzctGw/YVNVNH3IG7H5vmDEgcYwK1hd0hzkvxFg+6rctiFVLjWyusRYGJUAJyiqSHs9VjmzreouF9fAm5UMWCgXJRamKMFZxSQuxMGblq/GyZjbBHhnn9sBqoKfx/aO4oB5byhjSti8t07A8gfmXTtMdBw45jilpaVxTX8Nw08hnBmZbgsjDnJIdri+uyYYa9B6PsN4BcxRDveAVV/dCeMKjNSdT341UdfDP3+7xugWSft4IH1ijWbJ31F7SLBt0iNKEHO4dLlgz1gfHRuc1gU4MTKsTCu+HhsB0tpC+WJu+/FkY0YTFH/J8pvxOpMeqrJwdLo72VpZDNsdyT917dJ2vJqVDcgYJHykInfXeZobrNTJiRgHKN2pX1bI9qty8Av8MuL0YNr+S45K0et50fKKg6F9dfP4M/e8tgy+uaOmF3MkqQd5c0Bfrg97JdlwC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BhNzUr5VGGxZ08KUdoh+MSBK5t93fT2ovRP9v5sEWy84NDTxLkBNpAVCwZ8N?=
 =?us-ascii?Q?OPTIgdJikWur2oMPzw+lj71um8/lQwy/bAhdO5VvkD0g3hwTVrdE8tE/HNQ3?=
 =?us-ascii?Q?0YjJwKRj60C4/R/L8GHB18xOoRwJXDRhfsAKAMuqXNTqxWJS0rpAG1pVCQhv?=
 =?us-ascii?Q?jhoWquzoaGcOnMd9bxel2AUwF+tk5Lz7fmiJNnaIH4QfSFRU3tlBdb9ofd7K?=
 =?us-ascii?Q?u5Ymv33f7C03El9Ah4826MdAbbynon8RJgJdEFgfpQ291KZX67HD8Ayyp23t?=
 =?us-ascii?Q?nEwIJpwyrqIuVwKAy6I7UmU16leUnO+SNb4b6ppjwEOU4g1VWZGKPCReiMVF?=
 =?us-ascii?Q?ttSjI8E8CKwYFUyA1+ODGu8LiP6pqh4BancU10hqr8mUQqac0k9p1mWEeGE0?=
 =?us-ascii?Q?xl/Y75h0XDSYcsIT81eMdcu0YdqvuLElYlSJMq0UuDfVr9iiNF1s4sNHb3sJ?=
 =?us-ascii?Q?vLvk+i7lncqdbBqjBuj6mrR5pZA2i+YO32EBuEhkpWHNZcgaS0/7vNg6iYnS?=
 =?us-ascii?Q?PS/WzCIULsFsJpqGfHCK3chvvfOlx9a7oPb1S1DqqGvIfhQcKUJyHSuRRc79?=
 =?us-ascii?Q?0zPi82HTU2zG8ybMLMCSXB/D8xe6y4UXkNKcWBOt1JAV30KigCvOsMHOhE78?=
 =?us-ascii?Q?VxvhD/TltL5jlpmsQS0TZs/yy9j1jNFYrfW3Bpju7e02OlATiOG5x0z0FWjb?=
 =?us-ascii?Q?WwVjXhou4fjvqG8j50JAqwXl6Nx7Hid3UvSV6fOV0RcP7Tabh8nPDpyPfOnK?=
 =?us-ascii?Q?TIkYncZzb3vJBvlrgoM2w9XlkNqelm92SiMQXs4sr0gleQiePmk3eRIbF3Kr?=
 =?us-ascii?Q?NH6bM9BqhuWjd0TAMxbiG2HScmiPHpSKPyz70SRpF6hutiDl2jiFbldqBivr?=
 =?us-ascii?Q?8oM07ILwk0m521mderixzF66IzW9mAMGrmbJZtxCHdRh2qFUorgFGyN23LWv?=
 =?us-ascii?Q?Yle1vhf5o+ruTy9oJRNfX+yi2c1/AsLyKcEHPCkf5SOlouweZaQBGzHy1xvm?=
 =?us-ascii?Q?KXmkUdB+wzU3ucLDgNJKsK0mkgzg3w9TwH5CRIuX+H/IxEkRmukvnXZ35Rfb?=
 =?us-ascii?Q?9dRIRueUt3bVBlUAbszwePPdO+WSuMCN2JCIF73rZo8TfkSIROLHXBWJx7XB?=
 =?us-ascii?Q?fcKc2GNyR2k87ekWsCr2qlSyipMOVnSMp2EAa7uQmXAxk9tfJ2pgsOUg4WrW?=
 =?us-ascii?Q?zMdukINAP9FtY0Q+vH210gznZgaMlE5/iRoV52YxLD48Bty9eTCzow8Hk8vm?=
 =?us-ascii?Q?J9xRixOJDkPzlnTU8ccb2B4Fx1sgyIZspRNqYyRPr5yY2l/l+Str0m4vtCVg?=
 =?us-ascii?Q?gYk6Y8CzEc7L84URTRtIUsCpl7uiRhyAQo3ZEbkSvNL7sY6zLgMAZcgj+KpW?=
 =?us-ascii?Q?kgbJF7dbccHQdkte7tosu4VlQe9RRYx1pyDMAceHUujA+AM7455GtOn0fGCY?=
 =?us-ascii?Q?qxuJSUXzzbNZc4GkN6srxm+nC4DAaX1iT1BYt0yVJAJe/t00N3vYUSeOmFo3?=
 =?us-ascii?Q?W8dLp1ldkJilsZnl9p0t11RVZtbqZuY1pqmN9aYxBkJKIRRjEcDLLMlMsACv?=
 =?us-ascii?Q?TZMgO8Bqf05+Xw4hCkIt/qW7atyWjxNsYfpHxg10Z/9Uhb3OR/ofLuKZVVmY?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ubaKj8CeTWHKC230aLGeyyQFvGeSCxHWGa/e0p1Rx4kPIz7BGbvrSWB4pjWOGGqtTX+Old6XhVDoQ1nQK1JYbj49BPOQKtdSx5jvVlNgfD9KKhhgnmYvD4EcD2fr91rjT7Vwo8Ul85QIigHJT50BhKWiQhyAMYPxQO1bXin+rZnSzedMAABEhv+8yecB6QIVi1B64KqwAa+65CYzbNsdLQVWxPg+5CIKCqqtRu6DDazSDPJQKMQWDh09hIJoJyu/MKUcx+ugFoYWBkHOXwiV44+pfcmE0/kmURWy2JDODCvRw8jVZivFTNPqOXi5njaGSc0fwuF78Km2l/9QbEqy2AwNDkl8SF5rmYwpLZMdIb+X+i9HoePKEd/jRuAK9FNsWn8LsMK/8rjo4AzX4cQF1M0gWSZruVnfcRgkErqC40k9wSZAvr6lIrhrTNUj0cGZqHzsFlIvWxuHBMXKtmNCQhPhxTIoTqiK4l7aNO+XIHnEQ+UJU6A55+JlkL4YzAEqHWkWvtJnQYxmnQwKp1ZWiiLI5pBnRPqVG9aNBcXHR2oH+u9nUINbhI0JP1kXzCJbyJIevNl+iFcM2IIJUyOZU/6IvwhVGVt9kbwvxApwd0SxydTBVuHq2BfSc2emu60dUh9K/hnFiiOK5ewPSfxSxY9wPIiZ6mTDqC8fXyt+Wn3fKXyVPCfE4gx26lvTwvmS52zmimXAMYoMGQjnenY1dMRubXFnqi8aW6RjkCojg2N4BPbz5JwpsataLRa37nWYL5T3DyhKKEbGFMbEJdyLYO2JITeXKbo/rrP/2l9O/ry5wbWBhjWcZ+MfXmVQGzMAIJW/OBjCs5vCGFnYLfT7PBF1BIEp2YvpUrV4TBO+LBAPHSM3IbXOD0lgs7kYQljMS4QU5lYbCqVuU3xFAPxJ4w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602bfc5a-40f5-4f1d-22a4-08db624641a8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:49.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGultGz7cWjG+O+JC5PZxB4fjG/4J0zHCV2jUsFOe8KQMwb8vA5oIgCBaYgvyqOyj0+aoT7bJECnAxTcJbcIHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-ORIG-GUID: gZ4mrLy89S_U6lDpyfs6a3oCv5AQ4Mjp
X-Proofpoint-GUID: gZ4mrLy89S_U6lDpyfs6a3oCv5AQ4Mjp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the number of nodes based on the pending write action instead
of assuming the worst case.

This addresses a performance regression introduced in platforms that
have longer allocation timing.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index adf662bc413e..5ea211c3f186 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5541,9 +5541,51 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
  */
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
+	MA_WR_STATE(wr_mas, mas, entry);
+	unsigned char node_size;
+	int request = 1;
 	int ret;
 
-	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
+
+	if (unlikely(!mas->index && mas->last == ULONG_MAX))
+		goto ask_now;
+
+	mas_wr_store_setup(&wr_mas);
+	wr_mas.content = mas_start(mas);
+	/* Root expand */
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
+		goto ask_now;
+
+	if (unlikely(!mas_wr_walk(&wr_mas))) {
+		/* Spanning store, use worst case for now */
+		request = 1 + mas_mt_height(mas) * 3;
+		goto ask_now;
+	}
+
+	/* At this point, we are at the leaf node that needs to be altered. */
+	/* Exact fit, no nodes needed. */
+	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
+		return 0;
+
+	mas_wr_end_piv(&wr_mas);
+	node_size = mas_wr_new_end(&wr_mas);
+	if (node_size >= mt_slots[wr_mas.type]) {
+		/* Split, worst case for now. */
+		request = 1 + mas_mt_height(mas) * 2;
+		goto ask_now;
+	}
+
+	/* New root needs a singe node */
+	if (unlikely(mte_is_root(mas->node)))
+		goto ask_now;
+
+	/* Potential spanning rebalance collapsing a node, use worst-case */
+	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
+		request = mas_mt_height(mas) * 2 - 1;
+
+	/* node store, slot store needs one node */
+ask_now:
+	mas_node_count_gfp(mas, request, gfp);
 	mas->mas_flags |= MA_STATE_PREALLOC;
 	if (likely(!mas_is_err(mas)))
 		return 0;
-- 
2.39.2

