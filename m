Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7D731629
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbjFOLIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343536AbjFOLIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:08:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620372951;
        Thu, 15 Jun 2023 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686827323; x=1718363323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=erVBYcyeomAZdwRBRM5HEBKd/MHTaLpuLY+Vxu6/aTk=;
  b=UPt8X0nQtaFT39wbWwLkHL/7+purFonoUwwLSvjbmAROjREPPyn1UPG4
   WNypPi7RtccGB4jSuK2Mdhojnga1/rsfeKWs3MP5Xps+nbqWiYVlKEBch
   HU3fwPB0NmuXBm7206YD+3dpZiz8saOvEA5zeTLskNoGB7Mh2OKg8A3GJ
   bZkUOoUjTPE0v446SjNKItyQW031RC6fOHrVr47jjSHAzIrt9v/1/mT8W
   4oj34/b8rBEWVa9MpQuAlcc9TfbOZ3kriRaHbxT1FStF2283b9sR3Z26j
   6RrtHca9lOqlNprdiiGujNlf5c/jcqJLzCYhoXEGQOWv3NMSgjP/+g+Sj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="339227213"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="339227213"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 04:08:42 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="745483539"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="745483539"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 04:08:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 04:08:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 04:08:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 04:08:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMZL60+hvS1fgXIV4OMYuaBCb1ObFeyhezDThlI+UiNGmXtWHjWebP8l4/5jV+3vAB4kpdze4+uvl6XDd0b5H5Z21v18K9FjYX8GJM1QiW1kq04bTZf470EUw+ecQj2B/tnW7E3brLkzVi2WweeoiQ3D/sek0aAIIZQBDZAyQRrowPkAL6dPeOM65sNqxXB9AurkyOy67W63VZuldfm3aiPsRvcG+qa6xNg+ojAgRrF8L6gM79u2eTFAzrTdRhScRjj40RIS1n8QZGhToqhqAyXAosmAtqMi6RuNcQEefCfeu77YtM9zb1iozAac3c44wubqDq8IbQV/kts8w8egCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9qMnEmAKEeqR9fYxEr7WOCz+daquBsXSPkVaHLU/iI=;
 b=ec9xCDKq+0GEDBXSt1Ho1BpsdPRyVnpw3QmV/dzCe7uWXQavBB5/hdTCeMtBGQglDjhdIoWXmVPm5uiu+V3qZ7XJgEhYrudaz/jAuGnN9uoXEYpFjBVwtViErbS2sHftnL45RFQJIXOLHutkEIUqC3KFQT1a4Zgs32z82+HUxo3sqSPCnHE2//RsOaIfe1216ex54i7jD/CUXKO2aTDBhJs+9rQpU9Lpt6YV+UpheULWal1yAYmlMrvHry1C++Yk0zyuopzgVqp6xkQYT1CJc2uQxbUpK73eZndvY7ybnlhC9XBvElibvlZ3KF+9SCBZCvyoYgOdAyxa2w9E/cF2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2779.namprd11.prod.outlook.com (2603:10b6:5:c6::26) by
 CY5PR11MB6317.namprd11.prod.outlook.com (2603:10b6:930:3f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.27; Thu, 15 Jun 2023 11:08:39 +0000
Received: from DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de]) by DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de%4]) with mapi id 15.20.6455.030; Thu, 15 Jun 2023
 11:08:39 +0000
From:   "Jadav, Raag" <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: RE: [PATCH v3 2/3] pinctrl: intel: refine ->irq_set_type() hook
Thread-Topic: [PATCH v3 2/3] pinctrl: intel: refine ->irq_set_type() hook
Thread-Index: AQHZndRGEYk7XkvCzE+g3a/tygkcuq+KfTeAgAEjDpCAAAMMgIAAD0uAgAADFKA=
Date:   Thu, 15 Jun 2023 11:08:38 +0000
Message-ID: <DM6PR11MB2779664C590484A1601A93298C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
 <20230613085054.10976-3-raag.jadav@intel.com>
 <ZInpT0dUUVUcKdqv@smile.fi.intel.com>
 <DM6PR11MB2779F9C28712D7C25F9FB3768C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
 <20230615095517.GV45886@black.fi.intel.com>
 <ZIrs2YSEUbPyvZWE@smile.fi.intel.com>
