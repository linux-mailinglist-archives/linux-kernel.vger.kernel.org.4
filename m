Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4C705D27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjEQCXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjEQCW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:22:59 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76AB4EE0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:22:35 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 96CB32C04E1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:22:27 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684290147;
        bh=I1TRBeRFMd1p0Xy4qdKWmd+xZbTpy3cRbMviYdouafA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=pdE4cKzGOqZ7A8qFDIXCJotRiRtuz+Q2HrJ2vDF9p25db9cj4HU4W8vGCVGiCVPOp
         mFzIUaGfERf+qZeeLY2lXDioTmDYPpkHnVw2ziofpVetzPuiN2oIkbz6QvDDZGfg+k
         BgBJHaJGLzrv7CJoJwBEbfArM4SgcE72qSP0aUwMqqrpQQm8gjT32hqxki4BCrJ2nx
         lDCOOgi0CHiQfSDHtMHIFps8CEQsv6pMINp5IDYURMw/Q8swZnZffpjHocddcIsAjB
         Z2P7MU3CbwEo88Igar1/KPUD/DVrddEY1I0LsxS2g9lEuGVx8qtqDn8eQYH9LKxC9w
         m/pFbWZJaN3Bw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64643a630001>; Wed, 17 May 2023 14:22:27 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 14:22:27 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 17 May 2023 14:22:27 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 17 May 2023 14:22:27 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Marvell NFC timings on CN9130
Thread-Topic: Marvell NFC timings on CN9130
Thread-Index: AQHZh7FmJPDyhVgaf0OyIHAzbKJ+o69cXk8AgACV+wA=
Date:   Wed, 17 May 2023 02:22:26 +0000
Message-ID: <40c38662-221f-b9bb-9699-625dd788defd@alliedtelesis.co.nz>
References: <17a9eee2-d84f-549d-a5ff-da88d43393c1@alliedtelesis.co.nz>
 <20230516192538.45b35b6b@xps-13>
