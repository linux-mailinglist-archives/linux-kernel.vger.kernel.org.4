Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7666B5FA3F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJJTJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJJTJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:09:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C8061B32
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:09:00 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AIpEBv015816
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:09:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=1yB1Y2mIDN36M8oZTgngjSXew+hRQQl+3UXFo2V/KQo=;
 b=g+PMICmG33STc1aqS5aLb5leEpxCIBy16ziXa9UP6mycSzspvtMWbhfRCv28qYEoD9XY
 1AL+bcRjIyUNVa2o4mV0A37fQuyt1Nd6ZvY1leHN2lnAHPg4RxQgHzQjPx5ZnH+eAUY7
 NNHeovGJVv62OAH7qEzSgySCxOlNoR8BuMY= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k4n9rj7rn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3QFk1WOovoZ0pAPspQprmjt5IHGb6XdrG0P523ozJpnBPQmyZGcnbjWW0d61Uq3MbUcGJw+ExDNLIcmFPw1EMtR1iUaSWDyEUdtSnLFb3iNstI1GKgRZM3GiBHwyOV51W/cGv0Ip6yzaALWvRGxfHfRpSvDJ/GNISpgTPEy4yBDUcyLDJyfhI0J10Z9uV6XzKLZg29w2njaSef3bUkQsTWPfUSAiMTN6lzCNq0PVCeUQ9nN9w8tfBmU0+cU7QVguvmtIgwLVIK5NI/GAh0VLCGjj89dt+kT2uKq0DKUqtISQVyK9KdBIs+q1/0Rvhcw9BXrd6p+Zol3uWAy7BxGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yB1Y2mIDN36M8oZTgngjSXew+hRQQl+3UXFo2V/KQo=;
 b=dNwUmf0JXlonoY3JdCxh6cFB7HImubjgYsrkk+5CFTkmtj1WKUNi128o6G0Oz1OonXN4vfn+oF5cby2r8S7WEraPAppxxSucodCkvU7n0uaSaoh4lIJeT5bhAd9DtNJ/V/HxLavhl3Em3f4JT7Tl7jOCREQCvvpffaqQmGtUkhrTT8DTwpm4bhnID9yNwjonWejbMgyuxhrQLyIyS533cdi61GSrwOB7W+9oeWkEwtOEYmVWst7JsHxFPcZn+60TzDhd1EXvj5ymNHQYZ2e6s+G2KIQoF5w4Cck752gcYzuqZdOJ2q9VugO8f+w+vROQ0MBZNCbwvom+m1ts8PFyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3610.namprd15.prod.outlook.com (2603:10b6:5:1f6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 19:08:53 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%6]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 19:08:53 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Topic: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Index: AQHY2qb4/DleVypvfEGw7i865KJ5wq4H9+4AgAAKPAA=
Date:   Mon, 10 Oct 2022 19:08:53 +0000
Message-ID: <B849A9FF-1054-4D5C-AEBD-72AED8B8F277@fb.com>
References: <20221007234315.2877365-1-song@kernel.org>
 <20221007234315.2877365-5-song@kernel.org>
 <af5c148fb3b9c56d1eb7e92b05db7c6c04bcfc3c.camel@intel.com>
