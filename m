Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B755F6E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiJFTov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiJFTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:44:47 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B115D25C7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:44:46 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 001832C04A9;
        Thu,  6 Oct 2022 19:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1665085483;
        bh=vP/3ZTI4O6+JWANxa0Lbd754uOaN+AdF32Rz5G6KBZI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PtwuFlpqWQ/T+NKoZsAtF2WgwxRrhZmN2pG3t46YOpjMfLzWsj7GRXWuXrZHyKep+
         BnUD/B1AustrnoMct4NWj6cpDvK/VW5FXLDiDAqeKzfKmTsupNU/1jGHXooXlEhGzX
         4swC9L6c5eJnvjwZIWuSa0A4RIN6kU/n4XEcg10L2fcF51AfkwuRN1QGKy7KrLqTtg
         dGJc158nY9w3Nv2tEJQ2XJ+rBYXJWAQxrixdg1awFwwa9qSF2h8IxmD2fDa0O2YQpW
         4+WGOVtKbLPe3ZhDsXAJk1xge8TgmwOUe9nSnUlwdxaYT6xMKx2vOU14+QAUXrf/nD
         6BsDM5iuu+2pw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B633f302a0001>; Fri, 07 Oct 2022 08:44:42 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 7 Oct 2022 08:44:42 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.040; Fri, 7 Oct 2022 08:44:42 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Lars Melin <larsm17@gmail.com>,
        "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] USB: serial: option: add support for docomo L-03F
Thread-Topic: [PATCH 2/2] USB: serial: option: add support for docomo L-03F
Thread-Index: AQHYx+V+SZCrYsU8NESLV/fctSol063dhs8AgAACZICAI4U8AA==
Date:   Thu, 6 Oct 2022 19:44:42 +0000
Message-ID: <699018fe-dabc-21fc-1080-154555f210eb@alliedtelesis.co.nz>
References: <20220914025541.1018233-1-chris.packham@alliedtelesis.co.nz>
 <20220914025541.1018233-3-chris.packham@alliedtelesis.co.nz>
 <621867a7-e513-c0c8-fb4f-2116d3aa8c7c@gmail.com>
 <a15dc62e-4a0d-805e-497a-010c9dcc4c9c@alliedtelesis.co.nz>
