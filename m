Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE37738702
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjFUOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFUOal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:30:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B5112E;
        Wed, 21 Jun 2023 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687357839; x=1718893839;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gXGp5Bk6ceICNi2zrNKbNz3Y4NSybTmQY0Na3E8Xgbk=;
  b=bTitokFLgIDaeta6IoNyXyBuBvuOJ7BdIk6zsW/RwOi42KMeV4v9Msgk
   B9AQ3xo3WhVVbmxrJn0SW2UaZWQdebBBcPxu+nWuGmDpcNoFhY1iE4No7
   zALWg6Sdo5pVDqazEguOJJys/F0Ud89QJ9HZ/wpy1oGFtWSnLqD3wRU0o
   JWKyboVBZoJgIZ5nzudaQtKYHUt8+6YXZNnjX42OHpqC0K0lM+WATJlbQ
   QlY5IIU74i5V3VvaaDkrUARosXj33jfty4w2KzaeATOLaEfz+T8g8IZdF
   4uYbT9guYf1OFTz57zz63YRgqME+O5Ql8wH7l0uXHgewDjK1OnMw9Md8S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="339805076"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="339805076"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:30:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="888678244"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="888678244"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2023 07:30:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 07:30:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 07:30:37 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 07:30:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXXwozFn3O8FVwIjAxp7hbDi1/7uby70yOJNowmBuFopovKbDXaAPrhlSFRKtMg5BXacu6u+JQiT0f1BSFweD/kzLPLvKKl8/DK/169f/u21HPJN+j+rFdEbftpodU6z0J8A0cURd8jwVNoAj7M3jqtNyHKp6+Pd/+L62KBxtbPeiIdWXUrGo3vzKIbMwIJ/KJg5mam546CwZZWmid5bt0479UG7eOtNECrtdh6n0Ow3P6UWgX+ilT03Tw0Jhr96B7JTh7kCLIHRtKKEXkMcLAmSCom+tY8/2wUIiSuRRO9w32bP0OWKPSK8lYdjUySPN5Xf1gdX3X5qCKQy8qFcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXGp5Bk6ceICNi2zrNKbNz3Y4NSybTmQY0Na3E8Xgbk=;
 b=ARUSKbRRP9neGI+zqXNw4EyAPr2BwbV+sVglyaf3HebhtlOU3HGBQ9NZZMvrXUG+28JgLvgF6/99sNR3n4Sa8uPRJE1uF8csDzAt3WRyusAujOzPxHVhmbHi8aWnvQM4QoqwZ+7wE09Z1JKFJ/KZP0nW5QT8i1FCNjY3sRB+Gf2TYk2w9bfSLrkqxlaNJ6SeLs6r1Rhg2lDFw3P2Z0tR4oGcxVxIy8By1p+QytBy3E6NK1qbub41WMm3PzrihhOoKSqhvCqoE4AWnMHSJdqSDvUslgobrd0T3swlIfW1voBd1OxajKaqrkvc0QtbkKM7lJ9f80BUjr3YJ52fXIKHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com (2603:10b6:a03:4ed::18)
 by SA1PR11MB6944.namprd11.prod.outlook.com (2603:10b6:806:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:30:35 +0000
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf]) by SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:30:35 +0000
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
Thread-Index: AQHZo8s3B9RbI+84hEyMsxi/sEm8ma+VUkcA
Date:   Wed, 21 Jun 2023 14:30:35 +0000
Message-ID: <41d7a9144881cd536e545b57e193afc956646478.camel@intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
         <20230620230150.3068704-8-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230620230150.3068704-8-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0086:EE_|SA1PR11MB6944:EE_
