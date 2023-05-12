Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CDE700FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjELUfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239488AbjELUfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:35:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4550610C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683923736; x=1715459736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cOr7QDaI9JNjzVuWWQ9C+RNtOX8UX/a6pw3GtFIuXIg=;
  b=djO+d6OBotCl/IyuyL3tk1/OT6FIcxeVmb44vn0WzWqgzCYoUpN1Tsxb
   SV5V+BIQpV2KNVRAn5d5u53jCx9/GaoSzgyLE7hZlwPcTbnr3xvFFLhH9
   QpX/prgc55LKO5GpOzj3xzDiuIomnUGrSQDXD5r35OLZXaZq7KLTzCE6V
   JHrczg6wUdtwi7iBymLfmKZDNZL5nY2nVBRzoHsQcVNxRMoEic9T5WWGG
   f5DtU4+ZiMHGkDwct/LqN0fzO1nXQidcrftxQ8g3VVyB5LSjDT1r4QNeF
   7Ky54v+V17q2NuEWDUQD3aQBeNdgNVXPjQQZmBevJ1LQ94mOwPK3oDcOj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="353134305"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="353134305"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 13:35:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="703304098"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="703304098"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2023 13:35:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 13:35:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 13:35:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 13:35:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0Z2hKKil8OWIgWba1z/wrl9+qPI1Tha1+MU76zuMs3tx3W7VKWeu5bFt/IA2ajpUDtdbv5DJWszj/9fImddCx4/46ajbBD8LIV32Mgnxg+1NlcrBZhX49YJFWHXmrWQS5Kyf/wYwpAiA0Ut9Tz5yKuO7LAygX2rzf0YOhB/3Htjuy/+OZmE+YXEw+a9twXmb2ns0+/PeoUezwxC1ZC6roEUdQ49DbuVEX4eyVPizz9hh6376J/k7P/bkUk3J1ziX4KxuZYnO/ObYyykzFHetnc+/un6/jpu83VH30ZEoCiyg1lC2b9PN+azw/A/pYVXAgEGMY32ykQHfu/3nSJspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOr7QDaI9JNjzVuWWQ9C+RNtOX8UX/a6pw3GtFIuXIg=;
 b=Ezh+GjUF/tOh+GlnUTXyTIxmGHkjJQY7hd3Zvr6rLm9v4Ez6P6z2zWuAzw7lGym3D43LUyGRt5Bssxp78MrSMJculWOLN4+xZPnWCgv19JVf7JZWhRA8c1zhkpEvXN1MHp2QIOiJpyaAj/WCG4K4PYXLZsfFi44jCZyuY6uaolgoUtGHhN+kBa+xtHBnFEoZmhEwYikdE0fjEBCKzDNqxgCs2uz4BF6vZ4RPeY8qQOOZCFIRo13Mk90Rm5XWOj17S6MK20Y8WltC79cIzhKEvI56WQudlGWq/6FV3kp8PFpXJWY/RLp5PkZZ8j4vDp5Mey016ET/uoCcnVg0e6BjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 20:35:26 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 20:35:26 +0000
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
Thread-Index: AQHZc9RpUDnrLIcguE2hFRoOJfWMkK9MZ88AgARWAUCAAdZ8gIAABlIAgAMJStCAAVn4AIAANkHQ
Date:   Fri, 12 May 2023 20:35:26 +0000
Message-ID: <SJ1PR11MB6083CB61BDCABA2930155C2AFC759@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <c0755752-ce84-b5f9-6ac6-97812e98b8c3@intel.com>
 <SJ1PR11MB60832074F3140B38C1B08596FC719@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <237603b3-f553-2ede-5725-239b65626c69@intel.com>
 <SJ1PR11MB6083CFFA8CBDD296E966EC85FC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083031582F2A61A7D24ABAFFC749@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <b35c1b06-4236-15dc-6aed-ece8a0331c8c@intel.com>
