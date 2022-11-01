Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBAB6154FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKAWbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKAWbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:31:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C141DFB7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:31:42 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M47HM028746;
        Tue, 1 Nov 2022 22:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=J8Y2Ey1M18G7oaDVu2SAR48OoMG4Yc24leIq2Z/FI0g=;
 b=sdp85oOF6PlXA/gStkdt6TxNfZz4SXAe0kQ/HZ1ya6I3PeAC1iBUEN5pEYOvb+q6hTpH
 klzwNFtVULXAW4Uu2SvCHdyaeQH16A2iK8ikSbfwq+TJAz1VTjH71GDXbW/rXsVzvg9u
 QoMi4GpAcZms9htjhZYfc+L9jRN/b1HWY69A9FUturky0XMa1d8nBH8Z3MQlYxlhvzBZ
 BYrjVKinwiz2ZnRwBPxgo9tfTHBKZhXRdhNlyxptbFXGFKabmgu6JUsAIreywUfjdM9+
 +eND+ayq3ySF6s91gE5CZP+BTj5f1ZoSvpzGA1/vtIvmGhHYPj2lAGad3OIz99tcnSko KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtg3ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:31:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KUc3J003094;
        Tue, 1 Nov 2022 22:31:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmayarw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn3nkqfSQGvoFPtDvBDXFa0fYiL5TECcmCmYNNmOxZ2MIj6mi1k9Q77hVBiaRai2v55TEv5xRWDPmjCRRi933cjs9CblUAHaVpaqzZsX3/2G/NHUicovOSrTllZVGeBV4itL6nwTkixqod8GkO0Ype5sZGtFUlxtqrJnFHckdxsGOqZ7HhNFZCvb3ZuY8lgN56GHvgNFhw7DHZLqQJdOc90yUgs3B6GqLjWsA8Pd46nCNCIYgFLx+LGjLibeV6I5/T2yEIBtTaE8fd7r+ZwpCSJL4NNyWZnhBkdcy2GbUplcGLzVqnq+bOxhNw8cW65Ko1EhJ4pIIlbVoSyqJvLs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8Y2Ey1M18G7oaDVu2SAR48OoMG4Yc24leIq2Z/FI0g=;
 b=Mj/Vee226HfoIkoj8l1E4bkqjvgKWKRkEg+v6jvskZqbZpJIvue6e59d+JmGf2hZ8n3G3ZKcHft9yx/hFhQEoN02MhZaLAosp5dGU9LX1tx00TIHCTuTImtTd5NlEkkoOj7fnHZ7Y7mVwMBv32keEsuR+DEZkg/NrUtALUZEAgJ0uhLknFcjWi1LVWHAX6EBZ05PDdRJhJhddA3bBcRuOYmCe8zAKOuIRuWDdWurhL9d2fiPMzJsmdrrsHGWvlaqYiQjWe2bA9+1eZxaQqSFganr0RcZi3gDnVlLWjqVGmZRydOplKwRDuRPLLCRJ0FuTxizofDfGsOShbBqsnQhyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8Y2Ey1M18G7oaDVu2SAR48OoMG4Yc24leIq2Z/FI0g=;
 b=AsQKAlhB9HY8hJqv3RLr9/BzlI+hWwEV3aBJYHoCUqJU109C3VeLwZzPQho25CttBUVAhJqiwYveMc3wxdLfNQvY7hCnSQrR4FJs9EP0Yk80cSjrI/2HZ/xzLPMzbjQd64ixI4UmELYJ/GKmxjT/mOd7nZUFo9y3Tv60Sko2Ilc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 22:31:21 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 22:31:21 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 0/9] convert hugetlb_cgroup helper functions to folios
