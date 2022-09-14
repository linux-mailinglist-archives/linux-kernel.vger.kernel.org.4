Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3619D5B907D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiINWVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiINWUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:20:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCCC80F6E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:20:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EMAARs026129;
        Wed, 14 Sep 2022 22:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1Ip1504nE2rI5Mk0abFz7kLwYsrBv+Ysx7YZ81uNmX8=;
 b=uJZZLrnmYukpGEomRcMim6RLb3aHVVCFqbCAuhEETrj7jNDEMzzaS4l6gxCWfLE6HGNk
 pGRhFKxS8ngiJIgZ5ccer5MGyr03hrCeDX9pLCgHsvFMc+PQBlGP8sBynxJ55sVOuOKN
 ktGUGL7KrnrU8V+CUfMRWIMKM2edPzPewzWnSgrb7A4NZaKjDsDF+Yyp9uLsKuyb9lSa
 oD/yGHungRpHJtI4EXD4jdvnJH4BvuyAPwhZactRCpp3kW/mGrC/s/BwLRxCIDT67pjQ
 O0aVbql/8x0oCpiKRpcn07JkwcrzUr8vd+RiYu2lv1UxwYj4k16LgCuStb6FX98pOqze 2g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypbqrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EJAjlb035442;
        Wed, 14 Sep 2022 22:18:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym095mr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRoooO7fE/ST+x289RSUQ9p4OZwYdZ/lGZg5258R/MhzVjG2Nc0uiGDBVJYMzQfgAjws68YAW5acrMzt3fNG91yR4KpXLxsjVjYTMASaWpegm+ApdAm8T4zQQfo9trLxoltc2ooEUIYE3Rj3qqPBmUvyIfs3U2lrez5onIJVmZJK/DJez6MO6YNZOFDwsmBBU8IqX37CDwgUAEi2Shr4SJzo7fC1cSLe3hHcey95LF9n+M8h1U9nrYYopcnM6WxZU6iCTLp+r1NnwrndsarPnTROCfd2HxNE0ot+SrtlUG5KitNfH3cco18PPaZjjAV0MDdjDAFvcyb0Q1k6TAxO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ip1504nE2rI5Mk0abFz7kLwYsrBv+Ysx7YZ81uNmX8=;
 b=LlbwGiuFT4N8Y/w2joC8RV/j0WoGKynoJagxRFhb0J/SQHCNQZnqD+gkrLeh4nBRUfcwHqjD0EkqWm5yE+t0m0BB5MeyQ+hnsqW+hRuuF8N2MG4nXUoamora8YAqmDodqlST2MHhZizaTTKTIXb4ECF5snBPnSf6jCjRYGw+m9X25NLBOnfV6dfa5tIt0cMf2xu6v31dazzm7RI/YOQ237MQmEnUfzWnQ14sqq8ExSy8T6FbtRqugWA1byzVd0mDjoQsGtFS0Bykc9+4BaKvfO5WSfwB0e8pEBYkqlwESOtXGC5iKpnt+sD/uvokDPxEfPZKB9D5mX9MZj97kfHBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ip1504nE2rI5Mk0abFz7kLwYsrBv+Ysx7YZ81uNmX8=;
 b=b3fkDfIN38SrB0Mb/YQVaeUGsoneSBmthJcuJ4Of3LBLOY5eDQxKnBSS354ZcrvvXdi5unwD8GdcK2PvJKz9aBe0edvln0446DJrzFntCkiQdCAKrAVJ4Uqmg1CJGlQLZYcrekMOcr8oIHuSMY8IP8rUYU2s2xYFEmufTM0zuMI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4390.namprd10.prod.outlook.com (2603:10b6:610:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 22:18:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 22:18:39 +0000
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
Subject: [PATCH v2 9/9] hugetlb: clean up code checking for fault/truncation races
Date:   Wed, 14 Sep 2022 15:18:10 -0700
Message-Id: <20220914221810.95771-10-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914221810.95771-1-mike.kravetz@oracle.com>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7743fd-5bd0-4c36-1b01-08da969f130f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTFLaIG2WlgsxGmKzQac3tPw/zJzljptv29fCCCGc03Btw76ntnzuSBBjDvZgRkQyiriUyEfrWKBOhb/2UFGHSTyJONKCxYZVKJ03kJvPAwpOhk1eEJrgk/yHKUk9hwwNkwOY2h48r4g0XUUmucpLXZeOLqZl+pCC0ZWw4IZdcF2ZwgY8SjUXOgES4bT/G0jLjzgGtEM8DpyduXpLpFuC08BmZM61nhtLwCQvjW8BM4Bz6jk2vQPtnaKloIKUobZx/8hxoOBCByfxUvu4v659W7ZRcq42ZjghOdStYM4RxPuN6M13YHh0LcWHqGYZvtY6hyt1v9F3tqu8r12hF7fLtWfgmhlzOBWicbmkQzYEoVu5MWyH0EP5aCYBK3UFfLGk+XQPrKm3XKtp1zVmsn4XvfDWzKbeSZu0iikhm3s70DUNaNrZ66bZfzFFCjzmgdz6cY/vKFMaNm8WZQbsK8Sjkjgsl8DHUub8N0+1U6HPHmJ8l1Ns3AvRj+GgChTb5IIEyG94CtCy1JEumLziz0ws6ZlhgAmD+DP7J6U+J58TtkaJkhDLiZX12svKF9t4ddhGmsQhpDcb4cdzZk9Dn9I4eEHMEv7inwWjlfrHyhAj47wNB/ApSyfwjnw+hHQjRieUKiMuyXWf936Mr57/Y2WLsRupXzpZY9a7B+/UEFK/7V62neE+XrZ1+p1r3Le/jlO6CIS20X2UVVXdOuV2dzWZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(6512007)(7416002)(6666004)(86362001)(66556008)(36756003)(8676002)(107886003)(83380400001)(6486002)(66946007)(54906003)(44832011)(66476007)(8936002)(5660300002)(316002)(41300700001)(6506007)(478600001)(186003)(2906002)(38100700002)(26005)(4326008)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8r9+KVXHc3zgim8RH2NLp1PfvqiGZHIBjFW03EbQUv65Hgr/4BsSv1vp/03O?=
 =?us-ascii?Q?ice7b0M+tDD1SXJ7MPQUrHjoJ1I41hr9sFMXoSD4R428lXm31VN5uo9A3WcP?=
 =?us-ascii?Q?Oo/0W3tlH9KQ0oZTpMxF1qCeCkUQKytYmVa9c2+uwXHhYz1weQ5W+fX4fhDN?=
 =?us-ascii?Q?o1IhOxoTR97YzpXHFaM5rSSUAMbdz5PMHZ/Yj2+ivSCwUhb5wGiGVI+5jNFK?=
 =?us-ascii?Q?2Nj0jLP/ogcg9NBdj6S4TtNoRGr2pRhOKncH7V+kxDhKgO7IkXKc9M76ORZP?=
 =?us-ascii?Q?bNvSqzULQ5Qt3lME+DNe+UBAF1vhHK3mBj2kOcyjaIipx9n1feN4HwKseXZ2?=
 =?us-ascii?Q?Yfa7EUQ0O6F7O8KRsKE5cNVbmBq+KmmG3vvd4EoNK5PLqMnLOkJzQXTmz8Q4?=
 =?us-ascii?Q?j8+Kh67DD3bz4+DqYJ4yHHS+YNFd2eM4uRdIsDFMxcr3T36deFQdaUvmdn/7?=
 =?us-ascii?Q?lC42NEL0pjERfHc1l5ezzaUdHR+HAAIEsDBLgoOApPqffkFkrOK2NIiqQi4J?=
 =?us-ascii?Q?lj/BcNcRJ5NjLEWcR5uhoHdbHBzA6GAF+2WuemVUkf3TyN3bdq90My5gQvMc?=
 =?us-ascii?Q?0lsN/QPZj5OQDVTSANCFIzo6dE5MAwXWp25FntlSMt8vMYfRPjrdF94PtK6q?=
 =?us-ascii?Q?XYTQSCANNHzpvdLgJcj20FjRwDzKx8z6fACzBAtJWj/hD3t/Uni1q4Jlqw1J?=
 =?us-ascii?Q?Fut2gPMLlr1xutTAp9ljrJvsSrYxVixC3+xkMJf8ZrIl+OgWsJeHmd/uu1IH?=
 =?us-ascii?Q?WLX0qX9TlKJQmKXNXYW8I1mDLs61Toyrg0irYxyrI26dhVeHuG1vJ3SMD0M3?=
 =?us-ascii?Q?aeUgNCOrpGo8kfwV06mB7syPU5dEZrVoB5itM0Nx5gETecOczU1deguewamb?=
 =?us-ascii?Q?UCvkBkDhFixU/3QbVnCMBqbyXgbVnoyADcb7ujKlJ9yZANQ5Fiy1FV585irO?=
 =?us-ascii?Q?WvVEWg3L0J/a8vuFfKBqyKWJ94fhFOpeIMWPC3NK8uJesFwrxB9cGIcaZEDG?=
 =?us-ascii?Q?vEDUz7phepkM8A5dGM23FwKMUp/1ViHzSZlw3UaHLB9BGszK7wMNa1JCfD5u?=
 =?us-ascii?Q?drHbSoJWqpr4k87nkNmQbFnCKHWxu7i/f2LWkjD4LWck5/uZE/ZA8uYOETVh?=
 =?us-ascii?Q?EDLUygF5zyUWgT4RqCmJN6FEdac+goo7GE3pGDsY9FvExRP7LLmAref3wGbf?=
 =?us-ascii?Q?DWf1736dysjoRP5UruLtqSKLR7IpLLVZxaaBVrrexsp/DqqhjlTXXgEiwFB8?=
 =?us-ascii?Q?ZijXChcdTu8fhCP2XmF6BpnnazUxkWOKTtFeh8BDEyuuPVpwjLNSqO8roJEH?=
 =?us-ascii?Q?Bv8OCRMaBtWgMXj0+4j/82fl2XF4vNZgxpLZ0bnHqsDqfDq0E4riRvrcTtIn?=
 =?us-ascii?Q?vm2n7mrkmiDgdOhDsKCxibSlWf0tJN4b3/06HuPxUDqc2i3Cf0QMs5jqQcww?=
 =?us-ascii?Q?zhloP+OeQx/dJI+EMQD75hBrEe8QUax3qwKeFmPZQ7V8SaGeXBknyBrCUuA0?=
 =?us-ascii?Q?720FYkU/Zu3dja9gZnlrplhhVvFWAgmusy/biCFk0Zx7U07JG5OaosPSK1uf?=
 =?us-ascii?Q?1I2CwoddnekCtOLQYNS7Fu5czJKT1cwWrMIbCbKr8fSy5orUQkRM5BbGD4Cd?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7743fd-5bd0-4c36-1b01-08da969f130f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 22:18:39.1007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLu97R1moiteSWs3Bor2WiRp5gSM8bAmnqM2xvCQ3mjdzz2zQeVTBvkXUdCDOdTIYRUbmY6eM4YiOvxovkA7xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140108
X-Proofpoint-ORIG-GUID: uuq0JspoIzDwcGOp_ylP0s1lJboeLOqg
X-Proofpoint-GUID: uuq0JspoIzDwcGOp_ylP0s1lJboeLOqg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new hugetlb vma lock in place, it can also be used to handle
page fault races with file truncation.  The lock is taken at the
beginning of the code fault path in read mode.  During truncation, it
is taken in write mode for each vma which has the file mapped.  The
file's size (i_size) is modified before taking the vma lock to unmap.

How are races handled?

The page fault code checks i_size early in processing after taking the
vma lock.  If the fault is beyond i_size, the fault is aborted.  If the
fault is not beyond i_size the fault will continue and a new page will
be added to the file.  It could be that truncation code modifies i_size
after the check in fault code.  That is OK, as truncation code will soon
remove the page.  The truncation code will wait until the fault is
finished, as it must obtain the vma lock in write mode.

This patch cleans up/removes late checks in the fault paths that try to
back out pages racing with truncation.  As noted above, we just let the
truncation code remove the pages.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 31 ++++++++++++-------------------
 mm/hugetlb.c         | 27 ++++++---------------------
 2 files changed, 18 insertions(+), 40 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 009ae539b9b2..ed57a029eab0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -568,26 +568,19 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 
 	folio_lock(folio);
 	/*
-	 * After locking page, make sure mapping is the same.
-	 * We could have raced with page fault populate and
-	 * backout code.
+	 * We must remove the folio from page cache before removing
+	 * the region/ reserve map (hugetlb_unreserve_pages).  In
+	 * rare out of memory conditions, removal of the region/reserve
+	 * map could fail.  Correspondingly, the subpool and global
+	 * reserve usage count can need to be adjusted.
 	 */
-	if (folio_mapping(folio) == mapping) {
-		/*
-		 * We must remove the folio from page cache before removing
-		 * the region/ reserve map (hugetlb_unreserve_pages).  In
-		 * rare out of memory conditions, removal of the region/reserve
-		 * map could fail.  Correspondingly, the subpool and global
-		 * reserve usage count can need to be adjusted.
-		 */
-		VM_BUG_ON(HPageRestoreReserve(&folio->page));
-		hugetlb_delete_from_page_cache(&folio->page);
-		ret = true;
-		if (!truncate_op) {
-			if (unlikely(hugetlb_unreserve_pages(inode, index,
-								index + 1, 1)))
-				hugetlb_fix_reserve_counts(inode);
-		}
+	VM_BUG_ON(HPageRestoreReserve(&folio->page));
+	hugetlb_delete_from_page_cache(&folio->page);
+	ret = true;
+	if (!truncate_op) {
+		if (unlikely(hugetlb_unreserve_pages(inode, index,
+							index + 1, 1)))
+			hugetlb_fix_reserve_counts(inode);
 	}
 
 	folio_unlock(folio);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e8cbc0f7cdaa..2207300791e5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5561,6 +5561,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page, new_pagecache_page = false;
+	bool reserve_alloc = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5616,6 +5617,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
 		new_page = true;
+		if (HPageRestoreReserve(page))
+			reserve_alloc = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = hugetlb_add_to_page_cache(page, mapping, idx);
@@ -5679,10 +5682,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
-	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
-		goto backout;
-
 	ret = 0;
 	/* If pte changed from under us, retry */
 	if (!pte_same(huge_ptep_get(ptep), old_pte))
@@ -5726,10 +5725,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 backout:
 	spin_unlock(ptl);
 backout_unlocked:
-	unlock_page(page);
-	/* restore reserve for newly allocated pages not in page cache */
 	if (new_page && !new_pagecache_page)
 		restore_reserve_on_error(h, vma, haddr, page);
+
+	unlock_page(page);
 	put_page(page);
 	goto out;
 }
@@ -6061,26 +6060,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	ptl = huge_pte_lock(h, dst_mm, dst_pte);
 
-	/*
-	 * Recheck the i_size after holding PT lock to make sure not
-	 * to leave any page mapped (as page_mapped()) beyond the end
-	 * of the i_size (remove_inode_hugepages() is strict about
-	 * enforcing that). If we bail out here, we'll also leave a
-	 * page in the radix tree in the vm_shared case beyond the end
-	 * of the i_size, but remove_inode_hugepages() will take care
-	 * of it as soon as we drop the hugetlb_fault_mutex_table.
-	 */
-	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	ret = -EFAULT;
-	if (idx >= size)
-		goto out_release_unlock;
-
-	ret = -EEXIST;
 	/*
 	 * We allow to overwrite a pte marker: consider when both MISSING|WP
 	 * registered, we firstly wr-protect a none pte which has no page cache
 	 * page backing it, then access the page.
 	 */
+	ret = -EEXIST;
 	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
 		goto out_release_unlock;
 
-- 
2.37.2

