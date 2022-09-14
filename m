Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609F65B9074
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiINWS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiINWSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:18:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B2179631
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:18:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EMA2PT000788;
        Wed, 14 Sep 2022 22:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=7F3l2C0PVCLecv/z0XTeoBzuIVVvO7/ET+JeU1QgSek=;
 b=y+It71gKspOSvlTRK96vJ+35bsJcBCmcfISZ7HPGxvzpzL9cy96G/CTRi6Jkc6mPHHfr
 cdPyQkhBQwJxH2xCc0l98fepD1r7ReJk0oMXf5cojnkyx53ikhE59eJ/c7oHL1SxlHid
 5QNpmWXJlGEHAb52s/F0fGqO8CJfEIzQ6KwmWGSNUa9/85hdomBg2bJsWLe3FycEBqui
 /rDOWcwqSH8AK8Nigd5RGS+rX0exvMNhnsXn5mQfD1qxKhzJmabY773YYq03BrMahMmh
 c0ehyC1DnYl9HTTwHL1ue6xNUFPtvlY27ryoB7+CgOcEFtYh1wL+rc26a/1DjEd5BSQ/ 6Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyf3jmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EIt5hT035398;
        Wed, 14 Sep 2022 22:18:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym095ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrJmt4KqIAGwiqrFYCXjTU/2KV+YeEg/ErjR2GfGOZ2bN8Ddp6jSq6xaZIN/yhzkFiM4j3qvfXB4FKtpt6a9wKFSiLE140eaD56WNXmHaYLcs1g1CeZB+fWdFB6DApuHSuKviYpoPuLRscTWdX7S+Pvcf/Cpg9ZUJRr4qGgZIu7SQzSptYOHaFjpsJilvMfRknTbPUQCgQ/PxjTvvfZJQCd3YCOfRnS6/lVXusFxjS9C5kQIZfIVyGx0xUwAShwBPwEvuSerYEfNzQ3d3+Hn3pXk+uUBYMkP6Im37qTTHLsVgik4xcme3bS6R6QztiWUlINTaZwLrgaRPKZ88BWLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7F3l2C0PVCLecv/z0XTeoBzuIVVvO7/ET+JeU1QgSek=;
 b=Q8Kc8EWA8TbsmZcRJ15wFlApRhYSdB+QJi1QxUA1UsRxqFT16OLFKw4w3UR/EZAo3gnoPdaHk1mrciixJ3f037TqaSNkPAwhGZ526Ob8QDKynJHCeiHgnQgqelf8t9t16Vc/1wDovdFQsJI3X2gozwgOr7G/BDVwiZS+5XYq0CFb43lpzlFCVXgZ+d6xCrg+Kvcs0p5sNuB+59vfTpVY8QjATkmSzMyIOXkoFL53QTZ7i6fAVdPO78sPO1N7NTwjbHwi2IuSYBNcowV3rJPL0DYx8HE4OwWzHZOUsHeuUmUCJrQKhr2o+TdGCc2+dH8YQjDF7SPUItCqPURvPsONrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F3l2C0PVCLecv/z0XTeoBzuIVVvO7/ET+JeU1QgSek=;
 b=PY5sYdDyIpJt8tVFrhqIhvKUwwYvUkEuZBpL77l+03pQDZjDCA57pqtsp/VB4I18QlC20IjLjYkhPRDAspLKMWip8TZhQxyttyP00R42m5i7kqf6ty0ANAjN9YXBpOvmPqVWKts/iV+sTJq6n0bq1qTskOGrxn1XNEqtG2W12xE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5126.namprd10.prod.outlook.com (2603:10b6:408:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 22:18:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 22:18:17 +0000
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
Subject: [PATCH v2 0/9] hugetlb: Use new vma lock for huge pmd sharing synchronization
Date:   Wed, 14 Sep 2022 15:18:01 -0700
Message-Id: <20220914221810.95771-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0011.namprd21.prod.outlook.com
 (2603:10b6:302:1::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c60257-b9ec-4f29-e034-08da969f05d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvAuPUGmCMfQBQ+D9ZBkVdhlX6P3OXZgUqG0B7ejS/buzgOB8nCLul5RptgjPUgGNl6pAZWsb8zp/Xd1qcedJK+0Be1yfmI/MOh3yJ8EIklB3qV1Nr3qJ6rmhbQBa4G7b0Fd5Wld4R4oooniuAvV+2Om8EqT6G1hjSUGeRTkxp8qQrzaoiMW4JziPEHbbyxsUlRVsTV5/FaYbk3CAbmoozAfXrqWO4qiF3k9ilNM8dOrMTYoZyzmD4ErFa0mZvHyLH/PQTO+qQ+H4b4mfPfHM1QW7pcVNER95eSl/pZeKSvQd2OzZ+Re9IGQuV/bCHbk50tZ5WZGywfSU1dfZhsM708+FtpIGsLdjDsh4wyC+1S03V7fzKJx5FAc8XzAv8Ctx8MCfIkiNErjIshF4gX43TPWTs852vUk3MDF2GSDtdj68BuKBlqVSlXNiEyMOqGqfVlcQFcapj0RbmBn1I2ytYIAGBwIY8bkyVAEt5q8Hm34hdhNYXqSdHSIqomUpZveNTqwA6ijNNK/2h/BO88x/bs0vQt2jjKLPg5uLfQBviSXT+B0gj+mpi5AN6qEOebRjwhmye3ubi/Rr+J6eXCKo3AconCPCV7GXGrZQZQ/Uo87uAh/EJ7HGtUKNu1VDJ4cjTKJk1KHOTl7q8w/F4q0QttndNCDqs2G0z8lIjy8Dcl+PkCMmw5TKl9Geo2zosVmP1LZOTzl7IDMTs3h/JF0dkd1oYDnBXXgTEJUecCNZosU4tQ++FOxDDC29UOWVZDZ159HFHYgTZS2ApgUsSg1xUjXjjWt/TCJoTprTLV+uYr8rCLVmmMz8FCQU1sn+X5gd0qXwx+pHXimezBNMHpdlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(66946007)(6506007)(107886003)(54906003)(66476007)(86362001)(4326008)(6666004)(44832011)(5660300002)(66556008)(966005)(41300700001)(2906002)(36756003)(26005)(6512007)(7416002)(38100700002)(478600001)(316002)(8936002)(83380400001)(6486002)(8676002)(2616005)(186003)(1076003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DJlDKyXw8l1k/S5hMV31ykh+YDc0xtiviCmLWU4kYtundaO4NHaPCksbW4nH?=
 =?us-ascii?Q?JzG7ICu+c8x1oGkoJj44BV77RTQbfDInd+ojdxT7xvxgPte5qIqQlhTHHdM0?=
 =?us-ascii?Q?YyQT/VOBth36GRHiX0h/8t4unpNC3dl2iy0o9jO/enyDcJggeJCoqFrg6qBN?=
 =?us-ascii?Q?lIsXEQf6A8wacYSdbCCKBALar6pF4/sWAhqJ2RLCiW4f89ZbOugRGmuWqHmM?=
 =?us-ascii?Q?HPeOee//E6k3lYdmR7K8I87S+4uR5quqJTkxRWfdUmWfY2P5PbbLUZFuJ/SV?=
 =?us-ascii?Q?zwYqyu1HKghs2haTy7sI10T5lh2BO5znccCmKbiiNfVd597lODgWN9cNPXA7?=
 =?us-ascii?Q?y6WYTyx8Nt805SedCKcTsRs4mJE085eMfvg4f9ntYRb6DtYal0K2nDc1py59?=
 =?us-ascii?Q?8+UGL2DOwUYrfu88maHhPzXV1tZ7SVQNbP/JMNQN2u0zEMHyq+hBhRikdn/T?=
 =?us-ascii?Q?2Okf+X9ab6R45Mvh50Ep46KSUr83lTBYWr91DfTX0S7I8lcwmJXcYj80ULtV?=
 =?us-ascii?Q?kUfEJAygZlajx9Qf5eB1gQfqrNpWKTv17A83vgPL5hVIooaU0uNFyykXU+sZ?=
 =?us-ascii?Q?aSdg3URaK0VoWr9Mto1JGOuYGu7ugpHjVzwMOia8bE+azqC9ePQw1gefPEie?=
 =?us-ascii?Q?CTLWLTy3xWtTv8wGcVTAItGIUTl9DU+O2zbIklsxyQ+CMmvmN9o9RyoesV9I?=
 =?us-ascii?Q?ulPV/sznz1NtIlLMfKHX+/Fwq+xc+j1D/ClwbCSxcowzL+zYeiIbuzRFJLiM?=
 =?us-ascii?Q?GfEkvRuaPYs1ExHhaOILA1aZlWfh+s4P4u6xWInjfGlFb60eJk4MVuRboNVv?=
 =?us-ascii?Q?f7S8uy/GUxAMTi/DuwWbv14ohBAJiDzwAz2J++NEhDUqPu/715g4uR6jaAek?=
 =?us-ascii?Q?I8jQ2v/t6NxsKxe7uQ3tHHUPeAAh8Op4vVsd8Nnkl6LdiegoqPd6dVvMGNb9?=
 =?us-ascii?Q?0g0KVSuiBT4+Iprlui98dfZRFdJYdcXdFbEed+BK7kTDO4pTnM8HnpmSQlX6?=
 =?us-ascii?Q?93P0JKHmq11ABLFAJSxaHbSm4XhgjEMV3hoMEpuRzfMtkxjBIuCGU8P4uT2a?=
 =?us-ascii?Q?VR1QnRQVTef1WAbp/aKWEI+ZHCRbkIFK9IjnzitTfR060UWVESviK8lIE4or?=
 =?us-ascii?Q?jLTD4t1HxgTfKdVkB9v8AagZhvTYlkZL821L7HWbK1AQoNPz8vA0hTMW0g3Y?=
 =?us-ascii?Q?ghcjB5aJ3Cqnv2cnthuGgRV0c9plsGZGO+2n2ayebM8TfppIwKPhuAW84QhW?=
 =?us-ascii?Q?Khs+l3nEEUb1ICJ6LQY+FFPBjcpZ1MTq7C2JqJEQNrOpXyN48rhHCe1gPwqW?=
 =?us-ascii?Q?O2X4Ffta8T++0CnFQWOrUO/ZGfso/EWgds3EdM1ObDXAu7meXz8qosulhaDH?=
 =?us-ascii?Q?JW/UlJs8ZV+IvZnZL4QExxPXIulNa8b2KMdSZdBBWdUXGMMdjxooorTrkKlx?=
 =?us-ascii?Q?jSo3fGSsvXQ1YTxlkrJH/pUsAQOzfwXK5ypgYbOTmOvL0+iudkaXoHjxe+L+?=
 =?us-ascii?Q?rIgBH5rmNjq0grF9dm505pQQeJecPvK/nogyrMeQoaiixiXR85Gxj8cODJq4?=
 =?us-ascii?Q?TAAi3q8Rz7bvy8BKXgcyhuHMfE+xdJf52A/uzWWC2JoYF/Cd2EpH7TLxaBog?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c60257-b9ec-4f29-e034-08da969f05d7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 22:18:16.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5LkVWkpV98Ton0QRKT7NcwzlRFgzirgb49Ijk+ESB6cbqunnQ9TphQeNEK9QttyUFlRPUe8tGwJE3gHycYTtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140108
X-Proofpoint-GUID: zNwsx4JPqJ5Hm2PcB1-K4zrUZUarUGxN
X-Proofpoint-ORIG-GUID: zNwsx4JPqJ5Hm2PcB1-K4zrUZUarUGxN
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb fault scalability regressions have recently been reported [1].
This is not the first such report, as regressions were also noted when
commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") was added [2] in v5.7.  At that time, a proposal to
address the regression was suggested [3] but went nowhere.

The regression and benefit of this patch series is not evident when
using the vm_scalability benchmark reported in [2] on a recent kernel.
Results from running,
"./usemem -n 48 --prealloc --prefault -O -U 3448054972"

			48 sample Avg
next-20220913		next-20220913			next-20220913
unmodified	revert i_mmap_sema locking	vma sema locking, this series
-----------------------------------------------------------------------------
498150 KB/s		501934 KB/s			504793 KB/s

The recent regression report [1] notes page fault and fork latency of
shared hugetlb mappings.  To measure this, I created two simple programs:
1) map a shared hugetlb area, write fault all pages, unmap area
   Do this in a continuous loop to measure faults per second
2) map a shared hugetlb area, write fault a few pages, fork and exit
   Do this in a continuous loop to measure forks per second
These programs were run on a 48 CPU VM with 320GB memory.  The shared
mapping size was 250GB.  For comparison, a single instance of the program
was run.  Then, multiple instances were run in parallel to introduce
lock contention.  Changing the locking scheme results in a significant
performance benefit.

test		instances	unmodified	revert		vma
--------------------------------------------------------------------------
faults per sec	1		393043		395680		389932
faults per sec  24		 71405		 81191		 79048
forks per sec   1		  2802		  2747		  2725
forks per sec   24		   439		   536		   500
Combined faults 24		  1621		 68070		 53662
Combined forks  24		   358		    67		   142

Combined test is when running both faulting program and forking program
simultaneously.

Patches 1 and 2 of this series revert c0d0381ade79 and 87bf91d39bb5 which
depends on c0d0381ade79.  Acquisition of i_mmap_rwsem is still required in
the fault path to establish pmd sharing, so this is moved back to
huge_pmd_share.  With c0d0381ade79 reverted, this race is exposed:

Faulting thread                                 Unsharing thread
...                                                  ...
ptep = huge_pte_offset()
      or
ptep = huge_pte_alloc()
...
                                                i_mmap_lock_write
                                                lock page table
ptep invalid   <------------------------        huge_pmd_unshare()
Could be in a previously                        unlock_page_table
sharing process or worse                        i_mmap_unlock_write
...
ptl = huge_pte_lock(ptep)
get/update pte
set_pte_at(pte, ptep)

Reverting 87bf91d39bb5 exposes races in page fault/file truncation.
When the new vma lock is put to use in patch 8, this will handle the
fault/file truncation races.  This is explained in patch 9 where code
associated with these races is cleaned up.

Patches 3 - 5 restructure existing code in preparation for using the
new vma lock (rw semaphore) for pmd sharing synchronization.  The idea
is that this semaphore will be held in read mode for the duration of
fault processing, and held in write mode for unmap operations which may
call huge_pmd_unshare.  Acquiring i_mmap_rwsem is also still required
to synchronize huge pmd sharing.  However it is only required in the
fault path when setting up sharing, and will be acquired in huge_pmd_share().

Patch 6 adds the new vma lock and all supporting routines, but does not
actually change code to use the new lock.

Patch 7 refactors code in preparation for using the new lock. And, patch
8 finally adds code to make use of this new vma lock.  Unfortunately, the
fault code and truncate/hole punch code would naturally take locks in the
opposite order which could lead to deadlock.  Since the performance of
page faults is more important, the truncation/hole punch code is modified
to back out and take locks in the correct order if necessary.

[1] https://lore.kernel.org/linux-mm/43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org/
[2] https://lore.kernel.org/lkml/20200622005551.GK5535@shao2-debian/
[3] https://lore.kernel.org/linux-mm/20200706202615.32111-1-mike.kravetz@oracle.com/

v1  -> v2
- Addressed more issues pointed out by Miaohe Lin.  Tahnks again!  And,
  added some Reviewed-by's.
- Addressed performance issue with files that have large holes as reported
  by Sven Schnelle.  Ultimately, removed code using fault mutex to address
  fault/truncation races as new vma lock is sufficient for this.
- Made vma lock be a ref counted structure so that it can exist separate
  from its associated vma.  This makes the unmap code that backs out and
  take locks in order cleaner and a little simpler.
- Rebased and retested on next-20220913

RFC -> v1
- Addressed many issues pointed out by Miaohe Lin.  Thank you!  Most
  significant was not attempting to backout pages in fault code due to
  races with truncation (patch 4).
- Rebased and retested on next-20220822

Mike Kravetz (9):
  hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
  hugetlbfs: revert use i_mmap_rwsem for more pmd sharing
    synchronization
  hugetlb: rename remove_huge_page to hugetlb_delete_from_page_cache
  hugetlb: create remove_inode_single_folio to remove single file folio
  hugetlb: rename vma_shareable() and refactor code
  hugetlb: add vma based lock for pmd sharing
  hugetlb: create hugetlb_unmap_file_folio to unmap single file folio
  hugetlb: use new vma_lock for pmd sharing synchronization
  hugetlb: clean up code checking for fault/truncation races

 fs/hugetlbfs/inode.c    | 300 +++++++++++++++++++++++---------
 include/linux/hugetlb.h |  45 ++++-
 kernel/fork.c           |   6 +-
 mm/hugetlb.c            | 373 ++++++++++++++++++++++++++++++----------
 mm/memory.c             |   2 +
 mm/rmap.c               | 114 +++++++-----
 mm/userfaultfd.c        |  14 +-
 7 files changed, 621 insertions(+), 233 deletions(-)

-- 
2.37.2

