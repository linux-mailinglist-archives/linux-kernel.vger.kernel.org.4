Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35B374A3EA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjGFSwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGFSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:52:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D8A1BE9;
        Thu,  6 Jul 2023 11:52:10 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366IdcCr027403;
        Thu, 6 Jul 2023 18:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=DZnQHo+Hp65ownHO2EhSfIPPYyQxpX7h9cK+MbPZGIY=;
 b=pZUTf253mk40BFiR2uMxRRCmuJg36zWgpSlgroMzU36N9zAK+Fbl0XcSRmhVNSGPIUar
 zocxbmQ9K3dCvJZyR/sAdt4N3JWhxcUD1clvzBakv+QKHhrD5/EPIXsz0W5SG1YE46ti
 fNsl9UlNOp9IPRvFyhG5Api75VckxV12cjNk5h2Se2bUUANgoiEpcjbDJ9jVrTd3jNNL
 cD2b0+AYZqzO82UJe3/I16gJTucjmyMXxDwn648NpaASLHSgQCaxiEEooLloU+4FS8cp
 hKrJJ1DAdLbcdprBZD/NcWlZymMgwAJ9WbKdou4dvt+Gx1lhr3MhHgFjLvHKW8SQVArr yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp336r0r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 18:52:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366I9vwP007164;
        Thu, 6 Jul 2023 18:52:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakdednk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 18:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPEE1jlOBQJtxwJOfJ5t5c2pO2FeYQTdUDrZ6Upgmvw8U6WRKW8kKY2ZsVO2d0XVXIHqpam5QvYDmPwad+FRLSNC1Gy6UfhUKMXascrjzYNZWY8UwsAzWvaPMN4yoS33pOCROqcnPE3Tq6sNv6TC2AmiucyUOuKlejpnBSfyYjR88RE9DgLUdXoS7l2z59QktYBjT3R9lU5XXHOLulhPV37dMG7V5hG1tBwOiLt/9CDvUfWurRnWhTzcIONqBWb8XvKOYyXwslfTven4jldvK7pztztYc/H2yHrVGdW/J87iVhJH3p0mH38BpVnML5DTxYkpCROTaTGWx38yhRj0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZnQHo+Hp65ownHO2EhSfIPPYyQxpX7h9cK+MbPZGIY=;
 b=T0+kwhQIs/d9kA+QCmMk02P6tAhFyTSVmWON8dUrtadMmyQCtl6lRTc2vBpBVkB0qHiRrAQ4WKBoJ6oLnN+WNgwR/6VQUk6Y70TgrKPotLCPIergilpc+0dDA+o/yJSkb2EGQyk5ryTiK7YeXc2YHBaK15kVH28YsO7u9eCqwoRqXk48BnZsZS6DjP1ZYXtLvrAkeX42dR9Wpb5xAYFPZc41ojQ/pCnP9iF+SKliNodOs25M5NEfvC1UxXmbE7/TpMeYXPqmVRfH58DK+RHN7wQsOf1N/xXEEepcBoNfjmXB6vG4kn2uCiZRt50hJnege9ssdNOio+Xs35ZlJ0JyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZnQHo+Hp65ownHO2EhSfIPPYyQxpX7h9cK+MbPZGIY=;
 b=aU7ibRxauEFSU6pQQTC7k62OyK+OhfiP9WQkkRz0PdzGMNRSLyXw5R+WkGrRq8BVHzuznS3TKboZjFlEj1ZPYOgx7OSD0Nkob7cdqu9RE9tIfIS8qdStaBM6luoWHw0amhAsmjVL2vTbKU4WcoAeCARtyJ3jvYN1O+5+c5PV+14=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4421.namprd10.prod.outlook.com (2603:10b6:510:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 18:51:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 18:51:57 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        John Hsu <John.Hsu@mediatek.com>, stable@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH stable v6.1] mm/mmap: Fix extra maple tree write
