Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA15F16E6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiJAABe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiJAABa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:01:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD731A1E8E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:01:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UM45gM032436;
        Sat, 1 Oct 2022 00:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=J5CUqOSI6NUKPsm2f7bdchBdp4+rmGoTyMMTnAKcmoQ=;
 b=UWDQA91sXOfX1bFmWoKKl/1lsMN/yNOK9ASg3UAS9e4vJJ8WUoezYETtig6WTTPR78XI
 l4KvG6v0VY8jjczIGrzPYhI+WEIC3RcjEK0cmsQEJoRaj8X74iifNLLFLNCGSCiN7Zsz
 shiml/uqwq5EjW2FmJwZPYrCPBTJPUARzyJLYguOGuKkR1qoJsbsmQ3I5s2Q6TgyVHOA
 H5vBnTqBLrwcE2j7JJ2YC9lO+bcRwiRYrSzmd1R6wZbIIY3x4RMJ3QKc0DTD5GPO6qdg
 EdjF5OKE4vpT62vU3rJeDd9HejCDO9Y7AUOEpx7EbTPTxXC31oL23tIOmP8xNH0WbwAx Sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstq0b6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 00:00:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28UNVeis005138;
        Sat, 1 Oct 2022 00:00:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtps9jjyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 00:00:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYdWkowzeecV/TCY07f0jpq8YsulcztuvtOJ099UbmWLq4fb1AF5YK+1ekrg5T77xEeS70wb36P3S9GFrNR2rDz8c3b4v25mEdAIy38RT2NiXoTj6nNbo6f9lTAUQgTrevtuWQvdhi7YUW98hY0aBCsxd/cdLv8Nspj5oiPTo8oIP6jg4xvaSPyWqQqF8K9BkQjPB8Y2zJFmTreK6nGKuJLAunTrvl2BzH+OlHuE8oYU83zQfXtTc2digvfChyWMPMauVNDayQHxE2QZ3sFcVnA/+4pyUMYuBIZGurK+Tls0lGQgFWg0iI8p9gRyUIz7ptnbBNro/6YrRGkMRL4EsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5CUqOSI6NUKPsm2f7bdchBdp4+rmGoTyMMTnAKcmoQ=;
 b=cNvo761EGpNKZQfrE+XL+E3iR/WgjLQYgspLlMVZdDcIvzurdV/0+s2Q7kq6bLOGk/GqJB4nTK2sATfY6hID7TC6X+NRwXvY8cwHa589UeDk9fcVIwAMV+ppg8J/9sl6u4sMY9Kb+cDJ/QPPs4oDWT9rMW7PIKmqONnQcnmEuAGFWy9DpkoJXYKsJauPrhA9goXA6fGmJYxY0u+dZVmtsuUAIfnXf/kqW4yO2TaGBRQtLe9eN1j+p4XMbNOZlBW7ZarQYzUSK/JuegWQuKBR1wfki/WoRGGE5S7ZCK76hgYYwIju/BjkQlVgScvmQ7PRy1D59JCqP+968tO7fA1PDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5CUqOSI6NUKPsm2f7bdchBdp4+rmGoTyMMTnAKcmoQ=;
 b=PpAm8ml3hp1u2pnPE4ZXzUymCTxjj4ScUogQDOXALOOHbGBJ/PNh0sPV5F5Xecaz6IevZFuFVkNLbFbJDss/jB6vFoKOOdEfNC9+1MDxy/6n/33qHxs5YgSCfIL6GYYJHjuu0azwFntH35r+zTgwQ+c+4EuogCfkvILZQYHZ0JA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY5PR10MB6009.namprd10.prod.outlook.com (2603:10b6:930:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Sat, 1 Oct
 2022 00:00:48 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.023; Sat, 1 Oct 2022
 00:00:48 +0000
Date:   Fri, 30 Sep 2022 17:00:44 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 8/9] hugetlb: use new vma_lock for pmd sharing
 synchronization
Message-ID: <YzeDLCFMN6XZNfoF@monkey>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
 <20220914221810.95771-9-mike.kravetz@oracle.com>
 <01f10195-7088-4462-6def-909549c75ef4@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f10195-7088-4462-6def-909549c75ef4@huawei.com>
