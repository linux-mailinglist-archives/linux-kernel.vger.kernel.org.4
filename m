Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B8072D0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjFLUkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjFLUkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886A619AA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNtBX003133;
        Mon, 12 Jun 2023 20:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=j9omlzefsXQ1zzAnkg/pmDvba27GUm7hHo77v9ASBEM=;
 b=Hm/0dBTNhSW/Z9+Im9O0iNEmy/kQucs6MvuLidubwvJq8dzJeINJoCu4rrQkRvT79pJl
 rW0BkxcpJMJar9ttaQohbm8dfBeMWx/owu/QOEzlu6MA+x1cILwUF8Zn76jGYk7+QP28
 K83OcPGTdSXdh8XamUKDotzskvHyp21BBv02jSfq+YKtAUdsSv1CfD+N2gmkOGz494PA
 ZwBB1nrP8FHEbjbyjqDFZmhfDpkN7L9x+zRdKsdIUpTPrGPgr1K8/VodeRY9gfoz+Cgr
 z0iOoKNujvXbLXcQGPcwUhmbngWwpMp6QfdmkuKCnNaBssUSY0TXwDIsw2bwmeJDIfTu gw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdktnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJTvUA017793;
        Mon, 12 Jun 2023 20:40:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm313r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6Xh9SJIXhrlAfGQF7FG6cW+rH3LxqLDdTMtCSwh1Ms5rj0Rp5gg1cm6jomXQAgxndIHGYn9RbIcUUqsQYbrVV0dNcNJoCFy9Unl6zoiy7yPMKOGM1pOQjwD9gPE2/sM+In2TACOVMB767bYoGUtivTL10lm0DOTnk/sJCzz7WReKieKnxjhOa4LyuW5YWGvhcovuq3j/JRcU3vu784kqhxEiwm4uVMeJ+Lt/EJcR8mezt+5vJkHOVvmHCZpPR66gqtSF6vLkug56KupfNG1ychHP6C5MrQ8worz1J10evi5rbzaW1h1+iuMqZAoG4aUQ+BukpUWmabv6fljWv8U8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9omlzefsXQ1zzAnkg/pmDvba27GUm7hHo77v9ASBEM=;
 b=GCwkWgF8NWQBLmE4TTt/K+VJ2PajnODKJOVIag5cV65c8ZckMbuuFsisG4ih3HDtwM8ivl+kEpwzLmnt3kko+xLPEkz8p0Pikgt5ry03j1kd3WMOmZ0NBwM1KgtNm60uOq+WDn5Bc0tpBRp3S/xcNo5J+37YEmbZE/ty+ja0+w6xYqXWgcvFVrsIOJO/yFFovMXaO0IdbN2Ppon+PiBbqEwGfLqhnqWiU3ARZTYxrq0+x7zVdIOKbqO9PamwkNgGpP13y3wrBUIk/j0TYQHViWodL0Jife1eFUnaB799HKsOn9Ovl+Lbw83OPQXT4eyWcfgkxweODNzylkhtgPO5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9omlzefsXQ1zzAnkg/pmDvba27GUm7hHo77v9ASBEM=;
 b=FIjSZuwNsZ6ZudTWlM9lw7UEsVVIgnu17WNh3tSwiqFhnGkKbDtgzWeHReoiwFL5d43PYeqKzWd3r57pWRmq9MdVeDcbqbfqzGGw1Ao+G2EoKK4SIKJe2zrW9jiQNCOJ/1r6oyLCpwCWttoUnia7znKd54rq9P1sXVKvmEgqA84=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:06 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 03/16] mm: Move unmap_vmas() declaration to internal header
