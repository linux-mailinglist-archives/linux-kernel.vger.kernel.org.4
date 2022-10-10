Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12895FA363
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJJScX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJJScT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:32:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D0012605
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665426738; x=1696962738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0c/UE0ATApBT9o4pxpiimjA2nbGGpRr9XvbSoZywcUs=;
  b=fKGkhyOGHxp+Hw6jhYi5F6uUIwpO2OsD+CmngQs4micp9bFhfdQ/sz5k
   lyvLKF3Je35FMRs3sV/OgMhI0Ag1QhImodGtRh5s9d6qkurhvwPCrT/Se
   Vs4Tcpv6lF+xhJP2L0yY26w34DRsefu3Tn+NNvw0NVZ32qFy44Z/dh3H+
   O6Cxv10qGEAOlcZld+qgbYyW5+12v6/8WK1d5DnBL8yK99VKlfwgWTCTK
   E6EAfiLZeJGKmno3WP1QvSWJ6M7h+c7cYTkxcjBBt0mRW2fbdTO1KCNEP
   2Phac6gxqcdYh3OIw4u9euuOX61lha1gUWXPO8RnuMs7RJDZ8LDbaqoVU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="291594082"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="291594082"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 11:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="657038547"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="657038547"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 10 Oct 2022 11:32:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 11:32:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 11:32:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 11:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHMid40UhibVqF+xHUEEWQenQePy7qGcKom3faXJ8V0IwlPbyOPAP2rYoxDoI+RZi/1skymkqha+PzjBc3FQH1GBR4Se4jdudJ7NW5CKO3Es2v6PGZ6hpuFPSm2fNdZztGnwJuZ+iYL1I+Iy6Jsi3uPmTVZArXyE8Logyn0RVfju6057EFgs2EoEFt6+VarkDbpkT6gg4jNSq4Uwkn22R71fJIMGsGbCt0IA5+F1b1n4b3e009M8xU4UZUHsluP8EBhv0/6C6izemFtjUqP0v4ZIYpPFIdVgHjev1N12X0ZV5vzQeQEXi8J0lTiAbO/jBkHWE3SZxapnkzzOC0bkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c/UE0ATApBT9o4pxpiimjA2nbGGpRr9XvbSoZywcUs=;
 b=JL6vH+P02vlCCNm071dUOQYwFqBTvTpz6h6nTJ92zi9MlScvxBwqFsZC9TRhtDkUMCgUmklhoK83JkFrVUCRHNJSyB4ua11rLx0rZoA8Kp233ECQO50aJQzCdO0OWTzIrtECaKCb6PoVSVsnfuTaNaTI1QcWls+81RlKfVfW1Pn71LpOFrA/kVaYkVla8HhEm2hbUsCgXMrdSgh7nX2EWU3qV+VkNbrqAFNH18e4O1o1gLCL18laM8T+OuVh5NnotY/hrL+6aU/pkuCebax6TwpiCU+8Wn27lvtxb9QJ7wN/iEbMMh+P7UAOQQ3eldS70lrByrHsU4lgG4KzOIxXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 18:32:14 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.040; Mon, 10 Oct 2022
 18:32:14 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Topic: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Index: AQHY2qcSuA+QF3WN10KzhnOoNUAfaa4H9+yA
Date:   Mon, 10 Oct 2022 18:32:14 +0000
Message-ID: <af5c148fb3b9c56d1eb7e92b05db7c6c04bcfc3c.camel@intel.com>
References: <20221007234315.2877365-1-song@kernel.org>
         <20221007234315.2877365-5-song@kernel.org>
