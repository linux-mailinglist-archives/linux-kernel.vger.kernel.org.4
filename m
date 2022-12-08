Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01629647913
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLHWzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLHWzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:55:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4A675BE8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:55:47 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8MIvlN020769;
        Thu, 8 Dec 2022 22:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=bvJOS8DSJ1EJ4HA30V2gSqCuNWwqSq/VAvTROAY+t10=;
 b=vBdvh3n9vJ28av9S/yN5hy1iUzvtGiGmAkkyh28g9OPpbaKliit+wILZcoKdxlW9OCEU
 Vu3L1cYbDlins9TGD58UiwuSOc3nmtLL3j0aGuX9BFRFJhtNswvbMVwjQfvEYEoQ+mNE
 07CaVLB3musQbaGvNXmvpuCCckNAmNVuFrjB7UcQVVZEgZOBC7pZ1VCdBtLfECgW2enc
 dL5rl5m3tVbUER5oEJ4JlkqEJ29clJtdl2B1goJi/cfbdJgdrxwBzgqL/oC5MhlavPNm
 BHiiRyBH172XoGXbF5wYFJWXBt5ugYL8Tmxzab2Uh0a1zcFLePlNMTBIi53ozkJAY3zD yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maxeyu9aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 22:55:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8LwmEe032653;
        Thu, 8 Dec 2022 22:55:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7f0wke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 22:55:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvDUyhG20CdNNQ4stMn3qpZ30g9rJRJOlXW7uSiqrMnB+xj+euPNQMErHXwxnNBGVCoCpT9GT5v3aN0fLwZsXeoKwXW3WVECS8EV+vb3Abcp/rJ6NQb22G/OOIZW8ZX3mUda2mLL5ejo0prOjR+9VVNJTm0nbsX1jLGYeuQrixQu5e3DNQXQEjgpI8/KF8yVmCiKZCWChxu6lD/cjigCzsEEMiJWcYcLPquV7tEdydmsZLDSx3GchqvuMXJmJmmOrfC+LHfTndt9IbHXRFBpUopR8CE9FdFCCHjWx7VVtp1xKrMv/i1/h3tudxKHMy4zBfHhxS0cV2WcI3R/LW7FRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvJOS8DSJ1EJ4HA30V2gSqCuNWwqSq/VAvTROAY+t10=;
 b=XLjafEKl5TWDTkrjqtJGZdsMWw0c79h9o/ZAQqkrH2CduR7rJxHSAl3DKYfmPkGKHGfZlqn0U7qVGgS/8Xli2a8ltvFTe+YJLjn+bb5/9zd7imPMkATmzhqX92KSwut7+p4Ponk6M1g+8AAF8hUknsJiD9TZdkfc9DAjoapNHLtK+jEhMrPC5o02PlTZ1RsQ5HJHweNgzZlPSGH1iPGRZ0gNdAUIX9RHlOO2zvWBh6r9MVHo/1GzWQsXbwe1VLa3r5mp/Fzq6wIFOy1uRa/eEqWxQf1A+coMN301yU0uLRovgmohgqPf/M2y0UB3ksPdewg0qIP7X491rSoX38oDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvJOS8DSJ1EJ4HA30V2gSqCuNWwqSq/VAvTROAY+t10=;
 b=lXA16xUfieU9BSoB+zTFoOgNan8b1nNp+MDF/4sCn7s8OVhcODrlMWK70rLNn/S4zZXfRJ/as4dY1P+7ht9scRCKREoqyFaXRuzAZm7Hfvt6bldPkoC63T5P8GODDKwg+J84yjDPFmnVI4zAubTG92iGPT10xe7vtO+fL/CVHBQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB7277.namprd10.prod.outlook.com (2603:10b6:8:d8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Thu, 8 Dec 2022 22:55:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 22:55:11 +0000
Date:   Thu, 8 Dec 2022 14:55:07 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/47] hugetlb: don't set PageUptodate for
 UFFDIO_CONTINUE
Message-ID: <Y5JrS4o5Detzid9V@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-2-jthoughton@google.com>
 <Y3UQCmlnQXfKhbyE@x1n>
 <CADrL8HXXT+7BBMj3kgR8g=z4RZv0q-AF5ykkg1vXF9aYCWg9MA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HXXT+7BBMj3kgR8g=z4RZv0q-AF5ykkg1vXF9aYCWg9MA@mail.gmail.com>
