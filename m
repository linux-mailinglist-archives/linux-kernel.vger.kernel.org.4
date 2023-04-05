Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E44C6D7B22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbjDELWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbjDELWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:22:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24034200
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:21:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 335BLYhx109697;
        Wed, 5 Apr 2023 06:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680693694;
        bh=ZYZtDM+EnT6iQgi0D6tsE86c+r8ALNuoRvgk8Gg2Le8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=JIK7zvW2PMmaukF3hUSd+4q4zZ/tEv0Doj+5JdUdJGKH2DS8M5hXfRqawESTBZ+Pp
         8abdy2sqZghwua/PdapfWnD6awLzw+rLQ6Mtsy+pfmZSRNLsgjR4gEJ8lo15cW1fsu
         YbteWTU6zGoWbAOMSbEru5Q6YkhFNE1P0kc0VLAs=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 335BLX1R082210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Apr 2023 06:21:34 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 5
 Apr 2023 06:21:33 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.016; Wed, 5 Apr 2023 06:21:33 -0500
From:   "Ding, Shenghao" <shenghao-ding@ti.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
CC:     "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "Shenghao Ding" <13916275206@139.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: RE: [EXTERNAL] Re: [PATCH v10] ASoC: tas2781: Add tas2781 driver
Thread-Topic: [EXTERNAL] Re: [PATCH v10] ASoC: tas2781: Add tas2781 driver
Thread-Index: AQHZYv5dO/gdHn+1qke4qmD6peEJfK8UJ1NQgAGI0ACABulGsA==
Date:   Wed, 5 Apr 2023 11:21:33 +0000
Message-ID: <bbae9e35f2bf4cbcbc78f852041e4b2e@ti.com>
References: <20230329100107.8181-1-13916275206@139.com>
 <8d0d0478-1e45-ea52-f1b7-910b747d6282@linux.intel.com>
 <7a0cfa60e2a244168edd49c3d2f6a2bd@ti.com>
 <458d7c2f-bcee-9ec3-e955-9661a06a3349@wanadoo.fr>
