Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974A97386B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjFUOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjFUOVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:21:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B273135
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687357261; x=1718893261;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nYcyApmBIJ66ze0d06D3Vp/3AfjxcY5mz8i1PC0KGw8=;
  b=ndx1/ksjS43TLcox6106U15B4sgQWsoSMqPbMdQaCgPlFd5it0zkgySh
   44IIzOXtrZHwTGBeCvOVhEvi0kgOopaJk3tKKOtD5FkLpxzTNgsuin1Ly
   zrubnrTuKZg1qcZPIyM6/aBsyWIytJ0HHwrMHrfOJqBSeKa3hQBq/QVqq
   oWKBNGaB1O10fz3hMoL9CC3jkSDkoDdWVWAuU4casK4Zsn8WzTjjeZXhJ
   ZCTm67ovmaaHlrW9BNCtkw0DYBM4Fwv5BzJJosQ6iXS8yF2tYYCTK9oLZ
   tKRaX1vH9ytu/DQK9NyUkV7wM7kw9PZWyiMWJy36fFcyiq/i2KmXvwU7a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="339802159"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="339802159"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="708720052"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="708720052"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 21 Jun 2023 07:20:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 07:20:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 07:20:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 07:20:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G47mv3wfIBbj0awr2ErlSfeEZNkci/oOOJwW7gc24cpeYkArin5LtpIntzWmG52k2ye7ZUokxXr1PSWpouJN4k4v5TRhXAo5unSzi53Fz3DjxhU/nedoTbtHXE3P50fAMV6LGHPSDLTQWYpMwJFVSMmPVqTgjYNg8ourTXsYglvk+szrS+NQ77VhAuADciGaUtSR/IYNjTHPQeWsVAM4pYn5Gh8XWF8Dnggzi6B1I0d2ZKAfJFyYzM5JRqtv5aTLIN1Wb1x6psWAPloOgkG+dMzcVOgKDrITeMa4gLlinme0qSdq3Dre1RGx3xqKX2T70soBPmtEd2J+D8DBbcdgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYcyApmBIJ66ze0d06D3Vp/3AfjxcY5mz8i1PC0KGw8=;
 b=cMeUis5GtP55P7x40nH/kj7OiphCbZXHY9U7eLjR7ZjIp1rDN/WWqmiatKelOsPZ0X+Qg0vRUDlASHzAIGFblBXU1ZzXGDYDQtZinCTBKJcRu+ACopYegyaD/xoVJarGtXO5xDt+tDOSyZLY/vaibvH0e8B0pTifaa6Ao9xE4VA3Kdz+JlEzuxqS5rhRXWhr4P7T7K2ZrV83x7Pp8bWOs3ScDZcU92mB85VZQGJiyxYPTKG/dRH6j7d24UL6+rdZXDp9Cetir43Ju5lqiVBPirdW9tR+ur51Du/P/5PCyCgAUBlyeyi4NY71d/7rcGELxM0dqD0KfP7hOoB/Fi+hag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by MN2PR11MB4742.namprd11.prod.outlook.com (2603:10b6:208:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 14:20:54 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5dd7:db99:bf1a:4702]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5dd7:db99:bf1a:4702%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:20:54 +0000
From:   "Ma, Yu" <yu.ma@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "Deng, Pan" <pan.deng@intel.com>,
        "Li, Tianyou" <tianyou.li@intel.com>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
Thread-Topic: [PATCH] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
Thread-Index: AQHZmHGkJHNK5LCThUOCQcp+9xZgea9+JvKAgAAJdwCAAR6ZsIAJvTWw
Date:   Wed, 21 Jun 2023 14:20:54 +0000
Message-ID: <SN7PR11MB75909BC9BAF86C7A5343CEB2E15DA@SN7PR11MB7590.namprd11.prod.outlook.com>
References: <20230606124939.93561-1-yu.ma@intel.com>
 <20230606192013.viiifjcgb6enyilx@revolver>
 <20230606195406.smed5heroqbpghcx@revolver> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|MN2PR11MB4742:EE_
