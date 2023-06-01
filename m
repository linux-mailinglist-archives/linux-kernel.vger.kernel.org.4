Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D5F71906E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjFACQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjFACQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:16:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7DE19D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:40 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKBH38020019;
        Thu, 1 Jun 2023 02:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0xbWsBeaPIGtK6mfcigFaEI5C+wIlDGWBRAKirJxgb4=;
 b=aYYPoy71jl3rkQ+hBf4FHxUvrSdjM7HLzqw5TkemWedw8yduX7VHPxL6aNAgwEzbMuoC
 ySeYkXaCvjgU6pHLx6N5WZPEgJdhHFiAYwioV8sIFWJhe+8WVnvIa2+AloCpw6LwkVJx
 Bpol2tjZAm/x4tWDgcYs6JyBTljAZwL8QLGemig9yCxzQqEi2ec24tO2Z9xCIXfGDQT4
 9CVmEySRindttbPg7RDncDWk7LpOueYJOA8NQme2Tu1Gym9SJ8pn4jomp5dfgmVLCvEj
 0IT/6gpUtGYY2rJDVeeyimMq3MeMD64NV49uLgUbjUwpaqFAuJBKKLtcAY9xKehwf7bX Fg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh7hb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3510E5Vc014631;
        Thu, 1 Jun 2023 02:16:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6gr6q-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTE91UXFdpS6Ao6bVRNUSDn8gs7sQUFJpIM3Frl5LM+0QQVX13DwnggFNrx6MytO49MCJbN6+vznc288eiF/Trnsp+rRgumk2X6FURuPqt7WrQBS1zAEkrnzBi8Bq8DS72r2sWsLdzXp+KO92EGGlmShXdK6nIpdgP0uanbQlS3gy7fs+WNFOD2KVMBzYT55dBHteHb1odqGartY67yaYOuMlDWmq/21uJZ3yMon1m2C55dv7O4TmkLWfUg9ZGDpssJOQRiGcAdP2gOQK+ZA6zs1h5lMpaG+GQx01zI1kbVWD6K7yDYlVCqWgColltvOKcNxLY8gY86o4z2N0fsLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xbWsBeaPIGtK6mfcigFaEI5C+wIlDGWBRAKirJxgb4=;
 b=h5G7BCer7T800vn1TsHcHsaq823NUyJUz3GMHfp1lCN6U6aPvKryF1l+YsYqgkKJZdMuT68iJlMx+eBeQCoEE3WanqgbbJWXaA7P1cIrlH3H2BoDqOvlDPHg97betsvUYCQoPI4h4cQmX4DTkNo5VPJbd+McEEuADAwXW1XMNzsmHB/mUulRVuy3+7O7ZOhmeyBp4YSDGsUOwliehHJYRdQnM921BcVDYyr7p/h9h3N/q0+btBpAngRX7z5e4Feg0ib/3zLk02yo57c1/2sCeu2t/ZMJPyVosspr4qFlkmhZeJqhLS4CcBYT89wZPQ7Kx9IGk1NPWqPaSloUxjJWkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xbWsBeaPIGtK6mfcigFaEI5C+wIlDGWBRAKirJxgb4=;
 b=aayX/QjQZWeGt/cq7QwUqu++773E9u+rihJgzzX9vfYE9fxKKOT4aMwVEz0rWt0T26nqYa4AT3Cna7IrHlG9ExAytIWNuGqtxZUDaBl/T4n7nHcfEpSJO3MfWXhcc/xVt8VcKHk+YfnPtdjcQIJ79Vigcd4/U59ub440a5sMNg0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:29 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 05/14] mm: Remove prev check from do_vmi_align_munmap()
