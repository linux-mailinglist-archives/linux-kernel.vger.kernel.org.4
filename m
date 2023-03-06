Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE36ABDA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCFLD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCFLDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:03:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D77C900C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678100604; x=1709636604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7bln0cpmS3fKjmbSYh1eBYZcg93fgwlzPYpRGSXphkM=;
  b=KlR8oNKK2T+VwQjqi6U2sJ0dFtuf34VHt1+3sSY/cfOInUmpaxcq+cix
   lh6JIZWwjvCZFnXZWYwYzHYHWZCWvbo9DUykZ9O6vTEns5XM/dg5/Tpeq
   TyoO/VjRJ3EmWT/FOpnuXzUWOXBE9f7QkENVkhIscKveLmH2FXeSuUxu0
   LLgRfACrto4JylvsdS5L8zloEzitD9ge33zsMAi7ZfJXxmSLrZw1v3eaK
   j0HfPzr317yMgO0hA20Iko7qgee2F+2ULk671jt0QEdO8sY7faG3B6ekx
   G3Cnf01Pz/dCQZPpGCCwGesqmTgCpYexhIKoolbqpRBfngkmbXjG/sHGB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="334241566"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="334241566"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 03:03:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="850253046"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="850253046"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 06 Mar 2023 03:03:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 03:03:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 03:03:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 03:03:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbVDa0pLVM2iHiuXysmd9B1ZWX4buu6yioeBp7pXrnmw7ttAWf7Q+H02ZGGFUqpGPy0tBfxG5kddjZmWd41ESxkjv+By8qxRnjDl6WNoER7PtchdY2mstkLF7st79UTD8kfTWTS0TidV0xbVj7LPvC+/nGB+oJ+ij8PNm3LM2OdiVYtHGCMn+fIVaICch3OE0f0z94nrnjD2hRpJezDHR9HngnOD/rGh4K1K4rLjBJr8TpomXeX8NzFdoRzZwGn3cEvcTAyWpQ0n7yonGQDZ2xzeaCvh0G3q/AOlQ4JPvd8cCtfK2FQ/rMSEvHQBhfREVOGxUzzmZE6LOFFZxhUE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF8etV8nggYsjcAuqZ82XPlFeQiEmV7bIvYVvwCThWI=;
 b=bYKoZTywvsJQxWXOs9tAJDjJUkTm47xIQgiuBHxmPazjjWoQ4/yr7RtmSEIYDkKzns527hIbmwQjGBYLvONDOr/7N2A1/7vw6eNGBrhDMhtIpXjWmOCuPz0585dZujUiYZC2dshb7D1zhsLT3EmQ0AjoJGPZsfABMhe+hpGrOzs1qInacZLIk8fx+a4I+XCkqVGLHZcUbEwe3UtbF32ImgB/Q3hmLxpG/xZKf/X8rdRovFSvkZegicxwmm+sMedSM8NpQK2wZYhxZroy6W9JKbVTViksgKUf6yqOo7DiD56It+WxgXvauhnoHnVn3H8j0ch/ylYUc0VRNoKDj+hHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SA1PR11MB7700.namprd11.prod.outlook.com (2603:10b6:806:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 11:03:20 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::7f91:b0b7:7b23:fa58]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::7f91:b0b7:7b23:fa58%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 11:03:20 +0000
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>,
        "dmatlack@google.com" <dmatlack@google.com>,
        "mizhang@google.com" <mizhang@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/3] Documentation/CodingStyle: do not use data type
 names as variable names
Thread-Topic: [PATCH v1 2/3] Documentation/CodingStyle: do not use data type
 names as variable names
Thread-Index: AQHZTlCTsdfgmYhoBEqWM7ucxSddLq7qt9gAgAJWq/A=
Date:   Mon, 6 Mar 2023 11:03:20 +0000
Message-ID: <DS0PR11MB6373E6DC5F6FF3EB4824668ADCB69@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230304041932.847133-1-wei.w.wang@intel.com>
 <20230304041932.847133-3-wei.w.wang@intel.com> <87mt4szhk5.fsf@meer.lwn.net>
