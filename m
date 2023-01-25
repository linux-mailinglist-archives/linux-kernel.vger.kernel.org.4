Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C884B67B9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjAYSuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjAYSuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:50:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21F410EC;
        Wed, 25 Jan 2023 10:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674672618; x=1706208618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+2YUZLIfMrd5KbrW2OXaulIB0QC8P5hjQwdWnmcEoik=;
  b=LhUTWkMGiwzmjgoqTLEh8aNXjq5C24N+wM2zYU+Wr/VK4xGYMDBcoPB3
   YIjP5ix4s/IYTJT6lbiVERDOx1VH4ZK9FdHna2F0TB65LWEMVI4EBesCH
   CIdkbn1GAKgJYYicW21zwNy8L3r1u/E1F5EZQxz4K6dDDy4u2Lt8DJOnn
   RSEl6QPlNC9lE0h4FsfHt5eZDLP95f5D9g792etHwus7ocMPOEejEuRKO
   YXM+jKBKjPbnj06Pyv7O9/SPSnl2bBkuHfY+Tqdeatxkk7RvAqgmz7U4F
   fD60EVqwrPugQFt4peGwU2PMufaSQi23D0gaiM0UI8i1FxyOKuvk4Kwkf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306304442"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="306304442"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:50:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="751312025"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="751312025"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jan 2023 10:50:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 10:50:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 10:50:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 10:50:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQnf1JHDITVdDEi4t3T8Iv6zJAasA/FSQSYmId6moNczxNq7Jod9dQd1RuBoOMV0Q9+vzN7uPN7NfnxSMMRGNqzioz9jskbINThUotRJUsgIziTFdfx5Qrq6irF/uGdS/Fdy9T9/B9kSR/7epSmwabSvvxLexGg8AL4Lk/Qy54K1C//OWQhYE1eRGMp3ecW50wS2DhQHvTqPUx/yKlj0XMV5VpruaPLvFolt4lHqYJgwWrB6aJTO46qEKBwWeP6IJJBcrCoQjwuZ0ITdtaT17j0Bk8EXC9wNHP8UBpwWNrmMMHz/tSxtYHPXlYKg0z0C54OwfxtEE4wqmwrY0yHWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2YUZLIfMrd5KbrW2OXaulIB0QC8P5hjQwdWnmcEoik=;
 b=SusZ0MZL8GVmPmxYzPTsxX0FZBUCFTXuXstR9eoGU6PELVHT/OnC3Nxjg7LWoFgK7+FqlK9REIjil7aypNIq5KrTwmPfC97nQmW1s0OyFoEL9CXP5afeRqHOKvC/iy2qrNvFqh+OrCC/BIlnGAidrqS6AcOkhGyGNE98a9p3b6NhUdwNTdj4+SPBmW7JjpXOO2XRE2xh2UPSybwxJllTanDOYW/RTzxLVYiRc+ZwuDH6/piVNRHMd0ySTlI9uYtxHStDadQAQgEDa0bQAc9SdESgbjMRNlGKwgIoF05L8wsbMbsQz1PsFu8KW3/naueyOkDizoh3K64pwQ4l9Y68AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by CY8PR11MB6913.namprd11.prod.outlook.com (2603:10b6:930:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 18:50:10 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 18:50:10 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v2] cxl: fix spelling mistakes
