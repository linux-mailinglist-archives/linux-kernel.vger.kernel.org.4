Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3477637403
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKXIeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKXIes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:34:48 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C90DA4D6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669278831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMyBvxYImSVtPkb2HjY4PSs9PecEu/RPBedyNRJpZTs=;
        b=mQ2kAS/xAGIVsYgq8/SSSS/fqb8XH+r/7X4zsPC/CLwAP+t0ICfUoIES7K5a9xxfpzMQsF
        tchzEHWEjIvEZhZUoWSsNBGEqj8d7E0gApe7nPt/Dj/YkSC+x5Kox6pRedeXuHUU9sKA9Z
        TVNKJ6WJWxzgHEJeR+ZCytZC4BXJyXXpXQpGkblRAJDI0WPDLCDs9/HvCyTya+mODlmQsZ
        6nDJK8FS8mAG88J1/skfQna2vGmSiYFOWU0lFGGCNP7b+SzerlmVwrLWyavR3ew0hx805N
        +kjwMWtr03cy6vXtYRekUPwzqnyUV2kPmbmpw45gNLFoj2IujZUwAZ/YUmaDaw==
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-4HyuKn0eMYaj5J7Vg2oBYQ-1; Thu, 24 Nov 2022 03:33:46 -0500
X-MC-Unique: 4HyuKn0eMYaj5J7Vg2oBYQ-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by DM4PR19MB6121.namprd19.prod.outlook.com (2603:10b6:8:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Thu, 24 Nov
 2022 08:33:42 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 08:33:42 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v3 1/4] x86/of: Convert Intel's APIC bindings to YAML
 schema
Thread-Topic: [PATCH v3 1/4] x86/of: Convert Intel's APIC bindings to YAML
 schema
Thread-Index: AQHY/kRfW1rEdSurPU+OlYduityf0q5MrXWAgAEU54A=
Date:   Thu, 24 Nov 2022 08:33:41 +0000
Message-ID: <9e0ffd5a-8c34-5fb5-2d23-db3c9ec2c508@maxlinear.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <0cf089495a422b945ac4fc9c980ddb5429a711c3.1669100394.git.rtanwar@maxlinear.com>
 <ce1bf2fd-4080-4952-cf02-6d5b64da8b28@kernel.org>
