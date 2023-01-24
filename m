Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE04679116
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjAXGhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjAXGhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:37:50 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208148A6E;
        Mon, 23 Jan 2023 22:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674542261; x=1706078261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UHtVCs8RTR0YkWB+LNGhDQr3o9xPqc3BOwTBBymULZk=;
  b=LyD9k57H3XWJH9ZnF5+CX/9usHN0jf6eOtOBa1Tck86a3dUligNghQNR
   15d/4TPSh4qjGKtybHib1nn8aqMLl/LOmJiUS8cX3NcEocUES+9gCtDZc
   ppjMeG562vCa47kalKJgfdgdIqoEdZlHXUBOG5vTQEeMEYo4TeFywz3iD
   ga73DkWo9M1hwJpgqewG2V4IJpDXhjvMg/xkztMr//uue0pgD0B9EH5m9
   wz9JU3nxQhx1ql7817lS/5i57nxV+I9yJlNK8jkMxS50W9KDxDhd68ZFJ
   hRMaA0Dkdn9u6A9RuDbVvUBbsyQ1ENuIXtuVnhqKIT6C6cSDxEU9WXaFN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390743800"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="390743800"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 22:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="804473051"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="804473051"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2023 22:37:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 22:37:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 22:37:37 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 22:37:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PelPM6QJr6b5sQARMLPVrxeYDmU9scByI7Dye6epFwbDYJ3Arzexwo+aeCdd828noS77UloEjLeTKyvF/3shpWDMFALY65hLrCyP+8Hy+bZ/omvmbin1HBdbd0CuhlsJv0sfwW6x+z26zIdXvrzyTqZI3VLMX5Yo6vUo2KwERRvz8S4d8AZ6/KHq7/U8ZmWvDw9H0bI0pHjIIh90O537X9/jMBSiqXMCENb8rcCpPHX8xniwP1kQpyY6xzQVYKjiOpqr/EsVj69X3E42c2tmBxmX54o4bj6NW/yAYqKOFZVaE5D6WvaoehSFlpF723ZzCOBQOHeUHx7jCbaixXgFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHtVCs8RTR0YkWB+LNGhDQr3o9xPqc3BOwTBBymULZk=;
 b=I3xbw8+xP2X/7B+1gi9S5xDQL6Y6zjzVb+NYM4EPyCz8Dr8Ub7cogVAS5/vk2KJHFOYaPOrUzCbjdM9vZO5uUYY8SDX2Hzr3nhfuzKIeFaONACdykino9Y3iPuFhiJ3/I0OOwLeyjTln1Z//XCtwHaIrnz96b9BZOP7zCI/fXb8czaoe7sfOqqcRdAQqBzUvvGMpqsOsZtwKYTr9A2c2btxzL/I99RoXFccw+0nssVBripX5HS6acQKE7G0Kt518O293CJe4ZuJAEtX1RXdjOiRWEMxSeR9BUU5ynKwaGRNtDhg7mmn5t/xouBvdyP3kWYzZoaEC+qAhyUzP5uRYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Tue, 24 Jan
 2023 06:37:35 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 06:37:35 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Subject: Re: [PATCH v2 1/3] thermal/core: Fix unregistering netlink at thermal
 init time
Thread-Topic: [PATCH v2 1/3] thermal/core: Fix unregistering netlink at
 thermal init time
Thread-Index: AQHZLz9ajar6aeT6u0q92e1WWml0za6tHi6A
Date:   Tue, 24 Jan 2023 06:37:35 +0000
Message-ID: <9c2322a56f9cdc020e55a9e2003f434b84d873a7.camel@intel.com>
References: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
         <20230123152756.4031574-2-daniel.lezcano@linaro.org>