Thread-Topic: [PATCH v2] cxl: fix spelling mistakes
Thread-Index: AQHZMGxEqo3vXwCZ106Of6YDZzihla6veteA
Date:   Wed, 25 Jan 2023 18:50:10 +0000
Message-ID: <e8d5e120f78a34b255173f34d0955cee385a6974.camel@intel.com>
References: <20230125032221.21277-1-rdunlap@infradead.org>
In-Reply-To: <20230125032221.21277-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|CY8PR11MB6913:EE_
x-ms-office365-filtering-correlation-id: 0810bf31-ecb5-4bbc-192f-08daff04fc42
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E2joDILMW/TRUiLDCf/2sHS8NAZeeA/u3zrMSf6A3rS3fujd2/HrTZgMPYdLx7Oihw3qrbznlG/aDLFQE3nE15QWpd2xgfn8xIiNh2nIoP+Kf3IurtgfSPqO5uKYusTV8SKi3mebLg7rl7E6tbecLcQiGDz3gVUXLRsatJ+AXDI1K39sz/UX5hUzdi2H3rFUMTBiGpQcU9UUWkLi+YRg5WIUlCGF6nIiKSLCXmj+PX7ZhO1RN+kCYmEEQjoD29yZbFkrho3UZ1UHeVqigshwBDzAqNpl9+cRXssJwO+TVMBFgav4LghoM89h6PHjAfdC7C/iYa7NvBG6eJ9ZosqD/NenVaIGb+eQCvB51UXEFRqXb5iahCJzhOkqS+/IBZWSCrQQYw1Z39Inp/F6K751+CNk7kv3Mgjs4lBxTPirhT20+reN3m2uC9+wYXrCsTSlo/L54S/6fLI6FKc69lFLmpUgPEmPCiuLXe1VImuQawcI4I1FqTW6ai+FfP/OaSW1xQxAdbyEBpSZ3V8yuCQdLUv97v+1Twcfi7GDdKwFkX+5JdgtfFQhOh9RxxxpCx/lqmnnja8DAaN7UnKl0inyiygkm7KIeWX4XPn8iT6hBr5RC4lcjJ8zaduAeXvjubAy9ZUdt5THfvkqZ+XggxyXtPJFHqNTec1wz6Hv6LQSJzCigldXHgKpkZ3zqhZeeoWf4Y3jdPql8ke1GckHf4SWXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(83380400001)(2616005)(41300700001)(8936002)(36756003)(2906002)(38070700005)(82960400001)(86362001)(122000001)(38100700002)(5660300002)(6486002)(6506007)(107886003)(316002)(110136005)(54906003)(478600001)(6512007)(26005)(186003)(8676002)(71200400001)(66476007)(66556008)(66946007)(64756008)(4326008)(66446008)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjhENWFON25FY1dYWEpjUzBsQWlBdU1jUndTWk5SWXVJWWphVkVGak1oVHAy?=
 =?utf-8?B?N1AvMktWcUN1VjVOazRkclZsQUxZRHcyRFhRTEFjSDFJai9jc2ZXZnNFSkNW?=
 =?utf-8?B?Nm81alQ5QXMxUW9hNzB3STV4YVZjZkc2SVQzVEIwZXB1ZjhOcUxYZW1xRENy?=
 =?utf-8?B?aHhnYVd0RG91N0hLSnc3NUlPRldrcml1aHFTYThycVV1Q09udEJRN0NGK1BE?=
 =?utf-8?B?MEtFNXY0UENkYXFueFNGT01tdWdLTzdqcEU3NzdUcjB1N1M2UWFodjNKWDJ4?=
 =?utf-8?B?TzE5T2xLUG1UaUhkNGNlYTQ4ekpWR2ZMQlhKOUZOd1BMRkxRZkVRSXB5UnRO?=
 =?utf-8?B?TzB0TTl1cC82YkxOWmxBZzlZTlF2c0MxN1F2UzdXa1ZGeGZxdEJQOWFzQlJ4?=
 =?utf-8?B?NVRLdzc0RE9waGhEdFk3MjhFc1hnUzJIWHBBa3JXbFJjK1BKTk1VQkZBYncv?=
 =?utf-8?B?S2xYRWd4Y1paQkJqdEorWTZ0VTZkSGNaUnE5Nngvck53MzVLc2hXMXZBcnUy?=
 =?utf-8?B?RjhHUkpyZk1JUnBJVnAvTTlmeVJtTnpFL016ZlBZbURtaDY3YnNTQllWRGFn?=
 =?utf-8?B?aHBNOXh0VTM5bnRReXE1MVJLM3FzVmR2a21pTUExN3VOTEQ2cVIwWEd4R3o2?=
 =?utf-8?B?Z0pZQjdFNk5DOUNDeXh0WktxUGM1UXpJNWZCZ0dYSFU5MDlTZUxteTh4cUMv?=
 =?utf-8?B?aHlhRVkxMFVQcnoySTRNY3lmTlJ1b2wyWXZGak1lcUsrbG1oMkZsZTRPWmhF?=
 =?utf-8?B?V291KzRLM3c2bnNIUnRBMXM1WXB1WE5oTzVlajZ1TWNzQWRPYmZhTjRUZUZ2?=
 =?utf-8?B?SjZZRGQ1dU9SWTV2all3T2Z6YmxEdFBNM3JhQ0tGOHhIblBybWZ4YkNwaURY?=
 =?utf-8?B?SDJrRDNxL3FRN0VqUE5NZUVJbEYwSkV6RXJSMXFNNGY1L2txVHNPaHV4MXps?=
 =?utf-8?B?bDRsRGdkdDg1S2hZTENoOElHSGVTeFFPQmRZbjhmL2pZUnFwYlBPV3l6RTdr?=
 =?utf-8?B?Z2xocWJuV1FQOGp1RjY0bTAxWlo0b1FIL05ZbnN2WW84SzJyOHlLVENGUmE5?=
 =?utf-8?B?RGNhVldKRWhtbkNBQTNkcXFGUVZRUXZKaUIrZ2F1OHdvbTRVbU5WaCtrc1dW?=
 =?utf-8?B?MTN3cFE1cG5TVFJUeXFOZUtYTHBTcUE3UGZ3OTI4eUFLVkQwQ2hxMzNQejhB?=
 =?utf-8?B?N1pDL0RiZjgydm5vZk05K3U2RmNqdnVjWXROejdHbjkwV2tuUmRNNHp1aGxT?=
 =?utf-8?B?MC8zMVN3QVBkemdiZEN4eFpWdmVlem85MFVEMzNIYTVUYkl4YmE4WFNyYnJV?=
 =?utf-8?B?Y2o0TjhlQStBaC9aNDhOZmZzZTZPS1VMOG4zZUNmN0dDdlRXemM2YkdpU2ha?=
 =?utf-8?B?RFJEc1Qzbko2U0VSTmUrWlJkUmxjK0c2SFR1eE9YbzdTS3U3ck9EUkpjUVRT?=
 =?utf-8?B?VFN3ZWJpVkpzSmRWYUk4Z1pIeFhvNyt1NkVzNThYNE0xTEJlbHBGaGdYNUoy?=
 =?utf-8?B?UTlXSllYcDcxaEU4d2JLZFBDU1hxYS9pRUJGN0xkUHhvK2pFaWs2c05jQWVO?=
 =?utf-8?B?R2RIaTFhbHRtd3B3ejEyNVlPVEFNdERhUXg0NFl2cmN1VEFPaVBJVnNKUjJs?=
 =?utf-8?B?YmNWS3B1d0FPNWJvd2x6ZXI2Q2Q2TEI1K2JkcDF4dHlEcXE1bTY5WjFmd3hs?=
 =?utf-8?B?c3VaWndhMUo3QmJqdEhhbXgvaVhpU3o0Qm92dVZqb1pzbHBvVlpWcUxRVGdO?=
 =?utf-8?B?TGVoU29DdmI1MzNwcE9qRnBpOUdpZnYvMVhJYzRRUVNjNmZ5ZVQwdXZSOWpx?=
 =?utf-8?B?a0VqRnJCcTdEUUdoY2ZUQStpejdqYWdLU015djdpOVpvRG91MCtCQzdmRUY1?=
 =?utf-8?B?aUVWUUJhTWVGVDAvajRtMzg2OEg0SEV0MTc4K1QyakJWSGVOM0Z6aXhJQWYw?=
 =?utf-8?B?dG03UTB3ZWovTVVOYmZ0cWVIRXpGem1jQ3hkbkFMVHNVSWluT3ZJWkJDc2tj?=
 =?utf-8?B?cS90SHVqdE4vd1VWUUNUblkzTmpTMXltNDFRalZlOC83S0FWTW1OZkVOMFdw?=
 =?utf-8?B?d0k0ekt5cWdGY2pLRHg0WXdRTWs0UFQzckV4a0NCbzBkTG1CTUxSdmQrQTIv?=
 =?utf-8?B?aHJieHozOEZRTURxTmxFRFl2eTFucTRXeGFweTFmMktiZ0pDVDh6dGNldGJM?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3927960E42E054687A4B875AB2A8C8A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0810bf31-ecb5-4bbc-192f-08daff04fc42
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 18:50:10.2863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AvwF92Cv3kV3zdvC3VkVDVAtPsXMTuEfhIHF6I5XV7rJvTIHcq+1papRK+3MK87ITRr4K4WDMqsbniizUzqiVc6+Ers03q4vEFI7wflYCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6913
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTI0IGF0IDE5OjIyIC0wODAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IENvcnJlY3Qgc3BlbGxpbmcgbWlzdGFrZXMgKHJlcG9ydGVkIGJ5IGNvZGVzcGVsbCkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4g
Q2M6IEFsaXNvbiBTY2hvZmllbGQgPGFsaXNvbi5zY2hvZmllbGRAaW50ZWwuY29tPg0KPiBDYzog
VmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+IENjOiBJcmEgV2Vpbnkg
PGlyYS53ZWlueUBpbnRlbC5jb20+DQo+IENjOiBCZW4gV2lkYXdza3kgPGJ3aWRhd3NrQGtlcm5l
bC5vcmc+DQo+IENjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4g
Q2M6IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+IHYyOiBhZGQgY29ycmVjdGlv
bnMgZm9yIG90aGVyIHNvdXJjZS1jb2RlIHNwZWxsaW5nIGVycm9ycyAoQWxpc29uKQ0KPiANCj4g
wqBkcml2ZXJzL2N4bC9LY29uZmlnwqDCoMKgwqDCoMKgIHzCoMKgwqAgMiArLQ0KPiDCoGRyaXZl
cnMvY3hsL2FjcGkuY8KgwqDCoMKgwqDCoMKgIHzCoMKgwqAgMiArLQ0KPiDCoGRyaXZlcnMvY3hs
L2NvcmUvcG9ydC5jwqDCoCB8wqDCoMKgIDIgKy0NCj4gwqBkcml2ZXJzL2N4bC9jb3JlL3JlZ2lv
bi5jIHzCoMKgwqAgMiArLQ0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KDQpMb29rcyBnb29kLA0KUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8
dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KDQo+IA0KPiBkaWZmIC0tIGEvZHJpdmVycy9jeGwv
S2NvbmZpZyBiL2RyaXZlcnMvY3hsL0tjb25maWcNCj4gLS0tIGEvZHJpdmVycy9jeGwvS2NvbmZp
Zw0KPiArKysgYi9kcml2ZXJzL2N4bC9LY29uZmlnDQo+IEBAIC0xMTYsNyArMTE2LDcgQEAgY29u
ZmlnIENYTF9SRUdJT05fSU5WQUxJREFUSU9OX1RFU1QNCj4gwqDCoMKgwqDCoMKgwqDCoGRlcGVu
ZHMgb24gQ1hMX1JFR0lPTg0KPiDCoMKgwqDCoMKgwqDCoMKgaGVscA0KPiDCoMKgwqDCoMKgwqDC
oMKgwqAgQ1hMIFJlZ2lvbiBtYW5hZ2VtZW50IGFuZCBzZWN1cml0eSBvcGVyYXRpb25zIHBvdGVu
dGlhbGx5IGludmFsaWRhdGUNCj4gLcKgwqDCoMKgwqDCoMKgwqAgdGhlIGNvbnRlbnQgb2YgQ1BV
IGNhY2hlcyB3aXRob3V0IG5vdGlmaXlpbmcgdGhvc2UgY2FjaGVzIHRvDQo+ICvCoMKgwqDCoMKg
wqDCoMKgIHRoZSBjb250ZW50IG9mIENQVSBjYWNoZXMgd2l0aG91dCBub3RpZnlpbmcgdGhvc2Ug
Y2FjaGVzIHRvDQo+IMKgwqDCoMKgwqDCoMKgwqDCoCBpbnZhbGlkYXRlIHRoZSBhZmZlY3RlZCBj
YWNoZWxpbmVzLiBUaGUgQ1hMIFJlZ2lvbiBkcml2ZXIgYXR0ZW1wdHMNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgIHRvIGludmFsaWRhdGUgY2FjaGVzIHdoZW4gdGhvc2UgZXZlbnRzIG9jY3VyLsKgIElm
IHRoYXQgaW52YWxpZGF0aW9uDQo+IMKgwqDCoMKgwqDCoMKgwqDCoCBmYWlscyB0aGUgcmVnaW9u
IHdpbGwgZmFpbCB0byBlbmFibGUuwqAgUmVhc29ucyBmb3IgY2FjaGUNCj4gZGlmZiAtLSBhL2Ry
aXZlcnMvY3hsL2FjcGkuYyBiL2RyaXZlcnMvY3hsL2FjcGkuYw0KPiAtLS0gYS9kcml2ZXJzL2N4
bC9hY3BpLmMNCj4gKysrIGIvZHJpdmVycy9jeGwvYWNwaS5jDQo+IEBAIC0xOSw3ICsxOSw3IEBA
IHN0cnVjdCBjeGxfY3hpbXNfZGF0YSB7DQo+IMKgDQo+IMKgLyoNCj4gwqAgKiBGaW5kIGEgdGFy
Z2V0cyBlbnRyeSAobikgaW4gdGhlIGhvc3QgYnJpZGdlIGludGVybGVhdmUgbGlzdC4NCj4gLSAq
IENYTCBTcGVjZmljYXRpb24gMy4wIFRhYmxlIDktMjINCj4gKyAqIENYTCBTcGVjaWZpY2F0aW9u
IDMuMCBUYWJsZSA5LTIyDQo+IMKgICovDQo+IMKgc3RhdGljIGludCBjeGxfeG9yX2NhbGNfbih1
NjQgaHBhLCBzdHJ1Y3QgY3hsX2N4aW1zX2RhdGEgKmN4aW1zZCwgaW50IGl3LA0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgaWcpDQo+IGRp
ZmYgLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3BvcnQuYyBiL2RyaXZlcnMvY3hsL2NvcmUvcG9ydC5j
DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvcG9ydC5jDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2Nv
cmUvcG9ydC5jDQo+IEBAIC0xMTM3LDcgKzExMzcsNyBAQCBzdGF0aWMgc3RydWN0IGN4bF9wb3J0
ICpmaW5kX2N4bF9wb3J0X2F0DQo+IMKgfQ0KPiDCoA0KPiDCoC8qDQo+IC0gKiBBbGwgdXNlcnMg
b2YgZ3JhbmRwYXJlbnQoKSBhcmUgdXNpbmcgaXQgdG8gd2FsayBQQ0llLWxpa2Ugc3dpY2ggcG9y
dA0KPiArICogQWxsIHVzZXJzIG9mIGdyYW5kcGFyZW50KCkgYXJlIHVzaW5nIGl0IHRvIHdhbGsg
UENJZS1saWtlIHN3aXRjaCBwb3J0DQo+IMKgICogaGllcmFyY2h5LiBBIFBDSWUgc3dpdGNoIGlz
IGNvbXByaXNlZCBvZiBhIGJyaWRnZSBkZXZpY2UgcmVwcmVzZW50aW5nIHRoZQ0KPiDCoCAqIHVw
c3RyZWFtIHN3aXRjaCBwb3J0IGFuZCBOIGJyaWRnZXMgcmVwcmVzZW50aW5nIGRvd25zdHJlYW0g
c3dpdGNoIHBvcnRzLiBXaGVuDQo+IMKgICogYnJpZGdlcyBzdGFjayB0aGUgZ3JhbmQtcGFyZW50
IG9mIGEgZG93bnN0cmVhbSBzd2l0Y2ggcG9ydCBpcyBhbm90aGVyDQo+IGRpZmYgLS0gYS9kcml2
ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYw0KPiAtLS0g
YS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVn
aW9uLmMNCj4gQEAgLTM5OSw3ICszOTksNyBAQCBzdGF0aWMgc3NpemVfdCBpbnRlcmxlYXZlX2dy
YW51bGFyaXR5X3N0DQo+IMKgwqDCoMKgwqDCoMKgwqAgKiBXaGVuIHRoZSBob3N0LWJyaWRnZSBp
cyBpbnRlcmxlYXZlZCwgZGlzYWxsb3cgcmVnaW9uIGdyYW51bGFyaXR5ICE9DQo+IMKgwqDCoMKg
wqDCoMKgwqAgKiByb290IGdyYW51bGFyaXR5LiBSZWdpb25zIHdpdGggYSBncmFudWxhcml0eSBs
ZXNzIHRoYW4gdGhlIHJvb3QNCj4gwqDCoMKgwqDCoMKgwqDCoCAqIGludGVybGVhdmUgcmVzdWx0
IGluIG5lZWRpbmcgbXVsdGlwbGUgZW5kcG9pbnRzIHRvIHN1cHBvcnQgYSBzaW5nbGUNCj4gLcKg
wqDCoMKgwqDCoMKgICogc2xvdCBpbiB0aGUgaW50ZXJsZWF2ZSAocG9zc2libGUgdG8gc3Vwb3J0
IGluIHRoZSBmdXR1cmUpLiBSZWdpb25zDQo+ICvCoMKgwqDCoMKgwqDCoCAqIHNsb3QgaW4gdGhl
IGludGVybGVhdmUgKHBvc3NpYmxlIHRvIHN1cHBvcnQgaW4gdGhlIGZ1dHVyZSkuIFJlZ2lvbnMN
Cj4gwqDCoMKgwqDCoMKgwqDCoCAqIHdpdGggYSBncmFudWxhcml0eSBncmVhdGVyIHRoYW4gdGhl
IHJvb3QgaW50ZXJsZWF2ZSByZXN1bHQgaW4gaW52YWxpZA0KPiDCoMKgwqDCoMKgwqDCoMKgICog
RFBBIHRyYW5zbGF0aW9ucyAoaW52YWxpZCB0byBzdXBwb3J0KS4NCj4gwqDCoMKgwqDCoMKgwqDC
oCAqLw0KDQo=
