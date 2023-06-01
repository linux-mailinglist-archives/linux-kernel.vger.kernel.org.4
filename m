Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322B5719075
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjFACRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjFACRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:17:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFAC1AD
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJvV5Q022056;
        Thu, 1 Jun 2023 02:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NJmVxdLzLEbLcdb/yA4FmvurN2C/Dp3Rfx9FmMeuxiA=;
 b=I+d0Hgj/M0vCZE6XR5DjIjFcKV1xAUtAQRMVU0yVaxCUIThDsrgB34s/p7h3vZgDYlIk
 vNkVAG5ikCUV14bnbFNG5G0UWwVqwe/iS49Kx4wJE9c5Leq7O8ZtB/royKLxWD4v0Kk2
 2FkY1AtsWQGu+/rDNORnYxWuK5jl2Nafa1VF5QKw8A5LNpg40cZZtJytnc9d5wTJD2Ur
 zjMfjPSiYs1tlfzfIyukwu9yRJ5l5wD9o9zsR0O4xnAhKWWTfQMtxxhbxtyxCxY8XHtP
 htvFvhHmzm31yTG39fwc0zAVTD+k3Bakpu/EvMUq4ftX+zEHAe6ola49gKgXAojotQyx sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjqja9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3511YC8c014618;
        Thu, 1 Jun 2023 02:16:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6grag-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2XFJ3yC7py9RGj3tq6UUZEEtzC748NiBt6zM4R2FkTxEKtUQ24iB8yxsWFjKtzB8jOEmYn81l9sGXGCqXiBROq8Sa7ac/6bfdHqHq4/SPTbIVJ13aNoc3BvKq9nNdeA/igqyVjBBW7R14B/N7kLQ4NliDsT5ETJvzs+q44qFBV1G3voctwnsiRX59U6hzwaKz53LfRpmYES1FxKx6Cx+e8rW3D28Gl9IGa1usQ01QGy8BvudjS5BsR3BelAlzEVzEkhXa+GIW3bjEiI/CY7vw2E8VxoQ9E4dXsXqPWPKyLWxTVJ5jEga7qEXdka2hLHP3Ci4ZqbFyDnSpdZrCKDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJmVxdLzLEbLcdb/yA4FmvurN2C/Dp3Rfx9FmMeuxiA=;
 b=i3AdvXyA558q4BfbbuMwyRQZoIl1DdQUEGXdLHcofWLwkLwnMcTqoxB/LQ0iFtKFnHWZeVrQiuzBwIneySlsxgtMiT0i0KZSRg8OLT1soimBYK608thggv1u3bDSX2iYkQST8rsthcSGpkK2NSisLFTI82OVqMapDN79/XmqUjtz16s0LaHGGI6Txkh29pbb7RYlNlHthWwfZcamasGI43eHwFTLoXUq444okY1eoqMSGpVj1hOSDvdCyjly0rR+Auv56XVGVGBDspI2kDhMBX+DyVZ7jz5l57XRU47UejAAjoRet3xNL/FuAFcpgzeHdQhrLDyl8BQ65ir4ad5eiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJmVxdLzLEbLcdb/yA4FmvurN2C/Dp3Rfx9FmMeuxiA=;
 b=ZXM10YY/U7FFQJFZ4l9jgQUb4ie09s/DqlQSyu6TClprXJWqr/d8FDHrBzLCD51/Bgh1DuYeG9pBPPHqUGo6pYbP0gfUwsOuPL9wMOvoZmU/kjNpfkzl6zK9ZaXZQnhbVIlrLY8a9IhBsuInRvcJtY2YO6M2AqvfytiLhtCOtBU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:39 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 09/14] mm: Use vma_iter_clear_gfp() in nommu
