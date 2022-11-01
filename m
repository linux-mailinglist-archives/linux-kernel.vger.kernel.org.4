Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B514E615504
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKAWcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiKAWc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:32:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992AC1D675
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:32:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M3xsF016218;
        Tue, 1 Nov 2022 22:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=OjyqufhItJZNQqVVuotec1/lf1wZzFO6juqFsw+19r8=;
 b=GvRd29NzRgmCHvAQyaEE3bG+gsBdceZke68wZ6EXOO3NbWQDxnnoxDy/AeZyXlfhg4NL
 YB4CPuBfVtFQRtGMjXz2srQKupf74ODsexrz3fyMiAYOVPrI8BK5Dr3tAwcAEOf8NyfJ
 zCoUY5zQkPcze5JtBO+LPykDv8UKQQe0M3vb9D/FULh9ZCOgh9PB0cSojLDo1nBzhWTX
 v7kw8kxUnBI0ulIFsX7TYVcLwu98Yez2CFbg1wj5I4gEsC2BrO2e/fCZMKz+q1LRdgbW
 zBMwQoF8sEuwlVHnrjDh2H3igCGTrftPjyr/x6QUAGPXCfgEdefiUAwg+q7TagOBHX1i Pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussr1wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1JkV6e014190;
        Tue, 1 Nov 2022 22:32:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmay6yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bspiOvKCVaVFrV6VPbLYkewXlYtG7jMqMWot04gIHhArBKMBpozsqtAirbn7L2o4uUzEj7MkvC4FHLPz1dEKYZtwIr1Nrgylm6aTkMowafqGVgdGTKg/CLBSZiFfKX3qPVTLfdJQufUPz9Ka4t0uB+fSBkdId5owVoteGTRLMPZfX2qzq3s1qOUv8f7cWBwOnMVudRu7SuI+msS1kfEeXPY/ICSVyh6s1asq0VN3wA2f19L2YSLdTG6DmGu42O73PIAdO3aYnoP41v3zzsAQIgBcNof0Qfz2cb1UaZLe1DH7trhqBTJoQ9pzc2xrGeCwwI0q6sVxJapMuefbYhVpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjyqufhItJZNQqVVuotec1/lf1wZzFO6juqFsw+19r8=;
 b=HtxQJCtiKgJOQRf0wsv5zUV7/1W2ZPFqvb+Lrh0Nw3/qsTgRHM3sbNMnB7jmjBA/iEv5ts41bO5TgV1zcq1r+M7lfI/N829o8SpRolhCy19wFRt/e3czB2CaZ7AWbWbk3yXrnsV/wa3rmiEIjxEVPez5xKD+DwMBL2TSUXB8C8pxxMR5xS2wS7llJA3MB03nBaSEULdie0axYjC6PBhU5wZIbmTFvnhoIrg9leNnrtvmd7ncpMBzX0QWil6dzS8CVAzKCvQd5NeO1B+iWPkvKUm1EkBnj3k6buLZ2YwIXKxFG+OcWT4jjHfppoQPsOZBwB73T1+7c2tHE8L+3FHDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjyqufhItJZNQqVVuotec1/lf1wZzFO6juqFsw+19r8=;
 b=iKRJY8UnIfsFd0+4oF3pApmhXnhUXaeawbzhDmuPqjg8rGvwDKUJxLAEcIHZWQQzMDrL7Uf5Uyn/IqQ5C+W27ukf1B/bYRx344iqtGI9SQgx09V8idDKejWqjSJ8lAj3qraC+Lcoh67kw2xDajbv+vCnF+KF8U8TktG12NZIbxY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 22:32:12 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 22:32:12 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 5/9] mm/hugetlb: convert isolate_or_dissolve_huge_page to folios
