Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3EC67B7DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjAYRGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbjAYRGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:06:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA4F59748
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:06:26 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFNnjV019596;
        Wed, 25 Jan 2023 17:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=yI79RGV+JS852MP4/0cLY/XB9AbILbilppgbzvJIoaQ=;
 b=jKNrmtvhKI9pKSkYgsTxuCi0xNesODe9k/r5RxlwbYpjnSg6gFkv5IvvIKdgccKN/2NO
 xiAWGkghNrpuw6ZS021KRlhdzMRzzxfOO19kLQ4bbWbmxGi4Zjd5Bks2RsrXgtUgxxs9
 RwS2Fhcn7YzJ3BNQvpd9DtVwba5erh+z7hFf2EsVRg7dzb3c+gXYph3EWAlrGH6R5tD4
 PkxOB/xsWTEMJ5WZDRoYNsaD2mayhdLWsOvr+IXNnRjIhQgaP9PCRV2cTkpiEHiVnfTa
 Z+DKoy3U9YymrBsQ+ksWWXgve6UkldRWEXAYQGJTpBC5L9ySojct381wB/TNEDojS3fV yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87nt8h0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:06:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PGIZOT034260;
        Wed, 25 Jan 2023 17:06:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g6tt0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:06:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5MNpyII+s/ltFr/s1HrgfmZJfmFFdkx2sDc+9a7LFlTnQDmM2JHWTb7gyseSyiN5xS+88sThKfFq069vkbYQzvlOoJFlqzl1wpe0cOUjvlJW47vQkgrsLM6SSDwTJdac9Md0lDgB7/gCpmOkAwIBMzzvLQmUbdMl3jA/VX8pIfLM7o7rBFvUF9n1IrL5lVydoDnQVbvPZZqQfriwmYAXDYsMzx1SZGo7BpkA5QibCHL72K0tJ+lBV2yVWWDYE3Z/q0CMTquB84mCEWE1vIak/IRWlrTg+ZIDFs8sEBuOPiDFMenHCPV5q5ROgxCsJ5Z9Tz1wxeeB8Bf1/sDez8rZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI79RGV+JS852MP4/0cLY/XB9AbILbilppgbzvJIoaQ=;
 b=NnkPzP3wCrWDPHKji0X39vgjJ5iP2rsuz94o+UlWgNK8RfOQrraCjcz3Dn//Vr2gL6FpuElnKfisuCZCm4RWtWoLr3FDl8+SvrZMsUdL1tjIHjTaVqJVRlJzVSD1VGGYreBlkDe18D3TcwJp5rISzeIidAnbglQeETyoJ3sNRhoTOWk+FqDlQdM/pACX70pySPZ1xTg1Wni/nFJ3EcTY8N/ZD9R3ZkAL0e0DQmlZ+++GlkmwZkAaCxcib0uOtY4VEpohUcJXFAiXqi/kMxj35RJ15daLHKfnVoDn51p7hVNHfV2+ZGvRbD3fxLfx1NVZOro8nnmVhs7SgH4mRYAi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI79RGV+JS852MP4/0cLY/XB9AbILbilppgbzvJIoaQ=;
 b=MPejZRHMcHGsFAgFuv1iDzz6j4Y2hssnv8GuF3DR+Zr3Zl+okokegFy2DKp469VeITyeH7Q8+ZxdlYyhCpCcCpsWhaFLaBxuLmww2+niTgZTlJuV5e3+xTmyoktMs4moCnYYJ77V+oesyHIx/uDdaE0OuaHBCqCZhLh1hz0yBrY=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 17:06:03 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 17:06:03 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        gerald.schaefer@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 6/8] mm/hugetlb: convert hugetlb_add_to_page_cache to take in a folio
