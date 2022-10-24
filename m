Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8750660C00B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJYAsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJYAsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:48:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C213A7C7;
        Mon, 24 Oct 2022 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666653816; x=1698189816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=922jYJdd3RiSg3ioYA9cHNoHtHWRwUNHmQW4OTc2Yn4=;
  b=Y3CoguBVuyof1j6RPGEZxr6z6I7cuApSRG9uHnYUuwVpV2jx1PNTBjyc
   uiAJO3ieDfSZXuHcN361vCFP8eI/gfVkiTaJe/YVIalgYytAy/8CwE4qb
   RYVViSvZzscwRROQWzuwnn7WeGp/dEvRpqNtjKryGARxaUaqFUHVzmWCk
   cNaqxKFZoOWOzcqhE4zwfCTxhidsWhEkAQGRxLDcijqI+ljlggknEf3s9
   jFB2l1lXFhTnYWqgauKrGmp9QGDIXW6GG5kobbNKLdttIrK9AWe/KiBXP
   A7O0hcFhHhxMLRDAzUGqiGLOBwoLnSNa42TQzv1STd1thTePVY1Q1mn33
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="371759641"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="371759641"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 16:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="756739141"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="756739141"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2022 16:23:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:23:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 16:23:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 16:23:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nepre6UObpHokGP7PUfUqsY98XpxGoYlawkbIA7aqvtvhpb2bVERCM5P/lOHclYNOn6WdmxOx+Lon3AyWUBCsrJVeKJpGIRovr2yIlm1FgQK+y4gYhJiDNhhoMY+q+siquj3hPsvqJ1CkZCOD6UFLryx+cxtdegTvdtgWdIe8TyHCgbtR93boy7QDDLEYE2pqhDexBc3eO4RwJwYOn8sEdJf2FLZ9/pYxanuLwZqAamGrAAUjKCTASIGcxiXQT5PhFH2cFwCFvnCRfNgYcMw4+yG+YCgsg6u59ijRUvaA83WQYGsGjHzRkZbLGe0D3pGWPhvXeDW3YtjTZ/h5Y+CEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yw4Snpknchr12ICc7KfUycKy/B4dW1Pawsd8zBdx2Y=;
 b=j8bnUg9X+HQjQ0DEEhd1zRQdP25tC5E/DPvJ9EZcJ5eLAg249BREZm3xUOE7vMT1UZr8r7t/8+kwAYV0QV2gD1vlHok4H9bYHO1lMTKJEYbmxhKEoupbY4+LU32xd1hSPLUO1wpZBWRWwaeDIzNh9PlHmtcszpmagQnB3TTgN2r+aiiuVhRobFmTFzACdSYS8JMwL/NjECBgw8c50ZW5nvFMODQajk2DBqCZo+ckONOCPjz29TRWsLU4+V7yD6pfbS7XlLZyB1wzwj2u40AkEJhCMmQk4WXAEBlzO9GlkhKQTc7x6wLZ068a4C4WPBxU5JEqY9VgWr+RHP/YViMKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by CY8PR11MB6817.namprd11.prod.outlook.com
 (2603:10b6:930:63::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 24 Oct
 2022 23:23:22 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::40a1:5197:e1df:bb6c]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::40a1:5197:e1df:bb6c%10]) with mapi id 15.20.5746.026; Mon, 24 Oct
 2022 23:23:21 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: RE: [PATCH 1/1] kbuild: upgrade the orphan section warning to an
 error if CONFIG_WERROR is set
Thread-Topic: [PATCH 1/1] kbuild: upgrade the orphan section warning to an
 error if CONFIG_WERROR is set
Thread-Index: AQHY5cZutEIhoaA9LUqamYfjnx4Fj64d0OmAgAAA2gCAAGG9gA==
Date:   Mon, 24 Oct 2022 23:23:21 +0000
Message-ID: <BN6PR1101MB2161BDD7309CD8D02B71F444A82E9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221022030519.9505-1-xin3.li@intel.com>
 <20221022030519.9505-2-xin3.li@intel.com>
 <Y1bLk47I4pyEmJVi@dev-arch.thelio-3990X> <202210241031.4BB6E70FB@keescook>