In-Reply-To: <87mt4szhk5.fsf@meer.lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SA1PR11MB7700:EE_
x-ms-office365-filtering-correlation-id: dd5cc1d5-e507-495b-e18a-08db1e32657b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Srz2kijFTC7pA7ZefdzgsSrtI7juCukzXXlXNAQNlXTgPrpkrh0Kpdb5OT8mYrRQNwjjiOf1OFZjlTuEsV8CdhuXFkHjrXCzJZjl7Ah9XscQVf+p2P2pgvGpiJJkpt79HJo5jvEfb0p7eQJV7ioRc80dYhq+R6t/znfg6fB4iqrxmzly0mBpzJ1uRauLMrQ2P45PN7mwwjGhFC2rKhTpUZRlEAy3x/Eoh6OfkoHeR3yb+APKNpsP1eCju83c1S2FT5GyzN3OV7M4YJrzLqpp0kzF7U04q7cMUlMdEa9dFvx1gON8XUzzIernCpMabWTlaA/GduqZ3zFH8pe7MWozxV1emlu6BVtr8hgxM7KR/lFFsCRnNAow5cOrdEF+iJtp7LKyvrOehNElmmwz8YhnEHYQ3sD/n3Xb2VmO4BABTrzKuU46oPXUEx109PlA3NgxYlncceXPpKm+6Wuvg/zz9ks63hd63w6kBPGtPMSx8UDAGAcI8LtnpW4y9Ou/HC/cTvFEz9hdIUxtickwiucoTxp7qEClrE6Bk32QUUg0tlKZQ1RZuEWJKT0nSC1etPZ5WrtuHom11cwzEsJs4dQybnk1GJefPJvH/Eha64D0rhpg/sBR6uBVH0BbdFh8GEs5SgjYZTe6sanghAJbPvrsi+EfkAEf2JMztonFDoiJykgu2f6sbjADICf1qjvF8psSc9AqY5pXuVeRc0G4J5rIir5DfBNxDPq9LuLahLYE9Vo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199018)(316002)(478600001)(110136005)(7416002)(5660300002)(8936002)(52536014)(38100700002)(921005)(122000001)(33656002)(82960400001)(38070700005)(2906002)(4326008)(66556008)(66446008)(8676002)(66476007)(64756008)(66946007)(76116006)(55016003)(9686003)(186003)(6506007)(26005)(53546011)(86362001)(41300700001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Au/N4kc5LjfrOdP+TkIJJvPTeZ4ebyn3bihCOZM3U/neetzgleNg3TtOlvqI?=
 =?us-ascii?Q?5p41GdIVnN8EvwrDYzcEqa69cVjs1LcmqaK8CZOdFFzs7ag6bEDaDdCzOToS?=
 =?us-ascii?Q?7iUlEyMgArSJmXI1aDhMtzaP1oTjVgNnyyhE1uTSCqRF2/+UeJ3WZTtGeB/e?=
 =?us-ascii?Q?t8LXrjdRZxdNNImjfG/FJ04sc15YL2hlFSJXz1fHH9KG7l5EY1Zwit65UEAo?=
 =?us-ascii?Q?zYSscdlKwOyz83Dv2ZLqkyJOL2xH2RCHjTpuTugcWzt/KOxD/WuxfKTQwOAN?=
 =?us-ascii?Q?DqcROyBzeAhDRImB8c1ENwvuuN5OHNmdxv+Iy/Ul2U3a8UiETOVlYUHpDewE?=
 =?us-ascii?Q?mSo/9uxP6uFcjBYPb42goBbNnXaHKYCyIB1fNJB37VZ+e2EiqIcXb+OYbAqV?=
 =?us-ascii?Q?rZ6+4Xn+47DzOpdCKm/9QIm9OPzYpH/l36a3cQbEwXNCPiqFNYxfH9k0LRTF?=
 =?us-ascii?Q?ILhisaL5RpnY18E+qyvasMI7NXVjTYmQSdVNWdRqHkB0r6E9Ht1LZMPX8UWa?=
 =?us-ascii?Q?vrECdeP1GtcBkZKS6T+Xo38UhoSSLb/coNtGCuJ6aF4roLbrrqGCZs+wcU5R?=
 =?us-ascii?Q?p6bXokfmtAjXT8SE5PuKJUNLHIotfgf/vwmGAucIQWWjCF5rJ1kZaKOKQut4?=
 =?us-ascii?Q?5dudAFVO6inx2s4kfQTKg2TgyDNoFRgMNMcd4U66HgQ/9T6cSWOnfWXpimEX?=
 =?us-ascii?Q?WsOaZTIKlRempn0KD5OWhwZ+nsEmE56b37BdbDf+LFgT6c1ctoyGxuc+YePo?=
 =?us-ascii?Q?oGiZbjTReFIyktLifkj5axj53wd2PlGm9n2UUN414CJTlIXquyqr83EA9HB0?=
 =?us-ascii?Q?JZiCKlBpeVrbuDJG0u5s8fOucjP+Hh1y+nW2Pvybx/QOtX9K4WzG1BUGgjoj?=
 =?us-ascii?Q?vjjNsQQotCcloohxmglZWYtm+zB9srG3DFPUPQK91m8i52uv+NMWmMcf1DUh?=
 =?us-ascii?Q?xbxYoS05+tBOmMzGiOv9dD6UXc4f9MYx3uB/qdeBgOF6rbB5MID8SjEy3ZIQ?=
 =?us-ascii?Q?dvIwBjxxLdGewNxndtV9hHfn43zQk+5okm2CJA+C7k+GLkH6MedgpGbkTAaz?=
 =?us-ascii?Q?pRhCGwOtwh2WCqOhwFGeNWtGn60+77XbmBve4mUTF2ra43rmwt8ld37DHhus?=
 =?us-ascii?Q?AJRpmIyjrW1gGQWnjjSt91BUE3Dw+AGiduaqrFFhJrgZbP2y4V8VmtD7Vt+U?=
 =?us-ascii?Q?0O9gTc6uH/7Uxjga6+A+AVNKs79ePzpD+mR6H8IBnP2qR44B9CY7DxjuGNlI?=
 =?us-ascii?Q?DrqLQsFjU7Zfghlm/y5UEYvHXOJqMj+vTwdVF7FB3EpwG47nF1MBtYDFt7dB?=
 =?us-ascii?Q?e/Mn5KrUy3RzAYe7NAItEhmXKpU1his1LVhJzuobmNvmxYHlxK0cwIXVTSEv?=
 =?us-ascii?Q?sgaiMwHGmwwAzKlqiDzqaMWJI1p68mjc9fG0UMS9aNPl78lpb8hL+An59thI?=
 =?us-ascii?Q?hP6S9vt28h4tRR73R6tysIUYH+/fao+jLAg4alo+JsFVkPfmTU+hIi3YKHrT?=
 =?us-ascii?Q?yT8kz+1upxzAp4YiOdg+q+FQOOXJTS4uSvLhnv6i4uBFuZTuu8+f2TtfBrDV?=
 =?us-ascii?Q?molPDTNXAdeqNp1YM0l08v8Dp/EiqLq/CppdH9ts?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5cc1d5-e507-495b-e18a-08db1e32657b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 11:03:20.2560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npKRRrsjYk8XfKi6hVyPXnHAsh77k7PCEqtZ8FOLHilS3zdZqLCKV1XGtt6bT3pPL3fIUmZcYeiR62H5jBEgZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7700
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 4, 2023 11:02 PM, Jonathan Corbet wrote:
> Wei Wang <wei.w.wang@intel.com> writes:
>=20
> > Observed some merged code uses "bool" as variable name. This is
> > confusion either for the reader or compilier. Add a rule to have
> > programmers avoid using data types as variable names.
> >
> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > ---
> >  Documentation/process/coding-style.rst | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/process/coding-style.rst
> > b/Documentation/process/coding-style.rst
> > index 007e49ef6cec..6d7f4069d55d 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -356,6 +356,9 @@ specification that mandates those terms. For new
> > specifications  translate specification usage of the terminology to
> > the kernel coding  standard where possible.
> >
> > +"bool", "int", "long" etc. are specific names for data types, C
> > +programmers should not use them as variable names.
>=20
> It seems you found one place where bool was being misused.  Fixing it was
> certainly the right thing to do, but I'm not convinced we need to add clu=
tter
> to the documentation for this.

OK. I thought people would not name it in this way. But it indeed happened,
and I don't find we have such rules officially documented anywhere.
Fine if you (or most people) think that's not necessary, though.
