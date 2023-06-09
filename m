Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BE3729494
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbjFIJRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241398AbjFIJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:16:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA40F4680;
        Fri,  9 Jun 2023 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686301950; x=1717837950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2j4jomLk0TGKjFcKFTNcFF+0r1t7bJB8PqnhgjRoH/k=;
  b=GHF7Lz17Ge139CmGgYRXhMJNM38rojCBt6xDOLqUmWhgZ/Zg8K+OYWN8
   Y8JMmOjHawJHz+GaTDuV1siHxGFaiSK4AjExaIlJYnvqUDs1T+Wcvzsat
   2O2ho1SXiGr/Whzg13Y5ZgYgHTY49+mVzT+g0yTEvkTI816+7plj/UWYz
   hxcn9ER8Ur9q0q2juORbklsZvuFrrpe8PPn9CN9r9EOzESvCWQ2pZ+qsR
   m+8WmiwFtcgEiLcF3hGRQU+JxKNuJgHyybjlfPU2fbz9qmY//e6ctDdhK
   tf64ymrF5vda9XKOsKby1GK4rgMYy2732CQ9jXJPoNMg1cW4CdZy3t3xr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342230314"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342230314"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="780236905"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="780236905"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2023 02:10:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 02:10:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 02:10:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 02:10:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghIJE1JsHXoBoEM3dLQCbc3++f+AUI1liLvV+AHDuhEkoXJ35USN7195htcR+MJsuW20CaZ4K7aalwY4ETLZYGNOxbpkObTH4Gs4EI5q4SPFvtdbxXZGIlOwtKjs3AtGiD9HE7t3sOhUNfbecGi1kPtVSw4iirLILKRJ5rBTLruPNiMZo6+d9p7PrmTUNBTv8j1/nwksIHfKaN0aONJo1zYxQyCa6gsUVlUZDl6FcvqvllSZD5VSMqDMVE1phipGXOto/7pDYTREpHawgB9Lhis6g4ONkE6BGAx+6LGH2DZfzkzoBYJR1KoMl6otpQiQOiVo9U/v0vVeCBXBFb0a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j4jomLk0TGKjFcKFTNcFF+0r1t7bJB8PqnhgjRoH/k=;
 b=eL/jyt3ZFta+c2kjxISEVIrnchEo7ae/x/BbYC0Trre4MY6iVRqNpa5WNz1OhtysMRt7huFFWM+wV/2MUTZLqGf2/JZWGvs90inH8rVXd+2ju8P/P2wTy5H9LeMDcgzBUnfFWtHbTp8ntZBHnPEK4RJHA4u7jHF6OlghKVf7MSPp6F4aZQNiIbh3CfUBCo79sp0zPMEMTgCH/7qyqT7izM+Rn4vAk13vYEaj7wxG+KjtoIRWo3Qi7dqyKH+C2zFh4KPQKtXaS1/2ojvwoZJZzxSaVcuR7rB0KER4qV987bL4S1FO+bE1zX/cOcIJwWBcx07TD5EWRbXodzobktfA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2779.namprd11.prod.outlook.com (2603:10b6:5:c6::26) by
 DS7PR11MB7931.namprd11.prod.outlook.com (2603:10b6:8:e5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Fri, 9 Jun 2023 09:10:43 +0000
Received: from DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de]) by DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 09:10:42 +0000
From:   "Jadav, Raag" <raag.jadav@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: RE: [PATCH v2 3/4] pinctrl: intel: simplify exit path of set_mux hook
Thread-Topic: [PATCH v2 3/4] pinctrl: intel: simplify exit path of set_mux
 hook
Thread-Index: AQHZmqwOzSQDmehkJEaWgiHSbhsDla+CJXQAgAAG6zA=
Date:   Fri, 9 Jun 2023 09:10:42 +0000
Message-ID: <DM6PR11MB27791AE074AE94F8CA5C02A58C51A@DM6PR11MB2779.namprd11.prod.outlook.com>
References: <20230609082539.24311-1-raag.jadav@intel.com>
 <20230609082539.24311-4-raag.jadav@intel.com>
 <20230609083552.GM45886@black.fi.intel.com>
