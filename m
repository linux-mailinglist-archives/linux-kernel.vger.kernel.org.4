Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AF4626CA6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 00:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiKLXdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 18:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKLXd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 18:33:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B0D27F;
        Sat, 12 Nov 2022 15:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668296004; x=1699832004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jk4roxrKxad3b5KjFcSEKqeVaPz6fHgQ3SvpfoBIzZ8=;
  b=RBN3J+V64H5rGsT5ErZxBSSKmdJanLbeyCWvJ0zt2UMRafnSVAHRZf1a
   9uAHWJ0aGmxch93cenr3fS14qFyw6c7B5NNFXdXdG4FBE8rjlR5ceJmIP
   AOVrFkXVzj46ABTxJ1ZTTIKO62Tc445Wih2ZD9Y7c23BsNdrF5YlBIv2A
   iUeJrgH3jlspGOvA9gwr35ROiqf+ENGFzC6Zt6wmWIyVJQA624y8ugWH+
   JogOnT2Xyw4ue4dKIU/yIMwmgPeWgnLi+7wE9f3KQV5yIUKH4p0RdHhj4
   pqCCd+OiwgHfqFkXNxq0l8sO1oCQ4lM9AtfqHJ5eJJm2tg9Ooh8ixvAOs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="376028064"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="376028064"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 15:33:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="727118319"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="727118319"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Nov 2022 15:32:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 15:32:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 12 Nov 2022 15:32:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 12 Nov 2022 15:32:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzYUhsroB92Jl5Aouf0grAWhkbpWU4+CLB9N30K0HqX4V+vsV9hMIuOxwxp/odZ89flhs4lYm4POyTN31hnIU9Ak8+U/aUaTzhdqmPZHspmdY9y4YJPE4CQO+KK86+5ClbCX5gn93b64kD83qrItzvVfM+SZ0TQ9jjRscz1RhLKhpN2pfnemhr9mXXv2cAZd6Qi/pO+8LqMeSMtFT5SH6ccVgBwKiTKQ9whPkqlEq8l8W0eGsRzw/1P0PyrQ87RFIf4kw9IdXsSmkYW1ovC1uNbu9PCnv/VZ96qGNTPPDb3rfEVJACVV3wdKTb4hYvwaJUGuxVJ+9TvWSrEXkjxUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk4roxrKxad3b5KjFcSEKqeVaPz6fHgQ3SvpfoBIzZ8=;
 b=Z+laGzpmD09wrlpc2jHEvWFXhjVB5zLrIlB7BEgz3hP+TDOqRSvmqYF5lOdv9Pj4vUoBf2YYdIIYGi3sR6m8dLYnSJ6BL2E2CI3NMW/BmVxyvgwtMk9opIzk+sQ2ipcmWLl+thi702/+raLMcEsfWUOWFftuvim53uuOoZlgNWghRzbLl1FSY97vDaXQTBalhxF2IGuySD1Cp5WMzCVfUyAd1S41qXniNSEpj6iITjhnnAZixDLbZy/m11B2xRfMJPS2qKeRXY48aMrPfBqQ4n5S+YNcAAznKsU8DgTEMtYQaaE420NiRjAChRtM6nxYmE5+tzF/wR/xEOteUNs6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sat, 12 Nov
 2022 23:32:47 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014%4]) with mapi id 15.20.5813.012; Sat, 12 Nov 2022
 23:32:47 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Thread-Topic: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Thread-Index: AQHY8vv3UouK3GalXk6mzwRA6fUNf647gQ8AgAAjoWeAAA8ugIAARE5l
