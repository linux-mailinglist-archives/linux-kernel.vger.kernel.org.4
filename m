Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2FC70B1DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjEUWxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUWxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:53:41 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA73BF
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 15:53:39 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C9C9C2C0616
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:53:35 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684709615;
        bh=E2tFjC9bvpMCMFRl5dve/Zk4d5eGsp/Jdzl8wdV2rJo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lvwM7mhzNxJJHgIEEvBehCgsDzUf7ULSIVlSZBvDTjuT4rYQTxH1r1A+avjH42R/q
         DDr9dF3b9C6R3YpOCQFbLqAci4g86jOFIZjkkYnHC106+dCiFFUhs0rWhPPoE/C5Mz
         6AX/3Py5k272zk9jPJ6yEwdFu72kAEmgh5cRF30CHPkB5p7CTj8d3ly2xOsJcdfHwh
         dUrN+h00qdmDldND3l5IApHerpPayU3lY8kZtfYneIQQi7tilAs0KDRh/afOAS7AY5
         jDbltJnS0c8GbwNrLCHg0AQJ7LKljgpDatY4iUt/CCc0fO4F06K3N/QFQgYhWQtGyl
         hEuuT8MG4USAA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646aa0ef0001>; Mon, 22 May 2023 10:53:35 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 10:53:35 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Mon, 22 May 2023 10:53:35 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Mon, 22 May 2023 10:53:35 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Marvell NFC timings on CN9130
Thread-Topic: Marvell NFC timings on CN9130
Thread-Index: AQHZh7FmJPDyhVgaf0OyIHAzbKJ+o69cXk8AgACV+wCAB6FNAA==
Date:   Sun, 21 May 2023 22:53:35 +0000
Message-ID: <82b16918-8930-80ab-a87f-a5eefbff2a70@alliedtelesis.co.nz>
References: <17a9eee2-d84f-549d-a5ff-da88d43393c1@alliedtelesis.co.nz>
 <20230516192538.45b35b6b@xps-13>
 <40c38662-221f-b9bb-9699-625dd788defd@alliedtelesis.co.nz>
