Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C276A12AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjBWWPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWWPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:15:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E8F53EE1;
        Thu, 23 Feb 2023 14:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677190526; x=1708726526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Dun/OVWgFuwvRPHlF3I+5QKA4AHEZDMrBHGaky3+SNs=;
  b=lvQ7YkcgglCilvWQYyLt5qsEfhe9LcbMdZnt0kk9z/g2XbDuENpKTLwG
   hUV104G4BRnO4mI6tVYpwLKLavXK0xpw1ipnWlr86+M6dXtKQfWIpgFrb
   h6bk24nmwZw4sNfDiIVRFNurGSgZTSvCv74k9QgGnJBkuNdDzxN6/wAEA
   o4h6c9edZGcXLhV21VfNtCIhLVrVSON/1g/hadE7eLFmpR0J+MlPVDaQp
   ypeZgMiGX4ywBvk0fF1xsTtLdxhQgD0vnMuAF7x+u/vlM0TNGNjoTRoWq
   VTGPQLoQ6SjUj0rEbLVBoiUJ/LTt45UOagpJQSiZ+i9UvHqFxRGvonqmq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="398067234"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="398067234"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 14:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="918191558"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="918191558"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2023 14:14:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 14:14:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 14:14:57 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 14:14:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn7ZyjY5i4yHQ5RjoQY0CxdaHkvpY5v1fQ6cgtKyw7lgTNSHJRyzVp0dfgJUh3ScYoHaZ2HxR4M2lyvYYmb2LcrXm1vVuY2eDNtQuj+MdTAK5bJLjdD5zj0iipQRHlXti/lCXVHZTiWF4yfUd+64OIEKp6hd2trdg2Ou7qEHTLeRti/rbMpwpsGP7o4UlkLEDzg1NiJWSExRsxtZX+aEC4zbwLpiGLgTiAs4Jj/X4v2EkIXz4qbG/0pTHfjeZb4N07GHNh9pdKl3daz1nETj1LKQ6hB8lDxTiM+M/1mXkXKdsYzPkPF/XlBUYtwK5OOS8+g46h3MHJBqR7lzV5yU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dun/OVWgFuwvRPHlF3I+5QKA4AHEZDMrBHGaky3+SNs=;
 b=cTG+W/rudlOe9ekzurYFs/jW43VWm0OVeDv11ZSGHhwBFqjENp/ubQ07w5kGO89gmmFyxm8Lhu9OyZ65Sk/DP+cxaDmw0gcfvmvePhlrnXfuYjvzGGsjFh329tFJ4KYFI7YBBxAfNt79XG6VijYBrnEzVDkmzJEnOZqUiHcpJVzOQvv2h0LGJVVUyiwSmwYKuEQg/9EfrYTB8BggCrdjX0aerZXaxyO4UQlQK+j95apRo4llheFuMCh+wcpE77wlMXnr9g4OzA9rds82U9P+MxzCFF8gCbdVhEa29EQAqvpIPTJw6Hoyr5w7aLeZDPdfOQI8V7u6gqlbqnM46IrYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4519.namprd11.prod.outlook.com (2603:10b6:208:26c::7)
 by DS0PR11MB7505.namprd11.prod.outlook.com (2603:10b6:8:153::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 22:14:54 +0000
Received: from MN2PR11MB4519.namprd11.prod.outlook.com
 ([fe80::b997:7c43:d49c:a8f2]) by MN2PR11MB4519.namprd11.prod.outlook.com
 ([fe80::b997:7c43:d49c:a8f2%4]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 22:14:54 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "mat.jonczyk@o2.pl" <mat.jonczyk@o2.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 1/1] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
Thread-Topic: [PATCH 1/1] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
Thread-Index: AQHY7uTlpodIPezYNUeEvWAJUDtdf65Gqy+AgAMqwYCAilkzAIAJm5SA
Date:   Thu, 23 Feb 2023 22:14:54 +0000
Message-ID: <47a7437770e60480343ed9d719c66fdcac71c611.camel@intel.com>
References: <8ca5bf9ce1f544096a3ff88b743381bc9e60a76d.camel@intel.com>
         <20230217193142.6954-1-mat.jonczyk@o2.pl>
In-Reply-To: <20230217193142.6954-1-mat.jonczyk@o2.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4519:EE_|DS0PR11MB7505:EE_
x-ms-office365-filtering-correlation-id: d566a5dd-5e4e-4243-ee7b-08db15eb641a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sWtz7pce0g++OdMpy3vFOZPdrCxWmOGpZlNyUzNK3To0kz3GGp1BgLXrxaAQLCDiUOXYk2cgEya/x80cD7xLz0c9ZZ8ntcPQa2CNA1+XUnV5eyhoqUQUkjUvTgQ8ZkaViYp22f+Vfc4nq0VKKNs9vdw4IVzTCc2FinF1Crh5qMc68ybLbUNQokeBeDEd/EQgjZU4Z2nNFpju3l3YQ6ab3YdVDxdSYbsisn96ReVXX23CbD45lge7m7vFoS6AzMSuDV4sEp5jeE8f8y2ktwsIiBW0u3agw0Io6NBl89R0x9s9xynsGWwvU1I4Xce3GhstYUqJ2CXcJYxLQcIGgTpOUkZG3tvWzyR01R+GjnXe3VaY/VNYxx9ixEHqqmUcft2DPioXIL+tFwhyEDEWLaT4Tu7b3jtL/yKzdMLDGgxtTmw+kgM3i5XNb3DyyHM/A7GWIgO2WMBe0+Dg4xz5itQvQ97/sTcViGpHs67w5++dew4TNSmKv+UexFkzH5cVODAhjCcNCX/OmrJWM5YdWqWu8RxcJW6LIEHdz5iDTASzJcLh88IiTIUcZmMxAGdUooh86XyOx8lg4mrBW8TdHGlvYLhYdtYyqa1wo1n9wbiizZOqzyDn/GYQYwyAteVFjOw1b8dZm1gcydfGjlVPU59TjGAniGHYTE2hDJHHx486kJfa7z1LJTY6zX7W2UlR7nYP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4519.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(41300700001)(8936002)(86362001)(71200400001)(4001150100001)(4326008)(76116006)(66946007)(5660300002)(66446008)(64756008)(66476007)(66556008)(8676002)(91956017)(45080400002)(2906002)(316002)(36756003)(966005)(110136005)(6486002)(83380400001)(107886003)(478600001)(186003)(6512007)(6506007)(26005)(2616005)(38070700005)(66574015)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnF2VE1OM3U5bkVwWTNLWlRRK2QvR3htRGZyOXk3N2NEUUQ3MUNSd1p5dHVv?=
 =?utf-8?B?WVJqMXFmckhFNWlBdmxqdlBjY2xxRjdsNWJqYWxSdnhjNHNlQjJkUEdMU3FU?=
 =?utf-8?B?VG1RdmFsU0EvOWJldjQ3a3Y3c2NoR2MwWjdsOWJUbld6WlBBNmFuVEhiRzQ4?=
 =?utf-8?B?bll3Q0p2YnNPa1ZnS1pFQndiTjAvbnNLOG9hUGJNUENZcDVvRXZjT0RBM29O?=
 =?utf-8?B?WGM2TlVpdDNSV2ZscVVrMU9GcHF0bldlQVZlaHZMTzRGNFkrdEhsUFRwRzlz?=
 =?utf-8?B?QVFNeXpRMk0zTTZJaTNOV0k1SkpKWko3Z0ZBWExvMnJHRDh2M3ZoYm1NdHBP?=
 =?utf-8?B?cGMvTnBUM0dlL0FxeFpJTUlwQ3ZFZ0k1cFk4aHVTSXZXdjdDU3dJQ0dPa1Z3?=
 =?utf-8?B?cjg0MzNvNG1lQldBQ2tXV1VWQjhjZW52WkM5V1pKUmc3VzBuWG93MFZzQ2N5?=
 =?utf-8?B?TnJ3UTVaRnJRY1Y4WWRCWUF2OG9OdDdhUitaRmY5eEdobjQ1WFIrMXFndU4y?=
 =?utf-8?B?cDVZTmMxM1l4cnYyZG4raUM4Q1NUaE1CVlA1VXV4QW5TeklocWFxZjluSmFP?=
 =?utf-8?B?S0VncHhoSDFEMmR1UTB0QjlrTVpkUlI4eU45TmlTdGhuejFyODBnbSszRnlW?=
 =?utf-8?B?Vlh3ZUpnTldxK0lhTE9UaFpkS1BSYURTaXF5UWcvcUc5RkkxQ1RneTVyUXVD?=
 =?utf-8?B?RXBQaGVkTWdJckdQM3NjVTI2U2tuUjVXdGhlMEJ0UURQV0hTVzVKWUNlSUV0?=
 =?utf-8?B?R1UvaldKaStQWTJadjJsbGxGZS9iNmFoZU45UUdKR1BZOFRGTXNWeGJvZlN3?=
 =?utf-8?B?OXJRbkl5cExwcG5nOVltRll6eTF5MXA4dkdicnAvTUsyVVJVbXQ3Z3dvNkNR?=
 =?utf-8?B?NWZzcWlIZDM2TzBpLzFmT25zSFdwdHIyS2JyRmtlUTN5ZHA4OVlGdTNlY1hN?=
 =?utf-8?B?bGlnZXV5c1I3cDlrdE5JdFA0d3VxaTdnVmpwZURlZHFJOFlNcXpXSXZ1aFFo?=
 =?utf-8?B?Q1JZTWpwSEJOV0U3ZGlhcGNiVHpBQzk4NnRiUjZYcEU1NmowZDNSME53cVli?=
 =?utf-8?B?K25EZFZIYWdBeStIUUc2dTFFR1dDS1R1ZW9vSGVmLzhuaDNoNjdtOVp4bGZH?=
 =?utf-8?B?b3V3UFZNVkdtYUFzclAwNkpFUUMxT09RcDN3NEFPS0VGNjh6Z2huRXMzY3hB?=
 =?utf-8?B?d1FXbWVVdTVyTm5IQnFFVUFTV2RDUFMrVlRCNjhHSnJENmdaUmdGSVd5STIx?=
 =?utf-8?B?UEVYRkRUaTR6cVZzakFVY2k4b2ViSjQ4S2ZPUCtxdVUzY2xXaFNPTk9QRjNq?=
 =?utf-8?B?UTVhRkVsT1BMamwxcTBkRUV5dnhOUk1Pdm1XWmxwR2t3aFdMcTlhelRmblls?=
 =?utf-8?B?ZUVDWmxDZXJzWk9zbXhIYjZsVE9tb0s0U0VaZEFpbHNGYU1UODExbVowVVcv?=
 =?utf-8?B?aU1TeUdCTjdERCtucHZoQ1ZBbGEvUTVHT1BGUDdZYlp2L29DYlFRVTFWK1hk?=
 =?utf-8?B?Y3VxdzNXWWZVUDYvc1NSa0dOdEJnTnB2dU1DSm0zSWM4akhKMFU2Qk80K21G?=
 =?utf-8?B?ZDFaeU94OTlWMEtqTGNSaWNMOGZCejdSajJsWFFhdUpTUVBNbVNMemRtTDQ4?=
 =?utf-8?B?UUhyOGRBc1B1YURuQnNra2FOQ1E1cEk2QXZrdmNta2hjMktSd2NkY0JSNmZp?=
 =?utf-8?B?cWF6MVh2Y2Q3VDVoVDdpbTQ5Zzc2TTdsQlphdS9aNlVCZURNdTJOK203dUlG?=
 =?utf-8?B?Ync1TmpPMDZwQmhQdHRtSVh4ZS8rcFpmK09vWi9KdUk2SnZvcXI2eFN0YWtS?=
 =?utf-8?B?RXVZcFFuaFJza1V2S0JBdjE1MktDNDF5dDgzRCtrVVhWcUZieWhsZW9HUDNQ?=
 =?utf-8?B?eW1ObXE0bUVYWG54UlJ5NWx3YVBIUHVtZjFHcVAvR3g4M0NRMVVIeWY3dlFE?=
 =?utf-8?B?cFRnaWk0d1Q0WU1qd094MHJUVnlGd2QxOFFrYkREZVBubFZQbEJyNzlkcjhr?=
 =?utf-8?B?TEQ5aC9XdFR3aFgzQmNJMkIzcFdmb2hJeVU2YjExVUNSZ2pjK09ydlJ1RUVu?=
 =?utf-8?B?OGVvUVZtcnJrZ1pieHhKVGhZK1dkSE53dTZwUHAzZXp2SzdWaGUrTlJrUXRQ?=
 =?utf-8?B?VUZySldGY3RwVitrUjRMOUhsaFBKNmx4UDZGc3U3NTZNM0pLZGdXSmMrTVQx?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14541F15585A174C8F4A84DFE98CFB76@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4519.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d566a5dd-5e4e-4243-ee7b-08db15eb641a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 22:14:54.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lj4Sl1rrMvMEb3mQVS5Hf2xGb+SAqZv8DPxkEtjJ9xN6iUOfTt9hXZnc69Hs3cyrXF+DoIKx+pITz73zZ32mVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7505
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVpeiwNCg0KRG8geW91IG5lZWQgdGhlIG9yaWdpbmFsIHBhdGNoIHJlLWdlbmVyYXRlZCwg
b3IgY2FuIHlvdSBmaW5kIGl0IGluIHRoaXMNCnRocmVhZD8NCg0KT24gRnJpLCAyMDIzLTAyLTE3
IGF0IDIwOjMxICswMTAwLCBNYXRldXN6IEpvxYRjenlrIHdyb3RlOg0KPiBXIGRuaXUgMjEuMTEu
MjAyMiBvIDE5OjQ4LCBHaXgsIEJyaWFuIHBpc3plOg0KPiA+IEhpIE1hdGV1c3osDQo+ID4gDQo+
ID4gT24gU2F0LCAyMDIyLTExLTE5IGF0IDE5OjI2ICswMTAwLCBNYXRldXN6IEpvxYRjenlrIHdy
b3RlOg0KPiA+ID4gVyBkbml1IDIuMTEuMjAyMiBvIDE4OjU5LCBCcmlhbiBHaXggcGlzemU6DQo+
ID4gPiA+IFRoZSBtc2Z0X3NldF9maWx0ZXJfZW5hYmxlKCkgY29tbWFuZCB3YXMgdXNpbmcgdGhl
IGRlcHJlY2F0ZWQNCj4gPiA+ID4gaGNpX3JlcXVlc3QgbWVjaGFuaXNtIHJhdGhlciB0aGFuIGhj
aV9zeW5jLiBUaGlzIGNhdXNlZCB0aGUNCj4gPiA+ID4gd2FybmluZw0KPiA+ID4gPiBlcnJvcjoN
Cj4gPiA+ID4gaGNpMDogSENJX1JFUS0weGZjZjANCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEJyaWFuIEdpeCA8YnJpYW4uZ2l4QGludGVsLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+IMKgbmV0L2JsdWV0b290aC9tc2Z0LmMgfCAzNiArKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MjUgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IEhlbGxvLA0KPiA+ID4gDQo+ID4gPiBPbiB0
aGUgZmlyc3QgdGltZSBJIHdhcyB0ZXN0aW5nIHRoaXMgcGF0Y2gsIEkgd2FzIGhlYXZpbHkgdGVz
dGluZw0KPiA+ID4gdmFyaW91cyBCbHVldG9vdGggZnVuY3Rpb25hbGl0eS4gRXZlbnR1YWxseSwg
c29tZXRoaW5nIHN0b3BwZWQNCj4gPiA+IHdvcmtpbmcNCj4gPiA+IGFuZCBJIHdhcyBubyBsb25n
ZXIgYWJsZSB0byBlc3RhYmxpc2ggYSBCbHVldG9vdGggY29ubmVjdGlvbg0KPiA+ID4gYmV0d2Vl
bg0KPiA+ID4gbXkgbW9iaWxlIHBob25lIGFuZCBteSBsYXB0b3AuIFRvIHRyeSB0byByZXNvbHZl
IHRoaXMgaXNzdWUsIEkNCj4gPiA+IHRyaWVkDQo+ID4gPiBzdXNwZW5kaW5nDQo+ID4gPiBteSBs
YXB0b3AsIGJ1dCBhZnRlciByZXN1bWUsIEkgZ290IGEga2VybmVsIHBhbmljIChkbWVzZyBhdHRh
Y2hlZA0KPiA+ID4gYmVsb3csIEkgbWF5DQo+ID4gPiBwcm92aWRlIGpvdXJuYWwgZXh0cmFjdHMg
b24gcmVxdWVzdCkuDQo+IA0KPiBIZWxsbywNCj4gDQo+IEkgaGF2ZSB0byBhcG9sb2dpemUgZm9y
IHRoZSBkZWxheS4NCj4gDQo+IFRoaXMga2VybmVsIHBhbmljIGhhcHBlbmVkIHRvIG1lIGFnYWlu
LCB3aXRob3V0IHRoaXMgcGF0Y2ggc28gbm93IEkNCj4gY2FuDQo+IHNheSB0aGF0IGl0IGlzIHVu
cmVsYXRlZC4gSSBoYXZlIGFnYWluIHRlc3RlZCB0aGUgcGF0Y2ggeW91IHByb3ZpZGVkDQo+IGFu
ZA0KPiBCbHVldG9vdGggd2l0aCBpdCBhcHBlYXJlZCB0byBiZSB3b3JraW5nIGNvcnJlY3RseS4g
SSBoYXZlIGV2ZW4NCj4gdGVzdGVkDQo+IHdpdGggYSBtb2JpbGUgYXBwIGNhbGxlZCAiQmVhY29u
IFNpbXVsYXRvciIgWzFdIGFuZCB0aGUgYmVhY29uIHdhcw0KPiBzdWNjZXNzZnVsbHkgZm91bmQg
b24gbXkgbGFwdG9wLg0KPiANCj4gSSBoYXZlIHRlc3RlZCB0aGlzIG9uIHRvcCBvZiA2LjIuMC1y
YzguDQo+IA0KPiBBZGRpdGlvbmFsbHksIHRvIHNlZSBob3cgaXQgd29ya2VkLCBJIHRlc3RlZCBp
dCB3aXRoIHNvbWUgZGVidWdnaW5nDQo+IHByaW50a3MgYW5kIGFkZGl0aW9uYWwgY2FsbHMgdG8N
Cj4gwqDCoMKgwqDCoMKgwqDCoG1zZnRfc2V0X2ZpbHRlcl9lbmFibGUoaGRldiwgWCk7DQo+IChw
YXRjaCBhdHRhY2hlZCBiZWxvdykgYW5kIHRoZSBjb2RlIGFwcGVhcnMgdG8gZG8gYXMgaXQgaXMg
aW50ZW5kZWQsDQo+IGJ1dA0KPiB3aGVuIEkgY29tYmluZWQgdHdvIA0KPiDCoMKgwqDCoMKgwqDC
oMKgbXNmdF9zZXRfZmlsdGVyX2VuYWJsZShoZGV2LCB0cnVlKTsNCj4gY2FsbHMgb25lIGFmdGVy
IHRoZSBvdGhlciwgSSBnb3Qgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+IMKgwqDCoMKgwqDC
oMKgwqBCbHVldG9vdGg6IGhjaTA6IEJFR0lOIG1zZnRfc2V0X2ZpbHRlcl9lbmFibGUoaGRldiwg
MSkNCj4gwqDCoMKgwqDCoMKgwqDCoEJsdWV0b290aDogaGNpMDogQkVHSU4NCj4gbXNmdF9sZV9z
ZXRfYWR2ZXJ0aXNlbWVudF9maWx0ZXJfZW5hYmxlX2NiKGhkZXYsIHVzZXJfZGF0YSwgMCkNCj4g
wqDCoMKgwqDCoMKgwqDCoEJsdWV0b290aDogaGNpMDogRU5EIG1zZnRfc2V0X2ZpbHRlcl9lbmFi
bGUoaGRldiwgMSksIGVyciA9IDANCj4gwqDCoMKgwqDCoMKgwqDCoEJsdWV0b290aDogaGNpMDog
QkVHSU4gbXNmdF9zZXRfZmlsdGVyX2VuYWJsZShoZGV2LCAxKQ0KPiDCoMKgwqDCoMKgwqDCoMKg
Qmx1ZXRvb3RoOiBoY2kwOiBPcGNvZGUgMHhmY2YwIGZhaWxlZDogLTE2DQo+IMKgwqDCoMKgwqDC
oMKgwqBCbHVldG9vdGg6IGhjaTA6IEJFR0lODQo+IG1zZnRfbGVfc2V0X2FkdmVydGlzZW1lbnRf
ZmlsdGVyX2VuYWJsZV9jYihoZGV2LCB1c2VyX2RhdGEsIGYwKQ0KPiDCoMKgwqDCoMKgwqDCoMKg
Qmx1ZXRvb3RoOiBoY2kwOiBFTkQgbXNmdF9zZXRfZmlsdGVyX2VuYWJsZShoZGV2LCAxKSwgZXJy
ID0gLQ0KPiAxNg0KPiANCj4gaW5zdGVhZCBvZiB0aGUgZXJyb3IgY29kZSAweDBDIGFzIGlzIGRl
c2NyaWJlZCBpbiBhIGNvbW1lbnQgaW4NCj4gbXNmdF9sZV9zZXRfYWR2ZXJ0aXNlbWVudF9maWx0
ZXJfZW5hYmxlX2NiKCkgYW5kIHRoZSBNaWNyb3NvZnQNCj4gc3BlY2lmaWNhdGlvbi4gSXMgdGhp
cyBleHBlY3RlZD8NCj4gDQo+IEluIG1zZnRfc2V0X2ZpbHRlcl9lbmFibGUoKSB5b3VyIHBhdGNo
IGFsc28gY2FzdHMgZXJyIGZyb20gaW50IHRvIHU4DQo+IHdoaWxlIGNhbGxpbmcgbXNmdF9sZV9z
ZXRfYWR2ZXJ0aXNlbWVudF9maWx0ZXJfZW5hYmxlX2NiKCkgd2l0aG91dA0KPiBjaGVja2luZyBp
dHMgc2lnbi4NCj4gDQo+IEdyZWV0aW5ncywNCj4gDQo+IE1hdGV1c3oNCj4gDQo+IFsxXQ0KPiBo
dHRwczovL3BsYXkuZ29vZ2xlLmNvbS9zdG9yZS9hcHBzL2RldGFpbHM/aWQ9bmV0LmFsZWEuYmVh
Y29uc2ltdWxhdG9yDQo+IA0KPiBDYzogTHVpeiBWb24gRGVudHogPGx1aXoudm9uLmRlbnR6QGlu
dGVsLmNvbT4NCj4gDQo+IC0tLQ0KPiDCoG5ldC9ibHVldG9vdGgvbXNmdC5jIHwgMTMgKysrKysr
KysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbmV0L2JsdWV0b290aC9tc2Z0LmMgYi9uZXQvYmx1ZXRvb3RoL21zZnQuYw0KPiBp
bmRleCBiZjVjZWU0ODkxNmMuLmE2ZjU5NGJkMDcyMiAxMDA2NDQNCj4gLS0tIGEvbmV0L2JsdWV0
b290aC9tc2Z0LmMNCj4gKysrIGIvbmV0L2JsdWV0b290aC9tc2Z0LmMNCj4gQEAgLTYsNiArNiw3
IEBADQo+IMKgI2luY2x1ZGUgPG5ldC9ibHVldG9vdGgvYmx1ZXRvb3RoLmg+DQo+IMKgI2luY2x1
ZGUgPG5ldC9ibHVldG9vdGgvaGNpX2NvcmUuaD4NCj4gwqAjaW5jbHVkZSA8bmV0L2JsdWV0b290
aC9tZ210Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gwqANCj4gwqAjaW5jbHVk
ZSAiaGNpX3JlcXVlc3QuaCINCj4gwqAjaW5jbHVkZSAibWdtdF91dGlsLmgiDQo+IEBAIC01Mjcs
NiArNTI4LDEyIEBAIHZvaWQgbXNmdF9kb19vcGVuKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQ0KPiDC
oMKgwqDCoMKgwqDCoMKgaWYgKG1zZnRfbW9uaXRvcl9zdXBwb3J0ZWQoaGRldikpIHsNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtc2Z0LT5yZXN1bWluZyA9IHRydWU7DQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXNmdF9zZXRfZmlsdGVyX2VuYWJsZShoZGV2
LCB0cnVlKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1kZWxheSgxKTsNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1zZnRfc2V0X2ZpbHRlcl9lbmFibGUoaGRl
diwgZmFsc2UpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWRlbGF5KDEpOw0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXNmdF9zZXRfZmlsdGVyX2VuYWJsZSho
ZGV2LCB0cnVlKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1kZWxheSgxKTsN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1zZnRfc2V0X2ZpbHRlcl9lbmFibGUo
aGRldiwgdHJ1ZSk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogTW9uaXRv
cnMgZ2V0IHJlbW92ZWQgb24gcG93ZXIgb2ZmLCBzbyB3ZSBuZWVkIHRvDQo+IGV4cGxpY2l0bHkN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0ZWxsIHRoZSBjb250cm9sbGVy
IHRvIHJlLW1vbml0b3IuDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+
IEBAIC03NDksNiArNzU2LDggQEAgc3RhdGljIHZvaWQNCj4gbXNmdF9sZV9zZXRfYWR2ZXJ0aXNl
bWVudF9maWx0ZXJfZW5hYmxlX2NiKHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPiDCoMKgwqDCoMKg
wqDCoMKgc3RydWN0IG1zZnRfY3BfbGVfc2V0X2FkdmVydGlzZW1lbnRfZmlsdGVyX2VuYWJsZSAq
Y3AgPQ0KPiB1c2VyX2RhdGE7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbXNmdF9kYXRhICpt
c2Z0ID0gaGRldi0+bXNmdF9kYXRhOw0KPiDCoA0KPiArwqDCoMKgwqDCoMKgwqBidF9kZXZfd2Fy
bihoZGV2LCAiQkVHSU4NCj4gbXNmdF9sZV9zZXRfYWR2ZXJ0aXNlbWVudF9maWx0ZXJfZW5hYmxl
X2NiKGhkZXYsIHVzZXJfZGF0YSwgJXgpIiwNCj4gKHVuc2lnbmVkKSBzdGF0dXMpOw0KPiArDQo+
IMKgwqDCoMKgwqDCoMKgwqAvKiBFcnJvciAweDBDIHdvdWxkIGJlIHJldHVybmVkIGlmIHRoZSBm
aWx0ZXIgZW5hYmxlZCBzdGF0dXMNCj4gaXMNCj4gwqDCoMKgwqDCoMKgwqDCoCAqIGFscmVhZHkg
c2V0IHRvIHdoYXRldmVyIHdlIHdlcmUgdHJ5aW5nIHRvIHNldC4NCj4gwqDCoMKgwqDCoMKgwqDC
oCAqIEFsdGhvdWdoIHRoZSBkZWZhdWx0IHN0YXRlIHNob3VsZCBiZSBkaXNhYmxlZCwgc29tZQ0K
PiBjb250cm9sbGVyIHNldA0KPiBAQCAtODA0LDYgKzgxMyw4IEBAIGludCBtc2Z0X3NldF9maWx0
ZXJfZW5hYmxlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPiBib29sIGVuYWJsZSkNCj4gwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCBtc2Z0X2RhdGEgKm1zZnQgPSBoZGV2LT5tc2Z0X2RhdGE7DQo+IMKg
wqDCoMKgwqDCoMKgwqBpbnQgZXJyOw0KPiDCoA0KPiArwqDCoMKgwqDCoMKgwqBidF9kZXZfd2Fy
bihoZGV2LCAiQkVHSU4gbXNmdF9zZXRfZmlsdGVyX2VuYWJsZShoZGV2LCAlZCkiLA0KPiAoaW50
KSBlbmFibGUpOw0KPiArDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIW1zZnQpDQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiDCoA0KPiBAQCAt
ODE0LDYgKzgyNSw4IEBAIGludCBtc2Z0X3NldF9maWx0ZXJfZW5hYmxlKHN0cnVjdCBoY2lfZGV2
ICpoZGV2LA0KPiBib29sIGVuYWJsZSkNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoG1zZnRfbGVf
c2V0X2FkdmVydGlzZW1lbnRfZmlsdGVyX2VuYWJsZV9jYihoZGV2LCAmY3AsIGVycik7DQo+IMKg
DQo+ICvCoMKgwqDCoMKgwqDCoGJ0X2Rldl93YXJuKGhkZXYsICJFTkQgbXNmdF9zZXRfZmlsdGVy
X2VuYWJsZShoZGV2LCAlZCksIGVycg0KPiA9ICVkIiwgKGludCkgZW5hYmxlLCBlcnIpOw0KPiAr
DQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCj4gwqB9DQo+IMKgDQoNCg==