Date:   Sat, 12 Nov 2022 23:32:47 +0000
Message-ID: <B12A4934-AD7A-4F8E-A2FB-229542C1A098@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com> <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com> <Y2/z0yY3zcKmR5BN@zn.tnic>
In-Reply-To: <Y2/z0yY3zcKmR5BN@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB7510:EE_
x-ms-office365-filtering-correlation-id: 2d5337ee-ff02-4401-fc75-08dac50634fe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwoh7NX4Grfoji8mIiRMjtuqAyDu4WoImKTmvyb9tPPqXAUrJhYBNOh76C9BfoZDGenPjtD8B5xV6OSLp+V5BHMt5u3VPita/s5ogzl/Z2YH2rgZUq2nA4sc+0l3ZuoG3jBAeq2DL436GLQIEdZkcQr0/gvL1p2a6DUU8/aUh0TR7wU1XBOF8s0zCRe3SQu4tl+ztrPneXPMlZfywixXeXS3qha98aWR4Ds9kymplDn3JA4+F8fVurYCbLsYvivGcU4CeMGUWrZD/zs3unu1noOdTnDQUYppKt6bmG97gKCnOr6N3SoFD4DyEt0tnXmvIoE4diWdMQo9OyCJPj9Xl9lQ7AWjU47lZvDDSfSxqXVLE1bcEcsIUGGYMu2M3iDUONQiIaSbLK1dOOQAHW2iTUCSxD5rAJPo+Mhe/8TAopCyN6vxtKHdkEjW6LL9EamI7bLdhXmGmDJMus8Vk+J7y025T+i8WZDC/FRKwPTCGIob/CDOu4L1isaPflf9b0ylQx2D8xA/g0JAy/iKqsjUsPq6xwuT+Kn3d/YkbnuVAfXjhlPppQmuhuZbjscSDam8GM1z9r0TZEAzoAtGjVJyaz7YiBg4eEAq126nU3OwNJnJGMIGlw0ePf7lmK6tcUumlgeG76Hpw9T7V44+AAh5RqSbhFVCznLBFEEGFJgdSdAtKJWjYXOw09moaThzBlcqsBNFmd0NNk0nzp1HIwx5XMk6GuWN4InsCy/S+qLDLdd0XqqeEIwyHDdtzR2FwKcV4krq5HRQW4lVnoz54g1E4Imq0p/PyRc0ai87HHXOjmA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(41300700001)(5660300002)(4326008)(8676002)(66946007)(66476007)(66556008)(38070700005)(86362001)(82960400001)(54906003)(478600001)(6486002)(316002)(2906002)(6506007)(6916009)(6512007)(7416002)(64756008)(76116006)(66446008)(26005)(8936002)(4744005)(186003)(2616005)(33656002)(71200400001)(38100700002)(122000001)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2dtZHNmbkF0bEVSM3dGZ1JQSmZ1ZU5qdUtYTUx6YVN3dk5Xc1V4NHpqVEZD?=
 =?utf-8?B?UnhsUjE3ejZLREpwS0pFY05aZ0hGdVAvUHE0TGd5SVV6UkI2ZkVwTFRIYU1M?=
 =?utf-8?B?YVlPbW5mMVFlbFRkUHR5bUJvVmJOa1lVR01pcmxSeG9ueHYrWFhUZFhsYjBN?=
 =?utf-8?B?SXVWOWlndkh1c0NQVVBrYkhNaVpNcnRrTmhvdlp2emRXZ1czU1NoT01aTjJH?=
 =?utf-8?B?bVZpMDRUMlhyZkZ6VkM4NUZlZURsQllxSW1rbXFka0s1STVlU2cxanFYMWhl?=
 =?utf-8?B?Szc4NzFiNDlKVXVUOUhFTnNpWUNIcXY5VzlVUFo3aGxmM3daTTFmR0xtRXgw?=
 =?utf-8?B?WmtCMndPUjkxM1QrOHJxMUkxbmh5RFliSk9FVEZZc2pBVFZ2dkdhbUJVYWxU?=
 =?utf-8?B?eUtjZFFUZFZnbStPSmtWZVViZ3VBMDBDQ1B0S2Zlb29oUkJJMVFqeVBhT1VZ?=
 =?utf-8?B?d0daNFlNK3BZeU9vaUdqVHhDd1VBSmVTaHZSRmhNYkNLNGR3SkN2VXI4Qy84?=
 =?utf-8?B?V29uWmxkU09Mdyt2b04zclRjc3BPcFhmSndjRkc4OG4vb3RMbGNaOUxmaVJK?=
 =?utf-8?B?cUovc1RoQk53Wlp1cE1lYXZjbDRSQXFEMGNsOHJuVS94ajFFTkVjL2Nwa0Yx?=
 =?utf-8?B?ZER1Mkc3ODNZV0NtT1lxemxoOGxEeHFVUUVMbjJrdU84Rmo5blUrRmZjdTVM?=
 =?utf-8?B?K3RkSGJSSkE4SVlaT1IxWnFYUFFIaS9EYTVxMVVuTDRIV1FMQURET2NBTTFV?=
 =?utf-8?B?WGZxWll2SmRlRG5JZXU1WGx2YVNZVUltaHJ5WXNJb056OEZDd0dRVUIyc1px?=
 =?utf-8?B?US9vcWFSd01zZFVmeTFlbkcybDZtcFlndWxobHNLLzVXeEM4QmRJT05zMjJI?=
 =?utf-8?B?TjNqUXhvaDRSSnhLL2xvNmFjUWR5ZFBJNDB6ck96MDZtd3FxMG5QNFFYbEJS?=
 =?utf-8?B?amluQjBIYzdMMjc3OE5uL2ZYQzZLRDhPcytxQlp3enZCVkd5aTVUMWpYVHFF?=
 =?utf-8?B?NXhhS0Q1c0FkNGU5Y0UvTy9vanFkeXExQXY5NnVvd0EyRzIydUQyRkZkZnF6?=
 =?utf-8?B?b0VmTG1OOWo2VnNtbkZOSHQ2NWJlQXE4ckRFeFRxVkZmNTIycUZMQzRoZjdw?=
 =?utf-8?B?QnhYV3RBTEUwMVpmRzJnbEZDVFRXc0l5S3FKeUxIVkV4eFdBc3JFMSswN0s2?=
 =?utf-8?B?b2xCK21xSVg0WFZBZHRNUDlIUmhUazg3dHdHTHhpVHNVbDlYdjFCYzM2azFN?=
 =?utf-8?B?UU5ZN2xXMUk2anMvcjJ0TTIzb1NrUG1oZzJDZjRBb3hkd1kvWHRhSDVJbFYz?=
 =?utf-8?B?Um9wKzBrU3hEZDlxUlBPaVhtOHQ5Zi9wbDBhcmxZYzczM2VhenMxWGpaTE5y?=
 =?utf-8?B?WUpiakVVSGZwRnZUUFpSS2JoejkzVEg1OXV6Z3JrVEdUUUZzaFF6ZG94L1NG?=
 =?utf-8?B?ekxDamdQY2k2OVA4ZHhhdlI0S3k5a1laTXYvUERZV2o5SmJkMVRqMGM5RjlO?=
 =?utf-8?B?ekk3ekVsejJzMUw5Z0Y4WCtjUk9nRVhPU0tWL0pUVG4yYW01NEtkSENWUXEr?=
 =?utf-8?B?MDlPaU1LN0VYd0ZiNnVlRGpWWkppM29QdFg4a3dQYmdVTU5HaWNSd3RLOEli?=
 =?utf-8?B?V0Urc3JTNmkwNTZoMVhrR2hiTTRMRit6OUZ3ODRsdlhDekVWcXJSN28xOGZk?=
 =?utf-8?B?Z1Z2QVZDSkMrR0VOU2ZRcXRkSk5RYmRLY05ycnY3ejUrOWduNWVzNW5XN1hs?=
 =?utf-8?B?ellQYlBxdll4OWo4YUJKUUVVRFF5K0o0RU5UTE5LY2NOeFMzd3ZHdGUwSFlZ?=
 =?utf-8?B?TG1MM1NNcTJOeDE0MDgxRzhxWW55RFhzRU9YSHBCS2Z2S3J3K1o0aEdGa0N6?=
 =?utf-8?B?dDEyR01zRXV2a0hIOFUvSjV3cDNiRXZxTXczbDlHWGJpRWtPRnFYQnJudk1G?=
 =?utf-8?B?RW1qejdxRm9zTU5VMjRGSWZUUjlYMTlKUC9kUU9INkcyYmExQ2RNUmlCNEd5?=
 =?utf-8?B?WVhVSGZMNGwzbkMxTC9xNjlhZ3FQamdSUUNheXQ2MUZsUlI3ZDgxZkdteVpm?=
 =?utf-8?B?OHhOblltVGpWdFM3V1BEeVEvQklrZnAxUUluNjBubC9DZjFYZUtaakVGMi9n?=
 =?utf-8?Q?obs/FGp/QK6mcN8XB2MbixDDt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5337ee-ff02-4401-fc75-08dac50634fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 23:32:47.5779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWWn9f6gZKrju1JFXzEMV74qbis9i8pib4VLJOpB8zq51ZwZbQgNpf3xn0h1K3UutdTdFx5JJS/I6nAUqSWrZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEJ0dywgZG8geW91IGd1eXMgcmVhbGx5IHdhbnQgdG8gcnVuIHRoaXMgaW4gcHJvZHVjdGlv
