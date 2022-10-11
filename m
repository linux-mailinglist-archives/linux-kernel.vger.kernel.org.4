Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB105FB83F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJKQ0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJKQZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:25:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67429AFCB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:25:56 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BF68nf002204
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:25:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=STlmxAiRwUjDwlCW80ZvzV//Niz28iyNzFsSosFY6J8=;
 b=gZU+7s3zk7IL3jXLtHg3L9gZeehpsNCAEdIR/e6S3nscv5pMXipeDf+mQlD7SHRiWtJW
 ctiJUSGv0giyPzcnX34qr5MhhndAlbj9M3N//ta3q0EuKSJ/ILyRUi+JfNKxL8ZSOlth
 lAWBf37Qi/8JHYj/j5sXsPXm9dsZL33bgeCdTUiPr4hbDDNwBMoXt7sWZwCUGm7xPK5e
 1ugExmTHxS0qI9CS4jhIiqLWTG7BDHE1dhubtiii3o8UE6PnaoCeJA/shu6zfRaNlyfX
 zs2aGr6frJLlGD+Y22T5Mn5ZQBJc1DKU4xSvqG8/94RvYI54kimu1Wk0UaIOhLL8nHUz IQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k50b0518w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2eZS0EQOqFrDdECm/9dLyoaUVXvdE6UFWxwT/3DkJAKncO0sTj0BOdwVIjGM91KlobESjofU9fbY+cYQfzsQuu5G7zc6PovzmdfNq0yPjVHVCYRLy1KdW5IrlykftcM30MLPeoFdnMfJGhU2hAhcszPOHNfwqio0PJi5PW6Ne5TvpedQ4c4GE3AHjjRgHKpjBu2i8CCZKhXFw1JBNuaHUxHXrIXxxuJj/uOjLdBv/Cl9lvqEeODsBdTriFucXuK843px7OVnwb8HC+WfqGzTaIDxPeEMX6ctkIRkviDnCX8H30CsHmedAwVSJjRFwxS+VwP9dy0CSmY3a5x+JhrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STlmxAiRwUjDwlCW80ZvzV//Niz28iyNzFsSosFY6J8=;
 b=UFK3kBba471tVrjGAShBDg+9JWXuxj/QCqZAu5UDEg/meP0+i/+N+bcdyBfmM46OTaRowTKdnzxEDGGxvCJr2RSwlXIJ0JudzXGySfRPtmXQFpDe8oAraOuuUBEQw5icRU/TgBEOzFv57nljrCZ8tAeW0BarDahJiiZxXnVS39jo0ghG1XzZzcy9bf1OE3ESLj0QM2Qpc3so+QggxZizu9ruF4Dso8wxQKi5wiBsEMT8zQwn7JS5QBEV12a5jTiAT25TZe6mR37OhSTr8ILrKMFm51ShHERMo6LF3/nOekoeRBbj4cc28jO1RFg5mlJLuzKkX0OmEAYfKy95vONU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW3PR15MB3851.namprd15.prod.outlook.com (2603:10b6:303:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 16:25:52 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%6]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 16:25:51 +0000
From:   Song Liu <songliubraving@meta.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Topic: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Index: AQHY2qb4/DleVypvfEGw7i865KJ5wq4H9+4AgAAKPACAABD6AIABU84A
Date:   Tue, 11 Oct 2022 16:25:51 +0000
Message-ID: <2B66E2E7-7D32-418C-9DFD-1E17180300B4@fb.com>
References: <20221007234315.2877365-1-song@kernel.org>
 <20221007234315.2877365-5-song@kernel.org>
 <af5c148fb3b9c56d1eb7e92b05db7c6c04bcfc3c.camel@intel.com>
 <B849A9FF-1054-4D5C-AEBD-72AED8B8F277@fb.com>
 <3842f1e7cfdde4f848e164872f62c0c1da654fec.camel@intel.com>
