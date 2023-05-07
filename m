Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5146F998C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjEGP5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjEGP5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:57:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10A1132A6
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683475031; x=1715011031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XctkZ+2SGulzsn6lrFCG2/0nx5aF/tSVCrGDT3O3VHM=;
  b=N0oNT5tXGjwcUORzG634qNsLMN+WEBOOdFmqGYwVJwZb5Qaig9hEuetl
   uy7Etcg+l36N16ncKiSBQzCl9o+SZ/pKJJhnbiZoDb10kDwOyx775GJkp
   4ljehpJfywZjcFK3wKqM7FP2vNaLMrfdK/ig6Vr5tov6CyLyW9ZRg4hyQ
   hOXy55qI257GxwnDLv8YRao4q18cTl+MNUWeYRUWtCCoiuZtzGNV9j1tG
   JRk6iZOZDSN4BXK+9z1bcxgDZHHkRlkQF7XBqAmS5uNSfX8RTV/lr2Y6a
   n88KdtyKP+x8hPQz1CszMiFr9XQir7FGqGIsa9gqDHu97q3jsVplnrEH8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="338715661"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="338715661"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 08:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="822397672"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="822397672"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 07 May 2023 08:57:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 7 May 2023 08:57:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 7 May 2023 08:57:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 7 May 2023 08:57:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwU/byopTUULDdYqPJ4AvjdW/NuVzyEd04swJGzCg8kyaPmH8OjORPU0EWzB0Wz7NWLuDUXMcCdjLV3iNLBUEZwcYfRTSuPWp8N9RxT/AETaR2DGERr1y01+cWnnMeNb8ELsG+kdh07k1gpQAFCyr+sfg0z1BNFgbzPQbMp+k445hFpl0O91MUP8m0gFs18EA6iIEYDRR/0Ppth/vUen3VSEPe4luz+Zh53bWQgRfl5VUnHLHTB+M1Ril84tMM7MNeFhoLx5e55mF+Lyl/RWH1wUNljTbquoV49PpJVfHJW3PKOoyig5nI2o/exjSnAdsAJxJ2aKzso51tyZbozrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XctkZ+2SGulzsn6lrFCG2/0nx5aF/tSVCrGDT3O3VHM=;
 b=ROwoPh3myqepjhq+WU9keiANB6LVoWLO4BFuFPxa0vR4Yn0ajxMGa/oS8IDvJJeFKcz5MuiP4dNKC0i7G1SVT1goegzmcil4ei9F63AmLahx8QqSnQEKk391jGEZVUEVXtJ6lAMnOGBBHXUB/Qi2vJuDDRu/QmvjPlVYo1MgbgrC7pwjg2JPHilZgHmjBzckv2Otkh2O0+VuYXVwZ+XHCaXcYRXibJrs7OeCrboYKa8fufWYHeULxKBeOteK/dXwCra5XASfw18Yo8iW5VYhaStuNBrtGQYNvmGWLcCu46o22WbsW6FaHmO11ezTdWTrvR2AZVwQBqrJtTmETfI/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB7082.namprd11.prod.outlook.com (2603:10b6:930:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Sun, 7 May
 2023 15:57:07 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%7]) with mapi id 15.20.6363.032; Sun, 7 May 2023
 15:57:07 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
Thread-Topic: [GIT PULL] x86/shstk for 6.4
Thread-Index: AQHZdvLFwdOoBiNv3EeiRW4XzF36M69BDVuAgABnQwCAAAPJgIAMPVyAgAAJkYCAAEWaAIAABZ+AgAEAsgA=
Date:   Sun, 7 May 2023 15:57:07 +0000
Message-ID: <061cd3573d105969e4c439d61f74134fbc78d2db.camel@intel.com>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
         <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
         <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
         <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
         <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
         <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
         <085834410eb66433c414f2b81589d45edf1eaf3b.camel@intel.com>
         <CAHk-=wgCM+o1vm4pS_9=1E9XkOn6c1jiiKLJS2710ncEL+43tQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgCM+o1vm4pS_9=1E9XkOn6c1jiiKLJS2710ncEL+43tQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB7082:EE_
