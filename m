Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2ED6CB32E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjC1BdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1BdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:33:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ABD1BCB;
        Mon, 27 Mar 2023 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679967185; x=1711503185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1fSA3LpiQ3ra9/EQxyjiYEiHQwjUG0dRskqjevUeKJ0=;
  b=RzilWKP0jvuPh3AYtyqjzH5yHDYTcoqGbc+LDdQX+56h9W40pE2lJQUL
   jycKLu3pNRW+GC3jt5F24xAcauwbnrEaB+b7/mgAHcqC3DbY4ImdI09wO
   tZiVUUJBuTBTAaGpESC2TK21j2Mk1yQgDU+PFFtZYyPU6IHw1Fp61W61W
   In/JTU/Fg5kSvHPePzUfaGOh2sMpxw+hkBmFGPAdjWkb2qknarljpAnJ4
   aB/4LnK8qj0RMdjoYSxKqtzlu/Nvz8lQcJYw+QTRi+FAS5zZDyd37xO2v
   GHmnDQ6zYDtHalUqfFAIsiMH0hQ4S6+80qy318yFecByneTjroaoS+Fqr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="339163074"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="339163074"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 18:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="677170352"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="677170352"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2023 18:33:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 18:33:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 18:33:03 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 18:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D637LK/ah2rIvg/QvSTzV99TlT4u9Ye3BD/38UWSWs57OvHmoQ1e8Up8mUqbtqi3SPPESav89OvLva3GWD5ZO0mJNPTGTVQZIr9HvO7S+Dz8LpkvpE8MvIQufU4qUQY0CHcA7HG0oe08VU8Royu3i6zdtePsAbBaLNutKdGQE/QoPrP33Cx5ILsiLJrh9T3Dg1aUsAQlmwG/17du9x+go6I+JqJejUbWLdeWC5PfAvUC3TmyZVLpikkv1k94iU7uKRFohdFcBpMJGhv0O5cTQyajHgmMpl1HikX7XB34hbYr9voWWB9DMwPE5rI1H0lNAoVGPmawuCi2Rg3kc+TQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fSA3LpiQ3ra9/EQxyjiYEiHQwjUG0dRskqjevUeKJ0=;
 b=S//O//a7CmgD9FnWmIBx0KZRK6fPmM4Hx5HdJEX0Ehav+JP6j5GX3ccCezUiqfTqpGY1gwj39abr2qbTTGCUkhq5bDw4937bW4sbw/68FojiMD/dPhBsIuPhj1yircQs3A3RF9empfY8K0L+vGjb7fEX5UJJvBKITBgsigsdol2JhgCHvI6rIWB8mgU1zuX8BajtHYoMcIirJ4JIpPfzPan7kYpvfrUrH9cApyX1FXwIn0A7vc6XG7omLY28xMImOa6flddML6/ehPO5vj/BGAfD+iIcD+p8TYznol7eJgDRtykljFQd06baGW80rxWgQ/EllS6zwH1jWZ3bEeBeew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM4PR11MB8129.namprd11.prod.outlook.com (2603:10b6:8:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Tue, 28 Mar
 2023 01:32:56 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 01:32:56 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Oleksiy Avramchenko" <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: RE: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Topic: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Index: AQHZW9/cQoPnlerMcUKFbHJCjrW4W68FRAeAgAAUR4CACSeJoIAA622AgAAGJeA=
Date:   Tue, 28 Mar 2023 01:32:56 +0000
Message-ID: <PH0PR11MB58801CAE9B282B399B918852DA889@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230321102748.127923-1-urezki@gmail.com>
 <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
 <ZBnKKZsSpI8aAk9W@pc636>
 <PH0PR11MB58805561777B77DC69E87711DA8B9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ca153af5-bd66-4d48-afa5-ace3a13aec3c@paulmck-laptop>
