Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06C689983
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjBCNOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjBCNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:14:33 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E875142D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 05:14:32 -0800 (PST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-49-3V80XC-MO7-d7MlQJs6IJg-1; Fri, 03 Feb 2023 14:14:25 +0100
X-MC-Unique: 3V80XC-MO7-d7MlQJs6IJg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27; Fri, 3 Feb 2023 13:14:23 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa%2]) with mapi id 15.20.6064.024; Fri, 3 Feb 2023
 13:14:23 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "victor.liu@nxp.com" <victor.liu@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v5 09/10] arm64: dts: freescale: add initial apalis imx8
 aka quadmax module support
Thread-Topic: [PATCH v5 09/10] arm64: dts: freescale: add initial apalis imx8
 aka quadmax module support
Thread-Index: AQHZMXapcc36crndD0i5RUTKliezPK60vhwAgASxzACAA9AFgA==
Date:   Fri, 3 Feb 2023 13:14:23 +0000
Message-ID: <a18e3fb7529328e85730e50a748e140169b39e38.camel@toradex.com>
References: <20230126110833.264439-1-marcel@ziswiler.com>
         <20230126110833.264439-10-marcel@ziswiler.com>
         <20230129031932.GO20713@T480>
         <b815ba533d339adb014651f27d20f3f6349bdbc4.camel@toradex.com>
