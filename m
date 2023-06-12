Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69BE72D0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjFLUlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbjFLUlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:41:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24A519A7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKO4nm029683;
        Mon, 12 Jun 2023 20:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NJmVxdLzLEbLcdb/yA4FmvurN2C/Dp3Rfx9FmMeuxiA=;
 b=i9qE9hCSQDKA4f5Ep3rPsXgHaGrky7c1yc5PN8ZeZOAWuxj/CV8cITcF+fSQelWUPgm1
 BfVUCQbtaVjaS6dUO1vqSm7wq+ysIH/R2p/tIuLcterTsHNqxy6r7xoXfa7rPxHdmH5q
 v6wdhJ1q/GlKWKh1lKx3u5Fyx3lPztCzRKpkVjy26CExuvkV26dtJoPZPObIkYhW5W9z
 LpnYCdY+oguHhdPuGczzHSeFrqfEKgiTZ5p3PnXmlhN2OTLLjHyXOkZFPO//Y2uJnAHV
 S+E94DWeBfEz5HL6jj9+1jrawxgeG2EEghON9/M+IoHS/8behS1qxGQYEeNOrivwFuZf Fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2akv49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CK5C8k016192;
        Mon, 12 Jun 2023 20:40:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm39a2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iu/ENnTKzbTs31QmEtIiDzbg80S3aFioxCCt0cAiT4HSPoghkxDDiDYFt1dWWJ5PT+wH3YtnF9tuH4HxmH4s7214eJZ/zobmRj3qn5xPtsbu5peuazyXswM3i1/vAUwGAEwJ4DZpnoQ9Eue9CFICEWaF28utPohX2kVs+ReQmXAn8gBU2JsNsf7twMPI0Of1v7I07oSR5EA+/pzTB0cKoPGXYtZUgGgL/om4AHG+guWrnJCQCScfFuxUx+INZkP7NLIt02BRDJXqAf3lAii4ScoHq6bnKKtOiw51WW4w8Y6AFpJ3pCoQ3DquUvOCrxWILSWDCkAQETqeG9x2eHlfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJmVxdLzLEbLcdb/yA4FmvurN2C/Dp3Rfx9FmMeuxiA=;
 b=mCsGs2f6mUmdJLMhkY9ZFfwgc3zRaWYdeeThWb3JYlVfTpU2Osy9g209cYLfVaTdyvtyNW1+HVdvdQpUCY5A6Jn2yreljze53aOwIzYWmA1gXcEpOxZ7nKTb4tGOQWi5hWEyeFFLqst9yzyB8LnpvT2najdT6eOlzco3LWKSUq4KxVHb048DCDRbN+pijKhh7HKjkKNHbI4UD4r1wt3VuMHVsR62elPn7oNOzKHa5VIyXcpiIYsPACTALDPn+4+T9/nY2o6aedJEWcUbXqmwms/s8LVSAWa3ED0ytw1TzHFt7QCF3AKWc023yvp3S7x53U4Y1GoZbA3lxmBTf1EfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJmVxdLzLEbLcdb/yA4FmvurN2C/Dp3Rfx9FmMeuxiA=;
 b=RJQlZqZuu8eb7hqkFrI7CY7CN7sByKgIa4v4/CUaw5XlvTfAkH6vEvQTcW0lEFIlzJJQQLEW0DFwF9nqPY2AXnv+SHug8yENm1rnG1hapnNtBwJ42Enc9X1ft9QU/70o4msvXU/79Qv/xOpIJ1P0gpti/yalwhLGgdYt4THu0Ww=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:25 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 10/16] mm: Use vma_iter_clear_gfp() in nommu
