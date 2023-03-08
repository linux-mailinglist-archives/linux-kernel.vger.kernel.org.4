Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B956E6AFD00
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCHCrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCHCrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:47:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51850A4B36
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 18:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678243623; x=1709779623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GQHeck4LHhPsGInCdaF6EmmW0OA4c4xCW3y8CyK3+7Q=;
  b=XKJdTRA8eyA8QT+1un9dY86v57Yad0U1SbtFAdQP6M20WOQW9MmsAxPK
   2uzOpSSttCIY5d1zpQ9SBgmte+en7dBfJfFmZJQG2VznhRMn+pc4r/Kje
   lvv0AqZOD22XVswrKX8yhGvgVkZfb82ClufHf1boJjXizcNRf+G0Pg8zs
   N+TwuhYPimxUj8fabKgCXGztolq2aYgli6+X5lzjfFB+wUhGTm8f7aMju
   gY3y91L6lXy1h8NuGj8S6d8c+SRqRxytM/rq8SqN8KujJWvRucq9iRyU9
   BPXENyhSMJtxRv40G9WkDXmQAnGcQcFmfOsaUPBss5HQdqebgLVZegY4/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334752408"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="334752408"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 18:47:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679172091"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="679172091"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 07 Mar 2023 18:47:01 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 18:47:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 18:47:01 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 18:47:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k32eGGTeOJDLrAqeOu5pT1ZCTEA6mvxh+ZqeqrcozxfcS9Wpn2cu7o1iLEeuap/QFkb90adDty/aKycFydrH2BIPgooqxB6Y9xlJj6fKFLpLsWEy9NnXRrDvItxbLnG1cRtu8/NIPtckJqz38t9fQJdETvUWq9dUy5llpSIdXzg2x1GA5JDag9+sjgNRK1v9Fh2J40OFQGC6WzWMSwDYkRdas6OxrSngJTa8IlptWmsd4LYZyfNldEdeKdX4AGccdBTApxjbW0QcQJK6j7JrlJhIGeK66FRVLnRQ2QBLlYb1DtI8iLlXm98/YrsBNg572T27/3esB9XIJeMZFE6qag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQHeck4LHhPsGInCdaF6EmmW0OA4c4xCW3y8CyK3+7Q=;
 b=guCQv7/OvoVG27K4Q5IEoM+qtNE38vPlcYrff+kmYV72QZOhZCF4/Ag7QyOmRllZZ0wWZve0dCXCto2hF/6c37BT6+339N1dbTWXhsOPxBD6Rvv4PJcr0yR78+8TKphN5KQkTj/HhGxqxsQCmigjSSDpRB+UT+1YrRpgxnkKcjakH4P5RZwIgfpS8FsjadvCq/ESjiG5niEMJEGpfM+pY5IBE4x2D8vVb7ATUPwJ0qJhF3lHluOncLbP6a3dzgtS7+4vtGUm23acNZ+UhGk18GXWI8pZCKQxokpGinqwsrJO3IElrwE6w0H47s71ke9q1OicI/JEgHf7GahA72UDHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11)
 by SJ0PR11MB6576.namprd11.prod.outlook.com (2603:10b6:a03:478::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Wed, 8 Mar
 2023 02:46:59 +0000
Received: from MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::afb7:6502:7833:5a81]) by MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::afb7:6502:7833:5a81%7]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 02:46:59 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Topic: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Index: AQHZRNuCVMfcs7TxIUq/ygktez0G3a7XrYkAgAA5QYCAAIq/gIAAoQmAgBaCUACAAK6S8A==
Date:   Wed, 8 Mar 2023 02:46:59 +0000
Message-ID: <MN0PR11MB6010F6B9B3C68902E5675367E0B49@MN0PR11MB6010.namprd11.prod.outlook.com>
References: <20230220032856.661884-1-rui.zhang@intel.com>
         <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
         <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
         <87edqkosty.ffs@tglx>
         <65bb51627b7384190f6aa1c549548a2497a926c3.camel@intel.com>
 <3bc616e8a513d4bfef2fb2d824f7ca8e8815bc77.camel@intel.com>
