Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B806CD0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjC2DoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjC2DoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:44:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C96B270D;
        Tue, 28 Mar 2023 20:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680061442; x=1711597442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7f9TGG9MbF6tRNN+721tGaVj8IDVGZiiGdMh3BxH4f0=;
  b=NwnaY7zGTRF1nVGd4Omi3tEVBloa2FVutB74cxiCodNrWEuqZmHec5IA
   wZh8Dl5TTlNbg+u+lqhNuNlmFV6MBRL906Z/64TrlU7Gr80C0PonsPQ3/
   0Bga2QR/wTjaoNvMoU/4jPQkgcUTR2EniMGwUceVDCFTkNgjlpU48S+II
   KjbA/NPSZ502D8Er/cY5krqAVxm7i+G/LcD5by5YzlUfo3+WI8SFu6gD/
   g3lW2WZNOChDJ/QgGEmvjGrwez4EWP9b162f+O6I/jvK0dEuInCFOqPSz
   ogQNBXj93nxl2t36OvZymaPt/jK4xtQJDOrLYFhVvHwU7Ns4lrW8GgxdX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="321164658"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="321164658"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 20:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="753422319"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="753422319"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 28 Mar 2023 20:44:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 20:44:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 20:44:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 20:44:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpoe2V3cliYeRRvHHA2FCW2DrA0Dnv8y2EkbPh+S4lo6w2zXGend9HP+ywaJHZ7i60ZU6FfLB65HyxN021j6EEPATivtg9T5A10fZPeQw03bOwXGc+5kaFbrY1aZ4dTU3mbj6weY43lenj9fin7HTWRpn+3G9jcLBwghYCHm41ySYcG/Y/Yib3eb4b8fevBVne+gvwmbbqEPlH9XI86NNxVeX3oHTrZe/gGe70hBrMFBlMyHPI87s7SRcOYpsrVLmiMtXYIbVP2ghgFE1X5bj2eBvGLuRP4nnB9/YQYakkjNEjSSqIeSxmbFC+4vTquts+bET0qaKC5Mb1NOsykH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f9TGG9MbF6tRNN+721tGaVj8IDVGZiiGdMh3BxH4f0=;
 b=P9gGnF5vEBoZbpRPxVuXelDl3i7Dkj+ak1lBVHAgCEjpgkCsLOYHhGDHkuT7PJNTjEuDMiz+9TC+ZLFc5Nes+z6tjZZKbmj7l+QZaI24V62nZjPrvXN/7j0VKmWjcubP3ADA8S4B/O0qnRWNgj2JYofYgMFDrWQ0IaGLkrKf6R82FGkX2+pylIEUuZDEeaifUsdkh34B/VyTOOnyLMhVC096fskQaH7L9ZwZ1ZJcyVaDkYi18a8WgJG7JfZdh2SFVqO7GB7gPHTtw2IJ3/O5UIFnphkXK0IPpA7QgfmTY0LHjzmtC08kUvlRZniMil8ky743o/chTwzIy2IEF1O9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Wed, 29 Mar
 2023 03:43:59 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 03:43:58 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "peter.ganzhorn@gmail.com" <peter.ganzhorn@gmail.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] coretemp: Fix spamming of ring buffer
