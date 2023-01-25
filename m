Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7267367AFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjAYK0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbjAYK0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:26:17 -0500
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D79A303C7;
        Wed, 25 Jan 2023 02:26:14 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 30PAPblU003975; Wed, 25 Jan 2023 19:25:38 +0900
X-Iguazu-Qid: 2wGr5g72Qg5UDArwup
X-Iguazu-QSIG: v=2; s=0; t=1674642337; q=2wGr5g72Qg5UDArwup; m=Ie7n3otFoMyN3vAtuaxvL9oktvWNELN2oPO0NilkXEE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1113) id 30PAPZ1A005220
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 Jan 2023 19:25:36 +0900
X-SA-MID: 49732430
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZAKY5HnSUyCecKfi7zZbvh8QIr3u031mQrYAxS9NN/h10CrR9gBOqzxmTl+CEuWaETqKlSSPJ8B59ymzfXsh9Ii8O7XAwzKOyT8Vfrw2BZhIB2VG3m43U+5xgtY+ajz9DQWpjMXTl5OVciOqvEonlFc6L/+zGjaoFT+VI0w1GJ3Fb/ojwyJw2KW+hzBuY9sbYMN2mVWnpkDp9inmwavLrCaCi1fY57/eLbA9kkOsYctMvOChMPK5DoYipZD8JyFG8MtKG0YhTe4M3Iadl32s5DBc+cmypCTFyMwgM1mehiRT0ZVP6tEouhAXb7I+pMkWxu94gdVwQUZIMxVZTNz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KT6yyDFQNLJf/mEqfsPUvk/nk5j4iMurUE3EK7BBiHU=;
 b=d7zPpSttH6mWmHj7HMWUcePBob4WLXKXLwPODc41N6s7hiCVIvAylZxcGTahj32V5mkH3htIiFM4OzaayMFjElzQQbXMEV1NQKhjkBuBqObxssBL2N9KKbC7Qlntowh5PwTKKIlIyQeFQLM4nizJ4jjqqdvCBzGPBnm60ZJ5wN2GSUVOsb1Xt1HxtnIIC4deCe+PfsFiiCFx+9nbDjrhEpGzNOrjj1RY3ANHWVAHXkWo6kgXNErSqOVj0gbqR+e8xgzUez3CEs60uRDt/I8A8moYbeAy93kCbYSEVRM9KBwt0g3VRX3g4ckKHFzoD3iLN76hfxlBt+6InzeBW9el8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <laurent.pinchart@ideasonboard.com>, <hverkuil@xs4all.nl>