In-Reply-To: <40c38662-221f-b9bb-9699-625dd788defd@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D6056701DCEA64C8C6F8D8AE3A4812E@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=1FG7ZAwjbe0fjcAriRkA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNy8wNS8yMyAxNDoyMiwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4NCj4gT24gMTcvMDUv
MjMgMDU6MjUsIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+PiBIaSBDaHJpcyENCj4+DQo+PiBDaHJp
cy5QYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubnogd3JvdGUgb24gVHVlLCAxNiBNYXkgMjAyMyAw
NDo0NjozOA0KPj4gKzAwMDA6DQo+Pg0KPj4+IEhpIE1pcXVlbCwgVGhvbWFzLA0KPj4+DQo+Pj4g
QSBoYXJkd2FyZSBjb2xsZWFndWUgcmVwb3J0ZWQgYSBjb25jZXJuIHRvIG1lIGFib3V0IGEgbmV3
IGRlc2lnbiB3ZSANCj4+PiBoYXZlDQo+Pj4gdXNpbmcgdGhlIE1hcnZlbGwgQ045MTMwIFNvQyAo
d2hpY2ggSSB0aGluayB3YXMgY2FsbGVkIEFybWFkYS04SyBiZWZvcmUNCj4+PiB0aGV5IHJlYnJh
bmRlZCkuDQo+Pj4NCj4+PiBCYXNpY2FsbHkgdGhlaXIgY29uY2VybiBpcyB0aGF0IHRoZSB0V0Mg
dGltaW5nIHRoZXkgb2JzZXJ2ZSBpcyBmYXN0ZXINCj4+PiAofjE4bnMpIHRoYW4gdGhlIGRvY3Vt
ZW50ZWQgbWluaW11bSBpbiB0aGUgaGFyZHdhcmUgZGF0YXNoZWV0IGZvciB0aGUNCj4+PiBDTjkx
MzAgKDI1bnMpLiBBc2lkZSBmcm9tIG5vdCBtZWV0aW5nIHRoZSBkYXRhc2hlZXQgc3BlYyB3ZSd2
ZSBub3QNCj4+PiBvYnNlcnZlZCBhbnkgb3RoZXIgaXNzdWUgKHlldCkuDQo+PiBJIHdvdWxkIGhh
dmUgZXhwZWN0ZWQgdGhlIGNvbnRyb2xsZXIgdG8gc3VwcG9ydCBhbG1vc3QgYW55IGtpbmQgb2YN
Cj4+IHRpbWluZ3MsIGluY2x1ZGluZyBTRFIgRURPIG1vZGUgNS4gdFdDIGlzIDI1bnMgd2l0aCBt
b2RlIDQsIGJ1dCAyMCBvbg0KPj4gbW9kZSA1IChPTkZJKS4gU28gSSBiZWxpZXZlIHlvdSdyZSBy
dW5uaW5nIGEgc3lzdGVtIHdpdGggYSBjaGlwIHRoYXQgaXMNCj4+IG5vdCBjb21wYXRpYmxlIHdp
dGggdGhlIGZhc3Rlc3QgbW9kZS4gSWYgdGhhdCBpcyB0aGUgY2FzZSwgaXQgbWF5DQo+PiBleHBs
YWluIHdoeSB5b3UgZG9uJ3Qgc2VlIGVycm9ycyB3aXRoIHRoaXMgY2hpcDogaXQgbWF5IHN1cHBv
cnQNCj4+IHNsaWdodGx5IGZhc3RlciB0aW1pbmdzIHRoYW4gaXQgYWR2ZXJ0aXNlcy4NCj4+DQo+
PiBBbnl3YXksIGlmIHlvdXIgZmluZGluZ3MgYXJlIHRydWUsIGl0IG1lYW5zIHRoZSBjdXJyZW50
IGltcGxlbWVudGF0aW9uDQo+PiBpcyBzbGlnaHRseSBvdXQgb2Ygc3BlYyBhbmQgdGhlIHRpbWlu
ZyBjYWxjdWxhdGlvbiBtaWdodCByZXF1aXJlIHRvIGJlDQo+PiB0d2Vha2VkIGEgbGl0dGxlIGJp
dCB0byByZWR1Y2UgdFdDLg0KPj4NCj4+PiBJIG5vdGljZSBpbiB0aGUgbWFydmVsbF9uYW5kLmMg
ZHJpdmVyIHRoYXQgbWFydmVsbF9uZmNfaW5pdCgpIHNldHMgdGhlDQo+Pj4gTkFORCBDbG9jayBG
cmVxdWVuY3kgU2VsZWN0IGJpdCAoMHhGMjQ0MDcwMDowKSB0byAxIHdoaWNoIHJ1bnMgDQo+Pj4g
YWNjb3JkaW5nDQo+Pj4gdG8gdGhlIGRhdGFzaGVldCB0aGUgTkFORCBmbGFzaCBhdCA0MDBNSHog
LiBCdXQgdGhlIGNhbGN1bGF0aW9ucyBpbg0KPj4+IG1hcnZlbGxfbmZjX3NldHVwX2ludGVyZmFj
ZSgpIHVzZSB0aGUgdmFsdWUgZnJvbQ0KPj4+IGNsa19nZXRfcmF0ZShuZmMtPmNvcmVfY2xrKSB3
aGljaCBpcyBzdGlsbCAyNTBNSHogc28gSSdtIHdvbmRlcmluZyBpZg0KPj4+IG1heWJlIHRoZSBm
YWN0IHRoYXQgdGhlIE5BTkQgZmxhc2ggaXMgYmVpbmcgcnVuIGZhc3RlciBpcyBoYXZpbmcgYW4N
Cj4+PiBpbXBhY3Qgb24gdGltaW5ncyB0aGF0IGFyZSBjYWxjdWxhdGVkIGFyb3VuZCB0aGUgY29y
ZV9jbGsgZnJlcXVlbmN5Lg0KPj4gV2hhdCBpZiB5b3UgcmVzZXQgdGhpcyBiaXQ/IERvIHlvdSBv
YnNlcnZlIGRpZmZlcmVudCB0aW1pbmdzPyBJIGhvcGUNCj4+IHlvdSBkbywgb3RoZXJ3aXNlIHRo
aXMgaXMgYSBkZWFkLWVuZC4NCj4gWWVzIGlmIHdlIGNsZWFyIHRoZSBiaXQgdGhlIHRpbWluZ3Mg
Z28gZnJvbSB+MThucyB0byBhYm91dCAzMG5zLg0KPj4gVGhlIHRpbWluZ3MgYXJlIGRlcml2ZWQg
ZnJvbSB0aGlzIGNsb2NrIGJ1dCBJIHJlbWVtYmVyIHNlZWluZyBkaWZmZXJlbnQNCj4+IHJhdGVz
IHRoYW4gdGhlIG9uZXMgSSBleHBlY3RlZCB3aXRoIG5vIG9idmlvdXMgZXhwbGFuYXRpb24gKHNl
ZSB0aGUgIioNCj4+IDIiIGluIHRoZSBjYWxjdWxhdGlvbiBvZiBwZXJpb2RfbnMgYW5kIHRoZSBj
b21tZW50IHJpZ2h0IGJlbG93KS4gU28NCj4+IG1heWJlIHRoaXMgaXMgZHVlIHRvIHRoZSA0MDBN
SHogdnMuIDI1ME1IeiBpc3N1ZSB5b3UgYXJlIHJlcG9ydGluZywgb3INCj4+IHRoZXJlIGlzIGFu
IHVuZG9jdW1lbnRlZCBwcmUtc2NhbGVyIGluLWJldHdlZW4gKHRoaXMgaXMgbXkgb3JpZ2luYWwN
Cj4+IGd1ZXNzKS4NCj4NCj4gSSB3b25kZXJlZCBpZiB0aGUgKiAyIHdhcyBiZWNhdXNlIG9mIHRo
aXMgb3IgYmVjYXVzZSBvZiB0aGUgY29tbWVudCANCj4gdGhhdCB0aGUgRUNDX0NMSyBpcyAyKk5G
X0NMSy4gVGhhdCBwcm9iYWJseSBhbHNvIG1lYW5zIHRoYXQgYSBudW1iZXIgDQo+IG9mIFNvQ3Mg
YXJlIHJ1bm5pbmcgd2l0aCBhbiBleHRyYSAqMiB0aGF0IGRvbid0IG5lZWQgdG8gYmUgKGUuZy4g
DQo+IEFybWFkYS0zODUpLg0KSW50ZXJlc3RpbmdseSBjcDExMC1zeXN0ZW0tY29udHJvbGxlci5j
IGlzIGF3YXJlIG9mIHRoZSA0MDBNSHogb3B0aW9uIA0KYnV0IHRoYXQncyBvbmx5IGVmZmVjdGl2
ZSBpZiBpdCdzIGJlZW4gc2V0IHByaW9yIHRvIHRoZSBrZXJuZWwgYm9vdGluZy4gDQpJJ20gbm90
IHJlYWxseSBmYW1pbGlhciB3aXRoIGNsayBkcml2ZXJzIGJ1dCBJIGFzc3VtZSBpdCBtdXN0IGJl
IA0KcG9zc2libGUgdG8gbWFrZSBpdCBsb29rIHVwIHRoZSBmcmVxdWVuY3kgZHluYW1pY2FsbHkg
aW5zdGVhZCBvZiB1c2luZyBhIA0Kc2luZ2xlIGZpeGVkIHZhbHVlLg0KPg0KPj4+IERvIHlvdSB0
aGluayB0aGF0IHRoZSB0aW1pbmdzIGNhbGN1bGF0aW9ucyBzaG91bGQgdGFrZSB0aGUgTkFORCBD
bG9jaw0KPj4+IEZyZXF1ZW5jeSBTZWxlY3Qgc2V0dGluZyBpbnRvIGFjY291bnQ/DQo+PiBUaGVy
ZSBpcyBub3QgbXVjaCBhYm91dCB0aGlzIGNsb2NrIGluIHRoZSBtYW51YWwsIHNvIGlmIHRoZSBj
bG9jayBpcw0KPj4gZmVlZGluZyB0aGUgbG9naWMgb2YgdGhlIGNvbnRyb2xsZXIgZ2VuZXJhdGlu
ZyB0aGUgc2lnbmFscyBvbiB0aGUgYnVzLA0KPj4gdGhlbiB5ZXMuIFlvdSBjYW4gdmVyaWZ5IHRo
aXMgd2l0aCB0aGUgdGVzdCBtZW50aW9uZWQgYWJvdmUuDQo+Pg0KPj4gQ291bGQgeW91IGNoZWNr
IHRoZSB2YWx1ZXMgc2V0IHRvIHRXUCBhbmQgdFdIIHdpdGggYW5kIHdpdGhvdXQgdGhlIGJpdA0K
Pj4gYW5kIHByb2JlIHRoZSBzaWduYWxzIGluIGJvdGggY2FzZXM/IE1heWJlIHRoZSAiKiAyIiBp
biB0aGUNCj4+IHBlcmlvZF9ucyBjYWxjdWxhdGlvbiB3aWxsIHZhbmlzaCBpZiB3ZSB1c2UgNDAw
TUh6IGFzIGlucHV0IGNsb2NrIHJhdGhlcg0KPj4gdGhhbiBjbGtfZ2V0X3JhdGUoKSAob3IgYmV0
dGVyLCBleHBvc2UgdGhlIGJpdCBhcyBhIG11eC1jbG9jayBhbmQgdXNlDQo+PiBpdCB0byB0ZWxs
IHRoZSBDQ0YgdGhlIHJpZ2h0IGZyZXF1ZW5jeSkgYW5kIHlvdSdsbCBnZXQgYSBzaGFycGVyIHRX
QyBpbg0KPj4gdGhlIGVuZCwgd2hpY2ggaG9wZWZ1bGx5IHNob3VsZCBtYXRjaCB0aGUgc3BlYyB0
aGlzIHRpbWUuDQo+DQo+IEkgd2FzIGdvaW5nIHRvIGhhdmUgYSBsb29rIHRvIHNlZSBpZiBJIGNh
biBnZXQgdGhlIE5BTkQgY2xvY2sgdG8gDQo+IGNvcnJlY3RseSByZWZsZWN0IHRoZSB2YWx1ZSB3
aGVuIHRoZSBOQU5EIENsb2NrIEZyZXF1ZW5jeSBTZWxlY3QgYml0IA0KPiBpcyBzZXQuIEluIHRo
ZSBtZWFudGltZSBJJ2xsIGFsc28gZG8gc29tZSBleHBlcmltZW50cyByZW1vdmluZyB0aGUgKiAy
IA0KPiBhbmQgaGFyZC1jb2RpbmcgdGhlIGZyZXF1ZW5jeSBhdCA0MDBNSHou
