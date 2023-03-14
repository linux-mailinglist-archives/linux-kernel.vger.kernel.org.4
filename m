Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAC66B8801
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCNCDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjCNCDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:03:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEA567701;
        Mon, 13 Mar 2023 19:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678759419; x=1710295419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8fX81zJxwr09fhmR8HSAIVMVELTR6K98o4CeJoAgo04=;
  b=Z5gS8yav79IHRipuac751XXDbySGTR+H6pNn3X2NqzijbF4Bu0lfqxNc
   e4oXCkpuUdvTN5aB25g3El9WV/a6z5fCaw2okIXviXDahWyzKRZnTVZ/b
   G4L0oHuOUJx0cWMxhPHPyLDcjRo782YMcEuQUYhKMsBhO5dPUxx2ahubE
   ymz/uQOCSrdMO3Jnp5mIE9EMDwkIfSkwRIWnUt8FV0ArrqUhzpFjv/H17
   eTZ/pStT9ctjZsNBWUUJjzVXHt5v0tgKW+Be1EsRvvaexyXm0/SiaXf5n
   EcGl4NbZW7u7lkhjoEGPTqsIkpY4W38ewp6h4aDJX/DUYZ646z+Z2h1ok
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325671346"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="325671346"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 19:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="747827362"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="747827362"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2023 19:03:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 19:03:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 19:03:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 19:03:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKAwD/NAOhcUj3BW4v/9AEhoJ1ZJs0dDvwAxpTlc02D+FvMhh2z6s8d7EASVOLjJv5+cjw+hKaS7joL0iUF/wjQFlW9dNDJCV4ljz1o0mRI/A6CQrtPA+AjXh+vgDo3C+DHqd+VR+3J49c2OukPjpKIp3Gz5aiJSu0Tf5NsKNSU3N3kfDVr5rs6iAD1Cf2sqEBWijSz3GIkhE+hSmO5uUTJ+/y0O1EEPMvYsKO1aK33fEb6Fq0ZSaOFkGVhjWJaSivOonMU3QIf6BB7TLoDcYySBE/eIUQE0fw4E2F0MgzXwSYPNiMmQg4hqTMgGQMx4An5MkURHfQAK6nVVl1CJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fX81zJxwr09fhmR8HSAIVMVELTR6K98o4CeJoAgo04=;
 b=CVdAShmOTLLJS2wvPEuKx6NVpSoKI5I+sjs/i5G8UZ/QJsQPS3Z/Du6fE0zfzGxgBgxZbGvcBFyCbKeJtBRPL57DR0qz8OAq90j7e1w3LoF4E8pWCmL6sejGPU+1R2CflQBSlwpgDrxrXMl/+7ByQyVVxkmSJfS323qY9m00TnX3lV0dg5kpdCiOsrA/r6OFJuhQT2qu2g/bJFgmVsACOKyLkMYxEYfQj458lrmUUFOVUxfJzvvpiblQMvrM5RtmVi/CkfKdfybxD/VkL0KMCZ+O26J76eXovyNVwvsElU8RerC0joKJzb2tLLbK3igF4InxQmqy3WhFRRtgsrSHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH7PR11MB6452.namprd11.prod.outlook.com (2603:10b6:510:1f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Tue, 14 Mar
 2023 02:03:33 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 02:03:33 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] ACPI: processor: thermal: Update CPU cooling
 devices on cpufreq policy changes
Thread-Topic: [PATCH v2 4/4] ACPI: processor: thermal: Update CPU cooling
 devices on cpufreq policy changes