x-ms-office365-filtering-correlation-id: 81124ec0-ff0e-40ca-2170-08db72641373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sa/FPrEwl9KF92LdIrp5k+rxE/2EYzLtofRsjUqWYJh8l4oLsww/4xsiOps1yQoSaCb7T9HMYBMy6YYMzr+dXDUV//6a17Q/bIqU0QFZnNzSvjgR62MCcCxOvL4K3u8WEwOClA/MeqevvqiB5mlFXJEqFNvNDlW3KsvyiwYXA8j/fnVs9Z2GYlSwl9z2AX5MNvTRVHnPwkoE2tf6BqjK/J/bvs0UOXebZwTYwTAbiafY+Qk3e1clQ5IbM1gh1zo3KrYpZG4MTr4gL1RLjRIMb8mywcWBdF9yf+sw6dHB9Aza1xUXhuZDNHqOpkenaORhgp5hg0O/Vv/h1llJZIJcA5b/4ARdwyVfbUj0IGby3+j0L2YpocUJMiZPBPf4f/RR7dIPeligREsVYMRGNYTSHHZTtwQqyR62EI2xzk/fQfopIW7Yl9K/fIeZriia6K/rcnoYNLDHgDhpsIQfWysHvyFjozCP2OxCrbcwM/eVIP/gufoLU6SZVCH1qt3qAS+zrzkkto03nxPmoiouZzfY0NLbAfRod0uh9qBLasEGoR2wv1WzGzJZN0pkhaU1qBdGCCRfpiW80pVj3op2AFZFZPNceIQ6yISkUi09WNCT9adQL3eOuRdowdRVLrYITjI+rF60sSnXPU9JoFIz3fNK1HVX3oe+pkdiwY48BG2qy5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(110136005)(54906003)(478600001)(45080400002)(76116006)(66556008)(71200400001)(66946007)(66446008)(66476007)(91956017)(64756008)(6512007)(26005)(2616005)(6506007)(186003)(6486002)(4326008)(41300700001)(5660300002)(316002)(8676002)(8936002)(2906002)(38070700005)(82960400001)(38100700002)(122000001)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVdObVBVVFRmV09FSVdmUGpNU3hHMU5QbkJqWlAzeDl3VCtJRytsUVJrdStD?=
 =?utf-8?B?ck5zVmZ2UGY0QXRHb1JWcGhFREZtYTJGK2hNZkJwVENLWTBtWCtSTlBIc2JR?=
 =?utf-8?B?djM4NUZ3dlNpWFJ4SXVKMlg1N1FYcWJCM3RzRmZ3K2VSQlBDdW04STBxRUJV?=
 =?utf-8?B?UExRMDhtdWtLV053NGRWYzcvYUhBK0o3SlpJWTYzU1RQbEVYR1lzNVdZMnZa?=
 =?utf-8?B?Q0RUTWFxVkdLd3RoV2ljNUkySWZsaFVsWDNmekgzV0tvOVI2MEw1MWdGajl3?=
 =?utf-8?B?am5jVDRJS3hsSHNtV05UcHFDTEphRyttZTJnN2FQZjM5azllOUxwZ1JNR1pF?=
 =?utf-8?B?dW9VRjMvR3NYZU9ua1FyMHNDamN2TVVuRzNjVnY2Yk5BaGRMTDRYS2ZRaHVt?=
 =?utf-8?B?dm9WOWtNejdHUEFiVzNhVktKYnZid28rUGRxTDFnTEFGamtWcE9QdEN2ZjRr?=
 =?utf-8?B?eGoxVFExbStnMXpXdkY3R3E5cTBVY2tWZnNDSDMwNUpHMjFHNnBrOEwyT1JB?=
 =?utf-8?B?UmM4Vy95MjQzd25ZM083SkwzNTdBdzNmSVpGKzhpU0ltVklYVi94Wld5aCti?=
 =?utf-8?B?STRjMHVYSlR0VTJJMXdUSncya0toeEwyQU9SeC9DdklwdlROdnNIa1QyL21P?=
 =?utf-8?B?UGhuMXFDYVdIc1FLMkdiSWRnK204ak1yMFdES21JTjl4bFM5SDJnRzMxcnZ3?=
 =?utf-8?B?VXJDcG1uL0wxQU12Nmt4WENLbTVGd0Z0eDV5Ynl5MDZDSEJXM2o5RzlIMTlu?=
 =?utf-8?B?ZFAxTEtEOW1Sc3lPRDBYYUhJZ2dhaXhZaDhUSHlEazIzMFMyOHRHNUJGU01Y?=
 =?utf-8?B?cEVDTnRNUzhpdWdwVDhFNHUvdW9pZTF5Q2dGaldiRkdiUDFWUWJSS3IwZVNy?=
 =?utf-8?B?RkttVFArLzZvVnQxdFk3RVRHa3JxSHNDblI0aGxHWkRwcEFZVTBYckFCZTZI?=
 =?utf-8?B?YmgrSXZDbXZqLzFQTVJzdjdlNENvTGJPNzV2WC9SVTZNTUZMTjNWUk02a2VZ?=
 =?utf-8?B?ZnM2YkxUeVBaOC9ibWVoYnRHWWVUUnJ4cDMwRUc5b1V5d1A4QTcwQXorY0Vv?=
 =?utf-8?B?MDdUMnM5U3VoVmZGWkVGdEdlNTNGWGY3MU1IQ0trSDVGR2w3dU5hM3ZSeDZl?=
 =?utf-8?B?dnpubGNJVEhoZERwNklTeUJRMXh1TmxTNmxtcDhCa0Zlbm9vTjlSNkFkNW81?=
 =?utf-8?B?Q3l6TlZYbTc0WDI3VXVDckZVMnVYYloyc0VPLzdDZHdhM1FaK1NaWVRNbzh1?=
 =?utf-8?B?ckU4Vzh3ZUEzWWxOSW44L0VFS2FEeFhUZ2pNdnd0S0doK0tZcFpqckZjSzRR?=
 =?utf-8?B?WFRkVStLYmxFUVRTTGpTY2hoaC9uNkZTZW9DTTJYNTdWVzc5U0tQMm9SN1h6?=
 =?utf-8?B?aEM1WUdyUlFXWEh6UVZINTF2NWMxbDY1TjNPMTBOQS9sL3F5RFNpbE5oTTV0?=
 =?utf-8?B?azhNcktqemgrYW5ic1ZUYldBOWoyeGNRdWEvazB3QW5vWDlpWHRHQytBem5N?=
 =?utf-8?B?Vlk5Z21uL3pBUHcrd0pnNytWTW5MWmFVb1BVN3pMNXdKUGVGSkMvUDIzbDkr?=
 =?utf-8?B?T0JGeWQraG85UXlhQTlCckpFTjJmcDZFTThXbElwWGJZRWgyRVY3Qi9DOXR4?=
 =?utf-8?B?YzFraThkYWszQ3FPSzlZZ3Zwalc0bGFpUUJOc050ZE4zVVFSS1JVb2VFTzBW?=
 =?utf-8?B?Y1V0N1NRTnc4UFpCTWxSUTArVUQ3WGNTS2ZXOFZiUFlxTjZIb3R4M1hSUnJY?=
 =?utf-8?B?TnF1bGkybHY3N0UrbUNsQUVrb3V3d3JDZEEwK0dZSkpuQWMwQjlmTnpNUlhM?=
 =?utf-8?B?Rk83YVdQVzFwOEpiMmwwcXU4aXdMSGcvWEs3UmlKOUFYREhCT21uTm1HQ3ZF?=
 =?utf-8?B?bXV6eE1pRUg5SkVkS0p0Tjk4WUhZYmpLVFZyZUl2UFBqU0J4VENpcGFNNzdx?=
 =?utf-8?B?Z1BDWTZTOUVXYXJTd05tZU1Jb2hDdEhtMENicUZpMVp2eXA5U01lSzloQ2VV?=
 =?utf-8?B?RUpnd3V1Zm1hODZQai9MbGpGMnhKRHZOaXdrZUh0RGxVVDlhaGtVNk5JT2ZX?=
 =?utf-8?B?Z0ZHMWtrSnNrV0xRNnlqZnZVQjg3QkgrY3MzOTVHQ3c2MXNEakV4OUlYK3A5?=
 =?utf-8?B?N2xYanVZS0hrQXJabEVIM2F0c0hOUlM3bVpaNlhuOGdPMEdzd1RBcndMalEw?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F827BB04D630A4E927B6A0476C00C6F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81124ec0-ff0e-40ca-2170-08db72641373
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 14:30:35.1547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGrF1p7oMhtFct47iHnZ4vD3C80fdDXnYqHarwUYwKxp+tbcZlJVGetZoEpsqT+4yR8B1xQ4FX3UR+Bbf3T5YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6944
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