X-ClientProxiedBy: MW4PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:303:16d::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: ca325d12-f3b5-4864-e365-08dad96f42bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBxXyb8q43FsEYjSgUhCpPt78I+MTy2Ygt82d6YmAYELovApb0Oei9DIOSaiNa5Hsxzz7y3OvZMAMFk/gOzWjx5ua0aC8cj1rs688jPhi9DdYp6/3B8nFuf5VS7Zyz5guCwLP8FoGCv41LJ6maWf6GiemHzQK26GOXnLZmj7XRuBun/N+0YCIZDuxhvQ+tsdrQj4bc74+1Jke173h+PJfVWJ9szxkHTQHQs+TupNWEanib2MDKwAu+AfKBTvnvHLsU85mray0aPvICLGD2cPp+C1FbjTpg0etDTs8PLBbqpG2d4ctNwukp94U/QdSDMCXgG0cIsRDs2qsjTM7a73rFJzMAHq8mLct46ReIOqj3hJZjZLjN1VLcnhF9xm7I+uh7VSrwDNh3uYZg2ny5svuUsFHD+bsm86RwQ+Dpx58hG0Jz3aKbV8Zh5/B1UURkj8qwbzVNJz0r853ewfAoJj53Jhr2F2ImlPYDwAS+x2/IcLtTU/1nRBrsMcqpwy5eMirbQwnZ5zvGJ+qbuJvpy75xsZPdSqR828g8pWn7Qa9XcSu9UKrsyVYrrYWf6y8FNHhXC4BxhnKdT+aZseNSFp7FkyV0yEkCZDsRx4WTdfMRhOrM8gzubFGtX4xb8I8ytZ4kLTOc81xZOWMWxpZIHFuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(86362001)(66476007)(41300700001)(186003)(4326008)(8936002)(5660300002)(44832011)(8676002)(66946007)(478600001)(66556008)(53546011)(6916009)(6486002)(54906003)(6666004)(316002)(6506007)(9686003)(38100700002)(6512007)(7416002)(33716001)(26005)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAWjxM59SXlqTJsgU9OxwMoYa/Mbsv6u8o8Woh2ExoY9l7t/nfKH9Q230BnK?=
 =?us-ascii?Q?u/IjA/RXkdHlZFZhbuhbBxQ9BgRqUO36627JJl0zCZnLTmzKkUoY+HCVQIww?=
 =?us-ascii?Q?U8VVqzGqz+UBisfffCe6LVCF/hVrSqGcw8PqZijRdBYO5WUgI88eDV0opXYm?=
 =?us-ascii?Q?yIebt2h9SOFv7OvZUuQnXXoxdgSXNalM+lNi96oxJUegzMob0utqwcDXo/OI?=
 =?us-ascii?Q?HPswGMJ/OOfx8Mc2NfGFPvDH8fpdL46dncMq0HTeQA5wvupft6WN51VWtD0Z?=
 =?us-ascii?Q?uzc9xPphnIacD0Mqb4iCyJpOsxH2sLgcw7pczwMloeo18eAF4mP4PTsmkZ5U?=
 =?us-ascii?Q?XwCl/aZOoKa+KIk9sl7aEbmHpNkmMG5XNZ9cKM6B+q55gfe4W6cg23l37YjI?=
 =?us-ascii?Q?6khSHiWgukG123z5unWLm4h4sqoa6HMT+UGqrdvhgKJUB5zntdK/fR9v6BDT?=
 =?us-ascii?Q?wjeMTYywEnL020Bvbd8tcDqEICxH6qYkO2fV6CBtcOgCWdUPxeXjZPU6rInY?=
 =?us-ascii?Q?qO65HxLHtvFC3SZV5HLHyp3+sX3Pr2tzEwE7C6SQG4pll7HIeUn1FZ7LFzRB?=
 =?us-ascii?Q?WgCL3sY5ohMGiQYXciPvH6sdtnvMa7Ou1k/kUpyajEPgBSnExyIr0L5EeIt4?=
 =?us-ascii?Q?+V+R5ecfUhUTK0UZw5Bd+8cmEEyTRMEicPZmVyQSwhLysKyjlMgespZf4Rsr?=
 =?us-ascii?Q?2FqBUNwXmYskF4UxM4mag7NX3hPGcq8yKdgL28eFbsr55va76G/z6b71BVYM?=
 =?us-ascii?Q?FEaVyRRc9xN3ur092DnCGCYZB51a3fOnTNb3/c4ROBj0bqIyOh0YCnKYPjp7?=
 =?us-ascii?Q?50YvStvEyPCoxMtoZv8CV5fysXpV06b1AxVD71gQE2Gku8zU/glpDl8gEqbX?=
 =?us-ascii?Q?CES/5QaVu6j395d2eI4mPtebNXcYk58D34a6LgAoF1Mdf+s/LCNVIJrPZLVc?=
 =?us-ascii?Q?tfUyqE2W9z6lKjlf+kJ0UJZ15wkHwpGkECFIbr+qFDu36lO+UToq1Su8izW6?=
 =?us-ascii?Q?jKMIu6JTvO0gyvr44XyK5cWKPlME3IPj/72Gq8RJkYki0ajpzUAB6EP3BT08?=
 =?us-ascii?Q?4tesdxgb8HJIhl+WWqOHwADd93JpMmTpEtellim16vRtmvb3LEWAneLOB0Fh?=
 =?us-ascii?Q?kD9dgzugMDIqCuKgDASpDHRrNcHbiz+3h4XbFFxJk8sJLQ1JiEWJGj30ajdC?=
 =?us-ascii?Q?HBMDKT3MbaXzqKqy0Kinl/pGINsHUCDU4fCFPvXF7QzyXBopiE0cS2nZZ50k?=
 =?us-ascii?Q?9m0CwRBIZ8eGZVAM3LhO798WMtOqlrIGju17hNnDU1QvgIlvZU2U39zHA2Cb?=
 =?us-ascii?Q?b0Js9knHDbdFSDzg9gZZHMDqhDqLhdJ3b0sB5s593oQJkJvKa0G93RJ4XzFr?=
 =?us-ascii?Q?ElwZxJHEUoF5gIFJ8XJbKt2UHvctMZWy9OcTC2gKP3lMA3hEalJJ/38MMl9t?=
 =?us-ascii?Q?ZIGVrivNvQIONpQso7Bad8ircZ68EOEMEbJx7NkqCKYB7DUNSTFgwjaT+zE3?=
 =?us-ascii?Q?HMVTo4KU0u3QNgHT/ufSnvaJ7aN/qC5sFsuq96Kj53gpsubM4i+mski/haKQ?=
 =?us-ascii?Q?L98abVDdX0fA2c6aTF4fme2rWwrNNuOMRZUDfp3xltq/+6U1O7N5wtpYGzkZ?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca325d12-f3b5-4864-e365-08dad96f42bb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 22:55:11.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANbahW3JqfcEFAeYNqMmauYsc9z+uyhfpy+I229Ta6qa6QabVM9dE36ozSQyzG+sc1nHmokdj0Bkjei+pejT5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_12,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=944 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080189