x-ms-office365-filtering-correlation-id: ccc96e9a-397a-46eb-f2ad-08db4f13b580
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvJAhoQnnfr+9hJpDj/58Pq/N361/KMvmRy08zbYV7waAT1ehWrSlJzBUhh5SVByd7AUoW/Ls/LKFM6g0RoLAeqUUGggv3WQKpmUjTsgNP7quMuJ8n7g557/0/Rj0OcIL8bLgJVTQ7jWth53jRqPC1ZlfrcSAgvLHIHLJkZGOLDr+76XRNKlB4JeGmr4OzoEB62DqjnPwGg5kMLnhnpEVl7xO9P399qmeTj99I2euq8chl5ICHzkxBxZja0OArVJU8chtMxexxSE8+FpEAmg/PP0XrBE9yW0R9aAur+3vPyP1hRT069IvY03XrQHK7tH3K/tG1J+xUfjynAQjbyznk/+nkrLuIMYtQSOuALWOPRfCiFXD0ctRx5E71AfXN9jGftAxncD3sfWMB+6ZmW+iWdjycw+FiV9tikyb2NgL13FooQJFbTFNPx+BrrbNvLlESwFL/m+yNtPZvK5nNSTcIXSzUcb+NoZk2VN7GGwqE9JWzZsQUFLwOXSQAup2nwCagysMUD7cv6kzDx0Go4xJp5mWFLX6coms9/2Ox0eZeQczbgkAUqIi3mEG6mmDa3LROOGGRnYjFH18EjC4m1HvHTZzwgdSM31HJZIU/a5T7/3/ZQeC/JM9nVbOu9KbHPv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(91956017)(478600001)(6486002)(71200400001)(54906003)(2616005)(6512007)(6506007)(26005)(186003)(2906002)(36756003)(38100700002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6916009)(122000001)(82960400001)(4326008)(41300700001)(5660300002)(8676002)(8936002)(38070700005)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHNJZitnTnR6bCtYSURISmg4RDRUeUtaRzRseDhCOUd5RTZKaW9Wd3k2TTB5?=
 =?utf-8?B?TWJ6UjNiUDZZL2gvSFIydHdtaXJRVEt1NTFXdVlrUklzV1NUTm8xWUsyVkdt?=
 =?utf-8?B?VG1sTGxvTmhnbTA2K1FBbW9JQytTWFEwbWhFWkU2MUo4cVVkMWxCRFpFYTJ1?=
 =?utf-8?B?ZVdFL3hXMndpL2FwSFVsTXJWV29hVnNCUkp0T1JHem9DbU9HeDEzRlFqaWt2?=
 =?utf-8?B?eWZ6amVDMXBlSFR4aHYxeEZGTUZRZ0xuSm96a2VkZ3pVTWRkT2pPQXVWckVn?=
 =?utf-8?B?ZWd4NUlzNlRhY1RmZWlvWGgrRkhrUk03U0NZMGhZOFN1WWtKeUwrWEJKbThH?=
 =?utf-8?B?dzhMQXVuMEVKVXprd2VadTJlMmVEeUpDMHgzUWRFSUcvcUJoNGIwR3dlYmNT?=
 =?utf-8?B?aVgwY0w1MVptUjg3UHo4N3h4MHBXZ1FVWllDVTUzTlJnVlJENXNxbHl4aXVi?=
 =?utf-8?B?RDlJcVovTnp5R0RKbFZzZWthZzE4YXNVREtUanc1R0pJZHA4UlNRMjhrVzUz?=
 =?utf-8?B?dzNIUmpUUFpGdWRlWHBXQUcxZHVYRXQrbDk4cEM2MVhvdzk3Qndkak50SURB?=
 =?utf-8?B?bDFpeWV4ek0vazVOMGhmZUUzL2xRZXpUZmZVRTN5ZW5yRmtRSkg3KzNPcExn?=
 =?utf-8?B?eDZ1UlV0WmE5YithVUozeFMyVXU0ZS83MWtZbVhCS28wU3k4bzNuNThaUDZz?=
 =?utf-8?B?amZhamlYTU9lK1htaVVBYVNNQkx4eHNXZzlWd1NtSGJmYzAyckNqNndONU9R?=
 =?utf-8?B?L2RNam03bzJFL28xYWdhbS8wMElNeTIwRFpYelN2T1kySExIMGU2MERlWCtT?=
 =?utf-8?B?R1J4MkQreGdaRUJMRlFvU1VXWW53ckl2ZWRMTDdwZ1phZnMxUGtrcTFlaWRQ?=
 =?utf-8?B?Y3NOTDVMMjJyYVRqMVNuejJkQndGZ2N0cm1ndC9UZlNCV0NDZktSNlFIQVo1?=
 =?utf-8?B?cjNtMk9SWWtmb1RrOU4vVjNlOE5LTEhCSHpMa29idmtFc1VCWGdSL3BaZEdS?=
 =?utf-8?B?RjM0K0V4SllOd0ZmQzNnMVdLU0RmQlBCaG9nZk81Sk1EOWZBKzJnSUhOTHMv?=
 =?utf-8?B?b0FMYU9TSHFPQzdtTWRPNGNuZUx4NXdQSy8rdTFUNC9yUnZDeVd4YjZXL2xS?=
 =?utf-8?B?dmVXdzZsSnBsSS9DTTNRWFhseUZzRW5pNDJjdHloMVFJdW9wbWtORGF2dUdJ?=
 =?utf-8?B?eE9rRmVBNVc1WU9UdnRRdG9ZTmtMcEtCNzI3dEFicExHR0F5VFNGNEIvZzEr?=
 =?utf-8?B?YUNGQ2pWTEZQMTFrb2U0QWhpVmM2VkxMdGFxc1RmYXl3L01DdnVyeVM2ODFV?=
 =?utf-8?B?U0loOU5VdC9lNUJoVnZEWW1jU0hmVUJ2akIySUE1aGFOUWgwWWRYNVRoSFhT?=
 =?utf-8?B?akZ2R1gxaTFyVjlkdFRrMmxFQWhWRHRYYndaTDJRMndlM1o4QjRYM1F0UUVZ?=
 =?utf-8?B?U2xwZTN3MW1HM1dialJPZU5VWktPNk0zRE9yMUNjNEhMUW1LZ1lJUEh6SllU?=
 =?utf-8?B?OTkrbUxnM2xNaFlQMllEeXAvYmFjOTMwYXVjMVRwa0JQR2Fld21BVVJrV3RO?=
 =?utf-8?B?ejd5OENCc2N2VktNY25YVlJBVit5U2VoaEVLRFNFdkY2aE92RUt2dk5BMG9Q?=
 =?utf-8?B?T0xpNDRlanJyU2F2WVdMWmtER0sxZ0kxNlNKTisxYjFtMDAvV1FsWmNVYTI0?=
 =?utf-8?B?Y3VsR09tWHhINHhDbzRGcU1BMkUvSnNjUTVqSkp5Ti9mZFc5WHpBUHoxS1d1?=
 =?utf-8?B?T1Vya3Rmc2xzeE9EVkkwT291QjI1ZldLK2FRWjBZcHhzRFZWcy8zK1AzcG1w?=
 =?utf-8?B?blNGRFNHWjRwS0dubHdCYjNGM09iRlVSeTduZE0vbHpvWXEyYTRBTnUrb0NT?=
 =?utf-8?B?TTlZWDFqRjRnVXcrWVpMN2pEYWdmZTRubENsNW9YdjFKeHV2U3ptZWdoY09y?=
 =?utf-8?B?aU5uNXhqcUsweWRBYnhLdXRzZGdxUXh5NDZmZUpEUEdidDRIUktZK2gxa3Y5?=
 =?utf-8?B?MjJpQ3gyc0xZSXdFWGxUMXI4YXhEY1R1aTVUNmF2ZFdOa2tiYzIvU1NkVXlu?=
 =?utf-8?B?eWNteEwrd0xiNTF0MllqbGh5aEpPZk00eHlEY2RydmNMR0loazBicWZOUVRz?=
 =?utf-8?B?Sk1zcmRuNUFZR1o2Z1Ywbnpmc3lhcE5IN3Jza1UwdmNzRjJ6K3pBMXpzdWRX?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00E626A8EFB20242A8D3F1620226845D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc96e9a-397a-46eb-f2ad-08db4f13b580
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 15:57:07.0656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+NJ3E1OeSlyf2ZT0z+JGfl2tirRDS6O3ggzbsMbeXQkDbYzGEql2n+GwARvRzn6QzXdSdhI/aT1eeA5DofOi/aejj5A/2eRCAQEQypsmLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7082
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