Date:   Tue,  1 Nov 2022 15:30:50 -0700
Message-Id: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 158337b9-596f-4218-f314-08dabc58cd29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHfZVqYnHOkgAeCNEJTTNyuckhQKWDeMjUIIYWhTXRKPGm82Nie3rY1b+sp3ZEvvvpxUL5CZ5+1tRMUTJR6DNNUElZHqgTtZ9+mfF9B7v9dJkoyxBVV4n0AjMDUJsUGb1T3qTBkl3liTGCwF6yHC7cWX5M1ejgcROfB3kw6WoQUvLpaLD6mJwlQoWJF99MfNvvz75RWKh2veSN0Gokdwt+muO2vEXbBrJa1ERYMvnKGSu7k5Jqx4D8rh63qj05v0w0YeodNMUCfwlin8kKJ4FHPOYNqKO1VJbn8/b24Kdu/JaJq9yZbcKEO1kGGHmugGy1qElbM5XaFre+mcWb55oQ6CbmkDgj+IKWuOOAUKNFoSbWSQa7Nb81//Danq8BdhlDDdyiO64aB/kxxFTXBKFFbJZ0/cD3f9wWXy1R96YqwHuVaSncHbtU+RfkklS3CM/0/BdtQMkGW3Qta2eWhthqKOg2LQ6Fd0JlsrS9mwY6Cq+TAn440o/z2G/n8/sKxk4UmQshhvzc9NQI0o4CSDh+lhycyGEX8xlAZnpIDnm5rPMpzMe6NLvMkmXXlUD2pHpb98QtfVY+mBYrIWt8gslz4jJGY2NRNn5jI/HpwWmdUDJ+xkaswnymsBisVNHz/Bw4Y3KWFebvlSLZoET7N9Gfn8Vhosx9+8PKZq4U8V/lkwKMhKdvFQOlR3ZDyoajPv2vAouUh40P2MUQQW55D9cI+FMQcCli+YFlsKvldS/Xg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36756003)(86362001)(38100700002)(83380400001)(2906002)(5660300002)(44832011)(107886003)(2616005)(186003)(1076003)(6666004)(6506007)(26005)(6512007)(316002)(478600001)(4326008)(66556008)(66946007)(8676002)(66476007)(41300700001)(8936002)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k6R0suY2QqefF0Rc+xh3l2I9ROKkoEOFIrkQz/eLo0YF+K4ubZ/wsPHqQHrx?=
 =?us-ascii?Q?yf7bPlgumhunwzxkBvI1IgtksVGvQ9HcfxOZgWOxeyH9p52ZNmcyxPJEh5Zp?=
 =?us-ascii?Q?jpdqEMBs9xf0K25v7MsBbC4Zo2b1+nZkPMCLFL38EE8gsUnH+2S5ghkDgfWA?=
 =?us-ascii?Q?pXL68Q9Jz4x+/V7eehZpCtKvwDbnpepNc6aU0UxMrysKB45JCHGx19BshTpB?=
 =?us-ascii?Q?FiRmp60+hcTzuOu5JrkiJXF7UYrXbPoTHYEGx0ntBe9WxrvJE7R+n7fbQqyV?=
 =?us-ascii?Q?Bse6MdSUdefusvCBYmZTvMQuS5PzSFpG+tojNSj0lFVcAxFlnEO590cj1dsB?=
 =?us-ascii?Q?3f3Fqwwh/0rFa2uHORia3PCGHzRk4/N3OvQ5xozP/HsZqfKfGdrycN64gMnN?=
 =?us-ascii?Q?4lr7TnogOemfmz6hD/b43kPG+3z4VL6Tt1+6JvqNzDYLKdve1KTfQIiS4NLV?=
 =?us-ascii?Q?CpQvzy3yp9t/amdzS0oRvmSqnaQdtoBarTjxfaa+CAFstNHrXmdrcWvzuK5Q?=
 =?us-ascii?Q?RLblX7sv/ctq+hpSRM9GOJ1WZ528uxochdUrwb0p++KcX4cxxR+6iAJ+wo15?=
 =?us-ascii?Q?0o1Nnc80/kdOFGk7rlkxMLaOFmUyVQ2qC9UapYVSePQ1WdNZGC/XRG9jRGDr?=
 =?us-ascii?Q?z6H1+XVGIYEGfBxbe9wo2rPqBcbIuoBuFt2hqKDLiUb1sX2FGHal6TLgs8mx?=
 =?us-ascii?Q?P5b+L72ormrotsqiu8qVrO0aO3g5vCk+9L4x6gNcmS2eeJFhXJjPnWQqvlKy?=
 =?us-ascii?Q?bXbhDHaEhBeN4H+7b/mQ1flX8gfp5S3GeCtBkWHs2xuhWAUd99ezLfnnM8NO?=
 =?us-ascii?Q?pLCog6twfxD8m7hM2Xmbky2GIb9aQDLaB8hkz4lqtq0wIgLcPR4kiMQlcfuJ?=
 =?us-ascii?Q?7/8rL91VFHvcI8U9d+h/6LBmQvUxtd4mKmXIK1Wyx843btQz8fxYa5sVQgvA?=
 =?us-ascii?Q?6+/l2u3k3NeBrVMrbp/RyRDPjD2eXJxrNBvRQLNfbM9tfhWsy/SA4TFRsOK/?=
 =?us-ascii?Q?16zwbXSfya2DThS5wmZlk6FszauGGzDV/IyMJY1yRcFi7lFikPVcYEwNkbLa?=
 =?us-ascii?Q?embHO/KGVHUvc1rcuWaYITFyNejaLF4K1ff65IYDXWeqS++3rm5QDtvnbd9J?=
 =?us-ascii?Q?xp/woY+w3t7kGlg7QLVw0Tr3pHKRyB2eeFEHKZnnUFiN6UQAKvSQL8ss602u?=
 =?us-ascii?Q?IIsehH9hvRGu4HKOrkMmXuQfG2JZD9gdbyg0HQ9m9R+CILOSSvGK4dwLcliO?=
 =?us-ascii?Q?kxm7A//sGWPUxqYKvYErs6fr+21WxksaWX3LkGijxNLNfeIhBuBr/fWEE4ZL?=
 =?us-ascii?Q?tJXZzyqRIFjgijO9g+vm6pyaUKELhS9Se143XLEq0lsCKgQjTCJAAAtVmIr1?=
 =?us-ascii?Q?r7Qji3YXs1od6UmMWwB+LLuxYIhMysghuuZwDIxYKEb5G81aA2xY8ELL7Q7i?=
 =?us-ascii?Q?eWZBdW6RDkoMwLiWDeQgNyAM3zQNMgTBxk8X1Nn1RLzcezvAS4i41GO75POK?=
 =?us-ascii?Q?hPk0HLfNxUZt77Goke3f+m1O63kSwS6QijuzfJ8wB9asLBpf0jwAyp+2vzO+?=
 =?us-ascii?Q?Cl2vphyfU552FXDH+KfdfzMDhd1fisQQtdk6+jktPPHnkYzFdbopYZNLTcB0?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158337b9-596f-4218-f314-08dabc58cd29
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:31:21.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: st0ilgeFk3rinN19zLnGSdSKUDUH8dgLWYW1BSzBFUtDIm/i87VYLs8wnlcNheRf6pKmNu7xDcULNmo1K9yGw+gvbbMVMh61OsqhWUhFMC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=898
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010153
X-Proofpoint-GUID: mDRKZEkWXBDT2cgNbjz9puvERlBYIjbU
X-Proofpoint-ORIG-GUID: mDRKZEkWXBDT2cgNbjz9puvERlBYIjbU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series continues the conversion of hugetlb code from being
managed in pages to folios by converting many of the hugetlb_cgroup helper
functions to use folios. This allows the core hugetlb functions to pass in
a folio to these helper functions.