In-Reply-To: <20230516192538.45b35b6b@xps-13>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <516FDD8E619228409D55A0DF82E4278B@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=ZyLz09ez2SdZ2DKszXAA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNy8wNS8yMyAwNToyNSwgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4gSGkgQ2hyaXMhDQo+
DQo+IENocmlzLlBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5ueiB3cm90ZSBvbiBUdWUsIDE2IE1h
eSAyMDIzIDA0OjQ2OjM4DQo+ICswMDAwOg0KPg0KPj4gSGkgTWlxdWVsLCBUaG9tYXMsDQo+Pg0K
Pj4gQSBoYXJkd2FyZSBjb2xsZWFndWUgcmVwb3J0ZWQgYSBjb25jZXJuIHRvIG1lIGFib3V0IGEg
bmV3IGRlc2lnbiB3ZSBoYXZlDQo+PiB1c2luZyB0aGUgTWFydmVsbCBDTjkxMzAgU29DICh3aGlj
aCBJIHRoaW5rIHdhcyBjYWxsZWQgQXJtYWRhLThLIGJlZm9yZQ0KPj4gdGhleSByZWJyYW5kZWQp
Lg0KPj4NCj4+IEJhc2ljYWxseSB0aGVpciBjb25jZXJuIGlzIHRoYXQgdGhlIHRXQyB0aW1pbmcg
dGhleSBvYnNlcnZlIGlzIGZhc3Rlcg0KPj4gKH4xOG5zKSB0aGFuIHRoZSBkb2N1bWVudGVkIG1p
bmltdW0gaW4gdGhlIGhhcmR3YXJlIGRhdGFzaGVldCBmb3IgdGhlDQo+PiBDTjkxMzAgKDI1bnMp
LiBBc2lkZSBmcm9tIG5vdCBtZWV0aW5nIHRoZSBkYXRhc2hlZXQgc3BlYyB3ZSd2ZSBub3QNCj4+
IG9ic2VydmVkIGFueSBvdGhlciBpc3N1ZSAoeWV0KS4NCj4gSSB3b3VsZCBoYXZlIGV4cGVjdGVk
IHRoZSBjb250cm9sbGVyIHRvIHN1cHBvcnQgYWxtb3N0IGFueSBraW5kIG9mDQo+IHRpbWluZ3Ms
IGluY2x1ZGluZyBTRFIgRURPIG1vZGUgNS4gdFdDIGlzIDI1bnMgd2l0aCBtb2RlIDQsIGJ1dCAy
MCBvbg0KPiBtb2RlIDUgKE9ORkkpLiBTbyBJIGJlbGlldmUgeW91J3JlIHJ1bm5pbmcgYSBzeXN0
ZW0gd2l0aCBhIGNoaXAgdGhhdCBpcw0KPiBub3QgY29tcGF0aWJsZSB3aXRoIHRoZSBmYXN0ZXN0
IG1vZGUuIElmIHRoYXQgaXMgdGhlIGNhc2UsIGl0IG1heQ0KPiBleHBsYWluIHdoeSB5b3UgZG9u
J3Qgc2VlIGVycm9ycyB3aXRoIHRoaXMgY2hpcDogaXQgbWF5IHN1cHBvcnQNCj4gc2xpZ2h0bHkg
ZmFzdGVyIHRpbWluZ3MgdGhhbiBpdCBhZHZlcnRpc2VzLg0KPg0KPiBBbnl3YXksIGlmIHlvdXIg
ZmluZGluZ3MgYXJlIHRydWUsIGl0IG1lYW5zIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uDQo+
IGlzIHNsaWdodGx5IG91dCBvZiBzcGVjIGFuZCB0aGUgdGltaW5nIGNhbGN1bGF0aW9uIG1pZ2h0
IHJlcXVpcmUgdG8gYmUNCj4gdHdlYWtlZCBhIGxpdHRsZSBiaXQgdG8gcmVkdWNlIHRXQy4NCj4N
Cj4+IEkgbm90aWNlIGluIHRoZSBtYXJ2ZWxsX25hbmQuYyBkcml2ZXIgdGhhdCBtYXJ2ZWxsX25m
Y19pbml0KCkgc2V0cyB0aGUNCj4+IE5BTkQgQ2xvY2sgRnJlcXVlbmN5IFNlbGVjdCBiaXQgKDB4
RjI0NDA3MDA6MCkgdG8gMSB3aGljaCBydW5zIGFjY29yZGluZw0KPj4gdG8gdGhlIGRhdGFzaGVl
dCB0aGUgTkFORCBmbGFzaCBhdCA0MDBNSHogLiBCdXQgdGhlIGNhbGN1bGF0aW9ucyBpbg0KPj4g
bWFydmVsbF9uZmNfc2V0dXBfaW50ZXJmYWNlKCkgdXNlIHRoZSB2YWx1ZSBmcm9tDQo+PiBjbGtf
Z2V0X3JhdGUobmZjLT5jb3JlX2Nsaykgd2hpY2ggaXMgc3RpbGwgMjUwTUh6IHNvIEknbSB3b25k
ZXJpbmcgaWYNCj4+IG1heWJlIHRoZSBmYWN0IHRoYXQgdGhlIE5BTkQgZmxhc2ggaXMgYmVpbmcg
cnVuIGZhc3RlciBpcyBoYXZpbmcgYW4NCj4+IGltcGFjdCBvbiB0aW1pbmdzIHRoYXQgYXJlIGNh
bGN1bGF0ZWQgYXJvdW5kIHRoZSBjb3JlX2NsayBmcmVxdWVuY3kuDQo+IFdoYXQgaWYgeW91IHJl
c2V0IHRoaXMgYml0PyBEbyB5b3Ugb2JzZXJ2ZSBkaWZmZXJlbnQgdGltaW5ncz8gSSBob3BlDQo+
IHlvdSBkbywgb3RoZXJ3aXNlIHRoaXMgaXMgYSBkZWFkLWVuZC4NClllcyBpZiB3ZSBjbGVhciB0
aGUgYml0IHRoZSB0aW1pbmdzIGdvIGZyb20gfjE4bnMgdG8gYWJvdXQgMzBucy4NCj4gVGhlIHRp
bWluZ3MgYXJlIGRlcml2ZWQgZnJvbSB0aGlzIGNsb2NrIGJ1dCBJIHJlbWVtYmVyIHNlZWluZyBk
aWZmZXJlbnQNCj4gcmF0ZXMgdGhhbiB0aGUgb25lcyBJIGV4cGVjdGVkIHdpdGggbm8gb2J2aW91
cyBleHBsYW5hdGlvbiAoc2VlIHRoZSAiKg0KPiAyIiBpbiB0aGUgY2FsY3VsYXRpb24gb2YgcGVy
aW9kX25zIGFuZCB0aGUgY29tbWVudCByaWdodCBiZWxvdykuIFNvDQo+IG1heWJlIHRoaXMgaXMg
ZHVlIHRvIHRoZSA0MDBNSHogdnMuIDI1ME1IeiBpc3N1ZSB5b3UgYXJlIHJlcG9ydGluZywgb3IN
Cj4gdGhlcmUgaXMgYW4gdW5kb2N1bWVudGVkIHByZS1zY2FsZXIgaW4tYmV0d2VlbiAodGhpcyBp
cyBteSBvcmlnaW5hbA0KPiBndWVzcykuDQoNCkkgd29uZGVyZWQgaWYgdGhlICogMiB3YXMgYmVj
YXVzZSBvZiB0aGlzIG9yIGJlY2F1c2Ugb2YgdGhlIGNvbW1lbnQgdGhhdCANCnRoZSBFQ0NfQ0xL
IGlzIDIqTkZfQ0xLLiBUaGF0IHByb2JhYmx5IGFsc28gbWVhbnMgdGhhdCBhIG51bWJlciBvZiBT
b0NzIA0KYXJlIHJ1bm5pbmcgd2l0aCBhbiBleHRyYSAqMiB0aGF0IGRvbid0IG5lZWQgdG8gYmUg
KGUuZy4gQXJtYWRhLTM4NSkuDQoNCj4+IERvIHlvdSB0aGluayB0aGF0IHRoZSB0aW1pbmdzIGNh
bGN1bGF0aW9ucyBzaG91bGQgdGFrZSB0aGUgTkFORCBDbG9jaw0KPj4gRnJlcXVlbmN5IFNlbGVj
dCBzZXR0aW5nIGludG8gYWNjb3VudD8NCj4gVGhlcmUgaXMgbm90IG11Y2ggYWJvdXQgdGhpcyBj
bG9jayBpbiB0aGUgbWFudWFsLCBzbyBpZiB0aGUgY2xvY2sgaXMNCj4gZmVlZGluZyB0aGUgbG9n
aWMgb2YgdGhlIGNvbnRyb2xsZXIgZ2VuZXJhdGluZyB0aGUgc2lnbmFscyBvbiB0aGUgYnVzLA0K
PiB0aGVuIHllcy4gWW91IGNhbiB2ZXJpZnkgdGhpcyB3aXRoIHRoZSB0ZXN0IG1lbnRpb25lZCBh
Ym92ZS4NCj4NCj4gQ291bGQgeW91IGNoZWNrIHRoZSB2YWx1ZXMgc2V0IHRvIHRXUCBhbmQgdFdI
IHdpdGggYW5kIHdpdGhvdXQgdGhlIGJpdA0KPiBhbmQgcHJvYmUgdGhlIHNpZ25hbHMgaW4gYm90
aCBjYXNlcz8gTWF5YmUgdGhlICIqIDIiIGluIHRoZQ0KPiBwZXJpb2RfbnMgY2FsY3VsYXRpb24g
d2lsbCB2YW5pc2ggaWYgd2UgdXNlIDQwME1IeiBhcyBpbnB1dCBjbG9jayByYXRoZXINCj4gdGhh
biBjbGtfZ2V0X3JhdGUoKSAob3IgYmV0dGVyLCBleHBvc2UgdGhlIGJpdCBhcyBhIG11eC1jbG9j
ayBhbmQgdXNlDQo+IGl0IHRvIHRlbGwgdGhlIENDRiB0aGUgcmlnaHQgZnJlcXVlbmN5KSBhbmQg
eW91J2xsIGdldCBhIHNoYXJwZXIgdFdDIGluDQo+IHRoZSBlbmQsIHdoaWNoIGhvcGVmdWxseSBz
aG91bGQgbWF0Y2ggdGhlIHNwZWMgdGhpcyB0aW1lLg0KDQpJIHdhcyBnb2luZyB0byBoYXZlIGEg
bG9vayB0byBzZWUgaWYgSSBjYW4gZ2V0IHRoZSBOQU5EIGNsb2NrIHRvIA0KY29ycmVjdGx5IHJl
ZmxlY3QgdGhlIHZhbHVlIHdoZW4gdGhlIE5BTkQgQ2xvY2sgRnJlcXVlbmN5IFNlbGVjdCBiaXQg
aXMgDQpzZXQuIEluIHRoZSBtZWFudGltZSBJJ2xsIGFsc28gZG8gc29tZSBleHBlcmltZW50cyBy
ZW1vdmluZyB0aGUgKiAyIGFuZCANCmhhcmQtY29kaW5nIHRoZSBmcmVxdWVuY3kgYXQgNDAwTUh6
Lg0K
