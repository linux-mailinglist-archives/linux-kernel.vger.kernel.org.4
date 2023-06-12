Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEB072D0C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjFLUks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbjFLUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E0419B3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNjtB020940;
        Mon, 12 Jun 2023 20:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=XdzmE+0mLmhFH7X5HIPLWcKQFzfv1CAnkFZb+GsTr1o=;
 b=ifUOrZh+12Cf3O/Jor/v0wU5zaEucELK2g5bUpU5uZ7bvaNf4u+MQmKIu21PhQ22Elt4
 KNyv3u+I4ydtPrDjtARwDT10GoP73uYHnuhHJqQnh7AWRGyUPUTOZ7p04IHxrLwfLd/3
 o3Sludq9s634s64hJsmJpq4A60+PFxmI7bGYtbLqb5B3axO51cvJyWXgySYbyAeydi4D
 cGzuX+owKnAZQxe/GJttJ5fBFQNcMDWp8RuSIdXR90Vuq+7/LEc8/kilbPcsHrgbXqoc
 KUNP42aDo0pa6q0OIf7kHc81LvsL63Y/dJhOe637zcMTpB8tKe7vAUJzqAt8hHVFH71u /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d3uas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CIonMa016344;
        Mon, 12 Jun 2023 20:40:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm399f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdL/XsZL5jPQ/d0dmPVX1wdakkSkZTpaKUrhpoL//6VJ/+PaCwm8r82QcGKYstzx6EkP33glrLEqTpyrVFwN1rM9gbtR5oIcaXTHa8QWO+810clFM9IhSCIztdao2LUs/KVwWBiKjnx7XiCV/EBXJAL2zLYektthWsqYVbJYXwwKRSyhsFOAYF13R7ytTcPx4m8TLLSdQ7RQB5ZoAW6NNfFukcmK+f5WkMTCwGdZA3gUCbJeHorsY9lAG3rCWqbqnE9/u0ye/vgW64MDQQytMF7fKYFeeQBGVR7vpjvS2qnAJYiaeMSfvsnhc5AwdvUwoAA7ALEU4ubn7nZkwr0zBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdzmE+0mLmhFH7X5HIPLWcKQFzfv1CAnkFZb+GsTr1o=;
 b=hBG5vwazJLREtXO0Kw1dTj+C9zStNryGPb+DFc0VtJm64lpgUluOMimqMNPqlczlZ8xo0G86Dw6J70WFSEpVxtRRyIIEmjwxcO7lH98laONeoI8xmKgM12poq8ya4Ou2MXcs1vZTijevzHsyTBPzvLivawx0HS8UTUZIVwd4by25vnoGtKzg3CC4ihaPHM6KGRMpFMKpMCizqLGEWvguchyvrR87/+/gCy9FS91Xe5CDqJCgBF3nxD3MWXI3B2ntOii8ZAEPzhnxjz6P6u/9q0pKv7r8t6OLug6voCbpes6HVFqogsXPJfnxE1W3W+AN0/l69shxTh9cuGOr/2c9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdzmE+0mLmhFH7X5HIPLWcKQFzfv1CAnkFZb+GsTr1o=;
 b=bMfkNdwKp/uFlBw9btgcOyW8Q4Jico0NCaaNtVZ8L92gTmrXl495AwlG2wClB+Xs2+pG9xTW/bLW3T+3IWyudiM6v6xA34oJbegOqFy6z81ErhMCtqVM2gc/Vlo/EJISr1k6IT6m3LtNZ9XuP+TBsQsthBizy4uueUe8/NBINls=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:39:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:39:58 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 00/16] Reduce preallocations for maple tree
