Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8105FCB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJLTBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJLTBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:01:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E8C22BD0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:01:47 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CGZp6k008404
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:01:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=+Qti10ULGE3CwOxuvM8VWoUVNJHST6nVoyHjdssEvy4=;
 b=Urr1zaroSBQa6BMa3eSCvgICkPKdYfJeSXviWiM875dbGIh3TaZ2ACXOqHu+BJE26iwj
 hPL/MMmHqOBHtDsp85BvGakpYJIncZe+WH6fvz/Dp7A0buiUFWN1rFk1Od80ILWKpXyC
 sKuZ3kj6qswLeqBXs8KdKVuhVQtPd75CRMmjgfhdXcB1d3Hgwq1EbrG/9K4/2AHuHhS3
 QJUhhwBg8+R3ObIRGjGNCbMSdBd6xlXJtrFMFwtDf9PMM1TaSWSt7KUPVTKPCtEJ34Bv
 skuAs/YH/kvR0KULkUfiVcV8ppSQyWD1SaPZGoLHjUAutlut0jY8zVX8VIfMDzSmpRzU jw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k5qgr5wwv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:01:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8oOkuVdfUIQawY5WMHoKpy/YRb1sP9hls3jEY4D1wTIUT33AMxRLsxbUIrKJNuwRSxoq6ovqO1EHICkZOs5jS37SZ4+XbfbLmpgLuKA8gOVhEuslEbjft0uVuRr07mAmg+1a73egPcVu0WMKaK7mQaZGTHzHCsJFY1yDWo2zSut+BFgAlPp0+4DA3vHRBsTmyVbAXuJvz1fBXfebTnfBz9c4s3Ji1oCqdsuFQvG4iwDfp9zAoUfHsFn/p+V0GIYkMOUKVLfGmyXrjlwr/FTfAQee+Zdb22wKqfVna/gPxmKDUTUDgV2x3Z80tdRHgfaDhRPbBdApY4iIOc50X8XYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qti10ULGE3CwOxuvM8VWoUVNJHST6nVoyHjdssEvy4=;
 b=fBXzdd+mF8j64gjSVS/LBS3/2o/Qafg1z3JMld+jAqjeKKWaPXmK2UF3yl4wDqQ4TRWX8g18vIV+bcs0KFMNzZKnTv+TyzUaI6Ho8qDG5o+C0QD6790CIeUgola+uyjmO4oo6s44MCO6q1wddHycn85Qwl2BuMqy71IchAqzw1ITuVVnGZj5OteWMsVYEn/aymi3FHhXUbzUbjwoG/fQ81DNe0o+UZnqT3SbUxKL75J3mDwi046mh8PRi7T54BFVsYDMZJbbApTc7tR5FH3mwoFrzMxMbVTLDLA1IEiPUGGBEnM0TDhOISoZHZD8t9E6Reou6+ly1w6JPYNWrVVSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB4829.namprd15.prod.outlook.com (2603:10b6:510:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Wed, 12 Oct
 2022 19:01:44 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%6]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 19:01:44 +0000
From:   Song Liu <songliubraving@meta.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>
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
Thread-Index: AQHY2qb4/DleVypvfEGw7i865KJ5wq4H9+4AgAAKPACAABD6AIABU84AgABHRYCAAJX7gIAA2jQAgAAGboA=
Date:   Wed, 12 Oct 2022 19:01:44 +0000
Message-ID: <0209B426-E425-44C2-825C-8AAC59B5BB2D@fb.com>
References: <20221007234315.2877365-1-song@kernel.org>
 <20221007234315.2877365-5-song@kernel.org>
 <af5c148fb3b9c56d1eb7e92b05db7c6c04bcfc3c.camel@intel.com>
 <B849A9FF-1054-4D5C-AEBD-72AED8B8F277@fb.com>
 <3842f1e7cfdde4f848e164872f62c0c1da654fec.camel@intel.com>
 <2B66E2E7-7D32-418C-9DFD-1E17180300B4@fb.com>
 <99201f0c3509e1ea3d08a462beaaea9d60382cff.camel@intel.com>
 <0D4668C5-28C1-4846-9698-C5C05BC23F0B@fb.com>
 <6fb1ef25df1caa7206572f24a70da0c2f2714135.camel@intel.com>
