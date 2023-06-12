Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F24B72D0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjFLUkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjFLUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8897719AB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNtS2031433;
        Mon, 12 Jun 2023 20:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hNNPNCDvHhDl4WRLh9/7Z8qWAAWKO6ttK4dq+KZRwuk=;
 b=25FVTHF01gH8hjwRuYG87MO46BLLpBKYxc51DG3Ftx2qPPIrpe311Z80TlvkyHFq/9sI
 /W+87pON0u4FM19l3vA204aMjC1Qnvp/graQo7T2rQgMAtJmJ5nG1QgxXS3AGCEVMyGI
 Y1JhBeE2ZQ0uu/DOuzwqma5lOJUiUkDq6JFYVmxJ1+Pnh4jb6RW4190jcy6vM3dSUsHD
 Rw7nZER9xAD3lQqi93bsn00CG1V3MDZI2BUj7kT8X8pqUaxvGp2SKqQtU5IvU2L8BA1d
 hy2pDPV6L4eHBDne52tvGU0IAXKcCfcdg9tMxru8PZDoFOqnnsBwLK8qRDcePLgab9Hm DQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstusxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKTjNK014117;
        Mon, 12 Jun 2023 20:40:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm314tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7ageyaz0Ytokt1HEDIUzAA0w9oXl3sadA1PAbGpliOIuLQ/6L+REioMdcPBcEC+ysN3crr8mBhABSa0l44EurUocl7O9vva4EoJnPZqPehXDqrmIfUftmBHjtPkhIeJuInsZ23dThiqfj7bpoCBth0veZEEVCbZ2Z1uasKV7IoxYGwGjSDymbR49w6K8HyPwvDRdk8+64u3T3Js63g0SJuJ3gJxRDFtoO+wbbLl++RPw7GGEw0gYP4xAgfYOV76MUakHaIiHUIgzRZiCa3GiuWrB8moFBYS5lOpex7Vwlh+XgjsY5XtEwSFbaIWCzlDxLeMIarg6gOh9HBBgUyaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNNPNCDvHhDl4WRLh9/7Z8qWAAWKO6ttK4dq+KZRwuk=;
 b=nypFSZYdulMFUU24fNQuzHBdpd+nFpxcYd3ySt9ZJXKDMN1faDcR4o8gPqc10styBDcr4dbGPVnaWLMwS0M0sZ0eTB/K23MvXANxEz4PBeiRCdRfgXid6kYcfIDYAWM4qhjhorY1gaqA4vMMSbhZyithWzSIgDBdNFBVOS3s5CpbaGJ4EcYYitQwBr+5f82deN9309CHluj1FBJHUQop1MjY8xDvWK0j9S/oB7gZs7Vt21B0Ag/oKfS8eiaIAvuQMDy2rLF1Uktj2R0Edn8awxcYLbfDweh4VoZxHb2BYj0xrDmhmm+3Tjrzsfw6cSH5P5wJ/fLGbLho2D/8MaZBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNNPNCDvHhDl4WRLh9/7Z8qWAAWKO6ttK4dq+KZRwuk=;
 b=SgYB3fXOZc+84bcCfcmJKF+qMOfEFcE8zCzoZCyNCt6yaqNTdCm3ayCTEFTyNqDA3JkwWbKWPbsvrGWplmoc8YdSXUzDCVzzHVNq1CDXbZsN4zEtzHHyu7liMr1qXPRWQ7oUoKutZdBybJeOjVVVtMdjEE95MY4TJ16nHoqROCw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:40:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:01 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 01/16] maple_tree: Add benchmarking for mas_for_each
