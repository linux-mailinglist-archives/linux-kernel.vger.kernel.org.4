Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7C060969A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 23:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJWVrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 17:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiJWVrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 17:47:02 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3AF63F1A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 14:47:00 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2110.outbound.protection.outlook.com [104.47.22.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-GaPt3oYuNY-kw-tz1tjZ9w-2; Sun, 23 Oct 2022 23:46:58 +0200
X-MC-Unique: GaPt3oYuNY-kw-tz1tjZ9w-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0056.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:23::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Sun, 23 Oct 2022 21:46:56 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3c38:efa9:5eff:4caa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3c38:efa9:5eff:4caa%4]) with mapi id 15.20.5746.023; Sun, 23 Oct 2022
 21:46:56 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v1 6/8] arm64: dts: verdin-imx8mp: add pcie support
Thread-Topic: [PATCH v1 6/8] arm64: dts: verdin-imx8mp: add pcie support
Thread-Index: AQHYzqCSFprtPNshvkKk8r6HVRI4sa4cJPYAgACPuIA=
Date:   Sun, 23 Oct 2022 21:46:56 +0000
Message-ID: <9d922d5f8fce469a61396a94dd292d2fd2315b4e.camel@toradex.com>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
         <20220922162925.2368577-7-marcel@ziswiler.com>
         <20221023131232.GN125525@dragon>