In-Reply-To: <3842f1e7cfdde4f848e164872f62c0c1da654fec.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW3PR15MB3851:EE_
x-ms-office365-filtering-correlation-id: 984e4771-106f-4feb-e8d8-08daaba543a6
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fRirmPFt4fm2NbMp2aCcILlL3+OlaCpxfldIUxZyRz/7pTen0T5wCXXpFbweKfcpaK655vUaDi6FgemydV0yFlFngtV0wLZDGdu5C9ak+KeElAk9zTHLqGYxFsluhMd9I1YZH6bDdVzGwEiKeqfPAth/duWJV8R448rkqzJ8rfTnGqnCEgkbI6FlSp/FRdRllDGC/wKlxlD2n6hZ6s0yJDJxqsM3HWgu3h+/LHeIFf0TVe6epEReX8vim5OYC6NSBK9qbkW04YFpGpzjSo8NR870zatMp8MX30XOtqhIJVG23yf91tYvR+UeQ4HL0BxJrcPkRUbK8ubgo3su6LehXqaBixQLbCLz5faGynRSEwpHimorgpcgWlUUnc+Dzf6AnHILDmpS2Yd9Jlnr132rRM+XzpxeyaQdau0B96SWNckTR+m2GHPFrZru7wJll1Nv635u8HL0zZ4Qwwe/dtrAXrwDwsEXNEJIUu/bwxzCHiv5gvEaKOVeEZgQF48st1M2QPDzM7L42kprOLIsN4lxIo9N04vLZKAZwFrdXWxE46AnqHqpwdNFQK1XrfZ25lf4NO+wrkFGeABcQQ+0kIQzAhARputbGuk7sYyR2tsOM/xOUG9d7DgTrLUafbUmjP+Mn7U7j4oqtIpNd9/7/jXW4MQMXGrOyom4QxO99gq3C/ZVwewxW+2o+O2VA/gKyin4xUVslmuX6EzoCwx9+VP525vwzH7zqK9bg4NZlFvCJoXCBiKtt6f3JvhfZ5rTugVeSeITk8MKXzXGjccUmR7BhViK88cXCc0/7mXWiE4Xzhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199015)(6506007)(186003)(2906002)(4001150100001)(53546011)(83380400001)(86362001)(6512007)(9686003)(38070700005)(316002)(478600001)(54906003)(6916009)(71200400001)(122000001)(6486002)(38100700002)(7416002)(8936002)(5660300002)(66446008)(91956017)(66946007)(66556008)(66476007)(64756008)(76116006)(41300700001)(8676002)(4326008)(33656002)(36756003)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hGGqGD0b+gwYEn4ph7cS7M7K3OwNP5oCh0I5NOGl2pYgJImrHDxHDoWLrqi2?=
 =?us-ascii?Q?RunQ1yj1SNG+4YltN+NtGQsaE4BsDG9Tk88EjvI9d9R4U8evObnKDwSEAXOc?=
 =?us-ascii?Q?/co4DoXiSkAMQfEqM1Z77XN7abBKLMCKZ+5Xo8fZef//VFJqsRRpQ2qRNo6G?=
 =?us-ascii?Q?JJkP/SO2Z+NDhF2fgsiVUoy9PJOah7u/iupMZMoRs1JTrRrWd77kwRwke3nj?=
 =?us-ascii?Q?Blg6V0f9aTuEW0qqRy3gj2Xidwc/fLU0biAO1ozKVKM0Vjw7pIdKuJTtd6Pl?=
 =?us-ascii?Q?8y/voNMAymzalViAXz1+0NPHVTx8oS0mbEc/E2pDQG2OOPJ7GVnicYdIC4B4?=
 =?us-ascii?Q?KXEoTgWbMH8BIZgSj+Sq46jLyJ1BxOFYYYzlvhekDYDQCzy7D3Sru3593aQl?=
 =?us-ascii?Q?ig05R9nmRABcgT76gVsaWHdnPllnC+qWMeohUipl9lPVulXJmD3ttqkNQDSy?=
 =?us-ascii?Q?6TKoEI4Y3n/brjGcoVLCRv9dS8Snz/61M7hm5792vVJgXnV65HzJC61OFxWT?=
 =?us-ascii?Q?wdMSph+/AwwWfvINapGKUSar4FGPdKl1DdGGPqE8rKIEz3O3pwktH7SjRxOr?=
 =?us-ascii?Q?uVYVjLfpRd/QrHnwpHHNqaEz5UE6XkJtaEWi1OsMr1RnMY2upE28BIpMDHAZ?=
 =?us-ascii?Q?QuwwQW4pIZ5tQe0If0DpRpIR19At4c1ll3xBt7UivT9ZwxnTAwRlHdPeBnJq?=
 =?us-ascii?Q?ntrpQDUu8dUDLU5/jE+yxzA6kU9a+YGEIrCoNrE8ODFy2Llqlr0KaqEf45nT?=
 =?us-ascii?Q?IiYP8NE3hCMbGQC4HC5CBNuy3dq/IT/pIdgBqSU+ld6F4COnClyBqw9fQXZR?=
 =?us-ascii?Q?zqfHdXgSfMAm74tDx03rcO+AjAmWjHD+wsSORRKRkHcuXniF4htSkippXa5I?=
 =?us-ascii?Q?B+3vLfsHjU/pbiAB8LQStsbpxiUUGlUJykYqWDBEcA4h5UiX1GIbHjPeixd/?=
 =?us-ascii?Q?x5D09egcSrdMqv4nU8AYT8XAFyz1+qhrxSf/xYEN/isW+RCblFFcqhqiHjVb?=
 =?us-ascii?Q?Z7giBjKuMaE+trnGTe8E/hCxipe+8XWfoBWpLWWWhXrzuj1PBOL5HdnoKbxC?=
 =?us-ascii?Q?lHvuosNpIAT/OtEaL9snr6/ys1zwpulqIK9Yjb4oEA6SeiOznMYWssH2m4ni?=
 =?us-ascii?Q?AnZNF3NfnCKsTpsIiFhMFmNtD43JBlfPWyoZtPyVQmqovgk4TqAtMPpH68dZ?=
 =?us-ascii?Q?nXEdIzeoK5twPj0u88zjz7CWsUJ1DDk5+TfUl9N1icKmkUDRtXD3fJw+H7pS?=
 =?us-ascii?Q?gwh9L2haFWlgrqOgXak7dln7HHTj9qB2XCMTrdXYj9d9xgJ/RevSMMZ6uZ+3?=
 =?us-ascii?Q?To2uIi6eH4RpzBGivVoPVZjOOVQ5LIP0KBoJtrGzDA1wshxep4DDvJqGddw5?=
 =?us-ascii?Q?taDj/8kPacPEYr1GMIUYfUVRNSf4MNUUh+3RtcjHF7V6ll59i6ahaaA3aIDr?=
 =?us-ascii?Q?aHb8WQlc3Lxz4OiS8rQMXHGH+S/JI5RRAGNI/N18a/VbFvwewrpNLE+Hi5mt?=
 =?us-ascii?Q?TWeQPi8QkOK3BpWSOCL5q4rREyxq0aOK2epb/4OuZcq4PrVeAYL2FHj4gfF1?=
 =?us-ascii?Q?GIcntLg2earf4nfoZuxow6P4vNakiAaQLFxg+7B6iLfytFM8FhT3ctXqOrcu?=
 =?us-ascii?Q?HuvSECV27IMQD5GAFPRjGTaK1FZlMYbFilXuMdneiPCL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84D92B0659FF3F488AC6AF11743F5F38@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984e4771-106f-4feb-e8d8-08daaba543a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 16:25:51.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkoVzL5ExmHs2Ty9z1nBvNHa/veZswaSzQyUSUXa+kyfR1RuLGWUjOY9pKqf4x7DkgcJlc07LzGDsy3NnngLzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3851
