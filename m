Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3974665C4FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjACRXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjACRXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:23:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE503F5BF;
        Tue,  3 Jan 2023 09:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672766604; x=1704302604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JfaOnVae9koJq0eX9u9sV2tDekrlMYhTziRWCOZNMF0=;
  b=SqPI4iADiyuZVh0Z+SM3Ahh33TbEU5n57XMQw5MLk0NUL7g6P8quWvnH
   iDvLvJUo2qe0q8xZg1HWtUAQb954JFebGO+r4gOCvaUSUqWt09r7l17ed
   4NsVFl+RjNZzt1kX8WYyix4swRCl9BQB8jAX5bdobMnWUfHbPbxBtCMTn
   SFR1PeNDq/5wcDHTYJgqnWvrvOpXMBj8fhw7nVE1d8n+GHudz4Uqio3jH
   8tSWN+Ha5fD1eSs4KUIdiEQnVBPr8Tki029xNHb87Xpt9jXJo9o1AH1Yj
   2rHT8RllcwcOHs3znFpZLobfk+dUsokz1iZZIj2LI8H5mBpaO8M282gcU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="321781432"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="321781432"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 09:23:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="900250134"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="900250134"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2023 09:23:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 09:23:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 09:23:23 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 09:23:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k85Y0IBY98/YeQykSteZJ0aG185L1AsmMIr11toDLGFRukVER00DVI2E34wDaPWFCxgFN2VsE1L1AlAHWjgjbB5OpTZzZbNub3GSZK/7asdXaoIEfKgHUOb9FjhSgH+Ebn11pctg2XkuopBMJbBTZb1RByQFZlfW+wc9sW7BHKuPhbY3k8fOjrmLxYSj3wXGHa/OVSIzqvWN+RA2fhYxpxwUmrf+BepkDa5e7gSl56++w6jglPyhrw1rp9U9X3pM8N7H/oifSdSLvwFIqDaxDmiDCwW0qjuC6vHrTglQi0vKIdPSuiRp81wFCz32Sm4kpTkgClDE3dSXfyRXT/0mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfaOnVae9koJq0eX9u9sV2tDekrlMYhTziRWCOZNMF0=;
 b=Dh8gUJUnbWAZyatZPXb+5eL1g0Dsepz0omT0Js8qXODWMOkNrMYUf9jH+FpLlrpe7n8Jt6AEUrTWDvOz85DTl89Q1VjNtOxRC5g19g0pnxBxqx1jOFWSdfZulhnZ3uH84aBsH1MdpTbhW0Ntfe5eYFETNwt87JuBAAkbnZ+WlVu4AuL4wTZcr6rNj+29KV/lGoHuJid3Xb1qYgAJzpfiX1zI17rhZiNKW+iQIjVf17hYRl0y1c/rYnTiQwQPVaryf0zGn1RHW+mMIo/czcCQVcDBDxkVqoh35spuqB7FtG3/o1LNCfISWxnBZmyHdH16CPwd86ybiLaZJJ+MH+RGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 17:23:21 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 17:23:20 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH] x86/hibernate: Use fixmap for saving unmapped pages
Thread-Topic: [PATCH] x86/hibernate: Use fixmap for saving unmapped pages
Thread-Index: AQHZCECAee7h3GZRn0awYifKRUmveq5fPtOAgC3g0IA=
Date:   Tue, 3 Jan 2023 17:23:20 +0000
Message-ID: <c4c95945df72fda7b7d6f333a4aea7e19d7e684c.camel@intel.com>
References: <20221205002804.21225-1-rick.p.edgecombe@intel.com>
         <CAJZ5v0iZ8QdCMca1F+z2NJ8+a-jUkGMSNp2KRovCB-aMjHF7qg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iZ8QdCMca1F+z2NJ8+a-jUkGMSNp2KRovCB-aMjHF7qg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB6096:EE_
