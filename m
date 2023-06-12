Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C835572D158
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjFLVDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbjFLVCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:02:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C9B525A;
        Mon, 12 Jun 2023 13:58:41 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35CKvhwW118862;
        Mon, 12 Jun 2023 15:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686603463;
        bh=aNX27vBqU1/SV7wA7tyJnUEpW86dsjDy4WXzEKyLldA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=GSOB2AYB0NIdNF/KtZa6qar1l/bVHJO4yWo8D3EG+O7UAnatxN4/OeFGd5TBIs3sV
         bGpMDOq96UNrtQLitb2uJVE84vlefR5Md4iTUVQkyQQKBAGSZws22t+KWd5WsEseRI
         xT+yjZFdYSANX3RvBnlEfbd28tf8l117PYcPKxi4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35CKvhUT022636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Jun 2023 15:57:43 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Jun 2023 15:57:42 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Mon, 12 Jun 2023 15:57:42 -0500
From:   "Ding, Shenghao" <shenghao-ding@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Shenghao Ding <13916275206@139.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "gentuser@gmail.com" <gentuser@gmail.com>,
        "Ryan_Chu@wistron.com" <Ryan_Chu@wistron.com>,
        "Sam_Wu@wistron.com" <Sam_Wu@wistron.com>,
        "tiwai@suse.de" <tiwai@suse.de>
Subject: Re: [EXTERNAL] Re: [PATCH v5 4/4] ASoC: dt-bindings: Add tas2781
 amplifier
Thread-Topic: [EXTERNAL] Re: [PATCH v5 4/4] ASoC: dt-bindings: Add tas2781
 amplifier
