Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24C76E4F42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjDQReC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQRd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:33:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C242BE76;
        Mon, 17 Apr 2023 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681752837; x=1713288837;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hc4XMUpGci705ura12GTcGU+9TbX9UmfMlkCe+GLzcE=;
  b=b2iWnSamDQwZ5G8fNKgd6pH57PXlSG+D8bgUyBCcK8j2TED/skawHW8O
   KsxvBrJ9tAGS2fLAeRcHxNcv1fiZXgt7LymRsD6zzsO+BHY++WMihaDJg
   SxmwgoejGZbkPWELIrTlZYkAZ/HBttWXNfLITFmvktC093ie+uuZFqUA5
   7KoJjp0rVgeA6gcqplnekeDcyGKG2GjBUrdGCC1DmH6xIdOi3fsmKCzM7
   ULLrUq34k08blu1NE94Fa+87qN43r6bd+RR64fmnhgx6HGvOZT3jHV1jV
   HkTFmsw1EHmJh/N5PkzW43eX+/gWKhGWEB8PxqflDVc3RCbMDx30X9iv+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="407850518"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="407850518"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 10:33:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="693298746"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="693298746"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 17 Apr 2023 10:33:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 10:33:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 10:33:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 10:33:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj58p503tBG/iKuMrgg5enfKO6d2pnn9g34wHUJ1LEbYxrfTY4V73/R+bkamNZkQWIw+a4pf+TMUBeWBjYB5LGk58g7A4/staHcv8quFVTNhaMUu0mr2DhcDKrmYhlhTExHuqgU8h4mkwNG5oKQjrfhiaHoT5+gP3sX57QHcmBYATJ2LWIOqnGsf2PzqOiAOhJfatjdylp4P/FWSCxCyYY5biq0KfBlbbsQP+4EBS7iYyA+iEqyhw6F5P07mtfY1JO0mQCwKYhW4VRvlryR6Bw2cClUP5r0YICwzvvgN/DPJhlnTYCSoBwfzfh1IOEn3Q6PFSZTBZuLsV6TkCg4w0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc4XMUpGci705ura12GTcGU+9TbX9UmfMlkCe+GLzcE=;
 b=gaZmETtdNqvCzfngbR8SHvNZv2vY1L2OJN5grTIIPol5R6qMQFuK2gzaAzftlkaKcFPJhUcnqczfPb5MwkjjTSpRdULlmlxCqFLIyQ1RuSwNd9vNWj6mBA5S/u2IfR67DY3l7rPdNb/ZJfsnjEx2RLYfBOsTBcBcAt1xbh/i24vWSeWsGVI2NH9mrKbJLiCkpwx8FQ2ZU94pEkMmAFzrQLem8urlNV0GerYRr2bz3F6xcD6kHMmddLW/ACzFZej51yzV2NWub388ot6W+GZONz1N1l11cX01owcaM4b6HxYTsasZVY39UoyKAHQpECDPXkvyhv7TKvdAR/Er7ISDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM6PR11MB4755.namprd11.prod.outlook.com (2603:10b6:5:2ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 17:33:49 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%7]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 17:33:49 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "prarit@redhat.com" <prarit@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "song@kernel.org" <song@kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "david@redhat.com" <david@redhat.com>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "petr.pavlu@suse.com" <petr.pavlu@suse.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Hocko, Michal" <mhocko@suse.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [RFC 2/2] kread: avoid duplicates
Thread-Topic: [RFC 2/2] kread: avoid duplicates
Thread-Index: AQHZbpIfw1JZFbYun0W79Ekz4hQQJK8tdWMAgAAKagCAAkiXAA==
Date:   Mon, 17 Apr 2023 17:33:49 +0000
Message-ID: <be5182b65384f6a7667c239134037649a468033d.camel@intel.com>
References: <20230414052840.1994456-1-mcgrof@kernel.org>
         <20230414052840.1994456-3-mcgrof@kernel.org>
         <ZDuP3OCzN3x4NxRZ@infradead.org> <ZDuYmPB5oqKQLcQd@bombadil.infradead.org>
