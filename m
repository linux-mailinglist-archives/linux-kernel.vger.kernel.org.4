Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46160507D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJSTf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJSTfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:35:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602F315D086
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:35:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JIOU2Q020637;
        Wed, 19 Oct 2022 19:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2022-7-12;
 bh=DfB8XbkCziBN7trknZ4xHefVWGriSxO1QsC+ztB2gGA=;
 b=OJsbF+iwum+35fsJAonXblXMhD0KsmPCf2rV1MdFcdR/QXj2EIuRKHcrVJyqfeVzcrJg
 AB7weH6aZY/ZfuHGJYSLCvQB7KT/ybTUbMai93W0zh5WU+qanm+/eqzt2VPAzfzUlwn7
 gf83lX8INqwleD0dMzvB0NSEG25Rt35oxtHw1CpcxHqGGx711achF6DQBBJC14domtqI
 Ku3yc/eHRqPeqqxUS+YRIkK1qJfWUORH4sjkKrpt+U7x/5sG/CxNQNwSyfY294TFG0gG
 7UhyKs612QNNqj0QqXf+Iuz6l9jUzkAkg7hcVltyRFjG16bG4EvlTuy/e9q0QIx6wR7P DQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntf9b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 19:35:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JHo5d9016628;
        Wed, 19 Oct 2022 19:35:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrc4bfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 19:35:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzP/zuSjn12+dbTb/Hc5nPjOIpkB4ku5zo77R71NdxeLv+6qeZRGG5gahbn4Gjs/6Cnbb6hleyZcy1L5am4OGSGpVAcBesjSXV75PGM2a0mbr1dNZ8YyW7X41RSx//Iwvs6LRsgSFXGyl0j4Er9fjkpcMQi5eSNrSy60ICvW0NpPIBDl1stoevnjmh/VeJ5TxjRI37BoRhRXcfCK/TJm6BKsCC3+t5nhnoJJS5adtW8DLcTgtBuMS6odlcQOPNUID8N56v0H0xTmFrz/LnV8K4vqEgkRZc8tjb5OE1CdmFl87Fc8fwizVn6ZwclNcpejUPK2ePYhOncddfO6YyLnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfB8XbkCziBN7trknZ4xHefVWGriSxO1QsC+ztB2gGA=;
 b=aylUQiResiIGr+0jOLxA/zBnO6GH1AbqLNPKKBfiqggDb4bX26ei6fMMfWCwxHKxKSg5kZsSzfy7gT8Xr3clVlTQZWEC69FPFsZ2XqQJO3+4Teen8F2J2GD6dycRTn+0yDOwK+fD7pVNIjoUrWYADqNv64Rr9v72VuDOjahk5Jb2UHRRHe+5kSL9LV1zaSTnLePB8sNe5+y35nthuNe8ILbrAeKLXo0i4JbUrpMiq5tGKeOhTifz/2UPHO7GUjfrTU23y5UZR8Pv0i83Txr7KVlv5a1wQGTjMHaDiU+tAxsUDyKKz/O+tsmQfFSDuHYwUV9sSyb+l5tJQ6pf2+IFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfB8XbkCziBN7trknZ4xHefVWGriSxO1QsC+ztB2gGA=;
 b=YvduFuYXys8xUgpe7uc67bTvhhCpvVhJ9LAplgpJ3qr29/67x2efr0vNOlFPt1FSXupdSiQu1mAO1+gZ9qmXCEzKOWEj0PV4kqgWeF5NVCHB01BjsZkVG0RBT8bozxp3e+/V4SG6F4ntd2Ccw2mEZ9kWcNTth8raebR1rekJJcM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH0PR10MB5274.namprd10.prod.outlook.com (2603:10b6:610:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 19:35:05 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 19:35:05 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     wangkefeng.wang@huawei.com, konrad.wilk@oracle.com,
        haakon.bugge@oracle.com, john.haxby@oracle.com, jane.chu@oracle.com
Subject: [PATCH v3 1/1] vsprintf: protect kernel from panic due to non-canonical pointer dereference
Date:   Wed, 19 Oct 2022 13:34:31 -0600
Message-Id: <20221019193431.2923462-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20221019193431.2923462-1-jane.chu@oracle.com>
References: <20221019193431.2923462-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::28) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CH0PR10MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d862e8a-9400-4fa3-f523-08dab20905d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZidBr9sJyR7v97I7d526OROzk9MKcnPKv/fxdHwVarD8yyxcd3zP55xXetDCZjoXx7e7xCeUJQAT0xR8EH4hdcKGzv1x4Vcb1sBHDf2PgPPZmFjNowAvZPVD38tlxTJFfpwBTi/KdP6HkNTPSwYiNMaUuG3YC5U9fU5QlNJcsWkEfjTha/D0/CpU5B5+oUwR3X+R+7RF8W1/pt0BHz2WTb+JjVeTel3YPX837OQWgmiDoRZGyIANKifdeunB5Ijp2N+PqT2SPT/fGs840bEKWz3WFSro1ib04cYzJGZJFMo2OR2mgCq4A3KLwiQp3ADt/ZBd82KpaZ+k+PvBdvsHVc4Y1ffcEFcR6WaPPMc0dIaapO91pp9Gox0nop7372tIDMoYSZmBYHAHhCXv3w2ceXBH+EaGE1brrwFFOAenSrz8NrJIvGbP+ub2zplpzIawxcfevirucnrkaQoH3MXDtBRiOIDmIca1S7eahHTqZe0tZV0L74ZxrLPIFE5eJxqcirgK8a81buReOBQn0TFwGvteJTV90oHXr9/Ez5+qrnNb3JAYL0FS1X9DFS5G+HEpWdQURjz0gAaa5QQA1rM4P4ynk/6ifh3te8ei/i9E15SAf7cEjT8lt6o4OFNx+9EXbCq7LSpJFquU3DpdEzIuq6+wNmXt6HjNo/bLCG8qdCx6SNILUY3q/XNj1hEAxVuwKOgMF+NNQ5YlDvP1wC+5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(38100700002)(478600001)(6486002)(186003)(6506007)(36756003)(4326008)(44832011)(2616005)(316002)(66946007)(107886003)(66556008)(8676002)(6666004)(6512007)(5660300002)(66476007)(1076003)(2906002)(8936002)(86362001)(52116002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wbjUvIWOsyJ81KPwUKnKtGeaON7G2STTMlkc/AfXVO66iwN4ogisyakK72f+?=
 =?us-ascii?Q?HLyfXy0CGCtWCWW+hbQD+n6K7VCy+w99nOLn0DqZ/lAhkHBr1wTsxwKxA0ey?=
 =?us-ascii?Q?S+mBKehmhyArm0ti4XY6d+wtfCL1rVWSi6IHHYv1f7zNQ94K+8vxB5jIGgfS?=
 =?us-ascii?Q?2x+VhCIaOqjboC+VTsBaGsiHcnqaTcDVmTxvv067zaSU3zjD4op9pkffVPh6?=
 =?us-ascii?Q?5kqa0Uz/Fp9YNALdqVKmmJs4/v5A2UutevWS6onToUcOKaUZYXp8i4ytxlTH?=
 =?us-ascii?Q?2D+0D2E1j4edvtF8TY5x29TLUQgGEGdRYaGFYBpiaL1CE2+UQF/vuOYT1T5Y?=
 =?us-ascii?Q?RxezdWrLJFfvnAlGMTlMke7R0MJpOJRj+Q+vcAo5RLl1ocEOpD2u5ESDLhIt?=
 =?us-ascii?Q?kWZZNG9nlpDC6nKrGtfp2eVPCl/g2ipJvUE0X/X9CBRlQukSORw2zw325bkU?=
 =?us-ascii?Q?wTGJ8HnCu49gkHzQsk7IjleHfEgE6AQeSkXiZFob5k6DOuA0N487TNlPa0AS?=
 =?us-ascii?Q?jyzesiWzIUMHQFv8ffCHju5e1UyA+5rinLfZjRLtMHf4Kx2vFYUcNT4fTjNQ?=
 =?us-ascii?Q?WyVNsGRBtEi9yzm957Xe+ZEjxCZxglD5LeEJmaWPyZqgb9T0qv38cx+6gzFT?=
 =?us-ascii?Q?HK2KleSSm8UlJuxvFMwOqB7UVLvhSCa3Ac5i+6KzNNaFNNR174/guWgpXxid?=
 =?us-ascii?Q?Rxm2b0oE975wZVUfieMMzofhZkD0gFOIEwvuEzdqLwUdhyyGXdKK/Mf9Q4JG?=
 =?us-ascii?Q?JtilmQ9o+YlbHX5HzqYn2VfIt/XFairsFcIJPj3eMKsPlLxeV+M6zcdAfIfT?=
 =?us-ascii?Q?6rOJ2dpRyUA8Vf7khn6Es5KroIJkDPBZYonPtPgsX83NrZrUJGqne68x8NoA?=
 =?us-ascii?Q?DRTCqFXhJnrSwl+EFFgN/Mpn9tsLEsM6Su+EmjwpV4IPRaG7HDToVmkjGDtH?=
 =?us-ascii?Q?G8zXg5rwGToYorJpMh1zbRISh3dyJmWHbADAhJNyUYoYEv67v0JSNUiFcVjF?=
 =?us-ascii?Q?TL3HG/so59RjMDxEnRIrDsgWvC5e38XeSqBPufNO33pqBAPTMgHw72JYi3lv?=
 =?us-ascii?Q?Mcrl42vZh5FTzmRw9Q66mn/zJxWDq1cJxDX+Sbu1Jov34utu8cHj3y43sa5z?=
 =?us-ascii?Q?4jL0rOyZ929HQEzI68mZbV4vOUgaAgCtPkJpPitRcvmBYcmfTH0XyHCLGL9r?=
 =?us-ascii?Q?BetQmWp4KYPWB7duXIF2dG7uLX5KN2M3d+kSL/4xb9kdT7a0vAV4oIWGaEFQ?=
 =?us-ascii?Q?ScgjEBeWNT3ROvlWhqaRN08bNgkT99Hv552mXj2ONnXHxx++zKOCG2jyPBon?=
 =?us-ascii?Q?8lBGTy0df/t8rUzPT4tU1Kz5YOAvUDY3GeOEfklhkUtq1kpEGuyQVXjDXS+b?=
 =?us-ascii?Q?VwRH6ie9bHsn+X0Rex7CG2GAyWfuz4r/P0uKodgOvi0Fy+TvvePpFcoVkPX2?=
 =?us-ascii?Q?tYg580oqZTfn8vq2mZnst9PdHr0OKKmfVU7ZxlkBOulJRWfbZCkds5K23msX?=
 =?us-ascii?Q?pAiY/+OUeIMj+l9/RGwD5yA5nfQMo4tKEn3MYq0iCkKdAoKWISjkAW2p7brw?=
 =?us-ascii?Q?rSthlGyJQVozDgpY6DHXuC2Nti6fQMhmSVJSkMAVF5g2odoSjQzxVw+xpZv1?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d862e8a-9400-4fa3-f523-08dab20905d0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 19:35:04.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmP1rk73RnhmYUMcDAtNUtiZEej3tJZm9coSI4vAjAujOyyMbRbeZmDR4law/BLEtSCcxQ8WkEl6NUsACH3Yug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190110
X-Proofpoint-ORIG-GUID: thcmcBxTODlROz6ojSHTKTZ-3d1MEGZ0
X-Proofpoint-GUID: thcmcBxTODlROz6ojSHTKTZ-3d1MEGZ0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having stepped on a local kernel bug where reading sysfs has led to
out-of-bound pointer dereference by vsprintf() which led to GPF panic.
And the reason for GPF is that the OOB pointer was turned to a
non-canonical address such as 0x7665645f63616465.

vsprintf() already has this line of defense
	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
                return "(efault)";
Since a non-canonical pointer can be detected by kern_addr_valid()
on architectures that present VM holes as well as meaningful
implementation of kern_addr_valid() that detects the non-canonical
addresses, this patch addes a check on non-canonical string pointer by
kern_addr_valid() and display "(efault)" to alert user that something
is wrong instead of unecessarily panic the server.

On the other hand, if the non-canonical string pointer is dereferenced
else where in the kernel, by virtue of being non-canonical, a crash
is expected to be immediate.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 lib/vsprintf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c414a8d9f1ea..b38c12ef1e45 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -698,6 +698,9 @@ static const char *check_pointer_msg(const void *ptr)
 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
 		return "(efault)";
 
+	if (!kern_addr_valid((unsigned long)ptr))
+		return "(efault)";
+
 	return NULL;
 }
 
-- 
2.18.4

