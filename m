Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208326D35F2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDBHkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBHkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 03:40:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A2A26C;
        Sun,  2 Apr 2023 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680421252; x=1711957252;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fFQCwI1rizwhis8aIgVG0vtdLCJpIqQMiNV+vFRDbys=;
  b=Bi9cBroQfXsNKDqVLR/MLpd5ju1v9enXLv7Bh8nPnj5dTu1VEql/Y4mf
   WcNhdWS9TTSeo2L7aCTKN3cQDzoriS2JXVS14gHzkdoMTV4LkOriQlXUa
   U3Kvz6w7VUHio9NUNyE2M+qBK0v0TZgSx70Ys8B9IBGyHogjSDF5PuRz5
   Zj2mogyrF1zb7mvk7AX0udZGF+tp0eKHv5i4Llu1UNUrRVWpxYNEJOQ83
   NGahdyzTwQRdFGvCzGAzBJPchU9iUlVklqP/pMR1UlbBTfuF+0HCmpruN
   qyOWqN1iQgLv585+HBLaq5kDrvhRYKO33dOQeqwHOtg6wnuHyt6rhNCtE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="427997634"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="427997634"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 00:40:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="718182502"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="718182502"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2023 00:40:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 2 Apr 2023 00:40:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 2 Apr 2023 00:40:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 2 Apr 2023 00:40:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNRKyJ3FkI9NaPEkCFbo9qMShxC1KBPex+a/tLmJ7yNH6pq8zaVLpNbAzRSOs5FxlhMRGmS+QBHkzY5BaGQSS1460ivuy43PUed70/0bqbEeojt5VALB9O54yi9O78qBd640/f2osgFhwMvTzSCxQ24HjZvh2rWJPiSQCIz+Qf5Ng5o5qGcJZIlBYJha69s4md3AgkRY0dYSRUKrC2xQDP6UdM/SMq0xUZtcMuxdOUt7fN0DyCz9gpecRS8heB8A/ahxft+WJoBkXjm/SC3mUL+Z/7HUZ+lgFMx2ag0MC55m92ftccFk3PVvMsiMpbRpODyLYgPgO5p/84ZT4X0mFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFQCwI1rizwhis8aIgVG0vtdLCJpIqQMiNV+vFRDbys=;
 b=fvbM+rbNb1S6LYpImfFNXBr09nRe6TRy6pLSAzQ8o8BZZm5pCYT/+ETVMoEOVHC3GHhLnJNi571hvNS5CkN/x7nwnVh1YOkARClE2X9dg0jtsQAzJ8bzuK3MmT7u52MCBC7Rq4w5RgI9eeXjrj47jX9hN4auI3w0ylsb2tohCeLvP0nIBjvHlvt3tJHuz3ZG54deBC3rYfk5A0iJgcSiGsxoy108QQb/SynVoKQ2bL0044MYakPov1NAhmgLciYu1QrhyXmpd107gOccYph1cqLOmy7wKHUpvy4zZEA/+76829rJwBO6fhObEOMHva7vdfUga2dt5WUoJkG0ZFiwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by CO6PR11MB5634.namprd11.prod.outlook.com (2603:10b6:5:35d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Sun, 2 Apr
 2023 07:40:49 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Sun, 2 Apr 2023
 07:40:49 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 03/15] powercap/intel_rapl: Support per Interface
 rapl_defaults
Thread-Topic: [PATCH 03/15] powercap/intel_rapl: Support per Interface
 rapl_defaults
Thread-Index: AQHZWB3j9auVX0QQ5E+5UU7vlp3T3q8TsSeAgAQLfYA=
Date:   Sun, 2 Apr 2023 07:40:48 +0000
Message-ID: <0d85d86ffa9d9aee8f5cc83851dc07ccf16a5baa.camel@intel.com>
References: <20230316153841.3666-1-rui.zhang@intel.com>
         <20230316153841.3666-4-rui.zhang@intel.com>
         <CAJZ5v0iFP1A+yZfjgx-yXfV2c0+o1t9DAYsj-3YzzaqNfP9LVw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iFP1A+yZfjgx-yXfV2c0+o1t9DAYsj-3YzzaqNfP9LVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|CO6PR11MB5634:EE_
