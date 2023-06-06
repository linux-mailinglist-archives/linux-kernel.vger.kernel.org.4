Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6772427C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbjFFMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbjFFMlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:41:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9557310F4;
        Tue,  6 Jun 2023 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686055302; x=1717591302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/1ZSURowbgcbkbl8FSi2a+syA/bi0SXkBN0Pd3d+COo=;
  b=AeVqgG5wLI7rpJm4kD2U7Eh0fbJ0AGcFl5bnU+BjOqENaxPWTMD7dtGA
   v1u0FpGHwwKOQEdgCy3bT9kSbWQT6Lf90cQdaw9Z1TpnEsc9Tx4lCBhSW
   Zer6F6oBVS9iJV7DhIoMulwy58MnoAM5zamcEPkIwLgZIOIjFUZzvwESR
   c+2XRGufRsRlx+F7ZkVBEBuxC7ggt5GGxQVqAID6K0bR85uM0YLLloyBx
   342QHznw9tuVNqk7f3JsWDdj1Fcjjggfd3eDjcI/5lRL67Ni+RA9yafHM
   cDcFsPctkKPkovSae08VsMQMbP6I2/tQR9UCqAtWxyXUwUESw1kbhCfN0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422482492"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="422482492"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 05:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="1039162091"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="1039162091"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jun 2023 05:41:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 05:41:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 05:41:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 05:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj0Fuzh9uKPsCJ/Tks60VR3QbHaKjjjwmET+3eGi4i45qQ5IjcRMdlAb4ze+KQXRNX0JbgU6E4qCYqJIDZb7AVRRp7WLcG95gsXeNyPoAi/GRdOd37s1n4GrlWXHNpkXjchgihwn0bclDATyWTVFPvcwIk/XoUH0rdOaFhTYdr0ZBbrLeJ7BGB8vLaB9K5+q+KZpOVx8wzH5sy8sPZBUQ37dhyTA8RH0KcMh2maRHsI67xorSUV0fe4MkFV2Zp6e9acg82alrz/lAlaxe5qhJUDdvb1oZ/QgxAWhzh5CIhGjUDkLsypwSr6EEa8IT1SPwkRknNSTTs5rZUDZv5r28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1ZSURowbgcbkbl8FSi2a+syA/bi0SXkBN0Pd3d+COo=;
 b=mFynZX6vHKT0h1pXrfTr055C2r4LLUVd0GGjfkHmCk3FR2fZTEaHO//nFTExc3ZNpcj0A1DRUacmJTDhZJf4hOS2+1zA6Y+gRxxB9Mjb4PrsPopGnw0qH3/Nx0QC/bWZanbgEvf5pn0gLnc/8c0J5zIQjopBK5YtpSSi/2n9AiQRUx/zUJEur73yp/M69l519FgUk5M52y46rqplujcrXo5KxUZx6Y/uqJ140FPwz5qOTNPTYxCUtMsz4EVfNx+odw52cHFPA6SsftquOHTsUMqty2qqXqGiESDKaVM95zWRelY0tjV0M7wWatLf0WmndpI56aA/BGWGnGG4Qdu/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by DS0PR11MB8183.namprd11.prod.outlook.com (2603:10b6:8:161::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 12:41:39 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8%7]) with mapi id 15.20.6455.027; Tue, 6 Jun 2023
 12:41:38 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "arnd@kernel.org" <arnd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>
Subject: Re: [PATCH] powercap: intel_rapl: fix CONFIG_IOSF_MBI dependency
Thread-Topic: [PATCH] powercap: intel_rapl: fix CONFIG_IOSF_MBI dependency
Thread-Index: AQHZlNCnXNSy8gBN2Ua0NqR8ur6evq93J/qAgAASsYCAAIGxAIAGAngA
Date:   Tue, 6 Jun 2023 12:41:38 +0000
Message-ID: <349dc09fb6875d5f16870ccbeb56e6fbc48af79b.camel@intel.com>
References: <20230601213246.3271412-1-arnd@kernel.org>
         <ee67348af01d729a959563f5cb2ecab7534f2e53.camel@intel.com>
         <0d627109-483d-42c2-86c7-337c2d38fadb@app.fastmail.com>
         <CAJZ5v0iP+cmcoigiGwv58Hf8_3iM-+_5KZbAqiZyjqZxfBQR6A@mail.gmail.com>
