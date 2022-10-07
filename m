Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87EE5F7445
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJGGjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGGjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:39:35 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7143411754A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:39:33 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296NpGgV001103
        for <linux-kernel@vger.kernel.org>; Thu, 6 Oct 2022 23:39:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=OQLAVsqjf1aMeKL2sBQkd4PY3q5af7y6+2B8hblNiXk=;
 b=kg5yWOU4hIPUaVfLVIRDGAZx7TM48IShXwVrevMr8mkIiO99mC5zEcS02IGsnHmyGvL6
 rPmU+IKLaq9NjfpLqQv/fS6TZyLVLLMiOCQsBu13RLvg6IRqLRkifAD8B+RuiyiX8eXw
 Q2Jmu30dXwhRLrTyvM2LABPsxWHlJ1pgZDo= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k28c4hwqv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 23:39:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Waujlcnept+C5o0N0XtsRudv1mbc2vVJuaFOhLfOngCk5NrjJbAB99oI73BXVWZOjH8FzVpsa5cVKj6lDMm5J2pAP6HsIq1xZN9pzRXVHDLOmmw0HbHO+gLcYmFf5uC6Gdd2jl1h06k2W8fjQZEmfy9qgs6MqGpRI0DNRoCHLif7AJW4Nww9t3uVaSpir7stly9V6Po4yD9L0TGsLwq+52JkJj6P9/qPJNdJv7Nn6oDdkOeyZ1oJiZzqQgwg1ZIyCW52/y4yaGpugOFIQvU161nDlDqL+KnfjGgFrYZoUC/bAy4tkojMK2wZOiQqwjbMHy3cgYDPWVZag/85LhXAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQLAVsqjf1aMeKL2sBQkd4PY3q5af7y6+2B8hblNiXk=;
 b=ho/k1SOfnMhQqaaizduhqgHfHNReUjgxyIOzCAOn3936NNN7gDuNQfsnQrPVifU6hF+se+z7I8F9re3SD6H6ME57na34pcUgvlJrTkp8l9T2mg8nArpCsEL8NAsH4nlYXHCy67JhRhPIgKyRKmRbW5z53KP2UDtLPMiz94agh9SzD6Ey0bRFZfrjceBEGW7EaziPxn9frwabcmMpKd3ZdTuMDdKlvZsRPAOZfrsk7avhtmw7ke7EZDcdkjnQ8OiInSJ4DyEqd89sK+F/pfPQgDVamZsMECwxGt9kc2bSVtz1YeNEL0RCGy55QBvvFVTpZDfqHtJcNfHvDcZ6CLbVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB4150.namprd15.prod.outlook.com (2603:10b6:510:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Fri, 7 Oct
 2022 06:39:29 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5676.028; Fri, 7 Oct 2022
 06:39:29 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Song Liu <song@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hch@lst.de" <hch@lst.de>, Kernel Team <Kernel-team@fb.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [RFC 1/5] vmalloc: introduce vmalloc_exec and vfree_exec
Thread-Topic: [RFC 1/5] vmalloc: introduce vmalloc_exec and vfree_exec
Thread-Index: AQHYs1SdLUR7Rnzau0mUGJx0gBZF6a4CTFSAgAB8GwA=
Date:   Fri, 7 Oct 2022 06:39:29 +0000
Message-ID: <E652B995-9F44-4740-93A9-2B288635CE90@fb.com>
References: <20220818224218.2399791-1-song@kernel.org>
 <20220818224218.2399791-2-song@kernel.org>
 <Yz9hhTRzMr0ZEnA/@bombadil.infradead.org>
In-Reply-To: <Yz9hhTRzMr0ZEnA/@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB4150:EE_
x-ms-office365-filtering-correlation-id: b45fee40-3a31-49d5-782f-08daa82eaf80
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mf3yGafR/WsYvQFQbKPx1DN6q4JWKB0otb6p4KE7SWiG5B2ZTiioUkmb6G8ymwej4IBRW13ZDdUWeXC5aTVoTf5yoca8k6u2K7oMJNIfCIuG15mOr0fIqw7t7I+uRlns7Fp5m6z1LRbY52FAbLtHBVRHcUQAhWweILh4yRj0qh2dOaU9V22+gzaPkdds25ESVWeO4omPNTHCPLkefov9e3ZdF50FqCYDZ0qkQrur4v+vcx8GfBnipKbfN11TtEcuCSQ5lYnU899RLFsobP77/KPnHCGXnhRtKgfC+pFjPf09CouPuaVPLIfkDnxEqAY4vclA9D1hS/XH/KdA0rd671uRHidfBsDPxRNgymYeErwMjjTvS1SH9HOuFOhMaTEda2QrSAiWamFPdFfa29Zs0fb3/j3CZRbQZYQobRtkBMLkbwmsY9oKroUgmXkNR5vKm+DnXoRDKfQB4Mh4foo5+9hl3r9xG6FYvbfNUFuH9QfPoRLrkR7I6Kn2UdQJSaU2Rh55WrY8/mbGBUL5cRYhOv00+zWSVhXmFJPBVOkJ7Wx3z6ExTUOZBAPAjtXUBb2YXwvPvm8YWXp/qK4wFhzNH+EuLEMv4xSHk/JOboMOt0UgdsZ2NyhSEeq34FcyV9p0Xn64K4e9yuSfaHpTveKK0MdGkWSqcFCVTlwjSlJVrOaplsX87NnT3MIsyWxcA+fbxz2aez2mTTG98FVZXCvOYXnkNT93PXy65ADTVIL6ZFVG5c/0+9boOg8DHiaJIbrk7gUJXzxRa931qd6rHgoiAq/Dqux+ovaUtXEC5SOKcrNj0oNnYc43+0U8bnwuw/74/w1ayRU3ZUca4nGaKAmLAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(478600001)(36756003)(2616005)(33656002)(86362001)(8936002)(38070700005)(122000001)(38100700002)(2906002)(186003)(6506007)(6512007)(5660300002)(6486002)(54906003)(71200400001)(53546011)(66556008)(8676002)(66476007)(91956017)(76116006)(66946007)(83380400001)(64756008)(4326008)(316002)(41300700001)(6916009)(7416002)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yXb+rH9zRppvfX2USDSHyLjlJR/5R8sHRDjD+06+g+CNuVuJenYe/sOgJF6d?=
 =?us-ascii?Q?rHtInCou3cpb3uER8m+c1yfWRF4LaS+w98fNd69jUCXmTq2cB+s1p5Z3WKc1?=
 =?us-ascii?Q?YLv1QDRyrY1AZUiM+izuQORyPMSftRMHl7KfSfpr7qpDtqStzrz4I1DrgfN8?=
 =?us-ascii?Q?1o/l52jZTH4XLOICQ2UnrK892q2wKUYbErXFphp9ugEBouspqJKqqb2aftgJ?=
 =?us-ascii?Q?Q9w4GwSIczu12ZDe5rwG0GRwdr20oAHkQ6IVVLXP4gICcqlo18aUJC/VY7AS?=
 =?us-ascii?Q?zbGhTG5j0XzLXheJxQUU6nKa/NfX0k4Gsl7iQISAatcbq7qz30Eq2fydG6ND?=
 =?us-ascii?Q?uPdXh1mMPWaJ7+JzjwEfvmbbOIdE0A6HtUopu0VITDykljG2DrqB79aVM6He?=
 =?us-ascii?Q?A5v12sZssu8IQf3l/LQU04BhtqV5+zhGcro4ph/KwhYM2TU48dSsCVcSA8OE?=
 =?us-ascii?Q?eXwQKeuqhUoN49pmtQmHtjPUdQTIYGGrRgDngljA9xsXCYho1qaFvSfNZ6OB?=
 =?us-ascii?Q?8D8YPkIUtja53wfUk02MfEuahsKMh/6GtIxHWWnj6FVVMyd3XzOnC7o+CRJP?=
 =?us-ascii?Q?aDt2rZ2EanQouuIf51LsCJ9BZGu8zpZfawIUtTTBEkOTeE4Ax24ei5xs9p0M?=
 =?us-ascii?Q?+0mMNF4i8z1MrO4p/wFU7rPwnBZRxZY1R4h7XMW/3EgtY6gAy66z3iQn1o7g?=
 =?us-ascii?Q?s78u8mNLETBBu8B5oV8qHYmIUj+A4G1pyGhXYQ5oN+K2UYpaVi+sMz4Dd1Ee?=
 =?us-ascii?Q?BRbI5rDCgVw/s7SRxr3fZPGWMo4gmKdLy3djc19vJ40l0rIJWqHbOBAMRQL6?=
 =?us-ascii?Q?yYBpGFW+MCunIhOYsOpGuXKq9jKsrrjlvc8VcigeAkbFuvE5Wz0KUqXCvvOw?=
 =?us-ascii?Q?IcgGWFD2sL3kDpm7uB81OVoIl9sKkHQR9MXNtC5qK+jpMqPLCy/1X+x/qSHm?=
 =?us-ascii?Q?PaZvAJROFsWC2Lrv6qk0eSMk2oP9B+mOG7sEyJEGJ+LZZ8m41tKIgGD9B501?=
 =?us-ascii?Q?OXgge3Tb2QwwRZOk4uDiBsTr6vUdb9Z1afILrNXescmzcfPB3eJITpUoKko2?=
 =?us-ascii?Q?383/rMEDTPPJzBexnFvAifHcoVvvmuuouYRZIy/bY+1HL7ndT/Z2AGF2FKBA?=
 =?us-ascii?Q?i6gJgORdtDm07+EsOGTJxJwVAbeLmvUJQg2iHWhAuET0d6blNbiNbF7GfJtl?=
 =?us-ascii?Q?BQln1M5CoDwAkN3FdYI6FldKXJXKC5OhX1/Jj6zGr30oOKSm5sHH77je+SCu?=
 =?us-ascii?Q?2pTNPEX8l6AC9fQOvDq7VtwBF5rKkJUMqzODLWSDxECj2s9I8yeihtmcKH9C?=
 =?us-ascii?Q?IkvjSMFN3Q76WDgldPUks/yJPeiinomuDFC7v6OLP8zX5totMJ2L2GF974sR?=
 =?us-ascii?Q?QHIL7ivO3XlvBsgraNQlTUGi9JVin8cmzqBMcCeLarOPdVTiCsYKbvpH2alO?=
 =?us-ascii?Q?T/Qof/sAEN03AKEm7JQekHVbcvJIOmk+7CW3DMtVuwwJsUrXavA+bE/vv4NB?=
 =?us-ascii?Q?Q52FYaWWpFTc7hMYa7WeYR6GSHkQtoeSE9nv9eqNCaWeEIz4eM+4IWJ6AivX?=
 =?us-ascii?Q?OqnWejMiaaScHbiBjTM1TwsrpQv3vL/i/sne4HqiO4bMXONjc0+2zDMFN3nj?=
 =?us-ascii?Q?81/V8i3jv+oJ2GvZgnTsW8E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A84DA15A549324784C7E1774D7A8D29@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45fee40-3a31-49d5-782f-08daa82eaf80
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 06:39:29.2584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Z+8+7n02IZEhv5MIxjpERDLd8IMCl5isoTuMZXWPD7foPoaBMcNvCLamiLfBNJzmghDr4LIZFdZPomVlAiGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4150
X-Proofpoint-ORIG-GUID: bbl86MyG28FCSljAri_gup8eR9T9fdx_
X-Proofpoint-GUID: bbl86MyG28FCSljAri_gup8eR9T9fdx_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 6, 2022, at 4:15 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> On Thu, Aug 18, 2022 at 03:42:14PM -0700, Song Liu wrote:
>> --- a/mm/nommu.c
>> +++ b/mm/nommu.c
>> @@ -372,6 +372,13 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
>> }
>> EXPORT_SYMBOL(vm_map_pages_zero);
>> 
>> +void *vmalloc_exec(unsigned long size, unsigned long align)
>> +{
>> +	return NULL;
>> +}
> 
> Well that's not so nice for no-mmu systems. Shouldn't we have a
> fallback?

