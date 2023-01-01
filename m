Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB30B65A9FD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 13:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjAAM1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 07:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjAAM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 07:27:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA22718
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 04:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672576061; x=1704112061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vyXZ2H1YQrox6uc6OTRLG1mHdeUJSrlPzptIUURThUw=;
  b=JI+1puJq2Gd6dalzb/1xftXax34b/7g5JTDuOS1hwYRpm7JVCxTTGduk
   MK7fnQfIJ0MFp8bjZmaemf6a/IbpXcDz6j9MeLJRLBpfu63NkyIaTSw/X
   1vZXtEsOrXBagVjj25Y3GnuMt5RSjR3flXp2VBKoNSCvbjoXUvzZ+igwQ
   tCcHmxhsMMPYLtHBHyaYXGv5QO76pzVRJiNHt7uSBr5zWTtHsuVbd/DZZ
   d9sBEKCzY2ZIECvBP6bRk2LWd4iVXhY3J+opQzi6F/1cAAC4BhXGVA6mJ
   8mndFJNjBcQhjjLt8hIaaydmxkQm6AW15GzD49uRxau7KgaihAVxXWAQS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="385816302"
X-IronPort-AV: E=Sophos;i="5.96,292,1665471600"; 
   d="scan'208";a="385816302"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2023 04:27:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="761715265"
X-IronPort-AV: E=Sophos;i="5.96,292,1665471600"; 
   d="scan'208";a="761715265"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jan 2023 04:27:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 1 Jan 2023 04:27:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 1 Jan 2023 04:27:39 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 1 Jan 2023 04:27:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnDhT+ptZHd1YMalnlSpne803J1JULn9aZd/xGsoXC7VTpnChUWUb2lLe42GUS3Hh+bGYJXHRizC1rsLPM66JAZMJDXrqZdG+60lc/V7M7v1z4WL9Zvvo/GaLARuvP3I+h6mM9x+IoY5acW/f97lNJk3qBy4kM/gE7DGQyO6Vom8z1goUPmiM8zVvWHXXjcUeaT4fpu8Id1GaMQ9znZF2t1pJXjz1k7umtihJj0OvIvXSWjj8yT51s2qzQ5caJb0qYMvos4rPJet01gz1x7W1ZAirrA6eGOXVLctmOQgPiifJI3QsI90rzHJtcuBB+see+ZP8gAFrKNwILqjnBkfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnaZLF7sdiWBFSyTS6UcAQEPcZ9e5ZRL4LnZuqQEZbc=;
 b=lISjephvm4x6v10OWaHQvrHkBw4jDQp97k12TZB0rh8MET6ozK/hX52wmC6ZOUa79q7r8yXNTScg5MzxceNDWu0n3uHQDbASRPQJG1phuUf9aQ6jsmosGLlyUG3eZxmYGQn27PQHo8L3Ky/+cL9hvNw9ouPOEpn57/YkTYhulgcTH/qbjhy/hlrUQvovZ1sTt8J1/T+Pr7pE9gWv27sMgFzltqaS3eRbSPiK0MHZtF4KbpdEKUNnz5z5NGBBxiFtcmkcGA05V3GaB0SRV2OyuNWcW+CFsyFQiXry+FN9UAzY9manhHpNF35eJI2hzaKatWR4/zOYpIdWxPopjfksVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by PH8PR11MB8062.namprd11.prod.outlook.com (2603:10b6:510:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sun, 1 Jan
 2023 12:27:37 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::96fe:3ace:6917:1dd6]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::96fe:3ace:6917:1dd6%4]) with mapi id 15.20.5944.019; Sun, 1 Jan 2023
 12:27:37 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Subject: RE: [PATCH v1 1/1] mei: pxp: Use correct macros to initialize uuid_le
Thread-Topic: [PATCH v1 1/1] mei: pxp: Use correct macros to initialize
 uuid_le
