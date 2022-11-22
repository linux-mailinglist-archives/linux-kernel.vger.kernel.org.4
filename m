Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517AE634AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiKVXFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiKVXFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:05:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBAF8FFBE;
        Tue, 22 Nov 2022 15:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669158330; x=1700694330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qwgUkuK1QxSzNJgxpWswPN1JVpmfPFvc8gFnoy6Wn6w=;
  b=mBhS/BdYymusvHSLuQDO180jJb+FVhKB2VHjzCss4xG5WNhmagvculF2
   q+eK3jo/Qwoe9cU+S1EyDRDE0vShxC8ZVbw8BG/BGHaTEzGlljMvBeDn2
   ZHpwdK4nBzKkLl56uzBJPkKXAFitugsiwt+B7f9K3sU4u4X5NyhhuSyId
   OqMJ7cg5ZgE+t3uJu48rS7UzhiyzrqkkHkeq1dspdDNmbB1YMbhJplrYh
   deSBKCiaVTLi60ij8NC3pPPTQjOcqEGvpnkqtyWkMpwCv5uNfQqdnVFeu
   nm9HIXIhTCqkRnW+hEz91DwE+oj/dMfoZyn60Qwe4J5YusQbI0ZTe0WMr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="301489579"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="301489579"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:05:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="766499504"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="766499504"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 22 Nov 2022 15:05:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 15:05:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 15:05:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 15:05:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEQJBTtQV8++V7JXbVOy+nDVD8B1UL3ehG7y0UYmP6nVTQchaAD8kfrFLqQnfgbsgBVeGV1PjVY0lNy2s4/4FwpYx8Ew8XMgscq33CUhBRaT2ZOkYfBguV01S7JX4M2AoeltqcZceDVy8aZimnyL7JqvOE4mo3ZBOuaVUWW3DATeTzcVlb/vHo2kUcqJmWRczf8DKTXvDWDa+hsEeoQH+AsodX4XSiupw0l8BsS5ghr+CMwXGvJ+Vk+n1UAS7AupcUss3Dlr+n7gspREK+mZRfN1CfQm/0m9psFFy1dN6H46J3l1llpF/4UM0LASsZqX7o19+59zYTt3UvN6osO2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwgUkuK1QxSzNJgxpWswPN1JVpmfPFvc8gFnoy6Wn6w=;
 b=AHNkPZlt2Wag1o9wHb2tbQ2p/3riafTkZaTrlp0MqIX1budLg3OLevd0DB7n9sohfkbgMZcSbfxHxGp5hmaLWiE2mi9XBZzwKYKFjd4ceUwiREofGMyeXH3Mj20xoBUzud4/m776Wg0wtmoGktpClw1q4BENiJGwrVUDbrf6KPLWM08RUBGiDbhXSQ/NbFGKFzhZDl2rQ1R4OOs1c3AsY3q5U2vnS3VP02fC/Zf+eQ0TzQ6wAzzs1Rod8erZxSzGWxN17kCB899yUc32SXgfFtMf3J2mdpArCsn19OadgbMCzIjZL3W/T8DaE2N55Ne1A4rR/1unRHbCgv9j6Jbo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 23:05:27 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%6]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 23:05:27 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] mm: Make vmalloc_dump_obj() call in clean context
