Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FE871FB82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjFBIEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFBIEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:04:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F78198;
        Fri,  2 Jun 2023 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685693052; x=1717229052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a17iagegYF51Piso9jcL6rZk5AbbQI519YESpky/od4=;
  b=ExPMQ9NdjLgLp55pkD2zQsWyBB/ZSUfez6HISloYb4RBUWsKcuDXEPbJ
   6QOs691TggaeA3JDeDPAjIJw4W9zPDA5n/Wl9MSF4+10xhz2IhYjt7Blp
   IxtMBsbiwhOJBMO2pccMfdsPwi2oKPCv6dRntmddzzvayqXsG90kt9RlZ
   KHvs8gmMbYcnur6i9kPp+Ypa7DIsHa51/R1WaTIKlwUCYlopr/nTGv2r0
   Lypkl409vT2jrDJnLq0gsCSL7P696X3uF9BcBngk6+G72STtQmsHngmi1
   1ONWL8vny8N909VHez75kCDCw1IpKLWXC92bPO5+Y2rWhfvMCsFb8VQKw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="335423386"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="335423386"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 01:04:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="658148322"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="658148322"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2023 01:04:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 01:04:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 01:04:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 01:04:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8+/SOMYYMoET7G6ntNM+3Z4Bxdef2xfey866S4+1Wm1QGXpY31v8pWdpi7e9fTKOhhvDxAb8pWm0kUhw0yBmXI4NBfdDwjmTIfrOi/QdiZGZK9ds4uG6w1LesF0tHFY7euO3XHn8lOj43ZEs+r5SUhPzPFlLGweYx2hp+zjDSyD9ID8CmKrlugFEvA/lv7rVF9JNPxfIuL1LzMOeThVpUcEwKnEiou4avi5XdlP93nlIKI3vbG3g9k3jtSHiQEY7V0k3XsZTDVd8G/mxN2ezGHh5ycHH0KsP5E4BrlGgXmP5uQ720t0xSEwdgBmO+0lzTHI9XXJmF1D3RtxHGDDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a17iagegYF51Piso9jcL6rZk5AbbQI519YESpky/od4=;
 b=Bl0ghPdSjhIwecJfm0j77TXW8Woext34nMh/5W3urHsryP/0KSeEaYAtMGZCDn95uclWQum9hZOj8uE35LzNHaLARUvwZrzz5ZcXGAlM2NAj3ZJLKXj1oGDLAWEBO2PUUzvzXTuZn7PGlMLPOqcPS3pOi/ih22LaFj6nTin1QMRLWCeACjjdIQZHYgpqZq9WB+R9Um8JmeGCbKS/ljGhUXkN1URFrah81fE4L4j3xn0tVdCmSRZDuHanfvxavDo9fOzcCPRCAc6NbzwqJL1mdzJYNq/Z1EpUKj6OLF9sMLOkZun4BjmybgZMg6diihnpLoAd03wcgzl+mGtAenq1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 08:04:08 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8%7]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 08:04:08 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "arnd@kernel.org" <arnd@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] powercap: intel_rapl: fix CONFIG_IOSF_MBI dependency
