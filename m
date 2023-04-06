Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F1C6DA20F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbjDFT6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjDFT6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:58:46 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536D383D0;
        Thu,  6 Apr 2023 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680811052;
        bh=hIHZKMCNlD1nj8tlj6y6ab9ucYMc5iHFk+XQ3oEEOmg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ixn+X+rixKEeyGUXMD1SrI1W5wdniFZH1OTqrhIZMbvlhyprtrm+gfou01oEdR/oe
         mckiG0/lJB2phvh8GuaKBrj8LZZlrHJrQx0jb8gvXd5hRogpVM5gvggRNdmRMY1deY
         X8mWJXnFVz5D10mAvHQuqHXtLv0nRyXzpmhZue8TY5S0F8G8vv+KzfT14jy7nTTrUY
         kzEh8TtQql/1A5CZCKaKo6hC3AIJHVSuOFLvmQhIly9HOLl9/eAKCATGSyaKDOJxRf
         xQsuiDcTKEDu++R4VC7YaOFj97bp0qfiHL273g4UAEHDFND/dNnOeCw2FLHwcN+Ztl
         k4CXVM79quwNw==
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
Thread-Index: AQHZaJ93At1GnP2el0yoagNBg+3G/K8eWhSAgAAwTiD//+YUAIAAON0Q
Date:   Thu, 6 Apr 2023 19:57:22 +0000
Message-ID: <ff95314402a349a5a2998c1b5e2b13a2@dh-electronics.com>
References: <20230406154900.6423-1-cniedermaier@dh-electronics.com>
 <20230406154900.6423-3-cniedermaier@dh-electronics.com>
 <5478133e-7772-1db9-3473-1ec86fa2aae2@linaro.org>
 <a7fcfe695623491da96639079eb14c8f@dh-electronics.com>
 <f6c8586f-a5d1-875f-b2c0-7871112cf1b1@linaro.org>
