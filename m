Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E36E629FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKOQ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiKOQ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:57:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C52F66E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668531440; x=1700067440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vwpSsF5SF01vGtNKQ+3OaEgMp6uIWUbQkEbrY5v0yGE=;
  b=gU8V+dd81/NyyFxlrNHiQU4sm9lQXAha4g3MXjIaDyQQI6y9f56EcMiA
   WYiHo3xleDriwFnEiq9SKQpXVy2/+5D7kOXA5I2CECDlg7ieplmGnQ3P1
   ZAj1OJywKf+DQhCRudyBMSvt2mKaKvQegJ7FYPohIkzOGSPNhPSccebfR
   3peSxJUZ1udvDc/+fnADFwqHEI7mdUa60uZuFQbpGm836siQZzAm1kPjV
   mhBZUSE3tq2aPB/fVAcCbc/J6zWTWPA7rgHlZV6/m5rRDeakzaMMKXvgN
   2PHJzUAYTnTWrVh8sEDXeFu6ikkidYoxoNusp7h3lNyVBFJP/ejm0dLSc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312309908"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="312309908"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:57:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="633295565"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="633295565"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 15 Nov 2022 08:57:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 08:57:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 08:57:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 08:57:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DepmxY6PC6W5z80Va2MEHegWHTeEvQSsrgLsgA3DB7FF7IbGuW3/SOHWKy1bmqN+Azr0c/JS0NZvk35310xNOZeYqWHovgZeRLWe148L4sEFjf790irChUFTkJ9nY0uZ/I7J839ouqur2EBPirHLgT/hewRr1FYUhT1U0aRhJCuceOV+uiYEfnV4X30u3UyXD4MWnV6XZpndNWZbwuTfNZHv1rtGuOmGDitQXQof5sipLS3sWoojnlXZEM4yn8fhlwVYbRULWkZpdnAKoQ4PXpi1qjAfk0r2xqkxtqNL9yUfKyDhw15bPV6Mai9bSukpaAY37k8o8O0ImZVLes2eIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwpSsF5SF01vGtNKQ+3OaEgMp6uIWUbQkEbrY5v0yGE=;
 b=RrpFg5AKkN5PeHoDSzj7Dg4xajsc1YYpOxao4XC9jSCi4EeM1wauoLzhFhumoK4FLiofUVxk3icBzYwGA1/xaUeivUaew4+D9l7/IS3ux+91mV+1EgwAmrE8GJJzno1hnogEeYigQtazzrKusp+h6x1meVeictvbvifVrPC8WDdp09q9oW3yUQ+RwRwYH8GQrx1hiEje635HcQ8t3NAcv3k6Z45m03Iaf7twYpMP+CqI+d7l3v7QRRR4/Y8Wrv5d8jZPOR5EOpL/o9OSFQwZg9EwBVgzj5223UPBRkIxWUgiQ/r6lUhkkjgHqdNQ4KPy+MCChz2zhy18KK5vCMRqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 16:57:17 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 16:57:17 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: CET shadow stack app compatibility
Thread-Topic: CET shadow stack app compatibility
Thread-Index: AQHY+H8FF0IkDR4atkCzeBv5Re4FS64/O3AAgABc0iiAAJ1hAA==
Date:   Tue, 15 Nov 2022 16:57:16 +0000
Message-ID: <3bab52bb0076a4921f824e438488a66d913b4deb.camel@intel.com>
References: <7d8133c7e0186bdaeb3893c1c808148dc0d11945.camel@intel.com>
         <CAHk-=wgP5mk3poVeejw16Asbid0ghDt4okHnWaWKLBkRhQntRA@mail.gmail.com>
         <87sfikvfho.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87sfikvfho.fsf@oldenburg.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL1PR11MB5303:EE_
