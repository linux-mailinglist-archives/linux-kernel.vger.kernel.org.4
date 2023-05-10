Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E806FE14D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbjEJPMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbjEJPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:11:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70538268D;
        Wed, 10 May 2023 08:11:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34AE3owP005955;
        Wed, 10 May 2023 09:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683727430;
        bh=ht4Xp+j+Z/dsA3sLWnDQF8BKEuqV1FhA2y0sFH1RHBs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=Hxwzvt/iw0sSmAU7M4sNJbgUfPhy2AveemU93VNCu11exmwR7wOvs18wCsOn/OTnl
         iIkCJqv+KFgfmltpvLXCQDu+VZ+GU8tWGM78xAE8nwLA2m7WEERdQbmAWvvJwXW5Sd
         BZ2WIPCt0yHAd0QsZAFhCxEParABCFHp0bnrhvQE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34AE3onK001992
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 May 2023 09:03:50 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 May 2023 09:03:49 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 10 May 2023 09:03:49 -0500
From:   "Ding, Shenghao" <shenghao-ding@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "gentuser@gmail.com" <gentuser@gmail.com>,
        "Ryan_Chu@wistron.com" <Ryan_Chu@wistron.com>,
        "Sam_Wu@wistron.com" <Sam_Wu@wistron.com>,
        "Shenghao Ding" <13916275206@139.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781
 amplifier
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781
 amplifier
Thread-Index: AQHZgw2r46dnAmj+dEya5A38wB/fZK9Td3kQ
Date:   Wed, 10 May 2023 14:03:49 +0000
Message-ID: <c088d7dce83a45168d0dc25fee4a9e35@ti.com>
References: <20230508054512.719-1-13916275206@139.com>
 <ca9d45cf-8a84-4fbc-e1dd-c96eef36fe25@linaro.org>
