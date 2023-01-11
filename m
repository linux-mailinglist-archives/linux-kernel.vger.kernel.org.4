Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF776662A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjAKSSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjAKSSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:18:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F621EAC4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673461125; x=1704997125;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q9h1UxsA49Jwyg2smoaNCaa8JYQJTzeIMThwRQ4mTI8=;
  b=VFg4xQnF9WnVpCuvuJ0xJ1ztE/84jDfafqsdH+Tj9BC4R9X1eF08r1BY
   zf/GyoS9SgmBKSfXLaHRFFobJMiRC7oxC6l5m1sNa3RVAOTtaWSyYPESr
   lXcASNxOzWGgilZ8bVRd1j83LgihsIcpoHYzt9ecOediUtJbILS06LWNH
   1CDVqmmMdLIszqcNs6wCr6rW8sPrfMbgXJpcvSWsT5f6LbiUsXZFO11nm
   nURMxo3HhuNVAVkb+COFzItzdPrxWObJZLCcGwT+Aviaao9v6oo+Idgr1
   cIjHcb6glK+fbHTAqbYNiVqPRnJAdlVmh6riqEn0kYBWT3I7+VSeBJfpg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="307018391"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="307018391"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 10:18:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607470997"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607470997"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 11 Jan 2023 10:18:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 10:18:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 10:18:44 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 10:18:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LutTJ0mwmW0b4fO1xcmBkGcbJI/R/jU/KVnlfitvohGd33IsU71wEVwFSvQ7poPZgBS8rjuPMMVykX+mDVK9o3i4RACCCqq4faIZlOoX7oxMJFX2Lorm1GTBv2cpDQouAg0FRl6hd5Sj7D11eRD62H585vyjHVkWNM9H/7ST91xh9rqXHTvyQ/AAW7eFBq5Mqfuy+JAA0S9AbuJjM7Si9yHkfEHqAdWFKItjwRksBCjXN45K4Zs5gny3luuLApR5Ob57+A2GxT7rmW1mjy95Gm4DI+d/xbtkhf8O0iIJWv9FFPD4mstKb0UMeBuC/S5rmqwIbvF2oA/A7t+tEK81Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9h1UxsA49Jwyg2smoaNCaa8JYQJTzeIMThwRQ4mTI8=;
 b=mnL/IU2qqayaSxqXwmP+qEMtAvaE12oXr3J0dPz0QMTXB8bTNfmkMzTtF/JDZ48BQSaS+uMvXKgITrKU3tcwTTInP0u0IuzoOLwxm7jY6ufKrhzP/wcqBlB3Chap2+zyQQhIaqeaU4YQlVBVhdTPHx4VXk25TB91qoCbEirGkS4cLFLeth8VyQ1vyz44xLf5mlJn29P2Bf0pVPO4JMyLJMQiUhRE0OrGjyXXYwjazWISxzUF2D4RzVGAQg0+5S/lzPiff12zFvHXjyh+Nj5Nzicyp6qziPdOY/SbLfmcVnZL+qtLoHX0L6yItWKPS3tp7P5pXqQTOmKBWjpszS4BMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by BL3PR11MB6339.namprd11.prod.outlook.com (2603:10b6:208:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 18:18:38 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::52ef:33cf:9be9:fcb0]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::52ef:33cf:9be9:fcb0%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 18:18:38 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>
Subject: RE: [PATCH v5 1/5] x86/cpufeature: add the cpu feature bit for LKGS
Thread-Topic: [PATCH v5 1/5] x86/cpufeature: add the cpu feature bit for LKGS
Thread-Index: AQHZA0vkryPQw9e5lkSBztKhD4cTB66Zix+AgAA/5yA=
Date:   Wed, 11 Jan 2023 18:18:38 +0000
Message-ID: <SA1PR11MB67348C859B3390F692EB8280A8FC9@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20221128164028.4570-1-xin3.li@intel.com>
 <20221128164028.4570-2-xin3.li@intel.com> <Y77HW/vBIv2BWJ8A@zn.tnic>
