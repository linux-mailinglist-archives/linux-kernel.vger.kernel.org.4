Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C696F8E29
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjEFC6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEFC6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:58:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B50219A8
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683341924; x=1714877924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ROidbBhU3vZh/wJ4MsLaMqeWcF1i/RaDPg1HJepXM8w=;
  b=AuW1VRfxcOb3jLzTSJRW70kJjuCqcWZ6PJKHydisoU/LMmxWiU/SDu2D
   Mk6+2TYFHDv/ebXMQdRuf0Ma9vaMItyCOmlQE8i/dOlR3BR9g61FXLd6h
   8hT3CgWQ9PC0XlvR1/MeMgBxH2KY3F7vQuAL6wR1rzEqATtKzhUyNpimn
   8Ff4sesa9LS1uikSzLWrNajaV/Nyx97XVa8zZdWE7SokUUOEg67kCOvdl
   0kcEsLKt1DI08xL1B0tVgos92RD3KKAdhFcOtFUATN1oz7B3zKzVki+jG
   Ziv2fieM5sloJY2b0Wl1bJcvtvtf85Hq/t0RlZe0gSHg0zLrPnKb6xKOZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="346804562"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="346804562"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 19:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="1027740735"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="1027740735"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 05 May 2023 19:58:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 19:58:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 19:58:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 19:58:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhFJZnrIEeaAuG0lkwfzgE7fAmvQskzNNMrssC7BDQ5fLsrpGv4j28Ji1RlfSVVwv25pjB1aENu1/lt+3j9gqohkQImviYJIlideBXf6boN52AnXlsDS6eoZrZ9itogFogpsezT7WhdqExMZ9reC3Fm9ZotiDVsNQVaIZKcEHPkHS3B4WBgA91b/FX4u37xQli+br7wXw1cgr6wi81RVZRhpxksGuhasNtGByNwUauErBLnSIT/YxojhT7Mys7AatHkycfLAoHJnztDQJLwtpEtB9vbUS1eniE1Suhp9Ddp10Fv9iRiec/vhxCP6s0qldzsIMbW7eXnLI2vR1sHolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROidbBhU3vZh/wJ4MsLaMqeWcF1i/RaDPg1HJepXM8w=;
 b=TOG1lOwyPkYddNCiOGHHFHfLiH5lP1FddDU9QaA2Riu/csiGC44ZZn6yxKs8CNigc/L5LKxgkHMMVth/qUMHDfPSS33aEg7zaq6j+0kMZjJ77Qo2LYRQHEtaakENXamIY7hMwwdIIQESEMbqF+7AtTFXL0cn6PBRShDT1UVH7rrqJRkmD0Y/vvdwzvcyj9awWjRH9gEuspeOGcoLhmQ5aNn11psFhd73uGz8Mx6PXyt8w4Te6ozFyfo4mIKIrqtVh/UR3uqq1WbadX1Sp/nz+CQqZPGRCsX+YpWrXBJzys8qlzvQCrJfZ/QmvuHn50LygMhqftS5RSoE2ZdwOSXzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7195.namprd11.prod.outlook.com (2603:10b6:930:93::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Sat, 6 May
 2023 02:58:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6363.027; Sat, 6 May 2023
 02:58:33 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [git pull] IOMMU Updates for Linux v6.4
Thread-Topic: [git pull] IOMMU Updates for Linux v6.4
Thread-Index: AQHZe1TQZqyxolt6yEuibrPd6p/B5a9ESDGAgAd1t4CAAENNAIAAH7eAgAADsgCAAF/b0A==
Date:   Sat, 6 May 2023 02:58:32 +0000
Message-ID: <BN9PR11MB527612F299A6436DDFE4DAB28C739@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
 <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
 <ZFUMja5MpRPWCRXw@8bytes.org>
 <CAHk-=wjW4CzM9YZqwB3jU9mt7FKdctLWAbOcBQAwJ0_2eRmP=g@mail.gmail.com>
 <ZFVfncB76TrB+c4K@ziepe.ca>
 <CAHk-=wjvonKjgyY1-Mc9POg1euT68wX3Z5+wqBckN+_j=pOaAw@mail.gmail.com>
In-Reply-To: <CAHk-=wjvonKjgyY1-Mc9POg1euT68wX3Z5+wqBckN+_j=pOaAw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7195:EE_
x-ms-office365-filtering-correlation-id: 05d288bc-11ee-4f8e-bebc-08db4dddc726
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKhSouIjKqBPu81GG0PAj94wsXoXwOei1Y+vmaKPr1GN70LJHzhVPkH6bzTgM+MkmXY/CXzRItm4bI9R4FRR0Z4lIBitiWWRgPELX5uNX8Ul2fmeYhVZ9RpbpmudFMU0YpiMl+6GuqISPJJCc7jaMCeop+czSQ8tYqT+oKo+x4IFZe4m3+2z+Ps+vz+BkGDHSG2yzQPEk5XJr3AYy8LUi0IhB//TjhFLTU12WDlAtI+68Yd5Uw4P+taOoZWwV33PA/oOyg+p53nA6d2+pO33SqvPrTnUD4XTxlSd6oj/9VX5CO3lzen5bGdhUizVnd5LB7W0cFYRauOSVYgGSQ5FgMI7Dr95q8fOS3DsGlmFmLiRYHcXt0icMkJhOWG7lQv90JcukgA/bTocTjSAbpRpZlIJHcWDMUgCWPmkJ9cbyRknyTpkH2PZGvuoTXhT8+eszwtevgbn4hbkAl14pvwx9rmmG1USTFDWjaJtCOmBrp7jVxw5llA7BHTfIEh0BNqUJ29Gfcpwf6JINGaXkKFnrSVA0WXfkJ/GWdi93DynTVRxPl2vKm/PakFojVEObfqlRMHTWLy3lUrfkNIvPVFGMR16/t0sEKS6y7TRNzyjxeVSWSB1o6Krzrflngth657QNhxo63ZKJe0fa4jyLi2vOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(66899021)(8936002)(8676002)(55016003)(966005)(9686003)(6506007)(26005)(53546011)(2906002)(83380400001)(4326008)(7696005)(76116006)(478600001)(71200400001)(5660300002)(316002)(52536014)(66946007)(66446008)(186003)(64756008)(66556008)(54906003)(66476007)(110136005)(41300700001)(86362001)(33656002)(122000001)(38070700005)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFhzTmduWFhYVFViK0xMMzd4WHNPTDBWTmZ2bzdTWEl5UUY4T0RidHR0L05C?=
 =?utf-8?B?elM4M2Z2ZEh6Y1U1eHZKWlZBWmM0eWRMSkhzOHQ2WmNtVFJNREtRTm5YRDd2?=
 =?utf-8?B?aFNWdllQSk43TC80VUhsNnZ1MXJvbGZBTmpqY2FmWXo4MTA5dGg3VzdXOE9I?=
 =?utf-8?B?a2FUUVZYeTBIbUtsUTdFcGdLaWg3ZHRNSWwrODJiNXdiQjhwYUJzdkJSSW5T?=
 =?utf-8?B?NU5rRHM0QWhpWjR5cnBXbWVzM3R1dWJOYzdSSWxRaXo5R0EvU0xZTWVoZy95?=
 =?utf-8?B?QmE1MXJha3M0SHNWRVEvUU95c1JSMFI2bEdZWGlORnBxRHZxNXdoQnhleGxs?=
 =?utf-8?B?UnlIWGhyYzBpOVpEUWh5WkVxcHFKTWE4eU9HMGlIR1J0VTRvZWlUS01PWmVU?=
 =?utf-8?B?TUFCdGxmOFJyT0hJZFhZNWZmNDBoZ2lBSjRORzNuSFlwVHRCdytjZ2xwdHND?=
 =?utf-8?B?Vm9lU2N4RWJocFNyN0hoVVQvQ1ZoVmtWTTF1WGRlWEkrMXRid2NUM1ZHYU5k?=
 =?utf-8?B?SDRCR01TUTZCV0VHVkhRWUMvenY1NGhwSmJhOUZLUmp5aW83ODB2d2w3VW8y?=
 =?utf-8?B?eXcweHVjZnZyVlZMRzBjZVVoR3llMVB5NjdMNHNKbWtFV1haVGYwb1hIeUFy?=
 =?utf-8?B?em5DeVhHRy9sR2FKSFVlTzd1SE5tcWR0Tm12aE1xWng3T1QzY09MOEp4cmJz?=
 =?utf-8?B?b2c2Uzh6Ylk4S1RjZzNkbnVwdis1cFVjaHQwN1RWSXFscTl0RFdUa1h3cEht?=
 =?utf-8?B?RWJsaFMwcGliNERzTzVBaHhubm1ENlRqcTB1YTRBZnVJcXlIc01HRGdjNHFF?=
 =?utf-8?B?S0Y0K1dwdFYyY1cyaWdXQkprUmlRZGpTOVFCaGJSRE5aK2N6aS9rSTdETVgv?=
 =?utf-8?B?ZlliMkl1VXB5cnhNWHZ2SFU5TUczQUE5bHM1UnJWbVh1a2xtV2E2K2dLcHp3?=
 =?utf-8?B?aFE3ZEZGbmVRVE85d0FuR0JRazhMejU0eVhvMUs4YWZhRzhwaGVnWkp5bGF4?=
 =?utf-8?B?UnZMbUh2VmdvUGJFVHdJdVVjWHc1azlCU0xzbXEzdE5KY1QrVThFRmdJVW1B?=
 =?utf-8?B?cWhTemE0RnA0NEtueHRaa0lJUjdpeEg1N0FJZUN0MTFReFBIOXlUSXUxTHFQ?=
 =?utf-8?B?WnBDVjNrWFplalpwZUl3a2Vvd3JWSXo1OHRkdVB3eFk2dXB6aVNGT2Y2Q0Uv?=
 =?utf-8?B?SHNsQXNkZWYrcTRSZ1lzTForQzZ1UGV4bXRpWGlUNkxMcjU2YzNqNjZiTlFq?=
 =?utf-8?B?TWVTKzBKam81Q1ZNOHBqdGJLYTlDU3VpTW1XZjJMdGd4TmN5QXFDQ2dFU3hn?=
 =?utf-8?B?ZXpOM0lYY0l2Q2VvL21PL2N1MGlxc01iTGRYbFpJeHBMVkEwTkJOY3Y0QTRT?=
 =?utf-8?B?Y2ZtMStXS0VJMlVHa2FTcU9qUnJVQ1NUU2UvWlZiZlMzYXpjRklRWGgyN21n?=
 =?utf-8?B?UlUrODhNQ2tTWjZoQmtRYUtORU9IZ294MTJWQ1NwZjBxUFQ4RlkwRVh3Z2Yr?=
 =?utf-8?B?T3JyMHJSNGNWNlVVQ1VtY3JKOXE3elFDbXlCWk10MnVWY3RvYUEzVG1EY2JI?=
 =?utf-8?B?aDQzOUl1NVBXLytlLzJYeDZiUDg5VlRkT2pteXp2RC9MU2RDeWxhYUhjZTd4?=
 =?utf-8?B?aldhSTRpbHh4RDNDZGt4NHZCQzgrbUsrd1JxTTdSK1V3aGEzNFFRRXdkaEVi?=
 =?utf-8?B?VWwyQmY1a000VjhtVllHdWRPNmU4dEtOY0w1dmJzUlRBMjJMRG9IeU8zVVds?=
 =?utf-8?B?RHViNlBnSE0yZG9tL2IwVllHVUVkZmZNd1NrZXFDbkZRR3QySnF5RmhNa3Mr?=
 =?utf-8?B?T2JMRkZXUXE2VU1HcnVYaFRLTXd5ZmxwQmtMdzdsdkxDTzVpdjlwYWN0WlJo?=
 =?utf-8?B?cW12TFgyTElIS3ZPN3lGUVVRS2dpUW52aG1JZUtKODBnUUpzdXN3Q2k4MjVU?=
 =?utf-8?B?aDdMNUJINUhlY05nODVXd29FNzVXeElqTU1PaWZmb0ozNzBzYUYwaHFpL0Rj?=
 =?utf-8?B?dS9ObFQ1cTFUSmo3M1dkZUNtM1U4RWkydW5SV01LL2VGbUJFU1MxMldxdk5B?=
 =?utf-8?B?WVpsMmV0Z09Ga2FTZzVscVNqTTFJOFFtalNBRFZ1T3diSytMa3I4endhNm5H?=
 =?utf-8?Q?Vs37mR2nv4CER/+klny1MHjTh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d288bc-11ee-4f8e-bebc-08db4dddc726
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 02:58:32.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gL+BAccFOc1O8XkOTdcMFfcVTpbYmaeU2J4kWfgbXDGSjjkbDRuMb75nTVaeLI0MjQNMwL+qzf1uLSzPG8qRPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7195
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

PiBGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+
IFNlbnQ6IFNhdHVyZGF5LCBNYXkgNiwgMjAyMyA0OjExIEFNDQo+IA0KPiBPbiBGcmksIE1heSA1
LCAyMDIzIGF0IDEyOjU34oCvUE0gSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+IHdyb3Rl
Og0KPiA+DQo+ID4gQXQgbGVhc3Qgd2l0aCB0aGUgY3VycmVudCBzaXR1YXRpb24gQ09ORklHX0lO
VEVMX0VOUUNNRCBtaWdodCBiZSBhbg0KPiA+IGFwcHJvcHJpYXRlIG5hbWUsIHNwbGl0IG91dCBm
cm9tIHRoZSBJT01NVSBrY29uZmlnIGFuZCBwdXQgaW4gYXJjaA0KPiA+IGtjb25maWc/DQo+IA0K
PiBUaGF0IHdvdWxkIGF0IGxlYXN0IHNvbWV3aGF0IGNsYXJpZnkgdGhlIHVzZS4gSSBmaW5kIElP
TU1VX1NWQSB0byBiZSBhDQo+IHBhcnRpY3VsYXJseSBvcGFxdWUgbmFtZS4NCj4gDQo+IEFkbWl0
dGVkbHkgSSBwcm9iYWJseSBmaW5kIGl0IG9wYXF1ZSBiZWNhdXNlIEkgY29tZSBhdCBpdCBhcyBz
b21lYm9keQ0KPiBtdWNoIG1vcmUgZmFtaWxpYXIgd2l0aCB0aGUgTU0gc2lkZSwgbm90IGZyb20g
dGhlIElPTU1VIHNpZGUgKGFuZCB0aGUNCj4gX290aGVyXyBjb25kaXRpb25hbCBmaWVsZHMgdGhl
cmUgbWFrZSBzZW5zZSBmcm9tIHRoYXQgc3RhbmRwb2ludCksIGJ1dA0KPiBldmVuIHNvIEkgdGhp
bmsgaXQgd291bGQgYmUgZ29vZCB0byBjbGFyaWZ5Lg0KPiANCj4gT2YgY291cnNlLCBtYWtpbmcg
Y2xlYXIgaXQncyBhcmNoaXRlY3R1cmUtc3BlY2lmaWMgd291bGQgYWxzbyBiZSBhbg0KPiBhcmd1
bWVudCBmb3IgaGF2aW5nIGFuIGFjdHVhbCBhcmNoaXRlY3R1cmUtc3BlY2lmaWMgcGFydCBvZiAn
c3RydWN0DQo+IG1tX3N0cnVjdCcgKHRoZSBzYW1lIHdheSB3ZSBoYXZlICdzdHJ1Y3QgdGhyZWFk
X2luZm8nIGluIHRhc2tfc3RydWN0KSwNCj4gYnV0IHdpdGggb25seSBvbmUgc2luZ2xlIGZpZWxk
IEkgc3VzcGVjdCB0aGF0J3MganVzdCBub3Qgd29ydGggaXQuDQo+IA0KPiBBbmQgd2hvIGtub3dz
IC0gbWF5YmUgb3RoZXIgYXJjaGl0ZWN0dXJlcyB3aWxsIHBpY2sgc29tZXRoaW5nIGxpa2UgdGhp
cyB1cD8NCg0KTG9va3MgQVJNIGhhcyBTVDY0QlYvU1Q2NEJWMCBzaW1pbGFyIHRvIEVOUUNNRCBh
Y2NvcmRpbmcgdG8gWzFdLg0KDQpMb29raW5nIGF0IEFSTSBzcGVjIFsyXToNCg0KICBTaW5nbGUt
Y29weSBBdG9taWMgNjQtYnl0ZSBFTDAgU3RvcmUgd2l0aCBSZXR1cm4gc3RvcmVzIGVpZ2h0IDY0
LWJpdA0KICBkb3VibGV3b3JkcyBmcm9tIGNvbnNlY3V0aXZlIHJlZ2lzdGVycywgWHQgdG8gWCh0
KzcpLCB0byBhIG1lbW9yeQ0KICBsb2NhdGlvbiwgd2l0aCB0aGUgYm90dG9tIDMyIGJpdHMgdGFr
ZW4gZnJvbSBBQ0NEQVRBX0VMMSwgYW5kIHdyaXRlcw0KICB0aGUgc3RhdHVzIHJlc3VsdCBvZiB0
aGUgc3RvcmUgdG8gYSByZWdpc3Rlci4NCg0KQUNDREFUQV9FTDEgc291bmRzIGxpa2UgdGhlIFBB
U0lEX01TUiB1c2VkIGluIEVOUUNNRCwgdGhvdWdoIGl0J3MNCm5vdCBleHBsaWNpdGx5IHN0YXRl
ZCBzby4uLg0KDQpXaXRoIHRoYXQgQ09ORklHX0NQVV9QQVNJRCBtaWdodCBiZSBtb3JlIGZ1dHVy
ZS1wcm9vZiBiYXNlZCBvbg0KdGhlIHNlbWFudGljcyBvZiB0aG9zZSBFTlFDTUQtbGlrZSBpbnN0
cnVjdGlvbnM/DQoNCkJ1dC4uLg0KDQo+IA0KPiBCdXQgeWVzLCBpdCBtaWdodCBiZSBnb29kIHRv
IHJlYWxseSBwaW4gZG93biB3aGF0IHRoZSBydWxlcyBhcmUuIFJpZ2h0DQo+IG5vdyBJT01NVV9T
VkEgaGFzICpubyogcmVhbCBoZWxwLXRleHQgKHRoZXJlJ3MgYSBjb21tZW50IHNheWluZyAiIw0K
PiBTaGFyZWQgVmlydHVhbCBBZGRyZXNzaW5nIiksIGFuZCBpcyBhbHNvIGVuYWJsZWQgYnkgQVJN
X1NNTVVfVjNfU1ZBLA0KPiB3aGljaCBhcHBhcmVudGx5IGRvZXNuJ3QgYWN0dWFsbHkgd2FudCBw
YXNpZCBzdXBwb3J0IGF0IGFsbC4NCg0KLi4uIEFSTV9TTU1VX1YzX1NWQSBkb2VzIHJlcXVpcmUg
cGFzaWQgc3VwcG9ydC4gSnVzdCBubyBFTlFDTUQuDQoNClNWQSBhbGxvd3MgdGhlIGRldmljZSB0
byBhY2Nlc3MgQ1BVIHZpcnR1YWwgYWRkcmVzc2VzIHdpdGggcGFzaWQgdG8NCmlkZW50aWZ5IGEg
c3BlY2lmaWMgQ1BVIHBhZ2UgdGFibGUgd2hlbiB0aGUgZGV2aWNlIGlzIHNoYXJlZCBieSBtYW55
DQpwcm9jZXNzZXMuIGUuZy4gZWFjaCB3b3JrIHF1ZXVlIGluIHRoZSBkZXZpY2UgY2FuIGJlIGFz
c29jaWF0ZWQgd2l0aA0KYSB1bmlxdWUgcGFzaWQgcG9pbnRpbmcgdG8gdGhlIENQVSBwYWdlIHRh
YmxlIG9mIHRoZSBvd25pbmcgcHJvY2Vzcy4NCg0Kdy9vIEVOUUNNRCBtbS0+cGFzaWQgaXMgbm90
IHN0cmljdGx5IG5lY2Vzc2FyeS4gSU9NTVUgZHJpdmVyIGNhbg0Kc3RvcmUgdGhlIHBhc2lkIGlu
Zm9ybWF0aW9uIGluIGl0cyBvd24gc3RydWN0dXJlIHdoZW4gYSBDUFUgcGFnZQ0KdGFibGUgaXMg
YXNzb2NpYXRlZCB0byBhIGRldmljZS4NCg0KRU5RQ01EIGZ1cnRoZXIgYWxsb3dzIGEgc2luZ2xl
IHdvcmsgcXVldWUgc2hhcmVkIGJ5IG1hbnkgcHJvY2Vzc2VzLA0KYnkgc3RvcmluZyBwYXNpZCBp
biBhIE1TUiBhbmQgc2VuZGluZyBpdCBpbiB0aGUgd2lyZSBzbyB0aGUgd29yaw0KcXVldWUgY2Fu
IGJlIHN0YXRlbGVzcy4gVGhpcyBuZWVkcyB0byBzdG9yZSB0aGUgcGFzaWQgaW4gbW0gdG8gaGFu
ZGxlDQojR1AsIGZvcmsoKSwgZXRjLg0KDQpCdXQgYWZ0ZXIgbW0tPnBhc2lkIHdhcyBpbnRyb2R1
Y2VkIGluIDUyYWQ5YmM2NGM3NCAoIm1tOiBBZGQgYQ0KcGFzaWQgbWVtYmVyIHRvIHN0cnVjdCBt
bV9zdHJ1Y3QgIiksIGl0IHRoZW4gYmVjYW1lIHRoZSBjb21tb24NCnN0b3JhZ2UgZm9yIFNWQSBi
ZXlvbmQgRU5RQ01EIGFuZCBjb21tb24gc3ZhIGhlbHBlcnMgYXJlIGJ1aWx0DQphcm91bmQgbW0t
PnBhc2lkLCBlLmcuIGlvbW11X3N2YV9iaW5kX2RldmljZSgpLg0KDQpGcm9tIHRoaXMgYW5nbGUg
dXNpbmcgSU9NTVVfU1ZBIHRvIGd1YXJkIG1tLT5wYXNpZCBzdGlsbCBtYWtlcw0Kc2Vuc2UgdG8g
bWUuIEJ1dCB3ZSBkbyBuZWVkIHRvIGFkZCB0aGUgbWlzc2luZyBoZWxwLXRleHQgZm9yIGl0Lg0K
DQo+IA0KPiBJIGR1bm5vLiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgYSBodWdlIGRlYWwsIGJ1dCBp
dCBkaWQgY2F1c2Ugc29tZQ0KPiBjb25mdXNpb24gZHVyaW5nIHRoZSBtZXJnZS4NCj4gDQo+ICAg
ICAgICAgICAgICAgICAgTGludXMNCg0KWzFdIGh0dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vcXVl
c3Rpb25zLzcwNTYxNDkxL3RlbXBvcmFsaXR5LW9mLXN0NjRiLWFuZC1tb3ZkaXI2NGINClsyXSBo
dHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGRpMDU5Ni8yMDIwLTEyL0Jh
c2UtSW5zdHJ1Y3Rpb25zL1NUNjRCVjAtLVNpbmdsZS1jb3B5LUF0b21pYy02NC1ieXRlLUVMMC1T
dG9yZS13aXRoLVJldHVybi0NCg==
