Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4641B69303D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBKLSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:18:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7668C2DE49;
        Sat, 11 Feb 2023 03:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676114295; x=1707650295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eDmw5bcgyVUKVhE0KY0rDrI1DNkn1CPkERaGpw1wRxw=;
  b=Ss+s51CQpcQk4mMnQEBhUMJRoLsm3QAser7HP5Fflx7L3y72noGDcF9E
   hCi5dAN8vJT/BSEFWPzxOqcoAhxEBV+c1t0FzGwuXcnUF/+1+BWl1sPhB
   nQDDTLFHS/ECvfCt/YqlqCTpON3HduCpFiVey1BYy/LO0ZPKlLI5vCfxQ
   /s3dP9TyFOFco7KsfsKTEDUtIYNn6L/Qq9KRtmu9xdOnW9IegJIyYraP7
   GLwamyvvfas4yMAtcADSnYeLB7e9VYOca/ia1UwplKU7+0PK4EiHL11uG
   Nwy61tj5bzgccMQTVlVmZgl+xStup+A1bXMzCSBcgCVRMClUEbrjzoQK2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="314243564"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="314243564"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 03:18:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="913804760"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="913804760"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 11 Feb 2023 03:18:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 11 Feb 2023 03:18:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 11 Feb 2023 03:18:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 11 Feb 2023 03:18:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSLQvYV8vsb4K44umvhI7SDlBDFWhaniST59R4RMsdPnxBtJzFR9XBlWKzIzNCjCwEVcihW3PWzISC5D8cxA51FQ6C8JUFAjKgwgXZEvfg3JsUnLZK+WTNDUUiaGl8d0vgNA1ZSiemPAMWs7wbv1EoNXDi7KCy9qMBrZHXrWDxjzKQM+VO4gT1f+A1DlzMV7uo+rC871rwJAmIlRhX29IY/PSvEluNvq/5SmF9GKZotUBoS4aoItzESkTe0GBiphxrsH3WVC2aTqseBfSmHZF2etxo+5KH68X6osJHPp3otTUsH6IARfKAoULv67O5J07qhpBkcG24v/I2oZXnPOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDmw5bcgyVUKVhE0KY0rDrI1DNkn1CPkERaGpw1wRxw=;
 b=WG70UC2Ii/CO1oDPpRUYnzHgbicT4k++2+v90RopemD9cKdS+r2nmxYDvILK35QLLA5utX0kdwAfda3nxp8yWXBt6fuQLYHXMJv0sQfP0qsgtNvQQZG7VoP3TAm3ogKm7JuA610PKEx3ddSXa7iD6ygfNBB6vlrI37Z/NF24LXCov7+AYk3EDrfBqbBgJrhSCaYkopuoWaeO328dYUcsARlbhW4Zg+3ntj1hYPtAj5zK/SNTonIx2CxOgFdwh+JaIQ48bPA3d4fO2H4e1dVLXvhizJ631ieexyz+X8pSF0iTQXMHalT5ibEvzo9Cjka9arkqysuIJAGAIHNIfsGYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MW4PR11MB7161.namprd11.prod.outlook.com (2603:10b6:303:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Sat, 11 Feb
 2023 11:18:11 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%3]) with mapi id 15.20.6064.031; Sat, 11 Feb 2023
 11:18:11 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Thread-Topic: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Thread-Index: AQHZOD9ejAi0bsndXU+9RwTFzHNkO67DfmEAgAVk4YCAALWhkA==
Date:   Sat, 11 Feb 2023 11:18:10 +0000
Message-ID: <PH0PR11MB588015D6429D592BBD599733DADF9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230204022051.2737724-1-joel@joelfernandes.org>
 <Y+JQ8GX82Gn+7ZWe@lothringen>
 <CAEXW_YTCZO-8pT2ixnDmbVaLw31J4JRXieEGvFPdo4P=1GJPLA@mail.gmail.com>
