Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE776BFEFD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 03:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCSCDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 22:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCSCDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 22:03:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEAECA08;
        Sat, 18 Mar 2023 19:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679191427; x=1710727427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f3Z00hZyxGDhdN32l4Mvt//E43nWw7mkodeSPq5ewmw=;
  b=TggpNtB9MxnpUs384xgOs1PIpkyK0qWWFWrJKJBDbRAdDDoYa2vvQ4Bh
   ruRTnlpkfeGkHmKJeTsk5R+qEGQwBewD6Ew36LhDULR8nkLYSfzKmTYlL
   EkbZ7tolon6Rlms5ORikZ0p46zr/jb4CKNhjq1PuMBXUM5F6/NXXC2kUs
   F2M5mfOJQ6jV8P0bNPqTyLX1YHn2udGv6rm3A7birux0xzT3xbiQDZkNQ
   3RMZvq9SPSQ/G1HhBcyYJOgMY2w6IUlFZc7MhA9YTl+oBcZ/PWVXrLRCk
   ofS8z1KARViDOncoOtqxz1/pJRwAnxZRzYC58e/13ylqTtWc+ULMtx29S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="326839128"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="326839128"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 19:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="683079804"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="683079804"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 18 Mar 2023 19:03:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 18 Mar 2023 19:03:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sat, 18 Mar 2023 19:03:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sat, 18 Mar 2023 19:03:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm0A8yE+TRFhCq2dJktpuxvzXOLASQzcRSnyocBFfKGVRPeiysu4aPYwJEIL5Ec9qDgzMkMzbMSXiHP+91yE5F+09Q5iCIYM2T626SzLG60TqSJeN38X/F+C14LhmCoJ1zfEauTkA5U7H+qpRNPktFmVNmwM3AKI4ND+dz5TsjlixVBNElirb8XfddhctMMwlCnnbutdDmFTg6TpApmAL1gaqa078ORzZnP+b5YVIfjEyElQSUO/bLt01EZM5MyO8lqrhflu8UjlXmyRlJTfgU/OcHaK/mLmtTLOQKZqDHh9o3k4PKS6POoIuWfiT7+7FuhmOleA+HJAjdzqFacKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3Z00hZyxGDhdN32l4Mvt//E43nWw7mkodeSPq5ewmw=;
 b=SupeunAASUlGniV33daHMQphjgFBzisphlDupnmi7iiscGu6+sZDlFY7EB3RHuZnGJ966GJ76autMGfHNJw9RnpxnfzrNM1k3OvAcs975jk6TOwlircbhUBXdI+J1D3YRu8kuVUq1uKHNNyrn5FLiPRhon99Ia54ZSoEnqLbEsfUD1G1cr0vC3v3I2KUMwuU49+qCkam/zfc+E9mUuV3GExIJug2GNKBVR80cPugFT4nk0a/2F8zfITYVXb08HvzB9a9B8RgOUIgRiRbQE/RSFDB801tzsCfh5zPj4pJaUiHMnE/C4NBnlmmB6m7OS4oqusirGDaKyjyGI7Cj/TyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB5206.namprd11.prod.outlook.com (2603:10b6:510:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sun, 19 Mar
 2023 02:03:43 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%4]) with mapi id 15.20.6178.036; Sun, 19 Mar 2023
 02:03:43 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [PATCH] rcu: Fix incorrect trace string in rcu_boost_kthread()
Thread-Topic: [PATCH] rcu: Fix incorrect trace string in rcu_boost_kthread()
Thread-Index: AQHZWZxelxWKlvyHXEi/VJq/8bUqDa8BUbwAgAAH/GA=
Date:   Sun, 19 Mar 2023 02:03:43 +0000
Message-ID: <PH0PR11MB5880289F242D1E8028A52FC7DA839@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230318132435.3671003-1-qiang1.zhang@intel.com>
 <CAEXW_YQ2xGuy4ebPjyVAp4SJQUo=Wr8uAw9BnUsjgvozzhuUeg@mail.gmail.com>
