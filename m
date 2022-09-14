Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E8C5B8FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiINVL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiINVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:11:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A18307C;
        Wed, 14 Sep 2022 14:11:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EKdGG7012546;
        Wed, 14 Sep 2022 21:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ZJc1F9HYQOlsczZEz1vwWHtL1KKYf8bQHQYFfpT5CNA=;
 b=ZkGcqOeKJrR/J8ljmv5spZWDvnwHAozGWiNb85CdWi1gIJuugIIYrwWrD/fVD9ceChKs
 ka0PXy/iryrQEKRmFof9QT0t8czISYhnJzbBR3XFSlgZRPgPQ0bd1B+ZxEIj1DlMAK/b
 zlGft8Al2A0HvgGduWguZvUMCU4gbc43KvseoSd4Lc/wpINSJnfydOwit+Nxz5TLtI0u
 sieL2Vu1MpXJKrLiOLH1CbksPgqH9Vu0oiytV+HT24fri2xG5K3CCDNYfohiM/zkVDqj
 2DqXRG0Dgy2N9HJb2SjLzYMxar3q5Pm04cPB5xUSA8nBQNUtqakSu5PJCEb+CcT1zPVg mA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypbmby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 21:11:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EIwJFR035572;
        Wed, 14 Sep 2022 21:11:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyehr0ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 21:11:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVwykQ/f03l6C+0nHy/bJsRy5jfEFDfzXAefnvOjyM2f87SjF2zBNhRkCaJrgRPujvzKgjsgc/oi59thelPiWwnVLep8BWIai7nCG3XVq7U8pra+HAbcmM4Pi1GkYbMC+bfoG8TthuVcJtY1Wzx4b70TEoR7OsP0qvs5U2b9x96Wei03ueuDnJxZIAAKwaQJ9bdpLNrr+W3s+TjQ0vhrZVS5EOe9naL/bz4Rm2e6HBlS9AQYm+pkxNEyZGnMHlLJFDaM4MI1G7zhGSzfXuOpLMRy3lmtynj4IBrF4xQCdiiwMSXip894CgPG8E2lWx2sOt7JQDySGAvEPRU/65anFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJc1F9HYQOlsczZEz1vwWHtL1KKYf8bQHQYFfpT5CNA=;
 b=n7cSFPdyZXpFDpc1rbtodQKVOnYru0WCKa2aEJH/7bKc5wm4EFCyjxBTkN/DDQknXe/u2cDY2m8yOTqAdYrHqJEUg3R8+lNH19hj0h6kR6Lhb4z891bXZUiLK4kk78qDTjvurp16tMhyWV0CbTm6NOHqf19m90AbICDTIHEUyRTDuChqTGp+sHrSzve+Y6fT3kJN9+sw9wQKahLqLSWOTNP59ZoBKz/tRHn44RI2yKRmJ6Xn6PTEsObF7NHsA41BrvWW/+gzeb7Ax72OdnyTd4Nx7KPXGHaIe36t4Cxa7R4Z8svIYZCuYfabjFWp5iyzIaI/J0vvH46FP/QBFkV0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJc1F9HYQOlsczZEz1vwWHtL1KKYf8bQHQYFfpT5CNA=;
 b=rFTNhmL+PDhkyO1+8vA34+giC2MCq6WJTBeY+GbJU007msnJmG4y8sSNGjZyGLI36uNz5KNQMuKie9V6TXbV3nBEr4s8HCV4C3OZkOpgc1W9/jTi8a6VDzbKkckayAmAWAha23pjpgzHqvop6XJhnmgVkKHAFNZrX8xiMQkzd1U=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY5PR10MB6047.namprd10.prod.outlook.com (2603:10b6:930:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 21:11:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 21:11:09 +0000
Date:   Wed, 14 Sep 2022 14:11:05 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Doug Berger <opendmb@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 02/21] mm/hugetlb: correct max_huge_pages accounting on
 demote
Message-ID: <YyJDaVRrKy5jgewU@monkey>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-3-opendmb@gmail.com>
 <YyIN+bpKdCb3JuuY@monkey>
 <20220914135825.88814aa1699e93c8a782abc6@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914135825.88814aa1699e93c8a782abc6@linux-foundation.org>
