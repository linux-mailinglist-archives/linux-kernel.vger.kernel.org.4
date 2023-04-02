Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428F96D35F5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 09:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDBHnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 03:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBHnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 03:43:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC93AD1E;
        Sun,  2 Apr 2023 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680421389; x=1711957389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z5p8DY5oBxI4x0+CuRjFatKWC4y6pc+rCqHO+I8toIE=;
  b=Qk21zN3mJ6nJ7fVq82c3d5rQj6IrRTl4xVtbl0dRth/tXOqVreJa5TSM
   D1wUTAoYdfuNxkDKsgNleozaOUMMRG7CkJLE48QTdcY7PZJEBSjXpGfBx
   M+qNBsy5MGc/btKTgoZrqDvw5GaYh/VKVR4h5vaZRaWNyKqJDp7E3V8ri
   H3dnf7jbqecc2fIiCz7tK/SSErSeit8hw4WWboIlk1poDiljkDuP76oMk
   IhkrIPs/s3+QAnOJpyyT68V5R9TFy5F2dZMu13g1KNlRVdxqSisHZ8Vw4
   IIPdHJ90f99EDLc2UO7VtFPgEA07GUNbTksA4Qb6hXrwFPi1bbQdeITJR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="344265189"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="344265189"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 00:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="754865945"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="754865945"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2023 00:43:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 2 Apr 2023 00:43:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 2 Apr 2023 00:43:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 2 Apr 2023 00:43:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOemlvUD3kLlO893dP46wILNwqR6SV7bJ73e3K0oJb82L6LejuNUYPby1gTFahMrQM3Q5W1EojlCKOlNRN/TcCC4OTU11nmPmrTImZvKcJTsauVw2DZmUmGB0Q1t4beSsrA8o++bdPOS8J05TV7TG3LS1NGL+ze9XLpF/p3wYra6Fpv3sWjkb+3Tf0agQFb9oALeHPp42GP/5gW37dcqlKBeEhPBkONwD1PADDzwZILn8IVAdcOi+Vsd+oKrhuCqWnzM5UXOvhZkrdvqooK7C8hmSJwYHDoohpa9zqjNuXVwOdenVorD7ZFeStz4UHkYsGoytwRt1P3pOoWEK+rg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5p8DY5oBxI4x0+CuRjFatKWC4y6pc+rCqHO+I8toIE=;
 b=VzyD0kRBcuKH8WYUTEbr+MJFZvME07iDA9AVSuGYRXOTygfL7KUmIKXoi4inWeDz+4vQ8IQL2j932Hhk0fSJC6zSND6Ei/P9K7AouSkWS5vRI8Y5x77wztVgP9HRpDCtd1CkLEK4KxPLordZrpMeCeHNUxyWN1039EgxFIUt08XZapZZAHYkmFu4jVmkBZLOmOjRQGmhy7nsVfA3oUYW3IPQnM+6ZUeCwtAmqiGkA7kDvYgkQDLEOauoyLKX3j9Gegmo89z+koNHZiVzTlgiCW1JpY1QMdy+TKujooD70UK5l71ikTnkk9ww6uymMIp2ewtwJEnmdiFC49hlhu1VnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by CO6PR11MB5634.namprd11.prod.outlook.com (2603:10b6:5:35d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Sun, 2 Apr
 2023 07:43:05 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Sun, 2 Apr 2023
 07:43:05 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 04/15] powercap/intel_rapl: Support per Interface
 primitive information
Thread-Topic: [PATCH 04/15] powercap/intel_rapl: Support per Interface
 primitive information
Thread-Index: AQHZWB316+yFrnQACUyVZt8gfW7tUa8TscuAgAQLegA=
Date:   Sun, 2 Apr 2023 07:43:05 +0000
Message-ID: <1299d6418c469d56cfe4c94af7342e9c9d26858e.camel@intel.com>
References: <20230316153841.3666-1-rui.zhang@intel.com>
         <20230316153841.3666-5-rui.zhang@intel.com>
         <CAJZ5v0hG9mC0DAWeGfgcrripi8dpANSwBgBQxjDSzzLGQcC0iQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hG9mC0DAWeGfgcrripi8dpANSwBgBQxjDSzzLGQcC0iQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|CO6PR11MB5634:EE_
