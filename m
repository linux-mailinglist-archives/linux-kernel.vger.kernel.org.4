Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8733693622
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 06:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBLFQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 00:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBLFQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 00:16:34 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2068.outbound.protection.outlook.com [40.92.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37313DCF;
        Sat, 11 Feb 2023 21:16:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDqD+mmSS9J5iSHHmcGWHyRWYS32e3N3cyo04cIm7tMfJB3NBxRT9IDK7a5RDcH47lMHqeYerxpIgR+alAavmdKI3mH01UKCf74KsT0ou5dNY7vsyrc2vFZHPSQaJtN69Rz/AGYnh+wc1AbiyYDAaDaZy6cyrjeTc3r/JsP7dPKCqES5JnOex97vswbbync1iufOPAwVXrFppHTStR8TKp4DwVX4L/wH4aPZ/LaSPDMQyFpJn9BR3s40fd/F+snmg4FhfEvoU6pYNUI1e0gMtwVPzasMNvvq/kIv0UM6lSWvHSLi5r5VyFBhKgVYv7ckYM+0Pg3SmCeW/T9HiIMJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74CfJb6faPeuTNUIJfOUOb4MvVV9avXyZtfExkt1vPo=;
 b=BGX/a6KnibGlPuiMvzjqNNgptwZYFZmFOrBGJB7cNuH/vaG/jximN2k/MCH+PJiU+JI5TXei5J0pGfR5iWnUIcofLxJGcTHSTAyxepi2FAcGop+9J7JvVSl+7+qLTyyBA9pMEgvY9EQogg7XlXDc0IyLOg12OQVIkSx3ezDysyM3MkGk53zV8S+boarmRMJEB0DXMNuMqZOfNuzIGo7UP/dr6ODvsYKrBnLwKjZbzt81bmCldPqazK1hOiy26jiiFY85Q6RcTdeDoAxD/LbYZjPVp21HxEr1CS0BHMuN9iq2vTQXu2AK7RtHrADXKsC2Q4v8deQfgJR8vD3yOP+CIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74CfJb6faPeuTNUIJfOUOb4MvVV9avXyZtfExkt1vPo=;
 b=NPXsdJj3MB72apn8Q/XtXwM5WVZTEKtVRj0ZTfWXfU/FObqoTCqJXbAFDrkRy9uZhYCJRl8bl6l1VM7CUkpv2g7K0FQDYwiC3wmgdm58fk1B2xHuXYaNGVkxL2N+t5KUYtc15n8/CbWVPZ+OLpMDHhGc08ycL+pOD2K4CUe9RFXQMfqLRHtHa1MoUDx6Yo3NIo2fsnu4aL3pcKmgSm17Cv2htgFXIh9Jz5g81MkPRS/MLTbpvzKh3DTOgvo4V5zmSo2eXstVTVsPWZlJMBiRXPlMO05xG6tMuRmou/TwS578fwlJnP/AJ+o9QA2RUgUlCnEB4aq1AkoYu9njE1y5Fg==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN3PR01MB6150.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:81::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.9; Sun, 12 Feb 2023 05:16:25 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f156:868f:a45b:aeee]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f156:868f:a45b:aeee%10]) with mapi id 15.20.6111.009; Sun, 12 Feb
 2023 05:16:25 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH 3/3] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Thread-Topic: [PATCH 3/3] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Thread-Index: AQHZPQIWOA6klqVE3Eeu+IMq2FBbZa7J+X2AgADOx+g=
Date:   Sun, 12 Feb 2023 05:16:23 +0000
Message-ID: <BM1PR01MB09311C6B533B156B66ED58C7B8DC9@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
 <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com> <Y+fIr5Fxozjkg6yo@duo.ucw.cz>
