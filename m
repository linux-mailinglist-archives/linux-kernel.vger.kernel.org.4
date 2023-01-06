Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087476608D6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbjAFVfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbjAFVfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:35:51 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A4782F64
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 13:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673040946; x=1704576946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vUS8xxpYjW2ypUV3qN+z5HqMMLUpjdjqKp7g50E0Nz0=;
  b=MN9NrMU58rXRw+6koIYZl/mdwI/6ofeyjVgzLTfgg9yEZtKUDWecEeD/
   4vHfc1fcjqSk+GfebpcWaPuXLl3PcOz5B2PEGdUvnDdz4MMdnzDkqhrbN
   WVbm+koiQ9Lqf+vnOK288jN/c0NlO80KABy4OW9vx2NVjzju7HAGCCdvR
   6PFiZ4XVDt0I97cTECwBaP+gV8xGGVYqj1T2sci7nzxTTVYnb6DmK3NuV
   QfvI+MVi9y4H8ZhVe8yvcVRULzQ6bITWkdIRAq0p6dhAl14e1P/7a+D10
   tyKHmCpf/VkBusbWTXTC7lbTXIbjTwyGdjWEvaFbyv1mEm0bI1/hAJGuU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="310362430"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="310362430"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 13:35:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="763645900"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="763645900"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2023 13:35:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 13:35:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 13:35:45 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 13:35:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7hY8SXR85rp6cURyJFIL6i/hQnlUC5eEY7LXJQSaDfwTxG92rCYscNSt+G6LwF02oU7M5ElNLjnn+7qjvsU7gxsOEVjbT+W3Af6LMg60bOQ+x+SdUx1P6Qnprzu/m1QVBJ2sCdmTrN1MPPRcshHZ7g8WEOeG3FoFm3m9A5uYWkm3ebvUiHprK9k6HCyrkEJLr/4OM9astRLo/jOT6avclgm1gbwab+OnJRSVMzViqgvnO+edQcc64Zvb06tp77jWBxZJA5bFOfUVFgJVaTUKoq3LXZkB4KLyYdiL7OT1BrBX5tHAiRl/+0Vh64i4EOs+SOE7umJ/0hxjetXERRppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUS8xxpYjW2ypUV3qN+z5HqMMLUpjdjqKp7g50E0Nz0=;
 b=jrl34MSxx9/+CwPIc0d9sn6ksCMRbFJF/LroooRq+p2ZFjm/uyoeySs4nv879hduKdaRo4I2bKfgZwvSyzBgTcMcljlpSeo/an0pX7ctgjc4UA9H9bouuDEDDQvgU+tVOxXWSOkarQFujatNWklFEzNSyY6ZplEqjWyBmMjffqVuwszcs8s0SO8jEQ1nX4nb9n43wI8XYyEjsLExttNsdrGM/uQ4uRKVociyG7iFQ6qB3Prrbh7YlEzDoC8aMxudTPT/M8nnFHQnXvLRLT4v6O4sjAVBh3irQnriviDlU61KlglcE4qiIBpiSD9H9JJYW89Ejt8iSFbzsGmUBomHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5527.namprd11.prod.outlook.com (2603:10b6:208:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 21:35:41 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 21:35:41 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, "Raj, Ashok" <ashok.raj@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: RE: [PATCH v3 3/6] x86/microcode: Display revisions only when update
 is successful
Thread-Topic: [PATCH v3 3/6] x86/microcode: Display revisions only when update
 is successful
Thread-Index: AQHZH52NAoBL85VeDUGvO9l83Nz44a6OnkiAgAMwhQCAAANYAIAAGXUA
Date:   Fri, 6 Jan 2023 21:35:41 +0000
Message-ID: <SJ1PR11MB6083BD0E0191061B72A47982FCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-4-ashok.raj@intel.com> <Y7XMtWqSrs0uGkD7@zn.tnic>
 <Y7h5qD43kdPeEgQ7@a4bf019067fa.jf.intel.com> <Y7h8dpIQHnL93RdC@zn.tnic>
In-Reply-To: <Y7h8dpIQHnL93RdC@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5527:EE_
x-ms-office365-filtering-correlation-id: 2d9c0774-f857-48a7-edbd-08daf02df5b6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NLZOaNPKroHDdNJ7qnVfHgmZngQB24aCKMYdUea/rXYBqHGnMKnQEccugfgxqC1E1IJ+DisaposzszAB/B7TifTVRVSll0pUDVPxsHEkPCjI1buJfP8nCFYiOSOcz9NFuV36PLZRJELzz0CMNZ8REPPuMn+sYpV8+2xhlTzLXHNQc0eYaTaHs4RD0X1FC5QBxJQdTKdsflcGRkQzDnqxmtSbT44Uxe9U89pRSZnjoDHCgGN15XqATOCEv1dP9gmfQ1hfpMbqy+T+VTzgv089z1FBa639pQ5dfSp2Zg7LufmQrmkJ0zYn0tjCwiYIgW9Rt7BKlq1DXkztKpHG2CeMtB72MUzyOoJVE0zsbftuaW2lGske/TV4AUDiB4UU/I2ja68Nd4HFmbt/sHELn6FuxUCMbfrUcKTliQrrc9EFRybizpze/T1P94vbCiGFJRz+bCI33n0ehfrMTm/ce4qxmJhOVAvrvOQbdybc7rM7ULYACIl/WjJBtclrjbQVwfdjGN/d9O9b9XYoYUtESGAcIaDz2G+kSN33XQqstxRjKj/fkQjdBaaFkQ1qUNkTSXXtvVvpY54IdRdtMnxgKFMrmFxYZDTPROPxUUQAe50b/T+6ZmnzqPDrbrd8jhJURXY49lWY0inPQ/96hH16kB6ONI7c7Mmp8mhncsFIPFu4vvS5HGxzbbjG5cJCClgLubPhMrGk0p64B1cgYy/BIp1v8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(86362001)(8936002)(41300700001)(122000001)(6506007)(52536014)(7696005)(478600001)(38070700005)(64756008)(71200400001)(5660300002)(38100700002)(82960400001)(83380400001)(26005)(316002)(66556008)(4744005)(9686003)(76116006)(8676002)(15650500001)(186003)(66446008)(4326008)(66476007)(33656002)(2906002)(110136005)(66946007)(6636002)(54906003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzduWHFhQzdlZDI2bk9Vbll5Uk44aFBwQmx2UDhzLytDS3IwZjJtWVFGZno0?=
 =?utf-8?B?WjVpcXNITHE4S2RDNTFVNWpETVk5L3pJbGlyQzlWYTdUaUM5Y1M1dnRFZG1Z?=
 =?utf-8?B?OW9IRkUyUEZXQkFHL0NGd0ZXdU85UjA5a0QrVUFpQ0tBeTd6ZVZvTW8yMjJT?=
 =?utf-8?B?RWEzT1BmMy8zQSt4ZFFQSWM0VWQ3T2J0YW9NeXYwMnEzM1UwM2ZUZmtGZC9Z?=
 =?utf-8?B?eHhYK1FMQXhENVlsRk9manlBVDVkV1JlQ0ZCQWNqcVNLelRmaDhJSldJV2Z4?=
 =?utf-8?B?TTZ2MUNsajlEQTVMaVRXb1dQbHg1SmdSWlRkaWdEY3VJQzYzN3VFVXJuazBY?=
 =?utf-8?B?a0hHYmI5ZlBtbUJuYlFOTUV2T0lNS2tzQWNwRDRDU0lEQlpZeEhjb29QNnlu?=
 =?utf-8?B?dHFzbGd1MnFlaHMralh3QUp5Y2xldmxsaTM3TlFSYUpXaC9TNnpFUDlGbzRm?=
 =?utf-8?B?dkxlSmF2OVFKNjNhdGoxcy9kcjNZcDl0M1ZCZkw2UzQxYnQwbFlMalRKRUt4?=
 =?utf-8?B?ZjdNQjZFYkhtR2VEQjBCVHVUbVBReHdOMFFMUkZ3MmRFdDEvU0l5dzdEd3Q3?=
 =?utf-8?B?S0E1eHorVVVJdUs1MW9OYUtyaHZNOFAvdVJoVnhUWjV2SStpSldQSkxOY2dK?=
 =?utf-8?B?Y2dIOHRCWmxUMkZ4aXAvTEhvaUEyVnpISkNFMEdjdXpLZWRjbkZGeENRc0d2?=
 =?utf-8?B?dVRnd2ZsMkcxNmtwZG1UdVBDR3hXbG5GZHRaTGlpbFpjWjBFdUJuOWpQUjV5?=
 =?utf-8?B?VThnK0dSMHVEc3RYS3FkUXhWb1BZQWhHR2d5UkZPdTl2bHJqWXNjSzZtWDhE?=
 =?utf-8?B?RitMVW1VZm5jeFF2M2djWnlVaUk0a09SRGRHTUtrUTJEb1psVkJHdlI5RW9l?=
 =?utf-8?B?ekhYM1FnY0UrNE94RHVxeGtmc2RjaWw1V3hYelVWNy9oYVFhSW9GdUtudlo3?=
 =?utf-8?B?WkE4Zjcwc05HekdOamRzQ3VvRUgwNFFobFp4aHpUUzJyWXlvbk5wSEdmUlIv?=
 =?utf-8?B?elovbmFPMEpwSXlDajF3TWhwR000ejEyWEhUYWJGbmlOWTdjOUtIaTQ2Y0Zq?=
 =?utf-8?B?ckJXUmFmdnVEWG5MZ085KzdYN2FmWTlDamFsUjlQMlUvK3Z5NFowT0UzRkpy?=
 =?utf-8?B?b29hamh3WDl0cEJSQ05OWWFjaEhvRy9FTEpGUk9lMzg2S0d2QnNVRDB4R2Jk?=
 =?utf-8?B?aFhqL29BS1VNdVhzTGFPbGorVjZxenNLMUlzaGtLUWtwQldDbkNkS2E2dEpG?=
 =?utf-8?B?cEFkTDRPOFpKcDRINUJ2MVA3a21TMFJlaEhzd05wVWxMWFN2K0hURGpHTHRQ?=
 =?utf-8?B?TWhFOTZGbXlhMEVlNlJBU3BhNlBWdUlrZmtjWVYzb05uS01Kb1hTZUd3R3k3?=
 =?utf-8?B?NWNSZDYva3B3UTJkR3BSeEFtNUtKVi9Sb2ZuNy9IY3A1TnBXRjZiS25rSTJo?=
 =?utf-8?B?K0d2UTdHMkFPaERUTy9qSjZTVlNXV09mQmszbGlrSFlyMXpXYmZ3bmxzVE1q?=
 =?utf-8?B?d2hCVGV5QjdTUU5nZVdSL2Z6akxub2RmZ2xrQzJFcUFCVGZTQmwyeC9NbHZB?=
 =?utf-8?B?UUxkanhvRkE2WGFtYUtTeG1DcWc2QjQwRW5MZ0s5MVViRFgrNmtNT3BTKzY3?=
 =?utf-8?B?LzRYOUk0WGJkMmtFNEtxTEVkSE9Mak9jYlRnN011emdwUThiMkdmeDlHVUJw?=
 =?utf-8?B?YmdBUUJ3d2d6OVlrVUpJbnhxNU9iUkJONGFjZ0gzMjhNTitVOG43U3NYNXpm?=
 =?utf-8?B?RSs2NVl3djUzZVA1cDJBamM1NDN1WUMrK0kyUTBzdVpGN21kRHcyWmMyM0xB?=
 =?utf-8?B?SkZzRm1qTWp2WitEVXA4Y3VYQm5hSXY5WkVNSEtibENsUVNVSjRFTUQxVTM1?=
 =?utf-8?B?Mmd1YUlsbHVzL1dQWkVNY0UvVWVQazFWMUxZOU1hZURVTFlCRXBqdG5wQktT?=
 =?utf-8?B?WUZ3QUV2d2xQTTdUQTdBckZobzdvQWwwMEpsd3BiNm8rd2hKdHVsSER5NlpP?=
 =?utf-8?B?QUlQNWd1V09RWVQ1MERrYlpGV0tZVzFPSmhwaTR4cXNxdkZzMzlsN2Q3U0tN?=
 =?utf-8?B?V2MwZ2hNakxucUhwNnkyeVZaU1I0ZTFZT2lsVElXV3JpdWVIVllYbzJvb1FF?=
 =?utf-8?Q?jIjk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9c0774-f857-48a7-edbd-08daf02df5b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 21:35:41.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJG/BohB7UI5sFqGmlqTVffIO+avJk5I59s13ss/ZuZX5ERci09ImRnhvCWZhWkZ4GKYfaTUUbt9VQnS4e2sow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5527
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

PiBXZSBpc3N1ZSB0aGF0IGxpbmUgdW5jb25kaXRpb25hbGx5IHRvIGdpdmUgZmVlZGJhY2sgdG8g
dGhlIHVzZXIgdGhhdCB0aGUgYXR0ZW1wdA0KPiB3YXMgYWN0dWFsbHkgdHJpZWQuIE90aGVyd2lz
ZSwgeW91IGRvbid0IGdldCBhbnkgZmVlZGJhY2sgYW5kIHlvdSB3b25kZXIgd2hldGhlcg0KPiBp
dCBpcyBkb2luZyBhbnl0aGluZy4NCj4NCj4gVGhlIHByZXYgYW5kIG5leHQgcmV2aXNpb246DQo+
DQo+CSJtaWNyb2NvZGUgcmV2aXNpb246IDB4JXggLT4gMHgleFxuIiwNCj4NCj4gd2lsbCB0ZWxs
IHlvdSB3aGV0aGVyIHNvbWV0aGluZyBnb3QgbG9hZGVkIG9yIG5vdC4NCg0KU2VlbXMgbGlrZSBh
IHZlcnkgc3VidGxlIGluZGljYXRpb24gb2YgYSBwb3NzaWJseSBpbXBvcnRhbnQgZmFpbHVyZS4N
Cg0KRS5nLiBUaGVyZSBpcyBzb21lIHNlY3VyaXR5IHVwZGF0ZSB3aXRoIG5ldyBtaWNyb2NvZGUg
dG8gbWl0aWdhdGUuDQoNClVzZXIgZG93bmxvYWRzIHRoZSBuZXcgbWljcm9jb2RlLiBSdW5zOg0K
DQojIGVjaG8gMSA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L21pY3JvY29kZS9yZWxvYWQNCg0K
CVtUaGlzIGZhaWxzIGZvciBzb21lIHJlYXNvbl0NCg0KTG9va3MgYXQgY29uc29sZQ0KDQojIGRt
ZXNnIHwgdGFpbCAtMQ0KbWljcm9jb2RlIHJldmlzaW9uOiAweDQwMDAxYSAtPiAweDQwMDFhDQoN
ClVzZXIgZG9lc24ndCBub3RpY2UgdGhhdCB0aGUgdmVyc2lvbiBkaWRuJ3QgY2hhbmdlIGFuZCB0
aGlua3MNCnRoYXQgYWxsIGlzIHdlbGwuDQoNCklzIHRoZXJlIGFuIGVhcmxpZXIgbWVzc2FnZSB0
aGF0IHNheXMgc29tZXRoaW5nIGxpa2UgdGhpcz8NCg0KbWljcm9jb2RlOiBpbml0aWF0aW5nIHVw
ZGF0ZSB0byB2ZXJzaW9uIDB4NTAwM2YNCg0KLVRvbnkNCg0KDQo=
