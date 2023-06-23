Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7572E73BC00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjFWPtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjFWPt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:49:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C82117
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687535365; x=1719071365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5DQFgk9gvxRFUjlxUFSjUtzIJFkmewkU2t+au3zoz6A=;
  b=eNzNvXUwLp3cOL5MGc7NsWL3ZSt+1TaIVVeU2s+F73jie9eEXIwRUUVL
   36iPx+Qm4hh9/sMNQneZwJ0v6Tt6yne7w8o/wux65gp8oIGjhBtZn4Y+Y
   Yxww/Sla+FzvQDWEU8SNa70bwViZEmqPOjR505eURv5T3CnpAz9R28KQT
   kvsEABJ9E7x+FrRqQbCgd9cjDpwt/BJh0gRvLHU+Ei8bNSLgcmB/rfcDA
   1fIq6y5XMXOX1/4vm+z/vqAadR4mqbelszBqsk3lAO3szb8a4eCKGuA+c
   odXlDC5fBd/WfK7F4DXHT57hI3t7B1k9+JYG7bSKClQm1az6al0QbDXFg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="447170916"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="447170916"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 08:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="665519948"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="665519948"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 23 Jun 2023 08:49:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 08:49:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 08:49:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 08:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oen3gXcdF2Q8qsdDCWrC6tOW9MaToPFUKEbKupsY1Cv29lGVuTha+bFzyNZMGsM8hkdRQ9/qa4y8Gru1kiGL9KMaZdDN7E90qVvc46fo4xRyhxWRKZ81d50JoSFd409p7LlrdcRkPUAK+IKCmjicvsule2PZB8r4QQhgPJJ2ygD15noD2Ho6iu6VHUQqq9rzF8IgDzmPGv/dPN76SHELrF0YPuLP0251uinSWQxE6VxPuds//T4st2bMjEdktiRykcx/va4yYpqyU2/ojPTyckh26LjFM/ckjgs4hVMf1mhFbaVdjIlPEoc5DHEVsp46wBrQ4YUiYMVUCg7Yj9hwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DQFgk9gvxRFUjlxUFSjUtzIJFkmewkU2t+au3zoz6A=;
 b=NDBNi6MnVuM9FA1dnVNjS1wk0/Yqr6dwvV67yeCW+7UsFQ2xi7n2a6hsqnYsvbNsZISrm/ZC01St92NZVyG+9iI0nuT9682WRh37jqYR2gq8J1yu8ytQ5QyZd+6zzMQL1TG5/qFmztkLKQDbKCkKnyQANqePfdndKeqvHT7O3k79Lva8fzjAgHD7pjRNusOURi5yj3qYxxZonndRMwBpAM5ytE7Sxi1VWiheCNhzafRhs3CbSrbfA9dMdblbCKYiR+PJtJLGF6JU5VWqUI7u/Xw57d8WxvKc3jXLKw8ZvVyuCgqPjCi35GxiXY6ns12LANC0HZ5v534eK3R6mu+6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com (2603:10b6:a03:4ed::18)
 by DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Fri, 23 Jun 2023 15:49:17 +0000
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf]) by SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 15:49:17 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Tang, Feng" <feng.tang@intel.com>
CC:     "Chen, Tim C" <tim.c.chen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Thread-Topic: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Thread-Index: AQHZnbiCY6eum+iSlk2uGaiesk42zq+LmcaAgAFwMQCACeXpgIAAkUsAgAEX7IA=
Date:   Fri, 23 Jun 2023 15:49:17 +0000
Message-ID: <23ccb5aad770fb52014dca9fb1e4353b5c3cede9.camel@intel.com>
References: <20230613052523.1106821-1-feng.tang@intel.com>
         <20230613052523.1106821-2-feng.tang@intel.com>
         <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
         <ZIwMstkB7CG3pDYu@feng-clx> <87h6qz7et0.ffs@tglx> <87edm36qqb.ffs@tglx>
