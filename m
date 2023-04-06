Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F936D9F52
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbjDFRzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjDFRzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:55:02 -0400
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F21D98;
        Thu,  6 Apr 2023 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680803661;
        bh=VUtclU05iz+qAtVIYSOzJKrYupq03p43xdcYaL99E5I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=pe6GL6K5c+OqOnqeCnf021hURFuqS7d5DM0ukzM9sXj+pwWBJmBoN0zfF22MWMGEO
         3Sr72hdUaGLLuFj+/GOhGrUdWkBU/UL3TLBaHrnbORZj1JETfbwSfQk/gcokcA80wC
         SIQ9k7rBbjJD7wLDrDY1PrUw3wbAdg2HGkHPaPKYOxYEutjzEfbjijJueCgKwLjk5W
         OJKxuxpxhC4ZFTXy63t9OFcYMb1ePFLfxva2D3mAyNNuOvCDNymmXePHUAdbv+DenZ
         MldudkLD0of+N73e8R2wekfydL4tMQQXAvNvFJgDBsLPBRJ7yxeWXyJ7UlyB6bp/d1
         KnWDVt4H03udg==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 3/3] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Thread-Topic: [PATCH V2 3/3] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Thread-Index: AQHZaJ93At1GnP2el0yoagNBg+3G/K8eWhSAgAAwTiA=
Date:   Thu, 6 Apr 2023 17:54:10 +0000
Message-ID: <a7fcfe695623491da96639079eb14c8f@dh-electronics.com>
References: <20230406154900.6423-1-cniedermaier@dh-electronics.com>
 <20230406154900.6423-3-cniedermaier@dh-electronics.com>
 <5478133e-7772-1db9-3473-1ec86fa2aae2@linaro.org>
