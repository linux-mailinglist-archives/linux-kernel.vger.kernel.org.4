Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9834B6FB0B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjEHNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjEHNAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:00:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880ED35B2C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:00:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E9AF21F28;
        Mon,  8 May 2023 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683550810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=td1n8Mo3CyXBECQX8hxeMdc0DOHDFx+6010gztWci9s=;
        b=YmBL16hZqx6Yd9k4Y5zJkPAEu+Me+L3pq0Q6HGlry69TGWVlAV9eM+MeB2Qfh+B/4JkzVR
        53OtUIqPGxrCM9SdM14i06ssgqw8zecvo+hr55KXVxPMLs6Ikqv62hrI+48TYr4rtlpQaa
        J0G+O1RI5icDnygED3g8XupBpbulvLQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD52813499;
        Mon,  8 May 2023 13:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OWW6MFnyWGSyXAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 08 May 2023 13:00:09 +0000
Message-ID: <687d351b-0165-fc87-1426-1a4c16ef048a@suse.com>
Date:   Mon, 8 May 2023 15:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 02/16] x86/mtrr: replace some constants with defines
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230502120931.20719-3-jgross@suse.com>
 <20230505184952.GBZFVP0DkRrJiI+84Y@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230505184952.GBZFVP0DkRrJiI+84Y@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bbnKjoME3Dm6MHP7a9cYxEOI"
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bbnKjoME3Dm6MHP7a9cYxEOI
Content-Type: multipart/mixed; boundary="------------ztv1pDeiDiOt0OZ8mnwSmzD9";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, mikelley@microsoft.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <687d351b-0165-fc87-1426-1a4c16ef048a@suse.com>
Subject: Re: [PATCH v6 02/16] x86/mtrr: replace some constants with defines
References: <20230502120931.20719-1-jgross@suse.com>
 <20230502120931.20719-3-jgross@suse.com>
 <20230505184952.GBZFVP0DkRrJiI+84Y@fat_crate.local>
In-Reply-To: <20230505184952.GBZFVP0DkRrJiI+84Y@fat_crate.local>

--------------ztv1pDeiDiOt0OZ8mnwSmzD9
Content-Type: multipart/mixed; boundary="------------WhJDzxcxJviq0ozkUOfwxJLO"