In-Reply-To: <ca153af5-bd66-4d48-afa5-ace3a13aec3c@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM4PR11MB8129:EE_
x-ms-office365-filtering-correlation-id: c5870e28-0f6c-4fb3-49d2-08db2f2c5bb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33YZ6MuDf3juHbmIKJufGCtVgZ2AiU6g2xvT7eBKBCciL+Of6jmMttSZ5Uo2+gKOvhUYbZG+kXFHlEaVrQD803Z1GE1x9007wrsa5W3epC0WevuBjKDKvm4YRo8PK1gZvLH6enyPudG+J+1BjW5zBp8XA42OAvVChY97+GSGgcFwM1FLOCB7ouBRw7OnWpY3py4bwbELLo+nmXvX3tv4gI6kbFZkx2C6HgyVklE3O9t+0MqFcV0ZcAueYpvXSIkXnWvGp+BLiMBR/S4jv5zdxYnNORCP9elH75/CUTneR0eF02kWkyb87asXj6046OAqaM822e3HYbEzXS4TKkAYB6NZO+f4rQcO6vgqZl35DhN6NnZq//j6c+BSVxDtxTNn3x04eMjqyNAXdXJghh0allEkOnxZUMj1hp7lzqRnQvX8KjjJ6EGxD5WX2+ImYb20Cv5UaAOZHA1ECH/LCmLO/14zVDpI9TigzYF6ykTHKR8wOO1nwM8ZQd1pVL9S4zxSsP9fCyVZoFaEU02wFe1KEmw+Hrk+Db5/ODwz3X0RmydFkeUCLI/klFCD1rzdqS6K9zvzGMhlYLvayiARm9STU3D8Fi+2hS2nOY2kQwH7natF0AvWthu1RCeN1EOBYHCe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(83380400001)(8676002)(66946007)(66556008)(64756008)(76116006)(2906002)(66476007)(4326008)(6916009)(66446008)(54906003)(71200400001)(478600001)(7696005)(9686003)(316002)(186003)(26005)(38070700005)(7416002)(55016003)(6506007)(86362001)(52536014)(41300700001)(8936002)(38100700002)(122000001)(82960400001)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHI2Y0FqQTF6K0RvT1diRHloQ0hpM1F2OXFXY3hmNFh4WUlXcXZUdFFRZDhF?=
 =?utf-8?B?OGUveExjYm01VkFZYStzQzN4TGhqUFNGb09SK0gvZXpkbmFMQldESklXWEIz?=
 =?utf-8?B?N3ZVNUNCZDA4QmdzSElaOUNVM1lGOUhBS096MG9XZWRXNFEvNVhUWjl6dDVY?=
 =?utf-8?B?RGpJaCtRZWZnUW1RWWZNWlJEdGVOT0VxNUJGTW16TzhkQlNJY0FCTUtyT2h5?=
 =?utf-8?B?c0UzMldLSHBLaDVxb2txSitNa1hXY2UvcW9CYzJYS1M0OEpYZ0VhWnBsOHUy?=
 =?utf-8?B?eWY4bU03VStEVVQwRGY4Y0pTOXJwRzd2U05lWG5tcVM0WEpXNkg2N0NTNysw?=
 =?utf-8?B?Y3h4UlB2RTRoUEYxbHJsT0tMR2FYZnRtYWtTODVucDZMS2x2WVJDUHNmejJx?=
 =?utf-8?B?T3I0Vi9NWWpLdWl6K0FXa3BmT0dpZGVweUVHRml4ckw1aVhTT04xc1hrcGxE?=
 =?utf-8?B?SjhUWlBoUWZYSER4L1VXcTBRK2pCWldCZlJ4Tm1YT2lMbnhEY2tYSnRFaWRP?=
 =?utf-8?B?Q1I4b1ppd1gxZkZVM1ExeVB5L0lSMEwrRHJIazVZeUR0ajQ1WmZjam01OTc5?=
 =?utf-8?B?WFlkc216SkE1ZWRsQjk0QkRzZ29OV1dGem81SGJCQ04xdk9MWHdOZGFrTzBL?=
 =?utf-8?B?UVV5Q004VGVCdm9uM0pwVnNPb2ZSbVdCOEdzZFRaTkR3dTR0c0U3T1d3TnlO?=
 =?utf-8?B?VStUcVV0ZmxLRUYzMDdmOGlXUHNoRmh1NXFVdEZoTWMvcG45N3FRRFloUFdj?=
 =?utf-8?B?c01uaCtURm9TUFZDMlNEbjVva3J3eTQzN3h2ai9NeHpIZE9XeHZ1MWR5UElz?=
 =?utf-8?B?MWVVTWZ6aDFjUkV6N1NoSWdBdE82UGNyZmR6VjF1MXFIZGYzbFZGVFJ4NGtJ?=
 =?utf-8?B?UGlvL2hQeTV4YW1xbFQ4cERoUFhwWkNxeWpFZEJKK0U0YzZWM3MrUWs0K2lK?=
 =?utf-8?B?QzVUWEJ0T0pzdUZMZ0E0OVFQSUREQWh0WCsrcVpoY0VYVUFBYjZGaDdKOCt5?=
 =?utf-8?B?TmsvNFRoZi9SVlNCNFB5UlJON3R5a1owOHFCNndta0ViZytsOGhoUU5oYnBp?=
 =?utf-8?B?YUFvYXFKaTRKTWVhS2FVOUU3UHN4aHRwRkh0dnpmcTArMkhQY0M5OGdlendt?=
 =?utf-8?B?WS9ZRWVUbWZuWE1weDJpUHcvT3Nxd0RkNDY4VEdTc054cnJ3RU4rR3F3Wlp3?=
 =?utf-8?B?Z2NWSWxiNDlEWC85b1Exd3piQjNvMUpQYzlPbmpoMTVTdEhTTnk5NlpQbk9X?=
 =?utf-8?B?WDR2cWFjRzlrYndNQnFscS9DRTNmcmtDWDdTeU1iK0hYekRaSWw1YmZ5MW9Q?=
 =?utf-8?B?Y2xHbEY2QXZOajZoY2ZEOXRxK2FTMGtmWW9VNnN2b3JBRlNsSnZCeW1LYkZS?=
 =?utf-8?B?RmYvSmtxQlpqdkxBeVVlMkFYZVRVcnRSNloySGZmZUs0TlppK0pvMHozWHF5?=
 =?utf-8?B?eXBmWnNiQ2ZXRjgxcklxTWpEK1A1R0ZzdXBPVzk3aWx5U0tXcGlzQTRqamtS?=
 =?utf-8?B?SXVtYkJOL3pPQmdJZ1F6Sm93OXRhLzBwYlkzQkpCRkVlSWVGU1lmQTY0SWdm?=
 =?utf-8?B?QkFvcTVXUU5od2ZlRUJXcWNOejhsZk84RitxWjRLNllPZmZKM2lBeEYzZjl1?=
 =?utf-8?B?bEx6dW9qUzJwRjd1aytVMjEycGxKK0doa2hlNVV1RDJNTHBQRTRQaVFZS2Jk?=
 =?utf-8?B?NnRYeDVZNzQ2UVRvTzFiRHBzbjlMVExwVCsxcURLNGRsUCtjQUtXbjB5Z0NM?=
 =?utf-8?B?RklvY0lwWTczSWdHRGp6a0hBL0s1T25NbENYUTZ1aXhrVjBiNlArRG1BNVky?=
 =?utf-8?B?V0hBSzUrUGlDOUZhc0w5bCtvYytMbUhZeTZETXA1MnM3SFVwM1N1ZXIrdDd0?=
 =?utf-8?B?a1BUSEw1Ry9laGU4SWdnL0hqWW85VnNtZHhDbkhhV2Q2ZXF5UDdBcVkwM3A0?=
 =?utf-8?B?Mnd3cVdjQjBiNjgrR2hXWnAzeHlqTHhLRVlXajBHdXNiNllrVUtXMXdQeDd3?=
 =?utf-8?B?cms4NDByVm1OYXQ4SVA5bkZLVG5wd2RVZUUxNnpaVkVvVkJOZVAyVkcraXAv?=
 =?utf-8?B?WUg2OXp3c3VGMk16YXlFM0R1aHlSMC8xSkdhRlBzd0phNjk1MmM5MVRXVG4r?=
 =?utf-8?Q?4zN5czOO2h/xV4pR+Perj46fH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5870e28-0f6c-4fb3-49d2-08db2f2c5bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 01:32:56.6208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgDuZu9uOe2manYNZ5Dwevf5TcielSqfK428TmmFlaIZET/s07peico8fZlrVwBEhqIm/lsfHmbfYtYazYx08w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8129
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gRnJvbTogVWxhZHppc2xhdSBSZXpraSAoU29ueSkgPHVyZXpraUBnbWFpbC5jb20+DQo+
ID4gPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAyMSwgMjAyMyA2OjI4IFBNDQo+ID4gPiBbLi4uXQ0K
PiA+ID4gU3ViamVjdDogW1BBVENIIDEvMV0gUmVkdWNlIHN5bmNocm9uaXplX3JjdSgpIHdhaXRp
bmcgdGltZQ0KPiA+ID4gDQo+ID4gPiBBIGNhbGwgdG8gYSBzeW5jaHJvbml6ZV9yY3UoKSBjYW4g
YmUgZXhwZW5zaXZlIGZyb20gdGltZSBwb2ludCBvZiB2aWV3Lg0KPiA+ID4gRGlmZmVyZW50IHdv
cmtsb2FkcyBjYW4gYmUgYWZmZWN0ZWQgYnkgdGhpcyBlc3BlY2lhbGx5IHRoZSBvbmVzIHdoaWNo
IHVzZSB0aGlzDQo+ID4gPiBBUEkgaW4gaXRzIHRpbWUgY3JpdGljYWwgc2VjdGlvbnMuDQo+ID4g
PiANCj4gPiANCj4gPiBUaGlzIGlzIGludGVyZXN0aW5nIGFuZCBtZWFuaW5nZnVsIHJlc2VhcmNo
LiA7LSkNCj4gPiANCj4gPiA+IEZvciBleGFtcGxlIGluIGNhc2Ugb2YgTk9DQiBzY2VuYXJpbyB0
aGUgd2FrZW1lX2FmdGVyX3JjdSgpIGNhbGxiYWNrDQo+ID4gPiBpbnZvY2F0aW9uIGRlcGVuZHMg
b24gd2hlcmUgaW4gYSBub2NiLWxpc3QgaXQgaXMgbG9jYXRlZC4gQmVsb3cgaXMgYW4gZXhhbXBs
ZQ0KPiA+ID4gd2hlbiBpdCB3YXMgdGhlIGxhc3Qgb3V0IG9mIH4zNjAwIGNhbGxiYWNrczoNCj4g
Pg0KPiANCj4gDQo+IA0KPiBDYW4gaXQgYmUgaW1wbGVtZW50ZWQgc2VwYXJhdGVseSBhcyBmb2xs
b3dzPyAgaXQgc2VlbXMgdGhhdCB0aGUgY29kZSBpcyBzaW1wbGVyDQo+IChvbmx5IHBlcnNvbmFs
IG9waW5pb24pICDwn5iKLg0KPiANCj4gQnV0IEkgZGlkbid0IHRlc3Qgd2hldGhlciB0aGlzIHJl
ZHVjZSBzeW5jaHJvbml6ZV9yY3UoKSB3YWl0aW5nIHRpbWUNCj4gDQo+ICtzdGF0aWMgdm9pZCBy
Y3VfcG9sbF93YWl0X2dwKHN0cnVjdCByY3VfdGFza3MgKnJ0cCkNCj4gK3sNCj4gKyAgICAgICB1
bnNpZ25lZCBsb25nIGdwX3NuYXA7DQo+ICsNCj4gKyAgICAgICBncF9zbmFwID0gc3RhcnRfcG9s
bF9zeW5jaHJvbml6ZV9yY3UoKTsNCj4gKyAgICAgICB3aGlsZSAoIXBvbGxfc3RhdGVfc3luY2hy
b25pemVfcmN1KGdwX3NuYXApKQ0KPiArICAgICAgICAgICAgICAgc2NoZWR1bGVfdGltZW91dF9p
ZGxlKDEpOw0KPg0KPkkgY291bGQgYmUgd3JvbmcsIGJ1dCBteSBndWVzcyBpcyB0aGF0IHRoZSBn
dXlzIHdvcmtpbmcgd2l0aA0KPmJhdHRlcnktcG93ZXJlZCBkZXZpY2VzIGFyZSBub3QgZ29pbmcg
dG8gYmUgdmVyeSBoYXBweSB3aXRoIHRoaXMgbG9vcC4NCj4NCj5BbGwgdGhvc2Ugd2FrZXVwcyBi
eSBhbGwgdGFza3Mgd2FpdGluZyBmb3IgYSBncmFjZSBwZXJpb2QgZW5kIHVwDQo+Y29uc3VtaW5n
IGEgc3VycHJpc2luZ2x5IGxhcmdlIGFtb3VudCBvZiBlbmVyZ3kuDQoNCg0KQWdyZWUsICBtYXli
ZSBVbGFkemlzbGF1ICdzIHBhdGNoIHdpbGwgaGF2ZSBzaW1pbGFyIHByb2JsZW1zLg0KDQpUaGFu
a3MNClpxaWFuZw0KDQoNCj4NCj4JCQkJCQkJVGhhbngsIFBhdWwNCj4NCj4gK30NCj4gKw0KPiAr
dm9pZCBjYWxsX3JjdV9wb2xsKHN0cnVjdCByY3VfaGVhZCAqcmhwLCByY3VfY2FsbGJhY2tfdCBm
dW5jKTsNCj4gK0RFRklORV9SQ1VfVEFTS1MocmN1X3BvbGwsIHJjdV9wb2xsX3dhaXRfZ3AsIGNh
bGxfcmN1X3BvbGwsDQo+ICsgICAgICAgICAgICAgICAgICJSQ1UgUG9sbCIpOw0KPiArdm9pZCBj
YWxsX3JjdV9wb2xsKHN0cnVjdCByY3VfaGVhZCAqcmhwLCByY3VfY2FsbGJhY2tfdCBmdW5jKQ0K
PiArew0KPiArICAgICAgIGNhbGxfcmN1X3Rhc2tzX2dlbmVyaWMocmhwLCBmdW5jLCAmcmN1X3Bv
bGwpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwoY2FsbF9yY3VfcG9sbCk7DQo+ICsNCj4g
K3ZvaWQgc3luY2hyb25pemVfcmN1X3BvbGwodm9pZCkNCj4gK3sNCj4gKyAgICAgICBzeW5jaHJv
bml6ZV9yY3VfdGFza3NfZ2VuZXJpYygmcmN1X3BvbGwpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJP
TF9HUEwoc3luY2hyb25pemVfcmN1X3BvbGwpOw0KPiArDQo+ICtzdGF0aWMgaW50IF9faW5pdCBy
Y3Vfc3Bhd25fcG9sbF9rdGhyZWFkKHZvaWQpDQo+ICt7DQo+ICsgICAgICAgY2JsaXN0X2luaXRf
Z2VuZXJpYygmcmN1X3BvbGwpOw0KPiArICAgICAgIHJjdV9wb2xsLmdwX3NsZWVwID0gSFogLyAx
MDsNCj4gKyAgICAgICByY3Vfc3Bhd25fdGFza3Nfa3RocmVhZF9nZW5lcmljKCZyY3VfcG9sbCk7
DQo+ICsgICAgICAgcmV0dXJuIDA7DQo+ICt9DQo+IA0KPiBUaGFua3MNCj4gWnFpYW5nDQo+IA0K
PiANCj4gPiA+IA0KPiA+ID4gPHNuaXA+DQo+ID4gPiAgIDwuLi4+LTI5ICAgICAgWzAwMV0gZC4u
MS4gMjE5NTAuMTQ1MzEzOiByY3VfYmF0Y2hfc3RhcnQ6IHJjdV9wcmVlbXB0DQo+ID4gPiBDQnM9
MzYxMyBibD0yOA0KPiA+ID4gLi4uDQo+ID4gPiAgIDwuLi4+LTI5ICAgICAgWzAwMV0gLi4uLi4g
MjE5NTAuMTUyNTc4OiByY3VfaW52b2tlX2NhbGxiYWNrOiByY3VfcHJlZW1wdA0KPiA+ID4gcmhw
PTAwMDAwMDAwYjJkNmRlZTggZnVuYz1fX2ZyZWVfdm1fYXJlYV9zdHJ1Y3QuY2ZpX2p0DQo+ID4g
PiAgIDwuLi4+LTI5ICAgICAgWzAwMV0gLi4uLi4gMjE5NTAuMTUyNTc5OiByY3VfaW52b2tlX2Nh
bGxiYWNrOiByY3VfcHJlZW1wdA0KPiA+ID4gcmhwPTAwMDAwMDAwYTQ0NmY2MDcgZnVuYz1fX2Zy
ZWVfdm1fYXJlYV9zdHJ1Y3QuY2ZpX2p0DQo+ID4gPiAgIDwuLi4+LTI5ICAgICAgWzAwMV0gLi4u
Li4gMjE5NTAuMTUyNTgwOiByY3VfaW52b2tlX2NhbGxiYWNrOiByY3VfcHJlZW1wdA0KPiA+ID4g
cmhwPTAwMDAwMDAwYTVjYWIwM2IgZnVuYz1fX2ZyZWVfdm1fYXJlYV9zdHJ1Y3QuY2ZpX2p0DQo+
ID4gPiAgIDwuLi4+LTI5ICAgICAgWzAwMV0gLi4uLi4gMjE5NTAuMTUyNTgxOiByY3VfaW52b2tl
X2NhbGxiYWNrOiByY3VfcHJlZW1wdA0KPiA+ID4gcmhwPTAwMDAwMDAwMTNiN2U1ZWUgZnVuYz1f
X2ZyZWVfdm1fYXJlYV9zdHJ1Y3QuY2ZpX2p0DQo+ID4gPiAgIDwuLi4+LTI5ICAgICAgWzAwMV0g
Li4uLi4gMjE5NTAuMTUyNTgyOiByY3VfaW52b2tlX2NhbGxiYWNrOiByY3VfcHJlZW1wdA0KPiA+
ID4gcmhwPTAwMDAwMDAwMGE4Y2E2ZjkgZnVuYz1fX2ZyZWVfdm1fYXJlYV9zdHJ1Y3QuY2ZpX2p0
DQo+ID4gPiAgIDwuLi4+LTI5ICAgICAgWzAwMV0gLi4uLi4gMjE5NTAuMTUyNTgzOiByY3VfaW52
b2tlX2NhbGxiYWNrOiByY3VfcHJlZW1wdA0KPiA+ID4gcmhwPTAwMDAwMDAwOGYxNjJjYTggZnVu
Yz13YWtlbWVfYWZ0ZXJfcmN1LmNmaV9qdA0KPiA+ID4gICA8Li4uPi0yOSAgICAgIFswMDFdIGQu
LjEuIDIxOTUwLjE1MjYyNTogcmN1X2JhdGNoX2VuZDogcmN1X3ByZWVtcHQgQ0JzLQ0KPiA+ID4g
aW52b2tlZD0zNjEyIGlkbGU9Li4uLg0KPiA+ID4gPHNuaXA+DQo+ID4gPg0KPiA+IA0KPiA+IERp
ZCB0aGUgcmVzdWx0cyBhYm92ZSB0ZWxsIHVzIHRoYXQgQ0JzLWludm9rZWQ9MzYxMiBkdXJpbmcg
dGhlIHRpbWUgMjE5NTAuMTQ1MzEzIH4gMjE5NTAuMTUyNjI1Pw0KPiA+IA0KPiA+WWVzLg0KPiA+
DQo+ID4NCj4gPiBJZiBwb3NzaWJsZSwgbWF5IEkga25vdyB0aGUgc3RlcHMsIGNvbW1hbmRzLCBh
bmQgcmVsYXRlZCBwYXJhbWV0ZXJzIHRvIHByb2R1Y2UgdGhlIHJlc3VsdHMgYWJvdmU/DQo+ID4g
VGhhbmsgeW91IQ0KPiA+IA0KPiA+QnVpbGQgdGhlIGtlcm5lbCB3aXRoIENPTkZJR19SQ1VfVFJB
Q0UgY29uZmlndXJhdGlvbi4gVXBkYXRlIHlvdXIgInNldF9ldmVudCINCj4gPmZpbGUgd2l0aCBh
cHByb3ByaWF0ZSB0cmFjZXM6DQo+ID4NCj4gPjxzbmlwPg0KPiA+WFEtRFE1NDovc3lzL2tlcm5l
bC90cmFjaW5nICMgZWNobyByY3U6cmN1X2JhdGNoX3N0YXJ0IHJjdTpyY3VfYmF0Y2hfZW5kIHJj
dTpyY3VfaW52b2tlX2NhbGxiYWNrID4gc2V0X2V2ZW50DQo+ID4NCj4gPlhRLURRNTQ6L3N5cy9r
ZXJuZWwvdHJhY2luZyAjIGNhdCBzZXRfZXZlbnQNCj4gPnJjdTpyY3VfYmF0Y2hfc3RhcnQNCj4g
PnJjdTpyY3VfaW52b2tlX2NhbGxiYWNrDQo+ID5yY3U6cmN1X2JhdGNoX2VuZA0KPiA+WFEtRFE1
NDovc3lzL2tlcm5lbC90cmFjaW5nICMNCj4gPjxzbmlwPg0KPiA+DQo+ID5Db2xsZWN0IHRyYWNl
cyBhcyBtdWNoIGFzIHlvdSB3YW50OiBYUS1EUTU0Oi9zeXMva2VybmVsL3RyYWNpbmcgIyBlY2hv
IDEgPiB0cmFjaW5nX29uOyBzbGVlcCAxMDsgZWNobyAwID4gdHJhY2luZ19vbg0KPiA+TmV4dCBw
cm9ibGVtIGlzIGhvdyB0byBwYXJzZSBpdC4gT2YgY291cnNlIHlvdSB3aWxsIG5vdCBiZSBhYmxl
IHRvIHBhcnNlDQo+ID5tZWdhYnl0ZXMgb2YgdHJhY2VzLiBGb3IgdGhhdCBwdXJwb3NlIGkgdXNl
IGEgc3BlY2lhbCBDIHRyYWNlIHBhcnNlci4NCj4gPklmIHlvdSBuZWVkIGFuIGV4YW1wbGUgcGxl
YXNlIGxldCBtZSBrbm93IGkgY2FuIHNob3cgaGVyZS4NCj4gPg0KPiA+LS0NCj4gPlVsYWR6aXNs
YXUgUmV6a2kNCg==