In-Reply-To: <a15dc62e-4a0d-805e-497a-010c9dcc4c9c@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <27690313009F0149A9DA4343023FA1DA@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=UKij4xXy c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10 a=OfZ2qkOypkaOp9PJaTgA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGFycywNCg0KT24gMTQvMDkvMjIgMTY6MTgsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+DQo+
IE9uIDE0LzA5LzIyIDE2OjEwLCBMYXJzIE1lbGluIHdyb3RlOg0KPj4gT24gOS8xNC8yMDIyIDA5
OjU1LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+IEFkZCBzdXBwb3J0IGZvciB0aGUgZG9jb21v
IEwtMDNGIG1vZGVtLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hy
aXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4+IC0tLQ0KPj4+IMKgIGRyaXZlcnMv
dXNiL3NlcmlhbC9vcHRpb24uYyB8IDIgKysNCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Ivc2VyaWFsL29wdGlv
bi5jIGIvZHJpdmVycy91c2Ivc2VyaWFsL29wdGlvbi5jDQo+Pj4gaW5kZXggMjA2NWYwZmIyZmEw
Li4xNGVhZmY1MDgyMGIgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy91c2Ivc2VyaWFsL29wdGlv
bi5jDQo+Pj4gKysrIGIvZHJpdmVycy91c2Ivc2VyaWFsL29wdGlvbi5jDQo+Pj4gQEAgLTUyNyw2
ICs1MjcsNyBAQCBzdGF0aWMgdm9pZCBvcHRpb25faW5zdGF0X2NhbGxiYWNrKHN0cnVjdCB1cmIg
DQo+Pj4gKnVyYik7DQo+Pj4gwqAgLyogTEcgcHJvZHVjdHMgKi8NCj4+PiDCoCAjZGVmaW5lIExH
X1ZFTkRPUl9JRMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDEwMDQNCj4+PiDCoCAj
ZGVmaW5lIExHX1BST0RVQ1RfTDAyQ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDYx
OGYNCj4+PiArI2RlZmluZSBMR19QUk9EVUNUX0wwM0bCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMHg2MzY2DQo+Pj4gwqAgwqAgLyogTWVkaWFUZWsgcHJvZHVjdHMgKi8NCj4+PiDCoCAj
ZGVmaW5lIE1FRElBVEVLX1ZFTkRPUl9JRMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwZThkDQo+
Pj4gQEAgLTIwNzksNiArMjA4MCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9p
ZCBvcHRpb25faWRzW10gDQo+Pj4gPSB7DQo+Pj4gwqDCoMKgwqDCoCB7IFVTQl9ERVZJQ0VfQU5E
X0lOVEVSRkFDRV9JTkZPKFZJRVRURUxfVkVORE9SX0lELCANCj4+PiBWSUVUVEVMX1BST0RVQ1Rf
VlQxMDAwLCAweGZmLCAweGZmLCAweGZmKSB9LA0KPj4+IMKgwqDCoMKgwqAgeyBVU0JfREVWSUNF
X0FORF9JTlRFUkZBQ0VfSU5GTyhaRF9WRU5ET1JfSUQsIFpEX1BST0RVQ1RfNzAwMCwgDQo+Pj4g
MHhmZiwgMHhmZiwgMHhmZikgfSwNCj4+PiDCoMKgwqDCoMKgIHsgVVNCX0RFVklDRShMR19WRU5E
T1JfSUQsIExHX1BST0RVQ1RfTDAyQykgfSwgLyogZG9jb21vIEwtMDJDIA0KPj4+IG1vZGVtICov
DQo+Pj4gK8KgwqDCoCB7IFVTQl9ERVZJQ0UoTEdfVkVORE9SX0lELCBMR19QUk9EVUNUX0wwM0Yp
IH0sIC8qIGRvY29tbyBMLTAzRiANCj4+PiBtb2RlbSAqLw0KPj4+IMKgwqDCoMKgwqAgeyBVU0Jf
REVWSUNFX0FORF9JTlRFUkZBQ0VfSU5GTyhNRURJQVRFS19WRU5ET1JfSUQsIDB4MDBhMSwgDQo+
Pj4gMHhmZiwgMHgwMCwgMHgwMCkgfSwNCj4+PiDCoMKgwqDCoMKgIHsgVVNCX0RFVklDRV9BTkRf
SU5URVJGQUNFX0lORk8oTUVESUFURUtfVkVORE9SX0lELCAweDAwYTEsIA0KPj4+IDB4ZmYsIDB4
MDIsIDB4MDEpIH0sDQo+Pj4gwqDCoMKgwqDCoCB7IFVTQl9ERVZJQ0VfQU5EX0lOVEVSRkFDRV9J
TkZPKE1FRElBVEVLX1ZFTkRPUl9JRCwgMHgwMGEyLCANCj4+PiAweGZmLCAweDAwLCAweDAwKSB9
LA0KPj4NCj4+DQo+PiBIaSwNCj4+IHRoaXMgZG9lc24ndCBzZWVtIHRvIGJlIGNvcnJlY3QuIFNp
bmNlIHRoaXMgaXMgYSBMVEUgQ0FUMyBoaWdoc3BlZWQgDQo+PiBkZXZpY2UgYW5kIHRoZSBtb2Rl
bSBtYW51YWwgbWVudGlvbnMgTVMgV2luIE5ESVMgZHJpdmVyIHRoZW4gb25lIA0KPj4gaW50ZXJm
YWNlIGlzIGxpa2VseSB0byBiZSBhIFFNSSBpbnRlcmZhY2Ugd2hpY2ggeW91IG11c3QgYmxhY2ts
aXN0IGluIA0KPj4gdGhlIG9wdGlvbiBkcml2ZXIuDQo+PiBQbGVhc2UgcHJvdmlkZSBhIHVzYi1k
ZXZpY2VzIG9yIHZlcmJvc2UgbHN1c2Igb3V0cHV0IGZvciB0aGUgbW9kZW0uDQo+DQo+IFlhbWFt
b3RvLXNhbiwgYXJlIHlvdSBhYmxlIHRvIHByb3ZpZGUgdGhlIGxzdXNiIC12IG91dHB1dCBmb3Ig
dGhpcyANCj4gZGV2aWNlPyAoT3VyIGludGVybmFsIGlzc3VlIGZvciB0aGUgY29kZSBjaGFuZ2Ug
aXMgQ1ItNTYxMjApLg0KPg0KSnVzdCBmb2xsb3dpbmcgdXAgb24gdGhpcy4gSSd2ZSBub3QgYmVl
biBhYmxlIHRvIHRyYWNrIGRvd24gb25lIG9mIHRoZSANCmFjdHVhbCBtb2RlbXMgYW5kIGhhdmUg
aGFkIHJhZGlvIHNpbGVuY2UgZnJvbSBteSBjb2xsZWFndWVzIHdobyBkaWQgdGhlIA0Kb3JpZ2lu
YWwgd29yay4NCg0KSXMgdGhlIDEvMiBwYXRjaCBvZiB0aGlzIHNlcmllcyBhY2NlcHRhYmxlIG9u
IGl0J3Mgb3duPyAoc2hvdWxkIEkgcmViYXNlIA0KYW5kIHJlc3VibWl0IGl0KS4NCg0KPj4NCj4+
IHRoYW5rcw0KPj4gTGFycw==
