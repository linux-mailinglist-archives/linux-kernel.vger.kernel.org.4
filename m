Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918B863CB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiK2WwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbiK2WvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:51:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44D2711A4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:51:18 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMEBlq020338;
        Tue, 29 Nov 2022 22:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=pFBt8VX6o2UZgtqtp0qKSqJojCjD0tv5Zao/WbVC1Xs=;
 b=wuU7XVHLL/UaHs+sBKQj7hY4L3mCo1hC7zE6ApTPLx7Jpp8D1ZLJ/+ESKM8Wbt4WpFNy
 J8egZH2I3UFNZgNVnCjymV1oU4zZkqIb2aIaHGZn7N5CV4BAlYA0MM45L0H9U1lTrSJN
 0UHnin+P5gRU+BLj5JGU2UD6X6aSWQiF3ceYcVGdROYCIhPaqJWcn5coQB9UBML64KY3
 zA+kQMpmTfwuaXV7rQxbEgL2zl1oTH6fPRkaWGQhrtTZ25D8AF9wOK2jSNv9jE5ReyjW
 n5UcZemxNt18KGEtJ0QV/wMG7c2AolxjfXqwbMvAtQOM89xX+vxbPUXb3bpqVyu6maKI fA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht7m22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATL9k2Q019333;
        Tue, 29 Nov 2022 22:50:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398eax7y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUU4x2mtmGUjc/4mmNN1YX52GDjamaXusDYCBH+UynivFZdev9PuQlb7JG2InxWQ1FeKSFsqTGL3KsF8LVFRVHH5NZ8xebw+7/pVNnbVpYDfNoFWlswS7SNAU5V27W1NStF+P9TJjIH1SDBnQxgTLA542G/vtmS04Gjn5IQ0a46iQzQ4eMCYN3IzZjbHT2qU6x8L4NMQAWLuFU6TMrgEZ8Gfg7M+uKfLg+VoBi5kJWat8+oCXSBc3CGuzoIprb486+BTb5HZUsDKjtlrYtVqDokXYoUABS1iJmXArz+X1CmM6mLJvucbdkBGQ6FsuZ/zRHUDpDSrkkogFN+OtUrQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFBt8VX6o2UZgtqtp0qKSqJojCjD0tv5Zao/WbVC1Xs=;
 b=RMN8IBxfBLNqVeLSXdG6CfCIpIjBd0/sMl/9GtOohx+TiYKEku5jUzF+RLY1notO3iuG1EEkYqTQdBY62IXY97mB5+jWHeU0c/OD3rPfNR6YWsFoOMPtyHtQLy5I6CJzeX+hYLeIMf8Z8EN8Ym/KVGiVXVjh3x0Dc2YgKnd4Fi7tGiL/qrTxVQzz6+yCIEXwgdlk9ADyV/2egQcNcQ/KivSVFJIPAbXXWvjn9MVij4eCirtRtNyh/Ar9f5sC+QvT5cN6Bql+57OZxgIJtfONj32evMp2BG3yPoYjOjpk0ShxaIpGd0K5trRc5zD0t93V3ptRM6eBWYaGE/WqRtgtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFBt8VX6o2UZgtqtp0qKSqJojCjD0tv5Zao/WbVC1Xs=;
 b=YB6v5qE6JKhxDEcxHrZY85+ErjUMHuWzAm7uu5ug1yQyF83fqLIrCF4Tl4xm3v7XtZjCarZ/YGEd8uDcNP3HlY8GzJdfHsc+aNNB19BsyDYQsQilMXqRqJSzFCoWIOajN6FvvwPuf3hcnCOdkjNqvoflSc2rpj6+yjVMg44fdW8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:50:55 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:50:55 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v5 09/10] mm/hugetlb: convert hugetlb prep functions to folios