Date:   Mon, 12 Jun 2023 16:39:47 -0400
Message-Id: <20230612203953.2093911-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f98b25-61ff-460a-1927-08db6b85404f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ui6FME3PmAE0xJih6todlSqHZhFHycEvuWQQQOHktI0+6KfNlq2rJCBlLvfVtZxJeepEucrLjLbd5+uTEbNYbt9f1Ue2fGfFF1E5HC+buue3em5jlMJ/g/XyfimTu3Ld4xy+4RbZDFxQ26DZ/dg1IJpdgaetU4xhKtGb4H9pMbrQUoMBzZDilY94y/SYjw5R5rPN+ih7q3WZnGl3YpUk087bSZyGR8wejoljWQaskPjQ41KOGjo6hDhqm+HY2TpD1ssVRyedySw+KnmWhHpl5iKc6SZwQHjHCBAp4Tg3KmOIk4y4y9SpMtn8u+W4p0sjvHY3st9MiyVGk0Ytk0H/BFwQgYbmmxj+4Ryrfvlc1tOm9nEWByIGu20iVUltSHeTk0r5zegin443E1wgEnBca3mG/KHYJjq0Dt6u2af6esVEQyk4vl4RvLMCbfNLpRAPJ8RcAi/wqL46DUMI9m8Noeev74Pq7Eufr8GH4LR9ci7jCNsHWcPAbk+tcBsksHREpCXc3fPfaLjGxBuBcSef56zvqtKQ7+vBo2nrFKhQ4FxB8NN02BIMecGFzov7IU3g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E85lERHnonFOLmCDSD8HiyPzvk1SlzUAXOk4YIm1nJMo9uqAe0GEKwPyMtTy?=
 =?us-ascii?Q?p4pBoW3yTile2BoYQDe8zuUnAy9/6c9qNabKX6puW6FFUmVZ/AakCggRuAsn?=
 =?us-ascii?Q?ur00fUr9M0uCXFhyEoxNl/QJuqqq4/G5NXzBPsWHXBNaydM33irWD9boWgmd?=
 =?us-ascii?Q?s/e0nWrxZfxt1DVX7pt44a+TwL/+vxxJ6MEVxVPSY4AOgVZGtXRjuIGfgXbC?=
 =?us-ascii?Q?fw4TCLd3zO1kxTCacH2o5q0o63OSFSlirvFDd6v4XcDn2FpWlwW6m32fcKk8?=
 =?us-ascii?Q?2/Mf8/4lIrs1Tev1Bo8AiTP4YbqGUazAqZnIPakF3nHUmjLZ/UF1UwhdUizA?=
 =?us-ascii?Q?rWjvGt1FVBEuZctKruzf87sIvSk3YnnhmBBAk5Cv4XyPM02mLG6wUGt8IfuI?=
 =?us-ascii?Q?Yr4An7WC6lng8wUVGG4jJBe0PDVW9GQTrdGgEkG3hPH7nrnoSvf9k2GS7Bq1?=
 =?us-ascii?Q?xC//Ke0WvZrKOTMq09W/x2cIEbmUpD5AXz7C1CO0qgIg5n4W+QDAtOfORYfb?=
 =?us-ascii?Q?JeMCsab4uXnvus/kkHSfC9/zC1gnLhx+tVA3OwKri3fnHMEpdb6XWHS7JTaa?=
 =?us-ascii?Q?uyVmuKTnjwVN+lxgneaSeUYw/H46tdicDQ2roMxfgZcqHatpZs4Gr6nIin/b?=
 =?us-ascii?Q?xkKV8U06dJXMI8p4TCScU7tU7fa9GNrOwBySfEPclrwLoFLVW3l6mJCyCVr6?=
 =?us-ascii?Q?jQK1AoXGux7Pl28ROIn+QTWySXHX9s8WUeh8HI9QsFpb4OFUmZYAEa2HiBLu?=
 =?us-ascii?Q?bM6YggnLfI/AhYChjRkEr+og14IQH/sWcesHEPyPrqPVFWgvBleA2novTKVA?=
 =?us-ascii?Q?FRuIw0+gt/KJPYCPTFzwm0V2UGqfCD826e5JUuwoSGWLJwMPzeK57HyZrAsT?=
 =?us-ascii?Q?6Wxc8Pd4MqIBmweugRrlCvh1qMuHJMyr5oEDBsKngmSlzXoCHOTJzoQwLsSX?=
 =?us-ascii?Q?NDFX0myVnyYujKd086xQ4ngQwORE4ZlPczzxogJyVmDgpROhIeiaN8BLOYbe?=
 =?us-ascii?Q?TJjPXS1iRHHlT747fk0O5Kw43wnrJANgjfEsPpf8XDg0NvalfshjNzfPVtls?=
 =?us-ascii?Q?w7vg9L0HSXZV72YgBYzKDiyDbQoIerHi0zp9Urut+FyeyzV9shOWAviBo9pC?=
 =?us-ascii?Q?j0u+Qb3xaz7FzqZRgL3R9JDeD2gOFDvR+B602Yix00ldhaKnYBybfjAJXXnF?=
 =?us-ascii?Q?OsRSJPErK5YP6TSzln1nMrKcgXaxrfr4etnuSBX7Pc02CERqr/LG6JYraKA3?=
 =?us-ascii?Q?qPbIdPVfz722NzWfTl3sW9UXVy8oouQu/KYqRh+c15LSNeG6tBY9jK0x+wT+?=
 =?us-ascii?Q?w5RNvBbTi/veOZMMk8lgpnc0jkeJ1ujKm2SlK8A5czbJyXr4TjlCr0PNnk6B?=
 =?us-ascii?Q?D3gLml+ku2fXUv26lDeDvR2/1RhiRkSRDRAYuIR6n84UQ1P2iPyoOlj6AiNy?=
 =?us-ascii?Q?QPQv3jZLurq+JZFM54AaaieOR0wC5B/Koa9EqaPa2dbVoCZjA7IDCV9droyJ?=
 =?us-ascii?Q?64tXHnsXTfnhGG9YiaFPzWUfsbMy2xl8PTm1cjen8oZ6IBT2vlTraywHb5G/?=
 =?us-ascii?Q?6mLCc38JuIdEb2cmCvUOTmJx+yuSk66z9ct0WrUc3C/CvvsarBgYCN/0O+rp?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EFZ9tZrfCxV1Nsca/mQrlXaWeCJbiwD0qbiD0j2JQepVTbJW0rvi4qkkEDxc?=
 =?us-ascii?Q?HvQrqPinQt/czT2laJcAjrKsQzhfk6FpjWu2pOGgUutDBKoRGiGRlkagbNm7?=
 =?us-ascii?Q?JtjmbY80rbeH9uo5XXR8TW9TUKUfU9bo4i6CP1ickqiazjYsmHrJ1GsqbTMT?=
 =?us-ascii?Q?VVkbXj0LVgY3y5Y395zcefYUKCQWUyj65NvH80dijGta/UmwQsSNlHnUoNiL?=
 =?us-ascii?Q?JBlOCwd4PVryYncZSdk/pEwKAoHSHbkX0SCOFaJIfLUtkbgh9DsBFHvUrEaU?=
 =?us-ascii?Q?XMWZNOVFyLWcLwGYFPAN4qcsM/ZQ6+YTxgxAEpOri26AG+TWpjRkPWKmIoIf?=
 =?us-ascii?Q?+7c3/XcvYeRf12L58O98TPCfAlF+rvIHY1eYNFE7FBEFsuJ4Hs6oZpZoG+r4?=
 =?us-ascii?Q?NDq6jMdbO66N6jWKiZj5+ok88R22iOCPgApUWFutfBoA3cMXj5APu7vVGmc0?=
 =?us-ascii?Q?csOlqD8XjeeE/GDTV6tF7WdaT+9f/LpFqucF+9977HZpxcqe0Bsfqx+YYQod?=
 =?us-ascii?Q?D1SNbYBb4NNmcrnwNHHOCedooTVuoN/R5kaTJ2WhvA0Zri6+iFPUtoujGNqG?=
 =?us-ascii?Q?s0R+bOZJTUBquaotL9ZcRQB1nPxqPob7Wd1SopW2G+WtgLKq27n+c0EueAjC?=
 =?us-ascii?Q?SyswkngXBW4LrCUjifXQLGvOMhDu6icNle69bsT+ebTWDUL2hyKBAj71JalL?=
 =?us-ascii?Q?Jx92UO7Be6JAFkW3d+Uarh73Qt0Rf2+POmVl37SuNcsX5ibnmv119iUx4AFb?=
 =?us-ascii?Q?5RGdn01WvaQig2XO083GopvZHa/qljP9lOxuKpuQuK79N+71c+nzmELpA4XU?=
 =?us-ascii?Q?u1XeAdtVdYKCdOrL0fNA+fFbPmZeKulMzpYMXa8naaIAJU/+tj6kUR4fghGI?=
 =?us-ascii?Q?abyhnhKtH9R+3/4BW/BxZvw/VDL8YAdA/NuuYegbARBmZQ8rSFm8VKW+iCgo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f98b25-61ff-460a-1927-08db6b85404f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:25.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Byx8VIziLtcaGLxkhXV51lGLldpzDUcRF10yiWivYWusligkl5CcTtLzD1gGCGH3tRbXFjjHCsGwBRDZ3FAX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=983 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120176
