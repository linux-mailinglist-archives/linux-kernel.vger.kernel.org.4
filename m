Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12D3675C84
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjATSPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjATSPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:15:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F47D917E4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:15:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGDnl9015013;
        Fri, 20 Jan 2023 16:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=h/GdLfDfbRHJ+RMjKX6CtoKZdT/+X9odMCcSnswrYQ4=;
 b=qEDLvh9HmLy5dGalB1DJUjzETeaI3i821US6CmaCxtrSOFxJLRw9T4jSOpNweCpN7Bd9
 g+aHZfTTrjViyj0KNLlIl90hf4XSzN8ghZx1fb84n25sS9nGvw4i+yi5tR+6eV48q+MD
 G5RYBwpeOans5r0+EyD36IHONBClJfIbAODc2S76/yyB4Bep+S8v6I2D6vHXOsOCWkRG
 91IXdJ181XYhZtVR2oyXOw4qss+CU66oCINq3fe+gKTiVrzYZcvRBR2sD+o5D8sOai9M
 l70W8V0BIR7io0O0f5PlRXB1joBk8m2gvj8b0fppTnIkBnuQ0lHVGMvG9xUo5TxMmt4l hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxtd22e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFA49M013492;
        Fri, 20 Jan 2023 16:28:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmfaxyd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8dO0VYRgSNIF27Cg8+DdAGmG42eMGG/EwnSjSPbPLgEuTNC9AgSd37rWE4ySM6Kb90EZvJ5WvvTcirWbnXOjAc7ZRxQOtu0DbyCciZ9vKbWfaFhXIXtTblBl1oG71mb9/NQl+w/FD5ZRMZwARuo3eQ2KphMtKQvEmfOnXxGcM0pc9OgBUXn70prs0qHDFyAaJlfnJHifT33MR9M2YfcQjYfxEwfzqi+5Kt9CyZMJcKTLZb1/FxJmknbksTXDhFv3J9kJMrXpeaRf/9hTsdKFuC5alMMjPu0YuzTGU3+UT7CWjrtpFEZbttLGr8jvcZQ7p9ouOVnh21VZMunyzqZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/GdLfDfbRHJ+RMjKX6CtoKZdT/+X9odMCcSnswrYQ4=;
 b=B3tPF5xGfyQBd10b76OAtwoaj/wJXqHmwN61QfmjWRKdZFTI0zd28M9lBlJDwhtwG3lNim3q3hkk3n5Z842i8ApjUEPceM2FBAxarTnx9mLQ78cs//LpI/IkPi+4U3FRO45jeTKXcZVXvvnNco6najV+if1rfw0SpNBDt24uytWsZh3IE8FgpF0P+O2SxPh8VCXfBu9EMVrcHOk2AI3fd7tx7n2MsSxSfVs2RSsPpAtl1oK8cKANNPROwtDVzQ8/+igBz5qrfLhP4ykN3BDUkdSYQmFCMrOuK0MmY+NT0Yy/NZiz1vKZsAqF2UAbvGQfYvYbGkNrdlz46fdqFO8djg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/GdLfDfbRHJ+RMjKX6CtoKZdT/+X9odMCcSnswrYQ4=;
 b=Q+NMPNo4D0trlG0u6AKNcM599Co1ZWoVBCw84lvGfqrXaKhAqwzrBBcLU1DZ9miobAsTnF8RPZGuYR4SLKuiPtQouRazlwQ0AZPdyY+iEgg79/ndGG+pwObrbD7SHMvsD1cg9+2KNvulT2dHk4ncN8xhleKPO8x1BseRyTRtHl0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:28:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:04 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 21/49] task_mmu: Convert to vma iterator
