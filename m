Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6147B74B972
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjGGWRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjGGWRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:17:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562A2108
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688768260; x=1720304260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JZCc/z6LhqhTntxTvd+xYSgnqT/0CFZq43R/vWGBx/E=;
  b=EI8cTbYjs+Ontiu+6CEs8w83es2nBQw0GmLsxw1hoAd1QIRWMs5kgNHp
   fVmrDJLAcmy6WROHk55LLhLbM092frJzyj+SObv6wQWPd4Y40shpmJ4QL
   alZYewTAyjpGId19+jWaG9kt0BmweiLONt6+gc+AfLvpwB/JjfbDuKcdl
   YUngwadUSQEv05x5TtXKi5i/4VVJxSh5rEM1OiOdM7DymDHJOgiWdatjU
   B8jN4IUZX5/SuZU9vpK7N1Lgh9pewUwdJl+BugOBVnCe9fWyxl3XM9+q9
   O7NljJpnQblBW6wn+xifUC5R6dXuueA+2UncGq0eYINn2SZml5nrg4noL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="361461262"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="361461262"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 15:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="755342023"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="755342023"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2023 15:17:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 15:17:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 15:17:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 15:17:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUuKdiMgJ+DyVHF9OjYIy6hZOhSnZOFYYlkRwYEQwavcM7xMnI7ZWGSFd9LFW02Xgm/byKPNH0nZ7HIWnS8OSziFv+mMLr4MpFEsZ2FCoH71I/jves5/PD1oeFUWh3ICrZqcwpOUT7Y33j0bRBPlJQEY9M8nhBrTqB5aUqLCcj4dZlqYnELKASUJl2PemKeRCguSWTZF5Dhab3dEuOkDe3KS++1E8oZBAN2cfykMLcEvbd24ZKPG7Q7+N0ouDzaFKDVZx0ni7ZHeQfDzjhkuX76kV+hFUY5DlQoQVrJ4Fgk5qi4Xyz4+f370+8V2O8PBIwCDQCR8z1bowBoGAe+mFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOhbH03TDRhkTv/XhBI1r9+oxMLhN0uBRgGdlyeW/Ok=;
 b=RPqOHySK4GJ2oBvMji/Ogh7H4dZ2U7q+VxQ651YYDpo9GaiLG7FOswOov69xHiD8zeuSoEOA0vorTLVFtQ/g5sMZb/zZ1ov7ikiaq253BZEF44cdTXVOw/tQeLu8f2UKGIN8BZr56CF8k/wd0U6GBNGh6ObeTxA9KZHQyDfnlY7mR5CseQMnaHlnzz6EF+JM8sdCmdbhx+VzGmChx/xhWZ5Nq//qLIDTgm7M5fmoog0djuGW1kWbhEe2d15veiGz9bsC9GqP9ir/d0t6ErTjDo1epp1cgGDE9A7rdvZa+eO5pDYRW6GShaiLPiP8Bj4Vr8ARy2TYUGjfvrUIGHc++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by IA0PR11MB7209.namprd11.prod.outlook.com (2603:10b6:208:441::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 22:17:37 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc%7]) with mapi id 15.20.6544.024; Fri, 7 Jul 2023
 22:17:36 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>
Subject: RE: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Thread-Topic: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Thread-Index: AQHZr83AFvT4TTcrIkq3d3Abr5XF0q+sxk7ngAC/myCAAC0zwIAA3mCQgABOVsA=
Date:   Fri, 7 Jul 2023 22:17:36 +0000
Message-ID: <SA1PR11MB6734577080AC6734E305D735A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230706052231.2183-1-xin3.li@intel.com>
        <87v8exgmot.fsf@email.froward.int.ebiederm.org>
        <SA1PR11MB67348D11385F584354AB84C3A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
        <SA1PR11MB6734F3F72095C4D6B9C12C9BA82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
 <87sf9zfx76.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87sf9zfx76.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|IA0PR11MB7209:EE_