Date:   Mon, 12 Jun 2023 16:39:37 -0400
Message-Id: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA0PR10MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc7a9fa-057c-445b-9556-08db6b85302b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OaELEstgPJ6TiTRL86ULF1+sBRB57GospLy9MaFuwR0oAbdeCcRA+eYprt90frv7Bg8QYJFl2lW1jbnFrd+b10dBKtkRg1pg8T8FW6skY+3wJXqDM2lppMfEpe72cpsgAUI59lXnnKe7D4ZmLQdU7pvhBuyv2spRDcq77AaXQTOxEJOGV8Eq/AdNik7Drvz5dheL2H6bzsqTmGjmCA48rqR1743ukQTDud0VYQTwOT7IOaCDfp1cMqs5lPC8sQbkhzMfTtP1qRQe6Bd5pYZYi04AsQ/OTjPYbQQttAox06Zhp/VrgpANHN7fqy7wz3WfsrX9aJ33qMHCmJDTq6nuTAXhj6Qp2ewuM5kLrF+gGEgO06hQI2dPK7F4QnnIuPbe/YepoorkoG+M6FrRQkap1NVHyYg+O9L4fzUjn+ACijwTXRjiTQWXKpW2PXWgYRLKYcikjHzF33/1xooWWQsWpKty/ZK1YpALrFVzP6E/YS5NuRT610P2Q4MtxgGWtNIqL4Nx6vY+ki4KKVcXLgTyANQwHP7QwcNk2k3fVUlKHvsiwAHZbS6Axwcw8YDFyF+qVYTeno/56yazn+YOh2X3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(6916009)(83380400001)(478600001)(8936002)(8676002)(316002)(66476007)(66946007)(41300700001)(86362001)(4326008)(5660300002)(38100700002)(66556008)(36756003)(6666004)(6486002)(2906002)(966005)(54906003)(6512007)(107886003)(186003)(26005)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WJLozGy1VUEBZyV2Ds6irFMl1iaPCRmT7sN3PVqYw8J1SW/Hyt7KdCIyPI/W?=
 =?us-ascii?Q?C03lWpSbd53n2Wniet+j6t1UjHzxYwvU0jrM+VEw9TIBrevIgwTeZ20nYQXa?=
 =?us-ascii?Q?KAkRhQbpBNFB/FuF3aUXfgKlvTl56gFJ7k7T7TZMrSFimbkT6U5RwB3bWUyJ?=
 =?us-ascii?Q?QnRszEGdDoG+/GVnDyAEP1LiOdcOmR3ib3MmxgN/n0bcq3o0KgvPnAjXHoR5?=
 =?us-ascii?Q?3QaqwYkyiQ7H3moMWMCoY5kN6IIuqmryPOn84ZViqMhPuHaDNJLmdlSAPgsi?=
 =?us-ascii?Q?+xD6cA868wG2+gTVk+jZWH0lNyS5RzgsZ7o7Cq3feWg+ox6RAogoalHqHXHs?=
 =?us-ascii?Q?uyvCVb0Xol/8bCjqhgxihdcoMIWKWPnUOq0NfmJVJZwGweehXG6p1qLnDxTy?=
 =?us-ascii?Q?oLXsid6LBE3et/umo2OPWc+HhOp5/eSn2mzYuaQwOdkzJ3wb7sKz+52bvAmt?=
 =?us-ascii?Q?RgfaaUSmiqsCXf7umTZnnX9p3qMFhZb2HkN8/SmAvSXt6dxD/bPC2/Nu2iU6?=
 =?us-ascii?Q?G9LeIjOeH/tSVBNsibwKnJcKGf4EgP58uihvb9RsiyRAOnm+AOzv8xzephtj?=
 =?us-ascii?Q?ka8K08l0dBV0/pWoqwXbHuK8u34ngkRI+WmKaMLe9c4Wr8q2pMCrGDzMYtXL?=
 =?us-ascii?Q?5X86mSI24PIflXPZ7UCnZLzHNYoIGA64QJOzGK/291Lqr3oq1oerSWjzPtiB?=
 =?us-ascii?Q?wkQzTvs3GDVA0/suK+2ky30EilzTGbnwsxZYTVHM799tQCe8tlGlqXwInXIu?=
 =?us-ascii?Q?kXFVmfTMUpNwj9esaA74ZkwkF/EXaVyQE/aZFLHQIPCpRhIqonrFSMoBts2a?=
 =?us-ascii?Q?dhFzWAQ0ab8eExDx+pKfQSKYXUjiUSW+5Nd15MsfCEV9fB9u3oYNUG7jnDpv?=
 =?us-ascii?Q?8FCjWuOHtFqTPOsAVoIShjHcjfs0YpeqByR05bqxka55sf8XOZQQ1BFHBGmb?=
 =?us-ascii?Q?PdcV/psgEXtx/C8AaAlhcnTCCBxhZe1DSy3IpbQlSZrX/XQxkpviy/557tam?=
 =?us-ascii?Q?E6jht47Pm4ysDawnXZfGT45Q9JK/ADMKdG01SBqMJLYdXBrWevw2aA6hcSwr?=
 =?us-ascii?Q?OldDjnvlIBO8szkrmvm2tccjKPQZwlfOTevi+eViJYkdyMgtCVIe5GocUcXa?=
 =?us-ascii?Q?j23kxLZX1wiWVaaDgzn5PTO8+zraLqxxhz34zBJA74PTVahNDeVl7ADoyH7D?=
 =?us-ascii?Q?/X/c8/THU9OQ3jVrEENjoYejByuJhydlmQerMIJlc6lcAkCw2mElfzSj6vif?=
 =?us-ascii?Q?7zK8tNCDeihVTZQBu/0SAe1jxCw7lkL/kbONdgM5wGNO9CAy4J5Zbk+j6EtC?=
 =?us-ascii?Q?QZVYET7XwjzHCuisWdxsspcs180keivkHLmdQem0WIfw569J76NuR/CkXPjd?=
 =?us-ascii?Q?xANduKbVAcda0TiOIa7t0dU4FiIgbgpPm0BCNuvi0rxYD9G5yDzmQ5sSCrjP?=
 =?us-ascii?Q?OprN3gIn3VI21Iew12dRhkGFaicLNwUFft+U0xHddjIwI2oI7KD/dYHNf8Q8?=
 =?us-ascii?Q?LvBb4K+pyM7ftSDjKu+6cF3OGVnETQ0CwyiXDgqlO35ae+oCFM0oT7wbLJIp?=
 =?us-ascii?Q?2J9W6WgNDxd98qm6XjxR6xrZGiR1ubTydtSBl5inur/KvprB7JAlzoZlDoC7?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?D2CNQ1GmjJhR3qZsMGuPBNJYIqPbaf6msaaKoq/azfoXM+P8ZfRAvwPkl4yL?=
 =?us-ascii?Q?uvLdVScoVYZW2rLYRqIar950lruY0XSV/Wp0kLvgYVGAhCGWH5QpyjvA/J/n?=
 =?us-ascii?Q?CRuNiaTCUwhO+mKRvQw/+u7phxWWh0n2fJ3CACmWRrQdfhaKiX6hIhXcheCc?=
 =?us-ascii?Q?WqUVKL5QnL9T64U7SZzIbzIzEvaMJGbNUl5aO4JWDLj51MUakWwgFVLxvqmK?=
 =?us-ascii?Q?ORapxOOga7za8ooEx6cCriZB62jH86abC8JSerGsJ4H0PoQOXJi41nCxQf+B?=
 =?us-ascii?Q?vsv/KUUR+R/SRD0XuAQmvqOWh8Mqnda9M7CfBLpQH1OVsFg/nKcBtLrXsh/F?=
 =?us-ascii?Q?78MCa8qgti8XEcMwf/IzjkUM/jbkQeCUP6nEcPGdtTIGQ6sqR88ZLaQKFQVR?=
 =?us-ascii?Q?NBBQuSKX4c6Sj84NP8kDF1OBKR3vnNHyRrpc+FtYqHKGFk4pgH+18tBLCmnY?=
 =?us-ascii?Q?XaqjDSZBq8vQau1bb9Wwa74Oiqe/zFhiviq8GrbjwegNAAvs5kE5p97LvSN3?=
 =?us-ascii?Q?xLP5heMPxujNam3xtSXXUn9LfmAGyifmJOouatgEIX1DB+TLP+TW9eIUS2Tm?=
 =?us-ascii?Q?O7ksr+cFI3Vq5oVrgcRxDCsnw443FEl6VFkcnPFpoNbNt3K6ssW7bjoPWExI?=
 =?us-ascii?Q?s5qn0UkoPI7hIua2iBMPUYDNVaBebYRKSKIINJ+mzcP0Z7MYTc5FU5fzvKBp?=
 =?us-ascii?Q?jm5J0+NNAIG3JCknGp6QeMOknpieYzP50jqkh5rDjnyJ1c9oA7bZ9YSYOiKt?=
 =?us-ascii?Q?PPyDpaooOQ6BClCs7K2p2yFsIQgrYwWHeWQr5Rcc60OawKaNvrioVUiQrMf0?=
 =?us-ascii?Q?QjKQhjD5TshPR1dW7zZRf0W3eKu8XjRgrxk0nTcHM9KdSMcuRHNA064SROVj?=
 =?us-ascii?Q?93uJZQsTWrkUBPzKHcOKNVtZegEiLG4eZWbIgEcFD6CPdJp59OTFLqBagUpn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc7a9fa-057c-445b-9556-08db6b85302b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:39:58.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 159pS6NciQmH5FN2cQ+ZENHx7/m23zpoegXY6FsoDpW4epYFhcpKJBL3U1xX+NvG7EyvoWN6eV1co5M1UATk+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120176
