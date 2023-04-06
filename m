Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF46D9C96
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbjDFPpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDFPpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:45:33 -0400
X-Greylist: delayed 25635 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 08:45:29 PDT
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF20D93E0;
        Thu,  6 Apr 2023 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680795886;
        bh=weRr1LfyAYwIVDshDBkw836sXDNQAJoCHuPZdD7UunU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=m8Vr+QgQKVzNEXm4+kJGJOj63AuaBKTLCTeOtD2QmJREzINjWCTPQj0ZuUzykykEN
         H48sB7bllBO3j2CZyf5JX/fR+ShM/NyE6Y2A/xlqDDikKaoKkPIg/rpvTEDbY3ckIm
         Axm0dZPE2MgTv1UJAgs0SOaEfpZEHsDkuP2avTVNIlAS/Q1bsSzhFf+t47ty7uKDUx
         NSqQeeillvmYxZJvw9tp2J3bylLK2GY/PmpysUUHP6C6JSo7GZQJ5a22HSQ0cCIqDK
         oDUbGiurPEPzNWhnoB4SYoOIrS672aMflVoBzURROY23Jlea8rHkd3Y7tRLfmwJ52W
         LhFGIU7WRnAxw==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Marek Vasut <marex@denx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Thread-Topic: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Thread-Index: AQHZZ9hJaqalrClMnUSWr1zaggJvEq8cxTeAgAA/z6D//+elAIABBfrQgAA/KQCAADr0QA==
Date:   Thu, 6 Apr 2023 15:44:36 +0000
Message-ID: <622e846f1d2c4f8abba171202640d1d3@dh-electronics.com>
References: <20230405160258.46998-1-cniedermaier@dh-electronics.com>
 <20230405160258.46998-2-cniedermaier@dh-electronics.com>
 <05fa147c-116b-59b4-d14b-760bbefd7602@denx.de>
 <e7aa3b3220e148ee96f5a1c361721845@dh-electronics.com>
 <42737c19-698f-8cc8-45b2-8ff08a274f87@denx.de>
 <531df359744f4bdb9fd34eafc864d2bc@dh-electronics.com>
 <50c88cc4-e046-6c43-2d35-116d1d4ea2f8@denx.de>
