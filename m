Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1666E6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjAQTYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjAQTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:14:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE543D937
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673980139; x=1705516139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PV5Eo7bTt9f61qcydZl9et0sIQMPipFpYM0DRTC4uwk=;
  b=mP1iH+wB2p6FJOVdQ6FQ6tLWJby4Mc60yKEvWEASozBOA2kR6d0TEFgC
   3+rmgdgRptdxxv8OfY6tNAkyd9CCuFHhQq2Svc5PJDgZ2DUbqRSarXHf6
   b4IEYVSvw9gO4uDHrzkKwe4Y5n+uXCjzEfKSvWR+/LHq62cvDgXp8Dqcx
   5Pt63QHXv3Kxr52UM/m1QW3agI9Z36qvagNuZnppadgQkNsK/KpnxMOom
   CqqOMvRMcR1eqMEafCgFfvhF145FnnODLhdaMUEVsyklZNrKKLpzHscqt
   r/m59gigfGsc5rALMws9mJNifGweXy/iM7wLnWsCXZWbww0XNUC+KMKD+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="326851771"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326851771"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:28:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="748134811"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="748134811"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jan 2023 10:28:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 10:28:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 10:28:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 10:28:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3jjLYfovhaJIFoW4RBo7jyb24bqEQbd0x4QKI3fQd7X0jamsjIP/Emism0pBaEkiXYbYawm4ExouPe4aM7TQmKCiRpH2Psxa7XdZFElKV6IytroBmDMviT+ppR684ceguyEnO6kAXy616nT+jtwHpHcTyVYN5Uy2AlNbjZpwpLPl3Pze7PEVfxMT3OTKxbnSWfSIlX0eS/ZO9Hh6xn5CM/s/1KX+z4o0+HxiG2FMU+1wUBluqjlgiSmF++Zgc35OTVIiHNSn3+JL6ZTIHf2nqjdptvqDpkepx7MXolQlgbZNN6SWeRqeVFcF1j3mwp/z8QXxayTx35f71EgshoJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vMMkqeZWM2ifp/EKdgZbDr8DqyeMfyTKiMYR000s+U=;
 b=JpdtsgSmFL67xm7HzqT7uxcC9Fpp5dqyUTtfHzCDo5UO0GJCb1RhE42ecT3EJC46+7P53K3APvDXQAcSFLlpPtPbLTGfXiIPboZzdxOxM57NSnslOxhkgAnjDU9yaGVfLaX0cO5ci8Bonssrm13AgjhLlD6MObx7bN6C80EN9Mu6vbyKSHFxWrYCjWiVJqNnAH/1M4Yhh1GQbF49M81r2SeYRhVN8EGwdw7s533DvZfgJao5tJYUscTEwmyibfoSWrh01Dp4TFNIZLINrTniya3keRGgnwbRvyI0prnSxahcImjgObHjP4YWkahoUCA7sh9WkGOEwGpvPoxgUy5tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB7541.namprd11.prod.outlook.com (2603:10b6:510:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 18:28:45 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%6]) with mapi id 15.20.5986.018; Tue, 17 Jan 2023
 18:28:44 +0000
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
Subject: RE: [PATCH v2 02/18] x86/resctrl: Access per-rmid structures by index
Thread-Topic: [PATCH v2 02/18] x86/resctrl: Access per-rmid structures by
 index
