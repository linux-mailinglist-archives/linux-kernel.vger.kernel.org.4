Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE43672AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjARVvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjARVvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:51:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B75A53B37;
        Wed, 18 Jan 2023 13:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674078681; x=1705614681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LbE41aLQnBRMTuKO9Uil5D2tO1EAR1KtgXqaUALxEGA=;
  b=Z1Qw20homvQhvWOBu+qmXcKLYxqwVj7sX972nbeJj9Z7Ig1PPiM+l2B2
   UANHW3HtdkMN3iuPc7j/TqGODJPmlhNckSnabwVUJB+lWQxEVC9+J3jDu
   ljNErp4jrlZNOG63xIF3xBOXHDETnLVce3H1XMtf2/DRjhkCjnN4TBaiB
   IX14vbgpDh0/PQf8/jAiWEYdNaPSq/+wKHtGu40eeuIkFgqLt4Bf10Ahd
   E1zEus361Vy094tn6VzVP/Kb6gnbQDLKrO38hSmsQIiRQnmTN+jhUA3s2
   zQ+KUI1/LESeQJ3rWX7CrLMyLdd5FY+1Kt11VkVYb80KiYgpxG4I/XZ8q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="312986148"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="312986148"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 13:51:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="723252714"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="723252714"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jan 2023 13:51:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 13:51:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 13:51:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 13:51:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=el4PLiHouGvu2C2Ja1ggloL6G3U7kSZ+IsOvY1zD+STCV+Xrflgd1AuD2YaX3/jP17kthqbQWVS2oJACFO5jt7jYkjp75cByZvuLbHI7Vzw8Msn3qK/5KF4K28zWiAHPh9eun92VADRHhY230ZiV1GUwrzUJ99RfadRki9FNcmnHwj+QSQHW+0grVO5d/szxsHZxCushMrq223jJGkjwPRy8i95pTeIQKLgNbidK+nl90IyXZiC0rRJ4wsDTYeO+eVC0fhZy2rd5natA3zq9UH2YpIo8eWN5xMZYKGk7yJyQC2qE1ies2P5+Ii2dINe62/Ts8GlKtAVF7MPrDGAYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbE41aLQnBRMTuKO9Uil5D2tO1EAR1KtgXqaUALxEGA=;
 b=ezu6xYU8QRj1h4PO1vNg50AhLP9XKau1Xo1k3yZebCud77bBjZQWgb0Zuu7SEf9ZfydyPIjL8xOBvD0orciMl/ZKmNbyJa+jXZ7B2q1uOMVcEr2llbuz3R61CFMHlHYiaDI/c/S+1AUwnRJS/gkHds/R8cOoZ5fAmiA6BfacF3tD2hTS837AKToAzexROiUE6zupvx9YbbGOdJ51Z7UXxf+voKm2IA74/ueVPEYxYoPu1bjW85V0I96c+Xlg5AzMZGYtuZvF6esndhxGl496rWB+jm4HrjUv65PPUpi+hwL7ZKs/r8Ki3/NQ2XWKwmqASYeAeC8ysgmY7kviIljuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by SJ0PR11MB5167.namprd11.prod.outlook.com (2603:10b6:a03:2d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 21:51:17 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::52a1:e48a:a04c:ad94]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::52a1:e48a:a04c:ad94%4]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 21:51:17 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "rajat.khandelwal@linux.intel.com" <rajat.khandelwal@linux.intel.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>