In-Reply-To: <af5c148fb3b9c56d1eb7e92b05db7c6c04bcfc3c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM6PR15MB3610:EE_
x-ms-office365-filtering-correlation-id: 03476899-759f-4bfc-d544-08daaaf2df51
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vJNeDrbc6SLcdjwhc6Kmx4kNEX2ZJfMT+2gIvJzvrjWoFVvZuGe2P3GVr9uQKuM0I0womwi7cRczkTpQSaK3/UexXkFFcr/74TD8YaZFuOigHF6wNvrjMDCGAPwL4bavF8poucEuIkEEkiKm4sxYjWDFRJKIsCzxOiLfs7ntEfkhdHgBdJaKv9QHrw+NMnwiAawHc9MOKyoV2Wx6jKx4HB+8jUveVu/RQ2pFXoMc0i2yHDj2UjzulSeh9Dq8fEOQ5/gK5E+lmt3bYMYsiodqdPKHrPlDF2qdDxISxcdMTWwHzJZMyAmX9hlqnkkok4ZE3mbal5HZFYv0jrvAG9IJfidwGMwAuXf0+kK0rGuGwp2iLZjcTk/ddwTn2UJGUYJj2KAFv7BHPyBTamD7GHYs29IvdaZNeRQqOmPdA3ZT+8c1pciUx/FYzMko7pwzViGvqzgCs9aoOulkyekyEnWpUWk5xDbpkNfY/g2411cLEpzXL07RHjhguiX8Xjizd2IrEcjfPsmFqOercQQc4ai35xzySdRIEcszcrqSZXvt06md1OwKptAcQBdPNjhLNwtGFTZS5GHza/Z+PnrhZHnDpiw5PKRlNP66bFmLhz7ThNzuMmjfsWNsrli5krj/kjFPkGowf+S6ZBlQNapyk/8btSf2rkVDz5eyzvWkSmM6G1Ne8/ZpGz+UBLWOgSf0XvIXt84/1dAYCDfj19rf++KiVRvUURvPWjrnUaVtVS0inqbDoCPR/2s222dBKW+fozrfyvnLWYd/KG7g+3cqO4wJfAAcKbiXXB62Dlat6kmVB/8poD+6v1e3opLO/aSV346y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(4326008)(76116006)(66946007)(8676002)(66556008)(66446008)(64756008)(5660300002)(66476007)(41300700001)(86362001)(6916009)(316002)(54906003)(91956017)(2906002)(33656002)(36756003)(8936002)(7416002)(122000001)(478600001)(2616005)(186003)(38100700002)(53546011)(83380400001)(6486002)(6512007)(38070700005)(6506007)(71200400001)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ghiEkagg3noO7NJ/8xcziSCiLMD860oXDeWKI+T5smFQcKx8UBzosBkfJ6PT?=
 =?us-ascii?Q?22ut+9cv/BLVGIAXnC2x+UG+wFgZdSSnMwypoufFlWU+IqagsclvAyv+WzYA?=
 =?us-ascii?Q?rH5E+3peg/KYF4zEI5IJFNJD4GQaHebPZTx2mS4xTROhJ+4DOnsdBTYeHmyl?=
 =?us-ascii?Q?ahtie6xCXzaosraeey2747q3NqfeQ77hnmv2eWwMRJtL+NNYMSP6tk+Jiw24?=
 =?us-ascii?Q?zE6I2Otyyi1gfocMdWgabwNxQGNMBf0HM+RmJXSluQ4dXbsLk6rSvKb5NHj5?=
 =?us-ascii?Q?DrKR+oZertVi0+Oq2JFu0dHmaxmoAucbFVzf6RsIyTjha7Obd+lBIwsIndCh?=
 =?us-ascii?Q?vFxnht3/xBy2nVF8jOcXbO7wsiy+aVCVjctio1r7znbmlgBHr6atDxz0MSVp?=
 =?us-ascii?Q?V0tdtc9Rzal5N7bGRgGdQkeUx0PthYhdJItNahWrhMcKWWFnBXgk95UnZ9vh?=
 =?us-ascii?Q?viwaePXyNGNbUuEBt77y4eEyhx23PfnyWrIu+AkjTqZawyaIpWGZqHWEir1b?=
 =?us-ascii?Q?ecLyH+3OqqNWEuFDKOmklXrfrggC/paTfQUToXb4SFZ1eE4VAvWTFlyiQCYx?=
 =?us-ascii?Q?g4yKFxFBRrxeZlkTeztXqGpeMPvXg7oEOKsE3oAq37nj81NqvbPdeCjNe1T2?=
 =?us-ascii?Q?OTWGT0FJSFv9LP7a6gBi9+23l+SfamHUaV1SN0vLiFyRcvSo12hExO7ceKMy?=
 =?us-ascii?Q?A2+wPIZBwQ62TKJ1fgSfeS5KGxfm/eMiDp8FYTWYPXjPjapXn7oM9i0hCuM9?=
 =?us-ascii?Q?j+Loj3zNVRY4SX/S9GOsZD3KWQfxNDMjPVJfua8JdOQiXMgbD8gotUnRfiQS?=
 =?us-ascii?Q?Zb3fiYVCW4sue4vBY45fvmHqbm60b2wO7VcR5o9gQ3+HFi+RTo6ZSjl5O+HX?=
 =?us-ascii?Q?zHICtXCjA1WrekjkorSdePBnEniXb/8MWyMbcfXFeSQfKLlR559vvdkH1yJQ?=
 =?us-ascii?Q?wA7faVQnQyEli1HIaUY64YE9KHBy3yDKcI8md68LMFPJVH4Vtp3QrmqMDayS?=
 =?us-ascii?Q?e9Am9QDB9dB1hSkWvEZWTK+mlf6R+meyyrdaW7sfXKHkCd7uCI4T9ly3hueS?=
 =?us-ascii?Q?xSTx1nski+AsBKbc2wuI1vG/pAb6yQNvOjIDe1a9Lk1OkfSzpi5MHNwCq1eI?=
 =?us-ascii?Q?31oWKGx/tbzjY9LpLBc6qQyBv9YidtOHxE9iUnR1shs8/THN/gBmW6jNV43Q?=
 =?us-ascii?Q?tkOXTLHov4lTavos1p4bFyyIU8jfVhKti5H1F7NqeEohq/3usgZJP45Mmff9?=
 =?us-ascii?Q?x3EUGGD0q6x/i4o2yTIgSW2QD/ygy7VASYpsAAzVNAfB0m+rbn7NEnKk24Wl?=
 =?us-ascii?Q?WvXJR03BXa42TCFldad9HFhHCWDI9WZfSYsUHa4JuNWw9S4y7r2RxPYlq3nR?=
 =?us-ascii?Q?JJfqVOxg5alGRHbr+LEuxAStHrVNAvz7Q6rKHsfIFQ/gH4FBavj39ZIlVTy6?=
 =?us-ascii?Q?z0dIGTO1LJQ1junWIK4GKixEFh+3JgG8cIj3gWMBWClVSmq8azCNnTOd4wEA?=
 =?us-ascii?Q?ilrCz909pcJPZSmdvj6VdEdZtgKJQSy4o84fyjoJCeS9IUed+QNsDI2cTbUE?=
 =?us-ascii?Q?GSWWUHdV+M5bkGL/seAzVeDT8Z051AnbdNrduianvZvaYD9l2gT8AF3pJHSk?=
 =?us-ascii?Q?bRIFhMXzfG5cd9zjZXIL1uc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA5B424F3825AB4F96D48C99ED80EB82@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03476899-759f-4bfc-d544-08daaaf2df51
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 19:08:53.1679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbdc6vqeiUrgOYGsK2so7RQIP53LUGuEAeoIoODnu0PNIn1tnvAX317g6AycFCkO4TsKdQ9u6xhXCjmpmG3Gnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3610
X-Proofpoint-ORIG-GUID: Q5UfXUzwigZlvpvNSEv7b6bX5sIuVwFY
X-Proofpoint-GUID: Q5UfXUzwigZlvpvNSEv7b6bX5sIuVwFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_12,2022-10-10_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 10, 2022, at 11:32 AM, Edgecombe, Rick P <rick.p.edgecombe@intel.com> wrote:
> 
> On Fri, 2022-10-07 at 16:43 -0700, Song Liu wrote:
>> On x86 kernel, we allocate 2MB pages for kernel text up to
>> round_down(_etext, 2MB). Therefore, some of the kernel text is still
>> on 4kB pages. With vmalloc_exec, we can allocate 2MB pages up to
>> round_up(_etext, 2MB), and use the rest of the page for modules and
>> BPF programs.
>> 
>> Here is an example:
>> 
>> [root@eth50-1 ~]# grep _etext /proc/kallsyms
>> ffffffff82202a08 T _etext
>> 
>> [root@eth50-1 ~]# grep bpf_prog_ /proc/kallsyms  | tail -n 3
>> ffffffff8220f920 t
>> bpf_prog_cc61a5364ac11d93_handle__sched_wakeup       [bpf]
>> ffffffff8220fa28 t
>> bpf_prog_cc61a5364ac11d93_handle__sched_wakeup_new   [bpf]
>> ffffffff8220fad4 t
>> bpf_prog_3bf73fa16f5e3d92_handle__sched_switch       [bpf]
>> 
>> [root@eth50-1 ~]#  grep 0xffffffff82200000
>> /sys/kernel/debug/page_tables/kernel
>> 0xffffffff82200000-
>> 0xffffffff82400000     2M     ro   PSE         x  pmd
>> 
>> [root@eth50-1 ~]# grep xfs_flush_inodes /proc/kallsyms
>> ffffffff822ba910 t xfs_flush_inodes_worker      [xfs]
>> ffffffff822bc580 t xfs_flush_inodes     [xfs]
>> 
>> ffffffff82200000-ffffffff82400000 is a 2MB page, serving kernel text,
>> xfs
>> module, and bpf programs.
> 
> Can this memory range be freed as part of a vfree_exec() call then?
> Does vmalloc actually try to unmap it? If so, it could get complicated
> with PTI.
> 
> It probably should be a special case that never gets fully freed.

