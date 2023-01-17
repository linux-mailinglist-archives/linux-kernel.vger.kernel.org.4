Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C1A66E79D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjAQUSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbjAQUPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:15:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38A05AB77
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673982640; x=1705518640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wLeqRwfix5upOJ8heTWlhaudij/IQ4DsemO58k9YpS0=;
  b=JoqBl162xg3hyDzNbPPgc6b0WFkmrn5rHxDqQexqu+NALVielmZ7ko/q
   VvUdGkjvZ7hz9lPmOriaRiOl1/h6TByZyDQgzRNr96mSNvC+JOqnuO8ZH
   iskVa24IyMvyV2cF1DyZBuWyiq2pRdPS0ZjI6CVl945DwSpJrGTG6lidr
   0cHEY67E4ZcRQ8o/TJCT/vnSsNEtZgyqRH5/renznoL3MqP7mtm/00JE9
   2V75pYAIbGR/Ml4hYCSDLMtD+YmecRkXtm2y9dDo6uXjCk7TV3ev/WSG2
   6aGb5s+MULqM03+CuXLXMOlHi3zWDQPkC4HnE/pmHOL2LjxSUjVIsqvCz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304473907"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="304473907"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 11:10:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="833281396"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="833281396"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 17 Jan 2023 11:10:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 11:10:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 11:10:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 11:10:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9pU5F3pdO9G1a2vwUeOrwy6xqQsrt2irLUwff3YfWmjiGiA1AnOXpr+/ka97gR04T9/4pe9cdNkdvccT6kcIMSf0vfbIZ0Rg7ZWZT1/OQQRpBa3JSt7mEzbdXz0+sFaFZ3TUoNh9F3ZEs3uBAPMQVJIatBH8Hf2rfeW+Xrtcxd6mssVFi6ql32ziGvHZ4TwFb7LdLA+8mdGltM/mZBapWrFt0hWiDQh94jcdY3/BcSl6FTfrvmSIeqygKeUuJ7T/pPehmM5cj+yq7m18ZIAnsUqfFAYnmkMGYfUeVHjBXVTcn2ioXHa5o3ntHovrk/8dZrmKX4XxrclDpiMhqXO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30RyBu9rGJBwFJv06Sj2phRxl4nJVpXKns+0RK+QLco=;
 b=nWWweR3DOr9TEiIbvnQnJKlcE8zcB839Z8N5IkpLO+rnWOAXw95lRKtRmVc3/nkZ/DS6hSTVRUj0nab7qHroNkuMaGJgziMxN6NXfdgGvOLc8EIy62MCu9kD9nCGiIGm1MgTsx8XGUowOWpUojivSYjCP46IZsqjY7XVqEz2ThBFqi/8EDJWRAflZByCBvm4h2j0+qiOgE0OpADi6vEJ8HzG+DLzJ52Z5Ba8ddLwFfLIMxbm2vi5Kbvn9sqUgBC/1k6OduBmyhmvzVFnR+1EIUZnPMb9GL7SsJF4q/c+1LkdCe664RVu31UQ92WJZAlWC8lmSJ//t0+A0RerePKWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SJ0PR11MB6813.namprd11.prod.outlook.com (2603:10b6:a03:47f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 19:10:33 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%6]) with mapi id 15.20.5986.018; Tue, 17 Jan 2023
 19:10:33 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v2 07/18] x86/resctrl: Move CLOSID/RMID matching and
 setting to use helpers
Thread-Topic: [PATCH v2 07/18] x86/resctrl: Move CLOSID/RMID matching and
 setting to use helpers
