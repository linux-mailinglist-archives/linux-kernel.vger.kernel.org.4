Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177FD73D6DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFZERB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFZEQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:16:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFABBD
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 21:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687753012; x=1719289012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lCQlvyF+FURNnu4ZZXL0NcI81kOD0H9TOCcCOYf2IsQ=;
  b=WZJninay/5zcC75uxpKgdjpRo+cl81LcgmVxCpo74c7gFLWCNNd8mwWu
   ZCMkQhOOzR9S1GPDsRssPismK/3kwb4OgJbOXWxBOJ0paWPfTlBQS6Hnu
   fSI9Jhmi/aVNh1/bl1L06jd55RhitcGU75Kpg0CiawA4M7jjfWgCfsjkW
   9Y6H1PzJoVtmd+lGunWSdHIg2ctOmwXct3PAEfE3Rw97oogaRkWNYDv9C
   e9JndjspbLr450SKUIVHDzJTT22e7br/8hRW7xf+UxToCjNCRTt6JaSqD
   AcHoJhAfKyU+w8UVhr6JkilLEJAFqvIgZuZGpdb1XPrwDhwJjnXWhAyLZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="427161900"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="427161900"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 21:16:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="962623234"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="962623234"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2023 21:16:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 21:16:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 21:16:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 21:16:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaSEaCp3TGBpISLM23Sgn7zs4eZVDfIhqWlgUBr3a1V7LYNv7u9IVf436QcNR7ACrluZczk44FNB9FnN/5hXdlfqy9+vrFcsfAW2tEOiSBUS7R13KL7ciyS+rhvYHp5P3AE78sKdjzzYgUHd221bTRIq0H3ilIgrm/RhNQ4LCLUfcMNqOEYPM7+a3HVjtCkgxzevQ9euhlh8GzxAg21MJYWsefjXXZ1KGvcf1ZT2yDLUAVgcoQQMmBBB9G2atlZvRJFM+3Ztuo+lX94i/avMpqvf8eKqRS8C1/HMdZL9SIgKIVpNOLnyxI74rz6yVb0kdfmS5UTWQcawFaqQq26iQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCQlvyF+FURNnu4ZZXL0NcI81kOD0H9TOCcCOYf2IsQ=;
 b=iQ13dh0+ius5OzCVzvAXWPeikNGlvDIWQSHFWmxZsQfl4OYDonIMo3/5MfenWJcHjSLBQvgPoaUaUGaDBuW1BkSZJHbsw1FQ1xBjpc3VzGow4sHQYR3QdQkY7C9hhFpa10L+gFg0EitMvUb7wPM4AUCWZ+xZNy5VO5hbIWTT2GgLJaDmiSqFMQEXunVzvsEt2gf5YEYfMwE2YtnEPBHQth8xKwGtL8u4jBiRNOpFwiqNB2+MaE8PKB2r0laf5FQFHigLqtujvT4OsoJ4Qn/SEu5pN+9QOEKPjnuwnC5Jld09/YgjufaORIOK9WpOlBjkMXt+8lfoMMvRHTQfsbCSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 04:16:47 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 04:16:47 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Thread-Topic: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Thread-Index: AQHZpOcz4yOfuGedVUe15UWfk8cDPK+WjIqAgAAxu4CAAAfJgIABXnCAgAAJrwCAASC+IIAAQrOAgALqkRA=
Date:   Mon, 26 Jun 2023 04:16:47 +0000
Message-ID: <PH0PR11MB56734DB18155588535DC0384CB26A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
 <20230622122114.592791-1-kah.jing.lee@intel.com>
 <25439c1e-c9ef-0dc6-8d91-883d7734d0fd@linaro.org>
 <PH0PR11MB5673A862187810E9986E3C8BCB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <125c849f-3746-864f-8b8f-6e0a33aca439@linaro.org>
 <PH0PR11MB567334A09B2D4A1D3DDC09F2CB20A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <0599fc9c-0057-7aa5-3332-40922753ad97@linaro.org>
