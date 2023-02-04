Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E769868AC0F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 20:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjBDTTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 14:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjBDTTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 14:19:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A07D22781;
        Sat,  4 Feb 2023 11:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675538389; x=1707074389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I1si4+9f8g2+rlyI62XRPMfhmrXhKb4bf8iUgXl9MGw=;
  b=L04SlqQFLisgX90XELZEYVG9e6IizlTKWysUjF41kV2PuKZq7VytbanO
   EwAbeskXfewx6sHAXAeSkm0U9k8jBi8NO3LeXEpAxNvhPE0Mz4y6tc0lI
   9VlxQ6e4MG0NVi4ddpjlKvQeog/1edALM7oyluaiZW4QkYLbA6Obt3k8I
   KDnTKz/EDUxSD5J/LcOOk220kVkdPYhtZ828gIfj0xi4oghBTG3TmvefB
   VBiFdITvJNnTQhPHDJ695FvKRppEdfQPakNxhcvgmTBKVajUOaMZDlJDc
   85IWfeZch0PX5GVnGCV+hozn/NnzHDRmgW5YZpVKwFjkIXdSk/T0qm7zZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="356324534"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="356324534"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 11:19:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="808689716"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="808689716"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2023 11:19:48 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 4 Feb 2023 11:19:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 4 Feb 2023 11:19:48 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 4 Feb 2023 11:19:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPy9TXU0HXrVAkoMSr5Le0VdzJ0qs4e/GikGgMeudIB9DLXO+fj9epLhrfXeIh3Vl5XzJrPtHxN6/G/AA1/I2dZZep2WcFU6EZ1Bf3KegCg2sD5QVLbElf0TqMAwdPNaJfYnUY8VMzsntJpvuHaD90nLhDPz7Yck6e+mifbtBXLxWB8nC7FIw1INCYN33OOfRLJEVnbYirP9Ng45PQ4edYxCNM3+IcKfRJ6fdGjzUtSDua6KbgJbsBpjx6wApvELX5HHsEDzjUGr3yWy4EDFc9yVQfKEvsOLcA1ATFAksfEi/TxZgXEy3hjizZYUMF73z9Wm4/zM7u/CSgmVMbRohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1si4+9f8g2+rlyI62XRPMfhmrXhKb4bf8iUgXl9MGw=;
 b=Ew9RWBRqzS2so/tjcUt0UFAob36U9fXXf+4dRzS82sFAUFkZaALCwpdmZxRbriyTmP41y2m0U86GHPFl3rtnydA+GXxNdMjVsh/n5h13aGJasrElJaueL6y8b6rYrzyKn8SPUGIlCnVfpJoN6Lowvzo+pRf+25qy06n4c2wdarm9ix6x872QUgpk/L18lVTk5VPKHXrNq3Kk3/3q/HSbNeSAMN8/PO5qT9Z1sLswt7BywBwe62TZtKWQmHi7Y1AxpBiwps82bJ/WGLL/IOwswWjshqnT/asKiLk+MnQrCW0Unu9uZiZY2Dpj3TPnn3U2nZ8WnVgjQDneEjnL1276sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by CO1PR11MB4867.namprd11.prod.outlook.com (2603:10b6:303:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Sat, 4 Feb
 2023 19:19:46 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::fbab:ba2:a07f:55cb]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::fbab:ba2:a07f:55cb%9]) with mapi id 15.20.6064.032; Sat, 4 Feb 2023
 19:19:46 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "rajat.khandelwal@linux.intel.com" <rajat.khandelwal@linux.intel.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>
