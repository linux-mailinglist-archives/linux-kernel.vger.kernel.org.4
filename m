Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2B661E851
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiKGBhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiKGBhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:37:11 -0500
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Nov 2022 17:36:52 PST
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 209B0BC38;
        Sun,  6 Nov 2022 17:36:51 -0800 (PST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(20709:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Mon, 07 Nov 2022 09:18:03 +0800 (CST)
Received: from sphcmbx01.sunplus.com.tw (172.17.9.202) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Mon, 7 Nov 2022 09:18:04 +0800
Received: from sphcmbx01.sunplus.com.tw ([fe80::49ab:7804:9eea:7d3]) by
 sphcmbx01.sunplus.com.tw ([fe80::49ab:7804:9eea:7d3%14]) with mapi id
 15.00.1497.033; Mon, 7 Nov 2022 09:18:04 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v11 1/2] thermal: Add thermal driver for Sunplus
Thread-Topic: [PATCH v11 1/2] thermal: Add thermal driver for Sunplus
Thread-Index: AQHY4sPyoBAud6f7tUWAvgkFR+scRq4aHPyAgBipWvA=
Date:   Mon, 7 Nov 2022 01:18:03 +0000
Message-ID: <b97694939b824cf4b533b001a65005b4@sphcmbx01.sunplus.com.tw>
References: <cover.1665990345.git.lhjeff911@gmail.com>
 <076585e120b64832dcb81e39f3e59d719148816b.1665990345.git.lhjeff911@gmail.com>
 <d5cda762-63d0-ac89-e826-52b3bc6fad84@linaro.org>
In-Reply-To: <d5cda762-63d0-ac89-e826-52b3bc6fad84@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91ICBJIHdpbGwgZml4IGl0IGluIG5leHQgbmV4dCBzdWJtaXNzaW9uDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5s
ZXpjYW5vQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgT2N0b2JlciAyMywgMjAyMiAxMjoz
NiBBTQ0KPiBUbzogTGktaGFvIEt1byA8bGhqZWZmOTExQGdtYWlsLmNvbT47IGtyemtAa2VybmVs
Lm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7IGFtaXRrQGtlcm5lbC5vcmc7DQo+IHJ1aS56aGFuZ0Bp
bnRlbC5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogTGggS3VvIOmDreWKm+ixqiA8bGguS3VvQHN1bnBsdXMuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYxMSAxLzJdIHRoZXJtYWw6IEFkZCB0aGVybWFsIGRyaXZlciBmb3IgU3Vu
cGx1cw0KPiANCj4gT24gMTgvMTAvMjAyMiAwOTozMiwgTGktaGFvIEt1byB3cm90ZToNCj4gPiBB
ZGQgdGhlcm1hbCBkcml2ZXIgZm9yIFN1bnBsdXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBM
aS1oYW8gS3VvIDxsaGplZmY5MTFAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4g
djExOg0KPiA+ICAgLSBSZW1vdmUgdGhlIHJlbW92ZSBmdW5jdGlvbiBvZiB0aGUgcGxhdGZvcm1f
ZHJpdmVyDQo+ID4gICAtIEZpeCBlcnJvciByZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3Qu
DQo+ID4NCj4gPiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICB8ICAgNiArKw0K
PiA+ICAgZHJpdmVycy90aGVybWFsL0tjb25maWcgICAgICAgICAgIHwgIDEwICsrKw0KPiA+ICAg
ZHJpdmVycy90aGVybWFsL01ha2VmaWxlICAgICAgICAgIHwgICAxICsNCj4gPiAgIGRyaXZlcnMv
dGhlcm1hbC9zdW5wbHVzX3RoZXJtYWwuYyB8IDEzMCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxNDcgaW5zZXJ0aW9ucygrKQ0K
PiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGhlcm1hbC9zdW5wbHVzX3RoZXJtYWwu
Yw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMgaW5kZXgg
Y2YwZjE4NS4uYmYyMmM1MyAxMDA2NDQNCj4gPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+ICsrKyBi
L01BSU5UQUlORVJTDQo+ID4gQEAgLTE5NzUzLDYgKzE5NzUzLDEyIEBAIFM6CU1haW50YWluZWQN
Cj4gPiAgIEY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLXN1bnBs
dXMtc3A3MDIxLnlhbWwNCj4gPiAgIEY6CWRyaXZlcnMvc3BpL3NwaS1zdW5wbHVzLXNwNzAyMS5j
DQo+ID4NCj4gPiArU1VOUExVUyBUSEVSTUFMIERSSVZFUg0KPiA+ICtNOglMaS1oYW8gS3VvIDxs
aGplZmY5MTFAZ21haWwuY29tPg0KPiA+ICtMOglsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4g
PiArUzoJTWFpbnRhaW5lZA0KPiA+ICtGOglkcml2ZXJzL3RoZXJtYWwvc3VucGx1c190aGVybWFs
LmMNCj4gPiArDQo+ID4gICBTVU5QTFVTIFVBUlQgRFJJVkVSDQo+ID4gICBNOglIYW1tZXIgSHNp
ZWggPGhhbW1lcmgwMzE0QGdtYWlsLmNvbT4NCj4gPiAgIFM6CU1haW50YWluZWQNCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL0tjb25maWcgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZp
ZyBpbmRleA0KPiA+IGUwNTJkYWUuLjQwNWI3ODggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90
aGVybWFsL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KPiA+IEBA
IC01MDQsNCArNTA0LDE0IEBAIGNvbmZpZyBLSEFEQVNfTUNVX0ZBTl9USEVSTUFMDQo+ID4gICAJ
ICBJZiB5b3Ugc2F5IHllcyBoZXJlIHlvdSBnZXQgc3VwcG9ydCBmb3IgdGhlIEZBTiBjb250cm9s
bGVkDQo+ID4gICAJICBieSB0aGUgTWljcm9jb250cm9sbGVyIGZvdW5kIG9uIHRoZSBLaGFkYXMg
VklNIGJvYXJkcy4NCj4gPg0KPiA+ICtjb25maWcgU1VOUExVU19USEVSTUFMDQo+ID4gKwl0cmlz
dGF0ZSAiU3VucGx1cyB0aGVybWFsIGRyaXZlcnMiDQo+ID4gKwlkZXBlbmRzIG9uIFNPQ19TUDcw
MjEgfHwgQ09NUElMRV9URVNUDQo+ID4gKwloZWxwDQo+ID4gKwkgIFRoaXMgZW5hYmxlIHRoZSBT
dW5wbHVzIFNQNzAyMSB0aGVybWFsIGRyaXZlciwgd2hpY2ggc3VwcG9ydHMgdGhlIHByaW1pdGl2
ZQ0KPiA+ICsJICB0ZW1wZXJhdHVyZSBzZW5zb3IgZW1iZWRkZWQgaW4gU3VucGx1cyBTUDcwMjEg
U29DLg0KPiA+ICsNCj4gPiArCSAgSWYgeW91IGhhdmUgYSBTdW5wbHVzIFNQNzAyMSBwbGF0Zm9y
bSBzYXkgWSBoZXJlIGFuZCBlbmFibGUgdGhpcyBvcHRpb24NCj4gPiArCSAgdG8gaGF2ZSBzdXBw
b3J0IGZvciB0aGVybWFsIG1hbmFnZW1lbnQuDQo+ID4gKw0KPiA+ICAgZW5kaWYNCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL01ha2VmaWxlIGIvZHJpdmVycy90aGVybWFsL01ha2Vm
aWxlIGluZGV4DQo+ID4gMjUwNmM2Yy4uNDUxMjE5MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3RoZXJtYWwvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUNCj4g
PiBAQCAtNjEsMyArNjEsNCBAQCBvYmotJChDT05GSUdfVU5JUEhJRVJfVEhFUk1BTCkJKz0gdW5p
cGhpZXJfdGhlcm1hbC5vDQo+ID4gICBvYmotJChDT05GSUdfQU1MT0dJQ19USEVSTUFMKSAgICAg
Kz0gYW1sb2dpY190aGVybWFsLm8NCj4gPiAgIG9iai0kKENPTkZJR19TUFJEX1RIRVJNQUwpCSs9
IHNwcmRfdGhlcm1hbC5vDQo+ID4gICBvYmotJChDT05GSUdfS0hBREFTX01DVV9GQU5fVEhFUk1B
TCkJKz0ga2hhZGFzX21jdV9mYW4ubw0KPiA+ICtvYmotJChDT05GSUdfU1VOUExVU19USEVSTUFM
KQkrPSBzdW5wbHVzX3RoZXJtYWwubw0KPiA+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvc3VucGx1c190aGVybWFsLmMNCj4gPiBi
L2RyaXZlcnMvdGhlcm1hbC9zdW5wbHVzX3RoZXJtYWwuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uMjBlYTdkOQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiAr
KysgYi9kcml2ZXJzL3RoZXJtYWwvc3VucGx1c190aGVybWFsLmMNCj4gPiBAQCAtMCwwICsxLDEz
MCBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ID4g
Ky8qDQo+ID4gKyAqIENvcHlyaWdodCAoYykgU3VucGx1cyBJbmMuDQo+ID4gKyAqIEF1dGhvcjog
TGktaGFvIEt1byA8bGhqZWZmOTExQGdtYWlsLmNvbT4gICovDQo+ID4gKw0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvYml0ZmllbGQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L252bWVtLWNv
bnN1bWVyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC90aGVybWFsLmg+
DQo+ID4gKw0KPiA+ICsjZGVmaW5lIEVOQUJMRV9USEVSTUFMCQlCSVQoMzEpDQo+ID4gKyNkZWZp
bmUgU1BfVEhFUk1BTF9NQVNLCQlHRU5NQVNLKDEwLCAwKQ0KPiA+ICsNCj4gPiArI2RlZmluZSBU
RU1QX1JBVEUJCTYwOA0KPiA+ICsjZGVmaW5lIFRFTVBfQkFTRQkJMzUwMA0KPiA+ICsjZGVmaW5l
IFRFTVBfT1RQX0JBU0UJCTE1MTgNCj4gPiArDQo+ID4gKyNkZWZpbmUgU1BfVEhFUk1BTF9DVEww
X1JFRwkweDAwMDANCj4gPiArI2RlZmluZSBTUF9USEVSTUFMX1NUUzBfUkVHCTB4MDAzMA0KPiA+
ICsNCj4gPiArLyogY29tbW9uIGRhdGEgc3RydWN0dXJlcyAqLw0KPiA+ICtzdHJ1Y3Qgc3BfdGhl
cm1hbF9kYXRhIHsNCj4gPiArCXN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICpwY2JfdHo7DQo+
ID4gKwl2b2lkIF9faW9tZW0gKnJlZ3M7DQo+ID4gKwlpbnQgKm90cF90ZW1wMDsNCj4gPiArfTsN
Cj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgc3VucGx1c19nZXRfb3RwX3RlbXBfY29lZihzdHJ1Y3Qg
c3BfdGhlcm1hbF9kYXRhICpzcF9kYXRhLA0KPiA+ICtzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4g
PiArCXN0cnVjdCBudm1lbV9jZWxsICpjZWxsOw0KPiA+ICsJc3NpemVfdCBvdHBfbDsNCj4gPiAr
DQo+ID4gKwljZWxsID0gbnZtZW1fY2VsbF9nZXQoZGV2LCAiY2FsaWIiKTsNCj4gPiArCWlmIChJ
U19FUlIoY2VsbCkpDQo+ID4gKwkJcmV0dXJuIFBUUl9FUlIoY2VsbCk7DQo+ID4gKw0KPiA+ICsJ
c3BfZGF0YS0+b3RwX3RlbXAwID0gbnZtZW1fY2VsbF9yZWFkKGNlbGwsICZvdHBfbCk7DQo+ID4g
Kwludm1lbV9jZWxsX3B1dChjZWxsKTsNCj4gPiArDQo+ID4gKwlpZiAoKnNwX2RhdGEtPm90cF90
ZW1wMCA9PSAwKQ0KPiA+ICsJCSpzcF9kYXRhLT5vdHBfdGVtcDAgPSBURU1QX09UUF9CQVNFOw0K
PiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBU
aGVyZSBpcyBhIHRoZXJtYWwgc2Vuc29yIGluc3RhbmNlIGZvciBTdW5wbHVzIFNvYw0KPiA+ICsg
KiBUX0NPREUgaXMgdGhlIEFEQyBvZiB0aGUgdGhlcm1hbCBzZW5zb3INCj4gPiArICogVF9DT0RF
IDogMTEgZGlnaXRzIGluIHRvdGFsDQo+ID4gKyAqIFdoZW4gcmVtYW51ZmFjdHVyaW5nLCB0aGUg
MzUgZGVncmVlIFRfQ09ERSB3aWxsIGJlIHJlYWQgYW5kIHN0b3JlZCBpbiBudmNlbGwuDQo+ID4g
KyAqIG90cF90ZW1wMCBpcyB0aGUgMzUgZGVncmVlIFRfQ09ERSBvYnRhaW5lZCBmcm9tIG52Y2Vs
bA0KPiA+ICsgKiBUaGUgZnVuY3Rpb24gd2lsbCBnZXQgMzUgZGVncmVlIFRfQ09ERSBmb3IgdGhl
cm1hbCBjYWxpYnJhdGlvbi4NCj4gPiArICogVEVNUF9SQVRFIGlzIHRoZSBTdW5wbHVzIHRoZXJt
YWwgdGVtcGVyYXR1cmUgc2xvcGUuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArc3RhdGljIGludCBz
cF90aGVybWFsX2dldF9zZW5zb3JfdGVtcCh2b2lkICpkYXRhLCBpbnQgKnRlbXApIHsNCj4gPiAr
CXN0cnVjdCBzcF90aGVybWFsX2RhdGEgKnNwX2RhdGEgPSBkYXRhOw0KPiA+ICsJaW50IHRfY29k
ZTsNCj4gPiArDQo+ID4gKwl0X2NvZGUgPSByZWFkbChzcF9kYXRhLT5yZWdzICsgU1BfVEhFUk1B
TF9TVFMwX1JFRyk7DQo+ID4gKwl0X2NvZGUgPSBGSUVMRF9HRVQoU1BfVEhFUk1BTF9NQVNLLCB0
X2NvZGUpOw0KPiA+ICsJKnRlbXAgPSAoKCpzcF9kYXRhLT5vdHBfdGVtcDAgLSB0X2NvZGUpICog
MTAwMDAgLyBURU1QX1JBVEUpICsgVEVNUF9CQVNFOw0KPiA+ICsJKnRlbXAgKj0gMTA7DQo+ID4g
KwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCB0aGVy
bWFsX3pvbmVfb2ZfZGV2aWNlX29wcyBzcF9vZl90aGVybWFsX29wcyA9IHsNCj4gDQo+IHN0cnVj
dCB0aGVybWFsX3pvbmVfZGV2aWNlX29wcyAuLi4NCj4gDQo+IA0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjIwODA0MjI0MzQ5LjE5MjY3NTItMS1kYW5pZWwubGV6Y2Fub0BsaW5leHAu
b3JnDQo+IA0KPiANCj4gDQo+IA0KPiANCj4gLS0NCj4gPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+
IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiANCj4g
Rm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZh
Y2Vib29rIHwgPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+DQo+IFR3aXR0ZXIgfCA8
aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZw0K
