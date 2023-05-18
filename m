Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67DD708476
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjERO7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjERO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED3F173B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ICEqPV010486;
        Thu, 18 May 2023 14:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kk1VuRS5kSNxVjC5gqUqAVN5sQ5M/Ew4SDikwGYXJCg=;
 b=HITpHuHOX1gPHewBmQthXtlbWE+BVFgaYakYpCF/j2lTTCgVF5S103/hvxDM5kDJlbVE
 HzI4WBy3Cy/p+F1JKM1ETDRN/DEud60pAhqMyQc6s/Mu5entdTuUvYxIqPNnx7mxhMbo
 ZKXXi4wHRTruc3mdfD7vEPtV0ipM2zygnbG5oswqPSpGJOGJfIkv3UpEbnPsAI2zwURJ
 LblouYnLoiNcoNIZQfw7PIufB+b67Sxf/gTqew1Lj/bykLd7HO0IBf20u0htgZN1+Eqg
 659fpJWcSjBOuCe1g975Q85NtvYRr2dVN76VzUJGZj0lpic2XilUMhsHb/bLKgBzJ1fM eQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qnkux8ame-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDwvVZ004274;
        Thu, 18 May 2023 14:56:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10d67yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFhMc4LohmRJi46ozfUuvePWITLAo877BtWwIFnHAyDIz/b09/h+6Z9D4kulrQs82ukhmkc0Ki8tok2exMqbIrGbX1AutzKBKxZko5cps5oOLpkIq2vvci31Kw2jAm0vCOc3HBccKrLybxOQM7qzYmCjVyu3auyOEVmR31rd/eOkcC0cDBxvTPdprPUApxofyur1xXvpupDDXZ3/eJgBxGfA28Yf7rFtuOL5ourB7jE9oLOtI0Ws02IrmULLDdtvtpah21uTHFSakPHnMitOG2IC69GXBEmnQIJ9yNRRIIA14f7A6TuVpWIr3GvIKnaMAEbhQ4h1klNBJOEgKNSENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kk1VuRS5kSNxVjC5gqUqAVN5sQ5M/Ew4SDikwGYXJCg=;
 b=gEITRlcxny4bRBwPd2LUGTnGcsIXmE/QepPPPEzG9XukZznIaVQ12Fcj07AfDY/IayUX/9BNRTtnoQZS+HxVVVQ/ZO8NxX2DlnqJBljpQK2lz4HDCNU+AhlPyHtt9ak3scO0r77qR5MBDLPltszGoUt7WgXp8vZ46KSF93wRNAOa6QwIZ0iF2qjFHuek7g6W+03Uit2pSVBgcSEeDovnta1RJUCOweRWGC4F8FHrQVg2vjmzcunG6UhLvwA+IF4B6gFDh+qpOtNvjFyFHfLMqQb9wLarndtP8ZVVMVlm0e/Ef7lHVUAqbviqi660hfKYpIVBUEY1vMJaGacsmuEp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kk1VuRS5kSNxVjC5gqUqAVN5sQ5M/Ew4SDikwGYXJCg=;
 b=LM0vOOVd/T08go+Up7CoYYCTbmywOjCHyHBHT3k4LqXOBxAMYMx/trFsCZ4Kq8tCh8C4mmChdO6f4UzqLuvo9J5u3A30ne9KGCPoDmpCkncQ8deyuQXej62baOhMB059c3Ww3DQWB65eMhPznApNXzjTztYxcqZWOQQ7FCK7LrI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:40 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 21/35] maple_tree: mas_start() reset depth on dead node
