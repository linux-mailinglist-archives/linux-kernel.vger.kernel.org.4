Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4D6DA4EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbjDFVxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDFVxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:53:43 -0400
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882AAA5FC;
        Thu,  6 Apr 2023 14:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680817971;
        bh=f0pUhAJWTLi8vSi9ZobW2xHA14GSuVsrQ9QrsonYrqg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=INWTRWecbrNYN1h39h2BpE2FJjMvDgcpKlq2WKwJRdckGGMd1vAM0urH1u/7J9HhB
         +UsFlNbHnKJ/g7+EIGtKtVLJs50Yh85LWPVXdI/6K9lXQLtABCN3G1DjSat/9HacsE
         95tOCP4MStHoRYG0MFKFfgn5pUa9Mvy6aqAYPtEagbgT/dP40BQcwtYU3YYgBu8TI+
         3izXQZuLgZYCFpQoPYtMRxTrxUrIggpOGdakUPnR3uo8GJiZ1MhB0Xg01lW5Crrkgu
         G+PjaCrv6/JrdAtXjrv/WbLQn2dloa4pZILJYEzGkICzBfZJaX2eoFtJdjc3ZvV7FX
         ajBb2q5iMhj4g==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Krzysztof Kozlowski <krzk@kernel.org>,
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
Thread-Index: AQHZaJ93At1GnP2el0yoagNBg+3G/K8eWhSAgAAwTiD//+YUAIAAON0Q///zRYCAADW4IA==
Date:   Thu, 6 Apr 2023 21:52:41 +0000
Message-ID: <9224dcdbd62641cfb0ee691827d1b57d@dh-electronics.com>
References: <20230406154900.6423-1-cniedermaier@dh-electronics.com>
 <20230406154900.6423-3-cniedermaier@dh-electronics.com>
 <5478133e-7772-1db9-3473-1ec86fa2aae2@linaro.org>
 <a7fcfe695623491da96639079eb14c8f@dh-electronics.com>
 <f6c8586f-a5d1-875f-b2c0-7871112cf1b1@linaro.org>
 <ff95314402a349a5a2998c1b5e2b13a2@dh-electronics.com>
 <8353399f-c6de-8da7-78f1-d6a558c462d0@kernel.org>
In-Reply-To: <8353399f-c6de-8da7-78f1-d6a558c462d0@kernel.org>
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

RnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSBbbWFpbHRvOmtyemtAa2VybmVsLm9yZ10NClNlbnQ6
IFRodXJzZGF5LCBBcHJpbCA2LCAyMDIzIDEwOjM4IFBNDQo+IE9uIDA2LzA0LzIwMjMgMjE6NTcs
IENocmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+Pj4+PiArICAgICBhbGlhc2VzIHsNCj4+
Pj4+PiArICAgICAgICAgICAgIC9kZWxldGUtcHJvcGVydHkvIG1tYzA7IC8qIEF2b2lkIGRvdWJs
ZSBkZWZpbml0aW9ucyAqLw0KPj4+Pj4NCj4+Pj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCBpdC4gV2hh
dCBpcyAiZG91YmxlIGRlZmluaXRpb24iIG9mIGFsaWFzZXM/DQo+Pj4+DQo+Pj4+IE90aGVyd2lz
ZSBJIGVuZCB1cCBsaWtlIHRoaXM6DQo+Pj4+IG1tYzAgPSAmdXNkaGMxOw0KPj4+PiBtbWMxID0g
JnVzZGhjMjsNCj4+Pj4gbW1jMiA9ICZ1c2RoYzI7DQo+Pj4+DQo+Pj4+IElzICJFbnN1cmUgdW5p
cXVlIGFsbG9jYXRpb24iIGEgYmV0dGVyIGNvbW1lbnQgaGVyZT8NCj4+Pj4NCj4+Pj4+DQo+Pj4+
Pj4gKyAgICAgICAgICAgICAvZGVsZXRlLXByb3BlcnR5LyBtbWMxOw0KPj4+Pj4+ICsgICAgICAg
ICAgICAgbW1jMiA9ICZ1c2RoYzI7IC8qIGVNTUMgc2hvdWxkIGJlIG1tYzIgKi8NCj4+Pj4+DQo+
Pj4+PiBXaHk/IEhvdyBpcyB0aGlzIGxhYmVsZWQgb24gdGhlIGJvYXJkIChwaHlzaWNhbGx5IG9y
IG9uIHNjaGVtYXRpY3MpPyBJZg0KPj4+Pj4geW91IGFuc3dlciBoZXJlICJmb3IgYm9vdGluZyIs
IHRoZW4gdGhlIGFuc3dlciBpcyBOQUsuIERvbid0IGFkZA0KPj4+Pj4gc29mdHdhcmUgcG9saWNp
ZXMgdG8gRGV2aWNldHJlZS4NCj4+Pj4NCj4+Pj4gVGhlIG5hbWUgaW4gdGhlIHNjaGVtYXRpY3Mg
aXMgIlNEMiIuDQo+Pj4NCj4+PiBBbnN3ZXJpbmcgYWxzbyB0byBhYm92ZSAtIHRoZW4gbGlrZWx5
IHRoZSBhbGlhc2VzIHNob3VsZCBiZSBkcm9wcGVkIGZyb20NCj4+PiBTb00uIEkgZG91YnQgdGhh
dCBTb20gY2FsbHMgaXQgU0QxIGFuZCB5b3VyIGJvYXJkIFNEMi4uLg0KPj4NCj4+IE1heWJlIEkg
ZG9uJ3QgcXVpdGUgZ2V0IGl0LCBidXQgdGhlIGhhcmR3YXJlIHN0YXJ0cyBjb3VudGluZyBhdCAx
LiBUaGUgZmlyc3QNCj4+IGludGVyZmFjZSBpcyBTRDEgYW5kIGl0IGlzIHVzZWQgYXMgV2lGaS4g
VGhlIHNlY29uZCBvbmUgaXMgU0QyIHdoaWNoIGlzIHRoZQ0KPj4gZU1NQy4gU28gd2l0aCB0aGlz
IGFsaWFzZXMgaXQgc2hvdWxkIG1hdGNoIFNEMiB0byBtbWMyLg0KPj4gRG8geW91IHdhbnQgbWUg
dG8gZGVsZXRlIHRoZSBhbGlhc2VzIGluIHRoZSBpbmNsdWRlIGZpbGUgImlteDZ1bGwtZGhjb3It
c29tLmR0c2kiDQo+IA0KPiBZZXMsIGJlY2F1c2UgaXQgaW5jb3JyZWN0bHkgY2FsbHMgZU1NQyBh
cyBtbWMxLiBZb3Ugc2FpZCBpdCBpcyBTRDIsIHJpZ2h0Pw0KDQpZZXMuIEkgd2lsbCBkbyB0aGlz
IGluIHZlcnNpb24gMy4NCg0KDQpUaGFua3MgYW5kIGJlc3QgcmVnYXJkcw0KQ2hyaXN0b3BoDQo=
