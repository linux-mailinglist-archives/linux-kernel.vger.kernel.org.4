Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1ED64BC49
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiLMSpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiLMSpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:45:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DCC24F37
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:45:29 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDIiDAc023910;
        Tue, 13 Dec 2022 18:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=4rkdbN1hMpjfUF7AwauG6t7PcmZbghl8YoTgvwTZeBY=;
 b=Q5TOqdshyeRXPhzgH8BbX5bQTqGqYncqAe6hHl+D48lbLDy+54YpSIhG0BIZdIIwPUJA
 /BAOklZgv1oku4Ys9yTU1A0WVqD2iegmOY1SzDw9pl7BkJnAQJ7YI9SiGtkc4v4Fri8i
 fTvF+vgoIk0QAzsXn3cJafvXv4713GvmLkoB7l70lw40JzPRGPvPLyHQ0DGiRjw00TCo
 nxGeARBgZdhCqccTgPahXb1l4uuwM75eL+yWIKhRqGirv+YstemyqY8xGvtGO94fsXBl
 f1j6Kygx2cI8H/py0raqNZyDHt4PlVTGTKjSLEn9ob5KZ4BBjy6SukhY1nhd7Z+ptUs1 VA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mch1a687b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 18:44:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDI9iiF011711;
        Tue, 13 Dec 2022 18:44:58 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj68tmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 18:44:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+yjhwPor+AiyRVgqtQz5oBN0X/GRxjQckwzwXV2b9uZlFo+SJEiHvpfpAfndMSEr9X09emBIQBnJtujussWcPKvP7MFmzVklzKLSE7zErj9RfAtnJFhYMNSEQWIKXB43MARKLn2N5rJFFE5HlQ5BsSEhljQ2neAR1yLjuT0+QEu8wahIZ1smWeqb5F8Pp2ig8gSp+M67vZtOUQklgTVyE9n/e6l2zPl3f9AmOiGDKHdsx1qnrE1OlrRNk501o1G0kW3Xr0wJVt3/sVXTBhH3uE/A5k9tZ8LcvHu9XrchNd/+85Spr+BmyZPGGRop6m2uShaUBQy0vwjxP7aLkTO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rkdbN1hMpjfUF7AwauG6t7PcmZbghl8YoTgvwTZeBY=;
 b=GhT7R9kwvYlojr97RXYqs8yypqyc5C8xM0Vw914cRStKgssXKt0LPQitUDzRCj3Y3VDq7g/OZgJBZTZ8QY7qaiMBpQfrUcBVag0WqdVEdO2X8GmJj/BEm6U2l+DY+nuN6JPBkG3pa/7Xc3unm22eMJdtfL1n8diuEJwlZQUGwuefZrxT4FlqSMvtguz2R3WBLoAwMPMk0KJYVRLnVLHZbUSSAGjsf4/tIDSFUl0MchmGTnyzy44F34Zy173FQGjXGPcQ626MmMVFwgsrgs7J+d4/gTNe9nyY/hPhvDQVuHXxV7+he+4v79XE/8fmy71lOjGEtgoessQkVhAMhFDYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rkdbN1hMpjfUF7AwauG6t7PcmZbghl8YoTgvwTZeBY=;
 b=cwXeYpR1SdSRwQ+TiS3pJmMYF7QVwy8BE+jrqLPqBpSVwgYwkSVv9MMgjM1d16A3A57W/lNz6Zwux3tYvFuyTv/l9rB3nOkTMyCqqyQMXYU2AdrW9ka3VhEnOwqMZL4ZHHFwwa4ukiOJKXCS0YIN4fP7UmlISxlXYj3zSUd79zs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4491.namprd10.prod.outlook.com (2603:10b6:806:f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 18:44:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 18:44:55 +0000
Date:   Tue, 13 Dec 2022 10:44:52 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
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
Subject: Re: [RFC PATCH v2 10/47] hugetlb: add hugetlb_pte to track HugeTLB
 page table entries
Message-ID: <Y5jIJEuDicz/LDwF@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-11-jthoughton@google.com>
 <CAHS8izPYvrviLbtVNkg+bnSXt5zvaXfJJV9+CAZ_0qESyMimBw@mail.gmail.com>
 <CADrL8HXiNHw2MdgCWmi1JpK=dckJ=D-5-Wm5Ofv0L6Uh7nvqRg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HXiNHw2MdgCWmi1JpK=dckJ=D-5-Wm5Ofv0L6Uh7nvqRg@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 5611d505-8163-4529-9aa3-08dadd3a20b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QZ23hhzjeI1wfE8XjDHYcBN3MoYv5eWej14Izyg2eDFUqX7tHS10F88QP4FxBm+8f7OwBU3gN136Blz0tDmEO/HgF0f5syIUCWg/X8m4YPuPbTT6XJuVSmhp9EEFNOdHjp77pfkLPlXUarjPrJDkxIY+g9i0cKTiXOu+nXKOzU1ohZm0nxC8etCVEHjUUFH4qn1d5kizGQyLcelVSPlqgqJ31CWvN1LPS3S+eWcJr5YiBtiR8UZVJ8mhswqDIObeBqH0CdzjkL18KZoL1CNLYCFkSHFJz1dR9BjMVoFySvb/l2kEfYrafk3ZtTnCyFEb8SE5TJC33OjfJ8hxTaKcfwvOHPFuCQZXM6pXJuY6l6Vd3gyib/Cmy5ZYGJ9ZZTceeiPWoUPYG1BwSNHDNNyWc6Prh4niKRDANEvFWfXbMt9Dqx21+LEaeHaQDzRKJQTTMpskAMr2Zeyxt9RBhtCBlnMmRrmygzgTP7jmiGAEU+XnhjxCmIdaE/pG9TX9IGfs9k+hNousNz8fpGaRaJWnPs3fofPMv4Y2QPx4/O1SjU10c7w2GCPwZcQJ16wTJhO0gc2gMeFDtkKGE6Fz3XylXVJFCs+GY/Bx1r8HYPpJ+DdhwXFZWoI3g/vTItoOVhy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199015)(86362001)(478600001)(53546011)(26005)(6486002)(8936002)(66556008)(6512007)(6666004)(9686003)(6506007)(66476007)(5660300002)(4326008)(2906002)(7416002)(66946007)(8676002)(44832011)(316002)(54906003)(6916009)(38100700002)(186003)(41300700001)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IoAQpJHhg6pXV6ZGIXhlBq2mw6JOLhv+mRXHC0PXIDZP1YE6g+75cLa0OREg?=
 =?us-ascii?Q?mOmPH7Pw6GiUzxM/fPnXZizNic/v/Dh42IMR/41IkuagQ59cLjlELbCYIWap?=
 =?us-ascii?Q?xo4yaI2Wkdlf5QSlQdOi9y+WHYRjoCQCwr9lAOykts9e2w3CQWt7dskQJs21?=
 =?us-ascii?Q?3FrqpY4dwYG2i3wAjdnRrQM8RJ9CvUcAxgRfw/zy8QXBahoa9PQ38riiMPV3?=
 =?us-ascii?Q?5SctH51LDKuBa5IUaxMWNoPhJRRvvia5glcsNnImXNie5qNnhLsqg6H3hbez?=
 =?us-ascii?Q?cUj0DGjki9/DEkXzeV2BbxQFxP2i522XVMDns3x67meIo17b+aFl5OfbyFJb?=
 =?us-ascii?Q?bT3RO7B7DdCmvLm2Dx6UsVsPpHE4SX+rFJTW0U8hAN/WvyZOLGwoNIwUTrx/?=
 =?us-ascii?Q?nkH05kSxbLbV1wB1Ttj/EYPr2ScIuvybM4KKp6vdMs7ZL8/6+IOdB8sucBD6?=
 =?us-ascii?Q?xlRPcTNPZK/MExnmEelEqQp8KDQMppyyDJelpPn6qjgd6tnS4mpggWmYWuQJ?=
 =?us-ascii?Q?eEmsOnqBwKvCOX9/PKlEQ9BlL58h6cv+bLeBHVEYVMTdpRYP/vegxWQa2SDJ?=
 =?us-ascii?Q?CLyP+aHKIO7M5/rBhdfBX4NFcnC0ql+ivseJxAA2L1CyLMg5RSE6qw7GDSju?=
 =?us-ascii?Q?oimuqBR2WfHy7IRnYjM+uTkE6lm0QcORPpJYANdGixJgfVLA8HNlJlbqxMyI?=
 =?us-ascii?Q?P25wr/wAErzELdPU1JtG/c5ECE3xE09R6CrmiVqHAfpLGB7schxlq2G/06Qc?=
 =?us-ascii?Q?uu63hcUX7VIqXZqMiBkhmaZAFfjVAsLPsrW0GbeZNMSqrvb2N2aug9H67zXa?=
 =?us-ascii?Q?U6zndnSzh9+G0wRg9miN7BThX/pclK32ZkCcFW5pJavo+tOlNKQmnGT/VUpE?=
 =?us-ascii?Q?/3Xd7jrMDdWvieyWCbBgKh33NtnCkTqm0EhWbpHCtndhBiYg/xBw7kvoKF7s?=
 =?us-ascii?Q?QpxSRR48TQ7weZV2uT/25ElwxnYgee5pFyjo5lH5SlmA2GncCgYlOxzfPhzN?=
 =?us-ascii?Q?THWw06KIIaR3/+WjYXs3h1Wg9Y9roBbHWjaq43v7gkwbUJSju928hELQMB3U?=
 =?us-ascii?Q?oIYtJ12dCSKzbAGvZj4r1kxzO/vixDEwtdbdWs4gS+fNrNdvmdHsgO9tiH2Z?=
 =?us-ascii?Q?c7lJ9K0ChpCb8xAtwauH8lKYXQ36UNTRDwvTGix7RROvOkevKBVDielXxQ9s?=
 =?us-ascii?Q?xVwsGVvreVxAa1vWkXzG0O2sjDu1inEBvAKGBcaWxdN7mtpTqCRCIymOMeV2?=
 =?us-ascii?Q?ZA34CQ3elN6pd6n2eKvF3dPZhD0KGz0ghhdWaqGMS9Rj+fyFf4C7eaQ1YEB/?=
 =?us-ascii?Q?2MNhMZ/frkZ+hpjbB6JWK58gDWDYrZZnYftDeDWEQ7YfXV3KHAOzana34SwC?=
 =?us-ascii?Q?udoaG2E2QeWJTFzWmkeDUqXr2/vOAtljhkqp5GbAtsKropdrmXKxGSEfT8MC?=
 =?us-ascii?Q?cB2+GBaJ7Y+ohdmM2u9XEBs/7DIUkcPs1vIURosSRX9G1x7GTL7DY+piiKvr?=
 =?us-ascii?Q?hQzEQQT3VxadgoirQNsL/5gz48Ce7Plopz9Cs266jFJj189lyMrgt+H6Gi2P?=
 =?us-ascii?Q?3Ms6EfwlwlCS0LyuqlOxS2BO8ZALSpGQXqaJ1Nd2/f9uXw93MaW3388T/kxo?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5611d505-8163-4529-9aa3-08dadd3a20b2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 18:44:55.4951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XFJbi8rs8ZtHdc8jFajZBV8QTYn33zNA7pwzX8FkGmP1pWYKh6qLeIePeyfQVolnqAtKg06YfGc+VLtJ/kB3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130164