x-ms-office365-filtering-correlation-id: 443fccdf-14f7-4a42-d365-08db334d93c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bg8GByAPTRpxFUms/G2Yh4eEaP8JwknBu3TI00q6NNCcf/Z5gvHojAWA5LgEelhcB+BwtL4SZjn6+faTtY/pjZW4p5hkrSCFzKByEk8zKBFJaPZtxxHAg0+uFE8wSuGb6JsHlYH/ZlYvp7+CvQMb8KivVHjGKeEX6MCcFGzMW/YdwnUl4a2YkwibA9ZThd+AGEjSt5OawLf4VcfZZ0EKv9rY+ZY7dGbMVUjEoc5jcK0lLfVsUVOj//YLfXV1t3K5GyC7Ghdsr0mz4Tjk5AuVclFP7esue2p19ShG6HDB0oOk3cvz5OXs+fO0Z5TtF7wtTjKIGSjLgb1Xb9UqH3j/yFvGiVumBsfAN063EtErzQNnpfTuVmI4yN9M/nEDwHE++9ed5H1Vnbfa1fhOrVfJbkQlbqwCLhFTVT75dHM7dhjmoTRTiQXlw0r1CmyA2Dq6LndXotfvUf5LpYXiXJxqxXgrvHiQxZwaAesd3xFOXlLf41Qe+BOj7FKnacz6dsCKl+bF8mJpXnt5PCqa99FCArTRWwk/p8UFivhhtn3jEvwRkJy3EatZ7tWI9gQZpNK4eiGg/kjPaoQrCUM8N1KPXLpgT/FG5MttHXX0jAFWUflwsn8TYrKJNS1jThtXpGaT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(41300700001)(91956017)(8676002)(6916009)(4326008)(66476007)(64756008)(76116006)(66946007)(66556008)(66446008)(478600001)(316002)(54906003)(8936002)(122000001)(82960400001)(5660300002)(38100700002)(53546011)(186003)(83380400001)(2616005)(71200400001)(107886003)(6486002)(26005)(6512007)(6506007)(86362001)(36756003)(2906002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFp6ZTlaOFZpMHB5eHFMcG5PSmc1RDRtTlVZNEFmZjFzSjVFWXNIYVAxc2pE?=
 =?utf-8?B?YVJuWWR1OUt3aml6aHFmZlQrT3lRMHg0czB5aCtDaGtpbmxGYkNpVkhPbnBL?=
 =?utf-8?B?cTVjaGtyMk1IS3lCMkpzc0VPUDRVMHZFai9IbnBsWDNkTVFqK2RBMThyMHhE?=
 =?utf-8?B?dkVhWFY4RUNzNlV4QkY4RSs4QXNBTzBFSkI5bnZ4cWdER1NaWHJIQWpic1hP?=
 =?utf-8?B?QUJ5WmhyQitPMEdkaGZTWFJwRlFQUGpjd3ZqSlB2NEJuK0IwVlhTTXZOSFFz?=
 =?utf-8?B?bVBzZmU2N2xxUWVZQVBEVUtrVE8vRGdDVWtpV2RGK0loN2Faa3Fva1VQR0Rq?=
 =?utf-8?B?cEVvK1RtY0ZKVW9RdmdYVlhqSE4vRGhmOVdvK3pJWGt0VWk0OStrTGtnZEls?=
 =?utf-8?B?T00vTG1pSEVoSVQzSHVpNmxhcEs0b01KRFI5elUrNDF1SUVPWW5CN1JqZWFG?=
 =?utf-8?B?aG1IV1JvdDRVUCtGaVdBdTloOGlCaGlhZjNBUHRIamRydXA3UGJDek5jWXNE?=
 =?utf-8?B?RFlhMVFBZS83YXA3RE9rc2EwNEtWdlRGZVlzblZ1ZythQy9TMjZvV2x5YVNJ?=
 =?utf-8?B?ZjNwOEdPZUdlcGtxVllTV3lMZjJ1bDZ5OGdVUDVaWmZQSkMxYXZTRGEyRGln?=
 =?utf-8?B?UUpDd0hpSCtPNmdTSC9pRlJTMDdXV1h1WFA4czdzSjlBSW5UcjJ5WG1wN0hB?=
 =?utf-8?B?U01wTjJEUG9PbDlvcm5wYko5byswbGQvRi9kY2FjT2ZzcG85ZmFuYlhIYUFZ?=
 =?utf-8?B?NWYzdXd6bEJKbTlMYThIdUhwMW4zanlhQ1BidllCLzFhMlhlRk9USDNMaGpS?=
 =?utf-8?B?UWpjcU5GWllYa2k3cWNtam9tdDc1NUQ3MDBVOGR2azFicmJEN3hjT245UUdJ?=
 =?utf-8?B?TFdxVVdVVWNvaUtQK3ZqZ1l2a0tJSUJWaHZrN1A5UTBhYmlLazVtWWVwWkkw?=
 =?utf-8?B?d0N6OVN4SE1rMlMwaFlXNHczclJINmhoMzJzbGN0WkI2MnFWb0s2RlIvSzRK?=
 =?utf-8?B?Q2FwYlJCUG5id2pnV0VqcDlva0JCemx5SFlQTllSbmxZdWdWL1ZQV3BZbG5x?=
 =?utf-8?B?b1gwVXdBeVZwa3pJbzE2VjQrN3pOa2NVbHdNS0pxQTFMSWRGUC9mWDhWTEVs?=
 =?utf-8?B?VWxVVG1KZGFXWlpNQmV5S1J1STFoSXVoRVlxZ0ErZWxyd1pKNHRwUkI2SWc1?=
 =?utf-8?B?Z3gvZEtxV0JZeGh6enMvWDNjdFRVQlpFZ3lOVXJTSDdiL3ZKQ2l0ZEFuNUpK?=
 =?utf-8?B?NnlYU250ZVFPZGxDRHBmeHd6SjJTZWt5MWEzZWNseDZUby9OSW5KTDNGblh5?=
 =?utf-8?B?dlN4bC9RQ0FMRjUwMjA3dkhZRjNTZnV5S2w1azFOK1VDdW1Bc0xpdjhQdnBl?=
 =?utf-8?B?czlweU1HOGo2YnBvMzR0QVFENHIvdTFxUG5JeGE2VG1JUitQaitlSXphRDI5?=
 =?utf-8?B?NlZHZU5FSDJNTm9wZW9QN3drdXpjYnluQ1lJSVRGZmpMYW5iZ0FLTFRZVUdQ?=
 =?utf-8?B?ejV5b0syYXV1d3JxSjZMQ3BnWFd1SGRJN2xFai9lcTFSaDZqaE96c3dCTzZx?=
 =?utf-8?B?R2FZYVBTQUkrQVJSaTdXbzVRVE1sMkNhVXBhU3ZWZlkxUk4zYVY2UE9MYi96?=
 =?utf-8?B?WjZmWFA3TXY4d1EzL3MvT1JUSEVuaHZ2bHVMQjZ5algvQlg2czBOZDdrWEM0?=
 =?utf-8?B?UHcxQ01BMDk3Vllua3QwSEJJdFpGcDRvZEVCeWx4aWMzVUEyMFA5bERSbzZw?=
 =?utf-8?B?REhyTDN6WUp3aFJJaDVtWjB3emkrK0JlNWpHQTJWU3RaK3RXSnZRaEpHMW81?=
 =?utf-8?B?UWlyd2JidllMSnJxeGxHS0U2c1Qya2N0L2JlcWdxdzNmMUVBdFBWZ0p6eTJS?=
 =?utf-8?B?bDRJdDAyNmNaWnNBeXZCTU1HVnYrbWtIb0xLYXh2Y1JmYTBKdnhaNEtIV0tn?=
 =?utf-8?B?TXppaWc3akwyNEFPM0E4OHFLQVZqT1loL0VweEFTNFYyalB3d0RjMnErRTNX?=
 =?utf-8?B?b1lKNHhLc0sxeUhzWEw5N05TVmJEdDlXQ21jNnBsYWpNYmpYM2x6RkJZbEVn?=
 =?utf-8?B?RFJsdVVUWDR4Vk5GY0YzcndqK1RPVjZUbStydFlPWVZ4NEFUUzFsRi9UaUhp?=
 =?utf-8?Q?ljC6WZTD8VczBbWYyI41wk2bt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C9BCAF4A6515946A01EA855C6B6628E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443fccdf-14f7-4a42-d365-08db334d93c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2023 07:40:48.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJKJLtQURnSVzVNf9ZkTfBm5gTNW1X121xwnFFJ12vNAAGkyEtNFnFbym6Fodc3ZXDC7CTFz7QN6QGPHmOTNYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5634
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTMwIGF0IDE5OjU0ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBNYXIgMTYsIDIwMjMgYXQgNDo0MeKAr1BNIFpoYW5nIFJ1aSA8cnVpLnpo
YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gcmFwbF9kZWZhdWx0cyBpcyBJbnRlcmZhY2Ug
c3BlY2lmaWMuDQo+ID4gDQo+ID4gQWx0aG91Z2ggY3VycmVudCBNU1IgYW5kIE1NSU8gSW50ZXJm
YWNlIHNoYXJlIHRoZSBzYW1lDQo+ID4gcmFwbF9kZWZhdWx0cywNCj4gPiBuZXcgSW50ZXJmYWNl
IGxpa2UgVFBNSSBuZWVkIGl0cyBvd24gcmFwbF9kZWZhdWx0cyBjYWxsYmFja3MuDQo+ID4gDQo+
ID4gU2F2ZSB0aGUgcmFwbF9kZWZhdWx0cyBpbmZvcm1hdGlvbiBpbiB0aGUgSW50ZXJmYWNlIHBy
aXZhdGUNCj4gPiBzdHJ1Y3R1cmUuDQo+ID4gDQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMgfCA0NiAr
KysrKysrKysrKysrKysrKysrKy0tDQo+ID4gLS0tLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvaW50
ZWxfcmFwbC5oICAgICAgICAgICB8ICAyICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzUgaW5z
ZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiA+IGIvZHJpdmVycy9wb3dlcmNhcC9p
bnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gaW5kZXggMmQyYzE1ZWVhOGViLi41NmU4YWYyYTFlNmYg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+
ID4gKysrIGIvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gQEAgLTEx
NSw2ICsxMTUsMTEgQEAgc3RydWN0IHJhcGxfZGVmYXVsdHMgew0KPiA+ICB9Ow0KPiA+ICBzdGF0
aWMgc3RydWN0IHJhcGxfZGVmYXVsdHMgKnJhcGxfZGVmYXVsdHM7DQo+ID4gDQo+ID4gK3N0YXRp
YyBzdHJ1Y3QgcmFwbF9kZWZhdWx0cyAqZ2V0X3JwZChzdHJ1Y3QgcmFwbF9wYWNrYWdlICpycCkN
Cj4gDQo+IEkgd291bGQgcmVwbGFjZSAicnBkIiB3aXRoICJkZWZhdWx0cyIgaGVyZSBhbmQgZXZl
cnl3aGVyZSBiZWxvdyBpbg0KPiB0aGlzIHBhdGNoLg0KDQpzdXJlLCB3aWxsIHVwZGF0ZSBpbiBu
ZXh0IHJlbGVhc2UuDQoNCnRoYW5rcywNCnJ1aQ0K