CC:     <mchehab@kernel.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <rafael.j.wysocki@intel.com>, <broonie@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 3/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver user interace
Thread-Topic: [PATCH v5 3/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver user interace
Thread-Index: AQHZJWPtmelSVsjZq0uVz/vT5NgNQq6iiBUAgADeugCAC5bFoA==
Date:   Wed, 25 Jan 2023 10:20:27 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB620161823BA912502CEF0A5992CE9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-4-yuji2.ishikawa@toshiba.co.jp>
 <2b412539-2236-b41f-c777-bc9e9cf99d66@xs4all.nl>
 <Y8dFlFkVJS/6+Ib1@pendragon.ideasonboard.com>
In-Reply-To: <Y8dFlFkVJS/6+Ib1@pendragon.ideasonboard.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TYCPR01MB11709:EE_
x-ms-office365-filtering-correlation-id: d5f96a83-4c45-4e8d-efc8-08dafebdc792
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: meWzXlFTuaBjni2MNWc8UgZxz9Yfju9todSamjMCJMujaMjk0+Cp80W1Mn0aPOYQ/2rJJd/dHZROlYelj2axpxTOmXhC1FxpTq8T/8GfwbGRYBCF7DoSz3+Ww4WO9xjO9miCl9jYCKXn6wgM8wFx7mAdjlfP5OGJulO3n+d0nMzULV0/Wij+QHmenZBtkzOvoRTRDdDMc+ps56yTfJdm8Q6j+sVO0yNIGyDypxcV6Rpqe5Kbc1a4dF0VFfiDGFYg/HPAW7VmqRaX2Qr8Dc1AkqvJx2XrYA8pvmvKduYCbNZctyCfFKHtPp4u/MxqM2tgmd/S0EaDcGVcaD/T8W3ZPTPggp5zJ6mJfcNlVekwGRDr7XGV6usJPOPA2d2o5f9ZS6CmJzsmMcQ17yj1bdlLMg8L+aHTN1uJ5M6AnJFyadNDlietM+hGGMfehbPK6+ZTw2we1iY6bl6Eonk6l60qSExzYSTinRvxLwZ116tq8H8593yWUitT6r+f7VlCRY1cnOB60+hzGCcAjPbDEM359TqXOU9d4VZo5rPiv1lkZJa8TkonsMcW/j8xJ13KE7ru7DYXXpZYXv4Ppe2P56WfhqQ0VYxG9tP9Yp2QHhU4AYNJ5ftiqQum462U4gStyBh10r3gXBfT1ZubIz7MImNkoWLh7dwBhRngNfUIJvf0HBn3S1lTzkUYNRHOJvMsCAb9BxHtAIKPNtpp/gc8Wu54pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199018)(5660300002)(83380400001)(8936002)(2906002)(33656002)(52536014)(7416002)(9686003)(26005)(478600001)(38070700005)(186003)(122000001)(38100700002)(76116006)(316002)(54906003)(64756008)(66476007)(4326008)(86362001)(8676002)(66556008)(66946007)(55016003)(66446008)(110136005)(6506007)(55236004)(53546011)(71200400001)(41300700001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUV0NENCZUlMc042OUNhYzd1ZjN1RjFzbjdVOVJMb1RyaUI4Q2hmWUxUM0dO?=
 =?utf-8?B?a2huWERjWGJ6TXhKYTJQODZzNk1KUmNBZGZNY1R5TlhWYTY1TlAvTFFOb0Jn?=
 =?utf-8?B?b2RUVFloWE1tUzZ2a2RBV09DT3VsYlAzcFVlL0R2QWcrakJJZThsenBVZlQ3?=
 =?utf-8?B?aU41SHMxUEl5bFNMQlVPbjYvNklMVUZ5ejlidk8wSzU0ZVhpbUNhUWFjYm5T?=
 =?utf-8?B?S1ZtVHN0emhVYWtqeWJmbWNOaTV3YjMvSUM4NkJaZ3RTNFJLVUppME9sRExo?=
 =?utf-8?B?alBqenFSdExGb1JaemltanV4c2UvQ1NYYUpVUlR6UVlka0piaU1KTkU3ZlNC?=
 =?utf-8?B?NHZORTNTUU4rQnBremw5dnpRSzJCNE9hM0drclVoWFUxYmJCcDljT054YTB6?=
 =?utf-8?B?ajQ3YjJqVkFEVzl0MktMVkE3amc1alhMR3ZhL0V2d2pEYlRZNlYveGZGZGIx?=
 =?utf-8?B?OW9Ta3JvSFpPRGxOSTF1Mms1cTRPdkQ5YWdEeTZ0dnJUN2wzQm1rVVFsMnJq?=
 =?utf-8?B?dG82WW9aNnRQOVgyV0U3RjBhaGpia3FzcStscVRUeW9abEVYSS9OR3djdW1C?=
 =?utf-8?B?RG5JcnpMaGFKd2pSbjFHNThUVyt6ZTAydEY1Um93VVAyNjFUS1lMTWtWcVpw?=
 =?utf-8?B?bHVMNTh3emVFWGQxdGtucDFBRktheUY0NmgrcTZlOE5qM1A0UkdvVXRtMmZ3?=
 =?utf-8?B?MGVCUWFQMFlZdDBkVU10SVUxeHhWSkF0M1drejBETDZJbjZmVUhxWndLNTln?=
 =?utf-8?B?WTBwQnJ1Z05SVkpFTnJjYjZhQk9rMWJhQURPSXBIM1pwL0tkcWQzaFZZa2Ey?=
 =?utf-8?B?SXRZZVZGaUVCNWs3eXFTTkgvWnpkL3NPaE1YNWpaQTQ0bW1LNlhxZG4vSXNP?=
 =?utf-8?B?V21QdWZoTjN0STVMcWRUZGdJMjNVOVpCS2FvRVdBL2s4N0dzUWJuRHB0akxV?=
 =?utf-8?B?Vm9yRU1xRmJsTmVISjlJZncxeHMrTTZpQksyR2dwU0VnelBZSDBsZENWUlll?=
 =?utf-8?B?UGNkU0QwbTdWZGNycXVTcEJtSEpNaTkzdDdaNEdmaW56NXp5ZCtMVUNNakNS?=
 =?utf-8?B?Z0JCdkVqTStSRC9jN0xIQ3N3SFJjZzR3UnFKUStWQmVqRFN1NjBVVllDQk10?=
 =?utf-8?B?aS82ZnlyS2tTa0o4NmFubk1FM3VpSENlazVvOXBITTRCaVp1MHFMc3lWR3Zk?=
 =?utf-8?B?MDBJOGZ1L0V1dmp0NEc3bTkzWkp1bk9OUWRmNXh4ZmEyVlNrY0h5cE5nNHRT?=
 =?utf-8?B?Rks3ZktwbXgyRTQ0bXBwQ21oSklzblllOWNpUjdkeWdWRUtURjBxOURpd0cw?=
 =?utf-8?B?MEZRL3RlNjd3eVZMeGtGWE10bHdXdDR2c3IrSjIwZ1IzalBZNU80b2V0KzUx?=
 =?utf-8?B?cTZXNnVPWm16VWYzbzhtc3cwUkJKcUIzYnllOWN4KzNTaEpWNTRvK0E3K3V5?=
 =?utf-8?B?aHZVTnl1ZEhyWTVoZlNyK3REVGtTLzVMeGxDRTJ3YXhHUEV2bzFUVVo2K21L?=
 =?utf-8?B?Z0NQTUJLbUkyN0VzUmdRREt5U1lvMnZ5cHFJY3N3R2ZNWlIyc2xYMmF0YmxO?=
 =?utf-8?B?eGZWVHZwaUo4MEJuRzI2ZjR0L0swbFdKaGhxM0hEL1N4cVBBM0J2eHRHeVRF?=
 =?utf-8?B?RE01bkZGM2hiWDdQQ0creWhncGMxTVRNSmNjWDlsTzFHMWI5dFp0Wk9ZVUJy?=
 =?utf-8?B?cnpPYXIvNmNUeU9BT2N5YXBPTXJMSGhRa2s3RTBZa2RCVUNOZytPMlNYWUVQ?=
 =?utf-8?B?QWNhZzJTSmVCS1FaM2RsU1pmZE1yaU9pVTJSQTl2QTM2L0l5cldsd29MYnl2?=
 =?utf-8?B?RnJOVHhhU0pzNlgyOTV5NmZFMXFBMnJkd0NEMGhQV3psYThIV2lqczJtcFRX?=
 =?utf-8?B?VndqTDFwOHdTZmVseUxtSXljalBINGJ4WjhmT0tiWkoraUtUeW5qUGpVZVh4?=
 =?utf-8?B?WTdZVjFMSGdqeFFOVm9SVVAwcEN0ZUpIL0p4YlBIdWIrbDMyUjF3d0ViOS8y?=
 =?utf-8?B?R2xmYzBBZHVMMFljZVFlaTF2bzgxMjJKOGJmQnhjMmpYVDJGSU1obWp5enRK?=
 =?utf-8?B?Q0RMZndPd1hWMDJNbTkwa1p1TlFmaUpVL2l2VnUzd3BxWjFPVmtUN1ZqaEdI?=
 =?utf-8?B?MkpHNWkrRXJwdytkTXFsSmswTHdzM0V3Ri9YcDQrd2Jnd3c4KzJ1TW5qS3c5?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f96a83-4c45-4e8d-efc8-08dafebdc792
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 10:20:27.6291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqX1cwkuFZ25h6odXzPuGeCZyMOTvCz3hAoNASIpky3QBFFac1BygqhaLrQ4n/VHnxIV10wogLmkimpyWiDoI5jauyR9aJn4peELdNw4OPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11709
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF1cmVudCBQ
aW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEphbnVhcnkgMTgsIDIwMjMgMTA6MDQgQU0NCj4gVG86IEhhbnMgVmVya3VpbCA8aHZl
cmt1aWxAeHM0YWxsLm5sPg0KPiBDYzogaXNoaWthd2EgeXVqaSjnn7Plt50g5oKg5Y+4IOKXi++8
su+8pO+8o+KWoe+8oe+8qe+8tO+8o+KXi++8pe+8oemWiykNCj4gPHl1amkyLmlzaGlrYXdhQHRv
c2hpYmEuY28uanA+OyBNYXVybyBDYXJ2YWxobyBDaGVoYWINCj4gPG1jaGVoYWJAa2VybmVsLm9y
Zz47IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj
77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBSb2IgSGVycmluZyA8
cm9iaCtkdEBrZXJuZWwub3JnPjsNCj4gS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnPjsgUmFmYWVsIEogLiBXeXNvY2tpDQo+IDxyYWZhZWwuai53
eXNvY2tpQGludGVsLmNvbT47IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGxp
bnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMvNl0gbWVkaWE6IHBsYXRmb3Jt
OiB2aXNjb250aTogQWRkIFRvc2hpYmEgVmlzY29udGkNCj4gVmlkZW8gSW5wdXQgSW50ZXJmYWNl
IGRyaXZlciB1c2VyIGludGVyYWNlDQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIFR1ZSwgSmFuIDE3
LCAyMDIzIGF0IDEyOjQ3OjEwUE0gKzAxMDAsIEhhbnMgVmVya3VpbCB3cm90ZToNCj4gPiBNb3Jl
IGNvbW1lbnRzIGJlbG93Og0KPiA+DQo+ID4gT24gMTEvMDEvMjAyMyAwMzoyNCwgWXVqaSBJc2hp
a2F3YSB3cm90ZToNCj4gPiA+IEFkZCBzdXBwb3J0IHRvIFZpZGVvIElucHV0IEludGVyZmFjZSBv
biBUb3NoaWJhIFZpc2NvbnRpIEFSTSBTb0NzLg0KPiA+ID4gVGhlIGludGVyZmFjZSBkZXZpY2Ug
aW5jbHVkZXMgQ1NJMiBSZWNlaXZlciwgZnJhbWUgZ3JhYmJlciwgdmlkZW8NCj4gPiA+IERNQUMg
YW5kIGltYWdlIHNpZ25hbCBwcm9jZXNzb3IuDQo+ID4gPiBUaGlzIHBhdGNoIHByb3ZpZGVzIHRo
ZSB1c2VyIGludGVyZmFjZSBsYXllci4NCj4gPiA+DQo+ID4gPiBBIGRyaXZlciBpbnN0YW5jZSBw
cm92aWRlcyB0aHJlZSAvZGV2L3ZpZGVvWCBkZXZpY2UgZmlsZXM7IG9uZSBmb3INCj4gPiA+IFJH
QiBpbWFnZSBjYXB0dXJlLCBhbm90aGVyIG9uZSBmb3Igb3B0aW9uYWwgUkdCIGNhcHR1cmUgd2l0
aA0KPiA+ID4gZGlmZmVyZW50IHBhcmFtZXRlcnMgYW5kIHRoZSBsYXN0IG9uZSBmb3IgUkFXIGNh
cHR1cmUuDQo+ID4gPg0KPiA+ID4gVGhyb3VnaCB0aGUgZGV2aWNlIGZpbGVzLCB0aGUgZHJpdmVy
IHByb3ZpZGVzIHN0cmVhbWluZyAoRE1BLUJVRikNCj4gaW50ZXJmYWNlLg0KPiA+ID4gQSB1c2Vy
bGFuZCBhcHBsaWNhdGlvbiBzaG91bGQgZmVlZCBETUEtQlVGIGluc3RhbmNlcyBmb3IgY2FwdHVy
ZSBidWZmZXJzLg0KPiA+ID4NCj4gPiA+IFRoZSBkcml2ZXIgaXMgYmFzZWQgb24gbWVkaWEgY29u
dHJvbGxlciBmcmFtZXdvcmsuDQo+ID4gPiBJdHMgb3BlcmF0aW9ucyBhcmUgcm91Z2hseSBtYXBw
ZWQgdG8gdHdvIHN1YmRyaXZlcnM7IG9uZSBmb3IgSVNQIGFuZA0KPiA+ID4gQ1NJMiByZWNlaXZl
ciAoeWllbGRzIDEgaW5zdGFuY2UpLCB0aGUgb3RoZXIgZm9yIGNhcHR1cmUgKHlpZWxkcyAzDQo+
ID4gPiBpbnN0YW5jZXMgZm9yIGVhY2ggY2FwdHVyZSBtb2RlKS4NCj4gPiA+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZdWppIElzaGlrYXdhIDx5dWppMi5pc2hpa2F3YUB0b3NoaWJhLmNvLmpwPg0K
PiA+ID4gLS0tDQo+ID4gPiBDaGFuZ2Vsb2cgdjI6DQo+ID4gPiAtIFJlc2VuZCB2MSBiZWNhdXNl
IGEgcGF0Y2ggZXhjZWVkcyBzaXplIGxpbWl0Lg0KPiA+ID4NCj4gPiA+IENoYW5nZWxvZyB2MzoN
Cj4gPiA+IC0gQWRhcHRlZCB0byBtZWRpYSBjb250cm9sIGZyYW1ld29yaw0KPiA+ID4gLSBJbnRy
b2R1Y2VkIElTUCBzdWJkZXZpY2UsIGNhcHR1cmUgZGV2aWNlDQo+ID4gPiAtIFJlbW92ZSBwcml2
YXRlIElPQ1RMcyBhbmQgYWRkIHZlbmRvciBzcGVjaWZpYyBWNEwyIGNvbnRyb2xzDQo+ID4gPiAt
IENoYW5nZSBmdW5jdGlvbiBuYW1lIGF2b2lkaW5nIGNhbWVsY2FzZSBhbmQgdXBwZXJjYXNlIGxl
dHRlcnMNCj4gPiA+DQo+ID4gPiBDaGFuZ2Vsb2cgdjQ6DQo+ID4gPiAtIFNwbGl0IHBhdGNoZXMg
YmVjYXVzZSB0aGUgdjMgcGF0Y2ggZXhjZWVkcyBzaXplIGxpbWl0DQo+ID4gPiAtIFN0b3AgdXNp
bmcgSUQgbnVtYmVyIHRvIGlkZW50aWZ5IGRyaXZlciBpbnN0YW5jZToNCj4gPiA+ICAgLSBVc2Ug
ZHluYW1pY2FsbHkgYWxsb2NhdGVkIHN0cnVjdHVyZSB0byBob2xkIEhXIHNwZWNpZmljIGNvbnRl
eHQsDQo+ID4gPiAgICAgaW5zdGVhZCBvZiBzdGF0aWMgb25lLg0KPiA+ID4gICAtIENhbGwgSFcg
bGF5ZXIgZnVuY3Rpb25zIHdpdGggdGhlIGNvbnRleHQgc3RydWN0dXJlIGluc3RlYWQgb2YgSUQN
Cj4gPiA+IG51bWJlcg0KPiA+ID4gLSBVc2UgcG1fcnVudGltZSB0byB0cmlnZ2VyIGluaXRpYWxp
emF0aW9uIG9mIEhXDQo+ID4gPiAgIGFsb25nIHdpdGggb3Blbi9jbG9zZSBvZiBkZXZpY2UgZmls
ZXMuDQo+ID4gPg0KPiA+ID4gQ2hhbmdlbG9nIHY1Og0KPiA+ID4gLSBGaXggY29kaW5nIHN0eWxl
IHByb2JsZW1zIGluIHZpaWYuYw0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS92aXNjb250aS9NYWtlZmlsZSAgICAgIHwgICAgMSArDQo+ID4gPiAgZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS92aXNjb250aS92aWlmLmMgICAgICAgIHwgIDU0NSArKysrKysrKw0KPiA+ID4g
IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vdmlzY29udGkvdmlpZi5oICAgICAgICB8ICAyMDMgKysr
DQo+ID4gPiAgLi4uL21lZGlhL3BsYXRmb3JtL3Zpc2NvbnRpL3ZpaWZfY2FwdHVyZS5jICAgIHwg
MTIwMQ0KPiArKysrKysrKysrKysrKysrKw0KPiA+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
dmlzY29udGkvdmlpZl9pc3AuYyAgICB8ICA4NDYgKysrKysrKysrKysrDQo+ID4gPiAgNSBmaWxl
cyBjaGFuZ2VkLCAyNzk2IGluc2VydGlvbnMoKykgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4g
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS92aXNjb250aS92aWlmLmMNCj4gPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS92aXNjb250aS92aWlmLmgNCj4gPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS92aXNjb250aS92aWlmX2Nh
cHR1cmUuYw0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L3Zpc2NvbnRpL3ZpaWZfaXNwLmMNCj4gDQo+IFtzbmlwXQ0KPiANCj4gPiA+ICtzdGF0aWMgaW50
IHZpaWZfc19lZGlkKHN0cnVjdCBmaWxlICpmaWxlLCB2b2lkICpmaCwgc3RydWN0DQo+ID4gPiAr
djRsMl9lZGlkICplZGlkKSB7DQo+ID4gPiArCXN0cnVjdCB2aWlmX2RldmljZSAqdmlpZl9kZXYg
PSB2aWRlb19kcnZkYXRhX3RvX2NhcGRldihmaWxlKS0+dmlpZl9kZXY7DQo+ID4gPiArCXN0cnVj
dCB2aWlmX3N1YmRldiAqdmlpZl9zZCA9IHZpaWZfZGV2LT5zZDsNCj4gPiA+ICsNCj4gPiA+ICsJ
cmV0dXJuIHY0bDJfc3ViZGV2X2NhbGwodmlpZl9zZC0+djRsMl9zZCwgcGFkLCBzZXRfZWRpZCwg
ZWRpZCk7IH0NCj4gPg0KPiA+IEhhcyB0aGlzIGRyaXZlciBiZWVuIHRlc3RlZCB3aXRoIGFuIEhE
TUkgcmVjZWl2ZXI/IElmIG5vdCwgdGhlbiBJDQo+ID4gd291bGQgcmVjb21tZW5kIGRyb3BwaW5n
IHN1cHBvcnQgZm9yIGl0IHVudGlsIHlvdSBhY3R1YWxseSBjYW4gdGVzdCB3aXRoIHN1Y2gNCj4g
aGFyZHdhcmUuDQo+ID4NCj4gPiBUaGUgRFZfVElNSU5HUyBBUEkgaXMgZm9yIEhETUkvRFZJL0Rp
c3BsYXlQb3J0IGV0Yy4gaW50ZXJmYWNlcywgaXQncw0KPiA+IG5vdCBtZWFudCBmb3IgQ1NJIGFu
ZCBzaW1pbGFyIGludGVyZmFjZXMuDQo+IA0KPiBNb3JlIHRoYW4gdGhhdCwgZm9yIE1DLWJhc2Vk
IGRyaXZlcnMsIHRoZSB2aWRlbyBub2RlIHNob3VsZCAqbmV2ZXIqIGZvcndhcmQNCj4gaW9jdGxz
IHRvIGEgY29ubmVjdGVkIHN1YmRldi4gVGhlICpvbmx5KiB2YWxpZCBjYWxscyB0bw0KPiB2NGwy
X3N1YmRldl9jYWxsKCkgaW4gdGhpcyBmaWxlIGFyZQ0KPiANCj4gLSB0byB2aWRlby5zX3N0cmVh
bSgpIGluIHRoZSBzdGFydCBhbmQgc3RvcCBzdHJlYW1pbmcgaGFuZGxlcg0KPiANCj4gLSB0byBw
YWQuZ19mbXQoKSB3aGVuIHN0YXJ0aW5nIHN0cmVhbWluZyB0byB2YWxpZGF0ZSB0aGF0IHRoZSBj
b25uZWN0ZWQNCj4gICBzdWJkZXYgb3V0cHV0cyBhIGZvcm1hdCBjb21wYXRpYmxlIHdpdGggdGhl
IGZvcm1hdCBzZXQgb24gdGhlIHZpZGVvDQo+ICAgY2FwdHVyZSBkZXZpY2UNCj4gDQo+IFRoYXQn
cyBpdCwgbm90aGluZyBlbHNlLCBhbGwgb3RoZXIgY2FsbHMgdG8gdjRsMl9zdWJkZXZfY2FsbCgp
IG11c3QgYmUgZHJvcHBlZCBmcm9tDQo+IHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgdmlkZW9f
ZGV2aWNlLg0KPiANCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnQuIEkgdW5kZXJzdGFuZCB0
aGUgcmVzdHJpY3Rpb24uDQpJJ2xsIHJlbW92ZSBmb2xsb3dpbmcgZnVuY3Rpb25zIGNvcnJlc3Bv
bmRpbmcgdG8gaW9jdGxzLg0KDQoqIHZpaWZfZW51bV9pbnB1dA0KKiB2aWlmX2dfc2VsZWN0aW9u
DQoqIHZpaWZfc19zZWxlY3Rpb24NCiogdmlpZl9kdl90aW1pbmdzX2NhcA0KKiB2aWlmX2VudW1f
ZHZfdGltaW5ncw0KKiB2aWlmX2dfZHZfdGltaW5ncw0KKiB2aWlmX3NfZHZfdGltaW5ncw0KKiB2
aWlmX3F1ZXJ5X2R2X3RpbWluZ3MNCiogdmlpZl9nX2VkaWQNCiogdmlpZl9zX2VkaWQNCiogdmlp
Zl9nX3Bhcm0NCiogdmlpZl9zX3Bhcm0NCiogdmlpZl9lbnVtX2ZyYW1lc2l6ZXMNCiogdmlpZl9l
bnVtX2ZyYW1laW50ZXJ2YWxzDQoNCkkgY2FuIGNhbGwgc3ViZGV2aWNlcyBkaXJlY3RseSBpZiBJ
IG5lZWQuIElzIGl0IGEgY29ycmVjdCB1bmRlcnN0YW5kaW5nPw0KDQpBcyBmb3IgdmlpZl90cnlf
Zm10X3ZpZF9jYXAgYW5kIHZpaWZfc19mbXRfdmlkX2NhcCwgDQpJJ2xsIHJlbW92ZSBwYWQuZ19m
bXQoKSBjYWxsIHdoaWNoIGlzIGZvciBjaGVja2luZyBwaXhlbCBmb3JtYXQuDQpUaGUgY2hlY2sg
d2lsbCBiZSBtb3ZlZCB0byB2aWlmX2NhcHR1cmVfbGlua192YWxpZGF0ZSgpIHZhbGlkYXRpb24g
cm91dGluZSB0cmlnZ2VyZWQgYnkgYSBzdGFydCBzdHJlYW1pbmcgZXZlbnQuDQoNCj4gW3NuaXBd
DQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiANCj4gTGF1cmVudCBQaW5jaGFydA0KDQpSZWdhcmRz
LA0KWXVqaSBJc2hpa2F3YQ0K

