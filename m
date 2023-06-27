Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DFD73F2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjF0Don (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjF0DoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:44:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A06F35BD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687837271; x=1719373271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JO4JdODYlfxT17ICdw/boLEoZM1wHW3GaGdkdzXSpbE=;
  b=oFolWxQBZJWJwMLn+w2bez/G++mo7pThZonnOQaEPHb099LjazmOiBal
   4J1ySHNAnZpwQ6HPYBBiCokPH2MpnAQOeCJz9G68lpo5o3jeG37fnkvTY
   3osbdix3iTi1DRB2eyZ/4AuD5bPu5eq7hk8tNJssJ6h7Oa5cT3hWV7JLV
   lAXhJq9bpFaZlhiV8UrgLS4JuynSA69z0fLzkBQqzStISKTkHCKKMZjFn
   yIZ4CvU71SMvwxKsyLV/udFXDKJPF+RBv3F40ChbCOnfRxOA/3BEPMpsu
   0RbFuTwXY974vGfwWeeECKmS2yDkjQTK/ZgY9A3eBR96NFXAFaBL2STJn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="351246371"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="351246371"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 20:40:23 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="751463723"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="751463723"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 26 Jun 2023 20:40:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 20:40:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 20:40:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 20:40:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNoS9V6eR+eK/cjDylD49uUeoRk+iB2IikF0PCl1mZH/Kx9hdsb37iIaoz454xpKQGndtbd8rwcIjcmVEWAMWju59sAIhRxCaYRsT+XmNDO0j6nAIIkrl2H9FWkWLq0y8ZtfQcFbF9jhWJO+j7zIBCCG8jtEGdjHApma86N7X+e8R6VmNWQjnzHu/kx0y+8umHOpCZaDPHRSVpjUPndZCVqqTSOkmUmZBbPcfMZigDBO7sCUEA8aZ4A3rcdqETPnMbqm2ajfivJiVJuTJgNTvodXvbnqGGLigvMEwzv8o8xW6f7hFF2PJ4d7johz56danVbS+yKvsRmZbUufiHT89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO4JdODYlfxT17ICdw/boLEoZM1wHW3GaGdkdzXSpbE=;
 b=T4sM4oVM7Eho/bZocnA/ALkEIVxuqKF4DDYhFBH+mvpGhg3VzyAPSFEULlurc0sm2jnZ9l9N46a+QXs40ncIhbQ6yf+NhtRGTsYEHXZTEyZeStSyhdiATPM7BhDp7ci4ouMEbdXIJ6fLiqruUPiNEF2mJDIiYUcjDXmt8z0DhI1SLPxeR9N6vo2CPD1YD0j5jkTGeWjACCzKeJEJlrd1m61QYTSaeGb1lLO0+uGIPc/w9XEMFnrkJ1LDzP+Z69MdU+hbkW/vVf/ftN2wL/j8VsZViBk0SQE4ACFozJWNPmdaOt0ARWdPXsYC3Gc7SHP2wNHdetwKg5Kxly0aMKd0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 03:40:06 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049%4]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 03:40:06 +0000
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
Thread-Index: AQHZpOcz4yOfuGedVUe15UWfk8cDPK+WjIqAgAAxu4CAAAfJgIABXnCAgAAJrwCAASC+IIAAQrOAgALqkRCAAE0tAIABPBqQ
Date:   Tue, 27 Jun 2023 03:40:06 +0000
Message-ID: <PH0PR11MB5673A2BA9D39B9CD4C775DA5CB27A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
 <20230622122114.592791-1-kah.jing.lee@intel.com>
 <25439c1e-c9ef-0dc6-8d91-883d7734d0fd@linaro.org>
 <PH0PR11MB5673A862187810E9986E3C8BCB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <125c849f-3746-864f-8b8f-6e0a33aca439@linaro.org>
 <PH0PR11MB567334A09B2D4A1D3DDC09F2CB20A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <0599fc9c-0057-7aa5-3332-40922753ad97@linaro.org>
 <PH0PR11MB56734DB18155588535DC0384CB26A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <12c68124-9687-d68c-294a-2bfd13338edd@linaro.org>