Date:   Tue,  1 Nov 2022 15:30:55 -0700
Message-Id: <20221101223059.460937-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: de5eacdc-9052-42d5-ad27-08dabc58eb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pw6oMyWlcztfsZ89m8u/7L46ahGIjJrTKpqhXEn6eFFIX+56RCQNk42lVDA83tCMao18PDO86S9AehFKTmyEBOmZsrfLXvhKlj3LUJ5cf/RzuVRPdtDU/k2/vmDZ01Jzxg7QuccvStcA+50IwiGH8//sdc4pt8oH8GJKv9kfG4pvxTcdsPspAMTVbX0aK00e6Vkqe0UWXZNZU0pZh2lnkYqP1JJ5ddutYq208SuY+tR7dtTlSxfjHHxFv7ggNgZRXGxHucFt+935HZoTAkGZFw/vD2Y0n8VoJ8xu9PEldU8BzRmxScxuBF2DL05lCE8m2vJMjVAiXooyNDpr4U9iMo83GUubY4iq450xw7dt97KsrmBoI1tvN5PWqvEa1hVObd/quvOhPyNB5p9pZS8jwt4JlVW1/VF/Fgp6p+uiSm7nbYvrFNYTM4vHv3yHEheu6zinhvHOIeO/5SZCIMnhylcYmsJ6c6CsEn1FmPIMlYa09CYwqefUktQYuGaGGUdJi243ILgichRJkteVxCC5FDX24EJyMDBgmkjKRqATdS1Bcw42jE+pa0kd1iRKH7ZHS5gaw1BL/hcf5l6RjAfYvX/6hWjzwtTHesSVVuWadBpKp0yqc3r9qFV3HQ6qksjnFWkN6lw/OH3JbUnfOTDkiC3I/4rOpVFLQP7fZplwmr3oEcQ0vLi3Jszz+qi+X1KGpsYi+Xvtgds72G5QJgbXbiA5p4cENZBVxThqr+ArzV4E6qZrYTSv5yJ7Y/yetEWwBcE4pm/fWFyj1LvCPcX4bXn+ykmPMgqwzVp19XsueGmA22BFjOhWHlyQuiAy0I1/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(38100700002)(36756003)(44832011)(6506007)(66476007)(107886003)(6666004)(2906002)(4326008)(316002)(66556008)(8676002)(6486002)(41300700001)(8936002)(66946007)(5660300002)(86362001)(83380400001)(186003)(1076003)(26005)(478600001)(6512007)(2616005)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m6qj685AkQFrKy7gs3KRI5oYqJoxoYPOTfJr+XxVHG7ZJdFSTaNkkSm5/syd?=
 =?us-ascii?Q?gPosG5Yt4QheykRuZ23YC9yUr1ZOTCUR7/NypchnQH2Di20BpQDVUNeO6WdX?=
 =?us-ascii?Q?HmXA90E26TaYqA/IVLL7auH5u37c1k1ubohtCGt5xBwirk8yUY699kG8Rd11?=
 =?us-ascii?Q?JQvWvQDaOZKNIY4/3uxCLVmqfzgFf+l8NSxy4UqE1DOo0e+LtMUR5oSxO/+S?=
 =?us-ascii?Q?laf6rXjqvWzkBjbjJFVidc9T1LfkM82cjmPmmQ1/03rJRkw949mQQZ17rulz?=
 =?us-ascii?Q?Hvb4xHs7eL1Td98UBUe6mH8Wiej9Dt+ZW8XRD/WgW9krRm3kYyvfFzIBJ2XC?=
 =?us-ascii?Q?1he+pfPd5Xd1KS1HDFZq7MJ82spsi+kp2zHPQHI7QGeaoHjjOhysIUfXQs2q?=
 =?us-ascii?Q?29i9pgeOhEyMmLjitM1VFW3WtlTNPDCCRVQPDN0G4rJP+SG5VFvd3TB3ie3D?=
 =?us-ascii?Q?6p7MQtm8ssCbV5QQae9CxrNSmaLz7Cl/kfjOhkCdXXEqLAhi13WcCEC+13x+?=
 =?us-ascii?Q?CjUVh5Xwt8ZLF7cx8T60CpOAhZHU5ejrJAzUc0lUBFd+fuwv5cQNF108eMd3?=
 =?us-ascii?Q?Np0wcKXcik65oM0tcYp/Fn0JIuWGdSHvrN9GOxo4RKKOXBn4l0SRWPonZIB4?=
 =?us-ascii?Q?hW9BOC99Li1kgPOA16QVIgDbomCtsIXgvK5bl77fDTDCcuefnKBPL+sC2VND?=
 =?us-ascii?Q?HlZ3skoa9iZssJDl2BB0fzqHLOl7uAlht0MITILMFYWFkkl/Ef4OEgG28pOg?=
 =?us-ascii?Q?XjvqhFONfGqo4v+LzThO2ZM/9+PS3VBlAA0AKjtwfcuREBdsHK1+F135DM7D?=
 =?us-ascii?Q?6L/9R/gCrvTrpidpCpbum3lS9fP4RlUBHlC/dszmitTCL4vg2KiLuApBSSTN?=
 =?us-ascii?Q?sXRfbQW94U7JZNmnUS2DRQcd5vKWOlo/FlRwBw5TqJkcLAl7/U79ciKl8sIf?=
 =?us-ascii?Q?xvi8F5cW552Kfdd4UJW34blJ2MPCm7DokvhCiNBTWsERkUjYNm7HzHTAJvOS?=
 =?us-ascii?Q?gKb/B+wxjAA09rB9x7JNtQ6HVeoegWzal7g6s+ce6p0/5Mw2ZbNHg+4P+34P?=
 =?us-ascii?Q?5/nFMTR0jkGlcpmHAjDPsCp/tJmpBzN1yfxNzQBaJlNHjDF8yPht0DAIfRz7?=
 =?us-ascii?Q?q1AJzwiyxg6DqFf4wfcoxbmrK2Na8c261lPoCa/WFWAeGcDZwhob4GrPWdlb?=
 =?us-ascii?Q?RRy+k+VhlBfdI86qczTwh5EBhpwffO9DfdWoqg1gsPS9Coe7948W2ex9lARd?=
 =?us-ascii?Q?q41NBRQ0KChPkdziJ03g0BxPA9NnIbaBdZHy3v3sDhM0GYG4npji5vsnPgCs?=
 =?us-ascii?Q?jrQ/YEOOCY0429IgRa0zxKRqIww1KCLMkg+B3wLut0R+XGydXDeBcsP8iB0o?=
 =?us-ascii?Q?jz+qxVsYNa6eHaerz9m/neGuUKZ2FjkbQaEIVTFDzTiYQYtsiXdjsP0r71Sl?=
 =?us-ascii?Q?ZKq12FJ7SWzqb/TEuEu30x6Xi3md4XtwMFSZyqHu8G20W81ug0KDhJoIYDdC?=
 =?us-ascii?Q?6YpL7KaFkN756NdFehjGFMbpDwzlC73ZCvnW5CiWbaOr4/K2q1ABnJErEjNE?=
 =?us-ascii?Q?24PVQf2gubTgW6+4J9h2LuEw5e896iZgl7c324dKjfwMKunrT/CgTvgP0WXR?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5eacdc-9052-42d5-ad27-08dabc58eb9a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:32:12.5253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSNT3zbfWhBaxnu+VLB8KOqTmLvjMGEXNQ7rE47QQFi1njedjlUF5tzmAaTV6Ja/KdJ0hBN0aSXPIMqWA7Js0Fjnw6QMcAiunqSrSsACuvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010153