In-Reply-To: <Y77HW/vBIv2BWJ8A@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|BL3PR11MB6339:EE_
x-ms-office365-filtering-correlation-id: 1b83c2d0-b257-41b3-054b-08daf40042f5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDBKDzSaI5kG80a7TrXtZ+Jrwj47vSoUwxD3TrECrlMkApj4dbUqVUG645ZKku7WyVTTklbEbRmRdLERhlE9QIL7AWkrWOFF0U0nCgol1c7B/tGRApzRltXn2ixyiJQ6nAMoyWYRyyZkqkKrQ/9EiTh0RDxbAfHILzl0HaW/j9N9uH3HFwm3MT15YyrCLGan4IT5jcVkaacYQAZmSU5ARi1C47ToIh6UW0ZtA5lk/WEkhw0iNhxpwFEqLhA8bI4zzGxH1KnK/pVDrSQ2HEiFc6nj18DjmQiN5gz1fJc6gIJ4ZKzSTMxDwjl23e9ZvlxcGBsOo0uFD64az67lHzAWB8astFHIlYJaJLklHHCemQI9XhF5ujc1x7ou8husQxzZv4CwkBo62I1DKi25nF2rWbIEW5FzisUBVwC4gfld2Xo76E6HyL4Clzf75+bv8GPkFX5N1m7VnClxUE8Ia4PlXli81ydlPDvBS16Pjl/KKfC+Cy/AYdodgYTQBh2j0kcWtk6vEtYO26eD14pmu55JWDBBCepI6yQQGnsCqR/duzPYIUGSMa8xihbsKzKEPAINp+GvN0cCoWQPfhKz5HJxV4eFFzTT/EwniKuLKAowuopfJyysV+HRATWdqm4h5Y08GZM1igGw1kU20x3n2TkBIIvuMR+0LL8FSDV3M1/5RMuF1PSc8rNSDEXS1ZxelHVgJJfPsdALyaKhBpN2aA7LFfuKCf435Ae/+Cw1y8K4cgZ+LwF4ZzWSHKo1gpV/SS6Ehs0QEXqTRSaUB29c3BHWzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199015)(86362001)(7696005)(38100700002)(71200400001)(38070700005)(478600001)(966005)(186003)(26005)(6506007)(55016003)(33656002)(9686003)(82960400001)(41300700001)(6916009)(8676002)(66556008)(66476007)(66946007)(64756008)(66446008)(8936002)(7416002)(5660300002)(76116006)(83380400001)(52536014)(54906003)(316002)(4326008)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVk2UXFOOSthZW1lRmZrOUpYVWVLREF0RGt6ZUs5MnhuSjVDNW9TbFB2S3Nv?=
 =?utf-8?B?N01HVDdDTHFmN25CTklNNmdqRGpQT2dlTm9wQU9NSTRXQlVsODVpaDdvRUgx?=
 =?utf-8?B?THR4MDhHYXdZeWRUWkNoTGZpRWFia3RHLzdyd05POGhNL0U4eEdQbmNReHhw?=
 =?utf-8?B?TFdlQ2RzZURRampJSWFyVHdFcVI5d2x3c3BzVGFHelRpL1VBQzBGSDM0V2Q1?=
 =?utf-8?B?WjlDL0YzdklieS9OTzZ0dzRPYThjMmF6UjdhenR0elc2LzNReERpUlZnc3lE?=
 =?utf-8?B?RnF3dXNBMzVGZlY0NnNlb1JtNlFLRkVQbUtic3Bmb1pPOFhxVnEvK1JIWkhD?=
 =?utf-8?B?WStIK2w4Zy9DaFhYbFkzckxSQ291MDkra05OVXFvRnZ0S2VkS21XdXpCSDlM?=
 =?utf-8?B?ZXFrNVpUZTBEUVVpUEtpNThDc2RmRTBoNkFNVmVRMkpnN1V6MXBPR1pndkUv?=
 =?utf-8?B?M0tHVUI0cHZ1SXZNM2cvaC9IZS9CSHhVRU9Ma3FFdDh1RC9seXM0Z1VpZkV2?=
 =?utf-8?B?dmJFZDBiYU1kWENjL21YbC84MHNPVkk1aHYxbk9INHpSQmNSVmg5ZjhndmNu?=
 =?utf-8?B?ZzBTYzBqK3NCUDV2VS9SZk9tSlhvSnRNUVBlY2lvOXN6Ly9MU1R1ZXJOaWVw?=
 =?utf-8?B?aTRLeGpLaU1ObkduUzIyZ2h5elZiS0YwaFFJdndNaEI3c3RheWJIMUJFU1NQ?=
 =?utf-8?B?U1gyNzUvc0d5cUw0b1pmb1l4UXBvdEJmT3Q4V0IvNXNiUW9DT1JQY2l6VzAz?=
 =?utf-8?B?ZVduMEM5cXAyZzl6UkZ2T2JkTmFEZStYbEVmdHlic0RScTl6bVZ4aGpSN2RC?=
 =?utf-8?B?dHpkWDBiaCtoNXM0VnVqdnA5M2s5NUtyNktVM0xnT29jRndENjlMVTJmbFVC?=
 =?utf-8?B?S2tDcEJDL2duY3d2MFlIRUF6NG44SFdkdUJ1TEx4ajgvcDg1aDNCa2E2d2NI?=
 =?utf-8?B?QUV4SjdjUit6Wis0eURiTEJrcUtRaC9NbFdqcTlPbHBrN0RtUnVpZ1pMdWRY?=
 =?utf-8?B?ZjN2VkZlejVMZm5sSEhUYW5EVzlpaHJIMGdRZXVBbHRJbGpBTlo0SzhIK2RT?=
 =?utf-8?B?dUFSUjlVZlhyc1RVaFRHbWdNQnJHSXBxR0g3WUg5STh6cTBCQllnUW9jcG1G?=
 =?utf-8?B?SlVreVpPTUlkMDNKSVZ4WmNMVVRIYlRzcmpyKzdYM0dzUW5IZkdCVXpnc3hO?=
 =?utf-8?B?WWFYUWtkMEJwMzZ3OHlwOW4rVGN6bFVrb0s2Tm1TMkpoUDh2MHBGU0owMGF4?=
 =?utf-8?B?VUdoOWxnTG1hM3hXb0RjK2xYRmF4NVgvNUVFSi9sMktwNVl0bkJ1WmZTVjlH?=
 =?utf-8?B?M1hMVTE4REthQm1IS0J6aGd6Q2h2Q2lmRGV1dXVTZEVlOTkzdEJ1QmROUkdG?=
 =?utf-8?B?U2dLVzY1dWt6aExnemdoTlhhdU1TM3ZKWFJFb0NZL3lZMHFzNDE2NFJ3cmw1?=
 =?utf-8?B?b3VSVktrWnJuaFB4VXdKbHkrbkFMbnNibzM2cUQrYmNYQURlamV5cUJ2WlEv?=
 =?utf-8?B?S2lFaDdzbXp0UDZ5dmtlQlhjOFBBcDdpU2VPYWZ2bTFYM3R0T1FnNXFpbllw?=
 =?utf-8?B?QTllZHdmbTVrSVZSZ1VlSEhMTXU4d09ZeG9BODB5RlhLQkc0VnhIOGJIUFJh?=
 =?utf-8?B?ZzRNRXpBbWlrT2dia3Noc2dKUGpCeUpVa3BFdzJaZmtLQ3hGZk8xUXNSbnN1?=
 =?utf-8?B?ZHB6TEpRUjlaZTB3aGl5TnhwN2huOTluUEdBZDIrWEgwVHJ4bFRwYkRJYWVx?=
 =?utf-8?B?TEZ1akRMc3JjdzBxeGxWL0tsU0FIVlVrY3pZeWNBMmlmK2xRQVVVMExaTmZC?=
 =?utf-8?B?ZEwrRUFuZC8rVFdjOFV4Tm42SU45NTZLa2hVQ1BEK1ZVQjgvelBJV3ZzTnpR?=
 =?utf-8?B?bDV2aW5ZZVRkeDk5VGs3WjU4Qjh6djBLWHlWbHdORThxTG1lWjB5OU0xUGpp?=
 =?utf-8?B?cWRiV1JBWXZHZ3NtM2lXUFhIalcvUE5wNE9oZVNnTm9PVVBVZHd2eGhUNTdJ?=
 =?utf-8?B?WnRRTDdoN1BRRWdEQy8xUHhtbUNYVk5rUmd2TFRjUStXcUFOWUg2b0xURmJ2?=
 =?utf-8?B?NzBDSE11cWFtQy9hbVdxbG9JOE5obFdIUzlEMlpNTjcwdTJML3IveDVDRmEz?=
 =?utf-8?Q?SJbYl4DVaDoW4iMEVeR3w0qrp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b83c2d0-b257-41b3-054b-08daf40042f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 18:18:38.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HunEeMk69k/KjAiONARPxs9nXs1YgrYp7jkosphDZFhHCbih4Nxl2lZ8vG44jWvYIrrVsLcexyjWu6McRorr4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEFkZCB0aGUgQ1BVIGZlYXR1cmUgYml0IGZvciBMS0dTIChMb2FkICJLZXJuZWwiIEdTKS4N
