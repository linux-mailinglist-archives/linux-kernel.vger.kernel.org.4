Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2CC73B4B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjFWKJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjFWKJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:09:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968D235A3;
        Fri, 23 Jun 2023 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687514875; x=1719050875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5zqtVit91Y4DzeE9M/b8Chq464SRCJdDOUbigI0BCH4=;
  b=CTQuzGCYBwLfpjP+bHAqtGIFdGqnQexgVK1wqVlccg0AYNWJGVgfOzfw
   MW6pA/qMNkxgpBCdQMnfNoBUISHZ+Lv28GyHsTqNTweIfwm1XpLOk5hHR
   eyHUZr2tz1U99Q0kSIWQIsJZ2qmSeXfN64Nyis9XulpKjDPoRMk80tvdH
   xrjBtdngfh+ffGe6HixV6MXCKVv9ryammic9ZNn6i6gSKBpVvPfonQFW7
   zRHZTqTNOcqZgkjU19toNprJy8XF5W6IUtZVNWepq2tZD6gaI+SGFoDwM
   /E2rPy/ldQBGvxiQhLiiWl5jJQwi2QyqjNRXy/svQxCPlRcA771nmPw6w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359598292"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="359598292"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="889428316"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="889428316"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2023 03:07:31 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 03:07:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 23 Jun 2023 03:07:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 03:07:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPTdrjHRJHn/l1O182l/nuvz2UZVhHJ/YZoxMuJRbiBlbWEeZUzqqLLoyplemiBzDBOChRk5u5LdiTuraQ93bzylAGtJtOhejg8/Sazs6nT3Qwohse6IHtlhqXqaAmC1YunXon9CEFTfi/2r1w13OyZVQ8dliYNq12UatEenP3OoZ3qqYEcTcbNPmKZrOWDX0jQMGP645dtg8MeDNn28Y/Jp7e+1RJ3oJ3PGtvB8LmBxLw879+jS1bEhSBWDmxKrEVVNf7MUORX/9Gp4vWfsLONMliqsb4o2XXW52nksWiYLq0isdMJQp/Ub/HB83GD6CEeBp/dkYP1szmF2o+FrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CXzQXc/I7XBAgnESlg+8q7KFD09NZWtXQSpav+TW5s=;
 b=nvOVGAphdqkcw+9wnJZzdEO2FW0eslJUM43cOxSpJ4uxklRcBsZdayKYFSUdeuptGncYU2MMAUpcnFroH74ZAGUXnIbv1uVakomKvUq2/ilYgimFT8jo6tpOr0qKqFkVVV/IT4pgt/ZBUdt1T0LUUwrHz4t3D5Rtjtdq6Su9pMuxBUIX+Ez4MhWcbxfgbyn/ti/2kjlBAYKYLNyKCXPXub94NVXdpVZosui9cSEKqnpOyIxr2vQN8BMPeUfTj1ZsSi8RSDgDUdfLdSBkgRxs0MlTSwL8rOH754EvFriVy2ILLQAjbJJj8wBxS3sPwKWoQ798+Ty05Nj/XSo2TG8VCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 10:07:29 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 10:07:29 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>
Subject: RE: [PATCH 1/2] arch: arm64: boot: dts: Updated QSPI Flash layout for
 UBIFS
Thread-Topic: [PATCH 1/2] arch: arm64: boot: dts: Updated QSPI Flash layout
 for UBIFS
Thread-Index: AQHZpOcYZtUFqZ6fuE+XlvkVMV11dq+XMvYAgAD3XaA=
Date:   Fri, 23 Jun 2023 10:07:29 +0000
Message-ID: <PH0PR11MB567331CBF3E1FB1315F25A7CCB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <20230622085319.562868-1-kah.jing.lee@intel.com>
 <20230622-campsite-uncloak-37c292c37862@spud>