X-Proofpoint-GUID: M4mLsmk6L6fthHGAUKkbc8nPoOLSNAwh
X-Proofpoint-ORIG-GUID: M4mLsmk6L6fthHGAUKkbc8nPoOLSNAwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 10, 2022, at 1:09 PM, Edgecombe, Rick P <rick.p.edgecombe@intel.com> wrote:
> 
> On Mon, 2022-10-10 at 19:08 +0000, Song Liu wrote:
>>> On Oct 10, 2022, at 11:32 AM, Edgecombe, Rick P <
>>> rick.p.edgecombe@intel.com> wrote:
>>> 
>>> On Fri, 2022-10-07 at 16:43 -0700, Song Liu wrote:
>>>> On x86 kernel, we allocate 2MB pages for kernel text up to
>>>> round_down(_etext, 2MB). Therefore, some of the kernel text is
>>>> still
>>>> on 4kB pages. With vmalloc_exec, we can allocate 2MB pages up to
>>>> round_up(_etext, 2MB), and use the rest of the page for modules
>>>> and
>>>> BPF programs.
>>>> 
>>>> Here is an example:
>>>> 
>>>> [root@eth50-1 ~]# grep _etext /proc/kallsyms
>>>> ffffffff82202a08 T _etext
>>>> 
>>>> [root@eth50-1 ~]# grep bpf_prog_ /proc/kallsyms  | tail -n 3
>>>> ffffffff8220f920 t
>>>> bpf_prog_cc61a5364ac11d93_handle__sched_wakeup       [bpf]
>>>> ffffffff8220fa28 t
>>>> bpf_prog_cc61a5364ac11d93_handle__sched_wakeup_new   [bpf]
>>>> ffffffff8220fad4 t
>>>> bpf_prog_3bf73fa16f5e3d92_handle__sched_switch       [bpf]
>>>> 
>>>> [root@eth50-1 ~]#  grep 0xffffffff82200000
>>>> /sys/kernel/debug/page_tables/kernel
>>>> 0xffffffff82200000-
>>>> 0xffffffff82400000     2M     ro   PSE         x  pmd
>>>> 
>>>> [root@eth50-1 ~]# grep xfs_flush_inodes /proc/kallsyms
>>>> ffffffff822ba910 t xfs_flush_inodes_worker      [xfs]
>>>> ffffffff822bc580 t xfs_flush_inodes     [xfs]
>>>> 
>>>> ffffffff82200000-ffffffff82400000 is a 2MB page, serving kernel
>>>> text,
>>>> xfs
>>>> module, and bpf programs.
>>> 
>>> Can this memory range be freed as part of a vfree_exec() call then?
>>> Does vmalloc actually try to unmap it? If so, it could get
>>> complicated
>>> with PTI.
>>> 
>>> It probably should be a special case that never gets fully freed.
>> 
>> Right, this is never freed. 
> 
> Can we get a comment somewhere highlighting how this is avoided?