X-Proofpoint-ORIG-GUID: ispw32KKiRWCJPIcjNQ3gkYPqScEEMAz
X-Proofpoint-GUID: ispw32KKiRWCJPIcjNQ3gkYPqScEEMAz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial work on preallocations showed no regression in performance
during testing, but recently some users (both on [1] and off [android]
list) have reported that preallocating the worst-case number of nodes
has caused some slow down.  This patch set addresses the number of
allocations in a few ways.

During munmap() most munmap() operations will remove a single VMA, so
leverage the fact that the maple tree can place a single pointer at
range 0 - 0 without allocating.  This is done by changing the index in
the 'sidetree'.

Re-introduce the entry argument to mas_preallocate() so that a more
intelligent guess of the node count can be made.

During development of v2 of this patch set, I also noticed that the
number of nodes being allocated for a rebalance was beyond what could
possibly be needed.  This is addressed in patch 0008.

Patches are in the following order:
0001-0002: Testing framework for benchmarking some operations
0003-0004: Reduction of maple node allocation in sidetree
0005:      Small cleanup of do_vmi_align_munmap()
0006-0015: mas_preallocate() calculation change
0016:      Change the vma iterator order

Changes since v1:
 - Reduced preallocations for append and slot store - Thanks Peng Zhang
 - Added patch to reduce node allocations for mas_rebalance() (patch 0008)
 - Reduced resets during store setup to avoid duplicate walking (patch 0015)

