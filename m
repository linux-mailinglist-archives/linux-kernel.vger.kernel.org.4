Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF167911A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjAXGiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjAXGiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:38:21 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1AA2733;
        Mon, 23 Jan 2023 22:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674542300; x=1706078300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CpovBuAvqAOiPfskzWyYAkn844TfptmJQOX6BbLkaOQ=;
  b=aC+ynXW4ZYyGwXN1rhWDSrihMG/84kjLORjZYaxycgYBd2vYxTvsNq9s
   8EVEQu7aN34WOLo/i47V375Zdh91IlxrNIyL17IVM/rcDJHZkd5fs5iIo
   iGSuKPGZ/QVecljztmW0S+YDjL2Yvx81RiByiC6MW5Qhsi5gbDeRlJxiZ
   ghPIN8KWHUbBx1uGRax0wTfwK8SClARzliZKt9WscjLmlWAYa7IB462++
   6ki9audrBRxXdvMHWsIURY7oLODJyonuqNXmHHMZd3fBSqkuVsZTnjq+K
   I4+P6VBNZZ14BdcYr8PiRxmLkrEbPYwG2d52zqUFmZ39HmUhcEYsOOq8C
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="314139354"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="314139354"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 22:38:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="907379616"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="907379616"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jan 2023 22:38:19 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 22:38:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 22:38:19 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 22:38:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+yyjiTOg4IY6I1DCa1Pdtc2dUlflnGEEMUN6oP25+/EhUErKcFuiwgk0074p9rn05ucRHX683+5H0jknkp3n8+ZJqIxVRdkZIjf9QjPDeeqatNPjAyubIQLoCxjqM8UjsrBomjl+YjUSdCUXs5QY8BRJodtZ/Ru7OrwOuJPZkjxqY95p7YCEAMlQjN5avqQgGDiHFwoTM1uo+Le9RVoisblyCQpJ30HuvABsne5PRKpMmGDywpqFmwQU2VpkJdE0n+L/FGFASfh+leOsQZ5q7V5iTDHhHf7QfcjUGUNWKusH+WZK9X4X63nJBD/CMWZkOTvyIc8gAICxu6Wd1wwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpovBuAvqAOiPfskzWyYAkn844TfptmJQOX6BbLkaOQ=;
 b=dnZvunmWxKAXxe7CbpkFinC2cqGkCzKYZktEgs/ATVIGo/GnR5b5WAKWeKG1kkZq66FYi+Xwl020p6rhPjbl0n/MXFUkZyjladquyJO6pmm4F0t6GJHkq2tm3zyEhQb7ChOX52aLUlC2pOsvV1zudbGFWDyNrbNabrwpqDOPlhf7T0B/KlCVORTMSS5sZUD1YRsNxik+Fv+TsoXeAN/suPtGMfS+fe0x92bVYEGz4PH8TYUQEr9TdrYA/tPV49Di0RS1/GNtX9YgP/KL3JYq5gtkdFQCfagI6Q8J4uw4aylr95yZ+1JqFuJg2DExGHgTS45ACt28Znd25jb6rZ8aDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Tue, 24 Jan
 2023 06:38:17 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 06:38:17 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Subject: Re: [PATCH v2 2/3] thermal/core: Remove unneeded ida_destroy()
Thread-Topic: [PATCH v2 2/3] thermal/core: Remove unneeded ida_destroy()
Thread-Index: AQHZLz9eITU0S+3pzkGtQV4J/tOuIK6tHmIA
Date:   Tue, 24 Jan 2023 06:38:17 +0000
Message-ID: <d1eaa5606177087682d822c7d7b35c1079ea2e9a.camel@intel.com>
References: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
         <20230123152756.4031574-3-daniel.lezcano@linaro.org>
