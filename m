Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69344665E58
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjAKOuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjAKOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:49:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39435E0D2;
        Wed, 11 Jan 2023 06:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673448595; x=1704984595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u+dd8o+UZkiWAdMhSj6wIJWIGt3moUr/wKMO4TiQCg4=;
  b=mcPyIZSbFxn+6ElE1TAc/h0doODfMpslACQwUYvPEMy/AyXE56RFOpCS
   KPAD/WAh0rgXrYZNXpZhXB4PW+1vVgs1wgzCWkoAyEaDD9UwYOjH3GL1K
   9BuNIk19PA78v14AdCKA3XnhHCQOWWxM7Mu5sL1nDNTw6iyssB/u6DnQ2
   A6R/2ET6F7L/vz6fhFDERys6A4qDqkjKhr8iOK+wvZRKsVDUy8MiFC1QQ
   9VCYLJLUU50Ymp6kdwYMnxqE+/ImOCegWF4mfK4t6i1+ehYilIsYtowOw
   b0kmdAEmBtEdS6rywXLruTPtyDCB+1Hd34OFSUQtsEKdrdSbmw4VM2E87
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303125403"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303125403"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="657439035"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="657439035"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 11 Jan 2023 06:49:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 06:49:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 06:49:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 06:49:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOqaEywsskbVWjOMdQolKwmLNyyLRP83NB4pyY+iJ14AukVJfpAZy8/AHVwjwcSj4JFg3Bxnsuf/9eg0paUH3dU6z2nWH+jgBmpMdt2mQ1aPy2G6qCID28TcpMtfh0maJuC7DwRLx5kA4w9BD/iyjwPDxLzF0N/62+xMpm0NhUSVCxGhw4crETQj0F845KprcDJEChYxcNMTCSCfS77lvX+8TUT+p10qPKWIXCNqx++w4tYj9nloy0H/xos4Rk+vMm5NMUqthH70OUtdlX6xeDnUpkcQ7U6lnl14IlqaSTV4U94PQlP67C4qIvn7/pmKXyHDevVyijETs2/TiT45wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+dd8o+UZkiWAdMhSj6wIJWIGt3moUr/wKMO4TiQCg4=;
 b=bkMUqCKBqKYh8V44YYttkFgc93O62LW0nBpbYWixaJJSdVdZsewNiF5cpSBA0HZ2EGDKh69f23755naB3FmredpeLhgOoycx02P2Y7hntyGsYrF5ytLE2PsdSmMNT4xuwesHS826wP0/a1b+9ltS6mY3rLdKmZNhIId0J8jtO+uIp3mhv9/e+WO7GdmCEsKQM/+tztfiLqk72+zzS+ZpRZY/hYIwzZeZvpIMEpDkPnZEu4rEZc4Zo2LrxWHon4A6IcS6wNSZjQDlZrrmlH9bqMRfSCHgjTEO2evhOEbOAMUSOIbB7MDRvehSFOxr8UmhzAnJ01niynhMvLZsBBYdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 14:49:47 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 14:49:47 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Thermal ACPI APIs for generic trip points
Thread-Topic: [PATCH v4 0/3] Thermal ACPI APIs for generic trip points
Thread-Index: AQHZJQa9JdJI+aJ8s02kRrdU2KA97q6ZHFcAgAAxf4A=
Date:   Wed, 11 Jan 2023 14:49:47 +0000
Message-ID: <d51432466ed6b1a8eef0e966bf1b2c2bb2e1e37f.camel@intel.com>
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
         <b070cfab-b8ab-f795-0c98-fc874f05f16b@linaro.org>