Date:   Thu,  6 Jul 2023 14:51:35 -0400
Message-Id: <20230706185135.2235532-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0333.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f062cf8-ce64-4d39-f5f1-08db7e5212d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3aSikSrtYxnC0oPt5aALb86+DKr/94+eSUpOJRtVRZXgYxh+9a/v6p0XD4Ct5rq7lG18CDZHcTO3zug5fXxLndgZxrHgnZ0J3cmDQi5RKiylBl4BZ+BaF3Z/GITzw67c3ttcWU7qhDouafJrHGWrcK0ie9y5HTnMKngtF+Jj+J1GK/TBKGqrEkjkin7VwWAahyrC0JQm2mdqbPQJZk1xrymXVb5QQLR6U7R0E2SUkEsAXkXKgZ3bGpjusfZfb40zfznGSYjwiFBKhtnIYa3PmxJJ5Nh5/ATXqtRHRHsUHc0S2OhlEk3Gc2RdH/GR+LbU1ayeCLe1c00sgMxdFDTm5wU74ibljuwlNVvE62HgXr+C9ueaqyuq0BN9DkrOLYQjniaLpsyIpVxuYRomMP578Tr5b1nw8qx03AJkmhJbkvtlYO3FBJsntPPlZnAKeQu7idtKpXQ50EWoVDLZNP4tELV9Nyr4r4qzj/5NFLwXR6G9MiszJPs98mg3ubmc9sLhq2SON+MmTnsnMYD5bd66msEo83XMkyfG9Vk1Sg/A9so=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(38100700002)(66476007)(6916009)(4326008)(66556008)(66946007)(2616005)(186003)(86362001)(6486002)(36756003)(6666004)(966005)(6512007)(478600001)(1076003)(54906003)(26005)(6506007)(8676002)(8936002)(5660300002)(2906002)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/IRNGH6xKn0BwZOhzIYn4TGt66F4q5NIRVpRvG9VkLCZNELR9HixrkVDbO8?=
 =?us-ascii?Q?JYMUPEHcFrKj2pIzZZP0wASQOmJdwaR7Esa6CQzpwXHdUMYehN9KvhCQqaJH?=
 =?us-ascii?Q?iH5/hNoTRGgyHAtqN7ycKcfqGH6Nv0YApMKfvjbcgahJx6T9JfgU0EgUHb4w?=
 =?us-ascii?Q?gT6kyEolbAgkFwkGg6ubFgGmwyWxue1USvhdJuZ/RqNfVS8eTr77SA5cZdbQ?=
 =?us-ascii?Q?TJv3JNQRid07g0Nm8ZqGLLBSlZVphnMysajb9NcBgrggMeymyvW6h8F42QKZ?=
 =?us-ascii?Q?8ueiUxWP+zdMglYzSraVFPzvc8gArE4wx1yUDTVx9KiVI3n9ARJcQO+9vE2G?=
 =?us-ascii?Q?7OavBM+o3zHtDB+0DBZ6BprHEYA59bq2ED2KpCg/DdgZQvVm00Vj0lDUjNh0?=
 =?us-ascii?Q?y2cBOEEqNg41N4JbCpXWTRiMnZWoD8wzWC/GbKJ7ZJAFJomCL0h0RnE8lblt?=
 =?us-ascii?Q?Lf59xje4ytWafAc2rrCV+Pm8IWLSpNpfy+0TygA0rnfi9zawglTgg5unet9I?=
 =?us-ascii?Q?UN7v3M5KCjYBt8ay4TPArlTzSrWFtHlmGL23aPAv6lPzG3PEuD+obT05Ht4J?=
 =?us-ascii?Q?in5U9LMLNHVO1E311ZtWuMz7OpyXll2l3ENAbHkco4qnN919jXDlmITW3t+h?=
 =?us-ascii?Q?NN3oyw5bSU03mq8PxF7vKykuyveNIrfxi+QdM9M8JdZO6+FKACs4WyEDX8xd?=
 =?us-ascii?Q?RuDmRJg/jxfNS6FWSK3X6pBFoGv/WQLTNyftl1+Agk0YELHZkTws7eGguer+?=
 =?us-ascii?Q?UGMRAipFKhG/zvYkUkFBXlYUry0KNWD4aU4BZ0wNeV7R2y6qe2XNu2Iai41Q?=
 =?us-ascii?Q?ooPIIvbGTYupDS1nCxEYH9uBXl8OykczNno2qJ6LqPtr6Ju82YvF6Uw2S9oe?=
 =?us-ascii?Q?ejcLLb1U1lWx1gva1wjrgMvtvhtMXvOJ/Dddq2Xmccls+zA7iuj9wnH12ljn?=
 =?us-ascii?Q?6R6zVRhQiyUJeUFlE2VXijSHtT3WpHkK/gZUPfbIOye6Uttj1HaDzTSzVYEd?=
 =?us-ascii?Q?N6wB7+FJr6kpxBtDEtHlGXf3foam30Rt6HFc3icw5I9WvoTCUB9FZj9JYx10?=
 =?us-ascii?Q?D3fd3/s9LnwU/PJorU6CfFW7vzKehwaoAcO8uh8iQr4KgZE7zqNxZnw3rVUL?=
 =?us-ascii?Q?kV0a6akEhsyPPhPdUpHnMP2bvyXawL7XNtuj676rZmy5W39xQd6RgTSlmlrf?=
 =?us-ascii?Q?Iq4BWO6INnC2D8LRQohqHdYR2OJZ/CAA+vaeCDJwX+lsbzoU2Qo6z69gM1Jr?=
 =?us-ascii?Q?016EzGXCm2jPYUkH9Lwg2zRMANwNYhh3HIu2/s9Pd65JIldpPlb4qMbITodj?=
 =?us-ascii?Q?G0V31Y7+sYrMKDS3JmXPRijTxsdHOPayrXGv11HU7GRP7ORquGg3wqsFkhpe?=
 =?us-ascii?Q?3SlxV8HbvCTZxevfjUy2XuWAW0g6iqC7m2ZELBXjwHIlJwb3VDGndoRQCt4H?=
 =?us-ascii?Q?jhszwOW1PaSATVJR/O3G2ivehdCFYud0Ez1NuxXiVTLenATu23iEHEe8fhMM?=
 =?us-ascii?Q?UjzaH3VHaDzujFIyC9wJqS4QTWmYTcS2lIwi7nVQ/y7LS1KjlO493FwVxTfz?=
 =?us-ascii?Q?yeJ1qTNteNwHRlPsg/pkW9vGmhnEyZ6XkKNEqEObVE3irZQdLsIkPu5pWbbk?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5solJkWGKsfJJD9j+0cN2+5RhSnelQBk9PHYWA0IGaoAvTArOG73PlvkK6o1RZmq3zZgv3+o8z3jm6WKQ7Yb3ZhjYnE4XYOgtk/qCb55ITXVcgW/9wwmhzH9AL/t3kk6D5aLP898KlsiO8kxb9cokd6uh4T+mEAmI/J+OEhmvqAlcXNxicDwVfDhH56uk/AfInuvFMjphcCTqFIbYTUgIEET7bOFOhGj7FjMBnr/HvEaIpO7YpOmgisZohAKSPk6eyICxsQbtMfVwt7X5W3K2asmpfejOe17SUEYY8/rxVwDxhGxj38vZDGjdXyOep0M0ddWR+gGBe2Hwq5MDND0ilrtomKzF2VkkU0gvK6PKuZeXMgY9mUH/PdY/C3VJvYGG3wk/WKfoKnym3ai5BUpCtXxaFydj6noEnNCzy1+ZJIAB+UFqKI652aUYEOL+gRTxP3xfq7hBUdKwP8zxU0Xbpe4FnK3coxaKTKxNmLG6imMC1f0XGXVq4yG8UHD0vb9ga52vKe6OHvKKlpVZSVKh9XrJVP4wzHF5/5lJNdo5HdbhiFSiVgrm4ZIM9WSnGQzrhos7S862sR+UfInb4VVpcwyETdQwifcLMx9FrDGsnjJf+Vp+ZAbpLKC1hWbWwQ9QI0oZQ0AEPo9R+v4jraehxNBfAFoxuU/VLHjVxee/b/beO2KzLI6zUb21Wa520JxgJYYIBW+BIQn90mm7xan/DsY1fpP0TKarQoV4HAMATjQhOLtPGbYjTOS6h5i3fIrTCcxlIGV9j/DHS4FRsjTwVE8KlCE8dXt66RwDkt8nHGU8HDvX9OXbEUOzpyYBQg4s0E0tpucYp3zPCDcEfQZn/zZ/t3sPVU6tAIbTxK75n+VDW74JocJTi25OoO6xsTG
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f062cf8-ce64-4d39-f5f1-08db7e5212d6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:51:57.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmNj+ErAFK1r7eyQkNYDx5xFCH0zdOxEm8MdwXqHrS4KgMCnq1tjx7SaTj37VO6gSS5lYgkdoU0+tsYWglqXKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_13,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060167
X-Proofpoint-ORIG-GUID: iiR-0Eeu7RywGgvZX1AW1JjvVa7ILtBo
X-Proofpoint-GUID: iiR-0Eeu7RywGgvZX1AW1JjvVa7ILtBo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a upstream.

This was inadvertently fixed during the removal of __vma_adjust().

When __vma_adjust() is adjusting next with a negative value (pushing
vma->vm_end lower), there would be two writes to the maple tree.  The
first write is unnecessary and uses all allocated nodes in the maple
state.  The second write is necessary but will need to allocate nodes
since the first write has used the allocated nodes.  This may be a
problem as it may not be safe to allocate at this time, such as a low
memory situation.  Fix the issue by avoiding the first write and only
write the adjusted "next" VMA.

Reported-by: John Hsu <John.Hsu@mediatek.com>
Link: https://lore.kernel.org/lkml/9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com/
Cc: stable@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b8af52db3bbe..bb2e0ff0ef61 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -767,7 +767,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	}
 	if (end != vma->vm_end) {
 		if (vma->vm_end > end) {
-			if (!insert || (insert->vm_start != end)) {
+			if ((vma->vm_end + adjust_next != end) &&
+			    (!insert || (insert->vm_start != end))) {
 				vma_mas_szero(&mas, end, vma->vm_end);
 				mas_reset(&mas);
 				VM_WARN_ON(insert &&
-- 
2.39.2