x-ms-office365-filtering-correlation-id: bebd696a-1eb5-428c-acee-08dac72a73b9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vtBKZgzxyciSB3zOnLRrzdQqHF+hXXh/x+93K77ChFRZ2mLURXZNOB416ZBUuTAuWCzzFDI2WIHvr17DIZqP5icwaqLE8DG1UBtoTC+fJOSDUUMJSR4J9v0HWp5WzlTA+6KjY8NXfjJ9irQVBnZ77STistq+vj9A0m6n+qT+ccCWIA8yp7QjtUMnCd8HRfjOg5/GG7+474+MNm6aA+qJHs+A9ndg/FYpJ0H0TeimzLMCfOA+Cdmy2j54qU0mNWeK9+6L+lJh7agJOWakeiLPTv1q8LygHPFWiK4DTF8H2HTEbwU948c8EdS8AeDH1UI7EQBYkj0FapmOD0QdcQpnqETOEPsUNSCW+QdZkjtk5JiXkfKQgKGVeNYvwLbKv4GxA3mWqVBFG9gQyQuKM4a0ZYVuFIVf0cDB6H1IzoLEOFRlRpSqW9fvc3i30JS+2awCuAWwU0Eu5czAzfWg1EgT8lCmS8yM7H56totUhaEF5cxDBuByNrha6eyBvXE06FLRzZUkhgJOV1lt+qSLED6C7aBkXIPblbOqFM7BlocMskiB4mlyeMvZGaz206OeBOO4oXOxn2OfFiDGcScF7iGCIKeCo1767rEHF8zYoRnNxDbHdtqaiD4CEdsni8j3bHPKZTHVQ1a1oVCcwRt1KC4vMroRUS0SIY4qN1RdJ9/iN0jKhF+bMBuBjOcCIYKRTa5km6SPU8eDJJQQ0Jlyxw8e/swJ9nrRxwHoMKSOJHYdHLe3InaP+VFfAXWKA9F2hn82IbE5frkS3KWXut0x/y4usnLT9Bgk9qh5+TQI3KxahGM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(2906002)(4001150100001)(316002)(186003)(41300700001)(8936002)(36756003)(2616005)(5660300002)(26005)(64756008)(6512007)(4326008)(82960400001)(122000001)(91956017)(8676002)(66946007)(66446008)(66556008)(86362001)(76116006)(38100700002)(66476007)(6486002)(71200400001)(66899015)(54906003)(6506007)(38070700005)(110136005)(478600001)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cytKWENVbVZtQnhUT3NUSTJiZEhXenlzVFprd2pnRWtzUkJrdStNcEV3UEhv?=
 =?utf-8?B?UGxBdE45alVPSGdHc1RQWnpyZHlYL3Fia1BJbHpOSnhXc2x0K090ZkRLK2ht?=
 =?utf-8?B?blR1NHpUUHdzZ3NZaStCcWRIMG9hZmVFY2RiN05KdTE5MTgzclIvRkpSV0lr?=
 =?utf-8?B?SjI3cGRXRkppTXR3cVJVZDJmU2xFalcwTzA2c2hRcWhIcmZPa0QyMm1XWWZ4?=
 =?utf-8?B?VTBqQ3JWblBPMjkvNEJwSTg2ZlptQ2pWWWplaGR4aEpkYUtiOU96a2E5bVFC?=
 =?utf-8?B?c0NQNWN0V1ZuelRDY3hkWHY3YkJBdVZ1WE5DMG1NVjc0TjBLM1dRdTFRMXI3?=
 =?utf-8?B?VTJuNkJhUTgyUmNUdDB4L3lOdmhkOTBYTDlvalB1L0ZDVDVWR2NkTjY5V0lq?=
 =?utf-8?B?RC9iMWdJVUFENlZpZWNNQlE2VTVpdEExaVJvMlZkUEt5Wk84TlFEVWVSaXVP?=
 =?utf-8?B?T0tyNUZoSWwvSllvV2d2UzBJR25IbDRDWEVweTF4NndBMnVJa2RCK1NLNk1B?=
 =?utf-8?B?ZXJMYTJheEtMSWdRMUNMOW1DWDJsY1VQNVNIQWFtWlRiS3VVWWZpZ0RWYi91?=
 =?utf-8?B?b09LS2ViT2htbjlSM0JvR1Y0MEthZ29wdmNpTmNKNFVxYStKWUJpL1JocFB2?=
 =?utf-8?B?cXlOQ3BtN1BmaDdRWVJhM3dwYWxlNDdlYUNnS2FKbkF3dk91R1ZMbXB6blVw?=
 =?utf-8?B?dEY2ZU1ab2l2dnhhVmFjK0UvaUNlbFZzQTZMTkI3Q1VDM1Vrc3RPQnRuY2tk?=
 =?utf-8?B?VU9QcFVJTkxEbHUxMFJKNkk3YTJiVTZrYm1RR0NzS2dJRmIwVmpHdU5KelM2?=
 =?utf-8?B?WkFMbXZwczBDeTBWZzRFMy9IcHZZWHE0QU82U3E3eXlUNWZUS3lhNHpybm8v?=
 =?utf-8?B?SXB2aHo1aU1ISEE5NjJhSUdnYUxUM3RUaGRJL25ZQVV1c1ZMRUw1WGUvTnFr?=
 =?utf-8?B?NzI2MlhtUmJyU0hBdjA4cHBjT0RYUTNUT0NLV244VjRLcmRPMmJ0aVk0RExa?=
 =?utf-8?B?c0tZUUVXUTdkMzlaTUpiTDN4RCsvZkgvaW5Kc0pXd1EvMEtTQnE5TkVlUGFC?=
 =?utf-8?B?MTc2R3NhS04vWGFyTXZvWi9CVGFkZ3dCZDRxdnBLK2VnWG8wc2FkNnA4b05j?=
 =?utf-8?B?ZE9nNWxQRXh2WWlwUlQyejl4TXVZT2psWEdKSnduZVpvMFY0OVBNRFRtRk5X?=
 =?utf-8?B?TElCZVFtZTZieTA2ZGNIUXF6NWltT3d5ckNpbGJCYS9HQThLTE04K1dCT2VP?=
 =?utf-8?B?MWpwL3BQRi9LRys2OXJZWS9TeEhjYkFPWUFpMEtLWGxxaG84MGUrUlFvdlZt?=
 =?utf-8?B?VW5GaTlhNGpYaHkxemNqZ1BiLytGblZXMEZ6ZHV3NUVSblkvc2QzQlY5M1l0?=
 =?utf-8?B?MU95aGR4MWJGV3kvc3pxLzZ4UW4xbkdJOHJnSThEcU8rN1JONk05TWpZaHM1?=
 =?utf-8?B?eUxybFdUaHpMQlo1RjBpd0MvUEwzVmQzV2d4V01jQ3RIKzRmcnJweDUxd1Fy?=
 =?utf-8?B?MTZjbHNkVDlXbHg1amdQUHBHd2FoL1E2aHRYb0g1eHpPdis2K0lLeDdVbmNB?=
 =?utf-8?B?WisvZHBxUlJPWFNtc3lNM2hIZ3hhQVVBMWNjSlA3UVUvYXl0b2YzcFdNK25O?=
 =?utf-8?B?VU5IaXJKQ1dIK0c5RHcwNW5UaEloeG9DL1gxSzNhOW1VSG5Bc1RlRzZ4L3NO?=
 =?utf-8?B?TFM5ZXR3NytFRFJFZE1paFltZ0JqMHY0SXpleUhPWCtvVU1nZHNJR1hRV0Ro?=
 =?utf-8?B?bTNVRHE4SW81QWVNc3dFdkhWYXNISW9ieU8wZTNtYlQ1WjhFNTNIN3NnaENE?=
 =?utf-8?B?eHpvNURSMnlzMkh6R2RScU4vbDFHeDMwK0YrZkxoN3lnZ3lhQzIreGFtSzlh?=
 =?utf-8?B?b2phaWpvVGJDT1plaURNUndRa3BoQmpVeWYwL0p6eDIwamZNN2VVWDJLRlZO?=
 =?utf-8?B?cE9RdHRyMExqR2VkSFI3QXIrMjRQV0hNaDRoTDM3aWhsL3BhemRXR2FZSmhE?=
 =?utf-8?B?RkNraVdnUi9ZQWxuTTR6MUFpcFB1cUFhSk5ITFVVK2hIVkx3Q0dUdmxiRFZU?=
 =?utf-8?B?N1NaZ21KWTNmc1kyWm9Yb1VHakhKWWQ0cTZNZVREV2M5Vk5KOWxSVWNHeGxq?=
 =?utf-8?B?UXFRSDZZeVRaeXN2T2hrQ0FFSGFkU1dCWWFWb1FLRGpXRlNFRCsvUDZ4WVpp?=
 =?utf-8?Q?t98drEMyhY/uPHRccWFI2Mw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAF3406738619A4CAEC7055A4D8E60C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebd696a-1eb5-428c-acee-08dac72a73b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 16:57:17.0292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0+4hHTzVJztyjvIMlsf0I14tyhuz08yApF7nQBVKmBy9WFgK7VHb2xQiarFBbuZJ4aT4oFnIkK2kF310Gsm5uH/jSC5JRctY17LEuAMYzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDA4OjMzICswMTAwLCBGbG9yaWFuIFdlaW1lciB3cm90ZToN
