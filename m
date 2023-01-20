Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72205675DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjATTRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjATTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:17:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE275A24
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:17:31 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBgk2011455;
        Fri, 20 Jan 2023 16:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=vgzpJAY9VMzONa6f9TqAF7Ll7ccVCmH/+d2ppBJqQQU=;
 b=Nf3olKxIv64+QT70J9oxx8LGIIYKkFYn8DkhVSoNQWq+xGRgxdAB/QNl04lrgyQPqvRn
 vCWc+ws+GTAUlbfO/U9iIdxzotNjZG/9SnBcdQDyyDCEErIBHcpSMx3QJUuj2RWpt1ea
 6jio2qsYej4Vkjg+pdPWBgnccbLyWrv6uQ0XRfD0e7xGqWvFsEkpRZUoJcx+GONyVFq9
 Ludz+hB0R5ppmzvY/z0jMzgN2TPX/TZsraYLYFjiPt0EAH5Gf1huE2eBNXyMlJCRbf8d
 4aDu7ckbfpeu04CyoBlvwH7/G2QFskF93jaLNihRVGIJ15dOhKbZ5zXt4fNJQBKToKlD +A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895aqru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFVpgL004600;
        Fri, 20 Jan 2023 16:28:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1gjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFNyW5dDBWly1q7mWleqOG4FLK6IFTBTR7W/M+B5BuSI7a008maGBC8fbDzGvIOqN5gVq4ja0SRSUTPVvUlZucf/Wfyo1rgipZzpPeyfSpMuurWbIyx3YvWS9cb0OW3O+UIOzsSLlbBuwy3m5OygYXLbDio7gq2e+CadioYhNr15pi0aN4jIz642q1Up0TqjFGSu2gOuwfKNRnUt0bnTdkQmqIVJk9vAH4qij55ND7+BNjoAa2EJ2RAX7VuQHqDnsOylYygrcDRCepFwz6y4Fq6Yl7RLDCfqYo1Gt2tux1T+Lp0beOicsXntRiFaxXOMtNxMHHAIKLAyCQMudWAaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgzpJAY9VMzONa6f9TqAF7Ll7ccVCmH/+d2ppBJqQQU=;
 b=XwOMHnXsxEENXDX2mLgolQUzLiuM6xMSS/c4JkLfYMEJFOukGVofVzqAZ9HQfBom4DD9I1BVBRs/eqm3rR3jhBzVQkfTX1LhEM3lmLBsbjNeQHxLcgmGq13/ZT2AOzi7ESm8hC1R+Vv8Biyrg384cwIkKxjXOvSQQPKahXUcHZeotX5Ctl1BEwluKyC++/NK8q6AGVYCJ1Sp+RpukXYbuFBHJt8fdKhHrab4JSzlj0ZTTXssOdK4qKj62sqHIBXDe/Z7y0clEF0rB7/mS1kCE3nc6viNKkViCj0xzVJo+OcJOU/GZRq02l042p3tSa2lHeNFzRVsShOXQaN2zfuZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgzpJAY9VMzONa6f9TqAF7Ll7ccVCmH/+d2ppBJqQQU=;
 b=Vz+Cf3fn575leLW1bvBiA+jssixWWJd+29zURQY5Ay4hOLpaoefcvwM21xQQZw4iiQvmevtwTS1JNXZGcBHAf4M+d0MMX3Cd+FYQarCqtZxsSl8HGJThK1DfBTNdvFRLBnhlmNRtRJepHi1hXuGpl718nPQ2giX04aLJ3e4dEfc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:34 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 32/49] mm: Pass through vma iterator to __vma_adjust()
