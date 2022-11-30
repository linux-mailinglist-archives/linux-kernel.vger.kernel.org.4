Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B46963D50F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiK3Lza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiK3Lz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:55:26 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E30BC6;
        Wed, 30 Nov 2022 03:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669809298;
        bh=QTxShgLCFJDnPlJNxPnSPxh309OaURYH+NK5Jz73MWU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CPxzkI6aj7PjWInWFnzv4EXQwrJJ0SR9kjF8V3G3A+3NdDlyJzJzGYP7ZOcEtOnzU
         UDWUhBcefFRpFmpEiIWPYXQGhatMAocCY6A5d4VSM8pesj7GQwy8cWosjmU1ccwOHr
         tS3yfovHM9/yOFYkPe3utdRoOgLLIZ7smfooZH3GoGf+svqBtfZ6MQHoW/sMoe1fOs
         lvsmj8uMsCKqWF5JAYe2vzWj54T9hhl0am5PRJXDxVek9mo3dobBCEg58980BP3JUd
         vtomXHdzGqVCWPkR+J4e8C+iMXdOOq7JxzuKTxAiBVj1ahqe5+dQmkLOmqW5Igb+Y7
         Yi4sMKHEtMWbg==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V2] dt-bindings: mmc: Remove comment on wakeup-source
 property
Thread-Topic: [PATCH V2] dt-bindings: mmc: Remove comment on wakeup-source
 property
Thread-Index: AQHZBKVP2+ZPj2buAUK1UrVSwUIWK65XRtKAgAAT3VA=
Date:   Wed, 30 Nov 2022 11:54:47 +0000
Message-ID: <adc58f49cb0c4de6b95d203f4b5440ba@dh-electronics.com>
References: <20221130101852.5408-1-cniedermaier@dh-electronics.com>
 <CAPDyKFpZnnx_4+NmsVewMs8duDqf=qY57a134QD+1NdcKRnK_A@mail.gmail.com>
In-Reply-To: <CAPDyKFpZnnx_4+NmsVewMs8duDqf=qY57a134QD+1NdcKRnK_A@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVWxmIEhhbnNzb24gW21haWx0bzp1bGYuaGFuc3NvbkBsaW5hcm8ub3JnXQ0KU2VudDog
V2VkbmVzZGF5LCBOb3ZlbWJlciAzMCwgMjAyMiAxMjo0MCBQTQ0KPiBPbiBXZWQsIDMwIE5vdiAy
MDIyIGF0IDExOjIwLCBDaHJpc3RvcGggTmllZGVybWFpZXI8Y25pZWRlcm1haWVyQGRoLWVsZWN0
cm9uaWNzLmNvbT4gd3JvdGU6DQo+Pg0KPj4gVGhlIGN1cnJlbnQgY29tbWVudCBvbiB3YWtldXAt
c291cmNlIGlzIGEgbGl0dGxlIGNvbmZ1c2luZyBiZWNhdXNlDQo+PiB0aGUgd29yZCBkZXByZWNh
dGVkIGNhbiBiZSBpbnRlcnByZXRlZCBhdCBmaXJzdCBnbGFuY2UgdG8gbWVhbiB0aGF0DQo+PiB3
YWtldXAtc291cmNlIGlzIGRlcHJlY2F0ZWQuIEFsc28gbWVudGlvbmluZyB0aGUgb2Jzb2xldGUg
cHJvcGVydHkNCj4+IGNvbmZ1c2VzIG1vcmUgdGhhbiBpdCBoZWxwcy4gVGhlcmVmb3JlLCB0aGUg
Y29tbWVudCBzaG91bGQgYmUgcmVtb3ZlZA0KPj4gY29tcGxldGVseSBiZWNhdXNlIHRoZSBlbmFi
bGUtc2Rpby13YWtldXAgcHJvcGVydHkgaXMgbm90IHVzZWQgaW4NCj4+IGFueSBjdXJyZW50IERU
cy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggTmllZGVybWFpZXIgPGNuaWVkZXJt
YWllckBkaC1lbGVjdHJvbmljcy5jb20+DQo+PiAtLS0NCj4+IENjOiBVbGYgSGFuc3NvbiA8dWxm
LmhhbnNzb25AbGluYXJvLm9yZz4NCj4+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwu
b3JnPg0KPj4gQ2M6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRA
bGluYXJvLm9yZz4NCj4+IENjOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4+IENjOiBr
ZXJuZWxAZGgtZWxlY3Ryb25pY3MuY29tDQo+PiBDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9y
Zw0KPj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+PiBUbzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPj4gLS0tDQo+PiBWMjogLSBJbnN0ZWFkIG9mIGNoYW5naW5nIHRo
ZSBjb21tZW50LCByZW1vdmUgaXQNCj4+IC0tLQ0KPj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvbW1jLWNvbnRyb2xsZXIueWFtbCB8IDEgLQ0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tbWMvbW1jLWNvbnRyb2xsZXIueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbW1jLWNvbnRyb2xsZXIueWFtbA0KPj4gaW5kZXggODAy
ZTNjYThiZTRkLi5lODJjMDAzNjgwODggMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbW1jL21tYy1jb250cm9sbGVyLnlhbWwNCj4+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbW1jLWNvbnRyb2xsZXIueWFtbA0KPj4g
QEAgLTI5Myw3ICsyOTMsNiBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgICBkZXNjcmlwdGlvbjoNCj4+
ICAgICAgICBTRElPIG9ubHkuIFByZXNlcnZlcyBjYXJkIHBvd2VyIGR1cmluZyBhIHN1c3BlbmQv
cmVzdW1lIGN5Y2xlLg0KPj4NCj4+IC0gICMgRGVwcmVjYXRlZDogZW5hYmxlLXNkaW8td2FrZXVw
DQo+PiAgICB3YWtldXAtc291cmNlOg0KPj4gICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy9mbGFnDQo+PiAgICAgIGRlc2NyaXB0aW9uOg0KPiANCj4gVGhpcyBsb29r
cyBnb29kIHRvIG1lIQ0KPiANCj4gSG93ZXZlciwgbGV0J3MgYWxzbyBkcm9wIHRoZSByZWZlcmVu
Y2UgdG8gdGhlIHByb3BlcnR5IGZyb20NCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3Bvd2VyL3dha2V1cC1zb3VyY2UudHh0Lg0KDQpTaG91bGQgSSBpbmNsdWRlIHRoaXMgaW4g
YSB2ZXJzaW9uIDMgb3Igc2hvdWxkIEkgc2VuZCBhIHNlcGFyYXRlIHBhdGNoPw0KDQpSZWdhcmRz
DQpDaHJpc3RvcGgNCg==
