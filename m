Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2B6655BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjAKIIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjAKIIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:08:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4246C42;
        Wed, 11 Jan 2023 00:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673424514; x=1704960514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rrvSZr1g1SgmT2MvFpjXUHC/tZnoiW+wAg5TgwABkdQ=;
  b=WbQn0UirA6omOjOFC0OOlJ1DhTlPNXaa0AkFx419zfc9m6TuER0+vuqx
   HeZU0WEgAVeQT1Zn+mzJz67Lyhow5CCxbLuTi5TAJJcZHggti6fx+fSld
   NCWI++w7G6uy6bY9JQCTfpOSuTZwugW5rSEBQZYixuKq4+O9WhEX4bKgg
   w4vSpwHCEGnec4a9IBHOF8OqK02+nC8v4YxLlA46BXdUuY6GzkwskL6Ix
   cTMgI8dkkH3hpFx7Z+xIq3JH8YcK1J2Ch4jTjbOwk1shok38GqeMwsvXf
   wNrgQUD55bi32+mWP9MQMyfw+DAArMzS0miZMPvWeOLBbrF+zQz6QXcRk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350584740"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350584740"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 00:07:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="765081641"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="765081641"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jan 2023 00:07:54 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 00:07:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 00:07:54 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 00:07:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im1eaaPJskZlwNJEXflYaESn+PVqTP3lv05q2iJYu97v4chfWU4H6w962gFFI86QqTN8LKDZ94bd+7lwXARo15avAPCtmCQBePCLpwl4iTd/+tzGkSYbjnzyx2X1IE4dvn/PK5u54b++RJsUpqmw//lNHWxQ1CNrtj3CFlzdLgw4S3UrVL800NmOLexITJkyFhAiGysCGC0r9/NNsdArO9mUnBAzftHv9LpQC6mN/ewi2uhuNKhQwWV81vYA2OewbzH7TAxdBVM+InqZaLalMOjkURHEnUAyZgIsWoLTTakH1feQ7Ysd+XjDKl3u613qItpL/+hJUiNumYDDrd8C1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrvSZr1g1SgmT2MvFpjXUHC/tZnoiW+wAg5TgwABkdQ=;
 b=bGssdZr4CYK1QTtUfmKHr116JLeCR7l05S4S3GMPw+KVjWN7sFg7CdXhnA9i+HMgwDVl8co3fSU0eG4H97rZjlEUrzdZdeheU5iuJ5YMeV8/EqlGuK9fPf3Pbtfx6779BiyAYBXYHOR4Aj+OtNBXsQrAwAya+iGQ8RF0GtQYLlgDstJOIxqh9iGaN6XFezUb/Mc8Hvlrz0nRtIqBD0domY4Ox2DT/FqGqvRfR1xO/uYWhIP7H5lsWzHr1gb8zx/+llaPW+whhzXAVVFT8dM0gsWDXpM9qgoPva9EmSiu3CNWN2gxpV2YfHedqwxFlG3f3VR+P6/qQ0Iy/vvRqoICKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4329.namprd11.prod.outlook.com (2603:10b6:5:201::18)
 by CY8PR11MB7338.namprd11.prod.outlook.com (2603:10b6:930:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 08:07:51 +0000
Received: from DM6PR11MB4329.namprd11.prod.outlook.com
 ([fe80::1f13:f8b:5846:3195]) by DM6PR11MB4329.namprd11.prod.outlook.com
 ([fe80::1f13:f8b:5846:3195%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 08:07:51 +0000
From:   "Zhang, Yang5" <yang5.zhang@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH v1] ACPI: PNP: Introduce list of known non-PNP devices
Thread-Topic: [PATCH v1] ACPI: PNP: Introduce list of known non-PNP devices
Thread-Index: AQHZJR0gKBuvlkN6PUyPjwH7KCdxOa6Y0XGAgAAKbICAAAAhEA==
Date:   Wed, 11 Jan 2023 08:07:51 +0000
Message-ID: <DM6PR11MB43299E04540120D970C7A940BFFC9@DM6PR11MB4329.namprd11.prod.outlook.com>
References: <12149290.O9o76ZdvQC@kreacher>
         <c9acadcd3e19e7dafb8ba4cf1f0abb0200b18b1a.camel@intel.com>
 <b6c9bbdeea2f9d7f05d2d129a47e8449033d956c.camel@intel.com>
In-Reply-To: <b6c9bbdeea2f9d7f05d2d129a47e8449033d956c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4329:EE_|CY8PR11MB7338:EE_
x-ms-office365-filtering-correlation-id: 9fa38fde-a870-4e04-9a5b-08daf3aaef48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ymYjG07CkC5OgCERTPTyGSv75T/MviCJcOajgWK9DYL0K4/yeC+/wQko8FvIWRCGLAjagSpzZ2zL5qc1dozV4MdqNP4ewh1ergo+t0rYMecEAC1Hh+8ML19iLvp35hJEz1VezpbmK8rDnlUi68ZN5JwEq39iNn6zAoSidif2iE6L0FS81FdF8FNTqQJAjEtVwugmfUq/1NOz4udtpeszjrvmwAriPcVK8w1bKGf4H864he3W/ZrprZsVYdcT4XRAAi5EvXI5m++54ERdl8U3jhgUkROcXYP/55O81XtMh4ujhbZ9eKVqP+pX1DbSJah9wegJrGZmgI1uHuyhQm2ZDnWSn5Mhvx5PPf8Os3XOCYRL8RP0KO//S+Xn74TiQKa9a6Ca7Y3ZcL+gR+BGAh9jloeAaJpAaaYX/T67cCkseovyLTUxdjJrBZKSJ24fx4FgrRHhQjfezfTKtEvhk8HsvF0gP5jT4kRUernDWfQMuk2RGT/I7BHnrAhBJFyP8mptbnQxIrq3nkwP6xNayDrx/A1eLlrip93q8Y0D/tl26KOREZYcNwQF8cNtWQuzLzucmFcol82HhWYr6dqvhe9zG+2aQFLCOmdovS94+nLT5Xy+H2MrU7AJ6duF0xYLZfeyKhoIxJHrXmAAzFlyGcfC6ljzxrPnV48Nqin2bplZJ5yRlDcQuirUsQBzH3SkoAXaUnhBoxu/5AXjxrr00XobRrM76ZfcOubsAcQRI0n0PkgpzK1seKRX0gYPWiGXydK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4329.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(66476007)(33656002)(66556008)(83380400001)(52536014)(66946007)(76116006)(64756008)(38100700002)(8676002)(4326008)(107886003)(5660300002)(41300700001)(66446008)(8936002)(26005)(9686003)(186003)(110136005)(55016003)(54906003)(38070700005)(122000001)(7696005)(71200400001)(53546011)(478600001)(6506007)(82960400001)(316002)(84970400001)(86362001)(2906002)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0hSdG9qWklXMW9PVjBPeXRDc2tZWVBlSHB2VHdGTC9IY3FiOGZmQkRhelU2?=
 =?utf-8?B?VnhMaVlYQXpmS3VXcTlFOEtESDk0L2FTL2toYVRBS25uZS9nYVo0Zi9PTXgy?=
 =?utf-8?B?WFpSNkN0K1RCa0ZCTE5IR2M0dDBRemdXWHk1OS9kRTc0SFo5Rm52MTJkZTdx?=
 =?utf-8?B?cG1TRmx6cVpYZXYvRlFxN0d5REVGdW55R29IZEJZbk1ITEdOL2RkYXdNZUcw?=
 =?utf-8?B?Q29hYWlmbnRHRkZNVXR4cjZUZWl4YzRHWCtYa3dPakYxZmJlY0JkVkFNSFEw?=
 =?utf-8?B?dlNqWEVZbFFDY2FvZGZIM3BNWGRMTS9lQ0cxd2hmVEVCcUpqamMwUVUvM1Jh?=
 =?utf-8?B?TzZ6UFViRk1JVmlVMXZ3alJaeDQzYW1iQVdSRXIxVzhHdjY0bGc1L2ovWDlL?=
 =?utf-8?B?QkpiQk1vMCtGMHRKbU5ieWZyRTVMWE5IdjJhZCt5WGc3VmRqYUJyemhxNjNm?=
 =?utf-8?B?Vk1YK0RmazBHTlhQei9FdERZMytOU3JDTGxyNkpUeUY5UTB5N2o4eUh5alo5?=
 =?utf-8?B?akR2MUcxdjNDOFY1Q3Y4RHVpTEZIQitCQTBOTE9iU3NNdUk0UlkwZWtsdUdM?=
 =?utf-8?B?SG5IK1pNZDl2ck9PN1JOeURiWXV0TjBsbWFTVUlNVE16TzQ2dXhqUGJJWldN?=
 =?utf-8?B?TWRNWHV4dUxHVDJWNWhGcGVrSTBmTjZ2eGp0WWJ6VWhpRGYzWUFMU3NWSklt?=
 =?utf-8?B?MmdGS0hMRHBRSWw3bTVTTUxqbXhZNlF3TmpQN2tIb01Ra0dMSUVYWkluQWIv?=
 =?utf-8?B?WkVZUTBoc1lHTk1GVldTc25VVG9vMVhYQkZyaUM5OWtZZVNXczg3bTZyTVpo?=
 =?utf-8?B?NHFvYU9renBEVDdxL1hZK21jQmsxc0REOTFXZ0VsN3g4VER1elRWUmxhdkFl?=
 =?utf-8?B?ckhyRC9GTnVJN1pGTjh6alVJSlFOTEI2OEpyNkxIWkdSbXArYXArNFI5Y3Zr?=
 =?utf-8?B?TlpQTWh0TjFpUXpFQWEyeWZsQlMxNDFvdFV2VXlFbVpub1JqNUMycEhOandz?=
 =?utf-8?B?bm03Q21SZTIzbDZVMEpZSXE4aVJTT1pjd3FQU2RBOXNuM1BIT0FHSmdEQ1RY?=
 =?utf-8?B?em1CQjZJd21rRVlNMWJ1cXliTmVoa01PY2lDUXpGQ0lCSjVlUGVpQlVEL0tk?=
 =?utf-8?B?UENYZERnQUV4NWtqclJzQmVpUGttMWV2MnpuZi9OSFErSzNPZFhZNUhMa2J5?=
 =?utf-8?B?VG5IV2lOQWNwd1ErVFJ5NzBvc0QxSHVGRVZwc3NhQnp0VUpZdW1qVUpLV3BB?=
 =?utf-8?B?L2Q1SmgzQ2R1TkVWVWJrL3FPMkR4c1ZXN0cydkxQNUZNM0xWMWEra2NoQUNR?=
 =?utf-8?B?cTZUL3IxVmsxOXA2am5GSk1WMzMzaHhKdXRCVDFwRURmWEh5Q2NCS3JRZGY4?=
 =?utf-8?B?SDhYdjltalJsWkp3NTdudHJZOHhnZ2dXSmdjdXFZVmk0TkZDYzk3a1VsRkth?=
 =?utf-8?B?Q1N3dHo2emRWQ1BrcFVPMkhtOGo5WWVvSGJVbjZTQkFiVnZnZVkvdzM5dWRv?=
 =?utf-8?B?ZnRTL2NXUFRCak1sNXBmaE1xMVBObVNVbGNmbkp0a1BSNmY3YjkzaFV5bXI2?=
 =?utf-8?B?dk1rK3c2K1phcGtpejB2VXhOS1FCSVY0d2NRMzRBNXJQN2owdW5BRTRzMmtj?=
 =?utf-8?B?N2pyU1JkV21UVkpYL2xpaEtEL21xZHRjWENUaDN4VysxbUc1U3hCdE05cHcv?=
 =?utf-8?B?MVcxU1FJaVFqZ3k5V0gwbDBWS0FnWStTTDRpT0VCd3M5S1dHWFVPOTlTQUk1?=
 =?utf-8?B?T3hsM2pyYUtlWWVtUHVhSWxnb1A1UU8xak14eTBRYW1xSm42bVpsUGhqSmJq?=
 =?utf-8?B?dzJMbzlXSXFnUkFmM3lvNURsbWxCeVZZU2VzVmxRTjZtc0dmbjFGZXZ6ekFq?=
 =?utf-8?B?bGY4NzZPdGtWd1ovYnYxWXJPcUFwbjM2Umw1NlBTUEVSWVg0Mms2eEtHbWlp?=
 =?utf-8?B?WXV5MnEvT2cxQ1Qxbk9yREYrUnZscUN2OHJSZm9KVU55WFFlV0pRNnN5RVRt?=
 =?utf-8?B?cE12MUdubDZqa1Rsc3REZU9nV2hhRjlxaTRKNGdrM0hsMVkwWUlkRURxVlpK?=
 =?utf-8?B?SWVYSU12ZnlNczNPSVRheFh0NXZkSmFDWm03Z3kxZGhFUkY4dFBITko3Zlg4?=
 =?utf-8?Q?hyv2W5aU+6+7vB2slcxA9Y7GO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4329.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa38fde-a870-4e04-9a5b-08daf3aaef48
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 08:07:51.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +th6BebNN7dHE/huxGPu/3n1dp0UPmPaclZ33+tn+sied/yg81MWo0GuNBQxxMmfTnBzHDDfeOM3v+EPGuc4nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7338
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBaaGFuZywgUnVpIDxydWkuemhh
bmdAaW50ZWwuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAxMSwgMjAyMyA0OjAyIFBN
DQpUbzogcmp3QHJqd3lzb2NraS5uZXQ7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnDQpDYzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQ2hlbiwgWXUgQyA8eXUuYy5jaGVuQGludGVs
LmNvbT47IFpoYW5nLCBZYW5nNSA8eWFuZzUuemhhbmdAaW50ZWwuY29tPg0KU3ViamVjdDogUmU6
IFtQQVRDSCB2MV0gQUNQSTogUE5QOiBJbnRyb2R1Y2UgbGlzdCBvZiBrbm93biBub24tUE5QIGRl
dmljZXMNCg0KQ0MgWmhhbmcgWWFuZyB3aG8gaGFzIHRlc3RlZCB0aGUgcGF0Y2guDQoNCk9uIFdl
ZCwgMjAyMy0wMS0xMSBhdCAwNzoyNSArMDAwMCwgWmhhbmcsIFJ1aSB3cm90ZToNCj4gT24gVHVl
LCAyMDIzLTAxLTEwIGF0IDE4OjU4ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4g
PiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+
ID4gDQo+ID4gSW4gc29tZSBjYXNlcywgUE5QIGRldmljZSBJRHMgZnJvbSBhY3BpX3BucF9kZXZp
Y2VfaWRzW10gYXJlIA0KPiA+IHJldHVybmVkIGJ5IF9DSUQgZm9yIGRldmljZXMgZm9yIHdoaWNo
IG1hdGNoaW5nIHBsYXRmb3JtIGRyaXZlcnMgYXJlIA0KPiA+IHByZXNlbnQgaW4gdGhlIGtlcm5l
bCBhbmQgc2hvdWxkIGJlIGJvdW5kIHRvIHRoZW0uICBIb3dldmVyLCB0aGUgSURzIA0KPiA+IGNv
bWluZyBmcm9tIF9DSUQgY2F1c2UgdGhlIFBOUCBzY2FuIGhhbmRsZXIgdG8gYXR0YWNoIHRvIHRo
b3NlIA0KPiA+IGRldmljZXMgd2hpY2ggcHJldmVudHMgcGxhdGZvcm0gZGV2aWNlIG9iamVjdHMg
ZnJvbSBiZWluZyBjcmVhdGVkIA0KPiA+IGZvciB0aGVtLg0KPiA+IA0KPiA+IEFkZHJlc3MgdGhp
cyBieSBpbnRyb2R1Y2luZyBhIGxpc3Qgb2Yga25vd24gbm9uLVBOUCBkZXZpY2UgSURzIGludG8g
DQo+ID4gYWNwaV9wbnAuYyBzdWNoIHRoYXQgaWYgYSBkZXZpY2UgSUQgaXMgdGhlcmUgaW4gdGhh
dCBsaXN0LCBpdCBjYW5ub3QgDQo+ID4gYmUgYXR0YWNoZWQgdG8gYnkgdGhlIFBOUCBzY2FuIGhh
bmRsZXIgYW5kIGFkZCB0aGUgcGxhdGZvcm0gcnVudGltZSANCj4gPiB1cGRhdGUgYW5kIHRlbGVt
ZXRyeSBkZXZpY2UgSURzIHRvIHRoYXQgbGlzdCB0byBzdGFydCB3aXRoLg0KPiA+IA0KPiA+IFJl
cG9ydGVkLWJ5OiBDaGVuIFl1IDx5dS5jLmNoZW5AaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NClRlc3Rl
ZC1ieTogWmhhbmcgWWFuZyA8WWFuZzUuemhhbmdAaW50ZWwuY29tPg0KDQpUaGFua3MgDQpZYW5n
IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvYWNwaV9wbnAuYyB8ICAgMTQgKysrKysrKysr
KysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gPiANCj4gPiBJbmRleDogbGludXgtcG0vZHJpdmVycy9hY3BpL2FjcGlfcG5wLmMgDQo+
ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KPiA+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvYWNwaS9hY3BpX3Bu
cC5jDQo+ID4gKysrIGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9hY3BpX3BucC5jDQo+ID4gQEAgLTM0
OCwxMCArMzQ4LDIyIEBAIHN0YXRpYyBib29sIGFjcGlfcG5wX21hdGNoKGNvbnN0IGNoYXIgKmkN
Cj4gPiAgCXJldHVybiBmYWxzZTsNCj4gPiAgfQ0KPiA+ICANCj4gPiArLyoNCj4gPiArICogSWYg
b25lIG9mIHRoZSBkZXZpY2UgSURzIGJlbG93IGlzIHByZXNlbnQgaW4gdGhlIGxpc3Qgb2YgZGV2
aWNlDQo+ID4gSURzIG9mIGENCj4gPiArICogZ2l2ZW4gQUNQSSBkZXZpY2Ugb2JqZWN0LCB0aGUg
UE5QIHNjYW4gaGFuZGxlciB3aWxsIG5vdCBhdHRhY2gNCj4gPiB0bw0KPiA+IHRoYXQNCj4gPiAr
ICogb2JqZWN0LCBiZWNhdXNlIHRoZXJlIGlzIGEgcHJvcGVyIG5vbi1QTlAgZHJpdmVyIGluIHRo
ZSBrZXJuZWwNCj4gPiBmb3IgdGhlDQo+ID4gKyAqIGRldmljZSByZXByZXNlbnRlZCBieSBpdC4N
Cj4gPiArICovDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgYWNwaV9u
b25wbnBfZGV2aWNlX2lkc1tdID0gew0KPiA+ICsJeyJJTlRDMTA4MCJ9LA0KPiA+ICsJeyJJTlRD
MTA4MSJ9LA0KPiA+ICsJeyIifSwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgYWNw
aV9wbnBfYXR0YWNoKHN0cnVjdCBhY3BpX2RldmljZSAqYWRldiwNCj4gPiAgCQkJICAgY29uc3Qg
c3RydWN0IGFjcGlfZGV2aWNlX2lkICppZCkgIHsNCj4gPiAtCXJldHVybiAxOw0KPiA+ICsJcmV0
dXJuICEhYWNwaV9tYXRjaF9kZXZpY2VfaWRzKGFkZXYsIGFjcGlfbm9ucG5wX2RldmljZV9pZHMp
Ow0KPiANCj4gYWNwaV9tYXRjaF9kZXZpY2VfaWRzKCkgcmV0dXJucyBUcnVlIGlmIHRoZSBpZCBt
YXRjaGVzLCBhbmQgaW4gdGhpcyANCj4gY2FzZSwgYWNwaV9wbnBfYXR0YWNoKCkgc2hvdWxkIHJl
dHVybiBmYWxzZSwgcmlnaHQ/DQo+IA0KSXQgaXMgX19hY3BpX21hdGNoX2RldmljZSgpIHRoYXQg
cmV0dXJucyBUcnVlIHdoZW4gbWF0Y2hlcywgYW5kDQphY3BpX21hdGNoX2RldmljZV9pZHMoKSBy
ZXR1cm5zIDAgaW4gdGhpcyBjYXNlLg0KU28gdGhpcyBpcyBub3QgYSBidWcsIHNvcnJ5IGZvciB0
aGUgbm9pc2UuDQoNCnRoYW5rcywNCnJ1aQ0KDQo+IHRoYW5rcywNCj4gcnVpDQo+IA0KPiA+ICB9
DQo+ID4gIA0KPiA+ICBzdGF0aWMgc3RydWN0IGFjcGlfc2Nhbl9oYW5kbGVyIGFjcGlfcG5wX2hh
bmRsZXIgPSB7DQo+ID4gDQo+ID4gDQo+ID4gDQo=
