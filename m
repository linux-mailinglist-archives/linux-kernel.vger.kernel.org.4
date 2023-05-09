Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A246FBBE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjEIAOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEIAN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:13:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12B61BC5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683591238; x=1715127238;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L6Fs4zgKo7Wyfl9G0XHi1+e19C2hPl2UMvvegmbtLXk=;
  b=SzG4Us7UYDZCPeS/iEBF5J5xrj1k1vayGH/cfMmfbtlX1+GM2RymKbHP
   vKXYsZFGgO/fzx6/GoU6P8VoJSmVhBeOzVX3tqSLAGLLIjRmr4KAaXRfN
   NrdU8M/wpzVTN0CSGx2/qvg9Ol5y+755RukoXldpuTFAkPd83r8jvr1cm
   Tbi983clCtWhBUPWOvVbKy8hUnApj1bFbafsJWUUmyE+8BZn6uW1PB+dC
   urvdp34XhrMnMTHi2+RyNmq3O9ou4/GuQRMDxfM2o5uzvnjMqmPcC5fqS
   gDW/c7XCwVQLUiyAa2hMz+8tOceSJ9CMJVpjcmn03CCtgWHXcLUveV3hH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436098558"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="436098558"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 17:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="763603781"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="763603781"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 08 May 2023 17:13:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 17:13:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 17:13:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 17:13:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUPD8+V5I/QzT1QV+vpjCudaYWAhnzL01zKIUB2elSaqKL2qPfv2dT4g4fmWnf3SzztuIr/n1NGHUABitUsTULNa2UZl0jQgk3MFWPTar5zbdB2P49QT5MxjI/ms+CWrIyNckCWitVvMzCJNioFC6KR5knBN0J/Lco0Mdqo7CakFEmLdl7Onopn59Bra43TwpwNl1DwAc1ElkkHsU3lj/YW7OcgymlaorkMs8oR/wjwmYjZNY4X0vke/mvezwZ2JP8KDMp6xxXf97Wxtym2YXCPsvdBWdbTDKxufxIi6jFp6pNuhrBol3dLl6CsK3FHPRgdQizksttSt0So41yfr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6Fs4zgKo7Wyfl9G0XHi1+e19C2hPl2UMvvegmbtLXk=;
 b=a60ye1sP26RhrqejtctfGy0BnrksRNHSAWXxZJTGYZxEJCHvEn2C83T7LBjdaUAgUvB6rCR2opBohfZ1zJR6n+5DpD6gvgyvryfpMjjbOv1MyxGT2W9qHI59IUCb6CLFOIicmX77KoqjmLSOKUY51SQ2t3WfBtnVcazkm+mIJQy0z4g6ws8NhhKmXZzSRkPKf2rBlOa5aIHm1CTPdUempP9LRdSQzWQ2iBQ1T0xSMm7gSHPI40WNxBf9V9K54p0Lxancm8ysEh0K7tBcHGLrFH3CKg+yx2jr5jE3llmu/tpN9wCsKN7M1tIcbphl0TEG/hrLT2OmE6cvOB71weS7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 00:13:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:13:54 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: RE: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Thread-Topic: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Thread-Index: AQHZgB56n/zP0H2ZUUWJMwAk+LMxWq9NYqsAgABrcoCAAVu+AIABbW4AgAAAlACAAAPEgIAABi2AgAAzTQCAAEANoA==
Date:   Tue, 9 May 2023 00:13:54 +0000
Message-ID: <BN9PR11MB5276B168FF2BF15A4C55DEC48C769@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
        <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
        <20230506150741.2e3d2dcc@jacob-builder>
        <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
        <20230508094014.53913cf3@jacob-builder>
        <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
        <ZFkpk8y8mUZuZjkV@nvidia.com>
        <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
 <20230508132130.5a6feb0b@jacob-builder>