Date:   Wed, 25 Jan 2023 09:05:35 -0800
Message-Id: <20230125170537.96973-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
References: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4fcd86-f47e-4e5c-db2c-08dafef67071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IswZdBojMPHUO85Amz2DGUexXSkBxWHzKoiQ8k7hUucsfb4YNXeed48L9tczlFOpyRBL6h5TH4LmAA0VGJJoaBhCYo6XnV80GPDOreAckmaThj8XsRGSU2RdUykQQ+WwO+LJOyqcI97ErMIQPKYpwOSr8aGGPQ8a1DGKcm0ZfkG731beU1HsWfMdgCSPBrhBgmW6UpUlCB4outZxUpLcTGQ4jDk13rZeLf3YH/U5JdAbHUEavqKRtofv9dLGG7/ch2Y7xHTz0rGkkPyvBl1EpN2M5ou9RFX6cM85TQJlECEqv0MoU9aMP7Ogsxa+cU3I5HMmAbVll+pEcmxWyrg6VwFSQkMO5thu5J1w2i6kD20iSDoTwFwFZYL7tk8Tv9O3tPq8Eii+LJjd5JWE+QhWHGb8B3y0VlZizhbDh5yGZ++5+LsZXUd50jwjQ+RrV4OOYZqYseiQtAmiK5/B6AIiT5WBI89jAZPQHo5kB4Fktjvn0prGO/TR15h0ZyQ51cNuyKGM1pHdfQ16rnVy/NaUEIL66ZmWNA5zJemNHoC1u0YaIpKmIaZRgIyXAKQ6AEhSomYl5sRBKY/8voWUkk0kQVqNp8ovlP57ersH+PCnSrh947QEoUZzBkvBw8sqR9yFXYE2yqNGazk/KEjIopYaUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(186003)(26005)(6512007)(38100700002)(66946007)(66476007)(66556008)(8676002)(83380400001)(4326008)(8936002)(41300700001)(2906002)(44832011)(107886003)(6486002)(478600001)(5660300002)(6666004)(2616005)(1076003)(6506007)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B2PoJU9SE3Qr1u4O3T0zCWsoThdBIpG8x2cXsHNa5tE0btTyiYYU6YFx4uuG?=
 =?us-ascii?Q?hdseCNc1teInjq2IL6dG6gK/kadvDQuKxLsNEL1hwHIRCvJyEvxaeJLgaMS6?=
 =?us-ascii?Q?ROe1OyhQah55EHqls8AdVTNo1JgWSwnbKILPvRMlaLKVANmlb27q6rghe+WB?=
 =?us-ascii?Q?KO+9MIk58EPLe+p5pD6Bo7pCMlRkl5Trb4t/q6F0g4HSeqKXkwBCvABxyeL6?=
 =?us-ascii?Q?/T1MdOpfwmyodf6UJpf9wLy/4amCaw7673yyHxd8DTixrBSvDkk+95T8ot6K?=
 =?us-ascii?Q?/5Vsli2I7KTr+vS5cavqc1ghoYDEJ+wv/PTo+vuVrt+0qNwzXlNRutGj2nMu?=
 =?us-ascii?Q?yzizafS14l9uRARo36a/lJilKLeNRu+H9LmYZyyVggErto5Clxvesj4uf/Dd?=
 =?us-ascii?Q?f9Un1Nmpc/I3It3QjSeh3DEcWVbmRWFz6+DhGfvPduQQmqjkBhj/GNrWBv67?=
 =?us-ascii?Q?U81OCoz5cj/GtJSjvX13dZWZAVD/k7uU5YXMQEAdmb/rcyRhY/J3GrCezcPD?=
 =?us-ascii?Q?U3Dk5S2KgY9M1jUevzAhpcsYOnc/aTykjA0ol34Anux5BQOt1G/KnVuASUH4?=
 =?us-ascii?Q?D9ExJnXn6aVNbNbQErPcN9vIvEfKsbFBTV5m1nR4psJhLQJgR6qzAd0pbJOy?=
 =?us-ascii?Q?zr7T1iKzJYtlsW//GiXwWt93fP/y27e2yMLZCEMTD2n/yxnjGyjgcoMdQlnH?=
 =?us-ascii?Q?nrxEmQ8IYBQKX2oF9SQsYBmKIQhWZ+g883d1e9JgKED0XbK9u2IJWnVBvtiR?=
 =?us-ascii?Q?W2V6WBykOhXFEu6aNinVZWG057QqUWwgoXc18r8JSotarJY+H6Ha50cwHnsG?=
 =?us-ascii?Q?YPenzoPtb1ARSecNPagcMocpHLnALxQVwquphzOJmPedgEk0cNO8/z6Cji1Y?=
 =?us-ascii?Q?ypjP5jWiyMPJS9HmtcZyahNnkep5wYqFIQJMgptxV7v4/bPWGnnlAVg8Cj12?=
 =?us-ascii?Q?nfz2jdbiiBqZBvsOQDrlnruVcqnLpeeeJQ2Ses0P32UBMH3HlOxFJun3ub/p?=
 =?us-ascii?Q?qmMjY9N9gUDsJTu+25hG4+ayOYSAhN2iXXxfIboJhOqhWkbTN/vfN4tVS4nb?=
 =?us-ascii?Q?2C/ifQXpFpViNYYs9OYLnNhzCyiuMbyxopO1ptQRE+RefREIgVFMQK1vHvth?=
 =?us-ascii?Q?42/0xot68LZK/O/U9p+cA65S4uJlkDeQ45DoL3NXc5/21yyOujY6o+UfHIKm?=
 =?us-ascii?Q?CulJ5Styl6T0ldxKlKaPb/0SOlb184kPsd/HQKyMbuHyPo0qbcd8xA9cEAyy?=
 =?us-ascii?Q?K5p0yk1n3VcV0qjwHjquIwZYqV5G/B27A7JnNpRKG4LptRtj++spDjjOv1jN?=
 =?us-ascii?Q?QYRd05Uwq6iZ+tbaw6xnh9zKqHD7PZaLMAD7fV5jIFgTnlK+amknwqaWJLOF?=
 =?us-ascii?Q?ROLUCgqYwZkURqlqa/HRsKkMPzh0SwvOV6/XmQsQ5MBg+HcUTyvOkEoZITCo?=
 =?us-ascii?Q?8s6x8+HUlxQEgifhtwaHWs/QVyxgxXtaCArlDAwfNrwWwlY8MhDJ8ntOiZDo?=
 =?us-ascii?Q?iO2FBHN5cggHjdjvJXHNuAWroU1X2MXanAC1fTHs9Z2GpwFUMiBTDSgF2coA?=
 =?us-ascii?Q?iGNNVKDLbdpNFdaCm++5kIUAtFKWwr4qIg4YzPXyPbcnVNW/4yfYVf9gmf5y?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GVDgLNMmhGIUeehVWZD36mn4VHHHuKGeRmAX5Wce9WxHe78lvTUDEQVSfdxu?=
 =?us-ascii?Q?7jhfuNaRk0J4PJQP55IcxyyIVLZDdLR/0ZWnGdkw/JBFUR3+SzBwV252nWe6?=
 =?us-ascii?Q?swYVLSLnYIo6ocJKrQqHM1WPkkTSiKrHufU1ZVxstszz6fETpmHcVgZzHxrj?=
 =?us-ascii?Q?nFRhnoiuXLE0uGO0kS5TCzAqCvNdFx7SxUXwShPV1E1Qb21IxPfK/yuUufNX?=
 =?us-ascii?Q?6GFAjEBWqtKw0PfHKa1BXoImgS4MgzN6EF9Q/Hquoqe7jdgBfBg+McgDJ6pG?=
 =?us-ascii?Q?q+urzowEPYxGwYj6LBMgTi8UZmtvO4xBu/D5Zq7zxaLMBdUHz1oFtb5YXGQt?=
 =?us-ascii?Q?JakNAHgoW6oKdTDPmABZmDFc7zVDYu93RoMWRkped5q3rcThT+Xi5Bogoxz0?=
 =?us-ascii?Q?4LiIXvXD/8VwzM2D2DTUgunnGOAJ5E71GijET3EffvlkILtjz6m1GuvAUuz6?=
 =?us-ascii?Q?GEuToJ9E8XFcE/s8E76KwALomwR5XvCLUfTGRtAK9IKOczjOjx1HnN3SeGuM?=
 =?us-ascii?Q?suw2HbBAulQriDAoOVpqO+aX6JcdeL+FAU7VXc5vkC6h5sR2AEE3dYq5ZoDY?=
 =?us-ascii?Q?p1JsiNcYz34/MHQJkv25VW07Eluac7j1AFRaXvt44AhLoKSymbmYXAYeSLvQ?=
 =?us-ascii?Q?89fl3WbnEw5XxuP85ScYitlWTFfcm4yyfS9DCLITW4KNTXrc9/QcWd07e2Zo?=
 =?us-ascii?Q?oCjbpe0mShBVqOl9QOaoQpmekz9+bZojWzp9uQ8UVS+plkyF3CMiLz0/4c6l?=
 =?us-ascii?Q?HEhZ9HeVK4CF3dCpyLYWZfzYIbCU8gCMyCPb4GPGUWLfMFSY4Jb5iUsdRNCe?=
 =?us-ascii?Q?ao0SL6hcWvqWXnn6ufWHfgd94h0FbJdda7kUfsjIR67UyziDW6pvMtMVS7EB?=
 =?us-ascii?Q?A2Lrcm5LotQgiC5zFN/besDqwXbMNMhKqsUbD2Subkzo/4itJMInJrOodKVg?=
 =?us-ascii?Q?Ppj5FJbleGxcnjEC5/KKtgHCSV/Zb0gPaAn+Ant48ZA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4fcd86-f47e-4e5c-db2c-08dafef67071
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:06:03.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aE56grQRDHRXpa6Xwrl5wO5nzw3F5cx1AbVCx5p7LvRXX0fC40tpDhiNrNyU4oU4AWGuuZplhZudFvOnxuUu5d/tI98kQScCErdOv1KMdDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250152
X-Proofpoint-ORIG-GUID: KWx5RzlD4IJLLaHM_g8T15HAtQArYb4I
X-Proofpoint-GUID: KWx5RzlD4IJLLaHM_g8T15HAtQArYb4I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every caller of hugetlb_add_to_page_cache() is now passing in
&folio->page, change the function to take in a folio directly
and clean up the call sites.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    | 2 +-
 include/linux/hugetlb.h | 2 +-
 mm/hugetlb.c            | 9 ++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e2b8a00696bd..43af1753de5f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -871,7 +871,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		}
 		clear_huge_page(&folio->page, addr, pages_per_huge_page(h));
 		__folio_mark_uptodate(folio);
