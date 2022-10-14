Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3625FE775
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJNDO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiJNDN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:13:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0AB5F7CF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:13:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E1Txkf026322;
        Fri, 14 Oct 2022 03:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/ecZZqbF1xzPcqYuCvFEI6guW/DtEAVXatJHoDqN5qw=;
 b=SM1cJ5jm9wlvT7sSxkI8ePH5XilUFMHpqGD41b1M0uMR1MmpqxV3Al1Cera2zgsJNclf
 MfJnT1ZMb/EP240L1Ygh4vR3bVu4xw+S0/GG16wjdXM0ai8DTkjYPlzt0dXNDJsqs5io
 4Z/t/K0F7MxKrC3usjLZc5aBd1uaZEHD5l+bPNV71Wvcp0J18CzELQxkRjc2Wkajm8Zd
 6Vnpe9AlSTT6NHgLrV6kZD+fHhe945ibcpLwt0ShdtirOeXSb4cbCTStK49CoeBXeZGj
 tunFT6nRZGat08SaBhK/uZ5C1wLuOPWn74FvjUK01P9uvubQcFs5hwsYv3iOIdG3ESf4 7g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6kgmsv76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:13:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E2fbtg017587;
        Fri, 14 Oct 2022 03:13:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn71658-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ0GgOYTromkX2SCyKCFL6D6IUCKlDOVy9Opad+NReyfOwrObBmoejwyTEQC2GxVZAIvDuNtHDQw564Ax1KGqQMP87qb/1XVXRKyQagb7wQx5C9TzyItZDU2gqkfaVw/bH2MkI+XBLAcxxi2bMFIBt6ejUR/t9GYJKGipYUDfP56X8aGVPOK/FgalIvb5cgG+17P8uXcBsH9yEpR5XXVSaPwWFLaz7mk6cfpS3NU2UrQBywvmikCxgtbIlWaE6xEFfoNt/XqKLd3EPLBM5xhdpJm0EZbzBuYt4mYmD3xkUHNE2we5hPtvW38YjZ79j2KQPCvKIbaS4Wn7+K2SyQ2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ecZZqbF1xzPcqYuCvFEI6guW/DtEAVXatJHoDqN5qw=;
 b=mK82J92kn2kTrGZagcfKiVbl5YKcemuZTMtUqoxhAUxtZW4UMwJGsxd1yGURp3nOF0GWzUr0rOo3nykbn963KnrmVEWTZ+gcrC/c1AAXLSnoZWM85eKxwnykqSjF4zltF6LmD6bYGevG2329zfLG35wLwpylxRcARCcws5cqGlR/cyr8rAr8d4Kr1mRlhE/D8wMFmhQ4LTpr5OuYoVLpVoGNKH9AUfPrvaaKJ2B1H3sLqkN8WfmkGRtg6NH/LOpYz/p180CQRZ/Nah16T/QQ+rVi1+AdvgLVQ6jo9YTe6l96QRbKRudAIFhOLDPosiLZetD2Lkbkp/+ly8mrT3x+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ecZZqbF1xzPcqYuCvFEI6guW/DtEAVXatJHoDqN5qw=;
 b=WepxlrKuunNDAlX+/ZQizwmhBkBORJjuBrxA+BjfI+kbimCfUcSCIgEeMEXixxzmiwEGRU8SSysoF/9kxtR69Jv90fBomhuXZWxNkVxJI+ihNrLjKgSEWk/u8R79+zJN9t/f7HOoeEYwlo53AAKbyvzoP3XaT8vbiIR/H8gtH6U=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 03:13:40 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8%3]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:13:39 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 1/9] mm/hugetlb_cgroup: convert __set_hugetlb_cgroup() to folios
