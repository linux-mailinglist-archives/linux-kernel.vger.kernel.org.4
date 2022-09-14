Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8055B9075
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiINWT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiINWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:19:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6757286C3E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:19:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EMIW4w015296;
        Wed, 14 Sep 2022 22:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=6ivtxW+IRCVlKCBX7kIWyo1zJFXhNtt3pmRL4dhkLoM=;
 b=I+lre44FO8s0M0U69LG3tY8Pe8YkS0JC1yN2GEAsXGc02DL4IuvpQni6piIP8TmRhTw+
 BnFhqL3/aBwvowC4t9pXQzDvH+UVfmuuXlrxeoSSO+ftPdi+3/1Vv9oIEZrOcNYKyFnl
 1McVAWR7vChS2Svf6vCE/CAZry8mZsU1iCx8qPmcOoXKhDimRiF86KqW/avE4SeBwDMc
 qysdFg84//ikwimKfiVhhrm5RzrIW1R1mBf6rrBsXugLt3m3ZK9XtTTJBid/FrvpJrNe
 vN8yNeLe/enM6xCe02AFI5gwIO7/w2iirZKBCwn0caK7R0Blh7eQ21SY5qN/T1WP70iV oA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxycbnry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EJ636Z006504;
        Wed, 14 Sep 2022 22:18:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy2bjuh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iycipkIzS93zggF5NZArGo7Sb/sDycsYbs6EclebenBIXIW542AXdYt0vdD4qhI/6/IBKPrYF/sS/zJ3+TSOzxz7EidS1Ajvs5oxOmYTZXt+gLEk2IQI9vB6F0JNSJ03uG4PM2WENfjZ/Bybe0xeXaaNl5xOwqLAx1yelM1gP0MhHgV+wqLb1U3X7GYqiWyQ4iPhSV4zUrZ4PtloAyXobpFDbum0BRme8HN4gBmbkRvvZRdahrmFV/mOhATw+OebFCv/NdVw3ASVW9j4iwY093LjHgcjnszLLdjk+PcAWvEZEPNZaeqSqHgMYGHi60TkxnPyk1eoWT9mi3FHnZCCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ivtxW+IRCVlKCBX7kIWyo1zJFXhNtt3pmRL4dhkLoM=;
 b=QXZGb0dYcRSedrQtIPn3ueGswyZRCrrd+hBTIBnHumQ9UdKMeGcBIKy0H2f43EmwA2/0wKoOvvcf1LvGcjHUuYsrNjgmCjnp5xYANRtSRrvS4bSdHxXvWPWS1/CBlW2V3c3Cu0gkzdTv1rD2etAlOZqQWqZPxcxuD21L0SwPffiKM68NRDPPnMsOQmGolZtYIiEIJJDuGvhvdfCQq8ccP5xme+6YM7AOmkWyiSq1iSTuREt2JzDTBNT7m650O11Jy7uuez2AwYV3QnAINEHDkEejZFlAf5tlv84zcTLZdptjE7ErA7eEO44J76eadhaM44RdaHFDKhKtDtmPevKBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ivtxW+IRCVlKCBX7kIWyo1zJFXhNtt3pmRL4dhkLoM=;
 b=jcXVK2GNCO9wnzgsK5xoxmKMt4DYHOEc6YPzrUR0Wv6ayj4aDiAqFgsiyaPlMHOP27v2nP1mxqnsqWWfKbB4HiGx4QNVfOJU0ChvqiJsup+0W0g0FmdU/DzgaTl9dEP9B2HHxGOkSdGcJhX31VSKNY/JdqhAA+mJNjWNtVvZowA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Wed, 14 Sep
 2022 22:18:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 22:18:28 +0000
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
Subject: [PATCH v2 4/9] hugetlb: create remove_inode_single_folio to remove single file folio
Date:   Wed, 14 Sep 2022 15:18:05 -0700
Message-Id: <20220914221810.95771-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914221810.95771-1-mike.kravetz@oracle.com>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0156.namprd04.prod.outlook.com
 (2603:10b6:303:85::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f30175-95d2-458e-e2f4-08da969f0c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOtt8tSkYhN3bY41zBn9JpHPI5+XldPzOHMe3U7RDO9ZbUZVRIHsPrI3WSuUO9qhwrwTQsznmWfldZN6MR3qsm/m0AKQQnKl6KvXa4K2LNiaB/aHod+EVMiDtQpZCaUpwEOUy/Mz+MUaTtgyBupb5PGgcUnut0KwWWB+P0dBPniNFXqPLbrmfiqXjnNUXTGX8qViE9oAYfsXQW7DBHQQU2524IlWoGajzEDSCayYYmLXLcqbzoa7WacpMDGHSifE6os2uICqYjrUsKT65zJR/Lyun71U/wsZT+JYecjy6aQVsRYKRu39t1lxtFMUvnDStp82Z7EqceVW/VZJeZuxVT+iu+SQxXh+3U6KCEvrDai2QlXqb/AFfT2UJZMgXd1qvckFdbM3udL6JXBDFSEEGX/jfulg2XfQsoBK97kw/39Vo8J4oWlb2hoOQOwKyGHpAUkPeLu0QlnbJMg4v0dG2uyq+NkXbch1Oo6BV6HJ9w7WmiuLyzJZviF92zRDgeIm1Dvx32uWUhl/hJVmFRRRyMgQkahBgz8YQI6xawmN11Mgw0GDQAVdm0NaBD5VqgCJ/tTIgTalRHqz9y40mCYC1eJ38NMMA4WEA0Hox4Lj5D2xwX/2y9W45X9y3A8/8QFy2g2j/gboXl68MlMWtbWpKzefYu9KvB9B1ZpqL2i7EDiE954T71zoaQs2VheBIfkXGfsGD/3fBL/9oR6JTyutZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(478600001)(38100700002)(54906003)(316002)(36756003)(6506007)(8676002)(4326008)(66946007)(83380400001)(186003)(2616005)(1076003)(5660300002)(41300700001)(107886003)(66476007)(66556008)(86362001)(8936002)(6666004)(6486002)(7416002)(2906002)(26005)(6512007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s5Aj33NahkbR6fy9WTa2aL6kpGY87TZT9GcXP1EH1smnte6MJ9nrsaedGZSu?=
 =?us-ascii?Q?e2W9XnuSIWzjvnWZQvm0uCfBWJRsUDH9JwwbObMvji2+cXFSAr9fdz2HVllN?=
 =?us-ascii?Q?m7oyp3NVmIiANp9Gbh5SWYEh5fXFgYE8XIfUoZLo4qpIyHEas3qrPvqckPMi?=
 =?us-ascii?Q?oHbkdVjKVcav7n4DguHVagaVg3G8/sMDsFAiOq2/xFTJGUg9Xof8wH0YX5Zc?=
 =?us-ascii?Q?I+b3uXeds1Z6ixmAw6HUro3giiI4rHa5vHlnjSAFqhfPJH7LpcPinWFm5GEP?=
 =?us-ascii?Q?Alv0B1G775NNMA7NXENdaf7vJZR3HI3Hc33BNl3llI6gUFBEQVWjz7nrNpOI?=
 =?us-ascii?Q?182jTEQY+F2RlXZTTiesVWr/y0uKlybpy5zScDzqO8ZN9ye3qUtJN/qjbqeG?=
 =?us-ascii?Q?jqEDwb/R35xj+UGhiCyTCXCmfOiadrXqyfp26G4hY2P8Va3HPr4Pot7GvF8/?=
 =?us-ascii?Q?FLyGMxEGItB1WVCNM+XUtUIomir7OCHZFAAQYqFF690N4t2ThuOr4VpMLSvH?=
 =?us-ascii?Q?qfHU4cRwpelU2kPmqfuEXLrOB1W9dXlnVqXQr2wxAxtwtq1nTiwWBMOBF8yC?=
 =?us-ascii?Q?v6xUb4BbLctFSfN0Cr+4HxbCLZkWT142byDvNYUyWaHZ0I2nA/TH2RZfdAV0?=
 =?us-ascii?Q?AZqv1VPoIj4kRwt592oFWP6orHf9pjr8vD2lE2kC+H4W7nJoVa1+z6FxdjTx?=
 =?us-ascii?Q?7AtZjBN1dLbJJc8ZfaDgrrjJ2PPLS4FZVbLseVDr+cX/L9KmrHSxHDIZhSTf?=
 =?us-ascii?Q?IN3u2yFVQ4W3U894NvhuYbvESryjUw2nJFGxx0i81erEsgZVVyY4nr9rhqGt?=
 =?us-ascii?Q?bXKlEYcZ06DFa0e7JdM0uDaxfRfi3vBYo3JQsf46NRkHnYO9MsNWQz6bthDF?=
 =?us-ascii?Q?TQNyZlQf4NQb5lX+/7AZZskVqheA3LGsaDLvnxAIIynFxZW6APvo1iQPG8OM?=
 =?us-ascii?Q?fqM2l5EG6WTgmP1Di/RnbFFwmP0h5+z03IWZaoRTe5mpHI6NJ4CTUw93FoyY?=
 =?us-ascii?Q?whnToCGOcsOQOi6nBXi+iaXee9LWWaZkQd0TZR5/oSIefIQ9YDJK7jjbcqP6?=
 =?us-ascii?Q?Ac2PqeEb/DdIRiW/tWcZ16NIVnMYys015KGEj2ZDx6zSe8q9pW+D/KjG0K4e?=
 =?us-ascii?Q?A4/Z1ICcvtgPYM4M4mjDXQ/jYGo04eF/cjYxb6CUK4GrNd23B5PnhILHXqCx?=
 =?us-ascii?Q?JI3hNRg/OQTLZo1kDeoWX0ylF3t2OjcV2EcSZ1pCej+yFnSalcXSgY0a5Sh2?=
 =?us-ascii?Q?rwBohWZNNhOsmupn3gsf6hmZy1fpSuHDhetEpoqXjhFxNwDne1uQ2KukAAlq?=
 =?us-ascii?Q?Y4eNHgyGe+Bd1a3tEE+P5XK3KH4LNoELOFKS2rC2mCG5H4vWkW/xfZKevydo?=
 =?us-ascii?Q?4Wr4fLvzgIUMIXtzp460/ZzRCFRF6BWAfYJhFbmrKbieKiqPlPqNnQbd+1LS?=
 =?us-ascii?Q?rbrniFoMqJjssLz5lkRa1gAOYpCGW3clKdF0vsw0uP0M4mx3rB+e7USqaWlu?=
 =?us-ascii?Q?4woGcoAtuORZHhnTppZgKcwetWPxhxAr2ZCkqwZJVLeIcSCGvCmXt686V4Rh?=
 =?us-ascii?Q?fW+Yq7xjWt2w7AjZ/60eiqHN/ZXGshMJ3Xq/EU4qnE4ZhYSL3SQ7HguOVMzM?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f30175-95d2-458e-e2f4-08da969f0c7d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 22:18:28.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBTpN4TeVvAJc/ul7F0Mt0A2ljYCFrNvSd8T4YXRumDlyicSk4mnUmSyC4PCZu+sJTvtU00g8cXUAXJyZK2wpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140108
X-Proofpoint-ORIG-GUID: xBN2k2TtQfk0k7oxqVQj4K85fe08Lf9H
X-Proofpoint-GUID: xBN2k2TtQfk0k7oxqVQj4K85fe08Lf9H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the new routine remove_inode_single_folio that will remove a
single folio from a file.  This is refactored code from
remove_inode_hugepages.  It checks for the uncommon case in which the
folio is still mapped and unmaps.

No functional change.  This refactoring will be put to use and expanded
upon in a subsequent patches.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 105 ++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 42 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index edd69cc43ca5..7112a9a9f54d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -411,6 +411,60 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 	}
 }
 
