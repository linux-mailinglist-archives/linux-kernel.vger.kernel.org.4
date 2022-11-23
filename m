Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE90634F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiKWFTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiKWFTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:19:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765CE6CA23
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669180742; x=1700716742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D6sHzMdig+VSHFTAuarShAfzNOI1DJxQGvCphRx4Dmo=;
  b=QkLoPLvc1Riowx1iGh934pYOFwdevrCO/4QAo+UQ+96AnerEirdMrUIz
   qdLDBlPE1hg6VBWAawFhOh/GJWFuOWY25xsw7WqNay2WBgs7gDFQCsjI2
   5mJW2ixKyvqEm1aiTFb/YN3szplZMD8yxXU/MrlPAea7yW7jB2wSJy/f4
   gS3i4XgsxgQ7ykNkwyTVZ9ng5DADCmmbD3UXbtdj3NASLirGv88xnDCJZ
   Cg1aqVcbmv2xL3P3/hAOuTQ0EmBovXu4p4PJfBM09cZEc0THq2YN2DB70
   uQK/8Yr8loA0qzZ8NOHMTFtlcZRrxC3dU42SqXlZbt8MR3nX5S4uW7/Ef
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="311611074"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="311611074"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 21:19:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="635792326"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="635792326"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2022 21:19:01 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 21:19:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 21:19:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 21:19:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikSDxa9L9DprDY65kfFjcjNZXKjn1ZRfeuwxR92obIOBrwhfjToRJZ9Y2wxI9YK7TiwTrmnO+KY4lKN5cjXuAj/CcdrWRpQ9mGJ5N3TrlqQ5bBc1fZsd5AlyQS6DbUSHQF1cnZx/0ZS4Ia/E6YOy7EQX6nmgjYpKJ63GPbJo8b4Yk834wAc5L5Wz0pwpHvGy5Vrs8u4oFbBq2V/wKbkyoc09aDoHP38ipJ8jLlgPeV57Qe0z6zhLxsCXVMeCxIgNKdXaVLQ7tB+O/FJ/XTJTDscTYmiVPyboPo3BuCScOObYpRpko5qtprQhmAZPhei2/cqq58aJmob8KP0sv9Kf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6sHzMdig+VSHFTAuarShAfzNOI1DJxQGvCphRx4Dmo=;
 b=FbSOu3mwqrQB1G4J59IngyFcPP0ofZb9RFxjbseZ6nvUQEqkFtFO/HqQuR5Jv4zDdVOL0ByG/tEOV6cQ8ZNjOsUq9tuvUIsFl5wM1U6pPiw7pe/D+2g6rTn81TOre/Z/uY94Zx3JSrQUbyOVHXjeaKFOYxVg56LOokhKdMUme/Yz9MtTvyDJE5x3yMb0ZLFlvdoi1MGFpSZtzelkpoPeSm6bb7g2wKiMxfw8Qt4fpqj+rY2mV+jPlVeY4JB5YBL1YMKHoSSuZ1Tpwo6YekbW5AaMLxv2n9xkpZnSk1B4AdT3UM/GnzGpq8Fvp4b/KageW07xJECvfuOdatlACOsJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 05:18:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 05:18:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Luo, Yuzhang" <yuzhang.luo@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Add a fix for devices need extra dtlb flush
Thread-Topic: [PATCH] iommu/vt-d: Add a fix for devices need extra dtlb flush
Thread-Index: AQHY/iRZ1HNxV1akM0yWbTOvvjHGEq5LOSEAgAB3ReCAAEVGAIAAA3wQ
Date:   Wed, 23 Nov 2022 05:18:55 +0000
Message-ID: <BN9PR11MB527642B1DA920C78742036FD8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221122034529.3311562-1-jacob.jun.pan@linux.intel.com>
 <bc647ceb-b14b-dc5b-ba83-4f8befd188c5@arm.com>
 <BN9PR11MB527620902046A4339EAACD3F8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c085f67d-7874-4a83-a12c-703d1638d940@linux.intel.com>