In-Reply-To: <Y+fIr5Fxozjkg6yo@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Eh8K4cHMlnUviKgXbr477VJ4Qd1kgAghp+h044zQ1UzvZ/E3v5EhgK8oCf6ira0S]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN3PR01MB6150:EE_
x-ms-office365-filtering-correlation-id: 039026ab-8898-4a3e-8459-08db0cb848e4
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hFKO/y5DHzrKSsxqjOoHjNJ7wIt7AXxarvUh4jL+KlU14jMDZ+Kg0a+XoAvFMg8QdOsI6XyzRRzhfLxg+WdfX0RlJ6PUMiuLUyg/hvUsuIubVRO6/Jtur9Kw7MfK5wdxQiz8wjTA5jt5GvnpnHAgcsy8ZqKR0hfWFjpEBtaWtD5rJAptrYcngV8EG/eRYFP2s5a0vdB+Xlj5Mrl33gFmGwWTl2mW0pl+P5B4fTmfvAtwfDzJymatcpIXoIy9wC44uGCBFDhFlvFCU9XrXAeaj8Clqp1Wy4jdGaAvPG5u31f56ADbVyniprUbuJlmOCQDILX7qtIuTEj5QCO8k3mmFZVUBh4pTl9tIqFAFgfzgmLZW4RnI9XQLLTes8PhQf+voueOlgrO6Zrzn0etpTOBIrcqgguot+cV9vyvCxaBtJxeH+UkUbQe3MPMAqMp4tk+oCfu+wsPXL/lEV+KybTqJ6efLrObZURLToPjRPWxbUKGh1xPo+QtzttLXxFbjJmGUVFd9GsbERFzLJiQbso99CCLOW5UY0dAAqVbsfaqGGhKGycryI85U7uDOa34bkitmQddUUNy64m3dRSX2UNeY5V9BQJ2AcIqVU3ScJP+ukzmzReevCyjF+6DaWu6Cn9EiIdvscqoY3vGOuBpnYoHhw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmtqTlhvMytFMzdwclJScUsybVYybi9lZEFZMDdEUmsvY05tTm9WZENONk40?=
 =?utf-8?B?azFsTjZQSUMzdzIzTFM5SHh1VE1NbExWRGNFYXJWY0lHTXR4dmRlZGdzVEkz?=
 =?utf-8?B?OXM5NG53b0lPcExVamEwWks3ejgrN0cxU2tyVysycWtOeXVCZzdkek5NVk80?=
 =?utf-8?B?K011aUMxNXRzNnIxd2JLT0ZDL1Y4blZEZk1ESml1TGRrN0E3M0pIM05wVk0z?=
 =?utf-8?B?RUFQcU55QU9Gd0ltL0JuNDNkYzBxZjc2YUh3bi94Q1g5L2NET1ZlbFdlbzhm?=
 =?utf-8?B?Qmswb3lGaVJ4ZU94ZXI1eExqdnJqQXAzY2QxdTFra0U1bVFrdWg4UlQ4bWtJ?=
 =?utf-8?B?NnAxRUljeDNSSWZzeGZrYzFIOEdUTnFqNU1kYW91QlhkclIzVTlNaEJ1UTNl?=
 =?utf-8?B?OUIwU2NKQTVuczdGSWk3ZktnT2c3YUFYTW0yaTUxTm50bmdQaFBrL3dmeTE1?=
 =?utf-8?B?RjVBY0NJYklWTWVCUks5ZHUzeXNUQ2QvUUpNOW1idHg3UXM3MjNDeHQ5SEh4?=
 =?utf-8?B?SklzZFhId3J6Vlg3WnBXVzJ5RTd1M1drY002Q09uRFFSMmtVbklqcVBab3Ur?=
 =?utf-8?B?ZGZhdEdoMlpnUk9xYXFEazdwaEMyL1VuNmVrUWJ5TStlVzRBd2xiaTBRTitX?=
 =?utf-8?B?aVlGWkNmRXhKQ01JUjgrWFZtaHRQRnd3aEUvRG5mMmM0UVIwNUk1VTRtVkx1?=
 =?utf-8?B?QWJJT3dFeXdSMDREU1hFcFo4TFlhMVdjM1drYnk4djBCZlIwNlRuZzg5d0I3?=
 =?utf-8?B?c2UzRlM1bTFRNFJRN21uamlvYVp2dTlvZlNnQkNycWUwMExWREhTUEJMc1lx?=
 =?utf-8?B?UzNLcjY0cTdVeTA5OVhDY2IwbEJReE5Eakl2UVBrK245VXdYZ3lxNy8wUUlI?=
 =?utf-8?B?bE5UWER3VTIwbEprWDExd25sbHk3L0VxSEthejdtRlBZcldzQ3FqTmd6MmNh?=
 =?utf-8?B?S2d2MzZ4MlEySkpPM1pDOVdKSndvYzBZSmorWG83dDNkWC9OYnFybnBjT3lk?=
 =?utf-8?B?cEtkbEVMaXNaVkNtK0RFK3RqWFFnWm5GYmVHSTF3Qkw2KzhQNS9ET081anU5?=
 =?utf-8?B?TUhMcGwwMnp6NDFvL3J2R0swYXhaMU5QVk5BcnI2dG9GZUhFOW5vQllHZXZE?=
 =?utf-8?B?VkhYZlVqaFBsajJGbHlteW5MT1g1dzJGN0ZyRXRWc3dhbHRUSEZQbUl2TCsz?=
 =?utf-8?B?c2d1eE05c0RvVVhzM1pUYlUwbmEra1BhTlUxazhZejhGazlZWGU4VTFtLzAz?=
 =?utf-8?B?a0ExbmJBdi9yczJhUG9lQVR0OUhrSXI5KzhhZjlRV0xnTm5QUXJUa0xTZ2pZ?=
 =?utf-8?B?dGNDQlBkckdJL2xlbzBvVHNZMEFtUzcxQzNmWEU4U2l3QmtVRnRYZ2Nlc0t1?=
 =?utf-8?B?L1NPckkvTC90a1QrblBUTVFiUUtKa25qcGlYOVZpUEdRdElPdTdSQUxkNkFX?=
 =?utf-8?B?aFlOaUcwSUwzSi9UeFp4SmlLOG1RcGFlQ05wNkh2TENUdXp4YXM5a1FCcFVm?=
 =?utf-8?B?bnA4UjhLYnNOczcvZmgwTmxGVkVJL1hpbUh6U0pmK08vQjczVzJNMURLQUw3?=
 =?utf-8?B?UzlMRzQ4QlhxUDhjaWRKTXE0cklvNzdLN3ZFaWQ3WHlPZURUZFFEQVFzWmJE?=
 =?utf-8?B?SWw3cFMxaWduajNhQ25QTGVrWjE4MkNQNG9VZDNtc3d2UHZidEhNemdnQWJl?=
 =?utf-8?B?VjhBaThadkhod3RmS1Y1djJqekVlS0VLUGs0WGRSZTRNVDU5RnFKcXJVdnFt?=
 =?utf-8?B?UTNza1ZkQkdaU2h6RUxjWlU2RlJhTWpWREVLekRTaldnb2YwcWxOcVdQTnNJ?=
 =?utf-8?B?b0REeU9mQllHWW5KVGhyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 039026ab-8898-4a3e-8459-08db0cb848e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2023 05:16:23.9039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6150
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTEtRmViLTIwMjMsIGF0IDEwOjI2IFBNLCBQYXZlbCBNYWNoZWsgPHBhdmVsQHVj
dy5jej4gd3JvdGU6DQo+IA0KPiDvu79IaSENCj4gDQo+PiBGcm9tOiBPcmxhbmRvIENoYW1iZXJs
YWluIDxvcmxhbmRvY2guZGV2QGdtYWlsLmNvbT4NCj4+IA0KPj4gVGhpcyBkcml2ZXIgYWRkcyBz
dXBwb3J0IGZvciB0aGUga2V5Ym9hcmQgYmFja2xpZ2h0IG9uIEludGVsIFQyIE1hY3MNCj4+IHdp
dGggaW50ZXJuYWwgTWFnaWMgS2V5Ym9hcmRzIChNYWNCb29rUHJvMTYseCBhbmQgTWFjQm9va0Fp
cjksMSkNCj4gDQo+PiArICAgIGJhY2tsaWdodC0+aGRldiA9IGhkZXY7DQo+PiArICAgIGJhY2ts
aWdodC0+Y2Rldi5uYW1lID0gImFwcGxlOjprYmRfYmFja2xpZ2h0IjsNCj4gDQo+ICI6d2hpdGU6
a2JkX2JhY2tsaWdodCIsIHBsdXMgZG9jdW1lbnQgdGhpcyBpbg0KPiBEb2N1bWVudGF0aW9uL2xl
ZHMvd2VsbC1rbm93bi1sZWRzLnR4dCBzbyB0aGF0IHdlIGtlZXAgaXQgY29uc2lzdGVudA0KPiBh
Y2Nyb3NzIG1hY2hpbmVzPw0KDQpXZSBoYWQgdXNlZCB0aGUgc2FtZSBuYW1lIGZvciBidXR0ZXJm
bHkga2V5Ym9hcmRzLCB0aGUgY29kZSBiZWluZyBpbiBoaWQtYXBwbGUNCg0KV2lsbCB0aGF0IGFs
c28gYmUgbmVlZGVkIHRvIGJlIGNoYW5nZWQ/DQoNCj4gDQo+IFRoYW5rcywNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUGF2ZWwNCj4gLS0gDQo+IFBlb3BsZSBvZiBS
dXNzaWEsIHN0b3AgUHV0aW4gYmVmb3JlIGhpcyB3YXIgb24gVWtyYWluZSBlc2NhbGF0ZXMuDQo=
