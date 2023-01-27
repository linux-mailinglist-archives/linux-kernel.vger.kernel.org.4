Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E1567DCFB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 05:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjA0EvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 23:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0EvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 23:51:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566FF410BB;
        Thu, 26 Jan 2023 20:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674795080; x=1706331080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i3B1TlQwoY22RxIsdzAZq2RHfXBpF06atJhH9QriW1w=;
  b=hEE8BKiT5a4kBtQn7/AoPPRxmnKVOI5rL8hRALDs7G0dHceQ94jT7zOm
   kj7sBBi1Av8OBnXxTELOsANaPKjpLcHcYG3xu0rBfpVMFTKAkDuLL/ysH
   5ip6JW9eguePCjIJPYNWce70ys62i9ICLMhvgcWeYmJco+rQHrMSzCEGh
   8/1xEQ87utfEHSAFXIiUBD9Ftj0/553OwNTfVvGmGFrGsOCFtb/4pdmGw
   ePPL/R1/NGriFJCRB2Jhxqf1eh67Sh2oTS/3aeP+IGBfgIroj/Sig4LEf
   X3hUpVxeG1+Y+Rm2y60lRgz782v/Gd+k1JoLjIMlE4wYlAlJF/cNAt3GB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="310642607"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="310642607"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 20:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="695404939"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="695404939"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2023 20:51:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 20:51:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 20:51:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 20:51:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dexWKbOFD06V4aGl8C6JtU6kWNPO20OkIgLp6D5yZXzQiUl8w8NVQh+IyrGAeVaDO6rb2GMKRvovshbHcSg3I+iMBuGhH211SbKub9NlzXTafbC/9RdTbKV3tVMvLbd/j04cxxxg9a8PWGMwVr8D1uw8mHQP8Kcj9yBZvnMCTtBHbod+F+OE6hyi3DgxAoANGqPleiXRZsF74EsO+tAv4+MDG03tktVnPDEPzMMmOA6pMeTlxOe77tTepDE4vr2Dmk15hXAPh6Q4TF13XouvucQxQ2upBnEdI6QmXNZXVJyU+7TLR1hBQRBWmTbnpNVu3x8NUdQICtvrHs45FBgpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3B1TlQwoY22RxIsdzAZq2RHfXBpF06atJhH9QriW1w=;
 b=h4klyICzJeScqhPqdnTRtmluTyJU1LSULLneA4naYZsS/IAqD4bvGl3TqzfnrCCZujse0VMQN6Rk6DA4MHGSNlquHzfzNCQBgikqNbcWNkD42VhLCorWW1uiu+9FIbCz9UHdHWhE4R9AS+3uBGKeaQM6gd2hjvDfMDQohwXOpxJ5LzK0Hwc44bWI4X8yKuwZev2dm0YNHwgteYNHHr7Bk7QFtFO2SooUq7hTukUMHd8DSm8USPnd7/3mbJYMLUJE7Te8tDhHNyrCKHIuzTQDa3DVpSIAEgmgiBY38NH9rGY9mrpoB613tHu61CpDK6nybn0FLy0AQ5B5rPd4KNz69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Fri, 27 Jan
 2023 04:51:03 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%8]) with mapi id 15.20.5986.018; Fri, 27 Jan 2023
 04:51:03 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 2/7] x86/resctrl: Remove hard code of RDT_RESOURCE_L3 in
 monitor.c
Thread-Topic: [PATCH 2/7] x86/resctrl: Remove hard code of RDT_RESOURCE_L3 in
 monitor.c
Thread-Index: AQHZMbXnJ2URBPpPukyWP0KzYPyC066xBEkA
Date:   Fri, 27 Jan 2023 04:51:03 +0000
Message-ID: <IA1PR11MB609747FDBC10360855AC0BC19BCC9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-3-tony.luck@intel.com>
In-Reply-To: <20230126184157.27626-3-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR11MB6097.namprd11.prod.outlook.com
 (15.20.6043.007)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|BY1PR11MB8126:EE_
