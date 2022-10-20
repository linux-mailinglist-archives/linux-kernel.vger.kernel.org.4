Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83E605E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiJTKnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJTKnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:43:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31F41DEC20;
        Thu, 20 Oct 2022 03:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhtLwxTiEzvMAW/9gFBxR4Jp9mXRYR8yIKE+EP73kzFg8tFLLc3S1Xi7seMFG8K4BK73Zud5PhJgg1k1aGjMJQWm1NOFpwHeg1foal0w1CxjUz7MyZs6Uuh/kJfjBrWRoZhV96nadYBWM937ZFB4pABCP6EspQeYu5B16flMI/QKatmoc64Q06nuJ+QoDeJjrt314tzh5+5vQ5+8KljTi+3d/6JV/A/Py0Nto76bS9x8iJ9Zlu2TeCjqSHE9mPFagiMeMDhL1UkbMeR1vDIooNuG4TRX18H+K6g96H7xZfFQaqglMKDjjfxSNUM82uOhcp+8lZx0j+05BvYeL1LD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pds4a/AB6fKeKAtYkuqMxH2ro9C+9QOTb/c7IisDo4=;
 b=AgYrj90ocbQS/REO86Nu+k6/LAICxiHERTZZk6EFPL+k6CYQT2wKuvMVrQDQeC7Ia0FRpZI5Br5gwChjS9KvN03vRdarBTzf62s+IeutGomZbPKx9JS8UhFCIQPWLnD1DPgWDKBdtZ1ulNKayH0SyEk8buihUqPlrReQ8sEWx9/cmpzmgLx6AcLVaMbOoKMlan8lKBCn/nrtXvrR5S+xQP2jMbroHsAMWHrFIP0lcyieGs/IREH78P3Xgb5rQYyuW44LimtkL7mGTgaUKZUodGEuhHM5yWRLYwMoakSXZpI0M3oJM9C3RCE06jcBZMY9CmHGAn2UgeATl9Nv2RtMnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Pds4a/AB6fKeKAtYkuqMxH2ro9C+9QOTb/c7IisDo4=;
 b=PPuV7uwTEarstbAUFTlJm4lDxvo8TyMnD3Q7gtA/DuPkRbDWb54e5scDRP6tcSrTL/N9vv3b6Bimz6ok5QZW8wGqK+/DIYNNW1wKFtFYfKOSB0Z0glk6LQ2w/7ueLlX7ojZdWhdGTkC2TC+t4vHYOlS/ckryYOAEFTEfq2ixm5U=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8390.eurprd04.prod.outlook.com (2603:10a6:102:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 10:43:43 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea%5]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 10:43:42 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
Thread-Topic: [PATCH V2] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
Thread-Index: AQHY46tOTi2zpRnib0CirPl552XR464WyfAAgABO6aA=
Date:   Thu, 20 Oct 2022 10:43:42 +0000
Message-ID: <AS8PR04MB8404847954BDBA1462664C22922A9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221019110720.31722-1-sherry.sun@nxp.com>
 <2040575a-2378-ef7a-8a23-b2458d3103f6@kernel.org>
