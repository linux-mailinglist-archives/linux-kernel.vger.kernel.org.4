Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DEF5FA48A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJJUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJJUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:09:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6ADEC3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665432584; x=1696968584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8gjrRhrfYdesn0diaAIe47OFCOSG5D2swWMqV2u5GUU=;
  b=Krs6P92f46hIlCFa8VXGRPTECAZkqBPOzaIuWltfDO3x+D74BRxH+k5Y
   /JEzGF+UvS0Bw6XTXoLP3qhINRKT8TxxysMwdb8quRS2RSuw/mXgMoYc/
   T8YQTsZb3Mrub2RabKVzjfP5Hq9v/e//lT9ZcBOwRgEcklAuIEtXlhOJ5
   b1Qvkw4iRn0UuLaGF5xWJqPCqK4oiHf1kV975+gLY+QMageZ15gkSkRlO
   j4c5btEGGPILy21N7+TutQIX5BJ2DC8X7FTGFMPpnagGtns5ldYDivcTV
   nMzKEcE8MteiOg/qaVhWpZj6ageM5M48VNWm7XuydxH3RHISoODlBrjog
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="390632844"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="390632844"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 13:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="751482249"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="751482249"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2022 13:09:42 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 13:09:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 13:09:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 13:09:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1vThf6bKwmVZcAOdrKI8E1A/K4E6enBeVMbzXt096XX4RV+/7s4ds+pn7BFx8Ai9Fq3q9Bt2FOBX2ySyh4eFdlMqWnSrTHnIrBe5okZ278JXjHjJianzRK4q/OezvLfqqrI0HTNyqhLvZATaWBH2+giYgUsmvtHa2SKmFWXYSdTAxXUHwtVcGwzION/CwktrkUTWak+n8FTmtcRhPjqasAQagKtJZN1f6owtiUJ0nWD+PvWANSlviP1X+VsEGasrUquECQ6kMHZc1x3mBlDsU2atW0qhzFQ5kzdP+cC9GlooPHse90rFxpllyiukgaopEajsDGrk1xe4Sdjy+ZPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gjrRhrfYdesn0diaAIe47OFCOSG5D2swWMqV2u5GUU=;
 b=QUoR35IJyamA/PoKN4hVGUFh5oDiYAczZYMwENtOAWy1lPxS2uN9F87ciI+cWpEURsvDPOyTaBnlbUc2p6kF92V/l4tvmBZw70G0hIMqxDEmK5umS1ZH32TUXhn9t26Ea5lvGaAkopqdl7mqluAuhPEyOkqqZ9Sql7KZCrzMl0KmVi32Ze8mN3YH3+eCz2KQREvx0QrcTXVWlLSQzO3vn2jOCV9+XEgQoa9glqXESdvQPeQ9npSq7WUrepJFnAzvg29DBr8FUUrGryL4TXVfywNV/ikiMpuyhO5udOeGQn3NC60w9C/HoYKxUeMs3gRtkaij7Y9Y5r1wKOTu0MvvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB5642.namprd11.prod.outlook.com (2603:10b6:510:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 20:09:39 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.040; Mon, 10 Oct 2022
 20:09:39 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "songliubraving@fb.com" <songliubraving@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Topic: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Index: AQHY2qcSuA+QF3WN10KzhnOoNUAfaa4H9+yAgAAKP4CAABD5AA==
Date:   Mon, 10 Oct 2022 20:09:38 +0000
Message-ID: <3842f1e7cfdde4f848e164872f62c0c1da654fec.camel@intel.com>
References: <20221007234315.2877365-1-song@kernel.org>
         <20221007234315.2877365-5-song@kernel.org>
         <af5c148fb3b9c56d1eb7e92b05db7c6c04bcfc3c.camel@intel.com>
         <B849A9FF-1054-4D5C-AEBD-72AED8B8F277@fb.com>
In-Reply-To: <B849A9FF-1054-4D5C-AEBD-72AED8B8F277@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH0PR11MB5642:EE_
x-ms-office365-filtering-correlation-id: b4a4d3c4-0d21-4137-6b0d-08daaafb5c64
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: njlkhNW64LwurcDGd5EXLfMGlq6Vu4BbWVdNgN/yP38U1/Ytg3BrfD6R9GgJQ/Ho4Ipwg+FEY0AfHISZ22BsNdwjXdxhGiLd1ufQk0ibTjRk4yCscSHDz+byNPa0T1OADIVk9c/E7cT2iMlmFoAcYHNYnloO8vl4Wiu1Q1UPbyVkm70onW3VYJoiwoBHN6r191Dl0LSxwNc9hJuSFYTsv74n2iOt6CDJ1WYVfDJlJPhyZM/wgHsZEc6h7MPaGqLlQ6PepRfk4iPc6e6ZxwxKrucAGstAoiGWDAyb0Zy3KdUCSoQGTkMVeGEJhLKCTvKFNpHSVP5j9mO9NA2OUBV7WVUwPWSHyko2QJKMiZ0rNc//u3splNepP+P2xHKjjuc5yiyt67c4Tav/xza5CikUiZV7ysM4VqjtdqDnIubKB64EdEiSRdHzy6MitlQTqdLQrmj6QDQ6m6Qt6oXRyiB0MFPAJCRb/N+cg1RFxCZxOIOUo2F6UGP7fmtzKZuUaeEEhNkzaUEzIvl9hnxO4Ecx6msR0rkTz5TIUZjde6UHlWv1SGRilrboh+UP3gEBCkuWp4urDSplS9f49RMyZ2oaQ7DMSbJXJ/GhQGdEwVod5XF39leu5E+7JDwdyqlDcDZUFAH+L2JP3dnlSpfNO1FsJ31SouRO1Qs7jrgYlK6wL0feU4kpaukkJQR+tyyoB5H1nmWvxb6sY9FyFrf3xLoIPKetz3f0EhJEx0Wo5w37T5gElWaskvtNsKYQhUW1ZNHjPJ66u+n09KkJg7shiEzDiHO3HGxf7ygT5rAORGYbp7lrHC9q5uv0KWaIbFK5u371
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(41300700001)(316002)(38070700005)(2616005)(53546011)(71200400001)(86362001)(6486002)(4001150100001)(2906002)(36756003)(26005)(6512007)(66446008)(4326008)(76116006)(91956017)(6916009)(54906003)(64756008)(66476007)(6506007)(122000001)(82960400001)(66946007)(186003)(8936002)(8676002)(38100700002)(66556008)(7416002)(83380400001)(5660300002)(478600001)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REVnSlZtaWM2cldZc3BUUGQ1OXFKVExiNUVMU01jY21McWFuMHV5MWpTZXpG?=
 =?utf-8?B?K2ZuV3RBaVpZQUNEdDNjVE5kcVlBdDR3aVpURi9pVHFWVEtuYXRKWTB3MG90?=
 =?utf-8?B?TXlLeXVPclF2Z0JrOXdGTERrZkVQRHZlem13QjVJL3B4ZjNXYUk4Nk1HQitm?=
 =?utf-8?B?WnpvRy95SjNoTDVqOG9hYjdkamptdVFtUDRsV2pTZHFlZVp6ZEcvaUJ3STVx?=
 =?utf-8?B?Q2dZeHd1dXU0WElXTnBOcnRkQVAwUitDOU5nZUhvK09ZR0JKTVg5S1dLRXBE?=
 =?utf-8?B?ZmprZ1FHWlVJTVR4clArOURCTTBVOXh0VTFrNnArTUF2bFFhRGtEYkN0ZDNh?=
 =?utf-8?B?bVk3cWQ4NVhCSHlRM1RnZHl3cTFuUnM1UGgwdUZRQWZzNEJsYVc2Z3JNc25X?=
 =?utf-8?B?RFhIRHp1Rm5ZVnBxTGhYRDJtWlg4Snp2MUhVUVVMTkVjRHI4MEh6bUVlUWl6?=
 =?utf-8?B?QThENHVNdVZmTnk4cVlxRnh2QXdUYkFjK0tvWE4wNkhNbTdJSEV6SnYzVzY0?=
 =?utf-8?B?UDNMb3F0SlErbFZtM21SOE1NRTJJdThCVHNQQVRmbHlpZjZtdDdVcmw5RVlC?=
 =?utf-8?B?cVFuWDZyOHZXUXIrRWU4ejY3M3ZoZ0VGNzFLNzQwck9Wc2xFWjZRZ2wrODJh?=
 =?utf-8?B?NGZvb1ZlY1YrTk5HMjBlR2g2Sm84NGxvZHZBWWppWnZDMmR6aTdQSmR3OEhl?=
 =?utf-8?B?WkRjWkJmNzJ6U3NSREZJeUhyY3BZV2sybklVSlZWSFBDV3hJajY3ZUNnaWN2?=
 =?utf-8?B?Y3Zab2wwZjFXQU9Ra0dpbXJHbkRrVW5mazIzbjg5clg4ZDFvMGNFS1R0ZVRY?=
 =?utf-8?B?RTVVM3laZmVveDNUR2x6WU53MDd0OURhT3pabTFLNTQ4T1JrUnVPN2M4a1pW?=
 =?utf-8?B?Z28vY1RuaWlOaXlKSzlvUCt0N2U3WVdhMktlaExSbFhTVWtrbXJuTDBILzJw?=
 =?utf-8?B?S3RxSWRoTkxTV0NPb1FWYVVJMm1JTS91cUhkUmFwQmNIZ3dwRGNSSyt1MktL?=
 =?utf-8?B?WDk1V0o1YlpOemQrL2FPdnEyNkU5cHRHYStIVWhMdFlrZExlemdkeS9obHEx?=
 =?utf-8?B?RmUzNkh1UEJFb2w4UHNRZG9tQzdCMm9QZnFiV0haQVo5MFJ3dCtoMDZzK3RZ?=
 =?utf-8?B?WnR3Rmt3d3I0eUVpMHh4S3JhQzdPM3g3RFVKYzArNkRTc3lEdkNZU3VWKzNU?=
 =?utf-8?B?eU92MWlXNyt1Q1p1ditSclU1d1E3b1RqMmhOdUE2bGE4SG5vY0FrUFFyY0o0?=
 =?utf-8?B?Z3Z2aTVZOVdFbGlGRDc4Uks0b25RU2FtQmVMNW0xM1I4Snp6SWtEdFZZNzRj?=
 =?utf-8?B?UVVvQlRESmthODM3ZlZFV2I1eEM0a2xvdXVlMnpwMEdXdEdMaWJRUEdGMTZL?=
 =?utf-8?B?TTNhNlJDMWx2V1BqbjlsQlU4ZTZwR3BrWGY3M283R0FFUGRpRFZVQ2FuYmd1?=
 =?utf-8?B?M3NDYXRCMnJsZitnSWxMYlhpcFpjYUpKWlJmckU3dUltMTBCbE5LZ3lnZDYy?=
 =?utf-8?B?TWRCVGxTaTVVdmJsRDVmWXZWZTdUSTBTOG1HbDkxampTYmNqMFMwUzdEUlUz?=
 =?utf-8?B?TXRxQUJRNTFnSVJTZDdSU0Rka2gwWFJFSCtrSnFWYkNHSTRZMVdvM0dxRk9N?=
 =?utf-8?B?YVFRK1JsQzVkdWpDUzFpaWN2bG9rMnM3Smx3Y0ZYY1NVUVBiSEMzR0JMc2hr?=
 =?utf-8?B?a0pEaWF2VGJ2NE5vR3RYSWt2K3ZpbHllTHVFdGJ6YjgrL3NFaDJCT21qV2dU?=
 =?utf-8?B?TVdNL054ZWRwL0YyanFadUlmeGU5NWF5cXZWaVVSV3RCaEZISFN1T1ZRcUhm?=
 =?utf-8?B?VERuYW8xRjdHdFlkbFltVDgyekFkMm1GaW1KRkdNSmxSVHllNTBqL0hhdnV4?=
 =?utf-8?B?NjQ4TitKV0M1YU9KWmI5MEFCUzMxQzkwVWV6SUU2SHYzUUZwWFdGUTNDY3k2?=
 =?utf-8?B?K0FsTG5QekN3aVRydllvZy9HTWNJdDFaOU9VRnRrMnlMaVRzNVZ4Y3NkNmRv?=
 =?utf-8?B?eURHMTFOUEhFYlY5WGVwU0VPcVlOWWRUc00yanhLWkRUVFBEOThrTHRNeTJm?=
 =?utf-8?B?a0thMXJHTE53bEJlaytoWU9BSUczWU14YUpjdjBCWTJhT3BhV0FmL0JoTlRo?=
 =?utf-8?B?WVlkRVBUUGVhWHRZZjUwZDV0THN3VEhTWC8vd2EyaElpNWFzNmh5eFJ5N2lv?=
 =?utf-8?Q?1S/8wjdrlRxpsK3hrRxlJrc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E7521271324914A9CCF4F7DCB38F0A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a4d3c4-0d21-4137-6b0d-08daaafb5c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 20:09:38.9475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y16/F0dFQKJcDtVUbmmDp25BGnY1NM3NigYPE5DiZhCJeyVbLekhskyQw5aRmSigw8zDnMmLNrMQa/Ttb/XizBzB+u2wZk5HZqtKylKldYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5642
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTEwIGF0IDE5OjA4ICswMDAwLCBTb25nIExpdSB3cm90ZToNCj4gPiBP
biBPY3QgMTAsIDIwMjIsIGF0IDExOjMyIEFNLCBFZGdlY29tYmUsIFJpY2sgUCA8DQo+ID4gcmlj
ay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyMi0x
MC0wNyBhdCAxNjo0MyAtMDcwMCwgU29uZyBMaXUgd3JvdGU6DQo+ID4gPiBPbiB4ODYga2VybmVs
LCB3ZSBhbGxvY2F0ZSAyTUIgcGFnZXMgZm9yIGtlcm5lbCB0ZXh0IHVwIHRvDQo+ID4gPiByb3Vu
ZF9kb3duKF9ldGV4dCwgMk1CKS4gVGhlcmVmb3JlLCBzb21lIG9mIHRoZSBrZXJuZWwgdGV4dCBp
cw0KPiA+ID4gc3RpbGwNCj4gPiA+IG9uIDRrQiBwYWdlcy4gV2l0aCB2bWFsbG9jX2V4ZWMsIHdl
IGNhbiBhbGxvY2F0ZSAyTUIgcGFnZXMgdXAgdG8NCj4gPiA+IHJvdW5kX3VwKF9ldGV4dCwgMk1C
KSwgYW5kIHVzZSB0aGUgcmVzdCBvZiB0aGUgcGFnZSBmb3IgbW9kdWxlcw0KPiA+ID4gYW5kDQo+
ID4gPiBCUEYgcHJvZ3JhbXMuDQo+ID4gPiANCj4gPiA+IEhlcmUgaXMgYW4gZXhhbXBsZToNCj4g
PiA+IA0KPiA+ID4gW3Jvb3RAZXRoNTAtMSB+XSMgZ3JlcCBfZXRleHQgL3Byb2Mva2FsbHN5bXMN
Cj4gPiA+IGZmZmZmZmZmODIyMDJhMDggVCBfZXRleHQNCj4gPiA+IA0KPiA+ID4gW3Jvb3RAZXRo
NTAtMSB+XSMgZ3JlcCBicGZfcHJvZ18gL3Byb2Mva2FsbHN5bXMgIHwgdGFpbCAtbiAzDQo+ID4g
PiBmZmZmZmZmZjgyMjBmOTIwIHQNCj4gPiA+IGJwZl9wcm9nX2NjNjFhNTM2NGFjMTFkOTNfaGFu
ZGxlX19zY2hlZF93YWtldXAgICAgICAgW2JwZl0NCj4gPiA+IGZmZmZmZmZmODIyMGZhMjggdA0K
PiA+ID4gYnBmX3Byb2dfY2M2MWE1MzY0YWMxMWQ5M19oYW5kbGVfX3NjaGVkX3dha2V1cF9uZXcg
ICBbYnBmXQ0KPiA+ID4gZmZmZmZmZmY4MjIwZmFkNCB0DQo+ID4gPiBicGZfcHJvZ18zYmY3M2Zh
MTZmNWUzZDkyX2hhbmRsZV9fc2NoZWRfc3dpdGNoICAgICAgIFticGZdDQo+ID4gPiANCj4gPiA+
IFtyb290QGV0aDUwLTEgfl0jICBncmVwIDB4ZmZmZmZmZmY4MjIwMDAwMA0KPiA+ID4gL3N5cy9r
ZXJuZWwvZGVidWcvcGFnZV90YWJsZXMva2VybmVsDQo+ID4gPiAweGZmZmZmZmZmODIyMDAwMDAt
DQo+ID4gPiAweGZmZmZmZmZmODI0MDAwMDAgICAgIDJNICAgICBybyAgIFBTRSAgICAgICAgIHgg
IHBtZA0KPiA+ID4gDQo+ID4gPiBbcm9vdEBldGg1MC0xIH5dIyBncmVwIHhmc19mbHVzaF9pbm9k
ZXMgL3Byb2Mva2FsbHN5bXMNCj4gPiA+IGZmZmZmZmZmODIyYmE5MTAgdCB4ZnNfZmx1c2hfaW5v
ZGVzX3dvcmtlciAgICAgIFt4ZnNdDQo+ID4gPiBmZmZmZmZmZjgyMmJjNTgwIHQgeGZzX2ZsdXNo
X2lub2RlcyAgICAgW3hmc10NCj4gPiA+IA0KPiA+ID4gZmZmZmZmZmY4MjIwMDAwMC1mZmZmZmZm
ZjgyNDAwMDAwIGlzIGEgMk1CIHBhZ2UsIHNlcnZpbmcga2VybmVsDQo+ID4gPiB0ZXh0LA0KPiA+
ID4geGZzDQo+ID4gPiBtb2R1bGUsIGFuZCBicGYgcHJvZ3JhbXMuDQo+ID4gDQo+ID4gQ2FuIHRo
aXMgbWVtb3J5IHJhbmdlIGJlIGZyZWVkIGFzIHBhcnQgb2YgYSB2ZnJlZV9leGVjKCkgY2FsbCB0
aGVuPw0KPiA+IERvZXMgdm1hbGxvYyBhY3R1YWxseSB0cnkgdG8gdW5tYXAgaXQ/IElmIHNvLCBp
dCBjb3VsZCBnZXQNCj4gPiBjb21wbGljYXRlZA0KPiA+IHdpdGggUFRJLg0KPiA+IA0KPiA+IEl0
IHByb2JhYmx5IHNob3VsZCBiZSBhIHNwZWNpYWwgY2FzZSB0aGF0IG5ldmVyIGdldHMgZnVsbHkg
ZnJlZWQuDQo+IA0KPiBSaWdodCwgdGhpcyBpcyBuZXZlciBmcmVlZC4gDQoNCkNhbiB3ZSBnZXQg
YSBjb21tZW50IHNvbWV3aGVyZSBoaWdobGlnaHRpbmcgaG93IHRoaXMgaXMgYXZvaWRlZD8NCg0K
TWF5YmUgdGhpcyBpcyBqdXN0IG1lIG1pc3Npbmcgc29tZSB2bWFsbG9jIHVuZGVyc3RhbmRpbmcs
IGJ1dCB0aGlzDQpwb2ludGVyIHRvIGFuIGFsbCB6ZXJvIHZtX3N0cnVjdCBzZWVtcyB3ZWlyZCB0
b28uIEFyZSB0aGVyZSBvdGhlciB2bWFwDQphbGxvY2F0aW9ucyBsaWtlIHRoaXM/IFdoaWNoIHZt
YXAgQVBJcyB3b3JrIHdpdGggdGhpcyBhbmQgd2hpY2ggZG9uJ3Q/DQoNCj4gDQo+ID4gDQo+ID4g
PiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+DQo+ID4g
PiAtLS0NCj4gPiA+IGFyY2gveDg2L21tL2luaXRfNjQuYyB8ICAzICsrLQ0KPiA+ID4gbW0vdm1h
bGxvYy5jICAgICAgICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAyIGZp
bGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2luaXRfNjQuYyBiL2FyY2gveDg2L21tL2luaXRf
NjQuYw0KPiA+ID4gaW5kZXggMGZlNjkwZWJjMjY5Li5kOTRmMTk2YzU0MWEgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9hcmNoL3g4Ni9tbS9pbml0XzY0LmMNCj4gPiA+ICsrKyBiL2FyY2gveDg2L21tL2lu
aXRfNjQuYw0KPiA+ID4gQEAgLTEzNjcsMTIgKzEzNjcsMTMgQEAgaW50IF9faW5pdA0KPiA+ID4g
ZGVmZXJyZWRfcGFnZV9pbml0X21heF90aHJlYWRzKGNvbnN0IHN0cnVjdCBjcHVtYXNrDQo+ID4g
PiAqbm9kZV9jcHVtYXNrKQ0KPiA+ID4gDQo+ID4gPiBpbnQga2VybmVsX3NldF90b19yZWFkb25s
eTsNCj4gPiA+IA0KPiA+ID4gKyNkZWZpbmUgUE1EX0FMSUdOKHgpICAgICAgICAoKCh1bnNpZ25l
ZCBsb25nKSh4KSArIChQTURfU0laRSAtDQo+ID4gPiAxKSkgJg0KPiA+ID4gUE1EX01BU0spDQo+
ID4gPiB2b2lkIG1hcmtfcm9kYXRhX3JvKHZvaWQpDQo+ID4gPiB7DQo+ID4gPiAgICAgICB1bnNp
Z25lZCBsb25nIHN0YXJ0ID0gUEZOX0FMSUdOKF90ZXh0KTsNCj4gPiA+ICAgICAgIHVuc2lnbmVk
IGxvbmcgcm9kYXRhX3N0YXJ0ID0gUEZOX0FMSUdOKF9fc3RhcnRfcm9kYXRhKTsNCj4gPiA+ICAg
ICAgIHVuc2lnbmVkIGxvbmcgZW5kID0gKHVuc2lnbmVkDQo+ID4gPiBsb25nKV9fZW5kX3JvZGF0
YV9ocGFnZV9hbGlnbjsNCj4gPiA+IC0gICAgdW5zaWduZWQgbG9uZyB0ZXh0X2VuZCA9IFBGTl9B
TElHTihfZXRleHQpOw0KPiA+ID4gKyAgICB1bnNpZ25lZCBsb25nIHRleHRfZW5kID0gUE1EX0FM
SUdOKF9ldGV4dCk7DQo+ID4gDQo+ID4gVGhpcyBzaG91bGQgcHJvYmFibHkgaGF2ZSBtb3JlIGxv
Z2ljIGFuZCBhZGp1c3RtZW50cy4gSWYgZXRleHQgaXMNCj4gPiBQTUQNCj4gPiBhbGlnbmVkLCBz
b21lIG9mIHRoZSBzdHVmZiBvdXRzaWRlIHRoZSBkaWZmIHdvbid0IGRvIGFueXRoaW5nLg0KPiAN
Cj4gSG1tLi4gSSBkb24ndCBxdWl0ZSBmb2xsb3cgdGhpcyBjb21tZW50LiBJZiB0aGUgZXRleHQg
aXMgUE1EDQo+IGFsaWduZWQsIA0KPiB3ZSBjYW4gc3RpbGwgdXNlIHZtYWxsb2NfZXhlYyB0byBh
bGxvY2F0ZSBtZW1vcnkuIFNvIGl0IHNob3VsZG4ndCANCj4gbWF0dGVyLCBubz8NCg0KTWF5YmUg
dGhpcyBkb2Vzbid0IG1hdHRlciBzaW5jZSBQTUQgYWxpZ25tZW50IG11c3QgaGFwcGVuIG5hdHVy
YWxseQ0Kc29tZXRpbWVzLiBJIHdhcyBqdXN0IG5vdGljaW5nIHRoZSBhdHRlbXB0cyB0byBvcGVy
YXRlIG9uIHRoaXMgcmVnaW9uDQpiZXR3ZWVuIGV0ZXh0IGFuZCBzdGFydF9yb2RhdGEgKGZyZWVf
aW5pdF9wYWdlcygpLCBldGMpLiBJZiB0aGlzIHdhcw0KbmV2ZXIgbm90IFBNRCBhbGlnbmVkIHRo
ZXkgY291bGQgYmUgZHJvcHBlZC4gQnV0IGlmIHlvdSBhcmUgZ29pbmcgdG8NCmFkanVzdCB0aGUg
YmVoYXZpb3IgZm9yICFDT05GSUdfTU9EVUxFUywgZXRjLCB0aGVuIGl0IGlzIHN0aWxsIG5lZWRl
ZC4NCg==
