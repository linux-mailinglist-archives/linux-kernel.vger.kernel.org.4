Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7156F5D65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjECR6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjECR57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:57:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA52BD;
        Wed,  3 May 2023 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683136675; x=1714672675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xPTY1fBXx3tILGniPUwYyTNFjSY0ibnMv7k0/ICKDak=;
  b=C7nqvzR0Av9ShWpwMsYqepDh1lcXcmIQ+8+OtNPhtliP1/ZSVsDAh6kg
   HNWtTO+58yIJAtyIxgIueweOQFloJeThiubTNVcuakwUjOesgjBpGHcFk
   Nr9vXSj+G2WcL6x2L6TK69Nt6Fz8O6ywQZomEKwiBJiSV2CwgViaTvs0u
   u61dnmulRWidwuiN13Z3zYe+FF7hL7fV7S4BYMOY5/AMq8E8oLqJ1aLC4
   fYsQqIhzMfERmvxa2YH9ENJI0R+ljPmS0i9TzvLfz8nCrWSvzBJjvVldj
   FMeROIZJUm3Uv7FFcfvId28I9MTpfsX993KwGeseVPn/cpYQY4TxxnqTr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="435032957"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="435032957"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 10:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="820846920"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="820846920"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 03 May 2023 10:57:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 10:57:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 3 May 2023 10:57:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 3 May 2023 10:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdRU7+S9oWu/NOWCocxxfmHOM7kPZUcuYZHVvYQ105CVRvxbtFzCat+FrgU3ycGd/Dd08HZhRQC/jY76Avd5xfPnfN7jKLxzr4+++UkwJC+4S6DiPmg6OVsQ54bTvlSIiks9gNwFLyLLri7vpSpppdsjgFC6r5MdgDos7n+iUTN+61A1iJfCJTs7lv8Zi+HtmtJvx2PahzbzHI72a8EMNyymS3AC+WxRkSO7LeWP7UqbU/VqEc+VYkdveVgCXDuQQ0SahwdEKGEAsX4VuwNbE2XkVeMiMf+0t4L6ZBl0JNRh+ntSrgOiolWkYfzN7U4zB6fZJWoiJD9CTn8PDFUiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPTY1fBXx3tILGniPUwYyTNFjSY0ibnMv7k0/ICKDak=;
 b=CT1t3r83oTlULUxfIg6l9FoRdsuCY88PLf+5qslGsPsu0yWx+tGMWv//RmtdtuIzMObWT1j6wfcz4FkS4q9lRDv1Y5CBberV+vEgU3n6FFZNl0ou2IUIOOgNVfS1dPxKC2A7PvOUrgz+9vq4Klb9tyH4DNLqoXCXRt7ZsdsdWIih5JBKflcn0aQcztQ6HbrLvwEabPhnzkqV5cKgrNOgDxbtrpz34z4KN3FHQM5QcA8lX6CCjpmC29bc9/JAwPnYKgn5kRv+XkSwVoNgBxJjIY8P012IAyQsgeNAfZVOMkDabjsOFPP3ZGLo29/FyMX3aMqf0Y0/VDS4UK51iK/mKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by CH3PR11MB7274.namprd11.prod.outlook.com (2603:10b6:610:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 17:57:53 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::3403:36be:98a3:b532]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::3403:36be:98a3:b532%4]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 17:57:52 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "raghuhack78@gmail.com" <raghuhack78@gmail.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/mbox: Remove redundant dev_err() after failed
 mem alloc
Thread-Topic: [PATCH v2 1/2] cxl/mbox: Remove redundant dev_err() after failed
 mem alloc
Thread-Index: AQHZeW/+HGU49hY5IEWNDLziZDCsaq9I3qwA
Date:   Wed, 3 May 2023 17:57:52 +0000
Message-ID: <092aa8a27392b191d17930bd64fb98cf955681e9.camel@intel.com>
References: <20230428012235.119333-1-raghuhack78@gmail.com>
         <20230428012235.119333-2-raghuhack78@gmail.com>