Thread-Index: AQHZJ3hM+VcWIzEppUSZYtjY9I+xpa6hG7Rg
Date:   Tue, 17 Jan 2023 18:28:44 +0000
Message-ID: <IA1PR11MB60979C2E98EA36A279BF9C119BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-3-james.morse@arm.com>
In-Reply-To: <20230113175459.14825-3-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|PH0PR11MB7541:EE_
x-ms-office365-filtering-correlation-id: 87346b15-9fb6-4040-066d-08daf8b8aa75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2C63r1h4o7q7SatoGWU0HOCBGQo7yXkRv9Vo9ReuL1MfK76Z9morfCTvJJQDkXiAY6gmXk4bXcINOzA82NdOyUBPPnWMrKJE9nrkpC6Hwlu+WwXNiSEBffKxUJQ6rYJ4JhpcugXvXmRQf5/DeerDTQ+lkDeMewBJoIUwWSuvpgoPlnGA9F2DmnYqxuqXU2WIyr+IUPjiOA1gxbjHjbPs9ln//fHlSywCIKWUtvxNpGaBldzJY7qYuER6/LiCr3fEndSWoY3Lu+M2c/3dhpFDUIF1qdoeO6408ZQSVFHy3LZDnh2OohcG2R4QifzXgLTYTQ8r4+UZiOuFxDvTULNuQ0JNznlu9k1HnGE7N/4JGQkeT09vsatjkj3irGJ+VPEeA5r0gbTAHnkVjUNtV6gPQpL7agPQbGytDoV9iBbVtFD6r7QXvyPht1Nnr6wFt16ZupH/mYPY5xKl+7r8SLEEC6Wwh0jU39a85a9Vp9kJ66XU7Hix3128/wVEJR6f6S3b80z82Hs9qMXY/X2Bw1LtfOVVaa5fSkhdTQ1FyjDm6oqRn+sWaotW/ZNmOSpxVzJI7NzTGhW7JAD00frVAfVZTJ2mH2K3WDegNGCmrIDbBT4jrVEUg5CZIViR5NEpwmuI1c9WB+XqJKEGo+RX26YEODQ5JFZGCSO9pn4HLWFBW5Mll5MDGX/tjxen4YcyGqJurFvZLppwAXA2I1u66hhDOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(83380400001)(55016003)(86362001)(7416002)(38070700005)(52536014)(122000001)(82960400001)(30864003)(2906002)(5660300002)(8936002)(38100700002)(316002)(8676002)(478600001)(6506007)(66476007)(9686003)(71200400001)(26005)(186003)(64756008)(66556008)(7696005)(76116006)(66446008)(4326008)(66946007)(110136005)(54906003)(41300700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2H3X1uP+kbp6R9BNePf97qIZatdYkN16xcRCgrf5h321YLoI/hRkavoPVnD9?=
 =?us-ascii?Q?xJ+qYbkBUT1jpl7KWBxiuyBVf+tEewYk1zf+Ett/4/aH7RE0UXwzkhI6wEy3?=
 =?us-ascii?Q?QJZpe+7BRvthmcz+/oubfN3zsKni16h5JYX0HGVffmnhf8CcSb5CdrgUplNg?=
 =?us-ascii?Q?0QhenROmyvt4ZjGlC6qkBeU5Mw9oNLLytuMzC7Z/ZYWwBnkCfD6H9YHZvHzg?=
 =?us-ascii?Q?vUgBcNX7pyC6TcRJjQHVAsqpczx9B9bOVoXrpWF+93jTMG1gem2uYyX8a6dE?=
 =?us-ascii?Q?9QjbfUtCJhBThCwv5lhSl2Lx1x2crGOfW+NJCRzaP36i2rdjUcFBAyi9zJSN?=
 =?us-ascii?Q?4B90Brbbf7CEDHVAwktCkEE2/BgMMsWjf27QtO338gzyQacelN+HbNCwLloY?=
 =?us-ascii?Q?A1VcQNCQnZvgMYkwQLu+5WnmLSznFeK9r9ibRxfMSxyM6XZ+D9VVgp0ekvmH?=
 =?us-ascii?Q?vpsZ55XwYmJu7/TM/RDbN4JoBeTNHUNgD1yDAIUx1Bn7+ztXROJqallJepiB?=
 =?us-ascii?Q?Z+betGIyD1/+EGzjKECuDIHbBOAZncp3CUmQMK9/VDkunXLBAXUuYy+fibZs?=
 =?us-ascii?Q?ywI3obzs2sY9ggLvYUZp5WOxne5C3nWeY7JSktBE2G7kgQTOFANDiR9JNL9e?=
 =?us-ascii?Q?DsPYeZzKgAoYsqKxc+553z/VLN3VgjQVj3UOfaesOKWQFAV7MVh1HjnnlmZU?=
 =?us-ascii?Q?y4lLKsm1Mk32g2oyCz5QsA8Ic+oAuRa7uy/Dj86LGkRnb9hnQuiRGE/NQYND?=
 =?us-ascii?Q?UDZXo+/ArCYkJ94r2AJ8L3f1HG4McpPHgIwppnhU2Avwmrfm8E03pa4xXYZY?=
 =?us-ascii?Q?NjPMziMExSXQ9w+G5s7lz8/AE3sEQnG/5Mc1ww4uNOTAcIkxJtZAABUz4OqW?=
 =?us-ascii?Q?QSxXgf3z5WMoLmIvpu79ni/BTr3s26ymj3tmKXDnIPXF1F5/aOg5FGlVudan?=
 =?us-ascii?Q?BKRQFyvkEUXE3uJzKmdxruHrIKogvydk3FEysBLDkQyphCEbkmjF/q4nz/ty?=
 =?us-ascii?Q?yAnqzgkmlnV8tNPe4FLKJe3xN/zjAh71bo4T021ewxmhAsN0nHvFpB8EfzWl?=
 =?us-ascii?Q?caYvz92DzoPZ///ujYkY71F5LeTYxVeiYXl8YEzd6JAWGVttGX5yXvjlOY+i?=
 =?us-ascii?Q?c2eFiz3JVO80N31myXZvUL6pfdedBmr90tYVtNhKWX3E+/PVRmGghGS6V4Bf?=
 =?us-ascii?Q?VTjXY5F8Vryu5j9hXbbHtUax8Cz+Mywqkx8pyYSf6z/EVROqXB4Hy/qcuOeC?=
 =?us-ascii?Q?ZBHtFwLOK5Qrxn2Xk0sSTpINwMWkIgmWhIfDAOWx/QfpcNh8zBRVrmdqTj5z?=
 =?us-ascii?Q?jXenyJ+UKUqnW/fBQkdZEZBp/bEmf+Tw6FnvEMSXH+pibErqa+tRo1IzFnnq?=
 =?us-ascii?Q?riaY0qFjIEM9hMzEAX4hfTk0V0JA0PGIPCKk5LYZHs7iOvFGqiJrgCfunoaj?=
 =?us-ascii?Q?RWFDuUc8iOC5ireYFq2vmB017nJOIRNPYUG5Qd2BWzXIRRPBa9ZEXv8c6WZE?=
 =?us-ascii?Q?EZ7q27x7QKd8Jk2X90Bge+biEyUo9JIOCQ+FXZpQ2ipxy4Uu/zUsZ7q1PFgc?=
 =?us-ascii?Q?g97cqdElXM85uHXWULtbkVexLmG3x7AmgiDxtBhp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87346b15-9fb6-4040-066d-08daf8b8aa75
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 18:28:44.3332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZ/rTocVYCXNcN00eLWEOcO898cycZop5l8bW/8wvzJRJAyEXirpPxYLofCmTcQ3b6KtGy5Dbkpl+0uwZMdHyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

