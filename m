Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525C3648C7F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 03:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLJCS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 21:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLJCSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 21:18:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281C60FD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 18:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670638702; x=1702174702;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N4Fouu/iNAPFaLdu2ez2/EG8D1qAVdTu6089stHfWPw=;
  b=nS4PvaUUyEnySPQIV2QxhgzYag0o0qRv0c6L5FQcCqxydAw5nCsIGOSC
   sIZ/mtA5nCgrO4cLnysFhqKDtKm3ZMkZlon9G7yWmPUJXRnuLVL1Y/pu5
   hmElYKzRAvSfw6unymGnxmy5wHYDthL1/xxzib/b0Y54+N9jmjDchJJ78
   peIRPKNLtPBKVGDEooqPRUt62fds7+PsdLfyklxqxCfkmdbG/bDsy0+bx
   mOZj2luBRt2nySOwD6sTaP4143wBxO3BaMTtjIMzVbWlQdokRtuHui8Lz
   9IiUpkCXUr6Jkw3IcdgdGxOSZ4ONw6LIU0jhlHR+OuwvgZZjjaxpGntRU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="301007879"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="301007879"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 18:18:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="680114911"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="680114911"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2022 18:18:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 18:18:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 18:18:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 18:18:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNaGlsZYcya5yxRguURebf6KqhwHDxwxU+/UV33nfxuDE+HmFoAVK2yuGAzGEyHXDLn3lttibCDIQ87YGfmRQSzQw6HJuIJmd9Ezoi3qb1OKp5Rfmt6awHpgV9xkJ3TWqQGi09oq6LyS8Z6UH0pGC1hJLv/QL1OxL9ZpdbOTHYOetHEQAPqOfGH46aLUJnUnD6Rut7SN+pCZQbAN4hqno8yLUNezoL1v/UwS/QzYKpFfOv92ieygFKUNlZYF35pPpjK2DRTfRmmMmamRr94y/Jrt8XprRrMME/bht73m47BV9QBzkI5IRbtW5wOJPWxNJcpxY7Ee04pBFuYTvEWGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuViWDH1Q+oT5xQcQONimH8ES1LCeCrVpUoqheXBS00=;
 b=PnfsWIMOpA7YDKYQ1NdYa57HtHju6z5Y4Pswr+2ltLsSEs7mbvZuku5nUCwfnjBVrlZAktkniiwq3ittthusgeuMwHF2WKrSfZ0scV374nC1DnLzk5tMVP2momV4fhn3PYN0QxY6Gt9ut2osuV/2YU4hUrdhXbABUNdo7fY0RA448ErBJxiOuWX69x3UzTm0Nre0FcGgpixCMLFiYepX0IEiLAmRyfV+YkKEUif5fT/+UI2NJjsNz2odft4JoNG6CGUqwBoaFl6uh2c06gTRQSjh7eRD5lbvqKbmsjenaVcTBjIxozWjwVh1MCwWoHogQ6A25a2HYOaVcCjdOyQY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BN9PR11MB5419.namprd11.prod.outlook.com (2603:10b6:408:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Sat, 10 Dec
 2022 02:18:19 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%9]) with mapi id 15.20.5880.014; Sat, 10 Dec 2022
 02:18:18 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Shawn Wang <shawnwang@linux.alibaba.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jamie@nuviainc.com" <jamie@nuviainc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v4] x86/resctrl: Clear staged_config[] before and after it
 is used
Thread-Topic: [PATCH v4] x86/resctrl: Clear staged_config[] before and after
 it is used