In-Reply-To: <ZIrs2YSEUbPyvZWE@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2779:EE_|CY5PR11MB6317:EE_
x-ms-office365-filtering-correlation-id: 135d6236-8aab-404a-38a3-08db6d90df2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FWFrtc+PbrR0moARawP/OtetNx0xD0dhKAry8cJpuLtm4XwnQ01NqEid0XXSxEzoIxSY3zgg8SxrkDDTieV2SD/e4vyrXpjtrAca2DpnR7AcQx8rTFsYbrTeOtAA0daEeiqsVoru6yUD3+2/aI0NZRroEmHF+N7F5lVyqteRZIVNWsk1+eh8o91Q8vp/3HyWQKCO+gBG2PjvCc78RWQIpm9hsGJs6Gkg0zrGrVx9fPOE+PBqREwgbkahtJaKJoIDZKagsvQFRk+H0BkFQCFRs2lTtHf3fl+mkcI6m5Bc3G0ZR2+ozl5JefT2h+1SW4viRHmXJRhHDF9D/8ljp9GULodSRtZusYnHhaTc8qJqhjrVBYnFEPJ9lvODVXdgfjAYHcejGVoGP2LvXgGQhexJCKxts28W7RhW6wpd28tR9wDaxl44jXPQi3SjSXaH+ObRhDIHWnEAYWCznzLIo27Q/f8dYzVyI9st23mDUT48D+pAcPJCWhN34Mcr0vqtYY6NvRcNsOmy7FBpe/TQ+x4HMJ4lD8B7dm3gPVkUAiSEqJ7NiYKAHDPtR79YYFZ2qdu+L5+n03qA3uZrEVMe4SB+d9O2dZ6vRBWFd5yzyAxgaF94inM5u+29jvkqxdr4WDVu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(122000001)(478600001)(7696005)(71200400001)(82960400001)(38100700002)(55016003)(83380400001)(33656002)(186003)(9686003)(26005)(6506007)(38070700005)(316002)(41300700001)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(76116006)(86362001)(2906002)(52536014)(5660300002)(8936002)(8676002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7aipP4aCpn+X9dmWpKg6+Gwyq80gQMHn8Ts3R69Gu+4lZrUGKL4DVuKOLc63?=
 =?us-ascii?Q?lIbha2YfSp+P4xn0STroKU80hH8xNY2ifUg/ZcKoYrGBh171kLqkXTqY7Z/Z?=
 =?us-ascii?Q?+2r8j3rurBW5AtA4AElZDQ+Y8yyrwLmf1cZuvU5uRHSMDaBxSGmTvp8Vl5Hq?=
 =?us-ascii?Q?qv6L226BuL5oxSysrAtkw7yxOm90+aG6WtUtq5ivTkZt9FmFwip+1tbhSS3P?=
 =?us-ascii?Q?o285qcw8v1iKo3+s4KNzsYwTKCc7Ylg+4rgm+JmxJ+v3Ch6rabv2wXpWJlO8?=
 =?us-ascii?Q?sa8UFn1INjI31klUIb5Z9K9TvCzlkaF4612K4LIR9iZ4AML5otf6D4uICEMF?=
 =?us-ascii?Q?HP2HfhlXGvOxLgZS2IGxtBWp5m6fhgdEpApmg3seqOnJcarajpf0ilxgWcRf?=
 =?us-ascii?Q?OVkXaO+T8z4g00YZH0LNm/WN3F+rQ9r8eikQHZFC6lZLi27H5DgSgz7D4qSq?=
 =?us-ascii?Q?5oVaXzBeR37CM1v8UKIt0V/2/WbAuUDSTM899LmcYZPP3X12WEQvVkM16EOr?=
 =?us-ascii?Q?RS8gfZpbZT+isvvFUr53laRZbm6rAvAa49BmyHIZMo0VhV4NL53+oM7/17ZR?=
 =?us-ascii?Q?ksKAvDe9c/tXrknaoWs8ELbAOut7REbFtQss/s9fMV0e69z0BZiHlOoJSj+e?=
 =?us-ascii?Q?xRUTiE2aeSt0/HOvqdUqzsDKb1P/r8j90Sg33+B885v49TdGCC+GrCMws5f9?=
 =?us-ascii?Q?bbrh0Npna9E0+wp7xKamjRTcAeQ2AHk63rcjPrSWOD/faD6Uw4nVNNcojskJ?=
 =?us-ascii?Q?NGG98Bgn8S4r0DJp9vJg7ZbCE29yZBAaAO7vqooPSmvwhe97CKDESxc+PckK?=
 =?us-ascii?Q?HWfhLUFZjVjCTd8vEFpNliLIK77F85EjGyZycIcxxGXgtoymPf1Fslp9gLkV?=
 =?us-ascii?Q?yOSr9/KUeilyv8mRD2QN3wMqLrd/gy1SZ+iXCaQBkZYE5uMC0XbI9wd6Hw91?=
 =?us-ascii?Q?YcZ17GX853K2Gqo16STUZtaM1/ggHnu9IjPQk+cZWRi36TxqLapbzMkUAnyS?=
 =?us-ascii?Q?tUptAwvTDxcpQPcniFtdyO5pxlSBr4o1/jq7a3mktHwBZ4p5iux/RAasA0+g?=
 =?us-ascii?Q?E5Vd8RzVISC4i/tvgUioT3lhu+U4O1OLtAjbwXnZPG3Dqy8Mk+jJ4F1QdivM?=
 =?us-ascii?Q?ROVLNEd80wKSxAtn7iUGk5soXYM1xcCSOHOLyB/QNuKrjJw9mYzk6no1SP5F?=
 =?us-ascii?Q?mv1Xyn2GH9a3BzTqSsRjlXkjgcFQoyf1E4PQllWEzPfnx3YD5bsGEA4/RbT3?=
 =?us-ascii?Q?59EbncQVceuqpyByedDER7x6KRXlj4skPv+fs3amGqcxjptizI7dIqvCXWEX?=
 =?us-ascii?Q?dKvA8dDvkwgaSPNUGsRDG0km55t7NiDUhQAAq0orR6uTTFDvl4IDCfvH46l5?=
 =?us-ascii?Q?qO94WORRgcvDSxD0126/rFr4XVjIPtYO1xZrMDtXHHpnd4jSEgl7Iiy0p7nB?=
 =?us-ascii?Q?9kudPUHOyivKONI0eVrSkf788Tt9D1hmQ1cAgLzbewuKldwvg4WDLdz3le+Q?=
 =?us-ascii?Q?RespNPU1D6lYUV0eHi89wxHizfOV7TFnKDX+YuhtycqdNBwHoAClHwMuCY2N?=
 =?us-ascii?Q?I8LMkpOa+z/qwPnMEdc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135d6236-8aab-404a-38a3-08db6d90df2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 11:08:39.0015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+gm0+MJOYG7KcLqREy6PN3od1a2UaQOtsJ6p5Qj0AVfFYod00D+lOEwgsDhmz4VfkbyTvY9bNfD11xBqTQfMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 15, 2023 at 12:55:17PM +0300,
> mika.westerberg@linux.intel.com wrote:
> > On Thu, Jun 15, 2023 at 09:48:12AM +0000, Jadav, Raag wrote:
> > > > On Tue, Jun 13, 2023 at 02:20:53PM +0530, Raag Jadav wrote:
>=20
> ...
>=20
> > > > Looking at this I realized that entire temporary variable
> > > > assignments can be done outside of spin lock. You probably would
> > > > need another one for keeping rxinv value.
> > >
> > > Something like this?
>=20
> Almost, see below.
>=20
> > >         u32 value, rxevcfg;
> > >         u32 rxinv =3D 0;
>=20
> No assignment here.
>=20
>          u32 rxinv, rxevcfg;
>          u32 value;
>=20
> > >         if ((type & IRQ_TYPE_EDGE_BOTH) =3D=3D IRQ_TYPE_EDGE_BOTH) {
> > >                 rxevcfg =3D PADCFG0_RXEVCFG_EDGE_BOTH;
> > >         } else if (type & IRQ_TYPE_EDGE_FALLING) {
> > >                 rxevcfg =3D PADCFG0_RXEVCFG_EDGE;
> > >         } else if (type & IRQ_TYPE_EDGE_RISING) {
> > >                 rxevcfg =3D PADCFG0_RXEVCFG_EDGE;
> > >         } else if (type & IRQ_TYPE_LEVEL_MASK) {
> > >                 rxevcfg =3D PADCFG0_RXEVCFG_LEVEL;
> > >         } else {
> > >                 rxevcfg =3D PADCFG0_RXEVCFG_DISABLED;
> > >         }
>=20
> Now, if it's fully included in the diff (even with --patience parameter),=
 then
> you may drop {}.
>=20
> > >         if (type =3D=3D IRQ_TYPE_EDGE_FALLING || type =3D=3D
> IRQ_TYPE_LEVEL_LOW)
> > >                 rxinv =3D PADCFG0_RXINV;
>=20
> 		else
> 			rxinv =3D 0;
>=20
> > >         raw_spin_lock_irqsave(&pctrl->lock, flags);
> > >
> > >         intel_gpio_set_gpio_mode(reg);
> > >
> > >         value =3D readl(reg);
> > >
> > >         value &=3D ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
> > >         value |=3D rxinv;
> > >         value |=3D rxevcfg << PADCFG0_RXEVCFG_SHIFT;
>=20
> And I would rewrite these to the standard patterns:
>=20
>          value =3D (value & ~PADCFG0_RXINV) | rxinv;
>          value =3D (value & ~PADCFG0_RXEVCFG_MASK) | (rxevcfg <<
> PADCFG0_RXEVCFG_SHIFT);
>=20
> And looking at this, perhaps do shift also outside the lock:
>=20
>          } else {
>                  rxevcfg =3D PADCFG0_RXEVCFG_DISABLED;
>          }
>          rxevcfg <<=3D PADCFG0_RXEVCFG_SHIFT;
>=20
> But, taking into account scope of the _RXEVCFG_*, I would add shift direc=
tly
> to the definitions and kill that SHIFT entirely:
>=20
> #define PADCFG0_RXEVCFG_LEVEL           (0 << 25)
> #define PADCFG0_RXEVCFG_EDGE            (1 << 25)
> #define PADCFG0_RXEVCFG_DISABLED        (2 << 25)
> #define PADCFG0_RXEVCFG_EDGE_BOTH       (3 << 25)
>=20
> 	 ...
>=20
>          value =3D (value & ~PADCFG0_RXINV) | rxinv;
>          value =3D (value & ~PADCFG0_RXEVCFG_MASK) | rxevcfg;
>=20
> Try that one and look if it looks better. It might even save bytes after =
all.

Should I add all of this in original patch or send this as a separate patch
on top this series?