In-Reply-To: <CAJZ5v0iP+cmcoigiGwv58Hf8_3iM-+_5KZbAqiZyjqZxfBQR6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|DS0PR11MB8183:EE_
x-ms-office365-filtering-correlation-id: 469b0bea-e80e-442b-b706-08db668b5f5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QHFPuxtoa2VfdIH2wQKdXdixRmchqmInmode+nf5pxthjINcVlHjJsvG/mPcXIuFAYRVuCXPreLx3LExpWv3t1WcjatqX2H9Uk9LXyrNOstw9rLgb1WmZhZ7qCxqXxOAYxV30I0uqVtickkWnq7lmPvOXJ1vZZF5NUsX07dHguiDra1dJrE0Lhe4YcJOESlGUCMdAqv5XDJWc+G5tAQ99zsUfgohY9CGFqzKH/fAQFE6YGV7mNKE/yWQuESM8anMzugwH1PEG8UOz6Hkn59hoR3DOBlttz6lE3glHN4B4tQHw6Cyho9vY/909nF4GOJrK//FRUAOMJaMgHuwG52xp3tQXQ0baaVVg5f1u82BjFtyxvwkdKXXeRA3+nSawHesRwfgJcPh5+O6Ary5c2Z0NHgQgp6p6Gu+Ob85R18h0hqFL0WafYrKsGYQQnaFqFd337x807JLUN4MKf8Ybk7GUzOqRbGg8VF6OOFFZBqGLk8KNmBUshsWmvxooD+rGZjmdn08kykGG2uGmMEX9KrstyutrQ4HBRw7FPR5G03FSavHx7lwWkkQnp9ur/QATmNPwa0YW7/nG+MI4iByubFG+wZ3xYyUTaZau+pA6I/lEd254KSIkD2RsEkPQJFGML2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(2906002)(83380400001)(2616005)(38070700005)(86362001)(36756003)(82960400001)(38100700002)(122000001)(6486002)(41300700001)(316002)(5660300002)(8936002)(8676002)(54906003)(110136005)(478600001)(66556008)(91956017)(64756008)(66446008)(71200400001)(66946007)(76116006)(66476007)(4326008)(6512007)(53546011)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk1nbU5GRmVaKzVnQUt3SlZvallHcDBOVnNyNnM1WTJFZXhzc1E1d3VtTk82?=
 =?utf-8?B?cy8wdVFjNFp3TzlWL3Y0WUdyTUxrdFlvb0xXcS9YK0tnTFg4b2RkM1ErRWsz?=
 =?utf-8?B?OC9iV3hxRWl3WGJjVHBVNDQxQldqMXVFdTFBOW9XZkRBMjIvcC9FV0Iwei85?=
 =?utf-8?B?b2ZBQUExSkxGUlJEV3RlTTN5dk5HejcxUnNRYncrVXJ5cnJibVBuSk1pbjZq?=
 =?utf-8?B?Q29iWW0wc1laaXJ0U0dKSDE3dzNZZk02ekQ1ajJCeU1EVlYyQnRqMTRjNmt3?=
 =?utf-8?B?V3l4ZFBDSWV4MXpkVlpabHlKL1QzUzRUdGRBWGE4cUhjbm9yaGJDaDM4NnJH?=
 =?utf-8?B?RXRKSlpYNnIwOFNJVGdKV0RZK0E3QUx6NHVRMTliSW0rbHpHZlNPVW5QTk0v?=
 =?utf-8?B?cmduMWIrK2NaSXphNWVlSVFka1N0SVRVUGdWYlB0VFNSUHBaQW9FYmNwY00z?=
 =?utf-8?B?cGZSaVp3akhDQ0xJVjdPeU1oc1E4NDdCZTFNdDY3dnYxd0VsczhBcTN2b2NW?=
 =?utf-8?B?Sy9NVEZJdjl2TWk3KytxZ1dPSGtNYzY0NlZpbDlNQmNpQkErV0dHeU91OU1H?=
 =?utf-8?B?b0RDUytOa3ZDbzI4TUltRVpEWmpleVdHSmRHSFl1b3hiYVdMTmZRRnlrL2Zn?=
 =?utf-8?B?OG10eUM0U1BVMjFTbHVRVWQ0UHBvV3lPdTIxcXZTeTJ2akJ3Znc0OEZ5bnJ2?=
 =?utf-8?B?ZmRDcWEyMFVDNFU1eU9WdG9ybklRZHBvclhXVUdka2RZSG1qUWlzbkpLVHZa?=
 =?utf-8?B?Sk4rdWVYSkxHYUx1T1ZPcGFWVGphTjIrWjMxY0hoaU9McFFBVHZPZ1dhT1h6?=
 =?utf-8?B?TlBXN0hOVFN2NXl3d0dqOFhsZk1FR3ZpTFhtTHFVS291WTVQY0w5SlljYUVZ?=
 =?utf-8?B?cG9vSUdWMktxeHBXL0hmVXN1ZlBxRzBHV0JENmhwZHFOWHh5TU9xWElzSUlW?=
 =?utf-8?B?RUlTUHdUWDU4S0R3c2JzR0JVYlp6bHAzYW9oelBtL01lWE5ybURVK1FjRmVF?=
 =?utf-8?B?T0tkYjBpWjdRM1dSSXFwNVdqcHNyUkJWSlFkYnhYV2Z1dEtqVjVMYUhoOStx?=
 =?utf-8?B?S05QT096eCtJaEtvNWtsS0EzRVdublV2d3dQeEFuSHU3eFJaTlpLVStxVFBq?=
 =?utf-8?B?eUZpdVIrSDkrY1JJRU1yTXFGZnJVRXZaTDA4YkFuSjk0aEcyMmhuVElUMHlT?=
 =?utf-8?B?SGJqaDlaTTV0YUpnL3NIN1ViVytiYVNXL1cxR1B0ZkFRc1libTQ4Ris3OW5o?=
 =?utf-8?B?WUpiempKZVpuUzErdDIxdGtJSG5Hb24zZDdiOVpUZUY4ZzlnK2hPQzEybE9Q?=
 =?utf-8?B?Wk5JRzJoZ2s5dTZPS2s2N2dXZy9ianFrR1kwcER2bnh6c2prKzRwcERsbUdm?=
 =?utf-8?B?UDlqZy9QTU8rakZreFhSTE01cUFDNENDUHExZlhVMU54eEFZekNhUnZPc0Q3?=
 =?utf-8?B?eDd3VXZtUTN3dFFsdW5DVWtWT29xdW1rdGV1cHNkRkEzT3B6MDhTTGh3eE9Z?=
 =?utf-8?B?OWM4WWJ3czN4anRhVWIxS1ZLMm9IT3pteWhOSTF2cFhRT0QwRlc3Q05PRnVZ?=
 =?utf-8?B?a01wL0pkeWZGb2lYNTVuT0lXajc5dVRzVnVTWGZQU3Ziby9zcTJ0Zk9RNUw5?=
 =?utf-8?B?MC9RZXA2VmNjVVRXMnRCa0gxa2wxTXJsUWJ6ZmpDdi8vTXdSRE9VcUwrbUFa?=
 =?utf-8?B?QzhGWEJUVnpOMmpteUhUR29QNC9vcDRPM1lnZ0lqSXRoVFBFQ3ZjT3ZIc3hJ?=
 =?utf-8?B?Uy93U2hvOS9FUmwyeFdiY1JyS21VV3lCUTNsZmVxQmtkSFdZOHJrcC9MWllT?=
 =?utf-8?B?TDc0RThtLzJnekVydGJrc3V4VnVMVWxsdGQ3cE9kMURFUzkrQ1VDTDNmc2tO?=
 =?utf-8?B?NUVhSmUxMWNOYzFXQWhLaGRJOWR4dVRTTkhZRzZZN05RbnVnOExlczhGWnNG?=
 =?utf-8?B?SWRETFlha2h6ZWJ3dWNQT0FGbU5ZWFBESEE1L0NWRDd4QkdINFFtUFdtZ0FP?=
 =?utf-8?B?M0p5Mkh0eEdTSkN3NFBNdjlCTWVqQ1pEbmwwcEw4V1R0MXdJZWRXM0NodGIw?=
 =?utf-8?B?VUcrSmZwU1MvMWhHZ1JIMTVKMDVpUS96SFEvUGJZOEpqVUVsT0VwcGNrMVo3?=
 =?utf-8?B?WUllVC9IVkFVR21aejQ5LzVKazEyQXRKQ0ZGc2dEdWhFaEtkck91N3NLa3Fw?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FA8D646259C104DA124D9719F820B99@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469b0bea-e80e-442b-b706-08db668b5f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 12:41:38.8897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WnzVggRXPBsDRyukkiNjb0XbHONT2xH3nzIIHu55JkScz+HVznt8GUHmK5PHQ4j/kGmsHWIsM2r35LadKlEQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJhZmFlbCwNCg0KT24gRnJpLCAyMDIzLTA2LTAyIGF0IDE4OjU1ICswMjAwLCBSYWZhZWwg