X-ClientProxiedBy: MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY5PR10MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5871f1-fb66-4644-f455-08daa33ffec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +EP5ArosCxXl0hJWPBMNRHQJliNIzL+nLEXwj59pr2oOJAp7yf2BTtpof6w+Gly0e1F/3N4oCW/G0DpsbVl/4UKvjY+G/vP+wj8wVWbFxAQOauM/jXeM0zkORrZofLHltvo4vg4+jJevVqcSf2MKtZmHWvkgQSWkqStoRUEGOU/k2/Ues0UAX055eXOI4V981IOJ/42ONyvnO2fouRf2+3kIwYuHDUdeS80zAzDu86wlZGk9kG5n4ORcE83pOV0F9aAmI61Z3dA3AU3kf/uGaBr4sx6WaR307TRHEZcoO1EQbKScO+GTeVgJXMldlonWzvdMkXl8oxO/XiNP7LYT9R5gHVpdt6Dxf7B07uImf6A10CW6+ldkbHGMkrrUxZvYZDtGtDB2Uyu0bqKUb7qzCvRQTgJlsn/pGN3ZCPA3OBJiVXHVy0UZhoVawFe6XmAOq/4rzR+zF7zY+POIAOPerYw/ocA8C35pyecu32TC+doO/LQvNlT+cAR5ivHBVkvhV8eO6lb3bdHBAwqwrcuhwhfFuerAyefdY5wNjzRk9rwJ1PgjZFLZ4RaibA4AgAzc78c6OrIJvM26VU8xgxcWTmzhHlK3KQjzT8Py/s3sZj2oxKukw8BK4CQh1Lwv9iRrzm9Q0fbGC3qai+EHeSZk6Zls5oOF08ROz6/4fxdfTPW1Fnh7Pfo1C8Smrn7qFnafLdJNtg39NNb1goykBsHC+CSP/H8zEPcOx22BEORQ8M4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(6916009)(54906003)(966005)(316002)(478600001)(66556008)(66946007)(66476007)(6486002)(8676002)(4326008)(7416002)(6512007)(5660300002)(9686003)(86362001)(38100700002)(53546011)(26005)(6506007)(186003)(8936002)(44832011)(2906002)(6666004)(41300700001)(33716001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NJqE/X3opjPfIc4Asmtnz+a008VCe/+xteXtpGKibppg7Bdi18tNFWc5GU0U?=
 =?us-ascii?Q?JAfjJeNaw6Rbm0iE/4ao7RVqmDsu9uaXIWM8zY12mukiXfyEdH6ChKFtZEji?=
 =?us-ascii?Q?AQ8wJE3zxTvJeampyXlGyQlsxhcJRfMZjKL77BPcRmEjI1IiGiFtkSg2pgp6?=
 =?us-ascii?Q?BcYf+OSBYMR3oLpmZinBQLt/fblIUJsI7pZ7cSC9b6vIJ9d5ii4EFjHCryWi?=
 =?us-ascii?Q?Q8AeNKX4O6u5OgWtPzA1di4YhL2WJKmnIEsodccPNCbmvVSN8H9GVvEO5MPW?=
 =?us-ascii?Q?MhBdUjgjtkLIjHPF1f43Zvv24WD5heIU+ZlfxOn4t7tLYfQ6agvR1sn9cjab?=
 =?us-ascii?Q?JgloeiY9jGo9gQc+Ki4967BDCkP/8CE4h2rpHAKyp1b5+gjWBaaAhy6e/XMS?=
 =?us-ascii?Q?st3AvbbtirHaaiwjXM8m/p/ZhbVIaDDKxwJ07Rn54Xc/jzMZQthW9D9ORNDr?=
 =?us-ascii?Q?nt167Qtaw6W1f45iHAi7As9elz7b0mSi1bLTLWtCAfzZilFD8lbhsUvAvs/3?=
 =?us-ascii?Q?T0ZOqnrFeePQAmHy7MZI+0szMfAhHcE2kXRogNFekwRtlTB8aduMPJ1hNLaM?=
 =?us-ascii?Q?/ljHLhfx8oAPm7jRLspepzgyGmE3yqNl40KZxwcgFHaGsOSEIYzU8y1cv149?=
 =?us-ascii?Q?Q7cO5AQ7RR69paTfdrwIJjSprq9edcY5nFTwNqGsWopuRYFf7xMUG1TupkOR?=
 =?us-ascii?Q?vUos41d6suHHw8F0gg2M2rlfvHWPPuQ8PpjY6e3eWHn/3vckZm3cyYi5mVxJ?=
 =?us-ascii?Q?Emd5L1uZsCxyBPO3Hu6C6NE6040VIe5/B3isQ+5g4E0MIF22fk1kxKs65ZkI?=
 =?us-ascii?Q?6zVhmk1i5lWwvriJHjL9UO5eb63cJDQriG6+GsI/mkOH9uiKlei0OVFGJ8GR?=
 =?us-ascii?Q?TxLuOYvKOvE94GnRrlZIIubEnWgjTseMlJUaFl8v1VMtiCrpRjr8L8tM98sV?=
 =?us-ascii?Q?pUvRpELhSKujf0IJ/hlWxQrXd++3pnpje8xNKvj+3taJrj5Fo3GSnaDfXxn9?=
 =?us-ascii?Q?CC8jUR5LfNHCNyo5DcuS9uHAJw56F9QXdkOTaMg3qGzEBb7nlhVpFtnHtWPc?=
 =?us-ascii?Q?2KGXmv8YTW7EdCRWyqAa5rPLBCpPD6kDBuxj+vXLuCIMLPSe52GEivPSyCqD?=
 =?us-ascii?Q?rkCs8V2hmWMavE2D8TF9iNp49MmtBurohO5ss1XQzlH7wRylKbLo+wvZ7whO?=
 =?us-ascii?Q?/WQwBfzRuv12D4nlRzIlk092jAzOp2V9oIEU/3B0i4YT7dhlg8nfhy4vvd9W?=
 =?us-ascii?Q?W6QtSJ3nqo0IL2KB9obKyRpFrBP+Vq9uSPwW1fgTNAg/wRx3hvUwsD60eA4+?=
 =?us-ascii?Q?f6ymGcuDSrzCULN8vLFR4IRMXpOV3zNcw16QAaNsmFtdZCiA5cVT25Cfs5o8?=
 =?us-ascii?Q?IufBSTCfIz2vXruNXdr1/uKgRl06H94Syg59yPovb/CD0h+bOw/pgT3j7xd8?=
 =?us-ascii?Q?0GqH0CKsjighvtEgQGZP4iDTcTiKe+MtMPJxdD39kOWzXCygVHBvcn3GNFCc?=
 =?us-ascii?Q?N/IVfBuMjEn6sKRBLIx+0oJmH3laL0g/2Sros/arv+zgnTd5QmWY5lii27Zz?=
 =?us-ascii?Q?PM+8vglOKlmKlp0laL05Wp4fxqjtQFN3bv5eqqVAef/aDFPINR3QFN8vs+pJ?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5871f1-fb66-4644-f455-08daa33ffec3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 00:00:48.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oC+hv4OtRFdpxqPouqChEboXcxi2Q7xpMEl/924zrMhIlFx6fRrBaLCJfIHQ3ncJazjDyzYNPG5mH4H1VEEIqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_05,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209300149
X-Proofpoint-ORIG-GUID: GyiEGFQ7ADGFGfWhiYtKwWdn6KB19fjF
X-Proofpoint-GUID: GyiEGFQ7ADGFGfWhiYtKwWdn6KB19fjF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29/22 14:08, Miaohe Lin wrote:
> On 2022/9/15 6:18, Mike Kravetz wrote:
> > @@ -434,6 +434,7 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >  					struct folio *folio, pgoff_t index)
> >  {
> >  	struct rb_root_cached *root = &mapping->i_mmap;
> > +	struct hugetlb_vma_lock *vma_lock;
> >  	struct page *page = &folio->page;
> >  	struct vm_area_struct *vma;
> >  	unsigned long v_start;
> > @@ -444,7 +445,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >  	end = (index + 1) * pages_per_huge_page(h);
> >  
> >  	i_mmap_lock_write(mapping);
> > -
> > +retry:
> > +	vma_lock = NULL;
> >  	vma_interval_tree_foreach(vma, root, start, end - 1) {
> >  		v_start = vma_offset_start(vma, start);
> >  		v_end = vma_offset_end(vma, end);
> > @@ -452,11 +454,63 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >  		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> >  			continue;
> >  
> > +		if (!hugetlb_vma_trylock_write(vma)) {
> > +			vma_lock = vma->vm_private_data;
> > +			/*
> > +			 * If we can not get vma lock, we need to drop
> > +			 * immap_sema and take locks in order.  First,
> > +			 * take a ref on the vma_lock structure so that
> > +			 * we can be guaranteed it will not go away when
> > +			 * dropping immap_sema.
> > +			 */
> > +			kref_get(&vma_lock->refs);
> > +			break;
> > +		}
> > +
> >  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> >  				NULL, ZAP_FLAG_DROP_MARKER);
> > +		hugetlb_vma_unlock_write(vma);
> >  	}
> >  
> >  	i_mmap_unlock_write(mapping);
> > +
> > +	if (vma_lock) {
> > +		/*
> > +		 * Wait on vma_lock.  We know it is still valid as we have
> > +		 * a reference.  We must 'open code' vma locking as we do
> > +		 * not know if vma_lock is still attached to vma.
> > +		 */
> > +		down_write(&vma_lock->rw_sema);
> > +		i_mmap_lock_write(mapping);
> > +
> > +		vma = vma_lock->vma;
> > +		if (!vma) {
> 
> Thanks Mike. This method looks much simpler. But IIUC, this code can race with exit_mmap:
> 
> CPU 1					CPU 2
> hugetlb_unmap_file_folio		exit_mmap
>   kref_get(&vma_lock->refs);
>   down_write(&vma_lock->rw_sema);
> 					  free_pgtables // i_mmap_lock_write is held inside it.
>   i_mmap_lock_write(mapping);
>   vma = vma_lock->vma;
> 					  remove_vma
> 					    hugetlb_vm_op_close
> 					      hugetlb_vma_lock_free
> 					        vma_lock->vma = NULL;
> 					    vm_area_free(vma);
>   vma is used-after-free??
> 
> The root casue is free_pgtables is protected with i_mmap_lock_write while remove_vma is not.
> Or am I miss something again? ;)

Thank you Miaohe!  Sorry for the delay in responding.

Yes, I agree this is a possible race.  My first thought is that we may be
able to address this by simply taking the vma_lock when we clear the
vma_lock->vma field.  Something like this,

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4cb44a4629b8..bf0c220ebc32 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6918,7 +6918,9 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 		 * certainly will no longer be attached to vma so clear
 		 * pointer.
 		 */
+		down_write(&vma_lock->rw_sema);
 		vma_lock->vma = NULL;
+		up_write(&vma_lock->rw_sema);
 		kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
 		vma->vm_private_data = NULL;
 	}

