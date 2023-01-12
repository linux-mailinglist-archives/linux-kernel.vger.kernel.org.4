Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE06684FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbjALVFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbjALVDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:03:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A959953297
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:46:57 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJXo8x023270;
        Thu, 12 Jan 2023 20:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=q6+oCQXcVUPDMQ62zkDTZuFqVr20l7Tj/4Q5KsZwSwk=;
 b=Y1zHq+uMzDhfopxf7+yL6207d6diEYPBdaLBYrCTTDTRmPPPRzRMWfiM4VdY5f64wEcF
 kyzs2Y08U74L1+9WYzWRe336ZZP83p0M1W9UEh0X47+c54vw4vLZ3GsTLfm9kNx6Gcb2
 nvChW5jkKBWFhK0PDV1h0mSGFIy1qO6TTI6RCIlJrREGxPzTFOV5qvihuOeNMZv2MLZK
 4s5Md+6OLdrfy0U5bFc2FHYFz3l1pz1DGdWIcxZ3qr2So/rYKcHPibWm1EBby7r6evVp
 sACdHGa6xAfUwbQ2UOdM1+8Rp+mqjJl67/vwpksC9G0oMDtqku/FgMnsMLFyzhQIH1CF yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1y1nkhcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CJ4rb4022034;
        Thu, 12 Jan 2023 20:46:34 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4qt2n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUxHhb6akqq74MTDpQzhoe368W1uU/IJaXDTQ6WKDoVAkdmh896yXz4WzvxL5MltxiIL5fEvqCV7ZNzFwLAp7VuJOxgzAHPvjG6RCqXhfvk8WkuqfZbICrlFtvcYwPmcFEba+rdIVhqTavUsHLoreSD/KuQtPtqkp/9BVRZ/vSXfTgIv9Fq/8Os+cDZKLh+h/QzunyFKGapW12gZFC+M6Dr4VqbXApHqEz5B0m0I3X3WKwFGmez1OopXYrzLk1ENe2EaJIacuIFSpQ/t4B+ikR2xgkVJpoG9UyGbMWILBuLfMnbeCOkzkIfuJPJzzgROykvpBjvxheG4B9r8KrdLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6+oCQXcVUPDMQ62zkDTZuFqVr20l7Tj/4Q5KsZwSwk=;
 b=KYiPKIOkni+vEBREpEeVTQs9E2tku8cywpdZoPTvMEDuhqsn0BRCZzu+aEc/k4c1q69N9O0t3uirZ02GClsBHuUDvHUHVNVfZG7HHsv5kzszjPphKzN4TNa3X8+V/oRZxMqLx1XxUQkY+Eh8NlgLZoJdA4lzOk02qjEAl174URZXzz4zZR/HGcNYINtsebZMzBdthBXtFqLwD8grliKxHy+edgM98GCGdHl38B/4jSK7X4r2WpimMH+J7/9P6OMqQmuWzvl27Rxgug7E9WhZAllvHBi28BSYAFHHcdy7Uyvk5rvZlLbYZ7te+GMzwONtN19sdNjKQg5T6ydc0fCIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6+oCQXcVUPDMQ62zkDTZuFqVr20l7Tj/4Q5KsZwSwk=;
 b=Dm6copwerYamrL61LSHhJ46VDovsbKDcJfDZAGKSDzrYsNonOZOgG+4hqlTcCehJqvIlN8BPtu6LZiCUqbM0ylIxnQA3QgAdKdtSPrbSo/IE5LIwSLR7+sTAkAK2zY61fpE13kspdWUfYmv1MktyxJXe25lAFKw9Rwghx/UPPhY=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 20:46:32 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 12 Jan 2023
 20:46:32 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 6/8] mm/memory-failure: convert __free_raw_hwp_pages() to folios