Thread-Index: AQHZJ3hWN4ipqdgJc0urS68IeMbW+K6i/mIw
Date:   Tue, 17 Jan 2023 19:10:33 +0000
Message-ID: <IA1PR11MB6097186B7E9C2CF52A7F29C99BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-8-james.morse@arm.com>
In-Reply-To: <20230113175459.14825-8-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|SJ0PR11MB6813:EE_
x-ms-office365-filtering-correlation-id: a4bf543d-6768-4c30-5b19-08daf8be820e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KL+LFCH+svyDHOiPedRbY03qp8Wzu+VfUKxavthGJlB7LfeidIwIiQ+KAkVyjnI78nobR1KTrftXcO+M+TB8TJQqUK6E3wBPkE6tjMP1Jst0zoxIxbPPXokxhBMhpD3N3OerCkVuIDHkxlOOhZpNmKOGfdcy36ganfif10ySzVpiFMQBoxyVjlOFL3b4MB+wFmwSlev2ZZoxz2CrvCEEWpfYInBZinTGLzzmHYdlSLIyA1eCnS260AK9VEJZdWGbUNXKwPeM+knI8XIYt8w6VrwTsOw1q6eWo3W5BE9zNbfGQFKS6MqAhkMvHO94Eeu7WnKzSueCAAhRflkaPPagH7v68LnbJyky+q4rmIM4rGF8PqC7KuD4H0PiLN/SKiRAe5yTx/uerSqLbtN7ZldZCEZFGEIiFt2h0dHHvhxGam8MIfne9XBLxDExQZcsloPk19eFUAK+VhWkGWwYeHQOeKwN7ck+tv+w5IfYP7Woniih2wqyG+v+YT3aV5S1sZ9SPBJe19MvJIl20FKjFFtJd4y58KUuTWeMN8AjimBXSZ5I1ck8hKKC9gZXRvdjJJiQxyn0Wx9p+BicN7wjsGw+KaRjm0qD/WwwIu3SOkuxxjCVkEWh+7Sg01olegLGGDGe24Oa7fTupuSYQmQ399gKASQyK7lZfYNguQKvBsUChKs5q03OZl8+gCGwUpYjws2aYGmCjm+BPCVPli8ArfVVSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199015)(82960400001)(83380400001)(33656002)(122000001)(64756008)(86362001)(38070700005)(38100700002)(4326008)(2906002)(8676002)(5660300002)(7416002)(55016003)(8936002)(66446008)(66946007)(66556008)(66476007)(76116006)(52536014)(41300700001)(26005)(186003)(6506007)(9686003)(71200400001)(7696005)(110136005)(54906003)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sfh7snNLAnF4FcZylkN0ZdyXQuB5MXhzoHthu3t3zRKtADFSbEgf88tliI2J?=
 =?us-ascii?Q?j2Z+IDH5dtVkE01fcX1Bb79hlTKFmO6dQT7phiFpVOroGoyXVEU0vucQGFIi?=
 =?us-ascii?Q?rygpI0NaYSXiUFnEYYLvPb4jG4FsSqMbfdBFqiZDKh8JI0mQ42V1FIPP3HEc?=
 =?us-ascii?Q?w+aTqUijD4RXDX/m4+6nnevBqq5TSX09EJ/zbQ4DPHOZ6PZgxDx+Ijxjd0A7?=
 =?us-ascii?Q?WvbRANzWpMZaBk5JgEeT3jM1MgrIHaNlJB7VI6HePTdtcsKNYYpgYdcTI+Uj?=
 =?us-ascii?Q?JezOoybqkGA6Kv0zFSWLxxfgkMb6J+2QbM9Ss8KGqknm0ByYea7ke88w4wEs?=
 =?us-ascii?Q?ssv19pEInaYwK17smFIT5oAFsYUCdFITTa2B2LVwBdk4VGnaERwqiOBz9M2j?=
 =?us-ascii?Q?rRd+atbu8XQ1R0v9KRegHfe+QOcXz447+xjxjeRtpMdcIHvUS+gkR8l0z4QY?=
 =?us-ascii?Q?VNpNPNo0Fbaob/B77V4D1i2C36hzW9SHr5esvcEtXnX5/KqXEW8GBjNiStrz?=
 =?us-ascii?Q?sHL1qmKOgwU/OxhRGMUW2AWCR/1s9SdQ6R/s1clnjG9chqOeFnUUKzFxY1w8?=
 =?us-ascii?Q?V6d27pOC+1IoPa+HPddP/eBz4GEd/THpMdOERbjQW85KGIT0DJCIs8m1c0iy?=
 =?us-ascii?Q?TDxB4JRNrUg4VdCgCYbgJfbNORXy+s1TUNtwApJEX0girSC4CCJ+j5+V9iG8?=
 =?us-ascii?Q?gz/ajLIohX3eA9/RqNHjHcjpvoT/RkGQSWpmL6vfmxiRG4YIiw13B8irFc5t?=
 =?us-ascii?Q?JrF6oGTCFNynUQjLtCGfNtL4A7snChmwctSKc58yDHyWPwZqVdZ6J84fviSe?=
 =?us-ascii?Q?Ljn2vGmEbc0P83SzDJ/kSQA6MjLxYa04AmGDciT8Xs67EWS23iJG4MXm8+cX?=
 =?us-ascii?Q?Re6SjAhQf35I/H7vux0XjoKcRN88yMGS8RKaua1bkZVsLdMIihEdQH1qRzJx?=
 =?us-ascii?Q?NR+oGbmGHnRrOBaTCfLjAV3a/7FDm0CG3OIdguVZ77jYs6CMvKPpGMni2Af3?=
 =?us-ascii?Q?UgI5PD76ojnABu5LihMFly3eSrwiNmQXXdz73aCNEVFxMtaWUrx0pg5X5MHJ?=
 =?us-ascii?Q?KkNO9r1kny5wttzmPNP7HdsCG8Phi3NzW25R1YzS6Vf3gbWSUJXpkkctqScE?=
 =?us-ascii?Q?WUFUnibAKQB6Sm0d9kJ1dBbHUEipuQbiD70gFpl2zcz4Svy/h2NpsOv/STVs?=
 =?us-ascii?Q?gV4MO29lPC7u2dHFDBj1/CYMmKHwpaaRHEtupeT1X4PQKdOSujuaGXaVKJyq?=
 =?us-ascii?Q?K/3H1offGpZh6Ch/dQsSmI1MtgIIrcwFUUj9Txrh77qGhqhNIq+Y74BNORc/?=
 =?us-ascii?Q?t8k7k0qnmpg9ssTkbWwyLdYJ/EpcfPaCOqQh1nCX3ueiQtXuaQwsqUlb3QSk?=
 =?us-ascii?Q?Nu4Z8J8hn46Kys7wq2Of3FhcBDK/ho5pOCHzl7GcP7bfIIzGf2Fq4zHo8LF9?=
 =?us-ascii?Q?XT5LSrL3tl8ObRfTIZ9mqHHAfuZcSAKLTroUZsrj34nADBwD0N2IaFfKV8PO?=
 =?us-ascii?Q?KxqPkCa9cLatImK26vDJEwUjGAMfW6+PZA1QXyOnK+W0xIl5tkfxOTrmqPlg?=
 =?us-ascii?Q?OGcvjDQzw4krYNp0T7ClDR7S0GMyiY1YyiiUPM0K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bf543d-6768-4c30-5b19-08daf8be820e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 19:10:33.5487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klYI5JW9nGfXnenrpRhe52RigOjhYZTyHzsvGTZxS2ewjk/FVPUEX38e+nGDcg7+XRuRiD6aMJJjfLmm2bf/3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6813
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

