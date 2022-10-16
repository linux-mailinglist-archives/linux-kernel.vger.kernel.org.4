Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368006003F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJPWjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 18:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJPWj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:39:28 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E457664
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 15:39:27 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1DA012C04E3;
        Sun, 16 Oct 2022 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1665959962;
        bh=oWpcr9loT1LAqQR8CFDe7J/v/rubUPt8jGr6fgvQMVA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=sn1zaw75dORdufc7wPFjprMROokf0b3/KUHgKNVnuju/NXRObnA5zRYWIdNBrt4oa
         uQyb+qt0zQsMn3jYJqSj9ShTfbtYLN8+twu3Gvq6fMx7KpB879lrA4Y8dGJhGc00/4
         24f/M7Pi0zNs0/DXnzY29+2nTu0xHlYJwc1fU/dGPj1Xr91QDMsWboDPIjqOJOxBnB
         s3TWuf7D77dxp7vDIuh6dpj92Ni8z7qgpvHqPZ+S7hb5e7aY+qiTJr70n+TwSVsgy2
         cj2bqfFomU9SWIon5l/rSJjv66UZufxZE1KJy8C0xC8nz+BDJNSc3sX3K+hZ4uLVDJ
         jTWvhwysnLF/g==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B634c881a0001>; Mon, 17 Oct 2022 11:39:22 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Oct 2022 11:39:21 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.042; Mon, 17 Oct 2022 11:39:21 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: armada-xp: add interrupts for watchdog
Thread-Topic: [PATCH 1/2] ARM: dts: armada-xp: add interrupts for watchdog
Thread-Index: AQHYHt7uiWYAlaasj0eIMMhjL00ERqySWk8AgX/uSYA=
Date:   Sun, 16 Oct 2022 22:39:21 +0000
Message-ID: <0308a842-efcb-d4a0-f17c-2b0bf12c9dfb@alliedtelesis.co.nz>
References: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
 <20220211003257.2037332-2-chris.packham@alliedtelesis.co.nz>
 <87o839jw4p.fsf@BL-laptop>
In-Reply-To: <87o839jw4p.fsf@BL-laptop>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4212113A5D92B4CB103CCF22FC0E6E5@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=EZC2v8uC c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10 a=P-IC7800AAAA:8 a=HY4e2j-mU8xZvivSFSQA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZ29yeSwNCg0KT24gMTUvMDIvMjIgMDQ6MzksIEdyZWdvcnkgQ0xFTUVOVCB3cm90ZToN
Cj4gSGVsbG8gQ2hyaXMsDQo+DQo+PiBUaGUgZmlyc3QgaW50ZXJydXB0IGlzIGZvciB0aGUgcmVn
dWxhciB3YXRjaGRvZyB0aW1lb3V0LiBOb3JtYWxseSB0aGUNCj4+IFJTVE9VVCBsaW5lIHdpbGwg
dHJpZ2dlciBhIHJlc2V0IGJlZm9yZSB0aGlzIGludGVycnVwdCBmaXJlcyBidXQgb24NCj4+IHN5
c3RlbXMgd2l0aCBhIG5vbi1zdGFuZGFyZCByZXNldCBpdCBtYXkgc3RpbGwgdHJpZ2dlci4NCj4+
DQo+PiBUaGUgc2Vjb25kIGludGVycnVwdCBpcyBmb3IgYSB0aW1lcjEgd2hpY2ggaXMgdXNlZCBh
cyBhIHByZS10aW1lb3V0IGZvcg0KPj4gdGhlIHdhdGNoZG9nLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4g
QWNrZWQtYnk6IEdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29tPg0K
Pg0KPiBUbyBrZWVwIGJpc2VjdGFiaWxpdHkgdGhpcyBwYXRjaCBzaG91bGQgYmUgbWVyZ2VkIGFm
dGVyIHRoZSBkcml2ZXINCj4gcGF0Y2guDQo+DQo+IFRoYW5rcywNCj4NCj4gR3JlZ29yeQ0KDQpU
aGUgZHJpdmVyIGNoYW5nZXMgd2VyZSBtZXJnZWQgYSB3aGlsZSBiYWNrLiBMb29rcyBsaWtlIHlv
dXIgaW50ZW50aW9uIA0Kd2FzIGZvciB0aGlzIHRvIGdvIGluIHZpYSB0aGUgd2F0Y2hkb2cgdHJl
ZSBidXQgdGhhdCBuZXZlciBoYXBwZW5lZC4gDQpDb3VsZCB5b3UgdGFrZSBpdCB0aHJvdWdoIHlv
dXIgdHJlZSBub3c/IFByb2JhYmx5IHdvbid0IGJlIHVudGlsIDYuMiBub3cgDQpidXQgdGhhdCdz
IGZpbmUuDQoNCj4NCj4+IC0tLQ0KPj4gICBhcmNoL2FybS9ib290L2R0cy9hcm1hZGEteHAtOThk
eDMyMzYuZHRzaSB8IDEgKw0KPj4gICBhcmNoL2FybS9ib290L2R0cy9hcm1hZGEteHAuZHRzaSAg
ICAgICAgICB8IDEgKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEteHAtOThkeDMyMzYuZHRz
aSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FybWFkYS14cC05OGR4MzIzNi5kdHNpDQo+PiBpbmRleCAz
OGEwNTJhMDMxMmQuLjBlNTYxZGZjMGNhOSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2FybWFkYS14cC05OGR4MzIzNi5kdHNpDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9h
cm1hZGEteHAtOThkeDMyMzYuZHRzaQ0KPj4gQEAgLTI4Niw2ICsyODYsNyBAQCAmd2F0Y2hkb2cg
ew0KPj4gICAJY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYS14cC13ZHQiOw0KPj4gICAJY2xv
Y2tzID0gPCZjb3JlY2xrIDI+LCA8JnJlZmNsaz47DQo+PiAgIAljbG9jay1uYW1lcyA9ICJuYmNs
ayIsICJmaXhlZCI7DQo+PiArCWludGVycnVwdHMgPSA8OTM+LCA8Mzg+Ow0KPj4gICB9Ow0KPj4g
ICANCj4+ICAgJmNwdXJzdCB7DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXJt
YWRhLXhwLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEteHAuZHRzaQ0KPj4gaW5kZXgg
NmMxOTk4NGQ2NjhlLi40Mjk3NDgyZGE2MmYgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybS9ib290
L2R0cy9hcm1hZGEteHAuZHRzaQ0KPj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRhLXhw
LmR0c2kNCj4+IEBAIC0yNjAsNiArMjYwLDcgQEAgJndhdGNoZG9nIHsNCj4+ICAgCWNvbXBhdGli
bGUgPSAibWFydmVsbCxhcm1hZGEteHAtd2R0IjsNCj4+ICAgCWNsb2NrcyA9IDwmY29yZWNsayAy
PiwgPCZyZWZjbGs+Ow0KPj4gICAJY2xvY2stbmFtZXMgPSAibmJjbGsiLCAiZml4ZWQiOw0KPj4g
KwlpbnRlcnJ1cHRzID0gPDkzPiwgPDM4PjsNCj4+ICAgfTsNCj4+ICAgDQo+PiAgICZjcHVyc3Qg
ew0KPj4gLS0gDQo+PiAyLjM1LjENCj4+
