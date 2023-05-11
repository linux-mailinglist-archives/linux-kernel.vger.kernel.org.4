Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B1F6FF7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbjEKQ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbjEKQ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:56:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272DF30EE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:56:07 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BDwwtD006607;
        Thu, 11 May 2023 16:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=kyF58D5NbjAxslgZAu/gDp5+Ult0KlMoHtLNnm6xYdE=;
 b=wZ6sU9TPM0nJXy14KUQEh5+c4x94pltU6oecx2gEG+tfj153cMHrf7cnsalhoWKo3o2g
 7uLn5OW78QljTZ8oBQH9fvLwVvT8zR6PxkG1X9NPogE2o/sJ0QADhfmvZKOCjivLI7li
 C+L+1zY94KfERILo6iS6x1GDHGwgMr39QxA4R/rvBcdKBuvB0ozzuMb0RXiGQTGd9hi4
 LaFcMHTmrgxyfjNyHDdqL/jezyMtZtSKUd3OZvCWHE1ZFI3EEbAw++USkVOOTlhC0rZG
 m2BU8OTqGrdGdvfo4hj+uvTRz0YOFiPR46ULApD1cCbqdIwdP/tnQgZOQoc5lAd50m19 rQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77dfr48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 16:55:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34BGTv9C014484;
        Thu, 11 May 2023 16:55:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf82yp6k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 16:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXBnQgJdnl8zPXuEx80TBB74es4XKSIWvMn88VUdN38erzn1KWaEYKAix1uQiiQKaz/EztfyANXNAiNzE1Bu9H8GuqErJROlgKAi2CWuq453mq+H7hE3COTeU3s6VFQ4o+77C13FXu9rUzcBeFF2bzBp9EZxG5/TXotQfC0IX6Cpm47b8HdG/d69L+r+XyWvwO260CXvJtxyvVhvAV4FAAQ0IbLcw79nLMrALiczJW2GaDF8+aW2OMzFAbmQ0MSARbgLZlPx2uWX9rdaJhDeVEeYxALYTpnyY+a/hS7ez/kD/adxD00cCideXxPnkDJFAqKTJNZ7K/J1wL5jdN9zeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyF58D5NbjAxslgZAu/gDp5+Ult0KlMoHtLNnm6xYdE=;
 b=RQvJ9d0TIvKNF6QUZTzi3lo/oaPF4mrrA8iRIQBKVAchOQuHz9GK6Q+czsj4q5RrXPUIDGmhWvReJL/GvPxLOOCpYoNCVKb48p2vAPrio+NzH89G1Z0xR7PZG0oWcLHo5E1nlK8A4xO5e7feUDtP4MF0LrtHvzAxEha632UvwIm7vMDM8dBhHHvuYgU+n0dZu1W8p+J0dDdyK91wssVVX044PGWdbfN7ObRK5zjkxKKW+stnoeh87YdqJ9I/reRz65yIurOaGbsy5GKVZJLeapJtjNLeOrACNqGwFya2ftRm7easw9pf9JrnXXs/CAPqmhCp4pYB+JozaDLVZtG7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyF58D5NbjAxslgZAu/gDp5+Ult0KlMoHtLNnm6xYdE=;
 b=bcQ+GC4Q+R9SADsnSucsdCDExc3Q3V3ZqYr40SmovQodu8LXWI5ku9J5mB6ZWQR2v1HZvS/tAqyHD3EsuIOCe0HrQLzTHafVQY84shWqYchUVlY59ruwA74YGHGtaLQjsv5bCptI1LqIBRQcN6/aF7TZEu5rfTy9yPSz9EpgMT4=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by BN0PR10MB5160.namprd10.prod.outlook.com (2603:10b6:408:115::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 16:55:43 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6387.018; Thu, 11 May 2023
 16:55:43 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] mm, compaction: Skip all pinned pages during scan
