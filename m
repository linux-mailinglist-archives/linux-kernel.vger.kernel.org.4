Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DFC67B9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbjAYSkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbjAYSkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:40:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF755B587;
        Wed, 25 Jan 2023 10:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674672004; x=1706208004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZMAXaQmTPlthw+t1fDYaxSWYQ2Kod/dGV5+OeVqu0Z4=;
  b=nqeeFI6J8Srx85rAHwp0IQpDZUAHiePu2Ybo2HSlbvYWwu6G51AQ7unr
   jzzYbBbzO0fv53OktWvpdvRU1CMOhFtjCh6fQXBWJ9/6Zf+JUD/meFeOX
   mWDNgouJ5pW6d8w+3S0tlVXZASdAaRwqvm8MMykSi7uPEafYBYSLc5Mmy
   nuVzQgyFqMuW7bt1FC7lCbwiduOQ6KMv4JGJNe3lSxOaQ40Ns4KgTGkot
   M2N5UKJnOyPff7+FOp9YhaOyCVvuBCUC5D1BTCMhQ/UoaoMaHRpJ9kw+C
   d4gVPjKdp2vQ3BbzixPi07oR+tbrYfSxaWkZ1k94ZgacXlRD3Oy43wP+5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="391150748"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="391150748"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:40:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="770835001"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="770835001"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2023 10:40:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 10:40:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 10:40:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 10:40:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRJS2AYRbuTujP+F3jGrckzsh9PC7t3x4FStgNA9KGlCDVeWxvHicGoEI7vAKx1Wd9cS7W6Anp2xyCdO6KwrwzQAizllcCgMy0AZZjOw11pmmNhVQC0Q237i3OZPfDTroJjV5dachsrz0T8yHVMNnjq5ovXw9IOVx86PN8CtAN3vEeZWdIznPtIDwXI0TaHeKRD+KfAX4f6zHRJnkUc3Nlq3KQ3c/7CmFBX1KfJIeXC4nQHJuhP/Qkzbov3SQxOHgE+T5mJZrekDTfkljACLh7mczzu8kFxcJ5s5RHMO4bYHf4Bi5XlZrcKMgO4c4c0bInq3EHxk/l79VaVuyQROig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMAXaQmTPlthw+t1fDYaxSWYQ2Kod/dGV5+OeVqu0Z4=;
 b=Mo5KSTACCeQLX5AOCZB9RgxQ8AVM/peq9v2Aqfn+G8RhgURdO+cTsxCWj6QcFfleremiRJSafcUxWL2pTgkLfE7Kn3BFmORAyhVPCLbIRiArBZ6IzT5Tm7rCQE9p9/ilUuxMelV8/tQPJADNHvG4TEfLNngryqQVlE1cqvB8JADRq1k/b2vHhUoVuSM+J5xzaQ7HUrupijhjx033WFKKFa/YmtQ5KXwWaHlzdYUFkHzgvLEMtN+sTAAAwVBtEOwJk8yQFwgGx//fTwrok7FEmakk3+x4LLE9PW+EW6k/aeYxjnaJ65/HQh7Sghieux+PYajSu0CTSxgCw9WNF+kAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by CY8PR11MB7731.namprd11.prod.outlook.com (2603:10b6:930:75::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 18:40:01 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 18:40:01 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v2] nvdimm: Use kstrtobool() instead of strtobool()