Date:   Wed, 31 May 2023 22:15:56 -0400
Message-Id: <20230601021605.2823123-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 3557919e-b46a-4179-2196-08db62463588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xwk+yKWb4FbkJKarlqQvrSKzSRfyEWzrPysR2FaZUcL6ktaUXovbOXc27pjuU/U3rPk1yA12A/gl/8tUh6fkLzXqFjIoZDYOlziX82L3zxGM8SuKH6BD5C4pQhr1lvHue6b111nuvIF/7dF6ewwF7ezmbMY8X/Lc4pIkukISdrdxuETyZipgduC8xjO0yK5RByS+YY7/0HsMlWRbFVCdDHofpKxMr3v4m7jU/JNK9qEEpHgHRtrjoLtxug4wkZQb5nfNo6dft1qts8K2aNETjxBa+HOm49HyBd6I8O42zpjXb7xg8s8JdJ2a3kigKAZti0DGf0ZHIZgrAeVIXN4Sl9PpXSMSiM6An2nbeMzfDrYDQLT11DAEz0/+Guf/OD+gKEkENz1I68NBhfPKjKd25YC/rZsWJAU6v7Fqz96/Q9fdJ6qycnOBTfgEv7hTu1OTObqMGmi4hIyDXpX6DXMdshBh/ajiuib2pkYa53+B6tFHeQLCZSOY/pca5GNjlkJLlx73qUB238LOMNSSWqpTa3mWO77+U96PirEKfChJkRl7tC5fbQ2NsTxWAJJxu6rs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(4744005)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eh5yV5gFOHKBexFeqXkSCc9jpeT7tWf8eVll3pNH6cZL3yIrR7TBSV68UP0Z?=
 =?us-ascii?Q?N4if7QxDFrlippfAos4c9VFmqJw2+0v3AzJqxaXtfgbKUcLhaE0p1b6McXzs?=
 =?us-ascii?Q?n8lje3EWsyk2I0uy9/k5LYz/wod8jeSe0IjYiUuuuQQ7RavUf/UncCol5Mvk?=
 =?us-ascii?Q?syrYMTc3Oyw0IBgtMacQRpw/nTChtlrtWOzob31vHIdPej5rRAb5h0be8O30?=
 =?us-ascii?Q?FBXEkeBKfsXnnr8NGkGAcDkPwHzRakZOgUQRYWQM9wFSpUvEWy2I9Kcu7sR1?=
 =?us-ascii?Q?OCB92328dBGbYT1+LRpzhGiOxnKVXeI//H/tNYNb3lH1rgZY+Uk2B/a0urPe?=
 =?us-ascii?Q?GUeoH6K7nFrhevw/sSk1LMww7hlh8aBi6SRoY8jzEWKw/dAEzWvl/TeTUr0f?=
 =?us-ascii?Q?YZTjjBv6z4+rdkP7aM/kxXNTrhan6p+fueVC0JUS+tTUGC4xhLrjGKFVCy/L?=
 =?us-ascii?Q?57WLeGXqnKXrp8otAxAFump7XdAJFHtlZuFmh81blBD1mm9zhZ7Zd8sNMJt8?=
 =?us-ascii?Q?o+9wI8GjyycGKjISNhl72GLT4jhikCmNcKLHnJjNNr+l0XzjPPO6qYbD/lD4?=
 =?us-ascii?Q?wHiKvLXx8b+lOkRwk22NN7m77gMdZwYMRigNiVnVY/9oDMyFN74zraarI9fF?=
 =?us-ascii?Q?yc0GtXhoIn01IZCeXjO4pMr+UH7z7VwA3ODC7HRN6WmwC6rcqY0z1Hx3n+Da?=
 =?us-ascii?Q?jOV0gzdQ3kyrJqa62BiodG2OuCYde2Kb142H+/w8xDJlMWTtWd/tTSIcuvLq?=
 =?us-ascii?Q?WyJsIYrrKWngXzz/iBXWPs+nNB7HMVsmBFtxnKUasJESZ6zodr3a9ttRwJLT?=
 =?us-ascii?Q?iBbgg0kZaZjjCHpkTjZHlENQ+UXYSkPJBwFPGrPYEbxs/xfHORUbTa+zSfNO?=
 =?us-ascii?Q?UonzNxLaBB3dWIFP4bxzxNXPFaMYdCuQvZC7mlg3sYlGHRtMXEpaTld2cINa?=
 =?us-ascii?Q?EPcDQa0CuW3c3H3JiQJ0BLyxt8D/7FaCcbv/xbkilmEjuNEIW+SWMS2Iog3L?=
 =?us-ascii?Q?fHE0V9Jvss1fnOycj7OpMC3/nsNdSK0WRAG6Vk9dhBiqfc3mWe5S61VsW2Mr?=
 =?us-ascii?Q?DLf4UsWKRcav7Dd0UNC2v/nw+hQM6ByHiEMA5dO0BBCfm7a81RW8f0u4tHcV?=
 =?us-ascii?Q?GZxHQCM7yfmjgC80EUtvbRrWtNHOKUm3eNjkxQzygn3QxYb6LgXdtc3tsCyn?=
 =?us-ascii?Q?IMDp2K/ucA+xuR/nHHh1YScHdlk4Wg2/3fGEfuZuBdPdIOC7wZXvGCmZAog4?=
 =?us-ascii?Q?pouT4YQF2GN/DlV3HKjrZwz2GKZ244XV2bH+6FEbOAdy1dW+JpKZO7zX1yQr?=
 =?us-ascii?Q?3mp/YTOoqXNDRevbU49ya1Fx0i4QLCJyo7uVC8Lyg/3wPSFR9D4o1P42peNJ?=
 =?us-ascii?Q?hJuySPHjF6y7O+TnL7I3C2cq8BKTpQICWrPnLApdW7+1i8xQlF9rVvAMxTSx?=
 =?us-ascii?Q?pHpEJ241Wf5qbL2QTn9EYnJ2wKWBKfWOTUuBGBspsX4q5366r97plnZecj4Q?=
 =?us-ascii?Q?+mdN6mRfprZ8Z3bJdvbHxi2Awzh0tXmfc317xVAipnCx1W1KPoSFOlN40MVF?=
 =?us-ascii?Q?iy9vaL9RNcug2b+K/H4UueYDMvLVVrZe21snhTfPBt8P7YwbiJznAsUDVF97?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nfC6tsHTPUpSPx29ikvYpfnE2lqiTJxlRfFk8FDEEWx+DEm3TzMgDHsAcr5n6wXkloqtH+eyh3bFPjaUp0+bMI1v3hv26tcKv8SCM8GnTQoPLYDhrZVG51+E8QytkR6V2e/bgq7dnMrYTyilw6Pdvz2+H+aGnBfLJCTG+NvNiMfiN0eRvSVUAnWVRfaACOb7KhNoBASAv6b4wOQHHnh7abASlPwQYMd1WnjIi8VF3VqD9pnz5itP0pr9jqnKYoHXxGSlESe5rKwfeqopckBiFSKha84g717xefMcmwUZXJoXTU0bFErrbqs0yTzFIkKdAWiFS9UyTUy7s0/+0xN8AF5ftaxmpDzFxbTZScLi6+d+rb86BVHZOG9OQ9Lw46Xzd6wcox0wnhc0WsJi8LPZFJPe+BfMhSJYR2OXyyRlHCRlQ5pb7zQ5wGs/hhLGof0hEAXJ7sK55a6BLtcuIS7m6aKMaoQptOCKdZsqC/6XiZZO7acm18TYFD92WO/yJEIIYGuvjdnnPCLNaBtjAqmj/rQzAZ19JLeZOkPs8yjfq+F+McamBq4h3G7lx5vOsbVjwwuZUjTKfLKK1CaBUYgOWLj10wK8Lm03O7OmncoCvkLiAlXTOCFESz5ssyPJkVS8oOfpRi9Byp4Skihh3HuNEsZDuXWcSXwPKcR3mJu/FsrXQBE5Vkk0CN3rBf14YC0qH4JHP+O3EQ6vVHt/9s4k4UrccSVk/txFP+abXX9wJtGVYYXhXXN2Xkh6qhNoWWQKwMvNDLPn7AeWRjeEPVmJCeIW8HxsKYKTosowt1MnwS8CAPlF1cH4wwkl6/3Hvvy5pz+ZkO6nfkhljC4rS+/3FligiBBjcsItqqFRDDvJjuYI0dMnyrp08zCbWPRa8FxjikSR5dBTt0GkU/XzBuP+kQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3557919e-b46a-4179-2196-08db62463588
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:28.9566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Onw/kGxGBwHwdxUxCWzHQPLAOKqmEzf1/L6f4d3CiaPLzxGAK7d+xU0mAeZQov3/MeS8qTCuZdYCkP644cI4BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-GUID: k-KmwOXQGCkhC9tsrmjO1TemiYXr_d9K
X-Proofpoint-ORIG-GUID: k-KmwOXQGCkhC9tsrmjO1TemiYXr_d9K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the prev does not exist, the vma iterator will be set to MAS_NONE,
which will be treated as a MAS_START when the mas_next or mas_find is
used.  In this case, the next caller will be the vma iterator, which
uses mas_find() under the hood and will now do what the user expects.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8e5563668b18..fd3f505b40cc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2402,8 +2402,6 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	}
 
 	prev = vma_prev(vmi);
-	if (unlikely((!prev)))
-		vma_iter_set(vmi, start);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
-- 
2.39.2