In-Reply-To: <b070cfab-b8ab-f795-0c98-fc874f05f16b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB6493:EE_
x-ms-office365-filtering-correlation-id: 444085c0-2e84-4926-2d20-08daf3e3159a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uON71xy1r8v+O2K1DIPMgSelGOLIQE9aQKo+1HfpvsFa3IZPHiMOz6U2NFNUddEX/0+U2pcYIsk5umL76uKvCr2NLiH46/dGLgnC6IOM6uoiHzVBHQBLT9QzUp3ySNepwhihQWswvJ75ocFt7fYRpMYAcjPtemHG/lhCNvLtjT9n5XoHE6bzNW8aDev2l7jHOhXjDEEYWL3lI6Lk2hu7ClwuuCEFPPzzBUndOfG8qf200tZkTSA/AIrbZCMjadkRhWk7togg6Nk4yjL+lJd2+bDr2t4KoBgOEsb/nKNFPCVQIhSudSumovduqinu7l8ByBpb+yGBgOr4hBhHS6H9TVMRAAhqVN92aBNHzGe81NpEjh/tTAPj6mAqyTlxLQ0G4N5+QOoo57yW4dwoV1VNfwq12IenFZHb2vonu30EIPrZrkz/JWbGtAXDqLXjF9Oe438igY3Hx1FCyRlU3YoDboNJ3KBx/yhoe+ukjXTBi64zB/vWnsrvCf2WvGx/4Lxt+57D64z1CZPx+3fovL61Fvj+FRUfSkFV6TvroNqHhdTUiuH+yPgXjn6g7/Bwi9/oqvcokEs8l2l960p1Z/HJ3DJoof2FYdW4SvgiLIC8MnhoKceQw6UCFh24C3YHgD/FfSLi13G35DbA87a2yys3p0RYzQintYERKMuLQk1VZ04a11YIWdzYjf50FO2W3YgGac7BC3uSd+ocdn8ONCGCqKEd3unULPESFWb77NR81Jw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(41300700001)(66446008)(76116006)(110136005)(54906003)(4326008)(64756008)(316002)(36756003)(2616005)(8676002)(66556008)(66946007)(66476007)(91956017)(86362001)(38070700005)(83380400001)(82960400001)(122000001)(5660300002)(8936002)(38100700002)(2906002)(6506007)(71200400001)(53546011)(6486002)(6512007)(186003)(478600001)(26005)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnNYcHJpZ3VOeHNEU0VLbjN2L285cm1vRG5CK2ZnK0tsVWJRR3dXVzByY3B2?=
 =?utf-8?B?bkJ4K0Q2V21GVmJlaW05WDNxZlZxL05URjFNVERVSU8zVFBVQnNESUxLZmUx?=
 =?utf-8?B?QTc3b1k3NDRIYkR4YS9EanpJZ1JPV1lCZW5xd2dUbzRHWGFsVzg0bnhVRVBL?=
 =?utf-8?B?b2VwREdWc0tnMTd2TVdFK1A0cFpvR2R3RjBLYWJaRXpxZmVpOGpRWXREMVZH?=
 =?utf-8?B?TVBSOXE1YnZrUjJBOWpLMG05Z3lSNzRvbzh4dFVzaUtEeTUvQ0JyZmUwa2Ft?=
 =?utf-8?B?aXliNWMwVkpoV0l0elU0eUYxMlN5akYxM2dtSTZLS3BuVjBCWWw1aFY1ZHRj?=
 =?utf-8?B?aXByZDlURGdIWk5uZnVzTzBCWXQyU3BGc09MRFBRM0I4V09GNytDdG9JRUpB?=
 =?utf-8?B?VjhvUHl0UVRvczI0ME5DVVJsTkJPZ25sNnlacGFzak1NenR3dCtxUmp6MWdE?=
 =?utf-8?B?QVM5OEtqNW5peUxZbVlhaVd3T2dKdmJkazNDZC9ZbTdmdmljaTErREMwMGtq?=
 =?utf-8?B?aGl4V2lZckw0NlZLRlNlWkR2UmYrdjFhcEpnU3BtbUVDNGpmekF1bWU2V0Fx?=
 =?utf-8?B?VVg5djBDQzhXbXRwbUtvSnBLSHd3eHlENjFBRWxIOFV3Wkc2VUZJOUVTbnY0?=
 =?utf-8?B?NGtJQTllaWY3MzQ4ZzVMWkpPbnRQR1U2b2J0QTZSY09nWklRT1pzdlJJN0tx?=
 =?utf-8?B?eDBNcmpiTWgxTm5NMzRGdVg4bnhHc1ZFM0QyZXpELzdTOTlodU92RndZaEpt?=
 =?utf-8?B?dFZuaW94QlJpZnQxOGFLNDJpREIyem9wV3luczgzZ2U5YXBHSHNNQmhwRFVi?=
 =?utf-8?B?aWY1ZU5BNWNja0VJeEpaWk0xRkM0NnZNZ1pZTE9USXdaMUx5QnVqeEtSdmlV?=
 =?utf-8?B?dU9lQ01OL2s0SDNVMEdDZUNxT2lBTzJTVlZpbXBNWHFYYVBuWEJDKzJPWXFT?=
 =?utf-8?B?aXp2RkdZVWVOcXRETUtuYkwrZFlEM0s2L3VINlA3QjJhYU9DTkY3ckRhNExG?=
 =?utf-8?B?cFQvWFlZd0xnWlRuQU9BMkd5NVNCL3lhK3VzUnREck03b1hJenQvbjA5ekpn?=
 =?utf-8?B?UE55VlcrWmJERW5TYUYvNXF2b0VubEdkbnNtZnpyNnh0VGFMUlEySVg0UXlG?=
 =?utf-8?B?R1FiaWQ3R2RDZ2xrRjFDN3JQckpQVGh2SlVhUkswSm5KeFZPNWVieFgyRDNz?=
 =?utf-8?B?YmFNaFlaU0dsbHdPbE1jdXNNSitseWlwQ0JnTjhqTW40OGp0aEpaa2tLV3NQ?=
 =?utf-8?B?T0YxNGxPM29YbDlJbGU0b3NKajJHT2s4TEpKMHhJR0VBdXRlUXZFYy9BTFVu?=
 =?utf-8?B?Y2E4VnQ4NHNadUU1SG40ZFBTa01SK2ZNNGtuSENKRlZXVjFnSWYzN0NEa0pW?=
 =?utf-8?B?RjNYZVlRbEZ0Q0RCVEdjb1lIZ0JzUWswcVVjU0xFMXZ3K0ZRajVBL01Ja1VN?=
 =?utf-8?B?L29IVEhJMll0ZTlnWCtCUWc5RWxpNzVrSHh1UXllWlF0V1hlRE1ucDN1K0oz?=
 =?utf-8?B?eHYxdENDMWYvblhHY0JGVnNLcW4reTh2cjc4VUkycWo5KzdTTVd4RUsyMUZR?=
 =?utf-8?B?cGRWSHBlOXhMbXMreWprTTliWVpSNGtmRlh4UTBhcExycHFyTDc2Y2hUQ01G?=
 =?utf-8?B?ay8vVjNudXZyWHQrTlc5d1hleVpCWm5vUG5LdWhxQW1kTmNEdnVNR0tTcVR6?=
 =?utf-8?B?NzVFSnRNUHdJRGJQUSticllPQXdnSnBXL21SU1JYVUNtWU01djh3aEh3aDRm?=
 =?utf-8?B?NU0rdnYzRXBic05Hd1BqY05DM3ZINDh4cURKa1k5eWpSeVV2OXJVYVZUYjZq?=
 =?utf-8?B?YUFCSUJ1dEVveTdxUE9VUStXSW5zUGIvRTRLMm5nQjZma3haTGp0emlOMzU2?=
 =?utf-8?B?Z2h5UVB6T2hTNFQ2Y0x4Qi9KN1hNazFhNThBQTE0aWpaUFhsSUk1QU16ekJ5?=
 =?utf-8?B?c3FLWnZrZ2ozWGVCbGRUSFF4YzhpRFYvN2ZyaE5JUWhzT0ZHT0psR3A1QmRt?=
 =?utf-8?B?U1NGSTA1RnhnYUozZE11WDh5V21YanlLL0F5NUpTaHhRK0hKUzAzbHl5MkVZ?=
 =?utf-8?B?emY3MG9hMTlKWlVhckNBcEsxeFpmWnBKeks3R0Q3N1dRc3h5U3BhQklXbmUz?=
 =?utf-8?B?ZE9xSmQ3R2ZkbnNzc2loOWpZQ0MrOFU4STRld1AxcmJ0NWRIc25za09lRTBw?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4B09FD658A9404981CEC64E8618E921@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444085c0-2e84-4926-2d20-08daf3e3159a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 14:49:47.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sfWSkgdNbLm5m3FQ1d7jc6yFdWCF0lqtfBO1NZj0vjPqxxNukOz4NkT30nG5zgS6yMeNyKE5Zc/BsDNJHGYRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTExIGF0IDEyOjUyICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gQ2FuIEkgY29uc2lkZXIgdGhlc2UgY2hhbmdlcyBvayBmb3IgdGhlcm1hbC9ibGVlZGluZy1l
