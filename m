Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37B35F9769
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiJJEcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJJEci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:32:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0366432055
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665376357; x=1696912357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/f1HZY6g9IGaly4Pl32InWG+KlYim73E27Nq/wIh7TU=;
  b=NJx7E8Yq68rLoBzgQEcIy6i6TMCcYD+s4ic+uA7wK6qViHCpZETswDt+
   5sbcxt+gtRlxmBzSTjM0BXVbXwTpTNeLK1dh269fYDLRaHqgVyZfUB2xz
   PFUE12KzL9/4kVkUrQuUWn+ljWar8ErcKMPv0CQQu+bKvUyVGa6yaSzC4
   i8BApaadgk5iKCWxz+2vXbQx3CjTBqVM7/KqEmK9aN46gLgVkIYEmLlas
   aWt+Zpgh1U9YdRXELfB5dapVDkFydcoNdCOnOENsA4y+L/O0id67OiAgi
   uj7TrbWlow3NQz8nSWb7CQl3c912Y1YlnxUi+b2i5sgq7zPdK+buLWQhi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="283864651"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="scan'208";a="283864651"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 21:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="694492355"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="scan'208";a="694492355"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2022 21:32:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 21:32:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 9 Oct 2022 21:32:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 9 Oct 2022 21:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOvO9zdVenvtoErD4QLhI2C2iHWALdHt9pBbccQflx0p+JPW0OJ2ZuGCI42eAaHh5T6GA/8YfvYhQHaLA67Z3qP2S0DNLcEe5KqPzDUruPLIMnLUv2OQ+H6GWEL4zY501QcLTWlXE8hBeEj7PaCV1Cu1Bb7KSS3UJ+3nbQSI3j2UTfGdla2UjVOfO7eILk9MpUT7B0mbZdk8c121kdGx2jTJ02JFjSYkjx1TzxtyxoiTCApun7Jd+TcDdIxjcb1ZWjap5o53S4N4Epfmacpyyn31+xK688ChGOC1Lazf98xgVvHtq+lQZQyGzgwb6CuCRTpbkdxUk/OahGozb0KdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f1HZY6g9IGaly4Pl32InWG+KlYim73E27Nq/wIh7TU=;
 b=WKUkx93ZEhqDUtM801VmfMxugJXMYQqhkfJmh2oN0M37Sx2rp/yirgErAd08RLkvVPE4M8vl1qWAEq6GnH9hDOYXpqkasdsp1IlpJ4Vn9uyFnApPxU9NwFktQkpJxOOgq5PMwuY/c6/i9zjPr91bgNRBtPGSw5oXnGH+aNFjAdfe5+e++vrONImi7EFwM4WOU9i/piHQf1S3vq1131i0ocxtRWNdYqBNAX9EDtEGadruUgnVs3W9Fz65OYq7F9DlksPvzygvxs3jxjANGARRCTwTRJbZlyBU5zCaSgaYoH5c8NmAUMbF0PVJPPMlnQ91+rtCe9zooxPLQh2mKC+h+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 04:32:35 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5709.015; Mon, 10 Oct
 2022 04:32:35 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Brian Gerst <brgerst@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Topic: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Index: AQHY2Z1YsyE3enznIkOfLcepaehVE64DHbeAgADe43CAAHZbAIACmXPA
Date:   Mon, 10 Oct 2022 04:32:34 +0000
Message-ID: <BN6PR1101MB2161FFEB80E3D3AE06035384A8209@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <CAMzpN2iccL5kNa2UaBXppiLnoNWrpwJd74+uBrB_63N0F5F5Xg@mail.gmail.com>
 <BN6PR1101MB2161E1191DF1BD0135DC3947A85E9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <CAMzpN2i52orTgPqRARoCkuA=c2GEyWXLscrFRgDkb0LoFV01Rw@mail.gmail.com>