> When switching tasks, the CLOSID and RMID that the new task should use ar=
e
> stored in struct task_struct. For x86 the CLOSID known by resctrl, the va=
lue in
> task_struct, and the value written to the CPU register are all the same t=
hing.
>=20
> MPAM's CPU interface has two different PARTID's one for data accesses the
> other for instruction fetch. Storing resctrl's CLOSID value in struct tas=
k_struct
> implies the arch code knows whether resctrl is using CDP.
>=20
> Move the matching and setting of the struct task_struct properties to use
> helpers. This allows arm64 to store the hardware format of the register, =
instead
> of having to convert it each time.
>=20
> __rdtgroup_move_task()s use of READ_ONCE()/WRITE_ONCE() ensures torn
> values aren't seen as another CPU may schedule the task being moved while=
 the
> value is being changed. MPAM has an additional corner-case here as the PM=
G
> bits extend the PARTID space. If the scheduler sees a new-CLOSID but old-=
RMID,
> the task will dirty an RMID that the limbo code is not watching causing a=
n
> inaccurate count. x86's RMID are independent values, so the limbo code wi=
ll still
> be watching the old-RMID in this circumstance.
> To avoid this, arm64 needs both the CLOSID/RMID WRITE_ONCE()d together.
> Both values must be provided together.
>=20
> Because MPAM's RMID values are not unique, the CLOSID must be provided
> when matching the RMID.
>=20
> CC: Valentin Schneider <vschneid@redhat.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/include/asm/resctrl.h         | 18 ++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 57 +++++++++++++++-----------
>  2 files changed, 51 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index 44d568f3577c..d589a82995ac 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -95,6 +95,24 @@ static inline unsigned int
> resctrl_arch_round_mon_val(unsigned int val)
>  	return val * scale;
>  }
>=20
> +static inline void resctrl_arch_set_closid_rmid(struct task_struct *tsk,
> +						u32 closid, u32 rmid)
> +{
> +	WRITE_ONCE(tsk->closid, closid);
> +	WRITE_ONCE(tsk->rmid, rmid);
> +}
> +
> +static inline bool resctrl_arch_match_closid(struct task_struct *tsk,
> +u32 closid) {
> +	return READ_ONCE(tsk->closid) =3D=3D closid; }
> +
> +static inline bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 =
ignored,
> +					   u32 rmid)
> +{
> +	return READ_ONCE(tsk->rmid) =3D=3D rmid;
> +}
> +
>  static inline void resctrl_sched_in(void)  {
>  	if (static_branch_likely(&rdt_enable_key))
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e1f879e13823..ced7400decae 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -84,7 +84,7 @@ void rdt_last_cmd_printf(const char *fmt, ...)
>   *
>   * Using a global CLOSID across all resources has some advantages and
>   * some drawbacks:
> - * + We can simply set "current->closid" to assign a task to a resource
> + * + We can simply set current's closid to assign a task to a resource
>   *   group.

Seems this change doesn't gain anything. Maybe this change can be removed?

>   * + Context switch code can avoid extra memory references deciding whic=
h
>   *   CLOSID to load into the PQR_ASSOC MSR
> @@ -549,14 +549,26 @@ static void update_task_closid_rmid(struct
> task_struct *t)
>  		_update_task_closid_rmid(t);
>  }
>=20
> +static bool task_in_rdtgroup(struct task_struct *tsk, struct rdtgroup
> +*rdtgrp) {
> +	u32 closid, rmid =3D rdtgrp->mon.rmid;
> +
> +	if (rdtgrp->type =3D=3D RDTCTRL_GROUP)
> +		closid =3D rdtgrp->closid;
> +	else if (rdtgrp->type =3D=3D RDTMON_GROUP)
> +		closid =3D rdtgrp->mon.parent->closid;
> +	else
> +		return false;
> +
> +	return resctrl_arch_match_closid(tsk, closid) &&
> +	       resctrl_arch_match_rmid(tsk, closid, rmid); }
> +
>  static int __rdtgroup_move_task(struct task_struct *tsk,
>  				struct rdtgroup *rdtgrp)
>  {
>  	/* If the task is already in rdtgrp, no need to move the task. */
> -	if ((rdtgrp->type =3D=3D RDTCTRL_GROUP && tsk->closid =3D=3D rdtgrp->cl=
osid
> &&
> -	     tsk->rmid =3D=3D rdtgrp->mon.rmid) ||
> -	    (rdtgrp->type =3D=3D RDTMON_GROUP && tsk->rmid =3D=3D rdtgrp-
> >mon.rmid &&
> -	     tsk->closid =3D=3D rdtgrp->mon.parent->closid))
> +	if (task_in_rdtgroup(tsk, rdtgrp))
>  		return 0;
>=20
>  	/*
> @@ -567,19 +579,14 @@ static int __rdtgroup_move_task(struct task_struct
> *tsk,
>  	 * For monitor groups, can move the tasks only from
>  	 * their parent CTRL group.
>  	 */
> -
> -	if (rdtgrp->type =3D=3D RDTCTRL_GROUP) {
> -		WRITE_ONCE(tsk->closid, rdtgrp->closid);
> -		WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
> -	} else if (rdtgrp->type =3D=3D RDTMON_GROUP) {
> -		if (rdtgrp->mon.parent->closid =3D=3D tsk->closid) {
> -			WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
> -		} else {
> -			rdt_last_cmd_puts("Can't move task to different
> control group\n");
> -			return -EINVAL;
> -		}
> +	if (rdtgrp->type =3D=3D RDTMON_GROUP &&
> +	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
> +		rdt_last_cmd_puts("Can't move task to different control
> group\n");
> +		return -EINVAL;
>  	}
>=20
> +	resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid, rdtgrp->mon.rmid);
> +
>  	/*
>  	 * Ensure the task's closid and rmid are written before determining if
>  	 * the task is current that will decide if it will be interrupted.
> @@ -599,14 +606,15 @@ static int __rdtgroup_move_task(struct task_struct
> *tsk,
>=20
>  static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)  =
{
> -	return (rdt_alloc_capable &&
> -	       (r->type =3D=3D RDTCTRL_GROUP) && (t->closid =3D=3D r->closid));
> +	return (rdt_alloc_capable && (r->type =3D=3D RDTCTRL_GROUP) &&
> +		resctrl_arch_match_closid(t, r->closid));
>  }
>=20
>  static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)  {
> -	return (rdt_mon_capable &&
> -	       (r->type =3D=3D RDTMON_GROUP) && (t->rmid =3D=3D r->mon.rmid));
> +	return (rdt_mon_capable && (r->type =3D=3D RDTMON_GROUP) &&
> +		resctrl_arch_match_rmid(t, r->mon.parent->closid,
> +					r->mon.rmid));
>  }
>=20
>  /**
> @@ -802,7 +810,7 @@ int proc_resctrl_show(struct seq_file *s, struct
> pid_namespace *ns,
>  		    rdtg->mode !=3D RDT_MODE_EXCLUSIVE)
>  			continue;
>=20
> -		if (rdtg->closid !=3D tsk->closid)
> +		if (!resctrl_arch_match_closid(tsk, rdtg->closid))
>  			continue;
>=20
>  		seq_printf(s, "res:%s%s\n", (rdtg =3D=3D &rdtgroup_default) ? "/" : ""=
,
> @@ -810,7 +818,8 @@ int proc_resctrl_show(struct seq_file *s, struct
> pid_namespace *ns,
>  		seq_puts(s, "mon:");
>  		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>  				    mon.crdtgrp_list) {
> -			if (tsk->rmid !=3D crg->mon.rmid)
> +			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent-
> >closid,
> +						     crg->mon.rmid))
>  				continue;
>  			seq_printf(s, "%s", crg->kn->name);
>  			break;
> @@ -2401,8 +2410,8 @@ static void rdt_move_group_tasks(struct rdtgroup
> *from, struct rdtgroup *to,
>  	for_each_process_thread(p, t) {
>  		if (!from || is_closid_match(t, from) ||
>  		    is_rmid_match(t, from)) {
> -			WRITE_ONCE(t->closid, to->closid);
> -			WRITE_ONCE(t->rmid, to->mon.rmid);
> +			resctrl_arch_set_closid_rmid(t, to->closid,
> +						     to->mon.rmid);
>=20
>  			/*
>  			 * If the task is on a CPU, set the CPU in the mask.
> --
> 2.30.2

Thanks.

-Fenghua