Thread-Index: AQHZVbjzmpr/ZFmtEkikqPuE3cKH1q75hugA
Date:   Tue, 14 Mar 2023 02:03:33 +0000
Message-ID: <f33543d7149fcc5d8745df8e1cd5561ea110a90e.camel@intel.com>
References: <2692681.mvXUDI8C0e@kreacher> <2893417.e9J7NaK4W3@kreacher>
In-Reply-To: <2893417.e9J7NaK4W3@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH7PR11MB6452:EE_
x-ms-office365-filtering-correlation-id: 210d88a7-7943-4e44-d016-08db243050e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SbQPe10fuT4RbOzBFjBBrlENLSY4IDytTBcM0MIJzjSEc29QDN9wzU3OWaOgs0J4h85/8QmZN0VRRNyqerutNEBKr6SS3DOzqF8HVNOkmEPRXQg8T0WT6uHUQGMgIxnfZjHDEiSuLX58UU8L3g5Jk2vXlOoXINGlyk4U6bLrC69Lv3dPD3nQkSNdxXUfUBg2JDOTEsvkci9kOISl5lFs8y0FyRx0I7tWx2Gj6xKVtiMNYSKT4Fwqjz9iOliMlzPVhUwZ5q9yPBHrM8cmmfDHk3SOThHd5NNZYkaRyTf6Vm3hYXzyKB+KRJbpi54IGIoSTQvTppeeDqAu3IVK2aV0M8yqiPQdNYRVq/a6/CModLbKD+/DBtXoQtaQN7L91/Sv4gqe/k+31tpY03T8tFBukZ5sjrDSJu4B/Rq1PxmFvfmLrBEa8PkToy5+/2s1KuilcK3hfH/N7t8kYQAUUydP1nesZkJ/CgiMg+VV7TILZJMTm+WdTLSJyl+Hzgz8g0Q+gBXQjxYqfVXkx4LbLIkQKlweHSikMYj5BxCbpmlgy6P4mBz6ywv3Pnypv/8gFjnbVUdCGHpAteeOW5t4VSpFVRAZlZrc3OtDIOXwH3EV8kmx74Px48uiJXAUwUwmuY+HnrfAVHBreFP3SkUYYUSnPE1GKqBJEJHaXQyyQ8m+u2+n8XCMtXAYN0yBMbIFT4PNDCUGZCBCg9Q7gn0ebEHoOjVfhzIubHN1fNkMoKWY/0A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199018)(84970400001)(2616005)(15650500001)(2906002)(186003)(38100700002)(122000001)(82960400001)(26005)(6512007)(41300700001)(38070700005)(6506007)(83380400001)(5660300002)(478600001)(316002)(8936002)(64756008)(54906003)(110136005)(36756003)(66476007)(6486002)(91956017)(966005)(86362001)(8676002)(66946007)(66556008)(66446008)(76116006)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUxIUEg3UEIyNjJ0YnZ1aHF3WHo2VGhvZnB5Mml6VHphQ0YwcVVURFJVYW4z?=
 =?utf-8?B?blh5Qm1GKzhBK0x0ZlVuZ2dRd3B6TzR4bDZheERvbTRYdG1UUmVFM1R6bzVD?=
 =?utf-8?B?L0N6eXpSYUtPZkI0R01wbHExalBWajdsRSthRDVOVWJHUnRWTDZtcjFva1NZ?=
 =?utf-8?B?dnVsS0RQRU44MWRGSTV4L2U2YWNQaEdFUk95NEdaRExDS0xDSGtJcVBuZm8r?=
 =?utf-8?B?VFRQWUxSSzIzbVVFOStFZW0vZ3pGU3JIY3hvQXFqV0FUK0JrOFlhZGhDc0ll?=
 =?utf-8?B?bk4zTlFYTlBtbWlHVXB0SGErdVhBcFYyYm9HK216azhueEJiTng2cnZBd2hi?=
 =?utf-8?B?bHNvRDVCcHk2T2NuZlBNaXRiZ290MUpVUmNZTzFHdEUyNGR3MHFubEdYYzIy?=
 =?utf-8?B?MGlPZCtCMWhkcHlRQ2h5M1ljZXNTbW9aVEd5RVNjcVI2WUhxQzJJZ0Zveisy?=
 =?utf-8?B?bGI3TU9GcWNOYklDdDA4NHovMkt1SlVIdWszVnRhSUd2MkdYaktDcFlrdE1n?=
 =?utf-8?B?dXhhRVp1YTlTMm9OQWhIY3RTWjlQV3BzYTJtQkI1MTQyaGJlTUplb00zVG5O?=
 =?utf-8?B?K1JUbGJwYnpVZmxYZlBxMHZvRTQwSWpPWVl2VnFHdG9VUzZzcGdNQjFrNWxQ?=
 =?utf-8?B?c3lndHZGLzlWQmlmR0ozYlQwd1Y2YVdnRk1JMWxpTXBOQ2FGUnZBY0llMm1D?=
 =?utf-8?B?TGFIZGl0UWZRcVN2RWNaNHZlaVZhMjNGUzVxcTdpZGFCUHVpSlVMc1VwYU80?=
 =?utf-8?B?UGZnR09pRitjMW4rV0lrTnNQTGJnak8xazB1OGRzMVpsbWorNnhsVTJDYlht?=
 =?utf-8?B?SFdwY285dm5RUHN5eDhZdHlPMkRhcTlWU3pqd1ZNeVdIbzk5WTgxTU9QRzdI?=
 =?utf-8?B?M0d4aU1mMndUZjlLekVRaFBaRVI1K09QbStrSUFOaUxDb1d2djhrS3dVS2E3?=
 =?utf-8?B?Vy9jUUtsd2xYazFTZHRnQXhoRndJTFVLZTNvQ0FwL3pyMHNMZEtLY0dyOStK?=
 =?utf-8?B?aldLZmRBUVZrUWMwaW9IL3VKOTZYbjhPQWlQa0hQTmU0Tit3c0VOVUdNTDcw?=
 =?utf-8?B?OERzbHFNazFaT1QwS2JrQk9PTUhKUWcyb09rNGdnNDV6SmY2cDBKWGp0OThQ?=
 =?utf-8?B?NVpzSnMzMC9hQmdXT1JYZnd1TzJSN1JZak5IU1hvTUdJN09yandvSC9FVEp1?=
 =?utf-8?B?ZGd4Z2NzVGxuTExRbnIvWHZRTUgxVWp2cHBCNkJGT3FhcFRWUmo1WEt5emNE?=
 =?utf-8?B?RjBQb05oaE41SFpKZnp2a3ZtYzR1bmZJZTBZK0lSdHo3K0o1U3pNRWJpL1Z1?=
 =?utf-8?B?ZmIvejBwMlRGbFd4cmJMK1dYVldPOXdjMXBtZ1JRZ2NOQUFVMXlFUGV4Y280?=
 =?utf-8?B?VzcrZngvSTlxd0RlaUVOUFZuNXRPbThoVG4raTJkY1dkQWxXOXhrL1l4bFFm?=
 =?utf-8?B?WVM4UkJERm9PMFViY3VpRy9IL1AxQjdhckdERGhoeDhFOFQzd2Mzd1d6TXpE?=
 =?utf-8?B?L3A0b0NVeG5sZ0RKb2s1SHhpcVVpOUNuSzBmenM0ZEFQZ0dwbmN2V2ZBM2JF?=
 =?utf-8?B?N2lZT21tVnlQOEoySGlwR3hmb1g5Q2w1aFJnc0FmOW0vbmdQUVpwcUE0ODFI?=
 =?utf-8?B?U2NUMzFGSnMwSWJPZm45UUNLb3V2Unc5TWRWOXNYZU1Bc2svVWlETlU3Z3Fu?=
 =?utf-8?B?dUNzbEVCd0FMOTllTitRQVF3eEJzTmFpQnlrblJCZERHYjZJZ2J6dTY5SmZk?=
 =?utf-8?B?V25pd0dqYnRNSkdEWW5qdmIrbVJ4Z1Foa0wyeVJscU90WE9JWlBHQkVwVVdl?=
 =?utf-8?B?ZU9XbTRlVjUrbWVqbUd4NnNmM05FeFpMYTZlclNSMnpmcEJXeGVXeGxuYkQ1?=
 =?utf-8?B?azgyMkZqdHhPU3ExcmVrb251NGFDaWpaMDd4dHJ6U0FWTldjVTZYR1NMejRP?=
 =?utf-8?B?VEphcVM4TXVqWkZuUnRmd0RpWTh6THhNeVNQQnp3a0FKdzh6L3oxVlQ0QnE0?=
 =?utf-8?B?TE1GeFRUOUZkV3A2MTlmNyt6dzlVNDk2UUpncXk1bkxFcC96MG9ZWTZvMUo0?=
 =?utf-8?B?aEZoZS9Fdll6Tnl2TUdZL1VWOHdFSXk2VWZkTm1NKzMrOXBWZFlTYzJsKzN2?=
 =?utf-8?Q?MaVXGSLxmsR4WXWqUGtIsVsh/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CE73FCC33F5694F8CDBED0E8A7F7649@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210d88a7-7943-4e44-d016-08db243050e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 02:03:33.5903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJs/vreIrRdTLs3Ihn2/uqGTdH33m5seTKvPsdqxDmx+wny1nrhvmJ35MMzC+lcR5mXwWEYHtB3iI+dMj//mqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTEzIGF0IDE1OjM0ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gV2hlbiBhIGNwdWZyZXEgcG9saWN5IGFwcGVhcnMgb3IgZ29lcyBhd2F5LCB0aGUg