This is still early version, so I am not quite sure whether we 
need the fallback for no-mmu system. 

> 
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index effd1ff6a4b4..472287e71bf1 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -1583,9 +1592,17 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>> 	va->va_end = addr + size;
>> 	va->vm = NULL;
>> 
>> -	spin_lock(&vmap_area_lock);
>> -	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
>> -	spin_unlock(&vmap_area_lock);
>> +	if (vm_flags & VM_KERNEL_EXEC) {
>> +		spin_lock(&free_text_area_lock);
>> +		insert_vmap_area(va, &free_text_area_root, &free_text_area_list);
>> +		/* update subtree_max_size now as we need this soon */
>> +		augment_tree_propagate_from(va);
> 
> Sorry, it is not clear to me why its needed only for exec, can you elaborate a
> bit more?

This version was wrong. We should use insert_vmap_area_augment() here. 
Actually, I changed this in latest version. 

> 
>> +		spin_unlock(&free_text_area_lock);
>> +	} else {
>> +		spin_lock(&vmap_area_lock);
>> +		insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
>> +		spin_unlock(&vmap_area_lock);
>> +	}
>> 
>> 	BUG_ON(!IS_ALIGNED(va->va_start, align));
>> 	BUG_ON(va->va_start < vstart);
> 
> <-- snip -->
> 
>> @@ -3265,6 +3282,97 @@ void *vmalloc(unsigned long size)
>> }
>> EXPORT_SYMBOL(vmalloc);
>> 
>> +void *vmalloc_exec(unsigned long size, unsigned long align)
>> +{
>> +	struct vmap_area *va, *tmp;
>> +	unsigned long addr;
>> +	enum fit_type type;
>> +	int ret;
>> +
>> +	va = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, NUMA_NO_NODE);
>> +	if (unlikely(!va))
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +again:
>> +	preload_this_cpu_lock(&free_text_area_lock, GFP_KERNEL, NUMA_NO_NODE);
>> +	tmp = find_vmap_lowest_match(free_text_area_root.rb_node,
>> +				     size, align, 1, false);
>> +
>> +	if (!tmp) {
>> +		unsigned long alloc_size;
>> +		void *ptr;
>> +
>> +		spin_unlock(&free_text_area_lock);
>> +
>> +		alloc_size = roundup(size, PMD_SIZE * num_online_nodes());
>> +		ptr = __vmalloc_node_range(alloc_size, PMD_SIZE, MODULES_VADDR,
>> +					   MODULES_END, GFP_KERNEL, PAGE_KERNEL,
>> +					   VM_KERNEL_EXEC | VM_ALLOW_HUGE_VMAP | VM_NO_GUARD,
>> +					   NUMA_NO_NODE, __builtin_return_address(0));
> 
> We can review the guard stuff on the other thread with Peter.
> 
>> +		if (unlikely(!ptr)) {
>> +			ret = -ENOMEM;
>> +			goto err_out;
>> +		}
>> +		memset(ptr, 0, alloc_size);
>> +		set_memory_ro((unsigned long)ptr, alloc_size >> PAGE_SHIFT);
>> +		set_memory_x((unsigned long)ptr, alloc_size >> PAGE_SHIFT);
> 
> I *really* like that this is now not something users have to muck with thanks!

Well, this pushed some other complexity to the user side, for example, all
those hacks with text_poke in 3/5. 

> 
>> +
>> +		goto again;
>> +	}
>> +
>> +	addr = roundup(tmp->va_start, align);
>> +	type = classify_va_fit_type(tmp, addr, size);
>> +	if (WARN_ON_ONCE(type == NOTHING_FIT)) {
>> +		addr = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +
>> +	ret = adjust_va_to_fit_type(&free_text_area_root, &free_text_area_list,
>> +				    tmp, addr, size, type);
>> +	if (ret) {
>> +		addr = ret;
>> +		goto err_out;
>> +	}
>> +	spin_unlock(&free_text_area_lock);
>> +
>> +	va->va_start = addr;
>> +	va->va_end = addr + size;
>> +	va->vm = tmp->vm;
>> +
>> +	spin_lock(&vmap_area_lock);
>> +	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
>> +	spin_unlock(&vmap_area_lock);
>> +
>> +	return (void *)addr;
>> +
>> +err_out:
>> +	spin_unlock(&free_text_area_lock);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +void vfree_exec(const void *addr)
>> +{
>> +	struct vmap_area *va;
>> +
>> +	might_sleep();
>> +
>> +	spin_lock(&vmap_area_lock);
>> +	va = __find_vmap_area((unsigned long)addr, vmap_area_root.rb_node);
>> +	if (WARN_ON_ONCE(!va)) {
>> +		spin_unlock(&vmap_area_lock);
>> +		return;
>> +	}
>> +
>> +	unlink_va(va, &vmap_area_root);
> 
> Curious why we don't memset to 0 before merge_or_add_vmap_area_augment()?
> I realize other code doesn't seem to do it, though.

We should do the memset here. We will need the text_poke version of it. 

> 
>> +	spin_unlock(&vmap_area_lock);
>> +
>> +	spin_lock(&free_text_area_lock);
>> +	merge_or_add_vmap_area_augment(va,
>> +		&free_text_area_root, &free_text_area_list);
> 
> I have concern that we can be using precious physically contigous memory
> from huge pages to then end up in a situation where we create our own
> pool and allow things to be non-contigous afterwards.
> 
> I'm starting to suspect that if the allocation is > PAGE_SIZE we just
> give it back generally. Otherwise wouldn't the fragmentation cause us
> to eventually just eat up most huge pages available? Probably not for
> eBPF but if we use this on a system with tons of module insertions /
> deletions this seems like it could happen?

Currently, bpf_prog_pack doesn't let allocation > PMD_SIZE to share with
smaller allocations. I guess it is similar to the idea here? I am not 
sure what's the proper threshold for modules. We can discuss this later. 

Thanks,
Song

> 
>  Luis
> 
>> +	spin_unlock(&free_text_area_lock);
>> +	/* TODO: when the whole vm_struct is not in use, free it */
>> +}
>> +
>> /**
>>  * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
>>  * @size:      allocation size
>> @@ -3851,7 +3959,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>> 			/* It is a BUG(), but trigger recovery instead. */
>> 			goto recovery;
>> 
>> -		ret = adjust_va_to_fit_type(va, start, size, type);
>> +		ret = adjust_va_to_fit_type(&free_vmap_area_root, &free_vmap_area_list,
>> +					    va, start, size, type);
>> 		if (unlikely(ret))
>> 			goto recovery;
>> 
>> -- 
>> 2.30.2
>> 

