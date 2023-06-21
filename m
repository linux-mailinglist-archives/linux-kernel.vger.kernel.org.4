Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74D9738865
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjFUPHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjFUPHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:07:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1224B4219;
        Wed, 21 Jun 2023 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687359722; x=1718895722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mMRTf5lc+Rcklx+0DjZ6+bQl30fr3dv/JdkRFaTeV7c=;
  b=P7tVbxTKLhzXljhdZ2QOv1LJrW6F2gGlK5WmrryStePWRuBp25mie27b
   1+iHZcVbC5T8bFikgjtTdPFxcbJoLmByg/BVO2S27gjQ2CbF7Bxc04tr5
   tn1nLxGX8UByYkWZEfdaJuQO/X4UDljKaxLVBKThSuI6etZskfl0joPr4
   +BnTB+8mtNTTHATIoT5SLRgEDhKH80nqnSLCMJrhVf438098A0jDoLues
   by9fxa5ApXbRbZ0JmeIDYUcpbmYFfbrbRCWR+xlEYk1+f6vFTK15R5WbP
   hxk8PFOQbqs4IPXyKg1tI6cfCDk1yQYKwitnXD1103YtFOY0PNNFIMgLb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="339814041"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="339814041"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="961229317"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="961229317"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2023 07:58:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 07:58:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 07:58:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 07:58:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVXmlhmgzeiRMBSNTYI1W1lDjmZbiH5/UMl8Ivv4kUeDQbbGhXhX8SfYpA+Uh2bUdWk2LYGaVurYIQI6vpMPfina+FCIB6HqWZzXYZp0mggg6yOTHxSHSx2T73Qq8nO/tyYQJ5bxEP6lKWvRmB8gxMcb1Wb7WJEJ6ahTRTRzfk14Yne4tsTcOIgE5jQOFupoaeXQ4jeBnHTf50gGFo8zERuTZ5GC5Hbhg3gh8UPcdwNdMRkU8appyvRoaGujTlbZkZwLkNby+Qfy44LudqdDfkAEVbinQUwjVRbgT6TENTr9zs7JruMQH1x88dG1XVP9Vi7GKp5HfxRCdx5mbVV6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMRTf5lc+Rcklx+0DjZ6+bQl30fr3dv/JdkRFaTeV7c=;
 b=PgafrNqpNoYvnNNGuWH+VGqR5/cdW4A205tozAELyRrbrPoalsIRsMoc8ZS4afZlYu+mPzTOdt9Xwg2ypYfE/KQpTJsl9htt8F8j/YpoBgBpmyLk4M/A97B5KqaBgFR9VW9pEqvbab57HXqzpp6QZXJZ/wxdJnX+lauZy/brq+UMKE/qKgwIpHQqzudmlriH4Jb6yfzhIW6KWGbkWEY6EL9omzJxcQ4sROUF4f0KnkAslCkugzbDS5KfN8Llr0G0q80N8yeDNCaFDyyXAf4PHuA1SJezoBCoQA++C7WHj6MP2gwXt4CPtS1YVZpzccqTd0BGKsKUQkJNW/3r7bfNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com (2603:10b6:a03:4ed::18)
 by PH0PR11MB5807.namprd11.prod.outlook.com (2603:10b6:510:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 14:58:11 +0000
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf]) by SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:58:10 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] selftests/thermel/intel: Add test to read workload
 hint
Thread-Topic: [PATCH 7/7] selftests/thermel/intel: Add test to read workload
 hint
Thread-Index: AQHZo8s3B9RbI+84hEyMsxi/sEm8ma+VUkcAgAAHuIA=
Date:   Wed, 21 Jun 2023 14:58:10 +0000
Message-ID: <b84952341540c939ddf82dddef6b50a7d7992666.camel@intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
         <20230620230150.3068704-8-srinivas.pandruvada@linux.intel.com>
         <41d7a9144881cd536e545b57e193afc956646478.camel@intel.com>