Right, this is never freed. 

> 
>> 
>> Signed-off-by: Song Liu <song@kernel.org>
>> ---
>> arch/x86/mm/init_64.c |  3 ++-
>> mm/vmalloc.c          | 24 ++++++++++++++++++++++++
>> 2 files changed, 26 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index 0fe690ebc269..d94f196c541a 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -1367,12 +1367,13 @@ int __init
>> deferred_page_init_max_threads(const struct cpumask *node_cpumask)
>> 
>> int kernel_set_to_readonly;
>> 
>> +#define PMD_ALIGN(x)	(((unsigned long)(x) + (PMD_SIZE - 1)) &
>> PMD_MASK)
>> void mark_rodata_ro(void)
>> {
>> 	unsigned long start = PFN_ALIGN(_text);
>> 	unsigned long rodata_start = PFN_ALIGN(__start_rodata);
>> 	unsigned long end = (unsigned long)__end_rodata_hpage_align;
>> -	unsigned long text_end = PFN_ALIGN(_etext);
>> +	unsigned long text_end = PMD_ALIGN(_etext);
> 
> This should probably have more logic and adjustments. If etext is PMD
> aligned, some of the stuff outside the diff won't do anything.

Hmm.. I don't quite follow this comment. If the etext is PMD aligned, 
we can still use vmalloc_exec to allocate memory. So it shouldn't 
matter, no?

> 
> Also, if a kernel doesn't have modules or BPF JIT it would be a waste
> of memory.

I guess we can add a command line argument for these corner cases? 

Thanks,
Song

> 
>> 	unsigned long rodata_end = PFN_ALIGN(__end_rodata);
>> 	unsigned long all_end;
>> 
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 9212ff96b871..41509bbec583 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -75,6 +75,9 @@ static const bool vmap_allow_huge = false;
>> #define PMD_ALIGN(addr) ALIGN(addr, PMD_SIZE)
>> #define PMD_ALIGN_DOWN(addr) ALIGN_DOWN(addr, PMD_SIZE)
>> 
>> +static struct vm_struct text_tail_vm;
>> +static struct vmap_area text_tail_va;
>> +
>> bool is_vmalloc_addr(const void *x)
>> {
>> 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
>> @@ -637,6 +640,8 @@ int is_vmalloc_or_module_addr(const void *x)
>> 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
>> 	if (addr >= MODULES_VADDR && addr < MODULES_END)
>> 		return 1;
>> +	if (addr >= text_tail_va.va_start && addr <
>> text_tail_va.va_end)
>> +		return 1;
>> #endif
>> 	return is_vmalloc_addr(x);
>> }
>> @@ -2422,6 +2427,24 @@ static void vmap_init_free_space(void)
>> 	}
>> }
>> 
>> +static void register_text_tail_vm(void)
>> +{
>> +	unsigned long start = PFN_ALIGN((unsigned long)_etext);
>> +	unsigned long end = PMD_ALIGN((unsigned long)_etext);
>> +	struct vmap_area *va;
>> +
>> +	va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
>> +	if (WARN_ON_ONCE(!va))
>> +		return;
>> +	text_tail_vm.addr = (void *)start;
>> +	text_tail_vm.size = end - start;
>> +	text_tail_va.va_start = start;
>> +	text_tail_va.va_end = end;
>> +	text_tail_va.vm = &text_tail_vm;
>> +	memcpy(va, &text_tail_va, sizeof(*va));
>> +	insert_vmap_area_augment(va, NULL, &free_text_area_root,
>> &free_text_area_list);
>> +}
>> +
>> void __init vmalloc_init(void)
>> {
>> 	struct vmap_area *va;
>> @@ -2432,6 +2455,7 @@ void __init vmalloc_init(void)
>> 	 * Create the cache for vmap_area objects.
>> 	 */
>> 	vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
>> +	register_text_tail_vm();
>> 
>> 	for_each_possible_cpu(i) {
>> 		struct vmap_block_queue *vbq;

