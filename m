Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBE864524C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLGCxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiLGCxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:53:22 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7065F50;
        Tue,  6 Dec 2022 18:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1670381598;
  x=1701917598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ucpPcw6yzA7U6+OWMzVpYaMNtQ2FevT4TSmfdu8XnLQ=;
  b=CsXchBppC08SK82n/53ixtHdGFlS8bANvrBRb1Zq71EoC4xnIVJvieJd
   A/0wgHikjf/S7VZ5MKPZxMSXAQJJ6jKuwkHkMfXJM4rwgDdTcNMeRRfWg
   l9fiP+lHttrS/paVThidFa0HwsDvmzqwF3CwVhU56K1fwYQtu1XF8P4qd
   3Bh4eY+bOFY2qaBb4hzzWOIaiqpIm/EZcK1UJ69t0YjN6StCaJwe8nh+W
   u/rVZWPEbH0TB8wF5QFcDGaaiDrGKMELoaS/pDyLht1zH9u68/QrzXgNt
   BCUG3ITM2/hygmOg8tdOKD9FT1aIxGH+1WUaf8zgY3rEbAULEpEfJFvXs
   w==;
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Hermes Zhang <Hermes.Zhang@axis.com>
CC:     kernel <kernel@axis.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: bq256xx: Remove init ichg/vbat with max
 value
Thread-Topic: [PATCH] power: supply: bq256xx: Remove init ichg/vbat with max
 value
Thread-Index: AQHZA9EmYBH5aDLerkKG2mvQfE9eNq5V9biAgAEt4ACABCn/gIADTAIAgAEs8gCAAe8oAA==
Date:   Wed, 7 Dec 2022 02:53:15 +0000
Message-ID: <9abc98dd-751d-6f6e-3c33-f77c568d3597@axis.com>
References: <20221129090112.3451501-1-chenhuiz@axis.com>
 <20221129152715.4hwtobuv57hrndzu@mercury.elektranox.org>
 <60ca0aa6-508a-4350-f892-98d1368e3783@axis.com>
 <20221203010303.it5urfo2i7pj4n3n@mercury.elektranox.org>
 <cf37715e-8bff-b38c-cee9-fdcc3b1d3a6b@axis.com>
 <20221205212100.mldqqlv3mp5z7gwg@mercury.elektranox.org>