I still need to do a bit more work to verify.

Andrew, if you are concerned I do not think this is a show stopper.  The
race should be extremely rare, and a fix should be coming quickly.

<snip>
> > +	mapping = vma->vm_file->f_mapping;
> > +	idx = vma_hugecache_offset(h, vma, haddr);
> >  	hash = hugetlb_fault_mutex_hash(mapping, idx);
> >  	mutex_lock(&hugetlb_fault_mutex_table[hash]);
> >  
> > +	/*
> > +	 * Acquire vma lock before calling huge_pte_alloc and hold
> > +	 * until finished with ptep.  This prevents huge_pmd_unshare from
> > +	 * being called elsewhere and making the ptep no longer valid.
> > +	 *
> > +	 * ptep could have already be assigned via huge_pte_offset.  That
> > +	 * is OK, as huge_pte_alloc will return the same value unless
> > +	 * something has changed.
> > +	 */
> > +	hugetlb_vma_lock_read(vma);
> 
> [1] says vma_lock for each vma mapping the file provides the same type of synchronization
> around i_size as provided by the fault mutex. But what if vma->vm_private_data is NULL,
> i.e. hugetlb_vma_lock_alloc fails to alloc vma_lock? There won't be such synchronization
> in this case.
> 
> [1] https://lore.kernel.org/lkml/Yxiv0SkMkZ0JWGGp@monkey/#t
> 

Right.

Of course, this (checking i_size) only applies to shared/file mappings.
The only time hugetlb_vma_lock_alloc should fail in such cases is when
we can not allocate the small vma_lock structure.  Since the vma_lock
is primarily for huge pmd sharing synchronization, my thought was that
allocation errors would just prevent sharing.  But, as you point out
it could also impact these checks.

It would be easy to check for the lock allocation failure at mmap time
and fail the mmap.  It would be a little more tricky at fork time.

This also is something that is highly unlikely to occur.  And, if we
can't allocate a vma_lock I suspect we will not be up and running long
enough for this to be an issue. :) Let me think about the best way to handle.

> 
> Other parts of the patch look good to me. Thanks for your work.
> 

Thanks again,
-- 
Mike Kravetz
