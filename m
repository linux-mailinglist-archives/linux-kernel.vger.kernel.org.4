Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9306C69DB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjBUICC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjBUIBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:01:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47F61715F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676966512; x=1708502512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vq+gjfNX5ghkUyu+wPFjtDLtO5YaPFJr/Ze+zalmZjI=;
  b=Fwonx3yJ71RD8IFp6wKhexmRjUMzkg+c0lJ7K4z5mj4vmwxvYTqFiur8
   AzoCwXEox7+962RgGbL4k28MFXHMEfWkibBh40LBPTS5gFIlyvQKKOAwh
   ziw2czky+usg5ysKUq11jDjSXk900kV6AhsSbDgM4NqKUAbv0sjdZq0zK
   LWXGPvFZCjJ7H39p/89lU8KuvNRo21u04+fMDUV+r740E35UXg1gPblUj
   +6JEBHmCeZ2BoXXa5HfrWOL15HhMEfWqPPChRJnwNQ0/8VAClZZKv5Gv3
   oODSvfSvxA+ffH/ZRxzTqlNya4Na6+O10caI5ZLRRMP0raUFcCOgBUr5t
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="418796202"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="418796202"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 00:01:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="671561232"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="671561232"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2023 00:01:51 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 00:01:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 00:01:51 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 00:01:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASdaHcUV20PBnx7l5znuDhfd7XsNQWkUuujK8oBni7dTQtq+KEMf11UDsf9vjKrH30ZhJl8ujVeyktpwM8ijvDyCQ3j7FiG2Kxi6X9ZYAseGQogsH75gppu5O/kpqJnT0vM3TYiWxq2vp7pboT53/3U/p5WEiY2W3AelkBWO/cfksYoDoIVqK9Tqtwkh+lvMx+AxOTUXWLJ+jAh/fTTtg/AKz/E5AX0wXysW9gJLwy8QoCP0JL/0QUXtkTjyXRNiGXQo3/+9gXfLEx8/Q1JGuI5cDAqNYEfxa9gJGcNLLOBsAJdnD5JxVwulDsTk493U45VuGSUIMtg2aKphqZ5g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vq+gjfNX5ghkUyu+wPFjtDLtO5YaPFJr/Ze+zalmZjI=;
 b=db45+MChRBuT+CPLrs32Zi02DLwjUDR4dz/mtqLF2XwUYvN3AtTKsK3HiUVnnw8JWsU2Sg09kSAbGqTjFSb4BemY8jGoBoHCbDIKJzuF44rsFLk9SOHQ6hT48T+SZhFBY4vN5hBR3gdKeXkMmKe6JLCsa6SkR6NNQ2XWWJwuGLrHtwpShYZAj5XfKd9+grh0McbrWuYg+ml2X8FeqWoxLB2DurvDQy6J6r2lTngndIbLMSz3y7VQeIcQ1FpMYUnytPaeNmiBoicuXsegSSWD4UzwjNGP25TT1JU6ZgxsGuIqJ8UmUS1PDf6AG3vdQmXoRJ2mDTViYxspSAByd7thmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB4941.namprd11.prod.outlook.com (2603:10b6:a03:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 08:01:45 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6111.018; Tue, 21 Feb 2023
 08:01:45 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Topic: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Index: AQHZRNuCmUZrj67G7kGhK77N+UN9Nq7XrYkAgAA5PoCAAExHgIAA2LQA
Date:   Tue, 21 Feb 2023 08:01:44 +0000
Message-ID: <ec1dca74ee606fb72a382ee55f91d99b2373b816.camel@intel.com>
References: <20230220032856.661884-1-rui.zhang@intel.com>
         <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
         <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
         <Y/PEnzRCZXA94cuw@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/PEnzRCZXA94cuw@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB4941:EE_
x-ms-office365-filtering-correlation-id: 63ffe7ea-8f64-4dd7-5328-08db13e1e00b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rVwEB98zPxWmTmcojw4LXgMDee4VLZm12fY13oSLEyPiqJBqihdOj/s7GQIoU0T+1TIoR8SA03d9y8xeqjEEzW+Z85TjR8K7XcNR3EbFKuypoSR7doIZEmKq0An7GKqtNiswq09ERfb92Svat3WuaMMauV4v6NEF2Lc/5OQmG1ZzMfxt37e4nWP/53sVrE3LSakC1CWN4TdhqdW/GRwNh9t94gfiYqC0HNiKpTbgmQoQIC37wTidFYV9n2R+eAoDdi+whCu4+bdpxuDbFJMS+egJuMjh2LF6XRMFgUtBLxE0zC0bxwqrLEC+VEYdpOujtTWbdJHdl7L+pI8hwsuaMYgecO/PScUJ8Fr2XHsweK80joJwTRXEsh/gpu6/5N/HGaDHQfHXt3Eg7HfSKowyJkq2Vb+E83XHul1+tRbnmOKcWrBtKWb5bvSH6obCXnxB12BZBEaV9GP8U8cfPg2Tuqr5DHLYNRFmU5dKIvfrAQ1D2yYO2pCQ+9cQxMEWSdjnAg8+n13iziSE3Pf3wBNWOTtv7VJADh35P50M7TkB6evyllxpdM2IzFsSg2PMbQgBvUN8BShMEN89ZnvUAxeu+jCdRUHiV8OlSbhMusGDqMkOvZ1p/SB+oVoi45CbBa4YtC7+8NuIXgaPcjUlCJ4Ze6NKm7H7JkPC0Ep1nvga/4gh1hdKe47WXzwjlHyLCX89FcF38mmgWkCij/n/20Ffvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(36756003)(8936002)(5660300002)(316002)(41300700001)(2616005)(6916009)(8676002)(64756008)(6512007)(186003)(66446008)(66476007)(66556008)(4326008)(26005)(86362001)(2906002)(83380400001)(76116006)(66946007)(6506007)(122000001)(71200400001)(6486002)(478600001)(54906003)(91956017)(82960400001)(4744005)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVBTL05CaEkvMFhzUkFlcm5rbG84VEdhRTVkM1ArNVBkUmxTNlZpOUJ3UUla?=
 =?utf-8?B?SVEzRTVLWHo2VVNOZDR0NFdxclkvMkdlQUR1QTVoN09vZE9tV0VjaysyRVlH?=
 =?utf-8?B?NExIRDdxWk40cW5NQXlJRXBjTTQ0bnNkeG9sOS9tSlI5Q051cjU4TjhaMEJq?=
 =?utf-8?B?eERnUnhYNHVWbkpBWWdkbkNTcE5mbTg0aUduYVN4WnVRNkJtakowZ2Z3RjIr?=
 =?utf-8?B?T0ptbTZCalVyZzNUM2RzK2U5Y1pHblRBc0txZ09NOTBON1R3Y25PNlMxc2xt?=
 =?utf-8?B?NFUyaXM4V2NsZWs4cEtVaE9tV1BDdldFVFNJc01LdmlDUEJMYjJ3TXdaUkNw?=
 =?utf-8?B?d0w3YmNZdEYwUi84Z0p1OWdyTXArUjNnR0tSQlBOWnN6K1k3WjBpNmVhUjlK?=
 =?utf-8?B?elYya3dqbkVpQ0dZYTI2Zjhya25LM2kxakV6ekxWaTV2OTdTU3NVQjBhZ1RD?=
 =?utf-8?B?cExvQ2YzU1I1YkVWWEp2ekpqTlpUTXlUK2Q2S3R5TWZybTF6c25Xa3FmODNn?=
 =?utf-8?B?ODVzVDFlT0YvVm1wQWxwUktxMjUvM3dDNS9vNUdPd2I1RzQwOGRWUXZQTDBi?=
 =?utf-8?B?ZEhKd2IrRGRORWxrbmI2bUtMTmYyUE9FYWhCRXJPTVMrZlFMSXplcnIvdUJj?=
 =?utf-8?B?SXVCVXp2R2JHbEd0NkNiNk1SZEJVZUxhNTBrMFRRaEY2NXJjdmIzQzdoZ3oy?=
 =?utf-8?B?RDYyZ0RKWHFDN0RIc0hHaDU4TXplOHlQelE5ZE9xQ3JiV3J0Qk1sdFh0Skg0?=
 =?utf-8?B?NVgwM1I1ekpSYVF2eU5FRVhQYllUNGtjZGpRelBKOHlNUW1EaFpKcDg1dU9z?=
 =?utf-8?B?NkVtVGhicWxwWWc2TlBHc2RSNFp5cEtaTWtJL3RnOEpvaXNIYU02N3RTdTJy?=
 =?utf-8?B?Z3NuTXdrTXZzREJVMzhBMVovc0U0N0JPbHJNdnptZDQyaGM3T3hNZzJrMlRG?=
 =?utf-8?B?NDlaZnNMR3Z0VGVLdUJvbkJ1MUxSK2xaa2NYc3g3blBjMTlkQldhSDBJVlgy?=
 =?utf-8?B?eWxVUGRuQXBEVXZoR0xMaTRxSXdzTkF4Mm53K0ZmSkduNVJDcjQzcTdZT3dv?=
 =?utf-8?B?WXhqaGJZVkJGT2F0aTVrd3dnVmJ6OGxLa2c2TlhSMDdCUStlejhmL20xRXNw?=
 =?utf-8?B?S01CY0dveTh2L0JMOXFyZkdRSEkwNHBsQ2ZFSTBIaDR0UGJKTFYvVTlydTkz?=
 =?utf-8?B?M0NWZ3JjbjVFaHRQQ2RmcUNrU1lvZm91ZHdUcXVmNEN0Z1VNbTRubFdmR0lu?=
 =?utf-8?B?M1FiOVRzQktkM0xJYStrcUJWUVZpNWlkWisvRkIwSk4zcUlzRGVBaTZ1cEhz?=
 =?utf-8?B?YnJqbVlJeEZ3S29kbUcwRlJDeDRkTzZGWTUzVVBQeUJpU3BuU3piRHBLcThl?=
 =?utf-8?B?eTFMaCtycmtCdUIxdlYycGJCbmRwS291OGVtbThCS3Z0TzMyVTRycUhPendL?=
 =?utf-8?B?cmtONkI1SzB1dE9HYkhXTURFUkZJNUtvL2dWL2dzNGpzdUZVblNIVjFjQkJu?=
 =?utf-8?B?Si91ZWZSS0lzbGMwcG5ja3VBME1TaFd3V2g0NnNNS0s0RXhZM1JOTlJLM2Iy?=
 =?utf-8?B?R09vUk5hK2IxS0lBeStLYmYrTGhjVnk1WmZZclRDSHJtTGF0bjQ1NzlQZC9X?=
 =?utf-8?B?NGNoTHd5RTVqMU9POFV3NXh3R0RIMWFPSFI4YWtOVUQyQkxtMi9MTkRVa3c0?=
 =?utf-8?B?N05LdjJyc284eG45TW43N0xtT045VU9mWWtJSGV1bHdFcTdtNXR3NUNmWEY3?=
 =?utf-8?B?YmxVZm5VdExSdzRmMXVSSHJzQW0xYUVTZ0d5SmRkMjhjTzdJWkVUazluUmdy?=
 =?utf-8?B?cnBaYWxabmMwSW1RcWQ1bTBPalV5dUlVajVVUGREbXpOejVRSWVudmtKL29V?=
 =?utf-8?B?bDlyMXBRaGoveTlJVHRJWUdwUXY2VmFiQlNabHJ2T2oyS1NSeDRGMGRvZzg4?=
 =?utf-8?B?Z0NxVllRWjhsQUIrNFZ3TVRsMmx3aXhUdkRjRXpRSGg4MXdKeEJRYkM4Q1Mw?=
 =?utf-8?B?Y1RkcHE3UTJzOHUvSXRyYkhkWGZ4RUxZSXRIOWVQNWYxY2REdjZLS3JnRDRa?=
 =?utf-8?B?cEV5anVreFNnWnhLdWo2QnRKWmw1UVFTVWhpZTRsaWNxOUEyWWZvMFlCUDg2?=
 =?utf-8?Q?w8VlfSkJC7KshjUZwUclFPgqd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91D9C5AD8C11464580E87BFB5C3E3FBE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ffe7ea-8f64-4dd7-5328-08db13e1e00b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 08:01:44.9840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1k4NV+TKbZRlwb/R0RPYI4EIVzsbWBdRQ9vk4NYaOfEJE874Eln4/+gQUW5x2+omUUn0BYH20qcRqFp/clFMwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4941
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBldGVyLA0KDQo+IFdlIGNvdWxkIGFkZCBhbiBhc3NlcnRpb24gaW4gU01QIGJyaW5ndXAg
dGhhdCB0aGUgQVBJQy1JRCBmcm9tIE1BRFQNCj4gbWF0Y2hlcyB0aGUgc3RhdGUgYXMgcmVhZCBm
cm9tIENQVUlEID8gSWYgdGhhdCBtYXRjaGVzIChpdCByZWFsbHkNCj4gc2hvdWxkKSB0aGVuIHVz
aW5nIHRoZSBNQURUIHRhYmxlIElEcyBlYXJseSBzaG91bGQgd29yayBhbmQgYXQgbGVhc3QNCj4g
Z2l2ZSB1cyBhIGxpdGxlIGJpdCBtb3JlIGRhdGEuDQo+IA0KPiBBUElDLUlEIGlzIG9mIG5vIHVz
ZSB2cyBoeWJyaWQgdGhvdWdoLA0KDQpEbyB5b3UgaGF2ZSBhbnkgcG9pbnRlciB0byB0aGUgaHli
cmlkIGlzc3VlIHlvdSdyZSByZWZlcnJpbmcgdG8gaGVyZT8NCkluIHdoaWNoIGNhc2Ugd2UgbmVl
ZCB0byBrbm93IGhvdyBtYW55IHR5cGUgb2YgY29yZXM/DQoNCnRoYW5rcywNCnJ1aQ0K