+/*
+ * Called with hugetlb fault mutex held.
+ * Returns true if page was actually removed, false otherwise.
+ */
+static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
+					struct address_space *mapping,
+					struct folio *folio, pgoff_t index,
+					bool truncate_op)
+{
+	bool ret = false;
+
+	/*
+	 * If folio is mapped, it was faulted in after being
+	 * unmapped in caller.  Unmap (again) while holding
+	 * the fault mutex.  The mutex will prevent faults
+	 * until we finish removing the folio.
+	 */
+	if (unlikely(folio_mapped(folio))) {
+		i_mmap_lock_write(mapping);
+		hugetlb_vmdelete_list(&mapping->i_mmap,
+			index * pages_per_huge_page(h),
+			(index + 1) * pages_per_huge_page(h),
+			ZAP_FLAG_DROP_MARKER);
+		i_mmap_unlock_write(mapping);
+	}
+
+	folio_lock(folio);
+	/*
+	 * After locking page, make sure mapping is the same.
+	 * We could have raced with page fault populate and
+	 * backout code.
+	 */
+	if (folio_mapping(folio) == mapping) {
+		/*
+		 * We must remove the folio from page cache before removing
+		 * the region/ reserve map (hugetlb_unreserve_pages).  In
+		 * rare out of memory conditions, removal of the region/reserve
+		 * map could fail.  Correspondingly, the subpool and global
+		 * reserve usage count can need to be adjusted.
+		 */
+		VM_BUG_ON(HPageRestoreReserve(&folio->page));
+		hugetlb_delete_from_page_cache(&folio->page);
+		ret = true;
+		if (!truncate_op) {
+			if (unlikely(hugetlb_unreserve_pages(inode, index,
+								index + 1, 1)))
+				hugetlb_fix_reserve_counts(inode);
+		}
+	}
+
+	folio_unlock(folio);
+	return ret;
+}
+
 /*
  * remove_inode_hugepages handles two distinct cases: truncation and hole
  * punch.  There are subtle differences in operation for each case.
@@ -418,11 +472,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
  * truncation is indicated by end of range being LLONG_MAX
  *	In this case, we first scan the range and release found pages.
  *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserve
- *	maps and global counts.  Page faults can not race with truncation
- *	in this routine.  hugetlb_no_page() prevents page faults in the
- *	truncated range.  It checks i_size before allocation, and again after
- *	with the page table lock for the page held.  The same lock must be
- *	acquired to unmap a page.
+ *	maps and global counts.  Page faults can race with truncation.
+ *	During faults, hugetlb_no_page() checks i_size before page allocation,
+ *	and again after obtaining page table lock.  It will 'back out'
+ *	allocations in the truncated range.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
  *	Only when releasing a page is the associated region/reserve map
@@ -456,44 +509,12 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 			/*
-			 * If folio is mapped, it was faulted in after being
-			 * unmapped in caller.  Unmap (again) now after taking
-			 * the fault mutex.  The mutex will prevent faults
-			 * until we finish removing the folio.
-			 *
-			 * This race can only happen in the hole punch case.
-			 * Getting here in a truncate operation is a bug.
+			 * Remove folio that was part of folio_batch.
 			 */
