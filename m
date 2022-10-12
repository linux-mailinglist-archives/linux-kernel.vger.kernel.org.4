Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDFC5FC027
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 07:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJLFhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 01:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLFht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 01:37:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83A1A3F7D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 22:37:48 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C5VLgm008408
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 22:37:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=NdvGKWGngl6rSCf5qKsCtMx6nVWpFudwQfbOQ9fkbnQ=;
 b=fFEiCt7ecLXGFxKhFjy47mzkj+xsfmcxbllOXjwvXaG8fGbjyK1tpP35y6+tLot0bg90
 6B6q2YlW8+Kj8CuVwAdiJjeHVwtft1XBu+PORjIOg75BIDRC8uiweMfROrkFHNBuIEFu
 93Bt7Vb10PuRXGO5/qqiWkciOiV8dBD04BXU7Sokg7x7pybKyeIEZhG0M66mCWE8AepC
 1Iicr/xHyrJvY1Xlbtp22sFW92IZ2rxcY4bgSC1RIhk/A9ex0arYyCniOKa0ePGB0Vxr
 yixPR1kULyqtB2UR1Bjcvw+09jBRl3xaMXBSth58JYvzQx+RB/TcJHOun4mg0VV+5bZ9 tw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k5qgr022a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 22:37:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSqNXph6BR8LapqIQc4ZkaoW3DlcS2A+sZmspmMSEQHhFrI341o0xiJJPgfz8Wtux+Aq9BL9HrddBe5lvieh7VsACVfjDj8wtFYchRW1L3qdp5d0u73HqXfD54Lrm8tPJJeDVOy22oU7DFtDekQur9IegPcVthyjCgRYFo3elgkrByCRwHMqiBsGr/eg1g+x1kNhWlQE2MevqRbWbAhKCRk8cIbpt4UIGMfOm3bwQBL5+doh53HNn2hwsjVSdtSJTQg0oG2NBOezDJXXF9S5d6iWzOrAoq5iqu2aDVvWdYe4uekfWM5N9YlAkUwWtWONT2lCbTegwVGyX2/PrCi1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdvGKWGngl6rSCf5qKsCtMx6nVWpFudwQfbOQ9fkbnQ=;
 b=I6+ZgCYx+rokRQpiBvD7f4SvHaTnCdqsRXDxUEok1+RFxqF5hQ4DV1+ZnysbkR+R51f0C4cyFpjGmY0uLMkcCC53AZ6aJ6/JlCHKkMUwdp1202+T2ecc7aPkSXCkUQisNJ3EaslusOEjjjfc7+BKfD0ZbPP43Jcv0PTVsA8qQbPZXoKbSptngzY07CvGZw1mtwNMCCq/eeC29w4qQlEa7SyongcZ3umIDRXw5cAG5t5Vw64RreEa/yvMkNb5BtQs/zHZz9Q0Qv1JY8I8ozEqL9IJgwEWQBuCsAxcxOWd1IjA3bxoQhtHRcMhtXNTRAtH6+tCZA0/SXprjlwAqLVQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB4711.namprd15.prod.outlook.com (2603:10b6:a03:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 05:37:44 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%6]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 05:37:44 +0000
From:   Song Liu <songliubraving@meta.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     Song Liu <songliubraving@meta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHY2qb4/DleVypvfEGw7i865KJ5wq4H9+4AgAAKPACAABD6AIABU84AgABHRYCAAJX7gA==
Date:   Wed, 12 Oct 2022 05:37:43 +0000
Message-ID: <0D4668C5-28C1-4846-9698-C5C05BC23F0B@fb.com>
References: <20221007234315.2877365-1-song@kernel.org>
 <20221007234315.2877365-5-song@kernel.org>
 <af5c148fb3b9c56d1eb7e92b05db7c6c04bcfc3c.camel@intel.com>
 <B849A9FF-1054-4D5C-AEBD-72AED8B8F277@fb.com>
 <3842f1e7cfdde4f848e164872f62c0c1da654fec.camel@intel.com>
 <2B66E2E7-7D32-418C-9DFD-1E17180300B4@fb.com>
 <99201f0c3509e1ea3d08a462beaaea9d60382cff.camel@intel.com>