In-Reply-To: <f6c8586f-a5d1-875f-b2c0-7871112cf1b1@linaro.org>
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
YXJvLm9yZ10NClNlbnQ6IFRodXJzZGF5LCBBcHJpbCA2LCAyMDIzIDg6MDAgUE0NCj4gT24gMDYv
MDQvMjAyMyAxOTo1NCwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPiANCj4+Pj4gKysr
IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1kaGNvci1tYXZlby1ib3guZHRzDQo+Pj4+IEBA
IC0wLDAgKzEsMzYxIEBADQo+Pj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vci1sYXRlciBPUiBNSVQNCj4+Pj4gKy8qDQo+Pj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjMg
REggZWxlY3Ryb25pY3MgR21iSA0KPj4+PiArICogQ29weXJpZ2h0IChDKSAyMDIzIE1hcmFudGVj
IGVsZWN0cm9uaWNzIEdtYkgNCj4+Pj4gKyAqDQo+Pj4+ICsgKiBESENPTSBpTVg2VUxMIHZhcmlh
bnQ6DQo+Pj4+ICsgKiBESENSLWlNWDZVTEwtQzA4MC1SMDUxLVNQSS1XQlQtSS0wMUxHDQo+Pj4+
ICsgKiBESENPUiBQQ0IgbnVtYmVyOiA1NzgtMjAwIG9yIG5ld2VyDQo+Pj4+ICsgKiBtYXZlbyBi
b3ggUENCIG51bWJlcjogNTI1LTIwMCBvciBuZXdlcg0KPj4+PiArICovDQo+Pj4+ICsNCj4+Pj4g
Ky9kdHMtdjEvOw0KPj4+PiArDQo+Pj4+ICsjaW5jbHVkZSAiaW14NnVsbC1kaGNvci1zb20uZHRz
aSINCj4+Pj4gKw0KPj4+PiArLyB7DQo+Pj4+ICsgICAgIG1vZGVsID0gIkRIIGVsZWN0cm9uaWNz
IGkuTVg2VUxMIERIQ09SIG9uIG1hdmVvIGJveCI7DQo+Pj4+ICsgICAgIGNvbXBhdGlibGUgPSAi
bWFyYW50ZWMsaW14NnVsbC1kaGNvci1tYXZlby1ib3giLCAiZGgsaW14NnVsbC1kaGNvci1zb20i
LA0KPj4+PiArICAgICAgICAgICAgICAgICAgImZzbCxpbXg2dWxsIjsNCj4+Pj4gKw0KPj4+PiAr
ICAgICBhbGlhc2VzIHsNCj4+Pj4gKyAgICAgICAgICAgICAvZGVsZXRlLXByb3BlcnR5LyBtbWMw
OyAvKiBBdm9pZCBkb3VibGUgZGVmaW5pdGlvbnMgKi8NCj4+Pg0KPj4+IEkgZG9uJ3QgdW5kZXJz
dGFuZCBpdC4gV2hhdCBpcyAiZG91YmxlIGRlZmluaXRpb24iIG9mIGFsaWFzZXM/DQo+Pg0KPj4g
T3RoZXJ3aXNlIEkgZW5kIHVwIGxpa2UgdGhpczoNCj4+IG1tYzAgPSAmdXNkaGMxOw0KPj4gbW1j
MSA9ICZ1c2RoYzI7DQo+PiBtbWMyID0gJnVzZGhjMjsNCj4+DQo+PiBJcyAiRW5zdXJlIHVuaXF1
ZSBhbGxvY2F0aW9uIiBhIGJldHRlciBjb21tZW50IGhlcmU/DQo+Pg0KPj4+DQo+Pj4+ICsgICAg
ICAgICAgICAgL2RlbGV0ZS1wcm9wZXJ0eS8gbW1jMTsNCj4+Pj4gKyAgICAgICAgICAgICBtbWMy
ID0gJnVzZGhjMjsgLyogZU1NQyBzaG91bGQgYmUgbW1jMiAqLw0KPj4+DQo+Pj4gV2h5PyBIb3cg
aXMgdGhpcyBsYWJlbGVkIG9uIHRoZSBib2FyZCAocGh5c2ljYWxseSBvciBvbiBzY2hlbWF0aWNz
KT8gSWYNCj4+PiB5b3UgYW5zd2VyIGhlcmUgImZvciBib290aW5nIiwgdGhlbiB0aGUgYW5zd2Vy
IGlzIE5BSy4gRG9uJ3QgYWRkDQo+Pj4gc29mdHdhcmUgcG9saWNpZXMgdG8gRGV2aWNldHJlZS4N
Cj4+DQo+PiBUaGUgbmFtZSBpbiB0aGUgc2NoZW1hdGljcyBpcyAiU0QyIi4NCj4gDQo+IEFuc3dl
cmluZyBhbHNvIHRvIGFib3ZlIC0gdGhlbiBsaWtlbHkgdGhlIGFsaWFzZXMgc2hvdWxkIGJlIGRy
b3BwZWQgZnJvbQ0KPiBTb00uIEkgZG91YnQgdGhhdCBTb20gY2FsbHMgaXQgU0QxIGFuZCB5b3Vy
IGJvYXJkIFNEMi4uLg0KDQpNYXliZSBJIGRvbid0IHF1aXRlIGdldCBpdCwgYnV0IHRoZSBoYXJk
d2FyZSBzdGFydHMgY291bnRpbmcgYXQgMS4gVGhlIGZpcnN0DQppbnRlcmZhY2UgaXMgU0QxIGFu
ZCBpdCBpcyB1c2VkIGFzIFdpRmkuIFRoZSBzZWNvbmQgb25lIGlzIFNEMiB3aGljaCBpcyB0aGUN
CmVNTUMuIFNvIHdpdGggdGhpcyBhbGlhc2VzIGl0IHNob3VsZCBtYXRjaCBTRDIgdG8gbW1jMi4N
CkRvIHlvdSB3YW50IG1lIHRvIGRlbGV0ZSB0aGUgYWxpYXNlcyBpbiB0aGUgaW5jbHVkZSBmaWxl
ICJpbXg2dWxsLWRoY29yLXNvbS5kdHNpIg0Kb3Igd2hhdCBjYW4gSSBkbz8NCg0KDQpUaGFua3Mg
YW5kIHJlZ2FyZHMNCkNocmlzdG9waA0K
