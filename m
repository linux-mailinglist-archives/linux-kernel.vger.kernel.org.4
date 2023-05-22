Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4537370B43C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjEVEyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjEVEyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:54:01 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B732CBB
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:53:58 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B9DC52C00C1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:53:55 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684731235;
        bh=W012hPwq1lSLxWgcLCrWwL7vv+zpJZHAc2c8SqGFrLw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VMrhGF6TFZ4DEI5sndHHO7koXudl5ulw5MK4pKlX0Yka36cf2IYU3r65zv2YNpaM/
         9U1GVkS9QY/DdVgbH9P1Ln9v6bn5C6zXQzm/OUqL8vCKxWn8EJRzfuGD6w7rkq+eDj
         TWcwTac5hTthfJ4IILnmlGXLlcGZ01L916pX4VxW54o5ok7xGcmQ+pyUTYmCbkFOg5
         +y+BmDKi7zQw2jVaOWSjzdCjN75NCQ/9GuqeKzRWgwnYi7AheqhOm02Jo7EF2c5ZFz
         qVDmJOw5p6SIXz5ECyJomJS6JX/bcilYOFlLK3VVCXTHc6SGDO6nUPsH7ySNXiRIND
         Y+fYoQ0gQSAPA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646af5630001>; Mon, 22 May 2023 16:53:55 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 16:53:55 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Mon, 22 May 2023 16:53:55 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Mon, 22 May 2023 16:53:55 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Marvell NFC timings on CN9130
Thread-Topic: Marvell NFC timings on CN9130
Thread-Index: AQHZh7FmJPDyhVgaf0OyIHAzbKJ+o69cXk8AgACV+wCAB6FNAIAAZK0A
Date:   Mon, 22 May 2023 04:53:54 +0000
Message-ID: <7eb842b6-77c4-05ad-b984-4bb7ae11c278@alliedtelesis.co.nz>
References: <17a9eee2-d84f-549d-a5ff-da88d43393c1@alliedtelesis.co.nz>
 <20230516192538.45b35b6b@xps-13>
 <40c38662-221f-b9bb-9699-625dd788defd@alliedtelesis.co.nz>
 <82b16918-8930-80ab-a87f-a5eefbff2a70@alliedtelesis.co.nz>