In-Reply-To: <20221007234315.2877365-5-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA0PR11MB4542:EE_
x-ms-office365-filtering-correlation-id: c2c8eff4-8b0b-43b3-ddee-08daaaedc0cb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ni/5GYf9ItkA5zVYWRZsdJcZmTqXJN9IYzJBZXEBzFitUwaEyBzk+QzM6Tj8PgyZxplnR0F4r9OyZPGrr0PY7NUynO9GhfeViUJOeKPSVfKIsGucSnVmvt747fy5ekmM+/Y2PNK/GqXk24Ug8sXJ+5suUcv6yzUrxOdXZyfvwY6jhCFvHyldY4UgTox+UZjX2pXDCtK3xDlDYoY2KWeVtH2Kuqu0UY/iiC1xoH4TboJzWO7rAh3jr3ldc+GP5qTn6pcmoF2eftdOBQQ42ABeT2nJLbtOc9kuMvPpB9q8MTsNWcA4X24XVNqKVm8Dy1OF8Sj0n1OE5bgaJrrb7/Z9/VkQgrVFFrvWX8xyR/+e6GZikv4tEJ7Uc2hhM83xt1QqcXMqpX8CPfRCviZsAxgTaTR8w1gUZ3H9vZb7KU58F1ddxd5Cn9XYAa55c2hrovFMJwK34PZBaEAcjIwTbEWN8ekCCmobQnoVNaFqtRWxg7sj24Qx8gAEno28kIkC1ItdjOEpD15OiEMVutcPpB9rmLSI0/aj/fxEx0n4rPsZcvmbXyMktJ50+N/EyqaT3PEoOVtzf2DJVl7LF8F2ui32bJPWzCHGzZDU8eCsuAc82Ag5EexEgtU/ALRqlq1l6gik41jE06NeilvkkMcpzhBHzBO6R/tSRPTlgbB5zuhdAytObKTnT6crahCCayjRjljsWbKcuC/zoWtewk5cjXbRJlLqMHgR3FgqgT486NV4MZ/dYjfPHgc2Fo+nt43TT5KbqBlpcMXQHFJVoZE06bYxiBYxXuKPPYYPukOtL9AtDKC/oUv6gvaq5J1ztxSTVWhU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199015)(38070700005)(122000001)(38100700002)(64756008)(82960400001)(86362001)(8676002)(316002)(91956017)(66476007)(66446008)(66556008)(110136005)(76116006)(54906003)(66946007)(2906002)(83380400001)(41300700001)(186003)(8936002)(6506007)(71200400001)(107886003)(26005)(6512007)(478600001)(5660300002)(4326008)(2616005)(6486002)(36756003)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGI5L08vUUdoQk1KYVl1Q3d0ZklGZVl5L1Vob2ozaUEvUkUyTXVNLzVIeitj?=
 =?utf-8?B?Vm15YUtSWXpZVjJPajlZWnRnMW8zTVBqOGpUb3lEbC8rL2NMMUVVTU1Ia2FZ?=
 =?utf-8?B?WTBFcFpDTWo4SlROclJYNHpTY1RKR3pwY1FUMjhjeGN2MmMweFZlOHhJMlQy?=
 =?utf-8?B?TzZZMTZzRjZ1T1Y4Vm5QRG5mOVJqaVRNcTc1a3ZFbk4yV2FjZjd6V1pZYzBR?=
 =?utf-8?B?NUFZcHB1OWRtc3hpUHV1WWpWMmZQWEF4WVN5bU13TnJ0SEpicDJJOVlMUU9p?=
 =?utf-8?B?UDFpRzZ2UWg3RWNoVElDY3kxSWNDK3IzZVMwV2R3VGRsSEJ3Z0ZaWXd1cGNU?=
 =?utf-8?B?VG5zOUJlYWE1OCtMY21QMk9tWE5JejRVZmVwa3Rxb3c1RmR5NS9KMG8zSVdZ?=
 =?utf-8?B?S1FPczEzSVkvS003WjQyWlFnQ2hCYWlPSm5HVlhWRzBhYXRxTkFubzRlMEpI?=
 =?utf-8?B?MFRjRDNNTEZSS083ODZLaDdWSHlWRjliTU43Y1FQWllMUWtzdERZR2o4aWd4?=
 =?utf-8?B?OXdPMlBHMGgwNUxTWm9Ma2NGZWZuMExMcUxtZWVUYnBEWEZONUIzMVdTTFdI?=
 =?utf-8?B?WXNHR0Fkc2ZzNVN5eGRwSHFRb05maytQVnFsenFGN3MvbXdjM2hiMHhSMHZT?=
 =?utf-8?B?eGhCYmRPd2twVVJjU095QWMvTEtlSFdLU1ZtK3NRb2ZuU1BvRjluZllMZXh5?=
 =?utf-8?B?ZXpESHdNWEVMZ3lZVm5kY244RWdKNjNLMHhQUTFtek1qYk1RMWlvVzJGUjBT?=
 =?utf-8?B?aVEvTFFtKzkyd2VHUVJ2SUtPN3R4UFRxN0ErMTRvWlY1MTVRdFB1c3FJQ3ZL?=
 =?utf-8?B?VkZ6WW5wK2FqL252WVBiMGkzVGhiaTVYWXNlQnBGckJ0blZHNnl5ci9lSkd6?=
 =?utf-8?B?akRUQUV0a2lFd1BKZjhyWURrSnRPZ1ZjSWhiNWE4TFkxOEZKWU9Xb054RWlO?=
 =?utf-8?B?NVpzRHlSbGJtSC81Yjg4V1BEL2w1Z2xwTWVKaWxSS09xOXN2M1d3SGprbUtw?=
 =?utf-8?B?Rit1RFl0N1VUVXNEWEhXY0ZERnluMUdDdThGVkJjZWRKWnpRdVVqWWY4eit2?=
 =?utf-8?B?dUJaMFFUeFhMTHc1L1dNL3dlSWZQMVJDTEN3ZUdlOVdIaStGdmlFNVllWkVZ?=
 =?utf-8?B?Q1V3eE15WTNEeHhiaXRrY0hFWVhuNGpvVWlYajVvTXBwaWtKRzk0WDhnc2ZW?=
 =?utf-8?B?bWk3ZVNaQlA3ZDBFK2RBS3duTytadm9wd2h1Z3NNdGVWUVpTM2I4QnE5cVJD?=
 =?utf-8?B?eUVkWVphbUk5clZqYWRVN1dRdklOb3RmS2thVnVBck5iemhGUEozb0h3RlJ5?=
 =?utf-8?B?L3kxMHFFQ3NteUhxcFI2RHNxb2hpcjY4S21hM3VQR2NsVGprZWMwaTVDaG5v?=
 =?utf-8?B?eHYwQWJpSW9HMmNXSDVnVW9PM0w3UFVVRitXd0xXaFJDTU9RdVg2ay8yc0VE?=
 =?utf-8?B?Qjg5OVVWMm9WVGdibDdvbWIvLzR0ajhIZkl3UkwxRzRjKzVzTXljRnB4a0Zn?=
 =?utf-8?B?WEVxYVlZOWUxWTlTMEZjZXhqRG5LcnNyemIzYW1KdHNOUHd3ZWpjZzYwMllI?=
 =?utf-8?B?Z2YzOE9VR1IzZzJtOUcxNWhDNFBlWWlDa3pzUjFCNzQ0VHhOT01sdk15aWh2?=
 =?utf-8?B?UG1wbmE0WDFXTDlvaUsxeGRDS1Z2MW43MkpUL3BXVzBKM1J6T2xGdDNzVko5?=
 =?utf-8?B?REFZMklKdE5FVU5ybDRBQzNQK2NkRzNYa1RNdmhjYjRteTA0N0V0RnBDcFVr?=
 =?utf-8?B?UkJUVkttSFFXMmhhWmxjQ0JtTWVhUWVUTEt1NDB1dS95V3JrR21NTXlMWkxO?=
 =?utf-8?B?c0ZZaFFwb05rMUcwQ2dZbHpiVHh1QnU2a0NBV1RjOWNjVWNRVHFqN28rSTVn?=
 =?utf-8?B?Z2pSUUZOTG8zR1RXWkNhQ1NwZzFFS2xnbGdMNlVYMGlsNUQxaTNoaDduVDJ0?=
 =?utf-8?B?d3lBZllSZlNHdDFTN0txZzR4YVpKUExYeWRSWVBybUE5YUR3ZmZIalkvTG82?=
 =?utf-8?B?S0VxdWhnbVR3Y09WaTExdzRkb1JDRVFUNndkWmRzS2wvMXJwMDJzbEk4RE5z?=
 =?utf-8?B?b29Nci94dDh0THJ5TkhobGUxM0QrTFlPalBjSENPZXZWbFFZMHVSdDZqNGNP?=
 =?utf-8?B?Q2RXTitTS2k0dGV5UjZEWTVmZEpvTzJnUHk0cFhmckp6UFliWWFNZDBUQUMv?=
 =?utf-8?Q?GivpgsyMMG8i4847dKNOkMU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBC9B39C53C3C242B7D8BBEA1412AC48@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c8eff4-8b0b-43b3-ddee-08daaaedc0cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 18:32:14.4591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tw8OQR6/vVgwHZwdxCLukPP0mQuhG7og5ZT1tSagmh7X46IcSHGhO/tjxUf9Pm6ULkuo15Q3ttqTndzRBJR6Xj5zOhDOHFrf6cZJXEuVvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
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