Date:   Thu, 13 Oct 2022 20:12:55 -0700
Message-Id: <20221014031303.231740-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6527f4-dc10-4b9e-55c3-08daad92175f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6MvUdOWb/7tPEo8k9n2GM9FqSwYkcBlUr6Kclffek+wI/zerZRg+/JPzqTmpDTkM1NtDoL1arB4CqE0Tpcd0wksNUKjQcuGOVdnZQdUdIIMLeVQcUl7N25oEyYzDtkfB4sSmRFGgV2YvHcBHdCyltZjzhdZ+efbtOSW7RT0AMW/k1b2yX1owfXg+X86NIT8JxRePlREvyBMe2VpT4u2QawZnosFOTD9eKfP3ahttoNDz7c54G7mPt7Iun8SYM6qmys+pNxFO9PHlp43SdnY+tuDm4ZsHzBe/seQLL8XIwvMsls7fxQjS5m6cXSDhKX6P2u/8K24UQrtvu87DUv0joPUvjQJhFMOe8G9Kz9IMZehZqzFWorwz1eCNKDGZ5y7J3RPloAtu0djlAYh0mQ1LfNKRIcLo9m8/4zOgS3NAl5dGFR+eiPWtTfjDWVmzJsI5vjrHkFxnLsPTh5gBOycfTvao5Lp2Gk6H1eCCi/O0RzJExdWW5WszYw2DgoCTuDxtylmoX1Ike/2yrRw5qXWE+8Q/icxMxROZHt5JvnSciFeUuPG1AHslfkRvQBIsRzyc9cFsF45scK53jllZvJuSe8YrmWaB8owhsVuaVNiEkcmsuWBHsJlYUQu79Rquqlj05UXmQZqcQb4rqz/JQkAblpZBiRv7sb9xJFD5Gk8gxv6+2ekvLW5+EJRunC1PPKktu9aG5kWl2GRbeSxkYHhbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(478600001)(6486002)(8936002)(66556008)(66476007)(41300700001)(6512007)(5660300002)(26005)(36756003)(2906002)(4326008)(8676002)(66946007)(83380400001)(44832011)(316002)(38100700002)(6506007)(86362001)(2616005)(186003)(6666004)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5maBpsnqwsu6LZfrt4CdqJbeaqz7QeP/1SiUVcFqc/2UDma01rdMq7L8pYR?=
 =?us-ascii?Q?jMRQunHVf/atVyahcFqMW7bUnWgCWrrAAtE5b6VVMrqBGeaIFdqdoG2iWB6J?=
 =?us-ascii?Q?LDkg/Z14KzCABDoz/f3kVyMgVmCaV7yN67NjhZxPfRmsXq/s4SBx9jAjQVKa?=
 =?us-ascii?Q?yPRGMeCIZMC5JmKXYJl1I94eKuz/EeMo6S0FnEdsISmyKq6HnbNEcmlR0fn1?=
 =?us-ascii?Q?7ItjjsZX9Qa6RFAYagdi+VYWhw9XWofWRgeHBlyaHOSLOJdsLlnWzAO1tH3M?=
 =?us-ascii?Q?9OfWdEzfH5MChWWw/P/mb7GG7zilauHTAXAf4N8qWCB7ZcDdoPJPy/3me9Fz?=
 =?us-ascii?Q?gOm4t1/0g3t95zVIk/JaiqOXhEzk2Rny3JWWjtGgWE3T5iIpcmXYJxbuYdHB?=
 =?us-ascii?Q?xpQ4bh3lXMzjOUfwkh+RnXbUPHD0ce2kc/xyQodTGDE3iwPjwl6oUUQGk3Up?=
 =?us-ascii?Q?T/IXpONQ9CKsaTho5QQcRAvghbBaYsFfRaPfKoNLXmGNahiQyzEh00WStYuQ?=
 =?us-ascii?Q?um3XdPhh2zx69ycabP//vn7r1kIEbnOA4GIi5l4WRrxLxb/Gi9YZ2ZB2k3x2?=
 =?us-ascii?Q?qF7g5cdFWODRW+CHo+ZiyhgHPlzDO4cu4mtyzIz6abzwGx+3QUVAlL97vKuR?=
 =?us-ascii?Q?XCV/Eq/0EJhnA2Js3HnW3QkPV2rad1BJOYuH2TYyJ/uACb6/JBgHImrzLEF0?=
 =?us-ascii?Q?gTzanaylQDUgtP6CLTbsg5/34VL3V3nfFzoTLrtRuNWjcsnoDwqmq0UydB75?=
 =?us-ascii?Q?DIAgnK9XP+XmLH3J/hgs/LfdfzECtII4SNQqyimbV9CUQvQo6DY84ZEYfZu4?=
 =?us-ascii?Q?EGtHDyiarmC430+nLdAbDjeqazAUIG9EBISEyZ+0Ft50rt+5LLLbBrHanjZO?=
 =?us-ascii?Q?cDKDEhUxIs5AgfEyPK+d2FRGlC70IJ11YVl0tJypkdNAEr89qMTgZo3Kl1nl?=
 =?us-ascii?Q?Pb9FpFwx6SyvS1aA+4js8iedmZMua2dUOwTFogxRE0XwaAOJiyFMgVTY5Olw?=
 =?us-ascii?Q?yDgEYi/xMOhCEt49gfKlCfItV0Cjk/X4e1CnYYCh+oFHb0UeP6TkFWLqLe5j?=
 =?us-ascii?Q?X3cPdB0hImJp7ps14V1bdb+FT17GqnPulmFzYqKKPHmmL5Nb4tJwY0LzHsB2?=
 =?us-ascii?Q?qum6fJonpbYVj+SiyQno7ESuw4NCcHGq+KIkTQgxZFTQ16L2jYuhlBf7ImA6?=
 =?us-ascii?Q?dGvc+qiYO9AQSn35f6JLq7khxk5uk7N5ZiXifRYrdoSBiZUAjLbmdWh47s3b?=
 =?us-ascii?Q?XZ9e3kAK8vbbjK43v61NusFC9/+qbPVni//b3iuxBaBRLfs61xZ5Z+IOonaa?=
 =?us-ascii?Q?tOsfhEkH194umyROTov+1PVCANQEGKaRGGoEKt1aTobbWuA++PP+fQ5Jx4n7?=
 =?us-ascii?Q?Vat/X7YlNw1OF8Vu+pVu8rRd6liADZ2h4YVOvRiuA7bF1VhA0rnPneGHGixa?=
 =?us-ascii?Q?f83fUmQQk1CNiD8Mmr5mLWVaia6H4/ShomUB0mfzk0eJ6l57fIxRm0+ein5X?=
 =?us-ascii?Q?be6mudpD5MCqXSdmz7KURjS+H5TkSpCD2HAwnzk7o8UbhjesvJiRQWnLbO5R?=
 =?us-ascii?Q?MT/rjSo/X2iUdPG2StYsHieU8Q6yvG/oZL57YQRM+zE7ZT/EEq2+EWoPjPZZ?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6527f4-dc10-4b9e-55c3-08daad92175f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:13:39.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5+5rgtEhhFwdglgSfZd2vo/wipHUO7UkfIIb1W9zEtLycFpcNfUpTpQUw9+1aUvjEEDZGfuAWDGhDVbdARNXwUN4cfcBK0Cor7yXn7fGBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140017
