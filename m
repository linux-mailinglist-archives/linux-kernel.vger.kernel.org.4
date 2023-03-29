Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B189F6CDBB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjC2ONM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjC2OMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:12:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732E1527C;
        Wed, 29 Mar 2023 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680099109; x=1711635109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WiPTk7KI563Y68xszLLJrx2aUu95QWcyWfl1dvUf8II=;
  b=Uue3KgfYTR+ZZxexyOBHFvV3ufTHiH66uPfEuqcv9ozYDqn+GyHnBUi1
   edbgcRWdYJxxX+T0wAOELHj7k4bWdvV3Gt02K55RphPLmpPwA3efQinlq
   XG56YDDwiARryYSIK5YerMUTy7AvOcpiqiDvjKZc0PlsaN6G4wiwNvrO9
   M/0h3FL1m33LFRWhWYiKXyFoWgvtG7c9wed9+WgDTxEtbKdwK4faQB7CZ
   N9GQpDNZ58a98OO1q4SzOHKkxC7t0a0a+Wfg9zbZT69uXwUCG+vPhddmU
   mkC1kgLh+f5+ylAcm/ijDZgLDOHVwIA8weo9Ra7eOE/1uI72LTmunphbX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339612644"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="339612644"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="808226008"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="808226008"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2023 07:11:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 07:11:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 07:11:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 07:11:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrY5wzhFRqHhl4wS61GU8YRUyqJDLSb/HcMgHH9ahgXUXHfHqKM1XeMEidv+Ch1GAHgx+TwYDVF+v3yILb2RRqlymSHDRbXWKEko2hsBTI0RNSQcRwI4TrQZzoU38p3dbaCIX6HSbvJtNzAz7tbv8RpGdHD0qzY1wS3p4WQDzgiyn19yJfwAF5KHPmkrxRKsjLxwtb0aGMKd/cy9P9rlM23jgI2XaWMTxiJv9JtdjpdleBVYxWVRNR3xo/sFpKyugl9cXshwDZMY4tchzNU5lWjmbn1TrY87u1UwcRI+h0ZCqUk9zLgrZed1iKzHi42h1oz1AEamJpGNaL3pQgrFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiPTk7KI563Y68xszLLJrx2aUu95QWcyWfl1dvUf8II=;
 b=oJ8F+RzAZkDRwCchTSpfxyLZyLkaBifBPIszzxNkpE25UyGosmy2YT/TyRzYk/dKpJVuapG/5mf//SkXi/BU1JY51zqRKgx1RY/J4vSoK+aLD79OJrA8Cwd0NRkJMilUAz9Qky/WcjCIzTL4rmaRTkAT3hjYHzir+7xHeUxbbHSjmZmVFLSQu5wmH2d+8DqcecX/Xj7lCxscPGmR7RukssPoMNUUfjcg1icMf0WBqk4bcxlkizG+Vrmhv/90nVfZ/VMUzB6lF/4JgXK5qz6C+qgNKghRs+nls0Y/Mq/RzA/V6PPbqjYp3W0Pmn0Fv0n2uwLZGxzQatEFwS8Ji/7Y4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by MN6PR11MB8193.namprd11.prod.outlook.com (2603:10b6:208:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 14:11:36 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 14:11:36 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "peter.ganzhorn@gmail.com" <peter.ganzhorn@gmail.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] coretemp: Fix spamming of ring buffer
Thread-Topic: [PATCH 0/4] coretemp: Fix spamming of ring buffer
Thread-Index: AQHZYbU+LMzHZcsD1EaUSEWqRoX2la8RHfUAgACXvACAABegAA==
Date:   Wed, 29 Mar 2023 14:11:36 +0000
Message-ID: <51b2d540c174690a8e460ecba53b0195c4b01294.camel@intel.com>
References: <CA+3fRbFzq38sQomFM7xJt-UoeLv_ZZbQ2uaHZ+8J_5ntweJ7TA@mail.gmail.com>
         <7e821f80b7700fcf1fb26f40bde8397f0e5e6d7e.camel@intel.com>
         <aeed703c-5dbb-4a6f-a4d7-3c6a55d99e9e@roeck-us.net>