In-Reply-To: <82b16918-8930-80ab-a87f-a5eefbff2a70@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F8FF6B505EF474B8CFE7EB5C69A803A@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=I1XxGAnUKxW7y460cr8A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMi8wNS8yMyAxMDo1MywgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4NCj4gT24gMTcvMDUv
MjMgMTQ6MjIsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pg0KPj4gT24gMTcvMDUvMjMgMDU6MjUs
IE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+Pj4gSGkgQ2hyaXMhDQo+Pj4NCj4+PiBDaHJpcy5QYWNr
aGFtQGFsbGllZHRlbGVzaXMuY28ubnogd3JvdGUgb24gVHVlLCAxNiBNYXkgMjAyMyAwNDo0Njoz
OA0KPj4+ICswMDAwOg0KPj4+DQo+Pj4+IEhpIE1pcXVlbCwgVGhvbWFzLA0KPj4+Pg0KPj4+PiBB
IGhhcmR3YXJlIGNvbGxlYWd1ZSByZXBvcnRlZCBhIGNvbmNlcm4gdG8gbWUgYWJvdXQgYSBuZXcg
ZGVzaWduIHdlIA0KPj4+PiBoYXZlDQo+Pj4+IHVzaW5nIHRoZSBNYXJ2ZWxsIENOOTEzMCBTb0Mg
KHdoaWNoIEkgdGhpbmsgd2FzIGNhbGxlZCBBcm1hZGEtOEsgDQo+Pj4+IGJlZm9yZQ0KPj4+PiB0
aGV5IHJlYnJhbmRlZCkuDQo+Pj4+DQo+Pj4+IEJhc2ljYWxseSB0aGVpciBjb25jZXJuIGlzIHRo
YXQgdGhlIHRXQyB0aW1pbmcgdGhleSBvYnNlcnZlIGlzIGZhc3Rlcg0KPj4+PiAofjE4bnMpIHRo
YW4gdGhlIGRvY3VtZW50ZWQgbWluaW11bSBpbiB0aGUgaGFyZHdhcmUgZGF0YXNoZWV0IGZvciB0
aGUNCj4+Pj4gQ045MTMwICgyNW5zKS4gQXNpZGUgZnJvbSBub3QgbWVldGluZyB0aGUgZGF0YXNo
ZWV0IHNwZWMgd2UndmUgbm90DQo+Pj4+IG9ic2VydmVkIGFueSBvdGhlciBpc3N1ZSAoeWV0KS4N
Cj4+PiBJIHdvdWxkIGhhdmUgZXhwZWN0ZWQgdGhlIGNvbnRyb2xsZXIgdG8gc3VwcG9ydCBhbG1v
c3QgYW55IGtpbmQgb2YNCj4+PiB0aW1pbmdzLCBpbmNsdWRpbmcgU0RSIEVETyBtb2RlIDUuIHRX
QyBpcyAyNW5zIHdpdGggbW9kZSA0LCBidXQgMjAgb24NCj4+PiBtb2RlIDUgKE9ORkkpLiBTbyBJ
IGJlbGlldmUgeW91J3JlIHJ1bm5pbmcgYSBzeXN0ZW0gd2l0aCBhIGNoaXAgdGhhdCBpcw0KPj4+
IG5vdCBjb21wYXRpYmxlIHdpdGggdGhlIGZhc3Rlc3QgbW9kZS4gSWYgdGhhdCBpcyB0aGUgY2Fz
ZSwgaXQgbWF5DQo+Pj4gZXhwbGFpbiB3aHkgeW91IGRvbid0IHNlZSBlcnJvcnMgd2l0aCB0aGlz
IGNoaXA6IGl0IG1heSBzdXBwb3J0DQo+Pj4gc2xpZ2h0bHkgZmFzdGVyIHRpbWluZ3MgdGhhbiBp
dCBhZHZlcnRpc2VzLg0KPj4+DQo+Pj4gQW55d2F5LCBpZiB5b3VyIGZpbmRpbmdzIGFyZSB0cnVl
LCBpdCBtZWFucyB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbg0KPj4+IGlzIHNsaWdodGx5IG91
dCBvZiBzcGVjIGFuZCB0aGUgdGltaW5nIGNhbGN1bGF0aW9uIG1pZ2h0IHJlcXVpcmUgdG8gYmUN
Cj4+PiB0d2Vha2VkIGEgbGl0dGxlIGJpdCB0byByZWR1Y2UgdFdDLg0KPj4+DQo+Pj4+IEkgbm90
aWNlIGluIHRoZSBtYXJ2ZWxsX25hbmQuYyBkcml2ZXIgdGhhdCBtYXJ2ZWxsX25mY19pbml0KCkg
c2V0cyB0aGUNCj4+Pj4gTkFORCBDbG9jayBGcmVxdWVuY3kgU2VsZWN0IGJpdCAoMHhGMjQ0MDcw
MDowKSB0byAxIHdoaWNoIHJ1bnMgDQo+Pj4+IGFjY29yZGluZw0KPj4+PiB0byB0aGUgZGF0YXNo
ZWV0IHRoZSBOQU5EIGZsYXNoIGF0IDQwME1IeiAuIEJ1dCB0aGUgY2FsY3VsYXRpb25zIGluDQo+
Pj4+IG1hcnZlbGxfbmZjX3NldHVwX2ludGVyZmFjZSgpIHVzZSB0aGUgdmFsdWUgZnJvbQ0KPj4+
PiBjbGtfZ2V0X3JhdGUobmZjLT5jb3JlX2Nsaykgd2hpY2ggaXMgc3RpbGwgMjUwTUh6IHNvIEkn
bSB3b25kZXJpbmcgaWYNCj4+Pj4gbWF5YmUgdGhlIGZhY3QgdGhhdCB0aGUgTkFORCBmbGFzaCBp
cyBiZWluZyBydW4gZmFzdGVyIGlzIGhhdmluZyBhbg0KPj4+PiBpbXBhY3Qgb24gdGltaW5ncyB0
aGF0IGFyZSBjYWxjdWxhdGVkIGFyb3VuZCB0aGUgY29yZV9jbGsgZnJlcXVlbmN5Lg0KPj4+IFdo
YXQgaWYgeW91IHJlc2V0IHRoaXMgYml0PyBEbyB5b3Ugb2JzZXJ2ZSBkaWZmZXJlbnQgdGltaW5n
cz8gSSBob3BlDQo+Pj4geW91IGRvLCBvdGhlcndpc2UgdGhpcyBpcyBhIGRlYWQtZW5kLg0KPj4g
WWVzIGlmIHdlIGNsZWFyIHRoZSBiaXQgdGhlIHRpbWluZ3MgZ28gZnJvbSB+MThucyB0byBhYm91
dCAzMG5zLg0KPj4+IFRoZSB0aW1pbmdzIGFyZSBkZXJpdmVkIGZyb20gdGhpcyBjbG9jayBidXQg
SSByZW1lbWJlciBzZWVpbmcgZGlmZmVyZW50DQo+Pj4gcmF0ZXMgdGhhbiB0aGUgb25lcyBJIGV4
cGVjdGVkIHdpdGggbm8gb2J2aW91cyBleHBsYW5hdGlvbiAoc2VlIHRoZSAiKg0KPj4+IDIiIGlu
IHRoZSBjYWxjdWxhdGlvbiBvZiBwZXJpb2RfbnMgYW5kIHRoZSBjb21tZW50IHJpZ2h0IGJlbG93
KS4gU28NCj4+PiBtYXliZSB0aGlzIGlzIGR1ZSB0byB0aGUgNDAwTUh6IHZzLiAyNTBNSHogaXNz
dWUgeW91IGFyZSByZXBvcnRpbmcsIG9yDQo+Pj4gdGhlcmUgaXMgYW4gdW5kb2N1bWVudGVkIHBy
ZS1zY2FsZXIgaW4tYmV0d2VlbiAodGhpcyBpcyBteSBvcmlnaW5hbA0KPj4+IGd1ZXNzKS4NCj4+
DQo+PiBJIHdvbmRlcmVkIGlmIHRoZSAqIDIgd2FzIGJlY2F1c2Ugb2YgdGhpcyBvciBiZWNhdXNl
IG9mIHRoZSBjb21tZW50IA0KPj4gdGhhdCB0aGUgRUNDX0NMSyBpcyAyKk5GX0NMSy4gVGhhdCBw
cm9iYWJseSBhbHNvIG1lYW5zIHRoYXQgYSBudW1iZXIgDQo+PiBvZiBTb0NzIGFyZSBydW5uaW5n
IHdpdGggYW4gZXh0cmEgKjIgdGhhdCBkb24ndCBuZWVkIHRvIGJlIChlLmcuIA0KPj4gQXJtYWRh
LTM4NSkuDQo+IEludGVyZXN0aW5nbHkgY3AxMTAtc3lzdGVtLWNvbnRyb2xsZXIuYyBpcyBhd2Fy
ZSBvZiB0aGUgNDAwTUh6IG9wdGlvbiANCj4gYnV0IHRoYXQncyBvbmx5IGVmZmVjdGl2ZSBpZiBp
dCdzIGJlZW4gc2V0IHByaW9yIHRvIHRoZSBrZXJuZWwgDQo+IGJvb3RpbmcuIEknbSBub3QgcmVh
bGx5IGZhbWlsaWFyIHdpdGggY2xrIGRyaXZlcnMgYnV0IEkgYXNzdW1lIGl0IG11c3QgDQo+IGJl
IHBvc3NpYmxlIHRvIG1ha2UgaXQgbG9vayB1cCB0aGUgZnJlcXVlbmN5IGR5bmFtaWNhbGx5IGlu
c3RlYWQgb2YgDQo+IHVzaW5nIGEgc2luZ2xlIGZpeGVkIHZhbHVlLg0KPj4NCj4+Pj4gRG8geW91
IHRoaW5rIHRoYXQgdGhlIHRpbWluZ3MgY2FsY3VsYXRpb25zIHNob3VsZCB0YWtlIHRoZSBOQU5E
IENsb2NrDQo+Pj4+IEZyZXF1ZW5jeSBTZWxlY3Qgc2V0dGluZyBpbnRvIGFjY291bnQ/DQo+Pj4g
VGhlcmUgaXMgbm90IG11Y2ggYWJvdXQgdGhpcyBjbG9jayBpbiB0aGUgbWFudWFsLCBzbyBpZiB0
aGUgY2xvY2sgaXMNCj4+PiBmZWVkaW5nIHRoZSBsb2dpYyBvZiB0aGUgY29udHJvbGxlciBnZW5l
cmF0aW5nIHRoZSBzaWduYWxzIG9uIHRoZSBidXMsDQo+Pj4gdGhlbiB5ZXMuIFlvdSBjYW4gdmVy
aWZ5IHRoaXMgd2l0aCB0aGUgdGVzdCBtZW50aW9uZWQgYWJvdmUuDQo+Pj4NCj4+PiBDb3VsZCB5
b3UgY2hlY2sgdGhlIHZhbHVlcyBzZXQgdG8gdFdQIGFuZCB0V0ggd2l0aCBhbmQgd2l0aG91dCB0
aGUgYml0DQo+Pj4gYW5kIHByb2JlIHRoZSBzaWduYWxzIGluIGJvdGggY2FzZXM/IE1heWJlIHRo
ZSAiKiAyIiBpbiB0aGUNCj4+PiBwZXJpb2RfbnMgY2FsY3VsYXRpb24gd2lsbCB2YW5pc2ggaWYg
d2UgdXNlIDQwME1IeiBhcyBpbnB1dCBjbG9jayANCj4+PiByYXRoZXINCj4+PiB0aGFuIGNsa19n
ZXRfcmF0ZSgpIChvciBiZXR0ZXIsIGV4cG9zZSB0aGUgYml0IGFzIGEgbXV4LWNsb2NrIGFuZCB1
c2UNCj4+PiBpdCB0byB0ZWxsIHRoZSBDQ0YgdGhlIHJpZ2h0IGZyZXF1ZW5jeSkgYW5kIHlvdSds
bCBnZXQgYSBzaGFycGVyIHRXQyBpbg0KPj4+IHRoZSBlbmQsIHdoaWNoIGhvcGVmdWxseSBzaG91
bGQgbWF0Y2ggdGhlIHNwZWMgdGhpcyB0aW1lLg0KPj4NCj4+IEkgd2FzIGdvaW5nIHRvIGhhdmUg
YSBsb29rIHRvIHNlZSBpZiBJIGNhbiBnZXQgdGhlIE5BTkQgY2xvY2sgdG8gDQo+PiBjb3JyZWN0
bHkgcmVmbGVjdCB0aGUgdmFsdWUgd2hlbiB0aGUgTkFORCBDbG9jayBGcmVxdWVuY3kgU2VsZWN0
IGJpdCANCj4+IGlzIHNldC4gSW4gdGhlIG1lYW50aW1lIEknbGwgYWxzbyBkbyBzb21lIGV4cGVy
aW1lbnRzIHJlbW92aW5nIHRoZSAqIA0KPj4gMiBhbmQgaGFyZC1jb2RpbmcgdGhlIGZyZXF1ZW5j
eSBhdCA0MDBNSHouDQoNCkkgbGVhcm50IHNvbWV0aGluZyBvdmVyIHRoZSBjb3Vyc2Ugb2YgdGhl
IGRheS4gR2l2ZW4gdGltZXpvbmVzIEkgdGhvdWdodCANCml0IG1pZ2h0IGJlIHdvcnRod2hpbGUg
Z2V0dGluZyB0aGVtIG91dCB0aGVyZSBldmVuIGlmIEkgZG9uJ3QgaGF2ZSBhIA0KcGF0Y2ggdG8g
b2ZmZXIuDQoNCkl0IGFwcGVhcnMgdGhhdCBvbmx5IHRoZSBmaXJzdCBzZXQgb2YgdGltaW5ncyBj
YWxjdWxhdGVkIGJ5IA0KbWFydmVsbF9uZmNfc2V0dXBfaW50ZXJmYWNlKCkgYXJlIHVzZWQuIFRo
aXMgaXMgYmVjYXVzZSANCm1hcnZlbGxfbmZjX3NlbGVjdF90YXJnZXQoKSByZXR1cm5zIGVhcmx5
IGlmIHdlIGFyZSBhZGRyZXNzaW5nIHRoZSBzYW1lIA0KY2hpcC4gU28gZXZlbiB3aGVuIHdlIHRh
a2UgdGhlIFNEUiB0aW1pbmdzIGludG8gYWNjb3VudCB3ZSBkb24ndCBtYWtlIA0KZnVsbCB1c2Ug
b2YgdGhlbSBpbiBORFRSMC8xLg0KDQpUaGUgb3JpZ2luYWwgcHJvYmxlbSBJIHJlcG9ydGVkIHdh
cyBmcm9tIGEgY3VzdG9taXplZCBrZXJuZWwgd2hpY2ggDQppbmNsdWRlZCBhIGNoYW5nZSB0byB3
cml0ZSBvdXQgdGhlIE5EVFIwLzEgcmVnaXN0ZXJzIGF0IHRoZSBlbmQgb2YgDQptYXJ2ZWxsX25m
Y19zZXR1cF9pbnRlcmZhY2UoKS4gU28gSSBjYW4gbWFrZSBteSBwcm9ibGVtIGdvIGF3YXkgYnkg
DQpyZW1vdmluZyB0aGUgd3JpdGVzIHRvIE5EVFIwLzEgYnV0IHRoZW4gaW5zdGVhZCBvZiBiZWlu
ZyB0b28gZmFzdCB0aGV5IA0KYXJlIG5vdyB3YXkgdG9vIHNsb3cuIFRoYXQnZCBwcm9iYWJseSBr
ZWVwIHRoZSBIVyBlbmdpbmVlcnMgaGFwcHkgYnV0IGl0IA0KZmVlbHMgYSBiaXQgd3JvbmcuDQo=