In-Reply-To: <99201f0c3509e1ea3d08a462beaaea9d60382cff.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ0PR15MB4711:EE_
x-ms-office365-filtering-correlation-id: 4b1de4f2-35df-4579-c9be-08daac13e313
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1l9XEtB2TSb6rlnrzSqDe/aSR5a3/XGOkMzzmcQhObM+pSPh2sGPb9B+lJDTJjmZMNF3yopT8mH4QZK2qaQd99v9PjgknIq6pwIviWsSBA2v99Iei3RooxFk+RBm6Vt83osLFOJGhFr+TutEuPh9E9M4Z++aTQggOEWkHZ7OKCPTl42Spf2iS+zPGrpPebvPfTwH50gkjU4qR77kRyCq2xCSWWGJrmXcys5w6KNdtqwVkHRO+XS8r4q54vxmhF3F/M0n9Cut8egY094PZdGXbWkuekJNy0FVdl4S/ca3azpdSd0bc7w1zvOsjWwGdpptfCT+xUeJN/iRQVkaEyXRNX7Cy5eD5SnkXrwe3tvKjDIXpSpMvbCo6ewjSym3Jk72YapaEC+dehE95vdu6OVDQCtR5sfaOaFIxio92fu3VN4BKfon7MW4ZpwmDJaEgMzdPOnnmgqViMDq/DAaMpfVKYdi5sEfesejVpMmVgJnuYhnShJDWg/Fl/y5Tqt0sFWNizJ6h6XZ7UkRfboufmIqA/R6LyKi5/QRW7Wsiqd/MyrQ28wSNHczKb7EIL0unuen1YNSJv8D0hZdY24BOzqP43S/j3+ySuax0MGh120J9amK+H5lCYJrblLcWGPY0l0Kz6hC5v2AFWc045wBbeVcS0X5FBVWqaoa6RwJ3b4v1sLC+Q7We6nzfqI9VwRjaYy6DNrOeSTYV4DfiyC/4SHB9gMRrrUZi7dDrNz6wtY7E+GcXfm1Eq2vUPVAKQZ+QtJUBd62ETZsAZLxjMqEsz3IfjblrSLgpPIvEsSJK0USflI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(83380400001)(478600001)(186003)(6486002)(53546011)(86362001)(6506007)(66446008)(6512007)(9686003)(54906003)(4001150100001)(71200400001)(6916009)(66946007)(36756003)(8676002)(38100700002)(91956017)(4326008)(38070700005)(76116006)(64756008)(66476007)(66556008)(2906002)(316002)(7416002)(122000001)(8936002)(41300700001)(33656002)(5660300002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iWVj+166mfCScUvQWkLmgmqapHuVGikWFFaM/vgC80uYVDqi5Yph2wXT2a67?=
 =?us-ascii?Q?AJuiUnjCZI+b1GTlb06bp3TZZa9J1cb0UEM302+bdjMGKASRE8Zl3eU/8bIS?=
 =?us-ascii?Q?2Exg5UYexfjO4cG4Jt4ZCR20VOEjyHH1/p3VcTLyItdvjk/FLxqlBPQjqhMV?=
 =?us-ascii?Q?hIqZHUhP91aUM3M1InBoeMtDCZ+RbipQtiBcRfjGtOH+eJA0HtU5enwKtP4e?=
 =?us-ascii?Q?RdJK1YVWOTQD7Io/3t+bKgJlB+il+JdttCA6br6AlMCKY70MAvWUTRnjmiwv?=
 =?us-ascii?Q?SI9DmikwSDCQplfxRx/P31dUvAHeXv/jyUfSax6Cl1RXgMrAIghur/TS5j8v?=
 =?us-ascii?Q?bAJasRmpjVb2aUStiQ64iu+A71ALi4kpQlV4hWjp+BUgYf8/91g8UmuuVM+L?=
 =?us-ascii?Q?y9yEZObLXvrFLrVwgBYYxENM80KBFEShNuMyU30fG4TpRogeDFaOppyUBVDV?=
 =?us-ascii?Q?KJmULZXD5YpQBtESx7dP0J6lmkXqrN4vABGeoE6bgXKFwXoRh84eiCvA69/f?=
 =?us-ascii?Q?tZGrL0ZsoGWR7tdcSjxrgpVQUJalx07XZPpPwmPfRF65TGZxSkHeT9C5kX3v?=
 =?us-ascii?Q?oYhRb1kE/c2tig6WWP8Vjr1P0ypX5U81tz0Ir7tBMnxIWqs094f+WETX16S3?=
 =?us-ascii?Q?HY32YvY7CIjgMAvO0u+vPAU3Lkp0wmPnKoUpWuqnIDMf5z/nFChpeHlsx7Th?=
 =?us-ascii?Q?v+f8f2D1NFO3cO+81htjOCmf27+zJ0wtwrCcmC2+yYjnlV9No3bdvw0vCU9o?=
 =?us-ascii?Q?uu6qYLoNLFVH17hnUnsvRBEEO0GY11p1FSxm+X2Ki9L5rrqHWplX+zu65bd4?=
 =?us-ascii?Q?Qt5YO8YzTzP49GOimDYRcrl5d24I5vKnxWjI6N5EhGnojbeQ9yhzr9A5jLjC?=
 =?us-ascii?Q?QhkiwkK8PdOn5q5It6rav4lH1jSR9RDIMlE0EtwAfN1+09Zd+tRrN6zo2lLE?=
 =?us-ascii?Q?L746PM9E7AgLHnJgGAhWqAho4aLir8sJze/5UCDS6AFJ1zLXf5oMURYk3B+t?=
 =?us-ascii?Q?dsM4xGRiT4ExhDRqh0Tvzj7D9qT+gznyNiSpsca21OW6WPHfpHiGmRVluao9?=
 =?us-ascii?Q?U15fZnNtOalQV8ov17VvdlvyMF9L4nYX07glgNO/Vt+VYDsWCGwu0+DMcsjb?=
 =?us-ascii?Q?3LUbLkvWF7Z5wveiFG+uORKZ44nZqQtjhE/qa/1LqilW/KVM7W3IDgEQOS2s?=
 =?us-ascii?Q?YYRpfOv6EKEWDzUeppslbWd/FeAe8qAa90wQf2abuTy2P6GkP74QGyVx5dYU?=
 =?us-ascii?Q?jg3Q6ByhfSmPH6kmz1x0/FQcXivs6f3MOC8UJzILnWpx7xEazHbthdMSg7I0?=
 =?us-ascii?Q?O2b1qVp+tTPpYZqz/y4NYYbhBFxG+ejPhTG6ga113gFpglaKqO4bg5RXWF7N?=
 =?us-ascii?Q?Slm1uee78cfPH6UinwjWgeRS+ifybaAZEOZqMbZEr3MBXMbvsXEqaZ9ONcYC?=
 =?us-ascii?Q?N2iY8zsZVhQlhOejuwkp7yL0kZOv3njiXXYMAlDiEoejZoDFSH8LKxazVruB?=
 =?us-ascii?Q?bElyFpCXvCl+tFnjl1mFH7lzRppR9GyBZLeykix+EhP7jthjtaaG/irpPQID?=
 =?us-ascii?Q?8nD4A5FRLeC7mVawMpaTDNPZZ2R6eDgchjPciixk3CpNylDd91HZXIc2Fbdb?=
 =?us-ascii?Q?TxN4fVI+kBwNdRIaoAD3auCAq8FO9EZ8NyXa4Sh5v4nF?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9B4057D2B861E4C94FB081223F22CBD@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1de4f2-35df-4579-c9be-08daac13e313
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 05:37:44.0115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+Qqiy6SerHkEjqQKDzM89+VHAwnjguqL8z+sSMlRriv3qOOdKV93zb8hUe8NrdAaqpYbwzwJPyl1hrr1e2MjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4711
X-Proofpoint-GUID: Jt8rQkrPoP2r4XwOIkqwXlz39CHzcmjf
X-Proofpoint-ORIG-GUID: Jt8rQkrPoP2r4XwOIkqwXlz39CHzcmjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_03,2022-10-11_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 11, 2022, at 1:40 PM, Edgecombe, Rick P <rick.p.edgecombe@intel.com> wrote:
> 
> On Tue, 2022-10-11 at 16:25 +0000, Song Liu wrote:
>>> Maybe this is just me missing some vmalloc understanding, but this
>>> pointer to an all zero vm_struct seems weird too. Are there other
>>> vmap
>>> allocations like this? Which vmap APIs work with this and which
>>> don't?
>> 
>> There are two vmap trees at the moment: free_area_ tree and 
>> vmap_area_ tree. free_area_ tree uses vmap->subtree_max_size, while 
>> vmap_area_ tree contains vmap backed by vm_struct, and thus uses 
>> vmap->vm. 
>> 
>> This set add a new tree, free_text_area_. This tree is different to 
>> the other two, as it uses subtree_max_size, and it is also backed 
>> by vm_struct. To handle this requirement without growing vmap_struct,
>> we introduced all_text_vm to store the vm_struct for free_text_area_
>> tree. 
>> 
>> free_text_area_ tree is different to vmap_area_ tree. Each vmap in
>> vmap_area_ tree has its own vm_struct (1 to 1 mapping), while 
>> multiple vmap in free_text_area_ tree map to a single vm_struct.
>> 
>> Also, free_text_area_ handles granularity < PAGE_SIZE; while the
>> other two trees only work with PAGE_SIZE aligned memory. 
>> 
>> Does this answer your questions? 
> 
> I mean from the perspective of someone trying to use this without
> diving into the entire implementation.
> 
> The function is called vmalloc_exec() and is freed with vfree_exec().
> Makes sense. But with the other vmallocs_foo's (including previous
> vmalloc_exec() implementations) you can call find_vm_area(), etc on
> them. They show in "vmallocinfo" and generally behave similarly. That
> isn't true for these new allocations, right?

That's right. These operations are not supported (at least for now). 

> 
> Then you have code that operates on module text like:
> if (is_vmalloc_or_module_addr(addr))
> 	pfn = vmalloc_to_pfn(addr);
> 
> It looks like it would work (on x86 at least). Should it be expected
> to?
> 
> Especially after this patch, where there is memory that isn't even
> tracked by the original vmap_area trees, it is pretty much a separate
> allocator. So I think it might be nice to spell out which other vmalloc
> APIs work with these new functions since they are named "vmalloc".
> Maybe just say none of them do.

I guess it is fair to call this a separate allocator. Maybe 
vmalloc_exec is not the right name? I do think this is the best 
way to build an allocator with vmap tree logic. 

> 
> 
> Separate from that, I guess you are planning to make this limited to
> certain architectures? It might be better to put logic with assumptions
> about x86 boot time page table details inside arch/x86 somewhere.

Yes, the architecture need some text_poke mechanism to use this. 
On BPF side, x86_64 calls this directly from arch code (jit engine), 
so it is mostly covered. For modules, we need to handle this better. 

Thanks,
Song