T24gU2F0LCAyMDIzLTA1LTA2IGF0IDE3OjM4IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gU28gdGhhdCBtZWFucyB0aGF0IHRoZQ0KPiANCj4gwqDCoMKgwqDCoMKgwqAgaWYgKHB0ZV9k
aXJ0eShwdGUpKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHRlID0gcHRlX21r
c2F2ZWRkaXJ0eShwdGUpOw0KPiANCj4gaW4gcHRlX3dycHJvdGVjdCgpIGlzIGp1c3Qgbm9uc2Vu
c2ljYWwsIGFuZCBiYXNpY2FsbHkgc2F5cyAiaWYgZWl0aGVyDQo+IHRoZSByZWFsIGRpcnR5IG9y
IHRoZSBTVyBkaXJ0eSBiaXQgaXMgc2V0LCBzZXQgdGhlIFNXIGRpcnR5IGJpdCIuIEJ1dA0KPiB0
aGF0J3MgZW50aXJlbHkgcmVkdW5kYW50IHdydCB0aGUgb2xkIHN0YXRlIG9mIHRoZSBkaXJ0eSBi
aXQuDQo+IA0KPiBJdCByZWFsaXR5IHNob3VsZCBqdXN0ICdvcicgdGhlIEhXIGRpcnR5IGJpdCBp
bnRvIHRoZSBTVyBkaXJ0eSBiaXQNCj4gYW5kDQo+IGJlIGRvbmUgd2l0aCBpdC4NCj4gDQo+IE9m
IGNvdXJzZSwgbWF5YmUgSSBjb25mdXNlZCB0aGUgaXNzdWUgYnkgdGFsa2luZyBhYm91dCBIVyBk
aXJ0eSBhbmQNCj4gU1cNCj4gZGlydHksIGJlY2F1c2Ugd2UgKmFsc28qIGhhdmUgdGhhdCBlbnRp
cmVseSAqb3RoZXIqIGxlZ2FjeQ0KPiAiU09GVF9ESVJUWSIgYml0IHRoYXQgaXMgZGlmZmVyZW50
IGZyb20gdGhlIG5ldyBTVyBkaXJ0eSBiaXQNCj4gKCJTQVZFRF9ESVJUWSIpLg0KDQpTb3JyeSwg
SSBkaWQgdGhpbmsgeW91IG1lYW50IHRoZSBvbGQgX1BBR0VfU09GVF9ESVJUWSB3aGVuIHlvdSB3
ZXJlDQp0YWxraW5nIGFib3V0IHRoZSBTVyBkaXJ0eSBiaXQgaGVyZS4NCg0KWWVhLCBpZiBvbmx5
IF9QQUdFX1NBVkVEX0RJUlRZIGlzIHNldCwgYW5kIG5vdCBfUEFHRV9ESVJUWSwgdGhlbiBpdCdz
DQpwb2ludGxlc3MgdG8gZG8gcHRlX21rc2F2ZWRkaXJ0eSgpIGhlcmUuIFNvIEkgZ3Vlc3MgeW91
IHdlcmUgcG9pbnRpbmcNCm91dCBhbiBleGFtcGxlIG9mIHRoZSBnZW5lcmFsIHdyb25nbmVzcyB5
b3UgZWxhYm9yYXRlZCBvbi4gSSB0aG91Z2h0DQp5b3Ugd2VyZSBzYXlpbmcgaXQgd2FzIGEgZnVu
Y3Rpb25hbCBidWcuDQo=