x-ms-office365-filtering-correlation-id: d02b9dda-a19b-4684-3242-08db334de500
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKxHWsx+duW8ILzRhEdveE23DN4tkgOvv5gBdEfg8ZuowbhN3XMTT7cyv5seg+vkDcNk9mvL+slBDv0HKXsbF/UlIsd2ntnjc8z/DIVrHiMfh8Vb7sxBT5g4ZSW+GBDpXTGeBu2gXKHLGdMMWtJwtRR6/DTJ9E48O45biKSQIh47QOeJ6+/bZ3q+Nn3cEVxchWQdlSstcCYSuPIRM03r/Vm0AX3HgVrR+NET/2zF2X2Dlsjy0ylNGiY7Qn/rJTUb7T6ovDCi5i4OSclz04O4qjyJr5Ader6wUBZOaaUJ+iHcjkV5WTRS4pb0B/s1DCuVB6JWsjmv2HuAN0ifKyDjjSm/zI1/ahcadhLSI02TohagbVCCS4a6bvd2p8IPyBz/tvkOGiup6ZsUgXLYAHUeiHF7sEkRQ+LAgeBB17yhWr7j/w6c76QqOCp5+pzqzGpWB0qUZJv8GGagzi94419tKNsRiD1NCocOCDvrbU8cPpMTjP3v+5BJBsLGQjKelyqTeHZzzZ0swHYDpEW/6t9wvTjICte1TZe8TopalW3RccUw2REDoRYku9IfatTeQivKb9GJFVq0B8HR+2DQJcYzcLA/7nCjb/vUPxmF8VWKO7largwbh/nFisLRP/dQp1sC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(41300700001)(91956017)(8676002)(6916009)(4326008)(66476007)(64756008)(76116006)(66946007)(66556008)(66446008)(478600001)(316002)(54906003)(8936002)(122000001)(82960400001)(5660300002)(38100700002)(53546011)(186003)(83380400001)(2616005)(71200400001)(107886003)(6486002)(26005)(6512007)(6506007)(86362001)(36756003)(2906002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXlYc0o1VmxDRE0rWm1RcW9XelVLU1RXb0hqeld4Q2xjWDlyVDE2K2FxZHFO?=
 =?utf-8?B?WEhGVGdvNXJXQzZjbVlKM3FMdThZTkN2VlRWMG5KcWlKaWdHTmxGTmpQMHV6?=
 =?utf-8?B?Mm80U093bFJUVVdFeFdmYnoycVZwYVFEcGFYSHJGVCtobVpNMnh0eFEzWU9p?=
 =?utf-8?B?c0RMeG5mUEhNZ0dLazlJZlJSN1p4cHhYaUd4ZnlrS0VKUnllZHY1TFhsbXNs?=
 =?utf-8?B?UExvVUE2MlhrNkFxdXdLNC9keWF4ZDN1cDFndC8yZHZTMk9QY1kwQmJ4Rzg4?=
 =?utf-8?B?dGZLSjBFQTUrRFlQdmxQZ3BkQ3ZucEpoL3lyUVMxMFpGVEZpaE03SlJud2M5?=
 =?utf-8?B?QVArbUI2akIyMVJTMnk1UmwzL2xjUHZ5NktzME9oRE5LM25vOWZxbzhWMklh?=
 =?utf-8?B?bDh1eWd5empsZGpHNktDKzltZlpXUEJGTDEzMFBvcGNuUWZsWHk3amYvbnNn?=
 =?utf-8?B?c2kzYjRLdWxVeS9KMEtwaTNtZ1JDcVdDVVhpdUZQMHp5aVJVZnkzRFFsTGl0?=
 =?utf-8?B?RW5TcDlRNU5IaWxRREE5aTgyelh4bGlqNWg1RVNWT01EaGNNMjZQTnRBOElS?=
 =?utf-8?B?MmFMNUpCbnNmSzFkYi9ncThMcUlzaVltakNSay81b2ZrajdyK01qSkFxQ01o?=
 =?utf-8?B?T25iaG8zbDBTdVE3cFVEbjFXSnprZk9BZzkvQVgxakhOZlFNVnJpdlJZOXo2?=
 =?utf-8?B?S0VRVS94NkoxTlZGRGdOd3oyNDlEUS9UbXRkSHozb0doQVg0clFGSHlqdHJD?=
 =?utf-8?B?YldwNXlZcHlMS3V0VDdsaTF0d2c0SVA4ak40K092czc0TTlkL2RKQXc2MXUr?=
 =?utf-8?B?MllIS25ncGRoU0V3MUt6UVhkNXJtR0dFek9Ua21CUmRzS05CS2x2dklqZWNN?=
 =?utf-8?B?dE5hNWZobmtBbGpLTHE2NnE4eDBGdzExTHlQUnVFc1Q5eDJPcm9xbDlOeFpx?=
 =?utf-8?B?TjdhejQzSEVDS1FCZ3cvRzAxbGlJN3NCZmdiemxJaldxVVFyUUJEdkVGVmRh?=
 =?utf-8?B?c2lwSHA5bkhDOCtkVGM2bFdZSzUvdzQ2RGZucDVuWlNtbkh1R2c0N1IyaGIr?=
 =?utf-8?B?YnFYQjBoLzlkTnl3MG10ZHdqYVlzK0oyd3NqMW9pWDNJbnZ6OXlZNXp6K2R4?=
 =?utf-8?B?aXQvbndMS2RIZHZUelNvNXZMS0tBdkF6LzRzTnRaRTFYUUszcHpabTB6TFpl?=
 =?utf-8?B?SWltZVhiT1RMVUZENnlrb3RBdmZFelhVLzhzUllMZkk5M0ZFV0drNVErNmtk?=
 =?utf-8?B?Z05pQ0dkV2dwSkZWZmYwTFVpbGtCSE50WWJHNGpmT0paOG5Ob3pQcE1YVjE0?=
 =?utf-8?B?c0VLQ3VLMGtWdElPSWlKSzBOeUJPVldoUnp5dUwrejROMkxJTlp6ZHhwc1gw?=
 =?utf-8?B?RmF5dFl3UUVSbGlneWxXRDJyR0FMTTNiY0FJK3Y3R3NyUWxFSEVHZXRTWmpv?=
 =?utf-8?B?QTRsWEgvUVZsTmtTMDBLZlBmRjdUL093MlNzbmFaVHMra3U3SHNhQ0xNSXJt?=
 =?utf-8?B?M3BKeng5cjFXQWxZckFYYXFhQkhHdnBXVUNEallVSnF2RW5ucXFOb25EMSta?=
 =?utf-8?B?dkNkdHdUcVFBeEtKTkZ0MnlrL1lIUHYwNWE0Y0hvZWpjVjB6bkwwWXRaRk10?=
 =?utf-8?B?ZEQ5aVN6TjA3dkhXRVRudDcwR0NwdWcwN0psdUw1RWdjRjl0d04vdFZUMzc5?=
 =?utf-8?B?RE02R29kL0FPem9Sb081a2JKUTVJZ1pPWGJUTUlUeU02c2pUSUpMV1huamFZ?=
 =?utf-8?B?K29zdHg1UE9EeVhYN044K211eW16MHJFbmRHYitRMUUzdGREQkVwTmNpOEFI?=
 =?utf-8?B?bEl3eDZVemlWa2FpNXRYRm1yN09laGpHZTRrZjdwRUxGNWlCajVnYzhsTDhu?=
 =?utf-8?B?dmpjQ0V1Y3V2YlJBVDZBSkF4dWNicERGdEhDbDRmdmFPWUk2ZHhpdm9scG9N?=
 =?utf-8?B?MlZ0OGZrSVVLdm1iTGttY2MyS3duV01zRCtSb2hNdW9LMnhNbk5adE94Y3hY?=
 =?utf-8?B?c1dSV0p6T3VVYzJsNm1UaTFnaUpMd1lGVzEwQUQwZXBDS2c1WXBjSXk1Tk91?=
 =?utf-8?B?ek41eEhuSTUvR1V3L3BZZDNVVkh6Zm5MSE9CL0h2NGVKTWN5dkRXNUJwQ0I4?=
 =?utf-8?Q?bGQu902prtC+Pm+aFzK9J/PkN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83BA649FED9F864588334EE6E79C5505@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02b9dda-a19b-4684-3242-08db334de500
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2023 07:43:05.0239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtEaI6WEokiiRkJbE8FOrwYo5k+Ch2LsX0rVXVyuGFXcVLmYcPUtzHEY0w4n16nva1T+Yiio0wv8sxi/9NM/hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5634
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTMwIGF0IDE5OjU2ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBNYXIgMTYsIDIwMjMgYXQgNDo0MuKAr1BNIFpoYW5nIFJ1aSA8cnVpLnpo
YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gUkFQTCBwcmltaXRpdmUgaW5mb3JtYXRpb24g
aXMgSW50ZXJmYWNlIHNwZWNpZmljLg0KPiA+IA0KPiA+IEFsdGhvdWdoIGN1cnJlbnQgTVNSIGFu
ZCBNTUlPIEludGVyZmFjZSBzaGFyZSB0aGUgc2FtZSBSQVBMDQo+ID4gcHJpbWl0aXZlcywNCj4g
PiBuZXcgSW50ZXJmYWNlIGxpa2UgVFBNSSBoYXMgaXRzIG93biBSQVBMIHByaW1pdGl2ZSBpbmZv
cm1hdGlvbi4NCj4gPiANCj4gPiBTYXZlIHRoZSBwcmltaXRpdmUgaW5mb3JtYXRpb24gaW4gdGhl
IEludGVyZmFjZSBwcml2YXRlIHN0cnVjdHVyZS4NCj4gPiANCj4gPiBQbHVzLCB1c2luZyB2YXJp
YW50IG5hbWUgInJwIiBmb3Igc3RydWN0IHJhcGxfcHJpbWl0aXZlX2luZm8gaXMNCj4gPiBjb25m
dXNpbmcgYmVjYXVzZSAicnAiIGlzIGFsc28gdXNlZCBmb3Igc3RydWN0IHJhcGxfcGFja2FnZS4N
Cj4gPiBVc2UgInJwaSIgYXMgdGhlIHZhcmlhbnQgbmFtZSBmb3Igc3RydWN0IHJhcGxfcHJpbWl0
aXZlX2luZm8sIGFuZA0KPiA+IHJlbmFtZQ0KPiA+IHRoZSBwcmV2aW91cyBycGlbXSBhcnJheSB0
byBhdm9pZCBjb25mbGljdC4NCj4gPiANCj4gPiBObyBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYyB8IDUwICsrKysr
KysrKysrKysrKysrKy0tLS0NCj4gPiAtLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9pbnRlbF9y
YXBsLmggICAgICAgICAgIHwgIDIgKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRp
b25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
b3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gYi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVs
X3JhcGxfY29tbW9uLmMNCj4gPiBpbmRleCA1NmU4YWYyYTFlNmYuLjg5ODIzODI4NTE4OCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiBAQCAtNjU0LDcg
KzY1NCw3IEBAIHN0YXRpYyB1NjQgcmFwbF91bml0X3hsYXRlKHN0cnVjdCByYXBsX2RvbWFpbg0K
PiA+ICpyZCwgZW51bSB1bml0X3R5cGUgdHlwZSwNCj4gPiAgfQ0KPiA+IA0KPiA+ICAvKiBpbiB0
aGUgb3JkZXIgb2YgZW51bSByYXBsX3ByaW1pdGl2ZXMgKi8NCj4gPiAtc3RhdGljIHN0cnVjdCBy
YXBsX3ByaW1pdGl2ZV9pbmZvIHJwaVtdID0gew0KPiA+ICtzdGF0aWMgc3RydWN0IHJhcGxfcHJp
bWl0aXZlX2luZm8gcnBpc19kZWZhdWx0W10gPSB7DQo+IA0KPiBXaGF0IGRvZXMgdGhlICdzJyBp
biB0aGUgbmFtZSBzdGFuZCBmb3I/DQoNCidycGknIHN0YW5kcyBmb3IgcmFwbF9wcmltaXRpdmVf
aW5mbywgc28gSSB1c2UgJ3JwaXMnIGZvciBhIHNlcmllcyBvZg0KcmFwbF9wcmltaXRpdmVfaW5m
by4NCg0KdGhhbmtzLA0KcnVpDQoNCg==