In-Reply-To: <20221205212100.mldqqlv3mp5z7gwg@mercury.elektranox.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5A9CE3752350B4A8282D2123A578863@exhub.se.axis.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDIwMjIvMTIvNiA1OjIxLCBTZWJhc3RpYW4gUmVpY2hlbCB3cm90ZToNCj4gSGks
DQo+IA0KPiBPbiBNb24sIERlYyAwNSwgMjAyMiBhdCAwMzoyMzo1M0FNICswMDAwLCBIZXJtZXMg
Wmhhbmcgd3JvdGU6DQo+PiBJbml0IHRoZSBpY2hnIGFuZCB2YmF0IHJlZyB3aXRoIG1heCB2YWx1
ZSBpcyBub3QgZ29vZC4gRmlyc3QgdGhlIGNoaXANCj4+IGFscmVhZHkgaGFzIGEgZGVmYXVsdCB2
YWx1ZSBmb3IgaWNoZyBhbmQgdmJhdCAoc21hbGwgdmFsdWUpLiBJbml0IHRoZXNlDQo+PiB0d28g
cmVnIHdpdGggbWF4IHZhbHVlIHdpbGwgcmVzdWx0IGFuIHVuc2FmZSBjYXNlIChlLmcuIGJhdHRl
cnkgaXMgb3Zlcg0KPj4gY2hhcmdpbmcgaW4gYSBob3QgZW52aXJvbm1lbnQpIGlmIG5vIHVzZXIg
c3BhY2UgY2hhbmdlIHRoZW0gbGF0ZXIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSGVybWVzIFpo
YW5nIDxjaGVuaHVpekBheGlzLmNvbT48bWFpbHRvOmNoZW5odWl6QGF4aXMuY29tPg0KPj4gLS0t
DQo+Pg0KPj4NCj4+IEl0J3MgdGhlIGRyaXZlcidzIHRhc2sgdG8gc2V0dXAgc2FmZSBpbml0aWFs
IG1heGltdW0gdmFsdWVzLg0KPj4gUHJlLWtlcm5lbCB2YWx1ZXMgbWF5IG9yIG1heSBub3QgYmUg
c2FmZSBpZiB5b3UgY29uc2lkZXIgdGhpbmdzDQo+PiBsaWtlIGtleGVjLiBJZiB5b3UgZ2V0IHVu
c2FmZSB2YWx1ZXMgcHJvZ3JhbW1lZCwgdGhlbiBmaXggdGhlDQo+PiB2YWx1ZXMgaW5zdGVhZC4N
Cj4+DQo+PiAtLSBTZWJhc3RpYW4NCj4+DQo+Pg0KPj4NCj4+IFRoZSBjb25zdGFudF9jaGFyZ2Vf
Y3VycmVudF9tYXhfdWEgaXMgZWl0aGVyIGZyb20gZHRzIG9yIGRlZmF1bHQgdmFsdWUNCj4+IGZv
ciBlYWNoIGNoaXAgaW4gdGhlIGNvZGUsIGJ1dCBJIGd1ZXNzIEkgY291bGQgb3QgY2hhbmdlIHRo
ZW0gYmVjYXVzZSBpdA0KPj4gaGFzIHRoZWlyIG93biBtZWFuaW5nIChpdCB3aWxsIGJlIHVzZWQg
dG8gY2hlY2sgaWYgdGhlIHNldHRpbmcgaXMgdmFsaWQNCj4+IG9yIG5vdCkuIERvIHlvdSBtZWFu
IEkgY2FuIHNldCBzb21lIG90aGVyIHZhbHVlIGhlcmUgaW5zdGVhZCBvZg0KPj4gY29uc3RhbnRf
eHh4X21heD8NCj4+DQo+Pg0KPj4NCj4+IFlvdSBjYW4ganVzdCBjaGFuZ2UgdGhlIERUIHZhbHVl
IHRvIHNvbWV0aGluZyBzYWZlIGFzIGl0IGlzIG1lYW50IHRvIGJlPw0KPj4NCj4+DQo+PiBIaSwN
Cj4gDQo+IFBsZWFzZSB1c2UgcHJvcGVyIHF1b3RpbmcuDQoNCk9LLg0KDQo+IA0KPj4gSSB0cmll
ZCBpdCBidXQgaXQgZG9lc24ndCB3b3JrLiBBcyB0aGUgcHJvcGVydHkgaW4gZHRzIChjb25zdGFu
dF9jaGFyZ2VfY3VycmVudF9tYXhfbWljcm9hbXANCj4+IGFuZCBjb25zdGFudF9jaGFyZ2Vfdm9s
dGFnZV9tYXhfbWljcm92b2x0KSBtZWFucyB0aGUgbWF4IGN1cnJlbnQgYW5kIHZvbHRhZ2UgaW4g
Q0MgcGhhc2UsIGlmDQo+PiBJIGNoYW5nZSB0aGVtIHRvIGEgc2FmZShzbWFsbCkgdmFsdWUsIHdl
IGNvdWxkIG5vdCBhcHBseSBhbnkgdmxhdWUgYmlnZ2VyIHRoYW4gdGhlbSBpbiB0aGUNCj4+IGZ1
cnR1cmU6DQo+IA0KPiBSaWdodCwgYmVjYXVzZSB0aGUgYmlnZ2VyIHZhbHVlcyBhcmUgbm90IHNh
ZmUuDQo+IA0KPj4gaW4NCj4+IGJxMjU2eHhfc2V0X2ljaGdfY3VycigpDQo+Pg0KPj4gaWNoZyA9
IGNsYW1wKGljaGcsIEJRMjU2WFhfSUNIR19NSU5fdUEsIGljaGdfbWF4KTsNCj4+DQo+PiBTbyB0
aGUgRFQgdmFsdWUgYXJlIG5vdCBtYXRjaC9zdXRpYWJsZSBmb3Igd2hhdCB3ZSB3YW50IHRvIHNl
dCBoZXJlLiBFaXRoZXIgd2UgaW50cm9kdWNlIHR3bw0KPj4gbmV3IERUIHByb3BlcnR5IChmb3Ig
aW5pdCBwdXJwb3NlKSB0byBzZXQgaGVyZSBvciB3ZSBqdXN0IHJlbW92ZSB0aGUgc2V0dGluZyBo
ZXJlIGFzIHRoZSBjaGlwDQo+PiBhbHJlYWR5IGhhcyB0aGUgZGVmYXVsdCB2YWx1ZXMuDQo+IA0K
PiBUaGVyZSBhcmUgbm8gY2hpcCBkZWZhdWx0cyBpZiB5b3UgdXNlIGtleGVjLg0KPiANCj4gSSdt
IHRyeWluZyB0byByZWFkIGJldHdlZW4gdGhlIGxpbmVzLiBNeSB1bmRlcnN0YW5kaW5nIGlzLCB0
aGF0IHlvdQ0KPiBoYXZlIHNvbWUga2luZCBvZiB1c2Vyc3BhY2UgYmFzZWQgc29sdXRpb24gdG8g
bW9uaXRvciB0aGUgY2hhcmdpbmcNCj4gcHJvY2VzcyBhbmQgcmVkdWNlIHRoZSBjdXJyZW50IGlm
IGl0IGdldHMgZGFuZ2Vyb3VzLiBUaGlzIHByb2Nlc3MNCj4gc2hvdWxkIHVzZSBoaWdoZXIgY2hh
cmdlIGN1cnJlbnRzIHRoZW4gd2hhdCBpcyBjb25zaWRlcmVkIHNhZmU7IHdoZW4NCj4gaXQncyBu
b3QgcnVubmluZyBjaGFyZ2luZyBzaG91bGQgbm90IGdvIGFib3ZlIHRoZSBzYWZlIHRocmVzaG9s
ZC4NCj4gDQoNClllcyBhbmQgdGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJIGFsc28gZ28gdGhyb3Vn
aCB0aGUgd2hvbGUgaWRlYSBhbmQgSSANCnRoaW5rIHRoZSBwcm9ibGVtIGlzOiB3aGVuIEkgcGFz
cyBjb25zdGFudF9jaGFyZ2VfeHhfbWF4IHZhbHVlcyBpbiBkdHMsIA0KSSBpbnRlbmQgdG8gc2V0
IHRoZSBsaW1pdCBvZiB0aGUgY2hhcmdpbmcgY3VycmVudC92b2x0YWdlIHdoaWNoIGlzIA0KY29y
cmVjdCB0byBtYXAgdG8gaWNoZ19tYXgvdmJhdHJlZ19tYXgsIGJ1dCB0aGUgZHJpdmVyIGhlcmUg
ZG8gZXh0cmEgDQpzdGVwIHRvIHdyaXRlIHRoZSBtYXggdmFsdWUgdG8gaWNoZy92YmF0cmVnIHJl
Z3Mgd2hpY2ggSSB0aGluayBpcyBub3QgDQpnb29kL3NhZmUuIFNvIGlmIHdlIHdhbnQgdG8ga2Vl
cCB0aGUgaW5pdCBzZXR0aW5nIGluIGRyaXZlciwgSSBzdWdnZXN0IA0Kd2UgY2hhbmdlIHRoZSB2
YWx1ZXMgdG8gdGhlIGRlZmF1bHQgb25lOiBicS0+Y2hpcF9pbmZvLT5icTI1Nnh4X2RlZl9pY2hn
IA0KYW5kIGJxMjU2eHhfZGVmX3ZiYXRyZWcuDQoNCj4gVGhpcyBlZmZlY3RpdmVseSBtZWFucywg
dGhhdCB5b3Ugd2FudCB0byB0YWtlIG92ZXIgdGhlIGRlY2lzaW9uIHdoYXQNCj4gaXMgY29uc2lk
ZXJlZCBzYWZlIHRvIHVzZXJzcGFjZS4gU28gSSBzdWdnZXN0IGFkZGluZyBhIG1vZHVsZSBwYXJh
bWV0ZXINCj4gdG8gZGlzYWJsZSB0aGUgc2FmZXR5IGNsYW1wIGxpa2UgdGhpczoNCj4gDQo+IHN0
YXRpYyB1bnNpZ25lZCBib29sIG5vX3NhZmV0eSA9IGZhbHNlOw0KPiBtb2R1bGVfcGFyYW0obm9f
c2FmZXR5LCBib29sLCAwNjQ0KTsNCj4gTU9EVUxFX1BBUk1fREVTQyhub19zYWZldHksICJhbGxv
dyBjaGFyZ2UgY3VycmVudHMvdm9sdGFnZXMgY29uc2lkZXJlZCB1bnNhZmUgYnkgdGhlIGtlcm5l
bCBbZGVmYXVsdDogZGlzYWxsb3dlZF0iKTsNCj4gDQo+IC4uLg0KPiANCj4gaW50IGljaGdfbWF4
ID0gYnEtPmluaXRfZGF0YS5pY2hnX21heDsNCj4gaWYgKG5vX3NhZmV0eSkNCj4gICAgICBpY2hn
X21heCA9IGJxLT5pbml0X2RhdGEuaWNoZ19jaGlwX21heDsNCj4gDQoNClllcywgdGhpcyB1cGRh
dGUgd2lsbCB3b3JrIGFuZCBzb2x2ZSBteSBwcm9ibGVtLCB0aGUgb25seSB0aGluZyBpcyBJIA0K
bmVlZCBzZXQgYSBzYWZlIHZhbHVlIGluIGR0cyBpbnN0ZWFkIG9mIGEgcmVhbCBtYXggdmFsdWUg
dG8gDQpjb25zdGFudF9jaGFyZ2Vfdm9sdGFnZV9tYXhfbWljcm92b2x0LCB0aGUgcHJvcGVydHkg
bmFtZSBhbmQgdmFsdWUgaXMgDQpub3QgbWF0Y2guIEkgaGF2ZSBhbm90aGVyIGlkZWEgYXMgZGVz
Y3JpYmVkIGFib3ZlLCBwbGVhc2UgY2hlY2suIFRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzLA0KSGVy
bWVzDQoNCg==
