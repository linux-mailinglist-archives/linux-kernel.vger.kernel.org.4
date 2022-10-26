Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA3A60DA33
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiJZEPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiJZEPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:15:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA9205F7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:15:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q1nOcw024159;
        Wed, 26 Oct 2022 04:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=zc8mzcOzKYpscc3KXI4XlMqDxMCchmSJP4ytR0YQmQs=;
 b=Fw493+PpOsiZAsM0hCmnZLqByACGHom0iWRqNh53FQuhtQ/OQZqeS5aBZGL7tewry/94
 mdLheCygah08rNhtfJpcR2ZEBoYdTBqeJ8B9mS2bowrMHyU9Vn56/V3siujVmThHNbUQ
 AlUpacIDPSWRP3TuxgMNouL3F4+po4xNtQhpn/5R47g5oDuPhFaL045ryiXqxHRCsThl
 kKcGH8ozxRmTuKzSg9+DA6SGXDFQfezY3HK+XZUzRIiWEVGj5+rv2/CN7p/Eb1xtjdig
 s6SZwC7EXQ6WDJMIdR4NWhK2kobSs3Qtxl40UHPXyKCahgxn39m1kkGWrDXZhpmxVlyC DQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a35fdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 04:13:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q3A8Xb031874;
        Wed, 26 Oct 2022 04:13:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6ybb3c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 04:13:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVw0CyTWAHLyKTxFnPYaoFfg93G/QH2ciHmvzYvISAiFUhF8TvKLOtuWCq7Vbyxirq7cYlJ3i3eHxsP6S2Ct+eRrYIVIh4Gpv9UN17zfMtR/h+z1aFm7AXA2Z/41n15qSnfUwWU8QM7ZBHJ91XaiEaXu1sKICpvejRAvNj/i3Ui0bH9g10kt7oUttlSrKhCV6aw/1UhXpmDkReR6MjEyEvHQmH2NHOXQik/lLYEzX/0BBc+unzwL68UjRX+DFeEnjYc7VYvWsvlx6KWmfxhPJPgGP38TN4+1pyIT/9EDrMKfK2eDPdeNtFjdcOotiOjVGmxrX6gIbfloNH196qx4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc8mzcOzKYpscc3KXI4XlMqDxMCchmSJP4ytR0YQmQs=;
 b=G8NCmi2KANFBqml3arAn3w9h5L2UGt2wSGlKNI7ugvnXbTLaWBNYNZsPue25koRkNE6iQRicSNGiJ9PLYvZs1T0vAlvQoTiArXRMB6fVssJ/HtRCUvpjjF+b+fbgUfLltiZtkPHgqSuW8CoKTT9T02aqZSFYRuRfjaBLuhXWhqPdosVyPIF6dZQCkPSgZAmvWTv7AaPRlixWELwyVFFigzgeTblSz0KjwVBhJnBhFApZoAqr+BSl80w28Ezx5LM+MPy2cTlX45n78/YVKG18AH+YW1IxV5cBVr/yemyIdLWXyexMDvrL59VGNt5DzDmFQdGNPlpS7dqGJI/5EBO2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc8mzcOzKYpscc3KXI4XlMqDxMCchmSJP4ytR0YQmQs=;
 b=C/1ZMQ4JZRPNVVRRkSY+XbYP/o1f0uNXgsdm/k3iBtXXalHTaRfMSnnK2gaW0CjSPrUgsJv1zd1Dp32CQWI0ns/+08Wzz1983cwiDrdd1DRulQ9BKzS9dBTRB71tccsTk8SRi53cGTxRGCHX/aotDTNURqPfNNB1nQGpNrTNrXg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN4PR10MB5544.namprd10.prod.outlook.com (2603:10b6:806:1eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Wed, 26 Oct
 2022 04:13:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 04:13:18 +0000
Date:   Tue, 25 Oct 2022 21:13:13 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Chris Mason <clm@meta.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG] hugetlbfs_no_page vs MADV_DONTNEED race leading to SIGBUS
Message-ID: <Y1iz2dgCEvbpSPR1@monkey>
References: <215d225585ff3c5ea90c64e6c9bdff04ab548156.camel@surriel.com>
 <Y1ikfoLS0SdA6dna@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ikfoLS0SdA6dna@monkey>
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN4PR10MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: e057c9a3-9bda-4a43-cc93-08dab708690f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PJ+fWyEt5Q2PV9uLO+MS5QnqDaVPkTfCo/1EwUaaQBmwbeFWMx96iJm3mVspnxffGivu69tz8o+OQn/M1f3ixz1rWh4+D5iiaQxA4py/Vum0ZatPcV7DHCPg1BV9VdHMptVqkwxp9tjxVH+NQx7R0DkwQbFi91nSaUdl0Jhwy1jdlduaLvSYdxRA71vJ0jNJSSHpXqdvPSlPX0YmeqDm9717t4cwvQyA/nRrAfNMNBl3FfgWF8td/xG7fQymHi7bJmG5o+ZU0cRN2vrB4br57x8ZFqGWCB6ll2IoJRgam/oFKlOu2znuapKuieLYNKeTqqB/X+lkOUpAOCoa4rfertT7eWaDMB3ff4erMDXrSGgSif/Qwy2HF2OryAVfaPqyRuOn/Fc+IZFrwg4yTBQe1XqJeyV+GWf/xEaqbIZ1chcya/ZwJXA41TDO2rXVCse48S8sBpeGGghUv2d+ZYxtx7SLS0WCZuDiKc9aZR62TmAmqkgqrvKn/v5gtjKOMFhbmOheSb1VdAu8TE+GqZ/Y5Nq5nxU2bal28cXEt1BpSgpgB5DHbwo5LKWkOugRXpoFuIZP0NpW4tXxBPf+ggosgMhcq8RJJLyfP2h3J/L8NQ6Csetr0Otq1rEz30urRVtHpnR9i28Ora/Q0DIiA30gvrRlCWWK4O8PTtpWCi2pDv/fpib7M5m2Y+uIBChoYLAq2pw0PtWG97TP0SvbSCTsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(53546011)(6512007)(86362001)(33716001)(26005)(2906002)(186003)(83380400001)(38100700002)(44832011)(9686003)(8936002)(4326008)(41300700001)(66946007)(6486002)(478600001)(6506007)(316002)(6666004)(66556008)(8676002)(6916009)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H+E3Ihpk6T1Y4X0w1T7fVXCvImGBQlviUKSGNrmPyO9tJAn8uF6Vs4BDvK7j?=
 =?us-ascii?Q?0QiX0KjmtlFy/jGIh5OhaLOYIgTHDyPr/36lBjDT2rZ4ZWswZ9gUJEWV8pNc?=
 =?us-ascii?Q?B+tdkPd2O2/F4JspJG8KfGW8QRqt26j9ykq7Nr3TSq4zjzK41uk+VHBOYO5s?=
 =?us-ascii?Q?nbjnrInFoPBjZbdWdd5CnPcqvx1FDTosXqd2FGPP/5XduGXM4Lmv0PB+nmoW?=
 =?us-ascii?Q?Y5N06IgIHyXa+66B+d8nzUnqG7MPnYR458NKmhZV8ytS2aQSy5i9b1U6ABQi?=
 =?us-ascii?Q?QmR/5nJHqjhKAfNblykOfdlz85LBWQv2cdUCReHwNA3wZWAW+pkIoP1jvfPk?=
 =?us-ascii?Q?8H1LOE2DqA6WhdZC+WqPoXEdaBfuDu443E4cqnjNxFor4gVxElEyx9IbKmSP?=
 =?us-ascii?Q?9GCJWqTPe5sSrraZo9h3CAsdXyWza/kpuSbtydj5XdeuJ78hWYe8aeI5yLbm?=
 =?us-ascii?Q?YFN+MGhwcEOovq8G+Jj+QkNGEs7LOnhbCxp4LADhBdt0aE04nwTOCdEAS/ow?=
 =?us-ascii?Q?k2UELTuXcZtUo9nTPS0LltMhFi7JFrjyZ2yAuGTG2ejuiatMevSvTwWDG5UQ?=
 =?us-ascii?Q?FOb//gClkwu3g5WIAxj+RvT9ExZWDLeAmCS/OXtNCapAjSl8BJ1rwm31GDh7?=
 =?us-ascii?Q?Mw6lPpX8OOp9NFXipKx/xhnuPeNo/VisAEtJ6z7xkmoVsAU39fFSQ3Q4imcM?=
 =?us-ascii?Q?gmB2afs8q5FYz2MKkSC8k7sTKBt9PnNe2g0kaC0PdxhMwZlxMyWszel54tlN?=
 =?us-ascii?Q?W+SuYwXvBwUOUsc2Sv3x1x6u8uoecWXmDX2KAouDzK2VEwhDV+bBoU21AP9y?=
 =?us-ascii?Q?oFSibuwM9Td3i5Vbo5AFwIMW3fOrsCaXPwAklmW0RzHaI1HqJK6bXkoPebN4?=
 =?us-ascii?Q?nDYFfOVXyil1XwHENg6XHog3uDgd/ABJTN6nlpG3zuy6RUA+qGuOv69TRUSh?=
 =?us-ascii?Q?q0XIFP8R+SC8zeAICi7cLUh23sgCoKyEGDOzxw1G9CWcdTJvN4L/JHs9wftX?=
 =?us-ascii?Q?F43mHnarHqo2En9E/ydMEVJ7sdM7TElv/ZiTQxgIOAyPldi4gV9ae/tmqPJ5?=
 =?us-ascii?Q?8xYpjW8//7lCrScSmQo0m/LYWd1MXfiZmqD1IUt//F+s3mivdNRXTv3rqH3f?=
 =?us-ascii?Q?Z6XVfAPkeI5TNmRZucjfPPc7S8SqGDsj7gZakSafyprxYB6jz7e4LT2erpn6?=
 =?us-ascii?Q?p/3FNWkN2erd+yC/RX+oyZqyiyF9IS+tF0OF9wgSeo03GJ7ZvtA1No26h5Ee?=
 =?us-ascii?Q?9ByAyVYz4UcvpGmXTUaALk2CgluOwy/znpyTr6UQti0z2J7y5PqayylnBI2J?=
 =?us-ascii?Q?AxklCrWzfufIpxkXCXesGnxN6AZKO1RCSdmIDwjL1R2UKUP0vaZiAGj4ylZ3?=
 =?us-ascii?Q?a9oDWuZIw0ikS2aX/2uOq1a3nCcF2soIicFlBKFKARwIlqoA8SqMBJeYnLxL?=
 =?us-ascii?Q?yQwW1rBtFXTbqsgmhF/W4RaFxAUqNaKgUdCXd636esEkaP8VUoK621yG486O?=
 =?us-ascii?Q?7IAiudhIEibKnvry01Mq/AYHixHxa6lNjlJ8I7ZtUZW5mZtdYD3X1o4jH7qM?=
 =?us-ascii?Q?Mhu8Jv/0zn94AR3gn1h5NoB4jf+6zt2wywYSFnW00lotlOXBk1GdAq50F9g/?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e057c9a3-9bda-4a43-cc93-08dab708690f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 04:13:18.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9NvTFhwH1Gm7vIrer6cmAuHkXUcimZxKUFUt6hxeP8REZ5MELE3Y1agULc54VznCGxUXhk0gL4973f6u+8s/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_01,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260022