> Because of the differences between Intel RDT/AMD QoS and Arm's MPAM
> monitors, RMID values on arm64 are not unique unless the CLOSID is also
> included. Bitmaps like rmid_busy_llc need to be sized by the number of un=
ique
> entries for this resource.
>=20
> Add helpers to encode/decode the CLOSID and RMID to an index. The domain'=
s
> busy_rmid_llc and the rmid_ptrs[] array are then sized by index. On x86, =
this is
> always just the RMID. This gives resctrl a unique value it can use to sto=
re
> monitor values, and allows MPAM to decode the closid when reading the
> hardware counters.
>=20
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Added X86_BAD_CLOSID macro to make it clear what this value means
>  * Added second WARN_ON() for closid checking, and made both _ONCE()
> ---
>  arch/x86/include/asm/resctrl.h         | 24 ++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
> arch/x86/kernel/cpu/resctrl/monitor.c  | 79 +++++++++++++++++---------
> arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 ++-
>  4 files changed, 82 insertions(+), 30 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index 52788f79786f..44d568f3577c 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -7,6 +7,13 @@
>  #include <linux/sched.h>
>  #include <linux/jump_label.h>
>=20
> +/*
> + * This value can never be a valid CLOSID, and is used when mapping a
> + * (closid, rmid) pair to an index and back. On x86 only the RMID is
> + * needed.
> + */
> +#define X86_RESCTRL_BAD_CLOSID		~0
> +
>  /**
>   * struct resctrl_pqr_state - State cache for the PQR MSR
>   * @cur_rmid:		The cached Resource Monitoring ID
> @@ -94,6 +101,23 @@ static inline void resctrl_sched_in(void)
>  		__resctrl_sched_in();
>  }
>=20
> +static inline u32 resctrl_arch_system_num_rmid_idx(void)
> +{
> +	/* RMID are independent numbers for x86. num_rmid_idx=3D=3Dnum_rmid
> */

