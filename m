Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3085748FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjGEVYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGEVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:24:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501619AC;
        Wed,  5 Jul 2023 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688592287; x=1720128287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cS9BIti6XHohBhd1CXY/KGnIj/xYBykYU5NZ7mWvY8U=;
  b=j+pf+fGctS14+g7FHbnFna1WfXff8K2PG3boRzz1oFGeP9Vyzuwp1tVx
   UAVkH1ehLjwnOyq3l/q+ktd5IrIr/syQpII+YlAlVVhGgfsv4dcoOI9FM
   GcUev1QJMlPLJ3zIq9X2mddYNPdbaYkp+XMgv7FK8n7R9sBYyga6qu95B
   Fzyd0wKiXlW18V7tSrK6W60z4akpIgA4IZeRuXJ0Q9gI771Bbk4srupxs
   TBYyp+Q454w21siC/Uoi9r+o1Sw0k1SkjzgfR9u8ODpSvjgn/YIW9hz0K
   FqGGrQpqb43XIvAFmxNipXw3TNxODblfYdg7C6nlpjCCE+6gyOpKQdfWu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343039139"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="343039139"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 14:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="748885711"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="748885711"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 05 Jul 2023 14:24:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 14:24:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 14:24:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 14:24:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKBBl9ck+DAHQzMyJFer4Nlktdg6UpzWHJMVzuQuET/kBHSUngFBXYNWlAkTIwiz/Kx9Ehlt45iKi4u29UC6/cPs2x+75kCZL//aDhBKnEXbGODbRp+K8QcHyPgYHOPWEa9aa7+qX+1gFJP+rC1qEnf071nZ+vMssLjPtZv+2TnvKiCUvxK5ZBNbfRBLccS4/EYswKkdLaoGRPdHBnqEkqYAIwHiIvkDz/q2CMIu/x5KVbmlhPkkr/hlnmyXf+S9rilArvCl05trTRQOE+f4KdeIYXnMJ5nNRF5DeymwRsKRaE3f2Id0KiG/dKRMhBOIURtfTx1xHf7VrcR4lGYzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS9BIti6XHohBhd1CXY/KGnIj/xYBykYU5NZ7mWvY8U=;
 b=FMvjGKof5CdGzaPOmRMq3GLr0fPR8u/gr+9t+q8WhQh4slobz782uyfGfp9UrKYbO8nFtvLgZ2ZMSiSGiBg9RByPuulZMbZj016KTK/9tzEtxZZgozygVl281sXldZMzt88AiV8AGbpWfjwfYB+UW7GNkFGmBGuVR/kiwlCuKPHDMCJBZTQ8+1QYkddth9IhaVcB38vIkINZtSWIqtYW3ToNkmPLl2gVPx3fiEYC2vdDHNPLEKwN7RIs1GlJwUG37avjOXfMgAWJeLU/ruKJNEPT54HOOv99EpYJ8NRLXzzx7nsZAb3YhXz7lJbsTU2xXh1mMRHMkTPtLsN0liib0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by DM4PR11MB7183.namprd11.prod.outlook.com (2603:10b6:8:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 21:24:43 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::8e37:caf2:1d81:631d]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::8e37:caf2:1d81:631d%3]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 21:24:43 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NFIT: add helper to_nfit_mem() to take device to
 nfit_mem
Thread-Topic: [PATCH] ACPI: NFIT: add helper to_nfit_mem() to take device to
 nfit_mem
