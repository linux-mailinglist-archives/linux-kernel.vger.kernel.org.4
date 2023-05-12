Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08CE700EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjELSYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbjELSXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:23:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C110210E5C
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:22:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4ZYi021717;
        Fri, 12 May 2023 18:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=zUoTYTMCkwTw/+6/qqWbswBoxi9E+3/SfiPHa6ic8us=;
 b=zjeWn3ZalKtfRbUWFX3IlibrW1HnEkhWTRNMZDnB/wThl/ogi/z0e9pmEmBqAP7+Jzje
 +Le6wdTGI0TYAjAtkJ/YHuT6Mp0y0LyxmNfiYzZoggEnyCC6fVym/iGHGhN3qi1dPsok
 AakyD4GzcVrKq8FD7DnxRH51+8EXiA14RxN0H/VqE9gtDSmaRcJHY+Gk69fOg4Lm0dkp
 eZREGjbyAc9GAaj5tmNt51VfqMfOEOUFeFXhsefHNtX4bqcwB4STjmJOkf04TRjIOwjV
 ikAPLfPRiIjFrSQJn2PJkTKYYThBNdAwlpdAdHfjASPvu8HtwHL+r/vUunl7hJVGx7j0 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7793h2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHMa5v011717;
        Fri, 12 May 2023 18:21:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8156yq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGigkAcDbFDCAM8DSfSQrgtPaGBiE1X9JCSU9a2x99f3cvWzcp5ilb3VSMhx/Qa9a0pKTJdsDH6+nDw+i9pmsqnagdrl5DnUPVSAuVRLm1R8NJO0mM0Bpt8f0/LW6nqjHF1xAy1+6FzY+ToTWG43DXxDHRvxoFXZph8+f1QDyRsefWsoutO75oEGqPZnPFah7kXGpZUjNu3AdzR9LyMbtQIPmSUL8cT4VbhVXr9AhKSG44M0ttmUP0gLybYYd5JAh1/NBEB0ReFYQ4BXYe5z01pdQnk/SSXUsGRC5JeNysl6Uwn1v6wRJgtDSP3NJDtwknswgldwir43R43msckpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUoTYTMCkwTw/+6/qqWbswBoxi9E+3/SfiPHa6ic8us=;
 b=OhsbC4Lp0nzCIQ8FKmYJ2RMWyhahM3DETF/PpZH31J69taH73Dje0oJ/gboTx+LVwevMPujWviSbnk4FqVsP/9hBUQDneLht1k4MM7z+eoLKoRowFt8vsGLMAHpj8mzBgvsyl1NOnpxfvgO3+ciXI1BTnWzf0CJn2Lg97h9kRJbhQZQX/SQuPdG7mO8LWbTzGZNel9XBBIRBRiVFIU84YFiifwcI+zIiey2in+l8ZJ192IZXGwr4Er1d1qyGmicIGyNkdmAGfkrgF76La17jYM/2y2eUlsYKA5+1Y2JzZpZyh7G22KKic3LKi0TNEtpjFGrEfsEF6PzwGRUHQfE1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUoTYTMCkwTw/+6/qqWbswBoxi9E+3/SfiPHa6ic8us=;
 b=WbvaNgIFCpYa0YJLl2MFchk0zR/+SfA1nMNARScqnprt9t7Nw8ZiVxplgjdl8dMjv6cD2dYk9V62bXxUZ/V3Tf8+K5EkF3CSLwnKVsdCStfRu+eDwAsMh4+ADqxsckvOkmhCMMYlU4EXc+kmKhxh9ULH+Ydg0T6dMSvZF5NnneE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:29 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 15/35] maple_tree: Return error on mte_pivots() out of range