In-Reply-To: <CAMzpN2i52orTgPqRARoCkuA=c2GEyWXLscrFRgDkb0LoFV01Rw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|SJ0PR11MB5772:EE_
x-ms-office365-filtering-correlation-id: fa6aacb1-c716-40a6-1033-08daaa78744b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tootbqGfHo3OHjf2dB7zsWGDfeoV4bof+T+uIMc/i56eGnS3N4IDH/G2rJlfuyAmhAx3gtl2vr4cZsyMIMozzj/CfWCFva/nTdGDb6U3CbMxqnDcDHsQUIBe8VAvWLjUlm/tY4oPHt/iCB/hs5VM0hKjxmIfYYY6Lm9gxj2ysMg8PTp9qeTf+SW4a6PfubKmYYlusjOzchgOlw+EG6yCnK+yN9jW1ifRYGF2nRD4CtIyx8Eq91OWO5/GAg1V8w56s3IPtkqAU3O+kXphxqbKaFnCAnD6N1/EmY+ugqalL/aobHZ/eGovUNzDzrPWQIOQw9ROJJ1X38GFOmi4wOShEFYtS8oDL/FQl1/YCKarGO+mraPLik/xHrY6hOUNEG7nv5MOL0l/ZXdYvw97mKwgioDOipmwhFpbsd734l0AGFY0mxGh/UExVZ1ljIxllZJ6U1g4uBz4EL4wKkGhII1M7t3OPyIyLivkFbEkSyk+YFqsgXeRGEJD3xGLz1xdo91vHOni7rTZ3f2nftrVkJj56K+uaFt3i2gsAsAFMjFvrvQVlOgrMtyZRYM6QicV3QJeWiDRw5FDiJeyHkEM9mH46yZnI01Np7iNYzmxVhzQ+bAkS5QYVquxLZAt8zVMEXox3f+TG2mADtWeH2sMB6PIjnP6lETbBcTw0Ko+ZxdQFXsNHmFLnOlusF1O0OwSPpkb0YPkSk8YTOh5EKd+Gxerf3pKCXu0qd9ihEsiuFE+AfWbzxZlXNhjyOWfMgZYDosjDMwOl9jzdmTCU3lviYo8sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(6506007)(7696005)(26005)(66946007)(82960400001)(38100700002)(8676002)(55016003)(122000001)(76116006)(66556008)(66476007)(316002)(71200400001)(86362001)(4326008)(66446008)(64756008)(38070700005)(33656002)(186003)(478600001)(9686003)(2906002)(52536014)(6916009)(54906003)(5660300002)(41300700001)(4744005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2FUa010VXNPMUt4TzVvTjJtZis5Uk9ROEJ0dkc1MGJwNnc2WGFzUkdIVTlO?=
 =?utf-8?B?dVppeWhWYjUwVUVxSi9JTnlLdU9DZXB6bnZyV0RRQmZQdVlsYTJGZkFqTGpp?=
 =?utf-8?B?VlMyOGxGSnRvKzMvbXUweklFYUM0UnNJTnlZT0VKMFpCOURONmFkR2E1WEpG?=
 =?utf-8?B?YThzaXErNjVVUHFpdTRhbUVnSUV2WEcvOWNadDEwUlRaNEV1MHlNd241M3hQ?=
 =?utf-8?B?cE1ZZ2V1NWRCVGJZN3BiY2xCeXFQc3ZBZ0gvMjEybUNpVkY0Vy9yWGpuWjFT?=
 =?utf-8?B?MkN1YlhHTC9Jb3VzcnllLzA1WW10YnFLQmtkQXpMckpsZTNkU0l6akRYNFVD?=
 =?utf-8?B?OWVQSnBwRzB2ekx1U2xocDJuQ0QyK0E3bUNNTm9qc1ZYbmhNc1UxcFJjLzJ5?=
 =?utf-8?B?d2xKeHUwUG50N2p4ck5kSFYzK0dIaXNwQnBsem0yRlIzSHE5bHNjNEhTVUpy?=
 =?utf-8?B?UWxTSzI1T1VjS0ZzU21FMzFWekkvRzcwdDdqZ2VWbkF1bTc3Y2dlVjRBNnF0?=
 =?utf-8?B?S1BQVW5CTkt5TjNCUG1YWFJlWFJwWnRkMXVyT2ZUVE4rUjB0VUUrOUpJNkg2?=
 =?utf-8?B?R1NFZXhOS2hKVzYxdHNIZk01QlMvTVVadHdsZVg4eVRHbFFFS3FkLzFBUDF3?=
 =?utf-8?B?bVZxdUpyU3ljQUFjYVdxald6b0VFTTZSdm1sVndoRUhBNE1ZNTlwRllVMHNR?=
 =?utf-8?B?NEFnOFczVnhja3BrZndaTlVNczByeWtYSlduLzM4NGFWTitwWWFiSHlvSHg2?=
 =?utf-8?B?ckw3UXBDc0RXaHFJV0xRbi9vem5TT1lyRTBTbG4wMXZ0dHBPSXNiNVpKRUI2?=
 =?utf-8?B?OTl0OUV6aVUyLzV6ak9zM1FLSXJla0JPSHE3U1o2OG1jMlV0NDFZM3VRTGtG?=
 =?utf-8?B?aERWcHZhT1JCN25LWGlzVE1LQUtHYmhyYnFhcGduZFdWQ2FHU3RBTC9NdytJ?=
 =?utf-8?B?QlNFVm1tbUFnc1BxYkJPRFUrQXB5SVdWMk16M3JNOCszN1F2V2J5cVBSRWU3?=
 =?utf-8?B?aEd4VjN3LzNKeEgvR0dTSitHVnphcDF3ZWlhclAwOTd3REpCSThNcUg1TG1I?=
 =?utf-8?B?ZXU2OHdLMSt3ZFNJaUdnUjZTeHh6WjZQR3c1MWdHVnA1aU9PRlBqNmk1S0dN?=
 =?utf-8?B?SHFtRjNLTmdENGVlODRmeWdaeGpCK1hla3JrdThVaHd5ZDBITG13ZWgrZkMy?=
 =?utf-8?B?dDY3eUU0WS91STEzQUtjUGUyQkpyeSt1Y0dDMmYxWnQyUmR0bEhFd25GandP?=
 =?utf-8?B?Q3NGN2hqamxsVnZpbVJoNDdLVEgrOC9iVURGT0Rtd3Zqck01ZXFMVjhUNkxt?=
 =?utf-8?B?ZXBYR3FJSnAxTnFsUGFuSTlQcnFUSWQ2NUltU0Z3RFBXcGtHM0JPRXBNeVpv?=
 =?utf-8?B?S1JBU1RsVnRhQlg0cWEvU1VSNFErZzRmenVJaDE5cmdtMC9uS3B6dktiRFFx?=
 =?utf-8?B?cnRuelpWMVFaYmRSRkh1VWx5SURQYk5pSThXK0lOZnF6NEdkRVpyYzRpb09Z?=
 =?utf-8?B?TkNSMWFLaDBOK0NsNGRndzJCRDlIcUNZczkrQVBCdFRsSTF2a2dYK092ZzRN?=
 =?utf-8?B?YzZobEtJdk9ydGdhZlZreGFMMVduVFZ2WnZQdUFyMXpLbGpVWmEvNlMwWCt4?=
 =?utf-8?B?VHR4bklJREhjRUxWNlhkMVZINDI1VlBZcDVwdVIrQTg2b1RLZFRhVzBGdURC?=
 =?utf-8?B?V3VDRUVUditRTDZ1TExiQ2ZTR25zYVF4RlVTZ2VnZXd0cHJHcXhQZXd3SjNx?=
 =?utf-8?B?enp5MXhMU1FVcFl6Vm0vYjZDakN5TDFrNEE3NWxjNHNJUjltRkNHcXo1Q2Fk?=
 =?utf-8?B?MmcvL0xwTlZoSDg3VW04SEVsd2ZXWVlKZWlCU3Zsa203L21CQTZLNTVydXd2?=
 =?utf-8?B?WS9IM1dIbFlOZnFLT2U5K0hIa3FIQTNvOUZoTWpTRldlMkpNYk1XVGM0bDVn?=
 =?utf-8?B?bVFNOHliNEFMdll6UVpZa0EwMnlMdHQxL3NGYTJUbHlGb1BJRWNVWTM4YkdF?=
 =?utf-8?B?c2pyQmtNeTRqWjQzZ2owZWFCMGlHVWIrenZzVnVjN2tpMVJGTEtwMm94d2No?=
 =?utf-8?B?L3UyRHhlMmlENXJZd1J2Z1hYWW9NbmlNY1ZRYnhrMTk2ZGc5ZlBEWkNsZHhP?=
 =?utf-8?Q?/MhM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6aacb1-c716-40a6-1033-08daaa78744b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 04:32:34.9907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAZekgwYsX1KewbdjUTzNyrc3eK1dS0sFDKcFcml5HoPkIg64VSxuzCfKhp47UprQb/FmlclaJiZDDCOWavFMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gVGhlcmUgYXJlIG5vdCB0aGF0IG1hbnkgY2FsbCBzaXRlcywgc28gdXNpbmcgc29tZXRo
aW5nIGxpa2UgdGhpcw0KPiA+ID4gKGluY29ycG9yYXRpbmcgUGV0ZXIgWidzIHN1Z2dlc3Rpb24g
Zm9yIHRoZSBleGNlcHRpb24gaGFuZGxlcikgd291bGQNCj4gPiA+IGJlIGJldHRlciBmcm9tIGEg
Y29kZSByZWFkYWJpbGl0eSBwZXJzcGVjdGl2ZSB2cy4gYSB0aW55IGluY3JlYXNlIGluIGNvZGUg
c2l6ZS4NCj4gPg0KPiA+IFRoZSBleGlzdGluZyBhcHByb2FjaCBwYXRjaGVzIHRoZSBiaW5hcnkg
Y29kZSB0aHVzIHdlIGRvbid0IG5lZWQgdG8gY2hlY2sgaXQNCj4gYXQgcnVudGltZS4NCj4gDQo+
IHN0YXRpY19jcHVfaGFzKCkgdXNlcyBhbHRlcm5hdGl2ZXMgdG8gcGF0Y2ggdGhlIGJyYW5jaCwg
c28gdGhlcmUgaXMgbm8gcnVudGltZQ0KPiBjaGVjayBhZnRlciBlYXJseSBib290Lg0KPiANCg0K
U29ycnksIGRpZG4ndCBrbm93IGl0LCB0aGFua3MgZm9yIHBvaW50IGl0IG91dC4NCg0KSWYgd2Ug
cHJlZmVyIHN0YXRpY19jcHVfaGFzLCBhcmUgeW91IGFza2luZyB0byByZXBsYWNlIGFsbCBhbHRl
cm5hdGl2ZSBtYWNyb3Mgd2l0aCBpdD8NCg0KWGluDQoNCg==