Date:   Mon, 12 Jun 2023 16:39:38 -0400
Message-Id: <20230612203953.2093911-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA0PR10MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbe0029-e4e2-47eb-a0b5-08db6b8531e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fW9jK6+JCCE9qJGYTivQXROCeKeQtflnBCE8lvNLpr9XW3BrnIPVbSvOnCZatVu4fcHJevKYiu4jbE5omLmog+DQCk2RzfoZ0l0UwPFdj6JFRFtqfAvS/A69lbZZu611J/0AN246s9/jOUY5jS9st20jeKdL23zUVlmllmAU2l4NyJCfR8CR+yG5gTnefCpSIhoRT5DdlEQ4ju+wDYnY/5GWJmUB/7BDgvsFviONT93TGToChs3JGp+0JSAqJTsqkqIEQY21IHcdQw77i2eGC2QvOVBV/0kytfJIgSYaHV02Gzb8gxaYcD6w4E34loCaW+rXXNQFJaEj6GYz+2tEarNc82pS92lpTFkA8ru3Q4FoKPdWQNAmrISfRF2BytD1z3PLOkLxCKlyjJBENgkyeM2uy3iAhtLLNHjlU8eNoqEq03S243xbtrqnv40wzBtayWk5YWuF+ZyS5YiJAhU333VsXdmlCUQ7LRpW2heyQGCtk7Xb9KYVDs8V/K+JgYpffKlGlXPFH0e/I5DVUT+8raxKiK1S64DbiWMEsqMTcqtBHUtmgrVVkQXfGAbx3d1Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(6916009)(83380400001)(478600001)(8936002)(8676002)(316002)(66476007)(66946007)(41300700001)(86362001)(4326008)(5660300002)(38100700002)(66556008)(36756003)(6666004)(6486002)(2906002)(54906003)(6512007)(107886003)(186003)(26005)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PK24/H/bH4sp6g0lnYi8T04v+p9CYODDF4XNdnG2XAzUhWrQnaRXfEvbWvvw?=
 =?us-ascii?Q?Vvx7E0bkH9J3rCqb0C7exbW9DD2EMygv3HjppwM1y34FAeBMioMVl9wkjM0s?=
 =?us-ascii?Q?CAkaNx9wrNxlyqcPddgqrZs5d8Oo3ma13RB5KFCkGYaeWn/YcAzQhbpY3NrQ?=
 =?us-ascii?Q?fYaYwVqJAI4jcCXHgQhg5AhYKeNDbeDIHA86rGcmzY6Oi1yMTJogGqGxQlIj?=
 =?us-ascii?Q?jbVMVYqe1QZWctJfVJvXqfSlakSSjOj2kRK8kUXtbpH0VT6B42QpvOOv0Fbw?=
 =?us-ascii?Q?Zt0Smb+L3KBh7FBU8/zl4vfGB6t3HGDXgslKqZNQHx+XMZQbyx/sPYeerIj5?=
 =?us-ascii?Q?jKUzkwCbmd5S5YpoKyUpKxDkjFOxVX9elc8Le+crGzHLIa0fEEcJraOMeIed?=
 =?us-ascii?Q?G6OVvL836HzCiw9l+v56R61uR98F2TJ2rhZSyeExcuz36NBPTysVS5ncLw+Q?=
 =?us-ascii?Q?zgsF2PhxRNrwLt74WjFk7HXwUomJXOPyl2M1iXMad7ellvSlQxuJBMRvujyZ?=
 =?us-ascii?Q?aiY3w37GMVMcCbLkhIhTxmfFng8NAueIQmP/3MzF4lVnzuLRN6EVxj7HSdh9?=
 =?us-ascii?Q?wpwnzlkdMLTGvW2E3gwc32S7JVTP/2IjWcmcZPBbqjSNrX3XkU1a6v/WB/jo?=
 =?us-ascii?Q?/T3gagjrltwIY+XFKXipmhSyQYpycDQ+uwyjw7Xnlw2CF5WGD/z7RY8yt2WT?=
 =?us-ascii?Q?v4b6SoiWgGyzBnlObSywy2X6x+yMWZAxjj5mELlrIUzNj1KAwXXuEVs/h1b6?=
 =?us-ascii?Q?Y0xSx04CcU6wx0eCD2hJVOwioysaffGzMDdQ3fZJMDGZXDNrCmLrdGmzZG7h?=
 =?us-ascii?Q?WzdFJvUY9q6FCmEH0MjhzGCrMinwhdwT8XJ72482qioe15oWkW4lwTmSXV6Z?=
 =?us-ascii?Q?yVg/xb2d2oLwpmXf9CWqJllmsm0SE2pMhYJ3ZUJbbxo0fvhH3jxDzsFD5JX7?=
 =?us-ascii?Q?lTKy4xOmYumQwclzIYo5tsJxc9QJAMEBAOOyvirT0D/yW58pLyNUQ6nSuyCJ?=
 =?us-ascii?Q?C1nzMaJNdY2ZyBelzhJiB8RJoi8AtNm4qu2SKp8TuGSA6kPUvBoYncUall3q?=
 =?us-ascii?Q?CjA9g8BjMxvJUozcwt+uos7wm2JPvzjo2Jfg4wFRO51xJ0Xh399O0BDrKcku?=
 =?us-ascii?Q?XIrOL1qxDoJo1hPbygQRuTC3nV9xdFyCqUp9DgT/s+vNjPzS7A9jk2Q7RIqq?=
 =?us-ascii?Q?SFoYn0vZjxMEOtMY2Wt1BlLkcBuaNj8Jbls2QAb0z/7o90qxYalsmrqU7PF+?=
 =?us-ascii?Q?hrgAkYeGlcHTvuVhbI1Yzv8WcB2PIy5bAZySkloq1eBE1fYgZKco7jTB+hbo?=
 =?us-ascii?Q?vlZBde7tWs4gPVDmD4UXAG50UCRVt+6i8COdnmPNIOVVW8rjXUZrVbrjplm2?=
 =?us-ascii?Q?Ls88qbEj8lIHhRZCm1wqjEhjT8QrNZQcKYUq8dklBh/Hbdb2qTorBYWICB7N?=
 =?us-ascii?Q?pwe0Tnt+ronR3hqkT8rABLxU3fyBaH0ei2ZkCKZeHU9E6vwJoNC8EdQLUVNB?=
 =?us-ascii?Q?C3FweTTgwSC6GdTdDKl7neA0C5ouPMe9KiA7SX9/kT0Ph4LTjOK79x7Mfvwl?=
 =?us-ascii?Q?mbetrUOY4cgbIPeoZ6DBNqSA+nM74oZqElWWFapJ6BRHjlKkifiyEmrtYAH8?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?K3jREBT0wMYXRrQH6DzUPIZJu1ACqaHkoRAYjmoEpR4GFkUGek/bcbVdF4q+?=
 =?us-ascii?Q?g1sbVpnBm5wa9v7MZVG6cKkZlYg+Ok6fjhG+bzqpXQnEcV0VRlsYuj0KtPQy?=
 =?us-ascii?Q?I0/io8/s37dBtbValX/4BSz40Il+hFOKGjgsun7PbQF1o2OjHimndmMZ7sCS?=
 =?us-ascii?Q?O1p2ytBAevDdAi8TzF0Bd2enu4SzmlrlUPalTjm+lSgSD3Nhd4+1S48acIVQ?=
 =?us-ascii?Q?3faAqLxzesVpP87UX729jPVAZPbbfGSzUk6MwCnJpnOFtEhBvQN8fQLDZdpX?=
 =?us-ascii?Q?ObFvOLSkbKZQPBwSp0sADYSvVZKh6Wly0qY9zjxfSj9cl7s2Sb08AHW1OtpA?=
 =?us-ascii?Q?WrxMAha1pHfF63gCVtrnHHY9B/h4B83Opl5e0e/DMFPInEr/+mtLVWhlZ3BK?=
 =?us-ascii?Q?pQM/K/95Gx+VLdVL5gTmF31PPjUBcabEHAEJQslXJ049nFiUvkTxCe9/8aSP?=
 =?us-ascii?Q?qxM6lMHVHvvQGCXm+x10E4yiADUCrkIfAlvYVDoIXj6eu3GpO6j3RvKLtarn?=
 =?us-ascii?Q?FykcUGxZSLN1tjj2BOdpDDctjMwN1pFleEVndZmUZaKYdumBcvGMfXWpUwbo?=
 =?us-ascii?Q?9yGdnRUIQ7qPwK2/EjG7WMZpQhTDQOwywTmTa8uUBffo5s6LmDaNYRNw1Q7x?=
 =?us-ascii?Q?sUWbeKBF9M/8feeWPr3WmRdz1I9/++y9eMdhr9+u1dMi2YiX4c+9v9pbU3sI?=
 =?us-ascii?Q?yxzmOM80gzcDl41Sd3cD8sVGML5bIemJtT7lBgTQ/9VTtVplqUf53ajbf+pz?=
 =?us-ascii?Q?N31dEvtO1jbU85TeY9U3e1nKRouH6ztHaYivY9uAOpiLcKeuntJSWd0TxoPj?=
 =?us-ascii?Q?/2bm6GgRgIpp8lWQQ9DhJCAvxqmtBQGRln0Vf6NDIk9BoiBCuMWC7+E8qkS1?=
 =?us-ascii?Q?nJb20RdCqNoWY/MGMDwTy4vIPP7HoJj9DG0rZbfr50u5sHKIihxYDvbdpjS/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbe0029-e4e2-47eb-a0b5-08db6b8531e4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:01.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcgMFxXNmcwNsU0/9zCTs/vzfM2zVBGf5qnHZO2izEGjlxBUnrt5TxjlRA88+ggyMKf5wnEUQOFxIc5f9g5Stw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_15,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120176