T24gRnJpLCAyMDIyLTEwLTA3IGF0IDE2OjQzIC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gT24g
eDg2IGtlcm5lbCwgd2UgYWxsb2NhdGUgMk1CIHBhZ2VzIGZvciBrZXJuZWwgdGV4dCB1cCB0bw0K
PiByb3VuZF9kb3duKF9ldGV4dCwgMk1CKS4gVGhlcmVmb3JlLCBzb21lIG9mIHRoZSBrZXJuZWwg
dGV4dCBpcyBzdGlsbA0KPiBvbiA0a0IgcGFnZXMuIFdpdGggdm1hbGxvY19leGVjLCB3ZSBjYW4g
YWxsb2NhdGUgMk1CIHBhZ2VzIHVwIHRvDQo+IHJvdW5kX3VwKF9ldGV4dCwgMk1CKSwgYW5kIHVz
ZSB0aGUgcmVzdCBvZiB0aGUgcGFnZSBmb3IgbW9kdWxlcyBhbmQNCj4gQlBGIHByb2dyYW1zLg0K
PiANCj4gSGVyZSBpcyBhbiBleGFtcGxlOg0KPiANCj4gW3Jvb3RAZXRoNTAtMSB+XSMgZ3JlcCBf
ZXRleHQgL3Byb2Mva2FsbHN5bXMNCj4gZmZmZmZmZmY4MjIwMmEwOCBUIF9ldGV4dA0KPiANCj4g
W3Jvb3RAZXRoNTAtMSB+XSMgZ3JlcCBicGZfcHJvZ18gL3Byb2Mva2FsbHN5bXMgIHwgdGFpbCAt
biAzDQo+IGZmZmZmZmZmODIyMGY5MjAgdA0KPiBicGZfcHJvZ19jYzYxYTUzNjRhYzExZDkzX2hh
bmRsZV9fc2NoZWRfd2FrZXVwICAgICAgIFticGZdDQo+IGZmZmZmZmZmODIyMGZhMjggdA0KPiBi
cGZfcHJvZ19jYzYxYTUzNjRhYzExZDkzX2hhbmRsZV9fc2NoZWRfd2FrZXVwX25ldyAgIFticGZd
DQo+IGZmZmZmZmZmODIyMGZhZDQgdA0KPiBicGZfcHJvZ18zYmY3M2ZhMTZmNWUzZDkyX2hhbmRs
ZV9fc2NoZWRfc3dpdGNoICAgICAgIFticGZdDQo+IA0KPiBbcm9vdEBldGg1MC0xIH5dIyAgZ3Jl
cCAweGZmZmZmZmZmODIyMDAwMDANCj4gL3N5cy9rZXJuZWwvZGVidWcvcGFnZV90YWJsZXMva2Vy
bmVsDQo+IDB4ZmZmZmZmZmY4MjIwMDAwMC0NCj4gMHhmZmZmZmZmZjgyNDAwMDAwICAgICAyTSAg
ICAgcm8gICBQU0UgICAgICAgICB4ICBwbWQNCj4gDQo+IFtyb290QGV0aDUwLTEgfl0jIGdyZXAg
eGZzX2ZsdXNoX2lub2RlcyAvcHJvYy9rYWxsc3ltcw0KPiBmZmZmZmZmZjgyMmJhOTEwIHQgeGZz
X2ZsdXNoX2lub2Rlc193b3JrZXIgICAgICBbeGZzXQ0KPiBmZmZmZmZmZjgyMmJjNTgwIHQgeGZz
X2ZsdXNoX2lub2RlcyAgICAgW3hmc10NCj4gDQo+IGZmZmZmZmZmODIyMDAwMDAtZmZmZmZmZmY4
MjQwMDAwMCBpcyBhIDJNQiBwYWdlLCBzZXJ2aW5nIGtlcm5lbCB0ZXh0LA0KPiB4ZnMNCj4gbW9k
dWxlLCBhbmQgYnBmIHByb2dyYW1zLg0KDQpDYW4gdGhpcyBtZW1vcnkgcmFuZ2UgYmUgZnJlZWQg
YXMgcGFydCBvZiBhIHZmcmVlX2V4ZWMoKSBjYWxsIHRoZW4/DQpEb2VzIHZtYWxsb2MgYWN0dWFs
bHkgdHJ5IHRvIHVubWFwIGl0PyBJZiBzbywgaXQgY291bGQgZ2V0IGNvbXBsaWNhdGVkDQp3aXRo
IFBUSS4NCg0KSXQgcHJvYmFibHkgc2hvdWxkIGJlIGEgc3BlY2lhbCBjYXNlIHRoYXQgbmV2ZXIg
Z2V0cyBmdWxseSBmcmVlZC4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU29uZyBMaXUgPHNvbmdA
a2VybmVsLm9yZz4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9tbS9pbml0XzY0LmMgfCAgMyArKy0NCj4g
IG1tL3ZtYWxsb2MuYyAgICAgICAgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vaW5pdF82NC5jIGIvYXJjaC94ODYvbW0vaW5pdF82NC5j
DQo+IGluZGV4IDBmZTY5MGViYzI2OS4uZDk0ZjE5NmM1NDFhIDEwMDY0NA0KPiAtLS0gYS9hcmNo
L3g4Ni9tbS9pbml0XzY0LmMNCj4gKysrIGIvYXJjaC94ODYvbW0vaW5pdF82NC5jDQo+IEBAIC0x
MzY3LDEyICsxMzY3LDEzIEBAIGludCBfX2luaXQNCj4gZGVmZXJyZWRfcGFnZV9pbml0X21heF90
aHJlYWRzKGNvbnN0IHN0cnVjdCBjcHVtYXNrICpub2RlX2NwdW1hc2spDQo+ICANCj4gIGludCBr
ZXJuZWxfc2V0X3RvX3JlYWRvbmx5Ow0KPiAgDQo+ICsjZGVmaW5lIFBNRF9BTElHTih4KQkoKCh1
bnNpZ25lZCBsb25nKSh4KSArIChQTURfU0laRSAtIDEpKSAmDQo+IFBNRF9NQVNLKQ0KPiAgdm9p
ZCBtYXJrX3JvZGF0YV9ybyh2b2lkKQ0KPiAgew0KPiAgCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSBQ
Rk5fQUxJR04oX3RleHQpOw0KPiAgCXVuc2lnbmVkIGxvbmcgcm9kYXRhX3N0YXJ0ID0gUEZOX0FM
SUdOKF9fc3RhcnRfcm9kYXRhKTsNCj4gIAl1bnNpZ25lZCBsb25nIGVuZCA9ICh1bnNpZ25lZCBs
b25nKV9fZW5kX3JvZGF0YV9ocGFnZV9hbGlnbjsNCj4gLQl1bnNpZ25lZCBsb25nIHRleHRfZW5k
ID0gUEZOX0FMSUdOKF9ldGV4dCk7DQo+ICsJdW5zaWduZWQgbG9uZyB0ZXh0X2VuZCA9IFBNRF9B
TElHTihfZXRleHQpOw0KDQpUaGlzIHNob3VsZCBwcm9iYWJseSBoYXZlIG1vcmUgbG9naWMgYW5k
IGFkanVzdG1lbnRzLiBJZiBldGV4dCBpcyBQTUQNCmFsaWduZWQsIHNvbWUgb2YgdGhlIHN0dWZm
IG91dHNpZGUgdGhlIGRpZmYgd29uJ3QgZG8gYW55dGhpbmcuDQoNCkFsc28sIGlmIGEga2VybmVs
IGRvZXNuJ3QgaGF2ZSBtb2R1bGVzIG9yIEJQRiBKSVQgaXQgd291bGQgYmUgYSB3YXN0ZQ0Kb2Yg
bWVtb3J5Lg0KDQo+ICAJdW5zaWduZWQgbG9uZyByb2RhdGFfZW5kID0gUEZOX0FMSUdOKF9fZW5k
X3JvZGF0YSk7DQo+ICAJdW5zaWduZWQgbG9uZyBhbGxfZW5kOw0KPiAgDQo+IGRpZmYgLS1naXQg
YS9tbS92bWFsbG9jLmMgYi9tbS92bWFsbG9jLmMNCj4gaW5kZXggOTIxMmZmOTZiODcxLi40MTUw
OWJiZWM1ODMgMTAwNjQ0DQo+IC0tLSBhL21tL3ZtYWxsb2MuYw0KPiArKysgYi9tbS92bWFsbG9j
LmMNCj4gQEAgLTc1LDYgKzc1LDkgQEAgc3RhdGljIGNvbnN0IGJvb2wgdm1hcF9hbGxvd19odWdl
ID0gZmFsc2U7DQo+ICAjZGVmaW5lIFBNRF9BTElHTihhZGRyKSBBTElHTihhZGRyLCBQTURfU0la
RSkNCj4gICNkZWZpbmUgUE1EX0FMSUdOX0RPV04oYWRkcikgQUxJR05fRE9XTihhZGRyLCBQTURf
U0laRSkNCj4gIA0KPiArc3RhdGljIHN0cnVjdCB2bV9zdHJ1Y3QgdGV4dF90YWlsX3ZtOw0KPiAr
c3RhdGljIHN0cnVjdCB2bWFwX2FyZWEgdGV4dF90YWlsX3ZhOw0KPiArDQo+ICBib29sIGlzX3Zt
YWxsb2NfYWRkcihjb25zdCB2b2lkICp4KQ0KPiAgew0KPiAgCXVuc2lnbmVkIGxvbmcgYWRkciA9
ICh1bnNpZ25lZCBsb25nKWthc2FuX3Jlc2V0X3RhZyh4KTsNCj4gQEAgLTYzNyw2ICs2NDAsOCBA
QCBpbnQgaXNfdm1hbGxvY19vcl9tb2R1bGVfYWRkcihjb25zdCB2b2lkICp4KQ0KPiAgCXVuc2ln
bmVkIGxvbmcgYWRkciA9ICh1bnNpZ25lZCBsb25nKWthc2FuX3Jlc2V0X3RhZyh4KTsNCj4gIAlp
ZiAoYWRkciA+PSBNT0RVTEVTX1ZBRERSICYmIGFkZHIgPCBNT0RVTEVTX0VORCkNCj4gIAkJcmV0
dXJuIDE7DQo+ICsJaWYgKGFkZHIgPj0gdGV4dF90YWlsX3ZhLnZhX3N0YXJ0ICYmIGFkZHIgPA0K
PiB0ZXh0X3RhaWxfdmEudmFfZW5kKQ0KPiArCQlyZXR1cm4gMTsNCj4gICNlbmRpZg0KPiAgCXJl
dHVybiBpc192bWFsbG9jX2FkZHIoeCk7DQo+ICB9DQo+IEBAIC0yNDIyLDYgKzI0MjcsMjQgQEAg
c3RhdGljIHZvaWQgdm1hcF9pbml0X2ZyZWVfc3BhY2Uodm9pZCkNCj4gIAl9DQo+ICB9DQo+ICAN
Cj4gK3N0YXRpYyB2b2lkIHJlZ2lzdGVyX3RleHRfdGFpbF92bSh2b2lkKQ0KPiArew0KPiArCXVu
c2lnbmVkIGxvbmcgc3RhcnQgPSBQRk5fQUxJR04oKHVuc2lnbmVkIGxvbmcpX2V0ZXh0KTsNCj4g
Kwl1bnNpZ25lZCBsb25nIGVuZCA9IFBNRF9BTElHTigodW5zaWduZWQgbG9uZylfZXRleHQpOw0K
PiArCXN0cnVjdCB2bWFwX2FyZWEgKnZhOw0KPiArDQo+ICsJdmEgPSBrbWVtX2NhY2hlX3phbGxv
Yyh2bWFwX2FyZWFfY2FjaGVwLCBHRlBfTk9XQUlUKTsNCj4gKwlpZiAoV0FSTl9PTl9PTkNFKCF2
YSkpDQo+ICsJCXJldHVybjsNCj4gKwl0ZXh0X3RhaWxfdm0uYWRkciA9ICh2b2lkICopc3RhcnQ7
DQo+ICsJdGV4dF90YWlsX3ZtLnNpemUgPSBlbmQgLSBzdGFydDsNCj4gKwl0ZXh0X3RhaWxfdmEu
dmFfc3RhcnQgPSBzdGFydDsNCj4gKwl0ZXh0X3RhaWxfdmEudmFfZW5kID0gZW5kOw0KPiArCXRl
eHRfdGFpbF92YS52bSA9ICZ0ZXh0X3RhaWxfdm07DQo+ICsJbWVtY3B5KHZhLCAmdGV4dF90YWls
X3ZhLCBzaXplb2YoKnZhKSk7DQo+ICsJaW5zZXJ0X3ZtYXBfYXJlYV9hdWdtZW50KHZhLCBOVUxM
LCAmZnJlZV90ZXh0X2FyZWFfcm9vdCwNCj4gJmZyZWVfdGV4dF9hcmVhX2xpc3QpOw0KPiArfQ0K
PiArDQo+ICB2b2lkIF9faW5pdCB2bWFsbG9jX2luaXQodm9pZCkNCj4gIHsNCj4gIAlzdHJ1Y3Qg
dm1hcF9hcmVhICp2YTsNCj4gQEAgLTI0MzIsNiArMjQ1NSw3IEBAIHZvaWQgX19pbml0IHZtYWxs
b2NfaW5pdCh2b2lkKQ0KPiAgCSAqIENyZWF0ZSB0aGUgY2FjaGUgZm9yIHZtYXBfYXJlYSBvYmpl
Y3RzLg0KPiAgCSAqLw0KPiAgCXZtYXBfYXJlYV9jYWNoZXAgPSBLTUVNX0NBQ0hFKHZtYXBfYXJl
YSwgU0xBQl9QQU5JQyk7DQo+ICsJcmVnaXN0ZXJfdGV4dF90YWlsX3ZtKCk7DQo+ICANCj4gIAlm
b3JfZWFjaF9wb3NzaWJsZV9jcHUoaSkgew0KPiAgCQlzdHJ1Y3Qgdm1hcF9ibG9ja19xdWV1ZSAq
dmJxOw0K