In-Reply-To: <2040575a-2378-ef7a-8a23-b2458d3103f6@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|PAXPR04MB8390:EE_
x-ms-office365-filtering-correlation-id: e63e39fd-0b01-4220-b159-08dab287f51d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Vi7r7fKBrAVJCVRrW9FO9EVyqePV/Mtj+1pFHzZkeuCPjsA5KEviQ4C8HCKQAa+A8yzX7jzwqtu1//MXfYlRfXD5FsahLTVHncPCztBzGUfwliLYZUI9sB5++1SIW+uGe+kKHxtvJQRewstdRqVvKUGv4SZT6RqfANLrUKGj13ZJ/ZAfP9p00YHhvcjmQaKkEtcO3A9RhBx5Ge3x//xtSGNW/qrYpmgqiyn1YD5dlER8ReeAq5WiTz67MbH6Nlrd/5/yR/vdPFegWABCjDdgu3DBLwyij758ldCElWGeDNWQQlpG9YG+9rjOeupC+t05J7cz5KtI/L1XuYmJjBvfoscYdezrZkgu68zMrD7QlbA/zWASJGkkXP9L8t7irURnZnhuXaleV4JLgm/c0r3ELxMy6OhZRdIwXij8xz4DkUlMrnZ07h4e1EYYyYsTZfKbwc97EQilq/APQHCGUckRIw5wc2u4QfB5bYQXjT1M2n35idpCqwCdXwjsSGh7dcN080n1qOGB1LBqVQvm4br4YtweHUJnX024jRLb1BDOMhMqWzcK+7CyV/AzOtKALLi2vCSB84sArn3KPVNYkpDLZW09nTufb1aidP4py3/Gue8fKMXoHx+MdDyjJwXgWNNe8Mv8JAE19gXFcKMy8E0vQ5EREm1SNA/lcoDmarRy/tz4XarLPMantLMk8CHjQLSKRzI7omWGCzjKIfiQTxi5AAAFANMKjjYwgT4iFOMYYs9wj/+g/gdTOce66o/3bcSfRd9bvPEvFJoc4k6xUqnWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199015)(9686003)(26005)(478600001)(38070700005)(66946007)(41300700001)(44832011)(186003)(2906002)(6506007)(8936002)(4326008)(33656002)(52536014)(86362001)(5660300002)(7696005)(38100700002)(122000001)(54906003)(110136005)(316002)(66446008)(76116006)(71200400001)(55016003)(8676002)(64756008)(66476007)(83380400001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mnd6ZnRVclNCWEZkbm5DeENyTFkyUWhuNFZqTkdncVRoYWxOUnplZFZWRU5u?=
 =?utf-8?B?UVFNNFFENmxqZFhhekJlaUZ6c2FMTFowL2c0WGZUaXY3VjZqdmVNSGVpbmlW?=
 =?utf-8?B?YlRBdDNDVmJQdlRNNlNzb1hMN3E2b3VaajNGL1VUQWRhWXdXN2NRT0xXbk1Y?=
 =?utf-8?B?WGx4TStRSVYwczIwTTdiYUlLYUR1UmtOTDgxZktIb3RZeSs2Nm85dmd5TzE4?=
 =?utf-8?B?RGM0cVFXNWZWeG05K2JabFJFOWVMYzJVcm5tRldjbHkrdWh4aTh5MjNxKzJJ?=
 =?utf-8?B?VGVxTnR2NnB5Y004QWY2WGdnWVpIQ3Z5S2pmZWtkWStOeVN6dCs5ZWtZZjM2?=
 =?utf-8?B?Y2tET2QzSENIejZLVW9nVEN0dVpxN0hFUXVnbWpmVVBGTEc1UGJaY3BpVFBY?=
 =?utf-8?B?YVFKaEJYTy9ZRmxjb09DV2VCcXRzellUenY5Sk5YLzRZZWthVytLeURRaFVK?=
 =?utf-8?B?OHZ4QzgzdFlXT3hmcFpJc1FzS3RpQUorR2N0NXVRcE5pNm9ieWVlYXZsQk1Z?=
 =?utf-8?B?SzFQMHQ0TWxZZnRrUlNJanZDVDVQMnErR04wREMzcjMrWmN6R2dWbnU2bVNo?=
 =?utf-8?B?NU4xSU5FbVZjZHRQSW9ZS3hEeFhVbEtwZTZkVVpTUlVIQ25JUVhDY2tmZkM3?=
 =?utf-8?B?SXpFck1FNHdGbGVSOFFYS2Z3OUtsc1drUFVuRU1vcVBvUllJcDRQK3JBR1FX?=
 =?utf-8?B?U3M1Nm9wNENVczRQcWlremE5YmF1ZWNWZmVIM1JYNW1wbVY5R2VucU1QeDVU?=
 =?utf-8?B?aDVZUkx6bVAzNzJLcVdQQ1BsaE1VMnY4d25yRHpubHEzdWlLL2tOV2h0M2Nh?=
 =?utf-8?B?M3FuY2dhajArVHd5Q3NDTDdPZUJOTktReVBKS0J4M0VDMFN1bk0rbVZQQzVC?=
 =?utf-8?B?TTNHTUhERjR2eGlBR3hjVmpQTHJ4VTd4NzZnT2lpWTBaYlRnM0ZaWkpYU3RC?=
 =?utf-8?B?d1QzTkhRYU5icm9NMFY4UU5GRkpTUFE4cmdsMCtOZHNnRUFOTno2b2tIalBL?=
 =?utf-8?B?RzJlNFp3UFF4Rk45VG91TUpnOW4xWGhuVDFxY0FjNGNlVEVnRS84STQ2MW4v?=
 =?utf-8?B?VlZZQUd6b2xyWUVadXM5RFhQRjVoNUMvTGhGV3U4dUVocjFtV3Uwd1VtNk4x?=
 =?utf-8?B?Z3U0cDduZVBWVnlNVS9oYmxmVm4waGVjZm1HZDhGVi9oSjMwei9pSCtiQVVZ?=
 =?utf-8?B?Zi96Qk5WSndYcTMyd0hrNk9lQ1A2ZFY3WlRja2wzalUrY1pCWnQ0My9DcHMw?=
 =?utf-8?B?VlVTME1WQVQ4dDVWZlY3bUpJR05KUDNWakczQ2dEZ2ZqUHRQU1g3eHJmcmVo?=
 =?utf-8?B?eHdnQXl6a0lLdWMxK3JBaHFOUCszamZ2WWVpem50cGRDRGpoZURxb01UVEww?=
 =?utf-8?B?QWxTM1cvazI0ODM5a2RFVnRvSzU0Q1Rua05Uc1ozRWxhWEJTdGRYd2V0c1Nl?=
 =?utf-8?B?NDE4WjNOQlc3TjAxdXdMQVpiRnhDTVgyc2NpOXJLdXVnaEpDY2NWOXZDUWJU?=
 =?utf-8?B?MHNaTGpWUlorZUt4M1F3ZCs2OUxFSHBFRFZzRDIxNC82QUJhYTRTd0pBTDls?=
 =?utf-8?B?RzNHSjJ5NDVudm1SQmpjR3J6OFIwT1VYNTMyZUJFcmdGNDRrWGJrZWcybXkv?=
 =?utf-8?B?bXpwT3JJTWttazFYNWx0bFZkR1pDa1AwSWh0NDJreWpTN1Q2YmpCa3RSSy9C?=
 =?utf-8?B?R3lVWitIZCtTUW1zdzdXVVpPb1ZjSVppb2xXK3dDZytPaTV3ZjBQMnpxZzNt?=
 =?utf-8?B?Q3ZsNmtreE5zTHlhNkppd3hUL2ljWWxlTmFVcytJTzBVWXJ2YmcvN3l6alZu?=
 =?utf-8?B?K0QydTNWOExxclhBQ3p1UnRPSTMzT2RURUw3Ym5WTkRvWWhMZkpIZGwvV3V3?=
 =?utf-8?B?ZER0STBnK3ViajZhNHZFZ3JBWWZ2eGdPOXp2TFkyL25TZTZqaXBjKzExWWhs?=
 =?utf-8?B?Y09hQ1FScVgyWGU1Skh2dUtkUE50ZGgvRWthdGxZeWVrRnJNSWhROUZHcTR2?=
 =?utf-8?B?OVNKZzF0and3elUvcjliMEd3bnc5WStVWmRsM0NzampsMTU4cjF0c3ovZmF1?=
 =?utf-8?B?azJPaExhQ3RUeTM2WUY5WHlQcnU0WjBucHFyQ29GOVI5YWFtZ0g3YzhoNTVD?=
 =?utf-8?Q?1xnLwqtW73mL9IYirecm3iUFc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63e39fd-0b01-4220-b159-08dab287f51d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 10:43:42.8414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVeKgp2pS2i+oYwcEY3ljo0zqnABzR5Eb2nXzAo8P6/Go5vfLYzQ66kCd37hXG9vHiQTuR2xt31a4ynt8HreBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDE5LiAxMC4gMjIsIDEzOjA3LCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+IGxwdWFydF9n
