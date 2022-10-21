Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FB9607E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJUSFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUSFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:05:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C665A25590
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:05:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8901B1F45F;
        Fri, 21 Oct 2022 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666375540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yH1J+xhsUXyai44goUnxmIZ59mJX5PZ0iX8mHcgORDI=;
        b=Z8LOK5wteB3k3huUv+Ox2jbB8hIUNKawsdyAOeIcAZkTT2jmiKkI3HBmWRxdnVGiENzpCC
        VUjHhpLJeIKWOZR++t8aJUP8pomqpmkZb9Q6ww8+QQ1W4SwEKAmKXSPynf+NIclDjRsaZQ
        CBGnRNHf9CSoJY6jD60R5KNkz5WWLfA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D5E51331A;
        Fri, 21 Oct 2022 18:05:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1rQkEXTfUmNACAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 21 Oct 2022 18:05:40 +0000
Message-ID: <7af80d1e-d658-5dee-32b3-a9976e900dc7@suse.com>
Date:   Fri, 21 Oct 2022 20:05:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 03/16] x86/mtrr: replace use_intel() with a local flag
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-4-jgross@suse.com> <Y1LUm1Vdu4u2Tp1c@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y1LUm1Vdu4u2Tp1c@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iC6hg0isZdlfYIvaQ4Dyq9zi"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------iC6hg0isZdlfYIvaQ4Dyq9zi
Content-Type: multipart/mixed; boundary="------------6peZeoMdb1wv2u0HUHH0ClKF";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <7af80d1e-d658-5dee-32b3-a9976e900dc7@suse.com>
Subject: Re: [PATCH v4 03/16] x86/mtrr: replace use_intel() with a local flag
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-4-jgross@suse.com> <Y1LUm1Vdu4u2Tp1c@zn.tnic>
In-Reply-To: <Y1LUm1Vdu4u2Tp1c@zn.tnic>

--------------6peZeoMdb1wv2u0HUHH0ClKF
Content-Type: multipart/mixed; boundary="------------co2ugNmso3n6lUsxasGCqOzf"

