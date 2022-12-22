Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175A2653A29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiLVAj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiLVAj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:39:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D90218AE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:39:24 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLMiYgB016809;
        Thu, 22 Dec 2022 00:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=rMjCV6a7di2UO5Fy+n8P0Wk89Qa1mY4zuOuh2Ri5+q4=;
 b=W/hSMHjaJTqbC104KRBggbtHsrtvu6CHZn0avJFB/1737KdiiEgZ4dJpJ4Aya/yWGmIv
 7KTtN7EURdWb4Kt0gFakLZn8SeyTWagilwyDkOn8LkPutqr13UrRZ4nSQ/xKqtGDLIcQ
 FrYBojODfilQ9VaDwJoRZRZnkJxm7QkVLrjjSTQlTs+ERjBWdLELyY41Zl1LZ+5QRkGt
 JuGveQqJBquwLvba4mT48Y4r68xQx3jxtnQ4q+/ndaC57VsRNimZ4m7yA0kmvKrFkurI
 oWapjlLaHrWDIzhmpApiHadzqyqQ55RKcLAa5QPCOk6C/AE/mPNry23IRLiFMvaeyBTE dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tna1gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 00:38:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BLM716K009621;
        Thu, 22 Dec 2022 00:38:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47dnvet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 00:38:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAQaGZjk5AF+ZPMnwJJ1LV15hj9ye+BUoH+WqKKlXqAt4fn4q2xJghRhBF6Kp9Efum6FipMfm5/+kibtw93seVrv9eWSsJULGpQUg/EN3zrvhDiASV2fUeZGCS4TXdtOzCxsPNurCQDqhYhCCdlmn8NQ2qMfE3QkJjMjxAc/1nHhqpBZ6twESPsE0gZzobaQ5vbvuFKps36mcSARHsFhHDMffPLA4sOZdRYesC4CoPRrl1wXfQFLD4vxOeORR1YQtddDkkgtVw0VryIxe2vpMaRq8fFwKJuIRm8vvGdQcGUP8I3ibgA5U/pdviNsTB2PvcNmxe0c1VQB4g+WXLgZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMjCV6a7di2UO5Fy+n8P0Wk89Qa1mY4zuOuh2Ri5+q4=;
 b=Bq6W+nNj7/tGcjgzNFPZOlSXBP8gxlLVhU2MJuES4qvM9Axt9TTiRcM9zQZOFz/2I4jKYZEKhYJuNJHvHzSU0du5RKWt5px/g/mkIlXMHvrT+RUO8nSjeQcj17jY4ba78Z6fSIua67hhCBDMoGetxnq4DWF3MHaQ/4YiMbckC0PnaQT1Hyk0dl1g3Qnvv4aOPwhcAZIG+icvA6egROvxjnayrPv6MbDPz8PwXrN0zlzjbsNCASd4uU5ciUaXUJTjwyts4X7Q5z8JYdaZ/Ib0v9+cQ7TdXIzd937Fau/uXEJ63U4grUf2w6/ef7bD6GxON8hcZlLjUeN3xWCwT4QRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMjCV6a7di2UO5Fy+n8P0Wk89Qa1mY4zuOuh2Ri5+q4=;
 b=mk1YkgmCkkuwjRvF35+ZMh4CpAJUdw4xU6q4QKwTxmlT7PpK59j6OsB9DGxF1nkGg7e8G+6yMjq3NvIL1bWhi64A2VXJaPyKSCF0wKhQK9wrfBi7gFh9qI9Br4jl1qPyz1qA4BgiqYJYzeddYgAquZyyF7OZEYfupRfQNbPSKmA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 00:38:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 00:38:24 +0000
Date:   Wed, 21 Dec 2022 16:38:21 -0800
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
Subject: Re: [RFC PATCH v2 33/47] userfaultfd: add
 UFFD_FEATURE_MINOR_HUGETLBFS_HGM