X-Proofpoint-ORIG-GUID: ZeGkSo8bZNxgKlZvaQXNXL-sJIYC_5hQ
X-Proofpoint-GUID: ZeGkSo8bZNxgKlZvaQXNXL-sJIYC_5hQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the definition of vma_iter_clear_gfp() from mmap.c to internal.h so
it can be used in the nommu code.  This will reduce node preallocations
in nommu.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h | 12 ++++++++++++
 mm/mmap.c     | 12 ------------
 mm/nommu.c    | 12 ++++--------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2691deca9699..d78fd0fafa3b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1057,6 +1057,18 @@ static inline void vma_iter_clear(struct vma_iterator *vmi,
 	mas_store_prealloc(&vmi->mas, NULL);
 }
 
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	vmi->mas.index = start;
+	vmi->mas.last = end - 1;
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
 static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vmi)
 {
 	return mas_walk(&vmi->mas);
diff --git a/mm/mmap.c b/mm/mmap.c
index 75b2a86e1faa..22c71dff762b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -154,18 +154,6 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
 	return mas_prev(&vmi->mas, min);
 }
 
-static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
-			unsigned long start, unsigned long end, gfp_t gfp)
-{
-	vmi->mas.index = start;
-	vmi->mas.last = end - 1;
-	mas_store_gfp(&vmi->mas, NULL, gfp);
-	if (unlikely(mas_is_err(&vmi->mas)))
-		return -ENOMEM;
-
-	return 0;
-}
-
 /*
  * check_brk_limits() - Use platform specific check of range & verify mlock
  * limits.
diff --git a/mm/nommu.c b/mm/nommu.c
index f670d9979a26..a764b86b132a 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1383,17 +1383,13 @@ static int vmi_shrink_vma(struct vma_iterator *vmi,
 
 	/* adjust the VMA's pointers, which may reposition it in the MM's tree
 	 * and list */
-	if (vma_iter_prealloc(vmi)) {
-		pr_warn("Allocation of vma tree for process %d failed\n",
-		       current->pid);
-		return -ENOMEM;
-	}
-
 	if (from > vma->vm_start) {
-		vma_iter_clear(vmi, from, vma->vm_end);
+		if (vma_iter_clear_gfp(vmi, from, vma->vm_end, GFP_KERNEL))
+			return -ENOMEM;
 		vma->vm_end = from;
 	} else {
-		vma_iter_clear(vmi, vma->vm_start, to);
+		if (vma_iter_clear_gfp(vmi, vma->vm_start, to, GFP_KERNEL))
+			return -ENOMEM;
 		vma->vm_start = to;
 	}
 
-- 
2.39.2