In-Reply-To: <202210241031.4BB6E70FB@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|CY8PR11MB6817:EE_
x-ms-office365-filtering-correlation-id: fbe835d0-96a8-4804-6cce-08dab616bdd8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TZfmOkLYymT6K6qhB2gv+vpFQNeEabK//InJfrGIeqvlPx9URgkYVJphdBf0GK5KKbSMZ4NZHM7gKvK5h86KDK91VpW7ODuz+9+HR7AJNCNGHv3q+DbtvqF5NEO5lyJCxWsPsAiS3Aa5BePQ5g3//VHK2iPpEvUcig+HbK7td5UvJglQ3wKRl620PBpgqd/O53CZMBR8hlqmMendLMtsreiAeFf790bV2aMjUG4gqz2WgXvEzNQvXwoi1LUBBPHJZQagOGiH4oJpIruW7FXpnlo03R96J3PqQTw4dYOKhl6qKjDQMvhAP4T9KR9MV/UymHoygnbm8vzh7ogCTO4rHwLzTcVVBsN5jMlfKIpIeX3bVL1pNiTXdUQdDtixMJs3V3GGywlpVS6hINifLCEiQYYSis9qkfJw1cUQY+jlDpMqkJ+V1vKTrLBnu2Op4vBI8JW+L++ZUc6D/hFNG5dXASeBtZFv/qtKHW9tL7ieyCoUKJXQJ8zb/CfFpaaWHj4kxGSJjskVtlmVClyJ3aLwcowBw0B5n95xXbGyfU8SPdNDjsVClF0bmGammNVrHPmm5VpHv8p+PjKIl7K8SFngGto5dpbInw6BhKnqAKSN5Qs86iKOC7fc60plyPUxMfqlC/QKjMMb7JyW6B96OmCG+MDn6bojegSBHRSPgV17OfNlJNOz/9KVdyFbwWph16uIXmxTp1IYl4VexBZma9Pnc8m8DoewFXuHFhB17j9Gdo3gvB+LE0ayhISibhjfdGeykz1lSo3+4i3DEkB/zyI1Uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(52536014)(82960400001)(122000001)(478600001)(71200400001)(38100700002)(316002)(110136005)(8936002)(83380400001)(26005)(54906003)(64756008)(41300700001)(186003)(9686003)(7696005)(66476007)(38070700005)(8676002)(6506007)(4326008)(55016003)(2906002)(33656002)(5660300002)(66556008)(66946007)(66446008)(76116006)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5BODzHSva6UudsJm9UgoftwZu8SAtMJgwZsbDxX6sVmu8JLxj+KtsVLwqfdo?=
 =?us-ascii?Q?rTXYyw9yzd5axj6GX17qz99fk0axGoTf1vRuV4h5nw1/epeuXjVccK6OBE3C?=
 =?us-ascii?Q?qA0mGF+NOfP0NC5c4MwhK4+qVBa/OPZO6sUvN1GKsvR7zMhhqSxl6g/b/jqL?=
 =?us-ascii?Q?zv5b7kE88I63QDpp3Mk4L+Yi6g47eNl4qHec6jyqz/xhgAGBP9OQA+0dQcm1?=
 =?us-ascii?Q?WFkERAivyLg2iaF6waMxO7gT9+4Ukf7BgB/wSV51VD6yKJVp6pf1M+El/b9W?=
 =?us-ascii?Q?bI1kyHybVzDtN0mUHwLMfe3yzhze0cLH72swdnDaDFbZeoZ8wXjFtkltnXK1?=
 =?us-ascii?Q?37HDjmToRgoQulGf7DM74u1VMtK60yLNn++C78DG23UT8LNIPS4O4TASxu4P?=
 =?us-ascii?Q?ENlJ1BuB0JggHg4TzNrAI7GtTcD5s6G5f2hn8N/1QEt25W91nhZozb+N9V4C?=
 =?us-ascii?Q?/ruTgLYLQSOriesvIvJ2sEMkeuwWPDUBWdrkUOL3dyu+67U+UD16H3UMPAsQ?=
 =?us-ascii?Q?7f3uCsPnjSkVCJGNWyqs/gwabedh2pUEYwQDYtOMjBD3Vj2AqXOTeaY27PvK?=
 =?us-ascii?Q?tkRLfT3mKVgyoZZgpspDSCaQgX6Mh2PEvqemch5j7gVSAU38zUgD8Yd0CfiL?=
 =?us-ascii?Q?OL6+EW19k2h5cTqyV/P195B2iAXPPqNRsVwYkcrlHzoChURKu/FRtSVqGglD?=
 =?us-ascii?Q?r5keZRbcbG+E0fP7YhRGZslBx+aJs8T8fda+GJpiGr7/V7jRwT7y+zeX/YEg?=
 =?us-ascii?Q?6bQpfqdkXjCrdbNyiMGbjxSgureOatPENNn4Wa0IjjcxDB82QrLkpI/Whz9w?=
 =?us-ascii?Q?umo5qh9qvzRCJFXs3dQ1ugg9HyuRPFQQplXVGFTgqnTsxlKb6IosUfRATRnk?=
 =?us-ascii?Q?SPKYn/GuM8axF0Fybb//EViH/W3auSGxP9OuK6G4Vdxl4LMtCB0kJkVLpNY5?=
 =?us-ascii?Q?Y5VZ2UPMSEud2H2ZqdvZofkfHxrEbK9McjwP62my/IKSgjmOpVZCk1SUFcp5?=
 =?us-ascii?Q?1g75kY/vkeIb+bq1NrInO/IMxRoCR2CbxGR4iGnXbGc9+uq9FrPDNpMOLVg7?=
 =?us-ascii?Q?22Yxo2o1H7mPaU+W3D5tzIlC6OV5fzotItlcxxnaBTLZun+FQ7Rz+GnUe+oG?=
 =?us-ascii?Q?+BzkfZIB4qxpYSDiZjjjRmZumdGwTkogM24o+TkeP/eJaGfoEnZJvelnzQe0?=
 =?us-ascii?Q?nsYO594L/1YKPrTHFrws0aS6MmzfDR1Nk248KLVRMeSPfhhPtChva2J1Y4T/?=
 =?us-ascii?Q?WNvkBuPTPq1T+gjIBqD0W0WQs8rEdZX+GFph3txeJhCCXKDDP2szDvajudFy?=
 =?us-ascii?Q?56pMXPs2Nw6PJla5Cx3HGfbnFWXxocRs3mxF3pg+YthjcLm+NU2mmngmyoEb?=
 =?us-ascii?Q?11Bb/lEPfeB1iHP+8BEZTuOwrniUzdaqFFUb+1WTxzthvofj3bAt5BmVirf+?=
 =?us-ascii?Q?NqKvIrYX7QnWs2ekbByo0dWCiCjpVqxzkHkyx7W+OFNOqO3I+vczP8fv5hFh?=
 =?us-ascii?Q?LWm+QYtxN3A7pxEBgAmsVV49ogNLj3oIXqjCbLUfc1L0OLBcS/GcU/b+GvWR?=
 =?us-ascii?Q?0cX21q7cYuemplbOX60=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe835d0-96a8-4804-6cce-08dab616bdd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 23:23:21.6490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgY/KPjZoE6DXsWjEGCxF8H/Y2sR/wnbmTjf2C4gO/EwSjX6EEqmHYPhK5cX9yGGcQE7kPIJxX6h8vrchJ/Bbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Oct 24, 2022 at 10:29:55AM -0700, Nathan Chancellor wrote:
