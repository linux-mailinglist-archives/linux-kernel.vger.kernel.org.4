Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186FB6538AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiLUWcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbiLUWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:32:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A83109A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:32:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLMEAOv010673;
        Wed, 21 Dec 2022 22:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=d2shKQzn5gCqnXAYVpj3M5Yr9MJTOzrUP6NX+a5T4Oc=;
 b=Bikdq3kqJG1FJPwTPYfQ6GbLcOxnRq2EwlMF0ONZ7ONTUFkVBLFsn48UTcoqgwh31nYh
 fIMGo/HFq15p1vz2LjBfpHc3NfeAz0DvP+JmhwZdnIOr/f/XCNqB/ngvNy3ZqoKqYTD1
 HRETex7MrXVpYQkP33tTHjkZly80OSQCyvGVeaxiznIJxZ3T2eS25sG6BiH8P6DtYxTb
 kRnwUTdoTG9TPXUC3TSsCBGkUFAIXH3ufpcROvQjnI+0PCwgY7RA/ot8vHAaOIRYJn0G
 ygRHigQfkrFdUe7KQ/C4leDe0b3exov41Q6/8OHUxiS/4hNvhObOu+OdPB0ke2hW0bCh Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tr28j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 22:31:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BLLd1aV003437;
        Wed, 21 Dec 2022 22:31:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh4777syp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 22:31:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGMg3ZEVSkcUpU20N2m2xFXKn44fGWckwQ848huSqLUzeGaZWeo5855Zrfgop1XXgA7EQywPb5Ro6GI6g3AMf7PV2TA9ccYDs1hJd6rjU/A7ZfiM0+/dkL1shja9lmkEIKJaSJK2Im1a4KvesNbtjBRsElB0esQIwNPKuLpwC542Ev+sjsWSxfUaElm4gWp+lZF/SRm4Md1uNicetZWyQsN80LWZctsLw9kpIv93tMsLFI40G4/Iz63x14AQ0tlQ47zeAmvElyFocZ+vZ9zVGEQImMtjb4cppExMAoBkslm+aBqpVg6TV70qHcS1ZJT9EWlt5L7V2wq/j9bsDOdEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2shKQzn5gCqnXAYVpj3M5Yr9MJTOzrUP6NX+a5T4Oc=;
 b=HtDicXvWBdPCWSk3uO3n9MIKysfwJYki1fv1BBu4YnK63ng99mAdNrIDCFrPbjI127rQBs18I7QswvnMyiKp0HnMeNr9gDUuPqKsxZWIEy57nv9CHLm9mlzO9eqnnhNlirDMPq2FqVENvSOcykmqEzBb+URyju5TfnNhCDDyeJ28cFMmdTWiW3DZIr1AUbEaQ3ChrwbW0aLJta2NYu68CcyfXa0dL5F68D0vMVq4l51j4hj2UdetoQpVivQFlAohDtTuWg15pD16hKIXfQONcjDEZqPuXiOySuk7ZjWvBx4pEexBOyfMKZ1bApKryGb1UQsCmhV0MocuQdvYLeusYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2shKQzn5gCqnXAYVpj3M5Yr9MJTOzrUP6NX+a5T4Oc=;
 b=I6Q+COcHspo6fsn6JhLWa9W46gXdtx12aumehgUjHkNGUqhhvUj1wC/Hfi51GgZo2Mbgy0pEep8L15ax8esnbLxqSGSDjJoBuw2DBT3UaxRT0DhrpU8rn889QYMFR5KUfQCZu1wiYvAC+ch8vWEoclPfKdX2Pyqvw7GbszYdOT4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4831.namprd10.prod.outlook.com (2603:10b6:5:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 22:31:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 22:31:49 +0000
Date:   Wed, 21 Dec 2022 14:31:46 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
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
Message-ID: <Y6OJUtVkvdptEgW7@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-34-jthoughton@google.com>
 <Y3VkIdVKRuq+fO0N@x1n>
 <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com>
 <Y6NdN2ADVCcK70ym@x1n>
 <CADrL8HXqE3s4ckxh0OU5onkhystj=1jMTS+S7GFeiO+kwBo0QQ@mail.gmail.com>
 <Y6N9G0Y2j98V8Pnz@monkey>
 <Y6OEQB3dLSa083F6@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6OEQB3dLSa083F6@x1n>
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB4831:EE_
X-MS-Office365-Filtering-Correlation-Id: ca24a8cb-644a-4572-23d8-08dae3a326af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCVlgDnvAHenW/2x8gsQfGqgEE+Y77jqaaHx4AvGanmKboV9EEQ+OnttuUwvSPK5ITxe9EIUsONDYRNp6I7DHLRVWtuQi9umPC3vqWQbSfT/kCmNMRCWtjAf77aoIhexcKUWw3QtKZoYRDhd8qly7hr9zdKueTmJJ1VdzFne3Zja4YRNkt7p/5Bg38dmVHC/IiI5AET3kUg2Aq+oWTcbXHznbdDArdC8lmIPzRUNiobvLjGIXRpIrHtqsgFAChbvaAS+7k8EHIlZnIJjgAuUj5SgYrN/z04TXN9tm6TXxxGw7+q1GcR+HbJRr3nF3W3oY6f1usH59v4X1Yk82rzy0vP2bII+ux9Okm7TT5j/W/sDyHhFjpnnJpN602ce2Za/qNd8DfIUhMPxp1bq+dhuuuoYxirdzDyUxw8a6EjkEdVyYP4tw0g/WAG2KLpANnGzmD+D7KmWGleYPi05m+r6FRJdyVMEhCo3Uw1JKSLcU7fmqL8IEZwV2lLgROaiDcSqHZIL8K1XPU8S0rphVTSZxpC3Yvsz7G/MnuyZBc0wQKe7Iex6//DG+sTjftWebfTSC41T8YvPTSz38D+tYonpSD3RZyzY63xiDfGlmC+csj/szbL4tsk6jobPtwMc+GSIupHCDIEDObk28o5+ZvK7RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(8936002)(4326008)(5660300002)(86362001)(8676002)(2906002)(38100700002)(44832011)(66556008)(7416002)(478600001)(66946007)(66476007)(83380400001)(6916009)(316002)(6486002)(54906003)(26005)(33716001)(41300700001)(53546011)(6506007)(6666004)(9686003)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MoSakt5ksroQw2xbhkAuYExibXg1LeuxCyslAV1A/SCq6F1ABacT5nVCvy/e?=
 =?us-ascii?Q?DbxXjjgcw/+MC+aSTTdkKGqx+p3P89Ayu3bIdpZCbc1/6dp2E65MIYqwltA7?=
 =?us-ascii?Q?GXnvL9kp9DCibFYChkMUKZI1KxySx/Spja91ZgbnRjA/OuOv4S1SYLXRNici?=
 =?us-ascii?Q?n5WLolQCqy6nwXwCdv+kLx9VcQpAQnkckncvv/QsRySIljQOw7ITYYa7dKBj?=
 =?us-ascii?Q?4d+RFPbXsMhoLZKLKk7r83tDheFH+S/61VsgnpW7RFA5ZJC7ZZBb6D2K6bPE?=
 =?us-ascii?Q?rR7kIFj2VBiDLtcRby+L6HOHuBRuKLwT84EACbqyMoJQIBk4grfBZQRxgSLD?=
 =?us-ascii?Q?HqL+0UqDPeZgVOvgwkyTJ2mnaIlS8gFmemSZsd0X7IIzPkgvJgTBYmwC8jqS?=
 =?us-ascii?Q?jQ4tRjRgDqNDVCEoU/oMsDUENjybU339OHKtA7FkgTCe+j0sBd7TRvkRXk2/?=
 =?us-ascii?Q?Yw3R+sZ8LBGUe0W/pefNrw6g/TQuo8M8sp92ZF1yYGbqt8I1QLJIHPIRTmfL?=
 =?us-ascii?Q?sK8HuGEngy9ZoUBPe1S6Q8AfYfBVXCBg/wQCUtVefok+E2+DKaGsyx83Id2j?=
 =?us-ascii?Q?eyo7MOl8JfuhU2yGEAR7QWZmjCkqLiSKXmZvcQldk5dBbOv9qR7VaH/EVvIg?=
 =?us-ascii?Q?PXbY1r93cL21guwiOY8+qUjFL1dzXyGDNaH20VB8ufog6Y6CE7YJk4FMdbD2?=
 =?us-ascii?Q?WA2FcHc/QnkFchHq0kCWaTHDbl9RWG5fHZzzFdl4u6uGvDq03EfncIgwR7fs?=
 =?us-ascii?Q?UgnawhBXfzB/dLRZqj/PXm5a7jzTKYj9uKXZO2U/E/2wGnz6XRoBb+VtEH9d?=
 =?us-ascii?Q?ngL23+CgwHACi8hX7J5EdCYW4+5hYm+Gv+uj1D3CxQduG+FVAmivHAMfqQ9v?=
 =?us-ascii?Q?1E4vNQ1YhpB97RZkwsWp6/DIeEibuYdMHOKPEw7KnLQwHRrdrsFZaugZ/IyF?=
 =?us-ascii?Q?pW8upAd45bGA1UNfuVwKhXK6Pe/J5oebXcQKZ/U2MWupwMbJZhO/SMjtlaCx?=
 =?us-ascii?Q?POiYhMSduZy0Vsde6tusZwhRs5ELs/9Lvr+8b3mOoh25yzYB9vTJaE5MgHis?=
 =?us-ascii?Q?Ok9Lq87JANsjQUaEM6dz0HAnlPdlxg18IGuhJITlRQplmUV5rbCsilxER7GJ?=
 =?us-ascii?Q?gYfdh6q8GlKAPotq5HUfzABbyccr1a0GOndyepJEcWGNj+gIFLHu16TlyGAf?=
 =?us-ascii?Q?b+8kD9ItKyPWVlL6NQxSWh8OjhuJro7AcoFCFMcYOh0VnQjzdZxAO4dHQy+O?=
 =?us-ascii?Q?g76umbK7gyQGSaJmt03eghlnui87I1yQxMfBAztD5NqmdL4L4lDj+HYo3Bk7?=
 =?us-ascii?Q?0mvTeaSnxB8VrdauSRyuKX+weeZj2CFwQdw9B6+WkQK6+gg8L8uKGPu2rylX?=
 =?us-ascii?Q?gidQK2Yfe3tbRy6QZGGNXAh17HGN/q3K4lEDBlSohSQgxjfmRGLlX7gmsuok?=
 =?us-ascii?Q?U8l2a/EknJRIUVYcDCXKRRQ/gaddvTFLfOAv7QgUroj3tuHL0i4JJh3LmMJ4?=
 =?us-ascii?Q?3/o0MKC5ILDK7lORn7sotgey5StpPKF3Qiwh5gQQh+avQ9Uu2nDOlxWnXNpz?=
 =?us-ascii?Q?wXvfosqNCoPKznWDDiG8rdkQwNs05okL/X1nj1jVedVd9W3q6ebR23aXwO52?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca24a8cb-644a-4572-23d8-08dae3a326af
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 22:31:49.6407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4ZmrUfw4BnY9kRfWhoz4+DXzmcnVL9kfZUWmL+ApsbVYQodo1GK4yNdFKnfWlNBCgs+yZtxSPUfjJE+vnyCzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_12,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212210190
X-Proofpoint-GUID: Sj20h3gJeQwT7VjP4jejxf0iQZApooVt
X-Proofpoint-ORIG-GUID: Sj20h3gJeQwT7VjP4jejxf0iQZApooVt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/22 17:10, Peter Xu wrote:
> On Wed, Dec 21, 2022 at 01:39:39PM -0800, Mike Kravetz wrote:
> > On 12/21/22 15:21, James Houghton wrote:
> > > On Wed, Dec 21, 2022 at 2:23 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > James,
> > > >
> > > > On Wed, Nov 16, 2022 at 03:30:00PM -0800, James Houghton wrote:
> > > > > On Wed, Nov 16, 2022 at 2:28 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 21, 2022 at 04:36:49PM +0000, James Houghton wrote:
> > > > > > > Userspace must provide this new feature when it calls UFFDIO_API to
> > > > > > > enable HGM. Userspace can check if the feature exists in
> > > > > > > uffdio_api.features, and if it does not exist, the kernel does not
> > > > > > > support and therefore did not enable HGM.
> > > > > > >
> > > > > > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > > > >
> > > > > > It's still slightly a pity that this can only be enabled by an uffd context
> > > > > > plus a minor fault, so generic hugetlb users cannot directly leverage this.
> > > > >
> > > > > The idea here is that, for applications that can conceivably benefit
> > > > > from HGM, we have a mechanism for enabling it for that application. So
> > > > > this patch creates that mechanism for userfaultfd/UFFDIO_CONTINUE. I
> > > > > prefer this approach over something more general like MADV_ENABLE_HGM
> > > > > or something.
> > > >
> > > > Sorry to get back to this very late - I know this has been discussed since
> > > > the very early stage of the feature, but is there any reasoning behind?
> > > >
> > > > When I start to think seriously on applying this to process snapshot with
> > > > uffd-wp I found that the minor mode trick won't easily play - normally
> > > > that's a case where all the pages were there mapped huge, but when the app
> > > > wants UFFDIO_WRITEPROTECT it may want to remap the huge pages into smaller
> > > > pages, probably some size that the user can specify.  It'll be non-trivial
> > > > to enable HGM during that phase using MINOR mode because in that case the
> > > > pages are all mapped.
> > > >
> > > > For the long term, I am just still worried the current interface is still
> > > > not as flexible.
> > > 
> > > Thanks for bringing this up, Peter. I think the main reason was:
> > > having separate UFFD_FEATUREs clearly indicates to userspace what is
> > > and is not supported.
> > 
> > IIRC, I think we wanted to initially limit the usage to the very
> > specific use case (live migration).  The idea is that we could then
> > expand usage as more use cases came to light.
> > 
> > Another good thing is that userfaultfd has versioning built into the
> > API.  Thus a user can determine if HGM is enabled in their running
> > kernel.
> 
> I don't worry much on this one, afaiu if we have any way to enable hgm then
> the user can just try enabling it on a test vma, just like when an app
> wants to detect whether a new madvise() is present on the current host OS.
> 
> Besides, I'm wondering whether something like /sys/kernel/vm/hugepages/hgm
> would work too.
> 
> > 
> > > For UFFDIO_WRITEPROTECT, a user could remap huge pages into smaller
> > > pages by issuing a high-granularity UFFDIO_WRITEPROTECT. That isn't
> > > allowed as of this patch series, but it could be allowed in the
> > > future. To add support in the same way as this series, we would add
> > > another feature, say UFFD_FEATURE_WP_HUGETLBFS_HGM. I agree that
> > > having to add another feature isn't great; is this what you're
> > > concerned about?
> > > 
> > > Considering MADV_ENABLE_HUGETLB...
> > > 1. If a user provides this, then the contract becomes: "the kernel may
> > > allow UFFDIO_CONTINUE and UFFDIO_WRITEPROTECT for HugeTLB at
> > > high-granularities, provided the support exists", but it becomes
> > > unclear to userspace to know what's supported and what isn't.
> > > 2. We would then need to keep track if a user explicitly enabled it,
> > > or if it got enabled automatically in response to memory poison, for
> > > example. Not a big problem, just a complication. (Otherwise, if HGM
> > > got enabled for poison, suddenly userspace would be allowed to do
> > > things it wasn't allowed to do before.)
> 
> We could alternatively have two flags for each vma: (a) hgm_advised and (b)
> hgm_enabled.  (a) always sets (b) but not vice versa.  We can limit poison
> to set (b) only.  For this patchset, it can be all about (a).
> 
> > > 3. This API makes sense for enabling HGM for something outside of
> > > userfaultfd, like MADV_DONTNEED.
> > 
> > I think #3 is key here.  Once we start applying HGM to things outside
> > userfaultfd, then more thought will be required on APIs.  The API is
> > somewhat limited by design until the basic functionality is in place.
> 
> Mike, could you elaborate what's the major concern of having hgm used
> outside uffd and live migration use cases?
> 
> I feel like I miss something here.  I can understand we want to limit the
> usage only when the user specifies using hgm because we want to keep the
> old behavior intact.  However if we want another way to enable hgm it'll
> still need one knob anyway even outside uffd, and I thought that'll service
> the same purpose, or maybe not?

I am not opposed to using hgm outside the use cases targeted by this series.

It seems that when we were previously discussing the API we spent a bunch of
time going around in circles trying to get the API correct.  That is expected
as it is more difficult to take all users/uses/abuses of the API into account.

Since the initial use case was fairly limited, it seemed like a good idea to
limit the API to userfaultfd.  In this way we could focus on the underlying
code/implementation and then expand as needed.  Of course, with an eye on
anything that may be a limiting factor in the future.

I was not aware of the uffd-wp use case, and am more than happy to discuss
expanding the API.
-- 
Mike Kravetz