In-Reply-To: <87edm36qqb.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0086:EE_|DS0PR11MB7785:EE_
x-ms-office365-filtering-correlation-id: 1f9a03c1-a781-44fd-23a7-08db7401670e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l4BzXhXdyFfT6ck8vC2ljWeDphiPVlTVzHOWCIsV+6mt49q9MKXEr5vWkO1VCFhXVtIp2hbjMfXPm+/sI+MBBVPhM6GsZfhPPvrAVN+KDNsdkUpKWGdc8DykJtcqbrA4urlYy8UF58swGOOHWHv5VKtS4baEqSDoAmPalG+SBWfoaRMmUYWr4Ye1N0z1LagrauApKPVnAyEfTBKcmPpKQ6kuPm7V372uY3b8GAfaR1qxxRE6hVKwmrro22xrT1JRlWl08/h9geEw1L1u50YeAgTR/+wFLs/z7GX8qlFGujpoPU+vRHJdtT9GwtZGDDfM+TSQ+yKafijfbW0ELp/xvi5kFIlQOn26eDH7PmRoJulf3qdAWI0zA3ycjpIyyaOwk7oHFeKY19dJM//GRF4cK4md/lnPlwZjBA/FxAwn0ICg4qNV9U9+LnRSmrcdGfr8v/YDg14Rvik2LSVTFyAaN+Byb2MBLz0XXWaanwcex0bT66l9dJNWyfzE1ZmbTGijv48P2ESseste67ReVtR0qi5LYPov3lY+9OEeTLmfdjyFvvdjbUJA6IEnIUd4G8zldbsq0fFqEO/vlGfwHpdEUz4MYx71WPPDiL01a9Uj060=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(66946007)(53546011)(66476007)(76116006)(26005)(6512007)(6506007)(66556008)(86362001)(6636002)(4326008)(66446008)(91956017)(186003)(64756008)(110136005)(54906003)(2616005)(5660300002)(7416002)(83380400001)(38100700002)(316002)(122000001)(478600001)(36756003)(71200400001)(2906002)(82960400001)(966005)(6486002)(8676002)(38070700005)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjFqTFV5cEFhcTZKc0JsNnYzckZMZXpIRENxdURvMGxhUWQ1ak4zYTlMeXlk?=
 =?utf-8?B?NEZnNUdXaEZXeWRMVUh4cU5KdzNhRXZubjRXY0ZseS9rZ3FBWHd6RTdJTDN4?=
 =?utf-8?B?ZTk4NWNuZXJMeUtiZGlxTlJPZEhJQ1hzOStEZzlheDhwWlBLNjVQQXVDWHht?=
 =?utf-8?B?Z2MxeG5tUXlnTGZRNXQzSUpCbWNRYUU1S3JzSEdwTlZOSGc5eXRqeFhneEJ1?=
 =?utf-8?B?ZENRTEY3YS9CMDJlWXJXWVB2eXFBTU1wWFR2aXFHenl4UE5tMXI1R0FPQ2Mz?=
 =?utf-8?B?RkRnVkJKdG5GMS9Fa2JFMmVSQlZ5ZUFZTDFLMXdHU0h4MEEzMzU1ZG5HRGIy?=
 =?utf-8?B?V0FhNXR4YXRyejl2NDlzYnRpUEkyc0d2YUFsOTdRdFE2b1loWkRqYzU2cS9p?=
 =?utf-8?B?NEFCa2lWaVBJeUlHeWpicjNCSTFZVXBydXB6bVVXNTBtTXhCbVgzK09kTCtk?=
 =?utf-8?B?UGNZbTJ3ZjF0Z2ErNS9sZnJYNnlUclh6WU5TWm95TDFZSm1uWUsrb3NYOE53?=
 =?utf-8?B?UVZYdDdRSU11dkpqUUMzMjE5RjN3MWVNcnVHdlZjb3V1ZUVXZWVENWtmZHYw?=
 =?utf-8?B?UllRYW1KVVZycFB0Z2t2SUhOaFF1Z1Y2QVI5VVF4akk4c2dHTTZ2RHBSTzIw?=
 =?utf-8?B?MHhMZGxGOSs0UWZOODlHaWNoU1c5YlU0bVhsRWhMWU5ZVEFVUlExejBaRmNP?=
 =?utf-8?B?M1dqRnRyZWJ0R2JwbGxXem9wTVVxc2dXTVRmNUJmZ2RJMGFBU1pZci8rNDgz?=
 =?utf-8?B?T3BhLzFHa1ZZRDZvcFQ1ZEZBQytCYzY0RTN5OTBDVTVUeThxbEpzZllXcWE0?=
 =?utf-8?B?Y2VwcWJHcjhNYytFTU5XWStsQXJ0bzVTNThuQ1BuTWY0Yy9rTmRNY2tOVXNk?=
 =?utf-8?B?ZW52aURQSWgxSnlZd01xYUd3b0l3VDdobHNsMHNIb05OckM2ZGczbWFCSXkv?=
 =?utf-8?B?MHVvS3htNnh0WTFZZkdld1NremJ2azJzOFYxT3BwNEJLMHRLYXNPQ0piQzBT?=
 =?utf-8?B?eTZwQnQrNWRnR0YxZTdOd0Q0Mmt5SUZteDFRdzNwMFhPb2F6QXEvNzB3MWF0?=
 =?utf-8?B?emtQQzFTZ1MrbUllYmNkeHZWRUt1NEpSNjNYSnJBVW0vTFRWdi9keE1jV05F?=
 =?utf-8?B?UjZSZmNkWXluQXl1N1NCQkVPNnV4VXNHWnhNOWtReHMwOW10TktiYmhhN3Zx?=
 =?utf-8?B?MlZoSlZtVksyN2tLd0tZNTcwVWRERG91dVJra1dQSFZDd1h4RXRDT3YxU3pB?=
 =?utf-8?B?YUVvRkJ3RFQyUXkxRlJSSVBFNU9RL2J0Y013RSsxMkpSeW9aSkpVUXVLQTJZ?=
 =?utf-8?B?T1JSWmM1ejRaOFQ3SHhyMUg4aUk1U1FwZUprbzBhL0FhWmZrME5hZmJaamlJ?=
 =?utf-8?B?SXdXazBCKzJ5NFdqb2t2Y0pRWWRSRmRPV0JzcUtRdjdGQkY2NUYrbmJzS3ky?=
 =?utf-8?B?dXhqK084elBrZzZZcDVhNURyQitJLzZXYm5rOWYrSENESkJmV29STTRVckR4?=
 =?utf-8?B?OWZ1UE54QktTbVMrV290QTBCRmFxVzQ1Qk9IRVlYU2lJMkZ4K3pmY0FrWW4w?=
 =?utf-8?B?bUlwNUlKZ3VLYzVEVmVuMUtDWk1MajYxeFdTWlZhWlE5ZCtZTkJaU2NhUFVZ?=
 =?utf-8?B?NitnN2xpbGkxbmRtVjJSVlRFM2w5V0xIODlOVGhQTWtlRFV5RTRTUEg5OWZO?=
 =?utf-8?B?YXFjaUpVdTNWTE9DNjlKSFYxUCtzQmZ5V2ZtS0FHTVZQK1lxc3M4NTFnK1ZK?=
 =?utf-8?B?ei9WRys0bUhBaGVEQjJvMmFYSy9lYUYxSzA5a1cxNWFlOUJFaEhMQXRVelhx?=
 =?utf-8?B?V2FsaU94VUx1Wk1Lb1JhWjlwZkVteUZzQ0QwVWYvQ1BFMEx6c3h6cGlQYzlq?=
 =?utf-8?B?bGFqNVJBeUNjRG1FS3J5MUZSeG54VTFHMkdPM1Bjb29STjY3MUIvVnFUTzZj?=
 =?utf-8?B?cWZVZHp2Skg3YVF1Z3hYaENFSTFBZmc1QjNWTG04eWgySlVLNjNoQWgrU01k?=
 =?utf-8?B?NmIwMEY1Z3lUM0I2bjBCRUQweDNRbEFaMlcwemt1YXBaT000amUra2RHTWQw?=
 =?utf-8?B?TjBiUGtJZDNyWTM3eXNESTFQa3ZBNWNicXBybGRwS1dBYlkyWStYRktxTm1u?=
 =?utf-8?Q?aoPyFeWItjB2VYLsnc3GXsIcn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF287A3BE6B4F14EA120E8D995929C67@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9a03c1-a781-44fd-23a7-08db7401670e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 15:49:17.5274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BcFSpYmlzZHUVipgvVVXYWHVJJsX4SlHnqqYPlrpjGjV2mEcYt5C/d7IN4N9EKg5+9ddJuxdz0lVN/ayJ66gNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7785
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

