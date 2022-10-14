Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68115FF38F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJNS0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJNS0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:26:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C7184990
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:26:08 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29EI5qtT002659
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:26:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=X+U8gYEfmnhc7wSL2icYh1kwRzCpQtAhVR82jFXeU9U=;
 b=bpvdlljimPFd2vHKMWO1vLq51Vf3mZqmqlAC2lLr9Bsq3C7zV18L6CCzcGlZLzU6BJdO
 nTal4dkC/aLQczmTRf9ONSVQ1E0wp4AAyhOmwWc8peLZD+nrBnqoF4tRx2PFXS3NxeZ3
 XUuHyK73Vl2eYcdYrl3AJ56PQr2vR4E676GM/+cW2hjEZJJjGKni7JiuIRj0Cy2cI7f7
 QEnsqdBh2Yrx82lVKVkaS+87CWd8CZJ5ooh0FKsxG8qRewfpeHrPKyAU8O2Yz6DuuoIP
 iYKg6i7g/7BKLRThPAGHLNXdraZhjXvAPaVBZB9G8s4AvN6TkvHN24AyqWGRPOdcVQRg jg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by m0089730.ppops.net (PPS) with ESMTPS id 3k70cue1qn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:26:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9s7vBV5q4+hf+7KlKyq9QGA6RbOegWq+M0o7hPxYxY3y1j6pQ6z33mZCE2IuD9UVkptM/DWyCcdugNX2S8JArAiJSRpOhwewY9iFImUJxvfPCzAZHNdgF86x9wAidJh3eTkRdPnGuou89Q0UfP0d4ivojEoi8HvCz388L13BM5si4SdR+NtMBuPhhkHSJPF8W9tnVUkC/vw+mo1B9n18MGGdXc12ISySH7zoV8PPffjit10HgadI1eYK6K1Xy6s9NBlez+qQ17Bg4FdwOUZXJzdFWjIJWRsJRivAFQQKintcmsjhXfXd+sHDhszzai73AoGjsvY75PHQwh34NR2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+U8gYEfmnhc7wSL2icYh1kwRzCpQtAhVR82jFXeU9U=;
 b=aMshVUI8Msp9+nXm64UwL5jOqB8KHiDnAhg7LbonA06mz5tpvCkKDZ8E6fjan1r8k0MpLwdq7Pg+X+etRdeVNGkMj3n5KrWjhX5bpz1nWR3HFwDxn0sXZeX86f51J7PzmKBx3KMb9r97mgsWCi3KJRbeQfQJIhYy8E6UFIG7ITpBxlnFWbUeKMfHdTTaM5k76YoXOuKDEtrM1x3O6ZB4Zy1et1ik1O18S4MKQnfG+oFbRPHTKl7XAzpVfpW/1LI0smId6ZT4TtAtDXpNBfw0W8Qng0QaCXuo/qfP4qhq0gz2a8tWgOc4Ul8YX56JeDBOj6mZ11bAuucgYhRKpfIUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BN7PR15MB2497.namprd15.prod.outlook.com (2603:10b6:406:86::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 18:26:04 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 18:26:04 +0000
From:   Song Liu <songliubraving@meta.com>
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
Subject: Re: [RFC v2 3/4] modules, x86: use vmalloc_exec for module core
Thread-Topic: [RFC v2 3/4] modules, x86: use vmalloc_exec for module core
Thread-Index: AQHY2qcNgpyftmWu6UK6OlojFXIGNa4OEceAgAAtwQA=
Date:   Fri, 14 Oct 2022 18:26:04 +0000
Message-ID: <7112B8B4-B593-45AA-A9AD-2ABEEE96223E@fb.com>
References: <20221007234315.2877365-1-song@kernel.org>
 <20221007234315.2877365-4-song@kernel.org>
 <fb7a38faa52ce0f35061473c9c8b56394a726e59.camel@intel.com>
In-Reply-To: <fb7a38faa52ce0f35061473c9c8b56394a726e59.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BN7PR15MB2497:EE_
x-ms-office365-filtering-correlation-id: 65dbec71-fcbf-49b2-d1ae-08daae118e1f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dq1Gqi8WAiNRHnvtitqprU5THQPISaCFcXMFNhgvwCHdvC9Xl38FI16BCA9bwDXTcIIF9+zWpGL0XfOLqGzKGRc8yY6QKkURX50hNeuCjNcagoajfYhhioQr+cgrxfK0TjL4S4oPSxYYWbKs2et6cx2MJGBr0sryOs7TgxKBaVANaEn0tUK9H+qBAXfVLxZ4rmPsww3jMSnCV57XmjN4Wo0zSz+HuXd14fTGHF9x4XEd1IvqWZLZ6bDbRfqqbvAFKOQNA3Uufhugwdl4Mtbugej/i/Rkkuaw0LueAEJ7f9f0C2LBaD45abGGJbiu4jvLiR3PIfb8Bkkp2/c12Jsqq7bLN53jPBnRIiKsqlkiyY5XZXYFsJPMKao23LBdIkDxD4r+OS26ysYWy6nSbe3J2ci+E8UbRWfFKusv02KWw1AhWaG4NfH7AZvYELiLlH7F49Ai0/EvbVTrM0z+uEycRxGrJ2LB2qKhypZ2fD9u0AENZwVxaBs+6Y1sLo/XpDoOmXwsYCK8M7mPrGERztEh2uM0Mpelenj5sL4VdKofEZeQxIAiU3X7Q0N+JxX9zgqB/VdTDR/XFtggL2dLI/i4YYh2P+g2FODL2cwq97K9XWYF6NlUFv6cBYZ8izQBe9eR3mV+tL+Fhle6bAPQLQlBhcU1jiwBRUx9TYvPQuuwisLdchh+K1fNuHVX7d0FZxTrbyG/Gd+EkpsSgpNrxormIC7Hs451Mu1MAVNTpllijKwkfQKa7ZwwPwXyw+0wfT08wFvtTnNBsA5okAC0f+plHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(6512007)(6916009)(54906003)(8936002)(9686003)(6486002)(478600001)(5660300002)(7416002)(66446008)(64756008)(316002)(91956017)(4326008)(66556008)(36756003)(8676002)(76116006)(66946007)(66476007)(186003)(71200400001)(33656002)(122000001)(41300700001)(38100700002)(53546011)(38070700005)(83380400001)(6506007)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kq/cshrpoSWvuLsBMoAOcBsNTl+bJlbPpiRbo+65pAYFiKcU15vtamu2RXVd?=
 =?us-ascii?Q?YNE/21sBuOUxi/RdtbW9cxusl9ChFwcXXwQ4a3mOM6DfNJqibP3PtsdxqGE8?=
 =?us-ascii?Q?hURX1MnJSH2MOqCc3b9yYqZHLUOJSi9I6FfMmLl9rR28PmVEJzP8TSCFb1an?=
 =?us-ascii?Q?xtp6TTYCqOD5Gj0PNznBmzKCyQawP1ZCxCrAT7PeAcmxFASj8gRwb4GpZnSb?=
 =?us-ascii?Q?Nai3UyLmPYSsAKv3/TBy+60/Q9N1kAC8rk/qVxMYg5VxvV5jNujYjeO/Ygds?=
 =?us-ascii?Q?Lxlqd4Jf01wB2i9FWFYFqnxjzmabk44mtwaiib1XU2AmT/JJFn7huXLhbmBw?=
 =?us-ascii?Q?I0PWVxNCT31ig1rWZjH4g47W6gb/AaY05noPxf+JXZr29bZ4sPXydQEaQ4op?=
 =?us-ascii?Q?04GfxPw/CHkpK5TASPwiuthZwugR8sz87UIpEd0eYqQnRH1Q4ncPOytvs8ob?=
 =?us-ascii?Q?w0y/yeb8rSUZd9XfuoKlDSUTbKkMgIdRJeJ9TvOC1VyCEq2HJTB0i/avX5DU?=
 =?us-ascii?Q?JQzc2dPXkPjJXGNmCoEc9Nm9CLS0im5VXPluByDfnXhTvne0gKjikMrEnJBR?=
 =?us-ascii?Q?3xQjGcGuGrUdgQCZIlhU+X/Vld4w1LQzhjf9PCbsehytW+WK3CcniorWIrP0?=
 =?us-ascii?Q?b5ua0twBzazRph1MPYGkgD1w47/eVVm2N+8WA+bNpBhy/YvFbqPw6V3hgLhC?=
 =?us-ascii?Q?IasTymbBcWOLo44ZX9upCly0xgz4cE9E4z9bRz8/AbYR5rIGyyoVyWQ5XFaM?=
 =?us-ascii?Q?gsEjrqDryCYahLAX6/mfo1PiKPKK8atdXpjPLjP+RxKQ7zTCnXORaUsBejru?=
 =?us-ascii?Q?i5rBXmDmj6s+aNRnqBfAebIFHXwMZQdzz5yYz5QHvWGqZLHjgWckGkbnYjCg?=
 =?us-ascii?Q?z/kIfH4Zbltg22rgLnO8Kz+GBpwfWyFiL1OalCR+RwxFeVqs2lvkjD7eWnIL?=
 =?us-ascii?Q?XVfwRK8lyU6hIPibu6wDWoIfilwKXXWfpDClRY7/lbXYsKMSuIsEb1Kb/jto?=
 =?us-ascii?Q?mhGsM/GBcuC2qzIt/Hp6xPYPzDyhfyT65t6cxW/FDRsb7/AxUr2JvnlB3KMN?=
 =?us-ascii?Q?f3CCrHPlbYQJfHInDsrW/qErSo7buj5jw1ZP53w3XymzqNrdUIqPlEE6YX3I?=
 =?us-ascii?Q?36eGHGFsRK5fhyuoKnJbPKcDtL8AMxgF2V+WeO6ph2rYj50UEf1v7FnJgXNR?=
 =?us-ascii?Q?naal3SXT3nCVkvqyKFLJJ+FK5rtMyk9XEdnxW5DASzx0SRNQyJeHijllr0ic?=
 =?us-ascii?Q?Twya5jeXsPQlcN7a4RsLu4daeg5kfpb3sEEYdqMHtweuZWlW2gABJ8XVTUUG?=
 =?us-ascii?Q?L9vLBahBgvijax+K4qbF7v9au660zSKMIoZ63+RDZGIDCBSvgY9FV3XLnZwZ?=
 =?us-ascii?Q?DVlK2AIaAcWsTRmkO0UyBDgzYUWZZrbAa37k1fnZpEmezvhFE80hvQcdaLPr?=
 =?us-ascii?Q?znBwX5qbhOm+MEgQCuEPwdO7QfBO6v0Hgjaiz+2DkEarl6GkM8k7JpDg9H7Z?=
 =?us-ascii?Q?6sEALv5xS61vmtaUKQvaxJyS1z81xnJeJmPw93fau+1zz+mwhPeRPMPIZbRY?=
 =?us-ascii?Q?50wGK+oWIdMTXc26GlFKZUv+5P2dcS/ynjar379k6CBcrVjXw1Op6D4smIOb?=
 =?us-ascii?Q?L99RAWxVaRhQ7eRP6fS8f39aQkJDhxFe8cUCYzuhSBp+?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <989E48E96AE1A847882E6CE55A36BDB9@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dbec71-fcbf-49b2-d1ae-08daae118e1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 18:26:04.8004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJm+aYQrPkWgRa3A7BSVkjWlbUFcXoyQoYJynXj0/SnM3GsqlYLuYLQJwueN0hxST4dR9qcDPpIXAoYQ6PEMBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2497
X-Proofpoint-GUID: 6BANMEmfaO-c8DhbXCYYPsNXLSpRXCI7
X-Proofpoint-ORIG-GUID: 6BANMEmfaO-c8DhbXCYYPsNXLSpRXCI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_09,2022-10-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 14, 2022, at 8:42 AM, Edgecombe, Rick P <rick.p.edgecombe@intel.com> wrote:
> 
> On Fri, 2022-10-07 at 16:43 -0700, Song Liu wrote:
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index a4e4d84b6f4e..b44806e31a56 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -53,6 +53,7 @@
>> #include <linux/bsearch.h>
>> #include <linux/dynamic_debug.h>
>> #include <linux/audit.h>
>> +#include <linux/bpf.h>
>> #include <uapi/linux/module.h>
>> #include "internal.h"
>> 
>> @@ -1203,7 +1204,7 @@ static void free_module(struct module *mod)
>>        lockdep_free_key_range(mod->data_layout.base, mod-
>>> data_layout.size);
>> 
>>        /* Finally, free the core (containing the module structure)
>> */
>> -       module_memfree(mod->core_layout.base);
>> +       vfree_exec(mod->core_layout.base);
>> #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
>>        vfree(mod->data_layout.base);
>> #endif
>> @@ -1321,7 +1322,8 @@ static int simplify_symbols(struct module *mod,
>> const struct load_info *info)
>>                        ksym = resolve_symbol_wait(mod, info, name);
>>                        /* Ok if resolved.  */
>>                        if (ksym && !IS_ERR(ksym)) {
>> -                               sym[i].st_value =
>> kernel_symbol_value(ksym);
>> +                               unsigned long val =
>> kernel_symbol_value(ksym);
>> +                               bpf_arch_text_copy(&sym[i].st_value,
>> &val, sizeof(val));
> 
> Why bpf_arch_text_copy()? This of course won't work for other
> architectures. So there needs to be fallback method. That RFC broke the
> operation into two stages: Loading and finalized. When loading, on non-
> x86 the writes would simply be to the allocation mapped as writable.
> When it was finalized it changed it to it's final permission (RO, etc).
> Then for x86 it does text_pokes() for the writes and has it RO from the
> beginning.

Yeah, this one (3/4) is really a prototype to show vmalloc_exec could 
work for modules (with a lot more work of course). And something to
replace bpf_arch_text_copy() is one of the issues we need to address in
the future. 

> 
> I ended up needing a staging buffer for modules too, so that the code
> could operate on it directly. I can't remember why that was, it might
> be unneeded now since you moved data out of the core allocation.

Both bpf_jit and bpf_dispather uses a staging buffer with bpf_prog_pack. 
The benefit of this approach is that it minimizes the number of 
text_poke/copy() calls. OTOH, it is quite a pain to make all the 
relative calls correct, as the staging buffer has different address to 
the final allocation. 

I think we may not need the staging buffer for modules, as module 
load/unload happens less often than BPF program JITs (so it is ok for 
it to be slightly slower). 

btw: I cannot take credit for split module data out of core allocation,
Christophe Leroy did the work. :)

Thanks,
Song
