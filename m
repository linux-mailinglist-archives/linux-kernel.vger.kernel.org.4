Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA9A5B8013
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 06:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiINESx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 00:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiINESv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 00:18:51 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8103DBD0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 21:18:50 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B7C022C07C1;
        Wed, 14 Sep 2022 04:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1663129126;
        bh=DPROhToO4YBnKVinA+M5CiobHs5M0Cml08KKMUO5sBU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=O1+JmaAVWiTwJQqXsBB+8Wl5zEt2RFC9rYIVoALf9BsS4Cu3wH+wCAO+z43UyUOaW
         ZQMe3Y1nMdBQWI/8MeP/NwAVESYIYaGGiv4WOlavSVwjiAjK36GE7Zj6FvgmTmq8qu
         2jrs3DMTrkNFPtyr+0Mhf6Xp0oSLtj279audjhHEKG5FVjoCVm0AOE2NsmNd2/9roX
         oZ+dgQL79OmPmt/R6EFngZsFpb9yNEVSigNIoFn3bBTdxhiUBG1EsGcbQE29BaXoHa
         IZh3dZuMLuS6u5qHydI5jXO6KFWpjm0kxiV1lcA8mkRxZEVEYfyXWLKcjorRuscXmP
         +6VRuVvdYXmvA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B632156260001>; Wed, 14 Sep 2022 16:18:46 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 14 Sep 2022 16:18:46 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.040; Wed, 14 Sep 2022 16:18:46 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Lars Melin <larsm17@gmail.com>,
        "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] USB: serial: option: add support for docomo L-03F
Thread-Topic: [PATCH 2/2] USB: serial: option: add support for docomo L-03F
Thread-Index: AQHYx+V+SZCrYsU8NESLV/fctSol063dhs8AgAACZIA=
Date:   Wed, 14 Sep 2022 04:18:45 +0000
Message-ID: <a15dc62e-4a0d-805e-497a-010c9dcc4c9c@alliedtelesis.co.nz>
References: <20220914025541.1018233-1-chris.packham@alliedtelesis.co.nz>
 <20220914025541.1018233-3-chris.packham@alliedtelesis.co.nz>
 <621867a7-e513-c0c8-fb4f-2116d3aa8c7c@gmail.com>