Date:   Thu, 11 May 2023 10:55:16 -0600
Message-Id: <20230511165516.77957-1-khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0035.namprd05.prod.outlook.com
 (2603:10b6:803:40::48) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|BN0PR10MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 866ae541-337a-4be6-b944-08db52408ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eY4LDAw5IzmpFIDNUrqrQSBGqQeAY4T7pN7TPQstp3TWjDYndNE+IK3ChN5a1aqXqxa3W95QqDrHMdFl/2Bjxc3CXXNR043eAxmXGB5uDId9+1IiLUXCYWizqdjFNsDMsROpBBAyerHlB/W69WNIMAzc2HzUkHWTvTTbFXGIwJN1S/XAtjCAW0u1ziUqQ5duXoEBKnEH0+rdg7RQE8PUZOVcQED3L1IUKhxeNuqVDzi1qW0RI9mDhvVebYvSJ6aqFgk2802brDvaCcGkW4IXpCVKNtqHijV+zSJK4heHMmpO0wnFHAkM07yUQX/jiDFO3mKkuMFh7DigT/kLEkJWyr51EjygLtGfwzgptjrCqnxjo9TM+Ga6rLIq4yla2L8GL+4rQ8nwx+N1wIHso7ynOqYsEUHiWtSsvbag5Zoh5YJ4CTxoeeWmvLP2aDT+zmbeb7LagyDsq4GasUTHfhoUtdIyXA4s4mC7Faz/++aOM1WeXpfcExoOsETg+SU6VWRg08R90l6lNffCvaWVfDXxzNSNLyqHYaqHc9KXSk4tX5IFM+Z7bMSw1BL2Yczzt36s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(8676002)(5660300002)(44832011)(8936002)(66476007)(6916009)(66946007)(66556008)(4326008)(316002)(38100700002)(41300700001)(36756003)(86362001)(2906002)(2616005)(107886003)(6512007)(26005)(6506007)(186003)(1076003)(6666004)(6486002)(54906003)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tTVMZho6x5hGjHl8PHCNuVR7HyJEw4ctGDbP7l/fcxJeqSs8xN9bfV2qP5Sg?=
 =?us-ascii?Q?+DcWqcj1cXmRRDDggRodd/P8ZOMtEjn0EcOc3ZaYsICkPZO4okg1/kksUZ6f?=
 =?us-ascii?Q?eFJpFY+13frSOgRdHh/JsQzWnX+wHA4AU9YYg4bHENwpNEUsBXRqAZiTBZ/d?=
 =?us-ascii?Q?3ljD+gCoUQVXa88TVPVKNpmtj0Xcg39y0f91NoPC217mMcR3D3HhoGADi/ir?=
 =?us-ascii?Q?0za2QH9F7rF30ZU4WTMYmqh0WVupOiZPEJgk91yzRfpVeN2Efmq/7EMOwlpJ?=
 =?us-ascii?Q?K1FOhmvmH7IWmGETvPT7BG1CPFLutT/D+ktipjzYoFfVg0QFhOTJYxhb5tmM?=
 =?us-ascii?Q?0lkdEWKmiAiUfUALAhpnl5u72d63OKADsNH5a2Q1mFBPm65i6Tw/yQdZEym9?=
 =?us-ascii?Q?reOGUTfhAUsLOLCjYV5LW9/LBWxcbV+wCrSLGnp/lJoxeywYeEvVK36FGpO9?=
 =?us-ascii?Q?LkTfiiW+bVK9nOGNeihW0oBGjfLRgdMTmIOi0+87HRwgO6qTegE2JnoF8Tek?=
 =?us-ascii?Q?Sq+GbUsmMZeszJoM5UJ5Zpcv+sSoI28n2fT/7euFIvNq5JbxsDnugCvTM6eV?=
 =?us-ascii?Q?aPxPAm3iNtShQMSL5Xx+x1hfdVbTXj6ronHcjuITs0cZzxnmPuSJVRQNPPMe?=
 =?us-ascii?Q?+77Wg+X0px5Gp4sFHGrltk1j1imlg2wN5wenAb19La38OJ1F/PNbs8HtTxrW?=
 =?us-ascii?Q?RtV6rnE77roVEhHUcCNKQdWRC63RToq9/TdKH+8UdzLc7ZoFmIWiF3wRLOaG?=
 =?us-ascii?Q?L0KisMkge2LGO0gkJfocmNJG2/weNK1cNCD0H9LuTR6rKCUWvPUMGur+xyw7?=
 =?us-ascii?Q?xiqYdcn4qn73vlWawdL9+4PBsp/Yvhm+wPi2X09cCEybm5q3FZJd1Z1C1pZI?=
 =?us-ascii?Q?iGrZts04JR7JdkBQdw6HD6QUxqc/cJa+DrbRTxRoKFeUxvXGmdiAsez98eSv?=
 =?us-ascii?Q?LVCTLYHogyvHTKEoBCDB/UEOn32ICIBmwYbWjlju+Nv13fg7loEn2kJnoTUc?=
 =?us-ascii?Q?0by2B0EaJFHlFAq1YFbeFwFwpOBiWcrOTTIW2aHeruUg9Mr8n/UKoGw3pU6v?=
 =?us-ascii?Q?FvEKqaoTsJk//JmKHlEWR9dnIhZrH74rAY+ZTA6zBfb+HezaYustLJUpZH4C?=
 =?us-ascii?Q?ciXcbRWymu+rjp9gmVb4dOG42FlK8bVwcSgqOwJmVZ3T7b/YiWTvGLKbHvYb?=
 =?us-ascii?Q?WCGTs3GmEcEfI4khIx0Ws6tgGRTHnuRcoHL5LEfrsba2Zp1H3XYqBrJHzZkC?=
 =?us-ascii?Q?2j7FjGloCEX52i1Au/iKjPDxU8RJbBHEm8hxUTLpkxuf8CtmFy4XLW4KAXXu?=
 =?us-ascii?Q?VwCoT1bejjBEOm6G5G9zEMTH88n9lVRPjOEcNUqlw/CSCHxSZ9bbusz76NQ7?=
 =?us-ascii?Q?TzQcuTOv9KSWbVQFNQvKaboWdo4bg2EIgEwwVrkmPIciBaxxbeNvo/MEi6yV?=
 =?us-ascii?Q?Rt9iXmSlFjPyu2c7f5KGCMeZllHAEaYkWQH1S67bkYZxoQNCpijMlepI7nh1?=
 =?us-ascii?Q?HSdB4LuZ4/WAGRYanG/SqUtXf3vYwZt/uoGZTDO19i2n4fsMmI0d8yBvU1zS?=
 =?us-ascii?Q?MkgXNl48ms+aNKI+zL8n+ru5s5AIQMSLdVORKvF+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JcKW/yNnYnZNu4TAjp1cGbl1OpYoiKr28Ljp4KSgRkH/QEkBrpuY2a8QHUPetvKbIqrr7OU5tx5Jf+rCwk5cQQ1OWwbLP7r4ezOh+rrVkUSKib8fEUfaw+i7lI52C6bigwqU/CHgBD0m9m+vja6u9TiaW6D+nBX0GsvqaE/KTe8LwWboqy6Vcc1WkbmpSZt4xjKCDkIZHLszJJiipQ+k4WD5LE6LDQHnXOr+LnOH1dJW7vy+sZtJrw1PF4fL+fooHNukfGu+CoPQqndAoR0tfqBqnYQDlsakGOvV0vfobe71U5ZnAlsUTqqcCVQNFabCSZnBCleW8yDbw4bZKCeAYBqCNyfkbOWPr1JqHKXMwOgs1lCAA9dK38C1IdGU0Wa3ZyujC8eCttQklFbZ8MwU9ntZz4f0kt2Ar1TfTiyM2hkGsYc2KLYdDc6csotC8EKtXXR6FoVXxlaYj6L93K9+Cw57SVnYIUSzg6unjbugFOqc1S71suzF77Oe8161rjCrrOUulaipxoqztackG2HuRMwUAU6gNVIBFdbP0KvlhC+iTeTYdxpcPi5iW/dJsfrhHT4d5cHcKGIb0AT+bJunLeQp+PYp0uTutAAcGVT1DDvyxkvyGF+nbL7IVutwrXvfAovy3yahAM8JVcgOi8TCmBoNinz8dyISPWHo2EytCO1xtxDKussLpgXCgwBVmadCv6133ASIbuIr419WviDvfahSK6OAxaI60x+XfxgcgVJDOUbdqvBX/Tmy1m7p9E16qYFeQsADa2dGmqKOCPWI4f5vwAUFcD0ZV4WeLVUDAK5nsIMvXFYMh7CJJsLpQltuGFk9r8ECVOfSoCZYpEuIV0o9w1TOLz37YrLDiFxUKfiAKSgK5UjJPU3w/YVl2J39
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866ae541-337a-4be6-b944-08db52408ed8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 16:55:43.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/V3k+gtnjqjP36jdoZiCrthY6LeIceED0Pzci9kottw5oFL84Bp0ZLZYEzxxJE81aV6IwGaUSzJ/5g35QSmAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=804 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110145
X-Proofpoint-ORIG-GUID: acmc4lioxqrfPwNd0lG1QU7VVx7FiO82
X-Proofpoint-GUID: acmc4lioxqrfPwNd0lG1QU7VVx7FiO82
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinned pages can not be migrated. Currently as
isolate_migratepages_block() scans pages for compaction, it skips
any pinned anonymous pages. All pinned pages should be skipped and
not just the anonymous pinned pages. This patch adds a check for
pinned page by comparing its refcount with mapcount and accounts for
possible extra refcounts. This was seen as a real issue on a
customer workload where a large number of pages were pinned by vfio
on the host and any attempts to allocate hugepages resulted in
significant amount of cpu time spent in either direct compaction or
in kcompatd scanning vfio pinned pages over and over again that can
not be migrated.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Suggested-by: Steve Sistare <steven.sistare@oracle.com>
---
 mm/compaction.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 5a9501e0ae01..d1371fd75391 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -764,6 +764,32 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	return too_many;
 }
 