In-Reply-To: <20230123152756.4031574-2-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB7497:EE_
x-ms-office365-filtering-correlation-id: 8ea37632-5805-4234-fa1e-08dafdd57a7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OBu1/rKiRnEyo/dyRnPSF1QLbull2v1Rr0OkN+lG6TIRLGrvyfdtG/0l0S2eZPteFnU6wIIhZ+y8VIDIoT/5u0mHjFndy8ubIoCUTihggF7W0DkHfu4jVgeWe+9jrSJfnszIZHKSxja4q/8Gf6lzhr5tmvMnD0GJsPbam+he2dJr+2mhfHsDY0wB3OHA9pe+INI9CbmMTn73hqpQXrq9rF2HcuhNcOFOqPj/FIb2da/pj8aHfYSjmqBq5fORgNK5334mh4jUkh/zohzamSV7gv1UAOYean/GITKGEeGdSBi71Hs0YVm/BDrbk4hGFIM25fnUi2ICS/pyNaywB0EVfLassxUFcWXek8+/m9It726hKf+JahwBGgOPKNzHpMcXYT6/o96onzwuLH9vewjYMltzqKLNgEO/h3b+MSwvm9Qa/vu1CLk9mY+IUKqhIX1SVwaI8PXP7lgJXgFz/55G5W5igpkk2yadHvCpAKzmDylZ8Y+u3jWAbXjvZlc9w/uw1a/nEyKxDaCZIm8NdWu2ED2mdPO2i/e4LZ1al07H01jxjZXWcyz20cFRgQeZ9pxU3OT5Ohw32TmyddvdpVlcZbkKMaZ25nbRI6W8AWXbjszJzk2EyNVF/ScGcGwoEVfIvhhJTeFAqkTvmmCUMxwPMJUMksFqbL4Q8rnXEHHsDaii/IKfJMnxNxEPJx92OPrOTyVOmDBesOn0nzazxNMCHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(6512007)(26005)(186003)(86362001)(6506007)(478600001)(6486002)(71200400001)(36756003)(82960400001)(83380400001)(2906002)(110136005)(316002)(54906003)(38070700005)(2616005)(66946007)(38100700002)(8676002)(4326008)(66476007)(66446008)(76116006)(64756008)(66556008)(41300700001)(122000001)(91956017)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZldQYlBXTjlsL3ZSdGdOdlRRcytoemVlSGZWaWRlWDBqYzZWVHhHeUQvWWhy?=
 =?utf-8?B?alJjUndNQ3o5dEI3L3p3YndXZ1FyWDZUdXN2eEphajJnTTcrVEh6MW83RWdS?=
 =?utf-8?B?WjFlVnNnZ09rdlAyZkZxYUkreFhWZ0oxWkFJU04zSml0c09VeWtqVFc0eXY0?=
 =?utf-8?B?bW1MaE9iUXhJemZxZ2lOUm93S2srWXJpVXBUZ3dtcW9KQkJkeTZMUElYdG5Z?=
 =?utf-8?B?cmJoNWZJcjZsM2VvSFhzc1gxQjUzSDVXSCtJb1lLOFY5MDE0VVVJSyt4bGhz?=
 =?utf-8?B?U1JvVmlLM2ZTUlFMODg0dFRpL3M3MFlPT0VkRjBIVVNHMWd0ZW5LN0c4ODZL?=
 =?utf-8?B?QmdlK2V3c1h4aktnTjVMRU5EaFljMCt4TTdtck03V2Q5aXVaTXNoM0JkK3Ri?=
 =?utf-8?B?U1FTek5kNktoeXM3bDVORGlVM2hFNUxLaVNzR2NjdUR4Rm1lQUgxbDg3YWJK?=
 =?utf-8?B?Z3NlczhjeHZaNDJZZXhTOHZoWW8xdWFaM2VHRVZMemY1Y1Q3VDhOVG1vVmxF?=
 =?utf-8?B?WUdmaTFMNDB6WFVmdk1lL01vVm1Sd09zZksxcU5zRXh2WmVtbTNvM1BTbEUz?=
 =?utf-8?B?VXllY2hNdXJXOWFzaXIxY042TDRaQnNxOTl1aTZITFB4ekh6UEdzL0plYXRl?=
 =?utf-8?B?NUxUNC9HVTlORWxyd0lWeE9ZZjk5UWJHa1hoZU52dFZmODQ2UzJNeEVuWlZh?=
 =?utf-8?B?UWErN1BjalFoRzZ1Z0hWVjVUWWtQWGRHUitvbm9zemJJZmhIbHlvZmdkekgx?=
 =?utf-8?B?eis3c29wNURkNmwyRzh5b0VRVEc3UldOWGQxOFFLKzZVWHJWSzdidDlQOGhp?=
 =?utf-8?B?Ump4TmsvaDlxMnNIZThhbUNnYjRTelkzZ3dWazBOQ29SMVhlUXRwU1BkS3RY?=
 =?utf-8?B?RDZmd05TNS85RXc3V244R1NzZ1NURE9QOEY0Z1JCMy9UNWVsTzYwZmtNRFkz?=
 =?utf-8?B?M2ovbWxsdUxaQmN3cG5ZU3R4UHZhUU84L0hOZGhBZldqTFMrK05TTjQ4N0Ir?=
 =?utf-8?B?c0MzVkZEa3JiUHI4UHdRaHVUQ1JEUmQ4dDZ2c1Boa0tUd012L2VMUmlJcmF4?=
 =?utf-8?B?OVJESVJlMVFvcG1udHp4UlFrMmFRYkpQZzRUQkZwbVltb1Vhcm12Qk5IVldk?=
 =?utf-8?B?RzE4ZmpXbUF3eXBXTGdXQUJEbUxKSFRPU0c5ajhjNnNNS3pEbWpuc0VVMjE1?=
 =?utf-8?B?U2UyeEZZTlJWYlNEOWJTdTRGcml3dE00RG03NFlWaG5VYzRlekRHTzFzYU9Y?=
 =?utf-8?B?eUV3Q0tJV1FoMGpVRVlwckwzR1Z3K1o1R1BBWTEyeXREbUk5UmN6VVBKUnRs?=
 =?utf-8?B?YktEeG5aZUJJRHZWTUlzMDZaMUo3bERWYjducCtJUEJKalFMWUtOanpmUHBR?=
 =?utf-8?B?WXFZclQwaTZxd2Z0NHZxM1RXbG1YWGw2aVU3cmVENUtoU2drQVFHNDdCV2py?=
 =?utf-8?B?UGpyZWJhUXJpbEk3NU5LMFFMT0gxNE9ma0lxb3RGSW9SZVF5Q2FlZ3JFUjEy?=
 =?utf-8?B?T3FCTG9lUmV0R0g2RlBFdXdrSXl1d0RWNkxZYUp2a0dTK1V2eHJlMGF6N2ZE?=
 =?utf-8?B?NWxZaHI5NkZOc1N1UlpCSjR6cFhreEQ4eFl1bU1RRWxKZjdxYXRTNUtKQkpI?=
 =?utf-8?B?QmtqR3hIdVQrT1UzK3l3S2g2WWJZVUNpVFZFeWZPQkVDeEgwTkNPVDJZVXFq?=
 =?utf-8?B?T1NmNjVWNlRweEEvUTh5YzVjdFk0TURvMVo1T0d5RXpOdWV1Q3gvNjJxMnRx?=
 =?utf-8?B?ZlJUZW1LUm5RWjZnZ1lZcVp1SEZ0MFdyRVl1amdYZmRVMmkveUF5a0hZSVF6?=
 =?utf-8?B?WExseTR5aGxUZkthaG01YkhPRWMrVVZXQ3hmWHN1S3NCZEh0ZHR1bEIyQ0Nl?=
 =?utf-8?B?eVJIeTJsNUcvWkdWN1J1Uy9zTlE3dTU1V3p1ZHJUTWVKd09aMmNXN052czhu?=
 =?utf-8?B?YjVJbWNQbXFTa0F2MEtmNVFnNmY0RlJ4VitOVEFFczFwVlgrUjZ6UWtPclJm?=
 =?utf-8?B?RTViOHM4UWg3M254enMxcGdqVTJXdW1uQ3dnK2RORzFGQkdtdmQyWlgyUk1V?=
 =?utf-8?B?Nm5QcmNHTlFYazN5cWg5WDdXd2g4bzhhZDZ6VTJjUkZPODlWNW5KamtXeVUw?=
 =?utf-8?B?VkFZMzZpR25kYUs5aWpDVTNiTi8vK0NKcnRGbm16MzhDei9xRHNZYXZHSzVG?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E783875A9127A4C87D8DB6039438DB1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea37632-5805-4234-fa1e-08dafdd57a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 06:37:35.0528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOXLjCGkR0KeIf/bGd1P0dzBKfVZy6hbu7agyb0J7HYQMnARrZhBFoHlLDNctvs+sChVCRB5CGbbak+OTFvkWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTIzIGF0IDE2OjI3ICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gVGhlIHRoZXJtYWwgc3Vic3lzdGVtIGluaXRpYWxpemF0aW9uIG1pc3MgYW4gbmV0bGluaw0K
