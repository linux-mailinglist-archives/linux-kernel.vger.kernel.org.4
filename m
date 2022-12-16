Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4353864EDC3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiLPPWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiLPPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:22:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4B60374
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671204141; x=1702740141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b/QYAMRDoHLNxPj+jJGU474QqWGmT33OleMftb3HFfw=;
  b=aRFTFg/kKFXjgEurBE0kTA51YUo7Qulsd43M2RA0rnvq7qKiCUF/JDul
   NIyM+f74whBMfcvlkhv8KZR+gf2Zgun5ROQCy3uIUlCRx3sDzGlDQ0X8s
   QdEPN4j2Dcy67R4NdX4mbzWSdpkxLNDyhkR06YuVqM7nQcZA1uJeKAVnP
   ihQgKWTaqvzJmXS+1SsmBurRM76/BGQo+Jn3t3AuvcmmQvz20xDvCVXjR
   kwgwjOs3aSKZ3c9J66mGafTe1MgTJnoxDgvxnpsO4TkhAH4U2IDJi9kr6
   mCr+81PS6F/2dFye78UmQQZA+WAGOr0iAtxCpHqTNyuwirg4WD6BAfrkk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="381207585"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="381207585"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 07:22:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="713285097"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="713285097"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 16 Dec 2022 07:22:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 07:22:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 07:22:19 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 07:22:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UymjCmLr/nDOegwEZYpch6YdEAirqVLWtJdBghOG8ZFc0w9tv7II1KEYhtp/YikPtcH5zExCbImFvSJ2LE7Tar5vwZveb3eeEHB4wc269XAI2eO3StS2N/JkleNeJoOwx/BbBhMQj0j03EUmpX8DKM0NqWts8QsCelfmR7WBsv8amiveKBJ8foQKW5CczbioMKxQmrGBHOMwP6tip5sKx42KFztFSPh3gyy9ry5tt6f9SAZD45x3ltFwaXO3jLFN7BnFG/vIh5P33hxomL00rKlLv7/2iTNkPutblmGnHr5PwNQcgXwR0br2Czbi50XmljHW9BhO0FddxL37nlPSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/QYAMRDoHLNxPj+jJGU474QqWGmT33OleMftb3HFfw=;
 b=KK4eM2v+Nr4vUOzb9+xTk+Fak8aAaO0hbMh3QPCz3M0Efjq3Ok250dArn0LsM1pzdi01oglLescLB6lBSUSaECwanrKH4M85uDL1XOaVHVR/q1Jjq+R5NCeVtZewvUjPFt4NrtPo1fpLqE7Wn8uXfeV9ZHXJ/7N4AzHBLv6TC26oInTOCTlnOjdNuYEskF+HDFmEVfaECrnH0drWQUtVKGNoyUs5qU59ddrLiYDY6xuUmzGC0rmfsomH6J4hcCi2ZN/bnJ7E3kZE8ym8la2QNfb51CUJr6jPgj048NrcysgdorxWZkvlnjeLbz97TAXszG99GPcoi5YV4gKRodjc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.12; Fri, 16 Dec 2022 15:22:15 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4e05:a2f4:1f34:d790]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4e05:a2f4:1f34:d790%7]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 15:22:15 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] x86/tdx: Use ReportFatalError to report missing
 SEPT_VE_DISABLE
Thread-Topic: [PATCH 2/4] x86/tdx: Use ReportFatalError to report missing
 SEPT_VE_DISABLE
Thread-Index: AQHZC9HD8iLiGN2F4Eiy10+8ePcwSq5sd1OAgALB+QCAABJNAIAACVAAgAAmZgCAAFwRgIAA0uKg
Date:   Fri, 16 Dec 2022 15:22:15 +0000
Message-ID: <DM8PR11MB5750B5E74AFEAB83D8A7170BE7E69@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-3-kirill.shutemov@linux.intel.com>
 <3121847d-d334-67fc-43d8-0670c08c64b6@intel.com>
 <20221215171254.3v4maexfhkdnbfk2@box.shutemov.name>
 <795d6e1d-c79c-b079-3412-69ca2f8ee874@intel.com>
 <20221215185144.tjctmkwp5vodep3u@box>
 <b19600bd-d5cf-3359-60d8-1ecd9c1ff4f5@intel.com>
 <20221216023841.g7ebxefl2zglagek@box.shutemov.name>
