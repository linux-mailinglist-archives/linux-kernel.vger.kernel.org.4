Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7C724A16
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbjFFRU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbjFFRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:20:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9BB18F;
        Tue,  6 Jun 2023 10:20:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DDpwg022026;
        Tue, 6 Jun 2023 17:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Mh8dw22H93NbfgJfSHIdBa2G6WgAi2QaLrWJ7Sl9o3U=;
 b=d+oVOWGpw6blpDZG81OsDWBW4fmj26Txu4TERjcK1ijhKFkFlVGbOFy66+LxE4/2xw0v
 2W4T/HRjDDlGYtTK2XVn9H4RNHxSSUuEtS6UO87wH/I3MHhf6TNLKWQqgP95frCAhyEx
 DVSUpZcuWFSq6fPYDK6pbZWBvHPpG88hGU0GEN3fgyCeEPjiBxjXgCGqDBGRP3n4mcXR
 SH9P1ck8gPrfg6TUXri4ubPI6FOFh1XEI1vMugt33o6feIpChl5dzagE2XQwoSllIsj0
 rHdeHkCpibwD9AiWYPu/+Lx1CdMN85SbNBYis0KnBF/ood+7RR4HLSrPxTLNzeTj0EjG PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2n5umd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 17:20:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356Fp4mY023784;
        Tue, 6 Jun 2023 17:20:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tq9g48a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 17:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJHWXusreRWA41G5rDIFtKVM3Kota2uaLI4CzuAVEjateKVrqddEWUSaFV0zCjZlzu+pQx8zXIuB62NLTSsrBKzDh/5HbDaNmH2DsDU9zNGDMvgWSefVp/2/c6C1qlMALX7Tr5IvdLKjSi6dZo+9VnMgDUZT6tu2uLrrKnQVk20D32+kB1RQT0QAmjQvJmUecxka7lA+7bBBvpkth1TQPGkCcbVSnxOgwTOJHs3dg2soiUyEtv1b6/bOIzsEFz6iWr0TsxDVVkeMezpky4S2GMQ7g0xZM2bdkVroERWHsT7NJ8lM77Mv4Utj2qiIVkUwCAVMaW+OHOF5U4QTAnrLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh8dw22H93NbfgJfSHIdBa2G6WgAi2QaLrWJ7Sl9o3U=;
 b=jhl8RZgaetJGUTKTauBrxofOgV22XVsEh/WgjwmwxAAaWyz9JPeh+4LnyYiM/mpgG+Z8UqDq8lXIFHgIXI/y4IDLWfldph535n9daxMQh8JjA+wtVtxU/cx5Zzxbe9qKEGvQM7j28sxqZlsumA4m/xGhlp88UsEPNV57mUBnPvr4OeL5UbFdTGbmB+sr3Fx1fmDJrc4K4AIc81DuKCmZGP/6XMTcpccVDJqvDQlhzeVK9Red2d5PcK4aNxaJcBoCo2LL3pVaworXtjDo2IGnkPMyoc+lHyE3aHjrxZgTRSsQCO2/ITRJ7PG9+UIKerSbwf/JufDx8wqYQUXjuBB4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh8dw22H93NbfgJfSHIdBa2G6WgAi2QaLrWJ7Sl9o3U=;
 b=bkDRJWaC6M7zi6C6rR0xz2AtpQtumWuHgDxTeCUyBLwkJRqi6t77auzmwXXQPVEEHK6CB7e0BHptsfnb9939OG0qQbbgpu5lM59vG6B16ka7uWdQ4ySgV2jTD724p5CKpYLF3TBDFqFu73FRl2HETqH4OAr9esyHnVFYvNhMm0w=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5766.namprd10.prod.outlook.com (2603:10b6:a03:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 17:20:36 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 17:20:36 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     songmuchun@bytedance.com, mike.kravetz@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Ackerley Tng <ackerleytng@google.com>
Subject: [PATCH 6.3.y] mm/hugetlb: revert use of page_cache_next_miss()
Date:   Tue,  6 Jun 2023 10:20:22 -0700
Message-Id: <20230606172022.128441-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::31) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: b8444ae1-5dfa-4b75-74e1-08db66b25772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZT+XrGGh3Y7xY4MeUO8aFJaCnw73zfdhiGurB6IAB1lTWjpd2QTNiQ+s0MmYKAar0w2ktz+jLLEMVwRaWqM58PhxsXfeZoiE6xaJvFHw018q3lYG9ekul3Bk/ej98qZ3DIvJnr2Ro6xWdhx2x3LxqZkoIoY5cyhjuNyTZV1/VnD1jGCPJveo1nhYqcgS763Hm/jlqqYJCaKfgMbMKCdUWpaDzmJTTe+trG3pTbFHr4pm+UMh9fdVst/fDlLm/ewSzoJfG4c2cp200AbZOxh45FJ7MEYIW6/pboiHeg1vLiHj0ulWMyxahWbsIu/yWSgUVUv+nI5BxTOp1E9/EiClcTKN9NMqGtCLzc8QybDbEksXpUkdpoH8p8U5xwqadbpwpOpYCS+cfsV6TKXWHOsG4MXtPAqidoatp2ULnRO7NRy+miJdST1xW3sYzz+zaBN6ZoVBpr/2MkB8+0blobjn0QKgcICF2Oe2C4yIXNemkZNLLFaHcv6vCajfvgK2SgFaOJJXo4w0FFvgMydSUKVzdwvajflJsFlQ/yvK5WA4SA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(54906003)(478600001)(8676002)(44832011)(8936002)(5660300002)(36756003)(86362001)(2906002)(66946007)(66556008)(4326008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(6486002)(6666004)(6506007)(83380400001)(966005)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eOt2wRx/8C9VbubzyclaeVgc/T06iiu/Qyvlt0BF3JjWZNyxj06Ig6kkDx5k?=
 =?us-ascii?Q?kQ/F/Aw2yCIYV+FHju9ayzXdaQ0qHxP5QsikCDKLnKxu+F2UEn04HzzN3UIO?=
 =?us-ascii?Q?YZV1Rod/92elGXBEZ5d+w41guxXL9BiVi8KyQ5QzaRswD7yqR+5HsEUArLvD?=
 =?us-ascii?Q?MVDVMS5qVSLfqqXJNsP5/Ms9Kb8vsoJ9WWr2/1IroBhZZvlSmr1gzGB2SrgT?=
 =?us-ascii?Q?FsMBA+t9p4zkgzv3lKU4gEb62beBYhLfVan9mV+t6ZPGydDUvT+jzxzPCggC?=
 =?us-ascii?Q?HCvNGB6VnXsJ4UZ7cP5b5QwWgDqFHMtgWG/eXNuUpReYkY0Rc8NArS3wwumj?=
 =?us-ascii?Q?4mM1OzRp6MXYEkXa90HaXNNqxgLUh5gmwRoM2qSfwK1g81JYT+E0dr0jW/Oz?=
 =?us-ascii?Q?BYFhlH4iRBdMdpDWd3GfFSMa75+L3yfUbe02O0Z9GpRCD6H2NSOP6GiOLDyY?=
 =?us-ascii?Q?fm0mxetXMU1fCe8SjWXMhx8ojqkxGIfj0hC+5cDBziAEuPE0nlLFlWBNA4fW?=
 =?us-ascii?Q?tFdDJX9T0xQEHYwI0tALRIaDuyv0ycguGGH1Yl3cKCBQwgwvZch0r5amsU0n?=
 =?us-ascii?Q?diIz6DWFS7Nds4+mFNgk4OOMAdnop38inKSEG12Pl/6ozqDjv+zR8aGDILRB?=
 =?us-ascii?Q?Q3N+euY62G4ZhHEkq59Pzh3kwlgzEgxp+cIf+q+jAB0ViUEX8bh96Pj1sCif?=
 =?us-ascii?Q?izHcQO7SPm19Ow3bNC0CseIRkpRHlC5u8oUqeQrYIZe1XErPkN5TTK9N7UlU?=
 =?us-ascii?Q?CvZgEaAb4X+HhBdk4CJjgZBR+ijD+auQ/eo3uHQdQmF7R09Cc0faggxcg8Yd?=
 =?us-ascii?Q?y6htPTVexZgt2o/cJg4UR02XJlc/vqZQU539Be6wMgV+UQ4h2jJz3b6aRqw9?=
 =?us-ascii?Q?JtT8ue/m9AVTAzG4z0ESAANCI8ZYv0qmiUOc4Egu4CwuGvgsLySW8JMKHQlQ?=
 =?us-ascii?Q?wf/kwphdVHe2QWbb6ak0o/l6uYtPa5NzMm3A2qoyHP0B/Kg41wRey3ahIEPE?=
 =?us-ascii?Q?YQI+ndp8mPttCSsXRrtgEQqfNGBTlut0N1HMoEuiVw/6reUhexCs1auAGCb0?=
 =?us-ascii?Q?j+LIV0fNfQJ4JTbRNdYIDDD3AHUgXRtMuSe2aeZC28VEX4nSgMMwCC220r2u?=
 =?us-ascii?Q?PCGl/jILxVPsTrInaCTcmhS5x0ZXQ0eMhsxGiekdtQMep77E3KEqBU0WRJrd?=
 =?us-ascii?Q?xKnzyAquqP1ZFzVKxG5+cS2tJlyNo/c/LjVG+vsS3hTTVBwc6JJ4a0RUTRjz?=
 =?us-ascii?Q?7ngHl2EzjJBU6vBuU6X4oxhbiFgaoNiylVOlgkH43xmUMvPyyRod5Iw1FFsI?=
 =?us-ascii?Q?pWvqZPVoPv0gT4/8lNZOgQiT7JNt/w/Lt7MtXNxsytDEUgtZZI1FqtULUJGX?=
 =?us-ascii?Q?5ce0uw+0OZwQa97x5aMY7C08J/06M/04nkcD4MJ5JEI0O3qMb8T5OeGAU+7Q?=
 =?us-ascii?Q?coBeYZByNFuQktsNvlNlsx+pt+0s7+SjvXPJsY6G/S/QOL+eWW6eD2TNSUHA?=
 =?us-ascii?Q?SF3cwfw/qnDdfjUNr9WHuhLsuS2u4fgvfyx6xZPRQuoZqvCp4XmVsBpQ+DsY?=
 =?us-ascii?Q?uKe09BTNCkxCqDp7mcAwQafUEiOrBwndPFvJLcjNB+Zz8y+ww9UPH/o4rSDx?=
 =?us-ascii?Q?2SYsiTtcZK9buTT6pRxHsb6fzqtE4i0tu4xhkbi+HTkuO0fubN2S7YrfZaky?=
 =?us-ascii?Q?QQFREg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: saV0CWuN8kGORXNvPBBZVBbgLkvXTYPuMeiWBjvPvnYO9w9jk9SCbip+mM1R9sS54Fe3Xf8z7GDjrvRdsmor1Xu+WG4uj++MMwmrm1+orxzPDPL6vD11BepWz9DG1wJkbAPLzMRwdHXtwxUqyGjsVp7tKBg65O5wud7Hprl4GH+B2Ebzdh8YepqTq+43vpok0gzrPHljETlqT2Oe4Nq22Qf3/1x5+bTy8A0C74FSVYGvuNa5AaVAbZ4ZN+qzIjJ7tbc6ybkmt2pRAg7P1qp8XIrVMZDIcaNY/i/E4UwdJBARbwHMUnzv4NWIjbx+4j8Oqu9XFW3Hk3NgHY179i+ltGBWsSK/QqxNXp3uDMW5oJIHpISewPcbJlK9Sh1wbVgvQKefUToPwkGNRvlTTIyailUb/BI3gPR5djGJ2gHGraJHz2a8S6k/LhDYXqbSh0uxbD40rErxHtyr1tVsxaRteuxwU26xN5RZH6Z4zE5p0V8htyLUHj0r4q3kQtvC6fIFGTQZN9kVQYRLXS1goZaAvPBgbmySiSuyNJjF2n3mKMO5XpFU8+u31AdQ1+kwWvktBYzKuSgoOJM/d8zmS0VVkEo8w5tQ0MqoSGg3EfTr3eCq3rIXOj84LUGONmA9At4OL4yydoXYS+wKKG097MItQTGVXMvabYdHMGQ4KhG7e+V9qEkLJfOAE7bSexYerWP7wvQb+BG06CuIAOsFgzxlM5znzauMoJFxFf/npwQtOxA/kMVl+hH8z0JUfE7cgRI80J+R7p46gDh9chi+d/lrCtearepVTztGDocYz/zYdQKTWA1wBQ1qg545uhuvmzsMrzsCZNzRybAXv8P0+04fGg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8444ae1-5dfa-4b75-74e1-08db66b25772
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 17:20:36.2685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgL3jGDxAYhzF4ZWmwX5Wf8jGnK2x5lUiYsceeHZKIM0Q21R/DI3mcqrtpVV2Qq/Yv6BSz5g0xv5wfg81+/lPjSUBVKHamlR9D1oeDc3WQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=855 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306060149
X-Proofpoint-GUID: zy_1NTOZ1uxGjOg1sGVmP8BxJbzvAYe3
X-Proofpoint-ORIG-GUID: zy_1NTOZ1uxGjOg1sGVmP8BxJbzvAYe3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Ackerley[1], the use of page_cache_next_miss() in
hugetlbfs_fallocate() introduces a bug where a second fallocate() call to
same offset fails with -EEXIST. Revert this change and go back to the
previous method of using get from the page cache and then dropping the
reference on success.

hugetlbfs_pagecache_present() was also refactored to use
page_cache_next_miss(), revert the usage there as well.

User visible impacts include hugetlb fallocate incorrectly returning
EEXIST if pages are already present in the file. In addition, hugetlb
pages will not be included in core dumps if they need to be brought in via
GUP. userfaultfd UFFDIO_COPY also uses this code and will not notice pages
already present in the cache. It may try to allocate a new page and
potentially return ENOMEM as opposed to EEXIST.

Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
Cc: <stable@vger.kernel.org> #v6.3
Reported-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

[1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
---

This revert is the safest way to fix 6.3. The upstream fix will either
fix page_cache_next_miss() itself or use Ackerley's patch to introduce a
new function to check if a page is present in the page cache. Both
directions are currently under review so we can use this safe and simple
fix for 6.3

 fs/hugetlbfs/inode.c |  8 +++-----
 mm/hugetlb.c         | 11 +++++------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9062da6da5675..586767afb4cdb 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -821,7 +821,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 */
 		struct folio *folio;
 		unsigned long addr;
-		bool present;
 
 		cond_resched();
 
@@ -845,10 +844,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		rcu_read_lock();
-		present = page_cache_next_miss(mapping, index, 1) != index;
-		rcu_read_unlock();
-		if (present) {
+		folio = filemap_get_folio(mapping, idx);
+		if (folio) {
+			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_drop_vma_policy(&pseudo_vma);
 			continue;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 245038a9fe4ea..29ab27d2a3ef5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5666,13 +5666,12 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	pgoff_t idx = vma_hugecache_offset(h, vma, address);
-	bool present;
-
-	rcu_read_lock();
-	present = page_cache_next_miss(mapping, idx, 1) != idx;
-	rcu_read_unlock();
+	struct folio *folio;
 
-	return present;
+	folio = filemap_get_folio(mapping, idx);
+	if (folio)
+		folio_put(folio);
+	return folio != NULL;
 }
 
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
-- 
2.40.1