Thread-Topic: [PATCH v2] nvdimm: Use kstrtobool() instead of strtobool()
Thread-Index: AQHZJ/VP0QgoRC2ntkq8mQOJVVXd+a6viO4A
Date:   Wed, 25 Jan 2023 18:40:00 +0000
Message-ID: <8852ab436bff000b6974efbc01eb67aee901b0b9.camel@intel.com>
References: <7565f107952e31fad2bc825b8c533df70c498537.1673686195.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7565f107952e31fad2bc825b8c533df70c498537.1673686195.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|CY8PR11MB7731:EE_
x-ms-office365-filtering-correlation-id: c685e6ee-f2d3-4368-4c0b-08daff039109
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hQMRHZU8ErbAdINR4Vt2D/n2KT7Bc9Y7ydogz98fnpyisnfeYSBh6jz4SSRuSXBV0FaHtHbdVUcS9VGfAZn3orQ4LhOBeEw/yS6EQuFkb6NMtvCUiUSIxC9Jxct2eH1smFoD+lcV40o6NZcJzAWbWUNIk5f3A10gn6Ta6uPVjpfWiSUaKVNh1Bm73n48gIBzNVfJgh16hLwtlk6+hlPMNJxlI9Hpo50L8y9KO4T6J+FP6GHnTUT8HFYQiE1+Xi8nh0/l4Y3EE5VFZVj2PcdTsO6cHHLGH/q9+9jpx0NIsbErwJyzGbX1wLPJ0p8JJ5utkKlHmyqMdHVLZjWzaqa0/dWmBRNjzHijLkzd3w+XehB8+OqkufWfRqI/CcM9rm6PBE/cfS50nWAVqqfm2fzf5cd+XizvqFTA0nAi9vGNoke1E5iaK2JzhPgcdmRRBVt3F+md6DkrDPmc7hWmaUy088wlkL/3AUJZetaA6ItGrOYKF/7V3ckrZQcSWI8azHJZSBA8zI+riVB66fwxIlN3JwKB1RkCeguUMHeWBtgjb6lfVVo1ma5jOUhUw2QE47PHEYHjig+7ckqgfidzJoGYef94F3YGpyPc9O5W9fOvxgglWanpFfI4NdZYU9bvwHQBFyXCSkZeePG37Z3qXmEjm0yNFSzCTG8uPt7mr0oucKCzD2OCx9zLNb+ruvzDi24iLcqDS/WUG54poVUC1Z/MPE7wUumZJilyV3hub+ZSzeY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199018)(38070700005)(36756003)(54906003)(86362001)(64756008)(316002)(110136005)(38100700002)(41300700001)(5660300002)(82960400001)(83380400001)(4326008)(8676002)(8936002)(2906002)(478600001)(6506007)(6512007)(6486002)(66556008)(186003)(66476007)(6636002)(76116006)(122000001)(26005)(2616005)(66946007)(91956017)(71200400001)(966005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk5QamI3NlJEUWgyYlpwbk1iZnNpTURDVklmMStaQ1RBNVBkcFQxTkRGei9i?=
 =?utf-8?B?Nzh0ak1lMkw0dmxldE9yRVRUNC8wUGtLTURRWmg5M3hxWkRadHc5c2tvbzF2?=
 =?utf-8?B?SEdjWDFYaDFFcy9LMVQwVjFUbE5zcmY4WUNiL1V1emFuc0M0NmxZdEs0RlRH?=
 =?utf-8?B?N3B1TVNUelZDd2ZDM0pqMlVOTDBIMWtNcDlDUEpQckZjVGgxYVZ0ak9nai9S?=
 =?utf-8?B?RlN1T1BGbzFOVEJkV2hYU080Ri9EOWptaG9vdllPcGZ1SitjQ2s0SEJGVWFS?=
 =?utf-8?B?UDVWcEZjV0E0RjBXbFB3S1hkcXZGOVVuUFBXS0FkRzFZOGE1NlRjVlFVdFMy?=
 =?utf-8?B?d09Lb0FUVmJhNllMMXdEYUltYnBpT1FiU25jcmVDM1FER2xvTVpybFM5NGlw?=
 =?utf-8?B?YktiWU1QUnR0QzJSQ0ltcVpzMGhKMUg3QTlYNXpGSFlWYnF4NmFEM1k4ZnVX?=
 =?utf-8?B?MlZUUmxjWmswUnRvZ3hkanNXYnZJRkc1Mk83eDROUUxab0dyNzlPQWRFaTJQ?=
 =?utf-8?B?LzEzSllUT2Ztd1ZPODEvK0VrYVlhcWVIbHBwQUx4OCsvSUoyRlJQaHhDc2N1?=
 =?utf-8?B?YmMyUFduSmVMa2ZSa0Q1b0s3OEd0ZmRHWTh3bzMzNXB2UzhMcUYzdmhOL1U4?=
 =?utf-8?B?L01uY1RFUTQwbHlBY2FhTkdQeitwcHFWZmhJUTBld0Qxb0hvbjBkOThRYW1t?=
 =?utf-8?B?ZndQNVYzOStrZzNiRC91QURzZzduZEhDcjhCL1JCMnNPSnNJNEZSSmRIYmpH?=
 =?utf-8?B?WnF6K2xhb3N1TTRaL01ZYUUzRDFvL2VOR3NnUmF0WTRGRmRQOGNQM1YxaEpN?=
 =?utf-8?B?UFh3UUFkallvSjV5eDlqRFZmcW84S1ZydmlQdVRkbjNyd2pKc1JSSWFMRE1T?=
 =?utf-8?B?ZGg2dTc1LzIzNnl3a2UrMnozUlRIN1RFL2M1bEpNOTZUZmFlaW1wU0NMcHBI?=
 =?utf-8?B?anliWnpWYmt2YktZZ1Y1cWYwdmVnZ3RMK2Q5MDRUU3NuSklhUGV4bUkveDhv?=
 =?utf-8?B?QnhaakhnWllYU204ekIwUGxtOXkySFdoM3hndzZkMVkzWGpTeXNBMmt1dDZE?=
 =?utf-8?B?aGIwTC83VzdhZTNxNmpKS2Zub1JTcnpvcVF5Tk1qdStTcCtaaXBxSWdKSUg2?=
 =?utf-8?B?ait1SlNUeXhuWmtaRnpMeHZnYTdJYTM2OGFLc096eXFiSU1SVTNmMGZsNTBq?=
 =?utf-8?B?NmVLMGVaZUp4eHJFV0M2VFZJVlFOZDdOaS9rQXBadS9BYi9hbVFCZ0JscjAv?=
 =?utf-8?B?SVhMUEdMT0lETnR3Y0V3UWV6eTZkSDc0Q1dCR04xb0xiMDlZdEhvMUJ0SHhK?=
 =?utf-8?B?d3RJc0hFOVBZYkpBMjByTVBzZWVsZ3pxdFRZb3QyMThYSDh5Q1RUS3hRamIz?=
 =?utf-8?B?dExLS052Y2U4ajMzc1dGZ2tjYVFTMGdiaVBXZzlydm5EK1RCQkhvZjdPU3Ix?=
 =?utf-8?B?SG9pb05NYTV1Q1NHWE9XRlZ5b1lRQ21CcEZYaUxrdUVUK0ZQS3dnYy81QzRI?=
 =?utf-8?B?NWI3UzdSZzU4MEVwSUlTYjZidFEraGZMd3N1VjRzZWpQWXdJYk1ZTWZMWkRw?=
 =?utf-8?B?eXk3T3pxT3Jkd0YvQ3lwNEJFU2hRNmtURFhndE43dE9WL05YcVNsWmhTR3lo?=
 =?utf-8?B?U1VKMlJVZ2MxY3cyWCs4M0RLMHRJZ0pSdk5TNEltUkVLbzNkSlp1UkF3QVZj?=
 =?utf-8?B?RGpFS0JiMmJoekdUcGs4K2hWeTUzc1NiekkwbHZtUEd1OXZtRHZqZHhDTkRI?=
 =?utf-8?B?UkNjLy9xbmhGMDUzR1c3aWRvck5pNHJlRnRYQkNtQVF5c0RWYzdEZ0JBends?=
 =?utf-8?B?RVdnWTFDYlZUZjErbEp0MjlhUHBYZXVSZGIyNURGb1I0YUtlSm9xYW5JQzBR?=
 =?utf-8?B?QUV0cVJ1Um9IK0NudkJ5b1ZOeGFLaDJQTVUyeXoxaDM0VDF4cFVZRGE5K2sr?=
 =?utf-8?B?ZkYyUi95Z3ZxaDNhZ0R6NnJVdVVjM0NocDlwVCtjNXZkRVJZTmdiVHllVjYy?=
 =?utf-8?B?dWd0YkRVQS83YjM1b2xLVEs2SGtRWjdOUmE4V1BCN1pTbDNsWWhvWHhFNjVI?=
 =?utf-8?B?NkYva1FZTDVEQjF6T1BPMk1DVU8zdU9yMmxrNTFReVR4YklmbWJ6bzdwU21M?=
 =?utf-8?B?TGk3TE0zdk9nbHkrdzA4VWdWbGpwdkQyL2JDZW8xbDV1cFc5dWh5QkJUSGZj?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <021D6997AE1462429F818B9FC0395B4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c685e6ee-f2d3-4368-4c0b-08daff039109
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 18:40:00.9011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3fBGh6UxFhnOVb4HusbT+mx2A2Iw14BeM1YH+mF1OFpKYFgUrNaLx04ZT6tC7kjLnQJT/kVoyaDyYlr/Z/xqh+qZ32vDaPqDTZRiGwxS8vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7731
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTAxLTE0IGF0IDA5OjUwICswMTAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3Jv
dGU6DQo+IHN0cnRvYm9vbCgpIGlzIHRoZSBzYW1lIGFzIGtzdHJ0b2Jvb2woKS4NCj4gSG93ZXZl
ciwgdGhlIGxhdHRlciBpcyBtb3JlIHVzZWQgd2l0aGluIHRoZSBrZXJuZWwuDQo+IA0KPiBJbiBv
cmRlciB0byByZW1vdmUgc3RydG9ib29sKCkgYW5kIHNsaWdodGx5IHNpbXBsaWZ5IGtzdHJ0b3gu
aCwgc3dpdGNoIHRvDQo+IHRoZSBvdGhlciBmdW5jdGlvbiBuYW1lLg0KPiANCj4gV2hpbGUgYXQg
aXQsIGluY2x1ZGUgdGhlIGNvcnJlc3BvbmRpbmcgaGVhZGVyIGZpbGUgKDxsaW51eC9rc3RydG94
Lmg+KQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhl
LmphaWxsZXRAd2FuYWRvby5mcj4NCj4gLS0tDQo+IFRoaXMgcGF0Y2ggd2FzIGFscmVhZHkgc2Vu
dCBhcyBhIHBhcnQgb2YgYSBzZXJpZSAoWzFdKSB0aGF0IGF4ZWQgYWxsIHVzYWdlcw0KPiBvZiBz
dHJ0b2Jvb2woKS4NCj4gTW9zdCBvZiB0aGUgcGF0Y2hlcyBoYXZlIGJlZW4gbWVyZ2VkIGluIC1u
ZXh0Lg0KPiANCj4gSSBzeW5jaCdlZCB3aXRoIGxhdGVzdCAtbmV4dCBhbmQgcmUtc2VuZCB0aGUg
cmVtYWluaW5nIG9uZXMgYXMgaW5kaXZpZHVhbA0KPiBwYXRjaGVzLg0KPiANCj4gQ2hhbmdlcyBp
biB2MjoNCj4gwqAgLSBzeW5jaCB3aXRoIGxhdGVzdCAtbmV4dC4NCj4gDQo+IFsxXTogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2NvdmVyLjE2NjczMzYwOTUuZ2l0LmNocmlzdG9waGUuamFp
bGxldEB3YW5hZG9vLmZyLw0KPiAtLS0NCj4gwqBkcml2ZXJzL252ZGltbS9uYW1lc3BhY2VfZGV2
cy5jIHwgMyArKy0NCj4gwqBkcml2ZXJzL252ZGltbS9wbWVtLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDMgKystDQo+IMKgZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuY8KgwqDCoCB8IDUgKysr
LS0NCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cg0KVGhpcyBsb29rcyByZWFzb25hYmxlLA0KDQpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2
aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252
ZGltbS9uYW1lc3BhY2VfZGV2cy5jIGIvZHJpdmVycy9udmRpbW0vbmFtZXNwYWNlX2RldnMuYw0K
PiBpbmRleCBjNjBlYzBiMzczYzUuLjA3MTc3ZWFkYzU2ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9udmRpbW0vbmFtZXNwYWNlX2RldnMuYw0KPiArKysgYi9kcml2ZXJzL252ZGltbS9uYW1lc3Bh
Y2VfZGV2cy5jDQo+IEBAIC0yLDYgKzIsNyBAQA0KPiDCoC8qDQo+IMKgICogQ29weXJpZ2h0KGMp
IDIwMTMtMjAxNSBJbnRlbCBDb3Jwb3JhdGlvbi4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCj4gwqAg
Ki8NCj4gKyNpbmNsdWRlIDxsaW51eC9rc3RydG94Lmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZS5oPg0KPiDCoCNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gwqAjaW5jbHVkZSA8bGlu
dXgvc29ydC5oPg0KPiBAQCAtMTMzOCw3ICsxMzM5LDcgQEAgc3RhdGljIHNzaXplX3QgZm9yY2Vf
cmF3X3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY29uc3QgY2hhciAqYnVmLCBz
aXplX3QgbGVuKQ0KPiDCoHsNCj4gwqDCoMKgwqDCoMKgwqDCoGJvb2wgZm9yY2VfcmF3Ow0KPiAt
wqDCoMKgwqDCoMKgwqBpbnQgcmMgPSBzdHJ0b2Jvb2woYnVmLCAmZm9yY2VfcmF3KTsNCj4gK8Kg
wqDCoMKgwqDCoMKgaW50IHJjID0ga3N0cnRvYm9vbChidWYsICZmb3JjZV9yYXcpOw0KPiDCoA0K
PiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiByYzsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL3BtZW0uYyBiL2Ry
aXZlcnMvbnZkaW1tL3BtZW0uYw0KPiBpbmRleCA4MGRlZDVhMjgzOGEuLmYyYTMzNmM2ZDhjNiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udmRpbW0vcG1lbS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZk
aW1tL3BtZW0uYw0KPiBAQCAtMTcsNiArMTcsNyBAQA0KPiDCoCNpbmNsdWRlIDxsaW51eC9tb2R1
bGVwYXJhbS5oPg0KPiDCoCNpbmNsdWRlIDxsaW51eC9iYWRibG9ja3MuaD4NCj4gwqAjaW5jbHVk
ZSA8bGludXgvbWVtcmVtYXAuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9rc3RydG94Lmg+DQo+IMKg
I2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvYmxrLW1xLmg+
DQo+IMKgI2luY2x1ZGUgPGxpbnV4L3Bmbl90Lmg+DQo+IEBAIC00MDgsNyArNDA5LDcgQEAgc3Rh
dGljIHNzaXplX3Qgd3JpdGVfY2FjaGVfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiDCoMKg
wqDCoMKgwqDCoMKgYm9vbCB3cml0ZV9jYWNoZTsNCj4gwqDCoMKgwqDCoMKgwqDCoGludCByYzsN
Cj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgcmMgPSBzdHJ0b2Jvb2woYnVmLCAmd3JpdGVfY2FjaGUp
Ow0KPiArwqDCoMKgwqDCoMKgwqByYyA9IGtzdHJ0b2Jvb2woYnVmLCAmd3JpdGVfY2FjaGUpOw0K
PiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiByYzsNCj4gwqDCoMKgwqDCoMKgwqDCoGRheF93cml0ZV9jYWNoZShwbWVtLT5k
YXhfZGV2LCB3cml0ZV9jYWNoZSk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9yZWdp
b25fZGV2cy5jIGIvZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYw0KPiBpbmRleCA4M2RiZjM5
OGVhODQuLmY1ODcyZGU3ZWE1YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udmRpbW0vcmVnaW9u
X2RldnMuYw0KPiArKysgYi9kcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jDQo+IEBAIC01LDYg
KzUsNyBAQA0KPiDCoCNpbmNsdWRlIDxsaW51eC9zY2F0dGVybGlzdC5oPg0KPiDCoCNpbmNsdWRl
IDxsaW51eC9tZW1yZWdpb24uaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvaGlnaG1lbS5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L2tzdHJ0b3guaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4N
Cj4gwqAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiDCoCNpbmNsdWRlIDxsaW51eC9oYXNoLmg+
DQo+IEBAIC0yNzUsNyArMjc2LDcgQEAgc3RhdGljIHNzaXplX3QgZGVlcF9mbHVzaF9zdG9yZShz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHQNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb25zdCBjaGFyICpidWYsIHNpemVfdCBsZW4pDQo+
IMKgew0KPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCBmbHVzaDsNCj4gLcKgwqDCoMKgwqDCoMKgaW50
IHJjID0gc3RydG9ib29sKGJ1ZiwgJmZsdXNoKTsNCj4gK8KgwqDCoMKgwqDCoMKgaW50IHJjID0g
a3N0cnRvYm9vbChidWYsICZmbHVzaCk7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmRfcmVn
aW9uICpuZF9yZWdpb24gPSB0b19uZF9yZWdpb24oZGV2KTsNCj4gwqANCj4gwqDCoMKgwqDCoMKg
wqDCoGlmIChyYykNCj4gQEAgLTUzMCw3ICs1MzEsNyBAQCBzdGF0aWMgc3NpemVfdCByZWFkX29u
bHlfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpidWYsIHNp
emVfdCBsZW4pDQo+IMKgew0KPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCBybzsNCj4gLcKgwqDCoMKg
wqDCoMKgaW50IHJjID0gc3RydG9ib29sKGJ1ZiwgJnJvKTsNCj4gK8KgwqDCoMKgwqDCoMKgaW50
IHJjID0ga3N0cnRvYm9vbChidWYsICZybyk7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmRf
cmVnaW9uICpuZF9yZWdpb24gPSB0b19uZF9yZWdpb24oZGV2KTsNCj4gwqANCj4gwqDCoMKgwqDC
oMKgwqDCoGlmIChyYykNCg0K
