Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEFF5FE77C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJNDQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJNDPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:15:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E33DBE9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:15:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E1TqPq026262;
        Fri, 14 Oct 2022 03:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=acRyPjuqLPSR4zKveinzMUspL/hbEcXs3/pnXWlB/7k=;
 b=QYjxsLER206aFIgr0nV9f5qTYEAn71KjFuAR8NwXHIClLM5DokM6h84IxWFoh428lz/N
 Uz4V+kaV358N2l874XKSivZnx9RtGOHa06X3AWPL3qtI+Sxx8Oc1NjiMOj1C25C8Dzs7
 ntCBmWYBs3fmnljRR3FfsSqdJ91ejBIs3Cd0x2waUrvzQpQ/CzPFH7nyQPioPxNQHpr6
 ZEl6CwroL41Wov9zRKWifd8CVlrn2eM+I2RvNJiINqQX4qxGFyMFUuxf8kt+CT0Ji6wd
 0gL7I4JHqMVqifR0zjiTYIu5yzeWkZXTb/Z5cWyVs2pHwnqFVJin8e0zOmjskdiGbvNn qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6kgmsv89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29DNTev3009827;
        Fri, 14 Oct 2022 03:14:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynddbsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ai3wZxgUXeUmyRm0GRC+Z9C1tZLnRF4BQCcAaMa0vyC1f3YWsHUkS3kcJYntO4y4LlxCcxL0ygClgq24cJKqe5QwVKwDLHWP3tOC4Nnclum6tu3cOrTdjzkJGKes7RsoOAvjFFX09K3hDsG79nSwTJ3J4TfPBQ7jBGUGTWpnlTjcw++QihAY5aRF85a4JviOB++DnzAVALSC8TOJFloHNF2vu19sFdM7zZogM8NYIzbjyaZiEdZiwjzfkdywvK5FYn1qH3bXgct5wHxDgeSFQGDZ+J2gZaKq5ZFuCYAkTI3G6JfJf0fn6CeNdfvSAw53aSdCSKxRy0oaaJHfMOcBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acRyPjuqLPSR4zKveinzMUspL/hbEcXs3/pnXWlB/7k=;
 b=gHWE14+94/b4If9BrrDk9XdCjrHGBL7ROR2fj32/SedXQshnAo29ptd30tNhzwzexKOPrY/pvwhZnhCs0IDb9HcuONRQBOBXGXH+a7PLpG39wjX5oHoGJXAhGQyCjvnpdYvD6sY3FIZVsx2RjjdTC+cEwHK5uyTxVGsUCokbMzYTPiWmztDShx2NzUxjwdXEBitkIvTbJj0CpyVJbNwEmIB7Et2+BxGOyVXPDok3hdcjZ2u0YG+bHmBehP9gWiOYlxxdz6JUDS2N/VM4+lBK2DmrIGIMHOPrp97cm0LRMXKP1HVPbpn6HKkzeJje63RuS3cWS96Q65HtigxZ6v2sRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acRyPjuqLPSR4zKveinzMUspL/hbEcXs3/pnXWlB/7k=;
 b=p+pF0e3pOtoaaL1kQBdq+3pZ+Zvnd9+U9mqalLRe/ZlAtp7MCM0+34Ke+bnDilEm0MNQAxXgHLGE9glE+hMxvHZT7DU/qXzNMjfoSzwIS3DUp3+L8jsAMh1RGtaBb/KD9OjCUuEXT1gK2T5qi57LVyzML923KIZ1PwgYN3UhdzI=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS0PR10MB6750.namprd10.prod.outlook.com (2603:10b6:8:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Fri, 14 Oct
 2022 03:14:51 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8%3]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:14:50 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 8/9] mm/hugeltb_cgroup: convert hugetlb_cgroup_commit_charge*() to folios
