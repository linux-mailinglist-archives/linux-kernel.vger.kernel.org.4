Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35B65B9073
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiINWTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiINWTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:19:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E1F86C15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:19:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EMACHD029326;
        Wed, 14 Sep 2022 22:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Gsxm/1hzbwI5YCEaMDozVqtcgnXRFDIev726SYDrqyw=;
 b=t0UoD+xyo70TIZXXUy/WWeyP59VvqKWMSoNB2LbfjsDsfrCRYVwD3MiNgnIWls0NrIND
 yDwSg7XHYND0JBk3/ayxswuqRuejBc71jMyNYwZZsMCdHL0jTO/ZQmPtzO4kKIQB+smo
 6N9lb/Oizu3USee/LzRTAZDeRU8tMGgF7BC/uR42RI1KE9DzXbLvNuvOf9+YpoiizRle
 xdJT7/UPlCEQySS5PJaaHwKGK3OkjYQ6DWKTEd4LQnl7UAMA2iwlEofAiZbObIOPfe3u
 TyQrytaqAywaVnV+aYNwAkRobt+8b2vwzFDPxxXu/7PouDZCAGWGN5AySS5u/Vwfj1VG iQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxycbnrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EJ1dqi035524;
        Wed, 14 Sep 2022 22:18:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyehtdq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyAs7KMyn2YGShqjQEucATTn4SPjoD9R68511rhtZewNr38Hh+jgQH9OZGCkgZqkW//lgeoF1ipJ26wlMGfzHVUZvMNSFQBbpZnKZAvs/xksUMEn/8IKUlJmRwLKNDfWTaMsQ/bWUt01rKpgDECI9vQmDHyNuJadfSWP/RShTCWnSk3c3VbfVGXLS6gkKjr3ke3X+dOFv42jj4cbx7Rqzv1x9BVwsfy4SPjDOsjlhf2CIJRFeRei9d21JzCF76HccAGVqeHA3TKK2r6SEBWYsh5Auw3SXxDgrt1CKu0TEoi9OpWDwCI/c7bCMok5pPo266lFN8sl2bwbHRVVE3mjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gsxm/1hzbwI5YCEaMDozVqtcgnXRFDIev726SYDrqyw=;
 b=BWHadgknGL7b516j4XeRTVrWlibmU/H6ypki9gCSDJz8caBOuL/BrCHpLvISNZxY00/45I95lNuNDSUY9IJ1SCQHOyl6Wm4Glvd+Qbrw8Qp8LdkkrHyUAlil4SQarJH+ChCTpZUyqViR6kXhWkCOmxMRQ/o+EjlVmxzP7L1+XNizGkUtvZAVsAONttEgl8j0Q4/zOet1PimfdARAGbyEaPmWMkKxR2f6VWN7byRo1asetSlH2S9692o0Ay5rZOf++/wctnL/f4SS9GpgGeHbntrmTjGpX/R4vw66MKGSkLCYXBSjqrC4WsWb3jnfJysZxhUwCsl+TK2mENuHLM85gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gsxm/1hzbwI5YCEaMDozVqtcgnXRFDIev726SYDrqyw=;
 b=HCVBZBN7BeZQ+82Ol6Jy1cm2l/DWikqh7i/F3wHFERgEUa6n3saZuJbReBaElVAsFlB25BOF2OeV/HJVITGPk+xD5d8e4fM2CSi3mK2LBzD9XHGZf3nKl+Q2RRNpV1Edlzwo/Rdod0gxVLT2oD2Ju+IHE34F3AvImvn6QsQWF/Y=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5126.namprd10.prod.outlook.com (2603:10b6:408:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 22:18:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 22:18:20 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 1/9] hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
