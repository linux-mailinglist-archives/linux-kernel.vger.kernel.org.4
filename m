Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537C95B63E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiILXDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiILXC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:02:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82B712610
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 16:02:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CLENeu005813;
        Mon, 12 Sep 2022 23:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=WYqFMYYlJhweLmKg4V59kUceWtZTLW9rMVAWUVWBiCY=;
 b=DWLfyQ+D3rxRzZ17MebjZCKBVago4EFxCKhjYWIMvPbyl5+mr1TwLZLsOM7u1iY5/jSV
 gHJOVg0QflIfJKFtlr6yrFZqaydf0bGXQINKSYd/pAdN17ZkKNqgneZdkONhMYtCXfar
 RD/CVloks9abc6YvkHk8/EGWHWeuzh1pUyo49lqKB4LnNiGygdXi3S8HH4KeoSGqmRt4
 GKlD5UJ9ef05OpL5GwIRWJf0MGq2dfX9p3xh9xIDh5Bh5y9cHmP3dba13w/inj5uZoYG
 oMQ11GzucNPy0Y/4BBhUWpf5GLQ4TLb2MSF48jTfMG9q5pmoOzT5HIfISsYeRK3kPTHo CA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgj6smys7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 23:02:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28CN1Lti014617;
        Mon, 12 Sep 2022 23:02:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jgk8nsmvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 23:02:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJBGYm+7h+uvxN8HankO4WlwZ2kvKERmLyjltTOtPbZWYHcre+kCDsKAQGZJJdjhNMe4Kx07OCKfTGTDBQsewpo0VA4/btXxPBBUxnSYqy7/wKx3N8eeWMqE7Mle3jv5bp7m/NKuF589RgENq79GzmmwbUGKNkS315AeqYt3uU2d3QEEcGHM7Hp1xlBeqyCKEhrHYygD94/Gfvm55+Hfj6HG/r63yFoCbCN+FfWaDKHArSLee19OUNtG7i/PO0rgTjafAk0yb8CpHQXrH0L/7upNXlMIhTWULbFIts0g+5clM3wO3rNA3tPNGEMi7rAxIonLjFpf+hT9M9LZ8Ac6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYqFMYYlJhweLmKg4V59kUceWtZTLW9rMVAWUVWBiCY=;
 b=duZ9gX+zhtDYUqn2iDEPd9sOvVd1M8rfdz1SsuKhR5HeRc+lohqjPekFJkdoO7BhCguGLlriD6FL7IUmEEJHThZuhxCEbH9jgzhyuPj0eCX8hywiUxTkmeZkQWj8A0bwB3uPFNz5IdfPT+nxb5OVfeYxFWTlpmHuv3GpyD/TZDfMCp8bUn5xkwCbCIwuNjxiQoy1j/uo6yRzOzqbcsFE1zty1Wr9dh/DH1uRcJMUHCP/pQJzsHOzrcm2BDg04DrZ/iJfaQ6Rlc3ioqJQ0rtLrm+Cly90Qrx/VX8WhR9Mu533WLQDopBT3QSyVk2SBfoTE/sUmLGwOCdsDfHdIE7lFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYqFMYYlJhweLmKg4V59kUceWtZTLW9rMVAWUVWBiCY=;
 b=OZ6we5Hu+YD96jVOKH02tFtSmAwkPCRrr3Il6M1TaiLa607mEUbosxIG7dnLLeBsi6Kf/wD8ag5XjCtMVFwSNa7ywsqBl9Y5N3D4l0v3/6z2CQonD8ieWmSer9CzSyadhn0ZGHhl57OlGvxn1b/SrCG/5GHuHMZFt/txk1vM/M0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5045.namprd10.prod.outlook.com (2603:10b6:408:116::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Mon, 12 Sep
 2022 23:02:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 23:02:24 +0000
Date:   Mon, 12 Sep 2022 16:02:21 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] hugetlb: use new vma_lock for pmd sharing
 synchronization