In-Reply-To: <20230508132130.5a6feb0b@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6995:EE_
x-ms-office365-filtering-correlation-id: 76263307-8abd-4fef-488b-08db50224693
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V6NJI5kQbr1WBJLz7ZgjYHTiip9LeOUos2kIUQWul47P7S7uvso5Exf+UQYYIgt3QQBpGj41D1AkfgBziLFO0ClUbEWhu98T00XoEpJD8dnjCzwpeWghvM9ozcOiwmUs96yxpAxStFuBDbpp0GLqiBvEqIeLe9+Ih4D7JHMx/GdhaNC0NtB9fkocFxdnLxC+UGmIAvCQ0j3Ec26v8bcrAOzfLDrGcN+grfn9JFSH5/8s5nVxgGnUUL/PvYMNfarT/vQNoiI7sSONIQSj6FSeMJFUjiJ8LO4k58SaDLd4u5+ITDtxWQ8OWQME4afXf4BnT54mVcxKU0PpSf/mgD748hPAiAi7fAaaXhDA4TXLEvIYDv1Hr2gRfoAfWbCuTGVUXW5iIU0G5QXDgUZAyQDr0cBfH08COWYtY85al/bXDgGhRgtuXnmK4ka8EaoQAyQHTZPS5OJAEURXfltUkgf07/1fFt4m7nl7ez+MX6Q4Rm6umGM054Mf8S8q5jlDVM3EKrVscY6dJCYMwcd5pCTMswEHb4kCqw0eit0L2JlZNE7uHAAG4huKQA6O7HaofG8dV1Ph3bXTEzJ/tfUxxY95ZASj+JbeZOGhmRsxN4GhM5S3FWDM6ADyUXR7Qqhspec6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(26005)(6506007)(122000001)(9686003)(82960400001)(38100700002)(66946007)(76116006)(86362001)(55016003)(2906002)(4744005)(7416002)(33656002)(8676002)(66446008)(316002)(5660300002)(110136005)(66556008)(54906003)(8936002)(41300700001)(4326008)(52536014)(64756008)(66476007)(7696005)(38070700005)(71200400001)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0R4VWJCMk9hKzhtNDBiM2h0VmVEZmxrN1BBcEN6UExueEFPMEpHTDlOWTRM?=
 =?utf-8?B?UzJoOHQvZHNLeHlsdWtoRnNCeThVZGFyeG5hV3ZWcGptSmhMNUtyODRKMFB2?=
 =?utf-8?B?L0NPWmlxSUc4NmlhU0RMRzNxQXEvdkdiZkVhSnhEZHc5VTdCY0wzS09Fa09m?=
 =?utf-8?B?Ym9NVnRGUUZKQWhVbGdxRjhJOEpJbGRrT01mTFJsK3VRdXUxTW9nNysyL01X?=
 =?utf-8?B?Y3QwT2NMTzZXOTh1bGJXRDlzczU0amduZVhPTkhqaHBOOWt3ZysyR3JWT2NW?=
 =?utf-8?B?blpkUGRIRElzSzQycTM2OGc4WExOK1IwRDBrK0lDSmE2NXVqd1FSd2JoSnJk?=
 =?utf-8?B?aTNrMzJyZVpsYW9Lb2cxU2Fnc3BpMklTazl0NC8vMkx3Z0M0UmtaelNQdHh1?=
 =?utf-8?B?R0lKd20zS1dIdkprOGdvU201ODBuYzJTbHZnajhwQWQxcXBhWmhxOXJzNDhL?=
 =?utf-8?B?SEkzUzIzZ1JKekJJenRkWTdoVkY3LzI0UCtSWGoyeDJXdHNFYWVOaTEzTWZT?=
 =?utf-8?B?d2dNcjJnbFk2QnpjTUhMWHRaUFgyd3pZbzZ0c0dEUTRDNzN6emdtS3E2d2VH?=
 =?utf-8?B?NTFNMlRuTnRKSDU2RWQwZDYwR1VXeGZoN1ZYYmV6TGRlZEcydGtzUXA0bzVl?=
 =?utf-8?B?a3prNHVzMk9DZUx1UkpIZDZmRmlPZUMwaUFTbG1WaldNeGlzWU00d2F4dXZz?=
 =?utf-8?B?citSM1paVWJVNjJjM3daUVZIOFI4U3U1bFVRMnUwWnBuZVlLU0srcHdBbUZu?=
 =?utf-8?B?dVNwZEZNZFhnYjdWLyttUTFjQ0dPeHliNTFmdnhtUTQwQSttYmlsd2F2MkZj?=
 =?utf-8?B?UzFoTmpwQytJOWVoQWtZL3d4bXJIdDRMdmxKNmhyTTFzVmZsaTEwYVY5RGtx?=
 =?utf-8?B?aXRiS0FoNWpqTFo4Tkc0T2s3YUhXdzczMTBjMnBXdk1rV2NhWnZXQkZBWGw0?=
 =?utf-8?B?Y21PQ0kvMTFWWGl3VXFPeWZuajlJanVYNUpib1lNUTk2SDlSLzBLc0w5VHpP?=
 =?utf-8?B?K3ovV0pnUWdRSGRuMEVZWC9Femp4TUVUSHlDTXFSWXYvcUFGczF3YmttN2V0?=
 =?utf-8?B?UFV2N3dkaDM2OVlNbjJDejFyYTVQdmVFWS8zbE1TVGVJRHJFVFBJVXI4NzJj?=
 =?utf-8?B?VmhzaDBNeHFUNm9KTWVUY0tHZkNleElBQ2VyaEZpby93dnljWDBFUDdzWnZD?=
 =?utf-8?B?ajR2alJHWUFnaUFhQ0UzdDBDVmdINUZlNHk4WFpSbjFoK2pKK1pKQStLbXRt?=
 =?utf-8?B?VDNkWUtnL2JwRXROOTNSa0Qrd3ljakpwM0lGY2wzblR4aFBEN1NXckVyREQ0?=
 =?utf-8?B?RUVMQUtLNFF3QnRTKzlqbUZLVVBBdjhtY0xINzVJNVhPYkdPZDFQdWI1TEVZ?=
 =?utf-8?B?eHNJQmVpK0lkZGovbG8rUFVkVEhKc3MxYVNuVUV6OWlaMVdFdzlFR2JrYmRO?=
 =?utf-8?B?OHFsdFlici9pM0lkSk43ZDQxdjEwbEdPcnBwazJDemxJaXpHellRNFZUai9m?=
 =?utf-8?B?bXZUNzJNbmNlb21wNXJFQmtuZXFKbFhwdDlOSWV2ZjZGZi9LYWhwZU5lazZT?=
 =?utf-8?B?UnFwM3VQelhRdmxFTSs3dUVZOEVFUEN1bmhhb0ZlYU01aUJ4SDJKQW8zd1RS?=
 =?utf-8?B?cnd2YTQzelpoYXF5WmhsMHlkUGhWWDBMT3RvT28wc0JTZjVtQ2R3QUMwbHh5?=
 =?utf-8?B?K2hvbXZrWXJQQ0ppS3VYNGR1UXdpdkFHU1lVajErenN6RXgzdklaRCtkeGtp?=
 =?utf-8?B?MDZITUlSTnJhanlmV2I5eFE3ZkNSemNzelFGd3pyUzlJM3pYbFczdFNGVTIz?=
 =?utf-8?B?bkdKeXh4bC9ZajgyOStIN254cnliakJZUUtrdklhQU9HTW1ySjdyOHVHQXN2?=
 =?utf-8?B?VFRNVDBUMTRoVXdGOTFUSkhEMGNGSWUvdkRhWlA4YmhPTXVxanl0SmVlc3Jn?=
 =?utf-8?B?VDZ6WTV4Z3RCN0RpZGlROHlxN1pNSXNHTHZnYnRTQ0h5TlFZMnZlQlpHTkUx?=
 =?utf-8?B?SEJVeGczY1JIT2dWbHlhZkxjRlVNZzhqQkRWMXhFLzlCZDR5cGd1YVBrRU5m?=
 =?utf-8?B?WDdHVXZSa2RVNlZBd0tDWFNaemRGYTRJVm1mUk5VaFFjSlg4WGtFa3RlYm9t?=
 =?utf-8?Q?BrKtxR5lq7B70LnqHs9q7MVCk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76263307-8abd-4fef-488b-08db50224693
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:13:54.5932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4AchgypEdtWv8edC/KvD/r0WUkwY1diJaUyASdzyAOaiI67RLcmsF7qGJ5HtqC4N1Lo2TGIRiiYmdyBTWHercA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBNYXkgOSwgMjAyMyA0OjIyIEFNDQo+DQo+IExlYXZlIHRoZSBuYW1lIE1NX1BB
U0lEIGFzaWRlLCBJIGFtIHRyeWluZyB0byBjYXB0dXJlIHRoZSBkaXNjdXNzaW9uIHdpdGgNCj4g
YQ0KPiBwYXRjaCBiZWxvdy4gSSBhbSBzdHJ1Z2dsaW5nIHRvIGdldCBhIGNsZWFuIHNvbHV0aW9u
IHNpbmNlIFNWQSBjb2RlIGlzDQo+IGNvbW1vbiBhcyB5b3Ugc2FpZCAiaGF2aW5nIGEgcGVyLW1t
IEFTSUQgZm9yIElPIi4gSGF2aW5nIHg4NiBLY29uZmlnDQo+IHNlbGVjdA0KPiBNTV9QQVNJRCB3
b3VsZCBiZSByZWR1bmRhbnQgaWYgaXQgaXMgYWxyZWFkeSBzZWxlY3RlZCBieSBJT01NVV9TVkEu
DQoNCkN1cnJlbnRseSBTVkEgcmVsaWVzIG9uIG1tLT5wYXNpZCwgdy8gb3Igdy9vIEVOUUNNRC4N
Cg0KRnJvbSB0aGlzIGFuZ2xlIGhhdmluZyBJT01NVV9TVkEgc2VsZWN0IE1NX1BBU0lEIGxvb2tz
IHN1ZmZpY2llbnQgdG8gbWUuDQoNCklmIG9uZSBkYXkgdGhlcmUgaXMgYSByZWFzb24gdG8gY29u
c3RyYWluIG1tLT5wYXNpZCBvbmx5IGZvciBFTlFDTUQsIHRoZW4NCndlIGNhbiBtb3ZlIHRvIGxl
dCBhcmNoIGNvbmZpZyBzZWxlY3QgTU1fUEFTSUQuDQoNCg==