Date:   Fri, 20 Jan 2023 11:26:33 -0500
Message-Id: <20230120162650.984577-33-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3c92f5-60b6-4377-f3e9-08dafb03602c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNq1Ev6k3ccOvCOkQW7iqCLfwKiAP9hrXuBkCi7ljSweGsoBzjvMUhs2iBDZKjZ1XoKkF8XhZ6/aUGOE39l8HIcKEz9gMVKKHMvBXwR3hl75/lwvzQwpC6JHi4aGMy9JlOHLjnHtKiE0pJQ3FUWP/UiCMIeomUgr+IjP07UHov7+tKwvuIj0WR56DQjERc5X95ZeZLwbyQjv35egEpWErigAq+4W/CXfejILJS+9vr0TSQZnPwVvaepgT1egEixs1JQzsxKtPJ/s0BBI+ddMbNrH9JbbHAyP642hVxDCIfDJ9OUsqWvEzpvCOh6T5dxGGE50xloATUTXffDKnT11LmTSPwfX344kB9PBtd7JDVlmXjqWBIYPEzcWtrGxK+42WoCPJx7I+rikNMTw/BlpmDw+eyAHgjNlem+LoKLcUEu7tiaU8qgw/yOImAoUoa/Lq4zv3vrLLYGknocyJAS8lUhgS3XRnzgWOM+NgU/IBRQq/DGj9yVaeXztVdWDVTNANhiPKQfp1iZmvjWs5hMBnNK0lGRlKuxdTYqaLZnK9pwDsmLr7Pvbgmy7iCLnnTZZzZ9EzSYSbuBaZnDG6MHChsUXoQ9JCZJGjTnVywhljK+YNI1wvP01zu5tJII0l/0bSmwHWud+zSKn+KSTwraadg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(316002)(26005)(54906003)(41300700001)(2616005)(4326008)(66946007)(66476007)(66556008)(36756003)(83380400001)(86362001)(8676002)(38100700002)(6486002)(107886003)(478600001)(6512007)(6506007)(1076003)(186003)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQnLD9e4R2Gooyy49J74Wl4Dwdp1xEkVScxIROmq/Hk1KCruZd4ypjbfK+Mq?=
 =?us-ascii?Q?/3vd5Ol/c/aXsd1DwUKKTJeRlzgAZyt3HEwP1hHqcPmCkS9wSn1P+cpMXJZ3?=
 =?us-ascii?Q?r/WMZWeJBN+1p2sTtNkve2nq3a4ZsA2ONIV22kTMCA2wY75Ha7r6xkXEg1yK?=
 =?us-ascii?Q?RzBPCHVeJhstYq1iz3MRNmjIo8bJENoEkPU86Ne0/JXhysHtBaegbHUI72kA?=
 =?us-ascii?Q?DQC2ws/4EzDCkgJzHNwV6cQG0bd/jLZLTaPCBuAV2FP2dp/ug+biIzaCBM76?=
 =?us-ascii?Q?LcHGa8iCDFqVUbGDIRzZnkti+KdtPrA9RDio3RdbzyKSviWC4ld7LtTdQJKj?=
 =?us-ascii?Q?25HGSnSU3v0aFWaAf11D5FvD9ZnhPIXitPcm4+Kdukn3jcl7V97JT9ZkMXdH?=
 =?us-ascii?Q?ezXtvjf+K/7GgxIyDWaVa/P9VkYU+J3ZJgTO8sSMXLFZgE+c9inBRnnclPoN?=
 =?us-ascii?Q?ZDtQShSYOoTdKTiBTB8o9xgWt+gHEN9v3w7KAYdKFzVGsjTjqDRhEb0hXDb+?=
 =?us-ascii?Q?E4Gq5BBfFTWUCown+1UYvHriB3swjFApG4G1IjqG5TvAw06ixptMW4MMeR5t?=
 =?us-ascii?Q?PaXaaSeW1LU9S54j1fkw12vDw2sxI54X8Tp1TJIxJsGP04annvzyeqDQPzFM?=
 =?us-ascii?Q?+naGLlzoCxnnrN/W/MLzGe7jpCq31lIk36+jRG+nqDags21duR/6RNoYgeOI?=
 =?us-ascii?Q?DXcUqobrl+GujhhgRzr0rcU/atE690G1Z1Pm31VSRqDChI80t75XAf3tMrIm?=
 =?us-ascii?Q?GkEIF9BIlK55bTmAo+9ngsj35h9CXsGiHSApUYkPT0/ENL2uI0QvOd2mAuRK?=
 =?us-ascii?Q?ARbgjJYvbLu+YpbFZKiDucoupgd77Ukj1zKh+td9gLwbbd7jNRTtcgfx4qrG?=
 =?us-ascii?Q?wpJbPoUKPH4dyfrGpq0sygMItD7eD1cy/38PKO/bhXucKuqbKok79NN4bjzL?=
 =?us-ascii?Q?IuRTWrUIz4Vo4XCPUGuVk2JMrAqWyJryBwPBuKTyCenzUJE1wMkPeoVNj6qX?=
 =?us-ascii?Q?08ArVwlSfixHldH42FUSNPfEzLtmY1kNHtt1JxYTQGLVRsTM2BdyxXCCudOU?=
 =?us-ascii?Q?qFMauq0bXwn/RGa0G0hpLXG7QnJtyW1CsIxfyyZ2l5K4kHNCusYTjKcfGlhP?=
 =?us-ascii?Q?Xm9/2kGkwaPock421sUBHjq4OmxgHgSJvDdoUMOGGGxhqT0RxHIG0SzjDJYc?=
 =?us-ascii?Q?Z7rBo3eKRHIed60/95okpM0DaRRkqjM77vnpXRnb66DPwBSp0P/ib04BA4fe?=
 =?us-ascii?Q?rnA1mD7S/hz39+YVp4fpbEmsyuRZByMHRpff8t51nY3n7ddO1lvrHN8+avGp?=
 =?us-ascii?Q?X8KVHOg8K4f5BE/7vyT2wgfbi3nFhgrKIwe7A67Zad7iNHCJFdoAdfAdL2KG?=
 =?us-ascii?Q?1Ns6H7PF32W+yN3H4o1cxJM8RZX32KubO+Sdj8a2uk2TUpCP4ieO1jEQSZzn?=
 =?us-ascii?Q?P7Vndg4IzgrjyzlJF3Rg2wv1rCGqiZVNsyBRJsY5c/SP8BLMj/zs6fgfDivZ?=
 =?us-ascii?Q?0UGhOz4tG0ZAaWriOW4diJcAX8nzp6GlYt9gVnx7To2FSzGo+L3js9nv6RFk?=
 =?us-ascii?Q?Ut0x3WKS4i/T993r/sGRIAGZR4+v/LvKVc8YhisSoa/eYyQxY6X8xoVUAOss?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p7/4Ucfs7uzS27WX+bkI+RvGXp0Qtq4wSEawC7jEg+82s1CvHdNzDvFMg2PSd7u+oTRVV9ZmIOme/CBUxua2qsjmQLjUR8O3aVeKYCX/AbS97BXfgAvSDBm5nfYVX2hKuPUIe/sPBR3rcuOgM7t7st3Iy+dLqgLwl9MFEPYoy4B5/Wgo838AJhYYhoELMOzmFPyDX68L/R2ujrGa8ZTDx3xCS7K9rXZ8Cb+T67AS0ZFIHOYl0sCmn3JF1x1ZOW6Yd24952dwrl58Eb/CBpTs8D/iystFPoDym2ec/uFMuJeaCHloLtxEoy4Ze+g6VjZJu9KXs34eb2ZLinh5Kdn4npAgSk3aKIXOSk6hd6x9GX5JgZi3mJckfz93m1qYzmzkjNYu3Z2PdHR1WzCSDagBnvw0DofOc6GnepqH20t/OpKbmdITBw+uXMazeq5iy7hn38zqUfHOvrMb75cuIRkFZKMubKxHNtcLw/pt8X9xK93KOqZU0bhOh2BUDxvulDnjejv+QcOHhCF6ccc6hTrmsxw5RYOqToPAnPjFHpVpwJVNS4nch6zwQpz+wvAp4vtInYhThfiVvzTgOofHl1sXdOsw7EYggRefW2fGXZ+n6E5K3JyMyf927QJCQpTGAygSSUCE8jA8oo2I4Qgb4LIPL48b8RnGIYWvaKp4ogK79JA9Cbr8bk5u9haY5cRolBeDaCIZ3Kxn8EUWSmpuBt5acj1YF8IbBDdJDJmyvHa4s3PH4WDBSQu/Z+LK/nUZx0iPiNzgyqzalGK7LVt1JAz4PfMGrymR7pOmlIFdRgnWwusSOoxfZRdLSW/vYA+Wce99hQ/cu4vnAisMKVvaYK5uMr212Ug/NwsdujEWrwYsSHRw1BRDDepSbGBYltLuzw7f50Eve8XqkqveB8WrzfxaEA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3c92f5-60b6-4377-f3e9-08dafb03602c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:34.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zau38J6Tqrp7YaGkJ83VixMLaDl4hRB57Olw007uw3+NnbVzNykvxD/MYcw+eSGkI9K3Ioj7kMo4LTFjvJYQ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: wyOIaeAa-vyCH6IK5Od-xZFVfDxzSrgv