T24gVHVlLCAyMDIzLTA2LTIwIGF0IDE2OjAxIC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOgo+IFNvbWUgU29DcyBoYXZlIGluIGJ1aWx0IGZpcm13YXJlIHN1cHBvcnQgdG8gY2xhc3Np
ZnkgY3VycmVudCBydW5uaW5nCj4gd29ya2xvYWQgYW5kIHBhc3MgdG8gT1MgZm9yIG1ha2luZyBw
b3dlciBtYW5hZ2VtZW50IGRlY2lzaW9ucy4KPiAKPiBUaGlzIHRlc3QgcHJvZ3JhbSB3YWl0cyBm
b3Igbm90aWZpY2F0aW9uIG9mIHdvcmtsb2FkIHR5cGUgY2hhbmdlCj4gYW5kIHByaW50cy4gVGhp
cyBwcm9ncmFtIGNhbiBiZSB1c2VkIHRvIHRlc3QgdGhpcyBmZWF0dXJlIGFuZCBhbHNvCj4gYWxs
b3dzIG90aGVyIHVzZXIgc3BhY2UgcHJvZ3JhbXMgdG8gdXNlIGFzIGEgcmVmZXJlbmNlLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzIFBhbmRydXZhZGEKPiA8c3Jpbml2YXMucGFuZHJ1dmFk
YUBsaW51eC5pbnRlbC5jb20+Cj4gLS0tCj4gwqAuLi4vdGVzdGluZy9zZWxmdGVzdHMvdGhlcm1h
bC9pbnRlbC9NYWtlZmlsZcKgIHzCoCAxNiArKysKPiDCoC4uLi90aGVybWFsL2ludGVsL3dvcmts
b2FkX2hpbnRfdGVzdC5jwqDCoMKgwqDCoMKgwqAgfCAxMTQKPiArKysrKysrKysrKysrKysrKysK
PiDCoDIgZmlsZXMgY2hhbmdlZCwgMTMwIGluc2VydGlvbnMoKykKPiDCoGNyZWF0ZSBtb2RlIDEw
MDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aGVybWFsL2ludGVsL01ha2VmaWxlCj4gwqBj
cmVhdGUgbW9kZSAxMDA2NDQKPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aGVybWFsL2ludGVs
L3dvcmtsb2FkX2hpbnRfdGVzdC5jCj4gCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3RoZXJtYWwvaW50ZWwvTWFrZWZpbGUKPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3RoZXJtYWwvaW50ZWwvTWFrZWZpbGUKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAw
MDAwMDAwMDAwMC4uMDI0NTllMjcxZWY3Cj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3RoZXJtYWwvaW50ZWwvTWFrZWZpbGUKPiBAQCAtMCwwICsxLDE2IEBA
Cj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPiAraWZuZGVmIENST1NTX0NP
TVBJTEUKPiArdW5hbWVfTSA6PSAkKHNoZWxsIHVuYW1lIC1tIDI+L2Rldi9udWxsIHx8IGVjaG8g
bm90KQo+ICtBUkNIID89ICQoc2hlbGwgZWNobyAkKHVuYW1lX00pIHwgc2VkIC1lIHMvaS44Ni94
ODYvIC1lCj4gcy94ODZfNjQveDg2LykKPiArCj4gK2lmZXEgKCQoQVJDSCkseDg2KQo+ICtURVNU
X1BST0dTIDo9IHdvcmtsb2FkX2hpbnRfdGVzdAo+ICsKPiArYWxsOiAkKFRFU1RfUFJPR1MpCj4g
Kwo+ICtpbmNsdWRlIC4uLy4uL2xpYi5tawo+ICsKPiArY2xlYW46Cj4gK8KgwqDCoMKgwqDCoMKg
cm0gLWZyICQoVEVTVF9QUk9HUykKPiArZW5kaWYKPiArZW5kaWYKPiBkaWZmIC0tZ2l0Cj4gYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aGVybWFsL2ludGVsL3dvcmtsb2FkX2hpbnRfdGVzdC5j
Cj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aGVybWFsL2ludGVsL3dvcmtsb2FkX2hpbnRf
dGVzdC5jCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLjY5YTQ4
YThjY2JiNAo+IC0tLSAvZGV2L251bGwKPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90
aGVybWFsL2ludGVsL3dvcmtsb2FkX2hpbnRfdGVzdC5jCj4gQEAgLTAsMCArMSwxMTQgQEAKPiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPiArCj4gKyNkZWZpbmUgX0dOVV9T
T1VSQ0UKPiArCj4gKyNpbmNsdWRlIDxzdGRpby5oPgo+ICsjaW5jbHVkZSA8c3RyaW5nLmg+Cj4g
KyNpbmNsdWRlIDxzdGRsaWIuaD4KPiArI2luY2x1ZGUgPHVuaXN0ZC5oPgo+ICsjaW5jbHVkZSA8
ZmNudGwuaD4KPiArI2luY2x1ZGUgPHBvbGwuaD4KPiArCj4gKyNkZWZpbmUgV09SS0xPQURfTk9U
SUZJQ0FUSU9OX0RFTEFZX0FUVFJJQlVURQo+ICIvc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDAwOjAw
OjA0LjAvd29ya2xvYWRfaGludC9ub3RpZmljYXRpb25fZGVsYXlfbQo+IHMiCj4gKyNkZWZpbmUg
V09SS0xPQURfRU5BQkxFX0FUVFJJQlVURQo+ICIvc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDAwOjAw
OjA0LjAvd29ya2xvYWRfaGludC93b3JrbG9hZF9oaW50X2VuYWJsZQo+ICIKPiArI2RlZmluZSBX
T1JLTE9BRF9UWVBFX0lOREVYX0FUVFJJQlVURcKgCj4gIi9zeXMvYnVzL3BjaS9kZXZpY2VzLzAw
MDA6MDA6MDQuMC93b3JrbG9hZF9oaW50L3dvcmtsb2FkX3R5cGVfaW5kZXgiCj4gKwo+ICtzdGF0
aWMgY29uc3QgY2hhciAqIGNvbnN0IHdvcmtsb2FkX3R5cGVzW10gPSB7Cj4gK8KgwqDCoMKgwqDC
oMKgImlkbGUiLAo+ICvCoMKgwqDCoMKgwqDCoCJiYXR0ZXJ5X2xpZmUiLAo+ICvCoMKgwqDCoMKg
wqDCoCJzdXN0YWluZWQiLAo+ICvCoMKgwqDCoMKgwqDCoCJidXJzdHkiLAo+ICvCoMKgwqDCoMKg
wqDCoE5VTEwKPiArfTsKPiArCj4gKyNkZWZpbmUgV09SS0xPQURfVFlQRV9NQVhfSU5ERVjCoMKg
wqDCoMKgwqDCoMKgMwo+ICsKPiAraW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KSB7Cj4g
K8KgwqDCoMKgwqDCoMKgc3RydWN0IHBvbGxmZCB1ZmQ7Cj4gK8KgwqDCoMKgwqDCoMKgY2hhciBp
bmRleF9zdHJbNF07Cj4gK8KgwqDCoMKgwqDCoMKgaW50IGZkLCByZXQsIGluZGV4Owo+ICvCoMKg
wqDCoMKgwqDCoGludCBkZWxheSA9IDA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmIChhcmdjID4g
MSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjaGFyIGRlbGF5X3N0cls2NF07
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzc2NhbmYoYXJndlsxXSwgIiVk
IiwgJmRlbGF5KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJpbnRmKCJTZXR0
aW5nIG5vdGlmaWNhdGlvbiBkZWxheSB0byAlZCBtc1xuIiwKPiBkZWxheSk7Cj4gKwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZGVsYXkgPCAwKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgxKTsKPiArCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwcmludGYoZGVsYXlfc3RyLCAiJXNcbiIsIGFyZ3ZbMV0p
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKChmZCA9IG9wZW4oV09S
S0xPQURfTk9USUZJQ0FUSU9OX0RFTEFZX0FUVFJJQlVURSwKPiBPX1JEV1IpKSA8IDApIHsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBlcnJvcigiVW5h
YmxlIHRvIG9wZW4gd29ya2xvYWQgbm90aWZpY2F0aW9uCj4gZGVsYXlcbiIpOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgxKTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKHdyaXRlKGZkLCBkZWxheV9zdHIsIHN0cmxlbihkZWxheV9zdHIpKSA8IDApIHsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBlcnJvcigi
Q2FuJ3Qgc2V0IGRlbGF5XG4iKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGV4aXQoMSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0K
PiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb3NlKGZkKTsKPiArCj4gK8Kg
wqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqAvKiBFbmFibGUgZmVhdHVyZSB2aWEg
c3lzZnMga25vYiAqLwo+ICvCoMKgwqDCoMKgwqDCoGlmICgoZmQgPSBvcGVuKFdPUktMT0FEX0VO
QUJMRV9BVFRSSUJVVEUsIE9fUkRXUikpIDwgMCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBwZXJyb3IoIlVuYWJsZSB0byBvcGVuIHdvcmtsb2FkIHR5cGUgZmVhdHVyZSBlbmFi
bGUKPiBmaWxlXG4iKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgxKTsK
PiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmICh3cml0ZShmZCwgIjFc
biIsIDIpIDwgMCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZXJyb3IoIkNh
bicgZW5hYmxlIHdvcmtsb2FkIGhpbnRzXG4iKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZXhpdCgxKTsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGNs
b3NlKGZkKTsKClRoaXMgZW5hYmxlcyBXT1JLTE9BRF9FTkFCTEVfQVRUUklCVVRFIHdpdGhvdXQg
ZGlzYWJsaW5nIGl0IGFnYWluLgpBcyBhIHRlc3QgcHJvZ3JhbSwgbWF5YmUgd2UgY2FuIGFkZCBh
IHRpbWVvdXQsIGFuZCBzdG9wIHBvbGxpbmcgJgpkaXNhYmxlIHRoZSBXT1JLTE9BRF9FTkFCTEVf
QVRUUklCVVRFIGFmdGVyIHRoZSB0aW1lb3V0PwoKdGhhbmtzLApydWkKPiArCj4gK8KgwqDCoMKg
wqDCoMKgd2hpbGUgKDEpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKChm
ZCA9IG9wZW4oV09SS0xPQURfVFlQRV9JTkRFWF9BVFRSSUJVVEUsCj4gT19SRE9OTFkpKSA8IDAp
IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBlcnJv
cigiVW5hYmxlIHRvIG9wZW4gd29ya2xvYWQgdHlwZQo+IGZpbGVcbiIpOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgxKTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKChsc2VlayhmZCwgMEwsIFNFRUtfU0VUKSkgPCAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmcHJpbnRmKHN0ZGVyciwgIkZhaWxlZCB0
byBzZXQgcG9pbnRlciB0bwo+IGJlZ2lubmluZ1xuIik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBleGl0KDEpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmVh
ZChmZCwgaW5kZXhfc3RyLCBzaXplb2YoaW5kZXhfc3RyKSkgPCAwKSB7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmcHJpbnRmKHN0ZGVyciwgIkZhaWxl
ZCB0byByZWFkIGZyb206JXNcbiIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBXT1JLTE9BRF9UWVBFX0lOREVYX0FUVFJJQlVURSk7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBleGl0KDEpOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB1ZmQuZmQgPSBmZDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdWZkLmV2
ZW50cyA9IFBPTExQUkk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAo
KHJldCA9IHBvbGwoJnVmZCwgMSwgLTEpKSA8IDApIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBlcnJvcigicG9sbCBlcnJvciIpOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgxKTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIGlmIChyZXQgPT0gMCkgewo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJpbnRmKCJQb2xsIFRpbWVv
dXRcbiIpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9IGVsc2Ugewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKChsc2VlayhmZCwg
MEwsIFNFRUtfU0VUKSkgPCAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnByaW50ZihzdGRlcnIsICJGYWlsZWQgdG8g
c2V0Cj4gcG9pbnRlciB0byBiZWdpbm5pbmdcbiIpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGV4aXQoMSk7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJlYWQoZmQsIGluZGV4
X3N0ciwgc2l6ZW9mKGluZGV4X3N0cikpIDwKPiAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXhpdCgwKTsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzc2NhbmYoaW5kZXhfc3Ry
LCAiJWQiLCAmaW5kZXgpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKGluZGV4ID4gV09SS0xPQURfVFlQRV9NQVhfSU5ERVgpCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJp
bnRmKCJJbnZhbGlkIHdvcmtsb2FkIHR5cGUKPiBpbmRleFxuIik7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbHNlCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJpbnRmKCJ3b3Jr
bG9hZCB0eXBlOiVzXG4iLAo+IHdvcmtsb2FkX3R5cGVzW2luZGV4XSk7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGNsb3NlKGZkKTsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gK30KCg==