Date:   Thu, 12 Jan 2023 14:46:06 -0600
Message-Id: <20230112204608.80136-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
References: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::18) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CY8PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf4051b-b883-4b58-0a07-08daf4de16a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMgCNDPHnMQS3NQqymiOGYSmTYk9tjI1NxlfvBAgaL+54HOArZJZbZS/SV2AYlPmmDko8bFxEprNbJzyKQ5cE21eJTVuHDr6+MkTJ3xY2resHP5aCrCuDS5qKTgdCmlM7cNboy5/MB1F6LCYNASz2dibNDXpqxWDAzsrxvXW7DwF7rex5z+Yw0jck8EMBvdkcagDG0hZNUvowdkKY06WeksCv4GHrWb0RLM6GN5HFCkt8UyqjpEYQ/QZ54AGJnQhxMBiK4UuOV/SJMBhsznZiZXmDLe5vCIPW2EA/uawe0G0c6gTipsuAH+/k5QlDhnueW9UtFziX2dLl3plTq9Hwtp0CFZX50AB3apLWgNmvVX1cBHh6upJT5skht0ssG5hcI01/Op09Qc5kG4gsdO7PjcdINnaq+5vY+5K9lCco115EVoZLZJZJuQ8pw8UxE0s1lb9Pa0NsRJf0cYU0ASuhswsGPC7fe32eC/pVAfbHssacdJHEQzwX/Fya4Oexe+u/WlvwEwxWDyfyqfoXJt2f7HyPf314vi5DOL4zowa6wLGK7cVPcKD8+88wZuHgMeXLaDkxQwNf3IWcXEB0TMbq3N6j95YNZmA1SLDM/sN+uuAStpb4qoIIOtfJUvyZCBR+Ot/Y0fwohiXnx4B0UPArA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(44832011)(186003)(2616005)(6512007)(478600001)(316002)(5660300002)(107886003)(6486002)(1076003)(66946007)(8676002)(66476007)(66556008)(4326008)(83380400001)(8936002)(86362001)(41300700001)(36756003)(38100700002)(6666004)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JJOQ+8T+O2idkqrXSrP7XN+2CeWebXJjSpyK3UL4n/gdqVF2DZnGYb8OYtLM?=
 =?us-ascii?Q?KzUzAIf8cRpb35n5BQ68fdk2utbbnbwF5qTfqv3+XKPf6wrohexl1306OjUo?=
 =?us-ascii?Q?bDTCzQLG9o6KcrMLbaM42g1OMFXlUJ1LjKwefDEKgTBR+cgzTOE5XN3NNHBP?=
 =?us-ascii?Q?p4a45J/j3PznG/ndaLgBoGcIgbGJ/Tn/4MNlwwmiKPs6Zm/Cot4+q1t6NWjn?=
 =?us-ascii?Q?w+VCTeRb+n4mU25uZJTKUg/0ZZD3MrqKABY1FA5GcvaU/wcHLacnapkfexCE?=
 =?us-ascii?Q?NYcSv5vLVGFLKke5IBMhp0ffL24TtA0MLYYDbV6BqBikDcbWQE0HAodIv7Q2?=
 =?us-ascii?Q?sbsODu1i7EBnYm2e7GcxYdvFqHF8zXk3TmvxfH3oKhqVcRVCObDRfjBIvmZH?=
 =?us-ascii?Q?2WeJsIhP+JEyugNBNE0ZIG9dDV9h9VLflQbzn9LFJBn6FDx5PETrn0OnJukB?=
 =?us-ascii?Q?/30j22UDD0fetmkYHBLyyihxEOegFCLiFasZNR18gUFh8Scs6uazFvK2z0vx?=
 =?us-ascii?Q?OcTH4ouLqdrVPC1DOzwIkf96ZovGZGXEMJVCbQlb4Igcupyzz11yb9TWJrNW?=
 =?us-ascii?Q?0OA+kPjaSecZLUMTXVjVLreu2kohaGWUoYAIR870Yg/B4Iuc3k4kiArP3bm+?=
 =?us-ascii?Q?hcIehqpebAp3SOp3gYXqbMW1AInYsNaVecboXARnwTI/QAW1SWzFsnbp6oXN?=
 =?us-ascii?Q?0Y0Wc2HfVINiFlMD5eSDaYYgvXSqpKACxoj7yVOzj2GR5I9B1HIrpu7vMhi5?=
 =?us-ascii?Q?eucwpO9hNBQbDqHTZJq7jsK7Zhp2xkmef+fyVUHnYWZXcQfEG4d8FRUwcfsj?=
 =?us-ascii?Q?itahn+sOzcXzNXWA1IX53Kxq5g78v0BRtI6vQYPErbp3qyiuWxHY71xu2OYQ?=
 =?us-ascii?Q?o3yEc7NzaTkWitTLFMpowsVXv4SvPT12063Y69RghyG1J9TmjQlC8jNlzFMR?=
 =?us-ascii?Q?r1m3B/vLBp48NHRjiPoV2PZ5aP23OUWwXRXoH33LsIA/6S9LmJCjjkSGbROP?=
 =?us-ascii?Q?NaeVCpRUFAxzgRzxhU9HQdzm6kO9UUvVIgkKLTqsJt0mBKEV9iwDO3zcxaKX?=
 =?us-ascii?Q?pBefSbpQjeNuZTS5jNxM66gqVPitCZ/KrdpgBqOVB7eQUaMu/aJw1DmF3IOd?=
 =?us-ascii?Q?YNbO8V/q+AvmlF5Y8hnIub1zqTbBBCo6cNwhR6HBjpNi18CVb+AHxEihvwES?=
 =?us-ascii?Q?/SvkkmHq1HPihFQIJaTZJY609nun2nbpyEP4K8Hudoa/qcq+pqwMNsFZIaZW?=
 =?us-ascii?Q?tDuhgBdGMQAPQF4HeAVVU/PWsjbTY06zOmY7s64NHAlrkH6CxzkoF4thGfXE?=
 =?us-ascii?Q?vecpR6W2Pq+RODk3wAa/KjEP2HlqXhGwpozNS3cKKmbopwSFOREDQDut3vUk?=
 =?us-ascii?Q?1FXFirWJpxl+yEHQ2tVivPwtnBDfmrarQqD5ISRYA/H8WNu587CL/fH1tf4z?=
 =?us-ascii?Q?GUFQo4gcZd1RQNpFg6tD80swgHNFo67f+zXf0XLQgomHIo6lz6RF8bl0gyVi?=
 =?us-ascii?Q?4gZBx/QcIJ5pxoQlH4Qfb+95aRE9ikNvYQbbobXuJfKG2F4/MNCcDx8T3ScQ?=
 =?us-ascii?Q?BSiqcK+6ug0U2DXbjRGloRzeJkg34InpVYYP3YdWewJIUHOAA81Ugb5SIhSz?=
 =?us-ascii?Q?Nd4XwxM4Q7pZQXh3yOqLSTc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2Lyaud1wlccx+hS6dp2OZrzzCamJ55ChxsUCWnN4EmMLzEiftwxbcoubQfRX?=
 =?us-ascii?Q?8zQ+Ol6uwpA0i/tlWtyrwZQYFUaI4SDJRqQhST/9XzX2KLUyZzk6NOAQExx7?=
 =?us-ascii?Q?4w6t5nhel28K01LEKX8yMLBYwhGjxehdldgAo0n8vh2OWEjwZVdwFgxLnKVH?=
 =?us-ascii?Q?gmju05GTF69bWqiMyEK8VGU2RLAfLpUvZ3qd+bq0m0+36mMHmBP6q9gkMcjU?=
 =?us-ascii?Q?L4dKct9cYH0rZu/alxHiJRjls81fShXRJeC9D+tvVRdEX/f6+ZPMjN/HWwlt?=
 =?us-ascii?Q?/vYylTT90tyUW6zHLrMkkiFd9lkG6Y50oBoNdrfQzBJYEBKuyupRgrp/PCpp?=
 =?us-ascii?Q?2IKtT7KsW5rS8syozMft2fsvfl3IsFXEKUr3RNj9a/eh3XQH2EFVxi1nbHs9?=
 =?us-ascii?Q?otVK2LH8wwxkk1QX8P/MZq4TkS8eYNwurrNRQAbnxSupJPI2YPxiFmWfMjY8?=
 =?us-ascii?Q?9t9qtQ32/9FNmCZQ0iajzaHGvmEg1oBR2CKPT74OIbe0dZG5YJ9xubZZIWvg?=
 =?us-ascii?Q?BdFcH8y2ClLKkI5DYun6F0B8KwczRNbk6/+biStsCuq9zioIsak6Okg/D/TW?=
 =?us-ascii?Q?yGmwCnSIADw41oAVGTbC2WwkyxzcJ+We51XDlw389teSjRhTf+LYXikB7LlH?=
 =?us-ascii?Q?pDKRsBo7LCyEGkPqUjos8PgxVnIdLJ+cJY4sWhSpJD4OW1p9TcKTNmwO41Dm?=
 =?us-ascii?Q?Z31SzEzOsKEN3bQXwWKQklDXY83epv39AfOPcKq8O2cFdFqEmnVnZJjRXliy?=
 =?us-ascii?Q?GxUXeLbumX4b78uo1lcnoJUOeMrhP4wtUJLkVU902x0ZEAqy20eKAd9NyHQB?=
 =?us-ascii?Q?qiTcr91jAQUAq3czErp1jO8p169wfLtyNoshtW3XXnD8g+L0qxvjyLvkadOs?=
 =?us-ascii?Q?x/OPF0tdF9Ebi7b9D98j4qfk4VTBWS0b7Ng/VPX/6te7NNgbvorJWgp4sy4C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf4051b-b883-4b58-0a07-08daf4de16a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 20:46:32.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vv4Q1Lbc5oakonAx79EWET5qpDN5rYeUd0wgEPm6HGfSo9ZEakn96LxHmATzdctrCZdwlfsjYlAYf3sx2rvbKLFqm5pN97c8IDI49yIs8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120148