Thread-Index: AQHZrbDCCeF1j+qGJU+HOrk6bhPjmq+rstUA
Date:   Wed, 5 Jul 2023 21:24:42 +0000
Message-ID: <f91f0e2e990a598be0cfb7285a6c1904470d3fdf.camel@intel.com>
References: <20230703131729.1009861-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20230703131729.1009861-1-ben.dooks@codethink.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|DM4PR11MB7183:EE_
x-ms-office365-filtering-correlation-id: 6bb5a891-a5f1-4db7-f3c8-08db7d9e3fa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ymeg6tm14WVJeAP9WQaIVe4Azfc0vbJGxoZsCuEhVFWsPkK9+TN+RvLaFVXU9v4hDGtCpFuQlO1fy6a58eqVph3iD7qM/u1FWO0wB/6etUrSOZBrZtRlVnKWzqp6WYCFzB8k3Bb8gSDOccJXoFNSSu0+/8gNcMnmBN7EAJSxHjSKyUMTZNYveJKWFYGLaBx1nYdQP0J8kmaNADzMl24w3m85dL3QU0FBnO3NmnrCFYoW3IbNtdnyus9VBB5OdUmHGI109kXs1zp22v2MWNw2GHfEeKWvGgjOGKNG4zoz3msFEWwFCn4BEp6aFKqvRabf+BIvk9kgHjZ9BkfVj9LRubnzfnfukU/WYOgV/NFwfUXNO1ay+LTXTU5rweVNJAHznUbdNffjWuh5aznCSISwGBJRyBC2IQE1qY51hb9rUYBrY+WWjr27bt3pbXXH5hxUMHAOSbO7cHAKxz2jOsY5u79quU8GQ9GgQq184ZbQ5cZxR8clrfql8qIxPNlGuGZMp6HXJaQJ5EsvLU9g3UHVsWu0bfk8YwJubUdg1p27lDtaSZxXefzN0odeoWqr3e6LQFQhbqsowWFnGkzwA73H1MWbPVPQzQGPqpwkORZ7mCYNZsrzLrg6IU4T6tqYNNH2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(76116006)(71200400001)(6486002)(478600001)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(38070700005)(2906002)(4744005)(186003)(26005)(6506007)(6512007)(82960400001)(38100700002)(122000001)(41300700001)(66476007)(316002)(64756008)(4326008)(66556008)(66946007)(8936002)(8676002)(5660300002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MllJc21JcXAxaHpPaW1JQ3hDL1Q1dkkwTjRhOTRhWkg5NWkzVzBPYVlhZGZs?=
 =?utf-8?B?SDA2Z2VGVkRzOGoxOGYxU1M5SEZ2c1R6a1NySWkrR1ZtNlBBM2ZGekdvWWtD?=
 =?utf-8?B?ZzN5eHhIbnNOMUhNZE15d1ZhSVQxYzVHRnZlY09GWTZtbERMcStFKzRPRVQr?=
 =?utf-8?B?bzQ4dkxRblgwY2FaT2tFd3VtRWxtSjRFcWthc3dXeERMaXJCbEVYaHE4Ry9E?=
 =?utf-8?B?U2pjMFBDSmFGOWsrbVFZdGFnNGZMVk5RclRlSjFRb0h6VVRuWXNUbnRzYjFK?=
 =?utf-8?B?cmxuZUViS1l2K2FGTzYwVGdaSUJOUHNnNGhRdEVEbkFzSjEreEZKbCszMHU4?=
 =?utf-8?B?NjZCSmhKOTgybFE4WGxlSTJxRktjNCtpMDQxOUZJaFRuQ0NibVBDRU5uSjVS?=
 =?utf-8?B?THY0WGE1QXE4d00vcG9mdThKVVNtdHRwd0gvQVB0OWw4N0FGenhCcXM1cnd1?=
 =?utf-8?B?R2poUXdwa0d1WEhnOEdkeXZYaXB5UFFSMGt0WGhVTis5OHgyT0R5NU1FZ09n?=
 =?utf-8?B?dm1xRUZ4aHhBdW81aVdHQThXS3VHdVlCS3kwa3gwOXZ3WEpXMjhTL0phWjJC?=
 =?utf-8?B?L3Bjc3RYMU1Hc25MK1JiUUF3bGJiVW1EU2l0blg4SFJHMDJFQW5nZGVwaGdL?=
 =?utf-8?B?RlhwNzhpTGJjQlhHZXBxekRZU3FDNGRQV0grZTIyQThHZ2VObkN3YWZxczlr?=
 =?utf-8?B?L2EwdEhlZkplbGUzRUloQ3RaZTJwandHVG9KM0tUa1ZOZlgwMWFYd1ArNlkw?=
 =?utf-8?B?c25LdUNnLzhJek8rd015Y1ZPRC84VDBhN2tjWlk0WXRWUDRxNjhkMmtMNjJB?=
 =?utf-8?B?NTdIdG5CZ3BGUHQvYS9XNnpYYW96eldNL1hiNkNjZ0JDOVBCTXhBTXNXQzk3?=
 =?utf-8?B?TmV6WGdQL3dISzgrL2hVVUZLNy9VRlFBV0NLM3VhcWRyb2lkZDVvL2tVSE12?=
 =?utf-8?B?eXowRnpjU2lyWnJFczYwTURyK1diOVZwRmpyaEd5NlgvSHA5Znk2ZHAyYi95?=
 =?utf-8?B?TmN6L1VpK0dLQVYzU1RkMUI2dytrV0h4eDNTMDJHUkhYcWtQU1B5dGdZbGpL?=
 =?utf-8?B?am1KSmVqclRYZU5hZXJ1QTRsQlZEa2JyU2gzdFRrZTBBbFlFTzAvUlJvK1Vu?=
 =?utf-8?B?Wks0T3lWb0lDZ1VtekJibUQzZWF2ZmVHcVNldXU5cUpIdkd3UnBVRTBvNGM5?=
 =?utf-8?B?Z1NWMkswQjNMYy90aUFGemRNS1c2YnZCSEFHdnMrbnNtcERjY0pDVEkrZzRs?=
 =?utf-8?B?RGk0V1pjc2RrRWRzQzlCKzduNlhzSkRSVUN4TldhRW4vNFEvemRGVXFEUnVm?=
 =?utf-8?B?cy9XNWpVb2lKZ1EvbGFmVHovemh6UFlIUkdCNUZLTnF6U0J6SEpRZFBjQmZE?=
 =?utf-8?B?TGVlS0tWMUozcEpLVXgrcjBaZDJFeTdNS3h3VTJTbnM0K25FakZ4VkZwUVox?=
 =?utf-8?B?elhnUnVNTzNJbjlvdm9sR1NOZlYrTWpsbjNwV0J0V2UyV3lINUhJN1RjTFdl?=
 =?utf-8?B?QjA4dk1EeFpZZVdEUFpWdml6U2VoUmNjOGRTYjRlSVpMT2dXNGtQNTRjQ1Z2?=
 =?utf-8?B?YXVLTkVUMGV1aXpiemFwajc3Sy9WWGMva2VBanRrMnVZbjExMnpQZUZSMlBL?=
 =?utf-8?B?c1ViWEhMcUlqbkF5Ynl3WG5vdjBRZWMwaFg2aWxYcTJ4cWZuYXl3eU9HbFZO?=
 =?utf-8?B?aUp1S2hWSXpVeWFQc3NnYWJ6eGhJMzhDd1psUU9ybUl5V0VxMVoyUGlEd1Vp?=
 =?utf-8?B?WnpRSXp1SHlIcStVUTlNeE9XQ2VFUUQ1N2pvWUpld04zd1pwZmZRRFZ6VzB5?=
 =?utf-8?B?aHFkL0orbFdydHgzVG0zSG53THdhOEVTVWRIM1gwdEl6QUtyVjZyVWcyN3I3?=
 =?utf-8?B?TGllQkxWOTNHVGhTUng4RUJJTzFORlRNWlQyQXNORE9TR0V2YitYWXhBa3ZT?=
 =?utf-8?B?dE42RHhPOGFBWE9ZNkI2T001czFnem95ZWE1aEdTSzJpY3hxd1AxSDQva2Y1?=
 =?utf-8?B?ZlpLTGRqeVBiUmRrc3hMQmtTK255V1NrQWZGcFJRRU0yaG5IYmMrWXdmcnRT?=
 =?utf-8?B?OXdSUW9kZXU3UzBhZ3BUU1ZHK2k3bHVnM0p4Y1FsWERadHRIS0ZLekx4L3Rr?=
 =?utf-8?B?THdpQTRLS2puaDhERjB6MUNUa0dTcTFtc0FuVGxIU0taYTFQM00zdFBhbDhP?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <862EDE56CC098646BD56FA9657101235@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb5a891-a5f1-4db7-f3c8-08db7d9e3fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 21:24:42.8965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HomhgkNKUZLfMgLtoaOsF5frkCS3ZQN57HzeXHUMZ9XBbqJSljdxN4DluuAAThTXS4jD7nT7Tnh7RjIdQ4tVYEypIsvW2N92ja+ctE2N214=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTAzIGF0IDE0OjE3ICswMTAwLCBCZW4gRG9va3Mgd3JvdGU6DQo+IEFk
ZCBhIHF1aWNrIGhlbHBlciB0byBqdXN0IGRvIHN0cnVjdCBkZXZpY2UgdG8gdGhlIHN0cnVjdCBu
Zml0X21lbQ0KPiBmaWVsZCBpdCBzaG91bGQgYmUgcmVmZXJlbmNpbmcuIFRoaXMgcmVkdWNlcyB0
aGUgbnVtYmVyIG9mIGNvZGUNCj4gbGluZXMgaW4gc29tZSBvZiB0aGUgZm9sbG93Z24gY29kZSBh
cyBpdCByZW1vdmVzIHRoZSBpbnRlcm1lZGlhdGUNCj4gc3RydWN0IG52ZGltbS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEJlbiBEb29rcyA8YmVuLmRvb2tzQGNvZGV0aGluay5jby51az4NCj4gLS0t
DQo+IMKgZHJpdmVycy9hY3BpL25maXQvY29yZS5jIHwgMjcgKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9u
cygtKQ0KPiANCg0KTW9kdWxvIHRoZSB0eXBvIERhdmUgcG9pbnRlZCBvdXQsDQoNClJldmlld2Vk
LWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg==