--------------co2ugNmso3n6lUsxasGCqOzf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMTAuMjIgMTk6MTksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMDQsIDIwMjIgYXQgMTA6MTA6MTBBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEluIE1UUlIgY29kZSB1c2VfaW50ZWwoKSBpcyBvbmx5IHVzZWQgaW4gb25lIHNvdXJj
ZSBmaWxlLCBhbmQgdGhlDQo+PiByZWxldmFudCB1c2VfaW50ZWxfaWYgbWVtYmVyIG9mIHN0
cnVjdCBtdHJyX29wcyBpcyBzZXQgb25seSBpbg0KPj4gZ2VuZXJpY19tdHJyX29wcy4NCj4+
DQo+PiBSZXBsYWNlIHVzZV9pbnRlbCgpIHdpdGggYSBzaW5nbGUgZmxhZyBpbiBjYWNoZWlu
Zm8uYywgd2hpY2ggY2FuIGJlIHNldA0KPj4gd2hlbiBhc3NpZ25pbmcgZ2VuZXJpY19tdHJy
X29wcyB0byBtdHJyX2lmLiBUaGlzIGFsbG93cyB0byBkcm9wDQo+PiB1c2VfaW50ZWxfaWYg
ZnJvbSBtdHJyX29wcywgd2hpbGUgcHJlcGFyaW5nIHRvIHN1cHBvcnQgUEFUIHdpdGhvdXQN
Cj4+IE1UUlIuIEFzIGFub3RoZXIgcHJlcGFyYXRpb24gZm9yIHRoZSBQQVQvTVRSUiBkZWNv
dXBsaW5nIHVzZSBhIGJpdCBmb3INCj4+IE1UUlIgY29udHJvbCBhbmQgb25lIGZvciBQQVQg
Y29udHJvbC4gRm9yIG5vdyBzZXQgYm90aCBiaXRzIHRvZ2V0aGVyLA0KPj4gdGhpcyBjYW4g
YmUgY2hhbmdlZCBsYXRlci4NCj4+DQo+PiBBcyB0aGUgbmV3IGZsYWcgd2lsbCBiZSBzZXQg
b25seSBpZiBtdHJyX2VuYWJsZWQgaXMgc2V0LCB0aGUgdGVzdCBmb3INCj4+IG10cnJfZW5h
YmxlZCBjYW4gYmUgZHJvcHBlZCBhdCBzb21lIHBsYWNlcy4NCj4+DQo+PiBBdCB0aGUgc2Ft
ZSB0aW1lIGRyb3AgdGhlIGxvY2FsIG10cnJfZW5hYmxlZCgpIGZ1bmN0aW9uIGFuZCByZW5h
bWUNCj4+IHRoZSBfX210cnJfZW5hYmxlZCBmbGFnIHRvIG10cnJfZW5hYmxlZC4NCj4gDQo+
IFNvLCBJIGtpbmRhIGxpa2UgeW91ciBpZGVhIGFib3V0ICJyZXBsYWNlIHRoZSBib29sIHdp
dGggbXRycl9pZiAhPSBOVUxMIg0KPiB0byB0ZXN0IHdoZXRoZXIgTVRSUnMgYXJlIGVuYWJs
ZWQuDQo+IA0KPiBJT1csIGhvdyBkb2VzIHRoaXMgbG9vayBvbnRvcCBvZiB5b3Vycz8NCj4g
DQo+IEF0IHRoZSBlbmQgb2YgbXRycl9icF9pbml0KCkgSSBuZWVkIHRvIGRvIHNvbWUgY2Fy
ZWZ1bCBkYW5jaW5nIGJ1dCBJDQo+IHRoaW5rIHRoaXMgd2F5IGl0IGlzIGV2ZW4gY2xlYXJl
ci4gSSdtIHByZXR0eSBzdXJlIGl0IGNhbiBiZSBzaW1wbGlmaWVkDQo+IGV2ZW4gbW9yZSBi
dXQgb25lIHRoaW5nIGF0IGEgdGltZS4uLg0KDQpQbGVhc2UgaGF2ZSBhIGxvb2sgYXQgcGF0
Y2ggMTAgKEkndmUgcHV0IGl0IGFmdGVyIHRoZSByZXdvcmsgb2YgbXRycl9icF9pbml0KCkN
CmV4YWN0bHkgaW4gb3JkZXIgdG8gYXZvaWQgdGhlIGRhbmNlIHlvdSBoYWQgdG8gZG8pLg0K
DQoNCkp1ZXJnZW4NCg0KPiANCj4gVGh4Lg0KPiANCj4gLS0tDQo+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9t
dHJyL210cnIuYw0KPiBpbmRleCBkYWNiNTM3ZGExMjYuLjkyN2I0NjNhMjJiZCAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPiArKysgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jDQo+IEBAIC01OSw3ICs1OSw2IEBADQo+ICAg
I2RlZmluZSBNVFJSX1RPX1BIWVNfV0NfT0ZGU0VUIDEwMDANCj4gICANCj4gICB1MzIgbnVt
X3Zhcl9yYW5nZXM7DQo+IC1zdGF0aWMgYm9vbCBtdHJyX2VuYWJsZWQ7DQo+ICAgDQo+ICAg
dW5zaWduZWQgaW50IG10cnJfdXNhZ2VfdGFibGVbTVRSUl9NQVhfVkFSX1JBTkdFU107DQo+
ICAgc3RhdGljIERFRklORV9NVVRFWChtdHJyX211dGV4KTsNCj4gQEAgLTcxLDE1ICs3MCwx
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10cnJfb3BzICptdHJyX29wc1tYODZfVkVORE9S
X05VTV0gX19yb19hZnRlcl9pbml0Ow0KPiAgIA0KPiAgIGNvbnN0IHN0cnVjdCBtdHJyX29w
cyAqbXRycl9pZjsNCj4gICANCj4gLXN0YXRpYyB2b2lkIHNldF9tdHJyKHVuc2lnbmVkIGlu
dCByZWcsIHVuc2lnbmVkIGxvbmcgYmFzZSwNCj4gLQkJICAgICB1bnNpZ25lZCBsb25nIHNp
emUsIG10cnJfdHlwZSB0eXBlKTsNCj4gLQ0KPiAgIHZvaWQgX19pbml0IHNldF9tdHJyX29w
cyhjb25zdCBzdHJ1Y3QgbXRycl9vcHMgKm9wcykNCj4gICB7DQo+ICAgCWlmIChvcHMtPnZl
bmRvciAmJiBvcHMtPnZlbmRvciA8IFg4Nl9WRU5ET1JfTlVNKQ0KPiAgIAkJbXRycl9vcHNb
b3BzLT52ZW5kb3JdID0gb3BzOw0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBib29sIG10cnJf
ZW5hYmxlZCh2b2lkKQ0KPiArew0KPiArCXJldHVybiAhIW10cnJfaWY7DQo+ICt9DQo+ICsN
Cj4gICAvKiAgUmV0dXJucyBub24temVybyBpZiB3ZSBoYXZlIHRoZSB3cml0ZS1jb21iaW5p
bmcgbWVtb3J5IHR5cGUgICovDQo+ICAgc3RhdGljIGludCBoYXZlX3dyY29tYih2b2lkKQ0K
PiAgIHsNCj4gQEAgLTI5OSw3ICszMDAsNyBAQCBpbnQgbXRycl9hZGRfcGFnZSh1bnNpZ25l
ZCBsb25nIGJhc2UsIHVuc2lnbmVkIGxvbmcgc2l6ZSwNCj4gICAJaW50IGksIHJlcGxhY2Us
IGVycm9yOw0KPiAgIAltdHJyX3R5cGUgbHR5cGU7DQo+ICAgDQo+IC0JaWYgKCFtdHJyX2Vu
YWJsZWQpDQo+ICsJaWYgKCFtdHJyX2VuYWJsZWQoKSkNCj4gICAJCXJldHVybiAtRU5YSU87
DQo+ICAgDQo+ICAgCWVycm9yID0gbXRycl9pZi0+dmFsaWRhdGVfYWRkX3BhZ2UoYmFzZSwg
c2l6ZSwgdHlwZSk7DQo+IEBAIC00NDcsNyArNDQ4LDcgQEAgc3RhdGljIGludCBtdHJyX2No
ZWNrKHVuc2lnbmVkIGxvbmcgYmFzZSwgdW5zaWduZWQgbG9uZyBzaXplKQ0KPiAgIGludCBt
dHJyX2FkZCh1bnNpZ25lZCBsb25nIGJhc2UsIHVuc2lnbmVkIGxvbmcgc2l6ZSwgdW5zaWdu
ZWQgaW50IHR5cGUsDQo+ICAgCSAgICAgYm9vbCBpbmNyZW1lbnQpDQo+ICAgew0KPiAtCWlm
ICghbXRycl9lbmFibGVkKQ0KPiArCWlmICghbXRycl9lbmFibGVkKCkpDQo+ICAgCQlyZXR1
cm4gLUVOT0RFVjsNCj4gICAJaWYgKG10cnJfY2hlY2soYmFzZSwgc2l6ZSkpDQo+ICAgCQly
ZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTQ3Niw3ICs0NzcsNyBAQCBpbnQgbXRycl9kZWxfcGFn
ZShpbnQgcmVnLCB1bnNpZ25lZCBsb25nIGJhc2UsIHVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4g
ICAJdW5zaWduZWQgbG9uZyBsYmFzZSwgbHNpemU7DQo+ICAgCWludCBlcnJvciA9IC1FSU5W
QUw7DQo+ICAgDQo+IC0JaWYgKCFtdHJyX2VuYWJsZWQpDQo+ICsJaWYgKCFtdHJyX2VuYWJs
ZWQoKSkNCj4gICAJCXJldHVybiAtRU5PREVWOw0KPiAgIA0KPiAgIAltYXggPSBudW1fdmFy
X3JhbmdlczsNCj4gQEAgLTUzNiw3ICs1MzcsNyBAQCBpbnQgbXRycl9kZWxfcGFnZShpbnQg
cmVnLCB1bnNpZ25lZCBsb25nIGJhc2UsIHVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4gICAgKi8N
Cj4gICBpbnQgbXRycl9kZWwoaW50IHJlZywgdW5zaWduZWQgbG9uZyBiYXNlLCB1bnNpZ25l
ZCBsb25nIHNpemUpDQo+ICAgew0KPiAtCWlmICghbXRycl9lbmFibGVkKQ0KPiArCWlmICgh
bXRycl9lbmFibGVkKCkpDQo+ICAgCQlyZXR1cm4gLUVOT0RFVjsNCj4gICAJaWYgKG10cnJf
Y2hlY2soYmFzZSwgc2l6ZSkpDQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTU2Miw3
ICs1NjMsNyBAQCBpbnQgYXJjaF9waHlzX3djX2FkZCh1bnNpZ25lZCBsb25nIGJhc2UsIHVu
c2lnbmVkIGxvbmcgc2l6ZSkNCj4gICB7DQo+ICAgCWludCByZXQ7DQo+ICAgDQo+IC0JaWYg
KHBhdF9lbmFibGVkKCkgfHwgIW10cnJfZW5hYmxlZCkNCj4gKwlpZiAocGF0X2VuYWJsZWQo
KSB8fCAhbXRycl9lbmFibGVkKCkpDQo+ICAgCQlyZXR1cm4gMDsgIC8qIFN1Y2Nlc3MhICAo
V2UgZG9uJ3QgbmVlZCB0byBkbyBhbnl0aGluZy4pICovDQo+ICAgDQo+ICAgCXJldCA9IG10
cnJfYWRkKGJhc2UsIHNpemUsIE1UUlJfVFlQRV9XUkNPTUIsIHRydWUpOw0KPiBAQCAtNzUw
LDE1ICs3NTEsMTggQEAgdm9pZCBfX2luaXQgbXRycl9icF9pbml0KHZvaWQpDQo+ICAgCQl9
DQo+ICAgCX0NCj4gICANCj4gLQlpZiAobXRycl9pZikgew0KPiAtCQltdHJyX2VuYWJsZWQg
PSB0cnVlOw0KPiAtCQlzZXRfbnVtX3Zhcl9yYW5nZXMobXRycl9pZiA9PSAmZ2VuZXJpY19t
dHJyX29wcyk7DQo+ICsJaWYgKG10cnJfZW5hYmxlZCgpKSB7DQo+ICsJCWJvb2wgdXNlX2dl
bmVyaWMgPSBtdHJyX2lmID09ICZnZW5lcmljX210cnJfb3BzOw0KPiArCQlib29sIG10cnJf
c3RhdGVfZW5hYmxlZCA9IHRydWU7DQo+ICsNCj4gKwkJc2V0X251bV92YXJfcmFuZ2VzKHVz
ZV9nZW5lcmljKTsNCj4gICAJCWluaXRfdGFibGUoKTsNCj4gLQkJaWYgKG10cnJfaWYgPT0g
JmdlbmVyaWNfbXRycl9vcHMpIHsNCj4gKw0KPiArCQlpZiAodXNlX2dlbmVyaWMpIHsNCj4g
ICAJCQkvKiBCSU9TIG1heSBvdmVycmlkZSAqLw0KPiAtCQkJbXRycl9lbmFibGVkID0gZ2V0
X210cnJfc3RhdGUoKTsNCj4gKwkJCW10cnJfc3RhdGVfZW5hYmxlZCA9IGdldF9tdHJyX3N0
YXRlKCk7DQo+ICAgDQo+IC0JCQlpZiAobXRycl9lbmFibGVkKSB7DQo+ICsJCQlpZiAobXRy
cl9zdGF0ZV9lbmFibGVkKSB7DQo+ICAgCQkJCW10cnJfYnBfcGF0X2luaXQoKTsNCj4gICAJ
CQkJbWVtb3J5X2NhY2hpbmdfY29udHJvbCB8PSBDQUNIRV9NVFJSIHwgQ0FDSEVfUEFUOw0K
PiAgIAkJCX0NCj4gQEAgLTc2NywxMCArNzcxLDEzIEBAIHZvaWQgX19pbml0IG10cnJfYnBf
aW5pdCh2b2lkKQ0KPiAgIAkJCQljaGFuZ2VkX2J5X210cnJfY2xlYW51cCA9IDE7DQo+ICAg
CQkJCW10cnJfaWYtPnNldF9hbGwoKTsNCj4gICAJCQl9DQo+ICsNCj4gKwkJCWlmICghbXRy
cl9zdGF0ZV9lbmFibGVkKQ0KPiArCQkJCW10cnJfaWYgPSBOVUxMOw0KPiAgIAkJfQ0KPiAg
IAl9DQo+ICAgDQo+IC0JaWYgKCFtdHJyX2VuYWJsZWQpIHsNCj4gKwlpZiAoIW10cnJfZW5h
YmxlZCgpKSB7DQo+ICAgCQlwcl9pbmZvKCJEaXNhYmxlZFxuIik7DQo+ICAgDQo+ICAgCQkv
Kg0KPiBAQCAtODExLDcgKzgxOCw3IEBAIHZvaWQgbXRycl9zYXZlX3N0YXRlKHZvaWQpDQo+
ICAgew0KPiAgIAlpbnQgZmlyc3RfY3B1Ow0KPiAgIA0KPiAtCWlmICghbXRycl9lbmFibGVk
KQ0KPiArCWlmICghbXRycl9lbmFibGVkKCkpDQo+ICAgCQlyZXR1cm47DQo+ICAgDQo+ICAg
CWZpcnN0X2NwdSA9IGNwdW1hc2tfZmlyc3QoY3B1X29ubGluZV9tYXNrKTsNCj4gQEAgLTg1
Niw3ICs4NjMsNyBAQCB2b2lkIG10cnJfYnBfcmVzdG9yZSh2b2lkKQ0KPiAgIA0KPiAgIHN0
YXRpYyBpbnQgX19pbml0IG10cnJfaW5pdF9maW5pYWxpemUodm9pZCkNCj4gICB7DQo+IC0J
aWYgKCFtdHJyX2VuYWJsZWQpDQo+ICsJaWYgKCFtdHJyX2VuYWJsZWQoKSkNCj4gICAJCXJl
dHVybiAwOw0KPiAgIA0KPiAgIAlpZiAobWVtb3J5X2NhY2hpbmdfY29udHJvbCAmIENBQ0hF
X01UUlIpIHsNCj4gDQoNCg==
--------------co2ugNmso3n6lUsxasGCqOzf
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------co2ugNmso3n6lUsxasGCqOzf--

--------------6peZeoMdb1wv2u0HUHH0ClKF--

--------------iC6hg0isZdlfYIvaQ4Dyq9zi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNS33MFAwAAAAAACgkQsN6d1ii/Ey/Z
jAf9EYuGhxTK/DeZ73rnCaBUNrYCBur2gceTuL7qeDdNd6RDMkO/K7jPTEySJAy02MV1rAnO9Z2S
O11n7rlOhOJ2S/P8wLUnOZ2vROHw7J3Q5X8WFmDTSUaJkN64UM48B/v3U6R4AM2+BlpfbddvARm2
nPjJP1sU5UXObyKg188j6VVdIPDlgjdRadAvkEcl0nYV4mB4p0pOtCuYuj7kfj/9aiO+7Zurxtlk
yms4Xqg0+KQOO1/oH6vLRinZCQFpxb6HE5pt9Nt73YIXx78EyvAAeP+L6cIP0Pwu8Y+fp9FM6EKP
B+RfWAu0pmp5xalvjT5gwe30vQU7JJNWXuRZidNI0w==
=Yi1s
-----END PGP SIGNATURE-----

--------------iC6hg0isZdlfYIvaQ4Dyq9zi--
