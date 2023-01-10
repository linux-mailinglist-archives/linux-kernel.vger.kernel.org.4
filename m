Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F8D664787
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjAJRhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjAJRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:37:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9A39FA6;
        Tue, 10 Jan 2023 09:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673372237; x=1704908237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IW/F9cPXPi5MurOv6IRRQnAzfeAXVyYL+irgBikfJYs=;
  b=ISNUzZdwPkUkwjvq0ULSl9Xrmcojefmc9/3wt/GyB0CQteEhYMk8Fu/W
   Ai4A03KCLOgedd2FBDWY9I6O6Sv6fMFJgoVDt4mY4YhfwKx7X8beSS8i6
   kuG3yseKuX/fARVTvDm4iK6mdgtvuhF5sU1TxTcUyo4+QABgyHeiHNY82
   c7mIdbROQGuGUIr4fFTWxFHUoO0bgzt015PdO7T1BxPRQhwMkV8fiX+8o
   yFzc5UlzjEGiSNY3kHex0NUSM6V9yzHmGL29weYB5vSsoIP5gjBSnOLu8
   R2g6gGkaDAvf3tCEzybjnL5yKB21CODUJdK/kRdh6CasN1uF1UJ8SItn9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385516993"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="385516993"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 09:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="831075633"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="831075633"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2023 09:37:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 09:37:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 09:37:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 09:37:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmqHc0NOG0wRXwZuU4jQzRZW4m9aULNNLOyUKjLGCXaEoKFlLMKkOh+tkXmxFxW27onkHjhfkV5589rZ1+V4+iOz/KEVw3xZaF5R0z5KqbqNL2LuKL258jGv1uHObBATwMkbNMp+zVsHxjid7UO62o848WwuxlDidBMFFuu4VlbipLc0a7EgVyZRpAOifAcogym4mPYFiRZ3ChkiP4dV7x01I4Lc8lekJ+eVw21Q+zpoEWGjNA454KNw5mqzEDSU1I7TeILnf1HvEAlkHWXOfmUkj0Sgmtm/IAvjelBg+S0eUVUh65ZMAWveWsFyFIcgRN66AdxbJRgRkfopTNVRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW/F9cPXPi5MurOv6IRRQnAzfeAXVyYL+irgBikfJYs=;
 b=LIHlQnj4x0K5Nic6xKpvw79M4UHHr8WttTWkn1x20HmB8OqJ45gw7jVYfMnIfeiSMCWSNWAcO93HIobeOgaN/Sb6q5/Cmyp06/uR9l5fpsQf1WyZe3Z6n9gW9LAa5eu+kyF6lbqL1bo7yxLHb48oHBe/qox94xfCgjw2T/px5RYjEirjRaSsQmdK7qcf3b+KLfbOoTKGsCkUotnLsqHq5cGAfr1VjeqVTnz8hxJNn8BjyrrP3UVOmcii4ZPSWaE1ijHBhVeIkCquVhfDw0jhyAFGGYpUlpmLefCIKyGGwlGNZxmh574cUqJ1aO9XKpVYBrycG+IVOvke5/CPRl7jZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN9PR11MB5258.namprd11.prod.outlook.com (2603:10b6:408:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 17:36:57 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 17:36:56 +0000
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
Thread-Index: AQHZCECAee7h3GZRn0awYifKRUmveq5fPtOAgC3g0ICAAAjiAIAK+z4A
Date:   Tue, 10 Jan 2023 17:36:56 +0000
Message-ID: <8f73fdf9d1c9b94cbe1587bf8f5271ca65f17caa.camel@intel.com>
References: <20221205002804.21225-1-rick.p.edgecombe@intel.com>
         <CAJZ5v0iZ8QdCMca1F+z2NJ8+a-jUkGMSNp2KRovCB-aMjHF7qg@mail.gmail.com>
         <c4c95945df72fda7b7d6f333a4aea7e19d7e684c.camel@intel.com>
         <CAJZ5v0j6qd930BKWWf-e+_Vod0Wv16LZChCOa0yf0_uLC=UMyw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j6qd930BKWWf-e+_Vod0Wv16LZChCOa0yf0_uLC=UMyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BN9PR11MB5258:EE_
x-ms-office365-filtering-correlation-id: 0d4a1a2f-94d9-4675-b6fc-08daf331454d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vunGmNtfj3HCIM6Krpsin/5ryN1cHShHZG9R5M8FVmhlYg/zCQ+a1UvxkrHP7cD+MI/xnqycFMH9m0vk4DBGyBuffgao5/m88BHZRY0Q/aWF7hih506q9JAFzizHKe4Mw5FiRC7/FSRzILhzH8EGl3gnj/yrgxS2Csa0N9xV+gJq18EBqEPVKBJEUCM3wnqp6PIC0eAh5dz/uqyAUUYX+mYGK5n5qaz+zRDAuJHhnBIGph/2uWND78Sw2BI/qloHiwJMhMUD01OUUNmq8gaR0WuzZpNOlNbsSJdpyrRReHWSrL/EXn6wVrRxBd8dy0bF6jv1FulOzVpujRh8XLM4pnXyGjHunnqNAhk3qu7XZQMclV9uYYWBgmDMOF6hXLfh66M8iYixFAINLVa4F9NOriWtNDZbyi03WLLONzBv8YOLMAz6WYojanOtlZbuDBKt6vKv0BW6bz+EBNcGbYn4bLBl+/kTagrmHYoXXanUmdV6RX5wOX8hVL97tTRiXGhNu12Vl7pwmx99eMF5bzTh9gipMFd6cZNrWqMwLv2PpkiHmrVROBrGCzhR44AimMm9lANxQwz6mW5I2jkZ1Ui2Yt0bHWIYa3wecFepTTFY+YypTln19mMX3mjqosCxr1o62NZyeMK52+sGIMm1L4jeBorP6Di6SnIYCEtr1ZeXoP/HULYRFwcovPilCTOM6KsKhJ88UzCdWXcZ0P1ZaoQQAMmlpZn2eyYphsLvxnJKgms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6506007)(82960400001)(38100700002)(122000001)(2906002)(478600001)(6486002)(7416002)(2616005)(4744005)(8676002)(186003)(26005)(6512007)(71200400001)(5660300002)(316002)(8936002)(36756003)(38070700005)(86362001)(41300700001)(66446008)(4326008)(66946007)(64756008)(76116006)(66556008)(54906003)(91956017)(66476007)(6916009)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHRBTFk5Q2FEcXlMRnZSeDlNMlNFemt6RU9Xckxpb0tsS3dOL3FnWlhTUDFn?=
 =?utf-8?B?SFV4MUFGZkNLR1ZMdDFwNWZNb0QxSlJwdVpicHJabHJVVTdJVkxycXg2NHlx?=
 =?utf-8?B?R1Z0M0ZXMnJieGNOdHYyMjNrZXJQalR3NUtxd1JNbytaRkd3UGlLODQ5QUpk?=
 =?utf-8?B?SUJMT1lSVzIyQktKeDRvdFZTM1Z5ZGVIWERudTRlRHU3aTF3Z056eWI0Zjkv?=
 =?utf-8?B?TGYwY2ZzZXJoLzRsYXBRTlFBa0lKMHlwYk5DdVhXSFVmbENiaUpXQjVSdmQ3?=
 =?utf-8?B?OG5ndlMySW5wK25LUEExN2FUamJvSlE1WXdjNDlNZlBBNWZBam81TThxaXg4?=
 =?utf-8?B?S2ttRWhxQ0lDOXo4VThERWp6ckQ1MEVGbk9SYmZhL01jTUlobld4WkRIYVNu?=
 =?utf-8?B?SWxnajJKZ08waW5XQ1pBalNQOVUydkEvdTVpdjBBMllpczg4emVvZG0zaG9P?=
 =?utf-8?B?dkNpZVFRQUtGU25zeUVKcGN0UlJaNEdDbWh6Q1grd3pJV2w4OW9mWng4RDJH?=
 =?utf-8?B?RHYrbmlqQTlHTGxGL3NYbHNST2l6VFRPYVB0L1NJTktwNTByeWJyRkJxblc2?=
 =?utf-8?B?RjZRcHdXOG44WFo0Si9yZGRRaUkyd3ZqZGlLM1dLQzM5bmxldkJNRTY5OHZq?=
 =?utf-8?B?UldsVEZTT3AzU0N2aStEelVYc1g3SHBqNnpLT1lteHdQY0Jobk1wTXZ5bkQ2?=
 =?utf-8?B?RmtYRmI3QUlpQWdwTjgwTHFCNVJuYlBtS2MxdGxOd2VWaWdsY0dueU9oNzRa?=
 =?utf-8?B?OFViWnVMU1dpYWE4UXNKOHRxVUZsQllCSlZteDkyTkZtREQ3NVY3Nll0ZWRS?=
 =?utf-8?B?NG0yd1N1d2FBYlBKNVA0NnUvS2ZMSnhPUkcvL0ZtRW90ZnBBY1hPTVFydnEz?=
 =?utf-8?B?RXR2Q3pGWnd2RVpvWXIzS2ZTWEpyaVVheWI2M3V2bFJTdmQxZVk4MzVRK0dH?=
 =?utf-8?B?YlBNWjlxK1FjVkJZK0NXSW1zTzIvUTFxZjlPcHZOTUF2QURsWDR5b0Fia2Zh?=
 =?utf-8?B?VjBYVXJES2lYa0RTQUJoekM3YjFGeEtxTEk5Ni91LzdacUk2d1B3TE5pTjh0?=
 =?utf-8?B?VVVBWFBHWUl6Qk1HSyttUExuRDVSNytFaHhQL0FackhOYU81ejArQWd2K3BG?=
 =?utf-8?B?eVV1alEwUFlRVUZzbWVVQjd5akZQM2wvNnNIRkZJcHoyMVhacURVWTE1S25o?=
 =?utf-8?B?ZnVkMWlnU1VZdXZPb2xzZlYvR09JRklMZzFDUEV2Y1J2TFhwbThKNFMrN01T?=
 =?utf-8?B?S3RrbHVRUHE5WjlIQU9FSVdNVnlVTEx2TitXMWRVYUt5OGFXN0FuU3huUWV2?=
 =?utf-8?B?eXczSit5WUYwdEpnWWhSemh4RGlNcVIwblUwaDhHelZBTUZHQVUxcExNN2Nk?=
 =?utf-8?B?OHVCbmZUREFMV3dvaDdHQ1Z4RGY4dHVLdjRRMXBCMHRVbmVVUVhYWXJSZGFq?=
 =?utf-8?B?V1VmcnYvWVo3VzloTmVOTVRrbFFXZ2JuODhFbUx6N0NJbWNGeGVVNjFUR3JI?=
 =?utf-8?B?OHJHV3JpaW1nS05zMDJ2MjlPUUFiTFJoWVRvbTErQytidmxyekpGWGxENXFy?=
 =?utf-8?B?Tjd5dmxqVWprZ2JqZjZDMDdNL1BHN2QvZVRvNkU0OXJ1RDJkaDVwUExSTDh2?=
 =?utf-8?B?Y2d2NDFXT0tZMy9iMWdoa0phT2tqNGlrQm52RklRb0FHSWVibGl1WXhYRWZG?=
 =?utf-8?B?aGhpVm1mdlViWHRUeThyTkc1Tmhoc0dzRlNQN0ZCQnI3T1FEUndraFlINVZH?=
 =?utf-8?B?bHVDeXlNaHpmOERHV0JWNFhwMnlaNEhSOFNsY0szRlBlcFNnbWo3TWZxdkIr?=
 =?utf-8?B?a0d4UzFNZXNLeU56R0dDMDlkVmtBWlNDOXRDSDBDcmRmNkkxKzYzUFIzbUNz?=
 =?utf-8?B?NnMrRWZ6aWpqWTczR3VWVGxudWZFM0MrNUFENTM1ay8vUnVzdUd3MUxFaitO?=
 =?utf-8?B?a1dGL0YxQWtlbUhkNXdsTUJxV2tGZjhUaVRaRXhMYUFMN1dOSTRpNTVNa3dS?=
 =?utf-8?B?WVQ0SGpWMGs0SFdzYStpSGp6K09PT2V3QnpQMGg0ZHI5RVlNWE5FTTRVdUpY?=
 =?utf-8?B?Y2UwUTFMRjR4SldkczQyWnQrTStsRGVWalZuYjBIS2ZqNXhDYXVScnYzUHZw?=
 =?utf-8?B?VzJCTlhrREw4YkhWaFpDYzVzUnVYRWlUOGQ4cEdjUm5qeXFIaTVrd0NHeG9s?=
 =?utf-8?Q?u1uAIXI4Mq09kxwT8QpOkCw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79DF5F7B70596642A0B306EABBA8E3A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4a1a2f-94d9-4675-b6fc-08daf331454d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 17:36:56.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRMq1W9uBaRWFFNrkj9G1MVybcXyuw6hajL8tuMjWEThYslRFPcTiWJ4mBRiRtGUp587/WqLT4bnVS/2yVvKkMA6aQ5FVb9RyHnGM4m/Xr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5258
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTAzIGF0IDE4OjU1ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gPiA+IE9LLCBzbyBJIGRvbid0IGZlZWwgbGlrZSBpdCBpcyA2LjIgbWF0ZXJpYWwgYXQg
dGhpcyBwb2ludC4NCj4gPiA+IA0KPiA+ID4gUGxlYXNlIHJlc2VuZCBpdCB3aGVuIDYuMi1yYzEg
aXMgb3V0IHNvIGl0IGdldHMgc29tZSBtb3JlDQo+ID4gPiBzaWduaWZpY2FudA0KPiA+ID4gbGlu
dXgtbmV4dCBjb3ZlcmFnZSBiZWZvcmUgZ29pbmcgaW50byB0aGUgbWFpbmxpbmUuDQo+ID4gPiAN
Cj4gPiA+IFRoYW5rcyENCj4gPiANCj4gPiBIaSwNCj4gPiANCj4gPiBUaGlzIHN0aWxsIGFwcGxp
ZXMgZmluZSBvbiBib3RoIHRpcCBhbmQgTGludXMnIHRyZWUuIElzIGl0IGEgZ29vZA0KPiA+IHRp
bWU/DQo+IA0KPiBTdXJlLg0KPiANCj4gVGhhbmtzIQ0KDQpJIGRpZG4ndCBzZWUgdGhpcyBwaWNr
ZWQgdXAgYW55d2hlcmUuIE5vdCBzdXJlIGlmIEknbSBtaXNzaW5nIGl0LCBvcg0KdGhpcyBleGNo
YW5nZSB3YXMganVzdCBhbWJpZ3VvdXMuIEkgdGhvdWdodCB5b3UgY291bGQganVzdCBhcHBseSB0
aGlzDQpzZW5kIG9mIGl0LiBEbyB5b3UgbmVlZCBhbnl0aGluZyBmcm9tIG1lPw0KDQpUaGFua3Ms
DQoNClJpY2sNCg==