In-Reply-To: <0599fc9c-0057-7aa5-3332-40922753ad97@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|BN9PR11MB5227:EE_
x-ms-office365-filtering-correlation-id: 61172a9e-5550-436c-5990-08db75fc2842
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bLPpc8SmVV9YR7UxZnMjkXPndQm6SKdlyObwnriJplARt++TL+htgNM5nx0Dtyt/kHMYB30RxiDMwqW0pBPuuWsGKA1pIBy240NbSg7MxVfmJQk6GdeBJLY0ye3yWqYA3Qbvohs1tgxvJjKqMIDDj9/VFaAi3PH1pVv9mwUSvm9+d4n8fSenP/DzOh/AI63gOqouucj15TmNOO5PhUq1TsFHPVRNJiy+GAouU2oNNVHAMa1KH/RiXM/Z13TQgrmPHegDSbt4HU4Y1FZdpde0/Ofng9pt7Mn76XYL5+c7K6UGZVjZtdEo9Z/2uU4ltXNtu5o6GU6VPQkBQbddFKsxW+6p3xmVLlA6HsQvl6JBRMhSQ2ytUqIHqLAg63xfKg/6wVXKkOimvBdqYyQToxVN6yAYFsPtvZMHapW07oXeUoFlnaHXZa/46sFxJwvldymOgcNdYE8F6koSe/FtV6pL3mrHx6Uxt9nb5xtSCaVjWH7ymukPxLi19sqGFatQm77l8dpMGH1my/KR1VSfeTfwb1nGNY/pGvl2VW1EHLXS/TSJmNG2949JQPtgXdfYUBwZqaQsX8jsqp+vzDXs1+fUp8KXKtAwTkM7KdzFVN8EuRY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(5660300002)(52536014)(33656002)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(76116006)(4326008)(478600001)(38070700005)(8936002)(8676002)(966005)(55016003)(86362001)(110136005)(41300700001)(7696005)(2906002)(9686003)(53546011)(186003)(6506007)(26005)(122000001)(38100700002)(83380400001)(71200400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N05BbUxMZlkzZ1YxV3hFdjRwRXA5UDRYZGozc2ZUeERubC9VZUcxUU9xeWha?=
 =?utf-8?B?UDVDOG1JYVRodytTeVJ2U21WY01RUE8ybndmRFFVekhqN0dlZ3NaK1ZoV25w?=
 =?utf-8?B?WmVkdXI2dmlZOW81ODNmc2hEK2ZSdkY3QVRHTGNsRnhPNGxqdVZHNUhhc09V?=
 =?utf-8?B?MytFN29qMDEyb0Y2Q0ZCZDRZSndnbDlLY2pyWTdoY1M4ajlrQ05NWHQzV096?=
 =?utf-8?B?aTVwZE80a3hwbGpKTC9JOFlZU05uMUgyT2MwSmNmWXpMcUcvWDdnc2NaMTQy?=
 =?utf-8?B?RkFkQXR4cUx3S2pWOFZJVFkyam1yVThoTEN2d1dOcnhBS2N0YU1qT1pFZE4y?=
 =?utf-8?B?UkNGcGNMNGZXY0dEdnlvOXpleWUrT1BNS0FkRVgxeHVSbmROVjIyd1JZOWx3?=
 =?utf-8?B?ZFNId3J2dUwrc2c3Ukw4VnJTck03NE5RSU5oSVlGdlppb3NiZzlGVi8vRldT?=
 =?utf-8?B?TTFDTmFDbWh4V2J1RmdaR0NtRldEY2JuMjhUalpOVXNQSzhTOFFSSng3Vmta?=
 =?utf-8?B?VVRaeUl0c1g1Y2svbGxHVm9NSTRpRDIxOHA3SmNGRU5tdmpVZU9yRGMwYUdi?=
 =?utf-8?B?SGJ0MjlGZ0V4bnFVS2pwNXFKeFRpSjlhb3Z5KzVXd0FOQk1aSVdsOG5MMUw1?=
 =?utf-8?B?Y3hYcGZ5NEZvUTIzYktnS0FScHdpL0pTTFRzVzM2Wk1FMDgxRVNxbDRoczl5?=
 =?utf-8?B?Rlc5TTB2NUZta1BLOFJoVkVFM0NQRWVESE5lYlhFYlJiMmozTEZKQXRYdDV5?=
 =?utf-8?B?ZWJ0Q2FSSGNaRDJTMnhwU1RaVTlhWkpzVWxCUk53aFJKZWFTVlRvOUZRbTNV?=
 =?utf-8?B?UEZaOEc5czZjV3c2RzlxdHJabHVaQmxvSmZGMGNvRFo5djU0MXpSM2daQ3A4?=
 =?utf-8?B?c3BBdjFRTWVLZEpoaC9VRnJmaEFhTzBDZXR0UFVYNUhDNTl6akdJSURmL1hL?=
 =?utf-8?B?Rm1TKzFrUjQydytSeFB4RHROYjdPaGVyMGY0bjROVjZ5ZExJS0NhY0s0VVJE?=
 =?utf-8?B?REt6NFVJQVp2V216ejdnenFXSGZ1WGs4aHZVMEl5TnVrWDdhTjNGNENMUmZ5?=
 =?utf-8?B?bVhsSkZsa0tOSlFYMnZOczd5alR3YWpYSy9jMUFuT0xPTE16ODdUYzc3eWVJ?=
 =?utf-8?B?di90WWtDQnBhTkZ0NnBjTzBqYjJUZklaRlBGYW52eHlsZVBieStxblh0VXJT?=
 =?utf-8?B?NkpvVCtNcUU3QTA5SXpxN1YrRjFVcnJtakhseVRWOThDckFmcEd4UFRIaW55?=
 =?utf-8?B?OElmaXVRYmdQSXMvNE96d3lINFp3bnMwUVVVNHZFZWZsU284Rzk5amc0WWQv?=
 =?utf-8?B?R0FOVHA0TDZVVGQyeUZLbjcxeTlIdzg2R1lQbWhLbGV0K0NwcXRSTVE4bFdk?=
 =?utf-8?B?UUtvLzl0S0c5dCtEeUlaUUFsOWdhU3haZEg5S1dib0xlcEROWGFPMjJza0dI?=
 =?utf-8?B?WlF4UXNoQkJLa0l5bjZSZjY0dTc3WWh1NXZFcWZnUnRGMDFjVzZkNElaaFdY?=
 =?utf-8?B?VWY4V2xtdnZqb0Vyc3dIQnVMQUFTdnU3TGF2ajFpTFA5bzcyS2pVOUpaSWlF?=
 =?utf-8?B?UUkxc3NwUEtnb3BESm5VN2FLL3JjdkhCUDltUXNmK3hNUzFKZElqY1ZMYVZj?=
 =?utf-8?B?b2x4NWYvSmZ3SWduSGRRMlpOZmVWbFA5aWZjRXpBMFZvWUd1dGMyZ3RhbXlN?=
 =?utf-8?B?RkJ2VGcxclNkVzk0VjErT3lMOW5SNkdLZ1A3YkswdjFRZ3RFNVUrOHAyVE9j?=
 =?utf-8?B?bXE1OWppRk9SdW9IR2oxV2hqSE9TemdCSlJGREVBUmlvaXdqQ05aUjdyNVdD?=
 =?utf-8?B?c3Z4N0RwVm5DUStmYjViR2pqVjl1a2NwOGRtWWpva3NtTWg1MHJjd3NsVnBl?=
 =?utf-8?B?Ujk1bDRxM1FsY2ZjOGhYS0RsSDNVSWhMZmFveHpJRUNieEF4aEJsREk4UEdz?=
 =?utf-8?B?OVJMaTBBU3Q4bXNneUxIU0dwZEtkcGFCUVpsck1UNENyTTM3cWU5ZSsvaFJn?=
 =?utf-8?B?QmFUcDlmU1RtSEt6TXVXRzlOOGp4Z3lnTDBYb1h4UGxxWkZHT05SVk4zbGFr?=
 =?utf-8?B?dmdGajdFS1h1TjN5ZTBYK25aSkE4aDdFK0x2OHlWekhYOXlRNjBQN2VReTVl?=
 =?utf-8?Q?Emkr7QEn3aGqw3dfZhXzPrIQP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61172a9e-5550-436c-5990-08db75fc2842
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 04:16:47.0603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1zVYvuT2N/vVLmGNEDsnSCXwOY5rYcSUTowHknX4D7bVsFDzqxZRntIprkD/+k1/lyNUDOKmw+QxPOeuRiIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCAyNCBK
dW5lLCAyMDIzIDM6MzAgUE0NCj4gVG86IExlZSwgS2FoIEppbmcgPGthaC5qaW5nLmxlZUBpbnRl
bC5jb20+OyBEaW5oIE5ndXllbg0KPiA8ZGluZ3V5ZW5Aa2VybmVsLm9yZz47IFJvYiBIZXJyaW5n
IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gS296bG93c2tpIDxrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5l
bC5vcmc+OyBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsgV2lsbA0K
PiBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGFyY2g6IGFybTY0OiBjb25maWdzOiBF
bmFibGUgVUJJIGFuZCBVQklGUw0KPiANCj4gT24gMjQvMDYvMjAyMyAwNTo0MiwgTGVlLCBLYWgg
SmluZyB3cm90ZToNCj4gPj4+PiBTbyB5b3UgbWlzcyBpbml0IHJhbWRpc2suDQo+ID4+PiBDdXJy
ZW50bHkgd2UgYXJlIHVzaW5nIHRoZSBib290YXJncyB0byBtb3VudCB0aGUgcm9vdGZzIGZyb20g
UVNQSQ0KPiA+Pj4gTk9SDQo+ID4+IGZsYXNoOg0KPiA+Pj4gWyAgICAwLjAwMDAwMF0gS2VybmVs
IGNvbW1hbmQgbGluZTogZWFybHljb24gcGFuaWM9LTEgdWJpLm10ZD0xDQo+ID4+IHJvb3Q9dWJp
MDpyb290ZnMgcm9vdGZzdHlwZT11YmlmcyBydyByb290d2FpdA0KPiA+Pj4gSXMgaXQgcG9zc2li
bGUgdG8gbW91bnQgdGhlIHViaWZzIHJvb3RmcyB3aXRoIHRoZSB1Ymlmcz1tIGNvbmZpZyBkdXJp
bmcNCj4gYm9vdD8NCj4gPj4NCj4gPj4gSSB0aGluayB5ZXMuIHJvb3RmcyBkZXZpY2VzIGFyZSBm
b3IgZXhhbXBsZSBtb2R1bGVzLCBzbyBmaWxlc3lzdGVtDQo+ID4+IGNhbiBiZSBhcyB3ZWxsLg0K
PiA+IFdhcyBnb2luZyB0aHJvdWdoIG10ZCB1YmlmcyBwYWdlIC0NCj4gPiBodHRwOi8vd3d3Lmxp
bnV4LW10ZC5pbmZyYWRlYWQub3JnL2ZhcS91Ymlmcy5odG1sDQo+ID4gUXVvdGVkOiAnSW4gb3Jk
ZXIgdG8gbW91bnQgVUJJRlMgYXMgdGhlIHJvb3QgZmlsZSBzeXN0ZW0sIHlvdSBoYXZlIHRvDQo+
ID4gY29tcGlsZSBVQklGUyBpbnRvIHRoZSBrZXJuZWwgKGluc3RlYWQgb2YgY29tcGlsaW5nIGl0
IGFzIGEga2VybmVsDQo+ID4gbW9kdWxlKSBhbmQgc3BlY2lmeSBwcm9wZXIga2VybmVsIGJvb3Qg
YXJndW1lbnRzIGFuZCBtYWtlIHRoZSBrZXJuZWwNCj4gbW91bnQgVUJJRlMgb24gYm9vdC4nDQo+
IA0KPiBXaHk/IE1vZHVsZSBsb2FkZWQgYnkgaW5pdHJhbWZzIHdvdWxkIGFsc28gdW5kZXJzdGFu
ZCBjbWRsaW5lIGFyZ3VtZW50cywNCj4gcmlnaHQ/DQpUaGUgc3VnZ2VzdGlvbiBpcyB0byB1c2Ug
aW5pdHJhbWZzIGZvciByb290ZnMgLT4gcmVtb3VudCBVQklGUyBhcyBjaHJvb3Q/DQpUaGUgY29u
Y2VybiBpcyBhZGRpdGlvbmFsIGluaXRyZCBpbWFnZSBhbmQgc3RlcHMgdG8gc3RvcmUgaW4gdGhl
DQpsaW1pdGVkIE5PUiBmbGFzaCAoMjU2TUIsIEJvb3QgZGF0YSArIFVib290IC0gfjY2TUIsIFVC
SUZTIGltYWdlIC0gfjg4TUIsIA0Ka2VybmVsLml0YiAtIH4xME1CID0gMTY0TUIpLg0KV2l0aCB0
aGUgbW91bnRpbmcgUm9vdGZzIGZyb20gVUJJRlMgdm9sdW1lLCB3ZSBjYW4gc2tpcCB0aGUgaW5p
dHJkIHN0ZXAsIGFuZA0Kc2F2ZSBzb21lIHNwYWNlIGZvciB0aGUgdXNlciBvcGVyYXRpb25zLiAN
CkxldCBtZSBrbm93IGlmIEkgdW5kZXJzdGFuZHMgdGhhdCBjb3JyZWN0bHkuDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpUaGFua3MuIA0KDQpSZWdhcmRzLCANCkxlZSwgS2Fo
IEppbmcNCg0KDQo=
