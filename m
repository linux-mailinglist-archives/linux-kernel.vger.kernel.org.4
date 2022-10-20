Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05448605713
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJTF7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJTF6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:58:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7469919B640
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666245532; x=1697781532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NPRF/qRdkKg49YTst0Jj7J626/THuL1lZWvyDY/u1UU=;
  b=nM5JrtS+6Dan/9cdOtfCruLNEfQofCidus0JUGLy/1qqG1CGQS9ivSmK
   G4/9AK1D/JSPBku92EthohqKbCqdhPs5trYgdT8+vVY+5G39ororv/v7C
   p8zewQDMX2WRI1r8Uy3/iA9HcxX3m9O7ozhuyUFUDOslw0BC3RvU7uiyP
   n1SR/q7vrfDbUiXzIDgWTG3V3fH8/ZNHGKBGGAVRafRqKu6UJOd67/PJl
   5AhIhsvdqLitDn6NCFiN+PfUKEjl3VpZMR3QnTVqD7J06HxkMWZd4YKh4
   M0+062P9x2UmTwaFbF5StkAUtE86vghG8bgIsokVsP/lBOULUwn5P9fWl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="294006209"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="294006209"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 22:58:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="754933603"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="754933603"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2022 22:58:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 22:58:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 22:58:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 22:58:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DisHaAK4aLRaXTcO8ufMmr3HzuQRnQ62xQ7WSLD/xDHtsigTxLG0B2RF1O+Q5/LaBzGJfMMc93K+vzLT6sePDRNHNrTPcOn1RAtnULAcSJ9KLi5AouP6Z9zZgVamJmaz80B23Cs7GX58fexAF2ML4WC9K+cAvp1MnjOrRpoy3OICwNgB8p5DYoBjhvn1ui6ElMtT3Jsa7KBABIwK6uitJCiCnxDtj/jQbk2j3advmlZs4ZNDIwN0DeiLwT8qH+o5nw04Eg0x+aBtoLGOQUwjUwVim2WDmXk5LIFoNHL9ChcHB7sWeGXZyPxBgdzoFwk1RWQiIw3Vlvl10s6R40CNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPRF/qRdkKg49YTst0Jj7J626/THuL1lZWvyDY/u1UU=;
 b=X3iVFr3KKfQrDh3jVislwwNAZQO80PevaqGBtQufYNvwRxOlka1U9F/alacM3NA8bTMAzLBGMm+MjhvHpiSz+hspoWHi3WNr1Nj4Aox76YiUKLcLsYPwkkzp3h6EY84B2XGgUwrxqe0GO9y7FzqIJH7lQbX7NcP42IzErYXjYPsaexebuacyBlF/y/M6NJ4rVjjLpLL1XgMxJVfCY0toKPLoRKxnSGBOex9XJvvkyf+q9okcqjnJt83/08DjyIy3kVvYPDHDIzV7xY1gGQetqQJigCTCJUzOqyGA2LkuuAlxsHsHWN6+gPQtMADlZ1Vf6xJ9/cKYmkpQLXibGmOA+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by SA2PR11MB5019.namprd11.prod.outlook.com
 (2603:10b6:806:f8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Thu, 20 Oct
 2022 05:58:13 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5723.034; Thu, 20 Oct
 2022 05:58:12 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Gross, Jurgen" <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: RE: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Topic: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Index: AQHY47Kv7yW3S865XEiTjYU/Nl/o964VodIAgABWNFCAAMBdgIAAC5Gg
Date:   Thu, 20 Oct 2022 05:58:12 +0000
Message-ID: <BN6PR1101MB21614EE46D700C24E7D77E8FA82A9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221019095035.10823-1-xin3.li@intel.com>
 <20221019095035.10823-6-xin3.li@intel.com>
 <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
 <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <7bbc19c8-3494-1770-d186-ce5a92d511aa@suse.com>
In-Reply-To: <7bbc19c8-3494-1770-d186-ce5a92d511aa@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|SA2PR11MB5019:EE_
x-ms-office365-filtering-correlation-id: 3f29ad64-a11b-4bb0-2527-08dab26012e0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9//lb4WELl1MTAaBvT/PGfEoY0u3zg4lfw4qsh7cSSpDXRTKRD5VFm8HDF2sWZEKCpBAs6EaNxdynm7hIhfnXsBz6QatUoR9azJjRjAE4/qHQJf5bZq5+P0SK9O6u7f3ke6tUd7rkcMoCuD4AJWNInXx3ubmTmuUtdAyJk/OXwXqSPff7aOoL0p5+BtGPbuaTJUs2ZdFUaw8acoD+7lkCJMg6e/jBEYUhS32sSlUzv+DIyDu/84krDa/lJbs4sCLAzcU4kbYrMAhpibLKfwMI/fqZ/211K3pVwVk+PpMUDg1KwZvvEYAfHemdZgR/itALV7e4KZua++GQO+WjdA7jngvHpyrov6rV7kA5rXCRKjuIws4SNRQyYNEPLi71DFWLwNL/g6onTu82jIQIKMC2H/m56Y5yHZBH8Ji50h8j8Ep6lGF3TJFJGXPhoiwgbFQ0HxGAsORjuG/rJgoUoU9gZpBDqvcYza5orW4pAc1CSVby++pZbyjvpiaqbmsZglMNtHooVt0aDjb3lM3kfMNE5TuswNCC953IJCRw03vHfG+26w5cbYao66J01HWHCCENeAM5D1ks7agAz/tP5gYQdNUmYv2mscE75ofaSIxLfVCn+6uVHUNP6wqAhs9mdh0Bo3M04v72NHzTbLROQeEFbn0kJScJjFjiAAYZ4hfppzCu/Efofc64NHBl0uwE0GZ2NxdsDdwFoZQrkJVlM+jvA5LK82nIpW6pBCrT/quqBXcgn/Aidqb1gtHQqdwkYIMAFv36xiTHHSWy8GDzB33Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199015)(38070700005)(26005)(33656002)(82960400001)(55016003)(86362001)(38100700002)(83380400001)(122000001)(316002)(478600001)(71200400001)(4326008)(186003)(110136005)(54906003)(7696005)(41300700001)(53546011)(8936002)(6506007)(5660300002)(9686003)(66446008)(52536014)(64756008)(2906002)(8676002)(7416002)(76116006)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2E1cnN2NFk1K1phcGRtS3VJNVRTVFVlSVF4RWsxMmdXTjNFbFhMQlVKYVhJ?=
 =?utf-8?B?dkREaFEyZFRmcCtZZGY2Ym1MNVBLU1Fha3JXYVI5NFVMWGJpdE5yb1pCeHVC?=
 =?utf-8?B?azJMSTZoRU1FQ3RQVHpPNThPa01DRXJHSSt0RFBGbmxRWDI1ZVpSRGtiVkdM?=
 =?utf-8?B?T2UvaUZhNXpoLzdxeTBnY1kxd3ZWbzlqRGtDdEZhZzB5QWE2SCtzUitmblJy?=
 =?utf-8?B?R1Rhbzg5Ky9ETW9mWEVvRllJUVI1bkZGOWxHZmtrWEcrbCsrczhqaWltank4?=
 =?utf-8?B?OTZ0eHo5MkR2RVJCd1VnSWpLTnFmSzdxTkFieHQyWjAzWnViYjJYbGZOM0Yr?=
 =?utf-8?B?cFBlZTBleTl1SHNiV0J2RHRuOFRrbEpTZzZrWEM3K3FOWEVQai85V1FSNlBj?=
 =?utf-8?B?bFdFT3NYMmVqSXQvUEFWa09QY1V2TTFxdG1zRzd3R0hQRUg4VG8zeTdOOEc1?=
 =?utf-8?B?b0IvcE50V09XR1BQN2pJZTNOYWYyYlhkcU14TW13VVQvaStJRHNDdUswSkph?=
 =?utf-8?B?Z1c2cHd5elJtTndYbHc1RzZmVlpSN2QrYWZGMkNLdnp0NklyTUZ4OFdhMXRo?=
 =?utf-8?B?Uk9kVEFObml4bWVtbEFMTUlxR3JWYzN6MGI1WUkxZ2NSdXNuajJnUFFBaCtv?=
 =?utf-8?B?cEc3MlI3Q3ZMR0R1R01xTG1lNkZ5K2pYU1d5eEZvSGtjd1RsQ2pHZ2VrY0Ry?=
 =?utf-8?B?YlJhdXljdTFsN0VHa0E2MkRENTFLanJyQ0xDaGI1QUpqWTBTZk8xM0JpZ0ls?=
 =?utf-8?B?blVCTWEyV0FiZUlRSXVRUVBRUTZuS1hzRFpwdGJBVm9USFNRZURoSjNEUXFI?=
 =?utf-8?B?SVVxR2U2a3l5QUFxWWYwb0t4enJ5VEpPL3ppRnhXTWlWVlYwQkIraVFDWEs4?=
 =?utf-8?B?OWdMZlZHanY2US9xNXIrNXJzdnN3dHlhZm85YXFYNTBxZHM4SHhRRjRIc2NM?=
 =?utf-8?B?dFE4VGdQWXFZclhjZXBDZTRHb1hNZlgyaU4vaDFOeW1MazR0dTlmUmJJVDN0?=
 =?utf-8?B?djBmSHlGSk9udDZhdUNON01IemVZVDNJZnA0ajRJS0tZNStKNzhUeCtzd01p?=
 =?utf-8?B?VmdVZk5QUmJQU0hTbW9XaWM0N2tCdnBOSkxjR08weE5RUGdMVFdJeFFVakkr?=
 =?utf-8?B?TmZqNVhZamFnNDdnMXdkK0hkbEEzRktqZHI3TDBqVzZGV1p2dHVteGhxNVhp?=
 =?utf-8?B?dVo4UVpDTU80QlRCbmFoME1tdnRnRVQ3cXNzT1NlTmxVQStsb3crZ1hZRnFh?=
 =?utf-8?B?TnA5bDhSYlpWOG5vOWhwYjRONTVWUzUrY2FMOWNjdFBxKzdSNUE2bTNHcW16?=
 =?utf-8?B?UkRxRU4vN3FpQ2ZSSmxzbVZ0bHl2TTlZUVVadWI4V3VrTmlnalYwRm5lQkNl?=
 =?utf-8?B?UmVnaWNEK1VreVVyTndxY3EwQzlESEVTMGVkTjdUU3UzaTNXMXpPM1V4NFk0?=
 =?utf-8?B?c0NrVGc3TU8ySU9HOVdDRndCZFcvaDRENkh3a3Y4ZXdac3VINE1pa0lUTTc4?=
 =?utf-8?B?S28xV1Q5MklHaTFGcFhYYW5GRFBqMmF0VlQxTllJcnY5dHJuOENEUEYydC80?=
 =?utf-8?B?WW1vdDk2eGRTK0dtMG1KcU4yM2U0am9BeTUrTWpCU094T0ZaWVhjUEZRSVIv?=
 =?utf-8?B?dDFlcTZGdFdIdlZJd2hOUEdHallySUdqaTh6ekJGZlhLbmVPMXNRcnk2Wlpk?=
 =?utf-8?B?WTZyOWdBUVdhTGQ0ZjlUcmN2MXk2YXdpWlUrSkN1K2ZSbVdCNWFIZ0s3WXht?=
 =?utf-8?B?cjhmdXlvamxmNTJIS2tJVzBORXlwMFpqMERndmh6M2NJc1UrODc4Vng1bUox?=
 =?utf-8?B?THgycWxrdHp1ZkpIMzJRSWNhWm1td0RwZjJKK0lUcngzSDlvSDgxcmxteEhP?=
 =?utf-8?B?OXA5c1pxWkowTE4yWUtmckR4S2xrUThHSmFIYTVRMzgxeVhOWXA1UW4yekx2?=
 =?utf-8?B?RDBXTFlTTFdYaEpSb1dZSjhkV2YvdmlEM0JheDY0Vk9VbDlUbWtwd3V2Tm40?=
 =?utf-8?B?RDBYcEpuKzVjSDc0eUxFNDA4aTBJaW9yVGdJcXNiVnlpK0w3NUlXOGNRUFZx?=
 =?utf-8?B?MkFQVDhUZ2dvQmZzamZMQjlzNlV1SVA0TnpQbWd6MmYvNnV0amYyZWlzYnVG?=
 =?utf-8?Q?4ST4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f29ad64-a11b-4bb0-2527-08dab26012e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 05:58:12.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9PtlSB4d4FLBJ+Wa09EE4qWZBGQ5I8eVda7N1jJ1zsiaV0Ws6/kcMS+5PdSr78B4Bbj/kSEXXQOvvlN5bXRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxOS4xMC4yMiAxOTo0NSwgTGksIFhpbjMgd3JvdGU6DQo+ID4+PiArc3RhdGljIGlubGlu
ZSB2b2lkIF9faW5pdCBsa2dzX2luaXQodm9pZCkgeyAjaWZkZWYNCj4gPj4+ICtDT05GSUdfUEFS
QVZJUlRfWFhMICNpZmRlZiBDT05GSUdfWDg2XzY0DQo+ID4+PiArCWlmIChjcHVfZmVhdHVyZV9l
bmFibGVkKFg4Nl9GRUFUVVJFX0xLR1MpKQ0KPiA+Pj4gKwkJcHZfb3BzLmNwdS5sb2FkX2dzX2lu
ZGV4ID0gbmF0aXZlX2xrZ3M7DQo+ID4+DQo+ID4+IEZvciB0aGlzIHRvIHdvcmsgY29ycmVjdGx5
IHdoZW4gcnVubmluZyBhcyBhIFhlbiBQViBndWVzdCwgeW91IG5lZWQNCj4gPj4gdG8gYWRkDQo+
ID4+DQo+ID4+IAlzZXR1cF9jbGVhcl9jcHVfY2FwKFg4Nl9GRUFUVVJFX0xLR1MpOw0KPiA+Pg0K
PiA+PiB0byB4ZW5faW5pdF9jYXBhYmlsaXRpZXMoKSBpbiBhcmNoL3g4Ni94ZW4vZW5saWdodGVu
X3B2LmMsIGFzDQo+ID4+IG90aGVyd2lzZSB0aGUgWGVuIHNwZWNpZmljIC5sb2FkX2dzX2luZGV4
IHZlY3RvciB3aWxsIGJlIG92ZXJ3cml0dGVuLg0KPiA+DQo+ID4gWWVhaCwgd2UgZGVmaW5pdGVs
eSBzaG91bGQgYWRkIGl0IHRvIGRpc2FibGUgTEtHUyBpbiBhIFhlbiBQViBndWVzdC4NCj4gPg0K
PiA+IFNvIGRvZXMgaXQgbWVhbiB0aGF0IHRoZSBYZW4gUFYgdXNlcyBhIGJsYWNrIGxpc3QgZHVy
aW5nIGZlYXR1cmUgZGV0ZWN0aW9uPw0KPiA+IElmIHllcyB0aGVuIG5ldyBmZWF0dXJlcyBhcmUg
b2Z0ZW4gcmVxdWlyZWQgdG8gYmUgbWFza2VkIHdpdGggYW4NCj4gPiBleHBsaWNpdCBjYWxsIHRv
IHNldHVwX2NsZWFyX2NwdV9jYXAuDQo+ID4NCj4gPiBXb3VsZG4ndCBhIHdoaXRlIGxpc3QgYmUg
YmV0dGVyPw0KPiA+IFRoZW4gdGhlIGpvYiBpcyBtb3JlIGp1c3Qgb24gdGhlIFhlbiBQViBzaWRl
LCBhbmQgaXQgY2FuIHNlbGVjdGl2ZWx5DQo+ID4gZW5hYmxlIGEgbmV3IGZlYXR1cmUsIHNvbWV0
aW1lcyB3aXRoIFhlbiBQViBzcGVjaWZpYyBoYW5kbGluZyBjb2RlIGFkZGVkLg0KPiANCj4gVGhp
cyBpcyBub3QgaG93IGl0IHdvcmtzLiBGZWF0dXJlIGRldGVjdGlvbiBpcyBnZW5lcmljIGNvZGUs
IHNvIHdlJ2QgbmVlZCB0bw0KPiB0d2VhayB0aGF0IGZvciBzd2l0Y2hpbmcgdG8gYSB3aGl0ZWxp
c3QuDQo+DQoNClllcywgYSBYZW4gUFYgZ3Vlc3QgaXMgYmFzaWNhbGx5IGEgTGludXggc3lzdGVt
LiAgSG93ZXZlciBJSVJDLCB0aGUgWGVuIFBWDQpDUFVJRCBpcyBwYXJhLXZpcnR1YWxpemVkLCBz
byBpdCdzIFhlbiBoeXBlcnZpc29yJ3MgcmVzcG9uc2liaWxpdHkgdG8gZGVjaWRlDQpmZWF0dXJl
cyBleHBvc2VkIHRvIGEgWGVuIFBWIGd1ZXN0LiAgTm8/DQoNCj4gQWRkaXRpb25hbGx5IG1vc3Qg
ZmVhdHVyZXMgZG9uJ3QgcmVxdWlyZSBhbnkgWGVuIFBWIHNwZWNpZmljIGhhbmRsaW5nLiBUaGlz
IGlzDQo+IG5lZWRlZCBmb3Igc29tZSBwYXJhdmlydHVhbGl6ZWQgcHJpdmlsZWdlZCBvcGVyYXRp
b25zIG9ubHkuIFNvIHN3aXRjaGluZyB0byBhDQo+IHdoaXRlbGlzdCB3b3VsZCBhZGQgbW9yZSBl
ZmZvcnQuDQo+IA0KDQpMS0dTIGlzIGFsbG93ZWQgb25seSBpbiByaW5nIDAsIHRodXMgb25seSBY
ZW4gaHlwZXJ2aXNvciBjb3VsZCB1c2UgaXQuDQoNClhpbg0KDQo+IA0KPiBKdWVyZ2VuDQoNCg==