In-Reply-To: <20230622-campsite-uncloak-37c292c37862@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|MN0PR11MB5963:EE_
x-ms-office365-filtering-correlation-id: dc344b0b-4931-4ce0-0e71-08db73d1a720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBXno+g5xluHTo9u92AKrKwREwKnM0/QWqi0r/uRcWlHh0hItDoVwNOpOkDrQT1Plp4hW5Y6BwSAR508pX7CHduxjsInnGVwuZX0IFDczHyopYrDqN+hkNAwsfKeO/pIGgZRkJiGtYIzC6lJsoPhKYALBHleGX79dhiuj86SQOVrKsARvXxnGCsTOZrni0uQPLH6VxPGtHhoJ/kJpjK/KtE1IlyTdTdP0QKAsp4qwJF5CWZoHH95XWz9wjFOoohgHdJCXbPY7EIc4DAeVEegJEILoDHYodR1H+Djb0qLINuMg38HJbzHfT5QrjOYYhlxH8i7ok2KZQc1A27Ac9BDfQYyR5Xb6AQ/kUbk6POqGzffMfYHSDuOMcq0IjMZseMATW62SXLTyqCmIT7LV7ipzcIZavuejY6TIMGsy8KsbXs2euENY6pby3JAZa4L4UHP6ofdwyGNtD5fYBHaYEKTEv/5rQ9h7DpxDZM20+D41BbDp9T2xCDBiprHIBnX2Zga7a3Wd7H6dox1C3LNDtNmZHAOy01CD3pDhWH1IwuGFXBdk8gg5hbePMq189SaKMHE+s92Kofb8aVMUrScQ1E7FPeqt0bOUrC3VF/6cZNnzaOu2UlDIH3191jibagjlvYD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(54906003)(478600001)(55016003)(107886003)(26005)(9686003)(6506007)(53546011)(7696005)(71200400001)(5660300002)(2906002)(33656002)(15650500001)(4326008)(64756008)(66556008)(66476007)(6916009)(66946007)(76116006)(66446008)(86362001)(8936002)(8676002)(52536014)(41300700001)(83380400001)(316002)(38070700005)(82960400001)(122000001)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gi5RvCyXtA6lx/vNGud3ZeChg3fOQPkpv/uogCXqpAXpBrGFhFv8Yq7AkhAV?=
 =?us-ascii?Q?xJWmeQTtdWsq/Y2O2jkHmq+KgeG/xvAB1XT7pZd7L8IJfwkS0G85lKkIqno/?=
 =?us-ascii?Q?421rlWP/P/M79Wz49vvkTH5oI/IKwSAcJtQzQ2EyQ1Ur+zOR6BaXQkhzTcru?=
 =?us-ascii?Q?OfDqSAexsyS9pEubxwrT3PlLiEvJL6xAkk476ixCiGXcOlyS/thsIPcIHoOR?=
 =?us-ascii?Q?dOtA/qE6ht/rch30E8K/r8BNpZhK1KjiMV06waQr5BH3NN1ScwoGhBO+iA3j?=
 =?us-ascii?Q?itre1jJ0A3UUteNjqMxDcv4sPFqZScBCLGVSGvyhHBzFefQRcxf1Fn1Khjwz?=
 =?us-ascii?Q?2MlZnrLe6soeEz5Uf7ECWkPn5+/uEPSC21ZqSaQbA8DoruQZbNu/oHdyb5D5?=
 =?us-ascii?Q?q+35+F92updBh6vhpNsY1qPGtyINlKzadeqarVOwEC4foVyV5uzq6uRVkLDB?=
 =?us-ascii?Q?BgVtxL2xLyn6yCHVIR9JvUtz3Fyr/Ht7tEaKMP8anwXcgyUKHr+uEn5u3ouF?=
 =?us-ascii?Q?Tx7reUrX7n2l/kMhAjpLGeCv2K+Xf06tEVX0oSCWtDd7B96BQnpNN2IkWOSg?=
 =?us-ascii?Q?fXzaBpjtW+gOacWvb/G8yC9X8onPiY2YMeCVnvKQIVTBsft+jhLKTFqibj2y?=
 =?us-ascii?Q?jbfu4uIkWQMXzyQYWnmsx0Ak5jwF5xtP6ThdZYa5YDXrjMkS2BuAwMhYSKhL?=
 =?us-ascii?Q?XhkWA7OEREC+MKjLnZMu7ply+TRYhrvqA1asbofGTrIMTyReYGtJehB7keeA?=
 =?us-ascii?Q?lKEVrLHcgm9qwBb2PXTCiLVL55GN9xcCbT4lZLhqKsuBE13gUzDzmKshORi4?=
 =?us-ascii?Q?BzP9OD2XK/u3Fthw73BtRYyr+KMN6JXUMTRyvMQnw0npWU7AckPlybdbvIiQ?=
 =?us-ascii?Q?FImU+S3culSebp9Gi3B3VrSUU4bCz/zeC14N29vdP3ume6uHReLGYqeWGWBi?=
 =?us-ascii?Q?sNwwb5UPqzNvle0sj5IQrZp1m6u+64C/zJ1yWFXbjNyuGlL6mQFUS6pcYYKY?=
 =?us-ascii?Q?9lLeu199E5BYaTGxAxUgDmV/80EEyOjWXEeJCrPbDfGMRnx2UQpACmWJQNdX?=
 =?us-ascii?Q?uYY/VXVdaWIpzjiyhEkX6jRRbaKuFUDti7CG1kzyYo3ZXUvQ+t23tRk9AqOz?=
 =?us-ascii?Q?HFn1DzSKWaOAFXl1WT4jp95m1rThFGdMxLadysvlQ3PobLCML//rjWKRpkLR?=
 =?us-ascii?Q?lYXpMbfS6Oqrqzq6zF/QxTZKZcV/lZPtY1OE5uGCLxATajS9qOvZylZd2p2E?=
 =?us-ascii?Q?8Lhvfcb6fJEkgfZY5JgCIsnm1xTflue2e5S2j4mK2JTgDd/5BqO9wDj5T+QC?=
 =?us-ascii?Q?foHu9bccRDK9lS3AAMGLGEFIaQWoM4ZNdEGhFqYw6xRajYO4Ewd/gGRis/Ny?=
 =?us-ascii?Q?1rOdiwaoWVa1BaSBlFTvQRblQZaLBcSZm05g8sh/LH3TAFUlmQ2eZDnVcZwi?=
 =?us-ascii?Q?A2gOdom0t+mbyapdYcUdUfytPq2A64+SmEwpDEHdsg+PWoQwA3mAR9mJtbCS?=
 =?us-ascii?Q?ZrCiksUeCVfIxmCMxO1lUHosha3rC5eALQXVOjOxhJ467zXrfLdhzj124q6k?=
 =?us-ascii?Q?z+Yrhcc0bsZKlgmZKCs+VakOCDTGJDpuiDG9ZPQ4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc344b0b-4931-4ce0-0e71-08db73d1a720
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 10:07:29.1813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AHXzGwSvbxlNS7639Nrvw8qhlvqyE0JYR8z0HKtZVAhIXxL1rL2C8GLv0nrF1sPBhnEDTIi0ODCmVVwBn1kVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5963
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

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Friday, 23 June, 2023 3:19 AM
> To: Lee, Kah Jing <kah.jing.lee@intel.com>
> Cc: Dinh Nguyen <dinguyen@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Yuslaimi, Alif
> Zakuan <alif.zakuan.yuslaimi@intel.com>
> Subject: Re: [PATCH 1/2] arch: arm64: boot: dts: Updated QSPI Flash layou=
t
> for UBIFS
>=20
> On Thu, Jun 22, 2023 at 04:53:19PM +0800, kah.jing.lee@intel.com wrote:
> > From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
> >
> > This patch is to update the QSPI flash layout to support UBIFS in mtd
> > root partition.
>=20
> That much is clear from the diff. Surely it'd be better to explain *why* =
this
> change is being made, no?
Updated in v3 - Commit message:
Update the QSPI flash layout to support UBIFS in mtd root partition.
Flash layout is updated in order to store non-UBIFS related boot and fpga d=
ata in
qspi_boot(mtd0) while keep the rootfs with UBIFS in the root partition(mtd1=
).
>=20
> Thanks,
> Conor.
>=20
> >
> > Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
> > Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> > ---
> >  arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 8 ++++----
> >  arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 8 ++++----
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> > b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> > index 38ae674f2f02..12b960b9183c 100644
> > --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> > +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> > @@ -202,12 +202,12 @@ partitions {
> >
> >  			qspi_boot: partition@0 {
> >  				label =3D "Boot and fpga data";
> > -				reg =3D <0x0 0x03FE0000>;
> > +				reg =3D <0x0 0x04200000>;
> >  			};
> >
> > -			qspi_rootfs: partition@3FE0000 {
> > -				label =3D "Root Filesystem - JFFS2";
> > -				reg =3D <0x03FE0000 0x0C020000>;
> > +			root: partition@4200000 {
> > +				label =3D "Root Filesystem - UBIFS";
> > +				reg =3D <0x04200000 0x0BE00000>;
> >  			};
> >  		};
> >  	};
> > diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> > b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> > index 07c3f8876613..608017e6e36a 100644
> > --- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> > +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> > @@ -128,12 +128,12 @@ partitions {
> >
> >  			qspi_boot: partition@0 {
> >  				label =3D "Boot and fpga data";
> > -				reg =3D <0x0 0x03FE0000>;
> > +				reg =3D <0x0 0x04200000>;
> >  			};
> >
> > -			qspi_rootfs: partition@3FE0000 {
> > -				label =3D "Root Filesystem - JFFS2";
> > -				reg =3D <0x03FE0000 0x0C020000>;
> > +			root: partition@4200000 {
> > +				label =3D "Root Filesystem - UBIFS";
> > +				reg =3D <0x04200000 0x0BE00000>;
> >  			};
> >  		};
> >  	};
> > --
> > 2.25.1
> >

Thanks.=20

Regards,=20
Lee, Kah Jing