x-ms-office365-filtering-correlation-id: 4d613a49-6b12-4fd4-0360-08daedaf35fe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ikTNX7ORmWw/8mjX4t3vCbjMYMSonjymilWUNWvQnlIET6TBLGHRu7oyui1Xda3qs67bfwjzo+dmyIN6toMXjk2iu6HBwWk8Qy8xz8txxVSmZbLfYrV6us45WuWRRjIPKrK+aubLropnQfirKTXCtb5fPV8zoRUHnyHLkUtN/sxHgBjbG2F4B46+ljxXRENfoteEHSislRHVLda0yNUQ9YB2yxET+YU0Wj4dZzJGu0j8MF8sFvkM3pE2T6y+rkSIjAP3LEEtV/gCjwvtElgGqdKKlIVR5bh442GZU64TW08RD7Acu6Hl+F1Dr2WOYHS5oSSmGZQJr5qavaeI3Q5uBHkPv+7earpjPO3RXIr1+bJyTrUedbFE7KJOX02PCZ9NTMmoQ4W0xiDPtKzSXGUr4yy16IicVMsY1jUKHYgnRtrUraI0bigSjTeFZLyek3pbk+wh8Vx6gSlODm0k5t9LGAnjyqnpG+vBm+QPS5z30pWtSNnIHpAKYOemw7jItpULFwd9Zxui1JhG9A7YslDwbdZMHPXS++Y9fWOz9RYQXAj9auKTVZRYJwaeM45yzFoa4gyVp+VZfuD0Una8CB3Wp0vs1zjDfhY9QucNUUSHOwnG0+kIrJN+uTCHufHf2rKFEIKYl5g8vAplSU5ekQYlwmhtQzwxlw6C9BgJLWlJUGuv3EU79B/Uz67Cr6KRvow0GMUrss7VfGcsQyEYOu/6nUNIAFy3TOsCwvWMlUWRFp4Mp1No7+y/dMSmIH9laZp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(36756003)(2906002)(38070700005)(122000001)(82960400001)(8936002)(41300700001)(7416002)(4744005)(38100700002)(5660300002)(86362001)(66556008)(66476007)(76116006)(6916009)(6486002)(66946007)(71200400001)(54906003)(6506007)(478600001)(91956017)(64756008)(66446008)(316002)(6512007)(4326008)(26005)(2616005)(186003)(8676002)(22166006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnRmZS9QSnd2ZzdRSzlka1h0QnNjS3U0QnE1WE43RERmcThQMCswTTVaWjV3?=
 =?utf-8?B?dWJubFpuSkxsSDBQck1MS240RnRpQVBZZytvNGRvenVBRHYvTk9yWmJsQTVh?=
 =?utf-8?B?UjRQQWJWU252WVMwbGtWNGREL1FaeFdlK3hjLzNFbTI3Q1M3d3kySFVUMEVm?=
 =?utf-8?B?bERySkcwRnFUNjVwSWtIQVVreExuTWlBSHFFemFEakIwZTZTNmZaOUNlaytn?=
 =?utf-8?B?Q3A5VkJaa2R6Um91TlRaY0xCSTV5ekgrQitULzI4V2hyKzVxbmgwOEd4b1hh?=
 =?utf-8?B?ZCtKSU1pdkFjdDA3ekZBdjBRVGdvZHR3aGw1djVXaGVoL0orUFF2THY4TVJT?=
 =?utf-8?B?WUhkUUYwaDNsSGprUlhVUE5TM0xBdHc5MnFKdnliY0d4QzRMUmx0SzlyQ2JX?=
 =?utf-8?B?SE1RRlV0dEM2bm5naDNlWDlIa1huVmNQamx6V2tneVR1T3pFa3V3K1cxbkRZ?=
 =?utf-8?B?N3QzY01lMkYxeldJTGRydTQrYnc1c2dGdnBxZEpjSk1YSGJ0ZlhOWjFhdlI5?=
 =?utf-8?B?R21ES1RPc002T0NCa3JYTERFbGFaWVVjMlZkelFDdnRIZGJEbWMyMmJZV2Rw?=
 =?utf-8?B?RFlDUGlMbHJUaDMwa3pjK1BUMFlMSjdTOEVtYkxUTGJaNGxCSytCdjFyTWtr?=
 =?utf-8?B?QU4rczZFMWNRT052dFMvZ2JhQWZLS1laVnIvMU4wQUZVTlBkdE1YWUtOVXpX?=
 =?utf-8?B?T0x5aG5wK0hNL05nRGhCZkpmUGVSYTNVbXFVNDNhVjZNaGpWSVcrclVDb001?=
 =?utf-8?B?NE94YkhaTk83SUJuMk5JaEdaTG55d0ZoZUlIS1J4ZTgwMnJMenhoMEZzV0Jz?=
 =?utf-8?B?bDNhNU5BSnlRL1hiamR1QXR2NTcySFgzcENVZCtnNUp6N0tKZFI3WUVxcUpy?=
 =?utf-8?B?bDIybGdYQmlJOGdhNVJwWS9GaDVGZTkyN01CNmg2RTZFNjdpdDR0eVVEQk13?=
 =?utf-8?B?RXZicnRndjJtZkt5NE1WRVY5SVhQN1plT0JtciszbWJFNTJQREdoK0FoZmw5?=
 =?utf-8?B?cjdJNmJvUkNmQ3pQanYwVXJCLzZlUFMxaGRtQUxOazhWRTVCV2tkcDdCcXZE?=
 =?utf-8?B?MmMxaDNOcW1LK3VhMDNiMWxqZFF1SXpJNktIN3NWNEcxd0J3T1Z4TkJYbU5y?=
 =?utf-8?B?Rndzb3Q1L1hkNWdia2hDckFDZk1JUXZVUnlOVzh3VFZmaXlIUm1PQTlGbFlv?=
 =?utf-8?B?WFRIem93N0laTjBTSTVYeER0dFZIdjZEa1ZFcjJLKzVxUGFkaXdFaHV2UEc0?=
 =?utf-8?B?Y0hYM1U4bnNST0RhdnE5ampJZkhtRThPdllPUWl0ajEvVitlV3pMYXdzUUFY?=
 =?utf-8?B?OFJwWkVjQjcydG1lWTFRZ1dtWmFoVUwrM0hjQkdMUjZqMEwxTXdQbjNTc0w0?=
 =?utf-8?B?YnBIVUJRSXpOdlhKMXRNZ2pKRnl6aUw3NnNRZWNGbzVkL1Yxd09XRmh1VUQv?=
 =?utf-8?B?V0xBT0Q1L3dYT1JGWHVXbm9oRkFHT2psV25KUW8zek5HRElpWjhrMmxYQms3?=
 =?utf-8?B?L0tyV0FqRkhZZ2xjcW9LVEU0emhITURSc3ZqY2xUWHRuQUg1RWtIcFhLVTdj?=
 =?utf-8?B?ZWV5Q28rWUhtOWVvSDA2ZTc3NU5oSkphSFgyQVpkUEZFbGRycGxEVmZoV3JR?=
 =?utf-8?B?a2xoY212TlVVWHpla3dFMG5KN3hLZzNSb3hrdDZkVDBFcGtMclBVTXpvVUs0?=
 =?utf-8?B?WEJIc05KQjZVRGkxeS9GWllTVkZBbCtIdUhhWE9wSVVTTkFXVzBiZHpCQ01x?=
 =?utf-8?B?eG4xcUlRZWh5VWcxak03TGNKaDFnTFM4R0ZvRFk2OFZXcml6dzBDL2JRZjcz?=
 =?utf-8?B?Z1hGSktwa3dhZFZYZGtKQzVDREJ6YW9lbE9QM1hyRlFrOGVleHRzNmlVNUNl?=
 =?utf-8?B?VnJtdlpzYlhWSzRXWWp2M3pSZTJnSFpFQktDZklxcndtYURRV0NEU2h6SXZs?=
 =?utf-8?B?L1J6bjNJRzV3blQzZ0tqNVNxRzFvMWpQUlhJUndHMGs3VXE2RTJ2MVJWbWlH?=
 =?utf-8?B?UFluZ1B0WDRNeE5tYXkzdmhrTkVlQXZkeWtyTFNXbUFTM1RGdjl1eW9yYnVH?=
 =?utf-8?B?Vkxld0p0elJJTDM5SStUV0RwWVg3VXdJcWg2aEhlM2YyZGZiNFJTeVZGbHhH?=
 =?utf-8?B?ekhhalpEd2FjWnFxelhwUDZGS29FblZ5eWRpdjNURFZMeEx3R291M003ejZN?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <048044A4F1B4F84DA203543D058EC577@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d613a49-6b12-4fd4-0360-08daedaf35fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 17:23:20.6933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 046Tih4quZPt5BokTPrPlBsZDSfK2YSNP6E7ceJ5qflA+df8ZxmJPiMF68VRmlcD2yrGpEKo+08jvQWLYj927wopxuCEelW9dKupKpJVtPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEyLTA1IGF0IDEzOjQ2ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gPiANCj4gPiBIaSwNCj4gPiANCj4gPiBTaW5jZSBub25lIG9mIHRoZSBtb2R1bGUgc3Bh
Y2UgYWxsb2NhdGlvbiBvdmVyaGF1bHMgZXZlciBzZWVtIHRvIGdvDQo+ID4gc21vb3RobHkNCj4g
PiBhbmQgaXQgbWF5IGJlIGF3aGlsZSBiZWZvcmUgVk1fRkxVU0hfUkVTRVRfUEVSTVMgaW4gbm90
IG5lZWRlZCwgSQ0KPiA+IHRob3VnaHQgSQ0KPiA+IHdvdWxkIHRyeSBhbmQgZml4IHVwIHNvbWUg
b2YgaXRzIGRlZmljaWVuY2llcyBpbiB0aGUgbWVhbnRpbWUuIFRoaXMNCj4gPiBpcw0KPiA+IHBy
ZS13b3JrIGZvciB0aGF0LCBidXQgSSB0aG91Z2h0IGl0IHdhcyB1c2VmdWwgZW5vdWdoIG9uIGl0
J3Mgb3duLg0KPiA+IA0KPiA+IFRoZSB0ZXN0aW5nIHdhcyBoYWNraW5nIHVwIGhpYmVybmF0ZSB0
byBsb2FkIHNvbWUgZGF0YSB0byBhIGh1Z2UgTlANCj4gPiBtYXBwaW5nDQo+ID4gYW5kIG1ha2lu
ZyBzdXJlIHRoZSBkYXRhIHdhcyB0aGVyZSB3aGVuIGl0IGNhbWUgYmFjay4NCj4gDQo+IE9LLCBz
byBJIGRvbid0IGZlZWwgbGlrZSBpdCBpcyA2LjIgbWF0ZXJpYWwgYXQgdGhpcyBwb2ludC4NCj4g
DQo+IFBsZWFzZSByZXNlbmQgaXQgd2hlbiA2LjItcmMxIGlzIG91dCBzbyBpdCBnZXRzIHNvbWUg
bW9yZSBzaWduaWZpY2FudA0KPiBsaW51eC1uZXh0IGNvdmVyYWdlIGJlZm9yZSBnb2luZyBpbnRv
IHRoZSBtYWlubGluZS4NCj4gDQo+IFRoYW5rcyENCg0KSGksDQoNClRoaXMgc3RpbGwgYXBwbGll
cyBmaW5lIG9uIGJvdGggdGlwIGFuZCBMaW51cycgdHJlZS4gSXMgaXQgYSBnb29kIHRpbWU/DQoN
ClRoYW5rcywNCg0KUmljaw0K
