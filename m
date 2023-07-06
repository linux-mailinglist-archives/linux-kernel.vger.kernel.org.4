Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0472E749C04
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjGFMkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjGFMke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:40:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2E125;
        Thu,  6 Jul 2023 05:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/nbqIQU1pSjleK6DVaz+rmo9qDERZyBECjhyfPoBYJEW9ZSLDziLMokjfSBYU7l7aAXrHNcvB8QOsgYyzCqACLzmFFtkXz6kkU2OgaCIsFZAPIbrfduKRKpZjE1gyFLpJZP1Mvyq7B36t+f205pg0Se9KD5jyyRDoqJmXlwJUVkGPbf98oHXv9y6Oo8hCSGmYoiJByQSMNVouaj8Niv8OLwkp0ugjeoIia7Pr4Ljb2t9+aPVaVpurUaiaenrrjSmkJbO3DUbCJGE4jOGSmzjJw9EEDqQU1XXinRC5OK+qH8PGAFqXDES15PP/rMyY6I02r1Q21ML6vj6/EaMdZIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSgNilZw482hkUDcfMsk5BJs6ucYfOQTBpudaXbZhOA=;
 b=FQmlPxcUEC8oarnRlBZES5piaCXbKlo/epYF0B0vHu/9MhNkWGm4RYbRmF2p+fO87wSUt9TRRM7Z7OH6JSmHs+g99XOfMamPIJAdy51YpDtcwj+/IdlPxJFuGe5SIES2gMFG0ZRvhCdgD/Jc3GndfEhf3og6ZiaLwvPXyJ0QdH697rlH3G35ZzWLRabUHBpOOKrdiZcVBLr3524Mnkxt0NoiA3T9AUMYOAUB7GxQOobohQsylhzdKCON6p2YeGt2SJRW64bZFXH1Cdrxp7bDXGZ0Ic0GpbQ7KIeqhIVS3zK18kEOuWg6Mal+wzGnRnUr9FdFcjS1Ub1kiUy+jMKXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSgNilZw482hkUDcfMsk5BJs6ucYfOQTBpudaXbZhOA=;
 b=NxvC70yrSsLNYtUEUo47jRsnuJRj+E9lxdQYFgsfu9YASppdxuFjMR2hUgjwIluuT1iPbSm/b8WWDlw0KfwqSEAAPgia+PJQij860Xwan5HxoZuF0f+HYHmkr4JUzWiLNCNP0XSmNciqa6kf2p/gkHmADTXIf+EW0enyYI5aWY9oq4jM0BRPAz8Z+3fpWnpLS7DhHPI6hVr0DkKEMunuNtV4kWWphL7vVUPr+GKCG9TYSGOsASvWdBZ+mBMbIuReb6k0D94+APLpQaJgnLL89YMmbIyjnWOqGYPpH5AFR0szL8N1JXDKSRVZB04r5GoHaTiS4ybwoUgmAAcLqFIA1g==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 KL1PR06MB5921.apcprd06.prod.outlook.com (2603:1096:820:d2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 12:40:29 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:40:29 +0000
From:   =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjFdIG1lZGlhOkZpeCByZXBlYXRlZCBpbml0aWFs?=
 =?utf-8?Q?ization?=
Thread-Topic: [PATCH v1] media:Fix repeated initialization
Thread-Index: AQHZr0xHT35tBWoU6kGLmtmL74sUd6+rRwwAgAFncdA=
Date:   Thu, 6 Jul 2023 12:40:29 +0000
Message-ID: <SG2PR06MB3743C23ACD219CDEA19B3B46BD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230705142142.3526-1-machel@vivo.com>
 <abf11e52-c7ff-a3d3-8886-1c61d04fb599@linaro.org>
In-Reply-To: <abf11e52-c7ff-a3d3-8886-1c61d04fb599@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|KL1PR06MB5921:EE_
x-ms-office365-filtering-correlation-id: fdd5533a-0ccc-4771-fdc3-08db7e1e2e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PH7JPZBgKzKGrxPSNqDm7yTAUebvXhBP694FO9V2MxOiF5gUrCTyEg07GEB+mGni5KHnhPXusuxMF2BV5YfK5q71pjZdF97F3jo8qhhqtbeDO6zXRp2AOG+8Jl6CxRLVM/usAACyKB32CD87XQqomUhBll/MNeW0eS+E9kcZ0W4jk/6BRwatp51ieePT1saw9mECNOoYU6eytXmhoo5ibNzfRfweq9+Ks+qgaAhNy0nvy9JSPCymFwurjZdrOFM2eHHcQEy1S2RRYTRIdEE2GQY13ycFelc1WPqWoNJT2NmQs0ceuQTWAC4BXhWihtA29rfJeHX1ZRK69pXFUIJq67mzVWyYwMWFvnD81J5uhubMx68iM/FEKhXasrY8eH7iAWAq4iKZq0ql4s0I98iktBKm+e+YhJjeAKCsxYiHw6rtfwO3LQZyps27Wc4sz5pOaAC/BIojYf9VUeF/4O0EDAql2nwgZ9IHwQAkprieKlwmukUAC2DV3qNSstfPGrc0iD9U8DxY0UHULrQdnd+UyO+e1j79MS394Lloxj+qmum+UcU0ZQUgAto8aqjDmU9QVO87wT+IK/kL2IMXX/4taZQ9XYKCB9VwMGDNnx2i0u4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(6506007)(76116006)(66476007)(66446008)(6916009)(64756008)(66946007)(4326008)(66556008)(38100700002)(55016003)(122000001)(966005)(186003)(86362001)(71200400001)(7696005)(33656002)(38070700005)(85182001)(9686003)(224303003)(26005)(54906003)(478600001)(53546011)(8936002)(5660300002)(52536014)(316002)(2906002)(41300700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWxkc3kzd05OSnRvVmY2UkhnVTVQOUlwdFhnQlB6VHVDNWFyTm5hdWlKVlR5?=
 =?utf-8?B?UTZ0U214WCtRUVVHOFJvYkNLVS9XQUhOd0hjRHZiSXdZNHJUaVM0MEtNVmor?=
 =?utf-8?B?M1FTV3ZNRE9WS3Y5dURybU9GeVg2TTZEcFE3SnNxUjNaSlJBWnlLeWo5Rkl5?=
 =?utf-8?B?Y2RxTVYrRytWa1BxckdoUkpNZjZwTTBVRjRieEI2NnltRm9FZlMvL0ZSRWpO?=
 =?utf-8?B?a1RSZ0dxWmhyS3RwRklWYm5NMzdRVDc5eGQ3VVlBMnpsb2pxRU9NY05JS1hk?=
 =?utf-8?B?Uis3ZGxsUElSV0VkWlFFellOUk4wYm8zTEpBU3ZUTU41WlNFTnB3ZjRCcGtL?=
 =?utf-8?B?M0ZJL0l1VnVXZUxvU3dNVzJ2SjU1OVZGN0FjakFnaDhHUnFMZWVJemEwYTNr?=
 =?utf-8?B?L3kxaDFtRG5xb25lVFptbG9PVHUycUp2c05DSno2NUZRbUFITGtlU0UzVVY5?=
 =?utf-8?B?Y2QwRlN2T29pcksyaFdtVndUV3JlMVdSNXhDK1BNazl2b3ByLy9qT0daVmhD?=
 =?utf-8?B?UFo1QnJvUWNLdnBmWmpyWnBqZm1pNmp1NENwSzdMNnhXMHBRSWF6cTUwUVRX?=
 =?utf-8?B?cys0U2g3OTN2OVBhaDQ0em0xRXpHK0hJL2xBcnE1UEF0MFJ2Q1VvZTRJeVAx?=
 =?utf-8?B?S1lYYUlYaSt5QVFpQS9GSFhUREwxdXhDOGZOTHdVSjM5VkdSK2w4b1E4QXJr?=
 =?utf-8?B?WDg1UlNGdklsYk5kRGxoNVlHajJtc25IUEc4dFFDNnE2bndKdTZSeFZCZXh0?=
 =?utf-8?B?YnBTaUxOK09vTjNhTHJtUzYzSVNrRmlrQU5YL3NQQUlJeWlIMGlWeVBtVFk1?=
 =?utf-8?B?REY0YTdYYlBWZFlkMjRydVhZUmZnZEpjc0ZSeVNrcUtnak5zV09UNUg0REhQ?=
 =?utf-8?B?Yjc3UjFqZWdxYy92MW9nUkg0YU5QdEFwVC9xUHpzOU1pNElhQU1OdEZyUnNk?=
 =?utf-8?B?Rjcwck9kSHRYdnE1RktoV0hnUE9GRzBIL2Nsb3J0Vi9mdFNVTmNvUUVRUFAy?=
 =?utf-8?B?U3hLNWZBcEg1OE9NRDJKNy80bVRuRWVEVXBKTEx0VFl3aDkzbXFIYVBoaVF0?=
 =?utf-8?B?QU9Ud3BsUEYwN3RXdFBydlk1TFVVa1pTaGYzdC9rWEtnWEdhSU5CbzRqbHkz?=
 =?utf-8?B?akU3RnhZdURDemlrdlFCM0VlMm9JQ1BBWTl6K2lLRUdtR0FRMERLK1hOVGw3?=
 =?utf-8?B?eEhEdUJNYVdXaTlHa3daYythL3NQVWJQRUlSYi9FZ2VjVCtOLzltOStma3dR?=
 =?utf-8?B?WGpOcEp5UC9NZFBERkNQeTN3Z29LbDVtQWhvOHptTXdRRy9tSWhFdzFKQ3lv?=
 =?utf-8?B?Tmo4cFlaZTh0T0FhV2lZVGdQOW1wK0tUODBJMUNjanR2WUhkQXozaVo1dTNL?=
 =?utf-8?B?OEkyblF5SmNOTW93b21hVUY1T05laDgxK3d4aTJsMWRTdk94UHNKYXdZc0dL?=
 =?utf-8?B?VURZVnJwQUNCN1liUVI4RnNYVkRUSWYySDIySnVoMVRBRHdWanFveHVSYXNz?=
 =?utf-8?B?NXlKdmRROVUvOUNldXR6Q2JRYS9rdExCNVlxUkM5amY4MkNyaTlWU0M4SSts?=
 =?utf-8?B?R0dtb0VXa0VOKy9oYThPZ09HQ3hDQUlZbDF2WG1zaEVHTjhDT2hmczJWNGtH?=
 =?utf-8?B?S0xCZk1sVDUxSVJaaHR5ZmFEZkpaOXhCZnBvSS9sd0h4UmpxMW54akErdmVs?=
 =?utf-8?B?ZFE0NXI3ajY0Z3B5dDI0NG9YdTBGdStrOTZYbXNEZnlNR09tWmFpRHVCb2x0?=
 =?utf-8?B?VHRvTy91ZklNRSsrYTFna1I2K09rcUVON1hmSGVxcG05MzlPSmhZc1hDcWtV?=
 =?utf-8?B?UzY3Z0FRZ2F3WlBQeWRRS1A5UE9YYjFiRWJ1N0pLVHU2Z1VFemUxTVVYWHky?=
 =?utf-8?B?dGpNcURNd0tHZkNlZzhLSmtrUjlDcGZpalhFaUYzZWVtaGxMWHlnRUFOV3hT?=
 =?utf-8?B?anVuQVBZaXBIdy9mRWZxMGp1SDhxcnhBNkxqTm8vUlhITS94a0UxTkxJSDJz?=
 =?utf-8?B?bjF3bXk5em0xR0Zvb0hyRy9PdDBPc0tPWXRUYmZLSjZ4TXpPZ2tJV3k3clRy?=
 =?utf-8?B?czlUKzRmSTFVTmF1cVlKZnpzVkZMUjZ1OFJYd0RsNitiZUlGbWZRMUw5RGpm?=
 =?utf-8?Q?KGS0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd5533a-0ccc-4771-fdc3-08db7e1e2e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 12:40:29.7838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwZIa7mg6bf8y+ObVKYL/2h8RAIpRo/Hm1M8+ICxuL5cKDTOe+NsVpFU6vOQWXiMBjbnKeG424YzWNE2W/0lCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5921
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraS4NCkxvb2sgY2xvc2VseSwgdGhlcmUgc2VlbXMgdG8gYmUg
YSBtaXNhbGlnbm1lbnQgcHJvYmxlbSBoZXJlLiBJbiBhZGRpdGlvbiwgd2hhdCBtb2RpZmljYXRp
b25zIGRvIHlvdSBuZWVkIG1lIHRvIG1ha2UsIEkgd2lsbCBzdWJtaXQgdGhlbSByZXBlYXRlZGx5
IGFjY29yZGluZyB0byB5b3VyIHJlcXVpcmVtZW50cy4NCjogKQ0KLS0tLS3pgq7ku7bljp/ku7Yt
LS0tLQ0K5Y+R5Lu25Lq6OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tp
QGxpbmFyby5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDIz5bm0N+aciDXml6UgMjM6MTANCuaUtuS7
tuS6ujog546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqCA8bWFjaGVsQHZpdm8uY29tPjsgU3ls
d2VzdGVyIE5hd3JvY2tpIDxzLm5hd3JvY2tpQHNhbXN1bmcuY29tPjsgTWF1cm8gQ2FydmFsaG8g
Q2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBBbGltIEFraHRhciA8YWxpbS5ha2h0YXJAc2Ft
c3VuZy5jb20+OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtc2Ftc3VuZy1zb2NAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrmioTpgIE6IG9wZW5zb3VyY2Uua2VybmVsIDxv
cGVuc291cmNlLmtlcm5lbEB2aXZvLmNvbT4NCuS4u+mimDogUmU6IFtQQVRDSCB2MV0gbWVkaWE6
Rml4IHJlcGVhdGVkIGluaXRpYWxpemF0aW9uDQoNCk9uIDA1LzA3LzIwMjMgMTY6MjEsIFdhbmcg
TWluZyB3cm90ZToNCj4gSWYgdGhlIGZpcnN0IHJlcG9ydCByZXR1cm5zIE5VTEwsDQo+IHRoZXJl
IGlzIG5vIG5lZWQgdG8gZXhlY3V0ZSB0aGUNCj4gZmltY19jYXB0dXJlX3RyeV9mb3JtYXQoKSBm
dW5jdGlvbg0KPiBhZ2Fpbi4NCg0KRmV3IG5pdHBpY2tzIG9ubHksIGFzIEkgZG9uJ3Qga25vdyB0
aGUgY29kZSB1bmZvcnR1bmF0ZWx5Og0KDQpQbGVhc2Ugd3JhcCBjb21taXQgbWVzc2FnZSBhY2Nv
cmRpbmcgdG8gTGludXggY29kaW5nIHN0eWxlIC8gc3VibWlzc2lvbiBwcm9jZXNzIChuZWl0aGVy
IHRvbyBlYXJseSBub3Igb3ZlciB0aGUgbGltaXQpOg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjYuNC1yYzEvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5n
LXBhdGNoZXMucnN0I0w1OTcNCg0KUGxlYXNlIHVzZSBzdWJqZWN0IHByZWZpeGVzIG1hdGNoaW5n
IHRoZSBzdWJzeXN0ZW0uIFlvdSBjYW4gZ2V0IHRoZW0gZm9yIGV4YW1wbGUgd2l0aCBgZ2l0IGxv
ZyAtLW9uZWxpbmUgLS0gRElSRUNUT1JZX09SX0ZJTEVgIG9uIHRoZSBkaXJlY3RvcnkgeW91ciBw
YXRjaCBpcyB0b3VjaGluZy4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2FuZyBNaW5nIDxtYWNo
ZWxAdml2by5jb20+DQo+IC0tLQ0KPiAgLi4uL21lZGlhL3BsYXRmb3JtL3NhbXN1bmcvZXh5bm9z
NC1pcy9maW1jLWNhcHR1cmUuYyAgIHwgMTAgKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL3NhbXN1bmcvZXh5bm9zNC1pcy9maW1jLWNhcHR1cmUuYyANCj4g
Yi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3NhbXN1bmcvZXh5bm9zNC1pcy9maW1jLWNhcHR1cmUu
Yw0KPiBpbmRleCBhMGQ0M2JmODkyZTYuLjVjZTJmMDRhZmExZSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9zYW1zdW5nL2V4eW5vczQtaXMvZmltYy1jYXB0dXJlLmMNCj4g
KysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zYW1zdW5nL2V4eW5vczQtaXMvZmltYy1jYXB0
dXJlLmMNCj4gQEAgLTgyNSwxMCArODI1LDEyIEBAIHN0YXRpYyBpbnQgZmltY19waXBlbGluZV90
cnlfZm9ybWF0KHN0cnVjdCBmaW1jX2N0eCAqY3R4LA0KPiAgCQl0Zm10LT5oZWlnaHQgPSBtZi0+
aGVpZ2h0Ow0KPiAgCQlmZm10ID0gZmltY19jYXB0dXJlX3RyeV9mb3JtYXQoY3R4LCAmdGZtdC0+
d2lkdGgsICZ0Zm10LT5oZWlnaHQsDQo+ICAJCQkJCU5VTEwsICZmY2MsIEZJTUNfU0RfUEFEX1NJ
TktfQ0FNKTsNCj4gLQkJZmZtdCA9IGZpbWNfY2FwdHVyZV90cnlfZm9ybWF0KGN0eCwgJnRmbXQt
PndpZHRoLCAmdGZtdC0+aGVpZ2h0LA0KPiAtCQkJCQlOVUxMLCAmZmNjLCBGSU1DX1NEX1BBRF9T
T1VSQ0UpOw0KPiAtCQlpZiAoZmZtdCAmJiBmZm10LT5tYnVzX2NvZGUpDQo+IC0JCQltZi0+Y29k
ZSA9IGZmbXQtPm1idXNfY29kZTsNCj4gKwkJaWYgKGZmbXQpIHsNCj4gKwkJCWZmbXQgPSBmaW1j
X2NhcHR1cmVfdHJ5X2Zvcm1hdChjdHgsICZ0Zm10LT53aWR0aCwgJnRmbXQtPmhlaWdodCwNCj4g
KwkJCQlOVUxMLCAmZmNjLCBGSU1DX1NEX1BBRF9TT1VSQ0UpOw0KDQpUaGlzIGRvZXMgbm90IGxv
b2sgYWxpZ25lZC4NCg0KDQoNCkJlc3QgcmVnYXJkcywNCktyenlzenRvZg0KDQo=
