Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40295FE774
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJNDOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJNDNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:13:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652025D0D2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:13:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E33wKP006645;
        Fri, 14 Oct 2022 03:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=x2bxyowP5gwB7VE5V5/jK+xq/2Zm8JwG7e5CZeHyLM4=;
 b=thAliJt4vIom/KCgsPOVXp2wnU6TLZvLwC3lhKwkH8RwA+vg9B5biId4Jw9SfkLJLzjQ
 6ZgdA8o/jlT5mYK5D6PxLsjs4m/5gDwyHfRq6mx+PPEg/ZrJBp5zF8QGE/zCwJPi+y3B
 JhFMn6yAY0bAeuh0lp8WvO08wrGVHJRMBo/2nv1S3L/x590mVIdnZrcOzLXRhE7WDWy+
 uucOtBfdH8m7rdcFdkKmXd4cy2pQBIPYMEO1DE07qbCpyBRAIsl/XAY07VFI/qS0nv/c
 yXkkNKKJSldGLMzvn3vsyZT8u8dvrgpgV/slhfpT4jESv17jzJ9u+Hb7FhsUTytVv4vn cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6mr29k0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:13:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E33EjU032723;
        Fri, 14 Oct 2022 03:13:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn6t039-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:13:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM7N3GDGxZc3CXNDS4h6fUjV52ehGMXm0rAVdLsNjTiAeqiXKQwewuqZDCI1EXBgXhwG6pk0/BQvqffU2kJaKN2I/aWsUOZSt6ZwaY3XO3ViYquY53GsHuIRqcdzRbErdaPh+o9mo+/LpJR5b4hWhlnO9crqzgJczAWtxZ42+0bAtn2fqVI/1NndaagTFAlPEL4lL9+7qm0deutMNhwHW9eXLxr5mUezVj23iWzBXwoGeyftF+ARBwt0s7aqtNqgyserYrYABcMkWUKVVxUkS2YKBTE5qE5WBg5K359v8voHkIRh3T/n43oblrj+ga3FqFrjPEODos4RllrVUESPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2bxyowP5gwB7VE5V5/jK+xq/2Zm8JwG7e5CZeHyLM4=;
 b=f/zCGlCb6Zhgb913v4fPi0LE4JMLpC3fo1v9lGaOKKY+9NELA2QqeHHULPSucxRpjg2ThjP0xWRcD/Uqehdyj2q/nAYoUfC6vCHFBANDp5AIbfxQK8bzzO6KmwCh6Ht1y7dF6ZnOVvCYx7wafse/RYLkhFLovkAamqdg5aKSNYltaUrmB+WY8kecllN3KnNBEdHCLXpc7ThKRIbaGXQYGUojuHuZ2NyBvXC8XREPE12m4WD1tBCisL49wRF4u4eTlvsmCSXYpsEPmm2uK3AJmn1H1NhWDRUp/lHbaPrgelMZX5VLYS7pTd4CdO3cyLB2zCL2KOUk9xfW1bWMMiC4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2bxyowP5gwB7VE5V5/jK+xq/2Zm8JwG7e5CZeHyLM4=;
 b=ax0kAGTenxnlbf0qQSTW9yIUuIEfKVXHJUbg6hOmVeAjr2GsFVSEodFZxRWT3ehfixm+ITum1My5r3Jc/iWRUqDLERo89UbDvTcSSg100ZufVNzAgZCw5JF6HD3kKT2l8SPVrVkKJ6DooJt0pBXGXaEY+U2cYKjpJB09/n8ZwVc=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 03:13:30 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8%3]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:13:29 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 0/9] convert hugetlb_cgroup helper functions to folios