Date:   Wed, 14 Sep 2022 15:18:02 -0700
Message-Id: <20220914221810.95771-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914221810.95771-1-mike.kravetz@oracle.com>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:303:6a::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c3a85a-3d4a-4c40-d1f9-08da969f0821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOBSIGiEHnpxATbIRB3K9n1spLw7AnagkCqYAXYOTf9MAVTf/aB6mMq3co8l2nf2V+dads2VY/Itpt/qE5L0d3Kd9HlYTqL6+1CFzOIKSb+CE/eRFn3Knru+7V1sv4tUaXapLOQFgdgzhi89H/o48ogI9wW/emlN+/4FGEfHyiY63eSYgXXkYVtW137qq37jVwxIy4QJWL5JhG/MjMZFIfxxC98QGr4e8iot1svUROg4RNX5omo7xFGovQKYEDFUXdWFcVzbGZJOaKpNRBL3Jv8RNI/wAFu2hU8neouEAgAmbkjBv2nFdCLJT9h/i8mcGf4JWZUkNgbXFTnf12auYIyb4bn7EmgtZns7VdvLB64hXC6YovAr3CwszlxdTMUADJxY6mA3by5Lv+Py3H6E5uRUtnYBEjHhsc3nkb4Y1hJgcMzNyDVX04K9/AHBHUW+2aYj3jOTsM/t7JAGbFImVyENH3/F6iWWVmSHognUMFQx6IXMi0vENcaXkCVJSYGM9d9q3y+1Iq9lcK/85oWk6foKKuHqkHBlzrX5uaBpCxrtQynpEvZ7hW2PiaWK3OIOvns6LEdBJoDwB3Bt2MXDRI+A8wImtRkNPMIOnL37zQuK8yoEdWekyAzURuRV2VO67OOHc7w4r8fido4ZowHzRbmak+FITWOufWZ9+9ZILe8LmDgOkRPLlR7b8rh8SiUFYC6n0NEHGuQfwiatzpVpCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(66946007)(6506007)(107886003)(54906003)(66476007)(86362001)(4326008)(6666004)(44832011)(5660300002)(66556008)(41300700001)(2906002)(36756003)(26005)(6512007)(7416002)(38100700002)(478600001)(316002)(8936002)(83380400001)(6486002)(8676002)(2616005)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dH35fTSiRReeM70sD3rIGq8TrnUXO5yQGFRiSejmt4A53IoFu6xYvDhyZvVj?=
 =?us-ascii?Q?cywNEBHJZOMXEsYE63GmcICcPbkdWf0YpNzYKQ9vbf51ZTQcKOnW6UiPi7Xw?=
 =?us-ascii?Q?fNhgoFSXFhizb/g+L6cumLVc8bw0XYOSjT/feP+ghHJwPdxj2cuXeJq3y+2e?=
 =?us-ascii?Q?WY1DV6GEn86pj6CnGS1gbhDOZD2BbVFCenwUq9KziFkXk79jU4CdTvH9ZTv4?=
 =?us-ascii?Q?RiniHIqEybnvezOqHhYqIVpwTDqDZ4ttvE1IWVqibn+9vKf0aa++0IoGN3XM?=
 =?us-ascii?Q?qMlH88AYokLU4DpWvqsPRovFdHVEJpGIIdQOYk25/v55sX6Ev/8YBxM9nnFN?=
 =?us-ascii?Q?HlH0WjeMxQCZiBncWkDlTl9M4IHXfwt22D12wAH3t/6lkW+ycmDJoV5PHfqb?=
 =?us-ascii?Q?9oNslVDuaQ89gLUGjVttYRgCK/0cKVSLFEhN5Z5oFxR1i80tQkr3W8JWIZKM?=
 =?us-ascii?Q?VcrAmzNWrJUzzN7EYAlxkucJSiMXKdXLgkuHN3YRZYwY3sbep6kGPmD307dl?=
 =?us-ascii?Q?5OFkMW+352xyJ9n32IpwmLa80TM4rcZiJpDb5rrsKexyDXGFbZgtIX975L/E?=
 =?us-ascii?Q?Ku+foJwCjIeRocMKbhKvv0hWO8C2CJRRaHZnbT1yObxIqrFVu6zCqojtuv9+?=
 =?us-ascii?Q?fc8nTjgpWm7SLkEZnAi1YncGD8zenvoZxf65XY1VM+haUsw6Cqpu4kMay2K7?=
 =?us-ascii?Q?anWQwC/9cJIopjtMtuXwuid2FjdHSbd2kgjjwfZ8ZYT+62r05LZ3jGlBM78S?=
 =?us-ascii?Q?u+ZeCd9NZG/abWhirT/quVwWmdPNZAifiKmkPW1NNKvpX1BBp1MhYKnpGBNA?=
 =?us-ascii?Q?kLloWjuxJypdbYtUoWsK9IttBIZDqbFZH0MGgAl2MWCBLNLN1YzdncEgEiRd?=
 =?us-ascii?Q?jTtwcfnv+MMrikCZJAR8Bmr54Zc8q0tkrDYe1DdXC8weH5FbnP95nFU1crUU?=
 =?us-ascii?Q?1aeKch29zS5Ea2mGeTT+iULGWfR3RRQEWC/TYvyKtQgaOuFHhB+nGF3wlsIy?=
 =?us-ascii?Q?WhtktVneqcUvPTAjhsJQI+/5ELS4z7UpGNZq0tfg296jDmnBl7myS8IF5L90?=
 =?us-ascii?Q?6MPLsPjCYToSO1racXJfbRhBHknu7I3YxkIl5CMZRStw8geBs6Zwky7LAj7C?=
 =?us-ascii?Q?1LZ72mh0qRxZqdZMHQ9HuERu46Qj1RtdKoIHf6EMY0Io3JrcwrKmbJw7EU9K?=
 =?us-ascii?Q?haWESAk1xrMBqB1RRlFsaFvQNp31ISOaJajFuQAL16QNVUsTF6UAsHYazVFV?=
 =?us-ascii?Q?iR8q8zUyCEROlon7Uk87zBaD6oXmTLhHHNroCnn48gs+/m3163LSYFawvzK3?=
 =?us-ascii?Q?wkJkoYMzBjdfvt8ojtTea/k+Hpnm1q06ixOvRWvgwYKFn43LBeP5qaffuwno?=
 =?us-ascii?Q?X6DdDTEug70Wo04X2Ujo/cLbsDLclmQocUp3pR3YgWbf0hK5pkWtAh0egnaj?=
 =?us-ascii?Q?FdMby+76CvzZFl0vlhXwh0sO5y+cUmmNbe91JPXhYofFLjf9Zg/emdNEOvAC?=
 =?us-ascii?Q?o7Zipo6elZrjwrYmhc68Ue64L4JY8nrNeefprTdJidAX2g07d2o/RiD6DnJK?=
 =?us-ascii?Q?9ofwh+hcomqKEMVflz8nx43PAJG+Pc7OFfQLzAsdR/msC5Zb6qMUf7+1BBGN?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c3a85a-3d4a-4c40-d1f9-08da969f0821
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 22:18:20.7684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bf/w6rThK33agumlcukB7lnWd0mK0SYvbJW4oKZ/R6m7YtePx2/YmHoJAUJV3He2gfN5Zk19ZHdElCERFOXigQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140108
X-Proofpoint-ORIG-GUID: o0ru1XvVX_M_KTc6nyJUcJTeY73X9glX
X-Proofpoint-GUID: o0ru1XvVX_M_KTc6nyJUcJTeY73X9glX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") added code to take i_mmap_rwsem in read mode for the
duration of fault processing.  The use of i_mmap_rwsem to prevent
fault/truncate races depends on this.  However, this has been shown to
cause performance/scaling issues.  As a result, that code will be
reverted.  Since the use i_mmap_rwsem to address page fault/truncate races
depends on this, it must also be reverted.