Si4gV3lzb2NraSB3cm90ZToNCj4gT24gRnJpLCBKdW4gMiwgMjAyMyBhdCAxMToxMeKAr0FNIEFy
bmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIEZyaSwgSnVu
IDIsIDIwMjMsIGF0IDEwOjA0LCBaaGFuZywgUnVpIHdyb3RlOg0KPiA+ID4gT24gVGh1LCAyMDIz
LTA2LTAxIGF0IDIzOjMyICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiA+ID4gPiBGcm9t
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+ID4gPiANCj4gPiA+ID4gV2hlbiB0
aGUgaW50ZWxfcmFwbCBkcml2ZXIgaXMgYnVpbHQtaW4sIGJ1dCBpb3NmX21iaSBpcyBhDQo+ID4g
PiA+IGxvYWRhYmxlDQo+ID4gPiA+IG1vZHVsZSwNCj4gPiA+ID4gdGhlIGtlcm5lbCBmYWlscyB0
byBsaW5rOg0KPiA+ID4gPiANCj4gPiA+ID4geDg2XzY0LWxpbnV4LWxkOiB2bWxpbnV4Lm86IGlu
IGZ1bmN0aW9uIGBzZXRfZmxvb3JfZnJlcV9hdG9tJzoNCj4gPiA+ID4gaW50ZWxfcmFwbF9jb21t
b24uYzooLnRleHQrMHgyZGFjOWI4KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiA+ID4gPiBg
aW9zZl9tYmlfd3JpdGUnDQo+ID4gPiA+IHg4Nl82NC1saW51eC1sZDogaW50ZWxfcmFwbF9jb21t
b24uYzooLnRleHQrMHgyZGFjYTY2KToNCj4gPiA+ID4gdW5kZWZpbmVkDQo+ID4gPiA+IHJlZmVy
ZW5jZSB0byBgaW9zZl9tYmlfcmVhZCcNCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IElNTywgaXQg
aXMgdGhlIGludGVsX3JhcGxfY29tbW9uLmMgdGhhdCBjYWxscyBJT1NGIEFQSXMgd2l0aG91dA0K
PiA+ID4gc3BlY2lmeWluZyB0aGUgZGVwZW5kZW5jeS4gVGh1cyBpdCBzaG91bGQgYmUgZml4ZWQg
Ynkgc29tZXRoaW5nDQo+ID4gPiBsaWtlDQo+ID4gPiBiZWxvdywNCj4gPiA+IA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9wb3dlcmNhcC9LY29uZmlnDQo+ID4gPiArKysgYi9kcml2ZXJzL3Bvd2VyY2Fw
L0tjb25maWcNCj4gPiA+IEBAIC0xOCwxMCArMTgsMTEgQEAgaWYgUE9XRVJDQVANCj4gPiA+IMKg
IyBDbGllbnQgZHJpdmVyIGNvbmZpZ3VyYXRpb25zIGdvIGhlcmUuDQo+ID4gPiDCoGNvbmZpZyBJ
TlRFTF9SQVBMX0NPUkUNCj4gPiA+IMKgwqDCoMKgwqAgdHJpc3RhdGUNCj4gPiA+ICvCoMKgwqDC
oCBzZWxlY3QgSU9TRl9NQkkNCj4gPiA+IA0KPiA+ID4gwqBjb25maWcgSU5URUxfUkFQTA0KPiA+
ID4gwqDCoMKgwqDCoCB0cmlzdGF0ZSAiSW50ZWwgUkFQTCBTdXBwb3J0IHZpYSBNU1IgSW50ZXJm
YWNlIg0KPiA+ID4gLcKgwqDCoMKgIGRlcGVuZHMgb24gWDg2ICYmIElPU0ZfTUJJDQo+ID4gPiAr
wqDCoMKgwqAgZGVwZW5kcyBvbiBYODYNCj4gPiA+IMKgwqDCoMKgwqAgc2VsZWN0IElOVEVMX1JB
UExfQ09SRQ0KPiA+ID4gwqDCoMKgwqDCoCBoZWxwDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCBUaGlz
IGVuYWJsZXMgc3VwcG9ydCBmb3IgdGhlIEludGVsIFJ1bm5pbmcgQXZlcmFnZSBQb3dlcg0KPiA+
ID4gTGltaXQNCj4gPiANCj4gPiBJIHRoaW5rIHRoYXQgaGFzIHRoZSBsb2dpYyBzbGlnaHRseSBi
YWNrd2FyZHMgZnJvbSBhIHVzYWJpbGl0eQ0KPiA+IHBvaW50DQo+ID4gb2YgdmlldzogVGhlIHdh
eSBJIHJlYWQgdGhlIGFyY2gveDg2L0tjb25maWcgZGVzY3JpcHRpb24sIElPU0ZfTUJJDQo+ID4g
aXMgYSBmZWF0dXJlIG9mIHNwZWNpZmljIEludGVsIGhhcmR3YXJlIGltcGxlbWVudGF0aW9ucywg
d2hpY2gNCj4gPiBnZXRzIGVuYWJsZWQgd2hlbiBhbnkgb2YgdGhlc2UgU29DIHBsYXRmb3JtcyBh
cmUgZW5hYmxlZCBpbg0KPiA+IHRoZSBidWlsZCwgYW5kIHRoZSBJTlRFTF9SQVBMIGRyaXZlciBz
cGVjaWZpY2FsbHkgb25seSB3b3Jrcw0KPiA+IG9uIHRob3NlLCB3aGlsZSB0aGUgbmV3IElOVEVM
X1JBUExfVFBNSSBkcml2ZXIgd29ya3Mgb24gb3RoZXINCj4gPiBoYXJkd2FyZS4NCj4gPiANCj4g
PiBNb3JlIGdlbmVyYWxseSBzcGVha2luZywgSSB0aGluayBpdCBpcyBhIG1pc3Rha2UgZm9yIGEg
ZGV2aWNlDQo+ID4gZHJpdmVyIGluIG9uZSBzdWJzeXN0ZW0gdG8gdXNlICdzZWxlY3QnIHRvIGVu
Zm9yY2UgYSBidWlsZA0KPiA+IGRlcGVuZGVuY3kgb24gYSBkcml2ZXIgaW4gYW5vdGhlciBzdWJz
eXN0ZW0gd2hlbiB0aGUgb3RoZXINCj4gPiBzeW1ib2wgaXMgdXNlci12aXNpYmxlLg0KPiANCj4g
SU9TRl9NQkkgaXMgYWxyZWFkeSBzZWxlY3RlZCBmcm9tIG11bHRpcGxlIHBsYWNlcyBhbmQgd2hp
bGUgeW91IGNhbg0KPiBhcmd1ZSB0aGF0IHRoZXkgYXJlIGFsbCBtaXN0YWtlcywgdGhpcyBwYXJ0
aWN1bGFyIG5ldyBvbmUgd291bGQgbm90DQo+IGJlDQo+IHdvcnNlIHRoYW4gYW55IG9mIHRoZW0u
DQo+IA0KPiBJTU8gaXQgd291bGQgYmUgYmV0dGVyIGlmIElPU0ZfTUJJIHdlcmUgbm90IHVzZXIt
dmlzaWJsZSAoYW5kDQo+IGludGVyZXN0aW5nbHkgZW5vdWdoLCB3aG9ldmVyIHNlbGVjdHMgaXQg
c2hvdWxkIGFsc28gc2VsZWN0IFBDSSBvcg0KPiBkZXBlbmQgb24gaXQgLSBJJ20gbm90IHJlYWxs
eSBzdXJlIGlmIHRoYXQgZGVwZW5kZW5jeSBpcyB0YWtlbiBjYXJlDQo+IG9mDQo+IGluIGFsbCBj
YXNlcykuDQoNCkFncmVlZC4NCkV2ZW4gdGhlIHByZXZpb3VzIFJBUEwgY29kZSBkb2VzIG5vdCBz
ZWxlY3QgUENJIG9yIGRlcGVuZCBvbiBpdC4NCg0KTGV0IG1lIHJlZnJlc2ggdGhlIHBhdGNoIGFu
ZCByZXNlbmQuDQoNCnRoYW5rcywNCnJ1aQ0K