Thread-Topic: [PATCH v3] mm: Make vmalloc_dump_obj() call in clean context
Thread-Index: AQHY+uTOpQ3AnwpdEUCtphQz9Z9WFq5LlqMg
Date:   Tue, 22 Nov 2022 23:05:27 +0000
Message-ID: <PH0PR11MB58802C9BF5683925DF983A4FDA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221118003441.3980437-1-qiang1.zhang@intel.com>
In-Reply-To: <20221118003441.3980437-1-qiang1.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SJ0PR11MB5070:EE_
x-ms-office365-filtering-correlation-id: b53523cd-2757-4463-b2bb-08daccde0b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LcGnZamD/8Dz2g80Tafvv9zvNfpILTrj0Vw04mcHOILcuWCRvm47C0XU7SCx+s+EZ738J3DyD/sYcUM/YHX2yCMG4lk0y3GCJ3R2krPc9iJX9wdlE+CAGPnix0sRUT8Hi6jDIG3dEnE4wHPx4MzJUSG2r3c/rHdj+i71tnWV0ICIMTVRg8dLHgThP87gjv/dpZK5mhRnmXVBK+ul3+bCwoXyHlILRrg/rSg2PvreK4TU+ewVVe48cLv+FRHOOCpDCxxR8pI/3ZeTqNJzA2Xins6F/bgDCklwGyuyJWUaNDVbK91iP8jC1BCPsUz9n+ff0Vko0PVH1OBGwPd93A3dcavtrZSgLzZ/wX4XAAIP5AhPidQ0v+rBStuhDdL4vvLNYACjPXLUD6xepTwjAR2LXI82Ud9ebF+K4DFrAYPoOu76geAS5QEbObINuL61OZlXmCLwnJWfJKg2fn8mub8+MiCB0BmEhZajuDl9rDORG2gm9s5zBWGmzZjcNKOReZoz4PekuFdIuVVCdUQbnPgxfLa3rtEQZZcxrFqhlfIU3ELeU7pGmGJdwfJbVcgv4VDv4/CrMdii3im1kHsgrhXRhMkQoHDnHAHTtGUDrmEL/dzUGfQ7W5dVZ6Livi7rr3I2HqUA3gbK57WWQriiJ4tQnrRuOpRTNZxx1YkuXmXoqijzVTjMMYuhpvYW5a7ywV/mNL0Jw2ORT600AKtPQFlqNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(82960400001)(122000001)(38100700002)(86362001)(6506007)(8676002)(33656002)(38070700005)(7696005)(186003)(71200400001)(26005)(5660300002)(9686003)(316002)(66446008)(76116006)(64756008)(66946007)(54906003)(66476007)(478600001)(110136005)(4326008)(52536014)(83380400001)(8936002)(66556008)(2906002)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFB2aWpxMjI2bkxndnZhNDRJOU1Ja3ZycnhuOUFTb0tvcXNJYXh3MEF1MldN?=
 =?utf-8?B?a1hpMUw1N0J0SnZqdmZ2bFdBU25vVVh2Tml1cHRzK1J4KzMrL0lZdHh5enJB?=
 =?utf-8?B?ckMzTEJtc1BTNUpyMm9lZk42T0UzRGJqcDRST1l4Sk54UXlvN1NPVEZQQWVQ?=
 =?utf-8?B?UWp1cTc4OEdlTmtqMGp6MlEyaW8xVnpXVmJ0eHhDak5lM3FEN2w1VVMrNDcw?=
 =?utf-8?B?c1V5U0RrQjd2Tkc3TG1CY2VkVDBtTnN5UXJPN0pPRGpRbzkzU09BVnpsM0FI?=
 =?utf-8?B?czNBd2FBdEdsRlJObXVYb09ZbzZucHJYTjZwS2FOQjlRak9WeWFhYzJhVEhu?=
 =?utf-8?B?V25KS0lzNlpYSkdnaklZUzFIR1RiWlAwOEprdEthK1FoSGQrM3MwNkxjeGpq?=
 =?utf-8?B?VVhDRjhsbnhEdlpVZWNKUUgwS01neElqVnYramdMWCtnSEhjeEQvbXRDdXUz?=
 =?utf-8?B?ZDVyM2VwaW5uTG1qeE44ZHRvalhTcm9sSmpCRUlOTEo5aE5zdllUTHpWWjFW?=
 =?utf-8?B?WmFLMmx5WEY3WGxGNEgxQ2h4VjVrQ2tCRTAyeDBDSGhHZHU1MFlVUDAxckF0?=
 =?utf-8?B?elc4Q3RTL1BxZmR6R21wVXBsTzFnQ21hM2d6eTlSUUYrRTZpdUtzR2UwTThq?=
 =?utf-8?B?dlFRT2c0N05kUENMSjYyMXRpR20rZjJnRzVmaWVzQUpaVnczeCsyNGJEUXBM?=
 =?utf-8?B?dCtZdnZLYUhVWW1ET1dZKzVPUWJldlpnOC9NcWRoWnZJU2d3RkxOY1NtZEJ5?=
 =?utf-8?B?Yjc4ZXlFZnllejJPU2RVaW5LN0RXSTc3SmxyTU1vQi9ZRDhBM0JDcHQ1Uzlw?=
 =?utf-8?B?ZFRpSHIwcTJyYVhWNG9NSStRNzZuTXFud3lGaTUwVDkvREo2eUZwc0RIZUNn?=
 =?utf-8?B?MlFLUDZTK1lMZEg1U3MySnE4aDRvWWFBbGNuS0VDQitybUxWL05laDA1VmhR?=
 =?utf-8?B?YmdOQzZiMFJ3RnB5REorQjZIQjNaODBibEpHa0pBQUtqbUNsak8ySUJrdE4v?=
 =?utf-8?B?QWtBUEJEOHI3T0ZwN00zY0dKQ2t2bGhaTW9pRXg2ZXZhNTAvYjdTQ0p1S1Bk?=
 =?utf-8?B?ZUVIRnFEM3I2L0pCc3RMNzhCLzhpUGhCMG1MM1AxNHFheDFrRWlJWkNnUkJV?=
 =?utf-8?B?ZCtieC9vc1BlM1gzQVg3eFpBTUZoTWRmaUtCbW1UQkdxYnRsUEhiSGkyVEts?=
 =?utf-8?B?NTZpK0Qvbi9xYWEwOGRFd0R1Z1NGRkJVQzF5OExaSVhNTlZKVzVBb1U1VUdx?=
 =?utf-8?B?dEtnclI2THRJV1ZuUnNNbVZtL3dzcWFFWjNDSnc2VmFXS3J1OWxid3RQd3Fy?=
 =?utf-8?B?Sko5aVhDN05SV2RIbW5YRmJhNW1FclR1a3o5WktwZGg5R2w3Y01SaVJQL1lJ?=
 =?utf-8?B?eVJQL0U5V0x0WVV6bHkrTWxNN0c2WU5TLzBVOHdOZTh3RGdVNk8zNUxVZklW?=
 =?utf-8?B?Y29xbWJ2eDRNd0ZOOFA1bC9LMExJSDRPS0FBNWkvbHRoVUpqUExJd2VCVDlU?=
 =?utf-8?B?alYxY1ZObmxJTlhRam5XTEhKOEo5bnQwRnZyTzRZd1A3Z3MxQlRGeUxCS3pj?=
 =?utf-8?B?MU5qeVh5dGFUZ21nOHdJaXVxZmdac3ZVem9qdU5sQVNCNmh5Nm8raTFpNkpI?=
 =?utf-8?B?UFpjeEl2Q2xwa3JsRWNEMzhTNnpIT0ZHQWFBS1dwQTRIZ3NHVTc1ZkN0VVFl?=
 =?utf-8?B?M1RNKzhSbksyYW9YVnM2b2ZTdTYvaTBBalZqQWhXMTBHb09WOHhoV0ZHUGRL?=
 =?utf-8?B?M1VsMmhhRUZLWHBWWWlybjNycS96ZUZOTkxNbmIyQzJ4aitSZkRjTHBXSDZw?=
 =?utf-8?B?bGNwTnBUdjc1Y2UwSDI0OHJPTGVpSmdEY2E5NG5ORUUvRVBrSG1RV2t2aGZZ?=
 =?utf-8?B?T0lzdHozZ0twc1JuRm9sdlZpY1J2dHkvV3pZTUpXUlg3Zi9CcXR1bTFKZS9p?=
 =?utf-8?B?SXVxbklzZnkvajJGU1FmUFQ2a3FVWUcyelo4dFcwSTA0WXNkclhBdDFrS004?=
 =?utf-8?B?RnhCaDhtUk5jOC9iSWJ1L2hRRVJTNkg4TXE0b1dycnZ6Q1NLUmdxRWRieHV2?=
 =?utf-8?B?SXV4Z2JuRzFLeUNVdXFNZ1VobzN4NitOZ3lPM2NNNU1Zd0E5MEpCanljaUtP?=
 =?utf-8?Q?tDQQuxwy0k7tcmMsMIAcq0n0U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53523cd-2757-4463-b2bb-08daccde0b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 23:05:27.1479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aq84kEwDinoKcyW6z6IZk9FOLUS7w26eGbdai8V1BB0YPp0Igg92S6EDQbGcZbYdixA/vJRHsg6Ej1/pZ75EZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpHZW50bHkgcGluZyAg8J+Yig0KDQpUaGFua3MNClpxaWFuZw0KDQo+Q3VycmVudGx5LCB0aGUg
