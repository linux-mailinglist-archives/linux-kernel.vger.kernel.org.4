Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D05963DA50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiK3QNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiK3QNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:13:45 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azolkn19010002.outbound.protection.outlook.com [52.103.10.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234D850D41
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:13:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFuf6IAa6WlAvtRn1/P9yyKBKjJLafCqUf4FwD6B2J82/ayqnNRTOTpkfSAhNu7nszjuIQUzpR/B9dUvlCnw0Z1oiQW1yXEQ9lefjhx0BDau6u/nrKhoeujP5T0iWJQ2kijARfsPZlWEBy8WkJ2FJMucrRqnySS47OgOKK8kI2FQ0E3GXMdYPUjZMACElZTAbQbGJJClWqnZDWa+h5JE+i7g+VAzuL31JrucJw5/LrfuY30ULhempJp19AD+SH2p4T4mQH+nYiaLHe4rOcbe1KMQIJQuD3HseKF8IX4ivbAAsiuFM18Owul+H04MnsB+KLRg8p3nddFtcZa84y1hHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPKtceQEkvgP9Zy4ewLLPZNpzlgexH8YfKfiXq7TJTo=;
 b=O+p62O6tKy/i0vUB8T66saChS767fRtVd+K3UQB/FJ4EoUnf99XfZtjRkHgC9FIGRBXCOqS/orvfE+rxA+41eTHR2VNcTxOE0G6htUw6LxgNhZ0J5EmuxkDY2wQ1pAK8GimmjKQXmbzpwI5+E/dZa8Oso+Nwd9AJ8K+LUdqp3vu51KbR5XmJLFjR2W5cwfux7YGyWZSkuScVKgtEywlwp9LnKpZ+4TBsJhODD5pcyGLo/EsSMW8etgR/7kNSJMfTrv4dlOZbgJKNnAlZZGyT+vsXoQxEn94CZ9f0DhtJdxsada8/QKVTH0Dg7LoQOFrhknGLPutVycwlZaEUDOgN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DS0PR05MB9544.namprd05.prod.outlook.com (2603:10b6:8:11f::15)
 by DM5PR05MB3273.namprd05.prod.outlook.com (2603:10b6:3:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Wed, 30 Nov
 2022 16:13:41 +0000
Received: from DS0PR05MB9544.namprd05.prod.outlook.com
 ([fe80::33e4:cb6f:e54a:778f]) by DS0PR05MB9544.namprd05.prod.outlook.com
 ([fe80::33e4:cb6f:e54a:778f%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 16:13:41 +0000
From:   Soha Jin <soha@lohu.info>
To:     Soha Jin <soha@lohu.info>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH driver-core-next] platform: remove useless if-branch in
 __platform_get_irq_byname()
Thread-Topic: [PATCH driver-core-next] platform: remove useless if-branch in
 __platform_get_irq_byname()
Thread-Index: AQGNOzpBNLe6pR+Hdv3rzYKtKpIDNK7vNeIg
Sender: Soha Jin <soha@live.cn>
Date:   Wed, 30 Nov 2022 16:13:41 +0000
Message-ID: <DS0PR05MB95443EF90A23C41D4700F03ADA159@DS0PR05MB9544.namprd05.prod.outlook.com>
References: <20221111094542.270540-1-soha@lohu.info>
In-Reply-To: <20221111094542.270540-1-soha@lohu.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 2
x-tmn:  [zzHc37Pfq3Bjh2u2+O550yfBeyqTAOipOea8fM43QdcokCnQH3EavyOzeSngjww4]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR05MB9544:EE_|DM5PR05MB3273:EE_
x-ms-office365-filtering-correlation-id: ead66a53-c8be-4648-6ae2-08dad2edd926
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywiZFG/5Dlj1ENgP0tCpe2usGBDXSAB6gEpfWm42fcPtAoin0V5JVL1voTi9SZckTuLdQbBWEAihos6Tte+ll0PuPOKtTxzXWijL2EHxLA3RDFYOHhcTSc27KZV+m0G+rK+H7DOSLfC9BRV2f5ClTZlnAaILx1w2A434kqxoW+mRPQREqxdq7RSWeUaxZyt9e59DzjqKSZ56zhFIHb3X0bTuBfs7Oxc0UBInOmoEu5g4z277lM7B2i8O01RoumdB6HwsDWpnG7cT28rgRibhKTOyx2R7FUPJXniE6/5+ET6QX7DPG9ItZnQ3VDaFE6SXa6qIMxJGUbCMj6EoyczMt444XHe+LCUHuDls9NbmLwXlfZxPKfUXe4KTMlqzphllGHuG4Zd4aS0MxKf6thXEfx95hqCQEgjdKR/H6/euVT38x0u93ScFFYrlTTsZuDmt326GB9Fa2R2AzKibd7CuNErPYuasKkDe3Oyi0qleruTi9q6rcRm/ZeVY6WIfg8/nyZP6TyTXColK7GSs1PJOFz52+iPWZZ39/ObNaBPjG91cHgRGUlyKbn8sTvPdSxCsWLnu8U88xFPTKsB8Ov+E1MPcWtCf5euqK7C3CjANezhzxYt0oHeihUkpP9cilVYRptQdJFJIGA0nPDGOiQjJAJGGmxiWikAWWkAdwR9qBAGoB1gFdoE/8LLOQgHzng0d
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHZyd3IvTll5QjVDRkM5Ym1HRHVWcFNHOFY0SWt0MTF2a2ltdTByRG94L3JR?=
 =?utf-8?B?Uy9GeFlIamhveUJGQ1poeUhRS3lQWDFIQ3UrTXRMVnArQzVoRVR0RHkxSjVu?=
 =?utf-8?B?YjFpdysvTTRaTW1BMVY4VjN2aXllVFNzNmY4amN0UmN2QXd6MXM0eDBPa2J6?=
 =?utf-8?B?OHFzWUxWVkJCRUdwOE1aUXp0bFl0elhiMUJYNC8yYWEvZ2ZzQSsyclJOWGRz?=
 =?utf-8?B?N1U5VjBqYjBIR0IxcnRmWEIyZkgxYW51QmM2VnhGdDRoZVgyN3VLZ0FtYVFj?=
 =?utf-8?B?K002RURnNi9OaytCUlF1QjFrcExHRmZhakxNaXFYdSsyNWVOc1g1ZUhDTldj?=
 =?utf-8?B?aWxMb3NpRHVGU2l3WlV4cGFaSUV5NCtsdzFpMlk1ZE5KNkRvMnVNeHZGWHll?=
 =?utf-8?B?aCtUSCs0Vllkb3hZRkErVGpNZmJUM1pWY3B3eWo5Sms2cUdDbkV1MmRWK1JD?=
 =?utf-8?B?TGNOdEdTZ0FkNXpKRHA4UEtXRDJXZjlkUGFIcjVsUFU5L2RPbDJzZVdmeUw0?=
 =?utf-8?B?MWMwZ0I3UU85OGNuY28yVzIzeFJDUXpQTEZlMDc2NG50cUU4UXJLZjZiaExm?=
 =?utf-8?B?UW1nL0dDbE5IdTlBZmFiSjlQRnE4N3lTVTVYZ2hlbHhPRlBwQyswNFRxOHNH?=
 =?utf-8?B?SFVtc0ZEMC9vcElhdncxVk1ZN1dMbXNWTTZXcldjb25GWUJZN2Zja3hvdER5?=
 =?utf-8?B?eXV6eFc5b0tQbHhwZlFUc0FPa3pHYUFyekJLV3hyc3NUNXlKdk81ekd4aXJU?=
 =?utf-8?B?Z0Y3S2w1SUFUVldCT2JVejFIQkVZcnprOTZldG1WS2ZwdUNiTCtKSmFPTnRq?=
 =?utf-8?B?YjQrY1pxOXhXMVI2ZjIxcjVKQ2J3ZDlaQzFoc2dVQStkTE5OZUFrTjhmcHRa?=
 =?utf-8?B?WmN0ZXYwTzBGbDBwZ0o1Q3MvSVBwV1QzZldPRHBjT2RrdU04RGtwSU5kdWIw?=
 =?utf-8?B?cUZ5ci9nUjNweGwyVU1GdXAvY2Z4cmt5VTcxY05iendLOUtiYi80dGJuYjZ6?=
 =?utf-8?B?Z3U3L3pQRWo2dEQyUFNMZG5kMndvUVpIZ21ZekxZZFVoSzdSRDlNckRnQURs?=
 =?utf-8?B?S1hlNjVYb3ZZKzhCL3diVXZyYUd3bU5NRVhuQXZZTngySlc3bG1NWG5PZ3ZX?=
 =?utf-8?B?aEdTaGZMQ1FWRGJodEM4RnhqUzFHYmFTYzRuSnlzVWR4eUVZSFVLMkZYNi8x?=
 =?utf-8?B?NWhyVFdVNWVEcmtJNEQvc3p2OW1HNmZZZjNQMkMzU09ySlNvMEpMYWVkUXNv?=
 =?utf-8?B?b3JBNk04bmdUT2R0YUlZTzZaQUdBaFdONUlhZHFMY05SWHlFU1pTQnVzQm14?=
 =?utf-8?B?dFNGUlo4K0R2WWxlQSt6SnlMUkdMcEFoUm5QaWFVNlNLTlRXY3dsazdFeUFu?=
 =?utf-8?B?L25nUU1MUXIyVTg1eHJ6SnBjQlZaaVZWNkt3azdqWmlwSDhYRG8yb3hlRWFq?=
 =?utf-8?B?Z2M2ZTI1VExDVGxKZ3h6UU4zQi9WMnBLSTdYTENIQVBsZlpJdG0rNGljckJz?=
 =?utf-8?B?bFo5TnJCTmNuV0hGOEdDSWxBT2dOTG9vWExSeVBiTjZCNHVZL3ZvNHZ0K2tE?=
 =?utf-8?B?Q3JOZGJGRUw3Qm5Fa0pud1Y2aU9VRTNtN3pXdUYvZ29rR0grSlJpODFvU2Z3?=
 =?utf-8?B?c1A0WU10b09ZTnl3a2NVbUhkWitrRFphYUg4Y0s4dGNFd0ZXdTk2UG9QNkRL?=
 =?utf-8?B?RnJrWVMyY0xBdkZIQ042OHV1M1E5R0xmT00wUVRzZGdRWjROc0N5eGN5WWho?=
 =?utf-8?Q?qvsQjD54ye/nkA/Zng=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR05MB9544.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ead66a53-c8be-4648-6ae2-08dad2edd926
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 16:13:41.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3273
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTb2hhIEppbiA8c29oYUBsb2h1
LmluZm8+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTEsIDIwMjIgNTo0NiBQTQ0KPiANCj4g
V2hlbiBDT05GSUdfT0ZfSVJRIGlzIG5vdCBlbmFibGVkLCB0aGVyZSB3aWxsIGJlIGEgc3R1YiBt
ZXRob2QgdGhhdCBhbHdheXMNCj4gcmV0dXJucyAwIHdoZW4gZ2V0dGluZyBJUlEuIFRodXMsIHRo
ZSBpZi1icmFuY2ggY2FuIGJlIHJlbW92ZWQgc2FmZWx5Lg0KPiANCj4gRml4ZXM6IGQ0YWQwMTdk
NjM0NSAoInBsYXRmb3JtOiB1c2UgZndub2RlX2lycV9nZXRfYnluYW1lIGluc3RlYWQgb2YNCj4g
b2ZfaXJxX2dldF9ieW5hbWUgdG8gZ2V0IGlycSIpDQo+IFNpZ25lZC1vZmYtYnk6IFNvaGEgSmlu
IDxzb2hhQGxvaHUuaW5mbz4NCj4gLS0tDQo+ICBkcml2ZXJzL2Jhc2UvcGxhdGZvcm0uYyB8IDgg
KysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL3BsYXRmb3JtLmMgYi9kcml2ZXJz
L2Jhc2UvcGxhdGZvcm0uYyBpbmRleA0KPiA5NjhmM2Q3MWVlYWIuLjZjZDdmZDQ3OGM1ZiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9iYXNlL3BsYXRmb3JtLmMNCj4gKysrIGIvZHJpdmVycy9iYXNl
L3BsYXRmb3JtLmMNCj4gQEAgLTQ0MSwxMSArNDQxLDkgQEAgc3RhdGljIGludCBfX3BsYXRmb3Jt
X2dldF9pcnFfYnluYW1lKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKmRldiwNCj4gIAlzdHJ1
Y3QgcmVzb3VyY2UgKnI7DQo+ICAJaW50IHJldDsNCj4gDQo+IC0JaWYgKCFkZXYtPmRldi5vZl9u
b2RlIHx8IElTX0VOQUJMRUQoQ09ORklHX09GX0lSUSkpIHsNCj4gLQkJcmV0ID0gZndub2RlX2ly
cV9nZXRfYnluYW1lKGRldl9md25vZGUoJmRldi0+ZGV2KSwgbmFtZSk7DQo+IC0JCWlmIChyZXQg
PiAwIHx8IHJldCA9PSAtRVBST0JFX0RFRkVSKQ0KPiAtCQkJcmV0dXJuIHJldDsNCj4gLQl9DQo+
ICsJcmV0ID0gZndub2RlX2lycV9nZXRfYnluYW1lKGRldl9md25vZGUoJmRldi0+ZGV2KSwgbmFt
ZSk7DQo+ICsJaWYgKHJldCA+IDAgfHwgcmV0ID09IC1FUFJPQkVfREVGRVIpDQo+ICsJCXJldHVy
biByZXQ7DQo+IA0KPiAgCXIgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKGRldiwgSU9S
RVNPVVJDRV9JUlEsIG5hbWUpOw0KPiAgCWlmIChyKSB7DQo+IC0tDQo+IDIuMzAuMg0KPiANCg0K
UElORy4NCg0KUmVnYXJkcywNClNvaGENCg==