Date:   Thu, 13 Oct 2022 20:13:02 -0700
Message-Id: <20221014031303.231740-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS0PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e93baa6-74f0-48f2-2e05-08daad924164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6D0IsgLhrJughfin1Wu73W9us5lUi3Oq1m9J1iOedOv9qu4sYIiboFa088DBsJTwXu87gS3XDF/uOYeEVdLdYCdf7yDqZsOFZ7vvsc2kVf6CepVoDRqylpTmn7UBzetdOgJ+fHVgIpMqnVGFZ48cc0Pl92TeOCAAbrgI5DxVGecWVXbzM/sB9ga3NISpv1EPU9Qjw9hRnEchPb29vZcU/Gw40HsddJoqms8qDEDsHDxyephzFnjdo2bd9UjKJOV+wfZ9VPag64MI7XfSCNRCUyfjRdkXv1gmthcoKTJs2wlxSgdv1L70IoZQmUa0mtGHh+HJMrhB9s1FMMOvCiCcNVNgarG7KeDIWFQd/CVmTQ8TD/AHP+sM/eoWZak/4K5PKh/E1mr9dzTx5i7tZ5JpOKbUBYhFRfcgIEAErWytDkVQm487hjnjBCBo6ZFoAAn+XPE8Q2rMZWr7HWOr+oJ+buSf4JgTE4nGuiUM1/h5ZHqF2i/ta35TxIiEmq3cClVyrF/fsnil5abEgFmqyIu3te79wEhqf3oE+4FNkSLU0oGE+DCeh2O3WFJYLsuOgMRxcC/S1JA8y2yDgpUqs/z8E/mVVeGEJAwRuaJbyDjhZ7H7dKJNhmEsPS0xxUAAeQ9oW0IlvOiRPE5ZvoJqGPI1F60FIQXWZoMo32rTdLa2nRDFc2S6Jn7gNKpxG8a85mFGDgu2r7HnO6tn8V8IF19/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(83380400001)(2906002)(86362001)(26005)(6512007)(38100700002)(316002)(478600001)(186003)(41300700001)(8676002)(6486002)(44832011)(4326008)(5660300002)(66476007)(1076003)(2616005)(107886003)(66946007)(66556008)(36756003)(6506007)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4gHWK9DhOCbYgkDfP5mt0FYRQ7peUrlA7auNQ+Cv1TnA4UKRgZhpLCr3Qwk2?=
 =?us-ascii?Q?NZxYslBlHQvu9rD7kO7nWOFEFSg58ndZwq3c8kqxVrc7StIOorB/6IAU6y4l?=
 =?us-ascii?Q?pY1gqQf02d6ztdfdyCreLfWQDc7b93k+6G41e4VUKAH6FhJC12ys/DpJAPPz?=
 =?us-ascii?Q?ifr/+KbUBwOyIPJNhWdvUTV0gwgmIMUQCxB5dJ8PRedkbiLhtl4Ztx6We/f+?=
 =?us-ascii?Q?dWRm9L3BYJ9wFU68N0x3fSk5aQ8dPY8bJhzGSn0Qzj4KyEUGz89Ywg8GRu1N?=
 =?us-ascii?Q?LYn9yyCMmTmlyi5I+1e3RoopefLkS24jt74Co7HZugbMV5oEtJz1dQb+P38i?=
 =?us-ascii?Q?nB9gKhs4HOc6Jpqd7LZjU7oxV5Np7j6wDVlaagbto1WwFaLPlS6m0+4/qEvo?=
 =?us-ascii?Q?ayTIF6TBIVb5hrrh6+/2b+pyTlQRMaf7MJlx2W8hcqa7jJz3j/vo/FSHsgQr?=
 =?us-ascii?Q?XENPAIFcN7sRWy3R7pFvRfNAbDhXY34+gf574+oRhSNaoDHI2b8nvd9OFOvc?=
 =?us-ascii?Q?6YX9XyYJ+L4Lyhebby4rgkaxK3M9u/KadK8it++npr1zNQntINhNezGB7051?=
 =?us-ascii?Q?QpVVWE0vIBHlrarDJM5rWSSDW35/uDgGgmY3mBo0YgPqW/rCDTW3KTOcRkBP?=
 =?us-ascii?Q?PaZGn7w4d+/d1HZ4bJrED43yQOsfFLYoLDVEecxBZPsAd8jdzGpV5snuJ5F8?=
 =?us-ascii?Q?BdyzpbaPRziDJrG5FnRoh45scTq9IcUGV73MgbGuGrm9glQq4WnN0ZXPhYwq?=
 =?us-ascii?Q?aAWoEDAr1Jy54mdGnGiNTCJnfa4lAo6+HBwSrbQnTmS9YfV2bVIShF4tHUKI?=
 =?us-ascii?Q?u1nHpYVew8P4r5dQCyAbof1hIcR8cLNxfyUjZCs7OnDeYB+CIy8moCQkRV8f?=
 =?us-ascii?Q?JrDD6rUQcm2FgB4MdrR/zU3E27+125EY58dSGq2Yc2h7LS5/jtPp7cVBmzYB?=
 =?us-ascii?Q?4WoIqFE+q0jX2WBE7XodCwVxLGylm+0VE19uCnj+qspxcYBuY/LGpbug+e41?=
 =?us-ascii?Q?TdNnGoTZCvY+U3C/5s243ToYF6L3LrEYlZ4JE1+q9QPDQSIhY5Y/iF/dRaF6?=
 =?us-ascii?Q?YUpP8oV2GIsDCJpV5U4ewLXXWkCpEy+xraP9I46QBJ9BX5fwBaUjJznGpX4I?=
 =?us-ascii?Q?NtgCMEczIyyHYFNaAuI/TEdz3SA5mwMIQfhdnzz7bN/WPK+tWSV81MwZ5Y4Z?=
 =?us-ascii?Q?oZRiklbQzpWLkhTiAq712bYvaz0CAGZOEDwojJK9bEkaSQs7QHGjqVIhnc+Q?=
 =?us-ascii?Q?Ff7daoNdTMBqMpzoxtOEXjHyyOrlEa154WGNTDC695DyZpv9ksFJomg+43rI?=
 =?us-ascii?Q?mco1+gKijKHvk6weiHV+ZPg94uvzpi7eRoX8rSFnEl6abXYhMuP9ycX6zd1J?=
 =?us-ascii?Q?D/FrRmiRRqTEC749e5xuenbQelUUqEwV4fFY9nWvayR2xPth3JuIR2dFbbdH?=
 =?us-ascii?Q?zeg6ST5msmuZ3agHZYK/8Bm9IaqduUgq5pRArwncjZyj8h8vAMLbFpUEQ7pz?=
 =?us-ascii?Q?27t7JAPkYrvtAS3pFgsn8sMmik5xeTQTpww/69EYPVfIKLAWFCaOnjLxapty?=
 =?us-ascii?Q?OfdeaqW4xKNIU6JxdnsDlEHVefkaoqgNuwtLsDU3DpP2LqFhnR4i3H/JuONx?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e93baa6-74f0-48f2-2e05-08daad924164
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:14:50.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+4T3B6El7tpAgQ6U42mUqSB89p1WXALF9bXAsElcOi9p6UC24Yd9e9nh0eU5mWTuXQQg3WN8Nd61BigE6EAhpru4dGeGjeLna15dXiCI1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140017
X-Proofpoint-ORIG-GUID: pPwva1lBgqkQBwVpuC9D3uMQufBsCTjB
X-Proofpoint-GUID: pPwva1lBgqkQBwVpuC9D3uMQufBsCTjB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert hugetlb_cgroup_commit_charge*() to internally use folios to clean
up the code after __set_hugetlb_cgroup() was changed to take a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb_cgroup.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 7793401acc12..69939c233f4f 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -313,21 +313,21 @@ int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
 /* Should be called with hugetlb_lock held */
 static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					   struct hugetlb_cgroup *h_cg,
-					   struct page *page, bool rsvd)
+					   struct folio *folio, bool rsvd)
 {
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
 
-	__set_hugetlb_cgroup(page_folio(page), h_cg, rsvd);
+	__set_hugetlb_cgroup(folio, h_cg, rsvd);
 	if (!rsvd) {
 		unsigned long usage =
-			h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
+			h_cg->nodeinfo[folio_nid(folio)]->usage[idx];
 		/*
 		 * This write is not atomic due to fetching usage and writing
 		 * to it, but that's fine because we call this with
 		 * hugetlb_lock held anyway.
 		 */
-		WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx],
+		WRITE_ONCE(h_cg->nodeinfo[folio_nid(folio)]->usage[idx],
 			   usage + nr_pages);
 	}
 }
@@ -336,14 +336,18 @@ void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 				  struct hugetlb_cgroup *h_cg,
 				  struct page *page)
 {
-	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, page, false);
+	struct folio *folio = page_folio(page);
+
+	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, false);
 }
 
 void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 				       struct hugetlb_cgroup *h_cg,
 				       struct page *page)
 {
-	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, page, true);
+	struct folio *folio = page_folio(page);
+
+	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, true);
 }
 
 /*
-- 
2.31.1

