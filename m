Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BFA732B42
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbjFPJTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbjFPJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:19:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0332695
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686907167; x=1718443167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1Jm0qTwLvacZkomsEd2UxRbl2MzzAqbezswZIDeT1cc=;
  b=hcRM87cW8aCYfs1fflzm8YeJ47mLwYgUzsnLC1Q81YgqfusEYaN2T2zP
   3+HhhbivxcfjSiqQtyxNdMnhLcQcDOO5D+fhhlANQrKS5a9PrkEiUKQor
   9Yy507Q7C+db88Y8Px7IZhRYI5RzCSwJQ8ZWlSsH4RcB0diiengUhuu1k
   6a3AP2gYPTQ+LWUhYmHtUyUed4O/WBuqgbYYXxV0daY7fz86YasEGA82z
   lG3HLK4VIqfPNA+dH491BRSea3kygNGBavz18Orm/ep0FeeO3dCl7C3Ab
   duEO1T81M1wMQr6Tb7afkNZElkCsj3pXgE87uSKSlFFpVu6LHuh9ftfrD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="422819045"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="422819045"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 02:19:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782839982"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="782839982"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2023 02:19:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 02:19:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 02:19:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 02:19:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADE7Bkmy4F1aD7vm0vYGBJCXaH9pAUl/DdIqnR10htWh7QJyWyHPw/QRZfIIa468tGrm7Tz8x/VpNnpjKKBUyUlwS9t9RkzoXKOlHkKYRF4SkCYxtkUzGyOHj/hn0pPkYidIglBALaijgXE16Nv19CZpnvCvQ6ApIfjN9ncQSKN47KyaZADwth293++TgR1fTHXkz/fjqWQ+8o9+dfazRzwxguLM1QfHckn4rjw4Aif80esiEpEldYNKuwVCjVIxlDYWF0ZnMRlOqysQkMnxtRINpZWKRJt+rcxwzm7Ta8n33UvHdAe91LVp7d+D0r4/QCGrqqeXbSbUbRsoravPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jm0qTwLvacZkomsEd2UxRbl2MzzAqbezswZIDeT1cc=;
 b=JqxdI2X4iGExFGdW2tvIcF5eiVaO6yu98Tn5h1UWYITIYepw6ndGfWCnH6r4XIEhfm/6l9DwO0xP+qsYN8JQWJl6Qgk9QM2c5e79tQ0KJ+o++fMrQbbgLwjXzvddSs9/bYUrOj7BAVCmzGFdxAz+yfvY7WBlopkTk0VKa1z451+gZQxNAG6N2KxeTXLSipbq5kXGPuyvgK4jLs3vFufKgit5LOXOYksk/2OHMVn8Q7PQGGc29vyMUHZVFHrVLycPh5ROWKrHKrD2sVzGtfhRsSc1FQKHgr1ZM6b9rvqfKe2CCc3Vnw3TO85dUVVsNXnplDfyLMX7LChRjaryCLk0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by IA0PR11MB7954.namprd11.prod.outlook.com (2603:10b6:208:40e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 09:19:19 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::f6a8:daa0:7575:801d]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::f6a8:daa0:7575:801d%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 09:19:19 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Thread-Topic: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Thread-Index: AQHZnbiCY6eum+iSlk2uGaiesk42zq+LmcaAgAFpQICAABNVgIAAAjWAgAATPQA=
Date:   Fri, 16 Jun 2023 09:19:18 +0000
Message-ID: <d100b30d381b9d28b6fceab5e9c5042c3ca79ba8.camel@intel.com>
References: <20230613052523.1106821-1-feng.tang@intel.com>
         <20230613052523.1106821-2-feng.tang@intel.com>
         <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
         <d97fe59e47de77a36746107e4070e44ed46bf4d1.camel@intel.com>
         <20230616080231.GZ4253@hirez.programming.kicks-ass.net>
         <20230616081025.GM38236@hirez.programming.kicks-ass.net>