Message-ID: <Yx+6fbHUcInz4R+j@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-9-mike.kravetz@oracle.com>
 <08edc08e-08ab-0706-3c8d-804080f37bd7@huawei.com>
 <YxKMy3sDsWPEOMMJ@monkey>
 <1baff74d-d38f-6139-2548-19c0c8f87649@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1baff74d-d38f-6139-2548-19c0c8f87649@huawei.com>
X-ClientProxiedBy: MW4PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:303:b5::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc2f691-2676-4d7c-905d-08da9512db18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gA6ss9Dy7TlVjQZWAZIpLWDa3o/DU9Thhwoxpolo+kozlqIYTKPPW/c5mf+Aam8R/aB0fIJUiJk62x30Z3P+LvH6BztCM/haZUKHpBhxBtIQ4gNe4vOikwcdpknnsF6Xh1Eipl7N/4msjYNkFEuGWQyItly+flIZww31FG2VzM341a+oQ8DU09QIC/kVC+pQM4oz1t0mqzonqrJcMqzEv3vUeGAP6IUOcQEmiyNwkHzR36Q4AMa6kbBtC0gK/B7HV/IX6wrNHrbqOvi/ARIN4rdU52e0w9fvA+1WzmifFdSCODxHXMHJp6QhXRj71kKqEqA7V8eU4XhQs0p0PQp2aywgxP7izEt83DCmg8WYjzlkfd7M7AE6sUozsR4f5q00uVpMQCu25DGI+YJeC+v2iE9dLIjDvBfmh64xm1cH1Q55uZEAP4LMteX4bYM453cWibsw+deDgRR8ht+gK3yv3mp/itSjxvfodNcIGat1NjkLSoA5lRCKhTBRRYIkBWn1X1jNUS0i3oMj/s4HffErlvXW1FnOo3mZ3ik7cSUM+7yzYYnkaON/AqUdK2WV35yCGV0FbcfQUxcZd8Hmw1d/RhAF/BspUah4fsM6zWOLtpjh14KA1HLpcsd7d3wB/BmhGP0T8iy7sTJlLC6Z672HIzNrO2citaAN1L6K4gr9rtvSV0nmnlnapB/FmoC5ZD+q+5Vw41cnB+XhMt3gVH0zkAxEeSiRGS9+rqbA1E/NgujPX/tY/+xE7akuODWh8gx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(8936002)(33716001)(6506007)(316002)(66946007)(8676002)(5660300002)(66556008)(86362001)(4326008)(9686003)(6666004)(6512007)(38100700002)(6486002)(41300700001)(7416002)(66476007)(54906003)(2906002)(6916009)(478600001)(44832011)(83380400001)(26005)(53546011)(186003)(134034003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9mQ9rafvVG6644hO5BUSr64Q0xJOvEFzULXkP2m9GNfd7zlI6EDZb9Gq50ZW?=
 =?us-ascii?Q?oqACq7Vry8oOffY6iFisEnLZgaL3CdgYFeR6RfXgYSfjaN/MprZ8dPi1UNuO?=
 =?us-ascii?Q?vEPvbML7nBdrHTaVZ59bIrt3yzIskUoOLrjr3J4bhFpNLEQzT0lzHoDzOGLp?=
 =?us-ascii?Q?zlYcNYmFT0qBojcHgBmVQ1zN3JaPFM15ohNxMjLj91U5YubbsUZ9PRSwId3N?=
 =?us-ascii?Q?j2Pv/uiPpbRl6k/xvrc64oHe1LUTUPTBgAlH9smANpM3cQyi6oeRUGrThF5P?=
 =?us-ascii?Q?scXSBmfIARDiphqjXBgn8DBi6CZtrIDCyNQ2Qe9wOVpiEhZxRo6V+/xW3VM3?=
 =?us-ascii?Q?mIXvRl280gAzyez3xFY1vBEusAGjsyD8M7DgpGpDAxTzhuj3AKr7KT5pzDyo?=
 =?us-ascii?Q?zydTJdFX0ytUbynrH//D1hLdx7PsP+Cm7R4Qu+RsE6IQS9L58b+Rc9XJrYDO?=
 =?us-ascii?Q?R98smN4ZUVAeDwwZYAVzJaqDkpkjz3pxi+tPAN1dt/384IrUKE84JR5mWdgZ?=
 =?us-ascii?Q?nfupG8BGJdz2Wv9RTrmTUp4NLYDSAqArVlsfyCAeSEuwcfICVW91vRCTDBsJ?=
 =?us-ascii?Q?ks+DDw8YWJrmw+t8cu/xmuV1Hzr+ePdi4E3ADxoXouaxwVjCwhveS5tGNDP1?=
 =?us-ascii?Q?MaZL0Mvm98kcmZEOkSNkgcGptSehEiBjByVBdWPhGouoDRLUEdNgnigYGn+r?=
 =?us-ascii?Q?WjcazduGgT3+pDHQEdKYILlatqBljz7RErIfNMr7n+zulTWzgqwThSvOgSBU?=
 =?us-ascii?Q?9oB8qE8QX/LZHypW708G0rhlQyiw7YkSQm4ZgtnWIulWqL2GR2hsdtLRfuOu?=
 =?us-ascii?Q?MN0GYfJiWrbc/eso2n5KY30ZE//SpR/yDisV3Dz/M/nQ8IWzgoz5q3PO/ZAH?=
 =?us-ascii?Q?rXPhhg8p8HPa1AjfEyoYKmnPL+6aAo/7cxFbiSzo08Qmh5i/51ZOX7vPUkdr?=
 =?us-ascii?Q?KoHNX1a8WaCFJLJ5sE7EfQiD5Xv22DnzpaLgF7NaM/vlTd31nS/15kUhRijx?=
 =?us-ascii?Q?1Pr5lOM2gfv9LPSAGk2PhZZmRTAeanFb5D03dlXCtkm8I0imH8S28e9Q+c7S?=
 =?us-ascii?Q?z+pXtsdbmnQxKZeUeoOnq//OdVNZxjXDeCjeYXe38MimQ/7UYG5QHZhugMjD?=
 =?us-ascii?Q?Fdk6GZWu7RHpF5yfD24COZVCajVPTADuP6YzuLyFvgt+9jvv1mjDMs684kqb?=
 =?us-ascii?Q?QW7PHXB2XRQGeMOF6oMOPWYSPv+NHIRGiZLYe/uvc+Wx+V4AwqbVqYir7Iy/?=
 =?us-ascii?Q?/3LZUu6TE1IkUqx+2EeJ76tNzTjW7Ee0FAxT970GLhnG8Bq2K7J+93oJJRvW?=
 =?us-ascii?Q?eBpm+6geFs2z3WNn+xsfROD6lAarChUQElkW34A+8/9N8GQgtMop3cZd7tWB?=
 =?us-ascii?Q?02/EgbWR059BDO4OlxVa1J3Rq/YS+p7STdKvDOYkQpJfUuv8RDQQHKsoLX1N?=
 =?us-ascii?Q?Y3z/wbnQlpmn5BXMjI4sx9OThnasjnr+fBKE4iZobYmfnMcTz2AawCXI2RhI?=
 =?us-ascii?Q?OpBsAfsbU5naqYITKbK2ME7kKrOJzoKM1dwCU7K81i32I9seKs6Oh6RQuN+D?=
 =?us-ascii?Q?FKpDbu4ng/3cVesVfzDrf7/2TBaCvSlaB+kX1KB0SxDKleNqJcXOLOiEH90n?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc2f691-2676-4d7c-905d-08da9512db18
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 23:02:24.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaUGEugmuCBB3A872CdphM4TWNjUGBQxp/UjvUXqnrXShEaL/AUmWqmSyBkH0CczX1yzKfyIgsd7nkHeNzBtWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_14,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209120080
X-Proofpoint-GUID: thzELrucuFKel7NBVeMAN9n7KY_bTRmW
X-Proofpoint-ORIG-GUID: thzELrucuFKel7NBVeMAN9n7KY_bTRmW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/22 11:08, Miaohe Lin wrote:
> On 2022/9/3 7:07, Mike Kravetz wrote:
> > On 08/30/22 10:02, Miaohe Lin wrote:
> >> On 2022/8/25 1:57, Mike Kravetz wrote:
> >>> The new hugetlb vma lock (rw semaphore) is used to address this race:
> >>>
> >>> Faulting thread                                 Unsharing thread
> >>> ...                                                  ...
> >>> ptep = huge_pte_offset()
> >>>       or
> >>> ptep = huge_pte_alloc()
> >>> ...
> >>>                                                 i_mmap_lock_write
> >>>                                                 lock page table
> >>> ptep invalid   <------------------------        huge_pmd_unshare()
> >>> Could be in a previously                        unlock_page_table
> >>> sharing process or worse                        i_mmap_unlock_write
> >>> ...
> >>>
> >>> The vma_lock is used as follows:
> >>> - During fault processing. the lock is acquired in read mode before
> >>>   doing a page table lock and allocation (huge_pte_alloc).  The lock is
> >>>   held until code is finished with the page table entry (ptep).
> >>> - The lock must be held in write mode whenever huge_pmd_unshare is
> >>>   called.
> >>>
> >>> Lock ordering issues come into play when unmapping a page from all
> >>> vmas mapping the page.  The i_mmap_rwsem must be held to search for the
> >>> vmas, and the vma lock must be held before calling unmap which will
> >>> call huge_pmd_unshare.  This is done today in:
> >>> - try_to_migrate_one and try_to_unmap_ for page migration and memory
> >>>   error handling.  In these routines we 'try' to obtain the vma lock and
> >>>   fail to unmap if unsuccessful.  Calling routines already deal with the
> >>>   failure of unmapping.
> >>> - hugetlb_vmdelete_list for truncation and hole punch.  This routine
> >>>   also tries to acquire the vma lock.  If it fails, it skips the
> >>>   unmapping.  However, we can not have file truncation or hole punch
> >>>   fail because of contention.  After hugetlb_vmdelete_list, truncation
> >>>   and hole punch call remove_inode_hugepages.  remove_inode_hugepages
> >>>   check for mapped pages and call hugetlb_unmap_file_page to unmap them.
> >>>   hugetlb_unmap_file_page is designed to drop locks and reacquire in the
> >>>   correct order to guarantee unmap success.
> >>>
> >>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>> ---
> >>>  fs/hugetlbfs/inode.c |  46 +++++++++++++++++++
> >>>  mm/hugetlb.c         | 102 +++++++++++++++++++++++++++++++++++++++----
> >>>  mm/memory.c          |   2 +
> >>>  mm/rmap.c            | 100 +++++++++++++++++++++++++++---------------
> >>>  mm/userfaultfd.c     |   9 +++-
> >>>  5 files changed, 214 insertions(+), 45 deletions(-)
> >>>
> >>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> >>> index b93d131b0cb5..52d9b390389b 100644
> >>> --- a/fs/hugetlbfs/inode.c
> >>> +++ b/fs/hugetlbfs/inode.c
> >>> @@ -434,6 +434,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >>>  					struct folio *folio, pgoff_t index)
> >>>  {
> >>>  	struct rb_root_cached *root = &mapping->i_mmap;
> >>> +	unsigned long skipped_vm_start;
> >>> +	struct mm_struct *skipped_mm;
> >>>  	struct page *page = &folio->page;
> >>>  	struct vm_area_struct *vma;
> >>>  	unsigned long v_start;
> >>> @@ -444,6 +446,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >>>  	end = ((index + 1) * pages_per_huge_page(h));
> >>>  
> >>>  	i_mmap_lock_write(mapping);
> >>> +retry:
> >>> +	skipped_mm = NULL;
> >>>  
> >>>  	vma_interval_tree_foreach(vma, root, start, end - 1) {
> >>>  		v_start = vma_offset_start(vma, start);
> >>> @@ -452,11 +456,49 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >>>  		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> >>>  			continue;
> >>>  
> >>> +		if (!hugetlb_vma_trylock_write(vma)) {
> >>> +			/*
> >>> +			 * If we can not get vma lock, we need to drop
> >>> +			 * immap_sema and take locks in order.
> >>> +			 */
> >>> +			skipped_vm_start = vma->vm_start;
> >>> +			skipped_mm = vma->vm_mm;
> >>> +			/* grab mm-struct as we will be dropping i_mmap_sema */
> >>> +			mmgrab(skipped_mm);
> >>> +			break;
> >>> +		}
> >>> +
> >>>  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> >>>  				NULL, ZAP_FLAG_DROP_MARKER);
> >>> +		hugetlb_vma_unlock_write(vma);
> >>>  	}
> >>>  
> >>>  	i_mmap_unlock_write(mapping);
> >>> +
> >>> +	if (skipped_mm) {
> >>> +		mmap_read_lock(skipped_mm);
> >>> +		vma = find_vma(skipped_mm, skipped_vm_start);
> >>> +		if (!vma || !is_vm_hugetlb_page(vma) ||
> >>> +					vma->vm_file->f_mapping != mapping ||
> >>> +					vma->vm_start != skipped_vm_start) {
> >>
> >> i_mmap_lock_write(mapping) is missing here? Retry logic will do i_mmap_unlock_write(mapping) anyway.
> >>
> > 
> > Yes, that is missing.  I will add here.
> > 
> >>> +			mmap_read_unlock(skipped_mm);
> >>> +			mmdrop(skipped_mm);
> >>> +			goto retry;
> >>> +		}
> >>> +
> >>
> >> IMHO, above check is not enough. Think about the below scene:
> >>
> >> CPU 1					CPU 2
> >> hugetlb_unmap_file_folio		exit_mmap
> >>   mmap_read_lock(skipped_mm);		  mmap_read_lock(mm);
> >>   check vma is wanted.
> >>   					  unmap_vmas
> >>   mmap_read_unlock(skipped_mm);		  mmap_read_unlock
> >>   					  mmap_write_lock(mm);
> >>   					  free_pgtables
> >>   					  remove_vma
> >> 					    hugetlb_vma_lock_free
> >>   vma, hugetlb_vma_lock is still *used after free*
> >>   					  mmap_write_unlock(mm);
> >> So we should check mm->mm_users == 0 to fix the above issue. Or am I miss something?
> > 
> > In the retry case, we are OK because go back and look up the vma again.  Right?
> > 
> > After taking mmap_read_lock, vma can not go away until we mmap_read_unlock.
> > Before that, we do the following:
> > 
> >>> +		hugetlb_vma_lock_write(vma);
> >>> +		i_mmap_lock_write(mapping);
> > 
> > IIUC, vma can not go away while we hold i_mmap_lock_write.  So, after this we
> 
> I think you're right. free_pgtables() can't complete its work as unlink_file_vma() will be
> blocked on i_mmap_rwsem of mapping. Sorry for reporting such nonexistent race.
> 
> > can.
> > 
> >>> +		mmap_read_unlock(skipped_mm);
> >>> +		mmdrop(skipped_mm);
> > 
> > We continue to hold i_mmap_lock_write as we goto retry.
> > 
> > I could be missing something as well.  This was how I intended to keep
> > vma valid while dropping and acquiring locks.
> 
> Thanks for your clarifying.
> 

Well, that was all correct 'in theory' but not in practice.  I did not take
into account the inode lock that is taken at the beginning of truncate (or
hole punch).  In other code paths, we take inode lock after mmap_lock.  So,
taking mmap_lock here is not allowed.

I came up with another way to make this work.  As discussed above, we need to
drop the i_mmap lock before acquiring the vma_lock.  However, once we drop
i_mmap, the vma could go away.  My solution is to make the 'vma_lock' be a
ref counted structure that can live on after the vma is freed.  Therefore,
this code can take a reference while under i_mmap then drop i_mmap and wait
on the vma_lock.  Of course, once it acquires the vma_lock it needs to check
and make sure the vma still exists.  It may sound complicated, but I think
it is a bit simpler than the code here.  A new series will be out soon.
-- 
Mike Kravetz