Date:   Fri, 12 May 2023 14:20:16 -0400
Message-Id: <20230512182036.359030-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0282.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cb0909-3842-4ff4-2ee5-08db5315b4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JRLj6x+zyICInf1tmvUsrKXuBXYbVBLJ4i9Q0u9/Fm/H5nfRqRTa7+wi8ODooWGMRFvTglgS8b8EATAMQc015sM5AIbDCPyTOZMUKZTyW0O/E8RjYudN+7ffDCqM/dBMFWyuEdKBMn8kR2w5DbvBlWD1ECZakgL9CO2uLW/JG3W3Zs7rU1xvWiCjH5H/4kBCLHqJpeLMjsUoJwdFs3Kzn1dhxCALiCOJcAfgbILDrUqjNm2QQQm/C2u1ADlzMMvnK2YIvZnwheUNRZYaac82dwWOxECiWBAJYEMGcpmlPUTz0VDWkoyVnNkSsWNGcn8PIMn+BE1JRjrzufDfXIXgHy1ZB6J2lSEcqioTg9UUqZhD3INGY4NiCvckij+zpd465S//dIsIzFeL8AHnd5BelXy8fVuUaecVMK2DGUCygUE8O8DwbWBHCXGsLVs1hq0s8IpCRxwznMBd0SJDuyIK6U4O6BWGqgN1J7Lg4+bu69FTS0rOH25zzsJLOJnKX0UTxnCfqNRthgmDmm2ZPB+gg58CkbDpX91I4k08zC0C2MB8Q0+C/YZ8sDiWYOakBt/v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(54906003)(1076003)(86362001)(6666004)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fagwM2wTlG0EwDwAZVsOHZFN9kHbRHDWsNXczhxhWAcBNej0tmvZ/KVPOvvD?=
 =?us-ascii?Q?qPe9LABfwJDhS28sPE4+Br+hSRrz75c8O6hnrDy/2lWDJEK/uFM5MhWDXwyY?=
 =?us-ascii?Q?vEBD3k00o7/JceyyNODJ3YEGz9teysJUjrd4ChItLAdCtGpEWlJtPUirdrV1?=
 =?us-ascii?Q?eG1k2e2qcgl51a4bADjDO80vt/F5zIw9CWL8N5air9Y+X/GWU5ms1lmn/a8f?=
 =?us-ascii?Q?OqOehIJZAP8vdwVNROEkcOOHSMx+5r6GulvncdO6sc1K/6JiXLiLCaCCL+X+?=
 =?us-ascii?Q?02mWVZQdM4g2EGRND0POY2WbKdnTZ88+LxtgLHkiK+O7XzJwa7nhX7C04+pY?=
 =?us-ascii?Q?3JXNRasNHmsM6XyIXY5lgKw71pSx5i9xhcGBITE1A8+E13KOD9I27dpqOuAB?=
 =?us-ascii?Q?HSSozcDQNoG91a4C5dEkxcVB1G2WBTVqP62gTRBIqgW1rTFD7PybVl0UFKyW?=
 =?us-ascii?Q?E0ij1S5WeGQNmQsKtg59EfgLw5xxjZxR+tOy496fvp0iO2HV4RXrLGPQ7Vpd?=
 =?us-ascii?Q?9Uqqq12nIVmNxn+8AQBYn/fmtL5AqGZSxJZ7UxMol8tYXKp8xmqWPsYE7kDX?=
 =?us-ascii?Q?mv0CNMEgXIjVv+SeT/hpeuA6zvac6xP+VkoRDqysL3xtLhtTtcKMW2atBVvt?=
 =?us-ascii?Q?bwkUNHleq/t99RjZ6risSJRz5yZLnn1lRALto3kfaHjwbehnhirPgFcWBvom?=
 =?us-ascii?Q?4dqh5jk2McOe5Wb8Z4T3jq8jH3fBMdYc1DRNjQUVbG2glw0IQMFx1wUCtXcj?=
 =?us-ascii?Q?4hfFJLTxLhQ9V7SZNmInZRoVtayXhltVsv8097Qaywu+Ly9PQPqG5PduIxgh?=
 =?us-ascii?Q?qiN9AzuEvCURTqPV7iZAwUd/aJFtn+T2PD7JYNjfgkYo99x8jkfJcumyqdLa?=
 =?us-ascii?Q?pvV71TWLUTfGB7j3c2Kytdmn7AYwKb9DDHwA2/GlfL2U6DFSDj6Q/CfvBWtu?=
 =?us-ascii?Q?mDBHK1fjyc7DhgqmRSV5yIoi0MrB0KO477aQCWDsU+2o6ucG2JtLeRb1roE7?=
 =?us-ascii?Q?ovu7WbN66YD0bC1FCoqEh0RnGZHXNIbK/x6u5Pvr1nMt/UklUV/XHhQ9YDLE?=
 =?us-ascii?Q?zsNAXU50xdEsDevn4cN3kzeUuPLVOm8irQ67XEdz+nVVs037h0NJ50ha20ms?=
 =?us-ascii?Q?KqoQDDwVBVPEOGLZDMWrlFtNKxrG/cJfzSZlvlTsu1CGXxZ87zEHF2JqGeiu?=
 =?us-ascii?Q?Dqstc55ZELbCTvC7fhe+CxYXP+bPeYdi/TER1onWkYi2l1wyxdQGUaHqV8if?=
 =?us-ascii?Q?T2ddYyCY/aaKJdaghPpdoy/s/9RdN7Gv43ZzxSku1eK4O81w1tbWe91Xu2+Y?=
 =?us-ascii?Q?biXeA6ajINE4DlXjiPA0KJWLtAaNXWaQdj2rvTr12DYs9j0aq0MKLKrNhCG/?=
 =?us-ascii?Q?X5x2HFQ8TGehb8YJGDTbmtiTpZzhv7JJKcUtzsorem9oTl8wBKUZWFBT3czW?=
 =?us-ascii?Q?W+TZ4SZpcYcBQi4kB2q+G2SQrYXyojUQQFn8K2sLYgG0J9nh+k6hAmOUsEBL?=
 =?us-ascii?Q?VzwQePsk7bRk6enPfKdIWRcsYTIkQhXf89Jm91K9KpzFfInhaY/HQJN+bGY6?=
 =?us-ascii?Q?b0ETLAdsQ4PKM+2ujGpWzvxpuvtGr3XGuce9GSSY5N7uUuEuam9bn6FEySqz?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WSEfiWKUUnT0BOqrwj8eSV1Gx16lG+drxxOrVKdqdlUY5mWBrxSN+hwPqxk6?=
 =?us-ascii?Q?H5u7dOSbOr9y15/FQcVEI3AR0rRWbUQIyhbvfSmDKYDRLGeawYACdvgQT+1n?=
 =?us-ascii?Q?ZM+4v7YZNEyOc0KnrgYE0nC+060YY3ra0+YwV29gRY5qw2DnwvfUlKkxbrxd?=
 =?us-ascii?Q?YLih1Z3eCkmzYnGwpBSkuy70WOcQMmzTzEuuVusVKEEbvXDGVSPX94lMVJ7n?=
 =?us-ascii?Q?0Lob76TmcUz4p9Rbdd0pfX71zHqldtpFLFs3fAWFIOlZXKaQ/iDXXEirIRFg?=
 =?us-ascii?Q?I8rIEruDLZfQ9rCk7Od7dMRea4p2+qrCn8oGOlJp9xeqJ8kNKi9bU6wCgXG4?=
 =?us-ascii?Q?+XyUTVy1o7MI9rpS6++Mn6uNdq+mKNhH6ISccABHINj9btBkEHcG8J4kZPq0?=
 =?us-ascii?Q?4CP3pjrodBNydRh64bRgEBsAbke0peJyQYGhG4bjdiYxtHXVVIqIXe6he9ix?=
 =?us-ascii?Q?w1TaqCvi1oo8owwg/mR4++g6TxpN6vF/bi3aseU8kzJBB6AP056L245UMdkM?=
 =?us-ascii?Q?JxKtsj0dWWvPCni1y8ZegqFcK/ugSgiPbVx+mSB7j2MBrDaGDi8FP0M34kVi?=
 =?us-ascii?Q?Oey6AnoPWRxf2Peq+BALG3h2naak4jKrvKbFl52fxfSxfYGOZRtOLU+zBBes?=
 =?us-ascii?Q?J/RxhS3KS2vUjx9d6xo7ALdv5x8RLwk/geL1UR2rMNNqh93a7CFwSYsLC7Gq?=
 =?us-ascii?Q?PrpUvouM3Wxs+4lHj1w2zFtKA+CD+VBOtM3vOOuVwnVLjbfuJST4lDD70b6X?=
 =?us-ascii?Q?svPUuJ2z68waRsGIe0cVsSIxTvSBqwtrsYqq+uwFkQoY5QjVdSloYtFhO270?=
 =?us-ascii?Q?nBT8NP9bLeZL+9PLV/YartHhaWTQMKtctxtOYWqTQL5bVGWmJqLk4E0ki1wM?=
 =?us-ascii?Q?Ojab8mVwygi3qCTd8fpT2qoZsP3XqrIbXDMfa8rxrSPYpPpgFGGBtFTGHgbb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cb0909-3842-4ff4-2ee5-08db5315b4c5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:29.6421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KM0OUguI2aGH0zhUx7jZIlUmJSb586jbxFbxH3ldMelom92+tDbejAyojIR88C8dIjClEGKm9Dimd686DRkuoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: n-vHKpqarjIRa05frQUyVz_Dld6PJ7sZ