In a subsequent patch, code will be added to detect the fault/truncate
race and back out operations as required.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 30 +++++++++---------------------
 mm/hugetlb.c         | 22 +++++++++++-----------
 2 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f7a5b5124d8a..a32031e751d1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -419,9 +419,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
  *	In this case, we first scan the range and release found pages.
  *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserve
  *	maps and global counts.  Page faults can not race with truncation
- *	in this routine.  hugetlb_no_page() holds i_mmap_rwsem and prevents
- *	page faults in the truncated range by checking i_size.  i_size is
- *	modified while holding i_mmap_rwsem.
+ *	in this routine.  hugetlb_no_page() prevents page faults in the
+ *	truncated range.  It checks i_size before allocation, and again after
+ *	with the page table lock for the page held.  The same lock must be
+ *	acquired to unmap a page.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
  *	Only when releasing a page is the associated region/reserve map
@@ -451,16 +452,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			u32 hash = 0;
 
 			index = folio->index;
-			if (!truncate_op) {
-				/*
-				 * Only need to hold the fault mutex in the
-				 * hole punch case.  This prevents races with
-				 * page faults.  Races are not possible in the
-				 * case of truncation.
-				 */
-				hash = hugetlb_fault_mutex_hash(mapping, index);
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
-			}
+			hash = hugetlb_fault_mutex_hash(mapping, index);
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 			/*
 			 * If folio is mapped, it was faulted in after being
@@ -504,8 +497,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			folio_unlock(folio);
-			if (!truncate_op)
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
@@ -543,8 +535,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
-	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
+	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
 				      ZAP_FLAG_DROP_MARKER);
@@ -703,11 +695,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		/* addr is the offset within the file (zero based) */
 		addr = index * hpage_size;
 
-		/*
-		 * fault mutex taken here, protects against fault path
-		 * and hole punch.  inode_lock previously taken protects
-		 * against truncation.
-		 */
+		/* mutex taken here, fault path and hole punch */
 		hash = hugetlb_fault_mutex_hash(mapping, index);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c6b53bcf823d..6c97b97aa252 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5559,17 +5559,15 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	/*
-	 * We can not race with truncation due to holding i_mmap_rwsem.
-	 * i_size is modified when holding i_mmap_rwsem, so check here
-	 * once for faults beyond end of file.
+	 * Use page lock to guard against racing truncation
+	 * before we get page_table_lock.
 	 */
-	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
-		goto out;
-
 	new_page = false;
 	page = find_lock_page(mapping, idx);
 	if (!page) {
+		size = i_size_read(mapping->host) >> huge_page_shift(h);
+		if (idx >= size)
+			goto out;
 		/* Check for page in userfault range */
 		if (userfaultfd_missing(vma)) {
 			ret = hugetlb_handle_userfault(vma, mapping, idx,
@@ -5665,6 +5663,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
+	size = i_size_read(mapping->host) >> huge_page_shift(h);
+	if (idx >= size)
+		goto backout;
+
 	ret = 0;
 	/* If pte changed from under us, retry */
 	if (!pte_same(huge_ptep_get(ptep), old_pte))
@@ -5773,10 +5775,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This serves two purposes:
-	 * 1) It prevents huge_pmd_unshare from being called elsewhere
-	 *    and making the ptep no longer valid.
-	 * 2) It synchronizes us with i_size modifications during truncation.
+	 * until finished with ptep.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the ptep no longer valid.
 	 *
 	 * ptep could have already be assigned via huge_pte_offset.  That
 	 * is OK, as huge_pte_alloc will return the same value unless
-- 
2.37.2

