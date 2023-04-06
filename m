Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222576D9CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbjDFPzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbjDFPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:55:05 -0400
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27764220;
        Thu,  6 Apr 2023 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680796473;
        bh=aGyEXzPa8YH6WaNPSKSU0M7hG3BsQaGFWIDWPmDpoMc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ptEW6P3e0jPsHn1wvrfBisUeGPr1C/x3zMMpejuZoeYIb0OT7qymYEBE6o+clIGYQ
         cBk6mpeyB5xZpNGluteRXoGE4jsIGybOPe6KXf7os2FvuP73dd54rpDPfdZhwRbYOv
         tX6YVa2Iq9HFQEXMS8sZe8PD/JEBDscS1LiPyZfijVex2HSWnJXsLzD6OboI813ZmI
         hsND0Tn8Y01E7meGgU+cgYS194FurcNlJEH3Sj3SdBL+7fjV1bJ+8fUJ5QssaPtpOR
         Z2fIk3xud7dtmrTFqeYkwBons7YBXGGDneoSiT03BJCLiQidzZGQaIwJkQbOq0hy/B
         cGH4VQKOeqX3A==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        "Fabio Estevam" <festevam@denx.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: Add Marantec vendor prefix
Thread-Topic: [PATCH 1/3] dt-bindings: Add Marantec vendor prefix
Thread-Index: AQHZaJ75I9rbTopSl0Sohnb4PSTFTq8ebg9g
Date:   Thu, 6 Apr 2023 15:54:25 +0000
Message-ID: <73e37d840de5411f816fafe2ba7074c3@dh-electronics.com>
References: <20230406154529.6349-1-cniedermaier@dh-electronics.com>
In-Reply-To: <20230406154529.6349-1-cniedermaier@dh-electronics.com>
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

RnJvbTogQ2hyaXN0b3BoIE5pZWRlcm1haWVyIFttYWlsdG86Y25pZWRlcm1haWVyQGRoLWVsZWN0
cm9uaWNzLmNvbV0NClNlbnQ6IFRodXJzZGF5LCBBcHJpbCA2LCAyMDIzIDU6NDUgUE0NCj4gDQo+
IEFkZCB2ZW5kb3IgcHJlZml4IGZvciBNYXJhbnRlYyBlbGVjdHJvbmljcyBHbWJILg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIE5pZWRlcm1haWVyIDxjbmllZGVybWFpZXJAZGgtZWxl
Y3Ryb25pY3MuY29tPg0KPiAtLS0NCj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5v
cmc+DQo+IENjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxp
bmFyby5vcmc+DQo+IENjOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gQ2M6IEZhYmlv
IEVzdGV2YW0gPGZlc3RldmFtQGRlbnguZGU+DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBUbzogbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IC0tLQ0KPiBWMjogLSBBZGQgdGhpcyBwYXRj
aCB0byB0aGUgc2VyaWVzDQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3ZlbmRvci1wcmVmaXhlcy55YW1sIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbA0KPiBpbmRleCAwNTU3MDRkY2UzZDEuLmY1
OGU1ZWYyYmVkZCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3ZlbmRvci1wcmVmaXhlcy55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbA0KPiBAQCAtNzg5LDYgKzc4OSw4IEBAIHBh
dHRlcm5Qcm9wZXJ0aWVzOg0KPiAgICAgIGRlc2NyaXB0aW9uOiBNYW50aXggRGlzcGxheSBUZWNo
bm9sb2d5IENvLixMdGQuDQo+ICAgICJebWFwbGVib2FyZCwuKiI6DQo+ICAgICAgZGVzY3JpcHRp
b246IE1hcGxlYm9hcmQub3JnDQo+ICsgICJebWFyYW50ZWMsLioiOg0KPiArICAgIGRlc2NyaXB0
aW9uOiBNYXJhbnRlYyBlbGVjdHJvbmljcyBHbWJIDQo+ICAgICJebWFydmVsbCwuKiI6DQo+ICAg
ICAgZGVzY3JpcHRpb246IE1hcnZlbGwgVGVjaG5vbG9neSBHcm91cCBMdGQuDQo+ICAgICJebWF4
Ym90aXgsLioiOg0KPiAtLQ0KPiAyLjExLjANCg0KSWdub3JlIHRoaXMgcGF0Y2gsIEkgZm9yZ290
IHRoZSBWMiBwcmVmaXguDQo=