In-Reply-To: <12c68124-9687-d68c-294a-2bfd13338edd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|IA0PR11MB7910:EE_
x-ms-office365-filtering-correlation-id: ca329189-133a-4f38-0007-08db76c0330c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H6xXK//jFX1K/gtenjmAwXCI8qBjAxFU9HVA/paTmnRsPaF5Iu3Incu4gbEVX4DrSH8a2kMkbpaVDp9buk90hM6JgrI6MgvT3JqwdP4BEldz2678YBAK7+xcNkbY571f/eB2gLJ8AFQIyeodLFsODuuky/lu9Zv9HVe/IR4PJ0VzCSBZEknTBWJsSNrVQkLDdQWA+KW6gugAoSbcMP+pgreP4/p5riMqG7Zap0SP0vrwv/m921y9v/BR91XJgcfRplZ8ruAwU83TuHPaZ9RYMJ6V4tqTae/OqvuLN80rxFp03WUkbuonGXLZqS4og000dqKxwfEYIypDEVQanXS8mwmA1Tr+upPkGCu6HbqMU3MbNBrIRnJV+VFCW85u/2yl17+dPN2E1wcrcQmhueRGws32yImywycXnAqcuhiq0kukcsaIo4vcc4dVFV8iFkhF19eb8UO+MDo6CL0CFWAqNKaenS1/ow8ar6ruHAENGEbtOASteaUf1A2HBecjDwoCYxn0QxptnU8h7ibvAPnFR0to2EbaY++ihWNFqX/CDc4EyehjF3X59HDrAVoZA4G5//zE3DcT07IINHLZL0uw53d/knmVdAJ+1td+uUEyBqs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(53546011)(66446008)(966005)(7696005)(110136005)(83380400001)(71200400001)(26005)(9686003)(6506007)(2906002)(478600001)(186003)(5660300002)(52536014)(33656002)(4326008)(122000001)(38100700002)(316002)(82960400001)(55016003)(38070700005)(66946007)(66556008)(86362001)(66476007)(41300700001)(8936002)(8676002)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXNSdzJWbWEyb1ZlS0RoWmRUV2lKck9nb0IyY1VmVVJUOGdIUDhieTRCWTYz?=
 =?utf-8?B?Q3ZqR3Z0SzVuL1hWTlBPdStUTVcwSWtIM2paVmRJMnZSRlZ6c0tSUnRybU1s?=
 =?utf-8?B?T2hJcmV4T2NmMkowZWRFdVhCanhCOE5XMzZEb1doRkhWQWh3MGlnNU5mTmp2?=
 =?utf-8?B?UDIzMDMrLzZab3dWVXZqTHBSZEVrK2NhclJXYzM2U3hjWDQ3Um41dFBpU1E4?=
 =?utf-8?B?dWtqakoyYkxvWUhqWGpTNnBlL0hXeU1jK3NuMFJzNk41YXkxQWQyRTlEWXJD?=
 =?utf-8?B?dmFKRVFaZDIzL0Irb24xYXVxS05wWTAwRm1CSUJhcHdxRTErTEMyaFZ3VjNl?=
 =?utf-8?B?MnZzVGhvNDdnVWhRaTdEbUZoRFZPSmY4eFhPM3Z2V1ZvaFJJNGdiVGUyMWdO?=
 =?utf-8?B?cVJjRHk0YXRqWkxETW9NZ0I3c2s1RHpBV0hRM2lDRkdYTmFBdWlocHppUXlF?=
 =?utf-8?B?RUlTWXZOeVp0a2dtbWNRTEhydnNVc1NBM0ZWWVFXRTU3clpsYUZHbExObnZ0?=
 =?utf-8?B?T00vYTYydThDUTNMYndqblRQRlNpbGxuK3V3MjlDSFVOcHVNbmh0alZQcktH?=
 =?utf-8?B?VFJYN29BQ25qbW8vbXVGVUtlWXE0bUNnZVgvaU9XRFQ1MkhadE9PUjJkTElS?=
 =?utf-8?B?eXZLaGtXSnlJNDZTSWtVcGRNOEdpNVluV3dyNjIwT3hyZ1ZuZkdEV0Z0NHp4?=
 =?utf-8?B?ZjZSZzRyeUpxc3BKcElLTlRKcUhDamJHUDJkUnA1L285QkVPbTdSbis5OFNC?=
 =?utf-8?B?SXV4OXBJVXVuMk9jZjZCQmtCa3dwcGdvZnJVRFFCTGxxQkhXeHBWNnQzOHNm?=
 =?utf-8?B?MDduejBaN1ozU2lrMzBSUnJWMks5ekt2cm9kN011SitzWDdUZytKT1QxN1k2?=
 =?utf-8?B?bHZyZHRqUnd3YUtqUVN6aTdxY1ZNTEpQblZDY29qTnNjdjBVK0VBMlVobE5J?=
 =?utf-8?B?ZGZOVWtKSDhWWmszZVFOT2o2eTJiUUZMQ2taWkVHN1NNZHo5Tm5MZ2pQUTBQ?=
 =?utf-8?B?RGZuaCtubWdYcVNxMERJZnlUVWZ1UzV1ZG9CYWM1S2NYOTFKcG1QejcwbDBI?=
 =?utf-8?B?VVlsaXNuTTBXUGpEOUhKbU94S2NhbHZXRnFCVDVVZEc2a3lZMWcxUkVuQkJ6?=
 =?utf-8?B?NG05RU5Wd25vSlc4WGRUVmwwVkJLSG11TkplaXBMcklMdHA5OWdETjh4VExn?=
 =?utf-8?B?NnhpNG9vTTRUd09kRU55dFFjN0phU1NhQ2dUVnVONXg0bi8zTFNiS1RCQSth?=
 =?utf-8?B?bFZpZGtPWWlmWU5PZXVZTDJRekJmTmQ1RUlpKzhaWEEweWZuVThsejZVaE9r?=
 =?utf-8?B?YTg0TmlzRG9NV3N6T1FSMmEyWHltWnJJWllwOXRjd05BMDBxeTdnR3FoMFpp?=
 =?utf-8?B?RmdCb2JaL1RhaERFWXdpUHE3djkwdGVrS0huRmVYMXBCK214SHNnRmp5ZzJs?=
 =?utf-8?B?SHc2cHhTMEprblVJVDAyblFJNGh4aWFOaXdMelByY29lc3Rua1FoejFQL2NO?=
 =?utf-8?B?TWNzV3JoVmd2S2t6T2N1WVhUMlAwemdoeWJQRk51dzlKWE1hMUtzaTJHV0pV?=
 =?utf-8?B?S2N2TnZGZk5CV2JZNXJGMlF1WktlTUIwYXkyZ0YydmlzWm1lTVdlaytxSTlB?=
 =?utf-8?B?YUdOV2JVckNZZWRTMmpSMEtzbWlwbzQ1ZXJQKzdKRVZoV0MzRjE3amthR2l5?=
 =?utf-8?B?MXd5RVEra0o1clZXY3JaWmxjM2QvekovN3VKMmpiR1MwZVVwQ3JXNnY2SFpX?=
 =?utf-8?B?QWV5THdjdnhRSGRNZUs3KzMybnpIMEdkR2J3TUp0VE14L2h4R205SUw1OW1v?=
 =?utf-8?B?UGc5RENjSXc5dktDMGtBRzBpSVl2YVNzSzZ0REd5QkY3RCtqc1YySzBPTThN?=
 =?utf-8?B?bHVuMm5yKys0REVlcG5DbFBPMGpSbVpXNHBKREZKb1R5WFhORmtBcnRCMjRj?=
 =?utf-8?B?VlIvbnhlN2piQnZRMERMR1JrVVR4a05BRmIyK0RHb2pDS2ZkLy9vUFhoYXE4?=
 =?utf-8?B?dm9SR3BWbGQrRDJ5R1RoM1d4U3FPMFgzOHJmVTdSQkl0Q0tPdFBuMEMvQnBG?=
 =?utf-8?B?Y0c2a1NJd1QwSnAzajIzY0NhRDFaVERpMzJtcFdzOTlBV2NpZ082T2FYMFVx?=
 =?utf-8?Q?r9xQlItjIzG5KtAIEhHeYA3VL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca329189-133a-4f38-0007-08db76c0330c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 03:40:06.4710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPblc2inB46liaRU+NDrTDSWHO6h0BnoJ1u/5b8d5Ahc2MX8DMsQKDYcCOIohfJVbtPrNDL5Tr6YNEk6jMfqGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgMjYgSnVu
ZSwgMjAyMyA0OjM5IFBNDQo+IFRvOiBMZWUsIEthaCBKaW5nIDxrYWguamluZy5sZWVAaW50ZWwu
Y29tPjsgRGluaCBOZ3V5ZW4NCj4gPGRpbmd1eWVuQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8
cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwu
b3JnPjsgQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT47IFdpbGwNCj4g
RGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBhcmNoOiBhcm02NDogY29uZmlnczogRW5h
YmxlIFVCSSBhbmQgVUJJRlMNCj4gDQo+IE9uIDI2LzA2LzIwMjMgMDY6MTYsIExlZSwgS2FoIEpp
bmcgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4g
U2VudDogU2F0dXJkYXksIDI0IEp1bmUsIDIwMjMgMzozMCBQTQ0KPiA+PiBUbzogTGVlLCBLYWgg
SmluZyA8a2FoLmppbmcubGVlQGludGVsLmNvbT47IERpbmggTmd1eWVuDQo+ID4+IDxkaW5ndXll
bkBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRv
Zg0KPiA+PiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENv
bm9yIERvb2xleQ0KPiA+PiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IENhdGFsaW4gTWFyaW5hcyA8
Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+Ow0KPiA+PiBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwu
b3JnPg0KPiA+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIIDIvMl0gYXJjaDogYXJtNjQ6IGNvbmZpZ3M6IEVuYWJsZSBVQkkgYW5kIFVC
SUZTDQo+ID4+DQo+ID4+IE9uIDI0LzA2LzIwMjMgMDU6NDIsIExlZSwgS2FoIEppbmcgd3JvdGU6
DQo+ID4+Pj4+PiBTbyB5b3UgbWlzcyBpbml0IHJhbWRpc2suDQo+ID4+Pj4+IEN1cnJlbnRseSB3
ZSBhcmUgdXNpbmcgdGhlIGJvb3RhcmdzIHRvIG1vdW50IHRoZSByb290ZnMgZnJvbSBRU1BJDQo+
ID4+Pj4+IE5PUg0KPiA+Pj4+IGZsYXNoOg0KPiA+Pj4+PiBbICAgIDAuMDAwMDAwXSBLZXJuZWwg
Y29tbWFuZCBsaW5lOiBlYXJseWNvbiBwYW5pYz0tMSB1YmkubXRkPTENCj4gPj4+PiByb290PXVi
aTA6cm9vdGZzIHJvb3Rmc3R5cGU9dWJpZnMgcncgcm9vdHdhaXQNCj4gPj4+Pj4gSXMgaXQgcG9z
c2libGUgdG8gbW91bnQgdGhlIHViaWZzIHJvb3RmcyB3aXRoIHRoZSB1Ymlmcz1tIGNvbmZpZw0K
PiA+Pj4+PiBkdXJpbmcNCj4gPj4gYm9vdD8NCj4gPj4+Pg0KPiA+Pj4+IEkgdGhpbmsgeWVzLiBy
b290ZnMgZGV2aWNlcyBhcmUgZm9yIGV4YW1wbGUgbW9kdWxlcywgc28gZmlsZXN5c3RlbQ0KPiA+
Pj4+IGNhbiBiZSBhcyB3ZWxsLg0KPiA+Pj4gV2FzIGdvaW5nIHRocm91Z2ggbXRkIHViaWZzIHBh
Z2UgLQ0KPiA+Pj4gaHR0cDovL3d3dy5saW51eC1tdGQuaW5mcmFkZWFkLm9yZy9mYXEvdWJpZnMu
aHRtbA0KPiA+Pj4gUXVvdGVkOiAnSW4gb3JkZXIgdG8gbW91bnQgVUJJRlMgYXMgdGhlIHJvb3Qg
ZmlsZSBzeXN0ZW0sIHlvdSBoYXZlDQo+ID4+PiB0byBjb21waWxlIFVCSUZTIGludG8gdGhlIGtl
cm5lbCAoaW5zdGVhZCBvZiBjb21waWxpbmcgaXQgYXMgYQ0KPiA+Pj4ga2VybmVsDQo+ID4+PiBt
b2R1bGUpIGFuZCBzcGVjaWZ5IHByb3BlciBrZXJuZWwgYm9vdCBhcmd1bWVudHMgYW5kIG1ha2Ug
dGhlIGtlcm5lbA0KPiA+PiBtb3VudCBVQklGUyBvbiBib290LicNCj4gPj4NCj4gPj4gV2h5PyBN
b2R1bGUgbG9hZGVkIGJ5IGluaXRyYW1mcyB3b3VsZCBhbHNvIHVuZGVyc3RhbmQgY21kbGluZQ0K
PiA+PiBhcmd1bWVudHMsIHJpZ2h0Pw0KPiA+IFRoZSBzdWdnZXN0aW9uIGlzIHRvIHVzZSBpbml0
cmFtZnMgZm9yIHJvb3RmcyAtPiByZW1vdW50IFVCSUZTIGFzIGNocm9vdD8NCj4gPiBUaGUgY29u
Y2VybiBpcyBhZGRpdGlvbmFsIGluaXRyZCBpbWFnZSBhbmQgc3RlcHMgdG8gc3RvcmUgaW4gdGhl
DQo+ID4gbGltaXRlZCBOT1IgZmxhc2ggKDI1Nk1CLCBCb290IGRhdGEgKyBVYm9vdCAtIH42Nk1C
LCBVQklGUyBpbWFnZSAtDQo+ID4gfjg4TUIsIGtlcm5lbC5pdGIgLSB+MTBNQiA9IDE2NE1CKS4N
Cj4gPiBXaXRoIHRoZSBtb3VudGluZyBSb290ZnMgZnJvbSBVQklGUyB2b2x1bWUsIHdlIGNhbiBz
a2lwIHRoZSBpbml0cmQNCj4gPiBzdGVwLCBhbmQgc2F2ZSBzb21lIHNwYWNlIGZvciB0aGUgdXNl
ciBvcGVyYXRpb25zLg0KPiA+IExldCBtZSBrbm93IGlmIEkgdW5kZXJzdGFuZHMgdGhhdCBjb3Jy
ZWN0bHkuDQo+IA0KPiBhcm02NCBkZWZjb25maWcgY3JlYXRlcyBodWdlIGRldmVsb3BtZW50IGNv
bmZpZyBmb3IgYWxsIHBsYXRmb3Jtcywgc28gd2h5DQo+IHdvdWxkIHlvdSBldmVyIHVzZSBpdCBp
biByZXNvdXJjZS1jb25zdHJhaW5lZCBzeXN0ZW0/IEl0IHdvdWxkIGJhcmVseSBmaXQuDQo+IGRl
ZmNvbmZpZyBtb2R1bGVzIHRha2UgNTAgTUIgYWxvbmUgYW5kIHlvdSBkb24ndCBuZWVkIG1vc3Qg
b2YgdGhlbS4NCj4gDQo+IEkgdGhpbmsgeW91IG1pc3VuZGVyc3Rvb2QgdGhlIHB1cnBvc2Ugb2Yg
dGhpcyBkZWZjb25maWcgYW5kIG5vdyB0cnkgdG8gYXBwbHkNCj4gc29tZSBhcmd1bWVudHMgZm9y
IGRpZmZlcmVudCB1c2UgY2FzZXMuDQpVbmRlcnN0b29kIHRoZSBwb2ludC4gSW4gdGhpcyBjYXNl
LCBJIHdvdWxkIGRyb3AgdGhpcyBkZWZjb25maWcgcGF0Y2gsIGFuZA0KZG9jdW1lbnQgaXQgZm9y
IGN1c3RvbWVycyB0byBlbmFibGUgdGhyb3VnaCBtZW51Y29uZmlnLiANCg0KV2lsbCBwcm9jZWVk
IHRvIHNlbmQgdGhlIHYzIGZvciBvbmx5IGR0cyBjaGFuZ2VzLiANClRoYW5rcyBmb3IgdGhlIHRp
bWUuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpSZWdhcmRzLCANCkxlZSwg
S2FoIEppbmcNCg0K
