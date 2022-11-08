Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1DD621BD9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKHSZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKHSZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:25:52 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236A460EB8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1667931947; x=1670523947;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TBq5LL6mwgk8nSL0XzqtoYsstTPMBbtwYQWsea5cKdc=;
        b=A3oOpx9A2d2ha+V9WgJ/LTn0Zn9dVVG9LuUxdQKDGayzwiVRIPvFIe/Dgvtghiaw
        lvCZHVXRzYl29SUgeKLGEagMG8wxQ0DgaGoIwchtPAqkGrKyLLlnKyLW/2+x5uvr
        vLgzFTIHXOQXnQGoHWPWVTYiWGmdEj+5P7t+FgluZng=;
X-AuditID: ac14000a-833f270000003940-da-636a9f2b44f6
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5E.26.14656.B2F9A636; Tue,  8 Nov 2022 19:25:47 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Nov
 2022 19:25:47 +0100
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Tue, 8 Nov 2022 19:25:47 +0100
From:   Wadim Egorov <W.Egorov@phytec.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "upstream@phytec.de" <upstream@phytec.de>, "nm@ti.com" <nm@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: Add support for
 phyBOARD-Electra-AM642
Thread-Topic: [PATCH v2 2/2] arm64: dts: ti: Add support for
 phyBOARD-Electra-AM642
Thread-Index: AQHY85sVvT0/Blv6VUa3KTQm0eF4Aa41QFsAgAAGtYA=
Date:   Tue, 8 Nov 2022 18:25:47 +0000
Message-ID: <4963de6e-275b-e1d2-859c-7c7364b4599b@phytec.de>
References: <20221108175050.285340-1-w.egorov@phytec.de>
 <20221108175050.285340-2-w.egorov@phytec.de>
 <414f8281-80ba-dd2c-e5f9-9e9cde1ad1e0@linaro.org>
In-Reply-To: <414f8281-80ba-dd2c-e5f9-9e9cde1ad1e0@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D04FF9210E04FA418D2D176EC4BA9643@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWyRpKBR1d7flaywfIufYv5R86xWiz/PJvd
        ou/FQ2aLva+3sltsenyN1eLyrjlsFm9+nGWyaN17hN3i/9kP7A6cHptWdbJ53Lm2h81j85J6
        j+M3tjN5fN4kF8AaxWWTkpqTWZZapG+XwJXxecdq5oIJdhVzlkxgbmA8YtPFyMkhIWAi8WrJ
        I5YuRi4OIYHFTBLLVz1lBkkICdxnlOj/rA2R2MAo8WdWKxNIgk1AXWLi3xOsIAkRgU4mia99
        u5lAHGaBPiaJQy9msIFUCQuESHw7vhisQ0QgVOJ5+xlGCNtKYuOPZWBxFgEViZcNE1lBbF4B
        G4npH/6xQKyezSixc18diM0pYCfRtXQHWC+jgKzEhg3nwc5jFhCX2PTsOyvEDwISS/ZAxCUE
        RCVePv4HFZeXOHFrGtAuDqB6TYn1u/QhWi0kNk68BjVGUWJK90N2iBMEJU7OfMIygVF8FpIN
        sxC6ZyHpnoWkexaS7gWMrKsYhXIzk7NTizKz9QoyKktSk/VSUjcxgmJZhIFrB2PfHI9DjEwc
        jIcYJTiYlUR4RWoyk4V4UxIrq1KL8uOLSnNSiw8xSnOwKInz3u9hShQSSE8sSc1OTS1ILYLJ
        MnFwSjUw7tlgqxolkx1VNW3hE/0VCx2/S7yaMG2bNt/c5Q9VBH5WGZ/ufKhbHfdhuuQZ1tsi
        GXZGYpzf+t5oePWnz2xKSd90ocovOc4jhrNn+96Uv5mytXtEM60W7HN9tdLl39UHt78t+bNq
        Rk/NlD1f4lscZ9xO4xaYs/bN3x1LmV/HuQutfJtefTxnlhJLcUaioRZzUXEiAHa0pEHTAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDguMTEuMjIgdW0gMTk6MDEgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAw
OC8xMS8yMDIyIDE4OjUwLCBXYWRpbSBFZ29yb3Ygd3JvdGU6DQo+PiBBZGQgYmFzaWMgc3VwcG9y
dCBmb3IgcGh5Q09SRS1BTTY0eCBTb00gJiBwaHlCT0FSRC1FbGVjdHJhLUFNNjQyIENCLg0KPj4N
Cj4+IFRoZSBwaHlDT1JFLUFNNjR4IFsxXSBpcyBhIFNvTSAoU3lzdGVtIG9uIE1vZHVsZSkgZmVh
dHVyaW5nIFRJJ3MgQU02NHggU29DLg0KPj4gSXQgY2FuIGJlIHVzZWQgaW4gY29tYmluYXRpb24g
d2l0aCBkaWZmZXJlbnQgY2FycmllciBib2FyZHMuDQo+PiBUaGlzIG1vZHVsZSBjYW4gY29tZSB3
aXRoIGRpZmZlcmVudCBzaXplcyBhbmQgbW9kZWxzIGZvcg0KPj4gRERSLCBlTU1DLCBTUEkgTk9S
IEZsYXNoIGFuZCB2YXJpb3VzIFNvQ3MgZnJvbSB0aGUgQU02NHggZmFtaWx5Lg0KPj4NCj4+IEEg
ZGV2ZWxvcG1lbnQgS2l0LCBjYWxsZWQgcGh5Qk9BUkQtRWxlY3RyYSBbMl0gaXMgdXNlZCBhcyBh
IGNhcnJpZXIgYm9hcmQNCj4+IHJlZmVyZW5jZSBkZXNpZ24gYXJvdW5kIHRoZSBBTTY0eCBTb00u
DQo+Pg0KPj4gU3VwcG9ydGVkIGZlYXR1cmVzOg0KPj4gICAgKiBEZWJ1ZyBVQVJUDQo+PiAgICAq
IEhlYXJ0YmVhdCBMRUQNCj4+ICAgICogR1BJTyBidXR0b25zICYgTEVEcw0KPj4gICAgKiBTUEkg
Tk9SIGZsYXNoDQo+PiAgICAqIFNQSSBUUE0gQ2hpcA0KPj4gICAgKiBlTU1DDQo+PiAgICAqIENB
Tg0KPj4gICAgKiBFdGhlcm5ldA0KPj4gICAgKiBNaWNybyBTRCBjYXJkDQo+PiAgICAqIEkyQyBF
RVBST00NCj4+ICAgICogSTJDIFJUQw0KPj4gICAgKiBJMkMgTEVEIERpbW1lcg0KPj4gICAgKiBV
U0INCj4+DQo+PiBGb3IgbW9yZSBkZXRhaWxzLCBzZWU6DQo+Pg0KPj4gWzFdIFByb2R1Y3QgcGFn
ZSBTb006IGh0dHBzOi8vd3d3LnBoeXRlYy5jb20vcHJvZHVjdC9waHljb3JlLWFtNjR4DQo+PiBb
Ml0gUHJvZHVjdCBwYWdlIENCOiBodHRwczovL3d3dy5waHl0ZWMuY29tL3Byb2R1Y3QvcGh5Ym9h
cmQtYW02NHgNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBXYWRpbSBFZ29yb3YgPHcuZWdvcm92QHBo
eXRlYy5kZT4NCj4+IC0tLQ0KPj4gdjI6DQo+PiAgICAtIFVwZGF0ZSBjb21taXQgbWVzc2FnZQ0K
Pj4gICAgLSBBZGQgbGlua3MgdG8gcHJvZHVjdCBwYWdlcyBmb3IgU29NICYgQ0INCj4+ICAgIC0g
RHJvcCAiZml4ZWQiIGZyb20gcmVndWxhdG9yIG5vZGUgbmFtZXMNCj4+ICAgIC0gVXNlIGdlbmVy
aWMgbm9kZSBuYW1lcyBmb3IgcG1pYywgdHBtLCBsZWRzICYga2V5cw0KPj4gICAgLSBVcGRhdGUg
Y29tcGF0aWJsZSBvZiBzb20uZHRzaQ0KPj4gICAgLSBSZW1vdmUgbm90IG5lZWRlZCBub2RlIGxh
YmVscyBmb3IgcG1pYywgdHBtDQo+PiAgICAtIFJlbW92ZSBub3QgbmVlZGVkIFI1IGNvcmUgbWFp
bGJveCAmIHJlc2VydmVkIG1lbW9yeSBkZWZpbml0aW9ucw0KPj4gICAgICBUaGlzIGlzIHVzZSBj
YXNlIHNwZWNpZmljIGFuZCBzaG91bGQgbm90IGJlIGRlZmluZWQgaW4gdGhlIHNvbS5kdHNpDQo+
PiAgICAtIFByb3ZpZGUgYWxpYXNlcyBmb3IgdXNlZCBkZXZpY2VzIGJ5IFNvTSAmIENCDQo+PiAg
ICAtIEZpeGVkIGxlZCBkZWZpbml0aW9uOiBQcm92aWRlIHByb3BlciBkZWZhdWx0LXRyaWdnZXIs
IGZ1bmN0aW9uICYgY29sb3INCj4+ICAgIC0gUmVuYW1lZCBydGMgbGFiZWwgdG8gaTJjX3NvbV9y
dGMNCj4+IC0tLQ0KPj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL01ha2VmaWxlICAgICAgICAg
ICAgICAgfCAgIDEgKw0KPj4gICAuLi4vYm9vdC9kdHMvdGkvazMtYW02NC1waHljb3JlLXNvbS5k
dHNpICAgICAgfCAyODYgKysrKysrKysrKysrKysrKw0KPj4gICAuLi4vZHRzL3RpL2szLWFtNjQy
LXBoeWJvYXJkLWVsZWN0cmEtcmRrLmR0cyAgfCAzMjEgKysrKysrKysrKysrKysrKysrDQo+PiAg
IDMgZmlsZXMgY2hhbmdlZCwgNjA4IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NC1waHljb3JlLXNvbS5kdHNpDQo+PiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjQyLXBoeWJv
YXJkLWVsZWN0cmEtcmRrLmR0cw0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL3RpL01ha2VmaWxlIGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9NYWtlZmlsZQ0KPj4gaW5k
ZXggNDU1NWE1YmUyMjU3Li43OTMzMWYxNmNkNGIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL3RpL01ha2VmaWxlDQo+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL01h
a2VmaWxlDQo+PiBAQCAtMjAsNiArMjAsNyBAQCBkdGItJChDT05GSUdfQVJDSF9LMykgKz0gazMt
ajcyMDAtY29tbW9uLXByb2MtYm9hcmQuZHRiDQo+PiAgIGR0Yi0kKENPTkZJR19BUkNIX0szKSAr
PSBrMy1qNzIxczItY29tbW9uLXByb2MtYm9hcmQuZHRiDQo+PiAgIA0KPj4gICBkdGItJChDT05G
SUdfQVJDSF9LMykgKz0gazMtYW02NDItZXZtLmR0Yg0KPj4gK2R0Yi0kKENPTkZJR19BUkNIX0sz
KSArPSBrMy1hbTY0Mi1waHlib2FyZC1lbGVjdHJhLXJkay5kdGINCj4+ICAgZHRiLSQoQ09ORklH
X0FSQ0hfSzMpICs9IGszLWFtNjQyLXNrLmR0Yg0KPj4gICANCj4+ICAgZHRiLSQoQ09ORklHX0FS
Q0hfSzMpICs9IGszLWFtNjI1LXNrLmR0Yg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvdGkvazMtYW02NC1waHljb3JlLXNvbS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy90
aS9rMy1hbTY0LXBoeWNvcmUtc29tLmR0c2kNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBp
bmRleCAwMDAwMDAwMDAwMDAuLjg2ZTZiODdiODI2YQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0LXBoeWNvcmUtc29tLmR0c2kNCj4+IEBA
IC0wLDAgKzEsMjg2IEBADQo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4+ICsvKg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyMSBQSFlURUMgQW1lcmljYSwgTExDIC0g
aHR0cHM6Ly93d3cucGh5dGVjLmNvbQ0KPj4gKyAqIEF1dGhvcjogTWF0dCBNY0tlZSA8bW1ja2Vl
QHBoeXRlYy5jb20+DQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjIgUEhZVEVDIE1l
c3N0ZWNobmlrIEdtYkgNCj4+ICsgKiBBdXRob3I6IFdhZGltIEVnb3JvdiA8dy5lZ29yb3ZAcGh5
dGVjLmRlPg0KPj4gKyAqDQo+PiArICogUHJvZHVjdCBob21lcGFnZToNCj4+ICsgKiBodHRwczov
L3d3dy5waHl0ZWMuY29tL3Byb2R1Y3QvcGh5Y29yZS1hbTY0eA0KPj4gKyAqLw0KPj4gKw0KPj4g
KyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCj4+ICsjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvbGVkcy9jb21tb24uaD4NCj4+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvbmV0L3RpLWRw
ODM4NjcuaD4NCj4+ICsNCj4+ICsvIHsNCj4+ICsJbW9kZWwgPSAiUEhZVEVDIHBoeUNPUkUtQU02
NHgiOw0KPj4gKwljb21wYXRpYmxlID0gInBoeXRlYyxhbTY0LXBoeWNvcmUtc29tIiwgInRpLGFt
NjQyIjsNCj4+ICsNCj4+ICsJYWxpYXNlcyB7DQo+PiArCQlldGhlcm5ldDAgPSAmY3Bzd19wb3J0
MTsNCj4+ICsJCW1tYzAgPSAmc2RoY2kwOw0KPj4gKwkJcnRjMCA9ICZpMmNfc29tX3J0YzsNCj4+
ICsJfTsNCj4+ICsNCj4+ICsJbWVtb3J5QDgwMDAwMDAwIHsNCj4+ICsJCWRldmljZV90eXBlID0g
Im1lbW9yeSI7DQo+PiArCQlyZWcgPSA8MHgwMDAwMDAwMCAweDgwMDAwMDAwIDB4MDAwMDAwMDAg
MHg4MDAwMDAwMD47DQo+PiArCX07DQo+PiArDQo+PiArCXJlc2VydmVkLW1lbW9yeSB7DQo+PiAr
CQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4+ICsJCSNzaXplLWNlbGxzID0gPDI+Ow0KPj4gKwkJ
cmFuZ2VzOw0KPj4gKw0KPj4gKwkJc2VjdXJlX2Rkcjogb3B0ZWVAOWU4MDAwMDAgew0KPj4gKwkJ
CXJlZyA9IDwweDAwIDB4OWU4MDAwMDAgMHgwMCAweDAxODAwMDAwPjsgLyogZm9yIE9QLVRFRSAq
Lw0KPj4gKwkJCWFsaWdubWVudCA9IDwweDEwMDA+Ow0KPj4gKwkJCW5vLW1hcDsNCj4+ICsJCX07
DQo+PiArCX07DQo+PiArDQo+PiArCWxlZHMgew0KPj4gKwkJY29tcGF0aWJsZSA9ICJncGlvLWxl
ZHMiOw0KPj4gKw0KPj4gKwkJbGVkLTAgew0KPj4gKwkJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVs
dCI7DQo+PiArCQkJcGluY3RybC0wID0gPCZsZWRzX3BpbnNfZGVmYXVsdD47DQo+PiArCQkJY29s
b3IgPSA8TEVEX0NPTE9SX0lEX0dSRUVOPjsNCj4+ICsJCQlncGlvcyA9IDwmbWFpbl9ncGlvMCAx
MiBHUElPX0FDVElWRV9ISUdIPjsNCj4+ICsJCQlsaW51eCxkZWZhdWx0LXRyaWdnZXIgPSAiaGVh
cnRiZWF0IjsNCj4+ICsJCQlmdW5jdGlvbiA9IExFRF9GVU5DVElPTl9IRUFSVEJFQVQ7DQo+PiAr
CQl9Ow0KPj4gKwl9Ow0KPj4gKw0KPj4gKwl2Y2NfNXYwX3NvbTogdmNjLTV2MC1zb20gew0KPiBJ
IGFza2VkIHRvIGRyb3AgImZpeGVkIiwgbm90IG90aGVyIGdlbmVyaWMgcGFydHMuDQo+DQo+IE5v
ZGUgbmFtZXMgc2hvdWxkIGJlIGdlbmVyaWMuDQo+IGh0dHBzOi8vZGV2aWNldHJlZS1zcGVjaWZp
Y2F0aW9uLnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9jaGFwdGVyMi1kZXZpY2V0cmVlLWJhc2lj
cy5odG1sI2dlbmVyaWMtbmFtZXMtcmVjb21tZW5kYXRpb24NCg0KSGV5IEtyenlzenRvZiwNCg0K
b2gsIEkgc2VlIEkgcmVtb3ZlZCB0byBtdWNoIGhlcmUuIFdpbGwgZml4IGl0Lg0KDQouLi4NCg0K
Pj4gKwlsZWRzIHsNCj4+ICsJCWNvbXBhdGlibGUgPSAiZ3Bpby1sZWRzIjsNCj4+ICsJCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiArCQlwaW5jdHJsLTAgPSA8JnVzZXJfbGVkc19waW5z
X2RlZmF1bHQ+Ow0KPj4gKw0KPj4gKwkJbGVkLTEgew0KPj4gKwkJCWNvbG9yID0gPExFRF9DT0xP
Ul9JRF9SRUQ+Ow0KPj4gKwkJCWdwaW9zID0gPCZtYWluX2dwaW8wIDE1IEdQSU9fQUNUSVZFX0hJ
R0g+Ow0KPj4gKwkJCWxpbnV4LGRlZmF1bHQtdHJpZ2dlciA9ICJtbWMwIjsNCj4+ICsJCQlmdW5j
dGlvbiA9IExFRF9GVU5DVElPTl9ESVNLOw0KPj4gKwkJfTsNCj4+ICsNCj4+ICsJCWxlZC0yIHsN
Cj4+ICsJCQljb2xvciA9IDxMRURfQ09MT1JfSURfR1JFRU4+Ow0KPj4gKwkJCWdwaW9zID0gPCZt
YWluX2dwaW8wIDE2IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPj4gKwkJCWxpbnV4LGRlZmF1bHQtdHJp
Z2dlciA9ICJtbWMxIjsNCj4+ICsJCQlmdW5jdGlvbiA9IExFRF9GVU5DVElPTl9ESVNLOw0KPj4g
KwkJfTsNCj4+ICsJfTsNCj4+ICsNCj4+ICsJdmNjXzN2M19tbWM6IHJlZ3VsYXRvci1zZCB7DQo+
IFRoaXMgaXMgYSBmcmllbmRseSByZW1pbmRlciBkdXJpbmcgdGhlIHJldmlldyBwcm9jZXNzLg0K
Pg0KPiBJdCBzZWVtcyBteSBwcmV2aW91cyBjb21tZW50cyB3ZXJlIG5vdCBmdWxseSBhZGRyZXNz
ZWQuIE1heWJlIG15DQo+IGZlZWRiYWNrIGdvdCBsb3N0IGJldHdlZW4gdGhlIHF1b3RlcywgbWF5
YmUgeW91IGp1c3QgZm9yZ290IHRvIGFwcGx5IGl0Lg0KPiBQbGVhc2UgZ28gYmFjayB0byB0aGUg
cHJldmlvdXMgZGlzY3Vzc2lvbiBhbmQgZWl0aGVyIGltcGxlbWVudCBhbGwNCj4gcmVxdWVzdGVk
IGNoYW5nZXMgb3Iga2VlcCBkaXNjdXNzaW5nIHRoZW0uDQoNCkJ1dCB3aGF0IGlzIHdyb25nIHdp
dGggdGhlICJyZWd1bGF0b3Itc2QiIG5vZGUgbmFtZT8NCg0KUmVnYXJkcywNCldhZGltDQoNCj4N
Cj4gVGhhbmsgeW91Lg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPg0KDQo=