In-Reply-To: <20230123152756.4031574-3-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB7497:EE_
x-ms-office365-filtering-correlation-id: 659f3f05-f9de-46d1-1f60-08dafdd5938a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kaHONtgdwsvmp1h1m6bazP+5zpcXwfU2AXxU0k/LM9xUvOW/99uYMceFO83bbHXytNTziC/0r0DfPHW61RvKiYPv1gE+kdLmnNBSOE3NOroNsp2Ejroy6aKoeDAyUCMllSfMPc4aldUYs9GFh6oVp4PD629yfZcZmQEi21dC3IbNnn5bkNiJCVjk+ck6xuubOYMrBb0I3WKoaI/S6j99nZzwPUttddtfMqmKszMv6zlppQiqDphJ6F10YkY2oEQKAZGOprywXyHeNSyKXP9vMTzr/PRxy0llvijxO8ZwNZlJZOYg/l78Dg/c9DlQMtzd+6BkqgJ+qHr4u3z0VUhBEyEoVmWBf430GLRns3+o4ECQXz52OX1DNdeUIXhC4P0NVJW6dSeoPOQhtZXc4aPqhZ1Y22ZJynhUSa0BlUKu9MYKUAmywg1dMgMw+uQMXTBmbv5A6dhb+5wn483fWdNxcn5rFHMDCSpkehHhte/oKOHiOIMV2YGqZdf8q0IL+eRv038vDDULhHpNZDR0+AyjsLSujGrY6FNw4XfDY55oJid1sbKWyG1E78z4Le9oWvTJYAiFb2npgFkwpO/QP4Cgqf38jHftBg7RMD0UMHe+Fd1fsnK0jG+G9dzZ+MvrPVrGCJ73sAGCKlEsmXQ8EF5Y5vcj+p1V0yYbVVMzqHIlgFARXZMRniPB06LMj1murCHxksuMmEX1vuV0AohPqyYTNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(6512007)(26005)(186003)(86362001)(6506007)(478600001)(6486002)(71200400001)(36756003)(82960400001)(83380400001)(2906002)(110136005)(316002)(54906003)(38070700005)(2616005)(66946007)(38100700002)(8676002)(4326008)(66476007)(66446008)(76116006)(64756008)(66556008)(41300700001)(122000001)(91956017)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEtyc1dlZDR5NCszdnhyQ0hITzA0dlBvZklHS2lqeFM1NzYycDBhTnpIMURz?=
 =?utf-8?B?M2hzSjR3WlA5Y1hSakZjZUxkZVdaaDRQb2cxWjRuOTUyRi9wR1JKVFZyTG1L?=
 =?utf-8?B?WmxkMmlmb1orUWdrL0hqMUZmWEcxNWoxaUFXVjZqSE1Ec28zWUhqSS9WRDFJ?=
 =?utf-8?B?OUs5Mm1yZExjTzJ6Z3JCbkdRTUEwN3NyVDJKVjdCQWdyY0N3WlRaSzZ2ZFM3?=
 =?utf-8?B?TEFwUllzVjRabWptKytleStuRnBQQlEvaVVuVkZXdFh2NUpnSDZYd1NKZ0Nv?=
 =?utf-8?B?SVFicEFoT0hOOU1iNHlDUmk2dkpmcnNjVzdrOW9NNWpzNkJTV1B3VXJuenBJ?=
 =?utf-8?B?WFN4RlllTmhLNkg5aWQwbXVJQ0loTTFFdS9BdkN4ejQvOGVxV0RZNGU3c2Q0?=
 =?utf-8?B?WDVSRjdjZVM3Q3o3bHRmMmRpNS9MS2RZeVdmOVRDWFkxQXpsRWZuUXVxTjh1?=
 =?utf-8?B?dWxDYWM1VUNtdHA3bFJBcWxWK3k0ang2c1UvQW55RVhFS1dmODhaOU5KTkZL?=
 =?utf-8?B?K1crRHdPUkVMMXN2cG02YVVSaTdOZHpiTGVaM0k3cVYyNDk3VGtNUSsvb20x?=
 =?utf-8?B?R1NJVElQOVhaUjRtTE0xTlFMTjJMVisrOGg3cU1EM1dnODVqdUZwUVFSeE93?=
 =?utf-8?B?djVLSDIyL2UzbCtGNTBBT1A1czIvQlJZL1NoQ1dqUWlReWxSWDB6K04veS92?=
 =?utf-8?B?VVBrMWYyUTRmczJpQ2g3MUhmVXZGZk9MNkNYZWp0b00ramI3NjhGWGxJVjIw?=
 =?utf-8?B?aitPQXRuYUp6UDVkaWpUMWNDYlNjSzN5dmJ4c0xqS051MFZ1OWtML2tGWXFz?=
 =?utf-8?B?SEhqVEVVeno2bTRnRFF6WThHeXZhM0Fya1VkOXFZQnExUmJKNEdoQnd6dU9h?=
 =?utf-8?B?ay9BWlZ5QnN4eG9jcGZUa3FUd2VaaW5ianlhaWVaQytpR2MweFlwT2xoR2No?=
 =?utf-8?B?MDU5ZWFSNWRkcmhDd1hJNTJuTUtMSmZlbEVqNXlBOWdEeGRHeDJia0R5RE1v?=
 =?utf-8?B?bEkxZ3B4SkxYNTBmQitaRVFMOElCTHQyOUlIN3BPWUVDUlk2Tno0ZGxObzYx?=
 =?utf-8?B?Q3N5MjEyNE1vTzREZ0RyNE9SL084aDdXaWtNcnVURWpQU2dwWGYrRmlEbE11?=
 =?utf-8?B?Rk9Xb1lINGJESGJvSnNCK2JxTHRjdzhUWkN5Ym96S29INWhUdklsdGhJd3Zw?=
 =?utf-8?B?TEZZU0x1YzQ1T2FjTTVTKzVVREZGKzh4dnN5ZG54UzJKNlBnL3lkREFKdTl5?=
 =?utf-8?B?SWVPQnVuTlJEOFpZUUQwN05tZXl0aVJOS0djTS9NMTEwR0tYdTBhemlsb015?=
 =?utf-8?B?TW9mT0pLc1Z1Rzl6OEpPazBtZytyeGhUZ3ZWNlJLUlBkQXNMaUVzNzNmY1Rq?=
 =?utf-8?B?VHE1bmxCU1VWRG5WM0tPa2VPa0pkaVZjTEFQeEM3Sk9SbDVyZDE4K2RkbDlW?=
 =?utf-8?B?clJwbG1jQjdXZXpGT2NmdEoxc1ZoZnpJOXBlTG9oc3QvaU5zUGlRS3NJOWRB?=
 =?utf-8?B?OC8yTm1XVlZNa09oK3pwSTJkL3ZqWEZjaXk5SThoUEUwTlUvL2dwdm5seXBL?=
 =?utf-8?B?ZXF1TUNFcG96STZGYmVVekJqVzJCRkJmRGZ4S2E0bEJLMXlGTUkzT21RVUgz?=
 =?utf-8?B?L1JlTytreTErUGFNSE1uVzVXQ203RUs5Y2hLODBEK0dQbzk0ckJQNFV6a2pD?=
 =?utf-8?B?bExqdVJWS04xNDRySzVpMWs4YXFTY2lvY21QL3hyb1pDSXdyemZpT1VKUDlV?=
 =?utf-8?B?S3U5eHJhMjBFVjRLbGhkcVJEVXo1WFBvQjkwU1dGQWFrMkQySEk3aUpRZG9O?=
 =?utf-8?B?NXZPc2xDa0psTDEvUWtqWC8vK3NRVkdhNytNVTh0TWdIZXlxUjhPZGR6emRv?=
 =?utf-8?B?ZmhERW5MT2xoc1VwMEJtc1JQSG1KRlBSUXlmd1Q2YVZIcjZoa3IvaEtwUG5t?=
 =?utf-8?B?djhHN1NMSzRQSlJiekN6K1VodWNNK0YyODNPczN6U0NlakRDNEp2SkVOYkI3?=
 =?utf-8?B?bXMxZ25uRUMxc0djTU5aNE1xYS9rNndPY25HbGF5T1dVa3FNS05RTmlpNWZE?=
 =?utf-8?B?TThtbHJrOEdGYTdoaGFFYnh6cTlQY29BbU1id3hicW9zODB3aUNUVkRQZVBv?=
 =?utf-8?B?NE1hZWJPekkyUmg4bThjSklvWnZCWm5RNFFVTnJQTmNjYjd1empXVDl1c1Qv?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87AFF21B2458AB4EA871B372C37B08FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659f3f05-f9de-46d1-1f60-08dafdd5938a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 06:38:17.1197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2p3wshjg+ibrPN4++n6jybb32e2fKdJ8ThrLz2u5toMfKf1SumDJgmRVJeWj/cAiaU9bfzDjWG6bE18isewy4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTIzIGF0IDE2OjI3ICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gQXMgcGVyIGRvY3VtZW50YXRpb24gZm9yIHRoZSBpZGFfZGVzdHJveSgpIGZ1bmN0aW9uOiAi