In-Reply-To: <20230428012235.119333-2-raghuhack78@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|CH3PR11MB7274:EE_
x-ms-office365-filtering-correlation-id: 6f13f0f6-efa5-4da2-7af0-08db4bffea79
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r5S72BXlhvI+NmzhNtVQzbJGbj2dc/mhKD4mU6GXOXa3qSOEUsgUZlO9uRMB/KcSWq+EAbWIejYziDtBgmhc6Cmd2zeWKBdGpRVVncNNbJ0pALfl+sYqw4rpoF+KkxB18OFM7l4lTaPvyFb7c0tidEj7e8JmdhZurnLflCDtgFQ7qoiFFTaLUjHZ1C/TduSSu6nCOmMpsZwnOUMss3wzhCtl642T6jVK+Klxu2dJ+I1xa0TcSKRThogNVkWnsb5qGo6zhKHOaWD0EnGS+lJVGBTmIeQplUBt08pVh0Tq4wUeO8mo7V3R3UXOnIvOjh+zbtcuPidNM9bxw9GhtzvcvvFeJTiB9nKm/ogee7hMiI2kSLuzuW3gdEQn5VqyJwFOt0wIxWp1fca/R/4p4eIvCxdna4R0Byi4c//MX0s4OOQYfmr57NQk25mhFQTdq5/+R2mwwY61bP5DQCo8MZKQ9AAO+Mz1iZSvj7+KgmLheNPZGaE3pKv9COBLJZl6f3tYYiHLrsCavKEGIGBQffcdAJEDXZP4S2YpFQGJlP+nkx96wGfM8DiyT4fHcVYDp8NtpKlsRnn1QX6euvN2gYk967nyLJwNDgTvSZYuPjFfau4lL8nYRBkU8CYp+VZPaC2/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(4744005)(478600001)(2906002)(66446008)(4326008)(76116006)(64756008)(66556008)(66476007)(316002)(66946007)(91956017)(5660300002)(8936002)(6636002)(110136005)(41300700001)(8676002)(6506007)(186003)(26005)(38070700005)(6512007)(2616005)(6486002)(122000001)(86362001)(38100700002)(82960400001)(71200400001)(83380400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0F2OHdpYkdVS1M5bGhkZytZTnlKODExRWYvcVdmd1Q5VURTMDFkSzZTTURC?=
 =?utf-8?B?UnhwZlBycThMelR0MHZLMnA3LzNKVS9KYlZINHk0SW5UdnRVZitIK1FRUXhu?=
 =?utf-8?B?WW9LdWZHRUU0NCtFSXk1ZitHTXdiWE1EZytWa2xpRDhLSTY4TWx0OStyb1pB?=
 =?utf-8?B?V0cwTm1QT3BjNDhlQmI0WThneVdqS2Z0OWRyT2kxaW1OVnZ2RUhTTnNERmxT?=
 =?utf-8?B?MVI2dU4rWEdjNkJyR0IvSk1SMVBqUWpoY09pWlIweENKbmpCRkJhTDVlZDBF?=
 =?utf-8?B?TUh5RjlvT2FEaTMvTllJdHV2MVIrd3p0aVEwb2RpU0FJZGRxa2RPNG9hT0lJ?=
 =?utf-8?B?UFd0bjRtRXVidVNHbnlXWG01bnpuU2tzVUJLNHNxTmxVWDNncVc0YWNkelU5?=
 =?utf-8?B?elpLcWl0NG5PUStNSmhEY21hblAyQUp3OVdwVXI5VklpTWltcG5TRmVITmpU?=
 =?utf-8?B?OU9uMndOOFFYTnhBWDRaNTUxTk0zbkhzKzZua1FyNWFUY2V2aHd4NFZENjUy?=
 =?utf-8?B?eWlKcG5kQ1JXbW1WbXlZc3pHZVgxaDBsMEJBa0I0K1NQTnM4QmVadjdiVHpJ?=
 =?utf-8?B?VXo4MngraDJ5dlAzTEF2NlpFMGdyaUdReHZrQ3ExZ1pvZzA0cURZSU5xRHJj?=
 =?utf-8?B?am1zbk0xU2luUURud2RMQ3JJc2pCOWJLMFB5SDhhdDJ5dVpycERWSDEvclNx?=
 =?utf-8?B?M1ZodVBCeGNFNE81TlY4L1Y1REMvV2sySWlaSWJaNHZXd3lIVDBtWmVrdWZh?=
 =?utf-8?B?Wm1LdHFrcG0xaG94bkFkbjFicVdrMS9tN05WOUkrMEM3SG03ankveFZuZ1Vi?=
 =?utf-8?B?b2I2SE9XalBocXVQd2taUGFqWXdPVFJXT3poNWE1V2ZjakYrUThMY2lGOFd2?=
 =?utf-8?B?V1Ztb0Zmam5hclM5NjExSzFQaTBYS3dacmV5SlZyeHNNQUpJOUZ3eUMweURN?=
 =?utf-8?B?UVM1Y2ZFWGdDOVhyVzR6S3NodVBycTl2VXBrS1FxNWNiVG5xZTBPc1ZzT2Vw?=
 =?utf-8?B?VVZxZnpCYVdxRnltZ29YbkRxRi9pcVdvT0lIa2JaNVVETzdFcXZhMzk1a2lp?=
 =?utf-8?B?bVNVVkpYQ1p4aUZBTXpRbTl5RllISXBzbHlUS1JhdkJLMzViSXVrRjlPL01s?=
 =?utf-8?B?K05qTXhUUmhoUnhaamFXMmwyZkplWXNGWlFaYmMyRktPRG9TNllFb2YrOUFy?=
 =?utf-8?B?SDNQK1Z4cVdzYXYrKzVXM2NFRVJLTWZSTzBaQXgxdDdyYkdYUUxKWWJzcE9l?=
 =?utf-8?B?dkZkaWl4aHphdHZIc3hZWlFWd2ZHTWFLRy8rdjR2T3R5Q1J0NjBydkdWTEto?=
 =?utf-8?B?d3p0L2pPeUlqWm0yTUZST3R3QWt3YkFWVHZab0xHbFd2VWphS2N6bE51QWt1?=
 =?utf-8?B?QTRxM0Z3YVBqQitXNGhpeitpVmtpKzNiNkNsMlpCQ2Y5YkJxOXNVa0IzcVp3?=
 =?utf-8?B?RTRRa2swNTB5ZTAwWDV5OTVmcllibVU0TmRiNDNXWjRKVlZaclB5dWZrL1Js?=
 =?utf-8?B?YzhndGdaOGQ1L1VaOXFUWlFnekRhUkpxOWc3VWRVYVZ5Rno2NjBnRWsveVlx?=
 =?utf-8?B?WkxjZzZTKzlJanU1S21OWktkR3loVjVXTTFnU1k4NmFCYjJOOVR6SEg3U2RI?=
 =?utf-8?B?RE5lTDRxZ0p2YVlnYU1NWkFjQi9HL0tBWm5salFDamdJU1FJZlZyRTlnajVB?=
 =?utf-8?B?cldqWlVGVld2SndPa01nY3BKQytJZ2o2TGFZOW9nVDVUa3pBMTJQTFVzVGpF?=
 =?utf-8?B?dzVhRHh5eThRbWFRNWVac0NxTzFkbHNzM0FubTNRREJNOXFvV1BpejNWWllF?=
 =?utf-8?B?Q3B1aDIwcU9hMmEyK281blJqNTlZTDdCZE8vZjdXNGhZRnYrT2NqSThaUVNB?=
 =?utf-8?B?YUFwQm5SQkE2OTB6ejZmRjdhUTRYZG5TdFF1U3J2ZGVMajZKRndtTHN4amQ3?=
 =?utf-8?B?eGIzdmlpeVRzZ0p2dU82bkdMbUlCTHMrWFdtVXRUVDFSYU4vWHQvb216cXBi?=
 =?utf-8?B?NVpxc2NmTmNSTDlMTm5BRjIvME5nZThEQzVJVlhtclNzcHRZRXA2T3daTnBT?=
 =?utf-8?B?KzV0bFEzdlBtQUxmZUFoMzR3cGIyNlZTREU0RHg0d3U0VTdXb3ZYV0F6ZlNO?=
 =?utf-8?B?QnNiTzVuOG1TU2hmRVFmVXdLN3B3M0RxSEFZaVhqcDFhbm1ObWxxM1JKbWJp?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83C35CCB6509014EB3F6EABF74AD4361@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f13f0f6-efa5-4da2-7af0-08db4bffea79
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 17:57:52.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+akPOXomM/a56jI0G491UdLbZBBCy3h4qH+2WmcUcPlRCJadDDNk3dflFi11vrk9WC3zEQqaT+vKjvnFZDpGW7AMhXMzRXt+XZ0u/YQ9g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7274
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDAxOjIyICswMDAwLCBSYWdodSBIIHdyb3RlOg0KPiBJc3N1
ZSBmb3VuZCB3aXRoIGNoZWNrcGF0Y2gNCj4gDQo+IEEgcmV0dXJuIG9mIGVycm5vIHNob3VsZCBi
ZSBnb29kIGVub3VnaCBpZiB0aGUgbWVtb3J5IGFsbG9jYXRpb24NCj4gZmFpbHMsDQo+IHRoZSBl
cnJvciBtZXNzYWdlIGhlcmUgaXMgcmVkdW5kYXRhbnQgYXMgcGVyIHRoZSBjb2Rpbmcgc3R5bGUs
DQo+IHJlbW92aW5nIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFnaHUgSCA8cmFnaHVoYWNr
NzhAZ21haWwuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL2N4bC9jb3JlL21ib3guYyB8IDQgKy0t
LQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCg0K
TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGlu
dGVsLmNvbT4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvbWJveC5jIGIv
ZHJpdmVycy9jeGwvY29yZS9tYm94LmMNCj4gaW5kZXggZjJhZGRiNDU3MTcyLi4xMWVhMTQ1YjRi
MWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvbWJveC5jDQo+ICsrKyBiL2RyaXZl
cnMvY3hsL2NvcmUvbWJveC5jDQo+IEBAIC0xMTEyLDEwICsxMTEyLDggQEAgc3RydWN0IGN4bF9k
ZXZfc3RhdGUNCj4gKmN4bF9kZXZfc3RhdGVfY3JlYXRlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
wqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfZGV2X3N0YXRlICpjeGxkczsNCj4gwqANCj4gwqDC
oMKgwqDCoMKgwqDCoGN4bGRzID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpjeGxkcyksIEdG
UF9LRVJORUwpOw0KPiAtwqDCoMKgwqDCoMKgwqBpZiAoIWN4bGRzKSB7DQo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgIk5vIG1lbW9yeSBhdmFpbGFibGVcbiIp
Ow0KPiArwqDCoMKgwqDCoMKgwqBpZiAoIWN4bGRzKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiAtwqDCoMKgwqDCoMKgwqB9DQo+
IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBtdXRleF9pbml0KCZjeGxkcy0+bWJveF9tdXRleCk7DQo+
IMKgwqDCoMKgwqDCoMKgwqBtdXRleF9pbml0KCZjeGxkcy0+ZXZlbnQubG9nX2xvY2spOw0K