bG9iYWxfcmVzZXQoKSBzaG91bGRuJ3QgYnJlYWsgdGhlIG9uLWdvaW5nIHRyYW5zbWl0IGVuZ2lu
LA0KPiA+IG5lZWQNCj4gDQo+ICJlbmdpbmUiDQoNCldpbGwgZml4IGl0IGluIFYzLg0KDQo+IA0K
PiA+IHRvIHJlY292ZXIgdGhlIG9uLWdvaW5nIGRhdGEgdHJhbnNmZXIgYWZ0ZXIgcmVzZXQuDQo+
ID4NCj4gPiBUaGlzIGNhbiBoZWxwIGVhcmx5Y29uIGhlcmUsIHNpbmNlIGNvbW1pdCA2MGYzNjE3
MjJhZDIgKCJzZXJpYWw6DQo+ID4gZnNsX2xwdWFydDogUmVzZXQgcHJpb3IgdG8gcmVnaXN0cmF0
aW9uIikgbW92ZWQgbHB1YXJ0X2dsb2JhbF9yZXNldCgpDQo+ID4gYmVmb3JlIHVhcnRfYWRkX29u
ZV9wb3J0KCksIGVhcmx5Y29uIGlzIHdyaXRpbmcgZHVyaW5nIGdsb2JhbCByZXNldCwNCj4gPiBh
cyBnbG9iYWwgcmVzZXQgd2lsbCBkaXNhYmxlIHRoZSBUWCBhbmQgY2xlYXIgdGhlIGJhdWQgcmF0
ZSByZWdpc3RlciwNCj4gPiB3aGljaCBjYXVzZWQgdGhlIGVhcmx5Y29uIGNhbm5vdCB3b3JrIGFu
eSBtb3JlIGFmdGVyIHJlc2V0LCBuZWVkcyB0bw0KPiA+IHJlc3RvcmUgdGhlIGJhdWQgcmF0ZSBh
bmQgcmUtZW5hYmxlIHRoZSB0cmFuc21pdHRlciB0byByZWNvdmVyIHRoZQ0KPiA+IGVhcmx5Y29u
IHdyaXRlLg0KPiA+DQo+ID4gRml4ZXM6IGJkNTMwNWRjYWJiYyAoInR0eTogc2VyaWFsOiBmc2xf
bHB1YXJ0OiBkbyBzb2Z0d2FyZSByZXNldCBmb3INCj4gPiBpbXg3dWxwIGFuZCBpbXg4cXhwIikN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gQ2hhbmdlcyBpbiBWMjoNCj4gPiAxLiBUaGUgd2hpbGUgbG9vcCBtYXkgbmV2ZXIg
ZXhpdCBhcyB0aGUgc3RhdCBhbmQgc2ZpZm8gYXJlIG5vdCByZS1yZWFkDQo+ID4gaW5zaWRlIHRo
ZSBsb29wLCBmaXggdGhhdC4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvdHR5L3NlcmlhbC9mc2xf
bHB1YXJ0LmMgfCAyMiArKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gYi9kcml2ZXJzL3R0eS9zZXJp
YWwvZnNsX2xwdWFydC5jIGluZGV4IDY3ZmExMTNmNzdkNC4uOWEwNzgxMzk1YjFmDQo+ID4gMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gPiBAQCAtNDA4LDExICs0MDgsOSBA
QCBzdGF0aWMgaW50IGxwdWFydF9nbG9iYWxfcmVzZXQoc3RydWN0IGxwdWFydF9wb3J0DQo+ICpz
cG9ydCkNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0ID0gJnNwb3J0LT5w
b3J0Ow0KPiA+ICAgCXZvaWQgX19pb21lbSAqZ2xvYmFsX2FkZHI7DQo+ID4gKwl1bnNpZ25lZCBs
b25nIHR4X2VuYWJsZSwgYmQ7DQo+ID4gICAJaW50IHJldDsNCj4gPg0KPiA+IC0JaWYgKHVhcnRf
Y29uc29sZShwb3J0KSkNCj4gPiAtCQlyZXR1cm4gMDsNCj4gPiAtDQo+ID4gICAJcmV0ID0gY2xr
X3ByZXBhcmVfZW5hYmxlKHNwb3J0LT5pcGdfY2xrKTsNCj4gPiAgIAlpZiAocmV0KSB7DQo+ID4g
ICAJCWRldl9lcnIoc3BvcnQtPnBvcnQuZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSB1YXJ0IGlwZyBj
bGs6ICVkXG4iLA0KPiA+IHJldCk7IEBAIC00MjAsMTEgKzQxOCwyOSBAQCBzdGF0aWMgaW50IGxw
dWFydF9nbG9iYWxfcmVzZXQoc3RydWN0DQo+IGxwdWFydF9wb3J0ICpzcG9ydCkNCj4gPiAgIAl9
DQo+ID4NCj4gPiAgIAlpZiAoaXNfaW14N3VscF9scHVhcnQoc3BvcnQpIHx8IGlzX2lteDhxeHBf
bHB1YXJ0KHNwb3J0KSkgew0KPiA+ICsJCS8qDQo+ID4gKwkJICogSWYgdGhlIHRyYW5zbWl0dGVy
IGlzIHVzZWQgYnkgZWFybHljb24sIHdhaXQgdHJhbnNtaXQgZW5naW4NCj4gPiArY29tcGxldGUN
Cj4gDQo+ICJ3YWl0IGZvciB0cmFuc21pdCBlbmdpbmUgdG8gY29tcGxldGUiDQo+IA0KPiA+ICsJ
CSAqIGFuZCB0aGVuIHJlc2V0DQo+IA0KPiAiLiIgKGFkZCBhIHBlcmlvZCkNCg0KV2lsbCBmaXgg
aXQgaW4gVjMuIA0KDQo+IA0KPiA+ICsJCSAqLw0KPiA+ICsJCXR4X2VuYWJsZSA9IGxwdWFydDMy
X3JlYWQocG9ydCwgVUFSVENUUkwpICYgVUFSVENUUkxfVEU7DQo+ID4gKwkJaWYgKHR4X2VuYWJs
ZSkgew0KPiA+ICsJCQliZCA9IGxwdWFydDMyX3JlYWQoJnNwb3J0LT5wb3J0LCBVQVJUQkFVRCk7
DQo+ID4gKwkJCXdoaWxlICghKGxwdWFydDMyX3JlYWQocG9ydCwgVUFSVFNUQVQpICYNCj4gVUFS
VFNUQVRfVEMgJiYNCj4gPiArCQkJCSBscHVhcnQzMl9yZWFkKHBvcnQsIFVBUlRGSUZPKSAmDQo+
IFVBUlRGSUZPX1RYRU1QVCkpDQo+ID4gKwkJCQljcHVfcmVsYXgoKTsNCj4gDQo+IElmIHRoZSBI
VyBpcyBzdHVjaywgeW91IG1ha2UgdGhlIGtlcm5lbCBzdHVjayB0b28uIFdoYXQgYWJvdXQNCj4g
cmVhZF9wb2xsX3RpbWVvdXRfYXRvbWljKCkuIE9yIGF0IGxlYXN0IGEgY3VzdG9tIHRpbWVvdXQu
DQoNClNlZW1zIHVzZSByZWFkX3BvbGxfdGltZW91dF9hdG9taWMoKSBpcyBhIGdvb2QgaWRlYSwg
SSB3aWxsIHRyeSB0aGF0Lg0KDQo+IA0KPiA+ICsJCX0NCj4gPiArDQo+ID4gICAJCWdsb2JhbF9h
ZGRyID0gcG9ydC0+bWVtYmFzZSArIFVBUlRfR0xPQkFMIC0NCj4gSU1YX1JFR19PRkY7DQo+ID4g
ICAJCXdyaXRlbChVQVJUX0dMT0JBTF9SU1QsIGdsb2JhbF9hZGRyKTsNCj4gPiAgIAkJdXNsZWVw
X3JhbmdlKEdMT0JBTF9SU1RfTUlOX1VTLCBHTE9CQUxfUlNUX01BWF9VUyk7DQo+ID4gICAJCXdy
aXRlbCgwLCBnbG9iYWxfYWRkcik7DQo+ID4gICAJCXVzbGVlcF9yYW5nZShHTE9CQUxfUlNUX01J
Tl9VUywgR0xPQkFMX1JTVF9NQVhfVVMpOw0KPiA+ICsNCj4gPiArCQkvKiBSZWNvdmVyIHRoZSB0
cmFuc21pdHRlciBmb3IgZWFybHljb24gKi8NCj4gPiArCQlpZiAodHhfZW5hYmxlKSB7DQo+ID4g
KwkJCWxwdWFydDMyX3dyaXRlKHBvcnQsIGJkLCBVQVJUQkFVRCk7DQo+ID4gKwkJCWxwdWFydDMy
X3dyaXRlKHBvcnQsIFVBUlRDVFJMX1RFLCBVQVJUQ1RSTCk7DQo+IA0KPiBJIGRvbid0IGtub3cg
dGhlIEhXLiBJcyBpdCBlbm91Z2ggdG8gd3JpdGUgVEUgaGVyZT8gSU9XIHNob3VsZG4ndCB3ZQ0K
PiBwcmVzZXJ2ZSB0aGUgd2hvbGUgcmVnaXN0ZXIgY29udGVudCBmcm9tIHRoZSBhYm92ZSByZWFk
IGhlcmU/DQoNClllcywgbWF5YmUgcmVzdG9yZSB0aGUgd2hvbGUgY3RybCByZWdpc3RlciBoZXJl
IHdvdWxkIGJlIGJldHRlciB0byBhdm9pZCBhbnkgY29uZnVzaW9uLCB3aWxsIGRvIHRoYXQgaW4g
VjMuIFRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