In-Reply-To: <20230609083552.GM45886@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2779:EE_|DS7PR11MB7931:EE_
x-ms-office365-filtering-correlation-id: 3cdb54d9-3737-43f9-1619-08db68c966dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NWvX2fo4TSQYKLX1qQDFR1F6sjWpMCKok/YWeaMCIdpiXd9OeD+YbYjsM4CWNnV5CGW+Bx9salc6t9X6W5fKn6hxTrzvVdbgy162eY8KOV5kcRH35++9Foff26Ox6BoFcrQVU5JOxtSe1GlR27G4qRe8q833460nnEVeT09+GS85u4JJQLFCUClZ5s5H6Xk3tOFaccFAy87SNVW7ETmEjZ0RQzH9+ZyfLjzCQh2Ka99ljJLeP2JUW73xx8Y62qXmMb9jIXl/BOTwSnZzDhANVj7n79dZ2oFAlPYofIaM7nq+0EY6Z9oRUGweLq2M3MG6CNWLf0zahjxC5RReqVe5uRgHPD0X/baxB0xSU9uOHUjlW2Zl8YByxDqrrGZowsbZTtVhSIIWuKZUrrlD3yeoS6lG+Kd0cwkU2XxWAnyWqODIYiXu9Wj5wE01qsmXQ5DBmsETK1vU6U3JukBpLUUaTY6xqov1WxIrT8ClunQ0ScqbUbmQP4ef+gW4+mnSxJCbRY5qbfA4+XVM5WcLnKrSbgwo/AcaId6xlcS5p0ppSzAVrGw6h7IGyo1xe+snzonRjjJEPoiIKyiVarN8UPV/6hL+xYo/IKaewS5TqkbgMhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199021)(66556008)(71200400001)(7696005)(4744005)(76116006)(66446008)(2906002)(64756008)(66476007)(82960400001)(122000001)(66946007)(54906003)(38100700002)(86362001)(8676002)(8936002)(38070700005)(478600001)(316002)(6916009)(33656002)(4326008)(55016003)(52536014)(5660300002)(41300700001)(6506007)(26005)(9686003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0lXQTAybitrZWxRYkVNSlRPWXRLTGhrQmJ4ZGQ3V09URlJEdnVneWQyQnZ6?=
 =?utf-8?B?WDBVZU80RVhyNmJ4aDNzMjFvZFl4cGpNcnBaWDZNLzZYUXFBT0dxNDZid1Yv?=
 =?utf-8?B?bHZmbk1nYnNhMVh0aGIvS29lYk1xRlpibWJBcU1pQ2UrUURpQ2FHS1hXaWxW?=
 =?utf-8?B?RmhVWmJORjhRMDBDek5SV2oyVnZxaGIwQlpTaG8xS25kdTZaTUpsNmlaNmZi?=
 =?utf-8?B?NHlJZjdvODNhQU1ZbEY1dktqSHlPUnY4RUtrNjNRK1piMWJsb3RDMDdoWmxs?=
 =?utf-8?B?VldDWld5UURTMXg3clB3aGNEZnVyclVteVZ2U25Ha0pya3kxZUFOb2lUUllz?=
 =?utf-8?B?RFZxMUtzbGRGRzYvd010Q1FGZld5a0ppQXFKM0pCSFlpbkV3aXZpdWplWFhq?=
 =?utf-8?B?UlJmVUNkMUhWS21XVE54MFJmNkFTeUtZcVFadmhDNUNkWnhRVDZWVUhMeVNH?=
 =?utf-8?B?WVg4alRlNkltdVhBN0U2N04xemxCTU5BVnZyc016NnVKOUhxN0lML3VwOGRL?=
 =?utf-8?B?ZDhBOFAyaGJDazZLMlo3T29maU81eFdjY1JIZ2hEOHFJOWo0NHo3eUVZTzRk?=
 =?utf-8?B?ak9IREZWcy84eVpxaVhRWFNvNW1wMFF0dUl5cmpRSG16QkNYWEFiNTRPYXZY?=
 =?utf-8?B?dW9Mc1BJaHdxd3pFVzVsK3VXRXB5ZVhrK2JNNmU4TndZeXZzVS9lTUppR05D?=
 =?utf-8?B?d3dubHJIU1BqYlR3TnFTY2lXVjhSNFpEeFBRVHFrTUd3czFaQUJvTkF2WFpU?=
 =?utf-8?B?dE9BMDRxZTlMODZEMzMxYTl3S1lidUVwOWpQa3J6cFE0NnB3bS9jVmFnUTNS?=
 =?utf-8?B?VkRhUGFacTBuQzY5RmdnMnEzM0gzOGJ2QjhNeUpDdjZOQ0ZxNWh3V01ySzBW?=
 =?utf-8?B?ais5WGtYa0IzU0pXYzVxZ2pMTSt2T2Z1S3Z4ekQwUlZoZng1S1kvY01YRm5m?=
 =?utf-8?B?ZmFyMDhmNm05Skx0Um95SzA3MW9HK3BkQnl5MTk0dFY3V0dxeWYzQktMVm9h?=
 =?utf-8?B?QzZMMlR3YUtUQkIzdmMySzBYT1A4UzNURXRwRzBicmdoQ1Y4UWxPL2VrK0RO?=
 =?utf-8?B?L1h2ZDhGU05JdlFVMENXTGRmTnQ4YVppWVFJZzNsZUp2cXhZMWUwc3hpckpR?=
 =?utf-8?B?aHlubSt6YllGYzdtQzZzeGY3UTlxeUhWaWZaekdpN1doVUVqVGlwWmtkYm1E?=
 =?utf-8?B?clFrZkRGTTBuVDNpNm1LMUtoa2dlbUd4cnBqREZYQ0k1N3V6aGtKU3J2Zkdq?=
 =?utf-8?B?MXBRVnNseGdXdWdic0w2bHUwL20yQUhuRUx2RiswZTBmTysxL0w0KzQzT2sv?=
 =?utf-8?B?SHl3UnNwNzVjN2VaMExEMEcwWERPM0sxT3l5R1RKaGZLZ1hSYlo1VExhdmNJ?=
 =?utf-8?B?WkZFc09HZ1pBLzJZRDNxZzh6bDhOVmZ3RVg3bWsvM01HTVlwUENpZ3E4Ym9R?=
 =?utf-8?B?UGxzczhCWmxxdVF4alN6ZmRoN2FuV1NmZHk2OFJJZzlrMVdLamdsTk1UM0Jh?=
 =?utf-8?B?WUljdXEvT3RwVHFOR1hjS05xd3l4TittUjgydlhBc0MyRlo2akgwejNwZEJ2?=
 =?utf-8?B?ZmdZS0s0akJBNEJVdncxQ2VWM2RIc3FWWm5JaHJUemMrUzdZSXc2alFhQ0x3?=
 =?utf-8?B?NEdybloyTXkyVlpSWHp1cUlhY1BZK3ZIWENLengxbnB4S3AraG5uUk52aCsz?=
 =?utf-8?B?cjAyTWpvcEE4bC9vZ2tBcnF4OVdGZzlUY2dVUUlRN0RMeFRtVnR3QnQ1bmhx?=
 =?utf-8?B?OFppeTNvTkxOb1ovNXAyZHRNUmdiTmo4Q2NHaHlwMFdnb25DR3k2SU9uVDJL?=
 =?utf-8?B?WG5QY2ZxUllxV0h1UmFZeUFFQzRITThhOGFtQlZYVUk2K1JwZkJyeURFMnJr?=
 =?utf-8?B?MEpHbnRBV0syS2NMOS9uemZFc2pwRHVyaDlqSHhSaG9mRkhCUjNCNFowVExs?=
 =?utf-8?B?aUVxYXdEcHJyeTZJd1YvYXRqMkJ4MXZObWtSWlNBZGxxTzY5Zm55cko1Mlg2?=
 =?utf-8?B?WnYwSXJxOW9jeFQwdTRlallobTc1WlVGVXZTc2ttUGhxS2JVc3V6ZE9rS1VY?=
 =?utf-8?B?dUNQUUV3Q2ViLzRPQkNuOFhqQTBUelZQVXY1L2pqYjVOY3YvbnFMeUZUZFU4?=
 =?utf-8?Q?g077I7a1fQ9ug5MGPY12zj90S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdb54d9-3737-43f9-1619-08db68c966dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 09:10:42.6474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trZo8WiJilU8PUXL7vDYR1DK0sT+TcRQ05vZPA8Y7ucw1DSWVfFCPwr6Mm7BaQD/wSFTHzsw+PQBWTxlKEa9pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7931
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGcmksIEp1biAwOSwgMjAyMyBhdCAwMTo1NTozOFBNICswNTMwLCBSYWFnIEphZGF2IHdy
b3RlOg0KPiA+IFNpbXBsaWZ5IGV4aXQgcGF0aCBvZiAtPnNldF9tdXgoKSBob29rIGFuZCBzYXZl
IGEgZmV3IGJ5dGVzLg0KPiA+DQo+ID4gYWRkL3JlbW92ZTogMC8wIGdyb3cvc2hyaW5rOiAwLzEg
dXAvZG93bjogMC8tMjIgKC0yMikNCj4gPiBGdW5jdGlvbiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBvbGQgICAgIG5ldyAgIGRlbHRhDQo+ID4gaW50ZWxfcGlubXV4X3NldF9t
dXggICAgICAgICAgICAgICAgICAgICAgICAgMjQyICAgICAyMjAgICAgIC0yMg0KPiA+IFRvdGFs
OiBCZWZvcmU9MTA0NTMsIEFmdGVyPTEwNDMxLCBjaGcgLTAuMjElDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSYWFnIEphZGF2IDxyYWFnLmphZGF2QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9waW5jdHJsL2ludGVsL3BpbmN0cmwtaW50ZWwuYyB8IDkgKysrKystLS0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBU
aGlzIGFkZHMgb25lIG1vcmUgbGluZSBzbyBpdCBpcyBub3Qgc2ltcGxpZnlpbmcgOy0pDQoNCldv
dWxkICJvcHRpbWl6ZSIgc291bmQgYW55IGJldHRlcj8NCg0K