Date:   Mon, 12 Jun 2023 16:39:40 -0400
Message-Id: <20230612203953.2093911-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0084.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acfcaa3-5965-45e6-4a95-08db6b8534c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVEUUe8xAgmWcUVHfjMeHMZuWzMIzKrh+q6nlUSsTkRpp/AkwFFwzYsSExmOMRp3t1xii7ixMBXGKO1rEoPzQSdFmtujSYxmJ+ZI2qUwbFKzqPtW3h+Crh9eOA5RYXKhoU1JTQ5j1gO3EKJoEtVdlw8DnDJc0/PhuvyV9GctBWJ7zbZaDfSpdPkAp2X2tKJta7Kv3ZPEOGfYdI26QE6r8vRlCw6LyhSLYxg00JOZM0Uge4pEg+H1JDAUeH0pwnPd2A5VPJRgiSj02+oJ4niBP/t+7rQTGbfU0qaHQL70J53eTXwDu0c7xbiX8M1gTNv9UfRIBDi0ZCjV5prpqJ3iNRXm/oTN54g6G61nxfkn0M2R+w3KNO01NC74wEdaJHOGPKmKffNrCqtRLnNSoqpLmeMTf3L7YBarkAZ71lUOV9IwzHG6ua8eZGU5higzy0uWo1YLA0MUx+2D/Z6l25zG7gkdi/fDOBvCVwOizV5pqppuPP0tkOLFR3h10ky8oPvBezmHbep++O2jz2RqfaXnERBJ3SiKp9OkzSmyig7I7SF4lfCkve/asXBrYrIzPib2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bjg+OQ6C7HF2X/e9bJ0Cd17PF4Aio98JxVBibXXB61awrC9SCzpIaZEBoxnK?=
 =?us-ascii?Q?QC1ZTO51E1t+bVlIHXzKh2edRatoYB36GoZUOhrQ5+dtz9he7HspCfDJ/7x6?=
 =?us-ascii?Q?euVQTlR7cGJDlD7W8jzP1844WlWMo6b6rob9KIXUhWRPIxvh4sh/yVbK2qNh?=
 =?us-ascii?Q?zhZAMolfYztnCZ+nu3o3aqpnL2+cvkS1H+3+qc30qqOYJTJFNGIfx2ulBDUQ?=
 =?us-ascii?Q?5YhkV5fEqm4+wE9QzecMhk7AcZk2EOtRy49dGsnrFds9v2SMaj/CGXpdlv9P?=
 =?us-ascii?Q?kI5UQ+1PzQKp6yyFjbzEjBPA5tD4PJnvdbMLLpSYjD+zHbpJAdE1UUUQIPHe?=
 =?us-ascii?Q?/UqVMe7fTsqG5aL0/L1qvkoQ1aXwvGOf4fADps26qFDqxVw78BjXObM26knG?=
 =?us-ascii?Q?z6VWqXaz0PTVhdQztWZ0Tt3NAsHxwdtnWlxIsEdCKNrSGWM7IHE0G8v+BjiU?=
 =?us-ascii?Q?WEJ0hU+H0oCc56iqI/HFJmKPns1mq5I5bf6DkAS9Vkbg0ZcOUN3juE+XoD2p?=
 =?us-ascii?Q?sFJSDryPdMjFo/VC6ObLqJ08dpNcnsN9ctNMHO/HeCjgmIzLDRpAuOrz10yG?=
 =?us-ascii?Q?KToHXqGaKo5R2mCybQ+cPQ1xn8infl2Ntci1ToYgNf56oQVlvETC+eusbDk1?=
 =?us-ascii?Q?I+YehFbAQ7MJSH3KsvNj9DAm+pIE8yhzhVdtaOJirsNsKXNyMFO0PiUp5dZJ?=
 =?us-ascii?Q?UaAmEhWitPU63B6PqfY5Xy3LCioHrqn1uNgT4CnLeHNn/2T/zwCxZ9j+bguS?=
 =?us-ascii?Q?FFK91kwwJJdzEjhvVVIbO+Lxep780kCI1WpbPvSFRkNIFPnRfCnN925jSALb?=
 =?us-ascii?Q?HTKGRDbcbh5muzmwy8jlkD5M5RSyI1OFfldt7YfSifk6WKk5Uc4UU/gy10Tg?=
 =?us-ascii?Q?xFH47oIyqrh4IecBn7m6FA537wAydqXG2SizS/k/BhYUJ2hXEOM4XrVJpMDU?=
 =?us-ascii?Q?N9KL6AEGFpRwczbNGt7BU7NWY5YEzLqbaa3AttsBh2R01CcMjkSIygA3JkBK?=
 =?us-ascii?Q?gET5rm7gjYteK7/5A5H113SoQVKmEIWaUfe+G0iFYhabA7kXReYL62ZbQCtF?=
 =?us-ascii?Q?BCUmOHnFB10N6nu7tQhyhWuGT032OnLFGqZ3A+OBSy4wjLu4Atf62ZxqB0PI?=
 =?us-ascii?Q?jTjDN5Ps+4jsggud60qgbIfIHttLPe1uf4iTk1AJ9LXlRPpXdVJs4dygjjfU?=
 =?us-ascii?Q?ch+PtgTmKx93tj4Zufrwve7lghc+CsZ0KFUig51sj5NjfSihOP4PM4XX6CUT?=
 =?us-ascii?Q?yovRT3lIQIJhDBr3F2RAr29s6M78yN6RO4F6E5jWQ0opMKCpE8E6cwqElje5?=
 =?us-ascii?Q?VrQoqN533B8zXUENObOKfQWiZ2e83CpJt+yY75S53mxzSVD8/rmmsKB2Fe8j?=
 =?us-ascii?Q?tM1Ra/7e7FzvoK+nhFwsnAERv7WJAAQ/19JKem3uew71ezCeBiO9ZzL2CS88?=
 =?us-ascii?Q?XQ/DIT3+7DJomy/ADNWqRc9zntYH8/RP5pqbuZSLru6JgJ5i3IE1CkwGjQuW?=
 =?us-ascii?Q?p4HoE6ALyvdotP0A8Tm72r0+SVZEt14nENxrBMUzgQh1APa2Eh2lbbe29PCq?=
 =?us-ascii?Q?WZHML2r7udpi3XAl3x58ZC4irdkXCdtcgShp3U7cLbCyjb4yD09/xH71hr4O?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IOBZMygSHc4V3pGeQLovYjDYNXpAufzO1Hrr+7SbuD8va4CV822551fQV0Rj?=
 =?us-ascii?Q?QgTPgjG0uS89cmiQU1dZN7UUCV2wp3IjE2cXjJKqOsxzyuO+BBd/Vs5lms3Y?=
 =?us-ascii?Q?P/4gWlC4bQWEUsd7dMvv3TD3oaVwfyBmxRiJGZPmsomm6MgynkrVWYVqqDHc?=
 =?us-ascii?Q?fGI3esssbRYIYY9E0+Vu7dzdTC3WoayUAZEPbj9EOVDqR7CcCjCjPHqdjyVH?=
 =?us-ascii?Q?2TfHYWl2L1vza9ko7Vo6q0+3PA12ANb2eU1eJWQXaEycMkxs9IoGxgX16Dht?=
 =?us-ascii?Q?5voINR8FaiJNwEZdDB3PDToT/SirvhyWQ1JLbDhXJDlNs12foKnPCMpaK+ME?=
 =?us-ascii?Q?KNe5hHjXsKDEN2EuIFDZfMpit9wOV0CHRRw0o5oWutJu4ZHvF1QxVDKkwfiq?=
 =?us-ascii?Q?LV54KesPfIgm7lXkfgnI9lM83IBJcluJ/WL0XzNuau+UXje6GesoznGIS160?=
 =?us-ascii?Q?InjZc4n48rn7cC/gXqrD49Q1au2miVshJn7vCYO1qiXulN7VQmQZQBlKKJ3i?=
 =?us-ascii?Q?MkanA8jJCV+1zuZa6/PIIXIS5C+B29CjjiCXoOu+gLmpVvKqU/MMCUD//Owo?=
 =?us-ascii?Q?xdwjl+eIyvtKJmNG3rXQf7VTp+bfRmwpvefymKFfOz4wfKKAw6oPsWY40DO9?=
 =?us-ascii?Q?azHDEcv2Ed4GZB8/vtGY9AXz4ZmwRM8+1Nl4qarCdQIVUrs2q/ADUzlTlckE?=
 =?us-ascii?Q?CFb0iCXU4lQXOmEpoHrGpqR2ah3/tGXDRJhW20AN8b6leMzw1yvb6eeo0ZDi?=
 =?us-ascii?Q?C1BaMuFO3KJBgJntfOl1sfulbqJm/GWMU53sDEtNhSFaziuF7vi1N4ZuBPPs?=
 =?us-ascii?Q?81SycAU29qjlrV1pkyj++0m6lksXVqT0vMQx8w8Cdj3X22tcgGBtm/u+OSK2?=
 =?us-ascii?Q?t+M2ZTpfCQdGWFHks/8e1w3bkxwRs7mYyjIFnC+5ElJ2M92jnYogJ/wxIAcG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acfcaa3-5965-45e6-4a95-08db6b8534c5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:06.4200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnQp3eFDfZW1cV3sWc/iCFxbxrj9IEN7idm1q1GEBnif/8LUt7TVGPUBxDbrydvmuadI34tH0PNEzi14Jx8izw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120176
X-Proofpoint-ORIG-GUID: WaXItoCbJqspkI3w7aozadhHoYiHMjdT
X-Proofpoint-GUID: WaXItoCbJqspkI3w7aozadhHoYiHMjdT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unmap_vmas() is not used outside of the core mm code.  Move the
definition to mm/internal.h

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 4 ----
 mm/internal.h      | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 66032f0d515c..209fe13dc8a2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2302,10 +2302,6 @@ static inline void zap_vma_pages(struct vm_area_struct *vma)
 	zap_page_range_single(vma, vma->vm_start,
 			      vma->vm_end - vma->vm_start, NULL);
 }
-void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
-		struct vm_area_struct *start_vma, unsigned long start,
-		unsigned long end, bool mm_wr_locked);
-
 struct mmu_notifier_range;
 
 void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
diff --git a/mm/internal.h b/mm/internal.h
index f45f5eb4514f..9b665c4e5fc0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1099,6 +1099,10 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }
 
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
+		struct vm_area_struct *vma, unsigned long start_addr,
+		unsigned long end_addr, bool mm_wr_locked);
+
 /*
  * VMA lock generalization
  */
-- 
2.39.2