DQpzL21pc3MgYW4gbmV0bGluay9taXNzZXMgYSBuZXRsaW5rDQoNCm90aGVyIHRoYW4gdGhhdCwg
dGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuDQoNClJldmlld2VkLWJ5OiBaaGFuZyBSdWkgPHJ1
aS56aGFuZ0BpbnRlbC5jb20+DQoNCi1ydWkNCg0KPiAgdW5yZWdpc3RlcmluZw0KPiBmdW5jdGlv
biBpbiB0aGUgZXJyb3IuIEFkZCBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBMZXpj
YW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdGhlcm1h
bC90aGVybWFsX2NvcmUuYyAgICB8IDQgKysrLQ0KPiAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxf
bmV0bGluay5jIHwgNSArKysrKw0KPiAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfbmV0bGluay5o
IHwgMyArKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0K
PiBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiBpbmRleCBkOWEzZDk1NjZkNzMu
LmZkZGFmY2VlNWU2ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29y
ZS5jDQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiBAQCAtMTYwNiw3
ICsxNjA2LDcgQEAgc3RhdGljIGludCBfX2luaXQgdGhlcm1hbF9pbml0KHZvaWQpDQo+ICANCj4g
IAlyZXN1bHQgPSB0aGVybWFsX3JlZ2lzdGVyX2dvdmVybm9ycygpOw0KPiAgCWlmIChyZXN1bHQp
DQo+IC0JCWdvdG8gZXJyb3I7DQo+ICsJCWdvdG8gdW5yZWdpc3Rlcl9uZXRsaW5rOw0KPiAgDQo+
ICAJcmVzdWx0ID0gY2xhc3NfcmVnaXN0ZXIoJnRoZXJtYWxfY2xhc3MpOw0KPiAgCWlmIChyZXN1
bHQpDQo+IEBAIC0xNjIxLDYgKzE2MjEsOCBAQCBzdGF0aWMgaW50IF9faW5pdCB0aGVybWFsX2lu
aXQodm9pZCkNCj4gIA0KPiAgdW5yZWdpc3Rlcl9nb3Zlcm5vcnM6DQo+ICAJdGhlcm1hbF91bnJl
Z2lzdGVyX2dvdmVybm9ycygpOw0KPiArdW5yZWdpc3Rlcl9uZXRsaW5rOg0KPiArCXRoZXJtYWxf
bmV0bGlua19leGl0KCk7DQo+ICBlcnJvcjoNCj4gIAlpZGFfZGVzdHJveSgmdGhlcm1hbF90el9p
ZGEpOw0KPiAgCWlkYV9kZXN0cm95KCZ0aGVybWFsX2NkZXZfaWRhKTsNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX25ldGxpbmsuYw0KPiBiL2RyaXZlcnMvdGhlcm1hbC90
aGVybWFsX25ldGxpbmsuYw0KPiBpbmRleCA3NTk0M2IwNmRiZTcuLjA4YmM0NmMzZWM3YiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfbmV0bGluay5jDQo+ICsrKyBiL2Ry
aXZlcnMvdGhlcm1hbC90aGVybWFsX25ldGxpbmsuYw0KPiBAQCAtNjk5LDMgKzY5OSw4IEBAIGlu
dCBfX2luaXQgdGhlcm1hbF9uZXRsaW5rX2luaXQodm9pZCkNCj4gIHsNCj4gIAlyZXR1cm4gZ2Vu
bF9yZWdpc3Rlcl9mYW1pbHkoJnRoZXJtYWxfZ25sX2ZhbWlseSk7DQo+ICB9DQo+ICsNCj4gK3Zv
aWQgX19pbml0IHRoZXJtYWxfbmV0bGlua19leGl0KHZvaWQpDQo+ICt7DQo+ICsJZ2VubF91bnJl
Z2lzdGVyX2ZhbWlseSgmdGhlcm1hbF9nbmxfZmFtaWx5KTsNCj4gK30NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX25ldGxpbmsuaA0KPiBiL2RyaXZlcnMvdGhlcm1hbC90
aGVybWFsX25ldGxpbmsuaA0KPiBpbmRleCAxMDUyZjUyMzE4OGQuLjBhOTk4N2MzYmM1NyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfbmV0bGluay5oDQo+ICsrKyBiL2Ry
aXZlcnMvdGhlcm1hbC90aGVybWFsX25ldGxpbmsuaA0KPiBAQCAtMTMsNiArMTMsNyBAQCBzdHJ1
Y3QgdGhlcm1hbF9nZW5sX2NwdV9jYXBzIHsNCj4gIC8qIE5ldGxpbmsgbm90aWZpY2F0aW9uIGZ1
bmN0aW9uICovDQo+ICAjaWZkZWYgQ09ORklHX1RIRVJNQUxfTkVUTElOSw0KPiAgaW50IF9faW5p
dCB0aGVybWFsX25ldGxpbmtfaW5pdCh2b2lkKTsNCj4gK3ZvaWQgX19pbml0IHRoZXJtYWxfbmV0
bGlua19leGl0KHZvaWQpOw0KPiAgaW50IHRoZXJtYWxfbm90aWZ5X3R6X2NyZWF0ZShpbnQgdHpf
aWQsIGNvbnN0IGNoYXIgKm5hbWUpOw0KPiAgaW50IHRoZXJtYWxfbm90aWZ5X3R6X2RlbGV0ZShp
bnQgdHpfaWQpOw0KPiAgaW50IHRoZXJtYWxfbm90aWZ5X3R6X2VuYWJsZShpbnQgdHpfaWQpOw0K
PiBAQCAtMTE1LDQgKzExNiw2IEBAIHN0YXRpYyBpbmxpbmUgaW50DQo+IHRoZXJtYWxfZ2VubF9j
cHVfY2FwYWJpbGl0eV9ldmVudChpbnQgY291bnQsIHN0cnVjdCB0aGVybWFsX2dlDQo+ICAJcmV0
dXJuIDA7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBfX2luaXQgdGhlcm1hbF9u
ZXRsaW5rX2V4aXQodm9pZCkge30NCj4gKw0KPiAgI2VuZGlmIC8qIENPTkZJR19USEVSTUFMX05F
VExJTksgKi8NCg==