x-ms-office365-filtering-correlation-id: c9d04d3e-dcf4-487f-aefe-08db002217f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ckFG965lcFPpPrT3x2qvfmGgm2ez4iEPurJN3BDK/hR9m3YYc1kTL1EGkzBCy3nfDHUEe7EP7YyTtDKc/n5WhaKfx3+zT7iJVzlVhrChIu3/LbjaRLhqnvFm7znRmSpLL/+k6qxzZ3lsFcbpiDHr5/F4E3a1YGAGpOIr4qTlFRmcMevzn2Dr6AsZm+sHafL96x+Um+h8PHQQI/hERVAB287UfW0bN76yh6DECeNgrMmI/hATmzWTRtaAN54mDLVApDKuvR7+dr7PcOGO4RDcT7+vMYSKYdV9A5f3tB1EQr2maCvsO165mI8nm6o35eERk7udecOZdcn7l3an5UoyI49p687fVLyQiODhb24TSdKlwdfbdd5MMBsA6ZmNrcV2VE2SOgHUEsJx8XeVb3dqtj3OKWfKX3tOxV+1a00Wr5afQtPcWZbBhOOqS+siLqoRGSeDu+XOTOV0HofrUjrS+PMfK9uejm5NSQXh1QWNJCpawWazl17FC6QhkGBBRNNGBvuUDhHXqxu5JB9ojM9hg/YWn3LuxLJKFKYw0Pb4+LjLDBeTfdPBW2+RGZxyKWVqnNnuKSqXSTlc8jy1Igdpji898dviWE5dsHwK/SniP3lsPbVMRb1kQuP2B5JSKOWPA2fWHxJ0+YlcQBebyyf5T3ZCqEZWmEfaLvF9AZA1Abd05MhQRCtoAYNmVM+JqlYMv3Lms/ufcfglbZKDfbMuUiYeOZJhk9ss3gidd4muVuLJMObwK6hhDRtg2PcQQk2v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199018)(33656002)(54906003)(7696005)(8676002)(66476007)(66946007)(110136005)(316002)(86362001)(71200400001)(478600001)(66446008)(76116006)(64756008)(66556008)(7416002)(2906002)(6506007)(52536014)(41300700001)(55016003)(122000001)(5660300002)(8936002)(26005)(38070700005)(83380400001)(9686003)(82960400001)(38100700002)(186003)(53546011)(4326008)(65966003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjIwOFJCQUkrdElQNTVkRTFKVWZ2VVRzbGJSN1A4cXVtUnNNaHRjN1E5bGE1?=
 =?utf-8?B?RGdXcjYwd05RM1dDcDNEbzBzRFlzdEViKytqSDkxZ3hjc0llTTU4UG5tYktN?=
 =?utf-8?B?akpGSkFQVC9iQlgvT3pLWjUwMEhMalJLcEMzejNkbk1mTVA1RlI1TVZDOG9p?=
 =?utf-8?B?dHZVemdxZGc5Z0tPcWZIcktLYjVwckoxdE1YT0xpeklhelczOXc0aGxGeE10?=
 =?utf-8?B?bkl6RW1RZENlUlRvUFNtOTRLTnNpY0pPOThxU2dETWtwMlcrYlFocTN6QVQx?=
 =?utf-8?B?eEFIZ1B6c3ZkbHJNZFlDci9ELytpTG4xN2Z6SW45SkQrRC9VNTlLb3gzQ2RP?=
 =?utf-8?B?WWVncWpuR21XUUtpYUNNR3g1cEQzZWNROExCWnBBZVdQNVRaMERoY1NnVndF?=
 =?utf-8?B?K0QxZ2RMdjdWbGRaQStnSzJTSzRNY1lFZTVkUFJxc0ZycXVRL0drOGFTbndz?=
 =?utf-8?B?VmJ5Njd0TDlFSkFwU25Tbm1xSzAraEJ6MWJZQVNSd2NKb3NsaGpiQzJiRk5L?=
 =?utf-8?B?SEtEWHdWUWhjUmhwUGZnSk5UWFo5Y0tNWWg4aG5LRklFNGVtblhsWHk0b3pC?=
 =?utf-8?B?OUZSQmo1QUlnMVRFMWZNUDg0VUVKYlhwejdKNGU0aFVTL2x1Z0JiaWVUZ0hS?=
 =?utf-8?B?b2tDakpEd2dobEdjcmM5RHgrSkJUMTFTQUdRWGNDck5ydkFLRzl2VUphZEdO?=
 =?utf-8?B?Nmk2YVJHUThCeDZ6NnRseEhkdDYxSkFYd01wQWg2bnNnWXd6Wk9pV2xxT2lT?=
 =?utf-8?B?amQ2U0RycU1kY3lDQ2cvaERpajd3Mm1Yd04wZGVlWXJYR3gzQUdHUUYvS0Vq?=
 =?utf-8?B?VVg0U2VpZ1JoRjhlVWN1UmVhbTA2b3lJTFlhVlJITm5Ka0hUSERwZGpnM2hP?=
 =?utf-8?B?VE80RHYza3BTMWN3T3JIL1gxc0tjait5SnU1Tzl0aU1BbXdmeGZNTVJtRnNT?=
 =?utf-8?B?Y0xsWmRyeTF4eExQb0xWMmZjSmNTWkZ1WmJzb1ozUlhFMzM5YmV5Y0lWMi9D?=
 =?utf-8?B?VmZsSHJ4L1puTVpOM25qajk5Tlh4OFRWOU4xYmFMY3JSMFNZSkI3M3hJQWVn?=
 =?utf-8?B?Z0trc2kyUkNZU2FrMEJXbEg0N3I0MEwxRHZIUzRqcmQwZmJrRTl3am5wejNr?=
 =?utf-8?B?N1F2dXF4YW4yc3A0NVB1cnFNTkl1SjY1bzNGTWdkWjFpMTVzRWlyQmJCZngr?=
 =?utf-8?B?Q2d2bW1qUVVrOWtMY293dWVOdmF2ZlYvV3RWdUtKaDNRdEpKMHdrQkJUdFNz?=
 =?utf-8?B?VVJoZXU1V2owMjVJMGo2aEhFQThUdk1PL2hhcGFwcFlCaEQvd2JWOFYzK1Jp?=
 =?utf-8?B?NUV3WjlmWWI0Qms3Y2Rzd2QyeVVUa0hKdnhsVzhhZUgrUzR4NzlBYWdKSUE3?=
 =?utf-8?B?c0JZNllsSlFxY1NWWHFqdSttcG1neWVEUHhSNXMwTTk2MVlURXlOeUdJcUVj?=
 =?utf-8?B?cXQ2Qkx2L1dhTWFwOWVmNVBPdjNyWWZoQUNpbFhZcDZPZzd0dW5lOHBuZGlQ?=
 =?utf-8?B?TDcrSUQrbG54M0tCYTZadUhmL1doeDgwU0NRS2xtNTN5SW5BYUhONjA5UkRP?=
 =?utf-8?B?MFdWK1llbW1lV3pqNDNGTjBVeHNnNHBNZU54Y0NYVTZUMTM2Y3hoUE8rZ2NC?=
 =?utf-8?B?TnZScEtBOTdURXZQNVdkdDFaMDRWWENRQkNwUTVzNGJienkrN0JpQUVCdDRT?=
 =?utf-8?B?aWpTMmhDQWx6NWNvbmRQTlplS1ZZYmpsZ3VySm5kaHVqR0dhV0pDVWlIdkJW?=
 =?utf-8?B?RXJZUlUzajY2OVhHbER4OUtSM3lYbU8vY2d4dmFreWZQWjFNLzNrdVRkNXpi?=
 =?utf-8?B?UFlyY0htUjJSY1hvSjIwT3V2YVZJc1R4L2FkRk5FSmVFYlU2RkVTYlFYT2s4?=
 =?utf-8?B?NFJTQkh2NXZQKzcvOXAzbHM4UXBMWFB4TllNVHZ1RkFPS0tKRHJZWTdOU1VQ?=
 =?utf-8?B?VDZBSDBSaDgyMlhVV2dPSS9HNjhZSGE3WEs3T3hlUzROQmhia1Y0MHlHdWVV?=
 =?utf-8?B?cnNGanJDSlFRVERJNWhaald2cldkV0NaZmxGUndXZnpidmFTNXk1aDkxRjRS?=
 =?utf-8?B?Q1I2N2tEQlRNbTF2VnhNRzExT2VKSzVtT3dkTElkSjlELzVhR0puTnYyU09z?=
 =?utf-8?Q?TiIlIoWp8ctZWWedHsehsmgCT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BFF5FA8AFD98A4A860D66E9CC591ABE@intel.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d04d3e-dcf4-487f-aefe-08db002217f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 04:51:03.3872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKcLWCO/6X8amXI5q78cjGqEuWAbvPHvVMDQ0yaKWUSXwFrgmNjlSP+fWr6oSL35h6QDUx15lTCzi8VgKR0F1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRvbnksDQoNCk9uIDEvMjYvMjMgMTA6NDEsIFRvbnkgTHVjayB3cm90ZToNCj4gU2NvcGUg
b2YgbW9uaXRvcmluZyBtYXkgYmUgc2NvcGVkIGF0IEwzIGNhY2hlIGdyYW51bGFyaXR5IChsZWdh
Y3kpIG9yDQo+IGF0IHRoZSBub2RlIGxldmVsIChzeXN0ZW1zIHdpdGggU3ViIE5VTUEgQ2x1c3Rl
ciBlbmFibGVkKS4NCj4gDQo+IFNhdmUgdGhlIHN0cnVjdCByZHRfcmVzb3VyY2UgcG9pbnRlciB0
aGF0IHdhcyB1c2VkIHRvIGluaXRpYWxpemUNCj4gdGhlIG1vbml0b3Igc2VjdGlvbnMgb2YgY29k
ZSBhbmQgdXNlIHRoYXQgdmFsdWUgaW5zdGVhZCBvZiB0aGUNCj4gaGFyZC1jb2RlZCBSRFRfUkVT
T1VSQ0VfTDMuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gLS0tDQo+ICAgYXJjaC94ODYv
a2VybmVsL2NwdS9yZXNjdHJsL21vbml0b3IuYyB8IDE4ICsrKysrKysrKysrKy0tLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvbW9uaXRvci5jDQo+IGluZGV4IDc3NTM4YWJlYjcyYS4u
ZDA1YmJkNGY2YjJkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwv
bW9uaXRvci5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMN
Cj4gQEAgLTMwLDYgKzMwLDggQEAgc3RydWN0IHJtaWRfZW50cnkgew0KPiAgIAlzdHJ1Y3QgbGlz
dF9oZWFkCQlsaXN0Ow0KPiAgIH07DQo+ICAgDQo+ICtzdGF0aWMgc3RydWN0IHJkdF9yZXNvdXJj
ZSAqbW9uX3Jlc291cmNlOw0KPiArDQo+ICAgLyoqDQo+ICAgICogQHJtaWRfZnJlZV9scnUgICAg
QSBsZWFzdCByZWNlbnRseSB1c2VkIGxpc3Qgb2YgZnJlZSBSTUlEcw0KPiAgICAqICAgICBUaGVz
ZSBSTUlEcyBhcmUgZ3VhcmFudGVlZCB0byBoYXZlIGFuIG9jY3VwYW5jeSBsZXNzIHRoYW4gdGhl
DQo+IEBAIC0yNTEsNyArMjUzLDcgQEAgaW50IHJlc2N0cmxfYXJjaF9ybWlkX3JlYWQoc3RydWN0
IHJkdF9yZXNvdXJjZSAqciwgc3RydWN0IHJkdF9kb21haW4gKmQsDQo+ICAgICovDQo+ICAgdm9p
ZCBfX2NoZWNrX2xpbWJvKHN0cnVjdCByZHRfZG9tYWluICpkLCBib29sIGZvcmNlX2ZyZWUpDQo+
ICAgew0KPiAtCXN0cnVjdCByZHRfcmVzb3VyY2UgKnIgPSAmcmR0X3Jlc291cmNlc19hbGxbUkRU
X1JFU09VUkNFX0wzXS5yX3Jlc2N0cmw7DQo+ICsJc3RydWN0IHJkdF9yZXNvdXJjZSAqciA9IG1v
bl9yZXNvdXJjZTsNCj4gICAJc3RydWN0IHJtaWRfZW50cnkgKmVudHJ5Ow0KPiAgIAl1MzIgY3Jt
aWQgPSAxLCBucm1pZDsNCj4gICAJYm9vbCBybWlkX2RpcnR5Ow0KPiBAQCAtMzE2LDcgKzMxOCw3
IEBAIGludCBhbGxvY19ybWlkKHZvaWQpDQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgYWRkX3JtaWRf
dG9fbGltYm8oc3RydWN0IHJtaWRfZW50cnkgKmVudHJ5KQ0KPiAgIHsNCj4gLQlzdHJ1Y3QgcmR0
X3Jlc291cmNlICpyID0gJnJkdF9yZXNvdXJjZXNfYWxsW1JEVF9SRVNPVVJDRV9MM10ucl9yZXNj
dHJsOw0KPiArCXN0cnVjdCByZHRfcmVzb3VyY2UgKnIgPSBtb25fcmVzb3VyY2U7DQo+ICAgCXN0
cnVjdCByZHRfZG9tYWluICpkOw0KPiAgIAlpbnQgY3B1LCBlcnI7DQo+ICAgCXU2NCB2YWwgPSAw
Ow0KPiBAQCAtNjMzLDcgKzYzNSw3IEBAIHZvaWQgY3FtX2hhbmRsZV9saW1ibyhzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspDQo+ICAgDQo+ICAgCW11dGV4X2xvY2soJnJkdGdyb3VwX211dGV4KTsN
Cj4gICANCj4gLQlyID0gJnJkdF9yZXNvdXJjZXNfYWxsW1JEVF9SRVNPVVJDRV9MM10ucl9yZXNj
dHJsOw0KPiArCXIgPSBtb25fcmVzb3VyY2U7DQo+ICAgCWQgPSBjb250YWluZXJfb2Yod29yaywg
c3RydWN0IHJkdF9kb21haW4sIGNxbV9saW1iby53b3JrKTsNCj4gICANCj4gICAJX19jaGVja19s
aW1ibyhkLCBmYWxzZSk7DQo+IEBAIC02NjksNyArNjcxLDcgQEAgdm9pZCBtYm1faGFuZGxlX292
ZXJmbG93KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gICAJaWYgKCFzdGF0aWNfYnJhbmNo
X2xpa2VseSgmcmR0X21vbl9lbmFibGVfa2V5KSkNCj4gICAJCWdvdG8gb3V0X3VubG9jazsNCj4g
ICANCj4gLQlyID0gJnJkdF9yZXNvdXJjZXNfYWxsW1JEVF9SRVNPVVJDRV9MM10ucl9yZXNjdHJs
Ow0KPiArCXIgPSBtb25fcmVzb3VyY2U7DQo+ICAgCWQgPSBjb250YWluZXJfb2Yod29yaywgc3Ry
dWN0IHJkdF9kb21haW4sIG1ibV9vdmVyLndvcmspOw0KPiAgIA0KPiAgIAlsaXN0X2Zvcl9lYWNo
X2VudHJ5KHByZ3JwLCAmcmR0X2FsbF9ncm91cHMsIHJkdGdyb3VwX2xpc3QpIHsNCj4gQEAgLTc0
Nyw5ICs3NDksMTEgQEAgc3RhdGljIHN0cnVjdCBtb25fZXZ0IG1ibV9sb2NhbF9ldmVudCA9IHsN
Cj4gICAvKg0KPiAgICAqIEluaXRpYWxpemUgdGhlIGV2ZW50IGxpc3QgZm9yIHRoZSByZXNvdXJj
ZS4NCj4gICAgKg0KPiAtICogTm90ZSB0aGF0IE1CTSBldmVudHMgYXJlIGFsc28gcGFydCBvZiBS
RFRfUkVTT1VSQ0VfTDMgcmVzb3VyY2UNCj4gKyAqIE5vdGUgdGhhdCBNQk0gZXZlbnRzIGNhbiBl
aXRoZXIgYmUgcGFydCBvZiBSRFRfUkVTT1VSQ0VfTDMgcmVzb3VyY2UNCj4gICAgKiBiZWNhdXNl
IGFzIHBlciB0aGUgU0RNIHRoZSB0b3RhbCBhbmQgbG9jYWwgbWVtb3J5IGJhbmR3aWR0aA0KPiAt
ICogYXJlIGVudW1lcmF0ZWQgYXMgcGFydCBvZiBMMyBtb25pdG9yaW5nLg0KPiArICogYXJlIGVu
dW1lcmF0ZWQgYXMgcGFydCBvZiBMMyBtb25pdG9yaW5nLCBvciB0aGV5IG1heSBiZSBwZXIgTlVN
QQ0KPiArICogbm9kZSBvbiBzeXN0ZW1zIHdpdGggc3ViLU5VTUEgY2x1c3RlciBlbmFibGVkIGFu
ZCBhcmUgdGhlbiBpbiB0aGUNCj4gKyAqIFJEVF9SRVNPVVJDRV9OT0RFIHJlc291cmNlLg0KDQoi
UkRUX1JFU09VUkNFX05PREUiIGlzIG5vdCBkZWZpbmVkIHlldC4gSXQgd2lsbCBiZSBkZWZpbmVk
IGluIHBhdGNoICMzLg0KTWF5YmUgYmV0dGVyIHRvIG1vdmUgdGhpcyBjb21tZW50IGNoYW5nZSB0
byBwYXRjaCAjMyB0byBhdm9pZCBjb25mdXNpb24NCm9uIFJEVF9SRVNPVVJDRV9OT0RFLg0KDQpG
dXJ0aGVyLCB0aGUgY3VycmVudCBjb21tZW50IGNhbGxzIG91dCBNQk0gYmVjYXVzZSBNQk0gaXMg
bm90IG9idmlvdXNseQ0KcmVsYXRlZCB0byBMMy4gQnV0IHdpdGggU05DLCBJIHRoaW5rIHdlIG5l
ZWQgdG8gY2FsbCBvdXQgU05DIG5vZGUgZm9yDQphbGwgbW9uaXRvciBldmVudHMsIG5vdCBqdXN0
IE1CTS4NCg0KTWF5YmUgc29tZXRoaW5nIGxpa2UgdGhpcz8NCiAgICAvKg0KICAgICAqIEluaXRp
YWxpemUgdGhlIGV2ZW50IGxpc3QgZm9yIHRoZSByZXNvdXJjZS4NCiAgICAgKg0KICAgICAqIE1v
bml0b3IgZXZlbnRzIGNhbiBlaXRoZXIgYmUgcGFydCBvZiBSRFRfUkVTT1VSQ0VfTDMgcmVzb3Vy
Y2UsDQogICAgICogb3IgdGhleSBtYXkgYmUgcGVyIE5VTUEgbm9kZSBvbiBzeXN0ZW1zIHdpdGgg
c3ViLU5VTUEgY2x1c3Rlcg0KICAgICAqIGVuYWJsZWQgYW5kIGFyZSB0aGVuIGluIHRoZSBSRFRf
UkVTT1VSQ0VfTk9ERSByZXNvdXJjZS4NCiAgICAgKg0KICAgICAqIE5vdGUgdGhhdCBNQk0gZXZl
bnRzIGFyZSBhbHNvIHBhcnQgb2YgUkRUX1JFU09VUkNFX0wzIG9yDQogICAgICogUkRUX1JFU09V
UkNFX05PREUgcmVzb3VyY2UNCiAgICAgKiBiZWNhdXNlIGFzIHBlciB0aGUgU0RNIHRoZSB0b3Rh
bCBhbmQgbG9jYWwgbWVtb3J5IGJhbmR3aWR0aA0KICAgICAqIGFyZSBlbnVtZXJhdGVkIGFzIHBh
cnQgb2YgTDMgbW9uaXRvcmluZy4NCiAgICAgKi8NCg0KPiAgICAqLw0KPiAgIHN0YXRpYyB2b2lk
IGwzX21vbl9ldnRfaW5pdChzdHJ1Y3QgcmR0X3Jlc291cmNlICpyKQ0KPiAgIHsNCj4gQEAgLTc2
MSw2ICs3NjUsOCBAQCBzdGF0aWMgdm9pZCBsM19tb25fZXZ0X2luaXQoc3RydWN0IHJkdF9yZXNv
dXJjZSAqcikNCj4gICAJCWxpc3RfYWRkX3RhaWwoJm1ibV90b3RhbF9ldmVudC5saXN0LCAmci0+
ZXZ0X2xpc3QpOw0KPiAgIAlpZiAoaXNfbWJtX2xvY2FsX2VuYWJsZWQoKSkNCj4gICAJCWxpc3Rf
YWRkX3RhaWwoJm1ibV9sb2NhbF9ldmVudC5saXN0LCAmci0+ZXZ0X2xpc3QpOw0KPiArDQo+ICsJ
bW9uX3Jlc291cmNlID0gcjsNCj4gICB9DQo+ICAgDQo+ICAgaW50IHJkdF9nZXRfbW9uX2wzX2Nv
bmZpZyhzdHJ1Y3QgcmR0X3Jlc291cmNlICpyKQ0KDQpUaGFua3MuDQoNCi1GZW5naHVhDQo=
