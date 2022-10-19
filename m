Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1092D605131
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiJSUUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiJSUUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:20:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234ACFAE43
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:20:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JKH9mm003404;
        Wed, 19 Oct 2022 20:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=wVm7n855KMbquQQAtbBN8SVwpC02t3HqFP6FaB7NTlk=;
 b=ap4JzJIk1AWDm6sFncEhw77/RdEx//GsIfxwsrcbu9Q/9cNu2bTDfZK6uJuPONSrGpN0
 xDnWc0hzbZRILjorEaT6AXntL7Ms+kDm3fgTu4lxgSmWdGhNSPDIIxkzP5I+RGGCmNkb
 AavguFgSXxhtQxAOU2H9VVEXuEThhp6kH2PGD6LM3DBmZ+Drjow+1bund37Qnz+i+R5y
 kvuSR7odMIcGkurnAk3XtIVa8UM/zwuvl20ot0yrAx8qVYxn1EPHZZ/wRRkDDj2ABomx
 inSjLAGWC8F8vVxe4zrWyqSM12bLkLRmwNljYwQpSbWYeL4ayzgZYH9c67/Cp5IHLN6w +g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtksdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 20:20:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JHo6iW002733;
        Wed, 19 Oct 2022 20:20:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hthwjxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 20:20:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu42HB4/+ZxkArAYKxW0CISWd88emrp/3pQ3MURvwdB1mzVZIJYXuH+FHhU5eK11Lo0CBQ3LlBoQK/d5fV7tbByc6PcuXREaoA59V9/hdfzx7ZSYBz/OkmBcWs+6o9U5OVV/FmTpoUewF4/jOBjFLfyxRU5aDvyUAmlpSMs7JCY2ld1+qIuSvn9wsDmDPIjooJEOIbWBz0OKFCvVqKr7wr81Lq4qtJQZuTzay8fFMskv1XiCO47HvQQggRZ96/PVOo+EU29gZryZ1Sj3LXJ6pfzo0ckKcJCvNSiVLZMq/N51hmVFwWqsjpB+uPoPS/FyzI+dGY7WRyhWhU0lj8Dfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVm7n855KMbquQQAtbBN8SVwpC02t3HqFP6FaB7NTlk=;
 b=Gbh+z8uNY3AGE7IdhTUnbvTYEMNbiJmAdFad4YStNQD8CIf2neUdCqqYmw1DaN/5GH0ziruLpFSa59pd4+YC82KKyJbHWsdp6IzW8mtGarVpW30jyED/HiQSdwtlhyg8csLCmpsPkZHNJMvO7j59T5r39NvzIwDTp9140G3YaW8BguWL+529wgYXK0EFlPDVhlMHX1SwqqSMQZ/0pyzbDN6eTcfUtizO5XWroeaZ+W2sfCiaQ31FuzxbtUQ6GHGb9SgmUPs+o9DrSrFcvzQ0/S5PTTezaRSysPnsRo8glgkB6J8a+CsvgKgjxfjaa2yjlokO5BjnXw5loN8Og/Frdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVm7n855KMbquQQAtbBN8SVwpC02t3HqFP6FaB7NTlk=;
 b=csroasSkzCwCd34zUlD0c+kyc63m09gFVeBZnzIUFd9T6Bd9KKEdZFdjRS1ui5TKS6EHJEpHcXPa2odxsMs1L3Zjy8R6Nnm76jgh9TCnEukjl56dED/CIJoNbRxJ8ALVJPjOolb1vBpO+LareSFvsUZqYK/6UDR2k+ZsuLg5vKs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4641.namprd10.prod.outlook.com (2603:10b6:303:6d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 20:20:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 20:20:01 +0000
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
Subject: [PATCH v2] hugetlb: fix memory leak associated with vma_lock structure
Date:   Wed, 19 Oct 2022 13:19:57 -0700
Message-Id: <20221019201957.34607-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:303:83::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 5032a99c-a47b-4bce-f237-08dab20f4d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3Ph6mei/swEoKkmEYXsp1Ym0KoXgqawpRit6Ag0rs9dZsDJguBwTigORshCeyDQ7MJO7fnQNRYpjVMASAAif4qpSx1LoHEVJPalShTtGBKoNUEyFSCsh/aOScCefK61PbmXbfw/QviraPxRN8K4D5oL6/oI6X1jaQd7hIfCozxwSjQTVz6BXDQdZM1ZK51f1KVe/7o+VTFlvKMbkjPy+BYv8hBwI0DtMLf4Zf9fHVTSOOYScesHfairQdeugvfJO4Z/yZTi3GwPYtelvOVKE91mazdL35Zj9VGYtEgaCH6lnYjW4exRasFRYvoGJDC3zF2Cs53yzx+znvirrPWyawUM/WE2dwW2IdzNXpnUVnebPFppg6nzoEX43JKwWcaRdSl1GkZHJmIxWPu6qGamb0htrVsc2WZgsLoJxJJYEIs9bQgLpBgZoulutL0bq5hl51MRU7bb1OBgj0J+D+MUV2483h+eH2seEffiGoSF8ZV6PiZLEddNGpeDGqGNcsLCLg8yzyPPpTrgHT8qiTwVRqezKFbxvixjjxMJLObUHGtO7XFpPK0VJgO8jf7BbLgTj9BemNwQ2SkhG2C0ASO582gS6rL8DbiCUnCrXwjj4b/wDPF+pb4XyQMX8aTUMeSfDaNkCVBa0Tcpd5IdGlo6EuoyhtszD6kxSqdcrxRxIXBhT0/fgn/G+30O6uj9ZptjQXbPexiWzDeP2YsR5JQW+51vMxl3nKZQzaLlnb3zAXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(478600001)(66899015)(83380400001)(86362001)(6486002)(966005)(107886003)(36756003)(66476007)(66556008)(6506007)(6666004)(8676002)(4326008)(316002)(41300700001)(26005)(6512007)(8936002)(44832011)(7416002)(54906003)(5660300002)(2616005)(2906002)(66946007)(186003)(1076003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XdeJ/lJiCTSS0GTlCDVfY8na8QNs2SKxSONrorToCBLq4xhiX4u+GA6R5Fwq?=
 =?us-ascii?Q?mK+MPY1X5nMpWes4E8Fj35ENpccY3sEe3tjIC1TKPEtZ9lzOe0xQ4baHF4AW?=
 =?us-ascii?Q?S9feCs/DPnBTcVhNg4a6wyndDlQM4qK97I0erbTNybmI+IxxPsjbJbGcPVI9?=
 =?us-ascii?Q?D8AUjUCgUSDP47ua04822QZ4ZKyPaaRsfmiCkTUw2lcfvMB9lnpY8VboZAes?=
 =?us-ascii?Q?PmIwmpMKDP3M0ZZxOmvjx5k3VIa2sjjY3/2MztPHxEfsC7yMtPEpdAQp6yEX?=
 =?us-ascii?Q?/WZUjWXZuPwGIt5ijMZxg57u6oG6ByYw/MGAgx5bCHvGFPZvveXYU5KaIaif?=
 =?us-ascii?Q?uj5dPBQrTkpRtNxhpglbMTgYMaOuF6wBl7Ut6u9HGPxr0wA8ibpIGkGUlW2H?=
 =?us-ascii?Q?2yP4V2+De03P4IebiGoILHMmToscKm1lHL8N9LZab7RvELubcT6DymlBYtPy?=
 =?us-ascii?Q?SDTwcASh5yT1EwfxkBeuWE/6NUfpO8GYc9X0X+R0ApiiZTQoNedZkrtrjoEK?=
 =?us-ascii?Q?8HV0CDBB5EUkBs0IJyHdd4R+v7yGSTd9rCxigF33UfdDwLb2WgDFkl/n5vTn?=
 =?us-ascii?Q?02OipHVeabi4AqHkq+0qZLou3bH5V91jqCkiEX/ck1R5s0Lgs3azfOg5Dh/5?=
 =?us-ascii?Q?embx85RUKjWgIMGWry1WEcKhLZREbGjXzlaJD5gnvALxgM87GHVzxceByFJP?=
 =?us-ascii?Q?fHzVT6m/fhozfVwYHZl82p+Gnrptu51JYzsPesd+QdIopxdDKkWHVJFTy956?=
 =?us-ascii?Q?UVHrw1iHehf4PY9d/GcCRjUwkdmPjQoQfsUiu0H/bJ/7BouJhvt5wLlrmQgL?=
 =?us-ascii?Q?fsjTVVbAJKYUkIgBuqErlABQTHVJAiYc4YRozc+seW+3PysdouYW9Q5byz6S?=
 =?us-ascii?Q?eT/Z+LddiH7SsVXFa24qmgaPimtyvB+rEEEKosfIgvu73dvK6UIAVaPE3Ev4?=
 =?us-ascii?Q?lEL0vR6bQjahqLLEhHnWGY9iTP2q5ZXn0QRvzMNw9b3lidCXzrm+IhY2+uEl?=
 =?us-ascii?Q?rPaDrXgz62Boy1Qhp6ZW5hFJ7iHn8C3epvEd0+XmAuR1Z4PQrHw2QGSHRGz8?=
 =?us-ascii?Q?ygzxD5eZNxNV/Qxyh1THlRN4EWSAIfMmIalUjbind0MEP5an8GziXCv2KBJS?=
 =?us-ascii?Q?7MIbKkgUdaH+98mgaUXdvWIRn9AeGPE5zeXgpDmlRbw4T+Rs/Oez46U3tMau?=
 =?us-ascii?Q?ISUVtxlGtOqM28xgRTdYoAmBzKC7TgZZJLel5q3vNSbVk0lTEVpfw/eb9NqV?=
 =?us-ascii?Q?Hd0wxV/pOBI7+EeaCVUqgdV2wsmF8H3CGASABfQGqFIS6baB48dHwIoxKhB7?=
 =?us-ascii?Q?B/kkwdTP0IXv+lyyfyWJ4SZKrGi+t0Pih3GUfQ5rUnunVeydD9yl/OSngn0/?=
 =?us-ascii?Q?RwoI6t+9436CKPNjyW+GOXnHlqUOaTxiyk7bWVeR0MrTR5of+5FdrdpP4KDk?=
 =?us-ascii?Q?iQNKXjuPcD4RHYRS6eGf7nD4pxQCoMqPE8kzIcounZB/Cwu1TPAUa8ID7iOG?=
 =?us-ascii?Q?Aa4/0IWHbBQkIroArKT9M0Azwwb/Vk3jPbCEOxvpI2KRCWej0DMgqnt48srq?=
 =?us-ascii?Q?SC0d6FV0aWeq5zx7DlQ3wXPT0BrVhPKxmJapBnh6G/SIdtJCC6PcF/v9qgwC?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5032a99c-a47b-4bce-f237-08dab20f4d0f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 20:20:01.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9pl3iwNFUtC/mvFDvM8tLt4ym8SRVJJSW5gzRQjrCde7ey7XBszmKxVp4wSRrc/3MYswjBemb7CRVo6VWmqQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_12,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190114
X-Proofpoint-ORIG-GUID: BLWHmGiCbM1r1t0PjErejdQzqUPYt80w
X-Proofpoint-GUID: BLWHmGiCbM1r1t0PjErejdQzqUPYt80w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugetlb vma_lock structure hangs off the vm_private_data pointer
of sharable hugetlb vmas.  The structure is vma specific and can not
be shared between vmas.  At fork and various other times, vmas are
duplicated via vm_area_dup().  When this happens, the pointer in the
newly created vma must be cleared and the structure reallocated.  Two
hugetlb specific routines deal with this hugetlb_dup_vma_private and
hugetlb_vm_op_open.  Both routines are called for newly created vmas.
hugetlb_dup_vma_private would always clear the pointer and
hugetlb_vm_op_open would allocate the new vms_lock structure.  This did
not work in the case of this calling sequence pointed out in [1].
  move_vma
    copy_vma
      new_vma = vm_area_dup(vma);
      new_vma->vm_ops->open(new_vma); --> new_vma has its own vma lock.
    is_vm_hugetlb_page(vma)
      clear_vma_resv_huge_pages
        hugetlb_dup_vma_private --> vma->vm_private_data is set to NULL
When clearing hugetlb_dup_vma_private we actually leak the associated
vma_lock structure.

The vma_lock structure contains a pointer to the associated vma.  This
information can be used in hugetlb_dup_vma_private and hugetlb_vm_op_open
to ensure we only clear the vm_private_data of newly created (copied)
vmas.  In such cases, the vma->vma_lock->vma field will not point to the
vma.

Update hugetlb_dup_vma_private and hugetlb_vm_op_open to not clear
vm_private_data if vma->vma_lock->vma == vma.  Also, log a warning if
hugetlb_vm_op_open ever encounters the case where vma_lock has already
been correctly allocated for the vma.

[1] https://lore.kernel.org/linux-mm/5154292a-4c55-28cd-0935-82441e512fc3@huawei.com/

Fixes: 131a79b474e9 ("hugetlb: fix vma lock handling during split vma and range unmapping")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v2 - Allocate vma_lock in hugetlb_vm_op_open if !vma->vm_private_data
     on entry.  Thanks Miaohe Lin!

 mm/hugetlb.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 02f781624fce..ccdffc2fa1ca 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1014,15 +1014,23 @@ void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
 	/*
 	 * Clear vm_private_data
+	 * - For shared mappings this is a per-vma semaphore that may be
+	 *   allocated in a subsequent call to hugetlb_vm_op_open.
+	 *   Before clearing, make sure pointer is not associated with vma
+	 *   as this will leak the structure.  This is the case when called
+	 *   via clear_vma_resv_huge_pages() and hugetlb_vm_op_open has already
+	 *   been called to allocate a new structure.
 	 * - For MAP_PRIVATE mappings, this is the reserve map which does
 	 *   not apply to children.  Faults generated by the children are
 	 *   not guaranteed to succeed, even if read-only.
-	 * - For shared mappings this is a per-vma semaphore that may be
-	 *   allocated in a subsequent call to hugetlb_vm_op_open.
 	 */
-	vma->vm_private_data = (void *)0;
-	if (!(vma->vm_flags & VM_MAYSHARE))
-		return;
+	if (vma->vm_flags & VM_MAYSHARE) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		if (vma_lock && vma_lock->vma != vma)
+			vma->vm_private_data = NULL;
+	} else
+		vma->vm_private_data = NULL;
 }
 
 /*
@@ -4601,6 +4609,7 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 	struct resv_map *resv = vma_resv_map(vma);
 
 	/*
+	 * HPAGE_RESV_OWNER indicates a private mapping.
 	 * This new VMA should share its siblings reservation map if present.
 	 * The VMA will only ever have a valid reservation map pointer where
 	 * it is being copied for another still existing VMA.  As that VMA
@@ -4615,11 +4624,21 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 
 	/*
 	 * vma_lock structure for sharable mappings is vma specific.
-	 * Clear old pointer (if copied via vm_area_dup) and create new.
+	 * Clear old pointer (if copied via vm_area_dup) and allocate
+	 * new structure.  Before clearing, make sure vma_lock is not
+	 * for this vma.
 	 */
 	if (vma->vm_flags & VM_MAYSHARE) {
-		vma->vm_private_data = NULL;
-		hugetlb_vma_lock_alloc(vma);
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		if (vma_lock) {
+			if (vma_lock->vma != vma) {
+				vma->vm_private_data = NULL;
+				hugetlb_vma_lock_alloc(vma);
+			} else
+				pr_warn("HugeTLB: vma_lock already exists in %s.\n", __func__);
+		} else
+			hugetlb_vma_lock_alloc(vma);
 	}
 }
 
-- 
2.37.3