In-Reply-To: <CAEXW_YQ2xGuy4ebPjyVAp4SJQUo=Wr8uAw9BnUsjgvozzhuUeg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH0PR11MB5206:EE_
x-ms-office365-filtering-correlation-id: 852eeac4-7fe8-478c-a03b-08db281e2add
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jqL1ZXwtzijWdZfWkWCr/bxJdKmH7Ns8Ddweekr9Uu0qst6AQuJCKDgN4dvQakhQSW4N8qVi5njeDTDjqeRN4z4JebcdDLbCjTptt8GVfy7gRj0/urdom8GQEaRScteemetV2C0jNtFPaJVlHm1htY0fxf9za7qDFVn7owaEULKVIi7ekHNZ6TwlGxMsadUTls51FbWJl53jTG6JPDeKLNSYrX2J5H8p/K/HhDRWGYP16Bk/eIgvRpTEbh1ejL+mptpyWWXIEkwlhLpONCZlG60QPL5xGFvQt70caa1Hd5gRXWvHx5Ex543a6Y9auSN3TAvGJt2RiUnhGDvXiI7XvJLzOOOj+CySRZD/xF+G0BpZ8NJhhiHdaFx3gWJjwnwa2lYG6Yf1tAJM15xxIS8qrFL93uc49zHoSg3xKg7gryXyB+HR6T3sZ8T8ADa/8aGVXEmWMWf5/7h3spOYFanbc5/mTa974sa7z1zafzohLQqCK1w/RpPQrUyHEhK9rIXFxn2vN3Ab/T6W7dTtmk9nZ0meM4V3Qg9akGF9mBhYmMg320kKvSgpc3/xFB+fXHQ9UJ9HRAGsI0AenG75Xo5MylWj+mIRKckyxzrNVEt1KYdSA0OxzhwERY1e0d8G0Q0iTERj/kipuSU9vbLlXPbSltW7aRWnW3idP6tUh8ZcKLhl8fpT8Fu7MP/Br4ejO5nRV3P3GjyUYHhlj+AoGNxY9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199018)(86362001)(55016003)(33656002)(71200400001)(316002)(66556008)(66446008)(64756008)(76116006)(66946007)(66476007)(8676002)(83380400001)(54906003)(478600001)(4326008)(53546011)(6506007)(26005)(9686003)(186003)(6916009)(7696005)(38070700005)(38100700002)(52536014)(8936002)(5660300002)(2906002)(122000001)(82960400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDVNWTQ3QndaUnNncWlwMjFDVWNWRXV1eW9XU1ArUkRMT1JVY3lmdWlUTEkw?=
 =?utf-8?B?R3dqWlhreG1Od0EyRS81aHZSa0ZOWVpMM1R6ZENCN0YxdlVTWXloR094T2x4?=
 =?utf-8?B?WmVIeWtDM3JpSUdaZFJZaHN2bndNa0xEVUFyU3FEVE1oMG5pVFdkZ0pvYlp6?=
 =?utf-8?B?UTd2Si91N3RIQU5EV1I2VzBteDZ4QTRrTFBPNy9iKzlRdkN3YU0zODFpSXZj?=
 =?utf-8?B?SjFmQ3lNUHpyci9vYkd5M2VzOTJrL0psVm5vQUttV2hNc05vWWRNKzVsNm43?=
 =?utf-8?B?WEtYVy8yOTF5RTFsc2NuY0lBUWhTM3gyckhHZUtxRTZ5cEhEMHNsRWFNR01y?=
 =?utf-8?B?U1UxSmhaTlB2MEF4WEsvMGtLdnYwZXBnNHRaQlp2ODF3eXRpNXNJSmRrMlRt?=
 =?utf-8?B?aVZ5MXhML1lJREtRZTV2OUd3alF3SjZpWWRhWWNNZ1YxdnhnRVZqenBQZlFC?=
 =?utf-8?B?NzIybEtBVkVJMHEvM3ZxRzZxamNaemtCNk5FT2NUKzVGdUZjeExyZTloWEhZ?=
 =?utf-8?B?UGVjdldJZzJoVlQzc2lITXIxdCtxUEFsbEM3NDFHRnZnTml3RWRqdFIzTU1L?=
 =?utf-8?B?OERTamNiMmlrZ2NkM0VTbE0xR1ZyY3lQUkdJZ0k5V3M2cVVUK3ViWmlhVmlW?=
 =?utf-8?B?enU1N3hYZWZJNzB1ZW9BK1VBL0pPWkpwSUFaUmJ1QXBUc1lhQ2ZYRklxcjFM?=
 =?utf-8?B?MEhJdFlHVlZMclJuUHd4MUR4cnp6T2xPQmwrdHlMT1U2aUxJenNjclZ5NDNn?=
 =?utf-8?B?YjFzSy9hcEdUUDVRaCsrQmNYZnRzeEp5SWMwakVGQSs5WUkvODhna1dDLzJ2?=
 =?utf-8?B?aVYwQTVjNngrQzllNGdiWHppUm0ybnBMMGk3OURFSXkrQXlwZHZQSTgzUmtV?=
 =?utf-8?B?VER0czVlenBIQ1BrREpCenF0ZnNJNnB3Q0lZVCswdW5oTDllemtYU1MxN1cv?=
 =?utf-8?B?SUtIYkJDelIxOWhpcm91ckhyWHNTdEgzT09DVlQvSHdQdlNhRzd6SStYVC9z?=
 =?utf-8?B?RU85OWR3Rk5iTndNa1hVYzRvb3VrZ1YwWkkzMWpqdk1uZnV1OEVTMnIrNDZ5?=
 =?utf-8?B?M1VIQkVFQnZJcEdxN2dzbDFGMVYwd1JnRkUzUnNxMzYxNjdSNFN4V0N4NVVF?=
 =?utf-8?B?Sk9ram90V1NZaVVZYllTRkF3ZWZWd0c1aDZYcVViU3RuTFRwTEVCTnZEZ0pT?=
 =?utf-8?B?ZE4wSk9RR2JmYXo3dTRwU2JpK0kwaFNDZnVrRTM0eGZ6a09JU1pGS045TTB5?=
 =?utf-8?B?OWhITkxXQk5CMllYNXFQOExmTk9yVnlwTWRvZ0g3S1pmWkxBS3VvQndWMjR4?=
 =?utf-8?B?bngxaDI3S1dvbERsU1U3OWxFbzZCSStMbDNLTmI0ajJ3TFRBamZsYmVadmQ4?=
 =?utf-8?B?SGZLN0dHMHJHVzh2RGdSY2xZWHd2b09mem1jK2NRbW9pNklSS3ZiaE5VeFVE?=
 =?utf-8?B?bDNNNVloY3RjMEZyUHluWkhXcUMwRGFiQzRYWS9GMGJtZldlSWlDNHVzQVRE?=
 =?utf-8?B?ZGxxM2h0d2lmZGdBRXZWQU5hSDBuZVB6b3F1NnRYdmF4a2FYa0RpYlE4c0VP?=
 =?utf-8?B?OGlTMjQzM0I4TVV3TmgrSEVkNHMyRHQwOFQ5VEttSEFad3RyaDNpU2JzOEZz?=
 =?utf-8?B?K2VPQ1lvVTl3RGhQa3c0LzdYS1E0bUQ4Y3N5NFdIRXFhRlBGL21hWm4rRW5v?=
 =?utf-8?B?bFEvNTdPaUZVTHlBMXZ2b2hXNUUyVFYrakExVDZTOGQwelE0Q2VzbThhVnFP?=
 =?utf-8?B?L3AwUnNGYTZEVWdjeXltdFc4dmxIQkNVeEhHRWZCeDVMTDdJVXZuRXNGMjEz?=
 =?utf-8?B?QXJDOFdCaVRtSHB6L1FlejZoaGh5bkFyOTZhL1V5T2tBdDlTUTJyTFVSUDV1?=
 =?utf-8?B?U2czUWVMYzFVMjVVVFhiM0tyWmtRVGlEWm9rKzZIb3FPaHk2bkhhVkhjT1hZ?=
 =?utf-8?B?MFFFM0tYYUd6bDQ5Q1QvYzVJZUlUQm9yOTY5d291V3hkaTZIVmlXWGxkRm5V?=
 =?utf-8?B?ZlBwZG1IY2RlWjBmUW9kWHFOKzFLM3VESTRuNloxUzlhY3krcHdjMHNmd1NV?=
 =?utf-8?B?TFFzSlY0OXVlV0VGbytMaFhpWVQrNkZQcnM4UjYycjBjSVNKMzJVMUtTSXJZ?=
 =?utf-8?Q?ol/QF+immcZ2EzyxSheQJRJtm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852eeac4-7fe8-478c-a03b-08db281e2add
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2023 02:03:43.6198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXktOHG5DVwUN5vhdYsxUdoqn9/o1LPslw9iidUTk7iYe0H5RBX6xVXu+61SSsUaGgdqPRPL7ZjW5Baq/q0NfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5206
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBNYXIgMTgsIDIwMjMgYXQgOToyMOKAr0FNIFpxaWFuZyA8cWlhbmcxLnpoYW5nQGlu
dGVsLmNvbT4gd3JvdGU6DQo+DQo+IEN1cnJlbnRseSwgdGhlIHRyYWNlIHN0cmluZyBpbmZvcm1h
dGlvbiBiZWZvcmUgYW5kIGFmdGVyIHJjdV93YWl0KCkNCj4gYW5kIHNjaGVkdWxlX3RpbWVvdXRf
aWRsZSgpIGFyZSByZXZlcnNlZCwgdGhpcyBjb21taXQgdGhlcmVmb3JlDQo+IHN3aXRjaGVzIHRo
ZXNlIHN0cmluZ3MgaW4gb3JkZXIgdG8gY29ycmVjdGx5IHRyYWNlLg0KPg0KPkkgc3VnZ2VzdCBw
cm92aWRlIG1vcmUgZGV0YWlscyBvZiBob3cgdGhpcyBhZmZlY3RzIHlvdXIgdHJhY2luZy4gT25l
DQo+Y29tbWl0IHRvIGRyYXcgaW5zcGlyYXRpb24gZnJvbSBjb3VsZCBiZToNCj4NCj5mN2Y3YmFj
OWNiMWMgKCJyY3U6IEhhdmUgdGhlIFJDVSB0cmFjZXBvaW50cyB1c2UgdGhlIHRyYWNlcG9pbnRf
c3RyaW5nDQo+aW5mcmFzdHJ1Y3R1cmUiKQ0KPg0KPldoaWNoIGFsc28gbW9kaWZpZXMgdGhlIHNh
bWUgY29kZS4NCj4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50
ZWwuY29tPg0KPiAtLS0NCj4gIGtlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaCB8IDggKysrKy0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmggYi9rZXJuZWwvcmN1L3RyZWVf
cGx1Z2luLmgNCj4gaW5kZXggN2IwZmU3NDFhMDg4Li43YjYyMmI1MTk2YTggMTAwNjQ0DQo+IC0t
LSBhL2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaA0KPiArKysgYi9rZXJuZWwvcmN1L3RyZWVfcGx1
Z2luLmgNCj4gQEAgLTExMTQsMTAgKzExMTQsMTAgQEAgc3RhdGljIGludCByY3VfYm9vc3Rfa3Ro
cmVhZCh2b2lkICphcmcpDQo+ICAgICAgICAgdHJhY2VfcmN1X3V0aWxpemF0aW9uKFRQUygiU3Rh
cnQgYm9vc3Qga3RocmVhZEBpbml0IikpOw0KPiAgICAgICAgIGZvciAoOzspIHsNCj4gICAgICAg
ICAgICAgICAgIFdSSVRFX09OQ0Uocm5wLT5ib29zdF9rdGhyZWFkX3N0YXR1cywgUkNVX0tUSFJF
QURfV0FJVElORyk7DQo+IC0gICAgICAgICAgICAgICB0cmFjZV9yY3VfdXRpbGl6YXRpb24oVFBT
KCJFbmQgYm9vc3Qga3RocmVhZEByY3Vfd2FpdCIpKTsNCj4gKyAgICAgICAgICAgICAgIHRyYWNl
X3JjdV91dGlsaXphdGlvbihUUFMoIlN0YXJ0IGJvb3N0IGt0aHJlYWRAcmN1X3dhaXQiKSk7DQo+
DQo+RG9lc24ndCB0aGF0IGxvb2sgd2VpcmQgYmVjYXVzZSBub3cgeW91IHdpbGwgaGF2ZSAyICJT
dGFydCBib29zdA0KPmt0aHJlYWRAIiBtZXNzYWdlcyBpbiBzdWNjZXNzaW9uIChvbmUgb2YgdGhl
bSBjb21pbmcgYmVmb3JlIHRoZSBmb3INCj5sb29wKSA/DQo+DQo+ICAgICAgICAgICAgICAgICBy
Y3Vfd2FpdChSRUFEX09OQ0Uocm5wLT5ib29zdF90YXNrcykgfHwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgIFJFQURfT05DRShybnAtPmV4cF90YXNrcykpOw0KPiAtICAgICAgICAgICAgICAg
dHJhY2VfcmN1X3V0aWxpemF0aW9uKFRQUygiU3RhcnQgYm9vc3Qga3RocmVhZEByY3Vfd2FpdCIp
KTsNCj4gKyAgICAgICAgICAgICAgIHRyYWNlX3JjdV91dGlsaXphdGlvbihUUFMoIkVuZCBib29z
dCBrdGhyZWFkQHJjdV93YWl0IikpOw0KPiAgICAgICAgICAgICAgICAgV1JJVEVfT05DRShybnAt
PmJvb3N0X2t0aHJlYWRfc3RhdHVzLCBSQ1VfS1RIUkVBRF9SVU5OSU5HKTsNCj4gICAgICAgICAg
ICAgICAgIG1vcmUyYm9vc3QgPSByY3VfYm9vc3Qocm5wKTsNCj4NCj5BbHNvLCBpdCBpcyB3ZWly
ZCBoZXJlIHRoYXQgeW91IGFyZSBjYWxsaW5nIHJjdV9ib29zdCgpIHJpZ2h0IGFmdGVyDQo+cHJp
bnRpbmcgIkVuZCBib29zdCBrdGhyZWFkIi4NCg0KDQpUaGUgdHJhY2UgSSB1bmRlcnN0YW5kIHNo
b3VsZCBiZSBsaWtlIHRoaXM6DQoNCnJjdV9ib29zdF9rdGhyZWFkKCkNCnsNCgl0cmFjZV9yY3Vf
dXRpbGl6YXRpb24oVFBTKCJTdGFydCBib29zdCBrdGhyZWFkQGluaXQiKSk7DQoNCglmb3IgKDs7
KSB7DQoJCXRyYWNlX3JjdV91dGlsaXphdGlvbihUUFMoIlN0YXJ0IGJvb3N0IGt0aHJlYWRAcmN1
X3dhaXQiKSk7DQoJCXJjdV93YWl0KCk7DQoJCXRyYWNlX3JjdV91dGlsaXphdGlvbihUUFMoIkVu
ZCBib29zdCBrdGhyZWFkQHJjdV93YWl0IikpOw0KDQoJCXJjdV9ib29zdCgpDQoJCQ0KCQl0cmFj
ZV9yY3VfdXRpbGl6YXRpb24oVFBTKCJTdGFydCBib29zdCBrdGhyZWFkQHJjdV95aWVsZCIpKTsN
CgkJc2NoZWR1bGVfdGltZW91dF9pZGxlKDIpOw0KCQl0cmFjZV9yY3VfdXRpbGl6YXRpb24oVFBT
KCJFbmQgYm9vc3Qga3RocmVhZEByY3VfeWllbGQiKSk7DQoJfQ0KDQp9DQoNClRoYW5rcw0KWnFp
YW5nDQoNCg0KDQo+DQo+dGhhbmtzLA0KPg0KPiAtIEpvZWwNCj4NCj4NCj4NCj4gICAgICAgICAg
ICAgICAgIGlmIChtb3JlMmJvb3N0KQ0KPiBAQCAtMTEyNiw5ICsxMTI2LDkgQEAgc3RhdGljIGlu
dCByY3VfYm9vc3Rfa3RocmVhZCh2b2lkICphcmcpDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IHNwaW5jbnQgPSAwOw0KPiAgICAgICAgICAgICAgICAgaWYgKHNwaW5jbnQgPiAxMCkgew0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBXUklURV9PTkNFKHJucC0+Ym9vc3Rfa3RocmVhZF9zdGF0
dXMsIFJDVV9LVEhSRUFEX1lJRUxESU5HKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgdHJh
Y2VfcmN1X3V0aWxpemF0aW9uKFRQUygiRW5kIGJvb3N0IGt0aHJlYWRAcmN1X3lpZWxkIikpOw0K
PiAtICAgICAgICAgICAgICAgICAgICAgICBzY2hlZHVsZV90aW1lb3V0X2lkbGUoMik7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHRyYWNlX3JjdV91dGlsaXphdGlvbihUUFMoIlN0YXJ0IGJv
b3N0IGt0aHJlYWRAcmN1X3lpZWxkIikpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBzY2hl
ZHVsZV90aW1lb3V0X2lkbGUoMik7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHRyYWNlX3Jj
dV91dGlsaXphdGlvbihUUFMoIkVuZCBib29zdCBrdGhyZWFkQHJjdV95aWVsZCIpKTsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgc3BpbmNudCA9IDA7DQo+ICAgICAgICAgICAgICAgICB9DQo+
ICAgICAgICAgfQ0KPiAtLQ0KPiAyLjI1LjENCj4NCg==