Cj4gQmFzZWQgb24gd2hhdCB3ZSBoYXZlIHNlZW4gc28gZmFyIChhbmQgc2luY2UgZml4ZWQpLCBp
dCdzIG1vc3RseQ0KPiBzaGFyZWQNCj4gb2JqZWN0cyB0aGF0IHdlcmVuJ3QgbWFya2VkIHVwIGNv
cnJlY3RseS4NCg0KRm9yIHRoZSBiZW5lZml0IG9mIGFueW9uZSB0aGF0IGlzIG5vdCBpbnZvbHZl
ZCBpbiBDRVQuLi4gQXMgUGV0ZXJaIHdhcw0KanVzdCBkaXNjdXNzaW5nLCAiQ0VUIiBjb25zaXN0
cyBvZiB0d28gbW9zdGx5IGluZGVwZW5kZW50IGZlYXR1cmVzOg0KIklCVCIgYW5kICJTaGFkb3cg
U3RhY2siLiBJIGFtIGN1cnJlbnRseSB0cnlpbmcgdG8gZW5hYmxlIHVzZXJzcGFjZQ0Kc2hhZG93
IHN0YWNrIGluIHRoZSBrZXJuZWwuIE5vIElCVCBlbmZvcmNlbWVudCB3aWxsIGhhcHBlbiBpbiB1
c2Vyc3BhY2UNCmZvciB0aGUgdGltZSBiZWluZy4NCg0KRm9yIElCVCwgd2hpY2ggc2VlbXMgdG8g
YmUgaW4gd29yc2Ugc2hhcGUgdGhhbiBzaGFkb3cgc3RhY2sgZnJvbSBhbg0KZXhpc3RpbmcgdXNl
cnNwYWNlIHBlcnNwZWN0aXZlLCBJIGhhdmUgYWxzbyBzZWVuIHNoYXJlZCBvYmplY3RzIHdpdGgN
Cmlzc3Vlcy4NCg0KRm9yIHNoYWRvdyBzdGFjaywgaXQgd2FzIGp1c3QgSklUaW5nIGJpbmFyaWVz
LiBPZiBjb3Vyc2UgaWYgZ2xpYmMgaXMNCmNvbXBpbGVkIGluIG5vbi1wZXJtaXNzaXZlIG1vZGUg
dGhlcmUgaXMgYW4gYWRkaXRpb25hbCBjYXRlZ29yeSBvZg0KaXNzdWVzIGFyb3VuZCBkbG9wZW4o
KWluZyB0aGF0IHdlIGhhdmVuJ3QgZXZlbiBkaXNjdXNzZWQgeWV0LiBBbmQgdGhlDQpwYXN0IGlz
c3VlcyBhcm91bmQgbWFrZWNvbnRleHQoKSB3ZSBoYXZlIGFscmVhZHkgd29ya2VkIGFyb3VuZCBm
cm9tIHRoZQ0Ka2VybmVsLiBJZiB5b3UgYXJlIGF3YXJlIG9mIGFueSBvdGhlciBzcGVjaWZpYyBj
b21wYXRpYmlsaXR5IHByb2JsZW1zLA0KcGxlYXNlIHNoYXJlIHNvIHdlIGNhbiBkaXNjdXNzIHRo
ZSBleHRlbnQuDQoNCj4gICBUaGUgcG9zdGVkIGhhY2sgZGlkbid0IGV2ZW4NCj4gZGVhbCB3aXRo
IHRoYXQgY2FzZS4gIElmIHRoZSBtYWluIGV4ZWN1dGFibGUgaGFzIHRoZSBjdXJyZW50IG1hcmtl
cnMsDQo+IHRoZSBrZXJuZWwgd2lsbCBub3QgZGlzYWJsZSBzaGFkb3cgc3RhY2ssIGFuZCB0aGUg
cHJvY2VzcyB3aWxsIHN0aWxsDQo+IGNyYXNoIGFmdGVyIGxvYWRpbmcgdGhlIGluY29ycmVjdGx5
IG1hcmtlZCBzaGFyZWQgb2JqZWN0Lg0KDQpUaGUgcHJvcG9zZWQgZ2xpYmMgY2hhbmdlcyB3b3Vs
ZCBub3QgZW5hYmxlIHNoYWRvdyBzdGFjayB1bmxlc3MgdGhlDQpleGVjaW5nIGJpbmFyeSBoYXMg
dGhlIGVsZiBiaXQgbWFya2VkLiBTbyBpZiB3ZSBibG9jayB0aG9zZSBiaW5hcmllcw0KKHdoaWNo
IHRoZSBrZXJuZWwgY2FuIGVhc2lseSBjaGVjaykgZnJvbSBlbmFibGluZyBzaGFkb3cgc3RhY2ss
IG5vbmUgb2YNCnRoZSBsaW5rZWQgc2hhcmVkIG9iamVjdHMgd2lsbCBoYXZlIHNoYWRvdyBzdGFj
ayBlaXRoZXIuIFNvIEkgdGhpbmsgd2UNCmFyZSBvayB0byBob2xkIHRoaXMgaW4gb3VyIGJhY2sg
cG9ja2V0IHRvIHJlc29sdmUgdGhlIGtub3duIGlzc3VlcyBpZg0KYW55b25lIGNvbXBsYWlucy4N
Cg0KV2hlcmUgdGhlIHNoYXJlZCBvYmplY3RzIGNvdWxkIGNvbWUgaW50byBwbGF5IGlzLCBpbiB0
aGUgZXZlbnQgdGhhdCB3ZQ0KaGF2ZSB0byBibG9jayB0aGUgb2xkIGVsZiBiaXQgZnJvbSB0aGUg
a2VybmVsLCBhbmQgYSBuZXcgb25lIGlzDQpwcm9wZXJseSBtYXJrZWQgb24gYSBuZXcgZXhlY3V0
YWJsZSwgZnV0dXJlIGdsaWJjcyBjb3VsZCBkZWNpZGUgdG8NCmhvbm9yIHRoZSBvbGQgYml0cyB3
aGVuIGNoZWNraW5nIHNoYXJlZCBsaWJyYXJpZXMuIFNvIHlvdSBjb3VsZCBoYXZlIGFuDQpleGVj
dXRhYmxlIHdpdGggU0hTVEsyIGJpdCBsb2FkaW5nIGEgcHJvYmxlbSBTTyB3aXRoIGp1c3QgU0hT
VEsxIGJpdC4NCg0KSXQgd291bGQgaW5kZWVkIGJlIG1vcmUgZGlmZmljdWx0IGZvciB0aGUga2Vy
bmVsIHRvIGRldGVjdCB0aGlzLA0KZXNwZWNpYWxseSBpbiB0aGUgZGxvcGVuKCkgY2FzZSwgYnV0
IGl0IHNob3VsZCBub3QgcHJldmVudCBzaW1wbHkNCmJsb2NraW5nIGFueSBkYXkgMSBrZXJuZWwg
c3VwcG9ydCBiaW5hcmllcy4gUGxlYXNlLCBwbGVhc2UsIGRvbid0IGRvDQp0aGlzIGluIHRoZSBm
dXR1cmUgaWYgaXQgY29tZXMgdXAgdGhvdWdoLiBJZiB0aGUga2VybmVsIGNhbid0IGZpbmQgYW55
DQpnb29kIG9wdGlvbnMsIGl0IHJpc2tzIHNoYWRvdyBzdGFjayBnZXR0aW5nIHJldmVydGVkIGZv
ciBldmVyeW9uZS4NCg0KPiAgIFNvbWVvbmUgaGFzDQo+IHRvIHN0ZXAgaW4gYW5kIGZpeCB0aGlu
Z3MgZm9yIHJlYWwgKHNvIHRoYXQgdGhleSBkb24ndCBicmVhayBhZ2Fpbg0KPiBqdXN0DQo+IGFm
dGVyIHJlYnVpbGQgd2l0aCBhIGN1cnJlbnQgdG9vbGNoYWluIGFkZGluZyB0aGUgY3VycmVudCBt
YXJrZXJzKS4gDQo+IFRoZQ0KPiBrZXJuZWwgcGF0Y2ggbWFrZXMgdGhpcyBoYXJkZXIgYmVjYXVz
ZSBpdCdzIG5vdCBwb3NzaWJsZSBhbnltb3JlIHRvDQo+IHVzZQ0KPiBhbiBleGlzdGluZyBkaXN0
cmlidXRpb24gZm9yIHRoaXMga2luZCBvZiB3b3JrLg0KDQpUaGVyZSB3YXMgYW4gRVhQRVJUIGNv
bmZpZyBmb3IgdGhpbmdzIGxpa2UgdGhpcywgYW5kIEkgd2FzIG11bGxpbmcgYQ0KcnVudGltZSBz
eXNjdGwuIEJ1dCBJIHRoaW5rIG5vdyB0aGUgaWRlYSBpcyB0aGF0IHRoZSBwYXRjaCBjb3VsZCBz
ZXJ2ZQ0KYSAiYmV0dGVyIHRoYW4gYSBmdWxsIHJldmVydCIgcHVycG9zZS4gTm90IGFuIGlkZWFs
IHNvbHV0aW9uLg0KDQpCdXQgSSBzdGlsbCBkb24ndCBzZWUgd2h5IGRvaW5nIHRoZSBvcmRlcjoN
CjEuIGtlcm5lbCBzdXBwb3J0DQoyLiBsaWJjIHN1cHBvcnQNCjMuIGNvbXBpbGVyIHN1cHBvcnQN
Cg0KLi4ud291bGRuJ3QgaGF2ZSBnZW5lcmF0ZWQgYSBtb3JlIG5vcm1hbCBzaXR1YXRpb24gd2hl
cmUgb2xkIGJpbmFyaWVzDQpkb24ndCBicmVhayBhZ2FpbnN0IG5ldyBrZXJuZWxzIGFuZCB0ZXN0
aW5nIGNhbiBlYXNpbHkgaGFwcGVuIHRvIHJlZHVjZQ0KaXNzdWVzIGZ1cnRoZXIuIFNvIHdlIGNv
dWxkIHN0aWxsIHJlc2V0IGFuZCBkbyBleGFjdGx5IHRoYXQuDQoNCj4gICBJbnN0ZWFkLCB3ZSdk
IGhhdmUgdG8NCj4gd2FpdCBmb3IgYSByZWJ1aWxkIHdpdGggdGhlIG5ldyBtYXJrZXJzLCBhbmQg
b2YgY291cnNlIHRoaXMgcmVidWlsZA0KPiB3aWxsDQo+IHB1dCBpcyBpbiBleGFjdGx5IHRoZSBz
YW1lIHBvc2l0aW9uIGFzIGJlZm9yZTogdGhlIGluY29tcGF0aWJpbGl0aWVzDQo+IHdpbGwgYmUg
YmFjayBiZWNhdXNlIHRoZXkgYXJlIG5vIGxvbmdlciBtYXNrZWQgYnkgdGhlIGtlcm5lbC4NCg0K
UGVvcGxlIGJ1aWxkaW5nIG5ldyBhcHBzIGFuZCB0ZXN0aW5nIHRoZW0gYWdhaW5zdCB1cHN0cmVh
bSBrZXJuZWxzIGFuZA0KZmluZGluZyBpc3N1ZXMgc291bmRzIGxpa2UgYnVzaW5lc3MgYXMgdXN1
YWwuIEknbSBub3QgdHJ5aW5nIHRvIHNvbHZlDQphbGwgcG9zc2libGUgdXNlcnNwYWNlIG1pc3Rh
a2VzIGZyb20gdGhlIGtlcm5lbC4NCg0K