-			if (unlikely(folio_mapped(folio))) {
-				BUG_ON(truncate_op);
-
-				i_mmap_lock_write(mapping);
-				hugetlb_vmdelete_list(&mapping->i_mmap,
-					index * pages_per_huge_page(h),
-					(index + 1) * pages_per_huge_page(h),
-					ZAP_FLAG_DROP_MARKER);
-				i_mmap_unlock_write(mapping);
-			}
-
-			folio_lock(folio);
-			/*
-			 * We must free the huge page and remove from page
-			 * cache BEFORE removing the region/reserve map
-			 * (hugetlb_unreserve_pages).  In rare out of memory
-			 * conditions, removal of the region/reserve map could
-			 * fail. Correspondingly, the subpool and global
-			 * reserve usage count can need to be adjusted.
-			 */
-			VM_BUG_ON(HPageRestoreReserve(&folio->page));
-			hugetlb_delete_from_page_cache(&folio->page);
-			freed++;
-			if (!truncate_op) {
-				if (unlikely(hugetlb_unreserve_pages(inode,
-							index, index + 1, 1)))
-					hugetlb_fix_reserve_counts(inode);
-			}
-
-			folio_unlock(folio);
+			if (remove_inode_single_folio(h, inode, mapping, folio,
+							index, truncate_op))
+				freed++;
+
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		folio_batch_release(&fbatch);
-- 
2.37.2