Date:   Fri, 20 Jan 2023 11:26:22 -0500
Message-Id: <20230120162650.984577-22-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d56947d-f0ac-4df7-75a3-08dafb034e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIpPV4l33oFLiGkYuYQiuJ1dK8zQTTzRYvX5ompjsyvD1QP9HqOoAHdAQAvme6zp968EB9NZPRB1WbGrcyxr3aqSsT1KOy6brOfnqMqSWXea0lzalp1oJ4bIca4gaVjQtWRyGT/PiMBHgGqUeuX4CgaAFpytpcG+UNAbSsOzKqMXlktFv9t3w0ZADy6b+Kt2rkn89MTebLsBdWM5V6b9gOwgPfFOGvY+kx9zix/S5mIyKnt07DDZEJxXlDIk88fF/Bnzs70ef3g8/NodpKXFlB8WzJGwlbWHpolxnJmRzQgtBTHD2EG1qANh3NbLSA+2thdk/EOoQAqopXKR4AIC25TnBeCxr/4XFcryuQ2QOw9ZxM4RYqzzoh2h2IpL+AKlWShJucSoataaXDe+ZRRS8vmxSNz4/qm5LAWA3TKQ870pnoJyLsn+O5bSVJr8q69T6ikgAp26HuanuI0veHlEuu647OWDRrJqdQq6rSX0Uru2CtuxY46k0VJjR2elO7snIZ38BdUSrdr35m3bw39G9hWA8nTP5Ey9apJ60KfQHq4F7bauoMM+Fv6+UgElHsvfXum1yiRHJKcmG2raVRrk6wFeQhVZ5JkGLIPgRzxFCWUF5dBOc9XHly+3qfVGvUYcFM1xmLyFQKNWpHKnwe7LvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bw5ZrlujN4ci1U6tgD8nGlntDGbwgQD7ElVqrjmwhen2Gdafi8ODHFsDdZuw?=
 =?us-ascii?Q?6LarajNm2OC8v8KJ9ZkrdenD8hQdIPzTztWfDTR/gRO+7Po3PaiLMvI9QV1Z?=
 =?us-ascii?Q?zsRQI251KzXd/t63ZoeViOfEsqg2dZ2JH6OpZBWIKTgMeqG+ojBXWH8VUFHz?=
 =?us-ascii?Q?EyQiV17tHS4C8bnwabM19rnIz56O4SIrGaJWqk9kt7DlJxOClNgYQ6bEGKMj?=
 =?us-ascii?Q?aOpfcJ+HGfFe8J9TCGG0WKGw8NlXCyQPG7Qb0fSWnAQu/xaR+JNJpLg50lkS?=
 =?us-ascii?Q?yaxsA7NjBLZBaEtrszqSUJsRp0AbeGK3eIiRdM5OEZpZYQF8pCfFhxiTlW+l?=
 =?us-ascii?Q?gvfms0OfSwazSuy/zRKYgyoYlROETJUdG/i+MVh3PtTYbTztRiQSmvziwTaP?=
 =?us-ascii?Q?U1+2BVGU+WYmBUypYNxeMsL50BOsOLOxHW/U6t2SOkcjr9tTpXZGtRGffAci?=
 =?us-ascii?Q?xkRtqMdQ1JP8oerhVi8+oQvm5WjrniErbbQnyWg9zO3uL/HKT8TMogQ4l4KW?=
 =?us-ascii?Q?iTa0hQXWVvXoVNZQdTSc0eFiZl4DgKPCPfHK80NQv2RjFc15dQNSfqJIUy4X?=
 =?us-ascii?Q?UMIircngatnXeeOeA4zIHSumIhsyYybucrWR13w7g1o0OnsRq5/lyTQu17N8?=
 =?us-ascii?Q?MuhhMblHryydNgzasFWDYdKI7e2lWgPHniWATjha7LjsS7gOqV/2J9+lERWX?=
 =?us-ascii?Q?1ekN4np3/NrKkIF/Luq0yb/q63b25SM7Y9BWJiefm5raG20KWwPGj2UIB8yQ?=
 =?us-ascii?Q?TknGQZJS1auuv8aUTXXnkA5KCZ+8Aak/mjjj0/IUGnOcRH114V9MvxLEwn7Z?=
 =?us-ascii?Q?9ZWxMVEWTyaEq2Kcjvy2iwRRAWExWULgkyuHDq4UmzFPuPkQ51RZmPUr4cz+?=
 =?us-ascii?Q?tT66tIKANeiEeJJxyIQaNuTvmuk7johqA2MLsqoyudg4xC5PepQqfflWxKgQ?=
 =?us-ascii?Q?6jpV2LMiOtylU9yzuuoh+6js76/sZejeD2BOO4C0IeCNBF8GAHOwZdzOihEK?=
 =?us-ascii?Q?49dO8VpX3l64SfO8xcA+qOf6i+h0ZFbBr2T38YzueITlro29Cy17ygQ+xAFU?=
 =?us-ascii?Q?f6C5tC2y3O1t25wo1akAURxjNqEOCnYBJmlFSB3sol18lMbrGUmtVLu9vGc5?=
 =?us-ascii?Q?eqQz84CPrLwClMBRWdjrlL266QkIjKuPAVvSgj+Q3SUIsWvpzeix9oXJ36dr?=
 =?us-ascii?Q?QS06XmJM9yNEbfISiONykiqCjjUvDGTT+3yAzmNkzySKOwNFX4f1dT27yW82?=
 =?us-ascii?Q?oeQDFHeF++MUFDDZtZJJKeCnOMQqBlFfq9iHV132WKdmEDGxPv8Mek+CcNLp?=
 =?us-ascii?Q?nBctNd1UqwlSUeuaKRY3oKh7nVZLqO0TTk7Iq8MPycNvMrBgUlona7YoZDLb?=
 =?us-ascii?Q?7cNbEuljMs6dohJbhSSAH3ZUKZYcPURhgggRgYIG/sltBiUovHyV6sHdrz/c?=
 =?us-ascii?Q?Q3kxlaGdzj87dWRu0ELB6aLk03O4ACmwnvo7O9yqftOOY51eFj7Yk4dl66It?=
 =?us-ascii?Q?V7m626uusZGSNX+UArLEV4GLztbRAkVZYNbuGUmCh7ynU799MsXs8tH/YhZQ?=
 =?us-ascii?Q?n/cpGLA8dxTQ7DwSpO3ynWrj1NKUck0327lJRCmU480OPQNDxmPCLi6CkmhM?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h04CKSS6QoWXlGMdozjM3JgBg3nZowKUIn4JGJ3AqFth0h/lL/dcsWKnYi5ActMxszrK4KcxF08FXBnGbgCn0zo6+gJ3Xn7S+iOXW/bmJaRxMnYUpuVy0D0AHPP3n6F8yGgchqn3EpTsZ3bb9DZZZ7CLWIXP5NSS/o+TwUBl8uoOsTltpQ5gDJdWIvRByXJeDckkEoPADBFsGaAZ0i8q99N04ySJ/iRy0pTvFpCBsta49CoFaChZbO+oZYKqV3E/vVuHCMOpiDJhYIFz2FxSX2k2MmqH9AHd8VKsb6UCDSQEEidoiuHdzLlGGOtZHvSfdUuk1OM6tDgLRTNpnYq+AXcFf62UUgsm/FiHaeWxwguBSdVIfY7W6ZSVIso5WfeIofrWFqIPkyteNzr/k2nTkd9VvLVUy5JZH0b29pCgsZrmgaxl0HR/YtG/fs01Cys5iwnmHO8RcRtotozB1fbjQldAv/4PE7rJDizomJkD6TXS7l9wWCW8jp1C2mT4E/efvUY9lEygikls4Ss9FUxGG9GARfn93TecJ3WpvPrnIKnMMBxGx5PffF1gSQy5R2Km2poPiYGnrRUAXQd+caPTSkbvunPW8BmFx1NGYMwvKxvqnyrK6kvrNv58DizVaBNqxgzeDILmkAFNMXt5z473oBmSd1Sx541uTBRMceO7L/KlkYCGyAedyi6kleMRd3WaKnlcSatwmSlO4LkRyy+VnL/dGHzL9vFCiUCvMysypZa9pRY6GcmuvLlh7tD993k4jBuXkafv2cPtH2lPbIo7C2LXoHtzIFm/aMPGOaMbpA3Wjd6vez00IR2IcQZvFfG5UZe8kgh77Rrjjiy2m5cX2AeCNImfGjGRrm/t9StLs3jT4hJfGHwbAw0zoTos+X5A8mAqkHtVjrIIEqgS0yPkOQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d56947d-f0ac-4df7-75a3-08dafb034e63
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:04.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+YKOHZjuf3MkVJcFXO5hr/yBfG4JYWLPGoNsLMWopNP1eeJNAdATfgaUEfcw6wz+VpO1myzTpAmXvLqAyxf/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: bK4FlI9MpdmeapePPl8F3SBdXstuibOF
X-Proofpoint-ORIG-GUID: bK4FlI9MpdmeapePPl8F3SBdXstuibOF
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

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Update the comments to how the vma iterator works.  The vma iterator
will keep track of the last vm_end and start the search from vm_end + 1.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/proc/task_mmu.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e56dfa3d6165..f937c4cd0214 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -892,7 +892,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 	struct vm_area_struct *vma;
 	unsigned long vma_start = 0, last_vma_end = 0;
 	int ret = 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 
 	priv->task = get_proc_task(priv->inode);
 	if (!priv->task)