x-ms-office365-filtering-correlation-id: 9fdb8fc6-7f7e-4058-1c3d-08db7f37f83b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQNUOoHBXPoA20fDYxEDLKAleqAt2m5xl9ZqEvoJVadPfZ5R49b+HhWN4vPhXFv3NyHbudEDtuzFqRbcsLmRXX2rEju+Uog4YY36cpzyEFY4moaIQhz5EYQG52/093d7uPlCLEK/Qgf4V58pTi3+hJ8UEjmtA72Ktt53Myhxy99PGqz8pYc0emNP1bBCt5fT1NJMGzMqqKdCWK0WW4hVbm/Gqt3AW/P5Pj1BkJBqW2mFZCx7WtC3oYDHo0vDRC3DAn3TJEnjLwfWHY//5KPPQW1o21uhp+xzTtk93CeReXHnwnO3DV37for3Jdn1StfekGSyfWFXuLmX7yRqWcdz7JUOcjEDoKVhAC3AULf3zYiwyD1tQc+s5Y5bv7RAUiG6t/Loae4HQhrQlAXcFquomYLBl5DplBZIgwj1TjIHT5Cuqj8iep1hHIxMeQU+3egT8rd+OopBcQU2gO+mB9JgwvHWzvmlfcnb5jHgySkUhygKQPYVPkvx/zMOfVc2BU16T+td8z0AZ5gW5ppTg1WWf3pSESdvNcobOOgbSkUsgcxMEkGakyW0UGgR6fWbgZJX3i5YJtTwA2KxRFw9P2PReLyfDP44VF4efzaIm3YOZMJks36iFH5P6ZjlPQy6KS0Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(2906002)(55016003)(122000001)(82960400001)(38100700002)(9686003)(186003)(26005)(6506007)(5660300002)(38070700005)(86362001)(52536014)(33656002)(8676002)(54906003)(71200400001)(7696005)(478600001)(41300700001)(8936002)(64756008)(6916009)(66446008)(66946007)(76116006)(66556008)(4326008)(66476007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WKlOu6pbNh209c3voFyUiVRJNN7uqIzUO8NdOnKopgw1R8C1SEgFIDwAyGBs?=
 =?us-ascii?Q?2UF9Qp84M4k2/m6ko+zaloddEEG2T/rtB9U9Ha+qpmCrXEhenZzPmRkzWuIe?=
 =?us-ascii?Q?rPI+LjkwX/SMh2TXpig3xwNtw3qeQpZwo6xdnpJ2Wtc07QJaUPVfmi1A5Noq?=
 =?us-ascii?Q?XLUe3Qpw3R1KihzhICS36uRzucULS21eM3MSfnUERNudlnLcMY3UJb0nblvz?=
 =?us-ascii?Q?F7TruUYex0PeyZ2ihA/o1uedRAxU8JuxUp7PQhWebU9rRQcxpUi+JZGJ7yNV?=
 =?us-ascii?Q?c6saL231SAcfTk8hj6cVKGXsSbo/8MPu/M8fKXetlmaiaYD8aH2h7qz2mQ8j?=
 =?us-ascii?Q?RCsmTFByT7e+6sN3dy3av0Z/4nx/CFVyR9trv45xHCQyaq6ZoEkUM/DSnLU6?=
 =?us-ascii?Q?tNcpk7Azg/FgQhyzWMRwrdfQavOvvDV0JPGyypxm4kuekhqoJwJIPw6JbP8b?=
 =?us-ascii?Q?4SLsuflfFuNn5X1x8K/D8TyMKoaG5rmxypZPyOWKWCWlsX69WMOdX+ZRacDa?=
 =?us-ascii?Q?ZLprsMpMprA9wGH0jC6IISr48xRVMGfHIbb7WC/XgRQo/ijTRsnoeLgUE64B?=
 =?us-ascii?Q?1KCpC8iPNYgGwTV0begKJeQVDLpo5yHcM1gXMMrkQQZbrAg155bds0zIHYD0?=
 =?us-ascii?Q?zYMtZzOekwURDaegfibq+Yi4De4X2Rod492cRGDFkkzBN/uzW9DO746PduO+?=
 =?us-ascii?Q?4rElRmqNaVz7bhVnf8fdw3KNdckUEoM/EmL8Pmd6LpjLgOKuKGvr+5ZgCXst?=
 =?us-ascii?Q?43JGIy8iXJQd96LW1GtgBvVt5yEiY3NrZpzTeKxNywOwuhhBPvqRjCl7aCSB?=
 =?us-ascii?Q?wcCFXv5MKYkJW83OuPoJ0kYvLvzK70BwMkNk5FbzpxEE6TTGDh6hakukBJRi?=
 =?us-ascii?Q?yPFtY21upTBsjomXIWVTONY8kkxqCBfp/UvrwSDlceRRDRyRnPaQk5EbJ5x5?=
 =?us-ascii?Q?PtelTcbqjnl1F0sqYGFQZUJuMdcD8l53rZCVviK4lGeNDm5REXs+T8DJ44cv?=
 =?us-ascii?Q?tOiAujB84q+QZxlhVHlFEBzcZgA+i11cSiPZrQ1nvPe1DOzo7kD8WZ3eaafS?=
 =?us-ascii?Q?8GpHAQTC5etAbwVdeZ1k0jFqvR1qBDG+h9w8Bzv7bmMNdqLp4IS7zmdC48k4?=
 =?us-ascii?Q?psWK1Cg5HWAk6sXMQiAjaguIYm1zshfY/AwC251LX5F9MIKfu+S/PdPf7Qjs?=
 =?us-ascii?Q?ri3Ju4njz++aiR/iseqaY/Aj2lHh+N71gS0gXKiFP0EVNOgvSrzSIiKyIuXk?=
 =?us-ascii?Q?DC83C6PraQuo5VMEJK7O8SFpNxP52E4pdoBvQiYp7ouIxVmyVrDRuBBnJwi2?=
 =?us-ascii?Q?sRARXZip4x+W6Z+yH32LyAlX6YxlBpvT5O8Emfayjf04S3jClfxo9ZS8W4KO?=
 =?us-ascii?Q?t65gmPgfqk2U8OqLjKrn59Y8tTCYFI3EZaKkdPLBd7adDlao48rHJhQmD0iU?=
 =?us-ascii?Q?r7dWEmhC8HgQRvip/DSOqhjVpkEErHmmAUuxyp7LVtDRAzzUVyQTQ+vQZmem?=
 =?us-ascii?Q?5mQni62Z2HeeepbpouqnXchJHEldfOs/s+2lElHLsgaW8HeY6I8hIz4yNEu6?=
 =?us-ascii?Q?Alj34X+2H+tmq5XhSuI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdb8fc6-7f7e-4058-1c3d-08db7f37f83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 22:17:36.7465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mlnq0RGH1Bn/eioVRx85cQ6uZ2Pdepm/roQoWnBKt9opx6U5wJyjM8gWvswp0jHwYoPQFvvubASfavFk075oaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7209
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps something like patch below to make it clear that we are
> normalizing the segment values and forcing that normalization.

