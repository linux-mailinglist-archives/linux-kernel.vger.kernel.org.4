Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA1263FE66
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiLBDAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiLBDAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:00:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896E1D0392
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669950032; x=1701486032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bEMYf/Uux+mo+CUrZeBzY0tg+Akb3JPZFkazD/IH8C8=;
  b=CTtN3pQcq3FjlulkfPM43QxarSPQNS8FNESBYOUrobLc4LGav22FbLY5
   ymaqLCw8I2/DVelbNJkU5Nxt6FhOl0KLrtotNqWy2njy7uyTNEEJoKGeJ
   QKCKVlbKrHqZzHpoOhrNv4PjRvkqtIvOKS/X8yQUSRU7VLyxLIKW1URr0
   idXawP/snTupe35T7adTv6h6hjPUmeFakzuKRqdq+XNwYgNiRumZq1TkF
   CnxqEd+rEdQIFFcBOUzLJ5BSEMWClzn5XK8amI6lpf0bLyS1iwX+yTdpA
   idw+YhPAs59MpVCkOGd17ZpTBPxDcbNhRT5yaMTaiIhkaAjg5X7PL8EF5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342790150"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="342790150"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 19:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708319275"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="708319275"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2022 19:00:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 19:00:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 19:00:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 19:00:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCDAC+5MoIQ96Jt8Uou7kXCnM7OGKogNv5py2UIyXIC3iJ1dOZyZRKpPqYDw977IxcFq7sNOxqVL14W7cY+eGhCI3Tt2weV+cARcgA9CE8hng7n3ZQOBCQ0zn6vgsQ5SlqoSV3cAcqmxD/svublCq9E86PzztRTPxrc/4yvlPmLXg16noyApL03mNkUODvIjlxYfKbgjlMNiULRJcvhCsxiJNwQy2z6q3a+yNRVTM5DuN3x0HSsyZblvZ1s3mKma2saxO1jL++virZbQhKj+a81tbt++SlPYq28DzeKt/76hxogpGzXTxt41qSsfAUTAYROG8aET+PaInefrtIijSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEMYf/Uux+mo+CUrZeBzY0tg+Akb3JPZFkazD/IH8C8=;
 b=AD73WR7/SGAXiw4bWh0Udeb2wwws10sRRss6/mQ3ReVxOl5rtFeyLaA9KBC6ZcWJ/CFZLG5tAd6d9F+ptD5dcWAjOS8+HIQ/ykOhp/A0cNQxJz1XZh5gYNdtzykRagasWB48zW7PykUfanCqd7YV9NQ3jwYMHJ2QDiXB+nHpy5Lclna5kzSL9ctdMOFejUCuZUKCeVz1N0SVyLf2Ln+FF3ZzhSqiOQXLt63HIAXoQcLIrpTNwOIKIgUHW9P/zHrF7amnQzZL5liidZIUn2PbfHkgVmfPywBl4heYbcDliB1Qe+aLbz/rwdAs3szxt0yyd85PnitJCWOg3nIan1vAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 03:00:29 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::4bae:9f39:e66:96cf]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::4bae:9f39:e66:96cf%4]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 03:00:29 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Dipen Patel <dipenp@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "timestamp@lists.linux.dev" <timestamp@lists.linux.dev>
Subject: RE: Intel timed i/o driver in HTE
Thread-Topic: Intel timed i/o driver in HTE
Thread-Index: Adj6qih2Gsi7knz7SkKtEKSdboc8IwBFScgAAOFR9zAAD0o4gAE6XjGAAGMv55A=
Date:   Fri, 2 Dec 2022 03:00:29 +0000
Message-ID: <BYAPR11MB324034C53D14D8F7E332A3C5E1179@BYAPR11MB3240.namprd11.prod.outlook.com>
References: <BYAPR11MB3240F382BD180FF90C7DF0B9E1069@BYAPR11MB3240.namprd11.prod.outlook.com>
 <7de35859-97ab-8e88-f590-d5851b81773b@nvidia.com>
 <BYAPR11MB32405F4FA22BB47BD03C8F18E10C9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <CACRpkdbY5aU3OTufA0q+N7Pwm0shGgnjScAGR_96oo9XdgBDhQ@mail.gmail.com>
 <34baa0b1-72c3-e4b3-3eaf-9b07fe86c3df@nvidia.com>