X-Proofpoint-GUID: MtcwtReZ64DBs8Cevs9LgRfAK0_3oLC2
X-Proofpoint-ORIG-GUID: MtcwtReZ64DBs8Cevs9LgRfAK0_3oLC2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 20:07, Mike Kravetz wrote:
> On 10/25/22 16:37, Rik van Riel wrote:
> > Hi Mike,
> > 
> > After getting promising results initially, we discovered there
> > is yet another bug left with hugetlbfs MADV_DONTNEED.
> > 
> > This one involves a page fault on a hugetlbfs address, while
> > another thread in the same process is in the middle of MADV_DONTNEED
> > on that same memory address.
> > 
> > The code in __unmap_hugepage_range() will clear the page table
> > entry, and then at some point later the lazy TLB code will 
> > actually free the huge page back into the hugetlbfs free page
> > pool.
> > 
> > Meanwhile, hugetlb_no_page will call alloc_huge_page, and that
> > will fail because the code calling __unmap_hugepage_range() has
> > not actually returned the page to the free list yet.
> > 
> > The result is that the process gets killed with SIGBUS.
> 
> Thanks for the details Rik.  That makes perfect sense.
> 
> > I have thought of a few different solutions to this problem, but
> > none of them look good:
> > - Make MADV_DONTNEED take a write lock on mmap_sem, to exclude
> >   page faults. This could make MADV_DONTNEED on VMAs with 4kB
> >   pages unacceptably slow.
> > - Some sort of atomic counter kept by __unmap_hugepage_range()
> >   that huge pages may be getting placed in the tlb gather, and
> >   freed later by tlb_finish_mmu().  This would involve changes
> >   to the MMU gather code, outside of hugetlbfs.
> > - Some sort of generation counter that tracks tlb_gather_mmu
> >   cycles in progress, with the alloc_huge_page failure path
> >   waiting until all mmu gather operations that started before
> >   it to finish, before retrying the allocation. This requires
> >   changes to the generic code, outside of hugetlbfs.
> > 
> > What are the reasonable alternatives here?
> > 
> > Should we see if anybody can come up with a simple solution
> > to the problem, or would it be better to just disable
> > MADV_DONTNEED on hugetlbfs for now?
> 
> I am thinking that we could use the vma_lock to prevent faults on the
> vma until the MADV_DONTNEED processing is totally complete.  IIUC, it is
> the tlb_finish_mmu call that actually drops the ref count on the pages
> and returns them to the free list.  Currently, we hold the vma_lock in
> write mode during unmap, and acquire it in read mode during faults.
> However, we drop it in the MADV_DONTNEED path (just a bit) before calling
> tlb_finish_mmu.  So, holding a bit longer may address this issue rather
> simply.

Sorry, that is wrong!  The vma_lock only applies to sharable mappings
and this is certainly about non-sharable mappings.  Please disregard.

I will continue to think about this and try to come up with a solution.
If not, we may need to disable hugetlb MADV_DONTNEED.

I really don't want to modify too much (if any) non-hugtlb code to
accommodate this.
-- 
Mike Kravetz