In-Reply-To: <aeed703c-5dbb-4a6f-a4d7-3c6a55d99e9e@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|MN6PR11MB8193:EE_
x-ms-office365-filtering-correlation-id: bbc632f7-bfd5-4327-d077-08db305f81cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vSvmYsaJ3+LrnIU/QdanNSZM5Dt9cwnZSs/9Hhc3qjtog2gWaMnnp5zyFkJKbrxmq2WztK7nvB9Pec9ZtmJF1X5cgMDFJahZRiK/FXdLjyNQz3E/bWlzPfdnGvslYv5QlwpJ2Mu+pu4sgJBxq0uQAAsudT7aYZwbuCSBqwFlP2/Vfteppss29fXdNpDEhCLqQfT1M6OR80qWJV2oLETJxYGP0CL+x/KQ/KCfRG7KJZUjcEsxvj0Obuo4sWG1pc3HYWHorTieWPxQ6ltGcoUUUHqatVPUwqP+kxJj+7H7FJpQphvw19eue7h8MWlBrcNCmghImnhcIVuF0AVohQkcPZIjkaIlCLngvBF66E8HsFnbq1UmEcmmrtffo26H/1VBLlyWL8lVcrlE2jBXgO80XRVAJFcFh5sDiDLBjwJFB80zgAyWzHolFjaff/gMsVxVEm/lnkFqL/0b9UGehhuw5A4FrmraUlyEJqo/PXcsX7uNYpM9YsIVYgakyWcIyB2nYfmAfbcB3P88BvojNRwvjAuNtnf4QYXWz9WAoBsrIrUJTXgC4p8iHt8htavJvgU1YYBIpA/SyC2bbd3EUx46jUSLOxuWVdg4m949r47DoJJBpWRkFV2RoIkVRhJoe3hP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(6506007)(26005)(6512007)(83380400001)(53546011)(86362001)(8936002)(38070700005)(2616005)(186003)(82960400001)(71200400001)(2906002)(38100700002)(5660300002)(91956017)(478600001)(4326008)(122000001)(66476007)(66946007)(36756003)(316002)(8676002)(76116006)(64756008)(66446008)(41300700001)(6486002)(66556008)(54906003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b29sN0JzUFp1MTJnQkZwdTdpcEtSR25TSkgwTkJ2R1A5azYraHgydm5ESVJF?=
 =?utf-8?B?WnNHNU84VXYzaFVtR2RXQ0tmb2FnOXBuZThNZVZPdVJlcmE1TVQxV0hPRmJM?=
 =?utf-8?B?WWRTbXo5Rmx0QnF0MEd1ZVpKUVo2UUI1WGMrUjY2Qm1kc0p2Z3R5Z1A2M0N5?=
 =?utf-8?B?S3R6bWRDV0VkLzJuMmZpNUFySkdqZ0t5SHVZL2Y2N09lWkQzRUFTY0k1NTVM?=
 =?utf-8?B?TlN2ekpUeEZEVythMEJqcFVOOWh2aGFaS09xRzhkVDZRRk92dTFXQmc4MGVW?=
 =?utf-8?B?S1I2ems1NmlFaFB3NUZkdENyeU5YYnBuTUF1OXI4RDFSMUh5NGZoWjN6Q3lw?=
 =?utf-8?B?SzhDOGI1UUZscHlMdmRkL0t4ZjB2ekRZUUdON3pTWXNXbXB5RnJHYTJFTGxN?=
 =?utf-8?B?MGdNcmg4Yk5BTU5PUEt2eTZBYi9LS1ZKd3hmUGpkVGRlNkV0UU9BelFCSjF2?=
 =?utf-8?B?RWRCK0lDNHNFN1Zkbm1sQVBuR2h0SXE4bVNIbUJvU1AzZDhsRXlBa0xwMlM4?=
 =?utf-8?B?eTVIL3NoQzlpTXVKYVg3ZWJvY2RDMld0RUwxTTFWUFM3Y0FpSm1WRUtxR0Qz?=
 =?utf-8?B?cVhyOW1Cd29tb1loZDZBbHBmOXIzV1dlZEV5V2hzQUJrTXRKVE1qSnExU0ZZ?=
 =?utf-8?B?alRuU1o1R0o2NmRaRGF1am1lMlpzb3p5SlRrUTRudTIvbTBrdmZzK1dHT2Nq?=
 =?utf-8?B?Yy9pNlh5My9KajFQaHV4dzFaWWtTL2Y5QVJBOXN6RGdZUVlvclJrbmlySlZV?=
 =?utf-8?B?ajFDVE9NTCsxK2ZkNDd5cjVzakFMQVlFV0dyckhwamlpR2hPOGpIQjRUbHRm?=
 =?utf-8?B?eFZZajZjeEVpNXNoaUtTUy9rTHBGSGxGZTNBZGF5K0RsSkNYZG5qbHdOd1hB?=
 =?utf-8?B?SldpbThDUG1UbGtDamsydVNMTXVWYjlqcjJzSHNJd0l3bEJPaHhGRGdyN21i?=
 =?utf-8?B?MzAxYWRRUjJYYlVLajZpMFlDMWZDdzNnUGh6ZXNZaWd3TElaVlJMb0hzY3dC?=
 =?utf-8?B?OXd1d3k0dFdlalBSRndRNDZyTjRsMGxNRUVzVVByd0xCZDQvOGRwdmdUT2VP?=
 =?utf-8?B?SGpQalE2Q0kwVk1uSGdHblBUNFJTSlVvbjNsM1BZZ2tpTktCZXlDd2doa1Jq?=
 =?utf-8?B?K1hnNmdKS1ZNU1d6bVBXQXhEUlF3NUd6M05uWUlVbk8zZWQwOUdIZUY0b2JX?=
 =?utf-8?B?M0RlQ0wzRUlZNDEzVXBJNGFKOU1PS3ZPSWo5dTF2RW5WdWVzR2I4TjVkNFBE?=
 =?utf-8?B?SkdTeTJVZ1ZIdndVWU5aMzF1L1dqTjRsdjZtS1k5ZVpJNndPTExSSjROWVJF?=
 =?utf-8?B?elNlL0ZhNHJhQmFuMnNCWEIvd0l5a0tIRG1DL0NJeXRpUXNoTXlna3ZWLytu?=
 =?utf-8?B?WXFkSVlmdmx3dnFiMnBLYlU2YXN2M25PYmxxZFV0OXU2eFovNFgvTDNuaE93?=
 =?utf-8?B?V3VaMzhub0piblY2UkhqMWZxamsvNnFMbjZjMW9yZEJLT2NCTFpvYU9Xb2pW?=
 =?utf-8?B?MHAxNURiS2hDU1FQZnhmbWdwamFYK0FCci9kaU84V3lyTGZ2S1FPNkVZR01G?=
 =?utf-8?B?T0pTL0JSSUF3QkdsRGxmRkltV0ErdEI3bm5nSVBhZmxrUFJPek5leElEcHNH?=
 =?utf-8?B?c1hEVDVZbnFCNEwyejJmRjVwbDhBS3ppUG0xdWl6Wi9wZllERS9XTktjYjRO?=
 =?utf-8?B?c0NBVS9mUjk0bjJRdnVMV1UzREd1VE40emZrSmlJS3M4WWY0OTVuWFhVWmI2?=
 =?utf-8?B?SFZjUHdnbFlTdUQ3eDRNSzVRZjIrQzBMRGNZdmFNdmFxckltZ3NZMHliZGU0?=
 =?utf-8?B?UHJKSE9tbkF3N0RkWlU1VmRNNmdJZ3hqbDBrUHF4YkpKUE1ldVAvRWlGeSsx?=
 =?utf-8?B?SytwNTNKZCsrZFBGM1diNWpTTVIvMVpxQUVOZ1Jab1ZVeXU3QW1BaTZPK1NG?=
 =?utf-8?B?MXc1Mlk4UmFTRzVzTFJEM0Z2dHBzK0VFYlVXeG1Sd2E2aDY5MTRqaUs0ZGZ6?=
 =?utf-8?B?THpCaEFkZ3VBMVJUYXRqTnFhRDlGeFV1aUxGSmY2cHQ4QjQzUEowUUhCVnlH?=
 =?utf-8?B?UmIyanRZTm8xeXp6TzNiMjRKc2FEWTQ3bHgwMUpXZW0yMW9oSkdVZnd3aXow?=
 =?utf-8?Q?Exu1LGpwPlwnc+ZiK0z6XWW3Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61B54872A1DD91438B286BAC0CA461A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc632f7-bfd5-4327-d077-08db305f81cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 14:11:36.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4JRU/iPCtZy4UQzfR3vaPaFY1A7gOacQdlOgz0fhBHgkBpKGdhFopGviwvev0lZMOwYnTvWsQnEzdfeM4gaeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8193
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDA1OjQ3IC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiBXZWQsIE1hciAyOSwgMjAyMyBhdCAwMzo0Mzo1OEFNICswMDAwLCBaaGFuZywgUnVpIHdy
b3RlOg0KPiA+IEhpLCBQZXRlciwNCj4gPiANCj4gPiBDQyB0aGUgbGlzdC4NCj4gPiANCj4gPiBP
biBUdWUsIDIwMjMtMDMtMjggYXQgMjI6MzcgKzAyMDAsIFBldGVyIEdhbnpob3JuIHdyb3RlOg0K
PiA+ID4gRGVhciBNci4gUnVpLA0KPiA+ID4gRGVhciBNci4gUm9lY2ssDQo+ID4gPiANCj4gPiA+
IHBsZWFzZSBjb25zaWRlciBhY2NlcHRpbmcgdGhlIGF0dGFjaGVkIHBhdGNoZXMgb3INCj4gPiA+
IG1vZGlmeWluZyB0aGUgY29yZXRlbXAgY29kZSB0byBzdG9wIHNwYW1taW5nIG15IHN5c2xvZy4N
Cj4gPiA+IEkgd291bGQgYXBwcmVjaWF0ZSBpdCB2ZXJ5IG11Y2ggaWYgeW91IGNhbiBhY2NlcHQg
dGhlIHBhdGNoZXMuDQo+ID4gPiANCj4gPiA+IGNvcmV0ZW1wOiBJbXByb3ZlIGR5bmFtaWMgY2hh
bmdlcyBvZiBUak1heA0KPiA+ID4gQWZ0ZXIgaW50cm9kdWN0aW9uIG9mIGR5bmFtaWMgVGpNYXgg
Y2hhbmdlcyBpbiBjb21taXQNCj4gPiA+IGMwYzY3Zjg3NjFjZWMxZmUzNmMyMWQ4NWIxYTU0MDBl
YTdhYzMwY2QNCj4gPiA+IG15IHN5c2xvZyBnZXRzIHNwYW1tZWQgd2l0aCAiVGpNYXggaXMgLi4u
IGRlZ3JlZXMgQyINCj4gPiA+IG1lc3NhZ2VzLg0KPiA+ID4gSWYgVGpNYXggaXMgc3ViamVjdCB0
byBjaGFuZ2UgYXQgYW55IHRpbWUsIGl0IHdvbid0IGJlDQo+ID4gPiBzZXQgaW4gdGRhdGEgYW55
bW9yZSBhbmQgcmUtcmVhZCBldmVyeSB0aW1lIGZyb20gTVNSLg0KPiA+ID4gVGhpcyBjYXVzZXMg
cXVpdGUgYSBsb3Qgb2YgZGV2X2RiZygpIG1lc3NhZ2VzIHRvIGJlIGlzc3VlZC4NCj4gPiA+IA0K
PiA+ID4gVGhlIGZvbGxvd2luZyBwYXRjaGVzIGNoYW5nZSB0aGUgY29kZSB0byByZWFkIFRqTWF4
DQo+ID4gPiBmcm9tIHRoZSBNU1JzIGludG8gdGRhdGEtPnRqbWF4IChhZ2FpbikgYnV0IGFsbG93
IGZvciBhDQo+ID4gPiBkeW5hbWljIHVwZGF0ZSBhdCBhbnkgdGltZSBhcyB3ZWxsLiAoUGF0Y2hl
cyAxIGFuZCAyKQ0KPiA+ID4gVGhpcyB3YXkgYSBtZXNzYWdlIHdpbGwgb25seSBiZSBpc3N1ZWQg
YWZ0ZXIgYWN0dWFsIGNoYW5nZXMuDQo+ID4gPiBBbHNvIEkgcmVwbGFjZWQgdGhlIGRldl9kYmco
KSB3aXRoIGRldl9ub3RpY2UgKFBhdGNoIDMpIGFuZA0KPiA+ID4gYWRkZWQgYSBhZGRpdGlvbmFs
IGRldl9ub3RpY2UgZm9yIHRoZSBjYXNlIHdoZXJlIFRqTWF4IGlzDQo+ID4gPiBzZXQgYmFzZWQg
b24gYXNzdW1wdGlvbnMuIChQYXRjaCA0KQ0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IElmIHlvdSBk
byBub3Qgd2FudCB0byBhY2NlcHQgbXkgcGF0Y2hlcywgcmVtb3ZpbmcgdGhlDQo+ID4gPiBkZXZf
ZGJnKCkgaW4gZ2V0X3RqbWF4KCkgd291bGQgYmUgdGhlIG1vc3Qgc2ltcGxlDQo+ID4gPiBzb2x1
dGlvbiBJIGd1ZXNzLg0KPiA+ID4gDQo+ID4gUGxlYXNlIGNoZWNrIGlmIGJlbG93IHBhdGNoIHNv
bHZlcyB5b3VyIHByb2JsZW0gb3Igbm90Lg0KPiA+IA0KPiA+IEZyb20gOTM3MGVlNTE2M2E4NWY2
NTIzMGI1MjIyZjFmNGRlY2U1OWNlMDc4YSBNb24gU2VwIDE3IDAwOjAwOjAwDQo+ID4gMjAwMQ0K
PiA+IEZyb206IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gPiBEYXRlOiBXZWQs
IDI5IE1hciAyMDIzIDExOjM1OjE4ICswODAwDQo+ID4gU3ViamVjdDogW1BBVENIXSBod21vbjog
KGNvcmV0ZW1wKSBBdm9pZCBkdXBsaWNhdGUgZGVidWcgbWVzc2FnZXMNCj4gPiANCj4gPiBBdm9p
ZCBkdXBsaWNhdGUgZGV2X2RiZyBtZXNzYWdlcyB3aGVuIHRqbWF4IHZhbHVlIHJldHJpZXZlZCBm
cm9tDQo+ID4gTVNSDQo+ID4gZG9lcyBub3QgY2hhbmdlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9od21vbi9jb3JldGVtcC5jIHwgNiArKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2h3bW9uL2NvcmV0ZW1wLmMgYi9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMNCj4gPiBpbmRleCAz
MGQ3N2Y0NTE5MzcuLjgwOTQ1Njk2N2I1MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2h3bW9u
L2NvcmV0ZW1wLmMNCj4gPiArKysgYi9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMNCj4gPiBAQCAt
MjY3LDYgKzI2Nyw3IEBAIHN0YXRpYyBpbnQgZ2V0X3RqbWF4KHN0cnVjdCB0ZW1wX2RhdGEgKnRk
YXRhLA0KPiA+IHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCWludCBlcnI7DQo+ID4gIAl1MzIg
ZWF4LCBlZHg7DQo+ID4gIAl1MzIgdmFsOw0KPiA+ICsJc3RhdGljIHUzMiB0am1heDsNCj4gDQo+
IFRoYXQgd291bGQgYXBwbHkgdG8gZXZlcnkgaW5zdGFuY2Ugb2YgdGhpcyBkcml2ZXIsIG1lYW5p
bmcgdG8gZXZlcnkNCj4gQ1BVIGNvcmUuIElzIHRoYXQgcmVhbGx5IGFwcHJvcHJpYXRlID8NCj4g
DQo+IEd1ZW50ZXINCj4gDQpHb29kIHBvaW50Lg0KDQpNU1JfSUEzMl9URU1QRVJBVFVSRV9UQVJH
RVQgaXMgcGFja2FnZSBzY29wZSwgYW5kIHRoZSBjYWNoZWQgdGptYXgNCnNob3VsZCBhbHNvIGJl
IHBhY2thZ2Ugc2NvcGUsIG9yIGVsc2UgdGhpcyBtZXNzYWdlIGlzIHNob3duIGZvciBlYWNoDQpj
cHUgd2hlbiB0am1heCBjaGFuZ2VzIGluIG9uZSBwYWNrYWdlLg0KDQpQcmV2aW91c2x5LCB0aGUg
bWVzc2FnZSBpcyBwcmludGVkIG9ubHkgb25jZSBkdXJpbmcgZHJpdmVyIHByb2JpbmcgdGltZQ0K
dGh1cyBJJ20gd29uZGVyaW5nIGhvdyB1c2VmdWwgdGhpcyBpcy4NCg0KTWF5YmUgd2UgY2FuIGp1
c3QgZGVsZXRlIGl0Pw0KDQp0aGFua3MsDQpydWkNCg==
