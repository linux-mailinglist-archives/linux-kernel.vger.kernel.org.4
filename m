Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D4F66A21C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjAMSbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjAMSag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:30:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5247EA52
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673634406; x=1705170406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3nT4WfAv3H3escHn6+tEtEckzEF4qezqd7x1AScj8sY=;
  b=cSCG2bIzu5kn3JE/vDbNtlBqYQ94ZAwRMSJ6rIFe67fFcL/DiESdVDpZ
   ezcRjcxLZj1Ielh08iT9aEt3LBJPSl7n/iGsFc1fMwhR6Rcz+vwrLRXYo
   7NkH/Sd7/0HDyl+cI7gYuDgI1av9bV9+rgJm8YLY99LgKvDYiK4PDStVa
   4olernXcuxL53Gm9QZInhBFBlxAVLjyrSKN9m336E1VdpmbI3PSbpHqka
   /fRIXCUnS/CAjHB2VOiIzs0Oj9iXSSgv3gbMjwROJm0qrHgDgItzc/2oB
   UKXe24sWKUgOTMTqTx6rYSS1PlU1OdABE6CV+wh9XvRCsxfrfvKTWqP31
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="303759026"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="303759026"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 10:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="690580392"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="690580392"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2023 10:26:22 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 10:26:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 10:26:21 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 10:26:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgwQnGVauWIQ/n5svwbLuSrNVPG6Rb+gNepKl5Q/bIa/8+MXGYN8KiQnG6P2rfIL2z/3RAuMrf9tXTmL2kFJcd+gP2lSuDU8GCHO9DHbWD/QtnVYdyG+z0lrPt180KQgKRVowOqJBU/iY80cld8ZmgJU5yEW2MTbb9P+pzTHfv95p/JxPH1GH7o0DvUCzkxbTEU5ueFEJOVkNadjwcO4+V4nXBmr7YIIdoWYDjV/PzPVkFkmtRWB+Brx0kB0hvaV7ulh6Xm09GzE3ACCtk102Fcm1esVjcgFURmNWbPpZwj/bv08b3nc9fd+AcIdXQYIgCKuCw0fYtHL9lbOsD0V3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nT4WfAv3H3escHn6+tEtEckzEF4qezqd7x1AScj8sY=;
 b=bGxbmQlR/5f5v8k59NCuKMV4f17z80qiejgYwhm7oUToF7cil2c/JiP4bKfQAfKPvlPlT+w8xeDy8dpiMUVIq5V2zoW3Ff88U5/u6xCiosVLS1SOswNNq81l3VJLEoCTAcR9lUxep1soM9VoeAtyk9LZhzg7e3PTvxyHq4jlpk/cHvZrsIXu18SGpp82durKBGBcbVppqsw9dB47mSHSyNNMIy4YUoHR+Dv/1m1Sa152jem6jc5x6MGpBEFE7FZK9yMkA3BnovGwM1AmjJy1w0nel6BsfWySRHgJuj26barJ696q0CTPbBf4Opstl9+NvGaiRj9yWuNUUduwjXmYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS7PR11MB6014.namprd11.prod.outlook.com (2603:10b6:8:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 18:26:17 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::52ef:33cf:9be9:fcb0]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::52ef:33cf:9be9:fcb0%4]) with mapi id 15.20.5986.019; Fri, 13 Jan 2023
 18:26:17 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>
Subject: RE: [PATCH v6 0/5] x86: Enable LKGS instruction
Thread-Topic: [PATCH v6 0/5] x86: Enable LKGS instruction
Thread-Index: AQHZJlm6uTkjdY/2K0+2oO+/lS8Doq6asdEAgAAtzICAAXnQAIAAUqtg
Date:   Fri, 13 Jan 2023 18:26:16 +0000
Message-ID: <SA1PR11MB6734571ED95606FD753D0A4AA8C29@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230112072032.35626-1-xin3.li@intel.com>
 <Y7/5YPxbRE2AWgT0@gmail.com>
 <Y8Afy2J0io8F510i@hirez.programming.kicks-ass.net>
 <Y8Fcum+SkeQB9B4H@gmail.com>