In-Reply-To: <ZDuYmPB5oqKQLcQd@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM6PR11MB4755:EE_
x-ms-office365-filtering-correlation-id: a1c1a629-d92f-43ba-d698-08db3f69e79e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /DjnfpgVxwGBIW4glBEHcIjJAhWGmpw3KKI1BZZzVkDOZQ7ZHnW/e0U7TzryWIGmqLyVf08m9NF4N6Lgr8GH8345VxO7+mfZK8XagZHLrokJwnQ1b6H16x2vh158fXgEpVGi0FaNVNH5rBawxvheJ0b/AWCzE0inu3pD8Uai7ExDGv1CzpXO353Aelo5ex/0BQcw0bbX7SYiBlwXhznWFvVckyqB12ozGfdlrnQxfDHLYWIvKJtgJjX0YTUOAnB7UT/Uq6ylWzfqC7/tQk2UOn9pFCgJZjXa67F3rhHo0gQfVYOCSVo1Rv6S6NNXyOm25eDZArPUykXm1K8Ih+sdg7nNZDl0J38i5H6CAstm5iiB3Mvf1ppbbCc+4YscAXJA3sMS0Lca4/7yeiSBBmQdIvMJArgRh2mfFbps2txCur3obUoo5J8Yu7O7c/+8fStZllND2MzKgbXidUYwgQR3nffii6r65WTPkP+Nqi3esm77/27MlpJedHGo2ySw5urFRQtRTvai24lKd7k6SAfcd0EToIMJunytxNYRXq/vcn9M3zDhR+G1yEqxPm4/b4mPVKfc2KHGxu/9r3uoB8/JyFsgpn6b+9DFYfIArPYsG7qyB3X9oXqhrCT6bAEEYG3e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(38100700002)(8676002)(8936002)(122000001)(38070700005)(5660300002)(7416002)(2906002)(36756003)(86362001)(478600001)(6486002)(71200400001)(54906003)(110136005)(186003)(2616005)(6512007)(6506007)(76116006)(66476007)(66946007)(66446008)(26005)(41300700001)(91956017)(316002)(83380400001)(82960400001)(4326008)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cndpOVUyRUhxM1o1ejZielZ2dlRiajl1cnd1UTBmZVNkSEJTZmEzeWhKbDBs?=
 =?utf-8?B?NU9NeVBUQ0lKN25kVHNwZ3VGaTZoWHBVeHhIcTlsSnljdU9uOU9MaWUxTE9O?=
 =?utf-8?B?RFR4ZkxFVFJ0R2NGckp0Qi9CemlQd0d6KzlrUzl0NnJ6Q2ZCZ29CVWI4RnpI?=
 =?utf-8?B?dmhTSHI3UWt2TXNKZmI4bzRzOGtzbHJXNTRkUFh5VTFQc1NLZWg1L3hIbk5N?=
 =?utf-8?B?Z29qOEE0R20xRGo0V1FCNnozbnZCem43Z09xYkpXaElhdm4xaS9Yejg2ZVJT?=
 =?utf-8?B?TnhUT1RRMnV2NDhST0dYanUwL0ZWQjVBYndrWUN2TnZjSkd2M2hWVG8vSE9I?=
 =?utf-8?B?c3Nad0R5bk1RVExwa1VZd1E3ODVEWG9wcy9NL3RTRmUvU0dsb3hrK1ZIaDdu?=
 =?utf-8?B?Y0tkblR0Mk8vN24yRkhQWkgzRlVnY0NuRlE4M0NsUW5YVzNRaGYvZ1A1S1Fv?=
 =?utf-8?B?NHBrV2VFbjZTTFJNTUl6dXVlcVJPeTlnMHcwMUNwVnVOVDNJb05MNkUxbXI0?=
 =?utf-8?B?YTJRMXZGRGtCSTQzN1M2c25xUHdqVmd3K0R2MkMvWUR6UHQzUFdhZ2s2ZnZK?=
 =?utf-8?B?bng4RU91UklSVnR1NmIzaW1rQkZuY3pkdTVaa1B4dmoxY2F2MUtuM2cyVWJv?=
 =?utf-8?B?NUpLeDVsUW04bUxJUm91VnFoNWtGd3h5a1d5eWhtL3grSGI4dkpRZEUxSGxu?=
 =?utf-8?B?THk1VVZIbUVwNElZcFZHTkFHWXN0Y2JwYy9VZlRYSTRkV05wemhITzg4T1Rm?=
 =?utf-8?B?V0VVN0Ryc3dBUGc2VDFMakNwQ1N4N0FMMVdhRHNVS0JPekxxNjVUVmlRNXFO?=
 =?utf-8?B?MnRoSzlzL3d1SFJRbks3VldVa1hTTHNYckhLVFAxRUdMUENOOUxpSThBZHJv?=
 =?utf-8?B?R3NtV3dNMWM0UUI3NzRQaUxhdlpzNnR4YWlLdEdiWUNzR1p4ajVvNVFLekw4?=
 =?utf-8?B?SGt2cnRlS1ZWK2treXRkZkNnRVBPTkxZL3R1T0VRU09HOHVJTFAvTXhQSktK?=
 =?utf-8?B?SzlnbCtoeXZHTVFPdmt2Z0M4V09FT3BaY1hJMk1mSDBXL2o1ZjZNdnpLUHBk?=
 =?utf-8?B?MmxaVHpSL085RU5KUStnV2tpUkRsWnU4Q3hNZVJWNE5KZlAzcVcvY2tkUkpC?=
 =?utf-8?B?TGlEZC9mbGVMcklVVEN4NklvdFRFL2tnQkJhaGMzU3pNTjZ4eHZpVGxhRTVa?=
 =?utf-8?B?OXRza0Qzd1QzcUoycm1qLzE1Q21LWkFMeHJBcm8vUlZYZ3NYVy9INmVhZCs2?=
 =?utf-8?B?Mm9ZTExTa0VZRmJoWWVXNCtxR0IvQ2x6QktqZElOMzl3Zmw3d2pmcHQ1UllV?=
 =?utf-8?B?K0JOZDNpdlAwenlLTytuc0ZhR2JSM214YkFvRGlLT0FGcWhqdGpBK1F0Sjc1?=
 =?utf-8?B?UkhLWURhMnZMNm13NUNUVHdFclAwekZmbkUyMjR6SnN3K2FoNVUwNkROS1dS?=
 =?utf-8?B?MGxuWVhyZlJ1UWowTkZyMjFRUWg2WTd6SGorS3k3T0QzSVkraVd5R3hHUU12?=
 =?utf-8?B?Z3IweDZ0cm5MSXYybER1Q2JhTWJUNDhSWXZmSmREbUs4ZGw3NzhrcjdDMHR3?=
 =?utf-8?B?R1RYOEVwTndQU1BFRktUVTgrSFEvaGtWQ0xpWnhBcUNNa2hyenlLeGZPVjd6?=
 =?utf-8?B?Q295UndmejdwdnZsNndjdkxNRFhXWEVCNVI4dVFEYXMrLzJkWEhpVVh1MUs2?=
 =?utf-8?B?Tis3UDlsQ0xUNnZkdFEybERRdlQrb2RKZWJPYmdZRzMxZkpPVlFXdHdsQ0lD?=
 =?utf-8?B?cVIzdHNGYjVTdXpjRG45L2RYRFpjcjk1NURhN2hwYnMxOTRadG14b3BBbTF3?=
 =?utf-8?B?WnJ6eFhsZVhMTGc5aDNoOUxZQkFzdEtPS29iUW52OGVrZVM4NE95MzJHWTVy?=
 =?utf-8?B?ZElXUm52V21qMzFSRmtNQ0p4YlYrcW1mVDhhbElaRklBc01hNkxlMlM4d2I0?=
 =?utf-8?B?RldJV0RvNWp0VUh2elZKZ05lRTNEd01ZbXRueHNuZW56T3AxNitzaVMwbEt1?=
 =?utf-8?B?UnFxMDZQM3ZHaTJtRkVtY0plSGxlK09OWEJrRWNwNlc0OUhaOFdpOEs2enho?=
 =?utf-8?B?OWxlSno3ZXhaL3VTeEZKMDRJL3ZFWE9MdnYzK2pkSEV5akVVWGRSRGlhcng5?=
 =?utf-8?B?ZkZwRVVkc1o3N3A2aDNrRm1jRjdhT05SL0xzeXFOS0ZBNXBDQ3NWeWZFY1ky?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F03AC1A718F45D498F08AFF0B5F9B80D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c1a629-d92f-43ba-d698-08db3f69e79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 17:33:49.2968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNLBBZZmU0sT9P+oH//chK1bHEf72+B3n/DpRa40FbNymnQRUnvWZoeeypqaGizfGTpJ8aYI5E/OD8iHqgkbnVvqEmvVvAx6ymHoCBiTvGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4755
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA0LTE1IGF0IDIzOjQxIC0wNzAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3Rl
Og0KPiBPbiBTYXQsIEFwciAxNSwgMjAyMyBhdCAxMTowNDoxMlBNIC0wNzAwLCBDaHJpc3RvcGgg
SGVsbHdpZyB3cm90ZToNCj4gPiBPbiBUaHUsIEFwciAxMywgMjAyMyBhdCAxMDoyODo0MFBNIC0w
NzAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3RlOg0KPiA+ID4gV2l0aCB0aGlzIHdlIHJ1biBpbnRv
IDAgd2FzdGVkIHZpcnR1YWwgbWVtb3J5IGJ5dGVzLg0KPiA+IA0KPiA+IEF2b2lkIHdoYXQgZHVw
bGljYXRlcz8NCj4gDQo+IERhdmlkIEhpbGRlbmJyYW5kIGhhZCByZXBvcnRlZCB0aGF0IHdpdGgg
b3ZlciA0MDAgQ1BVcyB2bWFwIHNwYWNlDQo+IHJ1bnMgb3V0IGFuZCBpdCBzZWVtcyBpdCB3YXMg
cmVsYXRlZCB0byBtb2R1bGUgbG9hZGluZy4gSSB0b29rIGENCj4gbG9vayBhbmQgY29uZmlybWVk
IGl0LiBNb2R1bGUgbG9hZGluZyBlbmRzIHVwIHJlcXVpcmluZyBpbiB0aGUNCj4gd29yc3QgY2Fz
ZSAzIHZtYWxsb2MgYWxsb2NhdGlvbnMsIHNvIHR5cGljYWxseSBhdCBsZWFzdCB0d2ljZQ0KPiB0
aGUgc2l6ZSBvZiB0aGUgbW9kdWxlIHNpemUgYW5kIGluIHRoZSB3b3JzdCBjYXNlIGp1c3QgYWRk
DQo+IHRoZSBkZWNvbXByZXNzZWQgbW9kdWxlIHNpemU6DQo+IA0KPiBhKSBpbml0aWFsIGtlcm5l
bF9yZWFkKigpIGNhbGwNCj4gYikgb3B0aW9uYWwgbW9kdWxlIGRlY29tcHJlc3Npb24NCj4gYykg
dGhlIGFjdHVhbCBtb2R1bGUgZGF0YSBjb3B5IHdlIHdpbGwga2VlcA0KPiANCj4gRHVwbGljYXRl
IG1vZHVsZSByZXF1ZXN0cyB0aGF0IGNvbWUgZnJvbSB1c2Vyc3BhY2UgZW5kIHVwIGJlaW5nDQo+
IHRocm93bg0KPiBpbiB0aGUgdHJhc2ggYmluLCBhcyBvbmx5IG9uZSBtb2R1bGUgd2lsbCBiZSBh
bGxvY2F0ZWQuwqAgQWx0aG91Z2gNCj4gdGhlcmUNCj4gYXJlIGNoZWNrcyBmb3IgYSBtb2R1bGUg
cHJpb3IgdG8gcmVxdWVzdGluZyBhIG1vZHVsZSB1ZGV2IHN0aWxsDQo+IGRvZXNuJ3QNCj4gZG8g
dGhlIGJlc3Qgb2YgYSBqb2IgdG8gYXZvaWQgdGhhdCBhbmQgc28gd2UgZW5kIHVwIHdpdGggdG9u
cyBvZg0KPiBkdXBsaWNhdGUgbW9kdWxlIHJlcXVlc3RzLiBXZSdyZSB0YWxraW5nIGFib3V0IGdp
Z2FieXRlcyBvZiB2bWFsbG9jDQo+IGJ5dGVzIGp1c3QgbG9zdCBiZWNhdXNlIG9mIHRoaXMgZm9y
IGxhcmdlIHN5c3RlbXMgYW5kIG1lZ2FieXRlcyBmb3INCj4gYXZlcmFnZSBzeXN0ZW1zLiBTbyBm
b3IgZXhhbXBsZSB3aXRoIGp1c3QgMjU1IENQVXMgd2UgY2FuIGxvb3NlIGFib3V0DQo+IDEzLjU4
IEdpQiwgYW5kIGZvciA4IENQVXMgYWJvdXQgMjI2LjUzIE1pQi4NCj4gDQo+IEkgaGF2ZSBwYXRj
aGVzIHRvIGN1cnRhaWwgMS8yIG9mIHRoYXQgc3BhY2UgYnkgZG9pbmcgYSBjaGVjayBpbg0KPiBr
ZXJuZWwNCj4gYmVmb3JlIHdlIGRvIHRoZSBhbGxvY2F0aW9uIGluIGMpIGlmIHRoZSBtb2R1bGUg
aXMgYWxyZWFkeSBwcmVzZW50Lg0KPiBGb3INCj4gYSkgaXQgaXMgaGFyZGVyIGJlY2F1c2UgdXNl
cnNwYWNlIGp1c3QgcGFzc2VzIGEgZmlsZSBkZXNjcmlwdG9yLiBCdXQNCj4gc2luY2Ugd2UgY2Fu
IGdldCB0aGUgZmlsZSBwYXRoIHdpdGhvdXQgdGhlIHZtYWxsb2MgdGhpcyBSRkMgc3VnZ2VzdA0K
PiBtYXliZSB3ZSBjYW4gYWRkIGEgbmV3IGtlcm5lbF9yZWFkKigpIGZvciBtb2R1bGUgbG9hZGlu
ZyB3aGVyZSBpdA0KPiBtYWtlcw0KPiBzZW5zZSB0byBoYXZlIG9ubHkgb25lIHJlYWQgaGFwcGVu
IGF0IGEgdGltZS4NCg0KSSdtIHdvbmRlcmluZyBob3cgZGlmZmljdWx0IGl0IHdvdWxkIGJlIHRv
IGp1c3QgdHJ5IHRvIHJlbW92ZSB0aGUNCnZtYWxsb2NzIGluIChhKSBhbmQgKGIpIGFuZCBvcGVy
YXRlIG9uIGEgbGlzdCBvZiBwYWdlcy4NCg0KU28gdGhlIG9wZXJhdGlvbnMgYmVmb3JlIG1vZHVs
ZV9wYXRpZW50X2NoZWNrX2V4aXN0cygpIGFyZSBub3c6DQoxLiBkZWNvbXByZXNzaW5nICh2bWFs
bG9jKQ0KMi4gc2lnbmF0dXJlIGNoZWNrICh2bWFsbG9jKQ0KMy4gZWxmX3ZhbGlkaXR5X2NhY2hl
X2NvcHkoKQ0KNC4gZWFybHlfbW9kX2NoZWNrKCkgLT4gbW9kdWxlX3BhdGllbnRfY2hlY2tfZXhp
c3RzKCkNCg0KUmlnaHQ/IFRoZW4gYWZ0ZXIgdGhhdCBhIGJ1bmNoIG9mIGFyY2ggY29kZSBhbmQg
b3RoZXIgY29kZSBvdXRzaWRlIG9mDQptb2R1bGVzIG9wZXJhdGVzIG9uIHRoZSB2bWFsbG9jLCBz
byB0aGlzIG90aGVyIGNvZGUgd291bGQgdGFrZSBhIGxhcmdlDQphbW91bnQgb2YgY2hhbmdlcyB0
byBzd2l0Y2ggdG8gYSBsaXN0IG9mIHBhZ2VzLg0KDQpCdXQgZGlkIHlvdSBjb25zaWRlciB0ZWFj
aGluZyBqdXN0IDEtMyB0byBvcGVyYXRlIG9uIGEgbGlzdCBvZiBwYWdlcz8NCkFuZCB0aGVuIG1v
dmUgbW9kdWxlX3BhdGllbnRfY2hlY2tfZXhpc3RzKCkgYSBsaXR0bGUgdXAgaW4gdGhlIG9yZGVy
Pw0KQWZ0ZXIgbW9kdWxlX3BhdGllbnRfY2hlY2tfZXhpc3RzKCkgeW91IGNvdWxkIHZtYXAoKSB0
aGUgcGFnZXMgYW5kIGhhbmQNCml0IG9mZiB0byB0aGUgZXhpc3RpbmcgY29kZSBsb2NhdGVkIGFs
bCBvdmVyIHRoZSBwbGFjZS4NCg0KVGhlbiB5b3UgY2FuIGNhdGNoIHRoZSBkdXBsaWNhdGUgcmVx
dWVzdHMgYmVmb3JlIGFueSB2bWFsbG9jIGhhcHBlbnMuDQpJdCBhbHNvIHRha2VzIChhKSBhbmQg
KGIpIGRvd24gdG8gb25lIHZtYWxsb2MgZXZlbiBpbiB0aGUgbm9ybWFsIGNhc2UsDQphcyBhIHNp
ZGUgYmVuZWZpdC4gVGhlIGNoYW5nZXMgdG8gdGhlIHNpZ25hdHVyZSBjaGVjayBwYXJ0IG1pZ2h0
IGJlDQp0cmlja3kgdGhvdWdoLg0KDQpTb3JyeSBpZiB0aGlzIGlkZWEgaXMgb2ZmLCBJJ3ZlIGdv
dCBhIGxpdHRsZSBjb25mdXNlZCBhcyB0aGlzIHNlcmllcw0Kc3BsaXQgaW50byBhbGwgdGhlc2Ug
b2Zmc2hvb3RzIHNlcmllcy4NCg0K
