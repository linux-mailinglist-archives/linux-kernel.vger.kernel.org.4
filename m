Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738046914EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBIXwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBIXwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:52:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AAF5BA64
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675986733; x=1707522733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i8pjXNphVLhE1mcJ1Ed7sEdYyX8NL2o2Xx3JL9UXH80=;
  b=M5+ZVSkZW466A4Sp7NPn/1e9ZatoUXMi2T4aSrw+eMNsYoRfhnUgMlN3
   vkayWnYENaXSzF5L5d0N6aGldyVDtR2g2B9rDF/mejGdSaXqQiDisASdR
   FxpgS0y93yQ6r1H18Fkmh+Z7A0ZdEFnzQqFNRinhig//E89yI0UxuLKQ8
   J8nWGdEf+PQgH2X5pUF0i7Jw8lEKcDSTBYpGPKraPHdY9V02Xh053/B+6
   ZOlDdVJhQ+OT+5+oe1p6FaAiPkvCQJwyt6f0Y5311B02Lyvs508aTtjwd
   BFxjasutd0nfIyS//QyGLX3L+/Xex2EX68o7D0GGqj19gUsR25PdZBIEo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310646414"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="310646414"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="776686752"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="776686752"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 09 Feb 2023 15:52:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 15:52:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 15:52:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 15:52:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW6f+xEeHaut1CXojf5p8GeoUsEStndv+ckm+yo31e2hMvKG6a/hYff4u6cSnxRpMb/0FiNbgOgMqgo/fCRyjW4v0HbHVNTfveV4d3nJYpEingClSGMSlZFeOZykFji6QBnVwg2cXJgk+iC/oj+srbAcRWnpnDKLW3SMWQZYbbXbShZWaKU1xFTYjTa1uUHRnxlLGbj+hHj8CeUUUolnJe1iSrIPTb3UmTS+Pdo2VVVuJbHSnywtqeBHoOK1wxnsAbwdnKw0z+DxiM2bEzoyZAfGeQ23PQs1+Ss6AiaOvz/+BrtDuCLlPHwUZdt7pMOR0gXG72jOwxAKxBfdxQ+wUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QShtV1FSmGD6u6BX6O2nJAL2Yax91l+9FLuqcs+dgDk=;
 b=C1bcbtbBitiDYaAsAy63pTjTfkERHVjPnRQ2wapUo3RCjkFM4vCaPP1mIIyTNlMeXuOM44mN6+1RinO2sSDyVLJD2XSqLtkREnaVUutYHFobmu0onY7fhJaP8UJ+QOY8MA5QHo6n4c+xTcKe9erkg01wh4KtWjcW8pWfDdiR1l/mvvgPKG4GhQQIgCvy2bGiIQv+dRnDKTcWA5/2xht23XrOYBz2Z4+zuJiVJuLITFOrjlTfKCPK9sePRHt+KftuNE1Lkkft8n40jcOWbIut13s5/54v5ywp9ixssxliomMwaiNLqODipWMdX0waC8CTmoy3Aimngkj+ZBCeJIOjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA3PR11MB7487.namprd11.prod.outlook.com (2603:10b6:806:317::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 23:52:06 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%3]) with mapi id 15.20.6064.031; Thu, 9 Feb 2023
 23:52:06 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched/isolation: Fix illegal CPU value by
 housekeeping_any_cpu() return
Thread-Topic: [PATCH] sched/isolation: Fix illegal CPU value by
 housekeeping_any_cpu() return
Thread-Index: AQHZPJqZxYoAdHprS0OYkz1Mn3AM+a7G63MAgABd5FA=
Date:   Thu, 9 Feb 2023 23:52:06 +0000
Message-ID: <PH0PR11MB5880CBA66474C7BA0FBE06C5DAD99@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230209144911.987938-1-qiang1.zhang@intel.com>
 <20230209181420.GM2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230209181420.GM2948950@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA3PR11MB7487:EE_