ZGdlID8NCj4gDQo+IA0KSGksIERhbmllbCwNCg0KSW4gZ2VuZXJhbCwgdGhlIHBhdGNoIGxvb2tz
IGdvb2QgdG8gbWUuDQpCdXQgY2FuIHlvdSBnaXZlIG1lIG1vcmUgdGltZSBzbyB0aGF0IEkgY2Fu
IHRlc3QgdGhlbSBvbiBteSB0ZXN0IGJveCBieQ0KdGhpcyB3ZWVrPw0KDQp0aGFua3MsDQpydWkN
Cg0KPiBPbiAxMC8wMS8yMDIzIDE2OjE3LCBEYW5pZWwgTGV6Y2FubyB3cm90ZToNCj4gPiBSZWNl
bnRseSBzZW50IGFzIGEgUkZDLCB0aGUgdGhlcm1hbCBBQ1BJIGZvciBnZW5lcmljIHRyaXAgcG9p
bnRzIGlzDQo+ID4gYSBzZXQgb2YNCj4gPiBmdW5jdGlvbnMgdG8gZmlsbCB0aGUgZ2VuZXJpYyB0
cmlwIHBvaW50cyBzdHJ1Y3R1cmUgd2hpY2ggd2lsbA0KPiA+IGJlY29tZSB0aGUNCj4gPiBzdGFu
ZGFyZCBzdHJ1Y3R1cmUgZm9yIHRoZSB0aGVybWFsIGZyYW1ld29yayBhbmQgaXRzIHVzZXJzLg0K
PiA+IA0KPiA+IERpZmZlcmVudCBJbnRlbCBkcml2ZXJzIGFuZCB0aGUgQUNQSSB0aGVybWFsIGRy
aXZlciBhcmUgdXNpbmcgdGhlDQo+ID4gQUNQSSB0YWJsZXMgdG8NCj4gPiBnZXQgdGhlIHRoZXJt
YWwgem9uZSBpbmZvcm1hdGlvbi4gQXMgdGhvc2UgYXJlIGdldHRpbmcgdGhlIHNhbWUNCj4gPiBp
bmZvcm1hdGlvbiwNCj4gPiBwcm92aWRpbmcgdGhpcyBzZXQgb2YgQUNQSSBmdW5jdGlvbiB3aXRo
IHRoZSBnZW5lcmljIHRyaXAgcG9pbnRzDQo+ID4gd2lsbA0KPiA+IGNvbnNvbGlkYXRlIHRoZSBj
b2RlLg0KPiA+IA0KPiA+IEFsc28sIHRoZSBJbnRlbCBQQ0ggYW5kIHRoZSBJbnRlbCAzNHh4IGRy
aXZlcnMgYXJlIGNvbnZlcnRlZCB0byB1c2UNCj4gPiB0aGUgZ2VuZXJpYw0KPiA+IHRyaXAgcG9p
bnRzIHJlbHlpbmcgb24gdGhlIEFDUEkgZ2VuZXJpYyB0cmlwIHBvaW50IHBhcnNpbmcNCj4gPiBm
dW5jdGlvbnMuDQo+ID4gDQo+ID4gVGhlc2UgY2hhbmdlcyBoYXZlIGJlZW4gdGVzdGVkIG9uIGEg
VGhpbmtwYWQgTGVub3ZvIHgyODAgd2l0aCB0aGUNCj4gPiBQQ0ggYW5kDQo+ID4gSU5UMzR4eCBk
cml2ZXJzLiBObyByZWdyZXNzaW9uIGhhdmUgYmVlbiBvYnNlcnZlZCwgdGhlIHRyaXAgcG9pbnRz
DQo+ID4gcmVtYWluIHRoZQ0KPiA+IHNhbWUgZm9yIHdoYXQgaXMgZGVzY3JpYmVkIG9uIHRoaXMg
c3lzdGVtLg0KPiA+IA0KPiA+IENoYW5nZWxvZzoNCj4gPiAgIC0gVjQ6DQo+ID4gICAgIC0gRml4
ZWQgS2NvbmZpZyBvcHRpb24gZGVwZW5kZW5jeSwgc2VsZWN0IFRIRVJNQUxfQUNQSSBpZiBBQ1BJ
DQo+ID4gaXMgc2V0DQo+ID4gICAgICAgb25seSBmb3IgdGhlIFBDSCBkcml2ZXINCj4gPiANCj4g
PiAgIC0gVjM6DQo+ID4gICAgIC0gVG9vayBpbnRvIGFjY291bnQgUmFmYWVsJ3MgY29tbWVudHMN
Cj4gPiAgICAgLSBVc2VkIGEgc2lsZW5jZSBvcHRpb24gVEhFUk1BTF9BQ1BJIGluIG9yZGVyIHRv
IHN0YXkNCj4gPiBjb25zaXN0ZW50DQo+ID4gICAgICAgd2l0aCBUSEVSTUFMX09GLiBJdCBpcyB1
cCB0byB0aGUgQVBJIHVzZXIgdG8gc2VsZWN0IHRoZQ0KPiA+IG9wdGlvbi4NCj4gPiANCj4gPiAg
IC0gVjI6DQo+ID4gICAgIC0gRml4IHRoZSB0aGVybWFsIEFDUEkgcGF0Y2ggd2hlcmUgdGhlIHRo
ZXJtYWxfYWNwaS5jIHdhcyBub3QNCj4gPiBpbmNsdWRlZCBpbg0KPiA+ICAgICAgIHRoZSBzZXJp
ZXMNCj4gPiAgICAgLSBQcm92aWRlIGEgY291cGxlIG9mIHVzZXJzIG9mIHRoaXMgQVBJIHdoaWNo
IGNvdWxkIGhhdmUgYmVlbg0KPiA+IHRlc3RlZCBvbiBhDQo+ID4gICAgICAgcmVhbCBzeXN0ZW0N
Cj4gPiANCj4gPiBEYW5pZWwgTGV6Y2FubyAoMyk6DQo+ID4gICAgdGhlcm1hbC9hY3BpOiBBZGQg
QUNQSSB0cmlwIHBvaW50IHJvdXRpbmVzDQo+ID4gICAgdGhlcm1hbC9kcml2ZXJzL2ludGVsOiBV
c2UgZ2VuZXJpYyB0cmlwIHBvaW50cyBmb3IgaW50ZWxfcGNoDQo+ID4gICAgdGhlcm1hbC9kcml2
ZXJzL2ludGVsOiBVc2UgZ2VuZXJpYyB0cmlwIHBvaW50cyBpbnQzNDB4DQo+ID4gDQo+ID4gICBk
cml2ZXJzL3RoZXJtYWwvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKw0KPiA+
ICAgZHJpdmVycy90aGVybWFsL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsN
Cj4gPiAgIGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAg
MSArDQo+ID4gICBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL0tjb25maWcg
fCAgIDEgKw0KPiA+ICAgLi4uL2ludDM0MHhfdGhlcm1hbC9pbnQzNDB4X3RoZXJtYWxfem9uZS5j
ICAgIHwgMTc3ICsrKystLS0tLS0tLS0NCj4gPiAtLQ0KPiA+ICAgLi4uL2ludDM0MHhfdGhlcm1h
bC9pbnQzNDB4X3RoZXJtYWxfem9uZS5oICAgIHwgIDEwICstDQo+ID4gICBkcml2ZXJzL3RoZXJt
YWwvaW50ZWwvaW50ZWxfcGNoX3RoZXJtYWwuYyAgICAgfCAgODggKystLS0tLS0NCj4gPiAgIGRy
aXZlcnMvdGhlcm1hbC90aGVybWFsX2FjcGkuYyAgICAgICAgICAgICAgICB8IDIxMQ0KPiA+ICsr
KysrKysrKysrKysrKysrKw0KPiA+ICAgaW5jbHVkZS9saW51eC90aGVybWFsLmggICAgICAgICAg
ICAgICAgICAgICAgIHwgICA4ICsNCj4gPiAgIDkgZmlsZXMgY2hhbmdlZCwgMjg3IGluc2VydGlv
bnMoKyksIDIxNCBkZWxldGlvbnMoLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L3RoZXJtYWwvdGhlcm1hbF9hY3BpLmMNCj4gPiANCg==