In-Reply-To: <458d7c2f-bcee-9ec3-e955-9661a06a3349@wanadoo.fr>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.160.107]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm90aA0KSSB3cm90ZSBhIHRlc3QgY29kZSB0byB2ZXJpZnkgdGhlIGJlMzJfdG9fY3B1ICYg
YmUzMl90b19jcHVwLA0Kc3RhdGljIGludCBfX2luaXQgbGttX2luaXQodm9pZCkNCnsNCgljaGFy
IHRlc3RfYnVmW109ezB4MTIsIDB4MzQsIDB4YWIsIDB4YmMsIDB4NTYsIDB4NzgsIDB4ZWZ9Ow0K
CXVuc2lnbmVkIGludCAqaywgcCwgcTsNCglpbnQgaTsNCg0KCXByaW50aygiSGVsbG8sIFNoYW5n
aGFpIVxuIik7DQoNCglmb3IgKGkgPSAwOyBpIDwgNDsgaSArKykgew0KCQlrID0gKHVuc2lnbmVk
IGludCAqKSZ0ZXN0X2J1ZltpXTsNCgkJcCA9IGJlMzJfdG9fY3B1cCgoX19iZTMyICopayk7DQoJ
CXEgPSBiZTMyX3RvX2NwdSh0ZXN0X2J1ZltpXSk7DQoJCXByaW50aygiJWQ6ICprID0gMHglMDh4
IHAgPSAweCUwOHggcSA9IDB4JTA4eCAlbGRcbiIsDQoJCQlpLCAqaywgcCwgcSwgc2l6ZW9mKHVu
c2lnbmVkIGludCkpOw0KCX0NCglyZXR1cm4gMDsNCn0NClRoZSBvdXRwdXQgaXM6DQpbIDkxMDku
NzIyNTQ4XSBIZWxsbywgU2hhbmdoYWkhDQpbIDkxMDkuNzI2Mjg3XSAwOiAqayA9IDB4YmNhYjM0
MTIgcCA9IDB4MTIzNGFiYmMgcSA9IDB4MTIwMDAwMDAgNA0KWyA5MTA5LjcyNzY2NV0gMTogKmsg
PSAweDU2YmNhYjM0IHAgPSAweDM0YWJiYzU2IHEgPSAweDM0MDAwMDAwIDQNClsgOTEwOS43Mjg1
NTNdIDI6ICprID0gMHg3ODU2YmNhYiBwID0gMHhhYmJjNTY3OCBxID0gMHhhYmZmZmZmZiA0DQpb
IDkxMDkuNzI5MzA4XSAzOiAqayA9IDB4ZWY3ODU2YmMgcCA9IDB4YmM1Njc4ZWYgcSA9IDB4YmNm
ZmZmZmYgNA0KQXBwYXJlbnRseSwgYmUzMl90b19jcHVwJ3Mgb3V0cHV0IGlzIHdoYXQgSSBleHBl
Y3RlZC4NCkxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIGNvbW1lbnRzLiBUaGFua3MuDQoNCkJSDQpT
aGVuZ2hhbyBEaW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0b3Bo
ZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4gDQpTZW50OiBTYXR1cmRh
eSwgQXByaWwgMSwgMjAyMyA0OjQxIEFNDQpUbzogRGluZywgU2hlbmdoYW8gPHNoZW5naGFvLWRp
bmdAdGkuY29tPjsgQW1hZGV1c3ogU2xhd2luc2tpIDxhbWFkZXVzenguc2xhd2luc2tpQGxpbnV4
LmludGVsLmNvbT47IFNoZW5naGFvIERpbmcgPDEzOTE2Mjc1MjA2QDEzOS5jb20+OyBicm9vbmll
QGtlcm5lbC5vcmc7IGxnaXJkd29vZEBnbWFpbC5jb207IHBlcmV4QHBlcmV4LmN6OyBwaWVycmUt
bG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb20NCkNjOiBMdSwgS2V2aW4gPGtldmluLWx1QHRp
LmNvbT47IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgWHUsIEJhb2p1biA8eDEwNzcwMTJAdGkuY29tPjsgR3VwdGEsIFBlZXl1c2ggPHBl
ZXl1c2hAdGkuY29tPjsgTmF2YWRhIEthbnlhbmEsIE11a3VuZCA8bmF2YWRhQHRpLmNvbT4NClN1
YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MTBdIEFTb0M6IHRhczI3ODE6IEFkZCB0YXMy
NzgxIGRyaXZlcg0KDQpMZSAzMS8wMy8yMDIzIMOgIDA0OjE5LCBEaW5nLCBTaGVuZ2hhbyBhIMOp
Y3JpdMKgOg0KPiBIaSBBbWFkZXVzeiBTxYJhd2nFhHNraQ0KPiBUaGFua3MgZm9yIHlvdXIgY29t
bWVudC4NCj4gQW5zd2VyIGlubGluZS4NCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEFtYWRldXN6IFPFgmF3acWEc2tpIDxhbWFkZXVzenguc2xhd2luc2tpQGxpbnV4
LmludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDMwLCAyMDIzIDc6NTQgUE0NCj4g
VG86IFNoZW5naGFvIERpbmcgPDEzOTE2Mjc1MjA2QDEzOS5jb20+OyBicm9vbmllQGtlcm5lbC5v
cmc7IA0KPiBsZ2lyZHdvb2RAZ21haWwuY29tOyBwZXJleEBwZXJleC5jejsgDQo+IHBpZXJyZS1s
b3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbQ0KPiBDYzogTHUsIEtldmluIDxrZXZpbi1sdUB0
aS5jb20+OyBEaW5nLCBTaGVuZ2hhbyANCj4gPHNoZW5naGFvLWRpbmdAdGkuY29tPjsgYWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnOyANCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
WHUsIEJhb2p1biA8eDEwNzcwMTJAdGkuY29tPjsgR3VwdGEsIA0KPiBQZWV5dXNoIDxwZWV5dXNo
QHRpLmNvbT47IE5hdmFkYSBLYW55YW5hLCBNdWt1bmQgPG5hdmFkYUB0aS5jb20+DQo+IFN1Ympl
Y3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MTBdIEFTb0M6IHRhczI3ODE6IEFkZCB0YXMyNzgx
IGRyaXZlcg0KPiANCj4gT24gMy8yOS8yMDIzIDEyOjAxIFBNLCBTaGVuZ2hhbyBEaW5nIHdyb3Rl
Og0KPj4gQ3JlYXRlIHRhczI3ODEgZHJpdmVyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoZW5n
aGFvIERpbmcgPDEzOTE2Mjc1MjA2QDEzOS5jb20+DQo+Pg0KPj4gLS0tDQo+PiBDaGFuZ2VzIGlu
IHYxMDoNCj4+ICAgIC0gdXNpbmcgYmUxNl90b19jcHUgYW5kIGJlMzJfdG9fY3B1IGluc3RlYWQg
b2YgU01TX0hUT05TIGFuZCBTTVNfSFRPTkwNCj4+ICAgIC0gb3B0aW1pemUgYW5kIHJlZHVjZSB0
aGUgYm91bmRhcnkgY2hlY2tzDQo+PiAgICAtIEFkZCBjb21tZW50cyBvbiBzb21lIGttZW1kdXAg
aW5zdGVhZCBvZiBremFsbG9jK21lbWNweQ0KPj4gICAgQ2hhbmdlcyB0byBiZSBjb21taXR0ZWQ6
DQo+PiAJbW9kaWZpZWQ6ICAgc291bmQvc29jL2NvZGVjcy9LY29uZmlnDQo+PiAJbW9kaWZpZWQ6
ICAgc291bmQvc29jL2NvZGVjcy9NYWtlZmlsZQ0KPj4gCW5ldyBmaWxlOiAgIHNvdW5kL3NvYy9j
b2RlY3MvdGFzMjc4MS1kc3AuYw0KPj4gCW5ldyBmaWxlOiAgIHNvdW5kL3NvYy9jb2RlY3MvdGFz
Mjc4MS1kc3AuaA0KPj4gCW5ldyBmaWxlOiAgIHNvdW5kL3NvYy9jb2RlY3MvdGFzMjc4MS1pMmMu
Yw0KPj4gCW5ldyBmaWxlOiAgIHNvdW5kL3NvYy9jb2RlY3MvdGFzMjc4MS5oDQo+PiAtLS0NCj4g
DQo+IC4uLg0KPiANCj4+ICsNCj4+ICtzdGF0aWMgaW50IGZ3X3BhcnNlX2Jsb2NrX2RhdGFfa2Vy
bmVsKHN0cnVjdCB0YXNkZXZpY2VfZncgKnRhc19mbXcsDQo+PiArCXN0cnVjdCB0YXNkZXZfYmxr
ICpibG9jaywgY29uc3Qgc3RydWN0IGZpcm13YXJlICpmbXcsIGludCBvZmZzZXQpIHsNCj4+ICsJ
Y29uc3QgdW5zaWduZWQgY2hhciAqZGF0YSA9IGZtdy0+ZGF0YTsNCj4+ICsNCj4+ICsJaWYgKG9m
ZnNldCArIDE2ID4gZm13LT5zaXplKSB7DQo+PiArCQlkZXZfZXJyKHRhc19mbXctPmRldiwgIiVz
OiBGaWxlIFNpemUgZXJyb3JcbiIsIF9fZnVuY19fKTsNCj4+ICsJCW9mZnNldCA9IC1FSU5WQUw7
DQo+PiArCQlnb3RvIG91dDsNCj4+ICsJfQ0KPj4gKwlibG9jay0+dHlwZSA9IGJlMzJfdG9fY3B1
cCgoX19iZTMyICopJmRhdGFbb2Zmc2V0XSk7DQo+IA0KPiBXb3VsZG4ndCBqdXN0IGJlMzJfdG9f
Y3B1KGRhdGFbb2Zmc2V0XSkgd29yayBpbnN0ZWFkIG9mIGJlMzJfdG9fY3B1cD8NCj4gU2FtZSBp
biBvdGhlciBjYXNlcy4NCj4gW0RJTkddIGRhdGFbXSBpcyBhIGNoYXIgYXJyYXksIHRoZSBjb2Rl
IHdpbGwgY29udmVydCBkYXRhW29mZnNldF0sIA0KPiBkYXRhW29mZnNldCArIDFdLCBkYXRhW29m
ZnNldCArIDJdIGFuZCBkYXRhW29mZnNldCArIDNdIGludG8gaG9zdCBpbnN0ZWFkIG9mIGRhdGFb
b2Zmc2V0XSBvbmx5Lg0KPiANCg0KTm90IHN1cmUgdG8gZm9sbG93IHlvdS4NCklzbid0IGl0IHRo
ZSBwdXJwb3NlIG9mIGJlMzJfdG9fY3B1KCkgdG8gdGFrZSBhIDMyIGJpdHMgd29yZCwgaW4gb3Ro
ZXIgd29yZHMgNCB4IDggYml0cyBjaGFyLCBhbmQgc3dhcCB3aGF0IGlmIG5lZWRlZCAobGl0dGxl
IGVuZGlhbiBhcmNoKT8NCg0KSXQgZW5kcyB0byBfX3N3YWIzMigpIChbMV0gZm9yIHRoZSAiY29u
c3RhbnQiIGltcGxlbWVudGF0aW9uKQ0KDQoNCmJlMzJfdG9fY3B1cCgmcCkgZW5kcyB0byBfX3N3
YWIzMigqcCksIHdoaWNoIHJlYWxseSBsb29rcyB0byB0aGUgc2FtZSBhcyBiZTMyX3RvX2NwdShw
KS4NCg0KQ2FuIHlvdSBlbGFib3JhdGUgbW9yZT8NCg0KQ0oNCg0KDQpbMV06IA0KaHR0cHM6Ly9l
bGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMy1yYzMvc291cmNlL2luY2x1ZGUvdWFwaS9saW51
eC9zd2FiLmgjTDE4DQoNCg==