--------------WhJDzxcxJviq0ozkUOfwxJLO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDUuMjMgMjA6NDksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBN
YXkgMDIsIDIwMjMgYXQgMDI6MDk6MTdQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEluc3RlYWQgb2YgdXNpbmcgY29uc3RhbnRzIGluIE1UUlIgY29kZSwgdXNlIHNvbWUg
bmV3ICNkZWZpbmVzLg0KPj4NCj4+IFJlcGxhY2Ugc2l6ZV9vcl9tYXNrIGFuZCBzaXplX2Fu
ZF9tYXNrIHdpdGggdGhlIG11Y2ggZWFzaWVyIGNvbmNlcHQgb2YNCj4+IGhpZ2ggcmVzZXJ2
ZWQgYml0cy4NCj4gDQo+IFRoaXMgaXMgdGhlIGJldHRlciBjb21taXQgdGl0bGUgdGhhbiB3
aGF0J3MgdGhlcmUgbm93IGJlY2F1c2UgdGhlIHBhdGNoDQo+IGRvZXMgbW9yZSB0aGFuIGp1
c3QgcmVwbGFjaW5nIHNvbWUgY29uc3RhbnRzIHdpdGggZGVmaW5lcy4gVGhlcmVmb3JlIG15
DQo+IHF1ZXN0aW9uIHRvIHBhdGNoIDEuIEFueXdheSwgSSdsbCBmaXggaXQgdXAuDQo+IA0K
PiBBbHNvLCBzb21lIG1pbm9yIGNsZWFudXBzIG9udG9wOg0KPiANCj4gLS0tDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9tdHJyLmggYi9hcmNoL3g4
Ni9pbmNsdWRlL3VhcGkvYXNtL210cnIuaA0KPiBpbmRleCAzNzY1NjNmMmJhYzEuLmUzMTQ5
NjlhNWU2ZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9tdHJy
LmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9tdHJyLmgNCj4gQEAgLTg0
LDggKzg0LDggQEAgdHlwZWRlZiBfX3U4IG10cnJfdHlwZTsNCj4gICBzdHJ1Y3QgbXRycl9z
dGF0ZV90eXBlIHsNCj4gICAJc3RydWN0IG10cnJfdmFyX3JhbmdlIHZhcl9yYW5nZXNbTVRS
Ul9NQVhfVkFSX1JBTkdFU107DQo+ICAgCW10cnJfdHlwZSBmaXhlZF9yYW5nZXNbTVRSUl9O
VU1fRklYRURfUkFOR0VTXTsNCj4gLQl1bnNpZ25lZCBjaGFyIGVuYWJsZWQ7DQo+IC0JdW5z
aWduZWQgY2hhciBoYXZlX2ZpeGVkOw0KPiArCWJvb2wgZW5hYmxlZDsNCj4gKwlib29sIGhh
dmVfZml4ZWQ7DQo+ICAgCW10cnJfdHlwZSBkZWZfdHlwZTsNCj4gICB9Ow0KPiAgIA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYyBiL2FyY2gv
eDg2L2tlcm5lbC9jcHUvbXRyci9nZW5lcmljLmMNCj4gaW5kZXggNTliNDhiZDgzODBjLi4z
ZjA4MTFiMmZkMTggMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9n
ZW5lcmljLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYw0K
PiBAQCAtMzgsMTQgKzM4LDggQEAgdTY0IG10cnJfdG9tMjsNCj4gICBzdHJ1Y3QgbXRycl9z
dGF0ZV90eXBlIG10cnJfc3RhdGU7DQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwobXRycl9zdGF0
ZSk7DQo+ICAgDQo+IC1zdGF0aWMgdTMyIHBoeXNfaGlfcnN2ZDsNCj4gLQ0KPiAtdm9pZCBf
X2luaXQgbXRycl9zZXRfbWFzayh2b2lkKQ0KPiAtew0KPiAtCXVuc2lnbmVkIGludCBwaHlz
X2FkZHIgPSBib290X2NwdV9kYXRhLng4Nl9waHlzX2JpdHM7DQo+IC0NCj4gLQlwaHlzX2hp
X3JzdmQgPSBHRU5NQVNLKDMxLCBwaHlzX2FkZHIgLSAzMik7DQo+IC19DQo+ICsvKiBSZXNl
cnZlZCBiaXRzIGluIHRoZSBoaWdoIHBvcnRpb24gb2YgdGhlIE1UUlJwaHlzQmFzZU4gTVNS
LiAqLw0KPiArdTMyIHBoeXNfaGlfcnN2ZDsNCj4gICANCj4gICAvKg0KPiAgICAqIEJJT1Mg
aXMgZXhwZWN0ZWQgdG8gY2xlYXIgTXRyckZpeERyYW1Nb2RFbiBiaXQsIHNlZSBmb3IgZXhh
bXBsZQ0KPiBAQCAtMjMxLDggKzIyNSw3IEBAIHN0YXRpYyB1OCBtdHJyX3R5cGVfbG9va3Vw
X3ZhcmlhYmxlKHU2NCBzdGFydCwgdTY0IGVuZCwgdTY0ICpwYXJ0aWFsX2VuZCwNCj4gICAJ
CWlmICgoc3RhcnQgJiBtYXNrKSAhPSAoYmFzZSAmIG1hc2spKQ0KPiAgIAkJCWNvbnRpbnVl
Ow0KPiAgIA0KPiAtCQljdXJyX21hdGNoID0gbXRycl9zdGF0ZS52YXJfcmFuZ2VzW2ldLmJh
c2VfbG8gJg0KPiAtCQkJICAgICBNVFJSX1BIWVNCQVNFX1RZUEU7DQo+ICsJCWN1cnJfbWF0
Y2ggPSBtdHJyX3N0YXRlLnZhcl9yYW5nZXNbaV0uYmFzZV9sbyAmIE1UUlJfUEhZU0JBU0Vf
VFlQRTsNCj4gICAJCWlmIChwcmV2X21hdGNoID09IE1UUlJfVFlQRV9JTlZBTElEKSB7DQo+
ICAgCQkJcHJldl9tYXRjaCA9IGN1cnJfbWF0Y2g7DQo+ICAgCQkJY29udGludWU7DQo+IEBA
IC00NjIsNyArNDU1LDcgQEAgYm9vbCBfX2luaXQgZ2V0X210cnJfc3RhdGUodm9pZCkNCj4g
ICAJdnJzID0gbXRycl9zdGF0ZS52YXJfcmFuZ2VzOw0KPiAgIA0KPiAgIAlyZG1zcihNU1Jf
TVRSUmNhcCwgbG8sIGR1bW15KTsNCj4gLQltdHJyX3N0YXRlLmhhdmVfZml4ZWQgPSAhIShs
byAmIE1UUlJfQ0FQX0ZJWCk7DQo+ICsJbXRycl9zdGF0ZS5oYXZlX2ZpeGVkID0gbG8gJiBN
VFJSX0NBUF9GSVg7DQo+ICAgDQo+ICAgCWZvciAoaSA9IDA7IGkgPCBudW1fdmFyX3Jhbmdl
czsgaSsrKQ0KPiAgIAkJZ2V0X210cnJfdmFyX3JhbmdlKGksICZ2cnNbaV0pOw0KPiBAQCAt
NDcxLDggKzQ2NCw3IEBAIGJvb2wgX19pbml0IGdldF9tdHJyX3N0YXRlKHZvaWQpDQo+ICAg
DQo+ICAgCXJkbXNyKE1TUl9NVFJSZGVmVHlwZSwgbG8sIGR1bW15KTsNCj4gICAJbXRycl9z
dGF0ZS5kZWZfdHlwZSA9IGxvICYgTVRSUl9ERUZfVFlQRV9UWVBFOw0KPiAtCW10cnJfc3Rh
dGUuZW5hYmxlZCA9IChsbyAmIE1UUlJfREVGX1RZUEVfRU5BQkxFKSA+Pg0KPiAtCQkJICAg
ICBNVFJSX1NUQVRFX1NISUZUOw0KPiArCW10cnJfc3RhdGUuZW5hYmxlZCA9IChsbyAmIE1U
UlJfREVGX1RZUEVfRU5BQkxFKSA+PiBNVFJSX1NUQVRFX1NISUZUOw0KPiAgIA0KPiAgIAlp
ZiAoYW1kX3NwZWNpYWxfZGVmYXVsdF9tdHJyKCkpIHsNCj4gICAJCXVuc2lnbmVkIGxvdywg
aGlnaDsNCj4gQEAgLTU4NSw3ICs1NzcsNyBAQCBzdGF0aWMgdm9pZCBnZW5lcmljX2dldF9t
dHJyKHVuc2lnbmVkIGludCByZWcsIHVuc2lnbmVkIGxvbmcgKmJhc2UsDQo+ICAgDQo+ICAg
CXJkbXNyKE1UUlJwaHlzTWFza19NU1IocmVnKSwgbWFza19sbywgbWFza19oaSk7DQo+ICAg
DQo+IC0JaWYgKChtYXNrX2xvICYgTVRSUl9QSFlTTUFTS19WKSA9PSAwKSB7DQo+ICsJaWYg
KCEobWFza19sbyAmIE1UUlJfUEhZU01BU0tfVikpIHsNCj4gICAJCS8qICBJbnZhbGlkIChp
LmUuIGZyZWUpIHJhbmdlICovDQo+ICAgCQkqYmFzZSA9IDA7DQo+ICAgCQkqc2l6ZSA9IDA7
DQo+IEBAIC03MDAsOSArNjkyLDggQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgc2V0X210cnJf
c3RhdGUodm9pZCkNCj4gICAJICogU2V0X210cnJfcmVzdG9yZSByZXN0b3JlcyB0aGUgb2xk
IHZhbHVlIG9mIE1UUlJkZWZUeXBlLA0KPiAgIAkgKiBzbyB0byBzZXQgaXQgd2UgZmlkZGxl
IHdpdGggdGhlIHNhdmVkIHZhbHVlOg0KPiAgIAkgKi8NCj4gLQlpZiAoKGRlZnR5cGVfbG8g
JiBNVFJSX0RFRl9UWVBFX1RZUEUpICE9IG10cnJfc3RhdGUuZGVmX3R5cGUNCj4gLQkgICAg
fHwgKChkZWZ0eXBlX2xvICYgTVRSUl9ERUZfVFlQRV9FTkFCTEUpID4+IE1UUlJfU1RBVEVf
U0hJRlQpICE9DQo+IC0JICAgICAgIG10cnJfc3RhdGUuZW5hYmxlZCkgew0KPiArCWlmICgo
ZGVmdHlwZV9sbyAmIE1UUlJfREVGX1RZUEVfVFlQRSkgIT0gbXRycl9zdGF0ZS5kZWZfdHlw
ZSB8fA0KPiArCSAgICAoKGRlZnR5cGVfbG8gJiBNVFJSX0RFRl9UWVBFX0VOQUJMRSkgPj4g
TVRSUl9TVEFURV9TSElGVCkgIT0gbXRycl9zdGF0ZS5lbmFibGVkKSB7DQo+ICAgDQo+ICAg
CQlkZWZ0eXBlX2xvID0gKGRlZnR5cGVfbG8gJiBNVFJSX0RFRl9UWVBFX0RJU0FCTEUpIHwN
Cj4gICAJCQkgICAgIG10cnJfc3RhdGUuZGVmX3R5cGUgfA0KPiBAQCAtNzE5LDggKzcxMCw3
IEBAIHZvaWQgbXRycl9kaXNhYmxlKHZvaWQpDQo+ICAgCXJkbXNyKE1TUl9NVFJSZGVmVHlw
ZSwgZGVmdHlwZV9sbywgZGVmdHlwZV9oaSk7DQo+ICAgDQo+ICAgCS8qIERpc2FibGUgTVRS
UnMsIGFuZCBzZXQgdGhlIGRlZmF1bHQgdHlwZSB0byB1bmNhY2hlZCAqLw0KPiAtCW10cnJf
d3Jtc3IoTVNSX01UUlJkZWZUeXBlLCBkZWZ0eXBlX2xvICYgTVRSUl9ERUZfVFlQRV9ESVNB
QkxFLA0KPiAtCQkgICBkZWZ0eXBlX2hpKTsNCj4gKwltdHJyX3dybXNyKE1TUl9NVFJSZGVm
VHlwZSwgZGVmdHlwZV9sbyAmIE1UUlJfREVGX1RZUEVfRElTQUJMRSwgZGVmdHlwZV9oaSk7
DQo+ICAgfQ0KPiAgIA0KPiAgIHZvaWQgbXRycl9lbmFibGUodm9pZCkNCj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L210cnIvbXRyci5jDQo+IGluZGV4IGZkZGM0ZTBjNjYyNi4uMTA2N2YxMjhiZGVkIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jDQo+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMNCj4gQEAgLTYyNyw3ICs2MjcsNyBA
QCB2b2lkIF9faW5pdCBtdHJyX2JwX2luaXQodm9pZCkNCj4gICB7DQo+ICAgCWNvbnN0IGNo
YXIgKndoeSA9ICIobm90IGF2YWlsYWJsZSkiOw0KPiAgIA0KPiAtCW10cnJfc2V0X21hc2so
KTsNCj4gKwlwaHlzX2hpX3JzdmQgPSBHRU5NQVNLKDMxLCBib290X2NwdV9kYXRhLng4Nl9w
aHlzX2JpdHMgLSAzMik7DQo+ICAgDQo+ICAgCWlmIChjcHVfZmVhdHVyZV9lbmFibGVkKFg4
Nl9GRUFUVVJFX01UUlIpKSB7DQo+ICAgCQltdHJyX2lmID0gJmdlbmVyaWNfbXRycl9vcHM7
DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5oIGIvYXJj
aC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuaA0KPiBpbmRleCBhMDA5ODdlNmNjMWMuLjEw
MjhhMmI2Nzk2MSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210
cnIuaA0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5oDQo+IEBAIC01
OCw2ICs1OCw3IEBAIGV4dGVybiBjb25zdCBzdHJ1Y3QgbXRycl9vcHMgKm10cnJfaWY7DQo+
ICAgZXh0ZXJuIHVuc2lnbmVkIGludCBudW1fdmFyX3JhbmdlczsNCj4gICBleHRlcm4gdTY0
IG10cnJfdG9tMjsNCj4gICBleHRlcm4gc3RydWN0IG10cnJfc3RhdGVfdHlwZSBtdHJyX3N0
YXRlOw0KPiArZXh0ZXJuIHUzMiBwaHlzX2hpX3JzdmQ7DQo+ICAgDQo+ICAgdm9pZCBtdHJy
X3NldF9tYXNrKHZvaWQpOw0KDQpJIHRoaW5rIHlvdSB3YW50IHRvIGRlbGV0ZSB0aGlzXiBw
cm90b3R5cGUsIHRvby4NCg0KDQpKdWVyZ2VuDQo=
--------------WhJDzxcxJviq0ozkUOfwxJLO
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------WhJDzxcxJviq0ozkUOfwxJLO--

--------------ztv1pDeiDiOt0OZ8mnwSmzD9--

--------------bbnKjoME3Dm6MHP7a9cYxEOI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRY8lkFAwAAAAAACgkQsN6d1ii/Ey/k
/wf8CEff15y2CqOWm5WADIKWlTlAEdhmONNJFa7d63s//e502+B4D3hgdZLeJwRX8ietq7cxsIgt
pcRdm4pRFsDCttQvWXhMozXFbDLdj+FmPJOLyNSxoPjaIlPnqV6luhhj/RNpseWGCv6XlnQ/RSQq
hY1/7/Cktool7R00bmLb7baWqLuVHaEJQ+nqt3SYEVcuJtkaiup1oGx5/SnXYKZVWh7eES6CvdSQ
/iy70jmEbAlkxFIABQ0eXcFEgtOkHfa6G+AZ4obP2fCDlSXfEa7U34UFKl35dLIiVkz1EpimR5Td
8++LjMoTfd8IfkVODgjsSZqXn7uM4ATsR35UQ8uKLw==
=TZy6
-----END PGP SIGNATURE-----

--------------bbnKjoME3Dm6MHP7a9cYxEOI--