Date:   Thu, 13 Oct 2022 20:12:54 -0700
Message-Id: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::15) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f92640-370e-4c52-2dbf-08daad92110d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ia/CCUEv85KeXGIWlld0TtJOhvhmJo27O7n0zZcjxAW92wutrENAjO7eUCaEubZbT7LOyMLUBbvTj1NaeYMNEs/gRwzVySEK8jhEDyP+77TD83GUlEThk+51rnm6oPspZYiZMze2ciLxVpccoHbSP3HVCXOf/4v+NP1/FU+lWE/36tHYNgWYS6RHu6W4KtXbSDPPMNMTantMRxRY6Y+e2BysBXh1v2onMQtJwBA/Lu7RmdeumOjO+JxQqD9hIAb1vnz/WEp0TKvijL4V69IRG0nUDS/amjczcepCZOYtQa4P5E/NuI8rNMw6z4UCFClv5ucDY6FbRvaou/aAeBXzNa+PTrbyupBHn5F1CxVW4blzXLGjdEYYe+30QKvZQT8256oCvXRCckWqZwWk1GuA11D1l9We7CfYW0dt4SkY41BrtF1yMzxs0szzP1Kr7Tbr2QtD2sN28ssIjxAle1EthKTPcagc/IP+xb0Bzd0N9InQ+teVzE9LRYoJIbP84f8srvnJugz/4XScFbl9247ag3YYh2BnhRFFCCFW+bcxARrd91blmhu1UyplEb5F2Ra5NTDrkBe7DKKApVeMgUbNBYDBOEbNkYwrsh4/ldi1qtoGOXkcDgbsn0BjLFZcrFMl0/F/FqXftv8iBtdg0R4sr7T6ne6HLlX5ekeJ5yYaxALipTGAT9pG6RI6FnCvN6Sfw1i45azFi9Tmvz9aCl15byBLh1ny9nMGTuTzc3OWUHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(478600001)(6486002)(966005)(8936002)(66556008)(66476007)(41300700001)(6512007)(5660300002)(26005)(36756003)(2906002)(4326008)(8676002)(66946007)(83380400001)(44832011)(316002)(38100700002)(6506007)(86362001)(2616005)(186003)(6666004)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yRD9ZDZCUC1DJnBZCcoqFK+JpuoALl/emOgQ0m9yN0Gc7pUZwy9dyitDrzTY?=
 =?us-ascii?Q?keisECPAfALyB0kTqroHscaOkTnfPJtMhVa2y0FLhM6S761RJ+dJ7sThpodJ?=
 =?us-ascii?Q?PuQhTPAUzP2wk878GpkUV5z3AICenQQY8ZwI+Zu9mPQN87LEAGJkN2I9Y3mW?=
 =?us-ascii?Q?C088PUfOISWVGRTGshuJeRU5v8MDX+FmLH+95bsBHOpxdd+9o8Owzy5ExLVy?=
 =?us-ascii?Q?eJ9iWAjUTGZExkhexOJgXv+ut7MERcJto5F1T1I2x1nxZwg+0MJIv2Ziu7EC?=
 =?us-ascii?Q?euE8LXrXnLgdy3YgONtGkmMbtmzz5eK9AKo5LCV28EOwMcIq2xyszRwtGMd6?=
 =?us-ascii?Q?WD6sm4JYXINukVTQaQw/++g1nIKEuE9exCjre8lN6pX+/BNRiHOaEUyQu/Ji?=
 =?us-ascii?Q?Yg6CI0pawMQbxSWxW9RDu4vMoG5jJkvuVqkxFncj6PNxlN4zaUGiQJSYk01p?=
 =?us-ascii?Q?Qc5YXhQfPyNKlP6jscgcjaHJPifZ1BtVry8lOljzo2dk+bJdBvtH238TftP8?=
 =?us-ascii?Q?atW2nHiyDVuKrO0NHS4HX+io8mmnTlJMPaKtz4UATv8IyrtGwEoFtPHM4bqs?=
 =?us-ascii?Q?EGbVtQtqcyNYj8jfKiDV+mqpz7zsSb8PaT/dTfhycdQwDPE5th1xaFWK+2Bv?=
 =?us-ascii?Q?hedOa94Jr1F15p51ZwWkAX/rp3tV+nfrW2TBOSDi4na6FdHwLn8i7/EoNKWs?=
 =?us-ascii?Q?h0uHACMr/meYnJMfbn1IXecb1f7z2AjVFs//+pruK9o96R6UFZh4v7/K7GYa?=
 =?us-ascii?Q?Y9IxwHl1kRnAchkUr2V1mu9QOruaF9D0kwlgFgGf3e4y/BX7L1W0p5RCfbUg?=
 =?us-ascii?Q?MHapJjkS1wmUb+9icTyLartJocwA+Frh8SRh0XcJDycTPns7tXE3A2t/gsTO?=
 =?us-ascii?Q?1qmmBvxBYXLrbWg8aO1je3CCyk4kWigxkjf4IZowLEnQlxVULgrcBERGI0W+?=
 =?us-ascii?Q?/RmODV8KErGqdxxeOaAoGRKQ8ViEdqZHFCgTzJpEVOyy7gpzaVnObs4JoQoN?=
 =?us-ascii?Q?LuhjNyymN8AC6sBzAno3EVI8aUwjmNEFJ2d2VEjCE72f5rviPRmq/h5FNLWZ?=
 =?us-ascii?Q?dc+D5TA7wTs8bRJnLSQF/+L3iDc5gj7KggZ7MdqQ3KqxbAqfsBWQTkQ6fHhT?=
 =?us-ascii?Q?x4CGQ/LF8KjHXQCVXwUvyk3yz8P/XOHCP2FVSRs/kH7Q/QNOZlStYqqhhthd?=
 =?us-ascii?Q?7QHv/1rmhByO5fNixetaA3+CRB6kUad1PH+6g6nbwbQ1mnIHCuS02kPwAy51?=
 =?us-ascii?Q?f3TdgjeF4lop8ZwqlLqsx0+aJqIAfsNzvOzUPGW6KljmUVQzi9NoK0txamI4?=
 =?us-ascii?Q?jAinjO5ZFazyCYAnJ8WuiLh2edWcgwWagGdDjp5xBHPQ0X4cysF6NSw+Llpb?=
 =?us-ascii?Q?CM4DhfaOkZI8xamm7XpcKTcOGr72H0BeM1eiQB++fY1ZTg9/4Ihv0gFiXteY?=
 =?us-ascii?Q?XqVwYlyrmcJmwjza8DEQDXUVVjk9PH7Umc5tmjrYDhBbL2JpvL1YrWh5OnI/?=
 =?us-ascii?Q?2ycsHFyGlgdhWGL9OCcIYXz5r9baKJFtY5U2IqSJkSnLgk0/xmBvBknnqBUe?=
 =?us-ascii?Q?YfGrEfvZrudn6hhkNfh4eRzLHvpvNWJFWp28V8e26qNSfqAbHkig4z6F3zJJ?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f92640-370e-4c52-2dbf-08daad92110d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:13:29.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VE3IvCLn6CSv00gFD0vDnykfS6fyXJBE/iJcfd9JW4GtJ27eMDEZccdGhnrubQpumLfBYqnvf+L+ATFYlQDu2Emgu5qgjj9TNMSOmqgb94U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=867 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210140017
X-Proofpoint-ORIG-GUID: en4dOABsg6SVjwrxBPL0JNbLlDOcfXcY
X-Proofpoint-GUID: en4dOABsg6SVjwrxBPL0JNbLlDOcfXcY
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
folio conversion[1], both series apply cleanly on next-20221013 and
pass the LTP hugetlb test cases.


[1] https://lore.kernel.org/lkml/20220922154207.1575343-1-sidhartha.kumar@oracle.com/

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
 mm/migrate.c                   |   2 +-
 5 files changed, 144 insertions(+), 127 deletions(-)

-- 
2.31.1