> > On Fri, Oct 21, 2022 at 08:05:19PM -0700, Xin Li wrote:
> > > Andrew Cooper suggested upgrading the orphan section warning to a
> > > hard link error. However Nathan Chancellor said outright turning the
> > > warning into an error with no escape hatch might be too aggressive,
> > > as we have had these warnings triggered by new compiler generated
> > > sections, and suggested turning orphan sections into an error only
> > > if CONFIG_WERROR is set. Kees Cook echoed and emphasized that the
> > > mandate from Linus is that we should avoid breaking builds. It wrecks
> bisection, it causes problems across compiler versions, etc.
> > >
> > > Thus upgrade the orphan section warning to a hard link error only if
> > > CONFIG_WERROR is set.
> > >
> > > Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
> > > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > > Signed-off-by: Xin Li <xin3.li@intel.com>
> >
> > Thanks for the patch!
> >
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> >
> > We could deduplicate the '$(if $(CONFIG_WERROR),error,warn)' logic if
> > we hoisted it into Kconfig by having something like
> >
> >     config LD_ORPHAN_WARN_LEVEL
> >         string
> >         depends on LD_ORPHAN_WARN
> >         default "error" if WERROR
> >         default "warn"
> >
> > in init/Kconfig then using it everywhere like
> >
> >     --orphan-handling=3D$(CONFIG_LD_ORPHAN_WARN_LEVEL)
> >
> > but I will let others decide if they would prefer that over the
> > direction we went here.
>=20
> I think this makes it look cleaner, yeah.

Agree this looks much cleaner.

>=20
> --
> Kees Cook
