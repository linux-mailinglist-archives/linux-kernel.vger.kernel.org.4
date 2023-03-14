Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B186BA397
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCNXfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNXft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:35:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A51A243
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678836947; x=1710372947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=miwTXkRwEu/0naZoHpcZ/sW/zVIsm5mZZ1OtEn55qSc=;
  b=USJvTeVy0jIL4Xd8hH1Q0ni/EFf7GYz8gL1BnFcOl86BfotDyrfkCNcn
   Hg1RAfs0exMCx282IE5WLm5D2N+P7c2Knhrd7r2qMWOgouVH2Nors59i8
   hikGgXcBGgrLdlu+ZanBzWruNVot0Iqzp8eHsRbG2ZAfKvA2ZTgt0sV5C
   4Qhv9CGCcMTbkJJc/I9FGXWzvyROsAaEKfatIcgevOhQrZ29VEgTAQ6NC
   UA68p5J9HeYTKwzYTW0d8wXCPhwVFbFU+ENCMky79YerOOmomdQVBxOdQ
   CGVXIF412KwM9FPCaLprcLmF1sODRbkbH1eqMhiHGmPr2UOlxyH4T//Hl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="400150458"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="400150458"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 16:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="656549722"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="656549722"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2023 16:35:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 16:35:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 14 Mar 2023 16:35:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 14 Mar 2023 16:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3N0solxojAt+XoIHABmbHg1vYvTdRk4q9bhjvqR4wuJhi/DHpBqLXyk8KhTUVkWYw+Uwo8NF8od8tcAiwU/P1NI3ysWR9mA05KnnUtB9azN8S/Fqr6WS7VO4q3Iv84oE7BUfxIntNbHPgp82LjSsPZkpw9Cl1oAMaExRFIVkkNHNnpOIeago6ldU7fE5y2bhAT5E4YQeqTuxWOZvV6DZx0QIwZI3xfE3aqvsJZoA9mK/lmsV5UZULhgATOM+t5Qu7mnW3WWHZytpLAf83hJ9xZYdWOPpwI2nE85xBgECntl7HdfCmrX0ipIruzFAm4EPw4rW1bDFIzs+gyFt+kdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miwTXkRwEu/0naZoHpcZ/sW/zVIsm5mZZ1OtEn55qSc=;
 b=N0IIIq1VXiNd6YsUSwblqkADfzVSKqcI+1SDv+kvJBRQIspPfONSySUQ7tjekt5K7128rDNxtruVIUuSRLp+ykDm3eP8vhrXrTwDQRcFxuW5Da8QioSDXHI4/LQTMLeGorErzo4VWMDu4dKldvDH5kYFCtRkUoEmFIw/Hlf9TqH9N4uogw/DA6gN3Ao6PB6QvSYO15cJzgVTYJv2UL4DagntsxQ17NDO+pdY0a/Zfn68kySLk1IgGDaiazU96EHaeBefEFPNM4r+SiaHUzS8r9FYzcyflINlVAceY9XiH+LDpa//D2xyCjgy7su0jFb9Gk6cZfmql0w4imIL0z5qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH8PR11MB6657.namprd11.prod.outlook.com (2603:10b6:510:1c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 23:35:34 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 23:35:33 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "tarasmadan@google.com" <tarasmadan@google.com>,
        "bharata@amd.com" <bharata@amd.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv16 05/17] mm: Introduce untagged_addr_remote()
Thread-Topic: [PATCHv16 05/17] mm: Introduce untagged_addr_remote()
Thread-Index: AQHZVNWENxn9utRbo0a5msMIASZmbK768aoA
Date:   Tue, 14 Mar 2023 23:35:33 +0000
Message-ID: <3006f4d1b7ac3aef56e488dc6438972de1905a13.camel@intel.com>
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
         <20230312112612.31869-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230312112612.31869-6-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH8PR11MB6657:EE_