Date:   Tue, 29 Nov 2022 14:50:38 -0800
Message-Id: <20221129225039.82257-10-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:610:b1::13) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2240a9-8a8d-462c-fed5-08dad25c2cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47H7Lo1fuqQNtpWt8KB+w0mfT7vdYbwbMypp2NufQjCnJwlgICkjAlxxJW3KbIq6IOfNoyJf2hjXLdp1plun3mETbw5fEKMRFqDCE9sq7rLP3ZTYZYPLAgvvtmIAl2UNCXVouKgUOwwftibwFymmVWgDX3FgI8PR4h7TJFEW+eXgHc0VXvCwSLjeTMmLLjjvoBzBaD1nz/reHpwOUBleZCCvG2ZCG87j9hDkgyNtlbIUQFEvMbgr+2x3KuWYQeMeiR1FcWZ4b+toOJjfjUZMXVA0VWZu/w7LcN4QwoGnalihUOpkzD5b7d8bRDIZ+TtqOnH1zHrKG4nj0IvKfTf64ZXjDLVVbNRdl77BPeHQUfwo2ZIlMJXuaoejMRBXShC1GclIWx6gFEAJxLgRcPcTIfQ/qqbCc3b9y3dLsFDwtxGW8hA+3thMMw+/mu95RlQGS9Ob9yuYnnDypPhPu9gFvS0tUktsW+XS+COFCHkXTYfPjA75iyLjcUHU1P0rslAIiA61vYBqsAnm34RIv1FfY+q+THMUYJbGgdqVUlY1EVaMjwjkMMF7H/gERzQgr3ZPSQ6EeTGeOtrcU5PeSa44NrO3xju32VgM7XePztWKLGrS/FwfkjYrgv9TAZyZl9nXm11qMP2GxRRwy7DoVIx5LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(2616005)(6486002)(186003)(41300700001)(1076003)(478600001)(36756003)(6512007)(86362001)(26005)(7416002)(83380400001)(38100700002)(6506007)(8676002)(66556008)(66476007)(4326008)(6666004)(107886003)(44832011)(316002)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eVl0Y/6s3rILMlkNq6kOSZsjbnnKWcz77ZWDuIQYqAGuL+/GEqHJCGuzq7+x?=
 =?us-ascii?Q?dL7G8fSzVuo3T6Ci7oZh9PbvIaI8gg5GKAKms/PSIUX5h1bTSebc/UjZPqrY?=
 =?us-ascii?Q?nCBNPl5CPPmJjA2ZoVNscMatdOpZpmAVNO4rQU2NIuvIhn65gxAvUZpDdhjq?=
 =?us-ascii?Q?rUZ5NrKgYJ9mmSPmSKVaG7nQ5aNYhlOU+Q5sxDH3AFuw8XGgwXb2O/ATXk9F?=
 =?us-ascii?Q?gtTLzss2mRYqHKfM5kb7PProNftYrQE6VmSDmnA+WYBqhJOdS97PZf/KYHkc?=
 =?us-ascii?Q?c03YDozvIOtQPgKJpqfM/ZIyO/qQkiszPCGkkC3m4O3kYBVDNAancexwQaIQ?=
 =?us-ascii?Q?gRH8dwdXSPxPXybi3uVujw3fEMeSUi+Nf0ssL8VryxtzBoZvnALd3ZETX6Za?=
 =?us-ascii?Q?sLgUaSmAVVvWayP4ghmihcDDErLdObv16l6FRB/yke4xJaZ5Qa+QO56jTxeT?=
 =?us-ascii?Q?WS8LqRF1wjyC/pMgftPkpmRxjH5bSp4ux8fIcTedHELHw3SQzEfNuRkl8wxI?=
 =?us-ascii?Q?FT2d33QTfu3YKTnHLN+Dgo5gkgKqSKUWDU8DoQmo9TE8fJXw4aSfxLREnH8P?=
 =?us-ascii?Q?0wtxgn75ETWrIG8B9+abIjXp26dnnhZS1k1u3cSw2quJ2IBm98txOHra6e2J?=
 =?us-ascii?Q?RN80DRc3uWBF9Nn/ijUnYBLvkc/E71qWCCwjJQZtQqbPTP5vBDayfyc0wwRO?=
 =?us-ascii?Q?sXJbR2pkcF7vft8BIwtiYyDK6aLhbJCxMLuHW8mCUqyO2FVyXMZAFpPsOA0y?=
 =?us-ascii?Q?ZJ/QODZHO8UcjjFgYE4fuO1iZ6Puc9wKUdLNTdfpwbs7I75qzVS9xNfrNIfj?=
 =?us-ascii?Q?7eP2DzwCnZ6qC13GlShCDnNn3k5cNL78EHsck9FKWFI8L91vAY4UGi0KlJ9D?=
 =?us-ascii?Q?McXOkTx7RrPXGUEDap6PT9O0fHv9SdJ2aeJFgpjwG1iKi+k9MhJyflsg5oOd?=
 =?us-ascii?Q?EdND9V/oK1HYsxmSPLogbj/CAZXAy+TrryjYJgLLaEnQCDmRFhjNBHSBOWpT?=
 =?us-ascii?Q?YgRSNNaO4UxHvnjHvK/tBwwDd0sQ6rK9vsCrgtAh1cNW4ZEBBADIi9XVXgVr?=
 =?us-ascii?Q?+K8rlBwx0ROjS7kQkFlj7xNQV0jNxDK3VRpWqXXZIzO3zETKONY1pUYpSNCK?=
 =?us-ascii?Q?SL89TCiC9XQrVUH7x+7u9C3xPwjqqY3LU05JXhY4BbrLe6gU/aKQpKaci8SI?=
 =?us-ascii?Q?tqeFV/oC9a4c/Xe2/ExVEY22wPFuWGsPOduKUD5U656Y6z2xQIUTXui2kaWH?=
 =?us-ascii?Q?TkhxJ/bjDqC2Ks5L/lzpRujCklBmzqQYI9hbTbG4U0ew534AGnEm+zhoO8N9?=
 =?us-ascii?Q?JkotX/ADaxb86ayMvXge+svxsIopzwNLCjG6f1Wh5cQNplx1+Zdj/AGVEtjZ?=
 =?us-ascii?Q?HwcbO76DBHv7BuSSLUkIFN7ffF4y/sAOrO78+HdjhoGpFmtVOs3m9KSPG2Sc?=
 =?us-ascii?Q?ehck2RmAs86ubpaYtyiLAJgQQW3y+ynBK1M5ILbh9mQoBqdI9PIEv1Zr665w?=
 =?us-ascii?Q?JXNlTZ5mXru/iZk2ZKfEFiY0REJ23NXyvOXivh1D+bVKSQQYMZgtO16ZtjsW?=
 =?us-ascii?Q?MIDTRyvDpwsGf8SP1wV95UmZBGtCm9T9lXeJCpS9jctNEKBWaHIPf5EqBpBL?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4+7lavjsVlt939rQC6uCv63vmUlXEd3r74uJSnPiD5jEDcdOhSqauS7vX0JE?=
 =?us-ascii?Q?phMQzy0/uT63ihigeCP5lIc4aKk683JHiQ2rrmR6v6EZ91KfCFkWBtM8b5BU?=
 =?us-ascii?Q?1gsNtIIZEtb3GQqSSHa6fbgMtqGr2/ajj2rlDtcfze0di45IaAFHwHPHDpgu?=
 =?us-ascii?Q?uteGC0nnIavNncy0J1GFEPV/XGICxaXsM+ecdZVRkOfOiE0F0WzS6rmw99Vu?=
 =?us-ascii?Q?NQL0MnJ2wkVkYavfabt5fNEGdctsMiwL3xLKNYbAjjp4Uz4LyxsQUQbJKnzz?=
 =?us-ascii?Q?kAcBLeMaUFlcK+JuvWoLPSz1eteGe5GwGlItCVTB3rQEiBAwqWzf8YStX/9L?=
 =?us-ascii?Q?h8vDNhWIfVxnk3Pzrz77969qv2/oFTZtuR6AgyEmpsHMogLycQaiUe4bCE0g?=
 =?us-ascii?Q?z6GbKS7x0ypD7FFuwVKAB8r6klULKlKJwHOqo5lN1+JJzfArKQYyIayFxouL?=
 =?us-ascii?Q?mLFYZwQnOBJu+VCHsm2mgMV+EbCQPNUO5c85mYnCFQfRik6u3Loey5gcviMe?=
 =?us-ascii?Q?NrG73qFk9NiVa+MtxVzHHuyjBrse0FskXwQb6BXS+3YZQp4rLirApgKuYkQa?=
 =?us-ascii?Q?6OWe8+XGbuX+GdAbDLVnlQ+pXD5VJ/mOfIAlBXoIxxXS2nsNn8eveG5eLm+L?=
 =?us-ascii?Q?8cBEaKa+j3ej4odMYH3M/wzeWyHi6m5j+JxJ+WHqhfC2kET/SQwhJRZF5fDY?=
 =?us-ascii?Q?kE/IG949oq+7Af53RJYgDnhIuNBNATm38ltsRQR3o1EJhfCgqGOQni97VZcY?=
 =?us-ascii?Q?R3qJocgySoQhVRbxictR0nm5aFfUtQmozHoAeTPgqCYuhbf/KURSi+xfAENI?=
 =?us-ascii?Q?CjZV+ns7IvrWXvfHFmLve/4ybMHIt2NUvv/ASgDAgaowUs5KyP8IiHqWoNDd?=
 =?us-ascii?Q?LUopQ7/wWkQ80Jfmy6bGVPI2lrTEZL6UMC5TK2UcBL45DQ8I3v7ANpJwSxp7?=
 =?us-ascii?Q?IhcMzZG4vJz6geGRxluCLvyQx0ho6BBva2g+WToTG3AnxcNELnLa7ajIHVTA?=
 =?us-ascii?Q?wh9MgNopV222QjU8NUDYKpt+xh9504lVLMRtLSGvpf606KnUbKGuGDGniwVH?=
 =?us-ascii?Q?v6tcpfWZI5eQmCuUvJyVaW5JQUez+uVd0Q+ivRv6HCaGJhe4Fe4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2240a9-8a8d-462c-fed5-08dad25c2cd7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:50:55.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIUHTmcF5aJwYibkvhqX27rRYWxoSH7Dpk9KPC1j8ilSqqzKQPSvISenqi1ox9d+W5vxdZ1PtSS4AiBsOSIe6wRaqgOtCBKie1QikT4XfEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290137
