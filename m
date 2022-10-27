Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6676D60ED43
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiJ0BKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJ0BKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:10:03 -0400
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927614D1F;
        Wed, 26 Oct 2022 18:09:57 -0700 (PDT)
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 27 Oct 2022 09:09:54 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 29R19o33075527;
        Thu, 27 Oct 2022 09:09:50 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from CSBMAIL1.internal.ite.com.tw (192.168.65.58) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.14; Thu, 27 Oct 2022 09:09:49 +0800
Received: from CSBMAIL1.internal.ite.com.tw ([fe80::dd22:b444:859b:61c7]) by
 CSBMAIL1.internal.ite.com.tw ([fe80::dd22:b444:859b:61c7%18]) with mapi id
 15.01.2176.014; Thu, 27 Oct 2022 09:09:49 +0800
From:   <allen.chen@ite.com.tw>
To:     <robh@kernel.org>
CC:     <treapking@chromium.org>, <Jau-Chih.Tseng@ite.com.tw>,
        <Hermes.Wu@ite.com.tw>, <Kenneth.Hung@ite.com.tw>,
        <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <krzysztof.kozlowski+dt@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Thread-Topic: [PATCH v5 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Thread-Index: AQHY58b9JXyAtuOFo0e1NAYOP32Khq4hcNMg
Date:   Thu, 27 Oct 2022 01:09:49 +0000
Message-ID: <58b1b01c1f494c3e8a54890ad8a7cdb8@ite.com.tw>
References: <20221019093215.8204-1-allen.chen@ite.com.tw>
 <20221019093215.8204-2-allen.chen@ite.com.tw>
 <20221024163748.GA1874793-robh@kernel.org>
In-Reply-To: <20221024163748.GA1874793-robh@kernel.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.70.46]
x-tm-snts-smtp: F2AD3F7EDB6366E8473549C38F6788FD13AA418C777E49B61EB24EE2ED1897802002:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: mse.ite.com.tw 29R19o33075527
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgcm9iDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSb2IgSGVycmluZyA8
cm9iaEBrZXJuZWwub3JnPiANClNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjUsIDIwMjIgMTI6Mzgg
QU0NClRvOiBBbGxlbiBDaGVuICizr6xmpnQpIDxhbGxlbi5jaGVuQGl0ZS5jb20udHc+DQpDYzog
UGluLVllbiBMaW4gPHRyZWFwa2luZ0BjaHJvbWl1bS5vcmc+OyBKYXUtQ2hpaCBUc2VuZyAotL+s
TLS8KSA8SmF1LUNoaWguVHNlbmdAaXRlLmNvbS50dz47IEhlcm1lcyBXdSAop2Sozqe7KSA8SGVy
bWVzLld1QGl0ZS5jb20udHc+OyBLZW5uZXRoIEh1bmcgKKx4rmGt2ykgPEtlbm5ldGguSHVuZ0Bp
dGUuY29tLnR3PjsgQW5kcnplaiBIYWpkYSA8YW5kcnplai5oYWpkYUBpbnRlbC5jb20+OyBOZWls
IEFybXN0cm9uZyA8bmFybXN0cm9uZ0BiYXlsaWJyZS5jb20+OyBSb2JlcnQgRm9zcyA8cm9iZXJ0
LmZvc3NAbGluYXJvLm9yZz47IExhdXJlbnQgUGluY2hhcnQgPExhdXJlbnQucGluY2hhcnRAaWRl
YXNvbmJvYXJkLmNvbT47IEpvbmFzIEthcmxtYW4gPGpvbmFzQGt3aWJvby5zZT47IEplcm5laiBT
a3JhYmVjIDxqZXJuZWouc2tyYWJlY0BnbWFpbC5jb20+OyBEYXZpZCBBaXJsaWUgPGFpcmxpZWRA
bGludXguaWU+OyBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+OyBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBvcGVuIGxpc3Q6RFJN
IERSSVZFUlMgPGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBvcGVuIGxpc3Q6T1BF
TiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS8yXSBkdC1iaW5kaW5nczogaXQ2NTA1OiBhZGQg
cHJvcGVydGllcyB0byByZXN0cmljdCBvdXRwdXQgYmFuZHdpZHRoDQoNCk9uIFdlZCwgT2N0IDE5
LCAyMDIyIGF0IDA1OjMyOjEzUE0gKzA4MDAsIGFsbGVuIHdyb3RlOg0KPiBGcm9tOiBhbGxlbiBj
aGVuIDxhbGxlbi5jaGVuQGl0ZS5jb20udHc+DQo+IA0KPiBBZGQgcHJvcGVydGllcyB0byByZXN0
cmljdCBkcCBvdXRwdXQgZGF0YS1sYW5lcyBhbmQgY2xvY2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBQaW4tWWVuIExpbiA8dHJlYXBraW5nQGNocm9taXVtLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTog
QWxsZW4gQ2hlbiA8YWxsZW4uY2hlbkBpdGUuY29tLnR3Pg0KPiAtLS0NCj4gIC4uLi9iaW5kaW5n
cy9kaXNwbGF5L2JyaWRnZS9pdGUsaXQ2NTA1LnlhbWwgICB8IDg5ICsrKysrKysrKysrKysrKysr
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4MyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCANCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9icmlkZ2UvaXRlLGl0NjUwNS55YW1sIA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L2JyaWRnZS9pdGUsaXQ2NTA1LnlhbWwNCj4gaW5kZXggODMz
ZDExYjIzMDNhNy4uOGU2MDdiNjkyOWZjOSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2l0ZSxpdDY1MDUueWFtbA0KPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9icmlkZ2UvaXRlLGl0
NjUwNS55YW1sDQo+IEBAIC01Miw5ICs1Miw3MCBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgIG1heEl0
ZW1zOiAxDQo+ICAgICAgZGVzY3JpcHRpb246IGV4dGNvbiBzcGVjaWZpZXIgZm9yIHRoZSBQb3dl
ciBEZWxpdmVyeQ0KPiAgDQo+IC0gIHBvcnQ6DQo+IC0gICAgJHJlZjogL3NjaGVtYXMvZ3JhcGgu
eWFtbCMvcHJvcGVydGllcy9wb3J0DQo+IC0gICAgZGVzY3JpcHRpb246IEEgcG9ydCBub2RlIHBv
aW50aW5nIHRvIERQSSBob3N0IHBvcnQgbm9kZQ0KDQpObyBleGlzdGluZyB1c2VycyB5b3UgYXJl
IGJyZWFraW5nPyBUaGUgY29tbWl0IG1zZyBzaG91bGQgZXhwbGFpbi4NCg0KPT0+IFRoZXJlIGFy
ZSBubyBpdDY1MDUgdXNlcnMgaW4gY29tbXVuaXR5Lg0KPiArICBwb3J0czoNCj4gKyAgICAkcmVm
OiAvc2NoZW1hcy9ncmFwaC55YW1sIy9wcm9wZXJ0aWVzL3BvcnRzDQo+ICsNCj4gKyAgICBwcm9w
ZXJ0aWVzOg0KPiArICAgICAgcG9ydEAwOg0KPiArICAgICAgICAkcmVmOiAvc2NoZW1hcy9ncmFw
aC55YW1sIy8kZGVmcy9wb3J0LWJhc2UNCj4gKyAgICAgICAgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVz
OiBmYWxzZQ0KPiArICAgICAgICBkZXNjcmlwdGlvbjogQSBwb3J0IG5vZGUgcG9pbnRpbmcgdG8g
RFBJIGhvc3QgcG9ydCBub2RlDQo+ICsNCj4gKyAgICAgICAgcHJvcGVydGllczoNCj4gKyAgICAg
ICAgICBlbmRwb2ludDoNCj4gKyAgICAgICAgICAgICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlhbWwj
LyRkZWZzL2VuZHBvaW50LWJhc2UNCj4gKyAgICAgICAgICAgIHVuZXZhbHVhdGVkUHJvcGVydGll
czogZmFsc2UNCj4gKw0KPiArICAgICAgICAgICAgcHJvcGVydGllczoNCj4gKyAgICAgICAgICAg
ICAgbGluay1mcmVxdWVuY2llczoNCj4gKyAgICAgICAgICAgICAgICBtaW5JdGVtczogMQ0KPiAr
ICAgICAgICAgICAgICAgIG1heEl0ZW1zOiAxDQo+ICsgICAgICAgICAgICAgICAgZGVzY3JpcHRp
b246IEFsbG93ZWQgbWF4IGxpbmsgZnJlcXVlbmNpZXMgaW4gSHoNCj4gKw0KPiArICAgICAgcG9y
dEAxOg0KPiArICAgICAgICAkcmVmOiAvc2NoZW1hcy9ncmFwaC55YW1sIy8kZGVmcy9wb3J0LWJh
c2UNCj4gKyAgICAgICAgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiArICAgICAgICBk
ZXNjcmlwdGlvbjogVmlkZW8gcG9ydCBmb3IgRFAgb3V0cHV0DQo+ICsNCj4gKyAgICAgICAgcHJv
cGVydGllczoNCj4gKyAgICAgICAgICBlbmRwb2ludDoNCj4gKyAgICAgICAgICAgICRyZWY6IC9z
Y2hlbWFzL2dyYXBoLnlhbWwjLyRkZWZzL2VuZHBvaW50LWJhc2UNCj4gKyAgICAgICAgICAgIHVu
ZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArICAgICAgICAgICAgcHJvcGVydGll
czoNCj4gKyAgICAgICAgICAgICAgZGF0YS1sYW5lczoNCj4gKyAgICAgICAgICAgICAgICBvbmVP
ZjoNCj4gKyAgICAgICAgICAgICAgICAgIC0gbWluSXRlbXM6IDENCj4gKyAgICAgICAgICAgICAg
ICAgICAgbWF4SXRlbXM6IDENCj4gKyAgICAgICAgICAgICAgICAgICAgdW5pcXVlSXRlbXM6IHRy
dWUNCj4gKyAgICAgICAgICAgICAgICAgICAgaXRlbXM6DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgZW51bToNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIC0gMA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgLSAxDQo+ICsgICAgICAgICAgICAgICAgICAgIGRlc2NyaXB0aW9uOiBGb3Ig
b25lIGxhbmUgb3BlcmF0aW9uLg0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAtIG1pbkl0ZW1z
OiAyDQo+ICsgICAgICAgICAgICAgICAgICAgIG1heEl0ZW1zOiAyDQo+ICsgICAgICAgICAgICAg
ICAgICAgIHVuaXF1ZUl0ZW1zOiB0cnVlDQo+ICsgICAgICAgICAgICAgICAgICAgIGl0ZW1zOg0K
PiArICAgICAgICAgICAgICAgICAgICAgIGVudW06DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAtIDANCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIC0gMQ0KPiArICAgICAgICAgICAgICAg
ICAgICBkZXNjcmlwdGlvbjogRm9yIHR3byBsYW5lcyBvcGVyYXRpb24uDQo+ICsNCj4gKyAgICAg
ICAgICAgICAgICAgIC0gbWluSXRlbXM6IDQNCj4gKyAgICAgICAgICAgICAgICAgICAgbWF4SXRl
bXM6IDQNCj4gKyAgICAgICAgICAgICAgICAgICAgdW5pcXVlSXRlbXM6IHRydWUNCj4gKyAgICAg
ICAgICAgICAgICAgICAgaXRlbXM6DQo+ICsgICAgICAgICAgICAgICAgICAgICAgZW51bToNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgIC0gMA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
LSAxDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAtIDINCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgIC0gMw0KPiArICAgICAgICAgICAgICAgICAgICBkZXNjcmlwdGlvbjogRm9yIGZvdXIg
bGFuZXMgb3BlcmF0aW9uLg0KDQpJIHdvdWxkIGRvIGp1c3Q6DQoNCmRhdGEtbGFuZXM6DQogIG1p
bkl0ZW1zOiAxDQogIGl0ZW1zOg0KICAgIC0gZW51bTogWyAwLCAxIF0NCiAgICAtIGNvbnN0OiAx
DQogICAgLSBjb25zdDogMg0KICAgIC0gY29uc3Q6IDMNCg0KSXQgZG9lcyBhbGxvdyAzIGxhbmVz
LCBidXQgSSBkb24ndCB0aGluayB0aGF0J3MgYSBiaWcgZGVhbC4gV2hhdCBpdCBkb2VzIGRvZXNu
J3QgYWxsb3cgaXMgYW55IG9yZGVyIGFuZCB5b3VycyBkb2VzLg0KDQpSb2INCg==