Thread-Index: AQHZC3g3vupK6u+LqUSXN9pGs/kf7q5mXREg
Date:   Sat, 10 Dec 2022 02:18:18 +0000
Message-ID: <IA1PR11MB609702742C92B316A78D73459B1F9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20221209024436.22170-1-shawnwang@linux.alibaba.com>
In-Reply-To: <20221209024436.22170-1-shawnwang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|BN9PR11MB5419:EE_
x-ms-office365-filtering-correlation-id: 39938f66-8e19-4397-f4b2-08dada54cd38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TMB3qgxgpAuZKpRNrj7SFkQh2XF6kQghjley6mWuQn5N0YbgVycp2y0FmlLvI6kGkxuir5F65UV2UAry2bdC0qlyiT9W9pETUu0spFT1BoR/rDBnjeLk9Pq3b30cPUdBYfSUNxPWltkNt7HEhVIOPEWG/VdRAh1ELAsodNHl+C4gu+cy5LSpatNNATf1qTbtP+hSptLbVa6ZnmbVhxyRQx9Er7P/LyRjTtp+oPFpUsUdv5liPQYq+dcYRxIvn3A4/IarDzzUFyVNebYcvbP1lr49KL0KgHGfAvUwmmZMMqIiui5HOgT0+7K2Hm70CP34RTggUCAGJe32BJ531WzQ+rdSkV+lnsLBxeIyPbp23lhXzRJP+zpWWNsI29BqvnGYWwFwBIq5LseG4yqA1v+rQ5CBDl40IJUEZVludBZsPljjDKtMbEOkpsQMss1KzPAv7l278KDBXi/byghy2hg01pNvPu2oSz9vCBigWtbiYYxSe0U+NYspubh245DkQjCGBEChlxpJOB+fujl7Hbi2pb8d0ANguJsjkCwGjcgs7myuD4UjmUkYpqYF/2nvGAjAG9z4LpxrLBPJf/v8LADED+tIyihHzvb2cx/ifbVFlJGoRYKPYoT/0W0S37VCpkL9DSRPLcE69sOM7GrEDqZzlVaJRP/+YWY9PFOZlMGy4D4QsO6FbRXf+n3EOk5s/4d5nzCB/zPRr8+aGuc4SVpUVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(83380400001)(186003)(7696005)(6506007)(41300700001)(9686003)(2906002)(26005)(478600001)(82960400001)(52536014)(71200400001)(7416002)(33656002)(5660300002)(8936002)(38100700002)(64756008)(110136005)(86362001)(66556008)(66446008)(76116006)(8676002)(66946007)(66476007)(4326008)(38070700005)(54906003)(55016003)(6636002)(122000001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XGgjUUffacjSvU1W07wxbbL4ntuSXEqljXBMSaVv3S+Y5uAOF900ov4RYJ18?=
 =?us-ascii?Q?KWzN+AyLydYP5Qq9OW979t9E/M6CpAbBT1SlDQWi5J13FVsr0xkRVzeL7a+X?=
 =?us-ascii?Q?kwuB4cxf+mPUi+9bM1hBhdDxu7pqp74E5/ayy6GTiM1z1Ent8Qo0znJa4Z2R?=
 =?us-ascii?Q?JALO0HESP6/WxtTVE1YbPJ2052/Xl453iKYj78CugGuw+gxkYtjJjZUutuvD?=
 =?us-ascii?Q?n3PmOa7uOS41Ixi0pkCCUMRQc49F2vmPL7La1Ug7xQvAIPON9WmIl58OnWuW?=
 =?us-ascii?Q?YuXIMcM8LaSpG9HEXBpe1ZMIVbmUw4NmO+vV51e6M9hUL8dXZSuzxO2WiLK4?=
 =?us-ascii?Q?aL/im/ve5fXH2+I9LfyBC0EB/5n22ZajEdbdPpnib+8Fc/GW84BNsk1W89Tl?=
 =?us-ascii?Q?xPZiTL6PxC2QmJ9PqkVRq5IlVgr1dUMlfktdlYrq9CfBIucozr0XX3j/6f2o?=
 =?us-ascii?Q?k6ZpmF5Y82aFBxa3sQkU6513luHLJlgLyp0HhUoRhFSYPJDPfjYkXqRoMrJ4?=
 =?us-ascii?Q?qniWIj2pndcZLHnrHXplbE9JLe8u66PumSKLFspsRJI+u9fKXf5ru9lo9QME?=
 =?us-ascii?Q?bEsfhZ60PlKcSE0i0pP32yz3XlK1tlrIy/pn9Y1KBKmpEiZRuGXYjv1TWXUc?=
 =?us-ascii?Q?n5IrTaJNXz+YAaVOEhB3h3pVtSLwAM2hakfMHKhOZ7xwT6jmbybQ3qWgTNL3?=
 =?us-ascii?Q?08nQ7FZJQNldqLOJa295nzJJWuMVMtTBBWW4GcyTtTAmDY7yopmOEQkkNMui?=
 =?us-ascii?Q?yskFM+HsyFMqPGCjWkHzyGHjazR5i8xGl7ww5sBrV6CQQbebCi+zejwO2DOB?=
 =?us-ascii?Q?Tpq3Qlo+VBQ/2M9rhNf3vdYubnFGQmeJnfdyqX+M1HfYCW6/qJZuU9Ax6Uyy?=
 =?us-ascii?Q?wsszyG0gEruWnOSjNLDaQPrK1jMRDtPb3tYD0PeLTUEVDNy8351Gic3PHrZM?=
 =?us-ascii?Q?cNgCyNxhtcNX/U1T+GpNaSCDbrAotqo/s7LA95QGN7XV1w9KJBqzfUuPZDpd?=
 =?us-ascii?Q?rj8bCxUCFJwMMK/E6m5ovQFFbkpkrhrwl2vrmNdh9dI/MF5GGu3RbeFkKmrK?=
 =?us-ascii?Q?tIrUMUW5VOQC4rOYg4etbCMgfrPanouoaGyb8jd3nMT0fKn9KPDW+7PIt3O3?=
 =?us-ascii?Q?S61IaSwdgivHBidNx0X8Uujlb2kSAx45N0BlOr9of3hkjBh8ZcMN1QgCiY7f?=
 =?us-ascii?Q?8RT/c+afK1zXLzk8C+IFqkvog3rp9NvXQ3uT0MvOUT+L0zvr5gMTdVm5mlbx?=
 =?us-ascii?Q?fx1DLop2Mex1xUY4PMHkvFkjwZ9qpYsRkszA8eNUdcCIbxxzZpeIxGsFDZLm?=
 =?us-ascii?Q?fOluJ7wv538l3n0rAKfErDYGRlUx5Npsh9Nw3VuuAhATmP9B5ZtUrLyXT9dx?=
 =?us-ascii?Q?XPmHa8+lN5jkbZ46fjq53CDyWqPbOJgoElaqwUXcUV6U7340Ng9xp7YHelop?=
 =?us-ascii?Q?atKyXG9AwUtUdnojueqpVUVe4elGtSPw8hZMfPrWKNbl+0a0pKd9v4SDi4bS?=
 =?us-ascii?Q?t74j5Pw739RS3f8aHiOjQULjZAw2FnpBjy9egoqeGyHkpK1tJqTr5P+5OVgf?=
 =?us-ascii?Q?CZzOqMbnYOGAq7w7IfHCQGqrwKc99RApeyucYk0i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39938f66-8e19-4397-f4b2-08dada54cd38
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2022 02:18:18.1047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8C1qHZKWOJkofo374ZZHdFOCkSRP5tJu32QWRf2lSChqi6KWwCuhEiCv02i7zbXRGTFymgoOsUjcgWBnMObbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5419
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn,

> As a temporary storage, staged_config[] in rdt_domain should be cleared b=
efore
> and after it is used. The stale value in staged_config[] could cause an M=
SR
> access error.

Why should staged_config[] be cleared both before and after it's used?
If it's cleared only before it's used, does it make more sense?
Usually temp variables are initialized before they are used and their value=
s will
be ignored after usage. Especially clearing stage_config[] in double for
loop is pretty heavy code and an extra clearing stage_config[] after usage
takes unnecessary longer time.

> access error.
>=20
> Here is a reproducer on a system with 16 usable CLOSIDs for a 15-way L3 C=
ache
> (MBA should be disabled if the number of CLOSIDs for MB is less than
> 16.) :
> 	mount -t resctrl resctrl -o cdp /sys/fs/resctrl
> 	mkdir /sys/fs/resctrl/p{1..7}
> 	umount /sys/fs/resctrl/
> 	mount -t resctrl resctrl /sys/fs/resctrl
> 	mkdir /sys/fs/resctrl/p{1..8}
>=20
> An error occurs when creating resource group named p8:
>     unchecked MSR access error: WRMSR to 0xca0 (tried to write
> 0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
>     Call Trace:
>      <IRQ>
>      __flush_smp_call_function_queue+0x11d/0x170
>      __sysvec_call_function+0x24/0xd0
>      sysvec_call_function+0x89/0xc0
>      </IRQ>
>      <TASK>
>      asm_sysvec_call_function+0x16/0x20
>=20
> When creating a new resource control group, hardware will be configured b=
y
> the following process:
>     rdtgroup_mkdir()
>       rdtgroup_mkdir_ctrl_mon()
>         rdtgroup_init_alloc()
>           resctrl_arch_update_domains()
>=20
> resctrl_arch_update_domains() iterates and updates all resctrl_conf_type =
whose
> have_new_ctrl is true. Since staged_config[] holds the same values as whe=
n CDP
> was enabled, it will continue to update the CDP_CODE and CDP_DATA
> configurations. When group p8 is created, get_config_index() called in
> resctrl_arch_update_domains() will return 16 and 17 as the CLOSIDs for
> CDP_CODE and CDP_DATA, which will be translated to an invalid register -
> 0xca0 in this scenario.
>=20
> Fix it by clearing staged_config[] before and after it is used.
>=20
> Fixes: 75408e43509e ("x86/resctrl: Allow different CODE/DATA configuratio=
ns
> to be staged")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
> Suggested-by: Xin Hao <xhao@linux.alibaba.com>
> ---
> Changes since v3:
> - Update the commit message suggested by Reiniette Chatre.
> - Rename resctrl_staged_configs_clear() to rdt_staged_configs_clear().
> - Move rdt_staged_configs_clear() to arch/x86/kernel/cpu/resctrl/internal=
.h.
>=20
> Changes since v2:
> - Update the commit message suggested by Reiniette Chatre.
> - Make the clearing work more robust.
>=20
> Changes since v1:
> - Move the clearing from schemata_list_destroy() to
> resctrl_arch_update_domains().
> - Update the commit message suggested by Reiniette Chatre.
> - Add stable tag suggested by James Morse.
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  7 ++-----
>  arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 25 +++++++++++++++++++----
>  3 files changed, 24 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 1dafbdc5ac31..84f23327caed 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -374,7 +374,6 @@ ssize_t rdtgroup_schemata_write(struct
> kernfs_open_file *of,  {
>  	struct resctrl_schema *s;
>  	struct rdtgroup *rdtgrp;
> -	struct rdt_domain *dom;
>  	struct rdt_resource *r;
>  	char *tok, *resname;
>  	int ret =3D 0;
> @@ -403,10 +402,7 @@ ssize_t rdtgroup_schemata_write(struct
> kernfs_open_file *of,
>  		goto out;
>  	}
>=20
> -	list_for_each_entry(s, &resctrl_schema_all, list) {
> -		list_for_each_entry(dom, &s->res->domains, list)
> -			memset(dom->staged_config, 0, sizeof(dom-
> >staged_config));
> -	}
> +	rdt_staged_configs_clear();
>=20
>  	while ((tok =3D strsep(&buf, "\n")) !=3D NULL) {
>  		resname =3D strim(strsep(&tok, ":"));
> @@ -451,6 +447,7 @@ ssize_t rdtgroup_schemata_write(struct
> kernfs_open_file *of,
>  	}
>=20
>  out:
> +	rdt_staged_configs_clear();
>  	rdtgroup_kn_unlock(of->kn);
>  	cpus_read_unlock();
>  	return ret ?: nbytes;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5f7128686cfd..0b5c6c76f6f7 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -537,5 +537,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct
> rdt_domain *d);  void __check_limbo(struct rdt_domain *d, bool force_free=
);
> void rdt_domain_reconfigure_cdp(struct rdt_resource *r);  void __init
> thread_throttle_mode_init(void);
> +void rdt_staged_configs_clear(void);
>=20
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */ diff --git
> a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e5a48f05e787..fee8ed86b31c 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -78,6 +78,19 @@ void rdt_last_cmd_printf(const char *fmt, ...)
>  	va_end(ap);
>  }
>=20
> +void rdt_staged_configs_clear(void)
> +{
> +	struct rdt_resource *r;
> +	struct rdt_domain *dom;

Please reorder the variable definitions in the reversed Christmas tree orde=
r.

> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	for_each_alloc_capable_rdt_resource(r) {
> +		list_for_each_entry(dom, &r->domains, list)
> +			memset(dom->staged_config, 0, sizeof(dom-
> >staged_config));
> +	}
> +}
> +
>  /*
>   * Trivial allocator for CLOSIDs. Since h/w only supports a small number=
,
>   * we can keep a bitmap of free CLOSIDs in a single integer.
> @@ -2841,7 +2854,9 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdt=
grp)
> {
>  	struct resctrl_schema *s;
>  	struct rdt_resource *r;
> -	int ret;
> +	int ret =3D 0;
> +
> +	rdt_staged_configs_clear();
>=20
>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>  		r =3D s->res;
> @@ -2852,20 +2867,22 @@ static int rdtgroup_init_alloc(struct rdtgroup
> *rdtgrp)
>  		} else {
>  			ret =3D rdtgroup_init_cat(s, rdtgrp->closid);
>  			if (ret < 0)
> -				return ret;
> +				goto out;
>  		}
>=20
>  		ret =3D resctrl_arch_update_domains(r, rdtgrp->closid);
>  		if (ret < 0) {
>  			rdt_last_cmd_puts("Failed to initialize allocations\n");
> -			return ret;
> +			goto out;
>  		}
>=20
>  	}
>=20
>  	rdtgrp->mode =3D RDT_MODE_SHAREABLE;
>=20
> -	return 0;
> +out:
> +	rdt_staged_configs_clear();
> +	return ret;
>  }
>=20
>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
> --
> 2.27.0

Thanks.

-Fenghua

