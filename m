Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95A5E7BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiIWNaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiIWNaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:30:11 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE1A50534
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:30:04 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-53qp8h2yOhiy9nRzY5ZkUQ-1; Fri, 23 Sep 2022 15:29:59 +0200
X-MC-Unique: 53qp8h2yOhiy9nRzY5ZkUQ-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0150.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.17; Fri, 23 Sep 2022 13:29:58 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d10c:ccdc:19a2:a141]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d10c:ccdc:19a2:a141%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 13:29:58 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 5/5] dt-bindings: imx8ulp: clock: no spaces before tabs
Thread-Topic: [PATCH v1 5/5] dt-bindings: imx8ulp: clock: no spaces before
 tabs
Thread-Index: AQHYuYFHTRK50w3yxke+oalV6tv16a3tLiMA
Date:   Fri, 23 Sep 2022 13:29:58 +0000
Message-ID: <6466b857c8ebcced88062fad7273a1ff1f2e62b2.camel@toradex.com>
References: <20220826192252.794651-1-marcel@ziswiler.com>
         <20220826192252.794651-6-marcel@ziswiler.com>
In-Reply-To: <20220826192252.794651-6-marcel@ziswiler.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0150:EE_
x-ms-office365-filtering-correlation-id: 121af126-4e5f-4c80-f892-08da9d67b5d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: sxA7DEpJruk3zBeiKZZ5SOZwc+bKj5Rzk/F8I3E71Zn2OF07aEaN2IXna/PlkCaJQ4SdgK7oksO8NUxnS6Z+5yT5sTt0M3nkAwsupzdXe9znX4EmBNdcs8lN3+4K4BBErK4LCtojc1aR/Z7LwjAgh3nQm4Mg71zCkrRki6QuBJRYFeU4dNcMS7RBb/EFf/z6yoppuhArA3Xf+EfBiClb9xGvfsYwSu+LfWica57ro9St74bSxi9PwfVtIOJSAL/l98N/GVlhUY4hy/+STUYNAqhrkmSSXFD94VFKTp1a6GkkQSVercufq9EZnvCVwx5Lstgl65F9aKHkUrwdc9TrmBtjdYL8I2O12ZJTL+fSXmIJ2s2KolHCnShk9CMbRuijJprjKc+QSETuErP+cIUtauFHu63b+rT6U25jKRUT2HYJgNbCvZMJaXuarnpeFt52JQ4F0FPZI7SXAVV6n4aSYRXz9LT8VCbhdJZeyd7/2QMzG4FiRwFwGnaIJRX+QBnzE4GiJEDBHTznZAdCrAIn2Ap0xmgLhKQx9su3Q4QeMYX+s46npn0mqujRcDoQR10Hdzvi2z1YAXPl8C6wKddWMgGEaV7nahhjOJBdxBixcPXdw57uQoBN9S8Zpc8Y7aLMocrDyX3syjt4NbQrUDo4BJ8aMrMKG87gWJrztitGeOjLT4BY4kCCbSiOpzi8dbjRok2n7Xs/ZtqtEaaODiyMU+rckUlriQmjMUPhzjmuWJd/5rTTva3YilAqvvP6KPStyxv8xFWN8daYccWMZNcWfhTHVSZOvmXUOI1UuAOW5kA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39840400004)(346002)(396003)(451199015)(316002)(54906003)(6916009)(8936002)(122000001)(38070700005)(7416002)(186003)(5660300002)(44832011)(6512007)(71200400001)(2616005)(6506007)(2906002)(36756003)(6486002)(66556008)(83380400001)(478600001)(86362001)(38100700002)(66946007)(64756008)(76116006)(66476007)(66446008)(4326008)(8676002)(41300700001)(26005)(32563001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0xwZkFpUHFmQ2hQeitLK2UzU2RWdTBoQ1MyRTZLVXZyRXVoVXZXUWZPc2kw?=
 =?utf-8?B?Y1VYWGJCUDZiSzRubEpJR09rZFZuMWh0V1hMVHlWK1BlYkdzcHZkRVNtWFZl?=
 =?utf-8?B?bzBtNktraHlKeUpzUVdyWnZBUUVLVTVWdUxDN0ErSmRzZTUreWNDblE0YkNK?=
 =?utf-8?B?aU1pTTNnMFJiVU5vYW5RWjRrRmw4RnNWeSs5cGtheHBaYVFySDhxSHE3Z1g4?=
 =?utf-8?B?c0JJaTIreFc4Ly9OekJrSmVrMnJYYlRxNjU4SlZYNTZJTThUSlVSS1FKNTIz?=
 =?utf-8?B?RXlTQnRWeDFnTDhuVEhXNjdaditvSmwwK3BpMjBmNVMxSXpqd2F2d0ljUHZ4?=
 =?utf-8?B?NVNjbjRJdlRES0hPRFc5RmpaZkJZVktrWng5NlFuWXU3YllJcFRwS1F0N0pv?=
 =?utf-8?B?dHpKMWRFZzcvQzUyU2orSzgxZVhZVnIxckJFY1c2RTRLQ3J6V24xRUVWSGxX?=
 =?utf-8?B?ak9yaisyOHhpZmozRFkvL3ZnQXhCcUlQVE9VMldxUHFSaC9pUDlMNmlDMTVr?=
 =?utf-8?B?VDRBdEx3QVRCaHhZbUxJczVpMG1FNTBkRDBqUkVCNXduSkI0UXFUY1REMDBp?=
 =?utf-8?B?dHhvWlJIRWJ3S3ByNDlwQllvUXBjVlhXS0M0WnJ4RUtadkwzNWxXanBPSnVS?=
 =?utf-8?B?RFhRZE9ONC95MDFPTDZ0aHc4VVlwcVVZL29UZmJGYVV0WlZVTDlhTFc1MlZ0?=
 =?utf-8?B?RW1ESzF5eStBalJmL0Erb3o4ZFNUb28yM29BMVJZREtEM2xBczkzMWZpTWdI?=
 =?utf-8?B?R0g3QjFOUGxVSDFxMm5pWStCV01IYmRtRDhDYTltb2pjR3p3d3RYUVdqWURK?=
 =?utf-8?B?MlVsREwwaUVQc1VtUTdsOUM4cGRvMjZJaThHTDVrWnpDQW9GSmJibWhyNmZ6?=
 =?utf-8?B?TWFTZEZORVE2ZEowSm1lU3RJSnlsd0x5V0ZjeSt6SWgrTE4xSUE0ejRWbm80?=
 =?utf-8?B?bkpvZUFIUVJ6WFBTM2IxY1drUUExQXNRdHZWSzFGNWMyVThTZXJoN2UvaExQ?=
 =?utf-8?B?VDJXTG8rUGlVLzRFTjBZbTd1bVJQSFkvKzhtOW52ZmxIYllJdTlwbFN3OVZ4?=
 =?utf-8?B?QXY4UnJmcEFsUnBkQUZTenRhcTNiVFEwSEFOSVpJendCcU9MUVd6NFhpekZ4?=
 =?utf-8?B?VXVsOFB1c1JweVp6cmg5VVBYM3R5RUsxYzB3eVR5Q1JMZHh2RTVzbmp1NVp5?=
 =?utf-8?B?UjNjUTROcnp0dnlJaEt3TDRLMlo3MjhDRTF6ZFNOeUswNXdQOE9wWmwzekwz?=
 =?utf-8?B?dUlaamtqaVVsclpSRjZJaFNDdmh2VGtPK1V5NnNoSGNmM1UyaVBzZmxDNDlD?=
 =?utf-8?B?UWVUOHJNcVdQYk5TUm5hNThhaG9ZWjJ4SkNXWUkySno3TEIzSjdveGk5aU5j?=
 =?utf-8?B?eFFZN3djQU9ZcWpvaDRGczZqSGFqTjg2SUJjRFFBQ2pvQnF4L0IzdUlFSGZi?=
 =?utf-8?B?SmxtSFJxV3lxamFyTmJVMW9XNTNJd0FWendvUGlxTkhCMXRKUE5LcE41S3Ev?=
 =?utf-8?B?VjNhYnhVS1RVa1lyWVBWREdWZTdwYjNNbzEzTURRN2U2dGxQU0ZBUGh5aFly?=
 =?utf-8?B?R0RweHVoVGNWL3lTRWs1b2xWWXc2OWd2eVVwbUFmWDd1QkNuNWdLYlZvZENY?=
 =?utf-8?B?K292WUtQaHY0bVArWnBZVUlvMCtuUVM0MmJpRnBzbzc2Q0tDd3JscVVCQlIv?=
 =?utf-8?B?enpmQWFZZmdPWnk3MjdJeTJpb01zSDhUNnNWeEdoWGJDellqL0xFMTRVcnVD?=
 =?utf-8?B?SVo1VlNhZmYvNjNQOW5VcVMxRitrY21TellCK1U0bjI2UmhhUWpPejFRREU5?=
 =?utf-8?B?bUEvR0lqa2VMYUN6MUFETDlXWnhEeFZ4WmpkTCtUb3hXbFd2SDdYOW1vYU9U?=
 =?utf-8?B?bmJGVmpXSDJ6dEppdWdxbHdWaGp6UjZEV2Nld25NaEVhc2p3cUlRLzAwVERk?=
 =?utf-8?B?dWxodSsySHg3UjBwS1pjbjZGb0ZNTWVEQ0hpTVlscmMvalp0ZjNUakU5cHZK?=
 =?utf-8?B?UlJkNVozbG5ORmpNeElxeFNjTFJnNlFYM2QvOWdibkVLN1Y0N1JxdnZON2xy?=
 =?utf-8?B?QlBXK3VTM3F3TnpQZ2NNOHFtcTJMQmQ5ZlgxUmp1V0VkMG1vQStSVmhnUENH?=
 =?utf-8?B?dFdONHdJc3RiV1FlNTZydmRJMzlTRk1aNlNOUkpWN3dyREVrU1dTODJ5c0dk?=
 =?utf-8?Q?bnzoJY1xRLTaBehLdeNO01s=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 121af126-4e5f-4c80-f892-08da9d67b5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 13:29:58.3794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3N8qanZRJCfEbO1BmuvmvHPugpnM+qokpLyOS+P5BoOwSQKesxiZpFTiopCJ3npm1VLd6e9oygD7YAYsHkMW0klzdAGXpyMPlS1EgCDgu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0150
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <56ACA68C9D85904DA211C7D470D4E1E8@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTI2IGF0IDIxOjIyICswMjAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
Cj4gRnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+Cj4g
Cj4gVGhpcyBmaXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmdzOgo+IAo+IGluY2x1ZGUvZHQtYmlu
ZGluZ3MvY2xvY2svaW14OHVscC1jbG9jay5oOjIwNDogd2FybmluZzogcGxlYXNlLCBubyBzcGFj
ZQo+IMKgYmVmb3JlIHRhYnMKPiBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDh1bHAtY2xv
Y2suaDoyMTU6IHdhcm5pbmc6IHBsZWFzZSwgbm8gc3BhY2UKPiDCoGJlZm9yZSB0YWJzCj4gCj4g
U2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5j
b20+Cj4gCj4gLS0tCj4gCj4gwqBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDh1bHAtY2xv
Y2suaCB8IDQgKystLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9pbXg4
dWxwLWNsb2NrLmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDh1bHAtY2xvY2suaAo+
IGluZGV4IDk1M2VjZmU4ZWJjYy4uODI3NDA0ZmFkZjVjIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUv
ZHQtYmluZGluZ3MvY2xvY2svaW14OHVscC1jbG9jay5oCj4gKysrIGIvaW5jbHVkZS9kdC1iaW5k
aW5ncy9jbG9jay9pbXg4dWxwLWNsb2NrLmgKPiBAQCAtMjAxLDcgKzIwMSw3IEBACj4gwqAjZGVm
aW5lIElNWDhVTFBfQ0xLX1NBSTfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAyCj4gwqAj
ZGVmaW5lIElNWDhVTFBfQ0xLX1NQRElGwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDMKPiDC
oCNkZWZpbmUgSU1YOFVMUF9DTEtfSVNJwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgNAo+IC0jZGVmaW5lIElNWDhVTFBfQ0xLX0NTSV9SRUdTwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoDUKPiArI2RlZmluZSBJTVg4VUxQX0NMS19DU0lfUkVHU8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqA1Cj4gwqAjZGVmaW5lIElNWDhVTFBfQ0xLX1BDVExEwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoDYKPiDCoCNkZWZpbmUgSU1YOFVMUF9DTEtfQ1NJwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgNwo+IMKgI2RlZmluZSBJTVg4VUxQX0NM
S19EU0nCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA4Cj4g
QEAgLTIxMiw3ICsyMTIsNyBAQAo+IMKgI2RlZmluZSBJTVg4VUxQX0NMS19HUFUyRMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAxMwo+IMKgI2RlZmluZSBJTVg4VUxQX0NMS19HUFUzRMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAxNAo+IMKgI2RlZmluZSBJTVg4VUxQX0NMS19EQ19OQU5P
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMTUKPiAtI2RlZmluZSBJTVg4VUxQX0NMS19DU0lfQ0xL
X1VJwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDE2Cj4gKyNkZWZpbmUgSU1YOFVM
UF9DTEtfQ1NJX0NMS19VScKgwqDCoMKgwqDCoMKgwqDCoDE2Cj4gwqAjZGVmaW5lIElNWDhVTFBf
Q0xLX0NTSV9DTEtfRVNDwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAxNwo+IMKgI2Rl
ZmluZSBJTVg4VUxQX0NMS19SR1BJT0TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDE4Cj4gwqAj
ZGVmaW5lIElNWDhVTFBfQ0xLX0RNQTJfTVDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAxOQoKU2Ft
ZSBhcHBsaWVzIHRvIHRoaXMgb25lLiBBbnkgdGFrZXJzPwo=

