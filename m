Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3E6FDA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjEJIzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbjEJIzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:55:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80B21BFD
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:55:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-N3ky-fLINuaf4cVNoHcZnw-1; Wed, 10 May 2023 09:55:28 +0100
X-MC-Unique: N3ky-fLINuaf4cVNoHcZnw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 10 May
 2023 09:55:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 10 May 2023 09:55:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Maxim Kiselev' <bigunclemax@gmail.com>
CC:     Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v3 2/5] spi: sun6i: change OF match data to a struct
Thread-Topic: [PATCH v3 2/5] spi: sun6i: change OF match data to a struct
Thread-Index: AQHZgHJVw1wL+axJhkKYU1TQITl02K9QIrDQgAL/+QCAABUggA==
Date:   Wed, 10 May 2023 08:55:27 +0000
Message-ID: <1592f46b0f794b24a87a964d7208da68@AcuMS.aculab.com>
References: <20230506232616.1792109-1-bigunclemax@gmail.com>
 <20230506232616.1792109-3-bigunclemax@gmail.com>
 <702d085b3b814759a344886364c518f8@AcuMS.aculab.com>
 <CALHCpMh84Q8RAh2Y+cHzAvsm4h5zBZY=9fPF6OVmtLNvX+ePxQ@mail.gmail.com>
In-Reply-To: <CALHCpMh84Q8RAh2Y+cHzAvsm4h5zBZY=9fPF6OVmtLNvX+ePxQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWF4aW0gS2lzZWxldg0KPiBTZW50OiAxMCBNYXkgMjAyMyAwOTozNA0KPiANCj4gSGks
IERhdmlkDQo+IA0KPiA+IElzIGl0IHdvcnRoIGRvaW5nIGEgc3RydWN0dXJlIGNvcHkgYXQgdGhp
cyBwb2ludD8NCj4gPiBUaGUgJ2NmZycgZGF0YSBpcyBzaG9ydCBhbmQgY29uc3RhbnQgYW5kIGl0
IHdvdWxkIG1ha2UNCj4gPiB0aGUgY29kZSB0aGF0IHVzZXMgaXQgc21hbGxlciBhbmQgZmFzdGVy
Lg0KPiANCj4gSSdtIHNvcnJ5IGJ1dCBJIGRvbid0IGZ1bGx5IHVuZGVyc3RhbmQgd2hhdCB5b3Ug
YXJlIHN1Z2dlc3RpbmcuDQo+IEluIHBhdGNoIDNcNSB3ZSBleHRlbmQgdGhlIHN1bjZpX3NwaV9j
Zmcgc3RydWN0dXJlIHdpdGggdGhlIGhhc19jbGtfY3RsIGZpZWxkLg0KDQpZb3UgYXJlIHN0aWxs
IG9ubHkgYWRkaW5nIGEgc2Vjb25kIGludGVnZXIuDQoNCkknbSBzdWdnZXN0aW5nIHRoYXQgaW5z
dGVhZCBvZiBzc3BpLT5jZmcgYmVpbmcgYSBwb2ludGVyIHRvIHRoZQ0KY29uZmlnIGRhdGEgaXQg
aXMgYSBjb3B5IG9mIHRoZSBjb25maWcgZGF0YS4NClNvIHRoZSBhc3NpZ25tZW50IGJlbG93IGJl
Y29tZXMgKGlnbm9yaW5nIGVycm9yIGNoZWNrcykNCgltZW1jcHkoJnNzcGktPmNmZywgb2ZfZGV2
aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpLCBzaXplb2Ygc3NwaS0+Y2ZnKTsNCmFuZCB0
aGUgY29kZSB0aGF0IG5lZWRzIHRoZSB2YWx1ZXMgaXM6DQoJc3NwaS0+Y2ZnLmZpZm9fZGVwdGgN
CihldGMpDQoNCglEYXZpZA0KDQo+IA0KPiDQv9C9LCA4INC80LDRjyAyMDIz4oCv0LMuINCyIDEy
OjQ3LCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBhY3VsYWIuY29tPjoNCj4gPg0KPiA+IEZy
b206IE1ha3NpbSBLaXNlbGV2DQo+ID4gPiBTZW50OiAwNyBNYXkgMjAyMyAwMDoyNg0KPiA+ID4N
Cj4gPiA+IEFzIHdlJ3JlIGFkZGluZyBtb3JlIHByb3BlcnRpZXMgdG8gdGhlIE9GIG1hdGNoIGRh
dGEsIGNvbnZlcnQgaXQgdG8gYQ0KPiA+ID4gc3RydWN0IG5vdy4NCj4gPiA+DQo+ID4gLi4uDQo+
ID4gPiAtICAgICBzc3BpLT5maWZvX2RlcHRoID0gKHVuc2lnbmVkIGxvbmcpb2ZfZGV2aWNlX2dl
dF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOw0KPiA+ID4gKyAgICAgc3NwaS0+Y2ZnID0gb2ZfZGV2
aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOw0KPiA+DQo+ID4gSXMgaXQgd29ydGggZG9p
bmcgYSBzdHJ1Y3R1cmUgY29weSBhdCB0aGlzIHBvaW50Pw0KPiA+IFRoZSAnY2ZnJyBkYXRhIGlz
IHNob3J0IGFuZCBjb25zdGFudCBhbmQgaXQgd291bGQgbWFrZQ0KPiA+IHRoZSBjb2RlIHRoYXQg
dXNlcyBpdCBzbWFsbGVyIGFuZCBmYXN0ZXIuDQo+ID4NCj4gPiAgICAgICAgIERhdmlkDQo+ID4N
Cj4gPiAtDQo+ID4gUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQo+ID4gUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCj4gPg0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