Message-ID: <Y6Om/dvlt1Wl2uZw@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-34-jthoughton@google.com>
 <Y3VkIdVKRuq+fO0N@x1n>
 <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com>
 <Y6NdN2ADVCcK70ym@x1n>
 <CADrL8HXqE3s4ckxh0OU5onkhystj=1jMTS+S7GFeiO+kwBo0QQ@mail.gmail.com>
 <Y6N9G0Y2j98V8Pnz@monkey>
 <Y6OEQB3dLSa083F6@x1n>
 <Y6OJUtVkvdptEgW7@monkey>
 <CADrL8HX997CguZWkH3vB4+cYjwLc0mYV4GkroE41bCLRqFiPpg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HX997CguZWkH3vB4+cYjwLc0mYV4GkroE41bCLRqFiPpg@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5a1e6e-286b-4774-31a8-08dae3b4d5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pP14tFNQeCZsu9ah4XLLgopb9p8WBAuB/cgtN2YPxsxeZBBznkQ4xwoUOY16B8qcJJZr9e8eINf8Ok005a21juhE8tgUC5sXEjH9UQeGoXXd+yZYyAKgcuHKNWbDe8KUBLhXq7MxHGtGz2ku9jBrsUojQtHuVhRXPt4qgYfPGkuCleZGLeqFwnw6c36hAT5zANX0AeJ77Wf/i6WC5yu0L/8hNlticfAd0/J0tEtJsE8c1xKZ+hkQR+GjgaHKIb+n1He6W/xSySyicUeQhXJKaXgk+X4tVezbLXg2/bzzHaiLpw4+T14BfYzxtKtJvDmflXqVv48KeLkPr/aezUS6R5Tt4cZ5YOMPgIkoOm2bXBE1UrooMo5+5Mmb1XaN+vYG0/EW+LPo8ydpVZC63XLiXWehadW48IZjVdy/WB+/BwjA7Q+69/G2My6BuPHc7rhxROyYIB/hygX0QRGQUSiIQAdYpmob7WeedS1iQUyWpDHE+beobp88FLLmQROm+6HoTrW+rDbjebEMbeaohkdZcuS9K4qzHt0s/wo9kM0Q2bNsmE8gSrTFlaj5bbSGcjWngdcVXKiQrBux/6MXowX4Gs55dxvcstU6vcjd3scqMbyw5llbEIPk9jiu0S6MpjNBiFpcgSnsUiVVTehH46ymwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(44832011)(54906003)(38100700002)(6916009)(6486002)(478600001)(7416002)(2906002)(316002)(8936002)(66556008)(5660300002)(86362001)(66946007)(66476007)(8676002)(4326008)(26005)(83380400001)(186003)(6666004)(6506007)(41300700001)(33716001)(53546011)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PNC9jkAIvBReUS1K7dYgL0MykO+RXiQkDb94TTSF5kpobFUuE2OP35JSciGS?=
 =?us-ascii?Q?ruMYVHPLhwR7L1vvbyNJn0T38jTHw8MGdJSb3m9e1puVCMUciHX7MGQMRZTn?=
 =?us-ascii?Q?32ZARGwdoxLjdvMC594q4copmbOJAbDnc4RNUvICOVdA/7W/JgynLYJq+P9Z?=
 =?us-ascii?Q?1z4NszzaFQqlchVQ8oShjd0+A1RVSc9pbAVGkxgVK8HZyW0mWQrIO8Y95hDN?=
 =?us-ascii?Q?DMo487uM8e4xBPicZzcveUbhhqJqynIcG1hF/uh2ufGn2LLE/jmIhCiZUasj?=
 =?us-ascii?Q?nMx5wqYwhYL+8CL88ZSDy/1sqQ/4bItjYf6nskIOrTfoaVjndTvvH5vQ3U5V?=
 =?us-ascii?Q?KXUfej7hEj/vRYN4eA1RKNVwoMyelpn0cGgrYAAk/uviLmMIVO6XKDoU/r5/?=
 =?us-ascii?Q?hAOoho9+qDa2+lHvWLXPzJZ0zmQZ9LAMtun30InPExvl5rF6yWx9Zhv//+g6?=
 =?us-ascii?Q?XbOEcurSmClJvz8l5ey5+GXveaJmvN0CMRMvGQdr81sOhFDHZ3UrcOkge+rU?=
 =?us-ascii?Q?7VWcmECZu83imCzJ0FRaXe8PNlKrYHPu1krUUgjm60NeIUlhg85qBFAMWyRL?=
 =?us-ascii?Q?2pckC7fa+9ivGPG+1sxkQB3U+v+lWVJcVhk2L6OdYl/DvMtysRe8a54jJID7?=
 =?us-ascii?Q?5QrNnxQVaGR4V3poDU7dBIIAdfDVqYjc5Bki8qk2gE+amVVF7/IVL7rXewon?=
 =?us-ascii?Q?WHDobPzOrd7u9AHn00qgUICe5mTAJQRRyvLYT0qL7u8uq1p4dIbZIs6VFXO8?=
 =?us-ascii?Q?1V0havlOq6Ud53x+jwhjhgDL9/7lo3fgXGeTzc0whqqfaB55B7pJtxbf/at/?=
 =?us-ascii?Q?yRPo7TliEGzkUOB7SYQ5piz6PJkMDiba3OO1Cc1s1StF5jMfepEXQCqLQFqb?=
 =?us-ascii?Q?vLvh9Njp43XjaWj8goKwtIpb2HJPJI9ZW9WJR9mD77zXAIUTAxgAXFLCVdnt?=
 =?us-ascii?Q?zvz+Kd6fp0OJEsy3eDSBRQ+2e0u3m6Ol26hl6nOPwX+n7p7TfUXOORNy0ev8?=
 =?us-ascii?Q?gejtKwwKQ12QIvz07wPcu5OZPMjSW3PWfm44PEmT5rm2Oks7oVIdMQBn0CLm?=
 =?us-ascii?Q?6TNalTL0Hg/sJW/1dFS0H1U+Gmp/ta9JE4WkbsEq9+YfL2755LvKFyXuHoyu?=
 =?us-ascii?Q?TNfu+yztEwQk+Gg+dnEP7FJqTaWGXonCjFu3B+mA/KqWNsS/H9V3ri0KsvzO?=
 =?us-ascii?Q?X//zRGj20h7fQm29uOKoBUpJyEyGvtkYvj8780069Y9Hw4V49HYAL/N5Xlf9?=
 =?us-ascii?Q?V/fXy2dDt6ByuNCMPK/1tscPK1X0+j4ukkI9qN4oz1z3EvEYHAOba9Ktr+XK?=
 =?us-ascii?Q?c48fkdCNpGUwIxY2zOjeeP99Y5Qp8Ll93Ovy+8Ark5Wfr8fGGUI3p6IBlOHy?=
 =?us-ascii?Q?whKy0StW1zLVcOoOD4nofejegxzDpL1gDr6JpW78seGLwZ4HTCh1Lj2alQA3?=
 =?us-ascii?Q?gbmSfhblXVc7Gl3lkM4FOc7g24HZGfT/gMRCwgmUNJ9OKxYLLS2a25Hk6lE3?=
 =?us-ascii?Q?6HPVTiaqpFIA60qMTHz3fTGsfhl//I5x7+J1cCC7cnuLAJs6Oh+ADCVJzA2G?=
 =?us-ascii?Q?jmKXKV6ksAd3sAhKS7cjLcL/0n2yrhMsfVwB5jMQjNTmfMKOja7jXhLmdf9A?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5a1e6e-286b-4774-31a8-08dae3b4d5b3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 00:38:24.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0i/oCn3rq8/I9r2nv29jvuTeZatYTTFAwGUM/6h4dzTj7Pm13tcdWeVwN3HOnL02CPeJwniQMDN6kFhs8IgnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_14,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220001