SWYgdGhlIElEQSBpcw0KPiBhbHJlYWR5IGVtcHR5LCB0aGVyZSBpcyBubyBuZWVkIHRvIGNhbGwg
dGhpcyBmdW5jdGlvbi4iDQo+IA0KPiBUaGUgdGhlcm1hbCBmcmFtZXdvcmsgaXMgaW4gdGhlIGlu
aXQgc2VxdWVuY2UsIHNvIHRoZSBpZGEgd2FzIG5vdCB5ZXQNCj4gdXNlZCBhbmQgY29uc2VxdWVu
dGx5IGl0IGlzIGVtcHR5IGluIGNhc2Ugb2YgZXJyb3IuDQo+IA0KPiBUaGVyZSBpcyBubyBuZWVk
IHRvIGNhbGwgaWRhX2Rlc3Ryb3koKSwgbGV0J3MgcmVtb3ZlIHRoZSBjYWxscy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0K
DQpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQp0aGFua3Ms
DQpydWkNCj4gLS0tDQo+ICBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfCAyIC0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9j
b3JlLmMNCj4gaW5kZXggZmRkYWZjZWU1ZTZmLi5mYWQwYzRhMDdkMTYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3RoZXJtYWwv
dGhlcm1hbF9jb3JlLmMNCj4gQEAgLTE2MjQsOCArMTYyNCw2IEBAIHN0YXRpYyBpbnQgX19pbml0
IHRoZXJtYWxfaW5pdCh2b2lkKQ0KPiAgdW5yZWdpc3Rlcl9uZXRsaW5rOg0KPiAgCXRoZXJtYWxf
bmV0bGlua19leGl0KCk7DQo+ICBlcnJvcjoNCj4gLQlpZGFfZGVzdHJveSgmdGhlcm1hbF90el9p
ZGEpOw0KPiAtCWlkYV9kZXN0cm95KCZ0aGVybWFsX2NkZXZfaWRhKTsNCj4gIAltdXRleF9kZXN0
cm95KCZ0aGVybWFsX2xpc3RfbG9jayk7DQo+ICAJbXV0ZXhfZGVzdHJveSgmdGhlcm1hbF9nb3Zl
cm5vcl9sb2NrKTsNCj4gIAlyZXR1cm4gcmVzdWx0Ow0K