X-Proofpoint-GUID: bfNJLouZY3-BwEbTzzdisdQZgRFu3f59
X-Proofpoint-ORIG-GUID: bfNJLouZY3-BwEbTzzdisdQZgRFu3f59
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a way to test the speed of mas_for_each() to the testing code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 9939be34e516..3dbf99c3f2b1 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -44,6 +44,7 @@ atomic_t maple_tree_tests_passed;
 /* #define BENCH_WALK */
 /* #define BENCH_MT_FOR_EACH */
 /* #define BENCH_FORK */
+/* #define BENCH_MAS_FOR_EACH */
 
 #ifdef __KERNEL__
 #define mt_set_non_kernel(x)		do {} while (0)
@@ -1705,6 +1706,36 @@ static noinline void __init bench_mt_for_each(struct maple_tree *mt)
 }
 #endif
 
+#if defined(BENCH_MAS_FOR_EACH)
+static noinline void __init bench_mas_for_each(struct maple_tree *mt)
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
+
+	rcu_read_lock();
+	for (i = 0; i < count; i++) {
+		unsigned long j = 0;
+
+		mas_for_each(&mas, entry, max) {
+			MT_BUG_ON(mt, entry != xa_mk_value(j));
+			j += 5;
+		}
+		mas_set(&mas, 0);
+	}
+	rcu_read_unlock();
+
+}
+#endif
+
 /* check_forking - simulate the kernel forking sequence with the tree. */
 static noinline void __init check_forking(struct maple_tree *mt)
 {
@@ -3430,6 +3461,13 @@ static int __init maple_tree_seed(void)
 	mtree_destroy(&tree);
 	goto skip;
 #endif
+#if defined(BENCH_MAS_FOR_EACH)
+#define BENCH
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	bench_mas_for_each(&tree);
+	mtree_destroy(&tree);
+	goto skip;
+#endif
 
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_iteration(&tree);
-- 
2.39.2

