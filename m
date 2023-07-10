Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E2D74DCE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjGJR6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJR6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:58:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECEAAB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689011893; x=1720547893;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7dIgZHeh6TERHLWNQ2R2mcojw0etPkxEc0ym9dGsKAQ=;
  b=bFqOpz8q8FBNZmkEKeHqpgsXiGFKNq2e6qS35zeKUBODjNH8YxpL0a8B
   st5dw3Nuol6CRYBnJIv1U25zW79K3OwXW+KaOImiTFz4k0Pi3V0Cigw/u
   93mgyMZ+tRDLewbWBe7jDJby/TuVjgfJjTL8ZPqh4h71lNE4/PwBO9ah2
   hPrnsZ5c8FDd0023JXg+V+2MmbkRhQ6WuX4gHKlYwTo6EoN20AJMZpqvx
   CzSl++YYGKVY6TQsIJ1AG48hmChJKy8XSX1mcu9Fa6baZEP5wMPvZ5IUD
   Z30S9R7QTD1cSjXqkq+BbV6dNddRqAx1C6B7E9izzVdmVU7csYlfgeaJj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349220851"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="349220851"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 10:58:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="750425759"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="750425759"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 10 Jul 2023 10:58:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 10:58:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 10:58:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 10:58:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW975U7kTKMAvOiqxlcm/OqaKjZoOMvQFprNWt26IdqkdA8sqmhCm4mMXG4DH1JGjm3Gek0UsJ7Sw6OgWM8VERENNA/ZjWfLO1AIVKz8rG+R0YZ7QTera50b3mRVvAgPACKL2bIvozeAVyMjwYQKuAHdrNlqSDGp/AqSu7hK7X+kVw0exde5s6wy7lUNHhClrPq/xJMXw4eGIH5P4kGM+ItmbcQN3WwMjUJNzReqF2x4Jys3et8VfbqUwIPE2F1xxBtew/8Y2VzgsKkB64YfMRRExDAZ43HoUaxnT2IgkPlG6yEAP7xlgn0fJfhsVq8HmnUPKIfyr6HRa0SXfjvZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dIgZHeh6TERHLWNQ2R2mcojw0etPkxEc0ym9dGsKAQ=;
 b=MQzk1PHzeJyUl5eG9JBb7SbbdpuAnzy2T6gpR6oyPgd6nttu9AvFGUflpLFk4AtWNFHBcyHTOSm77NJLdo0/9RLHzaCnn/jSZaKm2Caknwyuaytxj9laV+ZOZ/Wm83Wnkx6PTtPVJPEHe5/jndGkmQRed004lUH4DTW0b0OITO7NmZjrSx0Es+Ez2A8F+SgeuBUpsXDmp5GbtX+R2f/9C6dUs+S4/F53GIMrN/XCZytwaGhgy9+wEOsy1Xh9a2675NwH0N1djYXXmSuAlzJMtwf8ZEbHqadFc6+D5ASCq22FW2iBZFWxEVPSrII6t/P0BaoA8a6+4qvrva9JEQ9SLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB8599.namprd11.prod.outlook.com (2603:10b6:510:2ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 17:58:07 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::ac6b:a101:ff02:a1bb]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::ac6b:a101:ff02:a1bb%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 17:58:07 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "janusz.krzysztofik@linux.intel.com" 
        <janusz.krzysztofik@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Gross, Jurgen" <jgross@suse.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Marczykowski, Marek" <marmarek@invisiblethingslab.com>,
        "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3 RESEND] x86/mm: Fix PAT bit missing from page
 protection modify mask
Thread-Topic: [PATCH v3 RESEND] x86/mm: Fix PAT bit missing from page
 protection modify mask
