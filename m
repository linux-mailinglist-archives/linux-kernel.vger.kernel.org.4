Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D9A746B3D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGDHza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjGDHzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:55:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1DAE4F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688457302; x=1719993302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2vtyn8Keuc5PpuXXhZ2K4vMIRoCqjpISjpsZc8kgzy8=;
  b=eVcgDQWrYtDPyynDfhxYizxXXejXwzROlFNYsxj8rakzBWO1UyvS2EHe
   olNTFtbzQNaX0LuTAn4ZyQRqHvDSLeMdV/yDPWIIh8F8U6LketPvOwmRk
   Jc1ZRU+f1wsfA5KJJvdz9Fj1dGBDDYwBacSvFVCOQu7TGimlHmVsHBT9m
   yDSzYDHfUo2plv9+t87A15KKmtvcD6Wl6pWrFCwoBVCpCryoQKv+Pcj+F
   tgWnWHcH/1A7Zig20zt0TQ4rXL2Qd6lfQ8iyTmpmtoMh5Ts9BJ4Oba616
   +hsVbo6kVHkfUm/cwsphlYV9ASFVIC1g/R2DKXfXOPC7GUCl31ZfRr7lq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393806719"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="393806719"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 00:55:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="784140775"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="784140775"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2023 00:55:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 00:55:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 00:55:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 00:55:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjEWmZVGj47wYOsvvEA2rnetQ60KEPmQZgzpDSVLitHPBZ8QeUiLx97cDcsp7fSal6KObaJnGVUlV7GIJMyXdUsy+UYqDXPIkwaUdzOVGUqVt8A0zwAH/KlyRCYxgJNZZLWghMe1YV8t5UWg23eq8Ve39iUrBl/nnYtdO+lHyDdoGeDVe5Yk3+15p8N7RH7qQrKwGSxeq4wdWULWYgB2XRNYGyWbboujhaTejy7JANCpcNCHzbBJdAtF0L+jafeuarApDywiWFBYdX2MblA3s24lcgWHBuVHmwjsh9gZjRk/i+uRCrsPntgQsiP3/8gEVeVZQ/1Plzo7RIDMCH3H7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vtyn8Keuc5PpuXXhZ2K4vMIRoCqjpISjpsZc8kgzy8=;
 b=BIiln9oCm6QKJxVSBK9ZH58mfIYf9qs/y0PQqRXNJEotmqpCeamkGq/ZBYTj4pax8ILUdPN1fdFTGfTQkU9M+k+b+V5vpgSYjSwpXCURLHsKKeD2ib03dpvqSO7tFjZOVX9uruPSbH+7TwcqntO2SrWiDFaL22/+yeHqFYj+En/erT2jrUcS+ADHyO3bqlVMSrVA9JtR8cYDhnuji2NWXlF0Rr1J4Ik9h+4DDopGPlTlXyf6fUowKA5wp7mdF2iqQSrrnYsHc2IJp3kHut9N/xIZa47fDJMrezaZH51cQKkhxLCoHkQVvqajT2DbyqdRh7W64pdPvefO3kEXRtxz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8057.namprd11.prod.outlook.com (2603:10b6:510:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 07:54:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 07:54:59 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Jingqi" <jingqi.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Thread-Topic: [PATCH 0/5] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Thread-Index: AQHZp3g/2UxT1hPuDU+fmpvlazmt86+nq2FQgAB9WICAASG5UA==
Date:   Tue, 4 Jul 2023 07:54:58 +0000
Message-ID: <BN9PR11MB5276ECF766C4F89F5083992F8C2EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230625150442.42197-1-Jingqi.liu@intel.com>
 <BN9PR11MB5276885D6A142BC94D80C2618C29A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4f18a7ca-3a57-0097-51f0-490f876831dc@intel.com>
In-Reply-To: <4f18a7ca-3a57-0097-51f0-490f876831dc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8057:EE_
x-ms-office365-filtering-correlation-id: 565ddb76-a9ed-48cf-fb77-08db7c63f6ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aTTgONYbteCF7p/jd86KTv7TUVDppnhD/mtI+H9d0dIGb4q1EN3fc3LcmfdhxAKBEgtVEP+66Qf8CcR8b3fckgFXZJeD43h1v6I/JO3YP1N1ccqTAAAxg4We/uggEvh8mPmv1bStf1gglbeB3zJ8LnBKD4NFcjuMuc3449KOvNy/gOaJ/2K9yXRPjfpJXOvs1O3WfMWeCMRfx3vFMv8SKH3uAixtqxzzPxnE+CUrwOMgLouEn8XBDtPTVWz5y7iZHQmvdcb3O8+bZBXTfqzNM+abdQxu6slR+2QgaO7mE4FED/D+SO4hZpHN+Go0Y8yUAAByK7BT3SNwR3xMMvSg26pkPb2MKRzp2adcSggix1UOleATfd681JDc0CTnijH2tlSLUMYmdCOO36Nk0JIWCEYIZKQT4N6Ny8ivv/ILFMpwARTnwN9hkTg83R0ip2avNOQsHOosDvSurxPSh/cLu0RfGfuUuo5ScXYcEtyTn1ASDrqhKJqohy908bpz5dTN00kTceCzGNWZY0fBr1iDe3Wz7GZN3fuNLR6F23T+wfeXXm/vPHy5DaY5whVfyB9xOvdPbJmR+WGG2sFRh+GMEHjPXzcnrsC8I7ERm7X9k8g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(110136005)(2906002)(9686003)(478600001)(26005)(7696005)(33656002)(86362001)(41300700001)(52536014)(8676002)(8936002)(71200400001)(5660300002)(66556008)(316002)(66446008)(64756008)(66476007)(4326008)(66946007)(122000001)(55016003)(38100700002)(38070700005)(53546011)(6506007)(82960400001)(76116006)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OERxSWNoUFM2SHp0aktpWW5FWmJOSDlxSXV0R0RMamhTMk5nUndxSHJKaVBp?=
 =?utf-8?B?WHMvbVVobGp4YUVIZFlCVGIzUUxyb1J5bndNMFlpZ0t0T2paQUxMZ3c1d3RB?=
 =?utf-8?B?bWU2eC9Yc2QySjArVlFkTWZEWXhWZTRlK0ZJS3AzNXlKZ0FOMkhXTFhhN3Js?=
 =?utf-8?B?alBCejlmOFltSy9keVZaM3hIY1l6d1VXcktSY3dQREFMS2FtZ2xXV3g0Njl4?=
 =?utf-8?B?NUFBbEZlcGdQWVlCQlZxM1BoRlVUcmtDTDRDRExReWxsMkIwbTNRS0dqTTdi?=
 =?utf-8?B?Z2Ztd1VmNlRidHBFL3JmUjcxc3dzOUg3TzdIOS95THJxYk5MU3daL0xnY29M?=
 =?utf-8?B?bExiUzdCSytvdDdJaHA4RHhMUEFQUHVLdXBNL2RpSTVWZUdHOUJ4V1FnSjhG?=
 =?utf-8?B?aUJ3SGZlRTFvQXQ4K0svU01yZXQvanhBaVNZa0pQQnc5ajR3ZTdKVkduWXBk?=
 =?utf-8?B?aldlNjQ5MVljYmRVUjE4MzBCWG11WHRtampCZUgzTk1xUEpYUnBVdE9kS3Jw?=
 =?utf-8?B?R1ptWHdOSWFrU2Y1eFhaOFZDYkZYSC9OcE9CazBFNzdKTmY2RUlsUWtGQmNi?=
 =?utf-8?B?dDR4Wi9EVkZEQjNRQTc5MC8zSGc3bzgyWUNrM3ZtYlJpdDIvZk50WmNRY3N3?=
 =?utf-8?B?N0dnZWE0UnRYOWhxZC9BRmc3bzlGdEhrV3JuMDBjMCtyaGRraE9rSFJWTkNN?=
 =?utf-8?B?K01kbEYvTFZOQUlodm1DM0paV2hobmJoUklLb0hMNlFCNE9Pd3NnVFlUZzRE?=
 =?utf-8?B?bUorQ012RDM2NHo2NXF5S0xGdGZwYVRLb0crMHI1ZkdHUEdoNUJtNU1qYllL?=
 =?utf-8?B?WkJJZW5Tc1Q1bFhCUGlDZGxIY1VXaFViNVo3RkRhVkZpdjMxUDlGVS8zQk5X?=
 =?utf-8?B?aXc2KzlxVUViMThYejZkVU8vOEJsRzFCQmhndHluV3VqemtaQXhSTmE2WUQv?=
 =?utf-8?B?ZjMzdDFBUlpIRzBXdVdHYzhGcDJ4RDhlcUVLNzJSR1BHODVPSHU2U3BuckUw?=
 =?utf-8?B?aHpNZmtMVzJlTFBxdVJuc3phYlZlaXNzdWp0Z1pYVVhJd094cTFkdXBZWWRC?=
 =?utf-8?B?S1VoS3hpOUFuYXRlUFY5cVJacXo3ellLN2lpNGVjSXNKUjR2V0ZNakExNnBV?=
 =?utf-8?B?QTJVdWVqZC9weUhZZkNuQW1STXlTclF4WjdkYlN3azlRZDlraHZPZUtwYS93?=
 =?utf-8?B?UEFMWGhwY05mS3ZYckZVQ3dhbzh3UGpOSU5aSkJEdEVTSWJadTJkTEx1Nk4y?=
 =?utf-8?B?NFB5S2s3NFp2bXFibytOU2dMK3FlNVJNSTFIYjhKSFp4MW82WitCK0pMdUxM?=
 =?utf-8?B?eFVLd3hCS0VDc0pWZjRuWG5objRVNjArQktqU0M4ME42RUUwUDQvRHA4RXgr?=
 =?utf-8?B?am1MWE9UZ29GYm4xT3J4SUpNb3ZVc2tGa3BTY0NpQzJCNzV6dlEySE50RGlC?=
 =?utf-8?B?WnJXOHo4ak5ic1IvRldOcUs4dU5oY2lDUDU3VGZtYjBnb2NMRVpXWFdrZG5y?=
 =?utf-8?B?K2xicTFtOEloNk5kdExkSXJIZkJoc0R4Z21heWZ4VFF4Z3lTK1JGODRHYTdG?=
 =?utf-8?B?cG9Iam5MNVkyL0JRRE8rVXRMRXpxNHVGSGZ2ZFk2b2pleEFhbFRlMFJLK1Rs?=
 =?utf-8?B?QWhCN2o0UzlEUDVjRlBGekIxWVc0RUVrUkZTcWJXV1ljTXlkY3YyQTN4ci9J?=
 =?utf-8?B?eStBSFlmRFJxRDVwRHFwUVFub2diWGp5WWRPRGk0T2hSaDlROTNQSmdCV3pW?=
 =?utf-8?B?UnB3L2ZTMVBNL0RlMWhtb01QRXFEZEQvMWpiU0pHc0VtK29iaDhBaTFLZTdp?=
 =?utf-8?B?Z1ZwUGp1UUIxdG5DdDIzVU5uYUxraVVmUys2djNwTEgrTFA1ZWJJRTJXbGQr?=
 =?utf-8?B?elZwbUYycjRVRHUwZ25pZk1iNUorbFRxTFRVUzZEL0wvQ3pFSEpKUG0wSnZJ?=
 =?utf-8?B?elZ6YlZRMG9tcnJ6dVdRSCtBekVabGsxSVhOM29DMXFLakNWNUVuRG9XeGxL?=
 =?utf-8?B?VlBsR3NOMzZDTUlPeG5LNWZpZ3ZtM21IM25oY0lkbnF6U1pSR2xrNHN1SHYy?=
 =?utf-8?B?UkZrMzJjZVAxTTVSZ1dTaEJUTzViYzVaN1I4cDE1SEYvQ3hQa205blUrOHhr?=
 =?utf-8?Q?1LoQfrd1EVXytjr6kaHJZaRFh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565ddb76-a9ed-48cf-fb77-08db7c63f6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 07:54:58.9386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMIE+ywqbis0Ikwj0DUVTtH9PFuyGIpYR0tKMsja8Rl9pqRgNEs9FJkQZinw5yaHyO0YipedcHP5ERjnAiB9XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8057
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMaXUsIEppbmdxaSA8amluZ3FpLmxpdUBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgSnVseSAzLCAyMDIzIDEwOjM3IFBNDQo+IA0KPiBPbiA3LzMvMjAyMyAzOjE1IFBNLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTGl1LCBKaW5ncWkgPGppbmdxaS5saXVAaW50ZWwu
Y29tPg0KPiA+PiBTZW50OiBTdW5kYXksIEp1bmUgMjUsIDIwMjMgMTE6MDUgUE0NCj4gPj4NCj4g
Pj4gVGhlIG9yaWdpbmFsIGRlYnVnZnMgb25seSBkdW1wcyBhbGwgSU9NTVUgcGFnZSB0YWJsZXMg
d2l0aG91dCBwYXNpZA0KPiA+PiBzdXBwb3J0ZWQuIEl0IHRyYXZlcnNlcyBhbGwgZGV2aWNlcyBv
biB0aGUgcGNpIGJ1cywgdGhlbiBkdW1wcyBhbGwgcGFnZQ0KPiA+PiB0YWJsZXMgYmFzZWQgb24g
ZGV2aWNlIGRvbWFpbnMuIFRoaXMgdHJhdmVyc2FsIGlzIGZyb20gc29mdHdhcmUNCj4gPj4gcGVy
c3BlY3RpdmUuDQo+ID4+DQo+ID4+IFRoaXMgc2VyaWVzIGR1bXBzIHBhZ2UgdGFibGVzIGJ5IHRy
YXZlcnNpbmcgcm9vdCB0YWJsZXMsIGNvbnRleHQgdGFibGVzLA0KPiA+PiBwYXNpZCBkaXJlY3Rv
cmllcyBhbmQgcGFzaWQgdGFibGVzIGZyb20gaGFyZHdhcmUgcGVyc3BlY3RpdmUuIEJ5DQo+ID4+
IHNwZWNpZnlpbmcgc291cmNlIGlkZW50aWZpZXIgYW5kIFBBU0lELCBpdCBzdXBwb3J0cyBkdW1w
aW5nIHNwZWNpZmllZA0KPiA+PiBwYWdlIHRhYmxlIG9yIGFsbCBwYWdlIHRhYmxlcyBpbiBsZWdh
Y3kgbW9kZSBvciBzY2FsYWJsZSBtb2RlLg0KPiA+Pg0KPiA+PiBGb3IgYSBkZXZpY2UgdGhhdCBv
bmx5IHN1cHBvcnRzIGxlZ2FjeSBtb2RlLCBzcGVjaWZ5IHRoZSBzb3VyY2UNCj4gPj4gaWRlbnRp
ZmllciwgYW5kIHNlYXJjaCB0aGUgcm9vdCB0YWJsZSBhbmQgY29udGV4dCB0YWJsZSB0byBkdW1w
IGl0cw0KPiA+PiBwYWdlIHRhYmxlLiBJdCBkb2VzIG5vdCBzdXBwb3J0IHRvIHNwZWNpZnkgUEFT
SUQuDQo+ID4+DQo+ID4+IEZvciBhIGRldmljZSB0aGF0IHN1cHBvcnRzIHNjYWxhYmxlIG1vZGUs
IHNwZWNpZnkgYQ0KPiA+PiB7c291cmNlIGlkZW50aWZpZXIsIFBBU0lEfSBwYWlyIGFuZCBzZWFy
Y2ggdGhlIHJvb3QgdGFibGUsIGNvbnRleHQgdGFibGUNCj4gPj4gYW5kIHBhc2lkIHRhYmxlIHRv
IGR1bXAgaXRzIHBhZ2UgdGFibGUuICBJZiB0aGUgcGFzaWQgaXMgbm90IHNwZWNpZmllZCwNCj4g
Pj4gaXQgaXMgc2V0IHRvIFJJRF9QQVNJRC4NCj4gPj4NCj4gPj4gU3dpdGNoIHRvIGR1bXAgYWxs
IHBhZ2UgdGFibGVzIGJ5IHNwZWNpZnlpbmcgImF1dG8iLg0KPiA+Pg0KPiA+PiBFeGFtcGxlcyBh
cmUgYXMgZm9sbG93czoNCj4gPj4gMSkgRHVtcCB0aGUgcGFnZSB0YWJsZSBvZiBkZXZpY2UgIjAw
OjFmLjAiIHRoYXQgb25seSBzdXBwb3J0cyBsZWdhY3kNCj4gPj4gbW9kZS4NCj4gPj4NCj4gPj4g
JCBzdWRvIGVjaG8gMDA6MWYuMCA+DQo+ID4+IC9zeXMva2VybmVsL2RlYnVnL2lvbW11L2ludGVs
L2RvbWFpbl90cmFuc2xhdGlvbl9zdHJ1Y3QNCj4gPj4gJCBzdWRvIGNhdCAvc3lzL2tlcm5lbC9k
ZWJ1Zy9pb21tdS9pbnRlbC9kb21haW5fdHJhbnNsYXRpb25fc3RydWN0DQo+ID4+IERldmljZSAw
MDAwOjAwOjFmLjAgQDB4MTA1NDA3MDAwDQo+ID4+IElPVkFfUEZOICAgICAgICAgICAgICAgIFBN
TDVFICAgICAgICAgICAgICAgICAgIFBNTDRFDQo+ID4+IDB4MDAwMDAwMDAwMDAwMCB8ICAgICAg
IDB4MDAwMDAwMDAwMDAwMDAwMCAgICAgIDB4MDAwMDAwMDEwNTQwODAwMw0KPiA+PiAweDAwMDAw
MDAwMDAwMDEgfCAgICAgICAweDAwMDAwMDAwMDAwMDAwMDAgICAgICAweDAwMDAwMDAxMDU0MDgw
MDMNCj4gPj4gMHgwMDAwMDAwMDAwMDAyIHwgICAgICAgMHgwMDAwMDAwMDAwMDAwMDAwICAgICAg
MHgwMDAwMDAwMTA1NDA4MDAzDQo+ID4+IDB4MDAwMDAwMDAwMDAwMyB8ICAgICAgIDB4MDAwMDAw
MDAwMDAwMDAwMCAgICAgIDB4MDAwMDAwMDEwNTQwODAwMw0KPiA+Pg0KPiA+PiBQRFBFICAgICAg
ICAgICAgICAgICAgICBQREUgICAgICAgICAgICAgICAgICAgICBQVEUNCj4gPj4gMHgwMDAwMDAw
MTA1NDA5MDAzICAgICAgMHgwMDAwMDAwMTA1NDBhMDAzICAgICAgMHgwMDAwMDAwMDAwMDAwMDAz
DQo+ID4+IDB4MDAwMDAwMDEwNTQwOTAwMyAgICAgIDB4MDAwMDAwMDEwNTQwYTAwMyAgICAgIDB4
MDAwMDAwMDAwMDAwMTAwMw0KPiA+PiAweDAwMDAwMDAxMDU0MDkwMDMgICAgICAweDAwMDAwMDAx
MDU0MGEwMDMgICAgICAweDAwMDAwMDAwMDAwMDIwMDMNCj4gPj4gMHgwMDAwMDAwMTA1NDA5MDAz
ICAgICAgMHgwMDAwMDAwMTA1NDBhMDAzICAgICAgMHgwMDAwMDAwMDAwMDAzMDAzDQo+ID4+DQo+
ID4+IFsuLi5dDQo+ID4+DQo+ID4+IDIpIER1bXAgdGhlIHBhZ2UgdGFibGUgb2YgZGV2aWNlICIw
MDowYS4wIiB3aXRoIHBhc2lkICIyIi4NCj4gPj4NCj4gPj4gJCBzdWRvIGVjaG8gMDA6MGEuMCwy
ID4NCj4gPj4gL3N5cy9rZXJuZWwvZGVidWcvaW9tbXUvaW50ZWwvZG9tYWluX3RyYW5zbGF0aW9u
X3N0cnVjdA0KPiA+PiAkIHN1ZG8gY2F0IC9zeXMva2VybmVsL2RlYnVnL2lvbW11L2ludGVsL2Rv
bWFpbl90cmFuc2xhdGlvbl9zdHJ1Y3QNCj4gPiBXaGF0IGFib3V0IGNyZWF0aW5nIGEgZGlyZWN0
b3J5IGxheW91dCBwZXIge2RldiwgcGFzaWR9IHNvIHRoZSB1c2VyIGNhbg0KPiA+IGVhc2lseSBm
aWd1cmUgb3V0IGFuZCBkdW1wPw0KPiA+DQo+ID4gZS5nLg0KPiA+DQo+ID4gL3N5cy9rZXJuZWwv
ZGVidWcvaW9tbXUvaW50ZWwvMDA6MGEuMC8wL2RvbWFpbl90cmFuc2xhdGlvbl9zdHJ1Y3QNCj4g
PiAvc3lzL2tlcm5lbC9kZWJ1Zy9pb21tdS9pbnRlbC8wMDowYS4wLzIvZG9tYWluX3RyYW5zbGF0
aW9uX3N0cnVjdA0KPiBUaGFua3MuDQo+IA0KPiBEbyB5b3UgbWVhbiBjcmVhdGUgYSBkaXJlY3Rv
cnkgZm9yIGVhY2ggZGV2aWNlLCB3aGV0aGVyIGl0IHN1cHBvcnRzDQo+IFBBU0lEIG9yIG5vdCA/
DQoNCmV2ZXJ5IGRldmljZSBoYXMgUEFTSUQjMCB2YWxpZCwgaS5lLiBSSUQyUEFTSUQuDQoNCj4g
U2VlbXMgdGhlIFBBU0lEIGNhbiBiZSBhc3NpZ25lZCBhdCBydW50aW1lLg0KPiBTbyBpdCBuZWVk
cyB0byBzdXBwb3J0IGNyZWF0aW5nIGRlYnVnZnMgZmlsZSBhdCBydW50aW1lIGluIElPTU1VIGRy
aXZlci4NCj4gTG9va3MgbGlrZSB0aGlzIHJlcXVpcmVzIG1vZGlmeWluZyBJT01NVSBkcml2ZXIu
DQo+IA0KDQpJc24ndCB0aGlzIHBhdGNoIHRyeWluZyB0byBtb2RpZnkgdGhlIGRyaXZlcj8NCg==
