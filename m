Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D032B70E897
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbjEWWDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbjEWWDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:03:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D45C1;
        Tue, 23 May 2023 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684879387; x=1716415387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vJ/bTjEbxLtVYl/o3FixfUJ9JmA1zzE2dgJW/2Hjg6Y=;
  b=Sz7vimCnRoRdiI2ouD5RkG5NrV/p3DqPBj1r63uZf43NSS/HZaREWzVJ
   PR/XaRaGG9HUOIf16Ez6MNUcylIjo6V7PxxRReWMvwxiXIEUANPU0TjmJ
   hZ5IDWsSY48B/t6Z/GTCYXVxhbirsjmNT+djn9+Aq2qrmfP+ZYJ0fmend
   eIr3i2vkjLRufmG4GUoqHY32gmPFoqpwGdA847r5nbwVn/3teXtwflKXl
   AEaTaaRBcJJNsGEdzcva0QVnH3htNeDSnSeniCRwz+Y/dEtWlb+Ycy8Wy
   oMojLmnxOFrd+/w225tVsVr3FLn4aE0QsKtKzZ4vT5zP/6JC8OKFHmedk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416834603"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="416834603"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 15:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="1034226331"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="1034226331"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 23 May 2023 15:03:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 15:03:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 15:03:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 15:03:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXlnwwW0FfFYhaKuvzI9L88yHugUWmhq/hxmodRn5IYX5Nk6+81v7NBc4HgtWqCbkLF4qEGHGCg/jPqoKOpK4OOZYUIPEdnApUJKv/JCaRPiYsGyw8DWqaaXVfxsrnPVufGHwGkhDcD1JomYGYABzeu31k16BRLE73YWG9JTa/OtidDo1i5Px+8h/xkAMOjJk1CaD18lMdU7Rvsp3/bhi89QDWGsS4PiVPivz1M9X0M7pXM3kQ/DroQWaDkGzgQYK/wT8wbf4/hd84zaXvrd8ls3vz+PfgG4Ae0LSt998KdyZaNlEerDSyTzoy+zrsA/oUv2T3hnRuzuSS/t5ubaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ/bTjEbxLtVYl/o3FixfUJ9JmA1zzE2dgJW/2Hjg6Y=;
 b=RHxKF9cS5wQ4To6KeuvKDR8jm5MNhmd6hxIkAJri9JpfZojfFqz4TS4tUCBIuVnsIaH3RsaTIUyM8dIAV5El7nLHKruPclrkVHUUHCoSVQiliZvTYUVoavUF0IDKC1hrsJuUQTfxbNYn12MwFHTi6R1iOtA4RPHc4xcm1nyNHVJzfXhbawr2yfWPKL5zb6mcVwo/kRtIsMqjIAjx0eb+qHlTPg2Kl+goO+2vJ59b9Q7vyb2WwFWif4vtdaRc+61iR+1LVgpZ8L/VZ/OPTAyP8qx9IUDogf+9LyJi/f/udTXrznDN10mhBz3rsXqsRcSR8rY7y3eCftqhCUx7pbryyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16)
 by PH0PR11MB5579.namprd11.prod.outlook.com (2603:10b6:510:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 22:03:00 +0000
Received: from SJ0PR11MB5600.namprd11.prod.outlook.com
 ([fe80::fa7f:e19b:bdfc:4af]) by SJ0PR11MB5600.namprd11.prod.outlook.com
 ([fe80::fa7f:e19b:bdfc:4af%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 22:03:00 +0000
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Brandt, Todd E" <todd.e.brandt@intel.com>
Subject: Re: [PATCH 0/2] ACPI PSVT table exported to userspace
Thread-Topic: [PATCH 0/2] ACPI PSVT table exported to userspace
Thread-Index: AQHZjcIf6bo7i5cctkO4of+LtzcgNq9oaSeA
Date:   Tue, 23 May 2023 22:03:00 +0000
Message-ID: <e175d1b19472ecfa3adccea6c3be52aa38d91232.camel@intel.com>
References: <20230523220102.2377173-1-srinivas.pandruvada@linux.intel.com>
         <cover.1432082423.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1432082423.git.todd.e.brandt@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5600:EE_|PH0PR11MB5579:EE_
x-ms-office365-filtering-correlation-id: 9a9d52cb-c9c4-43f9-1b45-08db5bd97932
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U3pow4FxdCRvvAA6EmekHH+1EQSIuSECKezqHY8ZtWzvegPdU/dWdEn9YO98yq9rZfFEDy8f2agKpYomAZjZOM5KOV2T3WWY8daOwTWvxMdWdgbtyv/x+8/qXWC9dw5qlQIzVfB3VoEDEuImLswekHfUUVc+AXuZJU+SbpDMRVODNwyVwB0u3rz/cpkwhbt3nNoGfnRkCMhoG9JDw8oo2pchS12YsO+XuJQsC5OovYO6BAht8/eagjnmMWEOPrBf/h7i4iZVDsf1OLRmUO/uK+StEf8Ws6bcvemCxc16a2tn9qabspwUGthF1kTi9Nw/BZmsr2CDZ+Sky8Bvh/fKp0N5SKHp2QqFJhpXTh2M2tK7u1JDcu2ZQKYc3oVTAIjqdRS+DMFKZLavPSki+fcOOQ8T8D7gpoPUN7S1pikt2HUeDtoc5pJn7LAGfJruWNlxZGFi14j/dUX9LlwuQ3Jt5n8NRmU7caJK2CC1XWd65BrMY1Umrp8nwEH6SxYaPDGEjG4rE2CfZXXGFXqjwrOf4X8AUqPd2Tz0VUxdU1ov/KFDv6uDA8ipJ75WYC4+Km+ekuEMQAp674Ui2agD7h0jKS4znM5fHiN8fRS8pSbG0vY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5600.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(4744005)(2906002)(5660300002)(186003)(122000001)(38070700005)(86362001)(6506007)(82960400001)(6512007)(38100700002)(2616005)(83380400001)(8936002)(36756003)(8676002)(76116006)(478600001)(316002)(71200400001)(6486002)(64756008)(4326008)(66446008)(66556008)(66476007)(66946007)(41300700001)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDd4WkY4eElhSWQwZHdVT08wOHd1elZ3NXBaNE9CQ09rNHBnWWwveUE2ak9n?=
 =?utf-8?B?MktGSWhpZWpDL1hPTzJZV3hSRDE0eFdEZTE3NXYxNzRlZ09iZnh4emUxcXZi?=
 =?utf-8?B?VkVHalA4dk9sT1YrNFRhRUd2UmFGbStFVWJYaW5FL0ZwS3hRaTIwdWsxOC9B?=
 =?utf-8?B?akh1MWNtMUtBb3o0dWxBUnpvWjJnSDRGakYzR0krTThBZ1BuWmttM0hPWUh6?=
 =?utf-8?B?ZU85ZzZmMm5qY1RBakQ4ek9Md1ZkR2p5TWVCYkowbjFHdGM0RVFIS0RCNDVV?=
 =?utf-8?B?WEUxb3V6NHI4ZDhVTzhDSUNha0ZxdkVHZEljZmxBcSs2dDdUeC9oSW1tdzZz?=
 =?utf-8?B?R1lXeHJOMlY1dmpDaE1CeE05cE04YS9oemNVSVZ3S25nWUhBS08yQjJrKzl4?=
 =?utf-8?B?eGNZSzNVZ2Rsc0lYeTNyVUtLaHYyUXJmcHJ4WlVnZDRLdTlwZ01OMnoyUDdC?=
 =?utf-8?B?Z01kdU0wMnRuSmRvc1RTYzBwVHJqL2tmSXpLbGlvdVdXdzdRbDhyOGRicHox?=
 =?utf-8?B?dEdGa0UrS1NtVUNHMndYLzNWMk9Qdm1YSER2NkNZMDVrSy9rMWEzMzdzNlhN?=
 =?utf-8?B?N1JjWDIzTzM0NkwrUEFYQXV5VGxhenVzdnVkN0dGK3Y2bXd0blQ4V0NybENF?=
 =?utf-8?B?Mk1rQ0xHOUZXMWxZVGRnRHN5NjRTSGZnMjU0TWpsRUxwOGpDWFVJZHFiYkkw?=
 =?utf-8?B?dHphMUJqampNN05WU1dOSEJLUjEvMjRzcVMvVlN5R21DYUg3dEczdjNiQ1VS?=
 =?utf-8?B?QlRvT3Q5b2xBZGovVEMzSUZ3VUtIeXV5eTVzbVZpNmlNai9DaEhDQXFRTXFY?=
 =?utf-8?B?VEJ0SHhtdGF4U3lLdlp4NlZDM0h4UFJvUG52ZG15UG1oSXF1M1IrYml1bm9h?=
 =?utf-8?B?UWpFZExoWnMzdmV0aFVqUXVKVHZWdVR3QkMvTUUvNk5IM2VJWXlsV2QzL0I3?=
 =?utf-8?B?bmZ3NVBjZHF5a2F4MDQxUjloNCswTlZqL0kyRlhtT25mdUhBUy9NT2JhZEFK?=
 =?utf-8?B?QUhHYnBNazVERk5lSHdiTmdmQlR0VVRXWXdGSWtNSDdxOXp0SzczMC8rMnZ5?=
 =?utf-8?B?TW5VQjhwZFpFaEwwcGhYVGphandUQWF4d3BNdGZqWGF2dmVvbFBkNkxqRWFr?=
 =?utf-8?B?dEVUZW9kajNjQ3FmNnZpbjhjZUhPZXloNzJrV0huVlZWMWowR1dKM0JEejhF?=
 =?utf-8?B?UEl4WUJxTHJsWVlMN2I1ZUVKSlROVkk4T3lCM1pmYjlNM1lOT1NuWWtqVld3?=
 =?utf-8?B?MlFERjZPMHdKb09HL0xtTFhhSDhmNWVZZ1ZOUHQrTFpaWGk1U3daRUZpQVVu?=
 =?utf-8?B?aW9RS2tGNW5PaThqS0xpSGUvSEpmK0FwU1cvQ3FKaVdZNk9zZ0dpUG5OMC9u?=
 =?utf-8?B?SjJLNmllUmpzQmVLRlhFam5hbjdJM3RZTjRBOFFKbUxTSmZRTVdWL0lySnBT?=
 =?utf-8?B?UWNBMUJoVHp3OWFsS1dROXEzcW9LenVJVGRHVzh6dFVnUU9hUzlkRUN6OU03?=
 =?utf-8?B?dThYckhYSm9vRmRmYnp3aHhCdm1zUWF3Z0wrdlcyeTdWWUZnMjMyQk9vTkpL?=
 =?utf-8?B?UXVnaWFucUgwbHk4M3RpOGhSSnNmTkJLOElaU3NxaTcwZXFCNTl4ZHVRMnBz?=
 =?utf-8?B?Y1BUekJFT1Ayb3RiSXZWWU02TW9yUHRpRnlHZk5KV3FwMHR2eXFoSkpESk44?=
 =?utf-8?B?MXZQV2lOY1ZBN2NoTTdlN0g5d0tNa1U1aDRoajJJTmFJK2l1Kzd1QVNiNU9J?=
 =?utf-8?B?ellmN21qNkNhZWYvQndXMlppc1IyalhWUTlxeHFrYXVDYmpQcEZiZkkyU1BC?=
 =?utf-8?B?ZFVTQzczYnp0S3I5QzJqb05qOXhjQzM3ajU2eCswYWpySktVaVhERFZRaGg4?=
 =?utf-8?B?NW9DNG9udFZiRlY1dVJsSVNLQ1BYTHJGVVZSWng3d3RRVWVubVdrM28yS0xF?=
 =?utf-8?B?SEs5R1ZUV0Fhb0FadkNCWkpCcWRsRGhEZTJvVkFrK0lvQWFqNHZpRldXbVZs?=
 =?utf-8?B?TWREdDJkT20wOS9uSy9hdWFoSUw5R2pCMnRKNXVJNkM3WTVhOG4wN0lWSDFE?=
 =?utf-8?B?VnV5SHY5WEE0bUUyZDhSbWRQeWM5RjFmWUZlbFowaEdqM0R5TU13QjVkWlJv?=
 =?utf-8?B?dzBlckU1ZkZaL1Y5bFBWVmlYSXdDLzIvd0p2LzkyckZRem5ETWFqMGlETTZ4?=
 =?utf-8?B?ZDBTZ1ovTWVaZmQrVWVTNEx6eXk0MjBSV25OcXliOFhtalNPM3J3RkVVeVVF?=
 =?utf-8?Q?UbpS2bQcI6CNJ0qLE+t+lj4fEx+AFbenrfl1IE9BWE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F36DC665F07D474B90DB4748A28020B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5600.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9d52cb-c9c4-43f9-1b45-08db5bd97932
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 22:03:00.2079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAEo9ccLi44Uzco/U++FGlktPraqEqlUYaXZgk2jlTIugOw0xNjwWVKEhX1I8Njjdrkjiz0hQDsRUR0Wcu+L5HjzHZ/rn/+KP2LOEu5upSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5579
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VudCBieSBtaXN0YWtlLiBQbGVhc2UgaWdub3JlLg0KDQpUaGFua3MsDQpTcmluaXZhcw0KDQpP
biBUdWUsIDIwMjMtMDUtMjMgYXQgMTU6MDEgLTA3MDAsIFNyaW5pdmFzIFBhbmRydXZhZGEgd3Jv
dGU6DQo+IEZyb206IFRvZGQgQnJhbmR0IDx0b2RkLmUuYnJhbmR0QGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IEkndmUgY29tcGxldGVkIGFuIHVwZGF0ZSB0byB0aGUgYWNwaV90aGVybWFsX3JlbCBk
cml2ZXINCj4gd2hpY2ggcHJvdmlkZXMgdGhlIFBTVlQgdGFibGUgdG8gdXNlcnNwYWNlLiBJdCBp
bmNsdWRlcyBhIHB5dGhvbg0KPiB0ZXN0IHNjcmlwdCBmb3IgdGVzdGluZyBhbmQgdG8gaGVscCBl
eHBsYWluIGhvdyB0byB1c2UgaXQuDQo+IEkndmUgdGVzdGVkIGl0IG9uIG15IEJyb2Fkd2VsbCBz
eXN0ZW0gYW5kIGl0IHNlZW1zIHRvIHdvcmsgd2VsbC4NCj4gDQo+IFRvZGQgQnJhbmR0ICgyKToN
Cj4gwqAgQWRkZWQgUFNWVCB0YWJsZSB0byBhY3BpX3RoZXJtYWxfcmVsIGRyaXZlci4gSXRzIGV4
cG9ydGVkIHRvDQo+IHVzZXJzcGFjZQ0KPiDCoMKgwqDCoMKgwqDCoCB2aWEgYW4gaW9jdGwgdG8g
dGhlIGFjcGlfdGhlcm1hbF9yZWwgZGV2aWNlLiBUaGUgUFNWVCB0YWJsZQ0KPiDCoMKgwqAgY29u
c2lzdHMgb2bCoMKgwqDCoCAxMiBmaWVsZHM6DQo+IMKgIEFkZGVkIGEgc2ltcGxlIHB5dGhvbiBz
Y3JpcHQgZm9yIHRlc3RpbmcgdGhlIHRoZXJtYWwgdGFibGVzLg0KPiANCj4gwqBkcml2ZXJzL3Ro
ZXJtYWwvaW50MzQweF90aGVybWFsL2FjcGlfdGhlcm1hbF9yZWwuYyB8IDE4OA0KPiArKysrKysr
KysrKysrKysrKysrKysNCj4gwqBkcml2ZXJzL3RoZXJtYWwvaW50MzQweF90aGVybWFsL2FjcGlf
dGhlcm1hbF9yZWwuaCB8wqAgNTUgKysrKysrDQo+IMKgc2NyaXB0cy9hY3BpLXRoZXJtYWwtcmVs
LXRlc3QucHnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNDgNCj4gKysr
KysrKysrKysrKysrKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMzkxIGluc2VydGlvbnMoKykNCj4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgc2NyaXB0cy9hY3BpLXRoZXJtYWwtcmVsLXRlc3QucHkNCj4g
DQoNCg==
