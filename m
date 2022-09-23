Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934EF5E7BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiIWN2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiIWN2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:28:16 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DC613BCF9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:28:13 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2044.outbound.protection.outlook.com [104.47.22.44]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-YMCO2ADXP9GiidHPiZMSWQ-1; Fri, 23 Sep 2022 15:28:08 +0200
X-MC-Unique: YMCO2ADXP9GiidHPiZMSWQ-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0780.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:56::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.17; Fri, 23 Sep 2022 13:28:07 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d10c:ccdc:19a2:a141]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d10c:ccdc:19a2:a141%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 13:28:07 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 4/5] clk: imx6sll: add proper spdx license identifier
Thread-Topic: [PATCH v1 4/5] clk: imx6sll: add proper spdx license identifier
Thread-Index: AQHYuYFG/X8GA3dipkiuxx8Jiw9fT63tLZ4A
Date:   Fri, 23 Sep 2022 13:28:07 +0000
Message-ID: <0bd909c734a0dcc4f8f5af452fb0970d80b624a5.camel@toradex.com>
References: <20220826192252.794651-1-marcel@ziswiler.com>
         <20220826192252.794651-5-marcel@ziswiler.com>
In-Reply-To: <20220826192252.794651-5-marcel@ziswiler.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0780:EE_
x-ms-office365-filtering-correlation-id: 427bfa56-4dae-4e21-66c0-08da9d677382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 8S0HyEsrYvc0fF/VlEbloWFi5HAoMtgU4N6bk4uAj3ITMrZg2hhsYBTOHfW7maMjgKDAOSFKpN//jY4Am+C6vWdaZ1xFU4jX4l0o+VM1pawQvHKTveUDrkS6pShFGoeKz6nht9lv0Qiu9W85xnB26/YCvjNUbGL/6nJq1aZ+SXWhQsh3Pwv+CT00Ki9WnpJ+FEY/vwQSy4Ic0wtF+q9QPWLC9na9OV7qIYOxcq278+pR8gVGkzHpK/deIl+/k8QmjMnvZqE+WB84G8d0SxFancGj2qi4tedr/pL5Aehs/GjMpR2MS+t9hTwXAsnPXlkW55YNv5lzCyaOR9zWyTI3sEUSRR7aPO/ZH5ca/klXHoALmDnvJJpJlbROcyaeCQBoSl503XPJ4AZuZmkxrjf5zL6/v5TZuIoLMTpZuEeCasofi7gCXT41Y/dWng771lVHUR3pvw3DZsEIW279gU16vZipjrQNXegUpFR9gI9CHwyxNFOJ6h4ETZt2nvcXonl7Nl/5uinOwDlrwfRXOZIFpmCOGNy6D5ka6eLKY5CF/JpPI/6wZMLYPmGOYN5+shyN8VYetOZStNAIGW6Otdc1cipftfFXcuo29/pm5kQcLA/ZYSPFbJQiGG/dgDGpMdnH6NMVhJHcBv+TVV3kT13z4VvvgY6ASJJNdZjOqu59S1tz823w4/wRZHDyEmPFYpgQeGaYgRF+wRVufvszHlpr736p8Ou1PQ6LPoWaacD7ciaYVF1oOUoT7Kw5O7lPsfNwgiJPgoYF/n6E75d6wXGUYw0xFar/+yLHT93JH7Lojb8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39840400004)(451199015)(36756003)(2906002)(54906003)(8676002)(76116006)(4326008)(122000001)(38100700002)(83380400001)(8936002)(41300700001)(5660300002)(44832011)(6916009)(316002)(66556008)(86362001)(66476007)(2616005)(478600001)(186003)(7416002)(26005)(6512007)(66946007)(6486002)(64756008)(71200400001)(66446008)(38070700005)(6506007)(32563001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?by8rbG44ZStwd2ZzOUdQa1E3MlBzbmgxNmlwY0lCQjFkK2FuT01raXhZSTJE?=
 =?utf-8?B?RnNMWXRGSnFVYXVrSThwTjdoL1U4bmJ0dkhmWDNoWWtZWUI0SG13VjFnd0NW?=
 =?utf-8?B?SXUxYzlpT25GL3UvT2RvQTRCblQ4a1Q4WUsvdnpDUkQrUXhtaHYyTUtENjJO?=
 =?utf-8?B?ZkcwN1dteTlnL3A4bFZZejJCaVBUNWpMbnM0czd6NHpEQkthclBSc2ZERmZZ?=
 =?utf-8?B?bEp0MjZ0T3ZHQjFiTzFwdnlGQmVsbkZBUEUwSVYrcjBPT2lucUpkUGVYTzJT?=
 =?utf-8?B?bVMzZnBNZVR1b0xqemFDdXpmZXpJVW5iLzZnTktQT0tLNVJ3dDFmTlZJT3dI?=
 =?utf-8?B?SGcwYXBPaGh3dXhVeTYvVUlESzhwWlpQTTJ3NkdBNXZWejNUT0R3RmdLVHI5?=
 =?utf-8?B?Q3ZJZStGOUZocnlMWWU1elIrRThqN1hFaysvVjBYSm5keGFraUdoRTc3MjBp?=
 =?utf-8?B?bng5K2xLMDJncUc1TU5LZ21VVkp4U1B5NVlnYkxnMlpKTVphWWppMXY4MmNp?=
 =?utf-8?B?RGdYQnB5ZHFSNU02enQ0N1RlVVdUOHRrNUJwZWcrWkZpZEVMNThEYXRqWk80?=
 =?utf-8?B?VWo3WUV3TG9nSjlRS0NpQkh4T1lLT1JSejJDemVvU3oyM0VVUjdWVGloYTNJ?=
 =?utf-8?B?V1VFM2VWL1FMVFg1QzhnY2dhY1NZTTVaVnlhWXZya1Ayb3RQWEVlYnVQWU9Z?=
 =?utf-8?B?SE9Qek9rQXVOaXdlYWpkWnZoYzBzMmlwT2s5SHNKTUc0VEpRNkpvMHFvWW1Z?=
 =?utf-8?B?U2piK2R1bkl6MC9QZ3k0OWVYSmlVejgzTDRiSU9LOStCRktZN1pXWnpTZkhi?=
 =?utf-8?B?dTlGYThjZEtDODdjTzRWRzBralBiam9YZE5OditGNEhiTkJjN2IweExTUWQ2?=
 =?utf-8?B?ZGkxaU0xdjBzKzUvaGdCWlFUemVXeURtclBwdW0wWko4Wm00Um9VUHgxVWdK?=
 =?utf-8?B?UktvN1ZnSUYvWUlpR0hPT1JGMk1iZVdFWHZZcjhrUlE1Z0hTRzdEMHlOUkpF?=
 =?utf-8?B?TjR1UkFXSGg3QzJBWDA3MEFBVUNTOGs1UkNDU201ZmdRUENXaHNtU0xadW9Z?=
 =?utf-8?B?NTliYVJDaU1ySUc0cmZXNjk1a2lIakplZnNnQmxtMHNXbkxVNjBUdXVHTEJP?=
 =?utf-8?B?c3RqdG8vUlpqcEtqYWtKcmdQYjRNc0lORkNsZGJOcHRLY0dsaFFnRTZoa09X?=
 =?utf-8?B?c3p3RWFOeDgya09VdlAwSUtKTSt1M0lJSFFKSk96VkFBczlZWW5IclM2Y0hS?=
 =?utf-8?B?cFFQRWdrbElFMm5RQWZWMmZLbm80YWdEc3pkY0NONlVnSnMyUjcybDl4RDJz?=
 =?utf-8?B?RndybXVVVmpGTnA3dlRRbkpEZkQwbTVOaEV4R0RmaGpDU0pzOHZ1dWprdysr?=
 =?utf-8?B?bW5vQk5xc1VoMXZKTGVkeUFSWE1rQnNxcDh2WlZRZjFObXc4bmtGSDQ1TERm?=
 =?utf-8?B?NWFnUlVzYmlkYWs0ZjB4Szd2YTB1MVJxOEFVcXZKVW5mTHdudTFyU05zOXZV?=
 =?utf-8?B?Q3dtUWN1c0ZJM215M09HTzUvNnZtaWpnWXppRGRpaW9MSUs2aUwxaDZ2eXJ4?=
 =?utf-8?B?aEVtYjZHWWV6dld5am1KZ0xxWlhRa3pJSVA5ZUM1aGpUbFZGRDYrYU4yemt4?=
 =?utf-8?B?S0V6YlZnYjNUVlVtSWZqa2pCWmdyTXRvUCtsbHhuVEdkTlhWL0J2VkZMZ1F4?=
 =?utf-8?B?YmhHaDd2OHFVYzNhdUg0RitLQjZiSmx6alRCOTJjelBBRmR2cDhDUnI5R2Jl?=
 =?utf-8?B?eFZXUVZoVGwvZ1dCVTRpS3BaaVpQakNDcTVTSm9wendTWlprdjI5c0hPVHIw?=
 =?utf-8?B?dEVOdEdQeFlOOWhLTStkVkxReVV0QjRVd3MzdkpCRWNGQlI4dUk5bFZmLzBO?=
 =?utf-8?B?akl4WTJreUVOb1dzSmdoYnpraDBad3d2YWxISUJYM1VOVEl2cVBPazl3Vm9y?=
 =?utf-8?B?eFZ6TzVXMm9zY1Z0UWpxSS9KQ0k3MHdWNDBJQVBiUU9uM1R2MHJOcDluSFov?=
 =?utf-8?B?MGV5V3p5ZDBXQ1BTaVV5NUdIckdUdHBLM2NtMDE5QUd2REdsck5UbWViZ1ls?=
 =?utf-8?B?dWdQZXlRbXorcENtZ0FBZnBHQ1YrR1V6WUlRbld5VlZ3ZWk0YUFaQ1dwMVdz?=
 =?utf-8?B?MEM2dCtYeTl3dGg1RktyV3pJcG9YVEJlekZ4cnRaVGhvU3hhNkhrSS94dDdo?=
 =?utf-8?Q?Mvw59S6Hs5binBzExf8zTC4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 427bfa56-4dae-4e21-66c0-08da9d677382
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 13:28:07.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJmed7C7Z2Ty6Kl2UDlwsis8IB0n528R6HMchk2rdwJrE8nleu9UrMAW+qf3urkyHzj6CVEXvKzP9srRo7ls12iZSikKaGdmIJWREiFvEkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0780
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <CDCE015605FB944195DD1D52F2BA83D4@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTI2IGF0IDIxOjIyICswMjAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
DQo+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0K
PiANCj4gVGhpcyBmaXhlcyB0aGUgZm9sbG93aW5nIGVycm9yOg0KPiANCj4gaW5jbHVkZS9kdC1i
aW5kaW5ncy9jbG9jay9pbXg2c2xsLWNsb2NrLmg6MTogd2FybmluZzogSW1wcm9wZXIgU1BEWA0K
PiDCoGNvbW1lbnQgc3R5bGUgZm9yICdpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDZzbGwt
Y2xvY2suaCcsIHBsZWFzZQ0KPiDCoHVzZSAnLyonIGluc3RlYWQNCj4gaW5jbHVkZS9kdC1iaW5k
aW5ncy9jbG9jay9pbXg2c2xsLWNsb2NrLmg6MTogd2FybmluZzogTWlzc2luZyBvcg0KPiDCoG1h
bGZvcm1lZCBTUERYLUxpY2Vuc2UtSWRlbnRpZmllciB0YWcgaW4gbGluZSAxDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4N
Cj4gLS0tDQo+IA0KPiDCoGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14NnNsbC1jbG9jay5o
IHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14NnNsbC1j
bG9jay5oIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9pbXg2c2xsLWNsb2NrLmgNCj4gaW5k
ZXggZjQ0NjcxMGZlNjNkLi40OTRmZDBjMzdmYjUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvZHQt
YmluZGluZ3MvY2xvY2svaW14NnNsbC1jbG9jay5oDQo+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGlu
Z3MvY2xvY2svaW14NnNsbC1jbG9jay5oDQo+IEBAIC0xLDQgKzEsNCBAQA0KPiAtLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wICovDQo+IMKgLyoNCj4gwqAgKiBDb3B5cmlnaHQgKEMpIDIwMTYgRnJlZXNjYWxl
IFNlbWljb25kdWN0b3IsIEluYy4NCj4gwqAgKiBDb3B5cmlnaHQgMjAxNy0yMDE4IE5YUC4NCg0K
SSBub3RpY2VkIHRoYXQgdGhpcyBvbmUgaGFzIG5vdCBsYW5kZWQgeWV0IHdoaWxlIHBhdGNoZXMg
MS0zIHdlcmUgcHVsbGVkIGJ5IFNoYXduLiBXaG8gd2lsbCB0YWtlIHRoaXMgb25lPw0K