X-Proofpoint-GUID: oJN3b6WnlOECBzx-IzPG9803g7sYeEns
X-Proofpoint-ORIG-GUID: oJN3b6WnlOECBzx-IzPG9803g7sYeEns
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/22 11:02, James Houghton wrote:
> On Wed, Dec 7, 2022 at 7:46 PM Mina Almasry <almasrymina@google.com> wrote:
> > On Fri, Oct 21, 2022 at 9:37 AM James Houghton <jthoughton@google.com> wrote:
> > >
> > > +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte)
> >
> > I also don't know if this is obvious to other readers, but I'm quite
> > confused that we pass both hugetlb_pte and pte_t here, especially when
> > hpte has a pte_t inside of it. Maybe a comment would help.
> 
> It's possible for the value of the pte to change if we haven't locked
> the PTL; we only store a pte_t* in hugetlb_pte, not the value itself.

I had comments similar to Mina and Peter on other parts of this patch.  Calling
this without some type of locking is 'interesting'.  I have not yet looked at
callers (without locking), but I assume such callers can handle stale results.

> Thinking about this... we *do* store `shift` which technically depends
> on the value of the PTE. If the PTE is pte_none, the true `shift` of
> the PTE is ambiguous, and so we just provide what the user asked for.
> That could lead to a scenario where UFFDIO_CONTINUE(some 4K page) then
> UFFDIO_CONTINUE(CONT_PTE_SIZE range around that page) can both succeed
> because we merely check if the *first* PTE in the contiguous bunch is
> none/has changed.

Right, Yuck!

> 
> So, in the case of a contiguous PTE where we *think* we're overwriting
> a bunch of none PTEs, we need to check that each PTE we're overwriting
> is still none while holding the PTL. That means that the PTL we use
> for cont PTEs and non-cont PTEs of the same level must be the same.
> 
> So for the next version, I'll:
> - add some requirement that contiguous and non-contiguous PTEs on the
> same level must use the same PTL
> - think up some kind of API like all_contig_ptes_none(), but it only
> really applies for arm64, so I think actually putting it in can wait.
> I'll at least put a comment in hugetlb_mcopy_atomic_pte and
> hugetlb_no_page (near the final huge_pte_none() and pte_same()
> checks).
> 
-- 
Mike Kravetz
