Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08CF6F2197
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346890AbjD2A0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjD2A0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:26:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB935B1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682728003; x=1714264003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GjAON1rAhbN+uSl5WRL5qQ+DLm4xD3QNr+H+lLs4LiE=;
  b=lbTwFdzO38XidmZ/Fc/4lz5WNBUjUmzfJvUw9FLzqg8pHnF7JjXOkC0o
   voMzrCCS0aNEqcWQmMix31PRFcTgI5mWrCR1S54zZyIKsy55pdEDUWoWO
   wSuVHocAXthAJuza9i9Bu8M1EdAy9n2exUIsqUaAdxuuPtuQ0Q8TGocaU
   LHRauWHlOe/yrWqidN8g4KNO7uy1XOzQfM5tX8orMAeF+a/VBM76JUp0z
   MQSM5vzs9Foj8braEal9fQeyoBnZUQar7bgsjHf4bSCpZgcmdctMHnOGT
   FvaF7O1wLR//XgKJ2YmdMSI0mgeLXAstRWaF0hxZ9M8/amsI3qLwVurri
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="328224974"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="328224974"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 17:26:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="759858771"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="759858771"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2023 17:26:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 17:26:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 28 Apr 2023 17:26:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 28 Apr 2023 17:26:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF+e51Lkt/op9HF9wW1JmPgoXlrDGe7ZpqX3PAOfJRN3yUjWoGw/aO5ZGbdeOXwigzsl2tRhqG1zqmhLqVGm+IZ/ZudCR4Q0QDglDexvuHGvxTnOAd5c3UyFYP6NMIfwARMlk+8PMTcTvx4RAb/H989LeNCOyD297aHmmOlc32QaWxfGgbWqN4nh8eMonpRc0uAhm1WvwKumWx8ZpDxY7R6DSc/GhcS7dgyDTodq+2TU9ky5F5eaGq8ibdB12fVqZL2pXLkjqc54h/LAkS/PcEN/SHbNydTfalqOFG69uDyJOkEob6ILiD6/Q/ZPvTtp4UI8B8tEqRRQqSc//yZkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjAON1rAhbN+uSl5WRL5qQ+DLm4xD3QNr+H+lLs4LiE=;
 b=g8WEf31hy/HW5dfSoh72UrCQLk6Z1J31F6Y1Qfz9BwCuVLzbjbm2OlJi1jQB++oyeCvuacnqgHDFPuPwttM9AKpPAB9DjMG5G6SOsUs40jYTdayODpVGAcyQ01dJ5uyjm2yJFUb8K4X55R11krIPHQTuwnuqnb5Ry5e3jYxjcixWq9VQiOJIbQOG3WWCBD6MheEQsM3oQlh8SavT13J26/MTjzOJ8NLXhCPshXJA/G6mNlVeg1N5SIGBMyh2BTSEVPzy+Z4JVkLHPvEBCNkB7PjAW/AB3jfBA1t31LvhXo30PQf5wh9rGI4a7ziiVSp7rVwXm4cgwpWZ+vztL0aECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Sat, 29 Apr
 2023 00:26:37 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%6]) with mapi id 15.20.6340.024; Sat, 29 Apr 2023
 00:26:37 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/shstk for 6.4
Thread-Topic: [GIT PULL] x86/shstk for 6.4
Thread-Index: AQHZdvLFwdOoBiNv3EeiRW4XzF36M69BDVuAgABnQwA=
Date:   Sat, 29 Apr 2023 00:26:37 +0000
Message-ID: <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
         <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