CC:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
Thread-Topic: [PATCH] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
Thread-Index: AQHZJ1erbq4qCF3G4Ey9qedGAwt0Ta6kv0sA
Date:   Wed, 18 Jan 2023 21:51:17 +0000
Message-ID: <075e4cb6824b58692c1bea0081e744ddac13826f.camel@intel.com>
References: <20230113140212.3905361-1-rajat.khandelwal@linux.intel.com>
In-Reply-To: <20230113140212.3905361-1-rajat.khandelwal@linux.intel.com>
Reply-To: "Box, David E" <david.e.box@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4522:EE_|SJ0PR11MB5167:EE_
x-ms-office365-filtering-correlation-id: 13206e17-7bfb-4c86-473e-08daf99e20a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 18s2wMthDO0yHJfesQSPisMq85Pk410vlVcw8H+XEIbblJW7MpmHvxgQak7mIyz6mu0ybEJr8+6imLCveAZwpZqFKwYrzsVk+bGpb3/kS+dKaq1lG7yIVgOmsTXDdI1XWNJLN1PN2R3KX5lJB4eNFHFKsmOMMq4JOHjVQVO3e93CDF3nEDSBXZ3Q7ab+tIVYUqyCU5HrVmqdyLB493Qoc2HwNQjeea9dNL+iAqUgCcizzPF2GOb0EqoowxdQNXR7ARcPeVJO/9q3ippO4lXdmnU0eUSCUqCNHYzMHuSejxuXbC0heLfcRg9ntWFy5ULPCIHe+1+i1aOAUW0/uXuAgCen7bQIulcu6IcpP6WR8UljcItAJ6xdpdAnHS1PMcb9ZI/Kv9hnAdcbEK2SUq2FoGTphb3KlBaXQaF32m8IFLA+Bv3fQ4w1Gp8aiV1hsUVOtKhV9GCzzAZSJVuGj8yusaw3Uek0GBCqorGRUJy7+VbFk1RUGxFBZ8d/evV0NiCU3rUHli2FH96MmuvqM5Ci9pay2mTr1DHF4kzbBZiOtsEUQsfyPpHQZUu8tT25yNB9gHJiq6vZXUEwE448H5Gxxieo3aXrOBJ/ixv8qRVlV1PV7+PTryXxcmUUl5ILMJYAVKcaXyIsJdU8Hvs0BNDbWTDQMT5YEcsB3zFm1xStvB7p3sXpgiJLC2vnezXwIyqvh1Z5qddDtiGGDqYY+n3TQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(82960400001)(122000001)(38100700002)(38070700005)(66946007)(8936002)(3450700001)(66476007)(5660300002)(76116006)(2906002)(91956017)(66556008)(66446008)(64756008)(8676002)(4326008)(41300700001)(2616005)(26005)(6512007)(186003)(83380400001)(71200400001)(54906003)(110136005)(86362001)(6486002)(478600001)(36756003)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDljUEtWNW1BNFV0ekF2TTJnMUtWbnl3U3hvUVZZV0xQN0hBanhMWFNWTlpa?=
 =?utf-8?B?VTJMQzRLMEVReUZ4RDlxYTJPSFRFYXpTU1BrNWtWMUp2b3ZOdVZPRUlwZ3pR?=
 =?utf-8?B?cWpWNVVoY0xWQ0t5YXFNNHR1Y3ByRnFycGZldU9OTmdRc0FVcGJDRTZ1alAr?=
 =?utf-8?B?aGlsU0ZQbWpKTEJ2SVl3cE1Kd1Z2UVB1Z25uRUtUMXltWnVOYmh1SWsrYWxB?=
 =?utf-8?B?V012Q2tIaW9RcjhzcUdFNlhGZDlBRi9LU2YxK3FxSzJocG5rQVcvVjE0VFFr?=
 =?utf-8?B?MzV5Y0N3YWNyd2htN1kvTkRIdzVYK1pjY25YdEI1Q21CRldZc2ZkTU00NFh6?=
 =?utf-8?B?ajhZN1paWHZ0b3gzUXdjbzlFblloMVYrZ0ZxbjlVdlVieXJqK2M5SG9lM0ZZ?=
 =?utf-8?B?TDg0ejNNeFFJdHNmWkRJTG9FNk9QZ0RCV1Z6aCtMNysvR3kyN1N4RDdUZWRy?=
 =?utf-8?B?ei81RkpGTmg5V3BmYnVUOFZHWWxtRHNPeGdkbFJZN21jR3hZN2RMOVlHQzFy?=
 =?utf-8?B?YUoza3NKRWpIb214OFNZb01vUldTUkhOZDJrbjA1L3M2U2FkWEVFa2s5THMx?=
 =?utf-8?B?bkVUYTdNYkFGUWRDU1gycnIwMVVJTlgwOWJtajNiKzhiaXhFK0RLdytiNzdE?=
 =?utf-8?B?YWxQVVM0dDNFaHphb3BaUWR1aVd6a0FVNXAvdEhJSVNlV1RMbHhXUm5wVXY2?=
 =?utf-8?B?M0hHU1o0aG5XVm4xVXpWTGozRTlVZllFUS92bVIzMFg4SzI1VzdsMFYrVzQ5?=
 =?utf-8?B?RDJuVzhLT1pqZjQ0M3QzOE9seGoxSXc1NFRCalVGUUdGOGtFTWRxOG5Wb1Zl?=
 =?utf-8?B?RlRzNzZBRXdIRGRvdDI5Q0MxaEdUYnU3SzY5WmgzV3JsU1RlNCt0RkgvM1ds?=
 =?utf-8?B?U2dxQkFzQS8rZkNoakltQVowR0JZWlVQVXluTndxcGUzRGl3THg0TU40NWFW?=
 =?utf-8?B?ZkJTL0FaNW56cXF0djl3MGhXT1Y4N1I2ek9ONis1YnhVSlI3YkxoVEtpNWQv?=
 =?utf-8?B?Q1R3UHR6Zm1EWVIxZ3JHR1FCMDNUaTJQQktCc1ZlMFJJbEJrY3A5ajFYdjlv?=
 =?utf-8?B?cVc5a09yb0wvek1ycWhhcEdiaVp2Mng5OGQrYlQ0N2JqbXRhYk92RkttdE5h?=
 =?utf-8?B?YjZkdFZjekxmVFdYYzhjMjY1c0d5YmN1dWFsM3A4ZVltYVNzamZUWmVzNXhn?=
 =?utf-8?B?RVF2eGhsTVIzWTRNSDZlQ3UxRGdEUzVDV1lpK2RicFdEYUpIZVhTYXJGN1pz?=
 =?utf-8?B?M2NhYTZnb1FWQnZrajVMVkNrV2FFNGhOOWZlUlRqYVZ0cmN2TlBqSmJTSlpR?=
 =?utf-8?B?dkJibFhQRTk0eXJFOUtzRGcxTG9wWGc4QjVlYXU1TnRqbnRTUFFEajZHKzZs?=
 =?utf-8?B?b1dYWlVhU1ZhSkc2Q3NXV21JZWwzc2ZqdVNYckRwZi9pSXhxWVpnYVN2M1Ur?=
 =?utf-8?B?dVhwd2Z1aTk4UFpoZy90SUhHRTY5dUVFSnkvNDQrNXNKSXdHVnJEQ3NlK04w?=
 =?utf-8?B?eHhUU2ZIWVVuRTJpbC9rbzZQeWdWY3NZb2ViOHdYR2NobDdtdzExQ1NXMmFJ?=
 =?utf-8?B?M1VNa1pwamNNU3hlNzMxM2tvVVFQOFVEY21Fc2tHc1g0RERMSmdvRVg4LzBr?=
 =?utf-8?B?MkZ1Z2F2YkZUb0lobjdGaGdtcVNaM1NoWW56MWFNUHVTMmlJVlNVc3pNQjcv?=
 =?utf-8?B?dEliWlYrdXpkMjBvWG81U24wa1NBakd0N1oyUmNqNnZWaitJUW9pbVpPSGg2?=
 =?utf-8?B?eGpkUCtWUU5LcVNWeVQ1OHUxYzhMZitpaGM1dE9PWHc4eFN4VDlib0FsWEdn?=
 =?utf-8?B?SEtRcEd6MFU0TGxHRkVSSTBCOFZpQnM5ZGxORkpYWVFRclFmbkE1OTV3NEV0?=
 =?utf-8?B?c1E5UGZKVEdCU25xbUZ3ZDEwTjlrL003MjE1RXBNNHMxYVNwRFRqK3ZoL3FO?=
 =?utf-8?B?VC85dytuMjVWcFczeVhYTGRjeHNvLzZtdVpiaEYwRW9jWk1wOFh0UVVubmNH?=
 =?utf-8?B?RTBFbzRGRkZDS0R5TDJkNEhCMk5FdUc1SzllRXcvRVdRbnZydklKMmtKM0FU?=
 =?utf-8?B?djBXazlDRS9TeFpERXBvWVljdkJ0QXkyemgybTMwVlJ1NlQ3Rmw3Z3c1K1g2?=
 =?utf-8?B?NkxMR0FpYnlvTlYrVWVZTHVFSkM4Q3RCL0hzS2dRS0NaL0ZuQzdWaThjWUoy?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85F10D5C4553EB44A56BF9522C1CF0C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13206e17-7bfb-4c86-473e-08daf99e20a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 21:51:17.3376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggRb9ZJqiUtIK5qjpB3+VS8wammbxqSXqE1opnG0BTIMudiEkxURsTtnHVLhOX+rmYYvXgY0yeBoEFvOCb/9pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5167
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

