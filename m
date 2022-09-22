Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366595E6761
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiIVPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIVPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:43:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E704CF310F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:42:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MDi4dt020629;
        Thu, 22 Sep 2022 15:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=alVtNxI2EMMAlPf0+74sGCfg6pw1tfnfM2fDTmA7sxI=;
 b=KAa+4X1HqaUPIQjcGHUOEyplDXSN+6erER7JiLU+hcErY9TgqpUBJN5RPqUOMzvRsNiY
 n4rEWHA8w17MWVKgrHpU8tGZn4uH/n8ajh7kXbh5zJlT+rpHFk9BYSOp4jVWoKzIvznw
 2CF6mxsG8/qEXOxh5YZ5zb9Slok91U9Qn87K10SL2qkRZ1m7KRPGaqgREwbZHr2wkoGb
 5JKf88KbUVoRxp6Wwm07hNLqq4+fjqGdZUjFuRkeIY4S3lDu0kEMBODyhDhCRt5MlHQM
 vWbDOL1xylQlFIj3vqMSYXPkRV+26fP4J8chfGiivngZwxNORUNdbBl1nWcPNm3QVhPV CA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68mdy0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:42:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28ME0RrV005827;
        Thu, 22 Sep 2022 15:42:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cqrf06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:42:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qzsal0L6Yw+hxr9dMTf1NOX7NGvPELqkMYx9sNz3LJrhR487hY+2IjKjoQ9acVzPqNMyS6+qB8frWvYHUjO+gyocu/ARajA1RUM0mJ3QPPzSjLaUq4VODtVohFCzpOfop7nxaxU9JU7U8WWiveH/eIvjQvKM3mymfQ+/W5/9rU02V2DL0R+N87Og2O0i/rU6+s4kUWc6NBpNvHiW+K5NyZFjuDpErsbZ/Oh3BPehtGa6EeMCjNGFv9rxTDP4KpNTklYCqvCTkura5difkCY2LyqNXWbJyT4HxfFdm1eiZa8qInJjgqZbISyN4NYkrQqSnkhgguAPLkXwPuUJ9AyACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alVtNxI2EMMAlPf0+74sGCfg6pw1tfnfM2fDTmA7sxI=;
 b=dhvuDe+fSRGKEEOrqJtpTXWe+p+Db1LVNDgqwlFSOrl+V73jGp1RViZYWQNHIFxHkXIiCINVWfKHo2RvbLG7bABzIJEcMxzLPFQtixd6Dc25E3MWXbXuitQvqAyv9uRuCq4k/Jco+C4zjQ3Dd2XQBPRSVQ6tfKLxmwBq6gP3+LZRnmBxEu3oS/hWAb8auRTuzbP/f7fXyGtdHKCAnIIDDT80tZ2PmC1Ct4Me9d/Dq1HAqj6BuSnwvJ+3mGSioaKrtX3F2KTkQ/lc3P8rW9VKqkmCs0beb3N7KhFhMiyPImtAxWTaQ85S48bWc6VSP0P1DzR0GIWjZqwSaxdOq78FkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alVtNxI2EMMAlPf0+74sGCfg6pw1tfnfM2fDTmA7sxI=;
 b=qnntgZdiJTsAdQr9gzR1i4X7rjgtH7Q0CfLq/DQzI//BqcWK5/NtCIcwUFcZ1i6BjYjili2DNfYqX1jZ7TxRyKXJmWCJxE5rw2YNx8x3U+l54SI0Z0ERGLbH0J6qnl/fnQwjXPmDlby+IezBO2rwJ19JMCe+0a6BX2uN/g8wGfU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 15:42:33 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 15:42:33 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 0/5] begin converting hugetlb code to folios