X-Proofpoint-GUID: b2iAiw9KxLEmz-nphlaTBPcaVFhxHP6R
X-Proofpoint-ORIG-GUID: b2iAiw9KxLEmz-nphlaTBPcaVFhxHP6R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 10:33, James Houghton wrote:
> On Wed, Nov 16, 2022 at 8:30 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Oct 21, 2022 at 04:36:17PM +0000, James Houghton wrote:
> > > This is how it should have been to begin with. It would be very bad if
> > > we actually set PageUptodate with a UFFDIO_CONTINUE, as UFFDIO_CONTINUE
> > > doesn't actually set/update the contents of the page, so we would be
> > > exposing a non-zeroed page to the user.
> > >
> > > The reason this change is being made now is because UFFDIO_CONTINUEs on
> > > subpages definitely shouldn't set this page flag on the head page.
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > ---
> > >  mm/hugetlb.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 1a7dc7b2e16c..650761cdd2f6 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -6097,7 +6097,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> > >        * preceding stores to the page contents become visible before
> > >        * the set_pte_at() write.
> > >        */
> > > -     __SetPageUptodate(page);
> > > +     if (!is_continue)
> > > +             __SetPageUptodate(page);
> > > +     else
> > > +             VM_WARN_ON_ONCE_PAGE(!PageUptodate(page), page);
> >
> > Yeah the old code looks wrong, I'm just wondering whether we can 100%
> > guarantee this for hugetlb.  E.g. for shmem that won't hold when we
> > uffd-continue on a not used page (e.g. by an over-sized fallocate()).
> >
> > Another safer approach is simply fail the ioctl if !uptodate, but if you're
> > certain then WARN_ON_ONCE sounds all good too.  At least I did have a quick
> > look on hugetlb fallocate() and pages will be uptodate immediately.
> 
> Failing the ioctl sounds better than only WARNing. I'll do that and
> drop the WARN_ON_ONCE for v1. Thanks!
> 

Sorry for the VERY late reply ...

After checking all the code paths, I do not think it is possible for a
!PageUptodate to be in the cache (target of continue).

ACK to failing the ioctl if not set, although I don't think it is possible
in current code.
-- 
Mike Kravetz