SGksCgpPbiBGcmksIDIwMjMtMDEtMTMgYXQgMTk6MzIgKzA1MzAsIFJhamF0IEtoYW5kZWx3YWwg
d3JvdGU6Cj4gQ3VycmVudGx5LCAnbHRyX2lnbm9yZScgc3lzZnMgYXR0cmlidXRlLCB3aGVuIHJl
YWQsIHJldHVybnMgbm90aGluZywgZXZlbgo+IGlmIHRoZXJlIGFyZSBjb21wb25lbnRzIHdob3Nl
IExUUiB2YWx1ZXMgaGF2ZSBiZWVuIGlnbm9yZWQuCj4gCj4gVGhpcyBwYXRjaCBhZGRzIHRoZSBm
ZWF0dXJlIHRvIHByaW50IG91dCBzdWNoIGNvbXBvbmVudHMsIGlmIHRoZXkgZXhpc3QuCj4gCj4g
U2lnbmVkLW9mZi1ieTogUmFqYXQgS2hhbmRlbHdhbCA8cmFqYXQua2hhbmRlbHdhbEBsaW51eC5p
bnRlbC5jb20+Cj4gLS0tCj4gwqBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5j
IHwgNDcgKysrKysrKysrKysrKysrKysrKystLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMzUg
aW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMKPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2lu
dGVsL3BtYy9jb3JlLmMKPiBpbmRleCBhMWZlMWUwZGNmNGEuLjMwZmZmNDQ2MTgwNyAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5jCj4gKysrIGIvZHJp
dmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuYwo+IEBAIC0xMjksNiArMTI5LDE0IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgcG1jX2JpdF9tYXAgKmV4dF9zcHRfcGZlYXJfbWFwW10gPSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoE5VTEwKPiDCoH07Cj4gwqAKPiArc3RydWN0IGx0cl9lbnRyeSB7
Cj4gK8KgwqDCoMKgwqDCoMKgdTMyIGNvbXBfaW5kZXg7Cj4gK8KgwqDCoMKgwqDCoMKgY29uc3Qg
Y2hhciAqY29tcF9uYW1lOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBsaXN0X2hlYWQgbm9kZTsK
PiArfTsKPiArCj4gK3N0YXRpYyBMSVNUX0hFQUQobHRyX2lnbm9yZV9saXN0KTsKPiArCj4gwqBz
dGF0aWMgY29uc3Qgc3RydWN0IHBtY19iaXRfbWFwIHNwdF9sdHJfc2hvd19tYXBbXSA9IHsKPiDC
oMKgwqDCoMKgwqDCoMKgeyJTT1VUSFBPUlRfQSIswqDCoMKgwqDCoMKgwqDCoMKgU1BUX1BNQ19M
VFJfU1BBfSwKPiDCoMKgwqDCoMKgwqDCoMKgeyJTT1VUSFBPUlRfQiIswqDCoMKgwqDCoMKgwqDC
oMKgU1BUX1BNQ19MVFJfU1BCfSwKPiBAQCAtMTMyNywyNyArMTMzNSwxOCBAQCBzdGF0aWMgaW50
IHBtY19jb3JlX3BsbF9zaG93KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZAo+ICp1bnVzZWQpCj4g
wqB9Cj4gwqBERUZJTkVfU0hPV19BVFRSSUJVVEUocG1jX2NvcmVfcGxsKTsKPiDCoAo+IC1zdGF0
aWMgaW50IHBtY19jb3JlX3NlbmRfbHRyX2lnbm9yZShzdHJ1Y3QgcG1jX2RldiAqcG1jZGV2LCB1
MzIgdmFsdWUpCj4gK3N0YXRpYyB2b2lkIHBtY19jb3JlX3NlbmRfbHRyX2lnbm9yZShzdHJ1Y3Qg
cG1jX2RldiAqcG1jZGV2LCB1MzIgdmFsdWUpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0
IHN0cnVjdCBwbWNfcmVnX21hcCAqbWFwID0gcG1jZGV2LT5tYXA7Cj4gwqDCoMKgwqDCoMKgwqDC
oHUzMiByZWc7Cj4gLcKgwqDCoMKgwqDCoMKgaW50IGVyciA9IDA7Cj4gwqAKPiDCoMKgwqDCoMKg
wqDCoMKgbXV0ZXhfbG9jaygmcG1jZGV2LT5sb2NrKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGlm
ICh2YWx1ZSA+IG1hcC0+bHRyX2lnbm9yZV9tYXgpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZXJyID0gLUVJTlZBTDsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byBvdXRfdW5sb2NrOwo+IC3CoMKgwqDCoMKgwqDCoH0KPiAtCj4gwqDCoMKgwqDCoMKgwqDC
oHJlZyA9IHBtY19jb3JlX3JlZ19yZWFkKHBtY2RldiwgbWFwLT5sdHJfaWdub3JlX29mZnNldCk7
Cj4gwqDCoMKgwqDCoMKgwqDCoHJlZyB8PSBCSVQodmFsdWUpOwo+IMKgwqDCoMKgwqDCoMKgwqBw
bWNfY29yZV9yZWdfd3JpdGUocG1jZGV2LCBtYXAtPmx0cl9pZ25vcmVfb2Zmc2V0LCByZWcpOwo+
IMKgCj4gLW91dF91bmxvY2s6Cj4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9jaygmcG1jZGV2
LT5sb2NrKTsKPiAtCj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIGVycjsKPiDCoH0KPiDCoAo+IMKg
c3RhdGljIHNzaXplX3QgcG1jX2NvcmVfbHRyX2lnbm9yZV93cml0ZShzdHJ1Y3QgZmlsZSAqZmls
ZSwKPiBAQCAtMTM1Niw2ICsxMzU1LDggQEAgc3RhdGljIHNzaXplX3QgcG1jX2NvcmVfbHRyX2ln
bm9yZV93cml0ZShzdHJ1Y3QgZmlsZQo+ICpmaWxlLAo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBz
dHJ1Y3Qgc2VxX2ZpbGUgKnMgPSBmaWxlLT5wcml2YXRlX2RhdGE7Cj4gwqDCoMKgwqDCoMKgwqDC
oHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYgPSBzLT5wcml2YXRlOwo+ICvCoMKgwqDCoMKgwqDCoGNv
bnN0IHN0cnVjdCBwbWNfcmVnX21hcCAqbWFwID0gcG1jZGV2LT5tYXA7Cj4gK8KgwqDCoMKgwqDC
oMKgc3RydWN0IGx0cl9lbnRyeSAqZW50cnk7Cj4gwqDCoMKgwqDCoMKgwqDCoHUzMiBidWZfc2l6
ZSwgdmFsdWU7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBlcnI7Cj4gwqAKPiBAQCAtMTM2NSwxMyAr
MTM2NiwzNSBAQCBzdGF0aWMgc3NpemVfdCBwbWNfY29yZV9sdHJfaWdub3JlX3dyaXRlKHN0cnVj
dCBmaWxlCj4gKmZpbGUsCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChlcnIpCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZXJyOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgZXJy
ID0gcG1jX2NvcmVfc2VuZF9sdHJfaWdub3JlKHBtY2RldiwgdmFsdWUpOwo+ICvCoMKgwqDCoMKg
wqDCoGlmICh2YWx1ZSA+IG1hcC0+bHRyX2lnbm9yZV9tYXgpCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJu
IGVyciA9PSAwID8gY291bnQgOiBlcnI7Cj4gK8KgwqDCoMKgwqDCoMKgbGlzdF9mb3JfZWFjaF9l
bnRyeShlbnRyeSwgJmx0cl9pZ25vcmVfbGlzdCwgbm9kZSkgewo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAoZW50cnktPmNvbXBfaW5kZXggPT0gdmFsdWUpCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVFWElTVDsKPiAr
wqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGVudHJ5ID0ga21hbGxvYyhzaXpl
b2YoKmVudHJ5KSwgR0ZQX0tFUk5FTCk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFlbnRyeSkKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9NRU07CgpDdXJyZW50bHkg
d2lsbCBsZWFrIG1lbW9yeSB3aGVuIHRoZSBkcml2ZXIgaXMgcmVtb3ZlZC4gc3RydWN0IHBtY19k
ZXYgaGFzIGEKcG9pbnRlciB0byB0aGUgcGxhdGZvcm0gZGV2aWNlIHNvIHlvdSBjYW4gdXNlIGRl
dm1fa21hbGxvYy4KCj4gKwo+ICvCoMKgwqDCoMKgwqDCoGVudHJ5LT5jb21wX25hbWUgPSBtYXAt
Pmx0cl9zaG93X3N0c1t2YWx1ZV0ubmFtZTsKPiArwqDCoMKgwqDCoMKgwqBlbnRyeS0+Y29tcF9p
bmRleCA9IHZhbHVlOwo+ICvCoMKgwqDCoMKgwqDCoGxpc3RfYWRkX3RhaWwoJmVudHJ5LT5ub2Rl
LCAmbHRyX2lnbm9yZV9saXN0KTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcG1jX2NvcmVfc2VuZF9s
dHJfaWdub3JlKHBtY2RldiwgdmFsdWUpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gY291
bnQ7Cj4gwqB9Cj4gwqAKPiDCoHN0YXRpYyBpbnQgcG1jX2NvcmVfbHRyX2lnbm9yZV9zaG93KHN0
cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqdW51c2VkKQo+IMKgewo+ICvCoMKgwqDCoMKgwqDCoHN0
cnVjdCBsdHJfZW50cnkgKmVudHJ5Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBsaXN0X2Zvcl9lYWNo
X2VudHJ5KGVudHJ5LCAmbHRyX2lnbm9yZV9saXN0LCBub2RlKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHNlcV9wcmludGYocywgIiVzXG4iLCBlbnRyeS0+Y29tcF9uYW1lKTsK
PiArwqDCoMKgwqDCoMKgwqB9CgpJdCB3b3VsZCBiZSBoZWxwZnVsIHRvIGFkZCBhIGZpcnN0IGNv
bHVtbiB0aGF0IHNob3dzIHRoZSBpbmRleC4gQnV0IEkgZ3Vlc3Mgd2UKZG9uJ3Qgc2hvdyB0aGlz
IGluIGx0cl9zaG93IGVpdGhlci4KCkRhdmlkCgo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IDA7Cj4gwqB9Cj4gwqAK
