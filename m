Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6D6724F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbjFFWSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjFFWSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:18:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625D81715
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686089880; x=1717625880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R4dml10zYRNEx38oSNHX21+Zra7CU0K1VIbRKfO9aAI=;
  b=XGRGt9t9OQQ7j++veUZH03dfTeMAleFsQgFA6P/lKQiNdnXlw1Pk5pJ8
   vivJ60NkJLf3yfPJryhrATmr/avFcmxXZl1fWbQy5QijgOOoRIZmmaLAJ
   VCXnzT9QzK10e6jDGszL+nRbef/MlOBq10d307BHCnoLAPgJBBSrjXGxT
   l9XfVuZwGwQ1tF9pR5Pye/2D0rqa7oJ78YSN5gg6uYgSxALsCRO2XCmVA
   DVc+aXqtpc84IEFk5HYyfvbwkL6ekua4C/nwUwOQB4hYBh49GffHZ5yth
   mkdPykRcI35U4b1npeELs8STQ45nAcV8i1FD0Rcb7Rl7Yo3vCDqt+AI8I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="360137114"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="360137114"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 15:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="703359033"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="703359033"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 06 Jun 2023 15:17:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 15:17:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 15:17:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 15:17:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a51AnCdyrAHsE/2Qu53GGtyp/LXeiQh4reP7oO53gmXV/dpuHmL8Z4nqUrGi/mWWt224n9UXDzFMwuaI4lIAHRcMHZOEKtgAXHpD9430hY4Tlq4fRcZcEHNdreo3UmN5bwT/17C7XwrdktIRMAIdMArhgMvy5j4alNKxB10unHdi2YNwGxZjB/nF+mblbexuNilfr5Jf1s2Zshkx0ZnP0rOTc1qO2fVBp+6ZtJ535/xHAOXc/leLS8e/+w9pI+OESbV9eYDDDJ+LqLgJWaFiz1+F5bT+tasHr72HwcSn01AtWdzSaU+gXAfB4PHhTg1MVzKXsFCuxM5pdXFV8eng7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4dml10zYRNEx38oSNHX21+Zra7CU0K1VIbRKfO9aAI=;
 b=iTmHRjSSu3b74rRmStuU5h/Q98p+Q0GbfzOcAuFjpPrnSnnwuCxVhzlUtEKyg2q+22i5f3f5XYNThDQUVlXvbc8t902d5c4wpn8Spu7EDbNknhji2Qfe+QJB25bvgATN9xsf5PEAXhSftj8rAFFTVO9SrmaxLWh0reHDBYZ0Z/51rpRGaAhHEm2AuIM6Rrxe5t7fDvTa+0ecm8KBtInglRhpoGJPBMv8I3o+jjSmh1Juj80jg6Gi6K/MhRUcSPrwIOSLfTFE40ddGmy8SxcTkFXnMJRojL/XekKdOge//uVPQWcL3drd8LraNO4l2MM1TOJ11sY2ayTZZqciu3rqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 22:17:54 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 22:17:53 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH] x86/tdx: Explicitly include <linux/errno.h> in
 <asm/tdx.h>
Thread-Topic: [PATCH] x86/tdx: Explicitly include <linux/errno.h> in
 <asm/tdx.h>
Thread-Index: AQHZmCim8jOtX6SwhEChddwFpeg98q99wC+AgACY9oA=
Date:   Tue, 6 Jun 2023 22:17:53 +0000
Message-ID: <df89f1c66059e717e9a66e314da24f939cc3eabc.camel@intel.com>
References: <20230606034000.380270-1-kai.huang@intel.com>
         <c84707e6-4f74-dc89-6243-63a72e86c62b@linux.intel.com>
