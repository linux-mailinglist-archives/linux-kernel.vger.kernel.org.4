Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E23273882F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjFUO62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjFUO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:58:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F36F2D5B;
        Wed, 21 Jun 2023 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687359176; x=1718895176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zLsX4KGAQkP7lLMyWFcIkWT2FZlAgS4X0v0U3Sbtt7o=;
  b=HaghXv7apeC14Mg5O4SbfnsarI/UW3K5mqu7nZaScSK/CrqG7NV3UUFP
   1B5C8WXHQdocLdSJb4FcHOV6o3TxSqaZqvgutUwwu4ysUeGwMbeo/3VB3
   k8mt45NjHrBb4F9z5IsFbPpqdzFkyyOiUxoOHZ6/ReEy7epBLgu2k3Yzl
   a2EYM8kaAUnl4rMXYKLfuWCY93rp4RT1XooJW5z+419TVtCJBnj803pX7
   N09QAWF6C9R6ZTYirIQGtNoU8/NshOYSaZWFGiVR/o8/S9Z4i2boo4iUi
   HrOrOsBMQpdLGNmQbasPYVkortSqOJGN6lul33B+H03zo/zuskUcujPIN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360209901"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360209901"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="784513990"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="784513990"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jun 2023 07:50:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 07:50:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 07:50:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 07:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjPOKANuVyY1/CfGvTs4Hljm0iosmjg2PiJMDzgWsAAoE2k00UjTb0b93RqwAHCoetoRLsqSk0dV67/EmkGwKzUnCf1oyx2dwUMoyyJop7rvEqSUW4GhZAPHky/2fsjg2i0XRIsvc6Rp2qwqfwxFIcRY+b63rIGW5uU+j0YRkp5tgHqRCO3/gotkw7HcB0m+8l3TnuHUZVrBC+waG0qAxcpJVRGxzfM98aAVVW/qyQCoMGgfmJ77pggWIKX8TFfdHYqeBsinYcyLGumgE331dk+vhEV1YTXut+1/aaXTemUAKC73mac+WIACyJErO5EQX7Us1AjdqmfzwdGRTUIK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLsX4KGAQkP7lLMyWFcIkWT2FZlAgS4X0v0U3Sbtt7o=;
 b=IdKASdu1/futDtk3IkS0IkPFk9mWdBsiozu1YpakHHUOYP+jzyUlQxd3RqIps46Fkab3Bz2ucp0jMitHmyYJZ3mbXn9lUWGtXPoduyI5QnknGluhPaS0sBgqHb/IaZDHn3WeYDPct9ajxrJNd/o2uT32gkHchBcr+M05cHae+P3G1r6dOOYi/O8yuElkJ5QuW2IWGY/cUSZfNaa0gpd7bTINf9ngG2JRpfuCFR+ivV4OzTquQkeLxO68zThrTKVeeggNATTYbtSVQD7pw/R4TxdoxkYENcTNK6urxcGOy7Q2991aLoRkTFl44L9bTASucRYWX+1C516yZ3vQzb4q1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com (2603:10b6:a03:4ed::18)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:50:20 +0000
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf]) by SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:50:20 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] thermal: int340x: processor_thermal: Add interrupt
 configuration
Thread-Topic: [PATCH 2/7] thermal: int340x: processor_thermal: Add interrupt
 configuration
Thread-Index: AQHZo8s7cNXueUXqD0+M5s2SuJ5CA6+VV8yA
Date:   Wed, 21 Jun 2023 14:50:19 +0000
Message-ID: <2bdbba78c1e3162bd7e385ed48715fd949133253.camel@intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
         <20230620230150.3068704-3-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230620230150.3068704-3-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0086:EE_|PH7PR11MB7595:EE_
