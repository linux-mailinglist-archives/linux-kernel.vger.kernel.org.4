Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8C5686287
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjBAJJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjBAJJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:09:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893F65D907;
        Wed,  1 Feb 2023 01:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675242527; x=1706778527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zAXxG1dSD/LrAI9k7iqcg2FHEDZhVXuIMLqjW5KgOkg=;
  b=LNQU9m/6v2/9/B+fKpGZtrrM6ws752TefhcDwn4Q+N7k1udyKC6Qtlyh
   8Mvs1Ux9j4tK6kbfYDwsez4cbRP58x3GosRkUUhz12u+3xr09DdMk05r5
   Mni7xRUeiFA7FxZjqqnpxQ6liZlgC7gmXOn7Qgf+s3nfmwMPtVs6hzA3o
   hY7tYJyX76XImHs4By8ub8IKj5vSbONZtUOz/Khf71r4807VwtTtNdfGg
   5GJTIexyg5TXYpGYd1UH2W6Xhp9gW245/hu0cX4nJEG+NaQtCDAejnurA
   nNmOgeHcgR9Aj9naaen+7CLuRH5kcODgLntzBjFNkxp14R7+u00XMYqKg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="308435539"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="308435539"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 01:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="838701311"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="838701311"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2023 01:08:29 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 01:08:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 01:08:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 01:08:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ifxbb79yoFeFROQvn0g0BzdL2oBZBAkl0EpaYNQITw2KBTfJ/l2sPBthB+kNTWDss1YqTSHb4yyNmzbDukSvMs2xUzs6gdeI3RxE/ySqQHdrIhQpIL+9rxP2Sw74AzK2FtB5ha4/ICZ8vqRLsYcVKyDLqW9LLgTx50IVco7IXOFJY4IkJmzO8C9DAhDvwpoCXbZ7ZOYfLFa2iOt/DZZFNl7zfS2yvGTipYoQgIm+gtrHWzqDBVfJlcFu2Og0tXl1V41PdUzZbrLCxXe5LI7SUeC27oC3FiVpv6RLPU62L4lI6UOFnbCu1VC0dJKq0JXhBJWsHNgKYuhPgG3D4pLTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAXxG1dSD/LrAI9k7iqcg2FHEDZhVXuIMLqjW5KgOkg=;
 b=V22Q8po7H/bVBCG/eVDPiazyz+l284SxdmAfD7QUi2FHx9IQlVpToCz/rSxmWorri7gua/6m3YiEzgBYnIvgSzW8Ny7ZnF9IO4USnB0EPPeWvj4lGit7H5uG0SAaEhXa8S8W1OO4A/dy0Oe18HkbN9eFIF18pg11xwMjlH3MRvHwQm1V5fo013gqnjCphHCIyEBWFMiTJpqIEU5tOAHlb5nAW/5zYthmOIYyH7psGmddZXqez9dqG96pG3RRs4xWN72nRY+zLPEMXCzc9SVzzz6kFTKJTFr66KXrF2uuTVAkMGc8AgJSnkrZCkkinIAmnTKzAVbNNDgO/QCtkNGmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5032.namprd11.prod.outlook.com (2603:10b6:510:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 09:08:27 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%4]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 09:08:27 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 0/8] thermal: intel: intel_pch: Code simplification and
 cleanups
Thread-Topic: [PATCH v1 0/8] thermal: intel: intel_pch: Code simplification
 and cleanups
Thread-Index: AQHZNN4k7uIHoJI5tU+cNG//rpyh2K65zzAAgAAAjwA=
Date:   Wed, 1 Feb 2023 09:08:27 +0000
Message-ID: <e5407fd3f7ab313e90711410c4845949d3712083.camel@intel.com>
References: <1751684.VLH7GnMWUR@kreacher>
         <e5493acd05ddffd8bf60942bd595421eb236c5d3.camel@intel.com>