Thread-Topic: [PATCH 0/4] coretemp: Fix spamming of ring buffer
Thread-Index: AQHZYbU+LMzHZcsD1EaUSEWqRoX2la8RHfUA
Date:   Wed, 29 Mar 2023 03:43:58 +0000
Message-ID: <7e821f80b7700fcf1fb26f40bde8397f0e5e6d7e.camel@intel.com>
References: <CA+3fRbFzq38sQomFM7xJt-UoeLv_ZZbQ2uaHZ+8J_5ntweJ7TA@mail.gmail.com>
In-Reply-To: <CA+3fRbFzq38sQomFM7xJt-UoeLv_ZZbQ2uaHZ+8J_5ntweJ7TA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|IA0PR11MB7910:EE_
x-ms-office365-filtering-correlation-id: e3b6d3e5-1db9-4a66-894d-08db3007d41b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rw1HxszCEthj/ElQqAfihMMIrze1T3/oByN3w/5kN85A1fhu/YdxLFL6xsBMALP4vGrdkn7oaPD5r5iWBoME/Du6bjrXG0MohSmIK3ZeRNcX0fxIvlf0WI5dkAFPssp4Mw1AxxMrHXKAbqq1XtCAwWGXIFFNqOhrT5w9NRdZ7Wi4+THU/WQxfxPinVfeQl6JlaSKInpvbQHJgSSYO20vkgQf1OrtSRmNdv9u9mHZ2bYNdEUmkkESLF6DeZcTRY20+2OBbkT5HpOwWRxuhszWfpUHGxlcHRU5vfdNa+8Qn4qMmjav4N50tsZqo1XCKKHcI9S29hvZUmRB58gizXfjCgt8TC+s9lci0nahDA5xXK28AyhsA+jzglBOZmxk+EdcJ1ck8rxhlX3SGi9TwBuydsa8dw4TPxfkSfNM/T0VvM2fdUkv9PcyKw1Nh1GSlWwR+D48jQPkuidUxpTZQPv/hfpjLd1cgjKYDza/cJROno3nFRmEaITNxyBks34SN29RDmtmaOsNXX12BEJnnt86ZYhuQhUG65UM7keN/9f+vPC1kDrjWfIVO51DubTb77H7s1ZQlXpT5t8AjDsvjwmfRB2nZn5hTGvsUfnAwlh65SaIlPXPr/U62S0UN1kFFY8I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(54906003)(2616005)(53546011)(110136005)(83380400001)(38070700005)(6486002)(38100700002)(478600001)(82960400001)(122000001)(86362001)(316002)(6512007)(6506007)(186003)(26005)(36756003)(71200400001)(5660300002)(8936002)(2906002)(8676002)(64756008)(66476007)(66946007)(66446008)(66556008)(91956017)(4326008)(41300700001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wjc5S2YrbUM4eE9tTEhOOTIraTFSRlR4akh1dWY4eDNKMWJSc3lUSkRDZWRk?=
 =?utf-8?B?Qm1xQUcrM0Y1dzVwUnlac2hKQ040b0s4ZWJsWUluUXgzRFIwekJvL3llak9x?=
 =?utf-8?B?aU9wS09JaXhDaGMyOHAxSGJ6bWJzd1ZVL1lVck92S3FSaU81cEJRM0pjK2Qr?=
 =?utf-8?B?WEpTOUhKRFNxN1o4ejVONlduMlZiaERBellubVBWbHR0dm9CajE1ZmJteStx?=
 =?utf-8?B?Z0dnN2ZQY3J2MENPL1ZxUzc1UmljbmRZUGd4UlA0aG9nNlVWZkIxSGpKOU42?=
 =?utf-8?B?M2VGZWl1TEQvc2RmS0dsdzA0M1NlSFZsdEt5ZXJGZmJ2bUhLTTYrUDAxWVln?=
 =?utf-8?B?bk1YV2EzNy9jYlRLRXlrRjlLRWZ0UU5hNFFuZUtXSk1QR29TN1JNdGt6Z0s3?=
 =?utf-8?B?ZjJlUU1jZHQxSUZ3REFiUDhFb2k2MFgxRDlPa2lxSGpMTDJTcU5tdjRUMWVy?=
 =?utf-8?B?MnFXRjJ5NmppNzE5TkN6TjZZOExhaFBybVg1UUFSV1JTTWhyR1hTbDlYdjJq?=
 =?utf-8?B?MWRLK1NJbFRPd3Y4VEpLZ0FxcTIzT1A0akNYNGF2Sm4rTXNkbnVkdkI4aGtj?=
 =?utf-8?B?bitFbmR2RVZuekx5VnM2QWZSMXU4L3kwVlNtdHh3TUp4SmZodnNHYml5TnB5?=
 =?utf-8?B?alN6ekNMdmZrbjEwbW9JL2hsYzMxU3ZjV3dRWUJJTGFEa2NhcUtWUEo1V2Mw?=
 =?utf-8?B?a3ZkOE9YVU1wdGloR21iYUg1SG1Kb1c0VkVWOGQ0Vk5BTStpVUIzK29KZEJa?=
 =?utf-8?B?WnR2NmxVUGJ2ZG10ZzZkNldnK2ZGUWhXaU5LeHI1cnEyblVKT3FKclhCZnA2?=
 =?utf-8?B?UlhaM04zU2JtM0dlbFBjRi9hNFMvZXVLVmU4NXJ0T0V1Z2luZTZ2WEl3OUNt?=
 =?utf-8?B?a0NoZktrajJHc1VraW1Jc1hCMlNldERtd0ZseXVGNzh0QVlQbndSM1BtYWlq?=
 =?utf-8?B?RVJLZWNnQ0kwMGlCb1VuS3VyaGJvRTZ2ckFVQlUxZWhTdklSS0lhc2R2OGxn?=
 =?utf-8?B?ZkhMSUtaR3FmUWJvbEpycVNaWFlKdWdhY04zbXd2TVU5UitkUzYxUG9mY0pW?=
 =?utf-8?B?OW1lU1dqeDRDQWZtRDU1U0lnMDNFeTljVm1PRWRoTVE4TTRSVndFcUNBcEV3?=
 =?utf-8?B?aGtLVDdBa2lQZmZZZEpiME1wTkdJeFphL0ZXTDAwNlU3S3ZoMjlWeFJDS1Jv?=
 =?utf-8?B?TWJtRXM3WjY3bHhOWXpZN0lhWVJmWVlsaHVxZFl2VnJ3M2NxT2ZlMHRKZEZX?=
 =?utf-8?B?VG9sZUxHRmRXQWd4Q25LWXpCR2tmYWZubW1GZTNpd3ZQL0ljRTlUTUlsV0ZP?=
 =?utf-8?B?WWhqT0N1Q25nSGcxeGNwV1JvZW9nT2QrdVB3MjRiaU9pR0x5ZTd2TE9wdGJp?=
 =?utf-8?B?WHlJZUtJVE1kdXdUWVNIbTJqeHFRbkw3dWVkSGZxa3RuS2xtS1F6YVNsbStR?=
 =?utf-8?B?U3JvNThkdzRjWitvVEZqRHRFMm5qNSttcHVScFpUWHFYZitSUE11QTAwZ1dF?=
 =?utf-8?B?djVDM3lKVnJIK0QxOStqWnNsKzExazlncUlQdTg4Y3A4M2FNTW9IZXk0cEJL?=
 =?utf-8?B?NDNLeEtLbjh3UzRsSDd3SXJLVFZzQk1VdU0rdW1zOFBSSjhZdjZMSHRUcjFN?=
 =?utf-8?B?R0lpYjZwMU9IdkQxQzhFWmQybXMwS0F2QlFZdnRyWFBLazZobXNiOUN1VWor?=
 =?utf-8?B?OHRjSTc3VXNPNHErWXkwcVl4THd6eTFxY09ZYVJEK0N1dXVDeXh5R0l2SVdj?=
 =?utf-8?B?V1BKTk1MOEMzZmpFUWZQVCticXh2Q3JzRzJRZ2xDYjdydktyeDQ0di8rbnJT?=
 =?utf-8?B?S1dLeHR2bmI3ZFUzek03bzd4dno3STNOVCtkMXJYV2JPMk9ndVQwUmdUZDR0?=
 =?utf-8?B?Q1hpRkd1amJ6cnc5Tno0RUZaNUlRYjZGbktEeXgwdGhjR2RTc2g3MUJPOHNZ?=
 =?utf-8?B?WUdITDZZUmRXeVFMRnB2Y3hPNUFnNlhYMWc0UEpFMzNnL2hHaUJhSXVNSkVM?=
 =?utf-8?B?S0NSMmR5bnFyNFlVYWp6RGpKYXNCa0lQSDY1bWc5L3puK3dUdDZiSnhJb1VF?=
 =?utf-8?B?bkFLRmtjd0xnUHBDVFd6NWtBdEpmSUphTDFWZkE4bERydGxNZVJkZitSbW02?=
 =?utf-8?B?dWMzL1M4Tld3RmFVQ2FpOVhnNGdoTTNRQzFDZlVmZlZHWEhBK0VIL0pMaWdW?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D53FE9B4E8C5640BFF5CA8B47A8B4DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b6d3e5-1db9-4a66-894d-08db3007d41b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 03:43:58.4067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyqjnU0FiTvjv6+WcL+Kfeq2/oFrvifkPGntni05eh+ik3Am7OFhoQf399dbc9shMbf3IpYKdAhTDkaF9k1LbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBldGVyLA0KDQpDQyB0aGUgbGlzdC4NCg0KT24gVHVlLCAyMDIzLTAzLTI4IGF0IDIyOjM3
ICswMjAwLCBQZXRlciBHYW56aG9ybiB3cm90ZToNCj4gRGVhciBNci4gUnVpLA0KPiBEZWFyIE1y
LiBSb2VjaywNCj4gDQo+IHBsZWFzZSBjb25zaWRlciBhY2NlcHRpbmcgdGhlIGF0dGFjaGVkIHBh
dGNoZXMgb3INCj4gbW9kaWZ5aW5nIHRoZSBjb3JldGVtcCBjb2RlIHRvIHN0b3Agc3BhbW1pbmcg
bXkgc3lzbG9nLg0KPiBJIHdvdWxkIGFwcHJlY2lhdGUgaXQgdmVyeSBtdWNoIGlmIHlvdSBjYW4g
YWNjZXB0IHRoZSBwYXRjaGVzLg0KPiANCj4gY29yZXRlbXA6IEltcHJvdmUgZHluYW1pYyBjaGFu
Z2VzIG9mIFRqTWF4DQo+IEFmdGVyIGludHJvZHVjdGlvbiBvZiBkeW5hbWljIFRqTWF4IGNoYW5n
ZXMgaW4gY29tbWl0DQo+IGMwYzY3Zjg3NjFjZWMxZmUzNmMyMWQ4NWIxYTU0MDBlYTdhYzMwY2QN
Cj4gbXkgc3lzbG9nIGdldHMgc3BhbW1lZCB3aXRoICJUak1heCBpcyAuLi4gZGVncmVlcyBDIg0K
PiBtZXNzYWdlcy4NCj4gSWYgVGpNYXggaXMgc3ViamVjdCB0byBjaGFuZ2UgYXQgYW55IHRpbWUs
IGl0IHdvbid0IGJlDQo+IHNldCBpbiB0ZGF0YSBhbnltb3JlIGFuZCByZS1yZWFkIGV2ZXJ5IHRp
bWUgZnJvbSBNU1IuDQo+IFRoaXMgY2F1c2VzIHF1aXRlIGEgbG90IG9mIGRldl9kYmcoKSBtZXNz
YWdlcyB0byBiZSBpc3N1ZWQuDQo+IA0KPiBUaGUgZm9sbG93aW5nIHBhdGNoZXMgY2hhbmdlIHRo
ZSBjb2RlIHRvIHJlYWQgVGpNYXgNCj4gZnJvbSB0aGUgTVNScyBpbnRvIHRkYXRhLT50am1heCAo
YWdhaW4pIGJ1dCBhbGxvdyBmb3IgYQ0KPiBkeW5hbWljIHVwZGF0ZSBhdCBhbnkgdGltZSBhcyB3
ZWxsLiAoUGF0Y2hlcyAxIGFuZCAyKQ0KPiBUaGlzIHdheSBhIG1lc3NhZ2Ugd2lsbCBvbmx5IGJl
IGlzc3VlZCBhZnRlciBhY3R1YWwgY2hhbmdlcy4NCj4gQWxzbyBJIHJlcGxhY2VkIHRoZSBkZXZf
ZGJnKCkgd2l0aCBkZXZfbm90aWNlIChQYXRjaCAzKSBhbmQNCj4gYWRkZWQgYSBhZGRpdGlvbmFs
IGRldl9ub3RpY2UgZm9yIHRoZSBjYXNlIHdoZXJlIFRqTWF4IGlzDQo+IHNldCBiYXNlZCBvbiBh
c3N1bXB0aW9ucy4gKFBhdGNoIDQpDQo+IA0KPiANCj4gSWYgeW91IGRvIG5vdCB3YW50IHRvIGFj
Y2VwdCBteSBwYXRjaGVzLCByZW1vdmluZyB0aGUNCj4gZGV2X2RiZygpIGluIGdldF90am1heCgp
IHdvdWxkIGJlIHRoZSBtb3N0IHNpbXBsZQ0KPiBzb2x1dGlvbiBJIGd1ZXNzLg0KPiANClBsZWFz
ZSBjaGVjayBpZiBiZWxvdyBwYXRjaCBzb2x2ZXMgeW91ciBwcm9ibGVtIG9yIG5vdC4NCg0KRnJv
bSA5MzcwZWU1MTYzYTg1ZjY1MjMwYjUyMjJmMWY0ZGVjZTU5Y2UwNzhhIE1vbiBTZXAgMTcgMDA6
MDA6MDAgMjAwMQ0KRnJvbTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KRGF0ZTog
V2VkLCAyOSBNYXIgMjAyMyAxMTozNToxOCArMDgwMA0KU3ViamVjdDogW1BBVENIXSBod21vbjog
KGNvcmV0ZW1wKSBBdm9pZCBkdXBsaWNhdGUgZGVidWcgbWVzc2FnZXMNCg0KQXZvaWQgZHVwbGlj
YXRlIGRldl9kYmcgbWVzc2FnZXMgd2hlbiB0am1heCB2YWx1ZSByZXRyaWV2ZWQgZnJvbSBNU1IN
CmRvZXMgbm90IGNoYW5nZS4NCg0KU2lnbmVkLW9mZi1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdA
aW50ZWwuY29tPg0KLS0tDQogZHJpdmVycy9od21vbi9jb3JldGVtcC5jIHwgNiArKysrKy0NCiAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMgYi9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMN
CmluZGV4IDMwZDc3ZjQ1MTkzNy4uODA5NDU2OTY3YjUwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9o
d21vbi9jb3JldGVtcC5jDQorKysgYi9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMNCkBAIC0yNjcs
NiArMjY3LDcgQEAgc3RhdGljIGludCBnZXRfdGptYXgoc3RydWN0IHRlbXBfZGF0YSAqdGRhdGEs
IHN0cnVjdCBkZXZpY2UgKmRldikNCiAJaW50IGVycjsNCiAJdTMyIGVheCwgZWR4Ow0KIAl1MzIg
dmFsOw0KKwlzdGF0aWMgdTMyIHRqbWF4Ow0KIA0KIAkvKiB1c2Ugc3RhdGljIHRqbWF4IG9uY2Ug
aXQgaXMgc2V0ICovDQogCWlmICh0ZGF0YS0+dGptYXgpDQpAQCAtMjg3LDcgKzI4OCwxMCBAQCBz
dGF0aWMgaW50IGdldF90am1heChzdHJ1Y3QgdGVtcF9kYXRhICp0ZGF0YSwgc3RydWN0IGRldmlj
ZSAqZGV2KQ0KIAkJICogd2lsbCBiZSB1c2VkDQogCQkgKi8NCiAJCWlmICh2YWwpIHsNCi0JCQlk
ZXZfZGJnKGRldiwgIlRqTWF4IGlzICVkIGRlZ3JlZXMgQ1xuIiwgdmFsKTsNCisJCQlpZiAodGpt
YXggIT0gdmFsKSB7DQorCQkJCWRldl9kYmcoZGV2LCAiVGpNYXggaXMgJWQgZGVncmVlcyBDXG4i
LCB2YWwpOw0KKwkJCQl0am1heCA9IHZhbDsNCisJCQl9DQogCQkJcmV0dXJuIHZhbCAqIDEwMDA7
DQogCQl9DQogCX0NCi0tIA0KMi4yNS4xDQoNCg==