X-Proofpoint-ORIG-GUID: -rUlxgouV6x5bNV-rYiiCj2VTvLnmCsg
X-Proofpoint-GUID: -rUlxgouV6x5bNV-rYiiCj2VTvLnmCsg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes a call to compound_head() by using a folio when operating on the
head page of a hugetlb compound page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2a48feadb41c..bcc39d2613b2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2815,7 +2815,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 {
 	struct hstate *h;
-	struct page *head;
+	struct folio *folio = page_folio(page);
 	int ret = -EBUSY;
 
 	/*
@@ -2824,9 +2824,8 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	 * Return success when racing as if we dissolved the page ourselves.
 	 */
 	spin_lock_irq(&hugetlb_lock);
-	if (PageHuge(page)) {
-		head = compound_head(page);
-		h = page_hstate(head);
+	if (folio_test_hugetlb(folio)) {
+		h = folio_hstate(folio);
 	} else {
 		spin_unlock_irq(&hugetlb_lock);
 		return 0;
@@ -2841,10 +2840,10 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	if (page_count(head) && !isolate_hugetlb(head, list))
+	if (folio_ref_count(folio) && !isolate_hugetlb(&folio->page, list))
 		ret = 0;
-	else if (!page_count(head))
-		ret = alloc_and_dissolve_huge_page(h, head, list);
+	else if (!folio_ref_count(folio))
+		ret = alloc_and_dissolve_huge_page(h, &folio->page, list);
 
 	return ret;
 }
-- 
2.31.1