Is it better to change the comment to something like:
+       /* RMIDs are independent of CLOSIDs and number of RMIDs is fixed. *=
/

> +	return boot_cpu_data.x86_cache_max_rmid + 1; }
> +
> +static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid,
> +u32 *rmid) {
> +	*rmid =3D idx;
> +	*closid =3D X86_RESCTRL_BAD_CLOSID;
> +}
> +
> +static inline u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid) {
> +	return rmid;
> +}
> +
>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>=20
>  #else
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5dbff3035723..af71401c57e2 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -8,6 +8,8 @@
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
>=20
Please remove this blank line.

> +#include <asm/resctrl.h>
> +
>  #define L3_QOS_CDP_ENABLE		0x01ULL
>=20
>  #define L2_QOS_CDP_ENABLE		0x01ULL
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 13673cab175a..dbae380e3d1c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -142,12 +142,27 @@ static inline u64 get_corrected_mbm_count(u32 rmid,
> unsigned long val)
>  	return val;
>  }
>=20
> -static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
> +/*
> + * x86 and arm64 differ in their handling of monitoring.
> + * x86's RMID are an independent number, there is one RMID '1'.
What do you mean by "one RMID '1'"?
Should this sentence be "x86's RMID is an independent number."?

> + * arm64's PMG extend the PARTID/CLOSID space, there is one RMID '1'
> +for each
> + * CLOSID. The RMID is no longer unique.
> + * To account for this, resctrl uses an index. On x86 this is just the
> +RMID,
> + * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
> + *
> + * The domain's rmid_busy_llc and rmid_ptrs are sized by index. The
> +arch code
> + * must accept an attempt to read every index.
> + */
> +static inline struct rmid_entry *__rmid_entry(u32 idx)
>  {
>  	struct rmid_entry *entry;
> +	u32 closid, rmid;
>=20
> -	entry =3D &rmid_ptrs[rmid];
> -	WARN_ON(entry->rmid !=3D rmid);
> +	entry =3D &rmid_ptrs[idx];
> +	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
> +
> +	WARN_ON_ONCE(entry->closid !=3D closid);
> +	WARN_ON_ONCE(entry->rmid !=3D rmid);
>=20
>  	return entry;
>  }
> @@ -243,8 +258,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, st=
ruct
> rdt_domain *d,  void __check_limbo(struct rdt_domain *d, bool force_free)=
  {
>  	struct rdt_resource *r =3D
> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
> -	u32 crmid =3D 1, nrmid;
> +	u32 idx, cur_idx =3D 1;
>  	bool rmid_dirty;
>  	u64 val =3D 0;
>=20
> @@ -255,12 +271,11 @@ void __check_limbo(struct rdt_domain *d, bool
> force_free)
>  	 * RMID and move it to the free list when the counter reaches 0.
>  	 */
>  	for (;;) {
> -		nrmid =3D find_next_bit(d->rmid_busy_llc, r->num_rmid, crmid);
> -		if (nrmid >=3D r->num_rmid)
> +		idx =3D find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
> +		if (idx >=3D idx_limit)
>  			break;
>=20
> -		entry =3D __rmid_entry(~0, nrmid);	// temporary
> -
> +		entry =3D __rmid_entry(idx);
>  		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
>  					   QOS_L3_OCCUP_EVENT_ID, &val)) {
>  			rmid_dirty =3D true;
> @@ -269,19 +284,21 @@ void __check_limbo(struct rdt_domain *d, bool
> force_free)
>  		}
>=20
>  		if (force_free || !rmid_dirty) {
> -			clear_bit(entry->rmid, d->rmid_busy_llc);
> +			clear_bit(idx, d->rmid_busy_llc);
>  			if (!--entry->busy) {
>  				rmid_limbo_count--;
>  				list_add_tail(&entry->list, &rmid_free_lru);
>  			}
>  		}
> -		crmid =3D nrmid + 1;
> +		cur_idx =3D idx + 1;
>  	}
>  }
>=20
>  bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)  {
> -	return find_first_bit(d->rmid_busy_llc, r->num_rmid) !=3D r->num_rmid;
> +	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
> +
> +	return find_first_bit(d->rmid_busy_llc, idx_limit) !=3D idx_limit;
>  }
>=20
>  /*
> @@ -311,6 +328,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entr=
y)
>  	struct rdt_domain *d;
>  	int cpu, err;
>  	u64 val =3D 0;
> +	u32 idx;
> +
> +	idx =3D resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>=20
>  	entry->busy =3D 0;
>  	cpu =3D get_cpu();
> @@ -330,7 +350,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entr=
y)
>  		 */
>  		if (!has_busy_rmid(r, d))
>  			cqm_setup_limbo_handler(d,
> CQM_LIMBOCHECK_INTERVAL);
> -		set_bit(entry->rmid, d->rmid_busy_llc);
> +		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
>  	put_cpu();
> @@ -343,14 +363,16 @@ static void add_rmid_to_limbo(struct rmid_entry
> *entry)
>=20
>  void free_rmid(u32 closid, u32 rmid)
>  {
> +	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
>  	struct rmid_entry *entry;
>=20
> -	if (!rmid)
> -		return;
> -
>  	lockdep_assert_held(&rdtgroup_mutex);
>=20
> -	entry =3D __rmid_entry(closid, rmid);
> +	/* do not allow the default rmid to be free'd */
> +	if (!idx)
> +		return;
> +
> +	entry =3D __rmid_entry(idx);
>=20
>  	if (is_llc_occupancy_enabled())
>  		add_rmid_to_limbo(entry);
> @@ -360,6 +382,7 @@ void free_rmid(u32 closid, u32 rmid)
>=20
>  static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)=
  {
> +	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
>  	struct mbm_state *m;
>  	u64 tval =3D 0;
>=20
> @@ -376,10 +399,10 @@ static int __mon_event_count(u32 closid, u32 rmid,
> struct rmid_read *rr)
>  		rr->val +=3D tval;
>  		return 0;
>  	case QOS_L3_MBM_TOTAL_EVENT_ID:
> -		m =3D &rr->d->mbm_total[rmid];
> +		m =3D &rr->d->mbm_total[idx];
>  		break;
>  	case QOS_L3_MBM_LOCAL_EVENT_ID:
> -		m =3D &rr->d->mbm_local[rmid];
> +		m =3D &rr->d->mbm_local[idx];
>  		break;
>  	default:
>  		/*
> @@ -412,7 +435,8 @@ static int __mon_event_count(u32 closid, u32 rmid,
> struct rmid_read *rr)
>   */
>  static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)  {
> -	struct mbm_state *m =3D &rr->d->mbm_local[rmid];
> +	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
> +	struct mbm_state *m =3D &rr->d->mbm_local[idx];
>  	u64 cur_bw, bytes, cur_bytes;
>=20
>  	cur_bytes =3D rr->val;
> @@ -502,7 +526,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, stru=
ct
> rdt_domain *dom_mbm)  {
>  	u32 closid, rmid, cur_msr_val, new_msr_val;
>  	struct mbm_state *pmbm_data, *cmbm_data;
> -	u32 cur_bw, delta_bw, user_bw;
> +	u32 cur_bw, delta_bw, user_bw, idx;
>  	struct rdt_resource *r_mba;
>  	struct rdt_domain *dom_mba;
>  	struct list_head *head;
> @@ -515,7 +539,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, stru=
ct
> rdt_domain *dom_mbm)
>=20
>  	closid =3D rgrp->closid;
>  	rmid =3D rgrp->mon.rmid;
> -	pmbm_data =3D &dom_mbm->mbm_local[rmid];
> +	idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
> +	pmbm_data =3D &dom_mbm->mbm_local[idx];
>=20
>  	dom_mba =3D get_domain_from_cpu(smp_processor_id(), r_mba);
>  	if (!dom_mba) {
> @@ -698,19 +723,19 @@ void mbm_setup_overflow_handler(struct
> rdt_domain *dom, unsigned long delay_ms)
>=20
>  static int dom_data_init(struct rdt_resource *r)  {
> +	u32 nr_idx =3D resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry =3D NULL;
> -	int i, nr_rmids;
> +	int i;
>=20
> -	nr_rmids =3D r->num_rmid;
> -	rmid_ptrs =3D kcalloc(nr_rmids, sizeof(struct rmid_entry), GFP_KERNEL);
> +	rmid_ptrs =3D kcalloc(nr_idx, sizeof(struct rmid_entry), GFP_KERNEL);
>  	if (!rmid_ptrs)
>  		return -ENOMEM;
>=20
> -	for (i =3D 0; i < nr_rmids; i++) {
> +	for (i =3D 0; i < nr_idx; i++) {
>  		entry =3D &rmid_ptrs[i];
>  		INIT_LIST_HEAD(&entry->list);
>=20
> -		entry->rmid =3D i;
> +		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
>  		list_add_tail(&entry->list, &rmid_free_lru);
>  	}
>=20
> @@ -719,7 +744,7 @@ static int dom_data_init(struct rdt_resource *r)
>  	 * default_rdtgroup control group, which will be setup later. See
>  	 * rdtgroup_setup_root().
>  	 */
> -	entry =3D __rmid_entry(0, 0);
> +	entry =3D __rmid_entry(resctrl_arch_rmid_idx_encode(0, 0));

Better change to:
+	entry =3D __rmid_entry(resctrl_arch_rmid_idx_encode(RESCTRL_BAD_CLOSID, 0=
));
because this explicitly tells CLOSID is invalid here on X86.

>  	list_del(&entry->list);
>=20
>  	return 0;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f3b739c52e42..9ce4746778f4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3320,16 +3320,17 @@ void resctrl_offline_domain(struct rdt_resource *=
r,
> struct rdt_domain *d)
>=20
>  static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_dom=
ain
> *d)  {
> +	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
>  	size_t tsize;
>=20
>  	if (is_llc_occupancy_enabled()) {
> -		d->rmid_busy_llc =3D bitmap_zalloc(r->num_rmid, GFP_KERNEL);
> +		d->rmid_busy_llc =3D bitmap_zalloc(idx_limit, GFP_KERNEL);
>  		if (!d->rmid_busy_llc)
>  			return -ENOMEM;
>  	}
>  	if (is_mbm_total_enabled()) {
>  		tsize =3D sizeof(*d->mbm_total);
> -		d->mbm_total =3D kcalloc(r->num_rmid, tsize, GFP_KERNEL);
> +		d->mbm_total =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
>  		if (!d->mbm_total) {
>  			bitmap_free(d->rmid_busy_llc);
>  			return -ENOMEM;
> @@ -3337,7 +3338,7 @@ static int domain_setup_mon_state(struct
> rdt_resource *r, struct rdt_domain *d)
>  	}
>  	if (is_mbm_local_enabled()) {
>  		tsize =3D sizeof(*d->mbm_local);
> -		d->mbm_local =3D kcalloc(r->num_rmid, tsize, GFP_KERNEL);
> +		d->mbm_local =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
>  		if (!d->mbm_local) {
>  			bitmap_free(d->rmid_busy_llc);
>  			kfree(d->mbm_total);
> --
> 2.30.2

Thanks.

-Fenghua