T24gRnJpLCAyMDIzLTA2LTIzIGF0IDAxOjA3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFRodSwgSnVuIDIyIDIwMjMgYXQgMTY6MjcsIFRob21hcyBHbGVpeG5lciB3cm90ZToN
Cj4gPiBPbiBGcmksIEp1biAxNiAyMDIzIGF0IDE1OjE4LCBGZW5nIFRhbmcgd3JvdGU6DQo+ID4g
U28gc29tZXRoaW5nIGxpa2UgdGhlIGJlbG93IHNob3VsZCBqdXN0IHdvcmsuDQo+IA0KPiBXZWxs
IGl0IHdvcmtzIGluIHByaW5jaXBsZSwgYnV0IGRvZXMgbm90IHRha2UgYW55IG9mIHRoZSBjb21t
YW5kIGxpbmUNCj4gcGFyYW1ldGVycyB3aGljaCBsaW1pdCBucl9wb3NzaWJsZSBDUFVzIG9yIHRo
ZSBhY3R1YWwga2VybmVsDQo+IGNvbmZpZ3VyYXRpb24gaW50byBhY2NvdW50LiBCdXQgdGhlIHBy
aW5jaXBsZSBpdHNlbGYgd29ya3MgY29ycmVjdGx5Lg0KPiANCj4gQmVsb3cgaXMgYW4gdXBkYXRl
ZCB2ZXJzaW9uLCB3aGljaCB0YWtlcyB0aGVtIGludG8gYWNjb3VudC4NCj4gDQo+IFRoZSBkYXRh
IGhlcmUgaXMgZnJvbSBhIHR3byBzb2NrZXQgc3lzdGVtIHdpdGggMzIgQ1BVcyBwZXIgc29ja2V0
Lg0KPiANCj4gTm8gY29tbWFuZCBsaW5lIHBhcmFtZXRlcnMgKE5SX0NQVVM9NjQpOg0KPiANCj4g
wqBzbXBib290OiBBbGxvd2luZyA2NCBDUFVzLCAzMiBob3RwbHVnIENQVXMNCj4gwqBjbG9ja3Nv
dXJjZTogdHNjLWVhcmx5OiBtYXNrOiAweGZmZmZmZmZmZmZmZmZmZmYgbWF4X2N5Y2xlczoNCj4g
MHgxZTMzMDZiOWFkYSwgbWF4X2lkbGVfbnM6IDQ0MDc5NTIyNDQxMyBucw0KPiDCoHNtcDogQnJv
dWdodCB1cCAxIG5vZGUsIDMyIENQVXMNCj4gwqBzbXBib290OiBNYXggbG9naWNhbCBwYWNrYWdl
cyBBQ1BJIGVudW1lcmF0aW9uOiAyDQo+IA0KPiAicG9zc2libGVfY3B1cz0zMiIgKE5SX0NQVVM9
NjQpIG9yDQo+IE5vIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIgKE5SX0NQVVM9MzIpOg0KPiANCj4g
wqBzbXBib290OiBBbGxvd2luZyAzMiBDUFVzLCAwIGhvdHBsdWcgQ1BVcw0KPiDCoGNsb2Nrc291
cmNlOiB0c2MtZWFybHk6IG1hc2s6IDB4ZmZmZmZmZmZmZmZmZmZmZiBtYXhfY3ljbGVzOg0KPiAw
eDFlMzMwNmI5YWRhLCBtYXhfaWRsZV9uczogNDQwNzk1MjI0NDEzIG5zDQo+IMKgc21wOiBCcm91
Z2h0IHVwIDEgbm9kZSwgMzIgQ1BVcw0KPiDCoHNtcGJvb3Q6IE1heCBsb2dpY2FsIHBhY2thZ2Vz
IEFDUEkgZW51bWVyYXRpb246IDENCj4gDQo+IG1heGNwdXM9MzINCj4gwqBzbXBib290OiBBbGxv
d2luZyA2NCBDUFVzLCAwIGhvdHBsdWcgQ1BVcw0KPiDCoGNsb2Nrc291cmNlOiB0c2MtZWFybHk6
IG1hc2s6IDB4ZmZmZmZmZmZmZmZmZmZmZiBtYXhfY3ljbGVzOg0KPiAweDFlMzMwNmI5YWRhLCBt
YXhfaWRsZV9uczogNDQwNzk1MjI0NDEzIG5zDQo+IMKgc21wOiBCcm91Z2h0IHVwIDEgbm9kZSwg
MzIgQ1BVcw0KPiDCoHNtcGJvb3Q6IE1heCBsb2dpY2FsIHBhY2thZ2VzIEFDUEkgZW51bWVyYXRp
b246IDINCj4gDQo+IEJ1dCB0aGF0J3MgcmVhbGx5IGFsbCB3ZSBzaG91bGQgZG8uIElmIHRoZSBB
Q1BJIHRhYmxlIGVudW1lcmF0ZXMgQ1BVcw0KPiBhcw0KPiBob3RwbHVnZ2FibGUgd2hpY2ggY2Fu
IG5ldmVyIGFycml2ZSwgdGhlbiBzbyBiZSBpdC4NCj4gDQo+IFdlIGhhdmUgZW5vdWdoIHBhcmFt
ZXRlcnMgdG8gb3ZlcnJpZGUgdGhlIEJJT1Mgbm9uc2Vuc2UuIFRyeWluZyB0byBkbw0KPiBtb3Jl
IG1hZ2ljIE1BRCB0YWJsZSBwYXJzaW5nIHdpdGggaGV1cmlzdGljcyBpcyBqdXN0IHdyb25nLg0K
PiANCj4gV2UgYWxyZWFkeSBoYXZlIHdheSB0b28gbWFueSBoZXVyaXN0aWNzIGFuZCB3b3JrYXJv
dW5kcyBmb3IgYnJva2VuDQo+IGZpcm13YXJlLCBidXQgZm9yIHRoZSBwcm9ibGVtIGF0IGhhbmQs
IHdlIHJlYWxseSBkb24ndCBuZWVkIG1vcmUuDQo+IA0KPiBUaGUgb25seSBzeXN0ZW1zIEkgb2Jz
ZXJ2ZWQgc28gZmFyIHdoaWNoIGhhdmUgYSBub24tc2Vuc2ljYWwgYW1vdW50DQo+IG9mDQo+ICJo
b3RwbHVnZ2FibGUiIENQVXMgYXJlIGhpZ2gtZW5kIHNlcnZlciBtYWNoaW5lcy4NCg0KV2Ugc2Vl
IGluc2FuZSBwb3NzaWJsZSBDUFVzIG9uIElWQiBzZXJ2ZXJzLCBvbmUgZnJvbSBQZXRlciBhbmQg
b25lIGluDQpMS1AgbGFiLCBtYXliZSBhIGRpZmZlcmVudCBwcm9ibGVtIGJ1dCBzdGlsbCByZWxh
dGVkLCBiZWNhdXNlIHRoZXkgbWF5DQpjYXVzZSBib2d1cyBfX21heF9sb2dpY2FsX3BhY2thZ2Vz
IGRldGVjdGVkLg0KDQpCZWxvdyBpcyBmaXggSSBtYWRlIGJ1dCBJIGRvbid0IGhhdmUgY2hhbmNl
IHRvIHRlc3QgaXQgeWV0Lg0KDQpGcm9tIDc3MTUyYmNlYjA1OTk0NGVlNDlhYzBkYzQ1ZTMxMzM1
NDU5MGMzYWIgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBaaGFuZyBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+DQpEYXRlOiBGcmksIDIzIEp1biAyMDIzIDEyOjE0OjI4ICswODAwDQpT
dWJqZWN0OiBbUEFUQ0ggUkZDXSB4ODYvYWNwaTogSWdub3JlIGludmFsaWQgeDJBUElDIGVudHJp
ZXMNCg0KQWNjb3JkaW5nIHRvIGh0dHBzOi8vdWVmaS5vcmcvc3BlY3MvQUNQSS82LjUvMDVfQUNQ
SV9Tb2Z0d2FyZV9Qcm9ncmFtbWluZ19Nb2RlbC5odG1sI3Byb2Nlc3Nvci1sb2NhbC14MmFwaWMt
c3RydWN0dXJlDQoiW0NvbXBhdGliaWxpdHkgbm90ZV0gT24gc29tZSBsZWdhY3kgT1NlcywgTG9n
aWNhbCBwcm9jZXNzb3JzIHdpdGggQVBJQw0KSUQgdmFsdWVzIGxlc3MgdGhhbiAyNTUgKHdoZXRo
ZXIgaW4gWEFQSUMgb3IgWDJBUElDIG1vZGUpIG11c3QgdXNlIHRoZQ0KUHJvY2Vzc29yIExvY2Fs
IEFQSUMgc3RydWN0dXJlIHRvIGNvbnZleSB0aGVpciBBUElDIGluZm9ybWF0aW9uIHRvIE9TUE0s
DQphbmQgdGhvc2UgcHJvY2Vzc29ycyBtdXN0IGJlIGRlY2xhcmVkIGluIHRoZSBEU0RUIHVzaW5n
IHRoZSBQcm9jZXNzb3IoKQ0Ka2V5d29yZC4gTG9naWNhbCBwcm9jZXNzb3JzIHdpdGggQVBJQyBJ
RCB2YWx1ZXMgMjU1IGFuZCBncmVhdGVyIG11c3QgdXNlDQp0aGUgUHJvY2Vzc29yIExvY2FsIHgy
QVBJQyBzdHJ1Y3R1cmUgYW5kIGJlIGRlY2xhcmVkIHVzaW5nIHRoZSBEZXZpY2UoKQ0Ka2V5d29y
ZC4iDQoNClRoaXMgbWVhbnMgdGhhdCBpZiB2YWxpZCBMQVBJQyBlbnRyaWVzIGFyZSBhbHJlYWR5
IGRldGVjdGVkLCB0aGUgQVBJQyBJRA0KaW4geDJBUElDIG11c3QgYmUgZXF1YWwgdG8gb3IgbGFy
Z2VyIHRoYW4gMHhmZi4NCg0KT24gYW4gSVZCLUVQIDIgc29ja2V0cyBzeXN0ZW0gd2l0aCAyMCBD
UFVzIHBlciBzb2NrZXQsIExpbnV4IGRldGVjdHMgNDANCnByZXNlbnQgQ1BVcyBmcm9tIExBUElD
LCBhbmQgODAgcG9zc2libGUgQ1BVcyBmcm9tIHgyQVBJQywgd2hpbGUgbWFueSBvZg0KdGhlIHgy
QVBJQyBlbnRyaWVzIHNoYXJlIHRoZSBzYW1lIEFQSUMgSUQgd2l0aCBMQVBDSSBlbnRyaWVzIGxp
a2UgYmVsb3cuDQoNClswMkNoIDAwNDQgICAxXSAgICAgICAgICAgICAgICBTdWJ0YWJsZSBUeXBl
IDogMDAgW1Byb2Nlc3NvciBMb2NhbCBBUElDXQ0KWzAyRmggMDA0NyAgIDFdICAgICAgICAgICAg
ICAgIExvY2FsIEFwaWMgSUQgOiAwMA0KLi4uDQpbMTY0aCAwMzU2ICAgMV0gICAgICAgICAgICAg
ICAgU3VidGFibGUgVHlwZSA6IDAwIFtQcm9jZXNzb3IgTG9jYWwgQVBJQ10NClsxNjdoIDAzNTkg
ICAxXSAgICAgICAgICAgICAgICBMb2NhbCBBcGljIElEIDogMzkNClsxNkNoIDAzNjQgICAxXSAg
ICAgICAgICAgICAgICBTdWJ0YWJsZSBUeXBlIDogMDAgW1Byb2Nlc3NvciBMb2NhbCBBUElDXQ0K
WzE2RmggMDM2NyAgIDFdICAgICAgICAgICAgICAgIExvY2FsIEFwaWMgSUQgOiBGRg0KLi4uDQpb
M0VDaCAxMDA0ICAgMV0gICAgICAgICAgICAgICAgU3VidGFibGUgVHlwZSA6IDA5IFtQcm9jZXNz
b3IgTG9jYWwgeDJBUElDXQ0KWzNGMGggMTAwOCAgIDRdICAgICAgICAgICAgICAgIFByb2Nlc3Nv
ciB4MkFwaWMgSUQgOiAwMDAwMDAwMA0KLi4uDQpbQjVDaCAyOTA4ICAgMV0gICAgICAgICAgICAg
ICAgU3VidGFibGUgVHlwZSA6IDA5IFtQcm9jZXNzb3IgTG9jYWwgeDJBUElDXQ0KW0I2MGggMjkx
MiAgIDRdICAgICAgICAgICAgICAgIFByb2Nlc3NvciB4MkFwaWMgSUQgOiAwMDAwMDA3Nw0KDQpG
b2xsb3cgdGhlIEFDUEkgc3BlYyB0byBpZ25vcmUgc3VjaCB4MkFQSUMgZW50cmllcy4NCg0KU2ln
bmVkLW9mZi1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KLS0tDQogYXJjaC94
ODYva2VybmVsL2FjcGkvYm9vdC5jIHwgMzUgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMgYi9hcmNoL3g4Ni9r
ZXJuZWwvYWNwaS9ib290LmMNCmluZGV4IDFjMzgxNzRiNWYwMS4uOWUwNmNjODJhZTk1IDEwMDY0
NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2FjcGkvYm9vdC5jDQorKysgYi9hcmNoL3g4Ni9rZXJu
ZWwvYWNwaS9ib290LmMNCkBAIC0xOTksNiArMTk5LDggQEAgc3RhdGljIGJvb2wgX19pbml0IGFj
cGlfaXNfcHJvY2Vzc29yX3VzYWJsZSh1MzIgbGFwaWNfZmxhZ3MpDQogCXJldHVybiBmYWxzZTsN
CiB9DQogDQorc3RhdGljIGJvb2wgaGFzX2xhcGljX2NwdXM7DQorDQogc3RhdGljIGludCBfX2lu
aXQNCiBhY3BpX3BhcnNlX3gyYXBpYyh1bmlvbiBhY3BpX3N1YnRhYmxlX2hlYWRlcnMgKmhlYWRl
ciwgY29uc3QgdW5zaWduZWQgbG9uZyBlbmQpDQogew0KQEAgLTIyNyw2ICsyMjksMTQgQEAgYWNw
aV9wYXJzZV94MmFwaWModW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICpoZWFkZXIsIGNvbnN0
IHVuc2lnbmVkIGxvbmcgZW5kKQ0KIAlpZiAoIWFjcGlfaXNfcHJvY2Vzc29yX3VzYWJsZShwcm9j
ZXNzb3ItPmxhcGljX2ZsYWdzKSkNCiAJCXJldHVybiAwOw0KIA0KKwkvKg0KKwkgKiBBY2NvcmRp
bmcgdG8gaHR0cHM6Ly91ZWZpLm9yZy9zcGVjcy9BQ1BJLzYuNS8wNV9BQ1BJX1NvZnR3YXJlX1By
b2dyYW1taW5nX01vZGVsLmh0bWwjcHJvY2Vzc29yLWxvY2FsLXgyYXBpYy1zdHJ1Y3R1cmUNCisJ
ICogd2hlbiBNQURUIHByb3ZpZGVzIGJvdGggdmFsaWQgTEFQSUMgYW5kIHgyQVBJQyBlbnRyaWVz
LCB0aGUgQVBJQyBJRA0KKwkgKiBpbiB4MkFQSUMgbXVzdCBiZSBlcXVhbCBvciBncmVhdGVyIHRo
YW4gMHhmZi4NCisJICovDQorCWlmIChoYXNfbGFwaWNfY3B1cyAmJiBhcGljX2lkIDwgMHhmZikN
CisJCXJldHVybiAwOw0KKw0KIAkvKg0KIAkgKiBXZSBuZWVkIHRvIHJlZ2lzdGVyIGRpc2FibGVk
IENQVSBhcyB3ZWxsIHRvIHBlcm1pdA0KIAkgKiBjb3VudGluZyBkaXNhYmxlZCBDUFVzLiBUaGlz
IGFsbG93cyB1cyB0byBzaXplDQpAQCAtMjUyLDYgKzI2Miw3IEBAIHN0YXRpYyBpbnQgX19pbml0
DQogYWNwaV9wYXJzZV9sYXBpYyh1bmlvbiBhY3BpX3N1YnRhYmxlX2hlYWRlcnMgKiBoZWFkZXIs
IGNvbnN0IHVuc2lnbmVkIGxvbmcgZW5kKQ0KIHsNCiAJc3RydWN0IGFjcGlfbWFkdF9sb2NhbF9h
cGljICpwcm9jZXNzb3IgPSBOVUxMOw0KKwlpbnQgY3B1Ow0KIA0KIAlwcm9jZXNzb3IgPSAoc3Ry
dWN0IGFjcGlfbWFkdF9sb2NhbF9hcGljICopaGVhZGVyOw0KIA0KQEAgLTI3NSwxMCArMjg2LDEx
IEBAIGFjcGlfcGFyc2VfbGFwaWModW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICogaGVhZGVy
LCBjb25zdCB1bnNpZ25lZCBsb25nIGVuZCkNCiAJICogdG8gbm90IHByZWFsbG9jYXRpbmcgbWVt
b3J5IGZvciBhbGwgTlJfQ1BVUw0KIAkgKiB3aGVuIHdlIHVzZSBDUFUgaG90cGx1Zy4NCiAJICov
DQotCWFjcGlfcmVnaXN0ZXJfbGFwaWMocHJvY2Vzc29yLT5pZCwJLyogQVBJQyBJRCAqLw0KKwlj
cHUgPSBhY3BpX3JlZ2lzdGVyX2xhcGljKHByb2Nlc3Nvci0+aWQsCS8qIEFQSUMgSUQgKi8NCiAJ
CQkgICAgcHJvY2Vzc29yLT5wcm9jZXNzb3JfaWQsIC8qIEFDUEkgSUQgKi8NCiAJCQkgICAgcHJv
Y2Vzc29yLT5sYXBpY19mbGFncyAmIEFDUElfTUFEVF9FTkFCTEVEKTsNCi0NCisJaWYgKGNwdSA+
PSAwKQ0KKwkJaGFzX2xhcGljX2NwdXMgPSB0cnVlOw0KIAlyZXR1cm4gMDsNCiB9DQogDQpAQCAt
MTExOCwyMSArMTEzMCwxMCBAQCBzdGF0aWMgaW50IF9faW5pdCBhY3BpX3BhcnNlX21hZHRfbGFw
aWNfZW50cmllcyh2b2lkKQ0KIAkJCQkgICAgICBhY3BpX3BhcnNlX3NhcGljLCBNQVhfTE9DQUxf
QVBJQyk7DQogDQogCWlmICghY291bnQpIHsNCi0JCW1lbXNldChtYWR0X3Byb2MsIDAsIHNpemVv
ZihtYWR0X3Byb2MpKTsNCi0JCW1hZHRfcHJvY1swXS5pZCA9IEFDUElfTUFEVF9UWVBFX0xPQ0FM
X0FQSUM7DQotCQltYWR0X3Byb2NbMF0uaGFuZGxlciA9IGFjcGlfcGFyc2VfbGFwaWM7DQotCQlt
YWR0X3Byb2NbMV0uaWQgPSBBQ1BJX01BRFRfVFlQRV9MT0NBTF9YMkFQSUM7DQotCQltYWR0X3By
b2NbMV0uaGFuZGxlciA9IGFjcGlfcGFyc2VfeDJhcGljOw0KLQkJcmV0ID0gYWNwaV90YWJsZV9w
YXJzZV9lbnRyaWVzX2FycmF5KEFDUElfU0lHX01BRFQsDQotCQkJCXNpemVvZihzdHJ1Y3QgYWNw
aV90YWJsZV9tYWR0KSwNCi0JCQkJbWFkdF9wcm9jLCBBUlJBWV9TSVpFKG1hZHRfcHJvYyksIE1B
WF9MT0NBTF9BUElDKTsNCi0JCWlmIChyZXQgPCAwKSB7DQotCQkJcHJfZXJyKCJFcnJvciBwYXJz
aW5nIExBUElDL1gyQVBJQyBlbnRyaWVzXG4iKTsNCi0JCQlyZXR1cm4gcmV0Ow0KLQkJfQ0KLQ0K
LQkJY291bnQgPSBtYWR0X3Byb2NbMF0uY291bnQ7DQotCQl4MmNvdW50ID0gbWFkdF9wcm9jWzFd
LmNvdW50Ow0KKwkJY291bnQgPSBhY3BpX3RhYmxlX3BhcnNlX21hZHQoQUNQSV9NQURUX1RZUEVf
TE9DQUxfTEFQSUMsDQorCQkJCQlhY3BpX3BhcnNlX2xhcGljLCBNQVhfTE9DQUxfQVBJQyk7DQor
CQl4MmNvdW50ID0gYWNwaV90YWJsZV9wYXJzZV9tYWR0KEFDUElfTUFEVF9UWVBFX0xPQ0FMX1gy
QVBJQywNCisJCQkJCWFjcGlfcGFyc2VfeDJhcGljLCBNQVhfTE9DQUxfQVBJQyk7DQogCX0NCiAJ
aWYgKCFjb3VudCAmJiAheDJjb3VudCkgew0KIAkJcHJfZXJyKCJObyBMQVBJQyBlbnRyaWVzIHBy
ZXNlbnRcbiIpOw0KLS0gDQoyLjM0LjENCg0KDQoNCg0KDQoNCg0K
