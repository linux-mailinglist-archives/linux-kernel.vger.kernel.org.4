Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3714564642F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLGWjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:39:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C5B6F0FD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:38:56 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7Lx9uv030858;
        Wed, 7 Dec 2022 22:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=mMjcFjpkGrUMbQah+4ESEDYEGowW7s7KaucTg1AiKDE=;
 b=P4kfCrXCgnaq8O6rN5o1c5IYWDEst3Nm8KYAaRUcvfWU9NGun1sI6p/sczbd1N/V4LYy
 HNwwvJWNFs8lRVIxvr+ey3c5Xa0YJ2uYhaj6yg2JgWBRVwgvxGoZ37CwMeVmErbn+FCR
 3RDKUlX6H8j/NEynPn6aAxbS+SVcLCBKB3gjydHrem1jbO8uSpcShtSa2c1qTeQfY1FW
 vH/rdySKgcaEtfNqz1s9bxStgBv/E5HTFApECsPfgl+ZD8zu/99HPtvhWvmPPojoZYY0
 U3VrACkE//cY2/Gy9ndENAQ9OJqyptjP03cKqvdvuZzrVy6NQSKQlVb0HBwZXEO6Z/TU Xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maudk9mrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 22:38:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7L19AM021779;
        Wed, 7 Dec 2022 22:38:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8gk7af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 22:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWvYqQwuppKl0tc+C90H6lC7Jl6XXM4fuZaYLb1IRxn1VOPnPF2h0HuBkYUKsSpbaJCS9sGNTVdy3bklWOFUzvKBhaoRSaPJd0o5Z38rXv5CwO0hRqgAJkUogJhvy/i/a+CHYfnNaymla6auVkBrwD/L/xC5nfXmNbult4X5Ms+Pgc38TW/Ade1MImv62FZZmmwlSjZAaSPKjHsY4mX83aHOCcAQYvpbA/D5Hobdqc6fffmZlJN5Lbtp2CiHsWwqgC7xs95QwOv6tNzRLu2R0UBu8yzMOAEyVZnJsKbfY5c32NpNTnM+mzJpRF0RlBnt8TFshiVflMIWLi6+H6sLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMjcFjpkGrUMbQah+4ESEDYEGowW7s7KaucTg1AiKDE=;
 b=mEM1lsRDYWyNiK1SJTRZo0TCW9OwV9gfg1S8fMcevNShZj8aE9eIi8IUlN0Itt1ZoxUsNwZ74uriOdvFR74fes/gE5bKe35+NMgulAyOXGY2jo8LXTNcqVDv0AW162MbMtuzPS6Xn+Lc5jSO62U3knbUmYH8uBtSx2GoMbzOiEMpDUGMFXx4FaPWF6NaBXfs22jAoY62anptTRsKi+V6g8y5une9qJngG7iVx1ay/oq8MJbLhltSz6ovgi3HQFA8WVNsalWSD8X2Q/Ochj8zHvV/CjTPHC0Ucw2k5nQ0Wq5pN1FgxM54k/V1weV/tmpybdPG+SrO+QlIL+GMo33apA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMjcFjpkGrUMbQah+4ESEDYEGowW7s7KaucTg1AiKDE=;
 b=nFtM4Tsvg3Wdgs8spbBe478UEl9Jz9oGwkqt98wdZlRNy2N99cqrYj13ljzO7lCAvhzWlkFrYGIQwgckAftMQhhUiyJqAyKBkTGyH52NXj26QVXhT9ntVn3JTzKMa00Gl7yla253ivn8fk9zKLAVWaRO+MH3qgUpgph0HgamaZE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB5166.namprd10.prod.outlook.com (2603:10b6:5:3a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 22:38:41 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 22:38:41 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero support
Date:   Wed,  7 Dec 2022 14:37:31 -0800
Message-Id: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:40::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb76d05-5c03-4451-50f9-08dad8a3ca54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BK5zlEl8h7P5ZgTHeAkALNIBxvgLbQy8TkiWYc9IXlqzTB6YXX0InJOmCqcIl5/rPtrs9W/S9ZC6+krw5Vc7yNUdZnYY/ZDWYqxR9pCVATYx9zscgm6GhUoHg9wH4s4VJ7dL7mbuU7Hf9FkeCnQB0s5u67g1ZVwelDWnaBp1LjdemUuT0lDHxKQ3C/hXX7yE/roe9OzRy+tQwHiICDFhFndHuXjZkRz8yboQF+CLko0KpNh4vU0e4WIXoswcEBNW+gYbPs+p+HLI3Q3gl6n945Dtll/Fn3j8OsuiF7dmSJlxeDfLmEvOeBPwhMDeLOoEewYUS1BrqCWZKlMSSBkhxlS0/NmbL8BdIWbv+9ya6ZUM2nIrR4AnNu3ASsUYHY7JnYlRhDCq4QOh4CwwToIby6smn/tsco2Zef57ZtOeopPIfs78DgbRubmfBcQf7H1eHXhBJFEmdbQI3acW1EuzYdmSwUJeKKUDY8uxUPjTKYJOYqLFNhDWVyJqHTNTsE7zB6YS6tpZTj5uY8kqbwDazZuR0omt2Sf3Y1vKi0nMPMQCOf4+1oZHRZ3mDQKrbVsENovTempl5CvfH4sn3gegNRbiI7n/pYi77heBiECT6AzuRqjtIx7O/HfbQSbmzuGY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(8676002)(44832011)(2906002)(4326008)(83380400001)(5660300002)(41300700001)(8936002)(6666004)(1076003)(6506007)(6512007)(186003)(107886003)(478600001)(6486002)(2616005)(66556008)(316002)(86362001)(66476007)(66946007)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X0anNwI6/qYmEq6+CgRd2SAXrfZ26m1Q5sqJERWTD1ypcQOD9N/pJ6FsM78r?=
 =?us-ascii?Q?LNTMlDce3v9NmZAvh7wsZq64Drvz8iACVyRMcdS4gP1s6PHh76IJvjurhj1O?=
 =?us-ascii?Q?jeK9jWViLfPBcpbYhWW6Q+WVRmzmvfCq1M4xRi29RQKstQ5iyaAnVwmw3N5w?=
 =?us-ascii?Q?85ALSME7loR/HXkvFkN6bttZaZbEv+E15Y1sxv8YZ4xiX/2hYfg1ZQj0RroV?=
 =?us-ascii?Q?B7e2sHz14DluvCKaFfbJQz9xdj+vz+ybqWqQNVOGLNWPPyXJn3I4XP3cQP+c?=
 =?us-ascii?Q?07UTghnK18sVioEbtzn2TyhYZQ3jtWeEtaKgGbcQtxKkpJ9XF5tVntbju8ro?=
 =?us-ascii?Q?aXyo35ea0Z+gTdBhf8rT0lJEgxVyL2lYNE1gzLAYllssuGrxRF8NEm/vMxvK?=
 =?us-ascii?Q?ZBWp+KjgZpGpf4M/z4rAZXUZlS24cVr7qMtl+oRb8/75Ec3p4adAm/mNbRt/?=
 =?us-ascii?Q?QETe7+6ytA10dsPmDsWU3X9Sf2x+EkOzLVv7Tl7z0ETKvGG0qObVnakRTSFA?=
 =?us-ascii?Q?AUE9nxafBQ6BJBAbXycHnS7lRwD9Bsys4rs4zmTivN7J3OyZr0Z0gDGHpxcJ?=
 =?us-ascii?Q?4MUYK3sC3W0i8m8ZJkpHejC0A9YWjLOG7ubE6cxFpGIllAZfHDmRQGxrsJHH?=
 =?us-ascii?Q?aWOvyaDyvTdOjFoVaDSHz41JB3QlRjroxSHdhAbAzqm6aDxf/YSGVKKSZOyz?=
 =?us-ascii?Q?lZ41GJPChDE96YtZmeC7MDrsX1zksGuuP4Vu9k393ZCyb46N2GcgXsXJlYAf?=
 =?us-ascii?Q?mP/vnf+gDP2Mfxdgu0Kbf7o3S/9SWVY4LOJmdoa6HzgGq9hdOilns46bpvm0?=
 =?us-ascii?Q?pMC76RIC+CZUOjqKH/srveoQpTDlV5aEAv6BowbTyq30pd4so9Q3zu3hDNMw?=
 =?us-ascii?Q?PhXJfTQKajRxwMegXsGB/Hj3b2Xfshdye9EmND3JaYUVgNYpoX9IBmhbQlnD?=
 =?us-ascii?Q?hnySfvUuA9mepd2HuVGVr6l2tHBvyxAwJKh6Dt6eFZIVPA4tCjmUWRm8flqw?=
 =?us-ascii?Q?E56ofOBx5YmAWuJHGSV9tkZ+fyiVIXpAJ5zvGR0i89UXleaBhKWtPppVARq6?=
 =?us-ascii?Q?dIFvA/azzSE1Gm28pjeGeCXwiOHkN4ruZppCMgnxH0yiiC1xdp9Qqquk59on?=
 =?us-ascii?Q?g2pbUzxmO1K0UuZjar8MW2W6B4DbbmJQRiz7QXQr9B3FbaF6of+/jorsi6Un?=
 =?us-ascii?Q?9Vh+8zek1jgkXF0sctF9YulMzz9zSzq/ZkUHtMwdjER2kZs+8EWdOR7+mcjF?=
 =?us-ascii?Q?NwGHm8SI+WC5t0zqVldNRA0RRodtLbdiaj9uBBNuXSuowKnL5z1dDHcJPB93?=
 =?us-ascii?Q?zYzVT/i98a/rN/FVd/5/H5UkchTcSzNWORDXM63/glmg1JCz3r3UoPwICfVM?=
 =?us-ascii?Q?NsVFNZgNl4f8JFzpZ7vFbsDVhm3hdje7nE7Sd9bEjR9vwMgunfHu7/ldRq7v?=
 =?us-ascii?Q?di1gBQvvSxKvah+VRhdKtQztG6pYFHOZB8g3lKGQe4cC5hXz5nichxbqRXe4?=
 =?us-ascii?Q?+cztsMNLqnsqQ3hqI2bSMPieJ9wwSjdxkBDm393sePImPJMsk81+r+BQIlo0?=
 =?us-ascii?Q?kwzltpeACJfY6joW6hbPNhahinDXEDXE5DgPfGrQzIkZxn6agH96/Uc4ZT99?=
 =?us-ascii?Q?Dewzo/IBFvmmL6DSPDrICIrPB5Ymzi8ZikYrT1WLcBmNJKQcy1hxCqZSg/Oz?=
 =?us-ascii?Q?wt/6OA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb76d05-5c03-4451-50f9-08dad8a3ca54
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 22:38:41.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/IXl88UsPqYnDS5vXfn94rJSoyyHRgpi9PjWKFtCUHxGe7qighppYPg19cFckzgkI3aIBQ5/odukBcJQ9A3p790MWfzRjkbPtmKOGF6GPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070192
X-Proofpoint-GUID: qEZscxVuqPs59qN_RdmAhCBOAk3lV_5P
X-Proofpoint-ORIG-GUID: qEZscxVuqPs59qN_RdmAhCBOAk3lV_5P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document hugetlb's use of a zero compound order so support for zero
orders is not removed from folio_set_compound_order().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Suggested-by: Muchun Song <songmuchun@bytedance.com>
---
This can be folded into f2b67a51d0ef6871d4fb0c3e8199f278112bd108
mm: add folio dtor and order setter functions

 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 443d496949a8..cd8508d728f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -999,9 +999,16 @@ static inline void set_compound_order(struct page *page, unsigned int order)
 #endif
 }
 
+/*
+ * folio_set_compound_order is generally passed a non-zero order to
+ * initialize a large folio.  However, hugetlb code abuses this by
+ * passing in zero when 'dissolving' a large folio.
+ */
 static inline void folio_set_compound_order(struct folio *folio,
 		unsigned int order)
 {
+	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+
 	folio->_folio_order = order;
 #ifdef CONFIG_64BIT
 	folio->_folio_nr_pages = order ? 1U << order : 0;
-- 
2.38.1

