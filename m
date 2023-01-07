Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5D2660F53
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjAGOHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjAGOH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:07:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1F49FF0;
        Sat,  7 Jan 2023 06:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673100448; x=1704636448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DrrdYOVgU6rGuaQhfhqCdqs0uxDpirGFMyLmjmRRl2U=;
  b=EOFxbPx1GJHdhKJcHx/NmQv4T3GnyPjONjEdNi3i6pLspIlfdaMTGqGI
   hOUqXEsGhV1UtLWATJzvNpJKOmkEf5DUrkKELAqFDkp4/w74jzLBuKLmL
   gRaMrNLYHNv+zRPHF6A/cpyBDDC9QA8mvaMSbdcjV/BCxDSVJPC/IenQj
   L4FYw+/V5nRu+Om1/Ljq1jUsHZwdfH2w4LlC6TYt616O36xF/TrX3z5OY
   1IIPj4p5k4tHMfuwoc5Ij70W8vlgKBskxaeNvgQoqLz41++t1g0UmdeSZ
   MyfeUa2gOrfBOU9jbodCFwQGBJE5LKqgusYhXNBLoBzCcq0RLMPSt3VBV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="302338164"
X-IronPort-AV: E=Sophos;i="5.96,308,1665471600"; 
   d="scan'208";a="302338164"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 06:07:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="686753839"