Thread-Index: AQHZswGMYdZ4juw/r0GrWBRLTXdpN6+zSiUA
Date:   Mon, 10 Jul 2023 17:58:07 +0000
Message-ID: <9c14a3597d658a065e853b6e5f64ff21b4b7b575.camel@intel.com>
References: <20230710073613.8006-2-janusz.krzysztofik@linux.intel.com>
In-Reply-To: <20230710073613.8006-2-janusz.krzysztofik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB8599:EE_
x-ms-office365-filtering-correlation-id: 7bde0d71-4059-4488-0227-08db816f376a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ib3Af+ab7/+lmnLiPMCNio/tnCrpJRT3E3YROw8EYwXGH3qPZmH/niB81W9jli01vvWkPQ5xZD7LDKdPCexq73sukBp7KQIp0VDB8D+FhEFva3P3l3MqsVLKVoyqujnZr6AS1SGJZ69Q4x5nmDC9tQAkVdULQXKIYU4hg8U66d3xK2ILD9aA7S5Q3wYerSYEFyIDh+Wk9mUFjIEGhzicuXQd2beRA9VdadsX+Lck/9MKgQUQPm+t+HNhCKQwcbQe/PjS3Ib76Yp2CB9uYHknAv3oE0m0Y29Yp+poVmrSkE7SdhzRbw+CacnROY9Ktm0oqx8HFAIUy2Dkko7oR4hx4PsYXAt1+QqqkPl0nT0KcoLkgI+bf8VESaAEwJeRgQEzo3yOmKP4mSxtffuV8i8h6gUVfD+oPLmDS6oHwkT4a8edC/JgrtSqrV/rbaASyYWrjXLwFKWExq4PAu+FuSXrN6vHR5NXe4Kn0QigYrAOkqGBrtSDQUX3VsxSOGAy2hICUAo4i4I8Eeq5oxevULBBtdimaP0WLOhFyMKP9HTGfL8cKSKd8j4P/71bPPpPLFjzURLA//epTlHqZ/c2Jwga3rPFRvwukg80JlzTBoYK9qmh/jAE8qk/HCzWOVxShClQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(86362001)(38100700002)(38070700005)(82960400001)(36756003)(71200400001)(6486002)(54906003)(110136005)(76116006)(91956017)(122000001)(6506007)(26005)(186003)(6512007)(2616005)(7416002)(5660300002)(66556008)(316002)(2906002)(478600001)(66946007)(8936002)(66476007)(8676002)(4326008)(64756008)(66446008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0dTb3pNU0hUVTZnbm56K1hzRmYrcDhnSExRVGNKTDFUZXZhZWgzK2Z0RjA3?=
 =?utf-8?B?SVVpNWVsTDFmb1lubUs2WXM2T1NxS1JrcFZkTWVHWjk2Tk9WaFJqZ3JuUEZu?=
 =?utf-8?B?ckpGSFRZTTBieHdma0lTT0EwbUthWUZHa3V2UHlXczJBblNrQXNLZWFoa3FJ?=
 =?utf-8?B?MFhuUnFkQTFsYmVyc2RVY3hlbU5HeVEweU1SQmdycDh0WCs1aFNUaUZ5ZkNU?=
 =?utf-8?B?MWY1K1pUNXhTUWxGUVhKR3dSK0xqMFQrYXYyWW5zTFNsSU9WV09lUE5VNlBr?=
 =?utf-8?B?S2hGcGJNSGJucE5UVmMySTMxYnZ4YUJoTkdWT1NwTmxhZ2R3cFNxZlE5VFY1?=
 =?utf-8?B?My9vM0U3VGV2ZUZoRXR5NHNKaTlKWC8renluRDIvOG9EMFZBK0RSNGU5cklj?=
 =?utf-8?B?eG8wWFVrUTZvMi8rajlZODJKaDJxY2JXc2tNQmczbVlTUWxkWUVub2RYZFgy?=
 =?utf-8?B?aVNLWmQrY2l5bjd3ZFVFdFJuaGd0SFhQQkJacUNpa3Z1K0NwR1phekdKYVRD?=
 =?utf-8?B?N3FzTmh3U0FUZDFOTUR6M1ZDaE9CYmdxTkR5V0pldFdXVDVwbU40cE41N0Zq?=
 =?utf-8?B?WDVIVjBBRSt0V280d29jbG1zeXRsUEh4QnZYUmJhazlXMmpjb2lnTjVwbDMr?=
 =?utf-8?B?Y0hvUkNGcVlKNHJCN3hESW04bkVwem9FSnBiTHZQWU40QWwzc2tORUJOWUVi?=
 =?utf-8?B?SkVta2Q1Vlpza1VaU0JkVzkxMHYrWmxJZUx1eXd2Z3l0bURmNmtQeHdrdWxy?=
 =?utf-8?B?Qm5xUHNodkdFSzl2bTNIVzljZTVmRjUwRWxxSmw2UnpQUVhJWUlZeG9NSHpm?=
 =?utf-8?B?d0Z1THJHbXN2ZHhzQTZ3ZXFJYlJQYlNleWo3T2pHRXFEejJybTF4QTkzRUdF?=
 =?utf-8?B?Q25JUk14V3QxbkxGai8wcytmYkxPczZNTVRhSDBnM2x3N3dXcEY0czJ1ZEJE?=
 =?utf-8?B?cnFYTkRZMHF6U3JxWG9sMXF0RGZBMGdtZjZvMFBwbWNRT3Z5SEkxdUdDdkw2?=
 =?utf-8?B?d29YSGF2akY3Wkk1WG50MXV2TUN0aWhPeW8yT21NUkxvWGUrQkxYNjBwYUp0?=
 =?utf-8?B?ak1ZK3hPMUtZYmk1SmVheGs2aEdXa1paWWIyczAxekZLVTBGbTlZVkxVQzRO?=
 =?utf-8?B?bjhMd0E0aDl2cC82b1BWRVROQlltZnRUcnVPditpREFHWk5GbTg5ZERKKzNl?=
 =?utf-8?B?SEZLaG5xVVpMUFM4SGFIb1NpZm9QYjBsZW1sK3d0QU8vYnRJQlZEQ1BQb1kr?=
 =?utf-8?B?a09HNE5yLzYyMFEyWlZ2UFh4SHRXWHRKY3plcUh2WWtkb3RWcjRTUjhBdk9S?=
 =?utf-8?B?aXkzR2I4ZVJkQXMwaXNtVDVGb3NyZm9hdkFiKzBSVGkvWVU4YVlzaFBoWEdY?=
 =?utf-8?B?dm56bHpnN0dWbDZMeDZmTzhYbTFHYWNiWGs4NDc0TEl2RUV2RGpPMVdBSE5S?=
 =?utf-8?B?TnREZE5xdlpseGtsMWNhcDBpYzJuOTNnYlpWT1E1bUlJeVVmMmNwZkM2cmoy?=
 =?utf-8?B?eEUrWDhOOU11aENTK1gzZlBkaXkvYlg3MXN3M3dJZDJEaGExS3ZEYkl4VnV0?=
 =?utf-8?B?VnRBM1lXbzdJandQU2dqcDJ3ck9EU1lSSXl6eEVvUndVZ0E3ckZKYklwYTli?=
 =?utf-8?B?N1dTYWFBTXlqb0pCZ25POXNQdTJmc2NncTFLdlZVSnVxQ1B0M1A0R0hxTkwy?=
 =?utf-8?B?S20wNmtleUlUTlZGU0ZJcXl1LzBEaEZsV1o4a1FXSjJRN0NJY2Nqb0FsQmVp?=
 =?utf-8?B?UHhxbjl6M1ozZ3U4V1BrWUN3T0JnQ0lqeTk4MlpnZkVFVmQ3NGxCMTdUU3RL?=
 =?utf-8?B?YVNZYm5XU0dmVk9wendKb0xEdHBwOVVvU0NlaXZVaWk2S2JxaWsyVUc2aklM?=
 =?utf-8?B?QnJ3dzczcVZ0SjhWWThWZWxQV3cwZHJlVXZvUDBJSElVSDBDVnNHOXFORnl4?=
 =?utf-8?B?YkRBWjJRWXdsaU9CbldCejArbHlrdkZaSFNIdVJjNnZxQXB4QUdzekZub09C?=
 =?utf-8?B?SEViQm9DVE9Hc2dyZEg1cExyQjVOWkZRaEJtNjg5NFcxR1E3U2ZWcFAyMWhE?=
 =?utf-8?B?bU84MjJRRStaUTNTSUFyeTFLdUMxNElDWFE5UnBvdC9KL3lFWDJSTXJuY2Iv?=
 =?utf-8?B?RTNEcmRLN1EzUUlDV1hXR3lLZ0loR0xQZ1lwR25oSU1DSTNWRDMxcmViNFpw?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F24461B297535444BDAD158B8E476CB7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bde0d71-4059-4488-0227-08db816f376a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 17:58:07.3524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiYUEHsv9AvcbDNQA4NCCtsISbILDwFoyq1ZlZyA9hBBUAGv3oYXUMHUvhDcF0KcLfwHdsr21SZwImQurDogYCNz4IkNsH9ADRI7DVx2VJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8599
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTEwIGF0IDA5OjM2ICswMjAwLCBKYW51c3ogS3J6eXN6dG9maWsgd3Jv
dGU6DQo+IFRoZSBpc3N1ZSBuZWVkcyB0byBiZSBmaXhlZCBieSBpbmNsdWRpbmcgX1BBR0VfUEFU
IGJpdCBpbnRvIGEgYml0bWFzaw0KPiB1c2VkDQo+IGJ5IHBncHJvdF9tb2RpZnkoKSBmb3Igc2Vs
ZWN0aW5nIGJpdHMgdG8gYmUgcHJlc2VydmVkLsKgIFdlIGNhbiBkbw0KPiB0aGF0DQo+IGVpdGhl
ciBpbnRlcm5hbGx5IHRvIHBncHJvdF9tb2RpZnkoKSAoYXMgaW5pdGlhbGx5IHByb3Bvc2VkKSwg
b3IgYnkNCj4gbWFraW5nDQo+IF9QQUdFX1BBVCBhIHBhcnQgb2YgX1BBR0VfQ0hHX01BU0suwqAg
SWYgd2UgZ28gZm9yIHRoZSBsYXR0ZXIgdGhlbiwNCj4gc2luY2UNCj4gX1BBR0VfUEFUIGlzIHRo
ZSBzYW1lIGFzIF9QQUdFX1BTRSwgd2UgbmVlZCB0byBub3RlIHRoYXQNCj4gX0hQQUdFX0NIR19N
QVNLDQo+IC0tIGEgaHVnZSBwbWRzJyBjb3VudGVycGFydCBvZiBfUEFHRV9DSEdfTUFTSywgaW50
cm9kdWNlZCBieSBjb21taXQNCj4gYzQ4OWYxMjU3YjhjICgidGhwOiBhZGQgcG1kX21vZGlmeSIp
LCBkZWZpbmVkIGFzIChfUEFHRV9DSEdfTUFTSyB8DQo+IF9QQUdFX1BTRSkgLS0gd2lsbCBubyBs
b25nZXIgZGlmZmVyIGZyb20gX1BBR0VfQ0hHX01BU0suwqAgSWYgc3VjaA0KPiBtb2RpZmljYXRp
b24gb2YgX1BBR0VfQ0hHX01BU0sgd2FzIGlycmVsZXZhbnQgdG8gaXRzIHVzZXJzIHRoZW4gb25l
DQo+IG1pZ2h0DQo+IHdvbmRlciB3aHkgdGhhdCBuZXcgX0hQQUdFX0NIR19NQVNLIHN5bWJvbCB3
YXMgaW50cm9kdWNlZCBpbnN0ZWFkIG9mDQo+IHJldXNpbmcgdGhlIGV4aXN0aW5nIG9uZSB3aXRo
IHRoYXQgb3RoZXJ3aXNlIGlycmVsZXZhbnQgYml0DQo+IChfUEFHRV9QU0UgaW4NCj4gdGhhdCBj
YXNlKSBhZGRlZC4NCj4gDQo+IEFzc3VtZSB0aGF0IGFkZGluZyBfUEFHRV9QQVQgdG8gX1BBR0Vf
Q0hHX01BU0sgZG9lc24ndCBicmVhaw0KPiBwdGVfbW9kaWZ5KCkNCj4gYW5kIGl0cyB1c2Vycywg
YW5kIGdvIGZvciBpdC7CoCBBbHNvLCBhZGQgX1BBR0VfUEFUX0xBUkdFIHRvDQo+IF9IUEFHRV9D
SEdfTUFTSyBmb3Igc3ltbWV0cnkuwqAgRm9yIGJldHRlciBjbGFyaXR5LCBzcGxpdCBvdXQgY29t
bW9uDQo+IGJpdHMNCj4gZnJvbSBib3RoIHN5bWJvbHMgdG8gYW5vdGhlciBvbmUgYW5kIHVzZSBp
dCB0b2dldGhlciB3aXRoIHNwZWNpZmljDQo+IGJpdHMNCj4gd2hlbiBkZWZpbmluZyB0aGUgbWFz
a3MuDQoNCkkgdGhpbmsgdGhpcyB3aG9sZSBlbnRhbmdsZW1lbnQgaXMgYSBiaXQgY29uZnVzaW5n
LCBidXQgbm90DQpmdW5jdGlvbmFsbHkgYnJva2VuLg0KDQpUaGUgcHJvYmxlbSBpcyBraW5kIG9m
IHRoYXQgdGhlIGV4aXN0aW5nIGNvZGUgYXNzdW1lcyB0aGF0IGFsbCB2bWEtDQo+dm1fcGFnZV9w
cm90IHJlbGV2YW50IHByb3QgYml0IHBvc2l0aW9ucyBhcmUgaWRlbnRpY2FsIGJldHdlZW4gUFRF
IGFuZA0KUE1Ecy4gVGhlIGJ1ZyBpcyB0aGF0IF9QQUdFX1BBVCBpcyBub3QgdHJlYXRlZCBhcyBy
ZWxldmFudCwgYnV0IGl0DQphY3R1YWxseSBpcy4gU28gZml4aW5nIGl0IGJyZWFrcyB0aGUgYXNz
dW1wdGlvbi4NCg0KTm90IHRyeWluZyB0byBzdWdnZXN0IHdlIHNob3VsZG4ndCBkbyB0aGUgc2lt
cGxlIGZpeCBoZXJlLCBidXQgSSB3b25kZXINCmlmIGl0IGlzIHdvcnRoIGNsZWFyaW5nIGl0IHVw
IGZ1cnRoZXI/DQoNCkkgdGhpbmsgYXQgbGVhc3Qgd2Ugc2hvdWxkIGluY2x1ZGUgYSBjb21tZW50
IGFyb3VuZCBfUEFHRV9DSEdfTUFTSyBvcg0KX1BBR0VfUEFUIGFzIHRvIHdoeSBpdCBpcyBhc3N1
bWVkIHRoYXQgdGhpcyB3aWxsIG5vdCBjYXVzZSBwcm9ibGVtcy4NClRoaXMgd2F5LCBzb21lb25l
IGluIHRoZSBmdXR1cmUgY2FuIHNlZSB0aGUgZXJyb3IgaW4gdGhlIHJlYXNvbmluZyBpZg0Kc29t
ZXRoaW5nIGNoYW5nZXMuIFdvdWxkIHNvbWV0aGluZyBsaWtlIHRoaXMgYmUgdXNlZnVsIGFuZCBj
b3JyZWN0DQpyZWFzb25pbmc/DQoNCi8qDQogKiBCaXQgNyBoYXMgZGlmZmVyZW50IG1lYW5pbmdz
IGZvciBQVEVzIGFuZCBQTURzLiBPbiBQVEVzIGl0IGlzIHRoZQ0KICogUEFUIGJpdCwgYW5kIG9u
IFBNRHMgaXQgaXMgdGhlIFBTRSBiaXQuIFRoaXMgY3JlYXRlcyBzb21lIGNvbmZ1c2luZ8KgDQog
KiBlbnRhbmdsZW1lbnQgaW4gY29kZSB0aGF0IG9wZXJhdGVzIHBhZ2UgdGFibGUgYml0cyB0aGF0
IGVuZCB1cCBpbg0KICogYm90aCBQVEVzIGFuZCBQTURzLg0KICoNCiAqIHZtYS0+dm1fcGFnZV9w
cm90IGlzIHVzZWQgZm9yIGNvbnN0cnVjdGluZyBib3RoIFBURSdzIGFuZCBodWdlDQogKiBwYWdl
IFBNRHMuIFRoaXMgbWVtYmVyIGlzIHNldCB2aWEgdm1fcGdwcm90X21vZGlmeSgpIHdoaWNoLCBk
ZXNwaXRlDQogKiB2bWEtPnZtX3BhZ2VfcHJvdCBiZWluZyB1c2VkIHRvIHNldCBodWdlIHBhZ2Vz
IGFzIHdlbGwsIG9ubHkgZmlsdGVycw0KICogYml0cyB3aXRoIF9QQUdFX0NIR19NQVNLIChhY3R1
YWxseSBpbiBwZ3Byb3RfbW9kaWZ5KCkpLiBUaGlzIG1lYW5zDQogKiBieSBoYXZpbmcgX1BBR0Vf
UEFUIGluIF9QQUdFX0NIR19NQVNLLCBfUEFHRV9QU0Ugd2lsbCBhbHNvIGJlwqANCiAqIHByZXNl
cnZlZC4NCiAqDQogKiBUaGlzIHNob3VsZCBiZSBoYXJtbGVzcyBiZWNhdXNlIHZtYS0+dm1fcGFn
ZV9wcm90IGlzIG9ubHkgYXBwbGllZCB0bw0KICogbGVhZiBwYWdlIHRhYmxlIGVudHJpZXMuIElu
IHRoZSBjYXNlIG9mIF9QQUdFX1BBVCBpbg0KICogdm1hLT52bV9wYWdlX3Byb3QgYmVpbmcgaW5h
ZHZlcnRlbnRseSBhcHBsaWVkIHRvIGEgaHVnZSBwYWdlLCB0aGlzDQogKiBpcyBmaW5lIGJlY2F1
c2UgX1BBR0VfUFNFIHdpbGwgYWxyZWFkeSBiZSBiZWluZyBzZXQgb24gYSBodWdlIHBhZ2UuDQrC
oCogSXQgaXMgZXhwZWN0ZWQgdGhhdCBjb2RlIHNob3VsZCBub3QgdHJ5IHRvIGFkZCBfUEFHRV9Q
U0UgdG8NCiAqIHZtYS0+dm1fcGFnZV9wcm90LCBzbyB0aGVyZSBzaG91bGRuJ3QgYmUgdGhlIGNh
c2Ugb2YgaW5hZHZlcnRlbnRseQ0KICogc2V0dGluZyBfUEFHRV9QQVQgaW4gYSBQVEUuIFNvIHRo
ZSBzYXZpbmcgZ3JhY2UgaXMgdGhhdCBQU0UgaXMNCiAqICphbHdheXMqIHNldCBvbiBQTURzIHRo
YXQgYWRkIGJpdHMgZGVyaXZlZCBmcm9tIHZtYS0+dm1fcGFnZV9wcm90Lg0KICovDQo=