In-Reply-To: <Y8Fcum+SkeQB9B4H@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS7PR11MB6014:EE_
x-ms-office365-filtering-correlation-id: 5e8c57b2-a249-44de-ab25-08daf593a8f3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7C43fqxC04cnTzHnfxLgyjBbNisB5qJ0nRp0r2Y+/Rp7SEoNMQjbKsmj4s5BZUuabPFKHjL1HtwadggGHQTqMMEtOpeJ4wraSKKjrE+I9YDdpuNG661nLcue9vd+hJFlIul5nFYjlORuV3D4Mo6ygPXKAupKK/BiJsUy1KybreMGxCIXgdZgghBkACkcWViZwO9vSlaRsjFD6gm0I/F/CJbQIAQRbffJ2CnKyy58JXWDiArKKJ1z0GS8+cebxDr0mW+wK+k3kHR5b5/vUELWmByMYeM5fht5UnrVpwWEjciKKzAQ70K6vrdewNwBTxzlmtTvMEP5n9WTbjx+mDkwgHeLDXsjPjESmqglWo55KjyICiyvEfWGPcE+UMpyF4ha47US84J3tveytn1fxmiSjX8qAh7QPLWADDtHlSCjvJqFUwX+qRqGarIygt7ya2vHQw2O5M55JcHes0QBNBPVI/jTDe2QrT8BboTr147B5NwTImROx+iZUS7riuTm2DVPDUnQqHdp4obY+wL+wkv2qIPV/XRSAZOLo/dFN+yx71VH43fpGKZrNzH4I4OMOhRGucux1zhTpWsuyXv14HAUFemcK81YDuGJqYvVFP7R1B1kKe+hzdgaH5UDN0QgTtriN0gXyBqYsSkNzDADd1WIFtkMKVmXvqnKDGs/u2B/xFcGavusSFR3kPstxndqK5w7neWbYQL7z2f9EDk+ZAesA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(110136005)(8936002)(52536014)(5660300002)(7416002)(54906003)(41300700001)(66946007)(76116006)(2906002)(316002)(4326008)(66556008)(66446008)(8676002)(66476007)(64756008)(71200400001)(82960400001)(186003)(122000001)(38100700002)(7696005)(9686003)(26005)(6506007)(33656002)(478600001)(55016003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGxPcnhBZEo5YlhPZ0tqRGZhRWZSN1RjQ250dHhlN3pkZWp3bzJTdjViRExJ?=
 =?utf-8?B?M0NqeEFpTkg5dTVQOW9PWXlUUWc3ZG1wN3pnLzJaaFNhZWhKRjRUWEZ6RTRt?=
 =?utf-8?B?anRBSzJXaENDSUJjTXBSQzJ3SWoxM2tKWGtqakJLWTRsRzZ5ZENONU1VZzNQ?=
 =?utf-8?B?MFhocWNGbXg0bERia002aEhHalYvM1RuSWhPdytzR09YUkpmd09OcDdjRGVI?=
 =?utf-8?B?MkZFUXBjWGhPUmlpOFd6VWxrYURrSmNzbnhnOHRsZ3lqOG12dmF0cnVGNmIy?=
 =?utf-8?B?eC9CSFZRQVZ6amtWSkNVL25aV3NJakp5MW1iK1Rwd25xS0E3QnlOT29GNXQz?=
 =?utf-8?B?L1htSmUwc3dxaWR2T0F5UlVuOFhLQ1k4Zmd2Um9QQWFQYzVuRG5kbkN6TWZB?=
 =?utf-8?B?dVphUmE0a2ZvenF1SzFReW5iMGw4VmI1MDdKMUxpMVlMaXJ6SFcwMWhEYlRZ?=
 =?utf-8?B?UmpQTkpOenZJYTdkZXI2Q21VS2ZXclNEV3U4aFB2Q3dBVnBibUVBU1Y5M3lR?=
 =?utf-8?B?aDNaUVpQNjF5WmN4Ujk5dWhYOFNkbjVpZitGbzcrYzZERkh6YmZFbk1qVjFI?=
 =?utf-8?B?NEQxK1pYWDIrcUo4ZDBqWkRLV2xSOHY5MmtDbmYxOUNBNnZmVGlSWEdJajZ5?=
 =?utf-8?B?MWZyV0R2dVB6czc5dDZSc1FEOEU4amQ0aVhBWkdMeUxwck5rMmNYYzdUT21E?=
 =?utf-8?B?UmNhd2ZqQWpvRHdMcldkMUgwdTRGTFduRGRRTVFZU2l6QnlwbGRKaS9saFU4?=
 =?utf-8?B?bWRvOW9sZ2xhRzNhQUExcUd0LzQrUTd2RWJZVm5nN2luNjlDdlczNStweDgz?=
 =?utf-8?B?OXhHR1R4YUk4MzVVZFRyM3h5SlBHYm9tcjZHLzh2VXc1UVEwVldBU1UyQ2xh?=
 =?utf-8?B?SDM0Y2hiRzJLZkRmMGcvWjRZcXc0c0RyY2lndnRZVUMvWHZqaXNsR1dwRUl0?=
 =?utf-8?B?OEp3VUxqbEVYWk93QnIxRnVlUzBqci9WSWRvbVFaRzBtTTFHY2dkUXZtcXRG?=
 =?utf-8?B?Nnl5QnhmRjAzTm92Ynl2bktRWXJISmh0eVYyN2h1b3RlMWlYYWdtKzhGaXFn?=
 =?utf-8?B?UUFwOWZJSkJVWE9YQUU4STQyUXUrMFpOcEErNnlNMG5SYmFvdjBNaTYvZFRz?=
 =?utf-8?B?NVloaGtWVCtrbE5XaXMyTlQzNkhjYVlqSVZSbXdsVVpPUHF4cU14bE9WTm1V?=
 =?utf-8?B?N01aTjExZ3cveVpSUGRKSVMrVVNDc0ZxWXM2b1gvQkcrY25kQzZFd0pBbEdQ?=
 =?utf-8?B?aWxlc0ZSMGpOejZObkpZcklEdEtSdUlDSlZSUlg2UXFnSmhsWTRwOHVlSEV1?=
 =?utf-8?B?YXhveXdrbmpmTnRHTEY4WGtQQW9MZi9WdnVOaWY2eFNxdkIzNklFQjd6ME5I?=
 =?utf-8?B?VjNhY1VuRFZqb09mbXNIbytKKytWdmR3VCs0Y1FzQ21XdmZuTy85RExNQWtS?=
 =?utf-8?B?dEhkSWo1T1B6STUzRG1vZlZCaHZOSTBMTnQ5dURLYUhXOGdlNkRSejNuMWFH?=
 =?utf-8?B?MWhudTcrdlZQME9oYVVGWEpLQnpUYjF4b3VTWDVaQVRTOUtTVSsvV0tkUXJM?=
 =?utf-8?B?YXMwQWczajlKL2tPVkloL0ZDVERYL3BFbGlUSzVaSGViZHhJT0t5ejhDNG0x?=
 =?utf-8?B?SFdxNjZtd1ZVa0NKZmkzNDQyb2FsbmxRYmJvZG1EVU9Jb1h2ZEFqQ09wcEF4?=
 =?utf-8?B?cTBwckcxMjJFSDBMcVhWNWdDKzhMb1FDK3M2b0ZOYzRWeG9NQ1M5RFdWRXFa?=
 =?utf-8?B?aFJSRnRlT2ZSb2xSV3FpemlkUFNpaUF3QTZ6UXpHbHkyYThRcDlMK1ZPNXhU?=
 =?utf-8?B?QVBKYmdsdTFxNVpiQzJ1c0Fic3puZS9BZHo1Mjg3cHg4aEJidk9LbTlOSHJJ?=
 =?utf-8?B?L3huc2VPVnpSWU41VW01dUVpbHVYZ2Rldk83cVBSSFBKNzk4V0x0VUlwNnds?=
 =?utf-8?B?bjVZQXpteFlXVGRMaG1uRXkvNEhMV245VG1rcGJsaEYvbmt2eS9PNTdrRVhE?=
 =?utf-8?B?ZlpFbXhuQzhZekhiSWo2K3IrSlVxMmJsbVZsa3hleFJhV01zYTA5dXBBQU5v?=
 =?utf-8?B?aU9yQXNIdEc4b0lPd21nTnFSU0N2emZjU1h6RHc2K2lYMy8zc2xSSldTaTl4?=
 =?utf-8?Q?GU6yF6msdtc4/RnRoi2GbzNxj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8c57b2-a249-44de-ab25-08daf593a8f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 18:26:16.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxOOWaVQD23+cVDTuLD3AgaavzSFLVAL6n4Q5DGCgjRNUdCBgTpm+pSPSAL+EbEceNd94OEb35eOMd49LtYSiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6014
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiBMS0dTIGluc3RydWN0aW9uIGlzIGludHJvZHVjZWQgd2l0aCBJbnRlbCBGUkVEIChm
bGV4aWJsZSByZXR1cm4NCj4gPiA+ID4gYW5kIGV2ZW50IGRlbGl2ZXJ5KSBzcGVjaWZpY2F0aW9u
LiBBcyBMS0dTIGlzIGluZGVwZW5kZW50IG9mIEZSRUQsDQo+ID4gPiA+IHdlIGVuYWJsZSBpdCBh
cyBhIHN0YW5kYWxvbmUgQ1BVIGZlYXR1cmUuDQo+ID4gPiA+DQo+ID4gPiA+IExLR1MgYmVoYXZl
cyBsaWtlIHRoZSBNT1YgdG8gR1MgaW5zdHJ1Y3Rpb24gZXhjZXB0IHRoYXQgaXQgbG9hZHMNCj4g
PiA+ID4gdGhlIGJhc2UgYWRkcmVzcyBpbnRvIHRoZSBJQTMyX0tFUk5FTF9HU19CQVNFIE1TUiBp
bnN0ZWFkIG9mIHRoZQ0KPiA+ID4gPiBHUyBzZWdtZW504oCZcyBkZXNjcmlwdG9yIGNhY2hlLCB3
aGljaCBpcyBleGFjdGx5IHdoYXQgTGludXgga2VybmVsDQo+ID4gPiA+IGRvZXMgdG8gbG9hZCB1
c2VyIGxldmVsIEdTIGJhc2UuICBUaHVzLCB3aXRoIExLR1MsIHRoZXJlIGlzIG5vDQo+ID4gPiA+
IG5lZWQgdG8gU1dBUEdTIGF3YXkgZnJvbSB0aGUga2VybmVsIEdTIGJhc2UuDQo+ID4gPg0KPiA+
ID4gT2ssIHRoaXMgbG9va3MgZ29vZCB0byBtZS4NCj4gPiA+DQo+ID4gPiBJJ3ZlIGFwcGxpZWQg
dGhlIGZpcnN0IDQgcGF0Y2hlcyB0byB0aXA6eDg2L2NwdSwgYXMgdGhlIGluc3RydWN0aW9uDQo+
ID4gPiBleGlzdHMgaW4gYSBwdWJsaWMgZG9jdW1lbnQgYW5kIHRoZXNlIHBhdGNoZXMgYXJlIGZp
bmUgc3RhbmQtYWxvbmUNCj4gPiA+IGFzIHdlbGwsIHN1Y2ggYXMgdGhlIGZhY3RvcmluZyBvdXQg
b2YgbG9hZF9nc19pbmRleCgpIG1ldGhvZHMgZnJvbSBhDQo+ID4gPiBoaWdoLXVzZSBsb3cgbGV2
ZWwgaGVhZGVyIGludG8gYSBuZXcgaGVhZGVyIGZpbGUuDQo+ID4gPg0KPiA+ID4gUGxhbm5pbmcg
dG8gYXBwbHkgdGhlIGZpbmFsLCBMS0dTIGVuYWJsZXIgcGF0Y2ggYXMgd2VsbCwgdW5sZXNzDQo+
ID4gPiB0aGVyZSdzIGFueSBvYmplY3Rpb25zIGZyb20gb3RoZXJzPw0KPiA+DQo+ID4gTmFoLCBJ
IHRoaW5rIHRoYXQgdGhpbmcncyBiaWtlLXNoZWRkZWQgdG8gbmVhciBkZWF0aC4gTGV0J3MganVz
dCBkbyBpdC4NCj4gDQo+IE9rIC0gYXBwbGllZCB0aGUgIzUgcGF0Y2ggdG8gdGlwOng4Ni9jcHUs
IGZvciBhIHY2LjMgbWVyZ2UuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAJSW5nbw0KDQpUaGFua3Mg
YSBsb3QhDQpYaW4NCg0K