In-Reply-To: <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB7636:EE_
x-ms-office365-filtering-correlation-id: bf15df18-04f8-44ab-031d-08db484864fb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YChDXnidLWCuPsq1uPUjoIzwBCvh9X30hw/TwPysyVHHnZX3tfMVXYlxhoXYq7g1lnNLk0WQ+FoEkiNp2m/FQcaxlfmrestRTX9ETUxNr+c8415GddT6KHQXqp72RCkBONieRwpt9SP+4yxfrhXcQhjQthgyiU6DgWjRL3z8N7F/K/wXREpnWGitMVl7JcAu2U5nEOMyhzviOCBj4KSiVJ1d+zQ13KH+fIBkJ51bUzjj4rH6aY40ngcf2bZtVvesCUDAuHwoys1jjrpw4jAWKZoo+97mJC5kUhprvRr3/Wb6nxnrhvZXb0sxUmBflPv+nLH7u2kHYooBvBAwXaxtMRImpug3Anea3q8oUi6Nz0FN8sceFefv+FOHNr4cCJ5t12xoHm+E99/82YhmauDHt8f0NNjEpCp+BmK9QgqQrg6DCrcX3He24lUop5nPNDIeYY/8oV3XF+NbgDAB0zZSe3jGyxO03gneI5qwIc42rIzaD0CExXkuel34eV52iWLvB+Cvaeujl07t8QkMLQbrAlVddDxjGtgF3qqu2X+9UBX052SoGUcKzyHFMDGszjNCkV5plA75SUzPQea7aTFb1//RtuikU+c5gXnXhZC0F2w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(4326008)(91956017)(38100700002)(122000001)(5660300002)(66946007)(316002)(66476007)(66556008)(76116006)(66446008)(64756008)(2616005)(8936002)(83380400001)(41300700001)(8676002)(71200400001)(38070700005)(966005)(6486002)(186003)(26005)(36756003)(6506007)(110136005)(6512007)(54906003)(478600001)(2906002)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3h2Vkh5UFZIYjF3T0xhSGcxdmVwa2kvdGtidGppRW1JTE9XV1Z6OFB1czZ1?=
 =?utf-8?B?UUZabEdVUjduTEpxZ1ZJRjBNTXNKSUw1NG1xdkdCOWRiSklVYzZHWEpwVEcw?=
 =?utf-8?B?bjl0dkFnSlcyNFc1eUFxbGVYMi9NcEl4TGs5ZmtZV0poSTdRVytHNGJHcG1j?=
 =?utf-8?B?V0tkME56R2FBcHRTRkx3NHJhc0V4ZzZicDkzbE1BcVdvZFhCRE1ESzA5YVJy?=
 =?utf-8?B?UnNUMmFLUklSR2laK2NjaXBucU1zSHMzRnJHN0dXbm1FYmZ1NlQ1ZUE1bDAr?=
 =?utf-8?B?cC94OTZoaGo2SU9tYkxNNFpkSTZZTnR1NTg0dno3cUh1YXFGLzJpcjZRb0py?=
 =?utf-8?B?Q1A4WGFaaUpuUlViSEFiSzVaLy9kWVhCT3JIU1E2b0prYVRBVWZMZk9MV3J2?=
 =?utf-8?B?WTJVdzNNZFU4ZEh4bkVkMFAybG9KTjNVNEhSZjh5VjhDWEQxK2l2WWdINjYx?=
 =?utf-8?B?RWFNNkN5RWc2MlhTR3diRTVIQWxBbHFNQW5YTmxyRjM1cm1KZEdNMGJLcExv?=
 =?utf-8?B?dzNrZ1A1UlRQNGx5M2ZlV093VlQ4eG5rVWZXdjhSSjVaU1hZZExWQ2k3bXFw?=
 =?utf-8?B?N3Q4aUlmK2w5T3NCMmJnZGFDekFpeUswSGR2Tis4aFBnY1dwTVA0NFJCNWsz?=
 =?utf-8?B?cXdpaVl3OXdBaVV0WENnSEIyTGMxcE0zd2dlRFl4WVFibTJmSklwNzNwSnJZ?=
 =?utf-8?B?RzYrSVVEcDE0eVVjTVFQTmZ5QlJOWkRJSlBaNFZ6UVpZM3dyOGhuYW5PWVhQ?=
 =?utf-8?B?ejVxQ1hSK0FaRFJSVWVlOExVYjlvZjJkOTZZTWdRQm0vV0E1TmdIVVNFcmd0?=
 =?utf-8?B?YWxpM3RadWozQnZYeC9WSXJEU0lFektWTDFGMTlCZURaNmhnbmhtWTV3OHhH?=
 =?utf-8?B?VmdXbENFVW0yUm9NdVZlVTAySituYXcyRGpxVVZEdisvMnB3Vm1ZUk5wZk5K?=
 =?utf-8?B?eEM4S0ZESjQxdWxyTGw0Szd1Mk02N3ExZUFnZVVka1pKbUVvSlk2ckNxOHZh?=
 =?utf-8?B?YUFHbTZqbTBuV21nSDRPQWg5M0Vsb1F2WnNPTFQ3djhhQ2JMQ0RyWWpmUDBJ?=
 =?utf-8?B?TGpiZDIraE9abDlldGhyR3hidmVSRHc3UHU1eEFKUFhZWFI2c1JkR0VyVy8z?=
 =?utf-8?B?cm1YcTQ1NEJoVmtXMzRzNGlENEJoSmpCcXBRS20zMlJRNXpucStyaG05a0pM?=
 =?utf-8?B?ZGdDLzVxT004TDRWZWhsVUN2VjRKdS8rbmZyYlNzZmZuNDV2WVJ3OU1zbGlt?=
 =?utf-8?B?anF6Y0pUeEdNSW9USFRWM0hNcHBBOW1jZkFONTlkK3dmbG01REl6NmlCYlBL?=
 =?utf-8?B?OGtqbVFSOTJrRHZVYXQ2TlNhMGZrUHZTeXltRmIvVzdEbDFJT0VlUkNMU2Ru?=
 =?utf-8?B?N3BFQThuU1NYL3poS1E3Zko3M3h0aVVucHEyek9pZHZjOU94WTFnWFl4WW55?=
 =?utf-8?B?ZjZMYUY1K2JwL1NMdWRkZHI5OWk1RmttUW43djZWcHlCYjZwK29ZZlVtTmxr?=
 =?utf-8?B?TUErcWdVL1ZwTVNkUWswb2pNckwySmlPS3ZtTzZKS0hhS1hGYXdJWHFodDdM?=
 =?utf-8?B?aVhnVHRrQ3FMU3FmcGxYREJtVGZoWjdoOFVNWFZVeHFqeC9FSmVDOWl4cVVD?=
 =?utf-8?B?cll1Z05iaVpkMmNqT3JrejQzUDNtakM0RlBsYldxS0swSzRTRk45RnJzd1Fl?=
 =?utf-8?B?RzNSQjRId0VIb3E3NTRiOUo5K0RpWWdOZDlPKzRJNVZTbS85K3lXREM5Vlla?=
 =?utf-8?B?cnRramZqNTNDRXYvVXpLUnBzVUkvbE80d3RvcU1SNFVLVkZKdDF5YUdpVE56?=
 =?utf-8?B?QU5lZFZGeTAxWGEzUVQ2RVRlNnpjd3NDR2htQ2F1dWM2NDhOQ3E5OEhpL2NY?=
 =?utf-8?B?Z0F5d3YvaTBJQ2REckJWOG1KWEozeERYOXlPYktRNG43dFJIMURTTVl2MmJP?=
 =?utf-8?B?WlRORzdVOVg1elhIQmlBUjY2YXFNNWsrQzZ3Q3hWdXBKaFNnMWRoRnAxU1FE?=
 =?utf-8?B?ZlM4QlFlSmpDMitBN3YxeGk0ZWY0QVVDSDlpMnozZjM3UnRFSUxBaG00SlhE?=
 =?utf-8?B?b0xZRVhIMnhZVFlrTjlkd3JlWDc1ckpHVTEvQ1hDZzhoV0pvN0c2UWVQSkt0?=
 =?utf-8?B?WTVBOStUL01UclhjNTFVaDRndFBPYStLY2dZbkJIUFR3dVo3QUUrL0dJSmZX?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFD0886AC0F73C4D985888965ED2A067@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf15df18-04f8-44ab-031d-08db484864fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2023 00:26:37.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8Zmb6eeReaLfTQD/beriW+tKDl1ppCeWjfP+DPzvwbTUypkwJdXtxRAGzjZ6VIoHvEG9IKa5TyUltpKvGxrevZIuN0bwG9hEccZShVJQDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7636
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

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDExOjE3IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gSWYgaXQgY2FuIGJlIGNob3BwZWQgdXAgaW50byBzbWFsbGVyIHBpZWNlcyAoInRoaXMgaXMg
anVzdCB0aGUNCj4gcHJlbGltaW5hcnkgd29yayBwYXJ0IHdoaWNoIGlzIGFsbCBvYnZpb3VzIGFu
ZCBjbGVhciIpIHRoYXQgbWlnaHQNCj4gaGVscA0KPiBtZSwgYnV0IEknbGwgZ2V0IGFyb3VuZCB0
byBpdCBldmVudHVhbGx5IHJlZ2FyZGxlc3MuDQoNCkxvb2tpbmcgYXQgaXQgd2l0aCB0aGF0IGlu
IG1pbmQsIEkgY2FuIHNlZSBob3cgdGhlIGtleSBiaXRzIGhhdmUgZ290dGVuDQpsb3N0IGluIHRo
ZSBub2lzZS4gSSd2ZSB0YWtlbiBhIHN0YWIgYXQgcmVvcmRlcmluZyBpdC4gSSB0aGluayBpdCBp
cw0KYmV0dGVyIGF0IHNlcGFyYXRpbmcgb3V0IGFuZCB0YWdnaW5nIHRoZSBib3JpbmcgcGFydHMg
ZnJvbSB0aGUgdGhvcm5pZXINCm9uZXMuDQoNClRoZSByZWJhc2Ugd2FzIGFsbW9zdCBjbGVhbiwg
YW5kIGNoYW5nZXMgYXJlIHByZXR0eSBtdWNoIGluIHRoZSBjb21taXRzDQp3aGVyZSB0aGV5IHdl
cmUgb3JpZ2luYWxseS4gVGhlIHJvYm90cyBhcmUgc3RpbGwgY2hlY2tpbmcgaXQgZm9yDQpiaXNl
Y3RhYmlsaXR5LCBzbyBwbGVhc2UgY29uc2lkZXIgdGhpcyBicmFuY2ggZm9yIHJldmlldyBvbmx5
Lg0KDQpUaGUgdGFncyBhcmUgYXMgZm9sbG93cyAoaW4gY2hyb25vbG9naWNhbCBvcmRlcik6DQoN
CmdlbmVyaWNfbW0NCi0tLS0tLS0tLS0NCkNvcmUgTU0gcmVmYWN0b3JpbmcgaW4gcHJlcCBmb3Ig
c2hhZG93IHN0YWNrIG1lbW9yeS4NCg0Kc2hhZG93X3N0YWNrX3ByZXANCi0tLS0tLS0tLS0tLS0t
LS0tDQpBZGQgS2NvbmZpZydzIGFuZCBkZWZpbmVzIG5lZWRlZCBieSBsYXRlciBwYXRjaGVzDQoN
CnNhdmVkX2RpcnR5DQotLS0tLS0tLS0tLQ0KSW1wbGVtZW50YXRpb24gb2YgdGhlICJTYXZlZCBE
aXJ0eSBCaXQiLiBUaGUgSFcgaGFzIHNoYWRvdyBzdGFjayBhcyBhDQp3ZWlyZCBQVEUgYml0IGNv
bWJpbmF0aW9uOiAiV3JpdGU9MCxEaXJ0eT0xIi4gU28gdGhlIHg4NiBtbSBjb2RlIGtlZXBzDQp0
cmFjayBvZiB0aGUgSFcgZGlydHkgYml0IGluIGEgU1cgYml0IHdoZW4gSFcgRGlydHk9MSBtZW1v
cnkgZ2V0cw0Kd3JpdGUtcHJvdGVjdGVkLCBpbiBvcmRlciB0byBub3QgaW5hZHZlcnRlbnRseSBj
cmVhdGUgc2hhZG93IHN0YWNrDQptZW1vcnkuDQoNCnNoYWRvd19zdGFja19tZW1fYm9yaW5nDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KU2hhZG93IHN0YWNrIG1lbW9yeSBwYXRjaGVzIHRoYXQg
YXJlIGZhaXJseSBtZWNoYW5pY2FsLg0KDQpzaGFkb3dfc3RhY2tfbWVtX3Rob3JueQ0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NClRoZSBuaXR0eSBncml0dHkgb2Ygc2hhZG93IHN0YWNrIG1lbW9y
eSBzdXBwb3J0Lg0KDQpzaGFkb3dfc3RhY2tfY29yZQ0KLS0tLS0tLS0tLS0tLS0tLS0NClRoaXMg
aXMgdGhlIG5vbi1NTSBwYXJ0cyBvZiB0aGUgc2hhZG93IHN0YWNrIGltcGxlbWVudGF0aW9uLiBJ
dA0KaW1wbGVtZW50cyBuZXcgQUJJIGFyb3VuZCBzaGFkb3cgc3RhY2tzIChjbG9uZSwgc2lnbmFs
cywgZW5hYmxpbmcsDQpldGMpLg0KDQpzaGFkb3dfc3RhY2tfcHRyYWNlDQotLS0tLS0tLS0tLS0t
LS0tLS0tDQpTdXBwb3J0IGZvciBwdHJhY2VycyB0byB3b3JrIHdpdGgvYXJvdW5kIHNoYWRvdyBz
dGFjay4NCg0KDQpZb3UgbWlnaHQgZmluZCBnZW5lcmljX21tLCBzaGFkb3dfc3RhY2tfcHJlcCwg
c2hhZG93X3N0YWNrX21lbV9ib3JpbmcNCmFuZCBzaGFkb3dfc3RhY2tfcHRyYWNlIHRvIGJlIHRo
ZSBtb3N0IG9yZGluYXJ5LiBBbmQgc2F2ZWRfZGlydHksIA0Kc2hhZG93X3N0YWNrX21lbV90aG9y
bnkgYW5kIHNoYWRvd19zdGFja19jb3JlIHRvIGJlIG1vcmUgaW50ZXJlc3RpbmcuDQoNCktpbmRs
eSBwbGFjZWQgb24gYSBob3N0IHdoZXJlIHRoZSB0YWdzIGNhbiBiZSB2aWV3ZWQgaW4gdGhlIGNv
bW1pdCBsb2cNCmJ5IERhdmU6DQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9kYXZlaC9kZXZlbC5naXQvbG9nLz9oPXNoYWRvd19zdGFja19wdHJhY2UNCg==
