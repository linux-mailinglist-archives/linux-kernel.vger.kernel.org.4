Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C1E66551C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjAKHZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbjAKHZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:25:25 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38457E03F;
        Tue, 10 Jan 2023 23:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673421923; x=1704957923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r16wyEr0WpCxpdquxa8H9wV1vxGXDJmKV3LXkCe8weM=;
  b=cQUpFoFmOP43Ikv+4gXg81kSvRSKKhdyDBtLoqRyMiAizXIGGnTpu6TQ
   ZxJMOQ6rKqhxysVo6Z6EyRWl2kGHrRViO2SAF+O1a/2Id7g0aWsjznOtt
   w1ETnZaufygqb4kQ6FLGvGDEqf+c6QtMPEJ5Jsy3TpiRrL1VQ6hHUJGxQ
   r9rf3X0WYtaxxOtqotgC6JzpxdGU+uAjn5O3FdSRqDP9yF8UzxT0GxLZn
   iVuohO3bb22tG9aZ45w4ZNXFZL92l7hQUg7gMcTicsrPJWdV4XEkZtsQf
   7kWA74T+SPPMFQS3lybCMz4Bq0WIsSFUBZmJardUuQn1+NF6e/Z0UC19R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="306867474"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="306867474"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 23:25:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720627379"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="720627379"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2023 23:25:13 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 23:25:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 23:25:13 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 23:25:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAfE7e0AbxoATvyRFaoYDl7gVVwSYYOGQ0p4jMfPDANM/yp1u6PGJd7JvKU9BoVmy9BIhz9yGlUOFl6mp0/a/rGSmPnKrbei6s+nOvK9K7Qez3sPDsWmKRjDHJvOm4/z8SsNWVAfs1Uh6OEDnkOfQBrI8/JD0y3EZNfW+UPfTD+JpvdhYF7g6r6eZRhJzpt2G6F1CuMhDbguLxLpA5fWVq/Dj+F5utrGrA6cTRzc4K6dDD8jp0lq8fXUCwcknNlGUC5Skrs2YixOA+/IJkcPgLeIa66uelBJ3GlkHVy3hOKw0ts2uyd2jFgWyTGAdbwHJ9MXlzDw73JkxkFEu2PTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r16wyEr0WpCxpdquxa8H9wV1vxGXDJmKV3LXkCe8weM=;
 b=IwkXshvJkCAxi9gYli5MSvQ3PEJdbF9hOZPT9CyX2dHhrIhO2fVZNanLsiQ49MmFLBan6E1tiQMCDtmqp5G06kP4Vcz1QanlFRelihT8rJV1/I+Qey6v/aJk6wDgAPnqH7wCPMF2rsB1TWpdpcx9J9mBOW5iYbNBrIHmkqHVM+XlJQU/ZKjQkVqKlYsrx4SrBsBPTSug2tlHx9jbR+34hx4ea5Ll44UAZoEtDEUGKYJjWhalK0IHcgbHKGFA07wcIkncCBgLO+cH1dDlbBNuhhyQ9yu73CN20wOiBaEmoR2W44YUXkPXQMU98F+t1lhAiPEB6sivDC6XRpTkxh7uxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 07:25:11 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 07:25:11 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chen, Yu C" <yu.c.chen@intel.com>