In-Reply-To: <621867a7-e513-c0c8-fb4f-2116d3aa8c7c@gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0393D94113E0034880A8B9CDFDF35270@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eJVtc0h1 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=xOM3xZuef0cA:10 a=l0u4jGKFXs9mNT7XCt8A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNC8wOS8yMiAxNjoxMCwgTGFycyBNZWxpbiB3cm90ZToNCj4gT24gOS8xNC8yMDIyIDA5
OjU1LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBkb2NvbW8g
TC0wM0YgbW9kZW0uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMu
cGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL3VzYi9z
ZXJpYWwvb3B0aW9uLmMgfCAyICsrDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3NlcmlhbC9vcHRpb24uYyBiL2Ry
aXZlcnMvdXNiL3NlcmlhbC9vcHRpb24uYw0KPj4gaW5kZXggMjA2NWYwZmIyZmEwLi4xNGVhZmY1
MDgyMGIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9zZXJpYWwvb3B0aW9uLmMNCj4+ICsr
KyBiL2RyaXZlcnMvdXNiL3NlcmlhbC9vcHRpb24uYw0KPj4gQEAgLTUyNyw2ICs1MjcsNyBAQCBz
dGF0aWMgdm9pZCBvcHRpb25faW5zdGF0X2NhbGxiYWNrKHN0cnVjdCB1cmIgKnVyYik7DQo+PiDC
oCAvKiBMRyBwcm9kdWN0cyAqLw0KPj4gwqAgI2RlZmluZSBMR19WRU5ET1JfSUTCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgxMDA0DQo+PiDCoCAjZGVmaW5lIExHX1BST0RVQ1RfTDAy
Q8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDYxOGYNCj4+ICsjZGVmaW5lIExHX1BS
T0RVQ1RfTDAzRsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDYzNjYNCj4+IMKgIMKg
IC8qIE1lZGlhVGVrIHByb2R1Y3RzICovDQo+PiDCoCAjZGVmaW5lIE1FRElBVEVLX1ZFTkRPUl9J
RMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwZThkDQo+PiBAQCAtMjA3OSw2ICsyMDgwLDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZGV2aWNlX2lkIG9wdGlvbl9pZHNbXSA9IHsNCj4+IMKg
wqDCoMKgwqAgeyBVU0JfREVWSUNFX0FORF9JTlRFUkZBQ0VfSU5GTyhWSUVUVEVMX1ZFTkRPUl9J
RCwgDQo+PiBWSUVUVEVMX1BST0RVQ1RfVlQxMDAwLCAweGZmLCAweGZmLCAweGZmKSB9LA0KPj4g
wqDCoMKgwqDCoCB7IFVTQl9ERVZJQ0VfQU5EX0lOVEVSRkFDRV9JTkZPKFpEX1ZFTkRPUl9JRCwg
WkRfUFJPRFVDVF83MDAwLCANCj4+IDB4ZmYsIDB4ZmYsIDB4ZmYpIH0sDQo+PiDCoMKgwqDCoMKg
IHsgVVNCX0RFVklDRShMR19WRU5ET1JfSUQsIExHX1BST0RVQ1RfTDAyQykgfSwgLyogZG9jb21v
IEwtMDJDIA0KPj4gbW9kZW0gKi8NCj4+ICvCoMKgwqAgeyBVU0JfREVWSUNFKExHX1ZFTkRPUl9J
RCwgTEdfUFJPRFVDVF9MMDNGKSB9LCAvKiBkb2NvbW8gTC0wM0YgDQo+PiBtb2RlbSAqLw0KPj4g
wqDCoMKgwqDCoCB7IFVTQl9ERVZJQ0VfQU5EX0lOVEVSRkFDRV9JTkZPKE1FRElBVEVLX1ZFTkRP
Ul9JRCwgMHgwMGExLCANCj4+IDB4ZmYsIDB4MDAsIDB4MDApIH0sDQo+PiDCoMKgwqDCoMKgIHsg
VVNCX0RFVklDRV9BTkRfSU5URVJGQUNFX0lORk8oTUVESUFURUtfVkVORE9SX0lELCAweDAwYTEs
IA0KPj4gMHhmZiwgMHgwMiwgMHgwMSkgfSwNCj4+IMKgwqDCoMKgwqAgeyBVU0JfREVWSUNFX0FO
RF9JTlRFUkZBQ0VfSU5GTyhNRURJQVRFS19WRU5ET1JfSUQsIDB4MDBhMiwgDQo+PiAweGZmLCAw
eDAwLCAweDAwKSB9LA0KPg0KPg0KPiBIaSwNCj4gdGhpcyBkb2Vzbid0IHNlZW0gdG8gYmUgY29y
cmVjdC4gU2luY2UgdGhpcyBpcyBhIExURSBDQVQzIGhpZ2hzcGVlZCANCj4gZGV2aWNlIGFuZCB0
aGUgbW9kZW0gbWFudWFsIG1lbnRpb25zIE1TIFdpbiBORElTIGRyaXZlciB0aGVuIG9uZSANCj4g
aW50ZXJmYWNlIGlzIGxpa2VseSB0byBiZSBhIFFNSSBpbnRlcmZhY2Ugd2hpY2ggeW91IG11c3Qg
YmxhY2tsaXN0IGluIA0KPiB0aGUgb3B0aW9uIGRyaXZlci4NCj4gUGxlYXNlIHByb3ZpZGUgYSB1
c2ItZGV2aWNlcyBvciB2ZXJib3NlIGxzdXNiIG91dHB1dCBmb3IgdGhlIG1vZGVtLg0KDQpZYW1h
bW90by1zYW4sIGFyZSB5b3UgYWJsZSB0byBwcm92aWRlIHRoZSBsc3VzYiAtdiBvdXRwdXQgZm9y
IHRoaXMgDQpkZXZpY2U/IChPdXIgaW50ZXJuYWwgaXNzdWUgZm9yIHRoZSBjb2RlIGNoYW5nZSBp
cyBDUi01NjEyMCkuDQoNCj4NCj4gdGhhbmtzDQo+IExhcnM=
