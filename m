Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A111B675A00
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjATQbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjATQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:31:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B18298EC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:30:30 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBjOF011480;
        Fri, 20 Jan 2023 16:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=xjY2jrdY3QZJ9w8k+bVf1Va0RZBvVfRpOJUI0biDIh8=;
 b=Yh20tt/EteSr0fZm/bmsSyt2IFw6ujx+fIm1d/1Ua4RmmPccgdZ2+pUpqzuv+kD4wiOv
 +4dh6JVRMRwDWTmyw83F+qcN6Qd/wQWBoReyi8bTlRDN5rRM2NV6H2skTFPhB8T0IQnJ
 N/0xY+TL56XrIsA9Vt0qCfrD3f5Yt7CSBgRBnQPT9Cm+nWatIZXDLKLuJU9uWnv2w0g4
 3diLOCpiRwJoB6AH3eq41Xr5lVA6ZQagQ25PBZpySl5qdWZ0XZ4cHouAJiTcuzT+eDWW
 pKVJGz5bffKCZX2Q2ROwNQ3BiXRJgsHHwny+nWB1/PDvDau5S8skuUvFK1d8RrRlqEet aQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895aqsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGP61h018673;
        Fri, 20 Jan 2023 16:28:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quja1da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtmHH/q2yOtOh0OSXtNysJqF7plAAPV2L0sUBesTabi4ID1602VQCrB/zUoDXZuw+PwwVQNE2OC0rpp27QHATpKkXs3yAX3P/FVjgja2tbphpgC+PmtS8+qJq3vnTJNUw094CujLezDreV7hAriXGmDX1wGvGdgxpqG5pTQyZQiqOZ3Lasx7Hu3ZSXP7mI/agOrkvNR4+hyDuhsePOnBdRlrMwQcoKcQjvGyw100ZmLU8GpgUk1CEiQ171Yqfs2NHAvy2eYeXgEcnG3kn4DNDpflntljeWLMbWRWpmCbp2WmEFLvOa4BwpJS4GAXzWYmtI/yA7J4o8W66d/bm9GyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjY2jrdY3QZJ9w8k+bVf1Va0RZBvVfRpOJUI0biDIh8=;
 b=MKpBUsJoKxuv9yv1+/IfMW5ohTvotUlUPI2NuPiWRy71ficGfpFdrruvr5/r3aJX9BGGToVHp26bKQMhoqNv6Pw1b7IqdlGCd5zLda2vFoAyAmcy+pQOxMWQLP0Ywoouee2lgaQrGOipcq9E5oISIkwOtgrwBej33ODNnPFbA9SLW8yH/cBSqz9ut/wmn/fzwtVMzKNwfMq+kbPHjqGG2VHT2wInbbuNIR5FLIcjCs18OKP4pxLMGjgr5nMcrZqe8KeSxEPZBB3ZelkZIxCydXpkFD4SLX3MKo1+opAC2mMFHGRpj6MwKe9dqtT9/FwHs1Gwx+0kQAIyZxWo3grfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjY2jrdY3QZJ9w8k+bVf1Va0RZBvVfRpOJUI0biDIh8=;
 b=sGYi86FBmaIJl8Zf9W/EaoMnkQX9GfxjdOkulMA8n/ndqRtunU+1P9/GaWUR64M2hpQ6DeWvouoqaohZNP2fEkkPEVJsui116L6jc2LezkmIs+bavW0ep7Ezn8g/0NHxik8wKwHvbQlSmI9kmgS37sdzH/cXPYuNaihvr7N2WfQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:52 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 39/49] mm/mmap: move anon_vma setting in __vma_adjust()
