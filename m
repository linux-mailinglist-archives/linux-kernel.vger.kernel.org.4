Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4A66F7314
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjEDTNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEDTNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:13:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B49ECD;
        Thu,  4 May 2023 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683227607; x=1714763607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MJ1q9VYyyuabwEVjSB5BiJJo/snVSC2nvulJvHHUFM0=;
  b=BZm8suvdvOHWENA0QB+hNr4LnZy5ddrvkSPo/kWNxBsd5lBY/08ju9hr
   ppSKneajnZHFCQy0B5/0Z5UNT3IVwuwHm1WOWemBeDJ0UwTMJtr4uDKKY
   zqrxSBnuFLfXwyrlU6UgqP1GTU9wc+M/KQAXGOacRLwL4pxGk6M5hFDI8
   A7jKV91hkNGxVB8vQlETHWetCdrg/5Upu+1qADxFpQ3nguJyte7pUCT3/
   w1a9BhDGAhAK2mt39EEo3dbedeG28jBbhFHDhd+WbdRX+VcToR7cb+AKs
   KiMbusVQc5c3KVNxhHO8npCA1zuzg5UIqeru9rR+EUc+Xk7bIso9yJEh+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="414546955"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="414546955"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 12:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="821308615"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="821308615"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2023 12:10:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 12:10:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 12:10:08 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 12:10:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVBXsNCnM4STBOzajmM3Vh5Nwig4evKxr65kGETInh83GPdmHDAebiP6D6D2X8t6IQzGG13+/5XYFtvEyfUbqVvcRBoTCDbuT/zzodL6bE1hr8UY7aJxCYln6gAJZowoCP8+wK/KaEW8AS9T3ZXTjO7MZ+cH2cHWtuQAw2y+wF+Y8uQFh81l4uB1J9QPvlYO3fKqWCC08cfqTfWhcJ1sECsbhy2VPLnSXvkYQ6TaliyIYDi03mSSKsnRwP7tHwxNZYHf+Bu6lzsd2rF37n6CHCrkS6XycgB6AAfdDYHEVih2eOhtXhaLcaWb4Dnpp65RNIxN5z+aj9daIno0iHQauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJ1q9VYyyuabwEVjSB5BiJJo/snVSC2nvulJvHHUFM0=;
 b=gybUM3v9lIJ4ExHH+IgXUUadxc7pNTLH8LZO8Y3pJU7JWBz6xxX/KWRXH5zYmDDwK8Lnci98v8JhU+CuysCA/FanS73mN/WLsjO3dc3H/BPK3cYUntdBUYf4hwKfQLZDGgUKV3cQI6P+863jJzE5WZw7SJ9Cu/Sv4YEVYPjy2V9zk2gevOz/7xAmNG2yNQQ45cysVN5ulUQPRuFdkssDTBf4DVFqZTcydx9N7u/v6XVKL2r/HU4PsCSUjCGauxmz71m1edONW8i1i4d0PL6YHOkQYXehzfDS9xef9o5cot8aaupOCz7ixxKXgKpG3kA5Kwm9OWLutCY5dPtXKoMoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by BY1PR11MB8007.namprd11.prod.outlook.com (2603:10b6:a03:525::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 19:10:06 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 19:10:06 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        "support@spotco.us" <support@spotco.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgkeyes@vigovproductions.net" <mgkeyes@vigovproductions.net>
Subject: Re: [PATCH] maple_tree: Make maple state reusable after
 mas_empty_area()
Thread-Topic: [PATCH] maple_tree: Make maple state reusable after
 mas_empty_area()
Thread-Index: AQHZfrGoQnwbuomzAkSSAR7SI/pJeK9Keq6A
Date:   Thu, 4 May 2023 19:10:05 +0000
Message-ID: <560c0037f71be3b0bfe0109ace30cfb869dc7382.camel@intel.com>
References: <20230504175509.2195838-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230504175509.2195838-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|BY1PR11MB8007:EE_
x-ms-office365-filtering-correlation-id: baf13ab9-713d-4943-752f-08db4cd32bd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7K+4ouyOflQcYCVddWstp5akb1Ic5yi2xRM0us/TA+jI/syNMHBrONnyDflGv/V7W5EBiVPKQ+frPjMXVYbyG1a0eiTcasoorLwayfal6y0SJWuEGvZpgeIuxfI7hJxKCFJ2LnLXIWGMXvKDsLx3XCPZbBfHh5r3VOykAQ6w/KlIBRUiJH68mUFsa5Rl/j0c0pzkSXdN3oZDh8N7bcMh4NJB5xLK5imagMsMR7LgqjqSeQNKFax6J6n/izQtJEAZiUroI3liFubHEdSDjwDw8Q0oDXM4a0Rz9uQR7+jqfb3tFClrLlmnNn3WFFBrh49EVtgfdsUkRp5wGopF1Q/r2iHbxUYifcuOG24WTOjJs+BHpXKQeaQNXVqlxGje3FgrM1M3amMVqc/8ggGzb6VXTCSQWFk/xigVp79i5qr0eplKDqlQiWGzYLXGtQ1DYryWsx+fSS86K5ZM3UKFk3+kNGbKpohsTUCn+OJDIGd4gr0eJB4D9q5R99c2jIOALmmIykN3ws1tkojhOeGO23ocnj3SQrC3KsShf3bg9g0eEndETVNp+HhaOlPqxIufq5E8Oskk/J5HhRreSPn4FLqxmQSKG3SsiwT0YTWCeWVCTA7ywatzYYZNZNksz41ZKgpHcu2OrsCxoUYdGaeBWG4YyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(2906002)(4744005)(66556008)(38100700002)(122000001)(38070700005)(82960400001)(2616005)(26005)(6506007)(6512007)(186003)(83380400001)(36756003)(8936002)(8676002)(5660300002)(91956017)(316002)(64756008)(966005)(71200400001)(478600001)(86362001)(110136005)(66446008)(4326008)(54906003)(41300700001)(6486002)(76116006)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWJvNkJZYXluRVBVWC9TMU1rdHlPVndSNTdwU0FTVXRzZlMxbHM1aVU0ZStw?=
 =?utf-8?B?Qzk1eUpNb2NWQThTRWNQT0htUmhlZDRsZUFEdThGYSs1SzhoeC93b2xRNzJZ?=
 =?utf-8?B?OHl3ZCtMdU5XZ2dKMlNCdWFOQ3hKV3BZZHNDZFNRTXpIY0YzYnljUHFtRFIz?=
 =?utf-8?B?alVtcHU3OUZBbGR3QVp6S0Y3UlZnV2dkaHZHMDNiQUg0dmZ4emFxUXJTb2d6?=
 =?utf-8?B?SmFWWmxNYkxnVkNGaHFRaGhjMFIxeE04aHZhNDE4SHdoWDdTNDBWNHVWTXc0?=
 =?utf-8?B?M0E4bGNLdG15Qy9tSjdJUzRzNGZ0aitCMml3eWl0WFR0N1NWWDhNT1NNR3V0?=
 =?utf-8?B?andxYktDZVpaZ3BhUEdib3JPR2owcVR1MU5IcEV6eVUwQ2w1NUF1bG51T1Vu?=
 =?utf-8?B?Wnc4RGxnVzg5MndhSmZCQnJ6Qi9tSmpvZGxSbndCUWdaazRCWWVEYjdzT251?=
 =?utf-8?B?YUdRS2xucUtpK2hGbzlESTZLdVRwZ0VYclFLTFlNTVpQRGpoQU5meXZoUldV?=
 =?utf-8?B?Mm15emdOaEMxVFhTQm5PS3Z6TVBBWmJURHU3RENkUThieTNzM0JURHRHZFZ5?=
 =?utf-8?B?OUJIVUVMdFFNMEdRV0dzeURBbWF1SnJwWHlRQ3VQWU02ZEZGNWs2UTFDSHZx?=
 =?utf-8?B?em05OXRWVUgzQjVlUjF1STl3YUFVVk5JVG9NUkx0YlFydVdsWTZhVkN6dnVG?=
 =?utf-8?B?NVRSRTYzVWJYZGRpZktZMXlQWEtsdFJScXhHcVpmNm11cnZzSGxJVllUM3NX?=
 =?utf-8?B?RzRMYjZ3WTNob09NbU1vdHhKdWd2Y09aOEoyeFQ0U1l2bmI1c1l2WFZmTUlu?=
 =?utf-8?B?dm1oeFVRbHc5aTFnN05vdVNzaGczd3h5cDJaQ0VsMHBCeHVSUXdtUGExNFd4?=
 =?utf-8?B?THlncEtrSktHOEZjdjlPcHZzckY2ZHpURXloLy9CMWJMam95SDNkdkhFMGFQ?=
 =?utf-8?B?MlJ5Wi91eDZuYkxiSGhzbHZwOVVZTm9ndDk2bEFRZmFkbmtJUWZkSCtJSWw2?=
 =?utf-8?B?VW5nV2pGU2dmb2taVm4zZFFURW1MMkFQdy9Nd0hrOElGUUtSMVJ3TXczV3Bs?=
 =?utf-8?B?K2dtNXNSbkpHdy9mU244azdnaUJESmxoU3ZpZTJpd0JYTkk0MWVhVXg0Wmp5?=
 =?utf-8?B?REdZQ0dQcGV6Y3JLKzZKM2tsdTRuQkR4ekNaaGpsYXpCYjlJUU90MU93OXJZ?=
 =?utf-8?B?WU9ubEVIZGtMcVY2eTdQY1lEVklPanVTYUwrN3Y1SGZWa3FGUWRZYXJUdy91?=
 =?utf-8?B?NFR3UWVscWw0ODRqSC8rcUdPK0UzTUJoWDJMbW1ibE5aRnVYcUhFaVZmWHdz?=
 =?utf-8?B?ZDhOZVp4MS8vV3hCZ0xKd1VJYVNPRDJScjZHNC95RC96OEFXZEhuL2IyVytj?=
 =?utf-8?B?RFM0YU5aZTdGN2FBVXBNVWgxYnYwQ2N5cUtVNC9SRFBQYmIwSWtFRWI4Rm8r?=
 =?utf-8?B?bWNUV1o0V3RUNlFrQkY1RUZpbVRNbHFJRm1BaUNwa0RkcW11S3N2SEN0OFNO?=
 =?utf-8?B?VkR0b2lVUGNDQyt5eFJjVFBiOVZZeGo2WTRhNzUrcncyN2FTbTFLcmF0M1Rj?=
 =?utf-8?B?MDJoaW1BZk02SUNRRk5JWmw2SG5ZTjRnQUtsUGpzSHc4QmRPZ213VWNRUkhL?=
 =?utf-8?B?eGE1YlUvTmZuSjhVU3dYZC9qNkxGMEVPL3VKOFl2U2taY2x6T1V0dG5hbFNR?=
 =?utf-8?B?M3Btd0RacHJmRllZdzhVczR5bGRvL0dQNTVUM2FKUllPOVBRRlJ0dEJuaE16?=
 =?utf-8?B?UWFwcjFmTFNkZTA3K2pDWXNQOG9ZakxXQjdIRDZ0bFAzSmpEc3JaK29KSjg2?=
 =?utf-8?B?TWhZeXNITysxV0tiOEJTS2RnMGNJOVFXOGlyK3pCMTF4RzRsZU9EUnhUdXVa?=
 =?utf-8?B?dDAxZ2k2WmF3d2ZVQWVuaWhVVFNXaDFOMjlIUlJZZHJubVliU0prRlNwekcy?=
 =?utf-8?B?U0RnTzJ4c29GYWxXbENqeFVjYm82ekV4RGNGT280b3RibGFCWDk5NmpoNXNQ?=
 =?utf-8?B?L3lhSjE1LzlPU2grSExvaGVMZHZycm1rMStETHFLZ20rWGxmbmtjYUJ4dE5M?=
 =?utf-8?B?UEl5NHpPSXdRM3JxajNGaWxNRTNGKzQyMHg0M1dydFp5RE5QS2wxU3daNGZr?=
 =?utf-8?B?bGp6Qmx3YjRnM0krS04zdGlCb3M4b0gxZDhVbkRoOGJ6akpSeURhbzlzVWpY?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9871F9EF0353664DBC646F2AF89ADE8B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf13ab9-713d-4943-752f-08db4cd32bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 19:10:05.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwgyvEO6mqaOk3gdUKlKRl+2ZHKat2kzxUR3uKvCxIoZ+R55/o2UXCiRrYRsJZX/3cU68Hlgfe4UDlRD2+0Rf5e8TYdg3FgQHikTnW9/ecw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8007
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA1LTA0IGF0IDEzOjU1IC0wNDAwLCBMaWFtIFIuIEhvd2xldHQgd3JvdGU6
DQo+IERvIG5vdCB1cGRhdGUgdGhlIG1pbiBhbmQgbWF4IG9mIHRoZSBtYXBsZSBzdGF0ZSB0byB0
aGUgc2xvdCBvZiB0aGUNCj4gbGVhZg0KPiBub2RlLsKgIExlYXZpbmcgdGhlIG1pbiBhbmQgbWF4
IHRvIHRoZSBub2RlIGVudHJ5IGFsbG93cyBmb3IgdGhlIG1hcGxlDQo+IHN0YXRlIHRvIGJlIHVz
ZWQgaW4gb3RoZXIgb3BlcmF0aW9ucy4NCj4gDQo+IFVzZXJzIHdvdWxkIGdldCB1bmV4cGVjdGVk
IHJlc3VsdHMgZnJvbSBvdGhlciBvcGVyYXRpb25zIG9uIHRoZSBtYXBsZQ0KPiBzdGF0ZSBhZnRl
ciBjYWxsaW5nIHRoZSBhZmZlY3RlZCBmdW5jdGlvbi4NCj4gDQo+IFJlcG9ydGVkLWJ5OiAiRWRn
ZWNvbWJlLCBSaWNrIFAiIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gUmVwb3J0ZWQt
Ynk6IFRhZCA8c3VwcG9ydEBzcG90Y28udXM+DQo+IFJlcG9ydGVkLWJ5OiBNaWNoYWVsIEtleWVz
IDxtZ2tleWVzQHZpZ292cHJvZHVjdGlvbnMubmV0Pg0KPiBMaW5rOg0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1tbS8zMmYxNTZiYTgwMDEwZmQ5N2RiYWYwYTBjZGZjODQzNjY2MDg2
MjRkLmNhbWVsQGludGVsLmNvbS8NCj4gTGluazoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtbW0vZTYxMDgyODZhYzAyNWMyNjg5NjRhN2VhZDNhYWI5ODk5ZjliYzZlOS5jYW1lbEBz
cG90Y28udXMvDQo+IEZpeGVzOiBGaXhlczogNTRhNjExYjYwNTkwICgiTWFwbGUgVHJlZTogYWRk
IG5ldyBkYXRhIHN0cnVjdHVyZSIpDQo+IENjOiA8U3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4g
U2lnbmVkLW9mZi1ieTogTGlhbSBSLiBIb3dsZXR0IDxMaWFtLkhvd2xldHRAb3JhY2xlLmNvbT4N
Cj4gLS0tDQoNClRoaXMgZml4ZXMgaXQgZm9yIGFsbCB0aGUgY2FzZXMgSSBlbmNvdW50ZXJlZCwg
dGhhbmtzIQ0K