x-ms-office365-filtering-correlation-id: e39633b4-c21a-4d4d-6dad-08db7262b957
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZ27ILSQN5u1tr6Tu/uSuLSHBrQiGczviWElsuuhCLHoZFUOtRbf2+C4WeWQwgjI+DKl7qWRJWUE/JhcBNYmw/g7XRgP9t0BPb80mHyd77JH93ZvxC6fJBd6aoTQ+J5jmKS1w9KVAEUBugp9d0J5bGsgHfUtkzw8BgpoKPV36s0dJtX9FKwQjHZCWieELN6NOwvaSC/Rrk2RMTXgmmkBkPSZjrZcijyhx8z1RokhwAKy31xwslb/uHp85me1k/OynmVFOJ9moXFzis++jOcQAR6oFSGyvlkWVxFJmxj4hnY61qNu9D/0B8G4IaSzu0rbqEMEwUmo4zlhBmKSaSrS9tjoeIZLOhXSSwpReAXmAYY1uUGXT6FxZqN32t2vwUPOCqYe257Y5VE0fIAJHU3/XM5aJ1ExcJ5jnvcOZRHYuI/Q65kL7AmnGnfWXhcfDkm/3uXjbajQvI2goZZlmIvcmC5eTq+ICcQhidkFdti7i8B3ev5Mfcdru+s6sKXllbHuDvu+U/a4U9AmitvzvjvQhvzSY+6It/tvaBAt0FgmU2xMdKgStbH6EAClQygU1aHZJTk7xfhLPDUjp6svLbEjOfZgY9PBAzTYeg8OQEAxgAjOBFNnPaLNpzUGX/x91V0Gc5zj/KbX3EgRMuGfMhUGgThadpIn3jIWFZerr5uPmbs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(921005)(52536014)(5660300002)(38100700002)(8676002)(41300700001)(38070700005)(64756008)(66446008)(33656002)(8936002)(122000001)(66476007)(66556008)(76116006)(82960400001)(316002)(86362001)(55016003)(66946007)(966005)(9686003)(186003)(6506007)(26005)(2906002)(478600001)(7696005)(71200400001)(83380400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SCtiZlYwdFF5bmY1SisyOEhGai9PMkpxVWlReFVFeTRUcmgxQWdLMEZHVWEy?=
 =?utf-8?B?ZHQ3YjN4a2RsSkkrQjdYd3NoTGdVVXRpc1BwQ1VCYTloaVdjUU1SUUdGSmtQ?=
 =?utf-8?B?bVo4VVVQM0xrTEpDV0xkWHpudHZDVWpSYmxVSldMZ0Jha1RpNjZBRS9kNmc0?=
 =?utf-8?B?UkU0cFA5M0xMN2ZZZUlFb1B6ODQzQUFNaHB5WlozaytEcU03YTlSc3hCbFd1?=
 =?utf-8?B?Qkcxa09GSUJwZDFTYlFxNTE2ZWZ0WE5weVRmUWhFQmxiSzdacVpEWXRVeEt4?=
 =?utf-8?B?eTEvcFdPWWJPQld5OTQ3akNKTlVJb3VSdVVsdTlZaUNZeGRvOXFVVVpqRVFJ?=
 =?utf-8?B?WGxEMEpadXJUU0Nwa3F4dE5GK0V4QmJBVTM1MFpZdm01U3VjeW5uU0tBOU1n?=
 =?utf-8?B?YVdLdE1hU1JTN2RiRVltWU44TDN1UHA5dFgyYi9rL1hOekc0U3JMUW5YTS9t?=
 =?utf-8?B?cE9WNi9teFJIaUovbEZ2ckMvWW0zNHB3MXJXaWxWVkZWOFFzSCs5cUV0SVoy?=
 =?utf-8?B?ODl3TzVJZURxa2xRWk9UeE9CVHpnV3c1K3JweEVNSUhLOTdBbnIzbWlsajY0?=
 =?utf-8?B?d0VDNlJzbVQzMU85TEhuRXZrSHdxWXNvSitnc3RkR3F5d3BZcnV5MUpCUHFP?=
 =?utf-8?B?bWxrWStndHVWanRMbkQ3bWR6dVFucUs2ODhkbnNqMmUyOFNVS0lIdEdTM0dU?=
 =?utf-8?B?K2Y0U0VSZWQxaWdENVZtMml4VDNKamkwdjBIK0dxVVRXV1ZyY3pjRGwyVTZO?=
 =?utf-8?B?RGdqdlY0aGNQWUpoUWpqUUNqWE93aHpUV1pQME1sV2hyeGFOeTRtMzNBay8w?=
 =?utf-8?B?M21TYWgyN3JkVStDYVFtSEN1a1ViNFBTSnFGN1BLc012SUhua3pxRnltZm1x?=
 =?utf-8?B?THNEc3JWbEZjUC84WHRiL013OXRScHNKOCtwdHJwTHpZZlVWa3dMQy82alpi?=
 =?utf-8?B?V1orQ2RvanVqS21IVGZlUkw5WWsvOHR4azV4OGZGSWluMldNNU1lN2N6TTlK?=
 =?utf-8?B?QkFldjBySE1pMmdpOFc5eUlQUFdNUnErNkNoa2hmTUNZTVE4anFJRCtRZ2Jy?=
 =?utf-8?B?SUVkalFSS3F4SUJTTTBYMWNsNCthcFJka3VHWCtQVjZRSjJlbDJORmRmWm0r?=
 =?utf-8?B?dE0wYWlPWGF6Q2Fac1M2YTl5c2dnWDlzdmplMm1VME5WdTdtbnR0cmI2Q2tx?=
 =?utf-8?B?K3dqbHNOajdNb29NL1hzZjNZRGlHS1FheTFiMFZURzNDK0RjTnJJdkZzalZj?=
 =?utf-8?B?WHJ1dzR4dkRoR2I3UFJ4bFVDQmtYTkx1MHlrWDZpM2VyL1pOL1dHSE1IWkNC?=
 =?utf-8?B?d3p2MisrODhsSmpuZmtpUHpmTnpSdHU3WVdQaHZSZDlSbHJZUWlyTmJMWkNW?=
 =?utf-8?B?T0hrUmdGUjIvWC9GSHcvdithK0lCcHFUajc5dEdCSGZ3OGlxd2dTcmlVckU5?=
 =?utf-8?B?clhsOHBELzZUekVSVXZNRFZEanZPY3h2bzRMaG9rZkE0S0l4WExyT1VkZXFq?=
 =?utf-8?B?ZEx2cnBONjZhTTdjTmxXR1N2VnJFVzhQUUwwRkVqQmxuNU5kQlA4Q0w2M1Q0?=
 =?utf-8?B?azJMbU1kVEVEbkNocU1ienBmOWpwNTBjRzhsZEw2ZFFETGdMMDRuNXRVajF3?=
 =?utf-8?B?RklOaW8veE5wTlVxbFJqOW15R0pUVStBZ0ZBM0FjOHhNNlljZE82YWVxZnda?=
 =?utf-8?B?djRvQmZrSzUwOVN2bm9PTFpvUmU3NE5FUzJuQXM1THlvZk4vbHBuV2prNGEr?=
 =?utf-8?B?aFFVZzFyTUY0b05GTTNMWWFna1puS3dFSk1OcFowQUEyMnRuR1lhOXl4ODNS?=
 =?utf-8?B?VUpxZW9nRTZSM3BEeVMrU3NMdjNhQVJJZ1oxbTJ5dm9WOExpSHI0THVRNFlO?=
 =?utf-8?B?K20vanUvL1ozcXFGQVFOb3JWQ09kV1B4NXEwWjhYTGV3UmRRMmFpMmtlanhJ?=
 =?utf-8?B?ck1GLzlocnVHa2V6STJxb0NXbVl3ZUZRa2xzbFhGNXNTM1lmTjVFY2M4UDZq?=
 =?utf-8?B?Z3grMmcwb21IYVlMQlJrazFsNmZDTzdXZmxrV1RmTjJJbndlVUs0Ri8vMHUx?=
 =?utf-8?B?ckNaN3k5QUJLa00zNXZRWlY1N3E3OHRKa3d3ZUdQSTQwUG44dmdOZjhCVWox?=
 =?utf-8?Q?V8r0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39633b4-c21a-4d4d-6dad-08db7262b957
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 14:20:54.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RdaTj2TSInhpwi6FsFVS767rnpP3AmVJUSc/3aHILQivmQVJZarCGRXlyOjM3QZa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4742
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KyBDaHJpc3RvcGggSGVsbHdpZyBpbiBUbyBsaXN0IA0KDQpIaSBDaHJpcywgDQpTb3JyeSB0aGF0
IGl0IGlzIHByZXR0eSBsb25nIGFnbywgZG8gd2UgaGF2ZSBhbnkgaWRlYSBhYm91dCB3aHkgcHV0
IHZtYSBvcGVyYXRpb25zIHRvIG1tIHN0cnVjdCBpbiB0aGUgY3JpdGljYWwgc2VjdGlvbiBvZiBm
aWxlIG1hcHBpbmcgbG9jayAoaS5lIHZtYV9saW5rKCkgYXMgYmVsb3csIHRoZSBvcGVyYXRpb25z
IHRvIG1tIHN0cnVjdCBsaWtlIF9fdm1hX2xpbmtfbGlzdCBhbmQgX192bWFfbGlua19yYiBpcyBw
cm90ZWN0ZWQgYnkgbWFwcGluZyBsb2NrKS4gV2UnZCBsaWtlIHRvIHN0dWR5IG1vcmUgaGVyZSBp
ZiBwb3NzaWJsZSwgc2luY2VyZWx5IGFwcHJlY2lhdGUgZm9yIGFueSBoaW50IG9yIGZlZWRiYWNr
Lg0KaHR0cHM6Ly9naXRodWIuY29tL21wZS9saW51eC1mdWxsaGlzdG9yeS9jb21taXQvYmJiY2U4
ZjQxZDNkYTBhYzk2OGJhYjdhOTY3ZTEyZTJiZTFhN2ViMA0KDQoNClJlZ2FyZHMNCll1DQoNCj4g
PiAqIExpYW0gUi4gSG93bGV0dCA8TGlhbS5Ib3dsZXR0QE9yYWNsZS5jb20+IFsyMzA2MDYgMTU6
MjBdOg0KPiA+ID4gKiBZdSBNYSA8eXUubWFAaW50ZWwuY29tPiBbMjMwNjA2IDA4OjIzXToNCj4g
PiA+ID4gVW5peEJlbmNoL0V4ZWNsIHJlcHJlc2VudHMgYSBjbGFzcyBvZiB3b3JrbG9hZCB3aGVy
ZSBiYXNoIHNjcmlwdHMNCj4gPiA+ID4gYXJlIHNwYXduZWQgZnJlcXVlbnRseSB0byBkbyBzb21l
IHNob3J0IGpvYnMuIFdoZW4gcnVubmluZw0KPiA+ID4gPiBtdWx0aXBsZSBwYXJhbGxlbCB0YXNr
cywgaG90IG9zcV9sb2NrIGlzIG9ic2VydmVkIGZyb20gZG9fbW1hcCBhbmQNCj4gZXhpdF9tbWFw
Lg0KPiA+ID4gPiBCb3RoIG9mIHRoZW0gY29tZSBmcm9tIGxvYWRfZWxmX2JpbmFyeSB0aHJvdWdo
IHRoZSBjYWxsIGNoYWluDQo+ID4gPiA+ICJleGVjbC0+ZG9fZXhlY3ZlYXRfY29tbW9uLT5icHJt
X2V4ZWN2ZS0+bG9hZF9lbGZfYmluYXJ5Ii4gSW4NCj4gPiA+ID4gZG9fbW1hcCxpdCB3aWxsIGNh
bGwgbW1hcF9yZWdpb24gdG8gY3JlYXRlIHZtYSBub2RlLCBpbml0aWFsaXplIGl0DQo+ID4gPiA+
IGFuZCBpbnNlcnQgaXQgdG8gdm1hIG1haW50YWluIHN0cnVjdHVyZSBpbiBtbV9zdHJ1Y3QgYW5k
IGlfbW1hcA0KPiA+ID4gPiB0cmVlIG9mIHRoZSBtYXBwaW5nIGZpbGUsIHRoZW4gaW5jcmVhc2Ug
bWFwX2NvdW50IHRvIHJlY29yZCB0aGUNCj4gPiA+ID4gbnVtYmVyIG9mIHZtYSBub2RlcyB1c2Vk
LiBUaGUgaG90IG9zcV9sb2NrIGlzIHRvIHByb3RlY3QNCj4gPiA+ID4gb3BlcmF0aW9ucyBvbiBm
aWxl4oCZcyBpX21tYXAgdHJlZS4gRm9yIHRoZSBtbV9zdHJ1Y3QgbWVtYmVyIGNoYW5nZQ0KPiA+
ID4gPiBsaWtlIHZtYSBpbnNlcnRpb24gYW5kIG1hcF9jb3VudCB1cGRhdGUsIHRoZXkgZG8gbm90
IGFmZmVjdCBpX21tYXANCj4gPiA+ID4gdHJlZS4gTW92ZSB0aG9zZSBvcGVyYXRpb25zIG91dCBv
ZiB0aGUgbG9jaydzIGNyaXRpY2FsIHNlY3Rpb24sIHRvDQo+ID4gPiA+IHJlZHVjZSBob2xkIHRp
bWUgb24gdGhlDQo+ID4gbG9jay4NCj4gPiA+ID4NCj4gPiA+ID4gV2l0aCB0aGlzIGNoYW5nZSwg
b24gSW50ZWwgU2FwcGhpcmUgUmFwaWRzIDExMkMvMjI0VCBwbGF0Zm9ybSwNCj4gPiA+ID4gYmFz
ZWQgb24gdjYuMC1yYzYsIHRoZSAxNjAgcGFyYWxsZWwgc2NvcmUgaW1wcm92ZXMgYnkgMTIlLiBU
aGUNCj4gPiA+ID4gcGF0Y2ggaGFzIG5vIG9idmlvdXMgcGVyZm9ybWFuY2UgZ2FpbiBvbiB2Ni40
LXJjNCBkdWUgdG8NCj4gPiA+ID4gcmVncmVzc2lvbiBvZiB0aGlzIGJlbmNobWFyayBmcm9tIHRo
aXMgY29tbWl0DQo+ID4gZjFhNzk0MTI0M2MxMDJhNDRlODg0N2UzYjk0ZmY0ZmYzZWM1NmYyNQ0K
PiA+ID4gPiAobW06IGNvbnZlcnQgbW0ncyByc3Mgc3RhdHMgaW50byBwZXJjcHVfY291bnRlciku
DQo+ID4gPg0KPiA+ID4gSSBkaWRuJ3QgdGhpbmsgaXQgd2FzIHNhZmUgdG8gaW5zZXJ0IGEgVk1B
IGludG8gdGhlIFZNQSB0cmVlIHdpdGhvdXQNCj4gPiA+IGhvbGRpbmcgdGhpcyB3cml0ZSBsb2Nr
PyAgV2Ugbm93IGhhdmUgYSB3aW5kb3cgb2YgdGltZSB3aGVyZSBhIGZpbGUNCj4gPiA+IG1hcHBp
bmcgZG9lc24ndCBleGlzdCBmb3IgYSB2bWEgdGhhdCdzIGluIHRoZSB0cmVlPyAgSXMgdGhpcyBh
bHdheXMNCj4gPiA+IHNhZmU/ICBEb2VzIHRoZSBsb2NraW5nIG9yZGVyIGluIG1tL3JtYXAuYyBu
ZWVkIHRvIGNoYW5nZT8NCj4gPg0KPiA+IFNvIEknbSBwcmV0dHkgc3VyZSBpdCdzIG5vdCBzYWZl
IGJlY2F1c2Ugd2UndmUgYmVlbiBlbnN1cmluZyB0aGF0IHRoaXMNCj4gPiBsb2NrIHdhcyB0YWtl
biBkdXJpbmcgdm1hIHRyZWUgaW5zZXJ0cyBzaW5jZSAyMDAyIFsxXS4gIFRha2UgYSBsb29rIGF0
DQo+ID4gdm1hX2xpbmsoKSBpbiB0aGF0IGNvbW1pdC4gIEkgc3RpbGwgZG9uJ3QgaGF2ZSBhbiBh
bnN3ZXIgYXMgdG8gd2h5DQo+ID4gaXQncyBub3Qgc2FmZSB0aG91Z2guDQo+ID4NCj4gPiBbMV0g
aHR0cHM6Ly9naXRodWIuY29tL21wZS9saW51eC0NCj4gPiBmdWxsaGlzdG9yeS9jb21taXQvYmJi
Y2U4ZjQxZDNkYTBhYzk2OGJhYjdhOTY3ZTEyZTJiZTFhN2ViMA0KPiA+DQo+IA0KPiBUaGFua3Mg
TGlhbSBmb3IgeW91ciBxdWljayByZXZpZXcgYW5kIGRpZ2dpbmcgaW4gcmVsYXRlZCBjb2RlLiBJ
IGp1c3QgY2hlY2tlZA0KPiB2bWFfbGluaygpIGluIDIwMDIsIHRoZSBmaWxlIGxvY2sgaXMgdGhl
cmUgdG8gcHJvdGVjdCBfX3ZtYV9saW5rKCksIGFuZCBpbg0KPiBfX3ZtYV9saW5rKCksIHRoZXJl
IGFyZSAzIGZ1bmN0aW9ucywgdGhlIGZpcnN0IDIgYXJlIG9wZXJhdGlvbnMgdG8gaW5zZXJ0IHZt
YSB0bw0KPiBtbV9zdHJ1Y3QsIGFuZCB0aGUgbGFzdCBmdW5jIF9fdm1hX2xpbmtfZmlsZSgpIGlz
IHRvIGluc2VydCB2bWEgdG8gdGhlIGZpbGUNCj4gbWFwcGluZyB0cmVlLiBTbyB0aGlzIGZpbGUg
bG9jayBhcm91bmQgX192bWFfbGluaygpIG1ha2VzIHNlbnNlIHNpbmNlIGl0IGhhcw0KPiBvcGVy
YXRpb25zIG9mIGZpbGUgbWFwcGluZyB0cmVlIGluc2lkZS4gSXQgc3RpbGwgY2Fubm90IGV4cGxh
aW4gd2h5IHRoZQ0KPiBvcGVyYXRpb25zIHRvIG1tX3N0cnVjdCBjYW5ub3QgYmUgbW92ZWQgb3V0
Lg0KPiANCj4gPiA+DQo+ID4gPiA+UmVsYXRlZCBkaXNjdXNzaW9uIGFuZCBjb25jbHVzaW9uDQo+
ID4gPiA+IGNhbiBiZSByZWZlcnJlZCBhdCB0aGUgbWFpbCB0aHJlYWQgaW5pdGlhdGVkIGJ5IDBk
YXkgYXMgYmVsb3c6DQo+ID4gPiA+IExpbms6DQo+ID4gPiA+aHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtbW0vYTRhYTJlMTMtNzE4Ny02MDBiLWM2MjgtDQo+ID4gN2U4ZmIxMDhkZWYwDQo+
ID4gPiA+QGludGVsLmNvbS8NCj4gPiA+DQo+ID4gPiBJIGRvbid0IHNlZSBhIGNvbmNsdXNpb24g
b24gdGhhdCB0aHJlYWQgdGFsa2luZyBhYm91dCBjaGFuZ2luZyB0aGUNCj4gPiA+IGxvY2tpbmcg
b3JkZXI/DQo+IEkgbWF5IG5vdCBpbnRybyB0aGlzIGxpbmsgY2xlYXIsIGl0IGlzIGFib3V0IHdo
eSBubyBvYnZpb3VzIGltcHJvdmVtZW50DQo+IG9ic2VydmVkIG9uIGxhdGVzdCBrZXJuZWwgZm9y
IHRoZSB0aW1lIGJlaW5nIDopDQo+IA0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gUmV2aWV3ZWQt
Ynk6IFRpbSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogWXUgTWEgPHl1Lm1hQGludGVsLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBt
bS9tbWFwLmMgfCA0ICstLS0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL21tL21tYXAu
YyBiL21tL21tYXAuYyBpbmRleA0KPiA+ID4gPiAxMzY3OGVkYWEyMmMuLjBlNjk0YTA0MzNiYyAx
MDA2NDQNCj4gPiA+ID4gLS0tIGEvbW0vbW1hcC5jDQo+ID4gPiA+ICsrKyBiL21tL21tYXAuYw0K
PiA+ID4gPiBAQCAtMjcxMSwxMiArMjcxMSwxMCBAQCB1bnNpZ25lZCBsb25nIG1tYXBfcmVnaW9u
KHN0cnVjdCBmaWxlDQo+ID4gPiA+ICpmaWxlLA0KPiA+IHVuc2lnbmVkIGxvbmcgYWRkciwNCj4g
PiA+ID4gIAlpZiAodm1hX2l0ZXJfcHJlYWxsb2MoJnZtaSkpDQo+ID4gPiA+ICAJCWdvdG8gY2xv
c2VfYW5kX2ZyZWVfdm1hOw0KPiA+ID4gPg0KPiA+ID4gPiAtCWlmICh2bWEtPnZtX2ZpbGUpDQo+
ID4gPiA+IC0JCWlfbW1hcF9sb2NrX3dyaXRlKHZtYS0+dm1fZmlsZS0+Zl9tYXBwaW5nKTsNCj4g
PiA+ID4gLQ0KPiA+ID4gPiAgCXZtYV9pdGVyX3N0b3JlKCZ2bWksIHZtYSk7DQo+ID4gPiA+ICAJ
bW0tPm1hcF9jb3VudCsrOw0KPiA+ID4gPiAgCWlmICh2bWEtPnZtX2ZpbGUpIHsNCj4gPiA+ID4g
KwkJaV9tbWFwX2xvY2tfd3JpdGUodm1hLT52bV9maWxlLT5mX21hcHBpbmcpOw0KPiA+ID4gPiAg
CQlpZiAodm1hLT52bV9mbGFncyAmIFZNX1NIQVJFRCkNCj4gPiA+ID4gIAkJCW1hcHBpbmdfYWxs
b3dfd3JpdGFibGUodm1hLT52bV9maWxlLT5mX21hcHBpbmcpOw0KPiA+ID4gPg0KPiA+ID4gPiAt
LQ0KPiA+ID4gPiAyLjM5LjMNCj4gPiA+ID4NCj4gPiA+ID4NCg==