Date:   Thu, 22 Sep 2022 10:42:02 -0500
Message-Id: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:610:58::37) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: b34a2fc9-a39a-4fa5-f9ee-08da9cb110b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ub5CoDSlKWqgcRDxq63xYNcfNjXL5MjAvDt1IFFYJYC1jFxvPDp72JYPEy3XTUOhIOSIUO9MGymDDD1JXQF05tmbD6YG+9RIMzAxnuHhEGmtUOQrTV+3CAnIgLeNB9flEwiF4PBwXdf5Kgg889R6rhI6+ad468kZlTmyaEYi2lsiQhfwXDSMyoCrbe2Hc56lIGc2TPD3u94yZdyIIDvwEMSdsFawvWYK8iFZ6ud9y7KXc5YEUl42BkiVkHvAQdX78YcNZUlpVwfKyCg5YWSax6z026GNifthuCznrJ4JbIEP74qJi83SWvg/hNZCPn9elcd8rwIk0ZJuiV4OiwbbIqWGTgkJF7gi5oJWRlXD+iitivMuRRpwnMO385eql7vW/vrBCil1TwlzkhmxQU4bOoo7ZlNJ/ZsF9N2E6PgSL70TUMusJw0/9n+ZIgPaqIGHJi1/WQeoE2CJ69e+E0yKiadH97x2kuh2Y0f6RzWz4+hkPNufTvVHrYy9ELU91mdAhtqN2851vI7wSv6E58MeiMX3iPhmgkQ1ZLXgNZX701DQa/jzHL+UUN2vRL0qZp8gb846LN888RlI7cLnbFDoMJnxO9UY/EOygH8JftBmKtgkr/Hp3sytpzdNB11MWC08vBkzhEqLDovKGWQB5sNrbbtlGLKnKnb1j1IKZHMSAS2+R+rof1T+BD+P2fu0tYmnsEsxeezLHsEyv8rclZMjbFbfewxGHvMtOKh4A1ic41a3W/dX9fSwUz5v6yxlKwXFGRp0qApTlrTGwUqRyzrxqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(2616005)(1076003)(966005)(6486002)(83380400001)(6666004)(44832011)(7416002)(41300700001)(26005)(6512007)(5660300002)(2906002)(107886003)(86362001)(316002)(36756003)(6506007)(4326008)(186003)(478600001)(66946007)(66556008)(66476007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YplyA5ho1nK15HNVSZVOm7wKr2KQUujsSZJnCuQGvajtFH1haivy+xWrF5WC?=
 =?us-ascii?Q?fd7xSibp9mfdgZ6Kr9VDE2IRQlrpTMyfefcdp71yT7Xq6ul/4+jAy3ss9cdz?=
 =?us-ascii?Q?lt5YkXp1SOvAoaf1l9vQa5d/VgJuSjb2hoTCca8jt7oLgdImzwI0AyCpCLcS?=
 =?us-ascii?Q?AEpyhMJpgCgJah2uex4Lvbr8w1EY9fufiE2JoEvv/pMQpU6j1Hr0mbrRaM6T?=
 =?us-ascii?Q?jJ7pO4i7QkoWZSam3BeAecnozcxxopmbr1LJq7l8EO9/NpY4FTad/bCEPFL0?=
 =?us-ascii?Q?gM41F8jJbQATPg0D78HBL0qs5QOUGGSw9KtshofdSoASDsVt1JAAo6amewdq?=
 =?us-ascii?Q?bCBNTl4SbJFoA3vg/W56qSzAFnSqBnBdt59TasZVRebLtcToAy7DqaQzhw5q?=
 =?us-ascii?Q?4xiMi5uQX/2ZUAVkBjfkVZZTDIwbeJlB28Kq7poZeKlu9+kXSfKyykx7Z+Mx?=
 =?us-ascii?Q?A+RIQ0M7uZesLjFPk5x7yUEClAF45pf80W6JWOL7iLM2K5Rj8RESuhQRGHht?=
 =?us-ascii?Q?aKyIajZS13KiRPhxhcU0TukMAxrIuRvJc/VFMscY78xWqIml889Ik2XtUZ0A?=
 =?us-ascii?Q?xWUrqsSaZancXfLyBSGYwZH1aZiXwHyVgmVqVuJzwwYt0HtSmlAkz+ErdHEk?=
 =?us-ascii?Q?UcDWNPWxK/hTxHoTwEzYn19duhgNESBCgdFk245ix4EFGORG2Q+8Oo+70WFe?=
 =?us-ascii?Q?dnwyhtHrE3SAQCICSn6Te/FJIEDBVCD6O9ttppxWfLKFCqFUC+wBELrjZyfG?=
 =?us-ascii?Q?AvdILe32GSbJTQXCab+gKVUTVBqA4u5NGwUXF19oHFNVI1lwLx69GDgpp6bV?=
 =?us-ascii?Q?efGJlD9+yEkKgmOhBhrcGdLUtgLxJuvr7B9AiqpoDf00U1bAyLBAscwuaFBC?=
 =?us-ascii?Q?W49+yZrTaTbMJ++AgNLgIPkKH+4Fs/I16VXNwR2osMpfBoRLy8q2D8r4o3iC?=
 =?us-ascii?Q?guiv7DLh2xnW6cjWz/ibBdpG7KV0FXizvTAk4UT4X3fsTb2Zleh/fwTknjhP?=
 =?us-ascii?Q?5ekx6hz0gBoM0pgtEJVmIQTxbW0mz7rgu1s8Vn0d+XEdRsYG6TfltVQy4zEz?=
 =?us-ascii?Q?d9aCwCBh5XWb3QBL62Q5dF4vlKiG/PUYd0BCoLdqJc2XkuxpQcm7cr/dZ7Cn?=
 =?us-ascii?Q?exOwUIot10uWPlqOdbKctkrWqcjT1Xmm7tRgB29OAW0BDMlUAq7W+fg71b/q?=
 =?us-ascii?Q?YPQrUPIGUP8Dc98lLfUueKipaUsuL3y1ILuNRdmxhvpUiz8n/wRrN+5kQn7R?=
 =?us-ascii?Q?eaTKxs12Yd4GugugXokJ3Te8CIRubVD5ogss8XmabHoNbn9lc2k4ZYYVi1SW?=
 =?us-ascii?Q?2CIX6zyfXP4RSN7bJMvuqtrPYP75Ugvv5VWu/STYZShEXjUQbgY7eZfesAAj?=
 =?us-ascii?Q?jCUYAsKBpC1Lek5xJ3veijzqAnbXn/Gkw3+MdKArA/oNIhEZ4/LuxJaNQVb8?=
 =?us-ascii?Q?5yCzMjzMXh+mdJRu9yw8H06p1ys7Wsq/csMWqIM/LxLFw4UU+ruJ76/IhGtB?=
 =?us-ascii?Q?5MoQYt374QX8OQKaWOaGJ1AH5/44c10qauHm/xsUDudlxpClpbvB03AkUFyH?=
 =?us-ascii?Q?8r972NftlCNYaHjtOwhmm3YhThP5XbeGeo3N4AytnIT60xYkHmGs6ys9GPba?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34a2fc9-a39a-4fa5-f9ee-08da9cb110b3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:42:33.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TM/8mDU2l2OL+hUDioxCCEHJwc4aFbdKgqYMEIdSOHfK0obOXdlQ+x/ZJl1+K/sqUeiFZeb7DwT2TcBeVGVPro0WH002VyUolAQMqNL8dHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=722
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220104
X-Proofpoint-ORIG-GUID: -V6ZitcvaI3r8VQsBzg0e-8FatBmweJ0
X-Proofpoint-GUID: -V6ZitcvaI3r8VQsBzg0e-8FatBmweJ0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series starts the conversion of the hugetlb code to operate
on struct folios rather than struct pages. This removes the ambiguitiy
of whether functions are operating on head pages, tail pages of compound
pages, or base pages. 

This series passes the linux test project hugetlb test cases.

Patch 1 adds hugeltb specific page macros that can operate on folios.

Patch 2 adds the private field of the first tail page to struct page.
For 32-bit, _private_1 alinging with page[1].private was confirmed by
using pahole. This patch depends on Matthew Wilcox's patch mm: Add the first tail
page to struct folio[1]:

Patch 3 introduces hugetlb subpool helper functions which operate on
struct folios. These patches were tested using the hugepage-mmap.c
selftest along with the migratepages command.

Patch 4 converts hugetlb_delete_from_page_cache() to use folios. This
patch depends on Mike Kravetz's patch: hugetlb: rename remove_huge_page
to hugetlb_delete_from_page_cache[2].

Patch 5 adds a folio_hstate() function to get hstate information from a
folio and adds a user of folio_hstate().

Bpftrace was used to track time spent in the free_huge_pages function
during the ltp test cases as it is a caller of the hugetlb subpool
functions. From the histogram, the performance is similar before and
after the patch series. 

Time spent in 'free_huge_page'

6.0.0-rc2.master.20220823
@nsecs:
[256, 512)         14770 |@@@@@@@@@@@@@@@@@@@@@@@@@@@
			 |@@@@@@@@@@@@@@@@@@@@@@@@@			      |
[512, 1K)            155 |                                                    |
[1K, 2K)             169 |                                                    |
[2K, 4K)              50 |                                                    |
[4K, 8K)              14 |                                                    |
[8K, 16K)              3 |                                                    |
[16K, 32K)             3 |                                                    |


6.0.0-rc2.master.20220823 + patch series
@nsecs:
[256, 512)         13678 |@@@@@@@@@@@@@@@@@@@@@@@@@@@			      |
			 |@@@@@@@@@@@@@@@@@@@@@@@@@			      |
[512, 1K)            142 |                                                    |
[1K, 2K)             199 |                                                    |
[2K, 4K)              44 |                                                    |
[4K, 8K)              13 |                                                    |
[8K, 16K)              4 |                                                    |
[16K, 32K)             1 |                                                    |

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/f0a284d27efbfcc1a46c2a6075a259e628ad29c0
[2] https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/e829be3202116d9aeb94cc1ff64e89dcbf7c47d3

v3 -> v4:
- rebase on next-20220921
- collect reviews by Mike Kravetz
- squash patches 3 and 4 from v2
- remove delete_from_page_cache()
v2 -> v3:
- fix build error by defining folio_hsate() when CONFIG_HUGETLB_PAGE=n
v1 --> v2:
- test compiling on i386.
- change return type from int to bool in patch 1
- move _private_1 field in struct page to within a CONFIG_64BIT block in patch 2
- squash patch 7 from v1 into patch 6

Sidhartha Kumar (5):
  mm/hugetlb: add folio support to hugetlb specific flag macros
  mm: add private field of first tail to struct page and struct folio
  mm/hugetlb: add hugetlb_folio_subpool() helpers
  hugetlbfs: convert hugetlb_delete_from_page_cache() to use folios
  mm/hugetlb: add folio_hstate()

 fs/hugetlbfs/inode.c     | 22 ++++++++---------
 include/linux/hugetlb.h  | 53 +++++++++++++++++++++++++++++++++++++---
 include/linux/mm_types.h | 14 +++++++++++
 include/linux/pagemap.h  |  1 -
 mm/folio-compat.c        |  5 ----
 mm/migrate.c             |  2 +-
 6 files changed, 75 insertions(+), 22 deletions(-)

-- 
2.31.1