In-Reply-To: <b35c1b06-4236-15dc-6aed-ece8a0331c8c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB5863:EE_
x-ms-office365-filtering-correlation-id: 94c8eabf-0c70-4ed5-5b20-08db53286b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f9dfRbHAwxIGAhFy+cAlAFk83ecZ5HL5uUOl5o3d8k/XQDVW1/mvIjAofnzNE65eJ5JHEjHzAyzs4AnEwlAW09JPGzn0x980H4MtgrYBre0Cjg/xQOfIPktEOPI5+RsNYCWjdFE2tYGA7G3Elo7KXQ4GNpTu0/ZLmsEIITE1eji/kVwZekF/GoeURhWZw6toba4Q1Mlhr8aXRCbkBAt66KWMt9kN3AnOgQGnh9VkvLHbYmr7vZcBBobnh7DEU4L8dRtPfzYgK/qWGTuoQUdqwV2woXG4XN4ngcCzArVloL0aYmPZThRTmHgK19wZGwSLBH9gyAqBBqPEvLKNzO3mYJ0B+j6WpV59EvECTHYjOiJFYxPEOIE/MBCakmGegXtHzSdbp6bYj3ELez08icubyQcNESvWiNcz7HEQgvccCWT87OLum5YCD7d0hwLP32Zm6gsBj8dxp8zBvb0im2r/pW1D5j9GxskOJ6q0vGOrwr9zfZGOOUorpDawxhLFM+lLqTskM91nr22iVEuW/huZ+PdsHJ7tMR7zSucQffyYofae2azoiePfi0MUCNa/VKvaT5aVqtfKb+8TaC1j+cH0LY3mfa6PohUvH09bqZ3tjMHNXE/olNluRSXgGwF/Pggw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(66476007)(4326008)(66946007)(76116006)(66556008)(66446008)(478600001)(7696005)(64756008)(110136005)(54906003)(316002)(38070700005)(86362001)(33656002)(83380400001)(186003)(6506007)(9686003)(26005)(8936002)(52536014)(8676002)(7416002)(5660300002)(71200400001)(2906002)(55016003)(38100700002)(82960400001)(921005)(122000001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkpYWlFHbHYycVZlNTgyQTdnZUs4c09BK2RiZVNPcldQbnl1dW9jenFwN1dV?=
 =?utf-8?B?c0RXZEZNVlllelVoc3hLRG8xekg3eTN3UllaTm55ZEVpTjJCN3llcXlQMHJs?=
 =?utf-8?B?d29sTzAvVXJjd3lZVlV2cXovV1c4QlpIcnVpc3hVRUlJSnVIRmFVeTRNcldR?=
 =?utf-8?B?R2l5aHpYenF6S0xJWXF4ajIxa2ZMMldxaXlNcS9jUXY1SmNsNjNzWHU4WUhH?=
 =?utf-8?B?a3MzS0phNGJTU0RkYnNEZVFPZzIvUjJnQ1B3RmRSRkw0VEFFQTBtSmhpdFdI?=
 =?utf-8?B?K01sWlgvSEVabFVvQzJkQmNua0V0Y0UyR0ZZc1l1YTBCSHFBYmR2cTQ3RU9y?=
 =?utf-8?B?YnRMcXBSdk14U0Rmd1A4eHpWTzBDOGFIMG1tVHJvcWsxMERna3JWcG9PZkMx?=
 =?utf-8?B?YkdRMzRibkFhVTdNU1Y2MU1SODRCSGN6VDJFRW5Raml2dnNKdERsRUhLQ21Y?=
 =?utf-8?B?MkxtK3Q3SnI4Uk9HZ0tUZzFKUG5waklzdU4yNEZrV2Nkc3JRbGV2OERGUkZx?=
 =?utf-8?B?eWdWK2xKaldWZ1M2L2RrcjZhbEluWU52TnBERHpKVHdacVVqdTk5LzZZdFZy?=
 =?utf-8?B?UVRKdnM5YUhqUUhsVXV0N3VBMFVJU1BiSnZaWXJVdlVKSFlZREVLNm14T2gr?=
 =?utf-8?B?anl0ZG9uVTJNUFo4S0x2QjV2SHpCRVVra2NzcXFuNmMzM2hwU0c3N1ErZzcz?=
 =?utf-8?B?c0p3bFEyZFgrUENEMnZXWldEYjVWMTdSbW10d09IU2o0VjgvS25vYTFxU3Zn?=
 =?utf-8?B?QWZlTWY4UGF2WWdiUmtUMndOWERGTko2TlFuRGdLVkpqdjZKeVhjTHoxUDZT?=
 =?utf-8?B?ZHdaaVcwSkk0SHlxdk5Sb0NIV1dzKy9tclhVOHlIYnJXZmdKMHhOTTZhdVZD?=
 =?utf-8?B?YUl2MnNrU0p1WVdIMnI1dENkUWlUbUMwaWxuRVJiWFZJZ2d3cThyQlg2WGkz?=
 =?utf-8?B?WURsS0dzUC9CUklXamVBcDB3ckJKUHZBTG43emNwYnpadEdDTmZjVTFIVytY?=
 =?utf-8?B?dFhOOGlIVjh5Z1dxS3d4YWx2WlJMRU9pTFcybllOZUdlVVRrZDlDbzhYUHdk?=
 =?utf-8?B?cTMwZ25iMFM0S0NxeHhHMmd6S1JhYXNHYzVnS0hvT2VtMjV4TmN6K0RmV0hz?=
 =?utf-8?B?TkwxdkRKbFpJYTd4S3lQdWZvekloYkM1RGE4MFNPelpGOXpJYUh5RTJ0b29Y?=
 =?utf-8?B?VkZTeGE3UmdzNGxmVHNucjNhZDBlWHZ4QWV6MEVIbXU5dHAraHIvYVNJYkt4?=
 =?utf-8?B?d05PSzl5TVduL1ZGQzRyVmF3SU1IcmRBNHhGbWc1a2J1WE5nR1ptWFVJWkZY?=
 =?utf-8?B?TUNYR0ZDWHhKeG5MVnVqcmQ5YWx3d1N3UzBZUkRoeDJqRW1QWUpFbFlXUWRt?=
 =?utf-8?B?UThVdjhOeUxSYXRTRkVzVENrdmphUHozc3lQK2dWbjFOTzlKK1MyRFlxQ2J6?=
 =?utf-8?B?cWVJbG5TaEFzV29RUzlybitJemlPQlJ4b0JPZTB3Tld2UTVESThCbmhMQ1pW?=
 =?utf-8?B?by95azJRSTlaQ2NsbU9SRFFjSGtVcW5rTDdpMkpDZ1YvdGZqN2tmTkxHRWRH?=
 =?utf-8?B?U1dtVUgwcmY1N0xDVFlqSXpwUlgyRzIzeGhBVitiS3V3UUJMaHZienkzUW42?=
 =?utf-8?B?TFNJemY1RmxMc1BNK2JuTFMvb25GR0tkbklkOTBOSnVmbTJXUHBNdzlVSUlN?=
 =?utf-8?B?S3VwTzdiM1JELzBMUE1qV2hudTVKTXR5NXdFczlqNm1mQzB6SVFoV1Z0b0Q2?=
 =?utf-8?B?VEtpY082MnFlUXlST2ZkeU1jVkx2ZWxRY2ttVlZCZ3ZzZjdWYTRIZzBmQVQv?=
 =?utf-8?B?L0o0NWUzcEI0MlA4NFdvNHBIWU9DWEZSR0NMcXRLMmFWd0Q5R3NHaURUNjEw?=
 =?utf-8?B?MGp4TmM1WkpML2QySU5PNE9QT3gxcXRCOE0rYjh5Q3djS0NZUXdpQ1VJbFBP?=
 =?utf-8?B?Y2RRUDdhNGIxQ05EczlJTVJiSitRSmx6QWlicGdxQjlKdDQ0cVAycFRWNTRy?=
 =?utf-8?B?cjlhRXdyWjlMRS9rWXhkL2s3NkxzMUtjc3NRakdGczZHZHdacmJDaDJVdHBt?=
 =?utf-8?B?d1htc2RsMnc4Q010a2JRUjBNUGZtRHpJd1ZISEtpYU1hS3A3WERhWkxMUE4r?=
 =?utf-8?Q?mbf0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c8eabf-0c70-4ed5-5b20-08db53286b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 20:35:26.2300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CMWQ56FqwrtOigYXAOV45ku5dKU+YKeBDbdquVpk7pY01yuHxbVoyATOMOW3PRYTfn1YvWY7+WC1a8K9TAIdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gWW91IGFza2VkIGZvciBleGFtcGxlcyBvZiByZXNvdXJjZXMgdGhhdCBkb24ndCBmaXQgd2Vs
bCBpbnRvIHRoZQ0KPj4gZXhpc3Rpbmcgc2NoZW1hdGEgbW9kZWwuDQo+UHJpbWFyaWx5IGFib3V0
IG1lIHRyeWluZyB0byB1bmRlcnN0YW5kIHdoYXQgYWJvdXQgdGhlIGV4aXN0aW5nIHNjaGVtYXRh
DQo+bW9kZWwgbWFrZXMgdGhlc2UgbmV3IGZlYXR1cmVzIGhhcmQgdG8gc3VwcG9ydC4gTXkgZmly
c3QgY29uZnVzaW9uIGlzDQo+dGhhdCBpdCBpcyBub3QgY2xlYXIgdG8gbWUgd2hhdCB5b3UgbWVh
biB3aXRoICJzY2hlbWF0YQ0KPm1vZGVsIi4gSSB0aGluayB0aGVyZSBhcmUgdHdvIHBhcnRzIHRv
IHRoaXM6IHRoZSBzY2hlbWF0YSBtb2RlbCBhcw0KPnRoZSB1c2VyIGludGVyZmFjZSBhbmQgdGhl
IHNjaGVtYXRhIG1vZGVsIGFzIGltcGxlbWVudGVkIHdpdGhpbg0KPnJlc2N0cmwuDQo+DQo+SXQg
aXMgbm90IGNsZWFyIGluIHlvdXIgbW90aXZhdGlvbiB3aGV0aGVyIHlvdSBhcmUgdGFsa2luZyBh
Ym91dCB0aGUNCj5mb3JtZXIgb3IgdGhlIGxhdHRlciBhbmQgdGh1cyBkdWcgdGhyb3VnaCB0aGUg
cGF0Y2hlcyB0byBmaWd1cmUgdGhpcw0KPm91dC4gQXQgZmlyc3QgaXQgc2VlbWVkIGFzIHRob3Vn
aCB0aGUgZHJpdmVyIGFpbXMgZm9yIGEgdG90YWxseQ0KPmRpZmZlcmVudCBjb25maWd1cmF0aW9u
IG1lY2hhbmlzbSB3aXRoIHRoZSBzdXBwb3J0IGZvciBkcml2ZXIgc3BlY2lmaWMNCj53cml0YWJs
ZSBmaWxlcyBpbiBldmVyeSBncm91cCAuLi4gYnV0IHRoZW4gdGhlbiB0aGUgZHJpdmVyIHBpdm90
cyBhbmQNCj5ob29rcyBpbnRvIHNjaGVtYXRhIGZpbGVzIHNvIGl0IHRoZW4gc2VlbXMgdGhhdCB0
aGUgZHJpdmVyIG1lY2hhbmlzbSBkb2VzDQo+YWltIHRvIG1haW50YWluIHRoZSBzY2hlbWF0YSBt
b2RlbCBhcyB1c2VyIGludGVyZmFjZSAocGVyaGFwcyB3aXRoDQo+YWRkaXRpb25hbCBjb25maWd1
cmF0aW9uIGZpbGVzIHRvIGdpdmUgbW9yZSBtZWFuaW5nIHRvIHRoZSB2YWx1ZXMNCj53cml0dGVu
IHRvIHRoZSBzY2hlbWF0YSBmaWxlKS4NCg0KRGlmZmVyZW50IGRyaXZlcnMgbWF5IGNob29zZSBk
aWZmZXJlbnQgc3Vic2V0cyBvZiB0aGUgaG9va3MgYXZhaWxhYmxlLg0KDQpJIGhhdmUgb25lIGNh
c2Ugd2hlcmUgYSBuZXcgZmlsZSBpcywgSU1ITywgcmVxdWlyZWQuIFRoZXJlJ3Mgbm8gd2F5IHRv
DQpmaXQgd2hhdCBuZWVkcyB0byBiZSBkb25lIGludG8gc2NoZW1hdGEuIEFub3RoZXIgd2hlcmUg
SSB0aG91Z2h0DQp0aGUgc2NoZW1hdGEgaG9vayBtYWtlcyBzZW5zZSAodGhvdWdoIHRoYXQgY291
bGQgYmUgaGFuZGxlZCB3aXRoDQphIGZpbGUgLi4uIGJ1dCBpdCB3b3VsZCBsb29rIHZlcnkgc2No
ZW1hdGEtbGlrZSkuIA0KDQo+U28sIGl0IHNlZW1zIHRvIG1lIHRoYXQgdGhlIGNvbmNlcm4gaXMg
bm90IHdpdGggdGhlIHVzZXIgaW50ZXJmYWNlLCBidXQNCj5ob3cgdGhlIHNjaGVtYXRhIHBhcnNp
bmcgaXMgZG9uZSBpbiByZXNjdHJsLiBJIGp1c3Qgc2VlbSB0byBrZWVwIGd1ZXNzaW5nDQo+aGVy
ZSBzbyBJIHdvdWxkIGFwcHJlY2lhdGUgbW9yZSBpbnNpZ2h0Lg0KPg0KPj4gSGVyZSdzIHRoZSBk
ZXRhaWxzIGJlaGluZCBvbmUgb2YgdGhvc2UgY2FzZXMuDQo+Pg0KPj4gRXhpc3RpbmcgcmVzb3Vy
Y2VzIGhhdmUgYSBzaW5nbGUgdmFsdWUgcGVyIGRvbWFpbiAoZS5nLiBhIGNhY2hlLXdheQ0KPj4g
Yml0bWFzaywgb3IgYSBtZW1vcnkgYmFuZHdpZHRoIHBlcmNlbnRhZ2Ugb3IgdGFyZ2V0KS4gT25l
IG9mIG15IG5ldw0KPj4gcmVzb3VyY2VzIGhhcyBzZXZlcmFsIHBhcmFtZXRlcnMuIEF0IGZpcnN0
IGdsYW5jZSB0aGlzIG1pZ2h0IGJlDQo+PiBzb2x2ZWQgYnkganVzdCBsaXN0aW5nIGEgY29tbWEg
c2VwYXJhdGVkIGxpc3Qgb2YgdGhlc2UgcGFyYW1ldGVycw0KPj4gZm9yIGVhY2ggZG9tYWluLiBT
byB0aGUgc2NoZW1hdGEgZW50cnkgZm9yIGZlYXR1cmUgWFlaIHRoYXQgaGFzIHR3bw0KPj4gZG9t
YWlucyBtaWdodCBsb29rIGxpa2UgdGhpczoNCj4NCj4NCj4+IFhZWjowPXBhcmFtMSxwYXJhbTIs
cGFyYW0zOzE9cGFyYW0xLHBhcmFtMixwYXJhbTMNCj4+DQo+PiBCdXQgdGhpcyBmZWF0dXJlIGhh
cyBhIHNlY29uZCBwcm9ibGVtLiBUaGUgaGFyZHdhcmUgc3VwcG9ydHMgYSB2ZXJ5DQo+PiBsaW1p
dGVkIHNldCBvZiB2YXJpYXRpb25zLiBUaGlzIGNvdWxkIGJlIGhhbmRsZWQgYnkgcmVwb3J0aW5n
DQo+PiBudW1fY2xvc2lkIGZvciB0aGlzIHJlc291cmNlIHRvIHRoYXQgbG93IG51bWJlci4gQnV0
IHRoZW4gcmVzY3RybA0KPj4gY29yZSBjb2RlIHdvdWxkIGxpbWl0IGFsbCByZXNvdXJjZXMgdG8g
dGhhdCB2YWx1ZS4gSW5zdGVhZCB0aGUgaC93DQo+PiBhbGxvd3MgcHJvZ3JhbW1pbmcgYSBtYXBw
aW5nIGZlYXR1cmUgZnJvbSBjbG9zaWQgbnVtYmVycyB0byByZXNvdXJjZQ0KPj4gaW5zdGFuY2Vz
IChhcyB0aGUgc2F5aW5nIGdvZXMgImFueSBjb21wdXRlciBzY2llbmNlIHByb2JsZW0gY2FuIGJl
DQo+PiBzb2x2ZWQgd2l0aCBvbmUgZXh0cmEgbGV2ZWwgb2YgaW5kaXJlY3Rpb24iKS4NCj4+DQo+
PiBTbyBpZiB0aGUgZHJpdmVyIG5hbWVkIHRoZXNlIGluc3RhbmNlczogQSwgQiwgQywgRC4gVGhl
biBhIHNjaGVtYXRhDQo+PiBmaWxlIG1pZ2h0IGxvb2sgbGlrZToNCj4+DQo+PiBYWVo6MD1COzE9
Qw0KPj4NCj4+IG1lYW5pbmcgdGhhdCB0aGUgZHJpdmVyIHdpbGwgc2V0IHVwIHNvIENMT1NJRCBm
b3IgdGhpcyByZXNjdHJsDQo+PiByZXNvdXJjZSBpcyBtYXBwZWQgdG8gaW5zdGFuY2UgIkIiIG9u
IGRvbWFpbiAwIGFuZCB0byBpbnN0YW5jZSAiQyIgb24NCj4+IGRvbWFpbiAxDQo+QXBvbG9naWVz
IGJ1dCBpdCBpcyBzdGlsbCBub3QgY2xlYXIgdG8gbWUgaG93IHRoaXMgY2Fubm90IGJlIGhhbmRs
ZWQNCj5pbiByZXNjdHJsLiBGb3IgZXhhbXBsZSwgY29uc2lkZXIgdGhpcyBoeXBvdGhldGljYWwg
c25pcHBldCB0aGF0IHVzZXMNCj5hIHVuaXF1ZSBjYWxsYmFjayB0byBwYXJzZSBhIHJlc291cmNl
J3Mgc2NoZW1hdGEgZW50cnkgKHNpbWlsYXIgdG8gdGhlDQo+cy0+dXBkYXRlKCkgY2FsbGJhY2sg
eW91IGludHJvZHVjZSwgYnV0IG5vdCBoYXZlIGl0IGJlIG9wdGlvbmFsKToNCj4NCj4gICAgICAg
c3RydWN0IHJlc2N0cmxfc2NoZW1hICpzOw0KPg0KPiAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5
KHMsICZyZXNjdHJsX3NjaGVtYV9hbGwsIGxpc3QpIHsNCj4gICAgICAgICAgICAgICBpZiAoIXN0
cmNtcChyZXNuYW1lLCBzLT5uYW1lKSAmJiByZHRncnAtPmNsb3NpZCA8IHMtPm51bV9jbG9zaWQp
DQo+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcy0+cGFyc2VfbGluZSh0b2ssIHMsIHJk
dGdycCk7DQo+ICAgICAgIH0NCj4gICAgICAgcmR0X2xhc3RfY21kX3ByaW50ZigiVW5rbm93biBv
ciB1bnN1cHBvcnRlZCByZXNvdXJjZSBuYW1lICclcydcbiIsIHJlc25hbWUpOw0KDQpUaGF0IGlz
IG11Y2ggY2xlYW5lci4gSXQgcmVxdWlyZXMgcGF0Y2hpbmcgdXAgdGhlIGV4aXN0aW5nIHJlc2N0
cmxfc2NoZW1hIHRvIHByb3ZpZGUNCmEgLT5wYXJzZXJfbGluZSgpICAuLi4gYWxzbyBhIC0+c2hv
d19saW5lKCkgZnVuY3Rpb24uDQoNCklmIHRoaXMgcHJvY2VlZHMsIEkgY2FuIG1ha2UgdGhlIGNo
YW5nZXMgdG8gcHJvdmlkZSB0aGlzIGNvbnNpc3RlbnQgaW50ZXJmYWNlLiBUaGFua3MuDQoNCj4+
IFRoZSBkcml2ZXIgcHJvdmlkZXMgYSB3YXkgdG8gc2V0IHBhcmFtMSwgcGFyYW0yLCBwYXJhbTMg
Zm9yIGVhY2ggb2YNCj4+IHRoZSBBLCBCLCBDLCBEIGluc3RhbmNlcy4NCj4NCj5TZWVtcyBsaWtl
IHRoZXNlIGNvdWxkIGJlIHNvbWUgbmV3IFJGVFlQRV9SRVNfWFlaIGZpbGVzPw0KDQpJbiBteSBj
dXJyZW50IGltcGxlbWVudGF0aW9uIHRoZSBkcml2ZXIgY2FuIG1ha2Ugc29tZS9hbGwgb2YgdGhl
IGZpbGVzIGFkZGVkDQp1bmRlciB0aGUgaW5mby8gZGlyZWN0b3J5IHdyaXRhYmxlLiBTbyB0aGlz
IFhZWiBkcml2ZXIgdXNlcyBpbmZvL1hZWi9wYXJhbSogZmlsZXMNCmFzIHRoZSBpbnRlcmZhY2Ug
Zm9yIHRoZSB1c2VyIHRvIHNldCB0aGUgcGFyYW1ldGVycy4NCg0KPg0KPk9uIHRoZSBtb2RlbCBz
cGVjaWZpYyBtb3RpdmF0aW9uIHRvcGljOiBJZiB0aGUgZ29hbCBvZiB0aGUgZHJpdmVyDQo+aW50
ZXJmYWNlIGlzIHRvIHN1cHBvcnQgbW9kZWwgc3BlY2lmaWMgY2hhbmdlcyB0byByZXNjdHJsIHRo
ZXJlIGlzIGENCj5wdWJsaWNseSBhdmFpbGFibGUgdXNlIGNhc2UgZm9yIGNvbnNpZGVyYXRpb246
DQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDQyMTE0MTcyMy4yNDA1OTQyLTEt
cGV0ZXJuZXdtYW5AZ29vZ2xlLmNvbS8NCj4NCj5JdCBpcyBub3Qgb2J2aW91cyB0byBtZSBob3cg
dGhhdCBtb2RlbCBzcGVjaWZpYyBwcm9ibGVtIGNvdWxkIGJlIHNvbHZlZA0KPndpdGggdGhpcyBk
cml2ZXIgaW50ZXJmYWNlLiBZb3VyIGluc2lnaHQgaGVyZSB3b3VsZCBiZSBhcHByZWNpYXRlZCBi
dXQgaXQNCj5zZWVtcyB0byBtZSB0aGF0IHdlIHdpbGwgaGF2ZSB0byBrZWVwIGFjY29tbW9kYXRp
bmcgbW9kZWwgc3BlY2lmaWMgY29kZQ0KPmluIHJlc2N0cmwuDQoNCkFsbCBteSBkcml2ZXJzIGFy
ZSBjdXJyZW50bHkgcmVsYXRlZCB0byB0aGUgY29udHJvbCBmZWF0dXJlcyBvZiByZXNjdHJsIHJh
dGhlciB0aGFuIHRoZQ0KbW9uaXRvciBmZWF0dXJlcy4gSSBkb24ndCBzZWUgYSB3YXkgZm9yIGEg
bW9kZWwgc3BlY2lmaWMgZHJpdmVyIHRvIHN0ZXAgaW4gYW5kIG1pdGlnYXRlDQp0aGF0IHBhcnRp
Y3VsYXIgcHJvYmxlbSB0aGF0IFBldGVyIGhhcy4NCg0KU2VlbXMgcXVpdGUgaGFja3kgdGhvdWdo
LiBUaGUgdHJpY2sgd2l0aCB0aGUgImhhcmQiIFJNSUQgcGVyIGNvcmUgaXMgZ29pbmcgdG8gbWlz
Y291bnQNCkxMQyBldmljdGlvbiB0cmFmZmljLiBJZiBhIGNvcmUgaXMgc3dpdGNoaW5nIHJhcGlk
bHkgYmV0d2VlbiB0YXNrcyB3aXRoIGRpZmZlcmVudCBSTUlEcw0KdGhhdCBjb3VsZCBiZSBhIHNp
Z25pZmljYW50IGRpZmZlcmVuY2UgZnJvbSBhY3R1YWwgdmFsdWVzLg0KDQoNCkJ1dCByZXF1ZXN0
cyBmb3Igc29tZSBtb2RlbCBzcGVjaWZpYyBxdWlya3MgdG8gd29yayBhcm91bmQgaC93IGxpbWl0
YXRpb25zIGRvZXNuJ3QNCm1lYW4gdGhhdCB3ZSBzaG91bGRuJ3QgY3JlYXRlIGEgZHJpdmVyIGxh
eWVyIGZvciBjYXNlcyB3aGVyZSBpdCBpcyBwb3NzaWJsZSB0bw0Kc2VwYXJhdGUgcy93IGludG8g
bGF5ZXJzLg0KDQotVG9ueQ0K