In-Reply-To: <20221023131232.GN125525@dragon>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0056:EE_
x-ms-office365-filtering-correlation-id: f2a1b85d-7130-428d-d6f7-08dab5401afb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: w2XJ7cEJV5+xQXHKc4WiDXHipQZa31WRBEilMsBI0K/gJa7o03Sbuo+8DZscOcvVuzrtvDoHOhGSl51Z0f4drqF1nHU/A/TFY8jW4hWwrntBs5zWrQO24Z4bM3NGcftoXEm55QEQRKp27v2Nc0bY5rcSlQgQgOn+O05fOCKTGr39UoiPkWnOJZppVshOiMNKwwwA2w8tI52pQwTVwkw1VA8FPced6tqiCycePDeNr/q5b08WuTCl67kGcRxNSN8hpT7AWlHF59G/foeeh21aYzZHweIwAqvwkhabwaAItjkJFiNvgLXY1xopjajk4q2LdVP47HEHcSnwIW2lm1NE3GugrN+FZWg6tcCEKFtNKjsQCJpJ9M417IsJlj/jtvEElffGY8KrrRFxJQUd0W6lhT4pDoX6EJUY/SaMLLtISx7lbrQuYMHaDQgEvnIWzpL/NU6sAGI4dg93JlvGpTikrnOBING4BbkyQfDXheUYsOE4uZZVFocjIhLneyjuotzOvYBNlccXn747/vqt5qVHxrq6aGqz2ZshMlznhUBhqFXpwQ3oZAyoxn16sBWDfAQq63SCtoUORPV+pzGqHWikjbrbnaXC3MTG7LjE3FsYl22VMEV8MEEiPD1XC4Pd9GFL6fasYJaSqsT2oyVEB6E2BnO5r6w1PYA8ayU+xuvxa2yV5uF3Ja8/1jmP7hc5KJrLyFBNNzwnUUGQ/qMLUGEvIvoPKJcobcU1RbOJhyPUKVJVgf9VeK4FcGrwsgWHD1dy5rx4B9aKgVOaLZ9mndbwc+GTWxudvcg7en0Mw4JKLU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39830400003)(396003)(366004)(136003)(346002)(376002)(451199015)(38070700005)(45080400002)(54906003)(6916009)(71200400001)(83380400001)(38100700002)(122000001)(186003)(2616005)(6506007)(6512007)(966005)(478600001)(6486002)(8676002)(66446008)(64756008)(66556008)(66476007)(66946007)(4326008)(76116006)(8936002)(86362001)(316002)(4001150100001)(36756003)(7416002)(5660300002)(44832011)(2906002)(41300700001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azlvdnk2U1AzZjcwYXZGQkEvVlBvUlUrZG9ackwyZ1llNXNrN2pNblN0Y1I2?=
 =?utf-8?B?NTRlYWVBOFpxZmJFR1BKQkdqVnAveE1vMkV6cWNlMzRCUU1FbC80KzR5bHdQ?=
 =?utf-8?B?UmNub1FyR0RDK3FkQmJ5ZkFlL3lmMjZSOE5IRXJYODdZVlVncUpTWHZvNFN0?=
 =?utf-8?B?MGtFa2NpSUlhV3FYb0IxTEFsd0lsUTV0QUlQUkdOREp3RkgrMlJIZXJkekEv?=
 =?utf-8?B?N1pUV3FvTG84TTE1RGdDbzFEVUlXMmI1WDFFM2IyTVFMS1Ivd0p5Y28reDYv?=
 =?utf-8?B?TjYzZ2lMc3pOWm1aWHRXb0dPZVdOYUFXaWN5ZjhmSVYyeDR3Nm5lMmpnUVFt?=
 =?utf-8?B?eW80dXVCUEdRSFU0S01ZLzNhQjk0L21PZnBLTHUvR2JqTFlTcFFkQkRaMkFC?=
 =?utf-8?B?UFNDOGduMWlzQk05b0xzcW1XTEVwNW50eTZ3WVlyTUNmRTI3SFpCUkNqcENX?=
 =?utf-8?B?aS9UNTlZQmlIK0lGMzdVZDlrbmNjZGNVMnkvNjNoVXZJaUN3ODBCK1ZDRVhG?=
 =?utf-8?B?Y3JVaG1WTXp5SFJpU2pDRU1FMkVTR1BQSnVDUjAzaVRidlFSK1JmV2V6cS95?=
 =?utf-8?B?dWdTQjJNQzFhYUdKR3dmbGNKWko2c3lSclhDV2lia3JaRXJIbWI1V09pUEFF?=
 =?utf-8?B?SGNvaVZvNnYwTWFFVHdySE4xNlVDSE1MU2E0aUsrMmJtLzFqTFhDQis4NThp?=
 =?utf-8?B?UEtJcG5WZWJDLzhkNytLVXN3RmVZM05NZXBUU3JFU2dLSU00dndLVG5YV25O?=
 =?utf-8?B?RzVWdWdoZUx3QXdXam5EV2dDMHRWYlZRRE1OY1pJOWc3OG1JTzU3eHZGYWNS?=
 =?utf-8?B?QUV6dzhHMDV1Q1R6NXNvd25UR01VcVE4NHErTnpza1Rlb3ozNExsWllrWFZv?=
 =?utf-8?B?MzluTmp0elM2OXZrazJTdzRISjdEU2pTZDZhNUZTUjZnd1A5UFhDNTBtbkZw?=
 =?utf-8?B?MUFIVGZpa0lvU0N3b21HemN1ZkZrL1k2bjVEYlRUOUltUmlCZmpaQy96RmNP?=
 =?utf-8?B?MjI0dzh4MXBrOTlmUzJYY1VLOENad3JYL3VSWGYyRUt3NWZKbnBUUmg5UmNC?=
 =?utf-8?B?WTZOUi96SldwVWo0RGMweVVpVno1aHpvNExVQ3ZCaHRudThOOXIzTVY0KytR?=
 =?utf-8?B?ZGZZenIyTnNzZ2pFNG1NMGxCV1g0OXZBMDdLZml0NWgrTFBPdDNZVWRPMlFm?=
 =?utf-8?B?Y1pONGdHSWZDVWN4cnVEMkR3bmZNS2tmMU4rREVxdndaRUdjQzlwVGtKajQv?=
 =?utf-8?B?c0NFN1RVSW4zRjFZUUp4ZDFLa1FkY2txd0IyY3JQcFU0UzVDUEswSWFtd1Y3?=
 =?utf-8?B?elNwOGpTakdXZE5NVU9JOXhUeldFUVdPTmsrdG5kYVlMcVVlSU8weXpMaFN0?=
 =?utf-8?B?VEFrRUJjMThFWGgwV3ZabWlyY3lZYlZLeTFIRFlLR2REek1tUUNzTkNvNFFi?=
 =?utf-8?B?dzBqNWVkbEVYdzJ1cmNDVlJWVys4ejE1ZDMzekJMVVpod2lyWlMra3JWNHhM?=
 =?utf-8?B?OWhpdWpRc1pJU2hpUWU5VEUzcTZrZmkvYlA5bDNJdWk0amNybTl0dVhOVkFW?=
 =?utf-8?B?V1ZjMUxONS9Xemc2dzhkQkpWWmhFMGs2c2xVMGo5bFJ3cWh5Q0tMb04yTGl3?=
 =?utf-8?B?NUIyaHVhOHd0c0k2VSt1T1lhcmJzVmUwS0hvMFl4UWhUcm9zcWFlZG1yQUNw?=
 =?utf-8?B?VkNZMDVmb0NiZitwNTNlelNlcnhlK3VRVHU3UXNBdVNkRkVIaUFNWSt4My9Q?=
 =?utf-8?B?ZGF4dTBrMVZ0WE1BdWxHQ3piaHlrTUlMenpMbjYrbS91TzJJY2NBYVBzYnFu?=
 =?utf-8?B?N1A3VU41M0gvdTM0eUpyeGtYSFNDODlKc3NuS2o2TitxSEEvSkNLUWNkd0Rp?=
 =?utf-8?B?TCtRTS9mSkhidktEbWNHeFQ4aDcvZFN6djNpUmNHaUl3U1hkVnZnQjBNMGxi?=
 =?utf-8?B?TnVSb2xzQkptYmJiTmxNbjMyTWkza0tieVJmdjN6ZEJFZ3NkT0Z3R1NnUFhp?=
 =?utf-8?B?WSs2ZVg1cWFBTzJQd2srQ2lackpsMEpUUnhUR0ZiWlBvaEhtWmFYSnZLV3c1?=
 =?utf-8?B?M1FBbjdSbzZWcitDd0FXbGxxOThJV0J1U2tWM2Z2THN0V3preDA4S2lmRXBa?=
 =?utf-8?B?NnNLRUp0UUorVHJQc0R2c0hoNG9WNTMwdHZIZ20wYVhnK2lxdDJrUndQZjVQ?=
 =?utf-8?Q?q1RhWkQ7xtm41UxOZqZgorJrQLrViuE3n+xphWkHYa7V?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a1b85d-7130-428d-d6f7-08dab5401afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 21:46:56.1436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpYF/kkAzTZ+Ud+VaFueDIbboukwuk+6Z/QX9lJsBNGG0Uowbt1OamqKO2ysKZc/ZMu2DGB8EQrtIZf3lPxeWNtd02egLACDZEdnma7RO9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0056
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <582CB5407367C148B0CC3F0B5FC8DAC0@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24NCg0KT24gU3VuLCAyMDIyLTEwLTIzIGF0IDIxOjEyICswODAwLCBTaGF3biBHdW8g
d3JvdGU6DQo+IE9uIFRodSwgU2VwIDIyLCAyMDIyIGF0IDA2OjI5OjIzUE0gKzAyMDAsIE1hcmNl
bCBaaXN3aWxlciB3cm90ZToNCj4gPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3
aWxlckB0b3JhZGV4LmNvbT4NCj4gPiANCj4gPiBBZGQgUENJZSBzdXBwb3J0IG9uIHRoZSBWZXJk
aW4gaU1YOE0gUGx1cy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJjZWwgWmlzd2lsZXIg
PG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiANCj4gPiAtLS0NCj4gPiBUaGlzIHN0
aWxsIHJlbGllcyBvbiB0aGUgUEhZIHBhcnQgbGFuZGluZyBbMV0gYW5kIHRoZSBpbnRlcm5hbCBT
WVNQTEwNCj4gPiBtb2RlIGdldHRpbmcgc29ydGVkIFsyXS4NCj4gPiANCj4gPiBbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzE2NjM2NTk0OTgtNTE4MC0xLWdpdC1zZW5kLWVtYWlsLWhv
bmd4aW5nLnpodUBueHAuY29tLw0KPiA+IFsyXQ0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9BUzhQUjA0TUI4Njc2NTdEMDNDNjE3NzQwOTZBNUExNjI4QzRDOUBBUzhQUjA0TUI4Njc2
LmV1cnByZDA0LnByb2Qub3V0bG9vay5jb20vDQo+IA0KPiBBcmUgdGhlc2UgZGVwZW5kZW5jaWVz
IGFscmVhZHkgbGFuZGVkIG9uIHY2LjEtcmMxPw0KDQpObywgYnV0IFsxXSBWaW5vZCBwdWxsZWQg
aW50byAtbmV4dCBvbiBPY3RvYmVyIDE3IHNvIHdlIHNob3VsZCBiZSBmaW5lLiBBY3R1YWxseSwg
eW91ciBwdWxsIG9mIFszXSBpbnRvIC1uZXh0DQphcyBvZiBTZXB0ZW1iZXIgMTcgaXMgbW9yZSBp
bXBvcnRhbnQsIGFzIG90aGVyd2lzZSB0aGF0IHBjaWUgYW5kIHBjaWVfcGh5IG5vZGUgSSdtIHJl
ZmVyZW5jaW5nIHdvdWxkIG5vdCBleGlzdA0KeWV0LiBPZiBjb3Vyc2UsIGl0IHdpbGwgb25seSBi
ZSByZWFsbHkgZnVuY3Rpb25hbCBvbmNlIFsyXSBhbHNvIGdldHMgc29ydGVkLiBIb3dldmVyLCBp
dCBzaG91bGQgcmVhbGx5IG5vdCBodXJ0DQphbHJlYWR5IGhhdmluZyBpdCBpbiB0aGVyZS4NCg0K
VGhhbmtzIQ0KDQpbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzE2NjIxMDkwODYtMTU4
ODEtMS1naXQtc2VuZC1lbWFpbC1ob25neGluZy56aHVAbnhwLmNvbS8NCg0KPiBTaGF3bg0KPiAN
Cj4gPiBseSANCj4gPiDCoC4uLi9kdHMvZnJlZXNjYWxlL2lteDhtcC12ZXJkaW4tZGFobGlhLmR0
c2nCoMKgIHzCoCA5ICsrKysrKystDQo+ID4gwqAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cC12ZXJkaW4uZHRzacKgwqDCoMKgIHwgMjIgKysrKysrKysrKysrKysrKysrLQ0KPiA+IMKgMiBm
aWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtdmVyZGlu
LWRhaGxpYS5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAt
dmVyZGluLWRhaGxpYS5kdHNpDQo+ID4gaW5kZXggNGI4Zjg2ZjYzMDgxLi42MGY5ZGM0ODQ3ZGIg
MTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXZl
cmRpbi1kYWhsaWEuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtcC12ZXJkaW4tZGFobGlhLmR0c2kNCj4gPiBAQCAtNjcsNyArNjcsMTQgQEAgJmkyYzQg
ew0KPiA+IMKgwqDCoMKgwqDCoMKgwqAvKiBUT0RPOiBBdWRpbyBDb2RlYyAqLw0KPiA+IMKgfTsN
Cj4gPiDCoA0KPiA+IC0vKiBUT0RPOiBWZXJkaW4gUENJRV8xICovDQo+ID4gKy8qIFZlcmRpbiBQ
Q0lFXzEgKi8NCj4gPiArJnBjaWUgew0KPiA+ICvCoMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJva2F5
IjsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZwY2llX3BoeSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKg
c3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+IMKgDQo+ID4gwqAvKiBWZXJkaW4gUFdNXzEg
Ki8NCj4gPiDCoCZwd20xIHsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1wLXZlcmRpbi5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1wLQ0KPiA+IHZlcmRpbi5kdHNpDQo+ID4gaW5kZXggN2JlN2U5MjI5MjdiLi4xNjBi
YjMyY2I1ZjcgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1wLXZlcmRpbi5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1wLXZlcmRpbi5kdHNpDQo+ID4gQEAgLTczNCw3ICs3MzQsMjcgQEAgZWVwcm9tX2Nh
cnJpZXJfYm9hcmQ6IGVlcHJvbUA1NyB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoH07DQo+ID4gwqB9
Ow0KPiA+IMKgDQo+ID4gLS8qIFRPRE86IFZlcmRpbiBQQ0lFXzEgKi8NCj4gPiArLyogVmVyZGlu
IFBDSUVfMSAqLw0KPiA+ICsmcGNpZSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgYXNzaWduZWQtY2xv
Y2tzID0gPCZjbGsgSU1YOE1QX0NMS19QQ0lFX0FVWD47DQo+ID4gK8KgwqDCoMKgwqDCoMKgYXNz
aWduZWQtY2xvY2stcGFyZW50cyA9IDwmY2xrIElNWDhNUF9TWVNfUExMMl81ME0+Ow0KPiA+ICvC
oMKgwqDCoMKgwqDCoGFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDEwMDAwMDAwPjsNCj4gPiArwqDC
oMKgwqDCoMKgwqBjbG9ja3MgPSA8JmNsayBJTVg4TVBfQ0xLX0hTSU9fUk9PVD4sDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmNsayBJTVg4TVBfQ0xLX1BDSUVfUk9PVD4s
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmNsayBJTVg4TVBfQ0xLX0hT
SU9fQVhJPjsNCj4gPiArwqDCoMKgwqDCoMKgwqBjbG9jay1uYW1lcyA9ICJwY2llIiwgInBjaWVf
YXV4IiwgInBjaWVfYnVzIjsNCj4gPiArwqDCoMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRl
ZmF1bHQiOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llPjsN
Cj4gPiArwqDCoMKgwqDCoMKgwqAvKiBQQ0lFXzFfUkVTRVQjIChTT0RJTU0gMjQ0KSAqLw0KPiA+
ICvCoMKgwqDCoMKgwqDCoHJlc2V0LWdwaW8gPSA8JmdwaW80IDE5IEdQSU9fQUNUSVZFX0xPVz47
DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmcGNpZV9waHkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoGNs
b2NrcyA9IDwmY2xrIElNWDhNUF9DTEtfSFNJT19ST09UPjsNCj4gPiArwqDCoMKgwqDCoMKgwqBj
bG9jay1uYW1lcyA9ICJyZWYiOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGZzbCxjbGtyZXEtdW5zdXBw
b3J0ZWQ7DQo+ID4gK8KgwqDCoMKgwqDCoMKgZnNsLHJlZmNsay1wYWQtbW9kZSA9IDxJTVg4X1BD
SUVfUkVGQ0xLX1BBRF9PVVRQVVQ+Ow0KPiA+ICt9Ow0KPiA+IMKgDQo+ID4gwqAvKiBWZXJkaW4g
UFdNXzEgKi8NCj4gPiDCoCZwd20xIHsNCj4gPiAtLSANCj4gPiAyLjM2LjENCg0KQ2hlZXJzDQoN
Ck1hcmNlbA0K