Q1BVIGNvb2xpbmcgZGV2aWNlcw0KPiBmb3INCj4gdGhlIENQVXMgY292ZXJlZCBieSB0aGF0IHBv
bGljeSBuZWVkIHRvIGJlIHVwZGF0ZWQgc28gdGhhdCB0aGUgbmV3DQo+IHByb2Nlc3Nvcl9nZXRf
bWF4X3N0YXRlKCkgdmFsdWUgaXMgc3RvcmVkIGFzIG1heF9zdGF0ZSBhbmQgdGhlDQo+IHN0YXRp
c3RpY3MgaW4gc3lzZnMgYXJlIHJlYXJyYW5nZWQgZm9yIGVhY2ggb2YgdGhlbS4NCj4gDQo+IERv
IHRoYXQgYWNjb3JkaW5nbHkgaW4gYWNwaV90aGVybWFsX2NwdWZyZXFfaW5pdCgpIGFuZA0KPiBh
Y3BpX3RoZXJtYWxfY3B1ZnJlcV9leGl0KCkuDQo+IA0KPiBGaXhlczogYTM2NTEwNWM2ODVjKCJ0
aGVybWFsOiBzeXNmczogUmV1c2UgY2Rldi0+bWF4X3N0YXRlIikNCj4gUmVwb3J0ZWQtYnk6IFdh
bmcsIFF1YW54aWFuIDxxdWFueGlhbi53YW5nQGludGVsLmNvbT4NCj4gTGluazogDQo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBtLzUzZWMxZjA2ZjYxYzk4NDEwMDg2ODkyNmYyODI2
NDdlNTdlY2ZiMmQuY2FtZWxAaW50ZWwuY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4g
V3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQoNClRlc3RlZC1ieTogWmhhbmcg
UnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KUmV2aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpo
YW5nQGludGVsLmNvbT4NCg0KdGhhbmtzLA0KcnVpDQoNCj4gLS0tDQo+IA0KPiB2MSAtPiB2Mjog
UmVtb3ZlIHRoZSBub3cgcmVkdW5kYW50IElTX0VSUigpIGNoZWNrcyBvbiBjZGV2IGJlZm9yZQ0K
PiBjYWxsaW5nDQo+ICAgICAgICAgICB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3VwZGF0ZSgpLg0K
PiANCj4gLS0tDQo+ICBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3RoZXJtYWwuYyB8ICAgMTQgKysr
KysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiANCj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfdGhl
cm1hbC5jDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9hY3BpL3By
b2Nlc3Nvcl90aGVybWFsLmMNCj4gKysrIGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3Jf
dGhlcm1hbC5jDQo+IEBAIC0xNDAsOSArMTQwLDEzIEBAIHZvaWQgYWNwaV90aGVybWFsX2NwdWZy
ZXFfaW5pdChzdHJ1Y3QgY3ANCj4gIAkJcmV0ID0gZnJlcV9xb3NfYWRkX3JlcXVlc3QoJnBvbGlj
eS0+Y29uc3RyYWludHMsDQo+ICAJCQkJCSAgICZwci0+dGhlcm1hbF9yZXEsDQo+ICAJCQkJCSAg
IEZSRVFfUU9TX01BWCwgSU5UX01BWCk7DQo+IC0JCWlmIChyZXQgPCAwKQ0KPiArCQlpZiAocmV0
IDwgMCkgew0KPiAgCQkJcHJfZXJyKCJGYWlsZWQgdG8gYWRkIGZyZXEgY29uc3RyYWludCBmb3Ig
Q1BVJWQNCj4gKCVkKVxuIiwNCj4gIAkJCSAgICAgICBjcHUsIHJldCk7DQo+ICsJCQljb250aW51
ZTsNCj4gKwkJfQ0KPiArDQo+ICsJCXRoZXJtYWxfY29vbGluZ19kZXZpY2VfdXBkYXRlKHByLT5j
ZGV2KTsNCj4gIAl9DQo+ICB9DQo+ICANCj4gQEAgLTE1Myw4ICsxNTcsMTIgQEAgdm9pZCBhY3Bp
X3RoZXJtYWxfY3B1ZnJlcV9leGl0KHN0cnVjdCBjcA0KPiAgCWZvcl9lYWNoX2NwdShjcHUsIHBv
bGljeS0+cmVsYXRlZF9jcHVzKSB7DQo+ICAJCXN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIgPSBw
ZXJfY3B1KHByb2Nlc3NvcnMsIGNwdSk7DQo+ICANCj4gLQkJaWYgKHByKQ0KPiAtCQkJZnJlcV9x
b3NfcmVtb3ZlX3JlcXVlc3QoJnByLT50aGVybWFsX3JlcSk7DQo+ICsJCWlmICghcHIpDQo+ICsJ
CQljb250aW51ZTsNCj4gKw0KPiArCQlmcmVxX3Fvc19yZW1vdmVfcmVxdWVzdCgmcHItPnRoZXJt
YWxfcmVxKTsNCj4gKw0KPiArCQl0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3VwZGF0ZShwci0+Y2Rl
dik7DQo+ICAJfQ0KPiAgfQ0KPiAgI2Vsc2UJCQkJLyogISBDT05GSUdfQ1BVX0ZSRVEgKi8NCj4g
DQo+IA0KPiANCg==