"Normalizing" sounds a good term.

> I am a bit confused why this code is not the same for ia32 and
> ia32_emulation.  I would think the normalization at least should apply
> to the 32bit case as well.
>=20
> Eric
>=20
> diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
> index 9027fc088f97..e5f3978388fd 100644
> --- a/arch/x86/kernel/signal_32.c
> +++ b/arch/x86/kernel/signal_32.c
> @@ -36,22 +36,47 @@
>  #ifdef CONFIG_IA32_EMULATION
>  #include <asm/ia32_unistd.h>
>=20
> +static inline unsigned int normalize_seg_index(unsigned int index)

normalize_usrseg_index?

> +{
> +	/*
> +	 * Convert the segment index into normalized form.
> +	 *
> +	 * For the indexes 0,1,2,3 always use the value of 0, as IRET
> +	 * forces this form for the nul segment.
> +	 *
> +	 * Otherwise set both DPL bits to force it to be a userspace
> +	 * ring 3 segment index.
> +	 */
> +	return (index < 3) ? 0 : index | 3;

s/</<=3D

no?

With this patch it looks that 1,2,3 are no longer valid selector values
in Linux, which seems the right thing to do but I don't know if there is
any side effect.

> +}
> +
>  static inline void reload_segments(struct sigcontext_32 *sc)
>  {
> -	unsigned int cur;
> +	unsigned int new, cur;
>=20
> +	new =3D normalize_seg_index(sc->gs);
>  	savesegment(gs, cur);
> -	if ((sc->gs | 0x03) !=3D cur)
> -		load_gs_index(sc->gs | 0x03);
> +	cur =3D normalize_seg_index(cur);
> +	if (new !=3D cur)
> +		load_gs_index(new);
> +
> +	new =3D normalize_seg_index(sc->fs);
>  	savesegment(fs, cur);
> -	if ((sc->fs | 0x03) !=3D cur)
> -		loadsegment(fs, sc->fs | 0x03);
> +	cur =3D normalize_seg_index(cur);
> +	if (new !=3D cur)
> +		loadsegment(fs, new);
> +
> +	new =3D normalize_seg_index(sc->ds);
>  	savesegment(ds, cur);
> -	if ((sc->ds | 0x03) !=3D cur)
> -		loadsegment(ds, sc->ds | 0x03);
> +	cur =3D normalize_seg_index(cur);
> +	if (new !=3D cur)
> +		loadsegment(ds, new);
> +
> +	new =3D normalize_seg_index(sc->es);
>  	savesegment(es, cur);
> -	if ((sc->es | 0x03) !=3D cur)
> -		loadsegment(es, sc->es | 0x03);
> +	cur =3D normalize_seg_index(cur);
> +	if (new !=3D cur)
> +		loadsegment(es, new);
>  }
>=20
>  #define sigset32_t			compat_sigset_t
