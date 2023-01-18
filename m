Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8365B671FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjAROov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjAROo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:44:27 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C04B367DE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:36:24 -0800 (PST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-I7B8-BC5MRaJexGHG90VPg-1; Wed, 18 Jan 2023 15:36:22 +0100
X-MC-Unique: I7B8-BC5MRaJexGHG90VPg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0003.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:27::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Wed, 18 Jan 2023 14:36:21 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa%2]) with mapi id 15.20.6002.012; Wed, 18 Jan 2023
 14:36:21 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v4 16/17] arm64: dts: freescale: apalis-imx8: fix
 reserved-memory node names
Thread-Topic: [PATCH v4 16/17] arm64: dts: freescale: apalis-imx8: fix
 reserved-memory node names
Thread-Index: AQHZKw5yH9xn+DGG2UG2ziZCJz4LSq6kNM6AgAAJiYA=
Date:   Wed, 18 Jan 2023 14:36:20 +0000
Message-ID: <1d4dc13ce1ffae4885bceb439d5d259f3567e6c4.camel@toradex.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
         <20230118072656.18845-17-marcel@ziswiler.com>
         <b5a60852-f8f5-f3c4-fb75-bb5f00823c82@linaro.org>
In-Reply-To: <b5a60852-f8f5-f3c4-fb75-bb5f00823c82@linaro.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0003:EE_
x-ms-office365-filtering-correlation-id: deb8417e-0a53-42ee-c5ba-08daf9615dfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 1sFxI8DIG1vAEsFVnimXUuto0H4iWS1Uvu0DRR8apa0B/e4bpqP0ImSJ3WxKQYcbrih89hVOzKjciTFF3S0SWGlxBzafstq3D5JyuoGkS+3yJJPKNY0aeGFygwwC/jhOZwLhtpxtQXbrJfuaXCoGaz/sCN06VIFth2fU0bCR4bm5GL/k9EgkmbdFr7x+eTnEjB9bzd7rmlVODaDjO/C4uj4BARCzYi+/FdLkZ3kamu1KzdPSqqz1NVk7MmTGzOKb6pGZlRE5YcV8E8MyEUEG3H8OWO/nMNePwj8EDtAxZ1o9kytU+fl4b3AdjngTF4xVjzvhKtGMRMRFSk0KAsmgGCh81vPrJflEAiDYqpODHW+wQWghV8PX5EMA0RlFJJPx2CWSxs66J+ApbQl+4SBVGrbISbnJLrGvHrHfVRUh3N1kWCIHDhQx/DJoO6UoUzam/LNPi1w9wvjV82kWL51qEllMxuahr4pQRUpqEfu00lFi+sEWmvBjo7XC997Salc2f7GQGK5vHCucoUNnOQPceOHTxu95C/0TvcEH+QUCE750EoCQ1dWw5VvRI6cguTckZ9fVJwjYYfiYdLHrDaaAudRfYQaGlJcCyKCv6i8K0Knr/bIlg+eN8DwiJoQf+MyFLU3fdjaXLvZQusdMlQgvePGfMwVxIPQNlyVCWsFIPnYnF93lpRNSIzv/1OhBxDAy/hL0Bigq2miw++k717INmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(39850400004)(396003)(346002)(451199015)(26005)(6486002)(38100700002)(76116006)(478600001)(71200400001)(316002)(110136005)(6512007)(41300700001)(4326008)(8676002)(83380400001)(66476007)(66556008)(66946007)(66446008)(64756008)(6506007)(186003)(2906002)(44832011)(54906003)(2616005)(5660300002)(8936002)(7416002)(53546011)(38070700005)(122000001)(36756003)(86362001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3pEVzVZOGdhSWZxR2RFU3lYUnBSN3IzNUcyMDVJbVJ4UE9YTWE3NFJiWmYx?=
 =?utf-8?B?K2FUN0Zabks4L21yb1ltck1rRmVFL1VwdWFObktNTjhmOEUzelBhVzlaTnBs?=
 =?utf-8?B?bjJaelpZNEhqdllMQjdzNkRPT2lxUGVFL29XemlwTkx2UlU4bWRtamRNY01s?=
 =?utf-8?B?MitGNjNaNTZFZ1ZiREZTeEQrODlhc0xqSmNvVkpsb0d6ekErWUwyUGpJZGtr?=
 =?utf-8?B?aitMNE1NS1dVaXhWSzJRZTBVOGsrRWs5bVpxRnM1SW5jK0hlVGtyRHhNVzdo?=
 =?utf-8?B?VTZTTDRXczlDNkpLcCtMTVlvTjNLL2YxQ2JlcnQ3UGttamZiR1oyODZGanQy?=
 =?utf-8?B?TmZjdzFKRHlGbitiUWd6a0ZaaWRzSUFEdzFocVpSeCtLTllVeXIwaGhoR1JJ?=
 =?utf-8?B?ZGxBMVVBdGZQU2RvV1BRSzNlcmxkNWtIRFM1NWRDVWxOQmd6K0QvdUtBeEx3?=
 =?utf-8?B?MXZHYTJYY05rRDNZR3hVWnpKNm1KMjlPUDduRFM2R09SL05yY3kvN01UdlRv?=
 =?utf-8?B?bUJzUXl0N1plQjh0QUx6SUJsVHFwT2YxVXpRZ0VCN1hoMDZKajh6RHFiS1FC?=
 =?utf-8?B?SnVWcElZeWtBME1ScjFFSG1CRnZvY0tUbVc3Wm9uazlqNkZTa1FGblBMNkov?=
 =?utf-8?B?NmZMU1hvN3pDeEVESVZ4NjJpNmlTV0Z6dWtTVnh6SDFEQlE4bVd2QzVUZzRk?=
 =?utf-8?B?RlZqclhkeHhvR3hBOHdySHhlVzR0Q1ZtS2VTU2tZaHJIT3pKSXpFZ25jUE5Z?=
 =?utf-8?B?QVk3M1FzYXRJTFZQZ000dGhqVEF2MEF3R0N2R1ZtSk16VEFCcUk3WW4vdDk3?=
 =?utf-8?B?UzVuUU5aTkFTVmMvTzJIUTF3c1p6UXdRSWdReFRUVVltQnh2VnRMcFJOK29t?=
 =?utf-8?B?VytyZUV0MllLTnU4WGMrRWljM0hNcVJCdFNnRkNpN2U1RXpQQWFiR2VNZy9u?=
 =?utf-8?B?YW8vdkVTUGRYTU9VbHZuTUQycXpMN3FlRWpYYUdScTBjemRkRFE1UGRPc1hR?=
 =?utf-8?B?MnYvNjBJTXpBeWFEVTB3bmViZXA1Mm1KM29zT3VpdkxVZE1zNVN3SThUdW0w?=
 =?utf-8?B?RWJWWjlwbWQrM2o0K1BRcmJZdVJuQjJkbmNnZjRXbHh5MmhLVVBCSVRraTRs?=
 =?utf-8?B?UFhPSE5sMlhTa1l1dklwMGVjYUtYWlVvYlM5Mm9NSElBVWJ5Zy9qVGs1N1lH?=
 =?utf-8?B?ZWU3Z05OMVpQUVpxTnFhRFNnV1JuNDdtVmFQenNYSUdIN2tDcnJ5THZuYnlp?=
 =?utf-8?B?R01jUGl2UTlUYnllbGtueStwRjZhTWhmQzNCekRYR1BZM0tLR0N0OUwzYzdZ?=
 =?utf-8?B?NGdjUWJ5d0ZocFRjSU1lL0NzNnB0dFFRRUkwMjJmRWFMYUhSZ1Z6ZHpod3dr?=
 =?utf-8?B?cElLajlyd251L1hPa2NZWGtRSDRoMlV0QlNDZkFUeFd3NGVPdmZadlhXeU1U?=
 =?utf-8?B?YlY3aTQxVTVkZjRHSlN2YjFXNEZXQnNCZmJpbTg2cEFCNjd3N0dCMUtTV09a?=
 =?utf-8?B?UTV5SlVpcXN5YTE3bjJSM002VHFpYlFoMUVlQjFLYmJLSWxIMEh3RHVTSmIy?=
 =?utf-8?B?RjB5TXlIOWFzK0NJeWFQRytMRWJqeVRtVzhyUFh1L1kyZXhlc0wzaWxmc2s5?=
 =?utf-8?B?dmtHbHFva2VMRGRIY3VHSVNmcElnQ0pNV1lKNVJDOVRSMDFreHllQW1MZTBD?=
 =?utf-8?B?WlREVVBUeGRwSW02YWkwMUYzcVVxbWVPUmhzc200UmdyMVRnN0xIZldHSUph?=
 =?utf-8?B?VVZ2c0VEYzVGMEN6UlZabHdHZlhwY3JkZmVLYThZd0JMOGJqaFljLzZ1bUE5?=
 =?utf-8?B?MXBYam5PTU1UU2pUR0ZxanZzRWVCVm9sN1EwS1NweHFuZXVod1Bndi8vNVhm?=
 =?utf-8?B?WWlTTW1qa3VlUlVLRGRWUmMrbENlRmkzV1FZcmFEMnRzK08wWklEemJEdGhT?=
 =?utf-8?B?eS9iMWZCVGxFejNQZklobEZHRXFMcXFPbldmM012azJKVFphbG5hRklKZ2xx?=
 =?utf-8?B?VXQ3ZmNhby81YjNjVmd1UVRGNTRwNjhvYVBoRFEwM1EvRzJ4TmdGNFNtWW9N?=
 =?utf-8?B?ZGRMMDNnbFVLMXBmenB4WGZNMDRocDl5dVJlclFQbWNKQWR3dXBjaWZXV0FL?=
 =?utf-8?B?ZVBvVHlLRS8vdGgrUERmb2pNU1NGSFJkaTRrMTl1SHZkNXo0ZTBhSFRxcUdY?=
 =?utf-8?Q?3EbB7Y7L6nBMI6fTb4kk7Ac=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: deb8417e-0a53-42ee-c5ba-08daf9615dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:36:20.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3b+Dgi9UVPexZ4Gal/bc/GVjE/eiucwutZDixz5thChvB3pmZZmhvQAxO413AhnFGia5YAh9w4x/fXOOqdVm1sWf3A50qC/iJ99rGDKMDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0003
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <6CB969B4C4FDA347AB8306A817303DA4@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTE4IGF0IDE1OjAyICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxOC8wMS8yMDIzIDA4OjI2LCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4g
RnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4g
DQo+ID4gRml4IHJlc2VydmVkLW1lbW9yeSBub2RlIG5hbWVzIHVzaW5nIGRhc2hlcyByYXRoZXIg
dGhhbiB1bmRlcnNjb3Jlcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJjZWwgWmlzd2ls
ZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiANCj4gPiAtLS0NCj4gPiANCj4g
PiBDaGFuZ2VzIGluIHY0Og0KPiA+IC0gTmV3IHBhdGNoIGZpeGluZyByZXNlcnZlZC1tZW1vcnkg
bm9kZSBuYW1lcy4NCj4gPiANCj4gPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDgtYXBhbGlzLXYxLjEuZHRzaSB8IDEyICsrKysrKy0tLS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OC1hcGFsaXMtdjEuMS5kdHNpIGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OC0NCj4gPiBhcGFsaXMtdjEuMS5kdHNp
DQo+ID4gaW5kZXggNzBjMDBiOTJjYjA1Li42MjE3ZTBhNDhmOTYgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OC1hcGFsaXMtdjEuMS5kdHNpDQo+ID4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OC1hcGFsaXMtdjEuMS5kdHNp
DQo+ID4gQEAgLTEzMywxNyArMTMzLDE3IEBAIHJlc2VydmVkLW1lbW9yeSB7DQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhbmdlczsNCj4gPiDCoA0KPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBkZWNvZGVyX2Jvb3Q6IGRlY29kZXJfYm9vdEA4NDAwMDAwMCB7
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlY29kZXJfYm9vdDogZGVjb2Rl
ci1ib290QDg0MDAwMDAwIHsNCj4gDQo+IFRoaXMgaXMgcmlkaWN1bG91cy4gWW91IGp1c3QgYWRk
ZWQgaXQhIElmIHdlIGNvbnNpZGVyIG9yaWdpbmFsIGNvZGUgYXMNCj4gd3JvbmcsIHRoZW4geW91
IGludGVudGlvbmFsbHkgYWRkZWQgd3JvbmcgY29kZSBqdXN0IHRvIGZpeCBpdC4NCj4gDQo+IE5v
LCB0aGF0J3Mgbm90IHRoZSB3YXkgaG93IGl0IHNob3VsZCBiZSBkZXZlbG9wZWQuDQoNClNoYXdu
IGFza2VkIG1lIHRvIGVhc2UgdGhlIHJldmlldyBwcm9jZXNzIHdoaWNoIGlzIGV4YWN0bHkgd2hh
dCBJIGRpZC4NCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