Date:   Thu, 18 May 2023 10:55:30 -0400
Message-Id: <20230518145544.1722059-22-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdcf175-ff33-4eae-cf4c-08db57b0166d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sh+maO+MJ+D2kakE8yMdjywlVS1OOYEBmMHJ6xzs47Dta+Ww91AQ6xvQ7yP2vpYcVV2IKHkpyRG/QysNcIcsaUnRlcemZg7Er/94g8iQkKkJ4BDB7tZ+Ecmq2Y9K/FbtV43d6Zmdxo2pIk+PPLvCAGJ2eP1szUjvbS2aTiFtqAZSQHRgOYYahe5taWUFwxI9UyHPmS5Kk7imC8XJN0hU0Vegys+iC/62tZ7JArn5AD2uCUKsZpUfMaGTgEQsSscEGNgzW7DxHr4r+rIYXfxzXl/ASavqluMn9zluvXtYnqdX5fBDwKmiUqXADv+d7ZExdGNEe2lV4Fid/4htPg9mKW7O0V9238NYXM6jugil4xJacg87XG1pG81vPAnjVt1UlD1E7DODk52vapenqjaU3XfakNLCcheNki4W90+Ry1iqD13zPS0mDh+TEfojHaU30J6Xf5i23Zsi9iC9DN5ccHEd8bG8Q0auo0xOWCNA/OlpOpWib1Z955xFItGzLhv/femqOF7qcCvu8NQkRI0WQrIjQke5s+PkIzxqV/TaTXur0BczWHnL67ZLsKgj+Yno
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(54906003)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ie0Um6gvSo8/SARPKGN5YzBIWkExd5ajggppePzd92Jo3bErlhOnm+9b68LU?=
 =?us-ascii?Q?STa8lzZezBcaxwwXtN6O7m10yw8mf9PYr/91mCklb6h2QvvcoJmDqhpxun4H?=
 =?us-ascii?Q?ufC1l4s9RdAMfviIgCnqwD5l4ya9Ghyv2jTa1Zm2BBMWSjgLFewviWKA4jOl?=
 =?us-ascii?Q?uwHpvMU/Ipgw6/ZISg5O1+tOn1Kc2C1941dq2MoSEmWZCuNGnBSqhtUvLAa5?=
 =?us-ascii?Q?Moo48qzhmQtaaTI3+F0QJU3A5busDRQAMQDakvTBcCRiAc0bWK6XjnoHcpKv?=
 =?us-ascii?Q?rCRhYPbCC5xzqZBhewwiuGQACgVt4MM7ikyHI1g09G0re25TJCYo4yNjqk1i?=
 =?us-ascii?Q?J2Mm+/tFlvvzxzQ637aTgTqRSnQ0Sa/jUU8BOm3dSTVaKuTvLPE5gync4wti?=
 =?us-ascii?Q?N5DFmmPTJOPiSvSnTjDnIxW0qSRDMrEjJhQhB7Upbamk86+fkrarBArj0wHy?=
 =?us-ascii?Q?1Brgwgj5YQcJmky/X1OYdOqkQFSp1o1LfCtqoQiUbjcsxBN7DFtJM+Hrzthw?=
 =?us-ascii?Q?YrqLpEOGIVZWnlt9UCrzEFfQPPAkGO1LA0GwSkO+Bueao03L6wAKeSCfmLaB?=
 =?us-ascii?Q?/ZmOSh59kWR1AI5EWgihj3sROMwDknwT4JJRVHsiW/Assjo0Hvsof6e6hKZ9?=
 =?us-ascii?Q?cfUAdT+fu6VKEzGX1z7jhOplDU0haHBtqdx4Ee8l/Jrwpq5wNBE/qFz8FN2u?=
 =?us-ascii?Q?OA6RRsu3mdGdG7FVGz2Y/FYh2DkAzXPRRXYWKAdmevZU2YbQ9z1rqP4DaqfF?=
 =?us-ascii?Q?jVCf3Ts7Bo9Vi+ptEgAujDeHz0z1AwK6xzuP7NuQtdUfos1jZHATM7MZ8hRq?=
 =?us-ascii?Q?xnXVlCEN+vUwnEJ0F0BqCFewcovJzYmMMlxTf1ti7spA6nc0r5d5BviA60wg?=
 =?us-ascii?Q?gFBRq36Gs5ua6qAopoZ8EuctW+tFC3smJSFnrYVmdtwiR2GQBV3SjDw7p3DJ?=
 =?us-ascii?Q?716CdWxhYcZWZqGadbBikiO7ryQn8FmHRScD2HWqjFClf1wGtF1yZpLtrDik?=
 =?us-ascii?Q?Q1hxHaVht/IBlhOdRZU8XrAVY/jsttBllsWt5UG7BkKb6tsbvLUopQImbdeW?=
 =?us-ascii?Q?AaTQd+lDEFKb3skHUN0GOQKZR1dlXnjPphtF/d3hYCmYaAxpduIj/XeeEFCf?=
 =?us-ascii?Q?aBRiFzAWQQkZa8ilYKkA4+IPFZhIQnLeZbZtxbZ8ehzIQvTFpJQrQQ0iJiaZ?=
 =?us-ascii?Q?5L5x4napfXImM8ArOCT+B8i3z0S08jBo9nRizl+PXZRRj/GD7TH9KDJaAFpP?=
 =?us-ascii?Q?5Jy+NmQ1zHAkWtL+ey3XKr6J0CsSkEcUhIDA4ghM8EBe2Av418Wz7AkOolki?=
 =?us-ascii?Q?EnsdTy2pf3B4GnovbsdWWbk4W+5iOhgdlvUnAn2XzTlFk0GHBWem8z9PXD9H?=
 =?us-ascii?Q?uaNu2gUYEGqlrxlD4yyybEstys0sv3Kaw243H/WOdRLJvOSyuGRlVdVg3Sna?=
 =?us-ascii?Q?t2aqOjh8u+PQhjD7nI2dxIEUqzKiayvt1ObOX1YtBIqquaCtoJ//NhE1eKYJ?=
 =?us-ascii?Q?Kn9goUN00FLavkA6iIvKWyTsXyRXkarNe1n68V5546mw4PuPUklZrguZQAni?=
 =?us-ascii?Q?lfXQoEgJTKF8ZQTyOcDlNqGsN8opYT+vauV+8IGV2vFJeXzduOClyY/zgjnb?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?15b07NxpTF7KDRLvHGzKXeP8bcIIXNkWfQ5JcxJyKM7wJVLN+7iAp+BFjNGX?=
 =?us-ascii?Q?r0IkD5F84qfxguEROlpB5ScaSl0/RQ3I3OX9g2VvJqNUBbBz28L1cJhN5kgn?=
 =?us-ascii?Q?cdfQEzmsAL8gjAqMc1zE4oXDIy1s+aByYfdpcqc8AqNuxFFRj3olTZA6rcH0?=
 =?us-ascii?Q?R1T0xjwBj02jIrSFw3Mrq9+pNOrK+L45hoa8TKOSzISj20zEYqiBekJgy1GO?=
 =?us-ascii?Q?DBPhbmtFA9ALf6PqNq8A8K9eTYL02C7EVRwrNy8/10dcqkVEbKVLXuXQBZ+R?=
 =?us-ascii?Q?kiPby8tY+d4KylMB+XwVKzSpBC2RF0CfUjKO5I/XIierDOKMpmtPIRyzcTgP?=
 =?us-ascii?Q?iKx/6txRrGEURBLPfVmlZcDa9kj8gKh0tr5nAjiFCEwW0oblJGzfIAPGBoWp?=
 =?us-ascii?Q?tvVOI+tFoASdqtK8cez6VynUGleU+Fuy5oJPIM1ee970UGO3ENREit1vYy8b?=
 =?us-ascii?Q?ypwPcyUMq/JqEd1JegVzrKnMo0z1R1U+a39bFdtvJqg7XR5Mp4W/n+7s4ck0?=
 =?us-ascii?Q?HSFBUSRk66C9LuzUWTZ0Zpc4AimKNqo1SK1naWdxVXQTS23OmehLgBVk3TYB?=
 =?us-ascii?Q?SSf2g1Yc9lzCXAA+f+Stm+35BZdbAmQfUxLmirWury8fHjrmqMLwwDGDTVZI?=
 =?us-ascii?Q?fMbpkT4IJojuZnlzql+45qZplqnsi6mDlzKea9GpJze3VhwRhXrMiEad8F2k?=
 =?us-ascii?Q?kA01OuGk9GrI0JEn2DQZJYRX5+zGyo6rP0u12bVgNvSGDI3/7oHnQihz/nKK?=
 =?us-ascii?Q?Wzvv1jihTfWWwGqIzSKMtc2U5y9f1stAvfOsb+l0nTdx015CPRbFgvxqkF48?=
 =?us-ascii?Q?Fl3rpzHCXpqc7A2w/0r4GXa6VlcSkhe0IGw/+mowK1OdgoTQ5TBgo1/hehSN?=
 =?us-ascii?Q?RE1hWVYsTFYr8VlcvOet+JrlnPnu02hQmkANa7L8ustQcRyUayVGWklgnt7K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdcf175-ff33-4eae-cf4c-08db57b0166d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:40.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1QRjIvdwV5wrrRu+eop6kYsZQeWmkQRpd8QsrUECTeUSxhT+l31Y1m79hoIL+x2QKY2Tt+05pnkUyS6F+7lzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-ORIG-GUID: JAAlHjXfQgd_QeHHVr3E46svQe0rlBK7
X-Proofpoint-GUID: JAAlHjXfQgd_QeHHVr3E46svQe0rlBK7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a dead node is detected, the depth has already been set to 1 so
reset it to 0.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b3e5ae43ff8f..e233f41ed4da 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1396,9 +1396,9 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 
 		mas->min = 0;
 		mas->max = ULONG_MAX;
-		mas->depth = 0;
 
 retry:
+		mas->depth = 0;
 		root = mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
-- 
2.39.2