-		error = hugetlb_add_to_page_cache(&folio->page, mapping, index);
+		error = hugetlb_add_to_page_cache(folio, mapping, index);
 		if (unlikely(error)) {
 			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
 			folio_put(folio);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d46f9db09a2c..67cf712c97be 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -722,7 +722,7 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct folio *folio);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index aad028706fbc..ab30f8550631 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5662,10 +5662,9 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 	return present;
 }
 
-int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			   pgoff_t idx)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	struct hstate *h = hstate_inode(inode);
 	int err;
@@ -5677,7 +5676,7 @@ int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 		__folio_clear_locked(folio);
 		return err;
 	}
-	ClearHPageRestoreReserve(page);
+	folio_clear_hugetlb_restore_reserve(folio);
 
 	/*
 	 * mark folio dirty so that it will not be removed from cache/file
@@ -5836,7 +5835,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		new_folio = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = hugetlb_add_to_page_cache(&folio->page, mapping, idx);
+			int err = hugetlb_add_to_page_cache(folio, mapping, idx);
 			if (err) {
 				/*
 				 * err can't be -EEXIST which implies someone
@@ -6269,7 +6268,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		 * hugetlb_fault_mutex_table that here must be hold by
 		 * the caller.
 		 */
-		ret = hugetlb_add_to_page_cache(&folio->page, mapping, idx);
+		ret = hugetlb_add_to_page_cache(folio, mapping, idx);
 		if (ret)
 			goto out_release_nounlock;
 		folio_in_pagecache = true;
-- 
2.39.1