Thread-Index: AQHZm7lW7ypyLzuvek6mMwtVkdn8i6+HqZ0q
Date:   Mon, 12 Jun 2023 20:57:42 +0000
Message-ID: <303B184A-1A35-4049-97F5-90D17FE990DA@ti.com>
References: <20230610141821.576926-1-13916275206@139.com>,<95aca760-c17c-eb96-bcfb-85f20124812b@linaro.org>
In-Reply-To: <95aca760-c17c-eb96-bcfb-85f20124812b@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4g5ZyoIDIwMjPlubQ25pyIMTHml6XvvIwwMDozM++8jEtyenlzenRvZiBLb3psb3dza2kg
PGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4g5YaZ6YGT77yaDQo+IA0KPiDvu79PbiAx
MC8wNi8yMDIzIDE2OjE4LCBTaGVuZ2hhbyBEaW5nIHdyb3RlOg0KPj4gQ3JlYXRlIHRhczI3ODEu
eWFtbCBmb3IgdGFzMjc4MSBkcml2ZXIuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFNoZW5naGFv
IERpbmcgPDEzOTE2Mjc1MjA2QDEzOS5jb20+DQo+IA0KPiBXZSBrZWVwIHRlbGxpbmcgeW91IHRo
YXQgeW91ciBlbWFpbCB0aHJlYWRpbmcgaXMgYnJva2VuLiBJdCBzdGlsbCBpcw0KPiBtYWtlcyBy
ZXZpZXdlcnMgbGlmZSBtb3JlIGRpZmZpY3VsdC4gTWFpbnRhaW5lciBhcyB3ZWxsIGFzIGFwcGx5
aW5nIGlzDQo+IG5vdCBzdHJhaWdodGZvcndhcmQuDQo+IA0KPiBXaHkgdGhpcyBpcyBub3QgaW1w
cm92ZWQ/DQo+IA0KU29ycnkgZm9yIGNhdXNpbmcgZGlmZmljdWx0aWVzLiBXb3VsZCB5b3UgYmUg
c28ga2luZCBhbmQgdGVsbCBtZSBob3cgdG8gYXZvaWQgdGhyZWFkaW5nIGJyb2tlbj8gSSBnZXQg
dGhlIHRocmVhZGluZyBicm9rZW4gaXNzdWUgZXZlcnkgdGltZSwgYnV0IEkgcmVhbGx5IGhhdmUg
bm8gaWRlYSBvZiBob3cgdG8gZml4IGl0Lg0KPj4gDQo+PiAtLS0NCj4+IENoYW5nZXMgaW4gdjU6
DQo+PiAtIHJlbW92ZSB0aSxicm9hZGNhc3QtYWRkcg0KPj4gLSByZW1vdmUgYWRkcmVzcy1jZWxs
cw0KPj4gLSByZW1vdmUgc2l6ZS1jZWxscw0KPj4gLSBwdXQgY29tcGF0aWJsZSBpdGVtIGZpcnN0
IGluIHByb3BlcnRpZXMNCj4+IC0gY2hhbmdlIHRoZSBtYXhJdGVtcyBvZiByZWcgZnJvbSA0IHRv
IDgNCj4+IC0gcmVtb3ZlIHdoaXRlIHNwYWNlIGFyb3VuZCA8Pg0KPj4gLSBjb3JyZWN0IHRoZSBy
ZWcgZm9ybWF0IHRvIDwweDM4PiwgPDB4M2E+IGV0Yw0KPj4gLSByZW1vdmUgJ1x0JyBpbiB0aGUg
ZmlsZQ0KPj4gLSBjb3JyZWN0IGEgY29tbWVudCBpbiB0aGUgZXhhbXBsZQ0KPj4gLS0tDQo+PiAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC90aSx0YXMyNzgxLnlhbWwgfCA3MyArKysrKysr
KysrKysrKysrKysrDQo+PiAxIGZpbGUgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKQ0KPj4gY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC90
aSx0YXMyNzgxLnlhbWwNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb3VuZC90aSx0YXMyNzgxLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc291bmQvdGksdGFzMjc4MS55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi42MWRiMTRhMzk2MzANCj4+IC0tLSAvZGV2L251
bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC90aSx0
YXMyNzgxLnlhbWwNCj4+IEBAIC0wLDAgKzEsNzMgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICsjIENvcHlyaWdodCAo
QykgMjAyMiAtIDIwMjMgVGV4YXMgSW5zdHJ1bWVudHMgSW5jb3Jwb3JhdGVkDQo+PiArJVlBTUwg
MS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb3Vu
ZC90aSx0YXMyNzgxLnlhbWwjDQo+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21l
dGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0bGU6IFRleGFzIEluc3RydW1lbnRz
IFRBUzI3ODEgU21hcnRBTVANCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gU2hlbmdo
YW8gRGluZyA8c2hlbmdoYW8tZGluZ0B0aS5jb20+DQo+PiArDQo+PiArZGVzY3JpcHRpb246DQo+
PiArICBUaGUgVEFTMjc4MSBpcyBhIG1vbm8sIGRpZ2l0YWwgaW5wdXQgQ2xhc3MtRCBhdWRpbyBh
bXBsaWZpZXINCj4+ICsgIG9wdGltaXplZCBmb3IgZWZmaWNpZW50bHkgZHJpdmluZyBoaWdoIHBl
YWsgcG93ZXIgaW50byBzbWFsbA0KPj4gKyAgbG91ZHNwZWFrZXJzLiBJbnRlZ3JhdGVkIGFuIG9u
LWNoaXAgRFNQIHN1cHBvcnRzIFRleGFzIEluc3RydW1lbnRzDQo+PiArICBTbWFydCBBbXAgc3Bl
YWtlciBwcm90ZWN0aW9uIGFsZ29yaXRobS4gVGhlIGludGVncmF0ZWQgc3BlYWtlcg0KPj4gKyAg
dm9sdGFnZSBhbmQgY3VycmVudCBzZW5zZSBwcm92aWRlcyBmb3IgcmVhbCB0aW1lDQo+PiArICBt
b25pdG9yaW5nIG9mIGxvdWRzcGVha2VyIGJlaGF2aW9yLg0KPj4gKw0KPj4gK2FsbE9mOg0KPj4g
KyAgLSAkcmVmOiBkYWktY29tbW9uLnlhbWwjDQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsg
IGNvbXBhdGlibGU6DQo+PiArICAgIGVudW06DQo+PiArICAgICAgLSB0aSx0YXMyNzgxDQo+PiAr
DQo+PiArICByZWc6DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIEkyQyBhZGRyZXNz
LCBpbiBtdWx0aXBsZSB0YXMyNzgxcyBjYXNlLCBhbGwgdGhlIGkyYyBhZGRyZXNzDQo+PiArICAg
ICAgYWdncmVhdGUgYXMgb25lIEF1ZGlvIERldmljZSB0byBzdXBwb3J0IG11bHRpcGxlIGF1ZGlv
IHNsb3RzLg0KPj4gKyAgICBtYXhJdGVtczogOA0KPj4gKyAgICBpdGVtczoNCj4+ICsgICAgICBt
aW5pbXVtOiAweDM4DQo+PiArICAgICAgbWF4aW11bTogMHgzZg0KPiANCj4gSXQgZG9lcyBub3Qg
bG9vayBsaWtlIHlvdSB0ZXN0ZWQgdGhlIGJpbmRpbmdzLCBhdCBsZWFzdCBhZnRlciBxdWljaw0K
PiBsb29rLiBQbGVhc2UgcnVuIGBtYWtlIGR0X2JpbmRpbmdfY2hlY2tgIChzZWUNCj4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dyaXRpbmctc2NoZW1hLnJzdCBmb3IgaW5zdHJ1
Y3Rpb25zKS4NCj4gDQpLaW5kbHkgcG9pbnQgbXkgbWlzdGFrZSwgSSBydW4gdGhlIGNvbW1hbmRz
IGZyb20gdGhlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93cml0aW5nLXNjaGVt
YS5yc3QgYmVmb3JlIHN1Ym1pc3Npb24uDQpGb3IgZHRfYmluZGluZ19jaGVjaywgY29tbWFuZCBh
cyBmb2xsb3csIG5vIGlzc3VlIHJlcG9ydGVkLA0KbWFrZSBEVF9DSEVDS0VSX0ZMQUdTPS1tIE89
IE89YnVpbGRfZGlyL3g4NiBkdF9iaW5kaW5nX2NoZWNrIC1qICQoZXhwciAkKG5wcm9jKSAtIDEp
IDI+JjEgfCB0ZWUgJE9VVFBVVF9ESVIxLyRPVVRQVVRfRElSMi9kdF9iaW5kaW5nX2NoZWNrLmxv
Zw0K4oCm4oCm4oCm4oCm4oCmDQogIERURVggICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvdW5kL3NhbXN1bmcsdG0yLmV4YW1wbGUuZHRzDQogIERURVggICAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3RpLHRhczI3ODEuZXhhbXBsZS5kdHMNCiAg
RFRFWCAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvYW1sb2dpYyx0
OTAxNS5leGFtcGxlLmR0cw0K4oCm4oCm4oCm4oCm4oCmLi4NCiAgRFRDX0NISyBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvc2Ftc3VuZyx0bTIuZXhhbXBsZS5kdGINCiAg
RFRDX0NISyBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvdGksdGFzMjc4
MS5leGFtcGxlLmR0Yg0KICBEVENfQ0hLIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zb3VuZC9hbWxvZ2ljLHQ5MDE1LmV4YW1wbGUuZHRiDQrigKbigKbigKbigKbigKYuLg0KDQpB
cyB0byDigJxtYWtlIGR0YnNfY2hlY2t0ZXN04oCdLCBpdCBjYW7igJl0IHdvcmsgaW4gZGVmYXVs
dCBjb21waWxpbmcgc3lzdGVtKHg4NikgYXQgYWxsLiBJbiBvcmRlciB0byB0ZXN0IHRoZSBiaW5k
aW5ncywgaXQgd2FzIGludGVncmF0ZWQgaW50byB0aGUgQmVhZ2xlQm9uZUJsYWNrIGNvbXBpbGlu
ZyBzeXN0ZW0uDQpDb21tYW5kIGFzIGZvbGxvdzoNCm1ha2UgQVJDSD1hcm0gQ1JPU1NfQ09NUElM
RT1hcm0tbGludXgtZ251ZWFiaWhmLSBEVF9DSEVDS0VSX0ZMQUdTPS1tIEtDT05GSUdfQ09ORklH
PWNvbmZpZ19kaXIvYmJiX2R0X2NvbmZpZyBPPWJ1aWxkX2Rpci9kdCBkdGJzX2NoZWNrIC1qICQo
ZXhwciAkKG5wcm9jKSAtIDEpIDI+JjEgfCB0ZWUgYnVpbGRfZGlyL2R0L2R0YnNfY2hlY2subG9n
DQpPbmx5IHR3byBsaW5lcyBoYXZlIHNvbWV0aGluZyB0byBkbyB3aXRoIHRoZSB0YXMyNzgxIGZy
b20gZHRic19jaGVjaywgaXQgaXMgcGxhdGZvcm0gaXNzdWUsIG5vdCB0YXMyNzgxIGJpbmRpbmdz
DQogIERUQ19DSEsgYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LWV2bS5kdGINCiAgRFRDX0NISyBh
cmNoL2FybS9ib290L2R0cy9hbTMzNXgtZXZtc2suZHRiDQogIERUQ19DSEsgYXJjaC9hcm0vYm9v
dC9kdHMvYW0zMzV4LWd1YXJkaWFuLmR0Yg0KL3Vzci9sb2NhbC9zcmMvbGludXgtZHQvYXJjaC9h
cm0vYm9vdC9kdHMvYW0zM3h4LWw0LmR0c2k6MTQ2Ny41LTI4OiBXYXJuaW5nIChpbnRlcnJ1cHRz
X3Byb3BlcnR5KTogL29jcC9pbnRlcmNvbm5lY3RANDgwMDAwMDAvc2VnbWVudEAxMDAwMDAvdGFy
Z2V0LW1vZHVsZUA5YzAwMC9pMmNAMC90YXMyNzgxQDNhOiNpbnRlcnJ1cHQtY2VsbHM6IHNpemUg
aXMgKDQpLCBleHBlY3RlZCBtdWx0aXBsZSBvZiA4DQovdXNyL2xvY2FsL3NyYy9saW51eC1kdC9h
cmNoL2FybS9ib290L2R0cy9hbTMzeHgtbDQuZHRzaToxNDY3LjUtMjg6IFdhcm5pbmcgKGludGVy
cnVwdHNfcHJvcGVydHkpOiAvb2NwL2ludGVyY29ubmVjdEA0ODAwMDAwMC9zZWdtZW50QDEwMDAw
MC90YXJnZXQtbW9kdWxlQDljMDAwL2kyY0AwL3Rhc2RldmljZUAzYTojaW50ZXJydXB0LWNlbGxz
OiBzaXplIGlzICg0KSwgZXhwZWN0ZWQgbXVsdGlwbGUgb2YgOA0KL3Vzci9sb2NhbC9zcmMvbGlu
dXgtZHQvYnVpbGRfZGlyL2R0L2FyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1ib25lYmx1ZS5kdGI6
IC86IGZpeGVkcmVndWxhdG9yQDI6ICdhbnlPZicgY29uZGl0aW9uYWwgZmFpbA0KDQo+IFlvdSBt
aXNzIGhlcmUgbWluSXRlbXMuDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cj4gDQo=