bWVtX2R1bXBfb2JqKCkgaXMgaW52b2tlZCBpbiBjYWxsX3JjdSgpLCB0aGUNCj5jYWxsX3JjdSgp
IGlzIG1heWJlIGludm9rZWQgaW4gbm9uLXByZWVtcHRpdmUgY29kZSBzZWdtZW50LA0KPmZvciBv
YmplY3QgYWxsb2NhdGVkIGZyb20gdm1hbGxvYygpLCB0aGUgZm9sbG93aW5nIHNjZW5hcmlvcw0K
Pm1heSBvY2N1cjoNCj4NCj4gICAgICAgIENQVSAwDQo+dGFza3MgY29udGV4dA0KPiAgIHNwaW5f
bG9jaygmdm1hcF9hcmVhX2xvY2spDQo+ICAgICAgIEludGVycnVwdCBjb250ZXh0DQo+ICAgICAg
ICAgICBjYWxsX3JjdSgpDQo+ICAgICAgICAgICAgIG1lbV9kdW1wX29iag0KPiAgICAgICAgICAg
ICAgIHZtYWxsb2NfZHVtcF9vYmoNCj4gICAgICAgICAgICAgICAgIHNwaW5fbG9jaygmdm1hcF9h
cmVhX2xvY2spIDwtLWRlYWRsb2NrDQo+DQo+YW5kIGZvciBQUkVFTVBULVJUIGtlcm5lbCwgdGhl
IHNwaW5sb2NrIHdpbGwgY29udmVydCB0byBzbGVlcGFibGUNCj5sb2NrLCBzbyB0aGUgdm1hcF9h
cmVhX2xvY2sgc3BpbmxvY2sgbm90IGFsbG93ZWQgdG8gZ2V0IGluIG5vbi1wcmVlbXB0aXZlDQo+
Y29kZSBzZWdtZW50LiB0aGVyZWZvcmUsIHRoaXMgY29tbWl0IG1ha2UgdGhlIHZtYWxsb2NfZHVt
cF9vYmooKSBjYWxsIGluDQo+YSBjbGVhbiBjb250ZXh0Lg0KPg0KPlNpZ25lZC1vZmYtYnk6IFpx
aWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4tLS0NCj52MS0+djI6DQo+IGFkZCBJU19F
TkFCTEVEKENPTkZJR19QUkVFTVBUX1JUKSBjaGVjay4NCj4gdjItPnYzOg0KPiBjaGFuZ2UgY29t
bWl0IG1lc3NhZ2UgYW5kIGFkZCBzb21lIGNvbW1lbnQuDQo+DQo+IG1tL3V0aWwuYyAgICB8ICA0
ICsrKy0NCj4gbW0vdm1hbGxvYy5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAy
IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj5kaWZm
IC0tZ2l0IGEvbW0vdXRpbC5jIGIvbW0vdXRpbC5jDQo+aW5kZXggMTI5ODRlNzY3NjdlLi4yYjAy
MjJhNzI4Y2MgMTAwNjQ0DQo+LS0tIGEvbW0vdXRpbC5jDQo+KysrIGIvbW0vdXRpbC5jDQo+QEAg
LTExMjgsNyArMTEyOCw5IEBAIHZvaWQgbWVtX2R1bXBfb2JqKHZvaWQgKm9iamVjdCkNCj4gCQly
ZXR1cm47DQo+IA0KPiAJaWYgKHZpcnRfYWRkcl92YWxpZChvYmplY3QpKQ0KPi0JCXR5cGUgPSAi
bm9uLXNsYWIvdm1hbGxvYyBtZW1vcnkiOw0KPisJCXR5cGUgPSAibm9uLXNsYWIgbWVtb3J5IjsN
Cj4rCWVsc2UgaWYgKGlzX3ZtYWxsb2NfYWRkcihvYmplY3QpKQ0KPisJCXR5cGUgPSAidm1hbGxv
YyBtZW1vcnkiOw0KPiAJZWxzZSBpZiAob2JqZWN0ID09IE5VTEwpDQo+IAkJdHlwZSA9ICJOVUxM
IHBvaW50ZXIiOw0KPiAJZWxzZSBpZiAob2JqZWN0ID09IFpFUk9fU0laRV9QVFIpDQo+ZGlmZiAt
LWdpdCBhL21tL3ZtYWxsb2MuYyBiL21tL3ZtYWxsb2MuYw0KPmluZGV4IGNjYWE0NjE5OThmMy4u
NDM1MWVhZmJlN2FiIDEwMDY0NA0KPi0tLSBhL21tL3ZtYWxsb2MuYw0KPisrKyBiL21tL3ZtYWxs
b2MuYw0KPkBAIC00MDM0LDYgKzQwMzQsMzEgQEAgYm9vbCB2bWFsbG9jX2R1bXBfb2JqKHZvaWQg
Km9iamVjdCkNCj4gCXN0cnVjdCB2bV9zdHJ1Y3QgKnZtOw0KPiAJdm9pZCAqb2JqcCA9ICh2b2lk
ICopUEFHRV9BTElHTigodW5zaWduZWQgbG9uZylvYmplY3QpOw0KPiANCj4rCS8qIGZvciBub24t
dm1hbGxvYyBhZGRyLCByZXR1cm4gZGlyZWN0bHkgKi8NCj4rCWlmICghaXNfdm1hbGxvY19hZGRy
KG9ianApKQ0KPisJCXJldHVybiBmYWxzZTsNCj4rDQo+KwkvKioNCj4rCSAqIGZvciBub24tUHJl
ZW1wdC1SVCBrZXJuZWwsIHJldHVybiBkaXJlY3RseS4gb3RoZXJ3aXNlIG5vdA0KPisJICogb25s
eSBuZWVkcyB0byBkZXRlcm1pbmUgd2hldGhlciBpdCBpcyBpbiB0aGUgaW50ZXJydXB0IGNvbnRl
eHQNCj4rCSAqIChpbl9pbnRlcnJ1cHQoKSl0byBhdm9pZCBkZWFkbG9jaywgYnV0IGFsc28gdG8g
YXZvaWQgYWNxdWlyZQ0KPisJICogdm1hcF9hcmVhX2xvY2sgc3BpbmxvY2sgaW4gZGlzYWJsZXMg
aW50ZXJydXB0cyBvciBwcmVlbXB0cw0KPisJICogY3JpdGljYWwgc2VjdGlvbnMsIGJlY2F1c2Ug
dGhlIHZtYXBfYXJlYV9sb2NrIHNwaW5sb2NrIGNvbnZlcnQNCj4rCSAqIHRvIHNsZWVwYWJsZSBs
b2NrDQo+KwkgKi8NCj4rCWlmIChJU19FTkFCTEVEKENPTkZJR19QUkVFTVBUX1JUKSAmJiAhcHJl
ZW1wdGlibGUoKSkNCj4rCQlyZXR1cm4gZmFsc2U7DQo+Kw0KPisJLyoqDQo+KwkgKiBnZXQgaGVy
ZSwgZm9yIFByZWVtcHQtUlQga2VybmVsLCBpdCBtZWFucyB0aGF0IHdlIGFyZSBpbg0KPisJICog
cHJlZW1wdGlibGUgY29udGV4dChwcmVlbXB0aWJsZSgpIGlzIHRydWUpLCBpdCBhbHNvIG1lYW5z
DQo+KwkgKiB0aGF0IHRoZSBpbl9pbnRlcnJ1cHQoKSB3aWxsIHJldHVybiBmYWxzZS4NCj4rCSAq
IGZvciBub24tUHJlZW1wdC1SVCBrZXJuZWwsIG9ubHkgbmVlZHMgdG8gZGV0ZXJtaW5lIHdoZXRo
ZXINCj4rCSAqIGl0IGlzIGluIHRoZSBpbnRlcnJ1cHQgY29udGV4dChpbl9pbnRlcnJ1cHQoKSkg
dG8gYXZvaWQgZGVhZGxvY2sNCj4rCSAqLw0KPisJaWYgKGluX2ludGVycnVwdCgpKQ0KPisJCXJl
dHVybiBmYWxzZTsNCj4rDQo+IAl2bSA9IGZpbmRfdm1fYXJlYShvYmpwKTsNCj4gCWlmICghdm0p
DQo+IAkJcmV0dXJuIGZhbHNlOw0KPi0tIA0KPjIuMjUuMQ0KDQo=