X-Proofpoint-GUID: KKwCzWtllePi_eY3CNfopvafwq8qpcKh
X-Proofpoint-ORIG-GUID: KKwCzWtllePi_eY3CNfopvafwq8qpcKh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert prep_new_huge_page() and __prep_compound_gigantic_page() to
folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 63 +++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5e580ab834c3..f61b4eb58cde 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1789,29 +1789,27 @@ static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 	set_hugetlb_cgroup_rsvd(folio, NULL);
 }
 
-static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
+static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int nid)
 {
-	struct folio *folio = page_folio(page);
-
 	__prep_new_hugetlb_folio(h, folio);
 	spin_lock_irq(&hugetlb_lock);
 	__prep_account_new_huge_page(h, nid);
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
-								bool demote)
+static bool __prep_compound_gigantic_folio(struct folio *folio,
+					unsigned int order, bool demote)
 {
 	int i, j;
 	int nr_pages = 1 << order;
 	struct page *p;
 
-	/* we rely on prep_new_huge_page to set the destructor */
-	set_compound_order(page, order);
-	__ClearPageReserved(page);
-	__SetPageHead(page);
+	/* we rely on prep_new_hugetlb_folio to set the destructor */
+	folio_set_compound_order(folio, order);
+	__folio_clear_reserved(folio);
+	__folio_set_head(folio);
 	for (i = 0; i < nr_pages; i++) {
-		p = nth_page(page, i);
+		p = folio_page(folio, i);
 
 		/*
 		 * For gigantic hugepages allocated through bootmem at
@@ -1853,43 +1851,41 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 			VM_BUG_ON_PAGE(page_count(p), p);
 		}
 		if (i != 0)
-			set_compound_head(p, page);
+			set_compound_head(p, &folio->page);
 	}
-	atomic_set(compound_mapcount_ptr(page), -1);
-	atomic_set(subpages_mapcount_ptr(page), 0);
-	atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(folio_mapcount_ptr(folio), -1);
+	atomic_set(folio_subpages_mapcount_ptr(folio), 0);
+	atomic_set(folio_pincount_ptr(folio), 0);
 	return true;
 
 out_error:
 	/* undo page modifications made above */
 	for (j = 0; j < i; j++) {
-		p = nth_page(page, j);
+		p = folio_page(folio, j);
 		if (j != 0)
 			clear_compound_head(p);
 		set_page_refcounted(p);
 	}
 	/* need to clear PG_reserved on remaining tail pages  */
 	for (; j < nr_pages; j++) {
-		p = nth_page(page, j);
+		p = folio_page(folio, j);
 		__ClearPageReserved(p);
 	}
-	set_compound_order(page, 0);
-#ifdef CONFIG_64BIT
-	page[1].compound_nr = 0;
-#endif
-	__ClearPageHead(page);
+	folio_set_compound_order(folio, 0);
+	__folio_clear_head(folio);
 	return false;
 }
 
-static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+static bool prep_compound_gigantic_folio(struct folio *folio,
+							unsigned int order)
 {
-	return __prep_compound_gigantic_page(page, order, false);
+	return __prep_compound_gigantic_folio(folio, order, false);
 }
 
-static bool prep_compound_gigantic_page_for_demote(struct page *page,
+static bool prep_compound_gigantic_folio_for_demote(struct folio *folio,
 							unsigned int order)
 {
-	return __prep_compound_gigantic_page(page, order, true);
+	return __prep_compound_gigantic_folio(folio, order, true);
 }
 
 /*
@@ -2041,7 +2037,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 		return NULL;
 	folio = page_folio(page);
 	if (hstate_is_gigantic(h)) {
-		if (!prep_compound_gigantic_page(page, huge_page_order(h))) {
+		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
 			 * Rare failure to convert pages to compound page.
 			 * Free pages and try again - ONCE!
@@ -2054,7 +2050,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 			return NULL;
 		}
 	}
-	prep_new_huge_page(h, page, page_to_nid(page));
+	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
 	return page;
 }
@@ -3058,10 +3054,10 @@ static void __init gather_bootmem_prealloc(void)
 		struct hstate *h = m->hstate;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
-		WARN_ON(page_count(page) != 1);
-		if (prep_compound_gigantic_page(page, huge_page_order(h))) {
-			WARN_ON(PageReserved(page));
-			prep_new_huge_page(h, page, page_to_nid(page));
+		WARN_ON(folio_ref_count(folio) != 1);
+		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
+			WARN_ON(folio_test_reserved(folio));
+			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 			free_huge_page(page); /* add to the hugepage allocator */
 		} else {
 			/* VERY unlikely inflated ref count on a tail page */
@@ -3480,13 +3476,14 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	for (i = 0; i < pages_per_huge_page(h);
 				i += pages_per_huge_page(target_hstate)) {
 		subpage = nth_page(page, i);
+		folio = page_folio(subpage);
 		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_page_for_demote(subpage,
+			prep_compound_gigantic_folio_for_demote(folio,
 							target_hstate->order);
 		else
 			prep_compound_page(subpage, target_hstate->order);
 		set_page_private(subpage, 0);
-		prep_new_huge_page(target_hstate, subpage, nid);
+		prep_new_hugetlb_folio(target_hstate, folio, nid);
 		free_huge_page(subpage);
 	}
 	mutex_unlock(&target_hstate->resize_lock);
-- 
2.38.1