In-Reply-To: <6fb1ef25df1caa7206572f24a70da0c2f2714135.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB4829:EE_
x-ms-office365-filtering-correlation-id: c163f6a9-1e4d-431e-f032-08daac84346c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gqj9VFO5ZeAsrEfoK91jcESZFM5EGzqkvTULbh8/U/CDOlJEMfrHRKeFWm49jja+zi9Onjn68BxJ83lAJSn897ykmJ7ga4NvQSJGLlKuTP6dDbxCM7f8ISmOAOQZWESKGq0doT91QgS48NTboq6R+Fp0XWOgTo/RjuIHfXhlVHliVRwjh0KiJeO/qjmGQA+0EqOxGbcLt+t1lyHzhAR6QpQ8yOS4K2rDqC0TlKzrFdENdtqKNFCIXKThYvM8mGEbe/VVw0lJDK6WKXcXvauey5KOLAnKG/4sm52l/ahptOg1gnYJdsw7dqAc2WFQ9+5L+MZYfHZeOGt1EAU4H1y3kdxPWiyWbtRs4zd4aoO5O5cuKSkpeGd8JAMZkxH7cXUYgRyRCguGT0g15OTElZzcWUK8XJ0bUfC10DXUvwZEPqM5cy1Hgn72yZ0MB7ioRhcpAb81BBYNzB6GKeORthYH16NOJ7R9bgZg/xur8Ll5VKptG3ah4IcqOjwEqSw4jSbvfZbjBGmDer1s37jdWW/wgWqRiOUtLtHMF6+0MzcnqptboehYjsMbqS7J/NzZ9A767BPZbB5xyKnXYyIcYAUfvi4yL+Lwf5HsOVQ408eHoLJUgYsFkct1ctJ6JsDcK9iWRvYlQT3W/T+sgcOMAWmU/wgrnMgfdEXAzWjV233JaF4+RtDwGLPHHmbKP1Or9y3fUf16wyvA2HW22j8OXdQmZHTEprbw0KWUD7JnGIPQv086El7xx5VsESS77UxeqBlLCr7IbtlXpb1srpEPLLkzroyLhW3m/3py3I4ni9uAsxc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199015)(53546011)(316002)(38100700002)(71200400001)(110136005)(66446008)(64756008)(4326008)(8676002)(91956017)(66556008)(76116006)(66476007)(66946007)(122000001)(86362001)(38070700005)(36756003)(33656002)(83380400001)(6512007)(9686003)(6506007)(54906003)(478600001)(6486002)(8936002)(4001150100001)(2906002)(186003)(41300700001)(5660300002)(7416002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kB8/jj++L/JILQdWscaT2DEhRp3zxoi7uBkRM7axTPAcYiHnBq37ntanlBc8?=
 =?us-ascii?Q?aYRcmzQZop/essYHsvtZT1xUaafIWSJXETCidm8q8C2pxfg7vqTGeLYMu4/D?=
 =?us-ascii?Q?fWBZKjBOKM8BvGweZrrSKM0K+yRnvd2s8g1Bo7tMxqJV5MJRm/JReUCocitH?=
 =?us-ascii?Q?yzBh44GqO9Ob6nIiUeUz32h4UI4N4z/aGy7dn7P1HbkGcC9CpYBi8TagjjUg?=
 =?us-ascii?Q?645pWmzmVBsPmTiOuSRE8XOMf/l+FRo78rE+yNaqKSx4pTrBoOrUuYyXG4wG?=
 =?us-ascii?Q?698XTTUByDH/cnDJG0h1xMbxy6R0ny41632Hv7peO9epdMPSjI23XUloVpCR?=
 =?us-ascii?Q?v4ygkXq1naeNynW9y/rd54hs/JLr7a7TWilDP0I2XZA29QfgY46lk1ewkPMi?=
 =?us-ascii?Q?wXC/HP40J+rv0IzIrcMJQWNnAbgFx/AHkN3gYVn6Op8wouxxl0AzQCHSDdVm?=
 =?us-ascii?Q?e9tplgBHDs5jGS0R5alTMMQr7tY4xLSt8kEUX+YyZTvo41vV+O+PEXdLs9Hs?=
 =?us-ascii?Q?ITBbbB8cCei1qOtBRyMgsJXjZrxmIWzj/MRH1aTNu2zr+koz+AXN+3MYGrOm?=
 =?us-ascii?Q?YTJG6Zl5pAbMigrbH7hHi+M/YlZ6iyAt9bOjTz8qksHz/no8eSy7FB/WEzkU?=
 =?us-ascii?Q?/Jog2ByFH+fuWn1dj4cmweCUKK/EwuAdbxbiWz4U1FdUXjfTRIC8tTb2v2J0?=
 =?us-ascii?Q?+sfkBcFzt7ZaSOuX4vKztl1HaJZQP8JQP4mO/NXUJepAySPEfh58YgiF0x8e?=
 =?us-ascii?Q?9C0sx9SHu5cGvC5yF0M+6AJkdioXqUqUUyUZGZwzIRbHJ+d6ls328YR79Mcr?=
 =?us-ascii?Q?a7CmcEjzuRnMWJ9tQ7hxonAgLv8b0ueEGaFSpby1Hs+KPHebow9ONDrUwg9o?=
 =?us-ascii?Q?9MHmtiqyZhGAfCM0lgqcb4DxR7QrfAwQjiVsk5/9r/dIiSlo5RtQ9oOZhvBD?=
 =?us-ascii?Q?cI2rSNpVs1bvrZKhsfUUsTxHyXKkhq7JKrqccgytuOm2+M1R1roKxIWbEObn?=
 =?us-ascii?Q?Yh8Kqc3Ew8JUxQ6RhThtRlJTVo0hqORGXFsfW0/8u+4H/Cel7TCLgEPUFZYR?=
 =?us-ascii?Q?XwWY3MpRWsVgaa1q++Y37jvQC6W7rafm4003ew7j2OOXXFsscxBZB2LIEcjf?=
 =?us-ascii?Q?UOn+L01GjaCsdZAPXFEqSMwLdJQkNk0vNVWhEoH2IX7WlhxDryttGzH2gCwr?=
 =?us-ascii?Q?VkhYvKkGPi18AtMqT2lAGu85T9XoXBXesadTiIUNaKecUsmF0jD14XpcG51f?=
 =?us-ascii?Q?Xu0qrB5f3XlInmbzQKJSEFctmdIURMSCTQSiha4JvgGkKc+t1+NnTrJG47c7?=
 =?us-ascii?Q?E+TD3N+0Uf8np85F88hzjNGYxUdhNghHmHKLuYXelGG3t19THQuBvoR9vOBY?=
 =?us-ascii?Q?+tEFZq06sHMf78B2alzCYe920sZH71mkSAdGmxNITOYzz9NrUeEfUC8XRIBe?=
 =?us-ascii?Q?lW6kGNjYd1uI0kmTCWus4eraL3vcX91Auys3Qk7v+uyGJlP6fLJU/syOaiUy?=
 =?us-ascii?Q?siPAXGC0nEDYMkaH+KB0LyMVEhDoZ4Cq1wbQYfkgPckivH32rX3rKxAwsFj4?=
 =?us-ascii?Q?eoji8ENUEDMqJlvQGi090ZaNPM6Sq7nZUfKbGiJmYkPy9MuufL//ERxtxQZE?=
 =?us-ascii?Q?wYTQCvxmsz+XPG3Peu/TkkMv2q4sZGlNI0lsQnCwYDlH?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED786EB8CE7D4040B9B01FE74FB3FADB@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c163f6a9-1e4d-431e-f032-08daac84346c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 19:01:44.0936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d70LJ/ZN246gnmDp8RV1076CMdJlpBLsFHY/FUp3LmpwwIl+9Qg1XBMuyjUckvHByOBnVY269SjohosSpG3jOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4829
X-Proofpoint-GUID: rRWX7CqXcKlLQ1cEW5EUbDrAdzoXcamx
X-Proofpoint-ORIG-GUID: rRWX7CqXcKlLQ1cEW5EUbDrAdzoXcamx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 12, 2022, at 11:38 AM, Edgecombe, Rick P <rick.p.edgecombe@intel.com> wrote:
> 
> On Wed, 2022-10-12 at 05:37 +0000, Song Liu wrote:
>>> Then you have code that operates on module text like:
>>> if (is_vmalloc_or_module_addr(addr))
>>>       pfn = vmalloc_to_pfn(addr);
>>> 
>>> It looks like it would work (on x86 at least). Should it be
>>> expected
>>> to?
>>> 
>>> Especially after this patch, where there is memory that isn't even
>>> tracked by the original vmap_area trees, it is pretty much a
>>> separate
>>> allocator. So I think it might be nice to spell out which other
>>> vmalloc
>>> APIs work with these new functions since they are named "vmalloc".
>>> Maybe just say none of them do.
>> 
>> I guess it is fair to call this a separate allocator. Maybe 
>> vmalloc_exec is not the right name? I do think this is the best 
>> way to build an allocator with vmap tree logic. 
> 
> Yea, I don't know about the name. I think someone else suggested it
> specifically, right?

I think Luis suggested rename module_alloc to vmalloc_exec. But I 
guess we still need module_alloc for module data allocations. 

> 
> I had called mine perm_alloc() so it could also handle read-only and
> other permissions.

What are other permissions that we use? We can probably duplicate
the free_text_are_ tree logic for other cases. 


> If you keep vmalloc_exec() it needs some big
> comments about which APIs can work with it, and an audit of the
> existing code that works on module and JIT text.
> 
>> 
>>> 
>>> 
>>> Separate from that, I guess you are planning to make this limited
>>> to
>>> certain architectures? It might be better to put logic with
>>> assumptions
>>> about x86 boot time page table details inside arch/x86 somewhere.
>> 
>> Yes, the architecture need some text_poke mechanism to use this. 
> 
> It also depends on the space between _etext and the PMD aligned _etext
> to be present and not get used by anything else. For other
> architectures, there might be rodata there or other things.

Good point! We need to make sure this part is not used by other things.

> 
>> On BPF side, x86_64 calls this directly from arch code (jit engine), 
>> so it is mostly covered. For modules, we need to handle this better. 
> 
> That old RFC has some ideas around this. I kind of like your
> incremental approach though. To me it seems to be moving in the right
> direction.

Thanks!
Song
