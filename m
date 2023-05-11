Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014E96FFB55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbjEKUfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEKUf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:35:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F130D3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683837326; x=1715373326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tqB3JFZaXzJ4JmSSPJH8elfOmKT+KiRKUi+iiXbSKsM=;
  b=Km5ZSCNhHFqOovfOHMgnojA5OAnUpkr5wzIgtyuy/9gHcETSyeCRmSdc
   mJBuuqhV4kZqOcOhFDcuj0AEmIKC321/W8DEB6GWQrhsuzpEfoI2DhQt7
   Mlt7c98p8YiyjSmlD7RBff8zC5cPUTEIM7BklbcQgeRUgwHK4VLkHkD+K
   TlUzIAJYig8EFvEFsltwEpOcktRHhnezeJRvfOblcf7qE6GPIu1mov9M3
   aTJPkwv+m9FPmmoYzhiT6ZV1HuhWwgrQymn4uWtELI1Dm3mFxTBN/MAW5
   jaLRKaZlocH1BZpP4IRyVK3iabnukSlKOiDdmhA7Y0yl7Mq6x8Wj1FIyf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335136198"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="335136198"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 13:35:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="789527846"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="789527846"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 11 May 2023 13:35:24 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 13:35:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 13:35:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 13:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+b1IGxibmqf/IQfTsZcOgO/sdQm4aQ1MA6eIwlrp+5N8AL3v11mHYkJOC1L7UaWEpILhRcxtrIVZdIbahw8K+d3RvZFhYd53FLmAXmeW25Z79SJrA3xv9rGU4WuQyRprDUfaYFC6ciYxfA4ZjOX1PeXtdloNQ7ZJS0EA20tJrpKafKle41AGo+F4+i1nM7vHMNT7QbZVZfJR518fQvKDW6JJ3xyYVnbFVTDFq/yMTGxAHqzf4ILIUAbl/kVyUdQtF6G7RPzejIcLZLJpQHglY8CrC/6q9Sc1QbOvC1njcutGEQfQ2ISilJ9ylWanXehOdGimQQ3+wcBVMGAZsIeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqB3JFZaXzJ4JmSSPJH8elfOmKT+KiRKUi+iiXbSKsM=;
 b=LlBrC9RE7gWFXhtpQASLl/e/04pHLsBQK8BWT2zXH3mOMlVzNPcMeR9HJgaL9PyoEx8pIi2M98AlnK5rIwt12X2PYOK4241s99UO2cH+mXLHGsMH54SrMIpG8gy8JOt4ds6otQ67kVHGJK5GOTVVLvTWac/BLnZeKhH2Qs7zVk0qDzHUPot3UeA+7/P/geg4OOGDA9itEjHtfOoqT+3R8Kt3tuWPEo8mo07xdcKPT8hsux+K0w48jlNOc8kocZrD9C8pLP3NegWct6yyEWxmLKBlL0blVICi34BYURgmgI7LxjloPkq5gAVvWbTYjfCFhKrLB78Q7IeSYzqgRO+TuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN6PR11MB8242.namprd11.prod.outlook.com (2603:10b6:208:474::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Thu, 11 May
 2023 20:35:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 20:35:21 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Thread-Topic: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Thread-Index: AQHZc9RpUDnrLIcguE2hFRoOJfWMkK9MZ88AgARWAUCAAdZ8gIAABlIAgAMJStA=
Date:   Thu, 11 May 2023 20:35:21 +0000
Message-ID: <SJ1PR11MB6083031582F2A61A7D24ABAFFC749@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <c0755752-ce84-b5f9-6ac6-97812e98b8c3@intel.com>
 <SJ1PR11MB60832074F3140B38C1B08596FC719@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <237603b3-f553-2ede-5725-239b65626c69@intel.com>
 <SJ1PR11MB6083CFFA8CBDD296E966EC85FC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083CFFA8CBDD296E966EC85FC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MN6PR11MB8242:EE_
x-ms-office365-filtering-correlation-id: 2d254b81-fdc6-4fac-9bbe-08db525f3d9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ks5MUSihrLM656eC2UX2hbSQ5gtrxV39BR6YebPnjNNG1AmvvOnQoRpVsxHvMKtafOZIsU/t75e+TcHt+cgczWW/QUXrojFMyMC8Lxy4h7j301kRCEWXRfhvRS1HOXCDBerQX5y2YQPssBasfPi08YRU72NCLvL3GZZfkovM+sVgymdoSfLQs4CN0ySI2uoMob35u/9Gu3FjjZnfJHAviS7F+EbRbiPFM5vneDZ3h5I54XISBn+pFtDKjWxYx8hv492xBpyPdt9beQPqf2j4jwlSweIGdw2OhPar7a8oUZJsbvhyc7YP5SkLn/rsnLOmeWhzEJ1yZ1JfDuJtX45jgWPy6xHJGMiVCtCQJXL8H6WpOsu7FF/gB/Lo9o6kKoJlEkmbhvKZRvEy2IcPwudbbSPzEGsfme68FCYiVMpFXbMfU0i0XkzUa+aJKkBXt8Ez6ryxybJybbyw/jpmB9EIDehhzolJ3jM7NkIPCY8xXbOyQvoWsZvIGBNk/09hKx2WmavdpQxTzoD+yG3e5loqOBUjPxI3F/rqIAV+8+F1ZCgqaUWn2uDmbfbw1xREpokWHLV1KKT0SFdExJAju11qM2Zk05mGB+mA2nCuF6fQ+SkjS+vELyrL/Z/g1Sq1ab3UprX3C2sdYlLMy/GuCQQFJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(66556008)(86362001)(33656002)(8936002)(64756008)(76116006)(7696005)(66446008)(54906003)(110136005)(66476007)(478600001)(4326008)(316002)(66946007)(52536014)(41300700001)(82960400001)(8676002)(5660300002)(7416002)(55016003)(2906002)(71200400001)(38100700002)(186003)(38070700005)(921005)(122000001)(9686003)(6506007)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckJJcU9qU29maGwwYUc3UTZoL09JN3ZXcDd3UlpWUEZDQmVodm1ZSjdYdWZT?=
 =?utf-8?B?V2FFODNXSmtCZHJ5L0FjSk1Ya3ZQYU4zRlFHTC9zS3NteHFRbEVEQnQyNUZU?=
 =?utf-8?B?ZCtQSWI4MTJES3haZVJUeTQ0ZWRBeWtlaSs5MHBQdnhwV0huUnZCZUZzS1Bz?=
 =?utf-8?B?TUlBVERXNTNObmJHQWNVN3MzRFpkR21JNm9SeUVPSlRsNEhHZEo4ditGZElO?=
 =?utf-8?B?T2lPZy9VbjljcnVkUEhJMkw3NnlkbnZQaXZIRkNnTW80cEc5QnFoRjM3aytR?=
 =?utf-8?B?eTV4czB6N3ZVQWtPT05jVlRSdHpaWi9aa1BxaEFEZ0E5ZWgwN3gzdnR6U0Zo?=
 =?utf-8?B?QmpETXlJeDh1V1o3b0gvWlVtRkVXNEVkWVFQY09UaUl0MFRNaXB6eldsTTNk?=
 =?utf-8?B?QktGV0VVd1dtTU1lZnJuQVhmZE5mRkVIY3BYSDN1VjhpSnZCOU55WnB6dWd4?=
 =?utf-8?B?aGFuRUg4ZnFOdzR6ZWdaUkNaUWdBd3JrTHBZb243YTQ2dGtKLzJXODBXZjlk?=
 =?utf-8?B?WnhhR1JGSk5FZDVkWjE5cHpEOEZpcFlERW1pbnZjMHh0UTNnODY3UlgzL0Ex?=
 =?utf-8?B?MUFaL1ZSenEvWUtKQ2J1UnVvWEVNVTF6TU1BeXZZRkF4eEVoZXlzakNZcnFN?=
 =?utf-8?B?NzlKYS9CdG1UUmV5d3UzZmtCd28rVjFIZkFWdUFDNDZIRFVvZnVJR0FLak4x?=
 =?utf-8?B?cWlhZUcrdWY0NzRzVklBSFpENGxXTlMwQmRhKzduNGR0d2M1TFRQWUpXTFho?=
 =?utf-8?B?ZUdHYm9yVjhQOVBrZU1rOHRJYWFpTkkwSWh5dFoyUU5VZFNqK3hOLzZkby84?=
 =?utf-8?B?UmtqSDUyb2lhaW9nVEE5K3VndThiWTR6N2JRUU1aTzdEMnBMdWFOYTVRbmxh?=
 =?utf-8?B?SHErQTkwQ28xckwzeGNEczY0amJFcHhiRkhHOXRzVis2M0gzUXZRWVhsUWNN?=
 =?utf-8?B?Z0pRQSt6VnNVUTlNQ2VPYWFaUGZKVE9QcHdaa2ZZTFRtc2c5aFp4M1puZnN4?=
 =?utf-8?B?bUZJR1FkNkx6RHJlc1BJNUV0NDBKRXowSUN5azRKUk03cUEyZjhNcDhzd0xP?=
 =?utf-8?B?bUJGT01GN2dySFEySVlsZVdmWW9BblVZTFFlcUtGUG1ZaThjdWRZZlRPYXpu?=
 =?utf-8?B?VERveld1cXlkMnUrem1YbFJpeVY2bTBoMldzMWNOdld6SWpjcHBJK2ZOVVRn?=
 =?utf-8?B?bWVTVUZhWVgyZjlwWnFDbStCMGFQbkI3VWg3MkU2L1A1bXBneXlSVm9IZnE4?=
 =?utf-8?B?YkFmQ3l6TnFSdERPdkt6aWRKMWFZM0xxcEFFbnVyUGdpSUJrN0FqOUJIdVZK?=
 =?utf-8?B?ZjNtT21qcDUvRFVqNEEzSlVOcll4NTdNL2tIcTh5Qy96MmlIQkxmNmZsMTBZ?=
 =?utf-8?B?amVnTzM1Uk5SUG5NVXNFMU5HRWtxdnYxb3pxbjNPd0ZraW45czhFank2clVt?=
 =?utf-8?B?STRJZ0tzWUpyeFFxWU41Wm12dTAzRnJ4YXFHNlpJeG9haTlaVDE1b0p5U0hr?=
 =?utf-8?B?YnR4blJqVXRWWWZLaW1NcnVXSXZIV3p6d2o2QUdkUEt0RFAzYmN3Rmc2SGQ2?=
 =?utf-8?B?VkR1aFRMNDJGTzdKU1BLWk0xREhYWWU2eElyeitPS0ZoV043NExjSm9KR095?=
 =?utf-8?B?a2NCdmF1V2hBd3kvV2tHek9YTXhIbWwyUlRZR2VGUUsyYTRUMmtGNkM4MFhE?=
 =?utf-8?B?ek5QNkVBL0xTNUh5VHBydy9ub2tFN2ZhYldqSGo3MzVZeWtGL2xGOEc2ejdw?=
 =?utf-8?B?enN5V2prTXhVUEFRRzZGSWYzcy9xd1pNQjlSZ1VZdGNhTXh5V3M4YTdpbG10?=
 =?utf-8?B?ZGpYSkQvQ1plcGpvRXFoaHU1N0E4R0tXaEt1Mkc1bGdKeFVMSnc5SGhEdnll?=
 =?utf-8?B?b0FJZEg5MWZaM3NhbHB0MUpQMVFsMUFvc2hoM29wazVWcnNhYUdsNTRLVXgw?=
 =?utf-8?B?aUo4ZHhnd284UGZNQmpQeWVnTSs2bktyeS9PVkJSMjJvd0wwU01qb2F2OG0y?=
 =?utf-8?B?U1o3eFRZNzNvVThwOXFNRXZ4eWRGWW5uVGw2U0NEV2RCbk9neFRmZkcyUUJZ?=
 =?utf-8?B?a0JRc0VFY0VZbUtlYkhwRUhOMmlyS2FlVTFsbEpubXIvSHA4czZlbTVxdFNm?=
 =?utf-8?Q?fdMM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d254b81-fdc6-4fac-9bbe-08db525f3d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 20:35:21.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csPzqyk+2p/qMDn8oMTZXLD7zmzFoUVxGY4ieK2Yjm9T4ri+pb01e895by2mkYFVKvESwkehnuZoDAD8liVeVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8242
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVpbmV0dGUsDQoNCllvdSBhc2tlZCBmb3IgZXhhbXBsZXMgb2YgcmVzb3VyY2VzIHRoYXQgZG9u
J3QgZml0IHdlbGwgaW50byB0aGUgZXhpc3Rpbmcgc2NoZW1hdGEgbW9kZWwuDQoNCkhlcmUncyB0
aGUgZGV0YWlscyBiZWhpbmQgb25lIG9mIHRob3NlIGNhc2VzLg0KDQpFeGlzdGluZyByZXNvdXJj
ZXMgaGF2ZSBhIHNpbmdsZSB2YWx1ZSBwZXIgZG9tYWluIChlLmcuIGEgY2FjaGUtd2F5IGJpdG1h
c2ssIG9yIGEgbWVtb3J5DQpiYW5kd2lkdGggcGVyY2VudGFnZSBvciB0YXJnZXQpLiBPbmUgb2Yg
bXkgbmV3IHJlc291cmNlcyBoYXMgc2V2ZXJhbCBwYXJhbWV0ZXJzLiBBdCBmaXJzdA0KZ2xhbmNl
IHRoaXMgbWlnaHQgYmUgc29sdmVkIGJ5IGp1c3QgbGlzdGluZyBhIGNvbW1hIHNlcGFyYXRlZCBs
aXN0IG9mIHRoZXNlIHBhcmFtZXRlcnMgZm9yDQplYWNoIGRvbWFpbi4gU28gdGhlIHNjaGVtYXRh
IGVudHJ5IGZvciBmZWF0dXJlIFhZWiB0aGF0IGhhcyB0d28gZG9tYWlucyBtaWdodCBsb29rIGxp
a2UNCnRoaXM6DQoNClhZWjowPXBhcmFtMSxwYXJhbTIscGFyYW0zOzE9cGFyYW0xLHBhcmFtMixw
YXJhbTMNCg0KQnV0IHRoaXMgZmVhdHVyZSBoYXMgYSBzZWNvbmQgcHJvYmxlbS4gVGhlIGhhcmR3
YXJlIHN1cHBvcnRzIGEgdmVyeSBsaW1pdGVkIHNldCBvZiB2YXJpYXRpb25zLg0KVGhpcyBjb3Vs
ZCBiZSBoYW5kbGVkIGJ5IHJlcG9ydGluZyBudW1fY2xvc2lkIGZvciB0aGlzIHJlc291cmNlIHRv
IHRoYXQgbG93IG51bWJlci4gQnV0IHRoZW4NCnJlc2N0cmwgY29yZSBjb2RlIHdvdWxkIGxpbWl0
IGFsbCByZXNvdXJjZXMgdG8gdGhhdCB2YWx1ZS4gSW5zdGVhZCB0aGUgaC93IGFsbG93cyBwcm9n
cmFtbWluZw0KYSBtYXBwaW5nIGZlYXR1cmUgZnJvbSBjbG9zaWQgbnVtYmVycyB0byByZXNvdXJj
ZSBpbnN0YW5jZXMgKGFzIHRoZSBzYXlpbmcgZ29lcyAiYW55IGNvbXB1dGVyDQpzY2llbmNlIHBy
b2JsZW0gY2FuIGJlIHNvbHZlZCB3aXRoIG9uZSBleHRyYSBsZXZlbCBvZiBpbmRpcmVjdGlvbiIp
Lg0KDQpTbyBpZiB0aGUgZHJpdmVyIG5hbWVkIHRoZXNlIGluc3RhbmNlczogQSwgQiwgQywgRC4g
VGhlbiBhIHNjaGVtYXRhIGZpbGUgbWlnaHQgbG9vayBsaWtlOg0KDQpYWVo6MD1COzE9Qw0KDQpt
ZWFuaW5nIHRoYXQgdGhlIGRyaXZlciB3aWxsIHNldCB1cCBzbyBDTE9TSUQgZm9yIHRoaXMgcmVz
Y3RybCByZXNvdXJjZSBpcyBtYXBwZWQgdG8gaW5zdGFuY2UgIkIiDQpvbiBkb21haW4gMCBhbmQg
dG8gaW5zdGFuY2UgIkMiIG9uIGRvbWFpbiAxLg0KDQpUaGUgZHJpdmVyIHByb3ZpZGVzIGEgd2F5
IHRvIHNldCBwYXJhbTEsIHBhcmFtMiwgcGFyYW0zIGZvciBlYWNoIG9mIHRoZSBBLCBCLCBDLCBE
DQppbnN0YW5jZXMuDQoNCi1Ub255DQo=