vfree_exec() only frees the range when we get PMD aligned range >=
PMD_SIZE. Since this range is smaller than PMD_SIZe, it is never
freed. I will add a comment for this in the never version. 
 
> 
> Maybe this is just me missing some vmalloc understanding, but this
> pointer to an all zero vm_struct seems weird too. Are there other vmap
> allocations like this? Which vmap APIs work with this and which don't?

There are two vmap trees at the moment: free_area_ tree and 
vmap_area_ tree. free_area_ tree uses vmap->subtree_max_size, while 
vmap_area_ tree contains vmap backed by vm_struct, and thus uses 
vmap->vm. 

This set add a new tree, free_text_area_. This tree is different to 
the other two, as it uses subtree_max_size, and it is also backed 
by vm_struct. To handle this requirement without growing vmap_struct,
we introduced all_text_vm to store the vm_struct for free_text_area_
tree. 

free_text_area_ tree is different to vmap_area_ tree. Each vmap in
vmap_area_ tree has its own vm_struct (1 to 1 mapping), while 
multiple vmap in free_text_area_ tree map to a single vm_struct.

Also, free_text_area_ handles granularity < PAGE_SIZE; while the
other two trees only work with PAGE_SIZE aligned memory. 

Does this answer your questions? 

> 
>> 
>>> 
>>>> 
>>>> Signed-off-by: Song Liu <song@kernel.org>
>>>> ---
>>>> arch/x86/mm/init_64.c |  3 ++-
>>>> mm/vmalloc.c          | 24 ++++++++++++++++++++++++
>>>> 2 files changed, 26 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>>>> index 0fe690ebc269..d94f196c541a 100644
>>>> --- a/arch/x86/mm/init_64.c
>>>> +++ b/arch/x86/mm/init_64.c
>>>> @@ -1367,12 +1367,13 @@ int __init
>>>> deferred_page_init_max_threads(const struct cpumask
>>>> *node_cpumask)
>>>> 
>>>> int kernel_set_to_readonly;
>>>> 
>>>> +#define PMD_ALIGN(x)        (((unsigned long)(x) + (PMD_SIZE -
>>>> 1)) &
>>>> PMD_MASK)
>>>> void mark_rodata_ro(void)
>>>> {
>>>>      unsigned long start = PFN_ALIGN(_text);
>>>>      unsigned long rodata_start = PFN_ALIGN(__start_rodata);
>>>>      unsigned long end = (unsigned
>>>> long)__end_rodata_hpage_align;
>>>> -    unsigned long text_end = PFN_ALIGN(_etext);
>>>> +    unsigned long text_end = PMD_ALIGN(_etext);
>>> 
>>> This should probably have more logic and adjustments. If etext is
>>> PMD
>>> aligned, some of the stuff outside the diff won't do anything.
>> 
>> Hmm.. I don't quite follow this comment. If the etext is PMD
>> aligned, 
>> we can still use vmalloc_exec to allocate memory. So it shouldn't 
>> matter, no?
> 
> Maybe this doesn't matter since PMD alignment must happen naturally
> sometimes. I was just noticing the attempts to operate on this region
> between etext and start_rodata (free_init_pages(), etc). If this was
> never not PMD aligned they could be dropped. But if you are going to
> adjust the behavior for !CONFIG_MODULES, etc, then it is still needed.

I guess we can add special handling for !CONFIG_MODULES && !CONFIG_BPF
&& !CONFIG_FTRACE cases, where we will not allocate this memory. 

Thanks,
Song