In-Reply-To: <41d7a9144881cd536e545b57e193afc956646478.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0086:EE_|PH0PR11MB5807:EE_
x-ms-office365-filtering-correlation-id: a73a1ac6-d405-4c86-66da-08db7267ee4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lMy9/3F2i8UG+FFt7bWBVgOLx4ucL5DIPL+93I6g45WcZ2TO+fGWqqnwEQEifPqG6ifcUNsBe72Hn824feCYqo9thK7DsD0Omvg54JR5O8l8yrzVOb+A5okXCro1znJw+GP11uM/2vDAghvYWd+CgqvkBCoSkp5qUq/DNHXeRyDSmKG/ntGX5ErsG8x4lhaG2WkwS6oi/62AmSd+9U79peuwMqEvwO6GXZOK0BIxkHBsf1asvBNcoXbV6UvGvIt1kRLyb/kKKFNvGEmIIGFdkBh1HBScxhGkG2UlwTcZ2RY/paprXiaIbXFgDLQrzpo4ykWXsIEY5PjrsbR6Cb3+hmxSc8bkMboCNZifSopM6inMehIcpMURobWpThFsaudReSCr3TOOedH0oBioqIf4GEWepyLU8Uv7No03QrqVrKkP9bE0FkR7advnxT+bWaMf4BNtkWIW6p2CaI1yfdAaPgr3DKr0eSaTxEFq/OdQmiIN0wuldbW+jaN6MV/SLGhsBbReEWliuCOe4TdL9E4jn+lv21LTMRkZuY3C9luiCODLrqJucbucN/Z34TPsp7EL0P+2LyAOob1FVyjrZq5BnCta3eop7LY+h6U1jxrQEhqpnkoiXe5OJON8HfOC8hj3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(8676002)(5660300002)(8936002)(66556008)(4326008)(66946007)(64756008)(66476007)(91956017)(76116006)(66446008)(316002)(2906002)(54906003)(41300700001)(110136005)(6486002)(71200400001)(45080400002)(478600001)(6506007)(6512007)(186003)(83380400001)(36756003)(26005)(122000001)(82960400001)(2616005)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGloU01teGc0dmNJRlJRaEtNT3UwSGVRQlJaUDZzSGsza3pvalF4NXdpZFY4?=
 =?utf-8?B?Y3Jvd3BETFpSQTB5aGxqekZZTTBGWWlVREtNbzE1V252K0k0VGY1elhERVVL?=
 =?utf-8?B?MlpYQmlFbWpPYitOMWhiR2swWElVdXp2dFhWeE8wSnBHem05dXV2RytyT0Q3?=
 =?utf-8?B?eVgyaFY1NDFMUlBpeEtobmdPVE9ncnVTMEgxK2o5Tko1YVZWU09EVGNCd3dh?=
 =?utf-8?B?dGJZQjRhKzg2cnpzZTIxZmVtVGpWT1Z1anBZRms5elFiVVB5eWpNQ1VodVp3?=
 =?utf-8?B?cG9hMnovRVF1QThZNnFpNnNRdm1Xc0RtSEFQWURRWndXKzVuTUZYRm8xVGc5?=
 =?utf-8?B?clJGSEp5TUMyL3lZam5mUHg2aFhHNUVWaWk2YUlYRFZqOGdlT1lLczdZQURX?=
 =?utf-8?B?ZnBpbFBSeWk0SUpGWkhkVks2N3BGbnpnd0RHVEVsczVrQjBaODQzWXp6TEJr?=
 =?utf-8?B?b0VNVnZwMWIyMHhRNjJWaUloN3R4TTgxbzVaTm9IWkIyUUhiQk9lN0h6REpL?=
 =?utf-8?B?aC90NDJ1OXBJQ3JxYnhLSW5vYjErbFVXd3JFZHlyRzFWZWJnZnZYSEI1RW14?=
 =?utf-8?B?RXlLcE5yd2VsVjdTSUxBSUVRNkxQVGZLNUhPbUFIZFRNYTFBa1R3WXU5ZUVz?=
 =?utf-8?B?MGdCcjdQcGluUlVFU3haYzRQSGZOZ3hUbUEwMldTZnVncFBxZGMxdzMrcjBk?=
 =?utf-8?B?RHdpK014UmtwanFtZXVvSmFmS2kxU2c2MXFPL2I4Tlg0WjFkZU1aeHRMZ1ls?=
 =?utf-8?B?K1lsN2lSdFR4TmxhamNYSHFXbTczYlVyR3lWREd4YTR6UnQrQmYwWU5MUEt4?=
 =?utf-8?B?elpiODNqeVJZQmVMdkFxbUFzZFhaQTRYS1ZiTVdqcEJ3ampzb1Y1VDllQ01a?=
 =?utf-8?B?R2thQzZOOEZWMWd6RFhDL3M2YWY2MGZ1aXhkeDhOYkhUclRoK214RXJ3MTl4?=
 =?utf-8?B?U1VnbFByUlhmUW5RbVFQcVZqdk1EMk4zWXhpdk90NVZvMmJacnp3QWlkWlVk?=
 =?utf-8?B?T2tVK0tYRzZFZzRkY1h3RXZSOWJQMkEzTkFMbkgvd25NRG5zRDFGZnIxZUJH?=
 =?utf-8?B?VUhqTUxpM3Q3S3B5dHVWVFphZ1ArTUhvcGo4OWwwTzJhQkNNL3JLWFlTR3Fk?=
 =?utf-8?B?RTVoTGtzQ3I5RWJocnJWN210K0RZTlU1SmMzbFpsakYvRU94ZVEyR0gyYXp1?=
 =?utf-8?B?OVU2VXFnSnhGelZLaXdPL2V0R3FyYU1nMTc1TERyNGJqclNtbm95RitUbzRn?=
 =?utf-8?B?cHNHQ015V0QzYWEvK05aMTY1V3RobWx1TXl6dFFIVS8yMzBHTlFrWUtQbU8w?=
 =?utf-8?B?Mk5XZHpGNWUrOVhOYkFtcEw4V1ZVVTBncGNFU2xqcnJkYTlkLzh4eGNnSE9s?=
 =?utf-8?B?b3d2WDJ0bmswRVB2czlpR0NhWVkybmVFMllZL1M1WTMzeEs1LzhXNFpOam40?=
 =?utf-8?B?V3FvQUFpc2hHc3BjaGpoK3lob0d4RHdaMDdoSk9udHAvaVFpR2V0VFF3WXFh?=
 =?utf-8?B?T2trTjl0QXdtY3cvV3hRQU14NkNMNGhVbll2bTJhRTUzNG1zOFQzQ0NONDh0?=
 =?utf-8?B?dWRHeVhObVBCVy82Qmcwb2hsZkYvdk1OZlRCbTVxNjExK3BrVVVNQTBmV3c4?=
 =?utf-8?B?L05tMm10MWptWDU0S1h4Zko0V0F5S251Q0FwK21IeTl3NFRKS3o3UW1GVEE2?=
 =?utf-8?B?T3hSSEhyYjlYR1lWS1lITW1RWlhwMTZqRk80cGpTNUdtZkFZek5zNDc0cjhG?=
 =?utf-8?B?dEEzTlgvQU9GRDdqTDkwbFZoajgvVndITzI1NkQ2UXh4QnFTQ1lvbVpnMWwv?=
 =?utf-8?B?elZFMm9vUUdrRTJRV3E4Q1czQTc3TTAxZGtYaVlUc2lQUzJXR2RoOS9xbDc5?=
 =?utf-8?B?SkduTCtINkRxdllYemg5RjE5VTFkVzZoL2RJaElLNjQ4RGQ0RVlqeWJsRndr?=
 =?utf-8?B?WTZOd2JZakpXd0hKZU1UKzBSek9QRGg1VW90bTd3VUVYbndvMndHWFlKNHBG?=
 =?utf-8?B?Vzl2bVUvWUdBbHQzZkl6VXpvZ1lHQWYvTTFaRG8xR243cnp4WUY2eEdFeHUy?=
 =?utf-8?B?dUdTcXZsaHh3ZHVWemhiNG1aWkNmZDJMakZSdGhPbytiL2o3Y0trZjRqdE1P?=
 =?utf-8?B?YWZUc0cweFE3MWZWTm9lUUJEeWFYZVZmcEloQmxQQ24yaDgxQ1NHT2wrdno1?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC46306704B87B4D8770A26D8241FC88@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73a1ac6-d405-4c86-66da-08db7267ee4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 14:58:10.7628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrFJ1RrPDmTcTs6s+0o5aJi9WX86W8TtdbNyXlCIEcEvC83bguKEg/LxRO+sdWTjhd+u4vhSN4FrOYctRt7LYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDE0OjMwICswMDAwLCBaaGFuZywgUnVpIHdyb3RlOgo+IE9u