In-Reply-To: <b815ba533d339adb014651f27d20f3f6349bdbc4.camel@toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0759:EE_
x-ms-office365-filtering-correlation-id: 00edbad7-824d-4b47-cd4e-08db05e89156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: C6HP9dI+y5EEu6lL5L7XLICnnlv+KyvVi4AFWofgSSlDmENBNkpoTip42lKAW2PwaMbxyz/64EW0FsgXYGuGYNmhJ9iMArBWiCkSe7yaJtQKrr+BqizzbtBXpNlWheKdQOpL7DskqEk7Np357ZYIUOha+GW6iYp3gyL2I2LAxoCnaAhjm6HTTdWcDYjXmPdX2alGZVd99E93vwtEuPH6q9wbjBHd4Z+OSPiX8mIcFNbgS0JZojEeW0huJ/0rt1mb92QpIqE+Vo/IlrHMBvpGH3J6rBIb+Z1YwkFrg726xr0pAYI8I4OskAsvFMoZs6SU640QEwwU0Fe0z6KdFFE78GVhAWlH0Q7SklS0gXJpVIWKzliWbZ2Ge5SflgWgL1+5rvKSwqvuq2D/Jp3/5X85sbrgYzhNDSRFa7G3wgMUCN+bUjtYFr4vVHz5+6Zg8ekZ6AagDVlhi7HTTYoVcVEydHf/dmTjjWMY0+7kn8PGEvtBIo2qE3zFvn3tPrN7c+BBjt80co9hqUjj+7Bc84rm6VMQ6+kGmYNTmAGW1s3D/KQfajXxlnCVXT5DnoKJVq+ze/XrbV7Y1MeYpoaAy2LouCVc2lG+DM5822JrJOP7e5Wj6/tFZ4XYAqmuMXs9AAGzuPOicELaumL8zDFSBSumqznsk+b36L4i3tke9EFxkw1aUTpN6sJf2iU3S9IlHGlsJSlx47hJNHsavC+6b8wAfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39840400004)(451199018)(36756003)(2906002)(38100700002)(316002)(54906003)(2616005)(71200400001)(6916009)(186003)(478600001)(6512007)(66446008)(64756008)(8676002)(66476007)(6486002)(66946007)(76116006)(66556008)(4744005)(38070700005)(5660300002)(7416002)(44832011)(86362001)(4326008)(8936002)(41300700001)(122000001)(6506007);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ni9Yb0FWSkZWZ0xqaStxeEJKS1hpYjdydTJzWkJWcXZrNDlRRW00cVR3M1Y4?=
 =?utf-8?B?SmVZTEJhQjNDMVN5MHBKR3daUWhRSWw4WExWK0NRU2d2MGxORUNHUHlNclNB?=
 =?utf-8?B?Q2c5MnB1VFRrZ1o1UHJOVmRiOGRJVEpKelpkMGxCMldibkJhb0Z4TTR2WjFh?=
 =?utf-8?B?ZVpxdmNSOVBESjdDRmJ4ZnoycUYvbXIzbmh6UXQvZkd5QlQrQkN3dzF4VmNG?=
 =?utf-8?B?Rk9xWTB1dTFWc1JlQS9GelY2cXRkNFA1MS84U0dRRDMvK1FSQ1U4dE9XL2h6?=
 =?utf-8?B?SjBDK0JUQm9DT2hZaUxvYnRiSmlwRGFpNDN2VUtzenlNRHBrSmRuQkhaWGlK?=
 =?utf-8?B?NW9OOEs1b3BKSHVQR0k0eFpzRm1RMU1JL01Vd2pYWVZ2UktsdGR2a3dZbmVP?=
 =?utf-8?B?YzcwNnJzSitXdTcxVTZFRUVUVjQyQjNicit3dDJOVGU3ZDh0V2tCNTFnN1Bl?=
 =?utf-8?B?YytPYlFsd2o1QVhDYTd6RHNBSmRWMm9JeDVVeXFFZXV5b0paL1ZOV0s0WkZY?=
 =?utf-8?B?TnJ2em1KZkxkd01zZGJ1RnV4RG9EcWNtYWxiNi9uMUV1aGNnZGJzanN2YjBY?=
 =?utf-8?B?a1VOOE12SzBGejljT09rNU4xMklUZ3FzU1JKVHRnZnpUUXgrSm1DSU9GdVhu?=
 =?utf-8?B?VXNxcGpBVG5FeE54Z3drdm1QSnJaM28zT1pGR0haSlhMVWlnTEU1Q3VLdHN5?=
 =?utf-8?B?Q1M0dlVteHZmOTBVVVo4SGtscTNTTDJUZnpWaXdrNnM5eVM4NWI1WHZMVjFH?=
 =?utf-8?B?MEMyenNlMjFrWGtUZktEU0NYVStrdkNXM0orMk93TVRlZXBWOGVQWjNhTkpw?=
 =?utf-8?B?dFo2dmxlc2wxSGtxR2oyZUFrOVBpOVJsaWxOdThhdmhqamhkVFFiMjFyTWp1?=
 =?utf-8?B?d1RpRjZLOVNUMWE5VHFKOHNpSndOcDg2R0dBUzY5Y1VvUSt4blpDN3k5NG5w?=
 =?utf-8?B?czFvMlN5Z3R0T3B3UEZrOVhYOWdlZStuTEVmUFMzeXhjbFV5SSt4djlOZjVz?=
 =?utf-8?B?akdLNkpXYU45RzhqQTFCcWVnOEsrZFFYMUtiR2F3cGlRcENIK2UzUG1HQnhD?=
 =?utf-8?B?WUFJeUZhUEhhSGZ2OCs1a2VUdEYxZFMxTk5TTDFIMzdVRWc5cU0yS21wclRD?=
 =?utf-8?B?RnpndmlVNzNTWStYbWgySzVRT0p4NHZtdXpzdTBjdTBDRVAvR0NLUlZuN2pT?=
 =?utf-8?B?VkprcXltQTJLV0lqTlZsT3Vzb2o2L2xoais4bUxqd25pVGlXUzliUEtSTyt6?=
 =?utf-8?B?UXFOWnpBZ0RkQjBwU2xBN3pmMjdqY3JWem1lb0xXcW41RUxJVGgybW1MRzdI?=
 =?utf-8?B?V0R3T3YvMFcrMHdkNlBZWDFpand3a0hVTXl1eXRlZEIvdjE2eFZnc2V6YVJP?=
 =?utf-8?B?MHczRzBFd1FWbGR6SjE1K050NlJONlE3UWIyTWdKOGJ5ZzBQaUkzd20rRHJy?=
 =?utf-8?B?Sk9OYjF2c3ZiNFAzdW9kQ0RsNkV0YUx6UmYwKy95dEo1RzRzbEd2UUpnZHZp?=
 =?utf-8?B?ejJQOHl5djhNc1ZlWFJ4SXJ3V2tBUk9DRitKTlRFODdmclZuU0RDNW0vZmxG?=
 =?utf-8?B?eEVKclB0ak9iWDVJMFFNLzdSSXJJeWhWbk5tRE9kTmQrTzJCc29tallsWjVD?=
 =?utf-8?B?bFl1ZkJOUnZkTE9TZFVYdVZFVzV6d1hGMFRnRkRDMnNZcStYdURVQmZPdjNL?=
 =?utf-8?B?SVJNSlFqaC9mRzdCMUw1aGxFc3BZdThPLzBsUklKS055YWhqSUpNYXdzMUxm?=
 =?utf-8?B?VHJ5OWR6TXNRQ1pRd2ZjYm1FZ1lieWRRei9oYUlFRVNjTElranhsd25ISHJL?=
 =?utf-8?B?U1V1R2VldHVDdmQ1S28za3VvQ3h2QXM3OWRMeUxiTDVsTzM5MGhkY28wKzk5?=
 =?utf-8?B?Y2ZIT0RnOENUeUNZRWRCOGI3LzRIaUJqd090dlFwSDFNa244N1EyaHNkRmVR?=
 =?utf-8?B?MmpjcGxFRGZpNVJaSVloU25WTlpvbUVpNEFzZ2JNaWF5a2hsbU9ZUU1mb0E1?=
 =?utf-8?B?RlBlZUJHWFg1dmpHUkI4RWxRcWF3bEFzbnBQcVpCbFNmWHJwSks1TVB0UkhU?=
 =?utf-8?B?OEV4MUNXN3IrUkNZcURQeTgvL1lZUzMwNTRwR3Y0SXRpQUwwMWREMnBTWGxK?=
 =?utf-8?B?dWVPSU8rVm1MWjEyR3RBMmt5eDJ5VFVKMnowNUEwN3FWK2FSZmZJb1ZGVkor?=
 =?utf-8?Q?M1qHmZDMOEvFV9MZbiAPBPQI7fM3U26tVEvWXPksvZ+6?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 00edbad7-824d-4b47-cd4e-08db05e89156
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 13:14:23.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yc0u2Eg/Om/P87FpISdQ0QiBhpM3unx5nJeLaj/fbpJfHgfTb9HEBuiPzAdtiYkTHjP/J8NhU1pvntvuDLW/oxuei02UiLXkm+AAd13tLF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0759
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <899B66032995E64497AE55FA40108438@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24NCg0KT24gV2VkLCAyMDIzLTAyLTAxIGF0IDA0OjAxICswMTAwLCBNYXJjZWwgWmlz
d2lsZXIgd3JvdGU6DQoNCltzbmlwXQ0KDQoNCj4gPiA+ICsvKiBBcGFsaXMgVUFSVDEgKi8NCj4g
PiA+ICsmbHB1YXJ0MSB7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBkbWEtbmFtZXMgPSAiIiwiIjsN
Cj4gPiANCj4gPiBXaGF0IGlzIHRoaXMgZm9yPw0KPiANCj4gSSBndWVzcyB0aGF0IHN3aXRjaGVz
IG9mZiBETUEgZmFsbGluZyBwYWNrIHRvIFBJTy4gTGlrZWx5LCB0aGVyZSB3YXMgYW4gaXNzdWUg
YXQgb25lIHBvaW50IGluIGRvd25zdHJlYW0uIExldA0KPiBtZSByZS10ZXN0IHdpdGhvdXQgaXQu
DQoNCkJUVzogVXBzdHJlYW0gdGhpcyBpbmRlZWQgd29ya3MganVzdCBmaW5lIHdpdGhvdXQgdGhp
cyBhbmQgSSByZW1vdmVkIGl0IGluIHY2Lg0KDQpbc25pcF0NCg0KPiA+ID4gKyZ1c2JvdGcxIHsN
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGFkcC1kaXNhYmxlOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
Y2ktZGlzYWJsZS1scG07DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBobnAtZGlzYWJsZTsNCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoG92ZXItY3VycmVudC1hY3RpdmUtbG93Ow0KPiA+ID4gK8KgwqDCoMKg
wqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHBp
bmN0cmwtMCA9IDwmcGluY3RybF91c2JvdGcxPjsNCj4gPiANCj4gPiBXZSBnZW5lcmFsbHkgd2Fu
dCB0byBwdXQgc3VjaCBnZW5lcmljIHByb3BlcnRpZXMgYmVmb3JlIGRldmljZSBzcGVjaWZpYw0K
PiA+IG9uZXMuDQo+IA0KPiBPa2F5Lg0KDQpTb3JyeSwgSSBtaXNzZWQgdGhlIGdlbmVyYWxseSBo
ZXJlLiBMZXQgbWUgcmUtd29yayB0aGUgZGV2aWNlIHRyZWVzIHdpdGggdGhpcyBpbiBtaW5kIGFk
aGVyaW5nIHRvIGhvcGVmdWxseSBhbGwNCnRoZSBydWxlcyB3aGljaCBhcHBseSBhbmQgc2VuZCBh
IHY3IEFTQVAuDQoNCj4gVGhhbmtzIQ0KDQpUaGFuayB5b3UhDQoNCj4gPiBTaGF3bg0KDQpDaGVl
cnMNCg0KTWFyY2VsDQoNCg0KW3NuaXBdDQo=

