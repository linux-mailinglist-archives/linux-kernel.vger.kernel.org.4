Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB565FB30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjAFGGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjAFGGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:06:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E636147A;
        Thu,  5 Jan 2023 22:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672985200; x=1704521200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i7Rt5rlmIK7eb0arlqsLvdAaRrtfFur8tR5n4Vh2KS4=;
  b=VF2GW0sVZzoD6SFumhekojVS6cl7qxjtji6jnj/+zvbGrlPebgiZi4UT
   bmVLe/XqfRo8O3cGiX7ilsFgtUtscK5muQPIXpq7aJFHXwyi6miWJbdlu
   RwVHOaZCSU6ETEoNwMdKj1+7BkeDMECAQY5INcmw7GGqSrPssVoHMNlZm
   J8jX1D0FmPEqRkTsMaVSnqikKtZ2cQbmbb1wyjRP2Uzje/S/oxHCxYp9K
   7+zE9No9MgjFCK3SzoL8LlO2ni3AU2EEqzrcWzkRvlrY54IoTLVAu3QtY
   QnhH1TIUlp1i6bbtxx+aRm+qWkrePSneqiy1W9az2a2VvNGq6RHl825x0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="310204752"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="310204752"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 22:06:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="655863701"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="655863701"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2023 22:06:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 22:06:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 22:06:26 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 22:05:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmAjWTJpjkseel4O3QQK5kFrwn522z+Mb4IQuEpu71aL/fqpuntBQLEYAk1fTfOL+Kf7zXPmUKYrPMF++RuEIzSsGR0datVbLg5OgQm+QEAr6JKskKpGbTOBiEaQQ7evTUbWXKDwSjj4O+ot1ajB/IZbQWbpBljzAcYE0pA1ewi3QwmcsnGC6ssrQeDVui1dONT1U1nvAJcVw/ccz1DTuYUoeKp8sLYulPg7Pn9cWkZAzuV/il6rsBPooFemLBa3MPSQbBZDCa1wAWDCPyapK0SgmgSFNMzDNV8H2bLWExY1GVmgsC3hkP5Z/vZvFiMZ24d6brKgwMOr/rGveAFzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7Rt5rlmIK7eb0arlqsLvdAaRrtfFur8tR5n4Vh2KS4=;
 b=Igb8jfAdSOPaq9PPVVWEGZz2/aX9qkNuDprhjvAmSVT72rkvOkpH7Q7Abh5598XmSN53cep7yvGICUKei01UBFUrG42lAVQrle69vpKrrk9Kph4en/yA2gNfwg75R+3xCoKT3OATraYFRCtlYNGeaLA7wNejDovyOSk3nXxZSScaL+AYY5z0mAbuglO4lXQ993xxkIi+E6GYcjIeRaPVJnEwphtihRvt2dnzEUAz+AY5dMnYiKAkSXmmVAfPTY95i8JzCQIiTkSUrP4YTSiE1o5Yh+BYiCpvdOTIe5LjNkpg/KK+86/9ZrIrK6SBbqGtTkGxR/zK2xyi4b27azRGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5014.namprd11.prod.outlook.com (2603:10b6:510:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 06:05:41 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 06:05:41 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Thread-Topic: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Thread-Index: AQHZIF1bxwQ7XEIB0EO18Lgdi7O9X66PZGKAgAAyjYCAAVIkAA==
Date:   Fri, 6 Jan 2023 06:05:41 +0000
Message-ID: <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
References: <20230104145831.25498-1-rui.zhang@intel.com>
         <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
         <ea9186869cca50a21efcc1a9cc4dbe5adcd1784b.camel@intel.com>
         <Y7aejeHDpLlwwYbr@zn.tnic>
In-Reply-To: <Y7aejeHDpLlwwYbr@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5014:EE_
x-ms-office365-filtering-correlation-id: df4783d6-aae3-4a3e-ecb8-08daefac0a50
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WPsRebloIOzeRsV/Hkva9uh+VOx+qZGZ4iX1t1GVHAqPdM/4aR1on3HIFJM7DmGgHMDSBzEM+/2tw4U2MQ2I+L2UlmHZeVQwRGCVZ/u+/+IXoCFpTSI4R9R66JrzrbpBn7AydcyFFwBVyYN6jj7+S+GsnOyTsAG3ajoBlpKyuG4ZNeGUHhxywAwTItYkOmP5tVt7zT/0KpfaC5mcOr5Gex4ev0UEyB1n8vG0sqrykSKeIgiIxBNfeWDLCGcjdt7iN3xEed6DEgLHVBdOyWcyWKnx7zLEmebR4tLMGSyyGIF/FnyVXAkHhzN2sewUgQAbF3NJ2FtvcEpcz77fl+nnWw/cVrh8xpPkTV6Gx/xjyo07Tn2ht4XqLGQML6HdekP37e8/X3rii6mE07efgNfS0pBvhunSFOMC14JR+kadBZ3LsOYwlr/+VOl4UjfzCESLIpZuBBfCQIKeUjExRSokJtVRYgFT8haggOXNDwPKISfarzhALfXV97AKL4MWkw+Nk/lXTaBc1luHzcqdEsz/TisqjxCdf0bdmnMyTAB5W1We3yVNjAZLOP03mgdsXSOvJsd4/Kv8S+l6Qcf5rbdZDaINfDojfDZqknQ4wkf5F8X4TBkJFADH/3gbYU3LhBmGiX019Wfl7yeZHU7YioOGwdZ44ueiDeaGsbCsDV6Vt2s4PouoDiUXkq4cjQDFjPKl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(64756008)(41300700001)(316002)(76116006)(8676002)(4326008)(66476007)(66446008)(66556008)(91956017)(2616005)(66946007)(36756003)(38070700005)(86362001)(122000001)(8936002)(7416002)(5660300002)(38100700002)(6916009)(54906003)(82960400001)(2906002)(478600001)(6486002)(6512007)(186003)(71200400001)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2pkczB5ajdzUUxnR2d5dk9MdklIRHYrWm5rL1pFWTlZdkJCcHQ4QVFNMzNG?=
 =?utf-8?B?bEZwOGtJcFArMjZXU2JIL1JYMU1Zd1FoVlhFYU1kTys3N0ExaWtyeWJRbTNS?=
 =?utf-8?B?Qzk3OHBLU010N3JoVjRYVUFlV3pxR1EzanpsaWN6a2VsakU2Rnc5L3R3emVr?=
 =?utf-8?B?ZVlFN09IWTdJODJObzFxK0ZJa3l6alhIZ0hYY2YyN1M5THdwTDdaQk9TWkZz?=
 =?utf-8?B?OXdzSkxmbU4veWFrQ0RNR2QzdWJZVnRtWTkrRWk4OUVBQU5GblhsU1F6UlJS?=
 =?utf-8?B?dUU4U29DSnZkUmtudml1QlZtZjd3Kzh2Qi9TMFV6akNHWTNrb2loUWpzNHpL?=
 =?utf-8?B?M29VS0E1RnlKdkdmaSt6YzJweU1xTFhJSlZrd0x1aWRLdmhjR3I1TmdsS293?=
 =?utf-8?B?OVpLR1Jrdm9jR3NoODB0ZXc0MUJieGNIdmFNWW1mL0ZuUUVJTms5ZmVkS25D?=
 =?utf-8?B?RS9KbmhEeG40bFp3cnlSZkpIWmpIcnRzY3ZzbVpXbFdyQ3pXcU1rK0wvVE9K?=
 =?utf-8?B?Y2liUjB0a3ZsQjQ4UURFY0NpWW5xNG9pY2ZvUXdrYUFVQXA0d3NnRFJFZUxY?=
 =?utf-8?B?bnF3OFhvV2svWk5lZ3oyMm1sWVNqVHFSazBaWUpDZUZQUmk2SXplR1NmbXFE?=
 =?utf-8?B?SHRuc1NqTENhYjViQzVjcnFnMm81Y2VucWMwZUJnYXRuKzdHSkRJbEgxYVA2?=
 =?utf-8?B?MVlXeWl4WW1mOFpueG5jMjZzcFJGNUVMeHVQWEMvUUprV1F6R21seVovWHJY?=
 =?utf-8?B?bktTYnpDei9hSzlvVFlDTmxwMW85ODJ3c0JmU1BZRjBBKy8wRDZ3K1ZIT3E0?=
 =?utf-8?B?Q25yYVcvWmwvYzFCWHYvUWhnYlpPT3lxazBEcGhTUXpPYVBEVEk3SHdLWlpC?=
 =?utf-8?B?ZTU5ZktpZUZiSmEvOGRTeWJPdGxSdmdFUVhaNmxERFdsYUxTT0VaQS9GUlhC?=
 =?utf-8?B?ZWU0TEN3aUxpMkFJdmc4UzhIVnVlTXd0SHFNczJ3eU9udi9NSmRRUmZsSlMx?=
 =?utf-8?B?UWNnM0NGcGJ6aklkU0NzbnQzY0xIOHN3T3Q0bkZVS0x2SVJwaDV4eW5HMllV?=
 =?utf-8?B?SUEvclBTNXh1VmFzT1JpY3lPM0lLNXJGSXJCazN6Q3hhemNrK2IrVHF5eWph?=
 =?utf-8?B?dGxKMitpL0YxSExtNFV5WFZya0VCTWoxSG16N1I4bjJrOWdYWXJjTGdZTE44?=
 =?utf-8?B?THcyMlpDR01UMnVqUXdhNHNrSDBEU01BcCt6eEt4MXFZZGUzZER5RU1hQWhx?=
 =?utf-8?B?cTNMQ1liYUx3Q1E4MnZlWE05MXhCVHJNWGRsWEFnM2t5QllMK1ZRVGJTaEhO?=
 =?utf-8?B?aDVxV0VHeGlWZDhMTWFmUnoyalhqeExVUDdVblBETFZzem9SdWJvMS8zdjY4?=
 =?utf-8?B?Q1VOcTFHN210S2tGa1FrTXdOdXJmUHZ4SzByOG9hcG8vMERiZGNqNHN4VUJ1?=
 =?utf-8?B?amhWcCtMdC9WTkNIZExZRVp5UWMya1E5S0k5ckFRYkJVeWZyU1RWL29JckZr?=
 =?utf-8?B?bVQ4QTdPRUtUcVdSc3ozZndoc0FRenJMc2duT0JKY1dYdW1kbkNXUXBLblB6?=
 =?utf-8?B?UHFNVUUwQjIyZEVBNzhha3BwMi9Odno2ZTR0ekh0QzRCUDhMK2pYTUJFS1ZL?=
 =?utf-8?B?aEo2Uy83Z002OFJEdE96Y1pRR1VINFlKYUMzSGs1SXRCeU5weFJDZU52MGh2?=
 =?utf-8?B?dmtQcXgvbUlNWFdhSXRTYTBrdnRSRGtHbWVtSU92QWZzUEhENkdacTcxQklE?=
 =?utf-8?B?dTMzS2FQd0NORnZLSXdMRm9rekNHb2xqWFFXY2FCeEFNYUhIVzFaTmd6eHJE?=
 =?utf-8?B?NGt1YlpQcnYyekh0NmpRd1hqVUVMTk01a0dDM2N1M3RIR1gzUmlEYjYyeE9q?=
 =?utf-8?B?VGZIWExVZ0dCS1ZDcExIMnU0TmRINGZkOUhralp5M3UxQjhPcUt3RFV3N2RE?=
 =?utf-8?B?a2k3eWhyWHZSc3dYcGZlTTAxdU1NK0R4QUlvK2VUd2c3MlRkVXZ3U3NsUkpG?=
 =?utf-8?B?b0RFVGpCRllJVW5BbmQvUmpGSlR4SWZaeDJmOEwwNHBUaWw1UTA4TjQwUFU5?=
 =?utf-8?B?cFZJS0ZuWG9XK01FVFhmOE9wN0t3cHZzdHE0cjk1ZFZPMDkycWRDQTlobFpk?=
 =?utf-8?B?MllSUGhKN01YYTRXMUVTWHBiVmhDQTdyNm5obHF2b3R6Ni8xZkRKb1paazY2?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C8D4BEB98164445A47C3EF8258E49DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4783d6-aae3-4a3e-ecb8-08daefac0a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 06:05:41.2210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHreZLq7JLTEweHp0odDT1Sx+hWt/JXnsIL4KEvqXZO/fLmXPYc0gMdPNvxJXoSthJXfwGl+A/6ADd+aLOHv0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5014
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

T24gVGh1LCAyMDIzLTAxLTA1IGF0IDEwOjU1ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgSmFuIDA1LCAyMDIzIGF0IDA2OjU0OjMxQU0gKzAwMDAsIFpoYW5nLCBSdWkg
d3JvdGU6DQo+ID4gSSB0aG91Z2h0IG9mIHRoaXMgYmVmb3JlIGFuZCBnb3Qgc29tZSBpZGVhcyBy
ZWxhdGVkLg0KPiA+IFNheSwgaW5zdGVhZCBvZiBtYWludGFpbmluZyB0aGUgbW9kZWwgbGlzdCBp
biBhIHNlcmllcyBvZiBkcml2ZXJzLA0KPiA+IGNhbg0KPiA+IHdlIGhhdmUgc29tZXRoaW5nIHNp
bWlsYXIgdG8gImNwdV9mZWF0dXJlIiBpbnN0ZWFkPw0KPiANCj4gWWVzLCB5b3UgY2FuIGRlZmlu
ZSBhIHN5bnRoZXRpYyBYODZfRkVBVFVSRSBmbGFnIGFuZCBzZXQgaXQgZm9yIGVhY2gNCj4gQ1BV
IG1vZGVsDQo+IHdoaWNoIHN1cHBvcnRzIHRoZSBmZWF0dXJlIGluIGFyY2gveDg2L2tlcm5lbC9j
cHUvaW50ZWwuYyBzbyB0aGF0IGF0DQo+IGxlYXN0IGFsbA0KPiB0aGUgbW9kZWwgbWF0Y2hpbmcg
Z3VuayBpcyBrZXB0IHdoZXJlIGl0IGJlbG9uZ3MsIGluIHRoZSBDUFUgaW5pdA0KPiBjb2RlIGFu
ZCB0aGUNCj4gb3RoZXIgY29kZSBzaW1wbHkgdGVzdHMgdGhhdCBmbGFnLg0KDQpHcmVhdCwgdGhh
bmtzIGZvciB0aGlzIGluZm8uDQoNCkJ1dCBJIHN0aWxsIGhhdmUgYSBxdWVzdGlvbi4NClRha2Ug
UkFQTCBmZWF0dXJlIGZvciBleGFtcGxlLCB0aGUgZmVhdHVyZSBpcyBub3QgYXJjaGl0ZWN0dXJh
bCwNCmFsdGhvdWdoIDgwJSBvZiB0aGUgcGxhdGZvcm1zIG1heSBmb2xsb3cgdGhlIHNhbWUgYmVo
YXZpb3IsIGJ1dCB0aGVyZQ0KYXJlIHN0aWxsIGNhc2VzIHRoYXQgYmVoYXZlIGRpZmZlcmVudGx5
LiBBbmQgc28gZmFyLCB0aGVyZSBhcmUgOA0KZGlmZmVyZW50IGJlaGF2aW9ycyBiYXNlZCBvbiBk
aWZmZXJlbnQgbW9kZWxzLg0KDQpJbiB0aGlzIGNhc2UsIGNhbiB3ZSBoYXZlIHNldmVyYWwgZGlm
ZmVyZW50IGZsYWdzIGZvciB0aGUgUkFQTCBmZWF0dXJlDQphbmQgbWFrZSB0aGUgUkFQTCBkcml2
ZXIgcHJvYmUgb24gZGlmZmVyZW50IFJBUEwgZmxhZ3M/IE9yIGVsc2UsIGENCm1vZGVsIGxpc3Qg
aXMgc3RpbGwgbmVlZGVkLg0KDQp0aGFua3MsDQpydWkNCg0K