In-Reply-To: <c84707e6-4f74-dc89-6243-63a72e86c62b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA0PR11MB8354:EE_
x-ms-office365-filtering-correlation-id: 69505a56-9b87-4329-9b42-08db66dbdf75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fIXXt5ih9vc+WJWKX449AkqHCeuePOx74CH/ELNDGEB7s3XH9EJAhekb7AE+VrzAVmchxdvjm1oTFT7ZgtNzhUyHtMpt+hmdqa30ghezQU+YGEfFkD4OKWZWuJQjIdHTgf3hLTBojluCd77ITf1Nlzv2VzUa4BPW1GgBB5XWlLWEMxNaaS5xFInfA7xJFy9+z7+KoqHXKTxeQ1S412En/5zcK0VV40vkzxAKeyaYJuMTfN+1O9dxXaOKmRcl+bxOjhVc435EcZDFqPtV3HnSIBnEIBMidcmH2qeeomDAEzwN6/tE7sMQbgoxMInXLowEExQNdSuRBN8i6n4jIVtm52gQyuY4Nz18JG5zBmH7qnoEwfENDGtGCMsG7T8Nlzmy2wNp0JoLK9KzdwUGFpac92j2N4yTyPkDgQIm2RmKzJlMIHaHCecaOXcfVA17ETc1HTgoBuLjMbp1tNI/A4hZrzJuVfrcjA2Ppd6nh1SuXgHvCrYlg2g/6d6Lp872snv5tMmu7oVbxCuPjaZNLu+uJaPGK4sJjLa9iWuACJT6ONNsr8h2ii4I0gnKg679CXFt+FnHJNWMWaAF/H4SCR+c1OW0ssxzRhckXvDCFcQ59ErW0xkv6GpGfQAbnCVmEjZn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(66476007)(66946007)(38070700005)(91956017)(64756008)(8936002)(66556008)(8676002)(76116006)(4326008)(66446008)(5660300002)(86362001)(54906003)(110136005)(316002)(41300700001)(38100700002)(478600001)(2906002)(4744005)(122000001)(82960400001)(71200400001)(6486002)(26005)(53546011)(6512007)(6506007)(36756003)(186003)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjVBcXBEbkNFd1BRVjIwYUd4YTNWbDVwalp1RTlwaUdJZXZ5UkUvdEVEbUt3?=
 =?utf-8?B?UWIzMW1lSHRNeDhZbGtuTHZKMkpFZERqd0dmMm4vcjl0U1IwcWpuSTFQNE5L?=
 =?utf-8?B?aEpsSW8vS2hsQ2hvWGxoQXNqOE9jWjBZMjZiT1A3bU8vV3VaL1ZIaUNiZWM0?=
 =?utf-8?B?L3NKa2VPNjUxN0llU0EvL2hDbVVMYTBHTUNEOC9iUFBWVlVmODh3OEh0LzRs?=
 =?utf-8?B?VFhYaEgrdGtnaG1WRUpndVdmWXZLU3RoZ0o3amc0MjVLZ3ZWTXNBQzBQb1hq?=
 =?utf-8?B?T2c3UDVIdUIyWTZ3VkU4L1ZxR2I1TmVyWjFUSzEzSDZHNzZEVGplWHozQUJB?=
 =?utf-8?B?ajYrbktPTzlMaXVuVEJWYnZKZnVOR29mQng0cUo0NE4zMnZSY0ZVdzAxVGxQ?=
 =?utf-8?B?eEYzOUVsbzU0dHM0WkRqcU5sc0wwbkovUEtlcm5Gem1lZXlRSXFWM3dwdmtD?=
 =?utf-8?B?TndNOHVTT1ZZVDZST3UwOVRiNm1WTkJOcS9TdGcvaVMyTjZDcnp2TC9SaTFZ?=
 =?utf-8?B?UjY4ajFNSzNrMmhsQmJnTmhvOWVGekJkVUJzZE9aZlVFMC9CNkFkZ0tCa3lp?=
 =?utf-8?B?dGpCR1lhSzBCZHYzY0VWMnZKcHg3cXN5VlhvQ2VZNGl3Q04wVFV3OUFGa3hE?=
 =?utf-8?B?ZXkwaUNJTzBSZkg1QWhEcFFSZzVFb1VZaVZvSzNtRWNZT1lCRS9SUXVyRS9p?=
 =?utf-8?B?cUh1RUJ3b0JDUlZBSThhYkY1R1JuL1VjaGhEWGFaQXhrS2NwRGVWdmMySVlY?=
 =?utf-8?B?Q3dmR1IwMGp0R1hLZXV6Smg1clUybkhSWFN0cVFXdTJJOTJDNjFrcWtCNEZh?=
 =?utf-8?B?N0QxeHlDVm9LTzRoRHhtVHJzczAzWE4xOE9xVlE3NW1LNE9UZjl1bmVkVjVS?=
 =?utf-8?B?YUZOQlRuZVd0a3Y1NzBkSkNrZzF0MVRoclJ3MG9SRDZMdEkycHNvYUVGWkFU?=
 =?utf-8?B?U29FVjl0S245Zm5sL0Q1eDFmcytHR1M3N0U5Q05ON2NVVERNTm1sbnllSTFX?=
 =?utf-8?B?Q1RYaDdvY0JvWC9WbE43OUJLcitZWm1PN2JxbjFNVjZ4bEJabG9XS2ZjaVhQ?=
 =?utf-8?B?MnprS1c2NkVIT3QwTkhWUmNVaTdrbnNSTEV1K0JSdERuQitwajI3b2JmaVZV?=
 =?utf-8?B?clg5VThicWQweHd1d3ArOEk3TmM3Ylp4VUhFTWFkSEhDMXdDeFkwTG84RVdG?=
 =?utf-8?B?QUx5K0RNcmJMOHQrY3hscmZ5c1JDdFhIVlM3L25QWForak0yTW4yUFNMaysz?=
 =?utf-8?B?QlpZUjZPWjZ5SDFTOU1MZU94Vk8zUG5tcE1HMWhYYjd4MFNFd0FoME1yTlQ5?=
 =?utf-8?B?d0lPU1hRUlFwM29TZk1VdjY2RHBKNVdwRzFjdU1XaGNscmhFVmlKL0VSbERV?=
 =?utf-8?B?VG83Tlg4WHFnd2FWQlBGM3BoZ2Z1dWVtdzhzTjVRQnB0NjROak9uU3VqRld0?=
 =?utf-8?B?TUFzdy9JYWdURWpHaFJWcjBUdU1EQmVHV0xCNm04eHlFK08zaFFPZDNBckVE?=
 =?utf-8?B?NnJ6U3l0NTR0b2hhcG9pbnNkUG1PWmV2Qm1jdEQ3clhicHp1dVA2NGU3L1Z6?=
 =?utf-8?B?YXlNNGR4b2liZ2phZkZNM2t6aWNGTkFGdnhwdjFPT0lPdDI0QUdYb0VpUmdl?=
 =?utf-8?B?QlMxeGdFQTJ5UURNaWJJL3pGQ0pnd3FhQ0dwR25NMkhqNVZSdlN3Q1hUQ0VM?=
 =?utf-8?B?ak9jMWdXWWdqdWxKTUxHUTNFVFRQMGRmOGpyOXF2Z1M1Z2VIN0pwb2VCWlhx?=
 =?utf-8?B?ZXhhOTBCVmJWbVEwSFpTSlcvZG9wRFluZmROQyt6bGx0RytvcHFMT3NJM0Ir?=
 =?utf-8?B?QWdhSmRiQzY1QUxVR0h2MUdMN2ljZXMwZzB5TUdyQjd5TUpsR2lORkR3Q3RE?=
 =?utf-8?B?NC9MdXBzWlNFZTA1ejMxZFpXTklieitDUWVRYmpoODdCYll3WUpTVFZUaHNi?=
 =?utf-8?B?M244ZlFCRkxxak9pT1pIUUZTOWJNcExRamt5Y1NZemZnVUtoNHJRRzRUL3Zj?=
 =?utf-8?B?NnRJN1dUL1pLRm80M3lWT09hcFhBSVdFOEtJSDF6UHZuV1dXWXdwUW1MNGcr?=
 =?utf-8?B?b252QW8wL0FoTzA2NWdKYngrTFNnbXJlMmIyU053cWRjNGNtWlBFMEt5Q0p0?=
 =?utf-8?B?M2hDQjRZWlRJRmFjTTlhejVJclNqUy9peHpSMnMyaGZ0MnMvcE14YnVFZlBh?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE02D84CF38A464FB2B49D048B10D5E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69505a56-9b87-4329-9b42-08db66dbdf75
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 22:17:53.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvDyPkzJlwPrQnozgaXVe8EqYbcvuX0aANqH3eRS7Y/pmh2BbJ3ekgd4w7UODdac8ZVMXcizUEh315PfC+KCoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
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

T24gVHVlLCAyMDIzLTA2LTA2IGF0IDA2OjEwIC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gDQo+IE9uIDYvNS8yMyA4OjQwIFBNLCBLYWkgSHVhbmcgd3JvdGU6DQo+
ID4gQ3VycmVudGx5LCBpbiA8YXNtL3RkeC5oPiB0ZHhfa3ZtX2h5cGVyY2FsbCgpIHNpbXBseSBy
ZXR1cm5zIC1FTk9ERVYNCj4gPiB3aGVuIFREWCBndWVzdCBpc24ndCBlbmFibGVkIGluIHRoZSBL
Y29uZmlnIHcvbyBoYXZpbmcgPGxpbnV4L2Vycm5vLmg+DQo+IA0KPiBNYXliZSB5b3UgY2FuIGV4
cGxpY2l0bHkgc2F5ICJDT05GSUdfSU5URUxfVERYX0dVRVNUIGlzIG5vdCBlbmFibGVkIg0KDQpJ
dCBhbHNvIGNhbiBiZSBkaXNhYmxlZCBieSAhQ09ORklHX0tWTV9HVUVTVC4NCg0KDQo=