This series depends on my previous patch series which begins the hugetlb
folio conversion[1], both series pass the LTP hugetlb test cases.


[1] https://lore.kernel.org/lkml/20220922154207.1575343-1-sidhartha.kumar@oracle.com/

v1 -> v2
-fix folio_test_hugetlb_freed() check in alloc_and_dissolve_huge_page
-add more folio conversions to unmap_and_move_huge_page in patch 9
-collect review-bys from Mike Kravetz
-rebased on next-20221101 and mm-unstable

Sidhartha Kumar (9):
  mm/hugetlb_cgroup: convert __set_hugetlb_cgroup() to folios
  mm/hugetlb_cgroup: convert hugetlb_cgroup_from_page() to folios
  mm/hugetlb_cgroup: convert set_hugetlb_cgroup*() to folios
  mm/hugetlb_cgroup: convert hugetlb_cgroup_migrate to folios
  mm/hugetlb: convert isolate_or_dissolve_huge_page to folios
  mm/hugetlb: convert free_huge_page to folios
  mm/hugetlb_cgroup: convert hugetlb_cgroup_uncharge_page() to folios
  mm/hugeltb_cgroup: convert hugetlb_cgroup_commit_charge*() to folios
  mm/hugetlb: convert move_hugetlb_state() to folios

 include/linux/hugetlb.h        |   6 +-
 include/linux/hugetlb_cgroup.h |  85 ++++++++++++------------
 mm/hugetlb.c                   | 115 ++++++++++++++++++---------------
 mm/hugetlb_cgroup.c            |  63 +++++++++---------
 mm/migrate.c                   |  12 ++--
 5 files changed, 149 insertions(+), 132 deletions(-)

-- 
2.31.1