x-ms-office365-filtering-correlation-id: d043b973-6a9b-4a8a-0e7a-08db0af8a66f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /dpCDZZ1rhTjEP9pqvjZxxuHwqrzJBtU+FW22g0dvp8UdAm49ejXLijW0PHy6nTO7WAoekkWI+BVEfGanE+jPxVcZZK0Y5o31NxOqQ7OmvQu0XsbSHFPl1+MFLboRDgI7ydS0kyifjBtlrD1NilWTswdcn469lMxFAxNwm5i7dL9+hKkenmNrjBhmr8vWq9WNpfTE1aC0Tq//mUP5smx7W4MI8+rEFnz/7+Nc5ouv4C9U6yl+yLpKnb5KyJSUI+Sbo02INE9RwHLPNFovNgV9C1ERsNxpcjJeNxz4DXK9Oei2peOmOvjti07kDpISnnP1C8tN58e4U07ZzVNmsR1c7D5897ObGLOlaIMI1zo8l1mvcDaQS+PHsGVTxoxuhBBzp6/AjlULmy6UGBBIB2IzK6IIFhqiDXvzpxlFjo/1qxFplyW0YvCmOm5B1aJpccAPPvujykHIZaI5w123xEYlASBuyuzOUafMCEAKD0xLdQjxvVQJuViMs77AdXkKCbfJDzliRtMj+SsK5nE6d/3371cIU5LzglmgMzCcp5PRYmi5tkBP65P7kDm1J4O3W76PGajSlqjq21qk2f9uNqR8QOzKXpRvnEQpg4Qv45qk5jJ/ET/ADRkwRAmBVUKB2VQ3BBVEjsKOEeFDYtVK+4HlLulh3LLHAIrW8UVsiZiXW7gIHeAzNTGE5qyCysJ+I4z3XtadE1uVPrwOjD8osO4sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199018)(2906002)(38070700005)(41300700001)(5660300002)(122000001)(52536014)(38100700002)(8936002)(316002)(6506007)(186003)(82960400001)(26005)(9686003)(66446008)(64756008)(66556008)(86362001)(66946007)(6916009)(66476007)(76116006)(4326008)(71200400001)(83380400001)(7696005)(55016003)(54906003)(8676002)(33656002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gYF1/dC8kx+WwC24qDM3+TLLd3Aznqgobn+JkiBSjcSRHSXVQZBT6DLvXaFv?=
 =?us-ascii?Q?EZU8Ud7Y2C6MDNe+e6mqeqWRBfwuJZ8u+9f0826mdyFWDfLv/U7yaKzeV+1/?=
 =?us-ascii?Q?93oV7qqmwSDY2zVXMU7tdhH21smrXRO1YALcJl8Oyi/dAnnjxShSZZcGL7wv?=
 =?us-ascii?Q?ntzkNpCpiTjjzsx5dg9/iSODDA8za+t65pkuqDRx74pVmHIuHA7JDWsdTk18?=
 =?us-ascii?Q?htbWiiFiGoLBBrFF39EaaUy/2OcxPuqjQcip/FL0LfPpG0KeLvul1Vm9xp5X?=
 =?us-ascii?Q?UqXPkf2yIEYd664cLrxpqkhs7i6evupwu3HqxXIrvq3vmrUcEj3IrPrLI28g?=
 =?us-ascii?Q?MMzv11VlI9wELQHx0eCxPeiFyP+0c1qSdhGG/ZRfpsjvsuqIvl7fD9Tj6GrM?=
 =?us-ascii?Q?HITASmw5+xgu7FXlup4c5roo2I3eFcH9oMCCpNaUKAbqfr9DyoE73fQ8+qO2?=
 =?us-ascii?Q?xcMWNljIB09+Rob4YX8JRcz8zVJaSK9fA/CnAYs/bP4UgkKoW50bR/QMkWTA?=
 =?us-ascii?Q?T7OfITKlu5xX+aRuZuRl3ridX/l+kdT0evEoHz2BdzB1PSaVFz1rzJbXL2kM?=
 =?us-ascii?Q?73cTEQnvLfVLLGKQr+YPpHnp61I9uWPSiz8G4zdsRSNhOTuB4XC1cusygRqT?=
 =?us-ascii?Q?2uKwgdGX4bH3axGrAtyjqcW1y68DYCU+tRVw43tN2Dig+I3GEZHXgwbPk0Sa?=
 =?us-ascii?Q?uZUUiFI05Q+qo0HWXAoEiO5r5IfnvYDMqskk639zjTB1RG50cBm5E+Hg5piX?=
 =?us-ascii?Q?OHnQ5MEUCzCAuAD87JxWEB+3gvN3XctD/6+OiKkIXZs5a1DaWUzEYwb64XHW?=
 =?us-ascii?Q?Bx6zDwgZ3hqExgH5Q4eV2d55rsUZmsStKCCKVZL7ZaMNhC3ldXNtd7snMfd/?=
 =?us-ascii?Q?8hiDsoE3EhF1Hkhnj+6v+fVoiaI9zsyWSnp74CqhlWI5oD9vRBWGRirHAsK+?=
 =?us-ascii?Q?UpAl1dBr6EzJuxXYnYD7/jGaYZ0TeUd9HuqIBqNobZCCX+lNHVqTFocw+2OZ?=
 =?us-ascii?Q?+C8OgdNtN/8LUHLog4nN1WNbf9anOOruuCgnrXC0sr1vUjxGtSqLF3lSqzwh?=
 =?us-ascii?Q?U8AGLPiYlHJJdu2yh5jcv/L+9c4XFDK8M2CMMk6e30Q1UJS512MXLA+dAm6m?=
 =?us-ascii?Q?A18lJIrbGbCxQE0lAX+6/zInP8PnuNee5+ToWW6kQkNP9uZAu4HvE8f9KoYy?=
 =?us-ascii?Q?aKKeINKkLMFUh+71K9NJsNY3syaXEMKqbppkk/KCDqzpZvxpEYA5C7sm8iDe?=
 =?us-ascii?Q?d5KZp8iOWR+ShwBaeja7xLhjXtG9B7SYLfEhcYlk29A5HYqSlVpaxhIXsHhs?=
 =?us-ascii?Q?Yf+c4lucOUSVGWnrw40VHcTmWIPzYchMXhWbWNiCFDf4o3Qq+W20AV2x5UbI?=
 =?us-ascii?Q?4BgXkelqveqgy0OtLCJKaoxcj1saWFcEowg5epijsUjJlGM93XQE4t2CGd4W?=
 =?us-ascii?Q?nzxq6DkUgjCpBSFapPT4Qgf9gZ+qZxdthBRVGc40H+B3KpIVHZdJXPLoUpLm?=
 =?us-ascii?Q?/UhEXCefgkdLPCV4XsZaO3H9PfgY3OT00dM/PASbrOtJV04SdCfrMatb8rr5?=
 =?us-ascii?Q?2OX65l9UZw1Q0VuUMV2GBZEXKQ9pYK49cPb7IyyP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d043b973-6a9b-4a8a-0e7a-08db0af8a66f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 23:52:06.3207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLIAgJVF3YcFBOZcn8YjhJd6HJlAtv6O22bP/JGh0Fe46WdrjOzoYISnzfziEKTkSaL7DY655NuhfKAM3EkfJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7487
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Feb 09, 2023 at 10:49:11PM +0800, Zqiang wrote:
> For kernels built with CONFIG_NO_HZ_FULL=3Dy, running the following tests=
:
>=20
> runqemu kvm slirp nographic qemuparams=3D"-m 1024 -smp 4" bootparams=3D
> "console=3DttyS0 nohz_full=3D0,1 rcu_nocbs=3D0,1 sched_verbose" -d
>=20
> root@qemux86-64:~# echo 0 > /sys/devices/system/cpu/cpu2/online
> root@qemux86-64:~# echo 0 > /sys/devices/system/cpu/cpu3/online
>=20
> [   22.838290] BUG: unable to handle page fault for address: ffffffff84cd=
48c0
> [   22.839409] #PF: supervisor read access in kernel mode
> [   22.840215] #PF: error_code(0x0000) - not-present page
> [   22.841028] PGD 3e19067 P4D 3e19067 PUD 3e1a063 PMD 800ffffffb3ff062
> [   22.841889] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN PTI
> [   22.842175] CPU: 0 PID: 16 Comm: rcu_preempt Not tainted 6.2.0-rc1-yoc=
to-standard+ #658
> [   22.842534] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>                BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.o4
> [   22.843036] RIP: 0010:do_raw_spin_trylock+0x70/0x120
> [   22.843267] Code: 81 c7 00 f1 f1 f1 f1 c7 40 04 04 f3 f3 f3 65
>                48 8b 04 25 28 00 00 00 48 89 45 e0 31 c0 e8 b8 0
> [   22.844187] RSP: 0018:ffff8880072b7b30 EFLAGS: 00010046
> [   22.844429] RAX: 0000000000000000 RBX: ffffffff84cd48c0 RCX: dffffc000=
0000000
> [   22.844751] RDX: 0000000000000003 RSI: 0000000000000004 RDI: ffffffff8=
4cd48c0
> [   22.845074] RBP: ffff8880072b7ba8 R08: ffffffff811daa20 R09: fffffbfff=
099a919
> [   22.845400] R10: ffffffff84cd48c3 R11: fffffbfff099a918 R12: 1ffff1100=
0e56f66
> [   22.845719] R13: ffffffff84cd48d8 R14: ffffffff84cd48c0 R15: ffff88800=
72b7cd8
> [   22.846040] FS:  0000000000000000(0000) GS:ffff888035200000(0000) knlG=
S:0000000000000000
> [   22.846403] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.846667] CR2: ffffffff84cd48c0 CR3: 000000001036c000 CR4: 000000000=
01506f0
> [   22.846988] Call Trace:
> [   22.847105]  <TASK>
> [   22.847208]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   22.847430]  ? rcu_read_unlock+0x26/0x80
> [   22.847612]  ? trace_preempt_off+0x2a/0x130
> [   22.847812]  _raw_spin_lock+0x41/0x80
> [   22.847984]  ? schedule_timeout+0x242/0x580
> [   22.848178]  schedule_timeout+0x242/0x580
> [   22.848366]  ? __pfx_schedule_timeout+0x10/0x10
> [   22.848575]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   22.848796]  ? __pfx_process_timeout+0x10/0x10
> [   22.849005]  ? _raw_spin_unlock_irqrestore+0x46/0x80
> [   22.849232]  ? prepare_to_swait_event+0xb8/0x210
> [   22.849450]  rcu_gp_fqs_loop+0x66e/0xe70
> [   22.849633]  ? rcu_gp_init+0x87c/0x1130
> [   22.849813]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
> [   22.850022]  ? _raw_spin_unlock_irqrestore+0x46/0x80
> [   22.850251]  ? finish_swait+0xce/0x100
> [   22.850429]  rcu_gp_kthread+0x2ea/0x6b0
> [   22.850608]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   22.850829]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   22.851039]  ? __kasan_check_read+0x11/0x20
> [   22.851233]  ? __kthread_parkme+0xe8/0x110
> [   22.851424]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   22.851627]  kthread+0x172/0x1a0
> [   22.851781]  ? __pfx_kthread+0x10/0x10
> [   22.851956]  ret_from_fork+0x2c/0x50
> [   22.852129]  </TASK>
>=20
> schedule_timeout()
> ->__mod_timer()
>  ->get_target_base(base, timer->flags)
>    ->get_timer_cpu_base(tflags, get_nohz_timer_target());
>      ->cpu =3D get_nohz_timer_target()
>              ->housekeeping_any_cpu(HK_TYPE_TIMER)
>                      /*housekeeping.cpumasks[type] is 2-3*/
> 		     /*cpu_online_mask is 0-1*/
>                ->cpu =3D cpumask_any_and(housekeeping.cpumasks[type],
> 			cpu_online_mask);
>              /*cpu value is 4*/
>      ->new_base =3D per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
>    /*new_base is illegal address*/
>  ->if (base !=3D new_base)
>    ->raw_spin_lock(&new_base->lock); =3D=3D> trigger Oops
>=20
> This commit therefore add checks for cpumask_any_and() return values
> in housekeeping_any_cpu(), if cpumask_any_and() returns an illegal CPU
> value, the housekeeping_any_cpu() will return current CPU number.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/sched/isolation.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 373d42c707bc..e255eb83f14f 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -46,7 +46,9 @@ int housekeeping_any_cpu(enum hk_type type)
>  			if (cpu < nr_cpu_ids)
>  				return cpu;
> =20
> -			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu =3D cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask)=
;
> +			if (cpu >=3D nr_cpu_ids)
> +				return smp_processor_id();
>
>
>Don't we need a "return cpu" here?  Or am I missing something subtle?

Sorry, thanks for review, I will change and resend.

Thanks
Zqiang

>
>							Thanx, Paul
>
>  		}
>  	}
>  	return smp_processor_id();
> --=20
> 2.25.1
>=20