x-ms-office365-filtering-correlation-id: f8a02e3b-d5c8-4d70-19ef-08db24e4ce20
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6nQ5VzzvRT5hG/5f3EM2H0u8q5VIMOp33No5OUU93bTbwLIfQUfxUlMykhv7u/5RWx7eUIryRw1agxep/mwnak1YbXcwxrso+DRChTRmoa8n8cA//Z7rShLAQKa0RSK8Xe1UAXbEkQ8ZyhjXlbXrAQ+cVTWLhfH2J7i4KosUDOa/94LxR5fIGKinDwxaQTzQfOc+Zjk2l4UCFFEQ6EtEFhY+m9cKEiKmNd9FCKUskADGUyzHM7sISOYFnDrLkT1+SwNZFmA2oEgtVlncGPNbZRbfidRUsKSbu/ZlSRcX6WnuSQw6TB5p8CGgR+D8zDSI40Y3d+JjaSnYZUMSL3/8G+bdDFFPMqEaGaeJ+yqc5P78S2PEacpKkCqEnObtJzL+51LhMoKvOg9KgeTZC7GNLl9CS+FLwgcNYtz1g/X1+bd5pI/HlSaPVD6dp4/FVIOyi0YTzi9USSbwHkiyavtUCdSTPgLL6LXEZwSqWs9t/eFqJrtKPCN5VELi/wu/a9WZET8g6oJedlOrVbMhDCZR/W7F8TYa4tIZivNdqYL8TFEiY+mQIoDjBazsyg9R207K5wse0fmxWx/eeAj1BdgK0+BVjIZBcXwdsq/YsZuSmOY0urOMIu6y4dFdCsZg9+ZCLHQmxFiF75KGyle3eRf3NFm5DAw2KCl9amq8kgEU1n6J/L2YDhkUixZ910s4m7Ol4dvOLT0lwEVyhvm0nGPXPdbk1gqP4BEEaF5rbDLlOg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199018)(36756003)(316002)(110136005)(54906003)(6486002)(478600001)(2906002)(71200400001)(7416002)(5660300002)(64756008)(8936002)(8676002)(76116006)(4744005)(41300700001)(66476007)(91956017)(4326008)(66946007)(66556008)(66446008)(122000001)(86362001)(38070700005)(82960400001)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDVNSGR6aXF6dGR6VWJaVHg0cFZJWW1nV3g5Ukg4YTkvSTN0OWgvOU52c1h4?=
 =?utf-8?B?R01kckRWdjZjZG9NMGNIYklldlVBK0tyTDNQdWhRWTZyczY3aTZTd3BNY09P?=
 =?utf-8?B?WE5pd2IzYlRZY2lKVER5dTNzT2c1Zmh5SE96ZGRYcTcxOHpuazlleE9qNFh1?=
 =?utf-8?B?SitUajBaLzNkaGh2TFAwbHdMN1VzcUZaNU9KV0hKRWhVWElLVjhxK2RGN1dX?=
 =?utf-8?B?SS9hNXlOa2NaYmlUYi92UzhEZGd5MDhwa0lTUHorTmxkanBodXFuaTZvd1Bz?=
 =?utf-8?B?V1BpbGJmRFpuWFBJYlF2cG01RlExT0RjOWJDbFpYWG5TdVR6dDlxYlNtd0du?=
 =?utf-8?B?MnFncFAvUFhCeWVOblhiVjBKRDNWZnAvQko4RVM4clJhakRYS2JrNk91V2J4?=
 =?utf-8?B?eDA4N1RQeXRsV2FHUlExenJDWEdlbmNnTGRWT2lxTWhUWDRmWTFUMldwemw4?=
 =?utf-8?B?U1pNd3QxN2o3QXk1YWhWVGY0UGlTVzM3MTh4SzZVeVBLUlplKzBNQTluQnRX?=
 =?utf-8?B?MGNNa1g0TVk5MGM1NSswSWEzeFpjYWd2MWs0b1ZwOVY1YWo3dktFSU9tbEla?=
 =?utf-8?B?VW1RUDluYVhiZW9RUENTeGxXNmJ6N2gxVnlleVhqTXNCMXdYK3oxclAwTmpN?=
 =?utf-8?B?cjFnbmp1cVpDLzFVUGpjTlA4UmY5L2htenI2RkE2Y0ZKRVVBeWVlVkNKeTh5?=
 =?utf-8?B?NThjdTM3d3ZjVFBtUERSRklhQ3M1RU1LL2FDdGlpeHp6c1VUcXNnTHlsU2tL?=
 =?utf-8?B?ckpBWDFUQmZVUjZQTERwWmdoOTk2UzVyK25MTEU3ZmdlanIvakdwRWtkdmQv?=
 =?utf-8?B?V2R4S1dVNG1iT1BjUTJ4cE5GNFRPRzIvdzV2OUpvVEFCRTV5TElDdWJRWkhR?=
 =?utf-8?B?dG5jR09YRGpNcUNxd3NoUmlGZW9iam45UlN5d1gxODhPNnBrZGNEaTQyTzZB?=
 =?utf-8?B?N0xGblpVQkEvT2pTQTViVlU2bjJXMTFTNlo2WVFXWm5SU1RFamFVQ1FhYkww?=
 =?utf-8?B?ekR5Y0QxMFBkUWxJaE11WVQxeWJ6TTBXek44RzJWT09CTTFia0NZVVFGdDZK?=
 =?utf-8?B?emcxVFA1TDF2VlE1SUpINDhwazBFT3lXcERwMHdpV3pzYW56Y2tjYTNScFVP?=
 =?utf-8?B?RWJTMGZwV0pjdGlFREtYNGQyeUFIRUpoSzVLRDNJd1FPQVFzYlRLOHVKVTB3?=
 =?utf-8?B?Q1ZDd3NNaGNRaFdJZi9GMFcxNGpxZmtVZ01UN2NkZnc2bUp2K3VzVVpNUk9j?=
 =?utf-8?B?b1kwVEpzdFFRUnlxNTN3WnJVSzFoamJhclJyeWhRbnNoYUJ3RnRoSCtxU1k5?=
 =?utf-8?B?dGlzcnh2UE5oR2hBSkVtWnVib2RKT2FiNzZoR2lGVkMyUCs3bCtWSk1nNFE1?=
 =?utf-8?B?bjJPeEtQUmc3S2NLYnJNRE5NYjRlbXZwUEgyRkkyNitUQ1EyaEZ3aFpVOTJj?=
 =?utf-8?B?Z1pzQlFvNk5Nd2R3cEJ0Wm9hTmVsaUtLZkNLd1gxNk5OTmtnNC9MRSszaUhV?=
 =?utf-8?B?MmJmbEV3RzRSdGpKVVNnMGFSY2ZBb2VCd1JEOU5tK3BMN1BtaVFrNGRKQlVX?=
 =?utf-8?B?M1ZEWjJaK0xDNEx2YXQzRHdlbTlqa09QeDhVUnRRSFpnVWhjeGM0SWs4UGV0?=
 =?utf-8?B?Q21tUTI5ODIxVCs4Z3NWc2VPSm04bXpTd1dFOGlveW83cFptZTB6NFZ6TEpx?=
 =?utf-8?B?djR6d3hxYXNVZlBpSDkrTUlrTlVKRWRuSVZYMWIxaDdHRGVvdFRZN0pka2RT?=
 =?utf-8?B?ODJpYlUwSlBIak5xaXVPcEp3blpCaDhWU3BOMkw5dlJUd2c4Z0hoS3ZyYVJk?=
 =?utf-8?B?N1lsMVFXVFNtMUE5czdXSWJBdC9nV1hWZktwaUdXNERDeGZnN090QmNLbm5R?=
 =?utf-8?B?a1hwd2NEWHAxY1FHN1VaRFNEOUROSU5mb2lTa2s2TWpxZmpucnZRdXJIZWh1?=
 =?utf-8?B?ZDhpVXJ6ZjE3NW9yTGs4cy91N0I0WkkrekV2bDZMQkV5ZDNNWnRxd2VCU0RJ?=
 =?utf-8?B?OU1peE93Zy9nUnlITHlsaVZ6U2ZaeXF0RjMxNWt1RlBBMk1Vb1dyYk1kK0tF?=
 =?utf-8?B?QzZ6UkZWd2orNUFoRGE0TE9XcWJybk1GcXY2VlZsN1lDeWZHWXQ3N2ZCQjlN?=
 =?utf-8?B?VzVUcytQRnpvdzRJdEt4Nk1mNUV5YTd2UWtmdXdWazlUUkdvQysxVmNSSVMz?=
 =?utf-8?Q?T/MkUgaZeBSytlYXTWW0Q5U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <002FC2E14F500F4FBCFEAF401E031EFB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a02e3b-d5c8-4d70-19ef-08db24e4ce20
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 23:35:33.2254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vASnGkTtebhsK3RcfstLk/xSLo7kqEL6HbG207/PD21e2rw/SIayMU+PBE1YZ5ClX7UmE7F/pGgh9xxV2k2NNVsF1fdlNw/lDtfgC8Q6Ows=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6657
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTAzLTEyIGF0IDE0OjI2ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IHVudGFnZ2VkX2FkZHIoKSByZW1vdmVzIHRhZ3MvbWV0YWRhdGEgZnJvbSB0aGUgYWRk
cmVzcyBhbmQgYnJpbmdzIGl0DQo+IHRvDQo+IHRoZSBjYW5vbmljYWwgZm9ybS4gVGhlIGhlbHBl
ciBpcyBpbXBsZW1lbnRlZCBvbiBhcm02NCBhbmQgc3BhcmMuDQo+IEJvdGggb2YNCj4gdGhlbSBk
byB1bnRhZ2dpbmcgYmFzZWQgb24gZ2xvYmFsIHJ1bGVzLg0KPiANCj4gSG93ZXZlciwgTGluZWFy
IEFkZHJlc3MgTWFza2luZyAoTEFNKSBvbiB4ODYgaW50cm9kdWNlcyBwZXItcHJvY2Vzcw0KPiBz
ZXR0aW5ncyBmb3IgdW50YWdnaW5nLiBBcyBhIHJlc3VsdCwgdW50YWdnZWRfYWRkcigpIGlzIG5v
dyBvbmx5DQo+IHN1aXRhYmxlIGZvciB1bnRhZ2dpbmcgYWRkcmVzc2VzIGZvciB0aGUgY3VycmVu
dCBwcm9jY2Vzcy4NCj4gDQo+IFRoZSBuZXcgaGVscGVyIHVudGFnZ2VkX2FkZHJfcmVtb3RlKCkg
aGFzIHRvIGJlIHVzZWQgd2hlbiB0aGUgYWRkcmVzcw0KPiB0YXJnZXRzIHJlbW90ZSBwcm9jZXNz
LiBJdCByZXF1aXJlcyB0aGUgbW1hcCBsb2NrIGZvciB0YXJnZXQgbW0gdG8gYmUNCj4gdGFrZW4u
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1v
dkBsaW51eC5pbnRlbC5jb20+DQo+IEFja2VkLWJ5OiBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxw
ZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4gVGVzdGVkLWJ5OiBBbGV4YW5kZXIgUG90YXBlbmtvIDxn
bGlkZXJAZ29vZ2xlLmNvbT4NCg0KU2VlbXMgdG8gY292ZXIgYWxsIHRoZSB1bnRhZ2dlZF9hZGRy
KCkgY2FzZXMgdGhhdCB3ZXJlIG9wZXJhdGluZyBvbiBhDQpub24tY3VycmVudCBNTS4NCg0KUmV2
aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==