In-Reply-To: <3bc616e8a513d4bfef2fb2d824f7ca8e8815bc77.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6010:EE_|SJ0PR11MB6576:EE_
x-ms-office365-filtering-correlation-id: 30ca0735-c4cc-4bac-41b5-08db1f7f6391
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WH+Ck7suz6Ldwd7lZA2pt5eiVOaK2k2NZZkryri6R5NJ661I50ch8tkCSyexmHyl1CGaNRUf4G9b2DqrdF3O8uJxWY/507JbjgMp9jdPfo05nbw7PWpuCLxtkUI5RGLN8Jt5mwF2KU7fGrlxAo7bxcFn9ToVJ8pJXbNmfaXzvqNrXjqodYr2UaH8hTEd+NdST3xsjpVTs07OgSk8qvEEnLmw5vNv1tt84CPTDykpwPOULUXyidAM7qOzmqB06c1vyI1uz23IYC3yTzgNxb9eiLv6w+rR/Y2KW0TQpEUE0QelaaLbvY+JXrxhffRxObpk95AbM0zFnPhwbqEOaVILvuWfovsVKP36DBf473VHcg1Bhfpi8Lx4fK9t7M449vnJ5CV/S4gkXc1giFPrfym8mgJUg7bbqppi8IdOkpyILEsGAPCjY4JKU5EKdHzrbxP2mGyvHJs/azdBRRGImVGgVzX9SHC3zUoL4OFizy9UkYW5XvNsSr3Uw2GotblpNz9VtGNbfEqP/yVc76mj60y4v0caMLVi6iro+61A4dTuwhfKTPScvneEhXR/WSM4gBuWJ3Kc7eyC+Y3rVJnEXUauCcEevoyllVihCa4aXgcftvxcle6lM0jqjN+5a6vhRqfEwbPWVgOzzFDgP4Lbqhqjcs4GQewavkHHb1BBLfw2WxqphKw4ua5PBgK+By5M+6GcNW6XLTiDM9DmS3Tddpe2zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6010.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199018)(33656002)(86362001)(5660300002)(186003)(71200400001)(9686003)(4326008)(41300700001)(52536014)(6506007)(26005)(8936002)(66476007)(478600001)(66446008)(110136005)(66556008)(54906003)(82960400001)(64756008)(7696005)(66946007)(122000001)(316002)(76116006)(38070700005)(38100700002)(8676002)(4744005)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm4rOS9wZ0p6YXNvZVdETGplU3BJaGhQRjVabWxzakg3WlBUcUt0Y3pibTlQ?=
 =?utf-8?B?Sk1LcUdoMjVCNFJTbWIvcDlqdUM0cytuS0RiT0p3Vlp5NDBKTkF2angzcVJX?=
 =?utf-8?B?R2QyNkVIT0VWKzdlWVZiWEdZT3VtK0Z4akJGUEdudlJ1SUdKS3NFeEdVeHd6?=
 =?utf-8?B?a2lqUXBFYTVyUy9xZ05acS92eXRKQ20rY2NGSHZRTnYrMHNoNkNkc2JRS3E0?=
 =?utf-8?B?RGdVLy9LUjFTRGFjaUdQdHRHMzNBQ0lKYXJ0MzFTMnBpNHM0QTFNTHQ0R1pZ?=
 =?utf-8?B?UlRYekIyWVc1NEI3eUZoM0pTK1FqdzRpTkNjQkM5VjZzdU1OcTNMaWhPVC9Q?=
 =?utf-8?B?cVlLWjhIMUE0VElKNWhtSXRmZTlEUFpuMU54MTYvWXhraEhvWDU3Sm93VHhi?=
 =?utf-8?B?V3hnanZlSDY2MWVDRmN3SDRUT1g0RWkvTUpYVVpKUWJ0akNqMERoMFhZOGF2?=
 =?utf-8?B?TE1zK0dKdEZOUkR5ZUJUL0RjcFB2SEtYdG13MHZ4VTQ0TGFjalozQXR3aWcw?=
 =?utf-8?B?QjZKZHVkSlVuY0pTOTVjK1M2RGxRNDlnRjRaQU9mZnJXb0pNMWkvWEY0blpT?=
 =?utf-8?B?YzRrRHdOSG9SeHFUNGVTQ2FqZkJFbmt4ZHJxdlM4ZkxmaUladWRHYmE2MDlO?=
 =?utf-8?B?M3A5T1NwTXZGZEdkUldxbjRKY0VDdVViTHR5RUJBandUUXFzamtGN3dzVW5B?=
 =?utf-8?B?bno5L2wvU3VVTE5CQkJNRmxlZVNEdks1UVVoWXFUZDRDNmpzcmI4c3pXVkFv?=
 =?utf-8?B?L09DY3RkS2hkelJIS1dGbjNRdEZtRW9JZ0FMd05DOGRLWHVoUS83WFJ5QjE1?=
 =?utf-8?B?YmpWVXpMY3NXRHlveHZPU1h1YTFBMEVieEtkNjZZRjN6VmtBVmIrRXMxbkUr?=
 =?utf-8?B?YTBvTVpibHJvQXNCZXlReklQbFlOdUJjNlV2eitFamZldnZzRlluelpSL0dK?=
 =?utf-8?B?S1BPdmpJSlczM2NEYXV3OTZhOUpsbkhZMHBvMlo1Nk5PTEc0ckdvNzRxVWVS?=
 =?utf-8?B?YmFxM21ldUQ3NklaYiszTGJ1SFVXNFBaemZXZ0VjeVd2WUpVWXEvOGxEVU1G?=
 =?utf-8?B?YU1CZjlXNVZjVnhyclBoeWg5QVJ4R1h5OHdHbFNYQ3RlS21rMEROM3I2SUYx?=
 =?utf-8?B?NFBuVE9ORC9iRTZnZTEyRHIwLytXSUpjSVBrY3RKMHhwKzhxckd1VWhOaFEw?=
 =?utf-8?B?SURKK3ZhOVpZeEtTSEFnOUZmRUhNRzBHak1qazBpa004dUxGTG1sVnNkQWNq?=
 =?utf-8?B?UVpWN01URjNHU3NFeWZwKy8rcmRFZnBHN0s2cDFNU1k2aGdLOGoxcm5qZ0or?=
 =?utf-8?B?L1NsS1MyWGhVRytIU0VSNjdrV3FGVHI1WWJ0QlpyMG9XbWtFWnlKMmFrWlZl?=
 =?utf-8?B?R0JFUzNnS2s4ZjVZRTdPYlhXTU1iWkZGcmxxa3lNM0tyNVBOYjhxVDdHTkk3?=
 =?utf-8?B?VTlFbzU0REM3cHVxT3VxTlF1YXJuSVJkVFhOa2hPblpXSnNzYzZaR1NiY0V1?=
 =?utf-8?B?cUttdmw0VTFyUnVrWmVSZ2gwOGN3RzN5WFUvV0RDTHEyeXVZbzYxVGVuTmkr?=
 =?utf-8?B?dmxYZm5uUXlUMHFzb3FybGVIM1FPM3NqR2hIUnZZMjMvVFU4SDQ0MCt6VjVR?=
 =?utf-8?B?N29WNEhIY2twakErWCttN05OYndFclF0REVaVGtabGtFWXlEcExQdEZrdTFU?=
 =?utf-8?B?ZjdQbWFTcVh2dkhta2hMRk9qc0Y1dWRQT1J0SVBneS9QaWdtZ1VwcTk1Uyta?=
 =?utf-8?B?QUY3YzZDQkVEaU1HWXFaL3NqUlpoWDBQV1JXbHVTREtta0d3NWRISmNNOWVn?=
 =?utf-8?B?ZnpBVlk5RzNmMmplTGp6VzYyQ1FrdnRyYWd3Z1M2SjlmLzRGVGkzanYxeDBI?=
 =?utf-8?B?S2dXL0xBUWFlaGNmY2Evc0hLb2prU1RITnNRT1FrUk9lY0JkL0c2em83NUh2?=
 =?utf-8?B?UjdCblMvVTYwajlqVUFUL1dJdXlza3JWNEFSQUtQK3ovVGk4K0NaNFhwVDJN?=
 =?utf-8?B?N0FyS1FmVWFLYlZnbnZ3YkQxeXUvaFNFVXpHSlJiQXVTSXVnbWdaWFFWaDkx?=
 =?utf-8?B?SnVRMys0TFNnb3Vud3AyeGdZMkZnL1lOcVpmNW1PaURXNjg3azNWL2RzeGpX?=
 =?utf-8?Q?mecUoW1a58rNN/+PqICYD5ccx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6010.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ca0735-c4cc-4bac-41b5-08db1f7f6391
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 02:46:59.4672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkYHyZdZvkRB3a1BCKhGZeCYO0nX78Gcr1pD00WAiy4hOIt6W3Ie/zl3Q6azZGpPOt8yU6Js97EEhe12dcotIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6576
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzLCBPbiBJbnRlbCwgTGludXggc2hvdWxkIGJlIGFibGUgYXNzZXJ0IHRoYXQgQ1BVSUQuMUYg
aGFzIGV4YWN0bHkgdGhlIHNhbWUgImxldmVsIiBkZWZpbml0aW9ucyBvbiBhbGwgQ1BVcyBpbiB0
aGUgc3lzdGVtIC0tIG5vIG1hdHRlciBTTVAgb3IgSHlicmlkIHByb2Nlc3Nvci4NCg0KVGhpcyBp
cyB3aGF0IFRob21hcyBpcyBhc2tpbmcgZm9yIC0tIGFuIGFyY2hpdGVjdHVyYWwgQVBJQy1JRCBk
ZWNvZGVyIC0tIG5vdCBhIGZ1dHVyZSBmZWF0dXJlLCBidXQgb25lIHRoYXQgaXMgYWxyZWFkeSBz
aGlwcGluZy4NCg0KV2l0aCB0aGlzIGRlY29kZXIsIHdlIGNhbiBwYXJzZSB0aGUgQUNQSSBCSU9T
IEFQSUMvTUFEVC4NCkFzIFBldGVyIGFzc2VydHMsIHRoZSBsaXN0IG9mIHByb2Nlc3NvcnMgaW4g
dGhlIE1BRFQgaGFzIHRvIHdvcmssIGVsc2Ugc21wYm9vdCB3b3VsZCBub3QgYmUgd29ya2luZy4N
Cg0KSWYgd2UgZG9uJ3QgYWxyZWFkeSBoYXZlIGEgY2hlY2sgdGhhdCB0aGUgSU5JVCB0byBBUElD
LUlEIE4gcmVhbGx5IHdha2VzIHVwIE4sIGFuZCBub3Qgc29tZSBvdGhlciBpZCwNCkl0IHNob3Vs
ZG4ndCBiZSBoYXJkIHRvIGFkZCB0aGF0IHNhbml0eSBjaGVjay4uLg0KDQpBbnl3YXksIHRydXN0
aW5nIHRoZSBNQURULCBhbmQgQ1BVSUQuMUYsIHdlIGNhbiBkZXRlcm1pbmUgZnJvbSBjcHUwIGlm
IHdlIGFyZSBnb2luZyB0byBib290IGFueSBTTVQgc2libGluZ3Mgb3Igbm90Lg0KSW5kZWVkLCB3
ZSBrbm93IGFoZWFkIG9mIHRpbWUgYWxsIG9mIHRoZSBDUFVJRC4xRiBsZXZlbHMsIGluY2x1ZGlu
ZyB0aGUgaW1wbGljaXQgd2hpY2ggIGxldmVsIC0tIHdoaWNoIENQVXMgYXJlIGluIHdoaWNoIHBh
Y2thZ2VzLA0KQW5kIHRodXMgaG93IG1hbnkgcGFja2FnZXMuDQoNCi1MZW4NCiANCg==