In-Reply-To: <e5493acd05ddffd8bf60942bd595421eb236c5d3.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5032:EE_
x-ms-office365-filtering-correlation-id: 49e629dc-d1a7-42b6-56f6-08db0433e15f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PYNc8GRYkCB4ZH6m+eVxp39h5Uh3698ocJZsWyelxe+pJIPBxgUmHV4DckZg4KuLwUcE65nJzoJ0F8eisOxZRhnFIkSCmlxgA2F2fpnsxKIEnVaNkhxYctjtHMkiTqV8J0Tq+phBw1iSrRC3gPw6VIJezCobIU23B0d3w1M88diYs+E8f6xT1PEFQWX6EffXV9YP0iD6HH3V0fQHnZ5iXgyeS15l2fqrfM7365rIXs6ECrlxTDduU+bdaJbjvIlBWRWdRBfgbcZLPx+4xuKRUcm8eZSqISC6fxkiZwlKd9jg6JaQgtqQSXDG30WEd023du6Nz4bYYS8YFVr/M3JX3Twqt5X49SvPWzeRWgg2m2GCawX+GOOZZNgFC9nL7P5+IAwujyc0XenngIg7yNWFLLD4+PNerwhV/9QDL82Kqg+Vc5VpoW+3gUubysXkCovLC4Rz3cvkcpqlAIxLQSf7ZktrvUpRLA5DG6/FMFdZzazdaOWb/luv7zMe9hFDaMnDM1CQG8HskXEW2mCCVXUnONqHZwQykBZozXBaq0a29uaVu96n2oUDLQuiJjBtaea+mFdD248IqDUmn6IGnk6r9Y07HJECh0eUZUJy8f4lULooNODOV6BL6YGys3OSkmdxTyPE06UmkNtm+8keemOooO8Fy8nUVz9U4QNUEBKeIMMXBCiNgRS895FId58hTbKXX/4/t+cSSEKssc/E/ggD4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(186003)(2616005)(26005)(6512007)(6506007)(36756003)(38100700002)(38070700005)(122000001)(86362001)(478600001)(71200400001)(6486002)(110136005)(54906003)(5660300002)(316002)(4744005)(8676002)(91956017)(76116006)(4326008)(82960400001)(41300700001)(2906002)(8936002)(66556008)(66476007)(64756008)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c05UNFR1OExMZGpValZ5UVdBQXFTc0lVMytyTlFBWHdyU1RWK1UxTUErcUJ5?=
 =?utf-8?B?eTFiamZhTWdxS20wZzQ0VjN2WXlERzJEd0NIME0vMDJzRExzczFsS2ZlWlg1?=
 =?utf-8?B?dFp6Rlg1eWFhS2dWY3pDamRMd05FSHM3MVNid3gzdWQ1ME13SXJocFZOU2VB?=
 =?utf-8?B?QW5OSFF0ZTRCTHkxd3ZkRWZBZEtoVVU1cnNzL2l5bFFvMWQyVXB5QzY5Mllm?=
 =?utf-8?B?amtkM3V2NmhQZExRLzJJK3d0dkxnR1JpbVliaHJMQ0xyd2VRaWNPTmRsQW54?=
 =?utf-8?B?dDc2M2QvSVV2UTFxM0JNNG8zZis2Ky9aTXpNZjdtbTMwMUt6eGxYTUVoQTJN?=
 =?utf-8?B?aFk2NzBxdnB5ZmNGaFpZT25Kd21lQjd1L2diQS9SVFFyMGxtd3JRbkdrV2wx?=
 =?utf-8?B?ZWVPSnZxSlBrOE1zRS8xaGMvODRkT2dxYkx2SVVLVkRsZ2FJNXlOOVcxZnJJ?=
 =?utf-8?B?UlVRSHVCdDQvMEtVekVVQjZtSVE2MkwxaGRiNGMzY0xPVnpWUyt6YWpRL3Vl?=
 =?utf-8?B?SDlwcm1odWpHck5lNk1SVzUyRmM0SldjZ1FjZno5NlJuaXdjcFFGYjdEb0Yx?=
 =?utf-8?B?cm15bi9xOXllZndZaEtubzdRYlVHZm5NNWhMYnptdjBmeFlrZFVaaklIek96?=
 =?utf-8?B?aGt5ZU8xOUVhaUZ1QTJ0QmF0UG1EeEJHYnRGUUx5c0lQU2huUVhTWmtOZ0Vp?=
 =?utf-8?B?SWJocXMxMERuSmgvV2YrUkJMRkJ5d3JBR0FJQlRYQlNiZTdmaG1Gcko1UzVm?=
 =?utf-8?B?bEFtUHZrU3g3Mm52TGpMcGpINlpDcnc4TnUwQUMwMFQ2MWlxdlRZc3NvQnJ3?=
 =?utf-8?B?anhCOWw4MEsrQWdEUFBKTzdRUGJQWk9adDNHZGdPK3luZmhrVi9tOTN3M280?=
 =?utf-8?B?eFZ1R09PVDhkc3dFcUl3Qld2M0RvQjZmdVMvQ2J2UjAvaWFTTTVFZVIzU1B4?=
 =?utf-8?B?ajYrWDN6djR2ZFlseWJTZ255SVVQSXdObjJHV1ZTYk5SREtMazlWY3RnNGp2?=
 =?utf-8?B?bVVTTDBzMno3Q0ZlL0xMNVFPaGErR0VXY0g4UTN0VkFjRnpBbllrTFE4NEVE?=
 =?utf-8?B?dVhleDdQYjZCQ1d2dmpQc1VFVlpHMk8rZ2srczNMclpHTzBlZlZRVmNYc1Vh?=
 =?utf-8?B?c3RnUUZoK3lWQklnT21wMkVYcTI1UnZzUitpS3pxY05qaElVK2xwUytjbXQ5?=
 =?utf-8?B?aFh6QUJpL1prOGVlcEVUMjAxLzZUNWtwV1prbmlheldVK1lBM0krYWZlcEx5?=
 =?utf-8?B?Z0MxaDd1Y0RHN2JCeFJRcm9BVkVtUnBwWnFhZHJlbHNyN3lZWkpDUFhnSHQ4?=
 =?utf-8?B?VEZvMmZSSmlKU0w4K1JxZVNiVXdLc2drRnRmTmNOSXVnb2JvU09Jcm1sVUtM?=
 =?utf-8?B?OE1lVjNQd2FXcG5oSTVlL2cxUHh3WnBOUHZSRnNyOTRJWnorMWtMNUwwdnZQ?=
 =?utf-8?B?UzlNSHBKNzRPRlRtRGxMWENoODBvcUFpNmNMKzB6eStVWDRZUVhkWFBkMzdR?=
 =?utf-8?B?ZXNKTXFLTFpSUXdESDF3WGo3bTRzM1ZNUDJEV0V4VkhyQ3EwdXVWdVR4OEw3?=
 =?utf-8?B?c3laeU02bnQrRXVMMkJwQlRrTEdLTFNzeEN2cE5jeCtXRU9rbG1lakRGMFFV?=
 =?utf-8?B?NUtyRlVES0d0dVBRb1FUUWJ6Zzk0QlJxbHVLWGVLUmlqbVB5b21DMmhZOU0r?=
 =?utf-8?B?SXhXVHR4NnlsL0l3NFA1UFRMT2ZDQzNZS29TWnVYbzFiSGdzdG11YUV2MkZB?=
 =?utf-8?B?L0xYQ1AvQkkvMkV1TEgxcWVLbUZpMU4ycnozUEFCbVAxQ05pS2RxeGI3c1Qy?=
 =?utf-8?B?TEhUR0oxaExFK0VJYmRTWlRCWnJYVDhKdEcvdmlvZEV5YTdJVFpxOWhrUElB?=
 =?utf-8?B?bFR0dEV5UTFzb0F3bXRpdmh4UVczR3RTVExLUS90OU92U0M4ZGxpRk00OXJ6?=
 =?utf-8?B?U2NabEZIWWRrbkhETFc1R3ZMNXVJSFl3OGpBMjZmc3NEaGQ4bm1DeVVsMUI1?=
 =?utf-8?B?ZDdSVFpjMXRuRlFadUwrZGJZR0g2K3pJQ3lvR1ZFRWpoV1JhZUFKVFozQm9V?=
 =?utf-8?B?NUgvSnIya0FJVDY5V2lZNW9RWTY3SWt4UDA5dEFYODVPQ3JuRmVHayszYlBU?=
 =?utf-8?B?OTlIN0h1NTk2L3F6Tk1ZWXBOOGsxdmhrdjVMMi9HUXJkQVFTNURYcTI5N0lh?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <470D87A0B21C4043A5C84090D9004DD5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e629dc-d1a7-42b6-56f6-08db0433e15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 09:08:27.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mdb0cpurS3qhjNO6yg4HwpZHj/xH+lROE+fxE8xpTamA1XngfAIO7BrTmYJlmcjdynPldNDilp5B7PEoLbUeYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5032
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTAxIGF0IDE3OjA2ICswODAwLCBaaGFuZyBSdWkgd3JvdGU6DQo+IE9u
IE1vbiwgMjAyMy0wMS0zMCBhdCAxOTo1NiArMDEwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6
DQo+ID4gSGkgQWxsLA0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIHJlbW92ZXMgc29tZSB1
bmVlZGVkIGNvZGUgYW5kIGRhdGEgc3RydWN0dXJlcw0KPiA+IGZyb20NCj4gPiB0aGUNCj4gPiBp
bnRlbF9wY2hfdGhlcm1hbCBkcml2ZXIsIHJlYXJyYW5nZXMgaXQgYW5kIGRvZXMgc29tZSBhc3Nv
cnRlZA0KPiA+IG1pbm9yDQo+ID4gY2xlYW51cHMNCj4gPiAobm8gY2hhbmdlIGluIGJlaGF2aW9y
IHNob3VsZCByZXN1bHQgZnJvbSBpdCkuDQo+ID4gDQo+ID4gUGxlYXNlIHJlZmVyIHRvIHRoZSBp
bmRpdmlkdWFsIHBhdGNoIGNoYW5nZWxvZ3MgZm9yIGRldGFpbHMuDQo+ID4gDQo+ID4gVGhhbmtz
IQ0KPiA+IA0KPiBUZXN0ZWQgb24gb25lIEtCTC1SIHBsYXRmb3JtLCBldmVyeXRoaW5nIHdvcmtz
IGZpbmUuDQo+IA0KPiBUZXN0ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCg0KRm9yZ290
IHRvIG1lbnRpb24sIEkgdGVzdGVkIHBhdGNoIDF+NyBpbiB0aGlzIHNlcmllcywgcGx1cyB0aGUg
YXBwZW5kZWQNCnBhdGNoIGluIHBhdGNoIDcvOCB0aHJlYWQuDQoNCj4gDQo+IHRoYW5rcywNCj4g
cnVpDQo=