@@ -910,7 +910,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		goto out_put_mm;
 
 	hold_task_mempolicy(priv);
-	vma = mas_find(&mas, ULONG_MAX);
+	vma = vma_next(&vmi);
 
 	if (unlikely(!vma))
 		goto empty_set;
@@ -925,7 +925,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
-			mas_pause(&mas);
+			vma_iter_invalidate(&vmi);
 			mmap_read_unlock(mm);
 			ret = mmap_read_lock_killable(mm);
 			if (ret) {
@@ -950,31 +950,31 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 			 *
 			 * 1) VMA2 is freed, but VMA3 exists:
 			 *
-			 *    find_vma(mm, 16k - 1) will return VMA3.
+			 *    vma_next(vmi) will return VMA3.
 			 *    In this case, just continue from VMA3.
 			 *
 			 * 2) VMA2 still exists:
 			 *
-			 *    find_vma(mm, 16k - 1) will return VMA2.
-			 *    Iterate the loop like the original one.
+			 *    vma_next(vmi) will return VMA3.
+			 *    In this case, just continue from VMA3.
 			 *
 			 * 3) No more VMAs can be found:
 			 *
-			 *    find_vma(mm, 16k - 1) will return NULL.
+			 *    vma_next(vmi) will return NULL.
 			 *    No more things to do, just break.
 			 *
 			 * 4) (last_vma_end - 1) is the middle of a vma (VMA'):
 			 *
-			 *    find_vma(mm, 16k - 1) will return VMA' whose range
+			 *    vma_next(vmi) will return VMA' whose range
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma = mas_find(&mas, ULONG_MAX);
+			vma = vma_next(&vmi);
 			/* Case 3 above */
 			if (!vma)
 				break;
 
-			/* Case 1 above */
+			/* Case 1 and 2 above */
 			if (vma->vm_start >= last_vma_end)
 				continue;
 
@@ -982,8 +982,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 			if (vma->vm_end > last_vma_end)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
-		/* Case 2 above */
-	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
+	} for_each_vma(vmi, vma);
 
 empty_set:
 	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
@@ -1279,7 +1278,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		return -ESRCH;
 	mm = get_task_mm(task);
 	if (mm) {
-		MA_STATE(mas, &mm->mm_mt, 0, 0);
+		VMA_ITERATOR(vmi, mm, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp = {
 			.type = type,
@@ -1299,7 +1298,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		}
 
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
-			mas_for_each(&mas, vma, ULONG_MAX) {
+			for_each_vma(vmi, vma) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &= ~VM_SOFTDIRTY;
-- 
2.35.1