Thread-Topic: [PATCH] powercap: intel_rapl: fix CONFIG_IOSF_MBI dependency
Thread-Index: AQHZlNCnXNSy8gBN2Ua0NqR8ur6evq93J/qA
Date:   Fri, 2 Jun 2023 08:04:08 +0000
Message-ID: <ee67348af01d729a959563f5cb2ecab7534f2e53.camel@intel.com>
References: <20230601213246.3271412-1-arnd@kernel.org>
In-Reply-To: <20230601213246.3271412-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|IA1PR11MB7917:EE_
x-ms-office365-filtering-correlation-id: facd2fbc-3f50-4871-c35b-08db633ff115
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKl2P+mB/xY4sxKbl6bP1UJymekiWXHaESMwpHGi66939w2RwqQWIaI4xQHg2OfSfzBMmA/gyPmYyvNh6sBghJQWKbVTf14wUuoXFrGN/sogLZXTXyiof8oMjHMGlVwxjunObdj4hm74TuCK2WjQm5T04wspwF1+pYkov7109dUWW5xFCJT2CydfqVODQ1cdd8Xh7ArWlHo35j4DCiI4jwCxerYYeW5uxebKx3idlNWj3feOTC5YklrWdfdbkOEHEjdahU/oPkkjcfeMwQY3XUO9mU+zPNe1nbHm0u7DERlZGBUiKuOXjMVtkFJVYqbleuN6QhNm9efv3ZvzPUOhslJGyJaxIB8l+7si50p0SPMOnUyoYKXFeHUJMd/zGBvsyh4haXdMeo/JzDVablvchKXzinRKwgYDXR/s10eI/azU3NvuD+QmusR7RiHDNG59yYUHz8E4HH0yqsisQmHbjQrhhIUhzl5GWhSPxp/mqlZYaaP5oxmv2LDqqEzRBrr1q6mLeJIKkFY7Rg0STOa9/ZjXfpPZGf9QAXAPYH9/WQFKeooEDcCPu9vBfghmHIOT7Whb2FWCwh82Fv+MKfaJTAgKpQAWmkA8MgADyACi9dyYrIxTigpdzdoKHWVz7qbS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(82960400001)(36756003)(122000001)(38100700002)(86362001)(38070700005)(71200400001)(8676002)(5660300002)(53546011)(6506007)(6512007)(26005)(41300700001)(66556008)(2906002)(186003)(2616005)(83380400001)(76116006)(6486002)(66446008)(91956017)(316002)(66946007)(54906003)(110136005)(478600001)(8936002)(66476007)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGNWMW9rODdObHo2ejNlakNZSlFIZmh6d0J3R2syUDVPR29xK1IraXhHSjlS?=
 =?utf-8?B?cXAyR2dNUW0zdUlnWWdIUUczOGJmd042eHR5bS9HTTUzd2JlcmJwdDVPWnRt?=
 =?utf-8?B?VU85YUZMbWhrNGxEdU1oaW5tU0pWM09USHlFejMyNTBBMXZKSUMwZHEzaWpZ?=
 =?utf-8?B?UGQ1R0cxdW1HTHQ2WUNjZWNzWXM0LzhpNytFY0plSkJwaThCWjZES3Y4TjQ1?=
 =?utf-8?B?R2pua24zSVV4UnVnU3VwajlYZUxKSjB2NnNPMWQ0ckdHeEp6R0t3MmcwM2x0?=
 =?utf-8?B?R0V4KzluanVPK3R2TnlDK291VHZLeUM0MnlSek5MWnJhejdseG1aUFQvNjMr?=
 =?utf-8?B?R0NmeFJnNUdzeVBGNDI4T0xNVDJ3WFVqWlZaZ25Wb3pvSmRIbVh6OXZLL3Vl?=
 =?utf-8?B?RHpFV1ZKdFdZQzVleFRFbTVUYktBZlBtWTV4MnZhZ1BsVVZKRXp4OFdTZG5V?=
 =?utf-8?B?TFp3bXIzWkxkbXk1TW5jcWk1TWUxbVBTR1FUOVAyNUxKdS9SNXVQRWhVZTMy?=
 =?utf-8?B?by9NWCszRnJ3RlptbG8wcUJidHhEVjJ0MURFWGxpZjNuQU8xZFhsMmFIZyta?=
 =?utf-8?B?bnN2YnBTMGpERVY3YW4vV2RhV0Z4MmpYZ0MwN1JpT1J0dTBtd3NrNGtuWTVR?=
 =?utf-8?B?NzlLNWhlNGRRMzRQbHhBMDdjMUNNWXR6a2VRNUtpWm0rNzV6M0VRbEdYYnFU?=
 =?utf-8?B?Y1FrRVJvL1U5VzFURTJldkN5YVorN2NFaE5rZHRwQ2ZyajN0ZmJkbHpCQzFo?=
 =?utf-8?B?OFZmR0pLUXRVYWx1VTBBY2ZXcktibDF5Um9VRmlGRUJreHgxT3dkS0svOEFy?=
 =?utf-8?B?dGpQeTFFNnVwOElpTFkxOGtOOWFQellUUnZ1aVBldVp1dUtEZ2FZTmM4ZGtK?=
 =?utf-8?B?MkFtc3FjK1lxWTN0SnUwYTErNFFHWVAzS3BJek05Ui8rUnROMmxjZE16U2x5?=
 =?utf-8?B?Q0Ixamg1RE5hSnlyVmZtZ2lLbjlhV28zUUtqYUlPWGw0RE9kOUcyN280UGh6?=
 =?utf-8?B?L3RUcVZ6ZC9lRm10QTl3NHRMRFFOZVQ4MmZ1V2VRaXZUU1orNnc5NS9sR2M1?=
 =?utf-8?B?ZFFwdnlEZ2YxRG5VZytPZnFRTDI5dDRzY053K2JhNTdqa0FoV2p4Ty9GQXdV?=
 =?utf-8?B?YnEvS2FpMFJaeEhXVVRBRi9uMjlvQTJyQ1IyNVBkVlZqdFZUcEJOZ29GaFcz?=
 =?utf-8?B?Yk1LeDNPTlZLcGdwMFB4RjdqODNUck5MOCsyU1pEeGZEeC9JSmZkUHdBOUJE?=
 =?utf-8?B?aXFhdUhkenE1eXM1WVVzWVd0WnZzd2h6YnVia0ZOTkZkSGwvclZTSXBtVUEz?=
 =?utf-8?B?RlBoSCtTemQ1STI1R3ZsQ3dIUVF4T29adW5lTkU2azNSOXl6M2thb2lOb01P?=
 =?utf-8?B?SGF2ZUxNcGZIbE45bDYzM3lCcHBHWEQvVTYyZzlocW4rS2NkMW9HWTlaNGZL?=
 =?utf-8?B?dEJzMlZxOGhvdWJOYmhCeXl0L0JxYnRNRHNhektCZ09vRWZWYmxCbGNGVEZX?=
 =?utf-8?B?c1Yvb1k1MHd1WjNmbFNna1FUM0dtNUh1VTFzWWhGZjhvVzg5R1d5NjN6NG42?=
 =?utf-8?B?QjZNMHk0Snh1VmRESjc1b0FNUUk0bHVVZzNEVDNQeHNJakR4WWJocEJjT1Qw?=
 =?utf-8?B?cjU4MjFaY3p5MGFJd3d5YXpyT0duVGJvQzB2YzdCSTNIMGFLWmFENE5YTER1?=
 =?utf-8?B?bWhhSEl1cWRJMnFCaittaFJad0kxL1llZW54bHkrZG1JNXlMWTVWMUN6bkhE?=
 =?utf-8?B?a1ZiRmtEdEcrcTlMNS9BaWluVEg2SmNnMlZIa08ydjJHR2R3Y29tSGIydWdU?=
 =?utf-8?B?UEdyWUU0akpaL3pzcngwRkR3NW9LdnFiZFVCREFvQXJiNVQ2K0hPTzFaMUlT?=
 =?utf-8?B?dm9QZjlaNnVIUzNlODhCemx4YXZNZHJPV01ac1AySGpneFpFWEp4YXJTWVAz?=
 =?utf-8?B?Ri9sR3hLUkRBZGc1UDA3eFhXTTJ4RlhwM2diTkNlRk1BY1VmSnZlWkNtWjN1?=
 =?utf-8?B?MEpuZkNFaVh5K1orbEE4RndPdHdmcTgzUHFoTm1TNUNzNk8vSFB1d2txZ3do?=
 =?utf-8?B?MzMzUTlDcEhhMm1ZZnBiR20rcVBGaUx2VGpleE8xMWZhNU9leE5sMFJ6Z2dI?=
 =?utf-8?B?bGtPd2hSK01WV2xHaGNYK3ErOExxSFRQdE5BcVFjWVR0RXd2ZXN3dDB3ZGV2?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <653F45E53CCE194F8C98392B5A8DF637@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facd2fbc-3f50-4871-c35b-08db633ff115
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 08:04:08.1563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbqfOqN/e69bh1r6yB9DRo7FsL6Z5XwkzB+0hFsrwt1K46s8YVzdbSPYG/d3n6CeNAVYq5SdHJsJvf2LuhAejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQsDQoNCk9uIFRodSwgMjAyMy0wNi0wMSBhdCAyMzozMiArMDIwMCwgQXJuZCBCZXJn
bWFubiB3cm90ZToNCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+
IFdoZW4gdGhlIGludGVsX3JhcGwgZHJpdmVyIGlzIGJ1aWx0LWluLCBidXQgaW9zZl9tYmkgaXMg
YSBsb2FkYWJsZQ0KPiBtb2R1bGUsDQo+IHRoZSBrZXJuZWwgZmFpbHMgdG8gbGluazoNCj4gDQo+
IHg4Nl82NC1saW51eC1sZDogdm1saW51eC5vOiBpbiBmdW5jdGlvbiBgc2V0X2Zsb29yX2ZyZXFf
YXRvbSc6DQo+IGludGVsX3JhcGxfY29tbW9uLmM6KC50ZXh0KzB4MmRhYzliOCk6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8NCj4gYGlvc2ZfbWJpX3dyaXRlJw0KPiB4ODZfNjQtbGludXgtbGQ6IGlu
dGVsX3JhcGxfY29tbW9uLmM6KC50ZXh0KzB4MmRhY2E2Nik6IHVuZGVmaW5lZA0KPiByZWZlcmVu
Y2UgdG8gYGlvc2ZfbWJpX3JlYWQnDQo+IA0KDQpJTU8sIGl0IGlzIHRoZSBpbnRlbF9yYXBsX2Nv
bW1vbi5jIHRoYXQgY2FsbHMgSU9TRiBBUElzIHdpdGhvdXQNCnNwZWNpZnlpbmcgdGhlIGRlcGVu
ZGVuY3kuIFRodXMgaXQgc2hvdWxkIGJlIGZpeGVkIGJ5IHNvbWV0aGluZyBsaWtlDQpiZWxvdywN
Cg0KRnJvbSAyOGRlNGM3ZDNkNGY5ZmVkNzVhN2VjZGNmNWVlYTViODllZDc3YmFiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0K
RGF0ZTogRnJpLCAyIEp1biAyMDIzIDA5OjAyOjE1ICswODAwDQpTdWJqZWN0OiBbUEFUQ0hdIHBv
d2VyY2FwL2ludGVsX3JhcGw6IEZpeCBDT05GSUdfSU9TRl9NQkkgZGVwZW5kZW5jeQ0KDQpBZnRl
ciBjb21taXQgMzM4MjM4OGQ3MTQ4ICgiaW50ZWxfcmFwbDogYWJzdHJhY3QgUkFQTCBjb21tb24g
Y29kZSIpLA0KYWNjZXNzaW5nIHRvIElPU0YgaW50ZXJmYWNlIGlzIGRvbmUgaW4gdGhlIFJBUEwg
Y29tbW9uIGNvZGUuDQoNClRodXMgaXQgaXMgdGhlIENPTkZJR19JTlRFTF9SQVBMX0NPUkUgdGhh
dCBoYXMgZGVwZW5kZW5jeSBvZg0KQ09ORklHX0lPU0ZfTUJJLCB3aGlsZSBDT05GSUdfSU5URUxf
UkFQTF9NU1IgZG9lcyBub3QuDQoNClRoaXMgcHJvYmxlbSB3YXMgbm90IGV4cG9zZWQgcHJldmlv
dXNseSBiZWNhdXNlIGFsbCB0aGUgcHJldmlvdXMgUkFQTA0KY29tbW9uIGNvZGUgdXNlcnMsIGFr
YSwgdGhlIFJBUEwgTVNSIGFuZCBNTUlPIEkvRiBkcml2ZXJzLCBoYXZlDQpDT05GSUdfSU9TRl9N
Qkkgc2VsZWN0ZWQuDQoNCkZpeCB0aGUgQ09ORklHX0lPU0ZfTUJJIGRlcGVuZGVuY3kgaW4gUkFQ
TCBjb2RlLiBUaGlzIGFsc28gZml4ZXMgYSBidWlsZA0KdGltZSBmYWlsdXJlIHdoZW4gdGhlIFJB
UEwgVFBNSSBJL0YgZHJpdmVyIGlzIGludHJvZHVjZWQgd2l0aG91dA0Kc2VsZWN0aW5nIENPTkZJ
R19JT1NGX01CSS4NCg0KeDg2XzY0LWxpbnV4LWxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGBz
ZXRfZmxvb3JfZnJlcV9hdG9tJzoNCmludGVsX3JhcGxfY29tbW9uLmM6KC50ZXh0KzB4MmRhYzli
OCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGlvc2ZfbWJpX3dyaXRlJw0KeDg2XzY0LWxpbnV4
LWxkOiBpbnRlbF9yYXBsX2NvbW1vbi5jOigudGV4dCsweDJkYWNhNjYpOiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvIGBpb3NmX21iaV9yZWFkJw0KDQpGaXhlczogMzM4MjM4OGQ3MTQ4ICgiaW50ZWxf
cmFwbDogYWJzdHJhY3QgUkFQTCBjb21tb24gY29kZSIpDQpSZXBvcnRlZC1ieTogQXJuZCBCZXJn
bWFubiA8YXJuZEBhcm5kYi5kZT4NClNpZ25lZC1vZmYtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5n
QGludGVsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcG93ZXJjYXAvS2NvbmZpZyAgICAgICAgICB8IDMg
KystDQogZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX21zci5jIHwgMSAtDQogMiBmaWxlcyBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3Bvd2VyY2FwL0tjb25maWcgYi9kcml2ZXJzL3Bvd2VyY2FwL0tjb25maWcNCmluZGV4
IGU3MTM5OTgwNGMxNC4uYWRlZmRkOGE0ZTEyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wb3dlcmNh
cC9LY29uZmlnDQorKysgYi9kcml2ZXJzL3Bvd2VyY2FwL0tjb25maWcNCkBAIC0xOCwxMCArMTgs
MTEgQEAgaWYgUE9XRVJDQVANCiAjIENsaWVudCBkcml2ZXIgY29uZmlndXJhdGlvbnMgZ28gaGVy
ZS4NCiBjb25maWcgSU5URUxfUkFQTF9DT1JFDQogCXRyaXN0YXRlDQorCXNlbGVjdCBJT1NGX01C
SQ0KIA0KIGNvbmZpZyBJTlRFTF9SQVBMDQogCXRyaXN0YXRlICJJbnRlbCBSQVBMIFN1cHBvcnQg
dmlhIE1TUiBJbnRlcmZhY2UiDQotCWRlcGVuZHMgb24gWDg2ICYmIElPU0ZfTUJJDQorCWRlcGVu
ZHMgb24gWDg2DQogCXNlbGVjdCBJTlRFTF9SQVBMX0NPUkUNCiAJaGVscA0KIAkgIFRoaXMgZW5h
YmxlcyBzdXBwb3J0IGZvciB0aGUgSW50ZWwgUnVubmluZyBBdmVyYWdlIFBvd2VyIExpbWl0IChS
QVBMKQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9tc3IuYyBiL2Ry
aXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9tc3IuYw0KaW5kZXggY2ZmNWM2ZThkNTcwLi5iNTM2
MTQ0NzI2ZjkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfbXNyLmMN
CisrKyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9tc3IuYw0KQEAgLTIyLDcgKzIyLDYg
QEANCiAjaW5jbHVkZSA8bGludXgvcHJvY2Vzc29yLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPg0KIA0KLSNpbmNsdWRlIDxhc20vaW9zZl9tYmkuaD4NCiAjaW5jbHVkZSA8
YXNtL2NwdV9kZXZpY2VfaWQuaD4NCiAjaW5jbHVkZSA8YXNtL2ludGVsLWZhbWlseS5oPg0KIA0K
LS0gDQoyLjI1LjENCg0KDQo+IFRoZSBkcml2ZXIgY2FuIHdvcmsgd2l0aCBpb3NmX21iaSBjb21w
bGV0ZWx5IGRpc2FibGVkLCBzbyBhZGQgYQ0KPiBkZXBlbmRlbmN5DQo+IHRoYXQgc3RpbGwgYWxs
b3dzIHRoaXMgY29uZmlndXJhdGlvbiwgYnV0IG90aGVyd2lzZSBmb3JjZXMgaXQgdG8gbm90DQo+
IGJlDQo+IGJ1aWx0LWluIHdoZW4gaW9zZl9tYmkgaXMgYSBsb2FkYWJsZSBtb2R1bGUuDQoNCk9u
IHRoZSBvdGhlciBzaWRlLCBJIGFncmVlIHdpdGggeW91IHRoYXQgdGhlIFRQTUkgZHJpdmVyIHNo
b3VsZCB3b3JrDQp3aXRoIGlvc2ZfbWJpIGNvbXBsZXRlbHkgZGlzYWJsZWQuDQoNCkEgY2xlYW5l
ciB3YXkgdG8gZG8gdGhpcyBpcyB0byBtb3ZlIHRoZSByYXBsX2RlZmF1bHRzIHNldHRpbmcgKGV2
ZW4gdGhlDQpyYXBsX3ByaW1pdGl2ZV9pbmZvIHNldHRpbmcpIGZyb20gaW50ZWxfcmFwbF9jb21t
b24uYyB0byB0aGUgSS9GDQpkcml2ZXJzLCBhcyB0aGlzIGlzIHJlYWxseSBpbnRlcmZhY2Ugc3Bl
Y2lmaWMuDQoNCk1heWJlIHdlIGNhbiB1c2UgdGhlIGFib3ZlIHBhdGNoIGFzIGEgcXVpY2sgZml4
LCBhbmQgcmVtb3ZlIHRoZQ0KSU9TRl9NQkkgZGVwZW5kZW5jeSBmcm9tIFJBUEwgY29tbW9uIGNv
ZGUgYXMgYSBsb25nIHRlcm0gc29sdXRpb24/DQoNCnRoYW5rcywNCnJ1aQ0K