X-ClientProxiedBy: MW4PR04CA0371.namprd04.prod.outlook.com
 (2603:10b6:303:81::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY5PR10MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f63acdc-4995-48d7-f0ec-08da9695a51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhfp4ORNBpfbD6YXmfV77AmYxZWGRWL6US7ui23Lr9CJl/anps4KKasU3R65whZRwS+j+mRH8ncSr2cRdqp5Vtu77mSpzaJsAd+u5h9rItJoHyubwCEDwHRWhZmJPI/2PmQaA6xWIuAaxdwW4scTxmNCh5gqIT6sHxGyFBDR2v6wje758YIAFNgReOQX9y06pNd7hDULONIDu/oJCTuhTAeW7bPk/bYevMPRPHqQiO+KfvHSj8xgnDVWlQBoElofSaWlg9iTXn7aIS2PMVRHppG38hIXgphmAam9A7wp3xKOOe/k4ma0Wjl9i1LsnQIdOOfEC9EqWZSmI55Wy30Kbdl5PsyH+Z8MIghE6o6H4CWWR5s8v3XCXBtZzIo7/IMAb3+YvG5WnQRDXwDvncj2Sh9+oaJjzUatA7+313cjbY3WOxr9MvFLxnoOSH/OCU13asr3LC4A6/xBkhE15FvRuD9tFNtUwoyRun6Ir5bLEe9EvkIfb23szVE1VouY6TWcqmw+T0YHJWFW64H/Ef6ro8S54H1hmlM03w2Sz84ZWBeHk15nXhffOsfh40s5ZCv115WlxOmMw5O7dQLhT9NK1RuOwuy4ufhYDIa+vnv9/Y/rvZWsSOUwIhVmcfM/J3xESLbgghJAUHu7aF7eiz75UUMRLuxVDoDyVs8SxWXVwdlxTEVkPS9fzGr2PBTZOyvkn64pZbh8qrdN3HkmJkEN03aePs4kBQkuenEcreihKEQaIFE/dOKyKq3Rj7fg+8+9CNZWKbaM0jN7Fu6gIMaut5z29kRzueHTsfoM9fcnrvYTGlMgqciNiOhwhHKg2gix
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(53546011)(186003)(7416002)(66946007)(66476007)(66556008)(33716001)(6666004)(4326008)(8676002)(41300700001)(83380400001)(8936002)(44832011)(966005)(6506007)(316002)(54906003)(6512007)(478600001)(9686003)(86362001)(6486002)(6916009)(26005)(2906002)(38100700002)(5660300002)(7406005)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xs/rUxOkxCNyFmGAzdTXlrpuh72vfJwLEM4PwSbCIXBcv0P44vAIgKvJQWkg?=
 =?us-ascii?Q?2WF0uqKHR8v6b6N0cW7+97zAnbW0CaLtZeLPotw4C9oJ+uVIpVpXkCvwvqkx?=
 =?us-ascii?Q?EgLXRt/d9I8VBt+UvIsclsEkOcrqyYtATUZ4XG8951KOBWu4k4k06BZJoKBK?=
 =?us-ascii?Q?OIGwkfFxODSUrzFJZiO7tebnNm7Ye4VgE92zU9ta7QlLFAP4Tt6ZzhpLMX2o?=
 =?us-ascii?Q?n+M4TmXAQJR/OGbjq89AKmzCcS1yG1XbxlABRytE8ucaahgK74OZVFKATIiv?=
 =?us-ascii?Q?frXBTOmnU6x9W+rjzy3gfTYPtcrETsNIrh/fhX0aSgMcUc4KipEE4o4aa/lk?=
 =?us-ascii?Q?hffGTfmgHIJyJ5sSwQ/mIGrR1Mmf3L+HcezxmrjhAVRLWBtNEZ4dAYkWxp5e?=
 =?us-ascii?Q?m1xReRZVHH8TtzTOqO0fYzQh7sa6ITuCWIOacUXGtf/dfTAWDsymlupYZH8q?=
 =?us-ascii?Q?73rtGuRLhcnRrCRpYcFvrqYNhpEdZNWk2A0g/4IY3XOS4FoCf2D73dp+NNq9?=
 =?us-ascii?Q?QxMgetJ7lyrmb2uXA44Pdlsg6x2WrWgXpLJJcW5CCj+B+HW+KX6FdSXp83lI?=
 =?us-ascii?Q?buTIszkKduz7gqSJvUOuilecMGVKdsK/QOQb6QHSbq7jY8Ln3DdkhlPuM7Vp?=
 =?us-ascii?Q?Koy4FzCwePLy0NXS7Yihd5eUiaskdreNNBXvsrJ1Mb7vto8Ng5rs/tDRXmrT?=
 =?us-ascii?Q?E1Kril92Ibr9GUmVcy8tBaQ0BoqIUAzsb5OAIXarewi1403btgxs4FZaM5JB?=
 =?us-ascii?Q?ZLKXvEB80+z3WXQOvOghPZteAWBb8PpvSKV0kDgyzl3l5Z3F+Ly9s9iuFYQg?=
 =?us-ascii?Q?6Y4s5eweE9jCPTLLXdZn1TfAHxhd/JTpSztRBaykIGbKeJxhW38iOvJq6EJ6?=
 =?us-ascii?Q?9VQTgKOBTrUEr7SKE70/Bfu4hzQNREGpIMKCOtOgq8G+pGm5OTI1WY8Y/x0E?=
 =?us-ascii?Q?eBMjPt6bKb57rMnjnKxgHcqD4quZEqZk+TdOq50dMK3+n1imCk4x3u8qHKsq?=
 =?us-ascii?Q?+Ca701NCbvLZGKimjaW5DzZuhzXovEcMwOj3KJCdalpevp8vsxPq8qHcMl8F?=
 =?us-ascii?Q?+rF+CtmA8TFlST+pUFZ++zKjMEcb4S8280JvZdXoERy/MuI3QTUb/eSP1gmm?=
 =?us-ascii?Q?FlTLN4pT7oeQCH3Gr40dPwAFK6jgX8KsWC2uRg8S06TP6MOvEKY1uQ1hbfhQ?=
 =?us-ascii?Q?cn7ADZFkWE1Qw4jJenqikAsyQnr8LvaNkqDM3cF0mYTs6VILOxhqagWmDedA?=
 =?us-ascii?Q?ULE8hdaCN09M0MYZB+wjdgKED8S0zMLQC6QkzCTfyQDVva8Fvi4A6+rI9HGS?=
 =?us-ascii?Q?Djid3Wzm0O1+rZIG9RipHjLJhfsGTQBBKu1skKAWlyHZFCIPwmtZfjD7mZid?=
 =?us-ascii?Q?BJAI2KXes+KTUIG/6LKhylTiphD8tZ6lRU6wR35WtpSHgSs7LTuWGU7yZXjq?=
 =?us-ascii?Q?JGGNkZy+kY38EiNEtrhiGMN9oGFZaNXoWXymjMSonKS4FyPqmQxiqFUMxs9g?=
 =?us-ascii?Q?3Sp33SjJbgBKTOKiUjN4yFwONCyHmscu7xyfnKfTKDHmbuk9sNMcjXUGzJ/n?=
 =?us-ascii?Q?CGNerF89mX0Xk070PdTyGQAJTTurSjBhnYSqqmKfwNLIsm2B0ts75CXvt1Nr?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f63acdc-4995-48d7-f0ec-08da9695a51e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 21:11:09.3876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sdo4ydswmtTgWF7/BBBNl6S+jLzBTJbigakwT3nRqPK/jyAvkBUz0nUJbwHOv1YhkQFvt0DUIL/NdL0gP20fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140102
X-Proofpoint-ORIG-GUID: o47Za2_nWZCmQWDSLjUhUfHgjtNLBAOg
X-Proofpoint-GUID: o47Za2_nWZCmQWDSLjUhUfHgjtNLBAOg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/22 13:58, Andrew Morton wrote:
> On Wed, 14 Sep 2022 10:23:05 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > On 09/13/22 12:54, Doug Berger wrote:
> > > When demoting a hugepage to a smaller order, the number of pages
> > > added to the target hstate will be the size of the large page
> > > divided by the size of the smaller page.
> > > 
> > > Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
> > > Signed-off-by: Doug Berger <opendmb@gmail.com>
> > > ---
> > >  mm/hugetlb.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index e070b8593b37..79949893ac12 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -3472,7 +3472,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
> > >  	 * based on pool changes for the demoted page.
> > >  	 */
> > >  	h->max_huge_pages--;
> > > -	target_hstate->max_huge_pages += pages_per_huge_page(h);
> > > +	target_hstate->max_huge_pages += pages_per_huge_page(h) /
> > > +					 pages_per_huge_page(target_hstate);
> > >  
> > >  	return rc;
> > >  }
> > 
> > This has already been fixed here,
> > 
> > https://lore.kernel.org/linux-mm/20220823030209.57434-2-linmiaohe@huawei.com/
> 
> Neither version tells us the user-visible runtime effects of the change :(

Sorry, I should have pushed harder on this with Miaohe's patch.

There are no user-visible runtime effects.  In fact, this change really causes
no functional change (unless I am mistaken and Miaohe did not correct me).
max_huge_pages is not used again until it is reset.  See my explanation at:
https://lore.kernel.org/linux-mm/YvwfvxXewnZpHQcz@monkey/
-- 
Mike Kravetz
