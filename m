Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACBA6651B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbjAKCVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjAKCVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:21:33 -0500
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65F983;
        Tue, 10 Jan 2023 18:21:31 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 30B2L4Xi016691; Wed, 11 Jan 2023 11:21:04 +0900
X-Iguazu-Qid: 34tMMX4C9vAtHHcj3V
X-Iguazu-QSIG: v=2; s=0; t=1673403663; q=34tMMX4C9vAtHHcj3V; m=SL9SHT9R1SDW/QuB95lT4RU8fYEi4UwATMQ3yLKws28=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 30B2L1RK009842
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Jan 2023 11:21:01 +0900
X-SA-MID: 52825087
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0UB3vfqolAoQegByzk4SS1oTaPqQLzhLueoe6J3NGmSFvnhTELWAOxp7QhWKzlvnQkg6KAYipPdOaWjDr5/m2uj/IvwwHTAeUZBfZrF7A+4elVU94wMq3a1DHf789ohCtz+ym/kOx0GXh/9nKPuTWwABC8F8Nh9Nv3NjmqtizfFKq8HRiEUBGHDHOvqpQwVxL1GrFh3kmNRxECewfpm50ye+Z9bn1wuNGJTir2zQCKcpc5VMqylh66ztAqUUPXpm4xR1B4GAl4QWdbVRkT8PVi8XahP17i6/j4yupevd5qSNIKpXxo1Ej931R0t13F/48Gdogxxl7GwhnQG0jdB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cNuhmJxh+ugGXqSa6UvAumsK679rnmBZRivRGQxIWM=;
 b=nnDaFYj2zKn3j0nCoVYFoJ1SzFigUh1PhucqSJxvrO6qYbotg6okjR/QIGM1W1S4RqkmWyT/UXULACxUGjmLyPbgEGOcHrfRYBMiS0syTTTNmAVCvq52OZJLHmhzTSj8AvuLcrzZDq1BI2Paho4McQwmbxZ5Uo0yzqD3xqFFlq6bwT1HTexNugeb1qbNcI6WN9UU9kMZWZ+jNT1b1t8NX64Eg5Yk0vmudbBl+BY248WmGG1/1o5PAOXdIOE5lL58k6V9yt6W6DvoKOSP5aVvm5T/MHZOsIajinEsVYgZ9mb94xiSt5fMJ1a3/y/S7Q7bPqkRtL/0/0W5HwhsBB53/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <krzk@kernel.org>, <hverkuil@xs4all.nl>,
        <laurent.pinchart@ideasonboard.com>, <mchehab@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Topic: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Index: AQHZJJTAFXt/zFsv/k+G9pe5B8zila6YCwmAgABwjtA=
Date:   Wed, 11 Jan 2023 02:19:17 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201932EC0EAB58C4228CD4292FC9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
 <20230110014143.18684-2-yuji2.ishikawa@toshiba.co.jp>
 <b0245b64-a3eb-a242-8824-9effe0c63f0e@kernel.org>