Thread-Index: AQHZGtY8SdpSr4iFY06/Sk1hol6Ajq6Jgtfw
Date:   Sun, 1 Jan 2023 12:27:37 +0000
Message-ID: <MN2PR11MB40935FAB63820A3B25E3A37DE5F69@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20221228160558.21311-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221228160558.21311-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|PH8PR11MB8062:EE_
x-ms-office365-filtering-correlation-id: 06dc0889-fe73-4dcc-eac3-08daebf39147
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SBB6nZ4290070fmHUWJs2se/+iCAg1G3wRFqEqxYe4zgv9+UtBxqy1+wNHaEiVMPDmMHjQWdgWrRwLhYMg7es4CfdXs8dh2FxREYdn6glK++egXXCtwJJnEw1CAiATCIEYLk4eL8sH9cKlJOV/RXRn3YNq6eFktNRwYZNE8ZmnADdpg1gqnF13TMACz2Y9yePPNfu2LPvdCW8CRmjmYo7qfWBQyrOEf3SibhbowV4pOcTupprCYwEnPa71sfxS8tgTIvtS/buWo+66aijBtZ5dtcTRXc7F9Rf53TIizK11F1MW0t+bqUFcrwAgJfEYh7oBPj94+NA8KM2Jwuox2fpGUG+pjKv+gOJ5zibH2k6w+lA/hvX7n8WJ/RtafehbqUv/K1LiKS/sfw+Qj/QeGcq+sMcYERdVnSLBY3LdZKBksuSO4XMri3Sf57JYq5vAQb8FCx9nnADTSOerf5ky5wO7oavu+OpiYP7fYA05/D2gR5nZ+8mtD4OGxmiihYdij0nreqza01vkeRsIDigUNr4W8OaylPkJweXUE4qjUV+9BOZv5vet7IMPCke3DrlVfGaoM8gzNAVyXCobAeZ5EIoYGR6lo0QA/rMmEq6zag8mwMh8uXgDa46+E62tjNRwqBr7JgRLCDlC+JIQngwXHMIF690VNU0LDDNrqdEii0IeYtlbDoHWf9b6BgIRjOvtu6wrpZxBCAZTxl/7vUcazIBFPV2HHSHS+S6glfpVj/z5c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(122000001)(38100700002)(83380400001)(86362001)(82960400001)(33656002)(8936002)(38070700005)(5660300002)(64756008)(66476007)(2906002)(66556008)(66446008)(8676002)(76116006)(4326008)(66946007)(52536014)(41300700001)(55016003)(26005)(7696005)(186003)(9686003)(6506007)(54906003)(110136005)(478600001)(71200400001)(316002)(22166003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KqTvebjiQvnzKV3wU36I9Msi8yB74PWEF8nYDey5qDQUvX5lVi9VidQArhmB?=
 =?us-ascii?Q?PL0EXbGG36JKJMIaSLmM4aZOVqiyfAtbCyyWrggM4QEsk/ltio3EOLXyk1aq?=
 =?us-ascii?Q?rE9/K/tGQtNj9jRd6inOc4IFn2h+lO99Wfo2+cjjAsf0lIe/pbmQxTkhzIPB?=
 =?us-ascii?Q?JvbjWRYmKF5YFjdjBjFZ8OruxdOOY8/Bi6qGsjocXp0hu291ohT528iZsVUj?=
 =?us-ascii?Q?lAT8/nv1sEprmxQGQh2Zx40gKAdR+Fc4yS8798lsAGieOb5l3ArXO+zzcre7?=
 =?us-ascii?Q?bx/NdhRVFNIoa+9ziejjxPnRgPxcPhIob/29mC/a9xPDKW4nAhaH4EYW3hH8?=
 =?us-ascii?Q?M5u7AKlTbt50g0zi3gZoGOusMWoVzJqhq1WqmXXVqAoesC/c7LYw9m/FVcih?=
 =?us-ascii?Q?3yIFi/1Xs4gXrTk5lYd79J4Sr8gIj6pjfu4TUuX9laVsdjLwCpKb2hyGJnIc?=
 =?us-ascii?Q?KJ5I7YGzMuhUD4ovKtRieaWvX5bC+vIuo+7q49Hc3cOstEsjWtsu3mShMnqn?=
 =?us-ascii?Q?igPXBYmzLNvutA/zkMAX7HHRGBy/rLhDG7FpO04DoIbk3gAZoaREEnesNizA?=
 =?us-ascii?Q?FPokbqxLX1Y9U8ohGKPPrvBPmh8UoU6qVUs2p5TA+zvHvY6LwPXX1purQ5qm?=
 =?us-ascii?Q?Y1KsjHVZvxm0Gn6wwkWwRqPEX2mv5Gbmltxmf2wl/pcdgdGb9h/6xqHmbfyF?=
 =?us-ascii?Q?6uuVcD+hfzQlmYBfsWAnbR8OTlX8iWflFKAxPrJrrzZxdE+hFpBqluxkZnj5?=
 =?us-ascii?Q?5Tm1vcckgMO93Jk6wbzME8+yrIvSQh83opI6mwAh1gJ0cJLqO01y5IkoZdoo?=
 =?us-ascii?Q?a47L15NVjQMTzkQBzsrqaMdm63mT6KO7OR/8OW4hPk22Gz+aQtU8Dz/gMYui?=
 =?us-ascii?Q?/Z9HUguiOTutPB+AsRQHBmdxVNrGofcF7x2S/7SpH9aqN8Z4TKSAROm6KWhf?=
 =?us-ascii?Q?nKuCJt5zvmSLSTCdYaxTfmSGtlq1KeAFVCODpqKDuba2xN5388pnU44z2edH?=
 =?us-ascii?Q?y4olGrlZRCZA4XJ8nadYsLAhkPYKhU2FKNmENJabewsYhEhdUSfvMd/J+Rto?=
 =?us-ascii?Q?Ge7QRQBJXHN9Mt7p74cieSr4r0HBNUltXjyIi89vV5M4TO7V3uVi3ABMyqMm?=
 =?us-ascii?Q?+rTogLEG4kbdTEWpYRcfOksQ8ofh5s0SFywmka3UyBzJnKHgE7Mg97E28jTj?=
 =?us-ascii?Q?F/m8jJKIOa2mPmBYNRQnTKPKuCrTYl681f4OJOpFYk1LRzdXKTY1bNri8JSj?=
 =?us-ascii?Q?xecW0TcinJiWJcDytwqghagfQ9cZJLNyyS2u1GmSk9+uwNx/pyrgIL1uE3Ir?=
 =?us-ascii?Q?hzfalUp/JKFo4iUIpX+FeA3YULqalHtrXdLsbn5zo6XoiTKHXuHQsim5GKv+?=
 =?us-ascii?Q?50nrcfmNYcx0Op32AVCake9QkmlrVU7b5CtyspDtBmzSiYxnHYbTffVME2Qm?=
 =?us-ascii?Q?Q1M3xiwUEtzWFQ7IwS0agzoIzDKV9SNUP8s+AQHHRnhBzgxRf7Sa9GM31J0v?=
 =?us-ascii?Q?4U4VCLTCZhZpOILHnO0InrAKxwDpoH0SrgU3oS9KWq0L7sradHLUm/rwuTTp?=
 =?us-ascii?Q?/IyboeMq+tqvGsYCpTFVvEfodUJgcP+I8fQ6J9Fc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dc0889-fe73-4dcc-eac3-08daebf39147
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2023 12:27:37.2711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpeamAl4uo+ofSiVdmQ5LHxv1aFqy1SzeUj7mjh7ITxGCsEY0/4CPa+61MusCrWzJDP309rwzvNxfL/ROWv7wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> GUID_INIT() is for internal guid_t type and shouldn't be used for the uui=
d_le.
> I.o.w. relying on the implementation details is layering violation. Use c=
orrect
> macros to initialize uuid_le.
>=20
> Fixes: c2004ce99ed7 ("mei: pxp: export pavp client to me client bus")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>=20

> ---
>  drivers/misc/mei/pxp/mei_pxp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/mei/pxp/mei_pxp.c
> b/drivers/misc/mei/pxp/mei_pxp.c index 8dd09b1722eb..7ee1fa7b1cb3
> 100644
> --- a/drivers/misc/mei/pxp/mei_pxp.c
> +++ b/drivers/misc/mei/pxp/mei_pxp.c
> @@ -238,8 +238,8 @@ static void mei_pxp_remove(struct mei_cl_device
> *cldev)  }
>=20
>  /* fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1 : PAVP GUID*/ -#define
> MEI_GUID_PXP GUID_INIT(0xfbf6fcf1, 0x96cf, 0x4e2e, 0xA6, \
> -			       0xa6, 0x1b, 0xab, 0x8c, 0xbe, 0x36, 0xb1)
> +#define MEI_GUID_PXP UUID_LE(0xfbf6fcf1, 0x96cf, 0x4e2e, 0xA6, \
> +			     0xa6, 0x1b, 0xab, 0x8c, 0xbe, 0x36, 0xb1)
>=20
>  static struct mei_cl_device_id mei_pxp_tbl[] =3D {
>  	{ .uuid =3D MEI_GUID_PXP, .version =3D MEI_CL_VERSION_ANY },
> --
> 2.35.1