x-ms-office365-filtering-correlation-id: 12155516-afd6-4193-bb3e-08db7266d5aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vRPX5G4XJRJ+pfPaEdV6W0gD22hwj4Mh1vGMCchrlkVimeZB+n3FNBdpmu17MLaRLdiQwc6tsQPtUSeaHf2fo1mtxLM3i0PovFlYED1FAU2nXrQJfTczg57zbA7cnwpt/ZL5Wpcx3WqKw/wWvvcjsXNKy3zWOHr32HPuIVpZON/YiS2Hl6qA4b4w7XhsKNlY4RnpYMO74eIzsT5FlqkJtn43MTMlt1Lhyvz6ACdHOuOr7rWXG0Cg7E3dgvVRgcbC/bR+7EBL8etRHPshzrZkYKtwdWdrqR67XzukwvY+jJWuuE07jMlliqDxZMKDLZGspxDYrkgEcfI3AWeAY8tJHnE6tzcJgcN9VZb3K0NBwBJIMpYouMsrH7R2W96LCT1uai1syJ2vCAOJjntE3v9X2n5Qi8BSm255fBII/0uekmgYXyvcfTfQoTKAwdAu6Gr3cA3odhNleWIKuLzf+IFKTK433Y+4jTCKBKuQ0vEwzqsTh4Mk12CwNCQANRGk+ThBw98Q4trW3RZiO6GK6yeDpvGH4i64vn116f5zUmX1HHH07VxMun/yOcyZbIO7boRE4zFP7PRNODApXRkMP75s5cvLrKP2ks2dasK+0UEWocW8aL5nhZZJkKxizC2brEiv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(6486002)(83380400001)(6506007)(6512007)(186003)(26005)(2616005)(36756003)(71200400001)(38100700002)(316002)(4326008)(76116006)(66946007)(66446008)(64756008)(66476007)(66556008)(2906002)(122000001)(91956017)(8676002)(8936002)(86362001)(82960400001)(5660300002)(38070700005)(41300700001)(54906003)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0lPbGtwdVVEWWYwNVRjQ0s4U2oyeGk2ald5Vms1MTA4dlFsckpFaW5HOHNn?=
 =?utf-8?B?TTVHTW9tTnhkblI3N0c0Z2pVMUJEZStneWlvR2NoZzNNMzdER2MvUCtodTNn?=
 =?utf-8?B?V2VkZUszQXBockZtM0Z1Q0VIUjg3NHpGaExxRFV1RnNQQmx0OTZvdlEwN3gr?=
 =?utf-8?B?Y0VEeGN5b2NjaGJaazNoYldIT2NodEJiSVY2S1dzUndzd1lsZjM1V2lESzNU?=
 =?utf-8?B?MG16cVlTNEhFb1FzQ2x5VU9pckVvOFkxV2syY0M1c25ta2Q5dHF0S2x3Qkdk?=
 =?utf-8?B?THBFRVJPZjhRaW1aK2Z6eXIwQ1pXN1Zlb1ZBM25Jc1VPZXhOcHFtRjJWRU5R?=
 =?utf-8?B?K1YyR1FpdjNmeCsvKytKOTY4Nmc5aXJ5WXpkeEloWVhPcnUrK3h1bjQ4eUZK?=
 =?utf-8?B?aWc2YWUxTlo2aVdrU05uZHJRWlc1OUJtUFc4RmJsT3o4YnFGWW1zNWtyVUJZ?=
 =?utf-8?B?Q3kxZjVLblRyREdlV3F5K2Y3aVRmM0czNmFpNHZNdFlLVWF0UndhYjVQUnRT?=
 =?utf-8?B?T0RlWGt1SmdJMktJa2wvenJ0ZTR6TzFURjJ5T3czU3V5UWpia1Z3bkxVNkN3?=
 =?utf-8?B?RWNod1JweVlidEYyRjZEUE1iT1FSNWpOeiswdVBxa0RwNTAzVUVKV3hEN2xk?=
 =?utf-8?B?VWRtQUt0V3ZyNzR1UVE4S056eWQzdU5vWEhLNFlXSTI2bU44SEp0ZFo1c2VR?=
 =?utf-8?B?NnRVL1NZN2JTQzZVTC9EN0hDNktoTjJ1bE9OdjI4RnVhTXc5Z1lsSmI0N3N6?=
 =?utf-8?B?aGltYUZ4dUxtNFB5S05RV1JNclRmSGhqOU5YaU5DcW8xK3R0RWM0dWw3SHJY?=
 =?utf-8?B?SVB5Zyt0UElYeWtpSlNVM2hodWU4Vk1HUE9ITjVFZXFLRnRrMjBQNGZuc3d0?=
 =?utf-8?B?RGJqMHBUbTk0VFFybEJNN2tpLzhLRVAycVFFNW9DMDh6Q1VHRGR0bTZoZ1RL?=
 =?utf-8?B?c2hiNkVNNTk5T1pJenVnOWVVWjdtdUVHRG1UdDlKSS9OQmVhTGltdE5WQ1hU?=
 =?utf-8?B?VEh6TkVXZmdzVzA1cVNTRm93ZDQyNkVKaVpuTE9HcUpXRGVxMCtTdjgyRi95?=
 =?utf-8?B?OHFVTFdXYzhzaEIxMDlhT1VHMFYvZWFDT2twZVJWQnRreWw4S3h6bThyM0k2?=
 =?utf-8?B?NkVEMEM3cGtrNzZEWk40UjBDZWdJKzNybVFzaU00RTU3N1VlU2N1UkMraXVz?=
 =?utf-8?B?MHFKa0FHdTcrVHZ1WEN6NGF4SVZXOE00R0JpeHJSNmpPSEZwVHU3RXpKTTBi?=
 =?utf-8?B?N0lSa0U5eWtHcmRBRGtnUWwwNTBUc200RGwvMUlxRnFQQjBNcWc3ejA1Sm1z?=
 =?utf-8?B?SHdNTU9rMER0YVArVUhGb2V5amo3Wm9mdmpnOGhRWkI5Yzk1NmtxVHoyR3NF?=
 =?utf-8?B?YnRsZFI2UUljQUtUUVhMYmhKOGM0S1JnSGhoRkxTWkhrOUhiekYvRkphY3ZN?=
 =?utf-8?B?UTV0bWQvVmVyUWxpSHhmVGFPRTJuTFhWVzNlVm5hUWhUbzRReDZPVHgzRTVF?=
 =?utf-8?B?QmlScXFuOWFvcFdPenRPSnB0TGdSTURIOWlkU3pYQTVyVnhINmxZdWU2L29y?=
 =?utf-8?B?ZHZjV2JoYStsSkRaQ2tWMldwT2VOeUZsMEtBTFB1ZFRJVkZsWHdNTzBFS2tk?=
 =?utf-8?B?ZkMza09XeU4xbVhCQkRxYnMraXVTMm1Ta1pwNDVkdnc5ZTNMRlhiRmZlRWI2?=
 =?utf-8?B?bmtPVTk0djY1UXk2azRSSlZnT042OWVjVXUwdEVzTjNDdnlhRFlKWDUvZHVG?=
 =?utf-8?B?S0dRelRYSWtDMXdRbXFVVzhhYUJHVXg4QlJiTmlFQ0tia0puUHRMSEQwV2NY?=
 =?utf-8?B?bmRJdDN3NjRVTTRETDRaZ0EvZk50NUZ1bW1NK0YyZDJuc3ByekNDVWRQOFV4?=
 =?utf-8?B?MGRGSTN5cnNvNTkrMzVPNTFGSldSNjhybXZ5YUVVRkJOWUJHMGVsVERxYlFa?=
 =?utf-8?B?ajRiVnprU0kyblExQWIxRHpCT09jZFpaT2ErYTA4dVZHcWNkT092K2ROOE9V?=
 =?utf-8?B?VkZwNUxGNThnVG1ZbS9sS25NUXpUMDFBRkFTRXk3akp1Q0loNTNvWStYZUIz?=
 =?utf-8?B?dmFYWG1yT1JRY2hlVnVYVS9NM3VKL0NxRFV5ZmtPbGdTQXFrMk5URitTYWp0?=
 =?utf-8?B?NktuWUlUZkU3WWxzZmN4UmJPNWg2cFdxOG11Q2JDQjhRRHdINFpzY25iZmdT?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA0C879577FAEF40B6C8A530B41ED8FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12155516-afd6-4193-bb3e-08db7266d5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 14:50:19.9951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIZ3t2skhQMOB38YDnaa6QMd2RaEEawapq+xYMKytaXNOGQio3BzPO+ivmNL1Xk+44irXQcoUR42wtcXhwYRIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
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