X-Proofpoint-ORIG-GUID: TCL30Dq5anAP7kFUCiHMkhxv5C36wRiW
X-Proofpoint-GUID: TCL30Dq5anAP7kFUCiHMkhxv5C36wRiW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change __set_hugetlb_cgroup() to use folios so it is explicit that the
function operates on a head page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb_cgroup.h | 14 +++++++-------
 mm/hugetlb_cgroup.c            |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 630cd255d0cf..7576e9ed8afe 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -90,31 +90,31 @@ hugetlb_cgroup_from_page_rsvd(struct page *page)
 	return __hugetlb_cgroup_from_page(page, true);
 }
 
-static inline void __set_hugetlb_cgroup(struct page *page,
+static inline void __set_hugetlb_cgroup(struct folio *folio,
 				       struct hugetlb_cgroup *h_cg, bool rsvd)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 
-	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
+	if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
 		return;
 	if (rsvd)
-		set_page_private(page + SUBPAGE_INDEX_CGROUP_RSVD,
+		set_page_private(folio_page(folio, SUBPAGE_INDEX_CGROUP_RSVD),
 				 (unsigned long)h_cg);
 	else
-		set_page_private(page + SUBPAGE_INDEX_CGROUP,
+		set_page_private(folio_page(folio, SUBPAGE_INDEX_CGROUP),
 				 (unsigned long)h_cg);
 }
 
 static inline void set_hugetlb_cgroup(struct page *page,
 				     struct hugetlb_cgroup *h_cg)
 {
-	__set_hugetlb_cgroup(page, h_cg, false);
+	__set_hugetlb_cgroup(page_folio(page), h_cg, false);
 }
 
 static inline void set_hugetlb_cgroup_rsvd(struct page *page,
 					  struct hugetlb_cgroup *h_cg)
 {
-	__set_hugetlb_cgroup(page, h_cg, true);
+	__set_hugetlb_cgroup(page_folio(page), h_cg, true);
 }
 
 static inline bool hugetlb_cgroup_disabled(void)
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index c86691c431fd..81675f8f44e9 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -317,7 +317,7 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
 
-	__set_hugetlb_cgroup(page, h_cg, rsvd);
+	__set_hugetlb_cgroup(page_folio(page), h_cg, rsvd);
 	if (!rsvd) {
 		unsigned long usage =
 			h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
@@ -359,7 +359,7 @@ static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 	h_cg = __hugetlb_cgroup_from_page(page, rsvd);
 	if (unlikely(!h_cg))
 		return;
-	__set_hugetlb_cgroup(page, NULL, rsvd);
+	__set_hugetlb_cgroup(page_folio(page), NULL, rsvd);
 
 	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
 								   rsvd),
-- 
2.31.1