In-Reply-To: <CAEXW_YTCZO-8pT2ixnDmbVaLw31J4JRXieEGvFPdo4P=1GJPLA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MW4PR11MB7161:EE_
x-ms-office365-filtering-correlation-id: b8ac3196-6e29-4e78-db95-08db0c21a8c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tm/24dd3Kas1qn8zCmXisAOB8WRoDEcTBe3HROJ/8v33OKiyIhLpEhcBNCl86ci3ZcVy9PfOn0CTytphcxNbr9+q1aRvPBMqRuR/kBQOTTKlCDXcJERVhCE5R6kPJcZGLh0jlPN10hECAYvRApvGZ7+Woxh0Dd8XxtQFpHAZ1UMveq4SN+pqvJpGcQGKNFqozVpyKqXOjHbv+xDN2UKDA3wC9kJ7IKtIzgvR8YVjo5sDnXL3RGDCzj7viu+BX2fUCxaVlq/f48YyOiRy+BrfsZTl42d/UV8yG6EM2Xt7/0NcNDybsU8t0p1woG7iW5ux5X+ToyeaisRX735bNWbAhxgm31fZ+tY12+2lSPIrrN3wOnMcUHzblMSwLuotkuD48pYTioIYqEtVvAiCtT8EZBX6Oeg2WdhFa+ElmTkQBik+mtJx2cHyFXPFt22PrvBejPwRfdkBlbffwDLX1XSGPaVwG9rGepQAHzDqQ5oE/5tUwj6P822NdVxeKe6qKuxGmNSuIUy6tJZZskQ2nkgZbwhC1I3VRQAWfrz2Qyj3XZGiyl+WBocrp869lbx1MQzXu8bm2Mm24q5nKGGdfeqGsD+vUaytQsy94o9Iii+o2yP+bkokdK0wXEL7nCpbRyloCHx2auqUoFLFEECu+12fvTstUZp+hn1fAMXUPBU9uZdCfoYceYqAdiV7qRhc4D04puLylsIL335AMaHyOLdAYzuvVUR9TUgGuX3/02XAN/8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199018)(9686003)(4326008)(64756008)(8676002)(66446008)(66476007)(7416002)(66574015)(8936002)(76116006)(66946007)(66556008)(26005)(186003)(6506007)(71200400001)(82960400001)(38070700005)(86362001)(52536014)(41300700001)(2906002)(5660300002)(33656002)(478600001)(38100700002)(316002)(83380400001)(7696005)(54906003)(55016003)(966005)(122000001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFo0eTFHTFBhKzcxSHdXczNKMjl1VGdIT0poUnlSYkl3TmJiUHFjZTdHdFph?=
 =?utf-8?B?OFhXSmhKMXYxWTdZL1dRRHAxTVZ0aW9zekkxSEdZa1gwb0dtcFo5TEdYK204?=
 =?utf-8?B?OW0zcmJtWVNMQkhaR1pueUdPWk1kMFhDcmcxbGl5blFwK0pOQ2dldUk2c3JG?=
 =?utf-8?B?QXYwWEVyWHRZMnZhQzRCT3VRSk5UbFVwVTg4Ui93dlZXVW5IaDRaL3pGNWla?=
 =?utf-8?B?ZWp1bTkrWTBtb21QMFh0bkovR0dIdm1aYVlWWnp6K00wZm1rUVNiQmc3TFJr?=
 =?utf-8?B?MmlTZURFbmQ3eHJwYjgvSXN2NnduZVExZFM2Z3ZnU0R5VXdNYTdmclF6Z245?=
 =?utf-8?B?MFQ0NXBUT3JXQnQ3ZXM1K04wbTlFcEJoR3BtNHViaWljZHNzb3FWTyt2b1BY?=
 =?utf-8?B?R2Z3TnB3NGVGeEFSVnZQaklSWStEaW8xdXBwMG1vM3l4UHNyYXpTdWhEMFdN?=
 =?utf-8?B?eGpPbkllRWpoNDdpeWlrd0hIb2tjeUlBczF2VGsvOFVsZFdYU24wRzcwaTJ5?=
 =?utf-8?B?V25obkpMWUtORGJyUmJ6OFdobjlFd3FrWWxvNU00WmkvMFhlVnF1dEdmSnZi?=
 =?utf-8?B?d3JJRkZCeDVPeU1QcnpldTZMQ2VWb2FPWTFneDJOeEJENjd4UFhQaTE2OWVL?=
 =?utf-8?B?Q2tQYlg5SEtuc3ZBWENQVlRDWGlPVWFabVJ0WXJMQzhqZlZYUWoxL0E0dWhM?=
 =?utf-8?B?bUM2SzZzbTk4SUVYNnYrTGhqWFE2UWZaTFJUaytmVTJ4SHZSeUNqeGp5U1M1?=
 =?utf-8?B?TmhvcjlJR1Fmck5ZWVRmaEdkN252aG95QzVLNk9EWHpidWNhM1JuQjJ2UkVI?=
 =?utf-8?B?TUNUMTVpMjdCcUlPYzBrSDJSUDZhZThweWYwNTlsTmU2KzRnbFpMMk9Ca1Rt?=
 =?utf-8?B?dlc1d3E1NzFEZkY1Y09vdDVjU2t3aG9rdnBkT0dFKzdITGZIeUU2WFdoeThN?=
 =?utf-8?B?RnRmOVIzaWFlVmFFVmFHeGFhSWEvWitoTDRpRldvNlNDWkUzL0MvR0YzM21M?=
 =?utf-8?B?d2FWZlZOa2ZvSk53T0hwcHRtbU9iSFpkSTJJQ3Zma0daTkVYdHhaMkwrZEp1?=
 =?utf-8?B?ZGhkYWhTRGJqeVlqUFBFWEFIQVpYenY4bjQ5Ti9TZjd2OEk3SEVOZWRaazBT?=
 =?utf-8?B?UFJHZzlNcXZlbWd0WDhqcUdxMTJFZWlkcmtoTVptVDZFbDFvaWt3T3RkRTBv?=
 =?utf-8?B?Z2YxT3NrZDJsRHJGMGZjSW1IUEYzM3lvQUlzTytGR0pRQ0JhK25jem5vNkg2?=
 =?utf-8?B?NndGN0t2N1gwa1BLelRwWFlXUTYzbmp6Zm9RcmZ4QzBTOU9yOCtxdnJNUXA2?=
 =?utf-8?B?ZTZlWUNDTXpGSUxhTi91MkhYYWN4eEJNamJkT2k5Z3JUV2hTYmFxRlNhU2dk?=
 =?utf-8?B?djR4WTRsMGdOY2MzVWIxZ3FGRGc5bTJwazIyNGpqYThYSFRVc0ZPc1ozQ3Nz?=
 =?utf-8?B?QkpJdlJubUtYR3lOdFBUK2lOMUJEcTRjUjJ0dUNXUVdqYW81RWZ1QnB4Zlg3?=
 =?utf-8?B?MDdNZktTc0JJdUQvTkJWNGtJZDZnUmZyaHlwcHdkWnhtbm52cldyNXFFVXg5?=
 =?utf-8?B?bDhtVHVjRzVNNmhHeGV0b3ZDYmRKS3NBaFFWTU1UcitwbHdmcEIrTkRzcUIx?=
 =?utf-8?B?a3dkNWsyMkRLdVk1Ly9YeG9SNmYvcEdyN2kybnp1YmtUS2szallFTUpJK053?=
 =?utf-8?B?Z0ROdzdBV21BTFRteVE3MUpOWVgrRHdCaGJYcHZONUlqN21NN2tFcCtuL1hz?=
 =?utf-8?B?OTRFVERaWktSSnlCb2ZCL0ZWWDBydXdyYm5MZjMzZGNjZEVUSm81ZkV2SmxG?=
 =?utf-8?B?SUNNSXBVTW1hUWtDQU5GcG9GUmdFZk9LTjNCWUNuSFRjWDYwNVJOTllOQkNx?=
 =?utf-8?B?bW1qMXpqZE1iZUp6azl1b2hPbjZwNnBmY01TbXN0RHh2d0EwbVM5VCtScGFE?=
 =?utf-8?B?TzVKTTdxaVlWdFF0UGJRMlFyOVNpSGhQQTRmTTRpTXU3ZDMyMTVVQW9GaDBV?=
 =?utf-8?B?Y2xSalhrYXF5Q1ZsaGpiZ3NuYUhDb0V6VFNZbzUwc254NWkyRlNqemE0YmFs?=
 =?utf-8?B?WHFORFJrd2d4djIvSGQwZ2tZZjE0MDg1NVNFQncrd3hLZXo3d0VJOHZ6ZlU2?=
 =?utf-8?Q?bw4z0bfKI0c0xot/G7SwTKI0K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ac3196-6e29-4e78-db95-08db0c21a8c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 11:18:10.7410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+D9C6Odk4dv59ewELHT5Mh3wtymNPQ9ZfVwWhO/9kXYzrsTwehYHA/TGj+aAIfZ46uoMvibGvmCgPZfCy7V9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7161
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPiBPbiBTYXQsIEZlYiAwNCwgMjAyMyBhdCAwMjoyMDo1MEFNICswMDAwLCBKb2VsIEZlcm5h
bmRlcyAoR29vZ2xlKSB3cm90ZToNCj4gPiBSZWNlbnQgZGlzY3Vzc2lvbiB0cmlnZ2VyZWQgZHVl
IHRvIGEgcGF0Y2ggbGlua2VkIGJlbG93LCBmcm9tIFFpYW5nLA0KPiA+IHNoZWQgbGlnaHQgb24g
dGhlIG5lZWQgdG8gYWNjZWxlcmF0ZSBmcm9tIFFTIHJlcG9ydGluZyBwYXRocy4NCj4gPg0KPiA+
IFVwZGF0ZSB0aGUgY29tbWVudHMgdG8gY2FwdHVyZSB0aGlzIHBpZWNlIG9mIGtub3dsZWRnZS4N
Cj4gPg0KPiA+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDExODA3MzAx
NC4yMDIwNzQzLTEtcWlhbmcxLnpoYW5nQGludGVsLmNvbS8NCj4gPiBDYzogUWlhbmcgWmhhbmcg
PFFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gQ2M6IEZyZWRlcmljIFdlaXNiZWNrZXIgPGZy
ZWRlcmljQGtlcm5lbC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9lbCBGZXJuYW5kZXMgKEdv
b2dsZSkgPGpvZWxAam9lbGZlcm5hbmRlcy5vcmc+DQo+ID4NCj4gPiAtLS0NCj4gPiAga2VybmVs
L3JjdS90cmVlLmMgfCAxMyArKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVs
L3JjdS90cmVlLmMgYi9rZXJuZWwvcmN1L3RyZWUuYw0KPiA+IGluZGV4IDkzZWIwM2Y4ZWQ5OS4u
NzEzZWI2Y2E2OTAyIDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQo+ID4gKysr
IGIva2VybmVsL3JjdS90cmVlLmMNCj4gPiBAQCAtMTk4Myw3ICsxOTgzLDEyIEBAIHJjdV9yZXBv
cnRfcXNfcmRwKHN0cnVjdCByY3VfZGF0YSAqcmRwKQ0KPiA+ICAgICAgIH0gZWxzZSB7DQo+ID4g
ICAgICAgICAgICAgICAvKg0KPiA+ICAgICAgICAgICAgICAgICogVGhpcyBHUCBjYW4ndCBlbmQg
dW50aWwgY3B1IGNoZWNrcyBpbiwgc28gYWxsIG9mIG91cg0KPiA+IC0gICAgICAgICAgICAgICog
Y2FsbGJhY2tzIGNhbiBiZSBwcm9jZXNzZWQgZHVyaW5nIHRoZSBuZXh0IEdQLg0KPiA+ICsgICAg
ICAgICAgICAgICogY2FsbGJhY2tzIGNhbiBiZSBwcm9jZXNzZWQgZHVyaW5nIHRoZSBuZXh0IEdQ
LiBEbw0KPiA+ICsgICAgICAgICAgICAgICogdGhlIGFjY2VsZXJhdGlvbiBmcm9tIGhlcmUgb3Ro
ZXJ3aXNlIHRoZXJlIG1heSBiZSBleHRyYQ0KPiA+ICsgICAgICAgICAgICAgICogZ3JhY2UgcGVy
aW9kIGRlbGF5cywgYXMgYW55IGFjY2VsZXJhdGlvbnMgZnJvbSByY3VfY29yZSgpDQo+ID4gKyAg
ICAgICAgICAgICAgKiBvciBub3RlX2dwX2NoYW5nZXMoKSBtYXkgaGFwcGVuIG9ubHkgYWZ0ZXIg
dGhlIEdQIGFmdGVyIHRoZQ0KPiA+ICsgICAgICAgICAgICAgICogY3VycmVudCBvbmUgaGFzIGFs
cmVhZHkgc3RhcnRlZC4gRnVydGhlciwgcmN1X2NvcmUoKQ0KPiA+ICsgICAgICAgICAgICAgICog
b25seSBhY2NlbGVyYXRlcyBpZiBSQ1UgaXMgaWRsZSAobm8gR1AgaW4gcHJvZ3Jlc3MpLg0KPg0K
PiBBY3R1YWxseSBub3RlX2dwX2NoYW5nZXMoKSBzaG91bGQgdGFrZSBjYXJlIG9mIHRoYXQuDQo+
DQo+WW91IGFyZSByZWZlcnJpbmcgdG8gIHJjdV9jb3JlKCkgLT4gcmN1X2NoZWNrX3F1aWVzY2Vu
dF9zdGF0ZSgpIC0+DQo+bm90ZV9ncF9jaGFuZ2VzKCkgZG9pbmcgdGhlIGFjY2VsZXJhdGlvbiBw
cmlvciB0byB0aGUgIHJjdV9jb3JlKCkgLT4NCj5yY3VfcmVwb3J0X3FzX3JkcCgpIGNhbGwsIGNv
cnJlY3Q/DQo+DQo+QWgsIGJ1dCBub3RlX2dwX2NoYW5nZXMoKSBoYXMgYW4gZWFybHkgcmV0dXJu
IHdoaWNoIHRyaWdnZXJzIGlmIGVpdGhlcjoNCj4xLiBUaGUgcm5wIHNwaW5sb2NrIHRyeWxvY2sg
ZmFpbGVkLg0KPjIuIFRoZSBzdGFydCBvZiBhIG5ldyBncmFjZSBwZXJpb2Qgd2FzIGFscmVhZHkg
ZGV0ZWN0ZWQgYmVmb3JlLCBzbw0KPnJkcC0+Z3Bfc2VxID09IHJucC0+Z3Bfc2VxLg0KPg0KPlNv
IEkgdGhpbmsgaXQgaXMgcG9zc2libGUgdGhhdCB3ZSBhcmUgaW4gdGhlIG1pZGRsZSBvZiBhIEdQ
LCBhbmQNCj5yY3VfY29yZSgpIGlzIGNhbGxlZCBiZWNhdXNlIFFTIHJlcG9ydGluZyBpcyByZXF1
aXJlZCBmb3IgdGhlIENQVSwgYW5kDQo+c2F5IHRoZSBjdXJyZW50IEdQIHN0YXJ0ZWQgd2UgYXJl
IGluIHRoZSBtaWRkbGUgb2ZmIG9jY3VycyBmcm9tIHRoZQ0KPnNhbWUgQ1BVIHNvIHJkcC0+Z3Bf
c2VxID09IHJucC0+Z3Bfc2VxLg0KPg0KPk5vdywgcmN1X2NvcmUoKSdzIGNhbGwgdG8gbm90ZV9n
cF9jaGFuZ2VzKCkgc2hvdWxkIHJldHVybiBlYXJseSBidXQNCj5pdHMgbGF0ZXIgY2FsbCB0byBy
ZXBvcnRfcXNfcmRwKCkgd2lsbCBub3QgYWNjZWxlcmF0ZSB0aGUgY2FsbGJhY2sNCj53aXRob3V0
IHRoZSBjb2RlIHdlIGFyZSBjb21tZW50aW5nIGhlcmUuDQo+DQo+IE15IGd1dCBmZWVsaW5nIGlz
IHRoYXQgdGhlDQo+IGFjY2VsZXJhdGlvbiBpbiByY3VfcmVwb3J0X3FzX3JkcCgpIG9ubHkgc3Rh
bmRzIGZvcjoNCj4NCj4gKiBjYWxsYmFja3MgdGhhdCBtYXkgYmUgZW5xdWV1ZWQgZnJvbSBhbiBJ
UlEgZmlyaW5nIGR1cmluZyB0aGUgc21hbGwgd2luZG93DQo+ICAgYmV0d2VlbiB0aGUgUk5QIHVu
bG9jayBpbiBub3RlX2dwX2NoYW5nZXMoKSBhbmQgdGhlIFJOUCBsb2NrIGluDQo+ICAgcmN1X3Jl
cG9ydF9xc19yZHAoKQ0KDQpGb3IgcmRwIHdoaWNoIGlzIGluIHRoZSBtaWRkbGUgb2YgYSBkZS1v
ZmZsb2FkaW5nIHByb2Nlc3MsIHRoZSBieXBhc3MgbGlzdCBoYXZlIGJlZW4NCmZsdXNoZWQsIHRo
ZSBub2NiIGt0aHJlYWRzIG1heSBtaXNzIGNhbGxiYWNrcyBhY2NlbGVyYXRpb24uICAgaW52b2tl
IGNhbGxfcmN1KCkNCndpbGwgYWxzbyBub3QgdXNlIGJ5cGFzcyBsaXN0LiBpZiBhdCB0aGlzIHRp
bWUgYSBuZXcgZ3Agc3RhcnRzLCBiZWZvcmUgY2FsbCByY3VfcmVwb3J0X3FzX3JkcCgpDQp0byBy
ZXBvcnQgcXMsICBldmVuIGlmIHJjdV9jb3JlKCkgaW52b2tlIG5vdGVfZ3BfY2hhbmdlcygpIG5v
dGljZSBncCBzdGFydCwgdGhpcyByZHAncyBjYWxsYmFjaw0KbWF5IHN0aWxsIG1pc3MgYWNjZWxl
cmF0aW9uIGlmIHJkcCBzdGlsbCBpbiBkZS1vZmZsb2FkaW5nIHByb2Nlc3MsIGJlY2F1c2UgaW52
b2tlIHJjdV9yZHBfaXNfb2ZmbG9hZGVkKCkNCnN0aWxsIHJldHVybiB0cnVlLg0KDQpJIHRoaW5r
IHRoaXMgaXMgYWxzbyBhIHJlYXNvbi4NCg0KVGhhbmtzDQpacWlhbmcNCg0KPg0KPlN1cmUsIHRo
aXMgYWxzbyBzZWVtcyBsaWtlIGEgdmFsaWQgcmVhc29uLg0KPg0KPiAqIF9fbm90ZV9ncF9jaGFu
Z2VzKCkgZ290IGNhbGxlZCBldmVuIGJlZm9yZSBmcm9tIHRoZSBHUCBrdGhyZWFkLCBhbmQgY2Fs
bGJhY2tzDQo+ICAgZ290IGVucXVldWVkIGJldHdlZW4gdGhhdCBhbmQgcmN1X2NvcmUoKS4NCj4N
Cj5BZ3JlZWQuIEluIHRoaXMgY2FzZSB3ZSB3aWxsIHRha2UgdGhlIGVhcmx5IHJldHVybiBpbg0K
Pm5vdGVfZ3BfY2hhbmdlcygpIHdoZW4gY2FsbGVkIGZyb20gdGhlIHJjdV9jb3JlKCkuIFNvIHll
YWgsIHRoYXQgd2FzDQo+a2luZCBvZiBteSBwb2ludCBhcyB3ZWxsIGJ1dCBzbGlnaHRseSBkaWZm
ZXJlbnQgcmVhc29uaW5nLg0KPg0KPkxldCBtZSBrbm93IGlmIHlvdSBkaXNhZ3JlZSB3aXRoIGFu
eXRoaW5nIEkgbWVudGlvbmVkLCB0aG91Z2guDQo+DQo+IC0gSm9lbA0K