X-Proofpoint-GUID: wyOIaeAa-vyCH6IK5Od-xZFVfDxzSrgv
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

Pass the vma iterator through to __vma_adjust() so the state can be
updated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  6 ++++--
 mm/mmap.c          | 31 +++++++++++++++----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 170a06e46cc9..479c79204d96 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2831,13 +2831,15 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
-extern int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
+extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
 	struct vm_area_struct *expand);
 static inline int vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
 {
-	return __vma_adjust(vma, start, end, pgoff, insert, NULL);
+	VMA_ITERATOR(vmi, vma->vm_mm, start);
+
+	return __vma_adjust(&vmi, vma, start, end, pgoff, insert, NULL);
 }
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index 19e5a79d5ca7..5f03c8f3f407 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -579,9 +579,9 @@ inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * are necessary.  The "insert" vma (if any) is to be inserted
  * before we drop the necessary locks.
  */
-int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
-	struct vm_area_struct *expand)
+int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	unsigned long start, unsigned long end, pgoff_t pgoff,
+	struct vm_area_struct *insert, struct vm_area_struct *expand)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *next_next = NULL;	/* uninit var warning */
@@ -594,7 +594,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	bool vma_changed = false;
 	long adjust_next = 0;
 	int remove_next = 0;
-	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *exporter = NULL, *importer = NULL;
 
 	if (next && !insert) {
@@ -679,7 +678,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 
-	if (vma_iter_prealloc(&vmi))
+	if (vma_iter_prealloc(vmi))
 		return -ENOMEM;
 
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
@@ -725,7 +724,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	if (start != vma->vm_start) {
 		if ((vma->vm_start < start) &&
 		    (!insert || (insert->vm_end != start))) {
-			vma_iter_clear(&vmi, vma->vm_start, start);
+			vma_iter_clear(vmi, vma->vm_start, start);
 			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
 		} else {
 			vma_changed = true;
@@ -735,8 +734,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	if (end != vma->vm_end) {
 		if (vma->vm_end > end) {
 			if (!insert || (insert->vm_start != end)) {
-				vma_iter_clear(&vmi, end, vma->vm_end);
-				vma_iter_set(&vmi, vma->vm_end);
+				vma_iter_clear(vmi, end, vma->vm_end);
+				vma_iter_set(vmi, vma->vm_end);
 				VM_WARN_ON(insert &&
 					   insert->vm_end < vma->vm_end);
 			}
@@ -747,13 +746,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	}
 
 	if (vma_changed)
-		vma_iter_store(&vmi, vma);
+		vma_iter_store(vmi, vma);
 
 	vma->vm_pgoff = pgoff;
 	if (adjust_next) {
 		next->vm_start += adjust_next;
 		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
-		vma_iter_store(&vmi, next);
+		vma_iter_store(vmi, next);
 	}
 
 	if (file) {
@@ -773,7 +772,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		vma_iter_store(&vmi, insert);
+		vma_iter_store(vmi, insert);
 		mm->map_count++;
 	}
 
@@ -819,7 +818,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	if (insert && file)
 		uprobe_mmap(insert);
 
-	vma_iter_free(&vmi);
+	vma_iter_free(vmi);
 	validate_mm(mm);
 
 	return 0;
@@ -1013,20 +1012,20 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (merge_prev && merge_next &&
 			is_mergeable_anon_vma(prev->anon_vma,
 				next->anon_vma, NULL)) {	 /* cases 1, 6 */
-		err = __vma_adjust(prev, prev->vm_start,
+		err = __vma_adjust(vmi, prev, prev->vm_start,
 					next->vm_end, prev->vm_pgoff, NULL,
 					prev);
 		res = prev;
 	} else if (merge_prev) {			/* cases 2, 5, 7 */
-		err = __vma_adjust(prev, prev->vm_start,
+		err = __vma_adjust(vmi, prev, prev->vm_start,
 					end, prev->vm_pgoff, NULL, prev);
 		res = prev;
 	} else if (merge_next) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
-			err = __vma_adjust(prev, prev->vm_start,
+			err = __vma_adjust(vmi, prev, prev->vm_start,
 					addr, prev->vm_pgoff, NULL, next);
 		else					/* cases 3, 8 */
-			err = __vma_adjust(mid, addr, next->vm_end,
+			err = __vma_adjust(vmi, mid, addr, next->vm_end,
 					next->vm_pgoff - pglen, NULL, next);
 		res = next;
 	}
-- 
2.35.1