In-Reply-To: <5478133e-7772-1db9-3473-1ec86fa2aae2@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSBbbWFpbHRvOmtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZ10NClNlbnQ6IFRodXJzZGF5LCBBcHJpbCA2LCAyMDIzIDY6NDAgUE0NCj4gT24gMDYv
MDQvMjAyMyAxNzo0OSwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4gQWRkIHN1cHBv
cnQgZm9yIE1hcmFudGVjIG1hdmVvIGJveC4gVGhlIHN5c3RlbSBpcyB1c2VkIHRvIGdldCBhDQo+
PiBzbWFydCBjb25udGVjdGlvbiB0byBhIGRvb3IgZHJpdmUuIEl0IGhhcyBVU0IsIFdpRmksIEJs
dWV0b290aCwNCj4+IFppZ2JlZSBhbmQgTkZDIGludGVyZmFjZXMuIFRoZSBjb3JlIG9mIHRoaXMg
c3lzdGVtIGlzIGEgc29sZGVyZWQNCj4+IGkuTVg2VUxMIERIQ09SIFNvTSBmcm9tIERIIGVsZWN0
cm9uaWNzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25p
ZWRlcm1haWVyQGRoLWVsZWN0cm9uaWNzLmNvbT4NCj4+IC0tLQ0KPj4gQ2M6IFJvYiBIZXJyaW5n
IDxyb2JoK2R0QGtlcm5lbC5vcmc+DQo+PiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6
dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPg0KPj4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9A
a2VybmVsLm9yZz4NCj4+IENjOiBMaSBZYW5nIDxsZW95YW5nLmxpQG54cC5jb20+DQo+PiBDYzog
TWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+PiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2
YW1AZGVueC5kZT4NCj4+IENjOiBOWFAgTGludXggVGVhbSA8bGludXgtaW14QG54cC5jb20+DQo+
PiBDYzoga2VybmVsQGRoLWVsZWN0cm9uaWNzLmNvbQ0KPj4gQ2M6IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnDQo+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPj4gVG86IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPj4gLS0tDQo+PiBWMjogLSBDb3Jy
ZWN0IHRoZSB2ZW5kb3IgcHJlZml4DQo+PiAgICAgLSBDaGFuZ2UgcGluY29uZmlnIG9mIFVzZXIg
YW5kIFJlc2V0IGJ1dHRvbg0KPj4gLS0tDQo+PiAgYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUg
ICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2dWxs
LWRoY29yLW1hdmVvLWJveC5kdHMgfCAzNjEgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+
ICAyIGZpbGVzIGNoYW5nZWQsIDM2MiBpbnNlcnRpb25zKCspDQo+PiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtZGhjb3ItbWF2ZW8tYm94LmR0cw0KPj4NCj4+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL01ha2VmaWxlDQo+PiBpbmRleCBhYThmYjRiN2NkY2MuLjU4ZDMzMzQxNjRlMiAxMDA2NDQN
Cj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlDQo+PiArKysgYi9hcmNoL2FybS9i
b290L2R0cy9NYWtlZmlsZQ0KPj4gQEAgLTc1MSw2ICs3NTEsNyBAQCBkdGItJChDT05GSUdfU09D
X0lNWDZVTCkgKz0gXA0KPj4gICAgICAgaW14NnVsbC1kaGNvbS1kcmMwMi5kdGIgXA0KPj4gICAg
ICAgaW14NnVsbC1kaGNvbS1wZGsyLmR0YiBcDQo+PiAgICAgICBpbXg2dWxsLWRoY29tLXBpY29p
dHguZHRiIFwNCj4+ICsgICAgIGlteDZ1bGwtZGhjb3ItbWF2ZW8tYm94LmR0YiBcDQo+PiAgICAg
ICBpbXg2dWxsLWpvemFjcC5kdGIgXA0KPj4gICAgICAgaW14NnVsbC1rb250cm9uLWJsLmR0YiBc
DQo+PiAgICAgICBpbXg2dWxsLW15aXItbXlzLTZ1bHgtZXZhbC5kdGIgXA0KPj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtZGhjb3ItbWF2ZW8tYm94LmR0cyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDZ1bGwtZGhjb3ItbWF2ZW8tYm94LmR0cw0KPj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uODNiYWNhYzE5OTMzDQo+PiAtLS0gL2Rl
di9udWxsDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWRoY29yLW1hdmVvLWJv
eC5kdHMNCj4+IEBAIC0wLDAgKzEsMzYxIEBADQo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAtb3ItbGF0ZXIgT1IgTUlUDQo+PiArLyoNCj4+ICsgKiBDb3B5cmlnaHQgKEMp
IDIwMjMgREggZWxlY3Ryb25pY3MgR21iSA0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyMyBNYXJh
bnRlYyBlbGVjdHJvbmljcyBHbWJIDQo+PiArICoNCj4+ICsgKiBESENPTSBpTVg2VUxMIHZhcmlh
bnQ6DQo+PiArICogREhDUi1pTVg2VUxMLUMwODAtUjA1MS1TUEktV0JULUktMDFMRw0KPj4gKyAq
IERIQ09SIFBDQiBudW1iZXI6IDU3OC0yMDAgb3IgbmV3ZXINCj4+ICsgKiBtYXZlbyBib3ggUENC
IG51bWJlcjogNTI1LTIwMCBvciBuZXdlcg0KPj4gKyAqLw0KPj4gKw0KPj4gKy9kdHMtdjEvOw0K
Pj4gKw0KPj4gKyNpbmNsdWRlICJpbXg2dWxsLWRoY29yLXNvbS5kdHNpIg0KPj4gKw0KPj4gKy8g
ew0KPj4gKyAgICAgbW9kZWwgPSAiREggZWxlY3Ryb25pY3MgaS5NWDZVTEwgREhDT1Igb24gbWF2
ZW8gYm94IjsNCj4+ICsgICAgIGNvbXBhdGlibGUgPSAibWFyYW50ZWMsaW14NnVsbC1kaGNvci1t
YXZlby1ib3giLCAiZGgsaW14NnVsbC1kaGNvci1zb20iLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICJmc2wsaW14NnVsbCI7DQo+PiArDQo+PiArICAgICBhbGlhc2VzIHsNCj4+ICsgICAgICAgICAg
ICAgL2RlbGV0ZS1wcm9wZXJ0eS8gbW1jMDsgLyogQXZvaWQgZG91YmxlIGRlZmluaXRpb25zICov
DQo+IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgaXQuIFdoYXQgaXMgImRvdWJsZSBkZWZpbml0aW9u
IiBvZiBhbGlhc2VzPw0KDQpPdGhlcndpc2UgSSBlbmQgdXAgbGlrZSB0aGlzOg0KbW1jMCA9ICZ1
c2RoYzE7DQptbWMxID0gJnVzZGhjMjsNCm1tYzIgPSAmdXNkaGMyOw0KDQpJcyAiRW5zdXJlIHVu
aXF1ZSBhbGxvY2F0aW9uIiBhIGJldHRlciBjb21tZW50IGhlcmU/DQoNCj4gDQo+PiArICAgICAg
ICAgICAgIC9kZWxldGUtcHJvcGVydHkvIG1tYzE7DQo+PiArICAgICAgICAgICAgIG1tYzIgPSAm
dXNkaGMyOyAvKiBlTU1DIHNob3VsZCBiZSBtbWMyICovDQo+IA0KPiBXaHk/IEhvdyBpcyB0aGlz
IGxhYmVsZWQgb24gdGhlIGJvYXJkIChwaHlzaWNhbGx5IG9yIG9uIHNjaGVtYXRpY3MpPyBJZg0K
PiB5b3UgYW5zd2VyIGhlcmUgImZvciBib290aW5nIiwgdGhlbiB0aGUgYW5zd2VyIGlzIE5BSy4g
RG9uJ3QgYWRkDQo+IHNvZnR3YXJlIHBvbGljaWVzIHRvIERldmljZXRyZWUuDQoNClRoZSBuYW1l
IGluIHRoZSBzY2hlbWF0aWNzIGlzICJTRDIiLg0KDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