bj8NCg0KQWJzb2x1dGVseSB5ZXMuDQoNCj4gQXMgaW4sIGFyZSB5b3UgcmVhbGx5IHRoYXQgY29u
ZmlkZW50IHRoYXQgYWxsIHRob3NlIHRlc3Qgc2VxdWVuY2UNCj4gZXhlY3V0aW9ucyByZWFsbHkg
ZG8gbm90IGFmZmVjdCBvdGhlciBDUFUgZXhlY3V0aW9uIGF0IGFsbD8NCg0KVGVzdHMgbWF5IGRy
YXcgYSBsb3Qgb2YgcG93ZXIsIHNvIHByZXZlbnQNCm90aGVyIGNvcmVzIGdvaW5nIGludG8gdHVy
Ym8gZnJlcXVlbmN5IHN0YXRlcy4gDQpCdXQgb3RoZXJ3aXNlIG5vIGVmZmVjdC4NCg0KPiBCZWNh
dXNlIGlmIHRoaXMgaXMgZ29pbmcgdG8gYmUgcnVuIGR1cmluZyBkb3dudGltZSwgYXMgVGhpYWdv
IHNheXMsIHRoZW4NCj4geW91IGNhbiBqdXN0IGFzIHdlbGwgdXNlIGRlYnVnZnMgZm9yIHRoaXMu
IEFuZCB0aGVuIHRoZXJlJ3Mgbm8gbmVlZCB0bw0KPiBjYXN0IGFueSBBUEkgaW4gc3RvbmUgYW5k
IHNvIG9uLg0KDQpEaWQgVGhpYWdvIHNheSDigJxkdXJpbmcgZG93bnRpbWXigJ0/IEkgdGhpbmsN
CmhlIHRhbGtlZCBhYm91dCBzb21lIHVzZXJzIG9wcG9ydHVuaXN0aWMgDQp1c2Ugb2Ygc2NhbiB0
ZXN0cy4gQnV0IHRoYXTigJlzIGZhciBmcm9tIG9ubHkNCmR1cmluZyBkb3dudGltZS4gV2UgZnVs
bHkgZXhwZWN0IENTUHMgdG8NCnJ1biB0aGVzZSBzY2FucyBwZXJpb2RpY2FsbHkgb24gcHJvZHVj
dGlvbiANCm1hY2hpbmVzLg0KDQotVG9ueQ==