Subject: Re: [PATCH v1] ACPI: PNP: Introduce list of known non-PNP devices
Thread-Topic: [PATCH v1] ACPI: PNP: Introduce list of known non-PNP devices
Thread-Index: AQHZJR0gKBuvlkN6PUyPjwH7KCdxOa6Y0XGA
Date:   Wed, 11 Jan 2023 07:25:10 +0000
Message-ID: <c9acadcd3e19e7dafb8ba4cf1f0abb0200b18b1a.camel@intel.com>
References: <12149290.O9o76ZdvQC@kreacher>
In-Reply-To: <12149290.O9o76ZdvQC@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB4920:EE_
x-ms-office365-filtering-correlation-id: 052c9182-a228-47f4-7b0d-08daf3a4f961
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vs1admaAwIn13xApHg9tfLGDqJkDENUV/kVlJUs++5JcMDhXoefZS9AacUdCtXIpm+i839L+3VyfoizddyGsN6ZTxXlaPr4d61xr3QT+PIZNcJxrO1We+aZmxPOocsal3+eQmQwMrtvZ1s1GQShdvxv9I2zocfIs9q9dyDIWS1dp3rKPcaP/zQVBRvNyAayIcniykemiJFVXdqDLhR71ED17HOg13boXJTjgohlfcoOoPFotyUcCu10MM0E9c8ULiQAt9XUjRHKymlijRKIjjpYeuJhmfiOr1dz3bSq5qilJr3moLy07pA9cH+unTRRAnmGOOonvb93IJkzB7dxsEiwFx3oJWdFa10nAlCwxtkV7+R/+qhfExoBBrgyZNenAy9k8LvVsLsUJqPJ6IQK4DM11QwMzdWPUG6gRENqKme+5SXQPYveIP6Qw61GqfoRGWlrBUvjXeIzDBqFW1v+4yCAnYvwlX70s4IV+K3Ms0BlFRkU0hE2J19gYzV8pYyMidqZvBxrKGB9lt+1k7LfKEEFR5gVgPdT5A/4hK2dA6U7jixuKMwBe/IzDmTVhwvBDTVyUTODNl/+bSyA3y8VhO/sMOf10DVDlpJfk8R6JYjNSlHsR2Tg1HnNqXKRwGe9ohVliElY0dngz/tm4V2HiJt+bdhH5Ud6SQqb+WkQyw7uOzEXQ453ggMnKObERNR/3p5LBGO2V597fr3sjNA6vSqHopltP9Nf0PKsYp2YWs8bWkWUSxeIe0CIWmqOWEtd3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(41300700001)(6506007)(8936002)(84970400001)(5660300002)(2906002)(107886003)(83380400001)(66556008)(66476007)(64756008)(66446008)(66946007)(91956017)(8676002)(71200400001)(76116006)(4326008)(36756003)(122000001)(38100700002)(82960400001)(2616005)(38070700005)(316002)(54906003)(478600001)(110136005)(6486002)(86362001)(26005)(186003)(6512007)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnhzRWtGVllYVVh2dGFTM2s2RjJzZWRWVDU3V3k3dHFsb05yNGNEaDFac2VC?=
 =?utf-8?B?VitveXQxSHRDUC9DOHFuR1k5ZVhCQ0VZcDY5YUhaM1VjSitpOVNQKy9uZ3BP?=
 =?utf-8?B?TmpaeXlPRC91aENSMlF3STB6RWNUYUVwQUZ4WTd0bGV3R0NmbG11UUZYU0Z6?=
 =?utf-8?B?dVNKYzYwVDBkU1RqQzZWN1ZQMm1uYW52Q1dPZ3VES1RkQUVGYnRZeUNQeFhk?=
 =?utf-8?B?UldvcTZuajdVNURsekoydllIakk4U3did1htMFdnNlF4YzQyQ3JnV2IzMmpI?=
 =?utf-8?B?ekhiRXROM21GV0g1RjZsMlBuR0RBOEpPUDhYK0lxdVNhRm1LVnVjK0IvOVFQ?=
 =?utf-8?B?cHZrc05HYjZ4MkJIeVhVVStlV1RWTjRabkttNHFQbTk4L2tOdWZDc01uWWFN?=
 =?utf-8?B?SkVLL3lWbkoxUWNZYytNa3lpMFo3OVV6YVNYMGt3K2htRWZLV0xxeldITXRq?=
 =?utf-8?B?WCtCV0VZano5dUdQdTVVTmkrNlZZVC8rM3E2ZDNBa2twNDRFSmJ6c2NBZW5m?=
 =?utf-8?B?cnFneFRXL3ovV3BybkxnYi9GcWVmYkZjdkRpcUQzSHRSeHRqNGNtUjllM0hO?=
 =?utf-8?B?QTlhTWpGV1N0V3FKcHBqc2Q1WDJyQUQvS0xJTjE5S3pXb3B2cmZoZ3dtQThU?=
 =?utf-8?B?UUprRS9hS3p4bFExWnN5a3NUMUNjOFg2eGhRVVl0YW1JUTh3NVNzUWZGRmVB?=
 =?utf-8?B?dWF0bWVneDFxKzFWL1BPV2ZTR2hva1VhdWFwc0FaUGo4UFZ4c1UyajVaOGpp?=
 =?utf-8?B?OEdoZGZkVFRzQ1FDcUJCZGRIUnlyQk5wSktIWW5YazJnOEtPQjkvOFgrMG9x?=
 =?utf-8?B?a3FxSWVSMGI1Wmd5dnpPb0MzeFFDR0pQYUhlbWJnTW9Vek1oRTBzd1UxR3J4?=
 =?utf-8?B?RjN3anoxMnhueGVncUFSMDVTZUduQjZrdHJrTzh6N25pUG13RU5LeUNSNDdU?=
 =?utf-8?B?M3pxOC8wZlBseE9QTUd0L1RWUFlYNW1ZMU5mYWJlcVRHMGZPNU5CZzNCbC9P?=
 =?utf-8?B?bzBQaGVIbVhld2FXZExZQ1g1RmxtMmpaUW9WRHFINXlKNXRZdjFnc1lhd28w?=
 =?utf-8?B?Nk1oMCtEbWhQZnZQMHY2MDJrZ25uSlBydGNubjArdENEQXA5cXBNQ3FtUDNi?=
 =?utf-8?B?QUwrQ1BaajJQVHZXQUdhY0RIVERtQW1vU1RNVXp3OVF0bDV6R25mMGVSekZP?=
 =?utf-8?B?VFdvVHlpVGI3U08vbHJBN3dmK3lPYTNsU0Juemc1a1RBL0tJd0xVbFB4TW9H?=
 =?utf-8?B?RTZYdWlQSDZiSnhrVmdHR3dkc3dhaUkwVkp1ajdUV3RWaHlOV1U1TEhVNVEr?=
 =?utf-8?B?RjlTMlc5TC9LT0FQMkU0Q1JFbjltWWJZczlqMm9DZXl3VmhIRlltSmFFQ0NN?=
 =?utf-8?B?endTTFRpMGkvVzkwR2hXYVJEUXZML2ZTb3hBaDVzNU5qcWo0MFJ3YjhhVlFY?=
 =?utf-8?B?OEdQWHZTSWV4cmI3dHA2YWVtcEE5b0hNUjRMREE0TktsVGRrQ1FoUVhKaUlw?=
 =?utf-8?B?MGp3Sngzd2l3dTZwcm0vQ3ZOZGlKVy9ydk54Q3FKclNFdm9pNmhWSm5DOUpD?=
 =?utf-8?B?Q0lybXRTSnM1QlppQnRyZjVnb0tkZ25HZE53TzhpV3plYkZoYnRBcVlrc1J4?=
 =?utf-8?B?RFJVR1JKOWsyWGxpc0RzeVd5SDdzY09XZzU3ODVDRWhSZ0JQNE5oYmJrd0Ux?=
 =?utf-8?B?MmZCTEZSSWQwM3ZkQlJwVW1wRmZ5bDdxN29ET01Vc05lNDNjVEZhd2tjd2My?=
 =?utf-8?B?SHpUZTUvUGZTZk5rcXNDdXpaZTBFWUhNSmZUSjE5MDdZTklIcG1JdlA3Wm54?=
 =?utf-8?B?Z3RaUmdTRzRDS1lCY3Z2WnFqMTcxWEpsb3Y4VkdYd2U4U1ZPQTVnVmJncXEz?=
 =?utf-8?B?dkdGM0cvK2dINnZiZzc5OEVJaDZYZjFVVzlmR2xpdGVtcDlvNHF6N3l0Szcy?=
 =?utf-8?B?eTROWGJrc1Q4dHVGVGMyRG9jTHl1YWowV3V0RXJjbXdnLzhPcWRUd2ZRSmEz?=
 =?utf-8?B?U08rK3JJZnNiTk5lcU5obnlSUGZqRHAraC9KMkRLbnpCUkpUU1RGVlRuVGhj?=
 =?utf-8?B?S2FFV3lPTHZjblFqcWQ4aW1LMzN2N0JwOXdrRVF6SDB2UTBXSUxFMTBhdCts?=
 =?utf-8?Q?vWhnPdPVTvZ8fOXjaY9t0p5mC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00403EF285B9FD499E5DCAE361D907F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052c9182-a228-47f4-7b0d-08daf3a4f961
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 07:25:11.0292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /v3Tyox/IjaVxFmkOLpZ7qbRbpmZGmjf7Qft1Ds3ep8WR8HJ5PUdm5TQ0dMkl70u9Lv4O6PUJg1F9KvV9DzW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTEwIGF0IDE4OjU4ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gSW4gc29tZSBjYXNlcywgUE5QIGRldmljZSBJRHMgZnJvbSBhY3BpX3BucF9kZXZp
Y2VfaWRzW10gYXJlIHJldHVybmVkDQo+IGJ5DQo+IF9DSUQgZm9yIGRldmljZXMgZm9yIHdoaWNo
IG1hdGNoaW5nIHBsYXRmb3JtIGRyaXZlcnMgYXJlIHByZXNlbnQgaW4NCj4gdGhlDQo+IGtlcm5l
bCBhbmQgc2hvdWxkIGJlIGJvdW5kIHRvIHRoZW0uICBIb3dldmVyLCB0aGUgSURzIGNvbWluZyBm
cm9tDQo+IF9DSUQNCj4gY2F1c2UgdGhlIFBOUCBzY2FuIGhhbmRsZXIgdG8gYXR0YWNoIHRvIHRo
b3NlIGRldmljZXMgd2hpY2ggcHJldmVudHMNCj4gcGxhdGZvcm0gZGV2aWNlIG9iamVjdHMgZnJv
bSBiZWluZyBjcmVhdGVkIGZvciB0aGVtLg0KPiANCj4gQWRkcmVzcyB0aGlzIGJ5IGludHJvZHVj
aW5nIGEgbGlzdCBvZiBrbm93biBub24tUE5QIGRldmljZSBJRHMgaW50bw0KPiBhY3BpX3BucC5j
IHN1Y2ggdGhhdCBpZiBhIGRldmljZSBJRCBpcyB0aGVyZSBpbiB0aGF0IGxpc3QsIGl0IGNhbm5v
dA0KPiBiZQ0KPiBhdHRhY2hlZCB0byBieSB0aGUgUE5QIHNjYW4gaGFuZGxlciBhbmQgYWRkIHRo
ZSBwbGF0Zm9ybSBydW50aW1lDQo+IHVwZGF0ZQ0KPiBhbmQgdGVsZW1ldHJ5IGRldmljZSBJRHMg
dG8gdGhhdCBsaXN0IHRvIHN0YXJ0IHdpdGguDQo+IA0KPiBSZXBvcnRlZC1ieTogQ2hlbiBZdSA8
eXUuYy5jaGVuQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kg
PHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvYWNwaS9hY3Bp
X3BucC5jIHwgICAxNCArKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL2Fj
cGkvYWNwaV9wbnAuYw0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMv
YWNwaS9hY3BpX3BucC5jDQo+ICsrKyBsaW51eC1wbS9kcml2ZXJzL2FjcGkvYWNwaV9wbnAuYw0K
PiBAQCAtMzQ4LDEwICszNDgsMjIgQEAgc3RhdGljIGJvb2wgYWNwaV9wbnBfbWF0Y2goY29uc3Qg
Y2hhciAqaQ0KPiAgCXJldHVybiBmYWxzZTsNCj4gIH0NCj4gIA0KPiArLyoNCj4gKyAqIElmIG9u
ZSBvZiB0aGUgZGV2aWNlIElEcyBiZWxvdyBpcyBwcmVzZW50IGluIHRoZSBsaXN0IG9mIGRldmlj
ZQ0KPiBJRHMgb2YgYQ0KPiArICogZ2l2ZW4gQUNQSSBkZXZpY2Ugb2JqZWN0LCB0aGUgUE5QIHNj
YW4gaGFuZGxlciB3aWxsIG5vdCBhdHRhY2ggdG8NCj4gdGhhdA0KPiArICogb2JqZWN0LCBiZWNh
dXNlIHRoZXJlIGlzIGEgcHJvcGVyIG5vbi1QTlAgZHJpdmVyIGluIHRoZSBrZXJuZWwNCj4gZm9y
IHRoZQ0KPiArICogZGV2aWNlIHJlcHJlc2VudGVkIGJ5IGl0Lg0KPiArICovDQo+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIGFjcGlfbm9ucG5wX2RldmljZV9pZHNbXSA9IHsN
Cj4gKwl7IklOVEMxMDgwIn0sDQo+ICsJeyJJTlRDMTA4MSJ9LA0KPiArCXsiIn0sDQo+ICt9Ow0K
PiArDQo+ICBzdGF0aWMgaW50IGFjcGlfcG5wX2F0dGFjaChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFk
ZXYsDQo+ICAJCQkgICBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgKmlkKQ0KPiAgew0KPiAt
CXJldHVybiAxOw0KPiArCXJldHVybiAhIWFjcGlfbWF0Y2hfZGV2aWNlX2lkcyhhZGV2LCBhY3Bp
X25vbnBucF9kZXZpY2VfaWRzKTsNCg0KYWNwaV9tYXRjaF9kZXZpY2VfaWRzKCkgcmV0dXJucyBU
cnVlIGlmIHRoZSBpZCBtYXRjaGVzLCBhbmQgaW4gdGhpcw0KY2FzZSwgYWNwaV9wbnBfYXR0YWNo
KCkgc2hvdWxkIHJldHVybiBmYWxzZSwgcmlnaHQ/DQoNCnRoYW5rcywNCnJ1aQ0KDQo+ICB9DQo+
ICANCj4gIHN0YXRpYyBzdHJ1Y3QgYWNwaV9zY2FuX2hhbmRsZXIgYWNwaV9wbnBfaGFuZGxlciA9
IHsNCj4gDQo+IA0KPiANCg==