In-Reply-To: <20230616081025.GM38236@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|IA0PR11MB7954:EE_
x-ms-office365-filtering-correlation-id: 5490e44d-d3d2-46ed-554d-08db6e4ac372
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ip/iReyEhVDbs2LC2Ss6x9kZ9bhhDELZnwVM8kIMlPsjdZ/D1V0FUmSN4CzDE0krA391BEXAJNNQNWvr3MAR8tpeJ7iaMhLgIcTkttqTBofObj3rgGlhFQY0+r+igB2luCur7nyfATyyVp88bR7aWmzaORY904BAQBrIl7yHfv8EGHDVCqCIzZKtNAgzBeu+kaXBt4xlDITtkxov62vPHFBBHJqnyo0ddK6UwBhYhOElZ0LdyQhzGiRFIiGJCYx7L3Pk03NYux51KroHlEf9XzTOmNqHs/omp02Vcg7ISoayoEvpfutH9UYQrTNMmufbOVDxW4pQpaLRaP2f19CWqZNw+KLj6J3HJI6vJvPl7y1NYAKp9eiGjpbkiMTxvCA3I0mhVyC1UT75JJOxmp+uqe4/8asqwu86oLVzjPqCOzYPslnmiV/XHEAYif9KqkVLdHsdKMtgGqWomm3DC/xqFXKiyFggMK/R4RcewBhZ/gPGCyBXw2P/lMWsQtahOPUghUMQpzXE6RNbcSpyhStyJ3dW6lOhhdbzUPzp8T3LYPTamH4kvKrot24FYUP1fS35NgkdH2YL7AnkUJ7TWux8WcX5Kx3CzOEXAl3Cp0LJlKEGmpIANJyProjJAAvwmHzT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(478600001)(54906003)(122000001)(6486002)(5660300002)(8936002)(82960400001)(8676002)(41300700001)(2906002)(36756003)(38070700005)(86362001)(7416002)(38100700002)(64756008)(66446008)(66476007)(66556008)(316002)(6916009)(66946007)(4326008)(91956017)(76116006)(71200400001)(26005)(6512007)(6506007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ui9ha0J4U2ZoWGE5UmZBc3J2bFdLckFKOEZsRFhpTmVvTEJGYmxvUXlCMCtp?=
 =?utf-8?B?QjlUaHBsbkRkSTFyemZjVGhXK2FQTXMwMW5lcTYzUnh4aGJtS1UxYzJXUHRD?=
 =?utf-8?B?T0NSc1hLc0E2NHZwTk1RbVM3c211aDRtbmtwSElVU2JBYWxxc1dUL1VZVWtM?=
 =?utf-8?B?MXZPdmtKUU9wamc3WW84dFhIeTNZOHpYTHViakFneWo2TGc4SUFZWnoxdWVJ?=
 =?utf-8?B?c2JGa2U1anFQWHNpOWlnTDhiUW5Ob1JpdGxkenJxTHJxSTdnK3NDQnNOWDhG?=
 =?utf-8?B?eG9nN2QyekpBbzBEM3MrKzEvSlpNZjdYck5MTG9KS2VIQmc4bC9QaDh4QlEy?=
 =?utf-8?B?bENlRjZvemQxU2d4TjlHSCtSaTg1SzBXdXo5b0JzVmVORzk5Y2Y5ZzVpTTFx?=
 =?utf-8?B?SVh1SVBmNzgxOFFRdzh1OUFQZEQzV3gxUGRHcy8yZWtzVytxWVdkdzVEWmFy?=
 =?utf-8?B?SXAveEhqUWVnVzRFeGVKKzFRMCs0aDl5am9sL3R2cWRDZG5rU2JqQzE3SFBT?=
 =?utf-8?B?TUdicWg3VHlDSW5EMGdyQnduRU5vUmQ0Y2lpNmJFUldrQ2JFTy9FSHJOMDNU?=
 =?utf-8?B?ejhZWEI1SWpheHBVc3JUeW1OR2lxbE5KQUo4ZVFRbnVMazBNa1hoV3VVb28z?=
 =?utf-8?B?SUUrVnJFQTQyZGh1bHB1cGt0Z1c4bXA4YmNZbHdQenRnSzhqWGJ0a2lCMERL?=
 =?utf-8?B?OEtCQ1doMDZCZ2RrdjVabmVhYmFGb2RHOHpjbWIyVFhKR1lJVFlmWForSlhj?=
 =?utf-8?B?M2dzMEdyVWRSdG5tZStDTEJxUzgySytpNnBSZEFGR2x0MVBRNkw1M1kyY1hD?=
 =?utf-8?B?Zk0zWi9HZ1JtSTNKUk5pcFh0K0Z6Nzc4YnpUdEF1WVJvZEREWDd1YjJpY25J?=
 =?utf-8?B?NXc4Q3ZsV3NVNVRNZnArR3l3Z2JDNnVIbHNoMXZYczcvc0hxQVFObFpud3Yz?=
 =?utf-8?B?MnUwQUw0aExuRlEycUJ6em1ybGZ1NFB6VGVlN3JyWVgzc29NZU5USytKeDBj?=
 =?utf-8?B?bmZnM3F6RnFQb2JndFlPZUdWelhnakg2UC9PdHk4WHdldDZCMzRENkI2MTEx?=
 =?utf-8?B?NkZKcWdva0JBeDJUOFJFWnM4Vnk0L09UbG1HZmdqK1luaWl1c3I1T2NHYlh0?=
 =?utf-8?B?cHpvWmUxc0ZZakFUdytsVzByR0g2WVA3bW9oeVlpVi9PTk41R3p5MDltdUtw?=
 =?utf-8?B?Sk5IbFcrSnN2UVBzZ3E3QUh4dEdBVjZLYzEyV3VQL053UGVIMjJQNVNjZVVt?=
 =?utf-8?B?UUQ0L2lLRXo2bXVSanZVR3F3T3hhUjBXOHdIWVN5VWxlNzdNMVJ1QjVOK0RH?=
 =?utf-8?B?cFhRZEgwT093eFZsVzROTmV1Snp3NnBkS1doeURRZy9kZ3JkZTEvN0pJTm0y?=
 =?utf-8?B?a1lkV01ObGxyUU9ZOEZhZUYzMHJYV3lMR3BZS2s1eGsrbWFmV0RzV1U1aXFF?=
 =?utf-8?B?Zk9ZY2lZb1AwZ3NycHdtVUwyUGZBSk9HVUNFcElXQU5MSTQ2L1JZajhyMURh?=
 =?utf-8?B?eTR6ZmN6SSt4aHphWTJWWURLOURwOHdqd3lLZmhuWDVTUEtQRHJ3b3lBcUds?=
 =?utf-8?B?ZnVuM2hOTmRWR0VZdTNwVjhZSEtYUWd4VmpsUkJUNUg3VFd1Z0FSaEdoRFFx?=
 =?utf-8?B?eVFFeEpZN2RqVTlnWVE2UjZkL3VaMTE5N3JoMExFTEg3SmxLNWR4dGxzNEs3?=
 =?utf-8?B?NDlsQ2g0cFpWbm5UN2l0S2hoZVpsWVE5NGZRWmxlY2Z5emNnYzVnZDZjazFk?=
 =?utf-8?B?cEFXZzRFNXR6cVh2dG5ZMUM5K3QrUnJuWjRyUGhnWTJMNXNuQ0h3SkxIUGE2?=
 =?utf-8?B?LzdyQjlMSkhyQVVyVFE0bU5Wd1Z0ZXdrYlJHSEpwampEc0FoY2pwOU82Ykdu?=
 =?utf-8?B?RHpYVG1qeWwrQ0ZxdWpTbzEyRFF3a0taeXRmQ3lSa2FJdE9nM3ZKdzl4djgx?=
 =?utf-8?B?MjBZd3piZC94T2x5M01ybGFzcG9NZE1aVExrM05RNXJ6Rmx2a3RvemtzNWQw?=
 =?utf-8?B?cjRibjlCaEJkS3VkMUREb3FNZzZkeSs5S1VGMGExU2Nsd21RRXFlL25pUlZK?=
 =?utf-8?B?UFh6MS9uZjVrcDlUSC9ENHk2YXlaTUYzNkxNaHp4UXBOSmsza0ppcW1nY21o?=
 =?utf-8?B?WFM0WnIyRkJ0WWVzazBBcXREY0EzbGtmTExWT0dEMU04ZVdRQWswaDIyQmJN?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A81C127E1DAD744ABDB707A26910A7A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5490e44d-d3d2-46ed-554d-08db6e4ac372
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 09:19:18.8319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pB7tGNVj5HqVPuXUpdER2Z8G0ovdGLTanxNixZmBK66Ww3W6+kqgiqDVbFrpChMppQrhvQs2IYtcMzCrLuIL1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7954
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

T24gRnJpLCAyMDIzLTA2LTE2IGF0IDEwOjEwICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBKdW4gMTYsIDIwMjMgYXQgMTA6MDI6MzFBTSArMDIwMCwgUGV0ZXIgWmlqbHN0
cmEgd3JvdGU6DQo+ID4gT24gRnJpLCBKdW4gMTYsIDIwMjMgYXQgMDY6NTM6MjFBTSArMDAwMCwg
WmhhbmcsIFJ1aSB3cm90ZToNCj4gPiA+IE9uIFRodSwgMjAyMy0wNi0xNSBhdCAxMToyMCArMDIw
MCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+ID4gDQo+ID4gPiA+IFNvIEkgaGF2ZSBhdCBsZWFz
dCB0d28gbWFjaGluZXMgd2hlcmUgSSBib290IHdpdGgNCj4gPiA+ID4gJ3Bvc3NpYmxlX2NwdXM9
IycNCj4gPiA+ID4gYmVjYXVzZSB0aGUgQklPUyBNQURUIGlzIHJlcG9ydGluZyBhIHN0dXBpZCBu
dW1iZXIgb2YgQ1BVcyB0aGF0DQo+ID4gPiA+IGFyZW4ndA0KPiA+ID4gPiBhY3R1YWxseSB0aGVy
ZS4NCj4gPiA+IA0KPiA+ID4gRG9lcyB0aGUgTUFEVCByZXBvcnQgdGhvc2UgQ1BVcyBhcyBkaXNh
YmxlZCBidXQgb25saW5lIGNhcGFibGU/DQo+ID4gPiBjYW4geW91IHNlbmQgbWUgYSBjb3B5IG9m
IHRoZSBhY3BpZG1wPw0KPiA+IA0KPiA+IFNlbnQgcHJpdmF0ZWx5LCBpdCdzIGEgYml0IGJpZy4N
Cj4gDQo+IFNvIGlmIEkgcmVtb3ZlICdwb3NzaWJsZV9jcHVzPTQwJyBpdCBkb2VzIGNyYXp5IHNo
aXQgbGlrZSB0aGlzOg0KPiANCj4gW8KgwqDCoCAxLjI2ODQ0N10gc2V0dXBfcGVyY3B1OiBOUl9D
UFVTOjUxMiBucl9jcHVtYXNrX2JpdHM6MTYwDQo+IG5yX2NwdV9pZHM6MTYwIG5yX25vZGVfaWRz
OjINCj4gDQo+IFvCoMKgwqAgMS4zMDM1NjddIHBjcHUtYWxsb2M6IFswXSAwMDAgMDAxIDAwMiAw
MDMgMDA0IDAwNSAwMDYgMDA3DQo+IFvCoMKgwqAgMS4zMDk4NzFdIHBjcHUtYWxsb2M6IFswXSAw
MDggMDA5IDAyMCAwMjEgMDIyIDAyMyAwMjQgMDI1DQo+IFvCoMKgwqAgMS4zMTYxNzJdIHBjcHUt
YWxsb2M6IFswXSAwMjYgMDI3IDAyOCAwMjkgMDQwIDA0MiAwNDQgMDQ2DQo+IFvCoMKgwqAgMS4z
MjI0NzVdIHBjcHUtYWxsb2M6IFswXSAwNDggMDUwIDA1MiAwNTQgMDU2IDA1OCAwNjAgMDYyDQo+
IFvCoMKgwqAgMS4zMjg3NzddIHBjcHUtYWxsb2M6IFswXSAwNjQgMDY2IDA2OCAwNzAgMDcyIDA3
NCAwNzYgMDc4DQo+IFvCoMKgwqAgMS4zMzUwODRdIHBjcHUtYWxsb2M6IFswXSAwODAgMDgyIDA4
NCAwODYgMDg4IDA5MCAwOTIgMDk0DQo+IFvCoMKgwqAgMS4zNDEzODddIHBjcHUtYWxsb2M6IFsw
XSAwOTYgMDk4IDEwMCAxMDIgMTA0IDEwNiAxMDggMTEwDQo+IFvCoMKgwqAgMS4zNDc2ODhdIHBj
cHUtYWxsb2M6IFswXSAxMTIgMTE0IDExNiAxMTggMTIwIDEyMiAxMjQgMTI2DQo+IFvCoMKgwqAg
MS4zNTM5OTJdIHBjcHUtYWxsb2M6IFswXSAxMjggMTMwIDEzMiAxMzQgMTM2IDEzOCAxNDAgMTQy
DQo+IFvCoMKgwqAgMS4zNjAyOTNdIHBjcHUtYWxsb2M6IFswXSAxNDQgMTQ2IDE0OCAxNTAgMTUy
IDE1NCAxNTYgMTU4DQo+IFvCoMKgwqAgMS4zNjY1OTZdIHBjcHUtYWxsb2M6IFsxXSAwMTAgMDEx
IDAxMiAwMTMgMDE0IDAxNSAwMTYgMDE3DQo+IFvCoMKgwqAgMS4zNzI5MDBdIHBjcHUtYWxsb2M6
IFsxXSAwMTggMDE5IDAzMCAwMzEgMDMyIDAzMyAwMzQgMDM1DQo+IFvCoMKgwqAgMS4zNzkyMDFd
IHBjcHUtYWxsb2M6IFsxXSAwMzYgMDM3IDAzOCAwMzkgMDQxIDA0MyAwNDUgMDQ3DQo+IFvCoMKg
wqAgMS4zODU1MDRdIHBjcHUtYWxsb2M6IFsxXSAwNDkgMDUxIDA1MyAwNTUgMDU3IDA1OSAwNjEg
MDYzDQo+IFvCoMKgwqAgMS4zOTE4MDZdIHBjcHUtYWxsb2M6IFsxXSAwNjUgMDY3IDA2OSAwNzEg
MDczIDA3NSAwNzcgMDc5DQo+IFvCoMKgwqAgMS4zOTgxMDldIHBjcHUtYWxsb2M6IFsxXSAwODEg
MDgzIDA4NSAwODcgMDg5IDA5MSAwOTMgMDk1DQo+IFvCoMKgwqAgMS40MDQ0MTFdIHBjcHUtYWxs
b2M6IFsxXSAwOTcgMDk5IDEwMSAxMDMgMTA1IDEwNyAxMDkgMTExDQo+IFvCoMKgwqAgMS40MTA3
MTRdIHBjcHUtYWxsb2M6IFsxXSAxMTMgMTE1IDExNyAxMTkgMTIxIDEyMyAxMjUgMTI3DQo+IFvC
oMKgwqAgMS40MTcwMTZdIHBjcHUtYWxsb2M6IFsxXSAxMjkgMTMxIDEzMyAxMzUgMTM3IDEzOSAx
NDEgMTQzDQo+IFvCoMKgwqAgMS40MjMzMTldIHBjcHUtYWxsb2M6IFsxXSAxNDUgMTQ3IDE0OSAx
NTEgMTUzIDE1NSAxNTcgMTU5DQo+IA0KPiBbwqDCoMKgIDIuMTEwMzgyXSBzbXA6IEJyaW5naW5n
IHVwIHNlY29uZGFyeSBDUFVzIC4uLg0KPiBbwqDCoMKgIDIuMTEyMjU1XSB4ODY6IEJvb3Rpbmcg
U01QIGNvbmZpZ3VyYXRpb246DQo+IFvCoMKgwqAgMi4xMTMyNTNdIC4uLi4gbm9kZcKgICMwLCBD
UFVzOsKgwqDCoMKgwqDCoMKgwqDCoCAjMcKgwqAgIzLCoMKgICMzwqDCoCAjNMKgwqAgIzXCoMKg
DQo+ICM2wqDCoCAjN8KgwqAgIzjCoMKgICM5DQo+IFvCoMKgwqAgMi4yMjEyNTNdIC4uLi4gbm9k
ZcKgICMxLCBDUFVzOsKgwqDCoCAjMTANCj4gW8KgwqDCoCAwLjE2MzUyMl0gc21wYm9vdDogQ1BV
IDEwIENvbnZlcnRpbmcgcGh5c2ljYWwgMCB0byBsb2dpY2FsIGRpZSAxDQo+IFvCoMKgwqAgMi4z
MzczNzJdwqDCoCAjMTHCoCAjMTLCoCAjMTPCoCAjMTTCoCAjMTXCoCAjMTbCoCAjMTfCoCAjMTjC
oCAjMTkNCj4gW8KgwqDCoCAyLjUwNDI1M10gLi4uLiBub2RlwqAgIzAsIENQVXM6wqDCoMKgICMy
MMKgICMyMcKgICMyMsKgICMyM8KgICMyNMKgICMyNcKgDQo+ICMyNsKgICMyN8KgICMyOMKgICMy
OQ0KPiBbwqDCoMKgIDIuNTYzMjUzXSAuLi4uIG5vZGXCoCAjMSwgQ1BVczrCoMKgwqAgIzMwwqAg
IzMxwqAgIzMywqAgIzMzwqAgIzM0wqAgIzM1wqANCj4gIzM2wqAgIzM3wqAgIzM4wqAgIzM5DQo+
IFvCoMKgwqAgMi42NjIzMjFdIHNtcDogQnJvdWdodCB1cCAyIG5vZGVzLCA0MCBDUFVzDQo+IFvC
oMKgwqAgMi42NjQyNTddIHNtcGJvb3Q6IE1heCBsb2dpY2FsIHBhY2thZ2VzOiA4DQo+IA0KPiBJ
dCBpcyBhbiBJVkItRVAgd2l0aCAqMiogc29ja2V0cywgMTAgY29yZXMgYW5kIFNNVCwgNDAgaXMg
cmlnaHQsIDE2MA0KPiBpcw0KPiBxdWl0ZSBpbnNhbmUuDQoNCkFjY29yZGluZyB0byB0aGUgTUFE
VCwgdGhlcmUgYXJlIGluZGVlZCA0MCB2YWxpZCBDUFVzLiBBbmQgdGhlbiA4MCBDUFVzDQp3aXRo
IA0KDQpBUElDIElECQk6IEZGDQplbmFibGVkCQk6IDANCk9ubGluZSBjYXBhYmxlCTogMA0KDQph
IGR1bWIgcXVlc3Rpb24sIHdoeSBhcmUgdGhlc2UgQ1BVcyBhZGRlZCBpbnRvIHRoZSBwb3NzaWJs
ZV9tYXNrPw0KSSBjYW4gZGlnIGludG8gdGhpcyBsYXRlciBidXQgSSBqdXN0IGRvbid0IGhhdmUg
YSBxdWljayBhbnN3ZXIgYXQgdGhlDQptb21lbnQuDQoNCnRoYW5rcywNCnJ1aQ0K