Cj4gPg0KPiA+IExLR1MgaW5zdHJ1Y3Rpb24gaXMgaW50cm9kdWNlZCB3aXRoIEludGVsIEZSRUQg
KGZsZXhpYmxlIHJldHVybiBhbmQNCj4gPiBldmVudCBkZWxpdmVyeSkgc3BlY2lmaWNhdG9uDQo+
IA0KPiBVbmtub3duIHdvcmQgW3NwZWNpZmljYXRvbl0gaW4gY29tbWl0IG1lc3NhZ2UuDQo+IFN1
Z2dlc3Rpb25zOiBbJ3NwZWNpZmljYXRpb24nLA0KPiANCj4gUGxlYXNlIHVzZSBhIHNwZWxsY2hl
Y2tlciBmb3IgeW91ciBjb21taXQgbWVzc2FnZXMuDQo+IA0KPiA+IGh0dHBzOi8vY2RyZHYyLmlu
dGVsLmNvbS92MS9kbC9nZXRDb250ZW50LzY3ODkzOC4NCj4gDQo+IFRoaXMgVVJMIGlzIG1vc3Qg
bGlrZWx5IGdvaW5nIHRvIGJlIHVuc3RhYmxlLg0KPiANCj4gV3JpdGUgaW5zdGVhZA0KPiANCj4g
IlNlYXJjaCBmb3IgdGhlIGxhdGVzdCBzcGVjIGluIG1vc3Qgc2VhcmNoIGVuZ2luZXMgYnkgZG9p
bmc6DQo+IA0KPiBzaXRlOmludGVsLmNvbSBGUkVEIChmbGV4aWJsZSByZXR1cm4gYW5kIGV2ZW50
IGRlbGl2ZXJ5KSBzcGVjaWZpY2F0aW9uIg0KDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLg0K
DQo+IEdvb2dsZSBldGMgaGFzIGluZGV4ZWQgaXQgYWxyZWFkeSBzbyBpdCBzaG91bGQgYWx3YXlz
IHB1bGwgb3V0IHRoZSBuZXdlc3QgcmV2aXNpb24uDQo+IA0KPiAkIHRlc3QtYXBwbHkuc2ggL3Rt
cC8wMS14ODYtY3B1ZmVhdHVyZS1hZGRfdGhlX2NwdV9mZWF0dXJlX2JpdF9mb3JfbGtncy0NCj4g
bmV3LnBhdGNoDQo+IGNoZWNraW5nIGZpbGUgYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVy
ZXMuaA0KPiBIdW5rICMxIEZBSUxFRCBhdCAzMTEuDQo+IDEgb3V0IG9mIDEgaHVuayBGQUlMRUQN
Cj4gY2hlY2tpbmcgZmlsZSB0b29scy9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlcy5o
DQo+IEh1bmsgIzEgRkFJTEVEIGF0IDMwOC4NCj4gMSBvdXQgb2YgMSBodW5rIEZBSUxFRA0KPiBB
cHBseT8gKHkvbikNCj4gDQo+IEkgZ3Vlc3MgeW91J2QgbmVlZCB0byByZWZyZXNoIHRoZSBwYXRj
aHNldCBhZ2FpbnN0IGxhdGVzdCB0aXAvbWFzdGVyLg0KDQpXaWxsIHJlYmFzZSBvbiB0b3Agb2Yg
bGF0ZXN0IG1hc3RlciBhbmQgc2VuZCB2NiBvZiB0aGUgcGF0Y2ggc2V0Lg0KDQpYaW4NCiANCj4g
VGh4Lg0KPiANCj4gLS0NCj4gUmVnYXJkcy9HcnVzcywNCj4gICAgIEJvcmlzLg0KPiANCj4gaHR0
cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg==