In-Reply-To: <34baa0b1-72c3-e4b3-3eaf-9b07fe86c3df@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3240:EE_|DM4PR11MB5567:EE_
x-ms-office365-filtering-correlation-id: 052488b4-e696-4530-738c-08dad4115eb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KaO8Vk17JNsBufje377wq09DiduCv0EQqgdPtuwkMQNuYMzhMqrKGHvI7JUp5BsZ2uFqthV6gwrOpys1IsG1HAOp9YAXYk4dKzVPElgn7Vn8qwFGIR9OWW2h2h2ccYEEsWX3bZRPId6bD2qlFxMFKQPRoU0RQyKt7MIB8o8KKY+uV7s6wJFOzRjbzt9Z2GqulzexKMBqDl3+7J0kGEeIG8bao3VgGHpIddrhtsfIDaUgc76MuMxOyuloVOs1d3/r0iYTIS9jhBTEFm04rWUSbYtgZZb6AqxzBgFhSNqdKwij+RNCjfAfjweWmNiAA5LXYF507+fhv7S3T/R/rgFPJd30fY1khQ1hzmBgB5XPj8szMTdRJhnu16tWAzumdHgDe/6G/2dXd7NLJDLABTqx9RYj5GLnaAtPUIHf+GonLtIj0RqS+l4pGvR0RRZcncBO9vR005mDFt6qE1WsdyiEmrzGajOv96jOAZ6/qTy+4JTQeB1XMUsvgJZGQoDJ2zvAfb4J4+1WMGawmnHzzGYJR/aKXiUPSv5lugnipzDWXVK8ZZ2kpJGM7YNp0rOcJC/PZFaQH1BXby/Qa+BpT0szQCwWbn8OrSv/P27YYZSA1GHT1mYEk8IMLopIHFQ4nrL14S4Tj1mSNb0Ewk/PNxRTX1QEwjgdMS4UG73J8oKANxWq8cxQsvr8DOhlRoLVPJCwhRmXc73n6iuM4dvN4QZ+WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(478600001)(38070700005)(26005)(6506007)(5660300002)(71200400001)(86362001)(33656002)(55016003)(7696005)(110136005)(54906003)(53546011)(76116006)(2906002)(41300700001)(66476007)(8936002)(66556008)(316002)(64756008)(66446008)(52536014)(66946007)(4326008)(8676002)(82960400001)(122000001)(186003)(83380400001)(9686003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME5WSmNDWC9PdXNMM21xRUM0RmFLeDZ0bG5LNEJmSDZPWGNEcjVvVmxORzBt?=
 =?utf-8?B?eFA2WmllWmJwdFpaUlJHMWd2N1JtMk05NnJDVGc2M1ZwZXZFdHpOTlFGYjZB?=
 =?utf-8?B?OGxFei9GNjVaMU04VkxwckluTkU5eU8yZ0dtQkhybTQ4d3RqTXVvSXpoNkRT?=
 =?utf-8?B?aGw2QWpxUFNkTUwyUWVKRSswVFFSekhwSWVxeXZnWkRTOFlsSlFLU0ZRdndz?=
 =?utf-8?B?VjBuZUxSSi9lNzI2d0V3Y0RYcDIxTFVjY0NZeEdpajcvZjdSK3dlMWZLV3FQ?=
 =?utf-8?B?T2dCdjJ6Z3JmSTZoVUpFVXB5RFU0NTBMYzZWWVZMaWxsWmR5UkdRbG9UYWE5?=
 =?utf-8?B?VTk3aDJ1d0hoZEFyWFJFSk1RTU1NenVFUHE4VHpHZzQyZDdLUnk0NTk4S3VH?=
 =?utf-8?B?TWZVSTNaYXRSUk9qVGlxTEVZQUVUeHFrdjYxUzJFcGpaNzJ6YmtrbXhuWUUy?=
 =?utf-8?B?eXBuOUFvSVBxYk9nMkVnajZuT1JmZ3JHUFUwTThMM0YvU0dYQ3M1enA2KzIv?=
 =?utf-8?B?T3JIbW1STDdpdEZCWFNXTmNRNUZjQ0x1MTJVdDJFa2IrSjVDeGZpaE8rQ3Uz?=
 =?utf-8?B?enBQQ0JDcjA3ZU5wNGMzaEpKdlk3TkN2WnROb01UOUtEWUd6Z3huMnBlUHow?=
 =?utf-8?B?UWVEcEE3ZjN4ZXhLVGpGcVlFSUF6MjFZd1BiNDdoaXRvaVhzVHA4T0RoOVJs?=
 =?utf-8?B?YjNSOWZIc210OTZvbkE4U2VkYTlLTHpEaW5rdy82dmlRK0VVR1ZQVnl1R3Fx?=
 =?utf-8?B?RVA3NGlnSC94aG5Ld0NoWWRnMWNVZGd5YWZZMG96SUcweTJicUdMWUpUcFRr?=
 =?utf-8?B?RTJwd282Q255WDQ4UG1NclpVQlF1Z0FXMlZ5Nzc5QndkZXlRZmJsTUgvTWNp?=
 =?utf-8?B?UlYyT3hZUmZEV1hLV3A0Z0pLaWViaGVRbGxteDB2anFhM0NmVW1FaWwvU2xi?=
 =?utf-8?B?V1NEZHdsWDNCQVNjMk94ODBLdTdkWEhUZ2pmRmdld1lCd0lhUGdyTDFrdTdL?=
 =?utf-8?B?MzVSSG9nY3ZWSzFkSWtTa092M0ZCZlRPWG90ZS93MjZIZ3VBTGt4cmJPWHhL?=
 =?utf-8?B?QXIvTG5icUorTHFQSW5XeUJEZ2E4cW81eEpibGRSVzBtbFFUeThLMEtybnR6?=
 =?utf-8?B?VXRMRC9pcjlhU0lrbEtsNC9wTEFoN2EwZEFyaGJJaFNwRGttSXhjbUsrcWNS?=
 =?utf-8?B?MzFmeGw5bVVqMEhheHo4TE02V0VucU1lc3RBT0VYZzdFMncwZDdJL3RsV3VT?=
 =?utf-8?B?aEQ4eTJydEZhejJORWdURUQzcXZxNXIzYmZSOVFKSWUwWTBLcER2dzBtcHQ4?=
 =?utf-8?B?YnBkc205SnZMa0VSMkc1MncwRjdqT0pEVVE4N2U4cDNkOWo5eGd1NS9TOW5H?=
 =?utf-8?B?Z3UvUjV4eUpSd1dhOS9jS2M1OHJSaGdtbkNWdmhqZ2hORm1nNytDSmx0SUt5?=
 =?utf-8?B?bFJRdE9tcjRjWUpuMzFEamxTL2JUem1Wc0NjWkNuRHFuaysrVGVFQy9kQkpE?=
 =?utf-8?B?UDh3N1R1QXBQNTdxMHFHN1cyV2pieXlBUWx0T0E1WGdjZ05CT1pZYmRZMHdD?=
 =?utf-8?B?SlVEVmFzWDU3QVBXQ0w1OEFWL0pTczZXNzlrSDdCKzdRSEtydnlrZVdRNTZl?=
 =?utf-8?B?MXdyK2ZvMi9zbjZXTVZxY3d5bmdjdEdUc0hLNUlLQ1c2QXUvQjN0UXdRNTU0?=
 =?utf-8?B?QmYyRStyenRHU2pCcGtHVDBuWnpNdnZ1RGR6Q09ZQjFSVHB1YkNVUkxQMHlY?=
 =?utf-8?B?cEdjM2lSa2JyNlkrOXdtSmZRSnBQVkRIVHJ2eEJ4M1c1bHNXU2pOT3laajd3?=
 =?utf-8?B?cWJCSFM1em41aXh6MWJRUEZ0TExlWlU2cHZYMWdiUmhGTHFsU1ZFQnd5RkRS?=
 =?utf-8?B?Y1BaRGluS3N2MEtNdDYyUjg0bHY0aVVkaEdDOGpwbXFEc08vOVl5VlR2RVFx?=
 =?utf-8?B?WGYrSExlcmc0bDROUXRIZUh5Rm9NSUtpRzJMSWpzL1RYWVFvRHk3SjcxVHpY?=
 =?utf-8?B?cGZab3FpSnlHV2tGOHh5anhUWEsvcHAzd0oyYndYU05hRHlZTkUxREVXYWk3?=
 =?utf-8?B?WmFRMitIc1FNTzhLRVJwdzBreVpsNkNXSnQ3empaWEZpc3YzeVVvemUrZC9i?=
 =?utf-8?Q?iUVfSLl4wwbT+raraX+UOj14M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052488b4-e696-4530-738c-08dad4115eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 03:00:29.4254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIcCK7i+8BOpubfDEE1Z0PbaKNQQn1KXiaDKHF23KvWnf5f5Yqsknmy9dxt/6ZFVDRxSOr70XzpogOf/DVhpjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGlwZW4gUGF0ZWwgPGRp
cGVucEBudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDMwLCAyMDIyIDg6
NTQgQU0NCj4gVG86IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz47IE4s
IFBhbmRpdGgNCj4gPHBhbmRpdGgubkBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBIYWxsLCBDaHJpc3RvcGhlciBTDQo+IDxjaHJpc3RvcGhlci5zLmhhbGxA
aW50ZWwuY29tPjsgR3Jvc3MsIE1hcmsgPG1hcmsuZ3Jvc3NAaW50ZWwuY29tPjsNCj4gU2FuZ2Fu
bmF2YXIsIE1hbGxpa2FyanVuYXBwYSA8bWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5hdmFyQGludGVs
LmNvbT47DQo+IEQsIExha3NobWkgU293amFueWEgPGxha3NobWkuc293amFueWEuZEBpbnRlbC5j
b20+OyBUIFIsIFRoZWplc2ggUmVkZHkNCj4gPHRoZWplc2gucmVkZHkudC5yQGludGVsLmNvbT47
IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsNCj4gdGltZXN0YW1wQGxpc3RzLmxp
bnV4LmRldg0KPiBTdWJqZWN0OiBSZTogSW50ZWwgdGltZWQgaS9vIGRyaXZlciBpbiBIVEUNCj4g
DQo+IE9uIDExLzIzLzIyIDE6MjIgUE0sIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+ID4gT24gV2Vk
LCBOb3YgMjMsIDIwMjIgYXQgMzozOCBQTSBOLCBQYW5kaXRoIDxwYW5kaXRoLm5AaW50ZWwuY29t
Pg0KPiB3cm90ZToNCj4gPg0KPiA+PiBTaW5jZSB0aGUgY3VycmVudCBncGlvIGZyYW1ld29yayBp
cyBpbmFkZXF1YXRlIHRvIHBlcmlvZGljIG91dHB1dA0KPiBtb2Rlcy4NCj4gPj4gSSB0aG91Z2h0
IHRvIGRpc2VudGFuZ2xlIGZyb20gZ3BpbyBhbmQgZGV2ZWxvcCBhIG5ldyBodGUgY29uc3VtZXIu
DQo+ID4+IFNvbWV0aGluZyBsaWtlIGh0ZS1saWJjZGV2LmMNCj4gPg0KPiA+IE1heWJlLCBpZiBE
aXBlbiB3YW50cyBpdC4NCj4gPiBPciBtYXliZSBpdCBuZWVkcyBpdHMgb3duIHN1YnN5c3RlbS4N
Cj4gPiBPciBtYXliZSBpdCBzaG91bGQgYmUgd2l0aCB3aGF0ZXZlciBpcyB1c2luZyB0aGVzZSBw
dWxzZSB0cmFpbnMuDQo+ID4NCj4gRmV3IHRoaW5ncyBJIHdhbnQgdG8ga25vdyBmcm9tIFBhbmRp
dGggYXMgYmVsb3c6DQo+IDEuIERvZXMgdGltZWQgaW8gb25seSBtZWFudCBmb3IgR1BJTyBvciBv
dGhlciBzaWduYWxzPyBpZiBvdGhlciBzaWduYWxzLCB3aGF0DQo+IHR5cGUgb2Ygc2lnbmFscz8N
ClRoaXMgY291bGQgYmUgdGltZSBzeW5jIHNpZ25hbHMgb3IgcGVyaW9kaWMvc2luZ2xlIHB1bHNl
IGlucHV0IGZvciB0aW1lc3RhbXAgc3VwcG9ydA0KIA0KPiAyLiBJbiB0aGUgb3V0cHV0IG1vZGUg
Y2FzZSB3aGVyZSBmb3IgZXhhbXBsZSwgdGltZWQgaW8gSVAgb3V0cHV0cyAxbXMgR1BJTw0KPiBw
dWxzZSwgZG9lcyBpdCBhbHNvIHRpbWVzdGFtcCBpdCBmb3IgY29uc3VtZXJzIHRvIHJldHJpZXZl
IGxhdGVyPw0KTm8uIEluIG91dHB1dCBtb2RlLCBlaXRoZXIgc2luZ2xlIHNob3Qgb3IgcGVyaW9k
aWMgcHVsc2UgdHJhaW4gaXMgZ2VuZXJhdGVkLg0KQnV0IHRpbWVkIGkvbyBkb2VzIGtlZXAgdGlt
ZXN0YW1wIGRhdGEgaW4gaW5wdXQgbW9kZS4NCg0KPiAzLiBDYW4geW91IHNoYXJlIHJvdWdoIGlk
ZWEgeW91IGhhdmUgaW4gbWluZCBmb3IgdGhlIGh0ZS1saWJjZGV2Pw0KYS4gVGhpcyBsYXllciBj
YW4gcHJvdmlkZSBpb2N0bCBiYXNlZCB1c2VyIGludGVyYWN0aW9ucyBmb3IgdGltZXN0YW1wIHNl
cnZpY2VzIChpbnB1dCBhbmQgb3V0cHV0IG1vZGUpDQpiLiBjaGFyIGRldmljZSBjcmVhdGlvbiBm
b3IgdGltZXN0YW1waW5nIGhhcmR3YXJlLiBTb21ldGhpbmcgbGlrZSAvZGV2L2h0ZVggDQpjLiAg
RGV2ZWxvcCBhIG5hdGl2ZSBodGUgY29uc3VtZXIsIHdoaWNoIGhhbmRsZXMgdXNlciBzcGFjZSBp
bnRlcmFjdGlvbnMgb2YgaHRlIHN1YnN5c3RlbQ0KPiANCj4gPiBBZ2Fpbjogd2hhdCBpcyBpdCB1
c2VkIGZvcj8gSWYgd2UgaGF2ZSBubyBpZGVhIHdoYXQgaXQgaXMgc3VwcG9zZWQgdG8NCj4gPiBi
ZSB1c2VkIGZvciwgd2UgY2Fubm90IHBsYWNlIGl0IHJpZ2h0LCBldmVuIGxlc3MgdGVzdCBpdC4N
Cj4gSSB0aGluayBpdCBjYW4gcG9zc2libHkgYWN0IGFzIHRpbWUgc3luYyBzZXJ2ZXIgYXMgb25l
IG9mIHRoZSB1c2UgY2FzZS4NCj4gPg0KPiA+IFlvdXJzLA0KPiA+IExpbnVzIFdhbGxlaWoNCg0K