v1: https://lore.kernel.org/lkml/20230601021605.2823123-1-Liam.Howlett@oracle.com/

[1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/

Liam R. Howlett (16):
  maple_tree: Add benchmarking for mas_for_each
  maple_tree: Add benchmarking for mas_prev()
  mm: Move unmap_vmas() declaration to internal header
  mm: Change do_vmi_align_munmap() side tree index
  mm: Remove prev check from do_vmi_align_munmap()
  maple_tree: Introduce __mas_set_range()
  mm: Remove re-walk from mmap_region()
  maple_tree: Adjust node allocation on mas_rebalance()
  maple_tree: Re-introduce entry to mas_preallocate() arguments
  mm: Use vma_iter_clear_gfp() in nommu
  mm: Set up vma iterator for vma_iter_prealloc() calls
  maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
  maple_tree: Update mas_preallocate() testing
  maple_tree: Refine mas_preallocate() node calculations
  maple_tree: Reduce resets during store setup
  mm/mmap: Change vma iteration order in do_vmi_align_munmap()

 fs/exec.c                        |   1 +
 include/linux/maple_tree.h       |  23 ++++-
 include/linux/mm.h               |   4 -
 lib/maple_tree.c                 | 121 ++++++++++++++++------
 lib/test_maple_tree.c            |  74 +++++++++++++
 mm/internal.h                    |  40 ++++++--
 mm/memory.c                      |  19 ++--
 mm/mmap.c                        | 171 ++++++++++++++++---------------
 mm/nommu.c                       |  45 ++++----
 tools/testing/radix-tree/maple.c |  59 ++++++-----
 10 files changed, 364 insertions(+), 193 deletions(-)

-- 
2.39.2