Date:   Wed, 31 May 2023 22:16:00 -0400
Message-Id: <20230601021605.2823123-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 764d96bb-2b7c-47f5-bfca-08db62463b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/rL/6OAsg/3tWtZ9GOKA76CIeF+ACWSp1kqJrd5XZmfvbN6cWP04nLURx+5zFk6Zo+cf226C+ENpcT2zZcmaypTeCYNIOuj0te28N+L1aVDb78v/76VLKQPqCfpvm7VwkxW+YV/khSKnF/3vFsTX37pEq5vPi1GNb6yuhpPEeKaKkNyg0sUaOsV2epM0Gr/bwGXcCEd8UgtGAsqA4TIzpn6vlpNoRXcVY9AQtPlg+069OTGSlKLjffRU2k+3PfDTBuQVPSP8TSF+RLRbqHXa4rT9FCUQTr301g3fiDZdfVmrRihYrxleE9OqI2RammBax7WWFIvZlI6NLOrnDEPe3cE+dDiX4+PRDlOM6oGE3ryPAzmCkLJYO9egY5c/7cvUxzkNBttGU49FnDQ41TPAPno8cvM+qP0kqs2sjnRqTBi2lNY0oTPgdYRYn1H1Hb5ALhSq6TkhNhA3n7FQBy0RW7tA/86ooQ8c1GRWfbZR8p4+Rp3D0fupc5QcijSr8AceHIv+hQB6sXUEzB7uQ5Imtnbo6otrzSSImSPGWCmZBHRnXFqWbed7rbZLrMcnC5H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?itOkKYcsysgjIM7P3IYuUPPD9KDnWfwJ5NNbl6KwsERDU29Qo+m3rKXdSoHs?=
 =?us-ascii?Q?XYXq2aIrCx1kn+vWiBvsigCXzNtTeO1r7Yq350UoK4H5lCbH6slPlrbp+f5q?=
 =?us-ascii?Q?JeVEO8TG5EajtRetySBWT6hJn3JAvRO7O7RStwBD0CAWfIkZm2Btkwypt3hW?=
 =?us-ascii?Q?fm6+YLucJC9V4mDKA2KS1l9NHIQXLmhkw1EW4McS1C6jmN6hqAeiH8t8tClM?=
 =?us-ascii?Q?3f6JKrfZApb3/StEgGQxBqeZxMV7Gue2WjNG0IOJd/0EtYBmhOghq5qppP0J?=
 =?us-ascii?Q?6lP55cBs463bWPszenfQh0d8GNS+rn6AYAdIN33CKCLQI11Qhcb+Asnfyc+g?=
 =?us-ascii?Q?/pwPVSo1tFhXFOe0AF6cF6Hk5IMlKVx49GKTuOzGUBT638KzGF6ngpo5cfuV?=
 =?us-ascii?Q?7T8JyToGjhlWC+CUJEwMOfs85tgjw6T2myqGF/LEjUjMSdDDWcDOaqO2bm+V?=
 =?us-ascii?Q?rmqY0W0PtBtTY97vDcRSjf1OtmIpVYKB4F8gvBbFwfBzx2a2TggpZ7NKailg?=
 =?us-ascii?Q?ccljN9OfjgJmIOA9YkvOFX0R7foB0Na+Lni5+C5geUyAb8GJhIJV+FRCzojT?=
 =?us-ascii?Q?KkcqSFRDPgBUgO0Oy8sKdTJ5c8wJapagxaibp21xRJbtZitPGA/sARrDYXwz?=
 =?us-ascii?Q?M1c+epOb6hVPPanGxeEZoQIDHJ3SCdiZMknIGlptTwFsEDcmLvoHPUN0XXsF?=
 =?us-ascii?Q?QZi1uU8BJHVewrQc4sQnX9c7Z72rem38+N2oL2QkPZjJK9jTTvLlXCPRNaRx?=
 =?us-ascii?Q?coLFLo44l40nZYF4VjqGavv312n0bEYelXUDoWPMOpcqo3P5LiDXsMYMEc9R?=
 =?us-ascii?Q?AjjpNiBjdDscmMQSZGGPJqSED0/qeCPFV2bR7POCN95/xZZ3VDvAZkRgfGtr?=
 =?us-ascii?Q?PHJkUBUBD23qX4ksveS876SQknvvGc2c/zs+rCc2UPXFPRGVo2DXzcf+X3Dc?=
 =?us-ascii?Q?HmMp0zBFupW3MehS4FgPIsX803zoOpklCFoupTWKTtFyLpGkKTkfSqBlNx21?=
 =?us-ascii?Q?rfzfGzPYBNgrd57/xvfrwnzSDzk9ZZkJ/ulpulJJ2XN6nRdycO4uQ5gmQVPp?=
 =?us-ascii?Q?A2UzMW7brUFmm5Oj+BYFUEkGS4ZVeKekBazyaoKuuZUdBmTxfTozK8nnbwBc?=
 =?us-ascii?Q?TfoSpYhmTH+LvxtZHhPq2ZtcG3t+aNLagkzrmcTJFx0kvQ+2wRBwNjKgm7dS?=
 =?us-ascii?Q?xju4j+W3eyNAe5Uj777B+Ijju76cQUbiYd5ypEBWW+Gz/stIVFP8XHNrhbvR?=
 =?us-ascii?Q?tAvOzBvyJkGnDNaSjMzTfN3SPlEP06sTbmq4IDIiVPvy/vwn/7wc3xy8xg+y?=
 =?us-ascii?Q?kO4YZQpL/H/vs/cvfqpU8NI0SDlRGkc5EQbTNuPh//4qysI716r7qaFWB0RN?=
 =?us-ascii?Q?URn91p73YKO51S1Wiy2BQ+9xInAId2g3jPnQDutzSUTkHEXQzEKbLiIWXESd?=
 =?us-ascii?Q?zP/piElFJGuFZgaiDjHBo2Ex0mw+9Bw49TGOcnVk3aBTrgw4Q1xQNtTIHy4A?=
 =?us-ascii?Q?G7CmquTIczlts0alBKXUbIRV1gXzO9pt9hQlzOig9TPub/1+SEXlTlCbh+Zu?=
 =?us-ascii?Q?cFRrSwe9repPUZ85rfSBSJ0Nfl19hKRXCRZ68xbG1IWi+bCq2IdZu1DjIYDf?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gOOBYxDZ8ON9CZhWXP8jm7qQJ708PGlt/4qpQVdKC1sTq87aZVc9yUAiHyaTa01SFNvAF0v3i/KftqGlxeMAn8r7UAmelfBh2ggv38QHq5bXZFTiyZu4Divfxv5vBw/IjhXLB7G7pW7RWnMkL9Uyjce1u2WwPTEQ6Ajnuz9kyoO52O7644m8CbqROPZPWqiDzYdlXB5+tl+PYy4eguNSF0dHnqHjTyE4BXnEC1umQRY/GElj6fWZL/cRvKHfwsg7BdabT32AITtvZTUnnhEgXTN6vUksCYEL/+PT/f+F1BGB1FVlGyiURhWSh81CsdkvHZ9uw+ntSRWqF/O+UpvoU5/Lby/CZhtrOOVzujJQ5efKXgrJsRQSgzM+4iP8y+8FpH5ztwJ6WSfMdYplhG653Dfo9AkQH/Kc692f6E/3M7R9Z+NVI0Py9GDbSHvz9DemF/A9lE/EV+Q1tK/QpDQqpKXs70FsWI629APDCM0Dye3glIjx6SmZn9W4BQaO4sIe90jhF7MlEoF9zmvvWKWpeyJW+zf9py8rLnQU8chpLoljaYJNwy052kN6rEHnD/5G3BYwPfzNxZNNngCyrPnmeapy4VSug3kc6am+Mrcl+nhpPl+wjKYaJpWFSFM3r9/I+bO4Dl826euiPjbhh6JIuRlTM84U6a7MQnIfkIb/TawLRL50QZY7rUmTyFG01PkVmvCRIYO/awGAMuDwVB4XHqlI/wG8wu39YguUI3FRJmgik6XYbrOyAFxbbl2N2joy5MNNY/+7WLgr3q6GAISYJ6vtQxAvtxhvgRyeobQqO8pjf+aYD6wE22c1y2IIJluxfRCVgHfZ6qLsOPMRE+22iL62RZeXZAMXe8l5T7Uzh63chdbB3v3XSy+nWYn4SvBvwnTUsnmWTPrhKOjIkQGCDA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764d96bb-2b7c-47f5-bfca-08db62463b95
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:39.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8zrHK8zn9VdbxZkBayF4hNk2VJsNrK3gzLySnBJKHe3ve7BDwzA3DyBecDOgEycz2fOWcfm9b+MFg1voBZCHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=985 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-ORIG-GUID: lrsWdV8N_1lIOYm9arKpH7kRzafi5vjx
X-Proofpoint-GUID: lrsWdV8N_1lIOYm9arKpH7kRzafi5vjx
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