In-Reply-To: <b0245b64-a3eb-a242-8824-9effe0c63f0e@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|OS3PR01MB8195:EE_
x-ms-office365-filtering-correlation-id: dbbdd49d-4da0-4b80-5710-08daf37a3ddb
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QorZ4/UDtrW8IfusX0a3S+16wgJfoaNPfvL4qAMUsW5DR+efxVuI9mdIACu/P+W9H6eVIzwABIl7DQZRSDbpjgqNbwVU7QgmoAaz8YyJKbbE3NGnsaHgoQN0wqxC8CWTz++Pxqli1WHIbTaW+rEieH5mgmEyH4D9XrftTjti2reogNhwwJgfvLIsotCorYvQkg5hbz/CtxMKijkE9WUWP3jpHgQaryK7uRxvSUFW4/wdxwIhMWh379oPI8HOMvnggbgDQOjcPIwp2CtkjJyMKnSOlfJh9XfL7t/FgOAYPDm5Np7LtE/dAsOKYb8Dy13ZPHFlLWgHG9Y6ahcZeElODh7O4SNgJ1VEk5Q5VHDupFpxx8QLX0U1q4YVpOQMGUS8Jff269G1kJSFvhRLr4gOhqEcyPI6ZbKQEpxbh+5865SwuDTqXwoD2AxpLZ9PYrV5ALfc7b8TwxQBnP+JuJm4COf9gOdJuqWT6F2aj05iJpFfvXHd3W6r4Flg7GWkmthZcmmsyXsGN73cBfanmakA+d8oeoEPfnkmuPFez8d6Ru/KE6sg+n9jnw14pOI2dUffeCtUGcL9ovQWLknSSpOhrEFcIFefxftP7YLxydY01T+A6R5tjuhJuQ22kRDRdpWdlgwrBe7LJ2V9IRy55m3eQuoultrHufk1O5021VqI53BoPUKjf6JnRPSsCSjyCA/RE44CYr+VXIOZvb2dow9j7A+aDxQEJmvOHWauEMPtgcA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(41300700001)(8936002)(52536014)(26005)(186003)(33656002)(5660300002)(53546011)(9686003)(6506007)(83380400001)(38070700005)(316002)(110136005)(54906003)(66476007)(8676002)(66446008)(4326008)(64756008)(86362001)(76116006)(66946007)(66556008)(122000001)(55016003)(71200400001)(966005)(7696005)(6636002)(38100700002)(478600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2lMckNtd2dzU0V1Qm50WS9YZ2xudllkcjBNc3dPRFRjelNHTEcrcGRzL0Y2?=
 =?utf-8?B?OGh4a3R1SHowamcxbHVPVTMzOEdyNkVqT01JYUErSmVwY1ZHOXNia2pEN2Rw?=
 =?utf-8?B?Q2h2YWhwODljZkxvMjJxOE9YMU90TUJWUHUrejQ1Z21SeTBEYzV3V0dXOGtk?=
 =?utf-8?B?Vk5oSngwdU1xS2hja2ltWUN5RHFjQ3lrV0pJVURvTUdLMXZxVzNUeDNkc2FO?=
 =?utf-8?B?ZDkvbGZXR2lGSjVQYklJQjVMY29laHhRYTJIT2hJRFV4UENaQjVkSE5aQ0FW?=
 =?utf-8?B?aHd3aXRpNVpVTnlxQklHVnMxL0Zmamx2enFGUUtMMGg5Q3l2b2V0aHhGRm1F?=
 =?utf-8?B?WCtkVlFacXRhdjlNTVhCNnV6VitDZDhHM2NIaEFsZXRvL1ArYzVWZU5CK0ZS?=
 =?utf-8?B?VFJPVDlFTzhIb3NtOFB3RG85UVovMVpLVWExdnVJV1JhUFE4aEgzS1dST1dD?=
 =?utf-8?B?Q2cwQmFhRmxtZzFucDVFQkFJNERVNGE1eklxdG1CaVl6UTNDQ2dQZ1BoanQw?=
 =?utf-8?B?ZktucHVXOUdQb1h6Rkc3NFFHWXdWdHNGWStUN3llUlQvOHl1SnFvTFZlK3k4?=
 =?utf-8?B?YUUveFFuV3Q0VDdHNisvUE5pcEJIaTMwWlQyb1Q0RnhGTGI4d1Uyckc1M2Jo?=
 =?utf-8?B?YVhCa3FPbmxLTVhqMDVBditsU0p0cVN5TlFaRDhnTU5Ob0xOQzllbVBjVzNx?=
 =?utf-8?B?SVM4ZnFBeGpwYVZ5YjVRUk1ObTU2V3pXeEMrbkc0cXVGWTZ1MkRrNHVUeHd5?=
 =?utf-8?B?SldNU2dHN2xiVzdXckZ2ZG9JVDRVZ1R2dGEvZE1Kdm5IRG9XSUtTeTVQeksx?=
 =?utf-8?B?MlA4T1JoenlKUExjUDBrNVd1cjJCUENEM1R4WkVWYlFmd0h6c3l5eXlYdmZU?=
 =?utf-8?B?YnVwc2Y4QWlBbXg1Z3kwb21VUGI5RDZlbHFLdE1tY0czNVppR3Y2UFQ2em43?=
 =?utf-8?B?YXdvNXhkVVFaWDFMS3pkekdxMWdmenBTcGNUZE1UY092K3NEUXNlMjJsMlYr?=
 =?utf-8?B?VU85M256ZFpGR3p2RkVRWlp6Q1dqRkIvRVdYczJBUThDOEhXaE5GM1hHaFh0?=
 =?utf-8?B?MGJwWkJOL3N2U1NjODFhcnc4a0dGb1lNc2J6S2VlVEQ4V09OQTVzQ2pTYVRK?=
 =?utf-8?B?Z3o3VXZ4MGtja3plNytQTWdUYkkyQjdFZWtNdVBsYlQ2RzY0bzUzdGEvYktv?=
 =?utf-8?B?NFFPT3l0KzZFNUk5bEcvOEhaeFFWMjJxM1pEUDl0NFlKT1ZVZVRvZFhFcHo0?=
 =?utf-8?B?WGdubFZiZXp2amNhVElZWXlBUjY5REgvM1kxdTV6TXltZy95V1JDWHduNUVN?=
 =?utf-8?B?NWxiOUpNQUMyR1A0Q1FLdG9iUExURHhBa3NHOEtRK1E2NFZMc0hOeGdtS0tO?=
 =?utf-8?B?bWZ1ZWhVQjE3emZrZWx4cHRSeW90R0VKSXpLVDJhUCtYK0VNMjI0K3gxZmQy?=
 =?utf-8?B?am9rL3gzZEVlMEhvbnVnRWkvNmpTaXZNdkFFY042NlpMNUpZQ3FxcEp4NXZi?=
 =?utf-8?B?MllUWm1idElYblE4VTVQSmV6MytjejJ4WDhCOGlBTHIzUUpXaFpUMWtxVDJX?=
 =?utf-8?B?b25kTGM0NXQvNXJHYWdvNHY1NjhCZ29pajB6VWFKNjVTL3ZyWEN4bk4rZWVj?=
 =?utf-8?B?N2x3Ynd5QWR2d2ExQSt1N3gxWFVnanBaMzhwblZ2Nm0xZTZsUzdDdXpVb2lL?=
 =?utf-8?B?OXVpZnhEdEN4TnRlV0ZaZ2xHRnVYdHVNY0luTXZsckdXcHFPa3lNeGJHYUZm?=
 =?utf-8?B?Z1pobjVuL2drbnArZU1qOWhOa25OZnVWclo5Rk1uTGFoM3Z2c0JWQmo0RU0v?=
 =?utf-8?B?dndyYkRYdGJZUWZBMmhKOVhiUUJMWW5oYVNLN0RLRVlVSW44U215NDdoNU5Q?=
 =?utf-8?B?UitZNy91SXhMMVgxZGRrUGN6RU5hRHpUTTFNNzEvU0VBbzU2U1dWRFo0cU1I?=
 =?utf-8?B?QmJxRHBRTGlmSDk5WDhLOGVpQ2FMZGJzT1N3bUNUYjdsWjAvbjdzN0hPRlJF?=
 =?utf-8?B?cWdIV1lGQUFORmtDTUNTZWJuN2s4VUY1bHF4d29aY3V1aDdyMjVSY2xFZjNo?=
 =?utf-8?B?eWdkNHJPVmJqQjNWYlhRWGw1bFFxVGxVbTVTeEtGdDZualYzTlZCckNwcSsy?=
 =?utf-8?B?TGE0WXk2V1ZKOTJta2t4clU1djcwWkdaZ0wxbEhKRFg0cWZmQmpOam5XVStL?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbdd49d-4da0-4b80-5710-08daf37a3ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 02:19:17.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8ojg18Z+N6YXGvzwqvAG8eWU9g+8a4rhNgHcKoAidHW23Uwy7ysiE/d+9E1zUYLOgc0LMPLcCrOULrzjWqDs5b5UOt6ifTJmfWCp04J1MI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8195
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5
LCBKYW51YXJ5IDExLCAyMDIzIDQ6MzEgQU0NCj4gVG86IGlzaGlrYXdhIHl1amko55+z5bedIOaC
oOWPuCDil4vvvLLvvKTvvKPilqHvvKHvvKnvvLTvvKPil4vvvKXvvKHplospDQo+IDx5dWppMi5p
c2hpa2F3YUB0b3NoaWJhLmNvLmpwPjsgSGFucyBWZXJrdWlsIDxodmVya3VpbEB4czRhbGwubmw+
OyBMYXVyZW50DQo+IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+
OyBNYXVybyBDYXJ2YWxobyBDaGVoYWINCj4gPG1jaGVoYWJAa2VybmVsLm9yZz47IGl3YW1hdHN1
IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KQ0KPiA8bm9i
dWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IENjOiBsaW51eC1tZWRpYUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NCAxLzZdIGR0LWJpbmRpbmdzOiBtZWRpYTogcGxhdGZvcm06IHZp
c2NvbnRpOiBBZGQgVG9zaGliYQ0KPiBWaXNjb250aSBWaWRlbyBJbnB1dCBJbnRlcmZhY2UgYmlu
ZGluZ3MNCj4gDQo+IE9uIDEwLzAxLzIwMjMgMDI6NDEsIFl1amkgSXNoaWthd2Egd3JvdGU6DQo+
ID4gQWRkcyB0aGUgRGV2aWNlIFRyZWUgYmluZGluZyBkb2N1bWVudGF0aW9uIHRoYXQgYWxsb3dz
IHRvIGRlc2NyaWJlIHRoZQ0KPiA+IFZpZGVvIElucHV0IEludGVyZmFjZSBmb3VuZCBpbiBUb3No
aWJhIFZpc2NvbnRpIFNvQ3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdWppIElzaGlrYXdh
IDx5dWppMi5pc2hpa2F3YUB0b3NoaWJhLmNvLmpwPg0KPiA+IFJldmlld2VkLWJ5OiBOb2J1aGly
byBJd2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IA0KPiBQbGVh
c2UgdXNlIHNjcmlwdHMvZ2V0X21haW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2YgbmVjZXNz
YXJ5IHBlb3BsZSBhbmQgbGlzdHMNCj4gdG8gQ0MuICBJdCBtaWdodCBoYXBwZW4sIHRoYXQgY29t
bWFuZCB3aGVuIHJ1biBvbiBhbiBvbGRlciBrZXJuZWwsIGdpdmVzIHlvdQ0KPiBvdXRkYXRlZCBl
bnRyaWVzLiAgVGhlcmVmb3JlIHBsZWFzZSBiZSBzdXJlIHlvdSBiYXNlIHlvdXIgcGF0Y2hlcyBv
biByZWNlbnQNCj4gTGludXgga2VybmVsLg0KPiANCj4gWW91IG1pc3NlZCBmZXcgb2YgdGhlbSwg
c28gY2xlYXJseSB0aGlzIHdhcyBub3Qgc2VudCBjb3JyZWN0bHkuDQo+IA0KPiANCj4gU3ViamVj
dDogZHJvcCBzZWNvbmQvbGFzdCwgcmVkdW5kYW50ICJiaW5kaW5ncyIuIFRoZSAiZHQtYmluZGlu
Z3MiDQo+IHByZWZpeCBpcyBhbHJlYWR5IHN0YXRpbmcgdGhhdCB0aGVzZSBhcmUgYmluZGluZ3Mu
DQoNClRoYW5rcyBmb3IgcmVwb3J0aW5nLiBUaGUgcmVjaXBpZW50IHdhcyBnZW5lcmF0ZWQgd2l0
aCBhbiBvbGRlciBrZXJuZWwuDQpJJ2xsIHVwZGF0ZSB0aGUgbGlzdCBhbmQgc2VuZCB0aGUgdjUg
cGF0Y2guDQoNCj4gPiAtLS0NCj4gPiBDaGFuZ2Vsb2cgdjI6DQo+ID4gLSBubyBjaGFuZ2UNCj4g
Pg0KPiA+IENoYW5nZWxvZyB2MzoNCj4gPiAtIG5vIGNoYW5nZQ0KPiA+DQo+ID4gQ2hhbmdlbG9n
IHY0Og0KPiA+IC0gZml4IHN0eWxlIHByb2JsZW1zIGF0IHRoZSB2MyBwYXRjaA0KPiA+IC0gcmVt
b3ZlICJpbmRleCIgbWVtYmVyDQo+ID4gLSB1cGRhdGUgZXhhbXBsZQ0KPiA+IC0tLQ0KPiA+ICAu
Li4vYmluZGluZ3MvbWVkaWEvdG9zaGliYSx2aXNjb250aS12aWlmLnlhbWwgfCA5OA0KPiA+ICsr
KysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDk4IGluc2VydGlvbnMoKykN
Cj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21lZGlhL3Rvc2hpYmEsdmlzY29udGktdmlpZi55YW1sDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvdG9zaGli
YSx2aXNjb250aS12aWlmLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZWRpYS90b3NoaWJhLHZpc2NvbnRpLXZpaWYueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAuLjcxNDQyNzI0ZDFhDQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS90
b3NoaWJhLHZpc2NvbnRpLXZpaWYueWENCj4gPiArKysgbWwNCj4gPiBAQCAtMCwwICsxLDk4IEBA
DQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTIt
Q2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUu
b3JnL3NjaGVtYXMvbWVkaWEvdG9zaGliYSx2aXNjb250aS12aWlmLnlhbWwjDQo+ID4gKyRzY2hl
bWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsN
Cj4gPiArdGl0bGU6IFRvc2hpYmEgVmlzY29udGk1IFNvQyBWaWRlbyBJbnB1dCBJbnRlcmZhY2Ug
RGV2aWNlIFRyZWUNCj4gPiArQmluZGluZ3MNCj4gDQo+IERyb3AgIkRldmljZSBUcmVlIEJpbmRp
bmdzIg0KPiANCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gTm9idWhpcm8gSXdh
bWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiA+ICsNCj4gPiArZGVz
Y3JpcHRpb246DQo+ID4gKyAgVG9zaGliYSBWaXNjb250aTUgU29DIFZpZGVvIElucHV0IEludGVy
ZmFjZSAoVklJRikNCj4gPiArICByZWNlaXZlcyBNSVBJIENTSTIgdmlkZW8gc3RyZWFtLA0KPiA+
ICsgIHByb2Nlc3NlcyB0aGUgc3RyZWFtIHdpdGggZW1iZWRkZWQgaW1hZ2Ugc2lnbmFsIHByb2Nl
c3NvciAoTDFJU1AsDQo+ID4gK0wySVNQKSwNCj4gPiArICB0aGVuIHN0b3JlcyBwaWN0dXJlcyB0
byBtYWluIG1lbW9yeS4NCj4gDQo+IEZpeCB3cmFwcGluZy4NCj4gDQo+ID4gKw0KPiA+ICtwcm9w
ZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBjb25zdDogdG9zaGliYSx2aXNj
b250aS12aWlmDQo+IA0KPiBDb21wYXRpYmxlIG11c3QgYmUgc3BlY2lmaWMuIFlvdSBjYWxsZWQg
eW91ciBTb0MgdmlzY29udGk1LCBkaWRuJ3QgeW91Pw0KPiANCj4gPiArDQo+ID4gKyAgcmVnOg0K
PiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IHJlZ2lzdGVycyBmb3Ig
Y2FwdHVyZSBjb250cm9sDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IHJlZ2lzdGVycyBmb3Ig
Q1NJMiByZWNlaXZlciBjb250cm9sDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAg
ICBpdGVtczoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogU3luYyBJbnRlcnJ1cHQNCj4gPiAr
ICAgICAgLSBkZXNjcmlwdGlvbjogU3RhdHVzIChFcnJvcikgSW50ZXJydXB0DQo+ID4gKyAgICAg
IC0gZGVzY3JpcHRpb246IENTSTIgUmVjZWl2ZXIgSW50ZXJydXB0DQo+ID4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IEwxSVNQIEludGVycnVwdA0KPiA+ICsNCj4gDQo+IA0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg0KUmVnYXJkcywNCll1amkNCg==