IFR1ZSwgMjAyMy0wNi0yMCBhdCAxNjowMSAtMDcwMCwgU3Jpbml2YXMgUGFuZHJ1dmFkYSB3cm90
ZToKPiA+IFNvbWUgU29DcyBoYXZlIGluIGJ1aWx0IGZpcm13YXJlIHN1cHBvcnQgdG8gY2xhc3Np
ZnkgY3VycmVudAo+ID4gcnVubmluZwo+ID4gd29ya2xvYWQgYW5kIHBhc3MgdG8gT1MgZm9yIG1h
a2luZyBwb3dlciBtYW5hZ2VtZW50IGRlY2lzaW9ucy4KPiA+IAo+ID4gVGhpcyB0ZXN0IHByb2dy
YW0gd2FpdHMgZm9yIG5vdGlmaWNhdGlvbiBvZiB3b3JrbG9hZCB0eXBlIGNoYW5nZQo+ID4gYW5k
IHByaW50cy4gVGhpcyBwcm9ncmFtIGNhbiBiZSB1c2VkIHRvIHRlc3QgdGhpcyBmZWF0dXJlIGFu
ZCBhbHNvCj4gPiBhbGxvd3Mgb3RoZXIgdXNlciBzcGFjZSBwcm9ncmFtcyB0byB1c2UgYXMgYSBy
ZWZlcmVuY2UuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzIFBhbmRydXZhZGEKPiA+
IDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4KPiA+IC0tLQo+ID4gwqAuLi4v
dGVzdGluZy9zZWxmdGVzdHMvdGhlcm1hbC9pbnRlbC9NYWtlZmlsZcKgIHzCoCAxNiArKysKPiA+
IMKgLi4uL3RoZXJtYWwvaW50ZWwvd29ya2xvYWRfaGludF90ZXN0LmPCoMKgwqDCoMKgwqDCoCB8
IDExNAo+ID4gKysrKysrKysrKysrKysrKysrCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTMwIGlu
c2VydGlvbnMoKykKPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3RoZXJtYWwvaW50ZWwvTWFrZWZpbGUKPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0Cj4gPiB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aGVybWFsL2ludGVsL3dvcmtsb2FkX2hpbnRfdGVzdC5j
Cj4gPiAKPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aGVybWFsL2lu
dGVsL01ha2VmaWxlCj4gPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RoZXJtYWwvaW50ZWwv
TWFrZWZpbGUKPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LjAyNDU5ZTI3MWVmNwo+ID4gLS0tIC9kZXYvbnVsbAo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvdGhlcm1hbC9pbnRlbC9NYWtlZmlsZQo+ID4gQEAgLTAsMCArMSwxNiBAQAo+ID4g
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPiA+ICtpZm5kZWYgQ1JPU1NfQ09N
UElMRQo+ID4gK3VuYW1lX00gOj0gJChzaGVsbCB1bmFtZSAtbSAyPi9kZXYvbnVsbCB8fCBlY2hv
IG5vdCkKPiA+ICtBUkNIID89ICQoc2hlbGwgZWNobyAkKHVuYW1lX00pIHwgc2VkIC1lIHMvaS44
Ni94ODYvIC1lCj4gPiBzL3g4Nl82NC94ODYvKQo+ID4gKwo+ID4gK2lmZXEgKCQoQVJDSCkseDg2
KQo+ID4gK1RFU1RfUFJPR1MgOj0gd29ya2xvYWRfaGludF90ZXN0Cj4gPiArCj4gPiArYWxsOiAk
KFRFU1RfUFJPR1MpCj4gPiArCj4gPiAraW5jbHVkZSAuLi8uLi9saWIubWsKPiA+ICsKPiA+ICtj
bGVhbjoKPiA+ICvCoMKgwqDCoMKgwqDCoHJtIC1mciAkKFRFU1RfUFJPR1MpCj4gPiArZW5kaWYK
PiA+ICtlbmRpZgo+ID4gZGlmZiAtLWdpdAo+ID4gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90
aGVybWFsL2ludGVsL3dvcmtsb2FkX2hpbnRfdGVzdC5jCj4gPiBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3RoZXJtYWwvaW50ZWwvd29ya2xvYWRfaGludF90ZXN0LmMKPiA+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0Cj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjY5YTQ4YThjY2JiNAo+ID4gLS0tIC9k
ZXYvbnVsbAo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGhlcm1hbC9pbnRlbC93
b3JrbG9hZF9oaW50X3Rlc3QuYwo+ID4gQEAgLTAsMCArMSwxMTQgQEAKPiA+ICsvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAo+ID4gKwo+ID4gKyNkZWZpbmUgX0dOVV9TT1VSQ0UK
PiA+ICsKPiA+ICsjaW5jbHVkZSA8c3RkaW8uaD4KPiA+ICsjaW5jbHVkZSA8c3RyaW5nLmg+Cj4g
PiArI2luY2x1ZGUgPHN0ZGxpYi5oPgo+ID4gKyNpbmNsdWRlIDx1bmlzdGQuaD4KPiA+ICsjaW5j
bHVkZSA8ZmNudGwuaD4KPiA+ICsjaW5jbHVkZSA8cG9sbC5oPgo+ID4gKwo+ID4gKyNkZWZpbmUg
V09SS0xPQURfTk9USUZJQ0FUSU9OX0RFTEFZX0FUVFJJQlVURQo+ID4gIi9zeXMvYnVzL3BjaS9k
ZXZpY2VzLzAwMDA6MDA6MDQuMC93b3JrbG9hZF9oaW50L25vdGlmaWNhdGlvbl9kZWxheQo+ID4g
X20KPiA+IHMiCj4gPiArI2RlZmluZSBXT1JLTE9BRF9FTkFCTEVfQVRUUklCVVRFCj4gPiAiL3N5
cy9idXMvcGNpL2RldmljZXMvMDAwMDowMDowNC4wL3dvcmtsb2FkX2hpbnQvd29ya2xvYWRfaGlu
dF9lbmFiCj4gPiBsZQo+ID4gIgo+ID4gKyNkZWZpbmUgV09SS0xPQURfVFlQRV9JTkRFWF9BVFRS
SUJVVEXCoAo+ID4gIi9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6MDA6MDQuMC93b3JrbG9hZF9o
aW50L3dvcmtsb2FkX3R5cGVfaW5kZQo+ID4geCIKPiA+ICsKPiA+ICtzdGF0aWMgY29uc3QgY2hh
ciAqIGNvbnN0IHdvcmtsb2FkX3R5cGVzW10gPSB7Cj4gPiArwqDCoMKgwqDCoMKgwqAiaWRsZSIs
Cj4gPiArwqDCoMKgwqDCoMKgwqAiYmF0dGVyeV9saWZlIiwKPiA+ICvCoMKgwqDCoMKgwqDCoCJz
dXN0YWluZWQiLAo+ID4gK8KgwqDCoMKgwqDCoMKgImJ1cnN0eSIsCj4gPiArwqDCoMKgwqDCoMKg
wqBOVUxMCj4gPiArfTsKPiA+ICsKPiA+ICsjZGVmaW5lIFdPUktMT0FEX1RZUEVfTUFYX0lOREVY
wqDCoMKgwqDCoMKgwqDCoDMKPiA+ICsKPiA+ICtpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFy
Z3YpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBwb2xsZmQgdWZkOwo+ID4gK8KgwqDCoMKg
wqDCoMKgY2hhciBpbmRleF9zdHJbNF07Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgZmQsIHJldCwg
aW5kZXg7Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgZGVsYXkgPSAwOwo+ID4gKwo+ID4gK8KgwqDC
oMKgwqDCoMKgaWYgKGFyZ2MgPiAxKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgY2hhciBkZWxheV9zdHJbNjRdOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHNzY2FuZihhcmd2WzFdLCAiJWQiLCAmZGVsYXkpOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHByaW50ZigiU2V0dGluZyBub3RpZmljYXRpb24gZGVsYXkgdG8gJWQg
bXNcbiIsCj4gPiBkZWxheSk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKGRlbGF5IDwgMCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZXhpdCgxKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBzcHJpbnRmKGRlbGF5X3N0ciwgIiVzXG4iLCBhcmd2WzFdKTsKPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoKGZkID0KPiA+IG9wZW4oV09SS0xPQURfTk9U
SUZJQ0FUSU9OX0RFTEFZX0FUVFJJQlVURSwKPiA+IE9fUkRXUikpIDwgMCkgewo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZXJyb3IoIlVuYWJsZSB0
byBvcGVuIHdvcmtsb2FkCj4gPiBub3RpZmljYXRpb24KPiA+IGRlbGF5XG4iKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgxKTsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKHdyaXRlKGZkLCBkZWxheV9zdHIsIHN0cmxlbihkZWxheV9zdHIp
KSA8IDApIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcGVycm9yKCJDYW4ndCBzZXQgZGVsYXlcbiIpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBleGl0KDEpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBj
bG9zZShmZCk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDC
oMKgwqAvKiBFbmFibGUgZmVhdHVyZSB2aWEgc3lzZnMga25vYiAqLwo+ID4gK8KgwqDCoMKgwqDC
oMKgaWYgKChmZCA9IG9wZW4oV09SS0xPQURfRU5BQkxFX0FUVFJJQlVURSwgT19SRFdSKSkgPCAw
KSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGVycm9yKCJVbmFibGUgdG8g
b3BlbiB3b3JrbG9hZCB0eXBlIGZlYXR1cmUgZW5hYmxlCj4gPiBmaWxlXG4iKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBleGl0KDEpOwo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+
ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHdyaXRlKGZkLCAiMVxuIiwgMikgPCAwKSB7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGVycm9yKCJDYW4nIGVuYWJsZSB3b3Jr
bG9hZCBoaW50c1xuIik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgx
KTsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGNsb3NlKGZk
KTsKPiAKPiBUaGlzIGVuYWJsZXMgV09SS0xPQURfRU5BQkxFX0FUVFJJQlVURSB3aXRob3V0IGRp
c2FibGluZyBpdCBhZ2Fpbi4KPiBBcyBhIHRlc3QgcHJvZ3JhbSwgbWF5YmUgd2UgY2FuIGFkZCBh
IHRpbWVvdXQsIGFuZCBzdG9wIHBvbGxpbmcgJgo+IGRpc2FibGUgdGhlIFdPUktMT0FEX0VOQUJM
RV9BVFRSSUJVVEUgYWZ0ZXIgdGhlIHRpbWVvdXQ/Cgp0byBiZSBtb3JlIGFjY3VyYXRlLCByZXN0
b3JlIFdPUktMT0FEX0VOQUJMRV9BVFRSSUJVVEUgdG8gaXRzIG9yaWdpbmFsCnN0YXRlLgoKdGhh
bmtzLApydWkKPiAKPiB0aGFua3MsCj4gcnVpCj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqB3aGls
ZSAoMSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgoZmQgPSBvcGVu
KFdPUktMT0FEX1RZUEVfSU5ERVhfQVRUUklCVVRFLAo+ID4gT19SRE9OTFkpKSA8IDApIHsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGVycm9yKCJV
bmFibGUgdG8gb3BlbiB3b3JrbG9hZCB0eXBlCj4gPiBmaWxlXG4iKTsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgxKTsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKChsc2VlayhmZCwgMEwsIFNFRUtfU0VUKSkgPCAwKSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZwcmludGYoc3RkZXJyLCAi
RmFpbGVkIHRvIHNldCBwb2ludGVyIHRvCj4gPiBiZWdpbm5pbmdcbiIpOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBleGl0KDEpOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpZiAocmVhZChmZCwgaW5kZXhfc3RyLCBzaXplb2YoaW5kZXhfc3RyKSkgPCAw
KSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZw
cmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIHJlYWQgZnJvbTolc1xuIiwKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgV09SS0xPQURfVFlQRV9JTkRFWF9B
VFRSSUJVVEUpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBleGl0KDEpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1ZmQuZmQgPSBmZDsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1ZmQuZXZlbnRzID0gUE9MTFBSSTsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoKHJldCA9IHBvbGwoJnVmZCwgMSwg
LTEpKSA8IDApIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcGVycm9yKCJwb2xsIGVycm9yIik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGV4aXQoMSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfSBlbHNlIGlmIChyZXQgPT0gMCkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcmludGYoIlBvbGwgVGltZW91dFxuIik7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKChsc2VlayhmZCwgMEwsIFNFRUtf
U0VUKSkgPCAwKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmcHJpbnRmKHN0ZGVyciwgIkZhaWxlZCB0byBzZXQKPiA+
IHBvaW50ZXIgdG8gYmVnaW5uaW5nXG4iKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGV4aXQoMSk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJlYWQoZmQsIGlu
ZGV4X3N0ciwgc2l6ZW9mKGluZGV4X3N0cikpCj4gPiA8Cj4gPiAwKSB7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBleGl0
KDApOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHNzY2FuZihpbmRleF9zdHIsICIlZCIsICZpbmRleCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChpbmRleCA+IFdPUktMT0FEX1RZUEVfTUFY
X0lOREVYKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcHJpbnRmKCJJbnZhbGlkIHdvcmtsb2FkIHR5cGUKPiA+IGluZGV4
XG4iKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZWxzZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcHJpbnRmKCJ3b3JrbG9hZCB0eXBlOiVzXG4iLAo+ID4gd29ya2xvYWRf
dHlwZXNbaW5kZXhdKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xvc2UoZmQpOwo+ID4gK8KgwqDC
oMKgwqDCoMKgfQo+ID4gK30KPiAKCg==