In-Reply-To: <20221216023841.g7ebxefl2zglagek@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CH0PR11MB5265:EE_
x-ms-office365-filtering-correlation-id: 8555d6e4-25ea-4bf4-1273-08dadf795006
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +s3jP5TZWqfXlS2VoeWWPo74HGX7/t0omTvBbb5PAEX82PWkIRBa+YK8hd/2Jpw78wdWRGVTiDRwWgNG21FkCmJbqzk6k7yMIPpt68ZzyEzeMIj2fnbbiR6/Vc/2VxG94EnWRcQP0p+tQ/K3ik8Y0nuO4rFk/+reEUS1pvbUVMn4vHqhLOT4FL686QWcdQ2Y57i3XC7W1AqZuefHYv0+wLrP1wAHBKG/2P61ehiuXogeOQUawf62shcKd4tNA3A3oRZaQj947Bp4ml3D8aQ75i6kXcDLufTH524Ztb4zd4s6/NobR5Q7xTAOtEa9u58n/vXL22f4Rkktbil4LLALxqC6dQ5xJVRUKJakerlBXGXZ+1F5jbXyeWm/uM2DEqn7BHFUfv3IZ/AtlHO6LDk7Y3PZ2JTqvf2jisD7T4BzvBQQ1GStX04VlG7Y70NlQZj+yz2XhLyPa6HxgRlBqBuG3qd4ezAeSjFdWCWujfb/iiShjoUC4pdrizVyUt5FfckkcAPK2EGN0Lsg9jIvyijbNUbzHcR5wzyxuvddxXtJQNj88MQTs1Q8baATlHGBsdSbdK0sNlkDSfksoJFlbmzNxUDOgwjTBDOhlTGb3bDjHLGJq2qPrS+5UogJzAG//iEp+lLESTt3ryT1QH2RSiDyu+HoKmCMoUWMUI+laAxyvuNWFgQE/zq3GVOmg56mvvxYEffcRape2iWjL6uFT1d7iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199015)(82960400001)(52536014)(4326008)(66946007)(8676002)(66556008)(64756008)(66476007)(5660300002)(122000001)(76116006)(41300700001)(66446008)(38100700002)(478600001)(7696005)(83380400001)(316002)(6636002)(110136005)(54906003)(38070700005)(2906002)(33656002)(71200400001)(53546011)(26005)(186003)(9686003)(6506007)(8936002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUZiSTJJWFBDeitqMS8rTWd3WkY3WlBVRmowVXV6azNpSDIwRS9XQnZtd1hx?=
 =?utf-8?B?VEt0UDdHL3laNzNVNHFNRHl1TWZ0NjZrTFh3WlQ4WFFRLzhwN3pBbExhdE1t?=
 =?utf-8?B?WjZLZ0xxMFVuUk1DV0duNS94TDNheXgrQk82YWRKazEwbWMrN3MwNVpKTlBY?=
 =?utf-8?B?b0ZaQXBlaGtJNC9CL205QlVUQ0w4TUtscU5hajR2bTZ3Nmk5OTQ0SzBvYUNH?=
 =?utf-8?B?ZkxteS9BV3FLb2RIcy9oVjdSOWF6bmhJbVRKdUh5eFJSajRxWUwvY0xyOGQ2?=
 =?utf-8?B?UW5ydWxEZkM5V3UveEpuaEJHU0VJRDdFMGliZnRXOWgxQzhGUU5EV2hLWUla?=
 =?utf-8?B?RDVjdE9VampZV3o2R0dmaWRwQ2xicXVNMDRTdDA5NEFmQkh4TnhuTzE5eEpo?=
 =?utf-8?B?VXFFMG5KTFYvKzBFN3BrTnpZQ2NUZWRoQy9peEppWlNuZnExRU5leEx3blMz?=
 =?utf-8?B?SWM0MTJpWGJuTC9OcUYvdWxoQkFGUVlvRTh3QitzNHFCeTJLL1BEb0xJMHdo?=
 =?utf-8?B?SndJMWhTYzRXZHhIQVRNVjYxR1A3eWlGZGFzYWN5U1hWUmpWR0FiMTFGRzVL?=
 =?utf-8?B?a2hXYy85WUdwblhvY2d3eVh0ajBVbEV2NGhZS2hDN0czYkw3WS9HaFhXbGpP?=
 =?utf-8?B?ZFNaSGpRZThrRUpGdlhnWTB2R202cHJQYXpMUm80Yk9LT1BrRVN0eWV2WUZa?=
 =?utf-8?B?VTRjdkRsVWphdGM5ZEFkOUJ3ZjlkSVMxU042T29OTW05OVhEKzlrdHlJbjZt?=
 =?utf-8?B?dmV0czJUaEhHenl3WUhhNC8wcFE0bGU2U1ppcy80cGR6clRqenVpSTZLajJK?=
 =?utf-8?B?d25KVFhXNTBEYWVjRmV0QW5ubUM0bnBaRlpSRTZvZzJ1V2VGK3dLeEJxOXls?=
 =?utf-8?B?SnY2QThvM1krZUl3UUJQS3BHT1F5cmpnMms4Y0ZQc3ZoWWxWUTlxMEZ6SkJB?=
 =?utf-8?B?dm83NGEzb2VjWThRbkpPRGlYR0tKM2FRVURLTExXRU8yYVNuSXEraFBnQTZr?=
 =?utf-8?B?Sm12WVlMNGk5VUJBUWxaVEptR0dybVIwZisvMUhRM2ozbUlQVFQ0WUxWL1Nk?=
 =?utf-8?B?Z0gwNjNFVWUzMENZd2wvRnc4bVl2bnc3ZjdmNzV3TGp2RGNHZ1VFYUMvUkdp?=
 =?utf-8?B?YkJrTFFzK20wWjBNNjVJRVdZQ1NDZXNKQVYrRVk1ZHVLcVVHZE9ESEFucGJW?=
 =?utf-8?B?ZlJtMjRxbXpTZjROTU1mamhWVm43U1RXSHhlMTVMMnM5d3RzY2xNSWdmTFNE?=
 =?utf-8?B?NjZPOStJaDd6dkpBb3U5U3dUQ25BcE8rQkNNc1ZqU1hqR2xOQW9oM1RCV2lB?=
 =?utf-8?B?Nm15QWFsMTJoS3ZNeHk5NFQwcjAyR1N1bDdCYWZwdGpHSjlGUHNjaHZLREkz?=
 =?utf-8?B?b01KcjNpTGdieGNxQjFES05MR3ZSWmxhZ0RWU0ViNGwrSHRuRlYxNHFvd044?=
 =?utf-8?B?SFp6eldpTExUS25weE42Yzg4dEUwK1NpaDFDaGdYODlFelI2d1cxTFd4cUlU?=
 =?utf-8?B?WHhvcVJSOFk5VHNRUzNKWEdhckJhakljQjAxbmhBaDNsdnd5dEJiUHgxd3Z0?=
 =?utf-8?B?djhFL2lHS2tPbzh1K3BWSm5KaE1XUkk2Y2srT0dDdDVnVnZpejd3eDFDUTNG?=
 =?utf-8?B?SzBudHlpSXZKdFBBeHpXbDVDbHZkTmpJRnFHM1gxMzE3b0hGUGhCa1BhTjZy?=
 =?utf-8?B?WW5vdkJtTml4T2N3b2N1K0hQOGZNM1Z4VWVJRWV0Qm9rcHpOMk1qMVRaU0JZ?=
 =?utf-8?B?d3JZa0VDY21zbVgrelJEN0VpbU9XTmg5ekk1eHN6RWw1MHVXMXYyRFQ4MEph?=
 =?utf-8?B?YkxKYXhySldlZUcxL0xuOUhBU1Y4TGJMS29ma3lvUG5mOGdqcm16bEZPYTJC?=
 =?utf-8?B?QW5nRUZUbVQ0aU9UMEs5YUMzaXlTZ3FCMVJ5ZTY4SEdib2pWQmxWWXpHcVQz?=
 =?utf-8?B?ZnQ1SVJkWTR5U3BjKzBCdU5SRC8zZ2RkZTFEVXVJTU55SnliWksxbThtNjVK?=
 =?utf-8?B?MDVPeCtKVEJuUTh2UEl5aFJKZ2JzT0hhMUZySHdxRVNscXZFSjB2eEVNTXQy?=
 =?utf-8?B?OXhFL1VhOTlVWVZNL1BHNW9tV2NDRzRJZUVSSjdMZzZaRHVmblM5U20vaDZS?=
 =?utf-8?Q?CkcJL2XW1FjA8X/HgjX6Xyuvx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8555d6e4-25ea-4bf4-1273-08dadf795006
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 15:22:15.2646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23B3c3snq40q39ItI5Zmj5heMwNaITgWPkL9Wx+8XkFw0jplDh6rEi0iWc+FuDQNCrhixjZkaP6rDcQWbNecE5+flcBwJaUNiBcjaH3WAqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBPbiBUaHUsIERlYyAxNSwgMjAyMiBhdCAwMTowOToxMFBNIC0wODAwLCBEYXZlIEhh
bnNlbiB3cm90ZToNCj4gPiBPbiAxMi8xNS8yMiAxMDo1MSwgS2lyaWxsIEEuIFNodXRlbW92IHdy
b3RlOg0KPiA+ID4+PiBTbyBSZXBvcnRGYXRhbEVycm9yKCkgaXMgbm8gZ29vZCBmb3IgdGhlIHRh
c2suIEFuZCBJIGRvbid0IGhhdmUgYW55dGhpbmcNCj4gPiA+Pj4gZWxzZSA6Lw0KPiA+ID4+IERv
IHdlICpyZWFsbHkqIGhhdmUgdG8gZG8gYSBoYXJkIHN0b3Agd2hlbiBTRVBUX1ZFX0RJU0FCTEUg
aXMgbWlzc2luZz8NCj4gPiA+Pg0KPiA+ID4+IFdvdWxkbid0IGl0IGJlIHNpbXBsZXIgdG8ganVz
dCBkZWZlciB0aGUgY2hlY2sgdW50aWwgd2UgY2FuIHNwaXQgb3V0IGENCj4gPiA+PiBzYW5lIGVy
cm9yIG1lc3NhZ2UgYWJvdXQgaXQ/DQo+ID4gPj4NCj4gPiA+PiBPciBpcyB0aGVyZSB0b28gbXVj
aCBzZWN1cml0eSBleHBvc3VyZSBieSBjb250aW51aW5nPw0KPiA+ID4gV2VsbCwgSSBndWVzcyB3
ZSBjYW4uIFdlIGFsd2F5cyBoYXZlIGF0dGVzdGF0aW9uIGFzIGEgYmFja3N0b3AuIE5vDQo+ID4g
PiBzZW5zaXRpdmUgdXNlciBkYXRhIGhhcyB0byBiZSBleHBvc2VkIHRvIHRoZSBURCBiZWZvcmUg
aXQgcGFzc2VkDQo+ID4gPiB0aGUgYXR0ZXN0YXRpb24uDQo+ID4NCj4gPiBPSywgc28gbGV0J3Mg
anVzdCBwcmV0ZW5kIHRoYXQgU0VQVF9WRV9ESVNBQkxFPTAgaXMgYSBibGF0YW50IHJvb3QgaG9s
ZQ0KPiA+IHRoYXQgbGV0cyB0aGUgVk1NIGNvbXByb21pc2UgdGhlIFREWCBndWVzdCAoSSBrbm93
IGl0J3Mgbm90LCBidXQgbGV0J3MNCj4gPiBqdXN0IHByZXRlbmQgaXQgaXMpLg0KPiA+DQo+ID4g
VGhlIGd1ZXN0IHN0YXJ0cyB1cCwgdGhlIFZNTSBjb21wcm9taXNlcyBpdCBhZnRlciB0aGUgYXR0
ZXN0YXRpb24gaGFzDQo+ID4gcnVuLiAgVGhlIG5vdyBjb21wcm9taXNlZCBndWVzdCBzZW5kIGFs
b25nIGl0cyByZXBvcnQuICBCdXQsIHNpbmNlIHRoZQ0KPiA+IHJlcG9ydCBjb250YWlucyAob3Ig
aW1wbGllcz8/PykgU0VQVF9WRV9ESVNBQkxFPTAsIHRoZSBndWVzdCB3aWxsIGJlDQo+ID4gYXNz
dW1lZCB0byBiZSBjb21wcm9taXNlZCBhbmQgd29uJ3QgZ2V0IGFueSBzZWNyZXRzIHByb3Zpc2lv
bmVkPw0KPiA+DQo+ID4gVGhhdCBhc3N1bWVzIHRoYXQgdGhlIGF0dGVzdGF0aW9uIHNlcnZpY2Ug
a25vd3MgdGhhdCBTRVBUX1ZFX0RJU0FCTEU9PTANCj4gPiBwbHVzIExpbnV4IGlzIGJhZC4gIElz
IHRoYXQgYSBnb29kIGFzc3VtcHRpb24/DQo+IA0KPiBJIGtub3cgdGhhdCBhdHRlc3RhdGlvbiBx
dW90ZSBpbmNsdWRlcyBhbGwgcmVxdWlyZWQgaW5mb3JtYXRpb24NCj4gKGF0dHJpYnV0ZXMgYW5k
IGtlcm5lbCBoYXNoKSB0byBtYWtlIHRoZSBkZWNpc2lvbiBhbmQgSSBhc3N1bWUgdGhhdA0KPiBh
dHRlc3RhdGlvbiBzZXJ2aWNlIGlzIGNvbXBldGVudC4gU28sIHllcywgSSB0aGluayBleHBlY3Rh
dGlvbiBMaW51eCArDQo+IFNFUFRfVkVfRElTQUJMRT09MCBnb2luZyB0byBiZSByZWplY3RlZCBp
cyByZWFzb25hYmxlLg0KPiANCj4gRWxlbmEsIGlzIHRoZXJlIGFueXRoaW5nIHlvdSBjYW4gZWxh
Ym9yYXRlIG9uIGhlcmU/DQoNClllcywgYXR0ZXN0YXRpb24gcXVvdGUgaGFzIHRoZSBhdHRyaWJ1
dGUgaW5jbHVkZWQgZm9yIFNFUFRfVkVfRElTQUJMRS4NClNvIHRoZSByZW1vdGUgdmVyaWZpZXIg
Y2FuIGNoZWNrIHRoaXMsICppZiogaXQgdW5kZXJzdGFuZHMgdGhhdCBpdCBpcyBpbXBvcnRhbnQu
IA0KSG93ZXZlciwgaXQgaXMgYSBiaWcgKklGKiBpbW8uIEluIFREWCBtb2R1bGUgc3BlYyBhbmQg
YXR0ZXN0YXRpb24gc3BlY3MsIA0KU0VQVF9WRV9ESVNBQkxFIGlzIG1hcmtlZCBhcyBhdHRyaWJ1
dGUgdGhhdCAicG90ZW50aWFsbHkgaW1wYWN0cyBzZWN1cml0eSINCnZzIFRVRCBhdHRyaWJ1dGVz
IGxpa2UgREVCVUcgdGhhdCBhcmUgY2xhc3NpZmllZCBhcyAieW91ciBURCBpcyBub3Qgc2VjdXJl
IGF0IGFsbCIuDQpTbywgd2Ugd2lsbCBiZSByZWx5aW5nIG9uIHZlcmlmaWVycyB0byB1bmRlcnN0
YW5kIHRoYXQgaW4gTGludXggY2FzZSBpdCBpcyBhIGNyaXRpY2FsDQp0aGluZyB2cyAicG90ZW50
aWFsbHkgaW1wYWN0aW5nIHNlY3VyaXR5IHRoaW5nIi4NCldlIHdpbGwgZG9jdW1lbnQgdGhpcyBz
cGVjaWZpY2FsbHkgaW4gb3VyIFREWCBndWVzdCBrZXJuZWwgZG9jdW1lbnRhdGlvbiwNCmJ1dCBJ
IGhhdmUgbm8gZ3VhcmFudGVlcyBvbiBob3cgY2FyZWZ1bCBwZW9wbGUgYXJlIHJlYWRpbmcgaXQu
ICANCk15IHByZWZlcmVuY2UgaXMgdG8gZG8gdGhlIHJpZ2h0IHRoaW5nIGluIGNvZGUuDQoNCkJl
c3QgUmVnYXJkcywNCkVsZW5hLiANCg==