X-Proofpoint-ORIG-GUID: 7b4-eFqBpryC4Vq9SYgJhhwcfsdEgWiT
X-Proofpoint-GUID: 7b4-eFqBpryC4Vq9SYgJhhwcfsdEgWiT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/22 19:02, James Houghton wrote:
> On Wed, Dec 21, 2022 at 5:32 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 12/21/22 17:10, Peter Xu wrote:
> > > On Wed, Dec 21, 2022 at 01:39:39PM -0800, Mike Kravetz wrote:
> > > > On 12/21/22 15:21, James Houghton wrote:
> > > > > Thanks for bringing this up, Peter. I think the main reason was:
> > > > > having separate UFFD_FEATUREs clearly indicates to userspace what is
> > > > > and is not supported.
> > > >
> > > > IIRC, I think we wanted to initially limit the usage to the very
> > > > specific use case (live migration).  The idea is that we could then
> > > > expand usage as more use cases came to light.
> > > >
> > > > Another good thing is that userfaultfd has versioning built into the
> > > > API.  Thus a user can determine if HGM is enabled in their running
> > > > kernel.
> > >
> > > I don't worry much on this one, afaiu if we have any way to enable hgm then
> > > the user can just try enabling it on a test vma, just like when an app
> > > wants to detect whether a new madvise() is present on the current host OS.
> 
> That would be enough to test if HGM was merely present, but if
> specific features like 4K UFFDIO_CONTINUEs or 4K UFFDIO_WRITEPROTECTs
> were available. You could always check these by making a HugeTLB VMA
> and setting it up correctly for userfaultfd/etc., but that's a little
> messy.
> 
> > >
> > > Besides, I'm wondering whether something like /sys/kernel/vm/hugepages/hgm
> > > would work too.
> 
> I'm not opposed to this.
> 
> > >
> > > >
> > > > > For UFFDIO_WRITEPROTECT, a user could remap huge pages into smaller
> > > > > pages by issuing a high-granularity UFFDIO_WRITEPROTECT. That isn't
> > > > > allowed as of this patch series, but it could be allowed in the
> > > > > future. To add support in the same way as this series, we would add
> > > > > another feature, say UFFD_FEATURE_WP_HUGETLBFS_HGM. I agree that
> > > > > having to add another feature isn't great; is this what you're
> > > > > concerned about?
> > > > >
> > > > > Considering MADV_ENABLE_HUGETLB...
> > > > > 1. If a user provides this, then the contract becomes: "the kernel may
> > > > > allow UFFDIO_CONTINUE and UFFDIO_WRITEPROTECT for HugeTLB at
> > > > > high-granularities, provided the support exists", but it becomes
> > > > > unclear to userspace to know what's supported and what isn't.
> > > > > 2. We would then need to keep track if a user explicitly enabled it,
> > > > > or if it got enabled automatically in response to memory poison, for
> > > > > example. Not a big problem, just a complication. (Otherwise, if HGM
> > > > > got enabled for poison, suddenly userspace would be allowed to do
> > > > > things it wasn't allowed to do before.)
> > >
> > > We could alternatively have two flags for each vma: (a) hgm_advised and (b)
> > > hgm_enabled.  (a) always sets (b) but not vice versa.  We can limit poison
> > > to set (b) only.  For this patchset, it can be all about (a).
> 
> My thoughts exactly. :)
> 
> > >
> > > > > 3. This API makes sense for enabling HGM for something outside of
> > > > > userfaultfd, like MADV_DONTNEED.
> > > >
> > > > I think #3 is key here.  Once we start applying HGM to things outside
> > > > userfaultfd, then more thought will be required on APIs.  The API is
> > > > somewhat limited by design until the basic functionality is in place.
> > >
> > > Mike, could you elaborate what's the major concern of having hgm used
> > > outside uffd and live migration use cases?
> > >
> > > I feel like I miss something here.  I can understand we want to limit the
> > > usage only when the user specifies using hgm because we want to keep the
> > > old behavior intact.  However if we want another way to enable hgm it'll
> > > still need one knob anyway even outside uffd, and I thought that'll service
> > > the same purpose, or maybe not?
> >
> > I am not opposed to using hgm outside the use cases targeted by this series.
> >
> > It seems that when we were previously discussing the API we spent a bunch of
> > time going around in circles trying to get the API correct.  That is expected
> > as it is more difficult to take all users/uses/abuses of the API into account.
> >
> > Since the initial use case was fairly limited, it seemed like a good idea to
> > limit the API to userfaultfd.  In this way we could focus on the underlying
> > code/implementation and then expand as needed.  Of course, with an eye on
> > anything that may be a limiting factor in the future.
> >
> > I was not aware of the uffd-wp use case, and am more than happy to discuss
> > expanding the API.
> 
> So considering two API choices:
> 
> 1. What we have now: UFFD_FEATURE_MINOR_HUGETLBFS_HGM for
> UFFDIO_CONTINUE, and later UFFD_FEATURE_WP_HUGETLBFS_HGM for
> UFFDIO_WRITEPROTECT. For MADV_DONTNEED, we could just suddenly start
> allowing high-granularity choices (not sure if this is bad; we started
> allowing it for HugeTLB recently with no other API change, AFAIA).

I don't think we can just start allowing HGM for MADV_DONTNEED without
some type of user interaction/request.  Otherwise, a user that passes
in non-hugetlb page size requests may get unexpected results.  And, one
of the threads about MADV_DONTNEED points out a valid use cases where
the caller may not know the mapping is hugetlb or not and is likely to
pass in non-hugetlb page size requests.

> 2. MADV_ENABLE_HGM or something similar. The changes to
> UFFDIO_CONTINUE/UFFDIO_WRITEPROTECT/MADV_DONTNEED come automatically,
> provided they are implemented.
> 
> I don't mind one way or the other. Peter, I assume you prefer #2.
> Mike, what about you? If we decide on something other than #1, I'll
> make the change before sending v1 out.

Since I do not believe 1) is an option, MADV_ENABLE_HGM might be the way
to go.  Any thoughts about MADV_ENABLE_HGM?  I'm thinking:
- Make it have same restrictions as other madvise hugetlb calls,
  . addr must be huge page aligned
  . length is rounded down to a multiple of huge page size
- We split the vma as required
- Flags carrying HGM state reside in the hugetlb_shared_vma_data struct

-- 
Mike Kravetz