In-Reply-To: <ca9d45cf-8a84-4fbc-e1dd-c96eef36fe25@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.160.143]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW5zd2VywrcgZW1iZWRlZCANCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4gDQpTZW50
OiBXZWRuZXNkYXksIE1heSAxMCwgMjAyMyAzOjA0IFBNDQpUbzogU2hlbmdoYW8gRGluZyA8MTM5
MTYyNzUyMDZAMTM5LmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgcm9iaCtkdEBrZXJu
ZWwub3JnOyBsZ2lyZHdvb2RAZ21haWwuY29tOyBwZXJleEBwZXJleC5jejsgcGllcnJlLWxvdWlz
LmJvc3NhcnRAbGludXguaW50ZWwuY29tDQpDYzogTHUsIEtldmluIDxrZXZpbi1sdUB0aS5jb20+
OyBEaW5nLCBTaGVuZ2hhbyA8c2hlbmdoYW8tZGluZ0B0aS5jb20+OyBhbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFh1LCBCYW9qdW4gPHgx
MDc3MDEyQHRpLmNvbT47IEd1cHRhLCBQZWV5dXNoIDxwZWV5dXNoQHRpLmNvbT47IE5hdmFkYSBL
YW55YW5hLCBNdWt1bmQgPG5hdmFkYUB0aS5jb20+OyBnZW50dXNlckBnbWFpbC5jb207IFJ5YW5f
Q2h1QHdpc3Ryb24uY29tOyBTYW1fV3VAd2lzdHJvbi5jb20NClN1YmplY3Q6IFtFWFRFUk5BTF0g
UmU6IFtQQVRDSCB2MiAyLzVdIEFTb0M6IGR0LWJpbmRpbmdzOiBBZGQgdGFzMjc4MSBhbXBsaWZp
ZXINCg0KT24gMDgvMDUvMjAyMyAwNzo0NSwgU2hlbmdoYW8gRGluZyB3cm90ZToNCj4gQ3JlYXRl
IHRhczI3ODEueWFtbCBmb3IgdGFzMjc4MSBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBT
aGVuZ2hhbyBEaW5nIDwxMzkxNjI3NTIwNkAxMzkuY29tPg0KPiANCj4gLS0tDQo+IENoYW5nZXMg
aW4gdjc6DQoNCllvdXIgc3ViamVjdCBzYXlzIGl0IGlzIHYyIGFuZCBwcmV2aW91c2x5IGl0IHdh
cyB2Ni4gTWFrZSBpdCBjb25zaXN0ZW50Lg0KW0RpbmddIHYyIGlzIHRoZSB2ZXJzaW9uIG5vIGZv
ciBhbGwgb2YgdGhlIHBhdGhlcywgaW4gZWFjaCBwYXRjaCB0aGVyZSBpcyBzZXBhcmF0ZWQgIHZl
cnNpb24sIHY3IGlzIHRoZSB2ZXJzaW9uIG51bWJlciBmb3IgeWFtbA0KPiAgLSBTdWJtaXQgdG9n
ZXRoZXIgd2l0aCB0YXMyNzgxIGNvZGVjIGRyaXZlciBjb2RlDQoNCkZpeCB5b3VyIHBhdGNoc2V0
IHRocmVhZGluZy4gSSBkb24ndCB0aGluayBpdCdzIHBvc3NpYmxlIHRvIGFwcGx5IHlvdXIgb25l
Lg0KDQo+ICAtIEFkZCBtb3JlIGRldGFpbCBkZXNjcmlwdGlvbiBmb3IgdGksYXVkaW8tc2xvdHMN
Cj4gIC0gS2VlcCBjb25zaXN0ZW50IGZvciAiSTJDIg0KPiAgLSByZW1vdmUgcmVzZXQtZ3Bpb3Mg
ZGVzY3JpcHRpb24NCj4gIC0gRm9yIHJlZywgZXhwcmVzcyBhcyBjb25zdHJhaW50cyBpbnN0ZWFk
DQo+ICAtIHJlbW92ZSB1bm5lY2Vzc2FyeSAnfCcNCj4gIENoYW5nZXMgdG8gYmUgY29tbWl0dGVk
Og0KPiAJbmV3IGZpbGU6ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5k
L3RpLHRhczI3ODEueWFtbA0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5k
L3RpLHRhczI3ODEueWFtbCB8IDkwIA0KPiArKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IA0KPiBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvdGksdGFzMjc4MS55YW1sDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3Rp
LHRhczI3ODEueWFtbCANCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291
bmQvdGksdGFzMjc4MS55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAw
MDAwMDAwMC4uOTZjMjU4NDg1NWQ0DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3RpLHRhczI3ODEueWFtbA0KPiBAQCAtMCww
ICsxLDkwIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9S
IEJTRC0yLUNsYXVzZSkgIyBDb3B5cmlnaHQgDQo+ICsoQykgMjAyMiAtIDIwMjMgVGV4YXMgSW5z
dHJ1bWVudHMgSW5jb3Jwb3JhdGVkICVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IGh0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3NvdW5kL3RpLHRhczI3ODEueWFtbCMNCj4gKyRzY2hlbWE6
IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiArDQo+ICt0
aXRsZTogVGV4YXMgSW5zdHJ1bWVudHMgVEFTMjc4MSBTbWFydEFNUA0KPiArDQo+ICttYWludGFp
bmVyczoNCj4gKyAgLSBTaGVuZ2hhbyBEaW5nIDxzaGVuZ2hhby1kaW5nQHRpLmNvbT4NCj4gKw0K
PiArZGVzY3JpcHRpb246DQo+ICsgIFRoZSBUQVMyNzgxIGlzIGEgbW9ubywgZGlnaXRhbCBpbnB1
dCBDbGFzcy1EIGF1ZGlvIGFtcGxpZmllcg0KPiArICBvcHRpbWl6ZWQgZm9yIGVmZmljaWVudGx5
IGRyaXZpbmcgaGlnaCBwZWFrIHBvd2VyIGludG8gc21hbGwNCj4gKyAgbG91ZHNwZWFrZXJzLiBJ
bnRlZ3JhdGVkIGFuIG9uLWNoaXAgRFNQIHN1cHBvcnRzIFRleGFzIEluc3RydW1lbnRzDQo+ICsg
IFNtYXJ0IEFtcCBzcGVha2VyIHByb3RlY3Rpb24gYWxnb3JpdGhtLiBUaGUgaW50ZWdyYXRlZCBz
cGVha2VyDQo+ICsgIHZvbHRhZ2UgYW5kIGN1cnJlbnQgc2Vuc2UgcHJvdmlkZXMgZm9yIHJlYWwg
dGltZQ0KPiArICBtb25pdG9yaW5nIG9mIGxvdWRzcGVha2VyIGJlaGF2aW9yLg0KPiArDQoNCnlv
dSBtaXNzIGFsbE9mIHdpdGggcmVmIHRvIHNhb3VuZC1kYWktY29tbW9uLg0KW0RpbmddIEFkZCBp
dCBpbiBuZXh0IHBhdGNoDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAg
IGVudW06DQo+ICsgICAgICAtIHRpLHRhczI3ODENCj4gKw0KPiArICByZWc6DQo+ICsgICAgZGVz
Y3JpcHRpb246IEkyQyBhZGRyZXNzIG9mIHRoZSBwcmltYXJ5IGRldmljZS4NCj4gKyAgICBpdGVt
czoNCj4gKyAgICAgIG1pbmltdW06IDB4MzgNCj4gKyAgICAgIG1heGltdW06IDB4M2YNCj4gKw0K
PiArICByZXNldC1ncGlvczoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIGludGVycnVw
dHM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICB0aSxhdWRpby1zbG90czoNCj4gKyAg
ICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgIE11bHRpcGxlIHRhczI3ODFzIGFnZ3JlZ2F0ZSBhcyBv
bmUgQXVkaW8gQW1wIHRvIHN1cHBvcnQNCj4gKyAgICAgIG11bHRpcGxlIGF1ZGlvIHNsb3RzDQo+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5
DQo+ICsgICAgbWF4SXRlbXM6IDQNCg0KWW91IHNhaWQgeW91IGNhbiBoYXZlIGhlcmUgdHdvIGFk
ZHJlc3Nlcy4gWW91IGRvbid0IGFsbG93IGl0LCB0ZXN0IGl0Lg0KDQpNaXNzaW5nIG1pbkl0ZW1z
LCBidXQuLi4NCg0KPiArICAgIGl0ZW1zOg0KPiArICAgICAgbWluaW11bTogMHgzOA0KPiArICAg
ICAgbWF4aW11bTogMHgzZg0KDQouLi4gU28gdGhlc2UgYXJlIGZpeGVkPyBObyBuZWVkIHRvIGVu
Y29kZSB0aGVtIGluIHN1Y2ggY2FzZS4uLg0KDQphbmQgYW55d2F5IGFjdHVhbGx5IEkgYWdyZWUg
d2l0aCBSb2IgaGVyZSAtIHRoZXNlIGFkZHJlc3NlcyBzaG91bGQgYmUgcHV0IGluIHJlZy4NCltE
SU5HXSBpZiBhbGwgdGhlIHB1dCBpbiByZWcsIHRoZSBpMmNfcHJvYmUgd2lsbCBiZSBjYWxsZWQg
c2V2ZXJhbCB0aW1lLiBUaGUgY29kZSBkb24gbm90IHdhbnQgdG8gcmVnaXN0ZXIgc2V2ZXJhbCBj
b2RlY3MsIGJ1dCBvbmUgY29kZWMgaW5jbHVkaW5nIHNldmVyYWwgdGFzMjc4MXMuDQoNCj4gKyAg
ICAgIGRlc2NyaXB0aW9uOg0KPiArICAgICAgICBJMkMgYWRkcmVzcyBvZiB0aGUgZGV2aWNlIGZv
ciBkaWZmZXJlbnQgYXVkaW8gc2xvdHMsDQo+ICsgICAgICAgIHVzZWxlc3MgaW4gbW9ubyBjYXNl
Lg0KPiArDQo+ICsgIHRpLGJyb2FkY2FzdC1hZGRyOg0KPiArICAgICRyZWY6IC9zY2hlbWFzL3R5
cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiArICAgIGRlc2NyaXB0aW9uOg0KPiArICAg
ICAgR2VuZXJpYyBJMkMgYWRkcmVzcyBmb3IgYWxsIHRoZSB0YXMyNzgxIGRldmljZXMgaW4NCj4g
KyAgICAgIHB1cnBvc2Ugb2YgSTJDIGJyb2FkY2FzdCBkdXJpbmcgdGhlIG11bHRpLWRldmljZQ0K
PiArICAgICAgd3JpdGVzLCB1c2VsZXNzIGluIG1vbm8gY2FzZS4NCg0KUHJvYmFibHkgeW91IGNh
biBmaWd1cmUgaXQgb3V0IGZyb20gcHJldmlvdXMgYWRkcmVzc2VzIGFuZCB0aGVyZSBpcyBubyBu
ZWVkIGZvciB0aGlzIHByb3BlcnR5Lg0KW0RpbmddIHRoaXMgYWRkcmVzcyBpcyB0aGUgY29tbW9u
IGFkZHJlc3MgZm9yIGFsbCB0aGUgdGFzMjc4MSwgaXQgY2FuIGJlIHVzZWQgZm9yIGRzcCBmaXJt
d2FyZSBkb3dubG9hZGluZyB0byBhbGwgdGhlIHRhczI3ODFzIGluIHBhcmFsbGVsLCB3aGljaCBj
YW4gc2F2ZSBtb3JlIGRvd25sb2FkaW5nIHRpbWUNCj4gKw0KPiArICAnI3NvdW5kLWRhaS1jZWxs
cyc6DQo+ICsgICAgY29uc3Q6IDENCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJs
ZQ0KPiArICAtIHJlZw0KPiArDQoNCg0KQmVzdCByZWdhcmRzLA0KS3J6eXN6dG9mDQoNCg==