In-Reply-To: <ce1bf2fd-4080-4952-cf02-6d5b64da8b28@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|DM4PR19MB6121:EE_
x-ms-office365-filtering-correlation-id: 7ede80fd-e765-46bc-7db4-08dacdf697db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: gV72TsDq1NL5DCRKPVqYKSpMkJVbore+y3+gMBdWvfZo8WHw96ZxDFF2lby62DG2AyxF2ttPeehcWw0YrxmIX/scXD0zmDUvLBWWyqQsAKDYZmBHskg1bD+IfhMiLYs/kgh0S7PhBH8ooaLk5oDk63t7QR/3SZsNLztgklKhwyZvzflb9Pt20NwT7PQPBqtQIr7GQeUUlVfPvMdg5mjbblDBsY9Hl+4mF5HDuXDNAaGO30Nlh6cRwCMN2RgSvdt9x+rS3GL6MQwJCV7m3xlRGnMa/McK4gHuf57IXvCx+IeAVWrc5SfT8taL5b3BHWvtIuaVnwNRoik458n3lr1MjCKSBkv9cH6k75SHhaXrePfrTG8l+OtCIKms45rCaK85SWD3/Dx267UUqv+SXQgxuoc90Ox00m0Zh4RFo76yWI775xGxfi8NFX/7D2T30E0wV84KrTyEH5q8IYY3lDzTOiSRFjiK8Mkg6fCBDPmVJ+EfFxwljJl7zlABR8gklVMTl9X+91yphRDpN4A/94cBAw/a+LWDEjVEbU/Qq9aRdvbTQvH14PPiLg8TcapfT2BMQmTy1Y8zDxS74XKPShqPL9ZuS8gXR8lzgjZkvLQE428iHc++vqYiJzAbeo22gkLLhrfgkEqhp0sqSymflc/2kIRuC9/8qyJOCalD13J09BiV/piNcDGFxkrxzAP6Zan4BYzpE/x0bQMeLPv5GHeqLZRQ4Vp5oY+fXAhVlxxmoyTHGvm8JvGW4Pb5bRldtdqAj2S4HwBBaLlVWz2nWrw6TA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(366004)(376002)(346002)(136003)(396003)(451199015)(6486002)(6506007)(6512007)(2616005)(26005)(110136005)(36756003)(122000001)(2906002)(478600001)(107886003)(53546011)(71200400001)(31696002)(86362001)(83380400001)(38100700002)(38070700005)(186003)(7416002)(8936002)(31686004)(66446008)(41300700001)(8676002)(66946007)(66556008)(91956017)(76116006)(64756008)(66476007)(4326008)(5660300002)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2VpZWtVZU5XcVUzZzB4eXh3ZjJyZy80UXRCRzZpVlRHb3NBRVpkNElWc25k?=
 =?utf-8?B?Q2gzeGVqcXBqOTMrYnFnanFWbFhqRkMycDZHandTcWtBV0F5RVA1aktWMUdw?=
 =?utf-8?B?OXpHTjBFYnVsVXRjL09Cbmc4TGQ4ajBWbHFYOG1ldlJZUWhNRWk4MzkxSWhU?=
 =?utf-8?B?RVhDQ0FRT3Z4by9RTktNcFVxSllBYWM5TVMyNEJrd3ViVGU2TGRySmxmTnpK?=
 =?utf-8?B?d2RBT2ZhRmZFSlNhcUdQMkxsU0RTb29PVlpmVjNxamdsZ1F4aDdjak9CRkQ3?=
 =?utf-8?B?YTlPY2JkUmNleHpJRlFiWUVTeDR3SE9HdzZYSGxEZG5CRHFFbW54Q3VaTyta?=
 =?utf-8?B?VVZhSlR5NS9PbXN6SEpFM1NyQ0Zaay9GMmd5ZHBWbTVnWlh3b2FHTjVKZzhW?=
 =?utf-8?B?bVVzelM1eVNBMUhTejI1UTQweVJRdFkvRVlmY2t5bXNtUVdndkVpcTI0Unpk?=
 =?utf-8?B?eDlLWkFhU3NvWkFyc1RmSXhzZlgvNTB6dFZTR1BRUEtxVktYQU8rZ2tmcUxl?=
 =?utf-8?B?Rm94amR2c21zemU0MWVWNWFBWG12T08rOHNBc3dPZ05UTmVWbUlTamw4dDZm?=
 =?utf-8?B?ODd3NkVmaldhN01IaXBaT3ZLTG81bVJhS3grTmpMR3VEY2lVT0Ntd05GZ0ln?=
 =?utf-8?B?YlZwVThuZmk5UXRFMUcwNkYxTlR4Qmw3dklybnFJZmR4a1NCZzNzYXkxd2lV?=
 =?utf-8?B?cDBqUHp0OHlaKzRtbjVmcUQ1ODJ1RGs4SUk5Z0RadW90dlYzTHlNZUJTVlh6?=
 =?utf-8?B?aThlc1FOQ2tjSUZQQlpuall1SytOYUh3WWxCOEhvN0hPbTFzQ2xiNExVcWMz?=
 =?utf-8?B?WE9uNk9NTkN6b2lzZFE0Qm9TMTJpTUFTdG9rNW9ZZmhiVm0vZ3hvZ2xXKzNu?=
 =?utf-8?B?dWlrNEQ3VVFtTmdRK2dSdFUwNVovL0pJbHl4SXBtNVBjdDA2dzlGTHBhWTRE?=
 =?utf-8?B?WFoxaE1LMXY5MWZJcWxCUnd1SWVmZkxCYVIvT2VSKzdvUkZKenkxWStaVzcr?=
 =?utf-8?B?M1ZyVUVVblowSVYyZUc3UGFPcDcrWkUrenBleWhLUmNzbVpmM1R3TUtpTFU4?=
 =?utf-8?B?bjVtM2psdHB0cFBSK2t1dGlKYTBRRUsvdVRqYmJvYmg0bTIzU0o3dVBKU1dN?=
 =?utf-8?B?aExXeWNlOGUyRGluSDhvd3JLOGkyYmhtcHpFaHV2bE1mclRFb2F6NlpIMlNp?=
 =?utf-8?B?MG5KOWo2eTJDd1ZVV0tOS1VnZlBZUmxlbTFXUElDdXFoNHdBQ2tkTzJEUStv?=
 =?utf-8?B?d1RCRWtaKzE4SWlMTGllU2V0ZzhZTFlSRFRrcUpMbjZHRGRIZG1rR2FOQWxy?=
 =?utf-8?B?U0NXcFBYSjdRRUNHazNTRVJpaTQxb3ZtTVhXR21nT3JRVDNra1VBNUdML0tP?=
 =?utf-8?B?TVJXY3VRbERWL29adGpqR1VPZUJSS1ZRREk3ZnQ3NExRZnRrMFFPUE5lTklH?=
 =?utf-8?B?eThiQzlWbHk0L3NZbThtNnhGUFR2NU92NkZVSXJZdHZtTmlwQVo4QUZjd0VB?=
 =?utf-8?B?aGpid0dVcGFZT2w1aHNja1VFZDBUdE85dWxiTFpCZzVKVEROSyt4U3h2aG5a?=
 =?utf-8?B?RVh1SFc4VnhRZllMZlorL3Z1MXp4ZHBDaVNVdHpXTjhHV0E2TlhhdlYxU0Uz?=
 =?utf-8?B?Wk96ZWtpM2UxZkg1Q3hYdTVVUEo3SzdsWVF6dlNyN3Jmck1QSFhNU0tjOThK?=
 =?utf-8?B?S2Jub25hUDVCRFQwWHhrcUErcHRxbHpWcGNPWXdLcFlSRFQzMTlTUUc0RXZ2?=
 =?utf-8?B?c3RwVmtmK0dtdTcyaU9xM3pvYXFkc3gxeXV1bGducVpNZ1I3RHFGVGZXdXpI?=
 =?utf-8?B?cEJmOXZpWUJiMVRrSlhvZ0Rld1hmZ1lTR2g5dTExUEFMWEo0MkNrZ1UwRWdL?=
 =?utf-8?B?YlJKNkM4bkhWN2tGKytwUE1ob1pVd1YrakhkYU16T0JzQVM5R3d4cDNCblBG?=
 =?utf-8?B?MTJ4VjRCZFkwajF4OTlXQk5DaUQ0UHI3NmxVeGxvKzhtUHpTVHArbTlMdits?=
 =?utf-8?B?am5iSHYxckVWWkhDY3RIbDhwU0JSNnJHdHNoRGU3Q2pTRmxCS2pPNGNhc0dv?=
 =?utf-8?B?TUNEL1BTVUlqamd4dE5Mem9zWHRNZ2V3R3ZIb1BoU1JkVEpXeDAzalVLeFo0?=
 =?utf-8?B?RkNFN3dhOEFvY0FXOWFxTHErNlF5VDJnS1BrZ2V5MW92NTA5RThxV3BaSWR3?=
 =?utf-8?B?S3c9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ede80fd-e765-46bc-7db4-08dacdf697db
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 08:33:41.9583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNiPTaf+wcSTbT0BYY/a7nbte6vLM6T2tgwkSTHH7AEUw5QDmk58cWqI6ZljcPRwl9styiyp7pKFWKdYbNHBYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6121
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <D99B79E679B2F546800B84E9F0C5460B@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMTEvMjAyMiAxMjowOCBhbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gVGhp
cyBlbWFpbCB3YXMgc2VudCBmcm9tIG91dHNpZGUgb2YgTWF4TGluZWFyLg0KPiANCj4gDQo+IE9u
IDIyLzExLzIwMjIgMDg6MzksIFJhaHVsIFRhbndhciB3cm90ZToNCj4+IEludGVsJ3MgQVBJQyBm
YW1pbHkgb2YgaW50ZXJydXB0IGNvbnRyb2xsZXJzIHN1cHBvcnQgbG9jYWwgQVBJQw0KPj4gKGxh
cGljKSAmIEkvTyBBUElDIChpb2FwaWMpLiBDb252ZXJ0IGV4aXN0aW5nIGJpbmRpbmdzIGZvciBs
YXBpYw0KPj4gJiBpb2FwaWMgZnJvbSB0ZXh0IHRvIFlBTUwgc2NoZW1hLiBTZXBhcmF0ZSBsYXBp
YyAmIGlvYXBpYyBzY2hlbWFzLg0KPj4gQWRkZGl0aW9uYWxseSwgYWRkIGRlc2NyaXB0aW9uIHdo
aWNoIHdhcyBtaXNzaW5nIGluIHRleHQgZmlsZSBhbmQNCj4+IGFkZCBmZXcgbW9yZSByZXF1aXJl
ZCBzdGFuZGFyZCBwcm9wZXJ0aWVzIHdoaWNoIHdlcmUgYWxzbyBtaXNzaW5nDQo+PiBpbiB0ZXh0
IGZpbGUuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2
Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFJhaHVsIFRhbndhciA8
cnRhbndhckBtYXhsaW5lYXIuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9pbnRlbCxjZTQxMDAtaW9h
cGljLnR4dCAgICAgICAgICAgICAgICAgICB8IDI2IC0tLS0tLS0tDQo+PiAgIC4uLi9pbnRlbCxj
ZTQxMDAtaW9hcGljLnlhbWwgICAgICAgICAgICAgICAgICB8IDYyICsrKysrKysrKysrKysrKysr
KysNCj4+ICAgLi4uL2ludGVsLGNlNDEwMC1sYXBpYy55YW1sICAgICAgICAgICAgICAgICAgIHwg
NDkgKysrKysrKysrKysrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTExIGluc2VydGlvbnMo
KyksIDI2IGRlbGV0aW9ucygtKQ0KPj4gICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ludGVsLGNlNDEwMC1p
b2FwaWMudHh0DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaW50ZWwsY2U0MTAwLWlvYXBpYy55YW1s
DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaW50ZWwsY2U0MTAwLWxhcGljLnlhbWwNCj4+DQo+IA0K
PiBQbGVhc2UgdXNlIHNjcmlwdHMvZ2V0X21haW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2Yg
bmVjZXNzYXJ5IHBlb3BsZQ0KPiBhbmQgbGlzdHMgdG8gQ0MuICBJdCBtaWdodCBoYXBwZW4sIHRo
YXQgY29tbWFuZCB3aGVuIHJ1biBvbiBhbiBvbGRlcg0KPiBrZXJuZWwsIGdpdmVzIHlvdSBvdXRk
YXRlZCBlbnRyaWVzLiAgVGhlcmVmb3JlIHBsZWFzZSBiZSBzdXJlIHlvdSBiYXNlDQo+IHlvdXIg
cGF0Y2hlcyBvbiByZWNlbnQgTGludXgga2VybmVsLg0KPiANCj4gWW91IG1pc3Mgbm90IG9ubHkg
cGVvcGxlIGJ1dCBhbHNvIGxpc3RzLCBtZWFuaW5nIHRoaXMgd2lsbCBub3QgYmUNCj4gYXV0b21h
dGljYWxseSB0ZXN0ZWQuDQo+IA0KPiBTbzogTm8uDQo+IA0KDQoNCkFncmVlIHRoYXQgaSBtYWRl
IG1pc3Rha2VzIGluIGVtYWlsIGxpc3QgZWFybGllci4gQnV0IGkgZml4ZWQgdGhhdCANCnByb2Js
ZW0gZnJvbSB2NCBvbndhcmRzIHRoYW5rcyB0byBBbmR5LiBGcm9tIHY0IG9ud2FyZHMsIFRvICYg
Q2Mgc2hvdWxkIA0KYmUgY29ycmVjdC4gVGhhbmtzLg0KDQpSZWdhcmRzLA0KUmFodWwNCg0KDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KPiANCg0K