X-IronPort-AV: E=Sophos;i="5.96,308,1665471600"; 
   d="scan'208";a="686753839"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 07 Jan 2023 06:07:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 7 Jan 2023 06:07:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 7 Jan 2023 06:07:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 7 Jan 2023 06:07:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boBw6DQK31UqcQHDK5Yze8L2fzAmKYd3ZhmcnhgwwlvgNsI/Sm5VnLc3bkVNcI3d/lbsvYYF0guWXbqvzCxFLm98YVRARJj63toUAYZeoEr1u9oDcLCwEtdjyImfb6EQqmZseYj1izKPJ4EAp454muIn4vQy7Y8l1ep0fgrLsaBRYWvD7l0RlVRoUdZ/pF8itcsfTosrQam/CesVc/l+x+pfq2zSuJTWR0l4B14HCr4RxZU4zeHv7c17ScjcYyZC2t+BR5tIBiLBb2lOeVxWpdlG3CnioMz9p0N+oKtNU757GMgO9buvmTB5nABxtxfj6REu7TaGteIjGZvBeXkzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrrdYOVgU6rGuaQhfhqCdqs0uxDpirGFMyLmjmRRl2U=;
 b=HAJgGN0eU5tQr9VZdwVbf1ZSG8akePyUu+OUTyZrk7S+ZG3dRvCrlMXu36YxOTkgKuWY8OESwOman4TOgN4gHrH0OQixShbzL916Ascr+sMc97qRSLmUcqUsrsQDbs534b1rxKASF07vRn937Y1Lkw8ndxlTxWHY/vEgM+Osw+wOjkP4aF3vwqJp1mj7+HHMoAzh9pJpjo19xuA2qiVM34PTGoYTA6KOpgmHCKv1GP8OycZrepaMLOczR8Cv2ufBIIuNOlxjlv7AP2RGFUyvwihSyh+KIN87Q9XPhnXLWT69snsKVmyV1aF3ZttHoclAv+hN2xJrEQ6vlZtYF1Bftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB7073.namprd11.prod.outlook.com (2603:10b6:510:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sat, 7 Jan
 2023 14:07:21 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5944.019; Sat, 7 Jan 2023
 14:07:20 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Thread-Topic: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Thread-Index: AQHZIF1bxwQ7XEIB0EO18Lgdi7O9X66PZGKAgAAyjYCAAVIkAIAATGEAgABCzQCAAAOHgIABhjKA
Date:   Sat, 7 Jan 2023 14:07:20 +0000
Message-ID: <b046750234086000acff8e52b817d8dc7b7efbe9.camel@intel.com>
References: <20230104145831.25498-1-rui.zhang@intel.com>
         <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
         <ea9186869cca50a21efcc1a9cc4dbe5adcd1784b.camel@intel.com>
         <Y7aejeHDpLlwwYbr@zn.tnic>
         <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
         <Y7f6RhF8FuK9R399@zn.tnic>
         <d6ae35f1e72d4bb8e02f44fe6d9369f1a5f21619.camel@intel.com>
         <a375b136-c4da-0676-7a67-d2308c012b8b@intel.com>
In-Reply-To: <a375b136-c4da-0676-7a67-d2308c012b8b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB7073:EE_
x-ms-office365-filtering-correlation-id: 43752334-ab9b-4e54-7817-08daf0b87e41
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QoWaQPJn8PtLNJOSQvds9F0D4hhTu/2K5sZMEi4NhuHTJtgesWFekmydsvkN2kfidhR5ZiP0PlWf/dAFfZR6WC3SYsmvEP+XCgG3hL1mJY0X0CAsmqWXyLgeb29XGuJxf030TRCdFU7tw/DoMuTyN+dc4isPisQwNb6nQ8GJLJE8igfFOT45AYkvnkfdOa9jJAKOMpYR6DaWn97MhxCHheuHWEIBNyFexhQVwvPHr2+lo/hCKXmlfUnWSBVd5YqxGLRWAvfF5bAjBVfblM0QDh8SHSCos/9hG1vj5t7nqcKFstOuxuuQD5vIHBNEk1S+0KR+/bQDt1FlDCu2mYwaIy64hqpMjUa6EPii+ILZl/wvIEHO6M/rlKi96RhXs6v1yu2mRQM/N5qecKOQIOGD146Qs/S3y1kdzsTAHRIFZbfAcftRo+25RwoIy6nK4uWqebpjWccp87O+fDBekKfr1pm3twdAD5A9dlLDpFI9LfQyFbJRma+24FtPSitKj04zr9fgFj1uZvPnwk8D+mDIgbeZBEa+vNZSNFiQ+nNjn+FxfKNfZx/gw5EmwBs7Ebb3578uHoo2zYyHTD2eb489YzRbTcXBB6Wjk1YlhlhWvcpSiB0tGbSC3TCD4FbEFaLXmAAdU9BkL9Fy9CBeOGEELzxkzpFpkXgU64dPEoS2WYg36MRwOIz3/K0CW1zVyq8mq9dReucf7ThAJxon+241dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(36756003)(91956017)(4326008)(54906003)(8676002)(64756008)(66556008)(41300700001)(66476007)(66946007)(8936002)(82960400001)(110136005)(38070700005)(122000001)(66446008)(86362001)(71200400001)(26005)(6512007)(53546011)(6486002)(478600001)(316002)(6506007)(38100700002)(76116006)(83380400001)(186003)(5660300002)(7416002)(2616005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHYzbFlmem1wY2xRb05MeW0xM3VYVkNzekphOVdVT0JKcDlTZmpHakZGRE9J?=
 =?utf-8?B?enRuWExmYzVnR0JQRHBNTGs1aGJld3U0UlVZeUpiemtSbTYrT0g0aDdkQ08w?=
 =?utf-8?B?b2FKTHRZV3NPYlJiRGJPeUJZMFpUWWNZbnVGeWlWcnFyVit0SGUvN2kwaFhG?=
 =?utf-8?B?YnhmVVNTdHZKbjJJemxTaWxrOWdweTBBemJoeGlTUzdVRm10aWpoN1VIY3hv?=
 =?utf-8?B?bkRWZitYcHYydXQ2NmNWREszRWxsTE1NNWtjVFJEaUxzT0RDSm1vaDMvTGVQ?=
 =?utf-8?B?bnlaeVdCYUlBV0VoNG8zS2hHUU5VdFNEY2hQQlB1UU10czJEcS9HTWZSMkxP?=
 =?utf-8?B?OUZyMU5TaEo0L0o5Zmg1SmpRWklvVllRYTVqU1dvakZzSWNvZmcwRTN1c0VI?=
 =?utf-8?B?RHFOUnhQVytlcTBoYUVKeTdOSWFQYXozWWROMGxjNUNqTk1EelBMNGI2bTZX?=
 =?utf-8?B?Y09zRjJ3K3p1SmNYeDZsWWVMbk12ZWZoc0NLSGcweWQ1T0V4YjU2Qjg4QWdP?=
 =?utf-8?B?cGlxN3RQUlZiSzhGZXlMRGVEaVVWdDBiRU9BdXgvdllTVXluQ1FQcTRvbWsw?=
 =?utf-8?B?Mllybm5URFpwNkk4UkR3K3g0bnlMTUJscjJaKzRsMXlxSFJkM09ZQnUySkhp?=
 =?utf-8?B?YlRxdXdVNVlaTG1zK25ZMVRMVDhTcnJ0d1lFQWJCTVhrallwQkQrR1hHbnhG?=
 =?utf-8?B?VzladDVVMnBYM2I4Q3k4ZW1mSHc1NEZqVzJUOHZybU1RL1NETEllb0Mra1di?=
 =?utf-8?B?clJhOHJTSGx4NlowRFZ2ak9Fb2J6aHJ2RkxWcm5HQkdOM1lLUUR2TnBHSTNj?=
 =?utf-8?B?eHM4Vmc0L1hBTUx5UVNCanJXTVI0MmtMRlpuMWhyclNuR2JuckMyS1VJc25s?=
 =?utf-8?B?L0tKb1ArUmpNUFNTYThkZFNGN3dSZHpQYXcwQnMwbzd6QUFJNUgwa1F4Sk83?=
 =?utf-8?B?MWFQZnZXQkNseXZSUHpncHRFR1lIbWpiUW8vUUVzdUYrRk1WMEtYSDdvQ1p6?=
 =?utf-8?B?Q3I4cTY1WWlGS21vMzVmcVNrUEJkc1hpTGtqU2wrejhIZEY2OEVzNW4vN1ho?=
 =?utf-8?B?VFZyZmJwUlpkaVZhYXNFVnNvMUg2dlBucVJoMHJiN2plY013bHV4ZFRFdUl1?=
 =?utf-8?B?czRVd3d1RHBDbW5GM2FaYXZsOHZFeDBVWjMrMVBjUXFaejFaUjRVUHF0WWdK?=
 =?utf-8?B?dVVCdnpUV1hSNzh6QnN0VXc2OXROOTY4S2JLaFJDMSs5V1pla21DZkFmdStK?=
 =?utf-8?B?ZmVvSmhIUlFETEY4V1lPUnlqd2lFTm1CcUVVVjNDUGpQR0twdExCdFRRek90?=
 =?utf-8?B?Mi8wcjk1bjVLM2JveisyOWxDN05GMjNBTWp4alN2anQrM3FuZVlLQ2VBRnl5?=
 =?utf-8?B?cDVib3RoOEtQSkVhcjdnb1B2WE5CVExFaVVhQ0VmZkZGMGZLUnNPQ3dnV0tF?=
 =?utf-8?B?OU5oQ1VudjVMZG9aOGxTUStKU2NNcUh4SmtXcUc4WkV6OU1iQklUSm5LZUV6?=
 =?utf-8?B?VlU2alVnVzNvRnFlNFBHcFRYSmdQVXd5dTVYMFF4bGFOS05JVGo3REFDYVlD?=
 =?utf-8?B?N3A1UVFyOHQ3ZTlKbUk1U1RGS2VDRHI4UDZZa3B6NURuc3hxNDhCZmlMNVhP?=
 =?utf-8?B?VkRLSkVFaUF5Y3p2dnNRb2Z2ZjlZU011T2tqbmszZFBicXRKUjhyZVlCanBy?=
 =?utf-8?B?RUVQZTlpSmprVldJSnNoZEEyVU1OZ3AyZnJwcTN4S1g1OG03TTQ0NU0yVTZr?=
 =?utf-8?B?ekFPV0ZGaW1idDlaejJIeVhNSStsWUIvN2ZHMGtWR3Zpc1pPU1Rrc01NOUli?=
 =?utf-8?B?S0xGZFdjbExzN3B0aUpXeUVWUkZLTnFiUGV6My9EbjI2dGQ5VVNvYnRyMUlX?=
 =?utf-8?B?Nk5rL3NSMW9VY3VUdlR2TnNic1ltZlFpOTI3SUhycE5DL2M0MENuczdxbzFw?=
 =?utf-8?B?T1RLTHhFQnFKR0gzRWhSdVBjZW83TVVIaDBRMEJaQzdLdUs0TzdJWlF4WnI0?=
 =?utf-8?B?VzlaVk5ZNHV1eGdTY29zeUNLZ29aQk10djhRcUtZYUdkTG04NHN0SG8xVXA0?=
 =?utf-8?B?TmREMUNZanBXREovbEVzS2dzTEtmei9iemkzTFU2WlF6R0lKVDJvZ3Arczlx?=
 =?utf-8?B?N3VJTFQ3UXNnbUxmcWVRTXgveTIvTzcvejVaY0s2WHduSE9XRktGYytsc3JR?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9C1C6568D570D45BB8C52756DADD30B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43752334-ab9b-4e54-7817-08daf0b87e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2023 14:07:20.8903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVnNdMeslpKIopvECVed2GH1xn2jYApCdSU8sPHD89NXtaqmBsx/hstaSf+6RHBfNg+sRMghbxrgo3r7wsHfGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7073
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTA2IGF0IDA2OjUwIC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMS82LzIzIDA2OjM4LCBaaGFuZywgUnVpIHdyb3RlOg0KPiA+IE15IG9yaWdpbmFsIHByb3Bv
c2FsIGlzIHRoYXQsIGluc3RlYWQgb2YgbWFpbnRhaW5pbmcgbW9kZWwgbGlzdHMgaW4NCj4gPiBh
DQo+ID4gc2VyaWVzIG9mIGRpZmZlcmVudCBkcml2ZXJzLCBjYW4gd2UgdXNlIGZlYXR1cmUgZmxh
Z3MgaW5zdGVhZCwgYW5kDQo+ID4gbWFpbnRhaW4gdGhlbSBpbiBhIGNlbnRyYWwgcGxhY2UgaW5z
dGVhZCBvZiBkaWZmZXJlbnQgZHJpdmVycy4gc2F5LA0KPiA+IHNvbWV0aGluZyBsaWtlDQo+ID4g
DQo+ID4gc3RhdGljIGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkIGludGVsX3BtX2ZlYXR1cmVzW10g
X19pbml0Y29uc3QgPSB7DQo+ID4gICAgICAgICBYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChT
S1lMQUtFX0wsICAgICAgICAgICBYODZfRkVBVFVSRQ0KPiA+IF9SQVBMIHwgWDg2X0ZFQVRVUkVf
VENDX0NPT0xJTkcpLA0KPiA+ICAgICAgICAgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoU0tZ
TEFLRV9YLCAgICAgICAgICAgWDg2X0ZFQVRVUkUNCj4gPiBfUkFQTCB8IFg4Nl9GRUFUVVJFX1VO
Q09SRV9GUkVRKSwNCj4gPiAgICAgICAgIC4uLg0KPiA+ICAgICAgICAgWDg2X01BVENIX0lOVEVM
X0ZBTTZfTU9ERUwoQUxERVJMQUtFLCAgICAgICAgICAgWDg2X0ZFQVRVUkUNCj4gPiBfUkFQTCB8
IFg4Nl9GRUFUVVJFX1RDQ19DT09MSU5HKSwNCj4gPiAgICAgICAgIFg4Nl9NQVRDSF9JTlRFTF9G
QU02X01PREVMKFNBUFBISVJFUkFQSURTX1gsICAgIFg4Nl9GRUFUVVJFDQo+ID4gX1JBUEwgfCBY
ODZfRkVBVFVSRV9VTkNPUkVfRlJFUSksDQo+ID4gICAgICAgICAuLi4NCj4gPiAgICAgICAgIHt9
LA0KPiA+IH07DQo+ID4gQW5kIHRoZW4gc2V0IHRoZSBmZWF0dXJlIGZsYWdzIGJhc2VkIG9uIHRo
aXMsIGFuZCBtYWtlIHRoZSBkcml2ZXJzDQo+ID4gdGVzdA0KPiA+IHRoZSBmZWF0dXJlIGZsYWdz
Lg0KPiANCj4gVGhhdCB3b3JrcyBpZiB5b3UgaGF2ZSB2ZXJ5IGZldyBmZWF0dXJlcy4gIFNLWUxB
S0VfWCBsb29rcyB0byBoYXZlIG9uDQo+IHRoZSBvcmRlciBvZiAxNSBtb2RlbC1zcGVjaWZpYyBm
ZWF0dXJlcywgb3IgYXQgbGVhc3QgcmVmZXJlbmNlcyBpbg0KPiB0aGUgY29kZS4NCj4gDQo+IFRo
YXQgbWVhbnMgdGhhdCB0aGUNCj4gDQo+IAlYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChTS1lM
QUtFX1gsIC4uLg0KPiANCj4gbGlzdCBnb2VzIG9uIGZvciAxNSBmZWF0dXJlcy4gIEl0J3MgZXZl
biB3b3JzZSB0aGFuIHRoYXQgYmVjYXVzZQ0KPiB5b3UnZA0KPiAqbGlrZSogdG8gYmUgYWJsZSB0
byBzY2FuIHVwIGFuZCBkb3duIHRoZSBsaXN0IGxvb2tpbmcgZm9yLCBzYXksICJhbGwNCj4gdGhl
IENQVXMgdGhhdCBzdXBwb3J0IFJBUEwiLiAgQnV0LCBpZiB5b3UgZG8gdGhhdCwgeW91IGFjdHVh
bGx5IG5lZWQNCj4gYQ0KPiB0YWJsZSAtLSBhIHJlYWxseSB3aWRlIHRhYmxlIC0tIGZvciAqYWxs
KiB0aGUgZmVhdHVyZXMgYW5kIGEgY29sdW1uDQo+IGZvcg0KPiBlYWNoLg0KDQpUaGF0J3MgdHJ1
ZS4NCg0KPiANCj4gV2hhdCB3ZSBoYXZlIG5vdyBpc24ndCBiYWQuICBUaGUgb25seSByZWFsIHdh
eSB0byBmaXggdGhpcyBpcyB0byBoYXZlDQo+IHRoZSBmZWF0dXJlcyBlbnVtZXJhdGVkICpwcm9w
ZXJseSosIGFrYS4gYXJjaGl0ZWN0dXJhbGx5Lg0KPiANCj4gSSBnZXQgaXQsIEludGVsIGRvZXNu
J3Qgd2FudCB0byBkZWRpY2F0ZSBDUFVJRCBiaXRzIGFuZCBhcmNoaXRlY3R1cmUNCj4gdG8NCj4g
b25lLW9mZnMuDQoNCj4gQnV0LCBhdCB0aGUgcG9pbnQgdGhhdCB0aGVyZSBhcmUgYSBkb3plbiBD
UFUgbW9kZWxzIGFjcm9zcw0KPiB0aHJlZSBvciBmb3VyIGRpZmZlcmVudCBDUFUgZ2VuZXJhdGlv
bnMsIGl0J3MgdGltZSB0byByZXZpc2l0DQo+IGl0LiAgQ291bGQNCj4geW91IGhlbHAgb3VyIGNv
bGxlYWd1ZXMgcmV2aXNpdCBpdCwgcGxlYXNlPw0KDQpGb3IgdGhpcyBSQVBMIGNhc2UsIEkgdGhp
bmsgdGhlIGJpZ2dlc3QgcHJvYmxlbSBpcyB0aGUgUkFQTA0KKmluY29tcGF0aWJpbGl0aWVzKiBi
ZXR3ZWVuIG1vZGVsIHZhcmlhbnRzIGFzIEluZ28gcG9pbnRlZCBvdXQuDQpTbyBhIENQVUlEIGJp
dCBjYW4gbm90IHNvbHZlIGFsbCB0aGUgcHJvYmxlbXMuDQoNCkJ1dCBnaXZlbiB0aGF0IHRoZSBi
aWdnZXN0IGluY29uc2lzdGVuY3kgaXMgdGhlIGVuZXJneSB1bml0IHVzZWQgb24NCmRpZmZlcmVu
dCBnZW5lcmF0aW9ucywgSSBjYW4gYWxzbyBjaGVjayB3aXRoIG91ciBjb2xsZWFndWVzIGlmIHRo
ZXJlIGlzDQphIHNvZnR3YXJlIHZpc2libGUgd2F5IHRvIGdldCB0aGUgImZpeGVkIiBlbmVyZ3kg
dW5pdHMgcmF0aGVyIHRoYW4NCmhhcmRjb2RpbmcgaXQgaW4gdGhlIGRyaXZlciB1c2luZyBhIG1v
ZGVsIGxpc3QuDQoNCnRoYW5rcywNCnJ1aQ0K