T24gVHVlLCAyMDIzLTA2LTIwIGF0IDE2OjAxIC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOgo+IFNvbWUgZmVhdHVyZXMgb24gdGhpcyBQQ0kgZGV2aWNlcyByZXF1aXJlIGludGVycnVw
dCBzdXBwb3J0LiBIZXJlCj4gaW50ZXJydXB0cyBhcmUgZW5hYmxlZC9kaXNhYmxlZCB2aWEgc2Vu
ZGluZyBtYWlsYm94IGNvbW1hbmRzLiBUaGUKPiBtYWlsYm94IGNvbW1hbmQgSUQgaXMgMHgxRSBm
b3IgcmVhZCBhbmQgMHgxRiBmb3Igd3JpdGUuCj4gCj4gVGhlIGludGVycnVwdCBjb25maWd1cmF0
aW9uIHdpbGwgcmVxdWlyZSBtdXRleCBwcm90ZWN0aW9uIGFzIGl0Cj4gaW52b2x2ZWQgcmVhZC1t
b2RpZnktd3JpdGUgb3BlcmF0aW9uLiBTaW5jZSBtdXRleCBhcmUgYWxyZWFkeSB1c2VkCj4gaW4g
dGhlIG1haWxib3ggcmVhZC93cml0ZSBmdW5jdGlvbnM6IHNlbmRfbWJveF93cml0ZV9jbWQoKSBh
bmQKPiBzZW5kX21ib3hfcmVhZF9jbWQoKSwgdGhlcmUgd2lsbCBiZSBkb3VibGUgbG9ja2luZy4g
QnV0LCB0aGlzIGNhbgo+IGJlIGF2b2lkZWQgYnkgbW92aW5nIG11dGV4ZXMgZnJvbSBtYWlsYm94
IHJlYWQvd3JpdGUgcHJvY2Vzc2luZwo+IGZ1bmN0aW9ucyB0byB0aGUgY2FsbGluZyAoZXhwb3J0
ZWQpIGZ1bmN0aW9ucy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhCj4g
PHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPgo+IC0tLQo+IMKgLi4uL3Byb2Nl
c3Nvcl90aGVybWFsX2RldmljZS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAy
ICsKPiDCoC4uLi9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfbWJveC5jwqAgfCA4
NSArKysrKysrKysrKysrKy0tLQo+IC0tCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDY4IGluc2VydGlv
bnMoKyksIDE5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQKPiBhL2RyaXZlcnMvdGhlcm1h
bC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfZGV2aWNlLmgKPiBiL2Ry
aXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfZGV2
aWNlLmgKPiBpbmRleCA3Y2RlY2EyZWRjMjEuLmRlZmM5MTljYjAyMCAxMDA2NDQKPiAtLS0KPiBh
L2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxf
ZGV2aWNlLmgKPiArKysKPiBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwv
cHJvY2Vzc29yX3RoZXJtYWxfZGV2aWNlLmgKPiBAQCAtOTEsNiArOTEsOCBAQCB2b2lkIHByb2Nf
dGhlcm1hbF93bHRfcmVxX3JlbW92ZShzdHJ1Y3QgcGNpX2Rldgo+ICpwZGV2KTsKPiDCoAo+IMKg
aW50IHByb2Nlc3Nvcl90aGVybWFsX3NlbmRfbWJveF9yZWFkX2NtZChzdHJ1Y3QgcGNpX2RldiAq
cGRldiwgdTE2Cj4gaWQsIHU2NCAqcmVzcCk7Cj4gwqBpbnQgcHJvY2Vzc29yX3RoZXJtYWxfc2Vu
ZF9tYm94X3dyaXRlX2NtZChzdHJ1Y3QgcGNpX2RldiAqcGRldiwgdTE2Cj4gaWQsIHUzMiBkYXRh
KTsKPiAraW50IHByb2Nlc3Nvcl90aGVybWFsX21ib3hfaW50ZXJydXB0X2NvbmZpZyhzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwKPiBib29sIGVuYWJsZSwgaW50IGVuYWJsZV9iaXQsCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgdGltZV93aW5kb3cpOwo+IMKgaW50IHByb2NfdGhlcm1h
bF9hZGQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcHJvY190aGVybWFsX2RldmljZQo+ICpw
cml2KTsKPiDCoHZvaWQgcHJvY190aGVybWFsX3JlbW92ZShzdHJ1Y3QgcHJvY190aGVybWFsX2Rl
dmljZSAqcHJvY19wcml2KTsKPiDCoGludCBwcm9jX3RoZXJtYWxfc3VzcGVuZChzdHJ1Y3QgZGV2
aWNlICpkZXYpOwo+IGRpZmYgLS1naXQKPiBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4
X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfbWJveC5jCj4gYi9kcml2ZXJzL3RoZXJtYWwvaW50
ZWwvaW50MzQweF90aGVybWFsL3Byb2Nlc3Nvcl90aGVybWFsX21ib3guYwo+IGluZGV4IGVjNzY2
YzU2MTViNy4uN2VmMGFmM2Y1YmVmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9pbnRl
bC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfbWJveC5jCj4gKysrIGIvZHJpdmVy
cy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9wcm9jZXNzb3JfdGhlcm1hbF9tYm94LmMK
PiBAQCAtNDUsMjMgKzQ1LDE2IEBAIHN0YXRpYyBpbnQgc2VuZF9tYm94X3dyaXRlX2NtZChzdHJ1
Y3QgcGNpX2Rldgo+ICpwZGV2LCB1MTYgaWQsIHUzMiBkYXRhKQo+IMKgwqDCoMKgwqDCoMKgwqBp
bnQgcmV0Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHByb2NfcHJpdiA9IHBjaV9nZXRfZHJ2ZGF0
YShwZGV2KTsKPiAtCj4gLcKgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmbWJveF9sb2NrKTsKPiAt
Cj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IHdhaXRfZm9yX21ib3hfcmVhZHkocHJvY19wcml2KTsK
PiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZ290byB1bmxvY2tfbWJveDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIHJldDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqB3cml0ZWwoZGF0YSwgKHByb2NfcHJpdi0+
bW1pb19iYXNlICsgTUJPWF9PRkZTRVRfREFUQSkpOwo+IMKgwqDCoMKgwqDCoMKgwqAvKiBXcml0
ZSBjb21tYW5kIHJlZ2lzdGVyICovCj4gwqDCoMKgwqDCoMKgwqDCoHJlZ19kYXRhID0gQklUX1VM
TChNQk9YX0JVU1lfQklUKSB8IGlkOwo+IMKgwqDCoMKgwqDCoMKgwqB3cml0ZWwocmVnX2RhdGEs
IChwcm9jX3ByaXYtPm1taW9fYmFzZSArCj4gTUJPWF9PRkZTRVRfSU5URVJGQUNFKSk7Cj4gwqAK
PiAtwqDCoMKgwqDCoMKgwqByZXQgPSB3YWl0X2Zvcl9tYm94X3JlYWR5KHByb2NfcHJpdik7Cj4g
LQo+IC11bmxvY2tfbWJveDoKPiAtwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJm1ib3hfbG9j
ayk7Cj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4g
d2FpdF9mb3JfbWJveF9yZWFkeShwcm9jX3ByaXYpOwo+IMKgfQo+IMKgCj4gwqBzdGF0aWMgaW50
IHNlbmRfbWJveF9yZWFkX2NtZChzdHJ1Y3QgcGNpX2RldiAqcGRldiwgdTE2IGlkLCB1NjQKPiAq
cmVzcCkKPiBAQCAtNzEsMTIgKzY0LDkgQEAgc3RhdGljIGludCBzZW5kX21ib3hfcmVhZF9jbWQo
c3RydWN0IHBjaV9kZXYKPiAqcGRldiwgdTE2IGlkLCB1NjQgKnJlc3ApCj4gwqDCoMKgwqDCoMKg
wqDCoGludCByZXQ7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcHJvY19wcml2ID0gcGNpX2dldF9k
cnZkYXRhKHBkZXYpOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZtYm94X2xvY2sp
Owo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gd2FpdF9mb3JfbWJveF9yZWFkeShwcm9jX3By
aXYpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBnb3RvIHVubG9ja19tYm94Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gcmV0Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoC8qIFdyaXRlIGNvbW1hbmQgcmVn
aXN0ZXIgKi8KPiDCoMKgwqDCoMKgwqDCoMKgcmVnX2RhdGEgPSBCSVRfVUxMKE1CT1hfQlVTWV9C
SVQpIHwgaWQ7Cj4gQEAgLTg0LDI4ICs3NCw4NSBAQCBzdGF0aWMgaW50IHNlbmRfbWJveF9yZWFk
X2NtZChzdHJ1Y3QgcGNpX2Rldgo+ICpwZGV2LCB1MTYgaWQsIHU2NCAqcmVzcCkKPiDCoAo+IMKg
wqDCoMKgwqDCoMKgwqByZXQgPSB3YWl0X2Zvcl9tYm94X3JlYWR5KHByb2NfcHJpdik7Cj4gwqDC
oMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdv
dG8gdW5sb2NrX21ib3g7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBy
ZXQ7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGlkID09IE1CT1hfQ01EX1dPUktMT0FEX1RZ
UEVfUkVBRCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCpyZXNwID0gcmVhZGwo
cHJvY19wcml2LT5tbWlvX2Jhc2UgKwo+IE1CT1hfT0ZGU0VUX0RBVEEpOwo+IMKgwqDCoMKgwqDC
oMKgwqBlbHNlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqcmVzcCA9IHJlYWRx
KHByb2NfcHJpdi0+bW1pb19iYXNlICsKPiBNQk9YX09GRlNFVF9EQVRBKTsKPiDCoAo+IC11bmxv
Y2tfbWJveDoKPiAtwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJm1ib3hfbG9jayk7Cj4gLcKg
wqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoH0K
PiDCoAo+IMKgaW50IHByb2Nlc3Nvcl90aGVybWFsX3NlbmRfbWJveF9yZWFkX2NtZChzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgdTE2Cj4gaWQsIHU2NCAqcmVzcCkKPiDCoHsKPiAtwqDCoMKgwqDCoMKg
wqByZXR1cm4gc2VuZF9tYm94X3JlYWRfY21kKHBkZXYsIGlkLCByZXNwKTsKPiArwqDCoMKgwqDC
oMKgwqBpbnQgcmV0Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZtYm94X2xvY2sp
Owo+ICvCoMKgwqDCoMKgwqDCoHJldCA9IHNlbmRfbWJveF9yZWFkX2NtZChwZGV2LCBpZCwgcmVz
cCk7Cj4gK8KgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZtYm94X2xvY2spOwo+ICsKPiArwqDC
oMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IMKgfQo+IMKgRVhQT1JUX1NZTUJPTF9OU19HUEwocHJv
Y2Vzc29yX3RoZXJtYWxfc2VuZF9tYm94X3JlYWRfY21kLAo+IElOVDM0MFhfVEhFUk1BTCk7Cj4g
wqAKPiDCoGludCBwcm9jZXNzb3JfdGhlcm1hbF9zZW5kX21ib3hfd3JpdGVfY21kKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2LCB1MTYKPiBpZCwgdTMyIGRhdGEpCj4gwqB7Cj4gLcKgwqDCoMKgwqDCoMKg
cmV0dXJuIHNlbmRfbWJveF93cml0ZV9jbWQocGRldiwgaWQsIGRhdGEpOwo+ICvCoMKgwqDCoMKg
wqDCoGludCByZXQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJm1ib3hfbG9jayk7
Cj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gc2VuZF9tYm94X3dyaXRlX2NtZChwZGV2LCBpZCwgZGF0
YSk7Cj4gK8KgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZtYm94X2xvY2spOwo+ICsKPiArwqDC
oMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IMKgfQo+IMKgRVhQT1JUX1NZTUJPTF9OU19HUEwocHJv
Y2Vzc29yX3RoZXJtYWxfc2VuZF9tYm94X3dyaXRlX2NtZCwKPiBJTlQzNDBYX1RIRVJNQUwpOwo+
IMKgCj4gKyNkZWZpbmUgTUJPWF9DQU1BUklMTE9fUkRfSU5UUl9DT05GSUfCoMKgMHgxRQo+ICsj
ZGVmaW5lIE1CT1hfQ0FNQVJJTExPX1dSX0lOVFJfQ09ORklHwqDCoDB4MUYKPiArI2RlZmluZSBX
TFRfVFdfTUFTS8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBHRU5NQVNL
X1VMTCgzMCwgMjQpCj4gKyNkZWZpbmUgU09DX1BSRURJQ1RJT05fVFdfU0hJRlTCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoDI0Cj4gKwo+ICtpbnQgcHJvY2Vzc29yX3RoZXJtYWxfbWJv
eF9pbnRlcnJ1cHRfY29uZmlnKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAo+IGJvb2wgZW5hYmxlLAo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGVuYWJsZV9iaXQsIGludAo+IHRpbWVf
d2luZG93KQoKQWxsIHRoZSBjYWxsZXJzIG9mIHRoaXMgQVBJIGluIHRoaXMgcGF0Y2ggc2VyaWVz
IHVzZXMKU09DX1dMVF9QUkVESUNUSU9OX0lOVF9FTkFCTEVfQklUIGFzIHRoZSBlbmFibGVfYml0
LCBzbyB0aGlzIHBhcmFtZXRlcgppcyByZWR1bmRhbnQ/Cm9yIGRvIHdlIGV4cGVjdCBhIGRpZmZl
cmVudCBlbmFibGVfYml0IG9uIG90aGVyL2Z1dHVyZSBwbGF0Zm9ybXM/Cgp0aGFua3MsCnJ1aQoK
PiArewo+ICvCoMKgwqDCoMKgwqDCoHU2NCBkYXRhOwo+ICvCoMKgwqDCoMKgwqDCoGludCByZXQ7
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmICghcGRldikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIC1FTk9ERVY7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2so
Jm1ib3hfbG9jayk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoC8qIERvIHJlYWQgbW9kaWZ5IHdyaXRl
IGZvciBNQk9YX0NBTUFSSUxMT19SRF9JTlRSX0NPTkZJRyAqLwo+ICsKPiArwqDCoMKgwqDCoMKg
wqByZXQgPSBzZW5kX21ib3hfcmVhZF9jbWQocGRldiwKPiBNQk9YX0NBTUFSSUxMT19SRF9JTlRS
X0NPTkZJRyzCoCAmZGF0YSk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkgewo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKCZwZGV2LT5kZXYsICJNQk9YX0NBTUFSSUxM
T19SRF9JTlRSX0NPTkZJRwo+IGZhaWxlZFxuIik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGdvdG8gdW5sb2NrOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDC
oMKgaWYgKHRpbWVfd2luZG93ID49IDApIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZGF0YSAmPSB+V0xUX1RXX01BU0s7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAvKiBQcm9ncmFtIG5vdGlmaWNhdGlvbiBkZWxheSAqLwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBkYXRhIHw9ICh0aW1lX3dpbmRvdyA8PCBTT0NfUFJFRElDVElPTl9UV19T
SElGVCk7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoZW5hYmxl
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkYXRhIHw9IEJJVChlbmFibGVfYml0
KTsKPiArwqDCoMKgwqDCoMKgwqBlbHNlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGRhdGEgJj0gfkJJVChlbmFibGVfYml0KTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gc2Vu
ZF9tYm94X3dyaXRlX2NtZChwZGV2LAo+IE1CT1hfQ0FNQVJJTExPX1dSX0lOVFJfQ09ORklHLCBk
YXRhKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBkZXZfZXJyKCZwZGV2LT5kZXYsICJNQk9YX0NBTUFSSUxMT19XUl9JTlRSX0NPTkZJ
Rwo+IGZhaWxlZFxuIik7Cj4gKwo+ICt1bmxvY2s6Cj4gK8KgwqDCoMKgwqDCoMKgbXV0ZXhfdW5s
b2NrKCZtYm94X2xvY2spOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ICt9Cj4g
K0VYUE9SVF9TWU1CT0xfTlNfR1BMKHByb2Nlc3Nvcl90aGVybWFsX21ib3hfaW50ZXJydXB0X2Nv
bmZpZywKPiBJTlQzNDBYX1RIRVJNQUwpOwo+ICsKPiDCoE1PRFVMRV9MSUNFTlNFKCJHUEwgdjIi
KTsKCg==
