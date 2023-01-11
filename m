Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379FC665BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbjAKMy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbjAKMxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:53:54 -0500
Received: from mo-csw.securemx.jp (mo-csw1116.securemx.jp [210.130.202.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BF718E27;
        Wed, 11 Jan 2023 04:53:51 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 30BCrN5X020176; Wed, 11 Jan 2023 21:53:23 +0900
X-Iguazu-Qid: 2wGrYclpvZ4AIX2un2
X-Iguazu-QSIG: v=2; s=0; t=1673441602; q=2wGrYclpvZ4AIX2un2; m=aL9ctF7rWmgapPMfAQRMglqtFD5hEQ7XfFcKL7dXqsA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1112) id 30BCrKfj024795
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Jan 2023 21:53:20 +0900
X-SA-MID: 48926635
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThTWWrYBGzAixDXCjqAPrVw2yONoMGzDPruQ857Ujgtz6S4UJUzOAdcVUeV7/3pvr7p4T6nk9OH/LUk4oWHry20Ffw/AEch6qZxw0gqmm/1RRHlmFTTkGEL2tVW3wquyIAMc/KPk0ncG31r0GeL8K+s/j7/5KxNzSsjZyIImh9Mm7+oy0K7I5JS73q7zRqj8YCqCcl6KDPTvjocCbIciSzeWUjMTUa3b+pzVYEeHbY0afItBUzoXjxt6qEIehepCE7R4BGSAF2iSoCW/xRedaCyS5st+qIIhatuaBvIUFy8sdokA5pDAz0QXJXauiFvyS42twXnKHYjp4Ge0K1JrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH9k8cQDA7idCSEZSDLuTxffLe++PoVJgLKMNhjP9lw=;
 b=dr4HRxungPIdDlvqkldaRtU0CnaanZas8kjUuF06GL36/qpLNtpsS8d/NvMUV0gb++4SfiZBbsRTqFI4ilzL6MoTz5QWESe/gF5a1EeYTPxrGIUQqSEeXCM+ZsUgoRBYrWPxRLgvLjQQdafq2Mzil/VdmPMIx3jYVVu4y6vz+Ly2Dgws5QlSKGdV4/deQNRjiyFr4ws/ZfAFddJNaAMLXnS5WlKp7YS8okDbvLA+Nkh8bchOu6g+6i1745eYUn+ic3qFn+fT8gU8U44rubfaFPHiPZDzxRWHH4AW47stZWi5xeGMomtvvPOtkRaSG2igeeXBe5el1Cvmf8o5oNSN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <krzysztof.kozlowski@linaro.org>, <hverkuil@xs4all.nl>,
        <laurent.pinchart@ideasonboard.com>, <mchehab@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <rafael.j.wysocki@intel.com>,
        <broonie@kernel.org>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Topic: [PATCH v5 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Index: AQHZJWPq25Efj94upEGIV2ZkL1BZ0q6Y8NyAgAA4CtA=
Date:   Wed, 11 Jan 2023 12:48:15 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201BA70A46B99142C9D412F92FC9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-2-yuji2.ishikawa@toshiba.co.jp>
 <a5aa6c41-941c-8337-d83a-ead2775ba864@linaro.org>
In-Reply-To: <a5aa6c41-941c-8337-d83a-ead2775ba864@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|OS3PR01MB5637:EE_
x-ms-office365-filtering-correlation-id: 3537833b-614c-4f7b-2c79-08daf3d21bb0
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0QYB99PtkUgHEWoBS0OuhTsxcn77hhb/3X6nUoPpp48NpqWFpaqmKxuOPa6lH7b3jhBO2Y/58GJTiLV7dNwMjOM7R/iGneQpXl0El0u3OeyYB0pzVcJxWNTXjNzcRHomBw1TR+joIqxZxMNbHbUCdgMLJNhVJt8UV+/9VWRZ1VIJIiDiO7GkAaaW0Yk0Z1hWQ2TLePcFEXk5cAhiv1D/ftJXvxf5LlmHio9856JcZEsZDgyxXF4IZVnq2hfAyUXIuCMXGOSOmSMmi4v9y3vfHqIYILimX1AuL/+EwKnByYQzdF+jhxNkyZ0TxfwixAlQ6vxELB0N211fW1F9+jYoNMCho+K0HhgDRGfAgYf33CChXGh9QAmEeabTD6tV7LlqdJolFg1lAEHJKy0EzGCH82qiVQhC1EoEaeO9eoLoyEQWNWZEWhj5O8MScQjE2Tt4zsPACcs15T/+8WxGwJ7Jx2NkNrY2166Rvk8o9v89XZwbywiAjdJRFdU+yimc1du/OUAAPKBgbxYlMhV7zKArrGBgfLeU5zLOFWW6FKBeKQpu35gA2qax7qjBeM9jKDVeEmqyRPb3wRJhytO2bsNYyC9zMGpcDRs3E5rRwyMuY6RxnY+51cC7un2DdiQU77kf3OyglGO/ttH7JtvV0vHxZj1DenqJGmH+L/RECCoDR4AkGVkN5EWqrgb2Ugr9Usfp3mWfwPfE3IzaDnnjZfu9nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(66446008)(66556008)(52536014)(8676002)(83380400001)(66476007)(4326008)(8936002)(66946007)(64756008)(86362001)(76116006)(55016003)(33656002)(122000001)(38100700002)(38070700005)(5660300002)(7416002)(478600001)(110136005)(41300700001)(54906003)(7696005)(2906002)(9686003)(6506007)(53546011)(26005)(186003)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2tWTlJnUDdjbWJOd1hWNEpuTUFIS251ekcrQVBSSGxYbGdFK0xBTVEwcDR1?=
 =?utf-8?B?b3MwYTZGRDhXMU9yQjhSZVBRMzhKb3Y3dUYzY3lYRUljSFJ4Mk16SlZDci9Z?=
 =?utf-8?B?ZjF0cFFlTlFCQjNCSlNwYWZHeC9SRUxMSm9sVVZSN0Q1VW1PTmV0eVR5NnFK?=
 =?utf-8?B?Q0NQVytkdHd2TlE5WjlMTnhwY2pMYm9aUm5sVVl3SGhRdkRsNGFUeStpMGhk?=
 =?utf-8?B?V3BpLzBGUXg1VG9aWCs5QTcrNFJxS0JuNkh5SzhVV0Z6bmdXNjZUM1ZHcTBl?=
 =?utf-8?B?SnByR01DbUVHS1dHaWlmU0VPV0wwVUo4VW1ONlR4WjlXakF5Zkw3QzJSa2dC?=
 =?utf-8?B?ZHhTMzZMNnNqZ1FuOUZCVUJ1WnlCWmkxSWVHNjk3RWVLRjNKbVlBeDBaSVdo?=
 =?utf-8?B?SklkTHFrRlpMbHN0M2xBNEZPanJOKzhXY2JKVXBOU0l6bS9YVWpxSzl0ZkVo?=
 =?utf-8?B?NWl6bkVPYjZER3hZaEQ3dVAxakFQRndRbTFxdVBraUd3WFZ1d2V5ODdvRitH?=
 =?utf-8?B?QU1yam83a3AzMVh6Q0NDUFpFQ205YVdQTjFjQ1M5VHk3UncwRDZSdFpTSnhL?=
 =?utf-8?B?eUFUSlpMSXlMbmx6Z1Z0R0szQ01ZS29Jemc2L3dnTE1DQzl0UlJMNjNTTk9E?=
 =?utf-8?B?ck9ZS0dKV2hlcmR1SVcxQUtqejdENnVYNC9ibGNaekptSFBCS0RQUHYxV21Q?=
 =?utf-8?B?aXJ3Qm02aGlYckdmRmFISnpheWxUNUVwMU03SmNpZG9ZSUpxTVdKeWNtN0Vo?=
 =?utf-8?B?WUdSMXBvYjd2VG5nTXNvbWdGVDNqTXlndUs3YzY5eHNKWjJScXVQc24yU01u?=
 =?utf-8?B?Qno5cmJpRWFwQVEzQmtZeE42SWVEbGU3aENHck9EOGR5ejV4ajkzUGlDcHdC?=
 =?utf-8?B?WnhqYnpnR2lJejVNZmFSMStNWGxOUHN6N0crbEQ2TjN4MGdqR1BTemZpZDMr?=
 =?utf-8?B?ZkhGdS8rTGpXT2ZhKzFYa1JYUGZ4TUI4M1k2cjRsc3pHV1c0TmVwNDZDZjBD?=
 =?utf-8?B?Nzl5YVYzVUF3QmVKUTV4TWxxNlVCcUF2cnJ6Q210bnBHWndKenptT2xEWDA1?=
 =?utf-8?B?SWpEa0lhRHlXdXR1ZG5FWVlJRTNJMzBIKy8wNGdUeHJNKzlncExyNllXZmhu?=
 =?utf-8?B?ZHVRclc1Y0FQUWJNb2VzUXdPc3hObVZGbUhZQlM1NlZZZ0JQRGR0N2JWQWlw?=
 =?utf-8?B?RURlTnlBV1pDcXJybGtkZ2ZldkthK0Vyb0Q3RUdLOVlkWmJYWjJ6RGZMTWFz?=
 =?utf-8?B?U3VwQ2hZK1h3WFMxNGk1d0grbTdVUUNuN3l2dk50b2JBNFRvUVVxdDZSVldo?=
 =?utf-8?B?amlzK3F1eHFuSjV5VEdoeE9tMmQ3cTZZTFJEWm5EQUJ1SFVSaEZ2c1h3d3Q2?=
 =?utf-8?B?ZHVocTNBdlBid285c2NZc2VmN3RUNVVja0lCQ2xFaHk3R1Z6WC82SjRLM3o2?=
 =?utf-8?B?dUFiUlRQR1MwVzZndDhuMFNGaVBsbExGcjNMRGRNYU15Nk93SW5zV1R1ZFlP?=
 =?utf-8?B?UU1zR3Ewc1JqZjdCdzRVWnFMVGtOak5vbVMyc0JVckljUXVQamZ6WjRxNDU4?=
 =?utf-8?B?L0pFalYybVBEVnNKZWplZXhmZEYyN2V3bHpLdk5pQjRJYnNzLy8weUFGU2xV?=
 =?utf-8?B?S1k2VVA0cDIrZ2QzOVJtbUpidkErdDlBeUpOckFMVElXVWNuQWtsTnozOXhG?=
 =?utf-8?B?SGtKNk8wV05QTGNLcmU2NFROcVpxWU83Z1BXbmVQS3o5NUszZWgvZVJXVmt5?=
 =?utf-8?B?SjNPeHc4RzdiamNxMkl1dy9GV0M5UTEwUjlFczJBL3N5VS8ybktxVzk3cmFN?=
 =?utf-8?B?RG9RS2FaMmpjSzNtSlBpT2R5YjdBbS94RkFHVXpCRXI3TEcxbTdrZUJUeDhp?=
 =?utf-8?B?czBzb2xDRE4venMxeXp2Yi90cE1XcFVyT3BnWU9UZzF6Z2w3U0l2dGl3bm1r?=
 =?utf-8?B?RmZZNzhERmt1ZjU2dVJYdlp1VWIyL0I5Q0Z1aEZsMzRZSlRMRjJVSllndmNp?=
 =?utf-8?B?aFRMb0tYaXgrNmt1OFR1d3N5bXBkSFRBOGRObE8vTlBQWVVWYmJJSkdGc1hx?=
 =?utf-8?B?cXRESWYrU0VmYy9MR2s4UjJHWCtKT1Bxa0Z2SlY4cG80eW1zTFR1QXZlakdn?=
 =?utf-8?B?VlpWOG5VTzc4QkovUWV1VEl5NWFES3IybTBOdXgrQ3krQzRSRE1qUXBPS050?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3537833b-614c-4f7b-2c79-08daf3d21bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 12:48:15.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypBu4AzLj74TS82d4k+GdGtLA7yzVckJyVuJJPiFKs/evR0rvxXeo8BUcsR3u7cT3qxaHY3bOmBQ/AqFVDhlbTqK5UWY6u0jya4mBnXEKd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5637
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEphbnVhcnkgMTEsIDIwMjMgNjoyMCBQTQ0KPiBUbzogaXNoaWthd2EgeXVqaSjnn7Plt50g5oKg
5Y+4IOKXi++8su+8pO+8o+KWoe+8oe+8qe+8tO+8o+KXi++8pe+8oemWiykNCj4gPHl1amkyLmlz
aGlrYXdhQHRvc2hpYmEuY28uanA+OyBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD47
IExhdXJlbnQNCj4gUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT47
IE1hdXJvIENhcnZhbGhvIENoZWhhYg0KPiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgaXdhbWF0c3Ug
bm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpDQo+IDxub2J1
aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+Ow0KPiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxp
bmFyby5vcmc+OyBSYWZhZWwgSiAuIFd5c29ja2kNCj4gPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwu
Y29tPjsgTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KPiBDYzogbGludXgtbWVkaWFA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS82XSBkdC1iaW5kaW5nczogbWVkaWE6IHBsYXRm
b3JtOiB2aXNjb250aTogQWRkIFRvc2hpYmENCj4gVmlzY29udGkgVmlkZW8gSW5wdXQgSW50ZXJm
YWNlIGJpbmRpbmdzDQo+IA0KPiBPbiAxMS8wMS8yMDIzIDAzOjI0LCBZdWppIElzaGlrYXdhIHdy
b3RlOg0KPiA+IEFkZHMgdGhlIERldmljZSBUcmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiB0aGF0
IGFsbG93cyB0byBkZXNjcmliZSB0aGUNCj4gPiBWaWRlbyBJbnB1dCBJbnRlcmZhY2UgZm91bmQg
aW4gVG9zaGliYSBWaXNjb250aSBTb0NzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWXVqaSBJ
c2hpa2F3YSA8eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcD4NCj4gPiBSZXZpZXdlZC1ieTog
Tm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiA+
IC0tLQ0KPiA+IENoYW5nZWxvZyB2MjoNCj4gPiAtIG5vIGNoYW5nZQ0KPiA+DQo+ID4gQ2hhbmdl
bG9nIHYzOg0KPiA+IC0gbm8gY2hhbmdlDQo+ID4NCj4gPiBDaGFuZ2Vsb2cgdjQ6DQo+ID4gLSBm
aXggc3R5bGUgcHJvYmxlbXMgYXQgdGhlIHYzIHBhdGNoDQo+ID4gLSByZW1vdmUgImluZGV4IiBt
ZW1iZXINCj4gPiAtIHVwZGF0ZSBleGFtcGxlDQo+ID4NCj4gPiBDaGFuZ2Vsb2cgdjU6DQo+ID4g
LSBubyBjaGFuZ2UNCj4gDQo+IE5vIGNoYW5nZT8gc28gYWxsIGNvbW1lbnRzIGdvdCBpZ25vcmVk
Pw0KPiANCj4gVGhpcyBpcyBhIGZyaWVuZGx5IHJlbWluZGVyIGR1cmluZyB0aGUgcmV2aWV3IHBy
b2Nlc3MuDQo+IA0KPiBJdCBzZWVtcyBteSBwcmV2aW91cyBjb21tZW50cyB3ZXJlIG5vdCBmdWxs
eSBhZGRyZXNzZWQuIE1heWJlIG15IGZlZWRiYWNrDQo+IGdvdCBsb3N0IGJldHdlZW4gdGhlIHF1
b3RlcywgbWF5YmUgeW91IGp1c3QgZm9yZ290IHRvIGFwcGx5IGl0Lg0KPiBQbGVhc2UgZ28gYmFj
ayB0byB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiBhbmQgZWl0aGVyIGltcGxlbWVudCBhbGwgcmVx
dWVzdGVkDQo+IGNoYW5nZXMgb3Iga2VlcCBkaXNjdXNzaW5nIHRoZW0uDQoNCkknbSB2ZXJ5IHNv
cnJ5LiBJIHdhcyB1cHNldCBhYm91dCB0aGUgcmVjaXBpZW50IGxpc3QgYW5kIHRvdGFsbHkgbWlz
c2VkIHlvdXIgY29tbWVudC4NCkknbGwgbWFrZSBhIHJlcGx5IHRvIHY0IHRocmVhZC4NCg0KPiAN
Cj4gVGhhbmsgeW91Lg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KUmVnYXJk
cywNCll1amkNCg==