X-Proofpoint-ORIG-GUID: n-vHKpqarjIRa05frQUyVz_Dld6PJ7sZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename mte_pivots() to mas_pivots() and pass through the ma_state to set
the error code to -EIO when the offset is out of range for the node
type.  Change the WARN_ON() to MAS_WARN_ON() to log the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d7809a7000c58..9f3784f4a5b7c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -663,22 +663,22 @@ static inline unsigned long *ma_gaps(struct maple_node *node,
 }
 
 /*
- * mte_pivot() - Get the pivot at @piv of the maple encoded node.
- * @mn: The maple encoded node.
+ * mas_pivot() - Get the pivot at @piv of the maple encoded node.
+ * @mas: The maple state.
  * @piv: The pivot.
  *
  * Return: the pivot at @piv of @mn.
  */
-static inline unsigned long mte_pivot(const struct maple_enode *mn,
-				 unsigned char piv)
+static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
 {
-	struct maple_node *node = mte_to_node(mn);
-	enum maple_type type = mte_node_type(mn);
+	struct maple_node *node = mas_mn(mas);
+	enum maple_type type = mte_node_type(mas->node);
 
-	if (piv >= mt_pivots[type]) {
-		WARN_ON(1);
+	if (MAS_WARN_ON(mas, piv >= mt_pivots[type])) {
+		mas_set_err(mas, -EIO);
 		return 0;
 	}
+
 	switch (type) {
 	case maple_arange_64:
 		return node->ma64.pivot[piv];
@@ -5399,8 +5399,8 @@ static inline int mas_alloc(struct ma_state *mas, void *entry,
 			return xa_err(mas->node);
 
 		if (!mas->index)
-			return mte_pivot(mas->node, 0);
-		return mte_pivot(mas->node, 1);
+			return mas_pivot(mas, 0);
+		return mas_pivot(mas, 1);
 	}
 
 	/* Must be walking a tree. */
@@ -5417,7 +5417,10 @@ static inline int mas_alloc(struct ma_state *mas, void *entry,
 	 */
 	min = mas->min;
 	if (mas->offset)
-		min = mte_pivot(mas->node, mas->offset - 1) + 1;
+		min = mas_pivot(mas, mas->offset - 1) + 1;
+
+	if (mas_is_err(mas))
+		return xa_err(mas->node);
 
 	if (mas->index < min)
 		mas->index = min;
-- 
2.39.2