In-Reply-To: <c085f67d-7874-4a83-a12c-703d1638d940@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6848:EE_
x-ms-office365-filtering-correlation-id: e709cc62-83ac-49dd-a476-08dacd12378a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BqIPEVz0Tv/aPQLF/6Ah+Q5hEX5j49FVgPalX4PER+MlaYesCiIBnHmFbiZjelbYzXtJ1H/wbXKlDE29gyPApoBEr7yf9OF08V22Rj/tcIWQw5dz8HTY9L6b/03n8wBwJnr3x4GwmNflHPqUvOiBgZRXkhZw1wffPgSg9nzdbF+/1mUlwmKtfui+35SHsDBc6gvpg2vvgqNkjmODdKpWyDO2TOpHNw1JAw0EZeHhJTJDGSdc5CzJ/z+1V8SjYErz6VU33xdgJhlY994Kkduo+xd4liRMmfyhFEzjJnh4Mw/Bqx0/0ra6sh87erWcX+8ILK67/KkKSLc8CNtBoXNUlCpCu/jnPI/kiv2Qy4/fMiOX2EkFbfaEV8ugyP7o3C0TZ+0tP0uLxpYcOWXNEmjg91FPWH6f9h/VtnIwmehD+4hyzgmlN9IyermafMQiZ7x3rMIapL3Ms5aoBqTG16oQqmttGYTpEkwRTgKWxpp5bKKPHvvCMu6ArYdjF0OM+2SbGy02+MfXkWSTPiCMLkGPFbFgJXiMkiObOQMUo1grT1kz4tK9+Cg8ptRDAIgApVeCO/uONvDT1uZqL8UjqWf4wFWvrXMHt4v+o4c8HngaOq4lNxnJKC/LOXnWIIFlDftdDuU84axV0Zirx+0m4EfI3o0RGRKdvzhXbk4u2FnRWmeY8HvzQis2+BzHGsFD/5H6rbd70XbEzWo9d3fdtwaUFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(33656002)(38070700005)(86362001)(8676002)(55016003)(6506007)(5660300002)(7696005)(83380400001)(122000001)(53546011)(9686003)(82960400001)(38100700002)(186003)(26005)(76116006)(2906002)(54906003)(66446008)(478600001)(66556008)(66476007)(41300700001)(64756008)(71200400001)(110136005)(8936002)(52536014)(316002)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWd1dHd0eW14VzllZ0tsemFVWTNnY0x0L2kvRTY0RkYrU2hRb3RHb3FCMGZr?=
 =?utf-8?B?UVUxS3RwS01OUkNONWpURmdQYllsdWhRSXFtVmRudDBva1YvSmZmMHQwQUlo?=
 =?utf-8?B?SGZIRVRMQnlKUUoyUStkbFcrTjZWSVFQWEpXcEppV21uTWRVczIvelYwWUdH?=
 =?utf-8?B?cTE5d29lVlZYRFN2QUk1YUdnNVRrOXkxTVduN09JcGFFQmt6cDBPU2MyZjNn?=
 =?utf-8?B?bzJmNHNYR2hCSkxGelJrcDcxV1AvN0pSazBBWUtyME5reEV5aUZjOGl4aFp4?=
 =?utf-8?B?a0VDc2h5ekg1blNPRFpGelNobnBCZHBnVHU0YU1uZlBkcXJCZEc4U2ppbkpm?=
 =?utf-8?B?dkNzcG1SekEzb2pmUjJGR0FQVkd2cU13U3h1ejg3ZUthTmtLeDkxSTZ3a3JK?=
 =?utf-8?B?QkZWU3pWNnR1RmpmSEw3Z21kdUZTSHhOSTlJZFZuU3c0dnRYNWNYMWp6aGlK?=
 =?utf-8?B?UTVLbHNCZmhZTkR1Qmo3ZzVDZTBmYjhKaEZsTjFZcTgyWUlGNUJ2TWk3VGgw?=
 =?utf-8?B?Skx2WDA2eCtWOHF5dUd6TnNrOUhJRHdzODJsd1pZSUZIREVrTis5V0FJVTZo?=
 =?utf-8?B?WnZWNXFzSmVpOTVtNnpUNFVYNi9BOSttS1U0K2VDYUl5VWRZSXZYMVNseTNB?=
 =?utf-8?B?RlBVRVd5ZUlmSXBsVVYzaEpoRjhvQ0d0UGN3OXVlMk54YmdhN3ROdVlJN0Q4?=
 =?utf-8?B?czV2TXFIR3M4Y3MvNVg4Mkd5YnlpUnM5YXRZY3d3S1RkSllpcElzdFdIUjhn?=
 =?utf-8?B?dUlrUHdTVThVVElCTHBUYlFLRE9HRm1pcFNscHNRK01ZbUZtTnB5QjZLVVhs?=
 =?utf-8?B?WEdpU093MUdjdWk1NFYzZGp6a01YUG5LUEFqS3pJL1VXVzdFME9GczBBaEVa?=
 =?utf-8?B?NnBQNVNJVWR4Q0lvaldCaHdydk5UQ1R3RnZubkZSTnUwcS9KVFlKaDVHZVhE?=
 =?utf-8?B?QjF5aWxmejh5ZjhkNlZCK25VUmlHRWZnUE9RNmVjdHlNYWtaV2RJd2JyNm95?=
 =?utf-8?B?OTl1STFuUjBhMnEvNTd0eUJ6SUNwa1lKam1oWlU5UGdpNWx0K0krbVoxTkpK?=
 =?utf-8?B?eVc5Q1plMGFZNE5RUkRpMGt5WXY3eC94ZXpVQ3JCSDZmZ2FZODJJQUN0ZFJi?=
 =?utf-8?B?TzRuSTQzTGFKSzFNVlMwNUFoOVQ4Um1SYWJia2s3SEVjQU10UHVxQmZsVTlt?=
 =?utf-8?B?ekhpMmFyQTZMS0pDb291Vyt2TEpad0xleFA4SDRQdHloWlNkSHh5WGtwQ3V4?=
 =?utf-8?B?aWE4Q3U4YlBjd25BU2Q0cWlWNWJ5SzEvNDUweXZER2hvUlg0bjRueEg1bGVv?=
 =?utf-8?B?K0s4VG0rYVJoMk5NMlNyR28zajkzdUhTVlFzOVgxS3VJU0Q3RG5naHo3dWpu?=
 =?utf-8?B?bnYrKzFxY2tNRG02bkJMNHdBKzVNV3BkMGFGWUZ2UElpa2RPVDJlZlVERmZT?=
 =?utf-8?B?WkN3ZHUycTVHb1U4NGV6bVlFSWpaVkp1TVdJWWkxNUNaN1MzcTRjODlRT3NI?=
 =?utf-8?B?bjNnS3VUeDIvOEdqOHpFOWhSL05samZENU5NcVFuRmhpaG9KWnVnZzFXVEx6?=
 =?utf-8?B?ekZpY1M5blBLcGlLbUY0blcrK0JGTGVmV0FVTXRXWSt0YjFUWTVQZFl4dDYy?=
 =?utf-8?B?c3BqOFVBSXY5RTRWOTUvTHEzQy9YOTNlbUVIMlJpTmQvVVA3c1djWjlIaU02?=
 =?utf-8?B?aG1HaHBuOExGQUgxYVpKOVh0MEhEMTVmYTFrMmN3QWVLYU44TnBMY0lmeEs5?=
 =?utf-8?B?U0d5Y280T28yUGJOKy92a08wYkl6ZFVaNWNaOW9VV1dPOUVhMUhlaHVRdlpY?=
 =?utf-8?B?RG43dE1nVm1uTVUvRFBXVHU5UzRJTG5xUWNkYnJWUWswTWc4QVN6aGFGaURP?=
 =?utf-8?B?YnFWWWZxWDFRQUZvTHczaXRZcUxCZGpUQVJHd1d3dW9mVGxuZHVCTDBjMldO?=
 =?utf-8?B?WWdqVUVIeE01T2kxblVGZ2xMZXlZZyt1UGtNa3hqT0tSVHg3UTBacFFWSFcx?=
 =?utf-8?B?bGpBSVBqRHA2aWFDTkRLWk5mZVV1TUpYRVhMVjRyWnZxNnNsTEFESUtBOFlk?=
 =?utf-8?B?d2sxUXdTWndSUFFHZEU4ZG95dHNqZTlXWCtkM0wycjJBd0FqU2NRV0VVMXRS?=
 =?utf-8?Q?sbwYErt7ES1dymN4ReERkwHvu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e709cc62-83ac-49dd-a476-08dacd12378a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 05:18:55.0815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCQQTQ5s9g02AlN8Hw9/dou+hptnBTl/eO7F1lBrQm0SyH7a9r1lUsI4/qhT4VtvLW4vCDJyLeBSjmPNTkPoig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDIzLCAyMDIyIDE6MDQgUE0NCj4gDQo+IE9uIDIwMjIvMTEvMjMgOTow
MiwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IFJvYmluIE11cnBoeSA8cm9iaW4ubXVy
cGh5QGFybS5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjMsIDIwMjIgMTo0
OSBBTQ0KPiA+Pg0KPiA+Pj4gKw0KPiA+Pj4gKy8qIEltcGFjdGVkIFFBVCBkZXZpY2UgSURzIHJh
bmdpbmcgZnJvbSAweDQ5NDAgdG8gMHg0OTQzICovDQo+ID4+PiArI2RlZmluZSBCVUdHWV9RQVRf
REVWSURfTUFTSyAweDQ5NGMNCj4gPj4+ICtzdGF0aWMgYm9vbCBkZXZfbmVlZHNfZXh0cmFfZHRs
Yl9mbHVzaChzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gPj4+ICt7DQo+ID4+PiArCWlmIChwZGV2
LT52ZW5kb3IgIT0gUENJX1ZFTkRPUl9JRF9JTlRFTCkNCj4gPj4+ICsJCXJldHVybiBmYWxzZTsN
Cj4gPj4+ICsNCj4gPj4+ICsJaWYgKChwZGV2LT5kZXZpY2UgJiAweGZmZmMpICE9IEJVR0dZX1FB
VF9ERVZJRF9NQVNLKQ0KPiA+Pj4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+Pj4gKw0KPiA+Pj4gKwlp
ZiAocmlza3lfZGV2aWNlKHBkZXYpKQ0KPiA+Pj4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+Pg0KPiA+
PiBIbW0sIEknbSBub3Qgc3VyZSB0aGF0IHRoYXQgbWFrZXMgbXVjaCBzZW5zZSB0byBtZSAtIHdo
YXQgcHJpdmlsZWdlIGNhbg0KPiA+PiB0aGUgZGV2aWNlIGdhaW4gZnJvbSBiZWluZyB0b2xkIHRv
IGludmFsaWRhdGUgdGhpbmdzIHR3aWNlPyBXaHkgd291bGQgd2UNCj4gPj4gd2FudCB0byBpbXBs
aWNpdGx5ICphbGxvdyogYSBkZXZpY2UgdG8gcG90ZW50aWFsbHkga2VlcCB1c2luZyBhIHN0YWxl
DQo+ID4+IHRyYW5zbGF0aW9uIGlmIGZvciBzb21lIGJpemFycmUgcmVhc29uIGZpcm13YXJlIGhh
cyBtYXJrZWQgaXQgYXMNCj4gPj4gZXh0ZXJuYWwsIHN1cmVseSB0aGF0J3Mgd29yc2U/DQo+IA0K
PiAgRnJvbSB0aGUgcGVyc3BlY3RpdmUgb2YgSU9NTVUsIGFueSBxdWlyayBpcyBvbmx5IGFwcGxp
Y2FibGUgdG8gdHJ1c3RlZA0KPiBkZXZpY2VzLiBJZiB0aGUgSU9NTVUgZHJpdmVyIGRldGVjdHMg
dGhhdCBhIHF1aXJrIGlzIGJlaW5nIGFwcGxpZWQgdG8gYW4NCj4gdW50cnVzdGVkIGRldmljZSwg
aXQgaXMgYWxyZWFkeSBidWdneSBvciBtYWxpY2lvdXMuIFRoZSBJT01NVSBkcml2ZXINCj4gc2hv
dWxkIGxldCB0aGUgdXNlcnMga25vdyBieToNCj4gDQo+IAlwY2lfaW5mbyhwZGV2LA0KPiAJCSAi
U2tpcHBpbmcgSU9NTVUgcXVpcmsgZm9yIGRldiBbJTA0WDolMDRYXSBvbiB1bnRydXN0ZWQNCj4g
UENJIGxpbmtcbiIsDQo+IAkJIHBkZXYtPnZlbmRvciwgcGRldi0+ZGV2aWNlKTsNCj4gCXBjaV9p
bmZvKHBkZXYsICJQbGVhc2UgY2hlY2sgd2l0aCB5b3VyIEJJT1MvUGxhdGZvcm0gdmVuZG9yIGFi
b3V0DQo+IHRoaXNcbiIpOw0KPiANCj4gYW5kIHN0b3AgYXBwbHlpbmcgYW55IHF1aXJrLg0KPiAN
Cg0KQSBxdWlyayB1c3VhbGx5IHJlbGF4ZXMgc29tZXRoaW5nIHRoZW4geW91IHdhbnQgaXQgb25s
eSBvbiB0cnVzdGVkIGRldmljZXMuDQoNCmJ1dCB0aGUgcXVpcmsgaW4gdGhpcyBwYXRjaCBpcyB0
cnlpbmcgdG8gZml4IGEgdnVsbmVyYWJpbGl0eS4gSW4gY29uY2VwdCBpdCdzDQp3ZWlyZCB0byBz
a2lwIGl0IG9uIHVudHJ1c3RlZCBkZXZpY2VzLiBUaGlzIGlpdWMgd2FzIHRoZSBwYXJ0IGNhdXNp
bmcgY29uZnVzaW9uDQp0byBSb2Jpbi4NCg==
