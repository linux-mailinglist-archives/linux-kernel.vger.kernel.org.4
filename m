Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191F2615C83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKBGy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKBGyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:54:25 -0400
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEEF25EB6;
        Tue,  1 Nov 2022 23:54:20 -0700 (PDT)
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 02 Nov 2022 14:54:18 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 2A26sG9M042974;
        Wed, 2 Nov 2022 14:54:16 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from CSBMAIL1.internal.ite.com.tw (192.168.65.58) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.14; Wed, 2 Nov 2022 14:54:17 +0800
Received: from CSBMAIL1.internal.ite.com.tw ([fe80::dd22:b444:859b:61c7]) by
 CSBMAIL1.internal.ite.com.tw ([fe80::dd22:b444:859b:61c7%18]) with mapi id
 15.01.2176.014; Wed, 2 Nov 2022 14:54:17 +0800
From:   <allen.chen@ite.com.tw>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <treapking@chromium.org>, <Jau-Chih.Tseng@ite.com.tw>,
        <Hermes.Wu@ite.com.tw>, <Kenneth.Hung@ite.com.tw>,
        <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Thread-Topic: [PATCH v6 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Thread-Index: AQHY6nDorSjdzmskUUWkM7FpU3Wft64rCzsw
Date:   Wed, 2 Nov 2022 06:54:17 +0000
Message-ID: <18659f5a5b2c4fd7b76731836aeb713d@ite.com.tw>
References: <20221027030155.59238-1-allen.chen@ite.com.tw>
 <20221027030155.59238-2-allen.chen@ite.com.tw>
 <d6f14e09-0c24-e19a-0951-bb3ca2219e79@linaro.org>
In-Reply-To: <d6f14e09-0c24-e19a-0951-bb3ca2219e79@linaro.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.70.46]
x-tm-snts-smtp: 7143E6E1BFEC61F7C88593D80B7E457DAF9E4169CD17B876763D7280031D059E2002:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: mse.ite.com.tw 2A26sG9M042974
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aGkNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4gDQpTZW50OiBGcmlkYXksIE9jdG9i
ZXIgMjgsIDIwMjIgOTo1OSBBTQ0KVG86IEFsbGVuIENoZW4gKOmZs+afj+WuhykgPGFsbGVuLmNo
ZW5AaXRlLmNvbS50dz4NCkNjOiBQaW4tWWVuIExpbiA8dHJlYXBraW5nQGNocm9taXVtLm9yZz47
IEphdS1DaGloIFRzZW5nICjmm77mmK3mmbopIDxKYXUtQ2hpaC5Uc2VuZ0BpdGUuY29tLnR3Pjsg
SGVybWVzIFd1ICjlkLPkvbPlro8pIDxIZXJtZXMuV3VAaXRlLmNvbS50dz47IEtlbm5ldGggSHVu
ZyAo5rSq5a625YCrKSA8S2VubmV0aC5IdW5nQGl0ZS5jb20udHc+OyBBbmRyemVqIEhhamRhIDxh
bmRyemVqLmhhamRhQGludGVsLmNvbT47IE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxp
YnJlLmNvbT47IFJvYmVydCBGb3NzIDxyb2JlcnQuZm9zc0BsaW5hcm8ub3JnPjsgTGF1cmVudCBQ
aW5jaGFydCA8TGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPjsgSm9uYXMgS2FybG1h
biA8am9uYXNAa3dpYm9vLnNlPjsgSmVybmVqIFNrcmFiZWMgPGplcm5lai5za3JhYmVjQGdtYWls
LmNvbT47IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT47IERhbmllbCBWZXR0ZXIgPGRh
bmllbEBmZndsbC5jaD47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBvcGVuIGxp
c3Q6RFJNIERSSVZFUlMgPGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBvcGVuIGxp
c3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMS8yXSBkdC1iaW5kaW5nczogaXQ2NTA1
OiBhZGQgcHJvcGVydGllcyB0byByZXN0cmljdCBvdXRwdXQgYmFuZHdpZHRoDQoNCk9uIDI2LzEw
LzIwMjIgMjM6MDEsIGFsbGVuIHdyb3RlOg0KPiBGcm9tOiBhbGxlbiBjaGVuIDxhbGxlbi5jaGVu
QGl0ZS5jb20udHc+DQo+IA0KPiBBZGQgcHJvcGVydGllcyB0byByZXN0cmljdCBkcCBvdXRwdXQg
ZGF0YS1sYW5lcyBhbmQgY2xvY2suDQoNClRoaXMgaXMgYSBmcmllbmRseSByZW1pbmRlciBkdXJp
bmcgdGhlIHJldmlldyBwcm9jZXNzLg0KDQpJdCBzZWVtcyBteSBwcmV2aW91cyBjb21tZW50cyB3
ZXJlIG5vdCBmdWxseSBhZGRyZXNzZWQuIE1heWJlIG15IGZlZWRiYWNrIGdvdCBsb3N0IGJldHdl
ZW4gdGhlIHF1b3RlcywgbWF5YmUgeW91IGp1c3QgZm9yZ290IHRvIGFwcGx5IGl0Lg0KUGxlYXNl
IGdvIGJhY2sgdG8gdGhlIHByZXZpb3VzIGRpc2N1c3Npb24gYW5kIGVpdGhlciBpbXBsZW1lbnQg
YWxsIHJlcXVlc3RlZCBjaGFuZ2VzIG9yIGtlZXAgZGlzY3Vzc2luZyB0aGVtLg0KDQpUaGFuayB5
b3UuDQoNCj09PiBJIGFtIHNvcnJ5IEkgZGlkbid0IGZpbmQgdGhlIG1pc3NpbmcgYWR2aWNlIHlv
dSBzYWlkLiBDb3VsZCB5b3UgZXhwbGFpbiBpdCBhZ2Fpbj8NCg0KUm9iIGFza2VkIC0gQ29tbWl0
IG1zZyBzaG91bGQgZXhwbGFpbiByZWFzb24gZm9yIGJyZWFraW5nIHVzZXJzLg0KDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBQaW4tWWVuIExpbiA8dHJlYXBraW5nQGNocm9taXVtLm9yZz4NCj4gU2ln
bmVkLW9mZi1ieTogQWxsZW4gQ2hlbiA8YWxsZW4uY2hlbkBpdGUuY29tLnR3Pg0KPiAtLS0NCj4g
IC4uLi9iaW5kaW5ncy9kaXNwbGF5L2JyaWRnZS9pdGUsaXQ2NTA1LnlhbWwgICB8IDY4ICsrKysr
KysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCANCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9icmlkZ2UvaXRlLGl0NjUwNS55YW1sIA0KPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2JyaWRnZS9pdGUsaXQ2NTA1LnlhbWwN
Cj4gaW5kZXggODMzZDExYjIzMDNhNy4uYjE2YTlkOTEyN2RkYiAxMDA2NDQNCj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2l0ZSxpdDY1MDUu
eWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9i
cmlkZ2UvaXRlLGl0NjUwNS55YW1sDQo+IEBAIC01Miw5ICs1Miw0OSBAQCBwcm9wZXJ0aWVzOg0K
PiAgICAgIG1heEl0ZW1zOiAxDQo+ICAgICAgZGVzY3JpcHRpb246IGV4dGNvbiBzcGVjaWZpZXIg
Zm9yIHRoZSBQb3dlciBEZWxpdmVyeQ0KPiAgDQo+IC0gIHBvcnQ6DQo+IC0gICAgJHJlZjogL3Nj
aGVtYXMvZ3JhcGgueWFtbCMvcHJvcGVydGllcy9wb3J0DQo+IC0gICAgZGVzY3JpcHRpb246IEEg
cG9ydCBub2RlIHBvaW50aW5nIHRvIERQSSBob3N0IHBvcnQgbm9kZQ0KPiArICBwb3J0czoNCj4g
KyAgICAkcmVmOiAvc2NoZW1hcy9ncmFwaC55YW1sIy9wcm9wZXJ0aWVzL3BvcnRzDQo+ICsNCj4g
KyAgICBwcm9wZXJ0aWVzOg0KPiArICAgICAgcG9ydEAwOg0KPiArICAgICAgICAkcmVmOiAvc2No
ZW1hcy9ncmFwaC55YW1sIy8kZGVmcy9wb3J0LWJhc2UNCj4gKyAgICAgICAgdW5ldmFsdWF0ZWRQ
cm9wZXJ0aWVzOiBmYWxzZQ0KPiArICAgICAgICBkZXNjcmlwdGlvbjogQSBwb3J0IG5vZGUgcG9p
bnRpbmcgdG8gRFBJIGhvc3QgcG9ydCBub2RlDQo+ICsNCj4gKyAgICAgICAgcHJvcGVydGllczoN
Cj4gKyAgICAgICAgICBlbmRwb2ludDoNCj4gKyAgICAgICAgICAgICRyZWY6IC9zY2hlbWFzL2dy
YXBoLnlhbWwjLyRkZWZzL2VuZHBvaW50LWJhc2UNCj4gKyAgICAgICAgICAgIHVuZXZhbHVhdGVk
UHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArICAgICAgICAgICAgcHJvcGVydGllczoNCj4gKyAg
ICAgICAgICAgICAgbGluay1mcmVxdWVuY2llczoNCj4gKyAgICAgICAgICAgICAgICBtaW5JdGVt
czogMQ0KPiArICAgICAgICAgICAgICAgIG1heEl0ZW1zOiAxDQo+ICsgICAgICAgICAgICAgICAg
ZGVzY3JpcHRpb246IEFsbG93ZWQgbWF4IGxpbmsgZnJlcXVlbmNpZXMgaW4gSHoNCj4gKw0KPiAr
ICAgICAgcG9ydEAxOg0KPiArICAgICAgICAkcmVmOiAvc2NoZW1hcy9ncmFwaC55YW1sIy8kZGVm
cy9wb3J0LWJhc2UNCj4gKyAgICAgICAgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiAr
ICAgICAgICBkZXNjcmlwdGlvbjogVmlkZW8gcG9ydCBmb3IgRFAgb3V0cHV0DQo+ICsNCj4gKyAg
ICAgICAgcHJvcGVydGllczoNCj4gKyAgICAgICAgICBlbmRwb2ludDoNCj4gKyAgICAgICAgICAg
ICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlhbWwjLyRkZWZzL2VuZHBvaW50LWJhc2UNCj4gKyAgICAg
ICAgICAgIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArICAgICAgICAgICAg
cHJvcGVydGllczoNCj4gKyAgICAgICAgICAgICAgZGF0YS1sYW5lczoNCj4gKyAgICAgICAgICAg
ICAgICBtaW5JdGVtczogMQ0KPiArICAgICAgICAgICAgICAgIHVuaXF1ZUl0ZW1zOiB0cnVlDQo+
ICsgICAgICAgICAgICAgICAgaXRlbXM6DQo+ICsgICAgICAgICAgICAgICAgICAtIGVudW06IFsg
MCwgMSBdDQo+ICsgICAgICAgICAgICAgICAgICAtIGNvbnN0OiAxDQo+ICsgICAgICAgICAgICAg
ICAgICAtIGNvbnN0OiAyDQo+ICsgICAgICAgICAgICAgICAgICAtIGNvbnN0OiAzDQo+ICsNCg0K
VGhpcyBsb29rcyBvay4NCg0KQmVzdCByZWdhcmRzLA0KS3J6eXN6dG9mDQoNCg==