Date:   Fri, 20 Jan 2023 11:26:40 -0500
Message-Id: <20230120162650.984577-40-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 703e6f97-6763-448a-6eab-08dafb036adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1j8J9pX/f6AI5/eqitFEsww8z894a00eHLvHEGplg6PY8fSVYLlEBbTC8T1SmN0VDQFRTjGoHQvNaNllxPZdtpcHVDIMIe8t23nb96wbMasIoYbHETB2z7Hx+I9Fq+275iewSs0nAEYtYjVJbnlf3LvASATzWmw+5BRsrIbRuUx8YJ/R7BlYbGotArIlitBU9IflfPT4Lq+EQdeHFY+ZDaLpozjCIWUSXTNiAHaS48IFKXomdo/aP0khCZ6y3KNK5S3XhnbO85KlSy7N8l+3H5wiTB8GbPiFyRrbHCSDNagsaEbGxTikE9BTB86db09cSRJoFy2l8qBVHX4YBhCBAjJaCzSM5xK27HG3UqJAg8aI01B1XY4UeBBPnkQzWioTMf68AfISVBvaE3cVJ4D9jmX2NqzhfE9AJw3xq+dvwmfLn8iusgatJ9zpgEu3AUmF/uhvpjI1wrrNaYoLgl7iO6/18YlVjCOGqQHXMXk/B5vGQ4aJjKiOVc+AJyj935xkymYhbeW+canKxhCfTYJXSQA7t/ty+Bwq7hct8HpfAAhtcd/Bj54nW03U6+v7OyLP2z6MnI6VRLAMf/Au1AuT3oH1CbWsoW7lnBrFVKx+i0QOJ2sdlqm8N3wlC/Hofn7a4yhVwKiC5CISUb9INjm+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(186003)(2906002)(8936002)(5660300002)(2616005)(41300700001)(86362001)(8676002)(83380400001)(66556008)(66476007)(66946007)(36756003)(4326008)(316002)(26005)(54906003)(6512007)(6506007)(1076003)(6486002)(38100700002)(6666004)(478600001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3f1k6UTK1thm0s9UHEKTwmSOPkL+73p6AqXoirtDCNZaaX+x+cPR1N/hWddO?=
 =?us-ascii?Q?O9eL+dhE9UIj0zn0I88+gkpPj07MuSr1T3HXyGyshGEhjEFPX1+QQNUluQgQ?=
 =?us-ascii?Q?XMSNSs8lJ9l6rzbqvqaGmBSX29lyunnYAizYOX/yNUaSZFfrnMz4tjnTy14D?=
 =?us-ascii?Q?VdgcoEhk/qxKD3XwCd26S+8j9/h6ISAP/rLGiyK6Nff853Eoy//RHqkE5cis?=
 =?us-ascii?Q?KQWOZ2+RZ4Ns0WFiNutPaOrIfNmWEHDJKs4D8cyEGiAV4snme8h7HmssA5SI?=
 =?us-ascii?Q?dvbRzce5+968tqDwgtMbq127ZxZprr2IhnO1/gpSABn2yo1cxcOgwG6/Jyg6?=
 =?us-ascii?Q?rLpaeZ+jfVdluo89bnEE1CGnkzD/LNV9BjR0ERk/hdOsn7UlsaS3OseF0V9a?=
 =?us-ascii?Q?Bsx0DmC4/d6w9rCpFf01TS8MPP8sr2rePoLiOqXWYnG92vrx3DxDifz+V8GS?=
 =?us-ascii?Q?StgjjRJIGcfQOuLTcmyOKsSLwbGejWFqntRqUD/24z18e81Hxomcs+V6NH1f?=
 =?us-ascii?Q?6Y1G0PEdZZC2HG1zlpRDh/n9cfv+PzXqgd3tgEAqBSIUDkte5ILGTZzcm899?=
 =?us-ascii?Q?UpCo4H5vI9cPzrSnta1qqMUms6r9szM+p73ERAbczS1aqy1WxUIFyqxLNtg4?=
 =?us-ascii?Q?loDKKPkQL8i99mkOSDnbgG7fQwXR9TO1fFV5mwdVJrWah4HhKkGMayLu0wJJ?=
 =?us-ascii?Q?RPBAIHxE53PnTmxQWEm66nShRGsj21R3bKKPyhKLf5JZ2BnZAxTXnEWSwxRg?=
 =?us-ascii?Q?c6r42Jdz2bKWoS2JmKSyVnP/D6Yrd99rQJzuyn0zUBPKVVo7rO3mFstHb3IX?=
 =?us-ascii?Q?Ot6kZNrLjXNkIKZmqDOUvfwTimmjbks/57NpE9faWc2xJCEju3+ThdA/QbG8?=
 =?us-ascii?Q?tTTi7UcVhb9wOLKf8iQs7UplAVL9oY3u+jJVYndsjeVR3uXfwvGOGLMPNP/5?=
 =?us-ascii?Q?OxYdiUAiln5ylx5DgyG+rC0naF8Obc6guKhjTdBZyy1Us1Mdxcs1i5oBnbXa?=
 =?us-ascii?Q?FMU6CMp+7/6fAlu5xAZfj4bsYji1YdNJBzH1lQFQTfN35cFW0Sl7Ksy9f1/d?=
 =?us-ascii?Q?j7MbDwb/J5UMlucZKw0b3W90r1I1IZwwVXaODGfyU9ecL/KHMxHBs5libRSb?=
 =?us-ascii?Q?bMjSOAco1qyWSpEJTA5uUhJaM9m8D+ZM/KnBA2HmguijYHVyFsTsCG4/nC1a?=
 =?us-ascii?Q?8PP/RhZpR8/QBaNCAAAAs+46bJCDPqqWfyzhwduMKYNM/semd7GbptVu/bcd?=
 =?us-ascii?Q?9W51xe0PMSCUXnb4mdOg6/HX6N63ToGjh70VeGP6XBju6Np5sB1Ff9WnwT65?=
 =?us-ascii?Q?Ra4D3Whzw429hfYYmLs48ZpBVPRF3e3CEjLPP7P1vnrMYWoy88SWQIUqr/j3?=
 =?us-ascii?Q?cWx5p5nShjko/J7l87UO5xXkCQfHCVktHNQAd8YT9LQxopOirl+tR19/dc+1?=
 =?us-ascii?Q?FPIiBg46b3+1udaSarZciNBsPaQVupdHS6PdrVRjquBF6vBfgnOcsXaZLOHM?=
 =?us-ascii?Q?iD1+bS6/gDzWw/6/dkun87wFyvup/MUKkwsLVvLeLV+RxlTDU9OJoBQiU+Yv?=
 =?us-ascii?Q?pdeVX653H4Nh+V+zZrm3z3vnTLtE9r6M+f6wN8OpYNhKtCm+Q60bvQRS0vtQ?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cGr8aZ2aRCmlf+pm7GIecX4pBR/TzBvASObIrmoHR4g3ihkvExTf5vfy1zJ96xOGbkni0bVfUlq16TASZ1MkUTsxNa2VjpIobJWcmcbffARUUQei3rlvpTyao0XUfG5/PKoSf/xyC12589yo2xYHeDHJvzkm17ycszyrSGxUVxZZMX+JivTH6W8vyEWqhNQngMOib6RpAFCewNRXoVOJpbkLJuN8Wru3bEWiYrp4dtzz8x9x2vrj7HQPkcqQwHiDYETFDR1NRDB00ZUfhT9cdYAxnkX9+BHaSQXkKTccj4EAufQZseI70RnnMlJmQdlpNXBp+vBYXITNWrUO2hGAeKPcsloVlD5tchQx/GvlnxF+LXqDzbOKFKr9iuMfZRhiXayqXnunaos0158081V9ndM7IpGwMIF+Gswc1EkK/q5cZr1TeHw+GVH2X2HbFwuA0hFOMl3GWdDOWhINGtCz9MFte1Lj5zlKXc6K0nAeCGgHxXRNPd42Nzc1M6ahT4L69/3mHzSuUbgPYpnvktN1f+6ZP8bj56DoLtTH22qYq9Xzqk6dYb5B6y2xYwELvV07LKDzCJeF8SaXvbH5uKkE0xuovolpiyAx4DN6dCr4AD4YHwhhzgGJfDWs8eC+q5s+wKVzKt1QFw5DnZWMp4WufvLKUXkWUF++pX2RdUko+j7LX6gEne3DiNXFlbQVPTLWRphMOJMwMrT+cXRwsdkGrtBlPfBOXAX1NvhAhxjYex38jt1vga2N1zQOwds/RSil6ZwJ+Jgr2eYgXkbdFFlpvarYcLr7b8ZsH13FxTztfl2yfYvL9hstYmck72siWlOurD7cosAjuOBAdQ1Ea1C8aF2/4s7BknYK38Gsd8b9NBAqPH479NuOBHJbG5J4aRYClgavlau1Ya+slUOomk1MvA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703e6f97-6763-448a-6eab-08dafb036adb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:52.4460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XXQ4uu4q5ImH7ydM7gVqU9MnMYEqJy9OrOAc9Ab0H3QvHVAXP+t7Fcre60wI+LLLy7Wyhxn9x6z6pCb9q9hJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: 7K5CINu5TmvjhHj_LMF9JfLoz3XHCSsE
X-Proofpoint-GUID: 7K5CINu5TmvjhHj_LMF9JfLoz3XHCSsE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Move the anon_vma setting & warn_no up the function.  This is done to
clear up the locking later.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 56483b837ef9..b83c70c59a76 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -685,6 +685,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_prealloc(vmi))
 		return -ENOMEM;
 
+	anon_vma = vma->anon_vma;
+	if (!anon_vma && adjust_next)
+		anon_vma = next->anon_vma;
+
+	if (anon_vma)
+		VM_WARN_ON(adjust_next && next->anon_vma &&
+			   anon_vma != next->anon_vma);
+
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
 	if (file) {
 		mapping = file->f_mapping;
@@ -706,12 +714,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		}
 	}
 
-	anon_vma = vma->anon_vma;
-	if (!anon_vma && adjust_next)
-		anon_vma = next->anon_vma;
 	if (anon_vma) {
-		VM_WARN_ON(adjust_next && next->anon_vma &&
-			   anon_vma != next->anon_vma);
 		anon_vma_lock_write(anon_vma);
 		anon_vma_interval_tree_pre_update_vma(vma);
 		if (adjust_next)
-- 
2.35.1