X-Proofpoint-GUID: hxfp-HrmliNkQGrR2AD7XvJStp0CMwlm
X-Proofpoint-ORIG-GUID: hxfp-HrmliNkQGrR2AD7XvJStp0CMwlm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change __free_raw_hwp_pages() to __folio_free_raw_hwp() and modify its
callers to pass in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory-failure.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 55f34be8ea39..3fff073da89b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1700,12 +1700,11 @@ static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
 	return (struct llist_head *)&folio->_hugetlb_hwpoison;
 }
 
-static unsigned long __free_raw_hwp_pages(struct page *hpage, bool move_flag)
+static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
 	struct llist_head *head;
 	struct llist_node *t, *tnode;
 	unsigned long count = 0;
-	struct folio *folio = page_folio(hpage);
 
 	head = raw_hwp_list_head(folio);
 	llist_for_each_safe(tnode, t, head->first) {
@@ -1763,7 +1762,7 @@ static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
 		 * Once hugetlb_raw_hwp_unreliable is set, raw_hwp_page is not
 		 * used any more, so free it.
 		 */
-		__free_raw_hwp_pages(hpage, false);
+		__folio_free_raw_hwp(folio, false);
 	}
 	return ret;
 }
@@ -1784,7 +1783,7 @@ static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return 0;
 
-	return __free_raw_hwp_pages(&folio->page, move_flag);
+	return __folio_free_raw_hwp(folio, move_flag);
 }
 
 void folio_clear_hugetlb_hwpoison(struct folio *folio)
-- 
2.39.0

