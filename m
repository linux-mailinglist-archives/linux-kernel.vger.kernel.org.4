Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198DD6CF877
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjC3BKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3BKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:10:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F113A9A;
        Wed, 29 Mar 2023 18:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680138612; x=1711674612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HA/CyXTtPtDxwXtzQqBlQMS6lrG/DZ4eUmuzUSPDfUs=;
  b=I2ZQm+1Bl1Ly9QEFYGmy0RwZ3VsyQR/yvnlLEyVgng4dDG/2+dgHNVgU
   R/kSzGKs7J3XUBBknEzbp6REIGTuBxaZST2XfhugnlQhdh5nus2aiOoXW
   TvI2AQxV20xNWpZm5EC8+Z58Yw3sk4IqoezHIj6XPYaH1rgurnHHfjtEk
   KJuAjC3VWkq4TFzmVM9JodPzlFneBIi+IfGH2Kxny00GtmGiz57A4F6cF
   X6OUDjsj+qr0fna5abARtWuvwApjPW0xm8RkvLkiAalpNNnL5vtaXDgA/
   /g+PPNlGvO7hSC12YzKqWHP3fEaBusoZsxVNEkivOIHGpogtjkQLg/uGm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="341058616"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="341058616"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 18:10:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="687040741"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="687040741"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2023 18:10:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 18:10:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 18:10:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 18:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPBm+vajy9l8GMIk/AvQ6e6GOD3WLBJPM6v5KuR4bv/RjfCC4nm74I2z+aNd/N5NL7ZOQazp+9sw+QiR8dD8n81ZB177150ig4QWVlYwzMUlnDtl7BcskJ98iGJHO4wAiN8RE7KNuGENqy7NZ0SdZovLSu3pdTpDgD11siep4DObrbb0i2cLWqO1jIb9KK4jbFBtvDKGSy02Zqs4GET6AVu2b5YrDgkBSOopFztCKMT2yxWF/HuopuakIXU5enKGmS/V3D1rT1GjE/5f7BO69tgPzcx8JFZWvNK8qTRz9qD7Fmcj2/TDZKn0QtoJKchFJphzWyFlpGLJTLjBgX3ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA/CyXTtPtDxwXtzQqBlQMS6lrG/DZ4eUmuzUSPDfUs=;
 b=IbRNDafwdiAzrb0CqL+YbUcNM0bksQyoblNAvBKJS7r67F1GQEgv3XUd1bD9bfcA/tWU1NUGZ9Js7Thq5KmPqG+UvgSfqAmJ1/OD8Y5bwLMPE/tizzHwwFHAZvO2vows06Zi2ydIMLaPXNiEQ10Juk+DLIW8r2wHTSSHqPgP2MwoVRZxFz8wsdioyI7T5/gsuQMkWMbP+dIBPa5yA5ospxronD4F1KvGjhcZSl4w1JmU4GOkZYLZQpVhHN5JKsiB6zDiMILSeWSvb7SqyrN2sQR2tmv+JYUFFr+o8MAmVQDQaED+Y/UCW77ihiCcbKFAOv/hboYzBlE+xbeNPpMyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH7PR11MB6524.namprd11.prod.outlook.com (2603:10b6:510:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 01:10:07 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 01:10:07 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>
Subject: Re: [PATCH] x86/ACPI/boot: Use FADT version to check support for
 online capable
Thread-Topic: [PATCH] x86/ACPI/boot: Use FADT version to check support for
 online capable
Thread-Index: AQHZYmZqwCMAvwKNHEqwiN/tJdsjC68Sg+yA
Date:   Thu, 30 Mar 2023 01:10:07 +0000
Message-ID: <27c83d42e9cd95a1bfc34fa278315224a63cc062.camel@intel.com>
References: <20230329174536.6931-1-mario.limonciello@amd.com>
In-Reply-To: <20230329174536.6931-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH7PR11MB6524:EE_
x-ms-office365-filtering-correlation-id: fccf04ad-abca-4295-fa30-08db30bb804b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ii5ScBBHKLHSt8zWng3srPNFVoqrFGh3VweZFjLD+/nZ3Dy//56/EmWSsZ8b4sC0NRL88S8LZ7YcCfzlBAHv/ZyEYFjw3N4v7On4CPPDzsQSI71dyOwFAqSzilCD1HDm8ngbLRcUoOtzNBArv13MmxGtKhgbQKPlMWV/RueFlO4jJKkVcvI9s/P7cKLjhTKi8Zv51OVyXrVW7531cvNtMS52uibs+9BW6DDDzC5mHknaWgpEr8ZGwnEYv3S+37jG2jLf+DQgzEmTOwVfLYWzUOYgQeklV23KlH639qF+TbYZWmjBNcA2ruBuQwtU8v4O4uP2lb16lOOj3/CZHOEu+S65W6BnokiInQq4u239Q/ho64XqDVpDYWtoEFRs0POdfcIe9MaCyPcKXg0oGEXo4XlSK1ObIUH7BmUIpRBUMQcRnJn13YZNX3EJYzAlU0K6R8SWsZ5y1egSaFCFqGisq4Mv9HD3yKTIlaYzy5A422t1Q5AV6zqfzaLPVvGRDi61FBWntZK4r/1h4suEVq+xNArVwOzoLYzyt/owKNeGjr/pxV0IHgSXuyrNJkmjv4GriYzMfv3ZuZdXsGt15cn1giPenl7pNM1pJVAmmv+P/fQKQf9IIRBA8GwfJz7RSlRD+OmQyEisJeMpj4/v8Kv1y+gAxsPwQ3n1k9dJc57iV1Aam3axDwzNzh4US2wbAzcY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(6512007)(26005)(64756008)(6506007)(41300700001)(186003)(6486002)(966005)(71200400001)(83380400001)(2616005)(478600001)(54906003)(316002)(110136005)(66446008)(76116006)(66476007)(38100700002)(4326008)(66556008)(91956017)(7416002)(66946007)(2906002)(8676002)(86362001)(36756003)(38070700005)(82960400001)(5660300002)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW1Id2dlK2RlVHJ6ZVljemJSNml2cHVjNEd6b1BXN3NEOHlOYmdzZDA5TGR3?=
 =?utf-8?B?aDIwVy9QQmlJMzNzNDI4RHV1VEtBWFo2aGc0bmVoOGx4UUhORGwrSVNJRU9D?=
 =?utf-8?B?N29ZVUNzZ3JuMC9WczFrWXd6bE1SMkdMNm0wWmVnTE1DY3ZNNXVqVWRvUUJt?=
 =?utf-8?B?UFNWSDRRZ05Sb05qVCtKUkVpcXdSVzdYUC9BYnZOSmF3U3I3RWxOREtnYkgw?=
 =?utf-8?B?eFZOT3ZnTlE4SzhSemZzSjhHWEFOTnMrT3h0VjJsSGd1Q2lCaTlydkNWMWM5?=
 =?utf-8?B?TjNKa2MzQndhaCs0YkF3VnhyQ0MrazBwUFZDSFJLWVBXWGJRMFRuZm5LWEZ5?=
 =?utf-8?B?bDErdTQxbWxLcU5BMGtpM1pPKzA1dStHb0drVjNOR2V2d1E3UUpuWHVpZ1dX?=
 =?utf-8?B?ZUY4d2dBdE5ua1E4dG0wWkoycXMxMVYyTVJRVkRsSHl5UWhFU00yd3NQU1hj?=
 =?utf-8?B?Ym9zbjhuODgwQytxcjF4OXd4b3h3c3NkMHdKOTdQOFQwSmZDNXFIVHpKemlm?=
 =?utf-8?B?U1JEcWVzZGhvSEEvdlEzM0lyVXZSVDFGcmRITVN3SEo2SE02OHpQejZlVFN1?=
 =?utf-8?B?WS9XZEFEQTlwSHNLZzRPMC85VTQ5RENMMTNwWlFrdzRoODBEQkRhWktjaXRa?=
 =?utf-8?B?TjgxdDNKMVRQSDZZbzVmQmFFbE5DaGxxMngveXltb0JPZnhEMTN4Y0t0WkNB?=
 =?utf-8?B?cWVRVy9rV2lpOWdCWlFNa2pIMjQwSFNYU1V4VThaZFp6QmxIWHJoSEgvbGw0?=
 =?utf-8?B?SmtvZDR4ZXJ3dldMaUp6cDQxQ3hSMTIrU0lFV09yQVZVVDBlQjkwSWtKZk5j?=
 =?utf-8?B?T0hJeDhFVFdxdnJMMTlOVkZtT0pxK24zaUlLWSt0OEgyN0cvTUFrcG5vSTJh?=
 =?utf-8?B?Y3pGQlBLWDlVQWFPUXBNR2ViUDR6b1FuSW1NNlgrYzJER01Bc0NrWXNUTzBu?=
 =?utf-8?B?TTZzb09BZ01OUzNGWTF0UTFrVTM3YkpOV09FNllqSHJTaEZVZ01VaVc3WkJU?=
 =?utf-8?B?VnJYNHRVZUZ0SkMwbUtDTk5pSWowN1VCcDBiSlpzdnRLTTltQkxOc1gvOXBW?=
 =?utf-8?B?b0dIWjJCSGliaVBWSERLWFR4U2NFMGFtQTVlemV0aXJzMDVpWDRVajBjdms1?=
 =?utf-8?B?ZGJremgzeFplYnRJSkNjNkFRbG5qYzNOZTNCUXY3MFU5LzJTdnptL1pSRkhD?=
 =?utf-8?B?NnlsdGhIQWtXYWJyUDNndEQ1WXg2TGVvRFh3Yys0OHlkd1JXbTNHQkVyQ1Na?=
 =?utf-8?B?WnhxL3NJekxBdi94dEZ0THRWTE9pT3gxZmdZUVpUYllmTGVhQzBmNTlEK2NK?=
 =?utf-8?B?d00vOEF5WDFIZ1psUDFpeC9ianRUcjhtRDRIaW1qSEFvK0pUVHZxK1JYdDJv?=
 =?utf-8?B?bVk0M3lnUHhqeE10UEFyT1preEtHUmU1VjhNSlo0SnJmTkpBcVdoTnY1NUM2?=
 =?utf-8?B?UkNTdzRxckFad0FrSVBZSFVYQ3p5b0YyYzcvaVFEcW5uSjRYaDBjTnVuSWZM?=
 =?utf-8?B?NUhwdzBLSERlNUwxQnVCWHFLU0QzcUhFV2lZRmNSQzlETFlWaG43cCtEdEow?=
 =?utf-8?B?TGxFL1RndjNoZG5wSWdCMjhubUhwUlZPVVdnRHFVclluajBmblQ5TDFxOXhO?=
 =?utf-8?B?T2FDUWJlSk1IOWI2d1pJSXQvMjBKemZHOVY5QnQ1b1Q4OGFoVXA4d0R3VU9J?=
 =?utf-8?B?YmFqN2JOUEpFOFl6bi9CdjVuTHZMeGlCUFdEazRKdGIwbGc5NEJISHlMbzZT?=
 =?utf-8?B?citHWk1hamtiajRJQWJBRnUwNTVZTmhaY1ZwZjZoOWRtRTU2V0RidnVxbTQ5?=
 =?utf-8?B?WDlldXBPYlYwSURFRGJ4V3VvQkZpN21BeFVOYkdzUVVUZENudGdtZ0tWV3pY?=
 =?utf-8?B?anJDS1gwRUp3RndGckx6OUgyMVVrZnMwZEtEOEpCYVh3dWZzbHVLM2VhTzRZ?=
 =?utf-8?B?TDVRZ2tNZXY0d1lvc3FiSytxMkxoNlorRDFTZWMwUHBoRWRjUnRxeWR4VjdL?=
 =?utf-8?B?NEw2OVFmam85N3FjbS9SV0RZY21EWlIzM3FJNjRHWDd4dlZmZnVyanVJV0hx?=
 =?utf-8?B?MzR5M1lQYWFYQ1A1MjZPbHpyM0MxZ0VTc1FmQkVUT09mam9hSFhUS3JuNTdV?=
 =?utf-8?Q?TSW9TGpn+TOjHYTqyf+5DMxdc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B3AEA62FCDC1543B881D29416D172C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccf04ad-abca-4295-fa30-08db30bb804b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 01:10:07.2069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jL8qWlnc1qSjjmeHAC4VWnQuk3Q0j5Z98Kej8cacgrUZ6H/3msEDAOOPVLgC4JPeVL9fQQM4lPp3c8MgvWumig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6524
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDEyOjQ1IC0wNTAwLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90
ZToNCj4gQUNQSSA2LjMgaW50cm9kdWNlZCB0aGUgb25saW5lIGNhcGFibGUgYml0LCBhbmQgYWxz
byBpbnRyb2R1Y2VkIE1BRFQNCj4gdmVyc2lvbiA1Lg0KPiANCj4gVGhpcyB3YXMgdXNlZCB0byBk
aXN0aW5ndWlzaCB3aGV0aGVyIHRoZSBvZmZzZXQgc3RvcmluZyBvbmxpbmUNCj4gY2FwYWJsZQ0K
PiBjb3VsZCBiZSB1c2VkLiBIb3dldmVyIEFDUEkgNi4yYiBoYXMgTUFEVCB2ZXJzaW9uICI0NSIg
d2hpY2ggaXMgZm9yDQo+IGFuIGVycmF0YSB2ZXJzaW9uIG9mIHRoZSBBQ1BJIDYuMiBzcGVjLg0K
DQpJIG1hZGUgYSBkb3VibGUgY2hlY2suDQoNCkluIGh0dHBzOi8vdWVmaS5vcmcvc2l0ZXMvZGVm
YXVsdC9maWxlcy9yZXNvdXJjZXMvQUNQSV82XzIucGRmLA0KTUFEVCByZXZpc2lvbiBpcyA0Lg0K
DQpJbiANCmh0dHBzOi8vdWVmaS5vcmcvc2l0ZXMvZGVmYXVsdC9maWxlcy9yZXNvdXJjZXMvQUNQ
SSUyMDZfMl9BX1NlcHQyOS5wZGYsDQpNQURUIHJldmlzaW9uIGlzIDQ1Lg0KDQpJbiANCmh0dHBz
Oi8vdWVmaS5vcmcvc2l0ZXMvZGVmYXVsdC9maWxlcy9yZXNvdXJjZXMvQUNQSV82XzJfQl9maW5h
bF9KYW4zMC5wZGYNCk1BRFQgcmV2aXNpb24gaXMgNS4NCg0KU28geW91IHByb2JhYmx5IG1lYW4g
Ni4yYSBoYXMgTUFEVCByZXZpc2lvbiAiNDUiIGhlcmU/DQoNCj4gICBUaGlzIG1lYW5zIHRoYXQg
dGhlIExpbnV4IGNvZGUNCj4gZm9yIGRldGVjdGluZyBhdmFpbGFiaWxpdHkgb2YgTUFEVCB3aWxs
IG1pc3Rha2luZ2x5IGZsYWcgQUNQSSA2LjJiIGFzDQo+IHN1cHBvcnRpbmcgb25saW5lIGNhcGFi
bGUgd2hpY2ggaXMgaW5hY2N1cmF0ZSBhcyBpdCdzIGFuIEFDUEkgNi4zDQo+IGZlYXR1cmUuDQo+
IA0KPiBJbnN0ZWFkIHVzZSB0aGUgRkFEVCBtYWpvciBhbmQgbWlub3IgcmV2aXNpb24gZmllbGRz
IHRvIGRpc3Rpbmd1c2gNCj4gdGhpcy4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBFcmljIERlVm9sZGVy
IDxlcmljLmRldm9sZGVyQG9yYWNsZS5jb20+DQo+IFJlcG9ydGVkLWJ5OiBCb3Jpc2xhdiBQZXRr
b2IgPGJwQGFsaWVuOC5kZT4NCj4gRml4ZXM6IGFhMDZlMjBmMWJlNiAoIng4Ni9BQ1BJOiBEb24n
dCBhZGQgQ1BVcyB0aGF0IGFyZSBub3Qgb25saW5lDQo+IGNhcGFibGUiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gLS0t
DQo+ICBhcmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva2VybmVsL2FjcGkvYm9vdC5jDQo+IGIvYXJjaC94ODYva2VybmVsL2FjcGkvYm9v
dC5jDQo+IGluZGV4IDFjMzgxNzRiNWYwMS4uZTkyZTMyOTJmZWY3IDEwMDY0NA0KPiAtLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2FjcGkv
Ym9vdC5jDQo+IEBAIC0xNDYsNyArMTQ2LDEwIEBAIHN0YXRpYyBpbnQgX19pbml0IGFjcGlfcGFy
c2VfbWFkdChzdHJ1Y3QNCj4gYWNwaV90YWJsZV9oZWFkZXIgKnRhYmxlKQ0KPiAgDQo+ICAJCXBy
X2RlYnVnKCJMb2NhbCBBUElDIGFkZHJlc3MgMHglMDh4XG4iLCBtYWR0LT5hZGRyZXNzKTsNCj4g
IAl9DQo+IC0JaWYgKG1hZHQtPmhlYWRlci5yZXZpc2lvbiA+PSA1KQ0KPiArDQo+ICsJaWYgKGFj
cGlfZ2JsX0ZBRFQuaGVhZGVyLnJldmlzaW9uID4gNiB8fA0KPiArCSAgICAoYWNwaV9nYmxfRkFE
VC5oZWFkZXIucmV2aXNpb24gPT0gNiAmJg0KPiArCSAgICAgYWNwaV9nYmxfRkFEVC5taW5vcl9y
ZXZpc2lvbiA+PSAzKSkNCj4gIAkJYWNwaV9zdXBwb3J0X29ubGluZV9jYXBhYmxlID0gdHJ1ZTsN
Cg0KQmV0dGVyIHRvIGhhdmUgYSBjb21tZW50IGhlcmU/DQpGb3IgbWUsIGl0IGlzIGhhcmQgdG8g
dW5kZXJzdGFuZCB0aGlzIGJ5IHJlYWRpbmcgdGhlIGNvZGUgZGlyZWN0bHkuDQoNCnRoYW5rcywN
CnJ1aQ0KDQo=
