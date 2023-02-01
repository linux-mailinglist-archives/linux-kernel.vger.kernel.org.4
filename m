Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA22C687080
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBAVfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAVfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:35:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480D739BA4;
        Wed,  1 Feb 2023 13:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675287300; x=1706823300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6B4MaqNQG5xuO56wJUw9yve1mc3BT7qV/W3lUMhPX1Q=;
  b=N+yJUSorulo8tKzbnWjsqk5XGCrK/tj36Aa6J0iZhDqJZetClGQg4/6h
   LSJk3p4cdqVWJoOyuXp8KzSnKovE+wgBWswapDFr7KOWWjHz1UxSrf0MV
   F0F+Qo1FIkqi3M66YA/aZ/o0Z9QO6OjpVSBPtn439a5+nuJfC17G5PL/w
   sBaha/2vWGpuqMCbYeZ5QZO2AXtbDw5rLOzUKZbAzKdQ+MyWw/eZxk/77
   WpMwAyrmaRgMYFo/h8SyIhKEaVN1jNWuYrSEOdUTLzWCEu09XrmiW9D5A
   8kfF50W3DixF+eSTe7MCY+VY5ZmzXRILAJUpNFtYodMlrWYV/o4OFFq+P
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355615095"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="355615095"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 13:34:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="658482252"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="658482252"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 01 Feb 2023 13:34:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 13:34:58 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 13:34:58 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 13:34:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4kAeadvG5WliG3fKUhmKy9motwO6CApg2rSmGLKcOz7dNY/Iq9JJGxlRNwrUgRFLJnm3bZ6SNrWeUWhHl4y6iqchg8ObroiIwK9s3QVL6JQZpNoTI9hL012/dyCP2WumuUXMqnIoMD1OlotECYTf/sV6ACNN1GY92QjvgrGgA1z5fn4hPTo+xeYICiuo9PpcGM6w1zaKT/ohgSo56blZnVvry+nF9GCxZQgYK9Ci6XUx/6P/eTcy9h94aZ5u5gUWKrpjZZe6O7hMFxRTNCEknE3gHg6BmZ7zpSH+hu0jeA6zqslFamb7Qt4vEMF6WTMVOiZe4BiV2OgAdzPTm380g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B4MaqNQG5xuO56wJUw9yve1mc3BT7qV/W3lUMhPX1Q=;
 b=R1ZLv2ulVoCtom6mEr4ZiRO/BiCdR8f+Of7zGI8HaSGhe4VElQwRjQAjcLbtrUgUbQ2dT49MDTwwdJMLA4jNd5jGzWncSd9IIGzYFzDFBfEsE6hCbGrymrXPeYnmb01HHFliHYbIXnEjx1GHkVOPVo3U/+6B5jMIyYac16YE/f+eJtA3mxhX4SfzuFwCGJzuST+UMheoTCB31S7vtYHvib2ORUCJS/NjQhQhDTUJP9ztqth6jOEZwH7tSlpmeiOJ5bYW6ft8ZjyxqEOQBOcD6NfDs2G84pvrTzY8Uhj1by9aYGHdJiXQLJqvI4IwoATEVZH2A+g6mhYSJ3PVNbhmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB4973.namprd11.prod.outlook.com (2603:10b6:a03:2de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 21:34:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6043.030; Wed, 1 Feb 2023
 21:34:55 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: RE: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Thread-Topic: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Thread-Index: AQHZNc4J4EU3Q3ktD0OwChsEsRbA+K66f+8AgAADG4CAAA6sAIAAC0rQ
Date:   Wed, 1 Feb 2023 21:34:55 +0000
Message-ID: <SJ1PR11MB60833440D921F960C62677ACFCD19@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230131234302.3997223-5-jithu.joseph@intel.com>
 <6a675f9b-2bbb-9317-2015-0b3362e49fdc@intel.com>
 <c04c1aee-b84c-324c-e7db-c004e778ef4e@intel.com>
 <ee97e1d6-5a21-2c5c-4fdf-05e2700e94cc@intel.com>
In-Reply-To: <ee97e1d6-5a21-2c5c-4fdf-05e2700e94cc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB4973:EE_
x-ms-office365-filtering-correlation-id: 64364611-7d74-430a-288e-08db049c291c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yR3h32jUN9e61Ciz2XdamAz6WCNwqpwVmrbaMEDtUKHcmSiw2xY7oy5qZHQEgOoCIbSrKwvIKxWSkvAW9vO2O9DFVJKPIEXFVRyI3rl+ZnixPpIqapFlxA12/CEYkTEPV1p2f2XcPYdEkuXu+pjWjEwMxJrzLqRnjVxMBuXR5SK9TM6xNdRmsp+1xJbwUhLpYqfIFy1J+bK2XJnenpMWgYweTZ6maly0/g4FWQQV6VYYV3R07vKpHgjwefOUb9PNN5O0uHeF9jYkc5eCP+3YZvNXyw2/YX1FOJM98EYvVIQuH16UiupAr8fLcboLgEwdG8wiE/zVpf9hEw+kM+OXWWF76nrXqD5NVELjVSR5WevNpJYgbZClv56wUkoCAwZ88wgP2dooW6/GU7xVBiAk7EyMACpmBaSaToDHbaSI/MW4BYki2bRSM0do1cdpyVqIHtvUWB2p1AXZ33h4biPuGcYCjCAACwKx4+iyVN63XIxTBMkQWyLCXZx5pV8C4mVl6uamdKPCcrPZ9ET+te8jkBB/rHBeR1DF6hjerlz/hASjLUJJhTo3l35KPB0hcL3Q3BtPng+yTFPuBLr92MgR9WenOAljS4LOXOdRrgPGja37Cn3mV2C5YErXGNKzzMxkwiDOjJxOGYcU40qcf7YIpAmxkPbK3c4J6uGrKjsddLd37wboyO4JsgevMTjaQkya
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(6506007)(9686003)(7416002)(7696005)(4744005)(5660300002)(71200400001)(26005)(186003)(110136005)(316002)(478600001)(54906003)(76116006)(64756008)(8676002)(4326008)(41300700001)(52536014)(8936002)(82960400001)(2906002)(66556008)(66476007)(66446008)(122000001)(66946007)(38100700002)(86362001)(33656002)(38070700005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3psR2RBNE9jSmQ2eVEveGFpekdBYXk3ckMvWVA0WnZSZ3FuNFpPaTV0WXY3?=
 =?utf-8?B?NTRMdEEzaDN3SlVhT1FjZmdmSndWYythczJjcmJDWGYzOHJra3pQV2hmaDNQ?=
 =?utf-8?B?WTF3eGk0NXdYVlI4ZEZrNm83ekxJYzhicWtCWkVGZ1J1MTZOU2RSN3REUkNi?=
 =?utf-8?B?a29BR0hJMWFnNTNvS2VQQW5uYkcwa1pTQW4xc3FPZjZ4bnZvbXEveHBtQ2ov?=
 =?utf-8?B?U0ViaGNCclkwbURZSExNOCtPdVFSVkxKcTNFWEg2MkhvZFlPdDRpNGwrZTFl?=
 =?utf-8?B?VldJNVVmOWRkOWxjWlh2bVlqR21GMFdESkRjU0tnVWMrMGdrZE9vS3FMYWtj?=
 =?utf-8?B?cXFNWS9WWGxYZXFxR3BsVHluRGswZ0drZThnUzRpbDF1ckdabDdCaVV2Tjl4?=
 =?utf-8?B?KzNKTHgySnNhWnd1K0drVFZQY2VNV1IxRnlLOHlOTjR3enBRV3dxRHloNmVr?=
 =?utf-8?B?a2c2UW9taEUyaFI4TmVlNlpGaDJRSEd6dEpub3RaV2U1ZThYR3VWbkhrdWdM?=
 =?utf-8?B?WjVMT0ovWjhiL1lhNDBzOS9zbkgvSXlTTGIzdEdIbjMycStLY3BoVENQbmk3?=
 =?utf-8?B?aWR2eXNxWURnVllrVkZZV1VqZzRQTUZaU2J6dHlDRk8ySjJ0Wi9iaHFjazU4?=
 =?utf-8?B?OUZ3dU5LeWU5VXdVbGNIL3duck41NzlPa2l2Zk5mMTVEekI0WkZDTmRidFJO?=
 =?utf-8?B?YW9waC9rL28yTXRnTzdvUEVKbmVMWjNyU1Z1dnkwOG9qU0tkSkdpdG1pb1JP?=
 =?utf-8?B?NVp1aW5wZ1Q5V1R1OWh4Q1dPK1RwNWtIQmwySGJaNlYycXZkc1BYRDEzSUhm?=
 =?utf-8?B?dXlpNzhGaDdYcFZoZ0JzV21TNzdsTDlwaGFYdWxFWUd6ZlhPbzFSdC82T0tM?=
 =?utf-8?B?QjErS0JubkNjSEdRR0tkdERZVTF4T1Axc050R3RSdWlqSVRodzd5RlR2ZDNs?=
 =?utf-8?B?RXJFL2w0TDFQOThWdk9RZGVudEdGOXZTRTZlV3Z5VVNzQXBDTzFBTXlpbWY3?=
 =?utf-8?B?WnltdllXTko3VDJ1UldqdnFSRE1pR3BtZVY0cjdPdWlXVDRJRzdFUThVaGs2?=
 =?utf-8?B?cDlSOEwxQ2doTFZZVHlDMkZLZFJ3RUFFRmRpZXgxUmQ2VlQrMG12bmROY2R2?=
 =?utf-8?B?QnpLQnU0ZkpBNzMwUUluSTlpUG8zSW9BNkthT3E1WkxCTXFZWlgrRFpFdnFE?=
 =?utf-8?B?SEJibU40c1lpVWpBa3RTY2ExT24vK2ROU1U2d0duQkljRlpxNDJqS0hNZ2hZ?=
 =?utf-8?B?ZGJzeTJnU1ZqNzl1ZlE2cmt4dU5oQzVlbUR4QUdPRXNpZDY0dFpZbXk4a1Zp?=
 =?utf-8?B?Z0RwMVovVW1wZzNrMVkxZUoxMGlJQmo5bGtzRk8zVStvRHpZQnlSWnVtT1pQ?=
 =?utf-8?B?RHIvVCt5c2FRWmorMlFBVmd4ekM1b3owUnNrTnJUYXNXb3ZJRXdVbkhUem00?=
 =?utf-8?B?R2NPZ2duVUs5ZUpuMXR5V0F5OE43TWwrenNRMXB5REh6WVVDUnJuUDJmK1J1?=
 =?utf-8?B?bVJMZWI5TitYNFVVRWpiNWdVbFBLTWJxZHhuR3JwRlQ1Z0dQSGcyNkVZRFlY?=
 =?utf-8?B?SFpzc01uTjByZHExK3p2WXBwMVRYTlVUY2dLYVdod1hLRmhjd09kd0lyNWI5?=
 =?utf-8?B?Y3pwV0hOYUxhQzhxNnNCNlJTWTJMNURZOUZBOUFIZWhuOVErK0Q2aitwSjlL?=
 =?utf-8?B?YmVlNjFRcnNWbzJya3Fjb0ZXRkNJVk1PSitVUGl2azVqclI0enYrUjJ1azZj?=
 =?utf-8?B?dndMdzBnUEZsVzBMa3JXK0JZSVdIQU1tdWl4SkVGMFFtNzBBN1dETXpjQlMr?=
 =?utf-8?B?WSt0Ty8wSkNBMjFidEhIMHJ3K3pYODI0U3kzSGtVaGYrTlR2N3FhK25yQ3kr?=
 =?utf-8?B?Ym1VbzNTaFdWMDFRU2VzNjZkTVFkSVpJcnlCNW9PcjBJcHVnek9UY3lTcGxm?=
 =?utf-8?B?OHZ2Rk5kcnVFZ0o1eUo3djhZQzduaHgzVXFlZExJQmZYdGExNzJPUHhnYld0?=
 =?utf-8?B?RFBFeFpMSVEzRmdlYzdKMTZYb001NVd2UmdSUCtCUlI5TTFNKzJlUlJGZC9k?=
 =?utf-8?B?bG9neVQ4NnRSSjZFakJDVjFyc0h6RUdNOU5ndTNMQ1ZhNnRsM1p1QlBKMkpX?=
 =?utf-8?Q?90aCkf/1Buec/DF7CIX9KEk94?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64364611-7d74-430a-288e-08db049c291c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 21:34:55.3540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KIoP+pAphCqCjCYXeeuLxKSMk6HE7VY7D3AGWYWlGpVpPRmn/OPTEJy2o2/yNHCsAgHXymd1ZbVuPC1HOVoLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4973
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

PiBCdXQsIHdoZW4gaXQncyBkb3duIHRvIGEgc2luZ2xlIGJpdCBpbiBhbiBvdGhlcndpc2UgY29t
cGxldGVseQ0KPiB1bnBvcHVsYXRlZCBieXRlLXNpemVkIGZpZWxkLCB5b3VyIGFyZ3VtZW50cyBm
b3IgdXNpbmcgYSBiaXRmaWVsZCBraW5kYQ0KPiBkcnkgdXAuICBCdXQsIGhlY2ssIGlmIHRoYXQn
cyB0aGUgaGlsbCB5b3Ugd2FudCB0byBkaWUgb24sIHdobyBhbSBJIHRvDQo+IHN0b3AgeW91Pw0K
DQpJdCBoZWxwcyBmb3IgY29uc2lzdGVuY3kgb2Ygc3R5bGUgd2l0aCBhbGwgdGhlIG90aGVyIGRl
ZmluaXRpb25zIGhlcmUgd2hlcmUNCnNvbWUgb3RoZXIgcmVnaXN0ZXJzIGRvbid0IGhhdmUgc3Vj
aCB0cml2aWFsIG1hcHBpbmdzIG9mIGZpZWxkcyB0byBDIGJhc2UgdHlwZXMuDQoNCkkga25vdyB0
aGF0IHVzaW5nIGJpdGZpZWxkcyBpbiBhcmNoIGluZGVwZW5kZW50IGNvZGUgaXMgZnJhdWdodCB3
aXRoIHByb2JsZW1zLg0KDQpCdXQgdGhlc2UgZGVmaW5pdGlvbnMgYXJlIGZvciB0aGUgYml0cyBp
biBJbnRlbCBNU1JzIChtb2RlbCBzcGVjaWZpYyByZWdpc3RlcnMpLg0KVGhpcyBzZWVtcyB0byBi
ZSBhbiBvcGVuICYgc2h1dCBjYXNlIHRoYXQgdGhpcyBjb2RlIGlzIG5ldmVyIGdvaW5nIHRvIGJl
DQp1c2VkIG9uIHNvbWUgb3RoZXIgYXJjaGl0ZWN0dXJlLg0KDQotVG9ueQ0K