In-Reply-To: <50c88cc4-e046-6c43-2d35-116d1d4ea2f8@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgW21haWx0bzptYXJleEBkZW54LmRlXQ0KU2VudDogVGh1cnNkYXks
IEFwcmlsIDYsIDIwMjMgNDoxMCBQTQ0KPiBPbiA0LzYvMjMgMTA6MzcsIENocmlzdG9waCBOaWVk
ZXJtYWllciB3cm90ZToNCj4+IEZyb206IE1hcmVrIFZhc3V0IFttYWlsdG86bWFyZXhAZGVueC5k
ZV0NCj4+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgNSwgMjAyMyA4OjQ3IFBNDQo+Pj4gT24gNC81
LzIzIDIwOjI0LCBDaHJpc3RvcGggTmllZGVybWFpZXIgd3JvdGU6DQo+Pj4+IEZyb206IE1hcmVr
IFZhc3V0IFttYWlsdG86bWFyZXhAZGVueC5kZV0NCj4+Pj4gU2VudDogV2VkbmVzZGF5LCBBcHJp
bCA1LCAyMDIzIDY6MjUgUE0NCj4+Pj4+IE9uIDQvNS8yMyAxODowMiwgQ2hyaXN0b3BoIE5pZWRl
cm1haWVyIHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IFsuLi5dDQo+Pj4+Pg0KPj4+Pj4+ICsvIHsNCj4+
Pj4+PiArICAgICBtb2RlbCA9ICJESCBlbGVjdHJvbmljcyBpLk1YNlVMTCBESENPUiBvbiBtYXZl
byBib3giOw0KPj4+Pj4+ICsgICAgIGNvbXBhdGlibGUgPSAiZGgsaW14NnVsbC1kaGNvci1tYXZl
by1ib3giLCAiZGgsaW14NnVsbC1kaGNvci1zb20iLA0KPj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAiZnNsLGlteDZ1bGwiOw0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgICBhbGlhc2VzIHsNCj4+Pj4+
PiArICAgICAgICAgICAgIC9kZWxldGUtcHJvcGVydHkvIG1tYzA7IC8qIEF2b2lkIGRvdWJsZSBk
ZWZpbml0aW9ucyAqLw0KPj4+Pj4+ICsgICAgICAgICAgICAgL2RlbGV0ZS1wcm9wZXJ0eS8gbW1j
MTsNCj4+Pj4+PiArICAgICAgICAgICAgIG1tYzIgPSAmdXNkaGMyOyAvKiBlTU1DIHNob3VsZCBi
ZSBtbWMyICovDQo+Pj4+Pg0KPj4+Pj4gV2h5IG5vdCBtbWMwID8NCj4+Pj4+DQo+Pj4+PiBVc2Ug
cm9vdD1QQVJUVVVJRD0gd2hlbiBib290aW5nIHRvIGF2b2lkIGFueSBkZXBlbmRlbmN5IG9uDQo+
Pj4+PiByb290PS9kZXYvbW1jYmxrMnBOIGVudW1lcmF0aW9uLg0KPj4+Pg0KPj4+PiBUaGlzIGlz
IGR1ZSB0byBzb2Z0d2FyZSBpbnRlcmNoYW5nZWFiaWxpdHkgd2l0aCB0aGUgREhDT00NCj4+Pj4g
aS5NWDZVTEwsIHdoZXJlIHRoZSBlTU1DIGlzIGFsd2F5cyBtbWMyLg0KPj4+DQo+Pj4gK0NDIFVs
ZiAsIEkgdmFndWVseSByZWNhbGwgc29tZSBkaXNjdXNzaW9uIGFib3V0IHRoaXMgZW51bWVyYXRp
b24gYW5kIEkNCj4+PiBhbSBub3Qgc3VyZSBvbmUgY2FuIHJlYWxseSBkZXBlbmQgb24gdGhhdC4N
Cj4+DQo+PiBUaGF0IHdoeSBJIHRoaW5rIGl0IGdvb2QgdG8gaGF2ZSBhIGRlZmluZWQgbnVtYmVy
IGZvciBtbWNibGsgZGV2aWNlcw0KPj4gb24gYW4gZW1iZWRkZWQgc3lzdGVtLiBBbiBleGNlcnB0
IGZyb20gWzFdOg0KPiANCj4gSSBtaWdodCBiZSBtaXNyZW1lbWJlcmluZyB0aGlzLCBidXQgY291
bGQgaXQgYmUgdGhhdCwgaWYgYW55IG5vbi1PRg0KPiBTRE1NQyBjb250cm9sbGVyIHByb2JlcyBl
YXJseSBhbmQgaG9ncyB0aGUgL2Rldi9tbWNibGsyIGJlZm9yZSB0aGUgT0YNCj4gb25lcyBoYXZl
IGEgY2hhbmNlIHRvIHByb2JlLCB0aGVuIHRoZSBPRiBvbmVzIHdvdWxkIGZhaWwgdG8gcHJvYmUg
Pw0KPiANCj4+IEFsdGVybmF0aXZlIHNvbHV0aW9ucyBsaWtlIFBBUlRVVUlEcyBkbyBub3QgY292
ZXIgdGhlIGNhc2Ugd2hlcmUgbXVsdGlwbGUNCj4+IG1tY2JsayBkZXZpY2VzIGNvbnRhaW4gdGhl
IHNhbWUgaW1hZ2UuDQo+IA0KPiBJIGFncmVlLCB0aGlzIGlzIGluZGVlZCBhIGRvd25zaWRlIG9m
IFBBUlRVVUlEIC4NCj4gDQo+PiBUaGlzIGlzIGEgY29tbW9uIGlzc3VlIG9uIGRldmljZXMNCj4+
IHRoYXQgY2FuIGJvb3QgYm90aCBmcm9tIGVNTUMgKGZvciByZWd1bGFyIGJvb3QpIGFuZCBTRCBj
YXJkcyAoYXMgYQ0KPj4gdGVtcG9yYXJ5IGJvb3QgbWVkaXVtIGZvciBkZXZlbG9wbWVudCkuIFdo
ZW4gYSBmaXJtd2FyZSBpbWFnZSBpcw0KPj4gaW5zdGFsbGVkIHRvIGVNTUMgYWZ0ZXIgYSB0ZXN0
IGJvb3QgdmlhIFNEIGNhcmQsIHRoZXJlIHdpbGwgYmUgbm8NCj4+IHJlbGlhYmxlIHdheSB0byBy
ZWZlciB0byBhIHNwZWNpZmljIGRldmljZSB1c2luZyAoUEFSVClVVUlEcyBvZGVyDQo+PiBMQUJF
THMNCj4gDQo+IFRoaXMgY2FuIGJlIHNvbHZlZCBieSB0aGUgaW5zdGFsbGVyIHVwZGF0aW5nIHRo
ZSBQQVJUVVVJRCBvbiB0aGUgZU1NQw0KPiBob3dldmVyLg0KPiANCj4+IFsxXSBodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbW1jL3BhdGNoLzIwMjAwODI1MTM0NDQx
LjE3NTM3LTItbWF0dGhpYXMuc2NoaWZmZXJAZXcudHEtZ3JvdXAuY29tLw0KPj4NCj4+IFNvIGZh
ciBJIGhhdmUgbmV2ZXIgaGFkIGEgcHJvYmxlbSB3aXRoIG51bWJlcmluZyBtbWNibGsgZGV2aWNl
cyB2aWEgYWxpYXNlcy4NCj4gDQo+IEJhc2VkIG9uIHRoZSBhYm92ZSwgSSBkb24ndCB0aGluayBl
aXRoZXIgdGhlIGFsaWFzZXMgb3IgUEFSVFVVSUQgaXMgYQ0KPiBwZXJmZWN0IHNvbHV0aW9uLCBi
dXQgdGhlIGFsaWFzZXMgc2hvdWxkIGJlIGZpbmUgZm9yIG14NnVsbCBhdCBsZWFzdD8NCj4gU28g
SSB0aGluayB3ZSBjYW4gY29uY2x1ZGUgdGhpcyBkaXNjdXNzaW9uIHRocmVhZCA/DQoNClllcywg
SSB3aWxsIHNlbmQgYSBuZXcgdmVyc2lvbiB3aXRoIHRoZSBjaGFuZ2VzIG9uIHRoZSBmaXJzdCBw
YXRjaC4NCg0KUmVnYXJkcw0KQ2hyaXN0b3BoDQo=