+/*
+ * Check if this base page should be skipped from isolation because
+ * it is pinned. This function is called for regular pages only, and not
+ * for THP or hugetlbfs pages. This code is inspired by similar code
+ * in migrate_vma_check_page(), can_split_folio() and
+ * folio_migrate_mapping()
+ */
+static inline bool is_pinned_page(struct page *page)
+{
+	unsigned long extra_refs;
+
+	/* anonymous page can have extra ref from page cache */
+	if (page_mapping(page))
+		extra_refs = 1 + page_has_private(page);
+	else
+		extra_refs = PageSwapCache(page) ? 1 : 0;
+
+	/*
+	 * This is an admittedly racy check but good enough to determine
+	 * if a page should be isolated
+	 */
+	if ((page_count(page) - extra_refs) > page_mapcount(page))
+		return true;
+	return false;
+}
+
 /**
  * isolate_migratepages_block() - isolate all migrate-able pages within
  *				  a single pageblock
@@ -992,12 +1018,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			goto isolate_fail;
 
 		/*
-		 * Migration will fail if an anonymous page is pinned in memory,
-		 * so avoid taking lru_lock and isolating it unnecessarily in an
-		 * admittedly racy check.
+		 * Migration will fail if a page is pinned in memory,
+		 * so avoid taking lru_lock and isolating it unnecessarily
 		 */
 		mapping = page_mapping(page);
-		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
+		if (is_pinned_page(page))
 			goto isolate_fail_put;
 
 		/*
-- 
2.37.2

