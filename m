Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55034718BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjEaVU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEaVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:20:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9ACB3;
        Wed, 31 May 2023 14:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685568056; x=1717104056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nkYan+jCed+BH1BRz71XNvY+D/czwBBfPMMmZ7ruag8=;
  b=f6MNCpsLf64upd5OOavbp+ogp3znstPrMO5UdSlKkJ3JXuvatJ0wc15p
   ZvqXDFIy+rwyfyOB2SuGKx7tM7LG9c+Vxd/Czcom9ETt/GGVu6HrxO/6w
   0oOJQX9dheR+dKGD5pe9XX2+Rghfu+15tUfrud+aPc2s/grLbzqk0TcuO
   s1PwAxpfGhjncNTpSTA6bBLr9coaH2Mmvt9NMWZlBP8bdSVbu86TIRljN
   WMtQO5VMuNU/3/5SHAkHdTZmudu+K1ukiDHVVP1Cp4gG/RipNsYbptFZ8
   j2h6hsJ5wJT9E+OlsNaOKpwdSqztWkqaaKevR19SHCBGHX8tyWT93qXLF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="441729749"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="441729749"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 14:20:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="796875055"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="796875055"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2023 14:20:51 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 14:20:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 14:20:51 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 14:20:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E10kByabOsSE2pzCgU4ynMcDsn9wowiu0qrd45ZeASFrOEEilVAHQXnpUnixvcKfqbn67WCBDr0FqsoJUL7oVzNBXA6Kbx+3WjIpTIVNmWdeSNGl+zO8EivMf2T40+F/pxs3+YAkXQujIVYlOjxkATz+CN+oKXSayMhhEI1Ilsl981mN910DafpfsFix6QW/mLd15rs/fvPnkXT09Lc6unLS6xOEf/0ki5DvUbWi12mtz6JWp0fFwMS68jXiKZzz1SwPifEBOXmv1KRCy4oYl98rIbX4P0UIA5auFksHloq0LHXkaL9H5qx9+cD+X1RdscTkrXxbLveiwqb8moIjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkYan+jCed+BH1BRz71XNvY+D/czwBBfPMMmZ7ruag8=;
 b=MgJei1WsjqkhUFtSFk9/0K8xNA8HdiK/8Ovi3JvJv6JN+qHjKFkdCTBeLGYOa2ul9bgOrLvRjOAoaUyQlJz6iDEkCbQdwGd0oHKrr+3HQg17dqxoF59H/JlT4e80sekWPBH5vDXsYX+kN8q2wTqUuvrw+biU18S4oYSD/HdxmbRymw30XNCfDqBH7hUMv1LSItRc6T8kvgGUc22pghJ9ocC8nlXe/38UFbbpRRTORWgA/nVue5QgW+568Eodxt4fFIMh8UKZU5SIpbpgAXPaXRQHlk3aVs4I+/F44lVGva7o1dsPSs0CYy0dHQsCh8vx529WHrAb24abTiPpj0ggcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17)
 by CO1PR11MB4817.namprd11.prod.outlook.com (2603:10b6:303:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 21:20:48 +0000
Received: from SA1PR11MB7109.namprd11.prod.outlook.com
 ([fe80::9787:88d6:b7e9:50cb]) by SA1PR11MB7109.namprd11.prod.outlook.com
 ([fe80::9787:88d6:b7e9:50cb%7]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 21:20:48 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH 3/4] cxl: add a firmware update mechanism using the sysfs
 firmware loader
Thread-Topic: [PATCH 3/4] cxl: add a firmware update mechanism using the sysfs
 firmware loader
Thread-Index: AQHZdMfj1+vIA1W97kmyE2uj67BBM69nYcuAgA3ALYA=
Date:   Wed, 31 May 2023 21:20:48 +0000
Message-ID: <a7443a348b9c2b51cf141ad1131c9befbb09724e.camel@intel.com>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
         <20230421-vv-fw_update-v1-3-22468747d72f@intel.com>
         <646c313f20907_33fb329412@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <646c313f20907_33fb329412@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7109:EE_|CO1PR11MB4817:EE_
x-ms-office365-filtering-correlation-id: b44231e2-9f61-46ce-e157-08db621ce766
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sbfQTFrONtsDoiLTs9SIm1rAa9+DLxgSASdtPP8XcB+6DIGLxX/3BOnDcAm3R2tV5fXkvA82awgHXiEdjDqrN+m/rVib+R/+3TsjhODntIa+7cB4e17L7TOES7J7UArVk5/feUpZMXIJctozjmo6n5ImiYpGADNCyFL8EKb+4MscrmhZamrBPsfSHhK+/57pgds8FC6WKNuGT/8/Nh497d7Tfdy+JAAVoOd6RC22lZ4DFu6eCCR6du+7wI8pMtdYxmcZhZbB7dFFTc9NyCBTcHl4DX+ju/DBlro90sjxvuaD7KKuXez3r2Erxvp0tq0XsxPj4Pbh/giGbKjFbQfp7IQIbgEdVTOes6VD3t2bB9GoV7b7mJ2QXfE39M+bJdUgR74c40M9F+LYzLwktbVjDoNMMWOJkot4Hh+JUN07PVGJSltQ+Ko992qpSSQIuBom2hlnebKNU5hnnvH6ZYDXVIfmNIQUpIDYIfM94SHpo6jPXn5xljgfiKkn+6xfzEZfHEjwtUTIYe0liC29D695eRUv36JcTqGZfGtVuBMr1QubioXXmuN17NVEn6UqRV7x7WDPU3g/WJsLutFER7bUltS8EDt9nB5wpXK868wZd0O+lfmBMLteE4ruDUEohttL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199021)(110136005)(54906003)(8676002)(8936002)(2906002)(4326008)(76116006)(64756008)(66556008)(15650500001)(91956017)(66946007)(66476007)(66446008)(6636002)(41300700001)(5660300002)(316002)(478600001)(71200400001)(107886003)(6486002)(122000001)(6512007)(6506007)(186003)(26005)(36756003)(83380400001)(86362001)(82960400001)(38070700005)(2616005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzVnQjBuTXNMRTZFZVFjV2dVRHlPMjhUQXlsbkhvNVBKTmxvZjJQTm9XMnV4?=
 =?utf-8?B?aVlleDl2bU1RWXNvNDlhV2tsbjFFcGllZEdQN004UVpLNU1EM3pQeWFVNzFH?=
 =?utf-8?B?NlE0RzJna0t0QmNMNVFockVSVXo3VlVydEtLL0wrclpucHdmdXNUbXlDelY5?=
 =?utf-8?B?Z0oycGZQRnFIbXIxUDdBWDdUS3BvazVIcE1McnFLRnR1K2cyMnFZMVNOR3M3?=
 =?utf-8?B?RUc3Yk9CK3RmNnBFaWo2VFBzSFJTVm1UQ01yYWZrRzZsd2tWQ3VuSEduYWE0?=
 =?utf-8?B?UnllaHR2Y3NJTVhmQlFqNjZTb0h4MW9GWi95bDJXM2VuS296WTZ0Z29GY0F0?=
 =?utf-8?B?amRzUDZKR1JxT0JJRC9RcCtTTVhuVU5Qakp5dkVybEtEME1UTmhER2l4bVhw?=
 =?utf-8?B?OVliU3d0VG9xbU1PaUcrZGpqVE1jOXpBRHFMaVFHQ3Z2bEJyZmlDdGxHRWw2?=
 =?utf-8?B?MXlJY0ZTdWEwU0c2OHVYbE9YdFU2amsyY1JzZlVRZTRYRmUyU2tZWGFUVnB6?=
 =?utf-8?B?SitSRnBGWnFncHR1STY3YWJ0a1d6QUlMVFZTNVpWd25qeDRMT0oxdmNEalhK?=
 =?utf-8?B?YmlzUmxGSmtIRmVWSjY5ME1Hb1NwSHVLVFFNOCtzT000b3NSZGhlLzIxcm14?=
 =?utf-8?B?N01KRE51bVkwVUNYTzh1YXNwNzVWQTBKMlBLYzdXR1NiVE1jMEEyeXo3azBY?=
 =?utf-8?B?NzBwNUczV2hyVnprTG5jQ29rZTJLREp3YWVGSkVBL05lYmpsUXpPa2I0anpo?=
 =?utf-8?B?enhNRUNRclpxOVpBRjhzeGlkKzJUOHJZcGhDdE5wcW1FT3NNK0ZMTm9KWTBF?=
 =?utf-8?B?WStWTDZDZTAvZjNjY1RHc3N5VytDNlNQTWx1aVU1WlZpazNZQmdYczc0V1c3?=
 =?utf-8?B?YVBIa2RMdHdLTUJPM1M4NDFlTDVVbjJIUUhQUThiM05jM3pJU09yYmJtdEF2?=
 =?utf-8?B?Mm5vcmlmcytQSFMzVHZiWXZWQUlxV0VBUU12c1ZHN0hjTUo4SXZHbUp0cm14?=
 =?utf-8?B?eGZxckNNNVhOUVlDZ2JPT0p2Q0tCSGdYTUZWanhKcld4aGorN1JwZWo2cmtF?=
 =?utf-8?B?d1lGcGh0RGlOZWVSdFJucjl6NHZ6ZVcvSUtsWmNDWnE3anlFYitMWnE0cVdo?=
 =?utf-8?B?NGtrVjlUZll2U21FQmFtR1FvaG1MUjVPV3ljZEVqUkNPMTRRM1hvV25YeGhm?=
 =?utf-8?B?VkY1MG1RaW12dmtLSUY5eDlrL1BCK3AzMGdQc24rL3ozMHhIcGVHMWpyZ0l2?=
 =?utf-8?B?M1lmbFJHdGZRbTliRzQ2dWZ0ckQxMU1SVGRoV2ZZZFkzdWY2dEdoUWZNV2dM?=
 =?utf-8?B?bWZaVk1OUjR4dDEzT0tObnFSSVFqTlFBclVoOUpnTkRtUENiWTJ2WVp5K2FD?=
 =?utf-8?B?R1BVRHZNUmEvbkcvOTVLMmJPY0w2U0l6VUUxWVNlNzI0ZG1EZ3JQU1QyWXVq?=
 =?utf-8?B?MjQ2ZjF3Wmx1Tnl3cjlGZ3pBSkNYWXNlVjJkSExsVlVhY0FQd0pSdERWS0dH?=
 =?utf-8?B?VXRscVdaUStPN1A1U0VJbWlXZ2I2UnJCM2ROU0V1bCtWaitrMDh6bCtGMDVu?=
 =?utf-8?B?MGZEVnUwUWlVY0g2cERKVkdSeVdsQWFxU0EyZS9NWm11TWkrZWM1YUprdVJw?=
 =?utf-8?B?cFpRdUVpK3diS2VoaGd3ajNhd0VDQlNYdml0OHFuamJ6M2xPTE1yZzhtMXF5?=
 =?utf-8?B?L0RZSFViQzM5cExaeUdPaFBrem9kdVRYakcvL3N6YWxnUHZDUkozTGlwbHgw?=
 =?utf-8?B?NVBlZ2hjeWtMU1djOEljbzhEOUdHd1F4RUZSUkRUenRGUVUwZnU5UWVxeXB5?=
 =?utf-8?B?K2VSMHpoQXZla0swc08yM2VreXNyRWJiNkJ2UzF0eDdwZ1g3aDc4dHVQeFFj?=
 =?utf-8?B?bkQwVlpwYUtsNTlYeXJ5WkpHOHVpcEhyejl6QlNBQWZmbVU5S04wSC91QXdR?=
 =?utf-8?B?Mlg0aVJoZlEyR0JTVlVLS2lYc3RxWXczSHFoQ1BSaFQrRmFNbklaZmNqTGFD?=
 =?utf-8?B?dVpOYjhJd0JiVGVTbU9WRzN5TjFsd0JZTVZFTlBoMFNlRFpOSEQvV1VXVlg0?=
 =?utf-8?B?L2M2MzhYNVBQYjd4ckc4eUVVeUtHaXJqdmRqRER0dkVoS3p4RC84MjRxcWxM?=
 =?utf-8?B?UU41Y245bDJnUG9ERjUzTW9QcFc1aWVsTjBFUGRReS8zcVZ3VlQyZHIvK1pk?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44F9458F889B0649A006479F20B46855@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44231e2-9f61-46ce-e157-08db621ce766
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 21:20:48.3934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPGB+gjZYs6ulPP7+ucg4eTt89MGDEUCUPuq9DA3H/lZOJYXZONAp23lveceSr7K22LpSjCUNvD8pumzB+BxyofhRLpbwFR/7cNJZMJXVdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4817
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTIyIGF0IDIwOjIxIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFZpc2hhbCBWZXJtYSB3cm90ZToNCg0KPHNuaXA+DQpFdmVyeXRoaW5nIGVsc2Ugbm90IGFkZHJl
c3NlZCBoZXJlIHNvdW5kcyBnb29kIGFuZCBJJ3ZlIG1hZGUgdGhvc2UNCmNoYW5nZXMuDQoNCj4g
PiANCj4gPiArwqDCoMKgwqDCoMKgwqByZW1haW5pbmcgPSBzaXplIC0gY3VyX3NpemU7DQo+ID4g
K8KgwqDCoMKgwqDCoMKgc2l6ZV9pbiA9IGN1cl9zaXplICsgc2l6ZW9mKCp0cmFuc2Zlcik7DQo+
ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJmN4bGRzLT5mdy5md19tdXRleCk7
DQo+IA0KPiBXaGF0IGlzIHRoaXMgbG9jayBwcm90ZWN0aW5nPyBJLmUuIHdpbGwgdGhlIGZ3X2xv
YWRlciByZWFsbHkgdHJ5IHRvIHNlbmQNCj4gbXVsdGlwbGUgb3ZlcmxhcHBpbmcgZmlybXdhcmUg
dXBkYXRlIGF0dGVtcHRzPw0KDQpUaGUgbG9jayBpcyBqdXN0IHRvIHByb3ZpZGUgcHJlZGljdGFi
bGUgcG9pbnRzIGF0IHdoaWNoIGEgY2FuY2VsDQpyZXF1ZXN0IG1heSBiZSBpbnRlcmNlcHRlZC4g
VGhlIGxvYWRlciB3b24ndCB0cnkgb3ZlcmxhcHBpbmcgZmlybXdhcmUNCnRyYW5zZmVyIHJlcXVl
c3RzLCBidXQgdGhlIC0+Y2FuY2VsIHJlcXVlc3QgY29tZXMgZnJvbSB1c2VyIHNwYWNlLCBhbmQN
CmNvdWxkIGhhcHBlbiB3aGlsZSB0aGVyZSBpcyBhIHRyYW5zZmVyIGluIHByb2dyZXNzLiBXaXRo
IHRoZSBsb2NrLCB0aGUNCmNhbmNlbCB3aWxsIG9ubHkgYmUgJ3Byb2Nlc3NlZCcgYWZ0ZXIgdGhl
IGN1cnJlbnQgY2h1bmsncyB0cmFuc2ZlciBpcw0KZG9uZS4gDQoNCj4gDQo+ID4gK8KgwqDCoMKg
wqDCoMKgaWYgKCFjeGxkcy0+ZncuY2xlYXJfdG9fc2VuZCkgew0KPiANCj4gSSB0ZW5kIHRvIHBy
ZWZlciBhdG9taWMgYml0b3BzIGZvciBzdGF0ZSBmbGFncywgZXNwZWNpYWxseSBpZiB0aGF0IGxl
dHMNCj4geW91IGdldCBhd2F5IHdpdGhvdXQgYSBsb2NrLg0KDQpJIGNhbiBsb29rIGludG8gdGhh
dCAtIGFuZCB0aGlzIHdhcyByZWFsbHkganVzdCBhIHNhbml0eSBjaGVjaywgbm90IGZvcg0KYW55
IHR5cGUgb2YgYXRvbWljaXR5IG9yIGxvY2tpbmcsIHJhdGhlciBqdXN0IHRvIGVuc3VyZSB0aGUg
LT5wcmVwYXJlDQpzdGVwIGhhcyBiZWVuIHJ1biBiZWZvcmUgd2UgZ2V0IHRvIHRoZSAtPndyaXRl
IHN0YWdlLg0KDQpJZiBpdCBoYWRuJ3QgYmVlbiBydW4sIGl0IHdvdWxkIGJlIGEgYnVnIGluIHRo
ZSBmaXJtd2FyZSB1cGxvYWRlciBjb3JlLA0Kc28gSSBzdXNwZWN0IHdlIGNhbiBqdXN0IHJlbW92
ZSB0aGlzIGFuZCBhc3N1bWUgdGhhdCB0aGUgZncgdXBsb2FkZXINCndpbGwgYWx3YXlzIGRvIHRo
ZSBkaWZmZXJlbnQgc3RlcHMgaW4gdGhlIHJpZ2h0IG9yZGVyLg0KDQo+IA0KPiA+IA0KDQo8c25p
cD4NCg0KPiANCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgZndfbmFtZSA9IGRldl9uYW1lKCZj
eGxtZC0+ZGV2KTsNCj4gPiArwqDCoMKgwqDCoMKgwqB0cnVuY2F0ZSA9IHN0cnN0cihmd19uYW1l
LCAiLmF1dG8iKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBsZW4gPSAodHJ1bmNhdGUpID8gdHJ1bmNh
dGUgLSBmd19uYW1lIDogc3RybGVuKGZ3X25hbWUpOw0KPiANCj4gV2hhdCBpcyB0aGlzIGRvaW5n
PyBUaGUgZGV2aWNlIG5hbWUgb2YgYSBjeGxfbWVtZGV2IHdpbGwgbmV2ZXIgaGF2ZSB0aGUNCj4g
c3RyaW5nICIuYXV0byIsIGxvb2tzIGxpa2UgdW5uZWNlc3NhcnkgY29weS9wYXN0YS4NCj4gDQo+
ID4gK8KgwqDCoMKgwqDCoMKgY3hsbWQtPmZ3X25hbWUgPSBrbWVtZHVwX251bChmd19uYW1lLCBs
ZW4sIEdGUF9LRVJORUwpOw0KPiANCj4gTm90IHN1cmUgdGhpcyBpcyBuZWVkZWQgZWl0aGVyLiBB
RkFJQ1MganVzdCBwYXNzIGRldl9uYW1lKCZjeGxtZC0+ZGV2KQ0KPiBhbmQgc2tpcCBhIHNlcGFy
YXRlIHN0cmluZy4NCj4gDQo+IA0KWWVwIGl0IHdhcyBjb3B5L3Bhc3RhIEknZCBtZWFudCB0byBj
bGVhbiB1cCBidXQgbWlzc2VkLiBEb25lIG5vdy4NCg==