CC:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
Thread-Topic: [PATCH v4] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
Thread-Index: AQHZOMACjUyTtgCxq0yRuAevSO2Q8K6/KcYA
Date:   Sat, 4 Feb 2023 19:19:45 +0000
Message-ID: <75308e1b2e0406118b1012e271c622b2f02c119e.camel@intel.com>
References: <20230205174418.1927876-1-rajat.khandelwal@linux.intel.com>
In-Reply-To: <20230205174418.1927876-1-rajat.khandelwal@linux.intel.com>
Reply-To: "Box, David E" <david.e.box@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4522:EE_|CO1PR11MB4867:EE_
x-ms-office365-filtering-correlation-id: a150e9c8-2300-4342-d845-08db06e4c6b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RveSPzH74Yh1kpfuVgSh8kNcSvdkZFLjmH7a6dTTbevpJuj5OIW+zXBei+KpOsuF+mzqx6GJdPRdd/XQ/XFcGR9X71zCQ3EfAfmqGC/B0grP9ukSz+oGTcwm92xICANUWq7s/2p7ATYZNeg0uUGQS69smAVvZ9TvGHrvYqBhwEv6UcxikkRBzkMQ1FUp/u3qNvbH6Ork2jjDgqqENdBKeZ96WBqcQqnhEChDQiwQqAzJKUXq9CfhFz2ooGhapZQwq1WV+OE97TJ+zighblhMQ7aS66yy69B9R4aQqggmvXusvD2isB0uZe3SaFq0oxeSuJGG9bXmQk2Mk2xrFCX6XT/PJL84u0zICV0v5PRK14Jg5X5l6bg8Z07NIhLT+SPoqnoCDiz+mh+ehbN99V8BiSnCcNahWW6icgd9OKjIxT59LjayWV3FTsHPm7y9Hyn8OB6EqrW9M/WS/+c2u82xQxfSJ+cp4JZu2/dCJ9RP1uDhZxaEMWv8j2rMD2oZSRVoPifz1BZWCjFSPPeQnVB/Hfq5CRkOdQahx2/b+PZ4aRobp2wO9VBOZuj0nHbIy3aXi3sOV7xFHjeh5ckyyeX35K9UqZKR7AxLs3IsoodmeG7KX4IzgeH81e2ZmssMkhhS8h5+35HdG4cJCbEDgMbQVs2HmB650U+9yEZGina5X/fkNs+M5fDEM0zERqQXLF+j5Hqkq+34RWV08yQX4dcFRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199018)(66899018)(316002)(91956017)(66556008)(8676002)(110136005)(66946007)(54906003)(4326008)(5660300002)(66446008)(76116006)(41300700001)(8936002)(66476007)(36756003)(82960400001)(38070700005)(86362001)(38100700002)(122000001)(64756008)(6512007)(6506007)(26005)(186003)(71200400001)(2906002)(83380400001)(3450700001)(2616005)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlBHbFdRY1lqenZjQ2lWY2tEVlcxMXJlZ3NIVG5ZblF5UWpmVUFqSGs4VzVx?=
 =?utf-8?B?UDk2QnkxWld4Zm9WV09BSXdRbjRCS3pPQ245clpkQkdIVUVjNGw1T1AvSCtN?=
 =?utf-8?B?S051YnpBUjdSUEJwTEhic0hBMkNldU5yUGlITU1nMWtoRUJtVmNsaGltUVRE?=
 =?utf-8?B?SUY4UjNiTm93RzdGQ2xLUXNjVzkzdzNvNml0dm45WFl3VDBkU011a0UrY05w?=
 =?utf-8?B?bTJrbmVtalVpS2ZqNGRBeHd3OUVuZE1UMFlpWGlMa2JGd05IUWpDbGd2L0hr?=
 =?utf-8?B?WE4ycDlNZWxiZzRlc0NiUHEvbkhmV0NRbTN3SFpHSEtrb0xLdWtUTmRJVE9y?=
 =?utf-8?B?M2p4ejRFNldoSTlXU2t2Q3ZCVGFyeGJnZlpQVGFQUXQ1WEJmMjRoRDlHUFpH?=
 =?utf-8?B?c0dHME44elo2K2hJN2RpeDFodVQ1Ykl1bVB0SmEzMmF3aVVEZ21YNFVMZmdw?=
 =?utf-8?B?dW9malFTVFBiTkNzc0pvTVZzdEdDNUh1UEp2NUh0VDhqWlhxTlN5TlAwMTRG?=
 =?utf-8?B?SElrMmNPbm4zeWh1LzdyN09HdkRLVEw5ZzJ1MVB0VUJ3Vno3WWc4TTFqVWJK?=
 =?utf-8?B?ckg2RmRZaDZYdG5YeE1xclh1elhnbE4rNUExZS9sVUYvdDRWTmNta0Fwdlh2?=
 =?utf-8?B?M1Yzd0lydmdHNTZUZkdhZVd2enRyZUFuNE1JRlBJSWRwWnZHbkt5Wkhsby80?=
 =?utf-8?B?N2c3UUhYR3cxbjA5WUtjblFwSUFmMjBqTnBJKzF5VzViNkpYZTYrZTFqUjQ4?=
 =?utf-8?B?ZWhsR1pGaHVkTTAxdjhtd1JFTlZKSGZiYnQzR0JtSjdHZ3VTUnd0RFNobDZz?=
 =?utf-8?B?RWljQXZOcGdCNHppWURXZTBaMEg4WnNKY2Z4WW90bEdLWE9MT0thQ2NxdFVs?=
 =?utf-8?B?THhSWTM0UXhReUlnbnIvRFJNTkEwR3RjcWFNZGZGdVBmT04zUXl5ODFUd3pM?=
 =?utf-8?B?TXUybXVTN1B2aXl0QitQRTVmOEM0azhTL05Ec09QMm9JekFlMUl5clpNeVRa?=
 =?utf-8?B?b2x1K0xBZ2R1NXFsUkhtcmlxWUR5WEJvYTJUdko0YjlaRHBzSFFOT3lFNU04?=
 =?utf-8?B?TGRZMEovN1JKOTM3RVdsM0dYWnVNU2lHOXpVODVuUUhQVEUwN1lOZkhRVDVR?=
 =?utf-8?B?QnhPeHZMWnlTdmlZdWRYTGtGVDZRazJ3dTlGNjJlbXAxSEVYODQycWVZU3c0?=
 =?utf-8?B?ZXZlV0ZRaEcxMTJNdHcyYVJTbGN0NUtUQURjS1NVWGppNTRzY0VvMUlRQ0ZI?=
 =?utf-8?B?SlNjK1J1UjRRdDYrN25KbjVaUG1idlR2NnFyaWhaZC9GcERaYUpYeEJCV2ZK?=
 =?utf-8?B?Mk9NNmo3TXhYMVRtNkYvbUlhSVlQRVJoelNoMy9HaENiNU5mS0xFandiVndz?=
 =?utf-8?B?UDJXRTJVNCtaMWsrT0hRamZkbk56ZU9zaWtjZ3FzYlRkakJXRDM4c1pWRHI4?=
 =?utf-8?B?TnIzdnkrcVBRZnRlamRkaTY5RXpyK3JCTnlSUFRxRzFkR0pqNTlGcit5U1Fu?=
 =?utf-8?B?RENGY3NVNnJTY1ByZlp6MFE2YXhBUTFmYktYV3ErdEN4dVNjT1R4d2s4OEsx?=
 =?utf-8?B?RkVzc1FSemJpR24yeWRxWDJCQ2ZxWGc0SE5xUFZiQmRkVFVQK1g4NU9SLzc0?=
 =?utf-8?B?TDlGNlZnZXBKVHZ1MHJxOGtjMXFGNFo0VlloMXJmR2x2aHByckR5ekgwTjlo?=
 =?utf-8?B?RVM0aUkwb1VXemxSK3N2MDArN3F4bDZ6SkxUZ2c3RXFCamtyRnBVY0hnY0Ey?=
 =?utf-8?B?VmdYRlpTQ05KY0xEYkNTVDY5WkhtMURDNXBaNHQ2Qkw1WUJVeExUWWJubmdk?=
 =?utf-8?B?QnFnTHdDcUtxM1FQWWZtVm1ranpZVUUzem16R0hOWk5QUHd4MkdYa3ptWitY?=
 =?utf-8?B?TzR6RGpVMlNYdWxjUG1xVm9GT2xVMGF5VDRSR29QeHFoK0xXaVl3R090WGFu?=
 =?utf-8?B?ckRYUEgrYWJFZ01oaThUWGNPWUlDbnhkTUdncUxUL3Y0K2R3L0EvenFHZHh6?=
 =?utf-8?B?NVdWZUdabnJFWS9vam1vSVVVbUQ5OS93Q1RMdS9QQkpqMVhqdFhiRWpDN3lR?=
 =?utf-8?B?ZTFaTjhSaEV3MmtGQTlycGpETTV3UHA2U1J6ZFRydVc0cENONE03UlBaNmFI?=
 =?utf-8?B?NEx4RVhFVHVCRjVmTFlyMEsrb0hSRGlQK2RKZ0Q3K3A1b1JBTTB4MnlxNkx6?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63B1ACB940EF8A43A4003D5BF0B6374E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a150e9c8-2300-4342-d845-08db06e4c6b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2023 19:19:45.8442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9B0CfNHK4rcjKz1wdqC2lpB48hUeLTKivzKL+a+z4OrCaBcNlXhd1ortdPFHNDxlsWZYzFeyaQ7BBBIrPoMq8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4867
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFqYXQsCgpPbiBTdW4sIDIwMjMtMDItMDUgYXQgMjM6MTQgKzA1MzAsIFJhamF0IEtoYW5k
ZWx3YWwgd3JvdGU6Cj4gQ3VycmVudGx5LCAnbHRyX2lnbm9yZScgc3lzZnMgYXR0cmlidXRlLCB3
aGVuIHJlYWQsIHJldHVybnMgbm90aGluZywgZXZlbgo+IGlmIHRoZXJlIGFyZSBjb21wb25lbnRz
IHdob3NlIExUUiB2YWx1ZXMgaGF2ZSBiZWVuIGlnbm9yZWQuCj4gCj4gVGhpcyBwYXRjaCBhZGRz
IHRoZSBmZWF0dXJlIHRvIHByaW50IG91dCBzdWNoIGNvbXBvbmVudHMsIGlmIHRoZXkgZXhpc3Qu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogUmFqYXQgS2hhbmRlbHdhbCA8cmFqYXQua2hhbmRlbHdhbEBs
aW51eC5pbnRlbC5jb20+Cj4gLS0tCj4gCj4gdjQ6IE11dGV4IHVubG9jayBkdXJpbmcgZXJyb3Ig
Y29uZGl0aW9ucwo+IAo+IHYzOiBJbmNvcnBvcmF0ZWQgYSBtdXRleCBsb2NrIGZvciBhY2Nlc3Np
bmcgJ2x0cl9pZ25vcmVfbGlzdCcKPiAKPiB2Mjoga21hbGxvYyAtPiBkZXZtX2ttYWxsb2MKPiAK
PiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMgfCA1OSArKysrKysrKysr
KysrKysrKysrKysrLS0tLS0KPiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3Jl
LmggfMKgIDIgKy0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKSwgMTIgZGVs
ZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3Bt
Yy9jb3JlLmMKPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMKPiBpbmRl
eCAzYTE1ZDMyZDc2NDQuLmY5ZDRiMjg2NWIwMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3BsYXRm
b3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5jCj4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50
ZWwvcG1jL2NvcmUuYwo+IEBAIC01Myw2ICs1MywxNyBAQCBjb25zdCBzdHJ1Y3QgcG1jX2JpdF9t
YXAgbXNyX21hcFtdID0gewo+IMKgwqDCoMKgwqDCoMKgwqB7fQo+IMKgfTsKPiDCoAo+ICsvKiBN
dXR1YWwgZXhjbHVzaW9uIHRvIGFjY2VzcyB0aGUgbGlzdCBvZiBMVFItaWdub3JlZCBjb21wb25l
bnRzICovCj4gK3N0YXRpYyBERUZJTkVfTVVURVgobHRyX2VudHJ5X211dGV4KTsKPiArCj4gK3N0
cnVjdCBsdHJfZW50cnkgewo+ICvCoMKgwqDCoMKgwqDCoHUzMiBjb21wX2luZGV4Owo+ICvCoMKg
wqDCoMKgwqDCoGNvbnN0IGNoYXIgKmNvbXBfbmFtZTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
bGlzdF9oZWFkIG5vZGU7Cj4gK307Cj4gKwo+ICtzdGF0aWMgTElTVF9IRUFEKGx0cl9pZ25vcmVf
bGlzdCk7Cj4gKwo+IMKgc3RhdGljIGlubGluZSB1MzIgcG1jX2NvcmVfcmVnX3JlYWQoc3RydWN0
IHBtY19kZXYgKnBtY2RldiwgaW50IHJlZ19vZmZzZXQpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDC
oHJldHVybiByZWFkbChwbWNkZXYtPnJlZ2Jhc2UgKyByZWdfb2Zmc2V0KTsKPiBAQCAtNDM1LDI3
ICs0NDYsMTggQEAgc3RhdGljIGludCBwbWNfY29yZV9wbGxfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUg
KnMsIHZvaWQKPiAqdW51c2VkKQo+IMKgfQo+IMKgREVGSU5FX1NIT1dfQVRUUklCVVRFKHBtY19j
b3JlX3BsbCk7Cj4gwqAKPiAtaW50IHBtY19jb3JlX3NlbmRfbHRyX2lnbm9yZShzdHJ1Y3QgcG1j
X2RldiAqcG1jZGV2LCB1MzIgdmFsdWUpCj4gK3ZvaWQgcG1jX2NvcmVfc2VuZF9sdHJfaWdub3Jl
KHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYsIHUzMiB2YWx1ZSkKPiDCoHsKPiDCoMKgwqDCoMKgwqDC
oMKgY29uc3Qgc3RydWN0IHBtY19yZWdfbWFwICptYXAgPSBwbWNkZXYtPm1hcDsKPiDCoMKgwqDC
oMKgwqDCoMKgdTMyIHJlZzsKPiAtwqDCoMKgwqDCoMKgwqBpbnQgZXJyID0gMDsKPiDCoAo+IMKg
wqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZwbWNkZXYtPmxvY2spOwo+IMKgCj4gLcKgwqDCoMKg
wqDCoMKgaWYgKHZhbHVlID4gbWFwLT5sdHJfaWdub3JlX21heCkgewo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBlcnIgPSAtRUlOVkFMOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBnb3RvIG91dF91bmxvY2s7Cj4gLcKgwqDCoMKgwqDCoMKgfQo+IC0KPiDCoMKgwqDC
oMKgwqDCoMKgcmVnID0gcG1jX2NvcmVfcmVnX3JlYWQocG1jZGV2LCBtYXAtPmx0cl9pZ25vcmVf
b2Zmc2V0KTsKPiDCoMKgwqDCoMKgwqDCoMKgcmVnIHw9IEJJVCh2YWx1ZSk7Cj4gwqDCoMKgwqDC
oMKgwqDCoHBtY19jb3JlX3JlZ193cml0ZShwbWNkZXYsIG1hcC0+bHRyX2lnbm9yZV9vZmZzZXQs
IHJlZyk7Cj4gwqAKPiAtb3V0X3VubG9jazoKPiDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2Nr
KCZwbWNkZXYtPmxvY2spOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gZXJyOwo+IMKgfQo+
IMKgCj4gwqBzdGF0aWMgc3NpemVfdCBwbWNfY29yZV9sdHJfaWdub3JlX3dyaXRlKHN0cnVjdCBm
aWxlICpmaWxlLAo+IEBAIC00NjQsNiArNDY2LDggQEAgc3RhdGljIHNzaXplX3QgcG1jX2NvcmVf
bHRyX2lnbm9yZV93cml0ZShzdHJ1Y3QgZmlsZQo+ICpmaWxlLAo+IMKgewo+IMKgwqDCoMKgwqDC
oMKgwqBzdHJ1Y3Qgc2VxX2ZpbGUgKnMgPSBmaWxlLT5wcml2YXRlX2RhdGE7Cj4gwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYgPSBzLT5wcml2YXRlOwo+ICvCoMKgwqDCoMKg
wqDCoGNvbnN0IHN0cnVjdCBwbWNfcmVnX21hcCAqbWFwID0gcG1jZGV2LT5tYXA7Cj4gK8KgwqDC
oMKgwqDCoMKgc3RydWN0IGx0cl9lbnRyeSAqZW50cnk7Cj4gwqDCoMKgwqDCoMKgwqDCoHUzMiBi
dWZfc2l6ZSwgdmFsdWU7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBlcnI7Cj4gwqAKPiBAQCAtNDcz
LDEzICs0NzcsNDYgQEAgc3RhdGljIHNzaXplX3QgcG1jX2NvcmVfbHRyX2lnbm9yZV93cml0ZShz
dHJ1Y3QgZmlsZQo+ICpmaWxlLAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGVycjsKPiDCoAo+IC3CoMKgwqDCoMKgwqDC
oGVyciA9IHBtY19jb3JlX3NlbmRfbHRyX2lnbm9yZShwbWNkZXYsIHZhbHVlKTsKPiArwqDCoMKg
wqDCoMKgwqBpZiAodmFsdWUgPiBtYXAtPmx0cl9pZ25vcmVfbWF4KQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgbXV0
ZXhfbG9jaygmbHRyX2VudHJ5X211dGV4KTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgbGlzdF9mb3Jf
ZWFjaF9lbnRyeShlbnRyeSwgJmx0cl9pZ25vcmVfbGlzdCwgbm9kZSkgewo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZW50cnktPmNvbXBfaW5kZXggPT0gdmFsdWUpIHsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9IC1FRVhJ
U1Q7CgpEbyB3ZSBuZWVkIHRvIHJldHVybiBhbiBlcnJvciBoZXJlPyBXZSBkb24ndCBvZmZlciBh
IHdheSB0byB1bmRvIHRoZSBpZ25vcmUgYW5kCnJld3JpdGluZyBpdCBkb2Vzbid0IGh1cnQgYW55
dGhpbmcuIEknbSBva2F5IHdpdGggaWdub3JpbmcgdGhpcy4KCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF91bmxvY2s7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDC
oMKgwqDCoGVudHJ5ID0gZGV2bV9rbWFsbG9jKCZwbWNkZXYtPnBkZXYtPmRldiwgc2l6ZW9mKCpl
bnRyeSksIEdGUF9LRVJORUwpOwo+ICvCoMKgwqDCoMKgwqDCoGlmICghZW50cnkpIHsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gLUVOT01FTTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfdW5sb2NrOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiAr
Cj4gK8KgwqDCoMKgwqDCoMKgZW50cnktPmNvbXBfbmFtZSA9IG1hcC0+bHRyX3Nob3dfc3RzW3Zh
bHVlXS5uYW1lOwo+ICvCoMKgwqDCoMKgwqDCoGVudHJ5LT5jb21wX2luZGV4ID0gdmFsdWU7Cj4g
K8KgwqDCoMKgwqDCoMKgbGlzdF9hZGRfdGFpbCgmZW50cnktPm5vZGUsICZsdHJfaWdub3JlX2xp
c3QpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBwbWNfY29yZV9zZW5kX2x0cl9pZ25vcmUocG1jZGV2
LCB2YWx1ZSk7Cj4gKwo+ICtvdXRfdW5sb2NrOgo+ICvCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9j
aygmbHRyX2VudHJ5X211dGV4KTsKCllvdSBjYW4gYWxsb2NhdGUgeW91ciBlbnRyeSBhbmQgZG8g
dGhlIGFzc2lnbm1lbnQgYmVmb3JlIHlvdSB0YWtlIHRoZSBsaXN0IGxvY2suCklmIHRoZSBhbGxv
Y2F0aW9uIGZhaWxzLCByZXR1cm4gaW1tZWRpYXRlbHkgd2l0aG91dCBhIGdvdG8uCgpZb3UgY2Fu
IGFsc28gbW92ZSBwbWNfY29yZV9zZW5kX2x0cl9pZ25vcmUoKSBhZnRlciB0aGUgdW5sb2NrLgoK
RGF2aWQKCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGVyciA9PSAwID8gY291bnQgOiBl
cnI7Cj4gwqB9Cj4gwqAKPiDCoHN0YXRpYyBpbnQgcG1jX2NvcmVfbHRyX2lnbm9yZV9zaG93KHN0
cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqdW51c2VkKQo+IMKgewo+ICvCoMKgwqDCoMKgwqDCoHN0
cnVjdCBsdHJfZW50cnkgKmVudHJ5Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZs
dHJfZW50cnlfbXV0ZXgpOwo+ICvCoMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnkoZW50
cnksICZsdHJfaWdub3JlX2xpc3QsIG5vZGUpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgc2VxX3ByaW50ZihzLCAiJXNcbiIsIGVudHJ5LT5jb21wX25hbWUpOwo+ICvCoMKgwqDC
oMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJmx0cl9lbnRyeV9tdXRleCk7
Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoH0KPiDCoAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5oCj4gYi9kcml2ZXJzL3BsYXRm
b3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5oCj4gaW5kZXggODEwMjA0ZDc1OGFiLi5kYTM1YjBmY2Jl
NmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuaAo+
ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmgKPiBAQCAtMzk2LDcg
KzM5Niw3IEBAIGV4dGVybiBjb25zdCBzdHJ1Y3QgcG1jX3JlZ19tYXAgYWRsX3JlZ19tYXA7Cj4g
wqBleHRlcm4gY29uc3Qgc3RydWN0IHBtY19yZWdfbWFwIG10bF9yZWdfbWFwOwo+IMKgCj4gwqBl
eHRlcm4gdm9pZCBwbWNfY29yZV9nZXRfdGdsX2xwbV9yZXFzKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpOwo+IC1leHRlcm4gaW50IHBtY19jb3JlX3NlbmRfbHRyX2lnbm9yZShzdHJ1Y3Qg
cG1jX2RldiAqcG1jZGV2LCB1MzIgdmFsdWUpOwo+ICtleHRlcm4gdm9pZCBwbWNfY29yZV9zZW5k
X2x0cl9pZ25vcmUoc3RydWN0IHBtY19kZXYgKnBtY2RldiwgdTMyIHZhbHVlKTsKPiDCoAo+IMKg
dm9pZCBzcHRfY29yZV9pbml0KHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYpOwo+IMKgdm9pZCBjbnBf
Y29yZV9pbml0KHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYpOwo+IC0tIAo+IDIuMzQuMQo+IAoK
